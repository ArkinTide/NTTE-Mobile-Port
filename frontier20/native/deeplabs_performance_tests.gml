function scrFRDeeplabsSpinCapture(_turret,_original,_base_only=false,_fog_probe=0) {
    var _w=view_width,_h=view_height,_surface=-1,_camera=-1,_buffer=-1,_success=false,
        _target=surface_get_target(),_world=matrix_get(matrix_world),_view=matrix_get(matrix_view),
        _projection=matrix_get(matrix_projection),_color=draw_get_color(),_alpha=draw_get_alpha(),_shader=shader_current();
    gpu_push_state();
    try {
        _surface=surface_create(_w,_h);_buffer=buffer_create(_w*_h*4,buffer_fixed,1);
        _camera=camera_create_view(view_xview,view_yview,_w,_h,0,noone,-1,-1,-1,-1);
        surface_set_target(_surface);camera_apply(_camera);matrix_set(matrix_world,matrix_build_identity());
        shader_reset();gpu_set_fog(false,0,0,0);gpu_set_blendmode(bm_normal);gpu_set_texfilter(false);
        draw_set_color(c_white);draw_set_alpha(1);draw_clear(make_color_rgb(38,59,67));
        // A patterned real background makes transparent/outline composites
        // observable, rather than comparing two all-transparent buffers.
        draw_set_color(make_color_rgb(83,118,105));
        for(var _yy=0;_yy<_h;_yy+=16) for(var _xx=0;_xx<_w;_xx+=16)
            if((_xx+_yy)%32==0) draw_rectangle(view_xview+_xx,view_yview+_yy,view_xview+_xx+7,view_yview+_yy+7,false);
        draw_set_color(c_white);
        if(_fog_probe>0) gpu_set_fog(1,c_red,0,0);
        if(_fog_probe==2) {
            // Deliberately retain red fog as a negative-control postcondition.
            draw_set_color(c_white);
        } else if(_base_only) {
            // Independent negative control: the same actual base/top, with
            // the whole gun scratch/composite intentionally omitted.
            with(_turret) {
                if(nexthurt>=scrFRSourceFrame()+4) gpu_set_fog(1,c_white,0,0);
                scrFRDrawSprite(spr_base,0,x,y);scrFRDrawSprite(spr_top,0,x,y);
                gpu_set_fog(0,0,0,0);
            }
        } else if(_original) {
            // The authored renderer only checks existence. Give that retained
            // independent oracle its actual full-view source scratch surface.
            var _vars=global.fr_module_vars[$ "area:deeplabs"];
            if(surface_exists(_vars.surfaceSpinTurret)) surface_free(_vars.surfaceSpinTurret);
            _vars.surfaceSpinTurret=-4;
            scrFRInvokeDraw(_turret,["area","deeplabs","SpinTurret_draw"],[]);
        } else scrFRInvokeDraw(_turret,_turret.on_draw,[]);
        if(_fog_probe>0) {
            // A white primitive exposes whether the renderer restored the
            // source's fog-disabled postcondition after an off-screen call.
            draw_set_color(c_white);
            draw_rectangle(view_xview+2,view_yview+2,view_xview+9,view_yview+9,false);
        }
        assert(real(surface_get_target())==real(_surface),"Spin Turret renderer lost its outer GPU target");
        surface_reset_target();buffer_get_surface(_buffer,_surface,0);_success=true;
        return {surface:_surface,pixels:_buffer,width:_w,height:_h};
    } finally {
        if(surface_get_target()==_surface) surface_reset_target();
        if(_target>=0 && surface_get_target()!=_target) surface_set_target(_target);
        if(_camera>=0) camera_destroy(_camera);
        matrix_set(matrix_world,_world);matrix_set(matrix_view,_view);matrix_set(matrix_projection,_projection);
        gpu_pop_state();if(_shader<0) shader_reset();else shader_set(_shader);
        draw_set_color(_color);draw_set_alpha(_alpha);
        if(!_success) {
            if(surface_exists(_surface)) surface_free(_surface);
            if(buffer_exists(_buffer)) buffer_delete(_buffer);
        }
    }
}

function scrFRDeeplabsScratchCoverage(_surface) {
    var _w=surface_get_width(_surface),_h=surface_get_height(_surface),
        _buffer=buffer_create(_w*_h*4,buffer_fixed,1),_coverage=0;
    try {
        buffer_get_surface(_buffer,_surface,0);
        for(var _offset=3;_offset<_w*_h*4;_offset+=4) {
            if(buffer_peek(_buffer,_offset,buffer_u8)>0) _coverage+=1;
        }
        return _coverage;
    } finally {buffer_delete(_buffer);}
}

function scrFRDeeplabsPerformanceTests() {
    assert(os_type==os_windows && scrNTTEFullSmokeEnabled() && scrFREnabled()
        && instance_exists(Player) && !instance_exists(GenCont),
        "Deeplabs regression requires the settled isolated NTUF desktop harness");
    var _before=scrNTTEFullInstances(all),_seed=random_get_seed(),_source_seed=scrFRSourceRandomGetSeed(),_vx=view_xview,_vy=view_yview,
        _vars=global.fr_module_vars[$ "area:deeplabs"],_old_scratch=_vars.surfaceSpinTurret,
        _turret=scrFRModCall("area","deeplabs","SpinTurret_create",710000,710000,2),
        _positions=[[.5,.5],[0,.5],[1,.5],[.5,0],[.5,1],[0,0]],
        _angles=[0,33,90,137.5],_checked=0,_original=undefined,_optimized=undefined,_base_only=undefined,_fog_control=undefined,
        _source_scratch_pixels=0,_local_scratch_pixels=0,
        _ai=_turret.on_step,_mask=_turret.mask_index,_health=_turret.hp,_fire=_turret.shootTime;
    _vars.surfaceSpinTurret=-4;
    try {
        assert(instance_exists(_turret)
            && scrFRScriptRef(_turret.on_draw)==scrFRScriptRef(scrFRDeeplabsSpinTurretDraw),
            "Actual Spin Turret factory did not select the local renderer");
        for(var _view_case=0;_view_case<2;++_view_case) {
            view_xview=710000+_view_case*.25;view_yview=710000+_view_case*.5;
            for(var _position=0;_position<array_length(_positions);++_position)
                for(var _angle=0;_angle<array_length(_angles);++_angle) {
                    _turret.x=view_xview+view_width*_positions[_position][0]+.25;
                    _turret.y=view_yview+view_height*_positions[_position][1]+.5;
                    _turret.drawAngle=_angles[_angle];
                    _turret.nexthurt=(_angle%2==0)?scrFRSourceFrame()+10:0;
                    _turret.image_blend=_view_case==0?c_white:make_color_rgb(175,201,227);
                    try {
                        _original=scrFRDeeplabsSpinCapture(_turret,true);
                        _source_scratch_pixels+=surface_get_width(_vars.surfaceSpinTurret)*surface_get_height(_vars.surfaceSpinTurret);
                        if(_checked==0) assert(scrFRDeeplabsScratchCoverage(_vars.surfaceSpinTurret)>16,
                            "Spin Turret original GPU oracle drew an empty gun scratch surface");
                        _optimized=scrFRDeeplabsSpinCapture(_turret,false);
                        _local_scratch_pixels+=surface_get_width(_vars.surfaceSpinTurret)*surface_get_height(_vars.surfaceSpinTurret);
                        if(_checked==0) {
                            assert(scrFRDeeplabsScratchCoverage(_vars.surfaceSpinTurret)>16,
                                "Spin Turret local GPU renderer drew an empty gun scratch surface");
                            _base_only=scrFRDeeplabsSpinCapture(_turret,false,true);
                            assert(!scrFRVisualSamePixels(_original,_base_only)
                                && !scrFRVisualSamePixels(_optimized,_base_only),
                                "Spin Turret GPU source/local comparison hid a missing gun composite");
                        }
                        if(!scrFRVisualSamePixels(_original,_optimized)) {
                            scrFRVisualSave(_original,"ntuf-spin-original-mismatch.png");
                            scrFRVisualSave(_optimized,"ntuf-spin-local-mismatch.png");
                            throw "Spin Turret GPU source/local mismatch view="+string(_view_case)
                                +" position="+string(_position)+" angle="+string(_angles[_angle]);
                        }
                        assert(surface_get_width(_vars.surfaceSpinTurret)<=100
                            && surface_get_height(_vars.surfaceSpinTurret)<=104,
                            "Spin Turret still allocates a full-view scratch surface");
                        if(_checked==0) scrFRVisualSave(_optimized,"ntuf-spin-local-render.png");
                        if(_checked==1) scrFRVisualSave(_optimized,"ntuf-spin-local-normal.png");
                    } finally {
                        scrFRVisualFree(_original);scrFRVisualFree(_optimized);scrFRVisualFree(_base_only);
                        _original=undefined;_optimized=undefined;_base_only=undefined;
                    }
                    ++_checked;
                }
        }
        // Culling may omit all turret geometry, but cannot omit the source
        // renderer's final fog reset. The red control proves the probe can
        // actually distinguish a missing reset rather than matching blanks.
        _turret.x=view_xview+view_width+256;_turret.y=view_yview+view_height/2;_turret.nexthurt=0;
        try {
            _original=scrFRDeeplabsSpinCapture(_turret,true,false,1);
            _optimized=scrFRDeeplabsSpinCapture(_turret,false,false,1);
            _fog_control=scrFRDeeplabsSpinCapture(_turret,false,false,2);
            assert(scrFRVisualSamePixels(_original,_optimized)
                && !scrFRVisualSamePixels(_optimized,_fog_control),
                "Off-screen Spin Turret changed the source fog postcondition or used a blank control");
            var _pixel=surface_getpixel_ext(_optimized.surface,4,4),
                _red_pixel=surface_getpixel_ext(_fog_control.surface,4,4);
            assert(color_get_red(_pixel)==255 && color_get_green(_pixel)==255 && color_get_blue(_pixel)==255
                && color_get_red(_red_pixel)==255 && color_get_green(_red_pixel)==0 && color_get_blue(_red_pixel)==0,
                "Spin Turret fog probe did not render the expected white and red GPU controls");
        } finally {
            scrFRVisualFree(_original);scrFRVisualFree(_optimized);scrFRVisualFree(_fog_control);
            _original=undefined;_optimized=undefined;_fog_control=undefined;
        }
        assert(_checked==48 && _turret.on_step==_ai && _turret.mask_index==_mask
            && _turret.hp==_health && _turret.shootTime==_fire,
            "Spin Turret draw changed its live collision, health, AI or attack state");
        scrNTTESmokeLog("PASS FRONTIER Deeplabs Spin Turret strict source/local GPU pixels: 48 rotation/hurt/tint/whole/fractional-view/edge cases; authored AI/projectiles intact; actual scratch pixels source="
            +string(_source_scratch_pixels)+" local="+string(_local_scratch_pixels)+" reduction="
            +string(100*(1-_local_scratch_pixels/_source_scratch_pixels))+"%; source/local each preserves 5 outline/body composites; off-screen fog reset matches source with visible red negative control");
    } finally {
        if(surface_exists(_vars.surfaceSpinTurret)) surface_free(_vars.surfaceSpinTurret);
        _vars.surfaceSpinTurret=_old_scratch;
        view_xview=_vx;view_yview=_vy;scrNTTEFullMergedRuntimeTestCleanup(_before);random_set_seed(_seed);scrFRSourceRandomSetSeed(_source_seed);
    }
}

function scrFRRobocenterWarningCapture(_warning,_source) {
    var _surface=-1,_camera=-1,_buffer=-1,_success=false,_target=surface_get_target(),
        _world=matrix_get(matrix_world),_view=matrix_get(matrix_view),_projection=matrix_get(matrix_projection),
        _color=draw_get_color(),_alpha=draw_get_alpha(),_shader=shader_current(),_sprite=_warning.sprite_index;
    gpu_push_state();
    try {
        _surface=surface_create(192,32);_buffer=buffer_create(192*32*4,buffer_fixed,1);
        _camera=camera_create_view(_warning.xstart-8,_warning.ystart-16,192,32,0,noone,-1,-1,-1,-1);
        surface_set_target(_surface);camera_apply(_camera);matrix_set(matrix_world,matrix_build_identity());
        shader_reset();gpu_set_fog(false,0,0,0);gpu_set_blendmode(bm_normal);gpu_set_texfilter(false);
        draw_set_color(c_white);draw_set_alpha(1);draw_clear_alpha(c_black,0);
        if(_source) {
            _warning.sprite_index=_warning.spr_idle;
            scrFRInvokeDraw(_warning,["area","robocenter","warning_draw"],[]);
        } else scrFRInvokeDraw(_warning,_warning.on_draw,[]);
        surface_reset_target();buffer_get_surface(_buffer,_surface,0);_success=true;
        return {surface:_surface,pixels:_buffer,width:192,height:32};
    } finally {
        _warning.sprite_index=_sprite;
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

// The retained original source binary_search/check_laser_style is the oracle.
// This tests authored masks in every trap direction against authored walls,
// compact exterior collision, broken walls and a completely unobstructed ray.
function scrFRRobocenterPerformanceTests() {
    assert(os_type==os_windows && scrNTTEFullSmokeEnabled() && scrFREnabled()
        && instance_exists(Player) && !instance_exists(GenCont),
        "Robocenter regression requires the settled isolated NTUF desktop harness");
    var _before=scrNTTEFullInstances(all),_seed=random_get_seed(),_source_seed=scrFRSourceRandomGetSeed(),
        _creator=instance_create(0,0,FRCustomObject),_captures=[],_checked=0,
        _oracle_us=0,_native_us=0,_angles=[0,90.014,180,270.014],
        _source_scan=["area","robocenter","binary_search"],
        _source_check=["area","robocenter","check_laser_style"];
    try {
        for(var _kind=0;_kind<2;++_kind) for(var _direction=0;_direction<4;++_direction) {
            var _x=650000+_kind*10000+_direction*2000,_y=650000,
                _angle=_angles[_direction],_wall_x=_x+lengthdir_x(160,_angle)-8,
                _wall_y=_y+lengthdir_y(160,_angle)-8,
                _wall=_kind==0?instance_create(_wall_x,_wall_y,Wall):scrNTTESolidWallBlock(_wall_x,_wall_y,64,64),
                _factory=_kind==0?"WarningBeam_create":"Beam_create",
                _beam=scrFRInvoke(_creator,["area","robocenter",_factory],[_x,_y,_angle]);
            assert(instance_exists(_beam),"Actual source Robocenter beam factory failed");
            var _actual_x=_beam.x,_actual_y=_beam.y,_actual_scale=_beam.image_xscale,
                _sprite=_beam.sprite_index,_mask=_beam.mask_index;
            if(_kind==0) {_beam.sprite_index=_beam.spr_idle;_beam.mask_index=mskLaser;}
            var _source_length=scrFRInvoke(_beam,_source_scan,[_source_check,500]);
            // binary_search returns the midpoint AFTER its last probe. The
            // actual authored factory then writes that returned value back to
            // x/y/scale. Do that same finalization before observing the oracle:
            // native instance coordinates have float storage, unlike a local
            // arithmetic expression at this deliberately distant fixture.
            with(_beam) {
                x=xstart+lengthdir_x(_source_length,image_angle);
                y=ystart+lengthdir_y(_source_length,image_angle);
                image_xscale=_source_length/2;
            }
            scrNTTESmokeLog("FRONTIER Robocenter scan compare "+json_stringify({kind:_kind,direction:_direction,
                actual_x:_actual_x,actual_y:_actual_y,actual_scale:_actual_scale,source_length:_source_length,
                xstart:_beam.xstart,ystart:_beam.ystart,angle:_beam.image_angle,
                source_x:_beam.x,source_y:_beam.y,source_scale:_beam.image_xscale,mask:_beam.mask_index}));
            assert(_source_length>64 && _source_length<500,
                "Robocenter positive control did not meet its authored/compact wall");
            assert(_actual_x==_beam.x && _actual_y==_beam.y && _actual_scale==_beam.image_xscale,
                "Optimized Robocenter beam changed the source endpoint or collision precision");
            // Repeated source/native queries exercise the same wall masks and
            // report a diagnostic; absolute timing is deliberately not a test.
            var _begin=get_timer();
            repeat(32) scrFRInvoke(_beam,_source_scan,[_source_check,500]);
            _oracle_us+=get_timer()-_begin;_begin=get_timer();
            repeat(32) with(_beam) scrFRRobocenterBeamLength(500);
            _native_us+=get_timer()-_begin;
            instance_destroy(_wall,false);
            var _source_clear=scrFRInvoke(_beam,_source_scan,[_source_check,500]),_native_clear=0;
            with(_beam) _native_clear=scrFRRobocenterBeamLength(500);
            assert(_source_clear==500 && _native_clear==500,
                "Robocenter scan cached an already-broken wall or shortened an empty ray");
            _beam.x=_actual_x;_beam.y=_actual_y;_beam.image_xscale=_actual_scale;
            _beam.sprite_index=_sprite;_beam.mask_index=_mask;
            if(_kind==0) {
                assert(_beam.sprite_index==-1 && _beam.mask_index==-1 && sprite_exists(_beam.spr_idle),
                    "Harmless warning retained a native long collision mask");
                if(_direction==0) {
                    var _actual=scrFRRobocenterWarningCapture(_beam,false),
                        _reference=scrFRRobocenterWarningCapture(_beam,true);
                    array_push(_captures,_actual);array_push(_captures,_reference);
                    assert(scrFRVisualSamePixels(_actual,_reference),
                        "Harmless warning optimization changed actual source sprite/bloom pixels");
                    scrFRVisualSave(_actual,"ntuf-robocenter-warning.png");
                }
            } else {
                assert(_beam.mask_index==scrFRModGet("area","robocenter","mskLaserTrapBeam")
                    && scrFRScriptRef(_beam.on_hit)==scrFRScriptRef(fr_Areas_robocenter_area_gml_Beam_hit),
                    "Real damaging beam lost its authored mask or hit callback");
            }
            instance_destroy(_beam,false);++_checked;
        }
        assert(_checked==8,"Robocenter scan fixture missed an authored direction/mask");
        scrNTTESmokeLog("PASS FRONTIER Robocenter exact source scan endpoints/empty ray/wall removal, warning GPU parity and damaging-beam mask; 256 queries source_us="
            +string(_oracle_us)+" native_us="+string(_native_us));
    } finally {
        for(var _i=0;_i<array_length(_captures);++_i) scrFRVisualFree(_captures[_i]);
        scrNTTEFullMergedRuntimeTestCleanup(_before);random_set_seed(_seed);scrFRSourceRandomSetSeed(_source_seed);
    }
}

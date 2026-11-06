// Native BackCont and freeze shadows share one fog-independent iOS presenter.
// RGB tint replaces source RGB; coverage and requested opacity stay separate.
function scrNTTEFullIOSShadowSourceTarget(_surface,_stage) {
    if(os_type!=os_ios) {surface_set_target(_surface);return true;}
    var _bound=scrNTTEFullIOSSurfaceTarget(_surface)
    scrNTTEFullIOSRenderTrace("native-shadow-source-"+_stage,{bound:_bound,
        width:surface_exists(_surface)?surface_get_width(_surface):-1,
        height:surface_exists(_surface)?surface_get_height(_surface):-1})
    if(!_bound) scrNTTEFullIOSRenderTrace("native-shadow-bind-failed-"+_stage,{surface:_surface})
    return _bound;
}
function scrNTTEFullIOSShadowPresent(_surface,_x,_y,_tint,_opacity,_compat=undefined,_shader_available=undefined) {
    if(!surface_exists(_surface)) return false;
    if(is_undefined(_compat)) _compat=(os_type==os_ios)
    if(!_compat) {
        // Preserve the established Android/desktop shadow pass exactly.
        draw_set_alpha(_opacity)
        gpu_set_fog(1,_tint,depth,depth+1)
        draw_surface(_surface,_x,_y)
        gpu_set_fog(0,0,0,0)
        draw_set_alpha(1)
        return true;
    }
    var _old_shader=shader_current(),_old_color=draw_get_color(),_old_alpha=draw_get_alpha(),_old_fog=gpu_get_fog(),
        _source=gpu_get_blendmode_src(),_dest=gpu_get_blendmode_dest(),
        _shader=shader_is_compiled(shNTTEFullCoastPresent),_neutral=-1,_camera=-1,
        _old_world=matrix_get(matrix_world),_old_view=matrix_get(matrix_view),
        _old_projection=matrix_get(matrix_projection),_active=false,_ready=true,_path="shader"
    if(!is_undefined(_shader_available)) _shader=_shader && _shader_available
    gpu_push_state()
    try {
        shader_reset();gpu_set_fog(false,0,0,0);gpu_set_colorwriteenable(true,true,true,true)
        gpu_set_ztestenable(false);gpu_set_zwriteenable(false);gpu_set_alphatestenable(false)
        draw_set_color(c_white);draw_set_alpha(1)
        var _draw=_surface
        if(!_shader && _tint!=c_black) {
            // Vertex tint cannot recolor black RGB. Copy only source alpha
            // onto white RGB, then tint the neutral texture without fog.
            _path="neutral-alpha-fallback"
            var _w=surface_get_width(_surface),_h=surface_get_height(_surface)
            _neutral=surface_create(_w,_h)
            if(surface_exists(_neutral)) {
                _camera=camera_create_view(0,0,_w,_h,0,noone,-1,-1,-1,-1)
                _active=scrNTTEFullIOSSurfaceTarget(_neutral)
                if(_active) {
                    camera_apply(_camera);matrix_set(matrix_world,matrix_build_identity())
                    draw_clear_alpha(c_white,0)
                    gpu_set_colorwriteenable(false,false,false,true)
                    gpu_set_blendmode_ext_sepalpha(bm_zero,bm_one,bm_one,bm_zero)
                    draw_surface_ext(_surface,0,0,1,1,0,c_white,1)
                    surface_reset_target();_active=false
                    matrix_set(matrix_world,_old_world);matrix_set(matrix_view,_old_view)
                    matrix_set(matrix_projection,_old_projection)
                    gpu_set_colorwriteenable(true,true,true,true)
                    _draw=_neutral
                } else _ready=false
            } else _ready=false
        } else if(!_shader) _path="black-vertex-fallback"
        if(_ready) {
            // Retain the caller's normal/additive RGB operation and use
            // source-over alpha so empty shadows cannot erase the scene.
            gpu_set_blendmode_ext_sepalpha(_source,_dest,bm_one,bm_inv_src_alpha)
            if(_shader) {
                shader_set(shNTTEFullCoastPresent)
                shader_set_uniform_f(shader_get_uniform(shNTTEFullCoastPresent,"waterTint"),
                    color_get_red(_tint)/255,color_get_green(_tint)/255,color_get_blue(_tint)/255,1)
            }
            draw_surface_ext(_draw,_x,_y,1,1,0,_shader?c_white:_tint,_opacity)
        } else {
            // Resource exhaustion still preserves true shadow coverage. A
            // nonblack tint cannot be exact in this path; record that fact.
            _path="allocation-failed-black-fallback"
            gpu_set_blendmode_ext_sepalpha(_source,_dest,bm_one,bm_inv_src_alpha)
            draw_surface_ext(_surface,_x,_y,1,1,0,_tint,_opacity)
        }
        if(scrNTTEFullIOSRenderTraceNeeded("native-shadow")) {
            try {
            var _width=surface_get_width(_surface),_height=surface_get_height(_surface),
                _points=[[0,0],[_width-1,0],[0,_height-1],[_width-1,_height-1],[_width div 2,_height div 2]],_pixels=[]
            for(var _i=0;_i<array_length(_points);++_i)
                array_push(_pixels,surface_getpixel_ext(_surface,_points[_i][0],_points[_i][1]))
            scrNTTEFullIOSRenderTrace("native-shadow",{path:_path,shader:_shader,
                width:_width,height:_height,source_points:_points,source_pixels_rgba:_pixels,
                tint:_tint,opacity:_opacity,colored_tint_exact:_ready})
            } catch(_read_error) {
                scrNTTEFullIOSRenderTrace("native-shadow",{path:_path,shader:_shader,pixel_read_error:string(_read_error)})
            }
        }
    }
    finally {
        if(_active) surface_reset_target()
        if(surface_exists(_neutral)) surface_free(_neutral)
        if(_camera>=0) camera_destroy(_camera)
        gpu_pop_state();gpu_set_fog(_old_fog)
        matrix_set(matrix_world,_old_world);matrix_set(matrix_view,_old_view)
        matrix_set(matrix_projection,_old_projection)
        if(_old_shader>=0) shader_set(_old_shader);else shader_reset()
        draw_set_color(_old_color);draw_set_alpha(_old_alpha)
    }
    return true;
}

function scrNTTEFullIOSShadowPixelCheck(_output,_source,_background,_background_alpha,_tint,_opacity,_additive,_label) {
    for(var _y=0;_y<16;++_y) for(var _x=0;_x<32;++_x) {
        var _src=surface_getpixel_ext(_source,_x,_y),_actual=surface_getpixel_ext(_output,_x,_y),
            _a=((_src>>24)&255)/255*_opacity,_dst=_additive?1:(1-_a),
            _r=clamp(color_get_red(_tint)*_a+color_get_red(_background)*_dst,0,255),
            _g=clamp(color_get_green(_tint)*_a+color_get_green(_background)*_dst,0,255),
            _b=clamp(color_get_blue(_tint)*_a+color_get_blue(_background)*_dst,0,255),
            _alpha=255*(_a+_background_alpha*(1-_a))
        assert(abs(color_get_red(_actual)-_r)<=3 && abs(color_get_green(_actual)-_g)<=3
            && abs(color_get_blue(_actual)-_b)<=3 && abs(((_actual>>24)&255)-_alpha)<=3,
            "iOS native shadow "+_label+" changed empty/real shadow RGB/alpha at "+string([_x,_y,_src,_actual,_r,_g,_b,_alpha]))
    }
}

function scrNTTEFullIOSShadowPresentTests() {
    var _state=scrNTTEFullCoastDrawState(),_source=-1,_output=-1,_camera=-1,_active=false,
        _back=instance_find(BackCont,0),_back_state=scrNTTEFullAreaGeneratorSnapshot(BackCont),
        _vx=view_xview,_vy=view_yview,_stop=lockstep_stop,_parked=scrNTTEFullInstances(Scorch),
        _fixture=scrNTTEFullValue(_back,"ntte_full_ios_shadow_fixture",undefined),
        _shader_fixture=scrNTTEFullValue(_back,"ntte_full_ios_shadow_shader_fixture",undefined)
    assert(instance_exists(_back),"Native shadow fixture requires the actual BackCont")
    for(var _i=0;_i<array_length(_parked);++_i) instance_deactivate_object(_parked[_i])
    gpu_push_state()
    try {
        _source=surface_create(32,16);_output=surface_create(32,16)
        _camera=camera_create_view(0,0,32,16,0,noone,-1,-1,-1,-1)
        surface_set_target(_source);_active=true;camera_apply(_camera)
        matrix_set(matrix_world,matrix_build_identity());shader_reset();gpu_set_fog(false,0,0,0)
        gpu_set_ztestenable(false);gpu_set_zwriteenable(false);gpu_set_alphatestenable(false)
        gpu_set_colorwriteenable(true,true,true,true);draw_set_color(c_black);draw_set_alpha(1)
        draw_clear_alpha(c_black,0)
        gpu_set_blendmode_ext_sepalpha(bm_one,bm_zero,bm_one,bm_zero)
        draw_rectangle(2,3,7,12,false)
        draw_set_alpha(0.5);draw_rectangle(10,3,14,12,false);draw_set_alpha(1)
        draw_sprite_ext(shd16,0,24,8,1,1,0,c_black,1)
        surface_reset_target();_active=false
        assert((surface_getpixel_ext(_source,0,0)>>24&255)==0 && (surface_getpixel_ext(_source,4,7)>>24&255)==255,
            "Native shadow source fixture lacks empty and actual opaque coverage")
        lockstep_stop=false;view_xview=0;view_yview=0
        _back.shad=_source;_back.ntte_full_ios_shadow_fixture=true
        var _background=make_color_rgb(43,117,181),_tints=[c_black,make_color_rgb(19,71,43),make_color_rgb(170,80,130)]
        for(var _fallback=0;_fallback<2;++_fallback) for(var _t=0;_t<array_length(_tints);++_t)
        for(var _mode=0;_mode<3;++_mode) {
            // Mode0 invokes actual BackCont.Draw; mode1 mirrors Freeze's
            // additive0.3 pass; mode2 verifies fractional destination alpha.
            var _additive=(_mode==1),_opacity=_additive?0.3:0.4,_ba=(_mode==2)?0.25:1,
                _before_color=c_aqua,_before_alpha=0.37
            surface_set_target(_output);_active=true;camera_apply(_camera)
            shader_reset();gpu_set_fog(false,0,0,0);gpu_set_colorwriteenable(true,true,true,true)
            gpu_set_ztestenable(false);gpu_set_zwriteenable(false);gpu_set_alphatestenable(false)
            draw_clear_alpha(_background,_ba)
            gpu_set_blendmode(_additive?bm_add:bm_normal)
            shader_set(shNTTEFullCoastPresent)
            shader_set_uniform_f(shader_get_uniform(shNTTEFullCoastPresent,"waterTint"),1,0,1,1)
            gpu_set_fog(true,c_fuchsia,0,0)
            draw_set_color(_before_color);draw_set_alpha(_before_alpha)
            // Native draw alpha may use float/packed storage. Compare the
            // getter snapshot, rather than the unsnapped decimal requested.
            _before_color=draw_get_color();_before_alpha=draw_get_alpha()
            var _fog=gpu_get_fog(),_blend=string(gpu_get_blendmode()),_shader=shader_current()
            _back.shadow_color=_tints[_t];_back.ntte_full_ios_shadow_shader_fixture=(_fallback==0)
            if(_mode==0) with(_back) event_perform(ev_draw,0)
            else scrNTTEFullIOSShadowPresent(_source,0,0,_tints[_t],_opacity,true,_fallback==0)
            var _after_fog=gpu_get_fog(),_fog_matches=array_length(_after_fog)==array_length(_fog)
            for(var _f=0;_f<min(array_length(_fog),array_length(_after_fog));++_f)
                if(_fog[_f]!=_after_fog[_f]) _fog_matches=false
            var _checks=[real(surface_get_target())==real(_output),shader_current()==_shader,
                draw_get_color()==_before_color,draw_get_alpha()==_before_alpha,
                string(gpu_get_blendmode())==_blend,_fog_matches]
            assert(_checks[0] && _checks[1] && _checks[2] && _checks[3] && _checks[4] && _checks[5],
                "iOS native shadow helper/event leaked caller state "+json_stringify({
                    test:[_mode,_fallback,_t],checks:_checks,
                    before:{target:real(_output),shader:_shader,color:_before_color,alpha:_before_alpha,fog:_fog,blend:_blend},
                    after:{target:real(surface_get_target()),shader:shader_current(),color:draw_get_color(),
                        alpha:draw_get_alpha(),fog:_after_fog,blend:string(gpu_get_blendmode())}}))
            surface_reset_target();_active=false
            scrNTTEFullIOSShadowPixelCheck(_output,_source,_background,_ba,_tints[_t],_opacity,_additive,
                string([_mode,_fallback,_t]))
        }
    }
    finally {
        if(_active) surface_reset_target()
        scrNTTEFullAreaGeneratorRestore(_back_state)
        _back.ntte_full_ios_shadow_fixture=_fixture;_back.ntte_full_ios_shadow_shader_fixture=_shader_fixture
        if(surface_exists(_source)) surface_free(_source)
        if(surface_exists(_output)) surface_free(_output)
        if(_camera>=0) camera_destroy(_camera)
        for(var _i=0;_i<array_length(_parked);++_i) instance_activate_object(_parked[_i])
        view_xview=_vx;view_yview=_vy;lockstep_stop=_stop
        gpu_pop_state();matrix_set(matrix_world,_state.world);matrix_set(matrix_view,_state.view)
        matrix_set(matrix_projection,_state.projection)
        if(_state.shader>=0) shader_set(_state.shader);else shader_reset()
        draw_set_color(_state.color);draw_set_alpha(_state.alpha)
    }
    scrNTTESmokeLog("IOS NATIVE SHADOW actual BackCont.Draw + freeze additive0.3, empty/fractional/real sprite alpha, black/colored tint, forced shader fallback and caller state OK @"+string(30/timescale))
}

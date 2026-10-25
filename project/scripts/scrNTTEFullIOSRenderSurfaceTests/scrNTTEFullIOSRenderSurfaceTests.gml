function scrNTTEFullIOSRenderSurfaceTests() {
    var _before=scrNTTEFullInstances(all),_game=scrNTTEFullAreaGeneratorSnapshot(GameCont),
        _state=scrNTTEFullCoastDrawState(),_vx=view_xview,_vy=view_yview,_seed=random_get_seed(),
        _quality=UberCont.opt_scaling,_minor=variable_global_exists("ntte_full_minor_quality") ? global.ntte_full_minor_quality:undefined,
        _parked=scrNTTEFullInstances([Floor,Wall,TopSmall,GenCont,NTTEFullCoastSea,NTTEFullCoastSeaTop,NTTEFullCoastSeaVisible]),
        _output=-1,_camera=-1
    for(var _i=0;_i<array_length(_parked);++_i) instance_deactivate_object(_parked[_i])
    gpu_push_state()
    try {
        // Phone-size source quality: this requests caches above5000px. The
        // legacy path keeps that quality; iOS bounds each real framebuffer.
        var _native_scale=2532/520,_bounded=scrNTTEFullIOSSurfaceScale(1104,544,_native_scale,true)
        assert(ceil(1104*_bounded)<=2048 && ceil(544*_bounded)<=2048
            && scrNTTEFullIOSSurfaceScale(1104,544,_native_scale,false)==_native_scale,
            "iOS surface limit changed legacy quality or left a >2048 framebuffer")
        GameCont.area=scrNTTEFullAreaId("coast");GameCont.subarea=1;GameCont.ntte_full_active_coast=true
        GameCont.ntte_sea_inst=[];view_xview=42000;view_yview=42000;UberCont.opt_scaling=4
        global.ntte_full_minor_quality=6.5
        var _sea=scrNTTEFullCoastSeaEnsure()
        _sea.ntte_coast_opaque_output=true
        for(var _dx=0;_dx<3;++_dx) for(var _dy=0;_dy<3;++_dy) instance_create(42000+32*_dx,42000+32*_dy,Floor)
        _output=surface_create(view_width,view_height)
        _camera=camera_create_view(view_xview,view_yview,view_width,view_height,0,noone,-1,-1,-1,-1)
        assert(scrNTTEFullIOSSurfaceTarget(_output),"Surface test caller target bind failed")
        camera_apply(_camera);draw_clear_alpha(c_fuchsia,1)
        var _target=surface_get_target()
        assert(!scrNTTEFullIOSSurfaceTarget(-1) && real(surface_get_target())==real(_target),
            "Rejected target bind changed caller framebuffer")
        with(_sea) event_perform(ev_draw,0)
        assert(_sea.ntte_coast_draw_ready && !_sea.ntte_coast_frame_fallback,
            "Bounded actual Coast frame failed to render")
        for(var _i=0;_i<8;++_i) {
            var _s=_sea.ntte_coast_surfaces[_i]
            assert(surface_get_width(_s.surf)<=2048 && surface_get_height(_s.surf)<=2048,
                "Actual Coast allocation exceeded compatibility limit: "+string(_i))
            assert(abs(surface_get_width(_s.surf)-ceil(_s.w*_s.scale))<=1,
                "Coast actual reciprocal draw scale differs from framebuffer dimensions")
        }
        var _crab=instance_create(42140,42050,NTTEFullTrafficCrab)
        _crab.wading=12;_crab.visible=false;GameCont.ntte_sea_inst=[_crab]
        _sea.ntte_coast_fixture_reject_target=true
        draw_clear_alpha(c_fuchsia,1)
        with(_sea) event_perform(ev_draw,0)
        var _deep=surface_getpixel(_output,view_width-8,view_height-8)
        assert(_sea.ntte_coast_frame_fallback && !_sea.ntte_coast_draw_ready
            && real(surface_get_target())==real(_output) && !_sea.ntte_coast_target_active
            && _crab.visible && _sea.ntte_coast_safe_factor==0.5,
            "Failed Coast bind concealed native actors, popped caller or skipped smaller retry")
        assert(color_get_red(_deep)>=25 && color_get_green(_deep)>=100 && color_get_blue(_deep)>=160,
            "Rejected Coast target black-cleared the actual parent water")
        GameCont.ntte_sea_inst=[]
        with(_sea) event_perform(ev_draw,0)
        assert(_sea.ntte_coast_draw_ready && !_sea.ntte_coast_frame_fallback
            && real(surface_get_target())==real(_output),"Coast did not recover on next smaller-cache frame")
        with(_sea) for(var _i=0;_i<8;++_i) surface_free(ntte_coast_surfaces[_i].surf)
        with(_sea) event_perform(ev_draw,0)
        assert(_sea.ntte_coast_draw_ready,"Coast background/resume lost bounded cache recreation")
    } finally {
        for(var _i=0;_i<16 && real(surface_get_target())!=real(_state.target);++_i) surface_reset_target()
        scrNTTEFullMergedRuntimeTestCleanup(_before)
        if(surface_exists(_output)) surface_free(_output)
        if(_camera>=0) camera_destroy(_camera)
        scrNTTEFullAreaGeneratorRestore(_game)
        for(var _i=0;_i<array_length(_parked);++_i) instance_activate_object(_parked[_i])
        view_xview=_vx;view_yview=_vy;UberCont.opt_scaling=_quality;global.ntte_full_minor_quality=_minor;random_set_seed(_seed)
        gpu_pop_state();matrix_set(matrix_world,_state.world);matrix_set(matrix_view,_state.view);matrix_set(matrix_projection,_state.projection)
        if(_state.shader>=0) shader_set(_state.shader);else shader_reset()
        draw_set_color(_state.color);draw_set_alpha(_state.alpha)
    }
    scrNTTESmokeLog("IOS SURFACE BOUNDS: actual eight Coast targets/phone-scale>5000 request/bind rejection parent protection/direct shore safe-frame/native visibility/next-frame smaller recovery/resume OK @"+string(30/timescale))
}

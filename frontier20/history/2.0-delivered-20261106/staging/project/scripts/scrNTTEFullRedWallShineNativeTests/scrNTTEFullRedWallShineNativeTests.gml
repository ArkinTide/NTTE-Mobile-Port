function scrNTTEFullRedWallShineNativeTests() {
    var _before=scrNTTEFullInstances(all),_game=scrNTTEFullAreaGeneratorSnapshot(GameCont),
        _players=scrNTTEFullAreaGeneratorSnapshot(Player),_back=scrNTTEFullAreaGeneratorSnapshot(BackCont),
        _old_controllers=scrNTTEFullInstances(NTTEFullRedWallShine),
        _source=scrNTTEFullSourceSeedState(),_seed=random_get_seed(),
        _quality=variable_global_exists("ntte_full_minor_quality")?global.ntte_full_minor_quality:undefined,
        _vx=view_xview,_vy=view_yview,_vw=view_width,_vh=view_height,
        _surface=-1,_camera=-1,_world=matrix_get(matrix_world),_view=matrix_get(matrix_view),_projection=matrix_get(matrix_projection),
        _color=draw_get_color(),_alpha=draw_get_alpha(),_fog=gpu_get_fog(),
        _bg=__background_get_colour_element(),_bgcolor=layer_background_get_blend(_bg[0])
    GameCont.ntte_full_source_seed=scrNTTEFullSourceSeedCopy(_source)
    // This mask-pixel oracle addresses unit-resolution texture coordinates;
    // option-driven resizing is covered by QualityConsumersNativeDrawTests.
    global.ntte_full_minor_quality=1
    try {
        for(var _i=0;_i<array_length(_old_controllers);++_i) instance_deactivate_object(_old_controllers[_i])
        GameCont.area=206;view_xview=128000;view_yview=128000;view_width=128;view_height=128
        // Desktop smoke setup creates BackCont only; create the real native
        // TopCont factory so the actual SubTopCont draw dispatcher exists.
        if(!instance_exists(SubTopCont)) instance_create(0,0,TopCont)
        var _wall=instance_create(128032,128056,Wall),_controller=instance_find(NTTEFullRedWallShine,0)
        assert(instance_exists(_controller),"Actual Wall constructor omitted shared source WallShine controller")
        _wall.topspr=scrNTTERefSprite("WallRedTop");_wall.topindex=0;_wall.image_speed=0
        var _top=instance_create(128088,128056,TopSmall)
        _top.sprite_index=scrNTTERefSprite("WallRedTrans");_top.image_index=0
        with(_controller) event_perform(ev_step,ev_step_end)
        assert(_controller.visible && array_get_index(_controller.ntte_shine_walls,_wall)>=0
            && array_get_index(_controller.ntte_shine_tops,_top)>=0,
            "Actual WallShine EndStep lost Red wall/top source cache")
        _surface=surface_create(128,128);_camera=camera_create_view(128000,128000,128,128,0,noone,-1,-1,-1,-1)
        surface_set_target(_surface);camera_apply(_camera);draw_clear_alpha(c_black,0)
        layer_background_blend(_bg[0],c_black)
        _controller.ntte_shine_wave=6.5
        with(SubTopCont) event_perform(ev_draw,0)
        assert(surface_exists(_controller.ntte_shine_mask) && surface_exists(_controller.ntte_shine_surface),
            "Actual SubTopCont draw did not execute source mask/sweep")
        assert(surface_get_target()==_surface,"Actual source mask/sweep lost its caller surface target")
        var _opaque=0,_shine=0,_outside=0
        for(var _x=0;_x<128;_x+=2) for(var _y=0;_y<128;_y+=2) {
            var _mask=surface_getpixel_ext(_controller.ntte_shine_mask,_x,_y),
                _sweep=surface_getpixel_ext(_controller.ntte_shine_surface,_x,_y),
                _ma=(int64(_mask)>>24)&255,_sa=(int64(_sweep)>>24)&255
            if(_ma>0) {_opaque+=1}
            if((_sweep&$ffffff)!=0 && _sa>0) {_shine+=1}
            if(_ma==0 && _sa!=0) {_outside+=1}
        }
        assert(_opaque>5 && _shine>0 && _outside==0,
            "Source WallShine RGB-only sweep failed visible top mask or painted outside its alpha")
        // Source Red background starts fully opaque and cuts actual Floor art
        // before adding crystal silhouettes back. Empty area stays opaque.
        var _floor=instance_create(128096,128096,Floor)
        _floor.sprite_index=scrNTTERefSprite("FloorRed");_floor.image_index=0;_floor.image_speed=0
        layer_background_blend(_bg[0],make_color_rgb(235,0,67));_controller.ntte_shine_reset=true
        with(_controller) scrNTTEFullRedWallShineDraw()
        var _empty=(int64(surface_getpixel_ext(_controller.ntte_shine_mask,8,8))>>24)&255,
            _cut=0
        for(var _x=96;_x<128;++_x) for(var _y=96;_y<128;++_y)
            if(((int64(surface_getpixel_ext(_controller.ntte_shine_mask,_x,_y))>>24)&255)==0) {_cut+=1}
        assert(_empty==255 && _cut>100,"Source Red background floor cutout failed opaque void/transparent floor")
        // Idle sweep advances its clock but adds no pixels to caller.
        draw_clear_alpha(c_black,0);_controller.ntte_shine_wave=100
        var _wave=_controller.ntte_shine_wave
        with(_controller) scrNTTEFullRedWallShineDraw()
        assert(_controller.ntte_shine_wave>_wave
            && ((int64(surface_getpixel_ext(_surface,8,8))>>24)&255)==0,
            "Source WallShine240logical interval must advance while omitting composition")
        surface_free(_controller.ntte_shine_mask);_controller.ntte_shine_mask=-1
        with(_controller) scrNTTEFullRedWallShineDraw()
        assert(surface_exists(_controller.ntte_shine_mask),"Source mask did not recover actual surface loss")
        instance_destroy(_top,false)
        with(_controller) event_perform(ev_step,ev_step_end)
        assert(!_controller.ntte_shine_reset,"Source count-only cache unexpectedly invalidated on TopSmall-only deletion")
        // Forced mask rebuild trims dead cached references, like source _ne.
        _controller.ntte_shine_reset=true
        with(_controller) scrNTTEFullRedWallShineDraw()
        assert(array_get_index(_controller.ntte_shine_tops,_top)<0,"Source top mask retained a destroyed cached instance")
        var _mask=_controller.ntte_shine_mask,_shine=_controller.ntte_shine_surface
        with(_controller) event_perform(12,0)
        assert(!surface_exists(_mask) && !surface_exists(_shine),"Actual controller CleanUp leaked mask/shine surfaces")
        surface_reset_target()
    }
    finally {
        global.ntte_full_minor_quality=_quality
        if(_surface>=0 && surface_get_target()==_surface) surface_reset_target()
        if(surface_exists(_surface)) surface_free(_surface)
        if(_camera>=0) camera_destroy(_camera)
        layer_background_blend(_bg[0],_bgcolor)
        matrix_set(matrix_world,_world);matrix_set(matrix_view,_view);matrix_set(matrix_projection,_projection)
        draw_set_color(_color);draw_set_alpha(_alpha);gpu_set_fog(_fog)
        gpu_set_colorwriteenable(true,true,true,true);gpu_set_blendmode(bm_normal)
        scrNTTEFullMergedRuntimeTestCleanup(_before)
        scrNTTEFullAreaGeneratorRestore(_game);scrNTTEFullAreaGeneratorRestore(_players)
        scrNTTEFullAreaGeneratorRestore(_back)
        for(var _i=0;_i<array_length(_old_controllers);++_i) instance_activate_object(_old_controllers[_i])
        GameCont.ntte_full_source_seed=_source;random_set_seed(_seed)
        view_xview=_vx;view_yview=_vy;view_width=_vw;view_height=_vh
    }
    scrNTTESmokeLog("FULL RED WALL SHINE: actual Wall/TopSmall constructors/source count cache/actual SubTopCont final draw/mask geometry/RGB-only diagonal stripe/outside alpha clipping/Red void and floor cutout/idle interval/surface loss/dead top trim/actual CleanUp OK @"+string(30/timescale))
}

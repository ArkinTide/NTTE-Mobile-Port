function scrNTTEFullTopShadowTestAlpha(_surface,_x,_y) {
    return (int64(surface_getpixel_ext(_surface,_x,_y))>>24)&255
}
function scrNTTEFullTopShadowNativeDrawTests() {
    var _before=scrNTTEFullInstances(all),_game=scrNTTEFullAreaGeneratorSnapshot(GameCont),
        _players=scrNTTEFullAreaGeneratorSnapshot(Player),_uber=scrNTTEFullAreaGeneratorSnapshot(UberCont),
        _state=scrNTTEFullCoastDrawState(),_seed=random_get_seed(),
        _vx=view_xview,_vy=view_yview,_vw=view_width,_vh=view_height,
        _override=variable_global_exists("ntte_full_minor_quality")?global.ntte_full_minor_quality:undefined,
        _parked=scrNTTEFullInstances([Floor,Wall,TopSmall,TopPot,GenCont,NothingSpiral,NTTEFullTopShadow,
            NTTEFullTopObject,NTTEFullMortarPlasma,NTTEFullBigPipe]),
        _output=-1,_solid=-1,_camera=-1,_sprites=[]
    for(var _i=0;_i<array_length(_parked);++_i) instance_deactivate_object(_parked[_i])
    gpu_push_state()
    try {
        GameCont.area=area_desert;GameCont.loops=0;GameCont.hard=0
        view_xview=0;view_yview=0;view_width=128;view_height=128;global.ntte_full_minor_quality=1
        _output=surface_create(128,128);_solid=surface_create(32,32)
        surface_set_target(_solid);draw_clear_alpha(c_white,1);surface_reset_target()
        var _spr32=sprite_create_from_surface(_solid,0,0,32,32,false,false,0,0),
            _spr16=sprite_create_from_surface(_solid,0,0,16,16,false,false,0,0)
        _sprites=[_spr32,_spr16]
        _camera=camera_create_view(0,0,128,128,0,noone,-1,-1,-1,-1)
        surface_set_target(_output);camera_apply(_camera);draw_clear_alpha(c_black,0)
        scrNTTEFullTopShadowEnsure()
        var _shadow=instance_find(NTTEFullTopShadow,0),_top=instance_create(48,48,NTTEFullTopObject)
        _top.x=48;_top.y=56;_top.z=8;_top.visible=true;_top.spr_shadow=_spr32;_top.spr_shadow_x=0;_top.spr_shadow_y=0
        draw_set_color(c_aqua);draw_set_alpha(0.7)
        var _draw_state=scrNTTEFullCoastDrawState()
        with(_shadow) scrNTTEFullTopShadowDraw()
        scrNTTEFullQualityConsumerState(_output,"TopShadow unmasked TopObject",_draw_state)
        assert(scrNTTEFullTopShadowTestAlpha(_shadow.ntte_top_shadow_surface,64,64)>250,
            "Original TopObject z>=8 shadow lost y-8 offset or actual opaque sprite")
        // Actual Floor at y56 appears at y48 in source's camera(y+8).
        var _floor=instance_create(48,56,Floor)
        _floor.sprite_index=_spr32;_floor.image_index=0;_floor.image_speed=0
        with(_shadow) scrNTTEFullTopShadowDraw()
        assert(scrNTTEFullTopShadowTestAlpha(_shadow.ntte_top_shadow_mask,64,64)>250
            && scrNTTEFullTopShadowTestAlpha(_shadow.ntte_top_shadow_surface,64,64)==0,
            "Original TopShadow actual shifted-floor mask failed to erase floor-facing shadow")
        var _wall=instance_create(56,56,Wall)
        _wall.outspr=_spr16;_wall.outindex=0
        with(_shadow) scrNTTEFullTopShadowDraw()
        assert(scrNTTEFullTopShadowTestAlpha(_shadow.ntte_top_shadow_mask,64,64)==0
            && scrNTTEFullTopShadowTestAlpha(_shadow.ntte_top_shadow_surface,64,64)>250,
            "Original TopShadow wall silhouette failed to cut floor mask and expose top shadow")
        // The exact source's noeligible-instance guard leaves the cached
        // texture available but must omit composition on this caller frame.
        _top.z=7;draw_clear_alpha(c_black,0)
        with(_shadow) scrNTTEFullTopShadowDraw()
        assert(scrNTTEFullTopShadowTestAlpha(_output,64,64)==0,"TopShadow drew grounded z7 wrapper")
        _top.z=8;_top.visible=false
        with(_shadow) scrNTTEFullTopShadowDraw()
        assert(scrNTTEFullTopShadowTestAlpha(_output,64,64)==0,"TopShadow drew invisible wrapper")
        var _plasma=instance_create(64,72,NTTEFullMortarPlasma)
        assert(_plasma.spr_shadow!=-1,"MortarPlasma constructor must expose its original procedural shadow")
        _plasma.z=104;_plasma.visible=true
        with(_shadow) scrNTTEFullTopShadowDraw()
        assert(scrNTTEFullTopShadowTestAlpha(_shadow.ntte_top_shadow_surface,64,64)>0,
            "TopShadow lost actual source MortarPlasma height-scaled ellipse at y-8")
        _plasma.z=8
        with(_shadow) scrNTTEFullTopShadowDraw()
        assert(scrNTTEFullTopShadowTestAlpha(_shadow.ntte_top_shadow_surface,64,64)>0,
            "TopShadow source z8 plasma endpoint failed saturated ellipse")
        _plasma.z=7;draw_clear_alpha(c_black,0)
        with(_shadow) scrNTTEFullTopShadowDraw()
        assert(scrNTTEFullTopShadowTestAlpha(_output,64,64)==0,"TopShadow drew grounded MortarPlasma")
        var _pipe=instance_create(96,96,NTTEFullBigPipe)
        _pipe.spr_top_idle=_spr16;_pipe.image_index=0;_pipe.image_xscale=1;_pipe.image_yscale=1
        _pipe.image_angle=0;_pipe.spr_shadow_x=0;_pipe.spr_shadow_y=0;_pipe.visible=true
        with(_shadow) scrNTTEFullTopShadowDraw()
        assert(scrNTTEFullTopShadowTestAlpha(_shadow.ntte_top_shadow_surface,100,100)>0,
            "TopShadow lost real BigPipe top sprite without height gate")
        var _spiral=instance_create(0,0,NothingSpiral)
        draw_clear_alpha(c_black,0)
        with(_shadow) scrNTTEFullTopShadowDraw()
        assert(scrNTTEFullTopShadowTestAlpha(_output,100,100)==0,"TopShadow drew during original NothingSpiral exclusion")
        instance_destroy(_spiral,false)
        for(var _pass=0;_pass<2;++_pass) {
            global.ntte_full_minor_quality=_pass==0?1.25:5.25
            with(_shadow) scrNTTEFullTopShadowDraw()
            var _scale=global.ntte_full_minor_quality
            assert(surface_get_width(_shadow.ntte_top_shadow_mask)==scrNTTEFullQualitySurfaceSize(256,_scale)
                && surface_get_width(_shadow.ntte_top_shadow_surface)==scrNTTEFullQualitySurfaceSize(128,_scale),
                "TopShadow mask/composite missed independent fractional/no-cap minor quality resize")
            scrNTTEFullQualityConsumerState(_output,"TopShadow fractional resize",_draw_state)
        }
        var _mask=_shadow.ntte_top_shadow_mask,_surface=_shadow.ntte_top_shadow_surface
        instance_destroy(_shadow)
        assert(!surface_exists(_mask) && !surface_exists(_surface),"TopShadow actual cleanup leaked real mask/composite surfaces")
    }
    finally {
        for(var _i=0;_i<16 && real(surface_get_target())!=real(_state.target);++_i) surface_reset_target()
        scrNTTEFullMergedRuntimeTestCleanup(_before)
        if(surface_exists(_output)) surface_free(_output)
        if(surface_exists(_solid)) surface_free(_solid)
        if(_camera>=0) camera_destroy(_camera)
        for(var _i=0;_i<array_length(_sprites);++_i) if(sprite_exists(_sprites[_i])) sprite_delete(_sprites[_i])
        for(var _i=0;_i<array_length(_parked);++_i) instance_activate_object(_parked[_i])
        scrNTTEFullAreaGeneratorRestore(_game);scrNTTEFullAreaGeneratorRestore(_players);scrNTTEFullAreaGeneratorRestore(_uber)
        view_xview=_vx;view_yview=_vy;view_width=_vw;view_height=_vh;global.ntte_full_minor_quality=_override;random_set_seed(_seed)
        gpu_pop_state();matrix_set(matrix_world,_state.world);matrix_set(matrix_view,_state.view);matrix_set(matrix_projection,_state.projection)
        draw_set_color(_state.color);draw_set_alpha(_state.alpha)
    }
    scrNTTESmokeLog("FULL TOP SHADOW source3families/z8+visibility/real shiftedFloor-Wall pixel mask/actual Mortar ellipse/BigPipe sprite/NothingSpiral gate/minor1.25+5.25 resize/caller state/actual cleanup OK @"+string(30/timescale))
}

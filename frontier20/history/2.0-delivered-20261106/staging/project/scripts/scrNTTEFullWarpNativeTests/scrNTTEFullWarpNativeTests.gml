function scrNTTEFullWarpNativeTests() {
    var _before=scrNTTEFullInstances(all),_game=scrNTTEFullAreaGeneratorSnapshot(GameCont),
        _players=scrNTTEFullAreaGeneratorSnapshot(Player),_back=scrNTTEFullAreaGeneratorSnapshot(BackCont),
        _music=scrNTTEFullAreaGeneratorSnapshot(MusCont),_seed=random_get_seed(),_global_seed=global.seed,_tick=current_frame,
        _p=instance_find(Player,0),_enemies=scrNTTEFullInstances(enemy),_walls=scrNTTEFullInstances(Wall),
        _surface=-1,_camera=-1,_world=matrix_get(matrix_world),_view=matrix_get(matrix_view),
        _projection=matrix_get(matrix_projection),_source_state=scrNTTEFullValue(GameCont,"ntte_full_source_seed",undefined)
    if(is_struct(_source_state)) GameCont.ntte_full_source_seed=scrNTTEFullSourceSeedCopy(_source_state)
    for(var _i=0;_i<array_length(_enemies);++_i) instance_deactivate_object(_enemies[_i])
    for(var _i=0;_i<array_length(_walls);++_i) instance_deactivate_object(_walls[_i])
    try {
        GameCont.area=206;GameCont.subarea=1;GameCont.loops=2;current_frame=8
        _p.x=99000;_p.y=99000;_p.visible=true
        var _s0=scrNTTEFullSourceWarpSeed(0),_s1=scrNTTEFullSourceWarpSeed(1),
            _first=instance_create(99064,99000,NTTEFullWarp),_second=instance_create(99200,99000,NTTEFullWarp)
        assert(_first.seed==_s0 && _second.seed==_s1 && _first.area!=206 && _second.area!=206
            && _first.area!=_second.area && _first.subarea>=1 && _first.subarea<=scrAreaGetMaxSubarea(_first.area)
            && !_first.open && _first.mask_index==-1 && _first.image_alpha==-1 && _first.depth==-9
            && _first.ntte_warp_alarm==30 && _first.image_speed==0.4*timescale
            && instance_exists(_first.prompt) && _first.prompt.creator==_first
            && _first.prompt.mask_index==mskReviveArea && _first.prompt.yoff==8,
            "Actual Warp constructor lost unique source area/seed ordering/defaults/native prompt")
        // An actual active enemy blocks the source alarm, independent of LOS.
        var _enemy=instance_create(99100,99100,NTTEFullRedSpider)
        with(_first) event_perform(ev_alarm,0)
        assert(!_first.open && _first.ntte_warp_alarm==30,"Warp opened while a real enemy remained")
        instance_destroy(_enemy,false)
        // Source requires at least one unobstructed player line after clearing.
        var _wall=instance_create(99032,98992,Wall)
        with(_first) event_perform(ev_alarm,0)
        assert(!_first.open,"Warp opened through an actual solid Wall blocking player LOS")
        instance_destroy(_wall,false)
        with(_first) event_perform(ev_alarm,0)
        assert(_first.open && _first.ntte_warp_alarm==-1,"Warp did not open after enemy clearance and real player LOS")
        var _angle=_first.image_angle
        _first.area=area_scrapyards;_first.subarea=2;_first.loops=3
        with(_first) event_perform(ev_step,ev_step_normal)
        assert(abs(_first.image_angle-_angle-timescale)<0.0001 && _first.prompt.visible
            && _first.prompt.text=="WARP#3-2 L3" && _first.sprite_index==_first.spr_open
            && abs(_first.image_xscale-1/3)<0.0001,
            "Warp open Step lost source spin/grow transition/selected map name/prompt visibility")
        // Real Draw executes both source artwork+bloom passes and restores
        // the negative CustomObject alpha convention afterward.
        _surface=surface_create(64,64);_camera=camera_create_view(99032,98968,64,64,0,noone,-1,-1,-1,-1)
        surface_set_target(_surface);camera_apply(_camera);draw_clear_alpha(c_black,0)
        with(_first) event_perform(ev_draw,0)
        surface_reset_target()
        assert(_first.image_alpha==-1,"Warp actual Draw lost negative-alpha convention")
        // Prompt.pick is the player index. Destruction must close siblings
        // and create the genuine BigPortal-backed WarpPortal with that target.
        _first.prompt.pick=_p.index;_second.open=true;_second.ntte_warp_alarm=10
        with(_first) event_perform(ev_step,ev_step_normal)
        assert(!instance_exists(_first) && !_second.open && _second.ntte_warp_alarm==-1,
            "Warp selected source prompt failed actual destruction or sibling closing")
        var _portals=scrNTTEFullInstances(NTTEFullWarpPortal),_found=noone
        for(var _i=0;_i<array_length(_portals);++_i) if(array_get_index(_before,_portals[_i])<0) _found=_portals[_i]
        assert(instance_exists(_found) && _found.area==area_scrapyards && _found.subarea==2 && _found.loops==3
            && instance_exists(_found.portal) && instance_is(_found.portal,BigPortal),
            "Warp destruction lost selected target or genuine native BigPortal transition object")
    }
    finally {
        if(surface_get_target()==_surface && _surface>=0) surface_reset_target()
        if(surface_exists(_surface)) surface_free(_surface)
        if(_camera>=0) camera_destroy(_camera)
        matrix_set(matrix_world,_world);matrix_set(matrix_view,_view);matrix_set(matrix_projection,_projection)
        scrNTTEFullMergedRuntimeTestCleanup(_before)
        for(var _i=0;_i<array_length(_enemies);++_i) instance_activate_object(_enemies[_i])
        for(var _i=0;_i<array_length(_walls);++_i) instance_activate_object(_walls[_i])
        scrNTTEFullAreaGeneratorRestore(_game);scrNTTEFullAreaGeneratorRestore(_players)
        scrNTTEFullAreaGeneratorRestore(_back);scrNTTEFullAreaGeneratorRestore(_music)
        GameCont.ntte_full_source_seed=_source_state
        global.seed=_global_seed;random_set_seed(_seed);current_frame=_tick
    }
    scrNTTESmokeLog("FULL WARP: source ordered seeds/unique nonred destination/real enemy+Wall LOS gate/spin+growth+selected map prompt/actual layered Draw/player-index pickup/sibling close/real BigPortal-backed selected target OK @"+string(30/timescale))
}

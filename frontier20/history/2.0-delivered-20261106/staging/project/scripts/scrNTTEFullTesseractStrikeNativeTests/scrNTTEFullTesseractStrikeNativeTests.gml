function scrNTTEFullTesseractStrikeNativeTests() {
    var _before=scrNTTEFullInstances(all),_game=scrNTTEFullAreaGeneratorSnapshot(GameCont),
        _players=scrNTTEFullAreaGeneratorSnapshot(Player),_back=scrNTTEFullAreaGeneratorSnapshot(BackCont),
        _seed=random_get_seed(),_tick=current_frame,_owner=instance_find(Player,0),_walls=scrNTTEFullInstances(Wall),
        _surface=-1,_camera=-1,_world=matrix_get(matrix_world),_view=matrix_get(matrix_view),_projection=matrix_get(matrix_projection)
    for(var _i=0;_i<array_length(_walls);++_i) instance_deactivate_object(_walls[_i])
    try {
        var _strike=noone
        with(_owner) _strike=scrNTTEFullMergedBasicProjectileCreate(101000,101000,NTTEFullTesseractStrike)
        _strike.image_angle=0
        assert(_strike.image_xscale==0.25 && _strike.image_yscale==0.25 && _strike.image_alpha==-1
            && _strike.active && _strike.length==320 && _strike.time==3 && _strike.ammo==1
            && _strike.ntte_strike_alarm==35 && _strike.mask_index==mskSuperFlakBullet
            && _strike.creator==_owner && _strike.team==_owner.team,
            "TesseractStrike actual constructor/source projectile ownership defaults changed")
        with(_strike) event_perform(ev_step,ev_step_end)
        assert(abs(_strike.x-101080)<=0.008 && _strike.y==101000 && _strike.xstart==101000,
            "Strike actual EndStep failed320scaled80px unobstructed warning extension")
        var _wall=instance_create(101040,100992,Wall)
        with(_strike) event_perform(ev_step,ev_step_end)
        var _blocked=false
        with(_strike) _blocked=place_meeting(x,y,_wall)
        assert(_blocked && _strike.x<101080,"Strike warning did not stop at the genuine wall collision mask")
        instance_destroy(_wall,false)
        _strike.image_xscale=1;_strike.image_yscale=1
        with(_strike) event_perform(ev_step,ev_step_end)
        var _count=instance_number(NTTEFullRedExplosion),_start=_strike.xstart
        GameCont.ntte_full_sleep_max=0
        with(_strike) event_perform(ev_alarm,1)
        assert(!_strike.active && _strike.image_speed==0.8*timescale && _strike.ntte_strike_alarm==3
            && instance_number(NTTEFullRedExplosion)==_count+1 && abs(_strike.xstart-_start-34)<=0.008
            && GameCont.ntte_full_sleep_max==15,
            "Strike first actual alarm lost34px explosion step/source flash speed/3tick delay/max freeze")
        var _explosion=noone
        with(NTTEFullRedExplosion) if(array_get_index(_before,id)<0) _explosion=id
        assert(instance_exists(_explosion) && _explosion.mask_index==mskPopoPlasmaImpact
            && _explosion.team==_owner.team && _explosion.creator==_owner,
            "Strike actual RedExplosion line lost original precise impact mask/projectile ownership")
        var _second=instance_create(101000,101100,NTTEFullTesseractStrike)
        _second.x=101010;_second.image_angle=0;_second.image_xscale=1;_second.image_yscale=1
        with(_second) event_perform(ev_alarm,1)
        assert(!instance_exists(_second) && GameCont.ntte_full_sleep_max==15,
            "Short first Strike segment lost guaranteed explosion/terminal destruction or stacked same-frame freeze")
        _surface=surface_create(352,64);_camera=camera_create_view(100984,100968,352,64,0,noone,-1,-1,-1,-1)
        surface_set_target(_surface);camera_apply(_camera);draw_clear_alpha(c_black,0)
        with(_strike) event_perform(ev_draw,0)
        surface_reset_target()
        assert(_strike.image_alpha==-1,"Strike actual arrow-line Draw lost negative-alpha convention")
        // Real logical Step alarms reach terminal after marching the full line.
        var _guard=0
        while(instance_exists(_strike) && _guard<round(100/timescale)) {
            with(_strike) event_perform(ev_step,ev_step_normal)
            _guard+=1
        }
        assert(!instance_exists(_strike),"Strike actual3tick alarm sequence failed to consume finite warning vector")
    }
    finally {
        if(surface_get_target()==_surface && _surface>=0) surface_reset_target()
        if(surface_exists(_surface)) surface_free(_surface)
        if(_camera>=0) camera_destroy(_camera)
        matrix_set(matrix_world,_world);matrix_set(matrix_view,_view);matrix_set(matrix_projection,_projection)
        scrNTTEFullMergedRuntimeTestCleanup(_before)
        for(var _i=0;_i<array_length(_walls);++_i) instance_activate_object(_walls[_i])
        scrNTTEFullAreaGeneratorRestore(_game);scrNTTEFullAreaGeneratorRestore(_players);scrNTTEFullAreaGeneratorRestore(_back)
        random_set_seed(_seed);current_frame=_tick
    }
    scrNTTESmokeLog("FULL TESSERACT STRIKE: actual vector+wall clipping/source34px owned RedExplosion steps/3tick alarm/first short-segment hit/same-frame max freeze/actual arrow Draw/finite destruction OK @"+string(30/timescale))
}

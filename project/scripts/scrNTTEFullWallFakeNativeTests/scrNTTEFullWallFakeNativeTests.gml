function scrNTTEFullWallFakeNativeTests() {
    var _before=scrNTTEFullInstances(all),_players=scrNTTEFullAreaGeneratorSnapshot(Player),
        _game=scrNTTEFullAreaGeneratorSnapshot(GameCont),_back=scrNTTEFullAreaGeneratorSnapshot(BackCont),
        _seed=random_get_seed(),_tick=current_frame,_p=instance_find(Player,0),
        _quality=variable_global_exists("ntte_full_minor_quality")?global.ntte_full_minor_quality:undefined,
        _vx=view_xview,_vy=view_yview,_vw=view_width,_vh=view_height,_surface=-1,_camera=-1,
        _world=matrix_get(matrix_world),_view=matrix_get(matrix_view),_projection=matrix_get(matrix_projection)
    global.ntte_full_minor_quality=1
    try {
        GameCont.area=206;_p.x=97008;_p.y=97008;_p.race=Race.Fish;current_frame=8
        var _wall=instance_create(97000,97000,NTTEFullWallFake),_helper=noone
        with(NTTEFullWallFakeHelper) if(creator==_wall) _helper=id
        assert(instance_is(_wall,Wall) && !_wall.solid && _wall.visible && _wall.depth==3
            && instance_exists(_helper) && _helper.solid && !_helper.visible && _helper.creator==_wall
            && _helper.sprite_index==_wall.sprite_index && _helper.mask_index==_wall.mask_index
            && abs(_wall.image_speed-(0.4+0.1*sin(_wall.x/16+_wall.y/16))*timescale)<0.0001,
            "WallFake actual constructor lost original animated Wall/independent solid copied helper")
        var _controller=instance_find(NTTEFullWallFakeController,0)
        _p.red_wall_fake=0
        with(_controller) event_perform(ev_step,ev_step_end)
        assert(!_helper.solid && _wall.mask_index==mskNone && abs(_p.red_wall_fake-0.1*timescale)<0.0001
            && _controller.ntte_wall_fake_reveal_visible,
            "WallFake actual EndStep lost in-wall actor collision disabling/reveal logical growth")
        _p.x=97500;_p.y=97500
        with(_controller) event_perform(ev_step,ev_step_end)
        assert(_helper.solid && _wall.mask_index==_helper.mask_index && _p.red_wall_fake==0,
            "WallFake source collision failed solid/mask restoration or circle decay")
        // Frog alone predicts its next physical motion, opens the helper,
        // and reverses that prediction before the engine motion pass.
        _p.race=Race.Frog;_p.y=_helper.y+8;_p.friction=0;_p.gravity=0
        _p.x=_helper.bbox_left-(_p.bbox_right-_p.x)-2
        _p.hspeed=4;_p.vspeed=0
        var _frog_x=_p.x,_frog_y=_p.y,_frog_hspeed=_p.hspeed,_frog_vspeed=_p.vspeed,_meeting=false
        with(_p) _meeting=place_meeting(x,y,_helper)
        assert(!_meeting,"Frog prediction fixture must start outside the helper mask")
        with(_controller) event_perform(ev_step,ev_step_end)
        assert(!_helper.solid && _wall.mask_index==mskNone && abs(_p.red_wall_fake-0.1*timescale)<0.0001
            && abs(_p.x-_frog_x)<=0.008 && abs(_p.y-_frog_y)<=0.008
            && _p.hspeed==_frog_hspeed && _p.vspeed==_frog_vspeed,
            "Frog predicted helper entry failed source opening/reveal or reverse motion restoration")
        _p.race=Race.Fish;_p.hspeed=0;_p.vspeed=0;_p.x=97500;_p.y=97500
        with(_controller) event_perform(ev_step,ev_step_end)
        assert(_helper.solid && _p.red_wall_fake==0,
            "Frog predicted reveal failed helper restoration after moving away")
        // A second nearby helper opens along with the intersected one, while
        // a remote wall stays solid under the source bbox-distance32 rule.
        var _near=instance_create(97016,97000,NTTEFullWallFake),_far=instance_create(97128,97000,NTTEFullWallFake),
            _near_helper=noone,_far_helper=noone
        with(NTTEFullWallFakeHelper) {
            if(creator==_near) _near_helper=id
            if(creator==_far) _far_helper=id
        }
        _p.x=97008;_p.y=97008
        with(_controller) event_perform(ev_step,ev_step_end)
        assert(!_near_helper.solid && _far_helper.solid,
            "WallFake helper neighborhood lost source32distance scope")
        instance_destroy(_near)
        with(_controller) event_perform(ev_step,ev_step_end)
        assert(!instance_exists(_near_helper),"WallFake EndStep retained orphan collision helper")
        // Both draw passes use actual surfaces and preserve RGB from the
        // already rendered game while retaining the authored circle/mask alpha.
        view_xview=0;view_yview=0;view_width=96;view_height=96
        _wall.x=32;_wall.y=32;_wall.mask_index=_helper.mask_index;_wall.image_speed=0;_wall.image_index=0
        _p.x=40;_p.y=40;_p.red_wall_fake=1;_controller.ntte_wall_fake_reveal_visible=true
        _surface=surface_create(96,96);_camera=camera_create_view(0,0,96,96,0,noone,-1,-1,-1,-1)
        surface_set_target(_surface);camera_apply(_camera);draw_clear(c_blue)
        var _pass=instance_find(NTTEFullWallFakeDrawBot,0)
        with(_pass) event_perform(ev_draw,0)
        assert(surface_exists(_pass.ntte_wall_fake_mask) && surface_exists(_pass.ntte_wall_fake_surface),
            "WallFake actual bottom draw failed mask/screenshot surface creation")
        var _pixels=0,_blue=0
        for(var _y=0;_y<96;++_y) for(var _x=0;_x<96;++_x) {
            var _pixel=surface_getpixel_ext(_pass.ntte_wall_fake_surface,_x,_y)
            if(((_pixel>>24)&255)>0) {_pixels+=1;if((_pixel&$ffffff)==c_blue) _blue+=1;}
        }
        assert(_pixels>0 && _pixels==_blue,
            "WallFake actual masked reveal lost intersected pixels or RGB-only screenshot semantics")
        with(instance_find(NTTEFullWallFakeRevealBot,0)) event_perform(ev_draw,0)
        with(instance_find(NTTEFullWallFakeDrawTop,0)) event_perform(ev_draw,0)
        with(instance_find(NTTEFullWallFakeRevealTop,0)) event_perform(ev_draw,0)
        if(surface_get_target()==_surface) surface_reset_target()
        // Actual helper cleanup after the final source Wall disappears.
        instance_destroy(_wall);instance_destroy(_far)
        with(_controller) event_perform(ev_step,ev_step_end)
        assert(!instance_exists(_helper) && !instance_exists(_far_helper) && _p.red_wall_fake==0,
            "WallFake final wall removal retained helpers or player reveal state")
    }
    finally {
        global.ntte_full_minor_quality=_quality
        if(surface_get_target()==_surface && _surface>=0) surface_reset_target()
        if(surface_exists(_surface)) surface_free(_surface)
        if(_camera>=0) camera_destroy(_camera)
        matrix_set(matrix_world,_world);matrix_set(matrix_view,_view);matrix_set(matrix_projection,_projection)
        view_xview=_vx;view_yview=_vy;view_width=_vw;view_height=_vh
        scrNTTEFullMergedRuntimeTestCleanup(_before)
        scrNTTEFullAreaGeneratorRestore(_players);scrNTTEFullAreaGeneratorRestore(_game);scrNTTEFullAreaGeneratorRestore(_back)
        current_frame=_tick;random_set_seed(_seed)
    }
    scrNTTESmokeLog("FULL WALL FAKE: actual animated Wall+independent solid helper, source EndStep proximity/mask/reveal, orphan cleanup, native bottom/top masked RGB screenshot/reveal surfaces OK @"+string(30/timescale))
}

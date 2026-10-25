function scrNTTEFullRoadmapNativeTests() {
    var _game=scrNTTEFullAreaGeneratorSnapshot(GameCont),_tick=current_frame,
        _surface=-1,_camera=-1,_world=matrix_get(matrix_world),_view=matrix_get(matrix_view),_projection=matrix_get(matrix_projection),
        _color=draw_get_color(),_alpha=draw_get_alpha()
    try {
        var _map=scrNTTEFullRoadmapData([[area_desert,1,0],[area_sewers,1,0],[area_scrapyards,3,0],
            [201,1,0],[201,3,0],[202,1,0],[205,2,0],[203,1,0],[204,1,0]])
        assert(array_length(_map)==10 && _map[0].area==-1 && _map[1].x==0 && _map[2].x==27 && _map[3].x==54,
            "Source roadmap lost sentinel/base3+1 area/subarea coordinates")
        assert(abs(_map[4].x-18.15)<=0.00001 && _map[4].y==-9 && _map[4].showdot
            && abs(_map[5].x-36.15)<=0.00001 && !_map[5].showdot && _map[6].x==44 && _map[6].y==-9
            && abs(_map[7].x-53.9)<=0.00001 && _map[7].y==9 && !_map[7].showdot
            && _map[8].x==_map[7].x && _map[8].y==9 && !_map[8].showdot
            && _map[9].x==_map[8].x && !_map[9].showdot,
            "Source roadmap lost exact coast/oasis/trench/pizza/lair coordinates/dot flags")
        _map=scrNTTEFullRoadmapData([[area_desert,3,0],[206,1,0],[206,3,0]])
        assert(_map[2].x==18 && _map[2].y==9 && _map[2].showdot && _map[2].showline
            && _map[3].x==18 && _map[3].y==18 && !_map[3].showdot && _map[3].showline
            && is_undefined(_map[2].warp) && is_undefined(_map[3].warp),
            "Still-in-Red roadmap must stack9px and preserve explicit boss subarea3")
        _map=scrNTTEFullRoadmapData([[area_desert,3,0],[206,1,0],[area_city,2,0]])
        assert(_map[2].x==81 && _map[2].y==0 && !_map[2].showdot && !_map[2].showline
            && is_struct(_map[2].warp) && _map[2].warp.last.x==18 && _map[2].warp.last.y==0
            && _map[2].warp.next.area==area_city && _map[3].x==81,
            "Completed source Red warp lost detached entry/exit geometry or duplicated ordinary path")
        var _secrets=[area_oasis,area_pizza_sewers,area_mansion,area_cursed_caves,area_jungle],_offsets=[0,27,36,54,72]
        for(var _i=0;_i<array_length(_secrets);++_i) {
            _map=scrNTTEFullRoadmapData([[area_desert,3,0],[206,1,0],[_secrets[_i],1,0]])
            assert(_map[2].x==_offsets[_i] && _map[2].y==9 && !_map[2].showline,
                "Completed Red warp lost original secret-area horizontal offset")
        }
        _map=scrNTTEFullRoadmapData([[area_desert,3,0],[206,1,0],[203,1,0]])
        assert(_map[2].x==27 && _map[3].x==27 && !_map[3].showdot,
            "Red-to-modded-Pizza roadmap ignored source predecessor correction")
        _map=scrNTTEFullRoadmapData([[area_desert,3,0],[206,1,0],[206,1,1]])
        assert(is_undefined(_map[2].warp) && _map[2].y==9 && _map[3].loops==1 && _map[3].y==18,
            "Unfinished Red warp was falsely connected across source loop identity")
        // Exercise the actual maintained roadmap renderer, including native
        // background/stats/character/pet icons and original animated RedDot.
        GameCont.waypoints=3;GameCont.waypnt=[area_desert,206,area_city]
        GameCont.waysub=[3,1,2];GameCont.waylps=[0,0,0]
        GameCont.area=area_city;GameCont.subarea=2;GameCont.loops=0;current_frame=8
        _surface=surface_create(256,128);_camera=camera_create_view(0,0,256,128,0,noone,-1,-1,-1,-1)
        surface_set_target(_surface);camera_apply(_camera);draw_clear_alpha(c_black,0)
        scrDrawRoadmap(128,64,3)
        var _anchor=scrNTTEFullRoadmapDraw(20,64,2)
        assert(_anchor[0]==101 && _anchor[1]==64,"Source roadmap final player/pet anchor did not follow completed warp")
        draw_set_color(c_lime);draw_set_alpha(0.4)
        var _data=scrNTTEFullRoadmapData()[2]
        scrNTTEFullRoadmapWarpDraw(_data,20,64,c_red,0.6)
        assert(draw_get_color()==c_lime && abs(draw_get_alpha()-0.4)<=0.00001,
            "Actual animated RedDot draw leaked source color/alpha state")
        surface_reset_target()
    }
    finally {
        if(_surface>=0 && surface_get_target()==_surface) surface_reset_target()
        if(surface_exists(_surface)) surface_free(_surface)
        if(_camera>=0) camera_destroy(_camera)
        matrix_set(matrix_world,_world);matrix_set(matrix_view,_view);matrix_set(matrix_projection,_projection)
        draw_set_color(_color);draw_set_alpha(_alpha)
        scrNTTEFullAreaGeneratorRestore(_game);current_frame=_tick
    }
    scrNTTESmokeLog("FULL RED ROADMAP: source six-area/base coordinates/stacked Red/boss3/completed warp disconnected path/five secret offsets/pizza predecessor/loop identity/actual Roadmap+RedDot Draw/native player+pet anchor/state restore OK @"+string(30/timescale))
}

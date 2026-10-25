function scrNTTEFullWarpDestinationNativeTests() {
    var _before=scrNTTEFullInstances(all),_game=scrNTTEFullAreaGeneratorSnapshot(GameCont),
        _players=scrNTTEFullAreaGeneratorSnapshot(Player),_seed=random_get_seed(),_tick=current_frame
    try {
        GameCont.area=206;GameCont.subarea=1;GameCont.loops=2;GameCont.lastarea=area_city;GameCont.lastsubarea=2
        // Use a real WarpPortal constructor, then the production terminal
        // destination bridge without performing native BigPortal room_restart.
        var _warp=instance_create(98000,98000,NTTEFullWarpPortal)
        assert(instance_exists(_warp.portal) && instance_is(_warp.portal,BigPortal),
            "Warp destination fixture did not construct a genuine native BigPortal")
        _warp.area=area_scrapyards;_warp.subarea=2;_warp.loops=3
        var _destination=undefined
        with(_warp) _destination=scrNTTEFullWarpPortalDestination()
        assert(GameCont.area==206 && GameCont.subarea==1 && GameCont.loops==2
            && _destination.area==area_scrapyards && _destination.subarea==2 && _destination.loops==3
            && _destination.lastarea==area_scrapyards && _destination.lastsubarea==1,
            "Warp bridge lost selected destination or source nonsecret return bookkeeping")
        GameCont.can_advance_stage=true
        with(GameCont) event_perform(ev_other,ev_room_end)
        assert(GameCont.area==area_scrapyards && GameCont.subarea==2 && GameCont.loops==3
            && GameCont.lastarea==area_scrapyards && GameCont.lastsubarea==1,
            "Actual Warp RoomEnd lost selected destination/return bookkeeping or advanced twice")
        GameCont.area=206;GameCont.subarea=1;GameCont.lastarea=area_city;GameCont.lastsubarea=2
        _warp.area=area_jungle;_warp.subarea=1;_warp.loops=4
        with(_warp) _destination=scrNTTEFullWarpPortalDestination()
        assert(_destination.lastarea==area_city && _destination.lastsubarea==2,
            "Warp secret destination must retain existing normal-area return information")
        GameCont.can_advance_stage=true
        with(GameCont) event_perform(ev_other,ev_room_end)
        assert(GameCont.area==area_jungle && GameCont.subarea==1 && GameCont.loops==4
            && GameCont.lastarea==area_city && GameCont.lastsubarea==2,
            "Actual secret Warp RoomEnd replaced retained normal-area return information")
    }
    finally {
        var _all=scrNTTEFullInstances(all)
        for(var _i=0;_i<array_length(_all);++_i) if(array_get_index(_before,_all[_i])<0) instance_destroy(_all[_i],false)
        scrNTTEFullAreaGeneratorRestore(_game);scrNTTEFullAreaGeneratorRestore(_players)
        random_set_seed(_seed);current_frame=_tick
    }
    scrNTTESmokeLog("FULL WARP DESTINATION: genuine invisible BigPortal/selected area+subarea+loops/pending actual RoomEnd/no double advancement/normal return update+secret return preservation OK @"+string(30/timescale))
}

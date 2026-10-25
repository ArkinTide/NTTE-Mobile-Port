function scrNTTEFullLairTransitNativeTests() {
    var _state=scrNTTEFullVanillaFixtureBegin(),_players=scrNTTEFullAreaGeneratorSnapshot(Player),
        _uber=scrNTTEFullAreaGeneratorSnapshot(UberCont),
        _oldActive=scrNTTEFullValue(GameCont,"ntte_full_active_lair",false),
        _oldVisits=scrNTTEFullValue(GameCont,"ntte_visits_lair",0),
        _oldPending=scrNTTEFullValue(GameCont,"ntte_full_pending_destination",undefined)
    try {
        for(var _loop=0;_loop<=1;++_loop) {
            GameCont.area=scrNTTEFullAreaId("lair");GameCont.subarea=1;GameCont.loops=_loop
            GameCont.gocrib=false;GameCont.can_advance_stage=true;GameCont.maxsubarea=1;GameCont.finalsubarea=true
            GameCont.ntte_full_pending_destination=undefined;GameCont.ntte_full_active_lair=true;GameCont.ntte_visits_lair=7
            var _hard=GameCont.hard,_waypoints=GameCont.waypoints
            with(GameCont) event_perform(ev_other,ev_room_end)
            assert(GameCont.area==area_scrapyards && GameCont.subarea==1 && GameCont.loops==_loop
                && GameCont.ntte_visits_lair==8 && !GameCont.ntte_full_active_lair,
                "Genuine native Lair RoomEnd did not finish in Scrapyards1 or lost visits/loop/active source state")
            assert(GameCont.waypoints==_waypoints+1 && GameCont.waypnt[_waypoints]==area_scrapyards
                && GameCont.waysub[_waypoints]==1 && GameCont.waylps[_waypoints]==_loop
                && GameCont.hard==_hard+(scrGameIsHardmode()?2:1),
                "Lair RoomEnd bypassed native stage bookkeeping or advanced its destination twice")
        }
        // Explicit WarpPortal destinations take precedence while source finish
        // still records the visit and source transit closes old area state.
        GameCont.area=scrNTTEFullAreaId("lair");GameCont.subarea=1;GameCont.loops=0
        GameCont.gocrib=false;GameCont.can_advance_stage=true;GameCont.ntte_full_active_lair=true
        GameCont.ntte_visits_lair=11
        scrNTTEFullAreaSet(area_vault,1,0)
        with(GameCont) event_perform(ev_other,ev_room_end)
        assert(GameCont.area==area_vault && GameCont.subarea==1 && GameCont.ntte_visits_lair==12
            && !GameCont.ntte_full_active_lair && is_undefined(GameCont.ntte_full_pending_destination),
            "Lair source finish overwrote an actual selected Warp destination or failed to consume/reset it")
    }
    finally {
        scrNTTEFullAreaGeneratorRestore(_players);scrNTTEFullAreaGeneratorRestore(_uber)
        scrNTTEFullVanillaFixtureEnd(_state)
        GameCont.ntte_full_active_lair=_oldActive;GameCont.ntte_visits_lair=_oldVisits
        GameCont.ntte_full_pending_destination=_oldPending
    }
    scrNTTESmokeLog("FULL LAIR TRANSIT: actual native RoomEndScrapyards1 atloops0/1, visits/active flags, native waypoint/hard increments, explicit Warp destination precedence and one-shot consumption OK @"+string(30/timescale))
}

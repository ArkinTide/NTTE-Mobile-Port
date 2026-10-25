function scrNTTEFullTrenchTransitNativeTests() {
    var _before=scrNTTEFullInstances(all),_game=scrNTTEFullAreaGeneratorSnapshot(GameCont),
        _players=scrNTTEFullAreaGeneratorSnapshot(Player),_uber=scrNTTEFullAreaGeneratorSnapshot(UberCont),
        _pit_check=scrNTTEFullAreaGeneratorSnapshot([Corpse,ChestOpen,Debris,Shell,Feather]),
        _source=scrNTTEFullSourceSeedState(),_seed=random_get_seed(),_tick=current_frame,
        _grid=variable_global_exists("ntte_full_trench_pit_grid")?global.ntte_full_trench_pit_grid:-1,
        _dirty=variable_global_exists("ntte_full_trench_pit_dirty")?global.ntte_full_trench_pit_dirty:false,
        _count=variable_global_exists("ntte_full_trench_floor_count")?global.ntte_full_trench_floor_count:-1,
        _progress_graph={nodes:[]}
    scrNTTEFullAreaSnapshotContainer(global.ntte_full_progress,_progress_graph)
    var _progress={instances:[],containers:_progress_graph.nodes}
    GameCont.ntte_full_source_seed=scrNTTEFullSourceSeedCopy(_source)
    global.ntte_full_trench_pit_grid=ds_grid_create(1250,1250)
    try {
        // Avoid persistent-file writes while exercising actual source Finish.
        variable_struct_set(global.ntte_full_progress.unlocks,"skin:parrot:1",true)
        GameCont.area=scrNTTEFullAreaId("trench");GameCont.subarea=1;GameCont.loops=2
        GameCont.gocrib=false;GameCont.ntte_visits_trench=4;GameCont.ntte_full_visits_trench=4
        for(var _sub=1;_sub<=3;++_sub) {
            GameCont.area=scrNTTEFullAreaId("trench");GameCont.subarea=_sub
            GameCont.can_advance_stage=true;GameCont.ntte_active_trench=true;GameCont.ntte_full_active_trench=true
            GameCont.ntte_full_pending_destination=undefined
            scrNTTEFullTrenchPitSet(10016,10016,true)
            with(GameCont) event_perform(ev_other,ev_room_end)
            assert(GameCont.area==(_sub<3?scrNTTEFullAreaId("trench"):area_city)
                && GameCont.subarea==(_sub<3?_sub+1:1) && GameCont.loops==2
                && GameCont.ntte_visits_trench==4+_sub && GameCont.ntte_full_visits_trench==4+_sub,
                "Actual Trench RoomEnd lost1->2->3->City1/source visits or incremented stage twice")
            assert(!GameCont.ntte_active_trench && !GameCont.ntte_full_active_trench
                && !scrNTTEFullTrenchPitGet(10016,10016),
                "Actual Trench RoomEnd leaked source active flag or original pit grid")
        }
        GameCont.area=scrNTTEFullAreaId("trench");GameCont.subarea=3;GameCont.can_advance_stage=true
        GameCont.ntte_active_trench=true;GameCont.ntte_full_active_trench=true
        var _destination=scrNTTEFullAreaSet(area_scrapyards,2,3)
        _destination.lastarea=area_scrapyards;_destination.lastsubarea=1
        scrNTTEFullTrenchPitSet(10016,10016,true)
        with(GameCont) event_perform(ev_other,ev_room_end)
        assert(GameCont.area==area_scrapyards && GameCont.subarea==2 && GameCont.loops==3
            && GameCont.lastarea==area_scrapyards && GameCont.lastsubarea==1
            && GameCont.ntte_visits_trench==8 && !scrNTTEFullTrenchPitGet(10016,10016),
            "Actual Trench selected Warp RoomEnd skipped visits/transit or replaced queued destination")
        GameCont.area=scrNTTEFullAreaId("trench");GameCont.subarea=1;GameCont.can_advance_stage=false
        GameCont.ntte_active_trench=true;scrNTTEFullTrenchPitSet(10016,10016,true)
        with(GameCont) event_perform(ev_other,ev_room_end)
        assert(GameCont.subarea==1 && GameCont.ntte_visits_trench==8 && GameCont.ntte_active_trench
            && scrNTTEFullTrenchPitGet(10016,10016),
            "Native disabled stage advance must not dispatch Trench finish/transit")
    }
    finally {
        scrNTTEFullMergedRuntimeTestCleanup(_before)
        scrNTTEFullAreaGeneratorRestore(_game);scrNTTEFullAreaGeneratorRestore(_players)
        scrNTTEFullAreaGeneratorRestore(_uber);scrNTTEFullAreaGeneratorRestore(_progress)
        scrNTTEFullAreaGeneratorRestore(_pit_check)
        GameCont.ntte_full_source_seed=_source;random_set_seed(_seed);current_frame=_tick
        ds_grid_destroy(global.ntte_full_trench_pit_grid)
        global.ntte_full_trench_pit_grid=_grid;global.ntte_full_trench_pit_dirty=_dirty
        global.ntte_full_trench_floor_count=_count
    }
    scrNTTESmokeLog("FULL TRENCH ACTUAL ROOMEND1->2->3->CITY1/visits/active aliases/pit reset/selected Warp retention/disabled-advance guard OK @"+string(30/timescale))
}

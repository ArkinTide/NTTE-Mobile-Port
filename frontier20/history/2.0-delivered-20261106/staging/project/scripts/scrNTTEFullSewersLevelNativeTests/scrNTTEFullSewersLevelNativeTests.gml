function scrNTTEFullSewersLevelNativeTests() {
    var _before=scrNTTEFullInstances(all),_game=scrNTTEFullAreaGeneratorSnapshot(GameCont),
        _players=scrNTTEFullAreaGeneratorSnapshot(Player),_back=scrNTTEFullAreaGeneratorSnapshot(BackCont),
        _uber=scrNTTEFullAreaGeneratorSnapshot(UberCont),_mus=scrNTTEFullAreaGeneratorSnapshot(MusCont),
        _seed=random_get_seed(),_source=scrNTTEFullSourceSeedState(),_tick=current_frame,
        _vx=view_xview,_vy=view_yview,_vw=view_width,_vh=view_height,
        _sync=variable_global_exists("ntte_full_sync_generation")?global.ntte_full_sync_generation:false,
        _tutorial=save_get_value("game","tutorial",true),
        _parked=scrNTTEFullInstances([Floor,FloorMaker,Wall,TopSmall,Bones,enemy,chestprop,RadChest,
            TopCont,SubTopCont,GenCont,NTTEFullSludgePool,NTTEFullSewersPropGuard,NTTEFullPet]),
        _progress_graph={nodes:[]},_bg=__background_get_colour_element(),_bgcolor=layer_background_get_blend(_bg[0])
    scrNTTEFullAreaSnapshotContainer(global.ntte_full_progress,_progress_graph)
    var _progress={instances:[],containers:_progress_graph.nodes}
    scrNTTEFullFloorInit()
    var _style=global.ntte_full_floor_style,_area=global.ntte_full_floor_area,
        _aw=global.ntte_full_floor_aw,_ah=global.ntte_full_floor_ah,_ax=global.ntte_full_floor_ax,_ay=global.ntte_full_floor_ay
    GameCont.ntte_full_source_seed=scrNTTEFullSourceSeedCopy(_source)
    for(var _i=0;_i<array_length(_parked);++_i) instance_deactivate_object(_parked[_i])
    try {
        GameCont.area=area_sewers;GameCont.subarea=1;GameCont.loops=1;GameCont.hard=1
        GameCont.gocrib=false;GameCont.crown=Crown.None;UberCont.opt_bossintro=false
        view_xview=0;view_yview=0;view_width=128;view_height=128
        scrNTTEFullFloorResetStyle();scrNTTEFullFloorResetAlign()
        save_set_value("game","tutorial",false);global.ntte_full_sync_generation=true
        var _gen=instance_create(0,0,GenCont)
        instance_destroy(FloorMaker,false);instance_destroy(Floor,false)
        // Native Destroy unsticks enemies BEFORE NTTE's level_start. Give
        // each Queen a real floor so that native prelude cannot stack both
        // at the unrelated Ratking water tile and invalidate separation.
        instance_create(240000,240000,Floor);instance_create(241000,240000,Floor)
        var _barrel=instance_create(239016,240016,ToxicBarrel),
            _queen=instance_create(240016,240016,FrogQueen),_second=instance_create(241016,240016,FrogQueen),
            _water=instance_create(242000,240000,Floor),_rat=instance_create(242016,240016,Ratking)
        _water.styleb=1
        var _first_queen=noone,_other_queen=noone
        with(FrogQueen) {_first_queen=id;break}
        _other_queen=_first_queen==_queen?_second:_queen
        // The real native Destroy event invokes production level_start hook;
        // hard1 intentionally proves this branch is outside _normalArea.
        with(_gen) event_perform(ev_destroy,0)
        instance_destroy(_gen,false)
        assert(instance_number(NTTECat)>=2 && instance_number(NTTECat)<=3,
            "Actual Sewers level_start omitted2..3Cats for the original barrel or spawned Cats for later pool props")
        assert(instance_number(NTTEFullSludgePool)==1 && !instance_exists(_rat)
            && instance_number(NTTEFullTrafficCrab)==1,
            "Actual Sewers level_start lost first-queen-only bath or guaranteed loop styleB Ratking replacement")
        var _pool=instance_find(NTTEFullSludgePool,0)
        assert(!_pool.setup && _pool.sprite_index==scrNTTERefSprite("msk.SewerPoolBig")
            && _pool.spr_floor==scrNTTERefSprite("SewerPoolBig") && array_length(_pool.floors)==25
            && !instance_exists(FrogEgg),
            "Source FrogQueen bath did not run real SludgePool Step/5x5 native floor art or enabled commented eggs")
        for(var _i=0;_i<25;++_i) {
            var _tile=_pool.floors[_i]
            assert(instance_exists(_tile) && _tile.sprite_index==scrNTTERefSprite("SewerPoolBig")
                && _tile.image_index==_i && _tile.material>=4,
                "Source FrogQueen bath lost ordered25floor art or actual sludge foot material")
        }
        assert(point_distance(_pool.x,_pool.y,_first_queen.x,_first_queen.y)<32
            && point_distance(_pool.x,_pool.y,_other_queen.x,_other_queen.y)>800,
            "Source FrogQueen bath moved to an additional queen despite source break")
        scrNTTEFullMergedRuntimeTestCleanup(_before)
        // No loop conversion in loop0, including water; dry loop1 preserves
        // a Ratking on a failed first chance draw. Non-Sewers changes nothing.
        GameCont.loops=0
        _water=instance_create(244000,240000,Floor);_water.styleb=1
        _rat=instance_create(244016,240016,Ratking)
        scrNTTEFullSewersLevelStart()
        assert(instance_exists(_rat) && !instance_exists(NTTEFullTrafficCrab),"Source Sewers loop0 replaced a Ratking")
        instance_destroy(_water,false);GameCont.loops=1
        var _failed_seed=-1
        for(var _i=0;_i<100;++_i) {random_set_seed(_i);if(random(3)>=1) {_failed_seed=_i;break}}
        assert(_failed_seed>=0,"Dry loop Ratking fixture failed to select a genuine native failed chance")
        random_set_seed(_failed_seed);scrNTTEFullSewersLevelStart()
        assert(instance_exists(_rat),"Dry loop Ratking must survive a failed1/3 source replacement draw")
        GameCont.area=area_desert;_barrel=instance_create(244000,240000,ToxicBarrel)
        scrNTTEFullSewersLevelStart()
        assert(!instance_exists(NTTECat),"Source ordinary Sewers provider leaked Cats into another area")
        // Original fork/wait0 protection: source size4 outside view, restores
        // old size once seen, preserves external size edits, and drops orphans.
        var _prop=instance_create(246000,240000,Pipe),_old_size=_prop.size
        scrNTTEFullSewersPropShield(_prop)
        var _guard=instance_find(NTTEFullSewersPropGuard,0)
        assert(instance_exists(_guard) && _prop.size==4,"Source off-screen prop did not receive actual deferred size4 protection")
        with(_guard) event_perform(ev_step,ev_step_normal)
        assert(instance_exists(_guard) && _prop.size==4,"Source prop protection ended before its point became visible")
        view_xview=_prop.x-64;view_yview=_prop.y-64
        with(_guard) event_perform(ev_step,ev_step_normal)
        assert(!instance_exists(_guard) && _prop.size==_old_size,"Actual visibility guard did not restore source original prop size")
        scrNTTEFullSewersPropShield(_prop)
        assert(!instance_exists(NTTEFullSewersPropGuard) && _prop.size==_old_size,
            "Source immediately visible prop must restore size without leaving a waiting coroutine")
        view_xview=0;view_yview=0;scrNTTEFullSewersPropShield(_prop)
        _guard=instance_find(NTTEFullSewersPropGuard,0);_prop.size=2
        view_xview=_prop.x-64;view_yview=_prop.y-64
        with(_guard) event_perform(ev_step,ev_step_normal)
        assert(_prop.size==2,"Source visibility protection overwrote an unrelated live size change")
        view_xview=0;view_yview=0;scrNTTEFullSewersPropShield(_prop)
        _guard=instance_find(NTTEFullSewersPropGuard,0);instance_destroy(_prop,false)
        with(_guard) event_perform(ev_step,ev_step_normal)
        assert(!instance_exists(_guard),"Source prop visibility coroutine survived its destroyed target")
    }
    finally {
        scrNTTEFullMergedRuntimeTestCleanup(_before)
        for(var _i=0;_i<array_length(_parked);++_i) instance_activate_object(_parked[_i])
        scrNTTEFullAreaGeneratorRestore(_game);scrNTTEFullAreaGeneratorRestore(_players)
        scrNTTEFullAreaGeneratorRestore(_back);scrNTTEFullAreaGeneratorRestore(_uber);scrNTTEFullAreaGeneratorRestore(_mus)
        scrNTTEFullAreaGeneratorRestore(_progress)
        GameCont.ntte_full_source_seed=_source;random_set_seed(_seed);current_frame=_tick
        save_set_value("game","tutorial",_tutorial);global.ntte_full_sync_generation=_sync
        layer_background_blend(_bg[0],_bgcolor)
        view_xview=_vx;view_yview=_vy;view_width=_vw;view_height=_vh
        global.ntte_full_floor_style=_style;global.ntte_full_floor_area=_area
        global.ntte_full_floor_aw=_aw;global.ntte_full_floor_ah=_ah;global.ntte_full_floor_ax=_ax;global.ntte_full_floor_ay=_ay
    }
    scrNTTESmokeLog("FULL SEWERS LEVEL START: actual GenCont Destroy hook/hard1 Cats2..3 per original barrel/first Queen only/real25tile SewerPoolBig bath/ordered floor art+sludge feet/no commented eggs/loop water Ratking TrafficCrab/dry chance/loop0+area guards/actual deferred prop size4 visibility restoration/external size/orphan cleanup OK @"+string(30/timescale))
}

// Reproduce the actual drain Step -> Destroy -> secret-room chain with
// surviving, disabled, and synchronously replaced native Dust constructors.
function scrNTTEFullSewerDrainLifetimeTests() {
    assert(!instance_exists(GenCont) && instance_exists(GameCont),"Drain lifetime requires a settled room")
    var _before=scrNTTEFullInstances(all),_game=scrNTTEFullAreaGeneratorSnapshot(GameCont),
        _players=scrNTTEFullAreaGeneratorSnapshot(Player),_uber=scrNTTEFullAreaGeneratorSnapshot(UberCont),
        _back=scrNTTEFullAreaGeneratorSnapshot(BackCont),_rng=scrNTTEFullArrayCopy(global.rng_state),
        _seed=random_get_seed(),_frame=current_frame,_stop=lockstep_stop,_skills=ds_list_create(),
        _parked=scrNTTEFullInstances([Floor,Wall,Top,TopSmall,enemy,prop,Portal,FloorExplo,Explosion,NTTEFullFloorReveal])
    scrNTTEFullFloorInit()
    var _style=global.ntte_full_floor_style,_area=global.ntte_full_floor_area,
        _aw=global.ntte_full_floor_aw,_ah=global.ntte_full_floor_ah,_ax=global.ntte_full_floor_ax,_ay=global.ntte_full_floor_ay
    for(var _i=0;_i<array_length(_parked);++_i) instance_deactivate_object(_parked[_i])
    try {
        lockstep_stop=false
        GameCont.area=area_sewers;GameCont.lastarea=area_sewers;GameCont.subarea=1;GameCont.loops=0
        GameCont.ntte_full_active_coast=false;GameCont.crown=Crown.None;GameCont.nochest=0
        GameCont.skills=_skills;GameCont.ntte_full_native_skill_counts={}
        scrNTTEFullFloorResetStyle();scrNTTEFullFloorResetAlign()
        var _modes=["live Dust","particles disabled","underwater Bubble replacement"]
        for(var _mode=0;_mode<array_length(_modes);++_mode) {
            var _baseline=scrNTTEFullInstances(all),_x=320016+_mode*4096,_y=320000
            UberCont.opt_prtcls=(_mode!=1);GameCont.underwater=(_mode==2)
            var _drain=instance_create(_x,_y,NTTEFullSewerDrain)
            _drain.type=WeaponChest
            with(_drain) event_perform(ev_step,ev_step_normal)
            assert(instance_exists(_drain) && instance_exists(_drain.ntte_full_my_floor) && _drain.hp==40,
                "Real Drain first Step failed original floor/40HP setup: "+_modes[_mode])
            var _entrance=_drain.ntte_full_my_floor,_floor_count=instance_number(Floor),
                _chests=instance_number(WeaponChest),_corpses=instance_number(Corpse),
                _dust_count=instance_number(Dust),_bubbles=instance_number(Bubble),
                _clears=instance_number(NTTEFullDrainWallClear)
            _drain.hp=0
            with(_drain) event_perform(ev_step,ev_step_normal)
            assert(!instance_exists(_drain) && instance_exists(_entrance)
                && instance_number(Floor)>_floor_count && instance_number(WeaponChest)==_chests+2
                && instance_number(Corpse)==_corpses+1 && instance_number(NTTEFullDrainWallClear)==_clears+1,
                "Real Drain Step/Destroy did not complete room/entrance/2chests/corpse/wall-clear after Dust: "+_modes[_mode])
            assert((_mode==0 ? instance_number(Dust)>_dust_count:instance_number(Dust)==_dust_count)
                && (_mode==2 ? instance_number(Bubble)>_bubbles:instance_number(Bubble)==_bubbles),
                "Drain fix changed native Dust lifetime or underwater replacement: "+_modes[_mode])
            if(_mode==0) with(Dust) if(array_get_index(_baseline,id)<0)
                assert(abs(image_xscale-1.75)<0.0001 && abs(image_yscale-1.75)<0.0001,
                    "Live Drain room Dust lost source2.5scale multiplier")
            scrNTTESmokeLog("SEWER DRAIN LIFETIME actual Step/Destroy/room completed: "+_modes[_mode])
            scrNTTEFullMergedRuntimeTestCleanup(_baseline)
        }
    }
    finally {
        scrNTTEFullMergedRuntimeTestCleanup(_before)
        for(var _i=0;_i<array_length(_parked);++_i) instance_activate_object(_parked[_i])
        scrNTTEFullAreaGeneratorRestore(_game);scrNTTEFullAreaGeneratorRestore(_players)
        scrNTTEFullAreaGeneratorRestore(_uber);scrNTTEFullAreaGeneratorRestore(_back)
        ds_list_destroy(_skills);global.rng_state=_rng;random_set_seed(_seed);current_frame=_frame;lockstep_stop=_stop
        global.ntte_full_floor_style=_style;global.ntte_full_floor_area=_area
        global.ntte_full_floor_aw=_aw;global.ntte_full_floor_ah=_ah;global.ntte_full_floor_ax=_ax;global.ntte_full_floor_ay=_ay
    }
    scrNTTESmokeLog("FULL SEWER DRAIN LIFETIME: actual Step->Destroy->secret room, native live/off/underwater Dust,2WeaponChests and surviving entrance/corpse/clear, source live-scale retained OK @"+string(30/timescale))
}

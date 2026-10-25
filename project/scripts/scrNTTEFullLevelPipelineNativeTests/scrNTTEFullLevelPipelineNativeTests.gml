// Every effect below is reached through the production GenCont event. No
// replacement stage callbacks, test counters or production-only probes exist.
function scrNTTEFullLevelPipelineFixtureGen(_area,_subarea,_loops,_hard,_crown) {
    GameCont.area=_area;GameCont.subarea=_subarea;GameCont.loops=_loops;GameCont.hard=_hard
    GameCont.crown=_crown;GameCont.gocrib=false;GameCont.noradch=0;GameCont.nochest=0
    GameCont.maxsubarea=scrAreaGetMaxSubarea(_area);GameCont.finalsubarea=(_subarea==GameCont.maxsubarea)
    GameCont.underwater=(_area==scrNTTEFullAreaId("oasis") || _area==scrNTTEFullAreaId("trench"))
    GameCont.ntte_heart_spawn=undefined;GameCont.ntte_visits_loop_red=-1
    GameCont.ntte_crime_bounty=0;GameCont.ntte_crime_active=false;GameCont.ntte_crime_enemy_count=0
    GameCont.ntte_pet_history=[];GameCont.ntte_quest_spawned_part_index_list=[]
    var _keys=["coast","oasis","pizza","lair","trench","red"]
    for(var _i=0;_i<array_length(_keys);++_i) {
        variable_instance_set(GameCont,"ntte_full_active_"+_keys[_i],false)
        variable_instance_set(GameCont,"ntte_active_"+_keys[_i],false)
    }
    with(Player) {race=Race.Fish;wep=wep_revolver;bwep=wep_none;ntte_state=undefined;bntte_state=undefined}
    scrNTTEFullFloorResetStyle();scrNTTEFullFloorResetAlign()
    var _gen=instance_create(0,0,GenCont)
    assert(instance_exists(_gen) && !_gen.ntte_full_sync_generation
        && scrNTTEFullValue(_gen,"ntte_full_events_setup",false),
        "Real pipeline generator missed native source pre-generation event setup or used synchronous bridge")
    return _gen
}
function scrNTTEFullLevelPipelineFixtureFloor() {
    // A controlled genuine population lets the normal Destroy callback be
    // observed without relying on a lucky random map/chest placement.
    instance_destroy(FloorMaker,false);instance_destroy(Floor,false)
    var _tiles=scrNTTEFullFloorFill(10016,10016,15,13)
    for(var _i=0;_i<array_length(_tiles);++_i) with(_tiles[_i]) mcr_floor_make_walls
    return _tiles
}
function scrNTTEFullLevelPipelineFixtureAmmo(_x,_y) {
    // Native AmmoChest.Create may immediately replace itself with a mystery
    // or IDPD box. Select a genuine surviving ordinary constructor outcome;
    // never overwrite its object type or bypass its native initialization.
    for(var _try=0;_try<64;++_try) {
        var _before=scrNTTEFullInstances(all),_chest=instance_create(_x,_y,AmmoChest)
        if(instance_exists(_chest) && _chest.object_index==AmmoChest) return _chest
        scrNTTEFullMergedRuntimeTestCleanup(_before)
    }
    assert(false,"Could not select a genuine ordinary native AmmoChest constructor outcome")
    return noone
}
function scrNTTEFullLevelPipelineNativeTests() {
    assert(scrNTTESmokeEnabled(),"Whole pipeline fixture requires explicit desktop smoke harness")
    var _before=scrNTTEFullInstances(all),_game=scrNTTEFullAreaGeneratorSnapshot(GameCont),
        _players=scrNTTEFullAreaGeneratorSnapshot(Player),_back=scrNTTEFullAreaGeneratorSnapshot(BackCont),
        _uber=scrNTTEFullAreaGeneratorSnapshot(UberCont),_mus=scrNTTEFullAreaGeneratorSnapshot(MusCont),
        _seed=random_get_seed(),_source=scrNTTEFullSourceSeedState(),_tick=current_frame,
        _sync=variable_global_exists("ntte_full_sync_generation")?global.ntte_full_sync_generation:false,
        _tutorial=save_get_value("game","tutorial",true),_progress=global.ntte_full_progress,
        _gameDirectory=game_directory,_scratch=working_directory+"level-pipeline-native-fixture/",
        _parked=scrNTTEFullInstances([Floor,FloorMaker,Wall,InvisiWall,TopSmall,TopPot,Bones,enemy,prop,chestprop,
            WepPickup,RadChest,TopCont,SubTopCont,GenCont,LevCont,NTTEFullWorldEvent,NTTEFullPet,NTTEFullTopObject]),
        _bg=__background_get_colour_element(),_bgcolor=layer_background_get_blend(_bg[0]),
        _vx=view_xview,_vy=view_yview,_skills=GameCont.skills,_fixtureSkills=ds_list_create(),
        _oldHeart=scrNTTEFullValue(GameCont,"ntte_heart_spawn"),
        _oldVisits=scrNTTEFullValue(GameCont,"ntte_visits_loop_red",-1),
        _oldDebt=scrNTTEFullValue(GameCont,"ntte_bigbandit_spawn",0)
    scrNTTEFullWorldEventsInit()
    var _hooks=global.ntte_full_world_event_hooks,
        _bound=variable_global_exists("ntte_full_world_events_native_bound")?global.ntte_full_world_events_native_bound:false,
        _alias=variable_global_exists("ntte_full_player_alias")?global.ntte_full_player_alias:undefined,
        _shrine=variable_global_exists("ntte_full_palace_shrine_skills")?global.ntte_full_palace_shrine_skills:undefined
    directory_create(_scratch);game_directory=_scratch
    global.ntte_full_progress=json_parse(json_stringify(_progress))
    // Preserve an independent physical native skills list throughout the
    // fixture; direct source acquisition cannot mutate the caller's list.
    ds_list_copy(_fixtureSkills,_skills);GameCont.skills=_fixtureSkills
    GameCont.ntte_full_source_seed=scrNTTEFullSourceSeedCopy(_source)
    for(var _i=0;_i<array_length(_parked);++_i) instance_deactivate_object(_parked[_i])
    try {
        global.ntte_full_world_event_hooks={}
        scrNTTEFullWorldEventsNativeBindings(true);global.ntte_full_world_events_native_bound=true
        assert(scrNTTEFullWorldEventsReady(),"Whole pipeline lacks genuine original event dependencies")
        save_set_value("game","tutorial",false);global.ntte_full_sync_generation=false
        UberCont.opt_bossintro=false

        // One uninterrupted real Destroy: early debt/grounded/Crime, natural
        // Desert3 skull, original BlockedRoom chest relocation, Crime chest
        // replacement at that final location, final Trap/Wall repairs.
        var _gen=scrNTTEFullLevelPipelineFixtureGen(area_desert,3,0,5,NTTEFullCrown.Crime)
        scrNTTEFullWorldEventsCleanup();scrNTTEFullLevelPipelineFixtureFloor()
        var _bandit=instance_create(10080,10016,Bandit),_want=instance_create(10016,10016,WantBoss),
            _guitar=scrWeaponPickupCreate(10144,10016,wep_guitar),
            _ammo=scrNTTEFullLevelPipelineFixtureAmmo(10176,10016),_oldSkull=instance_create(10240,10016,BigSkull),
            _trap=instance_create(10512,10320,Trap),_wall=instance_create(11200,11200,Wall)
        GameCont.ntte_bigbandit_spawn=1;GameCont.ntte_crime_bounty=2;GameCont.ntte_crime_active=true
        _wall.depth=0;_trap.solid=true
        var _event=scrNTTEFullWorldEventSet("BlockedRoom",true,_gen);_event.type="Chest"
        with(_gen) event_perform(ev_destroy,0)
        instance_destroy(_gen,false)
        var _ground=noone
        with(NTTEFullWepPickupGrounded) if(target==_guitar) _ground=id
        assert(!instance_exists(_want) && instance_exists(_ground) && instance_exists(_guitar)
            && GameCont.ntte_crime_enemy_count==2 && !GameCont.ntte_crime_active,
            "Whole Destroy pipeline missed early actual WantBoss debt/Grounded binding/Crime bounty schedule")
        assert(!instance_exists(_oldSkull) && instance_exists(NTTEFullCoastBossBecome),
            "Whole Destroy pipeline omitted source Desert3 biome provider")
        var _cat=noone
        with(NTTEFullCatChest) if(x==_event.x && y==_event.y) _cat=id
        assert(_event.ntte_event_generated && array_length(_event.floors)>0 && !instance_exists(_ammo)
            && instance_exists(_cat),
            "Whole Destroy event->Crime ordering lost actual relocated chest's final position or real shop replacement")
        assert(!_trap.solid && _wall.depth==1 && instance_exists(NTTEFullWorldFinalize),
            "Whole Destroy pipeline never reached final Trap/temporary Wall repair after event and chest mutations")
        with(NTTEFullWorldFinalize) event_perform(ev_step,ev_step_begin)
        assert(_wall.depth==0,"Whole pipeline's actual next BeginStep omitted deferred Wall restoration")
        scrNTTEFullMergedRuntimeTestCleanup(_before)

        // Valid source frozen-false case: the initial population consists
        // only of HostileHorror. A genuine later event introduces Maggots.
        // Late SilverTongue/Bonus must retain the original false snapshot.
        _gen=scrNTTEFullLevelPipelineFixtureGen(area_desert,1,0,9,Crown.None)
        scrNTTEFullWorldEventsCleanup();scrNTTEFullLevelPipelineFixtureFloor()
        instance_create(10080,10016,HostileHorror)
        GameCont.nochest=8;GameCont.ntte_heart_spawn={area:area_desert,subarea:1,loops:0}
        scrNTTEFullSkillSet("silver tongue",1)
        var _ordinary=[]
        repeat(24) array_push(_ordinary,scrNTTEFullLevelPipelineFixtureAmmo(10176,10016))
        var _wep=instance_create(10208,10016,WeaponChest)
        _event=scrNTTEFullWorldEventSet("BlockedRoom",true,_gen);_event.type="Maggot"
        assert(instance_number(enemy)==instance_number(HostileHorror),"Frozen-false pipeline did not start with only genuine Horror")
        with(_gen) event_perform(ev_destroy,0)
        instance_destroy(_gen,false)
        assert(_event.ntte_event_generated && instance_number(enemy)>instance_number(HostileHorror)
            && instance_exists(BigMaggot) && is_struct(GameCont.ntte_heart_spawn)
            && !instance_exists(NTTEFullCrystalHeart) && !instance_exists(NTTEFullPetWeaponBecome)
            && !instance_exists(NTTEFullWallCrate),
            "Source frozen normalArea changed after real event enemy creation or early gates consumed heart/mimic guarantee")
        for(var _i=0;_i<array_length(_ordinary);++_i)
            assert(instance_exists(_ordinary[_i]) && _ordinary[_i].bonus_pickup_check==false,
                "Late Bonus conversion recomputed normalArea after genuine event enemy births")
        scrNTTEFullSkillSet("silver tongue",0)
        scrNTTEFullMergedRuntimeTestCleanup(_before)

        // The Bonus crown overrides normal/hard gates even for Horror-only
        // final populations; this reaches the same genuine canonical tail.
        _gen=scrNTTEFullLevelPipelineFixtureGen(area_labs,1,1,1,NTTEFullCrown.Bonus)
        scrNTTEFullWorldEventsCleanup();scrNTTEFullLevelPipelineFixtureFloor()
        instance_create(10080,10016,HostileHorror)
        var _health=instance_create(10176,10016,HealthChest),_ammo=scrNTTEFullLevelPipelineFixtureAmmo(10240,10016)
        with(_gen) event_perform(ev_destroy,0)
        instance_destroy(_gen,false)
        assert(!instance_exists(_health) && !instance_exists(_ammo) && instance_exists(NTTEFullBonusHealthChest)
            && instance_exists(NTTEFullBonusAmmoChest),"Whole source Bonus crown tail lost normal-independent distinct Health/Ammo replacements")
        scrNTTEFullMergedRuntimeTestCleanup(_before)

        // Red ammo production is driven by either actual weapon slot rather
        // than the selected crown; actual Caves biome also replaces Bandit.
        _gen=scrNTTEFullLevelPipelineFixtureGen(area_caves,2,0,5,Crown.None)
        scrNTTEFullWorldEventsCleanup();scrNTTEFullLevelPipelineFixtureFloor()
        var _bandit=instance_create(10144,10016,Bandit),_rad=instance_create(10176,10016,RadChest)
        with(Player) bwep=wep_ntte_annihilator
        with(_gen) event_perform(ev_destroy,0)
        instance_destroy(_gen,false)
        assert(!instance_exists(_bandit) && instance_exists(NTTEFullMinerBandit) && !instance_exists(_rad)
            && instance_exists(NTTEFullRedAmmoChest),"Whole Caves biome->Red initial-chest chain lost actual Miner/secondary-slot Rad conversion")
        scrNTTEFullMergedRuntimeTestCleanup(_before)

        // Full normal Create->Alarm2->Alarm0->Alarm1->Destroy for all six
        // authored custom areas. Real production builders, populations,
        // events and the entire canonical tail execute without sync bridges.
        var _areas=["coast","oasis","pizza","lair","trench","red"]
        for(var _i=0;_i<array_length(_areas);++_i) {
            var _key=_areas[_i],_subarea=_key=="trench"?3:1
            scrNTTEFullSourceRandomSeed(1351+_i*100)
            _gen=scrNTTEFullLevelPipelineFixtureGen(scrNTTEFullAreaId(_key),_subarea,0,9,Crown.None)
            assert(instance_number(Floor)>20 && !instance_exists(FloorMaker),
                "Actual complete custom Create failed authored floor topology: "+_key)
            with(_gen) event_perform(ev_alarm,2)
            with(_gen) event_perform(ev_alarm,0)
            assert(instance_number(enemy)>0 && (_key=="coast" || instance_number(TopSmall)>0),
                "Actual custom Alarm0 failed authored population or terrain products: "+_key)
            with(_gen) event_perform(ev_alarm,1)
            assert(!instance_exists(_gen) && instance_number(TopCont)==1 && instance_number(SubTopCont)==1
                && scrNTTEFullValue(GameCont,"ntte_full_active_"+_key,false),
                "Complete normal custom lifecycle failed area_start/canonical tail or duplicated controllers: "+_key)
            var _events=scrNTTEFullWorldEventGet(all)
            for(var _j=0;_j<array_length(_events);++_j)
                assert(_events[_j].ntte_event_generated,"Natural pre-generation event was not generated by complete native lifecycle: "+_key)
            if(_key=="trench") {
                var _octo=noone
                with(NTTEFullPet) if(pet=="Octo") _octo=id
                assert(instance_exists(NTTEFullPitSquid) && instance_exists(_octo) && _octo.hiding,
                    "Complete Trench source area_start omitted true third-subarea boss or hiding Octo")
            }
            if(_key=="red") assert(instance_exists(NTTEFullWarp) && instance_exists(NTTEFullWallFake),
                "Complete Red native chain omitted actual Warp or secret hallway")
            scrNTTESmokeLog("FULL CANONICAL CUSTOM PIPELINE "+_key+" actual Create/Alarm2/Alarm0/Alarm1/Destroy OK")
            scrNTTEFullMergedRuntimeTestCleanup(_before)
        }
    }
    finally {
        scrNTTEFullMergedRuntimeTestCleanup(_before)
        for(var _i=0;_i<array_length(_parked);++_i) instance_activate_object(_parked[_i])
        GameCont.skills=_skills;if(ds_exists(_fixtureSkills,ds_type_list)) ds_list_destroy(_fixtureSkills)
        scrNTTEFullAreaGeneratorRestore(_game);scrNTTEFullAreaGeneratorRestore(_players)
        scrNTTEFullAreaGeneratorRestore(_back);scrNTTEFullAreaGeneratorRestore(_uber);scrNTTEFullAreaGeneratorRestore(_mus)
        GameCont.ntte_heart_spawn=_oldHeart;GameCont.ntte_visits_loop_red=_oldVisits;GameCont.ntte_bigbandit_spawn=_oldDebt
        GameCont.ntte_full_source_seed=_source;random_set_seed(_seed);current_frame=_tick
        save_set_value("game","tutorial",_tutorial);global.ntte_full_sync_generation=_sync
        global.ntte_full_world_event_hooks=_hooks;global.ntte_full_world_events_native_bound=_bound
        global.ntte_full_player_alias=_alias;global.ntte_full_palace_shrine_skills=_shrine
        global.ntte_full_progress=_progress
        var _files=[_scratch+"ntte-full-progress.json",_scratch+"ntte-full-progress.json.bak",_scratch+"ntte-full-progress.json.tmp"]
        for(var _i=0;_i<array_length(_files);++_i) if(file_exists(_files[_i])) file_delete(_files[_i])
        game_directory=_gameDirectory
        layer_background_blend(_bg[0],_bgcolor);view_xview=_vx;view_yview=_vy
    }
    scrNTTESmokeLog("FULL CANONICAL PIPELINE: actual early->Desert->event chest relocation->Crime->finalize chain, Horror-only frozen snapshot through real Maggot event, Bonus crown and Caves->Red slot chains, all6actual normal custom area lifecycles OK @"+string(30/timescale))
}

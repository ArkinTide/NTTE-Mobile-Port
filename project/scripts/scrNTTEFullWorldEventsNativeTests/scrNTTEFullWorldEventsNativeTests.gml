function scrNTTEFullWorldEventsFixtureAreaCleanup() {
    // The genuine desktop smoke driver inherits damagesource. The real area
    // cleanup must remove that gameplay family, but must not delete its caller
    // and silently stop the next 60/120 passes after a successful 30 pass.
    var _runners=scrNTTEFullInstances(NTTESmokeTest)
    for(var _i=0;_i<array_length(_runners);++_i) instance_deactivate_object(_runners[_i])
    try {scrCleanupAreaInstances()}
    finally {
        for(var _i=0;_i<array_length(_runners);++_i) instance_activate_object(_runners[_i])
    }
    for(var _i=0;_i<array_length(_runners);++_i)
        assert(instance_exists(_runners[_i]),"Actual area cleanup destroyed the desktop test driver")
}

function scrNTTEFullWorldEventsNativeTests() {
    scrNTTEFullFloorInit()
    var _before=scrNTTEFullInstances(all),_game=scrNTTEFullAreaGeneratorSnapshot(GameCont),
        _players=scrNTTEFullAreaGeneratorSnapshot(Player),_back=scrNTTEFullAreaGeneratorSnapshot(BackCont),
        _uber=scrNTTEFullAreaGeneratorSnapshot(UberCont),_mus=scrNTTEFullAreaGeneratorSnapshot(MusCont),
        _seed=random_get_seed(),_source=scrNTTEFullSourceSeedState(),_tick=current_frame,
        _sync=variable_global_exists("ntte_full_sync_generation")?global.ntte_full_sync_generation:false,
        _tutorial=save_get_value("game","tutorial",true),
        _parked=scrNTTEFullInstances([Floor,FloorMaker,Wall,TopSmall,Bones,enemy,prop,chestprop,RadChest,
            TopCont,SubTopCont,GenCont,NTTEFullWorldEvent,NTTEFullPet,NTTEFullSludgePool,NTTEFullTopObject]),
        _bg=__background_get_colour_element(),_bgcolor=layer_background_get_blend(_bg[0]),
        _floor_state=[global.ntte_full_floor_style,global.ntte_full_floor_area,
            global.ntte_full_floor_aw,global.ntte_full_floor_ah,global.ntte_full_floor_ax,global.ntte_full_floor_ay],
        _native_rng=array_create(array_length(global.rng_state)),_alarms=[],
        _view_x=view_xview,_view_y=view_yview,_camera=view_camera[0],
        _camera_x=camera_get_view_x(_camera),_camera_y=camera_get_view_y(_camera)
    array_copy(_native_rng,0,global.rng_state,0,array_length(global.rng_state))
    var _alarm_owners=scrNTTEFullInstances([GameCont,Player,BackCont,UberCont,MusCont])
    for(var _i=0;_i<array_length(_alarm_owners);++_i) with(_alarm_owners[_i]) {
        var _values=[]
        for(var _j=0;_j<12;++_j) array_push(_values,alarm[_j])
        array_push(_alarms,[id,_values])
    }
    scrNTTEFullWorldEventsInit()
    var _hooks=global.ntte_full_world_event_hooks,
        _bound_exists=variable_global_exists("ntte_full_world_events_native_bound"),
        _bound=_bound_exists?global.ntte_full_world_events_native_bound:false,
        _alias_exists=variable_global_exists("ntte_full_player_alias"),
        _alias=_alias_exists?global.ntte_full_player_alias:undefined,
        _skills_exists=variable_global_exists("ntte_full_palace_shrine_skills"),
        _skills=_skills_exists?global.ntte_full_palace_shrine_skills:undefined
    GameCont.ntte_full_source_seed=scrNTTEFullSourceSeedCopy(_source)
    for(var _i=0;_i<array_length(_parked);++_i) instance_deactivate_object(_parked[_i])
    try {
        // Harness certification only: actual source callbacks for every name.
        // This isolated registry is restored; it does not release production.
        global.ntte_full_world_event_hooks={}
        scrNTTEFullWorldEventsNativeBindings(true)
        global.ntte_full_world_events_native_bound=true
        assert(scrNTTEFullWorldEventsReady(),"Actual event lifecycle prerequisites are missing: "+string(scrNTTEFullWorldEventsMissing()))
        GameCont.loops=0;GameCont.subarea=2;GameCont.hard=5;GameCont.gocrib=false
        GameCont.crown=Crown.None;GameCont.underwater=false;UberCont.opt_bossintro=false
        save_set_value("game","tutorial",false);global.ntte_full_sync_generation=true
        // Original shuffled-with break selects one distant Floor, even when
        // several eligible distant candidates survive. A for/with translation
        // must break the scan rather than only the inner with statement.
        GameCont.area=scrNTTEFullAreaId("trench")
        instance_create(10000,10000,Floor)
        instance_create(10320,10000,Floor);instance_create(10000,10320,Floor);instance_create(9680,10000,Floor)
        // Native Gator.Create can replace itself with the real BuffGator at
        // hard5. Count that source-preserving constructor promotion as one.
        var _gators=instance_number(Gator)+instance_number(BuffGator)
        scrNTTEFullSeaCreatureEvent(10016,10016)
        assert(instance_number(Gator)+instance_number(BuffGator)==_gators+1,"Source SeaCreature must select exactly one distant Gator Floor")
        scrNTTEFullMergedRuntimeTestCleanup(_before)
        var _names=scrNTTEFullWorldEventOrder(),_source_count=array_length(_names),
            _blocked_types=["Chest","Scorpion","Skull","Dummy"]
        repeat(array_length(_blocked_types)) array_push(_names,"BlockedRoom")
        for(var _i=0;_i<array_length(_names);++_i) {
            var _name=_names[_i],_area=scrNTTEFullWorldEventArea(_name),_case_seed=4823+_i,_case_started=get_timer()
            scrNTTESmokeLog("WORLD EVENT LIFECYCLE BEGIN "+_name+" index="+string(_i)+" @"+string(30/timescale))
            scrNTTESmokeLog("WORLD EVENT LIFECYCLE INPUT "+json_stringify({event:_name,index:_i,rate:30/timescale,
                seed:_case_seed,entryRandom:random_get_seed(),entryGeneration:global.rng_state[RNGStates.Generation],
                entryLevseed:GameCont.levseed,all:instance_number(all),floors:instance_number(Floor),walls:instance_number(Wall),
                tops:instance_number(TopSmall),details:instance_number(Detail),enemies:instance_number(enemy),
                props:instance_number(prop),players:instance_number(Player)}))
            GameCont.area=is_undefined(_area)?area_vault:_area
            GameCont.subarea=2;GameCont.ntte_pet_history=[]
            scrNTTEFullFloorResetStyle();scrNTTEFullFloorResetAlign()
            // GenCont.Create seeds native terrain from Generation; Destroy
            // separately seeds population from levseed. Fix both fixture
            // inputs, not merely the RNG that Create immediately overwrites.
            // Their original values are already covered by the outer native
            // RNG copy and GameCont snapshot/finally restoration.
            global.rng_state[@ RNGStates.Generation]=_case_seed
            GameCont.levseed=_case_seed;random_set_seed(_case_seed)
            // Real Create installs source pre-generation callbacks and marks
            // this actual GenCont. Remove random encounters before the forced
            // individual callback fixture; their chance rules are separately
            // checked by the original manager and rules fixtures.
            var _gen=instance_create(0,0,GenCont)
            scrNTTESmokeLog("WORLD EVENT LIFECYCLE CREATED "+json_stringify({event:_name,
                elapsedMs:(get_timer()-_case_started)/1000,random:random_get_seed(),
                generation:global.rng_state[RNGStates.Generation],levseed:GameCont.levseed,
                all:instance_number(all),floors:instance_number(Floor),walls:instance_number(Wall)}))
            assert(variable_instance_exists(_gen,"ntte_full_events_setup"),
                "Actual GenCont.Create did not run original event setup: "+_name)
            scrNTTEFullWorldEventsCleanup()
            instance_destroy(FloorMaker,false);instance_destroy(Floor,false)
            var _tiles=scrNTTEFullFloorFill(10016,10016,11,9)
            for(var _t=0;_t<array_length(_tiles);++_t) with(_tiles[_t]) mcr_floor_make_walls;
            instance_create(10016,10016,Bandit)
            var _event=scrNTTEFullWorldEventSet(_name,true,_gen)
            if(_name=="BlockedRoom") {
                _event.type=_i<_source_count?"Maggot":_blocked_types[_i-_source_count]
                // Real GenCont.Destroy creates PortalClear on the player at
                // 10016,10016. Source Chest explicitly rejects that mask;
                // use an actual floor96pixels away for an eligible chest.
                if(_event.type=="Chest") instance_create(10112,10016,AmmoChest)
            }
            var _case_label=_name+(_name=="BlockedRoom"?"/"+_event.type:"")
            assert(instance_exists(_event) && !_event.ntte_event_generated && !_event.ntte_event_cleanup_done,
                "Actual event setup prematurely generated or cleaned its controller: "+_name)
            if(_name=="FirePit") assert(_event.ntte_firepit_steam_bound,"Actual FirePit setup omitted rain binding")
            // Source stage is after all genuine ordinary-biome providers.
            var _destroy_started=get_timer()
            scrNTTESmokeLog("WORLD EVENT LIFECYCLE DESTROY BEGIN "+_case_label+" "+json_stringify({
                elapsedMs:(_destroy_started-_case_started)/1000,random:random_get_seed(),
                generation:global.rng_state[RNGStates.Generation],levseed:GameCont.levseed,
                all:instance_number(all),floors:instance_number(Floor),walls:instance_number(Wall),
                tops:instance_number(TopSmall),details:instance_number(Detail),enemies:instance_number(enemy)}))
            with(_gen) event_perform(ev_destroy,0)
            instance_destroy(_gen,false)
            scrNTTESmokeLog("WORLD EVENT LIFECYCLE DESTROY END "+_case_label+" "+json_stringify({
                destroyMs:(get_timer()-_destroy_started)/1000,elapsedMs:(get_timer()-_case_started)/1000,
                random:random_get_seed(),all:instance_number(all),floors:instance_number(Floor),walls:instance_number(Wall),
                tops:instance_number(TopSmall),details:instance_number(Detail),enemies:instance_number(enemy)}))
            assert(instance_exists(_event) && _event.ntte_event_generated,
                "Actual native GenCont.Destroy failed to generate original event: "+_name)
            if(_name=="BlockedRoom") switch(_event.type) {
                case "Maggot":assert(instance_number(BigMaggot)>=3 && instance_number(Maggot)>=6,
                    "Actual BlockedRoom Maggot lifecycle omitted source population");break
                case "Scorpion":assert(instance_exists(NTTEFullBabyScorpionGold),
                    "Actual BlockedRoom Scorpion lifecycle omitted original baby gold scorpion");break
                case "Skull":assert(instance_exists(NTTEFullCowSkull) || instance_exists(NTTEFullCoastBossBecome),
                    "Actual BlockedRoom Skull lifecycle omitted original skull/Coast boss owner");break
                case "Dummy":assert(instance_exists(TutorialTarget),
                    "Actual BlockedRoom Dummy lifecycle omitted real TutorialTarget");break
                case "Chest":
                    var _held=false,_chest_diag=[]
                    with(chestprop) array_push(_chest_diag,[object_get_name(object_index),x,y,scrNTTEFullValue(id,"ntte_full_top_object",noone)])
                    with(RadChest) array_push(_chest_diag,[object_get_name(object_index),x,y])
                    with(chestprop) if(x==_event.x && y==_event.y) _held=true
                    with(RadChest) if(x==_event.x && y==_event.y) _held=true
                    assert(_held,"Actual BlockedRoom Chest lifecycle failed to relocate a genuine eligible chest into its room: event="+string([_event.x,_event.y])+" chests="+string(_chest_diag))
                    break
            }
            switch(_name) {
                case "PopoAmbush":assert(instance_exists(NTTEFullBigIDPDSpawn),"Actual PopoAmbush omitted native delayed spawn");break
                case "SeaCreature":assert(instance_exists(NTTEFullCreature),"Actual SeaCreature omitted real distant Creature");break
                case "BuriedVault":assert(instance_exists(NTTEFullBuriedVault),"Actual BuriedVault event omitted real excavation controller");break
                case "SewerPool":assert(instance_exists(NTTEFullSludgePool),"Actual SewerPool omitted real SludgePool");break
                default:assert(array_length(_event.floors)>0 || _name=="PalaceShrine",
                    "Actual original event did not attribute any surviving generated floors: "+_name);break
            }
            var _floor_count=instance_number(Floor),_all_count=instance_number(all)
            scrNTTEFullWorldEventsGenerate()
            assert(instance_number(Floor)==_floor_count && instance_number(all)==_all_count,
                "Actual original event generated twice: "+_name)
            with(_event) {scrNTTEFullWorldEventCleanup();scrNTTEFullWorldEventCleanup()}
            assert(_event.ntte_event_cleanup_done,"Actual original event cleanup was not idempotent: "+_name)
            if(_name=="FirePit") assert(!_event.ntte_firepit_steam_bound,"Actual FirePit cleanup retained native rain binding")
            scrNTTEFullWorldEventsFixtureAreaCleanup()
            assert(!instance_exists(_event) && !instance_exists(NTTEFullWorldEvent),
                "Actual area cleanup leaked parentless original event controller: "+_name)
            scrNTTESmokeLog("WORLD EVENT NATURAL LIFECYCLE "+_case_label+" actual native setup/generate/cleanup OK")
            scrNTTEFullMergedRuntimeTestCleanup(_before)
            scrNTTESmokeLog("WORLD EVENT LIFECYCLE FINISH "+_case_label+" "+json_stringify({
                elapsedMs:(get_timer()-_case_started)/1000,all:instance_number(all),floors:instance_number(Floor),
                walls:instance_number(Wall),tops:instance_number(TopSmall),details:instance_number(Detail),enemies:instance_number(enemy)}))
        }
    }
    finally {
        scrNTTEFullMergedRuntimeTestCleanup(_before)
        for(var _i=0;_i<array_length(_parked);++_i) instance_activate_object(_parked[_i])
        scrNTTEFullAreaGeneratorRestore(_game);scrNTTEFullAreaGeneratorRestore(_players)
        scrNTTEFullAreaGeneratorRestore(_back);scrNTTEFullAreaGeneratorRestore(_uber);scrNTTEFullAreaGeneratorRestore(_mus)
        GameCont.ntte_full_source_seed=_source;random_set_seed(_seed);current_frame=_tick
        save_set_value("game","tutorial",_tutorial);global.ntte_full_sync_generation=_sync
        layer_background_blend(_bg[0],_bgcolor)
        global.ntte_full_world_event_hooks=_hooks
        global.ntte_full_world_events_native_bound=_bound
        global.ntte_full_player_alias=_alias
        global.ntte_full_palace_shrine_skills=_skills
        scrNTTEFullFloorSetStyle(_floor_state[0],_floor_state[1])
        scrNTTEFullFloorSetAlign(_floor_state[2],_floor_state[3],_floor_state[4],_floor_state[5])
        array_copy(global.rng_state,0,_native_rng,0,array_length(_native_rng))
        for(var _i=0;_i<array_length(_alarms);++_i) {
            var _owner=_alarms[_i][0],_values=_alarms[_i][1]
            if(instance_exists(_owner)) with(_owner)
                for(var _j=0;_j<12;++_j) alarm[_j]=_values[_j]
        }
        view_xview=_view_x;view_yview=_view_y
        camera_set_view_pos(_camera,_camera_x,_camera_y)
    }
    scrNTTESmokeLog("FULL WORLD EVENT NATIVE LIFECYCLE all16 + all5BlockedRoom types / real GenCont Create+Destroy / one generation / original FirePit rain cleanup / actual area cleanup / harness registry restored OK @"+string(30/timescale))
}

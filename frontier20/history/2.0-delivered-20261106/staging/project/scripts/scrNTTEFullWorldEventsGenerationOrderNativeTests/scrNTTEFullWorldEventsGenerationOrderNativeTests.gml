// Observers wrap the genuine Trench and GatorAmbush callbacks; they do not
// substitute a builder, event implementation or forced event selection.
function scrNTTEFullWorldEventsOrderObserveAreaSetup() {
    array_push(global.ntte_full_event_order_trace,"area.setup")
    scrNTTEFullTrenchSetupNative()
    assert(goal==150 && safespawn>0,"Real Trench setup did not establish its source goal/safe-spawn before event eligibility")
}
function scrNTTEFullWorldEventsOrderObserveEventSetup() {
    var _gen=instance_find(GenCont,0)
    assert(_gen.goal==150,"Natural GatorAmbush setup ran before real Trench setup")
    array_push(global.ntte_full_event_order_trace,"event.setup")
    scrNTTEFullGatorAmbushSetup()
    assert(_gen.goal==135,"Natural GatorAmbush did not apply original90percent goal to real Trench150")
}
function scrNTTEFullWorldEventsOrderObserveFloors() {
    assert(array_equals(global.ntte_full_event_order_trace,["area.setup","event.setup"]),
        "Eager custom floors began before source area/event setup, or a setup callback ran twice")
    assert(goal==135 && instance_exists(scrNTTEFullWorldEventGet("GatorAmbush")),
        "Real Trench builder did not receive naturally selected GatorAmbush's reduced source goal")
    array_push(global.ntte_full_event_order_trace,"floors")
    scrNTTEFullTrenchBuildNative()
    assert(instance_number(Floor)>20,"Observed Trench floor callback did not execute its real topology")
}
function scrNTTEFullWorldEventsGenerationOrderNativeTests() {
    scrNTTEFullFloorInit();scrNTTEFullWorldEventsInit();scrNTTEFullAreaNativeInit()
    var _before=scrNTTEFullInstances(all),_game=scrNTTEFullAreaGeneratorSnapshot(GameCont),
        _players=scrNTTEFullAreaGeneratorSnapshot(Player),_back=scrNTTEFullAreaGeneratorSnapshot(BackCont),
        _uber=scrNTTEFullAreaGeneratorSnapshot(UberCont),_mus=scrNTTEFullAreaGeneratorSnapshot(MusCont),
        _seed=random_get_seed(),_tick=current_frame,_progress=global.ntte_full_progress,
        _hooks=global.ntte_full_world_event_hooks,_builders=global.ntte_full_area_generators,
        _bound=variable_global_exists("ntte_full_world_events_native_bound")?global.ntte_full_world_events_native_bound:false,
        _alias=variable_global_exists("ntte_full_player_alias")?global.ntte_full_player_alias:undefined,
        _skills=variable_global_exists("ntte_full_palace_shrine_skills")?global.ntte_full_palace_shrine_skills:undefined,
        _sync=variable_global_exists("ntte_full_sync_generation")?global.ntte_full_sync_generation:false,
        _trace=variable_global_exists("ntte_full_event_order_trace")?global.ntte_full_event_order_trace:undefined,
        _tutorial=save_get_value("game","tutorial",true),_rng=array_create(array_length(global.rng_state)),_alarms=[],
        _floor_state=[global.ntte_full_floor_style,global.ntte_full_floor_area,
            global.ntte_full_floor_aw,global.ntte_full_floor_ah,global.ntte_full_floor_ax,global.ntte_full_floor_ay],
        _view_x=view_xview,_view_y=view_yview,_camera=view_camera[0],
        _camera_x=camera_get_view_x(_camera),_camera_y=camera_get_view_y(_camera),
        _bg=__background_get_colour_element(),_bgcolor=layer_background_get_blend(_bg[0]),
        _parked=scrNTTEFullInstances([Floor,FloorMaker,Wall,TopSmall,Bones,enemy,prop,chestprop,RadChest,
            TopCont,SubTopCont,GenCont,NTTEFullWorldEvent,NTTEFullPet,NTTEFullSludgePool,NTTEFullTopObject])
    array_copy(_rng,0,global.rng_state,0,array_length(global.rng_state))
    var _owners=scrNTTEFullInstances([GameCont,Player,BackCont,UberCont,MusCont])
    for(var _i=0;_i<array_length(_owners);++_i) with(_owners[_i]) {
        var _values=[]
        for(var _j=0;_j<12;++_j) array_push(_values,alarm[_j])
        array_push(_alarms,[id,_values])
    }
    for(var _i=0;_i<array_length(_parked);++_i) instance_deactivate_object(_parked[_i])
    try {
        global.ntte_full_progress=json_parse(json_stringify(_progress))
        global.ntte_full_world_event_hooks={};scrNTTEFullWorldEventsNativeBindings(true)
        global.ntte_full_world_events_native_bound=true
        var _gator=variable_struct_get(global.ntte_full_world_event_hooks,"GatorAmbush")
        _gator.setup=scrNTTEFullWorldEventsOrderObserveEventSetup
        global.ntte_full_area_generators={}
        var _keys=variable_struct_get_names(_builders)
        for(var _i=0;_i<array_length(_keys);++_i)
            variable_struct_set(global.ntte_full_area_generators,_keys[_i],variable_struct_get(_builders,_keys[_i]))
        var _trench=variable_struct_get(_builders,string(scrNTTEFullAreaId("trench")))
        variable_struct_set(global.ntte_full_area_generators,string(scrNTTEFullAreaId("trench")),{
            make_floor:scrNTTEFullWorldEventsOrderObserveFloors,setup:scrNTTEFullWorldEventsOrderObserveAreaSetup,
            populate:_trench.populate,start:_trench.start})
        save_set_value("game","tutorial",false)
        for(var _mode=0;_mode<2;++_mode) {
            scrNTTEFullAreaGeneratorRestore(_game);scrNTTEFullAreaGeneratorRestore(_players)
            GameCont.area=scrNTTEFullAreaId("trench");GameCont.subarea=2;GameCont.loops=0
            GameCont.maxsubarea=scrAreaGetMaxSubarea(GameCont.area);GameCont.finalsubarea=false
            GameCont.hard=5;GameCont.crown=Crown.None;GameCont.gocrib=false;GameCont.ntte_crime_bounty=3
            GameCont.ntte_full_source_seed=scrNTTEFullSourceSeedBuild(615381)
            GameCont.ntte_full_source_pending_generation=undefined
            global.ntte_full_event_order_trace=[];global.ntte_full_sync_generation=false
            if(_mode==0) {
                var _gen=instance_create(0,0,GenCont)
                scrNTTEFullPetEffectGenerationSafetyTests()
                assert(!_gen.ntte_full_sync_generation && _gen.ntte_full_area_prepared,
                    "Normal real GenCont did not use the split asynchronous prepare/build path")
            }
            else scrNTTEFullAreaGenerateNative(GameCont.area,2,0,10016,10016,false,0)
            assert(array_equals(global.ntte_full_event_order_trace,["area.setup","event.setup","floors"]),
                "Real async/sync generation duplicated or misordered area/event setup: "+string(global.ntte_full_event_order_trace))
            scrNTTESmokeLog("WORLD GENERATION ORDER "+(_mode==0?"async Create":"actual synchronous AreaGenerateNative")
                +" real Trench150 -> natural GatorAmbush135 -> real floor builder OK")
            scrNTTEFullMergedRuntimeTestCleanup(_before)
        }
    }
    finally {
        scrNTTEFullMergedRuntimeTestCleanup(_before)
        for(var _i=0;_i<array_length(_parked);++_i) instance_activate_object(_parked[_i])
        scrNTTEFullAreaGeneratorRestore(_game);scrNTTEFullAreaGeneratorRestore(_players)
        scrNTTEFullAreaGeneratorRestore(_back);scrNTTEFullAreaGeneratorRestore(_uber);scrNTTEFullAreaGeneratorRestore(_mus)
        global.ntte_full_progress=_progress;global.ntte_full_world_event_hooks=_hooks;global.ntte_full_area_generators=_builders
        global.ntte_full_world_events_native_bound=_bound;global.ntte_full_player_alias=_alias
        global.ntte_full_palace_shrine_skills=_skills;global.ntte_full_sync_generation=_sync;global.ntte_full_event_order_trace=_trace
        save_set_value("game","tutorial",_tutorial);array_copy(global.rng_state,0,_rng,0,array_length(_rng))
        scrNTTEFullFloorSetStyle(_floor_state[0],_floor_state[1])
        scrNTTEFullFloorSetAlign(_floor_state[2],_floor_state[3],_floor_state[4],_floor_state[5])
        for(var _i=0;_i<array_length(_alarms);++_i) {
            var _owner=_alarms[_i][0],_values=_alarms[_i][1]
            if(instance_exists(_owner)) with(_owner) for(var _j=0;_j<12;++_j) alarm[_j]=_values[_j]
        }
        view_xview=_view_x;view_yview=_view_y;camera_set_view_pos(_camera,_camera_x,_camera_y)
        layer_background_blend(_bg[0],_bgcolor);current_frame=_tick;random_set_seed(_seed)
    }
    scrNTTESmokeLog("FULL WORLD GENERATION ORDER actual async/sync custom setup/event setup/floors/goal135/one setup OK @"+string(30/timescale))
}

// Separate native setup acceptance: real GenCont.Create chooses its own events.
// No forced EventSet, fake callbacks, generation replacement or certification.
// This closes selection coverage only; live multi-frame gameplay is separate.
function scrNTTEFullWorldEventsNaturalSelectionNativeTests() {
    scrNTTEFullFloorInit();scrNTTEFullWorldEventsInit()
    var _before=scrNTTEFullInstances(all),_game=scrNTTEFullAreaGeneratorSnapshot(GameCont),
        _players=scrNTTEFullAreaGeneratorSnapshot(Player),_back=scrNTTEFullAreaGeneratorSnapshot(BackCont),
        _uber=scrNTTEFullAreaGeneratorSnapshot(UberCont),_mus=scrNTTEFullAreaGeneratorSnapshot(MusCont),
        _seed=random_get_seed(),_tick=current_frame,_progress=global.ntte_full_progress,
        _hooks=global.ntte_full_world_event_hooks,
        _bound=variable_global_exists("ntte_full_world_events_native_bound")?global.ntte_full_world_events_native_bound:false,
        _alias=variable_global_exists("ntte_full_player_alias")?global.ntte_full_player_alias:undefined,
        _skills=variable_global_exists("ntte_full_palace_shrine_skills")?global.ntte_full_palace_shrine_skills:undefined,
        _sync=variable_global_exists("ntte_full_sync_generation")?global.ntte_full_sync_generation:false,
        _tutorial=save_get_value("game","tutorial",true),
        _rng=array_create(array_length(global.rng_state)),_alarm_state=[],
        _floor_state=[global.ntte_full_floor_style,global.ntte_full_floor_area,
            global.ntte_full_floor_aw,global.ntte_full_floor_ah,global.ntte_full_floor_ax,global.ntte_full_floor_ay],
        _view_x=view_xview,_view_y=view_yview,_camera=view_camera[0],
        _camera_x=camera_get_view_x(_camera),_camera_y=camera_get_view_y(_camera),
        _bg=__background_get_colour_element(),_bgcolor=layer_background_get_blend(_bg[0]),
        _parked=scrNTTEFullInstances([Floor,FloorMaker,Wall,TopSmall,Bones,enemy,prop,chestprop,RadChest,
            TopCont,SubTopCont,GenCont,NTTEFullWorldEvent,NTTEFullPet,NTTEFullSludgePool,NTTEFullTopObject]),
        _identity=scr_playerinstance_find(0),_name=is_undefined(_identity)?"":_identity.name
    array_copy(_rng,0,global.rng_state,0,array_length(global.rng_state))
    var _alarm_owners=scrNTTEFullInstances([GameCont,Player,BackCont,UberCont,MusCont])
    for(var _i=0;_i<array_length(_alarm_owners);++_i) with(_alarm_owners[_i]) {
        var _values=[]
        for(var _j=0;_j<12;++_j) array_push(_values,alarm[_j])
        array_push(_alarm_state,[id,_values])
    }
    for(var _i=0;_i<array_length(_parked);++_i) instance_deactivate_object(_parked[_i])
    try {
        global.ntte_full_progress=json_parse(json_stringify(_progress))
        variable_struct_set(global.ntte_full_progress.unlocks,"crown:crime",true)
        variable_struct_set(global.ntte_full_progress.unlocks,"pack:coast",true)
        variable_struct_set(global.ntte_full_progress.unlocks,"pack:trench",true)
        global.ntte_full_world_event_hooks={};scrNTTEFullWorldEventsNativeBindings(true)
        global.ntte_full_world_events_native_bound=true;global.ntte_full_sync_generation=true
        save_set_value("game","tutorial",false)
        if(!is_undefined(_identity)) _identity.name="blaac"
        GameCont.loops=0;GameCont.hard=5;GameCont.crown=Crown.None;GameCont.gocrib=false
        GameCont.ntte_crime_bounty=3
        GameCont.ntte_pet_history=[["Scorpion","mod","petlib",{bskin:0,scorpion_city:0}]]
        GameCont.popolevel=15;GameCont.heavyheart=0
        with(Player) {wep=wep_revolver;bwep=wep_none}
        var _pet=scrNTTEFullPetCreate(10016,10016,"Scorpion")
        _pet.scorpion_city=1
        var _fixture_before=scrNTTEFullInstances(all),_seen=[],_order=scrNTTEFullWorldEventOrder(),
            _profiles=[
                [area_desert,2,["BlockedRoom","GatorAmbush","MaggotPark","ScorpionCity","BanditCamp","BuriedVault"]],
                [area_sewers,2,["GatorDen","SewerPool"]],
                [area_scrapyards,2,["RavenArena","FirePit"]],
                [area_city,2,["SealPlaza"]],[area_labs,2,["MutantVats"]],
                [area_palace,1,["PopoAmbush"]],[area_palace,2,["PalaceShrine"]],
                [scrNTTEFullAreaId("coast"),2,["SeaCreature"]],
                [scrNTTEFullAreaId("trench"),2,["EelGrave"]]]
        for(var _p=0;_p<array_length(_profiles);++_p) {
            var _profile=_profiles[_p],_need=_profile[2],_done=false
            GameCont.area=_profile[0];GameCont.subarea=_profile[1]
            for(var _attempt=1;_attempt<=512 && !_done;++_attempt) {
                var _case_seed=100003+_p*1009+_attempt
                global.rng_state[@RNGStates.Generation]=_case_seed
                GameCont.ntte_full_source_seed=scrNTTEFullSourceSeedBuild(_case_seed)
                GameCont.ntte_full_source_pending_generation=undefined
                GameCont.levseed=_case_seed;GameCont.ntte_crime_bounty=3
                GameCont.ntte_pet_history=[["Scorpion","mod","petlib",{bskin:0,scorpion_city:0}]]
                _pet.scorpion_city=1
                var _gen=instance_create(0,0,GenCont),_events=scrNTTEFullWorldEventGet(all),
                    _selected=[],_previous=-1,_first_tip=""
                assert(variable_instance_exists(_gen,"ntte_full_events_setup"),"Natural GenCont.Create omitted event setup")
                for(var _i=0;_i<array_length(_events);++_i) {
                    var _event=_events[_i],_index=array_get_index(_order,_event.event_name),
                        _area=scrNTTEFullWorldEventArea(_event.event_name)
                    assert(_index>_previous,"Natural controllers violate original registration/creation priority")
                    _previous=_index;array_push(_selected,_event.id)
                    assert((is_undefined(_area) || _area==GameCont.area)
                        && GameCont.hard>=scrNTTEFullWorldEventHard(_event.event_name),"Natural selection crossed source area/hard boundary")
                    assert(!_event.ntte_event_generated && !_event.ntte_event_cleanup_done,
                        "Natural pre-generation event ran create/cleanup before terrain generation")
                    if(_first_tip=="" && _event.tip!="") _first_tip=_event.tip
                    if(array_get_index(_seen,_event.event_name)<0) {
                        array_push(_seen,_event.event_name)
                        scrNTTESmokeLog("WORLD NATURAL SELECTION "+_event.event_name+" seed="+string(_case_seed)
                            +" area="+string(GameCont.area)+" sub="+string(GameCont.subarea))
                    }
                }
                if(_first_tip!="") assert(_gen.tip_ntte_event==_first_tip && _gen.tip==_first_tip,
                    "Natural setup did not retain first nonempty event tip")
                var _rng_after=random_get_seed()
                scrNTTEFullWorldEventsSetup(_gen)
                assert(array_equals(_selected,scrNTTEFullWorldEventGet(all)) && random_get_seed()==_rng_after,
                    "Repeated natural setup rerolled choices, RNG or source setup callbacks")
                _done=true
                for(var _i=0;_i<array_length(_need);++_i) if(array_get_index(_seen,_need[_i])<0) _done=false
                scrNTTEFullMergedRuntimeTestCleanup(_fixture_before)
            }
            assert(_done,"Natural seed sweep did not select expected source events: "+string(_need)+" observed="+string(_seen))
        }
        assert(array_length(_seen)==16,"Natural original16 coverage is incomplete: "+string(_seen))
        // Original hard0 rejects every event before any chance or text/setup.
        GameCont.area=area_desert;GameCont.subarea=1;GameCont.hard=0
        var _gen=instance_create(0,0,GenCont)
        assert(instance_number(NTTEFullWorldEvent)==0,"Natural hard0 selected an event below its minimum difficulty")
        scrNTTEFullMergedRuntimeTestCleanup(_fixture_before)
    }
    finally {
        scrNTTEFullMergedRuntimeTestCleanup(_before)
        for(var _i=0;_i<array_length(_parked);++_i) instance_activate_object(_parked[_i])
        scrNTTEFullAreaGeneratorRestore(_game);scrNTTEFullAreaGeneratorRestore(_players)
        scrNTTEFullAreaGeneratorRestore(_back);scrNTTEFullAreaGeneratorRestore(_uber);scrNTTEFullAreaGeneratorRestore(_mus)
        global.ntte_full_progress=_progress;global.ntte_full_world_event_hooks=_hooks
        global.ntte_full_world_events_native_bound=_bound;global.ntte_full_player_alias=_alias
        global.ntte_full_palace_shrine_skills=_skills;global.ntte_full_sync_generation=_sync
        if(!is_undefined(_identity)) _identity.name=_name
        save_set_value("game","tutorial",_tutorial);array_copy(global.rng_state,0,_rng,0,array_length(_rng))
        scrNTTEFullFloorSetStyle(_floor_state[0],_floor_state[1])
        scrNTTEFullFloorSetAlign(_floor_state[2],_floor_state[3],_floor_state[4],_floor_state[5])
        for(var _i=0;_i<array_length(_alarm_state);++_i) {
            var _owner=_alarm_state[_i][0],_values=_alarm_state[_i][1]
            if(instance_exists(_owner)) with(_owner) for(var _j=0;_j<12;++_j) alarm[_j]=_values[_j]
        }
        view_xview=_view_x;view_yview=_view_y;camera_set_view_pos(_camera,_camera_x,_camera_y)
        layer_background_blend(_bg[0],_bgcolor);current_frame=_tick;random_set_seed(_seed)
    }
    scrNTTESmokeLog("FULL WORLD NATURAL SELECTION real GenCont.Create/all16/actual seed sweeps/ID order/first tip/hard0/idempotent setup OK @"+string(30/timescale))
}

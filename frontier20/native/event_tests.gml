// Uncharted Frontier (NTUF): isolated native event/entrance acceptance.
// Observers wrap registered callbacks and immediately invoke their original
// source implementation. No event result, completion flag or timer is forged.
function scrFREventTestsNames() {
    return ["PortalStorm","MeteorShower","Casino","PaintorCamp","Thunderstorm","ScrapyardsNight",
        "Blizzard","Aurora","Blackout","BoilingWater","SerpentLair","DebugEvent1","CoastNight",
        "HoarderSpawn","CurseSpread","HauntedCity"];
}
function scrFREventTestsCounts(_record,_name) {
    if(!variable_struct_exists(_record.observed,_name))
        _record.observed[$ _name]={setup:0,create:0,step:0,cleanup:0};
    return _record.observed[$ _name];
}
function scrFREventTestsObserve(_phase) {
    var _driver=global.fr_event_test_driver;
    assert(instance_exists(_driver),"NTUF event observer lost its isolated driver");
    var _counts=scrFREventTestsCounts(_driver.fr_event_record,event);
    _counts[$ _phase]++;
    if(event=="PortalStorm" && _phase=="step") {
        var _record=_driver.fr_event_record,_scale=scrFRSourceScale(),_seed=scrFRSourceRandomGetSeed();
        _record.storm_scale_min=min(_record[$ "storm_scale_min"]??infinity,_scale);
        _record.storm_scale_max=max(_record[$ "storm_scale_max"]??-infinity,_scale);
        if(_seed!=(_record[$ "storm_previous_seed"]??undefined))
            _record.storm_seed_changes=(_record[$ "storm_seed_changes"]??0)+1;
        _record.storm_previous_seed=_seed;
    }
    // self is still the actual libEvents event controller.
    return scrFRInvokeHere(_driver.fr_event_original[$ event+"_"+_phase],[]);
}
function scrFREventTestsSetupObserver() {return scrFREventTestsObserve("setup");}
function scrFREventTestsCreateObserver() {return scrFREventTestsObserve("create");}
function scrFREventTestsStepObserver() {return scrFREventTestsObserve("step");}
function scrFREventTestsCleanupObserver() {return scrFREventTestsObserve("cleanup");}
function scrFREventTestsDarkObserver() {
    var _driver=global.fr_event_test_driver;_driver.fr_event_record.dark_calls++;
    return scrFRInvokeHere(_driver.fr_event_original.draw_dark,[]);
}
function scrFREventTestsDarkEndObserver() {
    var _driver=global.fr_event_test_driver;_driver.fr_event_record.dark_end_calls++;
    return scrFRInvokeHere(_driver.fr_event_original.draw_dark_end,[]);
}
function scrFREventTestsInstrument(_driver,_install) {
    var _scripts=global.fr_module_scripts[$ "mod:Frontier_Events"],_names=scrFREventTestsNames(),
        _phases=["setup","create","step","cleanup"],
        _wrappers=[scrFREventTestsSetupObserver,scrFREventTestsCreateObserver,
            scrFREventTestsStepObserver,scrFREventTestsCleanupObserver];
    if(_install) _driver.fr_event_original={};
    for(var _i=0;_i<array_length(_names);++_i) for(var _j=0;_j<array_length(_phases);++_j) {
        var _key=_names[_i]+"_"+_phases[_j];
        if(_install) {
            if(!variable_struct_exists(_scripts,_key)) continue;
            _driver.fr_event_original[$ _key]=_scripts[$ _key];_scripts[$ _key]=_wrappers[_j];
        } else if(variable_struct_exists(_driver.fr_event_original,_key)) _scripts[$ _key]=_driver.fr_event_original[$ _key];
    }
    var _dark=["draw_dark","draw_dark_end"],_draw=[scrFREventTestsDarkObserver,scrFREventTestsDarkEndObserver];
    for(var _i=0;_i<2;++_i) {
        var _key=_dark[_i];
        if(_install) {_driver.fr_event_original[$ _key]=_scripts[$ _key];_scripts[$ _key]=_draw[_i];}
        else _scripts[$ _key]=_driver.fr_event_original[$ _key];
    }
}
function scrFREventTestsRegistered() {
    var _registered=scrFRModGet("mod","libEvents","event_list"),_actual=[],_expected=scrFREventTestsNames();
    assert(is_array(_registered),"NTUF libEvents did not retain its real registry");
    for(var _i=0;_i<array_length(_registered);++_i) {
        var _entry=_registered[_i];
        if(scrFRModuleKey(_entry[0],_entry[1])=="mod:Frontier_Events") array_push(_actual,_entry[2]);
    }
    assert(array_length(_actual)==16,"NTUF authored active event count changed");
    for(var _i=0;_i<16;++_i) assert(scrFRArrayFindIndex(_actual,_expected[_i])>=0,
        "NTUF registered event omitted: "+_expected[_i]);
    var _lib=scrFRLibGlobal();
    assert(instance_exists(_lib),"NTUF actual libGlobal controller is absent");
    var _hooks=_lib.activeHooks,_events=0;
    for(var _i=0;_i<array_length(_hooks);++_i)
        if(scrFRModuleKey(_hooks[_i][0],_hooks[_i][1])=="mod:libEvents") _events++;
    assert(_events==1,"NTUF libEvents level_start hook is absent or duplicated");
    return _actual;
}
function scrFREventTestsCase(_area,_events,_ticks=120,_loops=0,_subarea=1) {
    return {kind:"event",area:_area,subarea:_subarea,loops:_loops,events:_events,ticks:_ticks};
}
function scrFREventTestsStart(_driver) {
    assert(os_type==os_windows && scrNTTEFullSmokeEnabled(),"NTUF event fixture requires the isolated desktop harness");
    _driver.fr_event_cases=[scrFREventTestsCase(1,["PortalStorm"],1600,1),
        scrFREventTestsCase(1,["MeteorShower"]),scrFREventTestsCase(2,["Casino"]),
        scrFREventTestsCase(2,["PaintorCamp"]),scrFREventTestsCase(3,["Thunderstorm"],200),
        scrFREventTestsCase(3,["ScrapyardsNight"]),scrFREventTestsCase(5,["Blizzard"]),
        scrFREventTestsCase(5,["Aurora"]),scrFREventTestsCase(6,["Blackout"]),
        scrFREventTestsCase(7,["BoilingWater"]),scrFREventTestsCase(7,["SerpentLair"],800),
        scrFREventTestsCase(1,["DebugEvent1"],200),scrFREventTestsCase(201,["CoastNight"]),
        scrFREventTestsCase(1,["HoarderSpawn"]),scrFREventTestsCase(4,["CurseSpread"]),
        scrFREventTestsCase(5,["HauntedCity"]),
        scrFREventTestsCase(3,["Thunderstorm","ScrapyardsNight"],200),
        scrFREventTestsCase(5,["Aurora","Blizzard"]),
        scrFREventTestsCase(301,["HoarderSpawn"]),scrFREventTestsCase(305,["HoarderSpawn"]),
        scrFREventTestsCase(306,["HoarderSpawn"]),scrFREventTestsCase(201,["HoarderSpawn"]),
        scrFREventTestsCase(301,["PaintorCamp"]),scrFREventTestsCase(306,["PaintorCamp"]),
        scrFREventTestsCase(204,["PaintorCamp"]),scrFREventTestsCase(301,["DebugEvent1"],200)];
    var _entries=[["cove",4,1],["cove_alt",3,3],["graveyard",5,1],["robocenter",305,3],
        ["deeplabs",306,1],["cyberspace",1,1]];
    for(var _i=0;_i<array_length(_entries);++_i) {
        var _e=_entries[_i];array_push(_driver.fr_event_cases,
            {kind:_e[0],area:_e[1],subarea:_e[2],loops:0,events:[],ticks:2400});
    }
    assert(array_length(_driver.fr_event_cases)==32,"NTUF event/entry manifest is incomplete");
    _driver.fr_event_options=[];
    var _settings=[["mod","Frontier_Main","settingAltCoveEntrance"],["area","cove","settingAltCoveEntrance"],
        ["mod","Frontier_Main","settingLabsRouteAltMode"],["area","graveyard","settingLabsRouteAltMode"],
        ["area","robocenter","settingLabsRouteAltMode"],["area","deeplabs","settingLabsRouteAltMode"],
        ["area","cyberspace","settingCyberspaceEnabled"]];
    for(var _i=0;_i<array_length(_settings);++_i) {
        var _s=_settings[_i];array_push(_driver.fr_event_options,[_s,scrFRModGet(_s[0],_s[1],_s[2])]);
    }
    _driver.fr_event_player_race=scrFRPlayerRace(0);_driver.fr_event_player_skin=scrFRPlayerSkin(0);
    _driver.fr_event_immortal=global.__debug_immortality;_driver.fr_event_practice=UberCont.opt_practice;
    _driver.fr_event_index=-1;_driver.fr_event_phase=0;_driver.fr_event_results=[];_driver.persistent=true;
    global.fr_event_test_driver=_driver;
    scrFREventTestsInstrument(_driver,true);
    save_set_value("game","tutorial",false);
    UberCont.opt_bossintro=false;UberCont.opt_freeze=0;UberCont.opt_autopause=false;UberCont.paused=false;
    UberCont.want_quit_to_menu=false;UberCont.want_restart=false;UberCont.want_menu=false;
    scrFREventTestsNext(_driver);
}
function scrFREventTestsPrepare(_driver,_area,_subarea,_loops,_events,_neutral=false) {
    var _seed=47003+_driver.fr_event_index*977+(_neutral?149:0);
    GameCont.area=_area;GameCont.subarea=_subarea;GameCont.loops=_loops;GameCont.lastarea=area_labs;GameCont.lastsubarea=3;
    GameCont.hard=40;GameCont.crown=Crown.None;GameCont.proto=false;GameCont.gocrib=false;GameCont.killenemies=false;
    GameCont.skillpoints=0;GameCont.crownpoints=0;GameCont.ultrapoints=0;GameCont.patiencepick=false;
    GameCont.maxsubarea=scrAreaGetMaxSubarea(_area);GameCont.finalsubarea=_subarea==GameCont.maxsubarea;
    GameCont.baseseed=_seed;GameCont.levseed=_seed;GameCont.can_advance_stage=false;GameCont.is_level_ended=true;
    GameCont.ntte_full_source_seed=scrNTTEFullSourceSeedBuild(_seed);
    GameCont.ntte_full_source_pending_generation=undefined;GameCont.ntte_full_pending_destination=undefined;
    global.rng_state[@ RNGStates.Generation]=_seed;global.ntte_full_sync_generation=false;
    global.fr_continue_generation=undefined;
    var _event_refs=[];
    for(var _i=0;_i<array_length(_events);++_i) array_push(_event_refs,["mod","Frontier_Events",_events[_i]]);
    global.fr_continue_events={game:GameCont.id,events:_event_refs};
    _driver.fr_event_pending_events=_events;_driver.fr_event_ticks=0;_driver.fr_event_source_ticks=0;
    _driver.fr_event_phase=_neutral?6:1;
    _driver.fr_event_generation_started=false;
    _driver.fr_event_room_marker=instance_create(0,0,FRMarker);
    room_restart();
}
function scrFREventTestsNext(_driver) {
    _driver.fr_event_index++;
    if(_driver.fr_event_index>=array_length(_driver.fr_event_cases)) {_driver.fr_event_phase=9;return;}
    var _case=_driver.fr_event_cases[_driver.fr_event_index];
    for(var _i=0;_i<array_length(_driver.fr_event_options);++_i) {
        var _s=_driver.fr_event_options[_i][0],_value=_s[2]=="settingCyberspaceEnabled";
        scrFRModSet(_s[0],_s[1],_s[2],_value);
    }
    scrFRModSet("mod","Frontier_Main","settingAltCoveEntrance",_case.kind=="cove_alt");
    scrFRModSet("area","cove","settingAltCoveEntrance",_case.kind=="cove_alt");
    _driver.fr_event_record={index:_driver.fr_event_index,kind:_case.kind,area:_case.area,subarea:_case.subarea,
        loops:_case.loops,events:_case.events,observed:{},dark_calls:0,dark_end_calls:0,
        storm_portal_seen:false,storm_enemy_seen:false,rain_seen:false,serpent_seen:false,
        event_controllers:[],bindings:[],damage_calls:0,chest_inputs:0,prompt_inputs:0};
    _driver.fr_event_live={phase:0,ticks:0,step_baseline:{},timer_baseline:{},player:noone};
    scrNTTESmokeLog("NTUF EVENT/ENTRY BEGIN "+json_stringify(_case));
    scrFREventTestsPrepare(_driver,_case.area,_case.subarea,_case.loops,_case.events);
}
function scrFREventTestsGenerate(_driver) {
    // The persistent Vlambeer controller does not repeat its Create event on
    // room_restart. LevCont normally starts generation after that disposal;
    // this isolated driver supplies that one boundary action. The real async
    // GenCont must create all terrain and TopCont through its normal events.
    assert(!_driver.fr_event_generation_started && !instance_exists(_driver.fr_event_room_marker),
        "NTUF event fixture started generation twice or before actual room disposal");
    assert(!instance_exists(TopCont) && !instance_exists(GenCont) && instance_number(Floor)==0,
        "NTUF event room disposal retained old terrain or generation controllers");
    if(!instance_exists(BackCont)) instance_create(0,0,BackCont);
    if(!instance_exists(MusCont)) instance_create(0,0,MusCont);
    // Vlambeer normally creates this receiver before GenCont. Its real
    // Destroy event clears the loading letterbox when GenCont retires it.
    // Omitting it leaves a permanent black bar over the source weather card.
    _driver.fr_event_generation_spiral=instance_create(0,0,SpiralCont);
    var _gen=instance_create(0,0,GenCont);
    assert(instance_number(GenCont)==1 && instance_exists(_gen) && !_gen.ntte_full_sync_generation,
        "NTUF event fixture replaced ordinary async generation with sync callbacks");
    assert(_gen.fr_generation_metadata_ready && _gen.spawn_x==10016 && _gen.spawn_y==10016
        && is_real(_gen.safedist),"NTUF async GenCont omitted its native-backed NTT spawn contract");
    var _controllers=scrFRModCallArray("mod","libEvents","event_get_active",[all]);
    for(var _i=0;_i<array_length(_controllers);++_i) {
        var _event=_controllers[_i];
        assert(_event.spawn_x==_gen.spawn_x && _event.spawn_y==_gen.spawn_y,
            "NTUF source event_setup did not capture the real generation spawn");
    }
    _driver.fr_event_generation_started=true;
    scrNTTESmokeLog("NTUF EVENT real room disposal observed; async GenCont started");
}
function scrFREventTestsController(_name) {
    return scrFRModCallArray("mod","libEvents","event_get_active",[_name]);
}
function scrFREventTestsNamed(_object,_name) {return scrFRMatching(_object,"name",_name);}
function scrFREventTestsOne(_name) {
    var _found=scrFREventTestsNamed(FRCustomObject,_name);
    assert(array_length(_found)==1,"NTUF actual authored entry object missing or duplicated: "+_name);return _found[0];
}
function scrFREventTestsMove(_player,_x,_y) {
    assert(instance_exists(_player),"NTUF entry lost its real native Player");
    _player.x=_x;_player.y=_y;_player.xprevious=_x;_player.yprevious=_y;_player.speed=0;
}
function scrFREventTestsDamage(_targets,_player) {
    var _hits=0;
    for(var _i=0;_i<array_length(_targets);++_i) {
        var _target=_targets[_i];
        if(!instance_exists(_target) || scrNTTEFullValue(_target,"hp",0)<=0) continue;
        with(_player) if(scrFRProjectileHitRaw(_target,1000000,0)) _hits++;
    }
    return _hits;
}
function scrFREventTestsDark(_driver) {
    var _surface=surface_create(128,128),_color=draw_get_color(),_alpha=draw_get_alpha(),
        _world=matrix_get(matrix_world);
    assert(surface_exists(_surface),"NTUF dark acceptance could not obtain a real render target");
    try {
        surface_set_target(_surface);draw_clear_alpha(c_black,0);
        with(FRWorld) {
            scrFRDarkDraw("draw_dark",view_xview,view_yview);
            scrFRDarkDraw("draw_dark_end",view_xview,view_yview);
        }
        assert(draw_get_color()==_color && draw_get_alpha()==_alpha,
            "NTUF native darkness adapter leaked draw state");
    } finally {surface_reset_target();surface_free(_surface);matrix_set(matrix_world,_world);}
    assert(_driver.fr_event_record.dark_calls>0 && _driver.fr_event_record.dark_end_calls>0,
        "NTUF native darkness path did not invoke authored draw callbacks");
}
function scrFREventTestsPortalChance(_limit) {
    // The test hook replaces one original random() call with this observer.
    // Draw exactly once before bookkeeping, and return that same value.
    var _roll=scrFRSourceRandom(_limit),_driver=variable_global_exists("fr_event_test_driver")?global.fr_event_test_driver:noone;
    if(instance_exists(_driver)) {
        var _record=_driver.fr_event_record,_scale=scrFRSourceScale();
        _record.storm_roll_count=(_record[$ "storm_roll_count"]??0)+1;
        _record.storm_roll_min=min(_record[$ "storm_roll_min"]??infinity,_roll);
        _record.storm_roll_max=max(_record[$ "storm_roll_max"]??-infinity,_roll);
        if(_roll<_scale) {
            _record.storm_roll_success=(_record[$ "storm_roll_success"]??0)+1;
            if(portalStormCooldown<=0)
                _record.storm_ready_roll_success=(_record[$ "storm_ready_roll_success"]??0)+1;
        }
        if(!variable_struct_exists(_record,"storm_roll_samples")) _record.storm_roll_samples=[];
        if(array_length(_record.storm_roll_samples)<20)
            array_push(_record.storm_roll_samples,{roll:_roll,threshold:_scale,cooldown:portalStormCooldown});
    }
    return _roll;
}
function scrFREventTestsPortalEligibility(_proto_object,_player_object) {
    // Preserve the original short-circuit order and Floor instance scope.
    var _proto_distance=distance_to_object(_proto_object),_player_distance=undefined,
        _eligible=false,_driver=variable_global_exists("fr_event_test_driver")?global.fr_event_test_driver:noone;
    if(_proto_distance>64) {
        _player_distance=distance_to_object(_player_object);
        _eligible=_player_distance<224;
    }
    if(instance_exists(_driver)) {
        var _record=_driver.fr_event_record;
        _record.storm_selected_count=(_record[$ "storm_selected_count"]??0)+1;
        if(_eligible) _record.storm_eligible_selected=(_record[$ "storm_eligible_selected"]??0)+1;
        if(!variable_struct_exists(_record,"storm_selected_samples")) _record.storm_selected_samples=[];
        if(array_length(_record.storm_selected_samples)<20)
            array_push(_record.storm_selected_samples,{floor:real(id),x:x,y:y,
                proto_distance:_proto_distance,player_distance:_player_distance,eligible:_eligible});
    }
    return _eligible;
}
function scrFREventTestsPortalSelector() {
    // This real-selector regression runs only after the observed live window.
    // It consumes its two original random draws normally; a seed is not an
    // RNG-state snapshot, so never reseed the event to "restore" those draws.
    var _floors=scrFRInstances(Floor),
        _filtered=scrFRMatchingNE(Floor,"id",undefined),_first=_floors[0],
        _scripts=scrFRModGet("mod","Frontier_Events","scr"),
        _direct,_indirect,_value=undefined;
    _direct=scrFRModCall("mod","libGeneral","instance_random",Floor);
    _indirect=scrFRCallArray(_scripts.instance_random,[Floor]);
    if(variable_instance_exists(_first,"id")) _value=variable_instance_get(_first,"id");
    scrNTTESmokeLog("NTUF PORTAL STORM SELECTOR "+json_stringify({
        floors:array_length(_floors),filtered:array_length(_filtered),
        native_has_id:variable_instance_exists(_first,"id"),native_dynamic_id:_value,
        native_id:real(_first.id),direct:_direct,indirect:_indirect,
        reference:_scripts.instance_random}));
    assert(array_length(_filtered)==array_length(_floors),
        "PortalStorm's original libGeneral Floor selector lost native instance id fields");
    assert(scrFRIsInstanceValue(_direct) && scrFRIsInstanceValue(_indirect)
        && instance_is(_direct,Floor) && instance_is(_indirect,Floor),
        "PortalStorm's direct/registered original libGeneral random Floor selector failed");
}
function scrFREventTestsInspect(_driver) {
    var _case=_driver.fr_event_cases[_driver.fr_event_index],_record=_driver.fr_event_record,_live=_driver.fr_event_live;
    assert(!instance_exists(_driver.fr_event_generation_spiral) && !UberCont.letterbox,
        "NTUF ordinary generation did not retire its native loading spiral/letterbox");
    assert(GameCont.area==_case.area && GameCont.subarea==_case.subarea,"NTUF event generation changed its target");
    assert(instance_number(Floor)>=20,"NTUF event generation omitted native traversable terrain");
    _record.terrain={floors:instance_number(Floor),walls:instance_number(Wall),invisible:instance_number(InvisiWall),
        sea:instance_number(NTTEFullCoastSea),sea_top:instance_number(NTTEFullCoastSeaTop),
        sea_visible:instance_number(NTTEFullCoastSeaVisible)};
    if(_case.area==201 && _case.subarea>0) {
        // Original coast.area removes walls/tops and uses three ordered sea
        // controllers. Require that actual contract, including its constructor
        // behavior, rather than treating a correctly open sea as missing walls.
        assert(GameCont.ntte_full_active_coast && instance_number(Wall)==0 && instance_number(TopSmall)==0
            && _record.terrain.sea==1 && _record.terrain.sea_top==1 && _record.terrain.sea_visible==1,
            "NTUF Coast event lost its authored open-sea terrain/render controllers");
        var _probe=instance_create(50000,50000,Wall);
        assert(!instance_exists(_probe),"NTUF Coast event retained a wall despite the real unwalled sea constructor");
    } else assert(instance_number(Wall)+instance_number(InvisiWall)>0,
        "NTUF event generation omitted native collision");
    scrFREventTestsRegistered();
    var _active=scrFRModCallArray("mod","libEvents","event_get_active",[all]);
    assert(array_length(_active)==array_length(_case.events),"NTUF event lifecycle activated an unrelated event");
    for(var _i=0;_i<array_length(_case.events);++_i) {
        var _name=_case.events[_i],_event=scrFREventTestsController(_name),_counts=scrFREventTestsCounts(_record,_name);
        assert(instance_exists(_event) && _counts.create==1,"NTUF source create absent or duplicated: "+_name);
        assert(scrFRArrayEquals(_event.on_step,["mod","Frontier_Events",_name+"_step"])
            && scrFRArrayEquals(_event.on_cleanup,["mod","Frontier_Events",_name+"_cleanup"]),
            "NTUF libEvents did not install its source callback refs: "+_name);
        if(variable_struct_exists(_driver.fr_event_original,_name+"_setup"))
            assert(_counts.setup==1,"NTUF source setup absent or duplicated: "+_name);
        assert(_counts.cleanup==0,"NTUF live event cleaned up before its native room boundary");
        array_push(_record.event_controllers,_event);_live.step_baseline[$ _name]=_counts.step;
        _live.timer_baseline[$ _name]=scrNTTEFullValue(_event,"compatTimer",undefined);
        with(FRBinding) if(creator==_event) array_push(_record.bindings,id);
    }
    _live.player=instance_find(Player,0);assert(instance_exists(_live.player),"NTUF generation lost native Player");
    _live.hold_x=_live.player.x;_live.hold_y=_live.player.y;
    _live.ticks=0;
    if(_case.kind=="event") scrFREventTestsDark(_driver);
}
function scrFREventTestsCountField(_objects,_field) {
    var _count=0;with(_objects) if(variable_instance_exists(id,_field)) _count++;return _count;
}
function scrFREventTestsEventsStep(_driver) {
    var _case=_driver.fr_event_cases[_driver.fr_event_index],_record=_driver.fr_event_record,_live=_driver.fr_event_live;
    if(!scrFRReadyTick()) return false;
    _live.ticks++;
    if(array_length(scrFREventTestsNamed(FRCustomObject,"fr_stormportal"))>0) _record.storm_portal_seen=true;
    // Upstream tags its ZAxisToss controller, whose creator is the enemy;
    // the native enemy itself intentionally has no portalGuy field.
    with(FRCustomObject) if(scrNTTEFullValue(id,"portalGuy",false)) {
        var _spawned=scrNTTEFullValue(id,"creator",noone);
        if(instance_exists(_spawned) && instance_is(_spawned,enemy)) _record.storm_enemy_seen=true;
    }
    if(instance_number(RainDrop)>0) _record.rain_seen=true;
    if(array_length(scrFREventTestsNamed(FRCustomObject,"fr_PalaceSerpentSpawn"))>0
        || array_length(scrFREventTestsNamed(FRCustomObject,"fr_PalaceSerpent"))>0) _record.serpent_seen=true;
    if(_live.ticks<_case.ticks) return false;
    for(var _i=0;_i<array_length(_case.events);++_i) {
        var _name=_case.events[_i],_event=scrFREventTestsController(_name),_counts=scrFREventTestsCounts(_record,_name);
        assert(instance_exists(_event) && _counts.create==1 && _counts.cleanup==0,"NTUF live event lifecycle failed: "+_name);
        if(variable_struct_exists(_driver.fr_event_original,_name+"_step")) {
            var _delta=_counts.step-_live.step_baseline[$ _name];
            assert(abs(_delta-_live.ticks)<=2,"NTUF event step was skipped or dispatched twice per source tick: "+_name);
        }
        switch(_name) {
            case "PortalStorm":
                var _eligible=0,_without_proto=0,_floor_count=instance_number(Floor),_portals=[],
                    _proto_count=instance_number(ProtoStatue);
                with(Floor) {
                    if(distance_to_object(ProtoStatue)>64) _without_proto++;
                    if(distance_to_object(ProtoStatue)>64 && distance_to_object(Player)<224) _eligible++;
                }
                with(FRCustomObject) if(name=="fr_stormportal") array_push(_portals,
                    {sprite:sprite_get_name(sprite_index),frame:image_index,speed:image_speed,frames:image_number,
                     ammo:ammo,alarm:scrFRAlarmRead(id,1),done:portalDone,area:portalArea});
                scrNTTESmokeLog("NTUF PORTAL STORM OBSERVED "+json_stringify({
                    cooldown:_event.portalStormCooldown,spawned:_event.stormPortals,
                    portal_seen:_record.storm_portal_seen,enemy_seen:_record.storm_enemy_seen,
                    portals:_portals,proto_count:_proto_count,floors:_floor_count,
                    far_from_proto:_without_proto,eligible_floors:_eligible,
                    source_scale_min:_record[$ "storm_scale_min"]??undefined,
                    source_scale_max:_record[$ "storm_scale_max"]??undefined,
                    seed_changes:_record[$ "storm_seed_changes"]??0,max_portals:_event.maxPortals,
                    roll_count:_record[$ "storm_roll_count"]??0,
                    roll_min:_record[$ "storm_roll_min"]??undefined,roll_max:_record[$ "storm_roll_max"]??undefined,
                    roll_success:_record[$ "storm_roll_success"]??0,
                    ready_roll_success:_record[$ "storm_ready_roll_success"]??0,
                    selected_count:_record[$ "storm_selected_count"]??0,
                    selected_eligible:_record[$ "storm_eligible_selected"]??0,
                    roll_samples:_record[$ "storm_roll_samples"]??[],
                    selected_samples:_record[$ "storm_selected_samples"]??[]}));
                scrFREventTestsPortalSelector();
                assert(_event.portalStormCooldown<120 && _record.storm_portal_seen && _record.storm_enemy_seen,
                    "NTUF PortalStorm failed real cooldown/portal animation/alarm-spawn lifecycle");break;
            case "MeteorShower":case "ScrapyardsNight":case "Aurora":case "CoastNight":
                assert(scrFRModGet("mod","Frontier_Events","isNight") && _event.compatCheck,
                    "NTUF night setup or delayed source compatibility sprites failed: "+_name);
                assert(array_length(scrFREventTestsNamed(FRCustomObject,"fr_area_halfdark"))>0,
                    "NTUF night event omitted authored darkness");break;
            case "Thunderstorm":
                assert(_event.thunderstormCooldown<60 && _record.rain_seen,"NTUF real thunderstorm rain/cooldown did not run");break;
            case "Blizzard":
                assert(scrFRModGet("mod","Frontier_Events","blizzardSnowPos")>0 && array_length(_record.bindings)>=3,
                    "NTUF Blizzard source step/draw bindings did not run");
                if(scrFRArrayFindIndex(_case.events,"Aurora")>=0)
                    assert(_event.spr_snowflakes==scrFRModGet("mod","Frontier_Events","sprBlizzardSnowNight"),
                        "NTUF combined Aurora/Blizzard lost its authored night snow");break;
            case "Blackout":
                assert(scrFRModGet("mod","Frontier_Events","blackoutScale")>=0.25
                    && array_length(_record.bindings)>0,"NTUF Blackout source darkness state/bindings absent");break;
            case "Casino":
                assert(array_length(scrFREventTestsNamed(FRCustomObject,"fr_CasinoCarpet"))==1,
                    "NTUF Casino actual room/carpet generation failed");
                _record.casino_music=scrFRModGet("mod","Frontier_Events","casinoMusic");
                _record.sewer_music=scrFRModGet("mod","Frontier_Events","sewerMusic");break;
            case "HoarderSpawn":
                assert(scrFREventTestsCountField(Floor,"fr_hoarderSpawn")>0,
                    "NTUF actual Hoarder spawner did not inspect generated floors");break;
            case "PaintorCamp":
                assert(scrFREventTestsCountField(Floor,"fr_paintorSpawned")>0,
                    "NTUF actual Paintor spawner did not place its camp on generated floors");break;
            case "CurseSpread":
                assert(array_length(scrFREventTestsNamed(FRCustomObject,"fr_cursecavedraws"))==1
                    && (array_length(scrFRMatching(Floor,"sprite_index",sprFloor104,sprFloor104B))>0
                        || scrFREventTestsCountField(Wall,"fr_topSmallCurse")>0),
                    "NTUF CurseSpread did not retain its actual draw controller/terrain effects");break;
            case "DebugEvent1":assert(_event.debugActivated,"NTUF authored delayed DebugEvent1 did not activate");break;
            case "SerpentLair":assert(_record.serpent_seen,"NTUF authored SerpentLair did not produce its spawner");break;
            // BoilingWater and HauntedCity can validly choose no eligible
            // object on a small map; observed source create is authoritative.
        }
    }
    if(scrFRArrayFindIndex(_case.events,"CoastNight")>=0) {
        var _assets=scrFRModGet("mod","teassets","spr");
        assert(_assets.FloorCoast==scrFRModGet("mod","Frontier_Events","sprFloorCoastNight"),
            "NTUF CoastNight did not mutate the real NTTE asset registry");
    }
    if(scrFRArrayFindIndex(_case.events,"MeteorShower")>=0 && _case.subarea==1
        && scrFRModGet("mod","Frontier_Events","settingEventDropdowns")
        && !scrFRModGet("mod","Frontier_Events","settingNightLoops")) {
        assert((_record[$ "dropdown_visible_ticks"]??0)>0
            && (_record[$ "dropdown_ready_visible_ticks"]??0)>0
            && (_record[$ "dropdown_full_visible_ticks"]??0)>0
            && (_record[$ "dropdown_screen_proof"]??false),
            "NTUF natural MeteorShower sign never became visible after real room generation completed");
    }
    _record.observed_source_ticks=_live.ticks;return true;
}

function scrFREventTestsDropdownObserve(_driver) {
    var _record=_driver.fr_event_record,_controllers=scrFRMatching(FRCustomObject,"name","fr_EventDropdownController");
    for(var _i=0;_i<array_length(_controllers);++_i) {
        var _controller=_controllers[_i];
        _record.dropdown_controller_seen=true;
        _record.dropdown_index=_controller.arrayIndex;
        _record.dropdown_queue_count=array_length(_controller.dropdownsQueue);
        with(FRBinding) if(fr_binding_kind=="draw" && creator==_controller) {
            _record.dropdown_binding_seen=true;
            _record.dropdown_max_height=max(_record[$ "dropdown_max_height"]??-1000,height);
            if(height>=12 && height<=30) {
                _record.dropdown_visible_ticks=(_record[$ "dropdown_visible_ticks"]??0)+1;
                if(!instance_exists(GenCont) && !scrGameIsGenerationScreen())
                    _record.dropdown_ready_visible_ticks=(_record[$ "dropdown_ready_visible_ticks"]??0)+1;
                if(height>=20 && !instance_exists(GenCont) && !scrGameIsGenerationScreen()
                    && !UberCont.letterbox && UberCont.letterbox_frame==0)
                    _record.dropdown_full_visible_ticks=(_record[$ "dropdown_full_visible_ticks"]??0)+1;
                if(!(_record[$ "dropdown_screen_proof"]??false)
                    && !instance_exists(GenCont) && !scrGameIsGenerationScreen()) {
                    _record.dropdown_screen_proof=scrFRWeatherScreenProof(id,
                        "ntuf-natural-weather-final-screen-"+string(game_get_speed(gamespeed_fps))+".png");
                }
            }
        }
    }
}

// Check the engine's already composited previous frame, not a private replay
// of the banner's callback. A matching sprite on an isolated target alone
// cannot prove that generation overlays, camera or HUD actually let it show.
function scrFRWeatherScreenProof(_binding,_filename) {
    assert(instance_exists(_binding) && surface_exists(application_surface),
        "NTUF weather final-screen proof lost its live receiver or application surface");
    var _args=_binding.fr_binding_args,_width=ceil(view_width),_height=ceil(view_height),
        _actual_width=surface_get_width(application_surface),_actual_height=surface_get_height(application_surface),
        _reference=scrFRVisualCapture("weather-artwork",_width,_height,view_xview,view_yview,
            [_args[1],_args[2],_binding.height,_binding.bounceHeight]),
        _actual=buffer_create(_actual_width*_actual_height*4,buffer_fixed,1),_samples=0,_matches=0;
    try {
        buffer_get_surface(_actual,application_surface,0);
        for(var _y=0;_y<min(_height,100);++_y) for(var _x=0;_x<_width;++_x) {
            var _offset=4*(_y*_width+_x);
            if(buffer_peek(_reference.pixels,_offset+3,buffer_u8)<250) continue;
            var _r=buffer_peek(_reference.pixels,_offset,buffer_u8),
                _g=buffer_peek(_reference.pixels,_offset+1,buffer_u8),
                _b=buffer_peek(_reference.pixels,_offset+2,buffer_u8);
            // Non-black source art avoids credit for an empty black frame.
            if(_r+_g+_b<100) continue;
            var _ax=clamp(floor((_x+.5)*_actual_width/_width),0,_actual_width-1),
                _ay=clamp(floor((_y+.5)*_actual_height/_height),0,_actual_height-1),
                _at=4*(_ay*_actual_width+_ax);
            _samples++;
            if(abs(buffer_peek(_actual,_at,buffer_u8)-_r)<=16
                && abs(buffer_peek(_actual,_at+1,buffer_u8)-_g)<=16
                && abs(buffer_peek(_actual,_at+2,buffer_u8)-_b)<=16) _matches++;
        }
        surface_save(application_surface,working_directory+_filename);
        scrNTTESmokeLog("NTUF WEATHER FINAL SCREEN "+json_stringify({samples:_samples,matches:_matches,
            ratio:_matches/max(1,_samples),native_width:_width,native_height:_height,
            surface_width:_actual_width,surface_height:_actual_height,
            height:_binding.height,bounce:_binding.bounceHeight,viewx:view_xview,viewy:view_yview}));
        assert(_samples>100 && _matches/_samples>.8,
            "NTUF weather artwork did not reach the actual final application surface");
        return true;
    } finally {scrFRVisualFree(_reference);if(buffer_exists(_actual)) buffer_delete(_actual);}
}
function scrFREventTestsPrompt(_creator,_player) {
    var _prompt=noone;
    with(FRCustomObject) if(scrNTTEFullValue(id,"creator",noone)==_creator && variable_instance_exists(id,"pick")) {_prompt=id;break;}
    if(!instance_exists(_prompt)) return false;
    _prompt.pick=_player.index;return true;
}
function scrFREventTestsQueue(_expected,_subarea=1) {
    GameCont.ntte_full_pending_destination=undefined;
    with(GameCont) scrFRAreaFinish();
    var _next=scrNTTEFullAreaTakeDestination();
    assert(is_struct(_next) && _next.area==_expected && _next.subarea==_subarea,
        "NTUF actual entry did not queue its authored native destination");return _next;
}
function scrFREventTestsEntryStep(_driver) {
    var _case=_driver.fr_event_cases[_driver.fr_event_index],_record=_driver.fr_event_record,_live=_driver.fr_event_live,
        _p=_live.player;
    if(!scrFRReadyTick()) return false;
    _live.ticks++;
    if(_case.kind=="cyberspace") {
        if(_live.phase==0) {
            assert(instance_number(Player)==1,"NTUF Robot death admission requires one real native player");
            scrFRPlayerSetRace(_p.index,"robot");GameCont.fr_visitedCyberspace=false;
            global.__debug_immortality=false;UberCont.opt_practice=false;
            _live.phase=1;_live.death_at=_live.ticks+8;return false;
        }
        if(_live.phase==1 && _live.ticks>=_live.death_at) {
            // Genuine native fatal damage. wibbly must observe the missing
            // Player and invoke cyberspace_revive; the fixture never calls it.
            with(_p) {nexthurt=0;spirit=false;spirit_index=0;scr_hit_self(1000000);}
            _record.native_death_requested=true;
            _live.death_requested_at=_live.ticks;
            _live.phase=2;return false;
        }
        var _controllers=scrFREventTestsNamed(FRCustomObject,"fr_bluescreenController");
        if(_live.phase==2) {
            assert(_live.ticks-_live.death_requested_at<180,
                "NTUF authentic Robot death did not complete its native admission/revive lifecycle");
            if(array_length(_controllers)==0) return false;
            assert(GameCont.fr_visitedCyberspace && instance_exists(Player),"NTUF authentic Robot death did not revive into its admission UI");
            assert(scrFRPlayerRace(0)=="robot","NTUF native Cyberspace revival lost the real Robot race");
            _record.native_revive_observed=true;
            _live.player=instance_find(Player,0);_live.phase=3;
        }
        if(_live.phase==3) {
            var _yes=noone;
            with(FRCustomObject) if(scrNTTEFullValue(id,"fr_bluescreenbutton",false)
                && scrNTTEFullValue(id,"yesButton",false)) {_yes=id;break;}
            if(!instance_exists(_yes)) return false;
            // Supply the actual generated Yes button's registered click input.
            scrFRInvoke(_yes,_yes.clickScr,[]);_record.prompt_inputs++;_live.phase=4;
        }
        if(_live.phase==4) {
            assert(GameCont.area==302 && GameCont.subarea==0 && instance_exists(Portal),
                "NTUF actual bluescreen confirmation did not enter Cyberspace");
            _record.destination=scrFREventTestsQueue(302);return true;
        }
        return false;
    }
    assert(instance_exists(_p),"NTUF natural entrance test lost Player");
    if(_live.ticks mod 300==0) scrNTTESmokeLog("NTUF ENTRY progress "+json_stringify({
        kind:_case.kind,phase:_live.phase,ticks:_live.ticks,area:GameCont.area,subarea:GameCont.subarea,
        portals:instance_number(Portal),enemies:instance_number(enemy),
        entrance_open:instance_exists(_live[$ "entrance"]??noone)?(_live.entrance[$ "entranceopen"]??undefined):undefined,
        entrance_image:instance_exists(_live[$ "entrance"]??noone)?_live.entrance.image_index:undefined}));
    assert(_live.ticks<_case.ticks,"NTUF natural entrance exceeded its original source-tick budget: "+_case.kind);
    if(_live.phase==0) {
        _live.entrance=noone;
        if(_case.kind=="cove" || _case.kind=="cove_alt") _live.entrance=scrFREventTestsOne("fr_CoveEntrance");
        else if(_case.kind=="graveyard") _live.entrance=scrFREventTestsOne("fr_LabsEntrance");
        else if(_case.kind=="deeplabs") _live.entrance=scrFREventTestsOne("fr_DeeplabsEntrance");
        _live.phase=1;
    }
    // The sleeping native BigDog is a destructible prop, not an enemy.
    // Real damage wakes it through Destroy -> ScrapBoss before the ordinary
    // clear can open a Portal and suppress its proximity wake condition.
    if(_case.kind=="cove_alt") {
        var _sleepers=scrFRInstances(BecomeScrapBoss),_hits=scrFREventTestsDamage(_sleepers,_p);
        _record.damage_calls+=_hits;
        if(array_length(_sleepers)>0) {
            for(var _i=0;_i<array_length(_sleepers);++_i)
                assert(_sleepers[_i].hp<=0,"NTUF CoveAlt sleeper did not receive genuine damage");
            // Native prop.BeginStep processes hp<=0 and invokes Destroy on
            // the following frame; do not demand a synchronous constructor.
            _live.sleeper_hit_at=_live[$ "sleeper_hit_at"]??_live.ticks;
        }
        if(instance_exists(ScrapBoss)) _record.native_scrapboss_awakened=true;
        if(!(_record[$ "native_scrapboss_awakened"]??false)
            && variable_struct_exists(_live,"sleeper_hit_at"))
            assert(_live.ticks-_live.sleeper_hit_at<60,
                "NTUF CoveAlt damaged sleeper did not run its native death/spawn lifecycle");
    }
    _record.damage_calls+=scrFREventTestsDamage(scrFRInstances(enemy),_p);
    // Opening ordinary native chest colliders supplies the authored Cove
    // prerequisites. No chest, gate, boss or completion object is deleted.
    if(_case.kind=="cove" || _case.kind=="cove_alt") {
        var _chests=scrFRInstances(chestprop),_rads=scrFRInstances(RadChest);
        if(array_length(_chests)+array_length(_rads)>0) {
            var _chest=array_length(_chests)>0?_chests[0]:_rads[0];
            scrFREventTestsMove(_p,_chest.x,_chest.y);_record.chest_inputs++;return false;
        }
        if(!_live.entrance.open) return false;
        scrFREventTestsMove(_p,_live.entrance.x,_live.entrance.y);
        if(!_live.entrance.opened) return false;
        if(_case.kind=="cove_alt") assert(_record[$ "native_scrapboss_awakened"]??false,
            "NTUF CoveAlt entrance opened without observing its real native ScrapBoss");
        assert(GameCont.area==301 && GameCont.subarea==0,"NTUF authored Cove gate did not supply its destination");
        _record.destination=scrFREventTestsQueue(301);return true;
    }
    GameCont.is_level_ended=false;scrFREventTestsMove(_p,_live.hold_x,_live.hold_y);
    if(!instance_exists(Portal)) return false;
    GameCont.is_level_ended=true;
    switch(_case.kind) {
        case "graveyard":
            if(_live.entrance.locked) return false;
            scrFREventTestsMove(_p,_live.entrance.x,_live.entrance.y+24);
            if(scrFREventTestsPrompt(_live.entrance,_p)) _record.prompt_inputs++;
            if(GameCont.area!=305 || GameCont.subarea!=0) return false;
            _record.destination=scrFREventTestsQueue(305);return true;
        case "robocenter":
            // Robocenter's default entrance is the real Graveyard area_next
            // route after its subarea-3 WantLH boss; there is no physical gate.
            assert(_record.damage_calls>0 && !instance_exists(LilHunter) && !instance_exists(WantLH),
                "NTUF Graveyard route skipped its natural final encounter");
            _record.destination=scrFREventTestsQueue(306);return true;
        case "deeplabs":
            if(GameCont.area==303 && GameCont.subarea==0) {
                _record.destination=scrFREventTestsQueue(303);return true;
            }
            if(!_live.entrance.entranceopen) return false;
            scrFREventTestsMove(_p,_live.entrance.x,_live.entrance.y);
            return false;
    }
    return false;
}
function scrFREventTestsCleanupCheck(_driver) {
    var _record=_driver.fr_event_record;
    for(var _i=0;_i<array_length(_record.events);++_i) {
        var _name=_record.events[_i],_counts=scrFREventTestsCounts(_record,_name);
        assert(!instance_exists(_record.event_controllers[_i]) && !instance_exists(scrFREventTestsController(_name)),
            "NTUF event controller survived a real room cleanup: "+_name);
        if(variable_struct_exists(_driver.fr_event_original,_name+"_cleanup"))
            assert(_counts.cleanup==1,"NTUF on_cleanup source callback skipped or called twice: "+_name);
    }
    for(var _i=0;_i<array_length(_record.bindings);++_i) assert(!instance_exists(_record.bindings[_i]),
        "NTUF event-owned native binding leaked into the neutral room");
    assert(array_length(scrFRModCallArray("mod","libEvents","event_get_active",[all]))==0,
        "NTUF neutral generation inherited an old active event");
    if(scrFRArrayFindIndex(_record.events,"MeteorShower")>=0 || scrFRArrayFindIndex(_record.events,"ScrapyardsNight")>=0
        || scrFRArrayFindIndex(_record.events,"Aurora")>=0 || scrFRArrayFindIndex(_record.events,"CoastNight")>=0)
        assert(!scrFRModGet("mod","Frontier_Events","isNight"),"NTUF night cleanup left daytime in night state");
    if(scrFRArrayFindIndex(_record.events,"CoastNight")>=0) {
        var _assets=scrFRModGet("mod","teassets","spr"),_vars=global.fr_module_vars[$ "mod:Frontier_Events"];
        assert(_assets.FloorCoast==_vars.sprFloorCoast && _assets.CoastTrans==_vars.sprCoastTrans
            && _assets.PalankingChunk==_vars.sprCompatPalankingChunk
            && _assets.PalankingBott==_vars.sprCompatPalankingBott,
            "NTUF CoastNight cleanup failed to restore shared NTTE sprite consumers");
    }
    if(variable_struct_exists(_record,"casino_music")) assert(!audio_is_playing(_record.casino_music)
        && !audio_is_playing(_record.sewer_music),"NTUF Casino cleanup leaked event audio handles");
    scrFREventTestsRegistered();_record.cleanup_room_observed=true;
    array_push(_driver.fr_event_results,_record);scrNTTESmokeLog("NTUF EVENT/ENTRY PASS "+json_stringify(_record));
}
function scrFREventTestsStep(_driver) {
    if(_driver.fr_event_phase==9) {
        assert(array_length(_driver.fr_event_results)==32,"NTUF event/entry acceptance skipped a case");
        scrFREventTestsInstrument(_driver,false);
        for(var _i=0;_i<array_length(_driver.fr_event_options);++_i) {
            var _entry=_driver.fr_event_options[_i],_s=_entry[0];scrFRModSet(_s[0],_s[1],_s[2],_entry[1]);
        }
        global.__debug_immortality=_driver.fr_event_immortal;UberCont.opt_practice=_driver.fr_event_practice;
        scrFRPlayerSetRace(0,_driver.fr_event_player_race);scrFRPlayerSetSkin(0,_driver.fr_event_player_skin);
        global.fr_event_test_driver=undefined;_driver.fr_event_phase=10;
        scrNTTESmokeLog("NTUF EVENTS32 real registry / async generation / source callbacks / dark-weather / cleanup / natural entries PASS");
        return true;
    }
    if(_driver.fr_event_phase==10) return true;
    _driver.fr_event_ticks++;
    scrFREventTestsDropdownObserve(_driver);
    assert(_driver.fr_event_ticks<10000,"NTUF event acceptance timed out case="+string(_driver.fr_event_index)
        +" phase="+string(_driver.fr_event_phase)+" live="+string(_driver.fr_event_live.phase));
    var _case=_driver.fr_event_cases[_driver.fr_event_index],_death_window=_case.kind=="cyberspace"
        && _driver.fr_event_live.phase>=1 && _driver.fr_event_live.phase<=2;
    if(!_death_window) with(Player) {hp=100000;max_hp=100000;nexthurt=current_frame+100000;speed=0;can_walk=false;can_aim=false;}
    if(_driver.fr_event_phase==1 || _driver.fr_event_phase==6) {
        var _neutral=_driver.fr_event_phase==6;scrFREventTestsGenerate(_driver);_driver.fr_event_phase=_neutral?7:2;return false;
    }
    if(instance_exists(GenCont) || instance_exists(FloorMaker) || scrGameIsGenerationScreen()
        || (!instance_exists(Player) && !(_death_window && _driver.fr_event_phase==4))) return false;
    if(_driver.fr_event_phase==2) {_driver.fr_event_source_ticks=0;_driver.fr_event_phase=3;}
    if(_driver.fr_event_phase==3) {
        if(scrFRReadyTick()) _driver.fr_event_source_ticks++;
        if(_driver.fr_event_source_ticks<24) return false;
        scrFREventTestsInspect(_driver);_driver.fr_event_phase=4;return false;
    }
    if(_driver.fr_event_phase==4) {
        var _done=_case.kind=="event"?scrFREventTestsEventsStep(_driver):scrFREventTestsEntryStep(_driver);
        if(!_done) return false;
        // A new actual, event-free native room disposes event controllers and
        // bindings. Cleanup observers are invoked by that lifecycle only.
        _driver.fr_event_record.live_source_ticks=_driver.fr_event_live.ticks;
        scrFREventTestsPrepare(_driver,2,1,0,[],true);return false;
    }
    if(_driver.fr_event_phase==7) {
        if(scrFRReadyTick()) _driver.fr_event_source_ticks++;
        if(_driver.fr_event_source_ticks<24) return false;
        scrFREventTestsCleanupCheck(_driver);scrFREventTestsNext(_driver);
    }
    return false;
}

// Focused regression for real source props and the original queued sign.
// The engine owns Begin Step, movement, Draw and binding cleanup throughout.
function scrFRObstacleWeatherTestsStart(_driver,_rate=30) {
    assert(os_type==os_windows && scrNTTEFullSmokeEnabled(),
        "NTUF scenery/weather acceptance requires the isolated native runner");
    save_set_value("options","framerate",_rate);
    save_set_value("options","autopause",false);
    save_set_value("visual","freezeframes",0);
    save_set_value("visual","bossintro",false);
    scrOptionsUpdate();scrNTTEFullRateApply();
    assert(game_get_speed(gamespeed_fps)==_rate && UberCont.opt_framerate==_rate
        && abs(timescale-30/_rate)<.0001,"Scenery/weather acceptance did not apply its real native frame rate");
    var _volume=UberCont.opt_sndvol;UberCont.opt_sndvol=0;
    _driver.fr_prop_weather={ticks:0,props:[],x:[],y:[],hp:[],bindings:[],seen:0,
        max_height:-1000,pixel_coverage:0,pixel_ink:0,captured:false,done:false};
    var _state=_driver.fr_prop_weather;
    try {
        var _battery=scrFRModCallArray("area","robocenter","Battery_create",[12016,12016]),
            _statue=scrFRModCallArray("mod","Frontier_Objects","OasisStatue_create",[12272,12016,1]);
        assert(instance_exists(_battery) && instance_exists(_statue)
            && _battery.object_index==FRCustomProp && _statue.object_index==FRCustomProp,
            "NTUF scenery fixture did not construct its actual authored props");
        _state.props=[_battery,_statue];
        for(var _i=0;_i<array_length(_state.props);++_i) {
            var _prop=_state.props[_i],_before=_prop.hp,
                _blast=instance_create(_prop.x-8,_prop.y,Explosion);
            _blast.team=team_player;
            // Execute the real native explosion hit with the same physical
            // self/other as Collision_hitme. Its force precedes source hurt.
            with(_prop) with(_blast) assert(scr_explosion_generic_hit(),
                "NTUF scenery did not accept its real explosion collision");
            instance_destroy(_blast,false);
            assert(_prop.hp==_before-5 && _prop.speed>0,
                "NTUF scenery fixture missed HP loss or the actual explosion impulse");
            array_push(_state.x,_prop.x);array_push(_state.y,_prop.y);array_push(_state.hp,_prop.hp);
        }
        var _movable=instance_create(12528,12016,FRCustomProp);
        _movable.immmovable=false;_movable.speed=2*timescale;_movable.direction=0;
        _movable.spr_idle=sprHydrant;_movable.spr_hurt=sprHydrantHurt;
        _movable.sprite_index=sprHydrantDead;_movable.image_speed=0;
        _state.movable=_movable;_state.movable_start=_movable.x;
        // This is the original entrance and its native animation, with a real
        // native clear Portal. No opening callback or completion flag is
        // supplied by the fixture; the engine advances every host frame.
        _state.door=scrFRModCallArray("area","robocenter","DeeplabsEntrance_create",[13040,12016]);
        _state.door_portal=instance_create(13296,12016,Portal);_state.door_portal.image_alpha=0;
        _state.door_opening_seen=false;_state.door_opened=false;
        _driver.fr_prop_death_calls=0;_driver.fr_prop_destroy_calls=0;
        var _doomed=instance_create(12784,12016,FRCustomProp);
        _doomed.fr_test_owner=_driver;
        _doomed.on_death=function(){fr_test_owner.fr_prop_death_calls++;};
        _doomed.on_destroy=function(){fr_test_owner.fr_prop_destroy_calls++;};
        _doomed.hp=0;_state.doomed=_doomed;
        assert(array_length(scrFRMatching(FRCustomObject,"name","fr_EventDropdownController"))==0,
            "NTUF weather fixture started with an unrelated queued sign");
        // Use the original module queue/factory/controller/draw code; the
        // fixture never fabricates a sign, its pose, or a completion flag.
        scrFRModCallArray("mod","Frontier_Events","EventDropdown_queue",[1,0,-1]);
        scrFRModCallArray("mod","Frontier_Events","EventDropdown_queue",[4,0,-1]);
        var _controllers=scrFRMatching(FRCustomObject,"name","fr_EventDropdownController");
        assert(array_length(_controllers)==1 && array_length(_controllers[0].dropdownsQueue)==2,
            "NTUF original weather queue lost or duplicated its queued signs");
        _state.controller=_controllers[0];
        scrNTTESmokeLog("NTUF SCENERY/WEATHER native lifecycle began rate="+string(_rate)+" scale="+string(timescale));
    } finally {UberCont.opt_sndvol=_volume;}
}

function scrFRObstacleWeatherTestsStep(_driver) {
    var _state=_driver.fr_prop_weather;if(_state.done) return true;
    _state.ticks++;
    assert(instance_exists(_state.door) && instance_exists(_state.door_portal),
        "NTUF entrance animation fixture lost its original door or real native Portal");
    if(_state.door.sprite_index==_state.door.spr_opening) _state.door_opening_seen=true;
    if(_state.door.entranceopen && _state.door.sprite_index==_state.door.spr_open) _state.door_opened=true;
    if(_state.ticks>=30) assert(_state.door_opening_seen && _state.door_opened,
        "NTUF original DeepLabs entrance missed its native animation end between source ticks");
    for(var _i=0;_i<array_length(_state.props);++_i) {
        var _prop=_state.props[_i];
        assert(instance_exists(_prop) && _prop.hp==_state.hp[_i],
            "NTUF hit scenery kept losing HP after its projectile was gone");
        assert(abs(_prop.x-_state.x[_i])<.0001 && abs(_prop.y-_state.y[_i])<.0001 && _prop.speed==0,
            "NTUF immovable scenery drifted between real native Begin Step events");
        if(_state.ticks>=10) assert(_prop.sprite_index==_prop.spr_idle,
            "NTUF scenery never recovered its idle pose after its original hurt timer");
    }
    assert(instance_exists(_state.movable) && _state.movable.sprite_index==sprHydrantDead,
        "NTUF prop upkeep overwrote a source special animation");
    if(_state.ticks>=2) assert(_state.movable.x>_state.movable_start && _state.movable.speed>0,
        "NTUF prop upkeep froze an explicitly movable prop");
    if(_state.ticks>=2) assert(!instance_exists(_state.doomed)
        && _driver.fr_prop_death_calls==1 && _driver.fr_prop_destroy_calls==1,
        "NTUF prop upkeep skipped or repeated source death/destroy callbacks");
    var _controller=_state.controller;
    assert(instance_exists(_controller),"NTUF original weather queue controller vanished before its queue completed");
    var _bindings=[];
    with(FRBinding) if(fr_binding_kind=="draw" && creator==_controller) array_push(_bindings,id);
    for(var _i=0;_i<array_length(_bindings);++_i) {
        var _binding=_bindings[_i];
        if(!array_contains(_state.bindings,_binding)) {
            array_push(_state.bindings,_binding);_state.seen++;
            scrNTTESmokeLog("NTUF WEATHER original draw binding "+json_stringify({id:real(_binding),
                frame:current_frame,height:_binding.height,visible:_binding.visible,depth:_binding.depth,
                args:_binding.fr_binding_args}));
        }
        _state.max_height=max(_state.max_height,_binding.height);
        if(!_state.captured && _binding.height>=12 && _binding.height<=30) {
            scrFRWeatherScreenProof(_binding,"ntuf-weather-final-screen-"
                +string(game_get_speed(gamespeed_fps))+".png");
            // Draw the same receiver/event once into a real offscreen target.
            // Normal host Draw must already have advanced height into view.
            var _capture=scrFRVisualCapture("actor-event",ceil(view_width),ceil(view_height),
                view_xview,view_yview,[_binding]);
            try {
                _state.pixel_coverage=_capture.coverage;_state.pixel_ink=_capture.ink;
                assert(_capture.coverage>100 && _capture.ink>50 && _capture.top<60,
                    "NTUF original weather sign callback did not draw real visible artwork near the viewport top");
                scrFRVisualSave(_capture,"ntuf-weather-dropdown-native-"+string(game_get_speed(gamespeed_fps))+".png");
                _state.captured=true;
            } finally {scrFRVisualFree(_capture);}
        }
    }
    if(_state.ticks<180) return false;
    scrNTTESmokeLog("NTUF SCENERY/WEATHER observed "+json_stringify({ticks:_state.ticks,
        seen:_state.seen,max_height:_state.max_height,index:_controller.arrayIndex,
        allowed:_controller.dropdownAllowed,remaining_bindings:array_length(_bindings),
        coverage:_state.pixel_coverage,ink:_state.pixel_ink,scale:timescale,
        entrance_opening_seen:_state.door_opening_seen,entrance_opened:_state.door_opened}));
    assert(_state.seen==2 && _state.max_height>=20 && _state.captured
        && _controller.arrayIndex==2 && _controller.dropdownAllowed && array_length(_bindings)==0,
        "NTUF original weather signs did not descend, render, queue and retire through native Draw events");
    for(var _i=0;_i<array_length(_state.props);++_i) if(instance_exists(_state.props[_i])) instance_destroy(_state.props[_i],false);
    if(instance_exists(_state.movable)) instance_destroy(_state.movable,false);
    if(instance_exists(_state.door)) instance_destroy(_state.door,false);
    if(instance_exists(_state.door_portal)) instance_destroy(_state.door_portal,false);
    instance_destroy(_controller,false);_state.done=true;
    return true;
}

function scrFRAnimationEndTests() {
    var _before=scrNTTEFullInstances(all),_scale=global.time_scale,
        _render=global.fr_render_context,_override=global.fr_source_scale_override,_rows=[];
    try {
        var _portal=instance_create(14576,14000,Portal);_portal.image_alpha=0;
        for(var _pass=0;_pass<2;++_pass) {
            var _rate=_pass==0?30:60;global.time_scale=30/_rate;
            global.fr_render_context=false;global.fr_source_scale_override=undefined;
            var _door=scrFRModCallArray("area","robocenter","DeeplabsEntrance_create",[14000,14000]);
            _door.sprite_index=_door.spr_opening;_door.image_speed=.4*timescale;
            // At60 the next physical frame stays below the end, but the next
            // source callback crosses it. This deliberately exercises the
            // blind interval that the native-rate raw check used to miss.
            _door.image_index=_door.image_number-.3;
            var _legacy=(_door.image_index+_door.image_speed)>=_door.image_number;
            with(_door) scrFRModCallArray("area","robocenter","DeeplabsEntrance_step",[]);
            assert(_door.entranceopen && _door.sprite_index==_door.spr_open,
                "NTUF actual authored entrance missed the source interval animation boundary at"+string(_rate));
            if(_rate==60) assert(!_legacy,"NTUF60 animation boundary positive control did not straddle native frames");
            // The helper is an observer: speed and ordinary raw fields retain
            // physical host-frame units. Reverse and stopped animations keep
            // their original endpoint predicates too.
            assert(abs(_door.image_speed-.4*timescale)*1000000<1,"NTUF animation boundary adapter changed native animation speed");
            _door.sprite_index=_door.spr_opening;_door.image_index=.3;_door.image_speed=-.4*timescale;
            var _reverse=false;with(_door) _reverse=scrFRAnimationEnd();
            assert(_reverse,"NTUF source animation boundary lost reverse playback");
            _door.image_speed=0;
            var _stopped=true;with(_door) _stopped=scrFRAnimationEnd();
            assert(!_stopped,"NTUF source animation boundary completed a stopped animation");
            _door.image_index=_door.image_number-.3;_door.image_speed=.4*timescale;
            global.fr_render_context=true;
            var _draw=false;with(_door) _draw=scrFRAnimationEnd();
            assert(_draw==_legacy,"NTUF render-phase animation boundary changed its physical-frame horizon");
            global.fr_render_context=false;
            array_push(_rows,{rate:_rate,legacy_end:_legacy,source_end:_door.entranceopen,reverse_end:_reverse,draw_end:_draw});
            instance_destroy(_door,false);
        }
        scrNTTESmokeLog("NTUF ANIMATION BOUNDARY actual source door PASS "+json_stringify(_rows));
    } finally {
        global.time_scale=_scale;global.fr_render_context=_render;global.fr_source_scale_override=_override;
        scrNTTEFullMergedRuntimeTestCleanup(_before);
    }
}

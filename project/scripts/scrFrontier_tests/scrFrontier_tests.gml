// Explicit Windows test cases; none are invoked in ordinary or mobile games.
function scrFRIntegrationTestStart(_case) {
    if(os_type!=os_windows || !scrNTTEFullSmokeEnabled()) throw "Frontier tests require the isolated desktop harness";
    var _driver=instance_create(0,0,FRIntegrationTest);
    _driver.fr_test_case=_case;
    global.fr_test_trace_requested=false;global.fr_test_trace=false;
    for(var _i=1;_i<=parameter_count();++_i)
        if(parameter_string(_i)=="--ntuf-trace") global.fr_test_trace_requested=true;
    // Native Continue activates every inactive instance. Retire the original
    // dispatcher on handoff so unpausing cannot execute its tick-1 case again
    // and construct a second integration driver in the same live world.
    with(NTTESmokeTest) instance_destroy(id,false);
    // Room setup and rate changes may reload native options. Persist the
    // background runner's focus policy in its isolated save as well.
    save_set_value("options","autopause",false);
    UberCont.opt_autopause=false;UberCont.paused=false;UberCont.opt_freeze=0;
    assert(!save_get_option("options","autopause",true) && !UberCont.opt_autopause,
        "Frontier background acceptance enabled focus-loss pause");
    GameCont.is_level_ended=true;
    scrNTTESmokeLog("FRONTIER TEST START "+_case);
}

function scrFRIntegrationTestStep() {
// BEGIN FRONTIER PALACE BLOCK TEST DRIVER
if(fr_test_case=="palace-block") {
    if(!variable_instance_exists(id,"fr_palace_blocks")) {
        if(!scrFRReadyTick()) return;
        if(++fr_test_ticks<45) return;
        scrFRPalaceBlockTestsStart(id);
    }
    if(scrFRPalaceBlockTestsStep(id)) {
        scrNTTESmokeLog("PASS full internal selected implemented branches; not complete MOD coverage");
        game_end();
    }
    return;
}
// END FRONTIER PALACE BLOCK TEST DRIVER

    if(fr_test_case=="scary-face" && variable_instance_exists(id,"fr_scary_face")) {
        if(scrFRScaryFaceTestsStep(id)) {
            scrNTTESmokeLog("PASS full internal selected implemented branches; not complete MOD coverage");
            game_end();
        }
        return;
    }
    if(fr_test_case=="menu_audio" && variable_instance_exists(id,"fr_menu_audio")) {
        if(scrFRMenuAudioTestsStep(id)) {
            scrNTTESmokeLog("PASS full internal selected implemented branches; not complete MOD coverage");
            game_end();
        }
        return;
    }
    if(fr_test_case=="captain_chair" && variable_instance_exists(id,"fr_captain_chair")) {
        if(scrFRCaptainChairTestsStep(id)) {
            scrNTTESmokeLog("PASS full internal selected implemented branches; not complete MOD coverage");
            game_end();
        }
        return;
    }
    if(fr_test_case=="proto-chest" && variable_instance_exists(id,"fr_proto_chest")) {
        if(scrFRProtoChestTestsStep(id)) {
            scrNTTESmokeLog("PASS full internal selected implemented branches; not complete MOD coverage");
            game_end();
        }
        return;
    }
    if(fr_test_case=="restart" && variable_instance_exists(id,"fr_restart")) {
        if(scrFRRestartTestsStep(id)) {
            scrNTTESmokeLog("PASS full internal selected implemented branches; not complete MOD coverage");
            game_end();
        }
        return;
    }
    if((fr_test_case=="bubbles-startup-a" || fr_test_case=="bubbles-startup-b" || fr_test_case=="bubbles-random")
        && variable_instance_exists(id,"fr_bubbles_startup")) {
        if(scrFRBubblesStartupTestsStep(id)) {
            scrNTTESmokeLog("PASS FRONTIER Bubbles real native menu/new-run, starter, A/B, English/CJK and30/60Hz");
            scrNTTESmokeLog("PASS full internal selected implemented branches; not complete MOD coverage");
            game_end();
        }
        return;
    }
    if(fr_test_case=="ground-weapon" && variable_instance_exists(id,"fr_ground_weapon")) {
        if(scrFRGroundWeaponTestsStep(id)) {
            scrNTTESmokeLog("PASS full internal selected implemented branches; not complete MOD coverage");
            game_end();
        }
        return;
    }
    if(fr_test_case=="player-wall" && variable_instance_exists(id,"fr_player_wall")) {
        if(scrFRPlayerWallTestsStep(id)) {
            scrNTTESmokeLog("PASS full internal selected implemented branches; not complete MOD coverage");
            game_end();
        }
        return;
    }
    if(fr_test_case=="lifecycle" && variable_instance_exists(id,"fr_lifecycle")) {
        if(scrFRLifecycleTestsStep(id)) {
            scrNTTESmokeLog("PASS FRONTIER native pause, mutation and generation lifecycle at30/60Hz");
            scrNTTESmokeLog("PASS full internal selected implemented branches; not complete MOD coverage");
            game_end();
        }
        return;
    }
    if(!scrFRReadyTick()) {
        fr_test_wait_ticks=(self[$ "fr_test_wait_ticks"]??0)+1;
        if(fr_test_wait_ticks mod 300==0)
            scrNTTESmokeLog("FRONTIER TEST WAIT "+json_stringify({kind:fr_test_case,
                enabled:scrFREnabled(),world:instance_exists(FRWorld),paused:UberCont.paused,
                logic:instance_exists(FRWorld)?FRWorld.logic_tick:false,
                serial:instance_exists(FRWorld)?FRWorld.logic_serial:-1,
                frame:current_frame,scale:timescale,lockstep:lockstep_stop,
                generators:instance_number(GenCont),makers:instance_number(FloorMaker),
                floors:instance_number(Floor),tops:instance_number(TopCont),players:instance_number(Player)}));
        return;
    }
    fr_test_ticks++;
    global.fr_test_trace=global.fr_test_trace_requested && fr_test_ticks>=46 && fr_test_ticks<=80;
    if(fr_test_ticks mod 300==0)
        scrNTTESmokeLog("FRONTIER TEST HEARTBEAT "+json_stringify({kind:fr_test_case,ticks:fr_test_ticks,
            phase:self[$ "fr_area_phase"]??self[$ "fr_event_phase"]??self[$ "fr_continue_phase"]??-1,
            generators:instance_number(GenCont),makers:instance_number(FloorMaker),floors:instance_number(Floor)}));
    if(fr_test_ticks==45) {
        assert(scrFREnabled(),"Frontier modules were not enabled");
        var _ids=variable_struct_get_names(global.fr_weapon_keys);
        assert(array_length(_ids)==77,"Frontier weapon registry did not contain77 authored weapons");
        assert(array_length(variable_struct_get_names(global.fr_skill_keys))==26,"Frontier mutation registry incomplete");
        assert(array_length(variable_struct_get_names(global.fr_area_keys))==6,"Frontier area registry incomplete");
        scrNTTESmokeLog("FRONTIER BOOT REGISTRIES OK tasks="+string(array_length(global.fr_tasks)));
        switch(fr_test_case) {
            case "core":scrFRCoreTests();break;
            case "skills":scrFRSkillTestsStart(id);break;
            case "options":scrFROptionTests();break;
            case "unlocks":scrFRUnlockTestsStart(id);break;
            case "visual":scrFRVisualTestsStart(id);break;
            case "events":scrFREventTestsStart(id);break;
            case "prompts":scrFRPromptHUDTests();break;
            case "wall-fixes":scrFRWallFixTests();break;
            case "player-wall":scrFRPlayerWallTestsStart(id);break;
            case "ground-weapon":scrFRGroundWeaponTestsStart(id);break;
            case "proto-chest":scrFRProtoChestTestsStart(id);break;
            case "restart":scrFRRestartTestsStart(id);break;
            case "captain_chair":scrFRCaptainChairTestsStart(id);break;
            case "menu_audio":scrFRMenuAudioTestsStart(id);break;
            case "scary-face":scrFRScaryFaceTestsStart(id);break;
            case "scenery-weather":scrFRObstacleWeatherTestsStart(id);break;
            case "scenery-weather60":scrFRObstacleWeatherTestsStart(id,60);break;
            case "lifecycle":scrFRLifecycleTestsStart(id);break;
            case "progression":scrFRProgressionTestsStart(id);break;
            case "performance":scrFRPerformanceTestsStart(id);break;
            case "robocenter-perf":scrFRRobocenterPerformanceTests();break;
            case "deeplabs-perf":scrFRDeeplabsPerformanceTests();break;
            case "weather-perf":scrFRWeatherPerformanceTests();break;
            case "menu-repairs":scrFRMenuRepairTests();break;
            case "fly-wall":scrFRFlyWallTestsStart(id);break;
            case "localization":scrFRLocalizationTests();break;
            case "millipede":scrFRMillipedeTestsStart(id);break;
            case "race":scrFRRaceTestsStart();break;
            case "bubbles-startup-a":scrFRBubblesStartupTestsStart(id,0);break;
            case "bubbles-startup-b":scrFRBubblesStartupTestsStart(id,1);break;
            case "bubbles-random":scrFRBubblesStartupTestsStart(id,0,true);break;
            case "areas":scrFRAreaTestsStart(id);break;
            case "weapons":scrFRWeaponTestsStart(id);break;
            case "continue-write":scrFRContinueTestsStart(id,"write");break;
            case "continue-read":scrFRContinueTestsStart(id,"read");break;
        }
        if(fr_test_case=="wall-fixes" || fr_test_case=="robocenter-perf"
            || fr_test_case=="deeplabs-perf" || fr_test_case=="localization" || fr_test_case=="weather-perf" || fr_test_case=="menu-repairs") {
            scrNTTESmokeLog("PASS FRONTIER focused native regression "+fr_test_case);
            scrNTTESmokeLog("PASS full internal selected implemented branches; not complete MOD coverage");
            game_end();return;
        }
        if(fr_test_case=="core" || fr_test_case=="options" || fr_test_case=="prompts") {
            fr_test_target=instance_create(10016,10016,FRCustomObject);
            with(fr_test_target) fr_tests_frontier_gml_coroutine();
            assert(fr_test_target.fr_custom_actor && fr_test_target.value==1,
                "Fork parent did not initialize and continue immediately");
        }
    }
    if(fr_test_ticks==48 && (fr_test_case=="core" || fr_test_case=="options" || fr_test_case=="prompts")) {
        assert(instance_exists(fr_test_target) && fr_test_target.value==13,"Frontier fork/wait lost continuation state");
        if(fr_test_case=="core") assert(GameCont.fr_cleanup_test==17 && GameCont.fr_cleanup_fork_test==18,
            "Destroyed source cleanup lost delayed field/global restoration or its nested fork");
        instance_destroy(fr_test_target,false);
        scrNTTESmokeLog("PASS FRONTIER "+fr_test_case+" bootstrap and native runtime core");
        scrNTTESmokeLog("PASS full internal selected implemented branches; not complete MOD coverage");
        game_end();
    }
    if(fr_test_ticks>45 && fr_test_case=="fly-wall" && scrFRFlyWallTestsStep(id)) {
        scrNTTESmokeLog("PASS full internal selected implemented branches; not complete MOD coverage");
        game_end();return;
    }
    if(fr_test_ticks>45 && fr_test_case=="skills" && scrFRSkillTestsStep(id)) {
        scrNTTESmokeLog("PASS FRONTIER 26 acquired mutation callbacks and ownership round trips");
        scrNTTESmokeLog("PASS full internal selected implemented branches; not complete MOD coverage");
        game_end();
    }
    if(fr_test_ticks>45 && fr_test_case=="millipede" && scrFRMillipedeTestsStep(id)) {
        scrNTTESmokeLog("PASS FRONTIER focused native Millipede live-chain lifecycle at30/60Hz");
        scrNTTESmokeLog("PASS full internal selected implemented branches; not complete MOD coverage");
        game_end();
    }
    if(fr_test_ticks>45 && fr_test_case=="race") {
        var _result=scrFRRaceTestsStep();
        if(_result.done) {
            scrNTTESmokeLog("FRONTIER RACE CHECKS "+json_stringify(_result.checks));
            assert(_result.ok,"Frontier race acceptance checks failed");
            scrNTTESmokeLog("PASS FRONTIER Bubbles A/B, original abilities, ultras, hidden transformations and native clock");
            scrNTTESmokeLog("PASS full internal selected implemented branches; not complete MOD coverage");
            game_end();
        }
    }
    if(fr_test_ticks>45 && fr_test_case=="areas" && scrFRAreaTestsStep(id)) {
        scrNTTESmokeLog("PASS FRONTIER six native areas across 31 generation cases, live encounters and route transitions");
        scrNTTESmokeLog("PASS full internal selected implemented branches; not complete MOD coverage");
        game_end();
    }
    if(fr_test_ticks>45 && fr_test_case=="weapons" && scrFRWeaponTestsStep(id)) {
        scrNTTESmokeLog("PASS FRONTIER real weapon fire and state compatibility");
        scrNTTESmokeLog("PASS full internal selected implemented branches; not complete MOD coverage");
        game_end();
    }
    if(fr_test_ticks>45 && fr_test_case=="unlocks" && scrFRUnlockTestsStep(id)) {
        scrNTTESmokeLog("PASS FRONTIER authored unlock, popup and death portrait lifecycle");
        scrNTTESmokeLog("PASS full internal selected implemented branches; not complete MOD coverage");
        game_end();
    }
    if(fr_test_ticks>45 && fr_test_case=="visual" && scrFRVisualTestsStep(id)) {
        scrNTTESmokeLog("PASS FRONTIER real GPU sprite and UI pixel comparisons with positive controls");
        scrNTTESmokeLog("PASS full internal selected implemented branches; not complete MOD coverage");
        game_end();
    }
    if(fr_test_ticks>45 && fr_test_case=="events" && scrFREventTestsStep(id)) {
        scrNTTESmokeLog("PASS FRONTIER registered events, cleanup and six authored natural entrances");
        scrNTTESmokeLog("PASS full internal selected implemented branches; not complete MOD coverage");
        game_end();
    }
    if(fr_test_ticks>45 && (fr_test_case=="scenery-weather" || fr_test_case=="scenery-weather60") && scrFRObstacleWeatherTestsStep(id)) {
        scrNTTESmokeLog("PASS FRONTIER scenery/weather native lifecycle");
        scrNTTESmokeLog("PASS full internal selected implemented branches; not complete MOD coverage");
        game_end();
    }
    if(fr_test_ticks>45 && fr_test_case=="progression" && scrFRProgressionTestsStep(id)) {
        scrNTTESmokeLog("PASS full internal selected implemented branches; not complete MOD coverage");game_end();
    }
    if(fr_test_ticks>45 && fr_test_case=="performance" && scrFRPerformanceTestsStep(id)) {
        scrNTTESmokeLog("PASS full internal selected implemented branches; not complete MOD coverage");game_end();
    }
    if(fr_test_ticks>45 && (fr_test_case=="continue-write" || fr_test_case=="continue-read") && scrFRContinueTestsStep(id)) {
        scrNTTESmokeLog("PASS FRONTIER "+fr_test_case+" real native checkpoint and source state");
        scrNTTESmokeLog("PASS full internal selected implemented branches; not complete MOD coverage");
        game_end();
    }
}

function scrFRCoreTests() {
    scrNTTESmokeLog("FRONTIER CORE START values and references");
    assert(is_real(scrFRSelf(Player.id)) && instance_exists(scrFRSelf(Player.id)),
        "Legacy source self must remain a real instance ID for authored context guards");
    scrFRPlayerCompatTests();
    scrFRCyberspaceReviveTests();
    scrFRAmmoTests();
    scrFRButtonInputTests();
    scrFRSoundAssignmentTests();
    scrFRVisibilityTests();
    scrFRRawMotionTests();
    scrFRAnimationEndTests();
    scrFRDrawRandomSequenceTests();
    scrFRSourceRandomTests();
    scrFRTerrainRoomTests();
    scrFRStatusTimerTests();
    scrFRPathGridTests();
    scrFRHyperCrystalCompatTests();
    scrFRIrisProjectileTests();
    scrFRIDPDSpawnCompatTests();
    scrFRQueryUnionTests();
    scrFRSwarmbotPerformanceTests();
    scrFRLibPhaseTests();
    var _old_lib=scrFRLibGlobal(),_hook_count=array_length(_old_lib.activeHooks);
    _old_lib.lastUpdatedFrame=scrFRSourceFrame()-2;
    scrFRModCallArray("mod","lib","step",[]);
    var _new_lib=scrFRLibGlobal();
    assert(!instance_exists(_old_lib) && instance_exists(_new_lib)
        && array_length(_new_lib.activeHooks)==_hook_count && _hook_count>0,
        "Native library cache did not follow authored storage replacement and preserve subscriptions");
    scrNTTESmokeLog("FRONTIER CORE START module visibility");
    var _fixture_key="mod:__frontier_load_visibility_fixture";
    var _probe=function(){return 42;};
    scrNTTESmokeLog("FRONTIER CORE PROBE TYPE "+json_stringify({method:is_method(_probe),structure:is_struct(_probe),kind:typeof(_probe)}));
    scrFRRegisterModule(_fixture_key,{probe:_probe});
    try {
        assert(!scrFRModLoaded("mod",_fixture_key) && !scrFRScriptExists("mod",_fixture_key,"probe")
            && is_undefined(scrFRModCall("mod",_fixture_key,"probe")),
            "Statically registered future callbacks executed before their authored load point");
        scrNTTESmokeLog("FRONTIER CORE PROBE initially hidden");
        global.fr_initialized[$ _fixture_key]=true;
        assert(scrFRModLoaded("mod",_fixture_key) && scrFRModCall("mod",_fixture_key,"probe")==42,
            "Module callbacks did not become visible when initialization began");
        scrNTTESmokeLog("FRONTIER CORE PROBE dispatched");
    } finally {
        variable_struct_remove(global.fr_module_scripts,_fixture_key);
        variable_struct_remove(global.fr_module_vars,_fixture_key);
        variable_struct_remove(global.fr_initialized,_fixture_key);
        array_pop(global.fr_module_order);
    }
    scrNTTESmokeLog("FRONTIER CORE START with-data fixture");
    var _native_ref=instance_create(10016,10016,FRCustomObject);
    try {
        _native_ref.fr_array_probe=4;
        _native_ref.wep=wep_revolver;
        scrFRMaxHealthWrite(_native_ref,73);
        assert(_native_ref.max_hp==73,"Source corpse maxhealth assignment read an absent native health field");
        assert(array_length(scrFRMatching(_native_ref,"wep","energy chainsaw"))==0
            && array_length(scrFRMatchingNE(_native_ref,"wep","energy chainsaw"))==1
            && array_length(scrFRMatching(_native_ref,"wep",wep_revolver,"energy chainsaw"))==1,
            "Unloaded optional weapon queries must stay empty without hiding valid slots");
        fr_tests_frontier_gml_instance_array([_native_ref,real(_native_ref)]);
        assert(_native_ref.fr_array_probe==10,"Source with-array wrote a wrapper instead of the native entity");
        assert(scrFRScopeSame(_native_ref,self)==false && scrFRScopeSame(_native_ref,real(_native_ref)),
            "Native ref and legacy real instance scopes lost identity");
        assert(is_real(scrFRInstanceFind(FRCustomObject,0)),"Source instance_find did not return a real instance ID");
        var _created=scrFRInstanceCreate(10032,10032,FRCustomObject);
        assert(is_real(_created) && instance_exists(_created),"Source instance_create did not return a real instance ID");
        instance_destroy(_created,false);
    } finally {if(instance_exists(_native_ref)) instance_destroy(_native_ref,false);}
    var _payload={marker:42},_nested=[8,9];
    var _values=fr_tests_frontier_gml_values(["same","same",3,_payload,_nested,Bandit]);
    assert(array_length(_values)==6 && _values[0]=="same" && _values[1]=="same" && _values[2]==3,
        "Legacy with lost primitive data, order or duplicates");
    assert(_values[3].marker==42 && is_array(_values[4]) && _values[4][1]==9 && _values[5]==Bandit,
        "Legacy with flattened arrays, expanded object constants or lost structs");
    scrNTTESmokeLog("FRONTIER CORE START bound reference fixture");
    assert(fr_tests_frontier_gml_bound_ref()==432,"Bound script references changed argument order");
    scrFRCallbackReferenceTests();
    scrNTTESmokeLog("FRONTIER CORE START dynamic switch fixture");
    assert(fr_tests_frontier_gml_template("../sprites/")=="../sprites/sprPopoLaserBrain.png @1(3:0)",
        "Authored interpolation did not lower dynamic paths and text expressions");
    assert(fr_tests_frontier_gml_dynamic_case(2)==13 && fr_tests_frontier_gml_dynamic_case(7)==13
        && fr_tests_frontier_gml_dynamic_case(8)==88 && fr_tests_frontier_gml_dynamic_case(91)==3,
        "Runtime switch lowering changed labels, fallthrough or default order");
    scrNTTESmokeLog("FRONTIER CORE START NTTE adapter");scrFRNTTEAdapterTests();
    scrNTTESmokeLog("FRONTIER CORE START area registry");scrFRAreaTests();
    assert(is_undefined(scrFRAreaTryResolve("junkyard"))
        && array_length(scrFRMatching(GameCont,"area","junkyard","bigdog","ravenboss"))==0
        && array_length(scrFRMatching(GameCont,"area","junkyard",GameCont.area))==1
        && array_length(scrFRMatchingNE(GameCont,"area","junkyard"))==1,
        "Unloaded optional area queries must stay empty without hiding a valid native area");
    var _race_player=instance_find(Player,0);
    assert(is_undefined(scrFRRaceTryResolve("ace"))
        && is_undefined(scrFRRaceTryResolve("vanthro"))
        && is_undefined(scrFRRaceTryResolve("horsie"))
        && array_length(scrFRMatching(_race_player,"race","ace","vanthro","horsie"))==0
        && array_length(scrFRMatching(_race_player,"race","ace",_race_player.race))==1
        && array_length(scrFRMatchingNE(_race_player,"race","ace"))==1
        && scrFRRaceResolve("bubbles")==19,
        "Unloaded optional race queries hid a valid player or changed NE semantics");
    scrNTTESmokeLog("FRONTIER CORE START crown registry");scrFRCrownTests();
    scrNTTESmokeLog("FRONTIER CORE START Continue codec");scrFRContinueTests();
    scrNTTESmokeLog("FRONTIER CORE START local save lifecycle");scrFRSaveLoadTests();
    scrNTTESmokeLog("FRONTIER CORE START native weapon queries and chest");
    scrFRWeaponDropTests();
    assert(is_array(scrFRModGet("mod","Frontier_Projectiles","foundPirateWeps")),
        "Frontier save defaults were not available to dependent initializers");
    assert(scrFRWeaponResolve("energy bat")==144 && scrFRWeaponResolve("weapon:fossil cannon")==176
        && scrFRModLoaded("wep","energy bat") && scrFRModLoaded("weapon","fossil cannon"),
        "Existing native NTTE weapon identities were lost in Frontier module queries");
    var _pickups=scrNTTEFullInstances(all),_chest=instance_create(10016,10016,FRCustomObject);
    try {
        assert(!scrFRModLoaded("wep","chainsaw") && scrFRWeaponArea("chainsaw")==infinity,
            "Missing optional weapons must stay outside Frontier chest pools");
        with(_chest) scrFRModCall("mod","Frontier_Pickups","ToolKitChest_open");
        var _tools=scrFRMatching(WepPickup,"x",10016);
        assert(array_length(_tools)>=2,"Authored Toolkit chest did not create its two native weapon drops");
    } finally {scrNTTEFullMergedRuntimeTestCleanup(_pickups);}
    var _ids=variable_struct_get_names(global.fr_weapon_keys);
    for(var _i=0;_i<array_length(_ids);++_i) {
        var _weapon=real(_ids[_i]);
        assert(scr_weapon_is_valid(_weapon) && sprite_exists(scr_weapon_get_sprite(_weapon)),"Frontier native weapon artwork unavailable: "+string(_weapon));
    }
    var _skills=variable_struct_get_names(global.fr_skill_keys);
    for(var _i=0;_i<array_length(_skills);++_i) {
        var _skill=real(_skills[_i]),_icon=scrFRSkillIcon(_skill,false);
        assert(scr_skill_is_valid(_skill) && sprite_exists(_icon[0]),"Frontier skill metadata unavailable: "+string(_skill));
    }
    GameCont.fr_cleanup_test=0;GameCont.fr_cleanup_fork_test=0;
    var _cleanup=instance_create(10016,10016,FRCustomObject);
    _cleanup.cleanup_value=17;_cleanup.on_cleanup=fr_tests_frontier_gml_cleanup_coroutine;
    instance_destroy(_cleanup);
    scrNTTESmokeLog("PASS FRONTIER with-data, refs, dynamic-switch, NTTE adapters, six areas, crown and metadata");
}

function scrFRDrawRandomProbe() {array_push(global.fr_test_draw_random_values,random(1));}

function scrFRDrawRandomSequenceTests() {
    var _key="mod:__frontier_draw_random_fixture",_old_cache=global.fr_hook_cache,
        _old_skills=GameCont.fr_skills,_expected=[],_actual=[];
    global.fr_module_scripts[$ _key]={draw_dark:scrFRDrawRandomProbe};
    global.fr_hook_cache={draw_dark:[_key]};GameCont.fr_skills={};
    global.fr_test_draw_random_values=[];
    try {
        random_set_seed(751913);
        for(var _i=0;_i<8;++_i) array_push(_expected,random(1));
        random_set_seed(751913);
        for(var _i=0;_i<4;++_i) {
            array_push(_actual,random(1));
            scrFRDarkDraw("draw_dark",0,0);
            array_push(_actual,global.fr_test_draw_random_values[_i]);
        }
        assert(array_length(global.fr_test_draw_random_values)==4,
            "Actual draw callback was not dispatched once per rendering boundary");
        for(var _i=0;_i<8;++_i) assert(_actual[_i]==_expected[_i],
            "Darkness rendering restarted the native RNG instead of preserving authored random consumption");
        assert(_actual[0]!=_actual[2] && _actual[2]!=_actual[4],
            "RNG sequence positive control replayed the same frame prefix");
    } finally {
        global.fr_hook_cache=_old_cache;GameCont.fr_skills=_old_skills;
        variable_struct_remove(global.fr_module_scripts,_key);
        global.fr_test_draw_random_values=undefined;
    }
    scrNTTESmokeLog("PASS FRONTIER native RNG sequence continues through repeated real darkness draw dispatch");
}

function scrFRCallbackReferenceTests() {
    assert(is_undefined(scrFRCallArray([],[])),"Retired empty NTT callbacks must be a no-op");
    for(var _length=1;_length<=2;++_length) {
        var _rejected=false;
        try {scrFRCallArray(array_create(_length,0),[]);}
        catch(_error) {_rejected=string(_error)=="Malformed Frontier script reference";}
        assert(_rejected,"Truncated nonempty NTT references must remain invalid");
    }
    // Exercise the author's actual landing path: it calls cleanup, retires
    // on_cleanup with [], then destroys itself in the same source callback.
    var _before=scrNTTEFullInstances(all),_payload=instance_create(10016,10016,FRCustomObject);
    try {
        var _data_scope={tag:"source-data-with"},_data_actor;
        with(_data_scope) _data_actor=scrFRInstanceCreate(10032,10016,FRCustomObject);
        assert(instance_exists(_data_actor) && !variable_instance_exists(_data_actor,"hitid"),
            "Source creation from a data-with scope required a native id or acquired a false damage identity");
        assert(!scrFRVariableExists(_payload,"on_pick"),
            "Unassigned optional pickup callbacks must not satisfy the authored existence guard");
        _payload.mask_index=mskNone;_payload.depth=-10;_payload.angle=45;
        var _toss=scrFRModCall("mod","Frontier_Objects","ZAxisWeaponToss_create",10016,10016);
        assert(instance_exists(_toss),"Real source weapon toss factory returned no actor");
        _toss.creator=real(_payload);_toss.z=-1;_toss.zspeed=0;_toss.impactEffect=false;
        scrFRInvoke(_toss,["mod","Frontier_Objects","ZAxisWeaponToss_end_step"],[]);
        assert(!instance_exists(_toss) && instance_exists(_payload)
            && _payload.mask_index==mskPlayer && _payload.depth==-2 && _payload.angle==0,
            "Source weapon toss landing failed to restore its payload before retired-callback teardown");
    } finally {scrNTTEFullMergedRuntimeTestCleanup(_before);}
    scrNTTESmokeLog("PASS FRONTIER retired empty references, strict truncated references and real Z-axis weapon landing teardown");
}

function scrFRRawMotionTests() {
    // Run synchronously: each case samples the native physical-frame fields
    // and restores the live frame scale before the engine can advance.
    var _saved_scale=global.time_scale,_probe=instance_create(10016,10016,FRCustomObject);
    try {
        // GML's comparison epsilon can reject even zero with a tiny strict
        // bound. This expresses the same 1e-6 error bound at unit scale;
        // neither the clock nor the engine epsilon is altered for the test.
        var _zero_ok=abs(0.0)*1000000<1,_above_rejected=!(abs(0.000002)*1000000<1);
        scrNTTESmokeLog("FRONTIER RAW MOTION PRECISION "+json_stringify({epsilon:math_get_epsilon(),
            legacy_zero_accepted:abs(0.0)<0.000001,scaled_zero_accepted:_zero_ok,
            scaled_two_micro_units_rejected:_above_rejected}));
        assert(_zero_ok && _above_rejected,"Raw-motion scaled precision positive/negative controls failed");
        var _scales=[1,0.5];
        for(var _i=0;_i<array_length(_scales);++_i) {
            var _scale=_scales[_i];global.time_scale=_scale;
            _probe.hspeed=6*_scale;_probe.vspeed=-8*_scale;_probe.image_speed=0.25*_scale;
            var _read=[];with(_probe) _read=fr_tests_frontier_gml_raw_motion_read(id);
            var _invoked=scrFRInvoke(_probe,fr_tests_frontier_gml_raw_motion_read,[real(_probe)]);
            var _physical=[_probe.hspeed,_probe.vspeed,_probe.image_speed],
                _source=[_physical[0]/_scale,_physical[1]/_scale,_physical[2]/_scale],
                _expected=[6*_scale,-8*_scale,0.25*_scale];
            scrNTTESmokeLog("FRONTIER RAW MOTION READ "+json_stringify({scale:_scale,
                probe:real(_probe),caller:real(id),expected:_expected,native:_physical,
                direct:_read,dispatched:_invoked,
                exists:[variable_instance_exists(_probe,"hspeed"),variable_instance_exists(_probe,"vspeed"),
                    variable_instance_exists(_probe,"image_speed")],
                native_dynamic:[variable_instance_get(_probe,"hspeed"),variable_instance_get(_probe,"vspeed"),
                    variable_instance_get(_probe,"image_speed")],
                adapter_dynamic:[scrFRFieldGet(_probe,"hspeed_raw"),scrFRFieldGet(_probe,"vspeed_raw"),
                    scrFRFieldGet(_probe,"image_speed_raw")]}));
            for(var _j=0;_j<3;++_j)
                assert(abs(_physical[_j]-_expected[_j])*1000000<1,
                    "Native motion assignment exceeded the original 1e-6 precision bound");
            var _results=[_read,_invoked];
            for(var _dispatch=0;_dispatch<array_length(_results);++_dispatch) {
                var _sample=_results[_dispatch];
                assert(is_array(_sample) && array_length(_sample)==17
                    && scrFRScopeSame(_sample[15],_probe) && scrFRScopeSame(_sample[16],_probe),
                    "Direct/dispatched raw motion fixture lost its native instance scope");
                for(var _j=0;_j<3;++_j) {
                    assert(abs(_sample[_j]-_physical[_j])*1000000<1
                        && abs(_sample[_j+6]-_physical[_j])*1000000<1
                        && abs(_sample[_j+9]-_physical[_j])*1000000<1,
                        "Raw bare/member/dynamic reads must sample native physical-frame velocity");
                    assert(abs(_sample[_j+3]-_source[_j])*1000000<1
                        && abs(_sample[_j+12]-_source[_j])*1000000<1,
                        "Non-raw bare/dynamic reads lost source logical-tick velocity");
                }
            }
            assert(scrFRVariableExists(_probe,"hspeed_raw")
                && scrFRVariableExists(_probe,"vspeed_raw")
                && scrFRVariableExists(_probe,"image_speed_raw")
                && scrFRFieldGet(_probe,"hspeed_raw")==_probe.hspeed
                && scrFRFieldGet(_probe,"vspeed_raw")==_probe.vspeed
                && scrFRFieldGet(_probe,"image_speed_raw")==_probe.image_speed,
                "Raw dynamic field queries did not resolve native fields");
            var _written=[];with(_probe) _written=fr_tests_frontier_gml_raw_motion_write(id);
            assert(_written[0]==9 && _written[1]==2.5 && _written[2]==10
                && _written[3]==-4 && _written[4]==2.5
                && _probe.hspeed==10 && _probe.vspeed==-4 && _probe.image_speed==2.5,
                "Raw assignments, member compound writes, increments or dynamic writes were scaled");
            with(_probe) _written=fr_tests_frontier_gml_source_motion_write(id);
            assert(_written[0]==16 && _written[1]==-14 && _written[2]==0.5
                && _written[3]==16*_scale && _written[4]==-14*_scale && _written[5]==0.5*_scale,
                "Raw aliases changed non-raw source motion writes");
        }
    } finally {
        global.time_scale=_saved_scale;
        if(instance_exists(_probe)) instance_destroy(_probe,false);
    }
    scrNTTESmokeLog("PASS FRONTIER raw/source motion aliases and dynamic fields at30/60 physical-frame scales");
}

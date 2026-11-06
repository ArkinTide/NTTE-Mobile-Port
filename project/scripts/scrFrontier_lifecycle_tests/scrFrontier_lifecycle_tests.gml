// Native pause and mutation selection regressions. This driver is woken only
// in the explicitly selected isolated Windows case, never in ordinary games.
function scrFRLifecycleTestsPauseKeepAlive() {
    if(variable_global_exists("fr_lifecycle_test_driver") && global.fr_lifecycle_test_driver!=noone)
        instance_activate_object(global.fr_lifecycle_test_driver);
}

function scrFRLifecycleTestsStart(_driver) {
    assert(os_type==os_windows && scrNTTEFullSmokeEnabled(),
        "Frontier lifecycle acceptance requires the isolated native runner");
    _driver.persistent=true;global.fr_lifecycle_test_driver=_driver;
    var _lib=scrFRLibGlobal();
    _driver.fr_lifecycle={phase:0,ticks:0,wait:0,round:0,owner:FRWorld.id,
        generation:global.fr_boot_generation,lib:_lib,runs:0,paused_runs:0,
        serial:0,hooks:array_length(_lib.activeHooks),library_locked:false,marker:noone,actor:noone};
    save_set_value("game","tutorial",false);
    UberCont.opt_autopause=false;UberCont.opt_bossintro=false;UberCont.opt_freeze=0;
    UberCont.want_quit_to_menu=false;UberCont.want_menu=false;UberCont.want_restart=false;
    scrNTTESmokeLog("NTUF LIFECYCLE real pause/selection acceptance started");
}

function scrFRLifecycleTestsOwner(_state) {
    assert(scrFREnabled() && instance_number(FRWorld)==1 && FRWorld.id==_state.owner
        && global.fr_boot_generation==_state.generation,
        "Native suspension bootstrapped or lost the initialized Frontier world");
    var _lib=scrFRLibGlobal();
    assert(instance_exists(_lib),"Native lifecycle lost persistent source library storage");
    if(_state.library_locked)
        assert(_lib==_state.lib && array_length(_lib.activeHooks)==_state.hooks,
            "Native suspension rebuilt library storage or changed source subscriptions "
            +json_stringify({phase:_state.phase,paused:UberCont.paused,frame:current_frame,
                expected:real(_state.lib),actual:real(_lib),old_exists:instance_exists(_state.lib),
                expected_hooks:_state.hooks,actual_hooks:array_length(_lib.activeHooks),
                heartbeat:_lib.lastUpdatedFrame}));
}

function scrFRLifecycleTestsPause(_driver) {
    var _state=_driver.fr_lifecycle;
    // Storage replacement between rooms and newly acquired skill hooks are
    // authored behavior. Lock identity at the actual pause boundary, then
    // require it to survive every paused frame and the resumed simulation.
    _state.lib=scrFRLibGlobal();_state.hooks=array_length(_state.lib.activeHooks);
    _state.library_locked=true;
    _state.wait=0;_state.phase=2;
    assert(scrGameCanPause(),"Native lifecycle fixture could not enter the real pause UI");
    scrGamePause();
}

function scrFRLifecycleTestsStep(_driver) {
    var _state=_driver.fr_lifecycle;
    _state.ticks++;
    assert(_state.ticks<4800,"Frontier native pause/selection lifecycle timed out phase="+string(_state.phase));
    with(Player) {hp=100000;max_hp=100000;nexthurt=current_frame+100000;can_walk=false;can_aim=false;speed=0;}
    GameCont.is_level_ended=true;
    if(_state.phase==0) {
        if(instance_exists(GenCont) || instance_exists(FloorMaker) || scrGameIsGenerationScreen()
            || !instance_exists(Player)) return false;
        // Both the 30 Hz and 60 Hz render policies must suspend the same
        // source simulation and preserve exactly one initialized runtime.
        var _rate=_state.round==0?30:60;
        save_set_value("options","framerate",_rate);
        save_set_value("options","autopause",false);
        save_set_value("visual","freezeframes",0);
        save_set_value("visual","bossintro",false);
        scrOptionsUpdate();
        assert(game_get_speed(gamespeed_fps)==_rate && UberCont.opt_framerate==_rate,
            "Lifecycle acceptance did not apply its real native frame policy");
        _state.wait=0;_state.phase=1;
        _state.actor=instance_create(14016,14016,FRCustomObject);
        _state.actor.fr_lifecycle_driver=_driver;
        _state.actor.on_step=function(){fr_lifecycle_driver.fr_lifecycle.runs++;};
        return false;
    }
    if(_state.phase==1) {
        if(++_state.wait<8) return false;
        assert(_state.runs>0,"Native lifecycle control actor never received its normal source step");
        scrFRLifecycleTestsPause(_driver);return false;
    }
    if(_state.phase==2) {
        if(!UberCont.paused || UberCont.want_pause) return false;
        scrFRLifecycleTestsOwner(_state);
        assert(!instance_exists(Player) && !instance_exists(_state.actor) && !scrFRReadyTick(),
            "Native pause resumed gameplay actors or exposed a simulation tick");
        assert(scrFRAreaActive(scrFRAreaResolve("cove")) && is_struct(scrFRAreaInfo(scrFRAreaResolve("cove"))),
            "Paused initialized Frontier metadata became unavailable to the native selection/generation path");
        _state.paused_runs=_state.runs;_state.serial=FRWorld.logic_serial;
        // A real inactive controller is deliberately restored through the
        // same boot consumer. No module tables or library hooks may reset.
        instance_deactivate_object(FRWorld);
        assert(!instance_exists(FRWorld),"Lifecycle inactive-owner control did not deactivate the controller");
        assert(scrFRWorldEnsure()==_state.owner,"Inactive-owner bootstrap created another runtime");
        scrFRLifecycleTestsOwner(_state);
        _state.wait=0;_state.phase=3;return false;
    }
    if(_state.phase==3) {
        scrFRLifecycleTestsOwner(_state);
        assert(UberCont.paused && !scrFRReadyTick() && FRWorld.logic_serial==_state.serial
            && _state.runs==_state.paused_runs,
            "Frontier simulation progressed while native gameplay was deactivated");
        if(++_state.wait<36) return false;
        var _continue=noone;
        with(PauseButton) if(image_index==3) {_continue=id;break;}
        assert(instance_exists(_continue),"Native pause did not create its Continue consumer");
        with(_continue) event_user(0);
        assert(!UberCont.paused && instance_exists(_state.actor) && instance_exists(Player),
            "Native Continue event failed to reactivate ordinary gameplay");
        _state.wait=0;_state.phase=4;return false;
    }
    if(_state.phase==4) {
        if(++_state.wait<8) return false;
        scrFRLifecycleTestsOwner(_state);
        assert(_state.runs>_state.paused_runs,"Source simulation did not resume after the real Continue event");
        _state.library_locked=false;
        instance_destroy(_state.actor,false);
        // Dispose the old room first. The isolated smoke boot suppresses
        // Vlambeer menu input, so construct its real LevCont consumer only
        // after room_restart has removed the previous terrain and actors.
        GameCont.area=scrFRAreaResolve(_state.round==0?"cove":"robocenter");
        GameCont.subarea=1;GameCont.loops=1;
        GameCont.maxsubarea=scrAreaGetMaxSubarea(GameCont.area);GameCont.finalsubarea=false;
        GameCont.can_advance_stage=false;GameCont.skillpoints=1;
        GameCont.crownpoints=0;GameCont.ultrapoints=0;GameCont.patiencepick=false;
        GameCont.ntte_full_pending_destination=undefined;
        global.fr_continue_events={game:GameCont.id,events:[]};
        global.ntte_full_sync_generation=false;
        _state.marker=instance_create(0,0,FRMarker);_state.phase=5;
        room_restart();return false;
    }
    if(_state.phase==5) {
        assert(!instance_exists(_state.marker) && !instance_exists(TopCont) && instance_number(Floor)==0,
            "Selection acceptance retained old native terrain across room disposal");
        if(!instance_exists(BackCont)) instance_create(0,0,BackCont);
        if(!instance_exists(MusCont)) instance_create(0,0,MusCont);
        instance_create(view_width/2,view_height/2,LevCont);
        assert(instance_exists(LevCont) && instance_number(SkillIcon)>0 && !instance_exists(GenCont),
            "Native LevCont failed to offer an ordinary mutation choice before generation");
        _state.wait=0;_state.phase=6;return false;
    }
    if(_state.phase==6) {
        if(++_state.wait<4) return false;
        var _icon=instance_find(SkillIcon,0),_skill=_icon.skill,_before=scr_skill_get(_skill);
        _icon.selected=true;
        // Run the genuine mouse event, which calls Select, destroys LevCont,
        // creates GenCont and writes the native checkpoint synchronously.
        with(_icon) event_perform(ev_mouse,ev_left_press);
        assert(GameCont.skillpoints==0 && scr_skill_get(_skill)==_before+1
            && !instance_exists(LevCont),"Native SkillIcon mouse selection did not submit its real mutation");
        if(instance_exists(GenCont)) assert(GenCont.fr_generation_metadata_ready && GenCont.fr_event_setup_complete,
            "Native mutation submission skipped Frontier generation metadata or source event setup");
        scrFRLifecycleTestsOwner(_state);
        _state.wait=0;_state.phase=7;return false;
    }
    if(_state.phase==7) {
        if(instance_exists(GenCont) || instance_exists(FloorMaker) || scrGameIsGenerationScreen()
            || !instance_exists(Player)) return false;
        if(++_state.wait<24) return false;
        scrFRLifecycleTestsOwner(_state);
        assert(instance_number(Floor)>20 && instance_number(Wall)>0 && instance_exists(TopCont),
            "Native mutation selection failed to finish actual Frontier terrain and player placement");
        scrNTTESmokeLog("NTUF LIFECYCLE native pause/Continue/SkillIcon.Mouse4/GenCont PASS "
            +json_stringify({round:_state.round,area:GameCont.area,scale:timescale,
                boot_generation:global.fr_boot_generation,world:real(FRWorld.id),
                floors:instance_number(Floor),walls:instance_number(Wall)}));
        if(++_state.round<2) {_state.phase=0;return false;}
        global.fr_lifecycle_test_driver=noone;_state.phase=8;return true;
    }
    return _state.phase==8;
}

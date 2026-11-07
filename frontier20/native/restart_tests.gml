// Real whole-session restarts. The observer lives on the surviving UberCont;
// the test driver is deliberately destroyed by the same sweep as gameplay.
function scrFRRestartTestsColdRequested() {
    // UberCont.Create precedes the internal harness's counter initialization.
    // This pre-bootstrap selector must not invoke its stateful case consumer.
    if(os_type!=os_windows || !scrNTTEFullSmokeEnabled()) return false;
    for(var _i=1;_i<=parameter_count();++_i)
        if(parameter_string(_i)=="--ntte-full-case=FrontierRestartTests") return true;
    return false;
}
function scrFRRestartTestsColdSelectProbe() {
    assert(!scrFREnabled() && !instance_exists(FRWorld),
        "Cold CharSelect consumer was accidentally tested against an initialized runtime");
    var _authored=asset_get_index("sprFR_sprBubblesSelect_9a983e1c7c7a");
    assert(sprite_exists(_authored),"Bubbles Select art was absent from the cold native package");
    var _surface=surface_create(384,224),_icon=instance_create(80,80,CharSelect),_target_set=false;
    assert(surface_exists(_surface),"Cold CharSelect acceptance could not allocate its native GPU target");
    try {
        surface_set_target(_surface);_target_set=true;draw_clear_alpha(c_black,0);
        var _identities=[19,"bubbles","race:bubbles"];
        for(var _i=0;_i<array_length(_identities);++_i) {
            _icon.race=_identities[_i];
            assert(scrNTTEFullRaceSelectSprite(_icon.race,false,-1)==_authored,
                "Pre-bootstrap Bubbles Select query lost its packaged native art");
            with(_icon) event_perform(ev_draw,0);
        }
    } finally {
        if(_target_set) surface_reset_target();
        if(instance_exists(_icon)) instance_destroy(_icon,false);
        if(surface_exists(_surface)) surface_free(_surface);
    }
    global.fr_restart_cold_select_passed=true;
    scrNTTESmokeLog("NTUF RESTART cold pre-bootstrap real CharSelect.Draw numeric/string Bubbles PASS");
}

function scrFRRestartTestsStart(_driver) {
    assert(os_type==os_windows && scrNTTEFullSmokeEnabled() && global.ntte_smoke_active,
        "Frontier restart acceptance requires the isolated desktop harness");
    assert(variable_global_exists("fr_restart_cold_select_passed") && global.fr_restart_cold_select_passed,
        "Restart acceptance skipped its actual cold pre-bootstrap CharSelect.Draw consumer");
    var _state={phase:0,round:0,ticks:0,wait:0,driver:_driver,old_driver:noone,
        owner:FRWorld.id,generation:global.fr_boot_generation,lib:scrFRLibGlobal(),hooks:0,
        old_game:noone,actor:noone,binding:noone,marker:noone,icon:noone,
        actor_steps:0,binding_steps:0,frozen_actor_steps:0,frozen_binding_steps:0,
        stale_task_steps:0,cleanup_saw_game:false,cleanup_count:0,game:noone,player:noone};
    global.fr_restart_test_state=_state;_driver.fr_restart=_state;
    save_set_value("game","tutorial",false);
    save_set_value("options","autopause",false);
    save_set_value("visual","freezeframes",0);
    save_set_value("visual","bossintro",false);
    UberCont.opt_autopause=false;UberCont.opt_freeze=0;UberCont.paused=false;
    UberCont.want_quit_to_menu=false;UberCont.want_menu=false;UberCont.want_restart=false;
    global.index=0;global.is_server=true;
    scrFRRaceUnlockSet(true);scrFRRaceUnlockSet(true,1);
    scrNTTESmokeLog("NTUF RESTART genuine scrGameRestart(false/true) acceptance started");
}

function scrFRRestartTestsObserve() {
    if(os_type!=os_windows || !scrNTTEFullSmokeEnabled()
        || !variable_global_exists("fr_restart_test_state")) return;
    var _state=global.fr_restart_test_state;
    if(!is_struct(_state) || _state.phase==99) return;
    // Pause makes an existing driver inactive. Reactivate that exact observer
    // instead of confusing inactivity with destruction and making a duplicate.
    instance_activate_object(_state.driver);
    if(instance_exists(_state.driver)) return;
    var _driver=instance_create(0,0,FRIntegrationTest);
    _driver.fr_test_case="restart";_driver.fr_restart=_state;_state.driver=_driver;
}

function scrFRRestartTestsOwner(_state) {
    assert(scrFREnabled() && instance_number(FRWorld)==1 && FRWorld.id==_state.owner
        && global.fr_boot_generation==_state.generation,
        "Whole-session restart lost or reinitialized the Frontier owner");
    var _lib=scrFRLibGlobal();
    assert(instance_exists(_lib) && _lib==_state.lib
        && array_length(scrFRLibStorageInstances())==1,
        "Whole-session restart lost, duplicated or rebuilt the live source registry store");
}

function scrFRRestartTestsStaleTask(_task) {
    if(_task.pc==0) {_task.wait_ticks=200;_task.pc=1;return;}
    global.fr_restart_test_state.stale_task_steps+=1;
    _task.done=true;
}

function scrFRRestartTestsFixture(_driver) {
    var _state=_driver.fr_restart;
    _state.actor=instance_create(14016,14016,FRCustomObject);
    _state.actor.persistent=true;
    _state.actor.on_step=function(){global.fr_restart_test_state.actor_steps+=1;};
    _state.actor.on_cleanup=function(){
        var _state=global.fr_restart_test_state;
        _state.cleanup_count+=1;
        _state.cleanup_saw_game=instance_exists(GameCont) && GameCont.id==_state.old_game;
        _state.frozen_actor_steps=_state.actor_steps;
        _state.frozen_binding_steps=_state.binding_steps;
    };
    _state.binding=instance_create(14016,14016,FRBinding);
    _state.binding.persistent=true;
    _state.binding.fr_binding_kind="step";
    _state.binding.fr_binding_code=function(){global.fr_restart_test_state.binding_steps+=1;};
    _state.marker=instance_create(0,0,FRMarker);_state.marker.persistent=true;
    _state.wait=0;
}

function scrFRRestartTestsRequest(_driver,_quit) {
    var _state=_driver.fr_restart;
    _state.old_game=GameCont.id;_state.old_driver=_driver;
    _state.lib=scrFRLibGlobal();_state.hooks=array_length(_state.lib.activeHooks);
    _state.cleanup_saw_game=false;
    scrFRTaskStart(scrFRRestartTestsStaleTask,FRWorld.id,noone,[],0);
    global.fr_tasks[array_length(global.fr_tasks)-1].fr_retired_restart_probe=true;
    scrFRTaskStart(scrFRRestartTestsStaleTask,_state.actor,noone,[],0);
    global.fr_tasks[array_length(global.fr_tasks)-1].fr_retired_restart_probe=true;
    _state.phase=_quit?5:2;_state.wait=0;
    // No test helper exempts FRWorld or this driver. These are the production
    // entry points, including unpause + call_after when invoked while paused.
    scrGameRestart(_quit);
}

function scrFRRestartTestsRetired(_state) {
    if(instance_exists(_state.old_game) || instance_exists(_state.old_driver)) return false;
    scrFRRestartTestsOwner(_state);
    assert(!instance_exists(_state.actor) && !instance_exists(_state.binding)
        && !instance_exists(_state.marker) && _state.cleanup_saw_game,
        "Whole-session restart retained an old persistent actor or cleaned it after its GameCont");
    assert(_state.actor_steps==_state.frozen_actor_steps
        && _state.binding_steps==_state.frozen_binding_steps && _state.stale_task_steps==0,
        "A retired gameplay actor, binding or coroutine advanced in the new session");
    for(var _i=0;_i<array_length(global.fr_tasks);++_i)
        assert(!(global.fr_tasks[_i][$ "fr_retired_restart_probe"]??false),
            "A world-scoped or old-actor coroutine survived whole-session retirement");
    assert(array_length(_state.lib.activeHooks)==_state.hooks,
        "Whole-session restart discarded or duplicated initialized source subscriptions");
    return true;
}

function scrFRRestartTestsGenerate(_state) {
    assert(instance_number(GameCont)==1 && instance_number(Player)==1,
        "Genuine native restart/new-run did not create one game and one player");
    _state.game=GameCont.id;_state.player=instance_find(Player,0);
    assert(_state.player.race==19 && _state.player.bskin==_state.round
        && _state.player.spr_idle==scrFRRaceVar("sprIdle",_state.round),
        "Restarted Bubbles lost its numeric identity, A/B skin or authored body art");
    if(!instance_exists(BackCont)) instance_create(0,0,BackCont);
    if(!instance_exists(MusCont)) instance_create(0,0,MusCont);
    if(_state.phase==8) {
        // Select a real source weather event on the newly confirmed run.
        // This override changes selection only: original libEvents setup,
        // create, queue, native steps/draws and cleanup own all behavior.
        global.fr_continue_events={game:GameCont.id,events:[["mod","Frontier_Events","MeteorShower"]]};
        var _driver=_state.driver;
        _driver.fr_event_record={};
        _state.weather_pending=true;
    }
    // The explicit smoke bootstrap suppresses Vlambeer. Use its ordinary
    // async GenCont consumer only after the real room_restart disposal.
    _state.generation_spiral=instance_create(0,0,SpiralCont);
    var _gen=instance_create(0,0,GenCont);
    assert(!_gen.ntte_full_sync_generation,"Restart acceptance bypassed native asynchronous generation");
    _state.wait=0;
}

function scrFRRestartTestsStep(_driver) {
    var _state=_driver.fr_restart;
    assert(++_state.ticks<6000,"Frontier genuine restart acceptance timed out phase="+string(_state.phase));
    scrFRRestartTestsOwner(_state);
    with(Player) {hp=100000;max_hp=100000;nexthurt=current_frame+100000;can_walk=false;can_aim=false;speed=0;}
    if(instance_exists(GameCont)) GameCont.is_level_ended=true;
    if(_state.phase==0) {
        if(instance_exists(GenCont) || instance_exists(FloorMaker) || !instance_exists(Player)) return false;
        var _rate=_state.round==0?30:60;
        save_set_value("options","framerate",_rate);scrOptionsUpdate();
        scr_loadout_race_set_skin(19,_state.round);
        my_player.race=19;my_player.skin=_state.round;
        my_player.cwep=_state.round==0?FR_BUBBLES_CUTLASS:FR_BUBBLES_SHOVEL;
        scrFRRestartTestsFixture(_driver);
        _state.phase=1;return false;
    }
    if(_state.phase==1) {
        if(++_state.wait<8) return false;
        assert(_state.actor_steps>0 && _state.binding_steps>0,
            "Restart actor/binding positive controls did not receive genuine source steps");
        if(_state.round==1) {scrGamePause();_state.phase=11;return false;}
        scrFRRestartTestsRequest(_driver,false);return false;
    }
    if(_state.phase==11) {
        if(!UberCont.paused || UberCont.want_pause>0) return false;
        scrFRRestartTestsRequest(_driver,false);return false;
    }
    if(_state.phase==2) {
        if(!scrFRRestartTestsRetired(_state)) return false;
        assert(!instance_exists(Menu) && !instance_exists(GenCont) && instance_number(Floor)==0,
            "Genuine Restart(false) retained old room/menu terrain");
        scrFRRestartTestsGenerate(_state);_state.phase=3;return false;
    }
    if(_state.phase==3) {
        if(instance_exists(GenCont) || instance_exists(FloorMaker) || !instance_exists(TopCont)) return false;
        assert(instance_number(Floor)>20 && instance_number(Wall)>0,
            "Genuine Restart(false) failed to finish a populated native room");
        scrFRRestartTestsRetired(_state);
        scrFRRestartTestsFixture(_driver);_state.phase=4;return false;
    }
    if(_state.phase==4) {
        if(++_state.wait<24) return false;
        if(_state.round==1) {scrGamePause();_state.phase=12;return false;}
        scrFRRestartTestsRequest(_driver,true);return false;
    }
    if(_state.phase==12) {
        if(!UberCont.paused || UberCont.want_pause>0) return false;
        scrFRRestartTestsRequest(_driver,true);return false;
    }
    if(_state.phase==5) {
        if(!scrFRRestartTestsRetired(_state)) return false;
        assert(!instance_exists(GameCont) && !instance_exists(Player) && instance_number(Floor)==0,
            "Genuine Restart(true) retained a native run or its terrain");
        UberCont.want_quit_to_menu=false;UberCont.want_menu=false;UberCont.want_restart=false;
        if(!instance_exists(MusCont)) instance_create(0,0,MusCont);
        // The actual Play consumer initializes its menu GameCont before
        // MenuGen creates Floor. Floor's material reads GameCont.area even
        // while rendering campfire terrain, so constructing MenuGen alone
        // bypasses a required native menu boundary.
        var _play=instance_create(0,0,PlayButton);_play.num=0;
        with(_play) event_perform(ev_other,10);
        assert(!instance_exists(_play) && instance_number(GameCont)==1
            && instance_number(MenuGen)==1 && instance_number(Menu)==1
            && instance_number(Floor)>0,
            "Real post-Restart PlayButton failed its GameCont/MenuGen/menu terrain sequence");
        // Start the actual two-click Select fixture on a known other icon,
        // after PlayButton has performed its own player-instance reset.
        my_player.race=Race.Fish;
        _state.icon=noone;with(CharSelect) if(race==19) {_state.icon=id;break;}
        assert(instance_exists(_state.icon),"Genuine post-Restart menu omitted the Bubbles icon");
        _state.wait=0;_state.phase=6;return false;
    }
    if(_state.phase==6) {
        if(++_state.wait<8) return false;
        scrFRRestartTestsRetired(_state);
        assert(_state.icon.can,"Real CharSelect.Draw did not unlock Bubbles after whole-session restart");
        with(CharSelect) assert(sprite_exists(scrNTTEFullRaceSelectSprite(race,can,
            can?sprite_index:sprCharSelectLocked)),"A post-Restart native CharSelect still resolves invalid art");
        var _authored=scrFRRaceVar("sprSelect"),_enabled=global.fr_enabled;
        try {
            global.fr_enabled=false;
            assert(scrNTTEFullRaceSelectSprite(19,true,sprCharSelect)==_authored
                && scrNTTEFullRaceSelectSprite("bubbles",false,-1)==_authored
                && scrNTTEFullRaceSelectSprite("race:bubbles",true,-1)==_authored,
                "Missing-owner Select query lost Bubbles' own packaged unlocked/locked art");
        } finally {global.fr_enabled=_enabled;}
        with(_state.icon) event_perform(ev_mouse,ev_left_press);
        assert(my_player.race==19,"Genuine post-Restart Bubbles CharSelect.Mouse4 failed");
        _state.wait=0;_state.phase=7;return false;
    }
    if(_state.phase==7) {
        if(++_state.wait<4) return false;
        _state.marker=instance_create(0,0,FRMarker);
        _state.phase=8;
        with(_state.icon) event_perform(ev_mouse,ev_left_press);
        return false;
    }
    if(_state.phase==8) {
        assert(!instance_exists(Menu) && !instance_exists(_state.marker)
            && !instance_exists(GenCont) && instance_number(Floor)==0,
            "Post-Restart real CharSelect confirmation did not dispose the menu room");
        scrFRRestartTestsGenerate(_state);_state.phase=9;return false;
    }
    if(_state.phase==9) {
        if(instance_exists(GenCont) || instance_exists(FloorMaker) || !instance_exists(TopCont)) return false;
        assert(!instance_exists(_state.generation_spiral) && !UberCont.letterbox,
            "Post-Restart generation did not retire its ordinary loading spiral/letterbox");
        if(_state.weather_pending) {
            scrFREventTestsDropdownObserve(_driver);
            var _weather=_driver.fr_event_record,
                _controllers=scrFRMatching(FRCustomObject,"name","fr_EventDropdownController");
            ++_state.wait;
            if(_state.wait<ceil(150/timescale)) return false;
            assert(array_length(_controllers)==1 && _controllers[0].dropdownAllowed
                && _controllers[0].arrayIndex==array_length(_controllers[0].dropdownsQueue)
                && (_weather[$ "dropdown_full_visible_ticks"]??0)>=10
                && (_weather[$ "dropdown_screen_proof"]??false),
                "Post-Restart/menu natural MeteorShower card did not visibly descend, dwell and retire");
            scrNTTESmokeLog("NTUF RESTART natural weather final-screen lifecycle PASS "+json_stringify({
                round:_state.round,rate:game_get_speed(gamespeed_fps),
                fully_visible_frames:_weather.dropdown_full_visible_ticks,
                maximum_height:_weather.dropdown_max_height,
                completed_queue:_controllers[0].arrayIndex}));
            _state.weather_pending=false;
        } else if(++_state.wait<24) return false;
        assert(instance_exists(_state.game) && instance_exists(_state.player)
            && instance_number(Floor)>20 && instance_number(Wall)>0 && _state.stale_task_steps==0,
            "Post-Restart real Bubbles menu/new-run did not finish live gameplay");
        scrFRRestartTestsOwner(_state);
        scrNTTESmokeLog("NTUF RESTART genuine false/true + CharSelect.Draw/Mouse4 + GenCont PASS "
            +json_stringify({round:_state.round,rate:game_get_speed(gamespeed_fps),
                paused_restart:_state.round==1,boot_generation:global.fr_boot_generation,
                world:real(FRWorld.id),lib:real(scrFRLibGlobal()),cleanup_count:_state.cleanup_count}));
        if(++_state.round<2) {_state.phase=0;return false;}
        _state.phase=99;return true;
    }
    return false;
}

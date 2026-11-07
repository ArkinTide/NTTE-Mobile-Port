// Explicitly selected private native acceptance. Every HQ augment is acquired
// by the authored station coroutine before the real chair/save/credits path.
function scrFRCaptainChairTestsStart(_driver) {
    assert(os_type==os_windows && scrNTTEFullSmokeEnabled() && scrFREnabled(),
        "Captain chair acceptance requires the isolated native harness");
    var _original=UberCont.saveData,_copy=ds_map_create();
    ds_map_copy(_copy,_original);UberCont.saveData=_copy;
    var _state={phase:0,round:0,index:0,ticks:0,wait:0,driver:_driver,old_driver:noone,
        owner:FRWorld.id,generation:global.fr_boot_generation,lib:scrFRLibGlobal(),hooks:0,
        keys:[],oldskill:undefined,skill:undefined,station:noone,chair:noone,seat:noone,
        actor:noone,cleanup_saw_game:false,cleanup_count:0,stale_runs:0,
        game:noone,player:noone,original_map:_original,fixture_map:_copy,rows:[]};
    global.fr_captain_chair_test_state=_state;_driver.fr_captain_chair=_state;
    save_set_value("game","tutorial",false);save_set_value("options","autopause",false);
    save_set_value("visual","bossintro",false);save_set_value("visual","freezeframes",0);
    UberCont.custom=false;UberCont.daily_run=false;UberCont.weekly_run=false;
    UberCont.opt_autopause=false;UberCont.opt_freeze=0;UberCont.paused=false;
    UberCont.want_quit_to_menu=false;UberCont.want_menu=false;UberCont.want_restart=false;
    scrNTTESmokeLog("NTUF CAPTAIN CHAIR every HQ augment/source station/native chair/save/credits started");
}

function scrFRCaptainChairTestsObserve() {
    if(os_type!=os_windows || !scrNTTEFullSmokeEnabled()
        || !variable_global_exists("fr_captain_chair_test_state")) return;
    var _state=global.fr_captain_chair_test_state;
    if(!is_struct(_state) || _state.phase==99) return;
    instance_activate_object(_state.driver);
    if(instance_exists(_state.driver)) return;
    var _driver=instance_create(0,0,FRIntegrationTest);
    _driver.fr_test_case="captain_chair";_driver.fr_captain_chair=_state;_state.driver=_driver;
}

function scrFRCaptainChairTestsOwner(_state) {
    assert(scrFREnabled() && instance_number(FRWorld)==1 && FRWorld.id==_state.owner
        && global.fr_boot_generation==_state.generation && scrFRLibGlobal()==_state.lib
        && array_length(scrFRLibStorageInstances())==1,
        "Captain chair victory lost/rebuilt its initialized Frontier owner or registry");
}

function scrFRCaptainChairTestsStale(_task) {
    if(_task.pc==0) {_task.wait_ticks=1000;_task.pc=1;return;}
    global.fr_captain_chair_test_state.stale_runs+=1;_task.done=true;
}

function scrFRCaptainChairTestsDraw(_seat) {
    var _surface=surface_create(384,224),_set=false;
    assert(surface_exists(_surface),"Captain chair Draw acceptance could not allocate its GPU target");
    try {
        surface_set_target(_surface);_set=true;draw_clear_alpha(c_black,0);
        with(_seat) event_perform(ev_draw,0);
    } finally {if(_set) surface_reset_target();if(surface_exists(_surface)) surface_free(_surface);}
}

function scrFRCaptainChairTestsStation(_state) {
    _state.skill=_state.keys[_state.index];
    _state.oldskill=scrFRModCall("skill",_state.skill,"skill_augment");
    scrFRSkillSetActive(_state.oldskill,true);scrFRSetSkill(_state.oldskill,1);
    assert(scrFRGetSkill(_state.oldskill)==1 && scrFRGetSkill(_state.skill)==0,
        "HQ chair augment fixture did not begin with exactly its source base mutation");
    // This is the source station constructor used by AugmentStation_spawn.
    // Only its randomized reward choice is fixed; the authored on_step
    // coroutine still performs every grant, pool change, save and effect.
    _state.station=scrFRInvoke(_state.game,
        fr_Objects_Frontier_IDPD_mod_gml_AugmentStation_create,[14016,14016]);
    assert(instance_exists(_state.station),"Real HQ augment station constructor returned no actor");
    with(_state.station) {
        augment=_state.skill;newskill=augment;oldskill=_state.oldskill;
        augmentname=scrFRModCall("skill",augment,"skill_name");
        description=scrFRModCall("skill",augment,"skill_text");pick=1;
    }
    _state.wait=0;
}

function scrFRCaptainChairTestsStep(_driver) {
    var _state=_driver.fr_captain_chair;
    assert(++_state.ticks<18000,"HQ augment/chair acceptance timed out phase="+string(_state.phase));
    scrFRCaptainChairTestsOwner(_state);
    if(instance_exists(GameCont)) GameCont.is_level_ended=true;
    with(Player) {hp=100000;max_hp=100000;nexthurt=current_frame+100000;
        can_walk=false;can_aim=false;hspeed=0;vspeed=0;}
    if(_state.phase==0) {
        if(instance_exists(GenCont) || instance_exists(FloorMaker) || !instance_exists(Player)) return false;
        _state.game=GameCont.id;_state.player=instance_find(Player,0);
        _state.keys=scrFRModGet("mod","Frontier_IDPD","fr_augments_array");
        assert(array_length(_state.keys)>10,"HQ chair acceptance did not load the full authored augment roster");
        _state.phase=1;return false;
    }
    if(_state.phase==1) {
        save_set_value("options","framerate",_state.round==0?30:60);scrOptionsUpdate();
        GameCont.area=area_hq;GameCont.subarea=3;GameCont.win=false;
        with(Credits) instance_destroy(id,false);
        with(SpiralCont) instance_destroy(id,false);
        with(SitDown) instance_destroy(id,false);
        with(_state.player) {
            visible=true;race=19;bskin=_state.round;can_die=true;
            x=800000;y=800000;xprevious=x;yprevious=y;
            scrFRRacePlayerChange();scrFRRaceRefreshSprites();
            var _model=scrNTTEFullWeaponMerge({wep:wep_revolver},{wep:wep_shotgun});
            wep=scrNTTEFullWeaponNative(_model);bwep=FR_BUBBLES_CUTLASS;
        }
        if(!instance_exists(BackCont)) instance_create(0,0,BackCont);
        if(!instance_exists(TopCont)) instance_create(0,0,TopCont);
        if(!instance_exists(MusCont)) instance_create(0,0,MusCont);
        scrFRCaptainChairTestsStation(_state);_state.phase=2;return false;
    }
    if(_state.phase==2) {
        assert(++_state.wait<120,"HQ source station failed to apply augment "+string(_state.skill));
        if(!_state.station.opened) return false;
        assert(scrFRGetSkill(_state.oldskill)==0 && scrFRGetSkill(_state.skill)==1
            && !scrFRSkillActive(_state.oldskill),
            "Authored HQ station coroutine did not perform its base-to-augment substitution");
        // Let actual source skill step/late/end hooks observe the acquired
        // augment before seating. LastChair's own Alarm0 creates SitDown.
        if(_state.wait<20) return false;
        _state.chair=instance_create(800000,800000,LastChair);
        with(_state.chair) event_perform(ev_alarm,0);
        _state.seat=instance_find(SitDown,0);
        assert(instance_exists(_state.seat),"Native LastChair alarm did not create SitDown");
        with(_state.player) with(_state.seat) event_perform(ev_collision,Player);
        assert(_state.seat.sit && GameCont.win && !_state.player.visible
            && _state.seat.player==_state.player,
            "Real SitDown Player collision did not enter the native victory state");
        scrFRCaptainChairTestsDraw(_state.seat);
        _state.phase=3;_state.wait=0;return false;
    }
    if(_state.phase==3) {
        if(++_state.wait<4) return false;
        // Native Alarm2 invokes the real animation-end event. It updates
        // best stats, unlocks the win/crown and commits scrSave synchronously.
        with(_state.seat) event_perform(ev_alarm,2);
        assert(_state.seat.sprite_index==_state.seat.spr_sit && _state.seat.alarm[2]==-1,
            "Real chair animation/unlock/save consumer did not finish");
        var _json=scrPersistentJsonLoad(game_directory+"NuclearThrone.sav");
        assert(is_string(_json),"Chair win did not commit a valid permanent native save");
        scrFRCaptainChairTestsDraw(_state.seat);
        _state.actor=instance_create(14016,14016,FRCustomObject);_state.actor.persistent=true;
        _state.actor.on_cleanup=function(){
            var _state=global.fr_captain_chair_test_state;
            _state.cleanup_count+=1;_state.cleanup_saw_game=instance_exists(_state.game);
        };
        scrFRTaskStart(scrFRCaptainChairTestsStale,FRWorld.id,noone,[],0);
        global.fr_tasks[array_length(global.fr_tasks)-1].fr_retired_chair_probe=true;
        _state.hooks=array_length(_state.lib.activeHooks);_state.old_driver=_driver;
        _state.phase=4;_state.wait=0;
        // This native credits sweep destroys this driver too. UberCont's
        // observer resumes the fixture without exempting it from production.
        with(_state.seat) event_perform(ev_alarm,0);
        return false;
    }
    if(_state.phase==4) {
        assert(!instance_exists(_state.old_driver) && !instance_exists(_state.actor)
            && !instance_exists(_state.seat) && !instance_exists(_state.station)
            && instance_exists(Credits) && instance_exists(_state.game)
            && _state.cleanup_saw_game && _state.stale_runs==0,
            "Native victory sweep retained retired actors/tasks or lost its retained GameCont");
        assert(FRWorld.fr_previous_game==_state.game && array_length(_state.lib.activeHooks)==_state.hooks,
            "Credits reset the completed game identity or source hook registry");
        for(var _i=0;_i<array_length(global.fr_tasks);++_i)
            assert(!(global.fr_tasks[_i][$ "fr_retired_chair_probe"]??false),
                "World-scoped pre-victory coroutine survived credits retirement");
        if(++_state.wait<20) return false;
        array_push(_state.rows,{skill:_state.skill,rate:game_get_speed(gamespeed_fps),
            race:_state.player.race,skin:_state.player.bskin});
        scrNTTESmokeLog("NTUF CAPTAIN CHAIR source station + actual seat/animation/save/credits PASS "
            +json_stringify(_state.rows[array_length(_state.rows)-1]));
        scrFRSetSkill(_state.skill,0);scrFRSkillSetActive(_state.oldskill,true);
        if(++_state.index<array_length(_state.keys)) {_state.phase=1;return false;}
        if(++_state.round<2) {_state.index=0;_state.phase=1;return false;}
        UberCont.saveData=_state.original_map;ds_map_destroy(_state.fixture_map);
        _state.phase=99;return true;
    }
    return false;
}

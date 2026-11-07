// Explicit desktop development cases. Rebuild a genuine menu/new run instead
// of attaching a hidden Bubbles body to the smoke boot's existing Fish game.
function scrFRBubblesStartupTestsStart(_driver,_skin,_random=false) {
    assert(os_type==os_windows && scrNTTEFullSmokeEnabled() && global.ntte_smoke_active,
        "Bubbles new-run acceptance requires the isolated desktop harness");
    assert(_skin==0 || _skin==1,"Unknown Bubbles startup skin");
    _driver.persistent=true;
    _driver.fr_bubbles_startup={skin:_skin,random:_random,phase:0,round:0,trial:0,ticks:0,wait:0,
        driver:_driver,test_case:_driver.fr_test_case,keys:global.fr_weapon_keys,
        scripts:global.fr_module_scripts,
        marker:noone,player:noone,icon:noone,game:noone,steps:0,ends:0,draws:0,huds:0,
        play_steps:0,play_ticks:0,weapon_swing:false,attack_hits:[],attack_target:noone,
        touch_sampling:false,touch:{held:false,pressed:false,released:false},owner:FRWorld.id,
        boot_generation:global.fr_boot_generation};
    global.fr_bubbles_startup_state=_driver.fr_bubbles_startup;
    save_set_value("game","tutorial",false);
    save_set_value("options","autopause",false);
    save_set_value("visual","freezeframes",0);
    save_set_value("visual","bossintro",false);
    UberCont.opt_autopause=false;UberCont.opt_freeze=0;UberCont.paused=false;
    UberCont.want_quit_to_menu=false;UberCont.want_menu=false;UberCont.want_restart=false;
    global.index=0;global.is_server=true;
    // Exercise the actual local file boundary, preserving every other saved
    // Frontier default. This harness owns a separate smoke save directory.
    scrFRRaceUnlockSet(true);scrFRRaceUnlockSet(true,1);
    var _namespace=global.fr_module_vars[$ "mod:libSaves"].saves;
    assert(scrFRFileExists("FrontierSave.json"),"Bubbles unlock did not reach its private configuration file");
    variable_struct_remove(_namespace,"Frontier");
    scrFRModCallArray("mod","libSaves","save_load",["Frontier",{}]);
    assert(scrFRRaceAvailable() && scrFRRaceSkinAvailable(1),
        "Bubbles stored unlock failed to load before native character selection");
    scrNTTESmokeLog("NTUF BUBBLES STARTUP saved unlock reloaded; skin="+string(_skin));
}

function scrFRBubblesStartupTestsObserve(_kind,_player) {
    if(os_type!=os_windows || !scrNTTEFullSmokeEnabled() || !instance_exists(_player)
        || _player.race!=19) return;
    var _driver=noone;
    with(FRIntegrationTest) if(variable_instance_exists(id,"fr_bubbles_startup")) {_driver=id;break;}
    if(!instance_exists(_driver)) return;
    var _state=_driver.fr_bubbles_startup;
    if(_state.phase<2 || _state.phase>5) return;
    if(_kind=="step") {
        _state.steps+=1;
        if(_state.phase==5) _state.play_steps+=1;
    } else if(_kind=="end") {
        _state.ends+=1;
        var _found=false;
        with(Slash) if((self[$ "creator"]??noone)==_player && team==_player.team) {_found=true;break;}
        if(_found) _state.weapon_swing=true;
        if(_state.phase==5 && (_state.play_steps==15 || _state.play_steps==18
            || _state.play_steps==40 || _state.play_steps==44 || _state.play_steps==61
            || _state.play_steps==90 || _state.play_steps==145 || _state.play_steps==150))
            scrFRBubblesStartupTestsDiagnostic(_state,"end-input");
    } else if(_kind=="draw") {_state.draws+=1;}
    else if(_kind=="hud" && _state.phase==5 && _state.player==_player) {_state.huds+=1;}
}

function scrFRBubblesStartupTestsBeforeInputSample() {
    if(os_type!=os_windows || !scrNTTEFullSmokeEnabled()) return;
    var _driver=noone;
    with(FRIntegrationTest) if(variable_instance_exists(id,"fr_bubbles_startup")) {_driver=id;break;}
    if(!instance_exists(_driver)) return;
    var _state=_driver.fr_bubbles_startup;
    if(_state.phase!=5 || !instance_exists(_state.player)) return;
    var _step=_state.play_steps;
    _state.attack_mode=_step<55?"desktop-hold":(_step<85?"mobile-tap":"mobile-hold");
    if(instance_exists(_state.attack_target)) with(_state.attack_target) {
        x=_state.player.x+18;y=_state.player.y;speed=0;
    }
    _state.touch_sampling=false;
    if(_step>=55) {
        // Cover the one genuine scrHandleInputsGeneral -> MobileUI.User0
        // producer for the entire sampled gesture. Running a second event
        // after neutral hardware would clear the previous pointer capture
        // before its release edge and create a false mobile failure.
        _state.touch={held:_step==60 || (_step>=90 && _step<150),
            pressed:_step==60 || _step==90,released:_step==61 || _step==150};
        _state.touch_sampling=true;
    }
}

function scrFRBubblesStartupTestsAfterInputSample() {
    if(os_type!=os_windows || !scrNTTEFullSmokeEnabled()) return;
    var _driver=noone;
    with(FRIntegrationTest) if(variable_instance_exists(id,"fr_bubbles_startup")) {_driver=id;break;}
    if(!instance_exists(_driver)) return;
    var _state=_driver.fr_bubbles_startup;
    if(_state.phase!=5 || !instance_exists(_state.player)) return;
    var _index=_state.player.index,_step=_state.play_steps;
    _state.touch_sampling=false;
    if(_step<55) {
        KeyCont.dir_fire[_index]=0;
        KeyCont.press_fire[_index]=_step==15;
        KeyCont.hold_fire[_index]=_step>=15 && _step<=44;
        KeyCont.release_fire[_index]=_step==45;
    }
    if(_step==61 || _step==150) {
        assert(KeyCont.press_fire[_index] && KeyCont.hold_fire[_index],
            "Real manual-aim JoystickAttack did not emit its held release-as-press edge");
        scrNTTESmokeLog("NTUF BUBBLES STARTUP real touch release edge "+json_stringify({
            skin:_state.skin,round:_state.round,trial:_state.trial,step:_step,
            press:KeyCont.press_fire[_index],hold:KeyCont.hold_fire[_index]}));
    }
    if(_step==145) {
        scrFRBubblesStartupTestsDiagnostic(_state,"held-mobile-before-release");
        assert(array_length(_state.attack_hits)==2,
            "Bubbles desktop/touch tap failed or held gesture repeated unexpectedly: "+json_stringify(_state.attack_hits));
    }
    KeyCont.press_spec[_index]=_step==165;
    KeyCont.hold_spec[_index]=_step>=165 && _step<=169;
}

function scrFRBubblesStartupTestsTouchState() {
    if(os_type!=os_windows || !scrNTTEFullSmokeEnabled()) return undefined;
    var _state=undefined;
    with(FRIntegrationTest) if(variable_instance_exists(id,"fr_bubbles_startup")) {
        _state=fr_bubbles_startup;break;
    }
    return is_struct(_state) && _state.phase==5 && _state.touch_sampling?_state:undefined;
}
function scrFRBubblesStartupTestsTouchNearest(_radius) {
    var _state=scrFRBubblesStartupTestsTouchState();
    return is_struct(_state)?(_state.touch.held?0:-1):get_nearest_touch(_radius);
}
function scrFRBubblesStartupTestsTouchX(_index) {
    var _state=scrFRBubblesStartupTestsTouchState();
    return is_struct(_state)?x+rad:device_mouse_x_to_gui(_index);
}
function scrFRBubblesStartupTestsTouchY(_index) {
    var _state=scrFRBubblesStartupTestsTouchState();
    return is_struct(_state)?y:device_mouse_y_to_gui(_index);
}
function scrFRBubblesStartupTestsTouchButton(_kind,_index,_button) {
    var _state=scrFRBubblesStartupTestsTouchState();
    if(is_struct(_state)) return _state.touch[$ _kind];
    switch(_kind) {
        case "held":return device_mouse_check_button(_index,_button);
        case "pressed":return device_mouse_check_button_pressed(_index,_button);
        case "released":return device_mouse_check_button_released(_index,_button);
    }
    return false;
}
function scrFRBubblesStartupTestsHitBegin(_slash,_target) {
    if(os_type!=os_windows || !scrNTTEFullSmokeEnabled()) return undefined;
    var _state=undefined;
    with(FRIntegrationTest) if(variable_instance_exists(id,"fr_bubbles_startup")) {
        _state=fr_bubbles_startup;break;
    }
    if(!is_struct(_state) || _state.phase!=5 || _state.attack_target!=_target
        || (_slash[$ "creator"]??noone)!=_state.player) return undefined;
    assert(_slash.team==_state.player.team && _slash.hitid==_state.player.hitid,
        "Bubbles starting Slash lost its new shooter's team or damage identity");
    return {state:_state,target:_target,hp:_target.hp,damage:_slash.damage,
        mode:_state.attack_mode,step:_state.play_steps};
}
function scrFRBubblesStartupTestsHitEnd(_sample) {
    if(!is_struct(_sample) || !instance_exists(_sample.target)) return;
    var _loss=_sample.hp-_sample.target.hp;
    if(_loss<=0) return;
    var _row={mode:_sample.mode,step:_sample.step,damage:_sample.damage,hp_loss:_loss};
    array_push(_sample.state.attack_hits,_row);
    scrNTTESmokeLog("NTUF BUBBLES STARTUP natural Slash collision "+json_stringify(_row));
}

function scrFRBubblesStartupTestsAttackFixture(_state) {
    _state.attack_hits=[];_state.attack_mode="desktop-hold";_state.weapon_swing=false;
    _state.attack_target=instance_create(_state.player.x+18,_state.player.y,FRCustomHitme);
    with(_state.attack_target) {
        hp=10000;max_hp=10000;team=team_enemy;speed=0;
        sprite_index=sprBanditIdle;mask_index=mskPlayer;
        spr_idle=sprBanditIdle;spr_hurt=sprBanditIdle;visible=true;
    }
    // These are ordinary mobile input options. The fixture never sets a
    // Player reload/can_shoot/clicked field or calls a weapon fire callback.
    UberCont.opt_keyboard=false;UberCont.opt_gamepad=false;UberCont.opt_aimbot=false;
    UberCont.opt_splitfire=false;UberCont.opt_stickregions=false;
    _state.attack_stick=noone;
    with(JoystickAttack) if(object_index==JoystickAttack) {_state.attack_stick=id;break;}
    if(!instance_exists(_state.attack_stick)) _state.attack_stick=instance_create(0,0,JoystickAttack);
    assert(instance_exists(_state.attack_stick),"Bubbles touch test has no real JoystickAttack");
    _state.attack_stick.index=-1;
}

function scrFRBubblesStartupTestsObserveLifecycle() {
    if(os_type!=os_windows || !scrNTTEFullSmokeEnabled()
        || !variable_global_exists("fr_bubbles_startup_state")) return;
    var _state=global.fr_bubbles_startup_state;
    if(!is_struct(_state) || _state.phase==6) return;
    // Genuine Retry destroys the test driver along with ordinary gameplay.
    // The observer belongs to surviving UberCont, just like RestartTests;
    // no production cleanup exception is granted to the test actor.
    instance_activate_object(_state.driver);
    if(instance_exists(_state.driver)) return;
    var _driver=instance_create(0,0,FRIntegrationTest);
    _driver.fr_test_case=_state.test_case;_driver.fr_bubbles_startup=_state;
    _state.driver=_driver;
    scrNTTESmokeLog("NTUF BUBBLES STARTUP Retry observer recreated after genuine session cleanup");
}

function scrFRBubblesStartupTestsRequestDeath(_state) {
    _state.old_game=_state.game;_state.old_player=_state.player;
    _state.runs=UberCont.ctot_runs[19];
    _state.source_runs=scrFRModCallArray("mod","libSaves","save_get",["Frontier","bubbles_runs"]);
    _state.marker=instance_create(0,0,FRMarker);
    _state.trial=1;_state.phase=7;_state.wait=0;
    // A real native hostile projectile triggers ordinary damage, Player
    // death, stats, GameOver and its actual Retry button. Never construct a
    // replacement Player or bypass the death-screen restart consumer.
    _state.death_bullet=instance_create(_state.player.x,_state.player.y,EnemyBullet1);
    with(_state.death_bullet) {team=team_enemy;damage=1000;speed=0;}
    scrNTTESmokeLog("NTUF BUBBLES STARTUP native lethal projectile requested "+json_stringify({
        skin:_state.skin,round:_state.round,player:real(_state.old_player),game:real(_state.old_game)}));
}

function scrFRBubblesStartupTestsDiagnostic(_state,_stage) {
    var _p=_state.player;
    if(!instance_exists(_p)) return;
    var _index=_p.index;
    scrNTTESmokeLog("NTUF BUBBLES STARTUP diagnostic "+json_stringify({stage:_stage,
        skin:_state.skin,round:_state.round,phase:_state.phase,
        trial:_state.trial,
        last_time:scrFRRaceVar("lastTime"),time_begin:_state.time_begin,
        last_bubbles:scrFRRaceVar("lastBubbles"),bubbles_begin:_state.bubbles_begin,
        steps:_state.steps,ends:_state.ends,draws:_state.draws,huds:_state.huds,
        play_steps:_state.play_steps,play_ticks:_state.play_ticks,
        press_fire:KeyCont.press_fire[_index],hold_fire:KeyCont.hold_fire[_index],
        press_spec:KeyCont.press_spec[_index],hold_spec:KeyCont.hold_spec[_index],
        can_spec:_p.can_spec,can_shoot:_p.can_shoot,visible:_p.visible,reload:_p.reload,hp:_p.hp,
        charge:_p.bubbles_bubbleCharge,cooldown:_p.bubbles_bubbleCooldown,
        ready:scrFRReadyTick(),paused:UberCont.paused,lock_state:scrGameIsLockState(),
        lockstep_stop:lockstep_stop,rate:game_get_speed(gamespeed_fps),scale:timescale,
        weapon_swing:_state.weapon_swing,attack_hits:_state.attack_hits,
        weapon:_p.wep,ammo:json_stringify(_p.ammo),
        weapon_valid:scr_weapon_is_valid(_p.wep),
        weapon_type:scr_weapon_get_type(_p.wep),weapon_cost:scr_weapon_get_cost(_p.wep)}));
}

function scrFRBubblesStartupTestsClear(_driver) {
    // Mirror native scrCleanupSessionInstances' whole-session retirement,
    // retaining only this explicit observer and the initialized source runtime
    // that a shipping menu already owns. No old room actor may keep ticking
    // against the removed GameCont, including persistent native Players/music.
    with(all) {
        if(id==_driver || object_index==UberCont || object_index==Console
            || object_index==FRWorld) continue;
        if(persistent && (object_index==FRCustomObject || object_index==FRBinding)) continue;
        instance_destroy(id,false);
    }
    assert(!instance_exists(Player) && !instance_exists(GameCont) && !instance_exists(BackCont)
        && !instance_exists(TopCont) && !instance_exists(LevCont) && !instance_exists(GenCont)
        && !instance_exists(Menu) && !instance_exists(enemy) && instance_number(Floor)==0
        && instance_number(Wall)==0,
        "Bubbles menu fixture retained an old native gameplay/terrain actor");
}

function scrFRBubblesStartupTestsRetire(_driver) {
    var _state=_driver.fr_bubbles_startup;
    if(!is_struct(_state[$ "retiring"]??undefined)) {
        var _retiring={events:[],ticks:0};
        _state.retiring=_retiring;
        // Event CleanUp owns delayed music/sprite restoration. Let the real
        // final callbacks finish while their old GameCont still exists.
        with(FRCustomObject) if(name=="Event") array_push(_retiring.events,real(id));
        for(var _i=0;_i<array_length(_retiring.events);_i+=1) {
            var _event=_retiring.events[_i];
            if(instance_exists(_event)) with(_event) instance_destroy();
        }
    }
    var _retiring=_state.retiring;
    _retiring.ticks+=1;
    assert(_retiring.ticks<180,"Bubbles fixture event cleanup did not retire before leaving its native run");
    for(var _i=0;_i<array_length(global.fr_tasks);_i+=1) {
        var _task=global.fr_tasks[_i],_final=_task.final_scope;
        if(!_task.done && is_struct(_final) && array_contains(_retiring.events,_final.source)) return false;
    }
    scrFRBubblesStartupTestsClear(_driver);
    // Retire discarded-room continuations after all authored event cleanup
    // has completed. Keep live initialized runtime/bootstrap owners; no
    // coroutine against a destroyed actor or final-callback snapshot belongs
    // to the next genuine run.
    var _retained=[],_discarded=0;
    for(var _i=0;_i<array_length(global.fr_tasks);_i+=1) {
        var _task=global.fr_tasks[_i],_scope=_task.scope;
        if(_task.done) continue;
        if(!is_struct(_scope) && instance_exists(_scope)
            && (_scope.object_index==FRWorld
                || (_scope.persistent && (_scope.object_index==FRCustomObject || _scope.object_index==FRBinding))))
            array_push(_retained,_task);
        else {_task.done=true;_discarded+=1;}
    }
    global.fr_tasks=_retained;
    scrNTTESmokeLog("NTUF BUBBLES STARTUP native session retired "+json_stringify({round:_state.round,
        events:array_length(_retiring.events),cleanup_ticks:_retiring.ticks,
        retained_tasks:array_length(_retained),discarded_room_tasks:_discarded}));
    _state.retiring=undefined;
    return true;
}

function scrFRBubblesStartupTestsMenu(_driver) {
    var _state=_driver.fr_bubbles_startup,_rate=_state.round==0?30:60;
    if(!scrFRBubblesStartupTestsRetire(_driver)) return;
    save_set_value("options","framerate",_rate);
    var _language=_state.round==0?"English":"Simplified Chinese";
    save_set_value("etc","language",_language);
    scrOptionsUpdate();
    scrLanguageSet(_language);
    assert(global.language_current[$ "Init:Id"]==_language,
        "Bubbles startup did not activate the real English/CJK language configuration");
    UberCont.paused=false;UberCont.opt_autopause=false;UberCont.opt_freeze=0;
    UberCont.want_quit_to_menu=false;UberCont.want_menu=false;UberCont.want_restart=false;
    global.seed=583091+_state.round;
    global.crownpick=crwn_none;
    scr_playerinstances_reset_all();
    assert(player_count==1 && is_struct(my_player) && my_player.is_local(),
        "Bubbles startup fixture did not retain the real local native player slot");
    scr_loadout_race_set_skin(19,_state.skin);
    if(_state.random) {
        save_delete_value("cswep",19);
        var _seed=random_get_seed();
        for(var _candidate=1;_candidate<10000;++_candidate) {
            random_set_seed(_candidate);
            if(irandom_range(Race.Fish,Race.NUM_ALL_RACE_TYPES-1)==19) {_state.random_seed=_candidate;break;}
        }
        random_set_seed(_seed);
    } else scr_loadout_race_set_start_weapon(19,_state.skin==1?FR_BUBBLES_SHOVEL:FR_BUBBLES_CUTLASS);
    assert(scr_loadout_race_get_skin(19)==_state.skin,
        "Native Bubbles loadout rejected the selected A/B skin");
    _state.trial=0;
    _state.runs=UberCont.ctot_runs[19];
    _state.source_runs=scrFRModCallArray("mod","libSaves","save_get",["Frontier","bubbles_runs"]);
    _state.steps=0;_state.ends=0;_state.draws=0;_state.play_steps=0;_state.play_ticks=0;
    _state.huds=0;
    _state.weapon_swing=false;_state.player=noone;_state.game=noone;
    _state.menu=instance_create(0,0,Menu);
    assert(instance_exists(_state.menu) && instance_number(CharSelect)>0 && !instance_exists(GameCont),
        "Bubbles startup did not construct the ordinary native character menu");
    // Reset retains the local slot's previous/default race. Start from Fish
    // through the real menu consumer so Random's first click selects it and
    // the second click genuinely confirms, just like the reported recording.
    if(_state.random) scrCampfireMenuSelectionChange(my_player.index,Race.Fish);
    _state.icon=noone;
    with(CharSelect) if(race==(_state.random?Race.Random:19)) {_state.icon=id;break;}
    assert(instance_exists(_state.icon),"Unlocked Bubbles was missing from the native menu");
    _state.phase=1;_state.wait=0;
    scrNTTESmokeLog("NTUF BUBBLES STARTUP real menu created "+json_stringify({skin:_state.skin,rate:_rate}));
}

function scrFRBubblesStartupTestsStep(_driver) {
    var _state=_driver.fr_bubbles_startup;
    _state.ticks+=1;
    assert(_state.ticks<4800,"Bubbles startup timed out at native phase "+string(_state.phase));
    assert(scrFREnabled() && instance_number(FRWorld)==1 && FRWorld.id==_state.owner
        && global.fr_boot_generation==_state.boot_generation,
        "Bubbles menu/new-run transition lost or reinitialized the Frontier registry");
    assert(global.fr_weapon_keys==_state.keys && global.fr_module_scripts==_state.scripts
        && global.fr_weapon_keys[$ string(FR_BUBBLES_CUTLASS)]=="weapon:FR_BubblesCutlass"
        && global.fr_weapon_keys[$ string(FR_BUBBLES_SHOVEL)]=="weapon:FR_BubblesShovel"
        && !is_undefined(global.fr_module_scripts[$ "weapon:FR_BubblesCutlass"][$ "weapon_fire"])
        && !is_undefined(global.fr_module_scripts[$ "weapon:FR_BubblesShovel"][$ "weapon_fire"]),
        "Bubbles new run/Retry lost or replaced its registered source weapon callback tables");
    if(_state.phase>=1 && _state.phase<=5) {
        var _rate=_state.round==0?30:60;
        assert(game_get_speed(gamespeed_fps)==_rate && UberCont.opt_framerate==_rate
            && timescale==30/_rate && !UberCont.opt_autopause,
            "Bubbles native menu/new-run changed its actual engine rate, logic scale or background policy");
    }
    if(_state.phase==0) {scrFRBubblesStartupTestsMenu(_driver);return false;}
    if(_state.phase==1) {
        // can is authored by the real CharSelect.Draw event. Waiting here
        // proves selection did not bypass the native drawing/unlock consumer.
        _state.wait+=1;
        if(_state.wait<4) return false;
        assert(instance_exists(_state.icon) && _state.icon.can,
            "Bubbles native menu Draw failed to enable its unlocked character");
        with(_state.icon) event_perform(ev_mouse,ev_left_press);
        assert((_state.random && my_player.race==Race.Random) || (my_player.race==19 && my_player.skin==_state.skin
            && my_player.cwep==(_state.skin==1?FR_BUBBLES_SHOVEL:FR_BUBBLES_CUTLASS)),
            "Native Bubbles selection lost its race, skin or authored starting weapon");
        _state.phase=2;_state.wait=0;
        scrNTTESmokeLog("NTUF BUBBLES STARTUP first real CharSelect.Mouse4 selected Bubbles");
        return false;
    }
    if(_state.phase==2) {
        _state.wait+=1;
        if(_state.wait<4) return false;
        assert(!instance_exists(GameCont) && !instance_exists(Player),
            "Bubbles fixture constructed gameplay before the genuine confirmation consumer");
        _state.marker=instance_create(0,0,FRMarker);
        _state.phase=3;
        // GameCont's real creation initializes the run seed. Use its native
        // custom-seed option, otherwise it replaces global.seed before the
        // Random selection consumer and the fixture cannot choose Bubbles.
        if(_state.random) {global.seed=_state.random_seed;global.custom_seed=_state.random_seed;}
        // Same selected CharSelect click calls the production scrRunStart,
        // which creates GameCont, scrCreatePlayers and queues room_restart.
        with(_state.icon) event_perform(ev_mouse,ev_left_press);
        assert(instance_number(GameCont)==1 && instance_number(Player)==1,
            "Bubbles native confirmation did not create the genuine new run");
        _state.player=instance_find(Player,0);_state.game=GameCont.id;
        var _p=_state.player;
        assert(_p.race==19 && _p.bskin==_state.skin && _p.is_me && _p.index==global.index
            && _p.wep==(_state.skin==1?FR_BUBBLES_SHOVEL:FR_BUBBLES_CUTLASS),
            "scrRunStart/scrCreatePlayers did not construct the selected local Bubbles loadout: "+json_stringify({race:_p.race,skin:_p.bskin,weapon:_p.wep,seed:global.seed}));
        assert(_p.bubbles_bubbleCharge==100 && _p.max_hp==8 && _p.hp==8
            && _p.spr_idle==scrFRRaceVar("sprIdle",_state.skin),
            "New Bubbles Player did not finish its authored initializer");
        assert(UberCont.ctot_runs[19]==_state.runs+1
            && scrFRModCallArray("mod","libSaves","save_get",["Frontier","bubbles_runs"])==_state.source_runs+1,
            "Native/source Bubbles new-run statistics were skipped or duplicated");
        scrNTTESmokeLog("NTUF BUBBLES STARTUP genuine scrRunStart/scrCreatePlayers returned "+json_stringify({skin:_state.skin,player:real(_p.id),weapon:_p.wep}));
        return false;
    }
    if(_state.phase==3) {
        assert(!instance_exists(_state.marker) && !instance_exists(Menu)
            && !instance_exists(GenCont) && instance_number(Floor)==0,
            "Bubbles genuine new-run room_restart retained old menu/terrain");
        assert(instance_exists(_state.player) && instance_exists(_state.game),
            "Native Bubbles Player or GameCont did not persist across new-run room disposal");
        if(!instance_exists(BackCont)) instance_create(0,0,BackCont);
        if(!instance_exists(MusCont)) instance_create(0,0,MusCont);
        // The isolated smoke bootstrap suppresses Vlambeer. This is its same
        // ordinary GenCont consumer, after actual Room End advanced 1-0 to1-1.
        var _gen=instance_create(0,0,GenCont);
        assert(instance_number(GenCont)==1 && !_gen.ntte_full_sync_generation,
            "Bubbles startup substituted synchronous/manual room generation");
        _state.phase=4;_state.wait=0;
        scrNTTESmokeLog("NTUF BUBBLES STARTUP real room disposal then ordinary async GenCont");
        return false;
    }
    if(_state.phase==4) {
        if(instance_exists(GenCont) || instance_exists(FloorMaker) || scrGameIsGenerationScreen()) return false;
        assert(instance_exists(_state.player) && _state.player.race==19
            && instance_exists(TopCont) && instance_number(Floor)>20 && instance_number(Wall)>0,
            "Bubbles new-run generation did not finish a populated native room");
        assert(GameCont.area==area_desert && GameCont.subarea==1 && GameCont.loops==0,
            "Bubbles native new-run room transition failed to enter ordinary1-1");
        assert(_state.player.fr_native_race==19 && is_array(_state.player.bubbles_reducedEnemies),
            "Bubbles source create/level_start did not complete before play");
        _state.time_begin=scrFRRaceVar("lastTime");
        _state.bubbles_begin=scrFRRaceVar("lastBubbles");
        scrFRBubblesStartupTestsAttackFixture(_state);
        _state.steps=0;_state.ends=0;_state.draws=0;
        _state.phase=5;_state.play_ticks=0;_state.play_steps=0;_state.huds=0;
        return false;
    }
    if(_state.phase==5) {
        assert(instance_exists(_state.player) && _state.player.race==19 && _state.player.hp>0,
            "Bubbles disappeared or died during the first natural gameplay frames");
        if(!scrFRReadyTick()) return false;
        _state.play_ticks+=1;
        if(_state.play_ticks<180) return false;
        scrFRBubblesStartupTestsDiagnostic(_state,"before-assert");
        assert(surface_exists(application_surface),"Bubbles natural gameplay draw surface is unavailable");
        surface_save(application_surface,working_directory+"frontier-bubbles-startup-"
            +string(_state.skin)+"-"+string(_state.round==0?30:60)
            +(_state.trial==1?"-retry":"")+".png");
        assert(_state.steps>=60 && _state.ends>=60 && _state.draws>=30,
            "Bubbles startup did not observe the real Player Step/EndStep/Draw events");
        assert(_state.huds>=30,
            "Bubbles real local primary-player charge HUD did not finish drawing during natural play");
        assert(scrFRRaceVar("lastTime")>_state.time_begin+1,
            "Bubbles native source ticks did not run after new-game generation");
        assert(scrFRRaceVar("lastBubbles")>_state.bubbles_begin,
            "Bubbles physical special input did not run after new-game generation");
        assert(_state.weapon_swing,"Bubbles authored starting melee weapon never fired through native Player input");
        assert(array_length(_state.attack_hits)==3,
            "Bubbles desktop hold/mobile tap/mobile held-release did not each damage the natural collision target exactly once: "+json_stringify(_state.attack_hits));
        var _modes=["desktop-hold","mobile-tap","mobile-hold"],_damage=_state.skin==0?6:9;
        for(var _i=0;_i<3;++_i) assert(_state.attack_hits[_i].mode==_modes[_i]
            && _state.attack_hits[_i].damage==_damage && _state.attack_hits[_i].hp_loss==_damage,
            "Bubbles starting weapon lost its authored damage through real input/Slash collision: "+json_stringify(_state.attack_hits));
        assert(UberCont.ctot_runs[19]==_state.runs+1
            && scrFRModCallArray("mod","libSaves","save_get",["Frontier","bubbles_runs"])==_state.source_runs+1,
            "Bubbles first gameplay frames replayed new-run statistics");
        scrNTTESmokeLog("NTUF BUBBLES STARTUP real new-run acceptance PASS "+json_stringify({skin:_state.skin,random:_state.random,
            trial:_state.trial==0?"new":"retry",
            requested_rate:_state.round==0?30:60,rate:game_get_speed(gamespeed_fps),
            option_rate:UberCont.opt_framerate,scale:timescale,
            steps:_state.steps,ends:_state.ends,draws:_state.draws,huds:_state.huds,
            language:global.language_current[$ "Init:Id"],weapon:_state.player.wep,
            native_runs:UberCont.ctot_runs[19]-_state.runs,
            source_runs:scrFRModCallArray("mod","libSaves","save_get",["Frontier","bubbles_runs"])-_state.source_runs,
            source_ticks:_state.play_ticks,weapon_swing:_state.weapon_swing,
            attack_hits:_state.attack_hits,bubbles:scrFRRaceVar("lastBubbles")-_state.bubbles_begin}));
        KeyCont.press_fire[0]=false;KeyCont.hold_fire[0]=false;
        KeyCont.release_fire[0]=false;
        KeyCont.press_spec[0]=false;KeyCont.hold_spec[0]=false;
        if(_state.trial==0) {scrFRBubblesStartupTestsRequestDeath(_state);return false;}
        _state.round+=1;
        if(_state.round<2) {_state.phase=0;return false;}
        _state.phase=6;return true;
    }
    if(_state.phase==7) {
        assert(++_state.wait<600,"Bubbles real lethal projectile did not reach a native GameOver/Retry screen");
        if(instance_exists(_state.old_player) || !instance_exists(GameOver)) return false;
        var _retry=noone;
        with(PauseButton) if(image_index==1 && sprite_index!=sprGameOverResult) {_retry=id;break;}
        if(!instance_exists(_retry)) return false;
        assert(instance_exists(_state.old_game) && !instance_exists(Player),
            "Bubbles death-menu Retry fixture bypassed genuine death disposal");
        _state.phase=8;_state.wait=0;_state.old_driver=_driver;
        if(_state.random) {global.seed=_state.random_seed;global.custom_seed=_state.random_seed;}
        with(_retry) event_perform(ev_other,ev_user0);
        assert(UberCont.want_restart>0,"Actual Bubbles death-menu Retry did not request native restart");
        scrNTTESmokeLog("NTUF BUBBLES STARTUP actual GameOver PauseButton Retry requested");
        return false;
    }
    if(_state.phase==8) {
        assert(++_state.wait<600,"Bubbles death-menu Retry failed to construct its new native run");
        if(instance_exists(_state.old_game) || instance_exists(_state.old_driver)
            || !instance_exists(GameCont) || !instance_exists(Player)) return false;
        _state.player=instance_find(Player,0);_state.game=GameCont.id;
        var _p=_state.player;
        assert(_p!=_state.old_player && _p.race==19 && _p.bskin==_state.skin
            && _p.wep==(_state.skin==1?FR_BUBBLES_SHOVEL:FR_BUBBLES_CUTLASS)
            && _p.bubbles_bubbleCharge==100 && _p.hp==8 && _p.max_hp==8,
            "Genuine Bubbles death-menu Retry lost its new Player, starter or source initializer");
        assert(UberCont.ctot_runs[19]==_state.runs+1
            && scrFRModCallArray("mod","libSaves","save_get",["Frontier","bubbles_runs"])==_state.source_runs+1,
            "Bubbles genuine death-menu Retry skipped or duplicated source/native game_start");
        _state.phase=3;
        scrNTTESmokeLog("NTUF BUBBLES STARTUP genuine death-menu Retry returned "+json_stringify({
            skin:_state.skin,rate:game_get_speed(gamespeed_fps),old_player:real(_state.old_player),
            new_player:real(_p),world:real(FRWorld.id),weapon:_p.wep}));
        return false;
    }
    return _state.phase==6;
}

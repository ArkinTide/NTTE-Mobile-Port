// Desktop acceptance: real room disposal/asynchronous generation, naturally
// generated prompts/waves/bosses and actual native death/exit processing.
// Only Player inputs and damage are supplied; no completion flags or timers.
function scrFRIDPDSpawnCompatTests() {
    var _before=scrNTTEFullInstances(all),_game=scrNTTEFullAreaGeneratorSnapshot(GameCont),
        _seed=random_get_seed(),_rng=scrNTTEFullArrayCopy(global.rng_state),
        _module="CustomIDPDHandler",_player=instance_find(Player,0),
        _spawned=scrFRModGet("mod",_module,"spawnedPortals");
    assert(instance_number(IDPDSpawn)==0 && instance_number(VanSpawn)==0
        && array_length(scrFRMatching(FRCustomObject,"name","IDPDPortal"))==0
        && !instance_exists(LilHunter),"IDPD constructor acceptance requires the initial isolated room");
    try {
        // Cover native area-zero's delayed threshold and outside-area-zero's
        // Loop3 threshold, with ordinary and elite source replacement paths.
        var _cases=[[0,0,0],[0,3,1],[0,4,0],[1,0,0],[1,1,1],[1,3,1]];
        for(var _i=0;_i<array_length(_cases);++_i) {
            var _case=_cases[_i];GameCont.area=_case[0];GameCont.loops=_case[1];
            GameCont.popolevel=0;
            var _spawn=instance_create(_player.x,_player.y,IDPDSpawn),
                _freak=(_case[1]-(_case[0]==0)>=3);
            assert(instance_exists(_spawn) && variable_instance_exists(_spawn,"freak")
                && _spawn.freak==_freak && GameCont.popolevel==1,
                "Native IDPD constructor lost its original freak threshold or counter");
            assert(variable_instance_exists(_spawn,"elite")
                && (_spawn.elite==0 || _spawn.elite==1) && _spawn.alarm[0]>0,
                "Native IDPD constructor lost its elite decision or authored spawn delay");
            // Deliberately cover both constructor-provided elite outcomes;
            // only that RNG result is fixed, not source selection or spawns.
            _spawn.elite=_case[2];
            var _x=_spawn.x,_y=_spawn.y;
            scrFRModCall("mod",_module,"step");
            var _portals=scrFRMatching(FRCustomObject,"name","IDPDPortal");
            assert(!instance_exists(_spawn) && array_length(_portals)==1,
                "Original Frontier handler did not replace the actual native IDPD spawn exactly once");
            var _portal=_portals[0],_unit=_freak?PopoFreak:(_case[2]?EliteGrunt:Grunt),
                _count=_unit==Grunt?2+_case[1]:1;
            assert(_portal.x==_x && _portal.y==_y && _portal.freak==_freak
                && _portal.elite==_case[2] && !_portal.van && _portal.level==1
                && GameCont.popolevel==1 && _portal.spawn_idpd==_unit && _portal.spawn_num==_count,
                "Original IDPD portal changed native location, elite/freak payload, counter or unit factory");
            var _units=instance_number(_unit);
            with(_portal) scrFRModCall("mod",_module,"DefaultIDPD_spawn");
            assert(instance_number(_unit)==_units+_count,
                "Original Frontier IDPD spawn callback did not instantiate its selected native units");
            scrNTTESmokeLog("FRONTIER IDPD CONSTRUCTOR "+json_stringify({area:_case[0],loops:_case[1],
                elite:_case[2],freak:_freak,unit:object_get_name(_unit),count:_count}));
            scrNTTEFullMergedRuntimeTestCleanup(_before);
        }
    } finally {
        scrNTTEFullMergedRuntimeTestCleanup(_before);scrNTTEFullAreaGeneratorRestore(_game);
        scrFRModSet("mod",_module,"spawnedPortals",_spawned);
        random_set_seed(_seed);global.rng_state=_rng;
    }
    scrNTTESmokeLog("PASS FRONTIER actual native IDPD constructor, original replacement handler and native unit factories");
}

function scrFRHyperCrystalCompatTests() {
    var _before=scrNTTEFullInstances(all),_game=scrNTTEFullAreaGeneratorSnapshot(GameCont),
        _music=scrNTTEFullAreaGeneratorSnapshot(MusCont),_seed=random_get_seed(),
        _player=instance_find(Player,0),_module="Frontier_Caves";
    try {
        for(var _variant=0;_variant<2;++_variant) {
            var _boss,_controller;
            if(_variant==0) {
                _boss=scrFRModCall("mod",_module,"CoveHyperCrystal_create",_player.x,_player.y);
                var _controllers=scrFRMatching(scrFRMatching(FRCustomObject,"name","fr_coveHyperController"),"myCrystal",_boss);
                assert(array_length(_controllers)==1,"Cove native HyperCrystal lost its authored controller");
                _controller=_controllers[0];
            } else {
                _boss=instance_create(_player.x,_player.y,HyperCrystal);
                _controller=scrFRModCall("mod",_module,"LightningHyperCrystalController_create",_player.x,_player.y,_boss);
            }
            assert(instance_exists(_boss) && is_array(_boss.crystal) && array_length(_boss.crystal)==0
                && _boss.crystals==0,"Native HyperCrystal must expose an empty orbit array before its first summon");
            scrFRInvoke(_controller,_controller.on_step,[]);
            assert(is_array(_boss.crystal) && array_length(_boss.crystal)==0,
                "Authored HyperCrystal controller invented an orbit before the native summon event");
            // Exercise the real native summon event and then the original
            // source controller against its actual child instance IDs.
            with(_boss) event_perform(ev_alarm,1);
            assert(_boss.crystals==1 && array_length(_boss.crystal)==_boss.cnumber,
                "Native HyperCrystal first summon did not populate its declared orbit slots");
            scrFRInvoke(_controller,_controller.on_step,[]);
            var _sprite=_variant==0?scrFRModGet("mod",_module,"sprCoveLaserCrystalIdle"):sprLightningCrystalIdle;
            for(var _j=0;_j<array_length(_boss.crystal);++_j) {
                var _child=_boss.crystal[_j];
                assert(instance_exists(_child) && instance_is(_child,_variant==0?LaserCrystal:LightningCrystal)
                    && _child.spr_idle==_sprite,
                    "Authored HyperCrystal controller failed to adapt a real native orbit child");
                instance_destroy(_child,false);
            }
            // Stale child handles remain valid array entries until Alarm1
            // notices the depleted ring and the following event replaces it.
            scrFRInvoke(_controller,_controller.on_step,[]);
            with(_boss) event_perform(ev_alarm,1);
            assert(_boss.crystals==0,"Native HyperCrystal did not detect its depleted native orbit");
            with(_boss) event_perform(ev_alarm,1);
            scrFRInvoke(_controller,_controller.on_step,[]);
            for(var _j=0;_j<array_length(_boss.crystal);++_j)
                assert(instance_exists(_boss.crystal[_j]) && _boss.crystal[_j].spr_idle==_sprite,
                    "Authored HyperCrystal controller lost a replacement native orbit child");
            instance_destroy(_controller,false);
            instance_destroy(_boss,false);
        }
    } finally {
        scrNTTEFullMergedRuntimeTestCleanup(_before);
        scrNTTEFullAreaGeneratorRestore(_game);scrNTTEFullAreaGeneratorRestore(_music);
        random_set_seed(_seed);
    }
    scrNTTESmokeLog("PASS FRONTIER native HyperCrystal empty/first/replacement orbit and original Cove/Lightning controllers");
}

function scrFRAreaTestsStart(_driver) {
    if(os_type!=os_windows || !scrNTTEFullSmokeEnabled()) throw "Frontier area fixture requires the isolated desktop harness";
    _driver.fr_area_cases=[];
    var _seeds=[18031,40993,67187],_regions=[[301,1,0],[301,1,1],[302,1,0],[303,1,0],
        [305,1,0],[305,2,0],[305,3,0],[306,1,0],[306,1,1]];
    for(var _pass=0;_pass<3;++_pass) for(var _j=0;_j<array_length(_regions);++_j) {
        var _r=_regions[_j];
        array_push(_driver.fr_area_cases,{area:_r[0],subarea:_r[1],loops:_r[2],seed:_seeds[_pass]+_r[0],pass:_pass});
    }
    var _dev=[1,50,99];
    for(var _j=0;_j<array_length(_dev);++_j)
        array_push(_driver.fr_area_cases,{area:304,subarea:_dev[_j],loops:0,seed:_seeds[_j]+304,pass:_j});
    array_push(_driver.fr_area_cases,{area:302,subarea:1,loops:1,seed:96317,pass:3});
    assert(array_length(_driver.fr_area_cases)==31,"Frontier area case manifest is incomplete");
    _driver.fr_area_index=-1;_driver.fr_area_phase=0;_driver.fr_area_ticks=0;_driver.fr_area_observed=0;
    _driver.fr_area_results=[];_driver.persistent=true;
    _driver.fr_area_cove_alt=scrFRModGet("area","cove","settingAltCoveEntrance");
    save_set_value("game","tutorial",false);
    UberCont.opt_bossintro=false;UberCont.opt_freeze=0;UberCont.opt_autopause=false;UberCont.paused=false;
    UberCont.want_quit_to_menu=false;UberCont.want_restart=false;UberCont.want_menu=false;
    scrFRAreaTestsNext(_driver);
}

function scrFRAreaTestsNext(_driver) {
    _driver.fr_area_index++;
    if(_driver.fr_area_index>=array_length(_driver.fr_area_cases)) {
        scrFRModSet("area","cove","settingAltCoveEntrance",_driver.fr_area_cove_alt);
        _driver.fr_area_phase=4;return;
    }
    var _case=_driver.fr_area_cases[_driver.fr_area_index],_area=_case.area;
    GameCont.area=_area;GameCont.subarea=_case.subarea;GameCont.loops=_case.loops;
    GameCont.lastarea=area_labs;GameCont.lastsubarea=3;GameCont.hard=9;GameCont.crown=Crown.None;
    GameCont.proto=false;GameCont.gocrib=false;GameCont.killenemies=false;
    GameCont.maxsubarea=scrAreaGetMaxSubarea(_area);GameCont.finalsubarea=GameCont.subarea==GameCont.maxsubarea;
    GameCont.baseseed=_case.seed;GameCont.levseed=_case.seed;
    GameCont.ntte_full_source_seed=scrNTTEFullSourceSeedBuild(_case.seed);
    GameCont.ntte_full_source_pending_generation=undefined;GameCont.ntte_full_pending_destination=undefined;
    GameCont.can_advance_stage=false;GameCont.is_level_ended=true;
    global.rng_state[@ RNGStates.Generation]=_case.seed;global.ntte_full_sync_generation=false;
    global.fr_continue_generation=undefined;global.fr_continue_events=undefined;
    scrFRModSet("area","robocenter","arenaGened",false);
    scrFRModSet("area","cove","settingAltCoveEntrance",_case.loops>0);
    _driver.fr_area_ticks=0;_driver.fr_area_observed=0;_driver.fr_area_phase=1;
    _driver.fr_area_live=undefined;_driver.fr_area_result=undefined;
    scrNTTESmokeLog("FRONTIER AREA BEGIN "+scrFRAreaKey(_area)+" sub="+string(_case.subarea)+" loop="+string(_case.loops)+" seed="+string(_case.seed));
    room_restart();
}

function scrFRAreaTestsTransition(_driver) {
    var _old_area=GameCont.area,_old_subarea=GameCont.subarea,_old_loops=GameCont.loops,
        _max=scrAreaGetMaxSubarea(_old_area),
        _next=(_old_subarea<_max)?[_old_area,_old_subarea+1]:scrFRAreaCall(_old_area,"area_next");
    assert(is_array(_next) && array_length(_next)>=2,"Frontier source area_next did not supply a route");
    _next[0]=scrFRAreaResolve(_next[0]);GameCont.ntte_full_pending_destination=undefined;
    with(GameCont) scrFRAreaFinish();
    var _destination=scrNTTEFullAreaTakeDestination();
    assert(is_struct(_destination) && _destination.area==_next[0] && _destination.subarea==_next[1]
        && _destination.loops==_old_loops,"Frontier source finish queued an incorrect native destination: "+scrFRAreaKey(_old_area));
    assert(GameCont.area==_old_area && GameCont.subarea==_old_subarea,
        "Frontier source finish changed the live world before the native room boundary");
    var _rolling=scrFRModGet("area","AlternateAreaHandler","rollingEnabled");
    try {
        scrFRModSet("area","AlternateAreaHandler","rollingEnabled",false);
        GameCont.lastarea=_old_area;GameCont.lastsubarea=_old_subarea;
        GameCont.area=_destination.area;GameCont.subarea=_destination.subarea;
        with(GameCont) scrFRAreaTransit();
        assert(GameCont.area==_next[0] && GameCont.subarea==_next[1]
            && GameCont.maxsubarea==scrAreaGetMaxSubarea(GameCont.area),
            "Frontier transit cleanup lost the resolved return destination");
    } finally {scrFRModSet("area","AlternateAreaHandler","rollingEnabled",_rolling);}
    return [_next[0],_next[1]];
}

function scrFRAreaTestsInspect(_driver) {
    var _case=_driver.fr_area_cases[_driver.fr_area_index],_name=scrFRAreaKey(_case.area),
        _floors=instance_number(Floor),_walls=instance_number(Wall),_invisible=instance_number(InvisiWall),
        _enemies=instance_number(enemy),_left=infinity,_right=-infinity,_top=infinity,_bottom=-infinity,
        _custom=0,_handlers=0,_bound=0;
    assert(GameCont.area==_case.area && GameCont.subarea==_case.subarea,"Frontier source generation changed its native destination");
    assert(_floors>=20 && _walls+_invisible>0,
        "Frontier actual generator omitted traversable floors or native collision: "+_name);
    // Deeplabs deliberately replaces ordinary walls/tops with authored rooms.
    if(_case.area!=303) assert(_walls>0 && instance_number(TopSmall)>0,
        "Frontier actual generator omitted its native collision walls/tops: "+_name);
    with(Floor) {
        assert(sprite_exists(sprite_index),"Frontier floor has no native sprite: "+_name);
        _left=min(_left,x);_right=max(_right,x+32);_top=min(_top,y);_bottom=max(_bottom,y+32);
    }
    assert(_right>_left && _bottom>_top,"Frontier generated terrain has empty bounds");
    with(enemy) {
        assert(x==x && y==y && abs(x)<1000000 && abs(y)<1000000,"Frontier encounter has nonfinite coordinates");
        assert(x>=_left-512 && x<=_right+512 && y>=_top-512 && y<=_bottom+512,
            "Frontier encounter escaped the authored terrain bounds: "+_name+" "+object_get_name(object_index));
        if(scrNTTEFullValue(id,"fr_custom_actor",false)) _custom++;
        if(!is_undefined(scrNTTEFullValue(id,"on_step",undefined))) _handlers++;
    }
    with(FRCustomObject) if(!persistent) {_custom++;if(!is_undefined(on_step)) _handlers++;}
    with(FRBinding) if(!persistent) _bound++;
    assert(_custom+_bound>0 && _handlers+_bound>0,"Frontier source callbacks did not survive real native generation: "+_name);
    if(_name=="cove" || _name=="robocenter")
        assert(array_length(scrFRMatching(FRCustomObject,"name","fr_area_halfdark"))==1,
            "Frontier area_start was skipped or duplicated: "+_name);
    with(Player) assert(x>=_left-32 && x<=_right+32 && y>=_top-32 && y<=_bottom+32,
        "Frontier native player spawn is outside the authored map: "+_name);
    _driver.fr_area_result={area:_name,subarea:_case.subarea,loops:_case.loops,seed:_case.seed,
        floors:_floors,walls:_walls,invisible_walls:_invisible,enemies:_enemies,
        custom:_custom,handlers:_handlers,bindings:_bound,bounds:[_left,_top,_right,_bottom],
        observed_source_ticks:_driver.fr_area_observed};
    var _p=instance_find(Player,0);assert(instance_exists(_p),"Frontier live area fixture lost its native Player");
    _driver.fr_area_live={phase:0,ticks:0,damage_calls:0,prompts:0,waves:0,boss_seen:false,
        death_sequence:false,clear_portal:false,player:_p,hold_x:_p.x,hold_y:_p.y};
}

function scrFRAreaTestsNamed(_object,_name) {return scrFRMatching(_object,"name",_name);}
function scrFRAreaTestsOne(_name) {
    var _items=scrFRAreaTestsNamed(FRCustomObject,_name);
    assert(array_length(_items)==1,"Frontier authored object missing or duplicated: "+_name);return _items[0];
}
function scrFRAreaTestsMove(_player,_x,_y) {
    assert(instance_exists(_player),"Frontier area interaction lost its native Player");
    _player.x=_x;_player.y=_y;_player.xprevious=_x;_player.yprevious=_y;_player.speed=0;
}
function scrFRAreaTestsPromptPulse(_pulse) {
    // Run at the actual lib late-step binding's next natural dispatch, once.
    // The complete original binding still owns LibPrompt selection, on_pick
    // callbacks and the following source on_step/wait animation sequence.
    fr_binding_code=_pulse.code;fr_binding_args=_pulse.args;
    assert(_pulse.calls==0,"Frontier area prompt input edge dispatched twice");
    _pulse.calls++;
    var _player=_pulse.player,_pressed=false,_slot=-1;
    try {
        if(instance_exists(_player) && instance_exists(_pulse.prompt)) {
            _slot=_player.index;_pressed=KeyCont.press_pick[_slot];
            assert(!_pressed,"Frontier area prompt fixture overlapped an existing pickup edge");
            KeyCont.press_pick[_slot]=true;
        }
        scrFRCallArray(_pulse.code,_pulse.args);
        _pulse.selected=instance_exists(_pulse.prompt) && instance_exists(_player) && _slot>=0
            && _pulse.prompt.pick==_slot && instance_exists(_player.nearwep)
            && real(_player.nearwep)==real(_pulse.prompt.nearwep);
        _pulse.serial=scrFRLogicSerial();
    } finally {
        if(_slot>=0) KeyCont.press_pick[_slot]=_pressed;
        _pulse.released=true;_pulse.done=true;
    }
}
function scrFRAreaTestsPrompt(_creator,_player) {
    var _pending=_player[$ "fr_area_prompt_pulse"]??undefined,_creator_id=real(_creator.id);
    if(is_struct(_pending)) {
        if(!_pending.done && !instance_exists(_pending.binding)) _player.fr_area_prompt_pulse=undefined;
        else if(!_pending.done) return false;
        else if(_pending.creator==_creator_id && _pending.selected) {
            if(_pending.consumed) return false;
            assert(_pending.calls==1 && _pending.released,
                "Frontier area prompt did not complete a single native input/release edge");
            _pending.consumed=true;return true;
        }
    }
    var _prompt=noone;
    with(FRCustomObject) if(scrFRPromptIs(id)
        && scrFRScopeSame(scrNTTEFullValue(id,"creator",noone),_creator)
        && !is_undefined(on_step)) {_prompt=id;break;}
    if(!instance_exists(_prompt)) return false;
    var _lib=scrFRLibGlobal(),_binding=instance_exists(_lib)?_lib.bind_late_step:noone;
    assert(instance_exists(_binding) && _binding.object_index==FRBinding && _binding.fr_binding_kind=="step",
        "Frontier area prompt lost the real source late-step binding");
    var _pulse={creator:_creator_id,player:real(_player.id),prompt:real(_prompt.id),binding:real(_binding.id),
        code:_binding.fr_binding_code,args:_binding.fr_binding_args,calls:0,
        done:false,selected:false,released:false,consumed:false,serial:-1};
    _player.fr_area_prompt_pulse=_pulse;
    _binding.fr_binding_code=scrFRAreaTestsPromptPulse;_binding.fr_binding_args=[_pulse];
    return false;
}
function scrFRAreaTestsDamage(_targets,_player) {
    var _hits=0;
    for(var _i=0;_i<array_length(_targets);++_i) {
        var _target=_targets[_i];
        if(!instance_exists(_target) || scrNTTEFullValue(_target,"hp",0)<=0) continue;
        with(_player) if(scrFRProjectileHitRaw(_target,1000000,0)) _hits++;
    }
    return _hits;
}
function scrFRAreaTestsClear(_live) {_live.damage_calls+=scrFRAreaTestsDamage(scrFRInstances(enemy),_live.player);}
function scrFRAreaTestsPortal(_type=-1,_invisible=false) {
    var _found=noone;
    with(Portal) if((_type<0 || type==_type) && (!_invisible || image_alpha==0)) {_found=id;break;}
    return _found;
}

function scrFRAreaTestsCove(_driver,_case,_live) {
    var _p=_live.player;
    if(_live.phase==0) {
        _live.mimic=scrFRAreaTestsOne("fr_TreasureMimic");
        if(_case.loops>0) {
            var _ctrl=scrFRAreaTestsOne("fr_coveHyperController");
            assert(instance_exists(_ctrl.myCrystal) && instance_is(_ctrl.myCrystal,HyperCrystal),
                "Cove alternate entrance omitted its real native HyperCrystal");
            _live.boss_seen=true;_live.boss=_ctrl.myCrystal;
        }
        scrFRWeaponSlotWrite(_p,"wep",wep_shotgun);scrFRWeaponSlotWrite(_p,"bwep",wep_revolver);_p.curse=0;
        _live.phase=1;_live.exchange_picked=false;_live.exchange_complete=false;
    }
    if(_live.phase==1) {
        GameCont.is_level_ended=true;scrFRAreaTestsMove(_p,_live.mimic.x,_live.mimic.y+8);
        if(!_live.exchange_picked && scrFRAreaTestsPrompt(_live.mimic,_p)) {_live.exchange_picked=true;_live.prompts++;}
        var _output=false;
        with(WepPickup) if(scrFRSourceWeaponEqual(scrFRWeaponSlotRead(id,"wep"),"FR_Blunderbuss")) {_output=true;break;}
        if(!_output) return false;
        assert(_live.exchange_picked && _live.mimic.validwep,"Cove mimic skipped the actual shotgun exchange callback");
        _live.exchange_complete=true;_live.phase=2;scrFRAreaTestsMove(_p,_live.hold_x,_live.hold_y);
    }
    GameCont.is_level_ended=false;scrFRAreaTestsClear(_live);
    if(!instance_exists(scrFRAreaTestsPortal())) return false;
    if(_case.loops>0) assert(!instance_exists(_live.boss),"Cove clear exit opened before its actual HyperCrystal died");
    _live.clear_portal=true;return true;
}

function scrFRAreaTestsCyber(_driver,_case,_live) {
    if(_live.phase==0) {
        _live.processors=scrFRAreaTestsNamed(FRCustomObject,"fr_robotprocessor");
        assert(array_length(_live.processors)==3,"Cyberspace did not generate exactly three real processors");
        _live.processor_index=0;_live.processor_picked=false;_live.processor_wave=false;_live.phase=1;
    }
    GameCont.is_level_ended=false;
    if(_live.processor_index<3) {
        if(array_length(scrFRMatching(_live.processors,"complete",false))>0)
            assert(!instance_exists(scrFRAreaTestsPortal(3)),"Cyberspace exit opened before all real processors completed");
        var _processor=_live.processors[_live.processor_index];
        assert(instance_exists(_processor),"Cyberspace processor vanished before reboot completion");
        scrFRAreaTestsMove(_live.player,_processor.x,_processor.y+8);
        if(!_live.processor_picked && scrFRAreaTestsPrompt(_processor,_live.player)) {_live.processor_picked=true;_live.prompts++;}
        var _wave=scrFRMatching(enemy,"fr_processor",_processor);
        if(array_length(_wave)>0) _live.processor_wave=true;
        _live.damage_calls+=scrFRAreaTestsDamage(_wave,_live.player);
        if(!_processor.complete) return false;
        assert(_live.processor_picked && _live.processor_wave && _processor.enemiesSpawned>0
            && !_processor.active && array_length(_wave)==0,
            "Cyberspace completion skipped its real prompt, spawned wave or native deaths");
        _live.waves+=_processor.enemiesSpawned;_live.processor_index++;
        _live.processor_picked=false;_live.processor_wave=false;return false;
    }
    if(!instance_exists(scrFRAreaTestsPortal(3))) return false;
    assert(array_length(scrFRAreaTestsNamed(enemy,"Smile"))==0,"Cyberspace completion failed authored Smile cleanup");
    _live.clear_portal=true;return true;
}

function scrFRAreaTestsDeep(_driver,_case,_live) {
    var _p=_live.player;GameCont.is_level_ended=false;
    if(_live.phase==0) {
        _live.controller=scrFRAreaTestsOne("fr_DeeplabsFinaleController");_live.panel=scrFRAreaTestsOne("fr_DeeplabsCorePanel");
        _live.safe=scrFRAreaTestsOne("fr_deeplabsSafeZone");_live.elevator=scrFRAreaTestsOne("fr_DeeplabsEndElevator");
        _live.safe_x=(_live.safe.bbox_left+_live.safe.bbox_right)/2;_live.safe_y=(_live.safe.bbox_top+_live.safe.bbox_bottom)/2;
        _live.panel_picked=false;_live.safe_observed=false;_live.goal_bomb=false;_live.phase=1;
    }
    if(_live.phase==1) {
        scrFRAreaTestsMove(_p,_live.panel.x,_live.panel.y+8);
        if(!_live.panel_picked && scrFRAreaTestsPrompt(_live.panel,_p)) {_live.panel_picked=true;_live.prompts++;}
        if(!_live.controller.bombStarted) return false;
        // Source autoBomb is an authored compile-time macro. Moving from the
        // start-room hitbox may activate the core before the panel animation;
        // accept either genuine input route, never edit that macro or timer.
        assert(_live.panel.active && (_live.panel_picked
            || array_length(scrFRAreaTestsNamed(FRCustomObject,"fr_deeplabsStartingRoomHitbox"))==0),
            "Deeplabs countdown bypassed its real panel/start-room input");_live.phase=2;
    }
    if(_live.phase==2 || _live.phase==3) {
        scrFRAreaTestsMove(_p,_live.safe_x,_live.safe_y);
        var _inside=false;with(_p) _inside=place_meeting(x,y,_live.safe);
        assert(_inside,"Deeplabs safe-room input missed the real authored collision geometry");
        if(scrNTTEFullValue(_p,"fr_deeplabsIMSAFE",false)) _live.safe_observed=true;
        if(_live.controller.goalBomb) _live.goal_bomb=true;
    }
    if(_live.phase==2) {
        if(!scrFRModGet("area","deeplabs","esploded")) return false;
        assert(_live.safe_observed && _live.goal_bomb,"Deeplabs finale skipped its real safe-zone countdown");
        _live.death_sequence=true;_live.phase=3;
    }
    if(_live.phase==3) {
        if(!_live.elevator.arrived) return false;
        scrFRAreaTestsMove(_p,_live.elevator.x,_live.elevator.y+8);
        if(!scrFRAreaTestsPrompt(_live.elevator,_p)) return false;
        _live.prompts++;_live.phase=4;
    }
    if(_live.phase==4) {
        if(!_live.elevator.spawnedPortal) return false;
        assert(_live.elevator.arrived && _live.elevator.leftthestation && _live.elevator.launchedPod
            && instance_exists(scrFRAreaTestsPortal(-1,true)),
            "Deeplabs elevator skipped its real arrival/leave/pod/invisible-exit sequence");
        _live.clear_portal=true;return true;
    }
    return false;
}

function scrFRAreaTestsGrave(_driver,_case,_live) {
    if(_live.phase==0) {
        if(_case.subarea==3) {assert(instance_exists(WantLH),"Graveyard finale omitted its native LilHunter alarm");_live.phase=1;}
        else _live.phase=2;
    }
    GameCont.is_level_ended=false;
    if(_live.phase==1) {if(!instance_exists(LilHunter)) return false;_live.boss_seen=true;_live.phase=2;}
    scrFRAreaTestsClear(_live);if(!instance_exists(scrFRAreaTestsPortal())) return false;
    if(_case.subarea==3) assert(_live.boss_seen && !instance_exists(LilHunter) && !instance_exists(WantLH),
        "Graveyard exit did not wait for the real delayed LilHunter encounter/death");
    _live.clear_portal=true;return true;
}

function scrFRAreaTestsRobo(_driver,_case,_live) {
    if(_live.phase==0) {
        _live.entrance=scrFRAreaTestsOne("fr_DeeplabsEntrance");
        if(_case.loops>0) {
            var _boss=scrFRAreaTestsNamed(enemy,"BULWARK SYSTEM");
            assert(array_length(_boss)==1,"Robocenter Loop1 arena omitted the real Bulwark System");
            _live.boss=_boss[0];_live.boss_seen=true;_live.boss_x=_live.boss.x;_live.boss_y=_live.boss.y;
        }
        _live.phase=1;
    }
    GameCont.is_level_ended=false;
    if(_live.phase==1) {
        var _deaths=scrFRAreaTestsNamed(FRCustomObject,"fr_RoboBossDeath");
        if(array_length(_deaths)>0) {
            if(!_live.death_sequence) _live.death_started=_live.ticks-(90-_deaths[0].lifeTime);
            _live.death_sequence=true;
            assert(scrNTTEFullPortalBlocked(),"Native corpse/recovery exit ignored the real Bulwark delayed death actor");
        }
        scrFRAreaTestsClear(_live);if(!instance_exists(scrFRAreaTestsPortal())) return false;
        if(_case.loops>0) {
            var _trace={ticks:_live.ticks,boss_seen:_live.boss_seen,death_seen:_live.death_sequence,
                boss_exists:instance_exists(_live.boss),boss_hp:undefined,death_actors:[],enemies:[],corpses:[],portals:[],blockers:[],
                native_enemy_check:scr_check_enemies(),native_portal_blocked:scrNTTEFullPortalBlocked()},
                _all=scrNTTEFullInstances(all);
            if(_trace.boss_exists) _trace.boss_hp=_live.boss.hp;
            for(var _i=0;_i<array_length(_deaths);++_i) {
                var _actor=_deaths[_i];
                array_push(_trace.death_actors,{id:_actor,lifeTime:scrNTTEFullValue(_actor,"lifeTime",undefined),x:_actor.x,y:_actor.y});
            }
            for(var _i=0;_i<array_length(_all);++_i) {
                var _actor=_all[_i];if(!instance_exists(_actor)) continue;
                if(instance_is(_actor,enemy)) array_push(_trace.enemies,{id:_actor,object:object_get_name(_actor.object_index),
                    name:scrNTTEFullValue(_actor,"name",""),hp:scrNTTEFullValue(_actor,"hp",undefined)});
                if(instance_is(_actor,Corpse)) array_push(_trace.corpses,{id:_actor,object:object_get_name(_actor.object_index),alarm0:_actor.alarm[0],x:_actor.x,y:_actor.y});
                if(instance_is(_actor,Portal)) array_push(_trace.portals,{id:_actor,type:scrNTTEFullValue(_actor,"type",undefined),x:_actor.x,y:_actor.y});
                if(instance_is(_actor,NTTEFullPortalPrevent)) array_push(_trace.blockers,{id:_actor,creator:scrNTTEFullValue(_actor,"creator",undefined)});
            }
            scrNTTESmokeLog("FRONTIER ROBO EXIT "+json_stringify(_trace));
            assert(_live.boss_seen && _live.death_sequence && !instance_exists(_live.boss)
                && array_length(_deaths)==0,
                "Robocenter exit skipped its actual Bulwark death sequence/native corpse exit");
            var _spawner_corpse=false;
            with(Corpse) if(sprite_index==mskNone && x==_live.boss_x && y==_live.boss_y) {_spawner_corpse=true;break;}
            assert(_live.ticks-_live.death_started>=90 && _spawner_corpse,
                "Robocenter exit skipped the full authored death lifetime or its real invisible enemy corpse");
        }
        _live.clear_portal=true;_live.phase=2;
    }
    if(_live.phase==2) {
        if(!_live.entrance.entranceopen) return false;
        scrFRAreaTestsMove(_live.player,_live.entrance.x,_live.entrance.y);_live.phase=3;return false;
    }
    // Observe the real collision callback before the native finish boundary.
    // Source Deeplabs/0 + its invisible Portal must advance to Deeplabs/1.
    if(GameCont.area!=303 || GameCont.subarea!=0) return false;
    assert(instance_exists(scrFRAreaTestsPortal(-1,true)),"Robocenter entrance omitted its real invisible transfer portal");
    _live.deeplabs_entrance=true;return true;
}

function scrFRAreaTestsLive(_driver) {
    var _case=_driver.fr_area_cases[_driver.fr_area_index],_live=_driver.fr_area_live,_done=false;
    _live.ticks+=scrFRSourceScale();
    switch(_case.area) {
        case 301:_done=scrFRAreaTestsCove(_driver,_case,_live);break;
        case 302:_done=scrFRAreaTestsCyber(_driver,_case,_live);break;
        case 303:_done=scrFRAreaTestsDeep(_driver,_case,_live);break;
        case 304:
            GameCont.is_level_ended=false;
            assert(instance_exists(becomenemy) && !instance_exists(Portal),
                "Devzone sandbox sentinel vanished or an unauthored clear exit appeared");
            // Authored 99-floor sandbox has no clear exit; do not invent one.
            _done=_live.ticks>=60;break;
        case 305:_done=scrFRAreaTestsGrave(_driver,_case,_live);break;
        case 306:_done=scrFRAreaTestsRobo(_driver,_case,_live);break;
    }
    if(!_done) return false;
    var _result=_driver.fr_area_result;
    _result.live_source_ticks=_live.ticks;_result.damage_calls=_live.damage_calls;_result.prompt_inputs=_live.prompts;
    _result.processor_wave_enemies=_live.waves;_result.authored_boss_seen=_live.boss_seen;
    _result.death_sequence_seen=_live.death_sequence;_result.clear_exit_observed=_live.clear_portal;
    _result.exit_contract=(_case.area==304)?"authored-sandbox-sentinel-no-exit":"real-source-interaction-native-death-exit";
    GameCont.is_level_ended=true;_result.next=scrFRAreaTestsTransition(_driver);
    if(_case.area==306) assert(_result.next[0]==303 && _result.next[1]==1,"Real Robocenter entrance did not queue Deeplabs/1");
    array_push(_driver.fr_area_results,_result);scrNTTESmokeLog("FRONTIER AREA PASS "+json_stringify(_result));return true;
}

function scrFRAreaTestsStep(_driver) {
    if(_driver.fr_area_phase==4) {
        assert(array_length(_driver.fr_area_results)==31,"Frontier area campaign skipped a seed, actual subarea or Loop encounter");
        scrNTTESmokeLog("FRONTIER AREAS31 actual subareas + 3seeds + Loop encounters + prompts/waves/native deaths/real exits + sandbox contract PASS");return true;
    }
    _driver.fr_area_ticks++;
    var _detail=is_struct(_driver.fr_area_live)?" live="+string(_driver.fr_area_live.phase):"";
    assert(_driver.fr_area_ticks<7200,"Frontier area acceptance timed out case="+string(_driver.fr_area_index)+" phase="+string(_driver.fr_area_phase)+_detail);
    with(Player) {hp=100000;max_hp=100000;nexthurt=current_frame+100000;speed=0;can_walk=false;can_aim=false;}
    if(_driver.fr_area_phase<=3) GameCont.is_level_ended=true;
    if(_driver.fr_area_phase==1) {
        scrNTTESmokeLog("FRONTIER AREA START native generator");
        if(!instance_exists(BackCont)) instance_create(0,0,BackCont);
        if(!instance_exists(MusCont)) instance_create(0,0,MusCont);
        // Genuine checkpoint event restoration suppresses only unrelated
        // random event lotteries. All authored area content remains natural.
        global.fr_continue_events={game:GameCont.id,events:[]};
        var _generation=instance_create(0,0,GenCont);
        assert(instance_exists(_generation) && !_generation.ntte_full_sync_generation,
            "Frontier fixture replaced actual async generation with sync callbacks");
        scrNTTESmokeLog("FRONTIER AREA STARTED native generator");
        _driver.fr_area_phase=2;return false;
    }
    if(instance_exists(GenCont) || instance_exists(FloorMaker)) return false;
    if(_driver.fr_area_phase==2) {
        scrNTTESmokeLog("FRONTIER AREA GENERATED native terrain");
        _driver.fr_area_phase=3;_driver.fr_area_observed=0;
    }
    if(_driver.fr_area_phase==3) {
        _driver.fr_area_observed+=scrFRSourceScale();if(_driver.fr_area_observed<24) return false;
        scrFRAreaTestsInspect(_driver);_driver.fr_area_phase=5;return false;
    }
    if(_driver.fr_area_phase==5 && scrFRAreaTestsLive(_driver)) scrFRAreaTestsNext(_driver);
    return false;
}

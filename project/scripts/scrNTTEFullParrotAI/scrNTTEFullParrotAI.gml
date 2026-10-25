// parrot.race.gml 829..1470,1727..1875. Native alarm units are logical
// 30Hz ticks. Run this after UberCont's integer alarm top-up, before alarms.
function scrNTTEFullParrotCharmPlayer(_index) {
    var _result=noone
    with(Player) if(index==_index) _result=id
    return _result
}
function scrNTTEFullParrotCharmTargetBegin(_inst) {
    // Alarm/TargetEnd/Grab complete synchronously. A fresh token belongs to
    // each nested alarm and never survives into a later native event.
    var _state={players:[],before:scrNTTEFullMergedCaptureBegin(),actor:_inst,
        creator:scrNTTEFullValue(_inst,"creator",noone),team:scrNTTEFullValue(_inst,"team",team_player),charm:_inst.ntte_charm,speed:_inst.speed,
        monster:instance_is(_inst,enemy) || instance_is(_inst,NTTEFullPet) || scrNTTEFullValue(_inst,"ntte_monster_projectile",false)}
    var _target=scrNTTEFullParrotCharmTarget(_inst)
    // NTT Grunt alarms reference Player-specific fields when no Player exists.
    if(!(instance_is(_inst,Grunt) && !instance_exists(Player)) && variable_instance_exists(_inst,"target")) _inst.target=_target
    if(variable_instance_exists(_inst,"target")) with(Player) {
        array_push(_state.players,[id,x,y])
        if(instance_exists(_target)) { x=_target.x; y=_target.y }
        else { var _dir=random(360); x+=lengthdir_x(10000,_dir); y+=lengthdir_y(10000,_dir) }
    }
    return _state
}
function scrNTTEFullParrotCharmTargetEnd(_state) {
    for(var _i=0;_i<array_length(_state.players);++_i) {
        var _row=_state.players[_i]
        if(instance_exists(_row[0])) { _row[0].x=_row[1]; _row[0].y=_row[2] }
    }
}
function scrNTTEFullParrotCharmable(_inst) {
    return instance_is(_inst,hitme) || instance_is(_inst,NecroReviveArea) || instance_is(_inst,RevivePopoFreak)
}
function scrNTTEFullParrotCharmInherit(_inst,_source,_parent) {
    if(!instance_exists(_inst) || !scrNTTEFullParrotCharmable(_inst)) return;
    var _own=scrNTTEFullValue(_inst,"ntte_charm",undefined)
    if(is_struct(_own) && _own.charmed) {scrNTTEFullParrotCharmRegisterCopy(_inst);return;}
    var _vars=scrNTTEFullParrotCharm(_inst,true)
    _vars.time=_source.time; _vars.index=_source.index; _vars.kill=_source.kill; _vars.feather=_source.feather
    if(instance_is(_inst,hitme)) {
        if(instance_is(_inst,enemy) && !instance_is(_inst,bossenemy) && !scrNTTEFullValue(_inst,"enemy_boss",false) && !scrNTTEFullValue(_inst,"givekill",true)) {
            _vars.kill=!instance_is(_parent,bossenemy) && !scrNTTEFullValue(_parent,"enemy_boss",false)
            if(_vars.kill) _inst.raddrop=0
        }
        if(_vars.feather && _vars.time>=0) {
            var _first=noone,_owner=scrNTTEFullParrotCharmPlayer(_vars.index)
            // Source deliberately creates at least one inherited feather,
            // consuming 1.5 feather lifetimes until the inherited time is zero.
            do {
                var _f=scrNTTEFullParrotFeatherNew(_inst.x+orandom(24),_inst.y+orandom(24),_owner,_inst,_vars.index)
                _f.creator=noone
                _vars.time-=min(_vars.time,_f.stick_time*1.5)
                if(!instance_exists(_first)) _first=_f
            } until(_vars.time<=0)
            if(instance_exists(_first)) {
                _first.x=random_range(_inst.bbox_left,_inst.bbox_right+1); _first.y=random_range(_inst.bbox_top,_inst.bbox_bottom+1)
                _first.stick_wait=0
                with(_first) scrNTTEFullParrotFeatherStep()
            }
        }
    }
}
function scrNTTEFullParrotCharmGrab(_state) {
    // Freeze the exact births before inheritance callbacks create feathers or
    // descendants; those later births were outside the old full-room snapshot.
    var _new=scrNTTEFullMergedRuntimeNew(_state.before),_owner=_state.actor
    if(!instance_exists(_owner) && instance_exists(_state.creator)) _owner=_state.creator
    for(var _i=0;_i<array_length(_new);++_i) {
        var _inst=_new[_i]
        if(!instance_exists(_inst)) continue
        var _creator=scrNTTEFullValue(_inst,"creator",noone)
        if(scrNTTEFullParrotCharmable(_inst)) {
            if(_creator==noone) { _creator=_owner; _inst.creator=_creator }
            if(_creator==_state.actor || _creator==_state.creator || _creator==_owner) scrNTTEFullParrotCharmInherit(_inst,_state.charm,_owner)
        }
        if(instance_is(_inst,projectile) || instance_is(_inst,LaserCannon)) {
            if(_creator==noone || _creator==_state.actor || (_creator==_state.creator && !instance_is(_state.actor,hitme))) {
                _inst.team=_state.team
                // Native Wolf/Scorpion alarms can create unowned bullets with
                // raw instance_create. Preserve the actual source's monster
                // identity without changing creator, quantity, attack or RNG.
                if(scrNTTEFullValue(_state,"monster",false)) _inst.ntte_monster_projectile=true
                scrNTTEFullPetTwinsTeam(_inst,_state.team)
            }
        }
    }
}
function scrNTTEFullParrotCharmAlarm(_inst,_num) {
    var _state=scrNTTEFullParrotCharmTargetBegin(_inst),_error=undefined
    // No target is an intentional skipped attack for these two native alarms.
    try {
        if(_num!=2 || instance_exists(_inst.target) || (!instance_is(_inst,Gator) && !instance_is(_inst,JungleAssassin)))
            with(_inst) { alarm[_num]=0; event_perform(ev_alarm,_num) }
    }
    catch(_caught) { _error=_caught }
    finally {
        scrNTTEFullParrotCharmTargetEnd(_state)
        // The original error path restores players and rethrows before Grab.
        // Close this local token without inheriting partial failed emissions.
        if(!is_undefined(_error)) scrNTTEFullMergedRuntimeNew(_state.before)
    }
    if(!is_undefined(_error)) throw _error
    if(instance_exists(_inst)) {
        if(_inst.alarm[_num]>0) _inst.alarm[_num]+=1
        if(instance_is(_inst,enemy) && (_inst.canmelee || (_inst.alarm[11]>0 && _inst.alarm[11]<20)) && _inst.meleedamage>0) _inst.speed=max(_inst.speed,_state.speed)
    }
    scrNTTEFullParrotCharmGrab(_state)
}
function scrNTTEFullParrotCharmAggro() {
    // The source acceleration mutates only on a logical30Hz tick. Do not
    // discover projectile/shield/revive blockers on intervening Draw frames.
    if(current_frame%1>=timescale) return;
    if(alarm[1]<=0 || !instance_is(id,enemy) || alarm[2]>=0 || scrNTTEFullValue(id,"ammo",0)>0) return;
    if(variable_instance_exists(id,"intro") && !intro) return;
    if(sprite_index!=spr_idle && sprite_index!=spr_walk && sprite_index!=spr_hurt) return;
    var _self=id
    with(projectile) if(creator==_self) return;
    with(PopoShield) if(creator==_self) return;
    with(NecroReviveArea) if(creator==_self) return;
    // Same original Increased Aggro amount; each pure membership search may
    // stop at its first blocker without changing an alarm, emission or RNG.
    alarm[1]=max(1,alarm[1]-ceil(10/max(1,size)-1))
}
function scrNTTEFullParrotCharmFollow() {
    if(!instance_is(id,enemy) || !instance_exists(Player) || scrNTTEFullValue(id,"ammo",0)>0) return;
    if(meleedamage>0 && !variable_instance_exists(id,"gunangle") && !(scrNTTEFullValue(id,"walk",0)>0 && !instance_is(id,ExploFreak))) return;
    var _target=ntte_charm.target
    if(!instance_exists(_target) || collision_line(x,y,_target.x,_target.y,Wall,false,false) || distance_to_object(_target)>80 || distance_to_object(Player)>256) {
        var _follow=scrNTTEFullParrotCharmPlayer(ntte_charm.index)
        if(!instance_exists(_follow)) _follow=instance_nearest(x,y,Player)
        if(instance_exists(_follow) && distance_to_object(_follow)>32) motion_add(point_direction(x,y,_follow.x,_follow.y),timescale*timescale)
    }
}
function scrNTTEFullParrotCharmContact() {
    if(!instance_is(id,enemy) || !place_meeting(x,y,enemy)) return;
    var _self=id,_targets=[]
    with(enemy) if(id!=_self && team!=_self.team && place_meeting(x,y,_self)) array_push(_targets,id)
    for(var _i=0;_i<array_length(_targets);++_i) {
        var _victim=_targets[_i]
        if(!instance_exists(_victim)) continue
        var _freeze=UberCont.opt_freeze,_gamma=scr_skill_get(mut_gamma_guts),_hurt=scrNTTEFullValue(_victim,"nexthurt",0),_error=undefined
        UberCont.opt_freeze=0; scr_skill_set(mut_gamma_guts,false)
        if(alarm[11]>0 && alarm[11]<26) event_perform(ev_alarm,11)
        // Nested with provides the actual hostile enemy as collision 'other'.
        // Reuse the native collision itself, preserving its damage/sounds and
        // knockback, and restore the target's original invulnerability timer.
        try { with(_victim) with(_self) event_perform(ev_collision,Player) }
        catch(_caught) { _error=_caught }
        if(instance_exists(_victim)) _victim.nexthurt=_hurt
        UberCont.opt_freeze=_freeze; scr_skill_set(mut_gamma_guts,_gamma)
        if(!is_undefined(_error)) throw _error
    }
}
function scrNTTEFullParrotCharmSpecific() {
    var _target=ntte_charm.target
    if(instance_is(id,BigMaggot) && alarm[1]<0 && instance_exists(_target) && !collision_line(x,y,_target.x,_target.y,Wall,false,false)) alarm[1]=900
    if(instance_is(id,Shielder) || instance_is(id,EliteShielder)) {
        var _self=id
        with(PopoShield) if(creator==_self) team=_self.team
    }
    if(instance_is(id,LilHunterFly) && sprite_index==sprLilHunterLand && z< -160 && instance_exists(_target)) { x=_target.x; y=_target.y }
    // Epsilon's MeleeBandit/JungleAssassin/RhinoFreak/ExploFreak and Sniper
    // already move/aim at target rather than NTT's hardcoded nearest Player.
    // Undoing their movement here, as required by NTT, would break native AI.
    if(instance_is(id,HostileHorror) && ammo>0 && instance_exists(_target) && abs(gunoffset)>10) gunoffset=orandom(10)
}
function scrNTTEFullParrotCharmBeginStep() {
    // Native pause/freeze temporarily deactivates enemies. instance_exists
    // cannot distinguish those actors from destroyed ones; do not prune the
    // charm registry, run their alarms or consume lifetime while frozen.
    if(lockstep_stop || scrGameIsPaused() || instance_exists(PauseImage) || !instance_exists(GameCont)) return;
    if(!variable_instance_exists(GameCont,"ntte_charm_instance_list")) return;
    var _list=scrNTTEFullArrayCopy(GameCont.ntte_charm_instance_list)
    for(var _i=0;_i<array_length(_list);++_i) {
        var _inst=_list[_i]
        if(!instance_exists(_inst) || !_inst.ntte_charm.charmed || scrNTTEFullValue(_inst,"ntte_charm_override",false)) continue
        with(_inst) scrNTTEFullParrotCharmAggro()
        for(var _alarm=0;_alarm<=10;++_alarm) {
            if(!instance_exists(_inst)) break
            if(_inst.alarm[_alarm]>0 && _inst.alarm[_alarm]<=1) scrNTTEFullParrotCharmAlarm(_inst,_alarm)
        }
        if(instance_exists(_inst)) with(_inst) {
            scrNTTEFullParrotCharmFollow(); scrNTTEFullParrotCharmContact(); scrNTTEFullParrotCharmSpecific()
        }
    }
    scrNTTEFullParrotCharmTimers()
}
function scrNTTEFullParrotCharmAITests() {
    scrNTTEFullParrotShielderTargetTests()
    var _p=instance_find(Player,0),_before=scrNTTEFullInstances(all),_px=_p.x,_py=_p.y
    var _gator=instance_create(_p.x+48,_p.y,Gator),_target=instance_create(_p.x+96,_p.y,Bandit)
    var _vars=scrNTTEFullParrotCharm(_gator,true); _vars.index=_p.index
    _gator.alarm[2]=1; _gator.target=_target; _vars.target=_target
    scrNTTEFullParrotCharmAlarm(_gator,2)
    assert(_p.x==_px && _p.y==_py,"Parrot native alarm failed to restore the real Player position")
    assert(_gator.target==_target && _gator.team==team_player,"Parrot native Gator alarm lost its hostile target or source class")
    var _shots=[]
    with(projectile) if(creator==_gator && array_get_index(_before,id)<0) array_push(_shots,id)
    assert(array_length(_shots)==6,"Parrot native Gator attack did not fire its actual six shells")
    for(var _i=0;_i<array_length(_shots);++_i) assert(_shots[_i].team==team_player && _shots[_i].creator==_gator,"Parrot native attack created hostile or misowned shells")
    var _state=scrNTTEFullParrotCharmTargetBegin(_gator),_child=instance_create(_gator.x,_gator.y,Maggot)
    _child.creator=_gator; _vars.time=60; _vars.feather=true
    scrNTTEFullParrotCharmTargetEnd(_state); scrNTTEFullParrotCharmGrab(_state)
    assert(_child.team==team_player && _child.ntte_charm.charmed && _child.ntte_charm.index==_p.index && _child.ntte_charm.feather,
        "Parrot charmed offspring failed source team/index/feather inheritance")
    var _feathers=0
    with(NTTEFullParrotFeather) if(target==_child) _feathers+=1
    assert(_feathers==2 && _child.ntte_charm.time>0,"Parrot source inherited lifetime did not become two real feathers with one instant stick")
    var _attacker=instance_create(_p.x,_p.y,Maggot),_victim=instance_create(_p.x,_p.y,Bandit)
    scrNTTEFullParrotCharm(_attacker,true)
    _attacker.canmelee=true; _attacker.alarm[11]= -1; _attacker.meleedamage=1
    _victim.nexthurt=0; var _health=_victim.hp,_gamma=scr_skill_get(mut_gamma_guts),_freeze=UberCont.opt_freeze
    with(_attacker) scrNTTEFullParrotCharmContact()
    assert(_victim.hp==_health-1 && _victim.nexthurt==0 && !_attacker.canmelee && _attacker.alarm[11]==30,
        "Parrot real enemy contact did not preserve collision damage and source contact cooldown/invulnerability behavior")
    assert(scr_skill_get(mut_gamma_guts)==_gamma && UberCont.opt_freeze==_freeze,"Parrot contact leaked temporary Gamma Guts/freeze changes")
    var _all=scrNTTEFullInstances(all)
    for(var _i=0;_i<array_length(_all);++_i) if(array_get_index(_before,_all[_i])<0) instance_destroy(_all[_i],false)
    scrNTTESmokeLog("SYSTEMS PARROT AI: actual Gator six-shell alarm, real Player coordinate restoration and child team/index/feather lifetime inheritance OK")
    scrNTTEFullParrotScorpionContactTests()
}
function scrNTTEFullParrotScorpionContactTests() {
    var _p=instance_find(Player,0),_before=scrNTTEFullInstances(all),
        _players=scrNTTEFullAreaGeneratorSnapshot(Player),_game=scrNTTEFullAreaGeneratorSnapshot(GameCont),
        _rate=game_get_speed(gamespeed_fps),_types=[Scorpion,GoldScorpion,NTTESilverScorpion]
    try {
        GameCont.subarea=1;GameCont.loops=0
        _p.x=52000;_p.y=52000;_p.hp=1000;_p.max_hp=1000;_p.nexthurt=0;_p.race=Race.Fish
        for(var _case=0;_case<array_length(_types);++_case) {
            var _body=instance_create(_p.x,_p.y,_types[_case]),_bullet=noone,_flak=noone,_venom=noone,
                _future=noone,_far=noone,_foreign=noone,_rival=instance_create(_p.x+256,_p.y,Bandit)
            assert(instance_exists(_body) && _body.team==team_enemy && _body.meleedamage==5,
                "Scorpion contact regression did not retain the native source class/stats")
            _body.speed=4*timescale;_body.direction=0;_body.friction=0
            with(_body) {
                _bullet=scr_projectile_create(x,y,EnemyBullet2,0,0)
                _flak=scr_projectile_create(x,y,NTTEFullVenomFlak,0,0)
                _venom=scr_projectile_create(x,y,NTTEVenomPellet,0,0)
                _future=scr_projectile_create(x,y,EnemyBullet2,180,16)
                _far=scr_projectile_create(x+256,y,EnemyBullet2,0,0)
            }
            with(_rival) _foreign=scr_projectile_create(_body.x,_body.y,EnemyBullet2,0,0)
            _future.x=_body.bbox_right+16;_future.y=_body.y;_future.friction=0
            var _already_overlapping=false
            with(_future) _already_overlapping=place_meeting(x,y,_body)
            assert(!_already_overlapping,"Scorpion future-motion probe already overlapped before the source tick")
            var _motion_before=[_body.x,_body.y,_body.hspeed,_body.vspeed,_body.friction,
                _future.x,_future.y,_future.hspeed,_future.vspeed,_future.friction],
                _vars=scrNTTEFullParrotCharm(_body,true)
            _vars.index=_p.index
            assert(_body.ntte_charm.charmed && _body.ntte_charmed && _body.team==_p.team
                && _bullet.team==_p.team && _flak.team==_p.team && _venom.team==_p.team && _future.team==_p.team,
                "Scorpion charm left its own overlapping/next-source-tick native bullet or venom projectile hostile")
            assert(_far.team==team_enemy && _foreign.team==team_enemy,
                "Scorpion charm incorrectly converted distant or another creator's hostile shots")
            assert(json_stringify(_motion_before)==json_stringify([_body.x,_body.y,_body.hspeed,_body.vspeed,_body.friction,
                _future.x,_future.y,_future.hspeed,_future.vspeed,_future.friction]),
                "Charm nearby-projectile motion probe changed actual positions or velocity")
            var _hp=_p.hp,_cause=GameCont.deathcause
            _body.canmelee=true;_body.alarm[11]=-1;_p.nexthurt=0
            with(_p) with(_body) event_perform(ev_collision,Player)
            with(_p) with(_bullet) event_perform(ev_collision,hitme)
            with(_p) with(_flak) event_perform(ev_collision,hitme)
            with(_p) with(_venom) event_perform(ev_collision,hitme)
            assert(_p.hp==_hp && GameCont.deathcause==_cause && _body.canmelee,
                "Actual charmed Scorpion/body/native-bullet/venom collision hurt its same-team Player or consumed melee cooldown")
            _rival.x=_body.x;_rival.y=_body.y;_rival.hp=100;_rival.nexthurt=0
            with(_rival) with(_body) event_perform(ev_collision,Player)
            assert(_rival.hp==95 && !_body.canmelee && _body.alarm[11]==30,
                "Charmed Scorpion no longer deals its original five contact damage to a real hostile")
            scrNTTEFullParrotCharm(_body,false)
            assert(!_body.ntte_charm.charmed && !_body.ntte_charmed && _body.team==team_enemy
                && _bullet.team==team_enemy && _flak.team==team_enemy && _venom.team==team_enemy,
                "Scorpion uncharm did not restore source team for the body and still-overlapping owned projectiles")
            var _hp=_p.hp
            with(_p) with(_body) event_perform(ev_collision,Player)
            assert(_p.hp==_hp,"Scorpion uncharm lost its source contact-damage grace")
            with(_body) event_perform(ev_alarm,11)
            _p.nexthurt=0
            with(_p) with(_body) event_perform(ev_collision,Player)
            assert(_p.hp==_hp-5,"Hostile Scorpion did not regain original contact damage after its actual grace alarm")
            // Friendly visual overlays also include non-charmed allies. Their
            // real team, rather than eye color or an absent charm flag, gates damage.
            _body.team=team_player;_body.canmelee=true;_p.nexthurt=0;_hp=_p.hp
            with(_p) with(_body) event_perform(ev_collision,Player)
            assert(_p.hp==_hp,"Uncharmed but real same-team Scorpion ally damaged the Player")
            var _fixture=[_body,_bullet,_flak,_venom,_future,_far,_foreign,_rival]
            for(var _i=0;_i<array_length(_fixture);++_i) if(instance_exists(_fixture[_i])) instance_destroy(_fixture[_i],false)
        }
        assert(game_get_speed(gamespeed_fps)==_rate,"Scorpion charm regression changed actual engine rate")
        scrNTTESmokeLog("PARROT SCORPION CONTACT: three real native classes/body+bullet+venom same-team immunity,source-owned overlap+next-tick conversion only,uncharm team/grace/hostile5damage and uncharmed friendly team immunity OK @"+string(_rate))
    }
    finally {
        var _after=scrNTTEFullInstances(all)
        for(var _i=0;_i<array_length(_after);++_i)
            if(array_get_index(_before,_after[_i])<0 && instance_exists(_after[_i])) instance_destroy(_after[_i],false)
        scrNTTEFullAreaGeneratorRestore(_game);scrNTTEFullAreaGeneratorRestore(_players)
    }
}

function scrNTTEFullParrotShielderTargetTests() {
    var _fixture=scrNTTEFullVanillaFixtureBegin(),_players=scrNTTEFullAreaGeneratorSnapshot(Player),
        _stop=lockstep_stop,_rate=game_get_speed(gamespeed_fps),_types=[Shielder,EliteShielder];
    lockstep_stop=false;
    try {
        var _p=instance_find(Player,0);
        assert(instance_exists(_p),"Shielder target fixture needs the real Player");
        _p.x=54000;_p.y=54000;_p.xprevious=_p.x;_p.yprevious=_p.y;_p.speed=0;
        GameCont.ntte_charm_instance_list=[];GameCont.ntte_charm_instance_vars=[];
        for(var _type=0;_type<array_length(_types);++_type) {
            var _s=instance_create(_p.x+64,_p.y,_types[_type]),
                _b=instance_create(_p.x+128,_p.y,Bandit),_vars=scrNTTEFullParrotCharm(_s,true);
            _vars.index=_p.index;_vars.target=_b;
            assert(!variable_instance_exists(_b,"can_shoot"),"Bandit target fixture invented a Player shooting interface");
            for(var _mask=0;_mask<4;++_mask) {
                var _moving=(_mask&1)!=0,_hurt=(_mask&2)!=0,
                    _delta=_type==0?(_moving || _hurt):(_moving && _hurt);
                _b.speed=_moving?timescale:0;_s.hp=_s.max_hp-(_hurt?1:0);
                _s.walk=0;_s.speed=0;_s.freeze=20;
                with(_s) event_perform(ev_step,ev_step_normal);
                assert(_s.target==_b && _s.team==team_player && !variable_instance_exists(_b,"can_shoot"),
                    "Real charmed Shielder lost hostile target or mutated its interface");
                assert(abs(_s.freeze-(20+_delta*timescale))*1000000<=1,
                    "Shielder missing-interface/movement/health aggro: "+json_stringify([_type,_mask,_s.freeze]));
            }
            scrNTTEFullParrotCharm(_s,false);
            _p.speed=0;_s.hp=_s.max_hp;_s.walk=0;_s.speed=0;
            for(var _shoot=0;_shoot<2;++_shoot) {
                _p.can_shoot=_shoot!=0;_s.freeze=20;
                with(_s) event_perform(ev_step,ev_step_normal);
                var _delta=3*(_type==0?(_shoot==0):(_shoot==1));
                assert(_s.target==_p && abs(_s.freeze-(20+_delta*timescale))*1000000<=1,
                    "Shielder Player shooting-state polarity: "+json_stringify([_type,_shoot,_s.freeze]));
            }
            _s.target=noone;_s.freeze=20;
            with(_s) event_perform(ev_other,ev_user0);
            assert(_s.freeze==20,"Shielder used missing target while Player exists");
            _s.target=_b;instance_destroy(_b,false);
            with(_s) event_perform(ev_other,ev_user0);
            assert(_s.freeze==20,"Shielder used destroyed target while Player exists");
            _vars=scrNTTEFullParrotCharm(_s,true);_vars.index=_p.index;
            _s.freeze=20;
            with(_s) event_perform(ev_step,ev_step_normal);
            assert(!instance_exists(_s.target) && _s.freeze==20,"Charmed Shielder Step gained aggro without a hostile target");
            instance_destroy(_s,false);
        }
        assert(game_get_speed(gamespeed_fps)==_rate,"Shielder target regression altered engine rate");
        scrNTTESmokeLog("PARROT SHIELDER TARGET: two real inherited Steps, Bandit optional interface, source movement/health OR+AND, Player shooting polarity, absent/destroyed targets OK @"+string(_rate));
    } finally {
        scrNTTEFullAreaGeneratorRestore(_players);
        scrNTTEFullVanillaFixtureEnd(_fixture);lockstep_stop=_stop;
    }
}


// Frozen candidate56 charm alarm membership and restoration.
function scrNTTEFullParrotCharmLegacyTargetBeginTest(_inst) {
    var _state={players:[],before:scrNTTEFullParrotCharmLegacySetTest(),actor:_inst,
        creator:scrNTTEFullValue(_inst,"creator",noone),team:scrNTTEFullValue(_inst,"team",team_player),charm:_inst.ntte_charm,speed:_inst.speed}
    var _target=scrNTTEFullParrotCharmTarget(_inst)
    // NTT Grunt alarms reference Player-specific fields when no Player exists.
    if(!(instance_is(_inst,Grunt) && !instance_exists(Player)) && variable_instance_exists(_inst,"target")) _inst.target=_target
    if(variable_instance_exists(_inst,"target")) with(Player) {
        array_push(_state.players,[id,x,y])
        if(instance_exists(_target)) { x=_target.x; y=_target.y }
        else { var _dir=random(360); x+=lengthdir_x(10000,_dir); y+=lengthdir_y(10000,_dir) }
    }
    return _state
}

function scrNTTEFullParrotCharmLegacyGrabTest(_state) {
    var _new=scrNTTEFullInstances(all),_owner=_state.actor
    global.ntte_full_charm_alarm_birth_test.legacy_visits+=array_length(_new)
    if(!instance_exists(_owner) && instance_exists(_state.creator)) _owner=_state.creator
    for(var _i=0;_i<array_length(_new);++_i) {
        var _inst=_new[_i]
        if(variable_struct_exists(_state.before,string(_inst)) || !instance_exists(_inst)) continue
        var _creator=scrNTTEFullValue(_inst,"creator",noone)
        if(scrNTTEFullParrotCharmable(_inst)) {
            if(_creator==noone) { _creator=_owner; _inst.creator=_creator }
            if(_creator==_state.actor || _creator==_state.creator || _creator==_owner) scrNTTEFullParrotCharmInherit(_inst,_state.charm,_owner)
        }
        if(instance_is(_inst,projectile) || instance_is(_inst,LaserCannon)) {
            if(_creator==noone || _creator==_state.actor || (_creator==_state.creator && !instance_is(_state.actor,hitme))) {
                _inst.team=_state.team
                scrNTTEFullPetTwinsTeam(_inst,_state.team)
            }
        }
    }
}

function scrNTTEFullParrotCharmLegacyAlarmTest(_inst,_num) {
    var _state=scrNTTEFullParrotCharmLegacyTargetBeginTest(_inst),_error=undefined
    // No target is an intentional skipped attack for these two native alarms.
    if(_num!=2 || instance_exists(_inst.target) || (!instance_is(_inst,Gator) && !instance_is(_inst,JungleAssassin))) {
        try { with(_inst) { alarm[_num]=0; event_perform(ev_alarm,_num) } }
        catch(_caught) { _error=_caught }
    }
    scrNTTEFullParrotCharmTargetEnd(_state)
    if(!is_undefined(_error)) throw _error
    if(instance_exists(_inst)) {
        if(_inst.alarm[_num]>0) _inst.alarm[_num]+=1
        if(instance_is(_inst,enemy) && (_inst.canmelee || (_inst.alarm[11]>0 && _inst.alarm[11]<20)) && _inst.meleedamage>0) _inst.speed=max(_inst.speed,_state.speed)
    }
    scrNTTEFullParrotCharmLegacyGrabTest(_state)
}


function scrNTTEFullParrotCharmLegacySetTest() {
    var _set={},_visits=0
    with(all) {_set[$ string(id)]=true;_visits++}
    global.ntte_full_charm_alarm_birth_test.legacy_visits+=_visits
    return _set
}

function scrNTTEFullCharmAlarmBirthRowsTest(_capture,_actor,_other,_child=noone) {
    var _born=scrNTTEFullMergedCaptureEnd(_capture),_rows=[],_p=instance_find(Player,0);
    for(var _i=0;_i<array_length(_born);++_i) {
        var _inst=_born[_i],_creator=scrNTTEFullValue(_inst,"creator",noone),_target=scrNTTEFullValue(_inst,"target",noone),
            _charm=scrNTTEFullValue(_inst,"ntte_charm",undefined),_charmrow=undefined;
        if(is_struct(_charm)) _charmrow=[_charm.charmed,_charm.team,_charm.time,_charm.index,_charm.kill,_charm.feather,
            _charm.target==_actor,_charm.target==_other,_charm.target==_child];
        array_push(_rows,[_inst.object_index,_inst.x,_inst.y,_inst.xstart,_inst.ystart,_inst.speed,_inst.direction,
            _inst.image_index,_inst.image_speed,_inst.sprite_index,_inst.image_angle,_inst.image_xscale,_inst.image_yscale,
            scrNTTEFullValue(_inst,"team",undefined),_creator==_actor,_creator==_other,_creator==_p,_creator==noone,
            _target==_actor,_target==_other,_target==_child,scrNTTEFullValue(_inst,"damage",undefined),
            scrNTTEFullValue(_inst,"knockback_speed",undefined),scrNTTEFullValue(_inst,"hitid",undefined),_charmrow]);
    }
    return json_stringify(_rows);
}
function scrNTTEFullCharmAlarmBirthRegistryTest(_actor,_other,_child=noone) {
    var _rows=[];
    for(var _i=0;_i<array_length(GameCont.ntte_charm_instance_list);++_i) {
        var _inst=GameCont.ntte_charm_instance_list[_i],_vars=GameCont.ntte_charm_instance_vars[_i];
        array_push(_rows,[instance_exists(_inst)?_inst.object_index:-1,_inst==_actor,_inst==_other,_inst==_child,
            _vars.charmed,_vars.time,_vars.index,_vars.kill,_vars.feather]);
    }
    return json_stringify(_rows);
}
function scrNTTEFullCharmAlarmBirthCaptureNativeTests() {
    assert(os_type==os_windows && scrNTTEFullSmokeEnabled(),"Charm alarm birth regression needs explicit desktop smoke");
    var _before=scrNTTEFullInstances(all),_players=scrNTTEFullAreaGeneratorSnapshot(Player),
        _game=scrNTTEFullAreaGeneratorSnapshot(GameCont),_back=scrNTTEFullAreaGeneratorSnapshot(BackCont),
        _uber=scrNTTEFullAreaGeneratorSnapshot(UberCont),_seed=random_get_seed(),_streams=scrNTTEFullArrayCopy(global.rng_state),
        _source_rng=scrNTTEFullSourceSeedState(),_source_seed=_source_rng.random,_frame=current_frame,
        _test=variable_global_exists("ntte_full_charm_alarm_birth_test")?global.ntte_full_charm_alarm_birth_test:undefined,
        _p=instance_find(Player,0),_cases=0,_old_visits=0,_new_visits=0;
    try {
        _p.x=114000;_p.y=114000;_p.xprevious=_p.x;_p.yprevious=_p.y;_p.speed=0;
        _p.race=Race.Fish;GameCont.underwater=false;current_frame=2;
        for(var _density=0;_density<2;++_density) {
            var _dense=scrNTTEFullInstances(all);
            if(_density==1) repeat(2048) instance_create(116000,116000,NTTEFullMergedSetupProbe);
            // Six actual Gator shells, real Shielder no-creator bullet, actual
            // missile temporary deactivate/reactivate, and a real native failure alarm.
            var _types=[Gator,Shielder,BigDogMissile,Shielder];
            for(var _kind=0;_kind<4;++_kind) {
                var _results=[];
                for(var _legacy=1;_legacy>=0;--_legacy) {
                    var _local=scrNTTEFullInstances(all);
                    random_set_seed(573100+_kind);global.rng_state=scrNTTEFullArrayCopy(_streams);_source_rng.random=_source_seed;
                    GameCont.ntte_charm_instance_list=[];GameCont.ntte_charm_instance_vars=[];
                    global.ntte_full_charm_alarm_birth_test={legacy_visits:0};
                    var _actor=instance_create(114064,114000,_types[_kind]),_enemy=instance_create(114192,114000,Bandit),
                        _ally=instance_create(114096,114000,Bandit),_vars=scrNTTEFullParrotCharm(_actor,true);
                    _ally.team=team_player;_ally.creator=noone;
                    _vars.index=_p.index;_vars.time=60;_vars.feather=false;_vars.target=_enemy;
                    _actor.target=_enemy;_actor.alarm[2]=1;_actor.speed=0;
                    if(_kind==1 || _kind==3) _actor.ammo=2;
                    // Real Shielder source plays its shot and writes wkick,
                    // then uses gunangle arithmetic before creating the bullet.
                    // An invalid test-only angle forces that actual event error.
                    if(_kind==3) _actor.gunangle={force_native_error:true};
                    var _capture=scrNTTEFullMergedCaptureBegin(),_slot_start=instance_count,_px=_p.x,_py=_p.y,_error="";
                    try {
                        if(_legacy) scrNTTEFullParrotCharmLegacyAlarmTest(_actor,2);
                        else scrNTTEFullParrotCharmAlarm(_actor,2);
                    } catch(_caught) {
                        _error=is_struct(_caught) && variable_struct_exists(_caught,"message")?string(_caught.message):string(_caught);
                    }
                    var _visits=_legacy?global.ntte_full_charm_alarm_birth_test.legacy_visits:instance_count-_slot_start,
                        _born=scrNTTEFullMergedCaptureEnd(_capture),_shots=scrNTTEFullMergedRuntimeProjectiles(_born),
                        _expected=_kind==0?6:(_kind==1?1:0);
                    assert(_p.x==_px && _p.y==_py && array_length(_shots)==_expected,
                        "Actual charm alarm failed Player-coordinate restoration or native projectile quantity");
                    assert((_kind==3)==(_error!=""),
                        "Native Shielder exception was swallowed or a normal real alarm unexpectedly failed");
                    assert(_ally.creator==noone && _ally.team==team_player,
                        "Native reactivation made an old friendly actor look newly born");
                    if(_kind!=3) for(var _i=0;_i<array_length(_shots);++_i)
                        assert(_shots[_i].team==team_player && (_kind!=0 || _shots[_i].creator==_actor),
                            "Real charm alarm lost native ownership or left a newly fired shot hostile");
                    if(_kind==3) assert(_actor.wkick==5,
                        "Native failure probe did not reach the real Shielder event before its angle arithmetic");
                    array_push(_results,{rows:scrNTTEFullCharmAlarmBirthRowsTest(_capture,_actor,_enemy),
                        actor:json_stringify([_actor.alarm[1],_actor.alarm[2],_actor.alarm[11],_actor.speed,_actor.direction,
                            _actor.gunangle,_actor.wkick,_actor.target==_enemy]),
                        registry:scrNTTEFullCharmAlarmBirthRegistryTest(_actor,_enemy),error:_error!="",visits:_visits,
                        rng:random_get_seed(),streams:json_stringify(global.rng_state),source:_source_rng.random});
                    scrNTTEFullMergedRuntimeTestCleanup(_local);
                }
                assert(_results[0].rows==_results[1].rows && _results[0].actor==_results[1].actor
                    && _results[0].registry==_results[1].registry && _results[0].error==_results[1].error
                    && _results[0].rng==_results[1].rng && _results[0].streams==_results[1].streams && _results[0].source==_results[1].source,
                    "Birth discovery differs from literal old actual-alarm emission/order/ownership/alarms/registry/RNG");
                if(_density==1) assert(_results[0].visits>=(_kind==3?2048:4096) && _results[1].visits<32,
                    "Charmed native alarms still perform room-sized before/after discovery");
                _old_visits+=_results[0].visits;_new_visits+=_results[1].visits;_cases++;
                scrNTTESmokeLog("CHARM ALARM BIRTH ROW density="+string(_density)+" kind="+string(_kind)
                    +" visits="+string(_results[0].visits)+"->"+string(_results[1].visits));
            }
            scrNTTEFullMergedRuntimeTestCleanup(_dense);
        }
        // Outer native inheritance contains an inner real Gator alarm. Source
        // death uses the existing creator fallback; callbacks create genuine
        // inherited Maggot feathers only after the capture list is frozen.
        for(var _remove_source=0;_remove_source<2;++_remove_source) {
            var _results=[];
            for(var _legacy=1;_legacy>=0;--_legacy) {
                var _local=scrNTTEFullInstances(all);
                random_set_seed(573900+_remove_source);global.rng_state=scrNTTEFullArrayCopy(_streams);_source_rng.random=_source_seed;
                GameCont.ntte_charm_instance_list=[];GameCont.ntte_charm_instance_vars=[];
                global.ntte_full_charm_alarm_birth_test={legacy_visits:0};
                var _actor=instance_create(114064,114000,Gator),_inner=instance_create(114096,114000,Gator),
                    _enemy=instance_create(114256,114000,Bandit),_foreign=instance_create(114320,114000,Bandit),
                    _vars=scrNTTEFullParrotCharm(_actor,true),_ivars=scrNTTEFullParrotCharm(_inner,true);
                _actor.creator=_p;_vars.index=_p.index;_vars.target=_enemy;_vars.time=60;_vars.feather=true;
                _ivars.index=_p.index;_ivars.target=_enemy;_inner.target=_enemy;
                var _old=instance_create(114080,114000,EnemyBullet1);_old.creator=_actor;_old.team=team_enemy;
                var _capture=scrNTTEFullMergedCaptureBegin(),_px=_p.x,_py=_p.y,
                    _outer=_legacy?scrNTTEFullParrotCharmLegacyTargetBeginTest(_actor):scrNTTEFullParrotCharmTargetBegin(_actor);
                if(_legacy) scrNTTEFullParrotCharmLegacyAlarmTest(_inner,2);
                else scrNTTEFullParrotCharmAlarm(_inner,2);
                var _child=instance_create(114080,114000,Maggot),_otherchild=instance_create(114080,114000,Maggot),
                    _unowned=instance_create(114080,114000,EnemyBullet1),_foreignshot=instance_create(114080,114000,EnemyBullet1),
                    _gone=instance_create(114080,114000,Maggot);
                _child.creator=_actor;_otherchild.creator=_foreign;_unowned.creator=noone;_foreignshot.creator=_foreign;
                _unowned.team=team_enemy;_foreignshot.team=team_enemy;instance_destroy(_gone,false);
                if(_remove_source) instance_destroy(_actor,false);
                scrNTTEFullParrotCharmTargetEnd(_outer);
                if(_legacy) scrNTTEFullParrotCharmLegacyGrabTest(_outer);else scrNTTEFullParrotCharmGrab(_outer);
                assert(_p.x==_px && _p.y==_py && _old.team==team_enemy && _old.creator==_actor,
                    "Nested charm alarm leaked player relocation or inherited into an existing projectile");
                assert(_child.ntte_charm.charmed && _child.team==team_player && _child.ntte_charm.feather
                    && _child.ntte_charm.index==_p.index && _child.ntte_charm.time>0
                    && !scrNTTEFullValue(_otherchild,"ntte_charmed",false)
                    && _unowned.team==team_player && _foreignshot.team==team_enemy,
                    "Birth index changed source/foreign creator filters, dead-source fallback or actual child charm inheritance");
                var _feathers=0;with(NTTEFullParrotFeather) if(target==_child) _feathers++;
                assert(_feathers==2,"Inherited source lifetime did not create its exact two real feathers");
                array_push(_results,{rows:scrNTTEFullCharmAlarmBirthRowsTest(_capture,_actor,_foreign,_child),
                    registry:scrNTTEFullCharmAlarmBirthRegistryTest(_actor,_inner,_child),
                    rng:random_get_seed(),streams:json_stringify(global.rng_state),source:_source_rng.random});
                scrNTTEFullMergedRuntimeTestCleanup(_local);
            }
            assert(_results[0].rows==_results[1].rows && _results[0].registry==_results[1].registry
                && _results[0].rng==_results[1].rng && _results[0].streams==_results[1].streams && _results[0].source==_results[1].source,
                "Nested/dead-source charm birth order, feather quantities/geometry, registration or RNG differs from old oracle");_cases++;
        }
    } finally {
        scrNTTEFullMergedRuntimeTestCleanup(_before);scrNTTEFullAreaGeneratorRestore(_players);
        scrNTTEFullAreaGeneratorRestore(_game);scrNTTEFullAreaGeneratorRestore(_back);scrNTTEFullAreaGeneratorRestore(_uber);
        random_set_seed(_seed);global.rng_state=_streams;_source_rng.random=_source_seed;current_frame=_frame;
        global.ntte_full_charm_alarm_birth_test=_test;
    }
    scrNTTESmokeLog("CHARM ALARM BIRTH CAPTURE PASS exact actual Gator/Shielder/missile-reactivation/native-error,nested child+two-feathers,dead-source/foreign filters,ordered registry/RNG cases="
        +string(_cases)+" visits="+string(_old_visits)+"->"+string(_new_visits)+" @"+string(30/timescale));
}

// Native integration: lethal Entangler Wolf revival, the actual inherited
// three-shot Alarm2, and genuine projectile collision dispatch. This targets
// the repeated friendly-shot clone transaction rather than capping attacks.
function scrNTTEFullEntanglerFriendlyShotRowTest(_shot) {
    return json_stringify([_shot.x,_shot.y,_shot.direction,_shot.speed,_shot.sprite_index,_shot.mask_index,
        _shot.image_index,_shot.image_speed,_shot.image_angle,_shot.image_xscale,_shot.image_yscale,
        _shot.team,scrNTTEFullValue(_shot,"creator",noone),scrNTTEFullValue(_shot,"deflected",false),
        scrNTTEFullValue(_shot,"damage",undefined),scrNTTEFullValue(_shot,"hitid",undefined)])
}
function scrNTTEFullEntanglerFriendlyEmissionNativeTests() {
    var _fixture=scrNTTEFullVanillaFixtureBegin(),_players=scrNTTEFullAreaGeneratorSnapshot(Player),
        _back=scrNTTEFullAreaGeneratorSnapshot(BackCont),_uber=scrNTTEFullAreaGeneratorSnapshot(UberCont),
        _p=instance_find(Player,0),_stop=lockstep_stop,_frame=current_frame,
        _streams=scrNTTEFullArrayCopy(global.rng_state),_source=scrNTTEFullSourceSeedState(),_source_seed=_source.random,
        _collisions=0,_gate_cases=0
    lockstep_stop=false
    try {
        _p.x=174000;_p.y=174000;_p.xprevious=_p.x;_p.yprevious=_p.y;_p.speed=0;_p.race=Race.Fish
        GameCont.ntte_charm_instance_list=[];GameCont.ntte_charm_instance_vars=[];GameCont.underwater=false
        var _victim=instance_create(_p.x+64,_p.y,Wolf),_rival=instance_create(_p.x+256,_p.y,Bandit),_slash=noone
        _victim.hp=16;_victim.nexthurt=-1;_rival.hp=1000
        with(_p) _slash=scr_damage_create(_victim.x,_victim.y,NTTEFullEntanglerSlash)
        _slash.clone=true;_slash.damage=200;_slash.direction=45;_slash.candeflect=true
        with(_victim) with(_slash) event_perform(ev_collision,hitme)
        var _controller=noone
        with(NTTEFullCrystalClone) if(instance_is(target,Wolf) && target!=_victim && appear_health==16) {_controller=id;break;}
        assert(instance_exists(_controller) && _controller.target.hp==16 && _controller.target.ntte_charm.charmed,
            "Entangler friendly-emission fixture missed genuine lethal native Wolf clone")
        var _wolf=_controller.target,_vars=_wolf.ntte_charm
        _wolf.direction=0;_wolf.alarm[2]=1;_wolf.target=_rival;_vars.target=_rival;_vars.index=_p.index
        var _capture=scrNTTEFullMergedCaptureBegin()
        scrNTTEFullParrotCharmAlarm(_wolf,2)
        var _born=scrNTTEFullMergedCaptureEnd(_capture),_shots=scrNTTEFullMergedRuntimeProjectiles(_born)
        assert(array_length(_shots)==3,"Genuine revived Wolf Alarm2 changed source three-bullet quantity")
        for(var _i=0;_i<array_length(_shots);++_i) {
            var _shot=_shots[_i]
            scrNTTESmokeLog("ENTANGLER NATIVE WOLF SHOT "+json_stringify({type:object_get_name(_shot.object_index),
                creator:string(scrNTTEFullValue(_shot,"creator",noone)),monster:scrNTTEFullValue(_shot,"ntte_monster_projectile",false),team:_shot.team}))
            // Original owned-shot team conversion changes the raw native
            // EnemyBullet1 to AllyBullet without replaying its constructor.
            assert(_shot.object_index==AllyBullet && _shot.team==_p.team && _shot.ntte_monster_projectile
                && scrNTTEFullValue(_shot,"creator",noone)==noone,
                "Native raw Wolf shot lost persistent monster identity or changed original unowned creator")
        }
        // Repeated overlaps were the amplification route. The same actual
        // bullets must survive both Entangler and ordinary RedSlash unchanged.
        var _plain=instance_create(_slash.x,_slash.y,NTTEFullRedSlash)
        _plain.creator=_p;_plain.team=_p.team;_plain.direction=135
        for(var _orphan=0;_orphan<2;++_orphan) {
            if(_orphan) instance_destroy(_wolf,false)
            var _count=instance_number(all),_controllers=instance_number(NTTEFullCrystalClone),
                _bullets=instance_number(AllyBullet),_fx=instance_number(BulletHit),_deflect=instance_number(Deflect),
                _seed=random_get_seed(),_rng=json_stringify(global.rng_state),_srng=_source.random
            for(var _i=0;_i<array_length(_shots);++_i) {
                var _shot=_shots[_i],_row=scrNTTEFullEntanglerFriendlyShotRowTest(_shot)
                assert(scrNTTEFullFriendlyMonsterShot(_slash,_shot),"Revived Wolf shot missed live/orphan friendly-melee guard")
                repeat(8) {
                    with(_shot) with(_slash) event_perform(ev_collision,projectile)
                    with(_shot) with(_plain) event_perform(ev_collision,projectile)
                    _collisions+=2
                }
                assert(instance_exists(_shot) && scrNTTEFullEntanglerFriendlyShotRowTest(_shot)==_row,
                    "Player Entangler/RedSlash mutated a friendly raw native shot")
            }
            assert(instance_number(all)==_count && instance_number(NTTEFullCrystalClone)==_controllers
                && instance_number(AllyBullet)==_bullets && instance_number(BulletHit)==_fx
                && instance_number(Deflect)==_deflect && random_get_seed()==_seed
                && json_stringify(global.rng_state)==_rng && _source.random==_srng,
                "Friendly overlap amplified clone/projectile/FX instances or consumed gameplay RNG")
        }
        // Hostile source still gets the original one copy + two real wrappers.
        var _hostile=noone
        with(_rival) _hostile=scr_projectile_create(_slash.x,_slash.y,EnemyBullet1,180,4)
        var _controllers=instance_number(NTTEFullCrystalClone),_bullets=instance_number(EnemyBullet1)
        with(_hostile) with(_slash) event_perform(ev_collision,projectile)
        assert(instance_exists(_hostile) && _hostile.team==_p.team && _hostile.deflected
            && _hostile.direction==_slash.direction && instance_number(NTTEFullCrystalClone)==_controllers+2
            && instance_number(EnemyBullet1)==_bullets+1,
            "Entangler hostile native shot lost source deflection, one-copy or paired-wrapper quantity")
        var _own=noone
        with(_p) _own=scr_projectile_create(_slash.x,_slash.y,Grenade,180,2)
        assert(!scrNTTEFullFriendlyMonsterShot(_slash,_own),"Monster origin protection captured the Player's own grenade")
        // The original Increased Aggro gate/formula remains. Test native enemy
        // state with and without a real owned projectile at both render phases.
        var _actor=instance_create(_p.x+512,_p.y,Bandit),_blocker=instance_create(_p.x+768,_p.y,EnemyBullet1)
        _actor.intro=true;_actor.ammo=0;_actor.alarm[2]=-1;_actor.sprite_index=_actor.spr_idle
        for(var _size=1;_size<=4;++_size) for(var _phase=0;_phase<2;++_phase) for(var _blocked=0;_blocked<2;++_blocked) {
            _actor.size=_size;_actor.alarm[1]=40;current_frame=2+_phase*0.5
            _blocker.creator=_blocked?_actor:_rival
            var _seed=random_get_seed(),_rng=json_stringify(global.rng_state),_srng=_source.random,
                _expected=(!_blocked && current_frame%1<timescale)?max(1,40-ceil(10/max(1,_size)-1)):40
            with(_actor) scrNTTEFullParrotCharmAggro()
            assert(_actor.alarm[1]==_expected && random_get_seed()==_seed
                && json_stringify(global.rng_state)==_rng && _source.random==_srng,
                "Charm aggro pure-cost optimization changed original logical tick/formula/blocker/RNG")
            _gate_cases++
        }
        scrNTTESmokeLog("ENTANGLER FRIENDLY EMISSION PASS actual lethal Wolf/native three-shot Alarm2, "+string(_collisions)
            +" repeated live/orphan Entangler+RedSlash collisions without clone/FX amplification, hostile one-copy/two-wrapper and own-grenade controls; aggro cases="+string(_gate_cases)+" @"+string(30/timescale))
    }
    finally {
        scrNTTEFullVanillaFixtureEnd(_fixture);scrNTTEFullAreaGeneratorRestore(_players)
        scrNTTEFullAreaGeneratorRestore(_back);scrNTTEFullAreaGeneratorRestore(_uber)
        global.rng_state=_streams;_source.random=_source_seed;current_frame=_frame;lockstep_stop=_stop
    }
}

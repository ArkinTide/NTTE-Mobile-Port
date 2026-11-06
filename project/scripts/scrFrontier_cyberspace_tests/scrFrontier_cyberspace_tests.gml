// Core state/negative controls complement Event's real fatal damage ->
// PlayerManager -> bluescreen -> Yes -> native Cyberspace route check.
function scrFRCyberspaceReviveTests() {
    // Native registration compacts playerinstance_list. Its next contiguous
    // slot must be used; reserving slot 3 leaves a hole and moves the struct
    // away from the index consumed by the real native race-change helper.
    var _index=player_count;
    assert(_index<INPUT_MAX_PLAYERS,"Cyberspace revival Core fixture needs a free native player slot");
    var _old_slot=scr_playerinstance_find(_index),
        _before=scrNTTEFullInstances(all),_old_deaths=scrNTTEFullValue(GameCont,"fr_cyberspace_deaths",undefined),
        _old_visited=GameCont.fr_visitedCyberspace,
        _old_enabled=scrFRModGet("area","cyberspace","settingCyberspaceEnabled"),
        _old_speed=GameCont.wib_speedBonus[_index],_old_reload=GameCont.wib_reloadBonus[_index],
        _old_accuracy=GameCont.wib_accuracyBonus[_index],
        _effects=scrFRModGet("mod","Frontier_StatusEffects","statusEffects"),_old_targets=[],
        _seed=scrFRSourceRandomGetSeed(),_scale=scrFRSourceScale(),
        _dead=noone,_body=noone,_new=noone,_manager=noone;
    assert(!is_struct(_old_slot),"Cyberspace revival Core fixture needs an unused native player slot");
    assert(!instance_exists(SpiralCont) && _scale>0,"Cyberspace status acceptance needs ordinary source ticks");
    for(var _i=0;_i<array_length(_effects);++_i) {
        array_push(_old_targets,_effects[_i].targets);_effects[_i].targets=[];
    }
    try {
        var _slot=new PlayerInstance(_index);scr_playerinstance_add(_index,_slot);
        scrFRModSet("area","cyberspace","settingCyberspaceEnabled",true);GameCont.fr_visitedCyberspace=false;
        GameCont.wib_speedBonus[_index]=.75;GameCont.wib_reloadBonus[_index]=.2;GameCont.wib_accuracyBonus[_index]=.1;
        _dead=scrPlayerCreate(_index,Race.Robot,1);
        assert(scr_playerinstance_find(_index)==_slot && _slot.race==Race.Robot && _slot.skin==1,
            "Native Robot fixture registration or race-change failed before real death");
        _dead.max_hp=17;_dead.hp=17;_dead.maxspeed=6.25*timescale;
        _dead.accuracy=1.4;_dead.reloadspeed=1.7;_dead.footextra=3;
        _dead.ammo[Ammo.Bullets]=21;
        _dead.fr_ammo_max_delta=[0,11,0,0,0,0];_dead.fr_ammo_gain_delta=[0,4,0,0,0,0];
        _dead.wep=wep_wrench;
        var _buffs=["buffSpeedUp","buffFirerateUp","buffHealthUp","buffAmmoGain"];
        for(var _i=0;_i<array_length(_buffs);++_i)
            scrFRModCallArray("mod","Frontier_StatusEffects","status_apply_set",
                [_dead,scrFRModGet("mod","Frontier_StatusEffects",_buffs[_i]),(_i==0?2:4)+_scale]);
        scrFRModCall("mod","Frontier_StatusEffects","step");
        var _status_diag=[];
        for(var _i=0;_i<array_length(_buffs);++_i) {
            var _effect=scrFRModGet("mod","Frontier_StatusEffects",_buffs[_i]);
            array_push(_status_diag,{key:_effect.key,time:scrNTTEFullValue(_dead,_effect.key,-999),
                targets:array_length(_effect.targets),registered:array_contains(_effect.targets,_dead)});
        }
        scrNTTESmokeLog("FRONTIER CYBERSPACE source status after 4 apply_set calls and 1 real step "+json_stringify({
            source_scale:_scale,native_scale:timescale,max_hp:_dead.max_hp,hp:_dead.hp,
            maxspeed:_dead.maxspeed,reload:_dead.reloadspeed,ammo_gain:_dead.fr_ammo_gain_delta,
            speed_flag:scrNTTEFullValue(_dead,"fr_buffSpeedUp_check",undefined),
            reload_flag:scrNTTEFullValue(_dead,"fr_buffFirerateUp_check",undefined),
            health_flag:scrNTTEFullValue(_dead,"fr_buffHealthUp_hp",undefined),
            ammo_flag:scrNTTEFullValue(_dead,"fr_buffAmmoGain_ammo",undefined),statuses:_status_diag}));
        // Scale before comparing: GML's 1e-5 comparison epsilon would
        // otherwise reject an exact zero difference against that threshold.
        assert(_dead.max_hp==19 && abs(_dead.maxspeed-7*timescale)*100000<1
            && abs(_dead.reloadspeed-1.95)*100000<1 && _dead.fr_ammo_gain_delta[Ammo.Bullets]==12
            && _dead.fr_buffSpeedUp_check && _dead.fr_buffHealthUp_hp,
            "Real authored status application did not change the dying Robot's actual totals");
        _dead.hp=0;
        // Invoke the real native Destroy event. Its new production capture
        // runs before the existing physical weapon-drop consumer.
        instance_destroy(_dead);
        assert(!instance_exists(scrFRPlayerFind(_index))
            && is_struct(GameCont.fr_cyberspace_deaths[_index]),
            "Native Robot Destroy did not capture its source revival state");
        var _drops=scrNTTEFullInstances(WepPickup),_wrenches=0;
        for(var _i=0;_i<array_length(_drops);++_i) if(_drops[_i].wep==wep_wrench) _wrenches++;
        assert(_wrenches>0,"Native Robot death lost its actual weapon pickup");
        _manager=scrFRModCallArray("mod","wibbly","PlayerManager_create",[10016,10016]);
        _body=instance_create(58000,58016,Revive);_body.index=_index;
        var _rejected=false;
        try {with(_body) scrFRCyberspaceReviveEvent(ev_alarm,0);}
        catch(_error) {_rejected=string(_error)=="Cyberspace source Alarm0 preceded its synthetic collision";}
        assert(_rejected && !instance_exists(scrFRPlayerFind(_index)),
            "Unarmed source Revive restored a player before its collision event");
        with(_body) scrFRCyberspaceReviveEvent(ev_collision,Player);
        assert(!instance_exists(scrFRPlayerFind(_index)),"Source collision bypassed its following Alarm0");
        with(_body) _new=scrFRCyberspaceReviveEvent(ev_alarm,0);
        assert(instance_exists(_new) && _new.index==_index && _new.race==Race.Robot && _new.bskin==1
            && _slot.race==Race.Robot && _slot.skin==1 && _new.x==58000 && _new.y==58016,
            "Source Alarm0 lost native player slot, race, skin or authored carrier position");
        assert(_new.hp==19 && _new.max_hp==19 && _new.ammo[Ammo.Bullets]==21
            && _new.wep==wep_none && _new.bwep==wep_none,
            "Source revival restored fatal HP, reset durable health/ammo or duplicated dropped weapons");
        for(var _i=0;_i<array_length(_buffs);++_i) {
            var _effect=scrFRModGet("mod","Frontier_StatusEffects",_buffs[_i]);
            assert(array_length(_effect.targets)==1 && _effect.targets[0]==_new,
                "Source revival did not transfer the actual timed-status registry target exactly once");
        }
        assert(_new.fr_buffSpeedUp_time==2 && _new.fr_buffSpeedUp_check
            && _new.fr_buffFirerateUp_time==4 && _new.fr_buffFirerateUp_check,
            "Source revival lost original timed-status clocks or applied flags");
        // Speed expires before Wibbly discovers the revived Player. Its
        // reconciliation must retain that cleanup instead of replaying the
        // stale death-time speed, while the other three statuses remain live.
        repeat(ceil(1/_scale)) scrFRModCall("mod","Frontier_StatusEffects","step");
        assert(!_new.fr_buffSpeedUp_check && abs(_new.maxspeed-6.25*timescale)*100000<1,
            "Transferred real status did not run its authored expiry cleanup");
        with(_manager) scrFRModCallArray("mod","wibbly","PlayerManager_step",[]);
        assert(abs(_new.maxspeed-6.25*timescale)*100000<1 && abs(_new.accuracy-1.4)*100000<1
            && abs(_new.reloadspeed-1.95)*100000<1 && _new.max_hp==19 && _new.footextra==3
            && _new.fr_ammo_max_delta[Ammo.Bullets]==11 && _new.fr_ammo_gain_delta[Ammo.Bullets]==12
            && is_undefined(_new.fr_cyberspace_restored),
            "Original Wibbly respawn reapplied bonuses twice or reset captured native/source stats");
        with(_manager) scrFRModCallArray("mod","wibbly","PlayerManager_step",[]);
        assert(abs(_new.maxspeed-6.25*timescale)*100000<1 && abs(_new.reloadspeed-1.95)*100000<1,
            "Later ordinary Wibbly ticks applied the one-time revival restoration again");
        repeat(ceil(4/_scale)+2) scrFRModCall("mod","Frontier_StatusEffects","step");
        assert(_new.max_hp==17 && _new.hp==17 && abs(_new.reloadspeed-1.7)*100000<1
            && abs(_new.maxspeed-6.25*timescale)*100000<1 && _new.fr_ammo_gain_delta[Ammo.Bullets]==4
            && !_new.fr_buffHealthUp_hp && !_new.fr_buffFirerateUp_check && !_new.fr_buffAmmoGain_ammo,
            "Source revival made timed health/reload/speed/ammo effects permanent after real source expiry");
        with(_body) assert(scrFRCyberspaceReviveEvent(ev_alarm,0)==_new,
            "Repeated source Alarm0 created a duplicate Player");
        assert(is_undefined(GameCont.fr_cyberspace_deaths[_index]),"Source revival reused its consumed dead-player snapshot");
        _rejected=false;
        try {with(_body) scrFRCyberspaceReviveEvent(ev_alarm,4);}
        catch(_error) {_rejected=string(_error)=="Unsupported Cyberspace source revival event";}
        assert(_rejected,"Cyberspace adapter accepted an ordinary native co-op damage alarm");
        scrNTTESmokeLog("PASS FRONTIER native Robot Destroy/source Revive preserves slot, skin, full health, mutation/ammo totals and real status registry; expiry before/after Wibbly, dropped weapons and negative controls");
    } finally {
        scrNTTEFullMergedRuntimeTestCleanup(_before);
        global.playerinstance_list[_index]=_old_slot;scr_playerinstances_recollect();
        GameCont.fr_cyberspace_deaths=_old_deaths;GameCont.fr_visitedCyberspace=_old_visited;
        scrFRModSet("area","cyberspace","settingCyberspaceEnabled",_old_enabled);
        GameCont.wib_speedBonus[_index]=_old_speed;GameCont.wib_reloadBonus[_index]=_old_reload;
        GameCont.wib_accuracyBonus[_index]=_old_accuracy;
        for(var _i=0;_i<array_length(_effects);++_i) _effects[_i].targets=_old_targets[_i];
        scrFRSourceRandomSetSeed(_seed);
    }
}

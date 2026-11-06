// NTT's Revive has a scripted collision/Alarm0 revival API. Epsilon's
// ordinary Revive is a delayed co-op body and has no Alarm0. Only the two
// calls compiled from cyberspace_revive use this adapter.
function scrFRCyberspaceRememberStatuses(_player) {
    var _effects=scrFRModGet("mod","Frontier_StatusEffects","statusEffects"),
        _names=variable_instance_get_names(_player),_saved=[];
    for(var _i=0;_i<array_length(_effects);++_i) {
        var _effect=_effects[_i],_key=_effect.key;
        if(!array_contains(_effect.targets,_player)
            || scrNTTEFullValue(_player,_key,0)<=0) continue;
        var _prefix=string_delete(_key,string_length(_key)-4,5)+"_",_fields={};
        for(var _j=0;_j<array_length(_names);++_j) {
            var _name=_names[_j];
            if(string_pos(_prefix,_name)!=1
                && !(_key=="fr_buffBonusHeal_time" && _name=="fr_BonusHealStatusPrevHealth")
                && !(_key=="fr_debuffPlague_time" && _name=="fr_plagueLevel")) continue;
            var _value=variable_instance_get(_player,_name);
            _fields[$ _name]=is_array(_value)?scrFRArrayClone(_value):_value;
        }
        array_push(_saved,{key:_key,fields:_fields});
    }
    return _saved;
}

function scrFRCyberspaceRestoreStatuses(_player,_snapshot) {
    var _effects=scrFRModGet("mod","Frontier_StatusEffects","statusEffects"),_saved=_snapshot.statuses;
    for(var _i=0;_i<array_length(_saved);++_i) {
        var _entry=_saved[_i],_names=variable_struct_get_names(_entry.fields);
        for(var _j=0;_j<array_length(_names);++_j) {
            var _name=_names[_j],_value=_entry.fields[$ _name];
            if(string_pos("_prevhealth",_name)>0 || _name=="fr_BonusHealStatusPrevHealth")
                _value=_player.hp;
            variable_instance_set(_player,_name,is_array(_value)?scrFRArrayClone(_value):_value);
        }
        for(var _j=0;_j<array_length(_effects);++_j) if(_effects[_j].key==_entry.key) {
            var _effect=_effects[_j],_targets=[];
            for(var _k=0;_k<array_length(_effect.targets);++_k)
                if(_effect.targets[_k]!=_snapshot.source && _effect.targets[_k]!=_player)
                    array_push(_targets,_effect.targets[_k]);
            array_push(_targets,_player);_effect.targets=_targets;
            break;
        }
    }
}

function scrFRCyberspaceRememberPlayer(_player) {
    if(!scrFREnabled() || !instance_exists(GameCont) || !instance_exists(_player)
        || _player.race!=Race.Robot || GameCont.win
        || !scrFRModGet("area","cyberspace","settingCyberspaceEnabled")
        || scrNTTEFullValue(GameCont,"fr_visitedCyberspace",false)) return;
    var _fields=["max_hp","maxspeed","accuracy","footextra","veinsthreshold","cantoxic",
        "reloadspeed","ammo","ntte_red_ammo","ntte_bones","fr_ammo_max_delta","fr_ammo_gain_delta"],
        _values={};
    for(var _i=0;_i<array_length(_fields);++_i) {
        var _field=_fields[_i];
        if(variable_instance_exists(_player,_field)) {
            var _value=variable_instance_get(_player,_field);
            _values[$ _field]=is_array(_value)?scrFRArrayClone(_value):_value;
        }
    }
    // Physics is stored in source tick units so an options rate change at
    // the admission screen cannot replay a stale native frame scale.
    _values.maxspeed/=timescale;
    var _snapshots=scrNTTEFullValue(GameCont,"fr_cyberspace_deaths",undefined);
    if(!is_array(_snapshots)) _snapshots=array_create(INPUT_MAX_PLAYERS,undefined);
    _snapshots[_player.index]={game:GameCont.id,source:_player.id,race:_player.race,
        skin:_player.bskin,fields:_values,statuses:scrFRCyberspaceRememberStatuses(_player)};
    GameCont.fr_cyberspace_deaths=_snapshots;
}

function scrFRCyberspaceRestoreFields(_player,_snapshot) {
    var _fields=_snapshot.fields,_names=variable_struct_get_names(_fields);
    for(var _i=0;_i<array_length(_names);++_i) {
        var _name=_names[_i],_value=_fields[$ _name];
        if(_name=="maxspeed") _value*=timescale;
        else if(is_array(_value)) _value=scrFRArrayClone(_value);
        variable_instance_set(_player,_name,_value);
    }
    // The authored respawnProtector sets my_health=maxhealth every tick
    // during admission. Restore full maximum health, never the fatal HP.
    _player.hp=max(1,_player.max_hp);_player.lsthealth=_player.hp;
}

function scrFRCyberspaceReviveEvent(_event,_number) {
    assert(instance_is(id,Revive),"Cyberspace source revival requires its native Revive carrier");
    if(_event==ev_collision && _number==Player) {
        fr_cyberspace_revive_armed=true;return;
    }
    if(_event!=ev_alarm || _number!=0) throw "Unsupported Cyberspace source revival event";
    if(!(self[$ "fr_cyberspace_revive_armed"]??false)) throw "Cyberspace source Alarm0 preceded its synthetic collision";
    var _existing=scrFRPlayerFind(index);
    if(instance_exists(_existing)) {
        assert((self[$ "fr_cyberspace_revived_player"]??noone)==_existing,
            "Cyberspace source revival would replace a living player");
        return _existing;
    }
    var _slot=scr_playerinstance_find(index),
        _snapshots=scrNTTEFullValue(GameCont,"fr_cyberspace_deaths",undefined),
        _snapshot=is_array(_snapshots)?_snapshots[index]:undefined;
    assert(is_struct(_slot) && is_struct(_snapshot) && _snapshot.game==GameCont.id
        && _snapshot.race==Race.Robot && _slot.race==_snapshot.race,
        "Cyberspace source revival has no matching dead Robot state");
    var _player=scrPlayerCreate(index,_snapshot.race,_snapshot.skin);
    scrFRCyberspaceRestoreFields(_player,_snapshot);
    scrFRCyberspaceRestoreStatuses(_player,_snapshot);
    _player.x=x;_player.y=y;_player.xprevious=x;_player.yprevious=y;
    _player.fr_cyberspace_restored=_snapshot;
    // Source death already dropped both weapons as real pickups; its Yes
    // action carries those pickups into Cyberspace. Do not duplicate them.
    _player.wep=wep_none;_player.bwep=wep_none;
    _player.ntte_state=undefined;_player.bntte_state=undefined;
    _snapshots[index]=undefined;GameCont.fr_cyberspace_deaths=_snapshots;
    fr_cyberspace_revived_player=_player;
    return _player;
}

function scrFRCyberspaceRespawnBegin(_player) {
    var _snapshot=scrNTTEFullValue(_player,"fr_cyberspace_restored",undefined);
    if(!is_struct(_snapshot)) return;
    // A source status can expire between native revival and Wibbly noticing
    // it. Preserve the values at the start of this actual branch, rather
    // than replaying death-time totals after their cleanup has run.
    var _fields=["maxspeed","reloadspeed","accuracy","fr_ammo_max_delta","fr_ammo_gain_delta"],_values={};
    for(var _i=0;_i<array_length(_fields);++_i) if(variable_instance_exists(_player,_fields[_i])) {
        var _value=variable_instance_get(_player,_fields[_i]);
        _values[$ _fields[_i]]=is_array(_value)?scrFRArrayClone(_value):_value;
    }
    _snapshot.respawn_totals=_values;
}

function scrFRCyberspaceRespawnReady(_player) {
    var _snapshot=scrNTTEFullValue(_player,"fr_cyberspace_restored",undefined);
    if(!is_struct(_snapshot)) return;
    var _values=_snapshot[$ "respawn_totals"];
    assert(is_struct(_values),"Cyberspace Wibbly respawn lost its actual branch-entry totals");
    var _names=variable_struct_get_names(_values);
    for(var _i=0;_i<array_length(_names);++_i)
        variable_instance_set(_player,_names[_i],_values[$ _names[_i]]);
    _player.fr_cyberspace_restored=undefined;
}

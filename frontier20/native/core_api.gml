// Content-independent NTT adapters, adapted from the maintained native mobile bridge.
function scrFRScriptRef(_code) {
    // Capture code, not a creation-time instance. Callback self is the object
    // receiving the event; a creator can disappear before a callback runs.
    return is_method(_code) ? method_get_index(_code) : _code;
}


function scrFROther(_scope) {
    // Calling a resumable function as a struct member changes GML's physical
    // other to its task. Expose the source's logical other to nested calls.
    if(is_struct(_scope) && variable_struct_exists(_scope,"other_scope")) return scrFROther(_scope.other_scope);
    // Modern native with supplies the instance scope object. NTT's other
    // was an instance ID, used in creator filters and persisted by forks.
    // Normalize it before assigning creator/parent or comparing identities.
    if(is_struct(_scope)) return scrFRSelf(_scope);
    if(!is_undefined(_scope) && !is_array(_scope) && !is_string(_scope) && instance_exists(_scope)) return real(_scope.id);
    return _scope;
}


function scrFRInvoke(_scope,_code,_args) {
    if(!scrFRScopeExists(_scope)) return undefined;
    // Reentering with(self) changes the physical other. A collision callback
    // already running on its target must retain the actual colliding object.
    if(scrFRScopeSame(_scope,self)) return scrFRCallArray(_code,_args);
    var _result;
    with(_scope) _result=scrFRCallArray(_code,_args);
    return _result;
}

function scrFRInvokeHere(_code,_args) {
    _code=scrFRScriptRef(_code);
    if(variable_global_exists("fr_test_trace") && global.fr_test_trace)
        scrNTTESmokeLog("NTUF TRACE invoke "+(is_numeric(_code)?script_get_name(_code):typeof(_code))
            +" self="+string(id)+" frame="+string(current_frame));
    if(is_array(_code) || (is_struct(_code) && variable_struct_exists(_code,"fr_code")))
        return scrFRCallArray(_code,_args);
    if(is_struct(_code)) throw "Invalid Frontier callable object";
    switch(array_length(_args)) {
        case 0: return script_execute(_code);
        case 1: return script_execute(_code,_args[0]);
        case 2: return script_execute(_code,_args[0],_args[1]);
        case 3: return script_execute(_code,_args[0],_args[1],_args[2]);
        case 4: return script_execute(_code,_args[0],_args[1],_args[2],_args[3]);
        case 5: return script_execute(_code,_args[0],_args[1],_args[2],_args[3],_args[4]);
        case 6: return script_execute(_code,_args[0],_args[1],_args[2],_args[3],_args[4],_args[5]);
        case 7: return script_execute(_code,_args[0],_args[1],_args[2],_args[3],_args[4],_args[5],_args[6]);
        case 8: return script_execute(_code,_args[0],_args[1],_args[2],_args[3],_args[4],_args[5],_args[6],_args[7]);
        case 9: return script_execute(_code,_args[0],_args[1],_args[2],_args[3],_args[4],_args[5],_args[6],_args[7],_args[8]);
        case 10: return script_execute(_code,_args[0],_args[1],_args[2],_args[3],_args[4],_args[5],_args[6],_args[7],_args[8],_args[9]);
        case 11: return script_execute(_code,_args[0],_args[1],_args[2],_args[3],_args[4],_args[5],_args[6],_args[7],_args[8],_args[9],_args[10]);
        case 12: return script_execute(_code,_args[0],_args[1],_args[2],_args[3],_args[4],_args[5],_args[6],_args[7],_args[8],_args[9],_args[10],_args[11]);
        case 13: return script_execute(_code,_args[0],_args[1],_args[2],_args[3],_args[4],_args[5],_args[6],_args[7],_args[8],_args[9],_args[10],_args[11],_args[12]);
        case 14: return script_execute(_code,_args[0],_args[1],_args[2],_args[3],_args[4],_args[5],_args[6],_args[7],_args[8],_args[9],_args[10],_args[11],_args[12],_args[13]);
        case 15: return script_execute(_code,_args[0],_args[1],_args[2],_args[3],_args[4],_args[5],_args[6],_args[7],_args[8],_args[9],_args[10],_args[11],_args[12],_args[13],_args[14]);
        case 16: return script_execute(_code,_args[0],_args[1],_args[2],_args[3],_args[4],_args[5],_args[6],_args[7],_args[8],_args[9],_args[10],_args[11],_args[12],_args[13],_args[14],_args[15]);
    }
    throw "Frontier invocation exceeds audited arity 16";
}

function scrFRFieldName(_name,_target=undefined) {
    if(!is_undefined(_target) && !is_struct(_target) && !is_array(_target) && !is_string(_target)
        && instance_exists(_target) && instance_is(_target,GameCont)) {
        switch(_name) {
            case "kills":case "canspirit":return _name;
            case "norads":return "noradch";
            case "vaults":return "crownvisits";
        }
    }
    switch(_name) {
        case "my_health": return "hp";
        case "maxhealth": return "max_hp";
        case "race_id": return "race";
        case "kills": return "givekill";
        case "new": return "fr_field_new";
        case "text": return "mytext";
        case "canwalk": return "can_walk";
        case "canpick": return "can_pick";
        case "canspec": return "can_spec";
        case "canaim": return "can_aim";
        case "candie": return "can_die";
        case "canswap": return "can_swap";
        case "canfire": return "can_shoot";
        case "bcanfire": return "bcan_shoot";
        case "canspirit": return "can_spirit";
        case "chickendeaths": return "headloses";
        case "sprite_angle": return "image_angle";
        case "force": return "knockback_speed";
        case "shadcol": return "shadow_color";
        case "hspeed_raw": return "hspeed";
        case "vspeed_raw": return "vspeed";
        case "image_speed_raw": return "image_speed";
    }
    return _name;
}


function scrFRVariableExists(_target, _field) {
    if(scrFRAmmoTarget(_target,_field)) return true;
    if(scrFRPlayerCompatSeedTarget(_target,_field)) return true;
    _field=scrFRFieldName(_field,_target);
    if(is_struct(_target)) return variable_struct_exists(_target,_field);
    return instance_exists(_target) && variable_instance_exists(_target,_field);
}


function scrFRFieldGet(_target, _field) {
    if(scrFRAmmoTarget(_target,_field)) return scrFRAmmoArray(_target,_field);
    if(scrFRPlayerCompatSeedTarget(_target,_field)) return scrFRPlayerCompatSeedField(_field);
    _field=scrFRFieldName(_field,_target);
    if(_field=="bbox_right" || _field=="bbox_bottom") return scrFRSourceBBoxRead(_target,_field);
    if(is_struct(_target)) return _target[$ _field];
    if(!instance_exists(_target)) return undefined;
    if(string_length(_field)>=6 && string_copy(_field,1,5)=="alarm") {
        var _index=real(string_delete(_field,1,5));
        return scrFRAlarmRead(_target,_index);
    }
    if(!variable_instance_exists(_target,_field)) return undefined;
    return variable_instance_get(_target,_field);
}

function scrFRSourceBBoxRead(_target,_field) {
    // NTT's instance right/bottom are inclusive pixels; this native runner
    // exposes the outer edge. Source maps and sprite descriptors are data,
    // so only a live native instance read receives this conversion.
    if(is_struct(_target)) return _target[$ _field];
    if(!instance_exists(_target) || !variable_instance_exists(_target,_field)) return undefined;
    return variable_instance_get(_target,_field)-1;
}


function scrFRFilter(_target, _field, _values, _operation) {
    _field=scrFRFieldName(_field,_target);
    var _resolved=[];
    for(var _j=0;_j<array_length(_values);++_j) {
        var _expected=_values[_j];
        if(_field=="object_index" && is_string(_expected)) _expected=asset_get_index(_expected);
        if(_field=="wep"||_field=="bwep") {
            _expected=scrFRWeaponTryResolve(_expected);
            // Optional weapon modules are valid query operands even when
            // absent. They cannot match a native slot or a missing field.
            if(is_undefined(_expected)) continue;
        }
        if(_field=="area"||_field=="lastarea") {
            // Event compatibility pools also name optional, unloaded mods.
            // Missing areas cannot match a query; route writes remain strict.
            _expected=scrFRAreaTryResolve(_expected);
            if(is_undefined(_expected)) continue;
        }
        if(_field=="race") {
            // Optional companion races (Ace, Vanthro, Horsie) are queried by
            // supplied event/pickup callbacks without requiring those mods.
            // Skip unavailable operands; NE then includes the same targets.
            _expected=scrFRRaceTryResolve(_expected);
            if(is_undefined(_expected)) continue;
        }
        if(_field=="skin"||_field=="bskin") _expected=scrFRSkinResolve(_expected);
        array_push(_resolved,_expected);
    }
    _values=_resolved;
    var _found=[],_items=scrFRInstances(_target);
    _items=scrFRNTTEPetFilterItems(_target,_field,_values,_operation,_items);
    for(var _i=0;_i<array_length(_items);++_i) {
        var _item=_items[_i],_value=undefined,_match=false;
        // The snapshot is built immediately before this read and nothing in
        // this loop destroys instances. Preserve missing-field semantics.
        if(_field=="object_index") _value=scrFRObjectIndex(_item);
        else if(string_length(_field)>=6 && string_copy(_field,1,5)=="alarm")
            _value=scrFRAlarmRead(_item,real(string_delete(_field,1,5)));
        else if(_field=="bbox_right" || _field=="bbox_bottom") _value=scrFRSourceBBoxRead(_item,_field);
        else if(variable_instance_exists(_item,_field)) _value=variable_instance_get(_item,_field);
        for(var _j=0;_j<array_length(_values);++_j) {
            var _expected=_values[_j];
            switch(_operation) {
                case 0: _match=(_value==_expected); break;
                case 1: _match=(_value==_expected); break;
                // Missing fields never participate in ordered comparisons.
                case 2: _match=!is_undefined(_value)&&_value>=_expected; break;
                case 3: _match=!is_undefined(_value)&&_value>_expected; break;
                case 4: _match=!is_undefined(_value)&&_value<=_expected; break;
                case 5: _match=!is_undefined(_value)&&_value<_expected; break;
            }
            if(_match) break;
        }
        if(_operation==1) _match=!_match;
        if(_match) array_push(_found,_item);
    }
    return _found;
}


function scrFRMatching(_target, _field) {
    var _values=[]; for(var _i=2;_i<argument_count;++_i) array_push(_values,argument[_i]);
    return scrFRFilter(_target,_field,_values,0);
}

function scrFRMatchingNE(_target, _field) {
    var _values=[]; for(var _i=2;_i<argument_count;++_i) array_push(_values,argument[_i]);
    return scrFRFilter(_target,_field,_values,1);
}

function scrFRMatchingGE(_target,_field,_value) { return scrFRFilter(_target,_field,[_value],2); }

function scrFRMatchingGT(_target,_field,_value) { return scrFRFilter(_target,_field,[_value],3); }

function scrFRMatchingLE(_target,_field,_value) { return scrFRFilter(_target,_field,[_value],4); }

function scrFRMatchingLT(_target,_field,_value) { return scrFRFilter(_target,_field,[_value],5); }


function scrFRDelete(_target) {
    // instance_delete in NTT deliberately skips destroy/drop callbacks.
    var _items=scrFRInstances(_target);
    for(var _i=0;_i<array_length(_items);++_i) instance_destroy(_items[_i],false);
}


function scrFRWeaponName(_weapon) { return is_struct(_weapon)?scrFRSourceWeaponGet("name",_weapon):scr_weapon_get_name(scrFRWeaponResolve(_weapon)); }

function scrFRWeaponSprite(_weapon) { return is_struct(_weapon)?scrFRSourceWeaponGet("sprt",_weapon):scr_weapon_get_sprite(scrFRWeaponResolve(_weapon)); }

function scrFRWeaponType(_weapon) { return is_struct(_weapon)?scrFRSourceWeaponGet("type",_weapon):scr_weapon_get_type(scrFRWeaponResolve(_weapon)); }

function scrFRWeaponArea(_weapon) {
    // Authored optional integrations query the spawn depth before checking
    // mod_exists. An unavailable weapon cannot enter the available pool.
    if(is_string(_weapon) && !variable_struct_exists(global.fr_weapon_ids,_weapon)) {
        var _record=scrFRWeaponNTTERecord(_weapon);
        if(is_undefined(_record)) return infinity;
        return scrNTTEFullWeaponDropArea(_record.raw,id);
    }
    if(is_struct(_weapon)) return scrFRSourceWeaponGet("area",_weapon);
    return scr_weapon_get_area(scrFRWeaponResolve(_weapon));
}
function scrFRWeaponCost(_weapon) { return is_struct(_weapon)?scrFRSourceWeaponGet("cost",_weapon):scr_weapon_get_cost(scrFRWeaponResolve(_weapon)); }
function scrFRWeaponRads(_weapon) { return is_struct(_weapon)?scrFRSourceWeaponGet("rads",_weapon):scr_weapon_get_rads(scrFRWeaponResolve(_weapon)); }
function scrFRWeaponAuto(_weapon) { return is_struct(_weapon)?scrFRSourceWeaponGet("auto",_weapon):scr_weapon_is_auto(scrFRWeaponResolve(_weapon)); }
function scrFRWeaponIsMelee(_weapon) { return is_struct(_weapon)?scrFRSourceWeaponGet("melee",_weapon):scr_weapon_is_melee(scrFRWeaponResolve(_weapon)); }
function scrFRWeaponSetSprite(_weapon,_sprite) { wep_sprt[scrFRWeaponResolve(_weapon)]=_sprite;return _sprite; }

function scrFRWeaponSetName(_weapon,_name) { wep_name[scrFRWeaponResolve(_weapon)]=_name; }

function scrFRWeaponSetArea(_weapon,_area) { wep_area[scrFRWeaponResolve(_weapon)]=_area; }

function scrFRWeaponNTTERecord(_weapon) {
    if(!is_string(_weapon)) return undefined;
    var _key=scrFRModuleKey("weapon",_weapon);
    if(string_copy(_key,1,7)!="weapon:") return undefined;
    return scrNTTEFullWeaponDropRecord(string_delete(_key,1,7));
}

function scrFRWeaponTryResolve(_weapon) {
    var _depth=0;
    while(is_struct(_weapon) && variable_struct_exists(_weapon,"wep")) {
        if(++_depth>100) throw "Frontier cyclic weapon identity";
        _weapon=_weapon.wep;
    }
    if(is_numeric(_weapon)) return _weapon;
    if(is_string(_weapon) && variable_struct_exists(global.fr_weapon_ids,_weapon)) return global.fr_weapon_ids[$ _weapon];
    var _record=scrFRWeaponNTTERecord(_weapon);
    return is_undefined(_record)?undefined:_record.weapon;
}

function scrFRWeaponResolve(_weapon) {
    var _resolved=scrFRWeaponTryResolve(_weapon);
    assert(!is_undefined(_resolved),"Unknown Frontier or native NTTE weapon: "+string(_weapon));
    return _resolved;
}

function scrFRWeaponList(_list,_minimum,_maximum) {
    for(var _i=1;_i<=maxwep;++_i) {
        var _area=scr_weapon_get_area(_i);
        if(_area>=_minimum&&_area<=_maximum) ds_list_add(_list,_i);
    }
}

function scrFRWeaponPost(_kick,_shift,_shake) { scr_weapon_post(gunangle,_shift,_shake,_kick); }

function scrFRPlayerFind(_index) {
    var _found=noone;
    with(Player) if(index==_index) {_found=id;break;}
    return _found;
}

function scrFRPlayerFire(_direction=undefined) {
    // NTT player_fire's argument is aim direction, not a weapon ID. The
    // opening Venus scene already pays its one round in the source script.
    var _old=gunangle;
    if(!is_undefined(_direction)) gunangle=_direction;
    try {return scrFire(scrFRWeaponResolve(wep),false);}
    finally {gunangle=_old;}
}

function scrFRButtonValue(_index,_action,_prefix) {
    // Native InputHandling owns one struct containing each sampled slot array.
    // Legacy instance-variable access silently misses all ordinary actions.
    if(!is_real(_index) || _index<0 || floor(_index)!=_index || _index>=array_length(KeyCont.touch)) return false;
    if(_action=="okay") {
        if(_index!=global.index) return false;
        if(KeyCont.touch[_index]) {
            var _touch=variable_struct_get(KeyCont,_prefix+"_pick");
            return is_array(_touch) && _index<array_length(_touch) && _touch[_index];
        }
        if(UberCont.opt_gamepad) return (_prefix=="press")
            ? input_gamepad_check_pressed(_index,gp_face1) : input_gamepad_check(_index,gp_face1);
        return (_prefix=="press")?scr_keyboard_check_pressed(vk_enter):scr_keyboard_check_held(vk_enter);
    }
    var _key=_prefix+"_"+_action;
    if(!variable_struct_exists(KeyCont,_key)) return false;
    var _values=variable_struct_get(KeyCont,_key);
    return is_array(_values) && _index<array_length(_values) && _values[_index];
}

function scrFRButtonCheck(_index,_action) { return scrFRButtonValue(_index,_action,"hold"); }

function scrFRButtonPressed(_index,_action) { return scrFRButtonValue(_index,_action,"press"); }

function scrFRMotionAdd(_direction,_speed) { motion_add(_direction,_speed*timescale); }

function scrFRMotionSet(_direction,_speed) { motion_set(_direction,_speed*timescale); }

function scrFRMoveTowardsPoint(_x,_y,_speed) { move_towards_point(_x,_y,_speed*timescale); }

function scrFRScaledIncrement(_scope,_field,_delta,_post,_factor) {
    var _previous=variable_instance_get(_scope,_field)/_factor;
    variable_instance_set(_scope,_field,(_previous+_delta)*_factor);
    return _post?_previous:(_previous+_delta);
}

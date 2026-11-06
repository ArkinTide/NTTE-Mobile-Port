// Weapon IDs are allocated by the frozen 2.0 identity ledger after NTTE178.
function scrFRWeaponsInit() { scrFRWeaponsRefresh(); }

function scrFRWeaponDropRaw(_raw) {
    if(!scrFREnabled() || !is_string(_raw)) return undefined;
    var _key=scrFRModuleKey("weapon",_raw);
    if(string_copy(_key,1,7)!="weapon:" || !(global.fr_initialized[$ _key]??false)) return undefined;
    return global.fr_weapon_ids[$ string_delete(_key,1,7)];
}

function scrFRWeaponDropCandidates(_list) {
    if(!scrFREnabled()) return _list;
    // NTT registers raw MOD declarations, including area -1 entries, before
    // shuffling. Never prefilter settings, difficulty or held weapons here.
    for(var _i=0;_i<array_length(global.fr_module_order);++_i) {
        var _key=global.fr_module_order[_i];
        if(string_copy(_key,1,7)!="weapon:" || !(global.fr_initialized[$ _key]??false)) continue;
        var _raw=string_delete(_key,1,7);
        if(!is_undefined(global.fr_weapon_ids[$ _raw]) && array_get_index(_list,_raw)<0) array_push(_list,_raw);
    }
    return _list;
}

function scrFRWeaponDropDuplicates(_raw,_nearest) {
    var _weapon=scrFRWeaponDropRaw(_raw);
    if(is_undefined(_weapon)) return undefined;
    if(!instance_exists(_nearest) || _nearest.race==Race.Steroids) return false;
    var _name=string_delete(global.fr_weapon_keys[$ string(_weapon)],1,7),
        _primary=scrFRWeaponSlotRead(_nearest,"wep"),_secondary=scrFRWeaponSlotRead(_nearest,"bwep");
    // Raw strings match unevolved native pickups. Authored lightweight
    // records and complete NTTE fusion handles retain their own identity.
    return (is_string(_primary) && _primary==_name) || (is_string(_secondary) && _secondary==_name);
}

function scrFRWeaponProperty(_key,_property,_default) {
    var _code=global.fr_module_scripts[$ _key][$ _property];
    if(is_undefined(_code)) return _default;
    var _args=[];
    if(string_copy(_key,1,7)=="weapon:") _args=[global.fr_weapon_ids[$ string_delete(_key,1,7)]];
    var _value=scrFRInvokeHere(_code,_args);
    return is_undefined(_value)?_default:_value;
}

function scrFRWeaponsRefresh() {
    var _ids=variable_struct_get_names(global.fr_weapon_keys);
    for(var _i=0;_i<array_length(_ids);++_i) {
        var _weapon=real(_ids[_i]),_key=global.fr_weapon_keys[$ _ids[_i]];
        var _name=string_delete(_key,1,7);
        wep_name[_weapon]=string_upper(scrFRWeaponProperty(_key,"weapon_name",_name));
        wep_type[_weapon]=scrFRWeaponProperty(_key,"weapon_type",0);
        wep_cost[_weapon]=scrFRWeaponProperty(_key,"weapon_cost",0);
        wep_load[_weapon]=scrFRWeaponProperty(_key,"weapon_load",1);
        wep_area[_weapon]=scrFRWeaponProperty(_key,"weapon_area",-1);
        wep_auto[_weapon]=scrFRWeaponProperty(_key,"weapon_auto",false);
        wep_sprt[_weapon]=scrFRWeaponProperty(_key,"weapon_sprt",sprDefault);
        wep_text[_weapon]=scrFRWeaponProperty(_key,"weapon_text","");
        wep_swap[_weapon]=scrFRWeaponProperty(_key,"weapon_swap",sndSwapPistol);
        wep_mele[_weapon]=scrFRWeaponProperty(_key,"weapon_melee",false);
        wep_gold[_weapon]=scrFRWeaponProperty(_key,"weapon_gold",false);
        wep_rads[_weapon]=scrFRWeaponProperty(_key,"weapon_rads",0);
        wep_lout[_weapon]=-1; wep_naim[_weapon]=false;
    }
}

function scrFRWeaponFire(_weapon,_primary=true) {
    if(!scrFREnabled()) return false;
    var _raw=scrFRWeaponRaw(_weapon),_key=global.fr_weapon_keys[$ string(_raw)];
    if(is_undefined(_key)) return false;
    var _scripts=global.fr_module_scripts[$ _key];
    var _prefire=_scripts[$ "weapon_prefire"];
    var _value=is_struct(_weapon)?_weapon:scrFRWeaponPrepare(_raw,_primary);
    if(variable_instance_exists(id,"fr_charge_state") && is_struct(fr_charge_state)) _value=fr_charge_state;
    // A native weapon callback is an event on the shooter. Establish its
    // own top-level other even when a pet/helper called through another
    // object's with scope; nested authored projectile with blocks still get
    // this shooter as their real other. Do not alter collision dispatch.
    if(!is_undefined(_prefire)) with(id) scrFRInvokeHere(_prefire,[_primary,_value]);
    var _fire=_scripts[$ "weapon_fire"];
    assert(!is_undefined(_fire),"Frontier weapon has no fire callback: "+_key);
    with(id) scrFRInvokeHere(_fire,[_value]);
    // Every supplied burst weapon authors its own WeaponBurst controller in
    // weapon_fire. weapon_burst is metadata, not another native firing loop;
    // starting both duplicates every burst and recursively multiplies proxies.
    return true;
}

function scrFRWeaponStep() {
    if(!scrFRReadyTick() || lockstep_stop || UberCont.paused) return;
    var _slots=[wep,bwep];
    for(var _i=0;_i<2;++_i) {
        var _slot=_slots[_i];
        if(is_struct(_slot) || scrNTTEFullWeaponIsNative(_slot)) {
            var _parts=scrNTTEFullMergedRuntimeStateParts(scrNTTEFullMergedRuntimePart(_slot));
            for(var _j=0;_j<array_length(_parts);++_j) scrFRWeaponMergedCallback(id,_parts[_j],_i==0,"step");
            continue;
        }
        var _key=global.fr_weapon_keys[$ string(_slot)];
        if(is_undefined(_key)) continue;
        scrFRWeaponPrepare(_slot,_i==0);
        var _step=global.fr_module_scripts[$ _key][$ "step"];
        if(!is_undefined(_step)) with(id) scrFRInvokeHere(_step,[_i==0]);
    }
}

function scrFRPlayerFireExt(_angle,_weapon,_x,_y,_team,_owner,_accuracy=1,_burst_child=false) {
    // Player.Create initializes a complete native fire context without joining
    // the run. Change its object before it is visible to with(Player) scans.
    var _proxy=instance_create(_x,_y,Player);
    with(_proxy) {
        instance_change(FRFireCont,false);
        visible=false; persistent=false; mask_index=mskNothing;
        fr_fire_owner=_owner;fr_fire_serial=scrFRLogicSerial();
        fr_burst_child=_burst_child;fr_charge_state=is_struct(_weapon)?_weapon:undefined;
        creator=_owner; team=_team; accuracy=_accuracy;gunangle=_angle;
        wep=scrFRWeaponRaw(_weapon);bwep=wep_none;infammo=true;
        if(is_struct(_weapon)) scrFRWeaponSlotWrite(id,"wep",_weapon);
        index=instance_exists(_owner)?scrNTTEFullValue(_owner,"index",0):0;
        race=instance_exists(_owner)?scrNTTEFullValue(_owner,"race",Race.Fish):Race.Fish;
        hitid=instance_exists(_owner)?scrNTTEFullValue(_owner,"hitid",[sprMutant1Idle,""]):[sprMutant1Idle,""];
        if(wep!=wep_none) scrFire(wep,false,true);
    }
    return _proxy;
}

function scrFRWeaponRaw(_weapon) {
    var _depth=0;
    while(is_struct(_weapon) && variable_struct_exists(_weapon,"wep")) {
        if(++_depth>100) throw "Frontier cyclic weapon state";
        _weapon=_weapon.wep;
    }
    return scrFRWeaponResolve(_weapon);
}
function scrFRSourceWeaponEqual(_left,_right) {
    // Source lightweight-weapon records compare by identity, as in NTT.
    // Unwrapping them here would make an unequipped twin look equipped.
    if(is_struct(_left) || is_struct(_right)) return is_struct(_left)&&is_struct(_right)&&_left==_right;
    if(is_undefined(_left) || is_undefined(_right)) return is_undefined(_left)&&is_undefined(_right);
    return scrFRWeaponResolve(_left)==scrFRWeaponResolve(_right);
}
function scrFRWeaponPhysicalState(_scope,_raw) {
    var _context=variable_global_exists("ntte_full_merged_state_fire")?global.ntte_full_merged_state_fire:undefined;
    if(!is_struct(_context) || _context.actor!=_scope || !is_struct(_context.part)
        || scrNTTEFullWeaponRaw(_context.part)!=_raw) return undefined;
    return scrNTTEFullWeaponNativeState(_context.part);
}
function scrFRWeaponMergedCallback(_actor,_part,_primary,_callback) {
    var _raw=scrNTTEFullWeaponRaw(_part),_key=global.fr_weapon_keys[$ string(_raw)];
    if(is_undefined(_key)) return false;
    var _code=global.fr_module_scripts[$ _key][$ _callback];
    if(is_undefined(_code)) return false;
    var _mount=scrNTTEFullMergedRuntimeStateMount(_actor,_part,_primary,true),
        _old=variable_global_exists("ntte_full_merged_state_fire")?global.ntte_full_merged_state_fire:undefined,
        _sourcea=_actor[$ "fr_source_wep"]??undefined,_sourceb=_actor[$ "fr_source_bwep"]??undefined;
    global.ntte_full_merged_state_fire={actor:_actor,part:_part,primary:_primary};
    try {with(_actor) {scrFRWeaponPrepare(_raw,_primary);scrFRInvokeHere(_code,[_primary]);}}
    finally {
        global.ntte_full_merged_state_fire=_old;
        scrNTTEFullMergedRuntimeStateUnmount(_mount);
        _actor.fr_source_wep=_sourcea;_actor.fr_source_bwep=_sourceb;
    }
    return true;
}
function scrFRWeaponCarrier(_scope) {
    return instance_exists(_scope) && (instance_is(_scope,Player)
        || instance_is(_scope,FRFireCont) || instance_is(_scope,WepPickup));
}
function scrFRWeaponSlotPhysical(_scope,_field,_create=false) {
    if(!scrFRWeaponCarrier(_scope) || !variable_instance_exists(_scope,_field)) return undefined;
    var _weapon=variable_instance_get(_scope,_field),_physical=scrFRWeaponPhysicalState(_scope,_weapon);
    if(is_struct(_physical)) return _physical;
    // A mounted fusion leaf uses the context above. Outside that context its
    // complete native handle must remain visible to the source, not one leaf.
    if(is_struct(_weapon) || scrNTTEFullWeaponIsNative(_weapon)) return undefined;
    var _key=_field=="wep"?"ntte_state":"bntte_state";
    _physical=_scope[$ _key]??undefined;
    if(!is_struct(_physical) || (_physical[$ "weapon"]??undefined)!=_weapon) {
        if(!_create) return undefined;
        _physical=scrNTTENewState(_weapon);
        variable_instance_set(_scope,_key,_physical);
    }
    return _physical;
}
function scrFRWeaponSlotsSync(_scope) {
    if(!scrFRWeaponCarrier(_scope)) return;
    for(var _i=0;_i<2;++_i) {
        var _field=_i==0?"wep":"bwep";
        if(!variable_instance_exists(_scope,_field)) continue;
        var _physical=scrFRWeaponSlotPhysical(_scope,_field),_state=undefined;
        if(is_struct(_physical)) _state=_physical[$ "fr_source_weapon"]??undefined;
        // ntte_state follows native swaps, extra slots and drops, including
        // two physical copies of the same raw weapon with different values.
        variable_instance_set(_scope,"fr_source_"+_field,is_struct(_state)?_state:undefined);
    }
}
function scrFRWeaponSourceValue(_value) {
    // Ordinary loaded MOD weapons are strings in NTT. Keep this conversion
    // at the inventory read boundary so authored locals, arrays, traders and
    // is_string checks all observe the same representation. Native storage
    // and existing canonical lightweight/fusion records remain authoritative.
    if(!is_numeric(_value)) return _value;
    var _key=global.fr_weapon_keys[$ string(_value)];
    return is_undefined(_key)?_value:string_delete(_key,1,7);
}
function scrFRWeaponSlotRead(_scope,_field) {
    if(is_struct(_scope)) return _scope[$ _field];
    if(!instance_exists(_scope) || !variable_instance_exists(_scope,_field)) return undefined;
    if(scrFRWeaponCarrier(_scope)) {
        var _physical=scrFRWeaponSlotPhysical(_scope,_field);
        if(is_struct(_physical) && is_struct(_physical[$ "fr_source_weapon"]??undefined)) return _physical.fr_source_weapon;
        scrFRWeaponSlotsSync(_scope);
        var _state=_scope[$ "fr_source_"+_field]??undefined;
        if(is_struct(_state)) return _state;
    }
    return scrFRWeaponSourceValue(variable_instance_get(_scope,_field));
}
function scrFRWeaponSlotWrite(_scope,_field,_value) {
    if(is_struct(_scope)) {_scope[$ _field]=_value;return _value;}
    if(!instance_exists(_scope)) return _value;
    if(scrFRWeaponCarrier(_scope)) {
        var _raw=scrFRWeaponRaw(_value),_physical=scrFRWeaponPhysicalState(_scope,_raw);
        variable_instance_set(_scope,_field,_raw);
        if(!is_struct(_physical)) _physical=scrFRWeaponSlotPhysical(_scope,_field,true);
        if(is_struct(_physical)) _physical.fr_source_weapon=is_struct(_value)?_value:undefined;
        variable_instance_set(_scope,"fr_source_"+_field,is_struct(_value)?_value:undefined);
        if(instance_is(_scope,WepPickup)) with(_scope) {
            name=scr_weapon_get_name(wep);type=scr_weapon_get_type(wep);
            sprite_index=scr_weapon_get_sprite(wep);
        }
    }
    else variable_instance_set(_scope,_field,_value);
    return _value;
}
function scrFRWeaponPrepare(_weapon,_primary=true) {
    var _field=_primary?"wep":"bwep",_state=scrFRWeaponSlotRead(id,_field),_raw=scrFRWeaponRaw(_weapon);
    if(is_struct(_state) && scrFRWeaponRaw(_state)==_raw) {_state.primary=_primary;return _state;}
    var _key=global.fr_weapon_keys[$ string(_raw)];
    if(is_undefined(_key)) return _weapon;
    var _init=global.fr_module_scripts[$ _key][$ "lwo_initialize"];
    if(is_undefined(_init)) return scrFRWeaponSourceValue(_raw);
    // NPC fire proxies must receive their own record. The authored initializer
    // otherwise follows creator and can overwrite a real player's inventory.
    var _proxy=instance_is(id,FRFireCont),_owner=self[$ "creator"]??noone;
    if(_proxy) creator=id;
    try {scrFRInvokeHere(_init,[_raw]);} finally {if(_proxy) creator=_owner;}
    _state=scrFRWeaponSlotRead(id,_field);
    assert(is_struct(_state),"Frontier weapon initializer did not bind a source state: "+_key);
    _state.primary=_primary;
    return _state;
}
function scrFRWeaponReloaded(_primary=true) {
    if(!scrFREnabled()) return false;
    var _weapon=_primary?wep:bwep;
    if(is_struct(_weapon) || scrNTTEFullWeaponIsNative(_weapon)) {
        var _parts=scrNTTEFullMergedRuntimeStateParts(scrNTTEFullMergedRuntimePart(_weapon)),_found=false;
        for(var _j=0;_j<array_length(_parts);++_j)
            _found=scrFRWeaponMergedCallback(id,_parts[_j],_primary,"weapon_reloaded")||_found;
        return _found;
    }
    var _key=global.fr_weapon_keys[$ string(_weapon)];
    if(is_undefined(_key)) return false;
    var _callback=global.fr_module_scripts[$ _key][$ "weapon_reloaded"];
    if(is_undefined(_callback)) return false;
    scrFRWeaponPrepare(_weapon,_primary);
    scrFRInvokeHere(_callback,[_primary]);
    return true;
}
function scrFRWeaponRuntimeProperty(_weapon,_property) {
    if(!scrFREnabled() || is_struct(_weapon)) return undefined;
    var _key=global.fr_weapon_keys[$ string(_weapon)];
    if(is_undefined(_key)) return undefined;
    var _callback=global.fr_module_scripts[$ _key][$ "weapon_"+_property];
    if(is_undefined(_callback)) return undefined;
    var _value=_weapon;
    // Native loot providers also query metadata while scoped to their drop
    // record. Such structs have no instance id or physical inventory slots.
    if(!is_struct(self) && instance_exists(self)) {
        var _physical=scrFRWeaponPhysicalState(self,_weapon);
        if(is_struct(_physical) && is_struct(_physical[$ "fr_source_weapon"]??undefined))
            _value=_physical.fr_source_weapon;
        else if(scrFRWeaponCarrier(self)) {
            if(wep==_weapon) _value=scrFRWeaponSlotRead(self,"wep");
            else if(variable_instance_exists(self,"bwep") && bwep==_weapon) _value=scrFRWeaponSlotRead(self,"bwep");
        }
    }
    return scrFRInvokeHere(_callback,[_value]);
}
function scrFRWeaponPickupAdopt(_pickup,_physical) {
    if(!scrFREnabled() || !instance_exists(_pickup) || !is_struct(_physical)
        || !is_struct(_physical[$ "fr_source_weapon"]??undefined)) return;
    assert(_physical.weapon==_pickup.wep,"Frontier drop received a different physical weapon's state");
    _pickup.ntte_state=_physical;_pickup.fr_source_wep=_physical.fr_source_weapon;
    with(_pickup) {
        name=scr_weapon_get_name(wep);type=scr_weapon_get_type(wep);
        sprite_index=scr_weapon_get_sprite(wep);
    }
}
function scrFRWeaponChargeState(_weapon,_primary=true) {
    _weapon=scrFRWeaponRaw(_weapon);
    var _state=scrFRWeaponPrepare(_weapon,_primary);
    if(!is_struct(_state)) {
        var _key=global.fr_weapon_keys[$ string(_weapon)];
        _state={wep:_weapon,chrg:0,chrg_num:0,chrg_max:max(1,scrFRWeaponProperty(_key,"weapon_charge_max",1)),primary:_primary};
        scrFRWeaponSlotWrite(id,_primary?"wep":"bwep",_state);
    }
    return _state;
}
function scrFRWeaponChargeInit(_weapon) {
    var _primary=is_struct(_weapon)?scrNTTEFullValue(_weapon,"primary",true):true,
        _state=is_struct(_weapon)?_weapon:scrFRWeaponChargeState(_weapon,_primary),
        _owner=instance_is(id,FRFireCont)?fr_fire_owner:id,
        _spec=self[$ "specfiring"]??false;
    if(_state.chrg>=0) {
        _state.chrg=(_state.chrg_num<_state.chrg_max)?1:2;
        if(_state.chrg==1) {
            _state.chrg_num=min(_state.chrg_num+(self[$ "reloadspeed"]??1)*scrFRSourceScale(),_state.chrg_max);
            if(_spec && _primary) _state.chrg_num=_state.chrg_max;
        }
        else if((scrFRSourceFrame() mod 12)<scrFRSourceScale() && instance_is(_owner,Player)) _owner.gunshine=2;
        reload=min(reload,(self[$ "reloadspeed"]??1)*scrFRSourceScale());
        if(!instance_is(id,Player) || !(self[$ "fr_charge_native_input"]??false)) {
            var _controller=self[$ "fr_charge_controller"]??noone;
            if(!instance_exists(_controller)) {
                _controller=instance_create(x,y,FRCustomObject);
                with(_controller) {name="fr_FireCharge";on_step=scrFRWeaponChargeControllerStep;fr_wait=0;}
                fr_charge_controller=_controller;
            }
            _controller.fr_owner=_owner;_controller.fr_state=_state;_controller.fr_angle=gunangle;
            _controller.fr_accuracy=accuracy;_controller.fr_team=team;_controller.fr_wait=0;
            _controller.x=x;_controller.y=y;
        }
    }
    return {wep:_state,creator:_owner,primary:_primary,wepheld:instance_exists(_owner) && scrFRWeaponRaw(scrNTTEFullValue(_owner,"wep",0))==_state.wep,spec:_spec};
}
function scrFRWeaponChargeControllerStep() {
    if(++fr_wait<2) return;
    if(!instance_exists(fr_owner)) {instance_destroy();return;}
    fr_state.chrg=-1;
    scrFRPlayerFireExt(fr_angle,fr_state,x,y,fr_team,fr_owner,fr_accuracy,true);
    fr_state.chrg=0;fr_state.chrg_num=0;
    instance_destroy();
}
function scrFRWeaponInput(_weapon,_primary=true) {
    if(!scrFREnabled()) return false;
    if(is_struct(_weapon) || scrNTTEFullWeaponIsNative(_weapon)) {
        var _part=scrNTTEFullMergedRuntimePart(_weapon),_raw=scrNTTEFullWeaponRaw(_part),
            _key=global.fr_weapon_keys[$ string(_raw)];
        if(is_undefined(_key) || !scrFRWeaponProperty(_key,"weapon_chrg",false)) return false;
        var _mount=scrNTTEFullMergedRuntimeStateMount(id,_part,true),
            _old=variable_global_exists("ntte_full_merged_state_fire")?global.ntte_full_merged_state_fire:undefined,
            _input=variable_global_exists("ntte_full_merged_input_weapon")?global.ntte_full_merged_input_weapon:undefined,
            _sourcea=self[$ "fr_source_wep"]??undefined,_sourceb=self[$ "fr_source_bwep"]??undefined;
        global.ntte_full_merged_state_fire={actor:id,part:_part,primary:_primary};
        global.ntte_full_merged_input_weapon=_weapon;
        var _result=false;
        try {_result=scrFRWeaponInput(_raw,_primary);}
        finally {
            global.ntte_full_merged_state_fire=_old;global.ntte_full_merged_input_weapon=_input;
            scrNTTEFullMergedRuntimeStateUnmount(_mount);fr_source_wep=_sourcea;fr_source_bwep=_sourceb;
        }
        return _result;
    }
    var _raw=scrFRWeaponRaw(_weapon),_key=global.fr_weapon_keys[$ string(_raw)];
    if(is_undefined(_key) || !scrFRWeaponProperty(_key,"weapon_chrg",false)) return false;
    var _state=scrFRWeaponChargeState(_raw,_primary),_held=KeyCont.hold_fire[index],_pressed=KeyCont.press_fire[index];
    // Called inside scrPlayerFiring, including Steroids' temporarily swapped
    // input/slots. A release owns a single source callback and all true costs.
    if(_held && (can_shoot || _state.chrg_num>0) && scrCheckAmmo(_weapon) && scrCheckRads(_weapon)) {
        if(scrFRReadyTick()) {
            fr_charge_native_input=true;
            try {scrFire(_weapon,true,_primary);} finally {fr_charge_native_input=false;}
        }
    }
    else if(!_held && (_state.chrg_num>0 || _pressed)) {
        _state.chrg=-1;
        try {scrFire(_weapon,true,_primary);} finally {_state.chrg=0;_state.chrg_num=0;}
    }
    return true;
}
function scrFRSourceWeaponGet(_property,_weapon) {
    var _raw=scrFRWeaponRaw(_weapon),_key=global.fr_weapon_keys[$ string(_raw)];
    if(!is_undefined(_key)) {
        var _callback=global.fr_module_scripts[$ _key][$ "weapon_"+_property];
        if(!is_undefined(_callback)) {
            var _result=scrFRInvokeHere(_callback,[_weapon]);
            return _property=="fire"?id:_result;
        }
    }
    switch(_property) {
        case "raw":return _raw;
        case "chrg":return false;
        case "charge_max":return 0;
        case "avail":case "burst":return 1;
        case "burst_time":return 1;
        case "name":return scr_weapon_get_name(_raw);
        case "sprt":case "sprite":return scr_weapon_get_sprite(_raw);
        case "type":return scr_weapon_get_type(_raw);
        case "cost":return scr_weapon_get_cost(_raw);
        case "rads":return scr_weapon_get_rads(_raw);
        case "load":return scr_weapon_get_load(_raw);
        case "auto":return scr_weapon_is_auto(_raw);
        case "melee":return scr_weapon_is_melee(_raw);
        case "area":return scr_weapon_get_area(_raw);
        case "fire":
            if(instance_is(id,Player)) {scrFire(_raw,false);return id;}
            return scrFRPlayerFireExt(gunangle,_weapon,x,y,team,self[$ "creator"]??id,self[$ "accuracy"]??1);
    }
    return 0;
}
function scrFRWeaponBurstStart(_weapon,_primary,_remaining,_interval) {
    var _owner=instance_is(id,FRFireCont)?fr_fire_owner:id,_controller=instance_create(x,y,FRCustomObject);
    _controller.name="fr_WeaponBurst";_controller.on_step=scrFRWeaponBurstStep;
    _controller.fr_owner=_owner;_controller.fr_weapon=_weapon;_controller.fr_primary=_primary;
    _controller.fr_remaining=_remaining;_controller.fr_interval=_interval;_controller.fr_delay=_interval;
    _controller.fr_angle=gunangle;_controller.fr_accuracy=accuracy;_controller.fr_team=team;
}
function scrFRWeaponBurstStep() {
    if(!instance_exists(fr_owner)) {instance_destroy();return;}
    fr_delay-=scrFRSourceScale();if(fr_delay>0) return;
    x=fr_owner.x;y=fr_owner.y;
    if(variable_instance_exists(fr_owner,"gunangle")) fr_angle=fr_owner.gunangle;
    scrFRPlayerFireExt(fr_angle,fr_weapon,x,y,fr_team,fr_owner,fr_accuracy,true);
    if(--fr_remaining<=0) instance_destroy();else fr_delay+=fr_interval;
}

function scrFRFireContFinalize() {
    var _proxy=id,_owner=fr_fire_owner;
    // Authored weapon callbacks may create their shots after the helper has
    // returned (wep_none + direct weapon_fire). Finalize only at end-step.
    with(all) if(id>_proxy && variable_instance_exists(id,"creator") && creator==_proxy) {
        creator=_owner;
        if(variable_instance_exists(id,"team")) team=_proxy.team;
        if(variable_instance_exists(id,"hitid")) hitid=_proxy.hitid;
    }
    instance_destroy(id,false);
}

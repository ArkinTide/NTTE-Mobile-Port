// Static NTT module and reference semantics. No runtime source loading or eval.
function scrFRRuntimeInit() {
    global.fr_enabled=false;
    global.fr_module_vars={}; global.fr_module_scripts={};
    global.fr_module_aliases={}; global.fr_module_order=[];
    global.fr_initialized={}; global.fr_hook_cache={};
    global.fr_weapon_ids={}; global.fr_weapon_keys={};
    global.fr_area_ids={}; global.fr_area_keys={};
    global.fr_skill_ids={}; global.fr_skill_keys={};
    global.fr_skill_pool={};
    global.fr_race_ids={}; global.fr_race_keys={};
    global.fr_sound_assets={}; global.fr_sound_replacements={};
    global.fr_sprite_backups={}; global.fr_asset_sources={};
    scrFRTaskRuntimeInit();
    scrFRRegisterModules(); scrFRRegisterAssets(); scrFRRegisterIdentities();
    scrFRRegisterNTTECompat();
}

function scrFRModuleKey(_kind,_name) {
    if(_kind=="wep") _kind="weapon";
    if(!is_string(_name)) {
        if(_kind=="weapon") {
            // Source callbacks may pass a held lightweight record, while
            // native firing/pickup code holds the allocated numeric ID.
            // Both identify the declared module; neither is a module name.
            var _raw=_name,_depth=0;
            while(is_struct(_raw) && variable_struct_exists(_raw,"wep")) {
                if(++_depth>100) throw "Frontier cyclic weapon module identity";
                _raw=_raw.wep;
            }
            if(is_numeric(_raw)) {
                var _weapon_key=global.fr_weapon_keys[$ string(_raw)];
                if(!is_undefined(_weapon_key)) return _weapon_key;
                var _native=scrNTTEFullWeaponDropNativeRecord(_raw);
                if(!is_undefined(_native)) _name=_native.raw;
            } else if(is_string(_raw)) _name=_raw;
        }
        if(_kind=="race") {var _key=scrFRRaceKey(_name);if(_key!="") _name=_key;}
        if(_kind=="skin") {var _key=scrFRSkinKey(_name);if(_key!="") _name=_key;}
        if(_kind=="skill") {var _key=scrFRSkillKey(_name);if(!is_undefined(_key)) _name=_key;}
        if(_kind=="area") {var _key=scrFRAreaKey(_name);if(_key!="") _name=_key;}
    }
    _name=string_replace_all(string(_name),"\\","/");
    if(string_pos(":",_name)>0) return global.fr_module_aliases[$ _name]??_name;
    var _suffixes=[".mod.gml",".mod.ntgml",".wep.gml",".area.gml",".skill.gml",".race.gml",".skin.gml",".crown.gml"];
    for(var _i=0;_i<array_length(_suffixes);++_i) {
        var _suffix=_suffixes[_i],_at=string_length(_name)-string_length(_suffix)+1;
        if(_at>0 && string_copy(_name,_at,string_length(_suffix))==_suffix) {_name=string_delete(_name,_at,string_length(_suffix));break;}
    }
    var _key=_kind+":"+_name;
    return global.fr_module_aliases[$ _key]??_key;
}

function scrFRRegisterModule(_key,_scripts) {
    assert(!variable_struct_exists(global.fr_module_scripts,_key),"Duplicate Frontier module "+_key);
    global.fr_module_vars[$ _key]={};
    global.fr_module_scripts[$ _key]=_scripts;
    array_push(global.fr_module_order,_key);
}

function scrFRModLoaded(_kind,_module) {
    if(!variable_global_exists("fr_module_scripts")) return false;
    var _key=scrFRModuleKey(_kind,_module);
    if(variable_struct_exists(global.fr_module_scripts,_key)) return global.fr_initialized[$ _key]??false;
    if(string_copy(_key,1,7)=="weapon:" && !is_undefined(scrFRWeaponNTTERecord(_key))) return true;
    if(string_copy(_key,1,6)=="skill:" && scrNTTEFullSkillId(string_delete(_key,1,6))>=0) return true;
    return scrFRNTTEExists(_kind,_module);
}

function scrFRModExists(_kind,_module,_field) {
    if(scrFRNTTEHandles(_kind,_module)) return scrFRNTTEVariableExists(_kind,_module,_field);
    var _key=scrFRModuleKey(_kind,_module);
    if(variable_struct_exists(global.fr_module_scripts,_key) && !(global.fr_initialized[$ _key]??false)) return false;
    if(variable_struct_exists(global.fr_module_vars,_key))
        return variable_struct_exists(global.fr_module_vars[$ _key],_field);
    return scrFRNTTEHandles(_kind,_module) && !is_undefined(scrFRNTTEGet(_kind,_module,_field));
}

function scrFRModGet(_kind,_module,_field) {
    if(scrFRNTTEHandles(_kind,_module)) return scrFRNTTEGet(_kind,_module,_field);
    var _key=scrFRModuleKey(_kind,_module);
    if(variable_struct_exists(global.fr_module_vars,_key)) return global.fr_module_vars[$ _key][$ _field];
    if(scrFRNTTEHandles(_kind,_module)) return scrFRNTTEGet(_kind,_module,_field);
    throw "Frontier reads unknown module "+_key+"."+string(_field);
}

function scrFRModSet(_kind,_module,_field,_value) {
    if(scrFRNTTEHandles(_kind,_module)) return scrFRNTTESet(_kind,_module,_field,_value);
    var _key=scrFRModuleKey(_kind,_module);
    if(variable_struct_exists(global.fr_module_vars,_key)) {
        global.fr_module_vars[$ _key][$ _field]=_value; return _value;
    }
    if(scrFRNTTEHandles(_kind,_module)) return scrFRNTTESet(_kind,_module,_field,_value);
    throw "Frontier writes unknown module "+_key+"."+string(_field);
}

function scrFRScriptExists(_kind,_module,_name) {
    var _key=scrFRModuleKey(_kind,_module);
    if(variable_struct_exists(global.fr_module_scripts,_key)) return (global.fr_initialized[$ _key]??false) && variable_struct_exists(global.fr_module_scripts[$ _key],_name);
    return scrFRNTTEScriptExists(_kind,_module,_name);
}

function scrFRScriptGet(_kind,_module,_name) {
    var _key=scrFRModuleKey(_kind,_module);
    if(variable_struct_exists(global.fr_module_scripts,_key)) return (global.fr_initialized[$ _key]??false)?global.fr_module_scripts[$ _key][$ _name]:undefined;
    if(scrFRNTTEScriptExists(_kind,_module,_name)) return [_kind,_module,_name];
    return undefined;
}

function scrFRModCall(_kind,_module,_name) {
    var _args=[];
    for(var _i=3;_i<argument_count;++_i) array_push(_args,argument[_i]);
    return scrFRModCallArray(_kind,_module,_name,_args);
}

function scrFRModCallArray(_kind,_module,_name,_args) {
    var _key=scrFRModuleKey(_kind,_module);
    // Frontier loads its Iris weapons unconditionally but calls five factories
    // from an otherwise optional external Defpack. Vendor only that authored
    // closure: claiming full Defpack existence would activate unrelated sodas,
    // Wormhole factories and other integrations that are not part of this port.
    if(_key=="mod:defpack tools") {
        switch(_name) {
            case "create_fire_bullet":case "create_gamma_bullet":
            case "create_toxic_bullet":case "create_psy_bullet":
            case "create_lightning_bullet":
                assert(array_length(_args)==2,"Frontier Iris factory expects source x,y: "+_name);
                _key="mod:Frontier_IrisProjectiles";
                break;
        }
    }
    if(!variable_struct_exists(global.fr_module_scripts,_key)) {
        if(scrFRNTTEHandles(_kind,_module)) return scrFRNTTECall(_kind,_module,_name,_args);
        throw "Frontier calls unknown module "+_key+"::"+string(_name);
    }
    // Static compilation registers future modules before their authored load
    // point. NTT cannot call those callbacks until the module starts loading.
    // Options deliberately dispatches to later augment modules during init.
    if(!(global.fr_initialized[$ _key]??false)) return undefined;
    // libGeneral/libPickups pass script_ref_create's third element back to
    // mod_script_call. It is already compiled native code, not a field name.
    // Keep the module's loaded-state check above for both representations.
    var _code=is_string(_name)?global.fr_module_scripts[$ _key][$ _name]:scrFRScriptRef(_name);
    // NTT hook dispatch permits an absent optional callback in a loaded mod.
    if(is_undefined(_code) || _code==0) return undefined;
    return scrFRInvokeHere(_code,_args);
}

function scrFRScriptCall(_reference) {
    var _args=[];
    for(var _i=1;_i<argument_count;++_i) array_push(_args,argument[_i]);
    return scrFRCallArray(_reference,_args);
}

function scrFRCallArray(_reference,_args) {
    if(is_undefined(_reference) || _reference==noone) return undefined;
    _reference=scrFRScriptRef(_reference);
    if(is_struct(_reference) && variable_struct_exists(_reference,"fr_code")) {
        var _joined=array_concat(_reference.fr_args,_args);
        return scrFRCallArray(_reference.fr_code,_joined);
    }
    if(is_array(_reference)) {
        // NTT uses [] to retire a callback after invoking it manually. The
        // authored Z-axis tosses do this before their native Destroy event.
        if(array_length(_reference)==0) return undefined;
        if(array_length(_reference)<3) throw "Malformed Frontier script reference";
        var _joined=[];
        for(var _i=3;_i<array_length(_reference);++_i) array_push(_joined,_reference[_i]);
        for(var _i=0;_i<array_length(_args);++_i) array_push(_joined,_args[_i]);
        var _code=_reference[2];
        if(is_string(_code)) return scrFRModCallArray(_reference[0],_reference[1],_code,_joined);
        if(_code==0) return undefined;
        return scrFRInvokeHere(_code,_joined);
    }
    if(is_struct(_reference)) throw "Malformed Frontier script-reference object";
    return scrFRInvokeHere(_reference,_args);
}

function scrFRScriptRefExt(_kind,_module,_name) { return [_kind,_module,_name]; }

function scrFRScopeExists(_value) {
    return is_struct(_value) || (!is_array(_value) && !is_string(_value) && !is_undefined(_value) && instance_exists(_value));
}

function scrFRIsInstanceValue(_value) {
    if(is_undefined(_value) || is_struct(_value) || is_array(_value)
       || is_string(_value) || is_method(_value) || is_ptr(_value)) return false;
    // The native runner can return ref instance handles. Resource indices
    // remain below the native instance-ID range and must stay array data.
    return real(_value)>=100000 && instance_exists(_value);
}

function scrFRRealInstanceList(_items) {
    var _result=[];
    for(var _i=0;_i<array_length(_items);++_i) array_push(_result,real(_items[_i]));
    return _result;
}

function scrFRScopeSame(_left,_right) {
    if(is_struct(_left) || is_struct(_right)) return _left==_right;
    if(!scrFRIsInstanceValue(_left) || !scrFRIsInstanceValue(_right)) return false;
    return real(_left.id)==real(_right.id);
}

function scrFRSelf(_scope) {
    if(is_struct(_scope)) return _scope[$ "fr_with_value"]??_scope;
    if(instance_exists(_scope)) return real(_scope.id);
    return _scope;
}

function scrFRWithValues(_value) {
    if(is_array(_value)) {
        var _result=[];
        for(var _i=0;_i<array_length(_value);++_i) {
            var _item=_value[_i];
            // An array with iterates DATA. Do not expand object-index values,
            // discard strings, flatten nested arrays, or remove repetitions.
            if(is_struct(_item)) array_push(_result,_item);
            else if(scrFRIsInstanceValue(_item)) array_push(_result,real(_item));
            else array_push(_result,{fr_with_value:_item});
        }
        return _result;
    }
    if(is_struct(_value)) return [_value];
    return scrFRInstances(_value);
}

function scrFRInstances(_target) {
    if(scrFRObjectSelector(_target))
        return scrFRRealInstanceList(scrFRObjectInstances(_target));
    if(is_array(_target)) {
        var _result=[],_seen={};
        for(var _i=0;_i<array_length(_target);++_i) {
            var _more=scrFRInstances(_target[_i]);
            for(var _j=0;_j<array_length(_more);++_j)
                if(scrFRInstanceUnionAdd(_seen,_more[_j])) array_push(_result,_more[_j]);
        }
        return _result;
    }
    if(is_struct(_target) || is_undefined(_target) || is_string(_target)) return [];
    if(_target>=100000) return instance_exists(_target)?[real(_target)]:[];
    var _result=[];
    // Source Wall enumeration is authored terrain used for decoration,
    // wall-mounted spawns and sprite/weather setup. Packed exterior exists
    // only for native collision; its rectangle origin is not another tile.
    with(_target) if(_target!=Wall || object_index!=NTTESolidWall) array_push(_result,real(id));
    return _result;
}

function scrFRLQHas(_value,_key) { return is_struct(_value) && variable_struct_exists(_value,string(_key)); }
function scrFRLQGet(_value,_key,_default=undefined) {
    return scrFRLQHas(_value,_key)?variable_struct_get(_value,string(_key)):_default;
}
function scrFRLQSet(_value,_key,_data) {
    assert(is_struct(_value),"Frontier LQ set requires an object");
    variable_struct_set(_value,string(_key),_data); return _data;
}
function scrFRLQSize(_value) { return is_struct(_value)?array_length(variable_struct_get_names(_value)):0; }
function scrFRLQKey(_value,_index) {
    var _keys=is_struct(_value)?variable_struct_get_names(_value):[];
    return (_index>=0 && _index<array_length(_keys))?_keys[_index]:undefined;
}
function scrFRLQValue(_value,_index) { return scrFRLQGet(_value,scrFRLQKey(_value,_index)); }
function scrFRLQClone(_value) {
    if(!is_struct(_value)) return _value;
    var _copy={},_keys=variable_struct_get_names(_value);
    for(var _i=0;_i<array_length(_keys);++_i) _copy[$ _keys[_i]]=_value[$ _keys[_i]];
    return _copy;
}

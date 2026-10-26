// Numeric native-inventory handles retain the original lightweight weapon
// object. Handles never join maxwep's random-drop enumeration.
function scrNTTEFullWeaponNativeInit() {
    if(!variable_global_exists("ntte_full_native_weapon_models")) {
        global.ntte_full_native_weapon_base=maxwep+1
        global.ntte_full_native_weapon_models=[]
    }
}
function scrNTTEFullWeaponIsNative(_weapon) {
    return is_numeric(_weapon) && variable_global_exists("ntte_full_native_weapon_models")
        && _weapon>=global.ntte_full_native_weapon_base
        && _weapon<global.ntte_full_native_weapon_base+array_length(global.ntte_full_native_weapon_models)
        && _weapon==floor(_weapon)
        && is_struct(global.ntte_full_native_weapon_models[_weapon-global.ntte_full_native_weapon_base])
}
function scrNTTEFullWeaponModel(_weapon) {
    return scrNTTEFullWeaponIsNative(_weapon)
        ? global.ntte_full_native_weapon_models[_weapon-global.ntte_full_native_weapon_base]:_weapon
}
function scrNTTEFullWeaponNative(_weapon) {
    // Original content may store a module name (Backpacker: "crabbone").
    // Resolve that source representation before native getters/index tables;
    // numeric IDs and physical structs retain their existing transfer path.
    if(is_string(_weapon)) {
        var _record=scrNTTEFullWeaponDropRecord(_weapon)
        if(is_undefined(_record)) throw "Unknown original weapon module at native inventory boundary: "+_weapon
        _weapon=_record.weapon
    }
    if(!is_struct(_weapon)) return _weapon
    scrNTTEFullWeaponNativeInit()
    var _models=global.ntte_full_native_weapon_models
    for(var _i=0;_i<array_length(_models);++_i)
        if(_models[_i]==_weapon) return global.ntte_full_native_weapon_base+_i
    var _handle=global.ntte_full_native_weapon_base+array_length(_models)
    array_push(global.ntte_full_native_weapon_models,_weapon)
    scrNTTEFullWeaponNativeRefresh(_handle)
    return _handle
}
// Explicit physical duplication only. Transfers preserve the existing handle.
function scrNTTEFullWeaponNativeCopy(_weapon) {
    var _model=scrNTTEFullWeaponModel(_weapon)
    return is_struct(_model) ? scrNTTEFullWeaponNative(json_parse(json_stringify(_model))):_model
}
function scrNTTEFullWeaponNativeState(_weapon) {
    var _handle=scrNTTEFullWeaponNative(_weapon),_model=scrNTTEFullWeaponModel(_handle)
    if(!is_struct(_model)) return undefined
    if(!variable_struct_exists(_model,"ntte_native_state") || !is_struct(_model.ntte_native_state)) {
        _model.ntte_native_state=scrNTTENewState(scrNTTEFullWeaponRaw(_model))
        _model.ntte_native_state.weapon=_handle
    }
    _model.ntte_native_state.weapon=_handle
    return _model.ntte_native_state
}
function scrNTTEFullWeaponSwapSound(_weapon) {
    var _model=scrNTTEFullWeaponModel(_weapon)
    while(scrNTTEFullWeaponHasMerge(_model)==true) {
        // temerge_weapon_swap: play each stock at half volume, then return
        // the final front sound to the original native caller.
        snd_play(scrNTTEFullWeaponSkinStockSwap(_model),1,0.5)
        _model=scrNTTEFullWeaponMergedPart(_model)
    }
    return scrNTTEFullWeaponSkinStockSwap(_model)
}
function scrNTTEFullWeaponNativeSprite(_weapon,_held=false,_state=undefined,_hud=false) {
    var _model=scrNTTEFullWeaponModel(_weapon),_parts=[]
    while(true) {
        var _raw=scrNTTEFullWeaponRaw(_model)
        var _sprite=_raw==wep_none ? mskNone:(_hud ? scrNTTEFullWeaponHUDSprite(_raw):(_held ? scrNTTEFullWeaponStateSprite(_raw,
            is_struct(_model) ? scrNTTEFullWeaponNativePartState(_model,_state):_state):scr_weapon_get_sprite(_raw))
        )
        // A quest part can use the ordinary bone raw ID with its own type_index.
        // Resolve that physical model, rather than losing it at the raw-ID boundary.
        if(scrNTTEFullCrabboneIs(_model))
            _sprite=scrNTTEFullBoneWeaponMetadata(_model,_hud?"hud":"sprite",_sprite)
        _sprite=scrNTTEFullWeaponSourceSprite(_model,_state,_sprite,_hud)
        _sprite=scrNTTEFullTunnellerMetadata(_model,_hud?"hud":"sprite",_sprite)
        _sprite=scrNTTEFullWeaponSkinSprite(_model,_sprite,_hud)
        array_push(_parts,_sprite)
        if(scrNTTEFullWeaponHasMerge(_model)!=true) break
        _model=scrNTTEFullWeaponMergedPart(_model)
    }
    return scrNTTEFullMergeSpriteList(_parts)
}
function scrNTTEFullWeaponNativePartState(_model,_fallback=undefined) {
    var _state=scrNTTEFullValue(_model,"ntte_native_state",_fallback)
    if(!is_struct(_state)) return _state
    // StateSprite compares against the raw type. A shallow view retains all
    // state values while keeping the canonical physical state's handle intact.
    var _view=struct_clone(_state)
    _view.weapon=scrNTTEFullWeaponRaw(_model)
    _view.ntte_physical_state=_state
    _view.ntte_physical_model=_model
    return _view
}
function scrNTTEFullWeaponNativeProperty(_weapon,_field) {
    var _model=scrNTTEFullWeaponModel(_weapon),_raw=scrNTTEFullWeaponRaw(_model)
    switch(_field) {
        case "name":return scrNTTEFullMergedName(_model)
        case "text":return scrNTTEFullMergedText(_model)
        case "sprite":return scrNTTEFullWeaponNativeSprite(_model)
        case "loadout":return scrNTTEFullMergedLoadoutSprite(_model)
        case "swap":return scrNTTEFullWeaponSwapSound(_model)
        case "assist":return scr_weapon_has_assist_disabled(_raw)
        default:return scrNTTEFullWeaponMergeProperty(_model,_field)
    }
}
function scrNTTEFullWeaponNativeRefresh(_handle) {
    // Compatibility for legacy table consumers. Public getters recompute the
    // live model, so toggling/appending merges never depends on these caches.
    var _model=scrNTTEFullWeaponModel(_handle),_raw=scrNTTEFullWeaponRaw(_model)
    wep_name[_handle]=scrNTTEFullMergedName(_model);wep_text[_handle]=scrNTTEFullTunnellerCachedText(_model)
    wep_swap[_handle]=wep_swap[_raw];wep_sprt[_handle]=scrNTTEFullWeaponNativeSprite(_model)
    wep_lout[_handle]=scrNTTEFullMergedLoadoutSprite(_model)
    wep_type[_handle]=scrNTTEFullWeaponMergeProperty(_model,"type")
    wep_cost[_handle]=scrNTTEFullWeaponMergeProperty(_model,"cost")
    wep_rads[_handle]=scrNTTEFullWeaponMergeProperty(_model,"rads")
    wep_area[_handle]=scrNTTEFullWeaponMergeProperty(_model,"area")
    wep_load[_handle]=scrNTTEFullWeaponMergeProperty(_model,"load")
    wep_auto[_handle]=scrNTTEFullWeaponMergeProperty(_model,"auto")
    wep_gold[_handle]=scrNTTEFullWeaponMergeProperty(_model,"gold")
    wep_mele[_handle]=scrNTTEFullWeaponMergeProperty(_model,"melee")
    wep_naim[_handle]=wep_naim[_raw]
}
// A JSON graph keeps aliases between registered lightweight objects and their
// merged components intact. Direct json_stringify(models) duplicates them.
function scrNTTEFullWeaponNativeEncode(_value,_graph) {
    var _array=is_array(_value)
    if(!_array && !is_struct(_value)) return {type:0,value:_value}
    if(is_method(_value)) return {type:0,value:undefined}
    for(var _i=0;_i<array_length(_graph.originals);++_i)
        if(is_array(_graph.originals[_i])==_array && _graph.originals[_i]==_value) return {type:1,index:_i}
    var _index=array_length(_graph.originals),_node={array:_array,entries:[]}
    array_push(_graph.originals,_value);array_push(_graph.nodes,_node)
    if(_array) {
        for(var _i=0;_i<array_length(_value);++_i) array_push(_node.entries,scrNTTEFullWeaponNativeEncode(_value[_i],_graph))
    }
    else {
        var _keys=variable_struct_get_names(_value)
        for(var _i=0;_i<array_length(_keys);++_i) {
            var _key=_keys[_i],_entry=variable_struct_get(_value,_key)
            if(!is_method(_entry)) array_push(_node.entries,[_key,scrNTTEFullWeaponNativeEncode(_entry,_graph)])
        }
    }
    return {type:1,index:_index}
}
function scrNTTEFullWeaponNativeDecode(_entry,_objects) {
    return _entry.type==1 ? _objects[_entry.index]:_entry.value
}
function scrNTTEFullWeaponNativeExport() {
    scrNTTEFullWeaponNativeInit()
    var _graph={originals:[],nodes:[]},_root=scrNTTEFullWeaponNativeEncode(global.ntte_full_native_weapon_models,_graph)
    return {version:1,base:global.ntte_full_native_weapon_base,root:_root,nodes:_graph.nodes}
}
function scrNTTEFullWeaponNativeImport(_data) {
    global.ntte_weapon_load_rebase=undefined;
    if(!is_struct(_data) || !is_array(scrNTTEFullValue(_data,"nodes",undefined))) return;
    var _nodes=_data.nodes,_objects=[]
    for(var _i=0;_i<array_length(_nodes);++_i) array_push(_objects,_nodes[_i].array ? []:{})
    for(var _i=0;_i<array_length(_nodes);++_i) {
        var _node=_nodes[_i],_object=_objects[_i]
        for(var _j=0;_j<array_length(_node.entries);++_j) {
            var _entry=_node.entries[_j]
            if(_node.array) array_push(_object,scrNTTEFullWeaponNativeDecode(_entry,_objects))
            else variable_struct_set(_object,_entry[0],scrNTTEFullWeaponNativeDecode(_entry[1],_objects))
        }
    }
    scrUGWeaponImportRebase(_data,_objects);
    global.ntte_full_native_weapon_base=max(maxwep+1,_data.base)
    global.ntte_full_native_weapon_models=scrNTTEFullWeaponNativeDecode(_data.root,_objects)
    var _models=global.ntte_full_native_weapon_models
    for(var _i=0;_i<array_length(_models);++_i) {
        var _model=_models[_i],_handle=global.ntte_full_native_weapon_base+_i
        if(!is_struct(_model)) continue
        scrNTTEFullWeaponNativeRefresh(_handle)
        if(is_struct(scrNTTEFullValue(_model,"ntte_native_state",undefined)))
            _model.ntte_native_state=scrNTTEStateRestored(_model.ntte_native_state)
    }
}
function scrNTTEFullWeaponNativeNormalizeInventory() {
    wep=scrNTTEFullWeaponNative(wep);bwep=scrNTTEFullWeaponNative(bwep)
    for(var _i=0;_i<array_length(extra_weps);++_i) extra_weps[_i]=scrNTTEFullWeaponNative(extra_weps[_i])
}
function scrNTTEFullWeaponNativeNormalizePickup() {
    if(!is_struct(wep) && !scrNTTEFullWeaponIsNative(wep)) return;
    wep=scrNTTEFullWeaponNative(wep)
    var _state=scrNTTEFullValue(id,"ntte_state",undefined),_model=scrNTTEFullWeaponModel(wep)
    if(is_struct(_state) && (_state.weapon==wep
        || (scrNTTEFullValue(id,"ntte_throw_pickup",false) && _state.weapon==scrNTTEFullWeaponRaw(wep)))) {
        // Thrown-weapon landing may install a restored state after factory
        // creation. Adopt that actual physical state instead of discarding it.
        _model.ntte_native_state=_state;_state.weapon=wep
    }
    ntte_state=scrNTTEFullWeaponNativeState(wep)
    name=scr_weapon_get_name(wep);type=scr_weapon_get_type(wep);sprite_index=scr_weapon_get_sprite(wep)
}
function scrNTTEFullWeaponNativeAfterLoad() {
    if(scrNTTEFullWeaponIsNative(wep)) ntte_state=scrNTTEFullWeaponNativeState(wep)
    if(scrNTTEFullWeaponIsNative(bwep)) bntte_state=scrNTTEFullWeaponNativeState(bwep)
    for(var _i=0;_i<array_length(extra_weps);++_i)
        if(scrNTTEFullWeaponIsNative(extra_weps[_i])) ntte_extra_states[_i]=scrNTTEFullWeaponNativeState(extra_weps[_i])
}

function scrNTTEFullMergedNativeInventoryUnitTests() {
    scrNTTEFullWeaponNativeInit()
    var _registry=global.ntte_full_native_weapon_models,_registry_count=array_length(_registry),
        _registry_base=global.ntte_full_native_weapon_base,_max=maxwep
    var _game=scrNTTEFullAreaGeneratorSnapshot(GameCont),_players=scrNTTEFullAreaGeneratorSnapshot(Player),
        _keys=scrNTTEFullAreaGeneratorSnapshot(KeyCont),_before=scrNTTEFullInstances(all),_buffer=-1
    try {
        var _front={wep:wep_shotgun,ammo:7},_model=scrNTTEFullWeaponMerge(wep_revolver,_front)
        var _handle=scrNTTEFullWeaponNative(_model),_front_handle=scrNTTEFullWeaponNative(_front)
        assert(_handle>maxwep && maxwep==_max && is_numeric(_handle) && scr_weapon_is_valid(_handle)
            && scrNTTEFullWeaponNative(_model)==_handle && scrNTTEFullWeaponModel(_handle)==_model,
            "Native LWO registry changed source identity or polluted maxwep drop enumeration")
        var _copy=scrNTTEFullWeaponNativeCopy(_handle),_state=scrNTTEFullWeaponNativeState(_handle)
        _state.ammo=9;_state.charge=3
        assert(_copy!=_handle && scrNTTEFullWeaponModel(_copy)!=_model
            && scrNTTEFullWeaponNativeState(_copy)!=_state && scrNTTEFullWeaponNativeState(_copy).weapon==_copy,
            "Independent physical weapon copies shared a handle or native state")
        assert(scr_weapon_get_type(_handle)==scrNTTEFullWeaponMergeProperty(_model,"type")
            && scr_weapon_get_cost(_handle)==scrNTTEFullWeaponMergeProperty(_model,"cost")
            && scr_weapon_get_sprite(_handle)==scrNTTEFullMergeSpriteList([
                scr_weapon_get_sprite(wep_revolver),scr_weapon_get_sprite(wep_shotgun)]),
            "Native merged getters flattened source stats or actual composed weapon art")
        scrNTTEFullWeaponMergeActive(_handle,false)
        assert(scr_weapon_get_type(_handle)==scr_weapon_get_type(wep_revolver)
            && scr_weapon_get_sprite(_handle)==scr_weapon_get_sprite(wep_revolver),
            "Native merged getters cached stale activation state")
        scrNTTEFullWeaponMergeActive(_handle,true)
        var _player=instance_find(Player,0)
        _player.x=43216;_player.y=43216;_player.wep=wep_revolver;_player.bwep=wep_none
        _player.curse=0;_player.bcurse=0;_player.can_pick=true;_player.max_extra_weps=0;_player.extra_weps=[]
        _player.ntte_state=scrNTTENewState(wep_revolver);_player.bntte_state=undefined
        KeyCont.press_pick[_player.index]=false;KeyCont.press_swap[_player.index]=false
        var _drop=scrWeaponPickupCreate(_player.x,_player.y,_model)
        _drop.speed=0;_drop.autopick=true
        assert(_drop.wep==_handle && _drop.ntte_state==_state,"Native pickup lost physical model/state")
        with(_drop) with(_player) event_perform(ev_collision,WepPickup)
        assert(!instance_exists(_drop) && _player.wep==_handle && _player.ntte_state==_state
            && _player.bwep==wep_revolver,"Real native collision did not equip the original merged weapon")
        with(_player) scrSwapWeps(false)
        assert(_player.bwep==_handle && _player.bntte_state==_state,"Native swap detached merged slot state")
        with(_player) scrSwapWeps(false)
        var _ordinary=scrWeaponPickupCreate(_player.x,_player.y,wep_wrench)
        _ordinary.speed=0;_ordinary.autopick=true
        with(_ordinary) with(_player) event_perform(ev_collision,WepPickup)
        var _ground=noone
        with(WepPickup) if(wep==_handle) {_ground=id;break}
        assert(instance_exists(_ground) && _ground.ntte_state==_state && _state.ammo==9,
            "Replacing an equipped merge failed its actual ground/state transfer")
        _player.bwep=wep_none
        _ground.autopick=true;_ground.speed=0
        with(_ground) with(_player) event_perform(ev_collision,WepPickup)
        assert(_player.wep==_handle && _player.ntte_state==_state,"Ground re-pickup replaced merged physical identity")
        with(_player) {scrExtraWepsReset();scrExtraWepStoreCurrent()}
        assert(_player.extra_weps[0]==_handle && _player.ntte_extra_states[0]==_state,
            "Extra native weapon slot lost physical merged state")
        // Real buffer/JSON continuation, then native player serialization and
        // loader. Aliased front models must remain the same reconstructed LWO.
        var _encoded=json_parse(json_stringify(scrNTTEFullWeaponNativeExport()))
        _buffer=buffer_create(1024,buffer_grow,1)
        scrSavegamePlayers(_buffer,false);buffer_seek(_buffer,buffer_seek_start,0)
        scrNTTEFullWeaponNativeImport(_encoded)
        var _restored=scrNTTEFullWeaponModel(_handle),_restored_state=scrNTTEFullWeaponNativeState(_handle)
        assert(_restored!=_model && scrNTTEFullWeaponMergedPart(_handle)==scrNTTEFullWeaponModel(_front_handle)
            && _restored_state.ammo==9 && scrNTTEFullWeaponNative(_restored)==_handle,
            "JSON continuation lost handle mappings, merged part alias or native physical state")
        scrSavegamePlayers(_buffer,true)
        var _loaded=noone
        with(Player) if(array_get_index(_before,id)<0) {_loaded=id;break}
        assert(instance_exists(_loaded) && _loaded.wep==_handle && _loaded.ntte_state==_restored_state
            && _loaded.extra_weps[0]==_handle && _loaded.ntte_extra_states[0]==_restored_state,
            "Actual native player continuation did not rebind equipped/extra state to canonical merged LWO")
    }
    finally {
        if(buffer_exists(_buffer)) buffer_delete(_buffer)
        var _after=scrNTTEFullInstances(all)
        for(var _i=array_length(_after)-1;_i>=0;--_i)
            if(array_get_index(_before,_after[_i])<0 && instance_exists(_after[_i])) instance_destroy(_after[_i],false)
        scrNTTEFullAreaGeneratorRestore(_game);scrNTTEFullAreaGeneratorRestore(_players);scrNTTEFullAreaGeneratorRestore(_keys)
        array_resize(_registry,_registry_count)
        global.ntte_full_native_weapon_base=_registry_base;global.ntte_full_native_weapon_models=_registry
    }
    scrNTTESmokeLog("FULL MERGED NATIVE INVENTORY: identity handles without maxwep growth, independent copies, live model/art, actual pickup/swap/ground/extra transfer and native buffer/JSON player continuation OK @"+string(30/timescale))
}

// ntte.mod126..150/2628..2647 and temenu293..297/550..618.
// The native golden slot remains numeric. Source main is stored separately as
// the already-verified native weapon graph, never as a process-local handle.
function scrNTTEFullLoadoutWeaponKey(_race) { return "loadout:wep:"+string(_race) }
function scrNTTEFullLoadoutWeaponEligible(_weapon) {
    var _raw=scrNTTEFullWeaponRaw(_weapon)
    return scr_weapon_is_golden(_weapon)!=0 &&
        ((_raw>=wep_ntte_rogue_carbine && _raw<=maxwep) || scrNTTEFullWeaponHasMerge(_weapon)!=false)
}
function scrNTTEFullLoadoutWeaponPack(_weapon) {
    var _graph={originals:[],nodes:[]},_root=scrNTTEFullWeaponNativeEncode(scrNTTEFullWeaponModel(_weapon),_graph)
    return {version:1,root:_root,nodes:_graph.nodes}
}
function scrNTTEFullLoadoutWeaponUnpack(_data) {
    if(!is_struct(_data) || scrNTTEFullValue(_data,"version",0)!=1
        || !is_array(scrNTTEFullValue(_data,"nodes",undefined))) return wep_none
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
    scrFRContinueMergedWeaponsRestore(_objects);
    return scrNTTEFullWeaponNativeDecode(_data.root,_objects)
}
// Validate only the weapon links which native getters traverse. Shared
// metadata/state references are harmless and must retain their physical aliases.
// Keep both walks iterative so damaged graphs cannot recurse or loop forever.
function scrNTTEFullProtoWeaponTopologyValid(_weapon) {
    var _part=scrNTTEFullWeaponModel(_weapon),_parts=[];
    while(true) {
        if(is_struct(_part)) {
            for(var _i=0;_i<array_length(_parts);++_i)
                if(_parts[_i]==_part) return false;
            array_push(_parts,_part);
        }
        var _raw=_part,_wrappers=[];
        while(is_struct(_raw)) {
            for(var _i=0;_i<array_length(_wrappers);++_i)
                if(_wrappers[_i]==_raw) return false;
            array_push(_wrappers,_raw);
            if(!variable_struct_exists(_raw,"wep")) return false;
            _raw=_raw.wep;
        }
        if(!is_numeric(_raw)) return false;
        if(_raw!=floor(_raw) || _raw<0 || _raw>maxwep) return false;
        if(!is_struct(_part)) return true;
        if(!variable_struct_exists(_part,"temerge")) return true;
        var _merge=_part.temerge;
        if(!is_struct(_merge)) return true;
        if(!variable_struct_exists(_merge,"is_active")) return false;
        if(!variable_struct_exists(_merge,"wep")) return false;
        var _fronts=_merge.wep;
        if(!is_array(_fronts)) return false;
        if(array_length(_fronts)<1) return false;
        _part=scrNTTEFullWeaponModel(_fronts[0]);
    }
}
// The Proto Chest survives runs/processes; an inventory handle does not.
// Keep its original numeric slot as a backward-compatible stock fallback,
// and put the complete physical weapon graph in a separate JSON string.
function scrNTTEFullProtoWeaponSave(_weapon,_replace=false) {
    // A scalar equal to the permanent slot came from that durable slot,
    // not from a proven live transfer. Preserve it until the chest restores it,
    // even if a new physical model now occupies the same old temporary number.
    // Only explicit Room End storage may replace this unopened snapshot.
    var _stored=save_get_value("etc","protowep",wep_rusty_revolver),
        _snapshot=save_get_value("etc","protowep_model","");
    if(!_replace && _weapon==_stored && !is_struct(_weapon)) return;
    var _model=scrNTTEFullWeaponModel(_weapon);
    if(!scrNTTEFullProtoWeaponTopologyValid(_model)) _model=wep_rusty_revolver;
    var _raw=scrNTTEFullWeaponRaw(_model);
    if(!scr_weapon_is_valid(_model)) {_model=wep_rusty_revolver;_raw=_model;}
    _snapshot=is_struct(_model)?json_stringify(scrNTTEFullLoadoutWeaponPack(_model)):"";
    save_set_value("etc","protowep",_raw);
    save_set_value("etc","protowep_model",_snapshot);
}
function scrNTTEFullProtoWeaponRestore(_weapon) {
    var _saved=save_get_value("etc","protowep",wep_rusty_revolver),
        _snapshot=save_get_value("etc","protowep_model","");
    // A live chest transfer keeps its existing physical handle. Only the
    // matching durable numeric slot may adopt the saved reset snapshot.
    if(_weapon==_saved && is_string(_snapshot) && string_length(_snapshot)>0) {
        try {
            var _model=scrNTTEFullLoadoutWeaponUnpack(json_parse(_snapshot));
            if(!scrNTTEFullProtoWeaponTopologyValid(_model))
                throw "Invalid Proto Chest weapon topology";
            if(is_struct(_model) && scr_weapon_is_valid(_model)) {
                var _part=_model;
                while(true) {
                    if(is_struct(_part) && is_struct(scrNTTEFullValue(_part,"ntte_native_state",undefined))) {
                        _part.ntte_native_state.weapon=scrNTTEFullWeaponNative(_part);
                        _part.ntte_native_state=scrNTTEStateRestored(_part.ntte_native_state);
                    }
                    if(scrNTTEFullWeaponHasMerge(_part)==false) break;
                    _part=scrNTTEFullWeaponMergedPart(_part);
                }
                return scrNTTEFullWeaponNative(_model);
            }
        } catch(_error) {
            // A damaged companion cannot invalidate an ordinary legacy slot.
        }
    }
    if(_weapon==_saved && !is_struct(_weapon)) {
        // Permanent scalar slots are static IDs only. A currently registered
        // physical handle may merely reuse an old process's numeric value;
        // its unrelated model cannot reconstruct the lost stored composition.
        // Historical scalars within today's static ID range are ambiguous:
        // preserve ordinary weapon compatibility rather than guess a fusion.
        return is_numeric(_weapon) && _weapon==floor(_weapon)
            && _weapon>0 && _weapon<=maxwep ? _weapon:wep_rusty_revolver;
    }
    // A different valid handle is a current-run live transfer. Keep its
    // physical object, aliases and state rather than substituting a snapshot.
    if(!scrNTTEFullProtoWeaponTopologyValid(_weapon)) return wep_rusty_revolver;
    return scr_weapon_is_valid(_weapon)?scrNTTEFullWeaponNative(_weapon):wep_rusty_revolver;
}

function scrNTTEFullLoadoutWeaponStored(_race) {
    var _key=scrNTTEFullLoadoutWeaponKey(_race),_data=scrNTTEFullUnlockGet(_key+":main",undefined)
    if(!is_struct(_data)) return wep_none
    if(!variable_global_exists("ntte_full_loadout_weapon_cache") || !is_struct(global.ntte_full_loadout_weapon_cache)) global.ntte_full_loadout_weapon_cache={}
    var _cached=scrNTTEFullValue(global.ntte_full_loadout_weapon_cache,string(_race),undefined)
    if(!is_struct(_cached) || _cached.data!=_data) {
        var _model=scrNTTEFullLoadoutWeaponUnpack(_data)
        if(_model==wep_none || !scrNTTEFullLoadoutWeaponEligible(_model)) return wep_none
        _cached={data:_data,weapon:scrNTTEFullWeaponNative(_model)}
        global.ntte_full_loadout_weapon_cache[$ string(_race)]=_cached
    }
    return _cached.weapon
}
// Ownership compares the durable composition, not a numeric handle or
// mutable physical wrapper. Room continuation rebuilds those wrappers.
function scrNTTEFullLoadoutWeaponSignature(_weapon) {
    var _out=[],_part=scrNTTEFullWeaponModel(_weapon);
    while(true) {
        array_push(_out,[scrNTTEFullWeaponRaw(_part),scrNTTEFullWeaponSkinKey(_part),
            scrNTTEFullValue(_part,"type_index",-1),scrNTTEFullWeaponHasMerge(_part)]);
        if(scrNTTEFullWeaponHasMerge(_part)==false) break;
        _part=scrNTTEFullWeaponMergedPart(_part);
    }
    return json_stringify(_out);
}
function scrNTTEFullLoadoutWeaponStore(_race,_weapon) {
    // A custom selection grants temporary use, never a permanent starting
    // weapon. This shared boundary also covers native stored-weapon setters.
    if(scrGameIsCustomMode()) return false
    if(!scrNTTEFullLoadoutWeaponEligible(_weapon)) return false
    var _key=scrNTTEFullLoadoutWeaponKey(_race),_data=scrNTTEFullLoadoutWeaponPack(_weapon),
        _old=scrNTTEFullUnlockGet(_key+":main",undefined)
    // Source unlock_set compares the physical LWO identity. A weapon already
    // stored/started in this run must not overwrite its reset snapshot merely
    // because charges or native transient handles changed during play.
    var _cached=variable_global_exists("ntte_full_loadout_weapon_cache")
        ? scrNTTEFullValue(global.ntte_full_loadout_weapon_cache,string(_race),undefined):undefined
    // A live physical object may acquire a different fusion; compare its durable signature too.
    if(is_struct(_old) && scrNTTEFullLoadoutWeaponSignature(scrNTTEFullLoadoutWeaponUnpack(_old))
        ==scrNTTEFullLoadoutWeaponSignature(_weapon)) return false
    var _data=scrNTTEFullLoadoutWeaponPack(_weapon)
    scrNTTEFullUnlockSet(_key+":main",_data)
    scrNTTEFullLoadoutSet(_key,"main")
    scrNTTEFullLoadoutWeaponStored(_race)
    global.ntte_full_loadout_weapon_cache[$ string(_race)].live_model=scrNTTEFullWeaponModel(_weapon)
    return true
}
function scrNTTEFullLoadoutWeaponSelect(_race,_weapon) {
    var _main=scrNTTEFullLoadoutWeaponStored(_race)
    if(_main==wep_none || _weapon!=_main) return false
    scrNTTEFullLoadoutSet(scrNTTEFullLoadoutWeaponKey(_race),"main")
    return true
}
function scrNTTEFullLoadoutWeaponCurrent(_race,_native) {
    if(scrNTTEFullLoadoutGet(scrNTTEFullLoadoutWeaponKey(_race),"")=="main") {
        var _main=scrNTTEFullLoadoutWeaponStored(_race)
        if(_main!=wep_none) return _main
    }
    return _native
}
function scrNTTEFullLoadoutWeaponSlots(_race,_default,_gold) {
    var _slots=[_default,_gold],_main=scrNTTEFullLoadoutWeaponStored(_race)
    if(_main!=wep_none) array_push(_slots,_main)
    return _slots
}
function scrNTTEFullLoadoutWeaponGenerationStart() {
    // Each represented body contributes its two physical slots in normal
    // runs. The shared Store boundary rejects temporary custom equipment.
    with(Player) {
        var _weapons=[wep,bwep]
        // Keep the first eligible physical slot as the selected storage
        // candidate even when it was already stored in the previous room.
        for(var _i=0;_i<2;++_i) if(scrNTTEFullLoadoutWeaponEligible(_weapons[_i])) {
            scrNTTEFullLoadoutWeaponStore(race,_weapons[_i]);
            break;
        }
    }
}
function scrNTTEFullLoadoutWeaponGameStart() {
    with(Player) {
        if(scrNTTEFullValue(id,"ntte_loadout_weapon_started",false)) continue
        ntte_loadout_weapon_started=true
        // An explicit custom primary, including an empty slot, takes priority
        // over the character's saved starting weapon.
        if(scrCustomParam("wep",-1)>=0) continue
        var _key=scrNTTEFullLoadoutWeaponKey(race)
        if(scrNTTEFullLoadoutGet(_key,"")!="main") continue
        var _data=scrNTTEFullUnlockGet(_key+":main",undefined),_model=scrNTTEFullLoadoutWeaponUnpack(_data)
        if(_model==wep_none || !scrNTTEFullLoadoutWeaponEligible(_model)) continue
        var _type=scr_weapon_get_type(wep)
        if(_type!=Ammo.None) ammo[_type]=max(0,ammo[_type]-scrFRAmmoRead(id,"typ_ammo",_type)*3)
        // Every body and every run receives a separate physical model, so
        // mutable charges/merge cooldowns cannot consume the saved template.
        wep=scrNTTEFullWeaponNative(_model)
        scrNTTEFullLoadoutWeaponStored(race)
        global.ntte_full_loadout_weapon_cache[$ string(race)].live_model=_model
        var _part=_model
        while(true) {
            if(is_struct(_part) && is_struct(scrNTTEFullValue(_part,"ntte_native_state",undefined))) {
                _part.ntte_native_state.weapon=scrNTTEFullWeaponNative(_part)
                _part.ntte_native_state=scrNTTEStateRestored(_part.ntte_native_state)
            }
            if(scrNTTEFullWeaponHasMerge(_part)==false) break
            _part=scrNTTEFullWeaponMergedPart(_part)
        }
        ntte_state=scrNTTEFullWeaponNativeState(wep)
        _type=scr_weapon_get_type(wep)
        if(_type!=Ammo.None) ammo[_type]+=round(scrFRAmmoRead(id,"typ_ammo",_type)*3)
    }
}

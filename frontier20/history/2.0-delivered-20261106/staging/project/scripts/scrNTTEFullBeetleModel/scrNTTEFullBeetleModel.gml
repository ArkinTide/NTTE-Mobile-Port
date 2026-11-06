// beetle.race.gml 328..819: ordered part selection, original max-HP pricing
// and the two separate per-run merge histories. This is the inventory model;
// native equip/fire adapters must be present before the race is available.
function scrNTTEFullBeetleMenuNew() {
    return {is_open:false,scale:0,last_wkick:undefined,last_bwkick:undefined,last_canfire:undefined,last_canscope:undefined,
        wep:wep_none,bwep:wep_none,curse:0,bcurse:0,selection_angle:0,selection_state:undefined,
        selection_trail_last_x:x,selection_trail_last_y:y,selection_icon_scale:0,merging_scale:0,merging_part_num:0,
        selection_wep_info:{list:[],index:0,primary_count:0},
        merging_wep_info:{index_list:[],key_list:[],type_key_list:[],health_cost:0,name:"",type:Ammo.None,cost:0,load:0,sprite:mskNone}}
}
function scrNTTEFullBeetleClone(_weapon) {
    _weapon=scrNTTEFullWeaponModel(_weapon)
    return is_struct(_weapon) ? json_parse(json_stringify(_weapon)):_weapon
}
function scrNTTEFullBeetleUnmerge(_weapon) {
    var _copy=scrNTTEFullBeetleClone(_weapon)
    if(is_struct(_copy) && variable_struct_exists(_copy,"temerge")) variable_struct_remove(_copy,"temerge")
    return _copy
}
function scrNTTEFullBeetleParts(_weapon,_curse=0) {
    _weapon=scrNTTEFullWeaponModel(_weapon)
    var _parts=[]
    while(true) {
        if(scrNTTEFullWeaponRaw(_weapon)!=wep_none) array_push(_parts,_weapon)
        if(scrNTTEFullWeaponHasMerge(_weapon)!=false && _curse<=0) _weapon=scrNTTEFullWeaponMergedPart(_weapon)
        else break
    }
    return _parts
}
function scrNTTEFullBeetleMenuInventory(_primary,_secondary,_curse=0,_bcurse=0) {
    var _a=scrNTTEFullBeetleParts(_primary,_curse),_b=scrNTTEFullBeetleParts(_secondary,_bcurse)
    return {list:array_concat(_a,_b),index:0,primary_count:array_length(_a)}
}
function scrNTTEFullBeetleSelection(_inventory,_indices,_curse=0,_bcurse=0) {
    var _parts=[],_keys=[],_types=[],_merged=wep_none
    for(var _i=0;_i<array_length(_indices);++_i) {
        var _index=_indices[_i]
        if(_index<0 || _index>=array_length(_inventory.list) || array_get_index(_indices,_index)!=_i) throw "Invalid or duplicate Beetle part selection"
        var _part=_inventory.list[_index],_cursed=(_index<_inventory.primary_count ? _curse:_bcurse)>0
        _part=_cursed ? scrNTTEFullBeetleClone(_part):scrNTTEFullBeetleUnmerge(_part)
        array_push(_parts,_part)
        array_push(_types,string(scrNTTEFullWeaponMergeProperty(_part,"type")))
        var _raw_chain=_part
        while(true) {
            array_push(_keys,string(scrNTTEFullWeaponRaw(_raw_chain)))
            if(scrNTTEFullWeaponHasMerge(_raw_chain)!=false) _raw_chain=scrNTTEFullWeaponMergedPart(_raw_chain)
            else break
        }
        _merged=(_i==0) ? _part:scrNTTEFullWeaponMerge(_merged,_part)
    }
    return {parts:_parts,key_list:_keys,type_key_list:_types,weapon:_merged,health_cost:max(0,2*(array_length(_keys)-1))}
}
function scrNTTEFullBeetleHistoryKnown(_history,_keys) {
    var _node=_history
    for(var _i=0;_i<array_length(_keys);++_i) {
        if(!is_struct(_node) || !variable_struct_exists(_node,_keys[_i])) return false
        _node=variable_struct_get(_node,_keys[_i])
    }
    return is_struct(_node) && variable_struct_exists(_node,"?") && variable_struct_get(_node,"?")
}
function scrNTTEFullBeetleHistoryRemember(_history,_keys) {
    var _node=_history
    for(var _i=0;_i<array_length(_keys);++_i) {
        if(!variable_struct_exists(_node,_keys[_i])) variable_struct_set(_node,_keys[_i],{})
        _node=variable_struct_get(_node,_keys[_i])
    }
    variable_struct_set(_node,"?",true)
}
function scrNTTEFullBeetleQuote(_selection,_max_hp,_throne_butt,_key_history,_type_history) {
    var _known=scrNTTEFullBeetleHistoryKnown(_throne_butt ? _type_history:_key_history,_throne_butt ? _selection.type_key_list:_selection.key_list)
    var _cost=_known ? 0:_selection.health_cost
    return {cost:_cost,can_merge:_known || _max_hp>_cost,known:_known}
}
function scrNTTEFullBeetleModelTests() {
    var _stock=scrNTTEFullWeaponMerge(wep_revolver,wep_shotgun),_front=scrNTTEFullWeaponMerge(wep_crossbow,wep_wrench)
    var _snapshot=json_stringify(_stock),_inv=scrNTTEFullBeetleMenuInventory(_stock,_front,0,0)
    assert(array_length(_inv.list)==4 && _inv.primary_count==2,"Beetle did not expose all uncursed parts in native slot order")
    var _selected=scrNTTEFullBeetleSelection(_inv,[2,0,3]),_chain=_selected.weapon
    assert(scrNTTEFullWeaponRaw(_chain)==wep_crossbow && scrNTTEFullWeaponRaw(scrNTTEFullWeaponMergedPart(_chain))==wep_revolver
        && scrNTTEFullWeaponRaw(scrNTTEFullWeaponMergedPart(_chain,2))==wep_wrench && _selected.health_cost==4,"Beetle selected part order or original 2HP-per-extra-part fee changed")
    assert(json_stringify(_stock)==_snapshot,"Beetle preview detached actual inventory merge parts")
    var _cursed_inv=scrNTTEFullBeetleMenuInventory(_stock,wep_none,1,0)
    assert(array_length(_cursed_inv.list)==1,"Beetle exposed a cursed weapon's individual components")
    var _cursed=scrNTTEFullBeetleSelection(_cursed_inv,[0],1,0)
    assert(scrNTTEFullWeaponHasMerge(_cursed.weapon)==true && _cursed.health_cost==2,"Beetle lost a cursed whole weapon's component cost")
    var _keys={},_types={},_quote=scrNTTEFullBeetleQuote(_selected,4,false,_keys,_types)
    assert(!_quote.can_merge && _quote.cost==4,"Beetle allowed spending the last maximum HP")
    assert(!scrNTTEFullBeetleHistoryKnown(_keys,_selected.key_list),"An unaffordable Beetle preview altered merge history")
    scrNTTEFullBeetleHistoryRemember(_keys,_selected.key_list); scrNTTEFullBeetleHistoryRemember(_types,_selected.type_key_list)
    _quote=scrNTTEFullBeetleQuote(_selected,1,false,_keys,_types)
    assert(_quote.can_merge && _quote.cost==0 && _quote.known,"A repeated exact Beetle recipe charged max HP again")
    var _replacement=scrNTTEFullBeetleSelection(scrNTTEFullBeetleMenuInventory(wep_splinter_gun,scrNTTEFullWeaponMerge(wep_machinegun,wep_shovel)),[0,1,2])
    assert(scrNTTEFullBeetleQuote(_replacement,8,true,_keys,_types).cost==0
        && scrNTTEFullBeetleQuote(_replacement,8,false,_keys,_types).cost==4,"Beetle Throne Butt history did not distinguish matching ammo types from matching exact weapons")
    var _saved=json_parse(json_stringify({keys:_keys,types:_types}))
    assert(scrNTTEFullBeetleQuote(_selected,1,false,_saved.keys,_saved.types).cost==0,"Beetle recipe history did not survive real JSON continuation")
    scrNTTESmokeLog("SYSTEMS BEETLE MODEL: ordered splitting/selection without inventory mutation, cursed whole weapons, source max-HP threshold, exact/type histories and real JSON continuation OK")
}

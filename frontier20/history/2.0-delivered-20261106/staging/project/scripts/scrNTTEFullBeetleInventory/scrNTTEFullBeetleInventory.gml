// beetle.race.gml 590..819: commit the selected real inventory components.
// Preview clones are never equipped: physical part state remains attached to
// its canonical model while actual source parts are detached and reassembled.
function scrNTTEFullBeetleHistory() {
    if(!is_struct(scrNTTEFullValue(GameCont,"beetle_menu_merging_wep_key_tree",undefined))) GameCont.beetle_menu_merging_wep_key_tree={}
    if(!is_struct(scrNTTEFullValue(GameCont,"beetle_menu_merging_wep_type_key_tree",undefined))) GameCont.beetle_menu_merging_wep_type_key_tree={}
    return {keys:GameCont.beetle_menu_merging_wep_key_tree,types:GameCont.beetle_menu_merging_wep_type_key_tree}
}
function scrNTTEFullBeetleEquipState(_weapon) {
    return scrNTTEFullWeaponIsNative(_weapon) ? scrNTTEFullWeaponNativeState(_weapon):scrNTTENewState(_weapon)
}
function scrNTTEFullBeetleCommit(_indices) {
    var _inventory=scrNTTEFullBeetleMenuInventory(wep,bwep,curse,bcurse)
    if(array_length(_indices)==0) return {ok:false,cost:0,drops:[]}
    var _selection=scrNTTEFullBeetleSelection(_inventory,_indices,curse,bcurse),_history=scrNTTEFullBeetleHistory()
    var _quote=scrNTTEFullBeetleQuote(_selection,max_hp,scr_skill_get(mut_throne_butt)>0,_history.keys,_history.types)
    if(!_quote.can_merge) return {ok:false,cost:_quote.cost,drops:[]}
    // The original records new history branches only when the full raw cost
    // was affordable, before its existing-recipe discount is applied.
    if(max_hp>_selection.health_cost) {
        scrNTTEFullBeetleHistoryRemember(_history.keys,_selection.key_list)
        scrNTTEFullBeetleHistoryRemember(_history.types,_selection.type_key_list)
    }
    var _primary=false,_secondary=false,_oldcurse=curse,_oldbcurse=bcurse,_drops=[]
    for(var _i=0;_i<array_length(_indices);++_i) {
        if(_indices[_i]<_inventory.primary_count) _primary=true
        else _secondary=true
    }
    if(_primary && _secondary) {
        curse=max(curse,bcurse); bwep=wep_none; bcurse=0; bntte_state=scrNTTENewState(wep_none)
    }
    // Every uncursed part in an affected slot is detached in place. Keeping
    // these actual models preserves charge/ammunition on merged mod weapons.
    for(var _i=0;_i<array_length(_inventory.list);++_i) {
        var _isprimary=_i<_inventory.primary_count
        if(!(_isprimary ? _primary:_secondary)) continue
        var _part=_inventory.list[_i]
        if(is_struct(_part) && (_isprimary ? _oldcurse:_oldbcurse)<=0 && variable_struct_exists(_part,"temerge")) variable_struct_remove(_part,"temerge")
        if(array_get_index(_indices,_i)<0 && scrNTTEFullWeaponRaw(_part)!=wep_none) {
            var _native=scrNTTEFullWeaponNative(_part),_partcurse=_isprimary ? _oldcurse:_oldbcurse
            if(bwep==wep_none) { bwep=_native; bcurse=_partcurse; bntte_state=scrNTTEFullBeetleEquipState(_native) }
            else {
                var _pickup=scrWeaponPickupCreate(x,y,_native,false)
                _pickup.curse=_partcurse; _pickup.image_index=1; array_push(_drops,_pickup)
                instance_create(x,y,Dust)
            }
        }
    }
    if(_secondary && !_primary) { scrSwapWeps(false); clicked=false }
    var _merged=wep_none
    for(var _i=0;_i<array_length(_indices);++_i) {
        var _part=_inventory.list[_indices[_i]]
        _merged=(_i==0) ? _part:scrNTTEFullWeaponMerge(_merged,_part)
    }
    wep=scrNTTEFullWeaponNative(_merged); ntte_state=scrNTTEFullBeetleEquipState(wep)
    if(scrNTTEFullWeaponIsNative(wep)) scrNTTEFullWeaponNativeRefresh(wep)
    if(_quote.cost!=0) {
        headloses+=_quote.cost; max_hp-=_quote.cost; lsthealth=min(lsthealth,max_hp)
        scrNTTEFullRawHit(id,max(0,hp-max_hp),2)
        scrNTTEFullRaceStatAdd("race:beetle:spec",_quote.cost)
    }
    if(array_length(_indices)>=6) scrNTTEFullUnlockSet("skin:beetle:1",true)
    return {ok:true,cost:_quote.cost,drops:_drops,weapon:wep,primary:_primary,secondary:_secondary}
}
function scrNTTEFullBeetleInventoryTests() {
    var _p=instance_find(Player,0),_before=scrNTTEFullInstances(all),_old={wep:_p.wep,bwep:_p.bwep,curse:_p.curse,bcurse:_p.bcurse,
        state:_p.ntte_state,bstate:_p.bntte_state,maxhp:_p.max_hp,hp:_p.hp,lst:_p.lsthealth,head:_p.headloses,
        next:_p.nexthurt,sprite:_p.sprite_index,image:_p.image_index}
    var _oldkeys=scrNTTEFullValue(GameCont,"beetle_menu_merging_wep_key_tree",undefined),_oldtypes=scrNTTEFullValue(GameCont,"beetle_menu_merging_wep_type_key_tree",undefined)
    GameCont.beetle_menu_merging_wep_key_tree={}; GameCont.beetle_menu_merging_wep_type_key_tree={}
    var _a=scrNTTEFullWeaponMerge(wep_revolver,wep_shotgun),_b=scrNTTEFullWeaponMerge(wep_crossbow,wep_wrench),_result
    with(_p) {
        wep=scrNTTEFullWeaponNative(_a); bwep=scrNTTEFullWeaponNative(_b); curse=0; bcurse=0
        ntte_state=scrNTTEFullBeetleEquipState(wep); bntte_state=scrNTTEFullBeetleEquipState(bwep)
        max_hp=8; hp=8; lsthealth=8; headloses=0
        _result=scrNTTEFullBeetleCommit([2,0])
    }
    assert(_result.ok && _result.cost==2 && _p.max_hp==6 && _p.hp==6 && _p.lsthealth==6 && _p.headloses==2,
        "Beetle actual merge failed its exact max-HP/current-HP/native permanent-loss cost")
    assert(scrNTTEFullWeaponRaw(_p.wep)==wep_crossbow && scrNTTEFullWeaponRaw(scrNTTEFullWeaponMergedPart(_p.wep))==wep_revolver,
        "Beetle equipped merge did not preserve selected part order")
    assert(scrNTTEFullWeaponRaw(_p.bwep)==wep_shotgun && array_length(_result.drops)==1 && scrNTTEFullWeaponRaw(_result.drops[0].wep)==wep_wrench,
        "Beetle affected-slot leftovers were lost or duplicated instead of filling secondary then dropping")
    assert(is_struct(_p.ntte_state) && _p.ntte_state.weapon==_p.wep,"Beetle actual equip kept stale weapon-slot state")
    with(_p) { max_hp=1; hp=1; lsthealth=1; _result=scrNTTEFullBeetleCommit([0,1]) }
    assert(_result.ok && _result.cost==0 && _p.max_hp==1 && _p.hp==1,"Beetle actual repeated recipe charged again at one maximum HP")
    // Only the secondary slot is selected: original primary must survive as
    // the secondary weapon after the native swap, with its state intact.
    with(_p) {
        wep=wep_revolver; bwep=scrNTTEFullWeaponNative(scrNTTEFullWeaponMerge(wep_crossbow,wep_shovel)); curse=0; bcurse=0
        ntte_state=scrNTTEFullBeetleEquipState(wep); bntte_state=scrNTTEFullBeetleEquipState(bwep)
        max_hp=8; hp=8; _result=scrNTTEFullBeetleCommit([1,2])
    }
    assert(_result.ok && !_result.primary && _result.secondary && scrNTTEFullWeaponRaw(_p.wep)==wep_crossbow && _p.bwep==wep_revolver,
        "Beetle secondary-only merge failed the native slot swap or overwrote the unaffected primary")
    with(_p) { wep=_old.wep; bwep=_old.bwep; curse=_old.curse; bcurse=_old.bcurse; ntte_state=_old.state; bntte_state=_old.bstate;
        max_hp=_old.maxhp; hp=_old.hp; lsthealth=_old.lst; headloses=_old.head; nexthurt=_old.next; sprite_index=_old.sprite; image_index=_old.image }
    GameCont.beetle_menu_merging_wep_key_tree=_oldkeys; GameCont.beetle_menu_merging_wep_type_key_tree=_oldtypes
    var _all=scrNTTEFullInstances(all)
    for(var _i=0;_i<array_length(_all);++_i) if(array_get_index(_before,_all[_i])<0) instance_destroy(_all[_i],false)
    scrNTTESmokeLog("SYSTEMS BEETLE INVENTORY: real ordered equip, exact max-HP fee, leftover slot/ground transfers, repeat-recipe discount and secondary-only native swap OK")
}

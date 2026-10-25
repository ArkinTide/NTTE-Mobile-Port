// ntte.mod.gml3457..3503. Observe the total mutation count once in Begin Step;
// native skill_set still owns ordinary ammo, healing and curse removal.
function scrNTTEFullLastWishSlot(_actor,_primary,_diff) {
    var _weapon=variable_instance_get(_actor,_primary?"wep":"bwep"),
        _raw=scrNTTEFullWeaponRaw(_weapon),_cost=0
    // Original only accepts outer LWO having BOTH ammo and amax. Bone and
    // Trident have ammo but no amax. Nested merge fronts are not enumerated.
    switch(_raw) {
        case wep_ntte_sawblade_gun:case wep_ntte_pizza_cutter:case wep_ntte_vampire:_cost=1;break
        case wep_ntte_sawblade_cannon:_cost=7;break
        default:if(!scrNTTEIsScythe(_raw)) return;
    }
    var _state=undefined
    if(is_struct(_weapon) || scrNTTEFullWeaponIsNative(_weapon)) _state=scrNTTEFullWeaponNativeState(_weapon)
    else {
        var _key=_primary?"ntte_state":"bntte_state"
        _state=scrNTTEFullValue(_actor,_key,undefined)
        if(!is_struct(_state) || _state.weapon!=_weapon) {
            _state=scrNTTENewState(_weapon);variable_instance_set(_actor,_key,_state)
        }
    }
    // Read the actual physical capacity/buff, without triggering a separate
    // Back Muscle transition here (source reads the fields as they stand).
    var _max=_state.capacity,_buff=_state.muscle*(scrNTTEIsScythe(_raw)?0.8:1),
        _base=_max/(1+_buff),_wish=_base<200?ceil(_max*0.35):round(_max*0.785)
    _state.ammo=clamp(_state.ammo+_wish*_diff,_cost,_max)
}
function scrNTTEFullLastWishStep() {
    if(!instance_exists(GameCont)) return;
    // Source initializes Red before observing Last Wish. Missing fields only;
    // an existing run/save keeps its ammo and only applies a real muscle delta.
    with(Player) scrNTTEFullRedAmmoState()
    var _current=scr_skill_get(mut_last_wish),_previous=scrNTTEFullValue(GameCont,"ntte_lastwish",0)
    if(variable_instance_exists(GameCont,"ntte_lastwish") && _current==_previous) return;
    GameCont.ntte_lastwish=_current
    var _diff=_current-_previous
    if(_current==0 || _diff==0) return;
    with(Player) {
        scrNTTEFullLastWishSlot(id,true,_diff);scrNTTEFullLastWishSlot(id,false,_diff)
        if(race==NTTEFullRace.Parrot && feather_ammo<feather_ammo_max)
            feather_ammo=clamp(feather_ammo+2*feather_num*_diff,feather_num,feather_ammo_max)
        if(variable_instance_exists(id,"ntte_red_ammo")
            && (scrNTTEFullRedAmmoWeaponCost(wep)>0 || scrNTTEFullRedAmmoWeaponCost(bwep)>0))
            ntte_red_ammo=min(ntte_red_ammo+ntte_red_amax*_diff,ntte_red_amax)
    }
}

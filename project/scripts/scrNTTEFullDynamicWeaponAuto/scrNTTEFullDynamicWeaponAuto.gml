// Original per-LWO weapon_auto callbacks. The unchanged temerge reducer still
// decides how the current stock and front values combine on every query.
function scrNTTEFullWeaponAutoState(_weapon) {
    var _model=scrNTTEFullWeaponModel(_weapon)
    if(is_struct(_model)) return scrNTTEFullValue(_model,"ntte_native_state",undefined)
    // Numeric ordinary native slots store the physical LWO separately. All
    // engine firing and Steroids secondary entry points expose firing as wep.
    // Resolve only that exact held numeric identity; never borrow another
    // physical part's state merely because its raw weapon type is the same.
    if(variable_instance_exists(id,"wep") && wep==_weapon) {
        var _state=scrNTTEFullValue(id,"ntte_state",undefined)
        if(is_struct(_state) && _state.weapon==_weapon) return _state
    }
    return undefined
}
function scrNTTEFullWeaponStockAuto(_weapon) {
    var _model=scrNTTEFullWeaponModel(_weapon),_raw=scrNTTEFullWeaponRaw(_model)
    switch(_raw) {
        case wep_ntte_pizza_cutter:
            var _state=scrNTTEFullWeaponAutoState(_weapon)
            if(is_struct(_state)) return scrNTTEFullValue(_state,"loaded",false)
            // A source LWO not yet initialized by fire/step has no canload
            // field. Its original auto callback explicitly defaults to false.
            return is_struct(_model)?scrNTTEFullValue(_model,"canload",false):false
        case wep_ntte_annihilator:
            return scrNTTEFullRedWeaponCanCharge()
        case wep_ntte_entangler:
            return scrNTTEFullEntanglerCanCharge()
    }
    return scr_weapon_is_valid(_raw)?wep_auto[_raw]:false
}

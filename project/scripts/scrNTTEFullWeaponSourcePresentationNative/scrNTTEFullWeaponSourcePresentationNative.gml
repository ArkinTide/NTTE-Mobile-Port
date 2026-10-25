// entangler.wep24, annihilator.wep22, ultra quasar rifle.wep18 and
// bat disc launcher.wep25: source text events retain choice/color tags.
function scrNTTEFullWeaponSourceText(_weapon,_fallback="") {
    switch(scrNTTEFullWeaponRaw(_weapon)) {
        case wep_ntte_entangler:
            return choose("@wSPLIT @sTHE @(color:"+string(scrAreaGetBackroundColor(scrNTTEFullAreaId("red")))+")CONTINUUM","MAKING NEW FRIENDS")
        case wep_ntte_annihilator:
            return "@wBEND @sTHE @(color:"+string(scrAreaGetBackroundColor(scrNTTEFullAreaId("red")))+")CONTINUUM"
        case wep_ntte_ultra_quasar_rifle:
            return choose("THE GREEN SUN","ROCKET POWERED RECOIL DAMPENING")
        case wep_ntte_sawblade_gun:return "LIKE DISCS BUT @ySMARTER"
    }
    return _fallback
}
// Source HUD events query the complete physical stock's merged properties;
// curse only applies when the actual Player slot is this same source LWO.
function scrNTTEFullRedWeaponHUD(_weapon) {
    var _model=scrNTTEFullWeaponModel(_weapon),_raw=scrNTTEFullWeaponRaw(_model),_curse=false
    if(instance_is(id,Player)) {
        _curse=(scrNTTEFullWeaponModel(wep)==_model && curse>0)
            || (scrNTTEFullWeaponModel(bwep)==_model && bcurse>0)
    }
    var _normal=scr_weapon_is_golden(_weapon)!=0 || scr_weapon_get_rads(_weapon)>0 || _curse,
        _module=_raw==wep_ntte_entangler?"entangler":"annihilator"
    return scrNTTERefSprite("Weapon."+_module+(_normal?".sprWepHUD":".sprWepHUDRed"))
}
// clam shield.wep25: live shield identity hides only that physical weapon.
// Pickups and ThrownWep retain their visible sprite; HUD is unconditional.
function scrNTTEFullClamSourceSprite(_weapon,_state,_fallback) {
    var _model=scrNTTEFullWeaponModel(_weapon)
    if(!is_struct(_model)) _model=scrNTTEFullValue(_state,"ntte_physical_model",_model)
    var _raw=scrNTTEFullWeaponRaw(_model)
    if(_raw!=wep_ntte_clam_shield || !scrNTTEFullWeaponAvailable(_raw)
        || instance_is(id,WepPickup)) return _fallback
    var _thrown=asset_get_index("ThrownWep")
    if(_thrown>=0 && instance_is(id,_thrown)) return _fallback
    // A merged front without its own state must not borrow the stock state.
    if(is_struct(_model)) _state=scrNTTEFullValue(_model,"ntte_native_state",undefined)
    _state=scrNTTEFullValue(_state,"ntte_physical_state",_state)
    if(!is_struct(_state)) return _fallback
    var _hidden=false
    with(NTTEFullClamShield) if(variable_instance_exists(id,"ntte_clam_state") && ntte_clam_state==_state) {
        _hidden=true
        break
    }
    return _hidden?mskNone:_fallback
}
function scrNTTEFullWeaponSourceSprite(_weapon,_state,_fallback,_hud) {
    var _raw=scrNTTEFullWeaponRaw(_weapon)
    if(_hud) return (_raw==wep_ntte_entangler || _raw==wep_ntte_annihilator)
        ?scrNTTEFullRedWeaponHUD(_weapon):_fallback
    return scrNTTEFullClamSourceSprite(_weapon,_state,_fallback)
}

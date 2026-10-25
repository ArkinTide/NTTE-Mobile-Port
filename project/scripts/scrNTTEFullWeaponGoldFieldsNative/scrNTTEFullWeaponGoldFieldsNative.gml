// teleport gun.wep21..26 and trident.wep27..33: physical LWO gold fields.
function scrNTTEFullWeaponGoldMetadata(_weapon,_field,_fallback) {
    var _model=scrNTTEFullWeaponModel(_weapon),_raw=scrNTTEFullWeaponRaw(_model),
        _portal=_raw==wep_ntte_teleport_gun || _raw==wep_ntte_golden_teleport_gun,
        _trident=_raw==wep_ntte_trident || _raw==wep_ntte_golden_trident
    if(!_portal && !_trident) return scrNTTEFullBoneWeaponMetadata(_weapon,_field,_fallback)
    var _gold=_raw==wep_ntte_golden_teleport_gun || _raw==wep_ntte_golden_trident
            || scrNTTEFullValue(_model,"gold",false)!=0,
        _available=_portal || scrNTTEFullWeaponAvailable(_raw),
        _state=scrNTTEFullValue(_model,"ntte_native_state",undefined),
        _visible=!_trident || scrNTTEFullValue(_state,"visible",scrNTTEFullValue(_model,"visible",true))
    switch(_field) {
        case "name":return _available?(_gold?"GOLDEN ":"")+(_portal?"TELEPORT GUN":"TRIDENT"):"LOCKED"
        case "text":return _portal?(_gold?"LUXURY TRAVEL":"DON'T BLINK")
            :(_gold?"SHINE THROUGH THE SKY":"SCEPTER OF THE @bSEA")
        case "sprite":case "hud":
            if(!_visible) return mskNone
            if(!_available) return scrNTTEFullWeaponLockedSprite(_raw)
            return scrNTTERefSprite(_portal?(_gold?"GoldTeleportGun":"TeleportGun")
                :(_gold?"GoldTrident":"Trident"))
        case "loadout":return scrNTTERefSprite(_portal?(_gold?"GoldTeleportGunLoadout":"TeleportGunLoadout")
                :(_gold?"GoldTridentLoadout":"TridentLoadout"))
        case "area":return _available && !_gold?7:-1
        case "gold":return _gold?-1:0
        case "swap":
            if(_trident) return _visible?sndSwapSword:sndSwapCursed
            snd_play(sndCrystalTB)
            return sndSwapShotgun
    }
    return _fallback
}
function scrNTTEFullWeaponGoldFiring(_weapon) {
    var _model=scrNTTEFullWeaponModel(_weapon),_raw=scrNTTEFullWeaponRaw(_model),
        _scope=variable_global_exists("ntte_full_merged_state_fire")?global.ntte_full_merged_state_fire:undefined
    if(_raw!=wep_ntte_teleport_gun && _raw!=wep_ntte_golden_teleport_gun
        && _raw!=wep_ntte_trident && _raw!=wep_ntte_golden_trident
        && _raw!=wep_ntte_tunneller && _raw!=wep_ntte_golden_tunneller) return false
    if(is_struct(_scope) && _scope.actor==id && scrNTTEFullWeaponRaw(_scope.part)==_raw) _model=_scope.part
    return _raw==wep_ntte_golden_teleport_gun || _raw==wep_ntte_golden_trident
        || _raw==wep_ntte_golden_tunneller || scrNTTEFullValue(_model,"gold",false)!=0
}

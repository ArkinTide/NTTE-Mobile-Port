// tunneller.wep27..32: gold is a persistent LWO field, not another module.
// The separate native golden ID remains a compatible representation.
function scrNTTEFullTunnellerMetadata(_weapon,_field,_fallback) {
    var _model=scrNTTEFullWeaponModel(_weapon),_raw=scrNTTEFullWeaponRaw(_model)
    if(_raw!=wep_ntte_tunneller && _raw!=wep_ntte_golden_tunneller) return scrNTTEFullWeaponGoldMetadata(_weapon,_field,_fallback)
    var _gold=_raw==wep_ntte_golden_tunneller || scrNTTEFullValue(_model,"gold",false)!=0,
        _available=scrNTTEFullWeaponAvailable(_raw)
    switch(_field) {
        case "name":return _available?(_gold?"GOLDEN TUNNELLER":"TUNNELLER"):"LOCKED"
        case "sprite":return _available?scrNTTERefSprite(_gold?"GoldTunneller":"Tunneller"):scrNTTEFullWeaponLockedSprite(_raw)
        case "loadout":return scrNTTERefSprite(_gold?"GoldTunnellerLoadout":"TunnellerLoadout")
        case "area":return _available && !_gold?22:-1
        case "gold":return _gold?-1:0
        case "text":
            var _color=string(scrAreaGetBackroundColor(scrNTTEFullAreaId("red")))
            return _gold?choose("GOLDEN GOD","@(color:"+_color+")KEY @sTO THE @wMULTIVERSE")
                :choose("@wUNLOCK @sTHE @(color:"+_color+")CONTINUUM","FULL CIRCLE","YET ANOTHER @(color:"+_color+")RED KEY")
        case "hud":
            var _curse=false
            if(instance_is(id,Player)) {
                _curse=(scrNTTEFullWeaponModel(wep)==_model && curse>0)
                    || (scrNTTEFullWeaponModel(bwep)==_model && bcurse>0)
            }
            return scrNTTERefSprite(scr_weapon_is_golden(_weapon)!=0 || scr_weapon_get_rads(_weapon)>0 || _curse
                ?"TunnellerHUD":"TunnellerHUDRed")
    }
    return _fallback
}
function scrNTTEFullTunnellerStockText(_weapon) {
    var _raw=scrNTTEFullWeaponRaw(_weapon)
    if(_raw==wep_ntte_tunneller || _raw==wep_ntte_golden_tunneller)
        return scrNTTEFullTunnellerMetadata(_weapon,"text","")
    if(scrNTTEFullBoneWeaponMetadataHas(_weapon)) return scrNTTEFullBoneWeaponMetadata(_weapon,"text","")
    if(_raw==wep_ntte_teleport_gun || _raw==wep_ntte_golden_teleport_gun || _raw==wep_ntte_trident || _raw==wep_ntte_golden_trident)
        return scrNTTEFullWeaponGoldMetadata(_weapon,"text","")
    return scr_weapon_get_text(_raw)
}
function scrNTTEFullTunnellerCachedText(_weapon) {
    // Native compatibility table refresh is not a source weapon_text event.
    // Keep its cached display usable without consuming an extra random tip.
    var _seed=random_get_seed()
    try {return scrNTTEFullMergedText(_weapon)}
    finally {random_set_seed(_seed)}
}

// temerge.mod1695..1708: query this same physical firing weapon with only
// its merge disabled. Raw IDs discard gold/skin/visibility/ammo metadata.
function scrNTTEFullMergedRuntimeStockSprite(_weapon) {
    var _model=scrNTTEFullWeaponModel(_weapon)
    if(scrNTTEFullWeaponHasMerge(_model)==false) return scr_weapon_get_sprite(_model)
    var _merge=_model.temerge,_active=_merge.is_active
    try {
        _merge.is_active=false
        return scr_weapon_get_sprite(_model)
    }
    finally {_merge.is_active=_active}
}

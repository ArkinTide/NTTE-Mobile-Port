function scr_weapon_is_valid(_weapon) {
    if(is_struct(_weapon) || scrNTTEFullWeaponIsNative(_weapon)) {
        var _model=scrNTTEFullWeaponModel(_weapon),_raw=scrNTTEFullWeaponRaw(_model)
        return is_numeric(_raw) && _raw>=0 && _raw<=maxwep && (_raw>0 || scrNTTEFullWeaponHasMerge(_model)!=false)
    }
	gml_pragma("forceinline")
	return is_numeric(_weapon) && _weapon > 0 && _weapon <= maxwep
}

function scr_weapon_get_name(_weapon) {
    if(is_struct(_weapon) || scrNTTEFullWeaponIsNative(_weapon)) return scrNTTEFullWeaponNativeProperty(_weapon,"name")
    if(scrNTTEFullBoneWeaponMetadataHas(_weapon)) return scrNTTEFullBoneWeaponMetadata(_weapon,"name",0)
    if(!scrNTTEFullWeaponAvailable(_weapon)) return "LOCKED";
	gml_pragma("forceinline")
	return scr_weapon_is_valid(_weapon) ? wep_name[_weapon] : ("WEAPON" + string(_weapon))
}

function scr_weapon_get_type(_weapon) {
    if(is_struct(_weapon) || scrNTTEFullWeaponIsNative(_weapon)) return scrNTTEFullWeaponNativeProperty(_weapon,"type")
	gml_pragma("forceinline")
	return scr_weapon_is_valid(_weapon) ? wep_type[_weapon] : Ammo.None
}

function scr_weapon_get_cost(_weapon) {
    if(is_struct(_weapon) || scrNTTEFullWeaponIsNative(_weapon)) return scrNTTEFullWeaponNativeProperty(_weapon,"cost")
	gml_pragma("forceinline")
	return scr_weapon_is_valid(_weapon) ? wep_cost[_weapon] : -1
}

function scr_weapon_get_rads(_weapon) {
    if(is_struct(_weapon) || scrNTTEFullWeaponIsNative(_weapon)) return scrNTTEFullWeaponNativeProperty(_weapon,"rads")
	gml_pragma("forceinline")
	return scr_weapon_is_valid(_weapon) ? wep_rads[_weapon] : -1
}

function scr_weapon_get_area(_weapon) {
    if(is_struct(_weapon) || scrNTTEFullWeaponIsNative(_weapon)) return scrNTTEFullWeaponNativeProperty(_weapon,"area")
    if(scrNTTEIsScythe(_weapon)) return scrNTTEFullBoneWeaponMetadata(_weapon,"area",0)
    var _registered_area=scrNTTEFullWeaponRegisteredArea(_weapon);
    if(!is_undefined(_registered_area)) return _registered_area;
	gml_pragma("forceinline")
	return scr_weapon_is_valid(_weapon) ? wep_area[_weapon] : -1
}

function scr_weapon_get_load(_weapon) {
    if(is_struct(_weapon) || scrNTTEFullWeaponIsNative(_weapon)) return scrNTTEFullWeaponNativeProperty(_weapon,"load")
    if(scrNTTEFullBoneWeaponMetadataHas(_weapon)) return scrNTTEFullBoneWeaponMetadata(_weapon,"load",0)
	gml_pragma("forceinline")
	return scr_weapon_is_valid(_weapon) ? wep_load[_weapon] : -1
}

function scr_weapon_get_sprite(_weapon) {
    if(is_struct(_weapon) || scrNTTEFullWeaponIsNative(_weapon)) return scrNTTEFullWeaponNativeProperty(_weapon,"sprite")
    if(scrNTTEFullBoneWeaponMetadataHas(_weapon)) return scrNTTEFullBoneWeaponMetadata(_weapon,"sprite",0)
    if(!scrNTTEFullWeaponAvailable(_weapon)) return scrNTTEFullWeaponLockedSprite(_weapon);
	gml_pragma("forceinline")
	return scr_weapon_is_valid(_weapon) ? wep_sprt[_weapon] : -1
}

function scr_weapon_get_loadout_sprite(_weapon) {
    if(is_struct(_weapon) || scrNTTEFullWeaponIsNative(_weapon)) return scrNTTEFullWeaponNativeProperty(_weapon,"loadout")
	gml_pragma("forceinline")
	return scr_weapon_is_valid(_weapon) ? wep_lout[_weapon] : -1
}

function scr_weapon_is_auto(_weapon) {
    if(is_struct(_weapon) || scrNTTEFullWeaponIsNative(_weapon)) return scrNTTEFullWeaponNativeProperty(_weapon,"auto")
	gml_pragma("forceinline")
	return scrNTTEFullWeaponStockAuto(_weapon)
}

function scr_weapon_is_golden(_weapon) {
    if(is_struct(_weapon) || scrNTTEFullWeaponIsNative(_weapon)) return scrNTTEFullWeaponNativeProperty(_weapon,"gold")
	gml_pragma("forceinline")
	return scr_weapon_is_valid(_weapon) ? wep_gold[_weapon] : false
}

function scr_weapon_is_melee(_weapon) {
    if(is_struct(_weapon) || scrNTTEFullWeaponIsNative(_weapon)) return scrNTTEFullWeaponNativeProperty(_weapon,"melee")
	gml_pragma("forceinline")
	return scr_weapon_is_valid(_weapon) ? wep_mele[_weapon] : false
}

function scr_weapon_has_assist_disabled(_weapon) {
    if(is_struct(_weapon) || scrNTTEFullWeaponIsNative(_weapon)) return scrNTTEFullWeaponNativeProperty(_weapon,"assist")
	gml_pragma("forceinline")
	return scr_weapon_is_valid(_weapon) ? wep_naim[_weapon] : false
}

function scr_weapon_is_hyper(_weapon) {
	return _weapon == wep_hyper_launcher || _weapon == wep_hyper_rifle || _weapon == wep_hyper_slugger
}

function scr_weapon_get_text(_weapon) {
    if(is_struct(_weapon) || scrNTTEFullWeaponIsNative(_weapon)) return scrNTTEFullWeaponNativeProperty(_weapon,"text")
    if(_weapon==wep_ntte_tunneller || _weapon==wep_ntte_golden_tunneller) return scrNTTEFullTunnellerMetadata(_weapon,"text","")
    if(_weapon==wep_ntte_teleport_gun || _weapon==wep_ntte_golden_teleport_gun || _weapon==wep_ntte_trident || _weapon==wep_ntte_golden_trident) return scrNTTEFullWeaponGoldMetadata(_weapon,"text","")
    if(scrNTTEFullBoneWeaponMetadataHas(_weapon)) return scrNTTEFullBoneWeaponMetadata(_weapon,"text","")
    if(_weapon==wep_ntte_entangler || _weapon==wep_ntte_annihilator || _weapon==wep_ntte_ultra_quasar_rifle || _weapon==wep_ntte_sawblade_gun) return scrNTTEFullWeaponSourceText(_weapon)
	gml_pragma("forceinline")
	return scr_weapon_is_valid(_weapon) ? wep_text[_weapon] : ""
}

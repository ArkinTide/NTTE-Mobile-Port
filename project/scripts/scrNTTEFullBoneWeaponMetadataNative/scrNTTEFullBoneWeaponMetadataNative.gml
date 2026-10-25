// crabbone.wep8..47 and scythe.wep31..64,186..207.
// Three native Scythe IDs retain the existing real firing/state adapter.
function scrNTTEFullBoneWeaponMetadata(_weapon,_field,_fallback) {
    var _model=scrNTTEFullWeaponModel(_weapon),_raw=scrNTTEFullWeaponRaw(_model)
    if(!is_numeric(_raw)) return _fallback
    if(scrNTTEFullCrabboneIs(_raw)) {
        var _state=scrNTTEFullValue(_model,"ntte_native_state",undefined),
            _ammo=scrNTTEFullValue(_model,"ammo",scrNTTEFullValue(_state,"ammo",1)),
            _index=_ammo>0?scrNTTEFullCrabbonePartIndex(_model,_state)+2:0
        switch(_field) {
            case "name":
                var _names=["DROP",loc("NTTE:Bone","BONE"),"ANCIENT ARTIFACT","GUARDED ARTIFACT","STOLEN ARTIFACT","MISSING ARTIFACT"]
                return _names[_index]
            case "text":
                var _tips=["","BONE THE FISH","SECRETS LIE WITHIN","UNCONVENTIONAL WEAPONRY","BRING IT BACK","HARDLY FOUND, EASILY LOST"]
                return _tips[_index]
            case "sprite":case "hud":return _index==0?mskNone:(_index==1?scrNTTERefSprite("Bone"):scrNTTERefSprite("QuestArtifact",_index-2))
            case "swap":return _index==0?sndSwapCursed:(_index==1?sndBloodGamble:sndSwapHammer)
            case "load":return scrNTTEFullValue(id,"curse",0)>0?30:6
        }
        return _fallback
    }
    if(scrNTTEIsScythe(_raw)) {
        var _mode=_raw-wep_ntte_bone_scythe,_available=scrNTTEFullWeaponAvailable(wep_ntte_bone_scythe)
        switch(_field) {
            // Original mode-table logical reload; zero never rearms can_shoot.
            case "load":
                var _loads=[12,18,15]
                return _loads[_mode]
            case "name":
                var _names=["BONE SCYTHE","BONE SHOTBOW","BONE SLUGBOW"]
                return _available?_names[_mode]:"LOCKED"
            case "text":
                var _tips=["@rREASSEMBLED","@wMARROW @sFROM A HUNDRED @gMUTANTS","@gRADIATION@s DETERIORATES @wBONES"]
                return _tips[_mode]
            case "sprite":
                if(!_available) return scrNTTEFullWeaponLockedSprite(wep_ntte_bone_scythe)
                var _sprites=["Weapon.scythe.sprWep","Weapon.scythe.sprShotbow","Weapon.scythe.sprSlugbow"]
                return scrNTTERefSprite(_sprites[_mode])
            case "hud":
                var _huds=["Weapon.scythe.sprWepHUD","Weapon.scythe.sprShotbow","Weapon.scythe.sprSlugbowHUD"]
                return scrNTTERefSprite(_huds[_mode])
            case "swap":
                var _sounds=[sndBloodGamble,sndSwapMachinegun,sndSwapMotorized]
                return _sounds[_mode]
            case "area":return _available?19:-1
        }
    }
    return _fallback
}
function scrNTTEFullBoneWeaponMetadataHas(_weapon) {
    var _raw=scrNTTEFullWeaponRaw(_weapon)
    if(!is_numeric(_raw)) return false
    return scrNTTEFullCrabboneIs(_raw) || scrNTTEIsScythe(_raw)
}

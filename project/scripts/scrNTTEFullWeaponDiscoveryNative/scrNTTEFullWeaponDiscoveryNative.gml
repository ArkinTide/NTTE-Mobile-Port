// ntte.mod3915..3955; availability belongs to the OUTER registered module.
// temerge has no weapon_avail wrapper. Never recurse into merged front parts.
function scrNTTEFullWeaponAvailabilityRecord(_weapon) {
    var _record=scrNTTEFullWeaponDropNativeRecord(_weapon)
    if(is_undefined(_record)) return undefined
    return _record.unlock!="" || _record.raw=="beetle pistol" || _record.raw=="ultra quasar rifle" ? _record:undefined
}
function scrNTTEFullWeaponAvailable(_weapon) {
    // Custom loadouts may use every weapon without granting ownership. Keep
    // natural drop eligibility in WeaponDropArea's permanent unlock gates.
    if(scrGameIsCustomMode()) return true
    var _record=scrNTTEFullWeaponAvailabilityRecord(_weapon)
    if(is_undefined(_record)) return true
    if(_record.raw=="beetle pistol" || _record.raw=="ultra quasar rifle") return scrNTTEFullUnlockGet("race:beetle")
    return scrNTTEFullUnlockGet(_record.unlock)
        || (_record.raw=="trident" && scrNTTEFullUnlockGet("wep:trident"))
}
function scrNTTEFullWeaponLockedSprite(_weapon) {
    var _record=scrNTTEFullWeaponAvailabilityRecord(_weapon)
    return is_undefined(_record)?mskNone:scrNTTERefSprite("Weapon."+_record.raw+".sprWepLocked")
}
function scrNTTEFullWeaponRegisteredArea(_weapon) {
    var _record=scrNTTEFullWeaponDropNativeRecord(_weapon)
    if(is_undefined(_record)) return undefined
    // Native golden IDs are fields of the corresponding source LWO, whose
    // gold property explicitly suppresses natural drops.
    var _raw=scrNTTEFullWeaponRaw(_weapon)
    if(_raw==wep_ntte_golden_teleport_gun || _raw==wep_ntte_golden_trident || _raw==wep_ntte_golden_tunneller) return -1
    return scrNTTEFullWeaponDropArea(_record.raw,id)
}
function scrNTTEFullDiscoveryStatSet(_key) {
    if(scrNTTEFullValue(global.ntte_full_progress.stats,_key,false)==true) return false
    global.ntte_full_progress.stats[$ _key]=true
    return true
}
function scrNTTEFullDiscoveryPlayerEndStep() {
    // Temporary custom availability must neither Boneify the chosen loadout
    // nor record it as a permanently discovered source module.
    if(scrGameIsCustomMode()) return false
    var _changed=false
    for(var _i=0;_i<2;++_i) {
        var _primary=_i==0,_weapon=_primary?wep:bwep,
            _record=scrNTTEFullWeaponAvailabilityRecord(_weapon)
        if(is_undefined(_record)) continue
        if(scrNTTEFullWeaponAvailable(_weapon)) {
            _changed=scrNTTEFullDiscoveryStatSet("found:"+_record.raw+".wep") || _changed
            continue
        }
        var _angle=choose(-120,120),_state=scrNTTENewState(wep_ntte_bone)
        if(_primary) {wep=wep_ntte_bone;wepangle=_angle;ntte_state=_state}
        else {bwep=wep_ntte_bone;bwepangle=_angle;bntte_state=_state}
        snd_play(sndCrownRandom);scrNTTEFullTrenchShake(x,y,20)
        instance_create(x,y,NTTEFullGunWarrantEmpty)
        repeat(2) {
            var _fx=instance_create(x,y,Smoke)
            if(instance_exists(_fx)) {_fx.direction=gunangle+_angle;_fx.speed=2.5*timescale;_fx.depth=depth-1}
        }
    }
    return _changed
}
function scrNTTEFullDiscoveryEndStep() {
    if(scrGameIsCustomMode()) return;
    if(!variable_global_exists("ntte_full_progress")) scrNTTEFullProgressLoad()
    var _changed=false,_crown=scrNTTEFullCrownKey(GameCont.crown)
    if(_crown!="") {
        _changed=scrNTTEFullDiscoveryStatSet("found:"+_crown+".crown")
        scrNTTEFullAchievementAward("pack:crown",true)
        if(!scrNTTEFullUnlockGet("pack:crown")) {
            global.ntte_full_progress.unlocks[$ "pack:crown"]=true
            _changed=true
        }
    }
    with(Player) _changed=scrNTTEFullDiscoveryPlayerEndStep() || _changed
    // Save only transitions; source has one persistent shared stat/save map.
    if(_changed) scrNTTEFullProgressSave()
}

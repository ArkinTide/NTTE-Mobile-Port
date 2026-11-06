// Original bat tether.wep.gml. `bat` only groups this weapon's coils; the
// supplied TeslaCoil source never reads it as a different damage multiplier.
function scrNTTEFullVampireMuscle(_state) {
    var _muscle=scr_skill_get(mut_back_muscle)
    if(_state.muscle!=_muscle) {
        var _base=_state.capacity/(1+_state.muscle)
        _state.muscle=_muscle;_state.capacity=_base*(1+_muscle)
        // Deliberately source's new maximum minus its unbuffed maximum.
        // Losing Back Muscle does not subtract the previously added magazine.
        _state.ammo+=_state.capacity-_base
    }
}
function scrNTTEFullVampireRefill(_state,_owner,_weapon) {
    _state.ammo=_state.capacity*(1+scr_skill_get(mut_back_muscle))
    scrNTTEFullRawHit(_owner,1,false)
    var _cause=[scr_weapon_get_sprite(_weapon),"PLAYING GOD"]
    _owner.ntte_last_hit=_cause
    if(scr_player_is_local(_owner.index)) GameCont.deathcause=_cause
    if(_owner.hp>0) {
        var _volume=(_owner.hp<=_owner.max_hp/2)*0.3
        snd_play(sndGammaGutsProc,0.9+random(0.3),1.1+_volume)
        snd_play(sndHitFlesh,0.8+random(0.4),0.9+_volume)
        instance_create(x,y,AllyDamage);scrNTTEFullTrenchShake(x,y,12,true);sleep(24)
    }
    else {
        snd_play(sndGammaGutsKill);snd_play(sndHyperCrystalSearch,0.8,0.8)
        scrNTTEFullTrenchShake(x,y,24,true);sleep(48)
    }
}
function scrNTTEFullVampireFire(_primary) {
    var _state=scrNTTEState(),_owner=scrNTTEFullElectroWeaponCreator()
    if(!scrNTTESpend(_state,1)) return noone
    var _shot=scrNTTEFullMergedBasicProjectileCreate(x,y,NTTEFullTeslaCoil,gunangle),
        _capture_creator=_shot.creator,_count=0,_brain=scr_skill_get(mut_laser_brain)
    _shot.creator=_owner;_shot.ntte_full_range=64;_shot.ntte_full_time=7*(1+_brain)
    _shot.bat=true;_shot.ntte_full_primary=_primary
    if(!_primary) _shot.ntte_full_offy-=4
    if(_state.ammo<=0 && instance_is(_owner,Player)) {
        var _weapon=_state.weapon,
            _scope=variable_global_exists("ntte_full_merged_state_fire")?global.ntte_full_merged_state_fire:undefined
        if(is_struct(_scope) && _scope.actor==id) _weapon=_scope.part
        scrNTTEFullVampireRefill(_state,_owner,_weapon)
    }
    with(NTTEFullTeslaCoil) if(scrNTTEFullValue(id,"bat",false) && creator==_owner
        && ntte_full_primary==_primary) _count++
    if(_count==1) {
        scr_weapon_post(gunangle,-10,10,8)
        snd_play(sndBloodLauncherExplo,(_brain?0.7:0.9)+random(_brain?0.3:0.4),0.8)
        snd_play(_brain?sndLightningShotgunUpg:sndLightningShotgun,(_brain?0.7:0.8)+random(0.4),0.8)
    }
    if(_brain) {
        var _fx=instance_create(x,y,LaserBrain);_fx.creator=_owner
    }
    _shot.creator=_capture_creator
    return _shot
}

// Original lightring launcher and super lightring launcher weapon_fire.
function scrNTTEFullLightringWeaponFire(_weapon,_primary) {
    var _big=_weapon==wep_ntte_lightring_cannon,
        _shot=scrNTTEFullMergedBasicProjectileCreate(x,y,NTTEFullLightningDisc,gunangle,_big?14:10)
    _shot.ntte_full_primary=_primary
    if(_big) {
        _shot.ntte_full_charge*=2.5;_shot.ntte_full_charge_speed/=2
        _shot.ntte_full_stretch*=1.2;_shot.ntte_full_radius*=4/3
        _shot.ntte_full_super=1.2
        snd_play(sndLightningCannon,1.5,0.6)
    }
    snd_play(sndLightningCannonUpg,0.5,0.4)
    return _shot
}

// Original three tetrench weapon_fire entries. Real ElectroPlasma entities
// retain their exact authored tether chain and share it on the real creator.
function scrNTTEFullElectroWeaponIs(_weapon) {
    return _weapon==wep_ntte_electroplasma_rifle || _weapon==wep_ntte_electroplasma_shotgun
        || _weapon==wep_ntte_electroplasma_cannon
}
function scrNTTEFullElectroWeaponCreator() {
    var _creator=scrNTTEFullValue(id,"ntte_actor_fire_creator",noone)
    if(instance_exists(_creator)) return _creator
    _creator=scrNTTEFullMergedRuntimeActorOwner(id)
    return instance_exists(_creator) ? _creator:id
}
function scrNTTEFullElectroWeaponOne(_weapon,_primary=true,_burst=1,_context=undefined) {
    var _owner=scrNTTEFullElectroWeaponCreator(),_last=scrNTTEFullValue(_owner,"electroplasma_last",noone),
        _side=scrNTTEFullValue(_owner,"electroplasma_side",1),_shot=noone,
        _brain=scr_skill_get(mut_laser_brain)>0,_direction=gunangle
    switch(_weapon) {
        case wep_ntte_electroplasma_rifle:
            _shot=scrNTTEFullMergedBasicProjectileCreate(x,y,NTTEFullElectroPlasma,
                _direction+(17+orandom(7))*accuracy*_side,random_range(4,4.4))
            _shot.ntte_full_tether_inst=_last
            _owner.electroplasma_last=_shot;_owner.electroplasma_side=-_side
            if(_burst==1) scrNTTEFullCustomProjectileGunSound(_brain?sndLightningPistolUpg:sndLightningPistol,
                _brain?0.4:0.3,_brain?0.6:0.3)
            snd_play(sndEliteShielderFire,0.9+random(0.3));snd_play(sndGammaGutsProc,1+random(0.2))
            scr_weapon_post(_direction,3,0,6);scrNTTEFullNativeMotionAddFT(id,_direction+180,3)
            break
        case wep_ntte_electroplasma_shotgun:
            for(var _i=-2;_i<=2;++_i) {
                _shot=scrNTTEFullMergedBasicProjectileCreate(x,y,NTTEFullElectroPlasma,
                    _direction+(20+orandom(6))*accuracy*_i,random_range(4,4.8))
                _shot.ntte_full_tether_inst=_last;_last=_shot;_shot.primary=_primary
            }
            _owner.electroplasma_last=_last
            scrNTTEFullCustomProjectileGunSound(_brain?sndLightningShotgunUpg:sndLightningShotgun,
                _brain?0.4:0.3,_brain?0.6:0.3)
            snd_play(sndPlasmaBig,1.1+random(0.3))
            scr_weapon_post(_direction,6,0,8);scrNTTEFullNativeMotionAddFT(id,_direction+180,4)
            break
        case wep_ntte_electroplasma_cannon:
            _shot=scrNTTEFullMergedBasicProjectileCreate(x,y,NTTEFullElectroPlasmaBig,
                _direction+orandom(4*accuracy),6)
            var _channel=scrNTTEFullCustomProjectileGunSound(_brain?sndLightningShotgunUpg:sndLightningShotgun,
                0,_brain?0.6:0.3)
            if(_channel>=0) audio_sound_pitch(_channel,0.6+random(0.2))
            snd_play(_brain?sndPlasmaRifleUpg:sndPlasmaRifle,0.5+random(0.1))
            scr_weapon_post(_direction,30,0,12);scrNTTEFullNativeMotionAddFT(id,_direction+180,4)
            instance_create(x,y,Smoke)
            break
    }
    if(instance_exists(_shot)) _shot.primary=_primary
    return _shot
}
function scrNTTEFullElectroWeaponFire(_weapon,_primary=true) {
    if(_weapon==wep_ntte_electroplasma_rifle)
        scrNTTEFullNativeFireBurstStart(_weapon,3,3,_primary,scrNTTEFullElectroWeaponOne,undefined,3)
    return scrNTTEFullElectroWeaponOne(_weapon,_primary,1)
}
function scrNTTEFullElectroWeaponReloaded(_weapon) {
    if(!scrNTTEFullElectroWeaponIs(_weapon)) return false
    snd_play(sndLightningReload);snd_play(sndPlasmaReload,1.5)
    return true
}

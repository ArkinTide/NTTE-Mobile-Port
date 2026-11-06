// Original four Quasar weapon_fire entries. Persistent beam references belong
// to each physical weapon state, including an independently mounted front.
function scrNTTEFullQuasarWeaponIs(_weapon) {
    return _weapon==wep_ntte_quasar_blaster || _weapon==wep_ntte_quasar_rifle
        || _weapon==wep_ntte_quasar_cannon || _weapon==wep_ntte_ultra_quasar_rifle
}
function scrNTTEFullQuasarWeaponEpsilon() {
    static _epsilon=undefined
    if(is_undefined(_epsilon)) for(var _i=0;_i<=16;++_i) {
        _epsilon=power(10,-_i)
        if(_epsilon==0) break
    }
    return _epsilon
}
function scrNTTEFullQuasarWeaponFire(_weapon,_primary) {
    var _state=scrNTTEState(),_owner=scrNTTEFullElectroWeaponCreator(),
        _brain=scr_skill_get(mut_laser_brain),_dir=gunangle,_shot=noone
    switch(_weapon) {
        case wep_ntte_quasar_blaster:
            _shot=scrNTTEFullMergedBasicProjectileCreate(x,y,NTTEFullQuasarBeam,_dir+orandom(4*accuracy))
            _shot.ntte_full_primary=_primary;_shot.ntte_full_turn_factor=1/10
            _shot.ntte_full_shrink_delay=8;_shot.ntte_full_scale_goal=0.5;_shot.ntte_full_bend_friction=0.4
            _shot.image_xscale*=0.5;_shot.image_yscale*=0.5
            snd_play(_brain?sndLaserUpg:sndLaser,0.6+random(0.1));snd_play(sndPlasmaHit,1.5,0.6)
            scr_weapon_post(_dir,-12,4,12)
            break
        case wep_ntte_quasar_cannon:
            _shot=scrNTTEFullMergedBasicProjectileCreate(x,y,NTTEFullQuasarRing,_dir+orandom(8*accuracy),4)
            _shot.image_yscale=0;_shot.ntte_full_ring_size=0.6*power(1.2,_brain)
            scrNTTEFullCustomProjectileGunSound(_brain?sndPlasmaBigUpg:sndPlasmaBig,0.4,-0.5)
            scrNTTEFullCustomProjectileGunSound(_brain?sndLightningCannonUpg:sndLaser,0.4,-0.5)
            snd_play(sndExplosion,0.8,1.5);scr_weapon_post(_dir,-24,8,20)
            scrNTTEFullNativeMotionAddFT(id,_dir+180,5)
            break
        default:
            var _ultra=_weapon==wep_ntte_ultra_quasar_rifle,
                _beam=scrNTTEFullValue(_state,"beam",noone)
            if(!instance_exists(_beam) || _beam.creator!=_owner
                || (_primary && scrNTTEFullValue(id,"specfiring",false))) {
                _beam=scrNTTEFullMergedBasicProjectileCreate(x,y,
                    _ultra?NTTEFullUltraQuasarBeam:NTTEFullQuasarBeam,
                    _dir+(_ultra?0:orandom(6*accuracy)))
                if(_ultra) {
                    _beam.image_yscale=0;_beam.ntte_full_offset=32
                    _beam.ntte_full_scale_goal=0.3+0.1*_brain
                    snd_play(_brain?sndUltraLaserUpg:sndUltraLaser,0.4+random(0.1))
                    snd_play(_brain?sndPlasmaUpg:sndPlasma,1.2+random(0.2))
                    scr_weapon_post(_dir,-16,32,16);scrNTTEFullNativeMotionAddFT(id,_dir+180,4)
                    move_contact_solid(_dir+180,4)
                }
                else {
                    _beam.image_yscale=0.6;_beam.ntte_full_turn_factor=1/100;_beam.ntte_full_offset=16
                    snd_play(_brain?sndLaserUpg:sndLaser,0.4+random(0.1))
                    snd_play(_brain?sndPlasmaUpg:sndPlasma,1.2+random(0.2));snd_play(sndExplosion,1.5,0.5)
                    scr_weapon_post(_dir,-16,8,14);scrNTTEFullNativeMotionAddFT(id,_dir+180,3)
                }
                _state.beam=_beam
            }
            else if(_ultra) {
                var _add=1/15
                _beam.ntte_full_scale_goal=max(0.3,
                    (floor((_beam.image_yscale/power(1.2,_brain))/_add)+scrNTTEFullQuasarWeaponEpsilon()+1)*_add)
                _beam.ntte_full_flash=max(_beam.ntte_full_flash,current_frame+3)
                scrNTTEFullNativeMotionAddFT(id,_dir+180,2)
            }
            else {
                if(_beam.image_yscale<1) _beam.ntte_full_scale_goal=1
                else {
                    var _max=1+0.25*(1+0.4*_brain)
                    if(_beam.ntte_full_scale_goal<_max) {
                        _beam.ntte_full_scale_goal=min(
                            (floor((_beam.image_yscale/power(1.2,_brain))/0.25)+scrNTTEFullQuasarWeaponEpsilon()+1)*0.25,_max)
                        _beam.ntte_full_flash=max(_beam.ntte_full_flash,current_frame+2)
                    }
                }
                if(_beam.image_yscale<_beam.ntte_full_scale_goal) {
                    scrNTTEFullNativeMotionAddFT(id,_dir+180,2)
                    _beam.ntte_full_flash=max(_beam.ntte_full_flash,current_frame+3)
                }
            }
            _beam.ntte_full_shrink_delay=scr_weapon_get_load(_weapon)+1
            _beam.ntte_full_primary=_primary;_shot=_beam
            break
    }
    return _shot
}

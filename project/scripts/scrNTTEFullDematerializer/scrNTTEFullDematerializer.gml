// Literal source weps/dematerializer.wep.gml. The supplied MOD appears to
// contain an unfinished experiment: no-speed ElectroPlasma dies next Step.
// Preserve the actual source rather than inventing motion/lifetime exemptions.
function scrNTTEFullDematerializerFire(_primary=true) {
    var _owner=scrNTTEFullElectroWeaponCreator(),_last=scrNTTEFullValue(_owner,"electroplasma_last",noone),
        _side=scrNTTEFullValue(_owner,"electroplasma_side",1),_dir=gunangle+orandom(3*accuracy),
        _need=true,_shot=noone,_lifetime=scr_weapon_get_load(wep_ntte_dematerializer)+1
    // Original instances_matching_ne(obj.ElectroPlasma,"id") means all extant
    // ElectroPlasma, including ordinary shots/other creators/cannon descendants.
    with(NTTEFullElectroPlasma) {
        _need=false;ntte_demat_lifetime=_lifetime
    }
    if(_need) {
        _shot=scrNTTEFullMergedBasicProjectileCreate(x,y,NTTEFullElectroPlasma,_dir)
        with(_shot) {
            move_contact_solid(_dir,480)
            hyper="true";ntte_full_tether_range=1200;ntte_full_wave=0
            ntte_full_tether_inst=_owner;ntte_demat_lifetime=_lifetime
            _last=id
        }
    }
    _owner.electroplasma_last=_last;_owner.electroplasma_side=-_side
    var _brain=scr_skill_get(mut_laser_brain)>0
    scrNTTEFullCustomProjectileGunSound(_brain?sndLightningPistolUpg:sndLightningPistol,
        _brain?0.4:0.3,_brain?0.6:0.3)
    snd_play(sndEliteShielderFire,0.9+random(0.3));snd_play(sndGammaGutsProc,1+random(0.2))
    scr_weapon_post(gunangle,3,0,6);scrNTTEFullNativeMotionAddFT(id,gunangle+180,0.5)
    if(instance_exists(_shot)) _shot.primary=_primary
    return _shot
}
function scrNTTEFullDematerializerStep(_primary=true) {
    var _targets=[]
    with(NTTEFullElectroPlasma) if(variable_instance_exists(id,"ntte_demat_lifetime")
        && !is_undefined(ntte_demat_lifetime)) array_push(_targets,id)
    for(var _i=0;_i<array_length(_targets);++_i) {
        var _shot=_targets[_i]
        if(!instance_exists(_shot)) continue
        with(_shot) {
            // Avoid dereferencing a destroyed native instance; source normally
            // reaches its Electro lifetime condition before this can occur.
            if(ntte_demat_lifetime>0 && instance_exists(creator)) {
                x=creator.x;y=creator.y
                move_contact_solid(creator.gunangle,480)
                direction=creator.gunangle;image_angle=direction;ntte_full_wave=0
                ntte_demat_lifetime-=timescale
                with(creator) scr_weapon_post(gunangle,3,0,6)
            }
            else instance_destroy()
        }
    }
}
function scrNTTEFullDematerializerReloaded() {
    snd_play(sndLightningReload)
}

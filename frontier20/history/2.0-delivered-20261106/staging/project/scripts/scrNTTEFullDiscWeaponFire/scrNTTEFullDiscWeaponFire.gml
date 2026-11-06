// Original bat disc launcher/cannon and energy bat weapon_fire entries.
// weapon_post source arguments are kick, camera shift, shake.
function scrNTTEFullDiscWeaponSound(_sound,_pitch,_gain) {
    var _channel=snd_play(_sound,_pitch)
    if(_channel>=0) audio_sound_gain(_channel,UberCont.opt_sndvol*_gain,0)
}
function scrNTTEFullDiscWeaponFire(_weapon,_state,_primary) {
    var _big=_weapon==wep_ntte_sawblade_cannon,_cost=_big?7:1
    if(!scrNTTESpend(_state,_cost,true)) return noone
    var _disc=scrNTTEFullMergedBasicProjectileCreate(x,y,NTTEFullBatDisc,
        gunangle+orandom((_big?4:12)*accuracy))
    scrNTTEFullBatDiscBind(_disc,_state,_cost,(infammo || global.__debug_infammo)?0:_cost)
    _disc.big=_big;_disc.primary=_primary
    scrNTTEFullDiscWeaponSound(sndSuperDiscGun,(_big?0.6:0.8)+random(0.4),0.6)
    scrNTTEFullDiscWeaponSound(_big?sndNukeFire:sndRocket,1+random(0.6),0.8)
    if(_big) scrNTTEFullDiscWeaponSound(sndEnergyHammerUpg,0.8+random(0.4),0.6)
    scr_weapon_post(gunangle,_big?16:8,_big?12:8,_big?12:8)
    motion_set(gunangle+180,(_big?4:2)*timescale)
    repeat(irandom_range(_big?4:3,_big?8:6)) {
        var _smoke=instance_create(x,y,Smoke)
        with(_smoke) motion_set(other.gunangle+orandom(_big?32:24),random(_big?8:6)*timescale)
    }
    return _disc
}
function scrNTTEFullEnergyBatWeaponFire(_primary) {
    var _long=scr_skill_get(mut_long_arms),_angle=gunangle,
        _slash=scrNTTEFullMergedBasicProjectileCreate(x+lengthdir_x(20*_long,_angle),
            y+lengthdir_y(20*_long,_angle),NTTEFullEnergyBatSlash,_angle,lerp(2,5,_long))
    _slash.image_yscale*=sign(wepangle);_slash.primary=_primary
    var _brain=scr_skill_get(mut_laser_brain)>0
    scrNTTEFullDiscWeaponSound(_brain?sndEnergyHammerUpg:sndEnergyHammer,random_range(1.2,1.5),_brain?0.8:0.9)
    scrNTTEFullDiscWeaponSound(sndBlackSwordMega,random_range(0.5,0.7),_brain?0.3:0.2)
    _angle+=60*sign(wepangle)
    scr_weapon_post(gunangle,10,15,-4)
    scrNTTEFullNativeMotionAddFT(id,_angle,4)
    move_contact_solid(_angle,3)
    instance_create(x,y,Dust)
    return _slash
}
function scrNTTEFullPizzaDiscFire(_state,_primary) {
    var _disc=scrNTTEFullMergedBasicProjectileCreate(x,y,NTTEFullBatDisc,gunangle+orandom(4*accuracy))
    scrNTTEFullBatDiscBind(_disc,_state,1,(infammo || global.__debug_infammo)?0:1)
    _disc.primary=_primary
    return _disc
}
function scrNTTEFullBubbleBatWeaponFire(_primary) {
    var _long=scr_skill_get(mut_long_arms),_angle=gunangle,
        _slash=scrNTTEFullMergedBasicProjectileCreate(x+lengthdir_x(20*_long,_angle),
            y+lengthdir_y(20*_long,_angle),NTTEFullBubbleSlash,_angle,lerp(2,5,_long))
    _slash.image_yscale*=sign(wepangle);_slash.primary=_primary
    var _pitch=random_range(0.8,1.2)
    snd_play(sndOasisCrabAttack,1.6*_pitch);snd_play(sndOasisExplosionSmall,0.7*_pitch)
    snd_play(sndToxicBoltGas,2*_pitch);snd_play(sndHammer,1.2*_pitch)
    _angle+=60*sign(wepangle)
    scr_weapon_post(gunangle,10,15,-4)
    scrNTTEFullNativeMotionAddFT(id,_angle,3)
    move_contact_solid(_angle,3);instance_create(x,y,Dust)
    return _slash
}

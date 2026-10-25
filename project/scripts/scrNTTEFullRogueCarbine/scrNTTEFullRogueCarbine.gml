// weps/rogue carbine.wep.gml and tegeneral.mod.gml1657..1712.
function scrNTTEFullRogueBulletCreate() {
    sprite_index=sprNTTEIDPDHeavyBullet;spr_dead=sprNTTEIDPDHeavyBulletHit
    mask_index=mskBullet1;ntte_bloom=0.1;damage=7;force=12
    knockback_speed=12*timescale;typ=1;gland=2;temerge_object=HeavyBullet
    image_speed=timescale
}
function scrNTTEFullRogueBulletHit(_victim) {
    // Recovered original scrBulletCanHit is only strict different teams.
    // In particular it has no enemy health or immunity condition.
    if(lockstep_stop || !instance_exists(_victim) || _victim.team==team) return;
    if(gland!=0 && instance_is(creator,Player) && random(5)<3*scr_skill_get(mut_recycle_gland)) {
        // Epsilon scrWeapons declares typ_amax global; unlike NTT it is not
        // a player field. Use the same capacity table as scrPlayerGiveAmmo.
        if(creator.ammo[Ammo.Bullets]<typ_amax[Ammo.Bullets]) {
            creator.ammo[Ammo.Bullets]=min(creator.ammo[Ammo.Bullets]+gland,typ_amax[Ammo.Bullets])
            instance_create(x,y,RecycleGland);snd_play_hit(sndRecGlandProc,0.1)
        }
    }
    var _native=!scrNTTEFullRawHitCustom(_victim)
    scrNTTEFullNativeProjectileDirectHit(_victim,damage,knockback_speed/timescale,direction,0)
    if(_native && knockback_speed>0 && instance_exists(_victim)) with(_victim)
        speed=max(speed,16*timescale-friction*(1/timescale-1))
    instance_destroy()
}
function scrNTTEFullRogueBulletDestroy() {
    var _effect=instance_create(x,y,BulletHit);_effect.sprite_index=spr_dead
}
function scrNTTEFullRogueCarbineOne(_weapon,_primary=true,_burst=1,_context=undefined) {
    var _shot=scrNTTEFullMergedBasicProjectileCreate(x,y,NTTERogueCarbineBullet,gunangle+orandom(4*accuracy),16)
    _shot.gland=scr_weapon_get_cost(_weapon)/2
    var _sounds=[sndHeavyMachinegun,sndRogueRifle,sndGruntFire,sndIDPDNadeLoad],
        _pitches=[1.4,0.6,0.6,2.4],_spreads=[0.2,0.5,0.2,0.4]
    for(var _i=0;_i<4;++_i) {
        var _channel=scrNTTEFullCustomProjectileGunSound(_sounds[_i],0,0.3)
        var _pitch=_pitches[_i]+random(_spreads[_i])
        if(_channel>=0) audio_sound_pitch(_channel,_pitch)
    }
    scr_weapon_post(gunangle,-7,2,5)
    var _shell=instance_create(x,y,Shell);_shell.sprite_index=sprHeavyShell
    with(_shell) motion_add(other.gunangle+180+orandom(25),(2+random(3))*timescale)
    return _shot
}
function scrNTTEFullRogueCarbineFire(_primary=true) {
    scrNTTEFullNativeFireBurstStart(wep_ntte_rogue_carbine,2,2,_primary,scrNTTEFullRogueCarbineOne,undefined,2)
    return scrNTTEFullRogueCarbineOne(wep_ntte_rogue_carbine,_primary)
}

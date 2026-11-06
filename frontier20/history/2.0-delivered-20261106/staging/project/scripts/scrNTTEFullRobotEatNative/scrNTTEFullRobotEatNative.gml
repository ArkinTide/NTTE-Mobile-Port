// ntte.mod.gml3550..3605 and the six weapon_ntte_eat definitions.
// Called once per physical outer LWO. A merge front is not another meal.
function scrNTTEFullRobotEatCallbacks(_weapon,_auto_collect=false) {
    // Portal.Collision_Player dispatches its custom callback exactly once per
    // pickup, before the native per-Robot base rewards. Do not multiply it by
    // the number of Robots participating in the same portal entry.
    if(_auto_collect) return;
    scrNTTEFullRobotEatWeapon(_weapon)
}
function scrNTTEFullRobotEatWeapon(_weapon) {
    var _raw=scrNTTEFullWeaponRaw(_weapon)
    scrNTTEFullCrabboneExtraEat(_weapon)
    if(_raw==wep_ntte_entangler) scrNTTEFullEntanglerEat()
    if(scrNTTEIsScythe(_raw)) {
        repeat(3) {
            var _bone=instance_create(x,y,WepPickup)
            scrNTTEFullBoneDropVisual(_bone)
        }
        snd_play(sndMutant14Dead,1.4,0.5)
    }
    if(!instance_is(id,Portal)) {
        if(scrNTTEFullIsPortalWeapon(_raw)) {
            var _bullet=scrNTTEFullMergedBasicProjectileCreate(x,y,NTTEFullPortalBullet,random(360),20)
            with(_bullet) {
                event_perform(ev_other,ev_animation_end)
                move_contact_solid(direction,random_range(32,160))
                instance_destroy()
            }
            scrNTTEFullTrenchShake(x,y,30)
            snd_play(sndGuardianDead,0.6)
        }
        if(_raw==wep_ntte_ultra_quasar_rifle) scrNTTEFullRobotEatUltraQuasar(_weapon)
    }
    // Source weapon_get(red) may dynamically delegate to a merge front;
    // weapon_ntte_eat itself has no equivalent temerge wrapper.
    if(scrNTTEFullRedAmmoWeaponCost(_weapon)>0) instance_create(x,y,NTTEFullRedAmmoPickup)
}
function scrNTTEFullRobotEatUltraQuasar(_weapon) {
    var _state=undefined
    if(is_struct(_weapon) || scrNTTEFullWeaponIsNative(_weapon)) _state=scrNTTEFullWeaponNativeState(_weapon)
    else if(wep==_weapon) _state=ntte_state
    else if(bwep==_weapon) _state=bntte_state
    var _old_beam=scrNTTEFullValue(_state,"beam",noone),
        _goal=max(0.3,scrNTTEFullValue(_old_beam,"ntte_full_scale_goal",0)),
        _ring=scrNTTEFullMergedBasicProjectileCreate(x,y,NTTEFullQuasarRing,gunangle)
    _ring.image_yscale=0;_ring.sprite_index=scrNTTERefSprite("UltraQuasarBeam")
    _ring.ntte_full_trail=scrNTTERefSprite("UltraQuasarBeamTrail")
    _ring.ntte_full_follow=true;_ring.ntte_full_ultra=true;_ring.ntte_full_scale_goal=_goal
    _ring.ntte_full_ring_size=1.2*power(1.2,scr_skill_get(mut_throne_butt));_ring.ntte_full_shrink_delay=300
    var _sprite=scrNTTERefSprite("UltraQuasarBlasterEat")
    for(var _frame=0;_frame<sprite_get_number(_sprite);++_frame) {
        var _debris=instance_create(x,y,ScrapBossCorpse)
        with(_debris) {
            motion_set(random(360),(4+random(4))*timescale)
            sprite_index=_sprite;image_index=_frame;image_angle=random(360)
        }
    }
    var _clear=instance_create(x,y,PortalClear)
    _clear.image_xscale=2;_clear.image_yscale=2
    snd_play(sndUltraLaserUpg,0.4+random(0.1));snd_play(sndPlasmaHugeUpg,1.2+random(0.2));snd_play(sndMutant8Thrn)
}

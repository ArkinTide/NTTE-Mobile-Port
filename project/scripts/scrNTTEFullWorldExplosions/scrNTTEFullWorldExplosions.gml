// Exact teoasis BubbleExplosion/Small and tecaves PlasmaImpactSmall wrappers.
function scrNTTEFullBubbleExplosionCreate(_small) {
    // Called after damagesource.Create, deliberately bypassing modern Epsilon
    // Explosion/PopoExplosion constructors. Original9940 Popo only inherited
    // Explosion; Small's identity selected its no-debris, quarter-pixel branch.
    team=team_none; image_speed=0.4*timescale
    x+=orandom(_small ? 0.25:2); y+=orandom(_small ? 0.25:2)
    if(!_small) {
        repeat(10) {
            var _smoke=instance_create(x,y,Smoke)
            if(instance_exists(_smoke)) scrNTTEFullNativeMotionAddFT(_smoke,random(360),1+random(2))
        }
        var _angle=random(360)
        repeat(20) {
            var _dust=instance_create(x,y,Dust)
            if(instance_exists(_dust)) scrNTTEFullNativeMotionAddFT(_dust,_angle,6)
            _angle+=18
        }
    }
    scrNTTEFullTrenchShake(x,y,_small ? 3:7)
    scrNTTEFullCoastConstructExplosion()
    sprite_index=scrNTTERefSprite(_small ? "BubbleExplosionSmall":"BubbleExplosion")
    hitid=[sprite_index,_small ? "SMALL BUBBLE#EXPLOSION":"BUBBLE EXPLOSION"]
    mask_index=_small ? mskSmallExplosion:mskExplosion
    damage=3; knockback_speed=timescale; alarm[0]=_small ? 3:-1; alarm[1]=-1
    ntte_bubble_explosion_small=_small
    ntte_bubble_crown=!_small && scrCrownCheck(Crown.Death)
    if (_small) { snd_play(sndOasisExplosionSmall,1+random(2)); repeat(5) instance_create(x,y,Bubble) }
    else { snd_play(sndExplosionS,2); snd_play(sndOasisExplosion,1+random(1)); repeat(10) instance_create(x,y,Bubble) }
}

function scrNTTEFullBubbleExplosionHit(_target) {
    // scrExploCanHit only checks faction and the original30Hz damage phase.
    // It does not inspect hp, nexthurt, ordinary player damage procs or shields.
    if(lockstep_stop || !current_frame_active || !instance_exists(_target) || _target.team==team) return false
    var _player=_target.object_index==Player,_boil=_player && scr_skill_get(mut_boiling_veins)>0,
        _amount=damage,_radial=point_direction(x,y,_target.x,_target.y)
    if(ntte_bubble_explosion_small) {
        // SmallExplosion361 presents impact even if a boiling Player is in
        // the hurt animation. Only a new animation phase actually applies hit.
        sleep(3); scrNTTEFullTrenchShake(x,y,1)
        if(_boil) {
            if(_target.sprite_index==_target.spr_hurt) return false
            _amount=min(damage,max(0,_target.hp-_target.veinsthreshold))
        }
        scrNTTEFullNativeProjectileHitPush(_target,_amount,knockback_speed/timescale)
        if(_boil && instance_exists(_target)) _target.smoke=30
        return true
    }
    // Original Popo361 is a distinct raw hp/scrHurt path. In particular its
    // hardcoded FT6 and speed_min16 IGNORE authored force=1, and custom enemies
    // are not routed to the separate scrPushHit/on_hurt callback API.
    if(_boil && _target.sprite_index==_target.spr_hurt) return false
    if(_boil) {
        if(_target.hp>4) _target.hp=max(4,_target.hp-damage)
        _target.smoke=30
    }
    else _target.hp-=damage
    if(_player && !_boil) {
        _target.ntte_last_hit=hitid
        if(scr_player_is_local(_target.index) && damage>0) GameCont.deathcause=hitid
    }
    _target.nexthurt=current_frame+6
    if(!scrNTTEFullRawHitCustom(_target)
        && (!instance_is(_target,Turret) || _target.sprite_index!=_target.spr_fire)) {
        _target.sprite_index=_target.spr_hurt;_target.image_index=0
    }
    if(_player) with(_target) snd_play(snd_hurt)
    else with(_target) snd_play_hit(snd_hurt,0.2)
    scrNTTEFullNativeMotionAddFT(_target,_radial,6)
    with(_target) speed=max(speed,16*timescale-friction*(1/timescale-1))
    sleep(5);scrNTTEFullTrenchShake(_target.x,_target.y,2)
    return true
}

function scrNTTEFullBubbleExplosionProjectile(_target) {
    // Actual Popo250 removes every opposing projectile, including typ0 and
    // Grenade descendants. Its native event has no modern typ/grenade filter.
    if(lockstep_stop || !instance_exists(_target) || _target.team==team) return;
    instance_destroy(_target)
}

function scrNTTEFullBubbleExplosionRepel(_target) {
    if(lockstep_stop || !instance_exists(_target)) return;
    // Two original statements recalculate angle after changing x. They move
    // position by6*FT directly, not speed, friction, damage or team.
    x+=lengthdir_x(6*timescale,point_direction(_target.x,_target.y,x,y))
    y+=lengthdir_y(6*timescale,point_direction(_target.x,_target.y,x,y))
}

function scrNTTEFullBubbleExplosionSmallStep() {
    if (lockstep_stop) return;
    if(!place_meeting(x,y,projectile)) return;
    var _me=id,_targets=[]
    // instances_meeting_instance from the explosion side, followed by the
    // independently authored reverse-side place_meeting in the target scope.
    with(projectile) if(team!=other.team && typ!=0) array_push(_targets,id)
    for(var _i=0;_i<array_length(_targets);++_i) {
        var _target=_targets[_i]
        // Keep the complete source-ordered snapshot: a preceding projectile's
        // Destroy callback can move later entries. Reject distance only at the
        // same instant the old path would perform its exact mask query.
        if(instance_exists(_target) && _target.bbox_right>=bbox_left-1 && _target.bbox_left<=bbox_right+1
            && _target.bbox_bottom>=bbox_top-1 && _target.bbox_top<=bbox_bottom+1 && place_meeting(x,y,_target))
            with(_target) if(place_meeting(x,y,_me)) instance_destroy()
    }
}

function scrNTTEFullBubbleExplosionEndStep() {
    if (lockstep_stop || !ntte_bubble_crown) return;
    ntte_bubble_crown=false
    repeat(choose(2,3)) {
        var _child=instance_create(x+orandom(9),y+orandom(9),NTTEFullBubbleExplosionSmall)
        _child.team=team
    }
}

function scrNTTEFullPlasmaImpactSmallAfterCreate() {
    sprite_index=scrNTTERefSprite("PlasmaImpactSmall"); mask_index=scrNTTERefSprite("msk.PlasmaImpactSmall")
    damage=2; knockback_speed=6*timescale
}

function scrNTTEFullPlasmaImpactSmallHit(_target) {
    if (lockstep_stop || !scr_can_hit(_target)) return;
    if (scr_hit(_target,damage,hitid)) with (_target) motion_add_m(point_direction(other.x,other.y,x,y),other.knockback_speed,16*timescale)
}

function scrNTTEFullWorldExplosionSmoke() {
    var _crown=GameCont.crown,_before=instance_number(Scorch)
    GameCont.crown=Crown.Death
    var _big=instance_create(10080,10048,NTTEFullBubbleExplosion)
    assert(_big.damage==3 && _big.knockback_speed==timescale && _big.alarm[1]==-1 && instance_number(Scorch)==_before,"BubbleExplosion changed force/damage or left native scorch/crown duplication")
    _big.team=team_enemy
    _before=instance_number(NTTEFullBubbleExplosionSmall)
    with (_big) scrNTTEFullBubbleExplosionEndStep()
    var _new=instance_number(NTTEFullBubbleExplosionSmall)-_before
    assert(_new>=2 && _new<=3,"BubbleExplosion crown did not spawn2/3small bubbles")
    with (_big) scrNTTEFullBubbleExplosionEndStep()
    assert(instance_number(NTTEFullBubbleExplosionSmall)==_before+_new,"BubbleExplosion crown triggered more than once")
    with (NTTEFullBubbleExplosionSmall) assert(team==team_enemy && damage==3,"Small bubble explosion lost inherited team/damage")
    instance_destroy(_big,false); instance_destroy(NTTEFullBubbleExplosionSmall,false)
    var _small=instance_create(10080,10048,NTTEFullBubbleExplosionSmall)
    _small.team=team_player
    var _hostile=instance_create(_small.x,_small.y,NTTEVenomPellet),_friendly=instance_create(_small.x,_small.y,NTTEVenomPellet),_zero=instance_create(_small.x,_small.y,NTTEVenomPellet)
    _hostile.team=team_enemy; _friendly.team=team_player; _zero.team=team_enemy; _zero.typ=0
    // Native original mskSmallExplosion uses separate per-frame masks: frame0
    // is transparent, only frame1 is active. Exercise both collision phases.
    _small.image_index=0
    with (_small) scrNTTEFullBubbleExplosionSmallStep()
    assert(instance_exists(_hostile),"Small bubble killed a projectile before its active collision frame")
    _small.image_index=1
    with (_small) scrNTTEFullBubbleExplosionSmallStep()
    assert(!instance_exists(_hostile) && instance_exists(_friendly) && instance_exists(_zero),"Small bubble explosion projectile faction/type filtering changed")
    var _frame=current_frame,_victim=instance_create(_small.x+8,_small.y,NTTEFullCrystalPropRed)
    _victim.hp=20; _victim.max_hp=20; _victim.speed=0; current_frame=0
    with (_small) scrNTTEFullBubbleExplosionHit(_victim)
    // Default GML epsilon is1e-5: a strict <1e-5 rejects even zero as
    // epsilon-equal to the threshold. Use inclusive precision comparison.
    var _expected_speed=timescale+(1-timescale)*_victim.friction/2
    assert(_victim.hp==17 && abs(_victim.speed-_expected_speed)<=0.00001,"Small BubbleExplosion original3damage/FT1force hit changed")
    if (timescale<1) {
        current_frame=timescale
        with (_small) scrNTTEFullBubbleExplosionHit(_victim)
        assert(_victim.hp==17,"BubbleExplosion multiplied damage between logical30Hz ticks")
    }
    current_frame=_frame; instance_destroy(_victim,false)
    instance_destroy(_friendly,false); instance_destroy(_zero,false); instance_destroy(_small,false)
    var _impact=instance_create(10080,10048,NTTEFullPlasmaImpactSmall)
    assert(_impact.damage==2 && _impact.knockback_speed==6*timescale && _impact.mask_index==scrNTTERefSprite("msk.PlasmaImpactSmall"),"Small plasma damage/force/mask changed")
    instance_destroy(_impact,false); GameCont.crown=_crown
    scrNTTESmokeLog("FULL WORLD BUBBLE EXPLOSION3DAMAGE/1FORCE/NO SCORCH/CROWN2-3/ONCE + SMALL FACTIONS/TYP0 + SMALL PLASMA2/6/MASK OK")
}

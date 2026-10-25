// NTTE 2.062 tesewers: Bat and BatScreech. Timers use 30 Hz logical frames.
function scrNTTEBatCreate() {
    max_hp=30; raddrop=12; size=2; meleedamage=0
    spr_idle=sprNTTEBatIdle; spr_walk=sprNTTEBatWalk
    spr_hurt=sprNTTEBatHurt; spr_dead=sprNTTEBatDead
    spr_fire=sprNTTEBatYell; spr_weap=sprNTTEBatWeap; spr_shadow=shd48
    mask_index=mskScorpion; sprite_index=spr_idle; depth=-2
    hitid=[spr_idle,"BAT"]
    walk=0; ntte_bat_stress=20; ntte_bat_canfire=false
    ntte_bat_timer=60; ntte_bat_yell=0; ntte_bat_shots=0; ntte_bat_screeches=0
}

function scrNTTEBatAfterCreate() {
    spr_shadow=shd48
    gunangle=random(360); direction=gunangle
    snd_hurt=sndSuperFireballerHurt; snd_dead=sndFrogEggDead
    alarm[1]=-1; alarm[2]=-1
}

function scrNTTEBatScreech(_scale=1) {
    var _p=scr_projectile_create(x,y,NTTEBatScreech,0,0)
    _p.image_xscale=_scale; _p.image_yscale=_scale
    var _cat=instance_nearest(x,y,NTTECat)
    if (instance_exists(_cat) && _cat.team==team) _cat.ntte_cat_cantravel=true
    sprite_index=spr_fire; image_index=0; ntte_bat_yell=15
    ++ntte_bat_screeches
    snd_play(sndNothing2Hurt,random_range(1.4,1.6))
    snd_play(sndSnowTankShoot,random_range(0.8,1.2))
    scr_screenshake(16)
    return _p
}

function scrNTTEBatDecision() {
    scrTarget()
    ntte_bat_timer=20+irandom(30)
    if (ntte_bat_canfire) {
        snd_play(sndRustyRevolver,0.8)
        snd_play(sndSnowTankShoot,1.2)
        snd_play(sndFrogEggHurt,random_range(1,1.4))
        for(var _i=0;_i<=5;++_i) {
            var _p=scr_projectile_create(x,y,NTTEVenomPellet,gunangle+orandom(2+_i),2*_i)
            with (_p) {
                move_contact_solid(direction,4+4*_i)
                var _fx=instance_create(x,y,AcidStreak)
                with (_fx) motion_set(other.direction+orandom(4),other.speed*0.8)
                if (_i<=2) {
                    _fx=instance_create(x,y,Smoke)
                    with (_fx) motion_set(other.direction+orandom(8*_i),(4-_i)*timescale)
                }
            }
        }
        wkick+=7; ++ntte_bat_shots
        var _shell=instance_create(x,y,Shell)
        _shell.sprite_index=sprShotShell
        with (_shell) motion_set(other.gunangle+130*choose(-1,1)+orandom(20),5*timescale)
        ntte_bat_canfire=false
        return;
    }
    if (instance_exists(target) && scrTargetIsVisible(target)) {
        scrNTTESewerLook(point_direction(x,y,target.x,target.y))
        var _distance=point_distance(x,y,target.x,target.y)
        if (_distance>72) {
            if (random(5)<4) scrNTTESewerWalk(gunangle+orandom(8),random_range(15,35))
        }
        else if (_distance<48) {
            scrNTTESewerWalk(gunangle+180+orandom(12),random_range(10,15))
            ntte_bat_timer=walk
        }
        if (random(5)<2 && _distance>48 && _distance<192) {
            ntte_bat_timer=10; ntte_bat_canfire=true
            scrNTTEFX(sprAssassinNotice,x+4*right,y)
            snd_play_hit(sndShotReload,0.2)
        }
        else if (irandom(max(0,ntte_bat_stress))>=15) {
            ntte_bat_stress-=8
            scrNTTEBatScreech()
            with (NTTEBat) if (id!=other.id) ntte_bat_stress=max(ntte_bat_stress-4,10)
        }
        else ntte_bat_stress+=4
    }
    else {
        var _cat=instance_nearest(x,y,NTTECat)
        if (instance_exists(_cat) && _cat.team==team && _cat.ntte_cat_active
            && point_distance(x,y,_cat.x,_cat.y)>64 && !collision_line(x,y,_cat.x,_cat.y,Wall,false,false))
            scrNTTESewerWalk(point_direction(x,y,_cat.x,_cat.y)+orandom(8),random_range(15,35))
        else if (random(3)<1) scrNTTESewerWalk(direction+orandom(24),random_range(10,30))
        scrNTTESewerLook(direction)
    }
}

function scrNTTEBatStep() {
    if (lockstep_stop || hp<=0) return;
    if (walk>0) { walk-=timescale; motion_add(direction,0.8*timescale*timescale) }
    speed=min(speed,2.5*timescale)
    if (speed>0 && place_meeting(x+hspeed,y+vspeed,Wall)) {
        if (place_meeting(x+hspeed,y,Wall)) hspeed*=-1
        if (place_meeting(x,y+vspeed,Wall)) vspeed*=-1
    }
    ntte_bat_yell=max(0,ntte_bat_yell-timescale)
    if (ntte_bat_yell>0) sprite_index=spr_fire
    else if (sprite_index==spr_fire) { sprite_index=spr_idle; image_index=0 }
    ntte_bat_timer-=timescale
    if (ntte_bat_timer<=0) scrNTTEBatDecision()
}

function scrNTTEBatHurt(_amount,_attacker) {
    ntte_bat_stress+=_amount
    if (instance_exists(_attacker) && instance_is(_attacker,ToxicGas)) {
        ntte_bat_stress-=4; nexthurt=current_frame+6
        scrNTTEBatScreech(0.5)
    }
}

function scrNTTEBatDraw() {
    if (lockstep_stop) return;
    if (gunangle>180) draw_sprite_ext(sprite_index,image_index,x,y,right,1,0,image_blend,image_alpha)
    draw_sprite_ext(spr_weap,0,x+lengthdir_x(-wkick,gunangle),y+lengthdir_y(-wkick,gunangle),1,right,gunangle,image_blend,image_alpha)
    if (gunangle<=180) draw_sprite_ext(sprite_index,image_index,x,y,right,1,0,image_blend,image_alpha)
}

function scrNTTEBatScreechCreate() {
    sprite_index=sprNTTEBatScreech; mask_index=mskNTTEBatScreech
    image_speed=0.4*timescale; image_alpha=0.4; depth=-9
    typ=0; damage=0; ntte_bat_force=1; candeflect=false
    hitid=[sprite_index,"SOUND"]; ntte_bat_age=0
}

function scrNTTEBatScreechProjectile(_p) {
    if (lockstep_stop || !instance_exists(_p) || _p==id) return;
    if (_p.typ!=1 && _p.typ!=2) return;
    var _grenade=instance_is(_p,Grenade)
    if (_grenade && !candeflect && _p.team==team) return;
    if (candeflect) {
        with (_p) {
            deflected=true
            direction=point_direction(other.x,other.y,x,y); image_angle=direction
            if (instance_is(id,Grenade)) {
                speed=10*timescale; friction=0.1*timescale*timescale; alarm[1]=6
            }
            else team=other.team
            instance_create(x,y,Deflect)
        }
    }
    else {
        // A whole thrown weapon still becomes one reachable physical pickup.
        if (instance_is(_p,NTTEAttack) && scrNTTEIsGroundWeapon(_p.weapon)) {
            with (_p) { target=noone; scrNTTEThrowLand() }
            return;
        }
        if (instance_is(_p,ToxicGas)) {
            var _fx=instance_create(_p.x,_p.y,BulletHit)
            _fx.sprite_index=sprExploderExplo; _fx.image_index=2
        }
        else {
            repeat(2) {
                var _dust=instance_create(_p.x,_p.y,Dust)
                with (_dust) { motion_set(_p.direction+orandom(8),random(min(8*timescale,_p.speed))); friction=0.4*timescale*timescale }
            }
            instance_create(_p.x,_p.y,ThrowHit)
        }
        instance_destroy(_p)
    }
}

function scrNTTEBatScreechHit(_victim) {
    if (lockstep_stop || !scr_can_hit(_victim,false)) return;
    // GuardianDeath/PortalBullet use the same original BatScreech with damage
    // enabled. The ordinary bat's zero-damage wave keeps its continuous push.
    if (damage>0 && scr_can_hit(_victim,true)) {
        scr_projectile_hit(_victim,damage,ntte_bat_force*timescale,
            point_direction(x,y,_victim.x,_victim.y))
        return;
    }
    with (_victim) motion_add(point_direction(other.x,other.y,x,y),other.ntte_bat_force*timescale*timescale)
}

// NTTE 2.062 tesewers: BabyGator and BoneGator in Epsilon's native hierarchy.
function scrNTTESewerCreate(_bone) {
    ntte_gator_bone=_bone
    max_hp=_bone ? 24:12
    raddrop=_bone ? 6:2
    size=_bone ? 2:0
    meleedamage=0
    mask_index=_bone ? mskBandit:mskMaggot
    spr_idle=_bone ? sprNTTEBoneGatorIdle:sprNTTEBabyGatorIdle
    spr_walk=_bone ? sprNTTEBoneGatorWalk:sprNTTEBabyGatorWalk
    spr_hurt=_bone ? sprNTTEBoneGatorHurt:sprNTTEBabyGatorHurt
    spr_dead=_bone ? sprNTTEBoneGatorDead:sprNTTEBabyGatorDead
    spr_weap=_bone ? sprNTTEBoneGatorWeap:sprNTTEBabyGatorWeap
    spr_shadow=_bone ? shd24:shd16
    spr_shadow_y=_bone ? 0:1
    hitid=[spr_idle,_bone ? "BONE GATOR":"BABY GATOR"]
    sprite_index=spr_idle
    ntte_gator_timer=30
    ntte_gator_ammo=0
    ntte_gator_heal=0
    ntte_gator_shots=0
    ntte_gator_final=0
    ntte_gator_dead=false
    ntte_gator_den=false
    ntte_gator_awake=true
    walk=0; walkspeed=_bone ? 0.8:1.2; maxspeed=_bone ? 3.6:3.4
    z=0; maxz=12; zspeed=0; zfriction=0.5; zbounce=0
    kick_invul=current_frame+30
    direction=random(360)
    depth=-2
}

function scrNTTESewerAfterCreate() {
    // hitme.Create resets shadow fields; apply the original small shadow last.
    spr_shadow=ntte_gator_bone ? shd24:shd16
    spr_shadow_x=0; spr_shadow_y=ntte_gator_bone ? 0:1
    gunangle=direction
    snd_hurt=ntte_gator_bone ? sndGatorHit:sndHitFlesh
    snd_dead=sndGatorDie
    alarm[1]=-1
    alarm[2]=-1
}

function scrNTTESewerLook(_angle) {
    gunangle=(_angle+360) mod 360
    if (abs(lengthdir_x(1,gunangle))>0.001) right=sign(lengthdir_x(1,gunangle))
}

function scrNTTESewerWalk(_angle,_time) {
    direction=_angle
    walk=_time
}

function scrNTTESewerDecision() {
    scrTarget()
    var _seen=instance_exists(target) && scrTargetIsVisible(target),
        _distance=instance_exists(target) ? point_distance(x,y,target.x,target.y):infinity,
        _angle=instance_exists(target) ? point_direction(x,y,target.x,target.y):gunangle
    if (!ntte_gator_bone) {
        ntte_gator_timer=30+random(60)
        if (_seen && _distance<160) {
            scrNTTESewerLook(_angle)
            if (random(2)<1) {
                var _d=gunangle+orandom(12),_x=x+lengthdir_x(8,_d),_y=y+lengthdir_y(8,_d)
                scr_projectile_create(_x,_y,LHBouncer,_d,3)
                var _smoke=instance_create(_x,_y,Smoke)
                with (_smoke) motion_set(_d,2*timescale)
                snd_play_hit(sndBouncerSmg,0.2)
                motion_add(gunangle+180,2*timescale)
                wkick=6
                ++ntte_gator_shots
            }
            else if (random(3)<1) {
                scrNTTESewerWalk(random(360),random_range(30,70))
                scrNTTESewerLook(direction)
            }
        }
        else {
            scrNTTESewerWalk(direction+orandom(60),random_range(40,70))
            scrNTTESewerLook(direction)
        }
        return;
    }
    ntte_gator_timer=20+random(20)
    if (ntte_gator_ammo>0) {
        --ntte_gator_ammo
        ntte_gator_timer=4
        if (instance_exists(target)) scrNTTESewerLook(gunangle+clamp(angle_difference(_angle,gunangle),-20,20)+orandom(5))
        var _x=x+lengthdir_x(6,gunangle),_y=y+lengthdir_y(6,gunangle),_p=noone
        if (ntte_gator_ammo<=0) {
            _p=scr_projectile_create(_x,_y,Grenade,gunangle,9)
            _p.alarm[0]=10+random(10)
            ntte_gator_timer=20
            wkick=12
            motion_add(gunangle+180,4*timescale)
            snd_play(sndGrenadeShotgun,random_range(0.8,1.2))
            snd_play(sndFlamerStop,random_range(0.8,1.2))
            ++ntte_gator_final
        }
        else {
            // NTT MiniNade's native Epsilon counterpart: SmallGrenade,
            // 5 impact damage, short 10..20 fuse and SmallExplosion.
            _p=scr_projectile_create(_x,_y,SmallGrenade,gunangle,7+random(2))
            wkick=6
            motion_add(gunangle+180,timescale)
            snd_play(sndGrenadeRifle,random_range(0.8,1.2))
        }
        ++ntte_gator_shots
        var _fire=scr_projectile_create(_x,_y,TrapFire,gunangle,random(1))
        _fire.image_speed=0.4*timescale
        repeat(1+irandom(2)) instance_create(_x,_y,Smoke)
        return;
    }
    if (!instance_exists(target)) return;
    if (_seen) {
        scrNTTESewerLook(_angle)
        if (_distance<192) {
            if (_distance<128 || random(5)<1) {
                ntte_gator_timer=12
                ntte_gator_ammo=6
                scrNTTEFX(sprAssassinNotice,x,y)
                snd_play(sndDragonStart,random_range(0.8,1.2))
            }
            else scrNTTESewerWalk(gunangle+orandom(20),random_range(30,50))
            if (_distance<32) scrNTTESewerWalk(gunangle+180+orandom(30),random_range(20,50))
        }
        else scrNTTESewerWalk(gunangle+orandom(60),random_range(20,50))
    }
    else if (random(5)<2) {
        ntte_gator_timer+=random(10)
        scrNTTESewerWalk(direction+orandom(40),random_range(20,40))
        scrNTTESewerLook(direction)
    }
}

function scrNTTESewerStep() {
    if (lockstep_stop || hp<=0) return;
    if (scrNTTEFullValue(id,"ntte_full_den_hold",false)) return;
    if (ntte_gator_den && !ntte_gator_awake) {
        var _p=instance_nearest(x,y,Player)
        if (hp<max_hp || (instance_exists(_p) && point_distance(x,y,_p.x,_p.y)<=80)) {
            scrNTTESewerWakeDen()
            ntte_gator_timer=15+random(15)
        }
        else { speed=0; return; }
    }
    if (!ntte_gator_bone) {
        if (current_frame>=kick_invul && z<=0) {
            with (Player) if (team!=other.team && speed>0 && place_meeting(x,y,other.id) && scr_can_hit(other.id,true)) {
                scr_projectile_hit(other.id,3,speed,direction)
                other.zspeed=3
                other.zbounce=1
                instance_create(x,y,ImpactWrists)
                var _streak=scrNTTEFullSystemsCreate("WaterStreak",x,y)
                with (_streak) motion_set(other.direction,4*timescale)
                snd_play_hit(sndImpWristKill,0.3)
                scrNTTEFullTrenchShake(x,y,20); sleep(20)
            }
        }
        if (z>0 || zspeed>0) {
            z=min(14,z+zspeed*timescale)
            zspeed-=0.5*timescale
            if (z<=0 && zbounce>0) {
                scr_hit_self(1)
                zspeed=1.6*zbounce
                zbounce=0
                instance_create(x,y,ThrowHit)
                snd_play_hit(sndImpWristHit,0.3)
                scrNTTEFullTrenchShake(x,y,10)
            }
            z=max(0,z)
        }
        if (z>0) motion_add(direction,abs(zspeed)*timescale*timescale)
    }
    if (z<=0) {
        if (walk>0) {
            walk-=timescale
            motion_add(direction,(ntte_gator_bone ? 0.8:1.2)*timescale*timescale)
        }
        ntte_gator_timer-=timescale
    }
    speed=min(speed,(ntte_gator_bone ? 3.6:3.4)*timescale)
    if (!ntte_gator_bone && place_meeting(x+hspeed,y+vspeed,Wall)) {
        // Source uses its unscaled velocity for collision prediction; native
        // Epsilon hspeed/vspeed already contain the current logical scale.
        if (place_meeting(x+hspeed,y,Wall)) hspeed=-hspeed
        if (place_meeting(x,y+vspeed,Wall)) vspeed=-vspeed
        scrNTTESewerLook(direction)
    }
    if (ntte_gator_timer<=0) scrNTTESewerDecision()
}

function scrNTTESewerDraw() {
    if (lockstep_stop) return;
    var _y=y-z,_angle=image_angle+((!ntte_gator_bone && z>0) ? right*current_frame*12:0)
    if (gunangle>180) draw_sprite_ext(sprite_index,image_index,x,_y,image_xscale*right,image_yscale,_angle,image_blend,image_alpha)
    draw_sprite_ext(spr_weap,0,x+lengthdir_x(-wkick,gunangle),_y+lengthdir_y(-wkick,gunangle),1,right,gunangle,image_blend,image_alpha)
    if (gunangle<=180) draw_sprite_ext(sprite_index,image_index,x,_y,image_xscale*right,image_yscale,_angle,image_blend,image_alpha)
}

function scrNTTESewerDeath() {
    if (hp>0 || ntte_gator_dead || !instance_exists(GameCont)) return;
    ntte_gator_dead=true
    if (!ntte_gator_bone) {
        snd_play(snd_hurt,1.3+random(0.3)); snd_hurt=-1
        scrDrop(20,0)
        if (place_free(x,y-z/2)) { y-=z/2; vspeed+=z/5; speed/=max(1,z/10) }
        return;
    }
    // A true death explodes; silent generation/room cleanup never invokes this.
    var _e=scr_projectile_create(x,y,Explosion)
    _e.team=-1
    repeat(1+irandom(2)) {
        _e=scr_projectile_create(x,y,SmallExplosion)
        _e.team=-1
    }
    for(var _d=0;_d<360;_d+=18) {
        var _x=x+lengthdir_x(12,_d),_y=y+lengthdir_y(12,_d)
        if (position_meeting(_x,_y,Floor)) scr_projectile_create(_x,_y,TrapFire,_d+random_range(60,90),random(2))
    }
    snd_play(sndExplosionL)
    snd_play(sndFlameCannonEnd)
    scr_screenshake(20)
    scrDrop(16,0)
    if (random(40)<1) scrWeaponPickupCreate(x,y,wep_ntte_bone)
}

// Called by scr_hit in the attacker's context, before subtracting health.
function scrNTTESewerInterceptHit(_victim) {
    if (instance_is(_victim,NTTEBoneGator) && instance_is(id,Explosion)) {
        with (_victim) if (ntte_gator_heal<=current_frame) {
            hp=min(max_hp,hp+12)
            ntte_gator_heal=current_frame+8
            var _fx=instance_create(x,y,HealFX)
            _fx.sprite_index=sprNTTEBoneGatorHeal
            _fx.depth=-8
            snd_play_hit(sndBurn,0.2)
        }
        return true
    }
    if (instance_is(_victim,NTTEBabyGator) && _victim.speed>0) {
        _victim.zspeed=3
        _victim.zbounce=1
    }
    return false
}

// Native counterparts of NTTE 2.062 tedesert objects. All timers use logical frames.
function scrNTTEDesertEnemyCreate(_kind) {
    ntte_desert_kind=_kind
    ntte_ai_timer=40+random(30)
    ntte_burst=0
    ntte_shots=0
    ntte_walk=0
    ntte_spawn_budget=10
    ntte_dead_done=false
    walk=0
    if (_kind==0) {
        max_hp=7; raddrop=4; size=1; meleedamage=6
        spr_idle=sprNTTEBabyScorpionIdle; spr_walk=sprNTTEBabyScorpionWalk
        spr_hurt=sprNTTEBabyScorpionHurt; spr_dead=sprNTTEBabyScorpionDead
        spr_fire=sprNTTEBabyScorpionFire
        mask_index=mskBandit
        hitid=[spr_idle,"BABY SCORPION"]
    }
    else if (_kind==1) {
        max_hp=70; raddrop=20; size=3; meleedamage=5
        spr_idle=sprNTTESilverScorpionIdle; spr_walk=sprNTTESilverScorpionWalk
        spr_hurt=sprNTTESilverScorpionHurt; spr_dead=sprNTTESilverScorpionDead
        spr_fire=sprNTTESilverScorpionFire
        mask_index=mskScorpion
        ntte_ai_timer=90
        hitid=[spr_idle,"SILVER SCORPION"]
    }
    else {
        max_hp=42; raddrop=6; size=4; meleedamage=0
        spr_idle=sprNTTEBigMaggotNestIdle; spr_walk=spr_idle
        spr_hurt=sprNTTEBigMaggotNestHurt; spr_dead=sprNTTEBigMaggotNestDead
        spr_fire=sprNTTEBigMaggotNestChrg
        mask_index=mskScrapBoss
        ntte_ai_timer=150
        hitid=[spr_idle,"BIG MAGGOT NEST"]
    }
    sprite_index=spr_idle
    image_speed=0.4*timescale
    depth=-2
    gunangle=random(360)
    direction=gunangle
    spr_shadow=_kind==1 ? shd48:(_kind==2 ? shd64B:shd24)
}

function scrNTTEDesertEnemySounds() {
    snd_hurt=ntte_desert_kind==2 ? sndHitFlesh:sndScorpionHit
    snd_dead=ntte_desert_kind==2 ? sndBigMaggotDie:sndScorpionDie
    snd_mele=sndScorpionMelee
    alarm[1]=-1
    alarm[2]=-1
}

function scrNTTEDesertEnemyStep() {
    if (lockstep_stop || hp<=0) return;
    ntte_ai_timer-=timescale
    var _kind=ntte_desert_kind
    if (_kind==2) {
        speed=0
        // A finite budget prevents a living nest from producing unbounded mobs.
        if (ntte_ai_timer<=20 && ntte_spawn_budget>0) sprite_index=spr_fire
        if (ntte_ai_timer<=0) {
            var _p=instance_nearest(x,y,Player)
            if (ntte_spawn_budget>0 && instance_exists(_p) && point_distance(x,y,_p.x,_p.y)<480) {
                if (instance_number(Maggot)<32) {
                    repeat(2) {
                        var _a=random(360),_m=instance_create(x+lengthdir_x(32,_a),y+lengthdir_y(32,_a),Maggot)
                        _m.creator=id
                        _m.raddrop=0
                        scrNTTEDesertBudge(_m)
                    }
                    ntte_spawn_budget-=2
                    snd_play(sndMaggotSpawnIdle,1,0.25)
                }
            }
            sprite_index=spr_idle
            ntte_ai_timer=150
        }
        return;
    }
    if (ntte_walk>0) {
        ntte_walk-=timescale
        motion_add(direction,(_kind==1 ? 1.2:0.8)*timescale*timescale)
    }
    speed=min(speed,(_kind==1 ? 2.5:2.4)*timescale)
    if (ntte_ai_timer>0) return;
    scrTarget()
    var _seen=instance_exists(target) && scrTargetIsVisible(target,_kind==1 ? 320:160)
    if (_seen) {
        gunangle=point_direction(x,y,target.x+target.hspeed,target.y+target.vspeed)
        if (target.x!=x) right=sign(target.x-x)
    }
    if (ntte_burst>0) {
        --ntte_burst
        ++ntte_shots
        if (_kind==1) {
            scr_projectile_create(x,y,EnemyBullet2,gunangle+random_range(20,140)*((ntte_burst mod 2) ? -1:1),3)
            ntte_ai_timer=3
        }
        else {
            var _gold=instance_is(id,NTTEBabyScorpionGold),_count=_gold ? 3:1
            for(var _i=0;_i<_count;++_i) {
                var _dir=gunangle+(_gold ? (_i-1)*40:orandom(20))
                scr_projectile_create(x,y,NTTEVenomPellet,_dir,random_range(7,11))
            }
            direction=gunangle+orandom(10)
            ntte_walk=5
            ntte_ai_timer=_gold ? 2:random_range(1,3)
        }
        sprite_index=spr_fire
        snd_play(sndScorpionFire,1.4,0.4)
        if (ntte_burst<=0) {
            ntte_ai_timer=_kind==1 ? random_range(75,120):random_range(20,40)
            sprite_index=spr_idle
        }
        return;
    }
    var _distance=_seen ? point_distance(x,y,target.x,target.y):1000
    if (_seen && _distance>32 && _distance<(_kind==1 ? 300:112)) {
        ntte_burst=_kind==1 ? 10:6+irandom(2)
        ntte_ai_timer=_kind==1 ? 20:8 // readable wind-up before the first shot
        sprite_index=spr_fire
        if (_kind==1) {
            var _orb=scr_projectile_create(x,y,NTTEScorpionOrb,gunangle,3)
            _orb.ntte_charge=30
        }
        snd_play(sndScorpionFireStart,1.4)
    }
    else {
        direction=_seen ? gunangle+(_distance<=32 ? 180:0)+orandom(40):random(360)
        ntte_walk=random_range(15,30)
        ntte_ai_timer=random_range(30,60)
    }
}

function scrNTTEDesertBudge(_inst) {
    if (!instance_exists(_inst)) return false
    var _ox=_inst.x,_oy=_inst.y,_ok=false
    with (_inst) {
        for(var _r=0;_r<=64;_r+=8) {
            for(var _i=0;_i<8;++_i) {
                var _a=_i*45
                x=_ox+lengthdir_x(_r,_a)
                y=_oy+lengthdir_y(_r,_a)
                if (position_meeting(x,y,Floor) && !place_meeting(x,y,Wall)) { _ok=true; break }
            }
            if (_ok) break
        }
        if (!_ok) { x=_ox; y=_oy }
        xprevious=x; yprevious=y; xstart=x; ystart=y
    }
    return _ok
}

function scrNTTEDesertNestDeath() {
    if (hp>0 || ntte_dead_done || !instance_exists(GameCont)) return;
    ntte_dead_done=true
    repeat(2) {
        var _a=random(360),_m=instance_create(x+lengthdir_x(24,_a),y+lengthdir_y(24,_a),BigMaggot)
        _m.raddrop=4
        scrNTTEDesertBudge(_m)
    }
    scrDrop(50,35)
    scrDrop(100,0)
}

function scrNTTEDesertPropCreate(_kind) {
    ntte_prop_kind=_kind
    ntte_chest=noone
    ntte_prop_done=false
    size=1
    if (_kind==0) {
        max_hp=6
        spr_idle=sprNTTEBanditTent; spr_hurt=sprNTTEBanditTentHurt; spr_dead=sprNTTEBanditTentDead
        mask_index=mskBandit
    }
    else if (_kind==1) {
        max_hp=24
        spr_idle=sprNTTEBigCactus; spr_hurt=spr_idle; spr_dead=sprNTTEBigCactusDead
        mask_index=mskScorpion
        size=2
    }
    else {
        max_hp=32
        spr_idle=sprNTTEScorpionRock; spr_hurt=spr_idle; spr_dead=sprNTTEScorpionRockDead
        mask_index=mskScorpion
    }
    sprite_index=spr_idle
    image_speed=0.4*timescale
    depth=-1
}

function scrNTTEDesertPropDeath() {
    if (hp>0 || ntte_prop_done || !instance_exists(GameCont)) return;
    ntte_prop_done=true
    if (ntte_prop_kind==2 && instance_exists(Player)) {
        var _p=instance_create(x,y,NTTEBabyScorpion)
        scrNTTEDesertBudge(_p)
        repeat(2) {
            var _m=instance_create(x+orandom(12),y+orandom(12),Maggot)
            scrNTTEDesertBudge(_m)
        }
        scrDrop(60,10)
    }
    repeat(3) instance_create(x+orandom(8),y+orandom(8),Dust)
}

function scrNTTEHikerStep() {
    if (lockstep_stop || hp<=0) return;
    // Native Bandit supplies firing and movement; add faster decisions and bounded
    // wall-following rather than invoking NTT's dynamic pathfinding library.
    if (current_frame_active && alarm[1]>1) alarm[1]-=1
    if (walk>0 && instance_exists(target) && !scrTargetIsVisible(target,600)) {
        var _dir=point_direction(x,y,target.x,target.y)
        for(var _i=0;_i<5;++_i) {
            var _test=_dir+choose(-1,1)*_i*45
            if (!place_meeting(x+lengthdir_x(24,_test),y+lengthdir_y(24,_test),Wall)) {
                direction=angle_lerp(direction,_test,min(1,0.25*timescale))
                break
            }
        }
    }
}

function scrNTTECamperEndStep() {
    if (lockstep_stop || hp<=0 || !instance_exists(ntte_mount)) return;
    if (ntte_mount.hp<=0) { ntte_mount=noone; return; }
    x=ntte_mount.x-(ntte_mount.speed<=0 ? 2:1)*ntte_mount.right
    y=ntte_mount.y-(ntte_mount.speed<=0 ? 10:8)
    xprevious=x; yprevious=y
    speed=0
    right=ntte_mount.right
    depth=ntte_mount.depth-1
    if (sprite_index!=spr_hurt) sprite_index=ntte_mount.speed<=0 ? spr_idle:spr_walk
}

function scrNTTEScorpionOrbStep() {
    if (lockstep_stop) return;
    ntte_orb_age+=timescale
    if (ntte_orb_age<ntte_charge) {
        speed=max(0,speed-0.2*timescale*timescale)
        image_xscale=0.75+0.5*ntte_orb_age/ntte_charge
        image_yscale=image_xscale
    }
    else {
        if (!ntte_orb_fired) {
            ntte_orb_fired=true
            speed=8*timescale
        }
        if (ntte_orb_age>=ntte_charge+60) scrNTTEScorpionOrbBurst()
    }
}

function scrNTTEScorpionOrbBurst() {
    if (ntte_orb_done) return;
    ntte_orb_done=true
    if (ntte_orb_age>=ntte_charge) {
        for(var _i=0;_i<6;++_i) scr_projectile_create(x,y,NTTEVenomPellet,direction+_i*60,6)
    }
    instance_create(x,y,ScorpionBulletHit)
    instance_destroy()
}

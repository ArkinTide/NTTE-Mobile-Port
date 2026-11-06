// Original tedesert / tecoast native counterparts. These are constructors;
// natural area placement is wired separately by the area integration owner.
function scrNTTEFullWorldLook(_dir) {
    gunangle=_dir
    if (abs(lengthdir_x(1,_dir))>0.001) right=sign(lengthdir_x(1,_dir))
}

function scrNTTEFullWorldWalk(_dir,_ticks) {
    direction=_dir; walk=_ticks; speed=max(speed,0.4*timescale)
}

function scrNTTEFullWorldTargetVisible() {
    return instance_exists(target) && !collision_line(x,y,target.x,target.y,Wall,false,false)
}

function scrNTTEFullWorldWalkStep() {
    if (walk>0) { walk-=timescale; speed+=walkspeed*timescale*timescale }
    speed=min(speed,maxspeed*timescale)
    if (wkick!=0) wkick=approach(wkick,0,timescale)
}

function scrNTTEFullWorldEnemySprite() {
    return sprite_index==spr_hurt && image_index+image_speed<image_number ? spr_hurt:(speed>0 ? spr_walk:spr_idle)
}

function scrNTTEFullBabyScorpionCreate() {
    ntte_full_baby_scorpion=true; gold=false
    spr_idle=scrNTTERefSprite("BabyScorpionIdle"); spr_walk=scrNTTERefSprite("BabyScorpionWalk")
    spr_hurt=scrNTTERefSprite("BabyScorpionHurt"); spr_dead=scrNTTERefSprite("BabyScorpionDead")
    spr_fire=scrNTTERefSprite("BabyScorpionFire"); sprite_index=spr_idle
    hitid=[spr_idle,"BABY SCORPION"]; depth=-2; mask_index=mskBandit
    max_hp=7; raddrop=4; size=1; meleedamage=6
    walk=0; ammo=0; walkspeed=0.8; maxspeed=2.4
    ntte_baby_decide_left=40+irandom(30)
}

function scrNTTEFullBabyScorpionAfterCreate() {
    spr_shadow=shd24; spr_shadow_y=-1
    snd_hurt=sndScorpionHit; snd_dead=sndScorpionDie; snd_mele=sndScorpionMelee; snd_fire=sndScorpionFireStart
    gunangle=random(360); direction=gunangle; alarm[1]=-1
}

function scrNTTEFullBabyScorpionMakeGold() {
    gold=true
    spr_idle=scrNTTERefSprite("BabyScorpionGoldIdle"); spr_walk=scrNTTERefSprite("BabyScorpionGoldWalk")
    spr_hurt=scrNTTERefSprite("BabyScorpionGoldHurt"); spr_dead=scrNTTERefSprite("BabyScorpionGoldDead")
    spr_fire=scrNTTERefSprite("BabyScorpionGoldFire"); sprite_index=spr_idle
    hitid=[spr_idle,"BABY GOLDEN#SCORPION"]
    snd_hurt=sndGoldScorpionHurt; snd_dead=sndGoldScorpionDead; snd_mele=sndGoldScorpionMelee; snd_fire=sndGoldScorpionFire
    max_hp=16; hp=max_hp; raddrop=14
}

function scrNTTEFullBabyScorpionDecision() {
    ntte_baby_decide_left=50+irandom(30); scrTarget()
    if (ammo>0) {
        --ammo; ntte_baby_decide_left=gold ? 2:irandom_range(1,3)
        if (scrNTTEFullWorldTargetVisible()) scrNTTEFullWorldLook(point_direction(x,y,target.x,target.y))
        scrNTTEFullWorldWalk(gunangle+orandom(10),ntte_baby_decide_left+3)
        if (gold) {
            var _off=random_range(20,60)
            for(var _a=-_off;_a<=_off;_a+=_off) scr_projectile_create(x,y,NTTEVenomPellet,gunangle+_a,(_a==0 ? 10:6)+random(2))
        }
        else scr_projectile_create(x,y,NTTEVenomPellet,gunangle+orandom(20),7+random(4))
        snd_play(sndScorpionFire,1.4+random(0.2))
        if (random(4)<1) {
            var _acid=instance_create(x,y,AcidStreak)
            with (_acid) motion_set(other.gunangle+orandom(24),random_range(2,6)*timescale)
        }
        if (ammo<=0) {
            ntte_baby_decide_left=20+irandom(20); sprite_index=spr_idle
            snd_play(sndSalamanderEndFire,1.6,0.4)
        }
    }
    else if (scrNTTEFullWorldTargetVisible()) {
        scrNTTEFullWorldLook(point_direction(x,y,target.x+target.hspeed,target.y+target.vspeed))
        var _d=point_distance(x,y,target.x,target.y)
        if (random(3)<2 && _d>32 && _d<96) {
            ntte_baby_decide_left=1; ammo=6+irandom(2); snd_play(snd_fire,1.6)
        }
        else if (_d<=32) {
            ntte_baby_decide_left=20+irandom(30)
            scrNTTEFullWorldWalk(gunangle+180+orandom(40),random_range(10,20)); scrNTTEFullWorldLook(direction)
        }
        else { ntte_baby_decide_left=30+irandom(20); scrNTTEFullWorldWalk(gunangle+orandom(40),random_range(20,35)) }
    }
    else { scrNTTEFullWorldWalk(random(360),30); scrNTTEFullWorldLook(direction) }
}

function scrNTTEFullBabyScorpionStep() {
    if (lockstep_stop) return;
    if (hp<=0) { instance_destroy(); return }
    ntte_baby_decide_left-=timescale
    if (ntte_baby_decide_left<=0) scrNTTEFullBabyScorpionDecision()
    scrNTTEFullWorldWalkStep()
    if (sprite_index!=spr_hurt || image_index+image_speed>=image_number) sprite_index=ammo>0 ? spr_fire:scrNTTEFullWorldEnemySprite()
}

function scrNTTEFullBabyScorpionDeath() {
    if (hp>0) return;
    scrNTTEFullWorldPickupDrop(16,0)
    if (gold) {
        repeat(4+irandom(4)) scr_projectile_create(x,y,NTTEVenomPellet,random(360),8+random(4))
        repeat(8+irandom(8)) scr_projectile_create(x,y,NTTEVenomPellet,random(360),4+random(4))
    }
    repeat(gold ? 3:2) {
        var _d=direction+orandom(60),_acid=instance_create(x+lengthdir_x(6,_d),y+lengthdir_y(6,_d),AcidStreak)
        with (_acid) motion_set(_d,(4+random(4))*timescale)
    }
    snd_play(snd_dead,1.5+random(0.3),1.3); snd_dead=-1
}

function scrNTTEFullGullCreate() {
    spr_idle=scrNTTERefSprite("GullIdle"); spr_walk=scrNTTERefSprite("GullWalk")
    spr_hurt=scrNTTERefSprite("GullHurt"); spr_dead=scrNTTERefSprite("GullDead"); spr_weap=scrNTTERefSprite("GullSword")
    sprite_index=spr_idle; hitid=[spr_idle,"GULL"]; depth=-2; mask_index=mskBandit
    max_hp=8; raddrop=3; size=1; meleedamage=0; walk=0; walkspeed=0.8; maxspeed=3.5
    ntte_gull_decide_left=60+irandom(60); ntte_gull_slash_left=-1
}

function scrNTTEFullGullAfterCreate() {
    spr_shadow=shd24; snd_hurt=sndRavenHit; snd_dead=sndAllyDead
    gunangle=random(360); direction=gunangle; wepangle=140*choose(-1,1); alarm[1]=-1; alarm[2]=-1
}

function scrNTTEFullGullDecision() {
    ntte_gull_decide_left=40+irandom(30); scrTarget()
    if (scrNTTEFullWorldTargetVisible()) {
        scrNTTEFullWorldLook(point_direction(x,y,target.x,target.y))
        var _d=point_distance(x,y,target.x,target.y)
        if (_d>10 && _d<480) {
            if (_d<60) {
                ntte_gull_slash_left=8; instance_create(x,y,NTTEFullAssassinNotice); snd_play(sndRavenScreech,1.15+random(0.1))
            }
            else { ntte_gull_decide_left=40+irandom(10); scrNTTEFullWorldWalk(gunangle+orandom(20),random_range(20,35)) }
        }
        else { ntte_gull_decide_left=30+irandom(10); scrNTTEFullWorldWalk(gunangle+orandom(20),random_range(10,30)) }
    }
    else { scrNTTEFullWorldWalk(random(360),30); scrNTTEFullWorldLook(direction) }
}

function scrNTTEFullGullSlash() {
    if (instance_exists(target)) scrNTTEFullWorldLook(point_direction(x,y,target.x,target.y)+orandom(10))
    var _slash=scr_projectile_create(x,y,EnemySlash,gunangle,4); _slash.damage=2
    snd_play(sndChickenSword); motion_add(gunangle,4*timescale); wepangle*=-1; wkick=-3
}

function scrNTTEFullGullStep() {
    if (lockstep_stop) return;
    if (hp<=0) { instance_destroy(); return }
    // Native manual alarms retain source's decision-before-slash order.
    ntte_gull_decide_left-=timescale
    if (ntte_gull_decide_left<=0) scrNTTEFullGullDecision()
    if (ntte_gull_slash_left>0) {
        ntte_gull_slash_left-=timescale
        if (ntte_gull_slash_left<=0) scrNTTEFullGullSlash()
    }
    scrNTTEFullWorldWalkStep(); sprite_index=scrNTTEFullWorldEnemySprite()
}

function scrNTTEFullGullDrawWeapon() {
    // Exact telib.draw_weapon angle/kick order and the source's explicit flip=1.
    var _d=gunangle+wepangle*(1-wkick/20)
    draw_sprite_ext(spr_weap,0,x-lengthdir_x(wkick,_d),y-lengthdir_y(wkick,_d),1,1,_d,image_blend,image_alpha)
}

function scrNTTEFullGullDraw() {
    if (gunangle<=180) scrNTTEFullGullDrawWeapon()
    draw_sprite_ext(sprite_index,image_index,x,y,image_xscale*right,image_yscale,image_angle,image_blend,image_alpha)
    if (gunangle>180) scrNTTEFullGullDrawWeapon()
}

function scrNTTEFullWorldFlyCreate() {
    sprite_index=scrNTTERefSprite("FlySpin"); image_index=irandom(image_number-1)
    image_speed=(0.4+random(0.1))*timescale; image_xscale=choose(-1,1); depth=-9
    target=noone; target_x=0; target_y=0
}

function scrNTTEFullWorldFlyEndStep() {
    if (lockstep_stop) return;
    if (target!=noone) {
        if (instance_exists(target)) { x=target.x+target_x; y=target.y+target_y }
        else instance_destroy()
    }
}

function scrNTTEFullWorldCowSkullAfterCreate() {
    spr_idle=scrNTTERefSprite("CowSkullIdle"); spr_hurt=scrNTTERefSprite("CowSkullHurt"); spr_dead=scrNTTERefSprite("CowSkullDead")
    sprite_index=spr_idle
    var _l=random(16),_d=90+orandom(110),_fly=instance_create(x+lengthdir_x(_l,_d),y+lengthdir_y(_l,_d),NTTEFullFlySpin)
    _fly.depth=depth
}

function scrNTTEFullBloomingAfterCreate(_kind) {
    var _name=_kind==0 ? "BloomingBush":(_kind==1 ? "BloomingCactus":"BloomingAssassin")
    var _i=_kind==1 ? irandom(array_length(scrNTTERefSprite("BloomingCactusIdle"))-1):-1
    spr_idle=scrNTTERefSprite(_name+"Idle",_i); spr_hurt=scrNTTERefSprite(_name+"Hurt",_i); spr_dead=scrNTTERefSprite(_name+"Dead",_i)
    if (_kind==2) spr_walk=scrNTTERefSprite("BloomingAssassinWalk")
    sprite_index=spr_idle
}

function scrNTTEFullBigCactusCreate() {
    var _name=GameCont.area==area_campfire ? "BigNightCactus":(GameCont.area==scrNTTEFullAreaId("coast") ? "BigBloomingCactus":"BigCactus")
    spr_idle=scrNTTERefSprite(_name+"Idle"); spr_hurt=scrNTTERefSprite(_name+"Hurt"); spr_dead=scrNTTERefSprite(_name+"Dead")
    sprite_index=spr_idle; depth=-1; max_hp=24; size=2
}

function scrNTTEFullBigCactusAfterCreate() {
    spr_shadow=shd32; spr_shadow_y=4; snd_hurt=sndHitPlant; snd_dead=sndPlantSnareTrapper
    instance_create(x,y,PortalClear)
    if (place_meeting(x,y,Floor)) {
        var _p=instance_nearest(x,y,Player)
        if (!instance_exists(_p) || point_distance(x,y,_p.x,_p.y)>96) repeat(choose(2,3)) instance_create(x,y,GameCont.area==scrNTTEFullAreaId("coast") ? NTTEFullGull:NTTEFullBabyScorpion)
    }
}

function scrNTTEFullBigCactusDeath() {
    if (hp>0) return;
    var _start=random(360)
    for(var _d=_start;_d<_start+360;_d+=random_range(60,180)) {
        var _dust=instance_create(x,y,Dust)
        with (_dust) { motion_set(_d,random_range(4,5)*timescale); friction*=2 }
    }
}

function scrNTTEFullBuriedCarCreate() {
    spr_idle=scrNTTERefSprite("BuriedCarIdle"); spr_hurt=scrNTTERefSprite("BuriedCarHurt"); spr_dead=mskNone
    sprite_index=spr_idle; hitid=[spr_idle,"BURIED CAR"]; max_hp=20; size=2
}

function scrNTTEFullBuriedCarAfterCreate() {
    spr_shadow=mskNone; snd_hurt=sndHitMetal; target=noone
    // instance_nearest_bbox measures distance to the full rectangular floor.
    var _best=infinity
    with (Floor) {
        var _cx=clamp(other.x,bbox_left,bbox_right),_cy=clamp(other.y,bbox_top,bbox_bottom),_dis=point_distance(other.x,other.y,_cx,_cy)
        if (_dis<_best) { _best=_dis; other.target=id }
    }
}

function scrNTTEFullBuriedCarStep() {
    if (lockstep_stop) return;
    if (instance_exists(target)) { x=(target.bbox_left+target.bbox_right)/2; y=(target.bbox_top+target.bbox_bottom)/2 }
    else hp=min(hp,0)
    if (hp<=0) instance_destroy()
}

function scrNTTEFullBuriedCarDeath() {
    if (hp>0) return;
    repeat(2) scr_projectile_create(x+orandom(3),y+orandom(3),Explosion,0,0)
    repeat(2) scr_projectile_create(x+orandom(3),y+orandom(3),SmallExplosion,0,0)
    snd_play(sndExplosionCar)
    if (instance_exists(target)) with (target) {
        var _floor=id
        with (Detail) if (place_meeting(x,y,_floor)) instance_destroy()
        for(var _x=bbox_left;_x<bbox_right+1;_x+=16) for(var _y=bbox_top;_y<bbox_bottom+1;_y+=16) instance_create(_x,_y,FloorExplo)
        instance_destroy()
    }
}

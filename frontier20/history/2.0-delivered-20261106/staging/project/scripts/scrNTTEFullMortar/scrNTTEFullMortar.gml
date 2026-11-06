// NTTE 2.062 tecaves.mod.gml:2206..2230,2277..2611.
function scrNTTEFullMortarCreate() {
    ntte_full_mortar=true; curse=false
    spr_idle=scrNTTERefSprite("MortarIdle"); spr_walk=scrNTTERefSprite("MortarWalk")
    spr_fire=scrNTTERefSprite("MortarFire"); spr_hurt=scrNTTERefSprite("MortarHurt"); spr_dead=scrNTTERefSprite("MortarDead")
    sprite_index=spr_idle; depth=-3; hitid=[spr_idle,"MORTAR"]
    mask_index=mskDogGuardian; max_hp=75; raddrop=30; size=3; meleedamage=0
    walk=0; walkspeed=0.8; maxspeed=2; ntte_mortar_ammo=4
    ntte_mortar_target_x=x; ntte_mortar_target_y=y
    ntte_mortar_decide_left=100+irandom(40); ntte_mortar_shot_left=-1; ntte_mortar_shots=0
}

function scrNTTEFullMortarAfterCreate() {
    spr_shadow=shd48; spr_shadow_y=4
    snd_hurt=sndLaserCrystalHit; snd_dead=sndLaserCrystalDeath
    gunangle=random(360); direction=gunangle
    alarm[1]=-1; alarm[2]=-1
}

function scrNTTEFullMortarMakeCursed() {
    spr_idle=scrNTTERefSprite("InvMortarIdle"); spr_walk=scrNTTERefSprite("InvMortarWalk")
    spr_fire=scrNTTERefSprite("InvMortarFire"); spr_hurt=scrNTTERefSprite("InvMortarHurt"); spr_dead=scrNTTERefSprite("InvMortarDead")
    sprite_index=spr_idle; hitid=[spr_idle,"CURSED MORTAR"]
    snd_hurt=choose(sndBanditHit,sndBigMaggotHit,sndScorpionHit,sndRatHit,sndGatorHit,sndRavenHit,sndSalamanderHurt,sndSniperHit)
    snd_dead=choose(sndBanditDie,sndBigMaggotDie,sndScorpionDie,sndRatDie,sndGatorDie,sndRavenDie,sndSalamanderDead)
    curse=true
}

function scrNTTEFullMortarWalk(_dir,_time) {
    direction=_dir; walk=_time; speed=max(speed,0.4*timescale)
}

function scrNTTEFullMortarLook(_dir) {
    gunangle=_dir
    if (abs(lengthdir_x(1,_dir))>0.001) right=sign(lengthdir_x(1,_dir))
}

function scrNTTEFullMortarDecision() {
    ntte_mortar_decide_left=80+random(20); scrTarget()
    if (instance_exists(target) && point_distance(x,y,target.x,target.y)<240) {
        scrNTTEFullMortarLook(point_direction(x,y,target.x,target.y))
        if (random(3)<1) {
            ntte_mortar_shot_left=26; ntte_mortar_target_x=target.x; ntte_mortar_target_y=target.y
            sprite_index=spr_fire; snd_play(sndCrystalJuggernaut)
        }
        else {
            ntte_mortar_decide_left=40+irandom(40)
            scrNTTEFullMortarWalk(gunangle+orandom(15),15+random(30))
        }
    }
    else {
        ntte_mortar_decide_left=50+irandom(30)
        scrNTTEFullMortarWalk(random(360),10); scrNTTEFullMortarLook(direction)
    }
}

function scrNTTEFullMortarShot() {
    scrTarget()
    if (ntte_mortar_ammo<=0) {
        if (instance_exists(target)) { ntte_mortar_target_x=target.x; ntte_mortar_target_y=target.y }
        ntte_mortar_ammo=4
    }
    if (ntte_mortar_ammo<=0) return;
    var _tx=ntte_mortar_target_x+orandom(16),_ty=ntte_mortar_target_y+orandom(16)
    scrNTTEFullMortarLook(point_direction(x,y,_tx,_ty))
    snd_play(sndCrystalTB); snd_play(sndPlasma)
    var _p=scr_projectile_create(x+5*right,y,NTTEFullMortarPlasma,gunangle,3)
    with (_p) {
        z+=18
        var _logical_speed=speed/timescale,_travel=point_distance(x,y,_tx,_ty)/_logical_speed
        zspeed=_travel*zfriction*0.5-z/_travel
        var _x=x,_y=y,_z=z,_zspd=zspeed,_zfrc=zfriction,_i=0
        var _stepx=hspeed/timescale,_stepy=vspeed/timescale
        while (_z>0) {
            var _trail=instance_create(_x,_y-_z,BoltTrail)
            with (_trail) {
                image_angle=point_direction(x,y,_x+_stepx,_y+_stepy-(_z+_zspd))
                image_xscale=point_distance(x,y,_x+_stepx,_y+_stepy-(_z+_zspd))
                image_yscale=random(1.5); image_blend=make_color_rgb(235,0,67); depth=-9
                if (random(6)<1) {
                    var _charge=instance_create(x+orandom(8),y+orandom(8),LaserCharge)
                    with (_charge) {
                        motion_add(point_direction(x,y,_x,_y-_z),timescale)
                        alarm[0]=point_distance(x,y,_x,_y-_z)/(speed/timescale)+1; depth=-8
                    }
                }
            }
            _x+=_stepx; _y+=_stepy; _z+=_zspd; _zspd-=_zfrc; ++_i
        }
        var _start=random(360)
        for(var _a=_start;_a<_start+360;_a+=120+orandom(30)) {
            var _charge=instance_create(_x+lengthdir_x(16,_a),_y+lengthdir_y(16,_a),LaserCharge)
            with (_charge) {
                motion_add(point_direction(x,y,_x,_y),point_distance(x,y,_x,_y)/_i*timescale)
                alarm[0]=_i
            }
            _i*=0.75
        }
        var _spark=instance_create(_x,_y,CaveSparkle)
        _spark.image_speed*=random_range(0.5,1)
    }
    ++ntte_mortar_shots
    if (instance_exists(target) && !collision_line(x,y,target.x,target.y,Wall,false,false)) {
        var _d=point_direction(ntte_mortar_target_x,ntte_mortar_target_y,target.x,target.y)
        ntte_mortar_target_x+=lengthdir_x(32,_d); ntte_mortar_target_y+=lengthdir_y(32,_d)
    }
    if (--ntte_mortar_ammo>0) ntte_mortar_shot_left=4
}

function scrNTTEFullMortarStep() {
    if (lockstep_stop) return;
    if (hp<=0) { instance_destroy(); return }
    ntte_mortar_decide_left-=timescale
    if (ntte_mortar_decide_left<=0) scrNTTEFullMortarDecision()
    if (ntte_mortar_shot_left>0) {
        ntte_mortar_shot_left-=timescale
        if (ntte_mortar_shot_left<=0) scrNTTEFullMortarShot()
    }
    if (walk>0) { walk-=timescale; speed+=walkspeed*timescale*timescale }
    speed=min(speed,maxspeed*timescale)
    if (sprite_index!=spr_fire || image_index+image_speed>=image_number) {
        if (sprite_index!=spr_hurt || image_index+image_speed>=image_number) sprite_index=speed>0 ? spr_walk:spr_idle
    }
    if (sprite_index==spr_fire && random(5)<timescale) {
        var _tx=x+6*right,_ty=y-16,_l=irandom_range(16,24),_d=random(360)
        var _spark=instance_create(_tx+lengthdir_x(_l,_d),_ty+lengthdir_y(_l,_d),LaserCharge)
        with (_spark) {
            depth=other.depth-1; motion_set(_d+180,random_range(1,2)*timescale)
            alarm[0]=point_distance(x,y,_tx,_ty)/(speed/timescale)
        }
    }
    if (curse && random(3)<timescale) instance_create(x+orandom(8),y+orandom(8),Curse)
}

function scrNTTEFullMortarDraw() {
    var _flash=sprite_index==spr_fire && nexthurt>=current_frame+4
    if (_flash) gpu_set_fog(true,image_blend,0,0)
    draw_sprite_ext(sprite_index,image_index,x,y,image_xscale*right,image_yscale,image_angle,image_blend,image_alpha)
    if (_flash) gpu_set_fog(false,0,0,0)
}

function scrNTTEFullMortarSwap(_swap) {
    if (!instance_exists(_swap)) return false
    var _x=x,_y=y
    x=_swap.x; y=_swap.y; xprevious=x; yprevious=y
    _swap.x=_x; _swap.y=_y; _swap.xprevious=_x; _swap.yprevious=_y
    _swap.sprite_index=_swap.spr_hurt; _swap.image_index=0; _swap.nexthurt=current_frame+6
    var _selves=[id,_swap]
    for (var _i=0;_i<2;++_i) with (_selves[_i]) {
        if (place_meeting(x,y,Floor)) {
            if (!scrNTTEFullWorldBudge(id,Wall,40)) scrNTTEFullWorldWallClear(id)
        }
        else scrNTTEFullTopCreate(x,y,id,0,0)
    }
    return true
}

// Separate interception hook; root inserts alongside CrystalBat at scr_hit.
function scrNTTEFullMortarInterceptHit(_who,_amount) {
    if (!instance_exists(_who) || !variable_instance_exists(_who,"ntte_full_mortar")) return false
    with (_who) {
        hp-=_amount; nexthurt=current_frame+6; snd_play_hit(snd_hurt,0.3)
        if (sprite_index!=spr_fire) {
            sprite_index=spr_hurt; image_index=0
            if (curse && hp>0 && random(1)<_amount/25) {
                var _count=instance_number(NTTEFullMortar)
                if (_count>0) {
                    var _swap=instance_find(NTTEFullMortar,irandom(_count-1))
                    scrNTTEFullMortarSwap(_swap)
                }
            }
        }
    }
    return true
}

function scrNTTEFullMortarPlasmaCreate() {
    sprite_index=scrNTTERefSprite("MortarPlasma"); depth=-12
    mask_index=mskNone; damage=0; knockback_speed=0; typ=0
    z=1; zspeed=0; zfriction=0.4
    // The original CustomProjectile exposes a nullable shadow; the native parent does not.
    spr_shadow=shd24
}

function scrNTTEFullMortarPlasmaStep() {
    if (lockstep_stop) return;
    z+=zspeed*timescale; zspeed-=zfriction*timescale
    if ((direction>=30 && direction<=150) || (direction>=210 && direction<=330)) {
        image_index=round((point_direction(0,0,speed/timescale,zspeed)+90)/(360/image_number))
        image_angle=direction
    }
    else {
        image_index=zspeed>5 ? 0:(zspeed>2 ? 1:2)
        image_angle=point_direction(0,0,hspeed/timescale,-zspeed)
    }
    if (random(2)<timescale) {
        var _f=instance_create(x+orandom(4),y-z+orandom(4),PlasmaTrail)
        _f.sprite_index=scrNTTERefSprite("EnemyPlasmaTrail"); _f.depth=depth
    }
    if (z<=0 || (z<=8 && position_meeting(x,y+8,Wall))) instance_destroy()
}

function scrNTTEFullMortarPlasmaDraw() {
    draw_sprite_ext(sprite_index,image_index,x,y-z,image_xscale,image_yscale,image_angle,image_blend,image_alpha)
    gpu_set_blendmode(bm_add)
    draw_sprite_ext(sprite_index,image_index,x,y-z,2*image_xscale,2*image_yscale,image_angle,image_blend,0.1*image_alpha)
    gpu_set_blendmode(bm_normal)
}

function scrNTTEFullMortarPlasmaDestroy() {
    var _impact=scr_projectile_create(x,y,PlasmaImpact,0,0)
    _impact.sprite_index=scrNTTERefSprite("EnemyPlasmaImpact"); _impact.damage=2
    if (position_meeting(x,y+8,Wall) || !position_meeting(x,y+8,Floor)) _impact.depth=-9
    scr_screenshake(3); snd_play(sndPlasmaHit,1+orandom(0.1),1.5)
}

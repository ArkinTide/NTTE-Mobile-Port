// tecoast4247..4369 and4765..4915. Heavy Seal anchor and throwable water mine.
function scrNTTEFullSealAnchorCreate() {
    sprite_index=scrNTTERefSprite("SealAnchor"); image_speed=0; depth=-2; mask_index=-1
    typ=0; candeflect=true; damage=4; knockback_speed=6*timescale; team=team_enemy
    friction=0; last_x=[x,x]; last_y=[y,y]
}
function scrNTTEFullSealAnchorStep() {
    if (lockstep_stop) return;
    if (instance_exists(creator)) {
        var _ts=max(timescale,0.000001)
        x=creator.x+(hspeed/_ts)*(1-timescale); y=creator.y+(vspeed/_ts)*(1-timescale)
        creator.x+=hspeed/20; creator.y+=vspeed/20
    }
    else {
        if (friction<=0) { snd_play(sndSwapSword,2.4); friction=0.6*timescale*timescale; speed/=3; typ=1 }
        if (speed<timescale) instance_destroy()
    }
}
function scrNTTEFullSealAnchorEndStep() {
    if (lockstep_stop) return;
    var _distances=[2,sprite_width-2],_dir=direction
    for(var _i=0;_i<2;++_i) {
        var _x=x+lengthdir_x(_distances[_i],_dir),_y=y+lengthdir_y(_distances[_i],_dir)
        var _trail=instance_create(_x,_y,BoltTrail)
        _trail.image_angle=point_direction(_x,_y,last_x[_i],last_y[_i]); _trail.image_xscale=point_distance(_x,_y,last_x[_i],last_y[_i]); _trail.image_yscale=0.6
        last_x[_i]=_x; last_y[_i]=_y
    }
}
function scrNTTEFullSealAnchorDraw() {
    if (instance_exists(creator)) {
        var _x=x+lengthdir_x(2,direction-90),_y=y+lengthdir_y(2,direction-90),_sprite=scrNTTERefSprite("SealChain"),
            _dir=point_direction(_x,_y,creator.x,creator.y),_num=ceil(point_distance(x,y,creator.x,creator.y))/sprite_get_width(_sprite),_w=sprite_get_width(_sprite),_h=sprite_get_height(_sprite)
        for(var _i=0;_i<_num;++_i) {
            if (_i>=_num-1) _w=point_distance(_x,_y,creator.x,creator.y)
            draw_sprite_general(_sprite,0,0,0,_w,_h,_x,_y,1,1,_dir,image_blend,image_blend,image_blend,image_blend,image_alpha)
            _x+=lengthdir_x(_w,_dir); _y+=lengthdir_y(_w,_dir)
        }
    }
    draw_self()
}
function scrNTTEFullSealAnchorHit(_target) {
    if (lockstep_stop || !instance_exists(_target) || !scr_can_hit(_target,true)) return;
    if (scr_projectile_hit(_target,damage,knockback_speed)) _target.nexthurt=max(_target.nexthurt,current_frame+40)
}
function scrNTTEFullSealAnchorProjectile(_target) {
    if (lockstep_stop || !instance_exists(_target)) return;
    with (_target) if (typ==1 || typ==2) {
        if (typ==1 && other.candeflect) {
            direction=other.direction; image_angle=direction
            with (instance_create(x,y,Deflect)) image_angle=other.image_angle
        }
        else instance_destroy()
    }
}
function scrNTTEFullSealAnchorDeath() {
    var _bubble=scr_projectile_create(x+lengthdir_x(8,image_angle),y+lengthdir_y(8,image_angle),NTTEFullBubbleExplosion)
    _bubble.team=-1
    snd_play(sndWallBreakBrick,1.2+random(0.1),0.4); snd_play(sndSwapHammer,1.3,0.3)
}
function scrNTTEFullSealMineCreate() {
    spr_idle=scrNTTERefSprite("SealMine"); spr_hurt=scrNTTERefSprite("SealMineHurt"); spr_dead=sprScorchmark; sprite_index=spr_idle
    hitid=[spr_idle,"WATER MINE"]; image_speed=0.4*timescale; depth=-3; mask_index=mskNone; friction=0; max_hp=10
    creator=noone; canfly=true; size=2; z=0; zspeed=0; zfriction=1; ntte_mine_right=choose(-1,1)
    motion_add(random(360),3*timescale)
}
function scrNTTEFullSealMineAfterCreate() { spr_shadow=shd24; snd_hurt=sndHitMetal; team=team_none; right=ntte_mine_right; hp=max_hp }
function scrNTTEFullSealMineStep() {
    if (lockstep_stop) return;
    if (sprite_index!=spr_hurt || image_index+image_speed>=image_number) sprite_index=spr_idle
    z+=zspeed*timescale; zspeed-=zfriction*timescale
    image_angle-=sign(hspeed)*(abs(vspeed/2)+abs(hspeed))
    if (z<=0) {
        friction=0.4*timescale*timescale; mask_index=mskWepPickup; depth=-3
        if (speed>0) {
            speed=min(speed,4*timescale)
            if (random(5)<timescale) {
                instance_create(x,y+8,Dust)
                if (place_meeting(x,y,Floor)) snd_play(asset_get_index("sndFootPla"+choose("Rock","Sand","Metal")+string(irandom(5)+1)),0.6,0.6)
            }
        }
        if (zspeed< -10) {
            if (distance_to_object(Floor)<20 || place_meeting(x,y,Player)) hp=0
            else {
                var _angle=orandom(20)
                for(var _a=_angle;_a<_angle+360;_a+=180) {
                    var _water=scrNTTEFullWorldCreateRequired("WaterStreak",x,y)
                    with (_water) { motion_set(_a,4*timescale); hspeed+=other.hspeed/2; vspeed+=other.vspeed/2 }
                }
                snd_play(sndOasisExplosionSmall,2)
            }
        }
        if (place_meeting(x,y,Floor)) friction*=1.5
        else image_angle+=sin(current_frame/20)*0.5
        zspeed=0; z=0
    }
    else { friction=0; mask_index=mskNone; depth=-9 }
    if (place_meeting(x,y,hitme)) {
        var _targets=scrNTTEFullInstances(hitme)
        for(var _i=0;_i<array_length(_targets);++_i) {
            var _target=_targets[_i]
            if (_target==id || _target==creator || !place_meeting(x,y,_target)) continue
            motion_add(point_direction(_target.x,_target.y,x,y),_target.size/5*timescale)
            if (!instance_is(_target,prop)) with (_target) motion_add(point_direction(other.x,other.y,x,y),other.size/2*timescale)
        }
    }
    if (hp<=0) instance_destroy()
}
function scrNTTEFullSealMineDeath() {
    var _explosion=scr_projectile_create(x,y,Explosion)
    _explosion.team=-1; snd_play(sndExplosion)
    for(var _dir=direction;_dir<direction+360;_dir+=60) {
        var _bullet=scr_projectile_create(x,y,EnemyBullet3,_dir+orandom(20),7+random(4))
        _bullet.team=-1
    }
    snd_play_hit(sndFlakExplode,0.2)
}
function scrNTTEFullSealHeavyCreate() {
    spr_spwn=scrNTTERefSprite("SealHeavySpwn"); spr_idle=scrNTTERefSprite("SealHeavyIdle"); spr_walk=scrNTTERefSprite("SealHeavyWalk")
    spr_hurt=scrNTTERefSprite("SealHeavyHurt"); spr_dead=scrNTTERefSprite("SealHeavyDead"); spr_chrg=scrNTTERefSprite("SealHeavyTell"); spr_weap=scrNTTERefSprite("SealAnchor")
    sprite_index=spr_spwn; depth=-2; hitid=[spr_idle,"HEAVY SEAL"]; mask_index=mskBandit; max_hp=32; raddrop=12; size=2
    walk=0; walkspeed=0.8; maxspeed=3; wepangle=0; ntte_heavy_angle=random(360); gunangle=ntte_heavy_angle; direction=gunangle
    my_mine=noone; my_mine_ang=gunangle; my_mine_spin=0; target_x=x; target_y=y
    anchor=noone; anchor_swap=false; anchor_spin=0; anchor_throw=0; anchor_retract=0; ntte_heavy_timer=40+random(30)
}
function scrNTTEFullSealHeavyAfterCreate() { gunangle=ntte_heavy_angle; spr_shadow=shd24; snd_hurt=sndJockHurt; snd_dead=sndJockDead; alarm[1]=-1 }
function scrNTTEFullSealHeavyFace(_angle) { var _face=sign(lengthdir_x(1,_angle)); if (_face!=0) right=_face }
function scrNTTEFullSealHeavyStep() {
    if (lockstep_stop) return;
    if (hp<=0) { instance_destroy(); return }
    if (ntte_heavy_timer>0) { ntte_heavy_timer-=timescale; if (ntte_heavy_timer<=0) { ntte_heavy_timer=-1; scrNTTEFullSealHeavyDecision() } }
    scrNTTEFullWorldWalkStep()
    if (sprite_index==spr_spwn) {
        if (image_index+image_speed>=image_number) sprite_index=spr_idle
        if (image_index<2) y-=image_index*timescale
    }
    else sprite_index=scrNTTEFullWorldEnemySprite()
    if (anchor_spin!=0) {
        scrNTTEFullWorldLook(gunangle+anchor_spin*timescale); gunangle=(gunangle+360)%360; speed=max(speed,1.5*timescale)
        if (instance_exists(anchor)) {
            sprite_index=spr_walk; anchor.direction=gunangle; anchor.image_angle=gunangle
            if (anchor_throw>0) { anchor.speed+=anchor_throw*timescale*timescale; anchor_throw-=timescale }
            if (anchor_retract) { anchor.speed-=0.5*timescale*timescale; if (anchor.speed<=0) { instance_destroy(anchor,false); anchor=noone } }
        }
        else {
            if (ntte_heavy_timer<20) sprite_index=spr_chrg
            if (anchor_retract) {
                anchor_spin*=power(0.8,timescale)
                if (abs(anchor_spin)<1) { anchor_spin=0; anchor_throw=0; anchor_retract=false }
            }
            else { anchor_spin+=sign(anchor_spin)*0.4*timescale; anchor_spin=clamp(anchor_spin,-20,20) }
        }
        if (current_frame_active) {
            with (instance_create(x,y,Dust)) motion_add(other.gunangle,2*timescale)
            if (gunangle<abs(anchor_spin)) snd_play(sndMeleeFlip,0.1+random(0.1),instance_exists(anchor) ? 8:1.5)
        }
    }
    else {
        if (anchor_swap) { anchor_swap=false; snd_play(sndMeleeFlip); instance_create(x,y,WepSwap) }
        if (instance_exists(my_mine)) {
            if (my_mine_spin==0) my_mine_ang+=angle_difference(gunangle,my_mine_ang)/5
            else {
                my_mine_ang+=my_mine_spin*timescale; my_mine_ang=(my_mine_ang%360+360)%360; scrNTTEFullSealHeavyFace(my_mine_ang)
                my_mine_spin+=1.5*sign(my_mine_spin)*timescale; sprite_index=spr_chrg
            }
            with (my_mine) {
                x=other.x+lengthdir_x(16,other.my_mine_ang); y=other.y+lengthdir_y(16,other.my_mine_ang)
                if (other.my_mine_spin!=0) {
                    image_angle+=other.my_mine_spin/3
                    if (other.ntte_heavy_timer<5) { z=sqr(5-other.ntte_heavy_timer); zspeed=0 }
                    if (current_frame_active) instance_create(x,y,Dust)
                }
            }
        }
        else {
            my_mine=noone
            if (place_meeting(x,y,NTTEFullSealMine)) {
                var _mines=scrNTTEFullInstances(NTTEFullSealMine)
                for(var _i=0;_i<array_length(_mines);++_i) {
                    var _mine=_mines[_i],_held=false
                    with (NTTEFullSealHeavy) if (my_mine==_mine) _held=true
                    if (_held || !place_meeting(x,y,_mine)) continue
                    ntte_heavy_timer=20; my_mine=_mine; my_mine_ang=point_direction(x,y,_mine.x,_mine.y); scrNTTEFullSealHeavyFace(my_mine_ang)
                    _mine.creator=id; _mine.hitid=hitid
                    snd_play(sndSwapHammer,0.6+orandom(0.1),0.8)
                    for(var _dir=direction;_dir<direction+360;_dir+=18) with (instance_create(x,y,Dust)) motion_set(_dir,4*timescale)
                    break
                }
            }
        }
    }
}
function scrNTTEFullSealHeavyDraw() {
    var _draw=sprite_index!=spr_spwn || image_index>2
    if (!anchor_swap && _draw) draw_sprite_ext(spr_weap,0,x+right,y+6,1,1,90+right*30,image_blend,image_alpha)
    if (gunangle>180) draw_sprite_ext(sprite_index,image_index,x,y,image_xscale*right,image_yscale,image_angle,image_blend,image_alpha)
    if (anchor_swap && _draw && !instance_exists(anchor)) draw_sprite_ext(spr_weap,0,x-lengthdir_x(wkick,gunangle),y-lengthdir_y(wkick,gunangle),1,right,gunangle,image_blend,image_alpha)
    if (gunangle<=180) draw_sprite_ext(sprite_index,image_index,x,y,image_xscale*right,image_yscale,image_angle,image_blend,image_alpha)
}
function scrNTTEFullSealHeavyDecision() {
    ntte_heavy_timer=90+random(30)
    if (my_mine!=noone && my_mine_spin!=0) {
        sprite_index=spr_idle
        if (instance_exists(my_mine)) with (my_mine) {
            zspeed=10; direction=point_direction(x,y,other.target_x,other.target_y)
            speed=(point_distance(x,y,other.target_x,other.target_y)*zfriction)/(zspeed*2)*timescale; x-=hspeed; y-=vspeed
        }
        my_mine=noone; my_mine_spin=0; scrNTTEFullWorldWalk(gunangle,5)
        snd_play(sndAssassinGetUp,0.5+orandom(0.2)); snd_play(sndAssassinAttack,0.8+orandom(0.1),0.8)
    }
    else if (anchor_spin!=0) {
        if (!instance_exists(anchor)) {
            ntte_heavy_timer=60; anchor=scr_projectile_create(x,y,NTTEFullSealAnchor,gunangle); anchor_throw=8; anchor_spin=max(20,abs(anchor_spin))*sign(anchor_spin)
            anchor.creator=id; anchor.team=team; anchor.hitid=hitid
            scrTarget(); if (instance_exists(target)) direction=point_direction(x,y,target.x,target.y)
            snd_play(sndHammer,0.8+orandom(0.1))
            repeat(5) with (instance_create(x,y,Dust)) motion_add(other.gunangle,4*timescale)
        }
        else { ntte_heavy_timer=120+random(30); anchor_retract=true }
    }
    else {
        scrTarget()
        if (scrNTTEFullWorldTargetVisible()) {
            scrNTTEFullWorldLook(point_direction(x,y,target.x,target.y)); target_x=target.x; target_y=target.y
            var _distance=point_distance(x,y,target.x,target.y)
            if (my_mine==noone) {
                if (distance_to_object(Floor)>24 && random(4)<3) {
                    ntte_heavy_timer=20; my_mine=instance_create(x,y,NTTEFullSealMine); my_mine_ang=gunangle
                    my_mine.zspeed=5; my_mine.creator=id; my_mine.hitid=hitid
                }
                else {
                    if ((_distance<180 && random(4)<3) || _distance<100) {
                        ntte_heavy_timer=45; anchor_spin=choose(-1,1)*5; snd_play(sndRatMelee,0.5+orandom(0.1))
                        anchor_swap=true; snd_play(sndSwapHammer); instance_create(x,y,WepSwap)
                    }
                    else ntte_heavy_timer=30+random(30)
                    scrNTTEFullWorldWalk(gunangle+orandom(30),random_range(8,24))
                }
            }
            else if (instance_exists(my_mine)) {
                ntte_heavy_timer=20
                if (_distance<144) {
                    if (_distance<48) scrNTTEFullWorldWalk(gunangle+180,20)
                    else {
                        my_mine_ang=gunangle; my_mine_spin=choose(-1,1)
                        snd_play(sndRatMelee,0.5+orandom(0.1)); snd_play(sndSteroidsUpg,0.75+orandom(0.1))
                        repeat(5) with (instance_create(target_x,target_y,Dust)) motion_add(random(360),3*timescale)
                    }
                }
                else scrNTTEFullWorldWalk(gunangle+orandom(20),random_range(10,20))
            }
            else my_mine=noone
        }
        else { scrNTTEFullWorldWalk(random(360),5); scrNTTEFullWorldLook(direction) }
    }
}
function scrNTTEFullSealHeavySmoke() {
    var _before=scrNTTEFullInstances(all),_loops=GameCont.loops
    GameCont.loops=0
    var _heavy=instance_create(61000,61000,NTTEFullSealHeavy)
    assert(_heavy.hp==32 && _heavy.raddrop==12 && _heavy.size==2 && _heavy.walkspeed==0.8 && _heavy.maxspeed==3 && _heavy.sprite_index==scrNTTERefSprite("SealHeavySpwn"),"Heavy Seal source stats/spawn art changed")
    _heavy.anchor_spin=5; _heavy.anchor_swap=true; _heavy.gunangle=0
    with (_heavy) scrNTTEFullSealHeavyDecision()
    var _anchor=_heavy.anchor
    assert(instance_exists(_anchor) && _anchor.creator==_heavy && _anchor.damage==4 && _anchor.knockback_speed==6*timescale && _anchor.typ==0 && _heavy.ntte_heavy_timer==60 && _heavy.anchor_throw==8 && _heavy.anchor_spin==20,"Heavy Seal did not release original spinning anchor/60tick range phase")
    repeat(ceil(8/timescale)) with (_heavy) scrNTTEFullSealHeavyStep()
    assert(instance_exists(_anchor) && _anchor.speed>20*timescale && _heavy.anchor_throw<=0,"Heavy Seal omitted anchor's eight-tick outward acceleration")
    _heavy.anchor_throw=0; _heavy.anchor_retract=true; _anchor.speed=0.1*timescale*timescale
    var _explosions=instance_number(NTTEFullBubbleExplosion)
    with (_heavy) scrNTTEFullSealHeavyStep()
    assert(!instance_exists(_anchor) && _heavy.anchor==noone && instance_number(NTTEFullBubbleExplosion)==_explosions,"Retracted anchor must delete without its destruction explosion")
    _heavy.anchor_spin=0; _heavy.anchor_retract=false; _heavy.anchor_swap=false
    var _mine=instance_create(_heavy.x,_heavy.y,NTTEFullSealMine)
    _mine.speed=0; _mine.z=0; _mine.zspeed=0
    with (_mine) scrNTTEFullSealMineStep()
    assert(_mine.hp==10 && _mine.team==team_none && _mine.mask_index==mskWepPickup && _mine.depth==-3,"Water Mine source hp/team/ground mask changed")
    with (_heavy) scrNTTEFullSealHeavyStep()
    assert(_heavy.my_mine==_mine && _mine.creator==_heavy && _heavy.ntte_heavy_timer==20,"Heavy Seal did not claim nearby unheld actual Water Mine")
    _heavy.target_x=_heavy.x+100; _heavy.target_y=_heavy.y; _heavy.my_mine_spin=1
    with (_heavy) scrNTTEFullSealHeavyDecision()
    assert(_heavy.my_mine==noone && _heavy.my_mine_spin==0 && _mine.zspeed==10 && _mine.speed>0,"Heavy Seal omitted ballistic mine toss and hand release")
    var _shells=instance_number(EnemyBullet3),_blast=instance_number(Explosion)
    instance_destroy(_mine)
    assert(instance_number(EnemyBullet3)==_shells+6 && instance_number(Explosion)==_blast+1,"Water Mine did not create original explosion plus six shrapnel")
    var _orphan=instance_create(61400,61000,NTTEFullSealAnchor)
    _orphan.creator=noone; _orphan.speed=2*timescale
    with (_orphan) scrNTTEFullSealAnchorStep()
    assert(!instance_exists(_orphan) && instance_number(NTTEFullBubbleExplosion)==_explosions+1,"Orphan anchor did not switch to frictional projectile and explode below one logical speed")
    var _all=scrNTTEFullInstances(all)
    for(var _i=0;_i<array_length(_all);++_i) if (array_get_index(_before,_all[_i])<0) instance_destroy(_all[_i],false)
    GameCont.loops=_loops
    scrNTTESmokeLog("FULL WORLD HEAVY SEAL STATS/SPINNING ANCHOR/OUTWARD ACCEL/RETRACT DELETE/REAL MINE CLAIM+BALLISTIC TOSS/EXPLOSION+SIX SHRAPNEL/ORPHAN ANCHOR EXPLOSION OK")
}

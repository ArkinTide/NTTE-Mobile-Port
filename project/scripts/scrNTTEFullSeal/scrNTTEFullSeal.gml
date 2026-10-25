// tecoast3340..4245. All seven source loadouts share this real enemy.
enum NTTEFullSealType { None=0, Hookpole=1, Shield=2, Blunderbuss=3, Mercenary=4, Deadeye=5, Dasher=6 }
function scrNTTEFullSealCreate() {
    spr_spwn=scrNTTERefSprite("SealSpwn",0); spr_idle=scrNTTERefSprite("SealIdle",0); spr_walk=scrNTTERefSprite("SealWalk",0)
    spr_hurt=scrNTTERefSprite("SealHurt",0); spr_dead=scrNTTERefSprite("SealDead",0); spr_weap=scrNTTERefSprite("SealWeap",0)
    sprite_index=spr_spwn; mask_index=mskBandit; hitid=[spr_idle,"SEAL"]; depth=-2
    max_hp=10; raddrop=1; size=1; walk=0; walkspeed=0.8; maxspeed=3.5; type=0; hold=false; hold_x=0; hold_y=0; creator=noone
    wepangle=0; ntte_seal_start_angle=random(360); gunangle=ntte_seal_start_angle; direction=gunangle; slide=0; scared=false; shield=false; shield_inst=noone
    toss=noone; toss_speed=0; toss_time=0; toss_ammo=2; toss_spin=0; attack_delay=0; skeal=false; setup=true; trident_dist=0
    ntte_seal_timer1=20+random(20); ntte_seal_timer2=-1; ntte_seal_male=irandom(1)
}
function scrNTTEFullSealAfterCreate() {
    gunangle=ntte_seal_start_angle
    spr_shadow=shd24; snd_hurt=ntte_seal_male ? sndFireballerHurt:sndFreakHurt; snd_dead=ntte_seal_male ? sndFireballerDead:sndFreakDead
    alarm[1]=-1; alarm[2]=-1
}
function scrNTTEFullSealSetup() {
    setup=false
    var _last_spawn=spr_spwn
    if (skeal) {
        spr_idle=scrNTTERefSprite("SkealIdle"); spr_walk=scrNTTERefSprite("SkealWalk"); spr_hurt=scrNTTERefSprite("SkealHurt"); spr_dead=scrNTTERefSprite("SkealDead"); spr_spwn=scrNTTERefSprite("SkealSpwn")
        spr_bubble=-1; spr_bubble_pop=-1; spr_bubble_x=0; spr_bubble_y=0; snd_hurt=sndMutant14Hurt; snd_dead=sndGatorDie
        max_hp=ceil(max_hp*2); hp=ceil(hp*2); raddrop+=4; maxspeed-=1
    }
    else {
        spr_idle=scrNTTERefSprite("SealIdle",type); spr_walk=scrNTTERefSprite("SealWalk",type); spr_hurt=scrNTTERefSprite("SealHurt",type); spr_dead=scrNTTERefSprite("SealDead",type); spr_spwn=scrNTTERefSprite("SealSpwn",type)
    }
    spr_weap=scrNTTERefSprite("SealWeap",type); hitid=[spr_idle,"SEAL"]
    if (sprite_index==_last_spawn) sprite_index=spr_spwn
    if (type==NTTEFullSealType.Shield) wepangle=choose(-120,120)
}
function scrNTTEFullSealWalk(_direction,_time) { direction=_direction; walk=_time; speed=max(speed,0.4*timescale) }
function scrNTTEFullSealShot(_object,_angle,_speed=0,_x=x,_y=y) {
    var _shot=scr_projectile_create(_x,_y,_object,_angle,_speed)
    // Seal.creator is a Palanking leader, not the projectile's attacker. The
    // native damage factory treats any creator+hitid+team object as damage.
    _shot.creator=id; _shot.team=team; _shot.hitid=hitid
    return _shot
}
function scrNTTEFullSealFX(_object,_angle,_speed) {
    var _fx=instance_create(x,y,_object)
    with (_fx) motion_set(_angle,_speed*timescale)
    return _fx
}
function scrNTTEFullSealDecision() {
    ntte_seal_timer1=30+random(30); trident_dist=0
    scrTarget()
    if (instance_exists(target)) {
        var _last_aim=gunangle,_can_attack=attack_delay<=0
        scrNTTEFullWorldLook(point_direction(x,y,target.x,target.y))
        if (type==NTTEFullSealType.None || scrNTTEFullWorldTargetVisible()) {
            var _distance=point_distance(x,y,target.x,target.y)
            switch(type) {
                case NTTEFullSealType.Hookpole:
                    ntte_seal_timer1=10+random(15)
                    if (_distance<20) scrNTTEFullSealWalk(gunangle+180+orandom(60),10)
                    else if (random(5)<4) {
                        if (_can_attack && _distance<70) { ntte_seal_timer1=30; ntte_seal_timer2=10; trident_dist=_distance-24 }
                        else { scrNTTEFullSealWalk(gunangle+orandom(20),10); if (random(10)<1) slide=10 }
                    }
                    else { scrNTTEFullSealWalk(gunangle+choose(-80,80),15); if (random(2)<1) slide=5+random(10) }
                    break
                case NTTEFullSealType.Shield:
                    if (shield) {
                        ntte_seal_timer1=15+irandom(5)
                        if (wkick==0 && _distance<80) {
                            scrNTTEFullSealWalk(gunangle+orandom(10),random_range(4,8)); shield=false; ntte_seal_timer1=20
                            instance_create(x+lengthdir_x(8,gunangle),y+lengthdir_y(8,gunangle),WepSwap); snd_play(sndSwapSword)
                        }
                        else if (random(3)<2) { scrNTTEFullSealWalk(gunangle+orandom(50),random_range(6,12)); scrNTTEFullWorldLook(direction) }
                    }
                    else {
                        ntte_seal_timer1=20+random(10)
                        if (_distance<120) {
                            scrNTTEFullSealWalk(gunangle+180*(random(3)<1)+orandom(20),random_range(5,10))
                            if (_can_attack && _distance<80) {
                                var _shank=scrNTTEFullSealShot(Shank,gunangle,3); _shank.damage=2
                                motion_add(gunangle,2*timescale); wepangle*=-1; wkick=-4; instance_create(x,y,Dust)
                                snd_play(sndMeleeFlip); snd_play(sndScrewdriver); snd_play(sndSwapGold,1.25+random(0.5),0.4)
                            }
                            else { direction=gunangle+180; slide=10 }
                        }
                        else {
                            shield=true; wkick=2; instance_create(x+lengthdir_x(8,gunangle),y+lengthdir_y(8,gunangle),WepSwap); snd_play(sndSwapHammer)
                        }
                    }
                    break
                case NTTEFullSealType.Blunderbuss:
                    if (_distance<80) { direction=gunangle+180; slide=15; ntte_seal_timer1=slide+random(10) }
                    else {
                        if (_can_attack && _distance<192 && random(3)<2) { ntte_seal_timer1+=90; ntte_seal_timer2=15; snd_play(sndEmpty,2.5,0.5); wkick=-2 }
                        else { scrNTTEFullSealWalk(gunangle+orandom(90),10); if (random(2)<1) slide=15 }
                        if (random(3)<1) { var _spark=instance_create(x,y,CaveSparkle); _spark.depth=depth-1 }
                    }
                    break
                case NTTEFullSealType.Mercenary:
                    if (_distance>160) { direction=gunangle+orandom(60); slide=15; ntte_seal_timer1=slide+random(20) }
                    else {
                        scrNTTEFullSealWalk(gunangle+orandom(90),15)
                        if (_can_attack) {
                            ntte_seal_timer2=8; ntte_seal_timer1=ntte_seal_timer2+5+random(20); wkick=-4; snd_play(sndShotReload,1.5+random(0.5),1.2)
                            with (instance_create(x,y,Shell)) { sprite_index=sprShotShell; motion_add(other.gunangle+90*other.right,(2+random(2))*timescale) }
                        }
                    }
                    break
                case NTTEFullSealType.Deadeye:
                    if (!instance_exists(toss)) {
                        if (random(2)<1) scrNTTEFullSealWalk(gunangle+choose(-80,80)+orandom(20),random_range(4,20))
                        else { toss_ammo--; toss_time=60; toss_speed=random_range(7,9); toss=scrNTTEFullSealShot(NTTEFullSealDisc,random(360)) }
                    }
                    if (instance_exists(toss)) ntte_seal_timer1=15
                    break
                case NTTEFullSealType.Dasher:
                    if (_distance<32 || random(4)<1) { slide=5+random(5); direction=gunangle+180+orandom(40) }
                    else { slide=20; ntte_seal_timer2=8; direction=random(360); snd_play(sndSnowBotSlideStart,1.3+random(0.4),1.5) }
                    ntte_seal_timer1=slide+5+random(15)
                    break
                default:
                    if (instance_exists(creator) && scrNTTEFullValue(creator,"active",false)) {
                        scrNTTEFullWorldLook(point_direction(x,y,creator.x,creator.y)); scrNTTEFullSealWalk(gunangle,random_range(10,20))
                    }
                    else if (scared) {
                        if (_distance<120 || random(instance_number(NTTEFullSeal))<2) {
                            scrNTTEFullSealWalk(gunangle+180+orandom(50),random_range(20,30)); if (random(3)<1) slide=walk-5; ntte_seal_timer1=walk
                        }
                        else scrNTTEFullSealWalk(random(360),random_range(5,10))
                        scrNTTEFullWorldLook(direction)
                    }
                    else {
                        scrNTTEFullSealWalk(point_direction(x,y,xstart+orandom(24),ystart+orandom(24)),random_range(5,10))
                        if (_distance>120) scrNTTEFullWorldLook(direction)
                    }
                    break
            }
            if (ntte_seal_timer2>0 && slide>0) right=sign(lengthdir_x(1,gunangle-(direction-90)))
        }
        else {
            scrNTTEFullSealWalk(gunangle+orandom(60),random_range(5,25)); ntte_seal_timer1=5+irandom(walk)+irandom(15); scrNTTEFullWorldLook(direction)
            if (type==NTTEFullSealType.Shield && shield) scrNTTEFullWorldLook(_last_aim+angle_difference(direction,_last_aim)/5)
            if (type==NTTEFullSealType.Dasher) gunangle=random(180)
        }
    }
    else { scrNTTEFullSealWalk(random(360),random_range(5,25)); scrNTTEFullWorldLook(direction); ntte_seal_timer1+=walk }
    if (slide>0) {
        if (hold) slide=0
        else {
            snd_play_hit(sndRoll,0.4); snd_play(sndBouncerBounce,0.4+random(0.1))
            repeat(5) with (instance_create(x,y,Dust)) motion_add(random(360),3*timescale)
        }
    }
}
function scrNTTEFullSealAttack() {
    switch(type) {
        case NTTEFullSealType.Hookpole:
            var _dis=24+trident_dist,_dir=gunangle,_shank=scrNTTEFullSealShot(Shank,_dir+180,2,x+lengthdir_x(_dis,_dir),y+lengthdir_y(_dis,_dir))
            _shank.image_angle=_dir; _shank.image_xscale=0.5; _shank.depth=-3; _shank.damage=3; _shank.knockback_speed=12*timescale
            snd_play(sndMeleeFlip); snd_play(sndJackHammer); snd_play(sndScrewdriver)
            repeat(5) scrNTTEFullSealFX(skeal ? Smoke:Dust,gunangle+orandom(30),random(skeal ? 2:5))
            x+=lengthdir_x(4,gunangle); y+=lengthdir_y(4,gunangle); wkick=-trident_dist
            scrNTTEFullSealWalk(gunangle+180+orandom(20),random_range(6,10))
            break
        case NTTEFullSealType.Blunderbuss:
            repeat(6) scrNTTEFullSealShot(EnemyBullet1,gunangle+orandom(6),6+random(2))
            for(var _i=0;_i<6;++_i) {
                with (instance_create(x,y,Dust)) motion_add(random(360),3*timescale)
                with (instance_create(x,y+1,Dust)) motion_add(other.gunangle+orandom(6),(2+_i)*timescale)
            }
            snd_play(sndDoubleShotgun,1.5); motion_add(gunangle+180,4*timescale); wkick=10
            break
        case NTTEFullSealType.Mercenary:
            if (random(3)<1) ntte_seal_timer2=irandom_range(3,5)
            scrNTTEFullSealShot(EnemyBullet3,gunangle+orandom(4),12+random(2))
            scrNTTEFullSealFX(Smoke,gunangle,2); snd_play(sndEnemyFire,1,1.5); snd_play(sndShotgun,2+random(0.4),0.8)
            motion_add(gunangle+180,timescale); wkick+=5; scrTarget()
            if (instance_exists(target)) scrNTTEFullWorldLook(point_direction(x,y,target.x,target.y))
            break
        case NTTEFullSealType.Dasher:
            scrTarget(); if (scrNTTEFullWorldTargetVisible()) scrNTTEFullWorldLook(point_direction(x,y,target.x,target.y))
            scrNTTEFullSealShot(EnemyBullet1,gunangle,6); wkick=10; direction+=choose(-30,30)
            snd_play(sndEnemyFire,1+random(0.3),2.5); snd_play(sndTurretFire,1.3+orandom(0.2),1.5)
            break
    }
}
// Passive, opt-in acceptance trace. This records the executed sound branches
// without replacing native Step/Alarm/Collision dispatch or consuming RNG.
function scrNTTEFullSealDeadeyeObserve(_kind,_owner,_wall=noone) {
    if(!variable_global_exists("ntte_full_deadeye_observer") || !is_array(global.ntte_full_deadeye_observer)) return;
    var _live=instance_exists(_owner),_solid=instance_exists(_wall);
    array_push(global.ntte_full_deadeye_observer,{kind:_kind,frame:current_frame,owner:_owner,disc:id,
        x:x,y:y,speed:speed,direction:direction,dist:dist,alarm0:alarm[0],team:team,mask:mask_index,
        held:_live && _owner.toss==id,owner_x:_live?_owner.x:undefined,owner_y:_live?_owner.y:undefined,
        bbox:[bbox_left,bbox_top,bbox_right,bbox_bottom],wall:_wall,
        wall_bbox:_solid?[_wall.bbox_left,_wall.bbox_top,_wall.bbox_right,_wall.bbox_bottom]:undefined});
}
function scrNTTEFullSealDeadeyeStep() {
    if (!instance_exists(toss)) { toss_speed=0; toss_spin=0; if (toss_ammo<=0) type=NTTEFullSealType.None; return }
    var _ts=max(timescale,0.000001)
    if (instance_exists(Wall)) {
        var _wall=scrNTTEFullWorldNearestRectBBox(x,y,x,y,Wall)
        if (instance_exists(_wall)) with (_wall) if (distance_to_point(other.x,other.y)<other.toss_speed+max(other.toss.sprite_height,other.toss.sprite_width)/2) {
            // Retreat from the actual wall center. Reusing its X as Y
            // pushed the owner toward horizontal walls at unequal coordinates.
            var _dir=point_direction((bbox_left+bbox_right)/2,(bbox_top+bbox_bottom)/2,other.x,other.y)
            with (other) motion_add(_dir,timescale*timescale)
        }
    }
    with (toss) {
        var _logical_speed=speed/_ts
        if (_logical_speed<other.toss_speed) {
            _logical_speed+=1.5*timescale+friction; speed=_logical_speed*_ts; depth=other.depth
            if (_logical_speed>=other.toss_speed) {
                speed=(other.toss_speed+0.0001)*_ts; other.wkick=1
                repeat(2) with (instance_create(x,y,Dust)) motion_set(other.direction+orandom(30),random_range(3,5)*timescale)
                snd_play(sndMeleeFlip,1.4+random(0.2),0.8); snd_play(sndDiscgun,1.6+random(0.2),0.4)
                scrNTTEFullSealDeadeyeObserve("ready",other.id)
            }
        }
        else {
            depth=other.depth-1; other.toss_spin+=clamp(6*_logical_speed-other.toss_spin,-1,1)*timescale; direction+=other.toss_spin*timescale
        }
        var _length=speed/_ts+other.wkick-(speed-friction)
        x=other.x+lengthdir_x(_length,direction); y=other.y+lengthdir_y(_length,direction); xprevious=x; yprevious=y
        if (other.toss_time>0) other.toss_time-=timescale
        else if (speed/_ts>=other.toss_speed && abs(angle_difference(direction+90*sign(other.toss_spin),other.gunangle))<abs(other.toss_spin*0.5*max(1,timescale))) {
            // Source hspeed/vspeed are logical; only its final subtraction is raw.
            other.toss=noone; x=other.x+hspeed/_ts; y=other.y+vspeed/_ts; direction+=90*sign(other.toss_spin); x-=hspeed; y-=vspeed
            with (other) motion_add(other.direction,3*timescale)
            repeat(2) with (instance_create(x,y,Smoke)) {
                motion_set(other.direction+orandom(30),random_range(2,random(other.speed/_ts*2/3))*timescale); image_xscale*=2/3; image_yscale*=2/3
            }
            scrNTTEFullCoastSoundAt(x,y,sndDiscDie,0.6+random(0.1),2); scrNTTEFullCoastSoundAt(x,y,sndMeleeFlip,0.8+random(0.2),3)
            scrNTTEFullSealDeadeyeObserve("release",other.id)
        }
        // UberCont already compensates native alarms to logical 30 Hz ticks.
        if (instance_is(id,Disc)) { dist=0; alarm[0]=max(alarm[0],9) }
        other.right=sign(lengthdir_x(1,direction))
    }
}
function scrNTTEFullSealStep() {
    if (lockstep_stop) return;
    if (hp<=0) { instance_destroy(); return }
    if (setup) scrNTTEFullSealSetup()
    if (ntte_seal_timer1>0) {
        ntte_seal_timer1-=timescale
        if (ntte_seal_timer1<=0) { ntte_seal_timer1=-1; scrNTTEFullSealDecision() }
    }
    if (ntte_seal_timer2>0) {
        ntte_seal_timer2-=timescale
        if (ntte_seal_timer2<=0) { ntte_seal_timer2=-1; scrNTTEFullSealAttack() }
    }
    if (walk>0) { walk-=timescale; speed+=walkspeed*timescale*timescale }
    speed=min(speed,maxspeed*timescale)
    if (wkick!=0) wkick=approach(wkick,0,timescale)
    if (slide>0) {
        slide-=timescale; motion_add(direction,min(slide,2)*timescale*timescale)
        var _turn=5*sin(current_frame/10)*timescale
        if (type==NTTEFullSealType.Dasher) _turn/=3
        direction+=_turn; gunangle+=_turn
        if (random(skeal ? 3:1)<timescale) with (instance_create(x+orandom(3),y+6,skeal ? Smoke:Dust)) direction=other.direction
    }
    if (attack_delay>0) attack_delay-=timescale
    switch(type) {
        case NTTEFullSealType.Hookpole:
            if (ntte_seal_timer2>0) wkick+=2*timescale
            else if (wkick<0) wkick-=wkick/20*timescale
            break
        case NTTEFullSealType.Shield:
            if (shield && !instance_exists(shield_inst)) { shield_inst=scrNTTEFullSealShot(NTTEFullClamShield,gunangle); shield_inst.mask_index=sprWall0Out }
            else if (!shield && instance_exists(shield_inst)) instance_destroy(shield_inst)
            break
        case NTTEFullSealType.Blunderbuss:
            if (ntte_seal_timer2>0 && current_frame_active) {
                // Same six-way selection as source1+irandom(5); static
                // references preserve native sound binding on all runners.
                var _sound=choose(sndFootPlaSand1,sndFootPlaSand2,sndFootPlaSand3,sndFootPlaSand4,sndFootPlaSand5,sndFootPlaSand6)
                // Native snd_play checks audio_exists and tolerates muted or
                // unavailable audio; charging must still produce smoke/fire.
                snd_play(_sound)
                with (instance_create(x,y,Smoke)) {
                    motion_set(other.gunangle+other.right*120+orandom(20),(1+random(1))*timescale)
                    image_xscale/=2; image_yscale=image_xscale; growspeed-=0.01; depth=other.depth-(other.gunangle>180)
                }
            }
            break
        case NTTEFullSealType.Deadeye:scrNTTEFullSealDeadeyeStep(); break
        case NTTEFullSealType.Dasher:if (slide<=0 && gunangle>180) gunangle=random(180); break
        default:
            if (walk>0) direction+=orandom(10)
            if (type==NTTEFullSealType.None && scared) {
                var _palanking=asset_get_index("NTTEFullPalanking"),_has_palanking=object_exists(_palanking) && instance_exists(_palanking)
                if (!_has_palanking && scrNTTEFullValue(id,"wading",0)>0
                    && (x+sprite_width<view_xview || x-sprite_width>view_xview+view_width || y+sprite_height<view_yview || y-sprite_height>view_yview+view_height)) hp=0
            }
            break
    }
    var _anim_end=image_index+image_speed>=image_number || image_index+image_speed<0
    if (sprite_index!=spr_spwn) {
        if (sprite_index!=spr_hurt || _anim_end) {
            if (speed<=0) { if (sprite_index!=spr_idle) image_index+=random(2); sprite_index=spr_idle }
            else sprite_index=spr_walk
        }
    }
    else {
        if (_anim_end) { sprite_index=spr_idle; wkick=4; var _dust=instance_create(x,y,skeal ? Smoke:Dust); /* NTTE DUST LIFETIME seal-animation */ if(instance_exists(_dust)) {_dust.depth=depth-1 } }
        if (skeal) speed=0
        if (image_index<2) {
            if (skeal) { if (current_frame_active) scrNTTEFullSealFX(Smoke,90,1) }
            else y-=image_index*timescale
        }
    }
}
function scrNTTEFullSealDraw() {
    var _draw_weapon=sprite_index!=spr_spwn || image_index>(skeal ? 5:2),_angle=image_angle,_y=y
    if (slide>0) { image_angle=direction-90; y+=2 }
    if (type==NTTEFullSealType.Shield && _draw_weapon) {
        if (shield) draw_sprite_ext(spr_weap,0,x+2-8*right,y-16,1,1,270+right*25,image_blend,image_alpha)
        else draw_sprite_ext(scrNTTERefSprite("ClamShieldWep"),0,x-right,y,1,right,image_angle+90,c_white,image_alpha)
    }
    var _back=gunangle<=180
    if (!_back) draw_sprite_ext(sprite_index,image_index,x,y,image_xscale*right,image_yscale,image_angle,image_blend,image_alpha)
    if (_draw_weapon && !instance_exists(shield_inst) && sprite_exists(spr_weap)) {
        var _dir=gunangle+wepangle*(1-wkick/20),_side=wepangle==0 ? right:sign(wepangle)
        draw_sprite_ext(spr_weap,0,x-lengthdir_x(wkick,_dir),y-lengthdir_y(wkick,_dir),1,_side,_dir,image_blend,image_alpha)
    }
    if (_back) draw_sprite_ext(sprite_index,image_index,x,y,image_xscale*right,image_yscale,image_angle,image_blend,image_alpha)
    if (slide>0) { image_angle=_angle; y=_y }
}
function scrNTTEFullSealHurt() {
    if (type==NTTEFullSealType.None) {
        with (NTTEFullSeal) if (type==other.type && !scared && instance_exists(target) && point_distance(x,y,target.x,target.y)<80) {
            scared=true; instance_create(x,y,NTTEFullAssassinNotice)
        }
    }
    else if (type==NTTEFullSealType.Shield) snd_play_hit(sndHitRock,0.3)
}
function scrNTTEFullSealDeath() {
    if (hp>0) return;
    scrNTTEFullWorldPickupDrop(50,0)
    if (instance_exists(toss) && (toss.speed<toss_speed*timescale || toss_spin<20)) {
        with (toss) { snd_play_hit(sndDiscDie,0.2); var _fx=instance_create(x,y,DiscDisappear); _fx.depth=depth }
        instance_destroy(toss,false)
    }
    if (skeal) {
        snd_play_hit(sndBloodGamble,0.1)
        for(var _d=direction;_d<direction+360;_d+=120) scrNTTEFullSealFX(Smoke,_d,3)
    }
}
function scrNTTEFullSealSmoke() {
    var _before=scrNTTEFullInstances(all),_loops=GameCont.loops
    GameCont.loops=0
    for(var _type=0;_type<=6;++_type) {
        var _seal=instance_create(49000+_type*64,49000,NTTEFullSeal)
        _seal.type=_type
        with (_seal) scrNTTEFullSealSetup()
        assert(_seal.hp==10 && _seal.max_hp==10 && _seal.walkspeed==0.8 && _seal.maxspeed==3.5 && _seal.raddrop==1 && _seal.mask_index==mskBandit,"Seal original common stats changed")
        assert(_seal.spr_idle==scrNTTERefSprite("SealIdle",_type) && _seal.spr_weap==scrNTTERefSprite("SealWeap",_type),"Seal loadout art mapping changed")
        _seal.gunangle=0; _seal.ntte_seal_timer1=1000; _seal.ntte_seal_timer2=-1; _seal.sprite_index=_seal.spr_idle
        switch(_type) {
            case NTTEFullSealType.Hookpole:
                var _n=instance_number(Shank)
                _seal.trident_dist=36
                with (_seal) scrNTTEFullSealAttack()
                assert(instance_number(Shank)==_n+1 && _seal.x==49000+_type*64+4 && _seal.wkick==-36,"Seal hookpole omitted retracting shank or forward lunge")
                var _shot=instance_find(Shank,_n)
                assert(_shot.damage==3 && _shot.knockback_speed==12*timescale && _shot.direction==180 && _shot.image_xscale==0.5,"Seal hookpole source three damage/twelve pull force changed")
                break
            case NTTEFullSealType.Shield:
                _seal.shield=true
                with (_seal) scrNTTEFullSealStep()
                assert(instance_exists(_seal.shield_inst) && _seal.shield_inst.mask_index==sprWall0Out && _seal.shield_inst.creator==_seal,"Seal did not construct its actual source ClamShield")
                _seal.shield=false
                with (_seal) scrNTTEFullSealStep()
                assert(!instance_exists(_seal.shield_inst),"Seal sword mode retained active shield")
                break
            case NTTEFullSealType.Blunderbuss:
                var _n=instance_number(EnemyBullet1)
                with (_seal) scrNTTEFullSealAttack()
                assert(instance_number(EnemyBullet1)==_n+6 && _seal.wkick==10,"Seal blunderbuss omitted six source pellets/recoil")
                break
            case NTTEFullSealType.Mercenary:
                var _n=instance_number(EnemyBullet3)
                with (_seal) scrNTTEFullSealAttack()
                assert(instance_number(EnemyBullet3)==_n+1 && _seal.wkick==5,"Seal mercenary used wrong projectile or recoil")
                break
            case NTTEFullSealType.Deadeye:
                _seal.toss=instance_create(_seal.x,_seal.y,NTTEFullSealDisc); _seal.toss.creator=_seal
                _seal.toss_speed=8; _seal.toss_time=60
                var _sound_observer=variable_global_exists("ntte_full_coast_sound_observer")?global.ntte_full_coast_sound_observer:undefined
                global.ntte_full_coast_sound_observer=[]
                try {
                    repeat(ceil(20/timescale)) with (_seal) scrNTTEFullSealDeadeyeStep()
                    assert(instance_exists(_seal.toss) && _seal.toss.speed>=8*timescale && _seal.toss_spin>0 && _seal.toss.dist==0,"Seal deadeye omitted source disc spin-up/hold/native disc refresh")
                    assert(array_length(global.ntte_full_coast_sound_observer)==0,"Seal deadeye played its positional throw sounds during spin-up")
                    var _held=20,_disc=_seal.toss
                    while(instance_exists(_seal.toss) && _held<100) {
                        with(_seal) scrNTTEFullSealDeadeyeStep()
                        _held+=timescale
                        if(_held<60) assert(instance_exists(_seal.toss),"Seal deadeye released before the source sixty-logical-tick hold")
                    }
                    assert(!instance_exists(_seal.toss) && instance_exists(_disc),"Seal deadeye did not release its actual disc at tangent alignment")
                    var _sounds=global.ntte_full_coast_sound_observer
                    assert(array_length(_sounds)==2 && _sounds[0].sound==sndDiscDie && _sounds[1].sound==sndMeleeFlip
                        && _sounds[0].gain==2 && _sounds[1].gain==3 && _sounds[0].fade==64 && _sounds[1].fade==64
                        && _sounds[0].falloff==1 && _sounds[1].falloff==1
                        && _sounds[0].x==_disc.x && _sounds[0].y==_disc.y
                        && _sounds[1].x==_disc.x && _sounds[1].y==_disc.y,
                        "Seal deadeye throw bypassed original spatial sound, changed source gain/falloff, or repeated its throw")
                    _seal.toss_ammo=0
                    repeat(ceil(20/timescale)) with (_seal) scrNTTEFullSealDeadeyeStep()
                    assert(_seal.type==NTTEFullSealType.None && array_length(global.ntte_full_coast_sound_observer)==2,"Seal deadeye retained source two-disc ammo or repeated released-disc sound")
                }
                finally {global.ntte_full_coast_sound_observer=_sound_observer}
                break
            case NTTEFullSealType.Dasher:
                var _n=instance_number(EnemyBullet1)
                with (_seal) scrNTTEFullSealAttack()
                assert(instance_number(EnemyBullet1)==_n+1 && _seal.wkick==10,"Seal dasher source shot/recoil changed")
                break
        }
    }
    var _skeal=instance_create(49600,49000,NTTEFullSeal)
    _skeal.skeal=true; _skeal.type=NTTEFullSealType.Hookpole
    with (_skeal) scrNTTEFullSealSetup()
    assert(_skeal.hp==20 && _skeal.max_hp==20 && _skeal.raddrop==5 && _skeal.maxspeed==2.5 && _skeal.spr_idle==scrNTTERefSprite("SkealIdle"),"Skeletal Seal doubled health/rad bonus/speed/art changed")
    var _sweat=instance_create(49600,49100,NTTEFullSweat)
    assert(_sweat.depth==-2 && _sweat.image_speed==0 && _sweat.ntte_sweat_timer>=11 && _sweat.ntte_sweat_timer<15 && abs(_sweat.gravity-0.04*timescale*timescale)*1000000<=1,"Original Sweat source timing/depth/gravity changed")
    repeat(ceil(15/timescale)) if (instance_exists(_sweat)) with (_sweat) event_perform(ev_step,ev_step_normal)
    assert(!instance_exists(_sweat),"Original Sweat constant-frame sprite did not expire")
    var _all=scrNTTEFullInstances(all)
    for(var _i=0;_i<array_length(_all);++_i) if (array_get_index(_before,_all[_i])<0) instance_destroy(_all[_i],false)
    GameCont.loops=_loops
    scrNTTESmokeLog("FULL WORLD SEVEN SEAL LOADOUTS/RETRACTING HOOK/CLAM SHIELD/SIX PELLETS/MERCENARY/DISC SPIN+TANGENT RELEASE/DASHER/SKELETAL STATS + ORIGINAL SWEAT LIFETIME OK")
}

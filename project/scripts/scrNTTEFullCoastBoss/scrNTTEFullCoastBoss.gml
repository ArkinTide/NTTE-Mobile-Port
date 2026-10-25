// tedesert.mod.gml1176..1998. Rebuilt skull and original Big Fish boss.
function scrNTTEFullCoastBossBecomeCreate() {
    spr_idle=scrNTTERefSprite("BigFishBecomeIdle"); spr_hurt=scrNTTERefSprite("BigFishBecomeHurt"); spr_dead=sprBigSkullDead
    sprite_index=spr_idle; mask_index=mskScorpion; depth=-1; max_hp=100*(1+GameCont.loops); size=2
    part=min(scrNTTEFullValue(GameCont,"ntte_visits_coast",0)+GameCont.loops,sprite_get_number(spr_idle)-2)
}
function scrNTTEFullCoastBossBecomeAfterCreate() {
    spr_shadow=shd32; image_speed=0; snd_hurt=sndHitRock; snd_dead=-1; team=0
    prompt=scrNTTEFullPromptCreate(id,"DONATE"); prompt.on_meet=scrNTTEFullCoastBossBecomePromptMeet
}
function scrNTTEFullCoastBossBecomePromptMeet(_player) { return _player.race==Race.Skeleton }
function scrNTTEFullCoastBossBecomeStep() {
    if (lockstep_stop) return;
    speed=0; x=xstart; y=ystart
    sprite_index=nexthurt<current_frame+4 ? spr_idle:spr_hurt; image_index=clamp(part,0,image_number-1)
    if (instance_exists(prompt) && prompt.pick>=0) {
        var _player=noone,_pick=prompt.pick
        with (Player) if (index==_pick) _player=id
        if (instance_exists(_player)) {
            // NTT creates a34damage ordinary Bone solely to feed this skull.
            // The port has a native thrown-bone attack rather than a Bone object.
            with (_player) { scr_hit(id,1,[sprBone,"GENEROSITY"]); lasthit=[sprBone,"GENEROSITY"] }
            var _bone=instance_create(x,y,NTTEAttack)
            _bone.kind=NTTEKind.Bone; _bone.weapon=wep_ntte_bone; _bone.damage=34; _bone.state=undefined
            scrNTTEFullCoastBossBecomeHurt(id,34,0,0,_bone)
        }
    }
    if (part>0) {
        var _size=4*part,_walls=scrNTTEFullRectInstances(bbox_left-_size-_size*image_xscale,bbox_top,bbox_right-1+_size-_size*image_xscale,bbox_bottom-1,Wall)
        for(var _i=0;_i<array_length(_walls);++_i) with (_walls[_i]) { instance_create(x,y,FloorExplo); instance_destroy() }
        if (part>=sprite_get_number(spr_idle)-1) {
            var _boss=instance_create(x-image_xscale*8,y-6,NTTEFullCoastBoss)
            _boss.x=_boss.xstart; _boss.y=_boss.ystart; _boss.right=image_xscale
            with (WantBoss) instance_destroy()
            with (BanditBoss) hp=0
            scrNTTEFullPortalPoof()
            scrNTTEFullCoastBossBecomeCleanup(); instance_destroy(id,false); return;
        }
    }
    if (hp<=0) instance_destroy()
}
function scrNTTEFullCoastBossBecomeHurt(_target,_damage,_direction,_force,_attacker) {
    with (_target) {
        hp-=_damage; nexthurt=current_frame+6; snd_play_hit(snd_hurt,0.3)
        if (!instance_exists(_attacker)) return;
        var _bone=instance_is(_attacker,NTTEFullCrabboneBone) || (instance_is(_attacker,NTTEAttack) && _attacker.kind==NTTEKind.Bone),
            _arrow=instance_is(_attacker,NTTEFullBoneArrow),_weapon=scrNTTEFullWeaponModel(scrNTTEFullValue(_attacker,"wep",scrNTTEFullValue(_attacker,"weapon",wep_none))),
            _raw=scrNTTEFullWeaponRaw(_weapon),_type=is_struct(_weapon) ? scrNTTEFullValue(_weapon,"type_index",0):0,
            _thrown=scrNTTEFullValue(_attacker,"ntte_full_thrown_wep",false)
        if (_arrow || ((_bone || _thrown) && _raw==wep_ntte_bone && _type==0)) {
            var _ammo=_bone ? 1:(is_struct(_weapon) ? scrNTTEFullValue(_weapon,"ammo",1):1)
            // ThrownWep's source LWO carries ammo. Actual fired individual bones
            // contribute one even if their firing slot previously held a stack.
            if (_thrown) _ammo=scrNTTEFullValue(scrNTTEFullValue(_attacker,"state",undefined),"ammo",_ammo)
            var _add=_ammo+scrNTTEFullValue(_attacker,"big",0)
            part+=_add; hp=max(hp,max_hp); snd_play_hit(sndMutant14Turn,0.2)
            repeat(3*_add) {
                instance_create(_attacker.x+orandom(4),_attacker.y+orandom(4),Bubble)
                with (instance_create(x-image_xscale*8*part,y,Smoke)) { motion_add(random(360),timescale); depth=-2 }
            }
            if (_bone) _attacker.broken=true
            instance_destroy(_attacker,false)
        }
    }
}
function scrNTTEFullCoastBossBecomeCleanup() {
    if (instance_exists(prompt)) instance_destroy(prompt,false)
    prompt=noone
}
function scrNTTEFullCoastBossBecomeDeath() {
    scrNTTEFullCoastBossBecomeCleanup()
    if (part>0) {
        snd_play(sndOasisDeath)
        repeat(part) { with (scrWeaponPickupCreate(x,y,wep_ntte_bone)) motion_add(random(360),3*timescale); repeat(2) instance_create(x,y,Bubble) }
    }
    else for(var _a=direction;_a<direction+360;_a+=36) with (instance_create(x,y,Dust)) motion_set(_a,3*timescale)
}

function scrNTTEFullCoastBossCreate() {
    boss=true; spr_spwn=scrNTTERefSprite("BigFishSpwn"); spr_idle=sprBigFishIdle; spr_walk=sprBigFishWalk; spr_hurt=sprBigFishHurt; spr_dead=sprBigFishDead
    spr_chrg=sprBigFishFireStart; spr_fire=sprBigFishFire; spr_efir=sprBigFishFireEnd; spr_dive=scrNTTERefSprite("BigFishLeap"); spr_rise=scrNTTERefSprite("BigFishRise")
    sprite_index=spr_spwn; hitid=HitId.OasisBoss; mask_index=mskBigMaggot; depth=-2
    ntte_coast_hp=scrNTTEFullSewerBossHP(150); max_hp=ntte_coast_hp/(1+GameCont.loops/20)
    raddrop=50; size=3; meleedamage=3; walk=0; walkspeed=0.8; maxspeed=3; ammo=4; swim=0; swim_mask=-1; swim_target=noone
    ntte_coast_angle=random(360); gunangle=ntte_coast_angle; direction=gunangle; canfly=true; intro=false; tauntdelay=40
    swim_ang_frnt=direction; swim_ang_back=direction; shot_wave=0; fish_train=array_create(GameCont.loops*3,noone); fish_swim=[]; fish_swim_delay=0; fish_swim_regen=0
    ntte_coast_timers=[-1,90,-1,-1]; bossname="BIG FISH"; col=c_red
}
function scrNTTEFullCoastBossAfterCreate() {
    hp=ntte_coast_hp; max_hp=hp; gunangle=ntte_coast_angle; spr_shad=shd48; spr_shadow=spr_shad
    snd_hurt=sndOasisBossHurt; snd_dead=sndOasisBossDead; snd_mele=sndOasisBossMelee; snd_lowh=sndOasisBossHalfHP
    for(var _i=0;_i<4;++_i) alarm[_i]=-1
}
function scrNTTEFullCoastBossAlarm1() {
    ntte_coast_timers[1]=30+random(20); scrTarget()
    if (scrNTTEFullWorldTargetVisible()) {
        var _dis=point_distance(x,y,target.x,target.y)
        if (_dis<160 && (scrNTTEFullValue(target,"reload",0)<=0 || random(3)<2)) {
            scrNTTEFullWorldLook(point_direction(x,y,target.x,target.y))
            if ((_dis<64 && random(2)<1) || random(4)<1) { scrNTTEFullWorldWalk(gunangle+orandom(10),random_range(30,40)); ntte_coast_timers[1]=walk+random(10) }
            else {
                ammo=4*(GameCont.loops+2); ntte_coast_timers[2]=3; ntte_coast_timers[1]=-1
                scrNTTEFullWorldWalk(gunangle+orandom(30),8); sprite_index=spr_chrg; image_index=0; snd_play(sndOasisBossFire,1+orandom(0.2))
            }
        }
        else ntte_coast_timers[3]=6
    }
    else { ntte_coast_timers[1]=40+random(20); scrNTTEFullWorldWalk(random(360),20); scrNTTEFullWorldLook(direction) }
}
function scrNTTEFullCoastBossAlarm2() {
    repeat(irandom_range(1,2)) if (ammo>0) {
        ntte_coast_timers[2]=2; snd_play(sndOasisShoot)
        scr_projectile_create(x,y,NTTEFullBubbleBomb,gunangle+sin(shot_wave/4)*16,8+random(4))
        shot_wave+=2; walk++
        if (--ammo<=0) ntte_coast_timers[1]=60
    }
}
function scrNTTEFullCoastBossAlarm3() {
    scrTarget(); swim_target=target; ntte_coast_timers[3]=8; ntte_coast_timers[1]=18
    if (sprite_index!=spr_dive) {
        if (swim<=0) { sprite_index=spr_dive; image_index=0; spr_shadow=mskNone; snd_play(sndOasisBossMelee) }
        else if (swim>80) { scr_projectile_create(x,y,NTTEFullBubbleBomb,direction+orandom(10),4); snd_play_hit(sndBouncerBounce,0.3) }
    }
}
function scrNTTEFullCoastBossSpawnFX() {
    hspeed+=2*right*timescale; vspeed+=orandom(2)*timescale; scrNTTEFullTrenchShake(x,y,15); instance_create(x,y,PortalClear)
    for(var _dir=direction;_dir<direction+360;_dir+=72) {
        repeat(2) with (instance_create(x,y,Dust)) motion_set(_dir+orandom(30),5*timescale)
        with (scrNTTEFullWorldCreateRequired("WaterStreak",x,y)) { motion_set(_dir+orandom(30),(1+random(4))*timescale); image_angle=direction; image_speed*=random_range(0.8,1.2) }
    }
    snd_play(sndOasisBossDead,1.2+random(0.1),1.2)
    if (!intro) { intro=true; scrNTTEFullBossIntro("BigFish"); snd_play(sndOasisBossIntro) }
}
function scrNTTEFullCoastBossSwimFX() {
    if (!current_frame_active) return;
    image_angle=0
    var _cx=x,_cy=y+7,_speed=speed/max(timescale,0.000001),_vx=hspeed,_vy=vspeed
    if ((place_meeting(x,y,FloorExplo) && random(30)<1) || random(40)<1) repeat(irandom(2)) with (instance_create(_cx,_cy,Debris)) speed/=2
    var _dist=[16,-4],_angle=[swim_ang_frnt,swim_ang_back],_spread=[20,30]
    for(var _o=0;_o<2;++_o) for(var _side=-1;_side<=1;_side+=2) {
        var _x=_cx+lengthdir_x(_dist[_o],_angle[_o]),_y=_cy+lengthdir_y(_dist[_o],_angle[_o]),_a=_side*_spread[_o]
        if (_speed>1) with (instance_create(_x,_y,BoltTrail)) {
            motion_add(_angle[_o]+180+_a,_speed*random_range(0.5,1)*timescale); image_xscale=speed/max(timescale,0.000001)*2
            image_yscale=scr_skill_get(mut_bolt_marrow)>0 ? 0.6:1; image_angle=direction; hspeed+=_vx; vspeed+=_vy; friction=random(0.5)*timescale*timescale; depth=other.depth
        }
        if (random(20)<1) with (instance_create(_x,_y,Dust)) {
            hspeed+=_vx/2; vspeed+=_vy/2; motion_add(_angle[_o]+180+2*_a,_speed*timescale); image_xscale*=0.75; image_yscale=image_xscale; depth=other.depth
        }
    }
    if (random(4)<1) scrNTTEFullTrenchShake(_cx,_cy,4)
}
function scrNTTEFullCoastBossSwimEnd() {
    swim=0; ntte_coast_timers[3]=-1; scrNTTEFullWorldLook(direction); speed=0; spr_shadow=spr_shad
    sprite_index=spr_rise; image_index=0; depth=-2; mask_index=swim_mask; swim_mask=-1
    instance_create(x,y,PortalClear); snd_play(sndFootOrgSand1,0.5,5); snd_play(sndToxicBoltGas,0.5+random(0.2),0.5)
    repeat(10) { var _d=random(360); with (instance_create(x+lengthdir_x(12,_d),y+lengthdir_y(12,_d),Dust)) motion_add(_d,3*timescale) }
}
function scrNTTEFullCoastBossTrain() {
    var _leader=id,_broken=false
    for(var _i=0;_i<array_length(fish_train);++_i) {
        var _fish=fish_train[_i],_swim=_i<array_length(fish_swim) && fish_swim[_i]
        if (_broken) { if (instance_exists(_fish)) _fish.visible=true; fish_train[_i]=noone; continue }
        if (!instance_exists(_fish) && fish_swim_regen<=0 && _swim) {
            fish_swim_regen=3
            _fish=random(100)<1 ? scrNTTEFullWorldCreateRequired("Puffer",_leader.x,_leader.y):instance_create(_leader.x,_leader.y,BoneFish)
            _fish.kills=0; _fish.creator=id
            with (_fish) {
                var _dir=_leader.direction+180
                while(point_distance(x,y,_leader.x,_leader.y)<24) { x+=lengthdir_x(2,_dir); y+=lengthdir_y(2,_dir); direction=_dir }
                repeat(8) with (instance_create(x,y,Dust)) { motion_add(random(360),timescale); depth=other.depth-1 }
            }
            fish_train[_i]=_fish
        }
        if (instance_exists(_fish)) {
            with (_fish) {
                alarm[1]=15+_i*4; visible=!_swim
                if (_swim) {
                    scrNTTEFullWorldLook(point_direction(x,y,_leader.x,_leader.y))
                    if (speed>0 && current_frame_active && random(3)<1) with (instance_create(x+orandom(6),y+random(8),NTTEFullSweat)) { direction=other.direction+choose(-60,60)+orandom(10); speed=0.5*timescale }
                }
                var _dis=distance_to_object(_leader),_dir=point_direction(x,y,_leader.x,_leader.y)
                if (_dis>6) { while(_dis>6) { x+=lengthdir_x(2,_dir); y+=lengthdir_y(2,_dir); _dis-=2 }; motion_add(_dir,timescale) }
                _leader=id
            }
        }
        else { _broken=true; fish_train[_i]=noone }
    }
    if (fish_swim_delay<=0) {
        fish_swim_delay=3
        for(var _state=0;_state<=1;++_state) {
            var _pos=-1
            for(var _i=array_length(fish_swim)-1;_i>=0;--_i) if (fish_swim[_i]==_state) { _pos=_i; break }
            if (_pos>=0 && _pos<array_length(fish_train)-1) {
                fish_swim[_pos+1]=_state
                var _fish=fish_train[_pos+1]
                if (instance_exists(_fish)) with (_fish) repeat(8) with (instance_create(x+hspeed+orandom(8),y+vspeed+orandom(8),Dust)) depth=other.depth-1
            }
        }
        fish_swim[0]=swim>0
    }
    fish_swim_delay-=timescale; fish_swim_regen-=timescale
}
function scrNTTEFullCoastBossStep() {
    if (lockstep_stop) return;
    if (hp<=0) { instance_destroy(); return }
    // Source alarmN_run exits the custom Step immediately after first due timer.
    for(var _i=1;_i<=3;++_i) if (ntte_coast_timers[_i]>=0) {
        ntte_coast_timers[_i]-=timescale
        if (ntte_coast_timers[_i]<=0) {
            ntte_coast_timers[_i]=-1
            switch(_i) { case 1:scrNTTEFullCoastBossAlarm1();break; case 2:scrNTTEFullCoastBossAlarm2();break; case 3:scrNTTEFullCoastBossAlarm3();break }
            return;
        }
    }
    scrNTTEFullWorldWalkStep()
    var _special=[spr_hurt,spr_spwn,spr_chrg,spr_fire,spr_efir,spr_dive,spr_rise]
    if (array_get_index(_special,sprite_index)<0) sprite_index=scrNTTEFullWorldEnemySprite()
    else if (image_index+image_speed>=image_number) {
        if (sprite_index==spr_spwn) { sprite_index=spr_hurt; image_index=0; scrNTTEFullCoastBossSpawnFX() }
        else if (sprite_index==spr_dive) { sprite_index=spr_idle; image_index=0; swim=180; direction=90-right*90; swim_ang_frnt=direction; swim_ang_back=direction; depth=-1 }
        else if (sprite_index==spr_hurt || sprite_index==spr_rise || sprite_index==spr_efir) { sprite_index=spr_idle; image_index=0 }
        else if (sprite_index==spr_chrg) { sprite_index=spr_fire; image_index=0 }
        else if (sprite_index==spr_fire && ammo<=0) { sprite_index=spr_efir; image_index=0 }
    }
    if (swim>0) {
        swim-=timescale
        if (swim_mask!=-1) mask_index=swim_mask
        if (instance_exists(swim_target)) {
            speed+=(friction/max(timescale*timescale,0.000001)+swim/120)*timescale*timescale
            var _tx=swim_target.x,_ty=swim_target.y
            if (point_distance(x,y,_tx,_ty)<100) { _tx+=lengthdir_x(80,direction+10*right); _ty+=lengthdir_y(80,direction+10*right) }
            direction+=angle_difference(point_direction(x,y,_tx,_ty),direction)*(1-power(15/16,timescale))
        }
        else swim=0
        swim_ang_frnt+=angle_difference(direction,swim_ang_frnt)*(1-power(2/3,timescale))
        swim_ang_back+=angle_difference(swim_ang_frnt,swim_ang_back)*(1-power(9/10,timescale))
        if (place_meeting(x+hspeed,y+vspeed,Wall)) {
            speed*=2/3
            var _wall=scrNTTEFullWorldNearestRectBBox(x,y,x,y,Wall)
            if (instance_exists(_wall)) {
                var _cx=(_wall.bbox_left+_wall.bbox_right)/2,_cy=(_wall.bbox_top+_wall.bbox_bottom)/2
                with (instance_create(_cx,_cy,MeleeHitWall)) { motion_add(point_direction(x,y,_cx,_cy),timescale); image_angle=direction+180 }
            }
            snd_play(sndHammerHeadProc,1.4+random(0.2),0.5)
            with (instance_create(x,y,PortalClear)) { image_xscale/=2; image_yscale=image_xscale }
        }
        spr_shadow=mskNone; scrNTTEFullCoastBossSwimFX()
        var _self=id
        with (Player) if (team!=other.team && place_meeting(x,y,_self)) with (_self) event_perform(ev_collision,Player)
        with (prop) if (place_meeting(x,y,_self)) with (_self) event_perform(ev_collision,prop)
        with (BoltStick) if (target==_self) { snd_play_hit(sndCrystalPropBreak,0.3); repeat(5) with (instance_create(x,y,Dust)) motion_add(random(360),3*timescale); instance_destroy() }
        if (swim_mask==-1) swim_mask=mask_index
        mask_index=mskNone
        if (swim<=0) scrNTTEFullCoastBossSwimEnd()
    }
    if (tauntdelay>0 && !instance_exists(Player)) { tauntdelay-=timescale; if (tauntdelay<=0) snd_play(sndOasisBossHalfHP,0.8) }
    scrNTTEFullCoastBossTrain()
}
function scrNTTEFullCoastBossHurt(_target,_damage,_direction,_force,_attacker) {
    with (_target) {
        hp-=_damage; nexthurt=current_frame+6; snd_play_hit(snd_hurt,0.3)
        if (hp<=max_hp/2 && hp+_damage>max_hp/2) snd_play(snd_lowh)
        if (swim<=0) motion_add(_direction,_force)
        if (array_get_index([spr_spwn,spr_chrg,spr_fire,spr_efir,spr_dive,spr_rise],sprite_index)<0) { sprite_index=spr_hurt; image_index=0 }
    }
}
function scrNTTEFullCoastBossDraw() {
    var _hurt=nexthurt>=current_frame+4
    for(var _i=0;_i<array_length(fish_train);++_i) {
        var _fish=fish_train[_i]
        if (instance_exists(_fish) && _i<array_length(fish_swim) && fish_swim[_i]) with (_fish) {
            var _spr=sprite_index,_xsc=image_xscale*right,_ysc=image_yscale
            draw_sprite_part_ext(_spr,image_index,0,0,sprite_get_width(_spr),sprite_get_yoffset(_spr),x-sprite_get_xoffset(_spr)*_xsc,bbox_bottom-sprite_get_yoffset(_spr)*_ysc-2+spr_shadow_y,_xsc,_ysc,image_blend,image_alpha)
        }
    }
    if (swim>0) {
        var _spd=current_frame/3,_spr=[scrNTTERefSprite("BigFishSwimFrnt"),scrNTTERefSprite("BigFishSwimBack")],_ang=[swim_ang_frnt,swim_ang_back]
        if (_hurt) gpu_set_fog(true,image_blend,0,0)
        for(var _i=0;_i<=270;_i+=90) {
            var _x=x,_y=y+7,_col=image_blend
            if (_i<270) { _x+=dcos(_i); _y-=dsin(_i); _col=c_black }
            for(var _j=0;_j<2;++_j) {
                var _dir=_ang[_j]+180*_j+5*sin(_spd),_trn=(_j==0 ? 15:-25)*cos(_spd)
                for(var _img=0;_img<sprite_get_number(_spr[_j]);++_img)
                    draw_sprite_ext(_spr[_j],_img,_x+lengthdir_x(10*image_xscale,_dir),_y+lengthdir_y(10*image_xscale,_dir)-_img*image_yscale,image_xscale,image_yscale,_ang[_j]-90+_trn,_col,image_alpha)
            }
        }
    }
    else {
        if (_hurt && sprite_index!=spr_hurt) gpu_set_fog(true,image_blend,0,0)
        draw_sprite_ext(sprite_index,image_index,x,y,image_xscale*right,image_yscale,image_angle,image_blend,image_alpha)
    }
    if (_hurt) gpu_set_fog(false,0,0,0)
}
function scrNTTEFullCoastBossTrainShadows(_vx=0,_vy=0) {
    for(var _i=0;_i<array_length(fish_train);++_i) {
        var _fish=fish_train[_i]
        if (instance_exists(_fish) && _i<array_length(fish_swim) && fish_swim[_i]) with (_fish) draw_sprite(spr_shadow,0,x-_vx+spr_shadow_x,y-_vy+spr_shadow_y)
    }
}
function scrNTTEFullCoastBossBoneFishDeath() {
    if (hp<=0 && instance_is(scrNTTEFullValue(id,"creator",noone),NTTEFullCoastBoss) && !scrNTTEFullValue(id,"ntte_coast_train_drop",false)) {
        ntte_coast_train_drop=true; scrNTTEFullWorldPickupDrop(10,0)
    }
}
function scrNTTEFullCoastBossDeath() {
    if (hp>0) return;
    GameCont.killenemies=true
    // Source sets Coast0 before the native portal increments to Coast1.
    // Mobile pending-area applies the already-advanced destination directly.
    scrNTTEFullAreaSet("coast",1,GameCont.loops); instance_create(x,y,Portal)
    // BEGIN NTTE COAST BOSS SOURCE ENTRY FINISH
    // Portal construction does not restart the room; only RoomEnd consumes this.
    var _entry_pending=scrNTTEFullValue(GameCont,"ntte_full_pending_destination",undefined)
    if (GameCont.area==area_desert && GameCont.subarea==3 && is_struct(_entry_pending)
        && scrNTTEFullValue(_entry_pending,"area",-1)==scrNTTEFullAreaId("coast")
        && scrNTTEFullValue(_entry_pending,"subarea",-1)==1
        && scrNTTEFullValue(_entry_pending,"loops",-1)==GameCont.loops) {
        _entry_pending.ntte_full_source_entry_finish={origin:"coast_boss",
            area:scrNTTEFullAreaId("coast"),subarea:0,loops:GameCont.loops,
            from_area:GameCont.area,from_subarea:GameCont.subarea}
    }
    // END NTTE COAST BOSS SOURCE ENTRY FINISH
    with (MusCont) alarm[1]=1
}

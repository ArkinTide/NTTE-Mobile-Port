// NTT BBOX NORMALIZED: source inclusive right/bottom = modern runner edge-1.
// tetrench PitSquidArm: original charge -> plasma trail -> teleport cycle.
function scrNTTEFullPitSquidArmConfigure() {
    spr_idle=scrNTTERefSprite("TentacleIdle"); spr_walk=spr_idle; spr_hurt=scrNTTERefSprite("TentacleHurt")
    spr_dead=scrNTTERefSprite("TentacleDead"); ntte_full_appear=scrNTTERefSprite("TentacleSpwn")
    ntte_full_disappear=scrNTTERefSprite("TentacleTele"); sprite_index=ntte_full_appear
    hitid=[spr_idle,"PIT SQUID"]; max_hp=irandom_range(20,60); raddrop=0; size=3; walk=0
    mask_index=mskNone; ntte_full_mask=mskLaserCrystal; canfly=true; meleedamage=1; canmelee=false
    creator=noone; ntte_full_bomb=false; ntte_full_bomb_delay=0; ntte_full_teleport=false
    ntte_full_teleport_x=x; ntte_full_teleport_y=y; ntte_full_wave=0
    ntte_full_timers=[-1,15,-1,-1]; ntte_full_last_hp=max_hp; depth=-2
}

function scrNTTEFullPitSquidArmAfterCreate() {
    friction=0.8*timescale*timescale; image_speed=(0.4+orandom(0.1))*timescale
    snd_hurt=sndOasisHurt; snd_dead=sndMeatExplo; snd_mele=sndPlantSnare
    alarm[1]=-1; alarm[2]=-1; alarm[11]=30; canmelee=false; givekill=false
    ntte_full_last_hp=hp
}

function scrNTTEFullPitSquidArmDecision() {
    ntte_full_timers[1]=20+irandom(20)
    scrTarget()
    if (!instance_exists(target) || sprite_index==ntte_full_appear || !scrTargetIsVisible(target)) return;
    var _behind=false
    if (instance_exists(creator)) {
        _behind=(collision_line(x-creator.ntte_full_x,y-creator.ntte_full_y,
            target.x-creator.ntte_full_x,target.y-creator.ntte_full_y,creator,false,false)!=noone)
    }
    if (_behind) { ntte_full_timers[2]=1; return; }
    var _dir=point_direction(x,y,target.x,target.y),_distance=point_distance(x,y,target.x,target.y)
    if (_distance<16) {
        scrNTTEFullTrenchWalk(_dir+180+orandom(30),random_range(10,20)); scrNTTEFullTrenchLook(direction)
        ntte_full_timers[1]=walk+irandom(10)
    }
    else if (_distance<160 && random(2)<1) {
        ntte_full_timers[2]=1; ntte_full_bomb=true; ntte_full_bomb_delay=18
        snd_play(sndPlasmaReloadUpg,0.8+random(0.3),0.6); snd_play(sndOasisPortal,1.1+random(0.3))
    }
    else if (_distance<96) {
        direction+=orandom(30); scrNTTEFullTrenchLook(direction); instance_create(x,y,Bubble)
    }
    else {
        scrNTTEFullTrenchWalk(_dir+orandom(10),random_range(10,20)); scrNTTEFullTrenchLook(direction)
        ntte_full_timers[1]=walk+random(5)
    }
}

function scrNTTEFullPitSquidArmTeleport() {
    scrTarget()
    if (ntte_full_teleport) {
        if (!instance_exists(target)) { instance_destroy(id,false); return; }
        ntte_full_teleport=false; x=ntte_full_teleport_x; y=ntte_full_teleport_y
        xprevious=x; yprevious=y; visible=true; mask_index=ntte_full_mask; sprite_index=ntte_full_appear; image_index=0
        snd_play(sndOasisMelee,1+random(0.3),0.6)
    }
    else if (ntte_full_bomb_delay>0) {
        ntte_full_timers[2]=1; ntte_full_bomb_delay-=1
        repeat(1+irandom(1)) {
            var _fx=instance_create(random_range(bbox_left,(bbox_right-1)+1),random_range(bbox_top,(bbox_bottom-1)+1)-8,PlasmaTrail)
            _fx.sprite_index=scrNTTERefSprite("EnemyPlasmaTrail"); _fx.depth=depth-1
        }
        if (ntte_full_bomb_delay<=0) {
            var _fx=instance_create(x,y-8,ImpactWrists); _fx.sprite_index=scrNTTERefSprite("SquidCharge"); _fx.depth=depth-1
            repeat(2+irandom(4)) {
                var _fx=instance_create(x,y-8,LaserCharge); _fx.depth=depth-1; _fx.alarm[0]=(6+irandom(6))
                with (_fx) motion_set(irandom(359),(2+random(2))*timescale)
            }
            snd_play(sndPlasmaReload,1.8+random(0.4)); snd_play(sndCrystalJuggernaut,1.3+random(0.4),0.5)
        }
    }
    else {
        ntte_full_teleport=true; ntte_full_timers[2]=20+random(20)
        if (instance_exists(target)) {
            if (ntte_full_bomb) {
                ntte_full_bomb=false
                var _p=scr_projectile_create(x,y,NTTEFullPitSquidBomb,point_direction(x,y,target.x,target.y),0)
                // Native scr_damage_create recognizes an explicit creator field
                // before hitme ancestry; arm bombs must retain the arm itself.
                _p.creator=id; _p.target=target; _p.ntte_full_triple=false; _p.ntte_full_ammo=4+irandom(3)
                _p.ntte_full_timers[0]=10; _p.ntte_full_timers[1]+=10
            }
            else {
                var _empty=[],_valid=[],_tx=target.x,_ty=target.y,_boss=creator,
                    _spr=scrNTTERefSprite("FloorTrenchB")
                with (Floor) if (sprite_index==_spr && !scrNTTEFullTrenchPitlessMeeting(x,y)) {
                    array_push(_empty,id)
                    if (!place_meeting(x,y,hitme)) {
                        var _fx=(bbox_left+(bbox_right-1)+1)/2,_fy=(bbox_top+(bbox_bottom-1)+1)/2,_d=point_distance(_fx,_fy,_tx,_ty)
                        if (_d>32 && _d<128) {
                            if (!instance_exists(_boss)) array_push(_valid,id)
                            else {
                                var _squid_distance=point_distance(_fx,_fy,_boss.ntte_full_x,_boss.ntte_full_y)
                                if (_squid_distance>60*_boss.image_xscale && _squid_distance<180*_boss.image_xscale) array_push(_valid,id)
                            }
                        }
                    }
                }
                var _floors=array_length(_valid)>0 ? _valid:_empty
                if (array_length(_floors)>0) {
                    var _floor=_floors[irandom(array_length(_floors)-1)]
                    ntte_full_teleport_x=(_floor.bbox_left+(_floor.bbox_right-1)+1)/2
                    ntte_full_teleport_y=(_floor.bbox_top+(_floor.bbox_bottom-1)+1)/2
                }
            }
        }
        snd_play(sndOasisMelee,0.7+random(0.3))
    }
    ntte_full_timers[1]+=ntte_full_timers[2]
}

function scrNTTEFullPitSquidArmStep() {
    var _due=scrNTTEFullTrenchClock()
    if (_due[1]) scrNTTEFullPitSquidArmDecision()
    if (_due[2]) { scrNTTEFullPitSquidArmTeleport(); if (!instance_exists(id)) return; }
    ntte_full_wave+=timescale
    if (ntte_full_teleport) {
        if (visible) {
            if (sprite_index!=ntte_full_disappear) {
                if (sprite_index!=ntte_full_appear || image_index+image_speed>=image_number) {
                    sprite_index=ntte_full_disappear; image_index=0
                }
            }
            else if (image_index+image_speed>=image_number) visible=false
        }
        if (!visible) mask_index=mskNone
        canmelee=false; alarm[11]=30; speed=0; walk=0
    }
    else {
        if (walk>0) { walk-=timescale; speed+=2*timescale*timescale }
        speed=clamp(speed,1.2*timescale,3.5*timescale)
        if (sprite_index==ntte_full_appear && image_index+image_speed>=image_number) {
            sprite_index=spr_walk; mask_index=ntte_full_mask
        }
    }
    if (creator!=noone && (!instance_exists(creator) || (!ntte_full_bomb && creator.ntte_full_pit_height<1))) {
        if (sprite_index!=ntte_full_appear && sprite_index!=ntte_full_disappear) { hp=0; spr_dead=ntte_full_disappear; snd_dead=-1 }
    }
}

function scrNTTEFullPitSquidArmEndStep() {
    if (!visible) return;
    var _mask=mask_index; mask_index=ntte_full_mask
    if (instance_exists(creator)) {
        var _cx=creator.ntte_full_x,_cy=creator.ntte_full_y-8,_dis=48*abs(creator.image_xscale)
        if (point_distance(x,y,_cx,_cy)<_dis) {
            speed/=2; direction=point_direction(_cx,_cy,x,y)
            x=_cx+lengthdir_x(_dis,direction); y=_cy+lengthdir_y(_dis,direction); xprevious=x; yprevious=y
        }
    }
    if (scrNTTEFullTrenchPitlessMeeting(x,y)) {
        x=xprevious; y=yprevious
        if (scrNTTEFullTrenchPitlessMeeting(x+hspeed,y)) hspeed*=-1
        if (scrNTTEFullTrenchPitlessMeeting(x,y+vspeed)) vspeed*=-1
        speed*=0.5; scrNTTEFullTrenchLook(direction)
        var _clear=instance_create(x,y,PortalClear); _clear.pit_clear=1
    }
    mask_index=_mask
}

function scrNTTEFullPitSquidArmHurt(_amount,_attacker,_direction=undefined,_force=0,_hitid=HitId.None) {
    var _old_hp=hp+_amount
    if(is_undefined(_direction)) _direction=instance_exists(_attacker) ? scrNTTEFullValue(_attacker,"direction",0):direction
    if (creator!=noone && instance_exists(creator)) {
        var _boss=creator,_damage=min(_amount,max(0,_old_hp))
        // Source deliberately forwards through ordinary projectile_hit rather
        // than raw-hit: keep the actual attacker's context and force/direction.
        // GammaGuts is a contact effect, not a projectile with a hitid field.
        // Preserve the cause supplied to the original hit across this bridge.
        if(instance_exists(_attacker)) {
            with(_attacker) scr_projectile_hit(_boss,_damage,_force,_direction,false,_hitid)
        }
        else scr_projectile_hit(_boss,_damage,_force,_direction,false,_hitid)
        with (NTTEFullPitSquidArm) if (creator==_boss) nexthurt=current_frame+6
    }
    ntte_full_last_hp=hp
}

function scrNTTEFullPitSquidArmDeath() {
    if (hp>0 || !instance_exists(GameCont)) return;
    scrNTTEFullPickupDropBody(30,0)
    if (spr_dead!=ntte_full_disappear) {
        for(var _dir=direction;_dir<direction+360;_dir+=120) {
            var _fx=instance_create(x,y,BloodStreak)
            _fx.sprite_index=scrNTTERefSprite("SquidBloodStreak")
            with (_fx) motion_add(_dir+orandom(10),3*timescale)
        }
        sleep(35)
    }
}

function scrNTTEFullPitSquidBombCreate() {
    visible=false; mask_index=mskBandit; creator=noone; target=noone; team=team_none
    ntte_full_ammo=0; ntte_full_triple=true; ntte_full_timers=[3,20,-1,-1]
}

function scrNTTEFullPitSquidBombAdvance() {
    var _dir=direction
    if (instance_exists(target) && instance_exists(creator))
        _dir+=clamp(angle_difference(_dir,point_direction(x,y,target.x,target.y)),-45,45)
    var _tx=x+lengthdir_x(24,_dir),_ty=y+lengthdir_y(24,_dir)
    if (scrNTTEFullTrenchPitGet(_tx,_ty) && !place_meeting(_tx,_ty,Wall)) {
        if (instance_exists(creator)) {
            creator.ntte_full_teleport_x=_tx; creator.ntte_full_teleport_y=_ty
            creator.ntte_full_timers[2]=ntte_full_timers[1]+10
            creator.ntte_full_timers[1]=max(creator.ntte_full_timers[1],creator.ntte_full_timers[2])
        }
        if (ntte_full_ammo>0) {
            var _p=scr_projectile_create(_tx,_ty,NTTEFullPitSquidBomb,_dir,0)
            _p.target=target; _p.ntte_full_ammo=ntte_full_ammo-1
        }
    }
    repeat(irandom_range(3,7)) {
        var _fx=instance_create(x+orandom(12),y+orandom(12),PlasmaTrail); _fx.sprite_index=scrNTTERefSprite("EnemyPlasmaTrail")
    }
    repeat(irandom_range(1,2)) {
        var _fx=instance_create(x+orandom(6),y+orandom(6),LaserCharge)
        _fx.alarm[0]=(10+irandom(5))
        with (_fx) motion_set(_dir,timescale)
    }
}

function scrNTTEFullPitSquidBombStep() {
    var _due=scrNTTEFullTrenchClock()
    if (_due[0]) scrNTTEFullPitSquidBombAdvance()
    if (_due[1]) instance_destroy()
}

function scrNTTEFullPitSquidBombDeath() {
    if (!instance_exists(GameCont)) return;
    if (ntte_full_triple) {
        for(var _i=0;_i<3;++_i) {
            var _dir=direction+120*_i,_p=scr_projectile_create(x+lengthdir_x(8,_dir),y+lengthdir_y(8,_dir),NTTEFullPlasmaImpactSmall,direction,0)
            _p.sprite_index=scrNTTERefSprite("EnemyPlasmaImpactSmall"); _p.image_angle=0
        }
    }
    else {
        var _p=scr_projectile_create(x,y,PlasmaImpact,direction,0)
        _p.sprite_index=scrNTTERefSprite("EnemyPlasmaImpact"); _p.image_angle=0
        if (instance_exists(target) && GameCont.loops>0) {
            var _p=scr_projectile_create(x,y,NTTEFullMortarPlasma,point_direction(x,y,target.x,target.y),3)
            _p.zspeed=point_distance(x,y,target.x,target.y)*_p.zfriction/(_p.speed/timescale*2)
        }
    }
    snd_play_hit(sndEliteShielderFire,0.6); snd_play_hit(sndOasisExplosionSmall,0.4)
}

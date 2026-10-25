// tetrench PitSquid: hidden collision root, pit movement and original attacks.
function scrNTTEFullPitSquidConfigure() {
    boss=true; ntte_full_boss_hp=scrNTTEFullSewerBossHP(340)
    max_hp=ntte_full_boss_hp/(1+GameCont.loops/20); raddrop=50; size=5; canfly=true
    ntte_full_bite_sprite=scrNTTERefSprite("PitSquidMawBite")
    ntte_full_fire_sprite=scrNTTERefSprite("PitSquidMawSpit")
    spr_idle=mskNone; spr_walk=mskNone; spr_hurt=mskNone; spr_dead=-1; sprite_index=mskNone
    hitid=[ntte_full_fire_sprite,"PIT SQUID"]; mask_index=mskNone; ntte_full_mask=sprPortalClear
    ntte_full_x=x; ntte_full_y=y; x=0; y=0; ntte_full_bite=0; ntte_full_spit=0; ntte_full_ammo=0
    ntte_full_sink=false; ntte_full_pit_height=1; ntte_full_intro=false; ntte_full_can_intro=false
    ntte_full_rise_delay=0; ntte_full_taunt=60; ntte_full_side=choose(-1,1); ntte_full_last_plasma=noone
    ntte_full_eye=[]; ntte_full_eye_dir=random(360); ntte_full_eye_turn=0; ntte_full_eye_distance=0
    ntte_full_eye_laser=0; ntte_full_eye_laser_delay=0; ntte_full_timers=[-1,90,90,random_range(1,30)]
    repeat(3) array_push(ntte_full_eye,{x:0,y:0,distance:5,dir:random(360),blink:true,frame:0,laser:noone})
    ntte_full_last_hp=ntte_full_boss_hp; depth=11
}

function scrNTTEFullPitSquidAfterCreate() {
    max_hp=ntte_full_boss_hp; hp=max_hp; canmelee=false; meleedamage=8
    friction=0.01*timescale*timescale; snd_hurt=sndBigDogHit; snd_dead=sndNothing2Hurt; snd_lowh=sndNothing2HalfHP
    gunangle=random(360); image_xscale=1+0.1*GameCont.loops; image_yscale=image_xscale
    alarm[0]=-1; alarm[1]=-1; alarm[2]=-1; spr_shadow=mskNone; corpse=false
    scrNTTEFullPitSquidSmash(false,false)
}

// tetrench PitSquid constructor/Step + telib.wall_clear, not a new hitbox.
function scrNTTEFullPitSquidSmash(_intro,_smash) {
    var _clear=instance_create(ntte_full_x,ntte_full_y-16,PortalClear),
        _factor=1.2/0.75*(_intro ? 1.5:1)
    // Source temporarily sets mask_index=mask before calling wall_clear.
    // Copy that shape without exposing the hidden boss root to collisions.
    _clear.sprite_index=ntte_full_mask
    _clear.image_xscale=image_xscale*_factor
    _clear.image_yscale=image_yscale*_factor
    _clear.image_angle=image_angle
    _clear.pit_clear=0.75
    // Startup opens the pit quietly; only the rising Step launches chunks.
    if (_smash) _clear.pit_smash=true
    return _clear
}

function scrNTTEFullPitSquidTarget() {
    target=noone; var _best=infinity
    with (Player) if (team!=other.team && hp>0) {
        var _d=point_distance(x,y,other.x,other.y)
        if (_d<_best) { _best=_d; other.target=id }
    }
    return instance_exists(target)
}

function scrNTTEFullPitSquidDecision() {
    ntte_full_timers[1]=20+irandom(30)
    if (!scrNTTEFullPitSquidTarget()) return;
    if (!(ntte_full_intro || ntte_full_pit_height<1 || ntte_full_can_intro)) return;
    if (!ntte_full_intro && ntte_full_pit_height>=1) {
        ntte_full_sink=true; ntte_full_timers[1]=3.423*30; return;
    }
    var _dir=point_direction(x,y,target.x,target.y),_dis=point_distance(x,y,target.x,target.y)
    if (_dis>=96 || ntte_full_pit_height<1 || random(2)<1) {
        if (random(2)<ntte_full_pit_height || !ntte_full_intro) {
            motion_add(_dir,timescale*timescale); snd_play(sndRoll,0.2+random(0.2),2); snd_play(sndFishRollUpg,0.4,0.2)
        }
        if (ntte_full_sink) {
            ntte_full_timers[1]=ntte_full_intro ? 20+random(10):3.736*30
            direction=_dir; speed=max(speed,2.4*timescale)
            if (!ntte_full_intro) speed=min(speed,3*timescale)
            if (_dis<(ntte_full_intro ? 40:120)*image_xscale || (ntte_full_intro
                && ((_dis<160*image_xscale && !scrNTTEFullTrenchPitGet(x,y))
                    || (_dis<128*image_xscale && (random(2)<1 || random(max_hp)>=hp))))) {
                ntte_full_sink=false
                if (!ntte_full_intro) {
                    speed/=2; ntte_full_rise_delay=60
                    GameCont.ntte_full_boss_music_key="PitSquid"
                    with (MusCont) { alarm[2]=1; alarm[3]=-1 }
                }
            }
        }
    }
    if (ntte_full_pit_height<1) return;
    var _seen=(_dis<240 && !collision_line(x,y,target.x,target.y,Wall,false,false))
    if (_seen && (random(3)<2 || _dis>128) && ntte_full_eye_laser<=0) {
        // Original temporarily removes pit floors then collision_line(Floor).
        // Test every real non-pit floor directly, preserving exact masks.
        with (Floor) if (sprite_index!=scrNTTERefSprite("FloorTrenchB")) {
            if (collision_line(other.x,other.y,other.target.x,other.target.y,id,false,false)) { _seen=false; break }
        }
    }
    if (!_seen && ntte_full_eye_laser_delay<=0) { ntte_full_sink=true; ntte_full_timers[1]=20; return; }
    var _start=random(360),_num=irandom_range(2,3+floor(5*(image_xscale-1)))
    for(var _i=0;_i<_num;++_i) {
        var _count=0
        with (NTTEFullPitSquidArm) if (creator==other.id) _count+=1
        if (_count<2+10*(image_xscale-1) || random(5+5*_count)<1) {
            var _dir=_start+360*_i/_num,_arm=instance_create(x+lengthdir_x(1,_dir),y+lengthdir_y(1,_dir)-8,NTTEFullPitSquidArm)
            _arm.creator=id; _arm.hitid=hitid; _arm.team=team
            if (random(2)<1) { with (_arm) scrNTTEFullPitSquidArmTeleport(); _arm.ntte_full_timers[2]=1 }
            else _arm.ntte_full_timers[2]=irandom_range(60,150)
        }
    }
}

function scrNTTEFullPitSquidAttack() {
    ntte_full_timers[2]=40+random(20)
    if (ntte_full_pit_height<1 || !ntte_full_intro) { ntte_full_ammo=0; return; }
    if (ntte_full_ammo>0) {
        ntte_full_spit=0.6; var _distance=96
        if (scrNTTEFullPitSquidTarget() && !collision_line(x,y,target.x,target.y,Wall,false,false)) {
            _distance=point_distance(x,y,target.x,target.y)
            var _tx=target.x+_distance/12*target.hspeed/timescale,_ty=target.y+_distance/12*target.vspeed/timescale
            gunangle+=clamp(angle_difference(point_direction(x,y,_tx,_ty),gunangle)*0.5,-60,60)
        }
        var _p=scr_projectile_create(x,y,NTTEFullElectroPlasma,gunangle+2000/max(1,_distance)*image_xscale*ntte_full_side,5)
        _p.ntte_full_tether_inst=ntte_full_last_plasma; _p.image_xscale*=image_xscale; _p.image_yscale*=image_yscale; _p.damage=1
        ntte_full_last_plasma=_p; ntte_full_side*=-1
        snd_play(sndOasisShoot,1.1+random(0.3)); snd_play(sndGammaGutsProc,0.9+random(0.5),0.4)
        instance_create(x+orandom(8),y+orandom(8),PortalL); scrNTTEFullTrenchShake(x,y,5,true)
        ntte_full_ammo-=1
        if (ntte_full_ammo>0) { ntte_full_timers[2]=5+random(2); ntte_full_timers[1]+=ntte_full_timers[2] }
        else snd_play(sndOasisDeath,0.9+random(0.3),2.4)
        return;
    }
    if (!scrNTTEFullPitSquidTarget() || collision_line(x,y,target.x,target.y,Wall,false,false)) return;
    var _dis=point_distance(x,y,target.x,target.y),_dir=point_direction(x,y,target.x,target.y)
    if (point_distance(x+hspeed,y+vspeed,target.x,target.y)<64) {
        motion_set(_dir,_dis/32*timescale); ntte_full_bite=1.2
    }
    else if (ntte_full_eye_laser<=0 && ntte_full_eye_laser_delay<=0 && hp<max_hp/2) {
        ntte_full_eye_laser=90+random(450); ntte_full_eye_laser_delay=60; right*=-1
        snd_play(sndGammaGutsKill,0.6+random(0.1),0.8); snd_play(sndHyperCrystalSearch,0.6+random(0.1),0.8)
    }
    else {
        ntte_full_spit=1.2; ntte_full_timers[2]=15; ntte_full_timers[1]+=15
        ntte_full_ammo=3+irandom(2*image_xscale); gunangle=_dir; snd_play(sndOasisHorn,0.9,2.4)
    }
}

// BEGIN NTTE OWNED PITSQUID EYE CHARGE FX
// Original active tetrench2514..2531 + PitSquidL3621..3630.
// The unrelated always-on particles at2590..2595 remain disabled.
function scrNTTEFullPitSquidEyeChargeFX(_x,_y,_delay) {
    if(random(_delay)<10*timescale) {
        if(random(7)<1) {
            var _fx=instance_create(_x+orandom(12),_y,PortalL)
            _fx.sprite_index=scrNTTERefSprite("PitSpark",irandom(4))
            if(random(2)<1)
                _fx.sprite_index=asset_get_index("sprPortalL"+string(irandom_range(1,5)))
        }
        else {
            var _fx=instance_create(_x+orandom(16),_y,PlasmaTrail)
            _fx.sprite_index=scrNTTERefSprite("QuasarBeamTrail")
            _fx.hspeed+=orandom(1.5)*timescale
            _fx.vspeed+=orandom(0.8)*timescale
        }
    }
}
// END NTTE OWNED PITSQUID EYE CHARGE FX

function scrNTTEFullPitSquidEyes() {
    var _target=noone,_distance=infinity,_goal=0
    with (Player) {
        var _d=point_distance(x,y,other.x,other.y)
        if (_d<_distance && !collision_line(x,y,other.x,other.y,Wall,false,false)) { _distance=_d; _target=id }
    }
    ntte_full_eye_dir+=ntte_full_eye_turn*right*timescale; ntte_full_eye_turn*=power(0.9,timescale)
    for(var _i=0;_i<array_length(ntte_full_eye);++_i) {
        var _eye=ntte_full_eye[_i],_dis=(24+ntte_full_eye_distance)*max(ntte_full_pit_height,0),
            _dir=image_angle+ntte_full_eye_dir+360*_i/array_length(ntte_full_eye)
        _eye.x=x+hspeed+lengthdir_x(_dis*image_xscale,_dir); _eye.y=y+vspeed+lengthdir_y(_dis*image_yscale,_dir)
        if (ntte_full_eye_laser<=0 && !instance_exists(_eye.laser)) {
            if (instance_exists(_target)) {
                var _look=point_direction(_eye.x,_eye.y,_target.x,_target.y)
                _eye.dir=_look+angle_difference(_eye.dir,_look)*power(0.7,timescale)
                var _goal_dis=clamp(point_distance(_eye.x,_eye.y,_target.x,_target.y)/6,0,5)
                _eye.distance=_goal_dis+(_eye.distance-_goal_dis)*power(0.7,timescale)
            }
            else _eye.dir+=sin(current_frame/20)*1.5*timescale
        }
        var _last_frame=sprite_get_number(scrNTTERefSprite("PitSquidEyelid"))-1
        if (_eye.blink || (ntte_full_eye_laser>0 && ntte_full_eye_laser_delay>0)) {
            _eye.frame+=image_speed*(instance_exists(_eye.laser) ? 0.5:1)
            if(ntte_full_eye_laser>0)
                scrNTTEFullPitSquidEyeChargeFX(_eye.x,_eye.y,ntte_full_eye_laser_delay)
            if (_eye.frame>=_last_frame) {
                _eye.frame=_last_frame
                if ((instance_exists(Player) || ntte_full_pit_height>=1) && (ntte_full_intro || ntte_full_pit_height<1)
                    && current_frame_active && random(4)<1) _eye.blink=false
            }
        }
        else {
            _eye.frame=max(_eye.frame-image_speed,0)
            if (ntte_full_eye_laser>0) {
                _eye.distance*=power(0.1,timescale)
                if (!instance_exists(_eye.laser)) {
                    var _laser=scr_projectile_create(_eye.x,_eye.y,NTTEFullQuasarBeam,_dir,0)
                    _laser.damage=6; _laser.ntte_full_bend_friction=0.2; _laser.ntte_full_scale_goal=0.8*image_xscale
                    _laser.ntte_full_follow=false; _laser.mask_index=mskSuperFlakBullet
                    _laser.image_xscale=_laser.ntte_full_scale_goal/2; _laser.image_yscale=_laser.image_xscale; _laser.depth=-3
                    _eye.laser=_laser
                }
                _eye.laser.ntte_full_shrink_delay=4
            }
            if (_eye.frame<=0 && random(instance_exists(_target) ? 150:100)<timescale) _eye.blink=true
        }
        if (instance_exists(_eye.laser)) {
            _goal=-4; _eye.laser.ntte_full_hold_x=_eye.x; _eye.laser.ntte_full_hold_y=_eye.y
            _eye.laser.ntte_full_direction_goal=_dir
        }
    }
    if (ntte_full_spit>0 || ntte_full_bite>0) _goal=8
    ntte_full_eye_distance+=(_goal-ntte_full_eye_distance)/5*timescale
}

function scrNTTEFullPitSquidStep() {
    x=ntte_full_x; y=ntte_full_y; xprevious=x; yprevious=y
    var _due=scrNTTEFullTrenchClock()
    if (_due[1]) scrNTTEFullPitSquidDecision()
    if (_due[2]) scrNTTEFullPitSquidAttack()
    if (_due[3]) scrNTTEFullPitSquidSparks()
    if (ntte_full_sink || ntte_full_rise_delay>0) {
        ntte_full_rise_delay-=timescale
        var _goal=instance_exists(Player) ? 0.5:0
        if (ntte_full_pit_height>_goal) {
            ntte_full_pit_height+=(_goal-ntte_full_pit_height)/(instance_exists(Player) ? 4:8)*timescale
            if (abs(_goal-ntte_full_pit_height)<0.05) ntte_full_pit_height=_goal
            for(var _i=0;_i<array_length(ntte_full_eye);++_i) ntte_full_eye[_i].blink=true
        }
    }
    else if (ntte_full_pit_height<0.5) {
        ntte_full_pit_height+=abs(sin(current_frame/30))*0.02*timescale
        if (ntte_full_bite<=0 && ntte_full_pit_height>0.3) ntte_full_bite=0.6
    }
    else if (ntte_full_pit_height<1) {
        if (ntte_full_bite<=0) ntte_full_bite=1
        else if ((1-ntte_full_bite)*sprite_get_number(ntte_full_bite_sprite)>=6) {
            ntte_full_pit_height+=0.1*timescale
            if (ntte_full_pit_height>=1) {
                ntte_full_pit_height=1; ntte_full_timers[1]=10+random(10); ntte_full_timers[2]=30+random(10); speed/=3
                ntte_full_x=x; ntte_full_y=y; scrNTTEFullPitSquidSmash(!ntte_full_intro,true)
                for(var _i=0;_i<array_length(ntte_full_eye);++_i) ntte_full_eye[_i].blink=true
                snd_play(sndOasisExplosion); scrNTTEFullTrenchShake(x,y,30)
                if (!ntte_full_intro) {
                    ntte_full_intro=true; scrNTTEFullBossIntro("PitSquid")
                    snd_play(sndBigDogIntro); snd_play(sndNothing2Taunt,0.7,0.8)
                }
            }
        }
    }
    else if (!ntte_full_can_intro) {
        ntte_full_timers[1]=3.746*30
        var _count=0,_squids=0
        with (enemy) if (team!=team_player && !instance_is(id,Van)) _count+=1
        with (NTTEFullPitSquid) _squids+=1
        if (_count<=_squids) {
            ntte_full_can_intro=true; GameCont.ntte_full_boss_music_key="PitSquid"
            with (MusCont) { alarm[2]=1; alarm[3]=-1 }
        }
    }
    if (ntte_full_eye_laser>0) speed=0
    else if (speed>0) {
        ntte_full_eye_turn+=speed/timescale/10*timescale; direction+=sin(current_frame/20)*timescale
        if (random(10/max(0.001,ntte_full_pit_height))<speed) instance_create(x+orandom(40),y+orandom(40),Bubble)
    }
    if (ntte_full_eye_laser_delay>0) {
        ntte_full_eye_laser_delay-=timescale
        if (ntte_full_eye_laser>0 && ntte_full_bite<=0 && ntte_full_eye_laser_delay<30) ntte_full_bite=1.2
    }
    if (ntte_full_eye_laser>0) {
        if (ntte_full_eye_laser_delay<=0) ntte_full_eye_laser-=timescale
        if (ntte_full_eye_laser>30) ntte_full_eye_turn+=(0.1-0.03*(image_xscale-1))*timescale
        else for(var _i=0;_i<array_length(ntte_full_eye);++_i) ntte_full_eye[_i].blink=true
        var _wall=instance_nearest(x-8,y-8,Wall)
        if (instance_exists(_wall)) motion_add(point_direction(_wall.x+8,_wall.y+8,x,y),0.5*timescale*timescale)
        if (ntte_full_eye_laser<=0 || !instance_exists(Player) || ntte_full_pit_height<1) {
            ntte_full_eye_laser=0; ntte_full_eye_laser_delay=random_range(30,150)
        }
    }
    scrNTTEFullPitSquidEyes()
    if (ntte_full_spit>0) {
        var _frame=(1-ntte_full_spit)*sprite_get_number(ntte_full_fire_sprite)
        if (_frame<6 || ntte_full_ammo<=0) ntte_full_spit-=image_speed/sprite_get_number(ntte_full_fire_sprite)
    }
    if (ntte_full_bite>0) {
        var _frame=(1-ntte_full_bite)*sprite_get_number(ntte_full_bite_sprite)
        if (_frame<6 || _frame>=8 || (ntte_full_pit_height>0.5 && (ntte_full_eye_laser<=0 || ntte_full_eye_laser_delay<=0)))
            ntte_full_bite-=image_speed/sprite_get_number(ntte_full_bite_sprite)
        if (_frame>=8 && _frame<9) {
            if (ntte_full_pit_height>0.5) {
                mask_index=ntte_full_mask
                with (hitme) if (team!=other.team && hp>0 && place_meeting(x,y,other.id)) {
                    var _v=id
                    with (other) if (scr_can_hit(_v,true)) scr_projectile_hit(_v,8)
                }
                mask_index=mskNone
            }
            if (_frame-image_speed<8) { snd_play(snd_mele,0.8+orandom(0.1),0.8); snd_play(sndOasisChest,0.8+orandom(0.1)); repeat(3) instance_create(x,y,Bubble) }
        }
    }
    if (ntte_full_taunt>0 && !instance_exists(Player)) {
        ntte_full_taunt-=timescale
        if (ntte_full_taunt<=0 && ntte_full_intro) {
            if (!ntte_full_sink) { ntte_full_sink=true; ntte_full_eye_turn-=8; snd_play(sndNothing2Hurt,0.6,0.4); snd_play(sndNothingHurtHigh,0.3,0.5) }
            snd_play(sndNothingGenerators,0.4,0.4)
        }
    }
    ntte_full_x=x; ntte_full_y=y; x=0; y=0
}

function scrNTTEFullPitSquidEndStep() {
    var _old_x=ntte_full_x,_old_y=ntte_full_y
    ntte_full_x+=hspeed; ntte_full_y+=vspeed
    if (ntte_full_pit_height>0.5) {
        mask_index=ntte_full_mask
        if (scrNTTEFullTrenchPitlessMeeting(ntte_full_x,ntte_full_y-16) && !scrNTTEFullTrenchPitlessMeeting(_old_x,_old_y-16)) {
            ntte_full_x=_old_x; ntte_full_y=_old_y
            if (scrNTTEFullTrenchPitlessMeeting(ntte_full_x+hspeed,ntte_full_y-16)) hspeed*=-1
            if (scrNTTEFullTrenchPitlessMeeting(ntte_full_x,ntte_full_y-16+vspeed)) vspeed*=-1
            speed*=0.8
        }
        mask_index=mskNone
    }
    x=0; y=0
}

function scrNTTEFullPitSquidHurt(_amount) {
    if (_amount<=0) return;
    if (hp<=max_hp/2 && hp+_amount>max_hp/2) {
        snd_play(snd_lowh,0.6); ntte_full_bite=1
        if (ntte_full_ammo<=0) ntte_full_timers[2]=max(ntte_full_timers[2],45+random(15))
    }
    ntte_full_last_hp=hp
}

function scrNTTEFullPitSquidDraw() {
    var _xs=image_xscale*max(ntte_full_pit_height,0),_ys=image_yscale*max(ntte_full_pit_height,0),
        _col=merge_color(c_black,image_blend,clamp(ntte_full_pit_height,0,1)*(ntte_full_intro ? 1:1/3)),
        _eyelid=scrNTTERefSprite("PitSquidEyelid")
    for(var _i=0;_i<array_length(ntte_full_eye);++_i) {
        var _eye=ntte_full_eye[_i],_dis=_eye.distance*max(ntte_full_pit_height,0)
        if (_eye.frame<sprite_get_number(_eyelid)-1) {
            draw_sprite_ext(scrNTTERefSprite("PitSquidCornea"),image_index,_eye.x,_eye.y,_xs,_ys,image_angle,_col,image_alpha)
            draw_sprite_ext(scrNTTERefSprite("PitSquidPupil"),image_index,
                _eye.x+lengthdir_x(_dis*image_xscale,_eye.dir),_eye.y+lengthdir_y(_dis*image_yscale,_eye.dir),_xs,_ys,image_angle,_col,image_alpha)
        }
        draw_sprite_ext(_eyelid,_eye.frame,_eye.x,_eye.y,_xs,_ys,image_angle,_col,image_alpha)
    }
    if (ntte_full_bite>0 && ntte_full_bite<=1)
        draw_sprite_ext(ntte_full_bite_sprite,(1-ntte_full_bite)*sprite_get_number(ntte_full_bite_sprite),ntte_full_x,ntte_full_y,_xs,_ys,image_angle,_col,image_alpha)
    else if (ntte_full_spit>0 && ntte_full_spit<=1)
        draw_sprite_ext(ntte_full_fire_sprite,(1-ntte_full_spit)*sprite_get_number(ntte_full_fire_sprite),ntte_full_x,ntte_full_y,_xs,_ys,image_angle,_col,image_alpha)
}

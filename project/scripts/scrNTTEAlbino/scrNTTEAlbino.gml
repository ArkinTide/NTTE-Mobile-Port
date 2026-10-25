// NTTE 2.062 tesewers Albino Gator, native enemy/projectile integration.
function scrNTTEAlbinoCreate() {
    max_hp=32; raddrop=7; size=2; meleedamage=0
    spr_idle=sprNTTEAlbinoGatorIdle; spr_walk=sprNTTEAlbinoGatorWalk
    spr_hurt=sprNTTEAlbinoGatorHurt; spr_dead=sprNTTEAlbinoGatorDead
    spr_weap=sprNTTEAlbinoGatorWeap; spr_shadow=shd24
    mask_index=mskBandit; sprite_index=spr_idle
    hitid=[spr_idle,"ALBINO GATOR"]
    walk=0; ntte_albino_timer=30; ntte_albino_charge=0
    ntte_albino_spirit=15+GameCont.hard; ntte_albino_spirit_ready=true
    ntte_albino_spirit_timer=10; ntte_albino_spirit_hurt=current_frame
    ntte_albino_halo=sprStrongSpiritRefill; ntte_albino_halo_frame=0
    ntte_albino_aim=0; ntte_albino_grenades=2; ntte_albino_saw_target=false
    ntte_albino_wave=0; ntte_albino_shots=0; ntte_albino_throws=0
    ntte_gator_den=false; ntte_gator_awake=true; depth=-2
}

function scrNTTEAlbinoAfterCreate() {
    gunangle=random(360); direction=gunangle
    snd_hurt=sndBuffGatorHit; snd_dead=sndBuffGatorDie
    alarm[1]=-1; alarm[2]=-1
}

function scrNTTEAlbinoDecision() {
    scrTarget()
    var _exists=instance_exists(target),_seen=_exists && scrTargetIsVisible(target),
        _distance=_exists ? point_distance(x,y,target.x,target.y):infinity,
        _angle=_exists ? point_direction(x,y,target.x,target.y):gunangle
    ntte_albino_timer=20+random(30)
    if (ntte_albino_charge>0) {
        ntte_albino_timer=1
        --ntte_albino_charge
        if (_seen) scrNTTESewerLook(gunangle+clamp(angle_difference(_angle,gunangle),-2.4*ntte_albino_aim,2.4*ntte_albino_aim))
        if (ntte_albino_charge<=0) {
            ntte_albino_timer=30
            scr_projectile_create(x,y,NTTEAlbinoBolt,gunangle,16)
            motion_set(gunangle+180,3*timescale)
            wkick=8; ++ntte_albino_shots
            snd_play(sndHeavyCrossbow,random_range(1.2,1.4))
            snd_play(sndTurretFire,random_range(0.8,1))
        }
    }
    else if (_exists) {
        if (_seen) {
            scrNTTESewerLook(_angle)
            ntte_albino_saw_target=true
            if (random(3)<2) {
                ntte_albino_timer=1; ntte_albino_charge=30
                snd_play(sndCrossReload,random_range(0.8,1))
                snd_play(sndSniperTarget,random_range(1.4,1.6))
            }
            else scrNTTESewerWalk(gunangle+orandom(15),random_range(40,60))
        }
        else {
            var _own=0
            with (projectile) if (creator==other.id && team==other.team) _own+=1
            if (ntte_albino_grenades>0 && ntte_albino_saw_target && _distance<160 && _own==0 && random(2)<1) {
                --ntte_albino_grenades; ++ntte_albino_throws; ntte_albino_timer+=30
                if (abs(angle_difference(_angle,gunangle))>60) scrNTTESewerLook(_angle+orandom(30))
                scr_projectile_create(x,y,NTTEAlbinoGrenade,gunangle,random_range(8,12))
                motion_add(gunangle+180,2*timescale)
                snd_play(sndAssassinAttack,random_range(1,1.2))
            }
            else {
                scrNTTESewerWalk(gunangle+orandom(30),random_range(20,60))
                scrNTTESewerLook(direction)
            }
        }
    }
}

function scrNTTEAlbinoStep() {
    if (lockstep_stop || hp<=0) return;
    if (scrNTTEFullValue(id,"ntte_full_den_hold",false)) return;
    if (ntte_gator_den && !ntte_gator_awake) {
        var _p=instance_nearest(x,y,Player)
        if (hp<max_hp || ntte_albino_spirit<15+GameCont.hard || (instance_exists(_p) && point_distance(x,y,_p.x,_p.y)<=80)) scrNTTESewerWakeDen()
        else { speed=0; return; }
    }
    if (walk>0) { walk-=timescale; motion_add(direction,1.2*timescale*timescale) }
    speed=min(speed,3.6*timescale)
    ntte_albino_wave+=timescale
    ntte_albino_halo_frame+=0.4*timescale
    if (sprite_exists(ntte_albino_halo) && ntte_albino_halo_frame>=sprite_get_number(ntte_albino_halo)) {
        if (ntte_albino_halo==sprStrongSpirit) ntte_albino_halo=-1
        else ntte_albino_halo_frame=sprite_get_number(ntte_albino_halo)-1
    }
    ntte_albino_aim=approach(ntte_albino_aim,ntte_albino_charge>0 ? 1:0,0.1*timescale)
    ntte_albino_spirit_timer-=timescale
    if (ntte_albino_spirit_timer<=0) {
        ntte_albino_spirit_timer+=10
        if (ntte_albino_spirit<15) {
            ++ntte_albino_spirit
            if (ntte_albino_spirit>=15 && !ntte_albino_spirit_ready) {
                ntte_albino_spirit_ready=true
                ntte_albino_spirit=15+GameCont.hard
                ntte_albino_halo=sprStrongSpiritRefill; ntte_albino_halo_frame=0
                snd_play_hit(sndStrongSpiritGain,0.2)
            }
        }
    }
    if (place_meeting(x+hspeed,y+vspeed,Wall)) {
        if (place_meeting(x+hspeed,y,Wall)) hspeed*=-0.5
        if (place_meeting(x,y+vspeed,Wall)) vspeed*=-0.5
        if (ntte_albino_charge<=0) scrNTTESewerLook(angle_lerp(gunangle,direction,2/3))
    }
    ntte_albino_timer-=timescale
    if (ntte_albino_timer<=0) scrNTTEAlbinoDecision()
}

function scrNTTEAlbinoInterceptHit(_victim,_amount) {
    if (!instance_is(_victim,NTTEAlbinoGator)) return false
    with (_victim) {
        ntte_albino_spirit=max(0,ntte_albino_spirit-_amount)
        nexthurt=current_frame+6
        if (ntte_gator_den && !ntte_gator_awake) scrNTTESewerWakeDen()
        ntte_gator_awake=true
        if (current_frame<ntte_albino_spirit_hurt) return true
        if (!ntte_albino_spirit_ready) return false
        if (ntte_albino_spirit<=0) {
            ntte_albino_spirit_ready=false; ntte_albino_spirit_hurt=current_frame+6
            ntte_albino_halo=sprStrongSpirit; ntte_albino_halo_frame=0
            snd_play_hit(sndStrongSpiritLost,0.2)
            scrNTTEFullHurtParitySound(id,sndSuperFireballerFire,1,1,true)
        }
        else {
            snd_play_hit(sndCursedPickup,0.2)
            scrNTTEFullHurtParitySound(id,sndFireballerFire,1,1,true)
        }
        var _hurt_fx=instance_create(x+5*right,y-5,ThrowHit)
        _hurt_fx.depth=depth-1
        return true
    }
    return false
}

function scrNTTEAlbinoDraw() {
    if (lockstep_stop) return;
    if (ntte_albino_charge>0) {
        var _len=500,_ex=x+lengthdir_x(_len,gunangle),_ey=y+lengthdir_y(_len,gunangle)
        for(var _i=8;_i<=_len;_i+=8) {
            var _tx=x+lengthdir_x(_i,gunangle),_ty=y+lengthdir_y(_i,gunangle)
            if (position_meeting(_tx,_ty,Wall)) { _ex=_tx; _ey=_ty; break }
        }
        draw_set_alpha(ntte_albino_aim*0.8); draw_set_color(make_color_rgb(252,56,0))
        draw_line(x,y,_ex,_ey)
        draw_set_alpha(1); draw_set_color(c_white)
    }
    if (gunangle>180) draw_sprite_ext(sprite_index,image_index,x,y,right,1,0,image_blend,image_alpha)
    draw_sprite_ext(spr_weap,0,x+lengthdir_x(-wkick,gunangle),y+lengthdir_y(-wkick,gunangle),1,right,gunangle,image_blend,image_alpha)
    if (gunangle<=180) draw_sprite_ext(sprite_index,image_index,x,y,right,1,0,image_blend,image_alpha)
    if (sprite_exists(ntte_albino_halo)) draw_sprite(ntte_albino_halo,ntte_albino_halo_frame,x,y-3+sin(ntte_albino_wave*0.1))
}

function scrNTTEAlbinoBoltCreate() {
    typ=1; damage=6; knockback_speed=12*timescale
    sprite_index=sprNTTEAlbinoBolt; mask_index=mskBolt
    image_speed=0; spr_fade=-1; depth=-2
    target=noone; small=false; ntte_albino_stuck=false
    ntte_albino_fuse=-1; ntte_albino_ammo=0
    ntte_albino_age=0; ntte_albino_life=600
}

function scrNTTEAlbinoSplinterSetup() {
    small=true; damage=3; knockback_speed=6*timescale
    sprite_index=sprNTTEAlbinoSplinter
}

function scrNTTEAlbinoBoltStep() {
    if (lockstep_stop) return;
    ntte_albino_age+=timescale
    if (ntte_albino_age>=ntte_albino_life) { instance_destroy(); return; }
    if (ntte_albino_stuck) {
        speed=0; typ=0
        if (instance_exists(target) && target.hp>0) {
            x=target.x+lengthdir_x(12,image_angle+180)
            y=target.y+lengthdir_y(12,image_angle+180)
        }
        if (ntte_albino_fuse<0) ntte_albino_fuse=20
        ntte_albino_fuse-=timescale
        while (ntte_albino_fuse<=0) {
            if (small) { instance_destroy(); return; }
            if (ntte_albino_ammo<=0) {
                ntte_albino_ammo=4; ntte_albino_fuse+=30
                snd_play(sndSniperTarget,random_range(0.8,1))
            }
            else {
                visible=false
                var _d=90*(1-ntte_albino_ammo/4)
                for(var _side=-sign(_d);_side<=sign(_d);_side+=2) {
                    var _p=scr_projectile_create(x,y,NTTEAlbinoBolt,direction+180+_d*_side,15)
                    with (_p) scrNTTEAlbinoSplinterSetup()
                }
                --ntte_albino_ammo; ntte_albino_fuse+=1
                snd_play(ntte_albino_ammo mod 2 ? sndTurretFire:sndSplinterPistol)
                if (ntte_albino_ammo<=0) { instance_destroy(); return; }
            }
        }
    }
    else if (current_frame_active) {
        var _trail=instance_create(x,y,BoltTrail)
        _trail.image_angle=direction
        _trail.image_xscale=max(1,point_distance(x,y,xprevious,yprevious))
        _trail.image_yscale=small ? 0.6:1.5
        _trail.image_blend=team==team_player ? c_yellow:make_color_rgb(250,56,0)
    }
}

function scrNTTEAlbinoBoltHit(_victim) {
    if (lockstep_stop || ntte_albino_stuck || speed<=0 || !scr_can_hit(_victim,false)) return;
    if (scr_projectile_hit(_victim,damage,knockback_speed)) {
        if (instance_exists(_victim) && _victim.hp>0) { target=_victim; ntte_albino_stuck=true; speed=0 }
        repeat(4) instance_create(x,y,Smoke)
    }
}

function scrNTTEAlbinoBoltWall() {
    if (lockstep_stop || ntte_albino_stuck) return;
    speed=0; ntte_albino_stuck=true
    instance_create(x,y,Smoke); snd_play_hit(sndBoltHitWall,0.2)
}

function scrNTTEAlbinoGrenadeCreate() {
    damage=4; knockback_speed=4*timescale
    sprite_index=sprNTTEAlbinoGrenade; mask_index=mskBigRad
    image_speed=0.4*timescale; spr_fade=-1
    alarm[0]=-1; alarm[1]=-1; alarm[2]=-1
    ntte_albino_age=0; ntte_albino_angle=round(random(360)/45)*45
    ntte_albino_turn=orandom(1); ntte_albino_exploded=false
}

function scrNTTEAlbinoGrenadeStep() {
    if (lockstep_stop) return;
    ntte_albino_age+=timescale
    if (ntte_albino_age>=6) friction=0.4*timescale*timescale
    if (ntte_albino_age>=50) image_blend=(floor(ntte_albino_age) mod 4<2) ? c_white:c_black
    if (ntte_albino_age>=80) instance_destroy()
}

function scrNTTEAlbinoGrenadeDeath() {
    if (ntte_albino_exploded || !instance_exists(GameCont)) return;
    ntte_albino_exploded=true
    var _ex=scr_projectile_create(x,y,Explosion)
    _ex.team=team_none; _ex.mask_index=mskPopoExplo
    _ex.image_xscale=0.9; _ex.image_yscale=0.9
    for(var _i=0;_i<4;++_i) {
        var _d=ntte_albino_angle+_i*90,_p=scr_projectile_create(x+lengthdir_x(16,_d),y+lengthdir_y(16,_d),NTTEBeam,_d,0)
        _p.detached=true; _p.scale_goal=0.8; _p.beam_scale=0.8; _p.life=12
        _p.ntte_albino_turn=ntte_albino_turn
    }
    snd_play(sndExplosionL,random_range(1.8,2))
}

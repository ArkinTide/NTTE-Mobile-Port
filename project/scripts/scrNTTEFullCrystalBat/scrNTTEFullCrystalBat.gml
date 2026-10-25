// NTTE 2.062 objects/tecaves.mod.gml:113..359,2179..2204.
// This enemy has its own swept motion because its cursed dash can cross Wall.
// Native velocity is reserved for external impulses and absorbed on the next Step.
function scrNTTEFullCrystalBatCreate(_curse) {
    ntte_crystal_bat=true
    curse=_curse
    var _base=_curse ? "InvCrystalBat":"CrystalBat"
    spr_idle=scrNTTERefSprite(_base+"Idle"); spr_walk=spr_idle
    spr_hurt=scrNTTERefSprite(_base+"Hurt"); spr_dead=scrNTTERefSprite(_base+"Dead")
    spr_chrg=scrNTTERefSprite(_base+"Tell"); spr_fire=scrNTTERefSprite(_base+"Dash")
    mask_index=mskFreak; max_hp=18; raddrop=8; size=1; meleedamage=5
    sprite_index=spr_idle; depth=-2
    hitid=[spr_idle,_curse ? "CURSED CRYSTAL BAT":"CRYSTAL BAT"]
    walk=0; walkspeed=1.2; maxspeed=2.4; dash=false
    ntte_wander_left=90; ntte_target_left=90; ntte_tell_left=-1
    ntte_contact_left=-1; ntte_motion_speed=0; ntte_motion_direction=random(360)
    ntte_bat_can_fly=false; ntte_crystal_dash_count=0; ntte_crystal_contact_count=0
}

function scrNTTEFullCrystalBatAfterCreate() {
    spr_shadow=shd24; spr_shadow_y=4
    canmelee=false; friction=0
    gunangle=ntte_motion_direction; direction=gunangle
    snd_hurt=sndSpiderHurt; snd_dead=sndSpiderDead; snd_mele=sndSpiderMelee
    if (curse) {
        snd_hurt=choose(sndBanditHit,sndBigMaggotHit,sndScorpionHit,sndRatHit,sndGatorHit,sndRavenHit,sndSalamanderHurt,sndSniperHit)
        snd_dead=choose(sndBanditDie,sndBigMaggotDie,sndScorpionDie,sndRatDie,sndGatorDie,sndRavenDie,sndSalamanderDead)
    }
    alarm[1]=-1; alarm[2]=-1; alarm[3]=-1; alarm[11]=-1
}

function scrNTTEFullCrystalBatMotion(_dir,_spd) {
    ntte_motion_direction=_dir
    ntte_motion_speed=_spd
}

function scrNTTEFullCrystalBatLook(_dir) {
    gunangle=_dir
    if (abs(lengthdir_x(1,_dir))>0.001) right=sign(lengthdir_x(1,_dir))
}

function scrNTTEFullCrystalBatWalk(_dir,_time) {
    ntte_motion_direction=_dir; walk=_time
    ntte_motion_speed=max(ntte_motion_speed,0.6)
}

function scrNTTEFullCrystalBatWander() {
    ntte_wander_left=40+random(20)
    scrNTTEFullCrystalBatLook(round(random(360)/90)*90)
    scrNTTEFullCrystalBatWalk(gunangle,random_range(30,60))
}

function scrNTTEFullCrystalBatCheckDash() {
    ntte_target_left=10
    scrTarget()
    if (!instance_exists(target)) return false
    if ((!curse && collision_line(x,y,target.x,target.y,Wall,false,false))
        || point_distance(x,y,target.x,target.y)>=160) return false
    if (!place_meeting(x,target.y,target) && !place_meeting(target.x,y,target)) return false
    ntte_tell_left=7; sprite_index=spr_chrg
    scrNTTEFullCrystalBatLook(round(point_direction(x,y,target.x,target.y)/90)*90)
    scrNTTEFullCrystalBatMotion(gunangle+180+orandom(30),maxspeed)
    // The original recoil stops at solid geometry before the seven-tick tell.
    scrNTTEFullCrystalBatSweep(0,true)
    snd_play_hit(sndLaserCrystalHit,0.2)
    snd_play_hit(sndLuckyShotProc,0.2)
    snd_play(sndMaggotBite,1+random(0.2),0.8)
    ntte_wander_left=-1; ntte_target_left=-1; walk=0
    return true
}

function scrNTTEFullCrystalBatDash() {
    dash=true; sprite_index=spr_fire
    scrNTTEFullCrystalBatWalk(gunangle,60)
    ++ntte_crystal_dash_count
    snd_play_hit(sndLaserCrystalDeath,0.2)
    snd_play(sndBigMaggotBite,1.2+random(0.2),0.8)
}

function scrNTTEFullCrystalBatCanCrossWall() {
    if (!curse || !dash) return false
    var _allowed=true
    with (Wall) {
        if (place_meeting(x,y,other.id)
            && collision_rectangle(bbox_left-1,bbox_top-1,bbox_right+1,bbox_bottom+1,TopSmall,false,false)) {
            _allowed=false
            break
        }
    }
    return _allowed
}

// Resolve one physical frame in <=1-pixel increments. The parent native wall
// collision must not rebound a cursed bat that is intentionally inside a wall.
function scrNTTEFullCrystalBatSweep(_dt,_recoil=false) {
    if (ntte_motion_speed<=0) return false
    var _distance=ntte_motion_speed*(_recoil ? 1:_dt)
    var _parts=max(1,ceil(_distance)),_dx=lengthdir_x(_distance/_parts,ntte_motion_direction),_dy=lengthdir_y(_distance/_parts,ntte_motion_direction)
    for (var _i=0;_i<_parts;++_i) {
        var _lastx=x,_lasty=y
        x+=_dx; y+=_dy
        if (!place_meeting(x,y,Wall)) continue
        if (!_recoil && scrNTTEFullCrystalBatCanCrossWall()) {
            ntte_bat_can_fly=true
            continue
        }
        x=_lastx; y=_lasty
        if (_recoil) return true
        var _vx=lengthdir_x(ntte_motion_speed,ntte_motion_direction),_vy=lengthdir_y(ntte_motion_speed,ntte_motion_direction)
        if (place_meeting(x+_dx,y,Wall)) _vx=-_vx
        if (place_meeting(x,y+_dy,Wall)) _vy=-_vy
        ntte_motion_direction=point_direction(0,0,_vx,_vy)
        scrNTTEFullCrystalBatLook(round(ntte_motion_direction/90)*90)
        if (dash) {
            walk=0
            scrNTTEFullCrystalBatLook(ntte_motion_direction+180)
            instance_create(x,y,Smoke)
            snd_play(sndLaserCrystalHit,1+orandom(0.1))
            snd_play(sndBigDogWalk,1+orandom(0.1),0.1)
            sleep(24)
        }
        return true
    }
    return false
}

function scrNTTEFullCrystalBatFinishDash() {
    // A cursed bat continues for one more logical tick while embedded. It must
    // never become solid again until it has exited the wall.
    if (curse && place_meeting(x,y,Wall)) {
        ntte_tell_left=1
        return false
    }
    dash=false; ntte_wander_left=45; ntte_target_left=45
    sprite_index=spr_hurt; image_index=2; image_angle=0
    canmelee=false; ntte_contact_left=-1; ntte_bat_can_fly=false
    return true
}

function scrNTTEFullCrystalBatStep() {
    if (lockstep_stop) return;
    if (hp<=0) { instance_destroy(); return }
    // Damage handlers use native motion_add; fold their impulses into the
    // original logical velocity without letting the engine move twice.
    if (speed>0) {
        var _vx=lengthdir_x(ntte_motion_speed,ntte_motion_direction)+hspeed/timescale
        var _vy=lengthdir_y(ntte_motion_speed,ntte_motion_direction)+vspeed/timescale
        ntte_motion_speed=point_distance(0,0,_vx,_vy)
        ntte_motion_direction=point_direction(0,0,_vx,_vy)
    }
    speed=0; friction=0; image_speed=0.4*timescale
    ntte_contact_left-=timescale
    if (ntte_wander_left>0) {
        ntte_wander_left-=timescale
        if (ntte_wander_left<=0) scrNTTEFullCrystalBatWander()
    }
    if (ntte_target_left>0) {
        ntte_target_left-=timescale
        if (ntte_target_left<=0) scrNTTEFullCrystalBatCheckDash()
    }
    if (ntte_tell_left>0) {
        ntte_tell_left-=timescale
        if (ntte_tell_left<=0) scrNTTEFullCrystalBatDash()
    }
    if (sprite_index!=spr_chrg && sprite_index!=spr_fire
        && (sprite_index!=spr_hurt || image_index+image_speed>=image_number)) {
        sprite_index=ntte_motion_speed>0 ? spr_walk:spr_idle
    }
    if (walk>0) {
        walk-=timescale
        var _add=walkspeed+2*dash
        var _vx=lengthdir_x(ntte_motion_speed,ntte_motion_direction)+lengthdir_x(_add*timescale,gunangle)
        var _vy=lengthdir_y(ntte_motion_speed,ntte_motion_direction)+lengthdir_y(_add*timescale,gunangle)
        ntte_motion_direction=point_direction(0,0,_vx,_vy)
        ntte_motion_speed=max(_add,point_distance(0,0,_vx,_vy))
        if (dash) {
            image_angle=ntte_motion_direction-90
            canmelee=ntte_contact_left<0
            if (random(3)<timescale) {
                var _fx=instance_create(x,y,curse ? Smoke:Dust)
                /* NTTE NATIVE EFFECT LIFETIME cursed-bat-smoke */ if(instance_exists(_fx)) {if (curse && position_meeting(_fx.x,_fx.y,Wall)) { _fx.y-=8; _fx.depth=-7 } }
            }
        }
    }
    ntte_motion_speed=min(ntte_motion_speed,maxspeed+5*dash)
    scrNTTEFullCrystalBatSweep(timescale)
    if (walk<=0 && dash) scrNTTEFullCrystalBatFinishDash()
    ntte_motion_speed=max(0,ntte_motion_speed-0.6*timescale)
    if (curse && random(3)<timescale) instance_create(x+orandom(8),y+orandom(6),Curse)
}

function scrNTTEFullCrystalBatContact(_who) {
    if (lockstep_stop || !dash || ntte_contact_left>=0 || !scr_can_hit(_who)) return false
    if (scr_hit(_who,meleedamage,hitid)) {
        with (_who) motion_add(point_direction(other.x,other.y,x,y),4*timescale)
        snd_play_hit(snd_mele)
        ntte_contact_left=30; canmelee=false; ++ntte_crystal_contact_count
        return true
    }
    return false
}

function scrNTTEFullCrystalBatDraw() {
    draw_sprite_ext(sprite_index,image_index,x,y,image_xscale*right,image_yscale,image_angle,image_blend,image_alpha)
}

// Call before the generic hit handler changes sprite_index. This function
// performs only damage presentation; native projectile knockback still follows.
function scrNTTEFullWorldInterceptHit(_who,_amount) {
    if (!instance_exists(_who)) return false
    if (instance_is(_who,NTTEFullBoneRaven)) with (_who) scrNTTEFullBoneRavenBeforeHurt()
    if (instance_is(_who,NTTEFullBigMaggotSpawn)) {
        var _handled=false
        with (_who) _handled=scrNTTEFullBigMaggotSpawnHurt(_amount)
        return _handled
    }
    if (!variable_instance_exists(_who,"ntte_crystal_bat") && !variable_instance_exists(_who,"ntte_full_puffer")) return false
    with (_who) {
        hp-=_amount
        nexthurt=current_frame+6
        snd_play_hit(snd_hurt,0.3)
        if (sprite_index!=spr_chrg && sprite_index!=spr_fire) { sprite_index=spr_hurt; image_index=0 }
    }
    return true
}

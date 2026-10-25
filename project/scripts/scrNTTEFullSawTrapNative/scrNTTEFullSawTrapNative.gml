// tescrapyard1718..1986. CustomHitme hazard, deliberately outside enemy:
// its survival cannot prevent a cleared level's portal.
function scrNTTEFullSawTrapCreate() {
    spr_idle=scrNTTERefSprite("SawTrap");spr_walk=spr_idle;spr_hurt=scrNTTERefSprite("SawTrapHurt")
    sprite_index=spr_idle;spr_shadow=mskNone;spr_shadow_y=6
    hitid=[spr_idle,"SAWBLADE TRAP"];image_speed=0.4*timescale;depth=1
    snd_hurt=sndHitMetal;snd_dead=sndHydrantBreak;snd_mele=sndDiscHit;loop_snd=-1
    mask_index=mskShield;friction=0.2*timescale*timescale;max_hp=30;hp=max_hp
    meleedamage=6;canmelee=true;raddrop=0;size=3;team=team_enemy
    walled=false;side=choose(-1,1);maxspeed=3;spd=0;dir=random(360)
    active=false;sawtrap_hit=false;ntte_saw_wait=random_range(30,60)
    var _wall=scrNTTEFullWorldNearestRectBBox(x,y,x,y,Wall)
    if(instance_exists(_wall)) dir=point_direction(x,y,(_wall.bbox_left+_wall.bbox_right)/2,(_wall.bbox_top+_wall.bbox_bottom)/2)
}
function scrNTTEFullSawTrapCleanup() {
    if(loop_snd>=0) audio_stop_sound(loop_snd)
    loop_snd=-1
}
function scrNTTEFullSawTrapHurt(_target,_damage,_direction,_force,_attacker) {
    with(_target) {
        hp-=_damage;nexthurt=current_frame+6;snd_play_hit(snd_hurt,0.3)
        sprite_index=spr_hurt;image_index=0
        if(active) spd/=2
        else { spd=_force/4;dir=_direction }
    }
    return true
}
function scrNTTEFullSawTrapMove() {
    speed=0
    if(instance_exists(Portal)) active=false
    spd+=(active*maxspeed-spd)*0.2*timescale
    var _sideDir=dir+90*side,
        _walled=collision_circle(x+lengthdir_x(8,_sideDir),y+lengthdir_y(8,_sideDir),1,Wall,false,false)
    if(!_walled && walled) dir+=90*side
    walled=_walled
    var _length=spd*timescale,_direction=dir
    if(!collision_circle(x+lengthdir_x(_length,_direction),y+lengthdir_y(_length,_direction),1,Wall,false,false)) {
        x=round(x+lengthdir_x(_length,_direction));y=round(y+lengthdir_y(_length,_direction))
    }
    else dir-=90*side
    dir=(round(dir/90)*90+360) mod 360
    if(sprite_index==spr_hurt && image_index+image_speed>=image_number) sprite_index=spr_idle
    image_angle+=4*spd*side*timescale
    // Only initialized attached bolts carry target. Independent harpoon-rope
    // controllers are outside this family and must never be treated as bolts.
    var _saw=id,_depth=depth
    with(BoltStick) if(variable_instance_exists(id,"target") && target==_saw && depth<_depth) depth=_depth
}
function scrNTTEFullSawTrapFX() {
    if(spd>1 && scrNTTEFullPortalPointSeen(x,y,-1)) {
        if(random(2)<timescale) {
            var _length=random(12),_direction=dir,_debris=walled && chance(1,30),
                _x=x+lengthdir_x(_length,_direction),_y=y+lengthdir_y(_length,_direction)-2
            instance_create(_x,_y,_debris ? Debris:Dust)
            if(_debris) { snd_play(sndWallBreak,2,0.2);scrNTTEFullTrenchShake(x,y,random_range(2,6),true) }
        }
        if(walled) {
            var _length=random_range(12,16),_direction=dir,
                _x=x+lengthdir_x(_length,_direction)+orandom(2),_y=y+lengthdir_y(_length,_direction)-random(2)
            if(random(3)<2*timescale) {
                var _spark=instance_create(_x,_y,BulletHit)
                with(_spark) {
                    sprite_index=choose(sprGroundFlameDisappear,sprGroundFlameBigDisappear)
                    image_angle=_direction-random_range(15,60)*other.side
                    image_yscale=-random_range(1,1.5)*other.side
                    if(!place_meeting(x,y,Wall)) instance_destroy()
                }
            }
            if(random(4)<timescale) {
                var _spark=instance_create(_x+orandom(3),_y+orandom(3),NTTEFullSweat)
                with(_spark) { motion_set(_direction-random_range(45,90)*other.side,random(2)*timescale);image_blend=make_color_rgb(255,222,56) }
            }
        }
    }
    var _goal=spd/maxspeed
    if(_goal>0 && scrNTTEFullPortalPointSeen(x,y,0)) {
        if(!audio_is_playing(loop_snd)) { loop_snd=audio_play_sound(scrNTTERefSound("SawTrap"),0,true);if(loop_snd>=0) audio_sound_gain(loop_snd,0,0) }
    }
    else _goal=0
    var _gain=loop_snd>=0 ? audio_sound_get_gain(loop_snd):0
    if(loop_snd>=0 && (_gain>0 || _goal>0)) {
        audio_sound_pitch(loop_snd,(1+0.05*sin(current_frame/8))*spd/maxspeed)
        audio_sound_gain(loop_snd,_gain+0.1*(_goal-_gain)*timescale,0)
    }
    else if(loop_snd>=0) audio_stop_sound(loop_snd)
}
function scrNTTEFullSawTrapContact() {
    var _hit=false,_scale=0.55
    image_xscale*=_scale;image_yscale*=_scale
    var _near=scrNTTEFullRectInstances(bbox_left,bbox_top,bbox_right-1,bbox_bottom-1,hitme)
    for(var _i=0;_i<array_length(_near);++_i) {
        var _victim=_near[_i]
        if(_victim==id || !place_meeting(x,y,_victim) || collision_line(x,y,_victim.x,_victim.y,Wall,false,false)) continue
        if(!instance_is(_victim,prop) || _victim.size<=1) {
            if(!instance_is(_victim,prop) && (_victim.size<size || instance_is(_victim,Player)))
                with(_victim) motion_add(point_direction(other.x,other.y,x,y),0.6*timescale*timescale)
            if(active && canmelee && scrNTTEFullSawTrapCanMelee(_victim)) {
                scrNTTEFullNativeProjectileHitNP(_victim,meleedamage,4,40)
                scrNTTEFullCoastSoundAt(x,y,snd_mele,0.7+random(0.2),1)
            }
        }
        if(walled && instance_is(_victim,NTTEFullSawTrap)) with(_victim) {
            if(active && side!=other.side && walled) {
                _hit=true
                if(!sawtrap_hit || random(30)<timescale) {
                    scrNTTEFullCoastSoundAt(x,y,sndDiscBounce,0.6+random(0.2),0.8)
                    var _fx=instance_create(x,y,MeleeHitWall)
                    with(_fx) { motion_add(other.dir-random(120*other.side),random(1)*timescale);image_angle=direction+180 }
                    spd=0
                }
            }
        }
    }
    image_xscale/=_scale;image_yscale/=_scale;sawtrap_hit=_hit
}
function scrNTTEFullSawTrapCanMelee(_target) {
    // Original9940 scrMeleeCanHit checks opposite team and every target's
    // six-frame invulnerability, without checking HP (unlike EnemyCanHit).
    return instance_exists(_target) && _target.team!=team && _target.nexthurt<=current_frame
}
function scrNTTEFullSawTrapStep() {
    if(lockstep_stop) return;
    if(ntte_saw_wait>0) {
        ntte_saw_wait-=timescale
        if(ntte_saw_wait>0) return;
        active=true
    }
    scrNTTEFullSawTrapMove();scrNTTEFullSawTrapFX();scrNTTEFullSawTrapContact()
    if(hp<=0 || place_meeting(x,y,PortalShock)) instance_destroy()
}
function scrNTTEFullSawTrapDeath() {
    var _explo=scr_projectile_create(x,y,Explosion);_explo.team=-1
    repeat(3) { _explo=scr_projectile_create(x+orandom(6),y+orandom(6),SmallExplosion);_explo.team=-1 }
    repeat(3) instance_create(x+orandom(16),y+orandom(16),GroundFlame)
    repeat(3+irandom(3)) { var _piece=instance_create(x,y,Debris);_piece.sprite_index=scrNTTERefSprite("SawTrapDebris") }
    scrNTTEFullCoastSoundAt(x,y,sndExplosion,1+orandom(0.1),3)
    scrNTTEFullCoastSoundAt(x,y,snd_dead,1+orandom(0.2),3)
    scrNTTEFullWorldPickupDrop(50,0)
}

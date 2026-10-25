// NTTE 2.062 TeslaCoil, shared with bat tether (weapon display name VAMPIRE).
function scrNTTECoilOriginalCreate() {
    age=0
    life=random_range(8,16)*(1+0.5*scr_skill_get(mut_laser_brain))
    primary=true
    vampire=false
    target=noone
    target_x=x; target_y=y
    initialized=false
    range=96
    creator_offx=17
    creator_offy=2
    wave=random(960)
    typ=0; damage=14
    spr_fade=-1
    sprite_index=sprLightningBall
    image_speed=random_range(0.3,0.5)*timescale
    image_xscale=0.4; image_yscale=0.4
    mask_index=mskNone
    arc_points=[]
    arc_visible=false
    hit_count=0
}

function scrNTTECoilFollow() {
    var _d=creator.gunangle,_off=creator_offx-(primary ? creator.wkick:creator.bwkick)/3,
        _side=creator_offy*creator.right
    x=creator.x+creator.hspeed+lengthdir_x(_off,_d)+lengthdir_x(_side,_d-90)
    y=creator.y+creator.vspeed+lengthdir_y(_off,_d)+lengthdir_y(_side,_d-90)-(primary ? 0:4)
}

function scrNTTECoilTarget() {
    var _candidates=[],_priority=-infinity
    with (hitme) {
        if (hp<=0 || team==other.team || mask_index==mskNone) continue
        if (distance_to_point(other.x,other.y)>=other.range) continue
        if (collision_line(x,y,other.x,other.y,Wall,false,false)!=noone) continue
        // IDPD first, then enemies, then props. Friendly units are never targets.
        if (team>_priority) { _priority=team; _candidates=[] }
        if (team==_priority) array_push(_candidates,id)
    }
    if (array_length(_candidates)>0) {
        target=_candidates[irandom(array_length(_candidates)-1)]
        target_x=target.x; target_y=target.y
        life*=1.5
    }
    else {
        var _dist=range*random_range(0.2,0.8),_dir=random(360)
        do {
            target_x=x+lengthdir_x(_dist,_dir)
            target_y=y+lengthdir_y(_dist,_dir)
            _dist-=4
        } until (_dist<12 || collision_line(x,y,target_x,target_y,Wall,false,false)==noone)
    }
}

function scrNTTECoilArc() {
    arc_points=[]
    arc_visible=false
    if ((!instance_exists(target) && point_distance(x,y,target_x,target_y)>=range+32)
        || collision_line(x,y,target_x,target_y,Wall,false,false)!=noone) return;
    var _dist=point_distance(x,y,target_x,target_y),_dir=point_direction(x,y,target_x,target_y),
        _wave=variable_instance_exists(creator,"wave") ? creator.wave:wave,
        _arc=power(_dist,0.6)*sin(_wave/240*2*pi)+4*cos(_wave/960*2*pi),
        _bend=4*sqrt(abs(_arc))*sign(_arc),_segments=max(2,ceil(_dist/10))
    for(var _i=0;_i<=_segments;++_i) {
        var _t=_i/_segments,_off=_bend*4*_t*(1-_t)
        array_push(arc_points,[lerp(x,target_x,_t)+lengthdir_x(_off,_dir+90),
                              lerp(y,target_y,_t)+lengthdir_y(_off,_dir+90)])
    }
    arc_visible=true
    // Damage belongs to the continuous arc, not a repeating nearest-target zap.
    // Use native target invulnerability so overlapping coils share the same
    // six logical-frame damage window at 30/60/120 Hz.
    for(var _i=1;_i<array_length(arc_points);++_i) {
        var _a=arc_points[_i-1],_b=arc_points[_i]
        if (collision_line(_a[0],_a[1],_b[0],_b[1],Wall,false,false)!=noone) break
        with (hitme) {
            if (hp<=0 || team==other.team || mask_index==mskNone) continue
            if (bbox_right<min(_a[0],_b[0]) || bbox_left>max(_a[0],_b[0])
                || bbox_bottom<min(_a[1],_b[1]) || bbox_top>max(_a[1],_b[1])) continue
            var _victim=id
            with (other) if (scr_can_hit(_victim,true)
                && collision_line(_a[0],_a[1],_b[0],_b[1],_victim,false,true)!=noone) {
                if (scr_projectile_hit(_victim,damage,4*timescale,point_direction(x,y,_victim.x,_victim.y))) {
                    ++hit_count
                    if (!place_meeting(_victim.x,_victim.y,LightningHit)) instance_create(_victim.x,_victim.y,LightningHit)
                    snd_play_hit(sndLightningHit,0.2)
                }
            }
        }
    }
}

function scrNTTECoilOriginalStep() {
    if (lockstep_stop) return;
    if (!instance_exists(creator) || creator.hp<=0) { instance_destroy(); return; }
    scrNTTECoilFollow()
    if (!initialized) {
        range=vampire ? 64:96
        scrNTTECoilTarget()
        initialized=true
    }
    wave+=timescale
    if (instance_exists(target) && target.hp>0 && target.team!=team) {
        if (current_frame_active) { target_x=target.x+orandom(2); target_y=target.y+orandom(2) }
    }
    else if (target!=noone) { target=noone; life=min(life,8) }
    scrNTTECoilArc()
    if (primary) creator.wkick=3
    else creator.bwkick=3
    age+=timescale
    life-=timescale
    if (life<=0) instance_destroy()
}

function scrNTTECoilOriginalDraw() {
    draw_self()
    if (!arc_visible) return;
    var _frame=floor(age*0.4) mod sprite_get_number(sprLightning)
    for(var _i=1;_i<array_length(arc_points);++_i) {
        var _a=arc_points[_i-1],_b=arc_points[_i]
        if (collision_line(_a[0],_a[1],_b[0],_b[1],Wall,false,false)!=noone) break
        draw_sprite_ext(sprLightning,_frame,_a[0],_a[1],point_distance(_a[0],_a[1],_b[0],_b[1])/sprite_get_width(sprLightning),
                        random_range(0.5,1.25),point_direction(_a[0],_a[1],_b[0],_b[1]),c_white,1)
    }
}

function scrNTTEFireCoil(_weapon,_primary,_state) {
    var _bat=_weapon==wep_ntte_vampire
    if (_bat && !scrNTTESpend(_state,1)) return;
    var _p=scr_projectile_create(x,y,NTTECoil,gunangle,0)
    _p.primary=_primary
    _p.vampire=_bat
    if (!_primary) _p.creator_offy-=4
    if (_bat) {
        _p.life=7*(1+scr_skill_get(mut_laser_brain))
        if (_state.ammo<=0) scrNTTEVampireRefill(_state)
    }
    var _count=0
    with (NTTECoil) {
        if (creator==other.id && primary==_primary && vampire==_bat) { _count+=1 }
    }
    if (_count==1) {
        // NTT weapon_post(kick, pan, shake) -> Epsilon(dir, pan, shake, kick).
        scr_weapon_post(gunangle,-10,10,8)
        if (_bat) {
            snd_play(sndBloodLauncherExplo,random_range(0.9,1.3),0.8)
            snd_play(scr_skill_get(mut_laser_brain)>0 ? sndLightningShotgunUpg:sndLightningShotgun)
        }
        else {
            var _side=_p.creator_offy*right
            instance_create(x+lengthdir_x(17,gunangle)+lengthdir_x(_side,gunangle-90),
                            y+lengthdir_y(17,gunangle)+lengthdir_y(_side,gunangle-90)-(_primary ? 0:4),LightningHit)
            snd_play(scr_skill_get(mut_laser_brain)>0 ? sndLaserUpg:sndLaser,random_range(1.4,1.8))
        }
    }
}

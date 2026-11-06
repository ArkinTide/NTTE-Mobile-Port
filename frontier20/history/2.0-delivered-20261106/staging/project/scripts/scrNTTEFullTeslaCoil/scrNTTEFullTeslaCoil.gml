// Original tetrench TeslaCoil; also used by the cannon plasma projectiles.
function scrNTTEFullTeslaCoilCreate() {
    sprite_index=sprLightningBall; image_speed=(0.4+orandom(0.1))*timescale
    image_xscale=0.4; image_yscale=0.4; mask_index=-1
    damage=14; knockback_speed=4*timescale; typ=0
    creator=noone; team=team_none; target=noone
    num=3
    ntte_full_offx=17; ntte_full_offy=2; ntte_full_wave=random(960)
    ntte_full_time=random_range(8,16)*(1+0.5*scr_skill_get(mut_laser_brain))
    ntte_full_target_x=x; ntte_full_target_y=y; ntte_full_range=96
    ntte_full_primary=true; ntte_full_purple=false; ntte_full_target_delay=1
}

function scrNTTEFullTeslaCoilTarget() {
    var _targets=[],_priority=0
    with (hitme) if (team!=other.team && mask_index!=mskNone
        && distance_to_point(other.x,other.y)<other.ntte_full_range
        && !collision_line(x,y,other.x,other.y,Wall,false,false)) {
        // Retain source iteration/order behavior, including lower teams found
        // after the last priority reset.
        if (team>_priority) { _priority=team; _targets=[] }
        array_push(_targets,id)
    }
    if (array_length(_targets)>0) {
        target=_targets[irandom(array_length(_targets)-1)]
        ntte_full_target_x=target.x; ntte_full_target_y=target.y
        ntte_full_time*=1.5
    }
    else {
        var _dis=ntte_full_range*random_range(0.2,0.8),_dir=random(360)
        do {
            ntte_full_target_x=x+lengthdir_x(_dis,_dir)
            ntte_full_target_y=y+lengthdir_y(_dis,_dir); _dis-=4
        } until(_dis<12 || !collision_line(x,y,ntte_full_target_x,ntte_full_target_y,Wall,false,false))
    }
}

function scrNTTEFullTeslaCoilStep() {
    if (lockstep_stop) return;
    if (ntte_full_target_delay>=0) {
        ntte_full_target_delay-=timescale
        if (ntte_full_target_delay<=0) { ntte_full_target_delay=-1; scrNTTEFullTeslaCoilTarget() }
    }
    ntte_full_wave+=timescale
    if (!instance_exists(creator)) { instance_destroy(); return; }
    var _kick=ntte_full_primary ? "wkick":"bwkick",
        _recoil=variable_instance_exists(creator,_kick) ? variable_instance_get(creator,_kick):0,
        _xdis=ntte_full_offx-_recoil/3,
        _xdir=variable_instance_exists(creator,"gunangle") ? creator.gunangle:direction,
        _right=variable_instance_exists(creator,"right") ? creator.right:1,
        _ydis=ntte_full_offy*_right,_ydir=_xdir-90
    x=creator.x+creator.hspeed+lengthdir_x(_xdis,_xdir)+lengthdir_x(_ydis,_ydir)
    y=creator.y+creator.vspeed+lengthdir_y(_xdis,_xdir)+lengthdir_y(_ydis,_ydir)+(ntte_full_primary ? 0:-4)
    xprevious=x; yprevious=y
    if (instance_exists(target)) {
        ntte_full_target_x=target.x+orandom(2); ntte_full_target_y=target.y+orandom(2)
    }
    else if (target!=noone) { target=noone; ntte_full_time=min(ntte_full_time,8) }
    var _tx=ntte_full_target_x,_ty=ntte_full_target_y
    if ((instance_exists(target) || point_distance(x,y,_tx,_ty)<ntte_full_range+32)
        && !collision_line(x,y,_tx,_ty,Wall,false,false)) {
        // Source ElectroPlasma.wave is namespaced in this port; preserve
        // creator's wave rather than accidentally substituting the coil's.
        var _wave=scrNTTEFullValue(creator,"wave",scrNTTEFullValue(creator,"ntte_full_wave",ntte_full_wave)),
            _arc=power(point_distance(x,y,_tx,_ty),0.6)*sin(_wave/240*2*pi)+4*cos(_wave/960*2*pi),
            _parts=scrNTTEFullTrenchArc(x,y,_tx,_ty,4*sqrt(abs(_arc))*sign(_arc),id,false)
        if (ntte_full_purple) {
            for(var _i=0;_i<array_length(_parts);++_i) {
                var _p=_parts[_i]
                _p.damage=floor(damage*7/3); _p.sprite_index=scrNTTERefSprite("ElectroPlasmaTether"); _p.depth=-3
                if (random(16)<timescale) {
                    var _fx=instance_create(_p.x,_p.y,PlasmaTrail)
                    _fx.sprite_index=scrNTTERefSprite("ElectroPlasmaTrail")
                    with (_fx) motion_set(_p.direction,timescale)
                }
            }
            if (random(15)<timescale) scrNTTEFullTrenchFX(_tx,_ty,1,1,PortalL)
            if (!place_meeting(_tx,_ty,Smoke)) instance_create(_tx,_ty,Smoke)
        }
        else if (!place_meeting(_tx,_ty,LightningHit)) {
            var _fx=instance_create(_tx,_ty,LightningHit); _fx.image_speed=(0.2+random(0.2))*timescale
        }
    }
    scrNTTEFullTrenchShake(x,y,3,true)
    if (variable_instance_exists(creator,_kick)) variable_instance_set(creator,_kick,3)
    if (ntte_full_time>0) {
        ntte_full_time-=timescale
        if (ntte_full_time<=0) instance_destroy()
    }
}

function scrNTTEFullTeslaCoilHit(_victim) {
    // Source scrMeleeCanHit + scrBulletHit: no hp/phase gate, native minimum16,
    // direct original damage and actual custom callbacks, projectile angle.
    if(lockstep_stop || !instance_exists(_victim) || _victim.team==team
        || _victim.nexthurt>current_frame) return false
    var _native=!scrNTTEFullRawHitCustom(_victim)
    scrNTTEFullNativeProjectileDirectHit(_victim,damage,knockback_speed/timescale,direction,0)
    if(_native && knockback_speed>0 && instance_exists(_victim)) with(_victim)
        speed=max(speed,16*timescale-friction*(1/timescale-1))
    return true
}

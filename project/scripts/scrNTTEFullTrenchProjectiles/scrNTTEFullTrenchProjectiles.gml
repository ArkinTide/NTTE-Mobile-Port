// NTTE 2.062 tetrench LightningDisc + lightning_connect adapted to native VM.
// Uses a separate native lightning object because the exported vanilla Create
// applies a global underwater shock and does not implement NTT's ammo/alarm API.
function scrNTTEFullTrenchLightningCreate() {
    typ=0; damage=2; sprite_index=sprEnemyLightning; mask_index=mskLaser
    image_speed=0.4*timescale; ntte_full_ttl=-1
    ntte_full_enemy=true; ntte_full_emit_delay=-1; ntte_full_emit_ammo=0
}

function scrNTTEFullTrenchLightningStep() {
    if (lockstep_stop) return;
    if (ntte_full_emit_delay>0) {
        ntte_full_emit_delay-=timescale
        if (ntte_full_emit_delay<=0) {
            scrNTTEFullTrenchDischarge(x,y,direction,ntte_full_emit_ammo,true)
            instance_destroy(); return;
        }
    }
    if (ntte_full_ttl>=0) {
        ntte_full_ttl-=timescale
        if (ntte_full_ttl<=0) instance_destroy()
    }
}

// The native Epsilon scrLightningCreate replaces NTT's Lightning alarm/ammo
// chain API. Preserve its targeting, 8..12 pixel segment lengths, wall recoil,
// angular randomness, and animation staggering, using our underwater-safe node.
function scrNTTEFullTrenchDischarge(_sx,_sy,_angle,_length,_enemy=true) {
    var _marker=instance_create(_sx+lengthdir_x(8,_angle),_sy+lengthdir_y(8,_angle),LightningSpawn)
    _marker.image_angle=_angle
    var _first=scr_projectile_create(_sx,_sy,NTTEFullTrenchLightning,_angle,0),_node=_first,_source=id
    _first.visible=false; _first.image_angle=_angle
    for(var _count=max(1,ceil(_length));_count>0;--_count) {
        with (_node) {
            var _ox=x,_oy=y,_distance=8+random(4),_target_object=hitme
            if (team==team_player) _target_object=enemy
            else if (team==team_enemy || team==team_popo) _target_object=Player
            var _target=instance_nearest(x+lengthdir_x(80,direction),y+lengthdir_y(80,direction),_target_object)
            speed=4*timescale; direction=image_angle+orandom(15)
            if (instance_exists(_target) && point_distance(x,y,_target.x,_target.y)<120)
                motion_add(point_direction(x,y,_target.x,_target.y),timescale)
            x+=lengthdir_x(_distance,direction); y+=lengthdir_y(_distance,direction)
            var _wall=instance_place(x,y,Wall)
            if (instance_exists(_wall) && !instance_is(_wall,InvisiWall)) {
                x=xprevious; y=yprevious; direction+=180
            }
            speed=0; image_angle=direction
            image_xscale=-point_distance(x,y,_ox,_oy)*0.5; image_index+=0.4/_count
            damage=_enemy ? 2:7; sprite_index=_enemy ? sprEnemyLightning:sprLightning
            ntte_full_enemy=_enemy
            if (!_enemy && scr_skill_get(mut_laser_brain)) image_speed=0.3*timescale
            var _next=instance_create(x,y,NTTEFullTrenchLightning)
            _next.direction=direction; _next.image_angle=direction; _next.image_index=image_index
            _next.creator=creator; _next.team=team; _next.hitid=hitid
            _next.sprite_index=sprite_index; _next.damage=damage; _next.image_speed=image_speed
            _next.ntte_full_enemy=_enemy
            _node=_next
        }
    }
    with (_node) instance_create(x+lengthdir_x(image_xscale*0.5,image_angle),y+lengthdir_y(image_yscale*0.5,image_angle),LightningHit)
    return _first
}

function scrNTTEFullTrenchArc(_x1,_y1,_x2,_y2,_arc,_source,_enemy=true) {
    var _max=point_distance(_x1,_y1,_x2,_y2),_add=min(_max/8,10),_distance=_max,
        _dir=point_direction(_x1,_y1,_x2,_y2),_x=_x1,_y=_y1,_lx=_x,_ly=_y,
        _ox=lengthdir_x(_add,_dir),_oy=lengthdir_y(_add,_dir),_out=[]
    if (_max<0.001) return _out
    var _creator=instance_exists(_source) ? _source:id,
        _team=instance_exists(_source) ? _source.team:team,
        _hitid=instance_exists(_source) ? _source.hitid:hitid
    // NTT lightning_connect retains the original owner of projectile sources.
    if (instance_exists(_source) && !instance_is(_source,hitme)
        && variable_instance_exists(_source,"creator")) _creator=_source.creator
    while(_distance>_add) {
        _distance-=_add; _x+=_ox; _y+=_oy
        var _wx=_x2,_wy=_y2
        if (_distance>_add) {
            var _wave=_distance/_max*pi,_off=_arc/6*sin(_distance/8+current_frame/6)
            _wx=_x+lengthdir_x(_off,_dir-90)+_arc*sin(_wave)
            _wy=_y+lengthdir_y(_off,_dir-90)+_arc*sin(_wave/2)
        }
        var _p=instance_create(_wx,_wy,NTTEFullTrenchLightning)
        _p.damage=(_enemy ? 2:7); _p.sprite_index=(_enemy ? sprEnemyLightning:sprLightning)
        _p.ntte_full_enemy=_enemy
        _p.image_xscale=-point_distance(_lx,_ly,_wx,_wy)/2
        _p.image_angle=point_direction(_lx,_ly,_wx,_wy); _p.direction=_p.image_angle
        _p.creator=_creator; _p.team=_team; _p.hitid=_hitid
        var _phase=instance_exists(_creator) ? _creator.xstart+_creator.ystart:0
        _p.image_index=(current_frame*0.4+_phase) mod _p.image_number
        // Recreated every Step, exactly one rendered frame as in the original.
        _p.image_speed=_p.image_number
        array_push(_out,_p); _lx=_wx; _ly=_wy
    }
    if (array_length(_out)>0 && random(200)<array_length(_out)*timescale) {
        var _p=_out[irandom(array_length(_out)-1)]
        scrNTTEFullTrenchFX(_p.x,_p.y,8,1,PortalL)
        snd_play_hit(sndLightningReload,0.5)
    }
    return _out
}

// Original tetrench lightning_disappear. Enemy arcs become harmless trails;
// player arcs retain their invisible hit window and reset to normal animation.
function scrNTTEFullTrenchLightningDisappear(_instances) {
    var _input=is_array(_instances) ? _instances:[_instances],_out=[]
    for(var _i=0;_i<array_length(_input);++_i) {
        var _p=_input[_i]
        if (!instance_exists(_p)) continue
        var _enemy=variable_instance_exists(_p,"ntte_full_enemy") ? _p.ntte_full_enemy:instance_is(_p,EnemyLightning),
            _base_speed=0.4*timescale
        if (!_enemy && scr_skill_get(mut_laser_brain)) _base_speed=0.3*timescale
        _p.image_speed=_base_speed
        var _trail=instance_create(_p.x,_p.y,BoltTrail)
        _trail.sprite_index=_p.sprite_index; _trail.image_index=_p.image_index
        _trail.image_speed=_base_speed; _trail.image_xscale=_p.image_xscale
        _trail.image_yscale=_p.image_yscale*power(0.4*timescale/_base_speed,4/3)
        _trail.image_angle=_p.image_angle; _trail.image_blend=_p.image_blend
        _trail.image_alpha=_p.image_alpha; _trail.depth=_p.depth
        if (_enemy) _trail.image_yscale-=random(0.4)
        array_push(_out,_trail)
        if (_enemy) { with (_p) instance_destroy() }
        else { _p.image_index=0; _p.image_alpha=0 }
    }
    return _out
}

function scrNTTEFullLightningDiscCreate() {
    sprite_index=sprLightning; image_speed=0.4*timescale; depth=-3
    mask_index=mskWepPickup; image_xscale=0; image_yscale=0
    ntte_full_rotation_speed=random_range(10,20)*choose(-1,1)
    ntte_full_rotation=0; ntte_full_radius=12; ntte_full_charge=1
    ntte_full_charge_speed=2; ntte_full_segments=10; typ=0
    ntte_full_shrink=1/160; ntte_full_maxspeed=2.5; ntte_full_stretch=1
    ntte_full_super=-1; ntte_full_enemy=false; ntte_full_follow=true
    ntte_full_primary=true; ntte_full_setup=true
    ntte_full_hits=0
}

function scrNTTEFullLightningDiscSetup() {
    ntte_full_setup=false
    if (ntte_full_enemy) {
        if (sprite_index==sprLightning) sprite_index=sprEnemyLightning
    }
    else {
        var _brain=scr_skill_get(mut_laser_brain)
        ntte_full_charge*=power(1.2,_brain)
        ntte_full_stretch*=power(1.2,_brain); image_speed*=power(0.75,_brain)
    }
}

function scrNTTEFullLightningDiscStep() {
    if (lockstep_stop) return;
    ntte_full_rotation+=ntte_full_rotation_speed*timescale
    if (ntte_full_setup) scrNTTEFullLightningDiscSetup()
    if (image_xscale<ntte_full_charge) {
        image_xscale+=ntte_full_charge/20*ntte_full_charge_speed*timescale
        image_yscale=image_xscale
        if (ntte_full_follow && instance_exists(creator)) {
            x=creator.x; y=creator.y-(ntte_full_primary ? 0:4)
            if (variable_instance_exists(creator,"gunangle")) {
                direction=creator.gunangle; x+=hspeed/timescale; y+=vspeed/timescale
                if (place_meeting(x,y,Wall)) {
                    if (ntte_full_charge<2.5) scrNTTEFullWorldBudge(id,Wall,32)
                    else scrNTTEFullLightningDiscClearWalls(true)
                }
            }
            var _kick=ntte_full_primary ? "wkick":"bwkick"
            if (variable_instance_exists(creator,_kick))
                variable_instance_set(creator,_kick,5*image_xscale/ntte_full_charge)
        }
        xprevious=x; yprevious=y; x-=hspeed; y-=vspeed
        snd_play(sndLightningHit,image_xscale/ntte_full_charge)
        if (!ntte_full_enemy) {
            snd_play(sndPlasmaReload,image_xscale/ntte_full_charge*3)
            scrNTTEFullTrenchShake(x,y,6*image_xscale,true)
        }
    }
    else {
        if (ntte_full_charge>0) {
            if (place_meeting(x,y,Wall)) scrNTTEFullLightningDiscClearWalls(false)
            if (instance_exists(creator)) {
                var _kick=ntte_full_primary ? "wkick":"bwkick"
                if (variable_instance_exists(creator,_kick)) variable_instance_set(creator,_kick,-4)
                if (instance_is(creator,Player)) {
                    with (creator) scr_weapon_post(gunangle,16*other.ntte_full_charge,8*other.ntte_full_charge,wkick)
                    direction+=orandom(6*creator.accuracy)
                }
            }
            snd_play(sndLightningCannonEnd,(3+random(1))/ntte_full_charge)
            var _fx=instance_create(x,y,NTTEFullGunWarrantEmpty)
            _fx.image_angle=direction
            if (!ntte_full_enemy && scr_skill_get(mut_laser_brain)) snd_play(sndLightningPistolUpg,0.8)
            ntte_full_charge=0
        }
        if (!ntte_full_enemy && random(30)<timescale) {
            scrNTTEFullLightningDiscRandomZap()
        }
    }
    // Source logical speed -= current_time_scale; there is no floor clamp.
    if (ntte_full_charge<=0 && speed>ntte_full_maxspeed*timescale) speed-=timescale*timescale
    if (current_frame_active) {
      if (random(30)<image_xscale || (ntte_full_charge<=0 && speed>ntte_full_maxspeed*timescale && random(3)<image_xscale)) {
        var _d=random(360),_r=random(ntte_full_radius),_p=instance_create(x+lengthdir_x(_r*image_xscale,_d),y+lengthdir_y(_r*image_yscale,_d),PortalL)
        scrNTTEFullNativeMotionAddFT(_p,random(360),1)
        if (ntte_full_charge<=0) { _p.hspeed+=hspeed; _p.vspeed+=vspeed }
      }
      if(ntte_full_super>=0 && ntte_full_charge<=0 && image_xscale<ntte_full_super+1) {
        if(random(12*(image_xscale-ntte_full_super))<1) {
            var _angle=random(360)
            repeat(irandom(2)) {
                var _fx=instance_create(x+lengthdir_x(image_xscale*17+hspeed/timescale,_angle),
                    y+lengthdir_y(image_yscale*17+vspeed/timescale,_angle),LightningSpawn)
                _fx.image_angle=_angle;_fx.image_index=1
                var _portal=instance_create(_fx.x,_fx.y,PortalL);_portal.image_angle=_angle
            }
            scrNTTEFullTrenchShake(x,y,3)
            var _pitch=1/(4*(image_xscale-ntte_full_super+0.12)),_volume=0.1/(image_xscale-ntte_full_super+0.2)
            snd_play(sndGammaGutsKill,random_range(1.8,2.5)*_pitch,min(_volume,0.7))
            snd_play(sndLightningHit,random_range(0.8,1.2)*_pitch,min(_volume,0.7)*2)
            // Source logical speed subtracts two percent of *physical* speed.
            speed-=speed*0.02*timescale
            x+=orandom(3)*_pitch*timescale;y+=orandom(3)*_pitch*timescale
        }
      }
    }
    if (ntte_full_charge<=0) {
        image_xscale-=ntte_full_shrink*timescale; image_yscale-=ntte_full_shrink*timescale
        if(ntte_full_super>=0 && min(image_xscale,image_yscale)<=ntte_full_super) {
            instance_destroy();return;
        }
        if (min(image_xscale,image_yscale)<=0) {
            snd_play_hit(sndLightningHit,0.5); instance_create(x,y,LightningHit); instance_destroy()
        }
    }
}

function scrNTTEFullLightningDiscHit(_victim) {
    // Original scrMeleeCanHit: opposing team + nexthurt only, no hp/phase gate
    // and no invented private one-tick cache. The actual lightning does damage.
    if (!instance_exists(_victim) || _victim.team==team || _victim.nexthurt>current_frame) return false
    if (image_xscale>=ntte_full_charge) {
        x-=hspeed/timescale; y-=vspeed/timescale; direction=point_direction(x,y,_victim.x,_victim.y)+orandom(10)
    }
    var _angle=random(360),_sx=x+lengthdir_x(ntte_full_radius*image_xscale,_angle),
        _sy=y+lengthdir_y(ntte_full_radius*image_yscale,_angle),_scale=image_xscale
    var _node=scrNTTEFullMergedBasicProjectileCreate(_sx,_sy,ntte_full_enemy?EnemyLightning:Lightning,
        point_direction(_sx,_sy,_victim.x,_victim.y)+orandom(12))
    // Original computes ammo inside the new field after its constructor,
    // preserving direction/constructor/ammo RNG order.
    if(instance_exists(_node)) with(_node) {ammo=min(28,ceil(_scale+random(_scale*2)));event_perform(ev_alarm,0)}
    instance_create(_victim.x,_victim.y,Smoke); snd_play(sndLightningHit)
    ++ntte_full_hits
    return true
}

function scrNTTEFullLightningDiscWall(_wall) {
    var _hx=hspeed/timescale,_vy=vspeed/timescale
    if (image_xscale>=ntte_full_charge && min(image_xscale,image_yscale)<2.5) {
        if (place_meeting(x+hspeed/timescale,y,Wall)) hspeed=-hspeed
        if (place_meeting(x,y+vspeed/timescale,Wall)) vspeed=-vspeed
        if (instance_exists(_wall)) {
            var _a=point_direction(_wall.x+8,_wall.y+8,x,y)
            instance_create(_wall.x+8+lengthdir_x(8,_a),_wall.y+8+lengthdir_y(8,_a),PortalL)
        }
        with(_wall) snd_play_hit(sndLightningHit,0.2)
    }
    if (max(image_xscale,image_yscale)>1.2) {
        if(instance_exists(_wall)) with(_wall) {instance_create(x,y,FloorExplo);instance_destroy()}
        var _walls=scrNTTEFullInstances(Wall)
        for(var _i=0;_i<array_length(_walls);++_i) if(instance_exists(_walls[_i])) with(_walls[_i]) {
            if(place_meeting(x-_hx,y-_vy,other.id)) {instance_create(x,y,FloorExplo);instance_destroy()}
        }
    }
}

function scrNTTEFullLightningDiscDraw() {
    var _off=360/ntte_full_segments,_ys=ntte_full_stretch*(0.5+random(1)),_rotation=image_angle+ntte_full_rotation
    for(var _d=_rotation;_d<_rotation+360;_d+=_off) {
        var _r=random(2),_rx=ntte_full_radius*image_xscale+_r,_ry=ntte_full_radius*image_yscale+_r,
            _x1=x+lengthdir_x(_rx,_d),_y1=y+lengthdir_y(_ry,_d),
            _x2=x+lengthdir_x(_rx,_d+_off),_y2=y+lengthdir_y(_ry,_d+_off)
        draw_sprite_ext(sprite_index,image_index,_x1,_y1,point_distance(_x1,_y1,_x2,_y2)/2,_ys,
            point_direction(_x1,_y1,_x2,_y2),image_blend,image_alpha)
    }
}

function scrNTTEFullLightningDiscDestroy() {
    if (ntte_full_super<0 || !instance_exists(GameCont)) return;
    sleep(80)
    snd_play(sndLightningPistolUpg,0.7,0.4); snd_play(sndLightningPistol,0.7,0.6)
    snd_play(sndGammaGutsKill,0.5+random(0.2),0.7)
    var _start=random(360)
    for(var _i=0;_i<5;++_i) {
        var _dir=_start+_i*72,_p=scrNTTEFullMergedBasicProjectileCreate(x,y,NTTEFullLightningDisc,_dir,10)
        _p.ntte_full_charge=image_xscale/1.2; _p.ntte_full_follow=false
        _p.image_xscale=_p.ntte_full_charge*0.9; _p.image_yscale=_p.image_xscale
        instance_create(x+lengthdir_x(24,_dir),y+lengthdir_y(24,_dir),PortalClear)
    }
}

function scrNTTEFullLightningDiscClearWalls(_bbox) {
    var _disc=id,_walls=scrNTTEFullInstances(Wall)
    for(var _i=0;_i<array_length(_walls);++_i) {
        var _wall=_walls[_i]
        if(!instance_exists(_wall)) continue
        if(_bbox && (_wall.bbox_right-1<bbox_left || _wall.bbox_bottom-1<bbox_top
            || _wall.bbox_left>bbox_right-1 || _wall.bbox_top>bbox_bottom-1)) continue
        with(_wall) if(place_meeting(x,y,_disc)) {instance_create(x,y,FloorExplo);instance_destroy()}
    }
}
function scrNTTEFullLightningDiscRandomZap() {
    var _targets=scrNTTEFullInstances(hitme),_nearest=noone,_distance=infinity,_disc=id
    for(var _i=0;_i<array_length(_targets);++_i) {
        var _target=_targets[_i]
        if(_target.team==team || _target.team==team_none) continue
        var _d=point_distance(x,y,_target.x,_target.y)
        if(_d<_distance) {_distance=_d;_nearest=_target}
    }
    if(!instance_exists(_nearest)) return false
    var _hit=false
    with(_nearest) if(!place_meeting(x,y,_disc) && distance_to_object(_disc)<32) {
        with(_disc) _hit=scrNTTEFullLightningDiscHit(_nearest)
    }
    return _hit
}


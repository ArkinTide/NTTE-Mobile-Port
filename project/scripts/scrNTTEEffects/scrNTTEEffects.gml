function scrNTTEIndex(_array,_value) {
    for(var _i=0;_i<array_length(_array);++_i) if (_array[_i]==_value) return _i
    return -1
}

function scrNTTENearestHostile(_x,_y,_range) {
    var _best = noone, _distance = _range
    with (hitme) {
        if (instance_is(id,NTTECat) && !ntte_cat_active) continue
        if (hp>0 && team!=other.team && !instance_is(id,prop)) {
            var _d = point_distance(x,y,_x,_y)
            if (_d<_distance && collision_line(_x,_y,x,y,Wall,false,false)==noone) {
                _distance = _d
                _best = id
            }
        }
    }
    return _best
}

function scrNTTEFX(_sprite,_x,_y,_scale=1) {
    with (instance_create(_x,_y,PlasmaTrail)) {
        sprite_index = _sprite
        image_index = 0
        image_speed = 0.4*timescale
        image_xscale = _scale
        image_yscale = _scale
        depth = -4
    }
}

function scrNTTEClearWalls(_x,_y,_radius) {
    var _walls = ds_list_create()
    collision_circle_list(_x,_y,_radius,Wall,false,false,_walls,false)
    for(var _i=0;_i<ds_list_size(_walls);++_i) {
        var _wall = _walls[| _i]
        if (instance_exists(_wall) && !instance_is(_wall,InvisiWall)) scrWallDestroy(_wall)
    }
    ds_list_destroy(_walls)
}

function scrNTTEAreaDamage(_x,_y,_radius,_damage) {
    var _list = ds_list_create()
    collision_circle_list(_x,_y,_radius,hitme,false,false,_list,false)
    for(var _i=0;_i<ds_list_size(_list);++_i) scrNTTEHurt(_list[| _i],_damage,6,4)
    ds_list_destroy(_list)
}

function scrNTTESegmentDistance(_x,_y,_x1,_y1,_x2,_y2) {
    var _dx=_x2-_x1,_dy=_y2-_y1,
        _t=clamp(((_x-_x1)*_dx+(_y-_y1)*_dy)/max(0.001,_dx*_dx+_dy*_dy),0,1)
    return point_distance(_x,_y,_x1+_dx*_t,_y1+_dy*_t)
}

function scrNTTELineDamage(_x1,_y1,_x2,_y2,_width,_damage,_delay) {
    var _list = ds_list_create()
    collision_rectangle_list(min(_x1,_x2)-_width,min(_y1,_y2)-_width,
        max(_x1,_x2)+_width,max(_y1,_y2)+_width,hitme,false,false,_list,false)
    for(var _i=0;_i<ds_list_size(_list);++_i) {
        var _t = _list[| _i]
        if (!instance_exists(_t)) continue
        var _cx=(_t.bbox_left+_t.bbox_right+1)/2,_cy=(_t.bbox_top+_t.bbox_bottom+1)/2,
            _r=min(_t.bbox_right-_t.bbox_left,_t.bbox_bottom-_t.bbox_top)/2
        if (scrNTTESegmentDistance(_cx,_cy,_x1,_y1,_x2,_y2)<=_r+_width)
            scrNTTEHurt(_t,_damage,_delay,2)
    }
    ds_list_destroy(_list)
}

function scrNTTEHyperRay() {
    var _hits = 3, _sx=x, _sy=y
    // The original Hyper Bubbler is a penetrating hitscan, not a slow grenade.
    for(var _dist=0;_dist<1600;_dist+=8) {
        if (position_meeting(x,y,Wall)) break
        var _list=ds_list_create(), _hit=false
        collision_circle_list(x,y,6,hitme,false,false,_list,false)
        for(var _i=0;_i<ds_list_size(_list);++_i) {
            if (scrNTTEHurt(_list[| _i],12,999,12)) _hit=true
        }
        ds_list_destroy(_list)
        if (_hit) {
            scrNTTEFX(sprNTTEBubbleExplosionSmall,x,y)
            if (--_hits<=0) break
        }
        if ((_dist mod 32)==0) instance_create(x,y,Bubble)
        x+=lengthdir_x(8,direction)
        y+=lengthdir_y(8,direction)
    }
    scrNTTEAreaDamage(x,y,24,3)
    scrNTTEFX(sprNTTEBubbleExplosion,x,y)
}

function scrNTTEPairHarpoon(_p) {
    var _previous = variable_instance_exists(id,"ntte_last_harpoon") ? ntte_last_harpoon:noone
    if (instance_exists(_previous) && instance_is(_previous,NTTEAttack) && _previous.kind==NTTEKind.Harpoon) {
        _p.link = _previous
        _p.rope_length = _previous.rope_length
        _p.rope_dynamic = true
        _p.rope_timer = 60
        _previous.link = noone
        ntte_last_harpoon = noone
    }
    else {
        // The first shot connects to its owner. A second transfers that end
        // from the owner to the new harpoon, as in the original weapon script.
        _p.link=id
        _p.rope_dynamic=true
        _p.rope_length=point_distance(x,y,_p.x,_p.y)
        _p.rope_timer=45+random(15)
        ntte_last_harpoon=_p
    }
}

function scrNTTERopePull(_inst,_tx,_ty,_excess) {
    if (!instance_exists(_inst) || !instance_is(_inst,hitme) || instance_is(_inst,prop)) return;
    with (_inst) {
        var _dir=point_direction(x,y,_tx,_ty),_player=instance_is(id,Player),
            _drag=min(_excess/3,10/(max(size,0.5)*2))*timescale,
            _steps=max(1,ceil(_drag)),_dx=lengthdir_x(_drag/_steps,_dir),_dy=lengthdir_y(_drag/_steps,_dir)
        motion_add(_dir,(_player ? 0.5:2)*timescale*timescale)
        repeat(_steps) {
            if (!place_meeting(x+_dx,y,Wall)) x+=_dx
            if (!place_meeting(x,y+_dy,Wall)) y+=_dy
        }
    }
}

function scrNTTERopeStep() {
    if (!instance_exists(link)) return;
    var _len=point_distance(x,y,link.x,link.y),_harpoon=instance_is(link,NTTEAttack),
        _other_moving=_harpoon && link.kind==NTTEKind.Harpoon && !link.stuck
    rope_timer-=timescale
    if (rope_dynamic && stuck && _harpoon && link.stuck) rope_length=0
    var _excess=_len-rope_length
    if (_excess>1000 || (rope_timer<=0 && _excess>100) || life<30) { link=noone; return; }
    if (_excess>0) {
        if (instance_exists(target)) scrNTTERopePull(target,link.x,link.y,_excess)
        var _other_target=_harpoon ? link.target:link
        if (instance_exists(_other_target)) scrNTTERopePull(_other_target,x,y,_excess)
    }
    // Original ntte_step pulls before Harpoon_step records the new moving
    // length. Recording it first would erase the launch tug on the player.
    if (rope_dynamic && (!stuck || _other_moving)) rope_length=_len
}

function scrNTTENetExplode() {
    var _first=noone,_last=noone
    for(var _i=0;_i<10;++_i) {
        var _p=scrNTTEShot(NTTEKind.Harpoon,_i*36,14)
        _p.link=_last
        _p.rope_length=32
        _p.life=180
        if (_i==0) _first=_p
        _last=_p
    }
    if (instance_exists(_first)) _first.link=_last
    scrNTTEClearWalls(x,y,32)
    snd_play(sndExplosionS)
    scrNTTEFX(sprNTTEBubbleExplosion,x,y)
}

// Teleports use the traveller's own collision mask and require real floor.
function scrNTTETeleport(_inst,_x,_y) {
    var _ok=false
    if (!instance_exists(_inst)) return false
    with (_inst) {
        for(var _r=0;_r<=48;_r+=8) {
            for(var _a=0;_a<360;_a+=45) {
                var _tx=_x+lengthdir_x(_r,_a),_ty=_y+lengthdir_y(_r,_a)
                if (position_meeting(_tx,_ty,Floor) && !place_meeting(_tx,_ty,Wall)) {
                    scrNTTEFX(sprNTTEPortalBulletHit,x,y)
                    x=_tx
                    y=_ty
                    xprevious=x
                    yprevious=y
                    speed=0
                    if (variable_instance_exists(id,"nexthurt")) nexthurt=max(nexthurt,current_frame+10)
                    scrNTTEFX(sprNTTEPortalBulletHit,x,y)
                    _ok=true
                    break
                }
            }
            if (_ok) break
        }
    }
    return _ok
}

function scrNTTEPortalFinish() {
    if (age<hold_time || !instance_exists(creator) || creator.hp<=0) return;
    if (is_struct(portal_group) && portal_group.used) return;
    if (scrNTTETeleport(creator,safe_x,safe_y) && is_struct(portal_group)) portal_group.used=true
    scrNTTEFX(sprNTTEPortalBulletHit,x,y)
    snd_play(sndGuardianAppear)
}

function scrNTTEAttackDraw() {
    if (kind==NTTEKind.Bubble) draw_sprite_ext(sprite_index,image_index,x,y-z,1,1,0,c_white,1)
    else draw_self()
    if ((kind==NTTEKind.Plasma || kind==NTTEKind.Harpoon) && instance_exists(kind==NTTEKind.Plasma ? tether:link)) {
        var _t=kind==NTTEKind.Plasma ? tether:link,
            _d=point_distance(x,y,_t.x,_t.y)
        if (_d>(hyper || kind==NTTEKind.Harpoon ? 1200:256)) return;
        if (kind==NTTEKind.Plasma) {
            draw_sprite_ext(sprNTTEElectroPlasmaTether,floor(current_frame*0.4),x,y,
                _d/sprite_get_width(sprNTTEElectroPlasmaTether),1,
                point_direction(x,y,_t.x,_t.y),c_white,0.8)
        }
        else {
            draw_set_color(make_color_rgb(121,141,109))
            draw_line(x,y,_t.x,_t.y)
            draw_set_color(c_white)
        }
    }
}

function scrNTTEBeamCreate() {
    primary=true
    detached=false
    state=undefined
    ultra=false
    ring=false
    age=0
    life=8
    scale_goal=0.5
    beam_scale=0.5
    recent_targets=[]
    recent_times=[]
    points=[]
    angles=array_create(13,0)
    initialized=false
    typ=0
    spr_fade=-1
    damage=12
    mask_index=mskNone
}

function scrNTTEOwnsState(_p,_s) {
    if(scrNTTEFullMergedRuntimeStateHas(_p,true,_s) || scrNTTEFullMergedRuntimeStateHas(_p,false,_s)) return true;
    return instance_exists(_p) && is_struct(_s)
        && ((variable_instance_exists(_p,"ntte_state") && _p.ntte_state==_s)
        || (variable_instance_exists(_p,"bntte_state") && _p.bntte_state==_s))
}

function scrNTTEFireBeam(_w,_primary,_state) {
    var _beam=noone, _sustain=(_w==wep_ntte_quasar_rifle || _w==wep_ntte_ultra_quasar_rifle)
    if (_sustain) with (NTTEBeam) {
        if (creator==other.id && state==_state && !ring) _beam=id
    }
    if (!instance_exists(_beam)) {
        _beam=scr_projectile_create(x,y,NTTEBeam,gunangle,_w==wep_ntte_quasar_cannon ? 4:0)
        _beam.state=_state
        _beam.primary=_primary
        _beam.ultra=_w==wep_ntte_ultra_quasar_rifle
        _beam.ring=_w==wep_ntte_quasar_cannon
        _beam.scale_goal=_w==wep_ntte_quasar_blaster ? 0.5:(_beam.ultra ? 0.3:0.6)
        _beam.beam_scale=_beam.scale_goal
    }
    else _beam.scale_goal=min(_beam.ultra ? 3:1.25,_beam.scale_goal+(_beam.ultra ? 1/15:0.25))
    _beam.life=_beam.ring ? 120:(_sustain ? scr_weapon_get_load(_w)+1:8)
    snd_play(_beam.ultra ? sndUltraLaser:sndLaser,0.5)
}

function scrNTTEBeamStep() {
    if (lockstep_stop) return;
    if (variable_instance_exists(id,"ntte_albino_turn")) direction+=ntte_albino_turn*timescale
    age+=timescale
    life-=timescale
    if (!ring && !detached && (!instance_exists(creator) || creator.hp<=0 || !scrNTTEOwnsState(creator,state))) life=min(life,0)
    if (life<0) beam_scale=max(0,beam_scale-0.05*timescale)
    else beam_scale=lerp(beam_scale,scale_goal,min(1,0.1*timescale))
    if (beam_scale<=0) { instance_destroy(); return; }
    if (ring) {
        scrNTTEClearWalls(x,y,24*beam_scale)
        if (current_frame_active && (floor(age) mod 12)==0) {
            var _p=scr_projectile_create(x,y,NTTEBeam,random(360),0)
            _p.state=state
            _p.life=10
            _p.scale_goal=0.5
            _p.beam_scale=0.5
            _p.creator=noone // radial beams remain at their emitted origin
            _p.detached=true
            _p.primary=false
        }
    }
    else if (!detached && instance_exists(creator)) {
        x=creator.x+lengthdir_x(16,creator.gunangle)
        y=creator.y+lengthdir_y(16,creator.gunangle)-(primary ? 0:4)
        direction=angle_lerp(direction,creator.gunangle,(ultra ? 0.08:0.12)*timescale)
    }
    var _px=x,_py=y,_dir=direction, _width=(ultra ? 16:8)*beam_scale*power(1.2,scr_skill_get(mut_laser_brain))
    points=[[_px,_py]]
    if (!initialized) { initialized=true; angles=array_create(13,direction) }
    for(var _i=0;_i<13;++_i) {
        if (ring) _dir=direction+_i*30
        else {
            angles[_i]=angle_lerp(angles[_i],_dir,min(1,(0.08+_i*0.015)*timescale))
            _dir=angles[_i]
        }
        var _nx=_px+lengthdir_x(24,_dir),_ny=_py+lengthdir_y(24,_dir),
            _wall=collision_line(_px,_py,_nx,_ny,Wall,false,false)
        if (instance_exists(_wall) && !ring) {
            if (ultra && !instance_is(_wall,InvisiWall)) scrWallDestroy(_wall)
            else break
        }
        array_push(points,[_nx,_ny])
        if (current_frame_active) scrNTTELineDamage(_px,_py,_nx,_ny,_width,ultra ? 24:12,3)
        _px=_nx
        _py=_ny
    }
}

function scrNTTEBeamDraw() {
    var _spr=ultra ? sprNTTEUltraQuasarBeam:sprNTTEQuasarBeam,
        _count=array_length(points),_scale=beam_scale*power(1.2,scr_skill_get(mut_laser_brain))
    for(var _i=1;_i<_count;++_i) {
        var _a=points[_i-1],_b=points[_i],_d=point_direction(_a[0],_a[1],_b[0],_b[1])
        draw_sprite_ext(_spr,floor(current_frame*0.4),_a[0],_a[1],
            point_distance(_a[0],_a[1],_b[0],_b[1])/sprite_get_width(_spr),_scale,_d,c_white,1)
    }
    if (_count>1) {
        var _end=points[_count-1]
        draw_sprite_ext(ultra ? sprNTTEUltraQuasarBeamEnd:sprNTTEQuasarBeamEnd,
            floor(current_frame*0.4),_end[0],_end[1],_scale,_scale,direction,c_white,1)
    }
}

function scrNTTECoilCreate() {
    scrNTTECoilOriginalCreate()
}

function scrNTTECoilStep() {
    scrNTTECoilOriginalStep()
}

function scrNTTECoilDraw() {
    scrNTTECoilOriginalDraw()
}

function scrNTTEEnsureShield(_primary) {
    var _state=scrNTTEFullClamSlot(_primary);
    if(is_struct(_state)) return scrNTTEFullClamEnsure(_state);
    return noone;
}

function scrNTTEShieldCreate() {
    primary=true
    typ=0
    spr_fade=-1
    mask_index=mskNone
    recent_targets=[]
    recent_times=[]
    sprite_index=sprNTTEClamShield
    image_speed=0
    damage=12
}

function scrNTTEShieldStep() {
    if (lockstep_stop) return;
    if (!instance_exists(creator) || creator.hp<=0
        || (primary ? creator.wep:creator.bwep)!=wep_ntte_clam_shield
        || (!primary && creator.race!=Race.Steroids)) { instance_destroy(); return; }
    direction=creator.gunangle
    image_angle=direction
    x=creator.x+lengthdir_x(14,direction)
    y=creator.y+lengthdir_y(14,direction)-(primary ? 0:4)
    image_index=min(13,abs(primary ? creator.wkick:creator.bwkick))
    var _list=ds_list_create()
    collision_circle_list(x,y,16,projectile,false,true,_list,false)
    for(var _i=0;_i<ds_list_size(_list);++_i) {
        var _p=_list[| _i]
        if (!instance_exists(_p) || _p.team==team || _p.typ==0 || _p.speed<=0) continue
        if (abs(angle_difference(point_direction(creator.x,creator.y,_p.x,_p.y),direction))>85) continue
        if (_p.typ==1) {
            _p.direction=direction-clamp(angle_difference(_p.direction+180,direction),-40,40)
            _p.team=team
            _p.creator=creator
            _p.image_angle=_p.direction
        }
        else instance_destroy(_p)
        with (creator) motion_add(other.direction+180,0.5*timescale)
        snd_play(sndCrystalRicochet,1.2,0.5)
    }
    ds_list_destroy(_list)
}

function scrNTTESwingStep() {
    if (lockstep_stop) return;
    // Native Slash collisions supply ordinary deflection and wall interaction.
    if (kind==NTTESwingKind.Bubble || kind==NTTESwingKind.Energy) {
        var _list=ds_list_create()
        collision_rectangle_list(bbox_left,bbox_top,bbox_right,bbox_bottom,projectile,false,true,_list,false)
        for(var _i=0;_i<ds_list_size(_list);++_i) {
            var _t=_list[| _i]
            if (!instance_exists(_t) || _t.team==team || _t.typ==0) continue
            if (kind==NTTESwingKind.Bubble) {
                var _p=scrNTTEShot(NTTEKind.Bubble,direction,9)
                _p.life=30
            }
            else {
                var _p=scrNTTEShot(NTTEKind.Vlasma,direction,8,_t.damage>=12)
                _p.target=_t.creator
            }
            instance_destroy(_t)
        }
        ds_list_destroy(_list)
    }
}

function scrNTTESwingHit(_t) {
    if (lockstep_stop || !instance_exists(_t) || !scr_can_hit(_t,true)) return;
    var _hp=_t.hp,_maxhp=_t.max_hp,_object=_t.object_index,_x=_t.x,_y=_t.y,
        _clone=kind==NTTESwingKind.Clone && instance_is(_t,enemy) && !instance_is(_t,prop)
    if (!scr_projectile_hit(_t,damage,knockback_speed)) return;
    if (_clone && instance_exists(_t) && _t.hp<=0) {
        scrNTTECloneEnemy(_object,_x,_y,_hp)
    }
    if (kind==NTTESwingKind.Bone && instance_exists(_t) && _t.hp<=0 && !instance_is(_t,prop)) {
        scrNTTEFullScytheKillDrops(_t,_maxhp,_x,_y);
    }
}

function scrNTTEPickupStep() {
    if (lockstep_stop) return;
    age+=timescale
    if (age>900) { instance_destroy(); return; }
    var _p=instance_nearest(x,y,Player)
    if (!instance_exists(_p)) return;
    var _d=point_distance(x,y,_p.x,_p.y)
    if (_d<48) {
        x=lerp(x,_p.x,0.15*timescale)
        y=lerp(y,_p.y,0.15*timescale)
    }
    if (_d<12) {
        with (_p) {
            scrNTTEPlayerStep()
            if (other.pickup_kind==0) scrNTTEFullGiveBoneAmmo(other.amount)
            else ntte_red_ammo=min(9,ntte_red_ammo+other.amount)
            drawempty=30
        }
        snd_play(sndPickupDisappear)
        instance_destroy()
    }
}

function scrNTTECloneEnemy(_object,_x,_y,_hp) {
    // Run the actual native enemy AI, with team-aware target selection.
    var _c=instance_create(_x,_y,_object)
    if (!instance_exists(_c)) return;
    _c.hp=max(1,_hp)
    _c.team=team
    _c.raddrop=0
    _c.ntte_charmed=true
    _c.ntte_charm_time=current_frame+300
    _c.image_blend=make_color_rgb(190,110,225)
    var _guard=instance_create(_x,_y,NTTEClone)
    _guard.target=_c
    _guard.creator=creator
    _guard.life=300
    scrNTTEFX(sprNTTERedMegaSlash,_x,_y,0.5)
}

function scrNTTEArtifactImpact(_t) {
    switch (weapon) {
        case wep_ntte_ancient_artifact:
            var _proto=wep_rusty_revolver
            with (ProtoChest) _proto=wep
            if (instance_exists(creator)) with (creator) {
                var _px=x,_py=y,_oldangle=gunangle,_oldreload=reload,_oldcan=can_shoot,_oldw=wep,_oldstate=ntte_state
                x=other.x
                y=other.y
                gunangle=other.direction
                // Prototype chest cannot contain a quest artifact recursively.
                if (_proto<wep_ntte_ancient_artifact) {
                    wep=_proto
                    ntte_state=scrNTTENewState(_proto)
                    scrFire(_proto,false)
                }
                x=_px
                y=_py
                gunangle=_oldangle
                reload=_oldreload
                can_shoot=_oldcan
                wep=_oldw
                ntte_state=_oldstate
            }
            break
        case wep_ntte_guarded_artifact:
            var _last=noone
            for(var _i=-2;_i<=2;++_i) {
                var _p=scrNTTEShot(NTTEKind.Plasma,direction+_i*60,1.5)
                _p.tether=_last
                _last=_p
            }
            scrNTTEAreaDamage(x,y,40,12)
            break
        case wep_ntte_stolen_artifact:
            var _p=scr_projectile_create(x,y,NTTEBeam,direction+180,0)
            _p.creator=noone
            _p.detached=true
            _p.life=20+_t.size*6
            _p.scale_goal=1
            _p.beam_scale=1
            break
        case wep_ntte_missing_artifact:
            with (scr_projectile_create(x,y,PlasmaBig,direction,1.5)) team=other.team
            for(var _i=0;_i<4;++_i) {
                var _p=scrNTTEShot(NTTEKind.Vlasma,_i*90,8)
                _p.target=_t
            }
            for(var _i=0;_i<32;++_i) {
                var _f=instance_find(Floor,irandom(max(0,instance_number(Floor)-1)))
                if (instance_exists(_f) && point_distance(x,y,_f.x,_f.y)<192 && !position_meeting(_f.x+16,_f.y+16,Wall)) {
                    x=_f.x+16
                    y=_f.y+16
                    break
                }
            }
            break
    }
}

function scrNTTETunnelGenerate() {
    if (!instance_exists(GameCont) || !instance_exists(creator) || creator.hp<=0) return;
    // Native floor generation adds a connected side passage in the current area.
    // It deliberately does not reset GenCont or replace the active level.
    var _cx=round(x/32)*32,_cy=round(y/32)*32,_angle=round(direction/90)*90,
        _count=irandom_range(8,12)+(big ? 4:0),_new=[]
    for(var _i=0;_i<_count;++_i) {
        if (_i>1 && random(1)<0.25) _angle+=choose(-90,90)
        for(var _dx=-1;_dx<=1;++_dx) for(var _dy=-1;_dy<=1;++_dy) {
            var _fx=_cx+_dx*32,_fy=_cy+_dy*32
            if (!position_meeting(_fx+16,_fy+16,Floor)) {
                var _floor=instance_create(_fx,_fy,Floor)
                array_push(_new,_floor)
            }
            scrNTTEClearWalls(_fx+16,_fy+16,23)
            with (Top) if (point_distance(x,y,_fx+16,_fy+16)<36) instance_destroy()
        }
        _cx+=round(lengthdir_x(32,_angle))
        _cy+=round(lengthdir_y(32,_angle))
    }
    for(var _i=0;_i<array_length(_new);++_i) if (instance_exists(_new[_i])) with (_new[_i]) mcr_floor_make_walls;
    for(var _i=0;_i<array_length(_new);++_i) if (instance_exists(_new[_i])) with (_new[_i]) mcr_floor_create_tops;
    if (!array_length(_new)) return;
    var _end=_new[max(0,array_length(_new)-5)]
    if (instance_exists(_end)) {
        var _chest=choose(AmmoChest,WeaponChest,RadChest,HealthChest)
        instance_create(_end.x+16,_end.y+16,_chest)
        repeat(1+max(0,round(scr_skill_get(mut_open_mind)))) {
            var _f=_new[irandom(array_length(_new)-1)]
            if (instance_exists(_f) && point_distance(_f.x,_f.y,creator.x,creator.y)>96) instance_create(_f.x+16,_f.y+16,Bandit)
        }
    }
    scrNTTEFX(sprNTTECrystalHeartBulletHit,x,y,2)
    snd_play(sndHyperCrystalSearch,0.7)
}

function scrNTTEStartSalvo(_p) {
    if (!instance_exists(_p) || _p.burst_left<=0) return;
    var _s=scr_damage_create(_p.x,_p.y,NTTESalvo)
    _s.creator=_p.creator
    _s.team=_p.team
    _s.kind=_p.kind
    _s.remaining=_p.burst_left
    _s.interval=_p.burst_delay
    _s.wait=_s.interval
    _s.primary=_p.burst_primary
    _s.state=_p.state
    _p.burst_left=0
}

function scrNTTESalvoStep() {
    if (lockstep_stop) return;
    if (!instance_exists(creator) || creator.hp<=0) { instance_destroy(); return; }
    wait-=timescale
    if (wait>0) return;
    wait+=interval
    x=creator.x
    y=creator.y-(primary ? 0:4)
    var _p=scrNTTEShot(kind,creator.gunangle+orandom(kind==NTTEKind.Plasma ? 17:6),kind==NTTEKind.Plasma ? 4.4:9)
    _p.state=state
    if (kind==NTTEKind.Plasma) {
        var _last=noone
        with (NTTEAttack) if (creator==other.creator && kind==NTTEKind.Plasma && id!=_p && state==other.state) _last=id
        _p.tether=_last
    }
    if (--remaining<=0) instance_destroy()
}

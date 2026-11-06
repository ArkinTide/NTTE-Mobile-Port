function scrNTTEFullPetTwinsWhiteSpark() {
    var _fx=scrNTTEFullPetEffect([x,6],[y,6],[90,random_range(0.2,0.5)],LaserCharge)
    if(instance_exists(_fx)) with(_fx) {
        sprite_index=other.spr_fx_star
        image_index=choose(0,irandom(image_number-1))
        depth=other.depth-1; alarm[0]=random_range(15,30)
    }
}
function scrNTTEFullPetTwinsRedSpark() {
    with(instance_create(x+orandom(6),y+orandom(6),LaserCharge)) {
        sprite_index=other.spr_fx_star; depth=other.depth-1
        alarm[0]=random_range(10,20)
        motion_set(random(360),random(1)*timescale)
        image_speed=0.4*timescale
    }
}
// Source petlib.Twins. Two linked companions orbit their leader and route hostile
// projectiles through one another.  The pair intentionally remains one pet slot.
function scrNTTEFullPetTwinsSkin() {
    var _white=(bskin==1),_old=spr_idle
    spr_idle=scrNTTERefSprite(_white ? "PetTwinsWhite" : "PetTwinsRed")
    spr_walk=spr_idle; spr_hurt=spr_idle
    spr_icon=scrNTTERefSprite(instance_exists(leader) ? (_white ? "PetTwinsWhiteIcon":"PetTwinsRedIcon") : "PetTwinsIcon")
    spr_fx_arrow=scrNTTERefSprite(_white ? "PetTwinsWhiteEffect":"PetTwinsRedEffect")
    spr_fx_trail=scrNTTERefSprite(_white ? "CrystalWhiteTrail":"CrystalRedTrail")
    spr_fx_ring=_white ? sprImpactWrists:scrNTTERefSprite("SquidCharge")
    spr_fx_star=_white ? sprSpiralStar:sprLaserCharge
    if(sprite_index==_old) sprite_index=spr_idle
    if(instance_exists(prompt)) prompt.sprite_index=spr_icon
}
function scrNTTEFullPetTwinsCreate() {
    spr_idle=scrNTTERefSprite("PetTwinsRed"); spr_walk=spr_idle; spr_hurt=spr_idle
    spr_icon=scrNTTERefSprite("PetTwinsIcon"); spr_shadow_y=2
    mask_index=mskBandit; friction=0.1*timescale*timescale; minspeed=0.2; maxspeed=3; walkspeed=0.3
    spr_bubble=-1; spr_bubble_pop=-1; right=1; depth=-3
    // A stale physical partner reference means "already paired" in petlib.
    // The flag retains that distinction only after portable save restoration.
    ntte_twins_missing_partner=false
    array_push(history,"partner","ntte_twins_missing_partner")
    path_wall=[]; partner=noone; orbit_pull=0; orbit_dis=26; orbit_speed=3; flash=0; walled=false
    hitid=[spr_idle,"TWINS"]; stat.diverted=scrNTTEFullValue(stat,"diverted",0)
    hooks={skin:method(id,scrNTTEFullPetTwinsSkin),step:method(id,scrNTTEFullPetTwinsStep),alarm:method(id,scrNTTEFullPetTwinsAlarm),draw:method(id,scrNTTEFullPetTwinsDraw)}
}
function scrNTTEFullPetTwinsEffect(_x,_y,_len,_dir) {
    var _fx=instance_create(_x+lengthdir_x(_len,_dir),_y+lengthdir_y(_len,_dir),BulletHit)
    _fx.sprite_index=spr_fx_arrow; _fx.image_angle=_dir; _fx.depth=depth-1
}
function scrNTTEFullPetTwinsStep() {
    var _self=id
    if(flash>0) flash-=timescale
    if(partner==noone && !ntte_twins_missing_partner) {
        partner=scrNTTEFullPetCreate(x,y,"Twins")
        with(partner) { partner=other; team=other.team; stat_found=other.stat_found; bskin=1-other.bskin; scrNTTEFullPetSetSkin(id,bskin) }
    }
    if(instance_exists(leader) && instance_exists(partner)) {
        if(array_get_index(scrNTTEFullValue(leader,"ntte_pet",[]),id)>=0) {
            partner.leader=leader; partner.can_take=can_take; partner.stat_found=stat_found; partner.persistent=persistent
        } else { leader=partner.leader; can_take=partner.can_take; stat_found=partner.stat_found; persistent=partner.persistent }
    }
    if(instance_exists(leader)) {
        var _list=[]
        with(NTTEFullPet) if(pet=="Twins" && leader==_self.leader && instance_exists(partner)) array_push(_list,id)
        var _idx=array_get_index(_list,_self); if(_idx<0) _idx=0
        var _count=max(1,array_length(_list)),_a=360*_idx/_count+orbit_speed*scrNTTEFullValue(leader,"ntte_twins_orbit_wave",0)
        var _tx=leader.x+lengthdir_x(orbit_dis,_a),_ty=leader.y+lengthdir_y(orbit_dis,_a)
        if(orbit_pull>0) {
            var _t=1-power(1-min(1,orbit_pull),timescale)
            x=lerp(x,_tx,_t); y=lerp(y,_ty,_t)
            var _distance=point_distance(x,y,leader.x,leader.y)
            if(_distance>orbit_dis*2) { var _out=point_direction(leader.x,leader.y,x,y); x=leader.x+lengthdir_x(orbit_dis*2,_out); y=leader.y+lengthdir_y(orbit_dis*2,_out) }
        }
        orbit_pull=min(1,orbit_pull+timescale/6)
        path_wall=[]
    } else {
        orbit_pull=0; speed=max(speed,(minspeed+0.1)*timescale); path_wall=[Wall]
        if(place_meeting(x+hspeed,y+vspeed,Wall)) { if(place_meeting(x+hspeed,y,Wall)) hspeed*=-1; if(place_meeting(x,y+vspeed,Wall)) vspeed*=-1 }
    }
    // While inside a wall the original pet is hidden until a safe floor cell is found.
    if(walled) {
        spr_shadow=mskNone
        if(!instance_exists(leader)) scrNTTEFullPetTwinsUnwall()
        if(!place_meeting(x,y,Wall) && place_meeting(x,y,Floor)) {
            walled=false; spr_shadow=shd24; flash=2
            snd_play(sndCursedReminder,0.6+orandom(0.1),0.3)
            repeat(5) { var _trail=instance_create(x,y,NTTEFullCrystTrail); _trail.sprite_index=spr_fx_trail; _trail.speed*=2/3 }
            var _fx=instance_create(x,y,ThrowHit); _fx.sprite_index=spr_fx_ring
            _fx.image_xscale=0.6; _fx.image_yscale=0.6; _fx.image_speed=0.4*timescale; _fx.depth=depth-1
        }
    } else {
        with(projectile) if(instance_exists(_self) && team!=_self.team && place_meeting(x,y,_self)) scrNTTEFullPetTwinsDivert(id,_self)
        if(position_meeting(x,y,Wall)) {
            walled=true; spr_shadow=mskNone; flash=2; snd_play(sndCursedChest,2+orandom(0.1),0.3)
            var _fx=instance_create(x,y,ThrowHit); _fx.sprite_index=spr_fx_ring
            _fx.image_xscale=2/3; _fx.image_yscale=2/3; _fx.image_speed=0.4*timescale; _fx.depth=depth-1
        }
    }
    if(!walled && instance_exists(leader) && place_meeting(x,y,hitme)) with(hitme) if(team!=_self.team && team!=team_none
        && !instance_is(id,Player) && !instance_is(id,prop) && place_meeting(x,y,_self)) {
        var _target=id
        with(_self) if(scr_can_hit(_target,true)) {
            repeat(3) { var _trail=instance_create(x,y,NTTEFullCrystTrail); _trail.sprite_index=spr_fx_trail; _trail.speed*=2/3 }
            _target.direction=point_direction(leader.x,leader.y,_target.x,_target.y)
            scr_projectile_hit(_target,1)
        }
    }
    if(!walled) {
        if(bskin==1) {
            if(random(1)<1-power(19/20,timescale)) {
                scrNTTEFullPetTwinsWhiteSpark()
            }
            if(random(1)<1-power(24/25,timescale)) {
                var _fx=instance_create(x+orandom(6),y+orandom(6),BulletHit)
                _fx.sprite_index=sprThrowHit; _fx.image_xscale=0.2+random(0.3); _fx.image_yscale=_fx.image_xscale; _fx.depth=depth-1
            }
        } else if(random(1)<1-power(29/30,timescale)) {
            scrNTTEFullPetTwinsRedSpark()
        }
    }
}
function scrNTTEFullPetTwinsUnwall() {
    var _floors=scrNTTEFullInstances(Floor),_nearest=noone,_best=infinity
    for(var _i=0;_i<array_length(_floors);++_i) {
        var _f=_floors[_i],_dx=x-clamp(x,_f.bbox_left,_f.bbox_right+1),_dy=y-clamp(y,_f.bbox_top,_f.bbox_bottom+1),_d=_dx*_dx+_dy*_dy
        if(_d<_best) { _best=_d; _nearest=_f }
    }
    if(instance_exists(_nearest)) { x=(_nearest.bbox_left+_nearest.bbox_right+1)/2; y=(_nearest.bbox_top+_nearest.bbox_bottom+1)/2 }
    var _start=direction+180,_require_floor=place_meeting(xprevious,yprevious,Floor)
    if(x!=xprevious || y!=yprevious) _start=point_direction(x,y,xprevious,yprevious)
    var _ox=x,_oy=y,_radius=0,_found=false
    while(true) {
        var _increment=360/max(1,4*_radius),_a=_start
        repeat(ceil(360/_increment)) {
            x=_ox+lengthdir_x(_radius,_a); y=_oy+lengthdir_y(_radius,_a)
            if(!place_meeting(x,y,Wall) && (!_require_floor || position_meeting(x,y,Floor) || place_meeting(x,y,Floor))) { _found=true; break }
            x=_ox; y=_oy; _a+=_increment
        }
        if(_found || _radius>=64) break
        _radius=min(64,_radius+clamp(_radius,1,4))
    }
    if(_found) { xprevious=x; yprevious=y }
    return _found
}
function scrNTTEFullPetTwinsDivert(_shot,_pet) {
    if(!instance_exists(_shot) || !instance_exists(_pet)) return noone
    var _dst=_pet.partner
    var _kind=variable_instance_get(_shot,"object_index"),_new=_shot
    var _lightning=instance_is(_shot,Lightning) || instance_is(_shot,NTTEFullTrenchLightning)
    var _laser=instance_is(_shot,Laser)
    if(_shot.typ==0 && !_laser && !_lightning) return noone
    // Source clones the laser before diversion. The hostile original beam
    // remains in place, including when no partner or a walled exit absorbs
    // the clone. Ordinary projectiles move rather than duplicating.
    if(_laser) _new=scrNTTEFullOrchidClone(_shot)
    var _entryx=(_pet.x+_shot.x)/2,_entryy=(_pet.y+_shot.y)/2,_entrydir=_shot.direction
    _pet.flash=6; _pet.orbit_pull=-1
    if(instance_exists(_pet.leader)) _pet.stat.diverted+=1
    with(_pet) scrNTTEFullPetTwinsEffect(_entryx,_entryy,-6,_entrydir)
    snd_play(sndCrystalJuggernaut,1.6+random(0.8),1)
    if(!instance_exists(_dst)) { instance_destroy(_new,false); return noone }
    if(_dst.walled) {
        snd_play(sndHitWall,0.8+orandom(0.1),1.3)
        var _fx=instance_create(_dst.x,_dst.y,ThrowHit); _fx.image_xscale=2/3; _fx.image_yscale=2/3; _fx.depth=-7
        instance_destroy(_new,false); return noone
    }
    // Native lightning is generated synchronously. The chain metadata preserves
    // the original earliest overlapping node and removes its forward tail.
    if(_lightning) {
        var _chain=scrNTTEFullValue(_shot,"ntte_prism_chain",[_shot]),_idx=array_get_index(_chain,_shot)
        if(_idx<0) _idx=0
        while(_idx>0 && instance_exists(_chain[_idx-1])) {
            var _previous=_chain[_idx-1],_overlap=false
            with(_previous) _overlap=place_meeting(x,y,_pet)
            if(!_overlap) break
            --_idx
        }
        _new=_chain[_idx]
        for(var _i=_idx+1;_i<array_length(_chain);++_i) if(instance_exists(_chain[_i])) instance_destroy(_chain[_i],false)
        _shot=_new
    }
    var _origin_x=_shot.xstart,_origin_y=_shot.ystart,_direction=point_direction(_dst.x,_dst.y,_origin_x,_origin_y)
    _pet.orbit_pull=-1
    if(!collision_line(_dst.x,_dst.y,_origin_x,_origin_y,Wall,false,false)) _dst.orbit_pull=0
    if(!instance_exists(_new)) return noone
    with(_new) {
        x=_dst.x; y=_dst.y; xprevious=x; yprevious=y; xstart=x; ystart=y
        var _offset=angle_difference(_direction,direction)
        if(image_angle!=0 || image_angle==direction) image_angle+=_offset
        direction+=_offset
        team=_dst.team; hitid=_dst.hitid; twins_deflected=true; deflected=true
        if(variable_instance_exists(id,"zspeed")) zspeed*=-1
        if(variable_instance_exists(id,"zvel")) zvel*=-1
        scrNTTEFullPetTwinsTeam(id,_dst.team)
        if(_laser) {
            var _class=object_index,_creator=creator,_team=team,_self=id,_previous=noone
            with(projectile) if(id!=_self && object_index==_class && creator==_creator && team==_team && scrNTTEFullValue(id,"deflected",false)) _previous=id
            if(instance_exists(_previous)) instance_destroy(_previous,false)
            image_xscale=1; event_perform(ev_alarm,0)
        }
    }
    if(_lightning) {
        var _remaining=scrNTTEFullValue(_new,"ntte_prism_remaining",scrNTTEFullValue(_new,"ntte_full_emit_ammo",0))
        if(_remaining>0) {
            var _first=noone,_damage=_new.damage,_hitid=_new.hitid,_owner=_new.creator
            with(_new) _first=scrNTTEFullTrenchDischarge(x,y,direction,_remaining,_dst.team!=team_player)
            with(NTTEFullTrenchLightning) if(id>=_first) { team=_dst.team; damage=_damage; hitid=_hitid; creator=_owner; deflected=true }
            instance_destroy(_new,false); _new=_first
        }
    }
    if(_new!=_shot && !_laser) instance_destroy(_shot,false)
    _dst.flash=6
    with(_dst) scrNTTEFullPetTwinsEffect(x,y,12,_direction)
    var _snd=snd_play(sndLaserCrystalDeath,0.8+orandom(0.1),0.5); if(_snd>=0) audio_sound_set_track_position(_snd,0.4)
    return _new
}
// Original telib.team_instance_sprite rows that use native Epsilon objects.
function scrNTTEFullPetTwinsTeam(_inst,_team) {
    var _friendly=(_team==team_player)
    var _rows=[
        [EnemyLaser,Laser,sprEnemyLaser,sprLaser],
        [EnemyLightning,Lightning,sprEnemyLightning,sprLightning],
        [EnemyBullet1,AllyBullet,sprEnemyBullet1,sprAllyBullet],
        [EnemyBullet3,Bullet2,sprEBullet3,sprBullet2],
        [EnemyFlak,FlakBullet,sprEFlak,sprFlakBullet],
        [LHBouncer,BouncerBullet,sprLHBouncer,sprBouncerBullet]
    ]
    with(_inst) for(var _i=0;_i<array_length(_rows);++_i) {
        var _r=_rows[_i]
        if(object_index==_r[0] || object_index==_r[1]) {
            var _target=_r[_friendly ? 1:0]
            if(object_index!=_target) instance_change(_target,false)
            // telib.team_instance_sprite initializes converted enemy shells
            // without granting the player's close-range bonus damage.
            if(_friendly && _r[0]==EnemyBullet3) bonus=false
            sprite_index=_r[_friendly ? 3:2]
            if(instance_is(id,Laser)) { spr_start=_friendly ? sprLaserStart:sprEnemyLaserStart; spr_end=_friendly ? sprLaserEnd:sprEnemyLaserEnd }
            break
        }
    }
    return _inst
}
function scrNTTEFullPetTwinsAlarm(_dir,_dis) {
    if(!instance_exists(leader)) {
        if(instance_exists(partner)) {
            var _toward=point_direction(x,y,partner.x,partner.y)
            if(point_distance(x,y,partner.x,partner.y)<48 || irandom(4)==0) scrNTTEFullPetWalk(_toward+90+orandom(30),5)
            else scrNTTEFullPetWalk(_toward+orandom(10),random_range(5,15))
        } else scrNTTEFullPetWalk(random(360),random_range(10,30))
        return walk+random(10)
    }
    return 30
}
function scrNTTEFullPetTwinsDraw(_spr,_img,_x,_y,_xsc,_ysc,_ang,_col,_alp) {
    if(!walled || flash>0) {
        if(flash>0) gpu_set_fog(true,image_blend,0,0)
        draw_sprite_ext(_spr,_img,_x,_y,_xsc,_ysc,_ang,_col,_alp)
        if(flash>0) gpu_set_fog(false,0,0,0)
    }
}
function scrNTTEFullPetTwinsTests() {
    var _p=instance_find(Player,0),_old=scrNTTEFullValue(_p,"ntte_pet",[]),_oldmax=scrNTTEFullValue(_p,"ntte_pet_max",undefined)
    _p.ntte_pet=[]; _p.ntte_pet_max=2
    var _a=scrNTTEFullPetCreate(_p.x,_p.y,"Twins"); scrNTTEFullPetTake(_a,_p); with(_a) scrNTTEFullPetTwinsStep()
    assert(instance_exists(_a.partner) && _a.partner.bskin!=_a.bskin,"Twins failed to create opposite-skin partner")
    scrNTTEFullPetTwinsSparkSourceTests(_a)
    var _shot=instance_create(_a.x,_a.y,EnemyLaser); _shot.team=team_enemy; _shot.creator=instance_find(Bandit,0); _shot.speed=1
    _a.orbit_pull=-1
    with(_a) scrNTTEFullPetTwinsStep()
    assert(_a.stat.diverted>=1,"Twins failed to divert hostile laser")
    assert(instance_exists(_shot) && _shot.team==team_enemy && !scrNTTEFullValue(_shot,"deflected",false),"Twins consumed/modified the original hostile laser rather than its source clone")
    var _first=scrNTTEFullPetTwinsDivert(_shot,_a)
    var _second=scrNTTEFullPetTwinsDivert(_shot,_a)
    assert(instance_exists(_second) && !instance_exists(_first) && instance_exists(_shot),"Twins repeated beam diversion leaked the previous reflected beam")
    _a.partner.walled=true
    assert(scrNTTEFullPetTwinsDivert(_shot,_a)==noone && instance_exists(_shot),"Twins walled exit deleted the original hostile laser")
    _a.partner.walled=false
    if(instance_exists(_second)) instance_destroy(_second,false)
    if(instance_exists(_shot)) instance_destroy(_shot,false)
    if(instance_exists(_a.partner)) instance_destroy(_a.partner,false); instance_destroy(_a,false)
    _p.ntte_pet=_old; _p.ntte_pet_max=_oldmax
    scrNTTESmokeLog("SYSTEMS PET TWINS: linked opposite skins/orbit and hostile laser diversion OK")
}

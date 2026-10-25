// Source tecoast.mod.gml1402..1507,1748..1854,5616..5736.
// Genuine independent rope state; endpoints may be arbitrary enemy instances,
// physical harpoons, or attached BoltStick descendants. No NTTEAttack.kind use.
function scrNTTEFullHarpoonRope(_link1,_link2) {
    var _rope={link1:_link1,link2:_link2,length:0,harpoon_stuck:false,
        break_force:0,break_timer:45+random(15),creator:noone,broken:false}
    if(!variable_instance_exists(GameCont,"ntte_harpoon_rope")) GameCont.ntte_harpoon_rope=[]
    array_push(GameCont.ntte_harpoon_rope,_rope)
    var _links=[_link1,_link2]
    for(var _i=0;_i<2;++_i) if(instance_exists(_links[_i]) && instance_is(_links[_i],NTTEFullHarpoon)) {
        var _link=_links[_i];array_push(_link.rope,_rope)
        // Preserve the literal old source condition, rather than fabricating
        // ownership from the firing Player when the original did not.
        if(!instance_exists(_link.creator)) _rope.creator=_link.creator
    }
    var _controller=instance_create(0,0,NTTEFullHarpoonRope)
    _controller.ntte_rope=_rope;_rope.controller=_controller
    return _rope
}
function scrNTTEFullHarpoonUnrope(_rope) {
    if(_rope.broken==true) return;
    _rope.broken=true
    if(instance_exists(GameCont) && variable_instance_exists(GameCont,"ntte_harpoon_rope"))
        GameCont.ntte_harpoon_rope=scrNTTEFullMergedEffectsRemove(GameCont.ntte_harpoon_rope,_rope)
    var _links=[_rope.link1,_rope.link2]
    for(var _i=0;_i<2;++_i) if(instance_exists(_links[_i])) {
        var _link=_links[_i]
        if(instance_is(_link,NTTEFullHarpoon)) _link.pickup=true
        else if(instance_is(_link,NTTEFullHarpoonStick)) {
            var _pickup=instance_create(_link.x,_link.y,NTTEFullHarpoonPickup)
            _pickup.image_yscale=_link.image_yscale;_pickup.image_angle=_link.image_angle
            _pickup.target=_link.target
            instance_destroy(_link)
        }
    }
    if(instance_exists(_rope.controller)) instance_destroy(_rope.controller,false)
}
function scrNTTEFullHarpoonRopeStep() {
    if(lockstep_stop || !is_struct(ntte_rope)) return;
    var _rope=ntte_rope,_a=_rope.link1,_b=_rope.link2
    if(!instance_exists(_a) || !instance_exists(_b)) { scrNTTEFullHarpoonUnrope(_rope);return; }
    if(_rope.broken<0) _rope.length=0
    var _excess=point_distance(_a.x,_a.y,_b.x,_b.y)-_rope.length,
        _dir=point_direction(_a.x,_a.y,_b.x,_b.y),_links=[_a,_b]
    if(_excess>0) for(var _i=0;_i<2;++_i) {
        var _link=_links[_i],_inst=noone
        if(instance_is(_link,projectile)) continue
        if(instance_is(_link,BoltStick)) {
            if(_link.pull_speed!=0 && !instance_is(_link.target,becomenemy)) _inst=_link.target
        }
        else if(_a!=_b && ((!instance_is(_link,prop) && scrNTTEFullValue(_link,"team",team_none)!=team_none)
            || instance_is(_link,RadChest) || instance_is(_link,Car) || instance_is(_link,CarVenus)
            || instance_is(_link,CarVenusFixed))) _inst=_link
        if(instance_exists(_inst)) {
            var _pull=instance_is(_inst,Player)?0.5:scrNTTEFullValue(_link,"pull_speed",2),
                _drag=min(_excess/3,10/(max(scrNTTEFullValue(_inst,"size",1),0.5)*2)),_angle=_dir+_i*180
            // NTT hspeed/vspeed are logical fields; direct x/y drag is already
            // physical in the source. Do not reuse wall-clamped generic rope.
            with(_inst) {
                hspeed+=lengthdir_x(_pull*timescale,_angle);vspeed+=lengthdir_y(_pull*timescale,_angle)
                x+=lengthdir_x(_drag,_angle);y+=lengthdir_y(_drag,_angle)
            }
        }
    }
    depth=instance_exists(collision_line(_a.x,_a.y,_b.x,_b.y,Wall,false,false))?-9:1
    _rope.break_force=max(_excess,0)
    if(_rope.break_timer<=0 || _rope.break_force>1000) {
        if(_rope.break_force>100 || (_rope.broken<0 && _rope.length<=1)) {
            if(_rope.broken>=0) snd_play(sndHammerHeadEnd,2)
            scrNTTEFullHarpoonUnrope(_rope)
        }
    }
    else _rope.break_timer-=timescale
}
function scrNTTEFullHarpoonRopeDraw() {
    if(!is_struct(ntte_rope)) return;
    var _r=ntte_rope,_a=_r.link1,_b=_r.link2
    if(!instance_exists(_a) || !instance_exists(_b)) return;
    var _ay=_a.y-abs(scrNTTEFullValue(_a,"z",0)),_by=_b.y-abs(scrNTTEFullValue(_b,"z",0)),
        _distance=point_distance(_a.x,_ay,_b.x,_by),_width=clamp(_r.length/max(0.0001,_distance),0.1,2),
        _color=merge_color(c_white,c_red,(0.25+clamp(0.5-_r.break_timer/15,0,0.5))*clamp(_r.break_force/100,0,1)),
        _old=draw_get_color()
    if(_r.break_timer>0) _width+=(max(1,_width)-_width)*min(_r.break_timer/15,1)
    draw_set_color(_color);draw_line_width(_a.x,_ay,_b.x,_by,_width);draw_set_color(_old)
}
function scrNTTEFullMergedHarpoonHit() {
    if(!scrNTTEFullMergedProjectileCanHit(other.id) || other.hp<=damage) return;
    var _victim=other.id,_max=96,_target=noone,_source_team=team,_candidates=scrNTTEFullInstances(hitme),
        _chests=scrNTTEFullInstances(chestprop)
    for(var _i=0;_i<array_length(_chests);++_i) if(array_get_index(_candidates,_chests[_i])<0) array_push(_candidates,_chests[_i])
    for(var _i=0;_i<array_length(_candidates);++_i) {
        var _candidate=_candidates[_i]
        if(_candidate==_victim || scrNTTEFullValue(_candidate,"team",team_none)==_source_team) continue
        var _distance=point_distance(_candidate.x,_candidate.y,_victim.x,_victim.y)
        if(_distance<_max && !collision_line(_candidate.x,_candidate.y,_victim.x,_victim.y,Wall,false,false)) {
            _max=_distance;_target=_candidate
        }
    }
    if(!instance_exists(_target)) return;
    var _ropes=scrNTTEFullValue(GameCont,"ntte_harpoon_rope",[])
    for(var _i=0;_i<array_length(_ropes);++_i) {
        var _r=_ropes[_i]
        if((_r.link1==_victim && _r.link2==_target) || (_r.link1==_target && _r.link2==_victim)) return;
    }
    var _rope=scrNTTEFullHarpoonRope(_victim,_target)
    _rope.length=_max
}
function scrNTTEFullMergedNetFire(_at,_info) { _info.ammo_type=scr_weapon_get_type(_at.wep) }
function scrNTTEFullMergedNetSetup(_list,_info) {
    for(var _i=0;_i<array_length(_list);++_i) if(instance_exists(_list[_i])) {
        _list[_i].temerge_net_can_fire=[true]
        _list[_i].temerge_net_ammo_type=_info.ammo_type
    }
}
function scrNTTEFullMergedNetHit() {
    if(temerge_net_can_fire[0] && scr_can_hit(other.id) && other.hp>0) {
        scrNTTEFullMergedNetDestroy()
        temerge_net_can_fire[0]=false
    }
}
function scrNTTEFullMergedNetDestroy() {
    if(!temerge_net_can_fire[0]) return;
    var _num=min(damage*0.4*(knockback_speed/timescale>=3?1:0.4),120)
    _num=floor(_num)+(random(1)<frac(_num))
    if(_num<=0) return;
    var _angle=random(360),_spd=22,_target=id==other.id?noone:other.id
    for(var _dir=_angle;_dir<_angle+360;_dir+=360/_num) {
        var _off=0
        if(instance_exists(_target)) {
            var _near=noone,_best=infinity,_px=x+lengthdir_x(3*_spd,_dir),_py=y+lengthdir_y(3*_spd,_dir),_team=team
            with(enemy) if(team!=_team && id!=_target) {
                var _distance=point_distance(x,y,_px,_py)
                if(_distance<_best) {_best=_distance;_near=id}
            }
            if(instance_exists(_near) && !collision_line(_near.x,_near.y,x,y,Wall,false,false)) {
                _off=angle_difference(point_direction(x,y,_near.x,_near.y),_dir)
                if(abs(_off)>=180/_num) _off=0
            }
            var _harpoon=scrNTTEFullMergedBasicProjectileCreate(x,y,NTTEFullHarpoon,_dir+_off,_spd)
            with(_harpoon) move_contact_solid(direction,8)
            scrNTTEFullHarpoonRope(_harpoon,_target)
            _harpoon.ammo_type=temerge_net_ammo_type;_harpoon.can_temerge=false
        }
        var _fx=instance_create(x,y,MeleeHitWall)
        with(_fx) {motion_add(_dir+_off,random(2)*timescale);image_angle=direction+180;image_speed=0.6*timescale;image_yscale=2/3}
    }
    if(instance_exists(_target)) snd_play_hit(_num>1?sndSuperSplinterGun:sndCrossbow,0.2)
    scrNTTEFullMergedBasicSoundAt(x,y,sndGrenadeRifle,1.2+orandom(0.1),instance_exists(_target)?1:0.5,64)
    repeat(max(3,_num)) scrNTTEFullMergedStockFX(x,y,1+random(2),Dust)
    scrNTTEFullTrenchShake(x,y,2*_num)
}
function scrNTTEFullMergedCustomBind(_shot,_kind) {
    if(!instance_exists(_shot)) return;
    switch(_kind) {
        case "Harpoon":_shot.temerge_on_hit=scrNTTEFullMergedHarpoonHit;break
        case "NetNade":
            _shot.temerge_on_fire=scrNTTEFullMergedNetFire;_shot.temerge_on_setup=scrNTTEFullMergedNetSetup
            _shot.temerge_on_hit=scrNTTEFullMergedNetHit;_shot.temerge_on_destroy=scrNTTEFullMergedNetDestroy
            break
        case "BatDisc":_shot.temerge_on_fire=scrNTTEFullMergedCustomKeepFire;break
        case "ThrownWep":_shot.temerge_on_fire=scrNTTEFullMergedThrownWeaponFire;break
    }
}
function scrNTTEFullMergedCustomKeepFire(_at=undefined,_info=undefined) {temerge_can_delete=false}
function scrNTTEFullMergedThrownWeaponFire(_at,_info=undefined) {
    wep=scrNTTEFullWeaponMerge(wep,_at.wep)
    sprite_index=scr_weapon_get_sprite(wep)
    temerge_can_delete=false
}

// Real source objects used by Net merged payloads and the native weapon bridge.
function scrNTTEFullHarpoonCreate() {
    sprite_index=scrNTTERefSprite("Harpoon");image_speed=0;mask_index=mskBolt
    creator=noone;target=noone;damage=8;knockback_speed=8*timescale;typ=1
    rope=[];corpses=[];pickup=false;ammo_type=Ammo.Bolts;setup=true
    scrNTTEFullMergedCustomBind(id,"Harpoon")
}
function scrNTTEFullHarpoonStep() {
    if(lockstep_stop) return;
    // Preserve the original skewer list: no corpse can be owned by two spears.
    for(var _i=array_length(corpses)-1;_i>=0;--_i) {
        var _corpse=corpses[_i]
        if(instance_exists(_corpse) && _corpse.speed>0) {
            if(speed>0) {
                _corpse.x+=(x-_corpse.x)*0.3*timescale;_corpse.y+=(y-_corpse.y)*0.3*timescale
                _corpse.hspeed=hspeed;_corpse.vspeed=vspeed
                _corpse.xprevious=_corpse.x+_corpse.hspeed;_corpse.yprevious=_corpse.y+_corpse.vspeed
                _corpse.image_speed=0.4*timescale;_corpse.image_index=1;_corpse.depth=depth-1
            }
            else {_corpse.depth=1;if(_corpse.speed>5*timescale) {_corpse.speed=(5-random(1))*timescale;_corpse.direction+=orandom(80)}}
        }
        else {if(instance_exists(_corpse)) _corpse.depth=1;array_delete(corpses,_i,1)}
    }
    if(speed>0) {
        for(var _i=0;_i<array_length(rope);++_i) {
            var _r=rope[_i]
            if(!_r.harpoon_stuck && instance_exists(_r.link1) && instance_exists(_r.link2))
                _r.length=point_distance(_r.link1.x,_r.link1.y,_r.link2.x,_r.link2.y)
        }
        var _marrow=scr_skill_get(mut_bolt_marrow),_nearest=noone,_best=infinity,_team=team,_void=asset_get_index("sprVoid")
        if(_marrow>0) {
            with(hitme) if(team!=_team && team!=team_none && mask_index!=mskNone && (_void<0 || mask_index!=_void)) {
                var _distance=point_distance(x,y,other.x,other.y)
                if(_distance<_best) {_best=_distance;_nearest=id}
            }
            if(instance_exists(_nearest) && distance_to_object(_nearest)<16*_marrow && !place_meeting(x,y,_nearest)
                && !collision_line(x,y,_nearest.x,_nearest.y,Wall,false,false)) {
                direction=point_direction(x,y,_nearest.x,_nearest.y);image_angle=direction
            }
        }
        var _speared=scrNTTEFullInstances(Corpse)
        for(var _i=0;_i<array_length(_speared);++_i) {
            var _corpse=_speared[_i]
            if(_corpse.speed<=timescale || _corpse.mask_index==-1 || !place_meeting(x,y,_corpse)
                || array_get_index(corpses,_corpse)>=0 || sprite_get_width(_corpse.sprite_index)>=64 || sprite_get_height(_corpse.sprite_index)>=64) continue
            var _can=true,_self=id
            with(NTTEFullHarpoon) if(id!=_self && array_get_index(corpses,_corpse)>=0) {_can=false;break}
            if(_can) {
                array_push(corpses,_corpse)
                if(hspeed!=0) _corpse.image_xscale=-sign(hspeed)
                speed=max(speed-(3*(1+_corpse.size))*timescale,12*timescale)
                scrNTTEFullTrenchShake(x,y,6)
                var _fx=instance_create(_corpse.x,_corpse.y,ThrowHit)
                with(_fx) {motion_add(other.direction+orandom(30),3*timescale);image_speed=random_range(0.8,1)*timescale;image_xscale=min(0.5*(_corpse.size+1),1);image_yscale=image_xscale}
                snd_play(sndChickenThrow,0.4+random(0.2),3)
                snd_play(sndGrenadeShotgun,0.6+random(0.2),0.3+0.2*_corpse.size)
            }
        }
        if(place_meeting(x,y,chestprop)) {target=instance_nearest(x,y,chestprop);instance_destroy();return;}
    }
    else if(pickup) {instance_destroy();return;}
    if(place_meeting(x+hspeed,y+vspeed,PortalShock)) {pickup=true;instance_destroy()}
}
function scrNTTEFullHarpoonEndStep() {
    if(lockstep_stop) return;
    if(setup) {setup=false;if(hspeed!=0) image_yscale*=sign(hspeed)}
    if(speed>0) {
        var _fx=instance_create(x,y,BoltTrail)
        _fx.image_yscale=0.6;_fx.image_xscale=point_distance(x,y,xprevious,yprevious)
        _fx.image_angle=point_direction(x,y,xprevious,yprevious);_fx.creator=creator
    }
}
function scrNTTEFullHarpoonHit(_who) {
    if(lockstep_stop || speed<=0 || !scr_can_hit(_who)) return;
    scr_projectile_hit(_who,damage,knockback_speed)
    if(instance_exists(_who) && _who.hp>0) {target=_who;instance_destroy()}
}
function scrNTTEFullHarpoonWall() {
    if(lockstep_stop || speed<=0) return;
    move_contact_solid(direction,16);instance_create(x,y,Dust);snd_play(sndBoltHitWall);speed=0;typ=0
    if(array_length(rope)) {
        for(var _i=0;_i<array_length(rope);++_i) {
            var _r=rope[_i]
            if(_r.harpoon_stuck && instance_is(_r.link1,NTTEFullHarpoon) && instance_is(_r.link2,NTTEFullHarpoon)) _r.broken=-1
            _r.harpoon_stuck=true
        }
    }
    else {pickup=true;instance_destroy()}
}
function scrNTTEFullHarpoonDestroy() {
    if(pickup) {
        var _item=instance_create(x,y,NTTEFullHarpoonPickup)
        with(_item) motion_add(other.direction,other.speed/2)
        _item.image_yscale=image_yscale;_item.image_angle=image_angle;_item.target=target;_item.ammo_type=ammo_type
    }
    else if(instance_exists(target)) {
        var _old=id,_stick=instance_create(x,y,NTTEFullHarpoonStick)
        _stick.image_yscale=image_yscale;_stick.image_angle=image_angle;_stick.target=target;_stick.rope=rope
        if(variable_instance_exists(target,"size")) {
            _stick.pull_speed/=max(target.size,0.5)
            if((instance_is(target,prop) || target.team==team_none) && !instance_is(target,RadChest)
                && !instance_is(target,Car) && !instance_is(target,CarVenus) && !instance_is(target,CarVenusFixed)) _stick.pull_speed=0
        }
        for(var _i=0;_i<array_length(rope);++_i) {
            var _r=rope[_i]
            if(_r.link1==_old) _r.link1=_stick
            if(_r.link2==_old) _r.link2=_stick
            _r.harpoon_stuck=true
            var _a=instance_is(_r.link1,BoltStick)?_r.link1.target:_r.link1,
                _b=instance_is(_r.link2,BoltStick)?_r.link2.target:_r.link2
            if(_a==_b) {
                if(instance_exists(_r.link1)) _r.link1.pull_speed=0
                if(instance_exists(_r.link2)) _r.link2.pull_speed=0
            }
            if(scrNTTEFullValue(_r.link1,"pull_speed",0)<=0 && scrNTTEFullValue(_r.link2,"pull_speed",0)<=0) {
                _r.broken=-1
                if(instance_exists(_r.link1) && instance_exists(_r.link2)) _r.length=point_distance(_r.link1.x,_r.link1.y,_r.link2.x,_r.link2.y)
            }
        }
    }
}
function scrNTTEFullHarpoonCleanup() {
    for(var _i=0;_i<array_length(corpses);++_i) if(instance_exists(corpses[_i])) corpses[_i].depth=1
}
function scrNTTEFullHarpoonStickCreate() {
    sprite_index=scrNTTERefSprite("Harpoon");image_index=0;pull_speed=2;rope=[]
}
function scrNTTEFullHarpoonPickupCreate() {
    sprite_index=scrNTTERefSprite("Harpoon");image_index=1
    spr_open=scrNTTERefSprite("HarpoonOpen");spr_fade=scrNTTERefSprite("HarpoonFade")
    mask_index=mskBigRad;friction=0.4*timescale*timescale
    ntte_full_fade_timer=scrNTTEFullPickupAlarm(90+random(30),0.2);pull_spd=8
    target=noone;ammo_type=Ammo.Bolts
    on_step=scrNTTEFullHarpoonPickupStep;on_pull=scrNTTEFullHarpoonPickupPull;on_open=scrNTTEFullHarpoonPickupOpen
}
function scrNTTEFullHarpoonPickupStep() {
    if(!instance_exists(target)) return;
    x=target.x+target.hspeed-lengthdir_x(16,image_angle)
    y=target.y+target.vspeed-lengthdir_y(16,image_angle)-abs(scrNTTEFullValue(target,"z",0))
    xprevious=x;yprevious=y
    if(!target.visible) target=noone
}
function scrNTTEFullHarpoonPickupPull(_who=undefined) {
    if(instance_exists(target)) {
        if(place_meeting(x,y,Wall)) {x=target.x;y=target.y;xprevious=x;yprevious=y}
        target=noone
    }
    return speed<=0
}
function scrNTTEFullHarpoonPickupOpen(_opener) {
    var _type=ammo_type,_num=num
    with(instance_is(_opener,Player)?_opener:Player) {
        var _amount=_num*(1+floor(typ_ammo[_type]/10))
        if(_type==Ammo.None) {if(reload>0) reload-=3}
        else scrPlayerGiveAmmo(id,_type,_amount)
    }
    return false
}

function scrNTTEFullNetNadeCreate() {
    sprite_index=scrNTTERefSprite("NetNade");image_speed=0.4*timescale
    mask_index=mskBigRad;friction=0.4*timescale*timescale;creator=noone;lasthit=noone
    damage=10;knockback_speed=4*timescale;typ=1
    ntte_net_alarm0=60;ntte_net_alarm1=3;ntte_net_alarm2=45
    scrNTTEFullMergedCustomBind(id,"NetNade")
}
function scrNTTEFullNetNadeStep() {
    if(lockstep_stop) return;
    if(ntte_net_alarm0>0) {ntte_net_alarm0-=timescale;if(ntte_net_alarm0<=0) {instance_destroy();return;}}
    // alarmN_run exits only if the callback returns true or destroys self.
    // The original friction/blink callbacks return no value and continue Step.
    if(ntte_net_alarm1>0) {ntte_net_alarm1-=timescale;if(ntte_net_alarm1<=0) friction=0.8*timescale*timescale}
    if(ntte_net_alarm2>0) {ntte_net_alarm2-=timescale;if(ntte_net_alarm2<=0) sprite_index=scrNTTERefSprite("NetNadeBlink")}
    // Native Slash children include the source Guitar/Blood/Energy variants.
    var _slashes=scrNTTEFullInstances(Slash)
    for(var _i=0;_i<array_length(_slashes);++_i) if(instance_exists(_slashes[_i]) && place_meeting(x,y,_slashes[_i])) {
        var _self=id
        scrNTTEFullNetNadeBat(_slashes[_i])
        if(!instance_exists(_self)) return;
    }
    if(speed>0) {
        var _trail=instance_create(x,y,DiscTrail)
        _trail.image_angle=direction;_trail.image_xscale=image_xscale*(speed/timescale/16)
        _trail.image_yscale=image_yscale*0.25;_trail.depth=-1
    }
}
function scrNTTEFullNetNadeBat(_slash) {
    // NTT explicitly dispatches Grenade collision for the custom NetNade.
    // Epsilon's generic Slash handler tests actual native ancestry instead,
    // so that exact Grenade branch is translated here for this native class.
    if(scrNTTEFullValue(_slash,"shank",false) || typ==2) {instance_destroy();return;}
    motion_add(_slash.direction,12*timescale);friction=0.1*timescale*timescale
    ntte_net_alarm1=6;speed=12*timescale
    scr_screenshake(3);scrBulletHitFX(sprDeflect)
}
function scrNTTEFullNetNadeHit(_who) {
    if(!lockstep_stop && speed>0 && scr_can_hit(_who)) {
        lasthit=_who;scr_projectile_hit(_who,damage,knockback_speed);instance_destroy()
    }
}
function scrNTTEFullNetNadeDestroy() {
    repeat(8) scrNTTEFullMergedStockFX(x,y,1+random(2),Dust)
    snd_play(sndUltraCrossbow);snd_play(sndFlakExplode);scrNTTEFullTrenchShake(x,y,20)
    while(distance_to_object(Wall)<32) {
        var _wall=instance_nearest(x-8,y-8,Wall)
        if(!instance_exists(_wall)) break
        instance_create(_wall.x,_wall.y,FloorExplo);instance_destroy(_wall)
    }
    var _angle=random(360),_dis=0,_last=noone,_first=noone,_self=id
    for(var _i=0;_i<10;++_i) {
        var _dir=_angle+_i*36,_off=0
        _dis=_dis>0?0:8
        var _sx=x+lengthdir_x(_dis,_dir),_sy=y+lengthdir_y(_dis,_dir),_near=noone,_best=infinity,_team=team
        with(enemy) if(team!=_team && id!=other.lasthit) {
            var _distance=point_distance(x,y,_sx+lengthdir_x(66,_dir),_sy+lengthdir_y(66,_dir))
            if(_distance<_best) {_best=_distance;_near=id}
        }
        if(instance_exists(_near)) {
            _off=angle_difference(point_direction(x,y,_near.x,_near.y),_dir)
            if(abs(_off)>=18) _off=0
        }
        var _harpoon=scrNTTEFullMergedBasicProjectileCreate(_sx,_sy,NTTEFullHarpoon,_dir+_off,22)
        var _fx=instance_create(_harpoon.x,_harpoon.y,MeleeHitWall)
        with(_fx) {motion_add(_harpoon.direction,(1+random(2))*timescale);image_angle=direction+180;image_speed=0.6*timescale}
        if(!instance_exists(_first)) _first=_harpoon
        if(instance_exists(lasthit)) scrNTTEFullHarpoonRope(_harpoon,lasthit)
        else {if(instance_exists(_last)) scrNTTEFullHarpoonRope(_harpoon,_last);_last=_harpoon}
    }
    if(instance_exists(_last)) scrNTTEFullHarpoonRope(_first,_last)
}

// tecoast5223..5629. The transient projectile owns the original physical
// weapon/state until cleanup moves it into a pickup or back to a cursed slot.
function scrNTTEFullTridentCreate() {
    sprite_index=scrNTTERefSprite("Trident");image_speed=0.4*timescale
    mask_index=scrNTTERefSprite("msk.Trident");damage=40;force=5;typ=1
    curse=0;curse_return_delay=0;rotspeed=0;target=noone;marrow_target=noone
    hit_time=0;hit_list=-1;wep=wep_ntte_trident;state=undefined
    alarm[0]=15;ntte_trident_alarm_frame=-1;ntte_trident_cleaned=false
    ntte_trident_safe_x=undefined;ntte_trident_safe_y=undefined;ntte_trident_returning=false
}
function scrNTTEFullTridentOwns(_holder) {
    if(!instance_exists(_holder)) return false
    var _front=scrNTTEFullValue(_holder,"wep",wep_none),_back=scrNTTEFullValue(_holder,"bwep",wep_none)
    if(is_struct(wep) && (_front==wep || _back==wep)) return true
    if(is_struct(state) && (scrNTTEFullMergedRuntimeStateHas(_holder,true,state)
        || scrNTTEFullMergedRuntimeStateHas(_holder,false,state))) return true
    return (is_struct(state) && (scrNTTEFullValue(_holder,"ntte_state",undefined)==state
        || scrNTTEFullValue(_holder,"bntte_state",undefined)==state))
}
function scrNTTEFullTridentStep() {
    if(lockstep_stop || ntte_trident_alarm_frame==current_frame) return;
    if(scrNTTEFullTridentCoastReturnStep()) return;
    hit_time+=timescale
    if(curse>0 && visible && current_frame_active) instance_create(x+orandom(4),y+orandom(4),Curse)
    var _projectiles=scrNTTEFullInstances(projectile)
    for(var _i=0;_i<array_length(_projectiles);++_i) {
        var _p=_projectiles[_i],_type=scrNTTEFullValue(_p,"typ",0),_distance=infinity
        if(_p==id || _p.team==team || (_type!=1 && _type!=2) || _p.object_index==PopoNade) continue
        with(_p) _distance=distance_to_object(other.id)
        if(_distance<=8) {sleep(2);instance_destroy(_p)}
    }
    if(speed>0) {
        var _marrow=scr_skill_get(mut_bolt_marrow)
        if(_marrow>0) {
            var _target=marrow_target
            if(!instance_exists(_target) || collision_line(x,y,_target.x,_target.y,Wall,false,false)) {
                var _px=x+hspeed/timescale,_py=y+vspeed/timescale,_best=160,_targets=scrNTTEFullInstances(hitme),
                    _void=asset_get_index("sprVoid")
                for(var _i=0;_i<array_length(_targets);++_i) {
                    var _t=_targets[_i]
                    if(_t.team==team || _t.team==team_none || _t.mask_index==mskNone
                        || (sprite_exists(_void) && _t.mask_index==_void)
                        || !(instance_is(_t,enemy) || instance_is(_t,Player) || instance_is(_t,Sapling)
                            || instance_is(_t,Ally) || instance_is(_t,SentryGun) || scrNTTEFullRawHitCustom(_t))) continue
                    var _distance=point_distance(_t.x,_t.y,_px,_py),_shield=false
                    if(_distance>=_best || collision_line(_t.x,_t.y,x,y,Wall,false,false)) continue
                    if(ds_exists(hit_list,ds_type_map) && ds_map_exists(hit_list,_t) && hit_list[? _t]>hit_time) continue
                    with(PopoShield) if(creator==_t) {_shield=true;break}
                    if(!_shield) {_best=_distance;marrow_target=_t}
                }
            }
            else rotspeed+=(angle_difference(point_direction(x,y,_target.x,_target.y),direction)
                /max(1,60/(point_distance(x,y,_target.x,_target.y)+1)))*min(1,0.1*_marrow)*timescale
            var _factor=min(1,abs(rotspeed)/90)
            x-=hspeed*_factor;y-=vspeed*_factor
        }
        if(rotspeed!=0) {
            direction+=rotspeed*timescale;image_angle+=rotspeed*timescale
            rotspeed-=rotspeed*0.3*timescale
        }
        return;
    }
    if(curse>0 && scrNTTEFullTridentOwns(creator)) {
        if(curse_return_delay<6) {
            var _distance=max(5,point_distance(x,y,creator.x,creator.y)*0.1*timescale)/(curse_return_delay+1),
                _direction=point_direction(x,y,creator.x,creator.y)
            x+=lengthdir_x(_distance,_direction);y+=lengthdir_y(_distance,_direction)
            if(!place_free(x,y)) {
                xprevious=x;yprevious=y
                if(visible) {
                    visible=false;snd_play(sndCursedReminder,1+orandom(0.3))
                    repeat(4) with(instance_create(x+orandom(8),y+orandom(8),Smoke))
                        scrNTTEFullNativeMotionAddFT(id,_direction+180,random(1))
                }
            }
            else if(place_meeting(x,y,Floor) && !visible) {
                visible=true;snd_play(sndSwapCursed,1+orandom(0.3))
                repeat(4) with(instance_create(x+orandom(8),y+orandom(8),Smoke))
                    scrNTTEFullNativeMotionAddFT(id,_direction,random(2))
            }
            if(point_distance(x,y,creator.x,creator.y)<40) _direction+=180
            image_angle+=angle_difference(_direction,image_angle)*(1-power(1-0.05/(curse_return_delay+1),timescale))
        }
        if(curse_return_delay<=8) image_angle+=orandom(2+curse_return_delay)*timescale
        var _step=0.5*timescale
        curse_return_delay-=clamp(curse_return_delay,-_step,_step)
        if(place_meeting(x,y,creator) || (creator.mask_index==mskNone && place_meeting(x,y,Portal))) instance_destroy()
    }
    else instance_destroy()
}
function scrNTTEFullTridentCoastReturnStep() {
    // A missed throw over Coast water must remain recoverable. Retain its
    // physical weapon/state and travel back; do not replace it or return a
    // trident which is pinned to a target or uses the authored curse return.
    if(curse>0 || instance_exists(target) || GameCont.area!=201) return false
    if(!ntte_trident_returning) {
        if(place_meeting(x,y,Floor) && !place_meeting(x,y,Wall)) {
            ntte_trident_safe_x=x;ntte_trident_safe_y=y
            return false
        }
        if(point_in_rectangle(x,y,view_xview-24,view_yview-24,
            view_xview+view_width+24,view_yview+view_height+24)) return false
        if(is_undefined(ntte_trident_safe_x)) {
            var _floors=scrNTTEFullInstances(Floor),_best=infinity
            for(var _i=0;_i<array_length(_floors);++_i) {
                var _f=_floors[_i],_fx=(_f.bbox_left+_f.bbox_right-1)/2,
                    _fy=(_f.bbox_top+_f.bbox_bottom-1)/2,_d=point_distance(x,y,_fx,_fy)
                if(_d<_best && !collision_point(_fx,_fy,Wall,false,false)) {
                    _best=_d;ntte_trident_safe_x=_fx;ntte_trident_safe_y=_fy
                }
            }
        }
        if(is_undefined(ntte_trident_safe_x)) return false
        ntte_trident_returning=true;speed=0;friction=0;alarm[0]=-1;mask_index=mskNone
    }
    var _distance=point_distance(x,y,ntte_trident_safe_x,ntte_trident_safe_y),
        _step=min(_distance,3*timescale),_dir=point_direction(x,y,ntte_trident_safe_x,ntte_trident_safe_y)
    x+=lengthdir_x(_step,_dir);y+=lengthdir_y(_step,_dir)
    if(_distance<=_step) instance_destroy()
    return true
}
function scrNTTEFullTridentAlarm() {
    ntte_trident_alarm_frame=current_frame;friction=0.5*timescale*timescale
}
function scrNTTEFullTridentEndStep() {
    if(lockstep_stop || !visible) return;
    var _trail=instance_create(x,y,BoltTrail)
    _trail.image_xscale=point_distance(x,y,xprevious,yprevious)
    _trail.image_angle=point_direction(x,y,xprevious,yprevious);_trail.creator=creator
    if(curse>0) _trail.image_blend=make_color_rgb(235,0,67)
}
function scrNTTEFullTridentDraw() {
    draw_sprite_ext(sprite_index,image_index,x,y,
        image_xscale*max(2/3,1-0.025*abs(rotspeed)*min(1,speed/8)),image_yscale,
        image_angle+rotspeed,image_blend,image_alpha)
}
function scrNTTEFullTridentHit(_target) {
    // CustomProjectile's native collision calls the authored on_hit only for
    // foreign teams; source's own three-tick map supplies the hit interval.
    if(lockstep_stop || speed<=0 || !instance_exists(_target) || _target.team==team) return;
    if(!ds_exists(hit_list,ds_type_map)) hit_list=ds_map_create()
    var _first=!ds_map_exists(hit_list,_target)
    if(!_first && hit_list[? _target]>hit_time) return;
    hit_list[? _target]=hit_time+3
    scrNTTEFullNativeProjectileHitPush(_target,damage,force)
    if(!instance_exists(id)) return;
    if(marrow_target==_target) marrow_target=noone
    if(_first && speed>12*timescale) speed=18*timescale
    if(instance_exists(_target) && _target.hp>0) {
        if(scrNTTEFullValue(creator,"race",-1)!=Race.Chicken || scr_skill_get(mut_throne_butt)<=0) {
            snd_play(sndAssassinAttack,2);target=_target;speed=0
            if(curse>0) {curse_return_delay=8+random(2);mask_index=mskFlakBullet}
        }
    }
    else if(rotspeed<5) {x-=hspeed/timescale/3;y-=vspeed/timescale/3}
    var _size=clamp(scrNTTEFullValue(_target,"size",1),1,5)
    scrNTTEFullTrenchShake(x,y,12*_size,true);sleep(16*_size)
}
function scrNTTEFullTridentWall() {
    if(lockstep_stop || speed<=0) return;
    var _canwall=true
    if(speed>12*timescale) {
        if(scr_skill_get(mut_bolt_marrow)>0 && !instance_exists(marrow_target)) scrNTTEFullTridentStep()
        if(marrow_target!=creator && instance_exists(marrow_target)
            && point_distance(x,y,marrow_target.x,marrow_target.y)<160
            && !collision_line(x,y,marrow_target.x,marrow_target.y,Wall,false,false)) {
            var _turn=abs(angle_difference(image_angle,point_direction(x,y,marrow_target.x,marrow_target.y)))
            if(_turn>=10 && _turn<=160) _canwall=false
        }
    }
    if(_canwall) {
        speed=0;move_contact_solid(direction,16)
        if(curse>0) {curse_return_delay=8+random(2);mask_index=mskFlakBullet}
        instance_create(x,y,Debris);snd_play(sndBoltHitWall)
        snd_play(sndExplosionS,1.5,0.7);snd_play(sndBoltHitWall,1,0.7)
    }
    else if(instance_exists(marrow_target)) {
        direction+=angle_difference(point_direction(x,y,marrow_target.x,marrow_target.y),direction)*(1-power(0.75,timescale))
        image_angle=direction;alarm[0]=min(alarm[0],1)
    }
}
function scrNTTEFullTridentDestroy() {
    var _px=x+lengthdir_x(18,direction),_py=y+lengthdir_y(18,direction),
        _pop=instance_create(_px,_py,NTTEFullBubblePop)
    _pop.image_index=1
    repeat(3) scrNTTEFullMergedStockFX(_px,_py,[direction+orandom(30),choose(1,2,2)],Bubble)
}
function scrNTTEFullTridentCleanup() {
    if(ntte_trident_cleaned) return;
    ntte_trident_cleaned=true
    if(ds_exists(hit_list,ds_type_map)) ds_map_destroy(hit_list)
    hit_list=-1
    if(is_struct(state)) {state.visible=true;state.ammo=state.capacity;state.outstanding=0;state.loaded=true}
    if(curse>0 && scrNTTEFullTridentOwns(creator)) {
        if(instance_is(creator,Player) && is_struct(state)) {
            state.wepangle=angle_difference(image_angle,creator.gunangle)
            if(random(8)<1) state.wepangle+=360*sign(state.wepangle)
            var _back=scrNTTEFullMergedRuntimeStateHas(creator,false,state)
                && !scrNTTEFullMergedRuntimeStateHas(creator,true,state)
            variable_instance_set(creator,_back?"bwepangle":"wepangle",state.wepangle)
            var _fx=instance_create(creator.x,creator.y,WepSwap);_fx.creator=creator
        }
        snd_play(scrNTTEFullWeaponSwapSound(wep));snd_play(sndSwapCursed)
        return;
    }
    if(wep==wep_none) return;
    // Match exact LWO/state identity. A raw type match would delete another
    // player's independent Trident or erase the same-type secondary weapon.
    var _identity=state,_weapon=wep
    with(WepPickup) if((is_struct(_identity) && scrNTTEFullValue(id,"ntte_state",undefined)==_identity)
        || (is_struct(_weapon) && wep==_weapon)) instance_destroy()
    if(!visible && !place_meeting(x,y,Floor)) {
        var _floor=instance_nearest(x,y,Floor)
        if(instance_exists(_floor)) {x=(_floor.bbox_left+_floor.bbox_right)/2;y=(_floor.bbox_top+_floor.bbox_bottom)/2;repeat(4) instance_create(x,y,Smoke)}
    }
    var _stuck=instance_exists(target),
        _pickup=scrWeaponPickupCreate(x,y,wep,false,_stuck?NTTEFullWepPickupStick:WepPickup)
    _pickup.ntte_state=state;_pickup.image_angle=image_angle;_pickup.rotation=image_angle;_pickup.curse=curse
    _pickup.ntte_throw_pickup=true;_pickup.ntte_throw_target=noone;_pickup.ntte_throw_x=0;_pickup.ntte_throw_y=0
    _pickup.speed=0;_pickup.autopick=false;_pickup.slowreturn=false
    if(_stuck) {
        _pickup.mask_index=mskShield;_pickup.stick_target=target;_pickup.stick_damage=damage
        _pickup.stick_x=0;_pickup.stick_y=0;_pickup.ntte_stick_removed=false
        if(max(target.bbox_right-target.bbox_left,target.bbox_bottom-target.bbox_top)>32)
            _pickup.rotation+=angle_difference(point_direction(_pickup.x,_pickup.y,target.x,target.y),_pickup.rotation)/2
        else {_pickup.x=target.x-lengthdir_x(24,_pickup.rotation);_pickup.y=target.y-lengthdir_y(24,_pickup.rotation)}
        _pickup.stick_x=_pickup.x-target.x;_pickup.stick_y=_pickup.y-target.y
    }
    if(instance_is(creator,Player) && creator.race==Race.Chicken && scr_ultra_get(Race.Chicken,UltraSkill.Determination)) {
        _pickup.creator=creator;_pickup.alarm[0]=30
    }
}
function scrNTTEFullTridentStickStep() {
    if(lockstep_stop) return;
    if(instance_exists(stick_target)) {
        canwade=false;rotspeed=0
        x=stick_target.x+stick_target.hspeed+stick_x;y=stick_target.y+stick_target.vspeed+stick_y-abs(scrNTTEFullValue(stick_target,"z",0))
        xprevious=x;yprevious=y;speed=0
        var _intro=asset_get_index("NothingIntroMask")
        visible=stick_target.visible || (object_exists(_intro) && instance_is(stick_target,_intro))
    }
    else if(stick_target!=noone) {
        stick_target=noone;mask_index=mskWepPickup;visible=true;canwade=true;rotspeed=random_range(1,2)*choose(-1,1)
    }
}
function scrNTTEFullTridentStickCleanup() {
    if(scrNTTEFullValue(id,"ntte_stick_removed",false)) return;
    ntte_stick_removed=true
    if(!instance_exists(stick_target) || stick_damage==0) return;
    var _job=instance_create(x,y,NTTEFullTridentExtract)
    _job.target=stick_target;_job.damage=stick_damage;_job.wep=wep;_job.state=scrNTTEFullValue(id,"ntte_state",undefined)
    _job.direction=rotation;_job.creator=creator
}
function scrNTTEFullTridentExtractStep() {
    if(lockstep_stop) return;
    if(instance_exists(target) && instance_is(target,hitme)) {
        var _prop=instance_is(target,prop) || instance_is(target,Nothing) || instance_is(target,Nothing2)
        repeat(3) {
            var _fx=scrNTTEFullMergedStockFX(x+lengthdir_x(24,direction),y+lengthdir_y(24,direction),_prop?2.5:0,_prop?Dust:AllyDamage)
            /* NTTE DUST LIFETIME trident-extract */ if(instance_exists(_fx)) {_fx.depth=min(_fx.depth,target.depth-1) }
        }
        scrNTTEFullRawHit(target,damage,1)
        var _nearest=infinity,_holder=noone,_back=false,_physical=state
        with(Player) {
            var _isback=scrNTTEFullValue(id,"bntte_state",undefined)==_physical,
                _front=scrNTTEFullValue(id,"ntte_state",undefined)==_physical
            if(_isback || _front) {
                var _distance=point_distance(x,y,other.x,other.y)
                if(_distance<_nearest) {_nearest=_distance;_holder=id;_back=!_front}
            }
        }
        if(instance_exists(_holder)) variable_instance_set(_holder,_back?"bwkick":"wkick",10)
    }
    instance_destroy()
}

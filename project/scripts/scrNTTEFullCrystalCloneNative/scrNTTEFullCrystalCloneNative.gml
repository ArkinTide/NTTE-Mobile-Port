// tecaves.mod.gml887..1332: real instance-clone controllers, not a damage
// approximation. Native subclasses, AI, alarms, collision and Draw remain real.
function scrNTTEFullCrystalCloneHasTarget(_target,_team=undefined) {
    with(NTTEFullCrystalClone) if(target==_target && (is_undefined(_team) || team==_team)) return true
    return false
}
function scrNTTEFullCrystalPickups() {
    // Epsilon flattens NTT's abstract Pickup parent into these real classes.
    // Keep the original mask filter; weapons use mskWepPickup and do not clone.
    var _result=[],_instances=scrNTTEFullInstances(all)
    for(var _i=0;_i<array_length(_instances);++_i) {
        var _inst=_instances[_i]
        if(_inst.mask_index==mskPickup && (instance_is(_inst,HPPickup) || instance_is(_inst,AmmoPickup)
            || instance_is(_inst,CursedPickup) || instance_is(_inst,CrownPickup)
            || instance_is(_inst,NTTEFullCustomPickup) || instance_is(_inst,NTTEPickup))) array_push(_result,_inst)
    }
    return _result
}
function scrNTTEFullCrystalCloneRebind(_value,_source,_copy) {
    if(is_method(_value) && method_get_self(_value)==_source) return method(_copy,method_get_index(_value))
    return _value
}
function scrNTTEFullCrystalCloneValue(_value,_source,_copy) {
    // Native bound methods can be reported as structs. Preserve their
    // callable identity before copying ordinary source containers.
    if(is_method(_value)) return scrNTTEFullCrystalCloneRebind(_value,_source,_copy)
    if(is_array(_value)) {
        var _result=array_create(array_length(_value))
        for(var _i=0;_i<array_length(_value);++_i) _result[_i]=scrNTTEFullCrystalCloneRebind(_value[_i],_source,_copy)
        return _result
    }
    if(is_struct(_value)) {
        var _result={},_names=variable_struct_get_names(_value)
        for(var _i=0;_i<array_length(_names);++_i) {
            var _name=_names[_i]
            _result[$ _name]=scrNTTEFullCrystalCloneRebind(_value[$ _name],_source,_copy)
        }
        return _result
    }
    return scrNTTEFullCrystalCloneRebind(_value,_source,_copy)
}
function scrNTTEFullCrystalInstanceClone(_source) {
    if(!instance_exists(_source)) return noone
    var _copy=noone
    with(_source) _copy=scrNTTEFullMergedNativeCopy(false)
    if(!instance_exists(_copy)) return noone
    var _keep_charm=false,_charm=scrNTTEFullValue(_copy,"ntte_charm",undefined)
    if(is_struct(_charm) && _charm.charmed && instance_exists(GameCont)) {
        var _registry=scrNTTEFullValue(GameCont,"ntte_charm_instance_list",[]),
            _records=scrNTTEFullValue(GameCont,"ntte_charm_instance_vars",[]),_index=array_get_index(_registry,_copy)
        _keep_charm=_index>=0 && _index<array_length(_records) && _records[_index]==_charm
    }
    var _names=variable_instance_get_names(_source)
    for(var _i=0;_i<array_length(_names);++_i) {
        var _name=_names[_i]
        // This is native scheduler bookkeeping, absent in original NTT; its
        // copy already has a new identity and its own terminal snapshot.
        // Preserve NativeCopy's active registered record. Inactive/unregistered
        // charm state still needs the same explicit independent shallow copy
        // as other source containers, including previously uncharmed actors.
        if(_name=="temerge_destroy_event_vars" || (_name=="ntte_charm" && _keep_charm)
            || _name=="id" || _name=="object_index") continue
        variable_instance_set(_copy,_name,scrNTTEFullCrystalCloneValue(variable_instance_get(_source,_name),_source,_copy))
    }
    _copy.depth=_source.depth
    // NTT exposed alarms as cloneable fields; modern native alarms are an
    // engine array and are absent from variable_instance_get_names().
    for(var _i=0;_i<12;++_i) _copy.alarm[_i]=_source.alarm[_i]
    return _copy
}
function scrNTTEFullCrystalCloneCreate() {
    sprite_index=-1;spr_effect=-1;image_speed=0.4*timescale;image_alpha=0
    creator=noone;target=noone;clone=[];time=450;team=-1;appear=1;appear_flip=false;appear_health=false;budge=true
    ntte_clone_surface=-1;ntte_clone_camera=-1
    var _enemies=scrNTTEFullInstances(enemy)
    for(var _i=0;_i<array_length(_enemies);++_i) {
        var _enemy=_enemies[_i]
        if(_enemy.team==2 || _enemy.size>=5 || _enemy.mask_index==mskNone
            || scrNTTEFullValue(_enemy,"intro",undefined)==false || scrNTTEFullValue(_enemy,"name","")=="CrystalBrain") continue
        array_push(clone,_enemy)
    }
}
function scrNTTEFullCrystalCloneSprites() {
    if(!sprite_exists(sprite_index)) sprite_index=scrNTTERefSprite(team==2?"CrystalCloneOverlayAlly":(team==3?"CrystalCloneOverlayPopo":"CrystalCloneOverlay"))
    if(!sprite_exists(spr_effect)) spr_effect=scrNTTERefSprite(team==2?"CrystalBrainEffectAlly":(team==3?"CrystalBrainEffectPopo":"CrystalBrainEffect"))
}
function scrNTTEFullCrystalCloneEffect(_x1,_y1,_x2,_y2) {
    if(!sprite_exists(spr_effect)) return noone
    var _result=[],_direction=point_direction(_x1,_y1,_x2,_y2),_distance=point_distance(_x1,_y1,_x2,_y2)
    for(var _d=0;_d<_distance;_d+=random_range(12,24)) {
        var _fx=scrNTTEFullCrystalBrainEffect(_x1+lengthdir_x(_d,_direction)+orandom(8),_y1+lengthdir_y(_d,_direction)+orandom(8))
        _fx.sprite_index=spr_effect;_fx.image_speed=(lerp(0.8,0.4,_d/_distance)+orandom(0.1))*timescale
        _fx.image_angle=round((_direction+orandom(45))/90)*90;_fx.depth=-9
        _fx.direction=point_direction(_fx.x,_fx.y,_x2,_y2);_fx.speed=random_range(1,1.5)*(1-_d/_distance)*timescale
        array_push(_result,_fx)
    }
    return _result
}
function scrNTTEFullCrystalCloneBrainEffect(_x,_y) {
    var _fx=scrNTTEFullCrystalBrainEffect(_x,_y)
    _fx.sprite_index=spr_effect;_fx.depth=depth-choose(2,3)
    return _fx
}
function scrNTTEFullCrystalPlayerClone(_source) {
    var _ally=instance_create(_source.x,_source.y,NTTEFullCrystalAlly),
        _fields=["spr_idle","spr_walk","spr_hurt","spr_dead","spr_shadow","spr_shadow_x","spr_shadow_y",
            "image_xscale","image_yscale","image_angle","image_blend","image_alpha","snd_hurt","snd_dead","mask_index"]
    for(var _i=0;_i<array_length(_fields);++_i) if(variable_instance_exists(_source,_fields[_i]))
        variable_instance_set(_ally,_fields[_i],variable_instance_get(_source,_fields[_i]))
    _ally.sprite_index=_ally.spr_idle;_ally.max_hp=_source.max_hp;_ally.hp=_ally.max_hp;_ally.creator=_source
    // Epsilon's one-time C-skin setup would replace the copied Player visuals.
    _ally.setup=false;_ally.alarm[2]=-1
    audio_stop_sound(sndAllySpawn)
    var _world=scrNTTEFullValue(_source,"snd_wrld",-1)
    if(audio_exists(_world)) snd_play(_world)
    var _weapon=scrNTTEFullWeaponNativeCopy(_source.wep),_fire=instance_create(_ally.x,_ally.y,NTTEFullCrystalFireWeapon)
    _fire.creator=_ally;_fire.wep=_weapon
    var _state=scrNTTEFullValue(_source,"ntte_state",undefined)
    if(is_struct(_state)) {
        _ally.ntte_state=scrNTTEFullCrystalCloneValue(_state,_source,_ally)
        _ally.ntte_state.weapon=_weapon
    }
    return _ally
}
function scrNTTEFullCrystalCloneStep() {
    if(lockstep_stop) return;
    scrNTTEFullCrystalCloneSprites()
    if(target!=noone) return;
    var _sources=is_array(clone)?clone:scrNTTEFullInstances(clone),_nearest=noone,_distance=256
    for(var _i=0;_i<array_length(_sources);++_i) {
        var _source=_sources[_i]
        if(!instance_exists(_source)) continue
        var _d=point_distance(x,y,_source.x,_source.y)
        if(_d<_distance && !scrNTTEFullCrystalCloneHasTarget(_source,team)) {_distance=_d;_nearest=_source}
    }
    if(!instance_exists(_nearest)) {instance_destroy();return;}
    target=instance_is(_nearest,Player)?scrNTTEFullCrystalPlayerClone(_nearest):scrNTTEFullCrystalInstanceClone(_nearest)
    if(!instance_exists(target)) {instance_destroy();return;}
    var _controller=id,_source=_nearest
    with(target) {
        if(instance_is(id,hitme)) {
            raddrop=0
            if(team!=_controller.team) {
                if(_controller.team==2) {
                    var _charm=scrNTTEFullParrotCharm(id,true)
                    _charm.time=_controller.time+1;_charm.kill=true
                    if(instance_exists(_controller.creator) && variable_instance_exists(_controller.creator,"index")) _charm.index=_controller.creator.index
                }
                team=_controller.team
            }
            if(instance_is(id,enemy)) {
                kills=0;wepseed=-1
                // Native Epsilon uses these names for the source's two fields.
                givekill=false;dropseed=-1
                if(_controller.team!=2) {
                    hp=ceil(hp/2)
                    if(canmelee==true) {canmelee=false;alarm[11]=30}
                }
            }
        }
        if(speed==0) direction=random(360)
        if(_controller.budge) {
            if(!scrNTTEFullWorldBudge(id,_source)) {
                var _angle=random(360)
                x+=lengthdir_x(16,_angle);y+=lengthdir_y(16,_angle);xprevious=x;yprevious=y
                scrNTTEFullWorldWallClear(id)
            }
        }
        else {x+=dcos(direction);y-=dsin(direction)}
        xstart=x;ystart=y
    }
    scrNTTEFullCrystalCloneEffect(x,y,target.x,target.y)
    snd_play(sndHyperCrystalSearch,1.3+random(0.4),0.4)
}
function scrNTTEFullCrystalCloneEndStep() {
    if(lockstep_stop) return;
    if(!instance_exists(target)) {
        if(target!=noone) instance_destroy()
        return;
    }
    x=target.x;y=target.y;mask_index=target.sprite_index;depth=min(target.depth-1,object_get_depth(SubTopCont))
    var _controller=id
    if(appear>0) {
        appear-=timescale/24
        with(target) {
            visible=(_controller.appear<=0)
            if(instance_is(id,enemy)) {
                speed=0;x=xprevious;y=yprevious
                // Several native subclasses expose an unset optional walk
                // field. Field presence alone does not make it a number.
                var _walk=scrNTTEFullValue(id,"walk",undefined)
                if(is_real(_walk) || is_int64(_walk) || is_bool(_walk)) walk=min(1,_walk)
                if(variable_instance_exists(id,"spr_walk") && sprite_index==spr_walk) sprite_index=spr_idle
            }
            if(_controller.appear_health>0 && variable_instance_exists(id,"hp")) {
                hp=max(hp,_controller.appear_health);_controller.appear_health=hp
            }
        }
    }
    else if(target.visible && random(5)<timescale) {
        scrNTTEFullCrystalCloneBrainEffect(random_range(bbox_left,bbox_right)+orandom(10),random_range(bbox_top,bbox_bottom)+orandom(10))
    }
    if(time>=0) {
        time-=min(time,timescale)
        if(time<=0) {
            if(instance_is(target,hitme)) target.hp=0
            else if(!instance_is(target,becomenemy)) {
                with(target) {repeat(3) with(instance_create(x,y,Smoke)) motion_set(random(360),3*timescale);instance_destroy()}
            }
        }
    }
}
function scrNTTEFullCrystalCloneDestroy() {
    if(target!=noone) {
        var _num=round(((bbox_right-bbox_left)+(bbox_bottom-bbox_top))/32)+irandom(2)
        repeat(max(0,_num)) {
            instance_create(random_range(bbox_left,bbox_right),random_range(bbox_top,bbox_bottom),Smoke)
            scrNTTEFullCrystalCloneBrainEffect(random_range(bbox_left,bbox_right),random_range(bbox_top,bbox_bottom))
        }
        snd_play(sndHyperCrystalRelease,0.8+random(0.3),0.8)
    }
}
function scrNTTEFullCrystalCloneCleanup() {
    if(surface_exists(ntte_clone_surface)) surface_free(ntte_clone_surface)
    if(ntte_clone_camera>=0) camera_destroy(ntte_clone_camera)
}

// The original captures each real Draw event into a transparent screen-sized
// surface, cuts its alpha with a moving wave, then writes tiled RGB while
// preserving that alpha. Finished overlays add onto the normally drawn actor.
function scrNTTEFullCrystalCloneDraw() {
    if(lockstep_stop || !instance_exists(target)) return;
    var _group=[]
    if(appear>0) _group=[id]
    else with(NTTEFullCrystalClone) if(depth==other.depth && sprite_index==other.sprite_index && appear<=0) array_push(_group,id)
    if(array_length(_group)==0 || _group[0]!=id) return;
    var _seen=[]
    for(var _i=0;_i<array_length(_group);++_i) {
        var _c=_group[_i]
        if(instance_exists(_c.target) && _c.bbox_left<view_xview+view_width+24 && _c.bbox_right>view_xview-24
            && _c.bbox_top<view_yview+view_height+24 && _c.bbox_bottom>view_yview-24) array_push(_seen,_c)
    }
    if(array_length(_seen)==0) return;
    var _target=surface_get_target(),_scale=1
    if(surface_exists(_target)) _scale=surface_get_width(_target)/view_width
    else if(surface_exists(application_surface)) _scale=surface_get_width(application_surface)/view_width
    var _width=max(1,ceil(view_width*_scale)),_height=max(1,ceil(view_height*_scale))
    if(!surface_exists(ntte_clone_surface) || surface_get_width(ntte_clone_surface)!=_width || surface_get_height(ntte_clone_surface)!=_height) {
        if(surface_exists(ntte_clone_surface)) surface_free(ntte_clone_surface)
        ntte_clone_surface=surface_create(_width,_height)
    }
    if(!surface_exists(ntte_clone_surface)) return;
    if(ntte_clone_camera<0) ntte_clone_camera=camera_create_view(0,0,1,1,0,noone,-1,-1,-1,-1)
    var _world=matrix_get(matrix_world),_view=matrix_get(matrix_view),_projection=matrix_get(matrix_projection),
        _color=draw_get_color(),_alpha=draw_get_alpha(),_ts=timescale,_pushed=false
    gpu_push_state()
    try {
        surface_set_target(ntte_clone_surface);_pushed=true
        camera_set_view_pos(ntte_clone_camera,view_xview,view_yview);camera_set_view_size(ntte_clone_camera,view_width,view_height)
        camera_apply(ntte_clone_camera);matrix_set(matrix_world,matrix_build_identity())
        draw_clear_alpha(c_black,0);draw_set_alpha(1);draw_set_color(c_white)
        gpu_set_blendmode(bm_normal);gpu_set_texfilter(false)
        timescale=0.00000001
        for(var _i=0;_i<array_length(_seen);++_i) {
            var _clone=_seen[_i],_actor=_clone.target
            if(!instance_exists(_actor) || !(_clone.time>60 || (_clone.time%6)<3)) continue
            var _visible=_actor.visible
            if(_clone.appear>0) _actor.visible=true
            try {
                if(_actor.visible) with(_actor) {
                    if(object_index==NTTEFullCrystalAlly || object_index==NTTEFullCrystalCloneDrawProbe
                        || scrNTTEFullCoastObjectHasDraw(object_index)) event_perform(ev_draw,0)
                    else draw_self()
                    if(_clone.appear>0) {
                        var _mask=mask_index,_xs=image_xscale
                        try {
                            mask_index=sprite_index
                            if(variable_instance_exists(id,"right")) image_xscale*=right
                            var _a=min(1,_clone.appear)
                            if(_clone.appear_flip) _a=1-_a
                            var _x1=bbox_left,_y1=bbox_top,_x2=bbox_right,_y2=bbox_bottom,
                                _h=(_y2-_y1)/16,_y=lerp(_y1-2*_h,_y2,_a),_ay=_clone.appear_flip?_y2:_y1
                            if(_h>0) {
                                gpu_set_blendmode_ext(bm_zero,bm_inv_src_alpha)
                                draw_primitive_begin(pr_trianglestrip);draw_vertex(_x1,_ay)
                                for(var _x=_x1;_x<=_x2;++_x) {
                                    draw_vertex(_x,clamp(_y+_h*sin((_x-_x1+current_frame)/(2*_h))+_h*cos((_x-_x1-current_frame)/(4*_h)),_y1,_y2))
                                    draw_vertex(_x,_ay)
                                }
                                draw_primitive_end();gpu_set_blendmode(bm_normal)
                            }
                        }
                        finally {mask_index=_mask;image_xscale=_xs}
                    }
                }
            }
            finally {_actor.visible=_visible}
        }
        if(sprite_exists(sprite_index)) {
            gpu_set_blendmode(appear>0?bm_add:bm_normal)
            gpu_set_colorwriteenable(true,true,true,false)
            draw_sprite_tiled(sprite_index,image_index,0,0)
            gpu_set_colorwriteenable(true,true,true,true)
        }
        surface_reset_target();_pushed=false
        matrix_set(matrix_world,_world);matrix_set(matrix_view,_view);matrix_set(matrix_projection,_projection)
        gpu_set_blendmode(appear>0?bm_normal:bm_add)
        draw_surface_ext(ntte_clone_surface,view_xview,view_yview,1/_scale,1/_scale,0,c_white,1)
    }
    finally {
        if(_pushed) surface_reset_target()
        matrix_set(matrix_world,_world);matrix_set(matrix_view,_view);matrix_set(matrix_projection,_projection)
        timescale=_ts;draw_set_color(_color);draw_set_alpha(_alpha);gpu_pop_state()
    }
}

// Original tegeneral.FireWeapon, restricted to Player-copy Allies. Native
// Alarm1 still chooses targets and creates a genuine AllyBullet; this object
// replaces that owned bullet with the copied physical weapon's real firing.
function scrNTTEFullCrystalFireWeaponCreate() {
    creator=noone;wep=wep_none;wep_setup=true;wepangle=0;gunspr=undefined;search_id=-1
    var _maximum=-1
    with(all) _maximum=max(_maximum,id)
    search_id=_maximum
}
function scrNTTEFullCrystalFireWeaponStep() {
    if(lockstep_stop) return;
    if(!instance_exists(creator)) {
        if(wep!=wep_none) {
            var _drop=scrWeaponPickupCreate(x,y,wep,true)
            _drop.ammo=true
        }
        var _owner=creator,_weapon=wep
        with(AllyBullet) if(id>other.search_id && scrNTTEFullValue(id,"creator",noone)==_owner) {
            // The owner has gone; fire from a real independent anchor and
            // retain the deceased creator in the resulting shot fields.
            var _anchor=instance_create(x,y,NTTEFullMergedEffectScheduler)
            _anchor.team=team;_anchor.wep=_weapon
            var _result=scrNTTEFullActorFire(_anchor,_weapon,direction,1,false,_anchor)
            for(var _j=0;_j<array_length(_result.shots);++_j) if(instance_exists(_result.shots[_j])) _result.shots[_j].creator=_owner
            instance_destroy(_anchor,false);instance_destroy(id,false)
        }
        instance_destroy();return;
    }
    if(wep_setup?variable_instance_exists(creator,"wep") && !is_undefined(creator.wep):!variable_instance_exists(creator,"wep") || creator.wep!=wep) {
        if(!is_undefined(gunspr)) creator.gunspr=gunspr
        instance_destroy();return;
    }
    if(wep_setup) {wep_setup=false;creator.wep=wep}
    var _owner=creator,_weapon=wep,_bullets=[]
    with(AllyBullet) if(id>other.search_id && scrNTTEFullValue(id,"creator",noone)==_owner) array_push(_bullets,id)
    if(array_length(_bullets)>0) {
        var _sound=scrNTTEFullValue(_owner,"ntte_clone_fire_sound",-1)
        if(_sound>=0) audio_stop_sound(_sound)
    }
    var _angle=scrNTTEFullValue(_owner,"wepangle",wepangle)
    if(scr_weapon_is_melee(_weapon) ^^ (_angle!=0)) _angle=scr_weapon_is_melee(_weapon)?choose(-120,120):0
    for(var _i=0;_i<array_length(_bullets);++_i) {
        var _bullet=_bullets[_i],_dir=_bullet.direction,_overlap=false
        with(_owner) _overlap=place_meeting(x,y,_bullet)
        if(variable_instance_exists(_owner,"gunangle") && _overlap && abs(angle_difference(_dir,_owner.gunangle))<10) _dir=_owner.gunangle
        var _result=scrNTTEFullActorFire(_owner,_weapon,_dir,1,false,_owner,
            {position:{x:_bullet.x,y:_bullet.y},direction_owner:noone,direction_rotation:0,accuracy_dynamic:false,team_override:_bullet.team,creator_override:_owner})
        if(instance_exists(_owner)) {
            _owner.ntte_state=_result.state;_owner.wkick=_result.wkick
            _angle=_result.wepangle*((abs(_result.wepangle)>1)?sign(_angle):_angle)
            if(_owner.friction!=0) {_owner.hspeed+=_result.hspeed;_owner.vspeed+=_result.vspeed}
            if(variable_instance_exists(_owner,"reload")) _owner.reload+=_result.reload
            if(_owner.alarm[1]>0) {
                var _load=_result.reload*power(2/3,scr_skill_get(mut_throne_butt))
                _owner.alarm[1]=max(1,_load)
            }
        }
        instance_destroy(_bullet,false)
    }
    if(array_length(_bullets)>0) {
        // Like instance_max in NTT, capture AFTER replacement so the weapon's
        // own projectiles cannot be recursively mistaken for native emissions.
        var _maximum=-1
        with(all) _maximum=max(_maximum,id)
        search_id=_maximum
        wepangle=_angle
        if(variable_instance_exists(_owner,"wepangle")) {wepangle*=-1;_owner.wepangle=wepangle}
        else if(variable_instance_exists(_owner,"gunangle") && variable_instance_exists(_owner,"gunspr")) _owner.gunangle+=wepangle
    }
    x=_owner.x;y=_owner.y;wep=_owner.wep
    _owner.gunspr=scrNTTEFullWeaponNativeSprite(wep,true,scrNTTEFullValue(_owner,"ntte_state",undefined))
}
function scrNTTEFullCrystalAllyDraw() {
    if(lockstep_stop) return;
    var _spr=scrNTTEFullValue(id,"gunspr",sprAllyGun),_dx=x+lengthdir_x(-wkick,gunangle),_dy=y+lengthdir_y(-wkick,gunangle)
    if(gunangle<=180 && sprite_index!=spr_appear) draw_sprite_ext(_spr,0,_dx,_dy,1,right,gunangle,c_white,image_alpha)
    draw_sprite_ext(sprite_index,-1,x,y,image_xscale*right,image_yscale,image_angle,image_blend,image_alpha)
    if(GameCont.underwater) draw_sprite(sprPlayerBubble,-1,x,y)
    if(gunangle>180 && sprite_index!=spr_appear) draw_sprite_ext(_spr,0,_dx,_dy,1,right,gunangle,c_white,1)
}

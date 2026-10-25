// Source temerge1235..1258,1411..1499 and telib4920,5041 capture the
// instances born during one synchronous firing event, using ID boundaries.
// The native same-event instance table appends births; its physical length
// includes pending-destroy slots. Never retain this token across an event.
function scrNTTEFullMergedCaptureBegin() {
    return {ntte_merged_capture_count:instance_count}
}
function scrNTTEFullMergedCaptureEnd(_token) {
    var _out=[],_end=instance_count
    for(var _i=_token.ntte_merged_capture_count;_i<_end;++_i) {
        var _new=instance_id[_i]
        if(instance_exists(_new)) array_push(_out,_new)
    }
    return _out
}

// Source temerge1303..2145, telib4737..5184. This dispatcher is separate
// from its real-creator mount so each native integration batch can be frozen.
function scrNTTEFullMergedRuntimeCopy(_value) {
    var _out={}
    if(is_struct(_value)) {
        var _names=variable_struct_get_names(_value)
        for(var _i=0;_i<array_length(_names);++_i) _out[$ _names[_i]]=_value[$ _names[_i]]
    }
    return _out
}
function scrNTTEFullMergedRuntimePart(_weapon) {
    var _model=scrNTTEFullWeaponModel(_weapon)
    if(!is_struct(_model)) _model={wep:_model}
    if(scrNTTEFullWeaponHasMerge(_model)!=false) {
        _model.temerge.wep[0]=scrNTTEFullMergedRuntimePart(_model.temerge.wep[0])
        scrNTTEFullWeaponSetMergedPart(_model,_model.temerge.wep[0])
    }
    return _model
}
function scrNTTEFullMergedRuntimeProjectiles(_instances) {
    var _out=[]
    for(var _i=0;_i<array_length(_instances);++_i)
        if(instance_exists(_instances[_i]) && instance_is(_instances[_i],projectile)) array_push(_out,_instances[_i])
    return _out
}
function scrNTTEFullMergedRuntimeNew(_before) {
    if(is_struct(_before) && variable_struct_exists(_before,"ntte_merged_capture_count")) return scrNTTEFullMergedCaptureEnd(_before)
    return scrNTTEFullMergedRuntimeDifference(_before,scrNTTEFullInstances(all))
}
function scrNTTEFullMergedRuntimePlain(_actor,_part,_fire_at,_primary,_consume=false) {
    var _at=scrNTTEFullMergedRuntimeCopy(_fire_at),_raw=scrNTTEFullWeaponRaw(_part),
        _state=scrNTTEFullWeaponNativeState(_part),_state_weapon=_state.weapon,
        _saved_state=scrNTTEFullValue(_actor,"ntte_state",undefined),
        _saved_back=scrNTTEFullValue(_actor,"bntte_state",undefined),
        _depth=variable_global_exists("ntte_full_merged_plain_depth") ? global.ntte_full_merged_plain_depth:0,
        _result=undefined
    // A native custom attack uses scrNTTEState's raw equality. Keep the exact
    // canonical part state object, including its in-flight weapon references.
    _at.creator=_actor; _at.wep=[_raw]
    _state.weapon=_raw; _actor.ntte_state=_state
    global.ntte_full_merged_plain_depth=_depth+1
    try {
        _result=scrNTTEFullMergedRuntimeStateFire(_actor,_part,_at,_consume,_primary)
        if(_at.wep[0]!=_raw) _part.wep=_at.wep[0]
    }
    finally {
        _state.weapon=_state_weapon
        if(instance_exists(_actor)) {
            _actor.ntte_state=_saved_state; _actor.bntte_state=_saved_back
        }
        global.ntte_full_merged_plain_depth=_depth
    }
    return _result
}
function scrNTTEFullMergedRuntimeInherit(_instances,_merges,_weapon) {
    var _projectiles=scrNTTEFullMergedRuntimeProjectiles(_instances)
    for(var _i=0;_i<array_length(_merges);++_i) scrNTTEFullMergeApplyEffects(_projectiles,_merges[_i],_weapon)
    // Genuine deferred native controllers carry the same references, rather
    // than cloning setup containers and repeating a stock's side effects.
    for(var _i=0;_i<array_length(_instances);++_i) {
        var _inst=_instances[_i]
        if(instance_exists(_inst) && scrNTTEFullMergedRuntimeIsDelayed(_inst))
            _inst.ntte_merged_runtime_inherit=_merges
    }
    return _projectiles
}
function scrNTTEFullMergedRuntimeKeep(_shot,_frame,_ultra,_offset) {
    if(!instance_exists(_shot) || !scrNTTEFullValue(_shot,"temerge_can_delete",true)) return _offset
    var _retain=false
    if(_ultra) {
        var _raw=scrNTTEFullWeaponRaw(_frame.weapon),_cost=scr_weapon_get_cost(_raw),_type=scr_weapon_get_type(_raw),
            _numerator=(_frame.ammo_cost==0 ? 1:_frame.ammo_cost)*(_frame.ammo_type==Ammo.Bullets ? 1/3:1),
            _denominator=(_cost==0 ? 1:_cost)*(_type==Ammo.Bullets ? 1/3:1)
        _retain=random(_denominator)<_numerator
    }
    if(_retain) {
        with(_shot) {
            team=round(team);temerge_can_setup=false;creator=noone
            if(object_index==Laser || object_index==EnemyLaser) {
                x=xstart;y=ystart;image_xscale=1;image_angle+=_offset;direction+=_offset
                event_perform(ev_alarm,0)
            }
            else if(speed!=0) {if(direction==image_angle) image_angle+=_offset;direction+=_offset}
            with(instance_create(x,y,Dust)) motion_add(other.direction,3*timescale)
        }
        return -_offset
    }
    with(_shot) {
        switch(object_index) {
            case LightningBall:case FlameBall:case BloodBall:
                if(variable_instance_exists(id,"snd") && (instance_number(object_index)<=1 || snd!=asset_get_index(audio_get_name(snd))))
                    audio_stop_sound(snd)
                break;
        }
        // Source instance_delete deliberately bypasses grenade/flak Destroy.
        instance_destroy(id,false)
    }
    return _offset
}
function scrNTTEFullMergedRuntimeClamp(_player,_old_speed) {
    if(!instance_exists(_player)) return;
    with(_player) {
        var _limit=max(_old_speed,maxspeed)
        if(speed>_limit) {
            var _dx=lengthdir_x(1,direction),_dy=lengthdir_y(1,direction)
            // Source speed is logical30Hz. Manual stacking push is likewise
            // logical distance; the retained motion is native physical speed.
            for(var _dis=(speed-_limit)/timescale/8;_dis>0;--_dis) {
                var _len=min(1,_dis)
                if(!place_free(x+_len*_dx,y+_len*_dy)) break
                x+=_len*_dx;y+=_len*_dy
            }
            speed=_limit
        }
    }
}
function scrNTTEFullMergedRuntimeReplace(_instances,_frame,_origin,_accuracy,_inherited,_primary) {
    var _sorted=scrNTTEFullMergeFireSort(_instances,_origin.x,_origin.y),_independent=false,
        _part=_frame.weapon,_front=scrNTTEFullWeaponMergedPart(_part),
        _reload=scr_weapon_get_load(_part),_results=[],_players=[],_speeds=[],
        _offset=choose(-90,90),_ultra=false
    with(Player) if(race==NTTEFullRace.Beetle && scrNTTEFullRaceUltraGet(id,2)) _ultra=true
    try {
        for(var _i=0;_i<array_length(_sorted);++_i) {
            var _shot=_sorted[_i]
            if(!instance_exists(_shot)) continue
            var _shot_wep=scrNTTEFullValue(_shot,"wep",undefined)
            if(!is_undefined(_shot_wep) && (_shot_wep==_part || scrNTTEFullWeaponRaw(_shot_wep)==scrNTTEFullWeaponRaw(_part))) {
                if(scrNTTEFullTridentWeaponProjectileRetain(_shot,_part)) continue
                var _sprite=scr_weapon_get_sprite(_shot_wep)
                if(_shot.sprite_index==_sprite) continue
                if(_shot.sprite_index==scrNTTEFullMergedRuntimeStockSprite(_part)) {
                    _shot.sprite_index=_sprite
                    if(is_array(_shot.hitid) && array_length(_shot.hitid)>1 && _shot.hitid[1]==_sprite) _shot.hitid[1]=_shot.sprite_index
                    continue
                }
            }
            var _was_active=_frame.has_shot
            if(scrNTTEFullMergeFireReplacement(_frame,false)) {
                if(instance_is(_shot,NTTEFullPortalBullet)) scrNTTEFullMergedPortalBind(_shot)
                var _geometry=scrNTTEFullMergeFireAt(_shot,_part,_origin.x,_origin.y,_origin.direction,_accuracy,_independent),_at=_geometry.at,
                    _merge={last_fire_vars:_frame,
                        on_fire:scrNTTEFullValue(_shot,"temerge_on_fire",undefined),on_setup:scrNTTEFullValue(_shot,"temerge_on_setup",undefined),
                        on_hit:scrNTTEFullValue(_shot,"temerge_on_hit",undefined),on_wall:scrNTTEFullValue(_shot,"temerge_on_wall",undefined),
                        on_destroy:scrNTTEFullValue(_shot,"temerge_on_destroy",undefined),
                        speed_factor:scrNTTEFullValue(_shot,"temerge_speed_factor",undefined),object:scrNTTEFullValue(_shot,"temerge_object",_shot.object_index),setup_vars:{}}
                _independent=_geometry.independent
                var _defaults=scrNTTEFullMergedStockEvents(_merge.object),_names=["fire","setup","hit","wall","destroy"]
                for(var _j=0;_j<5;++_j) {
                    var _field="on_"+_names[_j]
                    if(is_undefined(_merge[$ _field])) _merge[$ _field]=_defaults[$ _names[_j]]
                }
                if(!is_undefined(_merge.on_fire)) scrNTTEFullMergedEffectsCall(_shot,_frame.actor,_merge.on_fire,[_at,_merge.setup_vars])
                if(instance_exists(_shot)) {
                    var _can_cost=scrNTTEFullValue(_shot,"temerge_can_cost",true),_can_fire=scrNTTEFullValue(_shot,"temerge_can_fire",true),
                        _fire_part=is_array(_at.wep) ? _at.wep[0]:_at.wep
                    if(_can_cost || _can_fire) {
                        var _cost=scrNTTEFullMergeFireCost(_frame,scrNTTEFullMergedRuntimeActorOwner(_at.creator),_can_cost,scrNTTEFullWeaponHasMerge(_fire_part)==true,_can_fire)
                        if(_cost.can_fire) {
                            _part.temerge.wep_fire_frame=current_frame
                            var _creator=_at.creator
                            if(instance_exists(_creator) && instance_is(_creator,Player) && array_get_index(_players,_creator)<0) {
                                array_push(_players,_creator);array_push(_speeds,_creator.speed)
                            }
                            _merge.speed_factor=_at.speed_factor
                            var _merges=[_merge]
                            for(var _j=0;_j<array_length(_inherited);++_j) array_push(_merges,_inherited[_j])
                            var _emission=scrNTTEFullMergedRuntimeEmit(_at,_merges,_frame,_primary)
                            array_push(_results,_emission);_reload=min(_reload,_emission.reload)
                            if(!_emission.has_shot) scrNTTEFullMergeFireStop(_frame)
                        }
                    }
                }
            }
            if(_was_active) _frame.shot_count+=1
            _offset=scrNTTEFullMergedRuntimeKeep(_shot,_frame,_ultra,_offset)
        }
    }
    finally {
        for(var _i=0;_i<array_length(_players);++_i) scrNTTEFullMergedRuntimeClamp(_players[_i],_speeds[_i])
    }
    _part.temerge.wep_fire_reload=_reload
    return _results
}
function scrNTTEFullMergedRuntimePlayerFire(_actor,_weapon,_fire_at,_merges=undefined,_previous=undefined,_primary=true,_consume=false) {
    if(!is_array(_merges)) _merges=[]
    var _part=scrNTTEFullMergedRuntimePart(_weapon),_merged=scrNTTEFullWeaponHasMerge(_part)==true,
        _at=scrNTTEFullMergedRuntimeCopy(_fire_at),_before=scrNTTEFullMergedCaptureBegin(),_frame=undefined,_plain=undefined,
        _result={actor:_actor,weapon:_weapon,reload:0,wkick:0,has_shot:false,shots:[],frame:undefined}
    _at.creator=_actor
    if(_merged && _part.temerge.is_part) return _result
    if(_merged) {
        _part.temerge.fire_frame=current_frame
        _frame=scrNTTEFullMergeFireFrame(_part,scrNTTEFullMergedRuntimeActorOwner(_actor),_previous)
    }
    else if(is_struct(_previous)) {
        // A plain front still owns a real source pre/post transaction. It has
        // no further replacement costs: its parent paid before entering here.
        // No replacement dispatch is possible below this unmerged front.
        // Ancestor stock intervals and all transaction rollback still apply.
        _frame={last_vars:_previous,main_vars:_previous.main_vars,weapon:_part,has_shot:false,shot_is_delayed:false,
            ntte_merged_terminal_plain_front:true}
    }
    if(is_struct(_frame)) scrNTTEFullMergeTransactionBegin(_actor,scrNTTEFullMergedRuntimeActorOwner(_actor),_frame,!_merged,false)
    scrNTTEFullMergedRuntimeActorFrame(_actor,_frame)
    try {
        _plain=scrNTTEFullMergedRuntimePlain(_actor,_part,_at,_primary,!is_struct(_frame) && _consume)
        scrNTTEFullWeaponSkinProjectiles(_plain.shots,_part)
        if(is_struct(_frame)) {
            scrNTTEFullMergeTransactionCapture(_frame)
            scrNTTEFullMergeTransactionEnd(_frame)
            _result.has_shot=_frame.has_shot;_result.frame=_frame
        }
        else _result.has_shot=_plain.has_shot
        _result.reload=_plain.reload;_result.wkick=_plain.wkick
        if(_merged) {
            var _projectiles=scrNTTEFullMergedRuntimeProjectiles(_plain.shots),
                _origin={x:_actor.x,y:_actor.y,direction:_actor.gunangle}
            // Use the post-mount source creator position exactly as the source
            // projectile_setup main event does, including actual teleports.
            scrNTTEFullMergedRuntimeReplace(_projectiles,_frame,_origin,scrNTTEFullValue(_at,"accuracy",_actor.accuracy),_merges,_primary)
            for(var _i=0;_i<array_length(_plain.shots);++_i) {
                var _inst=_plain.shots[_i]
                if(instance_exists(_inst) && scrNTTEFullMergedRuntimeIsDelayed(_inst)) {
                    _inst.ntte_merged_runtime_stock={frame:_frame,weapon:_part,merges:_merges,primary:_primary,accuracy:scrNTTEFullValue(_at,"accuracy",_actor.accuracy)}
                }
            }
            _result.has_shot=_frame.has_shot
        }
        else scrNTTEFullMergedRuntimeInherit(_plain.shots,_merges,_part)
        _result.shots=scrNTTEFullMergedRuntimeNew(_before)
        _result.reload=_actor.reload;_result.wkick=_actor.wkick
    }
    finally {
        if(is_struct(_frame) && !_frame.transaction_closed) scrNTTEFullMergeTransactionEnd(_frame,false)
        scrNTTEFullCrabboneTransferQueue(_actor,_part,_fire_at)
        scrNTTEFullCrabboneTransferFlush()
        scrNTTEFullTridentMergedQueue(_actor,_part,_fire_at,_primary)
        scrNTTEFullTridentMergedFlush()
    }
    return _result
}
function scrNTTEFullMergedRuntimeEmit(_at,_merges,_previous,_primary) {
    var _creator=_at.creator,_weapon=is_array(_at.wep) ? _at.wep[0]:_at.wep
    if(!instance_exists(_creator)) return {reload:0,wkick:0,has_shot:false,shots:[]}
    if(instance_is(_creator,Player)) return scrNTTEFullMergedRuntimePlayerFire(_creator,_weapon,_at,_merges,_previous,_primary)
    // ActorFireMount's native proxy keeps the real non-Player creator/team;
    // its raw scrFire entry consumes this narrowly scoped nested request.
    var _request=variable_global_exists("ntte_full_merged_request") ? global.ntte_full_merged_request:undefined,
        _result=undefined
    global.ntte_full_merged_request={merges:_merges,previous:_previous,primary:_primary}
    try { _result=scrNTTEFullActorFireMount(_creator,_at,_creator,false); }
    finally { global.ntte_full_merged_request=_request; }
    _result.has_shot=scrNTTEFullValue(_result,"has_shot",false) || array_length(_result.shots)>0
    return _result
}
function scrNTTEFullMergedRuntimeEntry(_weapon,_consume=true,_primary=true) {
    var _request=variable_global_exists("ntte_full_merged_request") ? global.ntte_full_merged_request:undefined,
        _merges=is_struct(_request) ? _request.merges:[],_previous=is_struct(_request) ? _request.previous:undefined,
        _part=scrNTTEFullWeaponModel(_weapon),_at={creator:id,wep:_weapon}
    // The request belongs to exactly one ActorFireMount proxy invocation.
    global.ntte_full_merged_request=undefined
    if(scrNTTEFullWeaponHasMerge(_part)==true && is_struct(_part.temerge.fire_at_vars)) _at=scrNTTEFullMergedRuntimeCopy(_part.temerge.fire_at_vars)
    _at.ntte_trident_transfer_refs=scrNTTEFullValue(id,"ntte_trident_transfer_refs",[])
    _at.ntte_crabbone_transfer_refs=scrNTTEFullValue(id,"ntte_crabbone_transfer_refs",[])
    var _result=scrNTTEFullMergedRuntimePlayerFire(id,_weapon,_at,_merges,_previous,_primary,_consume)
    if(variable_instance_exists(id,"ntte_merged_actor_owner")) ntte_merged_actor_result=_result
    return _result.has_shot
}
function scrNTTEFullMergedRuntimeEventBegin() {
    var _stock=scrNTTEFullValue(id,"ntte_merged_runtime_stock",undefined),
        _merges=scrNTTEFullValue(id,"ntte_merged_runtime_inherit",undefined)
    if(!is_struct(_stock) && !is_array(_merges)) return undefined
    if(scrNTTEFullValue(id,"ntte_merged_runtime_event_active",false)) return undefined
    ntte_merged_runtime_event_active=true
    var _skin_at=scrNTTEFullValue(id,"ntte_merged_runtime_at",undefined)
    return {skin_part:scrNTTEFullValue(_skin_at,"part",undefined),source:id,before:scrNTTEFullMergedCaptureBegin(),stock:_stock,merges:_merges,
        creator:scrNTTEFullValue(id,"creator",noone),x:x,y:y,direction:direction}
}
function scrNTTEFullMergedRuntimeEventEnd(_state) {
    if(!is_struct(_state)) return;
    if(instance_exists(_state.source)) _state.source.ntte_merged_runtime_event_active=false
    var _new=scrNTTEFullMergedRuntimeNew(_state.before),_stock=_state.stock
    scrNTTEFullWeaponSkinProjectiles(_new,_state.skin_part)
    if(is_struct(_stock)) {
        var _creator=_state.creator,_origin={x:scrNTTEFullValue(_creator,"x",_state.x),y:scrNTTEFullValue(_creator,"y",_state.y),
            direction:scrNTTEFullValue(_creator,"gunangle",_state.direction)}
        scrNTTEFullMergedRuntimeReplace(scrNTTEFullMergedRuntimeProjectiles(_new),_stock.frame,_origin,_stock.accuracy,_stock.merges,_stock.primary)
        for(var _i=0;_i<array_length(_new);++_i) if(instance_exists(_new[_i]) && scrNTTEFullMergedRuntimeIsDelayed(_new[_i]))
            _new[_i].ntte_merged_runtime_stock=_stock
    }
    else scrNTTEFullMergedRuntimeInherit(_new,_state.merges,undefined)
}

function scrNTTEFullMergedRuntimeDifference(_before,_after) {
    var _seen={},_out=[]
    for(var _i=0;_i<array_length(_before);++_i) {
        var _value=_before[_i],_key=string(real(_value)),_bucket=[]
        if(variable_struct_exists(_seen,_key)) _bucket=_seen[$ _key]
        array_push(_bucket,_value);_seen[$ _key]=_bucket
    }
    for(var _i=0;_i<array_length(_after);++_i) {
        var _value=_after[_i],_key=string(real(_value))
        if(variable_struct_exists(_seen,_key) && array_get_index(_seen[$ _key],_value)>=0) continue
        array_push(_out,_value)
    }
    return _out
}

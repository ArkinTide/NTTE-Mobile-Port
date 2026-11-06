// Frozen literal pre-terminal-marker code, extracted before optimization.
// Birth-capture behavior is already present; only terminal sound work changes.

function scrNTTEFullMergedTerminalOldSnapshot(_actor,_owner,_frame) {
    if(!instance_exists(_actor) || !is_struct(_frame)) throw "Merged transaction requires its actual live actor/frame"
    _frame.actor=_actor; _frame.owner=_owner; _frame.frame=current_frame
    _frame.x=_actor.x; _frame.y=_actor.y; _frame.hspeed=_actor.hspeed; _frame.vspeed=_actor.vspeed
    _frame.wepangle=scrNTTEFullValue(_actor,"wepangle",1)
    _frame.wkick=scrNTTEFullValue(_actor,"wkick",0); _frame.reload=scrNTTEFullValue(_actor,"reload",0)
    _frame.infammo=scrNTTEFullValue(_actor,"infammo",0)
    _frame.ammo=instance_exists(_owner) && instance_is(_owner,Player) ? scrNTTEFullArrayCopy(_owner.ammo):undefined
    _frame.rads=GameCont.rad; _frame.shake=scrNTTEFullMergeTransactionCameraSnapshot()
    _frame.opt_shake=UberCont.opt_shake; _frame.opt_freeze=UberCont.opt_freeze
    _frame.before_instances=scrNTTEFullMergedCaptureBegin(); _frame.assets=[]
    _frame.min_sound_id=scrNTTEFullMergeTransactionSoundMarker(); _frame.max_sound_id=_frame.min_sound_id
    _frame.transaction_captured=false; _frame.transaction_closed=false
    return _frame
}
function scrNTTEFullMergedTerminalOldBegin(_actor,_owner,_frame,_front=false,_precharged=false) {
    scrNTTEFullMergedTerminalOldSnapshot(_actor,_owner,_frame)
    _frame.is_front=_front
    var _previous=scrNTTEFullValue(_frame,"last_vars",undefined)
    if(is_struct(_previous)) {
        var _main=_previous.main_vars
        if(!is_struct(_main) || !variable_struct_exists(_main,"x")) throw "Merged ancestor transaction was not begun"
        _frame.main_vars=_main
        if(_frame.frame>_main.frame) {
            // A later deferred emission establishes a fresh baseline. Source
            // costs/infammo remain those of the original root weapon.
            var _keys=["frame","x","y","hspeed","vspeed","wepangle","wkick","reload","ammo","rads","shake","opt_shake","opt_freeze"]
            for(var _i=0;_i<array_length(_keys);++_i) _main[$ _keys[_i]]=_frame[$ _keys[_i]]
        } else {
            with(_actor) {
                x=_main.x; y=_main.y; hspeed=_main.hspeed; vspeed=_main.vspeed
                wepangle=abs(wepangle)*sign(_main.wepangle)
            }
            scrNTTEFullMergeTransactionCameraRestore(_main.shake)
        }
    } else {
        _frame.main_vars=_frame
        if(_precharged && _frame.infammo==0) {
            if(instance_is(_actor,Player)) {
                _actor.ammo[_frame.ammo_type]+=_frame.ammo_cost
                if(instance_exists(_owner) && instance_is(_owner,Player)) _frame.ammo=scrNTTEFullArrayCopy(_owner.ammo)
            }
            GameCont.rad+=_frame.rads_cost; _frame.rads=GameCont.rad
        }
    }
    _actor.wkick=0
    if(!_front) { UberCont.opt_shake=0; UberCont.opt_freeze=0 }
    return _frame
}
function scrNTTEFullMergedTerminalOldCapture(_frame) {
    if(_frame.transaction_captured) return _frame.assets
    var _now=scrNTTEFullMergedRuntimeNew(_frame.before_instances)
    for(var _i=0;_i<array_length(_now);++_i)
        array_push(_frame.assets,_now[_i])
    _frame.max_sound_id=scrNTTEFullMergeTransactionSoundMarker()
    _frame.transaction_captured=true
    return _frame.assets
}
function scrNTTEFullMergedTerminalOldEnd(_frame,_has_shot=undefined) {
    if(_frame.transaction_closed) return _frame.has_shot
    scrNTTEFullMergedTerminalOldCapture(_frame)
    if(is_undefined(_has_shot)) {
        _has_shot=false
        for(var _i=0;_i<array_length(_frame.assets);++_i) {
            var _inst=_frame.assets[_i]
            if(instance_exists(_inst) && instance_is(_inst,projectile)) { _has_shot=true; break }
        }
        if(!_has_shot) for(var _i=0;_i<array_length(_frame.assets);++_i) {
            var _inst=_frame.assets[_i]
            if(instance_exists(_inst) && variable_instance_exists(_inst,"team")) {
                _has_shot=true; _frame.shot_is_delayed=true; break
            }
        }
    }
    _frame.has_shot=_has_shot
    var _actor=_frame.actor,_main=_frame.main_vars
    try {
        if(_has_shot && instance_exists(_actor)) with(_actor) {
            if(sign(wepangle)!=sign(_main.wepangle)) {
                if(!variable_struct_exists(_main,"wepangle_side_frame") || current_frame-_main.wepangle_side_frame>1)
                    _main.wepangle_side=sign(wepangle)
                _main.wepangle_side_frame=current_frame
            }
            if(variable_struct_exists(_main,"wepangle_side")) wepangle=abs(wepangle)*sign(_main.wepangle_side)
            if(wkick==0) wkick=_frame.wkick
            else if(_frame!=_main) wkick=max(abs(wkick),abs(_frame.wkick))*((wkick<0 || _frame.wkick<0) ? -1:1)
            x+=_frame.x-_main.x; y+=_frame.y-_main.y
            hspeed+=_frame.hspeed-_main.hspeed; vspeed+=_frame.vspeed-_main.vspeed
            scrNTTEFullMergeTransactionCameraCombine(_frame.shake,_main.shake)
        }
        else if(!_has_shot) {
            scrNTTEFullMergeTransactionUndoStocks(_frame)
            if(instance_exists(_actor)) with(_actor) {
                wepangle=abs(wepangle)*sign(_main.wepangle)
                if(wkick==0) wkick=_main.wkick
            }
        }
        if(!_frame.is_front) {
            if(instance_exists(_frame.owner) && instance_is(_frame.owner,Player) && is_array(_frame.ammo))
                _frame.owner.ammo=scrNTTEFullArrayCopy(_frame.ammo)
            GameCont.rad=_frame.rads
        }
        if(instance_exists(_actor) && _actor.reload<=0 && _frame.reload>0)
            _actor.reload=max(_actor.reload,scrNTTEFullValue(_actor,"reloadspeed",1)*timescale)
    } finally {
        UberCont.opt_shake=_frame.opt_shake; UberCont.opt_freeze=_frame.opt_freeze
        _frame.transaction_closed=true
    }
    return _frame.has_shot
}
function scrNTTEFullMergedTerminalOldReplace(_instances,_frame,_origin,_accuracy,_inherited,_primary) {
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
                            var _emission=scrNTTEFullMergedTerminalOldEmit(_at,_merges,_frame,_primary)
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
function scrNTTEFullMergedTerminalOldPlayerFire(_actor,_weapon,_fire_at,_merges=undefined,_previous=undefined,_primary=true,_consume=false) {
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
        _frame={last_vars:_previous,main_vars:_previous.main_vars,weapon:_part,has_shot:false,shot_is_delayed:false}
    }
    if(is_struct(_frame)) scrNTTEFullMergedTerminalOldBegin(_actor,scrNTTEFullMergedRuntimeActorOwner(_actor),_frame,!_merged,false)
    scrNTTEFullMergedRuntimeActorFrame(_actor,_frame)
    try {
        _plain=scrNTTEFullMergedRuntimePlain(_actor,_part,_at,_primary,!is_struct(_frame) && _consume)
        scrNTTEFullWeaponSkinProjectiles(_plain.shots,_part)
        if(is_struct(_frame)) {
            scrNTTEFullMergedTerminalOldCapture(_frame)
            scrNTTEFullMergedTerminalOldEnd(_frame)
            _result.has_shot=_frame.has_shot;_result.frame=_frame
        }
        else _result.has_shot=_plain.has_shot
        _result.reload=_plain.reload;_result.wkick=_plain.wkick
        if(_merged) {
            var _projectiles=scrNTTEFullMergedRuntimeProjectiles(_plain.shots),
                _origin={x:_actor.x,y:_actor.y,direction:_actor.gunangle}
            // Use the post-mount source creator position exactly as the source
            // projectile_setup main event does, including actual teleports.
            scrNTTEFullMergedTerminalOldReplace(_projectiles,_frame,_origin,scrNTTEFullValue(_at,"accuracy",_actor.accuracy),_merges,_primary)
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
        if(is_struct(_frame) && !_frame.transaction_closed) scrNTTEFullMergedTerminalOldEnd(_frame,false)
        scrNTTEFullCrabboneTransferQueue(_actor,_part,_fire_at)
        scrNTTEFullCrabboneTransferFlush()
        scrNTTEFullTridentMergedQueue(_actor,_part,_fire_at,_primary)
        scrNTTEFullTridentMergedFlush()
    }
    return _result
}
function scrNTTEFullMergedTerminalOldEmit(_at,_merges,_previous,_primary) {
    var _creator=_at.creator,_weapon=is_array(_at.wep) ? _at.wep[0]:_at.wep
    if(!instance_exists(_creator)) return {reload:0,wkick:0,has_shot:false,shots:[]}
    if(instance_is(_creator,Player)) return scrNTTEFullMergedTerminalOldPlayerFire(_creator,_weapon,_at,_merges,_previous,_primary)
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

function scrNTTEFullMergedTerminalSoundReset(_p) {
    _p.x=58200;_p.y=58200;_p.xprevious=_p.x;_p.yprevious=_p.y
    _p.hspeed=0;_p.vspeed=0;_p.gunangle=0;_p.accuracy=0;_p.race=Race.Fish
    _p.infammo=0;_p.ntte_race_ultra=0;_p.ntte_native_race=-1
    _p.ammo=array_create(Ammo.NUM_AMMO_TYPES,100);_p.wepangle=1;_p.wkick=0;_p.reload=0;_p.reloadspeed=1
    _p.bwep=wep_none;_p.ntte_merged_actor_frames=[]
    GameCont.rad=100;GameCont.temerge_effect_vars_map={};GameCont.temerge_effect_call_step_instance_list=[]
    UberCont.opt_shake=1;UberCont.opt_freeze=1
    global.ntte_full_merged_plain_depth=0;global.ntte_full_merged_request=undefined
    global.ntte_full_merged_input_weapon=undefined;global.__debug_infammo=false
    global.ntte_full_merge_sound_marker_observer=[]
}
function scrNTTEFullMergedTerminalSoundRows(_p,_result,_bolts) {
    var _rows=[]
    for(var _i=0;_i<array_length(_bolts);++_i) {
        var _b=_bolts[_i]
        array_push(_rows,[_b.x,_b.y,_b.xstart,_b.ystart,_b.direction,_b.speed,_b.damage,
            _b.knockback_speed,_b.sprite_index,_b.image_angle,_b.creator==_p,typeof(_b.creator),_b.team,
            array_length(_b.temerge_vars_list),_b.temerge_vars_list[0].last_fire_vars==_result.frame,
            scrNTTEFullMergedProjectileHasEffect(_b,"piercing"),_b.temerge_piercing_amount,
            scrNTTEFullMergedProjectileHasEffect(_b,"trail")])
    }
    return json_stringify({shots:_rows,ammo:_p.ammo,rad:GameCont.rad,has:_result.has_shot,
        x:_p.x,y:_p.y,hspeed:_p.hspeed,vspeed:_p.vspeed,reload:_p.reload,wkick:_p.wkick,wepangle:_p.wepangle,
        count:_result.frame.shot_count,replacements:_result.frame.shot_replace_count})
}
function scrNTTEFullMergedTerminalSoundNativeTests() {
    var _before=scrNTTEFullInstances(all),_players=scrNTTEFullAreaGeneratorSnapshot(Player),
        _game=scrNTTEFullAreaGeneratorSnapshot(GameCont),_back=scrNTTEFullAreaGeneratorSnapshot(BackCont),
        _uber=scrNTTEFullAreaGeneratorSnapshot(UberCont),_seed=random_get_seed(),
        _streams=scrNTTEFullArrayCopy(global.rng_state),_tick=current_frame,
        _observer=variable_global_exists("ntte_full_merge_sound_marker_observer")?global.ntte_full_merge_sound_marker_observer:undefined,
        _depth=variable_global_exists("ntte_full_merged_plain_depth")?global.ntte_full_merged_plain_depth:0,
        _request=variable_global_exists("ntte_full_merged_request")?global.ntte_full_merged_request:undefined,
        _input=variable_global_exists("ntte_full_merged_input_weapon")?global.ntte_full_merged_input_weapon:undefined,
        _scope=variable_global_exists("ntte_full_merged_state_fire")?global.ntte_full_merged_state_fire:undefined,
        _muffles=variable_global_exists("ntte_merge_muffle")?global.ntte_merge_muffle:[],
        _infammo=global.__debug_infammo,_channel=-1,_gain=audio_sound_get_gain(sndPistol)
    scrNTTEFullWeaponNativeInit()
    var _models=scrNTTEFullArrayCopy(global.ntte_full_native_weapon_models)
    try {
        with(Player) {race=Race.Fish;ntte_race_ultra=0}
        var _p=instance_create(58200,58200,Player),_local=scrNTTEFullInstances(all),
            _expected=undefined,_expected_seed=undefined,_expected_streams=undefined
        _p.index=instance_find(Player,0).index
        // Literal frozen old dispatch/transaction functions exercise the same
        // native Super Crossbow and Golden Crossbow code as the new path.
        for(var _impl=0;_impl<2;++_impl) {
            scrNTTEFullMergedTerminalSoundReset(_p)
            random_set_seed(71493);global.rng_state=scrNTTEFullArrayCopy(_streams)
            current_frame=_tick;global.ntte_full_native_weapon_models=scrNTTEFullArrayCopy(_models)
            var _weapon=scrNTTEFullWeaponMerge(wep_super_crossbow,wep_golden_crossbow),
                _handle=scrNTTEFullWeaponNative(_weapon),_fn=_impl==0
                    ?scrNTTEFullMergedTerminalOldPlayerFire:scrNTTEFullMergedRuntimePlayerFire
            _p.wep=_handle;_p.ntte_state=scrNTTEFullWeaponNativeState(_handle)
            var _result=_fn(_p,_handle,{creator:_p}),_bolts=scrNTTEFullMergedRuntimeTestShots(_result.shots,Bolt),
                _frames=_p.ntte_merged_actor_frames,_rows=scrNTTEFullMergedTerminalSoundRows(_p,_result,_bolts)
            assert(array_length(_bolts)==5 && array_length(_frames)==6 && _result.has_shot && _p.wep==_handle,
                "Terminal marker fixture lost actual five Golden Crossbow shots, six real transactions or held inventory")
            assert(array_length(global.ntte_full_merge_sound_marker_observer)==(_impl==0?12:2),
                "Actual Super Golden Crossbow did not reduce precisely twelve sound markers to the root pair")
            assert(!scrNTTEFullValue(_frames[0],"ntte_merged_terminal_plain_front",false),
                "Merged root was incorrectly declared a terminal plain front")
            if(_impl==0) {_expected=_rows;_expected_seed=random_get_seed();_expected_streams=json_stringify(global.rng_state)}
            else {
                assert(_rows==_expected && random_get_seed()==_expected_seed && json_stringify(global.rng_state)==_expected_streams,
                    "Terminal markers changed frozen-old native ordered shots, effects, resources, physical motion or either RNG stream")
                for(var _i=1;_i<array_length(_frames);++_i)
                    assert(_frames[_i].ntte_merged_terminal_plain_front && _frames[_i].min_sound_id== -1
                        && _frames[_i].max_sound_id== -1 && _frames[_i].last_vars==_result.frame
                        && _frames[_i].transaction_captured && _frames[_i].transaction_closed,
                        "Plain front lost sealed real transaction/stock ancestor or retained unused marker channels")
            }
            scrNTTEFullMergedRuntimeTestCleanup(_local)
        }
        // Nested Assault Rifle is a real STOCK despite being its parent's
        // front. Its native Burst keeps that exact stock for deferred shots.
        scrNTTEFullMergedTerminalSoundReset(_p)
        _weapon=scrNTTEFullWeaponMerge(wep_revolver,wep_assault_rifle)
        scrNTTEFullWeaponMerge(_weapon,wep_golden_crossbow)
        _handle=scrNTTEFullWeaponNative(_weapon);_p.wep=_handle;_p.ntte_state=scrNTTEFullWeaponNativeState(_handle)
        _result=scrNTTEFullMergedRuntimePlayerFire(_p,_handle,{creator:_p})
        var _controllers=scrNTTEFullMergedRuntimeTestShots(_result.shots,Burst),_frames=_p.ntte_merged_actor_frames
        assert(array_length(_controllers)==1 && array_length(_frames)==3
            && array_length(global.ntte_full_merge_sound_marker_observer)==4,
            "Nested merged stock lost its own two markers or terminal front unexpectedly allocated markers")
        var _root=_frames[0],_mid=_frames[1],_interval=[_root.min_sound_id,_root.max_sound_id,_mid.min_sound_id,_mid.max_sound_id]
        assert(!_root.is_front && !_mid.is_front && _mid.last_vars==_root
            && _controllers[0].ntte_merged_runtime_stock.frame==_mid
            && !scrNTTEFullValue(_mid,"ntte_merged_terminal_plain_front",false),
            "Nested stock/deferred controller inherited the terminal suppression flag")
        current_frame+=2;with(_controllers[0]) event_perform(ev_alarm,0)
        current_frame+=2;with(_controllers[0]) event_perform(ev_alarm,0)
        _bolts=scrNTTEFullMergedRuntimeTestShots(scrNTTEFullMergedRuntimeNew(_local),Bolt)
        assert(array_length(_bolts)==3 && array_length(global.ntte_full_merge_sound_marker_observer)==4
            && json_stringify(_interval)==json_stringify([_root.min_sound_id,_root.max_sound_id,_mid.min_sound_id,_mid.max_sound_id])
            && _root.frame==current_frame && _root.main_vars==_root,
            "Deferred terminal fronts changed stock sound intervals or failed to advance the real main baseline")
        for(var _i=0;_i<array_length(_bolts);++_i)
            assert(array_length(_bolts[_i].temerge_vars_list)==2
                && _bolts[_i].temerge_vars_list[0].last_fire_vars==_mid
                && _bolts[_i].temerge_vars_list[1].last_fire_vars==_root,
                "Deferred final projectile stored terminal frame instead of the two real stock ancestors")
        scrNTTEFullMergedRuntimeTestCleanup(_local)
        // An actual failed plain front must still undo the sealed grenade
        // stock, preserving its native sound interval and later unrelated data.
        scrNTTEFullMergedTerminalSoundReset(_p);global.ntte_merge_muffle=[]
        var _stock=scrNTTEFullMergeFireFrame(scrNTTEFullWeaponMerge(wep_grenade_launcher,wep_revolver),_p)
        scrNTTEFullMergeTransactionBegin(_p,_p,_stock)
        _channel=audio_play_sound(sndPistol,1,true,0)
        assert(_channel>=0 && audio_is_playing(_channel),"Terminal sound regression requires --enable-audio and a real playable audio device")
        with(_p) scrFire(wep_grenade_launcher,false)
        scrNTTEFullMergeTransactionEnd(_stock)
        var _grenades=scrNTTEFullMergedRuntimeTestShots(_stock.assets,Grenade),
            _later=instance_create(_p.x+100,_p.y,Dust),_explosions=instance_number(Explosion),
            _minimum=_stock.min_sound_id,_maximum=_stock.max_sound_id
        assert(array_length(_grenades)==1 && _minimum>=0 && _maximum>_minimum
            && _channel>=_minimum && _channel<_maximum,"Audio fixture did not seal its real stock channel range")
        var _failed=scrNTTEFullMergedRuntimePlayerFire(_p,wep_none,{creator:_p},[],_stock)
        assert(!_failed.has_shot && _failed.frame.min_sound_id== -1 && _failed.frame.max_sound_id== -1
            && !instance_exists(_grenades[0]) && instance_exists(_later) && instance_number(Explosion)==_explosions
            && _stock.min_sound_id==_minimum && _stock.max_sound_id==_maximum
            && array_length(global.ntte_full_merge_sound_marker_observer)==2,
            "Failed terminal front lost stock-only no-Destruct rollback, untouched ancestor interval or suppression")
        var _registered=false
        for(var _i=0;_i<array_length(global.ntte_merge_muffle);++_i)
            if(global.ntte_merge_muffle[_i].sound==sndPistol && global.ntte_merge_muffle[_i].sound_id==_channel) _registered=true
        assert(_registered && audio_sound_get_gain(sndPistol)==_gain,"Failed terminal front did not muffle its actual stock sound interval")
        current_frame+=2
        _failed=scrNTTEFullMergedRuntimePlayerFire(_p,wep_none,{creator:_p},[],_stock)
        assert(abs(audio_sound_get_gain(sndPistol)-lerp(_gain,_gain*0.1,0.2))<0.0001
            && array_length(global.ntte_full_merge_sound_marker_observer)==2,
            "Repeated failed terminal front lost source per-frame attenuation or added terminal markers")
        audio_stop_sound(_channel);_channel=-1
        scrNTTEFullMergeTransactionMuffleRestore()
        assert(audio_sound_get_gain(sndPistol)==_gain,"Stock audio restoration changed after terminal suppression")
        // The public front argument does not prove terminality. Its existing
        // explicit callers keep both markers even with _front=true.
        var _generic=scrNTTEFullMergeFireFrame(scrNTTEFullWeaponMerge(wep_revolver,wep_revolver),_p)
        scrNTTEFullMergeTransactionBegin(_p,_p,_generic,true)
        scrNTTEFullMergeTransactionEnd(_generic,false)
        assert(_generic.is_front && _generic.min_sound_id>=0 && _generic.max_sound_id>_generic.min_sound_id
            && array_length(global.ntte_full_merge_sound_marker_observer)==4,
            "Generic TransactionBegin front argument incorrectly suppressed required sound markers")
        scrNTTESmokeLog("FULL MERGED TERMINAL SOUND: actual Super Golden Crossbow frozen-old 12->2 markers, five ordered shots/effects/resources/RNG, nested stock/deferred ancestors and failed-front no-Destruct rollback OK @"+string(30/timescale))
        scrNTTESmokeLog("FULL MERGED TERMINAL SOUND AUDIO: real stock interval muffle and restoration assertions executed OK @"+string(30/timescale))
    }
    finally {
        if(_channel>=0) audio_stop_sound(_channel)
        scrNTTEFullMergeTransactionMuffleRestore();global.ntte_merge_muffle=_muffles
        audio_sound_gain(sndPistol,_gain,0)
        scrNTTEFullMergedRuntimeTestCleanup(_before)
        scrNTTEFullAreaGeneratorRestore(_players);scrNTTEFullAreaGeneratorRestore(_game)
        scrNTTEFullAreaGeneratorRestore(_back);scrNTTEFullAreaGeneratorRestore(_uber)
        global.ntte_full_native_weapon_models=_models;global.ntte_full_merge_sound_marker_observer=_observer
        global.ntte_full_merged_plain_depth=_depth;global.ntte_full_merged_request=_request
        global.ntte_full_merged_input_weapon=_input;global.ntte_full_merged_state_fire=_scope
        global.__debug_infammo=_infammo;global.rng_state=_streams;current_frame=_tick;random_set_seed(_seed)
    }
}

// NTTE2.062 temerge2149..2609,4644..5010. This is the scheduler and
// projectile-event infrastructure, not substitutes for unported effect bodies.
function scrNTTEFullMergedEffectRef(_fn,_args=undefined) {
    return {ntte_effect_ref:true,fn:_fn,args:is_array(_args)?_args:[]}
}
function scrNTTEFullMergedEffectsInvoke(_target,_fn,_args) {
    // The VM ignores method binding in script_execute_ext. Enter the actual
    // instance explicitly, retaining the caller as other and arbitrary args.
    var _result=undefined
    with(_target) _result=script_execute_ext(_fn,_args)
    return _result
}
function scrNTTEFullMergedEffectsCall(_target,_other,_ref,_args=undefined) {
    if(!instance_exists(_target)) return undefined
    var _fn=_ref,_combined=[]
    if(is_struct(_ref) && scrNTTEFullValue(_ref,"ntte_effect_ref",false)) {
        _fn=_ref.fn
        for(var _i=0;_i<array_length(_ref.args);++_i) array_push(_combined,_ref.args[_i])
    }
    if(is_array(_args)) for(var _i=0;_i<array_length(_args);++_i) array_push(_combined,_args[_i])
    if(!is_callable(_fn)) throw "Merged callback is not callable"
    if(!instance_exists(_other)) _other=_target
    var _result=undefined
    // A method's other is its native caller: invoke FROM the requested other,
    // with the requested target as bound self. Never retain the creator's self.
    with(_other) _result=scrNTTEFullMergedEffectsInvoke(_target,_fn,_combined)
    return _result
}
function scrNTTEFullMergedEffectsList(_value) { return is_array(_value)?_value:[_value] }
function scrNTTEFullMergedEffectsLive(_list) {
    var _live=[]
    for(var _i=0;_i<array_length(_list);++_i) if(instance_exists(_list[_i])) array_push(_live,_list[_i])
    return _live
}
function scrNTTEFullMergedEffectsRemove(_list,_value) {
    var _out=[]
    for(var _i=0;_i<array_length(_list);++_i) if(_list[_i]!=_value) array_push(_out,_list[_i])
    return _out
}
function scrNTTEFullMergedEffectsInit() {
    if(variable_global_exists("ntte_full_merge_effect_initialized") && global.ntte_full_merge_effect_initialized
        && variable_global_exists("ntte_full_merge_effect_registry") && is_struct(global.ntte_full_merge_effect_registry)) return;
    global.ntte_full_merge_effect_initialized=true
    global.ntte_full_projectile_merge_effect=scrNTTEFullMergedProjectileAddEffect
    if(!variable_global_exists("ntte_full_merge_effect_registry") || !is_struct(global.ntte_full_merge_effect_registry)) global.ntte_full_merge_effect_registry={}
    scrNTTEFullMergedEffectAddEvent("hit_event","post_step",scrNTTEFullMergedEffectRef(scrNTTEFullMergedCollisionPost,["hit"]))
    scrNTTEFullMergedEffectAddEvent("wall_event","post_step",scrNTTEFullMergedEffectRef(scrNTTEFullMergedCollisionPost,["wall"]))
    scrNTTEFullMergedEffectAddEvent("destroy_event","post_step",scrNTTEFullMergedDestroyPost)
    scrNTTEFullMergedEffectAddEvent("fixed_plasma_speed_factor","begin_step",scrNTTEFullMergedFixedPlasmaBegin)
    scrNTTEFullMergedEffectAddEvent("fixed_seeker_speed_factor","step",scrNTTEFullMergedFixedSeekerStep)
    scrNTTEFullMergedEffectAddEvent("fixed_rocket_speed_factor","step",scrNTTEFullMergedFixedRocketStep)
    scrNTTEFullMergedEffectAddEvent("fixed_scale","draw",scrNTTEFullMergedFixedScaleDraw)
    scrNTTEFullMergedEffectAddEvent("fixed_lightning_yscale","draw",scrNTTEFullMergedFixedLightningDraw)
    scrNTTEFullMergedBasicInit()
    scrNTTEFullMergedPayloadInit()
    scrNTTEFullMergedExplosiveInit()
    scrNTTEFullMergedMotionInit()
    scrNTTEFullMergedEnergyInit()
    scrNTTEFullMergedHyperInit()
    scrNTTEFullMergedLightningInit()
}
function scrNTTEFullMergedEffectAddEvent(_effect,_event,_callback) {
    if(!variable_global_exists("ntte_full_merge_effect_registry") || !is_struct(global.ntte_full_merge_effect_registry)) global.ntte_full_merge_effect_registry={}
    var _entry=scrNTTEFullValue(global.ntte_full_merge_effect_registry,_effect,undefined)
    if(is_undefined(_entry)) {
        _entry={events:{},event_order:[]}
        variable_struct_set(global.ntte_full_merge_effect_registry,_effect,_entry)
    }
    var _callbacks=scrNTTEFullValue(_entry.events,_event,undefined)
    if(!is_array(_callbacks)) { _callbacks=[];array_push(_entry.event_order,_event) }
    // Repeated references are deliberate source behavior, not a set.
    array_push(_callbacks,_callback);variable_struct_set(_entry.events,_event,_callbacks)
}
function scrNTTEFullMergedEffectVars(_name,_create=false) {
    if(!instance_exists(GameCont)) return undefined
    if(!variable_instance_exists(GameCont,"temerge_effect_vars_map")) {
        if(!_create) return undefined
        GameCont.temerge_effect_vars_map={}
    }
    var _vars=scrNTTEFullValue(GameCont.temerge_effect_vars_map,_name,undefined)
    if(is_undefined(_vars) && _create) {
        _vars={instance_list:[],event_instance_map:{}}
        variable_struct_set(GameCont.temerge_effect_vars_map,_name,_vars)
    }
    return _vars
}
function scrNTTEFullMergedEffectScheduler(_name,_event,_instances) {
    var _vars=scrNTTEFullMergedEffectVars(_name,true),_scheduler=scrNTTEFullValue(_vars.event_instance_map,_event,noone)
    if(instance_exists(_scheduler)) return _scheduler
    _scheduler=instance_create(0,0,NTTEFullMergedEffectScheduler)
    _scheduler.ntte_effect_name=_name;_scheduler.ntte_effect_event=_event
    _scheduler.visible=(_event=="draw")
    if(_event=="draw") {
        _scheduler.depth=infinity
        for(var _i=0;_i<array_length(_instances);++_i) if(instance_exists(_instances[_i]))
            _scheduler.depth=min(_scheduler.depth,_instances[_i].depth-1)
    }
    variable_struct_set(_vars.event_instance_map,_event,_scheduler)
    if(_event=="step" || _event=="post_step") {
        if(!variable_instance_exists(GameCont,"temerge_effect_call_step_instance_list")) GameCont.temerge_effect_call_step_instance_list=[]
        array_push(GameCont.temerge_effect_call_step_instance_list,_scheduler)
        GameCont.temerge_effect_call_step_frame=current_frame
    }
    return _scheduler
}
function scrNTTEFullMergedEffectsCapture(_instance) {
    var _state={original:_instance,object:_instance.object_index,vars:{}}
    var _names=variable_instance_get_names(_instance)
    for(var _i=0;_i<array_length(_names);++_i) {
        var _name=_names[_i]
        if(_name!="temerge_destroy_event_vars") variable_struct_set(_state.vars,_name,variable_instance_get(_instance,_name))
    }
    var _builtins=["mask_index","sprite_index","image_index","image_xscale","image_yscale","image_angle","image_blend","image_alpha",
        "image_speed","x","y","xprevious","yprevious","xstart","ystart","speed","direction","friction","gravity","gravity_direction","depth","visible","solid"]
    for(var _i=0;_i<array_length(_builtins);++_i) variable_struct_set(_state.vars,_builtins[_i],variable_instance_get(_instance,_builtins[_i]))
    return _state
}
function scrNTTEFullMergedEffectsStoreDestroy(_vars,_instance) {
    if(!variable_struct_exists(_vars,"destroy_event_vars_list")) {
        _vars.destroy_event_vars_list=[];_vars.destroy_event_instance_list=[]
    }
    var _state=scrNTTEFullMergedEffectsCapture(_instance)
    _instance.temerge_destroy_event_vars=_state
    array_push(_vars.destroy_event_vars_list,_state);array_push(_vars.destroy_event_instance_list,_instance)
}
function scrNTTEFullMergedEffectObjectSetup(_name,_object,_input) {
    var _vars=scrNTTEFullMergedEffectVars(_name),_tag="temerge_"+_name+"_instance"
    if(is_undefined(_vars) || !array_length(_vars.instance_list)) return false
    var _instances=scrNTTEFullMergedEffectsList(_input)
    for(var _i=0;_i<array_length(_instances);++_i) {
        var _instance=_instances[_i]
        if(!instance_exists(_instance) || _instance.object_index!=_object) continue
        var _source=scrNTTEFullValue(_instance,_tag,undefined)
        if(array_get_index(_vars.instance_list,_instance)<0 && array_get_index(_vars.instance_list,_source)>=0) {
            array_push(_vars.instance_list,_instance);variable_instance_set(_instance,_tag,_instance)
            if(variable_struct_exists(_vars,"destroy_event_vars_list")) scrNTTEFullMergedEffectsStoreDestroy(_vars,_instance)
        }
    }
    return true
}
function scrNTTEFullMergedEffectsQueueCopy(_name,_copy) {
    var _vars=scrNTTEFullMergedEffectVars(_name)
    if(is_undefined(_vars) || !instance_exists(_copy)) return;
    var _pending=scrNTTEFullValue(_vars,"ntte_copy_pending",[])
    if(array_get_index(_pending,_copy)<0) array_push(_pending,_copy)
    _vars.ntte_copy_pending=_pending
}
function scrNTTEFullMergedEffectsQueueCopiedTags(_copy) {
    if(!instance_exists(_copy) || !instance_exists(GameCont)) return;
    var _map=scrNTTEFullValue(GameCont,"temerge_effect_vars_map",undefined)
    if(!is_struct(_map)) return;
    var _names=variable_struct_get_names(_map)
    for(var _i=0;_i<array_length(_names);++_i) {
        var _name=_names[_i],_vars=_map[$ _name]
        if(variable_instance_exists(_copy,"temerge_"+_name+"_instance")
            && array_get_index(_vars.instance_list,_copy)<0) scrNTTEFullMergedEffectsQueueCopy(_name,_copy)
    }
}
function scrNTTEFullMergedEffectsDiscoverCopies(_name) {
    var _vars=scrNTTEFullMergedEffectVars(_name)
    if(is_undefined(_vars) || !array_length(_vars.instance_list)) return;
    // Native Copy entries are wrapped by MergedNativeCopy, and explicit
    // field-copy births (Prism's native Lightning children) queue their tags.
    // Most copies
    // register synchronously there; a copy made while CallEvent temporarily
    // empties this effect's membership waits here for that buffer to restore.
    // Visiting this exact birth list avoids rescanning every floor/wall/actor
    // for each effect and event after every shot. Copy registration applies
    // independently of the chosen collision adapter. Only a live internal
    // smoke runner can select the frozen full-world comparison path.
    var _indexed=!(instance_exists(NTTESmokeTest) && variable_global_exists("ntte_full_merge_copy_legacy_smoke")
            && global.ntte_full_merge_copy_legacy_smoke),
        _all=_indexed?scrNTTEFullValue(_vars,"ntte_copy_pending",[]):scrNTTEFullInstances(all),_pending=[]
    if(_indexed && array_length(_all)>1) array_sort(_all,function(_a,_b) {return real(_a)-real(_b)})
    if(variable_global_exists("ntte_full_merge_copy_scan_observer") && is_array(global.ntte_full_merge_copy_scan_observer))
        array_push(global.ntte_full_merge_copy_scan_observer,{name:_name,count:array_length(_all),indexed:_indexed})
    for(var _i=0;_i<array_length(_all);++_i) {
        var _instance=_all[_i]
        if(!instance_exists(_instance)) continue
        if(variable_instance_exists(_instance,"temerge_"+_name+"_instance")) {
            scrNTTEFullMergedEffectObjectSetup(_name,_instance.object_index,[_instance])
            if(_indexed && array_get_index(_vars.instance_list,_instance)<0) array_push(_pending,_instance)
        }
    }
    _vars.ntte_copy_pending=_indexed?_pending:[]
}
function scrNTTEFullMergedEffectCallEvent(_name,_event,_args=undefined) {
    scrNTTEFullMergedEffectsInit()
    var _vars=scrNTTEFullMergedEffectVars(_name)
    if(is_undefined(_vars)) return;
    if(_event!="setup") scrNTTEFullMergedEffectsDiscoverCopies(_name)
    var _instances=scrNTTEFullMergedEffectsLive(_vars.instance_list)
    if(!array_length(_instances)) {
        // Dead snapshots still need replay before the empty scheduler unbinds.
        scrNTTEFullMergedEffectsReplayDestroy(_vars)
        var _scheduler=scrNTTEFullValue(_vars.event_instance_map,_event,noone)
        if(_scheduler==id) { variable_struct_set(_vars.event_instance_map,_event,noone);instance_destroy(id,false) }
        _vars.instance_list=[]
        return;
    }
    var _tagged=[]
    for(var _i=0;_i<array_length(_instances);++_i) {
        var _p=_instances[_i]
        if(is_undefined(scrNTTEFullValue(_p,"temerge_event_last_team",undefined))) {
            _p.temerge_event_last_team=_p.team;_p.team=round(_p.team);array_push(_tagged,_p)
        }
    }
    var _registry=scrNTTEFullValue(global.ntte_full_merge_effect_registry,_name,undefined),_callbacks=[]
    if(is_struct(_registry)) _callbacks=scrNTTEFullValue(_registry.events,_event,[])
    for(var _i=0;_i<array_length(_callbacks);++_i) {
        _vars.instance_list=[]
        var _call_args=[_instances]
        if(is_array(_args)) for(var _a=0;_a<array_length(_args);++_a) array_push(_call_args,_args[_a])
        var _new=scrNTTEFullMergedEffectsCall(id,id,_callbacks[_i],_call_args)
        if(is_array(_new)) _instances=_new
        else if(!is_undefined(_new) && _new!=0) throw "Merged effect returned a non-array instance list"
        for(var _a=0;_a<array_length(_vars.instance_list);++_a) array_push(_instances,_vars.instance_list[_a])
        _instances=scrNTTEFullMergedEffectsLive(_instances);_vars.instance_list=_instances
    }
    for(var _i=0;_i<array_length(_tagged);++_i) if(instance_exists(_tagged[_i])) {
        var _p=_tagged[_i],_last=scrNTTEFullValue(_p,"temerge_event_last_team",undefined)
        if(!is_undefined(_last)) {
            // Preserve the literal original condition; do not invent restoring
            // a rounded tag after an effect intentionally changes faction.
            if(_p.team==_last) _p.team=_last
            _p.temerge_event_last_team=undefined
        }
    }
    _vars.instance_list=_instances
    if(_event=="draw" && scrNTTEFullValue(_vars.event_instance_map,_event,noone)==id) {
        for(var _i=0;_i<array_length(_instances);++_i) if(_instances[_i].depth<depth+1) depth=min(depth,_instances[_i].depth-1)
    }
    scrNTTEFullMergedEffectsReplayDestroy(_vars)
}
function scrNTTEFullMergedProjectileAddEffect(_input,_name,_setup_args=undefined) {
    scrNTTEFullMergedEffectsInit()
    var _vars=scrNTTEFullMergedEffectVars(_name,true),_instances=scrNTTEFullMergedEffectsList(_input),
        _entry=scrNTTEFullValue(global.ntte_full_merge_effect_registry,_name,undefined)
    if(!is_struct(_entry)) throw "Original merged effect is not implemented: "+_name
    if(is_struct(_entry)) for(var _i=0;_i<array_length(_entry.event_order);++_i) {
        var _event=_entry.event_order[_i]
        if(_event=="setup") {
            var _saved=_vars.instance_list
            _vars.instance_list=_instances;scrNTTEFullMergedEffectCallEvent(_name,_event,_setup_args)
            _instances=_vars.instance_list;_vars.instance_list=_saved
        }
        else scrNTTEFullMergedEffectScheduler(_name,_event,_instances)
    }
    _vars.instance_list=scrNTTEFullMergedEffectsLive(_vars.instance_list)
    for(var _i=0;_i<array_length(_instances);++_i) {
        var _p=_instances[_i]
        if(!instance_exists(_p) || array_get_index(_vars.instance_list,_p)>=0) continue
        array_push(_vars.instance_list,_p)
        var _tag="temerge_"+_name+"_instance"
        if(!variable_instance_exists(_p,_tag)) variable_instance_set(_p,_tag,_p)
        if(_name=="destroy_event" && !variable_instance_exists(_p,"temerge_destroy_event_vars")) scrNTTEFullMergedEffectsStoreDestroy(_vars,_p)
    }
    return _instances
}
function scrNTTEFullMergedProjectileHasEffect(_instance,_name) {
    var _vars=scrNTTEFullMergedEffectVars(_name)
    return !is_undefined(_vars) && array_get_index(_vars.instance_list,_instance)>=0
}
function scrNTTEFullMergedProjectileAddEvent(_input,_event,_callback) {
    var _instances=scrNTTEFullMergedEffectsList(_input),_key="temerge_"+_event+"_event_ref_list"
    for(var _i=0;_i<array_length(_instances);++_i) if(instance_exists(_instances[_i])) {
        var _p=_instances[_i],_refs=scrNTTEFullValue(_p,_key,[])
        if(!array_length(_refs)) scrNTTEFullMergedProjectileAddEffect(_p,_event+"_event")
        else if(_event=="destroy" && variable_instance_exists(_p,"temerge_destroy_event_vars")) {
            var _state=scrNTTEFullMergedEffectsCapture(_p)
            _p.temerge_destroy_event_vars.vars=_state.vars
        }
        array_push(_refs,_callback);variable_instance_set(_p,_key,_refs)
        // AddEvent takes the first destroy snapshot before it appends the
        // callback; source arrays are shared, so publish the same list there.
        if(_event=="destroy" && variable_instance_exists(_p,"temerge_destroy_event_vars"))
            variable_struct_set(_p.temerge_destroy_event_vars.vars,_key,_refs)
    }
}
function scrNTTEFullMergedEffectSchedulerPhase(_phase) {
    if(scrNTTEFullMergedNativeSkipPredictedCollision(ntte_effect_name,_phase)) return;
    if(ntte_effect_event!=_phase || lockstep_stop) return;
    scrNTTEFullMergedEffectCallEvent(ntte_effect_name,ntte_effect_event)
}
function scrNTTEFullMergedEffectsPostStep() {
    // Must be called after all normal Step events and BEFORE native motion /
    // collision. EndStep is not an equivalent integration point.
    var _controllers=scrNTTEFullInstances(NTTEFullMergedEffectScheduler)
    for(var _i=0;_i<array_length(_controllers);++_i) if(instance_exists(_controllers[_i]))
        with(_controllers[_i]) scrNTTEFullMergedEffectSchedulerPhase("post_step")
}
function scrNTTEFullMergedEffectsFlushCreatedStep() {
    if(!instance_exists(GameCont) || scrNTTEFullValue(GameCont,"temerge_effect_call_step_frame",-1)!=current_frame) return;
    var _pending=scrNTTEFullValue(GameCont,"temerge_effect_call_step_instance_list",[])
    // Original runs CustomObject step first, then CustomStep post-step.
    for(var _phase=0;_phase<2;++_phase) for(var _i=0;_i<array_length(_pending);++_i) if(instance_exists(_pending[_i]))
        with(_pending[_i]) scrNTTEFullMergedEffectSchedulerPhase(_phase==0?"step":"post_step")
    GameCont.temerge_effect_call_step_instance_list=[]
}
function scrNTTEFullMergedEffectsReset() {
    if(instance_exists(GameCont)) {
        GameCont.temerge_effect_vars_map={};GameCont.temerge_effect_call_step_instance_list=[]
        GameCont.temerge_effect_call_step_frame=-1
    }
    instance_destroy(NTTEFullMergedEffectScheduler,false)
}
function scrNTTEFullMergedDestroyPost(_instances) {
    // Source2585 updates only this explicit moving subset after registration;
    // other stored fields remain the original AddEvent/ObjectSetup snapshot.
    var _fields=["mask_index","sprite_index","image_index","image_xscale","image_yscale","image_angle","image_blend","image_alpha",
        "x","y","speed","direction","friction","damage","knockback_speed","team","creator"]
    for(var _i=0;_i<array_length(_instances);++_i) if(instance_exists(_instances[_i])) {
        var _p=_instances[_i],_state=scrNTTEFullValue(_p,"temerge_destroy_event_vars",undefined)
        if(!is_struct(_state)) continue
        for(var _f=0;_f<array_length(_fields);++_f) {
            var _key=_fields[_f]
            variable_struct_set(_state.vars,_key,variable_instance_get(_p,_key))
        }
    }
}
function scrNTTEFullMergedEffectsReplayDestroy(_vars) {
    if(!variable_struct_exists(_vars,"destroy_event_vars_list")) return;
    var _states=_vars.destroy_event_vars_list
    for(var _i=0;_i<array_length(_states);++_i) {
        var _state=_states[_i]
        if(instance_exists(_state.original)) continue
        _vars.destroy_event_vars_list=scrNTTEFullMergedEffectsRemove(_vars.destroy_event_vars_list,_state)
        var _dummy=instance_create(_state.vars.x,_state.vars.y,_state.object),_names=variable_struct_get_names(_state.vars)
        for(var _n=0;_n<array_length(_names);++_n) {
            var _key=_names[_n]
            if(_key!="id" && _key!="object_index") variable_instance_set(_dummy,_key,variable_struct_get(_state.vars,_key))
        }
        _dummy.temerge_destroy_event_vars=_state
        var _dummy_id=_dummy
        with(_dummy) {
            xprevious=x;yprevious=y;direction=_state.vars.direction;speed=_state.vars.speed
            if(!scrNTTEFullValue(_state,"ntte_native_terminal",false) && !place_meeting(x+hspeed,y+vspeed,Wall)) { x+=hspeed;y+=vspeed }
            if(object_index==Laser || object_index==EnemyLaser) { x-=lengthdir_x(12,direction);y-=lengthdir_y(12,direction) }
            if(!place_meeting(x,y,PortalShock)) {
                var _refs=scrNTTEFullValue(id,"temerge_destroy_event_ref_list",[])
                for(var _r=0;_r<array_length(_refs);++_r) {
                    if(!instance_exists(_dummy_id)) break
                    scrNTTEFullMergedEffectsCall(_dummy_id,_dummy_id,_refs[_r])
                }
            }
            if(instance_exists(_dummy_id)) {
                if(object_index==LightningBall || object_index==FlameBall || object_index==BloodBall) {
                    var _snd=scrNTTEFullValue(id,"snd",-1)
                    if(instance_number(object_index)<=1 || _snd!=asset_get_index(audio_get_name(_snd))) snd_stop(_snd)
                }
                instance_destroy(id,false)
            }
        }
    }
    _vars.destroy_event_instance_list=scrNTTEFullMergedEffectsLive(_vars.instance_list)
}
function scrNTTEFullMergedProjectileEvent(_target,_other,_event,_normal=undefined) {
    if(!instance_exists(_target)) return false
    var _key="temerge_"+_event+"_event_ref_list",_refs=scrNTTEFullValue(_target,_key,[]),
        _iterate=_refs,_meeting=false,_solid=false
    if((_event=="hit" || _event=="wall") && instance_exists(_other)) {
        _solid=_target.solid || _other.solid
        with(_target) _meeting=_solid?place_meeting(x+hspeed,y+vspeed,_other):place_meeting(x,y,_other)
    }
    var _already_tagged=!is_undefined(scrNTTEFullValue(_target,"temerge_event_last_team",undefined))
    if(!_already_tagged) { _target.temerge_event_last_team=_target.team;_target.team=round(_target.team) }
    var _allow_normal=true
    for(var _i=0;_i<array_length(_iterate);++_i) {
        var _done=scrNTTEFullMergedEffectsCall(_target,_other,_iterate[_i])
        if(!instance_exists(_target)) return false
        if(!is_undefined(_done) && _done!=0) {
            _refs=scrNTTEFullMergedEffectsRemove(_refs,_iterate[_i]);variable_instance_set(_target,_key,_refs)
        }
        if(_meeting) {
            var _still=false
            if(instance_exists(_other)) with(_target) _still=_solid?place_meeting(x+hspeed,y+vspeed,_other):place_meeting(x,y,_other)
            if(!_still) { _allow_normal=false;break }
        }
    }
    if(!_already_tagged) {
        var _last=_target.temerge_event_last_team
        if(_target.team==_last) _target.team=_last
        _target.temerge_event_last_team=undefined
    }
    if(_allow_normal && !is_undefined(_normal)) scrNTTEFullMergedEffectsCall(_target,_other,_normal)
    return _allow_normal && instance_exists(_target)
}
function scrNTTEFullMergedProjectileAddScale(_input,_x,_y=undefined) {
    if(is_undefined(_y)) _y=_x
    var _instances=scrNTTEFullMergedEffectsList(_input)
    for(var _i=0;_i<array_length(_instances);++_i) if(instance_exists(_instances[_i])) with(_instances[_i]) {
        image_xscale+=_x*(image_xscale<0?-1:1);image_yscale+=_y*(image_yscale<0?-1:1)
        if(object_index==Rocket || object_index==Nuke || object_index==ConfettiBall) scrNTTEFullMergedProjectileAddEffect(id,"fixed_scale")
        if(object_index==Lightning || object_index==EnemyLightning) {
            temerge_fixed_lightning_yscale=image_yscale;scrNTTEFullMergedProjectileAddEffect(id,"fixed_lightning_yscale")
        }
    }
}
function scrNTTEFullMergedProjectileAddBloom(_input,_amount) {
    var _instances=scrNTTEFullMergedEffectsList(_input)
    for(var _i=0;_i<array_length(_instances);++_i) if(instance_exists(_instances[_i])) with(_instances[_i]) image_alpha+=_amount*sign(image_alpha)
}
function scrNTTEFullMergedProjectileAddDamage(_input,_factor) {
    var _instances=scrNTTEFullMergedEffectsList(_input)
    for(var _i=0;_i<array_length(_instances);++_i) if(instance_exists(_instances[_i])) with(_instances[_i]) damage+=round(damage*_factor)
}
function scrNTTEFullMergedProjectileAddForce(_input,_amount) {
    // Original force is logical velocity; this port's native projectile force
    // field is knockback_speed in pixels per physical frame.
    var _instances=scrNTTEFullMergedEffectsList(_input)
    for(var _i=0;_i<array_length(_instances);++_i) if(instance_exists(_instances[_i])) with(_instances[_i])
        knockback_speed+=_amount*timescale*sign(knockback_speed)
}
function scrNTTEFullMergedProjectileCanHit(_target) {
    return scr_can_hit(_target) && _target.hp>0 && scrNTTEFullValue(id,"canhurt",true)
}
function scrNTTEFullMergedFixedPlasmaBegin(_instances) {
    var _remaining=_instances
    for(var _i=0;_i<array_length(_instances);++_i) if(instance_exists(_instances[_i]) && _instances[_i].image_speed==0) {
        var _p=_instances[_i];_p.speed*= _p.temerge_fixed_speed_factor
        _remaining=scrNTTEFullMergedEffectsRemove(_remaining,_p)
    }
    return _remaining
}
function scrNTTEFullMergedFixedSeekerStep(_instances) {
    for(var _i=0;_i<array_length(_instances);++_i) if(instance_exists(_instances[_i]))
        _instances[_i].speed*=_instances[_i].temerge_fixed_speed_factor
}
function scrNTTEFullMergedFixedRocketStep(_instances) {
    for(var _i=0;_i<array_length(_instances);++_i) if(instance_exists(_instances[_i])) with(_instances[_i]) {
        var _maximum=(object_index==Nuke?5:12)*temerge_fixed_speed_factor*timescale
        if(speed>_maximum) speed=_maximum
    }
}
function scrNTTEFullMergedFixedScaleDraw(_instances) {
    for(var _i=0;_i<array_length(_instances);++_i) if(instance_exists(_instances[_i])) with(_instances[_i]) if(visible) draw_self()
}
function scrNTTEFullMergedFixedLightningDraw(_instances) {
    for(var _i=0;_i<array_length(_instances);++_i) if(instance_exists(_instances[_i])) with(_instances[_i]) if(visible) {
        var _ys=temerge_fixed_lightning_yscale/2
        image_yscale*=_ys;draw_self();image_yscale/=_ys
    }
}
function scrNTTEFullMergedEffectsMotion(_target,_forward) {
    with(_target) {
        // telib6348 uses raw native velocities, not logical speed. Reverse is
        // deliberately the source arithmetic, including its zero-speed guard.
        if(_forward) {
            if(friction!=0 && speed!=0) speed-=min(abs(speed),friction)*sign(speed)
            if(gravity!=0) { hspeed+=lengthdir_x(gravity,gravity_direction);vspeed+=lengthdir_y(gravity,gravity_direction) }
            if(speed!=0) { x+=hspeed;y+=vspeed }
        }
        else {
            if(speed!=0) { y-=vspeed;x-=hspeed }
            if(gravity!=0) { vspeed-=lengthdir_y(gravity,gravity_direction);hspeed-=lengthdir_x(gravity,gravity_direction) }
            if(friction!=0 && speed!=0) speed-=min(abs(speed),-friction)*sign(speed)
        }
    }
}
function scrNTTEFullMergedEffectsMeeting(_projectile,_target,_solid=false) {
    if(!instance_exists(_projectile) || !instance_exists(_target)) return false
    var _meeting=false
    with(_projectile) _meeting=_solid?place_meeting(x+hspeed,y+vspeed,_target):place_meeting(x,y,_target)
    return _meeting
}
function scrNTTEFullMergedEffectsCollisionAt(_p,_target,_type) {
    var _solid=_p.solid || _target.solid
    if(_solid) {
        _p.x=_p.xprevious;_p.y=_p.yprevious
        _target.x=_target.xprevious;_target.y=_target.yprevious
    }
    scrNTTEFullMergedProjectileEvent(_p,_target,_type)
    if(_solid) {
        if(instance_exists(_p)) { _p.x+=_p.hspeed;_p.y+=_p.vspeed }
        if(instance_exists(_target)) { _target.x+=_target.hspeed;_target.y+=_target.vspeed }
    }
}
function scrNTTEFullMergedCollisionPost(_type,_instances) {
    var _object=(_type=="hit")?hitme:Wall,_out=_instances,_key="temerge_"+_type+"_event_ref_list"
    for(var _i=0;_i<array_length(_instances);++_i) {
        var _p=_instances[_i]
        if(!instance_exists(_p) || _p.mask_index==mskNone) continue
        var _distance=infinity
        with(_p) _distance=distance_to_object(_object)
        if(_distance>16+max(0,abs(_p.speed)-_p.friction)+abs(_p.gravity)) continue
        var _fix=false,_old_xprevious=_p.xprevious,_old_yprevious=_p.yprevious
        if(_type=="wall" && array_get_index([Laser,EnemyLaser,Lightning,EnemyLightning,HyperGrenade],_p.object_index)>=0) {
            _fix=true;_p.xprevious=_p.x;_p.yprevious=_p.y
            if(_p.object_index==Laser || _p.object_index==EnemyLaser) {
                _p.xprevious-=lengthdir_x(2,_p.image_angle);_p.yprevious-=lengthdir_y(2,_p.image_angle)
            }
            if(_p.object_index==HyperGrenade && _p.alarm[0]==0) {
                _p.xprevious-=lengthdir_x(4,_p.direction);_p.yprevious-=lengthdir_y(4,_p.direction)
            }
        }
        scrNTTEFullMergedEffectsMotion(_p,true)
        with(_p) _distance=distance_to_object(_object)
        if(_distance<=16) {
            var _near=ds_list_create(),_queue=[]
            try {
                // Native right/bottom edges are exclusive; the original NTT
                // rectangle helper received inclusive source bounds.
                collision_rectangle_list(_p.bbox_left-16,_p.bbox_top-16,_p.bbox_right-1+16,_p.bbox_bottom-1+16,_object,false,false,_near,false)
                for(var _n=0;_n<ds_list_size(_near);++_n) {
                    var _target=_near[|_n]
                    if(_type!="hit" || _target.team!=_p.team) array_push(_queue,{target:_target,motion:true})
                }
            }
            finally { ds_list_destroy(_near) }
            for(var _q=0;_q<array_length(_queue) && instance_exists(_p);++_q) {
                var _record=_queue[_q],_target=_record.target
                if(!instance_exists(_target)) continue
                if(_record.motion) scrNTTEFullMergedEffectsMotion(_target,true)
                var _meeting=scrNTTEFullMergedEffectsMeeting(_p,_target)
                if(_meeting) {
                    var _before=scrNTTEFullInstances(all)
                    scrNTTEFullMergedEffectsCollisionAt(_p,_target,_type)
                    // Like the original instance_max loop, callbacks may
                    // create more colliders; append newly made matching ones
                    // without predicting their motion a second time. Finish
                    // these while the original target is still predicted,
                    // exactly before its reverse-motion operation.
                    var _known=_before,_after=scrNTTEFullInstances(all),_cursor=0
                    while(_cursor<array_length(_after) && instance_exists(_p)) {
                        var _new=_after[_cursor];_cursor+=1
                        if(array_get_index(_known,_new)>=0) continue
                        array_push(_known,_new)
                        if(!instance_is(_new,_object) || !scrNTTEFullMergedEffectsMeeting(_p,_new)) continue
                        scrNTTEFullMergedEffectsCollisionAt(_p,_new,_type)
                        _after=scrNTTEFullInstances(all);_cursor=0
                    }
                    if(!instance_exists(_p)) _out=scrNTTEFullMergedEffectsLive(_out)
                    else if(!array_length(scrNTTEFullValue(_p,_key,[]))) _out=scrNTTEFullMergedEffectsRemove(_out,_p)
                }
                if(instance_exists(_target) && _record.motion) scrNTTEFullMergedEffectsMotion(_target,false)
            }
        }
        if(instance_exists(_p)) {
            scrNTTEFullMergedEffectsMotion(_p,false)
            if(_fix) { _p.xprevious=_old_xprevious;_p.yprevious=_old_yprevious }
        }
    }
    return _out
}

function scrNTTEFullMergedEffectsUnitTests() {
    var _before=scrNTTEFullInstances(all),_game=scrNTTEFullAreaGeneratorSnapshot(GameCont),
        _players=scrNTTEFullAreaGeneratorSnapshot(Player),_back=scrNTTEFullAreaGeneratorSnapshot(BackCont),
        _old_registry=variable_global_exists("ntte_full_merge_effect_registry")?global.ntte_full_merge_effect_registry:undefined,
        _old_initialized=variable_global_exists("ntte_full_merge_effect_initialized")?global.ntte_full_merge_effect_initialized:false,
        _old_test=variable_global_exists("ntte_full_merge_effect_test")?global.ntte_full_merge_effect_test:undefined
    global.ntte_full_merge_effect_registry={};global.ntte_full_merge_effect_initialized=false
    global.ntte_full_merge_effect_test={calls:0,trace:[],dead:0,unused:0,phase:[],extra:noone}
    GameCont.temerge_effect_vars_map={};GameCont.temerge_effect_call_step_instance_list=[]
    try {
        var _p=instance_create(74000,74000,Bullet1),_caller=instance_create(74128,74000,Bullet1),
            _player=instance_find(Player,0)
        _p.team=team_player;_p.creator=_player;_p.speed=0
        _caller.team=team_player;_caller.speed=0
        var _context=function(_a,_b,_c,_d,_e,_f,_g,_h,_i,_j) {
            return [id,other.id,_a+_b+_c+_d+_e+_f+_g+_h+_i+_j]
        }
        var _value=scrNTTEFullMergedEffectsCall(_p,_caller,scrNTTEFullMergedEffectRef(_context,[1,2]),[3,4,5,6,7,8,9,10])
        assert(_value[0]==_p && _value[1]==_caller && _value[2]==55,
            "Merged callback lost self/other, bound arguments or native array invocation")
        var _count=function(_list) {
            global.ntte_full_merge_effect_test.calls+=1
            assert(array_length(_list)==1,"Merged membership deduplication changed")
        }
        // Register before Init: this must not suppress the builtin registry.
        scrNTTEFullMergedEffectAddEvent("test_duplicate","step",_count)
        scrNTTEFullMergedEffectAddEvent("test_duplicate","step",_count)
        scrNTTEFullMergedProjectileAddEffect([_p,_p],"test_duplicate")
        assert(variable_struct_exists(global.ntte_full_merge_effect_registry,"hit_event"),
            "External registration prevented builtin event initialization")
        var _vars=scrNTTEFullMergedEffectVars("test_duplicate"),_scheduler=_vars.event_instance_map.step
        with(_scheduler) event_perform(ev_step,ev_step_normal)
        assert(global.ntte_full_merge_effect_test.calls==2 && array_length(_vars.instance_list)==1,
            "Duplicate merged callbacks must run twice while membership stays unique")

        var _setup=function(_list,_replacement) {
            assert(!scrNTTEFullMergedProjectileHasEffect(_list[0],"test_setup"),
                "Setup should clear temporary effect membership before callbacks")
            return [_replacement]
        }
        scrNTTEFullMergedEffectAddEvent("test_setup","setup",_setup)
        var _result=scrNTTEFullMergedProjectileAddEffect(_p,"test_setup",[_caller])
        assert(_result[0]==_caller && !scrNTTEFullMergedProjectileHasEffect(_p,"test_setup")
            && scrNTTEFullMergedProjectileHasEffect(_caller,"test_setup"),"Setup list replacement was ignored")
        var _join=function(_list) {
            var _extra=global.ntte_full_merge_effect_test.extra
            if(instance_exists(_extra)) {
                global.ntte_full_merge_effect_test.extra=noone
                scrNTTEFullMergedProjectileAddEffect(_extra,"test_join")
            }
        }
        scrNTTEFullMergedEffectAddEvent("test_join","step",_join)
        scrNTTEFullMergedProjectileAddEffect(_p,"test_join")
        global.ntte_full_merge_effect_test.extra=_caller
        var _join_scheduler=scrNTTEFullMergedEffectVars("test_join").event_instance_map.step
        with(_join_scheduler) event_perform(ev_step,ev_step_normal)
        assert(array_length(scrNTTEFullMergedEffectVars("test_join").instance_list)==2,
            "Instances added during a grouped callback were lost")

        var _copy=noone
        with(_p) _copy=scrNTTEFullMergedNativeCopy(false)
        instance_destroy(_p,false)
        scrNTTEFullMergedEffectsDiscoverCopies("test_duplicate")
        assert(scrNTTEFullMergedProjectileHasEffect(_copy,"test_duplicate")
            && variable_instance_get(_copy,"temerge_test_duplicate_instance")==_copy,
            "Copy(false) lost source capture when original died before collection")

        var _once=function() {
            global.ntte_full_merge_effect_test.calls+=1
            array_push(global.ntte_full_merge_effect_test.trace,[id,other.id])
            return true
        },_ref=scrNTTEFullMergedEffectRef(_once),_normal=function() {global.ntte_full_merge_effect_test.unused+=1}
        scrNTTEFullMergedProjectileAddEvent(_copy,"wall",_ref)
        scrNTTEFullMergedProjectileAddEvent(_copy,"wall",_ref)
        var _old_count=global.ntte_full_merge_effect_test.calls
        scrNTTEFullMergedProjectileEvent(_copy,_caller,"wall",_normal)
        assert(global.ntte_full_merge_effect_test.calls==_old_count+2
            && !array_length(_copy.temerge_wall_event_ref_list) && global.ntte_full_merge_effect_test.unused==1,
            "Truthy callback should remove all equal refs after this dispatch's duplicate snapshot")
        scrNTTEFullMergedProjectileEvent(_copy,_caller,"wall")
        assert(global.ntte_full_merge_effect_test.calls==_old_count+2,"Removed callbacks ran in a later event")
        var _trace=global.ntte_full_merge_effect_test.trace
        assert(_trace[0][0]==_copy && _trace[0][1]==_caller,"Collision callback inherited scheduler context")

        var _bullet=instance_create(74400,74000,Bullet1),_victim=instance_create(74400,74000,NTTEBabyGator)
        _bullet.team=team_player;_bullet.creator=_player;_bullet.direction=0;_bullet.speed=0
        _victim.team=team_enemy;_victim.hp=50;_victim.speed=0;_victim.solid=false
        var _hit=function() {
            array_push(global.ntte_full_merge_effect_test.trace,[id,other.id])
            damage+=1
            return true
        }
        scrNTTEFullMergedProjectileAddEvent(_bullet,"hit",_hit)
        var _hit_scheduler=scrNTTEFullMergedEffectVars("hit_event").event_instance_map.post_step
        with(_hit_scheduler) scrNTTEFullMergedEffectSchedulerPhase("post_step")
        assert(_bullet.damage==4 && _victim.hp==50 && !array_length(_bullet.temerge_hit_event_ref_list),
            "Predicted callback should precede actual native collision damage")
        with(_victim) with(_bullet) event_perform(ev_collision,hitme)
        assert(_victim.hp==46,"Merged modifier did not reach real native projectile collision")

        var _primitives=instance_create(74700,74000,Bullet1)
        _primitives.image_xscale=-1;_primitives.image_yscale=0;_primitives.image_alpha=-1
        _primitives.damage=3;_primitives.knockback_speed=-2*timescale
        scrNTTEFullMergedProjectileAddScale(_primitives,0.5,0.25)
        scrNTTEFullMergedProjectileAddBloom(_primitives,0.5)
        scrNTTEFullMergedProjectileAddDamage(_primitives,0.5)
        scrNTTEFullMergedProjectileAddForce(_primitives,3)
        assert(_primitives.image_xscale==-1.5 && _primitives.image_yscale==0.25 && _primitives.image_alpha==-1.5
            && _primitives.damage==5 && abs(_primitives.knockback_speed+5*timescale)<0.0001,
            "Merged primitive sign, round or logical force scaling changed")
        var _dead=instance_create(75000,74000,Bullet1)
        _dead.team=team_player;_dead.creator=_player;_dead.direction=0;_dead.speed=2*timescale;_dead.ntte_test_payload=37
        var _destroy=function() {
            global.ntte_full_merge_effect_test.dead+=1
            assert(ntte_test_payload==37 && creator==instance_find(Player,0) && abs(x-(75010+2*timescale))<0.0001
                && damage==9 && direction==0 && other.id==id,"Destroy snapshot lost fixed/moving fields or context")
            instance_destroy(id,false)
        },_must_not_run=function() {global.ntte_full_merge_effect_test.unused+=100}
        scrNTTEFullMergedProjectileAddEvent(_dead,"destroy",_destroy)
        scrNTTEFullMergedProjectileAddEvent(_dead,"destroy",_must_not_run)
        _dead.x=75010;_dead.damage=9
        scrNTTEFullMergedDestroyPost([_dead])
        instance_destroy(_dead,false)
        var _dead_vars=scrNTTEFullMergedEffectVars("destroy_event")
        scrNTTEFullMergedEffectsReplayDestroy(_dead_vars);scrNTTEFullMergedEffectsReplayDestroy(_dead_vars)
        assert(global.ntte_full_merge_effect_test.dead==1 && global.ntte_full_merge_effect_test.unused==1
            && !array_length(_dead_vars.destroy_event_vars_list),"Destroy replay repeated or continued after dummy deletion")

        var _suppressed=instance_create(75200,74000,Bullet1),_shock=instance_create(75200,74000,PortalShock)
        _suppressed.speed=0
        scrNTTEFullMergedProjectileAddEvent(_suppressed,"destroy",_must_not_run)
        instance_destroy(_suppressed,false)
        scrNTTEFullMergedEffectsReplayDestroy(_dead_vars)
        assert(global.ntte_full_merge_effect_test.unused==1,"PortalShock failed to suppress destroy replay")
        instance_destroy(_shock,false)
        var _copy_source=instance_create(75400,74000,Bullet1),_copy_dead=noone
        _copy_source.speed=0
        scrNTTEFullMergedProjectileAddEvent(_copy_source,"destroy",function() {global.ntte_full_merge_effect_test.dead+=1})
        with(_copy_source) _copy_dead=scrNTTEFullMergedNativeCopy(false)
        instance_destroy(_copy_source,false)
        scrNTTEFullMergedEffectsDiscoverCopies("destroy_event")
        assert(_copy_dead.temerge_destroy_event_vars.original==_copy_dead,
            "Copied destroy snapshot still targets its source instead of copied instance")
        instance_destroy(_copy_dead,false)
        scrNTTEFullMergedEffectsReplayDestroy(_dead_vars)
        assert(global.ntte_full_merge_effect_test.dead==3,"Source/copy destroy snapshots did not replay individually")

        scrNTTEFullMergedEffectAddEvent("test_phase_begin","begin_step",function(_list) {array_push(global.ntte_full_merge_effect_test.phase,"begin")})
        scrNTTEFullMergedEffectAddEvent("test_phase_end","end_step",function(_list) {array_push(global.ntte_full_merge_effect_test.phase,"end")})
        scrNTTEFullMergedProjectileAddEffect(_caller,"test_phase_begin")
        scrNTTEFullMergedProjectileAddEffect(_caller,"test_phase_end")
        var _begin=scrNTTEFullMergedEffectVars("test_phase_begin").event_instance_map.begin_step,
            _end=scrNTTEFullMergedEffectVars("test_phase_end").event_instance_map.end_step
        with(_begin) event_perform(ev_step,ev_step_begin)
        with(_end) event_perform(ev_step,ev_step_end)
        assert(global.ntte_full_merge_effect_test.phase[0]=="begin" && global.ntte_full_merge_effect_test.phase[1]=="end",
            "Native begin/end scheduler events lost their registered phase")
        global.ntte_full_merge_effect_test.phase=[]
        scrNTTEFullMergedEffectAddEvent("test_phase_step","step",function(_list) {array_push(global.ntte_full_merge_effect_test.phase,"step")})
        scrNTTEFullMergedEffectAddEvent("test_phase_post","post_step",function(_list) {array_push(global.ntte_full_merge_effect_test.phase,"post")})
        scrNTTEFullMergedProjectileAddEffect(_caller,"test_phase_step")
        scrNTTEFullMergedProjectileAddEffect(_caller,"test_phase_post")
        // Discard earlier pending entries so this only tests the creation pair.
        GameCont.temerge_effect_call_step_instance_list=[scrNTTEFullMergedEffectVars("test_phase_step").event_instance_map.step,
            scrNTTEFullMergedEffectVars("test_phase_post").event_instance_map.post_step]
        scrNTTEFullMergedEffectsFlushCreatedStep()
        assert(array_length(global.ntte_full_merge_effect_test.phase)==2
            && global.ntte_full_merge_effect_test.phase[0]=="step" && global.ntte_full_merge_effect_test.phase[1]=="post"
            && !array_length(GameCont.temerge_effect_call_step_instance_list),"Creation-frame step/post-step order changed")

        _primitives.image_speed=0;_primitives.speed=3*timescale;_primitives.temerge_fixed_speed_factor=2
        scrNTTEFullMergedProjectileAddEffect(_primitives,"fixed_plasma_speed_factor")
        var _plasma_begin=scrNTTEFullMergedEffectVars("fixed_plasma_speed_factor").event_instance_map.begin_step
        with(_plasma_begin) event_perform(ev_step,ev_step_begin)
        with(_plasma_begin) event_perform(ev_step,ev_step_begin)
        assert(abs(_primitives.speed-6*timescale)<0.0001
            && !scrNTTEFullMergedProjectileHasEffect(_primitives,"fixed_plasma_speed_factor"),
            "Fixed plasma speed factor was not applied exactly once after image_speed reached zero")
        _primitives.speed=30*timescale;_primitives.temerge_fixed_speed_factor=2
        scrNTTEFullMergedProjectileAddEffect(_primitives,"fixed_rocket_speed_factor")
        var _rocket_step=scrNTTEFullMergedEffectVars("fixed_rocket_speed_factor").event_instance_map.step
        with(_rocket_step) event_perform(ev_step,ev_step_normal)
        assert(abs(_primitives.speed-24*timescale)<0.0001,"Fixed rocket speed cap lost logical time scaling")
        _primitives.temerge_fixed_lightning_yscale=4;_primitives.visible=true
        scrNTTEFullMergedProjectileAddEffect(_primitives,"fixed_lightning_yscale")
        var _draw=scrNTTEFullMergedEffectVars("fixed_lightning_yscale").event_instance_map.draw,_saved_yscale=_primitives.image_yscale
        with(_draw) event_perform(ev_draw,0)
        assert(_primitives.image_yscale==_saved_yscale && _draw.depth<=_primitives.depth-1,
            "Merged draw correction leaked projectile scale or failed source draw ordering")
    }
    finally {
        var _all=scrNTTEFullInstances(all)
        for(var _i=array_length(_all)-1;_i>=0;--_i) if(array_get_index(_before,_all[_i])<0) instance_destroy(_all[_i],false)
        scrNTTEFullAreaGeneratorRestore(_game);scrNTTEFullAreaGeneratorRestore(_players);scrNTTEFullAreaGeneratorRestore(_back)
        global.ntte_full_merge_effect_registry=_old_registry;global.ntte_full_merge_effect_initialized=_old_initialized
        global.ntte_full_merge_effect_test=_old_test
    }
    scrNTTESmokeLog("FULL MERGED EFFECTS: actual callback context/duplicates, setup replacement, in-event registration, copy(false), native collision, destroy replay and logical primitives OK @"+string(30/timescale))
}

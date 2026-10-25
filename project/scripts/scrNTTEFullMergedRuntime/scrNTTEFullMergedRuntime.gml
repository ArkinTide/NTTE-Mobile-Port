// telib4737..5184 native firing mounts. Runtime dispatcher is integrated
// separately; this batch establishes actual creator/event-context semantics.
function scrNTTEFullMergedRuntimeAt(_creator,_fire_at) {
    var _mount=scrNTTEFullActorMountNew(_creator,_fire_at,_creator)
    return {creator:_creator,creator_wep:scrNTTEFullValue(_creator,"wep",undefined),
        mount:_mount,wep:scrNTTEFullValue(_fire_at,"wep",undefined),
        team:scrNTTEFullValue(_fire_at,"team",undefined),accuracy:scrNTTEFullValue(_fire_at,"accuracy",undefined),
        is_active:true,instance_list:[],merge:undefined}
}
function scrNTTEFullMergedRuntimeMountBegin(_at) {
    if(!is_struct(_at) || !_at.is_active || !instance_exists(_at.creator)) return undefined
    var _creator=_at.creator,_mount=_at.mount,_state={at:_at,creator:_creator,before:scrNTTEFullMergedCaptureBegin(),
        x:_creator.x,y:_creator.y,xprevious:_creator.xprevious,yprevious:_creator.yprevious,
        hspeed:_creator.hspeed,vspeed:_creator.vspeed,
        gunangle:scrNTTEFullValue(_creator,"gunangle",undefined),accuracy:scrNTTEFullValue(_creator,"accuracy",undefined),
        team:scrNTTEFullValue(_creator,"team",undefined),wep:scrNTTEFullValue(_creator,"wep",undefined),
        bwep:scrNTTEFullValue(_creator,"bwep",undefined),set_wep:undefined,position:scrNTTEFullActorMountPosition(_mount)}
    with(_creator) {
        x=_state.position.x; y=_state.position.y
        if(!is_undefined(_state.gunangle)) gunangle=scrNTTEFullActorMountDirection(_mount)+_mount.direction_rotation
        if(!is_undefined(_at.accuracy)) accuracy=_at.accuracy
        if(!is_undefined(_at.team)) team=_at.team
        if(!is_undefined(_at.wep) && !is_undefined(_at.creator_wep)) {
            _state.set_wep=is_array(_at.wep) ? _at.wep[0]:_at.wep
            if(_state.wep==_at.creator_wep) wep=_state.set_wep
            if(_state.bwep==_at.creator_wep) bwep=_state.set_wep
        }
    }
    scrNTTEFullMergedRuntimeStateEventMount(_state)
    _at.is_active=false
    return _state
}
function scrNTTEFullMergedRuntimeIsDelayed(_instance) {
    return instance_is(_instance,projectileburst) || _instance.object_index==LaserCannon || _instance.object_index==NTTEFullRedFireCharge
}
function scrNTTEFullMergedRuntimeMountEnd(_state) {
    if(!is_struct(_state)) return []
    var _at=_state.at,_creator=_state.creator,_captured=[]
    _at.is_active=true
    if(instance_exists(_creator)) with(_creator) {
        if(!is_undefined(_state.set_wep)) {
            var _last_wep=_state.wep,_last_bwep=_state.bwep
            if(!is_undefined(_last_wep) && !is_undefined(_last_bwep)
                && ((wep==_last_bwep && bwep!=_last_bwep) || (bwep==_last_wep && wep!=_last_wep))) {
                var _swap=_last_wep; _last_wep=_last_bwep; _last_bwep=_swap
            }
            if(_last_bwep==_at.creator_wep) {
                if(bwep!=_state.set_wep && is_array(_at.wep)) _at.wep[0]=bwep
                bwep=_last_bwep
            }
            if(_last_wep==_at.creator_wep) {
                if(wep!=_state.set_wep && is_array(_at.wep)) _at.wep[0]=wep
                wep=_last_wep
            }
        }
        if(!is_undefined(_state.gunangle)) gunangle=_state.gunangle
        // Explicit source coordinates restore velocity only when firing has
        // not intentionally changed previous position (hyper melee/teleport).
        if(xprevious==_state.xprevious && yprevious==_state.yprevious) {
            if(!is_undefined(_at.mount.x)) { x=_state.x; hspeed=_state.hspeed }
            else x-=_state.position.x-_state.x
            if(!is_undefined(_at.mount.y)) { y=_state.y; vspeed=_state.vspeed }
            else y-=_state.position.y-_state.y
        }
        if(!is_undefined(_at.accuracy)) {
            if(accuracy==_at.accuracy) accuracy=_state.accuracy
            else if(_at.accuracy!=0) accuracy=_state.accuracy*(accuracy/_at.accuracy)
        }
        if(!is_undefined(_at.team) && team==_at.team) team=_state.team
    }
    var _all=scrNTTEFullMergedRuntimeNew(_state.before)
    for(var _i=0;_i<array_length(_all);++_i) {
        var _new=_all[_i]
        array_push(_captured,_new); array_push(_at.instance_list,_new)
        if(scrNTTEFullMergedRuntimeIsDelayed(_new)) {
            var _first=!variable_instance_exists(_new,"ntte_merged_runtime_at")
            _new.ntte_merged_runtime_at=_at
            // Existing actor bridge resolves live dynamic position/direction
            // without replacing the creator or changing controller identity.
            _new.ntte_actor_mount=_at.mount
            if(_first) {
                if(_new.alarm[0]>0) _new.alarm[0]+=1
                if(variable_instance_exists(_new,"delay")) _new.delay=max(_new.delay,timescale)+2*timescale
            }
        }
    }
    scrNTTEFullMergedRuntimeStateEventUnmount(_state)
    return _captured
}
function scrNTTEFullMergedRuntimeMountedEventBegin() {
    return scrNTTEFullMergedRuntimeMountBegin(scrNTTEFullValue(id,"ntte_merged_runtime_at",undefined))
}
function scrNTTEFullMergedRuntimeFiringAnchor(_instance) {
    var _at=scrNTTEFullValue(_instance,"ntte_merged_runtime_at",undefined)
    // The actual creator is already at its resolved mount while a deferred
    // native handler runs. Resolving the dynamic offset a second time would
    // move Burst/LaserCannon twice as far and rotate their aim twice.
    if(is_struct(_at) && !_at.is_active && instance_exists(_at.creator)) return _at.creator
    return scrNTTEFullActorFiringAnchor(_instance)
}
function scrNTTEFullMergedRuntimeFiringAngle(_instance) {
    var _at=scrNTTEFullValue(_instance,"ntte_merged_runtime_at",undefined)
    if(is_struct(_at) && !_at.is_active && instance_exists(_at.creator))
        return scrNTTEFullValue(_at.creator,"gunangle",0)
    return scrNTTEFullActorFiringAngle(_instance)
}
function scrNTTEFullMergedRuntimePlayerMount(_creator,_fire_at,_consume=false,_primary=true) {
    if(!instance_exists(_creator) || !instance_is(_creator,Player)) throw "Merged player mount requires its real Player creator"
    var _at=scrNTTEFullMergedRuntimeAt(_creator,_fire_at),_state=scrNTTEFullMergedRuntimeMountBegin(_at),
        _weapon=scrNTTEFullValue(_fire_at,"wep",_creator.wep),_result=undefined
    if(is_array(_weapon)) _weapon=_weapon[0]
    try {
        with(_creator) scrFire(_weapon,_consume,_primary)
        _result={reload:_creator.reload,wkick:_creator.wkick,weapon:_creator.wep,state:_creator.ntte_state,
            actor:_creator,has_shot:false,shots:[],at:_at}
    }
    finally {
        var _captured=scrNTTEFullMergedRuntimeMountEnd(_state)
        if(is_struct(_result)) {
            _result.shots=_captured
            for(var _i=0;_i<array_length(_captured);++_i)
                if(instance_exists(_captured[_i]) && (instance_is(_captured[_i],damagesource) || variable_instance_exists(_captured[_i],"team"))) _result.has_shot=true
        }
    }
    return _result
}

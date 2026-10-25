// telib.player_fire_ext/player_fire_at + source custom-event wrappers. The
// temporary native Player is synchronous only; retained frame/mount references
// are rebound to the actual actor before that native firing context is freed.
function scrNTTEFullMergedRuntimeActorOwner(_actor) {
    return scrNTTEFullValue(_actor,"ntte_merged_actor_owner",_actor)
}
function scrNTTEFullMergedRuntimeActorBegin(_proxy,_actor,_owner,_at,_angle,_accuracy) {
    _proxy.ntte_merged_actor_owner=_owner
    _proxy.ntte_crabbone_transfer_refs=scrNTTEFullValue(_at,"ntte_crabbone_transfer_refs",[])
    _proxy.ntte_trident_transfer_refs=scrNTTEFullValue(_at,"ntte_trident_transfer_refs",[])
    _proxy.ntte_merged_actor_frames=[]
    var _parent=is_struct(_at)?scrNTTEFullValue(_at,"mount",undefined):undefined
    if(!is_struct(_parent)) {
        var _source={creator:_actor,direction:_angle,accuracy:_accuracy}
        if(is_struct(_at)) {
            var _position=scrNTTEFullValue(_at,"position",undefined),
                _direction_owner=scrNTTEFullValue(_at,"direction_owner",noone)
            if(is_struct(_position)) {_source.x=_position.x;_source.y=_position.y}
            if(instance_exists(_direction_owner)) {
                _source.creator=_direction_owner;_source.direction=undefined
                _source.direction_rotation=scrNTTEFullValue(_at,"direction_rotation",0)
                if(scrNTTEFullValue(_at,"accuracy_dynamic",false)) _source.accuracy=undefined
            }
        }
        _parent=scrNTTEFullActorMountNew(_actor,_source,_actor)
    }
    _proxy.ntte_merged_actor_parent=_parent
}
function scrNTTEFullMergedRuntimeActorFrame(_actor,_frame) {
    if(!is_struct(_frame) || !variable_instance_exists(_actor,"ntte_merged_actor_frames")) return;
    array_push(_actor.ntte_merged_actor_frames,_frame)
}
function scrNTTEFullMergedRuntimeActorRetargetFrame(_frame,_proxy,_owner,_seen) {
    if(!is_struct(_frame) || array_get_index(_seen,_frame)>=0) return _seen
    array_push(_seen,_frame)
    if(scrNTTEFullValue(_frame,"actor",noone)==_proxy) _frame.actor=_owner
    if(scrNTTEFullValue(_frame,"owner",noone)==_proxy) _frame.owner=_owner
    _seen=scrNTTEFullMergedRuntimeActorRetargetFrame(scrNTTEFullValue(_frame,"last_vars",undefined),_proxy,_owner,_seen)
    return scrNTTEFullMergedRuntimeActorRetargetFrame(scrNTTEFullValue(_frame,"main_vars",undefined),_proxy,_owner,_seen)
}
function scrNTTEFullMergedRuntimeActorRetargetAt(_at,_proxy,_owner,_parent) {
    if(!is_struct(_at)) return;
    if(_at.creator==_proxy) _at.creator=_owner
    if(_at.mount.owner==_proxy) {
        _at.mount.owner=_owner
        _at.mount.ntte_merged_parent_mount=_parent
    }
}
// Only controllers born inside this synchronous call can retain its proxy.
// A pre-existing RedFireCharge is the one deliberate exception: custom charge
// input refreshes that same physical controller instead of creating a new one.
function scrNTTEFullMergedRuntimeActorCandidates(_proxy,_births) {
    var _out=[],_charges=scrNTTEFullInstances(NTTEFullRedFireCharge)
    for(var _i=0;_i<array_length(_charges);++_i)
        if(_charges[_i]<=_proxy) array_push(_out,_charges[_i])
    for(var _i=0;_i<array_length(_births);++_i)
        if(instance_exists(_births[_i]) && _births[_i]>_proxy) array_push(_out,_births[_i])
    return _out
}
function scrNTTEFullMergedRuntimeActorFinalize(_proxy,_result) {
    if(!variable_instance_exists(_proxy,"ntte_merged_actor_owner")) return;
    var _owner=_proxy.ntte_merged_actor_owner,_parent=_proxy.ntte_merged_actor_parent,
        _frames=_proxy.ntte_merged_actor_frames,_seen=[]
    var _fired=scrNTTEFullValue(_proxy,"ntte_merged_actor_result",undefined)
    if(is_struct(_fired)) {
        _result.has_shot=_fired.has_shot
        for(var _i=0;_i<array_length(_fired.shots);++_i) {
            var _shot=_fired.shots[_i]
            if(instance_exists(_shot) && scrNTTEFullValue(_shot,"creator",noone)==_owner
                && array_get_index(_result.shots,_shot)<0) array_push(_result.shots,_shot)
        }
    }
    for(var _i=0;_i<array_length(_frames);++_i)
        _seen=scrNTTEFullMergedRuntimeActorRetargetFrame(_frames[_i],_proxy,_owner,_seen)
    // Raw custom charging refreshes an existing controller, so include that
    // exact state even if this particular native call created no new object.
    var _instances=scrNTTEFullMergedRuntimeActorCandidates(_proxy,_proxy.ntte_merged_actor_births)
    for(var _i=0;_i<array_length(_instances);++_i) {
        var _inst=_instances[_i]
        if(_inst<=_proxy && _inst.object_index!=NTTEFullRedFireCharge) continue
        var _at=scrNTTEFullValue(_inst,"ntte_merged_runtime_at",undefined)
        if(!is_struct(_at)) continue
        if(_at.creator==_proxy) scrNTTEFullMergedRuntimeActorRetargetAt(_at,_proxy,_owner,_parent)
        else if(_at.creator!=_owner || scrNTTEFullValue(_at.mount,"ntte_merged_parent_mount",undefined)!=_parent) continue
        // Existing ordinary actor metadata is already retargeted by ActorFire.
        // Its complete parent+part mount supersedes the raw temporary anchor.
        _inst.ntte_actor_mount=_at.mount
    }
    _result.merged_frames=_frames
}
function scrNTTEFullMergedRuntimeActorChargeTag(_actor,_part,_at) {
    if(!variable_instance_exists(_actor,"ntte_merged_actor_owner")) return;
    var _owner=_actor.ntte_merged_actor_owner,_state=scrNTTEFullValue(_part,"ntte_native_state",undefined)
    with(NTTEFullRedFireCharge) if(wep==_state && creator==_owner) {
        ntte_merged_state_part=_part
        // Refresh direction/team/accuracy is source behavior. Keep the first
        // physical part mount so each later refresh cannot stack the offset.
        if(!variable_instance_exists(id,"ntte_merged_runtime_at")) ntte_merged_runtime_at=_at
    }
}
function scrNTTEFullMergedRuntimeActorMountDirection(_mount) {
    if(!is_undefined(_mount.direction)) return _mount.direction
    var _parent=_mount.ntte_merged_parent_mount
    return scrNTTEFullActorMountDirection(_parent)+_parent.direction_rotation
}
function scrNTTEFullMergedRuntimeActorMountPosition(_mount) {
    var _parent=scrNTTEFullActorMountPosition(_mount.ntte_merged_parent_mount),
        _x=is_undefined(_mount.x)?_parent.x:_mount.x,_y=is_undefined(_mount.y)?_parent.y:_mount.y,
        _angle=is_undefined(_mount.position_direction)?scrNTTEFullActorMountDirection(_mount):_mount.position_direction
    _angle+=_mount.position_rotation
    return {x:_x+lengthdir_x(_mount.position_distance,_angle),y:_y+lengthdir_y(_mount.position_distance,_angle)}
}
function scrNTTEFullMergedRuntimeActorMountAccuracy(_mount) {
    if(!is_undefined(_mount.accuracy)) return _mount.accuracy
    return scrNTTEFullActorMountAccuracy(_mount.ntte_merged_parent_mount)
}
function scrNTTEFullMergedRuntimeActorChargeHeld(_actor,_part,_primary) {
    if(!instance_exists(_actor)) return false
    if(!variable_instance_exists(_actor,_primary?"wep":"bwep")) return true
    return scrNTTEFullMergedRuntimeStateHeld(_actor,_part,_primary)
}

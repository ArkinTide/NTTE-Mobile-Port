// telib.player_fire_at_call transfers the array ENTRY after the complete
// native mount restores; the thrown LWO itself is never converted to wep_none.
function scrNTTEFullTridentMergedQueue(_actor,_part,_fire_at,_primary) {
    scrNTTEFullTridentMergedRefCapture(_fire_at)
    var _state=scrNTTEFullValue(_part,"ntte_native_state",undefined)
    if(!is_struct(_state) || !scrNTTEFullValue(_state,"ntte_trident_thrown",false)) return;
    if(!variable_global_exists("ntte_full_trident_transfers")) global.ntte_full_trident_transfers=[]
    var _pending=global.ntte_full_trident_transfers,_row=undefined
    for(var _i=0;_i<array_length(_pending);++_i) if(_pending[_i].part==_part) {_row=_pending[_i];break}
    if(!is_struct(_row)) {
        _row={actor:_actor,owner:scrNTTEFullMergedRuntimeActorOwner(_actor),part:_part,state:_state,
            primary:_primary,refs:[]}
        array_push(global.ntte_full_trident_transfers,_row)
    }
    var _ref=scrNTTEFullValue(_fire_at,"wep",undefined)
    if(is_array(_ref) && array_length(_ref)>0 && array_get_index(_row.refs,_ref)<0) array_push(_row.refs,_ref)
    var _retained=scrNTTEFullValue(_fire_at,"ntte_trident_transfer_refs",[])
    for(var _i=0;_i<array_length(_retained);++_i)
        if(array_get_index(_row.refs,_retained[_i])<0) array_push(_row.refs,_retained[_i])
}
function scrNTTEFullTridentMergedDetach(_weapon,_part) {
    var _model=scrNTTEFullWeaponModel(_weapon)
    if(_model==_part) return {weapon:wep_none,changed:true,removed:true}
    if(scrNTTEFullWeaponHasMerge(_model)!=false) {
        var _child=scrNTTEFullTridentMergedDetach(_model.temerge.wep[0],_part)
        if(_child.changed) {
            // Replace only the original parent's reference. Keep the detached
            // subtree, its own temerge chain and every canonical state intact.
            _model.temerge.wep[@ 0]=_child.weapon
            _model.temerge.is_part=(scrNTTEFullWeaponRaw(_model)==wep_none
                || scrNTTEFullWeaponHasMergedWeapon(_model,wep_none)!=false)
            return {weapon:_weapon,changed:true,removed:false}
        }
    }
    return {weapon:_weapon,changed:false,removed:false}
}
function scrNTTEFullTridentMergedContains(_weapon,_part) {
    var _model=scrNTTEFullWeaponModel(_weapon)
    if(_model==_part) return true
    return scrNTTEFullWeaponHasMerge(_model)!=false
        && scrNTTEFullTridentMergedContains(_model.temerge.wep[0],_part)
}
function scrNTTEFullTridentMergedRefCapture(_fire_at) {
    var _ref=scrNTTEFullValue(_fire_at,"wep",undefined)
    if(!is_array(_ref) || array_length(_ref)<=0) return;
    // FireCharge may release on a later frame with a new temporary at object.
    // Retain caller array references on that runtime controller, not on the
    // serializable physical LWO/state, and forward them at actual release.
    with(NTTEFullRedFireCharge) {
        var _part=scrNTTEFullValue(id,"ntte_merged_state_part",undefined)
        if(!is_struct(_part) || !scrNTTEIsTrident(scrNTTEFullWeaponRaw(_part))
            || !scrNTTEFullTridentMergedContains(_ref[0],_part)) continue
        if(!variable_instance_exists(id,"ntte_trident_transfer_refs")) ntte_trident_transfer_refs=[]
        if(array_get_index(ntte_trident_transfer_refs,_ref)<0) array_push(ntte_trident_transfer_refs,_ref)
    }
    if(!variable_global_exists("ntte_full_trident_transfers")) return;
    var _pending=global.ntte_full_trident_transfers
    for(var _i=0;_i<array_length(_pending);++_i) {
        var _row=_pending[_i]
        if(scrNTTEFullTridentMergedContains(_ref[0],_row.part) && array_get_index(_row.refs,_ref)<0)
            array_push(_row.refs,_ref)
    }
}
function scrNTTEFullTridentMergedDetachActor(_actor,_row) {
    if(!instance_exists(_actor)) return;
    var _slots=["wep","bwep"],_states=["ntte_state","bntte_state"]
    for(var _slot=0;_slot<2;++_slot) {
        if(!variable_instance_exists(_actor,_slots[_slot])) continue
        var _weapon=variable_instance_get(_actor,_slots[_slot]),
            _detached=scrNTTEFullTridentMergedDetach(_weapon,_row.part)
        if(!_detached.changed) continue
        variable_instance_set(_actor,_slots[_slot],_detached.weapon)
        if(_detached.removed) {
            variable_instance_set(_actor,_states[_slot],undefined)
            // Only the real Player may queue a later inventory swap. The
            // synchronous native ActorFire proxy is freed after returning.
            if(_slot==0 && _row.primary && instance_is(_actor,Player)
                && !variable_instance_exists(_actor,"ntte_merged_actor_owner"))
                _actor.ntte_trident_pending_swap=true
        }
    }
}
function scrNTTEFullTridentMergedFlush() {
    if(!variable_global_exists("ntte_full_trident_transfers")) return;
    // Stock input still has a raw physical-state mount around public scrFire.
    // Restore that outer mount before changing the actual held reference.
    if(variable_global_exists("ntte_full_merged_input_weapon") && !is_undefined(global.ntte_full_merged_input_weapon)) return;
    if(variable_global_exists("ntte_full_merged_state_fire") && is_struct(global.ntte_full_merged_state_fire)) return;
    if(variable_global_exists("ntte_full_merged_plain_depth") && global.ntte_full_merged_plain_depth>0) return;
    var _pending=global.ntte_full_trident_transfers
    global.ntte_full_trident_transfers=[]
    for(var _i=0;_i<array_length(_pending);++_i) {
        var _row=_pending[_i]
        scrNTTEFullTridentMergedDetachActor(_row.actor,_row)
        if(_row.owner!=_row.actor) scrNTTEFullTridentMergedDetachActor(_row.owner,_row)
        for(var _j=0;_j<array_length(_row.refs);++_j) {
            var _ref=_row.refs[_j],_detached=scrNTTEFullTridentMergedDetach(_ref[0],_row.part)
            // Explicit reference access is required even for a local alias
            // recovered from the retained refs array under legacy VM COW.
            if(_detached.changed) _ref[@ 0]=_detached.weapon
        }
        _row.state.ntte_trident_thrown=false
    }
}
function scrNTTEFullTridentMergedPlayerStep() {
    if(!scrNTTEFullValue(id,"ntte_trident_pending_swap",false)) return;
    if(variable_global_exists("ntte_full_merged_plain_depth") && global.ntte_full_merged_plain_depth>0) return;
    ntte_trident_pending_swap=false
    if(wep==wep_none) {
        if(bwep!=wep_none) scrSwapWeps(false)
        else if(array_length(extra_weps)>0) scrExtraWepRestoreFirst()
        swapmove=1;drawempty=30;clicked=false
    }
}

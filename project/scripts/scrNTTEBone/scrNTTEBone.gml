// Ordinary bones are spent; recoverable whole weapons leave the slot as well.
function scrNTTEBoneEmpty(_w,_s) {
    return (_w==wep_ntte_bone || scrNTTEIsGroundWeapon(_w)) && is_struct(_s) && _s.weapon==_w && _s.ammo<=0
}

function scrNTTEConsumeBoneSlots() {
    // Run after scrFire has completed (the next Player Step), including Steroids'
    // temporarily swapped firing slot. Changing wep inside scrFire corrupts reloads.
    var _a=variable_instance_exists(id,"ntte_state") ? ntte_state:undefined,
        _b=variable_instance_exists(id,"bntte_state") ? bntte_state:undefined,
        _changed=false
    if (scrNTTEBoneEmpty(wep,_a)) {
        wep=0; curse=0; reload=0; wkick=0; wepangle=0; can_shoot=true
        ntte_state=undefined
        _changed=true
    }
    if (scrNTTEBoneEmpty(bwep,_b)) {
        bwep=0; bcurse=0; breload=0; bwkick=0; bwepangle=0; bcan_shoot=true
        bntte_state=undefined
        _changed=true
    }
    for(var _i=array_length(extra_weps)-1;_i>=0;--_i) {
        var _s=_i<array_length(ntte_extra_states) ? ntte_extra_states[_i]:undefined
        if (!scrNTTEBoneEmpty(extra_weps[_i],_s)) continue
        array_delete(extra_weps,_i,1)
        array_delete(extra_weps_curse,_i,1)
        array_delete(extra_weps_reload,_i,1)
        array_delete(extra_weps_wkick,_i,1)
        array_delete(extra_weps_wepflip,_i,1)
        array_delete(extra_weps_wepangle,_i,1)
        array_delete(extra_weps_can_shoot,_i,1)
        array_delete(ntte_extra_states,_i,1)
        _changed=true
    }
    if (_changed) {
        if (wep==0) {
            if (bwep!=0) scrSwapWeps(false)
            else if (array_length(extra_weps)>0) scrExtraWepRestoreFirst()
        }
        if (bwep==0 && array_length(extra_weps)>0) {
            // Keep the extra-weapon carousel reachable after consuming a slot.
            scrSwapWeps(false)
            scrExtraWepRestoreFirst()
            scrSwapWeps(false)
        }
    }
    if (_changed) {
        clicked=false
        if (instance_exists(WepstickAttack) && index==global.index)
            with (WepstickAttack) scrWepstickUpdateSprite(other.id)
    }
}

function scrNTTEBoneBreak() {
    if (kind!=NTTEKind.Bone || weapon!=wep_ntte_bone) return false
    // Visual debris only: never a WepPickup, NTTEPickup or damage source.
    for(var _side=-1;_side<=1;_side+=2) {
        var _piece=instance_create(x,y,NTTEBoneShard)
        _piece.direction=image_angle+_side*65
        _piece.speed=random_range(1,2)*timescale
        _piece.image_angle=image_angle+(_side<0 ? 180:0)
        _piece.spin=_side*9
    }
    refund=0
    instance_destroy()
    return true
}

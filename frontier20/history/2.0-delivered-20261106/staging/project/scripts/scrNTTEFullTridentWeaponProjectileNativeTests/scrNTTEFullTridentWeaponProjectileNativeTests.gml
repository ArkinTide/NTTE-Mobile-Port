function scrNTTEFullTridentWeaponProjectileNativeTests() {
    var _before=scrNTTEFullInstances(all),_p=instance_find(Player,0)
    // The surrounding merged-state fixture owns private progress, actor/key/
    // native-model snapshots and cleanup. All shots below use actual input.
    for(var _variant=0;_variant<3;++_variant) for(var _cursed=0;_cursed<2;++_cursed) {
        var _child={wep:wep_revolver},_model={wep:wep_ntte_trident,gold:_variant>0}
        _model=scrNTTEFullWeaponMerge(_model,_child)
        var _handle=scrNTTEFullWeaponNative(_model)
        if(_variant==2) _handle=global.ntte_full_weapon_skin(_handle,"coat venuz",_p)
        var _state=scrNTTEFullWeaponNativeState(_model),_sprite=scr_weapon_get_sprite(_model)
        _p.wep=_handle;_p.ntte_state=_state;_p.bwep=wep_none;_p.bntte_state=undefined
        _p.can_shoot=true;_p.reload=0;_p.wepangle=0;_p.gunangle=0;_p.curse=_cursed;_p.bcurse=0
        _p.ntte_trident_pending_swap=false;_p.speed=0;_p.infammo=0;_p.specfiring=false
        KeyCont.hold_fire[_p.index]=true;KeyCont.press_fire[_p.index]=true
        repeat(ceil(7/timescale)) with(_p) scrNTTEHandleInput(wep,true)
        assert(_state.chrg_num==7,"Physical normal/gold/Coat Trident failed genuine seven-tick input charge")
        KeyCont.hold_fire[_p.index]=false;KeyCont.press_fire[_p.index]=false
        with(_p) scrNTTEHandleInput(wep,true)
        var _shots=scrNTTEFullMergedRuntimeTestShots(scrNTTEFullMergedRuntimeNew(_before),NTTEFullTrident)
        assert(array_length(_shots)==1,"Physical normal/gold/Coat merged Trident lost exact single projectile on release")
        var _shot=_shots[0],_origin=_shot.ntte_trident_weapon_projectile_origin
        assert(_shot.wep==_model && _shot.state==_state && _shot.sprite_index==_sprite
            && _shot.creator==_p && _shot.curse==_cursed && _shot.team==_p.team
            && abs(_shot.speed-18*(1+0.3*(_variant>0))*timescale)<0.001
            && !variable_instance_exists(_shot,"temerge_vars_list")
            && scrNTTEFullTridentWeaponProjectileRetain(_shot,_model),
            "Actual normal/gold/Coat Trident lost creation art, physical state, source gold speed or weapon-projectile exemption")
        assert((_cursed==0 && _p.wep==wep_none && is_undefined(_p.ntte_state))
            || (_cursed==1 && _p.wep==_handle && _p.ntte_state==_state && !_state.visible),
            "Normal/gold/Coat merged Trident changed ordinary detach or cursed held-state behavior")
        assert(_origin.projectile==_shot && _origin.model==_model && _origin.state==_state
            && _origin.raw==wep_ntte_trident && _origin.sprite==_sprite && _origin.frame==current_frame,
            "Actual creation snapshot lost exact projectile/model/state/raw/art/frame provenance")
        // Exact provenance is necessary: class membership, a copied marker,
        // same raw with a different physical model, or changed art is insufficient.
        var _pickupsBeforeForeign=instance_number(WepPickup),_visibleBeforeForeign=_state.visible,
            _ammoBeforeForeign=_state.ammo,_foreign=instance_create(_p.x+100,_p.y,NTTEFullTrident)
        assert(!scrNTTEFullTridentWeaponProjectileRetain(_foreign,_model),
            "An arbitrary Trident class instance bypassed merged replacement")
        _foreign.wep=_model;_foreign.state=_state;_foreign.sprite_index=_sprite
        _foreign.ntte_trident_weapon_projectile_origin=_origin
        assert(!scrNTTEFullTridentWeaponProjectileRetain(_foreign,_model),
            "Copied creation provenance incorrectly exempted a different projectile")
        // instance_destroy(false) suppresses Destroy, but native CleanUp still
        // runs. Return the witness's borrowed references before destroying it;
        // it must not return the real weapon or manufacture a landing pickup.
        _foreign.wep=wep_none;_foreign.state=undefined
        instance_destroy(_foreign,false)
        assert(_state.visible==_visibleBeforeForeign && _state.ammo==_ammoBeforeForeign
            && instance_number(WepPickup)==_pickupsBeforeForeign,
            "Foreign projectile witness cleanup changed the real weapon state or created a duplicate pickup")
        assert(!scrNTTEFullTridentWeaponProjectileRetain(_shot,{wep:wep_ntte_trident}),
            "A different physical source model borrowed another projectile's exemption")
        var _differentState=scrNTTENewState(wep_ntte_trident)
        _shot.state=_differentState
        assert(!scrNTTEFullTridentWeaponProjectileRetain(_shot,_model),"A different shot state borrowed creation provenance")
        _shot.state=_state
        var _oldCanonical=_model.ntte_native_state
        _model.ntte_native_state=_differentState
        assert(!scrNTTEFullTridentWeaponProjectileRetain(_shot,_model),"A replaced canonical state borrowed creation provenance")
        _model.ntte_native_state=_oldCanonical
        _shot.wep={wep:wep_ntte_trident}
        assert(!scrNTTEFullTridentWeaponProjectileRetain(_shot,_model),"A replaced projectile physical model borrowed creation provenance")
        _shot.wep=_model;_shot.sprite_index=mskNone
        assert(!scrNTTEFullTridentWeaponProjectileRetain(_shot,_model),"Changed projectile art bypassed exact creation-sprite matching")
        _shot.sprite_index=_sprite
        var _bad=struct_clone(_origin)
        _bad.raw=wep_revolver;_shot.ntte_trident_weapon_projectile_origin=_bad
        assert(!scrNTTEFullTridentWeaponProjectileRetain(_shot,_model),"Non-Trident raw source bypassed provenance validation")
        _bad=struct_clone(_origin);_bad.frame=current_frame-1;_shot.ntte_trident_weapon_projectile_origin=_bad
        assert(!scrNTTEFullTridentWeaponProjectileRetain(_shot,_model),"A previous-frame snapshot bypassed synchronous replacement provenance")
        _shot.ntte_trident_weapon_projectile_origin=_origin
        assert(scrNTTEFullTridentWeaponProjectileRetain(_shot,_model),"Restoring exact provenance failed to restore strict weapon exemption")
        var _owns=false
        with(_shot) _owns=scrNTTEFullTridentOwns(creator)
        scrNTTESmokeLog("TRIDENT PROVENANCE PRECLEANUP DIAG "+json_stringify({variant:_variant,cursed:_cursed,
            shotExists:instance_exists(_shot),shotModel:_shot.wep==_model,shotState:_shot.state==_state,
            creator:_shot.creator==_p,owns:_owns,visible:_state.visible,ammo:_state.ammo,
            slot:_p.wep,expectedSlot:_handle,pickups:instance_number(WepPickup)}))
        instance_destroy(_shot)
        var _pickup=noone
        with(WepPickup) if(scrNTTEFullValue(id,"ntte_state",undefined)==_state) _pickup=id
        scrNTTESmokeLog("TRIDENT PROVENANCE POSTCLEANUP DIAG "+json_stringify({variant:_variant,cursed:_cursed,
            visible:_state.visible,ammo:_state.ammo,pickup:instance_exists(_pickup),
            pickupModel:instance_exists(_pickup)?scrNTTEFullWeaponModel(_pickup.wep)==_model:false,
            pickupState:instance_exists(_pickup)?_pickup.ntte_state==_state:false,
            slot:_p.wep,expectedSlot:_handle,pickups:instance_number(WepPickup)}))
        assert(_state.visible && ((_cursed==0 && instance_exists(_pickup)
            && scrNTTEFullWeaponModel(_pickup.wep)==_model && _pickup.ntte_state==_state)
            || (_cursed==1 && !instance_exists(_pickup) && _p.wep==_handle)),
            "Actual normal/gold/Coat Trident cleanup lost same-model pickup or cursed physical return")
        scrNTTEFullMergedRuntimeTestCleanup(_before)
    }
    scrNTTESmokeLog("FULL TRIDENT WEAPON PROJECTILE: actual input normal/gold/Coat ordinary+cursed six releases, exact creation art/state/model retention, pickup/return and foreign projectile/model/state/art/raw/frame negative provenance OK @"+string(30/timescale))
}

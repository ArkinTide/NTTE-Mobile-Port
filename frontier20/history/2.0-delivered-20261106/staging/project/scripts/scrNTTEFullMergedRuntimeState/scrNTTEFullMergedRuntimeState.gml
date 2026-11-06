// Original temerge1114..1300 and telib4180..4380. Native per-part state
// adapters retain physical LWO identity while reusing the genuine weapon code.
function scrNTTEFullMergedRuntimeStateParts(_weapon,_event="step") {
    var _part=scrNTTEFullMergedRuntimePart(_weapon),_out=[_part]
    if(scrNTTEFullWeaponHasMerge(_part)==true && !_part.temerge.is_part
        && (_event!="reloaded" || _part.temerge.wep_fire_frame>=_part.temerge.fire_frame)) {
        var _front=scrNTTEFullMergedRuntimeStateParts(scrNTTEFullWeaponMergedPart(_part),_event)
        for(var _i=0;_i<array_length(_front);++_i) array_push(_out,_front[_i])
    }
    return _out
}
function scrNTTEFullMergedRuntimeStateContains(_weapon,_state) {
    if(!is_struct(_state)) return false
    var _part=scrNTTEFullWeaponModel(_weapon)
    if(!is_struct(_part)) return false
    if(scrNTTEFullValue(_part,"ntte_native_state",undefined)==_state) return true
    return scrNTTEFullWeaponHasMerge(_part)==true && !_part.temerge.is_part
        && scrNTTEFullMergedRuntimeStateContains(scrNTTEFullWeaponMergedPart(_part),_state)
}
function scrNTTEFullMergedRuntimeStateHas(_actor,_primary,_state) {
    if(!instance_exists(_actor) || !is_struct(_state)) return false
    var _key=_primary?"ntte_state":"bntte_state",_slot=_primary?"wep":"bwep"
    return scrNTTEFullValue(_actor,_key,undefined)==_state
        || scrNTTEFullMergedRuntimeStateContains(scrNTTEFullValue(_actor,_slot,wep_none),_state)
}
function scrNTTEFullMergedRuntimeStateHeld(_actor,_part,_primary) {
    if(!instance_exists(_actor)) return false
    var _weapon=scrNTTEFullValue(_actor,_primary?"wep":"bwep",undefined)
    if(is_undefined(_weapon)) return false
    return scrNTTEFullWeaponModel(_weapon)==_part
        || scrNTTEFullMergedRuntimeStateContains(_weapon,scrNTTEFullValue(_part,"ntte_native_state",undefined))
}
function scrNTTEFullMergedRuntimeStateMount(_actor,_part,_primary=true,_hide_other=false) {
    var _state=scrNTTEFullWeaponNativeState(_part),_slot=_primary?"wep":"bwep",
        _key=_primary?"ntte_state":"bntte_state",_other_slot=_primary?"bwep":"wep",
        _other_key=_primary?"bntte_state":"ntte_state",_raw=scrNTTEFullWeaponRaw(_part),
        _mount={actor:_actor,part:_part,state:_state,slot:_slot,key:_key,raw:_raw,
            weapon:variable_instance_get(_actor,_slot),slot_state:scrNTTEFullValue(_actor,_key,undefined),
            state_weapon:_state.weapon,hide_other:_hide_other,other_slot:_other_slot,other_key:_other_key,
            other_weapon:variable_instance_get(_actor,_other_slot),other_state:scrNTTEFullValue(_actor,_other_key,undefined)}
    variable_instance_set(_actor,_slot,_raw);variable_instance_set(_actor,_key,_state);_state.weapon=_raw
    if(_hide_other) {variable_instance_set(_actor,_other_slot,wep_none);variable_instance_set(_actor,_other_key,undefined)}
    return _mount
}
function scrNTTEFullMergedRuntimeStateUnmount(_mount) {
    if(!is_struct(_mount)) return;
    var _actor=_mount.actor,_part=_mount.part,_state=_mount.state
    if(instance_exists(_actor)) {
        var _weapon=variable_instance_get(_actor,_mount.slot)
        if(_weapon!=_mount.raw) _part.wep=_weapon
        variable_instance_set(_actor,_mount.slot,_mount.weapon)
        variable_instance_set(_actor,_mount.key,_mount.slot_state)
        if(_mount.hide_other) {
            variable_instance_set(_actor,_mount.other_slot,_mount.other_weapon)
            variable_instance_set(_actor,_mount.other_key,_mount.other_state)
        }
    }
    _state.weapon=_mount.state_weapon
}
function scrNTTEFullMergedRuntimeStateInput(_weapon,_primary) {
    // scrPlayerFiring has already swapped Steroids' firing slot to wep.
    var _part=scrNTTEFullMergedRuntimePart(_weapon),_mount=scrNTTEFullMergedRuntimeStateMount(id,_part,true),
        _old=variable_global_exists("ntte_full_merged_input_weapon")?global.ntte_full_merged_input_weapon:undefined,
        _result=false
    global.ntte_full_merged_input_weapon=_weapon
    try {_result=scrNTTEHandleInput(scrNTTEFullWeaponRaw(_part),_primary)}
    finally {
        global.ntte_full_merged_input_weapon=_old;scrNTTEFullMergedRuntimeStateUnmount(_mount)
        scrNTTEFullMergedRuntimeChargeTag(id,_part,undefined)
        scrNTTEFullCrabboneTransferFlush()
        scrNTTEFullTridentMergedFlush()
    }
    return _result
}
function scrNTTEFullMergedRuntimeStateStepOne(_actor,_part,_primary) {
    var _mount=scrNTTEFullMergedRuntimeStateMount(_actor,_part,_primary,true),_state=_mount.state,_raw=_mount.raw
    try {
        with(_actor) {
            if(_raw==wep_ntte_pizza_cutter) scrNTTEFullPizzaWeaponStep(_state,_primary)
            else scrNTTEMuscle(_state)
            if(_raw==wep_ntte_sawblade_gun || _raw==wep_ntte_sawblade_cannon) {
                if(_state.ammo<=0) _state.loaded=false
                if(!_state.loaded) {
                    var _melee=scr_weapon_is_melee(_raw),_canload=_melee?_state.ammo>0:_state.ammo>=_state.capacity
                    if(_canload) _state.loaded=true
                    else if(_state.ammo>0) {
                        variable_instance_set(id,_primary?"reload":"breload",scr_weapon_get_load(_raw))
                        variable_instance_set(id,_primary?"can_shoot":"bcan_shoot",false)
                    }
                }
            }
            if(_raw==wep_ntte_dematerializer) scrNTTEFullDematerializerStep(_primary);
            if(scrNTTEIsScythe(_raw)) {
                scrNTTEFullScythePlayerStep()
                if(_primary) scrNTTEFullScytheSwapInput()
            }
            if(_raw==wep_ntte_clam_shield && (_primary || race==Race.Steroids)) scrNTTEEnsureShield(_primary)
            // A spent nested thrown part becomes an empty source LWO. Never
            // run the inventory-carousel consumption routine on a mounted part.
            if((_raw==wep_ntte_bone || scrNTTEIsGroundWeapon(_raw)) && _state.ammo<=0)
                variable_instance_set(id,_primary?"wep":"bwep",wep_none)
        }
    }
    finally {scrNTTEFullMergedRuntimeStateUnmount(_mount)}
}
function scrNTTEFullMergedRuntimeStatePartUpdate(_part) {
    if(scrNTTEFullWeaponHasMerge(_part)==false) return;
    var _front=scrNTTEFullWeaponMergedPart(_part)
    scrNTTEFullMergedRuntimeStatePartUpdate(_front)
    if(current_frame_active) {
        if(_part.temerge.is_part) {
            if(scrNTTEFullWeaponRaw(_part)!=wep_none && scrNTTEFullWeaponHasMergedWeapon(_part,wep_none)==false) {
                for(var _node=_part;scrNTTEFullWeaponHasMerge(_node)!=false;_node=scrNTTEFullWeaponMergedPart(_node))
                    _node.temerge.is_part=false
            }
        }
        else if(scrNTTEFullWeaponRaw(_front)==wep_none
            || (scrNTTEFullWeaponHasMerge(_front)!=false && _front.temerge.is_part)) _part.temerge.is_part=true
    }
}
function scrNTTEFullMergedRuntimeStateStepSlots() {
    for(var _slot=0;_slot<2;++_slot) {
        var _weapon=_slot==0?wep:bwep
        if(!scrNTTEFullWeaponIsNative(_weapon) && !is_struct(_weapon)) continue
        var _part=scrNTTEFullMergedRuntimePart(_weapon),_parts=scrNTTEFullMergedRuntimeStateParts(_part)
        for(var _i=0;_i<array_length(_parts);++_i) scrNTTEFullMergedRuntimeStateStepOne(id,_parts[_i],_slot==0)
        scrNTTEFullMergedRuntimeStatePartUpdate(_part)
    }
}
function scrNTTEFullMergedRuntimeStateEndStep() {
    for(var _slot=0;_slot<2;++_slot) {
        var _weapon=_slot==0?wep:bwep
        if(!scrNTTEFullWeaponIsNative(_weapon) && !is_struct(_weapon)) continue
        var _parts=scrNTTEFullMergedRuntimeStateParts(_weapon)
        for(var _i=0;_i<array_length(_parts);++_i) {
            var _part=_parts[_i],_state=scrNTTEFullWeaponNativeState(_part)
            if(scrNTTEIsTrident(scrNTTEFullWeaponRaw(_part)) && scrNTTEFullValue(_state,"wepangle",0)!=0) {
                variable_instance_set(id,_slot==0?"wepangle":"bwepangle",_state.wepangle)
                _state.wepangle-=clamp(_state.wepangle*0.4,-40,40)*timescale
                if(abs(_state.wepangle)<1) _state.wepangle=0
            }
        }
    }
}
function scrNTTEFullMergedRuntimeStateReloadOne(_actor,_part,_primary) {
    var _mount=scrNTTEFullMergedRuntimeStateMount(_actor,_part,_primary),_raw=_mount.raw,_state=_mount.state
    try {
        with(_actor) switch(_raw) {
            case wep_ntte_bubble_bat:case wep_ntte_bubble_rifle:
            case wep_ntte_bubble_shotgun:case wep_ntte_bubble_cannon:
                var _distance=_raw==wep_ntte_bubble_shotgun?16:(_raw==wep_ntte_bubble_cannon?22:14),
                    _count=_raw==wep_ntte_bubble_shotgun?3:(_raw==wep_ntte_bubble_cannon?5:1)
                repeat(_count) {
                    var _bubble=instance_create(x+lengthdir_x(_distance,gunangle),y+lengthdir_y(_distance,gunangle),Bubble)
                    _bubble.image_xscale=0.75;_bubble.image_yscale=0.75;_bubble.image_angle=random(360)
                }
                snd_play(sndOasisExplosionSmall,1.3,0.4)
                break;
            case wep_ntte_bubble_minigun:
                var _pop=instance_create(x+lengthdir_x(19,gunangle),y+lengthdir_y(19,gunangle),NTTEFullBubblePop)
                _pop.image_index=wkick>0;_pop.image_angle=random(360);_pop.depth=-1
                snd_play(sndOasisExplosionSmall,1.1,0.4);break;
            case wep_ntte_electroplasma_rifle:case wep_ntte_electroplasma_shotgun:case wep_ntte_electroplasma_cannon:
                snd_play(sndLightningReload);snd_play(sndPlasmaReload,1.5);break;
            case wep_ntte_lightring_launcher:case wep_ntte_lightring_cannon:case wep_ntte_dematerializer:
                snd_play(sndLightningReload);break;
            case wep_ntte_tesla_coil:snd_play(sndLightningReload,0.5+random(0.5),0.8);break;
            case wep_ntte_clam_shield:snd_play(sndMeleeFlip);break;
            case wep_ntte_pizza_cutter:case wep_ntte_annihilator:case wep_ntte_entangler:
                if(scrNTTEFullValue(_state,"chrg",_state.charge)>0) {
                    var _key=_primary?"wepflip":"bwepflip"
                    variable_instance_set(id,_key,-variable_instance_get(id,_key))
                }
                else if(scr_weapon_is_melee(_raw)) snd_play(sndMeleeFlip)
                break;
            default:
                scrPlayerGunReloadFX(_raw)
                var _key=_primary?"wepflip":"bwepflip"
                variable_instance_set(id,_key,-variable_instance_get(id,_key))
                break;
        }
    }
    finally {scrNTTEFullMergedRuntimeStateUnmount(_mount)}
}
function scrNTTEFullMergedRuntimeStateReloaded(_primary) {
    var _weapon=_primary?wep:bwep
    if(!scrNTTEFullWeaponIsNative(_weapon) && !is_struct(_weapon)) return false
    var _parts=scrNTTEFullMergedRuntimeStateParts(_weapon,"reloaded")
    for(var _i=0;_i<array_length(_parts);++_i) scrNTTEFullMergedRuntimeStateReloadOne(id,_parts[_i],_primary)
    return true
}
// These fields mirror telib.weapon_fire_init. Source weapon implementations
// still own their charging sound, motion and final native projectile shapes.
function scrNTTEFullMergedRuntimeChargeState(_state,_raw) {
    if(!variable_struct_exists(_state,"chrg")) _state.chrg=0
    if(!variable_struct_exists(_state,"chrg_num")) _state.chrg_num=_state.charge
    if(!variable_struct_exists(_state,"chrg_max")) _state.chrg_max=scrNTTEChargeMax(_raw)
    return _state
}
function scrNTTEFullMergedRuntimeChargeRaw(_raw,_primary) {
    var _scope=variable_global_exists("ntte_full_merged_state_fire")?global.ntte_full_merged_state_fire:undefined
    if(!is_struct(_scope) || _scope.actor!=id || scrNTTEFullWeaponRaw(_scope.part)!=_raw) return false
    if(_raw==wep_ntte_pizza_cutter) return false
    if(scrNTTEIsTrident(_raw)) return false
    // These genuine native implementations already call FireChargeRefresh.
    if(scrNTTEIsTunnel(_raw)) return false
    if(_raw==wep_ntte_annihilator || _raw==wep_ntte_entangler) return false
    var _max=scrNTTEChargeMax(_raw)
    if(_max<=0) return false
    var _state=scrNTTEFullMergedRuntimeChargeState(scrNTTEState(),_raw),_enabled=true
    if(_raw==wep_ntte_pizza_cutter) _enabled=_state.loaded
    if(scrNTTERedCost(_raw)>0) _enabled=scrNTTEFullValue(scrNTTEFullRedWeaponOwner(),"ntte_red_ammo",0)>=scrNTTERedCost(_raw)
    if(!_enabled || _state.chrg<0) return false
    var _load=scrNTTEFullValue(id,"reloadspeed",1)*timescale
    _state.chrg=_state.chrg_num<_max?1:2
    if(_state.chrg==1) {
        _state.chrg_num=min(_state.chrg_num+_load,_max)
        if(_primary && scrNTTEFullValue(id,"specfiring",false)) _state.chrg_num=_max
    }
    else if((current_frame%12)<timescale) gunshine=2
    _state.charge=_state.chrg_num
    // Native scrFire flipped the melee angle before custom fire_init. Source
    // does that only on the final released branch.
    if(scr_weapon_is_melee(_raw)) wepangle*=-1
    reload=min(reload,_load)
    scrNTTEFullRedFireChargeRefresh(_state,_primary)
    return true
}
function scrNTTEFullMergedRuntimeStateFire(_actor,_part,_at,_consume,_primary) {
    var _old=variable_global_exists("ntte_full_merged_state_fire")?global.ntte_full_merged_state_fire:undefined,
        _result=undefined
    global.ntte_full_merged_state_fire={actor:_actor,part:_part,primary:_primary}
    try {_result=scrNTTEFullMergedRuntimePlayerMount(_actor,_at,_consume,_primary)}
    finally {global.ntte_full_merged_state_fire=_old}
    _result.at.part=_part
    scrNTTEFullMergedRuntimeChargeTag(_actor,_part,_result.at)
    scrNTTEFullMergedRuntimeActorChargeTag(_actor,_part,_result.at)
    return _result
}
function scrNTTEFullMergedRuntimeStateEventMount(_mount) {
    var _part=scrNTTEFullValue(_mount.at,"part",undefined),_actor=_mount.creator
    if(!is_struct(_part) || !instance_exists(_actor)) return;
    var _state=scrNTTEFullWeaponNativeState(_part)
    _mount.physical={state:_state,state_weapon:_state.weapon,
        front:scrNTTEFullValue(_actor,"ntte_state",undefined),back:scrNTTEFullValue(_actor,"bntte_state",undefined)}
    _state.weapon=scrNTTEFullWeaponRaw(_part)
    if(_mount.wep==_mount.at.creator_wep) _actor.ntte_state=_state
    if(_mount.bwep==_mount.at.creator_wep) _actor.bntte_state=_state
}
function scrNTTEFullMergedRuntimeStateEventUnmount(_mount) {
    var _physical=scrNTTEFullValue(_mount,"physical",undefined)
    if(!is_struct(_physical)) return;
    _physical.state.weapon=_physical.state_weapon
    if(instance_exists(_mount.creator)) {
        _mount.creator.ntte_state=_physical.front;_mount.creator.bntte_state=_physical.back
    }
    if(is_array(_mount.at.wep) && _mount.at.wep[0]!=scrNTTEFullWeaponRaw(_mount.at.part))
        _mount.at.part.wep=_mount.at.wep[0]
}
function scrNTTEFullMergedRuntimeChargeTag(_actor,_part,_at) {
    // Exact physical identity also survives controller reuse and input-driven
    // charging. Reuse does not manufacture a second source teamed object.
    var _state=scrNTTEFullValue(_part,"ntte_native_state",undefined),_owner=_actor
    with(NTTEFullRedFireCharge) if(wep==_state && creator==_owner) {
        ntte_merged_state_part=_part
        if(!is_undefined(_at) && !variable_instance_exists(id,"ntte_merged_runtime_at")) ntte_merged_runtime_at=_at
    }
}
function scrNTTEFullMergedRuntimeChargeStep() {
    if(lockstep_stop) return;
    if(!fire) {fire=true;return;}
    var _state=wep,_part=ntte_merged_state_part,_owner=creator,_primary=primary
    if(is_struct(_state)) {
        scrNTTEFullMergedRuntimeChargeState(_state,scrNTTEFullWeaponRaw(_part))
        if(_state.chrg!=0) {
            _state.chrg=-1
            if(instance_exists(_owner) && _owner.visible && scrNTTEFullMergedRuntimeActorChargeHeld(_owner,_part,_primary)) {
                var _at={creator:_owner,wep:[_part],direction:direction,accuracy:accuracy,team:team},
                    _mounted=scrNTTEFullValue(id,"ntte_merged_runtime_at",undefined),
                    _stock=scrNTTEFullValue(id,"ntte_merged_runtime_stock",undefined),
                    _merges=scrNTTEFullValue(id,"ntte_merged_runtime_inherit",[]),_previous=undefined
                _at.ntte_trident_transfer_refs=scrNTTEFullValue(id,"ntte_trident_transfer_refs",[])
                if(is_struct(_mounted)) {
                    var _position=scrNTTEFullActorMountPosition(_mounted.mount)
                    _at.x=_position.x;_at.y=_position.y
                }
                if(is_struct(_stock)) {_previous=_stock.frame.last_vars;_merges=_stock.merges}
                else if(array_length(_merges)>0) _previous=_merges[0].last_fire_vars
                var _raw=scrNTTEFullWeaponRaw(_part),_type=scr_weapon_get_type(_part),_cost=scr_weapon_get_cost(_part),
                    _enough=!instance_is(_owner,Player) || _owner.infammo!=0
                        || (_owner.ammo[_type]>=_cost && GameCont.rad>=scr_weapon_get_rads(_part))
                if(_enough) scrNTTEFullMergedRuntimeEmit(_at,_merges,_previous,_primary)
                else with(_owner) {wkick=-2;clicked=false;drawempty=30;snd_play(ammo[_type]<_cost?sndEmpty:sndUltraEmpty)}
            }
            _state.chrg=0
        }
        _state.chrg_num=0;_state.charge=0
    }
    instance_destroy()
}

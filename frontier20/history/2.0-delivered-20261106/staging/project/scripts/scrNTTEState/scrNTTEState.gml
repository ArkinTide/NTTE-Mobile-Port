// Native weapon-slot state. No instance IDs, methods or DS handles are saved.
function scrNTTEIsScythe(_w) {
    return _w >= wep_ntte_bone_scythe && _w <= wep_ntte_bone_slugbow
}

function scrNTTEIsBone(_w) {
    return _w == wep_ntte_bone || (_w >= wep_ntte_ancient_artifact && _w <= wep_ntte_missing_artifact)
}

function scrNTTEIsTrident(_w) {
    return _w == wep_ntte_trident || _w == wep_ntte_golden_trident
}

function scrNTTEIsTunnel(_w) {
    return _w == wep_ntte_tunneller || _w == wep_ntte_golden_tunneller
}

function scrNTTENewState(_w) {
    if(is_struct(_w) || scrNTTEFullWeaponIsNative(_w)) return scrNTTEFullWeaponNativeState(_w)
    var _cap = -1
    switch (_w) {
        case wep_ntte_sawblade_gun: _cap = 3; break
        case wep_ntte_sawblade_cannon: _cap = 14; break
        case wep_ntte_pizza_cutter: _cap = 1; break
        case wep_ntte_vampire: _cap = 6; break
        default:
            if (scrNTTEIsBone(_w) || scrNTTEIsTrident(_w)) _cap = 1
            if (scrNTTEIsScythe(_w)) _cap = 55
    }
    return {weapon:_w, capacity:_cap, ammo:scrNTTEIsScythe(_w) ? 0 : _cap,
        outstanding:0, charge:0, combo:0, muscle:0, loaded:true, epoch:0}
}

// scrFire/scrPlayerFiring always execute with the firing slot swapped to wep.
function scrNTTEState() {
    if (!variable_instance_exists(id,"ntte_state") || !is_struct(ntte_state)
        || ntte_state.weapon != wep) ntte_state = scrNTTENewState(wep)
    return ntte_state
}

function scrNTTEStateRestored(_state) {
    if(is_struct(_state) && scrNTTEIsTrident(scrNTTEFullWeaponRaw(_state.weapon))) _state.visible=true;
    if (!is_struct(_state)) return _state
    // Outstanding physical objects are not serialized across room/save loads.
    if (_state.capacity >= 0 && scrNTTEFullWeaponRaw(_state.weapon)!=wep_ntte_bone && !scrNTTEIsGroundWeapon(scrNTTEFullWeaponRaw(_state.weapon)))
        _state.ammo = min(_state.capacity, _state.ammo + _state.outstanding)
    _state.outstanding = 0
    _state.charge = 0
    _state.epoch += 1
    _state.loaded = true
    return _state
}

function scrNTTESwapState() {
    var _a = variable_instance_exists(id,"ntte_state") ? ntte_state : undefined,
        _b = variable_instance_exists(id,"bntte_state") ? bntte_state : undefined
    if (KeyCont.press_swap[index]) {
        scrNTTEFullChargeInputCancel(id);
        if (is_struct(_a)) _a.charge=0
        if (is_struct(_b)) _b.charge=0
    }
    ntte_state = _b
    bntte_state = _a
}

function scrNTTEMuscle(_s) {
    if(scrNTTEIsScythe(scrNTTEFullWeaponRaw(_s.weapon))) { scrNTTEFullScytheMuscle(_s); return; }
    if(scrNTTEFullWeaponRaw(_s.weapon)==wep_ntte_vampire) {scrNTTEFullVampireMuscle(_s);return;}
    var _m = scr_skill_get(mut_back_muscle)
    if (_s.capacity > 0 && !scrNTTEIsBone(_s.weapon) && !scrNTTEIsTrident(_s.weapon) && _s.muscle != _m) {
        var _factor = scrNTTEIsScythe(_s.weapon) ? 0.8 : 1,
            _old = _s.capacity
        _s.capacity = round((_old / (1 + _factor * _s.muscle)) * (1 + _factor * _m))
        _s.ammo = clamp(_s.ammo + _s.capacity - _old, 0, _s.capacity)
        _s.muscle = _m
    }
}

function scrNTTESpend(_s, _cost, _returns = false) {
    if (infammo || global.__debug_infammo) return true
    if (_s.ammo < _cost || !_s.loaded) {
        if (KeyCont.press_fire[index]) scrEmpty()
        return false
    }
    _s.ammo -= _cost
    if (_returns) _s.outstanding += _cost
    return true
}

function scrNTTEReturn(_s, _amount, _epoch) {
    if (!is_struct(_s) || _s.epoch != _epoch) return;
    _amount = min(_amount, _s.outstanding)
    _s.outstanding -= _amount
    _s.ammo = min(_s.capacity, _s.ammo + _amount)
    if (_s.ammo >= _s.capacity) _s.loaded = true
}

function scrNTTEChargeMax(_w) {
    if (scrNTTEIsTrident(_w)) return 7
    if (_w == wep_ntte_pizza_cutter) return 9
    if (_w == wep_ntte_annihilator || _w == wep_ntte_entangler || scrNTTEIsTunnel(_w)) return 15
    return 0
}

function scrNTTERedCost(_w) {
    if (_w == wep_ntte_annihilator) return 2
    if (_w == wep_ntte_entangler || scrNTTEIsTunnel(_w)) return 1
    return 0
}

function scrNTTEHandleInput(_w, _primary) {
    if(scrNTTEIsTunnel(scrNTTEFullWeaponRaw(_w))) return scrNTTEFullTunnellerInput(_w,_primary);
    // NTTE source stock-part input with complete merged release dispatch.
    if(is_struct(_w) || scrNTTEFullWeaponIsNative(_w)) return scrNTTEFullMergedRuntimeStateInput(_w,_primary);
    if(_w==wep_ntte_pizza_cutter) return scrNTTEFullPizzaWeaponInput(_w,_primary);
    if(scrNTTEIsTrident(_w)) return scrNTTEFullTridentInput(_w,_primary);
    if(scrNTTEFullWeaponRaw(_w)==wep_ntte_entangler) return scrNTTEFullEntanglerInput(_w,_primary);
    if(scrNTTEFullWeaponRaw(_w)==wep_ntte_annihilator) return scrNTTEFullRedWeaponInput(_w,_primary);
    if (_w < wep_ntte_bubble_bat || _w > wep_ntte_last) return false
    var _s = scrNTTEState(), _max = scrNTTEChargeMax(_w)
    if(scrNTTEFullIsPortalWeapon(_w) && scrNTTEFullPortalWeaponBusy(_s)) return true;
    scrNTTEMuscle(_s)
    if (_s.capacity >= 0 && _s.ammo < 0) _s.ammo = 0
    if (_w == wep_ntte_sawblade_gun || _w == wep_ntte_sawblade_cannon) {
        if (_s.ammo == 0) _s.loaded = false
        if (_s.ammo >= _s.capacity) _s.loaded = true
    }
    // Once thrown, these weapons cannot duplicate themselves by holding fire.
    if ((scrNTTEIsTrident(_w) || scrNTTEIsBone(_w)) && _s.ammo <= 0) return true
    if (_max <= 0) return false
    var _hold = _primary ? KeyCont.hold_fire[index] : KeyCont.hold_spec[index],
        _press = _primary ? KeyCont.press_fire[index] : KeyCont.press_spec[index],
        _redcost = scrNTTERedCost(_w)
    if (_redcost > 0 && ntte_red_ammo < _redcost) return false
    if (_w == wep_ntte_pizza_cutter && _s.ammo <= 0) return false
    if (_hold && (can_shoot || _s.charge > 0)) {
        scrNTTEFullWeaponDropFire(_w);
        var _before = _s.charge
        _s.charge = min(_max, _s.charge + timescale)
        wkick = 9 * _s.charge / _max
        if (_before < _max && _s.charge >= _max) {
            snd_play(sndCrystalRicochet, 2)
            instance_create(x + lengthdir_x(20,gunangle), y + lengthdir_y(20,gunangle), ThrowHit)
        }
        return true
    }
    if (!_hold && _s.charge > 0) {
        if (can_shoot) scrFire(_w, true, _primary)
        _s.charge = 0
        return true
    }
    return true
}

function scrNTTESecondaryCharging() {
    return variable_instance_exists(id,"bntte_state") && is_struct(bntte_state) && bntte_state.charge > 0
}

function scrNTTEPlayerStep() {
    scrNTTEFullCrabbonePhysicalStepSlots();
    scrNTTEFullCrabboneStepSlots();
    if(wep==wep_ntte_dematerializer) scrNTTEFullDematerializerStep(true);
    if(bwep==wep_ntte_dematerializer) scrNTTEFullDematerializerStep(false);
    scrNTTEFullTridentMergedPlayerStep();
    scrNTTEFullPizzaWeaponStepSlots();
    scrNTTEFullWeaponDropPlayerStep();
    if (!variable_instance_exists(id,"ntte_red_ammo")) ntte_red_ammo = 0
    scrNTTEFullRedAmmoState();
    if (!variable_instance_exists(id,"ntte_bones")) ntte_bones = 0
    if (!variable_instance_exists(id,"ntte_extra_states")) ntte_extra_states = []
    scrNTTEFullScythePlayerStep();
    scrNTTEConsumeBoneSlots()
    if (wep >= wep_ntte_bubble_bat && !scrNTTEFullWeaponIsNative(wep)) {
        var _s = scrNTTEState()
        scrNTTEMuscle(_s)
        if (scrNTTEIsScythe(wep)) {
            scrNTTEFullScytheSwapInput();
        }
        if (wep == wep_ntte_clam_shield) scrNTTEEnsureShield(true)
    }
    if (bwep == wep_ntte_clam_shield && race == Race.Steroids) scrNTTEEnsureShield(false)
    scrNTTEFullMergedRuntimeStateStepSlots();
    scrNTTEFullScytheControlUpdate(id);
}

function scrNTTEHeldSprite(_w, _back = false) {
    if(is_struct(_w) || scrNTTEFullWeaponIsNative(_w)) return scrNTTEFullSkinPlayerSprite(scrNTTEFullWeaponNativeSprite(_w,true,
        scrNTTEFullValue(id,_back ? "bntte_state":"ntte_state",undefined)))
    var _s = _back ? (variable_instance_exists(id,"bntte_state") ? bntte_state : undefined)
        : (variable_instance_exists(id,"ntte_state") ? ntte_state : undefined)
    if (is_struct(_s) && _s.weapon == _w && (scrNTTEIsTrident(_w) || scrNTTEIsBone(_w)) && _s.ammo <= 0) return mskNone
    if(scrNTTEFullWeaponRaw(_w)==wep_ntte_clam_shield && scrNTTEFullClamHeld(_s)) return mskNone;
    return scrNTTEFullSkinPlayerSprite(scrNTTEFullWeaponStateSprite(_w,_s))
}

function scrNTTEDrawStatus() {
    if (wep < wep_ntte_bubble_bat || !variable_instance_exists(id,"ntte_state") || !is_struct(ntte_state)) return;
    var _s = ntte_state, _max = scrNTTEChargeMax(wep)
    if (_s.charge > 0 && _max > 0) {
        draw_set_color(c_black)
        draw_rectangle(x-9,y-27,x+9,y-24,false)
        draw_set_color(_s.charge >= _max ? c_lime : c_white)
        draw_rectangle(x-8,y-26,x-8 + 16*_s.charge/_max,y-25,false)
        draw_set_color(c_white)
    }
    if (drawempty <= 0) return;
    var _text = ""
    if (scrNTTEIsScythe(wep)) _text = string(_s.ammo) + " BONES"
    else if (_s.capacity > 0) _text = string(_s.ammo) + "/" + string(_s.capacity)
    if (scrNTTERedCost(wep) > 0) _text = string(ntte_red_ammo) + " RED"
    if (_text == "") return;
    var _font = draw_get_font(), _ha = draw_get_halign(), _va = draw_get_valign()
    draw_set_font(fntSmall)
    draw_set_halign(fa_center)
    draw_set_valign(fa_bottom)
    draw_set_color(c_black)
    draw_text(x+1,y-16,_text)
    draw_set_color(c_white)
    draw_text(x,y-17,_text)
    draw_set_font(_font)
    draw_set_halign(_ha)
    draw_set_valign(_va)
}

// BEGIN NTTE CHARGE TAP DELAY
// Player input intent only. Authored charge rates, ordinary release attacks,
// direct scripted/AI fire and the physical merged-part states stay native.
function scrNTTEFullChargeInputState(_weapon) {
    if(is_struct(_weapon) || scrNTTEFullWeaponIsNative(_weapon))
        return scrNTTEFullWeaponNativeState(scrNTTEFullMergedRuntimePart(_weapon))
    return scrNTTEState()
}
function scrNTTEFullChargeInputEligible(_raw,_state) {
    if(scrNTTEIsTrident(_raw)) return _state.ammo>0 && scrNTTEFullValue(_state,"visible",true)
    if(_raw==wep_ntte_pizza_cutter) return _state.loaded
    var _red=scrNTTERedCost(_raw)
    return _red>0 && scrNTTEFullValue(scrNTTEFullRedWeaponOwner(),"ntte_red_ammo",0)>=_red
}
function scrNTTEFullChargeInputCancel(_actor,_primary=undefined) {
    if(!instance_exists(_actor)) return;
    for(var _slot=0;_slot<2;++_slot) {
        if(!is_undefined(_primary) && (_slot==0)!=_primary) continue
        var _key=_slot==0?"ntte_charge_primary":"ntte_charge_secondary",
            _intent=scrNTTEFullValue(_actor,_key,undefined)
        if(!is_struct(_intent)) continue
        var _state=_intent.state
        if(is_struct(_state)) {_state.chrg=0;_state.chrg_num=0;_state.charge=0}
        variable_instance_set(_actor,_key,undefined)
    }
}
function scrNTTEFullChargePlayerInput(_weapon,_primary) {
    var _raw=scrNTTEFullWeaponRaw(_weapon),_key=_primary?"ntte_charge_primary":"ntte_charge_secondary"
    if(scrNTTEChargeMax(_raw)<=0) {
        scrNTTEFullChargeInputCancel(id,_primary)
        return scrNTTEHandleInput(_weapon,_primary)
    }
    var _state=scrNTTEFullChargeInputState(_weapon),
        _held=_primary?KeyCont.hold_fire[index]:KeyCont.hold_spec[index],
        _press=_primary?KeyCont.press_fire[index]:KeyCont.press_spec[index],
        _intent=scrNTTEFullValue(id,_key,undefined),
        _same=is_struct(_intent) && _intent.weapon==_weapon && _intent.state==_state
    // Manual aim deliberately emits press_fire on finger release. An active
    // physical hold already has its intent; never reset accumulated charge
    // merely because that legacy release edge is named "press".
    if(!_same) {
        scrNTTEFullChargeInputCancel(id,_primary)
        _intent=undefined
    }
    // No red charge / a discless Pizza keeps its authored single-press auto
    // policy. A charge already in progress still gets its native release.
    if(!scrNTTEFullChargeInputEligible(_raw,_state) && _state.charge<=0) {
        scrNTTEFullChargeInputCancel(id,_primary)
        return scrNTTEHandleInput(_weapon,_primary)
    }
    if(!is_struct(_intent)) {
        if(!_held && !_press && _state.charge<=0) return true
        _intent={weapon:_weapon,state:_state,phase:_state.charge>0?2:0,elapsed:0,frame:current_frame}
        variable_instance_set(id,_key,_intent)
    }
    if(_intent.phase==0) {
        // The unchanged PlayerFiring path retains its native click buffer,
        // ammo checks, reload gate and tutorial event for the initial attack.
        if(_held || _press || clicked) return false
        scrNTTEFullChargeInputCancel(id,_primary)
        return true
    }
    if(_intent.phase==1) {
        if(!_held) {scrNTTEFullChargeInputCancel(id,_primary);return true}
        if(_intent.frame!=current_frame) {
            _intent.frame=current_frame;_intent.elapsed+=timescale
        }
        // Six logical 30 Hz ticks (200 ms), plus the ordinary native reload.
        // Skipped/locked Player frames cannot accrue hidden charging time.
        if(_intent.elapsed<6 || !can_shoot) return true
        _intent.phase=2
    }
    var _handled=scrNTTEHandleInput(_weapon,_primary)
    if(!_held || !scrNTTEFullChargeInputEligible(_raw,_state)) {
        // The native release above owns its shot and physical ammo changes.
        // Clearing intent afterwards must never synthesize another release.
        scrNTTEFullChargeInputCancel(id,_primary)
    }
    return _handled
}
function scrNTTEFullChargeTapBegin(_weapon,_primary) {
    var _key=_primary?"ntte_charge_primary":"ntte_charge_secondary",
        _intent=scrNTTEFullValue(id,_key,undefined)
    if(!is_struct(_intent) || _intent.phase!=0 || _intent.weapon!=_weapon
        || _intent.state!=scrNTTEFullChargeInputState(_weapon)) return undefined
    var _states=[]
    if(is_struct(_weapon) || scrNTTEFullWeaponIsNative(_weapon)) {
        var _parts=scrNTTEFullMergedRuntimeStateParts(_weapon)
        for(var _i=0;_i<array_length(_parts);++_i) {
            var _part=_parts[_i],_raw=scrNTTEFullWeaponRaw(_part)
            if(scrNTTEChargeMax(_raw)>0)
                array_push(_states,{state:scrNTTEFullWeaponNativeState(_part),raw:_raw})
        }
    }
    else array_push(_states,{state:_intent.state,raw:scrNTTEFullWeaponRaw(_weapon)})
    for(var _i=0;_i<array_length(_states);++_i) {
        var _entry=_states[_i],_state=_entry.state
        scrNTTEFullMergedRuntimeChargeState(_state,_entry.raw)
        // Trident's authored ordinary stab requires a positive partial charge;
        // its damage is constant. Pizza's 8-damage slash requires exactly zero.
        var _ordinary=scrNTTEIsTrident(_entry.raw)?min(1,_state.chrg_max/2):0
        _state.chrg=-1;_state.chrg_num=_ordinary;_state.charge=_ordinary
    }
    return {actor:id,key:_key,intent:_intent,states:_states,primary:_primary}
}
function scrNTTEFullChargeTapEnd(_tap,_fired) {
    if(!is_struct(_tap)) return;
    for(var _i=0;_i<array_length(_tap.states);++_i) {
        var _state=_tap.states[_i].state
        _state.chrg=0;_state.chrg_num=0;_state.charge=0
    }
    if(!instance_exists(_tap.actor)
        || scrNTTEFullValue(_tap.actor,_tap.key,undefined)!=_tap.intent) return;
    if(!_fired) return;
    var _held=_tap.primary?KeyCont.hold_fire[_tap.actor.index]:KeyCont.hold_spec[_tap.actor.index]
    if(!_held) {variable_instance_set(_tap.actor,_tap.key,undefined);return;}
    _tap.intent.phase=1;_tap.intent.elapsed=0;_tap.intent.frame=current_frame
}
// END NTTE CHARGE TAP DELAY

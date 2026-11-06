// Original weps/pizza cutter.wep.gml and inherited bat disc launcher.step.
// Genuine Slash/BatDisc and FireCharge keep native collision/ownership paths.
function scrNTTEFullPizzaWeaponState(_state) {
    if(!variable_struct_exists(_state,"chrg_max")) _state.chrg_max=9
    return scrNTTEFullRedWeaponState(_state)
}
function scrNTTEFullPizzaWeaponChargeTick(_state,_primary=true) {
    scrNTTEFullPizzaWeaponState(_state)
    var _owner=scrNTTEFullRedWeaponOwner(),_load=scrNTTEFullValue(_owner,"reloadspeed",1)*timescale
    _state.chrg=_state.chrg_num<_state.chrg_max?1:2
    if(_state.chrg==1) {
        _state.chrg_num=min(_state.chrg_num+_load,_state.chrg_max)
        if(_primary && scrNTTEFullValue(id,"specfiring",false)) _state.chrg_num=_state.chrg_max
    }
    else if(instance_is(_owner,Player) && (current_frame%12)<timescale) _owner.gunshine=2
    _state.charge=_state.chrg_num;reload=min(reload,_load)
    var _charge=_state.chrg_num/_state.chrg_max,_kick=-3*_charge
    if(wkick!=_kick) scr_weapon_post(gunangle,8*_charge*timescale,0,_kick)
    if(_state.chrg==1) {
        scrNTTEFullDiscWeaponSound(sndMeleeFlip,1/(1-0.25*_charge),1)
        scrNTTEFullDiscWeaponSound(sndSwapBow,0.3+2*_charge,0.3)
        if(_charge>=1) {
            scrNTTEFullDiscWeaponSound(sndSwapMotorized,1.4,0.5)
            scrNTTEFullDiscWeaponSound(sndDiscBounce,1.4+random(0.2),0.8)
            var _lx=18-wkick,_ly=2*scrNTTEFullValue(_owner,"wepflip",1),
                _angle=gunangle+wepangle*(1-wkick/20),
                _fx=instance_create(x+hspeed+lengthdir_x(_lx,_angle)+lengthdir_x(_ly,_angle-90),
                    y+vspeed+lengthdir_y(_lx,_angle)+lengthdir_y(_ly,_angle-90),DiscTrail)
            _fx.sprite_index=scrNTTERefSprite("BigDiscTrail");_fx.image_speed=0.4*timescale;_fx.depth=depth-1
            sleep(5)
        }
    }
    scrNTTEFullRedFireChargeRefresh(_state,_primary)
}
function scrNTTEFullPizzaWeaponInput(_weapon,_primary) {
    var _state=scrNTTEFullPizzaWeaponState(scrNTTEState()),
        _held=_primary?KeyCont.hold_fire[index]:KeyCont.hold_spec[index]
    if(!_state.loaded && _state.chrg_num<=0) return false
    if(_held && _state.loaded && (can_shoot || _state.chrg_num>0)) {
        scrNTTEFullWeaponDropFire(_weapon);scrNTTEFullPizzaWeaponChargeTick(_state,_primary)
        return true
    }
    if((!_held || !_state.loaded) && _state.chrg_num>0) {
        scrNTTEFullRedWeaponCharging(_state,-1);scrFire(_weapon,true,_primary)
        scrNTTEFullRedWeaponCharging(_state,0)
    }
    return true
}
function scrNTTEFullPizzaWeaponFire(_primary=true) {
    var _state=scrNTTEFullPizzaWeaponState(scrNTTEState())
    if(_state.loaded && _state.chrg>=0) {
        // Native scrFire already flipped melee; original fire_init flips only
        // on release, so a held charging tick must restore the previous angle.
        wepangle*=-1;scrNTTEFullPizzaWeaponChargeTick(_state,_primary)
        return noone
    }
    var _charge=_state.chrg_num/_state.chrg_max,_skill=scr_skill_get(mut_long_arms),
        _distance=20*_skill,_angle=gunangle+orandom(8*accuracy),
        _slash=scrNTTEFullMergedBasicProjectileCreate(x+lengthdir_x(_distance,_angle),
            y+lengthdir_y(_distance,_angle),Slash,_angle,3+2*_skill)
    _slash.primary=_primary
    if(_charge>0) {_slash.sprite_index=sprHeavySlash;_slash.damage=20}
    else {_slash.damage=8;_slash.force=6;_slash.knockback_speed=6*timescale}
    var _pitch=random_range(0.8,1.2)
    scrNTTEFullDiscWeaponSound(_charge>0?sndDiscHit:sndDiscBounce,(_charge>0?1.7:1.2)*_pitch,_charge>0?1:0.7)
    scrNTTEFullDiscWeaponSound(sndHammer,(_charge>0?0.8:1.4)*_pitch,1.4)
    scrNTTEFullDiscWeaponSound(sndShovel,(_charge>0?1.5:0.8)*_pitch,0.3)
    scr_weapon_post(gunangle,-5,8,-4);scrNTTEFullNativeMotionAddFT(id,_angle,3.5)
    if(_charge>0) sleep(15)
    if(_charge>=1 && scrNTTESpend(_state,1,true)) {
        scrNTTEFullPizzaDiscFire(_state,_primary)
        scrNTTEFullRedWeaponGunSound(sndDiscDie,0.4,0.3)
        scr_weapon_post(gunangle,40,5,8)
    }
    return _slash
}
function scrNTTEFullPizzaWeaponReloaded(_primary) {
    if(scrNTTEFullWeaponRaw(_primary?wep:bwep)!=wep_ntte_pizza_cutter) return false
    var _state=scrNTTEFullValue(id,_primary?"ntte_state":"bntte_state",undefined)
    if(is_struct(_state) && scrNTTEFullPizzaWeaponState(_state).chrg>0) {
        var _key=_primary?"wepflip":"bwepflip"
        variable_instance_set(id,_key,-variable_instance_get(id,_key))
    }
    else snd_play(sndMeleeFlip)
    return true
}
function scrNTTEFullPizzaWeaponStep(_state,_primary) {
    // Preserve the original buff arithmetic, including its no-subtraction
    // transition when Back Muscle is removed, instead of generic clamping.
    var _muscle=scr_skill_get(mut_back_muscle)
    if(_state.muscle!=_muscle) {
        var _raw=_state.capacity/(1+_state.muscle)
        _state.muscle=_muscle;_state.capacity=_raw*(1+_muscle)
        _state.ammo+=_state.capacity-_raw
    }
    if(_state.loaded && _state.ammo<=0) _state.loaded=false
    if(_state.loaded) return;
    if(_state.ammo>0) {_state.loaded=true;return;}
    if(!current_frame_active) return;
    var _sprite=scrNTTEFullWeaponStateSprite(wep_ntte_pizza_cutter,_state),
        _angle=gunangle+scrNTTEFullValue(id,_primary?"wepangle":"bwepangle",0),
        _dx=(sprite_get_bbox_right(_sprite)-1-sprite_get_xoffset(_sprite))*0.75,_dy=2,_x=x,_y=y
    if(_primary) _dx-=wkick
    else if(race==Race.Steroids) {_dx-=bwkick;_dy-=4;_y-=4}
    else _angle=90+20*right
    var _smoke=instance_create(_x+lengthdir_x(_dx,_angle)+lengthdir_x(_dy,_angle-90*right),
        _y+lengthdir_y(_dx,_angle)+lengthdir_y(_dy,_angle-90*right),Smoke)
    if(instance_exists(_smoke)) {
        _smoke.hspeed+=hspeed/2;_smoke.vspeed+=vspeed/2
        with(_smoke) {
            scrNTTEFullNativeMotionAddFT(id,_angle,2)
            image_xscale/=1.5;image_yscale/=1.5;growspeed=-0.015;gravity=-0.1*timescale*timescale
        }
    }
}
function scrNTTEFullPizzaWeaponStepSlots() {
    for(var _i=0;_i<2;++_i) {
        var _weapon=_i==0?wep:bwep
        if(_weapon!=wep_ntte_pizza_cutter) continue
        var _key=_i==0?"ntte_state":"bntte_state",_state=scrNTTEFullValue(id,_key,undefined)
        if(!is_struct(_state) || _state.weapon!=_weapon) {
            _state=scrNTTENewState(_weapon);variable_instance_set(id,_key,_state)
        }
        scrNTTEFullPizzaWeaponStep(_state,_i==0)
    }
}

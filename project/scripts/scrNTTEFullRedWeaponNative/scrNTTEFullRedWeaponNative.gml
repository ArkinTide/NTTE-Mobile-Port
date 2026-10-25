// weps/annihilator.wep.gml plus telib.weapon_fire_init/FireCharge semantics.
// Native slot charge remains an alias for the source LWO's chrg_num.
function scrNTTEFullRedWeaponState(_state) {
    if(!variable_struct_exists(_state,"chrg")) _state.chrg=0
    if(!variable_struct_exists(_state,"chrg_num")) _state.chrg_num=_state.charge
    if(!variable_struct_exists(_state,"chrg_max")) _state.chrg_max=15
    if(_state.chrg_num!=_state.charge) {
        _state.chrg_num=_state.charge
        if(_state.charge<=0) _state.chrg=0
    }
    return _state
}
function scrNTTEFullRedWeaponCharging(_state,_value) {
    scrNTTEFullRedWeaponState(_state)
    _state.chrg=_value
    if(_value==0) {_state.chrg_num=0;_state.charge=0}
    return _state
}
function scrNTTEFullRedWeaponOwner() {
    if(variable_instance_exists(id,"ntte_red_owner") && instance_exists(ntte_red_owner)) return ntte_red_owner
    // Native player_fire_ext proxy retains the real owner in its actor mount.
    if(variable_instance_exists(id,"ntte_actor_mount") && is_struct(ntte_actor_mount)
        && instance_exists(ntte_actor_mount.owner)) return ntte_actor_mount.owner
    return id
}
function scrNTTEFullRedWeaponCanCharge(_owner=undefined) {
    if(is_undefined(_owner)) _owner=scrNTTEFullRedWeaponOwner()
    return instance_exists(_owner) && scrNTTEFullValue(_owner,"ntte_red_ammo",0)>=2
}
function scrNTTEFullCrystalBrainEffect(_x,_y) {
    var _fx=instance_create(_x,_y,BulletHit)
    _fx.sprite_index=scrNTTERefSprite("CrystalBrainEffect")
    _fx.image_yscale=choose(1,-1);_fx.image_angle=round(random(360)/90)*90;_fx.depth=choose(-2,-3)
    return _fx
}
function scrNTTEFullRedWeaponSound(_sound,_pitch,_volume,_position=undefined) {
    var _handle=snd_play(_sound,_pitch,_volume)
    if(_handle!=-1 && !is_undefined(_position)) audio_sound_set_track_position(_handle,_position)
    return _handle
}
function scrNTTEFullRedWeaponGunSound(_sound,_variation,_fade) {
    // Original API registration names argument3 "fade"; it controls the
    // background emitter, as do the other authored weapon gun sounds.
    return scrNTTEFullCustomProjectileGunSound(_sound,_variation,_fade)
}
function scrNTTEFullRedWeaponSwap() {
    scrNTTEFullRedWeaponSound(sndHyperCrystalChargeExplo,0.6,0.5,1.55)
    return sndSwapHammer
}
function scrNTTEFullRedWeaponChargeTick(_state,_primary=true) {
    scrNTTEFullRedWeaponState(_state)
    var _load=scrNTTEFullValue(id,"reloadspeed",1)*timescale
    _state.chrg=(_state.chrg_num<_state.chrg_max)?1:2
    if(_state.chrg==1) {
        _state.chrg_num=min(_state.chrg_num+_load,_state.chrg_max)
        if(_primary && scrNTTEFullValue(id,"specfiring",false)) _state.chrg_num=_state.chrg_max
    }
    else if((current_frame%12)<timescale) gunshine=2
    _state.charge=_state.chrg_num
    reload=min(reload,_load)
    var _charge=_state.chrg_num/_state.chrg_max
    if(_state.chrg_num<=timescale && abs(wepangle)<30) wepangle=120*sign(wepangle)
    var _kick=2*_charge
    if(wkick!=_kick) scr_weapon_post(gunangle,8*_charge*timescale,0,_kick)
    var _last=wepangle
    wepangle*=power(1-_charge,(4/_state.chrg_max)*timescale)
    if(abs(wepangle)<0.1) wepangle=0.1*sign(_last)
    if((current_frame%5)<timescale) {
        var _distance=random_range(8,32)-wkick,_angle=gunangle+wepangle*(1-wkick/20)
        scrNTTEFullCrystalBrainEffect(x+lengthdir_x(_distance,_angle),y+lengthdir_y(_distance,_angle))
    }
    if(_state.chrg==1) {
        scrNTTEFullRedWeaponSound(sndHyperCrystalChargeExplo,0.4+0.2*_charge,0.5,1.55)
        snd_play(sndCrystalTB,1/(1-0.25*_charge),1)
        if(_charge>=1) {
            snd_play(sndCrystalTB,0.5+random(0.2));snd_play(sndCrystalJuggernaut,2)
            var _angle=gunangle+wepangle,_fx=instance_create(x+lengthdir_x(24,_angle),y+lengthdir_y(24,_angle),PlasmaTrail)
            _fx.sprite_index=sprThrowHit;_fx.image_speed=0.4*timescale;_fx.image_angle=random(360)
            _fx.image_blend=scrAreaGetBackroundColor(scrNTTEFullAreaId("red"));_fx.depth=depth-1
            var _fx2=instance_create(_fx.x,_fx.y,PlasmaTrail)
            _fx2.sprite_index=_fx.sprite_index;_fx2.image_speed=timescale;_fx2.image_angle=_fx.image_angle;_fx2.depth=_fx.depth-1
            scrNTTEFullTrenchShake(x,y,10);sleep(5)
        }
    }
    scrNTTEFullRedFireChargeRefresh(_state,_primary)
}
function scrNTTEFullRedWeaponInput(_weapon,_primary) {
    var _state=scrNTTEFullRedWeaponState(scrNTTEState()),
        _held=_primary?KeyCont.hold_fire[index]:KeyCont.hold_spec[index]
    if(!scrNTTEFullRedWeaponCanCharge() && _state.chrg_num<=0) return false
    if(_held && scrNTTEFullRedWeaponCanCharge() && (can_shoot || _state.chrg_num>0)) {
        scrNTTEFullWeaponDropFire(_weapon)
        scrNTTEFullRedWeaponChargeTick(_state,_primary)
        return true
    }
    if((!_held || !scrNTTEFullRedWeaponCanCharge()) && _state.chrg_num>0) {
        // FireCharge releases even while the tiny held-tick reload remains.
        scrNTTEFullRedWeaponCharging(_state,-1)
        scrFire(_weapon,true,_primary)
        scrNTTEFullRedWeaponCharging(_state,0)
        return true
    }
    return true
}
function scrNTTEFullRedWeaponFire(_primary=true) {
    var _state=scrNTTEFullRedWeaponState(scrNTTEState())
    if(_state.chrg>=0 && scrNTTEFullRedWeaponCanCharge()) {
        // Direct fire/active invocations enter the same source charge machine.
        // Undo the native melee flip: source fire_init flips only on release.
        wepangle*=-1
        scrNTTEFullRedWeaponChargeTick(_state,_primary)
        return noone
    }
    var _charge=_state.chrg_num/_state.chrg_max,_owner=scrNTTEFullRedWeaponOwner(),_shot=noone
    wepangle=120*sign(wepangle)
    if(_charge>=1 && scrNTTEFullRedWeaponCanCharge(_owner)) {
        _owner.ntte_red_ammo-=2
        _shot=scr_projectile_create(x,y,NTTEFullRedBullet,gunangle,16)
        scrNTTEFullRedWeaponGunSound(sndShotgun,0.2,0.3);scrNTTEFullRedWeaponGunSound(sndEnergyScrewdriver,0.3,0.3)
        scrNTTEFullRedWeaponGunSound(sndPlasmaReloadUpg,0.4,0.3);scrNTTEFullRedWeaponGunSound(sndUltraEmpty,0.5,0.3)
        scr_weapon_post(gunangle,8,6,10);scrNTTEFullNativeMotionAddFT(id,gunangle+180,3);sleep(40)
    }
    else {
        var _skill=scr_skill_get(mut_long_arms),_distance=20*_skill
        _shot=scr_damage_create(x+lengthdir_x(_distance,gunangle),y+lengthdir_y(_distance,gunangle),NTTEFullRedSlash)
        _shot.direction=gunangle;_shot.image_angle=gunangle;_shot.speed=lerp(2,5,_skill)*timescale
        _shot.image_yscale=sign(wepangle)
        scrNTTEFullRedWeaponGunSound(sndWrench,0.2,0.6)
        scrNTTEFullRedWeaponSound(sndHyperCrystalChargeExplo,1+random(0.5),0.4,1.5)
        instance_create(x,y,Smoke);scr_weapon_post(gunangle,12,1,-4);scrNTTEFullNativeMotionAddFT(id,gunangle,6);sleep(5)
    }
    _shot.primary=_primary
    return _shot
}
function scrNTTEFullRedWeaponReloaded(_primary) {
    if(scrNTTEFullWeaponRaw(_primary?wep:bwep)==wep_ntte_tesla_coil) {scrNTTEFullTeslaWeaponReloaded();return true;}
    if(scrNTTEFullElectroWeaponReloaded(scrNTTEFullWeaponRaw(_primary?wep:bwep))) return true;
    if(scrNTTEFullWeaponRaw(_primary?wep:bwep)==wep_ntte_lightring_launcher
        || scrNTTEFullWeaponRaw(_primary?wep:bwep)==wep_ntte_lightring_cannon) {snd_play(sndLightningReload);return true;}
    if(scrNTTEFullPizzaWeaponReloaded(_primary)) return true;
    if(scrNTTEFullBubbleWeaponReloaded(scrNTTEFullWeaponRaw(_primary?wep:bwep))) return true;
    if(scrNTTEFullEntanglerReloaded(_primary)) return true;
    var _weapon=_primary?wep:bwep
    if(scrNTTEFullWeaponRaw(_weapon)!=wep_ntte_annihilator) return false
    var _state=scrNTTEFullValue(id,_primary?"ntte_state":"bntte_state",undefined)
    if(is_struct(_state)) scrNTTEFullRedWeaponState(_state)
    if(is_struct(_state) && _state.chrg>0) {
        if(_primary) wepflip*=-1
        else bwepflip*=-1
    }
    else snd_play(sndMeleeFlip)
    return true
}

// Annihilator's clone=false original CustomSlash. Entangler's clone=true
// extension requires the genuine CrystalClone lifecycle and is a separate API.
function scrNTTEFullRedSlashCreate() {
    sprite_index=scrNTTERefSprite("RedSlash");mask_index=mskSlash;image_speed=0.4*timescale
    friction=0.1*timescale*timescale;damage=10;knockback_speed=12*timescale;force=12
    typ=0;walled=false;clone=false;candeflect=true
}
// Original NTT scrMeleeCanHit005ea0e0: strict different teams (including0),
// target immunity only. Source deliberately has no positive-health condition.
// This opt-in predicate leaves ordinary Epsilon projectile eligibility intact.
function scrNTTEFullRedSlashCanHit(_target) {
    return instance_exists(_target) && _target.team!=team && _target.nexthurt<=current_frame
}
function scrNTTEFullRedSlashHit(_target) {
    if(lockstep_stop || !scrNTTEFullRedSlashCanHit(_target)) return;
    scr_projectile_hit(_target,damage,knockback_speed)
}
function scrNTTEFullRedSlashProjectile(_target) {
    if(lockstep_stop || !instance_exists(_target)) return;
    if(scrNTTEFullFriendlyMonsterShot(id,_target)) return;
    var _typ=scrNTTEFullValue(_target,"typ",0)
    if(_typ!=1 && _typ!=2) return;
    if(_typ==1 && candeflect) {
        _target.deflected=true;_target.team=team;_target.direction=direction;_target.image_angle=direction
        var _fx=instance_create(_target.x,_target.y,Deflect);_fx.image_angle=_target.image_angle
    }
    else instance_destroy(_target)
}
function scrNTTEFullRedSlashWall(_target) {
    if(lockstep_stop || walled || !instance_exists(_target)) return;
    walled=true
    var _px=x,_py=y
    x+=hspeed;y+=vspeed
    var _cx=bbox_center_x,_cy=bbox_center_y,_hit=_target
    if(instance_is(_target,Wall)) {
        var _best=infinity,_walls=scrNTTEFullInstances(Wall)
        for(var _i=0;_i<array_length(_walls);++_i) if(place_meeting(x,y,_walls[_i])) {
            var _wall=_walls[_i],_dx=max(_wall.bbox_left-_cx,0,_cx-_wall.bbox_right),
                _dy=max(_wall.bbox_top-_cy,0,_cy-_wall.bbox_bottom),_distance=_dx*_dx+_dy*_dy
            if(_distance<_best) {_best=_distance;_hit=_wall}
        }
    }
    var _fx=instance_create((_hit.bbox_left+_hit.bbox_right)/2,(_hit.bbox_top+_hit.bbox_bottom)/2,MeleeHitWall)
    _fx.image_angle=point_direction(_cx,_cy,_fx.x,_fx.y)
    _fx.image_blend=scrAreaGetBackroundColor(scrNTTEFullAreaId("red"))
    snd_play_hit(sndMeleeWall,0.3)
    x=_px;y=_py
}

// Original weps/entangler.wep.gml. The fifteen-tick LWO belongs to the
// physical slot and is refreshed by the genuine two-phase FireCharge object.
function scrNTTEFullEntanglerCanCharge(_owner=undefined) {
    if(is_undefined(_owner)) _owner=scrNTTEFullRedWeaponOwner()
    return instance_exists(_owner) && scrNTTEFullValue(_owner,"ntte_red_ammo",0)>=1
}
function scrNTTEFullEntanglerSwap() {
    scrNTTEFullRedWeaponSound(sndHyperCrystalChargeExplo,0.6,0.5,1.55)
    return sndSwapSword
}
function scrNTTEFullEntanglerChargeTick(_state,_primary=true) {
    scrNTTEFullRedWeaponState(_state)
    var _load=scrNTTEFullValue(id,"reloadspeed",1)*timescale
    _state.chrg=(_state.chrg_num<_state.chrg_max)?1:2
    if(_state.chrg==1) {
        _state.chrg_num=min(_state.chrg_num+_load,_state.chrg_max)
        if(_primary && scrNTTEFullValue(id,"specfiring",false)) _state.chrg_num=_state.chrg_max
    }
    else if((current_frame%12)<timescale) gunshine=2
    _state.charge=_state.chrg_num;reload=min(reload,_load)
    var _charge=_state.chrg_num/_state.chrg_max,_kick=-4*_charge
    if(wkick!=_kick) scr_weapon_post(gunangle,8*_charge*timescale,0,_kick)
    if((current_frame%5)<timescale) {
        var _distance=random_range(8,32)-wkick,_angle=gunangle+wepangle*(1-wkick/20)
        scrNTTEFullCrystalBrainEffect(x+lengthdir_x(_distance,_angle),y+lengthdir_y(_distance,_angle))
    }
    if(_state.chrg==1) {
        scrNTTEFullRedWeaponSound(sndHyperCrystalChargeExplo,0.4+0.2*_charge,0.5,1.55)
        snd_play(sndCrystalTB,1/(1-0.25*_charge),1)
        if(_charge>=1) {
            var _owner=scrNTTEFullRedWeaponOwner()
            if(variable_instance_exists(_owner,"wepflip")) _owner.wepflip=sign(wepangle)*(_primary?1:-1)
            snd_play(sndCrystalRicochet,3);snd_play(sndCrystalJuggernaut,2)
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
function scrNTTEFullEntanglerInput(_weapon,_primary) {
    var _state=scrNTTEFullRedWeaponState(scrNTTEState()),
        _held=_primary?KeyCont.hold_fire[index]:KeyCont.hold_spec[index]
    if(!scrNTTEFullEntanglerCanCharge() && _state.chrg_num<=0) return false
    if(_held && scrNTTEFullEntanglerCanCharge() && (can_shoot || _state.chrg_num>0)) {
        scrNTTEFullWeaponDropFire(_weapon);scrNTTEFullEntanglerChargeTick(_state,_primary)
        return true
    }
    if((!_held || !scrNTTEFullEntanglerCanCharge()) && _state.chrg_num>0) {
        scrNTTEFullRedWeaponCharging(_state,-1);scrFire(_weapon,true,_primary)
        scrNTTEFullRedWeaponCharging(_state,0)
    }
    return true
}
function scrNTTEFullEntanglerFire(_primary=true) {
    var _state=scrNTTEFullRedWeaponState(scrNTTEState())
    if(_state.chrg>=0 && scrNTTEFullEntanglerCanCharge()) {
        wepangle*=-1;scrNTTEFullEntanglerChargeTick(_state,_primary)
        return noone
    }
    var _skill=scr_skill_get(mut_long_arms),_distance=20*_skill,_owner=scrNTTEFullRedWeaponOwner(),
        _mega=(_state.chrg_num>=_state.chrg_max && scrNTTEFullEntanglerCanCharge(_owner))
    if(_mega) _owner.ntte_red_ammo-=1
    var _shot=scr_damage_create(x+lengthdir_x(_distance,gunangle),y+lengthdir_y(_distance,gunangle),NTTEFullEntanglerSlash)
    _shot.direction=gunangle;_shot.image_angle=gunangle;_shot.speed=lerp(2,5,_skill)*timescale
    _shot.primary=_primary
    if(_mega) {
        _shot.sprite_index=scrNTTERefSprite("RedMegaSlash");_shot.mask_index=mskMegaSlash;_shot.damage=200;_shot.clone=true
        scrNTTEFullRedWeaponGunSound(sndBlackSword,0.2,0.3);scrNTTEFullRedWeaponGunSound(sndShovel,0.2,0.3)
        // Preserve the source's explicit negative UltraShotgun gain.
        scrNTTEFullRedWeaponGunSound(sndUltraShotgun,0.2,-0.5)
        repeat(3) with(instance_create(x,y,Smoke)) scrNTTEFullNativeMotionAddFT(id,random(360),1)
    }
    else {
        _shot.sprite_index=scrNTTERefSprite("RedHeavySlash");_shot.damage=20
        scrNTTEFullRedWeaponGunSound(sndChickenSword,0.2,0.3);scrNTTEFullRedWeaponGunSound(sndHammer,0.2,0.3)
        instance_create(x,y,Smoke)
    }
    scr_weapon_post(gunangle,_mega?32:16,6,_mega?-5:-4)
    scrNTTEFullNativeMotionAddFT(id,gunangle,6);sleep(10)
    return _shot
}
function scrNTTEFullEntanglerReloaded(_primary) {
    var _weapon=_primary?wep:bwep
    if(scrNTTEFullWeaponRaw(_weapon)!=wep_ntte_entangler) return false
    var _state=scrNTTEFullValue(id,_primary?"ntte_state":"bntte_state",undefined)
    if(is_struct(_state)) scrNTTEFullRedWeaponState(_state)
    if(is_struct(_state) && _state.chrg>0) {
        if(_primary) wepflip*=-1
        else bwepflip*=-1
    }
    else snd_play(sndMeleeFlip)
    return true
}
function scrNTTEFullEntanglerEat() {
    if(instance_is(id,Portal)) return noone
    var _clone=instance_create(x,y,NTTEFullCrystalClone)
    _clone.clone=id;_clone.creator=id;_clone.team=team
    return _clone
}

// clone=true branches of tecaves.RedSlash. Ordinary Annihilator slashes keep
// their own frozen handlers; Entangler uses the same genuine native parent.
function scrNTTEFullEntanglerSlashClone(_source) {
    if(!instance_exists(_source)) return noone
    var _size=scrNTTEFullValue(_source,"size",floor((_source.bbox_right-_source.bbox_left)/16)),
        _fx=instance_create(_source.x,_source.y,BulletHit)
    _fx.sprite_index=scrNTTERefSprite("WaterStreak");_fx.image_xscale=(2+_size)/3;_fx.image_yscale=_fx.image_xscale/3
    _fx.image_angle=(((_source.direction%180)-90)/4.5)+orandom(8)
    _fx.image_blend=scrAreaGetBackroundColor(scrNTTEFullAreaId("red"));_fx.depth=-4
    with(_fx) with(scrNTTEFullMergedNativeCopy(false)) image_angle+=180
    repeat(3) scrNTTEFullCrystalBrainEffect(_source.x+orandom(6*(_size+1)),_source.y+orandom(6*(_size+1)))
    sleep(8*(1+_size));snd_play(sndSwapSword,1.6+random(0.2))
    var _controller=instance_create(_source.x,_source.y,NTTEFullCrystalClone)
    _controller.clone=_source;_controller.creator=creator;_controller.team=team;_controller.budge=false
    with(_controller) scrNTTEFullCrystalCloneStep()
    return instance_exists(_controller)?_controller:noone
}
function scrNTTEFullEntanglerSlashPair(_source,_controller) {
    if(!instance_exists(_controller) || !instance_exists(_source)) return noone
    var _pair=instance_create(_source.x,_source.y,NTTEFullCrystalClone)
    _pair.clone=_source;_pair.target=_source;_pair.creator=_controller.creator;_pair.team=_controller.team
    _pair.appear=_controller.appear;_pair.appear_flip=!_controller.appear_flip
    return _pair
}
function scrNTTEFullEntanglerSlashHit(_target) {
    if(lockstep_stop || !scrNTTEFullRedSlashCanHit(_target)) return;
    var _hp=_target.hp
    scr_projectile_hit(_target,damage,knockback_speed)
    if(instance_exists(id) && clone && instance_exists(_target) && instance_is(_target,enemy) && _hp>0 && _target.hp<=0) {
        var _controller=scrNTTEFullEntanglerSlashClone(_target)
        if(instance_exists(_controller) && instance_exists(_controller.target)) {
            _controller.target.hp=_hp;_controller.appear=2/3;_controller.appear_health=_hp
        }
    }
}
function scrNTTEFullEntanglerSlashProjectile(_target) {
    if(lockstep_stop || !instance_exists(_target)) return;
    // Protect the whole deflect+clone transaction, including a monster shot
    // whose source has died. Returning only from RedSlash would still clone it.
    if(scrNTTEFullFriendlyMonsterShot(id,_target)) return;
    var _typ=scrNTTEFullValue(_target,"typ",0)
    scrNTTEFullRedSlashProjectile(_target)
    if(_typ!=1 || !candeflect || !clone || !instance_exists(_target)) return;
    var _controller=scrNTTEFullEntanglerSlashClone(_target)
    if(instance_exists(_controller) && instance_exists(_controller.target)) {
        _controller.appear=2/3
        with(_controller.target) {
            var _oldvspeed=vspeed
            direction+=random_range(10,20)*choose(-1,1);image_angle=direction
            if(vspeed<_oldvspeed) _controller.appear_flip=true
        }
        scrNTTEFullEntanglerSlashPair(_target,_controller)
    }
}
function scrNTTEFullEntanglerSlashEndStep() {
    if(lockstep_stop || !clone) return;
    var _targets=scrNTTEFullInstances(chestprop),_pickups=scrNTTEFullCrystalPickups()
    for(var _i=0;_i<array_length(_pickups);++_i) array_push(_targets,_pickups[_i])
    for(var _i=0;_i<array_length(_targets);++_i) {
        var _source=_targets[_i]
        if(!instance_exists(_source) || !place_meeting(x,y,_source)) continue
        var _overlap=false
        with(_source) _overlap=place_meeting(x,y,other.id)
        if(!_overlap || scrNTTEFullCrystalCloneHasTarget(_source)) continue
        with(_source) scrNTTEFullNativeMotionAddFT(id,random(180),1)
        var _controller=scrNTTEFullEntanglerSlashClone(_source)
        if(instance_exists(_controller) && instance_exists(_controller.target)) {
            _controller.appear=1/2;_controller.target.direction+=180
            scrNTTEFullEntanglerSlashPair(_source,_controller)
        }
    }
}

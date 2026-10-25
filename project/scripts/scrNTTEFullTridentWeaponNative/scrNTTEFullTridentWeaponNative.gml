// Original trident.wep.gml: charging is seven reload-speed-adjusted ticks;
// partial release stabs and full release transfers one actual physical weapon.
function scrNTTEFullTridentState(_state) {
    if(!variable_struct_exists(_state,"visible")) _state.visible=true
    if(!variable_struct_exists(_state,"wepangle")) _state.wepangle=0
    if(!variable_struct_exists(_state,"chrg_max")) _state.chrg_max=7
    return scrNTTEFullRedWeaponState(_state)
}
function scrNTTEFullTridentChargeTick(_state,_primary) {
    scrNTTEFullTridentState(_state)
    var _load=scrNTTEFullValue(id,"reloadspeed",1)*timescale
    _state.chrg=_state.chrg_num<_state.chrg_max?1:2
    if(_state.chrg==1) {
        _state.chrg_num=min(_state.chrg_num+_load,_state.chrg_max)
        if(_primary && scrNTTEFullValue(id,"specfiring",false)) _state.chrg_num=_state.chrg_max
    }
    else if((current_frame%12)<timescale) gunshine=2
    _state.charge=_state.chrg_num;reload=min(reload,_load)
    var _charge=_state.chrg_num/_state.chrg_max,_kick=9*_charge
    if(wkick!=_kick) scr_weapon_post(gunangle,8*_charge*timescale,0,_kick)
    if(_state.chrg==1) {
        snd_play(sndOasisMelee,1/(1-0.25*_charge))
        if(_charge>=1) {
            snd_play(sndCrystalRicochet,3);snd_play(sndSewerDrip,3)
            var _angle=gunangle+wepangle,_flash=instance_create(x+lengthdir_x(16,_angle),y+lengthdir_y(16,_angle),ThrowHit)
            _flash.depth=depth-1;instance_create(_flash.x,_flash.y,ImpactWrists);sleep(5)
        }
    }
    scrNTTEFullRedFireChargeRefresh(_state,_primary)
}
function scrNTTEFullTridentInput(_weapon,_primary) {
    var _state=scrNTTEFullTridentState(scrNTTEState()),_held=_primary?KeyCont.hold_fire[index]:KeyCont.hold_spec[index]
    if(!_state.visible || _state.ammo<=0) {_state.charge=0;_state.chrg_num=0;return true}
    if(_held && (can_shoot || _state.chrg_num>0)) {
        scrNTTEFullWeaponDropFire(_weapon);scrNTTEFullTridentChargeTick(_state,_primary);return true
    }
    if(!_held && _state.chrg_num>0) {
        scrNTTEFullRedWeaponCharging(_state,-1);scrFire(_weapon,true,_primary)
        scrNTTEFullRedWeaponCharging(_state,0)
    }
    return true
}
function scrNTTEFullTridentFire(_weapon,_primary) {
    var _state=scrNTTEFullTridentState(scrNTTEState())
    if(!_state.visible) {_state.chrg_num=0;_state.charge=0;return noone}
    if(_state.chrg>=0) {scrNTTEFullTridentChargeTick(_state,_primary);return noone}
    var _charge=_state.chrg_num/_state.chrg_max,_dir=gunangle,_shot=noone,
        _owner=scrNTTEFullRedWeaponOwner(),_physical=_weapon,
        _scope=variable_global_exists("ntte_full_merged_state_fire")?global.ntte_full_merged_state_fire:undefined
    if(is_struct(_scope) && _scope.actor==id) _physical=_scope.part
    var _gold=scrNTTEFullValue(scrNTTEFullWeaponModel(_physical),"gold",false)
        || scrNTTEFullWeaponRaw(_weapon)==wep_ntte_golden_trident
    if(_charge<=0) return noone
    if(_charge<1) {
        var _long=scr_skill_get(mut_long_arms),_distance=scr_weapon_get_load(_weapon)+8*_long,
            _offset=220/_distance
        scr_weapon_post(_dir,-20,8,-_distance);scrNTTEFullNativeMotionAddFT(id,_dir,2)
        for(var _index=-1;_index<=1;++_index) {
            var _angle=_index*_offset
            for(var _length=_distance+8*(_index==0?1:2/3);_length>0;_length-=16) {
                _shot=scrNTTEFullMergedBasicProjectileCreate(x+hspeed/timescale+lengthdir_x(_length,_dir+_angle),
                    y+vspeed/timescale+lengthdir_y(_length,_dir+_angle)-(_primary?0:4),
                    Shank,_dir+_angle/3,(1+_long)*(_index==0?1:0.5))
                _shot.image_xscale=0.5+0.1*(_index==0);_shot.image_yscale=0.9;_shot.canfix=false
                _shot.damage=20;_shot.depth=depth-(1+0.1*(_index!=0));_shot.primary=_primary
                if(_length<_distance) _shot.visible=false
                else with(_shot) if(place_meeting(x+hspeed/timescale,y+vspeed/timescale,Wall)) {
                    snd_play(sndMeleeWall);instance_create(x+orandom(4),y+orandom(4),Debris)
                    var _wall=instance_nearest(x+hspeed/timescale-8,y+vspeed/timescale-8,Wall)
                    if(instance_exists(_wall)) {
                        var _fx=instance_create((_wall.bbox_left+_wall.bbox_right+1)/2+orandom(4),
                            (_wall.bbox_top+_wall.bbox_bottom+1)/2+orandom(4),MeleeHitWall)
                        _fx.image_angle=_dir
                    }
                }
            }
        }
    }
    else {
        var _curse=scrNTTEFullValue(_owner,"curse",0)
        _shot=scrNTTEFullMergedBasicProjectileCreate(x,y,NTTEFullTrident,_dir,18*(1+0.3*_gold))
        _shot.sprite_index=scr_weapon_get_sprite(_physical);_shot.curse=_curse
        _shot.wep=_physical;_shot.state=_state;_shot.primary=_primary
        // ActorFire replaces constructor proxy creators in its collected shots.
        _shot.creator=_owner
        scrNTTEFullTridentWeaponProjectileCapture(_shot,_physical,_state)
        scr_weapon_post(_dir,50,5,-4);scrNTTEFullNativeMotionAddFT(id,_dir,4)
        if(scrNTTEFullRedFireChargeHeld(_owner,_state,_primary)
            || (is_struct(_scope) && _scope.actor==id)) {
            if(_curse<=0) {
                // The accepted modern firing adapter finishes its reload/slot
                // transaction before consuming ground weapons next PlayerStep.
                // Changing/swapping here corrupts Steroids' temporarily mounted slot.
                if(is_struct(_scope) && _scope.actor==id) _state.ntte_trident_thrown=true
                else _state.ammo=0
                _state.visible=false
            }
            else _state.visible=false
        }
    }
    var _pitch=random_range(0.8,1.2)
    scrNTTEFullDiscWeaponSound(sndAssassinAttack,1.3*_pitch,1.6)
    scrNTTEFullDiscWeaponSound(sndOasisExplosionSmall,0.7*_pitch,0.7)
    scrNTTEFullDiscWeaponSound(sndOasisDeath,1.2*_pitch,0.8);snd_play(sndOasisMelee,_pitch)
    if(_gold) scrNTTEFullDiscWeaponSound(sndSwapGold,0.8*_pitch,0.7)
    var _bubble=instance_create(x+lengthdir_x(24,_dir),y+lengthdir_y(24,_dir),Bubble)
    with(_bubble) {direction=_dir+orandom(30);speed=choose(1,2,2,3,3)*timescale}
    sleep(15)
    return _shot
}
function scrNTTEFullTridentReorient(_state,_primary) {
    if(!is_struct(_state) || scrNTTEFullValue(_state,"wepangle",0)==0) return;
    var _angle=_state.wepangle
    variable_instance_set(id,_primary?"wepangle":"bwepangle",_angle)
    _angle-=clamp(_angle*0.4,-40,40)*timescale
    if(abs(_angle)<1) _angle=0
    _state.wepangle=_angle
}
function scrNTTEFullTridentPlayerEndStep() {
    if(lockstep_stop) return;
    // Native LWO handles and trees already receive each physical part's EndStep
    // from MergedRuntimeState. Ordinary raw slots still need the source decay.
    if(!is_struct(wep) && !scrNTTEFullWeaponIsNative(wep) && scrNTTEIsTrident(wep)) scrNTTEFullTridentReorient(scrNTTEFullValue(id,"ntte_state",undefined),true)
    if(!is_struct(bwep) && !scrNTTEFullWeaponIsNative(bwep) && scrNTTEIsTrident(bwep)) scrNTTEFullTridentReorient(scrNTTEFullValue(id,"bntte_state",undefined),false)
}

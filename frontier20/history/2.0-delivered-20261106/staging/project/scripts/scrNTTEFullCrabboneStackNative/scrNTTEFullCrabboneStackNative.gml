// crabbone.wep.gml ordinary-stack batch. Source names in this adapter retain
// the acyclic physical ammo_wep chain, never an ammo total shared by two slots.
// Artifact interfaces are public for Quest; their firing/native merged transfer
// remain separate batches and this file does not open any world availability.
function scrNTTEFullCrabboneIs(_weapon) {
    var _raw=scrNTTEFullWeaponRaw(_weapon)
    if(!is_numeric(_raw)) return false
    return scrNTTEIsBone(_raw)
}
function scrNTTEFullCrabbonePartIndex(_weapon,_state=undefined) {
    var _model=scrNTTEFullWeaponModel(_weapon),_raw=scrNTTEFullWeaponRaw(_model)
    if(!scrNTTEIsBone(_raw)) return -1
    if(!is_struct(_state)) _state=scrNTTEFullValue(_model,"ntte_native_state",undefined)
    var _ammo=scrNTTEFullValue(_model,"ammo",scrNTTEFullValue(_state,"ammo",1)),
        _type=scrNTTEFullValue(_model,"type_index",scrNTTEFullValue(_state,"type_index",
            _raw==wep_ntte_bone?0:1+_raw-wep_ntte_ancient_artifact))
    return _ammo>0?_type-1:-1
}
function scrNTTEFullCrabboneCreateModel(_part_index,_ammo=1) {
    assert(_part_index>=-1 && _part_index<=3,"Crabbone part index must be ordinary -1 or quest0..3")
    var _raw=_part_index<0?wep_ntte_bone:wep_ntte_ancient_artifact+_part_index,
        _model={wep:_raw,ammo:_ammo,ammo_wep:wep_none,type_index:_part_index+1,combo:0},
        _state=scrNTTENewState(_raw)
    _state.ammo=_ammo;_state.ammo_wep=wep_none;_state.type_index=_part_index+1
    _model.ntte_native_state=_state
    return _model
}
function scrNTTEFullCrabboneParts(_weapon) {
    var _model=scrNTTEFullWeaponModel(_weapon),_out=[]
    while(true) {
        if(scrNTTEFullCrabboneIs(_model)) array_push(_out,_model)
        if(scrNTTEFullWeaponHasMerge(_model)==false) break
        _model=scrNTTEFullWeaponMergedPart(_model)
    }
    return _out
}
function scrNTTEFullCrabboneSetAmmo(_weapon,_ammo) {
    var _model=scrNTTEFullWeaponModel(_weapon)
    if(!is_struct(_model) || !scrNTTEFullCrabboneIs(_model)) return false
    _model.ammo=_ammo
    var _state=scrNTTEFullValue(_model,"ntte_native_state",undefined)
    if(is_struct(_state)) _state.ammo=_ammo
    return true
}
function scrNTTEFullCrabboneState(_state) {
    if(!variable_struct_exists(_state,"ammo_wep")) _state.ammo_wep=wep_none
    if(!variable_struct_exists(_state,"type_index")) {
        var _raw=scrNTTEFullWeaponRaw(_state.weapon)
        _state.type_index=(_raw>=wep_ntte_ancient_artifact && _raw<=wep_ntte_missing_artifact)
            ?1+_raw-wep_ntte_ancient_artifact:0
    }
    return _state
}
function scrNTTEFullCrabbonePhysical(_weapon,_state) {
    scrNTTEFullCrabboneState(_state)
    var _model=scrNTTEFullWeaponModel(_weapon)
    if(!is_struct(_model)) _model={wep:_weapon}
    _model.ntte_native_state=_state;_model.ammo=_state.ammo
    _model.ammo_wep=_state.ammo_wep;_model.combo=_state.combo;_model.type_index=_state.type_index
    return _model
}
function scrNTTEFullCrabbonePromptMeet(_player) {
    return _player.index==index && scrNTTEFullWeaponRaw(_player.wep)==wep_ntte_bone
}
function scrNTTEFullCrabboneStackPickup(_primary,_state) {
    var _list=ds_list_create(),_slot=_primary?"wep":"bwep",_key=_primary?"ntte_state":"bntte_state",
        _curse=_primary?curse:bcurse
    instance_place_list(x,y,WepPickup,_list,false)
    try {
        for(var _i=0;_i<ds_list_size(_list);++_i) {
            var _pickup=_list[|_i]
            // Numeric ordinary bones are this batch's natural contact path.
            // Quest/merged LWOs need their dedicated reference-transfer batch.
            if(!instance_exists(_pickup) || !_pickup.visible || _pickup.curse>_curse
                || _pickup.wep!=wep_ntte_bone) continue
            var _incoming=scrNTTEFullValue(_pickup,"ntte_state",undefined)
            if(!is_struct(_incoming)) _incoming=scrNTTENewState(wep_ntte_bone)
            if(_incoming==_state || _incoming.ammo<=0) continue
            scrNTTEFullCrabboneState(_incoming)
            var _amount=_incoming.ammo,_previous=scrNTTEFullCrabbonePhysical(variable_instance_get(id,_slot),_state)
            _incoming.ammo=_amount+_state.ammo;_incoming.ammo_wep=_previous
            variable_instance_set(id,_slot,wep_ntte_bone);variable_instance_set(id,_key,_incoming)
            _state=_incoming
            if(_primary || race==Race.Steroids) variable_instance_set(id,_primary?"wkick":"bwkick",0)
            else scrPopupCreate(x,y,loc_fmt("HUD:GotWeapon","%!",scr_weapon_get_name(wep_ntte_bone))+" x"+string(_amount))
            if(!variable_global_exists("ntte_full_progress")) scrNTTEFullProgressLoad()
            if(_state.ammo>scrNTTEFullValue(global.ntte_full_progress.stats,"bone",0)) {
                global.ntte_full_progress.stats.bone=_state.ammo;scrNTTEFullProgressSave()
            }
            var _fx=instance_create(_pickup.x,_pickup.y,DiscDisappear)
            _fx.image_angle=scrNTTEFullValue(_pickup,"rotation",0)
            scrNTTEFullDiscWeaponSound(sndHPPickup,4,1)
            scrNTTEFullDiscWeaponSound(sndPickupDisappear,1.2,1)
            scrNTTEFullDiscWeaponSound(sndBloodGamble,0.4+random(0.2),0.9)
            instance_destroy(_pickup)
        }
    }
    finally {ds_list_destroy(_list)}
    return _state
}
function scrNTTEFullCrabbonePendingSlots() {
    var _changed=false
    for(var _slot=0;_slot<2;++_slot) {
        var _primary=_slot==0,_key=_primary?"ntte_state":"bntte_state",_name=_primary?"wep":"bwep",
            _state=scrNTTEFullValue(id,_key,undefined)
        if(!is_struct(_state) || !scrNTTEFullValue(_state,"ntte_crabbone_pending_pop",false)) continue
        var _next=_state.ntte_crabbone_next
        _state.ntte_crabbone_pending_pop=false;_state.ntte_crabbone_next=wep_none
        if(is_struct(_next)) {
            // Exact old physical state, rather than reconstructing it from the
            // displayed ammo total or borrowing the other equal-raw slot.
            var _previous=_next.ntte_native_state
            variable_instance_set(id,_name,_next.wep);variable_instance_set(id,_key,_previous)
        }
        else {variable_instance_set(id,_name,wep_none);variable_instance_set(id,_key,undefined)}
        variable_instance_set(id,_primary?"wkick":"bwkick",0)
        _changed=true
    }
    if(_changed && wep==wep_none) {
        if(bwep!=wep_none) scrSwapWeps(false)
        else if(array_length(extra_weps)>0) scrExtraWepRestoreFirst()
        clicked=false;swapmove=1;drawempty=30
    }
}
function scrNTTEFullCrabboneGiveScythe(_primary) {
    // Original Prompt installs a temporary nearwep IceFlower until EndStep;
    // the same pickup press therefore cannot also switch the new Scythe mode.
    ntte_crabbone_scythe_frame=current_frame
    var _slot=_primary?"wep":"bwep",_key=_primary?"ntte_state":"bntte_state"
    variable_instance_set(id,_slot,wep_ntte_bone_scythe)
    variable_instance_set(id,_key,scrNTTENewState(wep_ntte_bone_scythe))
    scrNTTEFullDiscWeaponSound(sndBloodGamble,0.5,1)
    scrNTTEFullDiscWeaponSound(sndCursedChest,0.9,2)
    scrNTTEFullDiscWeaponSound(sndFishWarrantEnd,1.2,2)
    clicked=false;swapmove=1
    if(!visible || instance_exists(GenCont) || instance_exists(LevCont)) return;
    variable_instance_set(id,_primary?"wkick":"bwkick",-3);gunshine=1
    scrPopupCreate(x,y,loc_fmt("HUD:GotWeapon","%!",scr_weapon_get_name(wep_ntte_bone_scythe)))
    var _owner=id,_count=0,_angle=gunangle+variable_instance_get(id,_primary?"wepangle":"bwepangle")
    with(NTTEFullBoneFX) if(creator==_owner) _count+=1
    repeat(max(0,8-_count)) {
        var _fx=instance_create(x+lengthdir_x(12,_angle),y+lengthdir_y(12,_angle),NTTEFullBoneFX)
        _fx.creator=id;with(_fx) motion_add(_angle,timescale)
    }
    repeat(6) {
        var _fx=instance_create(x+lengthdir_x(8,_angle),y+lengthdir_y(8,_angle),Dust)
        /* NTTE DUST LIFETIME crabbone-scythe */ if(instance_exists(_fx)) {_fx.depth=-3; }with(_fx) motion_add(_angle+orandom(60),(1+random(5))*timescale)
    }
}
function scrNTTEFullCrabboneStepSlots() {
    scrNTTEFullCrabbonePendingSlots()
    var _ordinary=false
    for(var _slot=0;_slot<2;++_slot) {
        var _primary=_slot==0,_weapon=_primary?wep:bwep
        if(_weapon!=wep_ntte_bone) continue
        var _key=_primary?"ntte_state":"bntte_state",_state=scrNTTEFullValue(id,_key,undefined)
        if(!is_struct(_state) || _state.weapon!=_weapon) {
            _state=scrNTTENewState(_weapon);variable_instance_set(id,_key,_state)
        }
        scrNTTEFullCrabboneState(_state)
        if(_state.ammo<=0) continue
        _ordinary=true
        var _kick=variable_instance_get(id,_primary?"wkick":"bwkick")
        if(_kick<=0 && _kick>-5) variable_instance_set(id,_primary?"wkick":"bwkick",max(-5,_kick-2*timescale))
        _state=scrNTTEFullCrabboneStackPickup(_primary,_state)
        if(_state.ammo>=10) {
            if(!instance_exists(scrNTTEFullValue(id,"prompt_scythe",noone))) {
                prompt_scythe=scrNTTEFullPromptCreate(id,"SCYTHE")
                prompt_scythe.depth=1000000;prompt_scythe.index=index
                prompt_scythe.on_meet=scrNTTEFullCrabbonePromptMeet
            }
            prompt_scythe.yoff=sin(scrNTTEFullValue(id,"wave",0)/10)
            if(prompt_scythe.pick==index) {
                instance_destroy(prompt_scythe)
                var _rest=scrNTTEFullCrabbonePhysical(_weapon,_state)
                scrNTTEFullCrabboneGiveScythe(_primary);scrNTTEFullUnlockSet("wep:scythe",true)
                repeat(10) {
                    if(is_struct(_rest) && variable_struct_exists(_rest,"ammo_wep")) _rest=_rest.ammo_wep
                    else break
                }
                if(is_struct(_rest)) {
                    var _drop=scrWeaponPickupCreate(x,y,_rest.wep)
                    _drop.ntte_state=_rest.ntte_native_state
                }
            }
        }
        else if(instance_exists(scrNTTEFullValue(id,"prompt_scythe",noone))) instance_destroy(prompt_scythe)
    }
    if(!_ordinary && !scrNTTEFullCrabbonePhysicalPromptHeld(id) && instance_exists(scrNTTEFullValue(id,"prompt_scythe",noone))) instance_destroy(prompt_scythe)
}
function scrNTTEFullCrabboneFire(_weapon,_primary) {
    if(_weapon!=wep_ntte_bone) return false
    var _scope=variable_global_exists("ntte_full_merged_state_fire")?global.ntte_full_merged_state_fire:undefined
    if(is_struct(_scope)) return false
    var _state=scrNTTEFullCrabboneState(scrNTTEState()),_long=scr_skill_get(mut_long_arms),_dir=gunangle
    if(scrNTTEFullValue(_state,"ntte_crabbone_pending_pop",false)) return true
    reload=curse>0?30:6
    if(curse>0) {
        if(abs(wepangle)==120) wepangle=100*sign(wepangle)
        var _heavy=(++_state.combo mod 2)==0,_flip=sign(wepangle),_dis=lerp(10,20,_long),
            _slash=scrNTTEFullMergedBasicProjectileCreate(x+hspeed+lengthdir_x(_dis,_dir),
                y+vspeed+lengthdir_y(_dis,_dir),NTTEFullBoneSlash,_dir+orandom(5*accuracy),lerp(2,4,_long))
        _slash.image_xscale*=0.75;_slash.image_yscale*=0.75*_flip;_slash.rotspeed=2*_flip;_slash.heavy=_heavy
        scrNTTEFullDiscWeaponSound(sndWrench,1,0.5);snd_play_hit(sndCursedReminder,0.1)
        scrNTTEFullDiscWeaponSound(sndBloodGamble,(_heavy?0.5:0.7)+random(0.2),_heavy?0.7:0.5)
        if(_heavy) snd_play(sndHammer,1+random(0.2))
        instance_create(x,y,Dust);scr_weapon_post(_dir,12+8*_heavy,1,-9-3*_heavy)
        scrNTTEFullNativeMotionAddFT(id,_dir+20*_flip,3+_heavy)
        if(_heavy) sleep(10)
        return true
    }
    if(_state.ammo<=0) {reload=reloadspeed*timescale;return true}
    var _infinite=infammo!=0 || global.__debug_infammo,_next=_state.ammo_wep
    if(!_infinite) {
        _state.ntte_crabbone_pending_pop=true;_state.ntte_crabbone_next=_next
    }
    // The original projectile carries this physical top bone normalized to1.
    // Historical user override retains non-pickable two-piece ordinary shards.
    _state.ammo=1;_state.ammo_wep=wep_none
    var _physical=scrNTTEFullCrabbonePhysical(_weapon,_state),
        _shot=scrNTTEFullCrabboneProjectileCreate(id,_physical,_dir,lerp(16,20,_long),0,_infinite)
    scr_weapon_post(_dir,-4,4,-10)
    var _fx=instance_create(x,y,MeleeHitWall)
    with(_fx) {motion_add(other.gunangle,timescale);image_angle=direction+180}
    snd_play(sndChickenThrow);snd_play(sndBloodGamble,0.7+random(0.2))
    return true
}

// Source crabbone.wep physical LWO fire/stack/step. Replacements commit only
// after native raw/state/creator mounts restore, preserving original parts.
function scrNTTEFullCrabboneReplace(_weapon,_part,_replacement) {
    var _model=scrNTTEFullWeaponModel(_weapon)
    if(_model==_part) return {weapon:_replacement,changed:true,root:true}
    if(scrNTTEFullWeaponHasMerge(_model)!=false) {
        var _child=scrNTTEFullCrabboneReplace(_model.temerge.wep[0],_part,_replacement)
        if(_child.changed) {
            _model.temerge.wep[@ 0]=_child.weapon
            _model.temerge.is_part=(scrNTTEFullWeaponRaw(_model)==wep_none
                || scrNTTEFullWeaponHasMergedWeapon(_model,wep_none)!=false)
            return {weapon:_weapon,changed:true,root:false}
        }
    }
    return {weapon:_weapon,changed:false,root:false}
}
function scrNTTEFullCrabboneReplaceActor(_actor,_part,_next,_swap=true) {
    if(!instance_exists(_actor)) return;
    for(var _slot=0;_slot<2;++_slot) {
        var _name=_slot==0?"wep":"bwep",_key=_slot==0?"ntte_state":"bntte_state"
        if(!variable_instance_exists(_actor,_name)) continue
        var _weapon=variable_instance_get(_actor,_name),_result=scrNTTEFullCrabboneReplace(_weapon,_part,_next)
        if(!_result.changed) continue
        variable_instance_set(_actor,_name,scrNTTEFullWeaponNative(_result.weapon))
        if(_result.root) {
            variable_instance_set(_actor,_key,is_struct(_next)?scrNTTEFullWeaponNativeState(_next):undefined)
            variable_instance_set(_actor,_slot==0?"wkick":"bwkick",0)
            if(_swap && _slot==0 && scrNTTEFullWeaponRaw(_next)==wep_none && instance_is(_actor,Player)
                && !variable_instance_exists(_actor,"ntte_merged_actor_owner")) _actor.ntte_crabbone_pending_swap=true
        }
        if(scrNTTEFullWeaponIsNative(variable_instance_get(_actor,_name)))
            scrNTTEFullWeaponNativeRefresh(variable_instance_get(_actor,_name))
    }
}
function scrNTTEFullCrabboneTransferRefs(_fire_at) {
    var _refs=scrNTTEFullValue(_fire_at,"ntte_crabbone_transfer_refs",[]),
        _ref=scrNTTEFullValue(_fire_at,"wep",undefined)
    if(is_array(_ref) && array_length(_ref)>0 && array_get_index(_refs,_ref)<0) array_push(_refs,_ref)
    return _refs
}
function scrNTTEFullCrabboneTransferQueue(_actor,_part,_fire_at) {
    var _state=scrNTTEFullValue(_part,"ntte_native_state",undefined)
    if(!is_struct(_state) || !scrNTTEFullValue(_state,"ntte_crabbone_transfer",false)) return;
    if(!variable_global_exists("ntte_full_crabbone_transfers")) global.ntte_full_crabbone_transfers=[]
    var _rows=global.ntte_full_crabbone_transfers,_row=undefined
    for(var _i=0;_i<array_length(_rows);++_i) if(_rows[_i].part==_part) {_row=_rows[_i];break}
    if(!is_struct(_row)) {
        _row={actor:_actor,owner:scrNTTEFullMergedRuntimeActorOwner(_actor),part:_part,state:_state,
            next:_state.ntte_crabbone_transfer_next,refs:[]}
        array_push(global.ntte_full_crabbone_transfers,_row)
    }
    var _refs=scrNTTEFullCrabboneTransferRefs(_fire_at)
    for(var _i=0;_i<array_length(_refs);++_i)
        if(array_get_index(_row.refs,_refs[_i])<0) array_push(_row.refs,_refs[_i])
}
function scrNTTEFullCrabboneTransferFlush() {
    if(!variable_global_exists("ntte_full_crabbone_transfers")) return;
    if(variable_global_exists("ntte_full_merged_state_fire") && is_struct(global.ntte_full_merged_state_fire)) return;
    if(variable_global_exists("ntte_full_merged_plain_depth") && global.ntte_full_merged_plain_depth>0) return;
    if(variable_global_exists("ntte_full_merged_input_weapon") && !is_undefined(global.ntte_full_merged_input_weapon)) return;
    var _rows=global.ntte_full_crabbone_transfers
    global.ntte_full_crabbone_transfers=[]
    for(var _i=0;_i<array_length(_rows);++_i) {
        var _row=_rows[_i]
        scrNTTEFullCrabboneReplaceActor(_row.actor,_row.part,_row.next)
        if(_row.owner!=_row.actor) scrNTTEFullCrabboneReplaceActor(_row.owner,_row.part,_row.next)
        for(var _j=0;_j<array_length(_row.refs);++_j) {
            var _ref=_row.refs[_j],_result=scrNTTEFullCrabboneReplace(_ref[0],_row.part,_row.next)
            if(_result.changed) _ref[@ 0]=_result.weapon
        }
        _row.state.ntte_crabbone_transfer=false;_row.state.ntte_crabbone_transfer_next=wep_none
    }
}
function scrNTTEFullCrabbonePhysicalFire(_raw,_primary) {
    if(!scrNTTEFullCrabboneIs(_raw)) return false
    var _scope=variable_global_exists("ntte_full_merged_state_fire")?global.ntte_full_merged_state_fire:undefined
    // Accepted ordinary raw stack owns its safe next-Step pop. All physical
    // native/merged parts and the four plain artifact aliases use this path.
    if(_raw==wep_ntte_bone && !is_struct(_scope)) return false
    var _state=scrNTTEFullCrabboneState(scrNTTEState()),
        _part=is_struct(_scope)?_scope.part:scrNTTEFullCrabbonePhysical(_raw,_state),
        _index=scrNTTEFullCrabbonePartIndex(_part,_state),_artifact=_index>=0,
        _long=scr_skill_get(mut_long_arms),_dir=gunangle
    if(scrNTTEFullValue(_state,"ntte_crabbone_transfer",false)) return true
    reload=curse>0?30:6
    if(curse>0) {
        if(abs(wepangle)==120) wepangle=100*sign(wepangle)
        var _heavy=(++_state.combo mod 2)==0 && !_artifact,_flip=sign(wepangle),
            _dis=lerp(10,20,_long)+(_artifact?-16:0),
            _slash=scrNTTEFullMergedBasicProjectileCreate(x+hspeed+lengthdir_x(_dis,_dir),
                y+vspeed+lengthdir_y(_dis,_dir),_artifact?EnergySlash:NTTEFullBoneSlash,
                _dir+orandom(5*accuracy),lerp(2,4,_long))
        _slash.image_xscale*=0.75;_slash.image_yscale*=0.75*_flip
        if(_artifact) {
            _slash.damage=25;_slash.force=10;_slash.knockback_speed=10*timescale
            var _sprites=["EnergyBatSlash","PurpleEnergyBatSlash","PopoEnergyBatSlash","EnemyEnergyBatSlash"]
            _slash.sprite_index=scrNTTERefSprite(_sprites[_index])
            scrNTTEFullDiscWeaponSound(scr_skill_get(mut_laser_brain)>0?sndEnergySwordUpg:sndEnergySword,1,0.3)
            snd_play(sndBlackSword,random_range(0.5,0.7),2/3)
        }
        else {
            _slash.rotspeed=2*_flip;_slash.heavy=_heavy
            scrNTTEFullDiscWeaponSound(sndWrench,1,0.5);snd_play_hit(sndCursedReminder,0.1)
            snd_play(sndBloodGamble,(_heavy?0.5:0.7)+random(0.2),_heavy?0.7:0.5)
            if(_heavy) snd_play(sndHammer,1+random(0.2))
        }
        _part.combo=_state.combo
        instance_create(x,y,Dust);scr_weapon_post(_dir,12+8*_heavy,1,-9-3*_heavy)
        scrNTTEFullNativeMotionAddFT(id,_dir+20*_flip,3+_heavy)
        if(_heavy) sleep(10)
        return true
    }
    if(_state.ammo<=0) {reload=reloadspeed*timescale;return true}
    var _infinite=!_artifact && (infammo!=0 || global.__debug_infammo),_next=_state.ammo_wep
    if(!_infinite) {
        if(is_struct(_scope)) {
            _state.ntte_crabbone_transfer=true;_state.ntte_crabbone_transfer_next=_next
        }
        else {_state.ntte_crabbone_pending_pop=true;_state.ntte_crabbone_next=_next}
    }
    _state.ammo=1;_state.ammo_wep=wep_none
    _part.ammo=1;_part.ammo_wep=wep_none;_part.ntte_native_state=_state
    var _shot=scrNTTEFullCrabboneProjectileCreate(id,_part,_dir,lerp(16,20,_long),curse,_infinite)
    scr_weapon_post(_dir,-4,4,-10)
    var _fx=instance_create(x,y,MeleeHitWall)
    with(_fx) {motion_add(other.gunangle,timescale);image_angle=direction+180}
    snd_play(sndChickenThrow)
    snd_play(_artifact?sndPlasmaReload:sndBloodGamble,_artifact?2+orandom(0.1):0.7+random(0.2))
    return true
}
function scrNTTEFullCrabbonePhysicalPickup(_part,_primary) {
    var _state=scrNTTEFullCrabboneState(scrNTTEFullWeaponNativeState(_part)),
        _artifact=scrNTTEFullCrabbonePartIndex(_part,_state)>=0,
        _curse=_primary?curse:bcurse,_list=ds_list_create()
    instance_place_list(x,y,WepPickup,_list,false)
    try {
        for(var _i=0;_i<ds_list_size(_list);++_i) {
            var _pickup=_list[|_i]
            if(!instance_exists(_pickup) || !_pickup.visible || _pickup.curse>_curse || !scrNTTEFullCrabboneIs(_pickup.wep)) continue
            var _incoming=scrNTTEFullWeaponModel(_pickup.wep),_incoming_state=scrNTTEFullValue(_pickup,"ntte_state",undefined)
            if(!is_struct(_incoming_state)) _incoming_state=is_struct(_incoming)?scrNTTEFullWeaponNativeState(_incoming):scrNTTENewState(_pickup.wep)
            scrNTTEFullCrabboneState(_incoming_state)
            if(_incoming_state==_state || _incoming_state.ammo<=0) continue
            var _new_artifact=scrNTTEFullCrabbonePartIndex(_incoming,_incoming_state)>=0
            if(_new_artifact!=_artifact || (_new_artifact && scrNTTEFullQuestFloorTouch(_pickup))) continue
            _incoming=scrNTTEFullCrabbonePhysical(_incoming,_incoming_state)
            var _amount=_incoming_state.ammo
            _incoming_state.ammo+=_state.ammo;_incoming_state.ammo_wep=scrNTTEFullCrabbonePhysical(_part,_state)
            _incoming.ammo=_incoming_state.ammo;_incoming.ammo_wep=_incoming_state.ammo_wep
            scrNTTEFullCrabboneReplaceActor(id,_part,_incoming,false)
            _part=_incoming;_state=_incoming_state
            var _held=_primary || race==Race.Steroids
            if(_held) {variable_instance_set(id,_primary?"wkick":"bwkick",0);if(_new_artifact) gunshine=max(scrNTTEFullValue(id,"gunshine",0),2)}
            if(!_held || _new_artifact) scrPopupCreate(x,y,loc_fmt("HUD:GotWeapon","%!",scr_weapon_get_name(_pickup.wep))+" x"+string(_amount))
            if(!_new_artifact && _state.ammo>scrNTTEFullValue(global.ntte_full_progress.stats,"bone",0)) {
                global.ntte_full_progress.stats.bone=_state.ammo;scrNTTEFullProgressSave()
            }
            var _fx=instance_create(_pickup.x,_pickup.y,DiscDisappear)
            _fx.image_angle=scrNTTEFullValue(_pickup,"rotation",0)
            snd_play(sndHPPickup,4);snd_play(sndPickupDisappear,1.2);snd_play(sndBloodGamble,0.4+random(0.2),0.9)
            instance_destroy(_pickup)
        }
    }
    finally {ds_list_destroy(_list)}
    return _part
}
function scrNTTEFullCrabbonePhysicalStepSlots() {
    scrNTTEFullCrabboneTransferFlush()
    if(scrNTTEFullValue(id,"ntte_crabbone_pending_swap",false)) {
        ntte_crabbone_pending_swap=false
        if(wep==wep_none) {
            if(bwep!=wep_none) scrSwapWeps(false)
            else if(array_length(extra_weps)>0) scrExtraWepRestoreFirst()
            clicked=false;swapmove=1;drawempty=30
        }
    }
    for(var _slot=0;_slot<2;++_slot) {
        var _primary=_slot==0,_weapon=_primary?wep:bwep
        var _promote=_weapon>=wep_ntte_ancient_artifact && _weapon<=wep_ntte_missing_artifact
        if(_weapon==wep_ntte_bone) {
            // Source raw ordinary Bone becomes an LWO when it encounters a
            // physical stack pickup; keep the accepted all-raw path otherwise.
            var _touch=ds_list_create()
            instance_place_list(x,y,WepPickup,_touch,false)
            for(var _j=0;_j<ds_list_size(_touch);++_j) {
                var _pickup=_touch[|_j]
                if(_pickup.visible && _pickup.curse<=(_primary?curse:bcurse)
                    && is_struct(scrNTTEFullWeaponModel(_pickup.wep)) && scrNTTEFullCrabboneOrdinaryPickup(_pickup)) {
                    _promote=true;break
                }
            }
            ds_list_destroy(_touch)
        }
        if(_promote) {
            var _key=_primary?"ntte_state":"bntte_state",_state=scrNTTEFullValue(id,_key,undefined)
            if(!is_struct(_state)) _state=scrNTTENewState(_weapon)
            if(scrNTTEFullValue(_state,"ntte_crabbone_pending_pop",false)) continue
            _weapon=scrNTTEFullWeaponNative(scrNTTEFullCrabbonePhysical(_weapon,_state))
            variable_instance_set(id,_primary?"wep":"bwep",_weapon)
            variable_instance_set(id,_key,scrNTTEFullWeaponNativeState(_weapon))
        }
        if(!scrNTTEFullWeaponIsNative(_weapon) && !is_struct(_weapon)) continue
        var _parts=scrNTTEFullMergedRuntimeStateParts(_weapon)
        for(var _i=0;_i<array_length(_parts);++_i) {
            var _part=_parts[_i]
            if(!scrNTTEFullCrabboneIs(_part)) continue
            var _state=scrNTTEFullCrabboneState(scrNTTEFullWeaponNativeState(_part))
            if(_state.ammo<=0) {scrNTTEFullCrabboneReplaceActor(id,_part,_state.ammo_wep);continue}
            var _kick=variable_instance_get(id,_primary?"wkick":"bwkick")
            if(_kick<=0 && _kick>-5) variable_instance_set(id,_primary?"wkick":"bwkick",max(-5,_kick-2*timescale))
            _part=scrNTTEFullCrabbonePhysicalPickup(_part,_primary);_state=_part.ntte_native_state
            var _artifact=scrNTTEFullCrabbonePartIndex(_part,_state)>=0
            if(_artifact) {
                if(_primary && random(20)<timescale) {
                    var _len=random_range(4,12)-_kick,_dir=gunangle+(_primary?wepangle:bwepangle)*(1-_kick/20),
                        _spark=scrNTTEFullSystemsCreate("VaultFlowerSparkle",x+lengthdir_x(_len,_dir)+orandom(4),y+lengthdir_y(_len,_dir)+orandom(4)),
                        _index=scrNTTEFullCrabbonePartIndex(_part,_state)
                    _spark.sprite_index=(_index==0)?scrNTTERefSprite("AllyLaserCharge"):
                        (_index==1?scrNTTERefSprite("ElectroPlasmaTrail"):(_index==2?sprIDPDPortalCharge:sprLaserCharge))
                    _spark.depth=depth+(_primary?-1:1)
                }
            }
            else if(_state.ammo>=10 && scrNTTEFullWeaponModel(_primary?wep:bwep)==_part) {
                if(!instance_exists(scrNTTEFullValue(id,"prompt_scythe",noone))) {
                    prompt_scythe=scrNTTEFullPromptCreate(id,"SCYTHE");prompt_scythe.depth=1000000
                    prompt_scythe.index=index;prompt_scythe.on_meet=scrNTTEFullCrabbonePromptMeet
                }
                prompt_scythe.yoff=sin(scrNTTEFullValue(id,"wave",0)/10)
                if(prompt_scythe.pick==index) {
                    instance_destroy(prompt_scythe)
                    var _rest=_part,_saved=_primary?wep:bwep,_saved_state=_primary?ntte_state:bntte_state
                    scrNTTEFullCrabboneGiveScythe(_primary)
                    var _scythe={wep:wep_ntte_bone_scythe,ntte_native_state:_primary?ntte_state:bntte_state}
                    variable_instance_set(id,_primary?"wep":"bwep",_saved)
                    variable_instance_set(id,_primary?"ntte_state":"bntte_state",_saved_state)
                    scrNTTEFullCrabboneReplaceActor(id,_part,_scythe,false);scrNTTEFullUnlockSet("wep:scythe",true)
                    repeat(10) {if(is_struct(_rest) && variable_struct_exists(_rest,"ammo_wep")) _rest=_rest.ammo_wep;else break}
                    if(is_struct(_rest)) {
                        var _drop=scrWeaponPickupCreate(x,y,_rest)
                        _drop.ntte_state=_rest.ntte_native_state
                    }
                }
            }
        }
    }
}
function scrNTTEFullCrabbonePhysicalPromptHeld(_actor) {
    for(var _slot=0;_slot<2;++_slot) {
        var _weapon=scrNTTEFullValue(_actor,_slot==0?"wep":"bwep",wep_none),_model=scrNTTEFullWeaponModel(_weapon)
        if(!is_struct(_model) || !scrNTTEFullCrabboneIs(_model)) continue
        var _state=scrNTTEFullValue(_model,"ntte_native_state",undefined)
        if(is_struct(_state) && _state.ammo>=10 && scrNTTEFullCrabbonePartIndex(_model,_state)<0) return true
    }
    return false
}
function scrNTTEFullCrabboneOrdinaryPickup(_pickup) {
    if(!instance_exists(_pickup) || !scrNTTEFullCrabboneIs(_pickup.wep)) return false
    return scrNTTEFullCrabbonePartIndex(_pickup.wep,scrNTTEFullValue(_pickup,"ntte_state",undefined))<0
}

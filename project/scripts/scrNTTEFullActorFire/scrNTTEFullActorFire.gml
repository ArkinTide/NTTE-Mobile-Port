// Native equivalent of NTT player_fire_ext. Player.Create and its complete
// call chain (hitme.Create, scrPlayerAmmoInit, scrExtraWepsInit) only initialize
// instance fields; this deliberately does not call scrPlayerCreate/RaceChange,
// which register the player, alter the selected loadout, and update ammo stats.
function scrNTTEFullActorFire(_actor,_weapon,_angle,_accuracy=undefined,_consume=false,_owner=undefined,_at=undefined) {
    if(!instance_exists(_actor) || !scr_weapon_is_valid(_weapon)) return {reload:0,wkick:0,shots:[],state:undefined}
    var _owner_override=!is_undefined(_owner) && instance_exists(_owner) && _owner!=_actor && instance_is(_owner,Player)
    if(is_undefined(_owner)) _owner=_actor
    if(!instance_exists(_owner)) return {reload:0,wkick:0,shots:[],state:undefined}
    var _mount=is_struct(_at) ? scrNTTEFullValue(_at,"mount",undefined):undefined
    var _source=is_struct(_mount) ? _mount.owner:(_owner_override ? _owner:_actor)
    // telib.player_fire_at's explicit Player creator keeps that player's
    // firing context while position comes from the independent actor anchor.
    // Unowned pets retain the original FireCont/Fish path and default1accuracy.
    if(is_undefined(_accuracy)) _accuracy=_owner_override ? _owner.accuracy:1
    var _position={x:_actor.x,y:_actor.y}
    if(is_struct(_mount)) _position=scrNTTEFullActorMountPosition(_mount)
    var _birth_capture=scrNTTEFullMergedCaptureBegin()
    var _proxy=instance_create(_position.x,_position.y,Player),_shots=[]
    var _default_team=scrNTTEFullValue(_source,"team",team_none)
    var _fire_team=is_struct(_at) ? scrNTTEFullValue(_at,"team_override",_default_team):_default_team
    var _hitid=scrNTTEFullValue(_source,"hitid",scrNTTEFullValue(_actor,"hitid",[sprMutant1Idle,""]))
    var _fire_creator=is_struct(_at) ? scrNTTEFullValue(_at,"creator_override",_owner):_owner
    var _owner_player=instance_is(_source,Player),_leader=scrNTTEFullValue(_actor,"leader",noone)
    with(_proxy) {
        visible=false; persistent=false; can_walk=false; can_spec=false; can_aim=false
        index=scrNTTEFullValue(_source,"index",instance_exists(_leader) ? scrNTTEFullValue(_leader,"index",0):0)
        is_me=false; race=_owner_player ? _source.race:Race.Fish; bskin=-1
        if(_owner_player) {
            ntte_race_ultra=scrNTTEFullValue(_source,"ntte_race_ultra",0)
            ntte_actor_race_ultras=[0,scrNTTEFullRaceUltraValue(_source,1),scrNTTEFullRaceUltraValue(_source,2)]
        }
        team=_fire_team; hitid=_hitid; gunangle=_angle; accuracy=_accuracy
        ntte_red_owner=_source;
        ntte_actor_accuracy=_accuracy
        ntte_actor_angle=_angle
        if(is_struct(_mount)) ntte_actor_mount=_mount
        else if(is_struct(_at)) {
            ntte_actor_fixed_position=_at.position
            ntte_actor_direction_owner=_at.direction_owner
            ntte_actor_direction_rotation=_at.direction_rotation
            if(_at.accuracy_dynamic) ntte_actor_accuracy_owner=_at.direction_owner
        }
        wep=_weapon; bwep=wep_none; curse=scrNTTEFullValue(_actor,"curse",0); bcurse=0
        infammo=_consume ? scrNTTEFullValue(_actor,"infammo",0):1
        // The real creator's unrelated equipped slot never supplies state to
        // this independent physical weapon, nor receives reload/charge changes.
        ntte_state=scrNTTEFullValue(_actor,"ntte_state",undefined)
        if(!is_struct(ntte_state) || ntte_state.weapon!=wep) ntte_state=scrNTTENewState(wep)
        if(_consume && is_array(scrNTTEFullValue(_actor,"ammo",undefined))) ammo=scrNTTEFullArrayCopy(_actor.ammo)
        else if(_consume) { instance_destroy(id,false); throw "ActorFire consume requires an ammo array on its source actor" }
        // Preserve source placement and ownership while letting native firearm
        // setup see the same Player accuracy checks as player_fire_ext.
        scrNTTEFullMergedRuntimeActorBegin(id,_actor,_fire_creator,_at,_angle,_accuracy)
        scrFire(_weapon,_consume,true)
    }
    var _result={reload:_proxy.reload,wkick:_proxy.wkick,wepangle:_proxy.wepangle,hspeed:_proxy.hspeed,vspeed:_proxy.vspeed,shots:_shots,state:_proxy.ntte_state,weapon:_proxy.wep,
        context:{race:_proxy.race,index:_proxy.index,accuracy:_proxy.accuracy,ultra:scrNTTEFullValue(_proxy,"ntte_race_ultra",0),
            ultras:scrNTTEFullValue(_proxy,"ntte_actor_race_ultras",[0,0,0])}}
    // Native with(all) visits newborns newest first; retain its exact shot order.
    // The captured array itself stays ascending for Finalize's instance_find order.
    var _births=scrNTTEFullMergedCaptureEnd(_birth_capture)
    for(var _birth_i=array_length(_births)-1;_birth_i>=0;--_birth_i)
    with(_births[_birth_i]) if(id>_proxy && variable_instance_exists(id,"creator") && creator==_proxy) {
        creator=_fire_creator
        if(variable_instance_exists(id,"team")) team=_fire_team
        if(variable_instance_exists(id,"hitid")) hitid=_hitid
        ntte_actor_accuracy=_accuracy
        ntte_actor_angle=_angle
        ntte_actor_anchor=_actor
        if(is_struct(_mount)) ntte_actor_mount=_mount
        else if(is_struct(_at)) {
            ntte_actor_fixed_position=_at.position
            ntte_actor_direction_owner=_at.direction_owner
            ntte_actor_direction_rotation=_at.direction_rotation
            if(_at.accuracy_dynamic) ntte_actor_accuracy_owner=_at.direction_owner
        }
        array_push(_shots,id)
    }
    _proxy.ntte_merged_actor_births=_births
    _result.shots=_shots
    if(_consume) {
        _actor.ammo=scrNTTEFullArrayCopy(_proxy.ammo)
        _actor.ntte_state=_proxy.ntte_state
    }
    scrNTTEFullMergedRuntimeActorFinalize(_proxy,_result)
    instance_destroy(_proxy,false)
    return _result
}
// telib.player_fire_at({x,y},{rotation},accuracy,weapon,...,owner,true):
// position is a captured value, but delayed direction follows the creator's
// live gunangle. The chest itself may close before those delayed shots finish.
function scrNTTEFullActorFireAt(_actor,_weapon,_rotation=0,_accuracy=undefined,_owner=undefined) {
    if(is_undefined(_owner)) _owner=_actor
    if(!instance_exists(_actor) || !instance_exists(_owner)) return {reload:0,wkick:0,shots:[],state:undefined}
    var _dynamic_accuracy=is_undefined(_accuracy)
    if(_dynamic_accuracy) _accuracy=scrNTTEFullValue(_owner,"accuracy",1)
    var _angle=scrNTTEFullValue(_owner,"gunangle",0)+_rotation
    return scrNTTEFullActorFire(_actor,_weapon,_angle,_accuracy,false,_owner,
        {position:{x:_actor.x,y:_actor.y},direction_owner:_owner,direction_rotation:_rotation,accuracy_dynamic:_dynamic_accuracy})
}
// Full telib.player_fire_at mount used by temerge front replacements. The
// offset's direction is resolved BEFORE the separate firing-angle rotation.
// Each emission copies its mount fields, so one stock bullet's mount cannot
// be mutated by a later emission that reuses the caller's fireAt structure.
function scrNTTEFullActorMountNew(_actor,_fire_at,_fallback_owner=undefined) {
    if(is_undefined(_fallback_owner) || !instance_exists(_fallback_owner)) _fallback_owner=_actor
    var _creator=scrNTTEFullValue(_fire_at,"creator",_fallback_owner)
    if(is_undefined(_creator)) _creator=_fallback_owner
    var _base=instance_exists(_creator) ? _creator:_fallback_owner
    return {
        owner:_base,
        fallback_x:scrNTTEFullValue(_base,"x",_actor.x),fallback_y:scrNTTEFullValue(_base,"y",_actor.y),
        fallback_direction:scrNTTEFullValue(_base,"gunangle",0),fallback_accuracy:scrNTTEFullValue(_base,"accuracy",1),
        x:scrNTTEFullValue(_fire_at,"x",undefined),y:scrNTTEFullValue(_fire_at,"y",undefined),
        position_distance:scrNTTEFullValue(_fire_at,"position_distance",0),
        position_direction:scrNTTEFullValue(_fire_at,"position_direction",undefined),
        position_rotation:scrNTTEFullValue(_fire_at,"position_rotation",0),
        direction:scrNTTEFullValue(_fire_at,"direction",undefined),
        direction_rotation:scrNTTEFullValue(_fire_at,"direction_rotation",0),
        accuracy:scrNTTEFullValue(_fire_at,"accuracy",undefined)
    }
}
function scrNTTEFullActorMountDirection(_mount) {
    if(variable_struct_exists(_mount,"ntte_merged_parent_mount")) return scrNTTEFullMergedRuntimeActorMountDirection(_mount);
    if(!is_undefined(_mount.direction)) return _mount.direction
    return scrNTTEFullValue(_mount.owner,"gunangle",_mount.fallback_direction)
}
function scrNTTEFullActorMountPosition(_mount) {
    if(variable_struct_exists(_mount,"ntte_merged_parent_mount")) return scrNTTEFullMergedRuntimeActorMountPosition(_mount);
    var _x=is_undefined(_mount.x) ? scrNTTEFullValue(_mount.owner,"x",_mount.fallback_x):_mount.x
    var _y=is_undefined(_mount.y) ? scrNTTEFullValue(_mount.owner,"y",_mount.fallback_y):_mount.y
    var _position_angle=is_undefined(_mount.position_direction) ? scrNTTEFullActorMountDirection(_mount):_mount.position_direction
    _position_angle+=_mount.position_rotation
    return {x:_x+lengthdir_x(_mount.position_distance,_position_angle),y:_y+lengthdir_y(_mount.position_distance,_position_angle)}
}
function scrNTTEFullActorMountAccuracy(_mount) {
    if(variable_struct_exists(_mount,"ntte_merged_parent_mount")) return scrNTTEFullMergedRuntimeActorMountAccuracy(_mount);
    return is_undefined(_mount.accuracy) ? scrNTTEFullValue(_mount.owner,"accuracy",_mount.fallback_accuracy):_mount.accuracy
}
function scrNTTEFullActorFireMount(_actor,_fire_at,_fallback_owner=undefined,_consume=false) {
    if(!instance_exists(_actor) || !is_struct(_fire_at)) return {reload:0,wkick:0,shots:[],state:undefined}
    var _mount=scrNTTEFullActorMountNew(_actor,_fire_at,_fallback_owner)
    var _weapon=scrNTTEFullValue(_fire_at,"wep",scrNTTEFullValue(_mount.owner,"wep",wep_none))
    if(is_undefined(_weapon)) _weapon=scrNTTEFullValue(_mount.owner,"wep",wep_none)
    var _ref=is_array(_weapon)
    if(_ref) _weapon=_weapon[0]
    var _at={mount:_mount,
        team_override:scrNTTEFullValue(_fire_at,"team",undefined),
        creator_override:scrNTTEFullValue(_fire_at,"creator",_mount.owner)}
    _at.ntte_trident_transfer_refs=scrNTTEFullValue(_fire_at,"ntte_trident_transfer_refs",[])
    _at.ntte_crabbone_transfer_refs=scrNTTEFullCrabboneTransferRefs(_fire_at)
    _at.ntte_trident_transfer_refs=scrNTTEFullValue(_fire_at,"ntte_trident_transfer_refs",[])
    if(is_undefined(_at.team_override)) _at.team_override=scrNTTEFullValue(_mount.owner,"team",team_none)
    if(is_undefined(_at.creator_override)) _at.creator_override=_mount.owner
    var _result=scrNTTEFullActorFire(_actor,_weapon,scrNTTEFullActorMountDirection(_mount)+_mount.direction_rotation,
        scrNTTEFullActorMountAccuracy(_mount),_consume,_mount.owner,_at)
    scrNTTEFullTridentMergedRefCapture(_fire_at)
    if(_ref && variable_struct_exists(_result,"weapon") && _fire_at.wep[0]!=_result.weapon) _fire_at.wep[@ 0]=_result.weapon
    return _result
}
function scrNTTEFullActorDamageMetadata(_inst,_source) {
    if(!instance_exists(_inst) || !instance_exists(_source)) return;
    if(instance_is(_source,enemy) || instance_is(_source,NTTEFullPet) || scrNTTEFullValue(_source,"ntte_monster_projectile",false)) _inst.ntte_monster_projectile=true;
    var _mount=scrNTTEFullValue(_source,"ntte_actor_mount",undefined)
    if(is_struct(_mount)) _inst.ntte_actor_mount=_mount
    var _accuracy=scrNTTEFullValue(_source,"ntte_actor_accuracy",undefined)
    if(is_numeric(_accuracy)) _inst.ntte_actor_accuracy=_accuracy
    var _accuracy_owner=scrNTTEFullValue(_source,"ntte_actor_accuracy_owner",noone)
    if(instance_exists(_accuracy_owner)) _inst.ntte_actor_accuracy_owner=_accuracy_owner
    var _angle=scrNTTEFullValue(_source,"ntte_actor_angle",undefined)
    if(is_numeric(_angle)) _inst.ntte_actor_angle=_angle
    var _anchor=scrNTTEFullValue(_source,"ntte_actor_anchor",undefined)
    if(!is_undefined(_anchor)) _inst.ntte_actor_anchor=_anchor
    var _fixed=scrNTTEFullValue(_source,"ntte_actor_fixed_position",undefined)
    if(is_struct(_fixed)) {
        _inst.ntte_actor_fixed_position=_fixed
        _inst.ntte_actor_direction_owner=scrNTTEFullValue(_source,"ntte_actor_direction_owner",noone)
        _inst.ntte_actor_direction_rotation=scrNTTEFullValue(_source,"ntte_actor_direction_rotation",0)
    }
    scrNTTEFullWeaponMimicProjectileSetup(_inst,_source)
}
// A delayed shot's firing location may follow a pet while the projectile's
// creator remains its real player, as in Guardian YV's source player_fire_at.
function scrNTTEFullActorFiringAnchor(_inst) {
    var _mount=scrNTTEFullValue(_inst,"ntte_actor_mount",undefined)
    if(is_struct(_mount)) return scrNTTEFullActorMountPosition(_mount)
    var _fixed=scrNTTEFullValue(_inst,"ntte_actor_fixed_position",undefined)
    if(is_struct(_fixed)) return _fixed
    var _anchor=scrNTTEFullValue(_inst,"ntte_actor_anchor",undefined)
    if(!is_undefined(_anchor)) return instance_exists(_anchor) ? _anchor:noone
    return scrNTTEFullValue(_inst,"creator",noone)
}
function scrNTTEFullActorFiringAnchorExists(_anchor) {
    if(is_struct(_anchor)) return is_numeric(scrNTTEFullValue(_anchor,"x",undefined)) && is_numeric(scrNTTEFullValue(_anchor,"y",undefined))
    return instance_exists(_anchor)
}
function scrNTTEFullActorAccuracy(_inst,_fallback) {
    var _mount=scrNTTEFullValue(_inst,"ntte_actor_mount",undefined)
    if(is_struct(_mount)) return scrNTTEFullActorMountAccuracy(_mount)
    var _owner=scrNTTEFullValue(_inst,"ntte_actor_accuracy_owner",noone)
    if(instance_exists(_owner)) return scrNTTEFullValue(_owner,"accuracy",_fallback)
    return scrNTTEFullValue(_inst,"ntte_actor_accuracy",_fallback)
}
function scrNTTEFullActorFiringAngle(_inst) {
    var _mount=scrNTTEFullValue(_inst,"ntte_actor_mount",undefined)
    if(is_struct(_mount)) return scrNTTEFullActorMountDirection(_mount)+_mount.direction_rotation
    var _direction_owner=scrNTTEFullValue(_inst,"ntte_actor_direction_owner",noone)
    if(instance_exists(_direction_owner)) return scrNTTEFullValue(_direction_owner,"gunangle",0)+scrNTTEFullValue(_inst,"ntte_actor_direction_rotation",0)
    var _angle=scrNTTEFullValue(_inst,"ntte_actor_angle",undefined)
    if(is_numeric(_angle)) return _angle
    _angle=scrNTTEFullValue(_inst,"gunangle",undefined)
    if(is_numeric(_angle)) return _angle
    var _creator=scrNTTEFullValue(_inst,"creator",noone)
    return scrNTTEFullValue(_creator,"gunangle",scrNTTEFullValue(_inst,"direction",0))
}
function scrNTTEFullActorMountTests() {
    var _p=instance_find(Player,0),_before=scrNTTEFullInstances(all)
    var _old={x:_p.x,y:_p.y,angle:_p.gunangle,accuracy:_p.accuracy,race:_p.race,wkick:_p.wkick,
        wep:_p.wep,bwep:_p.bwep,state:_p.ntte_state,bstate:_p.bntte_state,ammo:json_stringify(_p.ammo)}
    _p.x=8000; _p.y=8000; _p.gunangle=20; _p.accuracy=0
    var _at={x:undefined,y:undefined,position_distance:12,position_direction:undefined,position_rotation:30,
        direction:undefined,direction_rotation:70,accuracy:0,wep:wep_crossbow,team:team_enemy,creator:_p}
    var _shot=scrNTTEFullActorFireMount(_p,_at),_bolt=noone
    for(var _i=0;_i<array_length(_shot.shots);++_i) if(instance_exists(_shot.shots[_i]) && instance_is(_shot.shots[_i],Bolt)) _bolt=_shot.shots[_i]
    assert(instance_exists(_bolt) && _bolt.creator==_p && _bolt.team==team_enemy
        && abs(_bolt.xstart-(8000+lengthdir_x(12,50)))<0.001 && abs(_bolt.ystart-(8000+lengthdir_y(12,50)))<0.001
        && abs(angle_difference(_bolt.direction,90))<0.001,
        "ActorFireMount immediate native shot did not apply independent center/barrel/aim/team/creator")
    _p.x+=13; _p.y+=23; _p.gunangle=70; _p.accuracy=1
    _at.x=-100; _at.position_rotation=0
    var _anchor=scrNTTEFullActorFiringAnchor(_bolt)
    assert(abs(_anchor.x-(_p.x+lengthdir_x(12,100)))<0.001 && abs(_anchor.y-(_p.y+lengthdir_y(12,100)))<0.001
        && abs(angle_difference(scrNTTEFullActorFiringAngle(_bolt),140))<0.001 && scrNTTEFullActorAccuracy(_bolt,-1)==0,
        "ActorFireMount failed live owner movement/turn, explicit zero accuracy, or independent emission snapshot")
    _at={position_distance:9,position_rotation:-15,direction_rotation:25,wep:wep_assault_rifle,creator:_p,team:team_enemy}
    _shot=scrNTTEFullActorFireMount(_p,_at)
    var _burst=noone
    for(var _i=0;_i<array_length(_shot.shots);++_i) if(instance_exists(_shot.shots[_i]) && instance_is(_shot.shots[_i],Burst)) _burst=_shot.shots[_i]
    assert(instance_exists(_burst),"ActorFireMount did not create native deferred Burst")
    _p.x+=31; _p.y-=17; _p.gunangle=160; _p.accuracy=0.3
    var _child_before=scrNTTEFullInstances(Bullet1)
    with(_burst) event_perform(ev_alarm,0)
    var _children=scrNTTEFullInstances(Bullet1),_child=noone
    for(var _i=0;_i<array_length(_children);++_i) if(array_get_index(_child_before,_children[_i])<0 && _children[_i].creator==_p) _child=_children[_i]
    assert(instance_exists(_child) && _child.team==team_enemy && abs(_burst.x-(_p.x+lengthdir_x(9,145)))<0.001
        && abs(_burst.y-(_p.y+lengthdir_y(9,145)))<0.001 && abs(angle_difference(_child.direction,185))<=0.601
        && scrNTTEFullActorAccuracy(_child,-1)==0.3 && is_struct(_child.ntte_actor_mount),
        "ActorFireMount real Burst lost live barrel rotation, inherited accuracy, source team or child mount")
    _at={x:8222,y:8333,position_distance:31,position_direction:270,position_rotation:15,
        direction:20,direction_rotation:90,accuracy:0,wep:wep_laser_cannon,creator:_p}
    _shot=scrNTTEFullActorFireMount(_p,_at)
    var _cannon=noone
    for(var _i=0;_i<array_length(_shot.shots);++_i) if(instance_exists(_shot.shots[_i]) && instance_is(_shot.shots[_i],LaserCannon)) _cannon=_shot.shots[_i]
    assert(instance_exists(_cannon),"ActorFireMount did not create native deferred LaserCannon")
    _p.x+=300; _p.y+=300; _p.gunangle=250
    with(_cannon) event_perform(ev_step,0)
    var _mx=8222+lengthdir_x(31,285),_my=8333+lengthdir_y(31,285)
    assert(abs(_cannon.x-(_mx+lengthdir_x(16,110)))<0.001 && abs(_cannon.y-(_my+lengthdir_y(16,110)))<0.001,
        "ActorFireMount Laser charge lost captured center, explicit position direction or independent firing rotation")
    var _laser_before=scrNTTEFullInstances(Laser)
    with(_cannon) event_perform(ev_alarm,0)
    var _lasers=scrNTTEFullInstances(Laser),_beam=noone
    for(var _i=0;_i<array_length(_lasers);++_i) if(array_get_index(_laser_before,_lasers[_i])<0 && _lasers[_i].creator==_p) _beam=_lasers[_i]
    assert(instance_exists(_beam) && abs(angle_difference(_beam.direction,110))<0.001
        && abs(_beam.xstart-(_mx+lengthdir_x(16,110)))<0.001 && abs(_beam.ystart-(_my+lengthdir_y(16,110)))<0.001,
        "ActorFireMount native deferred Laser lost the complete fixed mount")
    _at={x:8555,position_distance:7,position_direction:0,direction:0,wep:wep_crossbow,creator:noone,team:team_enemy}
    _shot=scrNTTEFullActorFireMount(_p,_at,_p)
    _bolt=noone
    for(var _i=0;_i<array_length(_shot.shots);++_i) if(instance_exists(_shot.shots[_i]) && instance_is(_shot.shots[_i],Bolt)) _bolt=_shot.shots[_i]
    assert(instance_exists(_bolt) && _bolt.creator==noone && _bolt.team==team_enemy
        && abs(_bolt.xstart-8562)<0.001 && abs(_bolt.ystart-_p.y)<0.001,
        "ActorFireMount lost explicit noone ownership or mixed fixed-X/live-Y center")
    assert(_p.wep==_old.wep && _p.bwep==_old.bwep && _p.ntte_state==_old.state && _p.bntte_state==_old.bstate
        && json_stringify(_p.ammo)==_old.ammo,"ActorFireMount mutated real inventory or ammo")
    var _after=scrNTTEFullInstances(all)
    for(var _i=0;_i<array_length(_after);++_i) if(array_get_index(_before,_after[_i])<0 && instance_exists(_after[_i])) instance_destroy(_after[_i],false)
    _p.x=_old.x; _p.y=_old.y; _p.gunangle=_old.angle; _p.accuracy=_old.accuracy; _p.race=_old.race; _p.wkick=_old.wkick
    scrNTTESmokeLog("SYSTEMS ACTOR MOUNT: immediate native shots, live/fixed/partial centers, independent barrel/aim rotations, Burst/Laser deferred inheritance, explicit noone/team and inventory isolation OK")
}
function scrNTTEFullActorFireTests() {
    var _p=instance_find(Player,0),_count=instance_number(Player),_pinst=scr_playerinstance_find(_p.index)
    var _snapshot={wep:_p.wep,bwep:_p.bwep,ammo:json_stringify(_p.ammo),state:_p.ntte_state,bstate:_p.bntte_state,race:_p.race,index:_p.index,selected:_pinst.race}
    var _actor=instance_create(_p.x+32,_p.y,NTTEFullPet)
    _actor.team=team_player; _actor.hitid=[sprMutant1Idle,"ACTOR FIRE TEST"]
    var _shot=scrNTTEFullActorFire(_actor,wep_revolver,0,1,false)
    assert(array_length(_shot.shots)>0 && _shot.reload==scr_weapon_get_load(wep_revolver),"ActorFire did not execute real native Revolver firing/reload")
    var _bullet=noone
    for(var _i=0;_i<array_length(_shot.shots);++_i) if(instance_exists(_shot.shots[_i]) && instance_is(_shot.shots[_i],Bullet1)) _bullet=_shot.shots[_i]
    assert(instance_exists(_bullet) && _bullet.creator==_actor && _bullet.team==team_player && _bullet.hitid[1]=="ACTOR FIRE TEST",
        "ActorFire failed real source creator/team/hitid ownership")
    assert(instance_number(Player)==_count && _p.wep==_snapshot.wep && _p.bwep==_snapshot.bwep && json_stringify(_p.ammo)==_snapshot.ammo
        && _p.ntte_state==_snapshot.state && _p.bntte_state==_snapshot.bstate && _p.race==_snapshot.race && _pinst.race==_snapshot.selected,
        "ActorFire polluted a real player's weapons/ammo/state/race/selected loadout")
    for(var _i=0;_i<array_length(_shot.shots);++_i) if(instance_exists(_shot.shots[_i])) instance_destroy(_shot.shots[_i],false)
    var _players=scrNTTEFullInstances(Player)
    for(var _i=0;_i<array_length(_players);++_i) with(_players[_i]) instance_change(NTTEFullActorTestShell,false)
    assert(instance_number(Player)==0,"ActorFire zero-player fixture retained a player")
    _shot=scrNTTEFullActorFire(_actor,wep_crossbow,30,0.5,false)
    assert(instance_number(Player)==0 && array_length(_shot.shots)>0,"ActorFire requires a pre-existing real player or leaked its synchronous firing context")
    for(var _i=0;_i<array_length(_shot.shots);++_i) if(instance_exists(_shot.shots[_i])) instance_destroy(_shot.shots[_i],false)
    for(var _i=0;_i<array_length(_players);++_i) with(_players[_i]) instance_change(Player,false)
    // A real native deferred Burst must survive the temporary firing context,
    // retain actor ownership and the requested accuracy, and stop safely when
    // its actual source actor is destroyed. No source gunangle field required.
    _shot=scrNTTEFullActorFire(_actor,wep_assault_rifle,37,0,false)
    var _burst=noone
    for(var _i=0;_i<array_length(_shot.shots);++_i) if(instance_exists(_shot.shots[_i]) && instance_is(_shot.shots[_i],Burst)) _burst=_shot.shots[_i]
    assert(instance_exists(_burst) && _burst.creator==_actor && _burst.ntte_actor_accuracy==0,"ActorFire lost the real delayed Burst/source/accuracy")
    var _bullet_before=scrNTTEFullInstances(Bullet1)
    _actor.x+=11
    with(_burst) event_perform(ev_alarm,0)
    var _bullets=scrNTTEFullInstances(Bullet1),_deferred=noone
    for(var _i=0;_i<array_length(_bullets);++_i) if(array_get_index(_bullet_before,_bullets[_i])<0 && _bullets[_i].creator==_actor) _deferred=_bullets[_i]
    assert(instance_exists(_deferred) && _deferred.team==_actor.team && _deferred.hitid[1]=="ACTOR FIRE TEST"
        && abs(angle_difference(_deferred.direction,37))<0.001 && _deferred.ntte_actor_accuracy==0,
        "ActorFire delayed child lost owner/team/hitid/captured angle or zero-spread accuracy")
    assert(abs(_burst.x-_actor.x)<0.001,"ActorFire delayed Burst did not follow the real source position")
    for(var _i=0;_i<array_length(_shot.shots);++_i) if(instance_exists(_shot.shots[_i]) && _shot.shots[_i]!=_burst) instance_destroy(_shot.shots[_i],false)
    if(instance_exists(_deferred)) instance_destroy(_deferred,false)
    _actor.ammo=array_create(Ammo.NUM_AMMO_TYPES,100); _actor.infammo=0
    var _consumed=scrNTTEFullActorFire(_actor,wep_revolver,0,0,true)
    assert(_actor.ammo[Ammo.Bullets]==100-scr_weapon_get_cost(wep_revolver) && json_stringify(_p.ammo)==_snapshot.ammo,
        "ActorFire explicit consumption failed actor ammo isolation")
    for(var _i=0;_i<array_length(_consumed.shots);++_i) if(instance_exists(_consumed.shots[_i])) instance_destroy(_consumed.shots[_i],false)
    // Guardian YV owns its shots through the real leader while the emission
    // point follows the guardian, including native delayed burst rounds.
    var _owned=scrNTTEFullActorFire(_actor,wep_assault_rifle,71,0,false,_p),_owned_burst=noone
    for(var _i=0;_i<array_length(_owned.shots);++_i) if(instance_exists(_owned.shots[_i]) && instance_is(_owned.shots[_i],Burst)) _owned_burst=_owned.shots[_i]
    assert(instance_exists(_owned_burst) && _owned_burst.creator==_p && scrNTTEFullActorFiringAnchor(_owned_burst)==_actor,
        "ActorFire separate source anchor and player ownership were not retained")
    _actor.x+=29
    var _prior=scrNTTEFullInstances(Bullet1)
    with(_owned_burst) event_perform(ev_alarm,0)
    var _current=scrNTTEFullInstances(Bullet1),_owned_child=noone
    for(var _i=0;_i<array_length(_current);++_i) if(array_get_index(_prior,_current[_i])<0 && _current[_i].creator==_p) _owned_child=_current[_i]
    assert(instance_exists(_owned_child) && abs(_owned_burst.x-_actor.x)<0.001 && abs(angle_difference(_owned_child.direction,71))<0.001,
        "ActorFire player-owned delayed shot failed to follow its actual firing actor")
    for(var _i=0;_i<array_length(_owned.shots);++_i) if(instance_exists(_owned.shots[_i]) && _owned.shots[_i]!=_owned_burst) instance_destroy(_owned.shots[_i],false)
    if(instance_exists(_owned_child)) instance_destroy(_owned_child,false)
    // telib.player_fire_at's explicit Player creator retains its actual race,
    // controller index, inherited accuracy and Ultra selection. An unrelated
    // equipped state must remain untouched when this actor fires another item.
    var _owner_before={race:_p.race,index:_p.index,accuracy:_p.accuracy,ultra:scrNTTEFullValue(_p,"ntte_race_ultra",0),
        state:json_stringify(_p.ntte_state),backstate:json_stringify(_p.bntte_state)}
    _p.race=NTTEFullRace.Beetle; _p.ntte_race_ultra=2; _p.accuracy=0
    _actor.index=_p.index+1
    var _override=scrNTTEFullActorFire(_actor,wep_crossbow,123,undefined,false,_p),_override_bolt=noone
    for(var _i=0;_i<array_length(_override.shots);++_i) if(instance_exists(_override.shots[_i]) && instance_is(_override.shots[_i],Bolt)) _override_bolt=_override.shots[_i]
    assert(_override.context.race==NTTEFullRace.Beetle && _override.context.index==_p.index && _override.context.ultra==2,
        "ActorFire explicit player creator lost real race/controller/Ultra context")
    assert(instance_exists(_override_bolt) && _override_bolt.creator==_p && _override_bolt.team==_p.team
        && _override_bolt.ntte_actor_accuracy==0 && abs(angle_difference(_override_bolt.direction,123))<0.001,
        "ActorFire explicit owner failed the actual zero-spread Crossbow shot using inherited player accuracy")
    assert(_p.wep==_snapshot.wep && _p.bwep==_snapshot.bwep && json_stringify(_p.ammo)==_snapshot.ammo
        && json_stringify(_p.ntte_state)==_owner_before.state && json_stringify(_p.bntte_state)==_owner_before.backstate,
        "ActorFire explicit owner mutated an unrelated real player's physical weapon/reload/charge/ammo state")
    for(var _i=0;_i<array_length(_override.shots);++_i) if(instance_exists(_override.shots[_i])) instance_destroy(_override.shots[_i],false)
    var _default=scrNTTEFullActorFire(_actor,wep_revolver,0)
    assert(_default.context.race==Race.Fish && _default.context.index==_actor.index && _default.context.accuracy==1 && _default.context.ultra==0,
        "ActorFire default pet path incorrectly inherited its leader's additional race/Ultra/accuracy")
    for(var _i=0;_i<array_length(_default.shots);++_i) if(instance_exists(_default.shots[_i])) instance_destroy(_default.shots[_i],false)
    // A real chest closes before its deferred native controllers fire. Its
    // captured source position survives that destruction, while each delayed
    // round still reads the living creator's current aim plus its rotation.
    var _fixed_before=scrNTTEFullInstances(all),_fixed_owner={x:_p.x,y:_p.y,angle:_p.gunangle}
    var _chest=instance_create(_p.x+200,_p.y+100,NTTEFullBeetleChestOpen)
    var _fixed_x=_chest.x,_fixed_y=_chest.y
    _p.gunangle=11
    var _fixedshot=scrNTTEFullActorFireAt(_chest,wep_assault_rifle,120,undefined,_p),_fixedburst=noone
    var _fixedexplicit=scrNTTEFullActorFireAt(_chest,wep_assault_rifle,120,0,_p),_explicitburst=noone
    var _fixedlaser=scrNTTEFullActorFireAt(_chest,wep_laser_cannon,240,undefined,_p),_cannon=noone
    for(var _i=0;_i<array_length(_fixedshot.shots);++_i) if(instance_exists(_fixedshot.shots[_i]) && instance_is(_fixedshot.shots[_i],Burst)) _fixedburst=_fixedshot.shots[_i]
    for(var _i=0;_i<array_length(_fixedexplicit.shots);++_i) if(instance_exists(_fixedexplicit.shots[_i]) && instance_is(_fixedexplicit.shots[_i],Burst)) _explicitburst=_fixedexplicit.shots[_i]
    for(var _i=0;_i<array_length(_fixedlaser.shots);++_i) if(instance_exists(_fixedlaser.shots[_i]) && instance_is(_fixedlaser.shots[_i],LaserCannon)) _cannon=_fixedlaser.shots[_i]
    assert(instance_exists(_fixedburst) && instance_exists(_explicitburst) && instance_exists(_cannon),"ActorFireAt did not create actual native delayed Burst/LaserCannon controllers")
    with(_chest) { ntte_beetle_stored=true; ntte_beetle_closing=true; instance_destroy() }
    assert(!instance_exists(_chest),"ActorFireAt chest fixture did not actually close/destroy its source")
    _p.x+=75; _p.y-=40; _p.gunangle=49
    var _fixed_bullets=scrNTTEFullInstances(Bullet1)
    with(_fixedburst) event_perform(ev_alarm,0)
    var _after_fixed_bullets=scrNTTEFullInstances(Bullet1),_fixedchild=noone
    for(var _i=0;_i<array_length(_after_fixed_bullets);++_i) if(array_get_index(_fixed_bullets,_after_fixed_bullets[_i])<0 && _after_fixed_bullets[_i].creator==_p) _fixedchild=_after_fixed_bullets[_i]
    assert(instance_exists(_fixedburst) && instance_exists(_fixedchild) && abs(_fixedburst.x-_fixed_x)<0.001 && abs(_fixedburst.y-_fixed_y)<0.001
        && abs(angle_difference(_fixedchild.direction,169))<0.001 && _fixedchild.creator==_p && _fixedchild.ntte_actor_accuracy==0,
        "ActorFireAt delayed Burst stopped on chest close, followed player movement, or lost dynamic player aim/rotation")
    var _child_anchor=scrNTTEFullActorFiringAnchor(_fixedchild)
    assert(is_struct(_child_anchor) && abs(_child_anchor.x-_fixed_x)<0.001 && abs(_child_anchor.y-_fixed_y)<0.001,
        "ActorFireAt delayed child lost its inherited fixed-position firing context")
    _p.accuracy=1/3
    var _accuracy_bullets=scrNTTEFullInstances(Bullet1)
    with(_fixedburst) event_perform(ev_alarm,0)
    var _accuracy_after=scrNTTEFullInstances(Bullet1),_accuracy_child=noone
    for(var _i=0;_i<array_length(_accuracy_after);++_i) if(array_get_index(_accuracy_bullets,_accuracy_after[_i])<0 && _accuracy_after[_i].creator==_p) _accuracy_child=_accuracy_after[_i]
    assert(instance_exists(_accuracy_child) && scrNTTEFullActorAccuracy(_accuracy_child,-1)==1/3
        && abs(angle_difference(_accuracy_child.direction,169))<=2/3+0.001,
        "ActorFireAt undefined accuracy did not follow the player's live accuracy for actual later Burst rounds")
    var _explicit_before=scrNTTEFullInstances(Bullet1)
    with(_explicitburst) event_perform(ev_alarm,0)
    var _explicit_after=scrNTTEFullInstances(Bullet1),_explicit_child=noone
    for(var _i=0;_i<array_length(_explicit_after);++_i) if(array_get_index(_explicit_before,_explicit_after[_i])<0 && _explicit_after[_i].creator==_p) _explicit_child=_explicit_after[_i]
    assert(instance_exists(_explicit_child) && scrNTTEFullActorAccuracy(_explicit_child,-1)==0 && abs(angle_difference(_explicit_child.direction,169))<0.001,
        "ActorFireAt explicit zero accuracy incorrectly inherited a later change in player accuracy")
    _p.accuracy=0
    with(_cannon) event_perform(ev_step,0)
    assert(abs(_cannon.x-(_fixed_x+lengthdir_x(16,289)))<0.001 && abs(_cannon.y-(_fixed_y+lengthdir_y(16,289)))<0.001,
        "ActorFireAt LaserCannon charge did not retain fixed source position and dynamically rotated owner aim after chest close")
    var _laser_before=scrNTTEFullInstances(Laser)
    with(_cannon) event_perform(ev_alarm,0)
    var _laser_after=scrNTTEFullInstances(Laser),_beam=noone
    for(var _i=0;_i<array_length(_laser_after);++_i) if(array_get_index(_laser_before,_laser_after[_i])<0 && _laser_after[_i].creator==_p) _beam=_laser_after[_i]
    assert(instance_exists(_beam) && abs(angle_difference(_beam.direction,289))<0.001
        && abs(_beam.xstart-(_fixed_x+lengthdir_x(16,289)))<0.001 && abs(_beam.ystart-(_fixed_y+lengthdir_y(16,289)))<0.001,
        "ActorFireAt real delayed Laser emitted from a dead/moving chest instead of captured position with current owner aim")
    var _fixed_all=scrNTTEFullInstances(all)
    for(var _i=0;_i<array_length(_fixed_all);++_i) if(array_get_index(_fixed_before,_fixed_all[_i])<0 && instance_exists(_fixed_all[_i])) instance_destroy(_fixed_all[_i],false)
    _p.x=_fixed_owner.x; _p.y=_fixed_owner.y; _p.gunangle=_fixed_owner.angle
    _p.race=_owner_before.race; _p.accuracy=_owner_before.accuracy; _p.ntte_race_ultra=_owner_before.ultra
    instance_destroy(_actor,false)
    with(_burst) event_perform(ev_alarm,0)
    assert(!instance_exists(_burst),"ActorFire delayed Burst did not stop after actual source destruction")
    with(_owned_burst) event_perform(ev_alarm,0)
    assert(!instance_exists(_owned_burst) && instance_exists(_p),"ActorFire player-owned delayed burst survived a destroyed firing anchor")
    scrNTTESmokeLog("SYSTEMS ACTOR FIRE: native shots/isolation, pet live anchors, explicit player race/index/Ultra/accuracy, fixed chest Burst/Laser after source destruction with dynamic owner aim, and actor ammo consumption OK")
}

// A friendly monster's shot stays undisturbed by the player's melee. Player
// grenades intentionally retain their original baseball/deflection behavior.
function scrNTTEFullFriendlyMonsterShot(_slash,_shot) {
    if(!instance_exists(_slash) || !instance_exists(_shot)
        || !instance_is(scrNTTEFullValue(_slash,"creator",noone),Player)
        || scrNTTEFullValue(_slash,"team",team_none)!=scrNTTEFullValue(_shot,"team",team_none)) return false;
    var _owner=scrNTTEFullValue(_shot,"creator",noone);
    return scrNTTEFullValue(_shot,"ntte_monster_projectile",false)
        || instance_is(_owner,enemy) || instance_is(_owner,NTTEFullPet);
}
function scrNTTEFullFriendlyMonsterShotTests() {
    var _fixture=scrNTTEFullVanillaFixtureBegin(),_stop=lockstep_stop;
    lockstep_stop=false;
    try {
        var _p=instance_find(Player,0),_ally=instance_create(157000,157000,Bandit),_slash=noone;
        _ally.team=_p.team;
        with(_p) _slash=scr_projectile_create(157000,157000,Slash,45,0);
        var _types=[EnemyBullet1,Grenade,NTTEFullBubbleBomb];
        for(var _i=0;_i<array_length(_types);++_i) {
            var _shot=noone;
            with(_ally) _shot=scr_projectile_create(157000,157000,_types[_i],180,2);
            var _angle=_shot.direction,_speed=_shot.speed,_team=_shot.team,_before=scrNTTEFullInstances(Deflect);
            assert(_shot.ntte_monster_projectile && scrNTTEFullFriendlyMonsterShot(_slash,_shot),"Friendly monster ownership was lost at native creation");
            if(_i==2) with(_shot) scrNTTEFullBubbleBombGrenadeEvent(_slash,id);
            else with(_shot) with(_slash) event_perform(ev_collision,projectile);
            assert(instance_exists(_shot) && _shot.direction==_angle && _shot.speed==_speed && _shot.team==_team
                && array_length(_before)==instance_number(Deflect),"Player melee altered a friendly monster shot");
            instance_destroy(_shot,false);
        }
        var _own=noone;with(_p) _own=scr_projectile_create(157000,157000,Grenade,180,2);
        assert(!scrNTTEFullFriendlyMonsterShot(_slash,_own),"Friendly monster gate captured the player's own grenade");
        var _expected=point_direction(0,0,_own.hspeed+lengthdir_x(12*timescale,45),_own.vspeed+lengthdir_y(12*timescale,45));
        with(_own) with(_slash) event_perform(ev_collision,projectile);
        assert(_own.speed==12*timescale && abs(angle_difference(_own.direction,_expected))<0.001,"Player grenade lost native melee deflection");
        var _hostile=noone;_ally.team=team_enemy;
        with(_ally) _hostile=scr_projectile_create(157000,157000,EnemyBullet1,180,2);
        assert(!scrNTTEFullFriendlyMonsterShot(_slash,_hostile),"Friendly gate captured a hostile monster shot");
        with(_hostile) with(_slash) event_perform(ev_collision,projectile);
        assert(_hostile.team==_p.team && _hostile.direction==45,"Hostile bullet lost native melee deflection");
        _ally.team=_p.team;var _orphan=noone;
        with(_ally) _orphan=scr_projectile_create(157000,157000,Grenade,180,2);
        instance_destroy(_ally,false);
        assert(scrNTTEFullFriendlyMonsterShot(_slash,_orphan),"Friendly shot lost protection after its owner died");
        scrNTTESmokeLog("FRIENDLY MONSTER SHOT: native enemy Bullet/Grenade/BubbleBomb creation and collision, owner-death identity, own grenade and hostile bullet behavior preserved @"+string(game_get_speed(gamespeed_fps)));
    } finally {scrNTTEFullVanillaFixtureEnd(_fixture);lockstep_stop=_stop;}
}

// BEGIN FOLLOWUP73 DEFERRED ACCURACY TEST
function scrNTTEFullCrystalWaveAccuracyNativeTests() {
    var _state=scrNTTEFullVanillaFixtureBegin(),_players=scrNTTEFullAreaGeneratorSnapshot(Player),
        _back=scrNTTEFullAreaGeneratorSnapshot(BackCont),_p=instance_find(Player,0),_stop=lockstep_stop
    try {
        lockstep_stop=false
        _p.x=62000;_p.y=62000;_p.wep=wep_wave_gun;_p.gunangle=35;_p.accuracy=0
        _p.ntte_state=scrNTTENewState(_p.wep)
        var _ally=scrNTTEFullCrystalPlayerClone(_p),_fire=noone
        with(NTTEFullCrystalFireWeapon) if(creator==_ally) {_fire=id;break}
        assert(instance_exists(_fire) && !variable_instance_exists(_ally,"accuracy"),
            "Real Player CrystalAlly did not reproduce the creator without an accuracy field")
        with(_fire) event_perform(ev_step,ev_step_normal)
        var _native=instance_create(_ally.x,_ally.y,AllyBullet)
        _native.creator=_ally;_native.team=team_player;_native.direction=35
        with(_fire) event_perform(ev_step,ev_step_normal)
        assert(!instance_exists(_native),"Actual CrystalFireWeapon did not replace its native AllyBullet")
        var _wave=noone
        with(WaveBurst) if(creator==_ally) {_wave=id;break}
        assert(instance_exists(_wave) && _wave.creator==_ally && scrNTTEFullActorAccuracy(_wave,-1)==1,
            "Cloned Ally Wave Gun lost its genuine owner or captured accuracy")
        // This is the reported real post-proxy Alarm0 -> User1 -> Bullet2 ->
        // shift/spread chain. Do not grant accuracy to the Ally to hide it.
        var _bullets=instance_number(Bullet2),_ammo=_wave.ammo
        with(_wave) event_perform(ev_alarm,0)
        assert(instance_number(Bullet2)==_bullets+2 && _wave.ammo==_ammo-1
            && !variable_instance_exists(_ally,"accuracy"),
            "Real deferred cloned-Ally WaveBurst failed its two native Bullet2 children")
        with(Bullet2) if(creator==_ally) {
            assert(team==team_player && scrNTTEFullActorAccuracy(id,-1)==1,
                "Deferred cloned-Ally child lost physical team/owner/captured accuracy")
        }

        // Captured zero and live Player accuracy remain distinct on the same
        // native deferred chain. The actor fallback must not override either.
        for(var _mode=0;_mode<2;++_mode) {
            _p.accuracy=0
            var _result=scrNTTEFullActorFireAt(_p,wep_wave_gun,0,_mode==0?0:undefined,_p),_burst=noone
            for(var _i=0;_i<array_length(_result.shots);++_i)
                if(instance_exists(_result.shots[_i]) && instance_is(_result.shots[_i],WaveBurst)) _burst=_result.shots[_i]
            assert(instance_exists(_burst),"Real Player accuracy fixture failed to create WaveBurst")
            _p.accuracy=0.25
            var _before=scrNTTEFullInstances(Bullet2)
            with(_burst) event_perform(ev_alarm,0)
            var _after=scrNTTEFullInstances(Bullet2),_new=0
            for(var _i=0;_i<array_length(_after);++_i) if(array_get_index(_before,_after[_i])<0) {
                var _child=_after[_i],_accuracy=_mode==0?0:0.25
                assert(_child.creator==_p && scrNTTEFullActorAccuracy(_child,-1)==_accuracy,
                    "Deferred Wave child changed explicit-zero or live-player accuracy semantics")
                if(_mode==0) assert(abs(angle_difference(_child.direction,35))<0.001,
                    "Explicit zero accuracy acquired fallback wave shift/spread")
                ++_new
            }
            assert(_new==2,"Deferred Player WaveBurst emitted an incorrect child count")
        }

        // Untagged native hitme creators may have no accuracy, a real numeric
        // accuracy, or disappear before these generic projectile helpers run.
        var _plain=instance_create(63000,63000,Bandit),_shot=noone
        with(_plain) _shot=scr_projectile_create(x,y,Bullet2,0,0)
        assert(!variable_instance_exists(_plain,"accuracy"),"Native Bandit unexpectedly supplies accuracy")
        with(_shot) {scr_projectile_shift(12);scr_projectile_spread(0)}
        assert(abs(angle_difference(_shot.direction,12))<0.001,"Missing accuracy did not default to1")
        _plain.accuracy=0.5
        with(_shot) {direction=0;scr_projectile_shift(12)}
        assert(abs(angle_difference(_shot.direction,6))<0.001,"Native hitme numeric shift accuracy was discarded")
        instance_destroy(_plain,false)
        with(_shot) {direction=0;scr_projectile_shift(12);scr_projectile_spread(0)}
        assert(abs(angle_difference(_shot.direction,12))<0.001,"Missing creator fallback did not remain safe")
        scrNTTESmokeLog("CRYSTAL WAVE ACCURACY actual PlayerClone/CrystalFireWeapon native-shot replacement -> delayed WaveBurst.Alarm0/User1 -> two Bullet2 shifts/spreads without Ally.accuracy; explicit zero/dynamic Player, untagged hitme with/without accuracy, dead creator and teams OK @"+string(30/timescale))
    }
    finally {
        scrNTTEFullAreaGeneratorRestore(_players);scrNTTEFullAreaGeneratorRestore(_back)
        scrNTTEFullVanillaFixtureEnd(_state);lockstep_stop=_stop
    }
}

// Frozen literal preoptimization production functions, 20261024.
// Independent full-room membership/order oracle; never calls candidate capture.
function scrNTTEFullActorBirthCaptureOldFire(_actor,_weapon,_angle,_accuracy=undefined,_consume=false,_owner=undefined,_at=undefined) {
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
    with(all) if(id>_proxy && variable_instance_exists(id,"creator") && creator==_proxy) {
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
    _result.shots=_shots
    if(_consume) {
        _actor.ammo=scrNTTEFullArrayCopy(_proxy.ammo)
        _actor.ntte_state=_proxy.ntte_state
    }
    scrNTTEFullActorBirthCaptureOldFinalize(_proxy,_result)
    instance_destroy(_proxy,false)
    return _result
}

function scrNTTEFullActorBirthCaptureOldFinalize(_proxy,_result) {
    if(!variable_instance_exists(_proxy,"ntte_merged_actor_owner")) return;
    var _owner=_proxy.ntte_merged_actor_owner,_parent=_proxy.ntte_merged_actor_parent,
        _frames=_proxy.ntte_merged_actor_frames,_seen=[]
    var _fired=scrNTTEFullValue(_proxy,"ntte_merged_actor_result",undefined)
    if(is_struct(_fired)) {
        _result.has_shot=_fired.has_shot
        for(var _i=0;_i<array_length(_fired.shots);++_i) {
            var _shot=_fired.shots[_i]
            if(instance_exists(_shot) && scrNTTEFullValue(_shot,"creator",noone)==_owner
                && array_get_index(_result.shots,_shot)<0) array_push(_result.shots,_shot)
        }
    }
    for(var _i=0;_i<array_length(_frames);++_i)
        _seen=scrNTTEFullMergedRuntimeActorRetargetFrame(_frames[_i],_proxy,_owner,_seen)
    // Raw custom charging refreshes an existing controller, so include that
    // exact state even if this particular native call created no new object.
    var _instances=scrNTTEFullInstances(all)
    for(var _i=0;_i<array_length(_instances);++_i) {
        var _inst=_instances[_i]
        if(_inst<=_proxy && _inst.object_index!=NTTEFullRedFireCharge) continue
        var _at=scrNTTEFullValue(_inst,"ntte_merged_runtime_at",undefined)
        if(!is_struct(_at)) continue
        if(_at.creator==_proxy) scrNTTEFullMergedRuntimeActorRetargetAt(_at,_proxy,_owner,_parent)
        else if(_at.creator!=_owner || scrNTTEFullValue(_at.mount,"ntte_merged_parent_mount",undefined)!=_parent) continue
        // Existing ordinary actor metadata is already retargeted by ActorFire.
        // Its complete parent+part mount supersedes the raw temporary anchor.
        _inst.ntte_actor_mount=_at.mount
    }
    _result.merged_frames=_frames
}

// Frozen old ActorFire/Finalize functions are prepended by the preparer.
// Compare real native emissions and existing-controller refresh, rather than
// asserting only that the optimized helper calls its own birth collector.
function scrNTTEFullActorBirthCaptureRows(_result,_actor,_owner) {
    var _rows=[]
    for(var _i=0;_i<array_length(_result.shots);++_i) {
        var _p=_result.shots[_i]
        assert(instance_exists(_p),"Actor capture returned a dead object")
        var _at=scrNTTEFullValue(_p,"ntte_merged_runtime_at",undefined),_row=[]
        for(var _f=0;_f<16;++_f) {
            var _name=["object_index","x","y","xstart","ystart","direction","speed","friction","gravity",
                "sprite_index","image_index","team","damage","accuracy","ntte_actor_angle","hitid"][_f]
            array_push(_row,scrNTTEFullValue(_p,_name,undefined))
        }
        array_push(_row,typeof(_p));array_push(_row,scrNTTEFullValue(_p,"creator",noone)==_owner)
        array_push(_row,is_struct(_at)?_at.creator==_owner:undefined)
        array_push(_row,is_struct(_at)?_at.mount.owner==_owner:undefined)
        array_push(_row,array_length(scrNTTEFullValue(_p,"temerge_vars_list",[])))
        array_push(_rows,_row)
    }
    var _frames=scrNTTEFullValue(_result,"merged_frames",[])
    for(var _i=0;_i<array_length(_frames);++_i) {
        var _frame=_frames[_i]
        assert(_frame.actor==_owner && _frame.owner==_owner,
            "Actor birth capture retained a discarded proxy in source firing frame")
    }
    return {shots:_rows,reload:_result.reload,wkick:_result.wkick,
        wepangle:_result.wepangle,hspeed:_result.hspeed,vspeed:_result.vspeed,
        has_shot:scrNTTEFullValue(_result,"has_shot",false),frames:array_length(_frames),
        actor_ammo:_actor.ammo,red_ammo:_actor.ntte_red_ammo,rad:GameCont.rad}
}
function scrNTTEFullActorBirthCaptureCandidatesTest() {
    var _before=scrNTTEFullInstances(all)
    try {
        var _old=instance_create(310000,310000,NTTEFullRedFireCharge),
            _older=instance_create(310000,310000,NTTEFullOutlineDrawDebrisProbe),
            _token=scrNTTEFullMergedCaptureBegin(),
            _proxy=instance_create(310000,310000,NTTEFullOutlineDrawDebrisProbe),
            _a=instance_create(310000,310000,NTTEFullOutlineDrawDebrisProbe),
            _gone=instance_create(310000,310000,NTTEFullOutlineDrawDebrisProbe),
            _new=instance_create(310000,310000,NTTEFullRedFireCharge)
        instance_destroy(_gone,false)
        var _rng=random_get_seed(),_streams=json_stringify(global.rng_state)
        var _births=scrNTTEFullMergedCaptureEnd(_token),_raw_with=[],
            _actual=scrNTTEFullMergedRuntimeActorCandidates(_proxy,_births),_expected=[],_all=scrNTTEFullInstances(all)
        // Keep this diagnostic raw: with(all) does not promise the same order
        // as instance_find(all, ordinal), which the old Finalize used.
        with(all) if(id>_proxy) array_push(_raw_with,id)
        var _tail=[]
        for(var _i=0;_i<array_length(_births);++_i) if(_births[_i]>_proxy) array_push(_tail,_births[_i])
        // Literal previous Finalize membership predicate, independently
        // enumerated with the old helper's original typed-reference order.
        for(var _i=0;_i<array_length(_all);++_i)
            if(_all[_i]>_proxy || _all[_i].object_index==NTTEFullRedFireCharge) array_push(_expected,_all[_i])
        scrNTTESmokeLog("ACTOR RAW ORDER "+json_stringify({births:_tail,oldWith:_raw_with,oldFind:_expected,rate:30/timescale}))
        assert(array_length(_raw_with)==array_length(_tail),"Old ActorFire with(all) newborn membership changed")
        for(var _i=0;_i<array_length(_raw_with);++_i) {
            var _reverse=_tail[array_length(_tail)-1-_i]
            assert(_raw_with[_i]==_reverse && typeof(_raw_with[_i])==typeof(_reverse),
                "ActorFire must preserve native newest-first typed newborn order independently of Finalize")
        }
        assert(array_length(_actual)==array_length(_expected),"Actor candidate capture changed old membership")
        for(var _i=0;_i<array_length(_expected);++_i)
            assert(_actual[_i]==_expected[_i] && typeof(_actual[_i])==typeof(_expected[_i]),
                "Actor candidate capture changed old ordered reference/type at "+string(_i))
        assert(array_get_index(_actual,_old)>=0 && array_get_index(_actual,_new)>=0
            && array_get_index(_actual,_a)>=0 && array_get_index(_actual,_older)<0
            && array_get_index(_actual,_gone)<0 && array_get_index(_actual,_proxy)<0,
            "Actor candidate capture lost old charge refresh/new descendants or included unrelated/dead/proxy")
        assert(random_get_seed()==_rng && json_stringify(global.rng_state)==_streams,
            "Actor candidate collection consumed RNG/native streams")
    }
    finally {scrNTTEFullMergedRuntimeTestCleanup(_before)}
}
function scrNTTEFullActorBirthCaptureNativeTests() {
    var _before=scrNTTEFullInstances(all),_players=scrNTTEFullAreaGeneratorSnapshot(Player),
        _game=scrNTTEFullAreaGeneratorSnapshot(GameCont),_back=scrNTTEFullAreaGeneratorSnapshot(BackCont),
        _uber=scrNTTEFullAreaGeneratorSnapshot(UberCont),_seed=random_get_seed(),
        _streams=scrNTTEFullArrayCopy(global.rng_state),_tick=current_frame,
        _request=variable_global_exists("ntte_full_merged_request")?global.ntte_full_merged_request:undefined
    scrNTTEFullWeaponNativeInit()
    var _models=scrNTTEFullArrayCopy(global.ntte_full_native_weapon_models),_player=instance_find(Player,0),
        _player_ammo=json_stringify(_player.ammo),_specs=[
            [wep_revolver,wep_none,false,false],
            [wep_shotgun,wep_revolver,false,false],
            [wep_super_crossbow,wep_golden_crossbow,false,false],
            [wep_heavy_revolver,wep_assault_rifle,false,false],
            [wep_revolver,wep_ntte_annihilator,true,false],
            [wep_ntte_annihilator,wep_revolver,true,false],
            [wep_shotgun,wep_revolver,false,true]]
    try {
        scrNTTEFullActorBirthCaptureCandidatesTest()
        UberCont.opt_shake=1;UberCont.opt_freeze=1
        for(var _density=0;_density<2;++_density) {
            var _dense=[]
            if(_density==1) repeat(512) array_push(_dense,instance_create(310000,310000,NTTEFullOutlineDrawDebrisProbe))
            for(var _case=0;_case<array_length(_specs);++_case) {
                var _spec=_specs[_case],_expected=undefined,_expected_rng=undefined,
                    _expected_streams=undefined,_expected_probe=undefined,_elapsed=[],_count=instance_number(Player)
                for(var _impl=0;_impl<2;++_impl) {
                    var _local_before=scrNTTEFullInstances(all),_fn=_impl==0?scrNTTEFullActorBirthCaptureOldFire:scrNTTEFullActorFire
                    random_set_seed(3123+_case);global.rng_state=scrNTTEFullArrayCopy(_streams)
                    global.ntte_full_native_weapon_models=scrNTTEFullArrayCopy(_models)
                    GameCont.temerge_effect_vars_map={};GameCont.rad=100
                    var _actor=instance_create(310000,310000,Ally),_owner=_spec[3]?_player:_actor,
                        _weapon=_spec[1]==wep_none?_spec[0]:scrNTTEFullWeaponMerge(_spec[0],_spec[1]),
                        _handle=scrNTTEFullWeaponNative(_weapon)
                    _actor.wep=_handle;_actor.bwep=wep_none;_actor.ntte_state=is_struct(_weapon)
                        ?scrNTTEFullWeaponNativeState(_weapon):scrNTTENewState(_weapon)
                    _actor.team=team_player;_actor.hitid=[sprMutant1Idle,"ACTOR BIRTH CAPTURE"]
                    _actor.visible=true;_actor.speed=0;_actor.gunangle=35;_actor.infammo=0
                    _actor.ntte_red_ammo=5;_actor.ammo=array_create(Ammo.NUM_AMMO_TYPES,100)
                    var _started=get_timer(),_result=_fn(_actor,_handle,35,0.6,false,_owner),
                        _time=get_timer()-_started,_charge_row=undefined
                    if(_spec[2]) {
                        var _charged=_spec[0]==wep_ntte_annihilator?scrNTTEFullWeaponNativeState(_weapon)
                            :scrNTTEFullWeaponNativeState(scrNTTEFullWeaponMergedPart(_weapon)),_controller=noone
                        with(NTTEFullRedFireCharge) if(wep==_charged) _controller=id
                        assert(instance_exists(_controller),"Actor refresh fixture did not create actual charge controller")
                        _actor.x+=7;_actor.y+=11;_actor.gunangle=72
                        _started=get_timer();_result=_fn(_actor,_handle,72,0.4,false,_owner);_time+=get_timer()-_started
                        var _controller_count=0
                        with(NTTEFullRedFireCharge) if(wep==_charged) {_controller_count++;assert(id==_controller,"Actor refresh replaced its physical controller")}
                        assert(_controller_count==1 && _controller.creator==_owner
                            && _controller.ntte_merged_runtime_at.creator==_owner
                            && _controller.ntte_merged_runtime_at.mount.owner==_owner,
                            "Actor refresh lost existing controller owner/stable mount or duplicated it")
                        _charge_row=[_controller.x,_controller.y,_controller.direction,_controller.accuracy,_controller.team,
                            _charged.charge,_charged.chrg,_charged.chrg_num]
                    }
                    array_push(_elapsed,_time)
                    var _actual=json_stringify({emission:scrNTTEFullActorBirthCaptureRows(_result,_actor,_owner),charge:_charge_row}),
                        _rng=random_get_seed(),_native_rng=json_stringify(global.rng_state),_probe=random(1)
                    if(_impl==0) {_expected=_actual;_expected_rng=_rng;_expected_streams=_native_rng;_expected_probe=_probe}
                    else {
                        if(_actual!=_expected) {
                            // Assertions are capped by the Runner. Emit short
                            // records before throwing, retaining strict order.
                            var _old_data=json_parse(_expected),_new_data=json_parse(_actual),
                                _old_rows=_old_data.emission.shots,_new_rows=_new_data.emission.shots
                            scrNTTESmokeLog("ACTOR DIFF HEADER "+json_stringify({caseIndex:_case,density:_density,
                                oldCount:array_length(_old_rows),newCount:array_length(_new_rows),
                                oldProbe:_expected_probe,newProbe:_probe,oldRng:_expected_streams,newRng:_native_rng}))
                            var _length=max(array_length(_old_rows),array_length(_new_rows))
                            for(var _row=0;_row<_length;++_row) {
                                var _old_row=_row<array_length(_old_rows)?_old_rows[_row]:undefined,
                                    _new_row=_row<array_length(_new_rows)?_new_rows[_row]:undefined
                                if(json_stringify(_old_row)!=json_stringify(_new_row)) {
                                    scrNTTESmokeLog("ACTOR DIFF OLD ROW "+string(_row)+" "+json_stringify(_old_row))
                                    scrNTTESmokeLog("ACTOR DIFF NEW ROW "+string(_row)+" "+json_stringify(_new_row))
                                }
                            }
                            _old_data.emission.shots=[];_new_data.emission.shots=[]
                            scrNTTESmokeLog("ACTOR DIFF OLD STATE "+json_stringify(_old_data))
                            scrNTTESmokeLog("ACTOR DIFF NEW STATE "+json_stringify(_new_data))
                        }
                        assert(_actual==_expected,"Actor birth capture changed literal old shot order/refs/motion/metadata/charge refresh, case="+string(_case)
                            +" density="+string(_density)+"; see preceding ACTOR DIFF records")
                        assert(_rng==_expected_rng && _native_rng==_expected_streams && _probe==_expected_probe,
                            "Actor birth capture changed real firing RNG/native streams")
                    }
                    assert(instance_number(Player)==_count && json_stringify(_player.ammo)==_player_ammo,
                        "Actor birth capture leaked synchronous proxy or changed real player ammo")
                    scrNTTEFullMergedRuntimeTestCleanup(_local_before)
                }
                scrNTTESmokeLog("ACTOR BIRTH CAPTURE "+json_stringify({rate:30/timescale,density:_density*512,
                    caseIndex:_case,oldUs:_elapsed[0],newUs:_elapsed[1],equivalent:true}))
            }
            for(var _i=0;_i<array_length(_dense);++_i) if(instance_exists(_dense[_i])) instance_destroy(_dense[_i],false)
        }
        scrNTTESmokeLog("PASS source-scoped actor births vs frozen literal old firing/Finalize: ordered typed refs, real immediate/delayed shots, existing charge refresh/physical owners, both RNG streams, dense-room timing @"+string(30/timescale))
    }
    finally {
        scrNTTEFullMergedRuntimeTestCleanup(_before)
        scrNTTEFullAreaGeneratorRestore(_players);scrNTTEFullAreaGeneratorRestore(_game)
        scrNTTEFullAreaGeneratorRestore(_back);scrNTTEFullAreaGeneratorRestore(_uber)
        global.ntte_full_native_weapon_models=_models;global.ntte_full_merged_request=_request
        global.rng_state=_streams;current_frame=_tick;random_set_seed(_seed)
    }
}

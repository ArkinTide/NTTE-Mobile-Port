function scrNTTEFullTridentMergedStateTests() {
    // Diagnose native VM alias semantics before testing the actual delayed
    // mount. @ writes must retain the literal caller and nested aliases.
    var _probe=[1],_probe_alias=_probe
    _probe_alias[@ 0]=2
    var _probe_direct=_probe[0],_probe_refs=[]
    array_push(_probe_refs,_probe)
    var _probe_nested=_probe_refs[0]
    _probe_nested[@ 0]=3
    var _probe_after_nested=_probe[0],_probe_struct={wep:_probe}
    _probe_struct.wep[@ 0]=4
    scrNTTESmokeLog("TRIDENT ARRAY ALIAS DIAG "+json_stringify({direct:_probe_direct,nested:_probe_after_nested,
        structWrite:_probe[0],structArray:_probe_struct.wep[0]}))
    var _before=scrNTTEFullInstances(all),_players=scrNTTEFullAreaGeneratorSnapshot(Player),
        _game=scrNTTEFullAreaGeneratorSnapshot(GameCont),_back=scrNTTEFullAreaGeneratorSnapshot(BackCont),
        _uber=scrNTTEFullAreaGeneratorSnapshot(UberCont),_keys=scrNTTEFullAreaGeneratorSnapshot(KeyCont),
        _seed=random_get_seed(),_frame=current_frame,_skills=ds_list_create(),
        _progress=global.ntte_full_progress,_progressSerialized=json_stringify(_progress),
        _pending=variable_global_exists("ntte_full_trident_transfers")?global.ntte_full_trident_transfers:[]
    scrNTTEFullWeaponNativeInit()
    var _models=scrNTTEFullArrayCopy(global.ntte_full_native_weapon_models)
    global.ntte_full_trident_transfers=[]
    GameCont.skills=_skills;GameCont.ntte_full_native_skill_counts={};GameCont.area=1;GameCont.underwater=false
    GameCont.temerge_effect_vars_map={};current_frame=2
    try {
        global.ntte_full_progress=json_parse(_progressSerialized)
        assert(global.ntte_full_progress!=_progress,"Merged Trident fixture did not isolate original progress identity")
        global.ntte_full_progress.unlocks[$ "wep:trident"]=true
        var _p=instance_find(Player,0),_player_count=instance_number(Player)
        _p.x=97000;_p.y=97000;_p.xprevious=_p.x;_p.yprevious=_p.y;_p.speed=0
        _p.gunangle=0;_p.wepangle=0;_p.wkick=0;_p.accuracy=0;_p.race=Race.Fish;_p.infammo=0
        _p.reloadspeed=1;_p.reload=0;_p.can_shoot=true;_p.clicked=false;_p.visible=true;_p.specfiring=false
        _p.ammo=array_create(Ammo.NUM_AMMO_TYPES,100);GameCont.rad=100;_p.curse=0;_p.bcurse=0
        _p.extra_weps=[];_p.ntte_extra_states=[];_p.ntte_trident_pending_swap=false
        var _child={wep:wep_revolver},_weapon=scrNTTEFullWeaponMerge(wep_ntte_trident,_child),
            _handle=scrNTTEFullWeaponNative(_weapon),_state=scrNTTEFullWeaponNativeState(_weapon)
        _p.wep=_handle;_p.ntte_state=_state;_p.bwep=wep_shotgun;_p.bntte_state=scrNTTENewState(wep_shotgun)
        _p.breload=0;_p.bcan_shoot=true
        KeyCont.hold_fire[_p.index]=true;KeyCont.press_fire[_p.index]=true
        repeat(ceil(7/timescale)) with(_p) scrNTTEHandleInput(wep,true)
        KeyCont.hold_fire[_p.index]=false;KeyCont.press_fire[_p.index]=false
        with(_p) scrNTTEHandleInput(wep,true)
        var _shots=scrNTTEFullMergedRuntimeTestShots(scrNTTEFullMergedRuntimeNew(_before),NTTEFullTrident)
        scrNTTESmokeLog("TRIDENT MERGED ROOT PREINDEX DIAG "+json_stringify({shots:array_length(_shots),
            raw:scrNTTEFullWeaponRaw(_weapon),stateWeapon:_state.weapon,ammo:_state.ammo,
            visible:scrNTTEFullValue(_state,"visible",true),charge:scrNTTEFullValue(_state,"chrg_num",-1),
            chrg:scrNTTEFullValue(_state,"chrg",-999),wep:_p.wep,bwep:_p.bwep,
            available:scrNTTEFullWeaponAvailable(wep_ntte_trident),
            pending:array_length(global.ntte_full_trident_transfers)}))
        assert(array_length(_shots)==1,"Merged root full Trident release must retain exactly one physical Trident before indexing")
        var _shot=_shots[0]
        scrNTTESmokeLog("TRIDENT MERGED ROOT DIAG "+json_stringify({shots:array_length(_shots),
            raw:scrNTTEFullWeaponRaw(_weapon),shotSame:_shot.wep==_weapon,stateSame:_shot.state==_state,
            wep:_p.wep,bwep:_p.bwep,ammo:_state.ammo,visible:_state.visible,
            flag:scrNTTEFullValue(_state,"ntte_trident_thrown",false),pending:array_length(global.ntte_full_trident_transfers)}))
        assert(array_length(_shots)==1 && _shot.wep==_weapon && _shot.state==_state && _shot.creator==_p
            && _weapon.wep==wep_ntte_trident && _weapon.temerge.wep[0]==_child && _child.wep==wep_revolver
            && _p.wep==wep_none && _p.bwep==wep_shotgun && is_undefined(_p.ntte_state)
            && _state.ammo==1 && !_state.visible && _p.ntte_trident_pending_swap
            && array_length(global.ntte_full_trident_transfers)==0,
            "Actual merged stock Trident did not transfer whole original LWO/state after input mount restoration")
        with(_p) scrNTTEPlayerStep()
        assert(_p.wep==wep_shotgun && _p.bwep==wep_none && !_p.ntte_trident_pending_swap
            && _shot.wep==_weapon && _weapon.wep==wep_ntte_trident,
            "Merged Trident root safe next-PlayerStep swap mutated/destroyed original thrown subtree")
        instance_destroy(_shot)
        var _pickup=noone
        with(WepPickup) if(scrNTTEFullValue(id,"ntte_state",undefined)==_state) _pickup=id
        assert(instance_exists(_pickup) && scrNTTEFullWeaponModel(_pickup.wep)==_weapon && _pickup.ntte_state==_state
            && _weapon.temerge.wep[0]==_child && _state.visible && _state.ammo==1,
            "Actual merged Trident cleanup failed original whole-tree pickup with identical physical state")
        scrNTTEFullMergedRuntimeTestCleanup(_before)
        // A front Trident carries its own nested front away. Only its parent's
        // reference becomes empty; neither physical LWO is rewritten or cloned.
        var _nested={wep:wep_shotgun},_front=scrNTTEFullWeaponMerge(wep_ntte_trident,_nested)
        _weapon=scrNTTEFullWeaponMerge(wep_revolver,_front);_handle=scrNTTEFullWeaponNative(_weapon)
        var _root=scrNTTEFullWeaponNativeState(_weapon)
        _state=scrNTTEFullWeaponNativeState(_front);_p.wep=_handle;_p.ntte_state=_root
        _p.bwep=wep_none;_p.bntte_state=undefined;_p.can_shoot=true;_p.reload=0;_p.wepangle=0
        repeat(ceil(7/timescale)) with(_p) scrFire(wep,true)
        var _controller=noone
        with(NTTEFullRedFireCharge) if(wep==_state) _controller=id
        assert(instance_exists(_controller) && _state.chrg_num==7 && _controller.ntte_merged_state_part==_front
            && _weapon.temerge.wep[0]==_front && _front.temerge.wep[0]==_nested,
            "Actual front nested Trident did not charge same physical subtree")
        with(_controller) {event_perform(ev_step,ev_step_normal);event_perform(ev_step,ev_step_normal)}
        _shots=scrNTTEFullMergedRuntimeTestShots(scrNTTEFullMergedRuntimeNew(_before),NTTEFullTrident);_shot=_shots[0]
        assert(!instance_exists(_controller) && array_length(_shots)==1 && _shot.wep==_front && _shot.state==_state
            && _front.wep==wep_ntte_trident && _front.temerge.wep[0]==_nested && _nested.wep==wep_shotgun
            && _weapon.temerge.wep[0]==wep_none && _weapon.temerge.is_part && _weapon.wep==wep_revolver
            && _p.wep==_handle && _p.ntte_state==_root && _root.ammo==-1 && _state.ammo==1
            // Original temerge1695..1708 exempts projectiles using the exact
            // physical weapon sprite; a thrown Trident is not merge-replaced.
            && !variable_instance_exists(_shot,"temerge_vars_list"),
            "Actual front Trident release rewrote original model, removed whole parent or lost source ancestry/state")
        with(_p) scrNTTEPlayerStep()
        assert(_front.wep==wep_ntte_trident && _front.temerge.wep[0]==_nested && _p.wep==_handle,
            "Generic merged Step converted detached projectile's actual Trident LWO into an empty part")
        instance_destroy(_shot);_pickup=noone
        with(WepPickup) if(scrNTTEFullValue(id,"ntte_state",undefined)==_state) _pickup=id
        assert(instance_exists(_pickup) && scrNTTEFullWeaponModel(_pickup.wep)==_front
            && _pickup.ntte_state==_state && _front.temerge.wep[0]==_nested
            && scrNTTEFullWeaponRaw(_weapon.temerge.wep[0])==wep_none,
            "Actual front Trident landing pickup did not preserve detached nested subtree identity")
        scrNTTEFullMergedRuntimeTestCleanup(_before)
        // Real enemy/Ally native proxy firing, retained delayed controller and
        // caller's weapon-by-reference array all refer to the original model.
        var _objects=[Bandit,Ally]
        for(var _kind=0;_kind<2;++_kind) {
            var _actor=instance_create(97500+_kind*200,97000,_objects[_kind])
            _actor.team=_kind==0?team_enemy:team_player;_actor.gunangle=15;_actor.visible=true;_actor.curse=0
            _weapon=scrNTTEFullWeaponMerge(wep_ntte_trident,{wep:wep_revolver});_handle=scrNTTEFullWeaponNative(_weapon)
            _state=scrNTTEFullWeaponNativeState(_weapon);_actor.wep=_handle;_actor.ntte_state=_state
            var _ref=[_handle],_at={creator:_actor,wep:_ref,direction:15,accuracy:0},_result=undefined
            repeat(ceil(7/timescale)) _result=scrNTTEFullActorFireMount(_actor,_at,_actor,false)
            _controller=noone
            with(NTTEFullRedFireCharge) if(wep==_state) _controller=id
            assert(instance_exists(_controller) && _controller.creator==_actor && _state.chrg_num==7
                && array_get_index(_controller.ntte_trident_transfer_refs,_ref)>=0 && instance_number(Player)==_player_count,
                "Actual enemy/Ally charged Trident lost source model, external array reference or freed-proxy ownership")
            var _captured=_controller.ntte_trident_transfer_refs,
                _alias_rows=[]
            for(var _j=0;_j<array_length(_captured);++_j) {
                var _alias=_captured[_j],_was=_alias[0]
                _alias[@ 0]=_was+100000
                array_push(_alias_rows,{row:_j,before:_was,caller:_ref[0],fireAt:_at.wep[0],
                    stored:_controller.ntte_trident_transfer_refs[_j][0],alias:_alias[0]})
                _alias[@ 0]=_was
            }
            scrNTTESmokeLog("TRIDENT CAPTURE ALIAS DIAG "+json_stringify(_alias_rows))
            _actor.x+=11;_actor.gunangle=90
            with(_controller) {event_perform(ev_step,ev_step_normal);event_perform(ev_step,ev_step_normal)}
            _shots=scrNTTEFullMergedRuntimeTestShots(scrNTTEFullMergedRuntimeNew(_before),NTTEFullTrident);_shot=_shots[0]
            scrNTTESmokeLog("TRIDENT ACTOR TRANSFER DIAG "+json_stringify({kind:_kind,
                controller:instance_exists(_controller),shots:array_length(_shots),creator:_shot.creator==_actor,
                team:_shot.team,expectedTeam:_actor.team,model:_shot.wep==_weapon,state:_shot.state==_state,
                direction:_shot.direction,raw:scrNTTEFullWeaponRaw(_weapon),actorWep:_actor.wep,
                actorStateUndefined:is_undefined(_actor.ntte_state),refWep:_ref[0],ammo:_state.ammo,
                players:instance_number(Player),expectedPlayers:_player_count,
                pending:array_length(global.ntte_full_trident_transfers),flag:scrNTTEFullValue(_state,"ntte_trident_thrown",false)}))
            assert(!instance_exists(_controller) && array_length(_shots)==1 && _shot.creator==_actor
                && _shot.team==_actor.team && _shot.wep==_weapon && _shot.state==_state
                && abs(angle_difference(_shot.direction,15))<0.001 && _weapon.wep==wep_ntte_trident
                && _actor.wep==wep_none && is_undefined(_actor.ntte_state) && _ref[0]==wep_none
                && _state.ammo==1 && instance_number(Player)==_player_count,
                "Actual enemy/Ally delayed Trident transfer lost physical model, captured direction, slot/array reference replacement or proxy cleanup")
            scrNTTEFullMergedRuntimeTestCleanup(_before)
        }
        // Cursed merged fronts remain attached while the real projectile is
        // away and return to the canonical source state without a pickup.
        _front={wep:wep_ntte_trident};_weapon=scrNTTEFullWeaponMerge(wep_revolver,_front)
        _handle=scrNTTEFullWeaponNative(_weapon);_root=scrNTTEFullWeaponNativeState(_weapon)
        _state=scrNTTEFullWeaponNativeState(_front);_p.wep=_handle;_p.ntte_state=_root;_p.curse=1
        _p.bwep=wep_none;_p.can_shoot=true;_p.reload=0;_p.gunangle=0
        repeat(ceil(7/timescale)) with(_p) scrFire(wep,true)
        _controller=noone
        with(NTTEFullRedFireCharge) if(wep==_state) _controller=id
        with(_controller) {event_perform(ev_step,ev_step_normal);event_perform(ev_step,ev_step_normal)}
        _shots=scrNTTEFullMergedRuntimeTestShots(scrNTTEFullMergedRuntimeNew(_before),NTTEFullTrident);_shot=_shots[0]
        var _owns=false
        with(_shot) _owns=scrNTTEFullTridentOwns(creator)
        assert(array_length(_shots)==1 && _shot.curse==1 && _shot.wep==_front && _shot.state==_state
            && _weapon.temerge.wep[0]==_front && !_weapon.temerge.is_part && !_state.visible && _owns
            && _p.wep==_handle && array_length(global.ntte_full_trident_transfers)==0,
            "Actual cursed merged Trident detached original front or failed canonical held ownership")
        var _pickups=instance_number(WepPickup)
        _shot.image_angle=70
        instance_destroy(_shot)
        assert(_state.visible && _state.ammo==1 && _weapon.temerge.wep[0]==_front
            && instance_number(WepPickup)==_pickups && _p.wepangle==_state.wepangle,
            "Actual cursed merged Trident cleanup dropped a duplicate instead of returning same physical front")
        var _returned_angle=_state.wepangle,
            _decayed=_returned_angle-clamp(_returned_angle*0.4,-40,40)*timescale
        if(abs(_decayed)<1) _decayed=0
        with(_p) event_perform(ev_step,ev_step_end)
        assert(_p.wepangle==_returned_angle && abs(_state.wepangle-_decayed)<0.001,
            "Actual Player EndStep lost front Trident slot rotation or applied source decay more than once")
        // A second real cursed throw is moved to the inactive secondary slot
        // before cleanup. Exact physical ownership routes its return angle to
        // that slot, preserving the newly active gun's unrelated angle.
        _state.wepangle=0;_p.can_shoot=true;_p.reload=0;_p.gunangle=0
        _p.bwep=wep_shotgun;_p.bntte_state=scrNTTENewState(wep_shotgun);_p.bcurse=0
        repeat(ceil(7/timescale)) with(_p) scrFire(wep,true)
        _controller=noone
        with(NTTEFullRedFireCharge) if(wep==_state) _controller=id
        with(_controller) {event_perform(ev_step,ev_step_normal);event_perform(ev_step,ev_step_normal)}
        _shots=scrNTTEFullMergedRuntimeTestShots(scrNTTEFullMergedRuntimeNew(_before),NTTEFullTrident);_shot=_shots[0]
        with(_p) scrSwapWeps(false)
        assert(_p.bwep==_handle && _p.bntte_state==_root && _shot.state==_state && _shot.curse==1,
            "Real weapon swap did not retain same cursed nested Trident in inactive secondary")
        _p.wepangle=17;_shot.image_angle=-65
        instance_destroy(_shot)
        _returned_angle=_state.wepangle
        assert(_p.wepangle==17 && _p.bwepangle==_returned_angle && _state.visible
            && instance_number(WepPickup)==_pickups,
            "Cursed nested Trident cleanup wrote active primary angle instead of exact physical secondary")
        _decayed=_returned_angle-clamp(_returned_angle*0.4,-40,40)*timescale
        if(abs(_decayed)<1) _decayed=0
        with(_p) event_perform(ev_step,ev_step_end)
        assert(_p.wepangle==17 && _p.bwepangle==_returned_angle && abs(_state.wepangle-_decayed)<0.001,
            "Actual Player EndStep lost inactive secondary front Trident rotation/source single decay")
        scrNTTEFullMergedRuntimeTestCleanup(_before)
        scrNTTEFullTridentWeaponProjectileNativeTests()
        scrNTTESmokeLog("PASS merged Trident actual root whole-LWO transfer/safe next-Step swap, nested front subtree detach/landing identity, native Bandit+Ally delayed array-ref transfer, cursed front keep/return")
    }
    finally {
        scrNTTEFullMergedRuntimeTestCleanup(_before)
        scrNTTEFullAreaGeneratorRestore(_players);scrNTTEFullAreaGeneratorRestore(_game)
        scrNTTEFullAreaGeneratorRestore(_back);scrNTTEFullAreaGeneratorRestore(_uber);scrNTTEFullAreaGeneratorRestore(_keys)
        global.ntte_full_native_weapon_models=_models;global.ntte_full_trident_transfers=_pending
        random_set_seed(_seed);current_frame=_frame;ds_list_destroy(_skills)
        global.ntte_full_progress=_progress
        assert(global.ntte_full_progress==_progress && json_stringify(global.ntte_full_progress)==_progressSerialized,
            "Merged Trident fixture changed original progress identity or serialized contents")
    }
}

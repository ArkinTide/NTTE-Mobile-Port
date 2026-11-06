function scrNTTEFullCrabbonePhysicalNativeTests() {
    scrNTTEFullWeaponNativeInit()
    var _before=scrNTTEFullInstances(all),_players=scrNTTEFullAreaGeneratorSnapshot(Player),
        _game=scrNTTEFullAreaGeneratorSnapshot(GameCont),_keys=scrNTTEFullAreaGeneratorSnapshot(KeyCont),
        _uber=scrNTTEFullAreaGeneratorSnapshot(UberCont),_seed=random_get_seed(),_frame=current_frame,
        _models=global.ntte_full_native_weapon_models,_skills=ds_list_create(),_enemies=scrNTTEFullInstances(enemy),
        _progress=global.ntte_full_progress
    global.ntte_full_progress=json_parse(json_stringify(_progress))
    global.ntte_full_progress.stats.bone=1000;global.ntte_full_progress.unlocks[$ "wep:scythe"]=true
    for(var _i=0;_i<array_length(_enemies);++_i) instance_deactivate_object(_enemies[_i])
    GameCont.skills=_skills;GameCont.ntte_full_native_skill_counts={};GameCont.area=1;GameCont.underwater=false;current_frame=2
    try {
        var _p=instance_find(Player,0)
        _p.x=5000;_p.y=5000;_p.xprevious=_p.x;_p.yprevious=_p.y;_p.speed=0;_p.race=Race.Fish
        _p.curse=0;_p.bcurse=0;_p.visible=true;_p.can_pick=true;_p.gunangle=0;_p.accuracy=0
        _p.infammo=0;_p.reload=0;_p.reloadspeed=1;_p.can_shoot=true;_p.specfiring=false
        _p.extra_weps=[];_p.ntte_extra_states=[];_p.ammo=array_create(Ammo.NUM_AMMO_TYPES,100)
        _p.bwep=wep_shotgun;_p.bntte_state=scrNTTENewState(wep_shotgun)
        KeyCont.press_pick[_p.index]=false
        var _back=_p.bntte_state,_bottom=scrNTTEFullCrabboneCreateModel(0),_top=scrNTTEFullCrabboneCreateModel(1)
        _p.wep=scrNTTEFullWeaponNative(_bottom);_p.ntte_state=scrNTTEFullWeaponNativeState(_bottom)
        var _pickup=scrWeaponPickupCreate(_p.x,_p.y,_top)
        _pickup.ntte_state=_top.ntte_native_state;_pickup.speed=0
        with(_p) scrNTTEPlayerStep()
        assert(!instance_exists(_pickup) && scrNTTEFullWeaponModel(_p.wep)==_top
            && _p.ntte_state==_top.ntte_native_state && _top.ammo==2 && _top.ammo_wep==_bottom
            && _p.ntte_state.ammo_wep==_bottom && _p.bntte_state==_back,
            "Actual native artifact contact did not stack different typed original models/exact previous state independently of secondary")
        var _epoch=scrNTTEFullInstances(all)
        with(_p) scrFire(wep,true)
        var _shots=scrNTTEFullMergedRuntimeTestShots(scrNTTEFullMergedRuntimeNew(_epoch),NTTEFullCrabboneBone),_shot=_shots[0]
        assert(array_length(_shots)==1 && _shot.wep==_top && _shot.state==_top.ntte_native_state
            && _top.ammo==1 && _top.ammo_wep==wep_none && _shot.creator==_p
            && scrNTTEFullWeaponModel(_p.wep)==_bottom && _p.ntte_state==_bottom.ntte_native_state,
            "Actual native artifact fire failed physical top transfer or exact previous-model/state replacement after mount")
        _shot.speed=0;with(_shot) event_perform(ev_step,ev_step_normal)
        _pickup=noone;with(WepPickup) if(scrNTTEFullWeaponModel(wep)==_top) _pickup=id
        assert(instance_exists(_pickup) && _pickup.ntte_state==_top.ntte_native_state,
            "Thrown stacked artifact did not land as same exact top physical model/canonical state")
        scrNTTEFullMergedRuntimeTestCleanup(_before)
        // Actual Quest target Floor blocks natural auto-stack only while no
        // hostile remains. A matching live controller is required, not art.
        var _floor=instance_create(4992,4992,Floor),_controller=instance_create(5000,5000,NTTEFullQuestFloorCont)
        _controller.target=_floor;_controller.part_index=0
        _top=scrNTTEFullCrabboneCreateModel(2);_pickup=scrWeaponPickupCreate(5000,5000,_top)
        _pickup.speed=0;_pickup.ntte_state=_top.ntte_native_state
        with(_p) scrNTTEPlayerStep()
        assert(instance_exists(_pickup) && scrNTTEFullWeaponModel(_p.wep)==_bottom
            && _bottom.ntte_native_state.ammo==1,"Actual artifact contact ignored live QuestFloor suppression")
        var _hostile=instance_create(5300,5000,Bandit)
        with(_p) scrNTTEPlayerStep()
        assert(!instance_exists(_pickup) && scrNTTEFullWeaponModel(_p.wep)==_top && _top.ammo_wep==_bottom,
            "Artifact auto-stack remained blocked while actual hostile enemy existed")
        scrNTTEFullMergedRuntimeTestCleanup(_before)
        // Source cursed artifacts are25-damage genuine EnergySlash with four
        // exact original visual variants and10force, without consuming parts.
        var _sprites=["EnergyBatSlash","PurpleEnergyBatSlash","PopoEnergyBatSlash","EnemyEnergyBatSlash"]
        for(var _i=0;_i<4;++_i) {
            _top=scrNTTEFullCrabboneCreateModel(_i);_p.wep=scrNTTEFullWeaponNative(_top)
            _p.ntte_state=scrNTTEFullWeaponNativeState(_top);_p.curse=1;_p.reload=0;_p.can_shoot=true;_p.wepangle=120;_p.speed=0
            _epoch=scrNTTEFullInstances(all)
            with(_p) scrFire(wep,true)
            _shots=scrNTTEFullMergedRuntimeTestShots(scrNTTEFullMergedRuntimeNew(_epoch),EnergySlash);_shot=_shots[0]
            assert(array_length(_shots)==1 && _shot.damage==25 && _shot.knockback_speed==10*timescale
                && _shot.sprite_index==scrNTTERefSprite(_sprites[_i]) && abs(_shot.image_xscale)==0.75
                && abs(_shot.image_yscale)==0.75 && abs(_p.wepangle)==100 && _top.ntte_native_state.ammo==1
                && scrNTTEFullWeaponModel(_p.wep)==_top,
                "Cursed actual artifact fire lost source EnergySlash25/force10/four sprite variants/3quarter geometry/angle100 or consumed model")
        }
        scrNTTEFullMergedRuntimeTestCleanup(_before)
        // Nested part transfer removes the original complete front subtree;
        // parent remains held/incomplete while that subtree becomes a pickup.
        _p.curse=0;_p.speed=0;_p.reload=0;_p.can_shoot=true
        _top=scrNTTEFullWeaponMerge(scrNTTEFullCrabboneCreateModel(1),{wep:wep_shotgun})
        var _root=scrNTTEFullWeaponMerge({wep:wep_revolver},_top),_root_state=scrNTTEFullWeaponNativeState(_root)
        _p.wep=scrNTTEFullWeaponNative(_root);_p.ntte_state=_root_state
        _epoch=scrNTTEFullInstances(all)
        with(_p) scrFire(wep,true)
        _shots=scrNTTEFullMergedRuntimeTestShots(scrNTTEFullMergedRuntimeNew(_epoch),NTTEFullCrabboneBone)
        assert(array_length(_shots)==1 && _shots[0].wep==_top && scrNTTEFullWeaponRaw(_top)==wep_ntte_guarded_artifact
            && scrNTTEFullWeaponRaw(_top.temerge.wep[0])==wep_shotgun && _root.temerge.is_part
            && scrNTTEFullWeaponRaw(_root.temerge.wep[0])==wep_none && _p.ntte_state==_root_state
            && scrNTTEFullWeaponModel(_p.wep)==_root,
            "Actual merged stock emission lost complete original artifact front subtree or removed/rebuilt its held parent")
        // Native instance_destroy(false) still runs CleanUp. Discard this
        // still-airborne fixture shot without manufacturing a pickup at the
        // stationary player's feet that would outrank the following prompt.
        _shots[0].broken=true
        scrNTTEFullMergedRuntimeTestCleanup(_before)
        // Raw ordinary held Bone naturally meets a physical ordinary model;
        // exact source stack promotion must retain all twelve original states.
        _p.wep=wep_ntte_bone;_p.ntte_state=scrNTTENewState(wep_ntte_bone)
        _p.curse=0;_p.reload=0;_p.can_shoot=true;_p.speed=0;_p.gunangle=0;_p.wepangle=120
        for(var _i=0;_i<11;++_i) {
            var _bone=scrNTTEFullCrabboneCreateModel(-1),_drop=scrWeaponPickupCreate(_p.x,_p.y,_bone)
            _drop.ntte_state=_bone.ntte_native_state;_drop.speed=0
            with(_p) scrNTTEPlayerStep()
        }
        assert(scrNTTEFullWeaponIsNative(_p.wep) && _p.ntte_state.ammo==12
            && instance_exists(_p.prompt_scythe),"Raw-to-physical ordinary contact lost twelve-bone chain or native Scythe prompt")
        KeyCont.press_pick[_p.index]=true
        with(_p) {scrNTTEFullPromptPlayerStep();scrNTTEPlayerStep()}
        scrNTTESmokeLog("CRABBONE PHYSICAL SCYTHE DIAG "+json_stringify({weapon:_p.wep,
            raw:scrNTTEFullWeaponRaw(_p.wep),ammo:scrNTTEFullValue(_p.ntte_state,"ammo",-999),
            stateWeapon:scrNTTEFullValue(_p.ntte_state,"weapon",-999),
            promptExists:instance_exists(_p.prompt_scythe),canPick:_p.can_pick,visible:_p.visible,
            winner:scrNTTEFullPromptWinner(_p),pickups:instance_number(WepPickup),
            conversionFrame:scrNTTEFullValue(_p,"ntte_crabbone_scythe_frame",-999),frame:current_frame}))
        assert(scrNTTEFullWeaponRaw(_p.wep)==wep_ntte_bone_scythe && _p.ntte_state.ammo==40
            && !instance_exists(_p.prompt_scythe),
            "Actual native physical twelve-bone prompt conversion switched mode or failed exact two-spare physical model collection")
        KeyCont.press_pick[_p.index]=false
        scrNTTEFullMergedRuntimeTestCleanup(_before)
        // Real non-Player native proxy uses external by-reference replacement.
        var _actor=instance_create(5400,5000,Bandit),_count=instance_number(Player)
        _actor.team=team_enemy;_actor.curse=0;_actor.gunangle=0
        _top=scrNTTEFullCrabboneCreateModel(3);_actor.wep=scrNTTEFullWeaponNative(_top)
        _actor.ntte_state=scrNTTEFullWeaponNativeState(_top)
        var _ref=[_actor.wep],_at={creator:_actor,wep:_ref,direction:0,accuracy:0}
        _epoch=scrNTTEFullInstances(all)
        scrNTTEFullActorFireMount(_actor,_at,_actor,false)
        _shots=scrNTTEFullMergedRuntimeTestShots(scrNTTEFullMergedRuntimeNew(_epoch),NTTEFullCrabboneBone)
        assert(array_length(_shots)==1 && _shots[0].wep==_top && _shots[0].creator==_actor
            && _shots[0].team==team_enemy && _actor.wep==wep_none && _ref[0]==wep_none
            && is_undefined(_actor.ntte_state) && instance_number(Player)==_count,
            "Actual enemy artifact forced consumption lost exact physical source/external array replacement or leaked native proxy")
        scrNTTESmokeLog("PASS native physical artifact stack/exact previous LWO pop, QuestFloor enemy-aware suppression, four cursed EnergySlash variants, whole nested subtree transfer, real Bandit external array commit without proxy leak")
    }
    finally {
        with(NTTEFullCrabboneBone) if(array_get_index(_before,id)<0) broken=true
        with(NTTEFullWepPickupStick) if(array_get_index(_before,id)<0) stick_damage=0
        scrNTTEFullMergedRuntimeTestCleanup(_before)
        for(var _i=0;_i<array_length(_enemies);++_i) instance_activate_object(_enemies[_i])
        scrNTTEFullAreaGeneratorRestore(_players);scrNTTEFullAreaGeneratorRestore(_game)
        scrNTTEFullAreaGeneratorRestore(_keys);scrNTTEFullAreaGeneratorRestore(_uber)
        global.ntte_full_native_weapon_models=_models;global.ntte_full_progress=_progress
        current_frame=_frame;random_set_seed(_seed);ds_list_destroy(_skills)
    }
}

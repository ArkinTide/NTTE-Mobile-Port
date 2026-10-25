function scrNTTEFullMergedRuntimeStateTests() {
    var _before=scrNTTEFullInstances(all),_players=scrNTTEFullAreaGeneratorSnapshot(Player),
        _game=scrNTTEFullAreaGeneratorSnapshot(GameCont),_back=scrNTTEFullAreaGeneratorSnapshot(BackCont),
        _uber=scrNTTEFullAreaGeneratorSnapshot(UberCont),_keys=scrNTTEFullAreaGeneratorSnapshot(KeyCont),
        _seed=random_get_seed(),_tick=current_frame,
        _scope=variable_global_exists("ntte_full_merged_state_fire")?global.ntte_full_merged_state_fire:undefined,
        _input=variable_global_exists("ntte_full_merged_input_weapon")?global.ntte_full_merged_input_weapon:undefined
    scrNTTEFullWeaponNativeInit()
    var _models=scrNTTEFullArrayCopy(global.ntte_full_native_weapon_models)
    global.ntte_full_merged_state_fire=_scope;global.ntte_full_merged_input_weapon=_input
    try {
        var _p=instance_find(Player,0)
        _p.x=52000;_p.y=52000;_p.xprevious=_p.x;_p.yprevious=_p.y
        _p.hspeed=0;_p.vspeed=0;_p.gunangle=0;_p.accuracy=0;_p.race=Race.Fish;_p.visible=true
        _p.infammo=0;_p.ntte_race_ultra=0;_p.ntte_native_race=-1;_p.ntte_scythe_slots_migrated=true
        _p.ammo=array_create(Ammo.NUM_AMMO_TYPES,100);_p.ntte_red_ammo=3;GameCont.rad=100
        _p.wepangle=1;_p.wkick=0;_p.bwep=wep_wrench;_p.bntte_state=scrNTTENewState(wep_wrench)
        KeyCont.press_pick[_p.index]=false;KeyCont.hold_fire[_p.index]=false;KeyCont.hold_spec[_p.index]=false
        KeyCont.press_fire[_p.index]=false;KeyCont.press_spec[_p.index]=false
        UberCont.opt_shake=1;UberCont.opt_freeze=1;GameCont.temerge_effect_vars_map={}
        // Full native PlayerStep reaches every active physical part, and the
        // independent nested Clam object survives its actual own Step event.
        var _clam={wep:wep_ntte_clam_shield},_disc=scrNTTEFullWeaponMerge(wep_ntte_sawblade_gun,_clam),
            _weapon=scrNTTEFullWeaponMerge(wep_ntte_bone_scythe,_disc),_handle=scrNTTEFullWeaponNative(_weapon),
            _root_state=scrNTTEFullWeaponNativeState(_weapon),_disc_state=scrNTTEFullWeaponNativeState(_disc),
            _clam_state=scrNTTEFullWeaponNativeState(_clam)
        _p.wep=_handle;_p.ntte_state=_root_state;_disc_state.ammo=1;_disc_state.loaded=false
        var _parts=scrNTTEFullMergedRuntimeStateParts(_handle)
        assert(array_length(_parts)==3 && _parts[0]==_weapon && _parts[1]==_disc && _parts[2]==_clam,
            "Merged native state traversal changed source stock/front/nested order")
        with(_p) scrNTTEPlayerStep()
        var _shields=scrNTTEFullMergedRuntimeTestShots(scrNTTEFullMergedRuntimeNew(_before),NTTEFullClamShield)
        assert(array_length(_shields)==1 && _shields[0].ntte_clam_state==_clam_state
            && _p.wep==_handle && _p.bwep==wep_wrench && _p.ntte_state==_root_state
            && _root_state.weapon==_handle && _disc_state.weapon==scrNTTEFullWeaponNative(_disc)
            && !_disc_state.loaded && !_p.can_shoot && _p.reload==scr_weapon_get_load(wep_ntte_sawblade_gun),
            "Actual Player custom Step lost nested Clam creation, disc return/reload blockade or held physical slots")
        var _shield=_shields[0]
        with(_shield) event_perform(ev_step,ev_step_normal)
        assert(instance_exists(_shield) && scrNTTEOwnsState(_p,_clam_state)
            && scrNTTEFullMergedRuntimeStateHas(_p,true,_clam_state),
            "Actual nested shield Step did not recognize its canonical physical front state")
        scrNTTEFullWeaponMergeActive(_weapon,false)
        with(_shield) event_perform(ev_step,ev_step_normal)
        assert(!instance_exists(_shield) && !scrNTTEFullMergedRuntimeStateHas(_p,true,_clam_state)
            && array_length(scrNTTEFullMergedRuntimeStateParts(_weapon))==1,
            "Inactive merge still owns/steps a hidden front shield")
        scrNTTEFullWeaponMergeActive(_weapon,true)
        // Actual raw mode swap is captured back to this same stock LWO.
        var _mount=scrNTTEFullMergedRuntimeStateMount(_p,_weapon,true,true)
        try {with(_p) scrNTTEFullScytheSwap(1)}
        finally {scrNTTEFullMergedRuntimeStateUnmount(_mount)}
        assert(scrNTTEFullWeaponRaw(_weapon)==wep_ntte_bone_shotbow && _p.wep==_handle
            && _p.ntte_state==_root_state && _root_state.weapon==_handle,
            "Mounted raw Scythe mode mutation failed to preserve the actual merged weapon/state identity")
        scrNTTEFullMergedRuntimeTestCleanup(_before)
        // Stock always reloads; active fronts reload only if their own source
        // wep_fire_frame reached fire_frame, recursively at each nested node.
        var _front=scrNTTEFullWeaponMerge(wep_ntte_bubble_shotgun,{wep:wep_ntte_bubble_bat})
        _weapon=scrNTTEFullWeaponMerge(wep_revolver,_front);_handle=scrNTTEFullWeaponNative(_weapon)
        _p.wep=_handle;_p.ntte_state=scrNTTEFullWeaponNativeState(_weapon);_p.wepflip=1
        _weapon.temerge.fire_frame=current_frame+10;_weapon.temerge.wep_fire_frame=current_frame
        with(_p) scrNTTEFullMergedRuntimeStateReloaded(true)
        assert(_p.wepflip==-1 && array_length(scrNTTEFullMergedRuntimeTestShots(scrNTTEFullMergedRuntimeNew(_before),Bubble))==0,
            "Unfired front incorrectly received reload callback")
        _weapon.temerge.wep_fire_frame=_weapon.temerge.fire_frame
        _front.temerge.fire_frame=current_frame;_front.temerge.wep_fire_frame=current_frame
        with(_p) scrNTTEFullMergedRuntimeStateReloaded(true)
        var _bubbles=scrNTTEFullMergedRuntimeTestShots(scrNTTEFullMergedRuntimeNew(_before),Bubble)
        assert(_p.wepflip==1 && array_length(_bubbles)==4,
            "Recursive actual reload callbacks lost source Shotgun3/Bat1 bubbles or duplicated stock flips")
        for(var _i=0;_i<array_length(_bubbles);++_i)
            assert(_bubbles[_i].image_xscale==0.75 && (_bubbles[_i].x==_p.x+16 || _bubbles[_i].x==_p.x+14),
                "Source per-weapon reload bubble distance/scale changed")
        scrNTTEFullMergedRuntimeTestCleanup(_before)
        // A consumed nested thrown weapon becomes a part, rather than
        // destructively removing the player's complete merged inventory slot.
        _front={wep:wep_ntte_bone};_weapon=scrNTTEFullWeaponMerge(wep_revolver,_front)
        _handle=scrNTTEFullWeaponNative(_weapon);_p.wep=_handle;_p.ntte_state=scrNTTEFullWeaponNativeState(_weapon)
        scrNTTEFullWeaponNativeState(_front).ammo=0
        current_frame=ceil(current_frame)
        with(_p) scrNTTEFullMergedRuntimeStateStepSlots()
        assert(_p.wep==_handle && scrNTTEFullWeaponRaw(_front)==wep_none && _weapon.temerge.is_part,
            "Nested spent Bone destroyed the whole native slot or failed to update source part state")
        // Real scrFire: a charged Annihilator front creates a genuine delayed
        // teamed object, then releases its actual native RedBullet with the
        // original Revolver effect ancestry and current creator position.
        _front={wep:wep_ntte_annihilator};_weapon=scrNTTEFullWeaponMerge(wep_revolver,_front)
        _handle=scrNTTEFullWeaponNative(_weapon);_p.wep=_handle;_p.ntte_state=scrNTTEFullWeaponNativeState(_weapon)
        _p.ntte_red_ammo=3;_p.wepangle=1;_p.reload=0;_p.can_shoot=true;_p.gunangle=0
        var _fired=false
        with(_p) _fired=scrFire(_handle,true)
        var _controllers=scrNTTEFullMergedRuntimeTestShots(scrNTTEFullMergedRuntimeNew(_before),NTTEFullRedFireCharge)
        assert(_fired && array_length(_controllers)==1 && _controllers[0].ntte_merged_state_part==_front
            && array_length(scrNTTEFullMergedRuntimeTestShots(scrNTTEFullMergedRuntimeNew(_before),NTTEFullRedBullet))==0,
            "Actual charged front failed to retain source delayed controller instead of immediate fire/no-shot cancellation")
        var _controller=_controllers[0],_charged=scrNTTEFullWeaponNativeState(_front),_captured_angle=_controller.direction
        with(_controller) event_perform(ev_step,ev_step_normal)
        assert(instance_exists(_controller) && _controller.fire && _charged.chrg_num>0,
            "First merged FireCharge Step must only arm the original two-phase release")
        _charged.chrg_num=15;_charged.charge=15;_charged.chrg=2
        _p.x+=25;_p.y+=30;_p.gunangle=90;current_frame+=2
        with(_controller) event_perform(ev_step,ev_step_normal)
        var _red=scrNTTEFullMergedRuntimeTestShots(scrNTTEFullMergedRuntimeNew(_before),NTTEFullRedBullet)
        assert(!instance_exists(_controller) && array_length(_red)==1 && _p.ntte_red_ammo==1
            && _charged.chrg==0 && _charged.charge==0 && _p.wep==_handle
            && _p.ntte_state==scrNTTEFullWeaponNativeState(_weapon) && _charged.weapon==scrNTTEFullWeaponNative(_front),
            "Actual merged charge release lost RedBullet/red-cost, source reset or complete physical-state restoration")
        assert(_red[0].creator==_p && abs(angle_difference(_red[0].direction,_captured_angle))<0.001
            && array_length(_red[0].temerge_vars_list)==1 && _p.gunangle==90,
            "Delayed merged front release lost captured direction, true creator or source inherited effect graph")
        assert(global.ntte_full_merged_state_fire==_scope && global.ntte_full_merged_input_weapon==_input,
            "Merged physical state/input scopes leaked after actual native callbacks")
        scrNTTESmokeLog("PASS merged recursive physical step/reload, nested shield ownership, raw mode/empty part capture, actual native delayed charge ancestry")
    }
    finally {
        scrNTTEFullMergedRuntimeTestCleanup(_before)
        scrNTTEFullAreaGeneratorRestore(_players);scrNTTEFullAreaGeneratorRestore(_game)
        scrNTTEFullAreaGeneratorRestore(_back);scrNTTEFullAreaGeneratorRestore(_uber);scrNTTEFullAreaGeneratorRestore(_keys)
        global.ntte_full_native_weapon_models=_models
        global.ntte_full_merged_state_fire=_scope;global.ntte_full_merged_input_weapon=_input
        current_frame=_tick;random_set_seed(_seed)
    }
}

// BEGIN NTTE CHARGE INPUT NATIVE TESTS
// Explicit native entry tests: no production wrapper is replaced or mocked.
function scrNTTEFullChargeInputTestEquip(_player,_weapon) {
    with(_player) {
        scrNTTEFullChargeInputCancel(id)
        x=204000;y=204000;xprevious=x;yprevious=y;speed=0;gunangle=0;accuracy=0
        wep=_weapon;bwep=wep_none;ntte_state=scrNTTENewState(_weapon);bntte_state=undefined
        wepangle=120;wepflip=1;wkick=0;reloadspeed=1;reload=0;can_shoot=true;clicked=false
        hp=8;max_hp=8;lsthealth=8;fainted=0;roll=0;visible=true;race=Race.Fish
        can_walk=false;can_spec=false;can_pick=false;infammo=0;curse=0;bcurse=0
        specfiring=false;ntte_red_ammo=8;ntte_native_race=-1;ntte_race_ultra=0
        ntte_scythe_slots_migrated=true;ammo=array_create(Ammo.NUM_AMMO_TYPES,100)
        KeyCont.hold_fire[index]=false;KeyCont.press_fire[index]=false
        KeyCont.hold_spec[index]=false;KeyCont.press_spec[index]=false
        KeyCont.press_swap[index]=false;KeyCont.press_pick[index]=false;KeyCont.moving[index]=0
    }
}
function scrNTTEFullChargeInputNativeTests() {
    var _before=scrNTTEFullInstances(all),_players=scrNTTEFullAreaGeneratorSnapshot(Player),
        _game=scrNTTEFullAreaGeneratorSnapshot(GameCont),_back=scrNTTEFullAreaGeneratorSnapshot(BackCont),
        _uber=scrNTTEFullAreaGeneratorSnapshot(UberCont),_graph={nodes:[]},_frame=current_frame,
        _seed=random_get_seed(),_skills=ds_list_create()
    scrNTTEFullAreaSnapshotContainer(KeyCont,_graph)
    scrNTTEFullWeaponNativeInit()
    var _models=scrNTTEFullArrayCopy(global.ntte_full_native_weapon_models),_p=instance_find(Player,0),
        _parked=scrNTTEFullInstances(NTTEFullRedFireCharge)
    for(var _i=0;_i<array_length(_parked);++_i) instance_deactivate_object(_parked[_i])
    GameCont.skills=_skills;GameCont.ntte_full_native_skill_counts={};GameCont.rad=100
    GameCont.area=area_desert;GameCont.underwater=false;GameCont.temerge_effect_vars_map={}
    UberCont.opt_shake=1;UberCont.opt_freeze=1;current_frame=300
    try {
        var _raws=[wep_ntte_trident,wep_ntte_golden_trident,wep_ntte_pizza_cutter,
            wep_ntte_annihilator,wep_ntte_entangler,wep_ntte_tunneller,wep_ntte_golden_tunneller]
        for(var _kind=0;_kind<array_length(_raws);++_kind) for(var _native=0;_native<2;++_native) {
            var _raw=_raws[_kind],_weapon=_native?scrNTTEFullWeaponNative({wep:_raw}):_raw
            scrNTTEFullChargeInputTestEquip(_p,_weapon)
            var _state=_p.ntte_state,_local=scrNTTEFullInstances(all)
            KeyCont.hold_fire[_p.index]=true;KeyCont.press_fire[_p.index]=true
            with(_p) scrPlayerFiring()
            var _shots=scrNTTEFullMergedRuntimeProjectiles(scrNTTEFullMergedRuntimeNew(_local))
            assert(array_length(_shots)>0 && _state.charge==0 && _state.chrg_num==0
                && instance_number(NTTEFullRedFireCharge)==0 && _p.ntte_red_ammo==8,
                "Charge tap failed ordinary native attack without a controller/red spend: "+string([_raw,_native]))
            if(_raw==wep_ntte_pizza_cutter) {
                var _slashes=scrNTTEFullMergedRuntimeTestShots(_shots,Slash)
                assert(array_length(_slashes)==1 && _slashes[0].damage==8 && _state.ammo==1 && _state.outstanding==0,
                    "Loaded Pizza tap must remain the exact ordinary8 slash without throwing its physical blade")
            }
            if(scrNTTEIsTrident(_raw)) {
                var _stabs=scrNTTEFullMergedRuntimeTestShots(_shots,Shank)
                assert(array_length(_stabs)>0 && _stabs[0].damage==20 && _state.ammo==1 && _state.visible,
                    "Trident tap lost its authored20 partial stab or consumed the physical weapon")
            }
            var _born_after_tap=scrNTTEFullInstances(all)
            KeyCont.press_fire[_p.index]=false;KeyCont.hold_fire[_p.index]=false
            current_frame+=timescale;_p.can_shoot=true;_p.reload=0
            with(_p) scrPlayerFiring()
            assert(_state.charge==0 && instance_number(NTTEFullRedFireCharge)==0
                && array_length(scrNTTEFullMergedRuntimeProjectiles(scrNTTEFullMergedRuntimeNew(_born_after_tap)))==0,
                "Short tap release emitted a second attack or entered charging")
            scrNTTEFullMergedRuntimeTestCleanup(_before)

            scrNTTEFullChargeInputTestEquip(_p,_weapon);_state=_p.ntte_state
            KeyCont.hold_fire[_p.index]=true;KeyCont.press_fire[_p.index]=true
            with(_p) scrPlayerFiring()
            KeyCont.press_fire[_p.index]=false;_born_after_tap=scrNTTEFullInstances(all)
            for(var _tick=1;_tick<ceil(6/timescale);++_tick) {
                current_frame+=timescale;_p.can_shoot=true;_p.reload=0
                with(_p) scrPlayerFiring()
                assert(_state.charge==0 && instance_number(NTTEFullRedFireCharge)==0
                    && array_length(scrNTTEFullMergedRuntimeProjectiles(scrNTTEFullMergedRuntimeNew(_born_after_tap)))==0,
                    "Held charge entered before six logical ticks or repeated the ordinary tap: "+string([_raw,_native,_tick]))
            }
            current_frame+=timescale;_p.can_shoot=true;_p.reload=0
            with(_p) scrPlayerFiring()
            assert(_state.charge==timescale && _state.chrg_num==timescale
                && instance_number(NTTEFullRedFireCharge)==1 && _p.ntte_red_ammo==8,
                "Held charge did not begin after the common200ms delay with unchanged first native tick")
            var _max=scrNTTEChargeMax(_raw)
            repeat(ceil(_max/timescale)-1) {
                current_frame+=timescale;_p.can_shoot=true;_p.reload=0
                with(_p) scrPlayerFiring()
            }
            assert(_state.charge==_max && _state.chrg_num==_max && _p.ntte_red_ammo==8,
                "Tap intent changed authored charge duration or consumed charge resources before release")
            KeyCont.hold_fire[_p.index]=false;current_frame+=timescale
            with(_p) scrPlayerFiring()
            assert(_state.charge==0 && _state.chrg_num==0 && _p.ntte_red_ammo==8-scrNTTERedCost(_raw),
                "Actual held release failed exact source charge reset/red resource cost")
            if(scrNTTEIsTrident(_raw)) assert(!_state.visible,"Full held Trident release did not transfer physical weapon")
            if(_raw==wep_ntte_pizza_cutter) assert(_state.ammo==0 && _state.outstanding==1,
                "Full held Pizza release did not transfer/refund-bind its physical blade")
            scrNTTEFullMergedRuntimeTestCleanup(_before)
        }

        // Real native click buffer and reload gates remain before an accepted
        // ordinary shot. The delay begins at that shot, not the original press.
        scrNTTEFullChargeInputTestEquip(_p,wep_ntte_pizza_cutter)
        _state=_p.ntte_state;_p.reload=4;_p.can_shoot=false
        KeyCont.hold_fire[_p.index]=true;KeyCont.press_fire[_p.index]=true
        with(_p) scrPlayerFiring()
        assert(_state.charge==0 && _p.reload==4,"Charge press bypassed ordinary native reload")
        KeyCont.press_fire[_p.index]=false;current_frame+=6;_p.can_shoot=true;_p.reload=0
        with(_p) scrPlayerFiring()
        assert(_state.charge==0 && _p.ntte_charge_primary.elapsed==0 && _p.ntte_charge_primary.phase==1,
            "The pending ordinary attack inherited time accrued before it actually fired")
        repeat(ceil(6/timescale)) {
            current_frame+=timescale;_p.can_shoot=false;_p.reload=2
            with(_p) scrPlayerFiring()
        }
        assert(_state.charge==0,"Six-tick threshold bypassed the ordinary attack's remaining reload")
        current_frame+=timescale;_p.can_shoot=true;_p.reload=0
        with(_p) scrPlayerFiring()
        assert(_state.charge==timescale,"Native reload completion did not admit the original charge machine")
        scrNTTEFullMergedRuntimeTestCleanup(_before)

        // Canonical stock/front/nested parts all perform source ordinary
        // attacks on the initial Player press, preserving their physical IDs.
        var _front=scrNTTEFullWeaponMerge(wep_ntte_trident,{wep:wep_ntte_annihilator}),
            _tree=scrNTTEFullWeaponMerge(wep_ntte_pizza_cutter,_front),
            _handle=scrNTTEFullWeaponNative(_tree)
        scrNTTEFullChargeInputTestEquip(_p,_handle)
        var _parts=scrNTTEFullMergedRuntimeStateParts(_tree),_states=[]
        for(var _i=0;_i<array_length(_parts);++_i) array_push(_states,scrNTTEFullWeaponNativeState(_parts[_i]))
        KeyCont.hold_fire[_p.index]=true;KeyCont.press_fire[_p.index]=true
        with(_p) scrPlayerFiring()
        assert(_p.wep==_handle && _p.ntte_state==_states[0] && _p.ntte_red_ammo==8
            && instance_number(NTTEFullRedFireCharge)==0,"Merged ordinary tap lost physical stock or charged a front")
        for(var _i=0;_i<array_length(_parts);++_i)
            assert(scrNTTEFullWeaponNativeState(_parts[_i])==_states[_i] && _states[_i].charge==0
                && _states[_i].chrg_num==0,"Merged ordinary scope replaced a canonical part or leaked charge aliases")
        scrNTTEFullMergedRuntimeTestCleanup(_before)

        // Both firing channels remain independent despite real Steroids slot
        // swaps, including two physical weapons sharing the same raw type.
        scrNTTEFullChargeInputTestEquip(_p,wep_ntte_annihilator)
        _p.race=Race.Steroids;_p.bwep=wep_ntte_annihilator;_p.bntte_state=scrNTTENewState(_p.bwep)
        _p.breload=0;_p.bcan_shoot=true;_p.bwepangle=120
        var _primary_state=_p.ntte_state,_secondary_state=_p.bntte_state
        KeyCont.hold_fire[_p.index]=true;KeyCont.press_fire[_p.index]=true
        KeyCont.hold_spec[_p.index]=true;KeyCont.press_spec[_p.index]=true
        with(_p) {scrPlayerFiring(true);scrSwapWeps(false);scrPlayerFiring(false);scrSwapWeps(false)}
        assert(_p.ntte_charge_primary.state==_primary_state && _p.ntte_charge_secondary.state==_secondary_state
            && _primary_state!=_secondary_state && _primary_state.charge==0 && _secondary_state.charge==0,
            "Steroids ordinary press mixed primary/secondary charge intent or physical identity")
        KeyCont.press_fire[_p.index]=false;KeyCont.press_spec[_p.index]=false
        repeat(ceil(6/timescale)) {
            current_frame+=timescale;_p.can_shoot=true;_p.bcan_shoot=true;_p.reload=0;_p.breload=0
            with(_p) {scrPlayerFiring(true);scrSwapWeps(false);scrPlayerFiring(false);scrSwapWeps(false)}
        }
        assert(_primary_state.charge==timescale && _secondary_state.charge==timescale,
            "Steroids actual mounted secondary input lost the same delay or double-counted a logical frame")
        KeyCont.press_swap[_p.index]=true
        with(_p) scrSwapWeps(false)
        KeyCont.press_swap[_p.index]=false
        assert(_primary_state.charge==0 && _secondary_state.charge==0
            && is_undefined(_p.ntte_charge_primary) && is_undefined(_p.ntte_charge_secondary),
            "Actual player weapon swap retained an old physical held-charge intent")
        scrNTTEFullMergedRuntimeTestCleanup(_before)

        // Direct scripted native fire and a noncharge stock's charged front
        // retain their source FireCharge behavior outside Player input intent.
        scrNTTEFullChargeInputTestEquip(_p,wep_ntte_annihilator)
        with(_p) scrFire(wep,true)
        assert(_p.ntte_state.charge==timescale && instance_number(NTTEFullRedFireCharge)==1,
            "Player intent adapter altered direct/scripted native charging")
        scrNTTEFullMergedRuntimeTestCleanup(_before)
        _front={wep:wep_ntte_annihilator};_tree=scrNTTEFullWeaponMerge(wep_revolver,_front)
        _handle=scrNTTEFullWeaponNative(_tree);scrNTTEFullChargeInputTestEquip(_p,_handle)
        with(_p) scrFire(wep,true)
        assert(scrNTTEFullWeaponNativeState(_front).charge==timescale && instance_number(NTTEFullRedFireCharge)==1,
            "Ordinary Player tap scope leaked into a later direct merged front fire")
        scrNTTESmokeLog("PASS charge input: seven raw/native weapons ordinary taps, no short-tap charge, logical200ms+reload gates, authored full charge/resources/physical transfer, recursive canonical fronts, Steroids dual/swap and direct native/script unchanged @"+string(30/timescale))
    }
    finally {
        scrNTTEFullMergedRuntimeTestCleanup(_before)
        scrNTTEFullAreaGeneratorRestore(_players);scrNTTEFullAreaGeneratorRestore(_game)
        scrNTTEFullAreaGeneratorRestore(_back);scrNTTEFullAreaGeneratorRestore(_uber)
        scrNTTEFullAreaGeneratorRestore({instances:[],containers:_graph.nodes})
        for(var _i=0;_i<array_length(_parked);++_i) instance_activate_object(_parked[_i])
        global.ntte_full_native_weapon_models=_models;current_frame=_frame;random_set_seed(_seed);ds_list_destroy(_skills)
    }
}

function scrNTTEFullChargeInputPlayerStepNativeTests() {
    scrNTTEFullWeaponNativeInit()
    var _fixture=scrNTTEFullVanillaFixtureBegin(),_players=scrNTTEFullAreaGeneratorSnapshot(Player),
        _back=scrNTTEFullAreaGeneratorSnapshot(BackCont),_graph={nodes:[]},_frame=current_frame,
        _stop=lockstep_stop,_skills=ds_list_create(),_models=scrNTTEFullArrayCopy(global.ntte_full_native_weapon_models),
        _parked=scrNTTEFullInstances([NTTEFullRedFireCharge,NTTEFullPrompt,Cinematic,SitDown,MenuGen])
    scrNTTEFullAreaSnapshotContainer(KeyCont,_graph)
    for(var _i=0;_i<array_length(_parked);++_i) instance_deactivate_object(_parked[_i])
    lockstep_stop=false;GameCont.skills=_skills;GameCont.ntte_full_native_skill_counts={};GameCont.rad=100
    try {
        var _p=instance_find(Player,0)
        assert(!scrGameIsLockState(),"Charge actual PlayerStep fixture is locked")
        for(var _order=0;_order<2;++_order) {
            var _before=scrNTTEFullInstances(all),_weapon=scrNTTEFullWeaponNative({wep:wep_ntte_annihilator})
            scrNTTEFullChargeInputTestEquip(_p,_weapon)
            var _state=_p.ntte_state,_slashes=instance_number(NTTEFullRedSlash),_bullets=instance_number(NTTEFullRedBullet),
                _started=false,_charge_ticks=0,_elapsed=0
            KeyCont.hold_fire[_p.index]=true;KeyCont.press_fire[_p.index]=true
            for(var _tick=0;_tick<ceil(90/timescale);++_tick) {
                current_frame+=timescale
                if(_order==0) with(NTTEFullRedFireCharge) if(creator==_p) event_perform(ev_step,ev_step_normal)
                with(_p) event_perform(ev_step,ev_step_normal)
                if(_order==1) with(NTTEFullRedFireCharge) if(creator==_p) event_perform(ev_step,ev_step_normal)
                with(_p) event_perform(ev_step,ev_step_end)
                if(_tick==0) assert(instance_number(NTTEFullRedSlash)==_slashes+1 && _state.charge==0,
                    "First actual native Player frame failed one immediate ordinary attack")
                else _elapsed+=timescale
                if(_state.charge>0) {
                    _started=true;_charge_ticks+=timescale
                    assert(_elapsed>=6 && _state.charge==min(_charge_ticks,15),
                        "Actual Player/controller event order changed delay or native15-tick charge rate")
                }
                assert(instance_number(NTTEFullRedSlash)==_slashes+1 && instance_number(NTTEFullRedBullet)==_bullets
                    && _p.ntte_red_ammo==8 && _p.wep==_weapon && _p.ntte_state==_state,
                    "Native held Player Step repeated the tap, released early or changed physical/resources")
                KeyCont.press_fire[_p.index]=false
                if(_state.charge>=15) break
            }
            assert(_started && _state.charge==15,"Actual Player native reload never admitted full held charge")
            KeyCont.hold_fire[_p.index]=false;current_frame+=timescale
            if(_order==0) with(NTTEFullRedFireCharge) if(creator==_p) event_perform(ev_step,ev_step_normal)
            with(_p) event_perform(ev_step,ev_step_normal)
            if(_order==1) with(NTTEFullRedFireCharge) if(creator==_p) event_perform(ev_step,ev_step_normal)
            assert(instance_number(NTTEFullRedBullet)==_bullets+1 && _state.charge==0 && _p.ntte_red_ammo==6,
                "Actual Player native release lost exactly one charged shot/source red2 cost")
            repeat(3) with(NTTEFullRedFireCharge) if(creator==_p) event_perform(ev_step,ev_step_normal)
            assert(instance_number(NTTEFullRedBullet)==_bullets+1,"Native controller duplicated an input-owned release")
            scrNTTEFullMergedRuntimeTestCleanup(_before)
        }
        // Native hidden and fainted early exits clear held intent and charging;
        // they do not call normal fire or change character skill preferences.
        for(var _mode=0;_mode<2;++_mode) {
            var _before=scrNTTEFullInstances(all)
            scrNTTEFullChargeInputTestEquip(_p,wep_ntte_annihilator)
            KeyCont.hold_fire[_p.index]=true;KeyCont.press_fire[_p.index]=true
            with(_p) scrPlayerFiring()
            KeyCont.press_fire[_p.index]=false
            repeat(ceil(6/timescale)) {
                current_frame+=timescale;_p.can_shoot=true;_p.reload=0
                with(_p) scrPlayerFiring()
            }
            _state=_p.ntte_state
            assert(_state.charge>0,"Early-exit cancellation fixture never began actual charging")
            if(_mode==0) _p.visible=false
            else _p.fainted=10
            with(_p) event_perform(ev_step,ev_step_normal)
            assert(_state.charge==0 && is_undefined(_p.ntte_charge_primary),
                "Actual hidden/fainted Player early exit retained held weapon-charge intent")
            scrNTTEFullMergedRuntimeTestCleanup(_before)
        }
    }
    finally {
        scrNTTEFullAreaGeneratorRestore(_players);scrNTTEFullAreaGeneratorRestore(_back)
        scrNTTEFullAreaGeneratorRestore({instances:[],containers:_graph.nodes})
        scrNTTEFullVanillaFixtureEnd(_fixture)
        for(var _i=0;_i<array_length(_parked);++_i) instance_activate_object(_parked[_i])
        global.ntte_full_native_weapon_models=_models;current_frame=_frame;lockstep_stop=_stop;ds_list_destroy(_skills)
    }
    scrNTTESmokeLog("PASS charge native PlayerStep/EndStep: ordinary first attack, original reload+delay, authored15 ticks, both FireCharge event orders, one source red2 release and actual hidden/fainted cancellation @"+string(30/timescale))
}

// The manual aiming joystick intentionally names its release edge press_fire,
// while still reporting hold_fire on that final frame. Exercise that exact
// input shape through Player.Step/EndStep and genuine FireCharge controllers.
function scrNTTEFullChargeLegacyFrame(_p,_order) {
    current_frame+=timescale
    if(_order==0) with(NTTEFullRedFireCharge) if(creator==_p) event_perform(ev_step,ev_step_normal)
    with(_p) event_perform(ev_step,ev_step_normal)
    if(_order==1) with(NTTEFullRedFireCharge) if(creator==_p) event_perform(ev_step,ev_step_normal)
    with(_p) event_perform(ev_step,ev_step_end)
}
function scrNTTEFullChargeLegacyReleaseNativeTests() {
    scrNTTEFullWeaponNativeInit()
    var _fixture=scrNTTEFullVanillaFixtureBegin(),_players=scrNTTEFullAreaGeneratorSnapshot(Player),
        _back=scrNTTEFullAreaGeneratorSnapshot(BackCont),_graph={nodes:[]},_frame=current_frame,
        _stop=lockstep_stop,_skills=ds_list_create(),_models=scrNTTEFullArrayCopy(global.ntte_full_native_weapon_models),
        _parked=scrNTTEFullInstances([NTTEFullRedFireCharge,NTTEFullPrompt,Cinematic,SitDown,MenuGen]),_checks=0
    scrNTTEFullAreaSnapshotContainer(KeyCont,_graph)
    for(var _i=0;_i<array_length(_parked);++_i) instance_deactivate_object(_parked[_i])
    lockstep_stop=false;GameCont.skills=_skills;GameCont.ntte_full_native_skill_counts={};GameCont.rad=100
    try {
        var _p=instance_find(Player,0),_raws=[wep_ntte_trident,wep_ntte_golden_trident,wep_ntte_pizza_cutter,
            wep_ntte_annihilator,wep_ntte_entangler,wep_ntte_tunneller,wep_ntte_golden_tunneller]
        assert(!scrGameIsLockState(),"Legacy input Player fixture is locked")
        for(var _kind=0;_kind<array_length(_raws);++_kind) for(var _native=0;_native<2;++_native) for(var _order=0;_order<2;++_order) {
            var _before=scrNTTEFullInstances(all),_raw=_raws[_kind],
                _weapon=_native?scrNTTEFullWeaponNative({wep:_raw}):_raw
            scrNTTEFullChargeInputTestEquip(_p,_weapon)
            var _state=_p.ntte_state,_max=scrNTTEChargeMax(_raw)
            KeyCont.hold_fire[_p.index]=true;KeyCont.press_fire[_p.index]=false;KeyCont.release_fire[_p.index]=true
            scrNTTEFullChargeLegacyFrame(_p,_order)
            assert(is_struct(_p.ntte_charge_primary) && _p.ntte_charge_primary.phase==1 && _state.charge==0,
                "Manual hold failed its ordinary first attack: "+string([_raw,_native,_order]))
            KeyCont.release_fire[_p.index]=false
            for(var _tick=0;_tick<ceil(150/timescale) && _state.charge<_max;++_tick)
                scrNTTEFullChargeLegacyFrame(_p,_order)
            assert(_state.charge==_max && _p.ntte_red_ammo==8,"Manual hold never reached unchanged full source charge")
            // Final touch-up frame: the legacy joystick's press+hold combination.
            var _intent=_p.ntte_charge_primary,_shots=scrNTTEFullInstances(all)
            KeyCont.press_fire[_p.index]=true
            scrNTTEFullChargeLegacyFrame(_p,_order)
            assert(_p.ntte_charge_primary==_intent && _state.charge==_max && _p.ntte_red_ammo==8,
                "Legacy release-named-press discarded full charge or substituted an ordinary shot")
            KeyCont.press_fire[_p.index]=false;KeyCont.hold_fire[_p.index]=false
            scrNTTEFullChargeLegacyFrame(_p,_order)
            var _born=scrNTTEFullMergedRuntimeNew(_shots)
            if(scrNTTEIsTrident(_raw)) assert(!_state.visible && array_length(scrNTTEFullMergedRuntimeTestShots(_born,NTTEFullTrident))==1,
                "Manual release failed one real charged Trident transfer")
            else if(_raw==wep_ntte_pizza_cutter) assert(_state.ammo==0 && _state.outstanding==1,
                "Manual release substituted ordinary Pizza slash instead of throwing its charged disc")
            else {
                assert(_p.ntte_red_ammo==8-scrNTTERedCost(_raw),"Manual release failed exact charged red resource cost")
                if(_raw==wep_ntte_annihilator) assert(array_length(scrNTTEFullMergedRuntimeTestShots(_born,NTTEFullRedBullet))==1,
                    "Manual charged Annihilator emitted ordinary slash")
                else if(_raw==wep_ntte_entangler) {
                    var _slashes=scrNTTEFullMergedRuntimeTestShots(_born,NTTEFullEntanglerSlash)
                    assert(array_length(_slashes)==1 && _slashes[0].damage==200 && _slashes[0].clone,
                        "Manual charged Entangler lost its genuine200damage charm slash")
                }
                else assert(array_length(scrNTTEFullMergedRuntimeTestShots(_born,NTTEFullCrystalHeartBullet))==1,
                    "Manual charged Tunneller emitted ordinary stabs instead of area ball")
            }
            assert(_state.charge==0 && is_undefined(_p.ntte_charge_primary),"Manual release leaked an active charge intent")
            repeat(3) with(NTTEFullRedFireCharge) if(creator==_p) event_perform(ev_step,ev_step_normal)
            assert(_p.ntte_red_ammo==8-scrNTTERedCost(_raw),"A stale controller repeated manual release resource spending")
            _checks++;scrNTTEFullMergedRuntimeTestCleanup(_before)
        }
    } finally {
        scrNTTEFullAreaGeneratorRestore(_players);scrNTTEFullAreaGeneratorRestore(_back)
        scrNTTEFullAreaGeneratorRestore({instances:[],containers:_graph.nodes});scrNTTEFullVanillaFixtureEnd(_fixture)
        for(var _i=0;_i<array_length(_parked);++_i) instance_activate_object(_parked[_i])
        global.ntte_full_native_weapon_models=_models;current_frame=_frame;lockstep_stop=_stop;ds_list_destroy(_skills)
    }
    scrNTTESmokeLog("PASS CHARGE LEGACY RELEASE actual Player.Step/EndStep, seven raw/native weapons, both controller orders, joystick release-named-press preserves full charge and exact projectile/resources/transfer checks="+string(_checks)+" @"+string(30/timescale))
}
// END NTTE CHARGE INPUT NATIVE TESTS

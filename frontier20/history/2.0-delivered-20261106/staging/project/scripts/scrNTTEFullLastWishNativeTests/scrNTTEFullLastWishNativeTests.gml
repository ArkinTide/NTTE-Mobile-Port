function scrNTTEFullLastWishNativeTests() {
    assert(scrNTTESmokeEnabled(),"Last Wish fixture requires explicit desktop smoke harness")
    scrNTTEFullWeaponNativeInit()
    var _before=scrNTTEFullInstances(all),_game=scrNTTEFullAreaGeneratorSnapshot(GameCont),
        _players=scrNTTEFullAreaGeneratorSnapshot(Player),_skills=ds_list_create(),_seed=random_get_seed(),
        _registry=global.ntte_full_native_weapon_models,_count=array_length(_registry),
        _last=scrNTTEFullValue(GameCont,"ntte_lastwish",0),_saved=[],_frame=current_frame
    GameCont.skills=_skills;GameCont.ntte_full_native_skill_counts={};GameCont.ntte_lastwish=0
    with(Player) {
        array_push(_saved,[id,scrNTTEFullValue(id,"feather_num",0),scrNTTEFullValue(id,"feather_ammo",0),
            scrNTTEFullValue(id,"feather_ammo_max",0),scrNTTEFullValue(id,"ntte_red_ammo",0),scrNTTEFullValue(id,"ntte_red_amax",4)])
        wep=wep_revolver;bwep=wep_none;race=Race.Fish
    }
    try {
        var _p=instance_find(Player,0)
        // A real newly created player receives no pilot's free three Red
        // shots; the same setup must preserve a loaded/current value.
        var _new=instance_create(99100,99100,Player)
        scrNTTEFullLastWishStep()
        assert(_new.ntte_red_ammo==0 && _new.ntte_red_amax==4,
            "Native first Begin Step did not establish original zero Red ammo: ammo="+string(_new.ntte_red_ammo)
            +" max="+string(_new.ntte_red_amax)+" muscle="+string(scr_skill_get(mut_back_muscle)))
        _new.ntte_red_ammo=2;scrNTTEFullLastWishStep()
        assert(_new.ntte_red_ammo==2,"Red initialization reset an existing saved/current amount")
        instance_destroy(_new,false)
        // Actual native mutation setter -> actual integrated Begin Step.
        _p.wep=wep_ntte_sawblade_gun;_p.ntte_state=scrNTTENewState(_p.wep);_p.ntte_state.ammo=0
        _p.bwep=wep_ntte_sawblade_cannon;_p.bntte_state=scrNTTENewState(_p.bwep);_p.bntte_state.ammo=0
        scr_skill_set(mut_last_wish,1)
        with(GameCont) event_perform(ev_step,ev_step_begin)
        assert(GameCont.ntte_lastwish==1 && _p.ntte_state.ammo==2 && _p.bntte_state.ammo==7,
            "Actual Last Wish/Begin Step did not refill two custom slots with source ceil and minimum shot cost")
        with(GameCont) event_perform(ev_step,ev_step_begin)
        assert(_p.ntte_state.ammo==2 && _p.bntte_state.ammo==7,"Unchanged Last Wish count refilled every frame")
        var _raws=[wep_ntte_pizza_cutter,wep_ntte_vampire,wep_ntte_bone_scythe,wep_ntte_bone_shotbow,wep_ntte_bone_slugbow],
            _expected=[1,3,20,20,20]
        for(var _i=0;_i<array_length(_raws);++_i) {
            _p.wep=_raws[_i];_p.ntte_state=scrNTTENewState(_p.wep);_p.ntte_state.ammo=0;_p.bwep=wep_none
            GameCont.ntte_lastwish=0;scrNTTEFullLastWishStep()
            assert(_p.ntte_state.ammo==_expected[_i],"Source custom Last Wish magazine mismatch: "+string(_raws[_i]))
        }
        // Physical outer LWO only, without recursively refilling merged parts.
        var _front=scrNTTEFullWeaponNative( {wep:wep_ntte_vampire} ),
            _outer=scrNTTEFullWeaponNative(scrNTTEFullWeaponMerge(wep_ntte_bone_scythe,scrNTTEFullWeaponModel(_front))),
            _rootState=scrNTTEFullWeaponNativeState(_outer),_frontState=scrNTTEFullWeaponNativeState(_front)
        _rootState.ammo=0;_frontState.ammo=0;_p.wep=_outer;_p.ntte_state=_rootState
        _p.bwep=wep_ntte_bone;_p.bntte_state=scrNTTENewState(_p.bwep);_p.bntte_state.ammo=0
        GameCont.ntte_lastwish=0;scrNTTEFullLastWishStep()
        assert(_rootState.ammo==20 && _frontState.ammo==0 && _p.bntte_state.ammo==0,
            "Last Wish failed real physical LWO state, recursed into source merge front or refilled ammo-without-amax Bone")
        _p.bwep=wep_ntte_trident;_p.bntte_state=scrNTTENewState(_p.bwep);_p.bntte_state.ammo=0
        _rootState.capacity=99;_rootState.muscle=1;_rootState.ammo=0
        GameCont.ntte_lastwish=0;scrNTTEFullLastWishStep()
        assert(_rootState.ammo==35 && _p.bntte_state.ammo==0,
            "Last Wish lost buffed actual capacity/source ceil or incorrectly refilled Trident without amax")
        // Source >=200 unbuffed capacity branch, then upper cap.
        _rootState.capacity=220;_rootState.muscle=0;_rootState.ammo=0
        GameCont.ntte_lastwish=0;scrNTTEFullLastWishStep()
        assert(_rootState.ammo==173,"Last Wish omitted source large-capacity 0.785 rounding branch")
        GameCont.ntte_lastwish=0;scrNTTEFullLastWishStep()
        assert(_rootState.ammo==220,"Last Wish exceeded actual magazine capacity")
        // Positive count falling 2->1 subtracts the difference, while complete
        // removal to zero never subtracts. Do not normalize this source quirk.
        _rootState.capacity=55;_rootState.muscle=0;_rootState.ammo=40
        GameCont.ntte_lastwish=2;scrNTTEFullLastWishStep()
        assert(_rootState.ammo==20,"Last Wish stack decrease while positive did not apply source negative delta")
        GameCont.ntte_full_native_skill_counts[$ string(mut_last_wish)]=0;ds_list_clear(_skills)
        scrNTTEFullLastWishStep()
        assert(_rootState.ammo==20 && GameCont.ntte_lastwish==0,"Last Wish removal to zero incorrectly drained magazines")
        ds_list_add(_skills,mut_last_wish);GameCont.ntte_full_native_skill_counts[$ string(mut_last_wish)]=1
        _p.wep=wep_ntte_annihilator;_p.bwep=wep_revolver;_p.race=NTTEFullRace.Parrot
        _p.feather_num=3;_p.feather_ammo=1;_p.feather_ammo_max=12;_p.ntte_red_ammo=1;_p.ntte_red_amax=8
        scrNTTEFullLastWishStep()
        assert(_p.feather_ammo==7 && _p.ntte_red_ammo==8,"Last Wish did not refill Parrot two volleys and eligible Red entire capacity")
        _p.feather_ammo=12;_p.ntte_red_ammo=1;GameCont.ntte_lastwish=2;scrNTTEFullLastWishStep()
        assert(_p.feather_ammo==12 && _p.ntte_red_ammo==-7,
            "Last Wish diverged from source full-feather guard or source Red negative-delta lower-bound behavior")
        _p.feather_ammo=1;_p.ntte_red_ammo=1;_p.wep=wep_revolver;GameCont.ntte_lastwish=2;scrNTTEFullLastWishStep()
        assert(_p.feather_ammo==3 && _p.ntte_red_ammo==1,
            "Last Wish lost feather one-volley lower clamp or granted Red without eligible weapon")
        _p.race=Race.Fish;_p.feather_ammo=1;GameCont.ntte_lastwish=0;scrNTTEFullLastWishStep()
        assert(_p.feather_ammo==1,"Last Wish refilled feather fields on a non-Parrot player")
    }
    finally {
        var _all=scrNTTEFullInstances(all)
        for(var _i=array_length(_all)-1;_i>=0;--_i)
            if(array_get_index(_before,_all[_i])<0 && instance_exists(_all[_i])) instance_destroy(_all[_i],false)
        scrNTTEFullAreaGeneratorRestore(_players);scrNTTEFullAreaGeneratorRestore(_game)
        for(var _i=0;_i<array_length(_saved);++_i) {
            var _s=_saved[_i],_p=_s[0]
            if(instance_exists(_p)) {_p.feather_num=_s[1];_p.feather_ammo=_s[2];_p.feather_ammo_max=_s[3];_p.ntte_red_ammo=_s[4];_p.ntte_red_amax=_s[5]}
        }
        GameCont.ntte_lastwish=_last;global.ntte_full_native_weapon_models=_registry;array_resize(_registry,_count)
        current_frame=_frame;random_set_seed(_seed);ds_list_destroy(_skills)
    }
    scrNTTESmokeLog("FULL LAST WISH NATIVE: actual mutation setter+Begin Step, source count delta/one-shot/removal semantics, five magazine classes/all Scythe modes/min shot cost/rounding/cap, real outer merged physical identity/no front recursion/no Bone-Trident refill, Parrot volleys and Red eligibility+signed delta OK @"+string(30/timescale))
}

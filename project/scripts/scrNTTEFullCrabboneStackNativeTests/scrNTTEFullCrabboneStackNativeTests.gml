function scrNTTEFullCrabboneStackNativeTests() {
    var _before=scrNTTEFullInstances(all),_players=scrNTTEFullAreaGeneratorSnapshot(Player),
        _game=scrNTTEFullAreaGeneratorSnapshot(GameCont),_keys=scrNTTEFullAreaGeneratorSnapshot(KeyCont),
        _uber=scrNTTEFullAreaGeneratorSnapshot(UberCont),_seed=random_get_seed(),_frame=current_frame,
        _progress=global.ntte_full_progress,_skills=ds_list_create()
    global.ntte_full_progress=json_parse(json_stringify(_progress))
    global.ntte_full_progress.stats.bone=1000;global.ntte_full_progress.unlocks[$ "wep:scythe"]=true
    GameCont.skills=_skills;GameCont.ntte_full_native_skill_counts={};GameCont.area=1;GameCont.underwater=false
    current_frame=2
    try {
        var _p=instance_find(Player,0),_states=[],_count=instance_number(WepPickup)
        _p.x=6000;_p.y=6000;_p.xprevious=_p.x;_p.yprevious=_p.y;_p.speed=0
        _p.wep=wep_ntte_bone;_p.ntte_state=scrNTTENewState(wep_ntte_bone)
        _p.bwep=wep_shotgun;_p.bntte_state=scrNTTENewState(wep_shotgun)
        var _back=_p.bntte_state
        _p.curse=0;_p.bcurse=0;_p.extra_weps=[];_p.ntte_extra_states=[];_p.race=Race.Fish
        _p.reload=0;_p.reloadspeed=1;_p.can_shoot=true;_p.gunangle=0;_p.wepangle=120;_p.wkick=0
        _p.infammo=0;_p.accuracy=0;_p.visible=true;_p.can_pick=true;_p.specfiring=false
        _p.ammo=array_create(Ammo.NUM_AMMO_TYPES,100);KeyCont.press_pick[_p.index]=false
        array_push(_states,_p.ntte_state)
        repeat(2) {
            var _pickup=scrWeaponPickupCreate(_p.x,_p.y,wep_ntte_bone),_incoming=scrNTTENewState(wep_ntte_bone)
            _pickup.ntte_state=_incoming;_pickup.speed=0;array_push(_states,_incoming)
            with(_p) scrNTTEPlayerStep()
        }
        var _top=_p.ntte_state,_second=_top.ammo_wep.ntte_native_state,_bottom=_second.ammo_wep.ntte_native_state
        assert(_top==_states[2] && _second==_states[1] && _bottom==_states[0]
            && _top.ammo==3 && _second.ammo==2 && _bottom.ammo==1
            && _bottom.ammo_wep==wep_none && instance_number(WepPickup)==_count
            && _p.bntte_state==_back && _p.bwep==wep_shotgun,
            "Real Player contact failed physical three-bone ammo_wep chain or borrowed unrelated secondary state")
        // Three actual native fires must restore those exact old states in
        // sequence. Each thrown top remains normalized to1 and cannot refund.
        var _order=[_top,_second,_bottom]
        for(var _i=0;_i<3;++_i) {
            _p.reload=0;_p.can_shoot=true;_p.gunangle=0;_p.speed=0
            with(_p) scrFire(wep,true)
            var _shots=scrNTTEFullMergedRuntimeTestShots(scrNTTEFullMergedRuntimeNew(_before),NTTEFullCrabboneBone),_shot=_shots[0]
            assert(array_length(_shots)==1 && scrNTTEFullWeaponRaw(_shot.wep)==wep_ntte_bone
                && _shot.state==_order[_i] && _shot.damage==34 && _shot.creator==_p
                && _shot.state.ammo==1 && _shot.state.ammo_wep==wep_none && !_shot.broken
                && _p.ntte_state==_order[_i] && _order[_i].ntte_crabbone_pending_pop,
                "Actual Crabbone native fire did not detach same physical top bone after completed mount")
            with(_p) scrNTTEPlayerStep()
            if(_i<2) assert(_p.wep==wep_ntte_bone && _p.ntte_state==_order[_i+1]
                && _p.ntte_state.ammo==2-_i,"Actual next-PlayerStep did not pop exact previous bone state")
            else assert(_p.wep==wep_shotgun && _p.ntte_state==_back && _p.bwep==wep_none,
                "Final bone consumption lost safe native secondary swap/state")
            var _shards=instance_number(NTTEBoneShard),_pickups=instance_number(WepPickup)
            _shot.x=_p.x+96;_shot.y=_p.y;_shot.speed=0
            with(_shot) event_perform(ev_step,ev_step_normal)
            var _returned=noone
            with(WepPickup) if(ntte_state==_order[_i]) _returned=id
            assert(!instance_exists(_shot) && instance_number(NTTEBoneShard)==_shards
                && instance_number(WepPickup)==_pickups+1 && instance_exists(_returned)
                && _returned.ntte_state==_order[_i] && _returned.x==_p.x+96
                && _returned.sprite_index==scrNTTERefSprite("Bone"),
                "Harmless thrown bone must return same physical state at its landing, without shards")
        }
        scrNTTEFullMergedRuntimeTestCleanup(_before)
        // Cursed ordinary bones are actual alternating light/heavy BoneSlash
        // swings, rather than repeatedly thrown/consumed projectiles.
        _p.wep=wep_ntte_bone;_p.ntte_state=scrNTTENewState(wep_ntte_bone);_p.curse=1
        _p.bwep=wep_none;_p.bntte_state=undefined;_p.wepangle=120;_p.gunangle=0;_p.speed=0
        var _state=_p.ntte_state
        for(var _i=0;_i<2;++_i) {
            _p.reload=0;_p.can_shoot=true
            with(_p) scrFire(wep,true)
            var _slashes=scrNTTEFullMergedRuntimeTestShots(scrNTTEFullMergedRuntimeNew(_before),NTTEFullBoneSlash),
                _slash=_slashes[array_length(_slashes)-1]
            with(_slash) scrNTTEFullBoneSlashSetup()
            assert(array_length(_slashes)==_i+1 && _slash.heavy==(_i==1) && _slash.damage==(_i==0?24:32)
                && abs(_slash.image_xscale)==0.75 && abs(_slash.image_yscale)==0.75
                && abs(_slash.rotspeed)==2 && abs(_p.wepangle)==100
                && _state.ammo==1 && _state.combo==_i+1 && _p.ntte_state==_state
                && _p.wkick==(_i==0?-9:-12),
                "Cursed Crabbone actual native fire lost source combo24/32, 3/4 geometry, angle100, post or physical ammo")
        }
        assert(instance_number(NTTEAttack)==0,"Cursed ordinary bone emitted legacy thrown projectile")
        scrNTTEFullMergedRuntimeTestCleanup(_before)
        // Build twelve physical bones through actual contact. Native prompt
        // selection then converts ten; the remaining two are dropped and the
        // genuine new Scythe's later Step collects their forty fragments.
        _p.wep=wep_ntte_bone;_p.ntte_state=scrNTTENewState(wep_ntte_bone);_p.curse=0;_p.speed=0
        _p.gunangle=0;_p.wepangle=120;_p.wkick=0;_p.can_pick=true
        repeat(11) {
            var _pickup=scrWeaponPickupCreate(_p.x,_p.y,wep_ntte_bone)
            _pickup.ntte_state=scrNTTENewState(wep_ntte_bone);_pickup.speed=0
            with(_p) scrNTTEPlayerStep()
        }
        var _prompt=_p.prompt_scythe
        assert(_p.ntte_state.ammo==12 && instance_exists(_prompt) && _prompt.text=="SCYTHE"
            && _prompt.depth==1000000,"Actual twelve-bone stack did not create source Scythe interaction prompt")
        KeyCont.press_pick[_p.index]=true
        with(_p) {scrNTTEFullPromptPlayerStep();scrNTTEPlayerStep()}
        scrNTTESmokeLog("CRABBONE SCYTHE PROMPT DIAG "+json_stringify({weapon:_p.wep,
            ammo:scrNTTEFullValue(_p.ntte_state,"ammo",-999),promptExists:instance_exists(_prompt),
            promptPick:scrNTTEFullValue(_prompt,"pick",-999),index:_p.index,canPick:_p.can_pick,
            visible:_p.visible,unlocked:scrNTTEFullUnlockGet("wep:scythe"),pickups:instance_number(WepPickup),
            expectedPickups:_count,winner:scrNTTEFullPromptWinner(_p)}))
        assert(_p.wep==wep_ntte_bone_scythe && _p.ntte_state.ammo==40
            && !instance_exists(_prompt) && scrNTTEFullUnlockGet("wep:scythe")
            && instance_number(WepPickup)==_count,
            "Actual native interaction failed ten-bone Scythe conversion, two-spare chain drop/collect or unlock")
        // Quest-facing typed model interfaces do not manufacture a quest,
        // natural artifact, pickup or unlocked entry point.
        for(var _part=-1;_part<4;++_part) {
            var _model=scrNTTEFullCrabboneCreateModel(_part,1)
            assert(scrNTTEFullCrabboneIs(_model) && scrNTTEFullCrabbonePartIndex(_model)==_part
                && _model.type_index==_part+1 && _model.ammo_wep==wep_none,
                "Quest-facing Crabbone physical model lost source type_index/part mapping")
            scrNTTEFullCrabboneSetAmmo(_model,0)
            assert(scrNTTEFullCrabbonePartIndex(_model)==-1 && _model.ntte_native_state.ammo==0,
                "Quest-facing spent artifact ammo did not synchronize exact canonical state")
        }
        scrNTTESmokeLog("PASS ordinary Crabbone actual contact physical stack, exact top pop/safe native swap, intact nonimpact landings, cursed alternating BoneSlash, real12-to10 Scythe prompt/spare fragments; quest interfaces only")
    }
    finally {
        with(NTTEFullCrabboneBone) if(array_get_index(_before,id)<0) broken=true
        scrNTTEFullMergedRuntimeTestCleanup(_before)
        scrNTTEFullAreaGeneratorRestore(_players);scrNTTEFullAreaGeneratorRestore(_game)
        scrNTTEFullAreaGeneratorRestore(_keys);scrNTTEFullAreaGeneratorRestore(_uber)
        global.ntte_full_progress=_progress;current_frame=_frame;random_set_seed(_seed)
        ds_list_destroy(_skills)
    }
}

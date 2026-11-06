// Controlled actual native damage/registered BeginStep/Destroy inheritance.
// The first native BonePile must fail on the unfixed production baseline.
function scrNTTEFullSkeletonBoneDropNativeTests() {
    assert(os_type==os_windows && scrNTTEFullSmokeEnabled() && !instance_exists(GenCont)
        && !instance_exists(Menu) && instance_exists(GameCont) && instance_exists(Player),
        "Skeleton bone reward requires a settled explicit desktop room")
    var _snapshot=scrNTTEFullInstances(all),_game=scrNTTEFullAreaGeneratorSnapshot(GameCont),
        _players=scrNTTEFullAreaGeneratorSnapshot(Player),_back=scrNTTEFullAreaGeneratorSnapshot(BackCont),
        _particles=UberCont.opt_prtcls,_seed=random_get_seed(),_stop=lockstep_stop,_frame=current_frame,
        _rng_states=scrNTTEFullArrayCopy(global.rng_state),_p=instance_find(Player,0)
    try {
        lockstep_stop=false;current_frame=floor(current_frame)
        assert(current_frame_active,"Actual30/60 native skeleton fixture needs an active frame")
        GameCont.underwater=false;UberCont.opt_prtcls=true
        var _classes=[BonePile,NightBonePile,BigSkull,NTTEFullEelSkull]
        for(var _i=0;_i<array_length(_classes);++_i) {
            var _before=scrNTTEFullInstances(all),_target=instance_create(146000+_i*256,146000,_classes[_i]),
                _class=object_get_name(_classes[_i]),_initial_hp=_target.hp,
                _x=_target.x,_y=_target.y,_dead=_target.spr_dead,_size=_target.size,
                _sx=_target.image_xscale,_sy=_target.image_yscale,
                _pickups=instance_number(WepPickup),_corpses=instance_number(Corpse),_dust=instance_number(Dust)
            // A real nonlethal hit and inherited BeginStep must keep the prop
            // alive, with no premature reward, including both native2HP piles.
            with(_p) scr_hit(_target,1)
            assert(_target.hp==_initial_hp-1 && _target.hp>0,"Native skeleton nonlethal scr_hit was intercepted")
            with(_target) event_perform(ev_step,ev_step_begin)
            assert(instance_exists(_target) && instance_number(WepPickup)==_pickups,
                "Nonlethal native skeleton damage granted a premature bone: "+_class)
            var _remaining=_target.hp
            with(_p) scr_hit(_target,_remaining)
            assert(instance_exists(_target) && _target.hp<=0,"Native skeleton lethal scr_hit did not reach the original health gate")
            scrNTTESmokeLog("SKELETON BONE BEFORE REGISTERED BEGIN STEP "+_class+" @"+string(30/timescale))
            with(_target) event_perform(ev_step,ev_step_begin)
            assert(!instance_exists(_target),"Registered native prop BeginStep did not dispatch lethal Destroy: "+_class)
            assert(instance_number(WepPickup)==_pickups+1,
                "Native skeleton lethal scr_hit + registered BeginStep must drop exactly one ordinary BONE: "+_class)
            var _bones=0,_matching_corpses=0
            with(WepPickup) if(array_get_index(_before,id)<0) {
                ++_bones
                assert(sprite_index==scrNTTERefSprite("Bone") && name==scr_weapon_get_name(wep_ntte_bone)
                    && type==Ammo.None,"Real bone death pickup retained screwdriver sprite/name/type: "+_class)
                assert(object_index==WepPickup && wep==wep_ntte_bone && x==_x && y==_y
                    && speed>=1.5*timescale-0.0001 && speed<=4.5*timescale+0.0001,
                    "Skeleton reward lost native WepPickup/raw bone/death position/additive motion3: "+_class)
            }
            with(Corpse) if(array_get_index(_before,id)<0) {
                if(sprite_index==_dead && x==_x && y==_y && size==_size
                    && image_xscale==_sx && image_yscale==_sy) { _matching_corpses+=1 }
            }
            assert(_bones==1 && instance_number(Corpse)==_corpses+1 && _matching_corpses==1,
                "Skeleton reward replaced/duplicated native corpse or actual reward: "+_class)
            assert(instance_number(Dust)==_dust+(_i>=2?12:2),
                "Skeleton reward lost original twoDust or inherited BigSkull tenDust: "+_class)
            // Eel keeps its previously installed child reward unchanged. The
            // ordinary piles use exact source fx origins and additive motion3.
            if(_i<2) with(Dust) if(array_get_index(_before,id)<0) {
                assert(x==_x && y==_y && speed>=1*timescale-0.0001 && speed<=5*timescale+0.0001,
                    "Ordinary skeleton twoDust lost exact source fx origin/additive motion3")
            }
            scrNTTESmokeLog("SKELETON BONE REAL DEATH "+_class+" one raw WepPickup + native corpse + source Dust OK")
            scrNTTEFullMergedRuntimeTestCleanup(_before)

            // Ordinary positive-HP destruction must never fabricate a reward.
            _before=scrNTTEFullInstances(all)
            _target=instance_create(147000+_i*256,147000,_classes[_i]);_pickups=instance_number(WepPickup)
            assert(_target.hp>0,"Positive-HP destruction fixture did not start alive")
            with(_target) instance_destroy()
            assert(!instance_exists(_target) && instance_number(WepPickup)==_pickups,
                "Direct positive-HP destruction incorrectly rewarded a bone: "+_class)
            scrNTTEFullMergedRuntimeTestCleanup(_before)

            // Genuine lethal damage followed by engine cleanup(false) bypasses
            // all Destroy events, matching room cleanup and avoiding free loot.
            _before=scrNTTEFullInstances(all)
            _target=instance_create(148000+_i*256,148000,_classes[_i]);_pickups=instance_number(WepPickup)
            var _hp=_target.hp
            with(_p) scr_hit(_target,_hp)
            assert(_target.hp<=0,"Destroy(false) fixture lacks actual lethal damage")
            instance_destroy(_target,false)
            assert(!instance_exists(_target) && instance_number(WepPickup)==_pickups,
                "Destroy(false) cleanup incorrectly ran a skeleton reward: "+_class)
            scrNTTEFullMergedRuntimeTestCleanup(_before)
        }
        // An unrelated ordinary native prop follows the same damage/BeginStep
        // chain, but must remain outside the exact source skeleton family.
        var _before=scrNTTEFullInstances(all),_target=instance_create(149000,149000,WaterPlant),
            _pickups=instance_number(WepPickup),_hp=_target.hp
        with(_p) scr_hit(_target,_hp)
        with(_target) event_perform(ev_step,ev_step_begin)
        assert(!instance_exists(_target) && instance_number(WepPickup)==_pickups,
            "Unrelated native prop lethal BeginStep incorrectly rewarded a bone")
        scrNTTEFullMergedRuntimeTestCleanup(_before)
        // Optional particles must not gate a real weapon reward. Dust.Create
        // genuinely destroys each attempted effect before returning its handle.
        UberCont.opt_prtcls=false
        var _before=scrNTTEFullInstances(all),_target=instance_create(149500,149500,BonePile),
            _pickups=instance_number(WepPickup),_dust=instance_number(Dust),_hp=_target.hp,
            _x=_target.x,_y=_target.y,_bones=0
        with(_p) scr_hit(_target,_hp)
        with(_target) event_perform(ev_step,ev_step_begin)
        assert(!instance_exists(_target) && instance_number(WepPickup)==_pickups+1 && instance_number(Dust)==_dust,
            "Real lethal BonePile with particles disabled lost its one reward or retained dead Dust")
        with(WepPickup) if(array_get_index(_before,id)<0) {
            if(wep==wep_ntte_bone && x==_x && y==_y) { _bones+=1 }
        }
        assert(_bones==1,"Particles-disabled native reward is not the actual ordinary bone")
        scrNTTESmokeLog("SKELETON BONE REAL DEATH particles disabled: exactly one ordinary bone and zero Dust OK")
        scrNTTEFullMergedRuntimeTestCleanup(_before)
    }
    finally {
        scrNTTEFullMergedRuntimeTestCleanup(_snapshot)
        scrNTTEFullAreaGeneratorRestore(_game);scrNTTEFullAreaGeneratorRestore(_players)
        scrNTTEFullAreaGeneratorRestore(_back)
        global.rng_state=_rng_states;UberCont.opt_prtcls=_particles
        lockstep_stop=_stop;current_frame=_frame;random_set_seed(_seed)
    }
    scrNTTEFullMaggotBoneDropTests()
    scrNTTESmokeLog("SKELETON BONE DROP actual native scr_hit + registered BeginStep for BonePile/NightBonePile/BigSkull/EelSkull exactly once, native corpse/twoDust/BigSkull10Dust, particles-off reward, nonlethal/direct-live/destroy(false)/unrelated negatives OK @"+string(30/timescale)+"; controlled callbacks, natural campaign/iPhone untested")
}

// User-requested nest reward: true death only, once per nest. Keep all of
// the existing nest damage/clamp/death behavior and ordinary drops intact.
function scrNTTEFullMaggotBoneDropTests() {
    scrNTTEFullWeaponNativeInit()
    var _before=scrNTTEFullInstances(all),_game=scrNTTEFullAreaGeneratorSnapshot(GameCont),
        _players=scrNTTEFullAreaGeneratorSnapshot(Player),_p=instance_find(Player,0),
        _seed=random_get_seed(),_frame=current_frame,_stop=lockstep_stop,
        _rng=scrNTTEFullArrayCopy(global.rng_state),_models=scrNTTEFullArrayCopy(global.ntte_full_native_weapon_models)
    try {
        lockstep_stop=false;current_frame=floor(current_frame);GameCont.underwater=false
        var _classes=[MaggotSpawn,NTTEMaggotNest,NTTEFullBigMaggotSpawn]
        for(var _i=0;_i<array_length(_classes);++_i) {
            var _base=scrNTTEFullInstances(all),_target=instance_create(188000+_i*256,188000,_classes[_i]),
                _kind=object_get_name(_classes[_i]),_hp=_target.hp,_count=scrNTTEFullTestOrdinaryBoneCount()
            with(_p) scr_hit(_target,1)
            assert(instance_exists(_target) && _target.hp>0 && _target.hp<_hp
                && scrNTTEFullTestOrdinaryBoneCount()==_count,"Nonlethal nest damage dropped bone: "+_kind)
            instance_destroy(_target,false)
            assert(scrNTTEFullTestOrdinaryBoneCount()==_count,"Nest replacement/cleanup(false) dropped a bone: "+_kind)
            scrNTTEFullMergedRuntimeTestCleanup(_base)

            _base=scrNTTEFullInstances(all);_target=instance_create(188000+_i*256,188128,_classes[_i])
            _count=scrNTTEFullTestOrdinaryBoneCount()
            with(_target) instance_destroy()
            assert(!instance_exists(_target) && scrNTTEFullTestOrdinaryBoneCount()==_count,
                "Direct live nest destruction granted a bone: "+_kind)
            scrNTTEFullMergedRuntimeTestCleanup(_base)

            _base=scrNTTEFullInstances(all);_target=instance_create(188000+_i*256,188256,_classes[_i])
            _count=scrNTTEFullTestOrdinaryBoneCount();_hp=_target.hp
            var _x=_target.x,_y=_target.y
            with(_p) scr_hit(_target,_hp+10)
            if(_i==2) assert(_target.hp==1,"Giant nest original lethal clamp was removed")
            else assert(_target.hp<=0,"Ordinary nest fixture did not receive true lethal damage")
            var _steps=0
            while(instance_exists(_target) && _steps<600) {
                with(_target) event_perform(ev_step,ev_step_normal)
                current_frame+=timescale;_steps++
            }
            assert(!instance_exists(_target),"Actual nest Step did not finish original death: "+_kind)
            var _bones=0
            with(WepPickup) if(array_get_index(_base,id)<0 && wep==wep_ntte_bone) {
                assert(wep==wep_ntte_bone && sprite_index==scrNTTERefSprite("Bone")
                    && name==scr_weapon_get_name(wep_ntte_bone) && type==Ammo.None
                    && x==_x && y==_y,"Nest bone has wrong native art/name/type/position: "+_kind)
                _bones++
            }
            assert(_bones<=1 && scrNTTEFullTestOrdinaryBoneCount()==_count+_bones,
                "True nest death duplicated its optional ordinary bone: "+_kind)
            // Real pickup Step and Draw must retain bone artwork, not restore
            // the default screwdriver before the player reaches the reward.
            with(WepPickup) if(array_get_index(_base,id)<0 && wep==wep_ntte_bone) {
                event_perform(ev_step,ev_step_normal)
                assert(sprite_index==scrNTTERefSprite("Bone") && wep==wep_ntte_bone,
                    "Actual pickup Step reverted newly dropped nest bone artwork")
            }
            scrNTTESmokeLog("MAGGOT BONE REAL DEATH "+_kind+" bones="+string(_bones)+", original clamp/Step="+string(_steps)+", live and cleanup negatives OK")
            scrNTTEFullMergedRuntimeTestCleanup(_base)

            // Compare exact seeded 20% eligibility, then repeat the callback
            // to prove that misses cannot reroll and hits cannot duplicate.
            var _hits=0,_misses=0
            for(var _trial=1;_trial<=32;++_trial) {
                _base=scrNTTEFullInstances(all)
                _target=instance_create(188000+_i*256,188512,_classes[_i]);_target.hp=0
                _count=scrNTTEFullTestOrdinaryBoneCount()
                var _caseSeed=7117+_trial*103
                random_set_seed(_caseSeed);var _expected=(random(1)<0.2)
                random_set_seed(_caseSeed)
                with(_target) scrNTTEFullSkeletonBoneDropNative()
                assert(_target.ntte_full_bone_drop_done
                    && scrNTTEFullTestOrdinaryBoneCount()==_count+_expected,
                    "Nest reward differs from requested seeded 20% threshold: "+_kind)
                if(_expected) _hits++;else _misses++
                var _afterRoll=random_get_seed()
                repeat(3) with(_target) scrNTTEFullSkeletonBoneDropNative()
                assert(random_get_seed()==_afterRoll
                    && scrNTTEFullTestOrdinaryBoneCount()==_count+_expected,
                    "Repeated nest callback rerolled a miss or duplicated a reward: "+_kind)
                scrNTTEFullMergedRuntimeTestCleanup(_base)
            }
            assert(_hits>0 && _misses>0,"Seeded nest reward fixture missed a probability branch")
        }
        var _base=scrNTTEFullInstances(all),_other=instance_create(189000,189000,Bandit),_count=scrNTTEFullTestOrdinaryBoneCount()
        with(_p) scr_hit(_other,_other.hp+10)
        with(_other) event_perform(ev_step,ev_step_normal)
        assert(!instance_exists(_other) && scrNTTEFullTestOrdinaryBoneCount()==_count,"Unrelated enemy death gained a nest bone")
        scrNTTEFullMergedRuntimeTestCleanup(_base)
    } finally {
        scrNTTEFullMergedRuntimeTestCleanup(_before)
        scrNTTEFullAreaGeneratorRestore(_game);scrNTTEFullAreaGeneratorRestore(_players)
        global.ntte_full_native_weapon_models=_models;global.rng_state=_rng
        current_frame=_frame;lockstep_stop=_stop;random_set_seed(_seed)
    }
    scrNTTESmokeLog("USER NEST BONE actual MaggotSpawn/NTTEMaggotNest/giant death, exact seeded20% gate, no repeat rolls, real sprite/name/type, nonlethal/live/cleanup/unrelated negatives @"+string(30/timescale))
}
// Native nests retain their original random weapon drops as well as the new
// bone. Count the requested reward separately from those untouched drops.
function scrNTTEFullTestOrdinaryBoneCount() {
    var _count=0
    with(WepPickup) if(wep==wep_ntte_bone) _count++
    return _count
}

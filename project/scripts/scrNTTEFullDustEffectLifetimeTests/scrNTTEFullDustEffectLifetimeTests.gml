// Focused controlled native-constructor/caller regression, not campaign proof.
// Sentinel is an inert GenCont descendant: it certifies native instance_exists
// ancestry gating only, not actual generation or a room transition.
function scrNTTEFullDustEffectLifetimeTests() {
    assert(os_type==os_windows && scrNTTEFullSmokeEnabled() && !instance_exists(GenCont)
        && instance_exists(GameCont),"Dust lifetime tests require a settled Windows native room")
    var _snapshot=scrNTTEFullInstances(all),_game=scrNTTEFullAreaGeneratorSnapshot(GameCont),
        _back=scrNTTEFullAreaGeneratorSnapshot(BackCont),_rng_states=scrNTTEFullArrayCopy(global.rng_state),
        _particles=UberCont.opt_prtcls,_seed=random_get_seed(),_stop=lockstep_stop
    try {
        lockstep_stop=false
        var _modes=["ground alive","particles disabled","underwater Bubble replacement","GenCont ancestry gate","Coast no-Floor replacement"]
        for(var _mode=0;_mode<array_length(_modes);++_mode) {
            var _before=scrNTTEFullInstances(all),_sentinel=noone,_x=46000+_mode*128,_y=46000
            GameCont.area=area_desert;GameCont.lastarea=area_desert;GameCont.subarea=1
            GameCont.ntte_full_active_coast=false;GameCont.underwater=(_mode==2)
            UberCont.opt_prtcls=(_mode!=1)
            if(_mode==3) {
                _sentinel=instance_create(_x,_y,NTTEFullDustLifetimeGenSentinel)
                assert(instance_exists(GenCont),"Native Dust generation guard did not see real descendant ancestry")
            }
            if(_mode==4) {
                GameCont.area=scrNTTEFullAreaId("coast");GameCont.lastarea=GameCont.area
                GameCont.ntte_full_active_coast=true
                // Constructor effects belong to the real nonpersistent Coast
                // scene. A historical active flag alone also exists in Vaults.
                scrNTTEFullCoastSeaEnsure()
                assert(!position_meeting(_x,_y,Floor) && scrNTTEFullCoastConstructActive(),
                    "Coast constructor probe did not activate original no-Floor replacement")
            }
            var _baseline=scrNTTEFullInstances(all),_bubbles=instance_number(Bubble),_dust=instance_create(_x,_y,Dust)
            assert(instance_exists(_dust)==(_mode==0),"Actual Dust constructor lifetime differs: "+_modes[_mode])
            assert(instance_number(Bubble)==_bubbles+(_mode==2?1:0),"Native underwater Dust replacement count differs")
            if(_mode==4) assert(instance_number(all)>array_length(_baseline),"Original Coast callback omitted replacement effect")
            scrNTTESmokeLog("DUST LIFETIME ACTUAL CONSTRUCTOR "+_modes[_mode]+" returned="+string(_dust)+" live="+string(instance_exists(_dust)))
            scrNTTEFullMergedRuntimeTestCleanup(_baseline)

            // Run the actual repaired chest appearance helper on a controlled
            // native actor. It uses only native x/y/depth and creates8Dust.
            var _actor=instance_create(_x,_y,Bandit),_actor_id=_actor.id
            _actor.depth=-17;_actor.feather_ammo=0;_actor.feather_ammo_max=4
            var _effects=scrNTTEFullInstances(all),_dust_count=instance_number(Dust),_bubbles=instance_number(Bubble)
            with(_actor) scrNTTEFullBeetleChestDust(0,360)
            assert(instance_exists(_actor) && _actor.id==_actor_id && _actor.depth==-17,
                "Lifetime guard changed actual caller identity/depth")
            assert(instance_number(Dust)==_dust_count+(_mode==0?8:0)
                && instance_number(Bubble)==_bubbles+(_mode==2?8:0),"Real Beetle appearance helper changed constructor effects")
            if(_mode==0) {
                var _found=0
                with(Dust) if(array_get_index(_effects,id)<0) {
                    assert(depth==-18 && speed==3*timescale,"Live Dust source speed/depth changed")
                    _found++
                }
                assert(_found==8,"Live source appearance helper did not retain eight real Dust instances")
            }
            scrNTTEFullMergedRuntimeTestCleanup(_effects)

            // Real original ParrotFeather Step reaches its creator, executes
            // Dust then continues to refund exactly one round and deletes the
            // physical feather. No direct Step helper or manual refund.
            var _feather=instance_create(_x,_y,NTTEFullParrotFeather)
            _feather.creator=_actor;_feather.target=_actor
            var _dust_count=instance_number(Dust),_bubbles=instance_number(Bubble)
            with(_feather) event_perform(ev_step,ev_step_normal)
            assert(!instance_exists(_feather) && _actor.feather_ammo==1,
                "Real ParrotFeather Step failed return/refund after its optional Dust")
            assert(instance_number(Dust)==_dust_count+(_mode==0?1:0)
                && instance_number(Bubble)==_bubbles+(_mode==2?1:0),"Real feather return changed native constructor effects")

            // Different callback scope: the actual TopObject EndStep destroys
            // the wrapper and its original Destroy restores the target inside
            // nested with(target), then adds inherited motion/depth to Dust.
            var _mask=_actor.mask_index,_shadow=_actor.spr_shadow
            _actor.alarm[1]=17
            var _wrapper=scrNTTEFullTopCreate(_actor.x,_actor.y,_actor,0,0)
            assert(instance_exists(_wrapper) && _wrapper.target==_actor && _actor.mask_index==mskNone,
                "Real top wrapper did not suspend the native target")
            _wrapper.z=0;_wrapper.zspeed=0;_wrapper.zfriction=0
            var _dust_count=instance_number(Dust),_bubbles=instance_number(Bubble)
            with(_wrapper) event_perform(ev_step,ev_step_end)
            assert(!instance_exists(_wrapper) && instance_exists(_actor) && _actor.mask_index==_mask
                && _actor.spr_shadow==_shadow && _actor.alarm[1]==17 && _actor.ntte_full_top_object==noone,
                "Real nested TopObject.Destroy failed native target identity/mask/shadow/alarm restoration")
            assert((_mode==0?instance_number(Dust)>_dust_count:instance_number(Dust)==_dust_count)
                && (_mode==2?instance_number(Bubble)>_bubbles:instance_number(Bubble)==_bubbles),
                "Real top landing changed native Dust/Bubble constructor branch")
            scrNTTESmokeLog("DUST LIFETIME REAL CALLERS Beetle8 appearance + native ParrotFeather.Step one refund + native TopObject.EndStep/Destroy nested target restore "+_modes[_mode])
            scrNTTEFullMergedRuntimeTestCleanup(_before)
        }
    }
    finally {
        scrNTTEFullMergedRuntimeTestCleanup(_snapshot)
        scrNTTEFullAreaGeneratorRestore(_game);scrNTTEFullAreaGeneratorRestore(_back)
        global.rng_state=_rng_states
        UberCont.opt_prtcls=_particles;lockstep_stop=_stop;random_set_seed(_seed)
    }
    scrNTTESmokeLog("DUST EFFECT LIFETIME actual constructors alive/off/underwater/GenCont ancestry/Coast no-Floor + actual source appearance helper/native feather return/native nested top landing OK; other25 caller branches/natural campaign/iPhone not certified")
}

// Synchronous real native event regression, independent of combat difficulty.
// Run under the normal dedicated Windows 30 and 60 smoke profiles.
function scrNTTEFullTrenchCompletionPreventNativeTests() {
    assert(os_type==os_windows && scrNTTEFullSmokeEnabled() && scrNTTESmokeEnabled() && !lockstep_stop,
        "Completion prevent regression requires dedicated unpaused Windows smoke")
    assert(30/timescale==30 || 30/timescale==60,"Completion prevent regression needs actual 30/60 profile")
    var _state=scrNTTEFullVanillaFixtureBegin(),_players=scrNTTEFullAreaGeneratorSnapshot(Player),
        _uber=scrNTTEFullAreaGeneratorSnapshot(UberCont),_progress=global.ntte_full_progress,
        _directory=game_directory,_scratch=working_directory+"trench-completion-prevent-"+string(get_timer())+"/",
        _clock=current_frame,_lockstep=lockstep_stop,_extra=scrNTTEFullInstances([Portal,CorpseActive,becomenemy,LastDie,YungCuz,NTTEFullPet,NTTEFullPortalPrevent])
    directory_create(_scratch);game_directory=_scratch
    global.ntte_full_progress=json_parse(json_stringify(_progress))
    for(var _i=0;_i<array_length(_extra);++_i) instance_deactivate_object(_extra[_i])
    GameCont.rad=0;GameCont.killenemies=0;GameCont.crown=crwn_none
    try {
        // Trench first: the unchanged pre-fix production helper fails its first
        // actual native Step here while the real staged-death guard is alive.
        var _keys=["trench","coast","oasis","lair","red"]
        for(var _i=0;_i<array_length(_keys);++_i) {
            var _key=_keys[_i],_unlock="pack:"+_key
            GameCont.area=scrNTTEFullAreaId(_key);GameCont.subarea=scrNTTEFullAreaInfo(_key).subareas
            variable_struct_set(global.ntte_full_progress.unlocks,_unlock,false)
            var _owner=instance_create(98000,98000,NTTEDesertDecor),
                _guard=instance_create(98000,98000,NTTEFullPortalPrevent)
            _guard.creator=_owner
            assert(!instance_is(_guard,becomenemy) && !instance_exists(enemy) && !instance_exists(becomenemy)
                && !instance_exists(CorpseActive) && !instance_exists(Portal)
                && !instance_exists(GenCont) && !instance_exists(LevCont) && instance_exists(Player),
                "Completion prevent regression did not isolate the actual lost becomenemy identity")
            with(_guard) event_perform(ev_step,ev_step_normal)
            assert(instance_exists(_guard) && _guard.creator==_owner,"Native guard prematurely released its living owner")
            scrNTTESmokeLog("COMPLETION PREVENT REAL STEP before "+json_stringify({area:_key,rate:30/timescale,
                owner:_owner,guard:_guard,native_becomenemy:instance_is(_guard,becomenemy),portal:instance_exists(Portal)}))
            with(GameCont) event_perform(ev_step,ev_step_normal)
            assert(!scrNTTEFullUnlockGet(_unlock),"Actual native completion awarded pack while source PortalPrevent is alive: "+_key)
            with(GameCont) event_perform(ev_step,ev_step_normal)
            assert(instance_exists(_guard) && !scrNTTEFullUnlockGet(_unlock),"Repeated actual native Step bypassed source completion guard: "+_key)

            // Preserve the exact authored alternative: an existing Portal wins
            // even while enemy/becomenemy-equivalent guards remain alive.
            var _portal=instance_create(98128,98000,Portal)
            with(GameCont) event_perform(ev_step,ev_step_normal)
            assert(instance_exists(_guard) && scrNTTEFullUnlockGet(_unlock),"Source Portal alternative was changed by completion guard: "+_key)
            instance_destroy(_portal,false)
            variable_struct_set(global.ntte_full_progress.unlocks,_unlock,false)
            with(GameCont) event_perform(ev_step,ev_step_normal)
            assert(!scrNTTEFullUnlockGet(_unlock),"Source completion guard failed again after Portal removal: "+_key)
            // Require a fresh real write after release, rather than accepting
            // the earlier Portal-alternative write as persistence evidence.
            var _prior_files=["ntte-full-progress.json","ntte-full-progress.json.bak","ntte-full-progress.json.tmp"]
            for(var _j=0;_j<array_length(_prior_files);++_j)
                if(file_exists(_scratch+_prior_files[_j])) file_delete(_scratch+_prior_files[_j])

            // Real native guard Step releases only after its creator is gone;
            // the fixture does not directly destroy the guard or fake a boss.
            instance_destroy(_owner,false)
            with(_guard) event_perform(ev_step,ev_step_normal)
            assert(!instance_exists(_guard),"Actual guard Step did not release its absent creator: "+_key)
            if(_key=="trench") {
                // Controlled shared freeze gate only; this does not simulate
                // menu pause or start a cooperative controller.
                lockstep_stop=true
                with(GameCont) event_perform(ev_step,ev_step_normal)
                assert(!scrNTTEFullUnlockGet(_unlock),"Explicit shared freeze guard GameCont Step awarded completion")
                lockstep_stop=_lockstep
                assert(!lockstep_stop,"Shared freeze fixture failed to restore normal native Step")
            }
            with(GameCont) event_perform(ev_step,ev_step_normal)
            assert(scrNTTEFullUnlockGet(_unlock),"Actual completion failed after native source guard release: "+_key)
            global.ntte_full_progress={schema:1,unlocks:{},loadouts:{},stats:{}}
            assert(scrNTTEFullProgressLoad() && scrNTTEFullUnlockGet(_unlock),"Released source completion pack did not persist through native default progress load: "+_key)
            scrNTTESmokeLog("COMPLETION PREVENT REAL RELEASE "+json_stringify({area:_key,rate:30/timescale,
                owner_alive:instance_exists(_owner),guard_alive:instance_exists(_guard),pack:scrNTTEFullUnlockGet(_unlock)}))
            scrNTTEFullCavesFixtureCleanup(_state.baseline)
        }
    }
    finally {
        lockstep_stop=_lockstep
        scrNTTEFullAreaGeneratorRestore(_players);scrNTTEFullAreaGeneratorRestore(_uber)
        scrNTTEFullVanillaFixtureEnd(_state)
        for(var _i=0;_i<array_length(_extra);++_i) instance_activate_object(_extra[_i])
        global.ntte_full_progress=_progress;game_directory=_directory;current_frame=_clock
        var _files=["ntte-full-progress.json","ntte-full-progress.json.bak","ntte-full-progress.json.tmp"]
        for(var _i=0;_i<array_length(_files);++_i) if(file_exists(_scratch+_files[_i])) file_delete(_scratch+_files[_i])
    }
    scrNTTESmokeLog("PASS COMPLETION PREVENT native actual GameCont.Step; live original-becomenemy-equivalent guard blocks all five final-subarea packs; repeated dispatch; exact Portal alternative; real creator-destroy/native guard-Step release; Trench explicit shared freeze guard; actual default progress persistence @"+string(30/timescale)+"; scoped event regression, no combat victory or continuous campaign claim")
}

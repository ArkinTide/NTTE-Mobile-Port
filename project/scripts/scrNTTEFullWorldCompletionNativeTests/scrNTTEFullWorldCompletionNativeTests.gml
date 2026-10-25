function scrNTTEFullWorldCompletionNativeTests() {
    assert(scrNTTESmokeEnabled() && !lockstep_stop,"Completion native Step fixture needs explicit unpaused desktop smoke harness")
    var _state=scrNTTEFullVanillaFixtureBegin(),_players=scrNTTEFullAreaGeneratorSnapshot(Player),
        _uber=scrNTTEFullAreaGeneratorSnapshot(UberCont),_progress=global.ntte_full_progress,
        _gameDirectory=game_directory,_scratch=working_directory+"world-completion-native-fixture/",
        _extra=scrNTTEFullInstances([Portal,CorpseActive,becomenemy,LastDie,YungCuz,NTTEFullPet]),
        _playerIds=scrNTTEFullInstances(Player)
    directory_create(_scratch);game_directory=_scratch
    global.ntte_full_progress=json_parse(json_stringify(_progress))
    for(var _i=0;_i<array_length(_extra);++_i) instance_deactivate_object(_extra[_i])
    GameCont.rad=0;GameCont.killenemies=0;GameCont.crown=crwn_none
    try {
        var _keys=["coast","oasis","trench","lair","red"]
        for(var _i=0;_i<array_length(_keys);++_i) {
            var _key=_keys[_i],_unlock="pack:"+_key,_max=scrNTTEFullAreaInfo(_key).subareas
            GameCont.area=scrNTTEFullAreaId(_key);GameCont.subarea=_max-1
            global.ntte_full_progress.unlocks[$ _unlock]=false
            with(GameCont) event_perform(ev_step,ev_step_normal)
            assert(!scrNTTEFullUnlockGet(_unlock),"Actual native Step unlocked custom area pack before its source final subarea: "+_key)
            GameCont.subarea=_max
            var _bandit=instance_create(98000,98000,Bandit)
            with(GameCont) event_perform(ev_step,ev_step_normal)
            assert(!scrNTTEFullUnlockGet(_unlock),"Actual native Step unlocked uncleared area pack with live enemy and no Portal: "+_key)
            instance_destroy(_bandit,false)
            var _pending=instance_create(98000,98000,becomenemy)
            with(GameCont) event_perform(ev_step,ev_step_normal)
            assert(!scrNTTEFullUnlockGet(_unlock),"Source pending-become-enemy blocker was lost: "+_key)
            instance_destroy(_pending,false)
            var _corpse=instance_create(98000,98000,CorpseActive)
            with(GameCont) event_perform(ev_step,ev_step_normal)
            assert(!scrNTTEFullUnlockGet(_unlock),"Source active corpse blocker was lost: "+_key)
            instance_destroy(_corpse,false)
            with(GameCont) event_perform(ev_step,ev_step_normal)
            assert(scrNTTEFullUnlockGet(_unlock),"Actual native Step failed source last-subarea enemy/become/corpse-free completion: "+_key)
            // The actual default progress file, rather than a custom helper
            // path, must already contain this natural unlock before RoomEnd.
            global.ntte_full_progress={schema:1,unlocks:{},loadouts:{},stats:{}}
            assert(scrNTTEFullProgressLoad() && scrNTTEFullUnlockGet(_unlock),
                "Source completed-area pack did not persist through actual default progress save/load: "+_key)
            scrNTTEFullCavesFixtureCleanup(_state.baseline)
        }

        GameCont.area=scrNTTEFullAreaId("lair");GameCont.subarea=1
        global.ntte_full_progress.unlocks[$ "pack:lair"]=false
        var _bandit=instance_create(98000,98000,Bandit),_portal=instance_create(98128,98000,Portal)
        with(GameCont) event_perform(ev_step,ev_step_normal)
        assert(instance_exists(_bandit) && scrNTTEFullUnlockGet("pack:lair"),
            "Actual source Portal alternative must unlock even while an enemy is still alive")
        scrNTTEFullCavesFixtureCleanup(_state.baseline)

        global.ntte_full_progress.unlocks[$ "pack:lair"]=false
        for(var _i=0;_i<array_length(_playerIds);++_i) instance_deactivate_object(_playerIds[_i])
        with(GameCont) event_perform(ev_step,ev_step_normal)
        assert(!scrNTTEFullUnlockGet("pack:lair"),"Source completion unlocked without any actual living Player")
        for(var _i=0;_i<array_length(_playerIds);++_i) instance_activate_object(_playerIds[_i])

        // Exercise genuine generator/level-up objects, including their native
        // constructors. They block completion until their real phase ends.
        var _gen=instance_create(98000,98000,GenCont)
        with(GameCont) event_perform(ev_step,ev_step_normal)
        assert(!scrNTTEFullUnlockGet("pack:lair"),"Actual GenCont failed to block pre-generation pack completion")
        scrNTTEFullCavesFixtureCleanup(_state.baseline)
        var _lev=instance_create(0,0,LevCont)
        with(GameCont) event_perform(ev_step,ev_step_normal)
        assert(!scrNTTEFullUnlockGet("pack:lair"),"Actual LevCont failed to block pack completion")
        scrNTTEFullCavesFixtureCleanup(_state.baseline)

        GameCont.area=scrNTTEFullAreaId("pizza");GameCont.subarea=1
        global.ntte_full_progress.unlocks[$ "pack:pizza"]=false
        with(GameCont) event_perform(ev_step,ev_step_normal)
        assert(!scrNTTEFullUnlockGet("pack:pizza"),"Source intentionally absent Pizza completion pack was invented")
        GameCont.area=area_desert;GameCont.subarea=3
        global.ntte_full_progress.unlocks[$ "pack:desert"]=false
        with(GameCont) event_perform(ev_step,ev_step_normal)
        assert(!scrNTTEFullUnlockGet("pack:desert"),"Source native main area incorrectly awarded a custom area pack")
    }
    finally {
        for(var _i=0;_i<array_length(_playerIds);++_i) instance_activate_object(_playerIds[_i])
        scrNTTEFullAreaGeneratorRestore(_players);scrNTTEFullAreaGeneratorRestore(_uber)
        scrNTTEFullVanillaFixtureEnd(_state)
        for(var _i=0;_i<array_length(_extra);++_i) instance_activate_object(_extra[_i])
        global.ntte_full_progress=_progress
        var _files=[_scratch+"ntte-full-progress.json",_scratch+"ntte-full-progress.json.bak",_scratch+"ntte-full-progress.json.tmp"]
        for(var _i=0;_i<array_length(_files);++_i) if(file_exists(_files[_i])) file_delete(_files[_i])
        game_directory=_gameDirectory
    }
    scrNTTESmokeLog("FULL WORLD COMPLETION: actual native common Step and default-file persistence for source Coast/Oasis/Trench/Lair/Red final-subarea packs; true enemy/become/corpse blockers, Portal alternative, live Player/GenCont/LevCont gates and intentional Pizza/native-area exclusions OK @"+string(30/timescale))
}

// Real native entity events: custom source IDs must not look up nonexistent
// sprCrown14..16 atlases. Default rendering uses the sprite selected by Step.
function scrNTTEFullCrownObjectNativeTests() {
    var _oldCrown=GameCont.crown,_oldSeed=random_get_seed(),_created=[],_frames=[15,20,10]
    try {
        for(var _c=1;_c<=16;++_c) {
            GameCont.crown=_c
            var _crown=instance_create(Player.x,Player.y,CrownObject)
            array_push(_created,_crown)
            with(_crown) event_perform(ev_alarm,2)
            var _idle=_c>=14?scrNTTEFullCrownSprite(_c,"Idle"):asset_get_index("sprCrown"+string(_c)+"Idle"),
                _walk=_c>=14?scrNTTEFullCrownSprite(_c,"Walk"):asset_get_index("sprCrown"+string(_c)+"Walk")
            assert(sprite_exists(_idle) && sprite_exists(_walk) && _crown.visible
                && _crown.crown==_c && _crown.spr_idle==_idle && _crown.spr_walk==_walk && _crown.sprite_index==_idle,
                "Actual CrownObject.Alarm2 omitted source idle/walk or changed native art: "+string(_c))
            if(_c>=14) assert(sprite_get_number(_idle)==_frames[_c-14] && sprite_get_number(_walk)==6
                && sprite_get_xoffset(_idle)==8 && sprite_get_yoffset(_idle)==8
                && sprite_get_xoffset(_walk)==8 && sprite_get_yoffset(_walk)==8,
                "Physical custom crown changed original authored frames/origin")
            with(_crown) {speed=0;walk=0;event_perform(ev_step,ev_step_normal)}
            assert(_crown.sprite_index==_idle,"Real resting crown Step did not select actual source idle art")
            with(_crown) {speed=timescale;event_perform(ev_step,ev_step_normal)}
            assert(_crown.sprite_index==_walk,"Real moving crown Step did not select actual source walk art")
            instance_destroy(_crown,false)
        }
    }
    finally {
        for(var _i=0;_i<array_length(_created);++_i) if(instance_exists(_created[_i])) instance_destroy(_created[_i],false)
        GameCont.crown=_oldCrown
        random_set_seed(_oldSeed)
    }
    scrNTTESmokeLog("CROWN OBJECT: actual constructor/Alarm2/idle+moving native Step, source three custom frame counts+origins and all thirteen native crowns OK @"+string(30/timescale))
}
function scrNTTEFullCrownLoadoutNativeTests() {
    assert(scrNTTESmokeEnabled(),"Crown loadout persistence fixture requires explicit smoke harness")
    var _progress=global.ntte_full_progress,_ready=variable_global_exists("ntte_full_feature_ready")?global.ntte_full_feature_ready:undefined,
        _game=scrNTTEFullAreaGeneratorSnapshot(GameCont),_gameDirectory=game_directory,
        _scratch=working_directory+"crown-loadout-native-fixture/",
        _fish=UberCont.cgot[Race.Fish],_crystal=UberCont.cgot[Race.Crystal],
        _key="ccrown_"+string(Race.Fish),_had=ds_map_exists(UberCont.saveData,_key),
        _saved=_had?UberCont.saveData[? _key]:undefined,
        _crowns=UberCont.crowngot[Race.Fish]
    directory_create(_scratch);game_directory=_scratch
    global.ntte_full_progress=json_parse(json_stringify(_progress))
    global.ntte_full_feature_ready=is_struct(_ready)?json_parse(json_stringify(_ready)):{}
    UberCont.cgot[Race.Fish]=true;UberCont.cgot[Race.Crystal]=true
    try {
        scrNTTEFullCrownObjectNativeTests()
        for(var _c=14;_c<=16;++_c) {
            var _name=scrNTTEFullCrownKey(_c)
            global.ntte_full_feature_ready[$ "crown:"+_name]=false
            global.ntte_full_progress.unlocks[$ "loadout:crown:"+_name]=true
            assert(array_get_index(scrNTTEFullCrownLoadoutSlots(),_c)<0
                && !scr_loadout_race_is_crown_unlocked(Race.Fish,_c)
                && !scr_loadout_race_set_start_crown(Race.Fish,_c),
                "Closed source custom crown gate leaked into native menu/select chain")
            save_set_value("ccrown",Race.Fish,_c)
            assert(scr_loadout_race_get_start_crown(Race.Fish)==crwn_none,
                "Native saved custom crown bypassed closed content gate")
            global.ntte_full_feature_ready[$ "crown:"+_name]=true
            assert(array_get_index(scrNTTEFullCrownLoadoutSlots(),_c)>=0
                && scr_loadout_race_is_crown_unlocked(Race.Fish,_c)
                && scr_loadout_race_is_crown_unlocked(Race.Crystal,_c),
                "Source global custom crown ownership incorrectly depends on native per-race crowngot")
            assert(scr_loadout_race_set_start_crown(Race.Fish,_c)
                && scr_loadout_race_get_start_crown(Race.Fish)==_c
                && save_get_value("ccrown",Race.Fish,crwn_none)==_c,
                "Custom crown failed actual native start-crown setter/getter/save-map roundtrip")
            var _open=scrNTTEFullCrownLoadoutSprite(_c,true),_locked=scrNTTEFullCrownLoadoutSprite(_c,false)
            assert(_open[0]==scrNTTEFullCrownSprite(_c,"Loadout") && sprite_exists(_open[0])
                && sprite_get_number(_open[0])==2 && _locked[0]==_open[0] && _open[1]==0 && _locked[1]==1,
                "Custom crown menu must use source two-frame Loadout artwork rather than native atlas overflow")
            global.ntte_full_progress.unlocks[$ "loadout:crown:"+_name]=false
            assert(!scr_loadout_race_set_start_crown(Race.Fish,_c)
                && scr_loadout_race_get_start_crown(Race.Fish)==crwn_none,
                "Locked custom crown could be selected or restored")
            GameCont.crown=_c
            assert(scrNTTEFullCrownLoadoutUnlockCurrent()
                && scrNTTEFullUnlockGet("loadout:crown:"+_name),
                "Source campfire/win custom crown unlock callback lost global permanent ownership")
        }
        var _native=0
        for(var _c=1;_c<=13;++_c) if(_c>crwn_none && UberCont.crowngot[Race.Fish,_c]) _native+=1
        assert(scr_loadout_race_get_unlocked_crowns_count(Race.Fish)==_native+3,
            "Custom loadout crown total double counted native cache or failed global ownership")
        var _normal=scrNTTEFullCrownLoadoutSprite(2,true),_normalLocked=scrNTTEFullCrownLoadoutSprite(2,false)
        assert(_normal[0]==sprLoadoutCrown && _normal[1]==2 && _normalLocked[0]==sprLockedLoadoutCrown,
            "Custom crown rendering changed ordinary native crown artwork")
        var _path=_scratch+"crown-loadout-roundtrip.json"
        assert(scrNTTEFullProgressSave(_path),"Custom crown source permanent state failed scratch save")
        global.ntte_full_progress={schema:1,unlocks:{},loadouts:{},stats:{}}
        assert(scrNTTEFullProgressLoad(_path)
            && scr_loadout_race_is_crown_unlocked(Race.Crystal,NTTEFullCrown.Bonus)
            && scr_loadout_race_is_crown_unlocked(Race.Crystal,NTTEFullCrown.Crime)
            && scr_loadout_race_is_crown_unlocked(Race.Crystal,NTTEFullCrown.Red),
            "Source global crown ownership failed actual JSON persistence/load/menu chain")
    }
    finally {
        if(_had) UberCont.saveData[? _key]=_saved
        else ds_map_delete(UberCont.saveData,_key)
        UberCont.cgot[Race.Fish]=_fish;UberCont.cgot[Race.Crystal]=_crystal
        UberCont.crowngot[Race.Fish]=_crowns
        scrNTTEFullAreaGeneratorRestore(_game)
        global.ntte_full_progress=_progress;global.ntte_full_feature_ready=_ready;game_directory=_gameDirectory
    }
    scrNTTESmokeLog("FULL CROWN LOADOUT NATIVE: source global ownership/closed gates/native setter getter/save-map/menu slots/two-frame artwork/count/JSON roundtrip OK @"+string(30/timescale))
}

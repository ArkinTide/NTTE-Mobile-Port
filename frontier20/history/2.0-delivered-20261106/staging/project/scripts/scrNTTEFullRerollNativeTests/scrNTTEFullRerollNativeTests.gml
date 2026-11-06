function scrNTTEFullRerollNativeTests() {
    assert(scrNTTESmokeEnabled(),"Reroll fixture requires explicit desktop harness")
    var _before=scrNTTEFullInstances(all),_game=scrNTTEFullAreaGeneratorSnapshot(GameCont),
        _players=scrNTTEFullAreaGeneratorSnapshot(Player),_skills=ds_list_create(),
        _seed=random_get_seed(),_directory=game_directory,_view=[view_xview,view_yview],
        _hidden=scrNTTEFullInstances([GenCont,LevCont,SkillIcon,UltraIcon,CrownIcon,SkillText]),
        _progress=global.ntte_full_progress,_scratch=working_directory+"reroll-native-fixture/",
        _hadSave=file_exists(savegame_file),_saveBuffer=-1
    // Native continue save uses a relative buffer_save path independently of
    // game_directory, so preserve that file around the genuine submit chain.
    if(_hadSave) _saveBuffer=buffer_load(savegame_file)
    directory_create(_scratch);game_directory=_scratch
    global.ntte_full_progress=json_parse(json_stringify(_progress))
    for(var _i=0;_i<array_length(_hidden);++_i) instance_deactivate_object(_hidden[_i])
    GameCont.skills=_skills;GameCont.ntte_full_native_skill_counts={}
    GameCont.ntte_full_skills={};GameCont.ntte_full_skill_order=[]
    GameCont.ntte_reroll=undefined;GameCont.ntte_reroll_hud=undefined
    GameCont.skillpoints=0;GameCont.ultrapoints=0;GameCont.crownpoints=0
    try {
        var _p=instance_find(Player,0)
        with(Player) {race=Race.Fish;max_hp=8;hp=8;wep=wep_revolver;bwep=wep_none;}
        // The actual native setter removes stacked Rhino Skin, preserving the
        // original health consequence and Flower's Blessing last-hit label.
        scr_skill_set(mut_rhino_skin,2)
        GameCont.ntte_reroll=mut_rhino_skin
        scrNTTEFullSkillSet("reroll",1)
        assert(scr_skill_get(mut_rhino_skin)==0 && scrNTTEFullSkillGet("reroll")==2
            && GameCont.skillpoints==1 && _p.max_hp==8 && _p.hp==8
            && _p.lasthit[1]=="FLOWER'S BLESSING",
            "Reroll did not remove native stack and preserve source health/points/last-hit")
        scrNTTEFullSkillSet("reroll",0)
        assert(scr_skill_get(mut_rhino_skin)==2 && GameCont.skillpoints==0
            && is_undefined(GameCont.ntte_reroll) && _p.max_hp==16 && _p.hp==16,
            "Cancel did not restore exact removed stack and consume its pending point")
        // No explicit target: source scans acquisition order and keeps the
        // last available mutation. Reroll itself must never become a target.
        scr_skill_set(mut_eagle_eyes,3)
        scrNTTEFullSkillSet("reroll",1)
        assert(GameCont.ntte_reroll==mut_eagle_eyes && scr_skill_get(mut_eagle_eyes)==0
            && scrNTTEFullSkillGet("reroll")==3,
            "Reroll automatic target diverged from last source-available acquisition")
        var _pending=json_parse(json_stringify(scrNTTEFullSystemsExport()))
        GameCont.ntte_reroll=undefined;GameCont.ntte_full_skills={};GameCont.ntte_full_skill_order=[]
        assert(scrNTTEFullSystemsImport(_pending) && GameCont.ntte_reroll==mut_eagle_eyes
            && scrNTTEFullSkillGet("reroll")==3,
            "Pending Flower reroll stack/target did not survive serialized continue state")
        // One unrelated pending point keeps the real native submit in its
        // level-up path rather than creating a full next-level generator.
        GameCont.skillpoints=2
        var _choice=instance_create(0,0,SkillIcon)
        _choice.skill=mut_extra_feet
        with(_choice) event_user(0)
        assert(scr_skill_get(mut_extra_feet)==3 && scrNTTEFullSkillGet("reroll")==0
            && GameCont.ntte_reroll_hud==mut_extra_feet && is_undefined(GameCont.ntte_reroll)
            && GameCont.skillpoints==1 && instance_exists(SkillText) && instance_exists(LevCont),
            "Real SkillIcon selection/submit/save chain did not multiply chosen native stack")
        if(!file_exists(savegame_file)) {
            // Expose a genuine serialization failure to the harness instead
            // of losing its precise field behind native save's print/catch.
            var _diagnostic_buffer=buffer_create(0xffff,buffer_grow,1)
            try {
                scrSavegameSession(_diagnostic_buffer,false)
                scrNTTESmokeLog("Reroll save diagnosis: session serialized")
                scrSavegameGlobals(_diagnostic_buffer,false)
                scrNTTESmokeLog("Reroll save diagnosis: globals serialized")
                scrSavegamePlayers(_diagnostic_buffer,false)
                scrNTTESmokeLog("Reroll save diagnosis: players serialized; file path="+savegame_file+" working="+working_directory+" game="+game_directory)
            }
            finally {if(buffer_exists(_diagnostic_buffer)) buffer_delete(_diagnostic_buffer);}
        }
        assert(file_exists(savegame_file),"Real selection submit did not emit native continue save")
        var _chosen=json_parse(json_stringify(scrNTTEFullSystemsExport()))
        GameCont.ntte_reroll_hud=undefined
        assert(scrNTTEFullSystemsImport(_chosen) && GameCont.ntte_reroll_hud==mut_extra_feet,
            "Completed Flower HUD did not survive serialized continue state")
        scr_skill_set(mut_extra_feet,0)
        with(GameCont) event_perform(ev_step,ev_step_end)
        assert(is_undefined(GameCont.ntte_reroll_hud),"Removed blessed mutation left a stale source HUD target")
        // Nonstandard awards can bypass SkillIcon: source waits for a real
        // SkillText and then takes the LAST acquisition after Reroll.
        scrNTTEFullSkillSet("reroll",1)
        assert(scrNTTEFullSkillGet("reroll")==2,"Fallback source target stack was not retained")
        scr_skill_set(mut_euphoria,1)
        scrNTTEFullSkillSet("lead ribs",2)
        var _texts=scrNTTEFullInstances(SkillText)
        for(var _i=0;_i<array_length(_texts);++_i) instance_deactivate_object(_texts[_i])
        with(GameCont) event_perform(ev_step,ev_step_end)
        assert(scrNTTEFullSkillGet("reroll")==2 && scrNTTEFullSkillGet("lead ribs")==2,
            "Source fallback resolved an award before a real SkillText existed")
        for(var _i=0;_i<array_length(_texts);++_i) instance_activate_object(_texts[_i])
        with(GameCont) event_perform(ev_step,ev_step_end)
        assert(scrNTTEFullSkillGet("reroll")==0 && scrNTTEFullSkillGet("lead ribs")==4
            && scr_skill_get(mut_euphoria)==1 && GameCont.ntte_reroll_hud==NTTEFullSkill.LeadRibs,
            "Source End Step fallback missed last custom award or multiplied the earlier native award")
        scrNTTEFullSkillSet("lead ribs",0)
        with(GameCont) event_perform(ev_step,ev_step_end)
        assert(is_undefined(GameCont.ntte_reroll_hud),"Removed blessed custom mutation left stale HUD")
        scrNTTESmokeLog("PASS Reroll actual stacked native removal/health/last-hit/cancel, acquisition-order automatic target, JSON pending/completed restore, actual SkillIcon/submit/save selection, End Step last-native/custom award and HUD cleanup")
    }
    finally {
        var _all=scrNTTEFullInstances(all)
        for(var _i=array_length(_all)-1;_i>=0;--_i)
            if(array_get_index(_before,_all[_i])<0 && instance_exists(_all[_i])) instance_destroy(_all[_i],false)
        for(var _i=0;_i<array_length(_hidden);++_i) instance_activate_object(_hidden[_i])
        scrNTTEFullAreaGeneratorRestore(_players);scrNTTEFullAreaGeneratorRestore(_game)
        global.ntte_full_progress=_progress;game_directory=_directory
        if(buffer_exists(_saveBuffer)) {buffer_save(_saveBuffer,savegame_file);buffer_delete(_saveBuffer);}
        else if(!_hadSave && file_exists(savegame_file)) file_delete(savegame_file)
        view_xview=_view[0];view_yview=_view[1];random_set_seed(_seed);ds_list_destroy(_skills)
    }
}

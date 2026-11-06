// Dedicated explicit Windows acceptance. The first assertion witnesses the real
// cold UberCont.Create hook, before this fixture ever writes a readiness map.
function scrNTTEFullFeatureReadinessProductionOnly() {
    var _open=["skill:compassion","race:beetle","race:parrot","skin:angler fish","skin:bat eyes","skin:bonus robot","skin:coat venuz","skin:cool frog","skin:orchid plant","skin:red crystal","crown:crime","crown:red","bonus","crown:bonus"]
    assert(is_struct(global.ntte_full_feature_ready) && array_length(variable_struct_get_names(global.ntte_full_feature_ready))==14,"Production certificate list must contain exactly14 reviewed keys")
    for(var _i=0;_i<14;++_i) assert(scrNTTEFullFeatureReady(_open[_i]),"Reviewed certificate missing: "+_open[_i])
    var _closed=["skill:annihilation","skill:bat ears","skill:lead ribs","skill:magnetic pulse","skill:reroll","skill:silver tongue","skill:toad breath","future:unknown"]
    for(var _i=0;_i<8;++_i) assert(!scrNTTEFullFeatureReady(_closed[_i]),"Unreviewed ordinary certificate opened")
    scrNTTEFullFeatureReadinessProductionOwnership()
}
function scrNTTEFullFeatureReadinessProductionOwnership() {
    var _saved=global.ntte_full_progress,_ready=json_stringify(global.ntte_full_feature_ready)
    try {
        global.ntte_full_progress={schema:1,unlocks:{},loadouts:{},stats:{}}
        for(var _race=NTTEFullRace.Beetle;_race<=NTTEFullRace.Parrot;++_race) {
            assert(scrNTTEFullRaceReady(_race) && !scrNTTEFullRaceAvailable(_race),"Readiness awarded an unearned race")
            variable_struct_set(global.ntte_full_progress.unlocks,"race:"+scrNTTEFullRaceKey(_race),true)
            assert(scrNTTEFullRaceAvailable(_race),"Earned race rejected exact ordinary certificate")
        }
        for(var _id=200;_id<=206;++_id) {
            var _key=scrNTTEFullSkinKey(_id),_race=scrRaceGetNumericID(scrNTTEFullSkinRace(_key))
            var _wrong=_race==Race.Fish?Race.Crystal:Race.Fish
            assert(array_get_index(scrNTTEFullSkinSlots(_race),_id)>=0 && !scr_race_is_skin_unlocked(_race,_id),"Readiness awarded unearned skin")
            variable_struct_set(global.ntte_full_progress.loadouts,"skin:"+string(_race),_key)
            assert(scrNTTEFullSkinSaved(_race)==-1,"Forged loadout bypassed skin ownership")
            variable_struct_set(global.ntte_full_progress.unlocks,"skin:"+_key,true)
            assert(scr_race_is_skin_unlocked(_race,_id) && scrNTTEFullSkinSaved(_race)==_id,"Earned source skin rejected ordinary default")
            variable_struct_set(global.ntte_full_progress.loadouts,"skin:"+string(_wrong),_key)
            assert(!scrNTTEFullSkinMatches(_wrong,_id) && scrNTTEFullSkinSaved(_wrong)==-1,"Skin loadout bypassed race identity")
        }
        for(var _c=14;_c<=16;++_c) {
            var _key=scrNTTEFullCrownKey(_c)
            assert(array_get_index(scrNTTEFullCrownLoadoutSlots(),_c)>=0 && !scrNTTEFullCrownLoadoutAvailable(Race.Fish,_c),"Readiness awarded unearned crown loadout")
            variable_struct_set(global.ntte_full_progress.unlocks,"crown:"+_key,true)
            assert(!scrNTTEFullCrownLoadoutAvailable(Race.Fish,_c),"Run unlock bypassed permanent crown ownership")
            variable_struct_set(global.ntte_full_progress.unlocks,"loadout:crown:"+_key,true)
            assert(scrNTTEFullCrownLoadoutAvailable(Race.Fish,_c),"Earned loadout rejected ordinary crown certificate")
        }
        assert(json_stringify(global.ntte_full_feature_ready)==_ready,"Ownership tests mutated readiness")
        scrNTTESmokeLog("READINESS ordinary14: unowned/earned2races,7skin slots+forged/wrong-race loadout rejection,3crown run/permanent ownership separation OK")
    } finally {global.ntte_full_progress=_saved}
}
function scrNTTEFullFeatureReadinessProductionClear() {
    var _keep=id
    with(all) if(id!=_keep && object_index!=UberCont && object_index!=Console) instance_destroy(id,false)
}
function scrNTTEFullFeatureReadinessProductionRestore() {
    if(restored) return;
    restored=true
    UberCont.saveData=old_save_map
    if(ds_exists(fixture_save_map,ds_type_map)) ds_map_destroy(fixture_save_map)
    UberCont.opt_autopause=old_autopause;UberCont.opt_framerate=old_framerate
    game_set_speed(old_game_speed,gamespeed_fps)
    game_directory=old_directory;global.ntte_full_progress=old_progress
    global.ntte_full_feature_ready=old_ready;global.ntte_smoke_active=old_smoke
    if(old_continue>=0) {buffer_save(old_continue,savegame_file);buffer_delete(old_continue)}
    else if(file_exists(savegame_file)) file_delete(savegame_file)
    for(var _i=0;_i<array_length(scratch_files);++_i)
        if(file_exists(scratch_files[_i])) file_delete(scratch_files[_i])
}
function scrNTTEFullFeatureReadinessProductionTests() {
    if(os_type!=os_windows || !scrNTTEFullSmokeEnabled()) throw "Production readiness acceptance requires explicit Windows full smoke"
    scrNTTEFullFeatureReadinessProductionOnly()
    scrNTTESmokeLog("READINESS actual cold UberCont.Create initialized the reviewed14 keys before desktop test map writes")
    var _object=asset_get_index("NTTEFullFeatureReadinessProductionTest")
    assert(object_exists(_object) && !instance_exists(_object),"Readiness observer missing/duplicated")
    var _observer=instance_create(0,0,_object)
    with(_observer) {
        old_directory=game_directory;old_progress=global.ntte_full_progress
        old_ready=global.ntte_full_feature_ready;old_smoke=global.ntte_smoke_active
        old_continue=file_exists(savegame_file)?buffer_load(savegame_file):-1
        old_tutorial=save_get_value("game","tutorial",true)
        old_save_map=UberCont.saveData;fixture_save_map=ds_map_create();ds_map_copy(fixture_save_map,old_save_map)
        UberCont.saveData=fixture_save_map
        old_autopause=UberCont.opt_autopause;old_framerate=UberCont.opt_framerate;old_game_speed=game_get_speed(gamespeed_fps)
        restored=false;scratch_files=[];rates=[30,60];pass_index=0;phase=0;elapsed=0;draw_frames=0;diag_next=0
        scratch_root=working_directory+"readiness-production-"+string(get_timer())+"/";directory_create(scratch_root)
        global.ntte_smoke_active=false
        with(NTTESmokeTest) instance_deactivate_object(id)
        scrNTTEFullFeatureReadinessProductionClear()
    }
}
function scrNTTEFullFeatureReadinessProductionAwait(_next) {
    phase=_next;elapsed=0;draw_start=draw_frames;diag_next=0
    scrNTTESmokeLog("READINESS native phase="+string(phase)+" fps="+string(rates[pass_index])
        +" map="+json_stringify(global.ntte_full_feature_ready)+" runtime="
        +json_stringify({draw_frames:draw_frames,visible:visible,active:instance_exists(id),
            runtime_fps:game_get_speed(gamespeed_fps),logic_scale:timescale,focus:window_has_focus(),
            autopause:UberCont.opt_autopause,paused:UberCont.paused,want_pause:UberCont.want_pause}))
}
function scrNTTEFullFeatureReadinessProductionMenu() {
    scrNTTEFullFeatureReadinessProductionClear()
    if(file_exists(savegame_file)) file_delete(savegame_file)
    UberCont.want_quit_to_menu=true
    instance_create(0,0,Vlambeer)
    scrNTTEFullFeatureReadinessProductionAwait(1)
}
function scrNTTEFullFeatureReadinessProductionSame() {
    assert(json_stringify(global.ntte_full_feature_ready)==map_bytes && !scrNTTEFullFeatureReady("skill:compassion")
        && !scrNTTEFullFeatureReady("future:unknown"),
        "Native re-entry/menu/continue overwrote an existing readiness map or opened a missing certificate")
    assert(!scrNTTEFullFeatureReadinessInit() && json_stringify(global.ntte_full_feature_ready)==map_bytes,
        "Readiness initializer merged/rebuilt an existing explicit-false map")
}
function scrNTTEFullFeatureReadinessProductionStepBody() {
    elapsed+=timescale
    assert(elapsed<=2700,"Readiness native acceptance timeout phase="+string(phase))
    if(instance_exists(Player)) with(Player) {
        hp=100000;max_hp=100000;lsthealth=100000;nexthurt=current_frame+100000
        speed=0;can_walk=false;can_aim=false
    }
    if(phase==0) {
        scrNTTEFullFeatureReadinessProductionClear()
        UberCont.opt_framerate=rates[pass_index];game_set_speed(rates[pass_index],gamespeed_fps)
        // Native UberCont.RoomStart reloads these options on actual restart.
        // Change only the isolated copied map; preserve the original map ID.
        save_set_value("options","autopause",false)
        save_set_value("options","framerate",rates[pass_index])
        UberCont.opt_autopause=false;UberCont.paused=false;UberCont.want_pause=false;UberCont.opt_freeze=0;UberCont.opt_bossintro=false
        UberCont.daily_run=false;UberCont.weekly_run=false;UberCont.coop=false;UberCont.hardmode=false
        UberCont.want_quit_to_menu=false;UberCont.show_leaderboards_menu=false
        global.is_server=true;global.index=0;global.custom_seed=0;global.seed=702643
        global.crownpick=crwn_none;global.recontinued_times=0
        scrGameCustomModeReset();scr_playerinstances_reset_all();my_player.race=Race.Fish;my_player.skin=0
        save_set_value("game","tutorial",false)
        game_directory=scratch_root+string(rates[pass_index])+"/";directory_create(game_directory)
        array_push(scratch_files,game_directory+"ntte-full-progress.json")
        array_push(scratch_files,game_directory+"ntte-full-progress.json.bak")
        array_push(scratch_files,game_directory+"ntte-full-progress.json.tmp")
        array_push(scratch_files,game_directory+"NuclearThrone.sav")
        global.ntte_full_progress={schema:1,unlocks:{},loadouts:{},stats:{}}
        var _invalid=[undefined,0,"invalid map"]
        for(var _i=0;_i<array_length(_invalid);++_i) {
            global.ntte_full_feature_ready=_invalid[_i]
            assert(!scrNTTEFullFeatureReady("skill:compassion") && !scrNTTEFullFeatureReady("future:unknown"),
                "FeatureReady treated invalid/nonstruct state as a certificate")
            assert(scrNTTEFullFeatureReadinessInit(),"Cold/invalid readiness map failed initialization")
            scrNTTEFullFeatureReadinessProductionOnly()
        }
        // Real disk progress with misleading ownership/loadout/stat fields must
        // never act as a certificate, either before or after initialization.
        var _owned=["skill:compassion","race:beetle","crown:red","skin:red crystal","future:unknown"]
        for(var _i=0;_i<array_length(_owned);++_i) {
            variable_struct_set(global.ntte_full_progress.unlocks,_owned[_i],true)
            variable_struct_set(global.ntte_full_progress.loadouts,_owned[_i],true)
            variable_struct_set(global.ntte_full_progress.stats,_owned[_i],true)
        }
        var _misleading={};variable_struct_set(_misleading,"race:beetle",true)
        global.ntte_full_progress.ntte_full_feature_ready=_misleading
        assert(scrNTTEFullProgressSave(),"Readiness progress isolation failed real disk write")
        global.ntte_full_progress={schema:1,unlocks:{},loadouts:{},stats:{}};global.ntte_full_feature_ready={}
        assert(scrNTTEFullProgressLoad() && scrNTTEFullUnlockGet("race:beetle")
            && array_length(variable_struct_get_names(global.ntte_full_feature_ready))==0,
            "Saved unlock/loadout/stat/extra readiness data certified production content")
        assert(!scrNTTEFullFeatureReadinessInit() && !scrNTTEFullFeatureReady("skill:compassion"),
            "Initializer overwrote a legitimate empty closed-gate map")
        global.ntte_full_feature_ready=undefined;scrNTTEFullFeatureReadinessInit()
        scrNTTEFullFeatureReadinessProductionOnly()
        global.ntte_full_feature_ready={fixture_sentinel:{pass_index:pass_index,value:1729}}
        variable_struct_set(global.ntte_full_feature_ready,"skill:compassion",false)
        map_bytes=json_stringify(global.ntte_full_feature_ready)
        scrNTTEFullFeatureReadinessProductionSame()
        menu_count=0
        scrNTTEFullFeatureReadinessProductionMenu();return;
    }
    if(phase==1) {
        if(instance_exists(Logo)) with(Logo) event_perform(ev_alarm,1)
        var _button=noone
        with(MainMenuButton) if(image_index==0) _button=id
        if(!instance_exists(_button)) return;
        with(_button) event_user(0)
        var _play=noone
        with(PlayButton) if(floor(num)==0) _play=id
        if(instance_exists(_play)) with(_play) event_user(0)
        assert(instance_exists(Menu) && instance_exists(MenuGen),"Readiness test native main Play path missed actual menu")
        selector=noone
        with(CharSelect) if(race==Race.Fish) other.selector=id
        assert(instance_exists(selector),"Native Fish selector missing under closed readiness")
        scrNTTEFullFeatureReadinessProductionAwait(2);return;
    }
    if(phase==2) {
        if(draw_frames-draw_start<3 || instance_exists(FloorMaker)) return;
        scrNTTEFullFeatureReadinessProductionSame()
        if(++menu_count<2) {scrNTTEFullFeatureReadinessProductionMenu();return;}
        assert(selector.can,"Readiness initialization broke original Fish availability")
        with(selector) event_perform(ev_mouse,ev_left_press)
        with(GoButton) event_perform(ev_mouse,ev_left_press)
        assert(instance_number(Player)==1 && Player.race==Race.Fish,"Readiness native Go failed original new Player")
        initial_player=instance_find(Player,0)
        scrNTTEFullFeatureReadinessProductionAwait(3);return;
    }
    if(phase==3) {
        if(instance_exists(Menu) || instance_exists(MenuGen) || instance_exists(GenCont) || instance_exists(FloorMaker)) return;
        assert(instance_exists(initial_player) && instance_number(Floor)>20 && instance_exists(TopCont),
            "Readiness native new run lacks actual room-restart world")
        assert(game_get_speed(gamespeed_fps)==rates[pass_index] && timescale==30/rates[pass_index]
            && !UberCont.opt_autopause,
            "Native room restart replaced the fixture rate or re-enabled background autopause")
        scrNTTEFullFeatureReadinessProductionSame()
        // Exercise the certified Compassion branch through source capacity
        // and ordinary RNG/SkillIcon. The existing full Compassion case remains
        // independent and continues to test its own temporary closed/open map.
        global.ntte_full_feature_ready=undefined;scrNTTEFullFeatureReadinessInit()
        scrNTTEFullFeatureReadinessProductionOnly()
        var _p=instance_find(Player,0),_pet=scrNTTEFullPetCreate(_p.x,_p.y,"Scorpion")
        assert(scrNTTEFullPetTake(_pet,_p) && _p.ntte_pet_max==1
            && scr_skill_can_appear(NTTEFullSkill.Compassion),
            "Production certificate failed source full-pet ordinary eligibility")
        GameCont.skillpoints=2;GameCont.ultrapoints=0;GameCont.crownpoints=0
        var _seed=1,_found=false
        repeat(2000) {random_set_seed(_seed);if(scrDecideSkill(false)==NTTEFullSkill.Compassion) {_found=true;break}_seed++}
        assert(_found,"Production certified Compassion was absent from real ordinary RNG")
        var _choice=instance_create(0,0,SkillIcon)
        random_set_seed(_seed);_choice.skill=scrDecideSkill(false)
        assert(_choice.skill==NTTEFullSkill.Compassion,"Production Compassion ordinary offer changed")
        with(_choice) event_user(0)
        assert(scr_skill_get(NTTEFullSkill.Compassion)==1 && GameCont.ntte_pet_max==2 && _p.ntte_pet_max==2,
            "Production certified ordinary SkillIcon grant failed exact capacity delta")
        // Resume a settled gameplay session: skill selection UI is intentionally
        // removed after the witnessed real grant, rather than submitted twice.
        instance_destroy(LevCont,false);instance_destroy(SkillIcon,false);instance_destroy(SkillText,false)
        GameCont.skillpoints=0
        saved_player=_p.id;saved_pet=_pet.id
        scrSavegameSave()
        assert(file_exists(savegame_file),"Production certified run did not write actual continuation file")
        global.ntte_full_feature_ready={fixture_sentinel:{pass_index:pass_index,value:2718}}
        variable_struct_set(global.ntte_full_feature_ready,"skill:compassion",false)
        map_bytes=json_stringify(global.ntte_full_feature_ready)
        scrNTTEFullFeatureReadinessProductionClear()
        UberCont.want_quit_to_menu=false
        instance_create(0,0,Vlambeer)
        scrNTTEFullFeatureReadinessProductionAwait(4);return;
    }
    if(phase==4) {
        if(instance_exists(GenCont) || instance_exists(FloorMaker)) return;
        assert(instance_number(Player)==1 && Player.id!=saved_player && Player.race==Race.Fish
            && UberCont.continued_run && instance_number(Floor)>20,
            "Readiness actual native file continuation did not reconstruct a new Player/world")
        assert(game_get_speed(gamespeed_fps)==rates[pass_index] && timescale==30/rates[pass_index]
            && !UberCont.opt_autopause,
            "Actual native continuation replaced the fixture rate or background run condition")
        scrNTTEFullFeatureReadinessProductionSame()
        assert(scr_skill_get(NTTEFullSkill.Compassion)==1 && GameCont.ntte_pet_max==2 && Player.ntte_pet_max==2,
            "Native continuation lost certified held skill or repeated its capacity delta")
        var _slots=Player.ntte_pet,_live=0
        for(var _i=0;_i<array_length(_slots);++_i) if(instance_exists(_slots[_i])) {
            _live++
            assert(_slots[_i].id!=saved_pet && _slots[_i].leader==Player.id && _slots[_i].pet=="Scorpion",
                "Actual readiness continuation lost reconstructed pet identity/ownership")
        }
        assert(array_length(_slots)==2 && _live==1,"Actual readiness continuation lost source fixed pet capacity")
        draw_start=draw_frames;scrNTTEFullFeatureReadinessProductionAwait(5);return;
    }
    if(phase==5) {
        if(elapsed>=diag_next) {
            diag_next=elapsed+30
            scrNTTESmokeLog("READINESS live Draw wait "+json_stringify({elapsed:elapsed,draw_frames:draw_frames,
                draw_start:draw_start,visible:visible,active:instance_exists(id),observers:instance_number(object_index),
                runtime_fps:game_get_speed(gamespeed_fps),fps_real:fps_real,logic_scale:timescale,focus:window_has_focus(),
                autopause:UberCont.opt_autopause,paused:UberCont.paused,want_pause:UberCont.want_pause,
                generator:instance_exists(GenCont),floor_maker:instance_exists(FloorMaker),
                pause_image:instance_exists(PauseImage),pause_buttons:instance_number(PauseButton)}))
        }
        if(draw_frames-draw_start<8) return;
        scrNTTEFullFeatureReadinessProductionSame()
        assert(scr_skill_get(NTTEFullSkill.Compassion)==1 && Player.ntte_pet_max==2,
            "Normal live frames after continuation replayed certified Compassion")
        scrNTTESmokeLog("PASS READINESS PRODUCTION cold/invalid/exact14/hidden seven+unknown false/existing false+empty map/persisted ownership isolation/two actual menus/native Go+room_restart/production ordinary grant/real binary continuation/new Player+pet/no map overwrite/no repeated delta @"+string(rates[pass_index]))
        if(++pass_index<array_length(rates)) {scrNTTEFullFeatureReadinessProductionAwait(0);return;}
        scrNTTEFullFeatureReadinessProductionRestore()
        scrNTTESmokeLog("PASS full internal selected implemented branches x 30/60; not complete MOD coverage")
        game_end()
    }
}
function scrNTTEFullFeatureReadinessProductionStep() {
    try {scrNTTEFullFeatureReadinessProductionStepBody()}
    catch(_error) {scrNTTEFullFeatureReadinessProductionRestore();throw _error}
}

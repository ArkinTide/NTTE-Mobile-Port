// Dedicated native room-restart acceptance. The desktop harness owns this
// process; production readiness remains unchanged outside the restored scope.
function scrNTTEFullRedSkinNaturalRead(_path) {
    if(!file_exists(_path)) return undefined
    var _file=file_text_open_read(_path),_text=""
    while(!file_text_eof(_file)) {_text+=file_text_read_string(_file);file_text_readln(_file)}
    file_text_close(_file);return _text
}
function scrNTTEFullRedSkinNaturalClear() {
    var _keep=id
    with(all) if(id!=_keep && object_index!=UberCont && object_index!=Console) instance_destroy(id,false)
}
function scrNTTEFullRedSkinNaturalRestore() {
    if(restored) return;
    restored=true
    // Restore opaque global references as well as the nested contents modified
    // by real menu/start/continue. The fixture never destroys original DS data.
    scrNTTEFullAreaGeneratorRestore(old_global_graph)
    for(var _i=0;_i<array_length(old_global_vars);++_i)
        variable_global_set(old_global_vars[_i][0],old_global_vars[_i][1])
    scrNTTEFullAreaGeneratorRestore(old_uber)
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
    random_set_seed(old_seed)
}
function scrNTTEFullRedSkinNaturalMenuTests() {
    assert(os_type==os_windows && scrNTTEFullSmokeEnabled(),"Red skin natural acceptance requires explicit Windows full smoke")
    var _object=asset_get_index("NTTEFullRedSkinNaturalMenuTest")
    assert(object_exists(_object) && !instance_exists(_object),"Red skin natural observer missing/duplicated")
    var _observer=instance_create(0,0,_object)
    with(_observer) {
        restored=false;scratch_files=[];old_global_vars=[]
        old_directory=game_directory;old_progress=global.ntte_full_progress
        old_ready=variable_global_exists("ntte_full_feature_ready")?global.ntte_full_feature_ready:undefined
        old_smoke=global.ntte_smoke_active;old_continue=file_exists(savegame_file)?buffer_load(savegame_file):-1
        old_seed=random_get_seed()
        old_save_map=UberCont.saveData;old_savedata=ds_map_write(old_save_map)
        old_autopause=UberCont.opt_autopause;old_framerate=UberCont.opt_framerate
        old_game_speed=game_get_speed(gamespeed_fps)
        old_uber=scrNTTEFullAreaGeneratorSnapshot(UberCont)
        fixture_save_map=ds_map_create();ds_map_copy(fixture_save_map,old_save_map)
        UberCont.saveData=fixture_save_map
        var _names=variable_struct_get_names(global),_graph={nodes:[]}
        for(var _i=0;_i<array_length(_names);++_i) {
            var _name=_names[_i],_value=variable_global_get(_name)
            array_push(old_global_vars,[_name,_value]);scrNTTEFullAreaSnapshotContainer(_value,_graph)
        }
        old_global_graph={instances:[],containers:_graph.nodes}
        rates=[30,60];pass_index=0;phase=0;elapsed=0;draw_frames=0;draw_start=0
        scratch_root=working_directory+"red-skin-natural-"+string(get_timer())+"/"
        directory_create(scratch_root)
        global.ntte_smoke_active=false
        with(NTTESmokeTest) instance_deactivate_object(id)
        scrNTTEFullRedSkinNaturalClear()
    }
}
function scrNTTEFullRedSkinNaturalAwait(_next) {phase=_next;elapsed=0;draw_start=draw_frames}
function scrNTTEFullRedSkinNaturalActualRate(_boundary) {
    assert(UberCont.saveData==fixture_save_map && ds_map_write(old_save_map)==old_savedata,
        "Red fixture lost copied options map or changed original save data: "+_boundary)
    assert(game_get_speed(gamespeed_fps)==rates[pass_index] && timescale==30/rates[pass_index]
        && UberCont.opt_framerate==rates[pass_index] && !UberCont.opt_autopause
        && fixture_save_map[? "options_framerate"]==rates[pass_index]
        && fixture_save_map[? "options_autopause"]==false,
        "Red native boundary replaced requested actual FPS/timescale/options: "+_boundary)
    scrNTTESmokeLog("RED SKIN ACTUAL RATE "+_boundary+" "+json_stringify({
        requested_fps:rates[pass_index],runtime_fps:game_get_speed(gamespeed_fps),logic_scale:timescale,
        autopause:UberCont.opt_autopause,original_savedata_unchanged:true}))
}
function scrNTTEFullRedSkinNaturalStepBody() {
    elapsed+=timescale
    assert(elapsed<=2700,"Red skin natural state timeout phase="+string(phase))
    if(instance_exists(Player)) with(Player) {
        hp=100000;max_hp=100000;lsthealth=100000;nexthurt=current_frame+100000
        speed=0;can_walk=false;can_aim=false
    }
    if(phase==0) {
        scrNTTEFullRedSkinNaturalClear()
        // Actual native RoomStart reloads only this fixture's copied options.
        save_set_value("options","autopause",false)
        save_set_value("options","framerate",rates[pass_index])
        UberCont.opt_framerate=rates[pass_index];game_set_speed(rates[pass_index],gamespeed_fps)
        UberCont.opt_autopause=false;UberCont.paused=false;UberCont.want_pause=false
        UberCont.opt_freeze=0;UberCont.opt_bossintro=false
        UberCont.daily_run=false;UberCont.weekly_run=false;UberCont.coop=false;UberCont.hardmode=false
        UberCont.want_quit_to_menu=false;UberCont.show_leaderboards_menu=false
        global.is_server=true;global.index=0;global.custom_seed=0;global.seed=701932
        global.crownpick=crwn_none;global.recontinued_times=0
        scrGameCustomModeReset();scr_playerinstances_reset_all();my_player.race=Race.Fish;my_player.skin=0
        if(file_exists(savegame_file)) file_delete(savegame_file)
        game_directory=scratch_root+string(rates[pass_index])+"/";directory_create(game_directory)
        array_push(scratch_files,game_directory+"ntte-full-progress.json")
        array_push(scratch_files,game_directory+"ntte-full-progress.json.bak")
        array_push(scratch_files,game_directory+"ntte-full-progress.json.tmp")
        array_push(scratch_files,game_directory+"NuclearThrone.sav")
        global.ntte_full_progress={schema:1,unlocks:{},loadouts:{},stats:{}}
        global.ntte_full_feature_ready={}
        assert(array_get_index(scrNTTEFullSkinSlots(Race.Crystal),206)<0
            && !scr_race_is_skin_unlocked(Race.Crystal,206),"Closed Red skin production gate exposed native slot")
        // One fixture-local gate only. Unlock ownership still starts absent.
        global.ntte_full_feature_ready[$ "skin:red crystal"]=true
        assert(!scr_race_is_skin_unlocked(Race.Crystal,206)
            && !scr_loadout_race_set_skin(Race.Crystal,206),"Unowned Red skin accepted native loadout selection")
        save_set_value("game","tutorial",false)
        instance_create(0,0,GameCont);instance_create(0,0,BackCont);instance_create(0,0,MusCont)
        scrCreatePlayers(0)
        GameCont.area=scrNTTEFullAreaId("red");GameCont.subarea=1;GameCont.loops=0;GameCont.hard=1
        GameCont.maxsubarea=scrAreaGetMaxSubarea(GameCont.area);GameCont.finalsubarea=true
        GameCont.ntte_visits_red=0;GameCont.ntte_full_pending_destination=undefined
        global.ntte_full_sync_generation=false;global.rng_state[@RNGStates.Generation]=701932
        var _gen=instance_create(0,0,GenCont)
        assert(!_gen.ntte_full_sync_generation,"Red skin source fixture bypassed normal native generation")
        scrNTTEFullRedSkinNaturalAwait(1);return;
    }
    if(phase==1) {
        if(instance_exists(GenCont) || instance_exists(FloorMaker)) return;
        assert(GameCont.ntte_active_red && GameCont.ntte_full_active_red && instance_number(Floor)>60
            && instance_exists(TopCont) && instance_exists(BackCont),"Real Red generation did not finish world/start/render chain")
        assert(!scrNTTEFullUnlockGet("skin:red crystal") && GameCont.ntte_visits_red==0,
            "Red entry/level start prematurely awarded the original finish-only skin")
        assert(is_undefined(scrNTTEFullRedSkinNaturalRead(game_directory+"ntte-full-progress.json"))
            || !scrNTTEFullValue(json_parse(scrNTTEFullRedSkinNaturalRead(game_directory+"ntte-full-progress.json")).unlocks,"skin:red crystal",false),
            "Red entry persisted a premature Red Crystal unlock")
        GameCont.can_advance_stage=false
        with(GameCont) event_perform(ev_other,ev_room_end)
        assert(!scrNTTEFullUnlockGet("skin:red crystal") && GameCont.ntte_visits_red==0 && GameCont.can_advance_stage,
            "Native blocked RoomEnd incorrectly executed Red finish")
        // This is the actual native completion event, not a direct RedFinish
        // or UnlockSet helper. Original Red has one subarea and self-loops.
        with(GameCont) event_perform(ev_other,ev_room_end)
        assert(scrNTTEFullUnlockGet("skin:red crystal") && GameCont.area==206 && GameCont.subarea==1
            && GameCont.ntte_visits_red==1 && GameCont.ntte_visits_loop_red==0
            && !GameCont.ntte_active_red && !GameCont.ntte_full_active_red,
            "Actual Red RoomEnd failed source finish award/one visit/self-loop/transit")
        var _saved=scrNTTEFullRedSkinNaturalRead(game_directory+"ntte-full-progress.json")
        assert(!is_undefined(_saved) && json_parse(_saved).unlocks[$ "skin:red crystal"],
            "Actual Red finish did not persist source skin ownership")
        global.ntte_full_progress={schema:1,unlocks:{},loadouts:{},stats:{}}
        assert(scrNTTEFullProgressLoad() && scr_race_is_skin_unlocked(Race.Crystal,206),
            "Actual progress reload lost naturally finished Red skin")
        scrNTTEFullRedSkinNaturalActualRate("source completed")
        scrNTTESmokeLog("RED SKIN SOURCE: real Red generation/no entry award/blocked RoomEnd exclusion/normal RoomEnd source finish+visits/self-loop/JSON reload OK @"+string(rates[pass_index]))
        scrNTTEFullRedSkinNaturalClear()
        if(file_exists(savegame_file)) file_delete(savegame_file)
        UberCont.want_quit_to_menu=true;instance_create(0,0,Vlambeer)
        scrNTTEFullRedSkinNaturalAwait(2);return;
    }
    if(phase==2) {
        if(instance_exists(Logo)) with(Logo) event_perform(ev_alarm,1)
        var _button=noone
        with(MainMenuButton) if(image_index==0) _button=id
        if(!instance_exists(_button)) return;
        with(_button) event_user(0)
        var _play=noone
        with(PlayButton) if(floor(num)==0) _play=id
        if(instance_exists(_play)) with(_play) event_user(0)
        assert(instance_exists(Menu) && instance_exists(MenuGen),"Actual MainMenu/Play did not build native skin selection menu")
        selector=noone
        with(CharSelect) if(race==Race.Crystal) other.selector=id
        assert(instance_exists(selector),"Crystal absent from real native menu")
        scrNTTEFullRedSkinNaturalActualRate("native menu constructed")
        scrNTTEFullRedSkinNaturalAwait(3);return;
    }
    if(phase==3) {
        if(draw_frames-draw_start<3 || instance_exists(FloorMaker)) return;
        scrNTTEFullRedSkinNaturalActualRate("native menu Draw before Go")
        assert(selector.can,"Native CharSelect Draw rejected ordinary Crystal")
        with(selector) event_perform(ev_mouse,ev_left_press)
        assert(my_player.race==Race.Crystal && selector.selected,"Real Crystal selection failed")
        // Use the same production API as the native loadout Draw handler.
        // This case deliberately does not claim mouse/touch skin hitbox proof.
        assert(array_get_index(scrNTTEFullSkinSlots(Race.Crystal),206)>=0
            && scr_loadout_race_set_skin(Race.Crystal,206),"Persisted Red ownership missing from native skin menu/API")
        my_player.skin=scr_loadout_race_get_skin(Race.Crystal)
        assert(my_player.skin==206 && scrNTTEFullSkinSaved(Race.Crystal)==206,
            "Actual loadout skin setter did not store stable Red key")
        var _saved=json_parse(scrNTTEFullRedSkinNaturalRead(game_directory+"ntte-full-progress.json"))
        assert(_saved.loadouts[$ "skin:"+string(Race.Crystal)]=="red crystal",
            "Native menu loadout API did not persist Red choice")
        with(GoButton) event_perform(ev_mouse,ev_left_press)
        assert(instance_number(Player)==1 && Player.race==Race.Crystal && Player.bskin==206,
            "Actual native Go/new-run did not construct selected Red Crystal Player")
        initial_player=Player.id
        scrNTTEFullRedSkinNaturalAwait(4);return;
    }
    if(phase==4) {
        if(instance_exists(Menu) || instance_exists(MenuGen) || instance_exists(GenCont) || instance_exists(FloorMaker)) return;
        scrNTTEFullRedSkinNaturalActualRate("actual room_restart world")
        assert(instance_number(Player)==1 && Player.id==initial_player && Player.race==Race.Crystal && Player.bskin==206
            && instance_number(Floor)>20 && instance_exists(TopCont),"Actual room_restart/new-level lost Red skin or native world")
        assert(scrNTTEFullSkinTargetSprite(Player.id,sprShield,"body")==scrNTTERefSprite("CrystalRedShield"),
            "Real new-run Red Crystal lost its source shield art mapping")
        saved_player=Player.id;scrSavegameSave()
        assert(file_exists(savegame_file),"Actual Red Crystal new-run failed binary continuation save")
        scrNTTEFullRedSkinNaturalClear();UberCont.want_quit_to_menu=false;instance_create(0,0,Vlambeer)
        scrNTTEFullRedSkinNaturalAwait(5);return;
    }
    if(phase==5) {
        if(instance_exists(GenCont) || instance_exists(FloorMaker)) return;
        scrNTTEFullRedSkinNaturalActualRate("actual binary continuation world")
        assert(instance_number(Player)==1 && Player.id!=saved_player && Player.race==Race.Crystal && Player.bskin==206
            && UberCont.continued_run && instance_number(Floor)>20,"Actual Vlambeer binary continuation lost selected Red Crystal/new Player/world")
        assert(scr_race_is_skin_unlocked(Race.Crystal,206) && scr_loadout_race_get_skin(Race.Crystal)==206,
            "Actual Red Crystal continuation lost persisted unlock/loadout")
        scrNTTESmokeLog("PASS RED SKIN NATURAL MENU: original one-subarea Red finish via actual RoomEnd/persisted ownership/native loadout setter API/real CharSelect+Go/new-run room_restart/native binary Vlambeer continuation OK; skin click hitbox not exercised @"+string(rates[pass_index]))
        if(++pass_index<array_length(rates)) {scrNTTEFullRedSkinNaturalAwait(0);return;}
        scrNTTEFullRedSkinNaturalRestore()
        scrNTTESmokeLog("PASS full internal selected implemented branches x 30/60; not complete MOD coverage")
        game_end()
    }
}
function scrNTTEFullRedSkinNaturalStep() {
    try {scrNTTEFullRedSkinNaturalStepBody()}
    catch(_error) {scrNTTEFullRedSkinNaturalRestore();throw _error}
}

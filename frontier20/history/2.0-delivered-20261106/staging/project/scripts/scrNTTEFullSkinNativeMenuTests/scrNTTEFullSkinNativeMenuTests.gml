// Explicit preowned-skin UI acceptance; natural acquisition is tested separately.
function scrNTTEFullSkinNativeMenuRead(_path) {
    if(!file_exists(_path)) return undefined;
    var _file=file_text_open_read(_path),_text=""
    while(!file_text_eof(_file)) {_text+=file_text_read_string(_file);file_text_readln(_file)}
    file_text_close(_file);return _text
}
function scrNTTEFullSkinNativeMenuClear() {
    var _keep=id
    with(all) if(id!=_keep && object_index!=UberCont && object_index!=Console) instance_destroy(id,false)
}
function scrNTTEFullSkinNativeMenuRestore() {
    if(restored) return;
    restored=true
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
function scrNTTEFullSkinNativeMenuTests() {
    assert(os_type==os_windows && scrNTTEFullSmokeEnabled(),"Skin menu acceptance requires explicit Windows full smoke")
    assert(!instance_exists(NTTEFullSkinNativeMenuTest),"Skin native menu observer duplicated")
    var _observer=instance_create(0,0,NTTEFullSkinNativeMenuTest)
    with(_observer) {
        restored=false;scratch_files=[];old_global_vars=[]
        old_directory=game_directory;old_progress=global.ntte_full_progress
        old_ready=global.ntte_full_feature_ready;old_smoke=global.ntte_smoke_active
        old_continue=file_exists(savegame_file)?buffer_load(savegame_file):-1
        old_seed=random_get_seed();old_save_map=UberCont.saveData;old_savedata=ds_map_write(old_save_map)
        old_autopause=UberCont.opt_autopause;old_framerate=UberCont.opt_framerate
        old_game_speed=game_get_speed(gamespeed_fps);old_uber=scrNTTEFullAreaGeneratorSnapshot(UberCont)
        fixture_save_map=ds_map_create();ds_map_copy(fixture_save_map,old_save_map);UberCont.saveData=fixture_save_map
        var _names=variable_struct_get_names(global),_graph={nodes:[]}
        for(var _i=0;_i<array_length(_names);++_i) {
            var _name=_names[_i],_value=variable_global_get(_name)
            array_push(old_global_vars,[_name,_value]);scrNTTEFullAreaSnapshotContainer(_value,_graph)
        }
        old_global_graph={instances:[],containers:_graph.nodes}
        cases=[{skin:200,race:Race.Fish,body:"FishAnglerIdle",hud:"AnglerTunnellerHUD"},
            {skin:201,race:Race.Eyes,body:"EyesBatIdle",hud:"BatTunnellerHUD"},
            {skin:202,race:Race.Robot,body:"RobotBonusIdle",hud:"BonusTunnellerHUD"},
            {skin:203,race:Race.Venuz,body:"YVCoatIdle",hud:"CoatTunnellerHUD"},
            {skin:204,race:Race.Frog,body:"FrogCoolIdle",hud:"CoolTunnellerHUD"},
            {skin:205,race:Race.Plant,body:"PlantOrchidIdle",hud:"OrchidTunnellerHUD"},
            {skin:206,race:Race.Crystal,body:"CrystalRedIdle",hud:"RedTunnellerHUD"}]
        rates=[30,60];pass_index=0;case_index=0;phase=0;elapsed=0;draw_frames=0;draw_start=0
        want_pointer=false;pointer_injections=0;injected_phase=-1;menu=noone
        scratch_root=working_directory+"skin-native-menu-"+string(get_timer())+"/";directory_create(scratch_root)
        global.ntte_smoke_active=false
        with(NTTESmokeTest) instance_deactivate_object(id)
        scrNTTEFullSkinNativeMenuClear()
    }
}
function scrNTTEFullSkinNativeMenuAfterSample(_pinst) {
    if(os_type!=os_windows || !scrNTTEFullSmokeEnabled()) return undefined;
    var _observer=instance_find(NTTEFullSkinNativeMenuTest,0)
    if(!instance_exists(_observer) || !_observer.want_pointer || id!=_observer.menu) return undefined;
    var _phase=_observer.phase
    if(_phase!=3 && _phase!=4 && _phase!=5) return undefined;
    if(_pinst.get_index()!=0 || _pinst.get_race()!=_observer.target_race) return undefined;
    _observer.want_pointer=false;_observer.pointer_injections++;_observer.injected_phase=_phase
    // Only this draw function's sampled local pointer and press are replaced.
    return {x:_observer.pointer_x,y:_observer.pointer_y,press:true}
}
function scrNTTEFullSkinNativeMenuAwait(_next) {
    phase=_next;elapsed=0;draw_start=draw_frames;want_pointer=false
    scrNTTESmokeLog("SKIN UI phase="+string(phase)+" key="+skin_key+" rate="+string(rates[min(pass_index,1)])
        +" preowned="+string(owned)+" draws="+string(draw_frames)+" pointer_injections="+string(pointer_injections))
}
function scrNTTEFullSkinNativeMenuActualRate(_boundary) {
    assert(UberCont.saveData==fixture_save_map && ds_map_write(old_save_map)==old_savedata,
        "Skin UI fixture lost copied save map or changed original bytes: "+_boundary)
    assert(game_get_speed(gamespeed_fps)==rates[pass_index] && timescale==30/rates[pass_index]
        && UberCont.opt_framerate==rates[pass_index] && !UberCont.opt_autopause
        && fixture_save_map[? "options_framerate"]==rates[pass_index]
        && fixture_save_map[? "options_autopause"]==false,
        "Skin native boundary replaced actual FPS/timescale/options: "+_boundary)
    scrNTTESmokeLog("SKIN UI ACTUAL RATE "+skin_key+" "+_boundary+" "+json_stringify({
        runtime_fps:game_get_speed(gamespeed_fps),logic_scale:timescale,original_savedata_unchanged:true}))
}
function scrNTTEFullSkinNativeMenuEnter() {
    scrNTTEFullSkinNativeMenuClear()
    if(file_exists(savegame_file)) file_delete(savegame_file)
    UberCont.want_quit_to_menu=true;instance_create(0,0,Vlambeer)
    scrNTTEFullSkinNativeMenuAwait(1)
}
function scrNTTEFullSkinNativeMenuPointer(_skin) {
    var _w=gui_w,_h=gui_h,_crownsize=sprite_get_height(sprLoadoutCrown)-4,
        _crowns_per_column=max(1,(_h-LETTERBOX_SIZE*4) div _crownsize),
        _crowns_per_row=array_length(scrNTTEFullCrownLoadoutSlots()) div _crowns_per_column,
        _crownleft=_w+12-_crowns_per_row*_crownsize,
        _slots=scrNTTEFullSkinSlots(target_race),_skinsize=sprite_get_width(sprLoadoutSkin)-4
    if(_skin) {
        var _slot=array_get_index(_slots,target_skin)
        assert(_slot>=0,"Fixture target skin absent from native slots")
        pointer_x=_crownleft-_crownsize div 2-22
        pointer_y=(_h div 2)-(_skinsize*0.5)*array_length(_slots)-2+_slot*_skinsize
    }
    else {pointer_x=_w+2-16;pointer_y=_h-LETTERBOX_SIZE+2-16}
    want_pointer=true;injected_phase=-1
}
function scrNTTEFullSkinNativeMenuArt() {
    var _case=cases[case_index],_base=scrNTTEFullNativeSprite("sprMutant"+string(target_race)+"Idle")
    assert(scrNTTEFullSkinTargetSprite(Player.id,_base,"body")==scrNTTERefSprite(_case.body),
        "Actual selected Player lost source body sprite mapping: "+skin_key)
    assert(scrNTTEFullSkinTargetSprite(Player.id,scrNTTERefSprite("TunnellerHUD"),"hud")==scrNTTERefSprite(_case.hud),
        "Actual selected Player lost source HUD sprite mapping: "+skin_key)
}
function scrNTTEFullSkinNativeMenuStepBody() {
    elapsed+=timescale
    assert(elapsed<=2700,"Skin native UI timeout "+string(case_index)+" phase="+string(phase))
    if(instance_exists(Player)) with(Player) {
        hp=100000;max_hp=100000;lsthealth=100000;nexthurt=current_frame+100000;speed=0;can_walk=false;can_aim=false
    }
    if(phase==0) {
        target_skin=cases[case_index].skin;target_race=cases[case_index].race;skin_key=scrNTTEFullSkinKey(target_skin)
        scrNTTEFullSkinNativeMenuClear()
        save_set_value("options","autopause",false);save_set_value("options","framerate",rates[pass_index])
        UberCont.opt_framerate=rates[pass_index];game_set_speed(rates[pass_index],gamespeed_fps)
        UberCont.opt_autopause=false;UberCont.paused=false;UberCont.want_pause=false
        UberCont.opt_freeze=0;UberCont.opt_bossintro=false
        UberCont.daily_run=false;UberCont.weekly_run=false;UberCont.coop=false;UberCont.hardmode=false
        UberCont.show_leaderboards_menu=false;global.is_server=true;global.index=0;global.custom_seed=0;global.seed=701932
        global.crownpick=crwn_none;global.recontinued_times=0
        scrGameCustomModeReset();scr_playerinstances_reset_all();my_player.race=Race.Fish;my_player.skin=0
        // Explicit preowned BASE race only; its MOD skin begins unowned.
        UberCont.cgot[target_race]=true
        // Original hidden Frog loadout requires this source achievement gate.
        save_set_value("achievement",Achievement.ULTRA_MUTANT,true)
        game_directory=scratch_root+string(rates[pass_index])+"-"+string(target_skin)+"/";directory_create(game_directory)
        var _files=["ntte-full-progress.json","ntte-full-progress.json.bak","ntte-full-progress.json.tmp","NuclearThrone.sav"]
        for(var _i=0;_i<array_length(_files);++_i) array_push(scratch_files,game_directory+_files[_i])
        global.ntte_full_progress={schema:1,unlocks:{},loadouts:{},stats:{}}
        global.ntte_full_feature_ready={};global.ntte_full_feature_ready[$ "skin:"+skin_key]=true
        save_set_value("game","tutorial",false);owned=false
        assert(!scr_race_is_skin_unlocked(target_race,target_skin),"Skin UI negative fixture unexpectedly owns target")
        scrNTTEFullSkinNativeMenuEnter();return;
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
        assert(instance_exists(Menu) && instance_exists(MenuGen),"Skin UI actual MainMenu/Play omitted character menu")
        menu=instance_find(Menu,0);selector=noone
        with(CharSelect) if(race==other.target_race) other.selector=id
        assert(instance_exists(selector),"Preowned base race missing from native menu")
        scrNTTEFullSkinNativeMenuActualRate("menu constructed")
        scrNTTEFullSkinNativeMenuAwait(2);return;
    }
    if(phase==2) {
        if(draw_frames-draw_start<3 || instance_exists(FloorMaker)) return;
        assert(selector.can,"Native CharSelect Draw rejected preowned base race")
        with(selector) event_perform(ev_mouse,ev_left_press)
        assert(my_player.race==target_race && selector.selected && GoButton.visible,"Native race selection failed")
        assert(scr_loadout_is_available_for_race(target_race),"Source base-race loadout gate remains closed")
        assert(!menu.loadout_open && menu.loadout_frame==0,"Native rebuilt menu unexpectedly opened loadout")
        scrNTTEFullSkinNativeMenuAwait(3);scrNTTEFullSkinNativeMenuPointer(false);return;
    }
    if(phase==3) {
        if(injected_phase!=3 || menu.loadout_frame<2) return;
        assert(menu.loadout_open,"Actual loadout arrow hitbox failed to open native panel")
        before_skin=my_player.skin;before_loadout=scr_loadout_race_get_skin(target_race)
        assert(before_skin!=target_skin,"Target already selected before actual skin click")
        scrNTTEFullSkinNativeMenuAwait(owned?5:4);scrNTTEFullSkinNativeMenuPointer(true);return;
    }
    if(phase==4) {
        if(injected_phase!=4 || draw_frames-draw_start<2) return;
        assert(my_player.skin==before_skin && scr_loadout_race_get_skin(target_race)==before_loadout
            && !scr_race_is_skin_unlocked(target_race,target_skin),"Actual locked skin hitbox accepted an unowned selection")
        scrNTTESmokeLog("SKIN UI LOCKED "+skin_key+": real arrow/fullview/locked-circle click rejected; now loading explicitly preowned fixture")
        // Deliberately preowned fixture data, not natural unlock evidence.
        global.ntte_full_progress.unlocks[$ "skin:"+skin_key]=true
        scrNTTEFullProgressSave();global.ntte_full_progress={schema:1,unlocks:{},loadouts:{},stats:{}}
        assert(scrNTTEFullProgressLoad() && scr_race_is_skin_unlocked(target_race,target_skin),"Preowned skin fixture JSON reload failed")
        owned=true;scrNTTEFullSkinNativeMenuEnter();return;
    }
    if(phase==5) {
        if(injected_phase!=5 || draw_frames-draw_start<2) return;
        assert(menu.loadout_open && menu.loadout_frame>=2 && my_player.skin==target_skin
            && scr_loadout_race_get_skin(target_race)==target_skin && scrNTTEFullSkinSaved(target_race)==target_skin,
            "Actual unlocked skin circle click failed native setter/slot selection")
        var _saved=scrNTTEFullSkinNativeMenuRead(game_directory+"ntte-full-progress.json")
        assert(!is_undefined(_saved) && json_parse(_saved).loadouts[$ "skin:"+string(target_race)]==skin_key,
            "Native skin hitbox did not persist the stable source key")
        scrNTTEFullSkinNativeMenuActualRate("actual skin hitbox before Go")
        with(GoButton) event_perform(ev_mouse,ev_left_press)
        assert(instance_number(Player)==1 && Player.race==target_race && Player.bskin==target_skin,"Native Go omitted selected skin")
        initial_player=Player.id;scrNTTEFullSkinNativeMenuAwait(6);return;
    }
    if(phase==6) {
        if(instance_exists(Menu) || instance_exists(MenuGen) || instance_exists(GenCont) || instance_exists(FloorMaker)) return;
        assert(instance_number(Player)==1 && Player.id==initial_player && Player.race==target_race && Player.bskin==target_skin
            && instance_number(Floor)>20 && instance_exists(TopCont),"Actual native restart lost selected skin/new-run world")
        scrNTTEFullSkinNativeMenuActualRate("actual room_restart world");scrNTTEFullSkinNativeMenuArt()
        saved_player=Player.id;scrSavegameSave();assert(file_exists(savegame_file),"Native selected skin continuation save missing")
        scrNTTEFullSkinNativeMenuClear();UberCont.want_quit_to_menu=false;instance_create(0,0,Vlambeer)
        scrNTTEFullSkinNativeMenuAwait(7);return;
    }
    if(phase==7) {
        if(instance_exists(GenCont) || instance_exists(FloorMaker)) return;
        assert(instance_number(Player)==1 && Player.id!=saved_player && Player.race==target_race && Player.bskin==target_skin
            && UberCont.continued_run && instance_number(Floor)>20,"Actual binary continuation lost selected skin/new Player/world")
        assert(scrNTTEFullSkinSaved(target_race)==target_skin && scr_race_is_skin_unlocked(target_race,target_skin),
            "Actual selected-skin continuation lost persisted ownership/loadout")
        scrNTTEFullSkinNativeMenuActualRate("actual binary continuation world");scrNTTEFullSkinNativeMenuArt()
        scrNTTEFullSkinNativeMenuAwait(8);return;
    }
    if(phase==8) {
        if(draw_frames-draw_start<8) return;
        scrNTTEFullSkinNativeMenuActualRate("continued eight real Draw frames")
        scrNTTESmokeLog("PASS SKIN NATIVE MENU "+skin_key+": locked rejection/preowned JSON reload/two real menus/native arrow+skin hitboxes/native Go+room_restart/body+HUD maps/binary continuation/new Player/eight Draw @"+string(rates[pass_index])+"; natural unlock tested separately")
        if(++case_index>=array_length(cases)) {case_index=0;pass_index++}
        if(pass_index<array_length(rates)) {scrNTTEFullSkinNativeMenuAwait(0);return;}
        scrNTTEFullSkinNativeMenuRestore()
        scrNTTESmokeLog("PASS full internal selected implemented branches x 30/60; not complete MOD coverage")
        game_end()
    }
}
function scrNTTEFullSkinNativeMenuStep() {
    try {scrNTTEFullSkinNativeMenuStepBody()}
    catch(_error) {scrNTTEFullSkinNativeMenuRestore();throw _error}
}

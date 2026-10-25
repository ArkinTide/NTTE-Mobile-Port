function scrNTTEPortalSelectionTransitionTests() {
    var _state=scrNTTEFullVanillaFixtureBegin(),_players=scrNTTEFullAreaGeneratorSnapshot(Player),
        _uber=scrNTTEFullAreaGeneratorSnapshot(UberCont),_back=scrNTTEFullAreaGeneratorSnapshot(BackCont),
        _keys=scrNTTEFullAreaGeneratorSnapshot(KeyCont),_music=scrNTTEFullAreaGeneratorSnapshot(MusCont),
        _parked=scrNTTEFullInstances([Portal,Corpse,LastDie,NTTEFullPet,SkillIcon,UltraIcon,CrownIcon]),
        _directory=game_directory,_map=UberCont.saveData,_clone=ds_map_create(),_skills=ds_list_create(),
        _progress=global.ntte_full_progress,_frame=current_frame,_stop=lockstep_stop,
        _draw=scrNTTEFullCoastDrawState(),_vx=view_xview,_vy=view_yview
    ds_map_copy(_clone,_map);UberCont.saveData=_clone
    ds_list_copy(_skills,GameCont.skills);GameCont.skills=_skills
    global.ntte_full_progress=json_parse(json_stringify(_progress))
    game_directory=working_directory+"portal-selection76-"+string(get_timer())+"/";directory_create(game_directory)
    for(var _i=0;_i<array_length(_parked);++_i) instance_deactivate_object(_parked[_i])
    try {
        lockstep_stop=false;GameCont.area=area_labs;GameCont.subarea=1;GameCont.loops=0
        GameCont.is_level_ended=false;GameCont.killenemies=0;GameCont.rad=0
        GameCont.skillpoints=2;GameCont.ultrapoints=0;GameCont.crownpoints=0;GameCont.level=4
        GameCont.patiencepick=false;GameCont.codpick=false;GameCont.ntte_full_native_skill_counts={}
        with(Player) {hp=max(hp,1);race=Race.Fish}
        var _area=GameCont.area,_subarea=GameCont.subarea,_waypoints=GameCont.waypoints,
            _lev=instance_create(0,0,LevCont),_choices=scrNTTEFullInstances(SkillIcon)
        assert(array_length(_choices)>1 && instance_number(LevCont)==1,"Native two-mutation fixture did not open real choices")
        GameCont.ntte_ally_portal_timer=0
        repeat(ceil(10*30/timescale)) {
            current_frame+=timescale
            with(GameCont) event_perform(ev_step,ev_step_normal)
            assert(!instance_exists(Corpse) && !instance_exists(Portal),
                "Portal recovery ran inside actual LevCont: it can restart selection and skip stages")
        }
        assert(instance_exists(_lev) && instance_number(LevCont)==1 && GameCont.skillpoints==2
            && GameCont.area==_area && GameCont.subarea==_subarea && GameCont.waypoints==_waypoints,
            "Waiting in native mutation selection changed the pending count or stage")
        // A corpse alarm queued before selection must also be harmless, even
        // when explicitly forceportal was set by a source-authored death.
        var _stale=instance_create(0,0,Corpse)
        _stale.forceportal=true
        with(_stale) event_perform(ev_alarm,0)
        assert(!instance_exists(Portal),"A stale native corpse alarm opened a portal inside mutation selection")
        instance_destroy(_stale,false)
        var _first=_choices[0],_skill=_first.skill,_old_count=scr_skill_get(_skill)
        with(_first) event_user(0)
        assert(GameCont.skillpoints==1 && scr_skill_get(_skill)==_old_count+1
            && instance_number(LevCont)==1 && !instance_exists(_lev) && !instance_exists(GenCont),
            "First actual SkillIcon.Select did not consume exactly one choice and retain the next selection")
        _lev=instance_find(LevCont,0);GameCont.ntte_ally_portal_timer=0
        repeat(ceil(3*30/timescale)) with(GameCont) event_perform(ev_step,ev_step_normal)
        assert(instance_exists(_lev) && !instance_exists(Corpse) && !instance_exists(Portal)
            && GameCont.area==_area && GameCont.subarea==_subarea,
            "Second mutation screen was interrupted or advanced the stage")
        with(instance_find(SkillIcon,0)) event_user(0)
        assert(GameCont.skillpoints==0 && !instance_exists(LevCont) && instance_number(GenCont)==1
            && GameCont.area==_area && GameCont.subarea==_subarea && GameCont.waypoints==_waypoints,
            "Final actual mutation choice failed exactly one generation start, or advanced the stage twice")
        GameCont.ntte_ally_portal_timer=0
        repeat(ceil(2*30/timescale)) with(GameCont) event_perform(ev_step,ev_step_normal)
        assert(!instance_exists(Portal) && !instance_exists(Corpse),"Portal recovery ran during actual generation")
        scrNTTEFullCavesFixtureCleanup(_state.baseline)
        GameCont.is_level_ended=true
        var _corpse=instance_create(0,0,Corpse)
        GameCont.ntte_ally_portal_timer=0
        with(GameCont) scrNTTEAllyPortalStep()
        with(_corpse) event_perform(ev_alarm,0)
        assert(!instance_exists(Portal) && _corpse.alarm[0]<0,"Completed stage rearmed a corpse/portal callback")
        GameCont.is_level_ended=false;lockstep_stop=true
        with(GameCont) scrNTTEAllyPortalStep()
        with(_corpse) event_perform(ev_alarm,0)
        assert(!instance_exists(Portal),"Paused corpse callback opened a portal")
        lockstep_stop=false
        var _floor=instance_create(0,0,Floor)
        with(_corpse) event_perform(ev_alarm,0)
        assert(instance_number(Portal)==1,"Actual empty combat room no longer opens its legitimate native portal")
        with(_corpse) event_perform(ev_alarm,0)
        assert(instance_number(Portal)==1,"Native retry duplicated an existing combat portal")
        scrNTTESmokeLog("PASS PORTAL SELECTION native10s LevCont wait, two actual SkillIcon selections -> one GenCont without stage/point drift; stale forced corpse alarms, ended/pause/generation guards and legitimate empty-room single portal @"+string(30/timescale))
    } finally {
        lockstep_stop=_stop;current_frame=_frame;global.ntte_full_progress=_progress
        scrNTTEFullAreaGeneratorRestore(_players);scrNTTEFullAreaGeneratorRestore(_uber)
        scrNTTEFullAreaGeneratorRestore(_back);scrNTTEFullAreaGeneratorRestore(_keys);scrNTTEFullAreaGeneratorRestore(_music)
        scrNTTEFullVanillaFixtureEnd(_state)
        for(var _i=0;_i<array_length(_parked);++_i) instance_activate_object(_parked[_i])
        UberCont.saveData=_map;ds_map_destroy(_clone);ds_list_destroy(_skills);game_directory=_directory
        view_xview=_vx;view_yview=_vy
        matrix_set(matrix_world,_draw.world);matrix_set(matrix_view,_draw.view);matrix_set(matrix_projection,_draw.projection)
    }
}
function scrNTTELanguagePreferencePersistenceTests() {
    var _state=scrNTTEFullMenuStats67Begin(),_language=global.language_current,
        _small=global.language_font_default,_big=global.language_font_bigname_default,_font=draw_get_font(),
        _cheats=global.cheats,_debug_names=["__debug_menu_options","__debug_hitboxes","__debug_health","__debug_immortality","__debug_teleportation","__debug_noreload","__debug_infammo"],
        _debug_values=[],_loaded=-1
    for(var _i=0;_i<array_length(_debug_names);++_i) {
        array_push(_debug_values,variable_global_get(_debug_names[_i]));variable_global_set(_debug_names[_i],false)
    }
    try {
        UberCont.public=true;save_set_value("options","framerate",game_get_speed(gamespeed_fps))
        for(var _practice=0;_practice<2;++_practice) {
            save_set_value("cheats","unlocked",true);save_set_value("cheats","orig_console",false)
            save_set_value("cheats","console",false);save_set_value("cheats","griller",false)
            save_set_value("cheats","practice",_practice==1);save_set_value("etc","language","English")
            save_set_value("fixture76","progress",123)
            var _path=game_directory+"NuclearThrone.sav",_initial=ds_map_create()
            _initial[? "etc_language"]="English";_initial[? "fixture76_progress"]=123
            _initial[? "cheats_unlocked"]=true;_initial[? "cheats_practice"]=_practice==1
            assert(scrPersistentJsonSave(_path,json_encode(_initial)),"Could not seed independent native save")
            ds_map_destroy(_initial);scrOptionsUpdate()
            assert(scr_debug_cheats_enabled()==(_practice==1),"Language test did not exercise both native save branches")
            var _menu=instance_create(0,0,MenuOptions),_rows=_menu.options[OptionCategory.Language],_row=undefined
            for(var _i=0;_i<array_length(_rows);++_i) if(_rows[_i][$ "language"]=="Simplified Chinese") _row=_rows[_i]
            assert(is_struct(_row),"Native language menu omitted Simplified Chinese")
            var _click=_row.click;_click(_row)
            var _saved=json_parse(scrPersistentJsonLoad(_path))
            assert(_saved[$ "etc_language"]=="Simplified Chinese",
                "Native language click did not immediately preserve Chinese on disk; practice="+string(_practice))
            scrSave();instance_destroy(_menu,false)
            _loaded=json_decode(scrPersistentJsonLoad(_path));UberCont.saveData=_loaded
            UberCont.opt_language=undefined;global.language_current={}
            scrOptionsUpdate()
            assert(UberCont.opt_language=="Simplified Chinese"
                && global.language_current[$ "Init:Id"]=="Simplified Chinese"
                && save_get_value("fixture76","progress",-1)==123,
                "Cold native disk/options reload lost Chinese or changed unrelated progress")
            // Reinitializing locale tables can leave the cached option intact.
            // The active table must be reapplied even when the option matches.
            global.language_current={};scrOptionsUpdate()
            assert(global.language_current[$ "Init:Id"]=="Simplified Chinese",
                "Cached opt_language suppressed language activation after locale reinitialization")
            UberCont.saveData=_state.clone;ds_map_destroy(_loaded);_loaded=-1
        }
        scrNTTESmokeLog("PASS LANGUAGE PERSIST native menu click immediate disk save, normal/practice whitelist, cold disk/options reload, cached locale reinitialization and unrelated progress preserved @"+string(30/timescale))
    } finally {
        if(_loaded>=0) {UberCont.saveData=_state.clone;ds_map_destroy(_loaded)}
        for(var _i=0;_i<array_length(_debug_names);++_i) variable_global_set(_debug_names[_i],_debug_values[_i])
        global.cheats=_cheats;global.language_current=_language
        global.language_font_default=_small;global.language_font_bigname_default=_big;draw_set_font(_font)
        scrNTTEFullMenuStats67End(_state)
    }
}

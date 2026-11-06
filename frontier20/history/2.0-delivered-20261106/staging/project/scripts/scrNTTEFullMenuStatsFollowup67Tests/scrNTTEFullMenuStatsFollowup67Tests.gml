// Real native menu draw and Player destruction, with private save files.
function scrNTTEFullMenuStats67Begin() {
    var _state={before:scrNTTEFullInstances(all),uber:scrNTTEFullAreaGeneratorSnapshot(UberCont),
        game:scrNTTEFullAreaGeneratorSnapshot(GameCont),back:scrNTTEFullAreaGeneratorSnapshot(BackCont),
        music:scrNTTEFullAreaGeneratorSnapshot(MusCont),keys:scrNTTEFullAreaGeneratorSnapshot(KeyCont),
        progress:global.ntte_full_progress,reminders:variable_global_exists("ntte_full_reminders")?global.ntte_full_reminders:undefined,
        directory:game_directory,map:UberCont.saveData,bytes:ds_map_write(UberCont.saveData),
        seed:random_get_seed(),frame:current_frame,stop:lockstep_stop,count:player_count,
        immortal:global.__debug_immortality,skills:ds_list_create(),clone:ds_map_create(),
        parked:scrNTTEFullInstances([Player,MenuOptions,BackButton,ResourcepackManager,CustomModeMenu,GameOver,SitDown,Cinematic,MenuGen])}
    ds_map_copy(_state.clone,_state.map);UberCont.saveData=_state.clone
    game_directory=working_directory+"menu-stats-followup67-"+string(get_timer())+"/";directory_create(game_directory)
    for(var _i=0;_i<array_length(_state.parked);++_i) instance_deactivate_object(_state.parked[_i])
    global.ntte_full_progress={schema:1,unlocks:{},loadouts:{},stats:{}};global.ntte_full_reminders=undefined
    GameCont.skills=_state.skills;GameCont.ntte_full_native_skill_counts={};GameCont.crown=crwn_none
    GameCont.area=area_palace;GameCont.subarea=3;GameCont.loops=0;GameCont.win=false;GameCont.underwater=false
    GameCont.ntte_full_active_coast=false
    UberCont.custom=false;UberCont.hardmode=false;UberCont.want_menu=true;UberCont.want_restart=false
    UberCont.cgot[Race.Melting]=true;UberCont.opt_practice=false
    lockstep_stop=false;global.__debug_immortality=false;player_count=1
    return _state
}
function scrNTTEFullMenuStats67End(_state) {
    scrNTTEFullMergedRuntimeTestCleanup(_state.before)
    for(var _i=0;_i<array_length(_state.parked);++_i) instance_activate_object(_state.parked[_i])
    scrNTTEFullAreaGeneratorRestore(_state.uber);scrNTTEFullAreaGeneratorRestore(_state.game)
    scrNTTEFullAreaGeneratorRestore(_state.back);scrNTTEFullAreaGeneratorRestore(_state.music)
    scrNTTEFullAreaGeneratorRestore(_state.keys)
    var _files=["ntte-full-progress.json","ntte-full-progress.json.bak","ntte-full-progress.json.tmp"]
    for(var _i=0;_i<array_length(_files);++_i) if(file_exists(game_directory+_files[_i])) file_delete(game_directory+_files[_i])
    global.ntte_full_progress=_state.progress;global.ntte_full_reminders=_state.reminders
    UberCont.saveData=_state.map;ds_map_destroy(_state.clone);game_directory=_state.directory
    current_frame=_state.frame;lockstep_stop=_state.stop;player_count=_state.count
    global.__debug_immortality=_state.immortal;random_set_seed(_state.seed);ds_list_destroy(_state.skills)
    assert(ds_map_write(_state.map)==_state.bytes,"Menu/stats regression changed the real native save map")
}
function scrNTTEFullMenuStats67Draw(_menu,_category,_only=undefined) {
    with(_menu) scrOptionsMenuChangeCategory(_category,false)
    if(is_struct(_only)) {_menu.items=[_only];_menu.item_count=1}
    _menu.last_change=current_frame-100;_menu.wait=true;_menu.mouse_active=false;_menu.pointed_item=-1
    _menu.slider=undefined;_menu.slider_change=0
    _menu.mx_last=device_mouse_x_to_gui(0);_menu.my_last=device_mouse_y_to_gui(0)
    KeyCont.press_nort[global.index]=false;KeyCont.press_sout[global.index]=false
    KeyCont.press_east[global.index]=false;KeyCont.press_west[global.index]=false
    with(_menu) event_perform(ev_draw,ev_gui)
}
function scrNTTEFullMenuReminderPersistenceNativeTests() {
    var _state=scrNTTEFullMenuStats67Begin(),_surface=-1,_camera=-1,_target=false,
        _draw=scrNTTEFullCoastDrawState(),_font=draw_get_font(),_ha=draw_get_halign(),_va=draw_get_valign(),_shader=shader_current()
    gpu_push_state()
    try {
        UberCont.opt_bossintro=false
        var _menu=instance_create(0,0,MenuOptions)
        assert(global.ntte_full_reminders[0].active && global.ntte_full_reminders[1].active,
            "Fresh unread profile lost its native settings guides")
        _surface=surface_create(ceil(gui_w),ceil(gui_h));assert(surface_exists(_surface),"Reminder render surface failed")
        _camera=camera_create_view(0,0,gui_w,gui_h,0,noone,-1,-1,-1,-1)
        surface_set_target(_surface);_target=true;camera_apply(_camera);matrix_set(matrix_world,matrix_build_identity())
        shader_reset();gpu_set_blendmode(bm_normal);draw_clear_alpha(c_black,1)
        scrNTTEFullMenuStats67Draw(_menu,OptionCategory.Main)
        var _pages=[OptionCategory.Game,OptionCategory.Audio]
        for(var _which=0;_which<2;++_which) {
            var _rows=_menu.options[_pages[_which]],_row=undefined
            for(var _i=0;_i<array_length(_rows);++_i)
                if(_rows[_i][$ "ntte_reminder_target"] && _rows[_i].ntte_reminder==_which) _row=_rows[_i]
            assert(is_struct(_row),"Native guide lost its actual option target")
            repeat(ceil(20/timescale)+1) scrNTTEFullMenuStats67Draw(_menu,_pages[_which],_row)
            assert(!global.ntte_full_reminders[_which].active
                && scrNTTEFullLoadoutGet(_which==0?"reminder:bossintro:seen":"reminder:music:seen",false),
                "Real native option Draw GUI failed to persist its completed guide")
        }
        var _path=game_directory+"ntte-full-progress.json",_bytes=scrNTTEFullMenuNativeFileBytes(_path),
            _backup=scrNTTEFullMenuNativeFileBytes(_path+".bak")
        repeat(4) scrNTTEFullMenuStats67Draw(_menu,OptionCategory.Main)
        assert(json_stringify(_bytes)==json_stringify(scrNTTEFullMenuNativeFileBytes(_path))
            && json_stringify(_backup)==json_stringify(scrNTTEFullMenuNativeFileBytes(_path+".bak")),
            "Read settings guides rewrote progress every frame")
        instance_destroy(_menu,false)
        global.ntte_full_progress={schema:1,unlocks:{},loadouts:{},stats:{}};global.ntte_full_reminders=undefined
        assert(scrNTTEFullProgressLoad(),"Private guide progress failed its real disk reload")
        _menu=instance_create(0,0,MenuOptions)
        assert(!global.ntte_full_reminders[0].active && !global.ntte_full_reminders[1].active,
            "Completed settings guides returned after genuine progress reload and menu reconstruction")
        instance_destroy(_menu,false)
        // Reminders OFF remains an independent existing preference.
        global.ntte_full_progress.loadouts={};scrNTTEFullOptionSet("reminders",false)
        global.ntte_full_reminders=undefined;_menu=instance_create(0,0,MenuOptions)
        assert(!global.ntte_full_reminders[0].active && !global.ntte_full_reminders[1].active,
            "Disabled reminders were forced on by the persistence repair")
    } finally {
        if(_target) surface_reset_target()
        if(_surface>=0 && surface_exists(_surface)) surface_free(_surface)
        if(_camera>=0) camera_destroy(_camera)
        gpu_pop_state();matrix_set(matrix_world,_draw.world);matrix_set(matrix_view,_draw.view);matrix_set(matrix_projection,_draw.projection)
        if(_shader>=0) shader_set(_shader);else shader_reset()
        draw_set_font(_font);draw_set_halign(_ha);draw_set_valign(_va);draw_set_color(_draw.color);draw_set_alpha(_draw.alpha)
        scrNTTEFullMenuStats67End(_state)
    }
    scrNTTESmokeLog("PASS settings reminder persistence: real MenuOptions Draw GUI, both completed guides, safe disk reload/rebuild, no repeated write and OFF unchanged @"+string(30/timescale))
}
function scrNTTEFullRunStats67Clear() {
    var _fields=["ctot_kill","ctot_dead","ctot_loop","ctot_time","ctot_runs","ctot_wins","ctot_days","ctot_hard","ctot_strk",
        "cbst_kill","cbst_race","cbst_area","cbst_suba","cbst_loop","cbst_diff","cbst_strk","cbst_fast",
        "hbst_kill","hbst_race","hbst_area","hbst_suba","hbst_loop","dbst_kill","dbst_race","dbst_area","dbst_suba","dbst_loop"]
    for(var _i=0;_i<array_length(_fields);++_i) variable_instance_set(UberCont,_fields[_i],array_create(Race.NUM_ALL_RACE_TYPES,0))
}
function scrNTTEFullPlayerRunStatsNativeTests() {
    var _state=scrNTTEFullMenuStats67Begin(),_cases=0
    try {
        scrNTTEFullRunStats67Clear()
        UberCont.cbst_kill[Race.Fish]=9;UberCont.cbst_area[Race.Fish]=1;UberCont.cbst_suba[Race.Fish]=2
        var _races=[Race.Crystal,17,18]
        for(var _i=0;_i<array_length(_races);++_i) {
            var _race=_races[_i],_p=scrNTTEFullDeath64Player()
            _p.race=_race;GameCont.kills=300+_i;GameCont.hard=1
            // Real Destroy, including the authored best-run/end-stat call.
            instance_destroy(_p)
            assert(!instance_exists(_p) && UberCont.cbst_area[_race]==7 && UberCont.cbst_suba[_race]==3
                && UberCont.cbst_race[_race]==_race && UberCont.cbst_kill[_race]==300+_i
                && UberCont.ctot_kill[_race]==300+_i && UberCont.ctot_dead[_race]==1
                && UberCont.cbst_area[Race.Fish]==1 && UberCont.cbst_suba[Race.Fish]==2,
                "Actual Player.Destroy wrote the 7-3 result to the wrong race or lost its end counters")
            GameCont.area=1;GameCont.subarea=2;GameCont.kills=2
            _p=scrNTTEFullDeath64Player();_p.race=_race;instance_destroy(_p)
            assert(UberCont.cbst_area[_race]==7 && UberCont.cbst_suba[_race]==3 && UberCont.cbst_kill[_race]==300+_i,
                "A later low-kill run replaced the original higher best run")
            GameCont.area=7;GameCont.subarea=3;_cases+=2
        }
        UberCont.hardmode=true;GameCont.kills=100
        var _p=scrNTTEFullDeath64Player();_p.race=18;instance_destroy(_p)
        assert(UberCont.hbst_area[18]==7 && UberCont.hbst_suba[18]==3 && UberCont.hbst_kill[18]==100
            && UberCont.cbst_kill[18]==302,"Hard-mode result leaked into the normal best record")
        _cases++
        UberCont.custom=true;GameCont.kills=9999
        _p=scrNTTEFullDeath64Player();_p.race=18;instance_destroy(_p)
        assert(UberCont.hbst_kill[18]==100 && UberCont.cbst_kill[18]==302,
            "Custom-mode result bypassed the existing native best-run exclusion")
        _cases++
        UberCont.custom=false;UberCont.hardmode=false;UberCont.opt_practice=true
        // Use the helper's fully initialized Fish for the ordinary practice
        // lifecycle; changing only race would not initialize Parrot abilities.
        _p=scrNTTEFullDeath64Player();_p.hp=0
        scrNTTEFullDeath64Step(_p)
        assert(instance_exists(_p) && _p.fainted==CHEAT_PRACTICE_FAINTED_TIME
            && UberCont.cbst_kill[Race.Fish]==9 && UberCont.cbst_kill[18]==302,
            "Practice fainting was incorrectly converted into a recorded terminal run")
        instance_destroy(_p,false);_cases++
    } finally {scrNTTEFullMenuStats67End(_state)}
    scrNTTESmokeLog("PASS player run stats: actual Player.Destroy native/Beetle/Parrot 7-3 and end counters, lower scores preserved, hard/custom separation and practice faint unchanged cases="+string(_cases)+" @"+string(30/timescale))
}
function scrNTTEFullRunStatsTotalDrawNativeTests() {
    var _state=scrNTTEFullMenuStats67Begin(),_surfaces=[],_buffers=[],_camera=-1,_target=false,
        _draw=scrNTTEFullCoastDrawState(),_font=draw_get_font(),_ha=draw_get_halign(),_va=draw_get_valign(),_shader=shader_current()
    gpu_push_state()
    try {
        scrNTTEFullRunStats67Clear();UberCont.hardgot=false
        var _width=ceil(view_width),_height=ceil(view_height),_context=instance_create(0,0,PopupText)
        _context.select=0;_context.progress=0;_context.maxprogress=1
        _camera=camera_create_view(view_xview,view_yview,_width,_height,0,noone,-1,-1,-1,-1)
        // A valid NTTE Parrot record must render exactly like the same saved
        // record placed in a vanilla slot, still naming its original race.
        for(var _pass=0;_pass<2;++_pass) {
            scrNTTEFullRunStats67Clear()
            var _slot=_pass==0?18:Race.Fish
            UberCont.ctot_runs[_slot]=1;UberCont.ctot_dead[_slot]=1;UberCont.ctot_kill[_slot]=302
            UberCont.cbst_race[_slot]=18;UberCont.cbst_area[_slot]=7;UberCont.cbst_suba[_slot]=3;UberCont.cbst_kill[_slot]=302
            var _surface=surface_create(_width,_height),_buffer=buffer_create(_width*_height*4,buffer_fixed,1)
            array_push(_surfaces,_surface);array_push(_buffers,_buffer)
            assert(surface_exists(_surface),"Total-stat render surface allocation failed")
            surface_set_target(_surface);_target=true;camera_apply(_camera);matrix_set(matrix_world,matrix_build_identity())
            shader_reset();gpu_set_blendmode(bm_normal);draw_clear_alpha(c_black,1)
            with(_context) event_perform_object(DrawStats,ev_draw,ev_draw_normal)
            surface_reset_target();_target=false;buffer_get_surface(_buffer,_surface,0)
        }
        var _painted=0
        for(var _offset=0;_offset<_width*_height*4;_offset+=4) {
            var _a=buffer_peek(_buffers[0],_offset,buffer_u32),_b=buffer_peek(_buffers[1],_offset,buffer_u32)
            assert(_a==_b,"Actual general-stat Draw omitted the NTTE total/best 7-3 record at pixel="+string(_offset div 4))
            if((_a & $ffffff)!=0) _painted++
        }
        assert(_painted>40,"General-stat comparison rendered an empty surface")
    } finally {
        if(_target) surface_reset_target()
        for(var _i=0;_i<array_length(_surfaces);++_i) if(surface_exists(_surfaces[_i])) surface_free(_surfaces[_i])
        for(var _i=0;_i<array_length(_buffers);++_i) buffer_delete(_buffers[_i])
        if(_camera>=0) camera_destroy(_camera)
        gpu_pop_state();matrix_set(matrix_world,_draw.world);matrix_set(matrix_view,_draw.view);matrix_set(matrix_projection,_draw.projection)
        if(_shader>=0) shader_set(_shader);else shader_reset()
        draw_set_font(_font);draw_set_halign(_ha);draw_set_valign(_va);draw_set_color(_draw.color);draw_set_alpha(_draw.alpha)
        scrNTTEFullMenuStats67End(_state)
    }
    scrNTTESmokeLog("PASS total run stats draw: real DrawStats.Draw all NTTE totals and Parrot 7-3 best record pixel-identical to equivalent native-slot record @"+string(30/timescale))
}

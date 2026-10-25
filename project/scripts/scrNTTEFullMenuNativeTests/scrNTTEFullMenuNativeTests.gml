function scrNTTEFullMusicBossRoutingTests() {
    var _game=scrNTTEFullAreaGeneratorSnapshot(GameCont),_mus=instance_find(MusCont,0),
        _music=scrNTTEFullAreaGeneratorSnapshot(MusCont),_before=scrNTTEFullInstances(all)
    try {
        if(!instance_exists(_mus)) _mus=instance_create(0,0,MusCont)
        var _keys=["CatBat","SealKing","PitSquid","Tesseract"]
        for(var _i=0;_i<array_length(_keys);++_i) {
            GameCont.area=area_palace;GameCont.subarea=3
            GameCont.ntte_full_boss_music_key=_keys[_i]
            with(_mus) {
                assert(!scrNTTEFullMusicBoss(),"Stale custom boss key overrode native Throne music")
                event_perform(ev_alarm,2)
                assert(song==custom_sound_check(musBoss4A),"Actual Throne boss alarm selected the wrong track")
            }
        }
        GameCont.area=205;GameCont.ntte_full_boss_music_key="PitSquid"
        GameCont.ntte_full_pitsquid_intro_start=false
        with(_mus) {
            assert(scrNTTEFullMusicBoss() && song==scrNTTERefSound("mus.PitSquid"),
                "Valid Trench boss music was lost while rejecting stale keys")
            scrNTTEFullMusicCancelIntro()
        }
    } finally {
        if(instance_exists(_mus)) with(_mus) {scrNTTEFullMusicCancelIntro();audio_stop_sound(song)}
        scrNTTEFullMergedRuntimeTestCleanup(_before)
        scrNTTEFullAreaGeneratorRestore(_game);scrNTTEFullAreaGeneratorRestore(_music)
    }
    scrNTTESmokeLog("MUSIC ROUTING: actual MusCont Alarm2 keeps Throne 7-3 native track after four stale MOD boss keys; valid PitSquid cue retained @"+string(30/timescale))
}
function scrNTTEFullMenuNativeFileBytes(_path) {
    if(!file_exists(_path)) return undefined
    var _buffer=buffer_load(_path),_bytes=[]
    try {
        _bytes=array_create(buffer_get_size(_buffer),0)
        for(var _i=0;_i<array_length(_bytes);++_i) _bytes[_i]=buffer_peek(_buffer,_i,buffer_u8)
    } finally { buffer_delete(_buffer) }
    return _bytes
}
function scrNTTEFullMenuNativeRenderTests(_menu) {
    var _rows=_menu.options[OptionCategory.NTTE_Options],_trace={rows:array_create(8,0)},
        _draws=[],_values=[0,0.5,1],_old_values=[_rows[6].value,_rows[7].value],
        _surface=-1,_camera=-1,_target=false,_draw=scrNTTEFullCoastDrawState(),
        _font=draw_get_font(),_halign=draw_get_halign(),_valign=draw_get_valign(),_shader=shader_current(),
        _progress_before=json_stringify(global.ntte_full_progress),_options_before=ds_map_write(UberCont.saveData)
    assert(array_length(_rows)==8 && _menu.item_count==8 && array_length(_menu.items)==8,
        "NTTE options render must retain all eight original native rows")
    gpu_push_state()
    try {
        _surface=surface_create(ceil(gui_w),ceil(gui_h))
        assert(surface_exists(_surface),"Native NTTE options render target allocation failed")
        _camera=camera_create_view(0,0,gui_w,gui_h,0,noone,-1,-1,-1,-1)
        surface_set_target(_surface);_target=true;camera_apply(_camera)
        matrix_set(matrix_world,matrix_build_identity());shader_reset();gpu_set_blendmode(bm_normal)
        draw_set_alpha(1)
        for(var _i=0;_i<8;++_i) {
            array_push(_draws,_rows[_i].draw)
            assert(is_undefined(_rows[_i].draw) && _rows[_i].visible,
                "Native NTTE settings row unexpectedly replaced/hidden before render")
            // Observe the real row traversal and return false so the complete
            // original native renderer, including scalar_slider, still runs.
            _rows[_i].ntte_render_probe=_trace;_rows[_i].ntte_render_row=_i
            _rows[_i].draw=method(_rows[_i],function(_opt) {
                _opt.ntte_render_probe.rows[_opt.ntte_render_row]++
                return false
            })
        }
        for(var _pass=0;_pass<array_length(_values);++_pass) {
            var _value=_values[_pass]
            _rows[6].value=_value;_rows[7].value=_value;_trace.rows=array_create(8,0)
            for(var _i=0;_i<8;++_i) {_rows[_i].anim=0;_rows[_i].splat=0}
            // Finish the native appearance gate without removing any row.
            // Neutral input prevents this rendering regression from clicking.
            _menu.last_change=current_frame-100;_menu.wait=true;_menu.mouse_active=false
            _menu.pointed_item=-1;_menu.slider=undefined;_menu.slider_change=0
            _menu.mx_last=device_mouse_x_to_gui(0);_menu.my_last=device_mouse_y_to_gui(0)
            draw_clear_alpha(c_black,0)
            scrNTTESmokeLog("NTTE OPTIONS NATIVE DRAW BEGIN value="+string(_value)+" @"+string(30/timescale))
            // Dispatch Draw GUI only. The unchanged native event owns its
            // Draw64 -> User1 -> User0 chain and percentage multiplication.
            // Baseline reaches its original DoMul error before the checks below.
            with(_menu) event_perform(ev_draw,ev_gui)
            assert(real(surface_get_target())==real(_surface),"Native options Draw GUI lost isolated render target")
            for(var _i=0;_i<8;++_i) assert(_trace.rows[_i]==1,
                "Actual native Draw GUI skipped/repeated NTTE settings row "+string(_i))
            for(var _i=6;_i<8;++_i) {
                var _row=_rows[_i],_actual=method_execute(_row.get_value,_row)
                assert(_row.type=="slider" && _row.scalar_slider && is_numeric(_actual) && _actual==_value && _row.value==_value,
                    "Native scalar slider must receive and retain numeric raw0/0.5/1 value")
            }
            assert(json_stringify(global.ntte_full_progress)==_progress_before && ds_map_write(UberCont.saveData)==_options_before,
                "Rendering NTTE settings changed progress or native saved options")
            scrNTTESmokeLog("NTTE OPTIONS NATIVE DRAW END eightRows=8 numericSliders=2 retained="+string(_value)+" @"+string(30/timescale))
        }
    } finally {
        for(var _i=0;_i<array_length(_draws);++_i) _rows[_i].draw=_draws[_i]
        _rows[6].value=_old_values[0];_rows[7].value=_old_values[1]
        if(_target) surface_reset_target()
        if(_surface>=0 && surface_exists(_surface)) surface_free(_surface)
        if(_camera>=0) camera_destroy(_camera)
        gpu_pop_state()
        matrix_set(matrix_world,_draw.world);matrix_set(matrix_view,_draw.view);matrix_set(matrix_projection,_draw.projection)
        if(_shader>=0) shader_set(_shader);else shader_reset()
        draw_set_font(_font);draw_set_halign(_halign);draw_set_valign(_valign)
        draw_set_color(_draw.color);draw_set_alpha(_draw.alpha)
    }
}
function scrNTTEFullMenuNativeTests() {
    var _before=scrNTTEFullInstances(all),_progress=global.ntte_full_progress,
        _parked=scrNTTEFullInstances([MenuOptions,BackButton,ResourcepackManager,CustomModeMenu]),_seed=random_get_seed(),
        _uber=scrNTTEFullAreaGeneratorSnapshot(UberCont),_menu=noone,
        _keys=scrNTTEFullAreaGeneratorSnapshot(KeyCont),_old_directory=game_directory,
        _old_save_map=UberCont.saveData,_old_savedata=ds_map_write(UberCont.saveData),_fixture_save_map=ds_map_create(),
        _file_names=["ntte-full-progress.json","ntte-full-progress.json.bak","ntte-full-progress.json.tmp"],_original_files=[],
        _reminders=variable_global_exists("ntte_full_reminders")?global.ntte_full_reminders:undefined
    for(var _i=0;_i<array_length(_file_names);++_i)
        array_push(_original_files,json_stringify(scrNTTEFullMenuNativeFileBytes(_old_directory+_file_names[_i])))
    ds_map_copy(_fixture_save_map,_old_save_map);UberCont.saveData=_fixture_save_map
    game_directory=working_directory+"menu-native-render-"+string(get_timer())+"/";directory_create(game_directory)
    for(var _i=0;_i<array_length(_parked);++_i) instance_deactivate_object(_parked[_i])
    global.ntte_full_progress={schema:1,unlocks:{},loadouts:{},stats:{}}
    try {
        assert(scrNTTEFullOptionRaw("shaders")==1 && scrNTTEFullOptionRaw("intros")==2
            && scrNTTEFullOptionRaw("outline:pets")==2,"Original menu option defaults changed")
        UberCont.opt_bossintro=false
        assert(!scrNTTEFullOptionGet("intros"),"AUTO intro ignored native boss intro preference")
        UberCont.opt_bossintro=true
        assert(scrNTTEFullOptionGet("intros"),"AUTO intro lost enabled native preference")
        assert(abs(scrNTTEFullOptionGet("quality:main")-scrNTTEFullSourceDisplayScale())<0.001,
            "Original default quality did not resolve screen scale")
        assert(scrNTTEFullMenuTime(3661.9)=="1:01:01","Source h:mm:ss stats display diverged")
        _menu=instance_create(0,0,MenuOptions)
        scrNTTEFullMenuFeatureFollowupTests(_menu)
        var _guides=0
        with(_menu) {
            var _pages=[OptionCategory.Main,OptionCategory.Game,OptionCategory.Audio]
            for(var _p=0;_p<array_length(_pages);++_p) {
                var _rows=options[_pages[_p]]
                for(var _i=0;_i<array_length(_rows);++_i)
                    if(!is_undefined(_rows[_i][$ "ntte_reminder"])) {_guides++;}
            }
        }
        assert(_guides==4,"Source reminder paths omitted native settings entry or target row")
        var _remind={active:true,time:0,text:"Turn em on!"}
        assert(!scrNTTEFullMenuReminderTick(_remind,false) && _remind.time==20,
            "Source reminder did not guide to target option before timing")
        repeat(ceil(20/timescale)) scrNTTEFullMenuReminderTick(_remind,true)
        assert(!_remind.active,"Source twenty-tick reminder did not finish at actual frame scale")
        var _hidden_pet=_menu.options[OptionCategory.NTTE_Pets][0]
        assert(!method_execute(_hidden_pet.condition,_hidden_pet),"Unknown pet leaked its detail page")
        assert(array_length(_menu.options[OptionCategory.NTTE_Options])==8,
            "Actual native options construction omitted NTTE settings")
        var _main=_menu.options[OptionCategory.Main],_entries=0
        for(var _i=0;_i<array_length(_main);++_i) if(_main[_i].category==OptionCategory.NTTE) {_entries++;}
        assert(_entries==1,"NTTE native main settings entry duplicated/missing")
        with(_menu) scrOptionsMenuChangeCategory(OptionCategory.NTTE_Options)
        assert(_menu.item_count==8 && _menu.category==OptionCategory.NTTE_Options,
            "Native settings navigation failed")
        KeyCont.press_nort[global.index]=false;KeyCont.press_sout[global.index]=false
        KeyCont.press_east[global.index]=false;KeyCont.press_west[global.index]=false
        scrNTTEFullMenuNativeRenderTests(_menu)
        var _foot=_menu.options[OptionCategory.NTTE_Options][2]
        method_execute(_foot.click,_foot)
        assert(scrNTTEFullOptionRaw("footprints")==0 && !scrNTTEFullOptionGet("footprints"),
            "Native actual option click did not persist source setting")
        method_execute(_foot.click,_foot)
        assert(scrNTTEFullOptionRaw("footprints")==1,"Native setting could not toggle back")
        var _q=_menu.options[OptionCategory.NTTE_Options][6]
        _q.value=0;method_execute(_q.click,_q)
        assert(abs(scrNTTEFullOptionGet("quality:main")-1/3)<0.0001,
            "Native quality slider did not preserve source lower resolution bound")
        global.ntte_full_progress.stats[$ "race:beetle:runs"]=17
        global.ntte_full_progress.stats[$ "race:parrot:time"]=3661
        assert(scrNTTEFullMenuStatText("race:beetle:runs")=="17"
            && scrNTTEFullMenuStatText("race:parrot:time","time")=="1:01:01",
            "Native stats page read invented counters")
        var _pets=scrNTTEFullMenuPets()
        assert(array_length(_pets)==14 && array_length(_menu.options[OptionCategory.NTTE_Pets])==14,
            "Original fourteen pet collection entries missing")
        global.ntte_full_progress.stats[$ "pet:Cuz.petlib.mod"]={found:1,owned:3661,playtime:61}
        with(_menu) scrNTTEFullMenuPetPage("Cuz")
        assert(_menu.category==OptionCategory.NTTE_PetDetails
            && array_length(_menu.options[OptionCategory.NTTE_PetDetails])==4
            && scrNTTEFullMenuPetValue("Cuz","owned")=="1:01:01"
            && scrNTTEFullMenuPetValue("Cuz","playtime")=="0:01:01",
            "Actual native pet detail page lost saved species-specific statistics")
        assert(array_length(_menu.options[OptionCategory.NTTE_Unlocks])==8
            && array_length(_menu.options[OptionCategory.NTTE_Credits])==10,
            "Original six pack unlocks/time/bones or MOD contributors omitted")
        // Rebuild uses native categories, preserving one entry on refresh.
        with(_menu) event_user(10)
        _main=_menu.options[OptionCategory.Main];_entries=0
        for(var _i=0;_i<array_length(_main);++_i) if(_main[_i].category==OptionCategory.NTTE) {_entries++;}
        assert(_entries==1,"Native menu refresh accumulated duplicate NTTE entry")
    }
    finally {
        scrNTTEFullMergedRuntimeTestCleanup(_before)
        for(var _i=0;_i<array_length(_parked);++_i) instance_activate_object(_parked[_i])
        for(var _i=0;_i<array_length(_file_names);++_i)
            if(file_exists(game_directory+_file_names[_i])) file_delete(game_directory+_file_names[_i])
        global.ntte_full_progress=_progress;game_directory=_old_directory
        global.ntte_full_reminders=_reminders
        scrNTTEFullAreaGeneratorRestore(_keys);scrNTTEFullAreaGeneratorRestore(_uber)
        UberCont.saveData=_old_save_map;ds_map_destroy(_fixture_save_map);random_set_seed(_seed)
        assert(ds_map_write(_old_save_map)==_old_savedata,"Native menu fixture leaked original saved options")
        for(var _i=0;_i<array_length(_file_names);++_i)
            assert(json_stringify(scrNTTEFullMenuNativeFileBytes(_old_directory+_file_names[_i]))==_original_files[_i],
                "Native menu fixture changed original progress/backup/temp file bytes")
    }
    scrNTTESmokeLog("FULL NATIVE NTTE MENU: actual MenuOptions construct/click/navigation/rebuild, native Draw GUI->User1->User0 all eight source rows, scalar sliders numeric0/0.5/1+unchanged values/save/options, AUTO+quality policy, two mutant stats, fourteen pets+specific saved details, six packs/time/bones and original contributors OK @"+string(30/timescale))
}

// BEGIN FOLLOWUP MENU FEATURES
function scrNTTEFullMenuFeatureFollowupTests(_menu) {
    scrNTTEFullParrotToggleFollowupTests(_menu)
    scrNTTEFullCustomMutationRenderTests()
    scrNTTEFullAchievementsFollowupTests()
    for(var _i=1;_i<=3;++_i) {
        var _expected="@1("+string(scrNTTERefSprite("RouteIcon"))+":0)1-"+string(_i)
        assert(scrAreaGetMapName(201,_i,0,false,false)==_expected
            && scrAreaGetMapName(201,_i,0,false,true)==_expected
            && scrNTTEFullWarpAreaName(201,_i,0)==_expected,"Coast display numbering differs across native displays")
        assert(scrAreaGetMapName(201,_i,1,false,false)==_expected+" L1"
            && scrAreaGetMapName(201,_i,1,true,false)==_expected+" H1","Coast display lost loop/hard suffix")
    }
    assert(scrAreaGetMapName(203,1,0,false,false)=="2-@2(sprSlice:0)"
        && scrAreaGetMapName(204,1,0,false,false)=="2-?"
        && scrNTTEFullWarpAreaName(203,1,0)=="2-@2(sprSlice:0)" && scrNTTEFullWarpAreaName(204,1,0)=="2-?"
        && scrAreaGetMapName(1,1,0,false,false)=="1-1","Pizza/Lair display mapping or vanilla Desert numbering changed")
    assert(scrNTTEFullAreaInfo("coast").background==make_color_rgb(42,145,205),"Coast brighter blue was not installed")
    scrNTTEFullBonusHUDOverlapTests()
    scrNTTEFullLocalizationFollowupTests(_menu)
    scrNTTEFullStartupFollowupTests()
    scrNTTESmokeLog("FOLLOWUP MENU: Parrot toggle, actual custom portraits, original achievement menu/notice, stage names and full bonus HUD verified")
}
function scrNTTEFullParrotToggleFollowupTests(_menu) {
    var _p=instance_find(Player,0),_players=scrNTTEFullAreaGeneratorSnapshot(Player),
        _keys=scrNTTEFullAreaGeneratorSnapshot(KeyCont),_uber=scrNTTEFullAreaGeneratorSnapshot(UberCont),
        _pi=scr_playerinstance_find(_p.index),_prefs=_pi.cprefs,_mobile=is_mobile,
        _before=scrNTTEFullInstances(all),_bit=1<<(array_get_index(UberCont.cpref_list,"parrot")+1)
    try {
        assert(array_get_index(UberCont.cpref_list,"parrot")==8,"Parrot preference shifted existing preference bits")
        var _rows=_menu.options[OptionCategory.Controls_Preferences],_found=0
        for(var _i=0;_i<array_length(_rows);++_i) if(_rows[_i].key=="cprefs_parrot") {
            _found++;assert(string_pos(sprite_get_name(scrNTTEFullRaceSprite(NTTEFullRace.Parrot,"Map",0)),
                method_execute(_rows[_i].get_name,_rows[_i]))>0,"Parrot preference used wrong native character icon")
        }
        assert(_found==1,"Parrot toggle preference missing or duplicated")
        _p.race=NTTEFullRace.Parrot;_pi.cprefs|=_bit;UberCont.paused=false
        KeyCont.activeforever[_p.index]=false
        for(var _pass=0;_pass<4;++_pass) {
            KeyCont.press_spec[_p.index]=_pass==0 || _pass==3
            KeyCont.hold_spec[_p.index]=_pass<2
            KeyCont.release_spec[_p.index]=_pass==2
            scrNTTEFullParrotToggleInput(_p.index)
            assert(KeyCont.activeforever[_p.index]==(_pass<3) && KeyCont.hold_spec[_p.index]==(_pass<3)
                && KeyCont.press_spec[_p.index]==(_pass==0),"Parrot sampled input did not latch on, survive hold/release and switch off on second press")
        }
        KeyCont.activeforever[_p.index]=true;UberCont.paused=true
        KeyCont.press_spec[_p.index]=true;scrNTTEFullParrotToggleInput(_p.index)
        assert(KeyCont.activeforever[_p.index] && !KeyCont.press_spec[_p.index],"Pause-menu input toggled Parrot skill")
        UberCont.paused=false;_pi.cprefs&=~_bit
        KeyCont.hold_spec[_p.index]=false;KeyCont.press_spec[_p.index]=false;scrNTTEFullParrotToggleInput(_p.index)
        assert(!KeyCont.hold_spec[_p.index],"Disabled Parrot preference failed to preserve original raw hold input")
        _pi.cprefs|=_bit;is_mobile=true
        var _button=instance_create(180,100,ButtonActive)
        assert(_button.can_forever(_p),"Real touch button did not recognize Parrot preference")
        KeyCont.activeforever[_p.index]=false;_button.volume_control_command=1
        with(_button) event_perform(ev_other,ev_user0)
        assert(KeyCont.activeforever[_p.index] && KeyCont.hold_spec[_p.index] && KeyCont.press_spec[_p.index],
            "Actual touch event failed first press dispatch")
        _button.volume_control_command=0
        with(_button) event_perform(ev_other,ev_user0)
        assert(KeyCont.hold_spec[_p.index] && !KeyCont.press_spec[_p.index],"Actual touch release recalled toggled feathers")
        _button.volume_control_command=1
        with(_button) event_perform(ev_other,ev_user0)
        assert(!KeyCont.activeforever[_p.index] && !KeyCont.hold_spec[_p.index],"Actual touch second press did not recall")
        KeyCont.activeforever[_p.index]=true
        with(_p) scrPlayerRaceChange(Race.Fish)
        assert(!KeyCont.activeforever[_p.index],"Changing away from Parrot leaked active skill latch")
    } finally {
        scrNTTEFullMergedRuntimeTestCleanup(_before);is_mobile=_mobile;_pi.cprefs=_prefs
        scrNTTEFullAreaGeneratorRestore(_players);scrNTTEFullAreaGeneratorRestore(_keys);scrNTTEFullAreaGeneratorRestore(_uber)
    }
}
function scrNTTEFullCustomMutationRenderTests() {
    var _before=scrNTTEFullInstances(all),_uber=scrNTTEFullAreaGeneratorSnapshot(UberCont),
        _draw=scrNTTEFullCoastDrawState(),_font=draw_get_font(),_ha=draw_get_halign(),_va=draw_get_valign(),
        _shader=shader_current(),_surface=-1,_reference=-1,_camera=-1,_target=false
    gpu_push_state()
    try {
        UberCont.custom=true;UberCont.custom_options=new CustomModeOptions("NTTE portrait check")
        UberCont.custom_options.skill_start=[]
        var _selector=instance_create(0,0,CustomModeSkillSelector),_h=max(512,ceil(gui_h)),_w=ceil(gui_w)
        _selector.scroll=0;_selector.dragging=true
        _surface=surface_create(_w,_h);_reference=surface_create(_w,_h)
        _camera=camera_create_view(0,0,_w,_h,0,noone,-1,-1,-1,-1)
        var _art=["Annihilation.HUD","BatEars.HUD","Compassion.Icon","LeadRibs.HUD",
            "MagneticPulse.HUD","Reroll.HUD","SilverTongue.Icon","ToadBreath.HUD"]
        for(var _pass=0;_pass<2;++_pass) {
            UberCont.custom_options.skill_start=_pass==0?[]:[1,30,31,32,33,34,35,36,37]
            surface_set_target(_surface);_target=true;camera_apply(_camera)
            matrix_set(matrix_world,matrix_build_identity());shader_reset();gpu_set_blendmode(bm_normal)
            gpu_set_texfilter(false);draw_set_color(c_white);draw_set_alpha(1);draw_clear_alpha(c_black,1)
            with(_selector) event_perform(ev_other,ev_user0)
            surface_reset_target();_target=false
            var _x=gui_w div 6,_y=LETTERBOX_SIZE+40,_step=sprite_get_width(sprSkillIcon)+4,
                _width=gui_w-_x,_start=_x
            for(var _i=1;_i<=maxskill;++_i) {
                if(_i==1 || _i>=30) {
                    var _sprite=_i<30?sprSkillIcon:scrNTTERefSprite("Skill."+_art[_i-30]),_frame=_i<30?_i:0,
                        _enabled=_pass==1
                    assert(sprite_exists(_sprite),"Missing source custom mutation portrait")
                    surface_set_target(_reference);_target=true;camera_apply(_camera)
                    draw_clear_alpha(c_black,1);draw_set_color(c_white);draw_set_alpha(1)
                    if(_enabled) draw_rectangle(_x-13,_y-17,_x+12,_y+16,false)
                    draw_sprite_ext(_sprite,_frame,_x,_y,1,1,0,_enabled?c_white:c_gray,1)
                    if(_enabled) draw_sprite(sprCustomModeWeaponYes,0,_x,_y)
                    surface_reset_target();_target=false
                    var _visible=0
                    for(var _dy=-16;_dy<16;++_dy) for(var _dx=-12;_dx<12;++_dx) {
                        var _a=surface_getpixel(_surface,_x+_dx,_y+_dy),_b=surface_getpixel(_reference,_x+_dx,_y+_dy)
                        assert(_a==_b,"Actual custom selector portrait pixel mismatch id="+string(_i)+" selected="+string(_enabled))
                        if(_b!=c_black) _visible++
                    }
                    assert(_visible>4,"Custom mutation portrait is blank")
                }
                _x+=_step
                if(_x>=_width) {_x=_start;_y+=sprite_get_height(sprSkillIcon)+4}
            }
            surface_save(_surface,working_directory+"ntte-custom-portraits-"+string(_pass)+"-"+string(30/timescale)+".png")
        }
    } finally {
        if(_target) surface_reset_target()
        if(surface_exists(_surface)) surface_free(_surface)
        if(surface_exists(_reference)) surface_free(_reference)
        if(_camera!=-1) camera_destroy(_camera)
        gpu_pop_state();matrix_set(matrix_world,_draw.world);matrix_set(matrix_view,_draw.view);matrix_set(matrix_projection,_draw.projection)
        if(_shader>=0) shader_set(_shader);else shader_reset()
        draw_set_font(_font);draw_set_halign(_ha);draw_set_valign(_va);draw_set_color(_draw.color);draw_set_alpha(_draw.alpha)
        scrNTTEFullMergedRuntimeTestCleanup(_before);scrNTTEFullAreaGeneratorRestore(_uber)
    }
}
function scrNTTEFullAchievementsFollowupTests() {
    var _before=scrNTTEFullInstances(all),_progress=global.ntte_full_progress,
        _save=UberCont.saveData,_fixture=ds_map_create(),_custom=UberCont.custom,_opt=UberCont.opt_achievs
    ds_map_copy(_fixture,_save);UberCont.saveData=_fixture
    try {
        assert(achievementmax==82 && array_length(scrNTTEFullAchievementKeys())==24,"NTTE achievement IDs/count changed")
        for(var _i=59;_i<=82;++_i) save_set_value("achievement",string(_i),0)
        global.ntte_full_progress={schema:1,unlocks:{},loadouts:{},stats:{}}
        global.ntte_full_progress.unlocks[$ "race:parrot"]=true
        var _count=instance_number(AchievementSplash)
        scrNTTEFullAchievementLegacyInit()
        assert(scrAchievementIsUnlocked(65) && instance_number(AchievementSplash)==_count,
            "Legacy NTTE progress was lost or generated historical popups")
        scrAchievementUnlock(65)
        assert(instance_number(AchievementSplash)==_count,"Direct native achievement entry repeated an already-owned legacy NTTE award")
        UberCont.custom=false;UberCont.opt_achievs=true
        scrNTTEFullUnlockSet("pack:coast",true)
        assert(scrAchievementIsUnlocked(59) && instance_number(AchievementSplash)==_count+1,
            "Actual NTTE unlock failed native achievement/notice bridge")
        var _notice=instance_find(AchievementSplash,instance_number(AchievementSplash)-1)
        assert(_notice.achievement_id==59 && _notice.str1==loc("Achievements",59,"name",chiev_name[59]),
            "Native achievement notice used mismatched title/id")
        scrNTTEFullUnlockSet("pack:coast",true)
        assert(instance_number(AchievementSplash)==_count+1,"Repeated NTTE unlock spammed duplicate achievements")
        UberCont.custom=true;scrNTTEFullUnlockSet("pack:trench",true)
        assert(!scrAchievementIsUnlocked(61),"Custom mode incorrectly awarded a new NTTE achievement")
        scrNTTEFullAchievementLegacyInit()
        assert(!scrAchievementIsUnlocked(61),"Rebuilding legacy directory converted custom unlock to achievement")
        UberCont.custom=false;scrNTTEFullUnlockSet("pack:trench",true)
        assert(scrAchievementIsUnlocked(61),"A later normal unlock could not award an earlier custom-only flag")
        UberCont.opt_achievs=false;_count=instance_number(AchievementSplash)
        scrNTTEFullUnlockSet("pack:oasis",true)
        assert(scrAchievementIsUnlocked(60) && instance_number(AchievementSplash)==_count,
            "Achievement notification preference lost unlock or failed to mute reminder")
        scrNTTEFullUnlockSet("quest:part:0",true)
        assert(instance_number(AchievementSplash)==_count,"Non-achievement quest state generated a notice")
        var _menu=instance_create(0,0,AchievementsMenu)
        assert(array_length(_menu.anim)==83 && _menu.unlocks==scrAchievementsCountUnlocked(),
            "Actual native achievements menu omitted appended entries or legacy progress")
        assert(_menu.max_height==83*40-167,"Achievements native scrolling excluded NTTE rows")
    } finally {
        scrNTTEFullMergedRuntimeTestCleanup(_before)
        global.ntte_full_progress=_progress;UberCont.saveData=_save;ds_map_destroy(_fixture)
        UberCont.custom=_custom;UberCont.opt_achievs=_opt
    }
}
function scrNTTEFullBonusHUDOverlapTests() {
    var _p=instance_find(Player,0),_players=scrNTTEFullAreaGeneratorSnapshot(Player),
        _game=scrNTTEFullAreaGeneratorSnapshot(GameCont),_draw=scrNTTEFullCoastDrawState(),
        _font=draw_get_font(),_ha=draw_get_halign(),_va=draw_get_valign(),_shader=shader_current(),
        _surface=-1,_camera=-1,_target=false
    gpu_push_state()
    try {
        _p.bonus_ammo=0;_p.bonus_health=0;_p.wave=0;_p.bonus_ammo_flash=0
        _surface=surface_create(320,192);_camera=camera_create_view(0,0,320,192,0,noone,-1,-1,-1,-1)
        var _base=[]
        for(var _pass=0;_pass<4;++_pass) {
            _p.bonus_ammo=_pass==0?0:(_pass==3?1:180);_p.bonus_ammo_max=240
            _p.bonus_ammo_tick=_pass==1?0:1
            surface_set_target(_surface);_target=true;camera_apply(_camera)
            matrix_set(matrix_world,matrix_build_identity());shader_reset();gpu_set_blendmode(bm_normal)
            gpu_set_texfilter(false);draw_set_color(c_white);draw_set_alpha(1);draw_clear_alpha(c_black,1)
            var _timer=_p.bonus_ammo
            with(_p) scrDrawPlayerHUD(id)
            surface_reset_target();_target=false
            assert(_p.bonus_ammo==_timer,"HUD drawing consumed bonus ammo time")
            var _idx=0
            for(var _y=32;_y<44;++_y) for(var _x=0;_x<54;++_x) {
                var _pixel=surface_getpixel(_surface,_x,_y)
                if(_pass==0) array_push(_base,_pixel)
                else assert(_pixel==_base[_idx],"Bonus ammo bar overlaps original ammunition row")
                _idx++
            }
            if(_pass>0) {
                var _data=scrNTTEFullBonusHUDData(_p,false),_pixels=0
                assert(_data.y==49,"Bonus ammo HUD did not move to separate lower row")
                for(var _y=46;_y<58;++_y) for(var _x=3;_x<53;++_x)
                    if(surface_getpixel(_surface,_x,_y)!=c_black) _pixels++
                assert(_pixels>8,"Moved bonus ammo row did not visibly render")
                surface_save(_surface,working_directory+"ntte-bonus-hud-"+string(_pass)+"-"+string(30/timescale)+".png")
            }
        }
    } finally {
        if(_target) surface_reset_target()
        if(surface_exists(_surface)) surface_free(_surface)
        if(_camera!=-1) camera_destroy(_camera)
        gpu_pop_state();matrix_set(matrix_world,_draw.world);matrix_set(matrix_view,_draw.view);matrix_set(matrix_projection,_draw.projection)
        if(_shader>=0) shader_set(_shader);else shader_reset()
        draw_set_font(_font);draw_set_halign(_ha);draw_set_valign(_va);draw_set_color(_draw.color);draw_set_alpha(_draw.alpha)
        scrNTTEFullAreaGeneratorRestore(_players);scrNTTEFullAreaGeneratorRestore(_game)
    }
}


function scrNTTEFullSupplementalBigGlyphTests() {
    var _points=[25119,27788,28270,34552,34573,34649,34656,34686,34690,34696,34739,34814,35281,
        35930,38408,39066,39612,39654,39749,40104,40132,40151,40520,40521,40533,40550,40859],
        _surface=-1,_camera=-1,_target=false,_draw=scrNTTEFullCoastDrawState(),
        _font=draw_get_font(),_ha=draw_get_halign(),_va=draw_get_valign(),_shader=shader_current()
    gpu_push_state()
    try {
        _surface=surface_create(96,96);_camera=camera_create_view(0,0,96,96,0,noone,-1,-1,-1,-1)
        var _table=scrBignameTableGet("cjk")
        for(var _i=0;_i<array_length(_points);++_i) {
            var _char=chr(_points[_i]),_glyph=_table[$ _char]
            assert(is_struct(_glyph) && _glyph.frame==2,"Native big-name sprite table is missing supplementary CJK "+string(_points[_i]))
            surface_set_target(_surface);_target=true;camera_apply(_camera)
            matrix_set(matrix_world,matrix_build_identity());shader_reset();gpu_set_blendmode(bm_normal)
            gpu_set_texfilter(false);draw_set_color(c_white);draw_set_alpha(1);draw_clear_alpha(c_black,1)
            draw_set_halign(fa_left);draw_set_valign(fa_top)
            draw_text_bigname(16,32,_char,c_white,1,1)
            surface_reset_target();_target=false
            var _visible=0
            for(var _y=0;_y<96;++_y) for(var _x=0;_x<96;++_x)
                if(surface_getpixel(_surface,_x,_y)!=c_black) _visible++
            assert(_visible>20,"Native draw_text_bigname rendered blank supplemental CJK "+string(_points[_i]))
        }
        scrNTTESmokeLog("NATIVE BIG CJK: all 27 supplemental glyphs, including U+86F8, are mapped and visibly rendered through real draw_text_bigname")
    } finally {
        if(_target) surface_reset_target()
        if(surface_exists(_surface)) surface_free(_surface)
        if(_camera!=-1) camera_destroy(_camera)
        gpu_pop_state();matrix_set(matrix_world,_draw.world);matrix_set(matrix_view,_draw.view);matrix_set(matrix_projection,_draw.projection)
        if(_shader>=0) shader_set(_shader);else shader_reset()
        draw_set_font(_font);draw_set_halign(_ha);draw_set_valign(_va);draw_set_color(_draw.color);draw_set_alpha(_draw.alpha)
    }
}
// Display localization must never change gameplay IDs, RNG or user text.
function scrNTTEFullLocalizationFollowupTests(_menu) {
    var _language=global.language_current,_small=global.language_font_default,
        _big=global.language_font_bigname_default,_draw=scrNTTEFullCoastDrawState(),
        _font=draw_get_font(),_ha=draw_get_halign(),_va=draw_get_valign(),
        _shader=shader_current(),_surface=-1,_camera=-1,_target=false,
        _progress=json_stringify(global.ntte_full_progress),_seed=random_get_seed(),
        _raw=[wep_name[wep_ntte_trident],wep_name[wep_ntte_bone_scythe],
            scrNTTEFullRaceText(NTTEFullRace.Parrot,"name")],
        _category=_menu.category,_before=scrNTTEFullInstances(all),
        _credit_rows=[],_credit_draws=[],_credit_trace={calls:0}
    gpu_push_state()
    try {
        scrNTTEFullLocalizeInstall()
        var _unchanged=["English","Traditional Chinese","Japanese"]
        for(var _i=0;_i<array_length(_unchanged);++_i) {
            var _entry=scrNTTEFullValue(global.language_store,_unchanged[_i],undefined)
            assert(is_struct(_entry),"Expected existing host language missing: "+_unchanged[_i])
            scrLanguageSet(_unchanged[_i])
            assert(!scrNTTEFullIsSimplifiedChinese()
                && scrNTTEFullDisplay("PARROT")=="PARROT"
                && scrNTTEFullDisplay("@wSILVER TONGUE@s")=="@wSILVER TONGUE@s",
                "NTTE Chinese leaked into "+_unchanged[_i])
        }
        scrLanguageSet("Simplified Chinese")
        assert(scrNTTEFullIsSimplifiedChinese(),"Actual host Simplified Chinese selection not recognized")
        assert(scrNTTEFullDisplay("CoolGuy")=="酷蛙" && scrNTTEFullDisplay("CoolGuy?")=="酷蛙？"
            && scrNTTEFullWeaponNameDisplay("BAT")=="棒球棍"
            && scrNTTEFullWeaponNameDisplay("ULTRA BAT")=="终极 棒球棍"
            && scrNTTEFullDisplay("BAT")=="蝙蝠",
            "CoolGuy or context-specific weapon BAT translation is incorrect")
        assert(loc("Weapons",wep_ntte_trident,"Name",wep_name[wep_ntte_trident])=="三叉戟"
            && loc("CharacterPrefOptions:ParrotToggle","PARROT ABILITY TOGGLE")=="鹦鹉技能切换",
            "NTTE names did not use native localization entry points")
        assert(scrNTTEFullDisplay("@wSILVER TONGUE@s")=="@w银舌@s"
            && scrNTTEFullDisplay("@1("+string(scrNTTERefSprite("RedText"))+":0)")=="红晶洞窟"
            && scrNTTEFullDisplay("@1("+sprite_get_name(scrNTTERefSprite("BonusText"))+":0)")=="无限",
            "Styled names or dynamically numbered image words escaped translation")
        var _keytag=scrNTTEFullLoadingPickTag()
        assert(scrNTTEFullDisplay("press "+_keytag+" to change modes")=="按 "+_keytag+" 切换模式",
            "Actual platform-specific Scythe key tag corrupted or left English sentence fragments")
        for(var _i=0;_i<array_length(global.ntte_zh_keys);++_i) {
            var _key=global.ntte_zh_keys[_i],_expected=global.ntte_zh_dictionary[$ _key]
            assert(scrNTTEFullDisplay(_key)==_expected,"Dictionary entry failed: "+_key)
        }
        var _old_intro=scrNTTEFullValue(UberCont,"ntte_full_intro_key","")
        var _intros=["BigFish","CatBat","Palanking","PitSquid","Tesseract","PetWeapon","PetWeaponCursed"],
            _names=["大鱼","大人物组合","海豹王","幽灵蛸","超立方","武器箱怪","诅咒武器箱怪"]
        for(var _i=0;_i<array_length(_intros);++_i) {
            UberCont.ntte_full_intro_key=_intros[_i]
            assert(scrNTTEFullBossIntroChineseName()==_names[_i],"Actual boss intro key was not translated")
        }
        UberCont.ntte_full_intro_key=_old_intro
        with(_menu) {
            category=OptionCategory.Game
            assert(!scrNTTEFullMenuTranslationEnabled(),"Ordinary settings/user name text was included in NTTE translation")
            category=OptionCategory.NTTE_Credits
            assert(!scrNTTEFullMenuTranslationEnabled()
                && scrNTTEFullMenuDisplay("Special Thanks")=="Special Thanks",
                "Credits should retain English headings and contributor names in Chinese language mode")
            var _credits=options[category],_thanks=0
            for(var _ci=0;_ci<array_length(_credits);++_ci) {
                var _credit=_credits[_ci]
                assert(is_method(_credit.draw),"Native credit row skipped its custom renderer: unbound callback")
                assert(_credit.height>=font_get_string_height(string_hash_to_newline(_credit.name))+12,
                    "Credit row height omitted its final multiline content")
                if(string_pos("Special Thanks#",_credit.name)==1) {
                    ++_thanks
                    assert(string_pos("#kuzumi#Golden vegetable#Dinosaur leader#",_credit.name)>0,
                        "Special Thanks must retain both existing names and Dinosaur leader on separate lines")
                }
            }
            assert(_thanks==1,"Special Thanks missing or duplicated")
            category=OptionCategory.NTTE_PetDetails
            assert(scrNTTEFullMenuTranslationEnabled(),"Pet detail page excluded from NTTE translation")
            assert(scrNTTEFullMenuDisplay("SCORPION")=="银蝎子宝宝" && scrNTTEFullMenuDisplay("WEAPON")=="武器箱怪",
                "Pet menu species names used generic enemy/weapon translations")
        }
        assert(scrNTTEFullDisplay("SCORPION")=="蝎子" && scrNTTEFullDisplay("WEAPON")=="武器",
            "Pet menu localization leaked into generic names")
        var _native_captain={object_index:Last,hitid:0},_native_bandit={object_index:Bandit,hitid:0},
            _saved_captain={object_name:"Last",text:"lasts"},
            _custom_bandit={object_index:Bandit,hitid:[0,"CUSTOM BANDIT"]}
        assert(scrNTTEFullEnemyDisplayName(_native_captain)=="舰长"
            && scrNTTEFullEnemyDisplayName(_native_bandit)=="盗贼"
            && scrNTTEFullAnnihilationEntryDisplay(_saved_captain)=="舰长"
            && scrNTTEFullEnemyName(_native_captain)=="LAST" && _saved_captain.text=="lasts"
            && scrNTTEFullEnemyDisplayName(_custom_bandit)==scrNTTEFullDisplay("CUSTOM BANDIT"),
            "Native annihilation names changed stored identities or ignored enemy context")
        scrLanguageSet("English")
        assert(scrNTTEFullEnemyDisplayName(_native_captain)=="LAST"
            && scrNTTEFullAnnihilationEntryDisplay(_saved_captain)=="LASTS",
            "Native annihilation Chinese names leaked into English")
        scrLanguageSet("Simplified Chinese")
        assert(random_get_seed()==_seed && json_stringify(global.ntte_full_progress)==_progress
            && _raw[0]==wep_name[wep_ntte_trident] && _raw[1]==wep_name[wep_ntte_bone_scythe]
            && _raw[2]==scrNTTEFullRaceText(NTTEFullRace.Parrot,"name"),
            "Translation changed gameplay identities, progress or RNG")
        _surface=surface_create(ceil(gui_w),ceil(gui_h))
        _camera=camera_create_view(0,0,gui_w,gui_h,0,noone,-1,-1,-1,-1)
        var _pages=[OptionCategory.NTTE,OptionCategory.NTTE_Options,OptionCategory.NTTE_Unlocks,OptionCategory.NTTE_Credits]
        for(var _i=0;_i<array_length(_pages);++_i) {
            if(_pages[_i]==OptionCategory.NTTE_Credits) {
                _credit_rows=_menu.options[OptionCategory.NTTE_Credits]
                for(var _ci=0;_ci<array_length(_credit_rows);++_ci) {
                    var _row=_credit_rows[_ci]
                    array_push(_credit_draws,_row.draw)
                    _row.ntte_credit_test_trace=_credit_trace;_row.ntte_credit_test_draw=_row.draw
                    _row.draw=method(_row,function(_opt) {
                        _opt.ntte_credit_test_trace.calls++
                        return method_execute(_opt.ntte_credit_test_draw,_opt)
                    })
                }
            }
            with(_menu) {
                scrOptionsMenuChangeCategory(_pages[_i]);last_change=current_frame-100;wait=true
                mouse_active=false;pointed_item=-1;slider=undefined;slider_change=0
            }
            surface_set_target(_surface);_target=true;camera_apply(_camera)
            matrix_set(matrix_world,matrix_build_identity());shader_reset();gpu_set_blendmode(bm_normal)
            gpu_set_texfilter(false);draw_set_color(c_white);draw_set_alpha(1);draw_clear_alpha(c_black,1)
            with(_menu) event_perform(ev_draw,ev_gui)
            surface_reset_target();_target=false
            surface_save(_surface,working_directory+"ntte-zh-menu-"+string(_i)+"-"+string(30/timescale)+".png")
            if(_pages[_i]==OptionCategory.NTTE_Credits) {
                assert(_credit_trace.calls>0,"Actual native credits menu did not invoke its bound row renderer")
                _credit_trace.calls=0
                // Render the lower page as well, where Special Thanks borders
                // the iOS port row and the old binary-only insertion overlapped.
                _menu.scroll=_menu.scroll_max;_menu.scroll_check=false
                surface_set_target(_surface);_target=true;camera_apply(_camera)
                draw_clear_alpha(c_black,1)
                with(_menu) event_perform(ev_draw,ev_gui)
                assert(_credit_trace.calls>0,"Scrolled credits lost all custom row renderer invocations")
                surface_reset_target();_target=false
                surface_save(_surface,working_directory+"ntte-credits-bottom-"+string(30/timescale)+".png")
            }
        }
        surface_set_target(_surface);_target=true;camera_apply(_camera)
        draw_clear_alpha(c_black,1);draw_reset_font();draw_align(fa_center,fa_middle)
        scrNTTEFullDrawText(gui_w/2,gui_h/2-32,"鹦鹉 / 三叉戟 / 蝙蝠双耳")
        scrNTTEFullDrawText(gui_w/2,gui_h/2-8,"蝾螈 / 蟾蜍呼吸 / 幽灵蛸")
        scrNTTEFullDrawBigName(gui_w/2,gui_h/2+32,"同情  银舌",c_white,1,0.65)
        surface_reset_target();_target=false
        surface_save(_surface,working_directory+"ntte-zh-glyphs-"+string(30/timescale)+".png")
        scrNTTEFullSupplementalBigGlyphTests()
        scrNTTESmokeLog("LOCALIZATION: native language switching; English/Traditional/Japanese unchanged; Simplified names+rich tags+boss keys; raw IDs/progress/RNG preserved; actual Chinese native menu renders")
    } finally {
        for(var _ci=0;_ci<array_length(_credit_draws);++_ci) {
            _credit_rows[_ci].draw=_credit_draws[_ci]
            variable_struct_remove(_credit_rows[_ci],"ntte_credit_test_trace")
            variable_struct_remove(_credit_rows[_ci],"ntte_credit_test_draw")
        }
        if(_target) surface_reset_target()
        if(surface_exists(_surface)) surface_free(_surface)
        if(_camera!=-1) camera_destroy(_camera)
        scrNTTEFullMergedRuntimeTestCleanup(_before)
        global.language_current=_language;global.language_font_default=_small;global.language_font_bigname_default=_big
        with(_menu) scrOptionsMenuChangeCategory(_category)
        gpu_pop_state();matrix_set(matrix_world,_draw.world);matrix_set(matrix_view,_draw.view);matrix_set(matrix_projection,_draw.projection)
        if(_shader>=0) shader_set(_shader);else shader_reset()
        draw_set_font(_font);draw_set_halign(_ha);draw_set_valign(_va);draw_set_color(_draw.color);draw_set_alpha(_draw.alpha)
    }
}


// Actual startup events and independent source-image comparison; no new object.
function scrNTTEFullStartupPixels(_actual,_reference,_w,_h,_label,_painted) {
    var _a=-1,_b=-1,_visible=0,_different=0,_delta=0
    try {
        _a=buffer_create(_w*_h*4,buffer_fixed,1);_b=buffer_create(_w*_h*4,buffer_fixed,1)
        buffer_get_surface(_a,_actual,0);buffer_get_surface(_b,_reference,0)
        for(var _off=0;_off<_w*_h*4;_off+=4) {
            var _pa=buffer_peek(_a,_off,buffer_u32),_pb=buffer_peek(_b,_off,buffer_u32)
            if((_pb & $ffffff)!=0) _visible++
            if(_pa!=_pb) {
                _different++
                for(var _shift=0;_shift<32;_shift+=8)
                    _delta=max(_delta,abs(((_pa>>_shift)&255)-((_pb>>_shift)&255)))
            }
        }
        assert(_delta<=2,"Startup PNG mismatch "+_label+" pixels="+string(_different)+" maxDelta="+string(_delta))
        assert(_painted?_visible>1000:_visible==0,"Startup reference blank/nonblank mismatch")
        scrNTTESmokeLog("STARTUP PIXELS "+_label+" compared="+string(_w*_h)+" different="+string(_different)+" maxDelta="+string(_delta))
    } finally {
        if(buffer_exists(_a)) buffer_delete(_a)
        if(buffer_exists(_b)) buffer_delete(_b)
    }
}
function scrNTTEFullStartupRender(_v,_png,_w,_h,_tag,_painted) {
    var _surface=-1,_reference=-1,_camera=-1,_target=false,_draw=scrNTTEFullCoastDrawState(),
        _font=draw_get_font(),_ha=draw_get_halign(),_va=draw_get_valign(),_shader=shader_current(),
        _gw=gui_w,_gh=gui_h,_mode=_v.mode,_alarm=_v.alarm[0],
        _prefix=working_directory+"ntte-startup-"+_tag+"-"+string(30/timescale)
    gpu_push_state()
    try {
        display_set_gui_size(_w,_h)
        _surface=surface_create(_w,_h);_reference=surface_create(_w,_h)
        _camera=camera_create_view(0,0,_w,_h,0,noone,-1,-1,-1,-1)
        surface_set_target(_surface);_target=true;camera_apply(_camera)
        matrix_set(matrix_world,matrix_build_identity());shader_reset();gpu_set_blendmode(bm_normal)
        gpu_set_texfilter(false);gpu_set_fog(false,c_black,0,0)
        draw_set_color(c_white);draw_set_alpha(1);draw_clear_alpha(c_black,1)
        if(_painted) with(_v) event_perform(ev_draw,0)
        with(_v) event_perform(ev_draw,ev_gui)
        assert(!gpu_get_texfilter(),"Startup GUI leaked texture filtering")
        assert(_v.mode==_mode && _v.alarm[0]==_alarm,"Drawing advanced startup mode/alarm")
        surface_reset_target();_target=false
        surface_set_target(_reference);_target=true;camera_apply(_camera)
        matrix_set(matrix_world,matrix_build_identity());shader_reset();gpu_set_blendmode(bm_normal)
        gpu_set_texfilter(true);draw_set_color(c_white);draw_set_alpha(1);draw_clear_alpha(c_black,1)
        if(_painted) {
            var _sw=sprite_get_width(_png),_sh=sprite_get_height(_png),_scale=min(_w/_sw,_h/_sh)*0.94,
                _left=(_w-_sw*_scale)/2,_top=(_h-_sh*_scale)/2
            assert(_left>=0 && _top>=0 && _left+_sw*_scale<=_w && _top+_sh*_scale<=_h,"Startup image cropped")
            draw_sprite_ext(_png,0,_left,_top,_scale,_scale,0,c_white,1)
        }
        surface_reset_target();_target=false
        surface_save(_surface,_prefix+"-actual.png");surface_save(_reference,_prefix+"-reference.png")
        scrNTTEFullStartupPixels(_surface,_reference,_w,_h,_tag,_painted)
    } finally {
        if(_target) surface_reset_target()
        if(surface_exists(_surface)) surface_free(_surface)
        if(surface_exists(_reference)) surface_free(_reference)
        if(_camera>=0) camera_destroy(_camera)
        display_set_gui_size(_gw,_gh);gpu_pop_state()
        matrix_set(matrix_world,_draw.world);matrix_set(matrix_view,_draw.view);matrix_set(matrix_projection,_draw.projection)
        if(_shader>=0) shader_set(_shader);else shader_reset()
        draw_set_font(_font);draw_set_halign(_ha);draw_set_valign(_va);draw_set_color(_draw.color);draw_set_alpha(_draw.alpha)
    }
}
function scrNTTEFullStartupFollowupTests() {
    assert(os_type==os_windows && scrNTTEFullSmokeEnabled(),"Startup QA requires explicit Windows smoke")
    assert(savegame_file==working_directory+"smoke-save/savegame.dat","Startup fixture requires reserved smoke save")
    assert(surface_get_target()<0,"Startup Create requires no render target")
    var _asset=working_directory+"startup-assets/TEAM-TE.png"
    assert(file_exists(_asset),"Independent startup PNG missing")
    var _before=scrNTTEFullInstances(all),_parked=[],_uber=scrNTTEFullAreaGeneratorSnapshot(UberCont),
        _smoke=global.ntte_smoke_active,_console=global.console_active,_stop=lockstep_stop,_seed=random_get_seed(),
        _safe=global.safemode,
        _progress=json_stringify(global.ntte_full_progress),_save=ds_map_write(UberCont.saveData),
        _binary=file_exists(savegame_file)?buffer_load(savegame_file):-1,
        _bytes=json_stringify(scrNTTEFullMenuNativeFileBytes(savegame_file)),
        _no_intro=file_exists("no_intro.txt"),_marker=json_stringify(scrNTTEFullMenuNativeFileBytes("no_intro.txt")),
        _draw=scrNTTEFullCoastDrawState(),_font=draw_get_font(),_ha=draw_get_halign(),_va=draw_get_valign(),
        _shader=shader_current(),_gw=gui_w,_gh=gui_h,_vx=view_xview,_vy=view_yview,_vw=view_width,_vh=view_height,
        _aw=surface_get_width(application_surface),_ah=surface_get_height(application_surface),
        _viewport=[view_visible[0],view_xport[0],view_yport[0],view_wport[0],view_hport[0]],
        _enabled=view_enabled,_rooms=[romInit,romGame],_cameras=[],_png=-1,_v=noone,_key=false
    for(var _i=0;_i<array_length(_rooms);++_i) array_push(_cameras,room_get_camera(_rooms[_i],0))
    gpu_push_state()
    try {
        for(var _i=0;_i<array_length(_before);++_i) {
            var _actor=_before[_i]
            if(_actor!=id && _actor.object_index!=UberCont && _actor.object_index!=Console) {
                array_push(_parked,_actor);instance_deactivate_object(_actor)
            }
        }
        for(var _i=0;_i<array_length(_rooms);++_i) room_set_camera(_rooms[_i],0,-1)
        if(file_exists(savegame_file)) file_delete(savegame_file)
        global.ntte_smoke_active=false;global.console_active=true;lockstep_stop=false
        UberCont.want_quit_to_menu=false;UberCont.show_leaderboards_menu=false;UberCont.show_weekly_results_menu=false
        // Invalid reserved bytes must be ignored intact when startup recovery
        // has disabled continuation, rather than reaching the binary loader.
        file_write(savegame_file,"safe-mode-preserved-run")
        var _recoveryBytes=json_stringify(scrNTTEFullMenuNativeFileBytes(savegame_file))
        global.safemode=true
        _v=instance_create(0,0,Vlambeer)
        assert(!instance_exists(GameCont) && !instance_exists(Player) && !instance_exists(GenCont)
            && instance_number(MainMenu)==1
            && json_stringify(scrNTTEFullMenuNativeFileBytes(savegame_file))==_recoveryBytes,
            "Actual safe-mode startup loaded/deleted the failed continuation or skipped native main menu")
        scrNTTESmokeLog("STARTUP RECOVERY actual Vlambeer.Create skipped invalid continuation, preserved exact file bytes and entered native menu")
        scrNTTEFullMergedRuntimeTestCleanup(_before)
        file_delete(savegame_file);global.safemode=false
        _png=sprite_add(_asset,1,false,false,0,0)
        assert(sprite_get_width(_png)==869 && sprite_get_height(_png)==924
            && sprite_get_width(sprNTTETeamStartup)==869 && sprite_get_height(sprNTTETeamStartup)==924,
            "Startup source dimensions changed")
        _v=instance_create(0,0,Vlambeer)
        if(_no_intro) {
            assert(!instance_exists(_v) && !instance_exists(Vlambeer) && !instance_exists(Logo)
                && instance_number(SpiralCont)==1 && instance_number(MainMenuButton)==4,
                "Actual no_intro Create failed native immediate menu")
            scrNTTESmokeLog("STARTUP NOINTRO actual Create->Alarm0->Logo.Alarm1 native menu verified")
        } else {
            assert(instance_exists(_v) && _v.mode==-1 && _v.alarm[0]==60 && instance_number(MainMenu)==1
                && !instance_exists(Logo) && !instance_exists(SpiralCont),"Actual startup Create failed TEAM first screen")
            scrNTTEFullStartupRender(_v,_png,320,240,"landscape",true)
            scrNTTEFullStartupRender(_v,_png,424,240,"wide",true)
            scrNTTEFullStartupRender(_v,_png,240,320,"portrait",true)
            lockstep_stop=true;scrNTTEFullStartupRender(_v,_png,320,240,"lockstep-hidden",false);lockstep_stop=false
            with(_v) event_perform(ev_draw,0)
            assert(_v.mode==-1,"Console-active drawing advanced TEAM screen")
            with(_v) event_perform(ev_alarm,0)
            assert(_v.mode==0 && _v.alarm[0]==120,"Native TEAM alarm lost saving screen/timer")
            scrNTTEFullStartupRender(_v,_png,320,240,"saving-hidden",false)
            var _modes=[1,2,3],_alarms=[60,120,60]
            for(var _i=0;_i<3;++_i) {
                with(_v) event_perform(ev_alarm,0)
                assert(_v.mode==_modes[_i] && _v.alarm[0]==_alarms[_i],"Original startup mode/timer changed")
                scrNTTEFullStartupRender(_v,_png,320,240,"mode"+string(_modes[_i])+"-hidden",false)
            }
            with(_v) event_perform(ev_alarm,0)
            assert(!instance_exists(_v) && instance_number(SpiralCont)==1 && instance_number(Logo)==1,"Startup lost native Logo handoff")
            scrNTTESmokeLog("STARTUP actual Create/Draw0/GUI/Alarm0, independent PNG, console+lockstep gates verified; input skip NOT_RUN: software key injection unsupported and OS input tool unavailable; no_intro file branch NOT_RUN here")
        }
        assert(!file_exists(savegame_file) && ds_map_write(UberCont.saveData)==_save
            && json_stringify(global.ntte_full_progress)==_progress,"Startup changed saved settings/progress")
    } finally {
        if(_key) {keyboard_key_release(vk_space);keyboard_clear(vk_space);}
        scrNTTEFullMergedRuntimeTestCleanup(_before)
        for(var _i=0;_i<array_length(_parked);++_i) instance_activate_object(_parked[_i])
        scrNTTEFullAreaGeneratorRestore(_uber)
        global.ntte_smoke_active=_smoke;global.console_active=_console;lockstep_stop=_stop;global.safemode=_safe
        if(_binary>=0) {buffer_save(_binary,savegame_file);buffer_delete(_binary);}
        else if(file_exists(savegame_file)) file_delete(savegame_file)
        if(sprite_exists(_png)) sprite_delete(_png)
        var _new_cameras=[]
        for(var _i=0;_i<array_length(_rooms);++_i) {
            var _new=room_get_camera(_rooms[_i],0);room_set_camera(_rooms[_i],0,_cameras[_i])
            if(_new>=0 && array_get_index(_cameras,_new)<0 && array_get_index(_new_cameras,_new)<0) array_push(_new_cameras,_new)
        }
        for(var _i=0;_i<array_length(_new_cameras);++_i) camera_destroy(_new_cameras[_i])
        room_set_viewport(room,0,_viewport[0],_viewport[1],_viewport[2],_viewport[3],_viewport[4]);room_set_view_enabled(romGame,_enabled)
        view_xview=_vx;view_yview=_vy;view_width=_vw;view_height=_vh
        surface_resize(application_surface,_aw,_ah);display_set_gui_size(_gw,_gh)
        gpu_pop_state();matrix_set(matrix_world,_draw.world);matrix_set(matrix_view,_draw.view);matrix_set(matrix_projection,_draw.projection)
        if(_shader>=0) shader_set(_shader);else shader_reset()
        draw_set_font(_font);draw_set_halign(_ha);draw_set_valign(_va);draw_set_color(_draw.color);draw_set_alpha(_draw.alpha)
        random_set_seed(_seed)
        assert(json_stringify(scrNTTEFullMenuNativeFileBytes(savegame_file))==_bytes,"Startup fixture changed reserved save bytes")
        assert(file_exists("no_intro.txt")==_no_intro && json_stringify(scrNTTEFullMenuNativeFileBytes("no_intro.txt"))==_marker,"Startup changed no_intro marker")
    }
    scrNTTESmokeLog("STARTUP fixture restored; engine elapsed timing and cold continuation NOT_RUN")
}

// BEGIN NTTE ACHIEVEMENT REPEAT NATIVE TESTS
// Reproduce the actual public/debug options-only save and startup JSON reload.
function scrNTTEFullAchievementRepeatNativeTests() {
    assert(scrNTTESmokeEnabled(),"Achievement reload regression requires private desktop smoke saves")
    var _before=scrNTTEFullInstances(all),_uber=scrNTTEFullAreaGeneratorSnapshot(UberCont),
        _queue=scrNTTEFullAreaGeneratorSnapshot(NTTEFullUnlockCont),
        _progress=global.ntte_full_progress,_save=UberCont.saveData,_save_bytes=ds_map_write(_save),
        _fixture=ds_map_create(),_reload=-1,_directory=game_directory,_alarms=[],
        _seed=random_get_seed(),_rng=scrNTTEFullArrayCopy(global.rng_state),
        _scratch=working_directory+"achievement-repeat-native-"+string(get_timer())+"/",
        _debug_names=["__debug_menu_options","__debug_hitboxes","__debug_health","__debug_immortality",
            "__debug_teleportation","__debug_noreload","__debug_infammo","cheats"],_debug_values=[]
    ds_map_copy(_fixture,_save);UberCont.saveData=_fixture
    directory_create(_scratch);game_directory=_scratch
    for(var _i=0;_i<12;++_i) array_push(_alarms,UberCont.alarm[_i]);
    for(var _i=0;_i<array_length(_debug_names);++_i) {
        array_push(_debug_values,variable_global_get(_debug_names[_i]));variable_global_set(_debug_names[_i],false)
    }
    try {
        UberCont.public=true;UberCont.custom=false;UberCont.opt_achievs=true
        for(var _id=59;_id<=82;++_id) save_set_value("achievement",string(_id),0)
        save_set_value("achievement","60",1)
        global.ntte_full_progress={schema:1,unlocks:{},loadouts:{},stats:{},achievement_legacy:{}}
        var _baseline_popups=instance_number(AchievementSplash)
        scrNTTEFullAchievementLegacyInit()
        assert(global.ntte_full_progress.achievement_earned[$ "pack:oasis"]
            && instance_number(AchievementSplash)==_baseline_popups,"Native-only existing achievement failed silent migration")
        scrSave()
        global.cheats=true
        var _count=instance_number(AchievementSplash),
            _queued=instance_exists(NTTEFullUnlockCont)?array_length(NTTEFullUnlockCont.unlock):0
        assert(scrNTTEFullUnlockSet("pack:coast",true),"First real source unlock did not change its content ownership")
        assert(instance_number(AchievementSplash)==_count+1
            && array_length(NTTEFullUnlockCont.unlock)==_queued+1,
            "First NTTE unlock lost its native achievement or original source notice")
        var _disk=json_parse(scrPersistentJsonLoad(_scratch+"NuclearThrone.sav")),
            _mod=json_parse(scrPersistentJsonLoad(_scratch+"ntte-full-progress.json",scrNTTEFullProgressStateValid))
        assert(!scrNTTEFullValue(_disk,"achievement_59",false)
            && _mod.unlocks[$ "pack:coast"] && scrNTTEFullValue(_mod.achievement_earned,"pack:coast",false),
            "Fixture failed to reproduce native options-only disk save with persistent earned NTTE progress")
        _reload=json_decode(scrPersistentJsonLoad(_scratch+"NuclearThrone.sav"));UberCont.saveData=_reload
        assert(!save_get_value("achievement","59",false),"Reentry fixture retained the live native achievement bit")
        global.ntte_full_progress={schema:1,unlocks:{},loadouts:{},stats:{}}
        assert(scrNTTEFullProgressLoad(),"Actual NTTE startup JSON reload failed")
        scrNTTEFullAchievementLegacyInit()
        assert(scrAchievementIsUnlocked(59),"Reloaded earned NTTE achievement vanished with its absent native bit")
        _count=instance_number(AchievementSplash);_queued=array_length(NTTEFullUnlockCont.unlock)
        repeat(3) {scrNTTEFullUnlockSet("pack:coast",true);scrAchievementUnlock(59);}
        assert(instance_number(AchievementSplash)==_count && array_length(NTTEFullUnlockCont.unlock)==_queued,
            "Repeated source/native conditions after actual reload renewed an already-owned achievement or source notice")
        // The one-time native ownership migration survives the same reload.
        scrNTTEFullAchievementLegacyInit()
        assert(global.ntte_full_progress.achievement_earned[$ "pack:oasis"]
            && instance_number(AchievementSplash)==_count,"Migrated native ownership vanished or repeated historical popups")
        // Custom content flags must stay distinct from genuinely earned awards.
        UberCont.custom=true;scrNTTEFullUnlockSet("pack:trench",true)
        assert(!scrAchievementIsUnlocked(61),"Custom content condition granted a permanent achievement")
        assert(scrNTTEFullProgressLoad(),"Custom progress reentry JSON failed")
        scrNTTEFullAchievementLegacyInit()
        assert(!scrAchievementIsUnlocked(61),"Reload turned a custom-only content flag into a real achievement")
        UberCont.custom=false;_queued=array_length(NTTEFullUnlockCont.unlock)
        scrNTTEFullUnlockSet("pack:trench",true)
        assert(scrAchievementIsUnlocked(61) && instance_number(AchievementSplash)==_count+1
            && array_length(NTTEFullUnlockCont.unlock)==_queued,
            "First later normal completion failed to award once or repeated the existing source unlock")
        UberCont.opt_achievs=false;_count=instance_number(AchievementSplash)
        scrNTTEFullUnlockSet("pack:lair",true)
        assert(scrAchievementIsUnlocked(62) && instance_number(AchievementSplash)==_count,
            "Muted achievement was not earned or emitted a native popup")
        var _again=json_decode(scrPersistentJsonLoad(_scratch+"NuclearThrone.sav"))
        UberCont.saveData=_again;ds_map_destroy(_reload);_reload=_again
        assert(scrNTTEFullProgressLoad(),"Second earned-achievement startup JSON reload failed")
        scrNTTEFullAchievementLegacyInit();UberCont.opt_achievs=true
        _queued=array_length(NTTEFullUnlockCont.unlock)
        scrNTTEFullUnlockSet("pack:coast",true);scrNTTEFullUnlockSet("pack:trench",true);scrNTTEFullUnlockSet("pack:lair",true)
        assert(scrAchievementIsUnlocked(59) && scrAchievementIsUnlocked(60)
            && scrAchievementIsUnlocked(61) && scrAchievementIsUnlocked(62)
            && instance_number(AchievementSplash)==_count && array_length(NTTEFullUnlockCont.unlock)==_queued,
            "Reentry or unmuting renewed earned NTTE achievements/source notices")
        scrNTTESmokeLog("NTTE ACHIEVEMENT REENTRY actual public+debug native options-only save/independent earned JSON/startup reload; first native+source notices, repeat and direct-native silence, native-owned migration, custom-to-normal first award, muted persistence OK @"+string(30/timescale))
    }
    finally {
        scrNTTEFullMergedRuntimeTestCleanup(_before);scrNTTEFullAreaGeneratorRestore(_queue)
        scrNTTEFullAreaGeneratorRestore(_uber);UberCont.saveData=_save
        if(_reload!=-1) ds_map_destroy(_reload);ds_map_destroy(_fixture)
        for(var _i=0;_i<12;++_i) UberCont.alarm[_i]=_alarms[_i];
        for(var _i=0;_i<array_length(_debug_names);++_i) variable_global_set(_debug_names[_i],_debug_values[_i]);
        global.ntte_full_progress=_progress;game_directory=_directory
        global.rng_state=_rng;random_set_seed(_seed)
        assert(ds_map_write(_save)==_save_bytes,"Achievement reentry fixture changed real player unlock progress")
    }
}
// END NTTE ACHIEVEMENT REPEAT NATIVE TESTS

// BEGIN NTTE ACHIEVEMENT OWNERSHIP NATIVE TESTS
// Real private JSON save/reload and actual AchievementsMenu.Create. Neither
// weapon ownership nor custom availability substitutes for permanent unlocks.
function scrNTTEFullAchievementOwnershipMenu(_expected,_baseline,_label) {
    var _menu=instance_create(0,0,AchievementsMenu);
    assert(instance_exists(_menu) && array_length(_menu.anim)==83
        && _menu.unlocks==_baseline+_expected,
        "Actual achievement menu ownership mismatch "+_label+": "+string(_menu.unlocks));
    with(_menu) instance_destroy();
}

function scrNTTEFullAchievementOwnershipNativeTests() {
    assert(os_type==os_windows && scrNTTESmokeEnabled(),"Ownership migration needs explicit private desktop smoke saves");
    var _before=scrNTTEFullInstances(all),_uber=scrNTTEFullAreaGeneratorSnapshot(UberCont),
        _queue=scrNTTEFullAreaGeneratorSnapshot(NTTEFullUnlockCont),
        _progress=global.ntte_full_progress,_save=UberCont.saveData,_save_bytes=ds_map_write(_save),
        _fixture=ds_map_create(),_reload=-1,_directory=game_directory,_alarms=[],
        _seed=random_get_seed(),_rng=scrNTTEFullArrayCopy(global.rng_state),
        _scratch=working_directory+"achievement-ownership-native-"+string(get_timer())+"/",
        _debug_names=["__debug_menu_options","__debug_hitboxes","__debug_health","__debug_immortality",
            "__debug_teleportation","__debug_noreload","__debug_infammo","cheats"],_debug_values=[];
    ds_map_copy(_fixture,_save);UberCont.saveData=_fixture;
    directory_create(_scratch);game_directory=_scratch;
    for(var _i=0;_i<12;++_i) array_push(_alarms,UberCont.alarm[_i]);
    for(var _i=0;_i<array_length(_debug_names);++_i) {
        array_push(_debug_values,variable_global_get(_debug_names[_i]));variable_global_set(_debug_names[_i],false);
    }
    try {
        UberCont.public=true;UberCont.custom=false;UberCont.opt_achievs=true;
        var _keys=scrNTTEFullAchievementKeys(),_base_count=0;
        for(var _id=0;_id<59;++_id) if(save_get_value("achievement",string(_id),false)) _base_count++;
        for(var _id=59;_id<=82;++_id) save_set_value("achievement",string(_id),0);
        assert(array_length(_keys)==24 && _keys[6]=="race:parrot" && _keys[17]=="wep:trident",
            "Ownership fixture's source/native identities changed");

        // Reproduce an old normal player's file: content was permanently
        // unlocked after the once-only empty achievement directories latched.
        global.ntte_full_progress={schema:1,unlocks:{},loadouts:{},stats:{},achievement_legacy:{},achievement_earned:{}};
        for(var _i=0;_i<24;++_i) global.ntte_full_progress.unlocks[$ _keys[_i]]=true;
        assert(scrNTTEFullProgressSave(),"Could not write actual stale-directory progress fixture");
        global.ntte_full_progress={schema:1,unlocks:{},loadouts:{},stats:{}};
        assert(scrNTTEFullProgressLoad(),"Actual stale-directory progress startup reload failed");
        var _splash=instance_number(AchievementSplash);
        scrNTTEFullAchievementOwnershipMenu(24,_base_count,"historical permanent flags");
        for(var _i=0;_i<24;++_i) assert(scrAchievementIsUnlocked(59+_i),"Historical actual ownership stayed locked: "+_keys[_i]);
        assert(instance_number(AchievementSplash)==_splash,"Historical reconciliation generated achievement popups");
        var _disk=json_parse(scrPersistentJsonLoad(_scratch+"ntte-full-progress.json",scrNTTEFullProgressStateValid));
        assert(_disk.achievement_sync_version==2 && array_length(variable_struct_get_names(_disk.achievement_legacy))==24,
            "Actual reconciled ownership was not saved to the independent progress file");
        for(var _i=0;_i<24;++_i) {scrNTTEFullUnlockSet(_keys[_i],true);scrAchievementUnlock(59+_i);}
        assert(instance_number(AchievementSplash)==_splash,"Recovered historical ownership repeated native awards");
        scrNTTESmokeLog("ACHIEVEMENT OWNERSHIP old persisted empty directories+24 source flags -> actual reload/menu, silent durable recovery OK");

        // A weapon being usable in custom is not an actual unlock condition.
        global.ntte_full_progress={schema:1,unlocks:{},loadouts:{},stats:{},achievement_legacy:{},achievement_earned:{}};
        global.ntte_full_progress.stats[$ "found:trident.wep"]=true;
        UberCont.custom=true;
        assert(scrGameIsCustomMode() && scrNTTEFullWeaponAvailable(wep_ntte_trident),"Custom availability negative control was not genuine");
        scrNTTEFullAchievementOwnershipMenu(0,_base_count,"custom availability/discovery only");
        assert(!scrAchievementIsUnlocked(76) && !scrNTTEFullUnlockGet("wep:trident"),
            "Custom availability/discovery inferred an earned weapon achievement");
        for(var _i=0;_i<24;++_i) scrNTTEFullUnlockSet(_keys[_i],true);
        assert(instance_number(AchievementSplash)==_splash,"Custom source condition generated a native award");
        var _queued=instance_exists(NTTEFullUnlockCont)?array_length(NTTEFullUnlockCont.unlock):0;
        // Native public/debug saves preserve only existing options on disk;
        // independently persisted custom origins must survive that real route.
        scrSave();global.cheats=true;scrSave();
        _disk=json_parse(scrPersistentJsonLoad(_scratch+"ntte-full-progress.json",scrNTTEFullProgressStateValid));
        assert(array_length(variable_struct_get_names(_disk.achievement_custom))==24,
            "Actual custom source origins were not committed beside their content flags");
        _reload=json_decode(scrPersistentJsonLoad(_scratch+"NuclearThrone.sav"));UberCont.saveData=_reload;
        global.ntte_full_progress={schema:1,unlocks:{},loadouts:{},stats:{}};
        assert(scrNTTEFullProgressLoad(),"Actual custom-origin JSON reentry failed");UberCont.custom=false;
        scrNTTEFullAchievementOwnershipMenu(0,_base_count,"persisted custom source flags");
        for(var _i=0;_i<24;++_i) assert(!scrAchievementIsUnlocked(59+_i),"Reentry converted known custom source to ownership: "+_keys[_i]);

        // The same real normal condition can earn its award despite its old
        // custom content flag. Source unlock notices still dedupe by content.
        scrNTTEFullUnlockSet("race:parrot",true);
        assert(scrAchievementIsUnlocked(65) && instance_number(AchievementSplash)==_splash+1
            && array_length(NTTEFullUnlockCont.unlock)==_queued,
            "First genuine normal completion after custom failed one native award or repeated source UI");
        _disk=json_parse(scrPersistentJsonLoad(_scratch+"NuclearThrone.sav"));
        assert(!scrNTTEFullValue(_disk,"achievement_65",false),"Fixture failed actual native options-only save reproduction");
        var _again=json_decode(scrPersistentJsonLoad(_scratch+"NuclearThrone.sav"));
        UberCont.saveData=_again;ds_map_destroy(_reload);_reload=_again;
        assert(scrNTTEFullProgressLoad(),"Actual earned ownership independent JSON reload failed");
        scrNTTEFullAchievementOwnershipMenu(1,_base_count,"genuine normal award after custom reload");
        repeat(3) {scrNTTEFullUnlockSet("race:parrot",true);scrAchievementUnlock(65);}
        assert(instance_number(AchievementSplash)==_splash+1 && array_length(NTTEFullUnlockCont.unlock)==_queued,
            "Earned normal ownership repeated achievement/source notices after real reload");
        scrNTTESmokeLog("ACHIEVEMENT OWNERSHIP custom usable/discovered negative,24 custom source origins survive actual save/reload/menu; later normal first award once OK");

        // A later native ownership bit remains authoritative even if progress
        // maps are already initialized, and survives options-only saving too.
        save_set_value("achievement","66",1);
        scrNTTEFullAchievementOwnershipMenu(2,_base_count,"later authoritative native ownership");
        _disk=json_parse(scrPersistentJsonLoad(_scratch+"ntte-full-progress.json",scrNTTEFullProgressStateValid));
        assert(_disk.achievement_earned[$ "race:beetle"],"Ready earned/legacy directories blocked a later native ownership import");
        scrSave();_again=json_decode(scrPersistentJsonLoad(_scratch+"NuclearThrone.sav"));
        UberCont.saveData=_again;ds_map_destroy(_reload);_reload=_again;
        assert(!save_get_value("achievement","66",false) && scrNTTEFullProgressLoad(),
            "Actual native-only import did not exercise the options-only reentry path");
        scrNTTEFullAchievementOwnershipMenu(2,_base_count,"reloaded later native ownership");
        assert(instance_number(AchievementSplash)==_splash+1,"Menu/native synchronization repeated a historical popup");

        // Startup/menu refresh is allowed after the schema is already current.
        // Only exact boolean source keys count, never arbitrary objects/stats.
        for(var _id=59;_id<=82;++_id) save_set_value("achievement",string(_id),0);
        global.ntte_full_progress={schema:1,unlocks:{},loadouts:{},stats:{},achievement_legacy:{},achievement_earned:{},achievement_custom:{},achievement_sync_version:2};
        global.ntte_full_progress.unlocks[$ "pack:coast"]={owned:true};
        global.ntte_full_progress.unlocks[$ "pack:oasis"]=false;
        global.ntte_full_progress.stats[$ "found:scythe.wep"]=true;
        global.ntte_full_progress.loadouts[$ "loadout:wep:fish"]={weapon:wep_ntte_trident};
        scrNTTEFullAchievementOwnershipMenu(0,_base_count,"nonboolean/noncompletion metadata");
        global.ntte_full_progress.unlocks[$ "wep:trident"]=true;
        assert(scrNTTEFullProgressSave() && scrNTTEFullProgressLoad(),"Later source-only progress failed actual disk cycle");
        scrNTTEFullAchievementOwnershipMenu(1,_base_count,"later exact permanent source unlock");
        assert(scrAchievementIsUnlocked(76) && instance_number(AchievementSplash)==_splash+1,
            "Current-schema permanent unlock was not reconciled silently by the actual menu");
        scrNTTESmokeLog("PASS ACHIEVEMENT OWNERSHIP actual stale/current progress startup reload+AchievementsMenu.Create,24 source mappings,known custom exclusion,native sync,first-only notices @"+string(30/timescale));
    } finally {
        scrNTTEFullMergedRuntimeTestCleanup(_before);scrNTTEFullAreaGeneratorRestore(_queue);
        scrNTTEFullAreaGeneratorRestore(_uber);UberCont.saveData=_save;
        if(_reload!=-1) ds_map_destroy(_reload);ds_map_destroy(_fixture);
        for(var _i=0;_i<12;++_i) UberCont.alarm[_i]=_alarms[_i];
        for(var _i=0;_i<array_length(_debug_names);++_i) variable_global_set(_debug_names[_i],_debug_values[_i]);
        global.ntte_full_progress=_progress;game_directory=_directory;
        global.rng_state=_rng;random_set_seed(_seed);
        assert(ds_map_write(_save)==_save_bytes,"Ownership fixture changed real player save data");
    }
}
// END NTTE ACHIEVEMENT OWNERSHIP NATIVE TESTS

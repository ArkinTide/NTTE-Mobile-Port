// Dedicated UI-only native smoke case. No second participant, cooperative
// gameplay, Save migration, or simulated hardware button API is used.
function scrNTTEFullSingleplayerUIEntryTests() {
    assert(scrNTTESmokeEnabled(),"Single-player UI fixture requires isolated native smoke")
    assert(!instance_exists(MainMenuButton) && !instance_exists(Logo) && !instance_exists(MenuOptions)
        && !instance_exists(CoopMenu) && !instance_exists(CoopController),
        "Single-player UI fixture needs the clean native smoke gameplay fixture")
    var _before=scrNTTEFullInstances(all),_driver=id,
        _uber=scrNTTEFullAreaGeneratorSnapshot(UberCont),_keys=scrNTTEFullAreaGeneratorSnapshot(KeyCont),
        _old_speed=game_get_speed(gamespeed_fps),_old_scale=timescale,_old_autopause=UberCont.opt_autopause,
        _old_paused=UberCont.paused,_old_want_pause=UberCont.want_pause,_old_stop=lockstep_stop,
        _old_smoke=global.ntte_smoke_active,_seed=random_get_seed(),
        _old_save_map=UberCont.saveData,_old_savedata=ds_map_write(UberCont.saveData),_scanned=0
    try {
        // Execute the real resource event which constructs the menu buttons.
        var _logo=instance_create(0,0,Logo)
        var _logo_created_exists=instance_exists(_logo),_logo_created_kind="missing",_logo_created_id=-1
        if(_logo_created_exists) { _logo_created_kind=object_get_name(_logo.object_index);_logo_created_id=_logo.id }
        with(_logo) event_perform(ev_alarm,1)
        var _logo_rows=[],_button_rows=[],_button_order=[],_main_buttons=[],_discord=0,_achievements=0
        with(Logo) array_push(_logo_rows,{id:string(id),kind:object_get_name(object_index),visible:visible})
        with(MainMenuButton) {
            array_push(_button_rows,{id:string(id),kind:object_get_name(object_index),
                image:image_index,x:x,y:y,available:available,visible:visible})
            if(object_index==ButtonDiscord) _discord++
            if(object_index==ButtonAchievements) _achievements++
        }
        // Use the same ordinal instance_find enumeration as native controller
        // traversal; a with(parent) scan is observed to visit reverse order.
        for(var _i=0;_i<instance_number(MainMenuButton);++_i) {
            var _button=instance_find(MainMenuButton,_i)
            array_push(_button_order,{ordinal:_i,id:string(_button.id),kind:object_get_name(_button.object_index),image:_button.image_index})
            if(_button.object_index==MainMenuButton) array_push(_main_buttons,_button)
        }
        scrNTTESmokeLog("SINGLEPLAYER UI LOGO CONSTRUCTION READONLY "+json_stringify({
            created_ref:string(_logo),created_type:typeof(_logo),created_exists:_logo_created_exists,
            created_kind:_logo_created_kind,created_id:string(_logo_created_id),
            after_event_logo_exists:instance_exists(_logo),after_event_logo_count:instance_number(Logo),
            actual_button_count:instance_number(MainMenuButton),exact_main_count:array_length(_main_buttons),
            exact_discord_count:_discord,exact_achievement_count:_achievements,
            logos:_logo_rows,buttons:_button_rows,native_ordinal_buttons:_button_order}))
        // instance_number(parent) includes the two footer subclasses. Preserve
        // them while requiring precisely four exact core objects and six total.
        assert(!instance_exists(_logo) && array_length(_main_buttons)==4
            && _discord==1 && _achievements==1 && instance_number(MainMenuButton)==6,
            "Actual Logo Alarm lost four exact core buttons or either original footer")
        var _images=[0,2,3,4],_buttons=[],_sum_y=0
        for(var _i=0;_i<4;++_i) {
            var _button=_main_buttons[_i]
            assert(instance_exists(_button) && _button.image_index==_images[_i] && _button.available,
                "Actual Logo menu lost original Play/Settings/Stats/Quit image IDs/order")
            assert(_button.y==floor(view_yview_center-36)+24*_i,
                "Four-item native menu is not centered at its original 24-pixel spacing")
            _sum_y+=_button.y;array_push(_buttons,_button)
        }
        // Real menu navigation consumes normal direction inputs and enumerates
        // actual buttons. This verifies traversal only, not physical Bluetooth.
        UberCont.opt_gamepad=true;UberCont.gamepad_sel=-1
        KeyCont.press_nort[global.index]=0;KeyCont.press_sout[global.index]=1
        KeyCont.press_east[global.index]=0;KeyCont.press_west[global.index]=0
        for(var _i=0;_i<4;++_i) {
            with(UberCont) scrGamepadUIControl()
            assert(UberCont.gamepad_sel==_i && _buttons[_i].hover,
                "Native hand-controller navigation skipped a remaining main-menu entry")
            var _hovered=0
            with(MainMenuButton) if(hover) _hovered++
            assert(_hovered==1,"Native menu traversal retained more than one selected button")
        }
        KeyCont.press_sout[global.index]=0
        // A stale image-1 event must exit before registry or menu reset side effects.
        var _stale=instance_create(0,0,MainMenuButton),_old_race=my_player.race,
            _count=instance_number(all),_sel=UberCont.gamepad_sel
        _stale.image_index=1;_stale.available=true
        with(_stale) event_user(0)
        assert(instance_number(all)==_count && instance_exists(_stale) && my_player.race==_old_race
            && UberCont.gamepad_sel==_sel && !instance_exists(CoopMenu) && !instance_exists(CoopController),
            "Removed image-1 menu event still performed a product action")
        instance_destroy(_stale)
        var _options=instance_create(0,0,MenuOptions)
        for(var _cat=0;_cat<array_length(_options.options);++_cat) {
            var _rows=_options.options[_cat]
            if(!is_array(_rows)) continue
            if(_cat==OptionCategory.Coop_Menu) assert(array_length(_rows)==0,
                "Native options still populated the removed cooperative category")
            for(var _i=0;_i<array_length(_rows);++_i) {
                var _row=_rows[_i],_key=scrNTTEFullValue(_row,"key",""),
                    _kind=scrNTTEFullValue(_row,"type","")
                assert(_key!="chat" && _key!="coop_lastip" && _key!="coop_lastport"
                    && !scrNTTEFullValue(_row,"__multiplayer_game",false),
                    "Native options retained a cooperative chat/address/local-server entry")
                if(_kind=="category") assert(_row.category!=OptionCategory.Coop_Menu,
                    "Native options retained a cooperative category link")
                _scanned++
            }
        }
        assert(_scanned>20,"Native MenuOptions fixture did not inspect its real populated option rows")
        assert(scrParseSpawn(["spawn","CoopMenu"])==-1
            && scrParseSpawn(["spawn","CoopController"])==-1
            && scrParseSpawn(["spawn","Coop","Menu"])==-1,
            "Console parser still resolves a removed cooperative controller")
        assert(scrParseSpawn(["spawn","Bandit"])==Bandit,
            "Single-player normal console spawning was disabled with cooperative objects")
        assert(!instance_exists(CoopMenu) && !instance_exists(CoopController),
            "UI-only traversal created cooperative networking objects")
        scrNTTESmokeLog("SINGLEPLAYER UI CONTRACTS BEFORE TEARDOWN actual Logo four centered original IDs/native direction traversal/inert stale1/real option rows="
            +string(_scanned)+"/blocked two cooperative spawn objects/normal Bandit spawn resolution")
    } finally {
        // This component covers entry/layout/option rows, not menu-close Save.
        // The existing fixture helper destroys new instances with perform=false,
        // suppressing Options.Destroy's production OptionsUpdate/Save chain.
        scrNTTEFullMergedRuntimeTestCleanup(_before)
        scrNTTEFullAreaGeneratorRestore(_keys);scrNTTEFullAreaGeneratorRestore(_uber)
        random_set_seed(_seed)
        game_set_speed(_old_speed,gamespeed_fps)
        assert(UberCont.saveData==_old_save_map && ds_map_write(_old_save_map)==_old_savedata,
            "Single-player UI teardown changed original saved options")
        assert(game_get_speed(gamespeed_fps)==_old_speed && timescale==_old_scale
            && UberCont.opt_autopause==_old_autopause && UberCont.paused==_old_paused
            && UberCont.want_pause==_old_want_pause && lockstep_stop==_old_stop
            && global.ntte_smoke_active==_old_smoke && instance_exists(_driver),
            "Single-player UI teardown changed timing/focus/pause policy or deactivated its smoke driver")
        scrNTTESmokeLog("SINGLEPLAYER UI TEARDOWN "+json_stringify({runtime_fps:game_get_speed(gamespeed_fps),
            logic_scale:timescale,opt_autopause:UberCont.opt_autopause,paused:UberCont.paused,
            want_pause:UberCont.want_pause,lockstep_stop:lockstep_stop,smoke_active:global.ntte_smoke_active,
            driver_active:instance_exists(_driver),original_savedata_unchanged:true}))
    }
    scrNTTESmokeLog("PASS SINGLEPLAYER UI ENTRY actual Logo four centered original IDs/native direction traversal/inert stale1/real option rows="
        +string(_scanned)+"/blocked two cooperative spawn objects/normal Bandit spawn resolution/isolated teardown @"+string(_old_speed))
}

// Explicit desktop source UI action QA; no source ownership predicate substitution.
function scrNTTEFullUnlockPresentationStep(_q) {
    assert(instance_exists(_q),"Unlock fixture lost actual queue object");
    with(_q) event_perform(ev_step,ev_step_end);
}
function scrNTTEFullUnlockPresentationRender(_q,_path) {
    var _width=view_width,_height=view_height,_x=view_xview,_y=view_yview;
    var _world=matrix_get(matrix_world),_view=matrix_get(matrix_view),_projection=matrix_get(matrix_projection);
    var _camera=camera_create_view(0,0,640,360,0,noone,-1,-1,-1,-1);
    var _surf=surface_create(640,360);
    assert(surface_exists(_surf),"Unlock fixture could not create real drawing target");
    var _font=draw_get_font(),_ha=draw_get_halign(),_va=draw_get_valign(),
        _color=draw_get_color(),_alpha=draw_get_alpha();
    try {
        view_xview=0;view_yview=0;view_width=640;view_height=360;
        surface_set_target(_surf);camera_apply(_camera);matrix_set(matrix_world,matrix_build_identity());
        draw_clear_alpha(c_black,0);
        draw_set_color(c_white);draw_set_alpha(1);
        draw_set_halign(fa_left);draw_set_valign(fa_middle);
        var _sentinel_font=draw_get_font();
        with(_q) event_perform(ev_draw,0);
        assert(draw_get_font()==_sentinel_font && draw_get_halign()==fa_left
            && draw_get_valign()==fa_middle && draw_get_color()==c_white
            && abs(draw_get_alpha()-1)<0.0001,"Actual UnlockCont Draw leaked renderer state");
        if(_q.splash_image>0 && _q.splash_texty<=0 && _q.unlock[_q.splash_index].txt=="GRAB YOUR FRIENDS") {
            var _silver=make_color_rgb(125,131,141),_visible=0;
            for(var _py=328;_py<360;++_py) for(var _px=384;_px<640;++_px)
                if(surface_getpixel(_surf,_px,_py)==_silver) _visible++;
            assert(_visible>20,"Source silver corner description is absent or outside the visible bottom rows");
        }
        surface_reset_target();
        surface_save(_surf,_path);
    } finally {
        if(surface_get_target()==_surf) surface_reset_target();
        surface_free(_surf);camera_destroy(_camera);
        matrix_set(matrix_world,_world);matrix_set(matrix_view,_view);matrix_set(matrix_projection,_projection);
        view_width=_width;view_height=_height;view_xview=_x;view_yview=_y;
        draw_set_font(_font);draw_set_halign(_ha);draw_set_valign(_va);
        draw_set_color(_color);draw_set_alpha(_alpha);
    }
}
function scrNTTEFullUnlockPresentationAssetTests() {
    scrNTTESmokeLog("UNLOCK BOOL TYPE true real="+string(is_real(true))+" bool="+string(is_bool(true))
        +" false real="+string(is_real(false))+" bool="+string(is_bool(false)));
    var _races=["beetle","parrot"];
    for(var _i=0;_i<array_length(_races);++_i) {
        var _race=scrNTTEFullRaceNumeric(_races[_i]);
        var _m=scrNTTEFullUnlockMetadata("race:"+_races[_i],1);
        var _expected_sprite=scrNTTEFullRaceSprite(_race,"Portrait",0);
        var _expected_sound=scrNTTEFullRaceSound(_race,"Cnfm");
        scrNTTESmokeLog("UNLOCK ASSET TYPE "+_races[_i]+" sprite="+string(_expected_sprite)
            +" is_real="+string(is_real(_expected_sprite))+" exists="+string(sprite_exists(_expected_sprite))
            +" sound="+string(_expected_sound)+" is_real="+string(is_real(_expected_sound))
            +" exists="+string(audio_exists(_expected_sound)));
        assert(sprite_exists(_expected_sprite) && _m.spr==_expected_sprite && sprite_exists(_m.spr),
            "Original race portrait lost through modern asset reference adaptation: "+_races[_i]);
        assert(audio_exists(_expected_sound) && _m.snd==_expected_sound && audio_exists(_m.snd),
            "Original race confirmation lost through modern asset reference adaptation: "+_races[_i]);
        var _locked=scrNTTEFullUnlockMetadata("race:"+_races[_i],false);
        assert(!_locked.unlocked && _locked.txt=="LOCKED" && _locked.spr==-1 && _locked.snd==-1,
            "Boolean false incorrectly treated as a source unlock: "+_races[_i]);
    }
    var _skins=["angler fish","bat eyes","bonus robot","coat venuz","cool frog","orchid plant","red crystal"];
    for(var _i=0;_i<array_length(_skins);++_i) {
        var _key=_skins[_i],_race=scrRaceGetNumericID(scrNTTEFullSkinRace(_key));
        var _m=scrNTTEFullUnlockMetadata("skin:"+_key,1);
        var _expected=scrNTTEFullSkinSprite(_key,sprBigPortrait);
        assert(sprite_exists(_expected) && _m.spr==_expected && sprite_exists(_m.spr),
            "Original native skin portrait lost: "+_key);
        assert(_m.snd==scr_race_get_sound(_race,"Cnfm") && audio_exists(_m.snd),
            "Original native skin confirmation lost: "+_key);
        var _locked=scrNTTEFullUnlockMetadata("skin:"+_key,false);
        assert(!_locked.unlocked && _locked.txt=="LOCKED" && _locked.spr==-1 && _locked.snd==-1,
            "Boolean false incorrectly created a skin portrait: "+_key);
    }
    // Real native pack/unpack roundtrip, not registration or selection.
    scrNTTEFullWeaponNativeInit();
    var _count=array_length(global.ntte_full_native_weapon_models);
    var _data=scrNTTEFullLoadoutWeaponPack(wep_ntte_golden_trident),_encoded=json_stringify(_data);
    var _m=scrNTTEFullUnlockMetadata("loadout:wep:0:main",_data);
    assert(_m.nam==scr_weapon_get_name(wep_ntte_golden_trident) && _m.txt=="STORED!"
        && _m.spr==-1 && _m.snd==-1,"Stored graph metadata did not resolve original weapon name");
    assert(array_length(global.ntte_full_native_weapon_models)==_count && json_stringify(_data)==_encoded,
        "Pure stored-weapon metadata registered a model or mutated saved graph");
}
function scrNTTEFullUnlockPresentationLocaleRender(_q,_root,_portrait) {
    var _big=global.language_font_bigname_default,_small=global.language_font_default,
        _language=global.language_current,_font=draw_get_font();
    var _name=_q.unlock[1].nam[1];
    try {
        scrLanguageSet("English");
        global.language_font_bigname_default=fntBig;global.language_font_default=fntM1;
        scrNTTEFullUnlockPresentationRender(_q,_root+"-english.png");
        if(!_portrait) scrNTTEFullUnlockPresentationTaggedRender(_q,_root+"-english");
        scrLanguageSet("Simplified Chinese");
        global.language_font_bigname_default=fntCJKBig;global.language_font_default=fntCJK;
        if(_portrait) _q.unlock[1].nam[1]="甲虫";
        scrNTTEFullUnlockPresentationRender(_q,_root+"-cjk.png");
        if(!_portrait) scrNTTEFullUnlockPresentationTaggedRender(_q,_root+"-cjk");
    } finally {
        _q.unlock[1].nam[1]=_name;
        global.language_current=_language;
        global.language_font_bigname_default=_big;global.language_font_default=_small;
        draw_set_font(_font);
    }
}
function scrNTTEFullUnlockPresentationTaggedRender(_q,_root) {
    var _u=_q.unlock[_q.splash_index],_name=_u.nam[0],_text=_u.txt;
    try {
        var _m=scrNTTEFullUnlockMetadata("pack:red",true);
        _u.nam[0]=_m.nam+" UNLOCKED";_u.txt=_m.txt;
        scrNTTEFullUnlockPresentationRender(_q,_root+"-red.png");
        _m=scrNTTEFullUnlockMetadata("loadout:crown:crime",true);
        _u.nam[0]=_m.nam+" UNLOCKED";_u.txt=_m.txt;
        scrNTTEFullUnlockPresentationRender(_q,_root+"-crown.png");
    } finally {_u.nam[0]=_name;_u.txt=_text;}
}
function scrNTTEFullUnlockPresentationTests() {
    assert(os_type==os_windows && scrNTTEFullSmokeEnabled(),"Unlock UI QA requires explicit Windows smoke");
    var _rate=game_get_speed(gamespeed_fps);
    assert((_rate==30 || _rate==60) && abs(timescale-30/_rate)<0.0001,"Unlock UI QA needs actual30/60 timing");
    var _scope=scrNTTEFullSkinUnlockNaturalBegin("unlock-presentation"),
        _parked=scrNTTEFullInstances([NTTEFullUnlockCont,UnlockScreen,PauseButton,GameOver,MobileUI]),
        _players=[],_q=noone;
    for(var _i=0;_i<array_length(_parked);++_i) instance_deactivate_object(_parked[_i]);
    try {
        if(!instance_exists(TopCont)) instance_create(0,0,TopCont);
        scrNTTEFullUnlockPresentationAssetTests();
        // A real native gamepad adapter object; inject only sampled A mapping
        // state, preserving its actual get_pressed method and public wrapper.
        var _pad=new __input_class_gamepad(0);
        _pad.custom_mapping=true;_pad.mapping_gm_to_raw={};
        var _a={held:false,press:false,release:false,value:0};
        variable_struct_set(_pad.mapping_gm_to_raw,gp_face1,_a);
        global.__input_gamepads=[_pad];UberCont.opt_gamepad=false;
        global.console_active=true;
        assert(!scrNTTEFullUnlockPressed(0) && !scrNTTEFullUnlockPressed(1),
            "Released native input adapter spuriously confirmed unlock");
        assert(scrNTTEFullUnlockSet("pack:coast",1),"Fresh source pack unlock was refused");
        _q=instance_find(NTTEFullUnlockCont,0);
        assert(instance_exists(_q),"Actual progress UnlockSet failed to create original queued UI");
        assert(instance_number(NTTEFullUnlockCont)==1 && _q.persistent && _q.unlock_delay==50
            && _q.unlock_index==0 && _q.splash_index==-1 && _q.splash_delay==40
            && _q.splash_timer==0 && _q.splash_timer_max==150,"Original queue Create defaults changed");
        assert(_q.unlock[0].nam[0]=="BEACH GUNS UNLOCKED" && _q.unlock[0].nam[1]=="BEACH GUNS"
            && _q.unlock[0].txt=="GRAB YOUR FRIENDS" && _q.unlock[0].spr==-1,
            "Original pack popup/portrait metadata differs");
        assert(scrNTTEFullUnlockSet("race:beetle",1),"Fresh source race unlock was refused");
        assert(scrNTTEFullSkinUnlocked("angler fish"),"Actual native skin wrapper failed");
        assert(instance_number(NTTEFullUnlockCont)==1 && array_length(_q.unlock)==3
            && !instance_exists(UnlockScreen),"Native skin wrapper duplicated queued popup/portrait UI");
        assert(_q.unlock[2].nam[0]=="ABYSSAL FISH UNLOCKED",
            "Boolean ownership omitted original UNLOCKED suffix");
        assert(!scrNTTEFullUnlockSet("race:beetle",1) && !scrNTTEFullSkinUnlocked("angler fish")
            && array_length(_q.unlock)==3,"Already-owned source unlock appended another entry");
        GameCont.crown=NTTEFullCrown.Crime;
        assert(scrNTTEFullCrownLoadoutUnlockCurrent() && array_length(_q.unlock)==4
            && _q.unlock[3].nam[1]=="CROWN OF CRIME@s" && _q.unlock[3].txt=="FOR @wEVERYONE",
            "Actual crown loadout ownership path never reached source presentation");
        assert(scrNTTEFullLoadoutWeaponStore(Race.Fish,wep_ntte_golden_trident)
            && array_length(_q.unlock)==5 && _q.unlock[4].txt=="STORED!"
            && _q.unlock[4].nam[1]==scr_weapon_get_name(wep_ntte_golden_trident),
            "Actual golden weapon Store path never reached source presentation");
        var _n=array_length(_q.unlock);
        scrNTTEFullLoadoutSet("option:unlock_ui_qa",1);
        scrNTTEFullLoadoutWeaponSelect(Race.Fish,scrNTTEFullLoadoutWeaponStored(Race.Fish));
        assert(array_length(_q.unlock)==_n,"Loadout selection/options incorrectly emitted new ownership UI");

        // Known original corner cadence. The delay-crossing tick does not
        // also consume a popup; first reveal tick selects index with image0.
        _q.splash_delay=timescale/2;
        scrNTTEFullUnlockPresentationStep(_q);
        assert(_q.splash_delay<=0 && _q.splash_index==-1,"Corner delay crossing consumed entry too early");
        scrNTTEFullUnlockPresentationStep(_q);
        assert(_q.splash_index==0 && _q.splash_timer==150 && _q.splash_image==0 && _q.splash_texty==2,
            "First source corner reveal state differs");
        var _frames=sprite_get_number(_q.splash_sprit)-1;
        assert(_frames==3,"Original corner artwork frame count changed");
        // The source clamp(delta,-1,1)*timescale has an asymptotic tail at60.
        repeat(_rate==30?3:6) scrNTTEFullUnlockPresentationStep(_q);
        assert(abs(_q.splash_image-(_rate==30?3:2.75))<0.0001 && _q.splash_texty==2,
            "Known original 30/60 corner image vector/title gate differs");
        var _settle=0;
        while(_q.splash_image<_frames) {
            scrNTTEFullUnlockPresentationStep(_q);_settle++;
            assert(_q.splash_texty==2 && _settle<128,"Corner title moved before source image comparison became ready");
        }
        scrNTTEFullUnlockPresentationStep(_q);
        assert(abs(_q.splash_texty-(2-timescale))<0.0001,"Corner title source offset timing differs");
        _q.splash_texty=0;
        scrNTTEFullUnlockPresentationRender(_q,_scope.scratch+"corner-"+string(_rate)+".png");
        scrNTTEFullUnlockPresentationLocaleRender(_q,_scope.scratch+"corner-"+string(_rate),false);

        _players=scrNTTEFullInstances(Player);
        for(var _i=0;_i<array_length(_players);++_i) instance_deactivate_object(_players[_i]);
        TopCont.darkness=false;UberCont.paused=false;
        assert(scrNTTEFullUnlockPendingPortrait(),"Death pending detector ignored actual race/skin portraits");
        var _native=instance_create(0,0,UnlockScreen);
        scrNTTEFullUnlockPresentationStep(_q);
        assert(_q.unlock_delay==1,"Native UnlockScreen did not retain priority and source delay1");
        with(TopCont) event_perform(ev_step,ev_step_end);
        assert(!instance_exists(GameOver),"Native UnlockScreen priority incorrectly made GameOver");
        instance_destroy(_native,false);
        _q.unlock_delay=50;
        var _ticks=0;
        while(_q.unlock_delay>0) {
            with(TopCont) event_perform(ev_step,ev_step_end);
            assert(!instance_exists(GameOver),"Epsilon GameOver constructor ran before pending portrait queue");
            scrNTTEFullUnlockPresentationStep(_q);_ticks++;
            assert(_ticks<=ceil(50/timescale)+1,"Original portrait delay never expired");
        }
        assert(_ticks==ceil(50/timescale) && _q.unlock_index==1 && _q.unlock_delay_continue==20
            && _q.unlock_porty==0 && TopCont.visible,"Original death skip/delay/cross-zero transition differs");
        assert(audio_is_playing(sndCharUnlock) && audio_is_playing(_q.unlock[1].snd),
            "Original cross-zero char/confirmation audio not playing");
        repeat(ceil(20/timescale)) {
            scrNTTEFullUnlockPresentationStep(_q);
            assert(_q.unlock_index==1,"Source delay consumed input on its final decrement tick");
        }
        // GM's ambient comparison epsilon can make even 0<1e-8 false.
        // Keep the strict original bound and change only this assertion's
        // comparison context, restoring gameplay math immediately afterward.
        var _epsilon=math_get_epsilon();
        try {
            math_set_epsilon(0);
            assert(_q.unlock_delay_continue==0 && abs(_q.unlock_image-(sprite_get_number(_q.unlock_sprit)-1))<0.00000001,
                "Original death presentation animation/20tick continue delay differs");
        } finally { math_set_epsilon(_epsilon); }
        scrNTTEFullUnlockPresentationRender(_q,_scope.scratch+"portrait-"+string(_rate)+".png");
        scrNTTEFullUnlockPresentationLocaleRender(_q,_scope.scratch+"portrait-"+string(_rate),true);
        _a.held=true;_a.press=false;_a.value=1;
        assert(input_gamepad_check(0,gp_face1) && !input_gamepad_check_pressed(0,gp_face1),
            "Native A held/pressed fixture mapping did not separate the states");
        scrNTTEFullUnlockPresentationStep(_q);
        assert(_q.unlock_index==1,"Holding A wrongly skipped queued unlock without another press");
        _a.press=true;
        var _mobile=is_mobile;
        try {
            is_mobile=true;
            assert(scrNTTEFullUnlockPressed(0) && !scrNTTEFullUnlockPressed(1),
                "Mobile platform branch discarded native Xbox A press");
        } finally { is_mobile=_mobile; }
        scrNTTEFullUnlockPresentationStep(_q);
        assert(_q.unlock_index==2 && _q.unlock_delay==1,"Actual native A press failed one-entry advance/delay1");
        _a.press=false;
        while(_q.unlock_delay>0) scrNTTEFullUnlockPresentationStep(_q);
        assert(_q.unlock_delay_continue==20,"Next source portrait did not reset its confirmation delay");
        repeat(ceil(20/timescale)) scrNTTEFullUnlockPresentationStep(_q);
        _a.press=true;scrNTTEFullUnlockPresentationStep(_q);_a.press=false;
        assert(_q.unlock_index==3 && _q.unlock_delay==1,"Second source portrait A press advanced incorrectly");
        scrNTTEFullUnlockPresentationStep(_q);
        assert(!instance_exists(_q) && !scrNTTEFullUnlockPendingPortrait() && TopCont.visible,
            "Corner-only tail did not skip/destroy actual queue and restore TopCont");
        with(TopCont) event_perform(ev_step,ev_step_end);
        assert(instance_number(GameOver)==1 && instance_number(PauseButton)==2,
            "Completed original portrait queue failed actual Epsilon GameOver/PauseButton handoff");
        scrNTTESmokeLog("PASS UNLOCK PRESENTATION SOURCE: actual progress/store/crown/skin queue;native asset refs;once-only queue;corner40/150/source image+title cadence;native Draw artifacts/state;original death50+20/skip tail;native UnlockScreen priority;real gamepad adapter A edge not hold;actual GameOver2buttons @"+string(_rate)+" artifacts="+_scope.scratch);
    } finally {
        for(var _i=0;_i<array_length(_players);++_i) instance_activate_object(_players[_i]);
        for(var _i=0;_i<array_length(_parked);++_i) instance_activate_object(_parked[_i]);
        scrNTTEFullSkinUnlockNaturalEnd(_scope);
    }
}

// Controlled native lifecycle tests. Call once before main UnlockPresentationTests,
// outside another NaturalBegin scope. No physical touch/Xbox claim.
function scrNTTEFullUnlockPresentationLifecycleTests() {
    var _scope=scrNTTEFullSkinUnlockNaturalBegin("unlock-lifecycle");
    var _parked=scrNTTEFullInstances([NTTEFullUnlockCont,UnlockScreen,PauseButton,MenuOptions,GameOver,MobileUI]);
    var _game=instance_find(GameCont,0),_new_game=noone,_players=[],_newgame_players=[];
    for(var _i=0;_i<array_length(_parked);++_i) instance_deactivate_object(_parked[_i]);
    try {
        if(!instance_exists(TopCont)) instance_create(0,0,TopCont);
        // Real duplicate Create must exit before it can touch older queues.
        var _entry=scrNTTEFullUnlockSplat("BEETLE","SOURCE QA",scrNTTEFullRaceSprite(17,"Portrait",0),scrNTTEFullRaceSound(17,"Cnfm"));
        var _q=instance_find(NTTEFullUnlockCont,0);
        var _duplicate=instance_create(0,0,GameCont);
        assert(!instance_exists(_duplicate) && instance_exists(_q) && array_length(_q.unlock)==1,
            "Rejected duplicate native GameCont incorrectly cleared source queue");
        // Native RunStart/MakeGame constructs GameCont before any Player.
        _newgame_players=scrNTTEFullInstances(Player);
        for(var _i=0;_i<array_length(_newgame_players);++_i) instance_deactivate_object(_newgame_players[_i]);
        instance_deactivate_object(_game);
        _new_game=instance_create(0,0,GameCont);
        assert(instance_exists(_new_game) && !instance_exists(_q),
            "Genuine new GameCont Create failed original older-ID UnlockCont cleanup");
        instance_destroy(_new_game);_new_game=noone;
        instance_activate_object(_game);
        for(var _i=0;_i<array_length(_newgame_players);++_i) instance_activate_object(_newgame_players[_i]);

        // Enter actual Epsilon pause, including its deactivate-all whitelist.
        // scrGamePause sets want_pause2; two real BeginSteps settle its2ticks.
        scrNTTEFullUnlockSplat("BEETLE","SOURCE QA",scrNTTEFullRaceSprite(17,"Portrait",0),scrNTTEFullRaceSound(17,"Cnfm"));
        _q=instance_find(NTTEFullUnlockCont,0);
        UberCont.paused=false;UberCont.want_pause=0;UberCont.bossintro=false;
        scrGamePause();
        with(UberCont) event_perform(ev_step,ev_step_begin);
        with(UberCont) event_perform(ev_step,ev_step_begin);
        assert(scrGameIsPaused() && !instance_exists(Player) && instance_exists(PauseButton)
            && instance_exists(_q),"Native pause whitelist lost source queue or failed actual player deactivation");
        // Opening actual Settings removes every PauseButton while paused.
        var _settings=noone;
        with(PauseButton) if(image_index==2) _settings=id;
        assert(instance_exists(_settings),"Native Settings button absent after real pause");
        with(_settings) event_user(0);
        assert(instance_exists(MenuOptions) && !instance_exists(PauseButton) && scrGameIsPaused()
            && !instance_exists(Player),"Actual pause Settings did not enter source BackMainMenu-equivalent state");
        var _index=_q.unlock_index,_delay=_q.unlock_delay;
        _q.splash_delay=0;
        with(_q) event_perform(ev_step,ev_step_end);
        assert(instance_exists(_q) && _q.splash_index==0 && _q.splash_timer==150
            && _q.unlock_index==_index && _q.unlock_delay==_delay && !scrNTTEFullUnlockPendingPortrait(),
            "Paused native Options either froze corner or consumed a death portrait");
        with(_q) event_perform(ev_step,ev_step_end);
        assert(_q.splash_image>0 && _q.splash_timer<150 && _q.unlock_index==_index && _q.unlock_delay==_delay,
            "Native paused Options failed corner animation/cadence or advanced portrait delay");
        scrGameUnpause(); // genuine resume reactivates every pre-pause instance.
        instance_destroy(MenuOptions,false);
        with(_q) event_perform(ev_step,ev_step_end);
        assert(instance_exists(_q) && instance_exists(Player) && _q.unlock_delay==_delay,
            "Actual resume lost persistent source queue or misdetected living player");

        // Original code explicitly disposes the queue on Menu entry. It must
        // preserve Menu itself, ownership and native GameOver's Menu exclusion.
        var _menu=instance_create(0,0,Menu);
        assert(instance_exists(_menu),"Actual Epsilon character-menu constructor failed");
        _players=scrNTTEFullInstances(Player);
        for(var _i=0;_i<array_length(_players);++_i) instance_deactivate_object(_players[_i]);
        assert(!scrNTTEFullUnlockPendingPortrait(),"Actual Menu incorrectly acquired source death gate");
        with(TopCont) event_perform(ev_step,ev_step_end);
        assert(instance_exists(_menu) && !instance_exists(GameOver),"Queued source UI destroyed Menu or made death UI there");
        with(_q) event_perform(ev_step,ev_step_end);
        assert(!instance_exists(_q) && instance_exists(_menu) && !instance_exists(GameOver),
            "Original Menu entry failed queue disposal or destroyed native Menu");
        scrNTTESmokeLog("PASS UNLOCK LIFECYCLE: actual duplicate/new GameCont Create;source older-ID cleanup;actual pause deactivation whitelist;Settings native user event/noPauseButtons;corner progresses while portraits wait;actual resume;native Menu remains and original queue self-disposes @"+string(30/timescale));
    } finally {
        if(instance_exists(_new_game)) instance_destroy(_new_game);
        instance_activate_object(_game);
        for(var _i=0;_i<array_length(_newgame_players);++_i) instance_activate_object(_newgame_players[_i]);
        if(scrGameIsPaused()) scrGameUnpause();
        for(var _i=0;_i<array_length(_players);++_i) instance_activate_object(_players[_i]);
        for(var _i=0;_i<array_length(_parked);++_i) instance_activate_object(_parked[_i]);
        scrNTTEFullSkinUnlockNaturalEnd(_scope);
    }
}

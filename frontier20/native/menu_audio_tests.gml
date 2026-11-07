// Private background acceptance. The runner is muted at its Windows audio
// session, while these actual native voices keep nonzero resource/voice gains.
// No fixture voice or asset-volume workaround is used in ordinary games.
function scrFRMenuAudioTestsRecord(_voice,_sample,_kind) {
    if(os_type!=os_windows || !scrNTTEFullSmokeEnabled()
        || !variable_global_exists("fr_menu_audio_test_state")) return _voice;
    var _state=global.fr_menu_audio_test_state;
    if(!is_struct(_state) || _state.phase==99 || _voice<0) return _voice;
    array_push(_state.voices,{voice:_voice,sample:_sample,name:audio_get_name(_sample),kind:_kind,
        frame:current_frame,phase:_state.phase,round:_state.round,
        gain_at_start:audio_sound_get_gain(_voice),sample_gain_at_start:audio_sound_get_gain(_sample),
        pitch_at_start:audio_sound_get_pitch(_voice)});
    return _voice;
}

function scrFRMenuAudioTestsStart(_driver) {
    assert(os_type==os_windows && scrNTTEFullSmokeEnabled() && scrFREnabled(),
        "Menu audio acceptance requires the private muted desktop harness");
    var _original=UberCont.saveData,_copy=ds_map_create();
    ds_map_copy(_copy,_original);UberCont.saveData=_copy;
    var _state={phase:0,round:0,ticks:0,wait:0,driver:_driver,old_driver:noone,
        original_map:_original,fixture_map:_copy,original_bytes:ds_map_write(_original),
        voices:[],snapshots:[],rows:[],old_source:-1,portal:-1,ambient:-1,mode_start:-1,
        track_start:0,gain_start:0,portal_plays_start:0,wall_start:0};
    global.fr_menu_audio_test_state=_state;_driver.fr_menu_audio=_state;
    save_set_value("game","tutorial",false);save_set_value("options","autopause",false);
    save_set_value("visual","freezeframes",0);save_set_value("visual","bossintro",false);
    save_set_value("volume","master",1);save_set_value("volume","music",.6);
    save_set_value("volume","ambient",.5);save_set_value("volume","sfx",.7);
    UberCont.opt_autopause=false;UberCont.opt_freeze=0;UberCont.paused=false;
    UberCont.want_quit_to_menu=false;UberCont.want_menu=false;UberCont.want_restart=false;
    scrNTTESmokeLog("NTUF MENU AUDIO real nonzero-gain voices under external process mute started");
}

function scrFRMenuAudioTestsObserve() {
    if(os_type!=os_windows || !scrNTTEFullSmokeEnabled()
        || !variable_global_exists("fr_menu_audio_test_state")) return;
    var _state=global.fr_menu_audio_test_state;
    if(!is_struct(_state) || _state.phase==99) return;
    instance_activate_object(_state.driver);
    if(instance_exists(_state.driver)) return;
    var _driver=instance_create(0,0,FRIntegrationTest);
    _driver.fr_test_case="menu_audio";_driver.fr_menu_audio=_state;_state.driver=_driver;
}

function scrFRMenuAudioTestsCount(_state,_sample,_live) {
    var _count=0;
    for(var _i=0;_i<array_length(_state.voices);++_i) {
        var _voice=_state.voices[_i];
        if(_voice.sample==_sample && (!_live || audio_is_playing(_voice.voice))) _count+=1;
    }
    return _count;
}

function scrFRMenuAudioTestsLatest(_state,_sample) {
    for(var _i=array_length(_state.voices)-1;_i>=0;--_i)
        if(_state.voices[_i].sample==_sample) return _state.voices[_i].voice;
    return -1;
}

function scrFRMenuAudioTestsNoRunLoading(_label) {
    assert(!instance_exists(GameCont),
        _label+": Back retained a retired GameCont instead of returning to the main menu");
    assert(!global.fr_module_vars[$ "mod:campfire"].level_loading
        && !global.fr_module_vars[$ "mod:wibbly"].level_start,
        _label+": source loading-completion flags outlived their retired native run");
    var _lib=global.fr_lib_global;
    assert(instance_exists(_lib) && !_lib.level_loading
        && !global.fr_module_vars[$ "mod:lib"].level_loading,
        _label+": native Back left a pending lib loading-completion notification");
}

function scrFRMenuAudioTestsIdleBegin(_state,_phase) {
    _state.portal=scrFRMenuAudioTestsLatest(_state,sndPortalLoop);
    assert(_state.portal>=0 && audio_is_playing(_state.portal),
        "Real spiral menu did not start its native portal ambience voice");
    assert(scrFRMenuAudioTestsCount(_state,sndPortalLoop,true)==1,
        "Spiral menu began with duplicated portal ambience voices");
    assert(abs(audio_sound_get_gain(sndPortalLoop)-.5)<.0001
        && audio_sound_get_gain(_state.portal)>.01
        && abs(audio_sound_get_pitch(_state.portal)-1)<.0001,
        "Menu audio fixture accidentally concealed its voice behind muted resource/voice gain or wrong pitch");
    _state.portal_plays_start=scrFRMenuAudioTestsCount(_state,sndPortalLoop,false);
    _state.track_start=audio_sound_get_track_position(_state.portal);
    _state.gain_start=audio_sound_get_gain(_state.portal);_state.wall_start=get_timer();
    _state.wait=0;_state.phase=_phase;
}

function scrFRMenuAudioTestsIdleEnd(_state,_label) {
    assert(audio_is_playing(_state.portal)
        && scrFRMenuAudioTestsCount(_state,sndPortalLoop,true)==1
        && scrFRMenuAudioTestsCount(_state,sndPortalLoop,false)==_state.portal_plays_start,
        "Idle mode menu restarted or stacked its native portal ambience voice");
    assert(abs(audio_sound_get_gain(_state.portal)-_state.gain_start)<.0001
        && abs(audio_sound_get_gain(sndPortalLoop)-.5)<.0001
        && abs(audio_sound_get_pitch(_state.portal)-1)<.0001,
        "Idle mode menu changed its actual native ambience gain or pitch");
    var _length=audio_sound_length(sndPortalLoop),
        _advance=(audio_sound_get_track_position(_state.portal)-_state.track_start+_length) mod _length,
        _wall=(get_timer()-_state.wall_start)/1000000;
    assert(_advance>.5 && abs(_advance-_wall)<.7,
        "Idle portal voice failed to advance at the native audio clock speed");
    assert(!audio_is_playing(_state.old_source),
        "Retired source gameplay loop leaked into the native mode menu");
    for(var _i=0;_i<array_length(_state.voices);++_i) {
        var _voice=_state.voices[_i];
        if(audio_is_playing(_voice.voice))
            array_push(_state.snapshots,{label:_label,round:_state.round,frame:current_frame,
                voice:_voice.voice,name:_voice.name,kind:_voice.kind,
                gain:audio_sound_get_gain(_voice.voice),sample_gain:audio_sound_get_gain(_voice.sample),
                pitch:audio_sound_get_pitch(_voice.voice),track:audio_sound_get_track_position(_voice.voice)});
        if(_voice.round==_state.round && _voice.phase<=2 && _voice.kind=="frontier-loop")
            assert(!audio_is_playing(_voice.voice),
                "A source loop created by gameplay/cleanup remained alive in the mode menu: "+_voice.name);
    }
    var _row={rate:30/timescale,phase:_label,portal_voice:_state.portal,
        live_portal_voices:1,new_portal_plays:0,voice_gain:audio_sound_get_gain(_state.portal),
        sample_gain:audio_sound_get_gain(sndPortalLoop),pitch:audio_sound_get_pitch(_state.portal),
        track_advance:_advance,wall_seconds:_wall,old_source_stopped:true};
    array_push(_state.rows,_row);scrNTTESmokeLog("NTUF MENU AUDIO native idle "+json_stringify(_row));
}

function scrFRMenuAudioTestsStep(_driver) {
    var _state=_driver.fr_menu_audio;
    assert(++_state.ticks<2400,"Native menu audio acceptance timed out at phase "+string(_state.phase));
    if(_state.phase==0) {
        if(instance_exists(GenCont) || instance_exists(FloorMaker)) return false;
        save_set_value("options","framerate",_state.round==0?30:60);scrOptionsUpdate();
        UberCont.opt_autopause=false;UberCont.opt_freeze=0;UberCont.paused=false;
        // Resource gains in the ordinary private runner are patched to zero
        // for start-up safety. Restore only these known voices after the
        // runner's Windows process mute has been applied, so gain assertions
        // exercise the real audio path rather than a zero-volume shortcut.
        var _assets=[sndPortalLoop,sndPortalFlyby1,sndPortalFlyby2,sndPortalFlyby3,sndPortalFlyby4,
            amb0,sndMenuCharSelect,sndClick,sndClickBack,sndHover,
            musThemeA,musThemeB,musThemeP];
        for(var _i=0;_i<array_length(_assets);++_i) audio_sound_gain(_assets[_i],1,0);
        scrVolume();audio_emitter_gain(UberCont.mainsound,.7);
        var _source=scrFRModGet("area","robocenter","ambRobocenter");
        assert(audio_exists(_source),"Native source-loop positive control sample was absent");
        audio_sound_gain(_source,1,0);
        _state.old_source=scrFRSoundLoop(_source);
        assert(_state.old_source>=0 && audio_is_playing(_state.old_source)
            && audio_sound_get_gain(_state.old_source)>.01,
            "Nonzero-gain source-loop positive control failed to obtain a real voice");
        _state.wait=0;_state.phase=1;return false;
    }
    if(_state.phase==1) {
        if(++_state.wait<4) return false;
        _state.phase=2;_state.old_driver=_driver;scrGameRestart(true);return false;
    }
    if(_state.phase==2) {
        if(instance_exists(_state.old_driver) || instance_exists(GameCont)) return false;
        assert(!audio_is_playing(_state.old_source),
            "Genuine native return-to-menu did not stop an old source loop");
        UberCont.want_quit_to_menu=false;UberCont.want_menu=false;UberCont.want_restart=false;
        UberCont.showtutorial=false;UberCont.hardgot=true;
        if(!instance_exists(MusCont)) instance_create(0,0,MusCont);
        instance_create(0,0,SpiralCont);
        with(instance_create(0,0,Logo)) event_perform(ev_alarm,1);
        // Parent scans include the Discord/Achievements footer subclasses,
        // whose image 0 is not the actual Play consumer.
        var _play=noone;with(MainMenuButton)
            if(object_index==MainMenuButton && image_index==0) {_play=id;break;}
        assert(instance_exists(_play),"Native main menu did not supply its actual Play consumer");
        with(_play) event_perform(ev_other,ev_user0);
        assert(instance_number(PlayButton)>=2 && instance_number(SpiralCont)==1,
            "Actual main menu Play did not reach the recorded mode-selection scene");
        _state.wait=0;_state.phase=3;return false;
    }
    if(_state.phase==3) {
        if(++_state.wait<3) return false;
        scrFRMenuAudioTestsIdleBegin(_state,4);return false;
    }
    if(_state.phase==4) {
        if(++_state.wait<90/timescale) return false;
        scrFRMenuAudioTestsIdleEnd(_state,"mode-menu-after-restart");
        var _normal=noone;with(PlayButton) if(num==0) {_normal=id;break;}
        assert(instance_exists(_normal),"Actual mode menu omitted its Normal PlayButton");
        with(_normal) event_perform(ev_other,ev_user0);
        assert(!instance_exists(SpiralCont) && instance_exists(GameCont) && instance_exists(MenuGen)
            && !audio_is_playing(_state.portal),
            "Normal PlayButton failed to begin the actual asynchronous character-menu generator");
        _state.ambient=-1;
        _state.wait=0;_state.phase=5;return false;
    }
    if(_state.phase==5) {
        // MenuGen creates Menu immediately and finishes its campfire through
        // later FloorMaker/Alarm events; the generator itself stays alive.
        if(instance_exists(FloorMaker) || !instance_exists(Menu)) return false;
        if(_state.ambient<0) {
            _state.ambient=scrFRMenuAudioTestsLatest(_state,amb0);
            assert(_state.ambient>=0 && audio_is_playing(_state.ambient)
                && scrFRMenuAudioTestsCount(_state,amb0,true)==1,
                "Real native character menu did not start one ambience voice");
            _state.wait=0;return false;
        }
        if(++_state.wait<90/timescale) return false;
        assert(!audio_is_playing(_state.portal) && !audio_is_playing(_state.old_source)
            && audio_is_playing(_state.ambient) && scrFRMenuAudioTestsCount(_state,amb0,true)==1,
            "Idle character menu leaked retired portal/source audio or stacked ambience");
        var _back=instance_find(BackButton,0);
        assert(instance_exists(_back),"Native character menu had no actual BackButton");
        _state.phase=6;_state.old_driver=_driver;
        with(_back) event_perform(ev_other,ev_user0);
        return false;
    }
    if(_state.phase==6) {
        if(instance_exists(_state.old_driver)) return false;
        scrFRMenuAudioTestsNoRunLoading("actual-character-Back");
        assert(!instance_exists(Menu) && instance_number(SpiralCont)==1
            && !audio_is_playing(_state.ambient),
            "Actual character-menu Back retained its old ambience or failed to restore the spiral scene");
        _state.wait=0;_state.phase=7;return false;
    }
    if(_state.phase==7) {
        if(++_state.wait<3) return false;
        scrFRMenuAudioTestsIdleBegin(_state,8);return false;
    }
    if(_state.phase==8) {
        if(++_state.wait<90/timescale) return false;
        scrFRMenuAudioTestsIdleEnd(_state,"main-menu-after-character-back");
        scrFRMenuAudioTestsNoRunLoading("main-menu-after-character-back-idle");
        if(++_state.round<2) {_state.phase=0;return false;}
        var _calls={};
        for(var _i=0;_i<array_length(_state.voices);++_i) {
            var _voice=_state.voices[_i],
                _key=string(_voice.round)+":"+string(_voice.phase)+":"+_voice.name;
            _calls[$ _key]=(_calls[$ _key]??0)+1;
        }
        var _file=file_text_open_write(working_directory+"ntuf-menu-audio-voices.json");
        try {file_text_write_string(_file,json_stringify({rows:_state.rows,calls:_calls,
            voices:_state.voices,snapshots:_state.snapshots}));}
        finally {file_text_close(_file);}
        scrNTTESmokeLog("NTUF MENU AUDIO actual play calls "+json_stringify(_calls));
        audio_stop_all();
        UberCont.saveData=_state.original_map;ds_map_destroy(_state.fixture_map);
        assert(ds_map_write(_state.original_map)==_state.original_bytes,
            "Menu audio acceptance changed the original permanent save map");
        scrNTTESmokeLog("PASS FRONTIER MENU AUDIO real native restart, mode idle, character idle and Back audio ownership at30/60Hz "+json_stringify(_state.rows));
        _state.phase=99;global.fr_menu_audio_test_state=undefined;return true;
    }
    return false;
}

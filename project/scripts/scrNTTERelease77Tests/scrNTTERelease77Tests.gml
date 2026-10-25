// A roadmap draw must remain safe when an old/session skin is not authored
// for the currently selected additional character. Exercise real rendering.
function scrNTTERoadmapPlayerIconsTests() {
    var _state=scrNTTEFullMenuStats67Begin(),_identity=scr_playerinstance_find(0),
        _race=_identity.race,_skin=_identity.skin,_hp=_identity.hp,_surface=-1,_camera=-1,
        _world=matrix_get(matrix_world),_view=matrix_get(matrix_view),_projection=matrix_get(matrix_projection),
        _color=draw_get_color(),_alpha=draw_get_alpha(),_count=0;
    try {
        GameCont.area=area_scrapyards;GameCont.subarea=3;
        GameCont.waypoints=1;GameCont.waypnt=[area_scrapyards];GameCont.waysub=[3];GameCont.waylps=[0];
        _surface=surface_create(320,180);_camera=camera_create_view(0,0,320,180,0,noone,-1,-1,-1,-1);
        surface_set_target(_surface);camera_apply(_camera);draw_clear_alpha(c_black,0);
        for(var _r=Race.Fish;_r<=NTTEFullRace.Parrot;++_r) {
            for(var _s=0;_s<scrRaceGetMaxSkinCount(_r);++_s) {
                _identity.race=_r;_identity.skin=_s;_identity.hp=4;
                assert(sprite_exists(scrNTTEFullSkinMenuSprite(_r,_s,sprMapIcon)),"Authored roadmap icon is missing: "+string([_r,_s]));
                scrDrawRoadmap(160,90,1);_count++;
            }
        }
        for(var _s=200;_s<=206;++_s) {
            _identity.race=scrRaceGetNumericID(scrNTTEFullSkinRace(scrNTTEFullSkinKey(_s)));_identity.skin=_s;
            assert(sprite_exists(scrNTTEFullSkinMenuSprite(_identity.race,_s,sprMapIcon)),"Authored extension skin map icon missing");
            scrDrawRoadmap(160,90,1);_count++;
        }
        _identity.race=Race.Chicken;_identity.skin=0;_identity.hp=0;scrDrawRoadmap(160,90,1);
        GameCont.area=area_city;_identity.race=Race.Rebel;_identity.skin=SkinLetter.B;scrDrawRoadmap(160,90,1);
        // Session/old-save invalid combinations are a genuine -1 resolver path;
        // do not delete static resources or bypass the real roadmap renderer.
        for(var _r=NTTEFullRace.Beetle;_r<=NTTEFullRace.Parrot;++_r) {
            _identity.race=_r;_identity.skin=0;_identity.hp=4;
            draw_clear_alpha(c_black,0);scrDrawRoadmap(160,90,1);
            var _default_pixels=scrNTTEParrotPerchPixels77(_surface);
            for(var _s=0;_s<3;++_s) {
                _identity.race=_r;_identity.skin=[-1,2,204][_s];_identity.hp=4;
                draw_clear_alpha(c_black,0);scrDrawRoadmap(160,90,1);
                assert(scrNTTEParrotPerchPixels77(_surface)==_default_pixels,
                    "Stale skin did not render its character's exact default map icon");
            }
        }
        scrNTTESmokeLog("PASS ROADMAP ICONS actual native rendering authored="+string(_count)+", seven extension skins, headless/hooded and six stale session skin combinations @"+string(30/timescale));
    } finally {
        _identity.race=_race;_identity.skin=_skin;_identity.hp=_hp;
        if(surface_get_target()==_surface) surface_reset_target();
        if(surface_exists(_surface)) surface_free(_surface);if(_camera>=0) camera_destroy(_camera);
        matrix_set(matrix_world,_world);matrix_set(matrix_view,_view);matrix_set(matrix_projection,_projection);
        draw_set_color(_color);draw_set_alpha(_alpha);scrNTTEFullMenuStats67End(_state);
    }
}
function scrNTTEParrotPerchPixels77(_surface) {
    var _size=surface_get_width(_surface)*surface_get_height(_surface)*4,_buffer=buffer_create(_size,buffer_fixed,1),_pixels=[];
    try {buffer_get_surface(_buffer,_surface,0);for(var _i=0;_i<_size;_i+=4) array_push(_pixels,buffer_peek(_buffer,_i,buffer_u32));}
    finally {buffer_delete(_buffer);}
    return json_stringify(_pixels);
}
function scrNTTEParrotPerchShadowTests() {
    var _state=scrNTTEFullMenuStats67Begin(),_surface=-1,_camera=-1,
        _world=matrix_get(matrix_world),_view=matrix_get(matrix_view),_projection=matrix_get(matrix_projection),
        _color=draw_get_color(),_alpha=draw_get_alpha();
    try {
        GameCont.area=201;GameCont.subarea=1;
        var _shell=instance_create(96,96,NTTEFullCoastBigDecal),_parrot=scrNTTEFullPetCreate(96,96,"Parrot");
        _shell.speed=0;_parrot.leader=_shell;_parrot.perched=_shell;_parrot.pickup=noone;
        with(_parrot) scrNTTEFullPetParrotStep();
        assert(_parrot.perched==_shell && _parrot.perched_y<0,"Actual shell did not retain its elevated parrot perch");
        // No local player owns this shell, so the optional pet outline is off.
        _parrot.leader=noone;
        _surface=surface_create(192,160);_camera=camera_create_view(0,0,192,160,0,noone,-1,-1,-1,-1);
        surface_set_target(_surface);camera_apply(_camera);
        for(var _skin=0;_skin<2;++_skin) {
            _parrot.bskin=_skin;with(_parrot) scrNTTEFullPetParrotSkin();
            _parrot.sprite_index=_parrot.spr_idle;_parrot.image_index=0;
            draw_clear_alpha(c_black,0);with(_parrot) scrNTTEFullPetBodyDraw();
            var _body=scrNTTEParrotPerchPixels77(_surface);
            draw_clear_alpha(c_black,0);with(_parrot) event_perform(ev_draw,0);
            assert(scrNTTEParrotPerchPixels77(_surface)==_body,"Perched parrot Draw painted a stray ground shadow over the shell");
            _parrot.perched=noone;
            draw_clear_alpha(c_black,0);with(_parrot) {draw_sprite(spr_shadow,0,x+spr_shadow_x,y+spr_shadow_y);scrNTTEFullPetBodyDraw();}
            var _ground=scrNTTEParrotPerchPixels77(_surface);
            draw_clear_alpha(c_black,0);with(_parrot) event_perform(ev_draw,0);
            assert(scrNTTEParrotPerchPixels77(_surface)==_ground,"Grounded parrot lost its normal source shadow");
            _parrot.perched=_shell;
        }
        scrNTTESmokeLog("PASS PARROT PERCH actual shell and both parrot skins, native Draw pixel oracle, no perched stripe and normal grounded shadow @"+string(30/timescale));
    } finally {
        if(surface_get_target()==_surface) surface_reset_target();
        if(surface_exists(_surface)) surface_free(_surface);if(_camera>=0) camera_destroy(_camera);
        matrix_set(matrix_world,_world);matrix_set(matrix_view,_view);matrix_set(matrix_projection,_projection);
        draw_set_color(_color);draw_set_alpha(_alpha);scrNTTEFullMenuStats67End(_state);
    }
}
function scrNTTEDummyAmbushMusicTests() {
    var _state=scrNTTEBossMusic77Begin(),_mus=instance_find(MusCont,0),_player=instance_find(Player,0),
        _parked=scrNTTEFullInstances([Wall,WantBoss,NTTEFullWorldEvent,CanSpawnBoss]);
    for(var _i=0;_i<array_length(_parked);++_i) instance_deactivate_object(_parked[_i]);
    try {
        GameCont.area=area_desert;GameCont.subarea=2;GameCont.loops=0;GameCont.proto=false;
        _player.x=80000;_player.y=80000;
        with(_mus) {alarm[1]=-1;event_perform(ev_alarm,11);}
        var _voice=_mus.music_sound,_want=instance_create(0,0,WantBoss),
            _event=instance_create(80000,80000,NTTEFullWorldEvent),_target=instance_create(80000,80000,TutorialTarget);
        _event.type="Dummy";_event.dummy_spawn=1;_event.dummy_music=false;_event.dummy_target=_target;
        _target.hp=8;_target.x=80032;
        assert(!position_meeting(_event.x,_event.y,TutorialTarget) && instance_exists(_target),
            "Fixture must distinguish a living displaced target from an absent target");
        with(_event) scrNTTEFullBlockedRoomStep();
        assert(_event.dummy_spawn==1 && !_event.dummy_music && !GameCont.proto && _mus.alarm[1]==-1,
            "Living Dummy displacement falsely consumed an ambush or armed Boss victory music");
        _target.hp=0;with(_target) event_perform(ev_step,ev_step_normal);
        assert(!instance_exists(_target),"Broken Dummy must pass through native enemy death");
        assert(instance_number(Wall)==0,"Isolated missing-spawn-wall control was contaminated");
        repeat(3) with(_event) scrNTTEFullBlockedRoomStep();
        assert(_event.dummy_spawn==1 && !_event.dummy_music && _event.dummy_retry>0 && _event.dummy_retry<30 && !GameCont.proto
            && instance_exists(_want) && !instance_exists(BanditBoss) && _mus.alarm[1]==-1
            && _mus.music_sound==_voice && audio_is_playing(_voice),
            "Failed Boss spawn incorrectly consumed the event and played Boss victory music");
        scrNTTESmokeLog("PASS DUMMY MUSIC actual living displaced target/native target death/missing spawn-wall retries preserve area voice, no premature victory or consumed ambush @"+string(30/timescale));
    } finally {
        scrNTTEFullMergedRuntimeTestCleanup(_state.before);
        for(var _i=0;_i<array_length(_parked);++_i) instance_activate_object(_parked[_i]);
        scrNTTEBossMusic77End(_state);
    }
}
// Audio must be enabled: verify actual native voices, not only asset selection.
function scrNTTEBossMusic77Begin() {
    scrNTTEFullCuzMusicAudioRequired()
    var _player=instance_find(Player,0),_state=scrNTTEFullMenuStats67Begin()
    _state.enemies=scrNTTEFullInstances(enemy)
    for(var _i=0;_i<array_length(_state.enemies);++_i) instance_deactivate_object(_state.enemies[_i])
    instance_activate_object(_player)
    if(!instance_exists(MusCont)) instance_create(0,0,MusCont)
    GameCont.loops=1 // Keep music requests while omitting the visual intro overlay.
    return _state
}
function scrNTTEBossMusic77End(_state) {
    with(MusCont) {scrNTTEFullMusicCancelIntro();audio_stop_sound(song);audio_stop_sound(amb)}
    scrNTTEFullMergedRuntimeTestCleanup(_state.before)
    for(var _i=0;_i<array_length(_state.enemies);++_i) instance_activate_object(_state.enemies[_i])
    scrNTTEFullMenuStats67End(_state)
}
function scrNTTESealKingMusicTests() {
    var _state=scrNTTEBossMusic77Begin(),_mus=instance_find(MusCont,0)
    try {
        GameCont.area=201;GameCont.subarea=3
        with(_mus) event_perform(ev_alarm,11)
        var _area_voice=_mus.music_sound,_boss=instance_create(68000,68000,NTTEFullPalanking)
        assert(audio_is_playing(_area_voice),"Coast area music must actually play before the boss intro")
        _boss.phase=5;_boss.active=true;_boss.intro_pan=1
        with(_boss) scrNTTEFullPalankingAlarm0()
        assert(_boss.intro && _mus.alarm[2]==1 && GameCont.ntte_full_boss_music_key=="Palanking",
            "Actual Seal King intro did not request its art/music key")
        with(_mus) event_perform(ev_alarm,2)
        assert(_mus.song==scrNTTERefSound("mus.SealKing") && audio_is_playing(_mus.music_sound)
            && !audio_is_playing(_area_voice),"Actual Palanking intro left Coast music playing instead of Seal King")
        var _voice=_mus.music_sound
        repeat(6) with(_mus) event_perform(ev_alarm,2)
        assert(_mus.music_sound==_voice && audio_is_playing(_voice),"Repeated Seal King cue restarted the playing boss voice")
        GameCont.area=205;GameCont.subarea=1
        with(_mus) event_perform(ev_alarm,11)
        assert(_mus.song==scrNTTERefSound("mus.Trench") && !audio_is_playing(_voice)
            && GameCont.ntte_full_boss_music_key=="","Next area failed to leave Seal King music")
        scrNTTESmokeLog("PASS SEAL KING MUSIC actual Palanking phase5 -> MusCont.Alarm2, playing boss voice, repeat request and next-area controls @"+string(30/timescale))
    } finally {scrNTTEBossMusic77End(_state)}
}
function scrNTTEPitSquidMusicPhaseTests() {
    var _state=scrNTTEBossMusic77Begin(),_mus=instance_find(MusCont,0),_player=instance_find(Player,0)
    try {
        GameCont.area=205;GameCont.subarea=3;GameCont.proto=false
        with(_mus) event_perform(ev_alarm,11)
        var _boss=instance_create(_player.x+80,_player.y,NTTEFullPitSquid)
        _boss.ntte_full_timers=[-1,-1,-1,-1]
        with(_boss) event_perform(ev_step,ev_step_normal)
        assert(_boss.ntte_full_can_intro && !_boss.ntte_full_intro && _mus.alarm[2]==1,
            "Actual PitSquid clear-room Step failed to request pre-emergence music")
        with(_mus) event_perform(ev_alarm,2)
        assert(_mus.song==scrNTTERefSound("mus.PitSquidIntroLoop") && audio_is_playing(_mus.music_sound)
            && audio_is_playing(_mus.ntte_full_music_intro),"PitSquid played battle music before its source pre-emergence cue")
        var _pre=_mus.music_sound,_pre_intro=_mus.ntte_full_music_intro
        repeat(6) with(_mus) event_perform(ev_alarm,2)
        assert(_mus.music_sound==_pre && _mus.ntte_full_music_intro==_pre_intro,
            "Repeated pre-emergence requests restarted intro/loop voices")
        audio_stop_sound(_pre_intro)
        with(_mus) scrNTTEFullMusicStep()
        assert(_mus.music_sound==_pre && _mus.ntte_full_music_intro<0 && audio_is_playing(_pre),
            "Pre-emergence intro completion lost its loop")
        _boss.ntte_full_sink=true;_boss.ntte_full_pit_height=0.5
        _boss.x=_boss.ntte_full_x;_boss.y=_boss.ntte_full_y
        with(_boss) scrNTTEFullPitSquidDecision()
        assert(!_boss.ntte_full_sink && _boss.ntte_full_rise_delay==60 && _mus.alarm[2]==1,
            "Actual first-rise decision failed to schedule the source battle transition")
        with(_mus) event_perform(ev_alarm,2)
        assert(_mus.song==scrNTTERefSound("mus.PitSquid") && audio_is_playing(_mus.music_sound)
            && !audio_is_playing(_pre) && !audio_is_playing(_pre_intro),"First-rise delay did not switch once to battle intro/main")
        var _battle=_mus.music_sound,_battle_intro=_mus.ntte_full_music_intro
        _boss.ntte_full_timers=[-1,-1,-1,-1];_boss.ntte_full_rise_delay=0
        _boss.ntte_full_pit_height=0.99
        _boss.ntte_full_bite=1-6.5/sprite_get_number(_boss.ntte_full_bite_sprite)
        with(_boss) event_perform(ev_step,ev_step_normal)
        assert(_boss.ntte_full_intro && _mus.alarm[2]==1,"Actual emergence failed to request the visual boss intro")
        with(_mus) event_perform(ev_alarm,2)
        assert(_mus.music_sound==_battle && _mus.ntte_full_music_intro==_battle_intro,
            "Emergence replayed the already-playing battle intro")
        audio_stop_sound(_battle_intro)
        with(_mus) scrNTTEFullMusicStep()
        repeat(6) with(_mus) event_perform(ev_alarm,2)
        assert(_mus.music_sound==_battle && _mus.ntte_full_music_intro<0 && audio_is_playing(_battle),
            "Battle-loop requests replayed the completed intro")
        // The source can_intro predicate must be evaluated live, including a
        // second boss, rather than inheriting a stale GameCont boolean.
        _boss.ntte_full_intro=false;_boss.ntte_full_can_intro=false
        with(_mus) event_perform(ev_alarm,2)
        assert(_mus.music_sound==_battle,"An unready hidden boss incorrectly restored the pre-emergence track")
        scrNTTESmokeLog("PASS PIT SQUID MUSIC actual clear-room Step/first-rise decision/emergence Step -> native Alarm2, pre-intro/loop and battle-intro/loop, stable real voices @"+string(30/timescale))
    } finally {scrNTTEBossMusic77End(_state)}
}
function scrNTTEGoldenLoadoutPixels77(_surface) {
    var _w=surface_get_width(_surface),_h=surface_get_height(_surface),_out=[],
        _buffer=buffer_create(_w*_h*4,buffer_fixed,1)
    try {
        buffer_get_surface(_buffer,_surface,0)
        for(var _y=_h-64;_y<_h;++_y) for(var _x=_w-100;_x<_w-20;++_x)
            array_push(_out,buffer_peek(_buffer,(_y*_w+_x)*4,buffer_u32))
    } finally {buffer_delete(_buffer)}
    return _out
}
function scrNTTEGoldenLoadoutDisplayTests() {
    var _state=scrNTTEFullMenuStats67Begin(),_menu=noone,_surface=-1,_camera=-1,_target=false,
        _p=my_player,_cwep=_p.cwep,_bwep=_p.bwep,_race=_p.race,
        _draw=scrNTTEFullCoastDrawState(),_cache=variable_global_exists("ntte_full_loadout_weapon_cache")?global.ntte_full_loadout_weapon_cache:undefined,
        _font=draw_get_font(),_halign=draw_get_halign(),_valign=draw_get_valign()
    gpu_push_state()
    try {
        _menu=instance_create(0,0,Menu)
        _menu.loadout_open=false;_menu.loadout_frame=0
        _p.race=Race.Fish;_p.bwep=wep_none;_p.cwep=wep_revolver
        global.ntte_full_loadout_weapon_cache={}
        global.ntte_full_progress.unlocks[$ "wep:trident"]=true
        global.ntte_full_progress.unlocks[$ "pack:red"]=true
        _surface=surface_create(ceil(gui_w),ceil(gui_h))
        assert(surface_exists(_surface),"Golden loadout render surface unavailable")
        _camera=camera_create_view(0,0,gui_w,gui_h,0,noone,-1,-1,-1,-1)
        surface_set_target(_surface);_target=true;camera_apply(_camera)
        matrix_set(matrix_world,matrix_build_identity());shader_reset();gpu_set_blendmode(bm_normal)
        var _weapons=[wep_ntte_golden_trident,wep_ntte_golden_teleport_gun,wep_ntte_golden_tunneller,
            scrNTTEFullWeaponNative(scrNTTEFullWeaponMerge(wep_golden_machinegun,wep_golden_shotgun))]
        for(var _i=0;_i<array_length(_weapons);++_i) {
            scrNTTEFullLoadoutWeaponStore(Race.Fish,_weapons[_i])
            var _stored=scrNTTEFullLoadoutWeaponStored(Race.Fish)
            _p.cwep=wep_revolver
            scr_loadout_race_set_start_weapon(Race.Fish,_stored)
            // The actual collapsed menu must match the native renderer with
            // the correct weapon explicitly supplied as its old primary.
            draw_clear_alpha(c_black,0)
            with(_menu) scrMenuDrawLoadout(_p)
            var _actual=scrNTTEGoldenLoadoutPixels77(_surface)
            _p.cwep=_stored
            draw_clear_alpha(c_black,0)
            with(_menu) scrMenuDrawLoadout(_p)
            var _reference=scrNTTEGoldenLoadoutPixels77(_surface)
            for(var _index=0;_index<array_length(_actual);++_index) {
                    assert(_actual[_index]==_reference[_index],
                        "Collapsed selection still displays the old ordinary weapon for saved golden main "+string(_i))
            }
            surface_save(_surface,"ntte-golden-loadout77-"+string(_i)+"-"+string(30/timescale)+".png")
            // Selecting the native starter must really change the icon back.
            scr_loadout_race_set_start_weapon(Race.Fish,wep_revolver)
            draw_clear_alpha(c_black,0)
            with(_menu) scrMenuDrawLoadout(_p)
            var _different=false,_control=scrNTTEGoldenLoadoutPixels77(_surface)
            for(var _index=0;_index<array_length(_actual);++_index)
                if(_actual[_index]!=_control[_index]) _different=true
            assert(_different,"Golden menu render control did not distinguish the native starter")
        }
        scrNTTESmokeLog("PASS GOLDEN LOADOUT actual saved selection/native collapsed Draw pixel oracle, three NTTE gold modules and golden merge plus starter control @"+string(30/timescale))
    } finally {
        if(_target) surface_reset_target()
        if(_camera>=0) camera_destroy(_camera)
        if(surface_exists(_surface)) surface_free(_surface)
        gpu_pop_state();matrix_set(matrix_world,_draw.world);matrix_set(matrix_view,_draw.view);matrix_set(matrix_projection,_draw.projection)
        if(_draw.shader>=0) shader_set(_draw.shader);else shader_reset()
        draw_set_color(_draw.color);draw_set_alpha(_draw.alpha)
        draw_set_font(_font);draw_set_halign(_halign);draw_set_valign(_valign)
        _p.cwep=_cwep;_p.bwep=_bwep;_p.race=_race
        global.ntte_full_loadout_weapon_cache=_cache
        scrNTTEFullMenuStats67End(_state)
    }
}
function scrNTTEUpdateStartupMenuTests() {
    var _player=instance_find(Player,0),_state=scrNTTEFullMenuStats67Begin(),
        _parked=scrNTTEFullInstances([Menu,MainMenu,MainMenuButton,Logo,ButtonDiscord,ButtonAchievements,PlayButton]),
        _event=ds_map_create(),_updater=UberCont.ntte_update
    for(var _i=0;_i<array_length(_parked);++_i) instance_deactivate_object(_parked[_i])
    try {
        assert(!scrNTTEUpdateCanPrompt(),"No ready menu should allow an update dialog")
        var _logo=instance_create(0,0,Logo)
        assert(!scrNTTEUpdateCanPrompt(),"Startup logo should not allow an update dialog")
        with(_logo) event_perform(ev_alarm,1)
        // Both corner icons inherit MainMenuButton: four entries plus two icons.
        assert(instance_number(MainMenuButton)==6 && !instance_exists(Logo)
            && !instance_exists(Menu) && !instance_exists(Player),"Real Logo.Alarm1 did not construct the native title menu")
        assert(scrNTTEUpdateCanPrompt(),"Real startup main menu blocks automatic update checks and available-version prompts")
        scrNTTEUpdateInit()
        var _s=scrNTTEUpdateState(),_release=scrNTTEUpdateTestRelease()
        _s.request=77001;_s.status="checking";_s.auto_checked=true
        _event[? "id"]=77001;_event[? "status"]=0;_event[? "http_status"]=200
        _event[? "result"]=json_stringify(_release)
        assert(scrNTTEUpdateHttpEvent(_event) && _s.status=="available" && _s.pending_prompt
            && scrNTTEUpdateCanPrompt(),"Available update cannot proceed to prompt on the actual title menu")
        var _options=instance_create(0,0,MenuOptions)
        assert(!scrNTTEUpdateCanPrompt() && _s.pending_prompt,"Options must defer rather than consume a pending update")
        instance_destroy(_options,false)
        assert(scrNTTEUpdateCanPrompt() && _s.pending_prompt,"Returning to title menu must allow the deferred prompt")
        instance_activate_object(_player)
        assert(!scrNTTEUpdateCanPrompt(),"Update dialog interrupted an active player")
        instance_deactivate_object(_player)
        // The existing selection-screen path must continue to work too.
        instance_destroy(MainMenuButton,false)
        var _selection=instance_create(0,0,Menu)
        assert(scrNTTEUpdateCanPrompt(),"Native character selection no longer allows a pending update")
        _options=instance_create(0,0,MenuOptions)
        assert(!scrNTTEUpdateCanPrompt(),"Selection-screen settings allowed an automatic update dialog")
        instance_destroy(_options,false)
        assert(scrNTTEUpdateCanPrompt(),"Closing selection settings lost the pending prompt opportunity")
        scrNTTESmokeLog("PASS UPDATE STARTUP actual Logo.Alarm1 -> four title buttons without Menu, available HTTP callback/deferred settings return, active-player guard and real character selection @"+string(30/timescale))
    } finally {
        UberCont.ntte_update=_updater;ds_map_destroy(_event)
        scrNTTEFullMergedRuntimeTestCleanup(_state.before)
        for(var _i=0;_i<array_length(_parked);++_i) instance_activate_object(_parked[_i])
        scrNTTEFullMenuStats67End(_state)
    }
}

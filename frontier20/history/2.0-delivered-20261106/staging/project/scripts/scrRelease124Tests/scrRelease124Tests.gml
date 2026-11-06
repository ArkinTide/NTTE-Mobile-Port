// Desktop-only regressions for the same mobile rendering/terrain/pet events.
function scrRelease124HUDTests() {
    var _s=scrRelease122FixtureBegin(),_p=instance_find(Player,0),
        _uber=scrNTTEFullAreaGeneratorSnapshot(UberCont),_top=scrNTTEFullAreaGeneratorSnapshot(TopCont),
        _draw=scrNTTEFullCoastDrawState(),_font=draw_get_font(),_ha=draw_get_halign(),_va=draw_get_valign(),
        _viewx=view_xview,_viewy=view_yview,_camera=-1,_a=-1,_b=-1,_target=false,_language=UberCont.opt_language,
        _parked=scrNTTEFullInstances([ButtonAct,ButtonActive,ButtonSwap,JoystickMove,JoystickAttack]);
    for(var _i=0;_i<array_length(_parked);++_i) instance_deactivate_object(_parked[_i]);
    gpu_push_state();
    try {
        scrLanguageSet("Simplified Chinese");
        _p.x=240080;_p.y=240080;_p.visible=true;_p.can_pick=true;_p.race=Race.Rogue;
        KeyCont.touch[_p.index]=true;UberCont.opt_keyboard=false;UberCont.opt_gamepad=false;
        UberCont.opt_hud=true;UberCont.paused=false;UberCont.want_pause=false;UberCont.quit_pause=false;
        view_xview=240000;view_yview=240000;TopCont.drawcontrols=true;
        var _button=instance_create(210,128,ButtonAct),_skill=instance_create(280,150,ButtonActive);
        _button.rad=20;_button.alpha=1;
        var _vine=scrUGCreate(_p.x,_p.y,"FireFlower");
        GameCont.area=area_scrapyards;GameCont.subarea=3;
        assert(scrNTTEFullPromptWinner(_p)==_vine.prompt,"HUD fixture lost Vine selection");
        assert(scrNTTEFullDisplay("VINE")=="藤蔓","Vine translation is not exactly two characters");
        _a=surface_create(320,192);_b=surface_create(320,192);
        _camera=camera_create_view(0,0,320,192,0,noone,-1,-1,-1,-1);
        for(var _pass=0;_pass<2;++_pass) {
            surface_set_target(_pass==0?_a:_b);_target=true;camera_apply(_camera);
            matrix_set(matrix_world,matrix_build_identity());shader_reset();gpu_set_blendmode(bm_normal);
            draw_clear_alpha(c_black,1);draw_set_color(c_white);draw_set_alpha(1);draw_reset_font();draw_align(fa_center,fa_top);
            if(_pass==0) with(TopCont) event_perform(ev_draw,64);
            else scrDrawInteractionHUD(_p);
            surface_reset_target();_target=false;
        }
        surface_save(_a,working_directory+"ntte-release124-hud-actual-"+string(30/timescale)+".png");
        surface_save(_b,working_directory+"ntte-release124-hud-single-"+string(30/timescale)+".png");
        var _different=0;
        // Both the world label and touch label, outside other UI elements.
        for(var _y=38;_y<59;++_y) for(var _x=56;_x<125;++_x)
            if(surface_getpixel(_a,_x,_y)!=surface_getpixel(_b,_x,_y)) _different++;
        for(var _y=84;_y<104;++_y) for(var _x=186;_x<250;++_x)
            if(surface_getpixel(_a,_x,_y)!=surface_getpixel(_b,_x,_y)) _different++;
        scrNTTESmokeLog("R124 HUD different pixels "+string(_different));
        assert(_different==0,"Actual TopCont mobile pipeline duplicated or displaced translated Vine labels");
        scrNTTESmokeLog("PASS Release124 actual native HUD/mobile-controls Vine labels equal one isolated rendering @"+string(30/timescale));
    } finally {
        if(_target) surface_reset_target();if(surface_exists(_a)) surface_free(_a);if(surface_exists(_b)) surface_free(_b);
        if(_camera>=0) camera_destroy(_camera);gpu_pop_state();
        matrix_set(matrix_world,_draw.world);matrix_set(matrix_view,_draw.view);matrix_set(matrix_projection,_draw.projection);
        draw_set_font(_font);draw_align(_ha,_va);view_xview=_viewx;view_yview=_viewy;
        scrLanguageSet(_language);scrNTTEFullAreaGeneratorRestore(_uber);scrNTTEFullAreaGeneratorRestore(_top);
        scrRelease122FixtureEnd(_s);
        for(var _i=0;_i<array_length(_parked);++_i) instance_activate_object(_parked[_i]);
    }
}
function scrRelease124TerrainTests() {
    var _s=scrRelease122FixtureBegin(),_list=global.lis_walls_visible,_fixture=ds_list_create();
    global.lis_walls_visible=_fixture;
    try {
        GameCont.area=area_city;GameCont.underwater=false;
        for(var _xx=0;_xx<15;++_xx) for(var _yy=0;_yy<15;++_yy) instance_create(250000+16*_xx,250000+16*_yy,Wall);
        var _steps=[[7,7],[7,6],[6,7],[7,8],[8,7],[6,6],[8,8],[5,7],[7,5],[9,7],[7,9]];
        for(var _i=0;_i<array_length(_steps);++_i) {
            var _x=250000+16*_steps[_i][0],_y=250000+16*_steps[_i][1],_wall=instance_position(_x,_y,Wall);
            if(instance_exists(_wall)) scrWallDestroy(_wall);else instance_create(_x,_y,FloorExplo);
            var _over=[];
            with(Wall) if(x>=250000 && position_meeting(x,y,FloorExplo)) array_push(_over,[real(id),x,y,object_get_name(object_index)]);
            scrNTTESmokeLog("R124 TERRAIN "+string(_i)+" overlap "+json_stringify(_over));
            assert(array_length(_over)==0,"Destroyed terrain retained Wall top over a real blast floor");
        }
        // A real TopTiny reorder temporarily masks its copied older cap.
        // Destroying the owner before the next EndStep must not strand it.
        var _tile=instance_create(250512,250512,TopSmall),_tiny=scrNTTEFullTopTinyCreate(250520,250520);
        with(_tiny) scrNTTEFullTopTinyEndStep();
        var _copies=_tiny.ntte_toptiny_restore;
        assert(array_length(_copies)>0,"TopTiny fixture did not create deferred cap copies");
        instance_destroy(_tiny,false);
        instance_create(250512,250512,FloorExplo);
        for(var _i=0;_i<array_length(_copies);++_i) {
            var _cap=_copies[_i][0];
            if(instance_exists(_cap) && _cap.x==250512 && _cap.y==250512)
                assert(false,"Blast retained an orphan wall cap after TopTiny owner disappeared");
            if(instance_exists(_cap)) assert(_cap.mask_index!=mskNone,"TopTiny owner destruction stranded another cap with disabled collision");
        }
        scrNTTESmokeLog("PASS Release124 sequential native blasts and interrupted TopTiny cap cleanup @"+string(30/timescale));
    } finally {global.lis_walls_visible=_list;ds_list_destroy(_fixture);scrRelease122FixtureEnd(_s);}
}
function scrRelease124VineTests() {
    var _s=scrRelease122FixtureBegin(),_p=instance_find(Player,0);
    try {
        GameCont.area=area_scrapyards;GameCont.subarea=3;
        var _vine=scrUGCreate(251000,251000,"FireFlower");
        assert(_vine.hp==30000 && _vine.max_hp==30000,"3-3 entrance Vine must have30000 HP");
        with(_vine) scrUG_FireFlower_hurt(73,0,0);
        assert(_vine.hp==29927,"Vine must retain real damage, not invulnerability");
        _vine.max_hp=1;_vine.hp=427;
        with(_vine) scrUGFlowerStep();
        assert(_vine.hp==29927 && _vine.max_hp==30000,"Old live entrance did not migrate while retaining damage");
        var _decor=scrUGCreate(252000,252000,"Vine");
        assert(_decor.max_hp==12,"Entrance HP override altered ordinary Undergrowth Vine props");
        scrNTTESmokeLog("PASS Release124 entrance-only30000HP with real damage and unchanged decoration @"+string(30/timescale));
    } finally {scrRelease122FixtureEnd(_s);}
}
function scrRelease124SpiderTests() {
    var _s=scrRelease122FixtureBegin(),_p=instance_find(Player,0),_lock=lockstep_stop;
    // This synchronous event fixture owns a logical tick. Real30/60 scheduling
    // and room transitions are verified separately by SpiderRouteTests.
    lockstep_stop=false;
    try {
        _p.x=253000;_p.y=253000;_p.ntte_pet=[];
        var _pet=scrNTTEFullPetCreate(_p.x,_p.y,"Spider");
        var _cursed_before=scrNTTEFullValue(_pet.stat,"cursed",0);
        assert(scrNTTEFullPetTake(_pet,_p),"Normal Spider adoption failed");
        assert(_pet.curse==0 && _pet.bskin==0,"New Spider was already cursed");
        GameCont.area=area_cursed_caves;
        with(_pet) event_perform(ev_step,ev_step_normal);
        assert(_pet.curse==1 && _pet.bskin==1 && _pet.stat.cursed==_cursed_before+1 && _pet.spr_idle==scrNTTERefSprite("PetSpiderCursedIdle"),
            "Normal Pet.Step did not automatically convert adopted Spider in Cursed Caves");
        repeat(3) with(_pet) event_perform(ev_step,ev_step_normal);
        assert(_pet.stat.cursed==_cursed_before+1,"Repeated Cursed Caves Step repeated conversion/stat");
        var _saved=json_parse(json_stringify(scrNTTEFullPetExport()));
        scrNTTEFullPetImport(_saved);_pet=_p.ntte_pet[0];
        GameCont.area=area_city;with(_pet) event_perform(ev_step,ev_step_normal);
        assert(_pet.curse==1 && _pet.bskin==1 && _pet.spr_idle==scrNTTERefSprite("PetSpiderCursedIdle"),"Cursed Spider lost form after continuation and departure");
        scrNTTESmokeLog("PASS Release124 ordinary Pet.Step automatic cursed conversion/one-time alert+stat/JSON persistence @"+string(30/timescale));
    } finally {lockstep_stop=_lock;scrRelease122FixtureEnd(_s);}
}
// Isolated real scheduled Scrap3-3 -> native Vine/Portal -> Undergrowth ->
// Jungle route. Explicit survival and defeated-enemy prerequisites,30/60Hz.
// The established fixture helper preserves/restores original save bytes/maps.
function scrRelease124SpiderRouteTests() {
    assert(os_type==os_windows && scrNTTEFullSmokeEnabled(),"Undergrowth acceptance requires explicit Windows smoke");
    var _observer=instance_create(0,0,Release124RouteTest);
    with(_observer) {
        restored=false;scratch_files=[];old_global_vars=[];
        old_directory=game_directory;old_progress=global.ntte_full_progress;
        old_ready=variable_global_exists("ntte_full_feature_ready")?global.ntte_full_feature_ready:undefined;
        old_smoke=global.ntte_smoke_active;old_continue=file_exists(savegame_file)?buffer_load(savegame_file):-1;
        old_seed=random_get_seed();old_save_map=UberCont.saveData;old_savedata=ds_map_write(old_save_map);
        old_game_speed=game_get_speed(gamespeed_fps);old_uber=scrNTTEFullAreaGeneratorSnapshot(UberCont);
        fixture_save_map=ds_map_create();ds_map_copy(fixture_save_map,old_save_map);UberCont.saveData=fixture_save_map;
        var _names=variable_struct_get_names(global),_graph={nodes:[]};
        for(var _i=0;_i<array_length(_names);++_i) {
            var _name=_names[_i],_value=variable_global_get(_name);
            array_push(old_global_vars,[_name,_value]);scrNTTEFullAreaSnapshotContainer(_value,_graph);
        }
        old_global_graph={instances:[],containers:_graph.nodes};
        scratch_root=working_directory+"undergrowth-natural-"+string(get_timer())+"/";directory_create(scratch_root);
        rates=[30,60];completed_rates=[];pass_index=0;phase=0;elapsed=0;draw_frames=0;world_ready_draw=-1;
        room_ends=0;room_starts=0;player=noone;flower=noone;portal=noone;
        ingress_contact=false;return_contact=false;shot=0;retreat_seen=false;retreat_ally=noone;collision_target=noone;collision_projectile=noone;
        global.ntte_smoke_active=false;smoke_drivers=scrNTTEFullInstances(NTTESmokeTest);
        with(NTTESmokeTest) instance_deactivate_object(id);
        scrNTTEFullCoastVaultClear();
    }
}
function scrRelease124Await(_phase) {phase=_phase;elapsed=0;world_ready_draw=-1;}
function scrRelease124RouteHop(_area) {
    scrNTTEFullAreaSet(_area,1,0);
    player.x+=384;player.y+=384;player.xprevious=player.x;player.yprevious=player.y;
    portal=instance_create(player.x,player.y,BigPortal);
    assert(portal.sprite_index==sprBigPortalSpawn,"Spider route bypassed native Portal Spawn");
}
function scrRelease124RouteStep() {
    elapsed+=timescale;
    assert(elapsed<2400,"Release124 spider route timeout phase "+string(phase));
    if(phase>0) scrNTTEFullCoastVaultRate();
    if(instance_exists(player)) {
        player.hp=100000;player.max_hp=100000;player.lsthealth=100000;player.nexthurt=current_frame+100000;
        player.can_walk=false;player.can_aim=false;player.speed=0;
    }
    if(phase==0) {
        for(var _i=0;_i<array_length(smoke_drivers);++_i) {
            instance_activate_object(smoke_drivers[_i]);
            if(instance_exists(smoke_drivers[_i])) instance_destroy(smoke_drivers[_i],false);
        }
        smoke_drivers=[];scrNTTEFullCoastVaultClear();
        save_set_value("options","framerate",rates[pass_index]);save_set_value("options","autopause",false);
        save_set_value("options","gamepad",false);save_set_value("options","keyboard",true);
        save_set_value("visual","bossintro",false);save_set_value("visual","freezeframes",false);
        save_set_value("game","tutorial",false);
        game_set_speed(rates[pass_index],gamespeed_fps);scrOptionsUpdate();
        scrRelease124Await(10);return;
    }
    if(phase==10) {
        UberCont.paused=false;UberCont.want_pause=false;UberCont.want_quit_to_menu=false;
        UberCont.daily_run=false;UberCont.weekly_run=false;UberCont.coop=false;UberCont.hardmode=false;
        UberCont.continued_run=false;UberCont.show_leaderboards_menu=false;
        var _case_seed=scrNTTEFullValue(id,"sweep",false)?6123+97*(floor(pass_index/2) mod 3):6123;
        global.is_server=true;global.index=0;global.custom_seed=_case_seed;global.recontinued_times=0;
        global.crownpick=crwn_none;scrGameCustomModeReset();scr_playerinstances_reset_all();
        my_player.race=Race.Fish;my_player.skin=0;
        game_directory=scratch_root+string(pass_index)+"/";directory_create(game_directory);
        for(var _i=0;_i<4;++_i) array_push(scratch_files,game_directory
            +["ntte-full-progress.json","ntte-full-progress.json.bak","ntte-full-progress.json.tmp","NuclearThrone.sav"][_i]);
        global.ntte_full_progress={schema:1,unlocks:{},loadouts:{},stats:{}};global.ntte_full_feature_ready={};
        if(file_exists(savegame_file)) file_delete(savegame_file);
        instance_create(0,0,GameCont);instance_create(0,0,BackCont);instance_create(0,0,MusCont);scrCreatePlayers(0);
        player=instance_find(Player,0);
        GameCont.area=area_caves;GameCont.subarea=1;
        GameCont.loops=0;GameCont.hard=GameCont.area==207?7:8;
        GameCont.proto=false;GameCont.crown=crwn_none;GameCont.skillpoints=0;GameCont.ultrapoints=0;GameCont.rad=-100000;
        GameCont.maxsubarea=3;GameCont.finalsubarea=false;GameCont.can_advance_stage=true;
        GameCont.levseed=_case_seed;GameCont.ntte_full_pending_destination=undefined;
        GameCont.ntte_full_source_seed=scrNTTEFullSourceSeedBuild(_case_seed);GameCont.ntte_full_source_pending_generation=undefined;
        global.rng_state[@RNGStates.Generation]=_case_seed;global.ntte_full_sync_generation=false;
        instance_create(0,0,GenCont);scrRelease124Await(1);return;
    }
    if(phase==1) {
        if(!scrNTTEFullCoastVaultReady() || instance_exists(LevCont)) return;
        nest=noone;with(NTTEFullWallEnemy) if(special) other.nest=id;
        assert(instance_exists(nest),"Real Caves generation omitted special Spider nest");
        nest_target=nest.target;
        scrRelease124Await(2);return;
    }
    if(phase==2) {
        if(elapsed<65) return;
        assert(instance_exists(nest) && instance_exists(nest_target),"Intact Spider nest disappeared on decoration timer");
        var _walls=scrNTTEFullRectInstances(nest_target.bbox_left,nest_target.bbox_top,nest_target.bbox_right-1,nest_target.bbox_bottom-1,Wall);
        assert(array_length(_walls)>0,"Special nest has no genuine wall support");
        for(var _i=0;_i<array_length(_walls);++_i) if(instance_exists(_walls[_i])) scrWallDestroy(_walls[_i]);
        scrRelease124Await(3);return;
    }
    if(phase==3) {
        if(elapsed<15) return;
        var _pets=scrUGMatching(NTTEFullPet,"pet","Spider");
        assert(!instance_exists(nest) && !instance_exists(nest_target) && array_length(_pets)==1 && _pets[0].visible,
            "Real wall collision did not release exactly one visible Spider");
        spider=_pets[0];assert(scrNTTEFullPetTake(spider,player),"Released Spider could not be adopted");
        assert(spider.curse==0 && spider.bskin==0,"Ordinary Caves Spider already cursed");
        scrRelease124RouteHop(area_cursed_caves);scrRelease124Await(4);return;
    }
    if(phase==4 || phase==6) {
        if(instance_exists(portal)) return;
        var _expected=phase==4?area_cursed_caves:area_city,_hops=phase==4?1:2;
        if(room_starts<_hops || room_ends<_hops || !scrNTTEFullCoastVaultReady() || instance_exists(LevCont)) return;
        assert(GameCont.area==_expected && instance_exists(spider),"Native Portal lost Spider/destination");
        scrRelease124Await(phase+1);return;
    }
    if(phase==5) {
        if(elapsed<30) return;
        assert(spider.visible && spider.curse==1 && spider.bskin==1 && spider.stat.cursed==1
            && spider.spr_idle==scrNTTERefSprite("PetSpiderCursedIdle"),
            "Actual scheduled Cursed Caves Pet.Step did not automatically convert persistent Spider");
        if(surface_exists(application_surface)) surface_save(application_surface,
            working_directory+"ntte-release124-cursed-spider-"+string(rates[pass_index])+".png");
        var _saved=json_parse(json_stringify(scrNTTEFullPetExport()));
        scrNTTEFullPetImport(_saved);spider=player.ntte_pet[0];
        assert(spider.curse==1 && spider.bskin==1 && spider.stat.cursed==1,"JSON continuation lost cursed form/stat");
        scrRelease124RouteHop(area_city);scrRelease124Await(6);return;
    }
    if(phase==7) {
        if(elapsed<30) return;
        assert(spider.visible && spider.curse==1 && spider.bskin==1 && spider.stat.cursed==1
            && spider.spr_idle==scrNTTERefSprite("PetSpiderCursedIdle"),"Cursed Spider reverted/lost after departing Cursed Caves");
        // Reproduce the interrupted cap reorder on real scheduled frames in
        // the same City area as the reported snowy-wall screenshot.
        var _tile=instance_create(256000,256000,TopSmall);
        var _tiny=scrNTTEFullTopTinyCreate(256008,256008);
        with(_tiny) scrNTTEFullTopTinyEndStep();
        cap_copies=_tiny.ntte_toptiny_restore;
        instance_destroy(_tiny,false);instance_create(256000,256000,FloorExplo);
        scrRelease124Await(8);return;
    }
    if(phase==8) {
        if(elapsed<8) return;
        with(TopSmall) assert(x!=256000 || y!=256000,"Scheduled destruction retained cap on blasted tile");
        for(var _i=0;_i<array_length(cap_copies);++_i) if(instance_exists(cap_copies[_i][0]))
            assert(cap_copies[_i][0].mask_index!=mskNone,"Scheduled interrupted reorder retained collisionless cap");
        scrNTTESmokeLog("PASS R124 REAL ROUTE Caves nest/65ticks/actual wall blast/release/adopt; native Portal Cursed Caves automatic visible form; JSON; native Portal City preserves curse; interrupted cap scheduled cleanup @"+string(rates[pass_index]));
        array_push(completed_rates,rates[pass_index]);
        if(++pass_index<array_length(rates)) {scrRelease124Await(0);return;}
        scrNTTEFullCoastVaultRestore();
        scrNTTESmokeLog("PASS full internal selected implemented branches x 30/60; not complete MOD coverage");game_end();
    }
}

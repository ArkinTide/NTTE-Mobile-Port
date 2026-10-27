// Isolated real scheduled Scrap3-3 -> native Vine/Portal -> Undergrowth ->
// Jungle route. Explicit survival and defeated-enemy prerequisites,30/60Hz.
// The established fixture helper preserves/restores original save bytes/maps.
function scrRelease123NaturalTests() {
    assert(os_type==os_windows && scrNTTEFullSmokeEnabled(),"Undergrowth acceptance requires explicit Windows smoke");
    var _observer=instance_create(0,0,Release123NaturalTest);
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
        rates=[30,30,30,30,30,30,60,60,60,60,60,60];completed_rates=[];pass_index=0;phase=0;elapsed=0;draw_frames=0;world_ready_draw=-1;
        room_ends=0;room_starts=0;player=noone;flower=noone;portal=noone;
        ingress_contact=false;return_contact=false;shot=0;retreat_seen=false;retreat_ally=noone;collision_target=noone;collision_projectile=noone;
        global.ntte_smoke_active=false;smoke_drivers=scrNTTEFullInstances(NTTESmokeTest);
        with(NTTESmokeTest) instance_deactivate_object(id);
        scrNTTEFullCoastVaultClear();
    }
}
function scrRelease123Capture(_tag) {
    var _rows=[];
    with(hitme) if(!instance_is(id,Player) && (instance_is(id,enemy) || hp==1)) {
        array_push(_rows,{id:real(id),object:object_get_name(object_index),name:scrNTTEFullValue(id,"name",""),
            x:x,y:y,hp:hp,max_hp:max_hp,visible:visible,sprite:sprite_index,mask:mask_index,
            team:team,kind:scrNTTEFullValue(id,"ug_kind",""),callback:is_callable(scrNTTEFullValue(id,"on_step",undefined))});
    }
    scrNTTESmokeLog("R123 "+_tag+" "+json_stringify({area:GameCont.area,loops:GameCont.loops,actors:_rows,
        enemies:scr_check_enemies(),portal:instance_number(Portal),seed:GameCont.levseed,rate:30/timescale,walls:instance_number(Wall),wall_occupants:instance_number(NTTEFullWallEnemy)}));
}
function scrRelease123Await(_phase) {phase=_phase;elapsed=0;world_ready_draw=-1;}
function scrRelease123NaturalStep() {
    try {scrRelease123NaturalBody();}
    catch(_error) {scrRelease123Capture("FAIL "+string(phase));scrNTTEFullCoastVaultRestore();throw _error;}
}
function scrRelease123NaturalBody() {
    elapsed+=timescale;
    assert(elapsed<2400,"Release123 timed out "+string(phase));
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
        scrRelease123Await(10);return;
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
        GameCont.area=scrNTTEFullValue(id,"sweep",false)?207:((pass_index mod 6)<2?207:((pass_index mod 6)<4?area_caves:204));GameCont.subarea=1;
        GameCont.loops=pass_index mod 2;GameCont.hard=GameCont.area==207?7:8;
        GameCont.proto=false;GameCont.crown=crwn_none;GameCont.skillpoints=0;GameCont.ultrapoints=0;GameCont.rad=-100000;
        GameCont.maxsubarea=3;GameCont.finalsubarea=false;GameCont.can_advance_stage=true;
        GameCont.levseed=_case_seed;GameCont.ntte_full_pending_destination=undefined;
        GameCont.ntte_full_source_seed=scrNTTEFullSourceSeedBuild(_case_seed);GameCont.ntte_full_source_pending_generation=undefined;
        global.rng_state[@RNGStates.Generation]=_case_seed;global.ntte_full_sync_generation=false;
        instance_create(0,0,GenCont);scrRelease123Await(1);return;
    }
    if(phase==1) {
        if(!scrNTTEFullCoastVaultReady() || instance_exists(LevCont)) return;
        scrRelease123Capture("generated "+string(pass_index));
        if(GameCont.area==207) {
            with(UGEnemy) assert(name!="" && max_hp>1,"Generation created an unconfigured UGEnemy "+string(id));
            var _species=["Scorpion","Cuz","CoolGuy","Salamander","Parrot","Mimic","Slaughter","Weapon","Guardian"];
            player.ntte_pet_max=12;
            for(var _i=0;_i<array_length(_species);++_i) {
                var _pet=scrNTTEFullPetCreate(player.x,player.y,_species[_i]);
                scrNTTEFullPetTake(_pet,player);
            }
            scrRelease123Await(2);return;
        }
        if(GameCont.area==204) {scrRelease123LairScene();scrRelease123Await(4);return;}
        nest=noone;with(NTTEFullWallEnemy) if(special) other.nest=id;
        scrNTTESmokeLog("R123 NEST "+string([instance_exists(nest),instance_number(NTTEFullWallEnemy)]));
        assert(instance_exists(nest),"Natural Caves omitted special spider nest");
        nest_target=nest.target;
        scrNTTESmokeLog("R123 nest before "+string([nest.x,nest.y,nest_target.sprite_index,nest_target.mask_index,nest_target.bbox_left,nest_target.bbox_top,nest_target.bbox_right,nest_target.bbox_bottom]));
        var _walls=scrNTTEFullRectInstances(nest_target.bbox_left,nest_target.bbox_top,nest_target.bbox_right-1,nest_target.bbox_bottom-1,Wall);
        assert(array_length(_walls)>0,"Special nest does not overlap breakable wall");
        // Actual terrain destruction; let the Runner perform collision events.
        for(var _i=0;_i<array_length(_walls);++_i) if(instance_exists(_walls[_i])) scrWallDestroy(_walls[_i]);
        scrRelease123Await(3);return;
    }
    if(phase==2) {
        if(instance_exists(Portal)) {
            assert(GameCont.area==207,"UG diagnostic advanced before observing its exit");
            var _last=scrNTTEPortalDeathPoint(),_exit=instance_find(Portal,0);
            if(is_struct(_last) && position_meeting(_last.x,_last.y,Floor))
                assert(_exit.x==_last.x && _exit.y==_last.y,"Scheduled exit missed the final hostile death position");
            scrRelease123Capture("after combat "+string(pass_index));
            scrNTTESmokeLog("R123 UG EXIT 1");scrRelease123Await(9);return;
        }
        with(UGEnemy) assert(name!="" && max_hp>1,"Combat created an unconfigured UGEnemy "+string(id));
        if(elapsed<1200 && floor(elapsed) mod 20==0) {
            var _victim=noone;
            with(enemy) if(team!=team_player && hp>0 && !(instance_is(id,UGEnemy) && name=="MillipedeSegment")) _victim=id;
            if(instance_exists(_victim)) with(player) {
                x=_victim.x-24;y=_victim.y;xprevious=x;yprevious=y;
                wep=wep_ug_fossil_cannon;gunangle=0;infammo=100;
                scrNTTEFireAll(wep,true);
            }
        }
        if(elapsed<1800) return;
        scrRelease123Capture("after combat "+string(pass_index));
        assert(instance_exists(Portal),"Natural UG combat did not open its exit");
        scrRelease123Await(9);return;
    }
    if(phase==3) {
        if(elapsed<15) return;
        var _pets=scrUGMatching(NTTEFullPet,"pet","Spider");
        scrNTTESmokeLog("R123 spider result "+string([instance_exists(nest),instance_exists(nest_target),array_length(_pets)]));
        if(instance_exists(nest)) scrNTTESmokeLog("R123 nest after "+string([nest.x,nest.y,nest_target.bbox_left,nest_target.bbox_top,nest_target.bbox_right,nest_target.bbox_bottom,position_meeting(nest.x,nest.y,Floor)]));
        assert(!instance_exists(nest) && !instance_exists(nest_target) && array_length(_pets)==1 && _pets[0].visible,"Natural nest did not release exactly one visible Spider");
        scrRelease123Await(9);return;
    }
    if(phase==4) {
        if(floor(elapsed) mod 30==0) {
            with(NTTECat) if(ntte_cat_active && !scrNTTECatGroundClear(x,y))
                assert(instance_exists(ntte_cat_sit),"Completed Cat movement left the authored floor "+string([x,y]));
        }
        if(elapsed<300) return;
        scrRelease123Capture("lair "+string(pass_index));
        scrRelease123LairScene();
        scrRelease123Await(9);return;
    }
    if(phase==9) {
        array_push(completed_rates,rates[pass_index]);
        if(++pass_index<array_length(rates)) {scrRelease123Await(0);return;}
        scrNTTEFullCoastVaultRestore();
        scrNTTESmokeLog("PASS Release123 actual generated UG Cannon combat+pet roster exits, Caves wall collision Spider release, Lair Cat movement @30/60");
        scrNTTESmokeLog("PASS full internal selected implemented branches x 30/60; not complete MOD coverage");game_end();
    }
}
function scrRelease123LairScene() {
    var _draw=scrNTTEFullCoastDrawState(),_list=global.lis_walls_visible,
        _oldshad=BackCont.shad,_view=[view_xview,view_yview,view_width,view_height],
        _lx=infinity,_ly=infinity,_rx=-infinity,_ry=-infinity;
    with(Floor) {_lx=min(_lx,bbox_left);_ly=min(_ly,bbox_top);_rx=max(_rx,bbox_right);_ry=max(_ry,bbox_bottom);}
    _lx-=48;_ly-=48;
    var _w=ceil(_rx-_lx+48),_h=ceil(_ry-_ly+48),_scene=surface_create(_w,_h),_shadow=surface_create(_w,_h),
        _camera=camera_create_view(_lx,_ly,_w,_h,0,noone,-1,-1,-1,-1),_walls=ds_list_create(),_active=false;
    gpu_push_state();
    try {
        view_xview=_lx;view_yview=_ly;view_width=_w;view_height=_h;
        global.lis_walls_visible=_walls;with(Wall) ds_list_add(_walls,id);BackCont.shad=_shadow;
        camera_apply(_camera);matrix_set(matrix_world,matrix_build_identity());shader_reset();
        gpu_set_fog(false,c_black,0,1);gpu_set_ztestenable(false);gpu_set_zwriteenable(false);
        gpu_set_alphatestenable(false);gpu_set_colorwriteenable(true,true,true,true);gpu_set_texfilter(false);
        gpu_set_blendmode(bm_normal);draw_set_alpha(1);draw_set_color(c_white);
        with(BackCont) scrShadows();
        surface_set_target(_scene);_active=true;camera_apply(_camera);
        draw_clear_alpha(scrAreaGetBackroundColor(GameCont.area),1);
        with(Floor) draw_self();
        with(BackCont) event_perform(ev_draw,0);
        with(Wall) if(visible) draw_self();
        with(SubTopCont) event_perform(ev_draw,0);
        with(NTTECat) scrNTTECatDraw();
        surface_reset_target();_active=false;
        surface_save(_scene,working_directory+"ntte-r123-lair-"+string(pass_index)+".png");
        surface_save(_shadow,working_directory+"ntte-r123-lair-shadow-"+string(pass_index)+".png");
    } finally {
        if(_active) surface_reset_target();
        surface_free(_shadow);surface_free(_scene);camera_destroy(_camera);ds_list_destroy(_walls);
        global.lis_walls_visible=_list;BackCont.shad=_oldshad;
        view_xview=_view[0];view_yview=_view[1];view_width=_view[2];view_height=_view[3];
        gpu_pop_state();matrix_set(matrix_world,_draw.world);matrix_set(matrix_view,_draw.view);matrix_set(matrix_projection,_draw.projection);
        draw_set_color(_draw.color);draw_set_alpha(_draw.alpha);if(_draw.shader>=0) shader_set(_draw.shader);else shader_reset();
    }
}
function scrRelease123PortalTests() {
    var _state=scrNTTEFullVanillaFixtureBegin(),
        _extra=scrNTTEFullInstances([Corpse,Portal,becomenemy,NTTEFullPortalPrevent,RadMaggotChest,CrownGuardian,VaultStatue,CrownPickup,TutCont,BecomeScrapBoss,SitDown,GameOver]),
        _progress=global.ntte_full_progress;
    for(var _i=0;_i<array_length(_extra);++_i) instance_deactivate_object(_extra[_i]);
    global.ntte_full_progress=json_parse(json_stringify(_progress));
    try {
        GameCont.area=area_sewers;GameCont.is_level_ended=false;GameCont.ntte_ally_portal_timer=0;
        with(GameCont) scrNTTEPortalDeathReset();
        for(var _i=0;_i<12;++_i) instance_create(260000+32*_i,260000,Floor);
        var _first=instance_create(260016,260016,Bandit),_last=instance_create(260304,260016,Bandit),
            _firstx=_first.x,_lastx=_last.x,_lasty=_last.y;
        with(_first) {hp=0;instance_destroy();}
        var _oldcorpse=instance_find(Corpse,0);
        with(_last) {hp=0;instance_destroy();}
        var _ally=instance_create(260144,260016,Bandit);_ally.team=team_player;
        with(_ally) {hp=0;instance_destroy();}
        var _lastdeath=scrNTTEPortalDeathPoint();
        assert(is_struct(_lastdeath) && _lastdeath.x==_lastx && _lastdeath.y==_lasty,
            "Last hostile death was overwritten by a friendly death");
        // Reproduce the recovery path that deliberately arms an older corpse.
        with(GameCont) scrNTTEAllyPortalStep();
        var _pending=noone;
        with(Corpse) if(alarm[0]>=0) _pending=id;
        assert(instance_exists(_pending),"Clear recovery did not arm a corpse alarm");
        _pending.x=_firstx;_pending.y=_lasty;
        with(_pending) event_perform(ev_alarm,0);
        var _portal=instance_find(Portal,0);
        assert(instance_exists(_portal) && _portal.x==_lastx && _portal.y==_lasty,
            "Portal used old corpse coordinates rather than final hostile death");
        assert(_pending.x==_firstx,"Portal placement teleported an older visible corpse");
        instance_destroy(_portal,false);

        // Authored forceportal locations keep their own coordinates.
        var _forced=instance_create(260080,260016,Corpse);
        _forced.forceportal=true;
        with(_forced) event_perform(ev_alarm,0);
        _portal=instance_find(Portal,0);
        assert(instance_exists(_portal) && _portal.x==260080 && _portal.y==260016,
            "Last-death placement moved an authored forced portal");
        instance_destroy(_portal,false);
        _forced.y=259999;_forced.sprite_index=sprBanditDead;_forced.mask_index=mskBandit;
        with(_forced) assert(place_meeting(x,y,Floor) && !position_meeting(x,y,Floor),
            "Forced portal edge fixture must overlap the floor only through its original mask");
        with(_forced) event_perform(ev_alarm,0);
        _portal=instance_find(Portal,0);
        assert(instance_exists(_portal) && _portal.x==_forced.x && _portal.y==_forced.y,
            "Last-death change replaced the original forced portal footprint rule");
        instance_destroy(_portal,false);
        with(GameCont) scrNTTEPortalDeathReset();
        assert(is_undefined(scrNTTEPortalDeathPoint()),"Portal death coordinates leaked across reset");
    } finally {
        global.ntte_full_progress=_progress;
        scrNTTEFullVanillaFixtureEnd(_state);
        for(var _i=0;_i<array_length(_extra);++_i) instance_activate_object(_extra[_i]);
    }
    scrNTTESmokeLog("PASS R123 portal actual hostile Destroy, older recovery corpse, ally exclusion, forceportal and reset @"+string(30/timescale));
}

function scrRelease123LairShadowTests() {
    scrNTTEFullPizzaShadow104Tests("lair");
}

function scrRelease123UGSeedsTests() {
    scrRelease123NaturalTests();
    var _observer=instance_find(Release123NaturalTest,0);
    _observer.sweep=true;
}

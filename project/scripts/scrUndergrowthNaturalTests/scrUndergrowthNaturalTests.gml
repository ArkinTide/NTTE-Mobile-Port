// Isolated real scheduled Scrap3-3 -> native Vine/Portal -> Undergrowth ->
// Jungle route. Explicit survival and defeated-enemy prerequisites,30/60Hz.
// The established fixture helper preserves/restores original save bytes/maps.
function scrUGNaturalTests() {
    assert(os_type==os_windows && scrNTTEFullSmokeEnabled(),"Undergrowth acceptance requires explicit Windows smoke");
    var _observer=instance_create(0,0,UGNaturalTest);
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
        ingress_contact=false;return_contact=false;shot=0;collision_target=noone;collision_projectile=noone;
        global.ntte_smoke_active=false;smoke_drivers=scrNTTEFullInstances(NTTESmokeTest);
        with(NTTESmokeTest) instance_deactivate_object(id);
        scrNTTEFullCoastVaultClear();
    }
}
function scrUGNaturalAwait(_phase) {
    phase=_phase;elapsed=0;world_ready_draw=-1;
    scrNTTESmokeLog("UNDERGROWTH phase="+string(phase)+" @"+string(rates[pass_index]));
}
function scrUGNaturalNearPortal(_portal) {
    scrNTTESmokeLog("UG portal "+string([_portal.x,_portal.y,instance_number(Floor),instance_number(Wall),player.mask_index]));
    player.mask_index=mskPlayer;
    for(var _r=48;_r>=16;_r-=16) for(var _a=0;_a<360;_a+=22.5) {
        var _x=_portal.x+lengthdir_x(_r,_a),_y=_portal.y+lengthdir_y(_r,_a);
        player.x=_x;player.y=_y;
        var _safe=false;
        with(player) _safe=place_meeting(x,y,Floor) && !place_meeting(x,y,Wall);
        if(_safe && !collision_line(_x,_y,_portal.x,_portal.y,Wall,false,false)) {
            player.xprevious=_x;player.yprevious=_y;player.mask_index=mskPlayer;return;
        }
    }
    throw "Undergrowth portal has no reachable native attraction path";
}
function scrUGNaturalStep() {
    try {scrUGNaturalBody();}
    catch(_error) {
        scrNTTESmokeLog("UNDERGROWTH failure phase="+string(phase)+" elapsed="+string(elapsed)+" rooms="+string(room_ends)+"/"+string(room_starts));
        scrNTTEFullCoastVaultRestore();throw _error;
    }
}
function scrUGNaturalBody() {
    elapsed+=timescale;
    assert(elapsed<2400,"Undergrowth scheduled route timed out phase="+string(phase));
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
        scrUGNaturalAwait(10);return;
    }
    if(phase==10) {
        UberCont.paused=false;UberCont.want_pause=false;UberCont.want_quit_to_menu=false;
        UberCont.daily_run=false;UberCont.weekly_run=false;UberCont.coop=false;UberCont.hardmode=false;
        UberCont.continued_run=false;UberCont.show_leaderboards_menu=false;
        global.is_server=true;global.index=0;global.custom_seed=6123;global.recontinued_times=0;
        global.crownpick=crwn_none;scrGameCustomModeReset();scr_playerinstances_reset_all();
        my_player.race=Race.Fish;my_player.skin=0;
        game_directory=scratch_root+string(rates[pass_index])+"/";directory_create(game_directory);
        for(var _i=0;_i<4;++_i) array_push(scratch_files,game_directory
            +["ntte-full-progress.json","ntte-full-progress.json.bak","ntte-full-progress.json.tmp","NuclearThrone.sav"][_i]);
        global.ntte_full_progress={schema:1,unlocks:{},loadouts:{},stats:{}};global.ntte_full_feature_ready={};
        if(file_exists(savegame_file)) file_delete(savegame_file);
        instance_create(0,0,GameCont);instance_create(0,0,BackCont);instance_create(0,0,MusCont);scrCreatePlayers(0);
        player=instance_find(Player,0);
        GameCont.area=area_scrapyards;GameCont.subarea=3;GameCont.loops=0;GameCont.hard=7;
        GameCont.proto=false;GameCont.crown=crwn_none;GameCont.skillpoints=0;GameCont.ultrapoints=0;GameCont.rad=-100000;
        GameCont.maxsubarea=3;GameCont.finalsubarea=false;GameCont.can_advance_stage=true;
        GameCont.levseed=6123;GameCont.ntte_full_pending_destination=undefined;
        GameCont.ntte_full_source_seed=scrNTTEFullSourceSeedBuild(6123);GameCont.ntte_full_source_pending_generation=undefined;
        global.rng_state[@RNGStates.Generation]=6123;global.ntte_full_sync_generation=false;
        room_ends=0;room_starts=0;ingress_contact=false;return_contact=false;shot=0;
        instance_create(0,0,GenCont);scrUGNaturalAwait(1);return;
    }
    if(phase==1) {
        if(!scrNTTEFullCoastVaultReady()) return;
        var _flowers=scrUGMatching(UGHitme,"name","FireFlower");
        assert(array_length(_flowers)==1,"Scrapyards3-3 natural generator omitted Vine entry");
        flower=_flowers[0];player.x=flower.x;player.y=flower.y;player.xprevious=player.x;player.yprevious=player.y;
        assert(instance_exists(flower.prompt),"Vine native prompt omitted");
        assert(scrNTTEFullPromptWinner(player)==flower.prompt,"Natural Vine cannot be selected by native pickup input");
        // Explicit one-frame interaction. Let the real Flower.Step and native
        // Portal attraction/contact/room_restart perform the transition.
        KeyCont.press_pick[player.index]=true;
        with(player) scrNTTEFullPromptPlayerStep();
        KeyCont.press_pick[player.index]=false;
        with(flower) scrUGFlowerStep();
        scrUGNaturalAwait(2);return;
    }
    if(phase==2) {
        if(!instance_exists(Portal)) return;
        portal=instance_find(Portal,0);scrUGNaturalNearPortal(portal);
        scrUGNaturalAwait(3);return;
    }
    if(phase==3) {
        if(instance_exists(portal)) {if(portal.close && portal.endgame<100) ingress_contact=true;return;}
        if(room_ends<1 || room_starts<1 || !scrNTTEFullCoastVaultReady()) return;
        assert(ingress_contact && GameCont.area==207 && GameCont.subarea==1,"Native Vine route did not enter Undergrowth");
        assert(instance_number(Floor)>100 && instance_exists(UGEnemy) && instance_exists(UGChest),"Undergrowth scheduled terrain/population/chest missing");
        player=instance_find(Player,0);
        collision_target=scrUGCreate(32000,32000,"PitcherPlant");
        collision_target.on_step=undefined;
        collision_projectile=scrUG_fossil_gun_LavaBomb_create(32000,32000);
        collision_projectile.creator=player;collision_projectile.team=player.team;collision_projectile.speed=0;
        collision_projectile.on_step=undefined;
        scrUGNaturalAwait(4);return;
    }
    if(phase==4) {
        if(elapsed<2) return;
        assert(instance_exists(collision_target) && collision_target.hp<25,"Real scheduled Fossil projectile collision did not damage source hurt callback");
        instance_destroy(collision_target,false);instance_destroy(collision_projectile,false);
        scrUGNaturalAwait(5);return;
    }
    if(phase==5) {
        if(elapsed>=120 && elapsed<120+timescale && surface_exists(application_surface))
            surface_save(application_surface,working_directory+"ntte-undergrowth-scene-"+string(rates[pass_index])+".png");
        // Let the full generated enemy population and shots run for10 seconds
        // on actual events. This is a bounded combat soak, not a campaign run.
        if(elapsed>=shot*30 && shot<10) {
            with(player) {wep=174+(other.shot mod 5);gunangle=random(360);scrNTTEFireAll(wep,true);}
            shot++;
        }
        if(elapsed<300) return;
        with(enemy) if(!instance_is(id,Player)) hp=0;
        scrUGNaturalAwait(6);return;
    }
    if(phase==6) {
        with(enemy) if(!instance_is(id,Player)) hp=0;
        if(!instance_exists(Portal)) return;
        portal=instance_find(Portal,0);scrUGNaturalNearPortal(portal);
        scrUGNaturalAwait(7);return;
    }
    if(phase==7) {
        if(instance_exists(portal)) {if(portal.close && portal.endgame<100) return_contact=true;return;}
        if(room_ends<2 || room_starts<2 || !scrNTTEFullCoastVaultReady()) return;
        assert(return_contact && GameCont.area==area_jungle && GameCont.subarea==1,"Undergrowth actual exit failed to reach Jungle");
        assert(!instance_exists(UGChest),"Undergrowth chest persisted into Jungle");
        scrNTTESmokeLog("UNDERGROWTH native Scrap3-3 Vine/Prompt/Portal, actual Undergrowth map/population, real shot collision,10s combat and Jungle exit OK @"+string(rates[pass_index]));
        array_push(completed_rates,rates[pass_index]);
        if(++pass_index<array_length(rates)) {scrUGNaturalAwait(0);return;}
        assert(array_length(completed_rates)==2,"Undergrowth route omitted30/60");
        scrNTTEFullCoastVaultRestore();
        scrNTTESmokeLog("PASS UndergrowthNaturalTests scheduled30/60 route/collision/combat soak; controlled survival/defeat prerequisites");
        scrNTTESmokeLog("PASS full internal selected implemented branches x 30/60; not complete MOD coverage");game_end();
    }
}

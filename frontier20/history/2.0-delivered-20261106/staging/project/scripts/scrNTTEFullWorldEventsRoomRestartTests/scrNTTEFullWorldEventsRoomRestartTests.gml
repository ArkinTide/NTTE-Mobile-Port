// Dedicated-process acceptance: actual BigPortal collision/animation-end
// room_restart and engine RoomEnd/RoomStart; temporary source bindings only.
function scrNTTEFullWorldEventsRoomRestartClear() {
    var _keep=id
    with(all) if(id!=_keep && object_index!=UberCont && object_index!=Console) instance_destroy(id,false)
}
function scrNTTEFullWorldEventsRoomRestartRestore() {
    if(restored) return;
    restored=true
    scrNTTEFullAreaGeneratorRestore(old_global_graph)
    for(var _i=0;_i<array_length(old_global_vars);++_i)
        variable_global_set(old_global_vars[_i][0],old_global_vars[_i][1])
    scrNTTEFullAreaGeneratorRestore(old_uber)
    UberCont.saveData=old_save_map
    if(ds_exists(fixture_save_map,ds_type_map)) ds_map_destroy(fixture_save_map)
    UberCont.opt_autopause=old_autopause;UberCont.opt_framerate=old_framerate
    game_set_speed(old_game_speed,gamespeed_fps)
    game_directory=old_directory;global.ntte_smoke_active=old_smoke
    if(old_continue>=0) {buffer_save(old_continue,savegame_file);buffer_delete(old_continue)}
    else if(file_exists(savegame_file)) file_delete(savegame_file)
    for(var _i=0;_i<array_length(scratch_files);++_i)
        if(file_exists(scratch_files[_i])) file_delete(scratch_files[_i])
    random_set_seed(old_seed)
}
function scrNTTEFullWorldEventsRoomRestartTests() {
    assert(os_type==os_windows && scrNTTEFullSmokeEnabled(),"World room_restart requires explicit dedicated Windows full smoke")
    var _object=asset_get_index("NTTEFullWorldEventsRoomRestartTest")
    assert(object_exists(_object) && !instance_exists(_object),"World room_restart observer missing/duplicated")
    var _observer=instance_create(0,0,_object)
    with(_observer) {
        restored=false;scratch_files=[];old_global_vars=[]
        old_directory=game_directory;old_smoke=global.ntte_smoke_active
        old_continue=file_exists(savegame_file)?buffer_load(savegame_file):-1
        old_seed=random_get_seed();old_save_map=UberCont.saveData
        old_autopause=UberCont.opt_autopause;old_framerate=UberCont.opt_framerate
        old_game_speed=game_get_speed(gamespeed_fps)
        old_uber=scrNTTEFullAreaGeneratorSnapshot(UberCont)
        var _names=variable_struct_get_names(global),_graph={nodes:[]}
        for(var _i=0;_i<array_length(_names);++_i) {
            var _name=_names[_i],_value=variable_global_get(_name)
            array_push(old_global_vars,[_name,_value]);scrNTTEFullAreaSnapshotContainer(_value,_graph)
        }
        old_global_graph={instances:[],containers:_graph.nodes}
        // Native UberCont.RoomStart re-reads options from saveData. Keep its
        // source of truth fixture-local as well as the live opt fields.
        fixture_save_map=ds_map_create();ds_map_copy(fixture_save_map,old_save_map)
        UberCont.saveData=fixture_save_map
        rates=[30,60];pass_index=0;phase=0;elapsed=0;draw_frames=0;draw_start=0
        room_ends=0;room_starts=0;hops=0;old_actors=[];old_prompts=[];old_tops=[]
        portal=noone;saw_spawn=false;saw_open=false;saw_collision=false;saw_disappear=false
        scratch_root=working_directory+"world-room-restart-"+string(get_timer())+"/"
        directory_create(scratch_root);global.ntte_smoke_active=false
        smoke_drivers=scrNTTEFullInstances(NTTESmokeTest)
        with(NTTESmokeTest) instance_deactivate_object(id)
        scrNTTEFullWorldEventsRoomRestartClear()
    }
}
function scrNTTEFullWorldEventsRoomRestartAwait(_phase) {phase=_phase;elapsed=0;draw_start=draw_frames}
function scrNTTEFullWorldEventsRoomRestartPortalProbe(_stage) {
    var _observer=instance_find(NTTEFullWorldEventsRoomRestartTest,0)
    if(!instance_exists(_observer) || _observer.phase!=4) return;
    if(_observer.portal==id) {
        // Native Spawn can finish after its contact countdown has elapsed.
        // Other7 sets Open and the same frame's Step may set Disappear before
        // the external observer's next Step. Record only actual event states.
        if(sprite_index==sprBigPortalSpawn) _observer.saw_spawn=true
        if(sprite_index==sprBigPortal) _observer.saw_open=true
        if(sprite_index==sprBigPortalDisappear) _observer.saw_disappear=true
        if(string_pos("Collision.Player.after",_stage)>0 && endgame<=30) _observer.saw_collision=true
        if(_stage=="BigPortal.Other7.animation-end.before"
            && sprite_index==sprBigPortalDisappear && instance_exists(Player))
            _observer.portal_native_restart_requested=true
    }
    scrNTTESmokeLog("WORLD REAL PORTAL EVENT "+_stage+" "+json_stringify({
        rate:_observer.rates[_observer.pass_index],hop:_observer.hops+1,
        portal:id,object:object_get_name(object_index),sprite:sprite_get_name(sprite_index),
        frame:image_index,frames:image_number,animation_speed:image_speed,
        countdown:endgame,alarm1:alarm[1],logic_frame:current_frame,
        room_ends:_observer.room_ends,room_starts:_observer.room_starts,
        player_exists:instance_exists(Player),paused:UberCont.paused,want_pause:UberCont.want_pause}))
}
function scrNTTEFullWorldEventsRoomRestartSeed(_area,_subarea,_seed) {
    // Invert native scrRngStatesReset's ordinary-biome formula. This only
    // chooses a reproducible run seed; native RNG reset/generation still runs.
    global.seed=(_seed-_area*80687-_subarea*56041+2147483647) mod 2147483647
    GameCont.ntte_full_source_seed=scrNTTEFullSourceSeedBuild(global.seed)
    GameCont.ntte_full_source_pending_generation=undefined
}
function scrNTTEFullWorldEventsRoomRestartRain(_firepit) {
    var _steam=instance_number(Breath),_rain=instance_create(Player.x,Player.y,RainSplash)
    assert(instance_number(Breath)==_steam+(_firepit?1:0),
        "Actual RainSplash/Create retained stale FirePit steam or failed exactly one new binding")
    if(_firepit) assert(instance_exists(scrNTTEFullWorldEventGet("FirePit"))
        && scrNTTEFullWorldEventGet("FirePit").ntte_firepit_steam_bound,
        "Rain witness has no new generated source FirePit binding")
}
function scrNTTEFullWorldEventsRoomRestartDiag(_label) {
    var _events=scrNTTEFullWorldEventGet(all),_selected=[]
    for(var _i=0;_i<array_length(_events);++_i) {
        var _event=_events[_i]
        array_push(_selected,{name:_event.event_name,id:_event.id,
            generated:_event.ntte_event_generated,cleanup:_event.ntte_event_cleanup_done,
            floors:array_length(_event.floors),steam:scrNTTEFullValue(_event,"ntte_firepit_steam_bound",false)})
    }
    var _source=scrNTTEFullValue(GameCont,"ntte_full_source_seed",undefined)
    scrNTTESmokeLog("WORLD REAL RESTART DIAG "+_label+" "+json_stringify({
        rate:rates[pass_index],runtime_fps:game_get_speed(gamespeed_fps),logic_scale:timescale,
        phase:phase,area:GameCont.area,subarea:GameCont.subarea,
        difficulty:GameCont.hard,loops:GameCont.loops,global_seed:global.seed,
        crime_bounty:GameCont.ntte_crime_bounty,
        player_count:instance_number(Player),player_race:Player.race,
        player_hp:Player.hp,player_weapon:Player.wep,player_back_weapon:Player.bwep,
        native_levseed:GameCont.levseed,native_generation_rng:global.rng_state[RNGStates.Generation],
        source_baseseed:scrNTTEFullValue(_source,"baseseed",-1),
        source_areanum:scrNTTEFullValue(_source,"areanum",-1),
        source_levseed:scrNTTEFullValue(_source,"levseed",-1),
        source_random:scrNTTEFullValue(_source,"random",-1),
        source_pending:scrNTTEFullValue(GameCont,"ntte_full_source_pending_generation",undefined),
        floor_count:instance_number(Floor),wall_count:instance_number(Wall),
        gen_count:instance_number(GenCont),floor_maker_count:instance_number(FloorMaker),
        top_count:instance_number(TopCont),subtop_count:instance_number(SubTopCont),
        back_count:instance_number(BackCont),trap_count:instance_number(NTTEFullTrapSpin),
        selected:_selected}))
}
function scrNTTEFullWorldEventsRoomRestartBeginHop(_area,_subarea,_seed) {
    // NTTE SPIDER RESTART TEST HOOK
    if(scrNTTEFullValue(id,"ntte_pet_spider_restart_test",false)) scrNTTEFullPetSpiderRestartBeforeHop()
    old_actors=scrNTTEFullInstances([NTTEFullWorldEvent,NTTEFullTrapSpin,NTTEFullOriginalTable,GatorSmoke])
    old_prompts=scrNTTEFullInstances(NTTEFullPrompt);old_tops=scrNTTEFullInstances(TopCont)
    // NTTE SPIDER RESTART TEST HOOK
    if(scrNTTEFullValue(id,"ntte_pet_spider_restart_test",false)) old_prompts=scrNTTEFullPetSpiderRestartTransientPrompts(old_prompts)
    old_dark=[]
    for(var _i=0;_i<array_length(old_tops);++_i) array_push(old_dark,old_tops[_i].dark)
    assert(array_length(old_tops)==1,"Real old world has duplicated/missing native TopCont")
    var _before_area=GameCont.area,_before_subarea=GameCont.subarea
    var _pending=scrNTTEFullAreaSet(_area,_subarea,0)
    assert(GameCont.area==_before_area && GameCont.subarea==_before_subarea
        && _pending.area==_area && _pending.subarea==_subarea,
        "Native pending destination changed active biome before room transition")
    target_area=_area;target_subarea=_subarea;target_seed=_seed
    scrNTTEFullWorldEventsRoomRestartSeed(_area,_subarea,_seed)
    // Keep actual shop witnesses outside the real PortalShock trade radius.
    // They must still exist at Disappear, then vanish at engine room disposal.
    with(Player) {x+=512;y+=512;xprevious=x;yprevious=y}
    portal=instance_create(Player.x,Player.y,BigPortal)
    // NTTE SPIDER NATURAL HIDDEN PORTAL TEST HOOK
    if(scrNTTEFullValue(id,"ntte_spider_portal_hidden_test",false)) scrNTTEFullPetSpiderPortalHiddenSetup()
    saw_spawn=portal.sprite_index==sprBigPortalSpawn;saw_open=false;saw_collision=false;saw_disappear=false
    assert(saw_spawn && portal.endgame==100,"Actual BigPortal did not start from native spawn/unentered state")
    portal_diag_last_sprite=-1;portal_diag_last={};portal_missing_logged=false
    portal_native_restart_requested=false;portal_missing_elapsed=0
    hop_ends=room_ends;hop_starts=room_starts
    scrNTTEFullWorldEventsRoomRestartAwait(4)
}
function scrNTTEFullWorldEventsRoomRestartStepBody() {
    elapsed+=timescale
    // NTTE SPIDER RESTART TEST HOOK
    if(phase!=0 && scrNTTEFullValue(id,"ntte_pet_spider_restart_test",false)) scrNTTEFullPetSpiderRestartMonitor()
    assert(elapsed<=3600,"World room_restart state timeout phase="+string(phase))
    if(phase!=0) assert(game_get_speed(gamespeed_fps)==rates[pass_index]
        && abs(timescale-30/rates[pass_index])<0.0001 && !UberCont.opt_autopause
        && UberCont.saveData==fixture_save_map,
        "Native RoomStart reset fixture framerate/logic scale/autopause or saveData identity")
    if(instance_exists(Player)) with(Player) {
        hp=100000;max_hp=100000;lsthealth=100000;nexthurt=current_frame+100000
        speed=0;can_walk=false;can_aim=false
    }
    if(phase==0) {
        // Initial/per-rate sandbox reset only. Neither certified hop uses this
        // helper, explicit RoomEnd, cleanup helpers or old-instance deletion.
        // BigPortal.Other7 activates all instances. Remove the original
        // dedicated-process driver before any measured map exists, so its
        // persistent Create flag cannot resume a second test after restart.
        for(var _i=0;_i<array_length(smoke_drivers);++_i) {
            instance_activate_object(smoke_drivers[_i])
            if(instance_exists(smoke_drivers[_i])) instance_destroy(smoke_drivers[_i],false)
        }
        smoke_drivers=[]
        scrNTTEFullWorldEventsRoomRestartClear()
        if(scrNTTEFullValue(id,"ntte_pet_transient_test",false)) scrNTTEFullPetTransientLifecycleBeginRate()
        // NTTE SPIDER RESTART TEST HOOK
        if(scrNTTEFullValue(id,"ntte_pet_spider_restart_test",false)) scrNTTEFullPetSpiderRestartBeginRate()
        save_set_value("options","autopause",false)
        save_set_value("options","framerate",rates[pass_index])
        UberCont.opt_framerate=rates[pass_index];game_set_speed(rates[pass_index],gamespeed_fps)
        UberCont.opt_autopause=false;UberCont.paused=false;UberCont.want_pause=false
        UberCont.opt_freeze=0;UberCont.opt_bossintro=false
        UberCont.daily_run=false;UberCont.weekly_run=false;UberCont.coop=false;UberCont.hardmode=false
        UberCont.want_quit_to_menu=false;UberCont.show_leaderboards_menu=false
        global.is_server=true;global.index=0;global.custom_seed=0;global.seed=102775
        global.crownpick=crwn_none;global.recontinued_times=0
        scrGameCustomModeReset();scr_playerinstances_reset_all();my_player.race=Race.Fish;my_player.skin=0
        if(file_exists(savegame_file)) file_delete(savegame_file)
        game_directory=scratch_root+string(rates[pass_index])+"/";directory_create(game_directory)
        array_push(scratch_files,game_directory+"ntte-full-progress.json")
        array_push(scratch_files,game_directory+"ntte-full-progress.json.bak")
        array_push(scratch_files,game_directory+"ntte-full-progress.json.tmp")
        array_push(scratch_files,game_directory+"NuclearThrone.sav")
        global.ntte_full_progress={schema:1,unlocks:{},loadouts:{},stats:{}}
        variable_struct_set(global.ntte_full_progress.unlocks,"crown:crime",true)
        variable_struct_set(global.ntte_full_progress.unlocks,"pack:coast",true)
        variable_struct_set(global.ntte_full_progress.unlocks,"pack:trench",true)
        global.ntte_full_feature_ready={};save_set_value("game","tutorial",false)
        global.ntte_full_world_event_hooks={}
        // Certification scope only; does not certify production cold start.
        scrNTTEFullWorldEventsNativeBindings(true);global.ntte_full_world_events_native_bound=true
        instance_create(0,0,GameCont);instance_create(0,0,BackCont);instance_create(0,0,MusCont)
        scrCreatePlayers(0)
        assert(scrNTTEFullWorldEventsReady(),"Room_restart source bindings missing genuine dependencies")
        GameCont.area=area_scrapyards;GameCont.subarea=2;GameCont.loops=0;GameCont.hard=5
        GameCont.maxsubarea=scrAreaGetMaxSubarea(GameCont.area);GameCont.finalsubarea=false
        GameCont.crown=Crown.None;GameCont.gocrib=false;GameCont.ntte_crime_bounty=3
        GameCont.ntte_pet_history=[["Scorpion","mod","petlib",{bskin:0,scorpion_city:0}]];GameCont.popolevel=15;GameCont.heavyheart=0
        GameCont.rad=0;GameCont.skillpoints=0;GameCont.ultrapoints=0;GameCont.level=1
        // Match the known natural combined profile. GatorAmbush text uses a
        // real choose() before RavenArena/FirePit chance rolls, so bounty zero
        // is a different RNG stream even when GenCont starts at the same seed.
        with(Player) {wep=wep_revolver;bwep=wep_none;hp=100000;max_hp=100000
            lsthealth=100000;nexthurt=current_frame+100000;can_walk=false;can_aim=false}
        scrNTTEFullFloorResetStyle();scrNTTEFullFloorResetAlign()
        GameCont.ntte_full_source_seed=scrNTTEFullSourceSeedBuild(102775)
        GameCont.ntte_full_source_pending_generation=undefined;GameCont.levseed=102775
        global.ntte_full_sync_generation=false;global.rng_state[@RNGStates.Generation]=102775
        scrNTTEFullWorldEventsRoomRestartDiag("before initial GenCont Create")
        var _gen=instance_create(0,0,GenCont)
        assert(!_gen.ntte_full_sync_generation,"Room_restart used eager synchronous generation")
        hops=0;room_ends=0;room_starts=0
        scrNTTEFullWorldEventsRoomRestartAwait(1);return;
    }
    if(phase==1) {
        if(instance_exists(GenCont) || instance_exists(FloorMaker)) return;
        scrNTTEFullWorldEventsRoomRestartDiag("initial generation complete")
        assert(GameCont.area==area_scrapyards && GameCont.subarea==2 && GameCont.levseed==102775,
            "Initial Scrap2 did not use actual fixture generation seed102775")
        var _event=scrNTTEFullWorldEventGet("FirePit")
        var _arena=scrNTTEFullWorldEventGet("RavenArena"),_gators=scrNTTEFullWorldEventGet("GatorAmbush")
        assert(instance_exists(_event) && _event.ntte_event_generated
            && instance_exists(_arena) && _arena.ntte_event_generated
            && instance_exists(_gators) && _gators.ntte_event_generated
            && instance_exists(NTTEFullTrapSpin) && instance_number(TopCont)==1 && instance_number(Floor)>20,
            "Actual asynchronous seed102775 omitted natural FirePit/TrapSpin/native world")
        scrNTTEFullWorldEventsRoomRestartRain(true)
        // FirePit has no prompt owner. A real separate source CatChest contact
        // supplies nonpersistent shop owners and persistent cleanup witnesses.
        witness_chest=instance_create(Player.x,Player.y,NTTEFullCatChest)
        scrNTTEFullWorldEventsRoomRestartAwait(2);return;
    }
    if(phase==2) {
        if(instance_exists(witness_chest)) return;
        assert(instance_number(NTTEFullChestShop)==3 && instance_number(NTTEFullPrompt)>=3,
            "Actual native CatChest contact did not create owner/persistent-prompt cleanup witnesses")
        witness_prompts=scrNTTEFullInstances(NTTEFullPrompt)
        for(var _i=0;_i<array_length(witness_prompts);++_i)
            assert(instance_exists(witness_prompts[_i].creator) && !witness_prompts[_i].creator.persistent,
                "Cleanup witness prompt lacks real nonpersistent shop owner")
        scrNTTEFullWorldEventsRoomRestartAwait(3);return;
    }
    if(phase==3) {
        if(draw_frames-draw_start<8) return;
        // NTTE SPIDER RESTART TEST HOOK
        if(scrNTTEFullValue(id,"ntte_pet_spider_restart_test",false) && !spider_initial_ready && !scrNTTEFullPetSpiderRestartInitialStep()) return;
        if(scrNTTEFullValue(id,"ntte_pet_transient_test",false) && !pet_anim_done) {
            scrNTTEFullPetTransientLifecycleAnimateBegin();return;
        }
        scrNTTESmokeLog("WORLD REAL RESTART initial Scrap2 naturalFirePit/TrapSpin/RainSplash steam+CatChest owner prompts/Draw8 @"+string(rates[pass_index]))
        scrNTTEFullWorldEventsRoomRestartBeginHop(area_sewers,2,101013);return;
    }
    if(phase==4) {
        if(instance_exists(portal)) {
            portal_diag_last={id:portal.id,object:object_get_name(portal.object_index),
                sprite:sprite_get_name(portal.sprite_index),frame:portal.image_index,
                frames:portal.image_number,animation_speed:portal.image_speed,
                countdown:portal.endgame,alarm1:portal.alarm[1],
                xx:portal.x,yy:portal.y,player_x:Player.x,player_y:Player.y,
                player_visible:Player.visible,logic_frame:current_frame}
            if(portal_diag_last_sprite!=portal.sprite_index) {
                portal_diag_last_sprite=portal.sprite_index
                scrNTTESmokeLog("WORLD REAL PORTAL STATE @"+string(rates[pass_index])+" hop="+string(hops+1)
                    +" engineRoomEnd/Start="+string(room_ends)+"/"+string(room_starts)+" "+json_stringify(portal_diag_last))
            }
            if(scrNTTEFullValue(id,"ntte_pet_transient_test",false)) scrNTTEFullPetTransientLifecycleLatePortal()
            saw_open=saw_open || portal.sprite_index==sprBigPortal
            saw_collision=saw_collision || portal.endgame<100
            saw_disappear=saw_disappear || portal.sprite_index==sprBigPortalDisappear
            if(hops==0 && portal.sprite_index==sprBigPortalDisappear)
                for(var _i=0;_i<array_length(witness_prompts);++_i)
                    assert(instance_exists(witness_prompts[_i]) && instance_exists(witness_prompts[_i].creator),
                        "Actual shop owner/prompt disappeared before measured engine room disposal")
            return;
        }
        if(!portal_missing_logged) {
        portal_missing_logged=true
        scrNTTESmokeLog("WORLD REAL PORTAL GONE "+json_stringify({rate:rates[pass_index],hop:hops+1,
            spawn:saw_spawn,open:saw_open,contact:saw_collision,disappear:saw_disappear,
            room_ends:room_ends,room_starts:room_starts,hop_ends:hop_ends,hop_starts:hop_starts,
            portal_ref:portal,other_big_portals:instance_number(BigPortal),all_portals:instance_number(Portal),
            last_live:portal_diag_last,native_restart_requested:portal_native_restart_requested,
            paused:UberCont.paused,want_pause:UberCont.want_pause}))
        }
        // room_restart is deferred until the engine finishes its current
        // event/frame. A later object's Step can see the destroyed portal
        // before RoomEnd/Start. Wait briefly only after the actual native
        // animation-end branch requested restart; still require real callbacks.
        if(portal_native_restart_requested && (room_ends==hop_ends || room_starts==hop_starts)) {
            portal_missing_elapsed+=timescale
            assert(portal_missing_elapsed<=4,"Native BigPortal requested restart but actual engine RoomEnd/Start never arrived")
            return;
        }
        assert(saw_spawn && saw_open && saw_collision && saw_disappear,
            "Real BigPortal did not complete native spawn/contact/open/disappear animation chain")
        assert(room_ends==hop_ends+1 && room_starts==hop_starts+1,
            "Missing genuine engine RoomEnd/RoomStart around BigPortal animation-end room_restart")
        assert(GameCont.area==target_area && GameCont.subarea==target_subarea
            && is_undefined(GameCont.ntte_full_pending_destination),
            "Native room restart failed to consume destination through actual GameCont.RoomEnd")
        for(var _i=0;_i<array_length(old_actors);++_i)
            assert(!instance_exists(old_actors[_i]),"Real engine room disposal retained old event/TrapSpin/table/smoke actor")
        for(var _i=0;_i<array_length(old_prompts);++_i)
            assert(!instance_exists(old_prompts[_i]),"Real owner CleanUp orphaned old persistent prompt")
        for(var _i=0;_i<array_length(old_tops);++_i)
            assert(!instance_exists(old_tops[_i]),"Real engine room disposal retained old native TopCont")
        if(scrNTTEFullValue(id,"ntte_pet_transient_test",false)) scrNTTEFullPetTransientLifecycleAfterHop()
        ++hops;scrNTTEFullWorldEventsRoomRestartAwait(5);return;
    }
    if(phase==5) {
        if(instance_exists(GenCont) || instance_exists(FloorMaker)) return;
        scrNTTEFullWorldEventsRoomRestartDiag("post-restart generation complete hop="+string(hops))
        assert(GameCont.levseed==target_seed && instance_number(Floor)>20
            && instance_number(TopCont)==1 && instance_number(SubTopCont)==1 && instance_exists(BackCont),
            "Actual restarted new map lost native seed/terrain/BackCont/TopCont renderer")
        var _selected=scrNTTEFullWorldEventGet(all)
        for(var _i=0;_i<array_length(_selected);++_i)
            assert(_selected[_i].ntte_event_generated,"New native generation left source event ungenerated")
        var _firepit=scrNTTEFullWorldEventGet("FirePit")
        assert(instance_exists(_firepit)==(hops==2),"Different biome/returned Scrap has wrong actual FirePit selection")
        if(hops==1) assert(!instance_exists(NTTEFullTrapSpin),"Old FirePit TrapSpin leaked into Sewer")
        else assert(instance_exists(NTTEFullTrapSpin)
            && instance_exists(scrNTTEFullWorldEventGet("RavenArena"))
            && instance_exists(scrNTTEFullWorldEventGet("GatorAmbush")),
            "Returned natural combined GatorAmbush/RavenArena/FirePit omitted new TrapSpin")
        scrNTTEFullWorldEventsRoomRestartRain(hops==2)
        // Surface indices can be recycled by native TopCont.Create; an index
        // still existing is not proof that the old instance/surface survived.
        var _reused=false
        for(var _i=0;_i<array_length(old_dark);++_i)
            if(old_dark[_i]>=0 && old_dark[_i]==TopCont.dark) _reused=true
        scrNTTESmokeLog("WORLD REAL RESTART hop="+string(hops)+" engineRoomEnd/Start="+string(room_ends)+"/"+string(room_starts)
            +" oldActors/Top/ownerPrompts absent; native map seed="+string(GameCont.levseed)+" surfaceIndexReused="+string(_reused))
        scrNTTEFullWorldEventsRoomRestartAwait(6);return;
    }
    if(phase==7) {scrNTTEFullPetTransientLifecycleAnimateStep();return;}
    if(phase==6) {
        if(draw_frames-draw_start<8) return;
        // NTTE SPIDER RESTART TEST HOOK
        if(scrNTTEFullValue(id,"ntte_pet_spider_restart_test",false)) {
            if(spider_settled_hop!=hops) scrNTTEFullPetSpiderRestartAfterDraws()
            if(hops==2 && !scrNTTEFullPetSpiderRestartEmptyStep()) return;
        }
        scrNTTESmokeLog("WORLD REAL RESTART new biome="+string(GameCont.area)+" Draw8/sourceBindings OK @"+string(rates[pass_index]))
        if(hops==1) {scrNTTEFullWorldEventsRoomRestartBeginHop(area_scrapyards,2,102775);return;}
        assert(hops==2 && room_ends==2 && room_starts==2,"Actual return chain has unexpected restart count")
        scrNTTESmokeLog("PASS WORLD EVENTS REAL ROOM RESTART: naturalFirePit Scrap2 seed102775/Draw8/steam, actual BigPortal engine collision+spawn/open/disappear+Other7 room_restart, native pending Sewer2 destination/newMap Draw8/no stale steam, second true restart returns naturalFirePit+newTrapSpin/steam/Draw8; old event/TrapSpin/nativeTop/ownerPrompt IDs absent; temporaryBindings only, production cold-start uncertified @"+string(rates[pass_index]))
        if(++pass_index<array_length(rates)) {scrNTTEFullWorldEventsRoomRestartAwait(0);return;}
        scrNTTEFullWorldEventsRoomRestartRestore()
        scrNTTESmokeLog("PASS full internal selected implemented branches x 30/60; not complete MOD coverage")
        game_end()
    }
}
function scrNTTEFullWorldEventsRoomRestartStep() {
    try {scrNTTEFullWorldEventsRoomRestartStepBody()}
    catch(_error) {scrNTTEFullWorldEventsRoomRestartRestore();throw _error}
}

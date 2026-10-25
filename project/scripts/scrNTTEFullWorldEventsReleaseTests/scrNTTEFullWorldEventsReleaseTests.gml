function scrNTTEFullWorldEventsReleaseRemove() {
    var _names=["ntte_full_world_event_hooks","ntte_full_world_events_native_bound",
        "ntte_full_palace_shrine_skills","ntte_full_player_alias"]
    for(var _i=0;_i<array_length(_names);++_i) {
        if(variable_struct_exists(global,_names[_i])) variable_struct_remove(global,_names[_i])
        assert(!variable_global_exists(_names[_i]),"Cold source dependency was not actually removed")
    }
}

function scrNTTEFullWorldEventsReleaseBindingsCapture() {
    assert(variable_global_exists("ntte_full_world_event_hooks")
        && variable_global_exists("ntte_full_world_events_native_bound")
        && global.ntte_full_world_events_native_bound,"Actual native initializer did not bind its registry")
    var _registry=global.ntte_full_world_event_hooks,_names=scrNTTEFullWorldEventOrder(),_rows=[]
    assert(is_struct(_registry) && array_length(variable_struct_get_names(_registry))==16,
        "Actual native initializer did not register exactly sixteen source events")
    for(var _i=0;_i<array_length(_names);++_i) {
        var _key=_names[_i],_hooks=variable_struct_get(_registry,_key)
        assert(is_struct(_hooks) && is_callable(_hooks.create),"Cold source registry lacks a real event provider")
        array_push(_rows,[_key,_hooks,_hooks.create,_hooks.setup,_hooks.step,_hooks.cleanup,_hooks.complete])
    }
    return {registry:_registry,rows:_rows,alias:global.ntte_full_player_alias,skills:global.ntte_full_palace_shrine_skills}
}

function scrNTTEFullWorldEventsReleaseBindingsSame(_snapshot,_where) {
    assert(global.ntte_full_world_event_hooks==_snapshot.registry
        && global.ntte_full_world_events_native_bound
        && array_length(variable_struct_get_names(global.ntte_full_world_event_hooks))==16
        && global.ntte_full_player_alias==_snapshot.alias
        && global.ntte_full_palace_shrine_skills==_snapshot.skills,
        "Native existing registry/bound/dependency identity changed at "+_where)
    for(var _i=0;_i<array_length(_snapshot.rows);++_i) {
        var _row=_snapshot.rows[_i],_hooks=variable_struct_get(global.ntte_full_world_event_hooks,_row[0])
        assert(_hooks==_row[1] && _hooks.create==_row[2] && _hooks.setup==_row[3]
            && _hooks.step==_row[4] && _hooks.cleanup==_row[5] && _hooks.complete==_row[6],
            "Native existing binding was overwritten at "+_where+": "+_row[0])
    }
}

function scrNTTEFullWorldEventsReleaseRestore() {
    if(restored) return;
    var _original_unchanged=ds_map_write(old_save_map)==old_save_bytes
    scrNTTEFullWorldEventsRoomRestartRestore()
    // Restore absence as well as all preexisting global identities/containers.
    var _now=variable_struct_get_names(global)
    for(var _i=0;_i<array_length(_now);++_i) {
        var _found=false
        for(var _j=0;_j<array_length(old_global_vars);++_j)
            if(old_global_vars[_j][0]==_now[_i]) {_found=true;break;}
        if(!_found) variable_struct_remove(global,_now[_i])
    }
    assert(scrNTTEFullWorldEventsNativeCertified(),"Ordinary release certificate did not survive acceptance restoration")
    var _owned=["ntte_full_world_event_hooks","ntte_full_world_events_native_bound",
        "ntte_full_palace_shrine_skills","ntte_full_player_alias","ntte_full_progress"]
    for(var _i=0;_i<array_length(_owned);++_i) {
        var _found=false
        for(var _j=0;_j<array_length(old_global_vars);++_j) if(old_global_vars[_j][0]==_owned[_i]) {
            _found=true
            assert(variable_global_get(_owned[_i])==old_global_vars[_j][1],
                "Cold acceptance failed original global registry/binding/progress identity restoration")
            break;
        }
        if(!_found) assert(!variable_global_exists(_owned[_i]),"Cold acceptance failed original missing-global restoration")
    }
    assert(_original_unchanged && UberCont.saveData==old_save_map
        && ds_map_write(old_save_map)==old_save_bytes,"Cold acceptance mutated original native options/save map")
}

function scrNTTEFullWorldEventsReleaseBeforeCreate() {
    assert(game_get_speed(gamespeed_fps)==rates[pass_index] && timescale==30/rates[pass_index],"Ordinary cold timing did not settle")
    assert(instance_number(NTTEFullWorldEventsColdProductionTest)==0,"Ordinary release has a certificate-control observer")
    assert(scrNTTEFullWorldEventsNativeCertified(),"Ordinary production certificate is closed")
    scrNTTEFullWorldEventsReleaseRemove()
    assert(!variable_global_exists("ntte_full_world_event_hooks") && !variable_global_exists("ntte_full_world_events_native_bound"),"Ordinary release prebound callbacks")
}
function scrNTTEFullWorldEventsReleaseAfterCreate(_gen) {
    binding_snapshot=scrNTTEFullWorldEventsReleaseBindingsCapture()
    for(var _i=0;_i<array_length(binding_snapshot.rows);++_i)
        assert(binding_snapshot.rows[_i][6]==true,"Ordinary constructor left incomplete provider")
    assert(scrNTTEFullWorldEventsNativeCertified() && scrNTTEFullWorldEventsReady() && scrNTTEFullValue(_gen,"ntte_full_events_setup",false),"Ordinary cold setup missing")
    scrNTTESmokeLog("WORLD RELEASE actual cold constructor initialized16 real complete providers @"+string(game_get_speed(gamespeed_fps)))
}
function scrNTTEFullWorldEventsReleaseStep() {
    try {
        assert(instance_number(NTTEFullWorldEventsColdProductionTest)==0 && scrNTTEFullWorldEventsNativeCertified(),"Ordinary certificate boundary changed")
        if(phase>0) scrNTTEFullWorldEventsReleaseBindingsSame(binding_snapshot,"ordinary world/portal frame")
        assert(ds_map_write(old_save_map)==old_save_bytes,"Ordinary acceptance changed original options map")
        scrNTTEFullWorldEventsReleaseStepBody()
    } catch(_error) {scrNTTEFullWorldEventsReleaseRestore();throw _error}
}

function scrNTTEFullWorldEventsReleaseTests() {
    assert(os_type==os_windows && scrNTTEFullSmokeEnabled(),"World room_restart requires explicit dedicated Windows full smoke")
    var _object=asset_get_index("NTTEFullWorldEventsReleaseTest")
    assert(object_exists(_object) && !instance_exists(_object),"World room_restart observer missing/duplicated")
    var _observer=instance_create(0,0,_object)
    with(_observer) {
        restored=false;scratch_files=[];old_global_vars=[];release_rate_applied=-1;binding_snapshot=undefined
        old_directory=game_directory;old_smoke=global.ntte_smoke_active
        old_continue=file_exists(savegame_file)?buffer_load(savegame_file):-1
        old_seed=random_get_seed();old_save_map=UberCont.saveData;old_save_bytes=ds_map_write(old_save_map)
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
        scratch_root=working_directory+"world-release-"+string(get_timer())+"/"
        directory_create(scratch_root);global.ntte_smoke_active=false
        smoke_drivers=scrNTTEFullInstances(NTTESmokeTest)
        with(NTTESmokeTest) instance_deactivate_object(id)
        scrNTTEFullWorldEventsRoomRestartClear()
    }
}

function scrNTTEFullWorldEventsReleaseStepBody() {
    elapsed+=timescale
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
        if(release_rate_applied!=rates[pass_index]) {
            save_set_value("options","autopause",false);save_set_value("options","framerate",rates[pass_index]);
            game_set_speed(rates[pass_index],gamespeed_fps);scrOptionsUpdate();release_rate_applied=rates[pass_index];return;
        }
        assert(game_get_speed(gamespeed_fps)==rates[pass_index] && timescale==30/rates[pass_index],"Ordinary cold timing did not settle");
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
        // Cold native GenCont alone initializes the real registry.
        instance_create(0,0,GameCont);instance_create(0,0,BackCont);instance_create(0,0,MusCont)
        scrCreatePlayers(0)
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
        scrNTTEFullWorldEventsReleaseBeforeCreate()
        var _gen=instance_create(0,0,GenCont)
        scrNTTEFullWorldEventsReleaseAfterCreate(_gen)
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
        scrNTTESmokeLog("WORLD REAL RESTART new biome="+string(GameCont.area)+" Draw8/sourceBindings OK @"+string(rates[pass_index]))
        if(hops==1) {scrNTTEFullWorldEventsRoomRestartBeginHop(area_scrapyards,2,102775);return;}
        assert(hops==2 && room_ends==2 && room_starts==2,"Actual return chain has unexpected restart count")
        scrNTTESmokeLog("PASS WORLD EVENTS ORDINARY RELEASE COLD ROOM RESTART: naturalFirePit Scrap2 seed102775/Draw8/steam, actual BigPortal engine collision+spawn/open/disappear+Other7 room_restart, native pending Sewer2 destination/newMap Draw8/no stale steam, second true restart returns naturalFirePit+newTrapSpin/steam/Draw8; old event/TrapSpin/nativeTop/ownerPrompt IDs absent; ordinary release certificate and cold production Init/Bindings; no legacy control observer @"+string(rates[pass_index]))
        if(++pass_index<array_length(rates)) {scrNTTEFullWorldEventsRoomRestartAwait(0);return;}
        scrNTTEFullWorldEventsReleaseRestore()
        scrNTTESmokeLog("PASS full internal selected implemented branches x 30/60; not complete MOD coverage")
        game_end()
    }
}

// Dedicated desktop process: source unlock -> native vault/contact/choice ->
// actual campfire lifecycle -> native Draw hitboxes/Go/restart -> binary
// continuation via real room_restart and engine-delivered Player.RoomStart.
// Loops and destination contexts are controlled prerequisites, not a claim of
// playing the entire intervening campaign. Production feature gates stay shut.
function scrNTTEFullCrownNaturalClear(_keep_run=false) {
    var _keep=id,_run=_keep_run
    with(all) if(id!=_keep && object_index!=UberCont && object_index!=Console
        && !(_run && (object_index==GameCont || instance_is(id,Player) || object_index==CrownObject))) instance_destroy(id,false)
}
function scrNTTEFullCrownNaturalProgressDiagnostic(_where) {
    // Read-only evidence before any failure teardown changes directories or
    // restores the original progress. Never call a save/load/award here.
    try {
        var _paths=[game_directory+"ntte-full-progress.json",
            scrNTTEFullProgressPath("ntte-full-progress.json"),
            working_directory+"ntte-full-progress.json"],_expected="",_files=[]
        if(variable_instance_exists(id,"scratch_root") && variable_instance_exists(id,"pass_index")) {
            _expected=scratch_root+string(rates[pass_index])+"/ntte-full-progress.json"
            array_push(_paths,_expected)
        }
        if(variable_instance_exists(id,"old_directory")) array_push(_paths,old_directory+"ntte-full-progress.json")
        for(var _i=0;_i<array_length(_paths);++_i) {
            var _path=_paths[_i]
            array_push(_files,{path:_path,parent_exists:directory_exists(filename_path(_path)),
                primary:file_exists(_path),temporary:file_exists(_path+".tmp"),backup:file_exists(_path+".bak")})
        }
        var _memory=variable_global_exists("ntte_full_progress")?global.ntte_full_progress:undefined,
            _game=instance_exists(GameCont)?{id:string(GameCont.id),
                area:scrNTTEFullValue(GameCont,"area"),subarea:scrNTTEFullValue(GameCont,"subarea"),
                loops:scrNTTEFullValue(GameCont,"loops"),crown:scrNTTEFullValue(GameCont,"crown"),
                crownpoints:scrNTTEFullValue(GameCont,"crownpoints")}:undefined,
            _state={where:_where,phase:scrNTTEFullValue(id,"phase"),elapsed:scrNTTEFullValue(id,"elapsed"),
                pass_index:scrNTTEFullValue(id,"pass_index"),crown_index:scrNTTEFullValue(id,"crown_index"),
                current_crown:scrNTTEFullValue(id,"current_crown"),current_key:scrNTTEFullValue(id,"current_key"),
                game_directory:game_directory,working_directory:working_directory,expected_path:_expected,
                path_parts:{bare_parent:filename_path("ntte-full-progress.json"),
                    empty_parent:filename_path(""),global_directory:variable_global_get("game_directory"),
                    self_has_directory:variable_instance_exists(id,"game_directory")},
                scratch_root:scrNTTEFullValue(id,"scratch_root"),old_directory:scrNTTEFullValue(id,"old_directory"),
                files:_files,binary_path:savegame_file,binary_exists:file_exists(savegame_file),
                progress_is_struct:is_struct(_memory),schema:scrNTTEFullValue(_memory,"schema"),
                unlocks:scrNTTEFullValue(_memory,"unlocks"),loadouts:scrNTTEFullValue(_memory,"loadouts"),
                stats:scrNTTEFullValue(_memory,"stats"),game:_game,
                generators:instance_number(GenCont),floor_makers:instance_number(FloorMaker),
                draw_frames:scrNTTEFullValue(id,"draw_frames"),room_ends:scrNTTEFullValue(id,"room_ends"),
                room_starts:scrNTTEFullValue(id,"room_starts"),restored:scrNTTEFullValue(id,"restored")}
        scrNTTESmokeLog("CROWN PROGRESS DIAGNOSTIC "+json_stringify(_state))
    }
    catch(_diagnostic_error) {
        // A diagnostic must never replace the original assertion/exception.
        show_debug_message("CROWN PROGRESS DIAGNOSTIC unavailable: "+string(_diagnostic_error))
    }
}
function scrNTTEFullCrownNaturalRead() {
    var _path=game_directory+"ntte-full-progress.json"
    scrNTTEFullCrownNaturalProgressDiagnostic("Read.before")
    assert(file_exists(_path),"Native crown chain did not write actual source progress JSON")
    var _f=file_text_open_read(_path),_text=""
    while(!file_text_eof(_f)) {_text+=file_text_read_string(_f);file_text_readln(_f)}
    file_text_close(_f);return json_parse(_text)
}
function scrNTTEFullCrownNaturalRestore() {
    if(restored) return;
    restored=true;want_pointer=false
    var _unchanged=ds_map_write(old_save_map)==old_savedata
    // Dedicated-process teardown must run while fixture data still owns all
    // actor cleanup, before restoring the original options map and progress.
    scrNTTEFullCrownNaturalClear()
    scrNTTEFullAreaGeneratorRestore(old_global_graph)
    for(var _i=0;_i<array_length(old_global_vars);++_i)
        variable_global_set(old_global_vars[_i][0],old_global_vars[_i][1])
    scrNTTEFullAreaGeneratorRestore(old_uber)
    UberCont.saveData=old_save_map
    if(ds_exists(fixture_save_map,ds_type_map)) ds_map_destroy(fixture_save_map)
    game_set_speed(old_game_speed,gamespeed_fps)
    game_directory=old_directory;global.ntte_full_progress=old_progress
    global.ntte_full_feature_ready=old_ready;global.ntte_smoke_active=old_smoke
    if(old_continue>=0) {buffer_save(old_continue,savegame_file);buffer_delete(old_continue)}
    else if(file_exists(savegame_file)) file_delete(savegame_file)
    for(var _i=0;_i<array_length(scratch_files);++_i)
        if(file_exists(scratch_files[_i])) file_delete(scratch_files[_i])
    random_set_seed(old_seed)
    assert(_unchanged && ds_map_write(old_save_map)==old_savedata,
        "Crown fixture or private teardown altered original options/save map")
    // UberCont.RoomEnd writes fullscreen/time before its dont_save gate.
    // This dedicated process ends after restoring original map bytes/pointer.
    instance_deactivate_object(UberCont)
}
function scrNTTEFullCrownNaturalMenuTests() {
    assert(os_type==os_windows && scrNTTEFullSmokeEnabled(),"Crown natural acceptance requires explicit Windows full smoke")
    var _object=asset_get_index("NTTEFullCrownNaturalMenuTest")
    assert(object_exists(_object) && !instance_exists(_object),"Crown natural observer missing/duplicated")
    var _observer=instance_create(0,0,_object)
    with(_observer) {
        restored=false;scratch_files=[];old_global_vars=[]
        old_directory=game_directory;old_progress=global.ntte_full_progress
        old_ready=variable_global_exists("ntte_full_feature_ready")?global.ntte_full_feature_ready:undefined
        old_smoke=global.ntte_smoke_active;old_continue=file_exists(savegame_file)?buffer_load(savegame_file):-1
        old_seed=random_get_seed();old_save_map=UberCont.saveData;old_savedata=ds_map_write(old_save_map)
        old_game_speed=game_get_speed(gamespeed_fps);old_uber=scrNTTEFullAreaGeneratorSnapshot(UberCont)
        fixture_save_map=ds_map_create();ds_map_copy(fixture_save_map,old_save_map);UberCont.saveData=fixture_save_map
        var _names=variable_struct_get_names(global),_graph={nodes:[]}
        for(var _i=0;_i<array_length(_names);++_i) {
            var _name=_names[_i],_value=variable_global_get(_name)
            array_push(old_global_vars,[_name,_value]);scrNTTEFullAreaSnapshotContainer(_value,_graph)
        }
        old_global_graph={instances:[],containers:_graph.nodes}
        rates=[30,60];pass_index=0;crown_index=0;crowns=[14,15,16]
        phase=0;elapsed=0;draw_frames=0;draw_start=0;anchor_x=10016;anchor_y=10016
        room_ends=0;room_starts=0;want_pointer=false;pointer_injections=0;injected_phase=-1;menu=noone
        scratch_root=working_directory+"crown-natural-"+string(get_timer())+"/";directory_create(scratch_root)
        global.ntte_smoke_active=false
        with(NTTESmokeTest) instance_deactivate_object(id)
        scrNTTEFullCrownNaturalClear()
    }
}
function scrNTTEFullCrownNaturalAwait(_phase) {
    scrNTTEFullCrownNaturalProgressDiagnostic("Await "+string(phase)+"->"+string(_phase))
    phase=_phase;elapsed=0;draw_start=draw_frames;world_ready_draw=-1;want_pointer=false
}
function scrNTTEFullCrownNaturalMenuAfterSample(_pinst) {
    if(os_type!=os_windows || !scrNTTEFullSmokeEnabled()) return undefined;
    var _observer=instance_find(NTTEFullCrownNaturalMenuTest,0)
    if(!instance_exists(_observer) || !_observer.want_pointer || id!=_observer.menu
        || (_observer.phase!=20 && _observer.phase!=21)
        || _pinst.get_index()!=0 || _pinst.get_race()!=Race.Fish) return undefined;
    _observer.want_pointer=false;_observer.pointer_injections++;_observer.injected_phase=_observer.phase
    // Replace only this real Draw callback's sampled local pointer/press.
    // Native circle/arrow hitboxes and their original setter calls still run.
    return {x:_observer.pointer_x,y:_observer.pointer_y,press:true}
}
function scrNTTEFullCrownNaturalPointer(_crown) {
    var _w=gui_w,_h=gui_h
    if(!_crown) {
        pointer_x=_w+2-16;pointer_y=_h-LETTERBOX_SIZE+2-16
    }
    else {
        assert(menu.loadout_frame>=3,"Crown pointer requires fully opened native loadout layout")
        var _slots=scrNTTEFullCrownLoadoutSlots(),_size=sprite_get_height(sprLoadoutCrown)-4,
            _top=LETTERBOX_SIZE*2,_right=_w+12,
            _per_column=max(1,(_h-_top*2) div _size),
            _left=_right-(array_length(_slots) div _per_column)*_size,
            _x=_right-_size*3,_y=_top-24,_found=false,
            _owned=scr_loadout_race_get_unlocked_crowns_count(Race.Fish)
        for(var _slot=0;_slot<array_length(_slots);++_slot) {
            var _id=_slots[_slot]
            if(_id==crwn_random && !_owned) {_x+=_size;continue;}
            if(_id==current_crown) {pointer_x=_x;pointer_y=_y;_found=true;break;}
            _x+=_size
            if(_x>=_right || _id==crwn_none) {_x=_left;_y+=_size}
        }
        assert(_found,"Naturally earned crown has no actual native menu circle")
    }
    want_pointer=true;injected_phase=-1
}
function scrNTTEFullCrownNaturalWorldReady() {
    if(instance_exists(GenCont) || instance_exists(FloorMaker)) {world_ready_draw=-1;return false;}
    if(world_ready_draw<0) {world_ready_draw=draw_frames;return false;}
    return draw_frames-world_ready_draw>=8
}
function scrNTTEFullCrownNaturalRate(_where) {
    assert(UberCont.saveData==fixture_save_map && ds_map_write(old_save_map)==old_savedata,
        "Crown fixture changed original save map or lost copied map at "+_where)
    assert(game_get_speed(gamespeed_fps)==rates[pass_index] && timescale==30/rates[pass_index]
        && UberCont.opt_framerate==rates[pass_index] && !UberCont.opt_autopause
        && save_get_value("options","framerate",-1)==rates[pass_index]
        && !save_get_value("options","autopause",true),"Crown native boundary replaced actual rate/options: "+_where)
}
function scrNTTEFullCrownNaturalGeneration(_area,_subarea,_loops,_hard,_seed) {
    scrNTTEFullCrownNaturalClear(true)
    instance_create(0,0,BackCont);instance_create(0,0,MusCont)
    GameCont.area=_area;GameCont.subarea=_subarea;GameCont.loops=_loops;GameCont.hard=_hard
    GameCont.maxsubarea=scrAreaGetMaxSubarea(_area);GameCont.finalsubarea=_subarea==GameCont.maxsubarea
    GameCont.levseed=_seed;GameCont.can_advance_stage=false
    GameCont.ntte_full_source_seed=scrNTTEFullSourceSeedBuild(_seed)
    GameCont.ntte_full_source_pending_generation=undefined;GameCont.ntte_full_pending_destination=undefined
    global.rng_state[@RNGStates.Generation]=_seed;global.ntte_full_sync_generation=false
    with(GameCont) event_perform(ev_other,ev_room_start)
    with(UberCont) event_perform(ev_other,ev_room_start)
    var _gen=instance_create(0,0,GenCont)
    assert(!_gen.ntte_full_sync_generation,"Crown case replaced actual async native generation with fixture shortcut")
    anchor_x=10016;anchor_y=10016
    scrNTTEFullCrownNaturalRate("controlled real area bootstrap")
}
function scrNTTEFullCrownNaturalMenu() {
    scrNTTEFullCrownNaturalClear()
    if(file_exists(savegame_file)) file_delete(savegame_file)
    UberCont.want_quit_to_menu=true;instance_create(0,0,Vlambeer)
}
function scrNTTEFullCrownNaturalPhysical(_where) {
    assert(GameCont.crown==current_crown && instance_number(CrownObject)==1,
        "Native earned crown identity/entity missing at "+_where)
    var _crown=instance_find(CrownObject,0)
    assert(_crown.visible && _crown.crown==current_crown
        && _crown.spr_idle==scrNTTEFullCrownSprite(current_crown,"Idle")
        && _crown.spr_walk==scrNTTEFullCrownSprite(current_crown,"Walk")
        && (_crown.sprite_index==_crown.spr_idle || _crown.sprite_index==_crown.spr_walk),
        "Native scheduled custom CrownObject Alarm/Step/Draw lost actual source art at "+_where)
}
function scrNTTEFullCrownNaturalNext() {
    if(++crown_index<array_length(crowns)) {scrNTTEFullCrownNaturalAwait(0);return;}
    crown_index=0
    if(++pass_index<array_length(rates)) {scrNTTEFullCrownNaturalAwait(0);return;}
    scrNTTEFullCrownNaturalRestore()
    scrNTTESmokeLog("PASS full internal selected implemented branches x 30/60; not complete MOD coverage")
    game_end()
}
function scrNTTEFullCrownNaturalStepBody() {
    elapsed+=timescale
    assert(elapsed<=3600,"Crown natural native state timed out crown="+string(crown_index)+" phase="+string(phase))
    if(phase>0) scrNTTEFullCrownNaturalRate("phase "+string(phase))
    if(instance_exists(Player)) with(Player) {
        hp=100000;max_hp=100000;lsthealth=100000;nexthurt=current_frame+100000
        speed=0;can_walk=false;can_aim=false
        if(other.phase!=11 && other.phase!=12 && other.phase!=13 && other.phase!=15) {
            x=other.anchor_x;y=other.anchor_y;xprevious=x;yprevious=y
        }
    }
    if(phase==0) {
        scrNTTEFullCrownNaturalClear()
        save_set_value("options","framerate",rates[pass_index]);save_set_value("options","autopause",false)
        save_set_value("options","keyboard",true);save_set_value("options","gamepad",false)
        save_set_value("visual","bossintro",false);save_set_value("visual","freezeframes",false)
        game_set_speed(rates[pass_index],gamespeed_fps)
        scrOptionsUpdate()
        // Native timescale is refreshed by the next actual frame. Observe
        // that update instead of assigning a synthetic logic rate here.
        scrNTTEFullCrownNaturalAwait(19);return;
    }
    if(phase==19) {
        UberCont.paused=false;UberCont.want_pause=false
        UberCont.daily_run=false;UberCont.weekly_run=false;UberCont.coop=false;UberCont.hardmode=false
        UberCont.want_quit_to_menu=false;UberCont.show_leaderboards_menu=false
        global.is_server=true;global.index=0;global.custom_seed=0;global.seed=701932;global.recontinued_times=0
        global.crownpick=crwn_none;scrGameCustomModeReset();scr_playerinstances_reset_all()
        my_player.race=Race.Fish;my_player.skin=0
        if(crown_index==0) {
            game_directory=scratch_root+string(rates[pass_index])+"/";directory_create(game_directory)
            array_push(scratch_files,game_directory+"ntte-full-progress.json")
            array_push(scratch_files,game_directory+"ntte-full-progress.json.bak")
            array_push(scratch_files,game_directory+"ntte-full-progress.json.tmp")
            array_push(scratch_files,game_directory+"NuclearThrone.sav")
            global.ntte_full_progress={schema:1,unlocks:{},loadouts:{},stats:{}}
            global.ntte_full_feature_ready={}
            for(var _i=0;_i<3;++_i) {
                assert(array_get_index(scrNTTEFullCrownLoadoutSlots(),crowns[_i])<0,
                    "Closed source crown gate exposed menu slot before isolated fixture")
                global.ntte_full_feature_ready[$ "crown:"+scrNTTEFullCrownKey(crowns[_i])]=true
            }
            global.ntte_full_world_event_hooks={};scrNTTEFullWorldEventsNativeBindings(true)
            global.ntte_full_world_events_native_bound=true
        }
        current_crown=crowns[crown_index];current_key=scrNTTEFullCrownKey(current_crown)
        pointer_injections=0
        assert(!scrNTTEFullUnlockGet("loadout:crown:"+current_key)
            && !scr_loadout_race_set_start_crown(Race.Fish,current_crown),"Unowned custom crown accepted native menu setter")
        save_set_value("game","tutorial",false)
        if(current_crown==NTTEFullCrown.Red) {
            assert(scrNTTEFullLoadoutGet("heart:spawn",0)>0,
                "Prior actual Bonus/Crime Campfire failed source next-run heart guarantee prerequisite")
            heart_before=scrNTTEFullLoadoutGet("heart:spawn",0)
            // Actual native Go consumes only the persisted guarantee earned by
            // this case's earlier campfire; no direct heart/ownership grant.
            assert(scr_loadout_race_set_start_crown(Race.Fish,crwn_none),"Native menu reset to no crown failed")
            scrNTTEFullCrownNaturalMenu();scrNTTEFullCrownNaturalAwait(1);return;
        }
        instance_create(0,0,GameCont);instance_create(0,0,BackCont);instance_create(0,0,MusCont);scrCreatePlayers(0)
        GameCont.rad=-100000;GameCont.crownpoints=0;GameCont.skillpoints=0;GameCont.ultrapoints=0
        if(current_crown==NTTEFullCrown.Crime) {
            assert(!scrNTTEFullUnlockGet("crown:crime"),"Crime source acquisition did not start locked")
            scrNTTEFullCrownNaturalGeneration(scrNTTEFullAreaId("pizza"),1,0,5,6123)
            scrNTTEFullCrownNaturalAwait(3);return;
        }
        // Source Bonus has only loops>0 availability, no invented crown:bonus
        // prerequisite. Controlled vault context exercises real pickup route.
        assert(!scrNTTEFullUnlockGet("crown:bonus"),"Bonus fixture invented a source unlock")
        scrNTTEFullCrownNaturalGeneration(area_vault,1,1,5,6124)
        scrNTTEFullCrownNaturalAwait(6);return;
    }
    if(phase==1 || phase==11) {
        if(instance_exists(Logo)) with(Logo) event_perform(ev_alarm,1)
        var _button=noone
        with(MainMenuButton) if(image_index==0) _button=id
        if(!instance_exists(_button)) return;
        with(_button) event_user(0)
        var _play=noone
        with(PlayButton) if(floor(num)==0) _play=id
        if(instance_exists(_play)) with(_play) event_user(0)
        assert(instance_exists(Menu) && instance_exists(MenuGen),"Real MainMenu/Play omitted native crown menu")
        menu=instance_find(Menu,0)
        selector=noone;with(CharSelect) if(race==Race.Fish) other.selector=id
        assert(instance_exists(selector),"Fish missing from actual native menu")
        scrNTTEFullCrownNaturalAwait(phase==1?2:12);return;
    }
    if(phase==2 || phase==12) {
        if(draw_frames-draw_start<8 || instance_exists(FloorMaker)) return;
        assert(selector.can,"Actual CharSelect scheduled Draw rejected Fish")
        assert(my_player.race!=Race.Fish,"Native Play must reset race before actual Fish selection, avoiding a premature run start")
        with(selector) event_perform(ev_mouse,ev_left_press)
        assert(my_player.race==Race.Fish && selector.selected && !instance_exists(Player),
            "Actual CharSelect selection failed or started the run before crown menu selection")
        if(phase==12) {
            assert(array_get_index(scrNTTEFullCrownLoadoutSlots(),current_crown)>=0
                && scr_loadout_race_is_crown_unlocked(Race.Fish,current_crown)
                && GameCont.crown!=current_crown && !menu.loadout_open && menu.loadout_frame==0,
                "Naturally earned crown missing or actual click prerequisite was bypassed")
            scrNTTEFullCrownNaturalAwait(20);scrNTTEFullCrownNaturalPointer(false);return;
        }
        else assert(GameCont.crown==crwn_none && global.crownpick==crwn_none,
            "Native Fish selection failed no-crown saved menu prerequisite for source heart run")
        with(GoButton) event_perform(ev_mouse,ev_left_press)
        assert(instance_number(Player)==1 && Player.race==Race.Fish,"Actual native Go failed genuine Player constructor")
        initial_player=Player.id
        if(phase==2) {
            assert(scrNTTEFullLoadoutGet("heart:spawn",0)==heart_before-1
                && is_struct(GameCont.ntte_heart_spawn),"Actual Go source run-start did not consume earned heart guarantee")
            heart_plan=GameCont.ntte_heart_spawn
            assert(heart_plan.loops==0 && heart_plan.area>=2 && heart_plan.area<=7,
                "Source run-start changed original guaranteed-heart normal area range")
            scrNTTEFullCrownNaturalAwait(4)
        }
        else scrNTTEFullCrownNaturalAwait(13)
        return;
    }
    if(phase==20) {
        if(injected_phase!=20 || menu.loadout_frame<3) return;
        assert(menu.loadout_open && GameCont.crown!=current_crown && pointer_injections==1,
            "Actual native loadout arrow click failed or changed crown before crown-circle input")
        scrNTTEFullCrownNaturalAwait(21);scrNTTEFullCrownNaturalPointer(true);return;
    }
    if(phase==21) {
        if(injected_phase!=21 || draw_frames-draw_start<2) return;
        assert(pointer_injections==2 && menu.loadout_crown_pointed==current_crown
            && GameCont.crown==current_crown && global.crownpick==current_crown
            && scr_loadout_race_get_start_crown(Race.Fish)==current_crown,
            "Actual native earned-crown circle hitbox failed current/saved crown propagation")
        scrNTTEFullCrownNaturalRate("actual arrow and earned-crown circle Draw clicks")
        run_ends=room_ends;run_starts=room_starts
        with(GoButton) event_perform(ev_mouse,ev_left_press)
        assert(instance_number(Player)==1 && Player.race==Race.Fish,
            "Actual native Go after crown click failed genuine Player constructor")
        initial_player=Player.id
        scrNTTEFullCrownNaturalAwait(13);return;
    }
    if(phase==3) {
        if(!scrNTTEFullCrownNaturalWorldReady()) return;
        assert(instance_number(Floor)>20 && instance_number(NTTEFullPizzaTV)==1,"Actual Crime prerequisite Pizza map/render chain missing")
        drain=noone
        with(NTTEFullSewerDrain) if(type=="area" && area==scrNTTEFullAreaId("lair")) other.drain=id
        assert(instance_exists(drain) && !scrNTTEFullUnlockGet("crown:crime"),"Natural source Lair drain absent or Crime unlocked early")
        drain.hp=0;scrNTTEFullCrownNaturalAwait(5);return;
    }
    if(phase==4) {
        if(instance_exists(Menu) || instance_exists(MenuGen) || !scrNTTEFullCrownNaturalWorldReady()) return;
        assert(Player.id==initial_player && is_struct(GameCont.ntte_heart_spawn)
            && !scrNTTEFullUnlockGet("crown:red"),"Actual no-crown new-run consumed guaranteed heart or unlocked Red prematurely")
        GameCont.rad=-100000
        scrNTTEFullCrownNaturalGeneration(heart_plan.area,heart_plan.subarea,heart_plan.loops,5,713251)
        scrNTTEFullCrownNaturalAwait(16);return;
    }
    if(phase==5) {
        if(instance_exists(drain) || !scrNTTEFullCrownNaturalWorldReady()) return;
        assert(GameCont.area==scrNTTEFullAreaId("lair") && scrNTTEFullUnlockGet("crown:crime")
            && GameCont.ntte_full_active_lair,"Actual Lair drain registered death failed source Crime unlock")
        assert(scrNTTEFullCrownNaturalRead().unlocks[$ "crown:crime"],"Actual Crime unlock did not persist")
        scrNTTESmokeLog("CROWN SOURCE Crime: real async Pizza/native Lair drain hp death/in-room Lair/source JSON unlock; controlled vault destination follows")
        // End the acquired source area through the native callback before the
        // controlled vault context. This is an explicit early RoomEnd, not a
        // claim that the separate Lair Cat/Bat/reward campaign was completed.
        GameCont.can_advance_stage=true
        with(GameCont) event_perform(ev_other,ev_room_end)
        assert(!GameCont.ntte_full_active_lair,"Explicit native source RoomEnd left Lair active across vault context")
        GameCont.skillpoints=0
        scrNTTEFullCrownNaturalGeneration(area_vault,1,0,5,6124)
        scrNTTEFullCrownNaturalAwait(6);return;
    }
    if(phase==6) {
        if(!scrNTTEFullCrownNaturalWorldReady()) return;
        assert(GameCont.area==area_vault && instance_number(CrownPickup)==1 && GameCont.crownpoints==0
            && !scrNTTEFullUnlockGet("loadout:crown:"+current_key),"Actual native vault generation failed fresh source crown pickup")
        pickup=instance_find(CrownPickup,0);anchor_x=pickup.x;anchor_y=pickup.y
        GameCont.lastarea=area_desert;GameCont.lastsubarea=1
        scrNTTEFullCrownNaturalAwait(7);return;
    }
    if(phase==7) {
        if(instance_exists(pickup)) return;
        assert(GameCont.crownpoints==1 && GameCont.area==area_desert && GameCont.subarea==1
            && instance_number(CrownObject)==1,"Real CrownPickup collision/Destroy failed point/native crown/revert destination")
        scrNTTEFullCrownNaturalClear(true)
        with(GameCont) event_perform(ev_other,ev_room_start)
        with(UberCont) event_perform(ev_other,ev_room_start)
        instance_create(0,0,Vlambeer)
        assert(instance_exists(LevCont) && instance_number(CrownIcon)>0,"Actual Vlambeer crown point failed native LevCont branch")
        chosen=noone;with(CrownIcon) if(crown==other.current_crown) other.chosen=id
        assert(instance_exists(chosen),"Earned source crown unavailable in native LevCont choices")
        var _bonus=false,_crime=false,_red=false
        with(CrownIcon) {
            if(crown==NTTEFullCrown.Bonus) _bonus=true
            if(crown==NTTEFullCrown.Crime) _crime=true
            if(crown==NTTEFullCrown.Red) _red=true
        }
        assert(_bonus==(GameCont.loops>0) && _crime==(GameCont.loops<=0 && scrNTTEFullUnlockGet("crown:crime"))
            && _red==(GameCont.loops>0 && scrNTTEFullUnlockGet("crown:red")),"Real LevCont choices changed source loop/unlock crown availability")
        scrNTTEFullCrownNaturalAwait(8);return;
    }
    if(phase==8) {
        if(draw_frames-draw_start<8) return;
        with(chosen) event_user(0)
        assert(GameCont.crown==current_crown && GameCont.crownpoints==0 && instance_exists(GenCont)
            && !instance_exists(LevCont),"Actual native CrownIcon choice failed equip/point/submit/next GenCont")
        scrNTTEFullCrownNaturalAwait(9);return;
    }
    if(phase==9) {
        if(!scrNTTEFullCrownNaturalWorldReady()) return;
        scrNTTEFullCrownNaturalPhysical("native selected-crown next world 8Draw")
        assert(!scrNTTEFullUnlockGet("loadout:crown:"+current_key),"Merely selecting crown prematurely awarded permanent source ownership")
        scrNTTEFullCrownNaturalGeneration(area_campfire,1,1,5,713252)
        scrNTTEFullCrownNaturalAwait(10);return;
    }
    if(phase==10) {
        if(!scrNTTEFullCrownNaturalWorldReady()) return;
        assert(GameCont.area==area_campfire && instance_number(Floor)>5
            && scrNTTEFullUnlockGet("loadout:crown:"+current_key)
            && scrNTTEFullCrownNaturalRead().unlocks[$ "loadout:crown:"+current_key],
            "Actual Campfire GenCont canonical callback failed source permanent crown ownership/JSON")
        scrNTTEFullCrownNaturalPhysical("native campfire 8Draw")
        assert(scrNTTEFullLoadoutGet("heart:spawn",0)>0,"Actual source campfire omitted next-run heart guarantee")
        global.ntte_full_progress={schema:1,unlocks:{},loadouts:{},stats:{}}
        assert(!scrNTTEFullUnlockGet("loadout:crown:"+current_key) && scrNTTEFullProgressLoad()
            && scr_loadout_race_is_crown_unlocked(Race.Fish,current_crown),"Source JSON reload lost naturally acquired global crown ownership")
        scrNTTESmokeLog("CROWN NATURAL "+current_key+": actual vault pickup contact/LevCont choices/CrownIcon submit/next-world8Draw/no premature ownership/canonical campfire+JSON reload OK @"+string(rates[pass_index]))
        scrNTTEFullCrownNaturalMenu();scrNTTEFullCrownNaturalAwait(11);return;
    }
    if(phase==13) {
        if(instance_exists(Menu) || instance_exists(MenuGen) || !scrNTTEFullCrownNaturalWorldReady()) return;
        assert(instance_number(Player)==1 && Player.id==initial_player && instance_number(Floor)>20
            && instance_exists(TopCont) && room_ends==run_ends+1 && room_starts==run_starts+1,
            "Actual selected-crown Go/room_restart failed normal world or real engine events")
        scrNTTEFullCrownNaturalPhysical("actual Go room_restart world 8Draw")
        saved_player=Player.id;scrSavegameSave()
        assert(file_exists(savegame_file),"Actual selected-crown new-run omitted binary save")
        scrNTTEFullCrownNaturalClear();UberCont.want_quit_to_menu=false
        continue_ends=room_ends;continue_starts=room_starts
        // The native romGame Vlambeer instance reads binary in its own Create
        // during the real restart. Engine RoomStart then initializes the new
        // Player/CrownObject; this fixture dispatches neither event manually.
        scrNTTEFullCrownNaturalAwait(15);room_restart();return;
    }
    if(phase==15) {
        if(room_ends==continue_ends) return;
        assert(room_ends==continue_ends+1 && room_starts==continue_starts+1,
            "Binary crown continuation omitted exactly one real engine RoomEnd+RoomStart")
        if(!scrNTTEFullCrownNaturalWorldReady()) return;
        assert(instance_number(Player)==1 && Player.id!=saved_player && UberCont.continued_run
            && GameCont.crown==current_crown && GameCont.is_level_continuation
            && instance_number(Floor)>20 && scr_loadout_race_is_crown_unlocked(Race.Fish,current_crown)
            && scr_loadout_race_get_start_crown(Race.Fish)==current_crown,
            "Actual Vlambeer binary continuation lost distinct Player/earned ownership/saved crown menu selection")
        scrNTTEFullCrownNaturalPhysical("actual binary continuation engine Player.RoomStart 8Draw")
        scrNTTESmokeLog("PASS CROWN NATURAL MENU "+current_key+": source acquisition/native vault+LevCont/campfire permanent ownership/JSON/actual scheduled Draw arrow+crown-circle hitboxes/actual Go room_restart/binary romGame Vlambeer new Player continuation+real engine RoomEnd+RoomStart/source physical art8Draw; controlled destination+loops, earlier campaign not covered @"+string(rates[pass_index]))
        if(current_crown==NTTEFullCrown.Crime) {
            // Crime menu/new-run correctly consumed its earlier campfire
            // guarantee. Visit another actual campfire with the continued
            // earned crown to replenish through the source callback only.
            scrNTTEFullCrownNaturalGeneration(area_campfire,1,1,5,713253)
            scrNTTEFullCrownNaturalAwait(18);return;
        }
        scrNTTEFullCrownNaturalNext();return;
    }
    if(phase==16) {
        if(!scrNTTEFullCrownNaturalWorldReady()) return;
        assert(instance_number(NTTEFullCrystalHeart)>=1 && is_undefined(GameCont.ntte_heart_spawn)
            && !scrNTTEFullUnlockGet("crown:red"),"Actual generated normal world failed source earned guarantee/real Heart or unlocked Red early")
        heart=instance_find(NTTEFullCrystalHeart,0);heart.hp=0
        scrNTTEFullCrownNaturalAwait(17);return;
    }
    if(phase==17) {
        if(instance_exists(heart)) return;
        assert(scrNTTEFullUnlockGet("crown:red") && scrNTTEFullCrownNaturalRead().unlocks[$ "crown:red"],
            "Actual native Heart HP death failed original Red unlock and source JSON persistence")
        scrNTTESmokeLog("CROWN SOURCE Red: prior real campfire earned guarantee/actual Go run-start consumes guarantee/controlled chosen normal area async generation/actual Heart hp death/source JSON unlock OK")
        GameCont.skillpoints=0
        scrNTTEFullCrownNaturalGeneration(area_vault,1,1,5,6124)
        scrNTTEFullCrownNaturalAwait(6);return;
    }
    if(phase==18) {
        if(!scrNTTEFullCrownNaturalWorldReady()) return;
        assert(GameCont.area==area_campfire && scrNTTEFullLoadoutGet("heart:spawn",0)>0
            && scrNTTEFullCrownNaturalRead().loadouts[$ "heart:spawn"]>0,
            "Actual second Campfire failed to persist replenished next-run heart guarantee")
        scrNTTEFullCrownNaturalPhysical("continued Crime native campfire replenishment 8Draw")
        scrNTTESmokeLog("CROWN SOURCE preparation: real continued Crime/canonical Campfire replenished actual persisted heart:spawn for Red new-run")
        scrNTTEFullCrownNaturalNext();return;
    }
}
function scrNTTEFullCrownNaturalStep() {
    try {scrNTTEFullCrownNaturalStepBody()}
    catch(_error) {
        scrNTTEFullCrownNaturalProgressDiagnostic("Step.failure.before-restore")
        scrNTTEFullCrownNaturalRestore();throw _error
    }
}

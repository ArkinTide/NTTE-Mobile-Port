// Controlled Palace3 only: native provider/contact/pickup/full binary Continue.
// No Portal exit, hub deposit/revisit, campaign ingress or merged-stack claim.
function scrNTTEFullPalaceArtifactContinueClear() {
    var _keep=id
    with(all) if(id!=_keep && object_index!=UberCont && object_index!=Console) instance_destroy(id,false)
}
function scrNTTEFullPalaceArtifactContinueRestore() {
    if(restored) return;
    restored=true
    if(path_exists(bot_path)) path_delete(bot_path)
    var _unchanged=ds_map_write(old_save_map)==old_savedata
    scrNTTEFullPalaceArtifactContinueClear()
    scrNTTEFullAreaGeneratorRestore(old_global_graph)
    for(var _i=0;_i<array_length(old_global_vars);++_i)
        variable_global_set(old_global_vars[_i][0],old_global_vars[_i][1])
    scrNTTEFullAreaGeneratorRestore(old_uber)
    UberCont.saveData=old_save_map
    if(ds_exists(fixture_save_map,ds_type_map)) ds_map_destroy(fixture_save_map)
    game_set_speed(old_game_speed,gamespeed_fps)
    game_directory=old_directory;global.ntte_smoke_active=old_smoke
    if(old_continue>=0) {buffer_save(old_continue,savegame_file);buffer_delete(old_continue)}
    else if(file_exists(savegame_file)) file_delete(savegame_file)
    for(var _i=0;_i<array_length(scratch_files);++_i)
        if(file_exists(scratch_files[_i])) file_delete(scratch_files[_i])
    random_set_seed(old_seed)
    assert(_unchanged && ds_map_write(old_save_map)==old_savedata,
        "Palace artifact teardown changed original physical options/save map")
    // Dedicated process termination must not deliver another Uber.RoomEnd
    // after its original map and binary bytes have been restored.
    instance_deactivate_object(UberCont)
}
function scrNTTEFullPalaceArtifactContinueAbort(_error) {
    var _o=instance_find(NTTEFullPalaceArtifactContinueTest,0)
    if(instance_exists(_o)) with(_o) {
        scrNTTEFullPalaceArtifactContinueDiagnostic("before strict callback failure: "+_error.message)
        scrNTTEFullPalaceArtifactContinueRestore()
    }
    throw _error
}
function scrNTTEFullPalaceArtifactContinueTests() {
    assert(os_type==os_windows && scrNTTEFullSmokeEnabled(),"Palace artifact Continue requires explicit Windows full smoke")
    assert(!instance_exists(NTTEFullPalaceArtifactContinueTest),"Palace artifact Continue observer duplicated")
    var _observer=instance_create(0,0,NTTEFullPalaceArtifactContinueTest)
    with(_observer) {
        restored=false;scratch_files=[];old_global_vars=[]
        old_directory=game_directory;old_smoke=global.ntte_smoke_active
        old_continue=file_exists(savegame_file)?buffer_load(savegame_file):-1
        old_seed=random_get_seed();old_game_speed=game_get_speed(gamespeed_fps)
        old_save_map=UberCont.saveData;old_savedata=ds_map_write(old_save_map)
        old_uber=scrNTTEFullAreaGeneratorSnapshot(UberCont)
        var _names=variable_struct_get_names(global),_graph={nodes:[]}
        for(var _i=0;_i<array_length(_names);++_i) {
            var _name=_names[_i],_value=variable_global_get(_name)
            array_push(old_global_vars,[_name,_value]);scrNTTEFullAreaSnapshotContainer(_value,_graph)
        }
        old_global_graph={instances:[],containers:_graph.nodes}
        fixture_save_map=ds_map_create();ds_map_copy(fixture_save_map,old_save_map);UberCont.saveData=fixture_save_map
        rates=[30,60];pass_index=0;phase=0;elapsed=0;draw_frames=0;world_ready_draw=-1
        room_ends=0;room_starts=0;player_room_starts=[];gen_creates=0;gen_destroys=0
        provider_records=[];factory_records=[];opened_records=[];load_calls=0;session_imports=0;player_loads=[]
        player=noone;source_chest=noone;source_pickup=noone;source_model=undefined
        initial_player=noone;saved_player=noone;previous_handle=-1;previous_model=undefined
        artifact_handle=-1;native_steps=0;move_samples=0;pick_samples=0;diagnostic_clock=0
        bot_path=path_add();bot_path_clock=0;bot_path_cursor=1;bot_goal_x=10016;bot_goal_y=10016
        scratch_root=working_directory+"palace-artifact-continue-"+string(get_timer())+"/";directory_create(scratch_root)
        smoke_drivers=scrNTTEFullInstances(NTTESmokeTest)
        with(NTTESmokeTest) instance_deactivate_object(id)
        global.ntte_smoke_active=false
        scrNTTEFullPalaceArtifactContinueClear()
    }
}
function scrNTTEFullPalaceArtifactContinueAwait(_next) {
    phase=_next;elapsed=0;world_ready_draw=-1;diagnostic_clock=0;bot_path_clock=0
    scrNTTESmokeLog("PALACE ARTIFACT CONTINUE phase="+string(phase)+" rate="+string(rates[pass_index]))
}
function scrNTTEFullPalaceArtifactContinueWorldReady() {
    if(instance_exists(GenCont) || instance_exists(FloorMaker)) {world_ready_draw=-1;return false;}
    if(world_ready_draw<0) {world_ready_draw=draw_frames;return false;}
    return draw_frames-world_ready_draw>=8
}
function scrNTTEFullPalaceArtifactContinueRate(_where) {
    assert(UberCont.saveData==fixture_save_map && ds_map_write(old_save_map)==old_savedata
        && game_get_speed(gamespeed_fps)==rates[pass_index] && timescale==30/rates[pass_index]
        && UberCont.opt_framerate==rates[pass_index] && !UberCont.opt_autopause
        && save_get_value("options","framerate",-1)==rates[pass_index]
        && !save_get_value("options","autopause",true),"Palace artifact rate/options changed: "+_where)
}
function scrNTTEFullPalaceArtifactContinueDiagnostic(_where) {
    var _p={exists:instance_exists(player)}
    if(instance_exists(player)) _p={id:player,x:player.x,y:player.y,hp:player.hp,max_hp:player.max_hp,
        wep:player.wep,bwep:player.bwep,can_walk:player.can_walk,can_pick:player.can_pick,visible:player.visible}
    scrNTTESmokeLog("PALACE ARTIFACT CONTINUE DIAGNOSTIC "+_where+" "+json_stringify({
        phase:phase,elapsed:elapsed,rate:rates[pass_index],player:_p,gen_creates:gen_creates,gen_destroys:gen_destroys,
        provider:provider_records,factory:factory_records,opened:opened_records,
        room_ends:room_ends,room_starts:room_starts,player_room_starts:player_room_starts,
        load_calls:load_calls,session_imports:session_imports,player_loads:player_loads,
        chest:source_chest,chest_exists:instance_exists(source_chest),pickup:source_pickup,pickup_exists:instance_exists(source_pickup),
        enemies:instance_number(enemy),throne_inactive:instance_number(NothingInactive),throne:instance_number(Nothing),
        portals:instance_number(Portal),move_samples:move_samples,pick_samples:pick_samples,rng:random_get_seed()}))
}
// Read-only hooks: no provider, chest, weapon, save or actor field is written.
function scrNTTEFullPalaceArtifactContinueProvider(_anchor) {
    var _o=instance_find(NTTEFullPalaceArtifactContinueTest,0)
    array_push(_o.provider_records,{anchor:_anchor,first:instance_find(NothingInactive,0),
        exists:instance_exists(_anchor),during_generation:instance_exists(GenCont),
        area:GameCont.area,subarea:GameCont.subarea,owned:scrNTTEFullUnlockGet("quest:part:1",false),
        spawned:array_get_index(scrNTTEFullValue(GameCont,"ntte_quest_spawned_part_index_list",[]),1)>=0})
}
function scrNTTEFullPalaceArtifactContinueFactory(_chest,_part) {
    var _o=instance_find(NTTEFullPalaceArtifactContinueTest,0)
    if(_part!=1) return;
    assert(instance_exists(GenCont) && GameCont.area==area_palace && GameCont.subarea==3
        && instance_is(_chest,NTTEFullQuestChest),"Guarded chest lacks actual normal Palace3 provider context")
    array_push(_o.factory_records,{chest:_chest,part:_part,x:_chest.x,y:_chest.y})
    _o.source_chest=_chest;_o.source_model=_chest.wep
}
function scrNTTEFullPalaceArtifactContinueOpened(_chest,_opener,_pickup) {
    var _o=instance_find(NTTEFullPalaceArtifactContinueTest,0)
    if(_chest!=_o.source_chest) return;
    assert(_opener==_o.player && instance_exists(_pickup)
        && scrNTTEFullWeaponModel(_pickup.wep)==_o.source_model,
        "Provider chest contact did not transfer its exact source physical model")
    var _touch=false
    with(_chest) _touch=place_meeting(x,y,_opener)
    assert(_touch,"Provider chest opened without actual native Player overlap")
    _o.source_pickup=_pickup
    array_push(_o.opened_records,{chest:_chest,opener:_opener,pickup:_pickup,overlap:_touch})
}
function scrNTTEFullPalaceArtifactContinueProbe(_where,_value=undefined) {
    var _o=instance_find(NTTEFullPalaceArtifactContinueTest,0)
    if(_o.restored) return;
    if(_where=="Gen.Create.after") _o.gen_creates++
    if(_where=="Gen.Destroy.after") _o.gen_destroys++
    if(_where=="Player.RoomStart.after") array_push(_o.player_room_starts,id)
    if(_where=="Load.begin") {
        assert(_o.phase==4 && !_value,"Fixture bypassed full native binary loader")
        _o.load_calls++
    }
    if(_where=="Session.Import.after") _o.session_imports++
    if(_where=="Player.Load.after") array_push(_o.player_loads,id)
}
function scrNTTEFullPalaceArtifactContinueFingerprint(_expected_continue=false) {
    var _model=scrNTTEFullWeaponModel(player.wep),_previous=scrNTTEFullWeaponModel(player.bwep),
        _graph={originals:[],nodes:[]},_root=scrNTTEFullWeaponNativeEncode([_model,player.ntte_state,_previous,player.bntte_state],_graph)
    if(_expected_continue) {
        // No pending physical projectile exists. Source StateRestored still
        // advances each canonical state's epoch once during registry import.
        // Predict only that authored scalar change in the ENCODED snapshot;
        // never call StateRestored or mutate either live model/state.
        assert(player.ntte_state.outstanding==0 && player.bntte_state.outstanding==0
            && player.ntte_state.charge==0 && player.bntte_state.charge==0
            && player.ntte_state.loaded && player.bntte_state.loaded,
            "No-fire binary graph baseline unexpectedly has pending weapon work")
        var _epochs=0
        for(var _i=0;_i<array_length(_graph.nodes);++_i) if(!_graph.nodes[_i].array) {
            var _entries=_graph.nodes[_i].entries
            for(var _j=0;_j<array_length(_entries);++_j) if(_entries[_j][0]=="epoch") {
                assert(_entries[_j][1].type==0,"Canonical state epoch is not a source scalar")
                _entries[_j][1].value+=1;_epochs++
            }
        }
        assert(_epochs==2,"Physical source graph does not contain exactly two canonical weapon states")
    }
    // BEGIN NTTE TEST ENCODED OBJECT ENTRY ORDER
    // Object field enumeration has no semantic order. Sort only the local
    // encoded object's entries; retain node IDs, arrays and exact descriptors.
    for(var _i=0;_i<array_length(_graph.nodes);++_i) if(!_graph.nodes[_i].array) {
        array_sort(_graph.nodes[_i].entries,function(_left,_right) {
            var _a=_left[0],_b=_right[0],_limit=min(string_byte_length(_a),string_byte_length(_b))
            for(var _k=1;_k<=_limit;++_k) {
                var _delta=string_byte_at(_a,_k)-string_byte_at(_b,_k)
                if(_delta!=0) return _delta;
            }
            return string_byte_length(_a)-string_byte_length(_b);
        });
    }
    // END NTTE TEST ENCODED OBJECT ENTRY ORDER
    return json_stringify({root:_root,nodes:_graph.nodes,wep:player.wep,bwep:player.bwep,
        curse:player.curse,bcurse:player.bcurse,ammo:player.ammo})
}
function scrNTTEFullPalaceArtifactContinuePhysical(_where) {
    assert(scrNTTEFullWeaponIsNative(player.wep) && scrNTTEFullWeaponIsNative(player.bwep)
        && player.wep==artifact_handle && player.bwep==previous_handle,
        "Artifact/previous physical handles changed: "+_where)
    var _model=scrNTTEFullWeaponModel(player.wep),_previous=scrNTTEFullWeaponModel(player.bwep)
    assert(scrNTTEFullCrabbonePartIndex(_model,player.ntte_state)==1 && _model.type_index==2
        && _model.ammo==1 && player.ntte_state.ammo==1 && player.ntte_state.type_index==2
        && _model.ammo_wep==wep_none && player.ntte_state.ammo_wep==wep_none
        && player.ntte_state==_model.ntte_native_state && player.ntte_state.weapon==player.wep
        && scrNTTEFullWeaponRaw(_previous)==wep_wrench && player.bntte_state==_previous.ntte_native_state
        && player.bntte_state.weapon==player.bwep && player.curse==0 && player.bcurse==0,
        "Source Guarded part/empty ammo_wep/one ammo/prior Wrench/canonical aliases changed: "+_where)
    var _ground=0,_registry=0
    with(WepPickup) if(scrNTTEFullQuestWeaponHasPart(wep,1,scrNTTEFullValue(id,"ntte_state",undefined))) _ground++
    var _models=global.ntte_full_native_weapon_models
    for(var _i=0;_i<array_length(_models);++_i)
        if(scrNTTEFullCrabbonePartIndex(_models[_i])==1) _registry++
    assert(_ground==0 && _registry==1 && instance_number(NTTEFullQuestChest)==0
        && array_length(GameCont.ntte_quest_spawned_part_index_list)==1
        && GameCont.ntte_quest_spawned_part_index_list[0]==1,
        "Guarded artifact duplicated ground/registry/provider or lost source per-run exclusion: "+_where)
    for(var _i=0;_i<4;++_i) assert(!scrNTTEFullUnlockGet("quest:part:"+string(_i),false),
        "Opening/carrying artifact prematurely granted a permanent hub deposit")
    assert(!scrNTTEFullUnlockGet("race:beetle",false),"Artifact acquisition prematurely granted Beetle")
}
function scrNTTEFullPalaceArtifactContinuePathDirection(_x,_y) {
    bot_path_clock-=timescale
    if(bot_path_clock<=0 || point_distance(_x,_y,bot_goal_x,bot_goal_y)>8) {
        bot_goal_x=_x;bot_goal_y=_y;bot_path_clock=20;bot_path_cursor=1
        var _left=infinity,_top=infinity,_right=-infinity,_bottom=-infinity
        with(Floor) {_left=min(_left,bbox_left);_top=min(_top,bbox_top);_right=max(_right,bbox_right);_bottom=max(_bottom,bbox_bottom)}
        var _grid=mp_grid_create(floor((_left-64)/8)*8,floor((_top-64)/8)*8,
            ceil((_right-_left+128)/8),ceil((_bottom-_top+128)/8),8,8)
        with(Wall) mp_grid_add_rectangle(_grid,bbox_left-5,bbox_top-3,bbox_right+5,bbox_bottom+3)
        path_clear_points(bot_path);mp_grid_path(_grid,bot_path,player.x,player.y,_x,_y,false);mp_grid_destroy(_grid)
    }
    if(path_get_number(bot_path)<2) return undefined;
    while(bot_path_cursor<path_get_number(bot_path)-1
        && point_distance(player.x,player.y,path_get_point_x(bot_path,bot_path_cursor),path_get_point_y(bot_path,bot_path_cursor))<6) bot_path_cursor++
    return point_direction(player.x,player.y,path_get_point_x(bot_path,bot_path_cursor),path_get_point_y(bot_path,bot_path_cursor))
}
function scrNTTEFullPalaceArtifactContinueInput(_keycont,_index) {
    var _o=instance_find(NTTEFullPalaceArtifactContinueTest,0)
    if(_o.restored || !instance_exists(_o.player) || _o.player.index!=_index) return;
    var _moving=false,_direction=0,_pick=false
    with(_o) if(!instance_exists(GenCont) && !instance_exists(FloorMaker) && (phase==2 || phase==3)) {
        var _target=phase==2?source_chest:source_pickup
        if(instance_exists(_target)) {
            if(point_distance(player.x,player.y,_target.x,_target.y)>3) {
                var _next=scrNTTEFullPalaceArtifactContinuePathDirection(_target.x,_target.y)
                if(!is_undefined(_next)) {_moving=true;_direction=_next;move_samples++}
            }
            _pick=phase==3
            if(_pick) pick_samples++
        }
    }
    _keycont.dir_move[_index]=_direction;_keycont.dir_fire[_index]=90
    _keycont.press_pick[_index]=_pick;_keycont.hold_pick[_index]=_pick
    _keycont.press_fire[_index]=false;_keycont.hold_fire[_index]=false;_keycont.release_fire[_index]=false
    _keycont.press_swap[_index]=false;_keycont.hold_swap[_index]=false
    _keycont.hold_spec[_index]=false;_keycont.press_spec[_index]=false
    _keycont.aimassist[_index]=false;_keycont.precisemovement[_index]=true;_keycont.moving[_index]=_moving?1:0
    _keycont.hold_east[_index]=false;_keycont.hold_west[_index]=false
    _keycont.hold_nort[_index]=false;_keycont.hold_sout[_index]=false
}
function scrNTTEFullPalaceArtifactContinueStepBody() {
    elapsed+=timescale;diagnostic_clock-=timescale
    if(phase>0 && diagnostic_clock<=0) {diagnostic_clock=150;scrNTTEFullPalaceArtifactContinueDiagnostic("periodic")}
    assert(elapsed<=7200,"Palace artifact Continue strict timeout phase="+string(phase))
    if(phase>0) scrNTTEFullPalaceArtifactContinueRate("normal frame")
    if(phase==0) {
        for(var _i=0;_i<array_length(smoke_drivers);++_i) {
            instance_activate_object(smoke_drivers[_i])
            if(instance_exists(smoke_drivers[_i])) instance_destroy(smoke_drivers[_i],false)
        }
        smoke_drivers=[];scrNTTEFullPalaceArtifactContinueClear()
        save_set_value("options","autopause",false);save_set_value("options","framerate",rates[pass_index])
        save_set_value("options","keyboard",true);save_set_value("options","gamepad",false)
        save_set_value("game","tutorial",false)
        UberCont.opt_framerate=rates[pass_index];game_set_speed(rates[pass_index],gamespeed_fps)
        UberCont.opt_autopause=false;UberCont.paused=false;UberCont.want_pause=false;UberCont.opt_freeze=0
        UberCont.opt_keyboard=true;UberCont.opt_gamepad=false;UberCont.block_input_frames=0;UberCont.block_input_fire=false
        UberCont.opt_bossintro=false;UberCont.daily_run=false;UberCont.weekly_run=false;UberCont.coop=false;UberCont.hardmode=false
        UberCont.want_quit_to_menu=false;UberCont.show_leaderboards_menu=false;UberCont.continued_run=false
        global.is_server=true;global.index=0;global.custom_seed=701932;global.recontinued_times=0
        global.__debug_infammo=false;global.crownpick=crwn_none
        scrGameCustomModeReset();scr_playerinstances_reset_all();my_player.race=Race.Fish;my_player.skin=0
        global.ntte_full_feature_ready={};global.ntte_full_progress={schema:1,unlocks:{},loadouts:{},stats:{}}
        global.ntte_full_native_weapon_base=maxwep+1;global.ntte_full_native_weapon_models=[]
        if(file_exists(savegame_file)) file_delete(savegame_file)
        game_directory=scratch_root+string(rates[pass_index])+"/";directory_create(game_directory)
        var _files=["ntte-full-progress.json","ntte-full-progress.json.bak","ntte-full-progress.json.tmp","NuclearThrone.sav"]
        for(var _i=0;_i<array_length(_files);++_i) array_push(scratch_files,game_directory+_files[_i])
        provider_records=[];factory_records=[];opened_records=[];load_calls=0;session_imports=0;player_loads=[]
        room_ends=0;room_starts=0;player_room_starts=[];gen_creates=0;gen_destroys=0
        source_chest=noone;source_pickup=noone;source_model=undefined;move_samples=0;pick_samples=0
        instance_create(0,0,GameCont);instance_create(0,0,BackCont);instance_create(0,0,MusCont);scrCreatePlayers(0)
        GameCont.area=area_palace;GameCont.subarea=3;GameCont.loops=0;GameCont.hard=5
        GameCont.maxsubarea=scrAreaGetMaxSubarea(GameCont.area);GameCont.finalsubarea=true
        GameCont.can_advance_stage=true;GameCont.gocrib=false;GameCont.crown=crwn_none
        GameCont.ntte_full_pending_destination=undefined
        GameCont.ntte_full_source_seed=scrNTTEFullSourceSeedBuild(701932)
        GameCont.ntte_full_source_pending_generation=undefined;global.ntte_full_sync_generation=false
        scrRngStatesReset();player=instance_find(Player,0);initial_player=player
        // Declared controlled, ordinary physical starting Wrench, empty second
        // slot. No fabricated artifact/merge/ammo_wep, HP or map anchor.
        previous_model={wep:wep_wrench};previous_handle=scrNTTEFullWeaponNative(previous_model)
        player.wep=previous_handle;player.ntte_state=scrNTTEFullWeaponNativeState(previous_handle)
        player.bwep=wep_none;player.bntte_state=undefined
        assert(player.hp==player.max_hp && player.hp>0,"Native starting Player health prerequisite failed")
        scrNTTEFullFloorResetStyle();scrNTTEFullFloorResetAlign()
        scrNTTEFullPalaceArtifactContinueAwait(1)
        var _gen=instance_create(0,0,GenCont)
        assert(!_gen.ntte_full_sync_generation,"Palace provider replaced asynchronous generation")
        scrNTTESmokeLog("PALACE ARTIFACT CONTINUE controlled Palace3/loop0/hard5/seed701932/Fish/native health/physical ordinary Wrench/empty secondary; no initial part")
        return;
    }
    if(phase!=4) assert(instance_exists(player) && player.hp>0,
        "Palace observer genuinely died; no fixture health/invulnerability rescue")
    assert(!instance_exists(LevCont),"Palace artifact path hit a real choice; no direct dismissal/XP suppression")
    if(phase==1) {
        if(!scrNTTEFullPalaceArtifactContinueWorldReady()) return;
        assert(gen_creates==1 && gen_destroys==1 && room_ends==0 && instance_number(Floor)>20
            && GameCont.area==area_palace && GameCont.subarea==3 && GameCont.loops==0,
            "Controlled Palace3 lacks real completed async generation/eight Draws")
        assert(array_length(provider_records)==1 && provider_records[0].exists
            && provider_records[0].anchor==provider_records[0].first && provider_records[0].during_generation
            && !provider_records[0].owned && !provider_records[0].spawned
            && array_length(factory_records)==1 && instance_exists(source_chest)
            && source_chest.wep==source_model && source_chest.sprite_index==scrNTTERefSprite("QuestChest")
            && scrNTTEFullCrabbonePartIndex(source_model)==1 && instance_number(NTTEFullPalaceStairs)>0,
            "Real first native NothingInactive Palace3 provider omitted exactly one eligible Guarded chest/stairs")
        scrNTTEFullPalaceArtifactContinueAwait(2);return;
    }
    if(phase==2) {
        if(instance_exists(source_chest)) return;
        assert(array_length(opened_records)==1 && instance_exists(source_pickup) && move_samples>0,
            "Source provider chest lacked real native walking/contact/open/pickup provenance")
        scrNTTEFullPalaceArtifactContinueAwait(3);return;
    }
    if(phase==3) {
        if(!scrNTTEFullQuestWeaponHasPart(player.wep,1,player.ntte_state)) return;
        artifact_handle=player.wep
        assert(!instance_exists(source_pickup) && scrNTTEFullWeaponModel(player.wep)==source_model
            && scrNTTEFullWeaponModel(player.bwep)==previous_model && pick_samples>0,
            "Native sampled pickup copied source model, duplicated pickup or lost the exact previous physical Wrench")
        scrNTTEFullPalaceArtifactContinuePhysical("before full binary save")
        physical_fingerprint=scrNTTEFullPalaceArtifactContinueFingerprint(true)
        saved_player=player;scrSavegameSave()
        assert(file_exists(savegame_file),"Actual full binary save was not written")
        var _binary=buffer_load(savegame_file)
        assert(buffer_get_size(_binary)>128,"Native artifact binary save is empty")
        binary_size=buffer_get_size(_binary);buffer_delete(_binary)
        continue_ends=room_ends;continue_starts=room_starts
        scrNTTEFullPalaceArtifactContinueClear();UberCont.want_quit_to_menu=false
        // Native romGame creates Vlambeer; it invokes the full session/global/
        // player loader, then real engine RoomStart initializes the new Player.
        scrNTTEFullPalaceArtifactContinueAwait(4);room_restart();return;
    }
    if(phase==4) {
        if(room_ends==continue_ends) return;
        if(!scrNTTEFullPalaceArtifactContinueWorldReady()) return;
        assert(room_ends==continue_ends+1 && room_starts==continue_starts+1
            && load_calls==1 && session_imports==1 && array_length(player_loads)==1
            && instance_number(Player)==1 && Player.id!=saved_player && player_loads[0]==Player.id
            && array_get_index(player_room_starts,Player.id)>=0 && UberCont.continued_run
            && GameCont.is_level_continuation && GameCont.area==area_palace && GameCont.subarea==3
            && gen_creates==2 && gen_destroys==2 && instance_number(Floor)>20,
            "Full binary native Continue omitted distinct loaded Player/session registry import/engine RoomStart/generated Palace/eight Draws")
        player=Player.id
        assert(player.hp>0,"Actual continued Player died before evidence boundary")
        scrNTTEFullPalaceArtifactContinuePhysical("actual engine Continue eight Draws")
        assert(scrNTTEFullWeaponModel(player.wep)!=source_model && scrNTTEFullWeaponModel(player.bwep)!=previous_model
            && scrNTTEFullPalaceArtifactContinueFingerprint()==physical_fingerprint,
            "Full native binary continuation retained old objects or lost exact reconstructed physical graph/ammo/curses")
        assert(array_length(provider_records)==2 && provider_records[1].exists
            && provider_records[1].anchor==provider_records[1].first && provider_records[1].during_generation
            && !provider_records[1].owned && provider_records[1].spawned && array_length(factory_records)==1,
            "Continued Palace provider failed actual same-run spawn exclusion or manufactured another artifact chest")
        scrNTTEFullPalaceArtifactContinueRate("full native binary Continue real RoomStart eight Draws")
        scrNTTESmokeLog("PASS PALACE ARTIFACT CONTINUE controlled Palace3/loop0/seed701932/real GenCont/first actual NothingInactive provider/stairs/real Guarded chest/native walking+contact+sampled pickup/exact source model+prior physical Wrench/full binary="
            +string(binary_size)+"/native Vlambeer session+global+player loader/registry canonical aliases/distinct reconstructed graph/actual engine RoomEnd+Player.RoomStart/eight Draws/per-run chest exclusion/no ground duplicate/no premature deposit @"
            +string(rates[pass_index])+"; ordinary campaign ingress/Portal exit/hub deposit+revisit/merged artifact stack not covered")
        if(++pass_index<array_length(rates)) {scrNTTEFullPalaceArtifactContinueAwait(0);return}
        scrNTTEFullPalaceArtifactContinueRestore()
        scrNTTESmokeLog("PASS full internal selected implemented branches x 30/60; not complete MOD coverage")
        game_end()
    }
}
function scrNTTEFullPalaceArtifactContinueStep() {
    try {scrNTTEFullPalaceArtifactContinueStepBody()}
    catch(_error) {
        scrNTTEFullPalaceArtifactContinueDiagnostic("before strict failure: "+_error.message)
        scrNTTEFullPalaceArtifactContinueRestore();throw _error
    }
}

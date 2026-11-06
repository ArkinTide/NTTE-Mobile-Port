// Controlled HQ3 only: source-gated native chamber/contact/pickup/full binary Continue.
// No Portal exit, hub deposit/revisit, campaign ingress or merged-stack claim.
function scrNTTEFullHQStolenContinueClear() {
    var _keep=id
    with(all) if(id!=_keep && object_index!=UberCont && object_index!=Console) instance_destroy(id,false)
}
function scrNTTEFullHQStolenContinueRestore() {
    if(restored) return;
    restored=true
    if(path_exists(bot_path)) path_delete(bot_path)
    var _unchanged=ds_map_write(old_save_map)==old_savedata
    scrNTTEFullHQStolenContinueClear()
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
        "HQ Stolen artifact teardown changed original physical options/save map")
    // Dedicated process termination must not deliver another Uber.RoomEnd
    // after its original map and binary bytes have been restored.
    instance_deactivate_object(UberCont)
}
function scrNTTEFullHQStolenContinueAbort(_error) {
    var _o=instance_find(NTTEFullHQStolenContinueTest,0)
    if(instance_exists(_o)) with(_o) {
        scrNTTEFullHQStolenContinueDiagnostic("before strict callback failure: "+_error.message)
        scrNTTEFullHQStolenContinueRestore()
    }
    throw _error
}
function scrNTTEFullHQStolenContinueTests() {
    assert(os_type==os_windows && scrNTTEFullSmokeEnabled(),"HQ Stolen artifact Continue requires explicit Windows full smoke")
    assert(!instance_exists(NTTEFullHQStolenContinueTest),"HQ Stolen artifact Continue observer duplicated")
    var _observer=instance_create(0,0,NTTEFullHQStolenContinueTest)
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
        provider_records=[];factory_records=[];opened_records=[];gate_records=[];chamber_steps=[];countdown_sum=0;countdown_extension=0;countdown_expected=60;open_attempts=0;source_chamber=noone;load_calls=0;session_imports=0;player_loads=[]
        door_slides=[];door_walls=[];door_step_seen=false;door_moved=false;door_completed=false
        player=noone;source_chest=noone;source_pickup=noone;source_model=undefined
        initial_player=noone;saved_player=noone;previous_handle=-1;previous_model=undefined
        artifact_handle=-1;native_steps=0;move_samples=0;pick_samples=0;diagnostic_clock=0
        bot_path=path_add();bot_path_clock=0;bot_path_cursor=1;bot_goal_x=10016;bot_goal_y=10016
        scratch_root=working_directory+"hq-stolen-continue-"+string(get_timer())+"/";directory_create(scratch_root)
        smoke_drivers=scrNTTEFullInstances(NTTESmokeTest)
        with(NTTESmokeTest) instance_deactivate_object(id)
        global.ntte_smoke_active=false
        scrNTTEFullHQStolenContinueClear()
    }
}
function scrNTTEFullHQStolenContinueAwait(_next) {
    phase=_next;elapsed=0;world_ready_draw=-1;diagnostic_clock=0;bot_path_clock=0
    scrNTTESmokeLog("HQ STOLEN CONTINUE phase="+string(phase)+" rate="+string(rates[pass_index]))
}
function scrNTTEFullHQStolenContinueWorldReady() {
    if(instance_exists(GenCont) || instance_exists(FloorMaker)) {world_ready_draw=-1;return false;}
    if(world_ready_draw<0) {world_ready_draw=draw_frames;return false;}
    return draw_frames-world_ready_draw>=8
}
function scrNTTEFullHQStolenContinueRate(_where) {
    assert(UberCont.saveData==fixture_save_map && ds_map_write(old_save_map)==old_savedata
        && game_get_speed(gamespeed_fps)==rates[pass_index] && timescale==30/rates[pass_index]
        && UberCont.opt_framerate==rates[pass_index] && !UberCont.opt_autopause
        && save_get_value("options","framerate",-1)==rates[pass_index]
        && !save_get_value("options","autopause",true),"HQ Stolen artifact rate/options changed: "+_where)
}
function scrNTTEFullHQStolenContinueDiagnostic(_where) {
    var _p={exists:instance_exists(player)}
    if(instance_exists(player)) _p={id:player,x:player.x,y:player.y,hp:player.hp,max_hp:player.max_hp,
        wep:player.wep,bwep:player.bwep,can_walk:player.can_walk,can_pick:player.can_pick,visible:player.visible}
    scrNTTESmokeLog("HQ STOLEN CONTINUE DIAGNOSTIC "+_where+" "+json_stringify({
        phase:phase,elapsed:elapsed,rate:rates[pass_index],player:_p,gen_creates:gen_creates,gen_destroys:gen_destroys,
        provider:provider_records,factory:factory_records,opened:opened_records,
        room_ends:room_ends,room_starts:room_starts,player_room_starts:player_room_starts,
        load_calls:load_calls,session_imports:session_imports,player_loads:player_loads,
        chest:source_chest,chest_exists:instance_exists(source_chest),pickup:source_pickup,pickup_exists:instance_exists(source_pickup),
        enemies:instance_number(enemy),chambers:instance_number(NTTEFullFreakChamber),slides:instance_number(NTTEFullWallSlide),
        portals:instance_number(Portal),move_samples:move_samples,pick_samples:pick_samples,rng:random_get_seed()}))
}
// Read-only hooks: no provider, chest, weapon, save or actor field is written.
function scrNTTEFullHQStolenContinueProviderBefore(_middle) {
    var _o=instance_find(NTTEFullHQStolenContinueTest,0)
    array_push(_o.provider_records,{anchor:_middle,first:instance_find(FloorMiddle,0),
        exists:instance_exists(_middle),during_generation:instance_exists(GenCont),
        x:_middle.x,y:_middle.y,area:GameCont.area,subarea:GameCont.subarea,
        owned:scrNTTEFullUnlockGet("quest:part:2",false),
        spawned:array_get_index(scrNTTEFullValue(GameCont,"ntte_quest_spawned_part_index_list",[]),2)>=0})
}
function scrNTTEFullHQStolenContinueProviderAfter(_middle,_entry,_enemy,_artifact,_side) {
    var _o=instance_find(NTTEFullHQStolenContinueTest,0),_n=array_length(_o.provider_records)-1
    assert(_n>=0 && _o.provider_records[_n].anchor==_middle && GameCont.area==area_hq && GameCont.subarea==3,
        "HQ3 provider lacks actual first FloorMiddle/normal generation context")
    assert(instance_exists(_entry) && instance_exists(_enemy) && instance_exists(_artifact)
        && _entry.x==_middle.x && _entry.y==_middle.y+208 && _entry.object==Player && _entry.open && _entry.alarm0==1
        && _enemy.x==_middle.x+208*_side && _enemy.y==_middle.y && _enemy.enemies==1 && _enemy.spawnmoment==-1
        && _artifact.x==_middle.x-208*_side && _artifact.y==_middle.y && _artifact.enemies==1 && _artifact.spawnmoment==-1,
        "Source HQ3 three208 chambers/entry/near-only sentinel changed")
    var _r=_o.provider_records[_n]
    _r.entry=_entry;_r.enemy=_enemy;_r.artifact=_artifact;_r.side=_side;_r.artifact_object=_artifact.object
    assert(_artifact.object==(_r.owned || _r.spawned?-1:"QuestChest"),"Stolen permanent/per-run source gate changed")
    if(!_r.owned && !_r.spawned) _o.source_chamber=_artifact
}
function scrNTTEFullHQStolenContinueChamberStep(_chamber) {
    var _o=instance_find(NTTEFullHQStolenContinueTest,0)
    if(_chamber!=_o.source_chamber || _o.phase==4) return;
    assert(!_chamber.open && _chamber.enemies==1 && _chamber.spawnmoment==-1,
        "Stolen chamber threshold/open was altered; clearing enemies cannot satisfy negative threshold")
    if(array_length(_o.chamber_steps)<4) array_push(_o.chamber_steps,{alarm:_chamber.alarm0,setup:_chamber.setup,
        player_distance:point_distance(_chamber.x,_chamber.y,_o.player.x,_o.player.y),enemies:instance_number(enemy)})
    if(_chamber.alarm0>0) {
        assert(array_length(_o.gate_records)==1,"Chamber countdown began without actual source near-player trigger")
        var _extension=_chamber.alarm0-_o.countdown_expected
        assert(_extension>=0 && (_extension%30)==0,"Chamber alarm changed outside source30tick desynchronization")
        _o.countdown_extension+=_extension
        _o.countdown_expected=_chamber.alarm0-timescale
        _o.countdown_sum+=timescale
    }
}
function scrNTTEFullHQStolenContinueChamberGate(_chamber,_target) {
    var _o=instance_find(NTTEFullHQStolenContinueTest,0)
    if(_chamber!=_o.source_chamber || _chamber.alarm0<=0 || _o.phase==4) return;
    var _distance=point_distance(_chamber.x,_chamber.y,_target.x,_target.y),
        _blocked=collision_line(_chamber.x,_chamber.y,_target.x,_target.y,Wall,false,false)
    assert(array_length(_o.gate_records)==0 && _target==_o.player && _distance<96 && !_blocked
        && !instance_exists(LastFire) && !_chamber.open && _chamber.alarm0==60,
        "Actual Stolen chamber trigger bypassed source proximity/LOS/LastFire/60tick delay")
    array_push(_o.gate_records,{distance:_distance,wall:_blocked,lastfire:instance_number(LastFire),delay:_chamber.alarm0})
    scrNTTESmokeLog("HQ STOLEN CONTINUE actual near-player gate "+json_stringify(_o.gate_records[0])+" @"+string(30/timescale))
}
function scrNTTEFullHQStolenContinueChamberAttempt(_chamber) {
    var _o=instance_find(NTTEFullHQStolenContinueTest,0)
    if(_chamber!=_o.source_chamber || _o.phase==4) return;
    _o.open_attempts++
    assert(array_length(_o.gate_records)==1 && _o.countdown_sum==60*_o.open_attempts+_o.countdown_extension,
        "Actual chamber excavation ran before complete native60tick countdown/retry")
    _o.countdown_expected=60
}
function scrNTTEFullHQStolenContinueChamberResult(_chamber,_result) {
    var _o=instance_find(NTTEFullHQStolenContinueTest,0)
    if(_chamber!=_o.source_chamber || _o.phase==4) return;
    assert(!instance_exists(GenCont) && _o.phase==2 && array_length(_o.gate_records)==1
        && array_length(_result.occupants)==1 && array_length(_result.floors)>0 && array_length(_result.slides)>0,
        "Stolen chest was not produced by real delayed chamber excavation")
    var _chest=_result.occupants[0]
    assert(instance_is(_chest,NTTEFullQuestChest) && _chest.x==_result.center_x && _chest.y==_result.center_y
        && scrNTTEFullCrabbonePartIndex(_chest.wep)==2 && _chest.wep.type_index==3,
        "Actual chamber failed centered exact Stolen part2 QuestChest")
    _o.source_chest=_chest;_o.source_model=_chest.wep
    _o.door_slides=_result.slides
    for(var _i=0;_i<array_length(_result.slides);++_i) {
        var _slide=_result.slides[_i]
        for(var _j=0;_j<array_length(_slide.slide_inst);++_j) {
            var _wall=_slide.slide_inst[_j]
            array_push(_o.door_walls,{wall:_wall,x:_wall.x,y:_wall.y})
        }
    }
    array_push(_o.factory_records,{chest:_chest,part:2,x:_chest.x,y:_chest.y,slides:array_length(_result.slides),
        countdown:_o.countdown_sum,source_desync_extension:_o.countdown_extension,
        attempts:_o.open_attempts,floors:array_length(_result.floors)})
    scrNTTESmokeLog("HQ STOLEN CONTINUE actual native chamber result "+json_stringify(_o.factory_records[0])+" @"+string(30/timescale))
}
function scrNTTEFullHQStolenContinueDoorWitness() {
    if(!array_length(door_slides)) return;
    var _gone=0
    for(var _i=0;_i<array_length(door_slides);++_i) {
        var _slide=door_slides[_i]
        if(instance_exists(_slide)) {
            if(_slide.slide_index>=0) door_step_seen=true
        } else _gone++
    }
    for(var _i=0;_i<array_length(door_walls);++_i) {
        var _r=door_walls[_i]
        if(instance_exists(_r.wall) && (_r.wall.x!=_r.x || _r.wall.y!=_r.y)) door_moved=true
    }
    door_completed=_gone==array_length(door_slides)
}
function scrNTTEFullHQStolenContinueOpened(_chest,_opener,_pickup) {
    var _o=instance_find(NTTEFullHQStolenContinueTest,0)
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
function scrNTTEFullHQStolenContinueProbe(_where,_value=undefined) {
    var _o=instance_find(NTTEFullHQStolenContinueTest,0)
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
function scrNTTEFullHQStolenContinueFingerprint(_expected_continue=false) {
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
    return json_stringify({root:_root,nodes:_graph.nodes,wep:player.wep,bwep:player.bwep,
        curse:player.curse,bcurse:player.bcurse,ammo:player.ammo})
}
function scrNTTEFullHQStolenContinuePhysical(_where) {
    assert(scrNTTEFullWeaponIsNative(player.wep) && scrNTTEFullWeaponIsNative(player.bwep)
        && player.wep==artifact_handle && player.bwep==previous_handle,
        "Artifact/previous physical handles changed: "+_where)
    var _model=scrNTTEFullWeaponModel(player.wep),_previous=scrNTTEFullWeaponModel(player.bwep)
    assert(scrNTTEFullCrabbonePartIndex(_model,player.ntte_state)==2 && _model.type_index==3
        && _model.ammo==1 && player.ntte_state.ammo==1 && player.ntte_state.type_index==3
        && _model.ammo_wep==wep_none && player.ntte_state.ammo_wep==wep_none
        && player.ntte_state==_model.ntte_native_state && player.ntte_state.weapon==player.wep
        && scrNTTEFullWeaponRaw(_previous)==wep_wrench && player.bntte_state==_previous.ntte_native_state
        && player.bntte_state.weapon==player.bwep && player.curse==0 && player.bcurse==0,
        "Source Stolen part/empty ammo_wep/one ammo/prior Wrench/canonical aliases changed: "+_where)
    var _ground=0,_registry=0
    with(WepPickup) if(scrNTTEFullQuestWeaponHasPart(wep,2,scrNTTEFullValue(id,"ntte_state",undefined))) _ground++
    var _models=global.ntte_full_native_weapon_models
    for(var _i=0;_i<array_length(_models);++_i)
        if(scrNTTEFullCrabbonePartIndex(_models[_i])==2) _registry++
    assert(_ground==0 && _registry==1 && instance_number(NTTEFullQuestChest)==0
        && array_length(GameCont.ntte_quest_spawned_part_index_list)==1
        && GameCont.ntte_quest_spawned_part_index_list[0]==2,
        "Stolen artifact duplicated ground/registry/provider or lost source per-run exclusion: "+_where)
    for(var _i=0;_i<4;++_i) assert(!scrNTTEFullUnlockGet("quest:part:"+string(_i),false),
        "Opening/carrying artifact prematurely granted a permanent hub deposit")
    assert(!scrNTTEFullUnlockGet("race:beetle",false),"Artifact acquisition prematurely granted Beetle")
}
// BEGIN NTTE HQ STOLEN NATIVE PLANNER FALLBACK HELPERS
// Fixture-only grid-first fallback. Endpoints alone never establish a route.
// Actual Player Wall/Floor masks include actual HQ Floor, unchanged.
// Native Player movement/fire remains the only way actors change position/HP.
function scrNTTEHQStolenNativeNavPoint(_x,_y,_budget) {
    if(_budget.remaining<=0) {_budget.exhausted=true;return 0;}
    _budget.remaining--;_budget.samples++
    var _wall=false,_floor=false
    with(player) {_wall=place_meeting(_x,_y,Wall);_floor=place_meeting(_x,_y,Floor)}
    if(_wall) return 2;
    if(!_floor) return 3;
    return 1;
}
function scrNTTEHQStolenNativeNavSegment(_x1,_y1,_x2,_y2,_budget) {
    var _steps=max(1,ceil(point_distance(_x1,_y1,_x2,_y2)/2))
    for(var _i=0;_i<=_steps;++_i)
        if(scrNTTEHQStolenNativeNavPoint(lerp(_x1,_x2,_i/_steps),lerp(_y1,_y2,_i/_steps),_budget)!=1) return false;
    return true;
}
function scrNTTEHQStolenNativeNavPose() {
    return [player,player.x,player.y,player.mask_index,player.sprite_index,player.image_index,
        player.image_xscale,player.image_yscale,player.image_angle,player.bbox_left,player.bbox_top,player.bbox_right,player.bbox_bottom];
}
function scrNTTEHQStolenNativeNavBuild(_grid) {
    var _total=_grid.width*_grid.height,_budget={remaining:200000,samples:0,exhausted:false},
        _out={complete:false,status:"node_budget",budget:_budget,pose:scrNTTEHQStolenNativeNavPose(),
            points:[],horizontal:[],vertical:[],members:[],parents:[],roots:[],visited:0}
    if(_total<=0 || _total>60000) return _out;
    var _points=array_create(_total,0),_horizontal=array_create(_total,0),_vertical=array_create(_total,0),
        _seen=array_create(_total,0),_parents=array_create(_total,-2),_roots=[],_queue=[],_head=0
    for(var _i=0;_i<_total && !_budget.exhausted;++_i)
        _points[_i]=scrNTTEHQStolenNativeNavPoint(_grid.x+((_i mod _grid.width)+0.5)*8,
            _grid.y+(floor(_i/_grid.width)+0.5)*8,_budget)
    var _cx=floor((player.x-_grid.x)/8),_cy=floor((player.y-_grid.y)/8)
    for(var _dy=-1;_dy<=1;++_dy) for(var _dx=-1;_dx<=1;++_dx) {
        var _nx=_cx+_dx,_ny=_cy+_dy
        if(_nx<0 || _ny<0 || _nx>=_grid.width || _ny>=_grid.height) continue;
        var _index=_ny*_grid.width+_nx
        if(_points[_index]==1 && scrNTTEHQStolenNativeNavSegment(player.x,player.y,
            _grid.x+(_nx+0.5)*8,_grid.y+(_ny+0.5)*8,_budget)) {
            _seen[_index]=1;_parents[_index]=-1;array_push(_queue,_index);array_push(_roots,_index)
        }
    }
    var _dxs=[-1,1,0,0],_dys=[0,0,-1,1]
    while(_head<array_length(_queue) && !_budget.exhausted) {
        var _index=_queue[_head++],_cx=_index mod _grid.width,_cy=floor(_index/_grid.width),
            _x=_grid.x+(_cx+0.5)*8,_y=_grid.y+(_cy+0.5)*8
        for(var _direction=0;_direction<4 && !_budget.exhausted;++_direction) {
            var _nx=_cx+_dxs[_direction],_ny=_cy+_dys[_direction]
            if(_nx<0 || _ny<0 || _nx>=_grid.width || _ny>=_grid.height) continue;
            var _next=_ny*_grid.width+_nx,_horizontal_edge=_direction<2,_slot=min(_index,_next),
                _code=_horizontal_edge?_horizontal[_slot]:_vertical[_slot]
            if(_code==0) {
                if(_points[_next]!=1) _code=_points[_next];
                else _code=scrNTTEHQStolenNativeNavSegment(_x,_y,_grid.x+(_nx+0.5)*8,_grid.y+(_ny+0.5)*8,_budget)?1:2;
                if(_horizontal_edge) _horizontal[_slot]=_code; else _vertical[_slot]=_code;
            }
            if(_code==1 && !_seen[_next]) {_seen[_next]=1;_parents[_next]=_index;array_push(_queue,_next);}
        }
    }
    _out.complete=!_budget.exhausted && _head==array_length(_queue)
    _out.status=_out.complete?"lattice_complete":"budget_unknown"
    _out.points=_points;_out.horizontal=_horizontal;_out.vertical=_vertical
    _out.members=_seen;_out.parents=_parents;_out.roots=_roots;_out.visited=array_length(_queue)
    return _out;
}
function scrNTTEHQStolenNativeNavFallback(_grid,_goal_x,_goal_y) {
    var _endpoint_budget={remaining:2,samples:0,exhausted:false},
        _start_code=scrNTTEHQStolenNativeNavPoint(player.x,player.y,_endpoint_budget),
        _goal_code=scrNTTEHQStolenNativeNavPoint(_goal_x,_goal_y,_endpoint_budget)
    if(_start_code!=1 || _goal_code!=1 || _endpoint_budget.exhausted) {
        scrNTTESmokeLog("HQ STOLEN NATIVE FALLBACK ENDPOINT REFUSED "+json_stringify({seed:global.custom_seed,rate:rates[pass_index],phase:phase,
            start:[player.x,player.y],goal:[_goal_x,_goal_y],start_code:_start_code,goal_code:_goal_code,budget:_endpoint_budget}))
        return false;
    }
    var _pose=scrNTTEHQStolenNativeNavPose(),_graph=undefined
    if(variable_struct_exists(_grid,"ntte_hq_stolen_nav_graph")) _graph=_grid.ntte_hq_stolen_nav_graph;
    // Reuse only inside this same synchronous grid scope and exact Player pose.
    // Every ordinary movement replan creates a fresh grid and a fresh graph.
    if(!is_struct(_graph) || json_stringify(_graph.pose)!=json_stringify(_pose)) {
        _graph=scrNTTEHQStolenNativeNavBuild(_grid);_grid.ntte_hq_stolen_nav_graph=_graph
    }
    if(!_graph.complete || _graph.budget.exhausted) {
        scrNTTESmokeLog("HQ STOLEN NATIVE FALLBACK UNKNOWN "+json_stringify({seed:global.custom_seed,rate:rates[pass_index],phase:phase,
            status:_graph.status,budget:_graph.budget,goal:[_goal_x,_goal_y]}))
        return false;
    }
    var _cx=floor((_goal_x-_grid.x)/8),_cy=floor((_goal_y-_grid.y)/8),_end=-1
    for(var _dy=-1;_dy<=1 && _end<0;++_dy) for(var _dx=-1;_dx<=1;++_dx) {
        var _nx=_cx+_dx,_ny=_cy+_dy
        if(_nx<0 || _ny<0 || _nx>=_grid.width || _ny>=_grid.height) continue;
        var _index=_ny*_grid.width+_nx
        if(_graph.members[_index] && scrNTTEHQStolenNativeNavSegment(_goal_x,_goal_y,
            _grid.x+(_nx+0.5)*8,_grid.y+(_ny+0.5)*8,_graph.budget)) {_end=_index;break;}
    }
    if(_end<0 || _graph.budget.exhausted) {
        scrNTTESmokeLog("HQ STOLEN NATIVE FALLBACK NO ROUTE "+json_stringify({seed:global.custom_seed,rate:rates[pass_index],phase:phase,
            start:[player.x,player.y],goal:[_goal_x,_goal_y],visited:_graph.visited,roots:_graph.roots,
            complete:_graph.complete,budget:_graph.budget}))
        return false;
    }
    var _reverse=[],_cursor=_end,_total=_grid.width*_grid.height,_count=0
    while(_cursor>=0 && _count++<=_total) {array_push(_reverse,_cursor);_cursor=_graph.parents[_cursor];}
    if(_cursor!=-1 || array_length(_reverse)<=0 || array_get_index(_graph.roots,_reverse[array_length(_reverse)-1])<0) return false;
    var _route=[[player.x,player.y]]
    for(var _i=array_length(_reverse)-1;_i>=0;--_i) {
        var _index=_reverse[_i]
        array_push(_route,[_grid.x+((_index mod _grid.width)+0.5)*8,_grid.y+(floor(_index/_grid.width)+0.5)*8])
    }
    array_push(_route,[_goal_x,_goal_y])
    // Freshly recheck every segment, including the two exact real endpoints,
    // before publishing any path points. Unknown can never be accepted.
    for(var _i=1;_i<array_length(_route);++_i)
        if(!scrNTTEHQStolenNativeNavSegment(_route[_i-1][0],_route[_i-1][1],_route[_i][0],_route[_i][1],_graph.budget)) return false;
    if(_graph.budget.exhausted || json_stringify(scrNTTEHQStolenNativeNavPose())!=json_stringify(_pose)) return false;
    path_clear_points(bot_path);path_set_kind(bot_path,0);path_set_closed(bot_path,false)
    for(var _i=0;_i<array_length(_route);++_i) path_add_point(bot_path,_route[_i][0],_route[_i][1],100)
    bot_hq_stolen_native_mask_path=true
    scrNTTESmokeLog("HQ STOLEN NATIVE FALLBACK PATH "+json_stringify({seed:global.custom_seed,rate:rates[pass_index],phase:phase,
        start:_route[0],goal:[_goal_x,_goal_y],points:array_length(_route),visited:_graph.visited,
        budget:_graph.budget,whole_route_rechecked:true,route:_route}))
    return true;
}
function scrNTTEHQStolenNativeNavFollow() {
    // Never skip a close corner using distance alone. Every proposed shortcut
    // is checked using the current real Player mask/Floor before native input.
    var _budget={remaining:512,samples:0,exhausted:false},_last=path_get_number(bot_path)-1,
        _first=clamp(bot_path_cursor,1,_last),_chosen=-1
    for(var _i=min(_last,_first+8);_i>=_first;--_i) {
        var _x=path_get_point_x(bot_path,_i),_y=path_get_point_y(bot_path,_i)
        if(point_distance(player.x,player.y,_x,_y)<0.01) continue;
        if(scrNTTEHQStolenNativeNavSegment(player.x,player.y,_x,_y,_budget)) {_chosen=_i;break;}
    }
    if(_chosen<0 || _budget.exhausted) {bot_path_clock=0;return undefined;}
    bot_path_cursor=_chosen
    return point_direction(player.x,player.y,path_get_point_x(bot_path,_chosen),path_get_point_y(bot_path,_chosen));
}
// END NTTE HQ STOLEN NATIVE PLANNER FALLBACK HELPERS
function scrNTTEFullHQStolenContinuePathDirection(_x,_y) {
    bot_path_clock-=timescale
    if(bot_path_clock<=0 || point_distance(_x,_y,bot_goal_x,bot_goal_y)>8) {
        bot_goal_x=_x;bot_goal_y=_y;bot_path_clock=20;bot_path_cursor=1
        var _left=infinity,_top=infinity,_right=-infinity,_bottom=-infinity
        with(Floor) {_left=min(_left,bbox_left);_top=min(_top,bbox_top);_right=max(_right,bbox_right);_bottom=max(_bottom,bbox_bottom)}
        var _grid=mp_grid_create(floor((_left-64)/8)*8,floor((_top-64)/8)*8,
            ceil((_right-_left+128)/8),ceil((_bottom-_top+128)/8),8,8)
        with(Wall) mp_grid_add_rectangle(_grid,bbox_left-5,bbox_top-3,bbox_right+5,bbox_bottom+3)
        path_clear_points(bot_path);mp_grid_path(_grid,bot_path,player.x,player.y,_x,_y,false);mp_grid_destroy(_grid)
        // BEGIN NTTE HQ STOLEN NATIVE PLANNER FALLBACK PLAN
        bot_hq_stolen_native_mask_path=false
        if(path_get_number(bot_path)<=1)
            scrNTTEHQStolenNativeNavFallback({x:floor((_left-64)/8)*8,y:floor((_top-64)/8)*8,
                width:ceil((_right-_left+128)/8),height:ceil((_bottom-_top+128)/8)},_x,_y)
        // END NTTE HQ STOLEN NATIVE PLANNER FALLBACK PLAN
    }
    if(path_get_number(bot_path)<2) return undefined;
    // BEGIN NTTE HQ STOLEN NATIVE PLANNER FALLBACK FOLLOW
    if(variable_instance_exists(id,"bot_hq_stolen_native_mask_path") && bot_hq_stolen_native_mask_path)
        return scrNTTEHQStolenNativeNavFollow();
    // END NTTE HQ STOLEN NATIVE PLANNER FALLBACK FOLLOW
    while(bot_path_cursor<path_get_number(bot_path)-1
        && point_distance(player.x,player.y,path_get_point_x(bot_path,bot_path_cursor),path_get_point_y(bot_path,bot_path_cursor))<6) bot_path_cursor++
    return point_direction(player.x,player.y,path_get_point_x(bot_path,bot_path_cursor),path_get_point_y(bot_path,bot_path_cursor))
}
function scrNTTEFullHQStolenContinueInput(_keycont,_index) {
    var _o=instance_find(NTTEFullHQStolenContinueTest,0)
    if(_o.restored || !instance_exists(_o.player) || _o.player.index!=_index) return;
    var _moving=false,_direction=0,_pick=false
    with(_o) if(!instance_exists(GenCont) && !instance_exists(FloorMaker)
        && (phase==2 || (phase==5 && door_completed) || phase==3)) {
        var _target=phase==2?source_chamber:(phase==5?source_chest:source_pickup)
        if(instance_exists(_target)) {
            if(point_distance(player.x,player.y,_target.x,_target.y)>3) {
                var _tx=_target.x,_ty=_target.y
                if(phase==2) {
                    var _best=infinity
                    with(Floor) for(var _fx=bbox_left+8;_fx<bbox_right;_fx+=8)
                        for(var _fy=bbox_top+8;_fy<bbox_bottom;_fy+=8) {
                            var _d=point_distance(_fx,_fy,_target.x,_target.y)
                            if(_d<96 && _d<_best && !collision_line(_fx,_fy,_target.x,_target.y,Wall,false,false)
                                && !collision_rectangle(_fx-5,_fy-3,_fx+5,_fy+3,Wall,false,false)) {
                                _best=_d;_tx=_fx;_ty=_fy
                            }
                        }
                    if(_best==infinity) {_tx=player.x;_ty=player.y}
                }
                var _next=scrNTTEFullHQStolenContinuePathDirection(_tx,_ty)
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
function scrNTTEFullHQStolenContinueStepBody() {
    elapsed+=timescale;diagnostic_clock-=timescale
    if(phase>0 && diagnostic_clock<=0) {diagnostic_clock=150;scrNTTEFullHQStolenContinueDiagnostic("periodic")}
    assert(elapsed<=7200,"HQ Stolen artifact Continue strict timeout phase="+string(phase))
    if(phase>0) scrNTTEFullHQStolenContinueRate("normal frame")
    if(phase==2 || phase==5) scrNTTEFullHQStolenContinueDoorWitness()
    if(phase==0) {
        for(var _i=0;_i<array_length(smoke_drivers);++_i) {
            instance_activate_object(smoke_drivers[_i])
            if(instance_exists(smoke_drivers[_i])) instance_destroy(smoke_drivers[_i],false)
        }
        smoke_drivers=[];scrNTTEFullHQStolenContinueClear()
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
        provider_records=[];factory_records=[];opened_records=[];gate_records=[];chamber_steps=[];countdown_sum=0;countdown_extension=0;countdown_expected=60;open_attempts=0;source_chamber=noone;load_calls=0;session_imports=0;player_loads=[]
        door_slides=[];door_walls=[];door_step_seen=false;door_moved=false;door_completed=false
        room_ends=0;room_starts=0;player_room_starts=[];gen_creates=0;gen_destroys=0
        source_chest=noone;source_pickup=noone;source_model=undefined;move_samples=0;pick_samples=0
        instance_create(0,0,GameCont);instance_create(0,0,BackCont);instance_create(0,0,MusCont);scrCreatePlayers(0)
        GameCont.area=area_hq;GameCont.subarea=3;GameCont.loops=0;GameCont.hard=5
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
        assert(player.hp==8 && player.max_hp==8,"Native starting Player health prerequisite failed")
        scrNTTEFullFloorResetStyle();scrNTTEFullFloorResetAlign()
        scrNTTEFullHQStolenContinueAwait(1)
        var _gen=instance_create(0,0,GenCont)
        assert(!_gen.ntte_full_sync_generation,"HQ provider replaced asynchronous generation")
        scrNTTESmokeLog("HQ STOLEN CONTINUE controlled HQ3/loop0/hard5/seed701932/Fish/native health/physical ordinary Wrench/empty secondary; no initial part")
        return;
    }
    if(phase!=4) assert(instance_exists(player) && player.hp>0,
        "HQ Stolen observer genuinely died; no fixture health/invulnerability rescue")
    assert(!instance_exists(LevCont),"HQ Stolen artifact path hit a real choice; no direct dismissal/XP suppression")
    if(phase==1) {
        if(!scrNTTEFullHQStolenContinueWorldReady()) return;
        assert(gen_creates==1 && gen_destroys==1 && room_ends==0 && instance_number(Floor)>20
            && GameCont.area==area_hq && GameCont.subarea==3 && GameCont.loops==0,
            "Controlled HQ3 lacks real completed async generation/eight Draws")
        assert(array_length(provider_records)==1 && provider_records[0].exists
            && provider_records[0].anchor==provider_records[0].first && provider_records[0].during_generation
            && !provider_records[0].owned && !provider_records[0].spawned
            && instance_exists(source_chamber) && source_chamber.object=="QuestChest"
            && source_chamber.enemies==1 && source_chamber.spawnmoment==-1 && !source_chamber.open
            && source_chamber.alarm0<0 && array_length(gate_records)==0 && array_length(factory_records)==0,
            "Real first native FloorMiddle HQ3 provider omitted untriggered source-gated Stolen chamber")
        scrNTTEFullHQStolenContinueAwait(2);return;
    }
    if(phase==2) {
        if(!instance_exists(source_chest)) return;
        assert(array_length(factory_records)==1 && array_length(gate_records)==1
            && !instance_exists(source_chamber) && countdown_sum==60*open_attempts+countdown_extension && move_samples>0,
            "Actual scheduled chamber source trigger/countdown/excavation/disposal witnesses incomplete")
        scrNTTEFullHQStolenContinueAwait(5);return;
    }
    if(phase==5) {
        if(instance_exists(source_chest)) return;
        assert(array_length(opened_records)==1 && instance_exists(source_pickup) && move_samples>0
            && door_step_seen && door_moved && door_completed,
            "Source chamber chest lacked real native walking/contact/open/pickup provenance")
        scrNTTESmokeLog("HQ STOLEN CONTINUE native sliding doors actual scheduled EndStep/motion/Destroy then physical chest contact OK @"+string(rates[pass_index]))
        scrNTTEFullHQStolenContinueAwait(3);return;
    }
    if(phase==3) {
        if(!scrNTTEFullQuestWeaponHasPart(player.wep,2,player.ntte_state)) return;
        artifact_handle=player.wep
        assert(!instance_exists(source_pickup) && scrNTTEFullWeaponModel(player.wep)==source_model
            && scrNTTEFullWeaponModel(player.bwep)==previous_model && pick_samples>0,
            "Native sampled pickup copied source model, duplicated pickup or lost the exact previous physical Wrench")
        scrNTTEFullHQStolenContinuePhysical("before full binary save")
        physical_fingerprint=scrNTTEFullHQStolenContinueFingerprint(true)
        saved_player=player;scrSavegameSave()
        assert(file_exists(savegame_file),"Actual full binary save was not written")
        var _binary=buffer_load(savegame_file)
        assert(buffer_get_size(_binary)>128,"Native artifact binary save is empty")
        binary_size=buffer_get_size(_binary);buffer_delete(_binary)
        continue_ends=room_ends;continue_starts=room_starts
        scrNTTEFullHQStolenContinueClear();UberCont.want_quit_to_menu=false
        // Native romGame creates Vlambeer; it invokes the full session/global/
        // player loader, then real engine RoomStart initializes the new Player.
        scrNTTEFullHQStolenContinueAwait(4);room_restart();return;
    }
    if(phase==4) {
        if(room_ends==continue_ends) return;
        if(!scrNTTEFullHQStolenContinueWorldReady()) return;
        assert(room_ends==continue_ends+1 && room_starts==continue_starts+1
            && load_calls==1 && session_imports==1 && array_length(player_loads)==1
            && instance_number(Player)==1 && Player.id!=saved_player && player_loads[0]==Player.id
            && array_get_index(player_room_starts,Player.id)>=0 && UberCont.continued_run
            && GameCont.is_level_continuation && GameCont.area==area_hq && GameCont.subarea==3
            && gen_creates==2 && gen_destroys==2 && instance_number(Floor)>20,
            "Full binary native Continue omitted distinct loaded Player/session registry import/engine RoomStart/generated HQ/eight Draws")
        player=Player.id
        assert(player.hp>0,"Actual continued Player died before evidence boundary")
        scrNTTEFullHQStolenContinuePhysical("actual engine Continue eight Draws")
        assert(scrNTTEFullWeaponModel(player.wep)!=source_model && scrNTTEFullWeaponModel(player.bwep)!=previous_model
            && scrNTTEFullHQStolenContinueFingerprint()==physical_fingerprint,
            "Full native binary continuation retained old objects or lost exact reconstructed physical graph/ammo/curses")
        assert(array_length(provider_records)==2 && provider_records[1].exists
            && provider_records[1].anchor==provider_records[1].first && provider_records[1].during_generation
            && !provider_records[1].owned && provider_records[1].spawned && provider_records[1].artifact_object==-1 && array_length(factory_records)==1,
            "Continued HQ provider failed actual same-run spawn exclusion or manufactured another artifact chest")
        scrNTTEFullHQStolenContinueRate("full native binary Continue real RoomStart eight Draws")
        scrNTTESmokeLog("PASS HQ STOLEN CONTINUE controlled HQ3/loop0/seed701932/real GenCont/first actual FloorMiddle provider/source near-player+LOS+LastFire gate/native60tick countdown/excavation+sliding doors/real Stolen chest/native walking+contact+sampled pickup/exact source model+prior physical Wrench/full binary="
            +string(binary_size)+"/native Vlambeer session+global+player loader/registry canonical aliases/distinct reconstructed graph/actual engine RoomEnd+Player.RoomStart/eight Draws/per-run chest exclusion/no ground duplicate/no premature deposit @"
            +string(rates[pass_index])+"; ordinary campaign ingress/HQ1-2/Captain combat/Portal exit/hub deposit+revisit/merged artifact stack not covered")
        if(++pass_index<array_length(rates)) {scrNTTEFullHQStolenContinueAwait(0);return}
        scrNTTEFullHQStolenContinueRestore()
        scrNTTESmokeLog("PASS full internal selected implemented branches x 30/60; not complete MOD coverage")
        game_end()
    }
}
function scrNTTEFullHQStolenContinueStep() {
    try {scrNTTEFullHQStolenContinueStepBody()}
    catch(_error) {
        scrNTTEFullHQStolenContinueDiagnostic("before strict failure: "+_error.message)
        scrNTTEFullHQStolenContinueRestore();throw _error
    }
}

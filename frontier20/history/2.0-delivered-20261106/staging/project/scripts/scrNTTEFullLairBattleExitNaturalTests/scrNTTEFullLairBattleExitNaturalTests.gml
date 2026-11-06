// Dedicated desktop process. Controlled initial Lair1/loop0/Fish/legal AutoCrossbow.
// This is a fail-closed, initially UNRUN complete-battle acceptance candidate.
// Upstream Pizza/Drain entry is deliberately outside this isolated initial scene.
// No target/player HP, runtime position, Boss phase/timer, reward or room edits.
function scrNTTEFullLairBattleExitClear() {
    var _keep=id
    with(all) if(id!=_keep && object_index!=UberCont && object_index!=Console) instance_destroy(id,false)
}
function scrNTTEFullLairBattleExitRestore() {
    if(restored) return;
    restored=true;want_fire=false;want_move=false
    ui_key=-1;ui_token_pending=false;ui_target=noone;ui_target_skill=-1
    if(path_exists(bot_path)) path_delete(bot_path)
    var _unchanged=ds_map_write(old_save_map)==old_savedata
    // Dedicated-process teardown only, after the measured assertions (or a
    // failure). Dispose private actors while private progress/map still own
    // their cleanup; do not let game_end advance a fixture GameCont afterward.
    scrNTTEFullLairBattleExitClear()
    scrNTTEFullAreaGeneratorRestore(old_global_graph)
    for(var _i=0;_i<array_length(old_global_vars);++_i)
        variable_global_set(old_global_vars[_i][0],old_global_vars[_i][1])
    scrNTTEFullAreaGeneratorRestore(old_uber)
    UberCont.saveData=old_save_map
    if(ds_exists(fixture_save_map,ds_type_map)) ds_map_destroy(fixture_save_map)
    game_set_speed(old_game_speed,gamespeed_fps)
    game_directory=old_directory;global.ntte_smoke_active=old_smoke
    current_frame=old_clock
    if(old_continue>=0) {buffer_save(old_continue,savegame_file);buffer_delete(old_continue)}
    else if(file_exists(savegame_file)) file_delete(savegame_file)
    for(var _i=0;_i<array_length(scratch_files);++_i)
        if(file_exists(scratch_files[_i])) file_delete(scratch_files[_i])
    random_set_seed(old_seed)
    assert(_unchanged,"Lair battle fixture changed original physical options/save map")
    assert(ds_map_write(old_save_map)==old_savedata,"Private cleanup altered original options/save map")
    // UberCont.RoomEnd writes fullscreen/tot_time before testing dont_save.
    // The process is now terminating; stop that extra native autosave only
    // after restoring the original pointer and checking the original bytes.
    instance_deactivate_object(UberCont)
}
function scrNTTEFullLairBattleExitNaturalTests() {
    assert(os_type==os_windows && scrNTTEFullSmokeEnabled(),"Lair battle/exit requires dedicated Windows full smoke")
    var _object=asset_get_index("NTTEFullLairBattleExitNaturalTest")
    assert(object_exists(_object) && !instance_exists(_object),"Lair battle observer missing/duplicated")
    var _observer=instance_create(0,0,_object)
    with(_observer) {
        restored=false;scratch_files=[];old_global_vars=[];want_fire=false;want_move=false
        old_directory=game_directory;old_smoke=global.ntte_smoke_active
        old_continue=file_exists(savegame_file)?buffer_load(savegame_file):-1
        old_seed=random_get_seed();old_game_speed=game_get_speed(gamespeed_fps);old_clock=current_frame
        old_save_map=UberCont.saveData;old_savedata=ds_map_write(old_save_map)
        old_uber=scrNTTEFullAreaGeneratorSnapshot(UberCont)
        var _names=variable_struct_get_names(global),_graph={nodes:[]}
        for(var _i=0;_i<array_length(_names);++_i) {
            var _name=_names[_i],_value=variable_global_get(_name)
            array_push(old_global_vars,[_name,_value]);scrNTTEFullAreaSnapshotContainer(_value,_graph)
        }
        old_global_graph={instances:[],containers:_graph.nodes}
        fixture_save_map=ds_map_create();ds_map_copy(fixture_save_map,old_save_map);UberCont.saveData=fixture_save_map
        scratch_root=working_directory+"lair-battle-exit-"+string(get_timer())+"/";directory_create(scratch_root)
        rates=[30,60];pass_index=0;phase=0;elapsed=0;draw_frames=0;world_ready_draw=-1;next_diagnostic=120
        current_seed=6123;room_ends=0;room_starts=0;bot_path=path_add()
        player=noone;hole=noone;bot_was_fire=false;bot_path_clock=0;bot_path_cursor=0
        bot_input_calls=0;bot_input_matched=0;bot_last_index=-1;bot_decisions=0;
        bot_last_decision=undefined;bot_last_plan=undefined;
        // BEGIN LAIR NATIVE MASK FALLBACK STATE
        bot_native_points=[];bot_native_cursor=1;bot_native_context="";
        bot_native_goal=[0,0];bot_native_active=false;bot_native_last=undefined;
        // END LAIR NATIVE MASK FALLBACK STATE
        ui_key=-1;ui_cooldown=0;ui_selections=0;silver_selected=false;ui_token_pending=false;ui_token_serial=0;ui_samples=0;ui_sample_key=-1;
        ui_sample_serial=0;ui_sample_target=noone;ui_target=noone;ui_target_skill=-1
        smoke_drivers=scrNTTEFullInstances(NTTESmokeTest)
        with(NTTESmokeTest) instance_deactivate_object(id)
        global.ntte_smoke_active=false
        scrNTTEFullLairBattleExitClear()
    }
}
function scrNTTEFullLairBattleExitAwait(_phase) {phase=_phase;elapsed=0;world_ready_draw=-1;next_diagnostic=120}
function scrNTTEFullLairBattleExitWorldReady() {
    if(instance_exists(GenCont) || instance_exists(FloorMaker)) {world_ready_draw=-1;return false;}
    if(world_ready_draw<0) {world_ready_draw=draw_frames;return false;}
    return draw_frames-world_ready_draw>=8
}
function scrNTTEFullLairBattleExitRate(_where) {
    assert(game_get_speed(gamespeed_fps)==rates[pass_index] && timescale==30/rates[pass_index]
        && UberCont.opt_framerate==rates[pass_index] && !UberCont.opt_autopause
        && UberCont.saveData==fixture_save_map && ds_map_write(old_save_map)==old_savedata
        && save_get_value("options","framerate",-1)==rates[pass_index]
        && !save_get_value("options","autopause",true),"Native rate/options isolation failed at "+_where)
}
function scrNTTEFullLairBattleExitFireBefore(_weapon) {
    var _observer=instance_find(NTTEFullLairBattleExitNaturalTest,0)
    if(!instance_exists(_observer) || (_observer.phase<2 || _observer.phase>3) || id!=_observer.player) return undefined;
    assert(_weapon==wep_auto_crossbow && infammo==0 && !global.__debug_infammo,
        "Lair battle fixture changed legal initial weapon or bypassed native ammo")
    return {before:scrNTTEFullInstances(Bolt),ammo:ammo[Ammo.Bolts]}
}
function scrNTTEFullLairBattleExitFireAfter(_sample) {
    if(!is_struct(_sample)) return;
    var _observer=instance_find(NTTEFullLairBattleExitNaturalTest,0)
    if(!instance_exists(_observer) || (_observer.phase<2 || _observer.phase>3) || id!=_observer.player) return;
    var _shots=scrNTTEFullInstances(Bolt),_new=0
    for(var _i=0;_i<array_length(_shots);++_i) {
        var _shot=_shots[_i]
        if(array_get_index(_sample.before,_shot)>=0 || _shot.creator!=id) continue
        assert(_shot.object_index==Bolt && _shot.damage==20 && _shot.speed>0
            && point_distance(_shot.x,_shot.y,x,y)<40,"Original moving AutoCrossbow Bolt20 missing")
        array_push(_observer.native_shots,{shot:_shot,x:_shot.x,y:_shot.y,damage:_shot.damage});_new++
    }
    if(_new==0) {
        assert(ammo[Ammo.Bolts]==_sample.ammo,"No-shot native firing attempt consumed ammo");return;
    }
    assert(_new==1 && ammo[Ammo.Bolts]==_sample.ammo-scr_weapon_get_cost(wep_auto_crossbow)
        && reload==scr_weapon_get_load(wep_auto_crossbow) && !can_shoot,
        "Native original fire omitted source cost/reload or created extra projectiles")
    _observer.shot_count++;_observer.ammo_spent+=scr_weapon_get_cost(wep_auto_crossbow)
}
function scrNTTEFullLairBattleExitBulletBefore(_target) {
    var _o=instance_find(NTTEFullLairBattleExitNaturalTest,0)
    if(!instance_exists(_o) || _o.restored || _o.phase<2 || _o.phase>3
        || creator!=_o.player || !instance_exists(_target)
        || !instance_is(_target,enemy) || _target.team==team_player || _target.hp<=0) return undefined;
    var _record=undefined
    for(var _i=0;_i<array_length(_o.native_shots);++_i)
        if(_o.native_shots[_i].shot==id) {_record=_o.native_shots[_i];break}
    assert(is_struct(_record) && object_index==Bolt && damage==20 && damage==_record.damage
        && point_distance(x,y,_record.x,_record.y)>1,"Lair hit lacks actual moving native Bolt20 firing/travel provenance")
    return {target:_target,hp:_target.hp,kind:_target.object_index}
}
function scrNTTEFullLairBattleExitBulletAfter(_sample) {
    if(!is_struct(_sample)) return;
    var _o=instance_find(NTTEFullLairBattleExitNaturalTest,0)
    if(!instance_exists(_o) || _o.restored) return;
    var _loss=instance_exists(_sample.target)?max(0,_sample.hp-max(0,_sample.target.hp)):_sample.hp
    assert(_loss==0 || _loss==min(20,_sample.hp),"Native Lair Bolt20 changed source unmodified weapon damage")
    if(_loss<=0) return;
    _o.native_hits++;_o.native_damage+=_loss
    if(_sample.kind==NTTEFullCatBoss) {_o.cat_hits++;_o.cat_damage+=_loss}
    else if(_sample.kind==NTTEFullBatBoss) {_o.bat_hits++;_o.bat_damage+=_loss}
    else {_o.population_hits++;_o.population_damage+=_loss}
}
// Called immediately around the unchanged native accepted hp subtraction.
// Read-only victim/caller snapshots distinguish Bolt provenance from gas and
// every other source-legal caller; overkill never supplies extra effective HP.
function scrNTTEFullLairBattleExitBossLossBefore(_amount,_hitid,_caller,_raw) {
    var _o=instance_find(NTTEFullLairBattleExitNaturalTest,0)
    if(!instance_exists(_o) || _o.restored || _o.phase<2 || _o.phase>3
        || (!instance_is(id,NTTEFullCatBoss) && !instance_is(id,NTTEFullBatBoss))) return undefined;
    return {target:id,kind:object_index,hp_before:hp,max_hp:max_hp,frame:current_frame,
        amount:_amount,hitid:json_stringify(_hitid),raw:_raw,caller:_caller,
        caller_kind:instance_exists(_caller)?_caller.object_index:-1,
        creator:instance_exists(_caller) && variable_instance_exists(_caller,"creator")?_caller.creator:noone}
}
function scrNTTEFullLairBattleExitBossLossAfter(_sample) {
    if(!is_struct(_sample)) return;
    var _o=instance_find(NTTEFullLairBattleExitNaturalTest,0)
    if(!instance_exists(_o) || _o.restored) return;
    assert(id==_sample.target && hp==_sample.hp_before-_sample.amount,
        "Accepted native Boss hp subtraction changed between read-only samples")
    _sample.hp_after=hp;_sample.loss=_sample.hp_before-hp
    _sample.effective_loss=max(0,min(max(0,_sample.hp_before),_sample.loss))
    if(_sample.loss<=0) return;
    array_push(_o.boss_loss_ledger,_sample)
    if(_sample.kind==NTTEFullCatBoss) _o.cat_native_loss+=_sample.effective_loss
    else _o.bat_native_loss+=_sample.effective_loss
    scrNTTESmokeLog("LAIR BATTLE EXIT native accepted Boss loss "+json_stringify(_sample))
}
function scrNTTEFullLairBattleExitCheckLossLedger() {
    var _cat_loss=0,_bat_loss=0
    for(var _i=0;_i<array_length(boss_loss_ledger);++_i) {
        var _record=boss_loss_ledger[_i]
        assert(_record.loss>0 && _record.hp_after==_record.hp_before-_record.amount
            && _record.loss==_record.amount
            && _record.effective_loss==max(0,min(max(0,_record.hp_before),_record.loss)),
            "Native accepted Boss loss ledger record lost its exact subtraction provenance")
        assert(_record.kind==NTTEFullCatBoss || _record.kind==NTTEFullBatBoss,
            "Native Boss ledger recorded another target kind")
        if(_record.kind==NTTEFullCatBoss) _cat_loss+=_record.effective_loss
        else _bat_loss+=_record.effective_loss
    }
    assert(_cat_loss==cat_native_loss && _bat_loss==bat_native_loss && _cat_loss>=200 && _bat_loss>=200,
        "Native Boss effective loss total differs from preserved accepted-loss records")
}
// BEGIN LAIR NAVIGATION READONLY HELPERS
function scrNTTEFullLairBattleExitActorRead(_actor) {
    if(!instance_exists(_actor)) return {id:_actor,exists:false};
    return {id:_actor,exists:true,object:_actor.object_index,xy:[_actor.x,_actor.y],
        bbox:[_actor.bbox_left,_actor.bbox_top,_actor.bbox_right,_actor.bbox_bottom],
        sprite:_actor.sprite_index,mask:_actor.mask_index,visible:_actor.visible,
        scale:[_actor.image_xscale,_actor.image_yscale],angle:_actor.image_angle,
        hp:scrNTTEFullValue(_actor,"hp",undefined),team:scrNTTEFullValue(_actor,"team",undefined),
        index:scrNTTEFullValue(_actor,"index",undefined),can_walk:scrNTTEFullValue(_actor,"can_walk",undefined),
        can_aim:scrNTTEFullValue(_actor,"can_aim",undefined),can_shoot:scrNTTEFullValue(_actor,"can_shoot",undefined)}
}
function scrNTTEFullLairBattleExitPointRead(_px,_py) {
    var _wall=false,_floor=false
    with(player) {_wall=place_meeting(_px,_py,Wall);_floor=place_meeting(_px,_py,Floor);}
    return {xy:[_px,_py],wall:_wall,floor:_floor,center_floor:position_meeting(_px,_py,Floor)}
}
function scrNTTEFullLairBattleExitSegmentRead(_x1,_y1,_x2,_y2,_budget) {
    var _steps=max(1,ceil(point_distance(_x1,_y1,_x2,_y2)/2))
    for(var _i=0;_i<=_steps;++_i) {
        if(_budget.remaining<=0) {_budget.exhausted=true;return {complete:false,legal:false,rule:"budget"};}
        _budget.remaining--;_budget.samples++
        var _px=lerp(_x1,_x2,_i/_steps),_py=lerp(_y1,_y2,_i/_steps),_point=scrNTTEFullLairBattleExitPointRead(_px,_py)
        if(_point.wall || !_point.floor) return {complete:true,legal:false,rule:"wall_or_floor",sample:_i,steps:_steps,point:_point};
    }
    return {complete:true,legal:true,steps:_steps}
}
function scrNTTEFullLairBattleExitPlanRead(_grid,_left,_top,_width,_height,_gx,_gy) {
    var _sx=floor((player.x-_left)/8),_sy=floor((player.y-_top)/8),
        _tx=floor((_gx-_left)/8),_ty=floor((_gy-_top)/8),_start_cell=undefined,_goal_cell=undefined,_points=[]
    if(_sx>=0 && _sy>=0 && _sx<_width && _sy<_height) _start_cell=mp_grid_get_cell(_grid,_sx,_sy)
    if(_tx>=0 && _ty>=0 && _tx<_width && _ty<_height) _goal_cell=mp_grid_get_cell(_grid,_tx,_ty)
    var _count=path_get_number(bot_path)
    for(var _i=0;_i<min(1024,_count);++_i) array_push(_points,[path_get_point_x(bot_path,_i),path_get_point_y(bot_path,_i)])
    bot_last_plan={frame:current_frame,phase:phase,elapsed:elapsed,origin:[_left,_top],dimensions:[_width,_height],
        start:scrNTTEFullLairBattleExitPointRead(player.x,player.y),goal:scrNTTEFullLairBattleExitPointRead(_gx,_gy),
        start_cell:[_sx,_sy],goal_cell:[_tx,_ty],start_occupancy:_start_cell,goal_occupancy:_goal_cell,
        count:_count,points:_points,points_complete:_count<=1024}
}
function scrNTTEFullLairBattleExitNavigationRead() {
    var _required=["bot_input_calls","bot_input_matched","bot_last_index","bot_decisions","bot_last_decision","bot_last_plan"]
    for(var _field=0;_field<array_length(_required);++_field)
        if(!variable_instance_exists(id,_required[_field])) return {ready:false,missing:_required[_field]};
    if(!instance_exists(player)) return {ready:false,player:false};
    var _target=is_struct(bot_last_decision)?bot_last_decision.target:noone,
        _goal=is_struct(bot_last_decision)?bot_last_decision.goal:noone,_hostiles=[],_hostile_count=0,
        _orbit=[],_walls=[],_budget={remaining:4096,samples:0,exhausted:false},_waypoint=undefined,
        _bbox=[player.bbox_left,player.bbox_top,player.bbox_right,player.bbox_bottom]
    with(enemy) if(team!=team_player && hp>0) {
        _hostile_count++
        if(array_length(_hostiles)<256) {
            var _ax=(bbox_left+bbox_right-1)/2,_ay=(bbox_top+bbox_bottom-1)/2,
                _distance=point_distance(x,y,other.player.x,other.player.y),
                _center_sight=!collision_line(x,y,other.player.x,other.player.y,Wall,false,false)
            array_push(_hostiles,{actor:scrNTTEFullLairBattleExitActorRead(id),distance:_distance,
                skip_van:instance_is(id,Van),skip_missile:instance_is(id,BigDogMissile),
                center_sight:_center_sight,
                bbox_sight:!collision_line(other.player.x,other.player.y,_ax,_ay,Wall,false,false),
                selector_cost:_distance+((visible && mask_index!=mskNone && _center_sight)?0:256)})
        }
    }
    with(Wall) if(bbox_right>=_bbox[0]-64 && bbox_left<=_bbox[2]+64
        && bbox_bottom>=_bbox[1]-64 && bbox_top<=_bbox[3]+64)
        array_push(_walls,{id:id,xy:[x,y],bbox:[bbox_left,bbox_top,bbox_right,bbox_bottom],mask:mask_index})
    if(instance_exists(_target)) {
        var _d=point_distance(player.x,player.y,_target.x,_target.y),
            _away=point_direction(_target.x,_target.y,player.x,player.y),_base=_away+(_d<100?0:70)
        for(var _i=0;_i<8;++_i) {
            var _dir=_base+45*_i,_gx=player.x+lengthdir_x(48,_dir),_gy=player.y+lengthdir_y(48,_dir)
            array_push(_orbit,{direction:_dir,goal:scrNTTEFullLairBattleExitPointRead(_gx,_gy),
                original_center_line_clear:!collision_line(player.x,player.y,_gx,_gy,Wall,false,false),
                actual_mask_segment:scrNTTEFullLairBattleExitSegmentRead(player.x,player.y,_gx,_gy,_budget)})
        }
    }
    var _point_count=path_get_number(bot_path)
    if(_point_count>0) {
        var _cursor=clamp(bot_path_cursor,0,_point_count-1),
            _wx=path_get_point_x(bot_path,_cursor),_wy=path_get_point_y(bot_path,_cursor)
        _waypoint={cursor:_cursor,point:scrNTTEFullLairBattleExitPointRead(_wx,_wy),
            segment:scrNTTEFullLairBattleExitSegmentRead(player.x,player.y,_wx,_wy,_budget)}
    }
    return {ready:true,mode:"navigation reads; rejected grid native-mask fallback enabled",frame:current_frame,
        calls:bot_input_calls,matched:bot_input_matched,last_index:bot_last_index,decisions:bot_decisions,
        player:scrNTTEFullLairBattleExitActorRead(player),player_mask:scrNTTEFullLairBattleExitPointRead(player.x,player.y),
        selected:scrNTTEFullLairBattleExitActorRead(_target),goal:scrNTTEFullLairBattleExitActorRead(_goal),
        last_decision:bot_last_decision,last_plan:bot_last_plan,hostiles:_hostiles,
        hostile_count:_hostile_count,hostiles_complete:_hostile_count<=256,nearby_walls:_walls,
        orbit:_orbit,waypoint:_waypoint,budget:_budget}
}
// END LAIR NAVIGATION READONLY HELPERS
// BEGIN LAIR NATIVE MASK FALLBACK HELPERS
function scrNTTEFullLairBattleExitNativeContext() {
    return json_stringify({phase:phase,player:player.id,mask:player.mask_index,
        sprite:player.mask_index<0?player.sprite_index:player.mask_index,
        scale:[player.image_xscale,player.image_yscale],angle:player.image_angle,
        walls:instance_number(Wall),floors:instance_number(Floor)})
}
function scrNTTEFullLairBattleExitNativeSegment(_x1,_y1,_x2,_y2,_budget) {
    var _steps=max(1,ceil(point_distance(_x1,_y1,_x2,_y2)/2))
    for(var _i=0;_i<=_steps;++_i) {
        if(_budget.remaining<=0) {_budget.exhausted=true;return false;}
        _budget.remaining--;_budget.samples++
        var _px=lerp(_x1,_x2,_i/_steps),_py=lerp(_y1,_y2,_i/_steps),_wall=false,_floor=false
        with(player) {_wall=place_meeting(_px,_py,Wall);_floor=place_meeting(_px,_py,Floor);}
        if(_wall) {_budget.wall++;return false;}
        if(!_floor) {_budget.floor_missing++;return false;}
    }
    return true
}
function scrNTTEFullLairBattleExitNativeGraph(_left,_top,_right,_bottom,_gx,_gy,_cell) {
    var _columns=ceil((_right+64-_left)/_cell),_rows=ceil((_bottom+64-_top)/_cell),_total=_columns*_rows,
        _budget={remaining:750000,samples:0,wall:0,floor_missing:0,exhausted:false},
        _result={found:false,status:"no_lattice_route",cell:_cell,columns:_columns,rows:_rows,nodes:0,edges:0,
            start_valid:false,goal_valid:false,start_connectors:0,goal_connectors:0,
            budget:_budget,points:[],whole_path_legal:false}
    // A rejected lattice/finite budget never proves no continuous world route.
    if(_total<=0 || _total>60000) {_result.status="unknown_node_budget";return _result;}
    var _sx=player.x,_sy=player.y
    _result.start_valid=scrNTTEFullLairBattleExitNativeSegment(_sx,_sy,_sx,_sy,_budget)
    _result.goal_valid=scrNTTEFullLairBattleExitNativeSegment(_gx,_gy,_gx,_gy,_budget)
    if(!_result.start_valid || !_result.goal_valid) {_result.status="invalid_endpoint";return _result;}
    var _known=array_create(_total,0),_parent=array_create(_total,-2),_queue=[],_head=0,
        _start_x=floor((_sx-_left)/_cell),_start_y=floor((_sy-_top)/_cell),_end=-1
    // The real Player stays where native movement left it; virtual connectors
    // validate every sample from that exact position to nearby lattice nodes.
    for(var _dy=-2;_dy<=2;++_dy) for(var _dx=-2;_dx<=2;++_dx) {
        var _cx=_start_x+_dx,_cy=_start_y+_dy
        if(_cx<0 || _cy<0 || _cx>=_columns || _cy>=_rows) continue
        var _index=_cy*_columns+_cx,_px=_left+(_cx+0.5)*_cell,_py=_top+(_cy+0.5)*_cell
        _result.edges++
        if(scrNTTEFullLairBattleExitNativeSegment(_sx,_sy,_px,_py,_budget)) {
            _known[_index]=1;_parent[_index]=-1;array_push(_queue,_index);_result.start_connectors++
        }
        if(_budget.exhausted) {_result.status="unknown_sample_budget";return _result;}
    }
    var _dxs=[-1,1,0,0],_dys=[0,0,-1,1]
    while(_head<array_length(_queue) && !_budget.exhausted) {
        var _index=_queue[_head++],_cx=_index mod _columns,_cy=floor(_index/_columns),
            _px=_left+(_cx+0.5)*_cell,_py=_top+(_cy+0.5)*_cell
        _result.nodes++
        if(abs(_px-_gx)<=_cell*2 && abs(_py-_gy)<=_cell*2) {
            _result.edges++;_result.goal_connectors++
            if(scrNTTEFullLairBattleExitNativeSegment(_px,_py,_gx,_gy,_budget)) {_end=_index;break;}
        }
        for(var _direction=0;_direction<4;++_direction) {
            var _nx=_cx+_dxs[_direction],_ny=_cy+_dys[_direction]
            if(_nx<0 || _ny<0 || _nx>=_columns || _ny>=_rows) continue
            var _next=_ny*_columns+_nx
            if(_parent[_next]!=-2 || _known[_next]<0) continue
            var _tx=_left+(_nx+0.5)*_cell,_ty=_top+(_ny+0.5)*_cell
            if(_known[_next]==0)
                _known[_next]=scrNTTEFullLairBattleExitNativeSegment(_tx,_ty,_tx,_ty,_budget)?1:-1
            if(_known[_next]<0) continue
            _result.edges++
            if(scrNTTEFullLairBattleExitNativeSegment(_px,_py,_tx,_ty,_budget)) {
                _parent[_next]=_index;array_push(_queue,_next)
            }
        }
    }
    if(_budget.exhausted) {_result.status="unknown_sample_budget";return _result;}
    if(_end<0) return _result;
    var _reverse=[],_cursor=_end,_guard=0
    while(_cursor>=0 && _guard<_total) {
        array_push(_reverse,[_left+((_cursor mod _columns)+0.5)*_cell,
            _top+(floor(_cursor/_columns)+0.5)*_cell]);_cursor=_parent[_cursor];_guard++
    }
    if(_cursor!=-1) {_result.status="unknown_parent_budget";return _result;}
    var _points=[[_sx,_sy]]
    for(var _i=array_length(_reverse)-1;_i>=0;--_i) array_push(_points,_reverse[_i])
    array_push(_points,[_gx,_gy])
    // Independently re-read the entire proposed path, both exact endpoint
    // connectors included; partial/budget-limited validation is never found.
    for(var _i=1;_i<array_length(_points);++_i) {
        if(!scrNTTEFullLairBattleExitNativeSegment(_points[_i-1][0],_points[_i-1][1],
            _points[_i][0],_points[_i][1],_budget)) {
            _result.status=_budget.exhausted?"unknown_sample_budget":"path_revalidation";return _result;
        }
    }
    _result.found=true;_result.status="found";_result.points=_points;_result.whole_path_legal=true
    return _result
}
function scrNTTEFullLairBattleExitNativePlan(_left,_top,_right,_bottom,_gx,_gy) {
    var _cells=[8,4],_answer=undefined
    for(var _i=0;_i<array_length(_cells);++_i) {
        _answer=scrNTTEFullLairBattleExitNativeGraph(_left,_top,_right,_bottom,_gx,_gy,_cells[_i])
        bot_native_last={rate:rates[pass_index],phase:phase,elapsed:elapsed,xy:[player.x,player.y],goal:[_gx,_gy],
            original_grid_count:path_get_number(bot_path),cell:_answer.cell,dimensions:[_answer.columns,_answer.rows],
            status:_answer.status,found:_answer.found,nodes:_answer.nodes,edges:_answer.edges,
            start_valid:_answer.start_valid,goal_valid:_answer.goal_valid,
            start_connectors:_answer.start_connectors,goal_connectors:_answer.goal_connectors,
            budget:_answer.budget,points:array_length(_answer.points),whole_path_legal:_answer.whole_path_legal}
        scrNTTESmokeLog("LAIR NATIVE MASK ROUTE "+json_stringify(bot_native_last))
        if(_answer.found || _answer.status=="invalid_endpoint") break;
    }
    return _answer
}
function scrNTTEFullLairBattleExitNativeFollow() {
    var _points=bot_native_points,_last=array_length(_points)-1,
        _budget={remaining:4096,samples:0,wall:0,floor_missing:0,exhausted:false},_chosen=-1
    // Only a newly read actual-position connector may skip waypoints; the
    // original6px proximity shortcut is deliberately absent from this route.
    for(var _i=min(_last,bot_native_cursor+8);_i>=bot_native_cursor;--_i) {
        if(point_distance(player.x,player.y,_points[_i][0],_points[_i][1])>96) continue
        if(scrNTTEFullLairBattleExitNativeSegment(player.x,player.y,_points[_i][0],_points[_i][1],_budget)) {
            _chosen=_i;break;
        }
    }
    if(_chosen<0 || _budget.exhausted) {
        bot_native_active=false;bot_path_clock=0
        scrNTTESmokeLog("LAIR NATIVE MASK FOLLOW REPLAN "+json_stringify({rate:rates[pass_index],phase:phase,
            xy:[player.x,player.y],cursor:bot_native_cursor,budget:_budget}))
        return [false,0]
    }
    bot_native_cursor=_chosen
    if(point_distance(player.x,player.y,_points[_chosen][0],_points[_chosen][1])<=0.5) {
        bot_native_active=false;bot_path_clock=0;return [false,0];
    }
    return [true,point_direction(player.x,player.y,_points[_chosen][0],_points[_chosen][1])]
}
// END LAIR NATIVE MASK FALLBACK HELPERS
function scrNTTEFullLairBattleExitWalk(_gx,_gy) {
    var _distance=point_distance(player.x,player.y,_gx,_gy)
    if(_distance<5) return [false,0];
    var _direction=point_direction(player.x,player.y,_gx,_gy)
    var _clear=!collision_line(player.x,player.y,_gx,_gy,Wall,false,false)
    if(_clear) return [true,_direction];
    bot_path_clock-=timescale
    if(bot_path_clock<=0 || point_distance(_gx,_gy,path_goal_x,path_goal_y)>24) {
        bot_path_clock=15;bot_path_cursor=1;path_goal_x=_gx;path_goal_y=_gy
        var _left=infinity,_top=infinity,_right=-infinity,_bottom=-infinity
        with(Floor) {_left=min(_left,bbox_left);_top=min(_top,bbox_top)
            _right=max(_right,bbox_right);_bottom=max(_bottom,bbox_bottom)}
        assert(_left<infinity,"Lair bot lost native floor graph")
        _left=floor((_left-64)/8)*8;_top=floor((_top-64)/8)*8
        var _grid=mp_grid_create(_left,_top,ceil((_right+64-_left)/8),ceil((_bottom+64-_top)/8),8,8)
        with(Wall) mp_grid_add_rectangle(_grid,bbox_left-5,bbox_top-3,bbox_right+5,bbox_bottom+3)
        path_clear_points(bot_path)
        mp_grid_path(_grid,bot_path,player.x,player.y,_gx,_gy,false);
        // BEGIN LAIR NAVIGATION READONLY ORIGINAL PLAN
        try {scrNTTEFullLairBattleExitPlanRead(_grid,_left,_top,
            ceil((_right+64-_left)/8),ceil((_bottom+64-_top)/8),_gx,_gy);}
        catch(_ntte_lair_plan_read_error) {bot_last_plan={error:string(_ntte_lair_plan_read_error)};}
        // END LAIR NAVIGATION READONLY ORIGINAL PLAN
        mp_grid_destroy(_grid)
        // BEGIN LAIR NATIVE MASK FALLBACK PLAN
        if(path_get_number(bot_path)<=1) {
            var _context=scrNTTEFullLairBattleExitNativeContext()
            if(!bot_native_active || bot_native_context!=_context
                || point_distance(_gx,_gy,bot_native_goal[0],bot_native_goal[1])>24) {
                bot_native_active=false;bot_native_points=[]
                var _answer=scrNTTEFullLairBattleExitNativePlan(_left,_top,_right,_bottom,_gx,_gy)
                if(_answer.found && _answer.whole_path_legal) {
                    bot_native_points=_answer.points;bot_native_cursor=1;bot_native_context=_context;
                    bot_native_goal=[_gx,_gy];bot_native_active=true
                }
            }
        }
        else bot_native_active=false
        // END LAIR NATIVE MASK FALLBACK PLAN
    }
    // BEGIN LAIR NATIVE MASK FALLBACK FOLLOW
    if(path_get_number(bot_path)<=1 && bot_native_active) {
        if(bot_native_context!=scrNTTEFullLairBattleExitNativeContext()
            || point_distance(_gx,_gy,bot_native_goal[0],bot_native_goal[1])>24) {
            bot_native_active=false;bot_path_clock=0;return [false,0];
        }
        return scrNTTEFullLairBattleExitNativeFollow();
    }
    // END LAIR NATIVE MASK FALLBACK FOLLOW
    if(path_get_number(bot_path)<=1) return [false,0];
    while(bot_path_cursor<path_get_number(bot_path)-1
        && point_distance(player.x,player.y,path_get_point_x(bot_path,bot_path_cursor),path_get_point_y(bot_path,bot_path_cursor))<6)
        bot_path_cursor++
    return [true,point_direction(player.x,player.y,path_get_point_x(bot_path,bot_path_cursor),path_get_point_y(bot_path,bot_path_cursor))]
}
function scrNTTEFullLairBattleExitBotAfterSample(_keycont,_index) {
    var _o=instance_find(NTTEFullLairBattleExitNaturalTest,0)
    // BEGIN LAIR NAVIGATION READONLY INPUT COUNTERS
    if(instance_exists(_o) && variable_instance_exists(_o,"bot_input_calls") && !_o.restored) {
        _o.bot_input_calls++;_o.bot_last_index=_index
        if(instance_exists(_o.player) && _o.player.index==_index) _o.bot_input_matched++
    }
    // END LAIR NAVIGATION READONLY INPUT COUNTERS
    if(!instance_exists(_o) || _o.restored || !instance_exists(_o.player) || _o.player.index!=_index) return;
    var _fire=false,_walk=[false,0],_aim=0
    if(_o.phase>=2 && _o.phase<=4 && !instance_exists(GenCont) && !instance_exists(LevCont)) with(_o) {
        var _target=noone,_score=infinity,_goal=noone
        with(enemy) {
            if(team==team_player || hp<=0 || instance_is(id,Van) || instance_is(id,BigDogMissile)) continue
            var _d=point_distance(x,y,other.player.x,other.player.y)
            var _visible=visible && mask_index!=mskNone
                && !collision_line(x,y,other.player.x,other.player.y,Wall,false,false)
            var _cost=_d+(_visible?0:256)
            if(_cost<_score) {_score=_cost;_target=id}
        }
        // Resupply uses existing native pickup/chest contacts. No grants,
        // inventory edits, new pickups or direct pickup callbacks occur here.
        if(player.hp<=4) {
            _goal=instance_nearest(player.x,player.y,HPPickup)
            if(!instance_exists(_goal)) _goal=instance_nearest(player.x,player.y,HealthChest)
        }
        if(!instance_exists(_goal) && player.ammo[Ammo.Bolts]<10) {
            _goal=instance_nearest(player.x,player.y,AmmoPickup)
            if(!instance_exists(_goal)) _goal=instance_nearest(player.x,player.y,AmmoChest)
        }
        if(instance_exists(_target)) {
            var _ax=(_target.bbox_left+_target.bbox_right-1)/2,
                _ay=(_target.bbox_top+_target.bbox_bottom-1)/2,
                _d=point_distance(player.x,player.y,_target.x,_target.y),
                _sight=!collision_line(player.x,player.y,_ax,_ay,Wall,false,false)
            _aim=point_direction(player.x,player.y,_ax,_ay)
            _fire=_target.visible && _target.mask_index!=mskNone && _sight && _d<300
                && player.ammo[Ammo.Bolts]>0
            if(!instance_exists(_goal)) {
                if(_sight && _d<192 && _target.visible && _target.mask_index!=mskNone) {
                    var _away=point_direction(_target.x,_target.y,player.x,player.y),
                        _orbit=_away+(_d<100?0:70),_found=false
                    for(var _try=0;_try<8;++_try) {
                        var _dir=_orbit+45*_try,
                            _gx=player.x+lengthdir_x(48,_dir),_gy=player.y+lengthdir_y(48,_dir)
                        if(instance_exists(collision_point(_gx,_gy,Floor,false,false))
                            && !collision_line(player.x,player.y,_gx,_gy,Wall,false,false)) {
                            _walk=[true,_dir];_found=true;break
                        }
                    }
                    if(!_found) _walk=[false,0]
                }
                else _walk=scrNTTEFullLairBattleExitWalk(_target.x,_target.y)
            }
        }
        else if(phase==2 && instance_exists(hole)) _goal=hole
        else if(phase==4 && instance_exists(exit_portal) && !exit_portal.close) _goal=exit_portal
        if(instance_exists(_goal)) _walk=scrNTTEFullLairBattleExitWalk(_goal.x,_goal.y)
        // BEGIN LAIR NAVIGATION READONLY DECISION
        bot_decisions++
        bot_last_decision={frame:current_frame,phase:phase,elapsed:elapsed,target:_target,goal:_goal,
            score:_score,fire:_fire,walk:_walk,aim:_aim,path_clock:bot_path_clock,
            path_cursor:bot_path_cursor,path_points:path_get_number(bot_path)}
        // END LAIR NAVIGATION READONLY DECISION
        if(_fire) bot_fire_samples++
        if(_walk[0]) bot_move_samples++
    }
    _keycont.dir_fire[_index]=_aim
    _keycont.press_fire[_index]=_fire && !_o.bot_was_fire
    _keycont.hold_fire[_index]=_fire;_keycont.release_fire[_index]=!_fire && _o.bot_was_fire
    _o.bot_was_fire=_fire
    _keycont.press_swap[_index]=false;_keycont.hold_swap[_index]=false
    _keycont.hold_spec[_index]=false;_keycont.press_spec[_index]=false
    _keycont.hold_pick[_index]=false;_keycont.press_pick[_index]=false
    _keycont.aimassist[_index]=false;_keycont.precisemovement[_index]=true
    _keycont.moving[_index]=_walk[0]?1:0;_keycont.dir_move[_index]=_walk[1]
    _keycont.hold_east[_index]=false;_keycont.hold_west[_index]=false
    _keycont.hold_nort[_index]=false;_keycont.hold_sout[_index]=false
}
// BEGIN LAIR MENU SAMPLE READONLY HELPER
function scrNTTEFullLairBattleExitMenuSample(_stage,_native_index=-1) {
    var _o=instance_find(NTTEFullLairBattleExitNaturalTest,0)
    if(!instance_exists(_o)) return;
    var _required=["restored","exit_started","phase","elapsed","ui_key","rates","pass_index","ui_cooldown","ui_selections"]
    for(var _field=0;_field<array_length(_required);++_field)
        if(!variable_instance_exists(_o,_required[_field])) return;
    if(_o.restored || !_o.exit_started || _o.phase<4 || _o.phase>5) return;
    var _keys=[],_buttons=[],_coops=[],_any_key=false
    for(var _i=0;_i<min(10,instance_number(ParButton));++_i) {
        var _button=instance_find(ParButton,_i),_key=ord(string(_i+1)),
            _held=keyboard_check(_key),_pressed=keyboard_check_pressed(_key)
        _any_key=_any_key || _held || _pressed
        array_push(_keys,{index:_i,key:_key,held:_held,pressed:_pressed,
            native_pressed:scr_keyboard_check_pressed(_key)})
        if(instance_exists(_button)) array_push(_buttons,{index:_i,id:_button,object:_button.object_index,
            skill:scrNTTEFullValue(_button,"skill","<absent>"),selected:scrNTTEFullValue(_button,"selected","<absent>")})
    }
    if(_native_index>=0 && _o.elapsed>48 && _o.ui_key<0 && !_any_key
        && (floor(_o.elapsed) mod 120)>=12) return;
    with(CoopController) array_push(_coops,{id:id,started:started,event_run:event_run})
    scrNTTESmokeLog("LAIR MENU EXACT SAMPLE "+json_stringify({stage:_stage,frame:current_frame,
        timer:get_timer(),rate:_o.rates[_o.pass_index],phase:_o.phase,elapsed:_o.elapsed,
        caller:id,caller_object:object_index,native_index:_native_index,keys:_keys,buttons:_buttons,
        observer_key:_o.ui_key,cooldown:_o.ui_cooldown,ui_selections:_o.ui_selections,
        levcont:instance_number(LevCont),skills:instance_number(SkillIcon),parbuttons:instance_number(ParButton),
        block_frames:UberCont.block_input_frames,keyboard:UberCont.opt_keyboard,gamepad:UberCont.opt_gamepad,
        sampled_keyboard:KeyCont.keyboard[0],sampled_gamepad:KeyCont.gamepad[0],
        typing:scr_keyboard_is_typing(),console:global.console_active,lockstep_stop:lockstep_stop,coops:_coops}))
}
// END LAIR MENU SAMPLE READONLY HELPER
// BEGIN LAIR INJECTED NUMERIC SAMPLE HELPER
function scrNTTEFullLairBattleExitSampleNumeric(_key,_raw,_index) {
    // Preserve the native raw result outside this isolated acceptance seam.
    if(os_type!=os_windows || !scrNTTEFullSmokeEnabled()
        || instance_number(NTTEFullLairBattleExitNaturalTest)!=1) return _raw;
    var _o=instance_find(NTTEFullLairBattleExitNaturalTest,0)
    var _required=["restored","exit_started","contact_seen","phase","room_ends","room_starts",
        "dead_bosses","player","ui_key","ui_token_pending","ui_token_serial","ui_samples",
        "ui_sample_key","ui_sample_serial","ui_sample_target","ui_target","ui_target_skill","ui_selections","rates","pass_index"]
    for(var _field=0;_field<array_length(_required);++_field)
        if(!variable_instance_exists(_o,_required[_field])) return _raw;
    if(_o.restored || _o.phase!=5 || !_o.exit_started || !_o.contact_seen
        || _o.room_ends!=1 || _o.room_starts!=1 || _o.dead_bosses!=2
        || !instance_exists(_o.player) || _index!=_o.player.index || id!=UberCont.id
        || !UberCont.opt_keyboard || UberCont.opt_gamepad || UberCont.block_input_frames!=0
        || scr_keyboard_is_typing() || global.console_active || lockstep_stop
        || !_o.ui_token_pending || _key!=_o.ui_key || !instance_exists(LevCont)
        || GameCont.skillpoints<=0) return _raw;
    var _slot=_key-ord("1")
    if(_slot<0 || _slot>=min(10,instance_number(ParButton))) return _raw;
    var _button=instance_find(ParButton,_slot)
    if(!instance_exists(_button) || !instance_is(_button,SkillIcon)
        || _button!=_o.ui_target || _button.skill!=_o.ui_target_skill) return _raw;
    assert(_o.ui_samples==_o.ui_selections && _o.ui_token_serial==_o.ui_samples+1,
        "Injected numeric token duplicated or previous native selection did not complete")
    _o.ui_token_pending=false;_o.ui_samples++
    _o.ui_sample_key=_key;_o.ui_sample_serial=_o.ui_token_serial;_o.ui_sample_target=_button
    scrNTTESmokeLog("LAIR MENU INJECTED SAMPLED NUMERIC INPUT "+json_stringify({
        frame:current_frame,rate:_o.rates[_o.pass_index],phase:_o.phase,index:_index,key:_key,raw:_raw,token:_o.ui_token_serial,
        samples:_o.ui_samples,selections_before:_o.ui_selections,button:_button,skill:_button.skill,
        mode:"injected sampled numeric input; physical keyboard untested"}))
    return true
}
// END LAIR INJECTED NUMERIC SAMPLE HELPER
function scrNTTEFullLairBattleExitMenuInput() {
    if(ui_key>=0) {
        if(ui_token_pending) return; // Retain until the native sampler consumes it.
        assert(ui_samples==ui_selections,"Consumed numeric token lacks completed native choice")
        scrNTTEFullLairBattleExitMenuSample("observer.token.retired")
        ui_key=-1;ui_target=noone;ui_target_skill=-1;ui_cooldown=8;return;
    }
    ui_cooldown-=timescale
    if(ui_cooldown>0 || phase!=5 || !exit_started || !instance_exists(LevCont)) return;
    // The original InputHandling numeric-key branch performs selection and
    // dispatch. This observer never writes icon.selected or invokes events.
    var _chosen=-1,_fallback=-1
    for(var _i=0;_i<min(9,instance_number(ParButton));++_i) {
        var _button=instance_find(ParButton,_i)
        if(!instance_is(_button,SkillIcon)) continue
        if(_fallback<0) _fallback=_i
        if(_button.skill==NTTEFullSkill.SilverTongue) {_chosen=_i;break}
    }
    if(_chosen<0 && silver_selected) _chosen=_fallback
    if(_chosen<0) return;
    assert(!ui_token_pending && ui_samples==ui_selections && ui_token_serial==ui_samples,
        "New injected numeric token overlaps unfinished native selection")
    ui_key=ord(string(_chosen+1));ui_target=instance_find(ParButton,_chosen);ui_target_skill=ui_target.skill
    ui_token_serial++;ui_token_pending=true
    scrNTTEFullLairBattleExitMenuSample("observer.token.created")
}
function scrNTTEFullLairBattleExitDiagnostic(_where) {
    // BEGIN LAIR NAVIGATION READONLY DIAGNOSTIC CALL
    var _navigation_read=undefined
    try {_navigation_read=scrNTTEFullLairBattleExitNavigationRead();}
    catch(_ntte_lair_navigation_read_error) {_navigation_read={error:string(_ntte_lair_navigation_read_error)};}
    // END LAIR NAVIGATION READONLY DIAGNOSTIC CALL
    // BEGIN LAIR REWARD MENU READONLY DIAGNOSTIC
    var _menu_families=[LevCont,SkillIcon,ParButton],_menu_instances=[[],[],[]]
    for(var _family=0;_family<array_length(_menu_families);++_family) {
        var _menu_object=_menu_families[_family]
        for(var _index=0;_index<instance_number(_menu_object);++_index) {
            var _menu=instance_find(_menu_object,_index)
            if(!instance_exists(_menu)) continue
            var _skill=scrNTTEFullValue(_menu,"skill","<absent>"),
                _creator=scrNTTEFullValue(_menu,"creator","<absent>")
            array_push(_menu_instances[_family],{index:_index,id:_menu,object:_menu.object_index,
                enumerated_active:true,exists:instance_exists(_menu),visible:_menu.visible,xy:[_menu.x,_menu.y],
                is_skill:instance_is(_menu,SkillIcon),skill:_skill,skill_type:typeof(_skill),
                creator:_creator,creator_type:typeof(_creator),
                num:scrNTTEFullValue(_menu,"num","<absent>"),
                selected:scrNTTEFullValue(_menu,"selected","<absent>"),
                appear:scrNTTEFullValue(_menu,"appear","<absent>"),
                appeary:scrNTTEFullValue(_menu,"appeary","<absent>")})
        }
    }
    // END LAIR REWARD MENU READONLY DIAGNOSTIC
    // BEGIN LAIR EXIT GATE READONLY DIAGNOSTIC
    var _corpses=[],_portals=[],_guards=[],_open_holes=[]
    with(Corpse) array_push(_corpses,{id:id,object:object_index,xy:[x,y],speed:speed,
        friction:friction,alarm0:alarm[0],sprite:sprite_index,image_index:image_index,
        image_number:image_number,image_speed:image_speed,forceportal:forceportal})
    with(Portal) array_push(_portals,{id:id,xy:[x,y],type:type,alpha:image_alpha,
        endgame:endgame,sprite:sprite_index,image_index:image_index,image_speed:image_speed})
    with(NTTEFullPortalPrevent) array_push(_guards,{id:id,creator:creator,
        creator_live:instance_exists(creator)})
    with(NTTEFullManholeOpen) array_push(_open_holes,{id:id,xy:[x,y],big:ntte_full_big,
        canportal:ntte_full_canportal,adopted_portal:ntte_full_portal,
        adopted_live:instance_exists(ntte_full_portal)})
    // END LAIR EXIT GATE READONLY DIAGNOSTIC
    scrNTTESmokeLog("LAIR BATTLE EXIT "+_where+" "+json_stringify({rate:rates[pass_index],phase:phase,
        elapsed:elapsed,frame:current_frame,shots:shot_count,hits:native_hits,damage:native_damage,
        population_hits:population_hits,population_damage:population_damage,
        cat_hits:cat_hits,cat_damage:cat_damage,bat_hits:bat_hits,bat_damage:bat_damage,
        cat_native_loss:cat_native_loss,bat_native_loss:bat_native_loss,boss_loss_records:array_length(boss_loss_ledger),
        ammo_spent:ammo_spent,move_samples:bot_move_samples,fire_samples:bot_fire_samples,
        player_xy:instance_exists(player)?[player.x,player.y]:[],player_hp:instance_exists(player)?player.hp:-1,
        ammo:instance_exists(player)?player.ammo:[],hostiles:scr_check_enemies(),
        manhole_live:instance_exists(hole),manhole_phase:instance_exists(hole)?hole.ntte_full_phase:-1,
        released:released,dead_bosses:dead_bosses,exit_started:exit_started,
        // BEGIN LAIR MENU EXACT SAMPLE READONLY FIELDS
        input_block_frames:UberCont.block_input_frames,coop_count:instance_number(CoopController),
        sampled_inputs:{keyboard:KeyCont.keyboard[0],gamepad:KeyCont.gamepad[0]},
        // END LAIR MENU EXACT SAMPLE READONLY FIELDS
        // BEGIN LAIR REWARD MENU READONLY FIELDS
        reward_menus:_menu_instances[0],skill_icons:_menu_instances[1],parbuttons:_menu_instances[2],
        menu_counts:[instance_number(LevCont),instance_number(SkillIcon),instance_number(ParButton)],
        reward_state:{lairmut:scrNTTEFullValue(GameCont,"ntte_lairmut","<absent>"),
            points:GameCont.skillpoints,crowns:GameCont.crownpoints,level:GameCont.level,
            silver_level:scr_skill_get(NTTEFullSkill.SilverTongue),silver_id:NTTEFullSkill.SilverTongue},
        menu_input:{key:ui_key,cooldown:ui_cooldown,keyboard:UberCont.opt_keyboard,gamepad:UberCont.opt_gamepad,
            held:ui_key>=0?keyboard_check(ui_key):false,pressed:ui_key>=0?keyboard_check_pressed(ui_key):false,
            typing:scr_keyboard_is_typing(),console:global.console_active,lockstep_stop:lockstep_stop},
        // END LAIR REWARD MENU READONLY FIELDS
        // BEGIN LAIR EXIT GATE READONLY FIELDS
        corpse_active_count:instance_number(CorpseActive),corpses:_corpses,portals:_portals,
        portal_guards:_guards,open_holes:_open_holes,pack_lair:scrNTTEFullUnlockGet("pack:lair"),
        levcont_count:instance_number(LevCont),gencont_count:instance_number(GenCont),
        toxic_delay_count:instance_number(ToxicDelay),cat_gas_count:instance_number(NTTECatGas),
        // END LAIR EXIT GATE READONLY FIELDS
        // BEGIN LAIR INJECTED NUMERIC SAMPLE FIELDS
        // BEGIN LAIR NAVIGATION READONLY JSON FIELD
        navigation_readonly:_navigation_read,
        // END LAIR NAVIGATION READONLY JSON FIELD
        numeric_input_mode:"injected sampled numeric input; physical keyboard untested",
        numeric_token:{pending:ui_token_pending,serial:ui_token_serial,samples:ui_samples,
            sample_key:ui_sample_key,sample_serial:ui_sample_serial,sample_target:ui_sample_target,
            target:ui_target,target_skill:ui_target_skill},
        // END LAIR INJECTED NUMERIC SAMPLE FIELDS
        room_ends:room_ends,room_starts:room_starts,ui_selections:ui_selections,silver:silver_selected,
        native_lair:[create_lair,destroy_lair],native_scrap:[create_scrap,destroy_scrap]}))
}
function scrNTTEFullLairBattleExitProbe(_kind) {
    var _o=instance_find(NTTEFullLairBattleExitNaturalTest,0)
    if(!instance_exists(_o) || _o.restored) return;
    if(_kind=="GenCont.Create.after") {
        assert(!ntte_full_sync_generation,"Natural Lair battle used synchronous test generation")
        if(GameCont.area==scrNTTEFullAreaId("lair")) _o.create_lair++
        if(GameCont.area==area_scrapyards) {
            // GenCont.Create can run inside native SkillIcon.Select, before
            // that destroyed icon's read-only after-probe returns.
            assert(_o.exit_started && scr_skill_get(NTTEFullSkill.SilverTongue)==1,
                "Scrapyards generated before native exit/actual Silver Tongue input")
            _o.create_scrap++
        }
    }
    if(_kind=="GenCont.Destroy.after") {
        if(GameCont.area==scrNTTEFullAreaId("lair")) _o.destroy_lair++
        if(GameCont.area==area_scrapyards) _o.destroy_scrap++
    }
    if(_kind=="Manhole.Step.before" && id==_o.hole && _o.phase==2) {
        _o.last_manhole_phase=ntte_full_phase
        _o.last_manhole_timer=ntte_full_timers[0]
        _o.last_manhole_clear=!scr_check_enemies() && !instance_exists(CorpseActive) && !instance_exists(NTTECatGas)
        _o.last_manhole_los=point_distance(x,y,_o.player.x,_o.player.y)<180
            && !collision_line(x,y,_o.player.x,_o.player.y,Wall,false,false)
    }
    if(_kind=="Manhole.Step.after" && _o.phase==2 && instance_exists(_o.hole)) with(_o) {
        if(last_manhole_timer<0 && last_manhole_phase==0 && hole.ntte_full_timers[0]>0) {
            assert(last_manhole_clear && hole.ntte_full_timers[0]==20,
                "Source manhole armed before ordinary enemy/corpse/gas clearance")
            gate_armed=true
        }
        if(hole.ntte_full_phase!=last_manhole_phase) {
            assert(gate_armed && hole.ntte_full_phase==last_manhole_phase+1
                && last_manhole_timer>0 && last_manhole_timer<=timescale
                && (last_manhole_phase==0 || last_manhole_los),
                "Manhole phase advanced without native elapsed clang timer/real Player LOS")
            clang_count++
        }
    }
    if(_kind=="Manhole.Destroy.before" && id==_o.hole) {
        assert(_o.phase==2 && ntte_full_released && ntte_full_phase==3
            && _o.gate_armed && _o.clang_count==3 && _o.population_hits>0
            && _o.bot_fire_samples>0 && _o.bot_move_samples>0
            && instance_number(NTTEFullCatBoss)==1 && instance_number(NTTEFullBatBoss)==1,
            "Manhole release lacks real population damage/input/three elapsed source clang phases/Boss pair")
        scrNTTESmokeLog("LAIR BATTLE EXIT release-before-destroy values "+json_stringify({
            frame:current_frame,rate:_o.rates[_o.pass_index],phase:_o.phase,
            lairmut_exists:variable_instance_exists(GameCont,"ntte_lairmut"),
            lairmut_value:scrNTTEFullValue(GameCont,"ntte_lairmut","<absent>"),
            pack_lair:scrNTTEFullUnlockGet("pack:lair"),skillpoints:GameCont.skillpoints,
            clangs:_o.clang_count,cat_count:instance_number(NTTEFullCatBoss),bat_count:instance_number(NTTEFullBatBoss)}))
        assert(!variable_instance_exists(GameCont,"ntte_lairmut"),
            "Lair pending mutation reward was granted before source Destroy timing")
        _o.source_points=GameCont.skillpoints
    }
    if(_kind=="Manhole.Destroy.after" && !_o.released && _o.gate_armed) with(_o) {
        assert(GameCont.skillpoints==source_points+1 && GameCont.ntte_lairmut
            && NTTEFullCatBoss.hp==200 && NTTEFullCatBoss.max_hp==200
            && NTTEFullBatBoss.hp==200 && NTTEFullBatBoss.max_hp==200
            && variable_instance_exists(NTTEFullBatBoss,"maxspeed") && NTTEFullBatBoss.maxspeed==3,
            "Native released Boss HP or immediate once-only source skillpoint/flag differs")
        hole_open=noone
        with(NTTEFullManholeOpen) if(ntte_full_big) other.hole_open=id
        assert(instance_exists(hole_open) && hole_open.ntte_full_big && hole_open.ntte_full_canportal
            && instance_number(NTTEFullPortalPrevent)==0,"Native release omitted open exit or retained dead gate")
        released=true;release_points=GameCont.skillpoints
    }
    if((_kind=="Cat.Destroy.before" || _kind=="Bat.Destroy.before") && _o.released) {
        var _cat=(_kind=="Cat.Destroy.before")
        assert(_o.phase==3 && hp<=0 && max_hp>=200
            && (_cat?_o.cat_hits:_o.bat_hits)>0,"Boss death lacks genuine native combat provenance")
        assert(_cat?!_o.cat_dead:!_o.bat_dead,"Native Boss death callback duplicated")
        _o.dead_partner=instance_find(_cat?NTTEFullBatBoss:NTTEFullCatBoss,0)
        _o.dead_partner_max=instance_exists(_o.dead_partner)?_o.dead_partner.max_hp:-1
        _o.dead_partner_eligible=instance_exists(_o.dead_partner) && _o.dead_partner.hp>0
        _o.dead_bosses++
        if(_cat) _o.cat_dead=true
        else _o.bat_dead=true
    }
    if((_kind=="Cat.Destroy.after" || _kind=="Bat.Destroy.after") && _o.released
        && _o.dead_bosses==1 && _o.dead_partner_eligible) {
        assert(instance_exists(_o.dead_partner) && _o.dead_partner.hp>0,
            "Source-live partner disappeared during native death callback")
        assert(_o.dead_partner.max_hp==_o.dead_partner_max+ceil(_o.dead_partner_max/4),
            "First native Boss death omitted source surviving-partner quarter maxHP increase")
        var _found=false
        with(NTTEFullBossHealController) if(ntte_full_target==_o.dead_partner) {
            assert(array_length(ntte_full_rads)>0 && ntte_full_heal>0,
                "First native Boss death lacks real Rad-linked heal controller")
            _found=true
        }
        assert(_found,"Partner healing bypassed real Rad-following controller")
    }
    if(_kind=="Portal.Contact.before" && _o.phase>=3 && _o.phase<=4 && !close) {
        if(_o.exit_portal==noone && _o.dead_bosses==2) _o.exit_portal=id
        assert(other.id==_o.player && id==_o.exit_portal && object_index==Portal && type==1
            && endgame>=100 && image_alpha==0 && _o.dead_bosses==2 && !scr_check_enemies()
            && instance_exists(_o.hole_open) && mask_index==_o.hole_open.sprite_index
            && point_distance(x,y,_o.hole_open.x,_o.hole_open.y)<1,
            "Exit contact lacks real source adopted manhole Portal/cleared combat/ordinary player movement")
    }
    if(_kind=="Portal.Contact.after" && _o.phase>=3 && _o.phase<=4 && id==_o.exit_portal && close && !_o.contact_seen) {
        assert(endgame==30 && alarm[1]>0 && other.id==_o.player,
            "Actual Portal collision omitted native close/endgame/alarm")
        _o.contact_seen=true
    }
    if(_kind=="Portal.Alarm1.before" && id==_o.exit_portal && !_o.exit_started) with(_o) {
        assert(phase==4 && contact_seen && dead_bosses==2 && !scr_check_enemies()
            && room_ends==0 && room_starts==0 && GameCont.area==scrNTTEFullAreaId("lair")
            && GameCont.ntte_lairmut && scrNTTEFullUnlockGet("pack:lair")
            && scr_skill_get(NTTEFullSkill.SilverTongue)==0,"Native Portal alarm lacks completed source battle/reward")
        exit_points=GameCont.skillpoints;exit_started=true
    }
    if(_kind=="SkillIcon.Select.before" && _o.exit_started) {
        assert(_o.ui_key>=0 && !_o.ui_token_pending && _o.ui_sample_key==_o.ui_key
            && _o.ui_sample_serial==_o.ui_token_serial && _o.ui_samples==_o.ui_selections+1
            && id==_o.ui_sample_target && id==_o.ui_target && skill==_o.ui_target_skill && selected
            && instance_exists(LevCont),"Reward choice bypassed injected sampled numeric input/native dispatch")
        _o.selection={skill:skill,old:scr_skill_get(skill),points:GameCont.skillpoints}
    }
    if(_kind=="SkillIcon.Select.after" && _o.exit_started) with(_o) {
        assert(is_struct(selection) && scr_skill_get(selection.skill)==selection.old+1
            && GameCont.skillpoints==selection.points-1,"Injected numeric sample/native dispatch failed real grant/point consumption")
        if(selection.skill==NTTEFullSkill.SilverTongue) {
            assert(!silver_selected && !GameCont.ntte_lairmut,"Source pending Lair mutation consumed incorrectly")
            silver_selected=true
        }
        ui_selections++;selection=undefined
    }
}
function scrNTTEFullLairBattleExitBootstrap() {
    scrNTTEFullLairBattleExitClear()
    current_frame=0;global.alarm_topup_acc=0
    global.custom_seed=current_seed;global.recontinued_times=0;global.__debug_infammo=false
    global.ntte_full_progress={schema:1,unlocks:{},loadouts:{},stats:{}}
    global.ntte_full_feature_ready={}
    if(file_exists(savegame_file)) file_delete(savegame_file)
    instance_create(0,0,GameCont);instance_create(0,0,BackCont);instance_create(0,0,MusCont);scrCreatePlayers(0)
    assert(global.seed==current_seed,"Native GameCont replaced controlled initial Lair seed")
    player=instance_find(Player,0)
    assert(instance_number(Player)==1 && player.race==Race.Fish && player.bskin==0,"Initial solo FishA failed")
    player.wep=wep_auto_crossbow;player.bwep=wep_none;player.infammo=0
    player.ammo[Ammo.Bolts]=typ_amax[Ammo.Bolts]
    GameCont.area=scrNTTEFullAreaId("lair");GameCont.subarea=1;GameCont.loops=0;GameCont.hard=5
    GameCont.maxsubarea=scrAreaGetMaxSubarea(GameCont.area);GameCont.finalsubarea=true
    GameCont.can_advance_stage=true;GameCont.gocrib=false;GameCont.crown=crwn_none
    GameCont.ntte_full_pending_destination=undefined
    GameCont.ntte_full_source_seed=scrNTTEFullSourceSeedBuild(current_seed)
    GameCont.ntte_full_source_pending_generation=undefined
    global.ntte_full_sync_generation=false;scrRngStatesReset()
    hole=noone;hole_open=noone;exit_portal=noone;released=false;gate_armed=false;clang_count=0
    create_lair=0;destroy_lair=0;create_scrap=0;destroy_scrap=0
    last_manhole_phase=-1;last_manhole_timer=-1;last_manhole_clear=false;last_manhole_los=false
    room_ends=0;room_starts=0;native_shots=[];shot_count=0;ammo_spent=0;native_hits=0;native_damage=0
    population_hits=0;population_damage=0;cat_hits=0;cat_damage=0;bat_hits=0;bat_damage=0
    cat_native_loss=0;bat_native_loss=0;boss_loss_ledger=[]
    cat_dead=false;bat_dead=false;dead_bosses=0;dead_partner=noone;dead_partner_max=-1
    dead_partner_eligible=false
    contact_seen=false;exit_started=false;selection=undefined
    bot_input_calls=0;bot_input_matched=0;bot_last_index=-1;bot_decisions=0;
        bot_last_decision=undefined;bot_last_plan=undefined;
        // BEGIN LAIR NATIVE MASK FALLBACK STATE
        bot_native_points=[];bot_native_cursor=1;bot_native_context="";
        bot_native_goal=[0,0];bot_native_active=false;bot_native_last=undefined;
        // END LAIR NATIVE MASK FALLBACK STATE
        ui_key=-1;ui_cooldown=0;ui_selections=0;silver_selected=false;ui_token_pending=false;ui_token_serial=0;ui_samples=0;ui_sample_key=-1;
        ui_sample_serial=0;ui_sample_target=noone;ui_target=noone;ui_target_skill=-1
    bot_was_fire=false;bot_fire_samples=0;bot_move_samples=0;bot_path_clock=0;bot_path_cursor=0
    path_goal_x=0;path_goal_y=0;path_clear_points(bot_path)
    scrNTTEFullFloorResetStyle();scrNTTEFullFloorResetAlign()
    scrNTTEFullLairBattleExitAwait(1)
    var _gen=instance_create(0,0,GenCont)
    assert(!_gen.ntte_full_sync_generation,"Initial Lair bypassed asynchronous generation")
    scrNTTESmokeLog("LAIR BATTLE EXIT controlled initial solo FishA/Lair1/loop0/hard5/legal AutoCrossbow+none/max55Bolts, native health/XP unchanged, native custom seed+allstream reset="+string(current_seed)+" @"+string(rates[pass_index]))
}
function scrNTTEFullLairBattleExitStepBody() {
    elapsed+=timescale
    if(phase>=1 && phase<=5) scrNTTEFullLairBattleExitMenuInput()
    if(elapsed>next_diagnostic && phase>=2) {
        scrNTTEFullLairBattleExitDiagnostic("native wait");next_diagnostic+=120
    }
    assert(elapsed<=10800,"Lair natural battle/reward/engine exit timed out phase="+string(phase))
    if(phase>0) scrNTTEFullLairBattleExitRate("phase "+string(phase))
    if(phase==0) {
        for(var _i=0;_i<array_length(smoke_drivers);++_i) {
            instance_activate_object(smoke_drivers[_i])
            if(instance_exists(smoke_drivers[_i])) instance_destroy(smoke_drivers[_i],false)
        }
        smoke_drivers=[];scrNTTEFullLairBattleExitClear()
        save_set_value("options","framerate",rates[pass_index]);save_set_value("options","autopause",false)
        save_set_value("options","keyboard",true);save_set_value("options","gamepad",false)
        save_set_value("visual","bossintro",false);save_set_value("visual","freezeframes",false)
        save_set_value("game","tutorial",false)
        UberCont.opt_framerate=rates[pass_index];UberCont.opt_autopause=false;UberCont.opt_keyboard=true
        UberCont.opt_gamepad=false;UberCont.opt_bossintro=false;UberCont.opt_freeze=0
        UberCont.paused=false;UberCont.want_pause=false;UberCont.block_input_frames=0;UberCont.block_input_fire=false
        game_set_speed(rates[pass_index],gamespeed_fps)
        scrNTTEFullLairBattleExitAwait(19);return;
    }
    if(phase==19) {
        UberCont.daily_run=false;UberCont.weekly_run=false;UberCont.coop=false;UberCont.hardmode=false
        UberCont.continued_run=false;UberCont.want_quit_to_menu=false;UberCont.show_leaderboards_menu=false
        global.is_server=true;global.index=0;global.crownpick=crwn_none
        scrGameCustomModeReset();scr_playerinstances_reset_all();my_player.race=Race.Fish;my_player.skin=0
        game_directory=scratch_root+string(rates[pass_index])+"/";directory_create(game_directory)
        var _files=["ntte-full-progress.json","ntte-full-progress.json.bak","ntte-full-progress.json.tmp","NuclearThrone.sav"]
        for(var _i=0;_i<array_length(_files);++_i) array_push(scratch_files,game_directory+_files[_i])
        scrNTTEFullLairBattleExitBootstrap();return;
    }
    if(phase>=1 && phase<=5) {
        assert(instance_exists(player) && player.hp>0,"Native unmodified-health Fish died during real Lair combat/exit")
        assert(player.wep==wep_auto_crossbow && player.bwep==wep_none && player.infammo==0
            && !global.__debug_infammo,"Lair battle changed controlled legal weapons/native ammo rules")
    }
    if(phase>=1 && phase<=4) {
        assert(!exit_started || phase==4,"Native engine exit began in an invalid battle phase")
        if(!exit_started) assert(room_ends==0 && room_starts==0,"Lair combat used artificial room boundaries")
    }
    if(phase==1) {
        if(!scrNTTEFullLairBattleExitWorldReady()) return;
        hole=instance_find(NTTEFullCatHoleBig,0)
        assert(create_lair==1 && destroy_lair==1 && instance_exists(hole)
            && instance_number(NTTEFullCatHoleBig)==1 && hole.ntte_full_phase==0
            && !hole.ntte_full_released && hole.ntte_full_timers[0]<0
            && scr_check_enemies() && instance_number(Floor)>20,
            "Async native Lair+8Draw lacks original populated world/unreleased source gate")
        assert(GameCont.ntte_full_active_lair && !instance_exists(NTTEFullCatBoss)
            && !instance_exists(NTTEFullBatBoss) && !instance_exists(Portal)
            && GameCont.skillpoints==0 && !variable_instance_exists(GameCont,"ntte_lairmut")
            && !scrNTTEFullUnlockGet("pack:lair") && scr_skill_get(NTTEFullSkill.SilverTongue)==0,
            "Initial native Lair prematurely supplied Boss/reward/Portal")
        old_game=GameCont.id;old_player=player.id;old_hard=GameCont.hard;old_waypoints=GameCont.waypoints
        old_visits=scrNTTEFullValue(GameCont,"ntte_visits_lair",0)
        scrNTTEFullLairBattleExitDiagnostic("initial isolated native Lair +8Draw")
        scrNTTEFullLairBattleExitAwait(2);return;
    }
    if(phase==2) {
        if(!released) return;
        assert(!instance_exists(hole) && population_hits>0 && shot_count>0 && ammo_spent==shot_count,
            "Population clearance/release lacks real AutoCrossbow cost/damage")
        scrNTTEFullLairBattleExitDiagnostic("ordinary damage/clearance/native clang/Boss release")
        scrNTTEFullLairBattleExitAwait(3);return;
    }
    if(phase==3) {
        if(dead_bosses<2 || scr_check_enemies() || !instance_exists(Portal)) return;
        exit_portal=instance_find(Portal,0)
        if(exit_portal.type!=1 || exit_portal.image_alpha!=0 || !scrNTTEFullUnlockGet("pack:lair")) return;
        scrNTTEFullLairBattleExitCheckLossLedger()
        assert(cat_dead && bat_dead && !instance_exists(NTTEFullCatBoss) && !instance_exists(NTTEFullBatBoss)
            && cat_hits>0 && bat_hits>0 && cat_native_loss>=200 && bat_native_loss>=200
            && GameCont.ntte_lairmut && GameCont.skillpoints>=release_points
            && scr_skill_get(NTTEFullSkill.SilverTongue)==0,
            "Native Boss defeat/source pending reward/completion lacks real accepted losses and moving Bolt provenance")
        assert(GameCont.hard==old_hard && GameCont.waypoints==old_waypoints
            && scrNTTEFullValue(GameCont,"ntte_visits_lair",0)==old_visits,
            "Battle/clear prematurely advanced source finish bookkeeping")
        scrNTTEFullLairBattleExitDiagnostic("two real Boss deaths/source pack/adopted exit Portal")
        scrNTTEFullLairBattleExitAwait(4);return;
    }
    if(phase==4) {
        if(!exit_started) return;
        scrNTTEFullLairBattleExitAwait(5);return;
    }
    if(phase==5) {
        if(instance_exists(LevCont) || !silver_selected || !scrNTTEFullLairBattleExitWorldReady()) return;
        assert(room_ends==1 && room_starts==1 && contact_seen && exit_started
            && create_scrap==1 && destroy_scrap==1 && GameCont.area==area_scrapyards
            && GameCont.subarea==1 && GameCont.loops==0 && !GameCont.ntte_full_active_lair
            && GameCont.id==old_game && player.id==old_player,
            "Real Portal engine exit/RoomEnd+Start/native next async generation+8Draw failed")
        assert(GameCont.hard==old_hard+1 && GameCont.waypoints==old_waypoints+1
            && scrNTTEFullValue(GameCont,"ntte_visits_lair",0)==old_visits+1
            && !GameCont.ntte_lairmut && scr_skill_get(NTTEFullSkill.SilverTongue)==1
            && ui_selections==exit_points && GameCont.skillpoints==0
            && file_exists(savegame_file) && scrNTTEFullUnlockGet("pack:lair")
            && instance_number(Floor)>20 && scr_check_enemies(),
            "Real exit lost exactly-once source bookkeeping/Silver Tongue injected numeric sample/native reward/next world")
        assert(ui_samples==ui_selections && ui_samples==ui_token_serial && !ui_token_pending,
            "Injected numeric sample consumption differs from completed native reward selections")
        var _progress_path=game_directory+"ntte-full-progress.json"
        assert(file_exists(_progress_path),"Lair completion did not persist its private progress")
        var _file=file_text_open_read(_progress_path),_text=""
        while(!file_text_eof(_file)) {_text+=file_text_read_string(_file);file_text_readln(_file)}
        file_text_close(_file)
        var _progress=json_parse(_text)
        assert(scrNTTEFullValue(_progress.unlocks,"pack:lair",false),"Lair completion private JSON disagrees with memory")
        scrNTTEFullLairBattleExitDiagnostic("complete ordinary battle/reward/real engine exit")
        scrNTTESmokeLog("PASS LAIR BATTLE EXIT NATURAL: controlled initial isolated FishA/Lair1/loop0/legal AutoCrossbow55Bolts/native health+XP; async generation+8Draw; ordinary sampled movement/fire/cost/reload/moving Bolt20 population clearance, native gate/corpse/gas and elapsed clang/LOS release, Cat+Bat real deaths and Rad-linked partner maxHP/healing controller, once-only source RELEASE skillpoint/flag, source pack memory+private JSON, genuine adopted Portal collision/animation/alarm engine RoomEnd+Start, source Scrapyards1 finish/visits/hard/waypoints exactly once, injected sampled numeric input with native Silver Tongue dispatch/remaining real choices/continuation save/next async generation+8Draw; physical keyboard/upstream Pizza/Drain/iPhone UNRUN @"+string(rates[pass_index]))
        if(++pass_index<array_length(rates)) {scrNTTEFullLairBattleExitAwait(0);return;}
        scrNTTEFullLairBattleExitRestore()
        scrNTTESmokeLog("PASS full internal selected implemented branches x 30/60; not complete MOD coverage")
        game_end()
    }
}
function scrNTTEFullLairBattleExitStep() {
    try {scrNTTEFullLairBattleExitStepBody()}
    catch(_error) {
        if(variable_instance_exists(id,"native_hits")) scrNTTEFullLairBattleExitDiagnostic("FAIL")
        scrNTTEFullLairBattleExitRestore();throw _error
    }
}

// Dedicated desktop process. Controlled Oasis1/loop0/legal initial loadout.
// Normal combat, source hidden contact crack and actual engine ingress are measured.
function scrNTTEFullOasisTrenchEntryClear() {
    var _keep=id
    with(all) if(id!=_keep && object_index!=UberCont && object_index!=Console) instance_destroy(id,false)
}
function scrNTTEFullOasisTrenchEntryRestore() {
    if(restored) return;
    restored=true;want_fire=false;want_move=false
    if(path_exists(bot_path)) path_delete(bot_path)
    var _unchanged=ds_map_write(old_save_map)==old_savedata
    // Dedicated-process teardown only, after the measured assertions (or a
    // failure). Dispose private actors while private progress/map still own
    // their cleanup; do not let game_end advance a fixture GameCont afterward.
    scrNTTEFullOasisTrenchEntryClear()
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
    assert(_unchanged,"Oasis/Trench fixture changed original physical options/save map")
    assert(ds_map_write(old_save_map)==old_savedata,"Private cleanup altered original options/save map")
    // UberCont.RoomEnd writes fullscreen/tot_time before testing dont_save.
    // The process is now terminating; stop that extra native autosave only
    // after restoring the original pointer and checking the original bytes.
    instance_deactivate_object(UberCont)
}
function scrNTTEFullOasisTrenchNaturalEntryTests() {
    assert(os_type==os_windows && scrNTTEFullSmokeEnabled(),"Oasis/Trench natural entry requires dedicated Windows full smoke")
    var _object=asset_get_index("NTTEFullOasisTrenchNaturalEntryTest")
    assert(object_exists(_object) && !instance_exists(_object),"Oasis/Trench observer missing/duplicated")
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
        scratch_root=working_directory+"oasis-trench-entry-"+string(get_timer())+"/";directory_create(scratch_root)
        rates=[30,60];pass_index=0;phase=0;elapsed=0;draw_frames=0;world_ready_draw=-1;next_diagnostic=120
        current_seed=701932;room_ends=0;room_starts=0;bot_path=path_add()
        hole=noone;portal=noone;clear_portal=noone;player=noone
        bot_was_fire=false;bot_target=noone;bot_path_clock=0;bot_path_cursor=0
        initial_hole_hidden=false;saw_reveal=false;manhole_destroy_seen=false
        smoke_drivers=scrNTTEFullInstances(NTTESmokeTest)
        with(NTTESmokeTest) instance_deactivate_object(id)
        global.ntte_smoke_active=false
        scrNTTEFullOasisTrenchEntryClear()
    }
}
function scrNTTEFullOasisTrenchEntryAwait(_phase) {phase=_phase;elapsed=0;world_ready_draw=-1;next_diagnostic=120}
function scrNTTEFullOasisTrenchEntryWorldReady() {
    if(instance_exists(GenCont) || instance_exists(FloorMaker)) {world_ready_draw=-1;return false;}
    if(world_ready_draw<0) {world_ready_draw=draw_frames;return false;}
    return draw_frames-world_ready_draw>=8
}
function scrNTTEFullOasisTrenchEntryRate(_where) {
    assert(game_get_speed(gamespeed_fps)==rates[pass_index] && timescale==30/rates[pass_index]
        && UberCont.opt_framerate==rates[pass_index] && !UberCont.opt_autopause
        && UberCont.saveData==fixture_save_map && ds_map_write(old_save_map)==old_savedata
        && save_get_value("options","framerate",-1)==rates[pass_index]
        && !save_get_value("options","autopause",true),"Native rate/options isolation failed at "+_where)
}
function scrNTTEFullOasisTrenchEntryFireBefore(_weapon) {
    var _observer=instance_find(NTTEFullOasisTrenchNaturalEntryTest,0)
    if(!instance_exists(_observer) || _observer.phase!=2 || id!=_observer.player) return undefined;
    assert(_weapon==wep_auto_crossbow || _weapon==wep_minigun,"Bot changed its declared legal starting weapons")
    assert(infammo==0 && !global.__debug_infammo,"Bot bypassed normal weapon ammo consumption")
    return {weapon:_weapon,before:scrNTTEFullInstances([Bolt,Bullet1]),
        ammo:ammo[scr_weapon_get_type(_weapon)],clock:current_frame}
}
function scrNTTEFullOasisTrenchEntryFireAfter(_sample) {
    if(!is_struct(_sample)) return;
    var _observer=instance_find(NTTEFullOasisTrenchNaturalEntryTest,0)
    if(!instance_exists(_observer) || _observer.phase!=2 || id!=_observer.player) return;
    var _shots=scrNTTEFullInstances([Bolt,Bullet1]),_new=0
    for(var _i=0;_i<array_length(_shots);++_i) {
        var _shot=_shots[_i]
        if(array_get_index(_sample.before,_shot)>=0 || _shot.creator!=id) continue
        var _bolt=_sample.weapon==wep_auto_crossbow
        assert(_shot.object_index==(_bolt?Bolt:Bullet1) && _shot.damage==(_bolt?20:3)
            && _shot.speed>0 && point_distance(_shot.x,_shot.y,x,y)<40,
            "Actual scrFire omitted original moving muzzle projectile or changed its original damage")
        array_push(_observer.native_shots,{shot:_shot,x:_shot.x,y:_shot.y,damage:_shot.damage,
            weapon:_sample.weapon,frame:current_frame});_new++
    }
    // The outer function observer also sees native input/reload attempts
    // which produce no shot. No-shot may consume no ammo; actual shots still
    // require exactly one original projectile and the full native cost/reload.
    if(_new==0) {
        assert(ammo[scr_weapon_get_type(_sample.weapon)]==_sample.ammo,
            "Native no-fire attempt consumed ammo without an original projectile");return;
    }
    assert(_new==1 && ammo[scr_weapon_get_type(_sample.weapon)]==_sample.ammo-scr_weapon_get_cost(_sample.weapon)
        && reload==scr_weapon_get_load(_sample.weapon) && !can_shoot,
        "Actual native fire omitted exactly one original projectile or bypassed source ammo/reload")
    _observer.shot_count++;_observer.ammo_spent+=scr_weapon_get_cost(_sample.weapon)
}
function scrNTTEFullOasisTrenchEntryBulletBefore(_target) {
    var _observer=instance_find(NTTEFullOasisTrenchNaturalEntryTest,0)
    if(!instance_exists(_observer) || _observer.restored || _observer.phase!=2
        || creator!=_observer.player || !instance_exists(_target)
        || !instance_is(_target,enemy) || _target.team==team) return undefined;
    var _record=undefined
    for(var _i=0;_i<array_length(_observer.native_shots);++_i)
        if(_observer.native_shots[_i].shot==id) {_record=_observer.native_shots[_i];break}
    assert(is_struct(_record),"Oasis enemy collision lacks actual native firing provenance")
    assert(damage==_record.damage && point_distance(x,y,_record.x,_record.y)>1,
        "Oasis native hit changed original damage or skipped moving projectile travel")
    return {target:_target,hp:_target.hp,damage:damage,travel:point_distance(x,y,_record.x,_record.y)}
}
function scrNTTEFullOasisTrenchEntryBulletAfter(_sample) {
    if(!is_struct(_sample)) return;
    var _observer=instance_find(NTTEFullOasisTrenchNaturalEntryTest,0)
    if(!instance_exists(_observer) || _observer.restored || _observer.phase!=2) return;
    var _loss=instance_exists(_sample.target)?_sample.hp-_sample.target.hp:_sample.hp
    if(_loss>0) {_observer.native_hits++;_observer.native_damage+=_loss}
}
function scrNTTEFullOasisTrenchEntryHostiles() {
    var _count=0
    with(enemy) if(hp>0 && team!=team_player && !instance_is(id,Van) && !instance_is(id,BigDogMissile)) _count++
    return _count
}
function scrNTTEFullOasisTrenchEntryBotTarget() {
    var _best=infinity,_next=noone,_hidden=noone,_hidden_distance=infinity
    with(enemy) if(hp>0 && team!=other.player.team && !instance_is(id,Van) && !instance_is(id,BigDogMissile)) {
        var _distance=point_distance(x,y,other.player.x,other.player.y)
        if(visible && mask_index!=mskNone) {
            if(_distance<_best) {_best=_distance;_next=id}
        }
        else if(_distance<_hidden_distance) {_hidden_distance=_distance;_hidden=id}
    }
    return instance_exists(_next)?_next:_hidden
}
// BEGIN NTTE OASIS GRID READONLY HELPER
function scrNTTEFullOasisTrenchEntryGridRead(_grid,_left,_top,_right,_bottom,_target,_avoid_clear) {
    var _columns=ceil((_right+64-_left)/8),_rows=ceil((_bottom+64-_top)/8),
        _sx=floor((player.x-_left)/8),_sy=floor((player.y-_top)/8),
        _gx=floor((_target.x-_left)/8),_gy=floor((_target.y-_top)/8),
        _start_bounds=_sx>=0 && _sy>=0 && _sx<_columns && _sy<_rows,
        _goal_bounds=_gx>=0 && _gy>=0 && _gx<_columns && _gy<_rows,
        _start_cell=_start_bounds?mp_grid_get_cell(_grid,_sx,_sy):undefined,
        _goal_cell=_goal_bounds?mp_grid_get_cell(_grid,_gx,_gy):undefined,
        _portal=undefined,_hole=undefined
    if(instance_exists(clear_portal)) {
        var _dx=player.x-clear_portal.x,_dy=player.y-clear_portal.y,
            _goal_dx=_target.x-clear_portal.x,_goal_dy=_target.y-clear_portal.y,
            _distance=point_distance(player.x,player.y,clear_portal.x,clear_portal.y),
            _goal_distance=point_distance(_target.x,_target.y,clear_portal.x,clear_portal.y)
        _portal={id:clear_portal,xy:[clear_portal.x,clear_portal.y],
            sprite:clear_portal.sprite_index,image:clear_portal.image_index,
            start_delta:[_dx,_dy],goal_delta:[_goal_dx,_goal_dy],
            start_distance:_distance,goal_distance:_goal_distance,
            start_in_square:abs(_dx)<=100 && abs(_dy)<=100,
            goal_in_square:abs(_goal_dx)<=100 && abs(_goal_dy)<=100,
            start_in_retreat_radius:_distance<108,start_in_attract_radius:_distance<96}
    }
    if(instance_exists(hole)) _hole={id:hole,xy:[hole.x,hole.y],visible:hole.visible,contact:hole.contact}
    return {grid:{left:_left,top:_top,columns:_columns,rows:_rows,cell_size:8},
        start:{xy:[player.x,player.y],cell:[_sx,_sy],in_bounds:_start_bounds,
            occupancy:_start_cell,blocked:_start_bounds?(_start_cell!=0):undefined},
        goal:{id:_target,xy:[_target.x,_target.y],cell:[_gx,_gy],in_bounds:_goal_bounds,
            occupancy:_goal_cell,blocked:_goal_bounds?(_goal_cell!=0):undefined},
        avoid_clear:_avoid_clear,clear_portal:_portal,hole:_hole}
}
// END NTTE OASIS GRID READONLY HELPER
// BEGIN NTTE OASIS SEGMENT READONLY HELPER
function scrNTTEFullOasisTrenchEntryActorCollisionsRead(_object) {
    var _objects=scrNTTEFullInstances(_object),_touching=[],_nearest=undefined,_minimum=infinity
    for(var _i=0;_i<array_length(_objects);++_i) {
        var _v=_objects[_i],_touch=false
        with(player) _touch=place_meeting(x,y,_v)
        var _distance=point_distance(player.x,player.y,(_v.bbox_left+_v.bbox_right)/2,(_v.bbox_top+_v.bbox_bottom)/2),
            _record={id:_v,object:_v.object_index,xy:[_v.x,_v.y],mask:_v.mask_index,sprite:_v.sprite_index,
                bbox:[_v.bbox_left,_v.bbox_top,_v.bbox_right,_v.bbox_bottom],center_distance:_distance}
        if(_touch) array_push(_touching,_record)
        if(_distance<_minimum) {_minimum=_distance;_nearest=_record}
    }
    return {touching:_touching,nearest:_nearest}
}
function scrNTTEFullOasisTrenchEntrySegmentRead(_x,_y,_avoid_clear) {
    var _length=point_distance(player.x,player.y,_x,_y),_steps=max(1,ceil(_length/2)),
        _minimum=_avoid_clear?max(0,min(100,point_distance(player.x,player.y,clear_portal.x,clear_portal.y)-0.001)):0
    for(var _sample=0;_sample<=_steps;++_sample) {
        var _sx=lerp(player.x,_x,_sample/_steps),_sy=lerp(player.y,_y,_sample/_steps),_wall=false,_floor=false
        with(player) {_wall=place_meeting(_sx,_sy,Wall);_floor=place_meeting(_sx,_sy,Floor)}
        var _radius=_avoid_clear?point_distance(_sx,_sy,clear_portal.x,clear_portal.y):undefined,
            _radius_fail=_avoid_clear?(_radius<_minimum):false
        if(_wall || !_floor) return {legal:false,rule:"wall_or_floor",sample:_sample,steps:_steps,
            xy:[_sx,_sy],wall:_wall,floor:_floor,radius:_radius,minimum:_minimum,radius_would_fail:_radius_fail}
        if(_radius_fail) return {legal:false,rule:"radius",sample:_sample,steps:_steps,
            xy:[_sx,_sy],wall:_wall,floor:_floor,radius:_radius,minimum:_minimum,radius_would_fail:true}
    }
    return {legal:true,steps:_steps,minimum:_minimum}
}
function scrNTTEFullOasisTrenchEntrySegmentsRead(_grid,_left,_top,_right,_bottom,_target,_avoid_clear) {
    var _columns=ceil((_right+64-_left)/8),_rows=ceil((_bottom+64-_top)/8),
        _start_x=floor((player.x-_left)/8),_start_y=floor((player.y-_top)/8),
        _start=undefined,_candidates=[],_escape=[],_legal_count=0,_wall_count=0,_floor_count=0,_radius_count=0,_sample_zero=0
    with(player) _start={id:id,xy:[x,y],previous:[xprevious,yprevious],object:object_index,
        sprite:sprite_index,mask:mask_index,image_angle:image_angle,image_xscale:image_xscale,image_yscale:image_yscale,
        bbox:[bbox_left,bbox_top,bbox_right,bbox_bottom],wall:place_meeting(x,y,Wall),floor:place_meeting(x,y,Floor),
        center_floor:position_meeting(x,y,Floor),hspeed:hspeed,vspeed:vspeed,speed:speed,roll:roll,can_walk:can_walk}
    _start.wall_actors=scrNTTEFullOasisTrenchEntryActorCollisionsRead(Wall)
    _start.floor_actors=scrNTTEFullOasisTrenchEntryActorCollisionsRead(Floor)
    // Same candidates and sample arithmetic as the original frozen planner;
    // read every rejection, without calculating/clearing/changing any path.
    for(var _ring=0;_ring<=16;++_ring) for(var _dy=-_ring;_dy<=_ring;++_dy) for(var _dx=-_ring;_dx<=_ring;++_dx) {
        if(max(abs(_dx),abs(_dy))!=_ring) continue
        var _cx=_start_x+_dx,_cy=_start_y+_dy
        if(_cx<0 || _cy<0 || _cx>=_columns || _cy>=_rows || mp_grid_get_cell(_grid,_cx,_cy)!=0) continue
        var _x=_left+_cx*8+4,_y=_top+_cy*8+4,_read=scrNTTEFullOasisTrenchEntrySegmentRead(_x,_y,_avoid_clear)
        array_push(_candidates,{cell:[_cx,_cy],xy:[_x,_y],read:_read})
        if(_read.legal) _legal_count++
        else {
            if(_read.sample==0) _sample_zero++
            if(_read.rule=="radius") _radius_count++
            else {if(_read.wall) _wall_count++;if(!_read.floor) _floor_count++}
        }
    }
    if(_avoid_clear) {
        var _away=point_direction(clear_portal.x,clear_portal.y,player.x,player.y),
            _current=point_distance(player.x,player.y,clear_portal.x,clear_portal.y)
        for(var _offset=-90;_offset<=90;_offset+=15) {
            var _direction=_away+_offset,_x=player.x+lengthdir_x(8,_direction),_y=player.y+lengthdir_y(8,_direction),
                _read=scrNTTEFullOasisTrenchEntrySegmentRead(_x,_y,true)
            array_push(_escape,{direction:_direction,xy:[_x,_y],
                outward:point_distance(_x,_y,clear_portal.x,clear_portal.y)>_current,read:_read})
        }
    }
    return {rate:rates[pass_index],phase:phase,elapsed:elapsed,frame:current_frame,start:_start,
        grid:{left:_left,top:_top,columns:_columns,rows:_rows,cell:8,start:[_start_x,_start_y]},
        target:{id:_target,xy:[_target.x,_target.y]},avoid_clear:_avoid_clear,
        clear_portal:instance_exists(clear_portal)?[clear_portal.x,clear_portal.y]:undefined,
        counts:{checked:array_length(_candidates),legal:_legal_count,sample_zero:_sample_zero,
            wall_first:_wall_count,floor_missing_first:_floor_count,radius_first:_radius_count},
        candidates:_candidates,escape:_escape}
}
// END NTTE OASIS SEGMENT READONLY HELPER
// BEGIN NTTE OASIS INPUT ORIGIN RECOVERY HELPER
function scrNTTEFullOasisTrenchEntryLegalSegment(_x,_y,_avoid_clear) {
    // Hypothetical collision reads use the actual Player mask; they never
    // move the actor, unblock a grid cell or relax a source contact gate.
    var _length=point_distance(player.x,player.y,_x,_y),_steps=max(1,ceil(_length/2)),
        _minimum=_avoid_clear?max(0,min(100,point_distance(player.x,player.y,clear_portal.x,clear_portal.y)-0.001)):0
    for(var _sample=0;_sample<=_steps;++_sample) {
        var _sx=lerp(player.x,_x,_sample/_steps),_sy=lerp(player.y,_y,_sample/_steps),_legal=true
        with(player) _legal=!place_meeting(_sx,_sy,Wall) && place_meeting(_sx,_sy,Floor)
        if(!_legal) return false;
        if(_avoid_clear && point_distance(_sx,_sy,clear_portal.x,clear_portal.y)<_minimum) return false;
    }
    return true
}
function scrNTTEFullOasisTrenchEntrySafeEscape() {
    var _away=point_direction(clear_portal.x,clear_portal.y,player.x,player.y),
        _current=point_distance(player.x,player.y,clear_portal.x,clear_portal.y),_best=_current,_chosen=undefined
    // Immediate ordinary input while a failed route awaits its next planning
    // tick. Even inside native attraction, start at the actual radius and
    // choose only an outward, real-mask/Floor-legal short segment.
    for(var _offset=-90;_offset<=90;_offset+=15) {
        var _direction=_away+_offset,_x=player.x+lengthdir_x(8,_direction),_y=player.y+lengthdir_y(8,_direction)
        if(!scrNTTEFullOasisTrenchEntryLegalSegment(_x,_y,true)) continue
        var _distance=point_distance(_x,_y,clear_portal.x,clear_portal.y)
        if(_distance>_best) {_best=_distance;_chosen=_direction}
    }
    return _chosen
}
function scrNTTEFullOasisTrenchEntryRecoverOrigin(_grid,_left,_top,_right,_bottom,_target,_avoid_clear) {
    var _columns=ceil((_right+64-_left)/8),_rows=ceil((_bottom+64-_top)/8),
        _start_x=floor((player.x-_left)/8),_start_y=floor((player.y-_top)/8),_checked=0,_legal=0
    // A conservative wall-expanded cell may contain a legal native Player.
    // Search nearby free cells without editing that conservative grid. Its
    // unchanged Portal square also excludes every recovered origin inside it.
    for(var _ring=0;_ring<=16;++_ring) for(var _dy=-_ring;_dy<=_ring;++_dy) for(var _dx=-_ring;_dx<=_ring;++_dx) {
        if(max(abs(_dx),abs(_dy))!=_ring) continue
        var _cx=_start_x+_dx,_cy=_start_y+_dy
        if(_cx<0 || _cy<0 || _cx>=_columns || _cy>=_rows || mp_grid_get_cell(_grid,_cx,_cy)!=0) continue
        var _x=_left+_cx*8+4,_y=_top+_cy*8+4
        _checked++
        if(!scrNTTEFullOasisTrenchEntryLegalSegment(_x,_y,_avoid_clear)) continue
        _legal++
        path_clear_points(bot_path)
        if(mp_grid_path(_grid,bot_path,_x,_y,_target.x,_target.y,false) && path_get_number(bot_path)>1) {
            // Follow the legal segment by ordinary sampled input first; then
            // consume the unchanged grid path starting at its real point zero.
            bot_path_cursor=0
            return {found:true,origin:[_x,_y],checked:_checked,legal:_legal}
        }
    }
    path_clear_points(bot_path)
    return {found:false,checked:_checked,legal:_legal}
}
// END NTTE OASIS INPUT ORIGIN RECOVERY HELPER
// BEGIN NTTE OASIS NATIVE MASK ROUTE HELPERS
function scrNTTEFullOasisTrenchEntryNativeRouteKey(_target,_avoid) {
    return json_stringify({phase:phase,target:_target,goal:[_target.x,_target.y],
        mask:player.mask_index,sprite:player.mask_index<0?player.sprite_index:player.mask_index,
        angle:player.image_angle,scale:[player.image_xscale,player.image_yscale],
        walls:instance_number(Wall),floors:instance_number(Floor),
        portal:_avoid?[clear_portal.id,clear_portal.x,clear_portal.y]:[]})
}
function scrNTTEFullOasisTrenchEntryNativeSegment(_x1,_y1,_x2,_y2,_minimum,_budget) {
    var _steps=max(1,ceil(point_distance(_x1,_y1,_x2,_y2)/2))
    for(var _i=0;_i<=_steps;++_i) {
        if(_budget.remaining<=0) {_budget.exhausted=true;return false;}
        _budget.remaining--;_budget.samples++
        var _x=lerp(_x1,_x2,_i/_steps),_y=lerp(_y1,_y2,_i/_steps),_wall=false,_floor=false
        with(player) {_wall=place_meeting(_x,_y,Wall);_floor=place_meeting(_x,_y,Floor)}
        if(_wall) {_budget.wall++;return false;}
        if(!_floor) {_budget.floor_missing++;return false;}
        if(_minimum>0 && point_distance(_x,_y,clear_portal.x,clear_portal.y)<_minimum) {
            _budget.radius++;return false;
        }
    }
    return true
}
function scrNTTEFullOasisTrenchEntryNativeGraph(_left,_top,_right,_bottom,_target,_minimum,_cell) {
    var _columns=ceil((_right+64-_left)/_cell),_rows=ceil((_bottom+64-_top)/_cell),_total=_columns*_rows,
        _budget={remaining:750000,samples:0,wall:0,floor_missing:0,radius:0,exhausted:false},
        _result={found:false,status:"no_route",cell:_cell,columns:_columns,rows:_rows,nodes:0,edges:0,
            start_valid:false,goal_valid:false,start_connectors:0,goal_connectors:0,
            minimum:_minimum,budget:_budget,points:[],whole_path_legal:false}
    if(_total<=0 || _total>60000) {_result.status="node_budget";return _result;}
    var _sx=player.x,_sy=player.y,_gx=_target.x,_gy=_target.y
    _result.start_valid=scrNTTEFullOasisTrenchEntryNativeSegment(_sx,_sy,_sx,_sy,_minimum,_budget)
    _result.goal_valid=scrNTTEFullOasisTrenchEntryNativeSegment(_gx,_gy,_gx,_gy,_minimum,_budget)
    if(!_result.start_valid || !_result.goal_valid) {_result.status="invalid_endpoint";return _result;}
    var _known=array_create(_total,0),_parent=array_create(_total,-2),_queue=[],_head=0,
        _start_x=floor((_sx-_left)/_cell),_start_y=floor((_sy-_top)/_cell),_end=-1
    // Virtual real-position start; never relocate the actor onto the lattice.
    for(var _dy=-2;_dy<=2;++_dy) for(var _dx=-2;_dx<=2;++_dx) {
        var _cx=_start_x+_dx,_cy=_start_y+_dy
        if(_cx<0 || _cy<0 || _cx>=_columns || _cy>=_rows) continue
        var _index=_cy*_columns+_cx,_x=_left+(_cx+0.5)*_cell,_y=_top+(_cy+0.5)*_cell
        _result.edges++
        if(scrNTTEFullOasisTrenchEntryNativeSegment(_sx,_sy,_x,_y,_minimum,_budget)) {
            _known[_index]=1;_parent[_index]=-1;array_push(_queue,_index);_result.start_connectors++
        }
        if(_budget.exhausted) {_result.status="sample_budget";return _result;}
    }
    var _dxs=[-1,1,0,0],_dys=[0,0,-1,1]
    while(_head<array_length(_queue) && !_budget.exhausted) {
        var _index=_queue[_head++],_cx=_index mod _columns,_cy=floor(_index/_columns),
            _x=_left+(_cx+0.5)*_cell,_y=_top+(_cy+0.5)*_cell
        _result.nodes++
        if(abs(_x-_gx)<=_cell*2 && abs(_y-_gy)<=_cell*2) {
            _result.edges++;_result.goal_connectors++
            if(scrNTTEFullOasisTrenchEntryNativeSegment(_x,_y,_gx,_gy,_minimum,_budget)) {_end=_index;break;}
        }
        for(var _direction=0;_direction<4;++_direction) {
            var _nx=_cx+_dxs[_direction],_ny=_cy+_dys[_direction]
            if(_nx<0 || _ny<0 || _nx>=_columns || _ny>=_rows) continue
            var _next=_ny*_columns+_nx
            if(_parent[_next]!=-2 || _known[_next]<0) continue
            var _tx=_left+(_nx+0.5)*_cell,_ty=_top+(_ny+0.5)*_cell
            if(_known[_next]==0) {
                _known[_next]=scrNTTEFullOasisTrenchEntryNativeSegment(_tx,_ty,_tx,_ty,_minimum,_budget)?1:-1
            }
            if(_known[_next]<0) continue
            _result.edges++
            if(scrNTTEFullOasisTrenchEntryNativeSegment(_x,_y,_tx,_ty,_minimum,_budget)) {
                _parent[_next]=_index;array_push(_queue,_next)
            }
        }
    }
    if(_budget.exhausted) {_result.status="sample_budget";return _result;}
    if(_end<0) return _result;
    var _reverse=[],_cursor=_end,_guard=0
    while(_cursor>=0 && _guard<_total) {
        array_push(_reverse,[_left+((_cursor mod _columns)+0.5)*_cell,
            _top+(floor(_cursor/_columns)+0.5)*_cell]);_cursor=_parent[_cursor];_guard++
    }
    if(_cursor!=-1) {_result.status="parent_budget";return _result;}
    var _points=[[_sx,_sy]]
    for(var _i=array_length(_reverse)-1;_i>=0;--_i) array_push(_points,_reverse[_i])
    array_push(_points,[_gx,_gy])
    // Validate every edge again, including both true endpoint connectors.
    for(var _i=1;_i<array_length(_points);++_i) {
        if(!scrNTTEFullOasisTrenchEntryNativeSegment(_points[_i-1][0],_points[_i-1][1],
            _points[_i][0],_points[_i][1],_minimum,_budget)) {
            _result.status=_budget.exhausted?"sample_budget":"path_revalidation";return _result;
        }
    }
    _result.found=true;_result.status="found";_result.points=_points;_result.whole_path_legal=true
    return _result
}
function scrNTTEFullOasisTrenchEntryNativePlan(_left,_top,_right,_bottom,_target,_avoid) {
    var _minimum=_avoid?max(0,min(100,point_distance(player.x,player.y,clear_portal.x,clear_portal.y)-0.001)):0,
        _cells=[8,4],_answer=undefined
    for(var _i=0;_i<array_length(_cells);++_i) {
        _answer=scrNTTEFullOasisTrenchEntryNativeGraph(_left,_top,_right,_bottom,_target,_minimum,_cells[_i])
        scrNTTESmokeLog("OASIS NATIVE MASK ROUTE "+json_stringify({rate:rates[pass_index],phase:phase,
            elapsed:elapsed,xy:[player.x,player.y],goal:[_target.x,_target.y],cell:_answer.cell,
            dimensions:[_answer.columns,_answer.rows],status:_answer.status,found:_answer.found,
            nodes:_answer.nodes,edges:_answer.edges,start_valid:_answer.start_valid,goal_valid:_answer.goal_valid,
            start_connectors:_answer.start_connectors,goal_connectors:_answer.goal_connectors,
            minimum:_minimum,budget:_answer.budget,points:array_length(_answer.points),
            whole_path_legal:_answer.whole_path_legal}))
        if(_answer.found || _answer.status=="invalid_endpoint") break;
    }
    return _answer
}
function scrNTTEFullOasisTrenchEntryNativeFollow() {
    var _points=ntte_oasis_native_points,_last=array_length(_points)-1,
        _budget={remaining:4096,samples:0,wall:0,floor_missing:0,radius:0,exhausted:false},_chosen=-1
    // Skip only a freshly validated actual-position segment, never by the
    // old6px proximity rule; this prevents shortcuts across a narrow corner.
    for(var _i=min(_last,ntte_oasis_native_cursor+8);_i>=ntte_oasis_native_cursor;--_i) {
        if(point_distance(player.x,player.y,_points[_i][0],_points[_i][1])>96) continue
        if(scrNTTEFullOasisTrenchEntryNativeSegment(player.x,player.y,_points[_i][0],_points[_i][1],
            ntte_oasis_native_minimum,_budget)) {_chosen=_i;break;}
    }
    if(_chosen<0 || _budget.exhausted) {
        scrNTTESmokeLog("OASIS NATIVE MASK FOLLOW REPLAN "+json_stringify({rate:rates[pass_index],
            phase:phase,xy:[player.x,player.y],cursor:ntte_oasis_native_cursor,budget:_budget}))
        return {moving:false,direction:0}
    }
    ntte_oasis_native_cursor=_chosen
    return {moving:point_distance(player.x,player.y,_points[_chosen][0],_points[_chosen][1])>0.5,
        direction:point_direction(player.x,player.y,_points[_chosen][0],_points[_chosen][1])}
}
// END NTTE OASIS NATIVE MASK ROUTE HELPERS
function scrNTTEFullOasisTrenchEntryBotAfterSample(_keycont,_index) {
    var _observer=instance_find(NTTEFullOasisTrenchNaturalEntryTest,0)
    if(!instance_exists(_observer) || _observer.restored || !instance_exists(_observer.player)
        || _observer.player.index!=_index) return;
    var _fire=false,_moving=false,_direction=0,_swap=false
    if(_observer.phase>=2 && _observer.phase<=4 && !instance_exists(GenCont) && !instance_exists(FloorMaker)) with(_observer) {
        // BEGIN NTTE OASIS CLEAR WAIT NATIVE NAVIGATION
        var _target=noone,_combat=phase==2 && !instance_exists(Portal) && scrNTTEFullOasisTrenchEntryHostiles()>0
        // END NTTE OASIS CLEAR WAIT NATIVE NAVIGATION
        if(_combat) _target=scrNTTEFullOasisTrenchEntryBotTarget()
        else if(instance_exists(hole)) _target=hole
        else if(instance_exists(portal)) _target=portal
        else if(instance_exists(spawned_portal)) _target=spawned_portal
        if(instance_exists(_target)) {
            var _distance=point_distance(player.x,player.y,_target.x,_target.y),
                _clear=!collision_line(player.x,player.y,_target.x,_target.y,Wall,false,false)
            _direction=point_direction(player.x,player.y,_target.x,_target.y)
            if(_combat) {
                _keycont.dir_fire[_index]=_direction
                var _type=scr_weapon_get_type(player.wep)
                _swap=player.ammo[_type]<=0 && player.ammo[scr_weapon_get_type(player.bwep)]>0
                _fire=!_swap && _clear && _distance<128 && _target.visible && _target.mask_index!=mskNone
                    && player.ammo[_type]>0
                _moving=(!_clear || _distance>112 || !_target.visible || _target.mask_index==mskNone) && _distance>24
            }
            else _moving=_distance>2
            bot_path_clock-=timescale
            var _avoid_clear=instance_exists(hole) && instance_exists(clear_portal)
            if(_moving && (!_clear || _avoid_clear)) {
                // BEGIN NTTE OASIS NATIVE MASK ROUTE CACHE
                var _native_active=variable_instance_exists(id,"ntte_oasis_native_route") && ntte_oasis_native_route
                // BEGIN NTTE OASIS COMBAT NATIVE MASK CACHE
                if(_native_active && (!(phase==2 || phase==3) || ntte_oasis_native_key!=scrNTTEFullOasisTrenchEntryNativeRouteKey(_target,_avoid_clear))) {
                // END NTTE OASIS COMBAT NATIVE MASK CACHE
                    ntte_oasis_native_route=false;_native_active=false;bot_path_clock=0
                }
                // END NTTE OASIS NATIVE MASK ROUTE CACHE
                if(!_native_active && (bot_target!=_target || bot_path_clock<=0)) {
                    ntte_oasis_native_route=false
                    bot_target=_target;bot_path_clock=20;bot_path_cursor=1
                    assert(instance_number(Floor)>0,"Oasis combat/entrance path lost native terrain")
                    var _left=infinity,_top=infinity,_right=-infinity,_bottom=-infinity
                    with(Floor) {_left=min(_left,bbox_left);_top=min(_top,bbox_top)
                        _right=max(_right,bbox_right);_bottom=max(_bottom,bbox_bottom)}
                    _left=floor((_left-64)/8)*8;_top=floor((_top-64)/8)*8
                    var _grid=mp_grid_create(_left,_top,ceil((_right+64-_left)/8),ceil((_bottom+64-_top)/8),8,8)
                    with(Wall) mp_grid_add_rectangle(_grid,bbox_left-5,bbox_top-3,bbox_right+5,bbox_bottom+3)
                    // BEGIN NTTE OASIS GRID READONLY BEFORE AVOID
                    var _ntte_oasis_grid_before=undefined
                    if(phase==3) try {
                        _ntte_oasis_grid_before=scrNTTEFullOasisTrenchEntryGridRead(_grid,_left,_top,_right,_bottom,_target,_avoid_clear)
                    }
                    catch(_ntte_oasis_grid_before_error) {
                        show_debug_message("OASIS GRID DIAGNOSTIC before unavailable: "+string(_ntte_oasis_grid_before_error))
                    }
                    // END NTTE OASIS GRID READONLY BEFORE AVOID
                    if(_avoid_clear) mp_grid_add_rectangle(_grid,clear_portal.x-100,clear_portal.y-100,
                        clear_portal.x+100,clear_portal.y+100)
                    path_clear_points(bot_path)
                    mp_grid_path(_grid,bot_path,player.x,player.y,_target.x,_target.y,false)
                    // BEGIN NTTE OASIS GRID READONLY AFTER PATH
                    if(phase==3) try {
                        var _ntte_oasis_grid_after=scrNTTEFullOasisTrenchEntryGridRead(_grid,_left,_top,_right,_bottom,_target,_avoid_clear)
                        scrNTTESmokeLog("OASIS GRID DIAGNOSTIC "+json_stringify({rate:rates[pass_index],
                            phase:phase,elapsed:elapsed,frame:current_frame,
                            walls_only:_ntte_oasis_grid_before,after_avoid:_ntte_oasis_grid_after,
                            path_points:path_get_number(bot_path),path_cursor:bot_path_cursor}))
                    }
                    catch(_ntte_oasis_grid_after_error) {
                        show_debug_message("OASIS GRID DIAGNOSTIC after unavailable: "+string(_ntte_oasis_grid_after_error))
                    }
                    // END NTTE OASIS GRID READONLY AFTER PATH
                    // BEGIN NTTE OASIS SEGMENT READONLY CALL
                    if(phase==3 && path_get_number(bot_path)<=1) try {
                        var _ntte_oasis_segment_key=json_stringify({xy:[player.x,player.y],mask:player.mask_index,
                            sprite:player.sprite_index,angle:player.image_angle,scale:[player.image_xscale,player.image_yscale],
                            target:[_target.x,_target.y],walls:instance_number(Wall),floors:instance_number(Floor)})
                        if(!variable_instance_exists(id,"ntte_oasis_segment_read_key") || ntte_oasis_segment_read_key!=_ntte_oasis_segment_key) {
                            scrNTTESmokeLog("OASIS SEGMENT READONLY "+json_stringify(
                                scrNTTEFullOasisTrenchEntrySegmentsRead(_grid,_left,_top,_right,_bottom,_target,_avoid_clear)))
                            ntte_oasis_segment_read_key=_ntte_oasis_segment_key
                        }
                    }
                    catch(_ntte_oasis_segment_error) {
                        show_debug_message("OASIS SEGMENT READONLY unavailable: "+string(_ntte_oasis_segment_error))
                    }
                    // END NTTE OASIS SEGMENT READONLY CALL
                    // BEGIN NTTE OASIS INPUT ORIGIN RECOVERY CALL
                    if(phase==3 && path_get_number(bot_path)<=1) {
                        var _ntte_oasis_recovery=scrNTTEFullOasisTrenchEntryRecoverOrigin(_grid,_left,_top,_right,_bottom,_target,_avoid_clear)
                        scrNTTESmokeLog("OASIS INPUT ORIGIN RECOVERY "+json_stringify({rate:rates[pass_index],
                            phase:phase,elapsed:elapsed,player_xy:[player.x,player.y],recovery:_ntte_oasis_recovery,
                            path_points:path_get_number(bot_path),path_cursor:bot_path_cursor}))
                    }
                    // END NTTE OASIS INPUT ORIGIN RECOVERY CALL
                    // BEGIN NTTE OASIS NATIVE MASK ROUTE CALL
                    // BEGIN NTTE OASIS COMBAT NATIVE MASK CALL
                    if((phase==2 || phase==3) && path_get_number(bot_path)<=1 && (phase==2 ? true : !_ntte_oasis_recovery.found)) {
                    // END NTTE OASIS COMBAT NATIVE MASK CALL
                        var _native_plan=scrNTTEFullOasisTrenchEntryNativePlan(_left,_top,_right,_bottom,_target,_avoid_clear)
                        if(_native_plan.found) {
                            ntte_oasis_native_route=true;ntte_oasis_native_points=_native_plan.points;ntte_oasis_native_cursor=1
                            ntte_oasis_native_minimum=_native_plan.minimum
                            ntte_oasis_native_key=scrNTTEFullOasisTrenchEntryNativeRouteKey(_target,_avoid_clear)
                        }
                    }
                    // END NTTE OASIS NATIVE MASK ROUTE CALL
                    mp_grid_destroy(_grid)
                }
                // BEGIN NTTE OASIS NATIVE MASK ROUTE FOLLOW
                // BEGIN NTTE OASIS COMBAT NATIVE MASK FOLLOW
                if((phase==2 || phase==3) && variable_instance_exists(id,"ntte_oasis_native_route") && ntte_oasis_native_route) {
                // END NTTE OASIS COMBAT NATIVE MASK FOLLOW
                    var _native_follow=scrNTTEFullOasisTrenchEntryNativeFollow()
                    _moving=_native_follow.moving;_direction=_native_follow.direction
                    if(!_moving) {ntte_oasis_native_route=false;bot_path_clock=0;}
                }
                else
                // END NTTE OASIS NATIVE MASK ROUTE FOLLOW
                if(path_get_number(bot_path)>1) {
                    while(bot_path_cursor<path_get_number(bot_path)-1
                        && point_distance(player.x,player.y,path_get_point_x(bot_path,bot_path_cursor),path_get_point_y(bot_path,bot_path_cursor))<6)
                        bot_path_cursor++
                    _direction=point_direction(player.x,player.y,path_get_point_x(bot_path,bot_path_cursor),path_get_point_y(bot_path,bot_path_cursor))
                }
                else _moving=false
            }
            // BEGIN NTTE OASIS INPUT ORIGIN RECOVERY RETREAT
            // Phase3 follows a mask-legal origin outside the actual avoidance
            // square. Preserve valid paths; without one, immediately sample a
            // legal outward input even while its20tick path clock is pending.
            if(phase!=3 && _avoid_clear && point_distance(player.x,player.y,clear_portal.x,clear_portal.y)<108) {
                _direction=point_direction(clear_portal.x,clear_portal.y,player.x,player.y);_moving=true
            }
            else if(phase==3 && _avoid_clear && path_get_number(bot_path)<=1
                && (!variable_instance_exists(id,"ntte_oasis_native_route") || !ntte_oasis_native_route)) {
                var _escape=scrNTTEFullOasisTrenchEntrySafeEscape()
                if(!is_undefined(_escape)) {_direction=_escape;_moving=true}
            }
            // END NTTE OASIS INPUT ORIGIN RECOVERY RETREAT
        }
        if(_fire) bot_fire_samples++
        if(_moving) bot_move_samples++
    }
    _keycont.press_fire[_index]=_fire && !_observer.bot_was_fire
    _keycont.hold_fire[_index]=_fire;_keycont.release_fire[_index]=!_fire && _observer.bot_was_fire
    _observer.bot_was_fire=_fire
    _keycont.press_swap[_index]=_swap;_keycont.hold_swap[_index]=_swap
    _keycont.hold_spec[_index]=false;_keycont.press_spec[_index]=false
    _keycont.hold_pick[_index]=false;_keycont.press_pick[_index]=false
    _keycont.aimassist[_index]=false;_keycont.precisemovement[_index]=true
    _keycont.moving[_index]=_moving?1:0;_keycont.dir_move[_index]=_direction
    _keycont.hold_east[_index]=false;_keycont.hold_west[_index]=false
    _keycont.hold_nort[_index]=false;_keycont.hold_sout[_index]=false
}
function scrNTTEFullOasisTrenchEntryDiagnostic(_where) {
    var _enemies=[]
    with(enemy) if(hp>0 && team!=team_player) array_push(_enemies,{id:id,object:object_get_name(object_index),
        hp:hp,xy:[x,y],visible:visible,mask:mask_index})
    scrNTTESmokeLog("OASIS TRENCH DIAGNOSTIC "+_where+" "+json_stringify({
        rate:rates[pass_index],seed:current_seed,phase:phase,elapsed:elapsed,frame:current_frame,
        area:instance_exists(GameCont)?GameCont.area:-1,subarea:instance_exists(GameCont)?GameCont.subarea:-1,
        generation:instance_exists(GenCont)||instance_exists(FloorMaker),enemies:_enemies,
        hole:hole,hole_live:instance_exists(hole),initial_hidden:initial_hole_hidden,reveal:saw_reveal,
        contact:saw_player_hole_contact,destroy:manhole_destroy_seen,clear_portal:clear_portal,
        spawned_portal:spawned_portal,portal:portal,source_reclaimed:saw_reclaimed_portal,
        shots:shot_count,ammo_spent:ammo_spent,hits:native_hits,damage:native_damage,
        fire_samples:bot_fire_samples,move_samples:bot_move_samples,path_points:path_get_number(bot_path),
        player_xy:instance_exists(player)?[player.x,player.y]:[],
        player_ammo:instance_exists(player)?player.ammo:[],
        room_ends:room_ends,room_starts:room_starts,restart:native_restart_requested}))
}
function scrNTTEFullOasisTrenchEntryProbe(_kind) {
    var _observer=instance_find(NTTEFullOasisTrenchNaturalEntryTest,0)
    if(!instance_exists(_observer) || _observer.restored) return;
    if(_kind=="GenCont.Destroy.after" && _observer.phase==1 && GameCont.area==scrNTTEFullAreaId("oasis")) {
        assert(instance_number(NTTEFullManhole)==1,"Genuine Oasis start did not produce exactly one Crack")
        var _hole=instance_find(NTTEFullManhole,0)
        assert(!_hole.visible && _hole.contact && _hole.image_index==0 && _hole.image_number==2
            && _hole.sprite_index==scrNTTERefSprite("Crack")
            && _hole.area==scrNTTEFullAreaId("trench") && _hole.subarea==1,
            "Genuine Oasis start omitted hidden/contact/original two-frame Crack/final Trench1 destination")
        _observer.hole=_hole;_observer.hole_x=_hole.x;_observer.hole_y=_hole.y
        _observer.hole_start_sprite=_hole.sprite_index;_observer.hole_start_frames=_hole.image_number
        _observer.initial_hole_hidden=true
        _observer.initial_hostiles=scrNTTEFullOasisTrenchEntryHostiles()
        assert(_observer.initial_hostiles>0 && !instance_exists(Portal),"Actual Oasis generated no live encounter before natural clear")
    }
    if(_observer.phase>=1 && _observer.phase<=4) {
        if(_kind=="Corpse.Alarm0.before" && !scr_check_enemies()) {
            _observer.saw_native_clear_alarm=true;_observer.clear_alarm_frame=current_frame
        }
        if(id==_observer.hole) {
            if(_kind=="Manhole.Step.before") {
                if(!visible && instance_exists(Portal)) _observer.saw_reveal_prerequisite=true
                if(visible && contact && place_meeting(x,y,Player)) _observer.saw_player_hole_contact=true
            }
            if(_kind=="Manhole.Step.after" && visible && _observer.saw_reveal_prerequisite) _observer.saw_reveal=true
            if(_kind=="Manhole.Destroy.before") {
                assert(_observer.initial_hole_hidden && _observer.saw_reveal_prerequisite && _observer.saw_reveal
                    && _observer.saw_player_hole_contact && visible && contact && place_meeting(x,y,Player)
                    && !place_meeting(x,y,Explosion) && sprite_index==_observer.hole_start_sprite
                    && image_number==_observer.hole_start_frames && image_number==2 && image_index==image_number-1,
                    "Genuine Crack Destroy lacks source hidden/reveal/contact/original two-frame terminal state")
                assert(!scr_check_enemies() && scrNTTEFullOasisTrenchEntryHostiles()==0
                    && _observer.saw_native_clear_alarm && instance_exists(_observer.clear_portal),
                    "Crack opened before actual native combat clear and clear-Portal reveal")
                _observer.manhole_destroy_seen=true
            }
        }
        if(_kind=="Portal.Create.after") {
            if(!_observer.manhole_destroy_seen) {
                assert(_observer.phase==2 && _observer.saw_native_clear_alarm && _observer.clear_alarm_frame==current_frame && !scr_check_enemies()
                    && scrNTTEFullOasisTrenchEntryHostiles()==0 && _observer.clear_portal==noone,
                    "Oasis clear Portal lacks genuine Corpse/native enemy-clear provenance")
                _observer.clear_portal=id;_observer.clear_portal_spawn=sprite_index==sprPortalSpawn
            }
            else if(point_distance(x,y,_observer.hole_x,_observer.hole_y)<1) {
                assert(_observer.spawned_portal==noone,"Genuine Crack death spawned duplicate entrance Portals")
                _observer.spawned_portal=id;_observer.saw_source_spawn=sprite_index==sprPortalSpawn
                var _pending=GameCont.ntte_full_pending_destination
                assert(is_struct(_pending) && _pending.area==scrNTTEFullAreaId("trench")
                    && _pending.subarea==1 && _pending.loops==0
                    && GameCont.area==scrNTTEFullAreaId("oasis") && GameCont.subarea==1,
                    "Source Crack death lost final Trench1 queue or prematurely changed active Oasis")
            }
        }
        if(_kind=="ManholeOpen.Step.after" && _observer.manhole_destroy_seen
            && point_distance(x,y,_observer.hole_x,_observer.hole_y)<1 && instance_exists(ntte_full_portal)) {
            assert(ntte_full_portal==_observer.clear_portal || ntte_full_portal==_observer.spawned_portal,
                "Source ManholeOpen claimed a Portal outside the observed native clear/death chain")
            assert(ntte_full_portal.image_alpha==0 && ntte_full_portal.mask_index==sprite_index
                && point_distance(ntte_full_portal.x,ntte_full_portal.y,x,y)<1,
                "Source ManholeOpen did not actually move/mask its native entrance Portal")
            _observer.reclaimed_portal=ntte_full_portal;_observer.saw_reclaimed_portal=true
            if(_observer.portal==noone) _observer.portal=ntte_full_portal
        }
        if(_kind=="Portal.Collision.Player.before") {
            assert(_observer.manhole_destroy_seen && (id==_observer.spawned_portal || id==_observer.reclaimed_portal)
                && point_distance(x,y,_observer.hole_x,_observer.hole_y)<1,
                "Bot touched ordinary Oasis exit before genuine Crack ingress")
            if(_observer.portal!=id) {assert(!_observer.saw_contact,"Two entrance Portals accepted native Player contact");_observer.portal=id}
        }
    }
    if(id==_observer.portal || id==_observer.spawned_portal || id==_observer.reclaimed_portal) {
        if(sprite_index==sprPortalSpawn) _observer.saw_spawn=true
        if(sprite_index==sprPortal) _observer.saw_open=true
        if(sprite_index==sprPortalDisappear) _observer.saw_disappear=true
        if(_kind=="Portal.Collision.Player.after" && endgame<=30) {
            _observer.portal=id;_observer.saw_contact=true
        }
        if(_kind=="Portal.Alarm1.before") {
            assert(id==_observer.portal && _observer.saw_contact,"Non-contact entrance Portal requested native room_restart")
            _observer.native_restart_requested=true
        }
    }
}
function scrNTTEFullOasisTrenchEntryBootstrap() {
    // Controlled initial Oasis1 only; every subsequent lifecycle is native.
    scrNTTEFullOasisTrenchEntryClear()
    scrNTTESmokeLog("OASIS TRENCH CONTROLLED CLOCK before "+string(current_frame)+"/"+string(global.alarm_topup_acc))
    current_frame=0;global.alarm_topup_acc=0
    global.custom_seed=current_seed;global.recontinued_times=0;global.__debug_infammo=false
    global.ntte_full_progress={schema:1,unlocks:{},loadouts:{},stats:{}}
    global.ntte_full_feature_ready={}
    if(file_exists(savegame_file)) file_delete(savegame_file)
    instance_create(0,0,GameCont);instance_create(0,0,BackCont);instance_create(0,0,MusCont);scrCreatePlayers(0)
    assert(global.seed==current_seed,"Native GameCont custom-seed initialization replaced Oasis seed")
    player=instance_find(Player,0)
    assert(instance_number(Player)==1 && player.race==Race.Fish && player.bskin==0,"Controlled Oasis initial solo Fish failed")
    player.wep=wep_auto_crossbow;player.bwep=wep_minigun;player.infammo=0
    player.ammo[Ammo.Bolts]=typ_amax[Ammo.Bolts];player.ammo[Ammo.Bullets]=typ_amax[Ammo.Bullets]
    player.can_walk=true;player.can_aim=true
    GameCont.area=scrNTTEFullAreaId("oasis");GameCont.subarea=1;GameCont.loops=0;GameCont.hard=9
    GameCont.maxsubarea=scrAreaGetMaxSubarea(GameCont.area);GameCont.finalsubarea=true
    GameCont.can_advance_stage=true;GameCont.gocrib=false;GameCont.crown=crwn_none
    GameCont.rad=-100000;GameCont.skillpoints=0;GameCont.crownpoints=0;GameCont.ultrapoints=0
    GameCont.ntte_full_pending_destination=undefined
    GameCont.ntte_full_source_seed=scrNTTEFullSourceSeedBuild(current_seed)
    GameCont.ntte_full_source_pending_generation=undefined
    global.ntte_full_sync_generation=false;scrRngStatesReset()
    hole=noone;portal=noone;clear_portal=noone;spawned_portal=noone;reclaimed_portal=noone
    room_ends=0;room_starts=0;initial_hole_hidden=false;saw_reveal=false;saw_reveal_prerequisite=false
    saw_player_hole_contact=false;manhole_destroy_seen=false;saw_reclaimed_portal=false
    saw_source_spawn=false;saw_spawn=false;saw_open=false;saw_contact=false;saw_disappear=false
    clear_portal_spawn=false;saw_native_clear_alarm=false;clear_alarm_frame=-1;native_restart_requested=false;missing_portal_clock=0
    shot_count=0;ammo_spent=0;native_shots=[];native_hits=0;native_damage=0;initial_hostiles=0
    bot_was_fire=false;bot_fire_samples=0;bot_move_samples=0;bot_target=noone;bot_path_clock=0;bot_path_cursor=0
    path_clear_points(bot_path);next_diagnostic=120
    scrNTTEFullFloorResetStyle();scrNTTEFullFloorResetAlign()
    scrNTTEFullOasisTrenchEntryAwait(1)
    var _gen=instance_create(0,0,GenCont)
    assert(!_gen.ntte_full_sync_generation,"Oasis fixture bypassed actual asynchronous generation")
    scrNTTESmokeLog("OASIS TRENCH controlled initial solo Fish/Oasis1/loop0/hard9/legal AutoCrossbow+Minigun/max ammo/protected HP/XP suppression; native custom seed+regional reset="+string(current_seed)+" @"+string(rates[pass_index]))
}
function scrNTTEFullOasisTrenchEntryStepBody() {
    elapsed+=timescale
    if(elapsed>next_diagnostic && phase>=2 && phase<=4) {
        scrNTTEFullOasisTrenchEntryDiagnostic("native wait");next_diagnostic+=120
    }
    assert(elapsed<=5400,"Oasis/Trench natural entry timeout phase="+string(phase))
    if(phase>0) scrNTTEFullOasisTrenchEntryRate("phase "+string(phase))
    if(instance_exists(player)) {
        player.hp=100000;player.max_hp=100000;player.lsthealth=100000;player.nexthurt=current_frame+100000
    }
    if(phase==0) {
        for(var _i=0;_i<array_length(smoke_drivers);++_i) {
            instance_activate_object(smoke_drivers[_i])
            if(instance_exists(smoke_drivers[_i])) instance_destroy(smoke_drivers[_i],false)
        }
        smoke_drivers=[];scrNTTEFullOasisTrenchEntryClear()
        save_set_value("options","framerate",rates[pass_index]);save_set_value("options","autopause",false)
        save_set_value("options","keyboard",true);save_set_value("options","gamepad",false)
        save_set_value("visual","bossintro",false);save_set_value("visual","freezeframes",false)
        save_set_value("game","tutorial",false)
        UberCont.opt_framerate=rates[pass_index];UberCont.opt_autopause=false;UberCont.opt_keyboard=true
        UberCont.opt_gamepad=false;UberCont.opt_bossintro=false;UberCont.opt_freeze=0
        UberCont.paused=false;UberCont.want_pause=false;UberCont.block_input_frames=0;UberCont.block_input_fire=false
        game_set_speed(rates[pass_index],gamespeed_fps)
        scrNTTEFullOasisTrenchEntryAwait(19);return;
    }
    if(phase==19) {
        UberCont.daily_run=false;UberCont.weekly_run=false;UberCont.coop=false;UberCont.hardmode=false
        UberCont.continued_run=false;UberCont.want_quit_to_menu=false;UberCont.show_leaderboards_menu=false
        global.is_server=true;global.index=0;global.crownpick=crwn_none
        scrGameCustomModeReset();scr_playerinstances_reset_all();my_player.race=Race.Fish;my_player.skin=0
        game_directory=scratch_root+string(rates[pass_index])+"/";directory_create(game_directory)
        var _files=["ntte-full-progress.json","ntte-full-progress.json.bak","ntte-full-progress.json.tmp","NuclearThrone.sav"]
        for(var _i=0;_i<array_length(_files);++_i) array_push(scratch_files,game_directory+_files[_i])
        scrNTTEFullOasisTrenchEntryBootstrap();return;
    }
    if(phase==1) {
        if(!scrNTTEFullOasisTrenchEntryWorldReady()) return;
        assert(initial_hole_hidden && instance_exists(hole) && !hole.visible
            && GameCont.ntte_full_active_oasis && GameCont.underwater && !TopCont.darkness
            && instance_number(Floor)>20 && instance_number(TopCont)==1 && !instance_exists(TutCont)
            && !instance_exists(Portal) && scrNTTEFullOasisTrenchEntryHostiles()>0,
            "Actual Oasis generation+8Draw lost original hidden Crack/terrain/underwater/encounter")
        assert(!scrNTTEFullUnlockGet("skin:parrot:1") && !scrNTTEFullUnlockGet("pack:trench"),
            "Initial Oasis fixture pre-owned final Trench/B rewards")
        old_world=scrNTTEFullInstances([Floor,Wall,TopCont,SubTopCont]);old_game=GameCont.id;old_player=player.id
        old_hard=GameCont.hard;old_waypoints=GameCont.waypoints
        old_oasis_visits=scrNTTEFullValue(GameCont,"ntte_visits_oasis",0)
        old_trench_visits=scrNTTEFullValue(GameCont,"ntte_visits_trench",0)
        hop_ends=room_ends;hop_starts=room_starts
        scrNTTEFullOasisTrenchEntryAwait(2);return;
    }
    if(phase==2) {
        if(!instance_exists(clear_portal)) return;
        scrNTTEFullOasisTrenchEntryDiagnostic("actual native clear before Crack")
        assert(clear_portal_spawn && saw_native_clear_alarm && !scr_check_enemies()
            && scrNTTEFullOasisTrenchEntryHostiles()==0 && initial_hostiles>0
            && shot_count>0 && ammo_spent==shot_count && bot_fire_samples>0 && native_hits>0 && native_damage>0,
            "Oasis clear lacks real enemy encounter/native input/ammo/moving projectile damage/Corpse clear Portal")
        assert(room_ends==hop_ends && room_starts==hop_starts,"Oasis combat unexpectedly changed engine rooms")
        scrNTTEFullOasisTrenchEntryAwait(3);return;
    }
    if(phase==3) {
        if(instance_exists(hole)) return;
        assert(initial_hole_hidden && saw_reveal && saw_player_hole_contact && manhole_destroy_seen
            && instance_exists(spawned_portal) && saw_source_spawn && bot_move_samples>0,
            "Genuine Oasis hidden Crack failed reveal/contact/Destroy/source Portal/native movement chain")
        scrNTTEFullOasisTrenchEntryAwait(4);return;
    }
    if(phase==4) {
        if(instance_exists(portal)) {
            saw_open=saw_open || portal.sprite_index==sprPortal
            saw_disappear=saw_disappear || portal.sprite_index==sprPortalDisappear
            return;
        }
        if(!native_restart_requested) return;
        if(room_ends==hop_ends || room_starts==hop_starts) {
            missing_portal_clock+=timescale
            assert(missing_portal_clock<=4,"Actual entrance Alarm1 requested restart without engine RoomEnd/Start");return;
        }
        assert(saw_source_spawn && saw_spawn && saw_open && saw_contact && saw_disappear
            && saw_reclaimed_portal && native_restart_requested && bot_move_samples>0,
            "Oasis Crack ingress omitted source Portal ownership/input/contact/animation/native Alarm1")
        assert(room_ends==hop_ends+1 && room_starts==hop_starts+1,
            "Actual Oasis/Trench ingress did not execute exactly one engine RoomEnd/RoomStart")
        assert(GameCont.id==old_game && instance_exists(old_player) && Player.id==old_player
            && GameCont.area==scrNTTEFullAreaId("trench") && GameCont.subarea==1 && GameCont.loops==0
            && is_undefined(GameCont.ntte_full_pending_destination) && !GameCont.ntte_full_active_oasis
            && scrNTTEFullValue(GameCont,"ntte_visits_oasis",0)==old_oasis_visits,
            "Actual engine ingress lost persistent actors/final Trench1/Oasis transit/consumed queue or changed non-finished Oasis visits")
        assert(scrNTTEFullValue(GameCont,"ntte_visits_trench",0)==old_trench_visits+1,
            "Original current-area Trench0 finish visit missing: expected="+string(old_trench_visits+1)
            +" actual="+string(scrNTTEFullValue(GameCont,"ntte_visits_trench",0)))
        assert(GameCont.hard==old_hard+1 && GameCont.waypoints==old_waypoints+1
            && GameCont.waypnt[old_waypoints]==scrNTTEFullAreaId("trench") && GameCont.waysub[old_waypoints]==1,
            "Actual Crack engine ingress bypassed native difficulty/waypoint accounting")
        for(var _i=0;_i<array_length(old_world);++_i)
            assert(!instance_exists(old_world[_i]),"Actual engine disposal retained old Oasis terrain/renderer")
        scrNTTEFullOasisTrenchEntryAwait(5);return;
    }
    if(phase==5) {
        if(!scrNTTEFullOasisTrenchEntryWorldReady()) return;
        // BEGIN NTTE OASIS TRENCH PHASE5 READONLY TERRAIN DIAGNOSTIC
        var _ntte_phase5_fields={
            area:{present:variable_instance_exists(GameCont,"area"),value:scrNTTEFullValue(GameCont,"area","<absent>")},
            subarea:{present:variable_instance_exists(GameCont,"subarea"),value:scrNTTEFullValue(GameCont,"subarea","<absent>")},
            loops:{present:variable_instance_exists(GameCont,"loops"),value:scrNTTEFullValue(GameCont,"loops","<absent>")},
            active_trench:{present:variable_instance_exists(GameCont,"ntte_active_trench"),value:scrNTTEFullValue(GameCont,"ntte_active_trench","<absent>")},
            full_active_trench:{present:variable_instance_exists(GameCont,"ntte_full_active_trench"),value:scrNTTEFullValue(GameCont,"ntte_full_active_trench","<absent>")},
            underwater:{present:variable_instance_exists(GameCont,"underwater"),value:scrNTTEFullValue(GameCont,"underwater","<absent>")},
            full_active_oasis:{present:variable_instance_exists(GameCont,"ntte_full_active_oasis"),value:scrNTTEFullValue(GameCont,"ntte_full_active_oasis","<absent>")}}
        var _ntte_phase5_actors={floors:instance_number(Floor),tops:instance_number(TopCont),
            backs:instance_number(BackCont),pit_renderers:instance_number(NTTEFullPitRenderer),
            pit_squids:instance_number(NTTEFullPitSquid),players:instance_number(Player),
            generators:instance_number(GenCont),floor_makers:instance_number(FloorMaker),portals:instance_number(Portal)}
        var _ntte_phase5_rewards={parrot_b:scrNTTEFullUnlockGet("skin:parrot:1"),trench_pack:scrNTTEFullUnlockGet("pack:trench")}
        var _ntte_phase5_conditions={
            area_is_trench:_ntte_phase5_fields.area.value==scrNTTEFullAreaId("trench"),
            subarea_is_one:_ntte_phase5_fields.subarea.value==1,loops_are_zero:_ntte_phase5_fields.loops.value==0,
            full_trench_active:_ntte_phase5_fields.full_active_trench.value==true,
            trench_active:_ntte_phase5_fields.active_trench.value==true,underwater:_ntte_phase5_fields.underwater.value==true,
            oasis_inactive:_ntte_phase5_fields.full_active_oasis.value==false,
            floors_gt_twenty:_ntte_phase5_actors.floors>20,exactly_one_top:_ntte_phase5_actors.tops==1,
            back_exists:instance_exists(BackCont),exactly_one_pit_renderer:_ntte_phase5_actors.pit_renderers==1,
            pit_squid_absent:!instance_exists(NTTEFullPitSquid),parrot_b_absent:!_ntte_phase5_rewards.parrot_b,
            trench_pack_absent:!_ntte_phase5_rewards.trench_pack}
        var _ntte_phase5_pit_grid=variable_global_exists("ntte_full_trench_pit_grid")?global.ntte_full_trench_pit_grid:-1
        scrNTTESmokeLog("OASIS TRENCH PHASE5 READONLY "+json_stringify({
            expected_rate:rates[pass_index],runtime_fps:game_get_speed(gamespeed_fps),logic_scale:timescale,
            phase:phase,elapsed:elapsed,frame:current_frame,draw_frames:draw_frames,world_ready_draw:world_ready_draw,
            draws_since_ready:draw_frames-world_ready_draw,room_ends:room_ends,room_starts:room_starts,
            game:GameCont.id,old_game:old_game,player:player,old_player:old_player,
            fields:_ntte_phase5_fields,actors:_ntte_phase5_actors,rewards:_ntte_phase5_rewards,conditions:_ntte_phase5_conditions,
            pending_cleared:is_undefined(scrNTTEFullValue(GameCont,"ntte_full_pending_destination",undefined)),
            native_trench_visits:scrNTTEFullValue(GameCont,"ntte_visits_trench","<absent>"),
            compatibility_trench_visits:scrNTTEFullValue(GameCont,"ntte_full_visits_trench","<absent>"),
            top_darkness:instance_exists(TopCont)?scrNTTEFullValue(TopCont,"darkness","<absent>"):"<no TopCont>",
            pit_grid_present:variable_global_exists("ntte_full_trench_pit_grid"),pit_grid_valid:ds_exists(_ntte_phase5_pit_grid,ds_type_grid),
            pit_dirty:variable_global_exists("ntte_full_trench_pit_dirty")?global.ntte_full_trench_pit_dirty:"<absent>",
            pit_floor_count:variable_global_exists("ntte_full_trench_floor_count")?global.ntte_full_trench_floor_count:"<absent>"}))
        // END NTTE OASIS TRENCH PHASE5 READONLY TERRAIN DIAGNOSTIC
        assert(GameCont.area==scrNTTEFullAreaId("trench") && GameCont.subarea==1 && GameCont.loops==0
            && GameCont.ntte_full_active_trench && GameCont.ntte_active_trench && GameCont.underwater
            && !GameCont.ntte_full_active_oasis && instance_number(Floor)>20 && instance_number(TopCont)==1
            && instance_exists(BackCont) && instance_number(NTTEFullPitRenderer)==1
            && !instance_exists(NTTEFullPitSquid) && !scrNTTEFullUnlockGet("skin:parrot:1")
            && !scrNTTEFullUnlockGet("pack:trench"),
            "Actually entered Trench1+8Draw omitted source underwater terrain/pit renderer or granted final rewards early")
        scrNTTESmokeLog("PASS OASIS TRENCH NATURAL ENTRY: controlled initial Oasis1/loop0/Fish/legal loadout/protected HP/XP suppression; actual async generation+8Draw, actual sampled combat/ammo/moving projectile damage/Corpse clear Portal, original hidden/contact/two-frame Crack reveal+Destroy, source new+reclaimed entrance Portal, native contact/animation/Alarm1 room_restart/exactly1 engine RoomEnd+Start/bookkeeping/old-world disposal, actual Trench1 complete+8Draw; no upstream Coast/full Trench/iPhone claim @"+string(rates[pass_index]))
        if(++pass_index<array_length(rates)) {scrNTTEFullOasisTrenchEntryAwait(0);return;}
        scrNTTEFullOasisTrenchEntryRestore()
        scrNTTESmokeLog("PASS full internal selected implemented branches x 30/60; not complete MOD coverage")
        game_end()
    }
}
function scrNTTEFullOasisTrenchEntryStep() {
    try {scrNTTEFullOasisTrenchEntryStepBody()}
    catch(_error) {scrNTTEFullOasisTrenchEntryRestore();throw _error}
}

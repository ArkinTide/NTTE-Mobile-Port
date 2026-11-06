// Controlled Trench3 entry, then real combat/clear/portal/engine transition.
// This is NOT evidence for the earlier Desert/Coast/Oasis/Trench1-2 route.
function scrNTTEFullParrotBConnectedRead(_path) {
    if(!file_exists(_path)) return undefined;
    var _file=file_text_open_read(_path),_text=""
    while(!file_text_eof(_file)) {_text+=file_text_read_string(_file);file_text_readln(_file)}
    file_text_close(_file);return _text
}
function scrNTTEFullParrotBConnectedClear() {
    var _keep=id
    with(all) if(id!=_keep && object_index!=UberCont && object_index!=Console) instance_destroy(id,false)
}
function scrNTTEFullParrotBConnectedRestore() {
    if(restored) return;
    restored=true;want_pointer=false
    if(path_exists(bot_path)) path_delete(bot_path)
    var _unchanged=ds_map_write(old_save_map)==old_savedata
    // Dedicated-process teardown while private data still owns all actor
    // cleanup. game_end must not later RoomEnd a measured fixture GameCont.
    scrNTTEFullParrotBConnectedClear()
    scrNTTEFullAreaGeneratorRestore(old_global_graph)
    for(var _i=0;_i<array_length(old_global_vars);++_i)
        variable_global_set(old_global_vars[_i][0],old_global_vars[_i][1])
    scrNTTEFullAreaGeneratorRestore(old_uber)
    UberCont.saveData=old_save_map
    if(ds_exists(fixture_save_map,ds_type_map)) ds_map_destroy(fixture_save_map)
    UberCont.opt_autopause=old_autopause;UberCont.opt_framerate=old_framerate
    game_set_speed(old_game_speed,gamespeed_fps)
    game_directory=old_directory;global.ntte_full_progress=old_progress
    global.ntte_full_feature_ready=old_ready;global.ntte_smoke_active=old_smoke
    if(old_continue>=0) {buffer_save(old_continue,savegame_file);buffer_delete(old_continue)}
    else if(file_exists(savegame_file)) file_delete(savegame_file)
    for(var _i=0;_i<array_length(scratch_files);++_i)
        if(file_exists(scratch_files[_i])) file_delete(scratch_files[_i])
    random_set_seed(old_seed)
    assert(_unchanged && ds_map_write(old_save_map)==old_savedata,
        "Parrot B connected fixture or private teardown changed original options/save map")
    // UberCont.RoomEnd changes fullscreen/tot_time before dont_save. This
    // dedicated process is terminating after original pointer+bytes restored.
    instance_deactivate_object(UberCont)
}
function scrNTTEFullParrotBConnectedTests() {
    assert(os_type==os_windows && scrNTTEFullSmokeEnabled(),"Parrot B connected requires explicit Windows full smoke")
    assert(!instance_exists(NTTEFullParrotBConnectedTest),"Parrot B connected observer duplicated")
    var _observer=instance_create(0,0,NTTEFullParrotBConnectedTest)
    with(_observer) {
        restored=false;scratch_files=[];old_global_vars=[]
        old_directory=game_directory;old_progress=global.ntte_full_progress
        old_ready=global.ntte_full_feature_ready;old_smoke=global.ntte_smoke_active
        old_continue=file_exists(savegame_file)?buffer_load(savegame_file):-1
        old_seed=random_get_seed();old_save_map=UberCont.saveData;old_savedata=ds_map_write(old_save_map)
        old_autopause=UberCont.opt_autopause;old_framerate=UberCont.opt_framerate
        old_game_speed=game_get_speed(gamespeed_fps);old_uber=scrNTTEFullAreaGeneratorSnapshot(UberCont)
        var _names=variable_struct_get_names(global),_graph={nodes:[]}
        for(var _i=0;_i<array_length(_names);++_i) {
            var _name=_names[_i],_value=variable_global_get(_name)
            array_push(old_global_vars,[_name,_value]);scrNTTEFullAreaSnapshotContainer(_value,_graph)
        }
        old_global_graph={instances:[],containers:_graph.nodes}
        fixture_save_map=ds_map_create();ds_map_copy(fixture_save_map,old_save_map);UberCont.saveData=fixture_save_map
        rates=[30,60];pass_index=0;phase=0;elapsed=0;draw_frames=0;draw_start=0
        room_ends=0;room_starts=0;want_pointer=false;pointer_injections=0;injected_phase=-1
        target_race=NTTEFullRace.Parrot;target_skin=1;menu=noone;player=noone;boss=noone;portal=noone
        bot_path=path_add();bot_target=noone;bot_path_clock=0;bot_path_cursor=0
        current_seed=701932;bot_trench_native_mask_path=false
        scratch_root=working_directory+"parrot-b-connected-"+string(get_timer())+"/";directory_create(scratch_root)
        global.ntte_smoke_active=false
        smoke_drivers=scrNTTEFullInstances(NTTESmokeTest)
        with(NTTESmokeTest) instance_deactivate_object(id)
        scrNTTEFullParrotBConnectedClear()
    }
}
function scrNTTEFullParrotBConnectedAwait(_next) {
    phase=_next;elapsed=0;draw_start=draw_frames;want_pointer=false
    scrNTTESmokeLog("PARROT B CONNECTED phase="+string(phase)+" rate="+string(rates[min(pass_index,1)]))
}
function scrNTTEFullParrotBConnectedActualRate(_boundary) {
    assert(UberCont.saveData==fixture_save_map && ds_map_write(old_save_map)==old_savedata,
        "Parrot B connected changed original save map or lost isolated copy: "+_boundary)
    assert(game_get_speed(gamespeed_fps)==rates[pass_index] && timescale==30/rates[pass_index]
        && UberCont.opt_framerate==rates[pass_index] && !UberCont.opt_autopause
        && fixture_save_map[? "options_framerate"]==rates[pass_index]
        && fixture_save_map[? "options_autopause"]==false,
        "Parrot B connected native boundary reset actual FPS/options/timescale: "+_boundary)
    scrNTTESmokeLog("PARROT B CONNECTED ACTUAL RATE "+_boundary+" "+json_stringify({
        runtime_fps:game_get_speed(gamespeed_fps),logic_scale:timescale,original_savedata_unchanged:true}))
}
// Observer-only diagnostics. All actor fields are read; no lifecycle, input,
// ammo, projectile, map or progress value is changed to satisfy acceptance.
function scrNTTEFullParrotBConnectedClearDiagnostic(_boundary,_force) {
    var _boss_live=instance_exists(boss),_death_count=instance_number(NTTEFullPitSquidDeath),
        _prevent_count=instance_number(NTTEFullPortalPrevent),_portal_count=instance_number(Portal),
        _boss_state={id:boss,exists:_boss_live},_player_state={id:player,exists:instance_exists(player)},
        _deaths=[],_prevents=[],_hostile_count=0,_arms=[],_target_state={id:bot_target,exists:instance_exists(bot_target)}
    if(instance_exists(bot_target)) {
        _target_state.object=object_get_name(bot_target.object_index)
        _target_state.x=bot_target.x;_target_state.y=bot_target.y
        _target_state.visible=bot_target.visible;_target_state.mask=bot_target.mask_index
    }
    if(_boss_live) {
        _boss_state.hp=boss.hp;_boss_state.max_hp=boss.max_hp
        _boss_state.intro=boss.ntte_full_intro;_boss_state.can_intro=boss.ntte_full_can_intro
        _boss_state.pit_height=boss.ntte_full_pit_height;_boss_state.sink=boss.ntte_full_sink
        _boss_state.rise_delay=boss.ntte_full_rise_delay;_boss_state.timers=boss.ntte_full_timers
        _boss_state.mask=boss.mask_index;_boss_state.target=boss.target;_boss_state.team=boss.team
        _boss_state.x=boss.ntte_full_x;_boss_state.y=boss.ntte_full_y
    }
    if(instance_exists(player)) {
        _player_state.hp=player.hp;_player_state.x=player.x;_player_state.y=player.y
        _player_state.wep=player.wep;_player_state.bwep=player.bwep
        _player_state.ammo=player.ammo;_player_state.reload=player.reload
        _player_state.can_shoot=player.can_shoot;_player_state.can_walk=player.can_walk
        _player_state.can_aim=player.can_aim;_player_state.team=player.team
        _player_state.infammo=player.infammo
    }
    with(enemy) if(hp>0 && team!=team_player && !instance_is(id,Van)) _hostile_count++
    with(NTTEFullPitSquidArm) array_push(_arms,{id:id,creator:creator,hp:hp,
        visible:visible,mask:mask_index,x:x,y:y})
    with(NTTEFullPitSquidDeath) array_push(_deaths,{id:id,pit_height:ntte_full_pit_height,
        explode:ntte_full_explode,sink:ntte_full_sink,timers:ntte_full_timers})
    with(NTTEFullPortalPrevent) array_push(_prevents,{id:id,creator:creator})
    // Exclude frame/timer/input counters from this signature: lifecycle changes
    // are logged once, while the forced pre-assert record always has all values.
    var _signature=json_stringify([_boss_live,_boss_live?boss.hp:-1,
        _boss_live?boss.ntte_full_intro:false,_boss_live?boss.ntte_full_can_intro:false,
        _death_count,_prevent_count,_portal_count,instance_number(NTTEFullPitSquidArm),
        saw_intro,saw_death,saw_prevent,_hostile_count])
    if(!_force && _signature==diagnostic_signature) return;
    diagnostic_signature=_signature
    scrNTTESmokeLog("PARROT B CLEAR DIAGNOSTIC "+_boundary+" "+json_stringify({
        rate:rates[pass_index],phase:phase,elapsed:elapsed,frame:current_frame,
        conditions:{boss_gone:!_boss_live,staged_death_gone:_death_count==0,
            saw_intro:saw_intro,saw_death:saw_death,saw_prevent:saw_prevent,
            arm_hits_positive:arm_hits>0,forwarded_at_least_initial:forwarded_damage>=boss_hp,
            last_hp_lethal:last_boss_hp<=0,shots_positive:shot_count>0,
            sampled_fire_positive:bot_fire_samples>0,ammo_matches_shots:ammo_spent==shot_count},
        initial_hp:boss_hp,last_observed_hp:last_boss_hp,arm_hits:arm_hits,
        forwarded_damage:forwarded_damage,shots:shot_count,ammo_spent:ammo_spent,
        native_shot_records:array_length(native_shots),bot_fire_samples:bot_fire_samples,
        bot_move_samples:bot_move_samples,bot_was_fire:bot_was_fire,bot_target:bot_target,
        path_points:path_get_number(bot_path),path_cursor:bot_path_cursor,bot_target_state:_target_state,
        boss:_boss_state,player:_player_state,arms:_arms,staged_deaths:_deaths,prevents:_prevents,
        boss_count:instance_number(NTTEFullPitSquid),death_count:_death_count,
        prevent_count:_prevent_count,portal_count:_portal_count,hostile_count:_hostile_count,
        lockstep_stop:lockstep_stop,generation_active:instance_exists(GenCont)||instance_exists(FloorMaker),
        pack_owned:scrNTTEFullUnlockGet("pack:trench"),b_owned:scrNTTEFullUnlockGet("skin:parrot:1"),
        room_ends:room_ends,room_starts:room_starts}))
}
function scrNTTEFullParrotBConnectedBulletBefore(_target) {
    if(os_type!=os_windows || !scrNTTEFullSmokeEnabled()) return undefined;
    var _observer=instance_find(NTTEFullParrotBConnectedTest,0)
    if(!instance_exists(_observer) || _observer.phase!=2 || creator!=_observer.player
        || !instance_exists(_target) || !instance_is(_target,NTTEFullPitSquidArm)) return undefined;
    var _boss=_target.creator
    if(!instance_exists(_boss) || _boss!=_observer.boss) return undefined;
    var _record=undefined
    for(var _i=0;_i<array_length(_observer.native_shots);++_i)
        if(_observer.native_shots[_i].shot==id) {_record=_observer.native_shots[_i];break}
    assert(is_struct(_record),"Boss arm collision has no real PlayerFiring/scrFire shot provenance")
    assert(damage==_record.damage && damage==(object_index==Bolt?20:3)
        && point_distance(x,y,_record.x,_record.y)>1,
        "Boss arm hit changed original weapon damage or skipped actual native projectile movement")
    return {boss:_boss,arm:_target,hp:_boss.hp,arm_hp:_target.hp,shot:id,
        damage:damage,travel:point_distance(x,y,_record.x,_record.y),weapon:_record.weapon}
}
function scrNTTEFullParrotBConnectedBulletAfter(_sample) {
    if(!is_struct(_sample) || !instance_exists(_sample.boss)) return;
    var _observer=instance_find(NTTEFullParrotBConnectedTest,0)
    if(!instance_exists(_observer) || _observer.phase!=2) return;
    var _loss=_sample.hp-_sample.boss.hp
    if(_loss<=0) return;
    _observer.arm_hits++;_observer.forwarded_damage+=_loss
    _observer.last_boss_hp=_sample.boss.hp
    assert(_sample.arm_hp>0 && _loss<=_sample.arm_hp,
        "Real native Bullet1/PitSquidArm collision forwarded overkill beyond the remaining arm HP")
    scrNTTESmokeLog("PARROT B REAL ARM COLLISION "+json_stringify({shot:_sample.shot,arm:_sample.arm,
        arm_hp_before:_sample.arm_hp,boss:_sample.boss,boss_before:_sample.hp,boss_after:_sample.boss.hp,
        original_damage:_sample.damage,native_travel:_sample.travel,weapon:_sample.weapon,
        forwarded:_loss,total:_observer.forwarded_damage,rate:_observer.rates[_observer.pass_index]}))
}
function scrNTTEFullParrotBConnectedFireBefore(_weapon) {
    var _observer=instance_find(NTTEFullParrotBConnectedTest,0)
    if(!instance_exists(_observer) || _observer.phase!=2 || id!=_observer.player) return undefined;
    assert(_weapon==wep_auto_crossbow || _weapon==wep_minigun,"Bot changed its declared legal starting weapons")
    assert(infammo==0 && !global.__debug_infammo,"Bot bypassed normal weapon ammo consumption")
    return {weapon:_weapon,before:scrNTTEFullInstances([Bolt,Bullet1]),
        ammo:ammo[scr_weapon_get_type(_weapon)],clock:current_frame}
}
function scrNTTEFullParrotBConnectedFireAfter(_sample) {
    if(!is_struct(_sample)) return;
    var _observer=instance_find(NTTEFullParrotBConnectedTest,0)
    if(!instance_exists(_observer) || _observer.phase!=2 || id!=_observer.player) return;
    assert(ammo[scr_weapon_get_type(_sample.weapon)]==_sample.ammo-scr_weapon_get_cost(_sample.weapon)
        && reload==scr_weapon_get_load(_sample.weapon) && !can_shoot,
        "Native bot fire bypassed source ammo cost or original weapon reload")
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
    assert(_new==1,"Actual ordinary Auto Crossbow/Minigun fire did not emit exactly one original projectile")
    _observer.shot_count++;_observer.ammo_spent+=scr_weapon_get_cost(_sample.weapon)
}
function scrNTTEFullParrotBConnectedBotTarget() {
    var _best=infinity,_next=noone,_hidden=noone,_hidden_distance=infinity
    with(enemy) if(hp>0 && team!=other.player.team && object_index!=NTTEFullPitSquid) {
        var _distance=point_distance(x,y,other.player.x,other.player.y)
        if(visible && mask_index!=mskNone) {
            if(_distance<_best) {_best=_distance;_next=id}
        }
        else if(_distance<_hidden_distance) {_hidden_distance=_distance;_hidden=id}
    }
    return instance_exists(_next)?_next:_hidden
}
// Deterministic read-only planning for the sampled-input bot. A hostile's
// exact cell may be blocked by the conservative wall padding even though an
// ordinary player can fire from a reachable position beside it.
function scrNTTEFullParrotBConnectedNativeClear(_player,_x,_y) {
    var _steps=max(1,ceil(point_distance(_player.x,_player.y,_x,_y)/2))
    for(var _i=0;_i<=_steps;++_i) {
        var _px=lerp(_player.x,_x,_i/_steps),_py=lerp(_player.y,_y,_i/_steps),_free=false
        with(_player) _free=!place_meeting(_px,_py,Wall)
        if(!_free) return false;
    }
    return true
}
function scrNTTEFullParrotBConnectedTryPath(_grid,_path,_player,_gx,_gy,_left,_top,_columns,_rows) {
    path_clear_points(_path)
    if(mp_grid_path(_grid,_path,_player.x,_player.y,_gx,_gy,false)) return true;
    var _sx=floor((_player.x-_left)/8),_sy=floor((_player.y-_top)/8)
    if(_sx<0 || _sy<0 || _sx>=_columns || _sy>=_rows
        || mp_grid_get_cell(_grid,_sx,_sy)>=0
        || !scrNTTEFullParrotBConnectedNativeClear(_player,_player.x,_player.y)) return false;
    for(var _r=1;_r<=3;++_r) {
        for(var _dx=-_r;_dx<=_r;++_dx) for(var _dy=-_r;_dy<=_r;++_dy) {
            if(max(abs(_dx),abs(_dy))!=_r) continue;
            var _cx=_sx+_dx,_cy=_sy+_dy
            if(_cx<0 || _cy<0 || _cx>=_columns || _cy>=_rows
                || mp_grid_get_cell(_grid,_cx,_cy)<0) continue;
            var _px=_left+(_cx+0.5)*8,_py=_top+(_cy+0.5)*8
            if(!collision_point(_px,_py,Floor,false,false)
                || !scrNTTEFullParrotBConnectedNativeClear(_player,_px,_py)) continue;
            path_clear_points(_path)
            if(mp_grid_path(_grid,_path,_px,_py,_gx,_gy,false) && path_get_number(_path)>1) {
                bot_path_cursor=0
                return true;
            }
        }
    }
    path_clear_points(_path)
    return false
}
function scrNTTEFullParrotBConnectedPlanPath(_grid,_path,_player,_target,_left,_top,_columns,_rows) {
    if(scrNTTEFullParrotBConnectedTryPath(_grid,_path,_player,_target.x,_target.y,_left,_top,_columns,_rows)) return true;
    var _radii=[32,48,64,80]
    for(var _ri=0;_ri<array_length(_radii);++_ri) {
        for(var _ai=0;_ai<8;++_ai) {
            var _angle=_ai*45,_gx=_target.x+lengthdir_x(_radii[_ri],_angle),
                _gy=_target.y+lengthdir_y(_radii[_ri],_angle),_native_free=false
            if(!collision_point(_gx,_gy,Floor,false,false)
                || collision_line(_gx,_gy,_target.x,_target.y,Wall,false,false)) continue;
            with(_player) _native_free=!place_meeting(_gx,_gy,Wall)
            if(!_native_free) continue;
            path_clear_points(_path)
            if(scrNTTEFullParrotBConnectedTryPath(_grid,_path,_player,_gx,_gy,_left,_top,_columns,_rows)) return true;
        }
    }
    path_clear_points(_path)
    scrNTTESmokeLog("PARROT B PATH BLOCKED "+json_stringify({
        target:object_get_name(_target.object_index),target_id:_target.id,
        target_x:_target.x,target_y:_target.y,player_x:_player.x,player_y:_player.y,
        start_cell:mp_grid_get_cell(_grid,floor((_player.x-_left)/8),floor((_player.y-_top)/8)),
        goal_cell:mp_grid_get_cell(_grid,floor((_target.x-_left)/8),floor((_target.y-_top)/8))}))
    return false
}
function scrNTTEFullParrotBConnectedBotAfterSample(_keycont,_index) {
    var _observer=instance_find(NTTEFullParrotBConnectedTest,0)
    if(!instance_exists(_observer) || _observer.restored || _observer.phase!=2
        || !instance_exists(_observer.player) || _observer.player.index!=_index) return;
    var _player=_observer.player,_fire=false,_moving=false,_direction=0,_swap=false
    if(!instance_exists(GenCont) && !instance_exists(FloorMaker)) with(_observer) {
        var _target=scrNTTEFullParrotBConnectedBotTarget()
        if(instance_exists(_target)) {
            var _distance=point_distance(player.x,player.y,_target.x,_target.y),
                _clear=!collision_line(player.x,player.y,_target.x,_target.y,Wall,false,false)
            _direction=point_direction(player.x,player.y,_target.x,_target.y)
            _keycont.dir_fire[_index]=_direction
            var _type=scr_weapon_get_type(player.wep)
            _swap=player.ammo[_type]<=0 && player.ammo[scr_weapon_get_type(player.bwep)]>0
            _fire=!_swap && _clear && _distance<128 && _target.visible && _target.mask_index!=mskNone
                && player.ammo[_type]>0
            _moving=(!_clear || _distance>80 || !_target.visible || _target.mask_index==mskNone) && _distance>24
            bot_path_clock-=timescale
            if(_moving && !_clear) {
                if(bot_target!=_target || bot_path_clock<=0) {
                    bot_target=_target;bot_path_clock=20;bot_path_cursor=1
                    assert(instance_number(Floor)>0,"Combat bot lost actual generated terrain before path planning")
                    var _left=infinity,_top=infinity,_right=-infinity,_bottom=-infinity
                    with(Floor) {_left=min(_left,bbox_left);_top=min(_top,bbox_top)
                        _right=max(_right,bbox_right);_bottom=max(_bottom,bbox_bottom)}
                    _left=floor((_left-64)/8)*8;_top=floor((_top-64)/8)*8
                    var _columns=ceil((_right+64-_left)/8),_rows=ceil((_bottom+64-_top)/8),
                        _grid=mp_grid_create(_left,_top,_columns,_rows,8,8)
                    with(Wall) mp_grid_add_rectangle(_grid,bbox_left-5,bbox_top-3,bbox_right+5,bbox_bottom+3)
                    bot_trench_native_mask_path=false
                    var _planned=scrNTTEFullParrotBConnectedPlanPath(_grid,bot_path,player,_target,_left,_top,_columns,_rows)
                    if(!_planned && path_get_number(bot_path)<=1) {
                        var _native_bounds={x:_left,y:_top,width:_columns,height:_rows}
                        if(scrNTTETrenchNativeNavFallback(_native_bounds,_target.x,_target.y)) bot_path_cursor=1
                    }
                    mp_grid_destroy(_grid)
                }
                if(path_get_number(bot_path)>1) {
                    if(bot_trench_native_mask_path) {
                        var _native_direction=scrNTTETrenchNativeNavFollow()
                        if(is_undefined(_native_direction)) _moving=false
                        else _direction=_native_direction
                    } else {
                        while(bot_path_cursor<path_get_number(bot_path)-1
                            && point_distance(player.x,player.y,path_get_point_x(bot_path,bot_path_cursor),path_get_point_y(bot_path,bot_path_cursor))<6)
                            bot_path_cursor++
                        _direction=point_direction(player.x,player.y,path_get_point_x(bot_path,bot_path_cursor),path_get_point_y(bot_path,bot_path_cursor))
                    }
                }
                else _moving=false
            }
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
function scrNTTEFullParrotBConnectedPortalProbe(_stage) {
    if(os_type!=os_windows || !scrNTTEFullSmokeEnabled()) return;
    var _observer=instance_find(NTTEFullParrotBConnectedTest,0)
    if(!instance_exists(_observer) || (_observer.phase!=2 && _observer.phase!=3) || id!=_observer.portal) return;
    if(sprite_index==sprPortalSpawn) _observer.saw_spawn=true
    if(sprite_index==sprPortal) _observer.saw_open=true
    if(sprite_index==sprPortalDisappear) _observer.saw_disappear=true
    if(_stage=="Collision.Player.after" && endgame<=30) _observer.saw_collision=true
    if(_stage=="Alarm1.before") _observer.native_restart_requested=true
    scrNTTESmokeLog("PARROT B REAL PORTAL "+_stage+" "+json_stringify({portal:id,
        sprite:sprite_get_name(sprite_index),endgame:endgame,phase:_observer.phase,
        room_ends:_observer.room_ends,room_starts:_observer.room_starts,
        owns_b:scrNTTEFullUnlockGet("skin:parrot:1"),owns_pack:scrNTTEFullUnlockGet("pack:trench")}))
}
function scrNTTEFullParrotBConnectedAfterSample(_pinst) {
    if(os_type!=os_windows || !scrNTTEFullSmokeEnabled()) return undefined;
    var _observer=instance_find(NTTEFullParrotBConnectedTest,0)
    if(!instance_exists(_observer) || !_observer.want_pointer || id!=_observer.menu) return undefined;
    var _phase=_observer.phase
    if((_phase!=7 && _phase!=8) || _pinst.get_index()!=0 || _pinst.get_race()!=NTTEFullRace.Parrot) return undefined;
    _observer.want_pointer=false;_observer.pointer_injections++;_observer.injected_phase=_phase
    return {x:_observer.pointer_x,y:_observer.pointer_y,press:true}
}
function scrNTTEFullParrotBConnectedPointer(_skin) {
    var _w=gui_w,_h=gui_h,_crownsize=sprite_get_height(sprLoadoutCrown)-4,
        _columns=max(1,(_h-LETTERBOX_SIZE*4) div _crownsize),
        _rows=array_length(scrNTTEFullCrownLoadoutSlots()) div _columns,
        _left=_w+12-_rows*_crownsize,_slots=scrNTTEFullSkinSlots(target_race),
        _skinsize=sprite_get_width(sprLoadoutSkin)-4
    if(_skin) {
        var _slot=array_get_index(_slots,target_skin)
        assert(_slot>=0,"Parrot B missing from native skin slots")
        pointer_x=_left-_crownsize div 2-22
        pointer_y=(_h div 2)-(_skinsize*0.5)*array_length(_slots)-2+_slot*_skinsize
    }
    else {pointer_x=_w+2-16;pointer_y=_h-LETTERBOX_SIZE+2-16}
    want_pointer=true;injected_phase=-1
}
function scrNTTEFullParrotBConnectedArt() {
    assert(Player.bskin==1 && Player.race==NTTEFullRace.Parrot
        && Player.spr_idle==scrNTTEFullRaceSprite(NTTEFullRace.Parrot,"Idle",1)
        && Player.spr_walk==scrNTTEFullRaceSprite(NTTEFullRace.Parrot,"Walk",1)
        && Player.spr_hurt==scrNTTEFullRaceSprite(NTTEFullRace.Parrot,"Hurt",1),
        "Native new/continued Parrot B Player lost its actual authored body art")
}
function scrNTTEFullParrotBConnectedStepBody() {
    elapsed+=timescale
    assert(elapsed<=3600,"Parrot B connected timeout phase="+string(phase))
    if(phase>=2) assert(UberCont.saveData==fixture_save_map && ds_map_write(old_save_map)==old_savedata
        && game_get_speed(gamespeed_fps)==rates[pass_index] && timescale==30/rates[pass_index]
        && UberCont.opt_framerate==rates[pass_index] && !UberCont.opt_autopause,
        "Parrot B connected actual native frame options changed")
    if(instance_exists(Player)) with(Player) {
        hp=100000;max_hp=100000;lsthealth=100000;nexthurt=current_frame+100000
        can_walk=other.phase==2;can_aim=other.phase==2
        if(other.phase!=2) speed=0
    }
    if(phase==0) {
        for(var _i=0;_i<array_length(smoke_drivers);++_i) {
            instance_activate_object(smoke_drivers[_i])
            if(instance_exists(smoke_drivers[_i])) instance_destroy(smoke_drivers[_i],false)
        }
        smoke_drivers=[];scrNTTEFullParrotBConnectedClear()
        save_set_value("options","autopause",false);save_set_value("options","framerate",rates[pass_index])
        save_set_value("options","keyboard",true);save_set_value("options","gamepad",false)
        UberCont.opt_framerate=rates[pass_index];game_set_speed(rates[pass_index],gamespeed_fps)
        UberCont.opt_autopause=false;UberCont.paused=false;UberCont.want_pause=false;UberCont.opt_freeze=0
        UberCont.opt_keyboard=true;UberCont.opt_gamepad=false;UberCont.block_input_frames=0;UberCont.block_input_fire=false
        UberCont.opt_bossintro=false;UberCont.daily_run=false;UberCont.weekly_run=false;UberCont.coop=false;UberCont.hardmode=false
        UberCont.want_quit_to_menu=false;UberCont.show_leaderboards_menu=false
        global.is_server=true;global.index=0;global.custom_seed=0;global.seed=701932
        global.__debug_infammo=false
        global.crownpick=crwn_none;global.recontinued_times=0
        scrGameCustomModeReset();scr_playerinstances_reset_all();my_player.race=target_race;my_player.skin=0
        UberCont.cskin[target_race]=0
        if(file_exists(savegame_file)) file_delete(savegame_file)
        game_directory=scratch_root+string(rates[pass_index])+"/";directory_create(game_directory)
        var _files=["ntte-full-progress.json","ntte-full-progress.json.bak","ntte-full-progress.json.tmp","NuclearThrone.sav"]
        for(var _i=0;_i<array_length(_files);++_i) array_push(scratch_files,game_directory+_files[_i])
        global.ntte_full_progress={schema:1,unlocks:{},loadouts:{},stats:{}}
        // Explicit prerequisite: already owns/selects Parrot A. B and final
        // Trench pack begin absent. This does not claim a natural Coast entry.
        global.ntte_full_progress.unlocks[$ "race:parrot"]=true
        global.ntte_full_feature_ready={};global.ntte_full_feature_ready[$ "race:parrot"]=true
        save_set_value("game","tutorial",false)
        assert(player_count==1 && !scrNTTEFullUnlockGet("skin:parrot:1")
            && !scr_race_is_skin_unlocked(target_race,1) && !scrNTTEFullUnlockGet("pack:trench"),
            "Controlled solo prerequisite already owns Parrot B or Trench completion")
        scrNTTEFullParrotBConnectedAwait(1);return;
    }
    if(phase==1) {
        scrNTTEFullParrotBConnectedActualRate("settled controlled Trench3 entry")
        instance_create(0,0,GameCont);instance_create(0,0,BackCont);instance_create(0,0,MusCont)
        scrCreatePlayers(0);player=instance_find(Player,0)
        assert(instance_number(Player)==1 && player.race==target_race && player.bskin==0,
            "Controlled Trench3 prerequisite did not create solo selected Parrot A")
        // Legal controlled initial equipment and native maximum ammo only.
        // All later reload, cost, swap, projectiles and hits belong to native
        // PlayerFiring/scrFire and the sampled bot inputs; no refills/DPS edits.
        player.wep=wep_auto_crossbow;player.bwep=wep_minigun;player.infammo=0
        player.ammo[Ammo.Bolts]=typ_amax[Ammo.Bolts];player.ammo[Ammo.Bullets]=typ_amax[Ammo.Bullets]
        player.can_walk=true;player.can_aim=true
        GameCont.area=scrNTTEFullAreaId("trench");GameCont.subarea=3;GameCont.loops=0;GameCont.hard=9
        GameCont.maxsubarea=scrAreaGetMaxSubarea(GameCont.area);GameCont.finalsubarea=true
        // Controlled combat acceptance excludes XP/level-choice progression.
        GameCont.rad=-100000;GameCont.skillpoints=0;GameCont.crownpoints=0;GameCont.ultrapoints=0
        GameCont.ntte_full_source_seed=scrNTTEFullSourceSeedBuild(global.seed)
        GameCont.ntte_full_source_pending_generation=undefined
        global.ntte_full_sync_generation=false;global.rng_state[@RNGStates.Generation]=701932
        var _gen=instance_create(0,0,GenCont)
        assert(!_gen.ntte_full_sync_generation,"Parrot B fixture bypassed native asynchronous map generation")
        boss=noone;boss_hp=0;last_boss_hp=0;arm_hits=0;forwarded_damage=0;shot_count=0;ammo_spent=0
        native_shots=[];bot_was_fire=false;bot_fire_samples=0;bot_move_samples=0
        bot_target=noone;bot_path_clock=0;bot_path_cursor=0;path_clear_points(bot_path)
        saw_intro=false;saw_death=false;saw_prevent=false;natural_map=false;diagnostic_signature=""
        portal=noone;room_ends=0;room_starts=0
        saw_spawn=false;saw_open=false;saw_collision=false;saw_disappear=false;native_restart_requested=false
        scrNTTEFullParrotBConnectedAwait(2);return;
    }
    if(phase==2) {
        if(instance_exists(GenCont) || instance_exists(FloorMaker)) return;
        assert(GameCont.area==scrNTTEFullAreaId("trench") && GameCont.subarea==3
            && GameCont.ntte_full_active_trench && instance_number(Floor)>20 && instance_exists(NTTEFullPitRenderer),
            "Actual Trench3 generation omitted area lifecycle/map/pit renderer")
        if(!natural_map) {
            assert(instance_number(NTTEFullPitSquid)==1,"Native Trench3 failed exactly one natural PitSquid")
            boss=instance_find(NTTEFullPitSquid,0);boss_hp=boss.hp;last_boss_hp=boss.hp;natural_map=true
            assert(boss_hp==scrNTTEFullSewerBossHP(340) && boss.mask_index==mskNone,
                "Naturally generated boss changed source HP or exposed hidden collision root")
            scrNTTEFullParrotBConnectedActualRate("actual native Trench3 map before combat")
        }
        assert(!scrNTTEFullUnlockGet("skin:parrot:1") && room_ends==0,
            "Parrot B was granted before actual final exit")
        if(instance_exists(boss)) {
            assert(boss.mask_index==mskNone,"Fixture or production exposed hidden root outside attack callback")
            if(boss.ntte_full_intro) saw_intro=true
        }
        var _observer_id=id
        with(NTTEFullPitSquidDeath) {
            _observer_id.saw_death=true
            var _death=id
            with(NTTEFullPortalPrevent) if(creator==_death) _observer_id.saw_prevent=true
        }
        scrNTTEFullParrotBConnectedClearDiagnostic("observed lifecycle",false)
        if(instance_exists(Portal)) {
            if(!instance_exists(portal)) portal=instance_find(Portal,0)
            if(portal.sprite_index==sprPortalSpawn) saw_spawn=true
            if(portal.sprite_index==sprPortal) saw_open=true
            // This observer was created before GameCont: its Step can see a
            // new Alarm-created portal before GameCont's clear-frame award.
            if(!scrNTTEFullUnlockGet("pack:trench")) return;
            scrNTTEFullParrotBConnectedClearDiagnostic("before unchanged natural clear assertion",true)
            assert(!instance_exists(boss) && !instance_exists(NTTEFullPitSquidDeath)
                && saw_intro && saw_death && saw_prevent && arm_hits>0 && forwarded_damage>=boss_hp && last_boss_hp<=0
                && shot_count>0 && bot_fire_samples>0 && ammo_spent==shot_count,
                "Natural clear lacks actual native weapon input/ammo/moving projectile hits/intro/lethal root/staged death/Prevent release")
            assert(scrNTTEFullUnlockGet("pack:trench") && !scrNTTEFullUnlockGet("skin:parrot:1"),
                "Source clear frame must grant Trench pack before the final-exit B skin")
            var _text=scrNTTEFullParrotBConnectedRead(game_directory+"ntte-full-progress.json")
            assert(!is_undefined(_text) && json_parse(_text).unlocks[$ "pack:trench"]
                && !scrNTTEFullValue(json_parse(_text).unlocks,"skin:parrot:1",false),
                "Natural clear-frame pack grant was not written to isolated JSON before B acquisition")
            hop_ends=room_ends;hop_starts=room_starts
            scrNTTEFullParrotBConnectedActualRate("natural clear pack grant before portal exit")
            scrNTTEFullParrotBConnectedAwait(3);return;
        }
        return;
    }
    if(phase==3) {
        if(room_ends>hop_ends) {
            assert(room_ends==hop_ends+1 && room_starts==hop_starts+1 && native_restart_requested
                && saw_spawn && saw_open && saw_collision && saw_disappear,
                "Natural Portal lacks real spawn/open/contact/disappear/Alarm1/engine RoomEnd+RoomStart")
            scrNTTEFullParrotBConnectedAwait(4);return;
        }
        assert(!scrNTTEFullUnlockGet("skin:parrot:1"),"B was granted without the actual engine final exit")
        if(instance_exists(portal)) {
            if(portal.sprite_index==sprPortalSpawn) saw_spawn=true
            if(portal.sprite_index==sprPortal) saw_open=true
            if(portal.sprite_index==sprPortalDisappear) saw_disappear=true
            // Controlled player position is the only portal input; native
            // collision/countdown/animation/Alarm1 own transition and target.
            if(portal.endgame==100) {player.x=portal.x;player.y=portal.y;player.xprevious=player.x;player.yprevious=player.y}
        }
        return;
    }
    if(phase==4) {
        if(instance_exists(GenCont) || instance_exists(FloorMaker)) return;
        assert(GameCont.area==area_city && GameCont.subarea==1 && instance_number(Floor)>20
            && !GameCont.ntte_full_active_trench && !instance_exists(boss) && !instance_exists(portal),
            "Real source Trench3 finish/transit did not generate City1 and dispose old world")
        assert(instance_exists(player) && player.race==target_race && player.bskin==0,
            "Solo selected living Parrot did not survive actual final exit")
        var _text=scrNTTEFullParrotBConnectedRead(game_directory+"ntte-full-progress.json")
        assert(!is_undefined(_text),"Natural final exit failed real progress JSON write")
        var _saved=json_parse(_text)
        assert(_saved.unlocks[$ "skin:parrot:1"] && _saved.unlocks[$ "pack:trench"],
            "Natural final-exit JSON omitted newly acquired B skin or earlier clear-frame pack")
        global.ntte_full_progress={schema:1,unlocks:{},loadouts:{},stats:{}}
        assert(scrNTTEFullProgressLoad() && scrNTTEFullUnlockGet("skin:parrot:1")
            && scr_race_is_skin_unlocked(target_race,1),"Actual JSON reload lost newly earned Parrot B ownership")
        scrNTTEFullParrotBConnectedActualRate("real engine City1 and newly earned B JSON reload")
        scrNTTESmokeLog("PARROT B SOURCE CHAIN controlled Trench3 prerequisite / native GenCont / real arm collisions="
            +string(arm_hits)+" forwarded="+string(forwarded_damage)+" / actual staged death / natural pack / real portal+RoomEnd+RoomStart / City1 / new B JSON")
        scrNTTEFullParrotBConnectedClear()
        if(file_exists(savegame_file)) file_delete(savegame_file)
        UberCont.want_quit_to_menu=true;instance_create(0,0,Vlambeer)
        scrNTTEFullParrotBConnectedAwait(5);return;
    }
    if(phase==5) {
        if(instance_exists(Logo)) with(Logo) event_perform(ev_alarm,1)
        var _button=noone
        with(MainMenuButton) if(image_index==0) _button=id
        if(!instance_exists(_button)) return;
        with(_button) event_user(0)
        var _play=noone
        with(PlayButton) if(floor(num)==0) _play=id
        if(instance_exists(_play)) with(_play) event_user(0)
        assert(instance_exists(Menu) && instance_exists(MenuGen),"Real MainMenu/Play did not build character menu")
        menu=instance_find(Menu,0);selector=noone
        with(CharSelect) if(race==other.target_race) other.selector=id
        assert(instance_exists(selector),"Selected owned Parrot missing from actual menu")
        scrNTTEFullParrotBConnectedActualRate("actual native menu constructed after acquisition")
        scrNTTEFullParrotBConnectedAwait(6);return;
    }
    if(phase==6) {
        if(draw_frames-draw_start<3 || instance_exists(FloorMaker)) return;
        assert(selector.can,"Native CharSelect Draw rejected owned Parrot")
        with(selector) event_perform(ev_mouse,ev_left_press)
        assert(my_player.race==target_race && my_player.skin==0 && selector.selected && GoButton.visible,
            "Actual Parrot selection skipped A prerequisite or failed native slot/Go state")
        assert(!menu.loadout_open && menu.loadout_frame==0,"Native loadout unexpectedly already open")
        scrNTTEFullParrotBConnectedAwait(7);scrNTTEFullParrotBConnectedPointer(false);return;
    }
    if(phase==7) {
        if(injected_phase!=7 || menu.loadout_frame<2) return;
        assert(menu.loadout_open && scr_race_is_skin_unlocked(target_race,1),
            "Native actual loadout arrow failed or newly earned B unavailable")
        scrNTTEFullParrotBConnectedAwait(8);scrNTTEFullParrotBConnectedPointer(true);return;
    }
    if(phase==8) {
        if(injected_phase!=8 || draw_frames-draw_start<2) return;
        assert(pointer_injections==2 && my_player.skin==1 && scr_loadout_race_get_skin(target_race)==1,
            "Actual newly earned Parrot B hitbox failed native loadout setter/selected slot")
        scrNTTEFullParrotBConnectedActualRate("actual newly earned B skin hitbox before Go")
        with(GoButton) event_perform(ev_mouse,ev_left_press)
        assert(instance_number(Player)==1 && Player.race==target_race && Player.bskin==1,
            "Native Go/scrRunStart omitted naturally unlocked and actually clicked Parrot B")
        initial_player=Player.id;run_ends=room_ends;run_starts=room_starts
        scrNTTEFullParrotBConnectedAwait(9);return;
    }
    if(phase==9) {
        if(instance_exists(Menu) || instance_exists(MenuGen) || instance_exists(GenCont) || instance_exists(FloorMaker)) return;
        assert(instance_number(Player)==1 && Player.id==initial_player && room_ends==run_ends+1
            && room_starts==run_starts+1 && instance_number(Floor)>20 && Player.ntte_native_race_started,
            "Actual new-run restart omitted new B Player/generated world/engine events")
        scrNTTEFullParrotBConnectedActualRate("actual Go room_restart B world");scrNTTEFullParrotBConnectedArt()
        saved_player=Player.id;scrSavegameSave();assert(file_exists(savegame_file),"Actual Parrot B binary continuation write missing")
        scrNTTEFullParrotBConnectedClear();UberCont.want_quit_to_menu=false;instance_create(0,0,Vlambeer)
        scrNTTEFullParrotBConnectedAwait(10);return;
    }
    if(phase==10) {
        if(instance_exists(GenCont) || instance_exists(FloorMaker)) return;
        assert(instance_number(Player)==1 && Player.id!=saved_player && Player.race==target_race
            && Player.bskin==1 && UberCont.continued_run && instance_number(Floor)>20
            && scrNTTEFullUnlockGet("skin:parrot:1"),"Actual native binary continuation lost B/new Player/world/ownership")
        scrNTTEFullParrotBConnectedActualRate("actual native binary continuation B world");scrNTTEFullParrotBConnectedArt()
        scrNTTEFullParrotBConnectedAwait(11);return;
    }
    if(phase==11) {
        if(draw_frames-draw_start<8) return;
        scrNTTEFullParrotBConnectedActualRate("continued B eight actual Draw frames")
        scrNTTESmokeLog("PASS PARROT B CONNECTED controlled Trench3/legal starting AutoCrossbow+Minigun/native sampled bot inputs/source ammo+reload/moving original-damage projectiles/native340HP boss intro/real arm damage/staged death+prevent/natural clear pack/natural portal/engine RoomEnd+RoomStart/City1/new B JSON reload/actual menu arrow+B hitboxes/Go+restart/new B Player/binary continuation/Draw8 @"+string(rates[pass_index])+"; earlier aquatic route and co-op branch not covered")
        if(++pass_index<array_length(rates)) {pointer_injections=0;scrNTTEFullParrotBConnectedAwait(0);return;}
        scrNTTEFullParrotBConnectedRestore()
        scrNTTESmokeLog("PASS full internal selected implemented branches x 30/60; not complete MOD coverage")
        game_end()
    }
}
function scrNTTEFullParrotBConnectedStep() {
    try {scrNTTEFullParrotBConnectedStepBody()}
    catch(_error) {scrNTTEFullParrotBConnectedRestore();throw _error}
}

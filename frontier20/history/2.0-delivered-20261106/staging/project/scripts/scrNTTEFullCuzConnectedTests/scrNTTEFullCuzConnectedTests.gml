// Dedicated controlled Crib acquisition -> native car -> hostile death -> Cuz.
// The final full binary Continue is an explicitly controlled boundary, not UI.
function scrNTTEFullCuzConnectedClear() {
    var _keep=id
    with(all) if(id!=_keep && object_index!=UberCont && object_index!=Console) instance_destroy(id,false)
}
function scrNTTEFullCuzConnectedRestore() {
    if(restored) return;
    restored=true;measuring=false
    if(path_exists(bot_path)) path_delete(bot_path)
    var _unchanged=ds_map_write(old_save_map)==old_savedata
    scrNTTEFullCuzConnectedClear()
    scrNTTEFullAreaGeneratorRestore(old_global_graph)
    for(var _i=0;_i<array_length(old_global_vars);++_i)
        variable_global_set(old_global_vars[_i][0],old_global_vars[_i][1])
    scrNTTEFullAreaGeneratorRestore(old_uber);UberCont.saveData=old_save_map
    if(ds_exists(fixture_save_map,ds_type_map)) ds_map_destroy(fixture_save_map)
    game_set_speed(old_game_speed,gamespeed_fps)
    game_directory=old_directory;global.ntte_smoke_active=old_smoke
    if(old_continue>=0) {buffer_save(old_continue,savegame_file);buffer_delete(old_continue)}
    else if(file_exists(savegame_file)) file_delete(savegame_file)
    for(var _i=0;_i<array_length(scratch_files);++_i)
        if(file_exists(scratch_files[_i])) file_delete(scratch_files[_i])
    random_set_seed(old_seed)
    assert(_unchanged && ds_map_write(old_save_map)==old_savedata,"Cuz cleanup changed original user save/options")
    instance_deactivate_object(UberCont)
}
function scrNTTEFullCuzConnectedAbort(_error) {
    var _o=instance_find(NTTEFullCuzConnectedTest,0)
    if(instance_exists(_o)) with(_o) {
        scrNTTEFullCuzConnectedDiagnostic("before strict failure: "+_error.message)
        scrNTTEFullCuzConnectedRestore()
    }
    throw _error
}
function scrNTTEFullCuzConnectedTests() {
    assert(os_type==os_windows && scrNTTEFullSmokeEnabled(),"Cuz connected requires dedicated Windows full smoke")
    assert(!instance_exists(NTTEFullCuzConnectedTest),"Cuz observer duplicated")
    scrNTTEFullCuzConnectedFingerprintContract()
    var _o=instance_create(0,0,NTTEFullCuzConnectedTest)
    with(_o) {
        restored=false;measuring=false;scratch_files=[];old_global_vars=[]
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
        scratch_root=working_directory+"cuz-connected-"+string(get_timer())+"/";directory_create(scratch_root)
        rates=[30,60];pass_index=0;phase=0;elapsed=0;draw_frames=0;physical_frames=0;world_ready_draw=-1
        room_ends=0;room_starts=0;gen_creates=0;gen_destroys=0;player_room_starts=[]
        owner=noone;player=noone;pet=noone;provider=noone;prompt=noone;car=noone;portal=noone;drop=noone
        source_couches=[];source_yungs=[];source_pets=[];source_bandits=[];native_bullets=[];hit_records=[];death_drops=[]
        takeover_before=undefined;takeover_setup=undefined;takeover_return_unlocks=[];destroy_record=undefined;pet_returns=0;owner_destroys=0
        load_calls=0;player_loads=[];input_calls=0;move_samples=0;pick_samples=0;spec_samples=0;fire_samples=0
        recovery_input_samples=0;direct_bullet_input_samples=0;avoid_input_samples=0;last_native_threats=[]
        actual_draws=0;shot_count=0;ammo_spent=0;note_seen=false;beat_seen=false;diag_clock=0
        expected_owner_hp=8;bot_was_pick=false;bot_was_fire=false;bot_was_spec=false
        bot_path=path_add();bot_path_clock=0;bot_path_cursor=1;bot_goal_x=0;bot_goal_y=0;last_path={}
        smoke_drivers=scrNTTEFullInstances(NTTESmokeTest)
        with(NTTESmokeTest) instance_deactivate_object(id)
        global.ntte_smoke_active=false
        scrNTTEFullCuzConnectedClear()
    }
}
function scrNTTEFullCuzConnectedAwait(_phase) {
    phase=_phase;elapsed=0;world_ready_draw=-1;diag_clock=0;bot_path_clock=0
    scrNTTESmokeLog("CUZ CONNECTED phase="+string(phase)+" rate="+string(rates[pass_index]))
}
function scrNTTEFullCuzConnectedWorldReady() {
    if(instance_exists(GenCont) || instance_exists(FloorMaker)) {world_ready_draw=-1;return false;}
    if(world_ready_draw<0) {world_ready_draw=draw_frames;return false;}
    return draw_frames-world_ready_draw>=8
}
function scrNTTEFullCuzConnectedRate() {
    assert(UberCont.saveData==fixture_save_map && ds_map_write(old_save_map)==old_savedata
        && game_get_speed(gamespeed_fps)==rates[pass_index] && timescale==30/rates[pass_index]
        && UberCont.opt_framerate==rates[pass_index] && !UberCont.opt_autopause
        && save_get_value("options","framerate",-1)==rates[pass_index],"Cuz connected actual rate/save isolation failed")
}
function scrNTTEFullCuzConnectedPlayerRecord(_p) {
    if(!instance_exists(_p)) return {exists:false};
    return {exists:true,id:_p,x:_p.x,y:_p.y,hp:_p.hp,max_hp:_p.max_hp,nexthurt:_p.nexthurt,
        index:_p.index,race:_p.race,wep:_p.wep,bwep:_p.bwep,ammo:_p.ammo,visible:_p.visible,
        can_walk:_p.can_walk,can_pick:_p.can_pick,last_hit:scrNTTEFullValue(_p,"ntte_last_hit",undefined),
        adopted:scrNTTEFullValue(_p,"ntte_cuz_adopted",false)}
}
// Snapshot only: zero entries means the native unlock-overlay branch was not
// exercised. The fixture neither creates an overlay nor cancels its alarm.
function scrNTTEFullCuzConnectedUnlockRecord() {
    var _records=[]
    with(UnlockScreen) array_push(_records,{id:id,visible:visible,alarm0:alarm[0],race:race,bskin:bskin})
    return _records
}
function scrNTTEFullCuzConnectedAreaRecord() {
    if(!instance_exists(GameCont)) return {exists:false};
    return {exists:true,area:GameCont.area,subarea:GameCont.subarea,lastarea:GameCont.lastarea,
        lastsubarea:GameCont.lastsubarea,gocrib:GameCont.gocrib,can_advance_stage:GameCont.can_advance_stage,
        loops:GameCont.loops,hard:GameCont.hard}
}
function scrNTTEFullCuzConnectedDiagnostic(_where) {
    var _enemies=[]
    with(enemy) array_push(_enemies,{id:id,type:object_get_name(object_index),x:x,y:y,hp:hp,team:team})
    scrNTTESmokeLog("CUZ CONNECTED DIAGNOSTIC "+_where+" "+json_stringify({rate:rates[pass_index],phase:phase,
        elapsed:elapsed,physical_frames:physical_frames,owner:scrNTTEFullCuzConnectedPlayerRecord(owner),
        player:scrNTTEFullCuzConnectedPlayerRecord(player),pet:pet,pet_exists:instance_exists(pet),
        provider:provider,prompt:prompt,car:car,portal:portal,drop:drop,couches:source_couches,yungs:source_yungs,
        pets:source_pets,bandits:source_bandits,bullets:native_bullets,hits:hit_records,drops:death_drops,
        takeover_before:takeover_before,takeover_setup:takeover_setup,takeover_return_unlocks:takeover_return_unlocks,destroy_record:destroy_record,
        owner_destroys:owner_destroys,pet_returns:pet_returns,slot:is_struct(scr_playerinstance_find(0))?scr_playerinstance_find(0).race:-1,
        gen_creates:gen_creates,gen_destroys:gen_destroys,room_ends:room_ends,room_starts:room_starts,
        inputs:input_calls,moves:move_samples,picks:pick_samples,spec:spec_samples,fire:fire_samples,
        recovery_inputs:recovery_input_samples,direct_bullet_inputs:direct_bullet_input_samples,
        avoidance_inputs:avoid_input_samples,last_native_threats:last_native_threats,
        native_deathcause:scrNTTEFullValue(GameCont,"deathcause",undefined),frame:current_frame,
        shots:shot_count,ammo_spent:ammo_spent,draws:actual_draws,note:note_seen,beat:beat_seen,last_path:last_path,
        block_input_frames:UberCont.block_input_frames,paused:UberCont.paused,gameover:instance_number(GameOver),
        unlocks:scrNTTEFullCuzConnectedUnlockRecord(),context:scrNTTEFullCuzConnectedAreaRecord(),enemies:_enemies,rng:random_get_seed()}))
}
// Read-only engine probes. No observer calls a producer, death or takeover.
function scrNTTEFullCuzConnectedProbe(_where,_who=noone) {
    var _o=instance_find(NTTEFullCuzConnectedTest,0)
    if(!instance_exists(_o) || _o.restored || !_o.measuring) return;
    if(_where=="Gen.Create") {_o.gen_creates++;return}
    if(_where=="Gen.Destroy") {_o.gen_destroys++;return}
    if(_where=="Couch.Create" && instance_exists(GenCont)) array_push(_o.source_couches,_who)
    if(_where=="Yung.Create" && instance_exists(GenCont)) array_push(_o.source_yungs,_who)
    if(_where=="Enemy.Create" && instance_exists(GenCont) && instance_exists(_who) && _who.object_index==Bandit)
        array_push(_o.source_bandits,_who)
    if(_where=="Player.RoomStart") array_push(_o.player_room_starts,_who)
    if(_where=="Player.Load") {
        array_push(_o.player_loads,_who)
        if(_o.phase==7) scrNTTESmokeLog("CUZ CONNECTED FINGERPRINT native-player-load "+scrNTTEFullCuzConnectedFingerprint(_who))
    }
    if(_where=="Load.begin") _o.load_calls++
    if(_where=="Player.Draw" && _who==_o.player && instance_exists(_who)
        && scrNTTEFullValue(_who,"ntte_cuz_adopted",false)) _o.actual_draws++
    if(_where=="Pet.Step.return" && _who==_o.pet && is_struct(_o.takeover_before) && !instance_exists(_who)) {
        _o.pet_returns++
        _o.takeover_return_unlocks=scrNTTEFullCuzConnectedUnlockRecord()
        assert(instance_number(Player)==1,"Actual Cuz Pet.Step returned without exactly one replacement")
        _o.player=instance_find(Player,0)
        assert(!instance_exists(_o.owner) && _o.player!=_o.owner && !instance_exists(_o.prompt),
            "Actual Cuz callback retained owner/pet/prompt or reused old owner ID")
    }
    if(_where=="Deferred.after") with(NTTEFullPet) if(pet=="Cuz" && array_get_index(_o.source_pets,id)<0)
        array_push(_o.source_pets,id)
}
function scrNTTEFullCuzConnectedBanditBefore(_who) {
    var _o=instance_find(NTTEFullCuzConnectedTest,0)
    if(!_o.measuring || _o.phase!=4 || array_get_index(_o.source_bandits,_who)<0) return undefined;
    return {creator:_who,x:_who.x,y:_who.y,before:scrNTTEFullInstances(EnemyBullet1),frame:current_frame}
}
function scrNTTEFullCuzConnectedBanditAfter(_sample) {
    if(!is_struct(_sample)) return;
    var _o=instance_find(NTTEFullCuzConnectedTest,0),_shots=scrNTTEFullInstances(EnemyBullet1)
    for(var _i=0;_i<array_length(_shots);++_i) {
        var _shot=_shots[_i]
        if(array_get_index(_sample.before,_shot)>=0 || _shot.creator!=_sample.creator) continue
        assert(_shot.damage==3 && _shot.speed>0 && _shot.team==team_enemy
            && point_distance(_shot.x,_shot.y,_sample.x,_sample.y)<2,"Native Bandit shot lost original constructor/motion")
        array_push(_o.native_bullets,{id:_shot,creator:_sample.creator,x:_shot.x,y:_shot.y,damage:_shot.damage,frame:current_frame})
    }
}
function scrNTTEFullCuzConnectedHitBefore(_bullet,_victim) {
    var _o=instance_find(NTTEFullCuzConnectedTest,0)
    if(!_o.measuring || _o.phase!=4 || _victim!=_o.owner || !instance_exists(_victim)) return undefined;
    var _source=undefined
    for(var _i=0;_i<array_length(_o.native_bullets);++_i)
        if(_o.native_bullets[_i].id==_bullet) {_source=_o.native_bullets[_i];break}
    assert(is_struct(_source) && _bullet.damage==3 && _bullet.creator==_source.creator
        && point_distance(_bullet.x,_bullet.y,_source.x,_source.y)>1,"Owner collision lacks real moving generated-Bandit shot")
    return {bullet:_bullet,victim:_victim,before:_victim.hp,next:_victim.nexthurt,frame:current_frame,source:_source}
}
function scrNTTEFullCuzConnectedHitAfter(_sample) {
    if(!is_struct(_sample) || !instance_exists(_sample.victim)) return;
    var _o=instance_find(NTTEFullCuzConnectedTest,0),_after=_sample.victim.hp,_loss=_sample.before-_after
    if(_loss<=0) return;
    assert(_loss==3 && _sample.frame>=_sample.next && _sample.victim.nexthurt==_sample.frame+6,
        "Owner HP loss differs from original Bandit damage/invulnerability interval")
    for(var _i=0;_i<array_length(_o.hit_records);++_i)
        assert(_o.hit_records[_i].bullet!=_sample.bullet,"One native bullet dealt duplicate measured damage")
    array_push(_o.hit_records,{bullet:_sample.bullet,creator:_sample.source.creator,before:_sample.before,after:_after,
        frame:_sample.frame,next:_sample.victim.nexthurt})
    _o.expected_owner_hp=_after
    scrNTTESmokeLog("CUZ CONNECTED REAL HIT "+json_stringify(_o.hit_records[array_length(_o.hit_records)-1]))
}
function scrNTTEFullCuzConnectedDeathBefore(_who) {
    var _o=instance_find(NTTEFullCuzConnectedTest,0)
    if(!_o.measuring || _who!=_o.owner) return undefined;
    assert(_who.hp<=0 && _o.expected_owner_hp<=0 && array_length(_o.hit_records)>=3
        && !instance_exists(GenCont) && player_count==1,"Owner Destroy did not follow genuine lethal ordinary hits")
    _o.owner_destroys++
    _o.destroy_record={id:_who,index:_who.index,race:_who.race,hp:_who.hp,wep:_who.wep,bwep:_who.bwep,
        pet:_o.pet,frame:current_frame,x:_who.x,y:_who.y,unlocks_before:scrNTTEFullCuzConnectedUnlockRecord()}
    return {before:scrNTTEFullInstances(WepPickup)}
}
function scrNTTEFullCuzConnectedDeathAfter(_sample) {
    if(!is_struct(_sample)) return;
    var _o=instance_find(NTTEFullCuzConnectedTest,0),_pickups=scrNTTEFullInstances(WepPickup)
    _o.destroy_record.unlocks_after=scrNTTEFullCuzConnectedUnlockRecord()
    for(var _i=0;_i<array_length(_pickups);++_i) {
        var _pickup=_pickups[_i]
        if(array_get_index(_sample.before,_pickup)>=0) continue
        array_push(_o.death_drops,{id:_pickup,wep:_pickup.wep,ammo:_pickup.ammo})
        if(_pickup.wep==_o.destroy_record.wep) _o.drop=_pickup
    }
}
function scrNTTEFullCuzConnectedTakeoverBefore(_pet) {
    var _o=instance_find(NTTEFullCuzConnectedTest,0)
    if(!_o.measuring || _pet!=_o.pet) return;
    assert(!instance_exists(Player) && _o.owner_destroys==1 && !GameCont.win
        && _pet.leader_index==0 && is_struct(scr_playerinstance_find(0)),"Cuz takeover lacks genuine last-owner death/retained slot")
    assert(!is_struct(_o.takeover_before),"Cuz attempted duplicate takeover")
    _o.takeover_before={id:_pet,x:_pet.x,y:_pet.y,index:_pet.leader_index,frame:current_frame,
        slot_race:scr_playerinstance_find(0).race,prompt:_pet.prompt,spr_idle:_pet.spr_idle,spr_walk:_pet.spr_walk,
        mask:_pet.mask_index,angle:_pet.portal_angle,unlocks:scrNTTEFullCuzConnectedUnlockRecord()}
}
function scrNTTEFullCuzConnectedTakeoverSetup(_new) {
    var _o=instance_find(NTTEFullCuzConnectedTest,0)
    if(!_o.measuring || !is_struct(_o.takeover_before)) return;
    _o.takeover_setup={id:_new,x:_new.x,y:_new.y,hp:_new.hp,max_hp:_new.max_hp,index:_new.index,
        race:_new.race,adopted:scrNTTEFullValue(_new,"ntte_cuz_adopted",false),next:_new.nexthurt,
        spirit:_new.spirit_index,spr_idle:_new.spr_idle,spr_walk:_new.spr_walk,mask:_new.mask_index,angle:_new.angle,
        slot_race:scr_playerinstance_find(0).race,frame:current_frame,unlocks:scrNTTEFullCuzConnectedUnlockRecord()}
}
function scrNTTEFullCuzConnectedFireBefore(_who) {
    var _o=instance_find(NTTEFullCuzConnectedTest,0)
    if(!_o.measuring || _o.phase!=6 || _who!=_o.player) return undefined;
    return {before:scrNTTEFullInstances(Bullet1),ammo:_who.ammo[Ammo.Bullets]}
}
function scrNTTEFullCuzConnectedFireAfter(_sample,_who) {
    if(!is_struct(_sample) || !instance_exists(_who)) return;
    var _o=instance_find(NTTEFullCuzConnectedTest,0),_shots=scrNTTEFullInstances(Bullet1),_new=0
    for(var _i=0;_i<array_length(_shots);++_i) if(array_get_index(_sample.before,_shots[_i])<0 && _shots[_i].creator==_who) {
        assert(_shots[_i].damage==3 && _shots[_i].speed>0,"Adopted Cuz normal revolver firing changed projectile");_new++
    }
    if(_new>0) {
        assert(_new==1 && _who.ammo[Ammo.Bullets]==_sample.ammo-1,"Adopted Cuz shot lacks native ammo cost")
        _o.shot_count++;_o.ammo_spent++
    }
}
// Read native Player collision queries along a segment without moving any
// actor. Navigation uses only the usual sampled direction inputs below.
function scrNTTEFullCuzConnectedNativeClear(_x,_y) {
    var _distance=point_distance(player.x,player.y,_x,_y),_steps=max(1,ceil(_distance/2))
    for(var _i=0;_i<=_steps;++_i) {
        var _px=lerp(player.x,_x,_i/_steps),_py=lerp(player.y,_y,_i/_steps),_free=false
        with(player) _free=!place_meeting(_px,_py,Wall)
        if(!_free) return false;
    }
    return true
}
function scrNTTEFullCuzConnectedPathDirection(_x,_y,_kind) {
    bot_path_clock-=timescale
    if(bot_path_clock<=0 || point_distance(_x,_y,bot_goal_x,bot_goal_y)>12) {
        bot_goal_x=_x;bot_goal_y=_y;bot_path_clock=15;bot_path_cursor=1
        var _left=infinity,_top=infinity,_right=-infinity,_bottom=-infinity
        with(Floor) {_left=min(_left,bbox_left);_top=min(_top,bbox_top);_right=max(_right,bbox_right);_bottom=max(_bottom,bbox_bottom)}
        var _origin_x=floor((_left-64)/8)*8,_origin_y=floor((_top-64)/8)*8,
            _columns=ceil((_right-_left+128)/8),_rows=ceil((_bottom-_top+128)/8),
            _grid=mp_grid_create(_origin_x,_origin_y,_columns,_rows,8,8)
        with(Wall) mp_grid_add_rectangle(_grid,bbox_left-5,bbox_top-3,bbox_right+5,bbox_bottom+3)
        var _sx=floor((player.x-_origin_x)/8),_sy=floor((player.y-_origin_y)/8),
            _gx=floor((_x-_origin_x)/8),_gy=floor((_y-_origin_y)/8),
            _start_in=_sx>=0 && _sy>=0 && _sx<_columns && _sy<_rows,
            _goal_in=_gx>=0 && _gy>=0 && _gx<_columns && _gy<_rows,
            _start_blocked=true,_goal_blocked=true,_query_x=player.x,_query_y=player.y,
            _native_start=scrNTTEFullCuzConnectedNativeClear(player.x,player.y),
            _native_goal=scrNTTEFullCuzConnectedNativeClear(_x,_y),_native_goal_free=false,_recovery=false
        with(player) _native_goal_free=!place_meeting(_x,_y,Wall)
        if(_start_in) _start_blocked=mp_grid_get_cell(_grid,_sx,_sy)<0
        if(_goal_in) _goal_blocked=mp_grid_get_cell(_grid,_gx,_gy)<0
        // A legal physical Player can occupy a conservatively blocked 8px
        // cell. Query from a nearby unblocked center only when the complete
        // real-mask segment to that center is free. The Player still has to
        // walk there through native input; its position/grid are never edited.
        if(_start_in && _start_blocked && _native_start && _goal_in && !_goal_blocked) {
            var _best=infinity
            for(var _dx=-3;_dx<=3;++_dx) for(var _dy=-3;_dy<=3;++_dy) {
                var _cx=_sx+_dx,_cy=_sy+_dy
                if(_cx<0 || _cy<0 || _cx>=_columns || _cy>=_rows || mp_grid_get_cell(_grid,_cx,_cy)<0) continue;
                var _px=_origin_x+(_cx+0.5)*8,_py=_origin_y+(_cy+0.5)*8,
                    _distance=point_distance(player.x,player.y,_px,_py)
                if(_distance<_best && scrNTTEFullCuzConnectedNativeClear(_px,_py)) {
                    path_clear_points(bot_path)
                    if(mp_grid_path(_grid,bot_path,_px,_py,_x,_y,false)) {
                        _best=_distance;_query_x=_px;_query_y=_py;_recovery=true
                    }
                }
            }
        }
        path_clear_points(bot_path)
        var _ok=mp_grid_path(_grid,bot_path,_query_x,_query_y,_x,_y,false)
        bot_path_cursor=_recovery?0:1
        last_path={start:[player.x,player.y],goal:[_x,_y],kind:_kind,success:_ok,points:path_get_number(bot_path),
            origin:[_origin_x,_origin_y],columns:_columns,rows:_rows,start_cell:[_sx,_sy],goal_cell:[_gx,_gy],
            start_in_bounds:_start_in,goal_in_bounds:_goal_in,start_blocked:_start_blocked,goal_blocked:_goal_blocked,
            native_start_free:_native_start,native_goal_free:_native_goal_free,native_segment_to_goal_free:_native_goal,
            query_start:[_query_x,_query_y],recovery_start:_recovery,input_route:"grid"}
        mp_grid_destroy(_grid)
    }
    if(path_get_number(bot_path)<2) return undefined;
    while(bot_path_cursor<path_get_number(bot_path)-1
        && point_distance(player.x,player.y,path_get_point_x(bot_path,bot_path_cursor),path_get_point_y(bot_path,bot_path_cursor))<6) bot_path_cursor++
    return point_direction(player.x,player.y,path_get_point_x(bot_path,bot_path_cursor),path_get_point_y(bot_path,bot_path_cursor))
}
// Read-only snapshots retain caller/creator evidence even if a projectile is
// consumed by the following real collision. Ordinary Bandit bullets remain
// deliberately eligible for the fixture's unchanged strict damage path.
function scrNTTEFullCuzConnectedThreats() {
    var _threats=[],_px=player.x,_py=player.y
    with(enemy) if(team==team_enemy && hp>0 && meleedamage>0 && point_distance(x,y,_px,_py)<=112)
        array_push(_threats,{id:id,type:object_get_name(object_index),kind:"contact",x:x,y:y,
            vx:hspeed/timescale,vy:vspeed/timescale,amount:meleedamage,hitid:hitid,radius:32})
    with(projectile) if(team==team_enemy && damage>0 && object_index!=EnemyBullet1 && point_distance(x,y,_px,_py)<=112)
        array_push(_threats,{id:id,type:object_get_name(object_index),kind:"projectile",x:x,y:y,
            vx:hspeed/timescale,vy:vspeed/timescale,amount:damage,hitid:hitid,creator:creator,radius:24})
    return _threats
}
function scrNTTEFullCuzConnectedThreatMargin(_x,_y) {
    var _margin=infinity
    for(var _i=0;_i<array_length(last_native_threats);++_i) {
        var _t=last_native_threats[_i],_vx=_t.vx,_vy=_t.vy,_den=_vx*_vx+_vy*_vy,
            _ticks=_den>0?clamp(((_x-_t.x)*_vx+(_y-_t.y)*_vy)/_den,0,6):0,
            _d=point_distance(_x,_y,_t.x+_vx*_ticks,_t.y+_vy*_ticks)-_t.radius
        _margin=min(_margin,_d)
    }
    return _margin
}
function scrNTTEFullCuzConnectedInput(_keys,_index) {
    var _o=instance_find(NTTEFullCuzConnectedTest,0)
    if(!instance_exists(_o) || _o.restored || !_o.measuring || !instance_exists(_o.player) || _o.player.index!=_index) return;
    var _move=false,_dir=0,_pick=false,_fire=false,_spec=false,_aim=0
    with(_o) {
        input_calls++
        if(!instance_exists(GenCont) && !instance_exists(FloorMaker)) {
            var _goal=noone,_goal_kind="actor"
            if(phase==2) _goal=pet
            if(phase==3) _goal=instance_exists(portal)?portal:car
            if(phase==4) {
                last_native_threats=scrNTTEFullCuzConnectedThreats()
                var _distance=infinity
                for(var _i=0;_i<array_length(native_bullets);++_i) {
                    var _b=native_bullets[_i].id
                    if(instance_exists(_b) && point_distance(player.x,player.y,_b.x,_b.y)<=96
                        && point_distance(player.x,player.y,_b.x,_b.y)<_distance
                        && !collision_line(player.x,player.y,_b.x,_b.y,Wall,false,false)
                        && scrNTTEFullCuzConnectedNativeClear(_b.x,_b.y)) {
                        _distance=point_distance(player.x,player.y,_b.x,_b.y);_goal=_b;_goal_kind="bullet"
                    }
                }
                if(!instance_exists(_goal)) {
                    var _distance=infinity
                    for(var _i=0;_i<array_length(source_bandits);++_i) {
                        var _b=source_bandits[_i]
                        if(!instance_exists(_b) || _b.hp<=0) continue
                        var _d=point_distance(player.x,player.y,_b.x,_b.y)
                        if(_d<_distance) {_distance=_d;_goal=_b;_goal_kind="bandit"}
                    }
                    if(instance_exists(_goal) && point_distance(player.x,player.y,_goal.x,_goal.y)<88
                        && !collision_line(player.x,player.y,_goal.x,_goal.y,Wall,false,false)) _goal=noone
                }
            }
            if(phase==5) _goal=drop
            if(instance_exists(_goal) && point_distance(player.x,player.y,_goal.x,_goal.y)>4) {
                var _next=scrNTTEFullCuzConnectedPathDirection(_goal.x,_goal.y,_goal_kind)
                if(!is_undefined(_next)) {
                    _move=true;_dir=_next
                    if(last_path.recovery_start && bot_path_cursor==0) recovery_input_samples++
                }
                else if(phase==4 && _goal_kind=="bullet" && point_distance(player.x,player.y,_goal.x,_goal.y)<=96
                    && !collision_line(player.x,player.y,_goal.x,_goal.y,Wall,false,false)) {
                    // A bullet's point-LOS endpoint need not admit a Player's
                    // expanded grid cell. Use ordinary directional input only
                    // if its next short native-mask segment is physically free.
                    var _toward=point_direction(player.x,player.y,_goal.x,_goal.y),
                        _step=min(8,point_distance(player.x,player.y,_goal.x,_goal.y))
                    if(scrNTTEFullCuzConnectedNativeClear(player.x+lengthdir_x(_step,_toward),player.y+lengthdir_y(_step,_toward))) {
                        _move=true;_dir=_toward;direct_bullet_input_samples++;last_path.input_route="native-visible-bullet"
                    }
                }
            }
            if(phase==4 && scrNTTEFullCuzConnectedThreatMargin(player.x,player.y)<0) {
                // Evade only naturally generated non-Bandit damage through
                // the same ordinary direction input. No actors are edited.
                var _best=scrNTTEFullCuzConnectedThreatMargin(player.x,player.y),_evade=undefined
                for(var _a=0;_a<360;_a+=45) {
                    var _ex=player.x+lengthdir_x(8,_a),_ey=player.y+lengthdir_y(8,_a)
                    if(!scrNTTEFullCuzConnectedNativeClear(_ex,_ey)) continue;
                    var _score=scrNTTEFullCuzConnectedThreatMargin(_ex,_ey)
                    if(_score>_best) {_best=_score;_evade=_a}
                }
                if(!is_undefined(_evade)) {_move=true;_dir=_evade;avoid_input_samples++}
            }
            if(phase==2 && instance_exists(prompt) && scrNTTEFullPromptWinner(player)==prompt) _pick=true
            if(phase==3 && !instance_exists(portal) && instance_exists(car)) with(player) _pick=place_meeting(x,y,other.car)
            if(phase==5 && instance_exists(drop)) with(player) _pick=place_meeting(x,y,other.drop)
            if(phase==6 || phase==8) {
                _spec=true
                if(phase==6) {
                    _fire=shot_count==0 && player.ammo[Ammo.Bullets]>0;_aim=0
                    if(elapsed<8) {_move=true;_dir=play_direction}
                }
            }
        }
        if(_move) move_samples++
        if(_pick && !bot_was_pick) pick_samples++
        if(_spec) spec_samples++
        if(_fire) fire_samples++
    }
    _keys.dir_move[_index]=_dir;_keys.moving[_index]=_move?1:0;_keys.precisemovement[_index]=true;_keys.aimassist[_index]=false
    _keys.dir_fire[_index]=_aim;_keys.hold_fire[_index]=_fire;_keys.press_fire[_index]=_fire&&!_o.bot_was_fire
    _keys.release_fire[_index]=!_fire&&_o.bot_was_fire
    _keys.hold_pick[_index]=_pick;_keys.press_pick[_index]=_pick&&!_o.bot_was_pick;_keys.release_pick[_index]=!_pick&&_o.bot_was_pick
    _keys.hold_spec[_index]=_spec;_keys.press_spec[_index]=_spec&&!_o.bot_was_spec;_keys.release_spec[_index]=!_spec&&_o.bot_was_spec
    _keys.hold_swap[_index]=false;_keys.press_swap[_index]=false
    _keys.hold_east[_index]=false;_keys.hold_west[_index]=false;_keys.hold_nort[_index]=false;_keys.hold_sout[_index]=false
    _keys.press_paus[_index]=false
    _o.bot_was_pick=_pick;_o.bot_was_fire=_fire;_o.bot_was_spec=_spec
}
function scrNTTEFullCuzConnectedFingerprint(_p) {
    return json_stringify({race:_p.race,index:_p.index,adopted:scrNTTEFullValue(_p,"ntte_cuz_adopted",false),
        hp:_p.hp,max_hp:_p.max_hp,wep:_p.wep,bwep:_p.bwep,ammo:_p.ammo,curse:_p.curse,bcurse:_p.bcurse,
        skin:_p.bskin,extra:_p.extra_weps,slot_race:scr_playerinstance_find(_p.index).race})
}
// JSON player persistence converts integer enum storage to real storage.
// Compare all JSON fields recursively, preserving bool/string/container types.
// The existing native-tested F64 helper avoids GameMaker's numeric epsilon.
function scrNTTEFullCuzConnectedValueEqual(_a,_b) {
    if(is_array(_a) || is_array(_b)) {
        if(!is_array(_a) || !is_array(_b) || array_length(_a)!=array_length(_b)) return false;
        for(var _i=0;_i<array_length(_a);++_i)
            if(!scrNTTEFullCuzConnectedValueEqual(_a[_i],_b[_i])) return false;
        return true
    }
    if(is_struct(_a) || is_struct(_b)) {
        if(!is_struct(_a) || !is_struct(_b)) return false;
        var _keys=variable_struct_get_names(_a),_other_keys=variable_struct_get_names(_b)
        if(array_length(_keys)!=array_length(_other_keys)) return false;
        for(var _i=0;_i<array_length(_keys);++_i) {
            var _key=_keys[_i]
            if(!variable_struct_exists(_b,_key) || !scrNTTEFullCuzConnectedValueEqual(_a[$ _key],_b[$ _key])) return false;
        }
        return true
    }
    if(is_bool(_a) || is_bool(_b)) return is_bool(_a) && is_bool(_b) && _a==_b;
    if(is_numeric(_a) || is_numeric(_b))
        return is_numeric(_a) && is_numeric(_b) && scrNTTEFullPetCallbackLifetimeF64Equal(_a,_b);
    return typeof(_a)==typeof(_b) && _a==_b
}
function scrNTTEFullCuzConnectedFingerprintEqual(_a,_b) {
    return scrNTTEFullCuzConnectedValueEqual(json_parse(_a),json_parse(_b))
}
function scrNTTEFullCuzConnectedFingerprintContract() {
    var _base={race:Race.Cuz,index:0,adopted:true,hp:8,max_hp:8,wep:wep_revolver,bwep:0,
        ammo:[999,63,0,0,0,0],curse:false,bcurse:false,skin:0,extra:[],slot_race:Race.Cuz},
        _text=json_stringify(_base),_keys=variable_struct_get_names(_base)
    assert(scrNTTEFullCuzConnectedFingerprintEqual(_text,json_stringify(json_parse(_text))),
        "Cuz fingerprint rejected exact integer/real JSON roundtrip")
    assert(scrNTTEFullCuzConnectedValueEqual(16,16.0) && !scrNTTEFullCuzConnectedValueEqual(true,1)
        && !scrNTTEFullCuzConnectedValueEqual(false,0),"Cuz fingerprint mixed boolean and numeric types")
    assert(!scrNTTEFullCuzConnectedValueEqual(8,8.000000001),"Cuz fingerprint admitted numeric tolerance")
    for(var _i=0;_i<array_length(_keys);++_i) {
        var _key=_keys[_i],_value=_base[$ _key],_changed=json_parse(_text)
        _changed[$ _key]=is_array(_value)?[123456]:(is_bool(_value)?!_value:_value+1)
        assert(!scrNTTEFullCuzConnectedFingerprintEqual(_text,json_stringify(_changed)),"Cuz fingerprint accepted changed field "+_key)
        _changed=json_parse(_text);variable_struct_remove(_changed,_key)
        assert(!scrNTTEFullCuzConnectedFingerprintEqual(_text,json_stringify(_changed)),"Cuz fingerprint accepted missing field "+_key)
        _changed=json_parse(_text);_changed[$ "extra_"+_key]=0
        assert(!scrNTTEFullCuzConnectedFingerprintEqual(_text,json_stringify(_changed)),"Cuz fingerprint accepted extra field "+_key)
        _changed=json_parse(_text)
        _changed[$ _key]=is_array(_value)?{order:0}:(is_bool(_value)?(_value?1:0):string(_value))
        assert(!scrNTTEFullCuzConnectedFingerprintEqual(_text,json_stringify(_changed)),"Cuz fingerprint accepted changed type "+_key)
    }
    var _reordered=json_parse(_text);_reordered.ammo=[63,999,0,0,0,0]
    assert(!scrNTTEFullCuzConnectedFingerprintEqual(_text,json_stringify(_reordered)),"Cuz fingerprint accepted changed array order")
    assert(scrNTTEFullCuzConnectedValueEqual({a:[1,{b:false}],c:"x"},{c:"x",a:[1.0,{b:false}]})
        && !scrNTTEFullCuzConnectedValueEqual({a:[1,{b:false}],c:"x"},{c:"x",a:[1.0,{b:0}]})
        && !scrNTTEFullCuzConnectedValueEqual({a:[1,{b:false}],c:"x"},{c:"x",a:[1.0,{z:false}]}),
        "Cuz fingerprint lost recursive key/value/type contract")
    scrNTTESmokeLog("CUZ CONNECTED FINGERPRINT CONTRACT PASS all13 fields/value/missing/extra/type; array order; recursive bool/number; no epsilon")
}
function scrNTTEFullCuzConnectedBeginBody() {
    physical_frames++
    if(phase!=0) return;
    measuring=false
    for(var _i=0;_i<array_length(smoke_drivers);++_i) {
        instance_activate_object(smoke_drivers[_i])
        if(instance_exists(smoke_drivers[_i])) instance_destroy(smoke_drivers[_i],false)
    }
    smoke_drivers=[];scrNTTEFullCuzConnectedClear()
    save_set_value("options","autopause",false);save_set_value("options","framerate",rates[pass_index])
    save_set_value("options","keyboard",true);save_set_value("options","gamepad",false)
    UberCont.opt_framerate=rates[pass_index];game_set_speed(rates[pass_index],gamespeed_fps)
    UberCont.opt_autopause=false;UberCont.opt_keyboard=true;UberCont.opt_gamepad=false;UberCont.opt_practice=false
    UberCont.paused=false;UberCont.want_pause=false;UberCont.opt_freeze=0;UberCont.block_input_frames=0;UberCont.block_input_fire=false
    UberCont.opt_bossintro=false;UberCont.daily_run=false;UberCont.weekly_run=false;UberCont.coop=false;UberCont.hardmode=false
    UberCont.want_quit_to_menu=false;UberCont.want_menu=false;UberCont.want_restart=false;UberCont.show_leaderboards_menu=false
    global.is_server=true;global.index=0;global.__debug_infammo=false;global.__debug_immortality=false;global.crownpick=crwn_none
    scrGameCustomModeReset();scr_playerinstances_reset_all();my_player.race=Race.Fish;my_player.skin=0
    global.ntte_full_progress={schema:1,unlocks:{},loadouts:{},stats:{}};global.ntte_full_feature_ready={}
    global.custom_seed=701932;global.recontinued_times=0;UberCont.continued_run=false
    game_directory=scratch_root+string(rates[pass_index])+"/";directory_create(game_directory)
    var _files=["ntte-full-progress.json","ntte-full-progress.json.bak","ntte-full-progress.json.tmp","NuclearThrone.sav"]
    for(var _i=0;_i<array_length(_files);++_i) array_push(scratch_files,game_directory+_files[_i])
    if(file_exists(savegame_file)) file_delete(savegame_file)
    room_ends=0;room_starts=0;gen_creates=0;gen_destroys=0;player_room_starts=[]
    source_couches=[];source_yungs=[];source_pets=[];source_bandits=[];native_bullets=[];hit_records=[];death_drops=[]
    takeover_before=undefined;takeover_setup=undefined;takeover_return_unlocks=[];destroy_record=undefined;pet_returns=0;owner_destroys=0
    load_calls=0;player_loads=[];input_calls=0;move_samples=0;pick_samples=0;spec_samples=0;fire_samples=0
    recovery_input_samples=0;direct_bullet_input_samples=0;avoid_input_samples=0;last_native_threats=[]
    actual_draws=0;shot_count=0;ammo_spent=0;note_seen=false;beat_seen=false;expected_owner_hp=8
    bot_was_pick=false;bot_was_fire=false;bot_was_spec=false;path_clear_points(bot_path)
    owner=noone;player=noone;pet=noone;provider=noone;prompt=noone;car=noone;portal=noone;drop=noone
    save_set_value("game","tutorial",false)
    instance_create(0,0,GameCont);instance_create(0,0,MusCont);scrCreatePlayers(0)
    owner=instance_find(Player,0);player=owner
    assert(player.hp==8 && player.max_hp==8 && player.wep==wep_revolver && player.infammo==0
        && scr_skill_get(mut_strong_spirit)==0 && player_count==1,"Controlled Cuz Fish native baseline failed")
    GameCont.area=area_crib;GameCont.subarea=1;GameCont.loops=0;GameCont.hard=0
    GameCont.lastarea=area_desert;GameCont.lastsubarea=1;GameCont.crown=crwn_none;GameCont.win=false
    GameCont.maxsubarea=scrAreaGetMaxSubarea(area_crib);GameCont.finalsubarea=false
    // Declared initial controlled Crib reload: native GameCont.RoomEnd restores
    // this one-shot flag then exits without treating Crib as a completed exit.
    // The later real car and separate binary Continue use their native flows.
    GameCont.can_advance_stage=false
    GameCont.ntte_full_pending_destination=undefined;GameCont.ntte_full_source_seed=scrNTTEFullSourceSeedBuild(701932)
    GameCont.ntte_full_source_pending_generation=undefined;global.ntte_full_sync_generation=false
    scrRngStatesReset();scrNTTEFullFloorResetStyle();scrNTTEFullFloorResetAlign()
    measuring=true;scrNTTEFullCuzConnectedAwait(1)
    // Declared controlled ingress: the engine itself creates Vlambeer/GenCont.
    room_restart()
}
function scrNTTEFullCuzConnectedEndBody() {
    if(restored || phase==0) return;
    elapsed+=timescale;diag_clock-=timescale
    scrNTTEFullCuzConnectedRate()
    if(diag_clock<=0) {diag_clock=150;scrNTTEFullCuzConnectedDiagnostic("periodic")}
    assert(elapsed<5400,"Cuz strict phase timeout; no fallback actors/damage/rescue")
    assert(!instance_exists(LevCont),"Cuz natural chain encountered real level-choice boundary")
    if(instance_exists(owner)) assert(owner.hp==expected_owner_hp || owner.hp==max(0,expected_owner_hp),
        "Owner HP changed without recorded original Bandit bullet")
    if(phase==1) {
        if(!scrNTTEFullCuzConnectedWorldReady()) return;
        assert(GameCont.area==area_crib && room_ends==1 && room_starts==1 && gen_creates==1 && gen_destroys==1
            && array_get_index(player_room_starts,owner)>=0 && array_length(source_couches)==1
            && array_length(source_yungs)==1 && array_length(source_pets)==1,"Controlled native Crib provider/engine lifecycle failed")
        provider=source_yungs[0];pet=source_pets[0]
        assert(instance_exists(provider) && instance_exists(pet) && provider.ntte_cuz==pet && pet.cuz==provider
            && pet.pet=="Cuz" && !instance_exists(pet.leader) && pet.leader_index==-1,"Deferred Cuz lacks single native bidirectional binding")
        prompt=pet.prompt;assert(instance_exists(prompt),"Native Cuz prompt missing")
        scrNTTEFullCuzConnectedAwait(2);return;
    }
    if(phase==2) {
        if(!instance_exists(pet) || pet.leader!=owner || pet.leader_index!=owner.index) return;
        assert(pick_samples>0 && !instance_exists(provider) && pet.persistent && !pet.can_take
            && array_get_index(owner.ntte_pet,pet)>=0 && pet.stat.found==1 && pet.stat.owned>0,
            "Sampled native prompt did not acquire Cuz, record owner slot or remove seated counterpart")
        car=instance_nearest(player.x,player.y,CarVenusFixed)
        assert(instance_exists(car),"Native Crib did not generate a real return car")
        car_ends=room_ends;car_starts=room_starts
        scrNTTEFullCuzConnectedAwait(3);return;
    }
    if(phase==3) {
        if(instance_exists(car) && instance_number(Portal)==0) return;
        if(!instance_exists(portal)) with(Portal) if(type==1) other.portal=id
        if(room_ends==car_ends) return;
        if(!scrNTTEFullCuzConnectedWorldReady()) return;
        assert(room_ends==car_ends+1 && room_starts==car_starts+1 && gen_creates==2 && gen_destroys==2
            && GameCont.area==area_desert && GameCont.subarea==1 && instance_exists(pet) && pet.leader==owner
            && pet.leader_index==0 && array_length(source_bandits)>0 && player.hp==8,
            "Real car/Portal did not transfer same Cuz into actual generated Desert1")
        scrNTTEFullCuzConnectedAwait(4);return;
    }
    if(phase==4) {
        if(instance_exists(owner)) return;
        if(!is_struct(takeover_setup) || pet_returns==0) {
            assert(!instance_exists(GameOver),"Actual event order created GameOver before companion takeover")
            return;
        }
        assert(owner_destroys==1 && is_struct(destroy_record) && is_struct(takeover_before)
            && is_struct(takeover_setup) && pet_returns==1,"Owner death did not execute actual Cuz Pet.Step takeover/self-cleanup")
        var _b=takeover_before,_n=takeover_setup
        assert(_n.id==player && _n.race==Race.Cuz && _n.adopted && _n.hp==_n.max_hp && _n.max_hp==8
            && _n.index==_b.index && _n.x==_b.x && _n.y==_b.y && _n.next==_b.frame+30 && _n.spirit==6
            && _n.spr_idle==_b.spr_idle && _n.spr_walk==_b.spr_walk && _n.mask==_b.mask && _n.angle==_b.angle,
            "Natural adopted Cuz identity/full HP/visual/native protection contract failed")
        assert(scr_playerinstance_find(0).race==Race.Cuz,"Source Cuz takeover failed retained-slot race update before ultra/save")
        assert(instance_exists(drop) && death_drops[0].wep==wep_revolver,"Native owner death did not produce original revolver pickup")
        scrNTTEFullCuzConnectedAwait(5);return;
    }
    if(phase==5 || phase==6 || phase==8) {
        assert(instance_exists(player) && player.hp>0 && instance_number(Player)==1 && !instance_exists(pet)
            && !instance_exists(owner) && pet_returns==1 && owner_destroys==1 && player.race==Race.Cuz
            && scrNTTEFullValue(player,"ntte_cuz_adopted",false) && !instance_exists(GameOver) && !instance_exists(Menu)
            && !UberCont.paused,"Adopted Cuz lost actual playable survivor/UI exclusion")
        with(UnlockScreen) assert(!visible && alarm[0]<0,"Original Cuz takeover did not cancel pending unlock overlay")
    }
    if(phase==5) {
        if(player.wep!=wep_revolver) return;
        assert(!instance_exists(drop) && player.ammo[Ammo.Bullets]>0,"Cuz did not recover real death-drop weapon/ammo through native pickup")
        play_start_x=player.x;play_start_y=player.y;play_draw_start=actual_draws;play_direction=undefined
        for(var _dir=0;_dir<360;_dir+=45) {
            var _free=false,_x=player.x+lengthdir_x(28,_dir),_y=player.y+lengthdir_y(28,_dir)
            with(player) _free=!place_meeting(_x,_y,Wall)
            if(_free && !collision_line(player.x,player.y,_x,_y,Wall,false,false)) {play_direction=_dir;break}
        }
        assert(!is_undefined(play_direction),"Adopted Cuz has no clear native movement probe direction")
        scrNTTEFullCuzConnectedAwait(6);return;
    }
    if(phase==6 || phase==8) {
        if(scrNTTEFullValue(player,"ntte_cuz_snd_num",-1)>=0
            && array_get_index([sndCuzBye,sndCuzWep],scrNTTEFullValue(player,"ntte_cuz_snd",-1))>=0) beat_seen=true
        with(Wind) if(sprite_index==scrNTTERefSprite("PetParrotNote") && point_distance(x,y,other.player.x,other.player.y)<64) other.note_seen=true
        if(elapsed<12 || actual_draws-play_draw_start<8 || !beat_seen || !note_seen) return;
        assert(beat_seen && note_seen && spec_samples>0,"Adopted Cuz sampled active input did not run source beatbox/note path")
        if(phase==6) {
            assert(point_distance(player.x,player.y,play_start_x,play_start_y)>2 && shot_count>0 && ammo_spent==shot_count,
                "Adopted Cuz normal sampled movement/fire did not produce actual motion/projectile/ammo")
            saved_player=player;saved_fingerprint=scrNTTEFullCuzConnectedFingerprint(player)
            scrNTTESmokeLog("CUZ CONNECTED FINGERPRINT before-full-save "+saved_fingerprint)
            // Explicit independent persistence boundary, not pause-menu route.
            scrSavegameSave();assert(file_exists(savegame_file),"Cuz native full binary save missing")
            continue_ends=room_ends;continue_starts=room_starts;continue_gen=gen_creates
            measuring=false;scrNTTEFullCuzConnectedClear();UberCont.want_quit_to_menu=false
            measuring=true;scrNTTEFullCuzConnectedAwait(7);room_restart();return;
        }
        scrNTTESmokeLog("PASS CUZ CONNECTED controlled Fish8HP/Crib701932/native engine+Gen/Couch+Yung+deferredPet/sampled prompt adoption/"
            +"actual car+Portal Desert1/same pet persistence/generated-Bandit Alarm1+moving3damage bullets/native lethal owner Destroy/"
            +"actual Pet.Step takeover+safe self-cleanup/new adopted Cuz+retained slot/native sampled movement+fire+beatbox+actual8Draw/"
            +"separate controlled full binary/native Vlambeer+Player.RoomStart/continued beatbox @"+string(rates[pass_index])
            +"; ordinary Crib ingress/unlock, pause UI save route, multiplayer/ultras/special portal variants/iPhone not covered")
// BEGIN NTTE CUZ AUDIO TEST PASS GATE
if(os_type==os_windows && scrNTTEFullSmokeEnabled() && instance_exists(NTTEFullCuzConnectedTest) && variable_instance_exists(instance_find(NTTEFullCuzConnectedTest,0),"ntte_cuz_audio")) try { var _ntte_cuz_audio_event_receiver=id; with(instance_find(NTTEFullCuzConnectedTest,0)) { scrNTTEFullCuzMusicPassDone(); } } catch(_ntte_cuz_audio_error) { with(instance_find(NTTEFullCuzConnectedTest,0)) scrNTTEFullCuzConnectedAbort(_ntte_cuz_audio_error); }
// END NTTE CUZ AUDIO TEST PASS GATE
        if(++pass_index<array_length(rates)) {scrNTTEFullCuzConnectedAwait(0);return}
        scrNTTEFullCuzConnectedRestore();scrNTTESmokeLog("PASS full internal selected implemented branches x 30/60; not complete MOD coverage");game_end()
    }
    if(phase==7) {
        if(room_ends==continue_ends || !scrNTTEFullCuzConnectedWorldReady()) return;
        assert(room_ends==continue_ends+1 && room_starts==continue_starts+1 && gen_creates==continue_gen+1
            && load_calls==1 && array_length(player_loads)==1 && instance_number(Player)==1 && Player.id!=saved_player
            && player_loads[0]==Player.id && array_get_index(player_room_starts,Player.id)>=0
            && UberCont.continued_run && GameCont.is_level_continuation,"Cuz full native Continue skipped loader/engine identity boundary")
        player=Player.id
        scrNTTESmokeLog("CUZ CONNECTED FINGERPRINT comparison "+json_stringify({
            before:saved_fingerprint,after:scrNTTEFullCuzConnectedFingerprint(player),frame:current_frame,elapsed:elapsed}))
        assert(scrNTTEFullCuzConnectedFingerprintEqual(scrNTTEFullCuzConnectedFingerprint(player),saved_fingerprint),"Full native Cuz Continue changed inventory/HP/adoption/slot")
        play_draw_start=actual_draws;note_seen=false;beat_seen=false
        scrNTTEFullCuzConnectedAwait(8)
    }
}
function scrNTTEFullCuzConnectedBegin() {
    try {scrNTTEFullCuzConnectedBeginBody()} catch(_error) {scrNTTEFullCuzConnectedAbort(_error)}
}
function scrNTTEFullCuzConnectedEnd() {
    try {scrNTTEFullCuzConnectedEndBody()} catch(_error) {scrNTTEFullCuzConnectedAbort(_error)}
}

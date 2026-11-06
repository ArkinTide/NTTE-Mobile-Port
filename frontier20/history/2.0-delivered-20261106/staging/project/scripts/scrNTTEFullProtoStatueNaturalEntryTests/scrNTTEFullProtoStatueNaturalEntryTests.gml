// Dedicated Windows acceptance: controlled Scrap2/proto=false, source-born
// Statue and enemies, native input/fire/rads, actual Portal and engine Vault.
// This is not Ancient0 acquisition, a hub deposit, or ordinary campaign ingress.
function scrNTTEFullProtoEntryProtectBot() {
    // Test-only survival prerequisite. All native damage callbacks still run.
    if(restored || phase<=0 || !instance_exists(player)) return;
    player.hp=max(player.hp,1000000)
}
function scrNTTEFullProtoEntryClear() {
    var _keep=id
    with(all) if(id!=_keep && object_index!=UberCont && object_index!=Console) instance_destroy(id,false)
}
function scrNTTEFullProtoEntryRestore() {
    if(restored) return;
    restored=true
    if(path_exists(bot_path)) path_delete(bot_path)
    var _unchanged=ds_map_write(old_save_map)==old_savedata
    scrNTTEFullProtoEntryClear()
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
    assert(_unchanged && ds_map_write(old_save_map)==old_savedata,"Proto entry cleanup changed original physical save/options")
    // Dedicated process teardown: native Uber.RoomEnd writes options even with
    // dont_save. Stop that extra termination event after original bytes restore.
    instance_deactivate_object(UberCont)
}
function scrNTTEFullProtoStatueNaturalEntryTests() {
    assert(os_type==os_windows && scrNTTEFullSmokeEnabled(),"Proto entry requires explicit Windows full smoke")
    assert(!instance_exists(NTTEFullProtoStatueNaturalEntryTest),"Proto entry observer duplicated")
    var _observer=instance_create(0,0,NTTEFullProtoStatueNaturalEntryTest)
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
        scratch_root=working_directory+"proto-statue-entry-"+string(get_timer())+"/";directory_create(scratch_root)
        rates=[30,60];pass_index=0;phase=0;elapsed=0;draw_frames=0;world_ready_draw=-1
        candidate_seeds=[6123,701932,101013,713251];candidate_index=0;selected_seed_30=-1
        current_seed=-1;perch_x=10016;perch_y=10016;bot_goal_x=10016;bot_goal_y=10016
        player=noone;statue=noone;portal=noone;reserve=noone
        generated_enemies=[];generated_rad_chests=[];topraven_successors=[];native_shots=[];drops=[];gen_creates=0;gen_destroys=0
        statue_creates=0;statue_destroy_seen=false;room_ends=0;room_starts=0
        bot_path=path_add();bot_target=noone;bot_path_clock=0;bot_path_cursor=0;bot_was_fire=false
        diagnostic_clock=0;shot_count=0;ammo_spent=0;statue_hits=0;enemy_hits=0;received_rads=0
        fire_samples=0;move_samples=0;charged_seen=false;saw_spawn=false;saw_open=false
        input_calls=0;input_matched=0;input_active=0;last_input_index=-1;phase_input_start=0
        path_requests=0;path_successes=0;path_failures=0;path_fail_streak=0;profile_paths=0
        last_path={};phase_origin_x=0;phase_origin_y=0
        saw_contact=false;saw_disappear=false;native_restart_requested=false
        smoke_drivers=scrNTTEFullInstances(NTTESmokeTest)
        with(NTTESmokeTest) instance_deactivate_object(id)
        global.ntte_smoke_active=false
        scrNTTEFullProtoEntryClear()
    }
}
function scrNTTEFullProtoEntryAwait(_next) {
    phase=_next;elapsed=0;world_ready_draw=-1;diagnostic_clock=0
    phase_input_start=input_matched;path_fail_streak=0
    if(instance_exists(player)) {phase_origin_x=player.x;phase_origin_y=player.y}
    scrNTTESmokeLog("PROTO ENTRY phase="+string(phase)+" rate="+string(rates[pass_index]))
}
function scrNTTEFullProtoEntryWorldReady() {
    if(instance_exists(GenCont) || instance_exists(FloorMaker)) {world_ready_draw=-1;return false;}
    if(world_ready_draw<0) {world_ready_draw=draw_frames;return false;}
    return draw_frames-world_ready_draw>=8
}
function scrNTTEFullProtoEntryRate(_where) {
    assert(UberCont.saveData==fixture_save_map && ds_map_write(old_save_map)==old_savedata
        && game_get_speed(gamespeed_fps)==rates[pass_index] && timescale==30/rates[pass_index]
        && UberCont.opt_framerate==rates[pass_index] && !UberCont.opt_autopause
        && save_get_value("options","framerate",-1)==rates[pass_index]
        && !save_get_value("options","autopause",true),"Proto entry rate/options changed: "+_where)
}
function scrNTTEFullProtoEntryDiagnostic(_where) {
    var _enemies=[],_rads=[],_statue={exists:instance_exists(statue)},_player={exists:instance_exists(player)}
    if(instance_exists(statue)) _statue={id:statue,x:statue.x,y:statue.y,hp:statue.hp,max_hp:statue.max_hp,
        rad:statue.rad,charged:statue.charged,visible:statue.visible}
    if(instance_exists(player)) _player={id:player,x:player.x,y:player.y,hp:player.hp,max_hp:player.max_hp,
        wep:player.wep,ammo:player.ammo,reload:player.reload,can_walk:player.can_walk,can_aim:player.can_aim}
    with(enemy) array_push(_enemies,{id:id,type:object_get_name(object_index),x:x,y:y,hp:hp,raddrop:raddrop,
        visible:visible,team:team,reserved:id==other.reserve})
    with(Rad) array_push(_rads,{id:id,x:x,y:y,speed:speed,type:object_get_name(object_index),target:scrNTTEFullValue(id,"target",noone),
        life:alarm[0],claimed:is_struct(scrNTTEFullValue(id,"ntte_full_rad_path",undefined))})
    scrNTTESmokeLog("PROTO ENTRY DIAGNOSTIC "+_where+" "+json_stringify({rate:rates[pass_index],
        seed:current_seed,phase:phase,elapsed:elapsed,statue:_statue,player:_player,enemies:_enemies,rads:_rads,
        generated:generated_enemies,drops:drops,shots:shot_count,ammo_spent:ammo_spent,statue_hits:statue_hits,
        enemy_hits:enemy_hits,received_rads:received_rads,charged_seen:charged_seen,
        gen_creates:gen_creates,gen_destroys:gen_destroys,room_ends:room_ends,room_starts:room_starts,
        portals:instance_number(Portal),levcont:instance_number(LevCont),input_fire:fire_samples,input_move:move_samples,
        input_calls:input_calls,input_matched:input_matched,input_active:input_active,last_input_index:last_input_index,
        player_index:instance_exists(player)?player.index:-1,global_index:global.index,
        block_input_frames:UberCont.block_input_frames,block_input_fire:UberCont.block_input_fire,
        generation_active:instance_exists(GenCont)||instance_exists(FloorMaker),
        path_requests:path_requests,path_successes:path_successes,path_failures:path_failures,
        path_fail_streak:path_fail_streak,profile_paths:profile_paths,last_path:last_path,
        perch:[perch_x,perch_y],phase_origin:[phase_origin_x,phase_origin_y],
        rng:random_get_seed(),native_rng:global.rng_state,proto:instance_exists(GameCont)?GameCont.proto:false}))
}
function scrNTTEFullProtoEntryCandidate() {
    // Candidate generation is a declared bootstrap, never a measured portal.
    scrNTTEFullProtoEntryClear()
    current_seed=candidate_seeds[candidate_index]
    global.custom_seed=current_seed;global.recontinued_times=0
    UberCont.continued_run=false
    global.ntte_full_progress={schema:1,unlocks:{},loadouts:{},stats:{}}
    if(file_exists(savegame_file)) file_delete(savegame_file)
    generated_enemies=[];generated_rad_chests=[];topraven_successors=[];native_shots=[];drops=[];gen_creates=0;gen_destroys=0
    statue=noone;portal=noone;reserve=noone;statue_creates=0;statue_destroy_seen=false
    room_ends=0;room_starts=0;shot_count=0;ammo_spent=0;statue_hits=0;enemy_hits=0;received_rads=0
    fire_samples=0;move_samples=0;charged_seen=false;bot_was_fire=false
    input_calls=0;input_matched=0;input_active=0;last_input_index=-1;phase_input_start=0
    path_requests=0;path_successes=0;path_failures=0;path_fail_streak=0;profile_paths=0;last_path={}
    saw_spawn=false;saw_open=false;saw_contact=false;saw_disappear=false;native_restart_requested=false
    path_clear_points(bot_path);bot_target=noone;bot_path_clock=0;bot_path_cursor=0
    instance_create(0,0,GameCont);instance_create(0,0,BackCont);instance_create(0,0,MusCont);scrCreatePlayers(0)
    assert(global.seed==current_seed,"Proto controlled native custom-seed initialization changed seed")
    GameCont.area=area_scrapyards;GameCont.subarea=2;GameCont.loops=0;GameCont.hard=5
    GameCont.maxsubarea=scrAreaGetMaxSubarea(GameCont.area);GameCont.finalsubarea=false
    GameCont.can_advance_stage=true;GameCont.gocrib=false;GameCont.crown=crwn_none
    // Deliberately the HUB branch. Native preceding-region proto acquisition
    // and Ancient0 chest discovery are outside this independent entrance case.
    GameCont.proto=false
    assert(GameCont.crownvisits==0 && GameCont.crownrad==0,"Controlled run unexpectedly carries prior vault visits/radiation")
    GameCont.ntte_full_pending_destination=undefined
    GameCont.ntte_full_source_seed=scrNTTEFullSourceSeedBuild(current_seed)
    GameCont.ntte_full_source_pending_generation=undefined;global.ntte_full_sync_generation=false
    scrRngStatesReset()
    player=instance_find(Player,0)
    // Declared legal controlled starting equipment/max ammo. No subsequent
    // ammo/radiation/charged edits or DPS changes. A BeginStep health
    // floor protects only the bot; real damage callbacks still execute.
    player.wep=wep_minigun;player.bwep=wep_revolver;player.infammo=0
    player.ammo[Ammo.Bullets]=typ_amax[Ammo.Bullets]
    assert(player.hp==player.max_hp && player.hp>0 && player.infammo==0,"Native starting Player health/ammo prerequisite failed")
    scrNTTEFullFloorResetStyle();scrNTTEFullFloorResetAlign()
    scrNTTEFullProtoEntryAwait(1)
    var _gen=instance_create(0,0,GenCont)
    assert(!_gen.ntte_full_sync_generation,"Proto entry replaced actual asynchronous generation")
    scrNTTESmokeLog("PROTO ENTRY controlled Scrap2/loop0/hard5/proto=false/test-only bot health floor/Minigun+Revolver/max starting bullets; seed="
        +string(current_seed)+" @"+string(rates[pass_index]))
}
function scrNTTEFullProtoEntryProfile() {
    profile_reject=""
    if(instance_number(ProtoStatue)!=1 || statue_creates!=1 || !instance_exists(statue)) {
        profile_reject="natural statue count/constructor";return false
    }
    assert(statue.hp==statue.max_hp && statue.max_hp==120 && statue.rad==0 && !statue.charged
        && GameCont.proto==false,"Natural statue source baseline changed before combat")
    var _far=-1
    for(var _i=0;_i<array_length(generated_enemies);++_i) {
        var _enemy=generated_enemies[_i]
        if(!instance_exists(_enemy) || _enemy.hp<=0 || _enemy.team==player.team) continue
        var _distance=point_distance(_enemy.x,_enemy.y,statue.x,statue.y)
        if(_distance>_far) {_far=_distance;reserve=_enemy}
    }
    var _available=0,_near=[]
    for(var _i=0;_i<array_length(generated_enemies);++_i) {
        var _enemy=generated_enemies[_i]
        if(!instance_exists(_enemy) || _enemy==reserve || _enemy.hp<=0 || _enemy.team==player.team) continue
        if(point_distance(_enemy.x,_enemy.y,statue.x,statue.y)<148
            && !collision_line(_enemy.x,_enemy.y,statue.x,statue.y,Wall,false,false)) {
            _available+=_enemy.raddrop;array_push(_near,_enemy)
        }
    }
    // Strict pre-combat geometry prerequisite, not an artificial rad grant.
    if(!instance_exists(reserve) || _available<25) {
        profile_reject="source nearby unreserved radiation="+string(_available)+" needs25; reserve="+string(reserve);return false
    }
    perch_x=0;perch_y=0;var _best=infinity,_found=false,_eligible=0
    var _grid=scrNTTEFullProtoEntryGrid()
    with(Floor) {
        var _x=(bbox_left+bbox_right)/2,_y=(bbox_top+bbox_bottom)/2,
            _distance=point_distance(_x,_y,other.statue.x,other.statue.y),_free=false
        with(other.player) _free=!place_meeting(_x,_y,Wall)
        if(_distance<94 || _distance>138 || !_free
            || collision_line(_x,_y,other.statue.x,other.statue.y,Wall,false,false)) continue
        _eligible++
        // Read the real starting Player and the same planner as native input.
        // A clear perch alone does not prove the bot can walk there.
        var _reachable=false
        with(other) {_reachable=scrNTTEFullProtoEntryPlan(_grid,_x,_y,true)}
        if(!_reachable) continue
        var _score=point_distance(_x,_y,other.player.x,other.player.y)
        if(_score<_best) {_best=_score;other.perch_x=_x;other.perch_y=_y;_found=true}
    }
    if(_found) scrNTTEFullProtoEntryPlan(_grid,perch_x,perch_y,true)
    mp_grid_destroy(_grid.id);path_clear_points(bot_path)
    if(!_found) {profile_reject="no reachable natural clear94..138px firing perch; eligible="+string(_eligible);return false}
    scrNTTESmokeLog("PROTO ENTRY PROFILE "+json_stringify({seed:current_seed,nearby_source_rad:_available,
        nearby_enemies:_near,reserve:reserve,perch:[perch_x,perch_y],statue:statue,rate:rates[pass_index],
        eligible_perches:_eligible,profile_paths:profile_paths,last_path:last_path}))
    return true
}
function scrNTTEFullProtoEntryFireBefore(_weapon) {
    var _observer=instance_find(NTTEFullProtoStatueNaturalEntryTest,0)
    if(!instance_exists(_observer) || id!=_observer.player || _observer.phase<2 || _observer.phase>4) return undefined;
    assert(_weapon==wep_minigun && infammo==0 && !global.__debug_infammo,"Proto bot changed declared native weapon/ammo rules")
    return {weapon:_weapon,before:scrNTTEFullInstances(Bullet1),ammo:ammo[Ammo.Bullets]}
}
function scrNTTEFullProtoEntryFireAfter(_sample) {
    if(!is_struct(_sample)) return;
    var _observer=instance_find(NTTEFullProtoStatueNaturalEntryTest,0),_new=0,_shots=scrNTTEFullInstances(Bullet1)
    for(var _i=0;_i<array_length(_shots);++_i) {
        var _shot=_shots[_i]
        if(array_get_index(_sample.before,_shot)>=0 || _shot.creator!=id) continue
        assert(_shot.damage==3 && _shot.speed>0 && point_distance(_shot.x,_shot.y,x,y)<40,
            "Proto native fire changed damage/muzzle/travel")
        array_push(_observer.native_shots,{shot:_shot,x:_shot.x,y:_shot.y,damage:_shot.damage,weapon:_sample.weapon});_new++
    }
    if(_new==0) {
        if(ammo[Ammo.Bullets]!=_sample.ammo) {
            var _live=[];
            for(var _i=0;_i<array_length(_shots);++_i) {
                var _shot=_shots[_i];
                array_push(_live,{shot:_shot,type:object_get_name(_shot.object_index),creator:_shot.creator,
                    old:array_get_index(_sample.before,_shot)>=0,x:_shot.x,y:_shot.y});
            }
            scrNTTESmokeLog("PROTO FIRE AMMO MISMATCH "+json_stringify({before:_sample.ammo,after:ammo[Ammo.Bullets],
                weapon:_sample.weapon,held:wep,player:id,x:x,y:y,reload:reload,can_shoot:can_shoot,shots:_live}));
        }
        assert(ammo[Ammo.Bullets]==_sample.ammo,"Proto native fire consumed ammo without original projectile");return;
    }
    assert(_new==1 && ammo[Ammo.Bullets]==_sample.ammo-scr_weapon_get_cost(_sample.weapon)
        && reload==scr_weapon_get_load(_sample.weapon) && !can_shoot,"Proto native fire bypassed ammo/reload")
    _observer.shot_count++;_observer.ammo_spent+=scr_weapon_get_cost(_sample.weapon)
}
function scrNTTEFullProtoEntryBulletBefore(_target) {
    var _observer=instance_find(NTTEFullProtoStatueNaturalEntryTest,0)
    if(!instance_exists(_observer) || _observer.phase<2 || _observer.phase>4 || creator!=_observer.player
        || !instance_exists(_target)) return undefined;
    var _record=undefined
    for(var _i=0;_i<array_length(_observer.native_shots);++_i)
        if(_observer.native_shots[_i].shot==id) {_record=_observer.native_shots[_i];break}
    assert(is_struct(_record) && damage==3 && damage==_record.damage
        && point_distance(x,y,_record.x,_record.y)>1,"Proto hit lacks original PlayerFiring moving-projectile provenance")
    return {target:_target,hp:_target.hp,shot:id,damage:damage,travel:point_distance(x,y,_record.x,_record.y),
        statue:_target==_observer.statue,reserved:_target==_observer.reserve}
}
function scrNTTEFullProtoEntryBulletAfter(_sample) {
    if(!is_struct(_sample) || !instance_exists(_sample.target)) return;
    var _observer=instance_find(NTTEFullProtoStatueNaturalEntryTest,0),_loss=_sample.hp-_sample.target.hp
    if(_loss<=0) return;
    assert(_loss<=_sample.damage && !_sample.reserved,"Proto bot altered native damage or shot reserved map enemy")
    if(_sample.statue) _observer.statue_hits++;else _observer.enemy_hits++
    scrNTTESmokeLog("PROTO ENTRY NATIVE HIT "+json_stringify({shot:_sample.shot,target:_sample.target,
        statue:_sample.statue,before:_sample.hp,after:_sample.target.hp,damage:_sample.damage,travel:_sample.travel}))
}
function scrNTTEFullProtoEntryDeathBefore(_source_kind="enemy") {
    var _observer=instance_find(NTTEFullProtoStatueNaturalEntryTest,0)
    if(!instance_exists(_observer) || _observer.phase<1 || _observer.phase>4) return undefined;
    if(_source_kind=="rad_chest") {
        if(object_index!=RadChest || array_get_index(_observer.generated_rad_chests,id)<0) return undefined;
        assert(!instance_exists(GenCont) && hp<=0 && raddrop==25,
            "Generated RadChest drop observer requires actual native lethal destruction")
        return {enemy:id,type:object_get_name(object_index),hp:hp,raddrop:raddrop,
            source_kind:"rad_chest",source_generated:true,before:scrNTTEFullInstances(Rad)}
    }
    assert(_source_kind=="enemy","Unknown native drop observer source kind")
    return {enemy:id,type:object_get_name(object_index),hp:hp,raddrop:raddrop,source_kind:"enemy",
        source_generated:array_get_index(_observer.generated_enemies,id)>=0
            || scrNTTEFullProtoEntryTopRavenGenerated(_observer,id,object_index),before:scrNTTEFullInstances(Rad)}
}
function scrNTTEFullProtoEntryDeathAfter(_sample) {
    if(!is_struct(_sample)) return;
    var _observer=instance_find(NTTEFullProtoStatueNaturalEntryTest,0),_rads=scrNTTEFullInstances(Rad),_amount=0,_count=0
    for(var _i=0;_i<array_length(_rads);++_i) {
        var _rad=_rads[_i]
        if(array_get_index(_sample.before,_rad)>=0) continue
        if(_sample.source_kind=="rad_chest") {
            assert(_rad.object_index==Rad,"Native RadChest produced unexpected large/derived radiation")
            for(var _j=0;_j<array_length(_observer.drops);++_j)
                assert(_observer.drops[_j].rad!=_rad,"Native RadChest radiation already has another owner")
        }
        var _amount_here=_rad.object_index==BigRad?10:1
        array_push(_observer.drops,{rad:_rad,amount:_amount_here,source:_sample.enemy,type:_sample.type,
            source_kind:_sample.source_kind,source_generated:_sample.source_generated,
            lethal:_sample.hp<=0,consumed:false});_amount+=_amount_here;_count++
    }
    if(_sample.source_kind=="rad_chest") assert(_count==25 && _amount==25 && _sample.raddrop==25,
        "Native generated RadChest must drop exactly25 genuine individual radiation instances")
    if(_amount>0) scrNTTESmokeLog("PROTO ENTRY REAL NATIVE RAD DROP "+json_stringify({source:_sample.enemy,
        type:_sample.type,source_kind:_sample.source_kind,source_generated:_sample.source_generated,
        lethal:_sample.hp<=0,amount:_amount,declared:_sample.raddrop}))
}
function scrNTTEFullProtoEntryRadBefore(_statue) {
    var _observer=instance_find(NTTEFullProtoStatueNaturalEntryTest,0)
    if(!instance_exists(_observer) || _statue!=_observer.statue) return undefined;
    return {rad:id,before:_statue.rad,hp:_statue.hp,max_hp:_statue.max_hp,still:!speed/* NTTE PROTO RAD NATIVE STILL */,
        amount:object_index==BigRad?10:1,statue:_statue}
}
function scrNTTEFullProtoEntryRadAfter(_sample) {
    if(!is_struct(_sample) || !instance_exists(_sample.statue)) return;
    var _gain=_sample.statue.rad-_sample.before
    if(_gain==0) return;
    var _observer=instance_find(NTTEFullProtoStatueNaturalEntryTest,0),_record=undefined
    for(var _i=0;_i<array_length(_observer.drops);++_i)
        if(_observer.drops[_i].rad==_sample.rad) {_record=_observer.drops[_i];break}
    assert(is_struct(_record) && _record.source_generated && _record.lethal && !_record.consumed
        && _gain==_sample.amount && _record.amount==_gain && _sample.still && _sample.hp<_sample.max_hp*0.7
        && !instance_exists(_sample.rad),"Statue rad lacks genuine generated enemy/RadChest death/drop/native stopped collision provenance")
    _record.consumed=true;_observer.received_rads+=_gain
    scrNTTESmokeLog("PROTO ENTRY REAL STATUE RAD "+json_stringify({rad:_sample.rad,source:_record.source,
        amount:_gain,before:_sample.before,after:_sample.statue.rad,source_kind:_record.source_kind,source_generated:true}))
}
function scrNTTEFullProtoEntryProbe(_where) {
    var _observer=instance_find(NTTEFullProtoStatueNaturalEntryTest,0)
    if(!instance_exists(_observer) || _observer.restored) return;
    if(_where=="GenCont.Create.after") _observer.gen_creates++
    if(_where=="GenCont.Destroy.after") {
        _observer.gen_destroys++
        scrNTTESmokeLog("PROTO ENTRY REAL GEN DESTROY "+json_stringify({area:GameCont.area,subarea:GameCont.subarea,
            floors:instance_number(Floor),proto:GameCont.proto,rate:_observer.rates[_observer.pass_index]}))
    }
    if(_where=="Enemy.Create.after" && instance_exists(GenCont)
        && GameCont.area==area_scrapyards && GameCont.subarea==2) array_push(_observer.generated_enemies,id)
    if(_where=="RadChest.Create.after" && _observer.phase==1 && instance_exists(GenCont)
        && GameCont.area==area_scrapyards && GameCont.subarea==2) {
        assert(object_index==RadChest && hp==max_hp && hp>0 && raddrop==25
            && array_get_index(_observer.generated_rad_chests,id)<0,
            "Generated RadChest observer requires a unique genuine native healthy constructor")
        array_push(_observer.generated_rad_chests,id)
        scrNTTESmokeLog("PROTO ENTRY REAL GENERATED RAD CHEST "+json_stringify({source:id,x:x,y:y,
            seed:_observer.current_seed,pass:_observer.pass_index,amount:raddrop}))
    }
    if(_where=="Statue.Create.after") {
        _observer.statue_creates++;_observer.statue=id
        _observer.statue_x=x;_observer.statue_y=y
    }
    if(_where=="Statue.Destroy.before" && id==_observer.statue) {
        assert(hp<=0 && rad>24 && charged && rad==_observer.received_rads && _observer.statue_hits>0,
            "Statue destroyed before genuine charging/native lethal shooting")
        _observer.statue_destroy_seen=true
        scrNTTESmokeLog("PROTO ENTRY REAL STATUE DEATH "+json_stringify({id:id,hp:hp,rad:rad,charged:charged}))
    }
    if((_where=="Portal.Contact.after" || _where=="Portal.Animation.before" || _where=="Portal.Alarm1.before")
        && id==_observer.portal) {
        if(sprite_index==sprPortalSpawn) _observer.saw_spawn=true
        if(sprite_index==sprProtoPortal) _observer.saw_open=true
        if(sprite_index==sprProtoPortalDisappear) _observer.saw_disappear=true
        if(_where=="Portal.Contact.after" && endgame<=30) _observer.saw_contact=true
        if(_where=="Portal.Alarm1.before") _observer.native_restart_requested=true
        scrNTTESmokeLog("PROTO ENTRY REAL PORTAL "+_where+" "+json_stringify({portal:id,type:type,
            sprite:sprite_get_name(sprite_index),endgame:endgame,room_ends:_observer.room_ends}))
    }
}
function scrNTTEFullProtoEntryGrid() {
    var _left=infinity,_top=infinity,_right=-infinity,_bottom=-infinity
    with(Floor) {_left=min(_left,bbox_left);_top=min(_top,bbox_top);_right=max(_right,bbox_right);_bottom=max(_bottom,bbox_bottom)}
    var _x=floor((_left-64)/8)*8,_y=floor((_top-64)/8)*8,
        _width=ceil((_right-_left+128)/8),_height=ceil((_bottom-_top+128)/8),
        _grid=mp_grid_create(_x,_y,_width,_height,8,8)
    with(Wall) mp_grid_add_rectangle(_grid,bbox_left-5,bbox_top-3,bbox_right+5,bbox_bottom+3)
    return {id:_grid,x:_x,y:_y,width:_width,height:_height}
}
// BEGIN NTTE PROTO PROFILE PATH READONLY HELPERS
function scrNTTEFullProtoProfilePointRead(_x,_y,_walls) {
    var _wall=false,_floor=false,_center=position_meeting(_x,_y,Floor),
        _bbox=[player.bbox_left+_x-player.x,player.bbox_top+_y-player.y,
            player.bbox_right+_x-player.x,player.bbox_bottom+_y-player.y],_near=[]
    with(player) {_wall=place_meeting(_x,_y,Wall);_floor=place_meeting(_x,_y,Floor)}
    if(_walls) with(Wall) {
        if(bbox_right>=_bbox[0]-16 && bbox_left<=_bbox[2]+16
            && bbox_bottom>=_bbox[1]-16 && bbox_top<=_bbox[3]+16)
            array_push(_near,{id:id,xy:[x,y],bbox:[bbox_left,bbox_top,bbox_right,bbox_bottom],mask:mask_index})
    }
    return {xy:[_x,_y],wall:_wall,floor:_floor,center_floor:_center,translated_bbox:_bbox,walls:_near}
}
function scrNTTEFullProtoProfileSegmentRead(_x1,_y1,_x2,_y2,_budget) {
    var _steps=max(1,ceil(point_distance(_x1,_y1,_x2,_y2)/2))
    for(var _i=0;_i<=_steps;++_i) {
        if(_budget.remaining<=0) {_budget.exhausted=true;return {complete:false,legal:false,rule:"sample_budget"};}
        _budget.remaining--;_budget.samples++
        var _x=lerp(_x1,_x2,_i/_steps),_y=lerp(_y1,_y2,_i/_steps),_wall=false,_floor=false
        with(player) {_wall=place_meeting(_x,_y,Wall);_floor=place_meeting(_x,_y,Floor)}
        if(_wall || !_floor) return {complete:true,legal:false,rule:"wall_or_floor",sample:_i,steps:_steps,
            xy:[_x,_y],wall:_wall,floor:_floor}
    }
    return {complete:true,legal:true,steps:_steps}
}
function scrNTTEFullProtoProfileComponentRead(_grid) {
    var _total=_grid.width*_grid.height,_cache={complete:false,status:"node_budget",cells:[],members:[],
        frontier:[],visited:0,start_cell:[floor((player.x-_grid.x)/8),floor((player.y-_grid.y)/8)]}
    if(_total<=0 || _total>60000) return _cache;
    var _cells=array_create(_total,0),_seen=array_create(_total,0),_boundary=array_create(_total,0),
        _sx=_cache.start_cell[0],_sy=_cache.start_cell[1],_queue=[],_head=0
    for(var _y=0;_y<_grid.height;++_y) for(var _x=0;_x<_grid.width;++_x)
        _cells[_y*_grid.width+_x]=mp_grid_get_cell(_grid.id,_x,_y)
    _cache.cells=_cells;_cache.members=_seen
    if(_sx<0 || _sy<0 || _sx>=_grid.width || _sy>=_grid.height) {_cache.status="start_outside";return _cache;}
    var _start=_sy*_grid.width+_sx
    if(_cells[_start]!=0) {_cache.status="start_blocked";return _cache;}
    _seen[_start]=1;array_push(_queue,_start)
    var _dxs=[-1,1,0,0],_dys=[0,0,-1,1],_frontier=[]
    while(_head<array_length(_queue)) {
        var _index=_queue[_head++],_x=_index mod _grid.width,_y=floor(_index/_grid.width)
        _cache.visited++
        for(var _direction=0;_direction<4;++_direction) {
            var _nx=_x+_dxs[_direction],_ny=_y+_dys[_direction]
            if(_nx<0 || _ny<0 || _nx>=_grid.width || _ny>=_grid.height) continue
            var _next=_ny*_grid.width+_nx
            if(_cells[_next]!=0) {
                if(!_boundary[_next]) {_boundary[_next]=1;array_push(_frontier,[_index,_next]);}
            }
            else if(!_seen[_next]) {_seen[_next]=1;array_push(_queue,_next);}
        }
    }
    // Publish only completed local arrays, without writing the native grid.
    _cache.members=_seen;_cache.frontier=_frontier;_cache.complete=true;_cache.status="complete"
    return _cache
}
function scrNTTEFullProtoProfilePathRead(_grid,_x,_y) {
    if(!variable_struct_exists(_grid,"ntte_proto_read_component")) {
        _grid.ntte_proto_read_component=scrNTTEFullProtoProfileComponentRead(_grid)
        var _first=_grid.ntte_proto_read_component
        scrNTTESmokeLog("PROTO PROFILE GRID READONLY "+json_stringify({seed:current_seed,rate:rates[pass_index],
            phase:phase,origin:[_grid.x,_grid.y],dimensions:[_grid.width,_grid.height],cell:8,
            status:_first.status,complete:_first.complete,start_cell:_first.start_cell,visited:_first.visited,
            cells:_first.cells,members:_first.members,frontier:_first.frontier}))
    }
    var _cache=_grid.ntte_proto_read_component,_gx=floor((_x-_grid.x)/8),_gy=floor((_y-_grid.y)/8),
        _inside=_gx>=0 && _gy>=0 && _gx<_grid.width && _gy<_grid.height,_member=undefined,
        _budget={remaining:4096,samples:0,exhausted:false},_edges=[],_used=[]
    if(_cache.complete && _inside) _member=_cache.members[_gy*_grid.width+_gx]==1
    // Read at most32 unique blocked boundary cells nearest this exact goal.
    // This does not clear a cell, construct a usable route or change _success.
    for(var _sample=0;_sample<32 && !_budget.exhausted;++_sample) {
        var _best=-1,_distance=infinity
        for(var _i=0;_i<array_length(_cache.frontier);++_i) {
            if(array_get_index(_used,_i)>=0) continue
            var _next=_cache.frontier[_i][1],_nx=_grid.x+((_next mod _grid.width)+0.5)*8,
                _ny=_grid.y+(floor(_next/_grid.width)+0.5)*8,_d=point_distance(_nx,_ny,_x,_y)
            if(_d<_distance) {_best=_i;_distance=_d;}
        }
        if(_best<0) break;
        array_push(_used,_best)
        var _pair=_cache.frontier[_best],_from=_pair[0],_to=_pair[1],
            _fx=_grid.x+((_from mod _grid.width)+0.5)*8,_fy=_grid.y+(floor(_from/_grid.width)+0.5)*8,
            _tx=_grid.x+((_to mod _grid.width)+0.5)*8,_ty=_grid.y+(floor(_to/_grid.width)+0.5)*8
        array_push(_edges,{indices:_pair,from:scrNTTEFullProtoProfilePointRead(_fx,_fy,false),
            to:scrNTTEFullProtoProfilePointRead(_tx,_ty,false),
            segment:scrNTTEFullProtoProfileSegmentRead(_fx,_fy,_tx,_ty,_budget)})
    }
    scrNTTESmokeLog("PROTO PROFILE PATH READONLY "+json_stringify({seed:current_seed,rate:rates[pass_index],
        phase:phase,elapsed:elapsed,attempt:profile_paths+1,original_path:last_path,
        player:{id:player,xy:[player.x,player.y],mask:player.mask_index,sprite:player.sprite_index,
            image:player.image_index,angle:player.image_angle,scale:[player.image_xscale,player.image_yscale],
            bbox:[player.bbox_left,player.bbox_top,player.bbox_right,player.bbox_bottom]},
        start:scrNTTEFullProtoProfilePointRead(player.x,player.y,true),goal:scrNTTEFullProtoProfilePointRead(_x,_y,true),
        component:{complete:_cache.complete,status:_cache.status,visited:_cache.visited,goal_cell:[_gx,_gy],
            goal_inside:_inside,goal_member:_member,frontier_total:array_length(_cache.frontier)},
        direct_segment:scrNTTEFullProtoProfileSegmentRead(player.x,player.y,_x,_y,_budget),
        frontier_samples:_edges,budget:_budget}))
}
// END NTTE PROTO PROFILE PATH READONLY HELPERS
// BEGIN NTTE PROTO NATIVE PLANNER FALLBACK HELPERS
// Fixture-only fallback for proven conservative-grid false negatives.
// Native Player movement/fire remains the only way actors change position/HP.
function scrNTTEProtoNavPoint(_x,_y,_budget) {
    if(_budget.remaining<=0) {_budget.exhausted=true;return 0;}
    _budget.remaining--;_budget.samples++
    var _wall=false,_floor=false
    with(player) {_wall=place_meeting(_x,_y,Wall);_floor=place_meeting(_x,_y,Floor)}
    if(_wall) return 2;
    if(!_floor) return 3;
    return 1;
}
function scrNTTEProtoNavSegment(_x1,_y1,_x2,_y2,_budget) {
    var _steps=max(1,ceil(point_distance(_x1,_y1,_x2,_y2)/2))
    for(var _i=0;_i<=_steps;++_i)
        if(scrNTTEProtoNavPoint(lerp(_x1,_x2,_i/_steps),lerp(_y1,_y2,_i/_steps),_budget)!=1) return false;
    return true;
}
function scrNTTEProtoNavPose() {
    return [player,player.x,player.y,player.mask_index,player.sprite_index,player.image_index,
        player.image_xscale,player.image_yscale,player.image_angle,player.bbox_left,player.bbox_top,player.bbox_right,player.bbox_bottom];
}
function scrNTTEProtoNavBuild(_grid) {
    var _total=_grid.width*_grid.height,_budget={remaining:200000,samples:0,exhausted:false},
        _out={complete:false,status:"node_budget",budget:_budget,pose:scrNTTEProtoNavPose(),
            points:[],horizontal:[],vertical:[],members:[],parents:[],roots:[],visited:0}
    if(_total<=0 || _total>60000) return _out;
    var _points=array_create(_total,0),_horizontal=array_create(_total,0),_vertical=array_create(_total,0),
        _seen=array_create(_total,0),_parents=array_create(_total,-2),_roots=[],_queue=[],_head=0
    for(var _i=0;_i<_total && !_budget.exhausted;++_i)
        _points[_i]=scrNTTEProtoNavPoint(_grid.x+((_i mod _grid.width)+0.5)*8,
            _grid.y+(floor(_i/_grid.width)+0.5)*8,_budget)
    var _cx=floor((player.x-_grid.x)/8),_cy=floor((player.y-_grid.y)/8)
    for(var _dy=-1;_dy<=1;++_dy) for(var _dx=-1;_dx<=1;++_dx) {
        var _nx=_cx+_dx,_ny=_cy+_dy
        if(_nx<0 || _ny<0 || _nx>=_grid.width || _ny>=_grid.height) continue;
        var _index=_ny*_grid.width+_nx
        if(_points[_index]==1 && scrNTTEProtoNavSegment(player.x,player.y,
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
                else _code=scrNTTEProtoNavSegment(_x,_y,_grid.x+(_nx+0.5)*8,_grid.y+(_ny+0.5)*8,_budget)?1:2;
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
function scrNTTEProtoNavFallback(_grid,_goal_x,_goal_y) {
    var _pose=scrNTTEProtoNavPose(),_graph=undefined
    if(variable_struct_exists(_grid,"ntte_proto_nav_graph")) _graph=_grid.ntte_proto_nav_graph;
    // Reuse only inside this same synchronous grid scope and exact Player pose.
    // Every ordinary movement replan creates a fresh grid and a fresh graph.
    if(!is_struct(_graph) || json_stringify(_graph.pose)!=json_stringify(_pose)) {
        _graph=scrNTTEProtoNavBuild(_grid);_grid.ntte_proto_nav_graph=_graph
    }
    if(!_graph.complete || _graph.budget.exhausted) {
        scrNTTESmokeLog("PROTO NATIVE FALLBACK UNKNOWN "+json_stringify({seed:current_seed,rate:rates[pass_index],phase:phase,
            status:_graph.status,budget:_graph.budget,goal:[_goal_x,_goal_y]}))
        return false;
    }
    var _cx=floor((_goal_x-_grid.x)/8),_cy=floor((_goal_y-_grid.y)/8),_end=-1
    for(var _dy=-1;_dy<=1 && _end<0;++_dy) for(var _dx=-1;_dx<=1;++_dx) {
        var _nx=_cx+_dx,_ny=_cy+_dy
        if(_nx<0 || _ny<0 || _nx>=_grid.width || _ny>=_grid.height) continue;
        var _index=_ny*_grid.width+_nx
        if(_graph.members[_index] && scrNTTEProtoNavSegment(_goal_x,_goal_y,
            _grid.x+(_nx+0.5)*8,_grid.y+(_ny+0.5)*8,_graph.budget)) {_end=_index;break;}
    }
    if(_end<0 || _graph.budget.exhausted) return false;
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
        if(!scrNTTEProtoNavSegment(_route[_i-1][0],_route[_i-1][1],_route[_i][0],_route[_i][1],_graph.budget)) return false;
    if(_graph.budget.exhausted || json_stringify(scrNTTEProtoNavPose())!=json_stringify(_pose)) return false;
    path_clear_points(bot_path);path_set_kind(bot_path,0);path_set_closed(bot_path,false)
    for(var _i=0;_i<array_length(_route);++_i) path_add_point(bot_path,_route[_i][0],_route[_i][1],100)
    bot_native_mask_path=true
    scrNTTESmokeLog("PROTO NATIVE FALLBACK PATH "+json_stringify({seed:current_seed,rate:rates[pass_index],phase:phase,
        start:_route[0],goal:[_goal_x,_goal_y],points:array_length(_route),visited:_graph.visited,
        budget:_graph.budget,whole_route_rechecked:true,route:_route}))
    return true;
}
function scrNTTEProtoNavFollow() {
    // Never skip a close corner using distance alone. Every proposed shortcut
    // is checked using the current real Player mask/Floor before native input.
    var _budget={remaining:512,samples:0,exhausted:false},_last=path_get_number(bot_path)-1,
        _first=clamp(bot_path_cursor,1,_last),_chosen=-1
    for(var _i=min(_last,_first+8);_i>=_first;--_i) {
        var _x=path_get_point_x(bot_path,_i),_y=path_get_point_y(bot_path,_i)
        if(point_distance(player.x,player.y,_x,_y)<0.01) continue;
        if(scrNTTEProtoNavSegment(player.x,player.y,_x,_y,_budget)) {_chosen=_i;break;}
    }
    if(_chosen<0 || _budget.exhausted) {bot_path_clock=0;return undefined;}
    bot_path_cursor=_chosen
    return point_direction(player.x,player.y,path_get_point_x(bot_path,_chosen),path_get_point_y(bot_path,_chosen));
}
// END NTTE PROTO NATIVE PLANNER FALLBACK HELPERS
function scrNTTEFullProtoEntryPlan(_grid,_x,_y,_profile) {
    var _start_x=floor((player.x-_grid.x)/8),_start_y=floor((player.y-_grid.y)/8),
        _goal_x=floor((_x-_grid.x)/8),_goal_y=floor((_y-_grid.y)/8),
        _start_wall=false,_goal_wall=false,
        _start_floor=collision_point(player.x,player.y,Floor,false,false)!=noone,
        _goal_floor=collision_point(_x,_y,Floor,false,false)!=noone
    with(player) {_start_wall=place_meeting(x,y,Wall);_goal_wall=place_meeting(_x,_y,Wall)}
    // BEGIN NTTE PROTO NATIVE PLANNER FALLBACK RESET
    bot_native_mask_path=false
    // END NTTE PROTO NATIVE PLANNER FALLBACK RESET
    path_clear_points(bot_path)
    var _success=_start_floor && _goal_floor && !_start_wall && !_goal_wall
        && mp_grid_path(_grid.id,bot_path,player.x,player.y,_x,_y,false)
        && path_get_number(bot_path)>=2
    // BEGIN NTTE PROTO NATIVE PLANNER FALLBACK PLAN
    if(!_success && _start_floor && _goal_floor && !_start_wall && !_goal_wall)
        _success=scrNTTEProtoNavFallback(_grid,_x,_y)
    // END NTTE PROTO NATIVE PLANNER FALLBACK PLAN
    last_path={profile:_profile,start:[player.x,player.y],goal:[_x,_y],
        start_cell:[_start_x,_start_y],goal_cell:[_goal_x,_goal_y],
        start_occupancy:mp_grid_get_cell(_grid.id,_start_x,_start_y),
        goal_occupancy:mp_grid_get_cell(_grid.id,_goal_x,_goal_y),
        start_wall:_start_wall,goal_wall:_goal_wall,
        start_floor:_start_floor,goal_floor:_goal_floor,
        points:path_get_number(bot_path),success:_success}
    // BEGIN NTTE PROTO PROFILE PATH READONLY CALL
    if(_profile && current_seed==101013) try {scrNTTEFullProtoProfilePathRead(_grid,_x,_y);}
    catch(_ntte_proto_profile_read_error) {show_debug_message("PROTO PROFILE READONLY unavailable: "+string(_ntte_proto_profile_read_error));}
    // END NTTE PROTO PROFILE PATH READONLY CALL
    if(_profile) profile_paths++
    else {
        path_requests++
        if(_success) {path_successes++;path_fail_streak=0}
        else {path_failures++;path_fail_streak++}
    }
    return _success
}
function scrNTTEFullProtoEntryPathDirection(_x,_y) {
    bot_path_clock-=timescale
    if(bot_path_clock<=0 || point_distance(_x,_y,bot_goal_x,bot_goal_y)>12) {
        bot_goal_x=_x;bot_goal_y=_y;bot_path_clock=20;bot_path_cursor=1
        var _grid=scrNTTEFullProtoEntryGrid()
        scrNTTEFullProtoEntryPlan(_grid,_x,_y,false);mp_grid_destroy(_grid.id)
    }
    if(path_get_number(bot_path)<2) return undefined;
    // BEGIN NTTE PROTO NATIVE PLANNER FALLBACK FOLLOW
    if(variable_instance_exists(id,"bot_native_mask_path") && bot_native_mask_path) return scrNTTEProtoNavFollow();
    // END NTTE PROTO NATIVE PLANNER FALLBACK FOLLOW
    while(bot_path_cursor<path_get_number(bot_path)-1
        && point_distance(player.x,player.y,path_get_point_x(bot_path,bot_path_cursor),path_get_point_y(bot_path,bot_path_cursor))<6)
        bot_path_cursor++
    return point_direction(player.x,player.y,path_get_point_x(bot_path,bot_path_cursor),path_get_point_y(bot_path,bot_path_cursor))
}
// BEGIN NTTE PROTO MOVEMENT DODGE HELPERS
// Fixture movement prediction only. No actor/input/world setters are used.
function scrNTTEProtoDodgeThreats() {
    var _out={complete:true,threats:[]},_projectiles=instance_number(projectile),
        _warnings=instance_number(HitWarning),_assassins=instance_number(MeleeBandit)
    if(_projectiles>256 || _warnings>64 || _assassins>64) {_out.complete=false;return _out;}
    for(var _i=0;_i<_projectiles;++_i) {
        var _actor=instance_find(projectile,_i)
        if(!instance_exists(_actor) || !_actor.visible || _actor.mask_index==mskNone
            || !variable_instance_exists(_actor,"team") || _actor.team==player.team
            || !variable_instance_exists(_actor,"damage") || _actor.damage<=0) continue;
        var _gap_x=max(_actor.bbox_left-player.bbox_right,player.bbox_left-_actor.bbox_right),
            _gap_y=max(_actor.bbox_top-player.bbox_bottom,player.bbox_top-_actor.bbox_bottom)
        if(max(_gap_x,_gap_y)>128) continue;
        array_push(_out.threats,{actor:_actor,warning:false,x:_actor.x,y:_actor.y,
            vx:_actor.hspeed,vy:_actor.vspeed,box:[_actor.bbox_left,_actor.bbox_top,_actor.bbox_right,_actor.bbox_bottom],
            slash:instance_is(_actor,EnemySlash)})
        if(array_length(_out.threats)>32) {_out.complete=false;return _out;}
    }
    // HitWarning has no creator field. Pair its visible location with a
    // visible hostile Assassin; this is conservative warning geometry, not
    // a claim that the warning owns that actor or a source callback rewrite.
    for(var _i=0;_i<_warnings;++_i) {
        var _notice=instance_find(HitWarning,_i)
        if(!instance_exists(_notice) || !_notice.visible) continue;
        for(var _j=0;_j<_assassins;++_j) {
            var _actor=instance_find(MeleeBandit,_j)
            if(!instance_exists(_actor) || !_actor.visible || _actor.team==player.team || _actor.hp<=0
                || _actor.alarm[2]<=0 || _actor.alarm[2]>10
                || point_distance(_notice.x,_notice.y+16,_actor.x,_actor.y)>64
                || point_distance(player.x,player.y,_actor.x,_actor.y)>112) continue;
            array_push(_out.threats,{actor:_actor,warning:true,x:_actor.x,y:_actor.y,
                vx:_actor.hspeed,vy:_actor.vspeed,box:[],slash:true})
            if(array_length(_out.threats)>32) {_out.complete=false;return _out;}
        }
    }
    return _out;
}
function scrNTTEProtoDodgeRisk(_moving,_direction,_threats,_terrain,_budget) {
    var _frames=ceil(8/timescale),_px=player.x,_py=player.y,_vx=player.hspeed,_vy=player.vspeed,
        _max=player.maxspeed,_friction=player.friction,_risk=0,_clearance=infinity,
        _left=player.bbox_left-player.x,_top=player.bbox_top-player.y,
        _right=player.bbox_right-player.x,_bottom=player.bbox_bottom-player.y
    for(var _step=0;_step<=_frames;++_step) {
        if(_step>0) {
            var _speed=point_distance(0,0,_vx,_vy)
            if(_moving && _speed<_max) {
                _vx+=lengthdir_x(3*timescale,_direction);_vy+=lengthdir_y(3*timescale,_direction)
                _speed=point_distance(0,0,_vx,_vy)
            }
            // Match Player.Step's unconditional late speed cap as well as
            // its acceleration cap, including externally added momentum.
            if(_speed>_max) {_vx*=_max/_speed;_vy*=_max/_speed;_speed=_max;}
            var _drag=_speed>0?max(0,_speed-_friction)/_speed:0
            _vx*=_drag;_vy*=_drag
            var _nx=_px+_vx,_ny=_py+_vy
            if(_terrain && !scrNTTEProtoNavSegment(_px,_py,_nx,_ny,_budget))
                return {complete:!_budget.exhausted,legal:false,risk:infinity,clearance:-infinity};
            _px=_nx;_py=_ny
        }
        for(var _i=0;_i<array_length(_threats);++_i) {
            if(_budget.remaining<=0) {_budget.exhausted=true;return {complete:false,legal:false,risk:infinity,clearance:-infinity};}
            _budget.remaining--;_budget.samples++
            var _threat=_threats[_i],_shift_x=_threat.vx*_step,_shift_y=_threat.vy*_step,
                _gap=infinity,_hit=false
            if(_threat.warning) {
                // Rotated64x48 Slash origin16,24 has <=54px radial reach;
                //72 also covers the real Player mask and a short safety gap.
                _gap=point_distance(_px,_py,_threat.x+_shift_x,_threat.y+_shift_y)-72
            }
            else {
                // Translation equivalence queries the real current rotated
                // projectile and Player masks without moving either actor.
                var _query_x=_px-_shift_x,_query_y=_py-_shift_y
                with(player) _hit=place_meeting(_query_x,_query_y,_threat.actor)
                // Preserve the full rotated Slash extent and sweep the
                // previous/current projected boxes. Never use center CPA.
                var _previous=max(0,_step-1),_margin=_threat.slash?6:3,
                    _sl=_threat.box[0]+min(_shift_x,_threat.vx*_previous)-_margin,
                    _st=_threat.box[1]+min(_shift_y,_threat.vy*_previous)-_margin,
                    _sr=_threat.box[2]+max(_shift_x,_threat.vx*_previous)+_margin,
                    _sb=_threat.box[3]+max(_shift_y,_threat.vy*_previous)+_margin
                _gap=max(_sl-(_px+_right),(_px+_left)-_sr,_st-(_py+_bottom),(_py+_top)-_sb)
            }
            _clearance=min(_clearance,_gap)
            if(_hit || _gap<=0) _risk+=(_frames-_step+1)*(1+min(72,max(0,-_gap)))
        }
    }
    return {complete:!_budget.exhausted,legal:true,risk:_risk,clearance:_clearance};
}
function scrNTTEProtoDodgeMove(_moving,_direction) {
    var _answer={override:false,moving:_moving,direction:_direction},_started=get_timer()
    if(timescale<0.5 || timescale>1 || !player.can_walk || player.roll) return _answer;
    var _scan=scrNTTEProtoDodgeThreats()
    if(!_scan.complete || array_length(_scan.threats)==0) return _answer;
    var _budget={remaining:65536,samples:0,exhausted:false},
        _base=scrNTTEProtoDodgeRisk(_moving,_direction,_scan.threats,false,_budget)
    if(!_base.complete || _base.risk<=0) return _answer;
    var _best=_base,_chosen=-1,_directions=[_direction],_moves=[_moving]
    for(var _i=0;_i<16;++_i) {array_push(_directions,_i*22.5);array_push(_moves,true);}
    array_push(_directions,0);array_push(_moves,false)
    for(var _i=0;_i<array_length(_directions);++_i) {
        var _sample=scrNTTEProtoDodgeRisk(_moves[_i],_directions[_i],_scan.threats,true,_budget)
        if(!_sample.complete || _budget.exhausted) return _answer;
        if(!_sample.legal) continue;
        if(_sample.risk<_best.risk-0.001 || (abs(_sample.risk-_best.risk)<=0.001 && _sample.clearance>_best.clearance+0.25)) {
            _best=_sample;_chosen=_i
        }
    }
    if(_chosen<0) return _answer;
    _answer.override=true;_answer.moving=_moves[_chosen];_answer.direction=_directions[_chosen]
    if(floor(elapsed) mod 15==0) scrNTTESmokeLog("PROTO MOVEMENT DODGE "+json_stringify({rate:rates[pass_index],seed:current_seed,
        phase:phase,elapsed:elapsed,xy:[player.x,player.y],threats:array_length(_scan.threats),
        original:[_moving,_direction,_base.risk,_base.clearance],chosen:[_answer.moving,_answer.direction,_best.risk,_best.clearance],
        samples:_budget.samples,microseconds:get_timer()-_started,complete:true,terrain_legal:true}))
    return _answer;
}
// END NTTE PROTO MOVEMENT DODGE HELPERS
function scrNTTEFullProtoEntryInput(_keycont,_index) {
    var _observer=instance_find(NTTEFullProtoStatueNaturalEntryTest,0)
    if(!instance_exists(_observer) || _observer.restored) return;
    _observer.input_calls++;_observer.last_input_index=_index
    if(!instance_exists(_observer.player) || _observer.player.index!=_index) return;
    _observer.input_matched++
    var _fire=false,_moving=false,_move_direction=0,_aim=0
    with(_observer) if(!instance_exists(GenCont) && !instance_exists(FloorMaker) && phase>=2 && phase<=5) {
        input_active++
        var _target=noone,_destination_x=perch_x,_destination_y=perch_y
        if(phase==2 || phase==4) _target=statue
        if(phase==3) {
            var _nearest=infinity,_targets=scrNTTEFullProtoEntryCombatTargets()
            for(var _i=0;_i<array_length(_targets);++_i) {
                var _enemy=_targets[_i]
                if(!instance_exists(_enemy) || _enemy==reserve || _enemy.hp<=0 || _enemy.raddrop<=0 || _enemy.team==player.team) continue
                var _distance=point_distance(_enemy.x,_enemy.y,statue.x,statue.y)
                if(_distance<148 && _distance<_nearest
                    && !collision_line(_enemy.x,_enemy.y,statue.x,statue.y,Wall,false,false)) {_nearest=_distance;_target=_enemy}
            }
            // BEGIN NTTE PROTO RAVEN LOS LURE INPUT
            if(!instance_exists(_target)) {
                var _lure=scrNTTEFullProtoEntryRavenLureGoal()
                if(_lure.active) {_destination_x=_lure.x;_destination_y=_lure.y}
            }
            // END NTTE PROTO RAVEN LOS LURE INPUT
            // BEGIN NTTE PROTO EMPTY TARGET SELF DEFENSE INPUT
            if(!instance_exists(_target)) _target=scrNTTEFullProtoEntryEmptyTargetDefense()
            // END NTTE PROTO EMPTY TARGET SELF DEFENSE INPUT
        }
        if(phase==5 && instance_exists(portal)) {_destination_x=portal.x;_destination_y=portal.y}
        if(instance_exists(_target)) {
            _aim=point_direction(player.x,player.y,_target.x,_target.y)
            var _live_shot=false
            for(var _i=0;_i<array_length(native_shots);++_i) if(instance_exists(native_shots[_i].shot)) {_live_shot=true;break}
            var _allowed=phase!=2 || _target.hp>=_target.max_hp*0.7
            var _cross_statue=phase==3 && collision_line(player.x,player.y,_target.x,_target.y,statue,false,false)!=noone
            _fire=_allowed && !_live_shot && !_cross_statue && _target.visible && _target.mask_index!=mskNone
                && point_distance(player.x,player.y,_target.x,_target.y)>20
                && !collision_line(player.x,player.y,_target.x,_target.y,Wall,false,false)
                && player.ammo[Ammo.Bullets]>0
        }
        if(point_distance(player.x,player.y,_destination_x,_destination_y)>5) {
            var _direction=scrNTTEFullProtoEntryPathDirection(_destination_x,_destination_y)
            if(!is_undefined(_direction)) {_moving=true;_move_direction=_direction}
        }
        // BEGIN NTTE PROTO MOVEMENT DODGE INPUT
        if(phase>=2 && phase<=4) {
            var _ntte_proto_dodge=scrNTTEProtoDodgeMove(_moving,_move_direction)
            if(_ntte_proto_dodge.override) {_moving=_ntte_proto_dodge.moving;_move_direction=_ntte_proto_dodge.direction;}
        }
        // END NTTE PROTO MOVEMENT DODGE INPUT
        if(_fire) fire_samples++
        if(_moving) move_samples++
    }
    _keycont.dir_fire[_index]=_aim;_keycont.dir_move[_index]=_move_direction
    _keycont.press_fire[_index]=_fire && !_observer.bot_was_fire
    _keycont.hold_fire[_index]=_fire;_keycont.release_fire[_index]=!_fire && _observer.bot_was_fire
    _observer.bot_was_fire=_fire
    _keycont.press_swap[_index]=false;_keycont.hold_swap[_index]=false
    _keycont.hold_pick[_index]=false;_keycont.press_pick[_index]=false
    _keycont.hold_spec[_index]=false;_keycont.press_spec[_index]=false
    _keycont.aimassist[_index]=false;_keycont.precisemovement[_index]=true;_keycont.moving[_index]=_moving?1:0
    _keycont.hold_east[_index]=false;_keycont.hold_west[_index]=false
    _keycont.hold_nort[_index]=false;_keycont.hold_sout[_index]=false
}
function scrNTTEFullProtoEntryStepBody() {
    elapsed+=timescale;diagnostic_clock-=timescale
    if(phase>0 && diagnostic_clock<=0) {diagnostic_clock=150;scrNTTEFullProtoEntryDiagnostic("periodic")}
    assert(elapsed<=3600,"Proto entry strict phase timeout "+string(phase))
    if(phase>0) scrNTTEFullProtoEntryRate("normal observer frame")
    if(phase==0) {
        for(var _i=0;_i<array_length(smoke_drivers);++_i) {
            instance_activate_object(smoke_drivers[_i])
            if(instance_exists(smoke_drivers[_i])) instance_destroy(smoke_drivers[_i],false)
        }
        smoke_drivers=[];scrNTTEFullProtoEntryClear()
        save_set_value("options","autopause",false);save_set_value("options","framerate",rates[pass_index])
        save_set_value("options","keyboard",true);save_set_value("options","gamepad",false)
        UberCont.opt_framerate=rates[pass_index];game_set_speed(rates[pass_index],gamespeed_fps)
        UberCont.opt_autopause=false;UberCont.paused=false;UberCont.want_pause=false;UberCont.opt_freeze=0
        UberCont.opt_keyboard=true;UberCont.opt_gamepad=false;UberCont.block_input_frames=0;UberCont.block_input_fire=false
        UberCont.opt_bossintro=false;UberCont.daily_run=false;UberCont.weekly_run=false;UberCont.coop=false;UberCont.hardmode=false
        UberCont.want_quit_to_menu=false;UberCont.show_leaderboards_menu=false
        global.is_server=true;global.index=0;global.__debug_infammo=false;global.crownpick=crwn_none
        scrGameCustomModeReset();scr_playerinstances_reset_all();my_player.race=Race.Fish;my_player.skin=0
        global.ntte_full_feature_ready={}
        save_set_value("game","tutorial",false)
        game_directory=scratch_root+string(rates[pass_index])+"/";directory_create(game_directory)
        var _files=["ntte-full-progress.json","ntte-full-progress.json.bak","ntte-full-progress.json.tmp","NuclearThrone.sav"]
        for(var _i=0;_i<array_length(_files);++_i) array_push(scratch_files,game_directory+_files[_i])
        candidate_index=0
        if(pass_index==1) {
            candidate_index=array_get_index(candidate_seeds,selected_seed_30)
            assert(candidate_index>=0,"Proto60 lost actual30 accepted source seed")
        }
        scrNTTEFullProtoEntryCandidate();return;
    }
    assert(instance_exists(player) && player.hp>0,"Proto bot genuinely died; no fixture health/invulnerability rescue")
    assert(!instance_exists(LevCont),"Proto chapter encountered genuine level/crown choice; no XP suppression or direct dismissal")
    if(phase>=2 && phase<=5 && elapsed>60) {
        assert(input_matched>phase_input_start,"Proto native input seam absent or index mismatch; inspect input diagnostic")
        assert(path_fail_streak<3,"Proto sampled bot cannot plan actual Player-to-goal path; inspect path diagnostic")
    }
    if(phase==1) {
        if(!scrNTTEFullProtoEntryWorldReady()) return;
        assert(GameCont.area==area_scrapyards && GameCont.subarea==2 && !GameCont.proto
            && gen_creates==1 && gen_destroys==1 && room_ends==0 && instance_number(Floor)>20,
            "Controlled Scrap2 lacked real async generation lifecycle/eight Draws")
        if(!scrNTTEFullProtoEntryProfile()) {
            scrNTTEFullProtoEntryDiagnostic("profile rejected: "+profile_reject)
            assert(pass_index==0,"Same-seed60 source profile differs from actual30")
            assert(++candidate_index<array_length(candidate_seeds),"No declared native seed satisfies strict source radiation/perch geometry")
            scrNTTEFullProtoEntryCandidate();return;
        }
        if(pass_index==0) selected_seed_30=current_seed
        bot_goal_x=perch_x;bot_goal_y=perch_y;bot_path_clock=0
        scrNTTEFullProtoEntryAwait(2);return;
    }
    if(phase>=2 && phase<=4) {
        assert(room_ends==0 && !GameCont.proto && !scrNTTEFullUnlockGet("quest:part:0")
            && !scrNTTEFullUnlockGet("race:beetle"),"Proto entry silently advanced/granted Ancient/Beetle")
        if(instance_exists(statue)) {
            assert(statue.rad==received_rads,"Statue radiation changed without recorded native generated-enemy drop collision")
            if(statue.charged) charged_seen=true
        }
    }
    if(phase==2) {
        assert(instance_exists(statue) && statue.hp>0,"Bot killed uncharged statue")
        if(statue.hp<statue.max_hp*0.7) {
            assert(statue_hits>=13 && shot_count>=statue_hits && statue.rad==received_rads,
                "Statue damage threshold lacks original3damage actual shots")
            scrNTTEFullProtoEntryAwait(3)
        }
        return;
    }
    if(phase==3) {
        assert(instance_exists(statue) && statue.hp>0 && !instance_exists(Portal),"Statue feed lost live statue or allowed ordinary Portal to steal rads")
        if(statue.charged) {
            assert(received_rads>24 && charged_seen && statue_hits>=13 && enemy_hits>0,
                "Statue charged without real generated-enemy rads/native combat")
            scrNTTEFullProtoEntryDiagnostic("genuine charged transition")
            scrNTTEFullProtoEntryAwait(4)
        }
        return;
    }
    if(phase==4) {
        if(instance_exists(statue)) return;
        with(Portal) if(type==3 && point_distance(x,y,other.statue_x,other.statue_y)<4) other.portal=id
        assert(instance_exists(portal) && statue_destroy_seen && charged_seen && received_rads>24
            && GameCont.area==area_vault && GameCont.lastarea==area_scrapyards && GameCont.lastsubarea==2,
            "Native charged Statue death did not create original vault Portal/destination")
        assert(ammo_spent==shot_count && fire_samples>0 && move_samples>0,"Native weapon input/ammo provenance incomplete")
        if(portal.sprite_index==sprPortalSpawn) saw_spawn=true
        hop_ends=room_ends;hop_starts=room_starts
        scrNTTEFullProtoEntryRate("actual charged statue Portal before entry")
        scrNTTEFullProtoEntryAwait(5);return;
    }
    if(phase==5) {
        if(instance_exists(portal)) {
            if(portal.sprite_index==sprPortalSpawn) saw_spawn=true
            if(portal.sprite_index==sprProtoPortal) saw_open=true
            if(portal.sprite_index==sprProtoPortalDisappear) saw_disappear=true
        }
        if(room_ends>hop_ends) {
            assert(room_ends==hop_ends+1 && room_starts==hop_starts+1 && native_restart_requested
                && saw_spawn && saw_open && saw_contact && saw_disappear,
                "Proto Portal skipped spawn/open/native input contact/disappear/Alarm1/real engine events")
            scrNTTEFullProtoEntryAwait(6)
        }
        return;
    }
    if(phase==6) {
        if(!scrNTTEFullProtoEntryWorldReady()) return;
        assert(GameCont.area==area_vault && !GameCont.proto && GameCont.crownvisits==1
            && gen_creates==2 && gen_destroys==2 && instance_number(Floor)>20
            && !instance_exists(statue) && !instance_exists(portal) && instance_number(CrownPed)==1
            && instance_number(NTTEFullQuestFloorCont)==4 && !scrNTTEFullUnlockGet("quest:part:0")
            && !scrNTTEFullUnlockGet("race:beetle"),"Native portal Vault/eightDraw hub branch or explicit no-Ancient boundary failed")
        scrNTTEFullProtoEntryRate("actual native Vault eight Draws")
        scrNTTESmokeLog("PASS PROTO STATUE NATURAL ENTRY controlled Scrap2/proto=false/seed="+string(current_seed)
            +"/test-only bot health floor+legal initial Minigun/max starting bullets/real GenCont/native sampled movement+fire/original3damage+ammo+reload/"
            +"generated-enemy deaths+Rad1/BigRad10 source provenance/actual stopped Rad collisions/>24charge/native lethal statue/"
            +"real type3 Portal spawn+open+contact+disappear+Alarm1/engine RoomEnd+RoomStart/native Vault+hub/eightDraw @"
            +string(rates[pass_index])+"; controlled destination, Ancient0 acquisition/ordinary campaign/hub deposit/revisit not covered")
        if(++pass_index<array_length(rates)) {scrNTTEFullProtoEntryAwait(0);return}
        scrNTTEFullProtoEntryRestore()
        scrNTTESmokeLog("PASS full internal selected implemented branches x 30/60; not complete MOD coverage")
        game_end()
    }
}
function scrNTTEFullProtoEntryStep() {
    try {scrNTTEFullProtoEntryStepBody()}
    catch(_error) {
        scrNTTEFullProtoEntryDiagnostic("before strict failure: "+_error.message)
        scrNTTEFullProtoEntryRestore();throw _error
    }
}

// BEGIN NTTE PROTO TOPRAVEN SUCCESSION HELPERS
function scrNTTEFullProtoEntryTopRavenSuccessor(_native) {
    var _observer=instance_find(NTTEFullProtoStatueNaturalEntryTest,0)
    if(!instance_exists(_observer) || _observer.restored || _observer.phase<1 || _observer.phase>4) return;
    // This callback is inside the actual TopRaven constructor, after copying
    // the source state. Only an initial source ID can acquire a successor.
    if(array_get_index(_observer.generated_enemies,id)<0) return;
    assert(object_index==NTTEFullTopRaven && hp>0 && instance_exists(_native) && _native!=id
        && _native.object_index==Raven && _native.hp==hp && _native.max_hp==max_hp
        && _native.x==x && _native.y==y && _native.raddrop==raddrop,
        "Proto TopRaven succession lacks actual live source/native state-copy constructor provenance")
    for(var _i=0;_i<array_length(_observer.topraven_successors);++_i) {
        var _old=_observer.topraven_successors[_i]
        assert(_old.source!=id && _old.successor!=_native,"Proto TopRaven succession reused a source or successor")
    }
    var _link={source:id,successor:_native,source_object:object_index,successor_object:_native.object_index,
        seed:_observer.current_seed,pass_index:_observer.pass_index}
    array_push(_observer.topraven_successors,_link)
    scrNTTESmokeLog("PROTO ENTRY INITIAL TOPRAVEN SUCCESSOR "+json_stringify({source:_link.source,
        successor:_link.successor,source_type:object_get_name(object_index),successor_type:object_get_name(_native.object_index),
        source_in_initial:true,successor_in_initial:array_get_index(_observer.generated_enemies,_native)>=0,
        hp:hp,raddrop:raddrop,xy:[x,y],rate:_observer.rates[_observer.pass_index],
        seed:_observer.current_seed,phase:_observer.phase,elapsed:_observer.elapsed,frame:current_frame}))
}
function scrNTTEFullProtoEntryTopRavenGenerated(_observer,_actor,_object) {
    if(_object!=Raven) return false;
    for(var _i=0;_i<array_length(_observer.topraven_successors);++_i) {
        var _link=_observer.topraven_successors[_i]
        if(_link.successor==_actor && _link.source_object==NTTEFullTopRaven && _link.successor_object==Raven
            && _link.seed==_observer.current_seed && _link.pass_index==_observer.pass_index
            && array_get_index(_observer.generated_enemies,_link.source)>=0) return true;
    }
    return false;
}
// END NTTE PROTO TOPRAVEN SUCCESSION HELPERS

// BEGIN NTTE PROTO SUCCESSOR COMBAT TARGETS HELPERS
function scrNTTEFullProtoEntryCombatTargets() {
    // Called in the observer's input context. Keep the original initial ID
    // array untouched; this local list adds only its proven live successors.
    var _targets=[]
    for(var _i=0;_i<array_length(generated_enemies);++_i) array_push(_targets,generated_enemies[_i])
    for(var _i=0;_i<array_length(topraven_successors);++_i) {
        var _link=topraven_successors[_i]
        if(_link.source==reserve || !instance_exists(_link.successor)) continue
        if(!scrNTTEFullProtoEntryTopRavenGenerated(id,_link.successor,_link.successor.object_index)) continue
        if(array_get_index(_targets,_link.successor)<0) array_push(_targets,_link.successor)
    }
    return _targets;
}
// END NTTE PROTO SUCCESSOR COMBAT TARGETS HELPERS

// BEGIN NTTE PROTO EMPTY TARGET SELF DEFENSE HELPERS
function scrNTTEFullProtoEntryEmptyTargetDefense() {
    // Input choice only. A zero-drop hostile is never a new radiation source.
    if(phase!=3 || !instance_exists(player) || !instance_exists(statue)) return noone;
    var _chosen=noone,_nearest=96,_count=instance_number(enemy)
    for(var _i=0;_i<_count;++_i) {
        var _actor=instance_find(enemy,_i)
        if(!instance_exists(_actor) || _actor==reserve || _actor==statue || _actor.hp<=0
            || _actor.raddrop!=0 || _actor.team==player.team || !_actor.visible || _actor.mask_index==mskNone) continue
        var _distance=point_distance(player.x,player.y,_actor.x,_actor.y)
        if(_distance<=20 || _distance>=_nearest
            || collision_line(player.x,player.y,_actor.x,_actor.y,Wall,false,false)
            || collision_line(player.x,player.y,_actor.x,_actor.y,statue,false,false)!=noone) continue
        _chosen=_actor;_nearest=_distance
    }
    if(instance_exists(_chosen) && floor(elapsed) mod 30==0)
        scrNTTESmokeLog("PROTO EMPTY TARGET SELF DEFENSE SELECTED "+json_stringify({phase:phase,elapsed:elapsed,
            rate:rates[pass_index],seed:current_seed,target:_chosen,type:object_get_name(_chosen.object_index),
            hp:_chosen.hp,raddrop:_chosen.raddrop,distance:_nearest,only_when_charge_target_empty:true,
            adds_radiation_provenance:false}))
    return _chosen;
}
// END NTTE PROTO EMPTY TARGET SELF DEFENSE HELPERS

// BEGIN NTTE PROTO RAVEN LOS LURE HELPERS
function scrNTTEFullProtoEntryRavenLureGoal() {
    var _out={active:false,x:perch_x,y:perch_y,mode:"none"}
    if(phase!=3 || !instance_exists(player) || !instance_exists(statue)) return _out;
    if(!variable_instance_exists(id,"proto_raven_lure"))
        proto_raven_lure={actor:noone,returning:false,refresh:0,approach:false,gx:0,gy:0,rx:0,ry:0}
    var _state=proto_raven_lure,_targets=scrNTTEFullProtoEntryCombatTargets(),_actor=_state.actor
    if(!instance_exists(_actor) || array_get_index(_targets,_actor)<0 || _actor==reserve
        || _actor.object_index!=Raven || _actor.hp<=0 || _actor.raddrop<=0 || _actor.team==player.team
        || !_actor.visible || _actor.mask_index==mskNone) {
        _actor=noone;var _nearest=infinity
        for(var _i=0;_i<array_length(_targets);++_i) {
            var _candidate=_targets[_i]
            if(!instance_exists(_candidate) || _candidate==reserve || _candidate.object_index!=Raven
                || _candidate.hp<=0 || _candidate.raddrop<=0 || _candidate.team==player.team
                || !_candidate.visible || _candidate.mask_index==mskNone) continue;
            if(array_get_index(generated_enemies,_candidate)<0
                && !scrNTTEFullProtoEntryTopRavenGenerated(id,_candidate,_candidate.object_index)) continue;
            var _distance=point_distance(_candidate.x,_candidate.y,statue.x,statue.y)
            if(_distance<_nearest) {_nearest=_distance;_actor=_candidate}
        }
        _state.actor=_actor;_state.returning=false;_state.refresh=0;_state.approach=false
    }
    if(!instance_exists(_actor)) return _out;
    var _distance=point_distance(player.x,player.y,_actor.x,_actor.y),
        _clear=!collision_line(player.x,player.y,_actor.x,_actor.y,Wall,false,false)
    // Original Raven Alarm1 approaches a clear Player beyond64 pixels and
    // retreats inside64. Acquire LOS, then walk home with an80..112 lead.
    // Losing LOS reacquires a real reachable flank; no Raven AI is invoked.
    if(!_clear || _distance>160) _state.returning=false
    if(_clear && _distance<=112) _state.returning=true
    if(_state.returning && _clear) {
        _out.active=true
        if(_distance>112) {_out.x=player.x;_out.y=player.y;_out.mode="wait_for_native_chase"}
        else {_out.x=perch_x;_out.y=perch_y;_out.mode="lead_to_original_perch"}
    } else {
        _state.refresh-=timescale
        if(_state.refresh<=0 || !_state.approach || point_distance(_actor.x,_actor.y,_state.rx,_state.ry)>32) {
            _state.refresh=30;_state.approach=false;_state.rx=_actor.x;_state.ry=_actor.y
            var _options=[]
            with(Floor) {
                var _x=(bbox_left+bbox_right)/2,_y=(bbox_top+bbox_bottom)/2,
                    _gap=point_distance(_x,_y,_actor.x,_actor.y),_free=false
                if(_gap<80 || _gap>120 || collision_line(_x,_y,_actor.x,_actor.y,Wall,false,false)) continue;
                with(other.player) _free=!place_meeting(_x,_y,Wall) && place_meeting(_x,_y,Floor)
                if(!_free) continue;
                array_push(_options,{x:_x,y:_y,score:point_distance(_x,_y,other.player.x,other.player.y)+abs(_gap-96)*0.25})
            }
            var _grid=scrNTTEFullProtoEntryGrid(),_used=[]
            // At most8 natural Floor-centre choices, with the existing actual
            // native-mask planner proving reachability before native input.
            for(var _try=0;_try<8 && !_state.approach;++_try) {
                var _best=-1,_score=infinity
                for(var _i=0;_i<array_length(_options);++_i)
                    if(array_get_index(_used,_i)<0 && _options[_i].score<_score) {_score=_options[_i].score;_best=_i}
                if(_best<0) break;
                array_push(_used,_best)
                var _point=_options[_best]
                if(scrNTTEFullProtoEntryPlan(_grid,_point.x,_point.y,true)) {
                    _state.gx=_point.x;_state.gy=_point.y;_state.approach=true
                }
            }
            mp_grid_destroy(_grid.id)
            // A profile probe owns only planner state. Ordinary sampled input
            // replans its chosen destination before following any route.
            bot_path_clock=0
        }
        if(_state.approach) {_out.active=true;_out.x=_state.gx;_out.y=_state.gy;_out.mode="acquire_reachable_native_los"}
    }
    if(floor(elapsed) mod 30==0) scrNTTESmokeLog("PROTO RAVEN LOS LURE INPUT "+json_stringify({rate:rates[pass_index],
        seed:current_seed,phase:phase,elapsed:elapsed,target:_actor,type:object_get_name(_actor.object_index),
        actor_xy:[_actor.x,_actor.y],player_xy:[player.x,player.y],statue_xy:[statue.x,statue.y],
        source_initial:array_get_index(generated_enemies,_actor)>=0,
        source_successor:scrNTTEFullProtoEntryTopRavenGenerated(id,_actor,_actor.object_index),
        distance:_distance,wall_clear:_clear,goal:[_out.x,_out.y],mode:_out.mode,active:_out.active,
        no_charge_target:true,actor_to_statue:point_distance(_actor.x,_actor.y,statue.x,statue.y)}))
    return _out;
}
// END NTTE PROTO RAVEN LOS LURE HELPERS

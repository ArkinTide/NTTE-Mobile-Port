// Dedicated desktop process. Controlled initial Pizza1/loop0/Fish/legal AutoCrossbow.
// Unmodified native health; real sampled movement/fire/ammo/projectile Drain death.
// Original Pizza-to-Lair is an in-room expansion with zero engine room boundaries.
function scrNTTEFullPizzaLairDrainClear() {
    var _keep=id
    with(all) if(id!=_keep && object_index!=UberCont && object_index!=Console) instance_destroy(id,false)
}
function scrNTTEFullPizzaLairDrainRestore() {
    if(restored) return;
    restored=true;want_fire=false;want_move=false
    if(path_exists(bot_path)) path_delete(bot_path)
    var _unchanged=ds_map_write(old_save_map)==old_savedata
    // Dedicated-process teardown only, after the measured assertions (or a
    // failure). Dispose private actors while private progress/map still own
    // their cleanup; do not let game_end advance a fixture GameCont afterward.
    scrNTTEFullPizzaLairDrainClear()
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
    assert(_unchanged,"Pizza/Lair fixture changed original physical options/save map")
    assert(ds_map_write(old_save_map)==old_savedata,"Private cleanup altered original options/save map")
    // UberCont.RoomEnd writes fullscreen/tot_time before testing dont_save.
    // The process is now terminating; stop that extra native autosave only
    // after restoring the original pointer and checking the original bytes.
    instance_deactivate_object(UberCont)
}
function scrNTTEFullPizzaLairDrainNaturalTests() {
    assert(os_type==os_windows && scrNTTEFullSmokeEnabled(),"Pizza/Lair natural entry requires dedicated Windows full smoke")
    var _object=asset_get_index("NTTEFullPizzaLairDrainNaturalTest")
    assert(object_exists(_object) && !instance_exists(_object),"Pizza/Lair observer missing/duplicated")
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
        scratch_root=working_directory+"pizza-lair-drain-"+string(get_timer())+"/";directory_create(scratch_root)
        rates=[30,60];pass_index=0;phase=0;elapsed=0;draw_frames=0;world_ready_draw=-1;next_diagnostic=120
        current_seed=6123;room_ends=0;room_starts=0;bot_path=path_add()
        drain=noone;player=noone;tv=noone;bot_was_fire=false;bot_path_clock=0;bot_path_cursor=0
        smoke_drivers=scrNTTEFullInstances(NTTESmokeTest)
        with(NTTESmokeTest) instance_deactivate_object(id)
        global.ntte_smoke_active=false
        scrNTTEFullPizzaLairDrainClear()
    }
}
function scrNTTEFullPizzaLairDrainAwait(_phase) {phase=_phase;elapsed=0;world_ready_draw=-1;next_diagnostic=120}
function scrNTTEFullPizzaLairDrainWorldReady() {
    if(instance_exists(GenCont) || instance_exists(FloorMaker)) {world_ready_draw=-1;return false;}
    if(world_ready_draw<0) {world_ready_draw=draw_frames;return false;}
    return draw_frames-world_ready_draw>=8
}
function scrNTTEFullPizzaLairDrainRate(_where) {
    assert(game_get_speed(gamespeed_fps)==rates[pass_index] && timescale==30/rates[pass_index]
        && UberCont.opt_framerate==rates[pass_index] && !UberCont.opt_autopause
        && UberCont.saveData==fixture_save_map && ds_map_write(old_save_map)==old_savedata
        && save_get_value("options","framerate",-1)==rates[pass_index]
        && !save_get_value("options","autopause",true),"Native rate/options isolation failed at "+_where)
}
function scrNTTEFullPizzaLairDrainFireBefore(_weapon) {
    var _observer=instance_find(NTTEFullPizzaLairDrainNaturalTest,0)
    if(!instance_exists(_observer) || _observer.phase!=2 || id!=_observer.player) return undefined;
    assert(_weapon==wep_auto_crossbow && infammo==0 && !global.__debug_infammo,
        "Drain fixture changed legal initial weapon or bypassed native ammo")
    return {before:scrNTTEFullInstances(Bolt),ammo:ammo[Ammo.Bolts]}
}
function scrNTTEFullPizzaLairDrainFireAfter(_sample) {
    if(!is_struct(_sample)) return;
    var _observer=instance_find(NTTEFullPizzaLairDrainNaturalTest,0)
    if(!instance_exists(_observer) || _observer.phase!=2 || id!=_observer.player) return;
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
function scrNTTEFullPizzaLairDrainBulletBefore(_target) {
    var _observer=instance_find(NTTEFullPizzaLairDrainNaturalTest,0)
    if(!instance_exists(_observer) || _observer.restored || _observer.phase!=2
        || creator!=_observer.player || _target!=_observer.drain || !instance_exists(_target)) return undefined;
    var _record=undefined
    for(var _i=0;_i<array_length(_observer.native_shots);++_i)
        if(_observer.native_shots[_i].shot==id) {_record=_observer.native_shots[_i];break}
    assert(is_struct(_record) && object_index==Bolt && damage==20 && damage==_record.damage
        && point_distance(x,y,_record.x,_record.y)>1,
        "Drain contact lacks native moving Bolt firing/damage/travel provenance")
    return {target:_target,hp:_target.hp}
}
function scrNTTEFullPizzaLairDrainBulletAfter(_sample) {
    if(!is_struct(_sample)) return;
    var _observer=instance_find(NTTEFullPizzaLairDrainNaturalTest,0)
    if(!instance_exists(_observer) || _observer.restored || _observer.phase!=2) return;
    var _loss=instance_exists(_sample.target)?_sample.hp-_sample.target.hp:_sample.hp
    assert(_loss==0 || _loss==20,"Original Drain Bolt20 collision changed native damage")
    if(_loss>0) {_observer.native_hits++;_observer.native_damage+=_loss}
}
function scrNTTEFullPizzaLairDrainPlayerState(_player) {
    return json_stringify({x:_player.x,y:_player.y,xp:_player.xprevious,yp:_player.yprevious,
        hp:_player.hp,max_hp:_player.max_hp,ammo:_player.ammo,wep:_player.wep,bwep:_player.bwep,
        speed:_player.speed,can_walk:_player.can_walk,can_aim:_player.can_aim})
}
function scrNTTEFullPizzaLairDrainTVScreen(_tv) {
    if(!instance_exists(_tv) || !sprite_exists(_tv.myscreen)) return false;
    // Native TV.Alarm0 changes the frame within its original channel. Keep
    // the channel identity while allowing that scheduled source animation.
    switch(_tv.tv) {
        case 1:return array_get_index([sprTV1A,sprTV1B,sprTV1C],_tv.myscreen)>=0;
        case 2:return array_get_index([sprTV2A,sprTV2B,sprTV2C],_tv.myscreen)>=0;
        case 3:return array_get_index([sprTV3A,sprTV3B,sprTV3C],_tv.myscreen)>=0;
        case 4:return array_get_index([sprTV4A,sprTV4B,sprTV4C],_tv.myscreen)>=0;
        case 5:return _tv.myscreen==sprTV5A;
    }
    return false;
}
function scrNTTEFullPizzaLairDrainBotAfterSample(_keycont,_index) {
    var _observer=instance_find(NTTEFullPizzaLairDrainNaturalTest,0)
    if(!instance_exists(_observer) || _observer.restored || !instance_exists(_observer.player)
        || _observer.player.index!=_index) return;
    var _fire=false,_moving=false,_direction=0
    if(_observer.phase==2 && instance_exists(_observer.drain) && !instance_exists(GenCont)) with(_observer) {
        var _gx=drain.x,_gy=drain.y+64,
            _distance=point_distance(player.x,player.y,_gx,_gy),
            _clear=!collision_line(player.x,player.y,_gx,_gy,Wall,false,false)
        _direction=point_direction(player.x,player.y,_gx,_gy);_moving=_distance>5
        // The original drain overlaps its support wall and explicitly forwards
        // real wall-bound projectiles to hitme. Check the open approach point,
        // then aim the actual inclusive mask centre, leaving forwarding native.
        var _ax=(drain.bbox_left+drain.bbox_right-1)/2,_ay=(drain.bbox_top+drain.bbox_bottom-1)/2
        _keycont.dir_fire[_index]=point_direction(player.x,player.y,_ax,_ay)
        _fire=player.y>drain.y+24 && abs(player.x-drain.x)<=16
            && point_distance(player.x,player.y,drain.x,drain.y)<128
            && !collision_line(player.x,player.y,drain.x,drain.y+16,Wall,false,false)
            && player.ammo[Ammo.Bolts]>0
        bot_path_clock-=timescale
        if(_moving && !_clear) {
            if(bot_path_clock<=0) {
                bot_path_clock=20;bot_path_cursor=1
                var _left=infinity,_top=infinity,_right=-infinity,_bottom=-infinity
                with(Floor) {_left=min(_left,bbox_left);_top=min(_top,bbox_top)
                    _right=max(_right,bbox_right);_bottom=max(_bottom,bbox_bottom)}
                assert(_left<infinity,"Drain bot lost original Pizza terrain")
                _left=floor((_left-64)/8)*8;_top=floor((_top-64)/8)*8
                var _grid=mp_grid_create(_left,_top,ceil((_right+64-_left)/8),ceil((_bottom+64-_top)/8),8,8)
                with(Wall) mp_grid_add_rectangle(_grid,bbox_left-5,bbox_top-3,bbox_right+5,bbox_bottom+3)
                path_clear_points(bot_path)
                mp_grid_path(_grid,bot_path,player.x,player.y,_gx,_gy,false);mp_grid_destroy(_grid)
            }
            if(path_get_number(bot_path)>1) {
                while(bot_path_cursor<path_get_number(bot_path)-1
                    && point_distance(player.x,player.y,path_get_point_x(bot_path,bot_path_cursor),path_get_point_y(bot_path,bot_path_cursor))<6)
                    bot_path_cursor++
                _direction=point_direction(player.x,player.y,path_get_point_x(bot_path,bot_path_cursor),path_get_point_y(bot_path,bot_path_cursor))
            }
            else _moving=false
        }
        if(_fire) bot_fire_samples++
        if(_moving) bot_move_samples++
    }
    _keycont.press_fire[_index]=_fire && !_observer.bot_was_fire
    _keycont.hold_fire[_index]=_fire;_keycont.release_fire[_index]=!_fire && _observer.bot_was_fire
    _observer.bot_was_fire=_fire
    _keycont.press_swap[_index]=false;_keycont.hold_swap[_index]=false
    _keycont.hold_spec[_index]=false;_keycont.press_spec[_index]=false
    _keycont.hold_pick[_index]=false;_keycont.press_pick[_index]=false
    _keycont.aimassist[_index]=false;_keycont.precisemovement[_index]=true
    _keycont.moving[_index]=_moving?1:0;_keycont.dir_move[_index]=_direction
    _keycont.hold_east[_index]=false;_keycont.hold_west[_index]=false
    _keycont.hold_nort[_index]=false;_keycont.hold_sout[_index]=false
}
function scrNTTEFullPizzaLairDrainDiagnostic(_where) {
    scrNTTESmokeLog("PIZZA LAIR DRAIN "+_where+" "+json_stringify({rate:rates[pass_index],phase:phase,
        elapsed:elapsed,frame:current_frame,shots:shot_count,hits:native_hits,damage:native_damage,
        ammo_spent:ammo_spent,fire_samples:bot_fire_samples,move_samples:bot_move_samples,
        player_xy:instance_exists(player)?[player.x,player.y]:[],player_hp:instance_exists(player)?player.hp:-1,
        ammo:instance_exists(player)?player.ammo:[],drain_live:instance_exists(drain),
        drain_xy:instance_exists(drain)?[drain.x,drain.y]:[],drain_hp:instance_exists(drain)?drain.hp:-1,
        floors:instance_number(Floor),walls:instance_number(Wall),enemies:instance_number(enemy),
        path_points:path_get_number(bot_path),gen_lair:create_lair,dead_lair:destroy_lair,
        drain_destroy:drain_destroy_seen,expanded:expanded,room_ends:room_ends,room_starts:room_starts}))
}
function scrNTTEFullPizzaLairDrainProbe(_kind) {
    var _observer=instance_find(NTTEFullPizzaLairDrainNaturalTest,0)
    if(!instance_exists(_observer) || _observer.restored) return;
    if(_kind=="GenCont.Create.after") {
        if(_observer.phase==1 && GameCont.area==scrNTTEFullAreaId("pizza")) {
            assert(!ntte_full_sync_generation,"Initial Pizza bypassed native async generation")
            _observer.create_pizza++
        }
        if(_observer.phase==2 && GameCont.area==scrNTTEFullAreaId("lair")) {
            assert(_observer.drain_destroy_seen && ntte_full_sync_generation,
                "Lair generation lacks original Drain Destroy and production synchronous in-room bridge")
            _observer.lair_generation=id;_observer.create_lair++
        }
    }
    if(_kind=="GenCont.Destroy.after") {
        if(_observer.phase==1 && GameCont.area==scrNTTEFullAreaId("pizza")) _observer.destroy_pizza++
        if(_observer.phase==2 && GameCont.area==scrNTTEFullAreaId("lair")) {
            assert(_observer.drain_destroy_seen && _observer.create_lair==1,
                "Lair native finalization ran without genuine Drain and GenCont")
            _observer.destroy_lair++
        }
    }
    if(_kind=="Drain.Destroy.before" && id==_observer.drain) {
        assert(_observer.phase==2 && hp<=0 && max_hp==40 && type=="area"
            && area==scrNTTEFullAreaId("lair") && subarea==1 && ntte_full_hallway_size==320
            && spr_idle==scrNTTERefSprite("PizzaDrainIdle") && size==3 && team==team_none,
            "Real Drain death lost original40HP Pizza area-drain properties")
        assert(_observer.native_hits>=2 && _observer.native_damage==40 && _observer.shot_count>=2
            && _observer.ammo_spent==_observer.shot_count && _observer.bot_fire_samples>0
            && _observer.bot_move_samples>0 && !place_meeting(x,y,Explosion)
            && instance_number(FloorExplo)==array_length(_observer.rim_floor_ids)
            && !scrNTTEFullUnlockGet("crown:crime"),
            "Drain death lacks actual ordinary projectile damage/input/ammo or used source blast shortcut")
        for(var _i=0;_i<array_length(_observer.rim_floor_ids);++_i)
            assert(instance_exists(_observer.rim_floor_ids[_i]),"Ordinary Drain shots changed the existing native rim terrain")
        _observer.drain_destroy_seen=true
        _observer.death_player_state=scrNTTEFullPizzaLairDrainPlayerState(_observer.player)
    }
    // Destroy tails can run after their native instance no longer exists.
    // Read only observer and surviving world here, never dead Drain fields.
    if(_kind=="Drain.Destroy.after" && _observer.drain_destroy_seen && !_observer.expanded) with(_observer) {
        assert(create_lair==1 && destroy_lair==1 && GameCont.area==scrNTTEFullAreaId("lair")
            && GameCont.ntte_full_active_lair && !instance_exists(GenCont) && !instance_exists(FloorMaker)
            && instance_number(NTTEFullLairBorder)==1 && instance_number(NTTEFullCatHoleBig)==1
            && array_length(GameCont.ntte_full_lair_rooms)>=6 && instance_number(Floor)>old_floor_count,
            "Native Drain Destroy omitted completed source hallway/Lair real GenCont/layout/population")
        assert(GameCont.id==old_game && player.id==old_player
            && scrNTTEFullPizzaLairDrainPlayerState(player)==death_player_state,
            "Production in-room generation failed same Player/GameCont state restoration")
        assert(scrNTTEFullUnlockGet("crown:crime") && !scrNTTEFullUnlockGet("pack:lair")
            && !variable_instance_exists(GameCont,"ntte_lairmut") && GameCont.skillpoints==source_points,
            "Source Drain completion omitted Crime or prematurely granted Boss release reward")
        expanded=true;expansion_draw=draw_frames
    }
}
function scrNTTEFullPizzaLairDrainBootstrap() {
    scrNTTEFullPizzaLairDrainClear()
    current_frame=0;global.alarm_topup_acc=0
    global.custom_seed=current_seed;global.recontinued_times=0;global.__debug_infammo=false
    global.ntte_full_progress={schema:1,unlocks:{},loadouts:{},stats:{}}
    global.ntte_full_feature_ready={}
    if(file_exists(savegame_file)) file_delete(savegame_file)
    instance_create(0,0,GameCont);instance_create(0,0,BackCont);instance_create(0,0,MusCont);scrCreatePlayers(0)
    assert(global.seed==current_seed,"Native GameCont replaced controlled initial Pizza seed")
    player=instance_find(Player,0)
    assert(instance_number(Player)==1 && player.race==Race.Fish && player.bskin==0,"Initial solo FishA failed")
    player.wep=wep_auto_crossbow;player.bwep=wep_none;player.infammo=0
    player.ammo[Ammo.Bolts]=typ_amax[Ammo.Bolts]
    GameCont.area=scrNTTEFullAreaId("pizza");GameCont.subarea=1;GameCont.loops=0;GameCont.hard=5
    GameCont.maxsubarea=scrAreaGetMaxSubarea(GameCont.area);GameCont.finalsubarea=true
    GameCont.can_advance_stage=true;GameCont.gocrib=false;GameCont.crown=crwn_none
    GameCont.ntte_full_pending_destination=undefined
    GameCont.ntte_full_source_seed=scrNTTEFullSourceSeedBuild(current_seed)
    GameCont.ntte_full_source_pending_generation=undefined
    global.ntte_full_sync_generation=false;scrRngStatesReset()
    drain=noone;tv=noone;create_pizza=0;destroy_pizza=0;create_lair=0;destroy_lair=0
    lair_generation=noone;expanded=false;expansion_draw=-1;drain_destroy_seen=false;death_player_state=""
    room_ends=0;room_starts=0;native_shots=[];shot_count=0;ammo_spent=0;native_hits=0;native_damage=0
    bot_was_fire=false;bot_fire_samples=0;bot_move_samples=0;bot_path_clock=0;bot_path_cursor=0
    path_clear_points(bot_path)
    scrNTTEFullFloorResetStyle();scrNTTEFullFloorResetAlign()
    scrNTTEFullPizzaLairDrainAwait(1)
    var _gen=instance_create(0,0,GenCont)
    assert(!_gen.ntte_full_sync_generation,"Initial Pizza bypassed asynchronous generation")
    scrNTTESmokeLog("PIZZA LAIR DRAIN controlled initial solo FishA/Pizza1/loop0/hard5/legal AutoCrossbow+none/max55Bolts, native health/XP unchanged, native custom seed+allstream reset="+string(current_seed)+" @"+string(rates[pass_index]))
}
function scrNTTEFullPizzaLairDrainStepBody() {
    elapsed+=timescale
    if(elapsed>next_diagnostic && phase>=2) {
        scrNTTEFullPizzaLairDrainDiagnostic("native wait");next_diagnostic+=120
    }
    assert(elapsed<=5400,"Pizza/Lair real Drain route timed out phase="+string(phase))
    if(phase>0) scrNTTEFullPizzaLairDrainRate("phase "+string(phase))
    if(phase==0) {
        for(var _i=0;_i<array_length(smoke_drivers);++_i) {
            instance_activate_object(smoke_drivers[_i])
            if(instance_exists(smoke_drivers[_i])) instance_destroy(smoke_drivers[_i],false)
        }
        smoke_drivers=[];scrNTTEFullPizzaLairDrainClear()
        save_set_value("options","framerate",rates[pass_index]);save_set_value("options","autopause",false)
        save_set_value("options","keyboard",true);save_set_value("options","gamepad",false)
        save_set_value("visual","bossintro",false);save_set_value("visual","freezeframes",false)
        save_set_value("game","tutorial",false)
        UberCont.opt_framerate=rates[pass_index];UberCont.opt_autopause=false;UberCont.opt_keyboard=true
        UberCont.opt_gamepad=false;UberCont.opt_bossintro=false;UberCont.opt_freeze=0
        UberCont.paused=false;UberCont.want_pause=false;UberCont.block_input_frames=0;UberCont.block_input_fire=false
        game_set_speed(rates[pass_index],gamespeed_fps)
        scrNTTEFullPizzaLairDrainAwait(19);return;
    }
    if(phase==19) {
        UberCont.daily_run=false;UberCont.weekly_run=false;UberCont.coop=false;UberCont.hardmode=false
        UberCont.continued_run=false;UberCont.want_quit_to_menu=false;UberCont.show_leaderboards_menu=false
        global.is_server=true;global.index=0;global.crownpick=crwn_none
        scrGameCustomModeReset();scr_playerinstances_reset_all();my_player.race=Race.Fish;my_player.skin=0
        game_directory=scratch_root+string(rates[pass_index])+"/";directory_create(game_directory)
        var _files=["ntte-full-progress.json","ntte-full-progress.json.bak","ntte-full-progress.json.tmp","NuclearThrone.sav"]
        for(var _i=0;_i<array_length(_files);++_i) array_push(scratch_files,game_directory+_files[_i])
        scrNTTEFullPizzaLairDrainBootstrap();return;
    }
    if(phase>=1 && phase<=3) assert(instance_exists(player) && player.hp>0,"Unmodified native-health Fish died during scoped Drain entry")
    if(phase==1) {
        if(!scrNTTEFullPizzaLairDrainWorldReady()) return;
        with(NTTEFullSewerDrain) if(type=="area" && area==scrNTTEFullAreaId("lair")) other.drain=id
        tv=instance_find(NTTEFullPizzaTV,0)
        assert(create_pizza==1 && destroy_pizza==1 && instance_number(NTTEFullSewerDrain)==1
            && instance_exists(drain) && drain.hp==40 && drain.max_hp==40 && drain.ntte_full_hallway_size==320
            && drain.subarea==1 && drain.ntte_full_loops==0 && drain.team==team_none && drain.size==3,
            "Actual Pizza generation+8Draw lacks original natural40HP/320hall Lair Drain")
        assert(GameCont.ntte_full_active_pizza && instance_number(Floor)>20 && instance_number(TopCont)==1
            && instance_number(NTTEFullPizzaTV)==1 && tv.visible && tv.sprite_index==sprTV
            && tv.spr_idle==sprTV && scrNTTEFullPizzaLairDrainTVScreen(tv) && !instance_exists(NTTEFullCatBoss)
            && !instance_exists(NTTEFullBatBoss) && !instance_exists(NTTEFullCatHoleBig)
            && !scrNTTEFullUnlockGet("crown:crime") && !scrNTTEFullUnlockGet("pack:lair")
            // Original SewerDrain_step explicitly uses floor_set(...,2)
            // for its rim. FloorExplo is terrain, not a live Explosion.
            && instance_number(FloorExplo)>0 && !instance_exists(Explosion),
            "Actual Pizza native population/art/locked rewards/no-blast initial state failed")
        rim_floor_ids=scrNTTEFullInstances(FloorExplo)
        old_game=GameCont.id;old_player=player.id;old_hard=GameCont.hard;old_waypoints=GameCont.waypoints
        old_visits=scrNTTEFullValue(GameCont,"ntte_visits_pizza",0);old_floor_count=instance_number(Floor)
        source_points=GameCont.skillpoints;stable_floor=collision_point(10016,10016,Floor,false,false)
        assert(instance_exists(stable_floor),"Original native spawn has no stable Pizza floor")
        old_controllers=scrNTTEFullInstances([BackCont,TopCont,SubTopCont]);tv_channel=tv.tv
        scrNTTEFullPizzaLairDrainAwait(2);return;
    }
    if(phase==2) {
        if(!expanded) return;
        assert(!instance_exists(drain),"Original lethal native Drain Destroy left its target alive")
        scrNTTEFullPizzaLairDrainDiagnostic("native Drain20+20 death and complete in-room Lair")
        scrNTTEFullPizzaLairDrainAwait(3);return;
    }
    if(phase==3) {
        if(draw_frames-expansion_draw<8) return;
        assert(GameCont.area==scrNTTEFullAreaId("lair") && GameCont.subarea==1 && GameCont.loops==0
            && GameCont.id==old_game && player.id==old_player && instance_exists(stable_floor)
            && GameCont.ntte_full_active_lair && instance_number(BackCont)==1 && instance_number(TopCont)==1,
            "Lair+8realDraw lost source destination/persistent actors/original Pizza terrain/renderers")
        for(var _i=0;_i<array_length(old_controllers);++_i)
            assert(!instance_exists(old_controllers[_i]),"Production set-area in-room generation retained old renderer")
        assert(room_ends==0 && room_starts==0 && GameCont.hard==old_hard && GameCont.waypoints==old_waypoints
            && scrNTTEFullValue(GameCont,"ntte_visits_pizza",0)==old_visits
            && is_undefined(GameCont.ntte_full_pending_destination),
            "Original in-room Drain route incorrectly used room boundary/finish/bookkeeping/queued Portal")
        assert(instance_exists(tv) && tv.visible && tv.sprite_index==sprTV && tv.spr_idle==sprTV
            && tv.tv==tv_channel && scrNTTEFullPizzaLairDrainTVScreen(tv)
            && instance_number(NTTEFullCatHoleBig)==1 && !NTTEFullCatHoleBig.ntte_full_released
            && NTTEFullCatHoleBig.ntte_full_phase==0 && instance_number(NTTEFullLairBorder)==1
            && !instance_exists(NTTEFullCatBoss) && !instance_exists(NTTEFullBatBoss)
            && !variable_instance_exists(GameCont,"ntte_lairmut") && GameCont.skillpoints==source_points
            && !scrNTTEFullUnlockGet("pack:lair") && scrNTTEFullUnlockGet("crown:crime"),
            "Lair+8Draw lost original TV/unreleased manhole/border or prematurely granted boss reward")
        var _progress_path=game_directory+"ntte-full-progress.json"
        assert(file_exists(_progress_path),"Native Crime unlock did not persist private progress")
        var _file=file_text_open_read(_progress_path),_text=""
        while(!file_text_eof(_file)) {_text+=file_text_read_string(_file);file_text_readln(_file)}
        file_text_close(_file)
        var _progress=json_parse(_text)
        assert(variable_struct_get(_progress.unlocks,"crown:crime")
            && !scrNTTEFullValue(_progress.unlocks,"pack:lair",false),"Persisted native Crime differs from memory or grants pack early")
        scrNTTESmokeLog("PASS PIZZA LAIR DRAIN NATURAL: controlled initial FishA/Pizza1/loop0/legal AutoCrossbow55Bolts/native health+XP; actual async Pizza+8Draw, native sampled movement/fire/cost/reload/moving Bolt20+20/original40HP Drain registered death, original production sync in-room hallway/Lair generation+8Draw/same Player+GameCont+state/old Pizza floor+TV retained/renderers replaced, source Crime memory+private JSON, unreleased manhole/no early boss rewards, zero engine RoomEnd+Start; upstream Sewer/full boss/exit/iPhone UNRUN @"+string(rates[pass_index]))
        if(++pass_index<array_length(rates)) {scrNTTEFullPizzaLairDrainAwait(0);return;}
        scrNTTEFullPizzaLairDrainRestore()
        scrNTTESmokeLog("PASS full internal selected implemented branches x 30/60; not complete MOD coverage")
        game_end()
    }
}
function scrNTTEFullPizzaLairDrainStep() {
    try {scrNTTEFullPizzaLairDrainStepBody()}
    catch(_error) {
        try {
        // Read surviving native state before teardown; never manufacture a
        // missing actor, force a reward or alter the failing assertion.
        var _tv=instance_find(NTTEFullPizzaTV,0)
        scrNTTESmokeLog("PIZZA LAIR DRAIN FAILURE STATE "+json_stringify({
            phase:phase,rate:rates[pass_index],active:scrNTTEFullValue(GameCont,"ntte_full_active_pizza"),
            area:GameCont.area,floors:instance_number(Floor),top:instance_number(TopCont),
            back:instance_number(BackCont),tv_count:instance_number(NTTEFullPizzaTV),
            tv:instance_exists(_tv)?{visible:_tv.visible,sprite:_tv.sprite_index,idle:_tv.spr_idle,
                screen:_tv.myscreen,screen_exists:sprite_exists(_tv.myscreen),expected:sprTV}:undefined,
            cats:instance_number(NTTEFullCatBoss),bats:instance_number(NTTEFullBatBoss),
            borders:instance_number(NTTEFullLairBorder),points:GameCont.skillpoints,
            lairmut:variable_instance_exists(GameCont,"ntte_lairmut"),
            holes:instance_number(NTTEFullCatHoleBig),crime:scrNTTEFullUnlockGet("crown:crime"),
            lair:scrNTTEFullUnlockGet("pack:lair"),floor_explo:instance_number(FloorExplo),
            explosions:instance_number(Explosion)}))
        scrNTTEFullPizzaLairDrainDiagnostic("before failure restore")
        } catch(_diagnostic_error) {show_debug_message("Pizza/Lair diagnostic unavailable: "+string(_diagnostic_error))}
        scrNTTEFullPizzaLairDrainRestore();throw _error
    }
}

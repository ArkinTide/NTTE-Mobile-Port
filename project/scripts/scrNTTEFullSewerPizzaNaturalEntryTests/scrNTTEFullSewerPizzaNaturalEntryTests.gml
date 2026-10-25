// Dedicated desktop process. Initial Sewer1/loop0/seed/loadout are controlled;
// the measured entrance, explosion, native Portal and engine transition are real.
function scrNTTEFullSewerPizzaEntryClear() {
    var _keep=id
    with(all) if(id!=_keep && object_index!=UberCont && object_index!=Console) instance_destroy(id,false)
}
function scrNTTEFullSewerPizzaEntryRestore() {
    if(restored) return;
    restored=true;want_fire=false;want_move=false
    var _unchanged=ds_map_write(old_save_map)==old_savedata
    // Dedicated-process teardown only, after the measured assertions (or a
    // failure). Dispose private actors while private progress/map still own
    // their cleanup; do not let game_end advance a fixture GameCont afterward.
    scrNTTEFullSewerPizzaEntryClear()
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
    assert(_unchanged,"Sewer/Pizza fixture changed original physical options/save map")
    assert(ds_map_write(old_save_map)==old_savedata,"Private cleanup altered original options/save map")
    // UberCont.RoomEnd writes fullscreen/tot_time before testing dont_save.
    // The process is now terminating; stop that extra native autosave only
    // after restoring the original pointer and checking the original bytes.
    instance_deactivate_object(UberCont)
}
function scrNTTEFullSewerPizzaNaturalEntryTests() {
    assert(os_type==os_windows && scrNTTEFullSmokeEnabled(),"Sewer/Pizza natural entry requires dedicated Windows full smoke")
    var _object=asset_get_index("NTTEFullSewerPizzaNaturalEntryTest")
    assert(object_exists(_object) && !instance_exists(_object),"Sewer/Pizza observer missing/duplicated")
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
        scratch_root=working_directory+"sewer-pizza-entry-"+string(get_timer())+"/";directory_create(scratch_root)
        rates=[30,60];pass_index=0;phase=0;elapsed=0;draw_frames=0;world_ready_draw=-1
        candidate_seeds=[101013,701932,6123,713251,6124,713252,102775,713253]
        candidate_index=0;selected_seed_30=-1;room_ends=0;room_starts=0
        entrance_records=[];manhole_records=[];hole=noone;portal=noone;player=noone
        smoke_drivers=scrNTTEFullInstances(NTTESmokeTest)
        with(NTTESmokeTest) instance_deactivate_object(id)
        global.ntte_smoke_active=false
        scrNTTEFullSewerPizzaEntryClear()
    }
}
function scrNTTEFullSewerPizzaEntryAwait(_phase) {phase=_phase;elapsed=0;world_ready_draw=-1}
function scrNTTEFullSewerPizzaEntryWorldReady() {
    if(instance_exists(GenCont) || instance_exists(FloorMaker)) {world_ready_draw=-1;return false;}
    if(world_ready_draw<0) {world_ready_draw=draw_frames;return false;}
    return draw_frames-world_ready_draw>=8
}
function scrNTTEFullSewerPizzaEntryRate(_where) {
    assert(game_get_speed(gamespeed_fps)==rates[pass_index] && timescale==30/rates[pass_index]
        && UberCont.opt_framerate==rates[pass_index] && !UberCont.opt_autopause
        && UberCont.saveData==fixture_save_map && ds_map_write(old_save_map)==old_savedata
        && save_get_value("options","framerate",-1)==rates[pass_index]
        && !save_get_value("options","autopause",true),"Native rate/options isolation failed at "+_where)
}
function scrNTTEFullSewerPizzaEntryRngLog(_where) {
    scrNTTESmokeLog("SEWER PIZZA NATIVE RNG "+_where+" "+json_stringify({
        rate:rates[pass_index],candidate:current_seed,seed:global.seed,custom_seed:global.custom_seed,
        native_clock:current_frame,native_alarm_phase:global.alarm_topup_acc,
        random_state:random_get_seed(),native_states:global.rng_state,
        native_levseed:instance_exists(GameCont)?GameCont.levseed:-1,
        native_area:instance_exists(GameCont)?GameCont.area:-1,
        native_subarea:instance_exists(GameCont)?GameCont.subarea:-1}))
}
function scrNTTEFullSewerPizzaEntryGeometryLog(_where) {
    // Diagnostics only: keep the original Profile's order/decisions untouched.
    // Hash sorted physical geometry without runtime instance IDs, and inspect
    // every original launch location with the actual current Player mask.
    var _hole=instance_find(NTTEFullManhole,0),_floors=[],_wall_rows=[],_near_floors=[],_near_walls=[],_launches=[]
    with(Floor) {
        var _row=[x,y,bbox_left,bbox_top,bbox_right,bbox_bottom,sprite_index,image_index,mask_index,image_xscale,image_yscale,image_angle]
        array_push(_floors,json_stringify(_row))
        if(instance_exists(_hole) && point_distance(x,y,_hole.x,_hole.y)<160) array_push(_near_floors,_row)
    }
    var _walls=scrNTTEFullInstances(Wall)
    for(var _i=0;_i<array_length(_walls);++_i) with(_walls[_i]) {
        var _row=[x,y,bbox_left,bbox_top,bbox_right,bbox_bottom,sprite_index,image_index,mask_index,image_xscale,image_yscale,image_angle]
        array_push(_wall_rows,json_stringify(_row))
        if(instance_exists(_hole) && point_distance(x,y,_hole.x,_hole.y)<160) array_push(_near_walls,_row)
    }
    array_sort(_floors,true);array_sort(_wall_rows,true)
    if(instance_exists(_hole) && instance_exists(player)) for(var _i=0;_i<array_length(_walls);++_i) {
        var _wall=_walls[_i],_wx=clamp(_hole.x,_wall.bbox_left,_wall.bbox_right-1),
            _wy=clamp(_hole.y,_wall.bbox_top,_wall.bbox_bottom-1),_distance=point_distance(_hole.x,_hole.y,_wx,_wy)
        if(_distance<8 || _distance>32) continue
        var _dir=point_direction(_hole.x,_hole.y,_wx,_wy)
        for(var _offset=72;_offset>=40;_offset-=16) {
            var _px=_hole.x-lengthdir_x(_offset,_dir),_py=_hole.y-lengthdir_y(_offset,_dir),
                _blocked=false,_floor_present=false,_wall_hit=noone,_floor_hit=noone
            with(player) {
                _blocked=place_meeting(_px,_py,Wall);_floor_present=position_meeting(_px,_py,Floor)
                _wall_hit=instance_place(_px,_py,Wall);_floor_hit=instance_position(_px,_py,Floor)
            }
            array_push(_launches,{wall:[_wall.x,_wall.y,_wall.bbox_left,_wall.bbox_top,_wall.bbox_right,_wall.bbox_bottom],
                impact:[_wx,_wy],offset:_offset,launch:[_px,_py],player_hits_wall:_blocked,
                point_on_floor:_floor_present,hit_wall:instance_exists(_wall_hit)?[_wall_hit.x,_wall_hit.y]:[],
                hit_floor:instance_exists(_floor_hit)?[_floor_hit.x,_floor_hit.y]:[],
                line_blocked:collision_line(_px,_py,_hole.x,_hole.y,Wall,false,false)!=noone})
        }
    }
    var _player=instance_exists(player)?{
        xy:[player.x,player.y],bbox:[player.bbox_left,player.bbox_top,player.bbox_right,player.bbox_bottom],
        sprite:player.sprite_index,image:player.image_index,mask:player.mask_index,
        scale:[player.image_xscale,player.image_yscale],image_angle:player.image_angle,angle:player.angle,
        can_walk:player.can_walk,visible:player.visible,roll:player.roll}:undefined
    scrNTTESmokeLog("SEWER PIZZA GEOMETRY "+_where+" "+json_stringify({rate:rates[pass_index],candidate:current_seed,
        frame:current_frame,draw:draw_frames,logic_scale:timescale,player:_player,
        hole:instance_exists(_hole)?[_hole.x,_hole.y,_hole.sprite_index,_hole.image_index,_hole.mask_index]:[],
        floor_count:array_length(_floors),wall_count:array_length(_wall_rows),
        floor_hash:md5_string_utf8(json_stringify(_floors)),wall_hash:md5_string_utf8(json_stringify(_wall_rows)),
        nearby_floors:_near_floors,nearby_walls:_near_walls,launch_candidates:_launches}))
}
function scrNTTEFullSewerPizzaEntryCandidate() {
    // Initial/per-rate/seed-search setup only, never the measured transition.
    scrNTTEFullSewerPizzaEntryClear()
    current_seed=candidate_seeds[candidate_index]
    scrNTTESmokeLog("SEWER PIZZA CONTROLLED CLOCK before initial candidate reset "+json_stringify({
        rate:rates[pass_index],candidate:current_seed,native_clock:current_frame,native_alarm_phase:global.alarm_topup_acc}))
    // Initial candidate bootstrap only: isolate the real native clock and
    // integer alarm compensation phase. Native actors/RNG/delays remain live.
    current_frame=0;global.alarm_topup_acc=0
    scrNTTESmokeLog("SEWER PIZZA CONTROLLED CLOCK after initial candidate reset "+json_stringify({
        rate:rates[pass_index],candidate:current_seed,native_clock:current_frame,native_alarm_phase:global.alarm_topup_acc}))
    entrance_records=[];manhole_records=[];hole=noone;portal=noone
    room_ends=0;room_starts=0;want_fire=false;want_move=false
    input_fire_pulses=0;input_move_samples=0;rocket_creations=0;explosion_creations=0
    next_fire_clock=0;fire_clock=0;input_was_fire=false
    saw_explosion_contact=false;saw_open_progress=false;manhole_destroy_seen=false
    saw_spawn=false;saw_open=false;saw_contact=false;saw_disappear=false;native_restart_requested=false
    missing_portal_clock=0;saw_native_ammo_spent=false
    scrNTTEFullSewerPizzaEntryRngLog("before custom-seed input/native GameCont.Create")
    global.custom_seed=current_seed;global.recontinued_times=0
    global.ntte_full_progress={schema:1,unlocks:{},loadouts:{},stats:{}}
    if(file_exists(savegame_file)) file_delete(savegame_file)
    instance_create(0,0,GameCont);instance_create(0,0,BackCont);instance_create(0,0,MusCont);scrCreatePlayers(0)
    scrNTTEFullSewerPizzaEntryRngLog("after native GameCont.Create/custom-seed initialization")
    assert(global.seed==current_seed,"Native GameCont custom-seed initialization replaced the declared candidate")
    GameCont.area=area_sewers;GameCont.subarea=1;GameCont.loops=0;GameCont.hard=2
    GameCont.maxsubarea=scrAreaGetMaxSubarea(area_sewers);GameCont.finalsubarea=true
    GameCont.can_advance_stage=true;GameCont.gocrib=false;GameCont.crown=crwn_none
    // This case certifies entrance/transition, not XP/level-choice progression.
    GameCont.rad=-100000;GameCont.skillpoints=0;GameCont.crownpoints=0;GameCont.ultrapoints=0
    GameCont.ntte_full_pending_destination=undefined
    GameCont.ntte_full_source_seed=scrNTTEFullSourceSeedBuild(current_seed)
    GameCont.ntte_full_source_pending_generation=undefined
    global.ntte_full_sync_generation=false
    // Actual local native reset seeds all independent streams for the final
    // regional context. Setting Generation alone leaves Props/Enemies/Chest
    // from GameCont.Create's earlier context, changing entrance occupancy.
    scrRngStatesReset()
    scrNTTEFullSewerPizzaEntryRngLog("after native Sewer1 all-stream reset")
    player=instance_find(Player,0)
    player.wep=wep_bazooka;player.bwep=wep_none;player.ammo[Ammo.Explosives]=55
    player.hp=100000;player.max_hp=100000;player.lsthealth=100000;player.nexthurt=current_frame+100000
    player.can_walk=false;player.can_aim=true;player.can_shoot=true;player.reload=0
    scrNTTEFullFloorResetStyle();scrNTTEFullFloorResetAlign()
    scrNTTEFullSewerPizzaEntryAwait(1)
    var _gen=instance_create(0,0,GenCont)
    assert(!_gen.ntte_full_sync_generation,"Sewer candidate replaced actual asynchronous native generation")
    scrNTTESmokeLog("SEWER PIZZA controlled initial Sewer1/loop0/hard2/Bazooka/protected Player/XP suppressed, actual async seed="+string(current_seed)+" @"+string(rates[pass_index]))
}
function scrNTTEFullSewerPizzaEntryProfile() {
    profile_reject=""
    scrNTTEFullSewerPizzaEntryGeometryLog("before original Profile after eight DrawEnd")
    if(instance_number(NTTEFullManhole)!=1 || instance_exists(PizzaEntrance)) {
        profile_reject="entrance/count: Manhole="+string(instance_number(NTTEFullManhole))
            +" native PizzaEntrance="+string(instance_number(PizzaEntrance))
            +" native constructor records="+string(array_length(entrance_records))
            +" converted records="+string(array_length(manhole_records))
        return false
    }
    hole=instance_find(NTTEFullManhole,0)
    var _matched=false
    for(var _i=0;_i<array_length(entrance_records);++_i) {
        var _record=entrance_records[_i]
        if(point_distance(_record.x,_record.y,hole.x,hole.y)<2) _matched=true
    }
    assert(_matched,"Generated Manhole has no recorded real native PizzaEntrance ancestor")
    assert(hole.area==scrNTTEFullAreaId("pizza") && hole.subarea==0 && !hole.contact
        && hole.visible && hole.image_index==0,"Natural Manhole lost source Pizza0/explosion-only closed metadata")
    var _bosses=0
    with(enemy) if(variable_instance_exists(id,"boss") ? boss:scrEnemyIsBoss(id)) _bosses++
    if(_bosses>0) { profile_reject="boss guard: live source Boss count="+string(_bosses);return false }
    // Reproducible natural geometry prerequisite: actual wall close enough for
    // a real Bazooka impact to cover the hole, plus a clear natural launch lane.
    var _walls=scrNTTEFullInstances(Wall),_ok=false,_near_walls=0,_free_launches=0,_blocked_lines=0
    for(var _i=0;_i<array_length(_walls) && !_ok;++_i) {
        var _wall=_walls[_i],_wx=clamp(hole.x,_wall.bbox_left,_wall.bbox_right-1),
            _wy=clamp(hole.y,_wall.bbox_top,_wall.bbox_bottom-1),_distance=point_distance(hole.x,hole.y,_wx,_wy)
        if(_distance<8 || _distance>32) continue
        _near_walls++
        var _dir=point_direction(hole.x,hole.y,_wx,_wy)
        for(var _offset=72;_offset>=40;_offset-=16) {
            var _px=hole.x-lengthdir_x(_offset,_dir),_py=hole.y-lengthdir_y(_offset,_dir),_free=false
            with(player) _free=!place_meeting(_px,_py,Wall) && position_meeting(_px,_py,Floor)
            if(!_free) continue
            _free_launches++
            if(collision_line(_px,_py,hole.x,hole.y,Wall,false,false)) { _blocked_lines++;continue }
            launch_x=_px;launch_y=_py;impact_x=_wx;impact_y=_wy;impact_wall=_wall.id;_ok=true;break
        }
    }
    if(!_ok) profile_reject="launch geometry: hole=("+string(hole.x)+","+string(hole.y)
        +") total walls="+string(array_length(_walls))+" walls8..32="+string(_near_walls)
        +" free Floor launches="+string(_free_launches)+" wall-blocked lanes="+string(_blocked_lines)
    scrNTTEFullSewerPizzaEntryRngLog("profile evaluated "+(_ok?"eligible":profile_reject))
    return _ok
}
function scrNTTEFullSewerPizzaEntryAfterSample(_keycont,_index) {
    var _observer=instance_find(NTTEFullSewerPizzaNaturalEntryTest,0)
    if(!instance_exists(_observer) || _observer.restored || !instance_exists(_observer.player)
        || _observer.player.index!=_index) return;
    var _fire=false,_move=false,_dir=0
    if(_observer.phase==2 && _observer.want_fire && _observer.fire_clock>=_observer.next_fire_clock) {
        _fire=true;_observer.next_fire_clock=_observer.fire_clock+45;_observer.input_fire_pulses++
    }
    if(_observer.phase==3 && _observer.want_move) {
        _move=point_distance(_observer.player.x,_observer.player.y,_observer.hole_x,_observer.hole_y)>2
        _dir=point_direction(_observer.player.x,_observer.player.y,_observer.hole_x,_observer.hole_y)
        if(_move) _observer.input_move_samples++
    }
    _keycont.press_fire[_index]=_fire;_keycont.hold_fire[_index]=_fire
    _keycont.release_fire[_index]=!_fire && _observer.input_was_fire;_observer.input_was_fire=_fire
    _keycont.hold_spec[_index]=false;_keycont.press_spec[_index]=false
    _keycont.hold_pick[_index]=false;_keycont.press_pick[_index]=false
    _keycont.press_swap[_index]=false;_keycont.hold_swap[_index]=false
    _keycont.aimassist[_index]=false;_keycont.precisemovement[_index]=true
    _keycont.moving[_index]=_move?1:0;_keycont.dir_move[_index]=_dir
    _keycont.hold_east[_index]=false;_keycont.hold_west[_index]=false
    _keycont.hold_nort[_index]=false;_keycont.hold_sout[_index]=false
    if(_observer.phase==2)
        _keycont.dir_fire[_index]=point_direction(_observer.player.x,_observer.player.y,_observer.impact_x,_observer.impact_y)
}
function scrNTTEFullSewerPizzaEntryNestLog(_kind) {
    var _observer=instance_find(NTTEFullSewerPizzaNaturalEntryTest,0)
    if(!instance_exists(_observer) || _observer.restored || _observer.phase!=1) return;
    var _holes=[],_pools=[]
    with(NTTEFullManhole) array_push(_holes,[x,y,sprite_index,image_index])
    with(NTTEFullSludgePool) array_push(_pools,{position:[x,y],sprite:sprite_index,setup:setup,floor_count:array_length(floors)})
    scrNTTESmokeLog("SEWER PIZZA SOURCE NEST "+_kind+" "+json_stringify({rate:_observer.rates[_observer.pass_index],
        candidate:_observer.current_seed,frame:current_frame,queen:[x,y,xstart,ystart,xprevious,yprevious,hspeed,vspeed,speed],
        holes:_holes,pools:_pools,random_state:random_get_seed(),native_states:global.rng_state}))
}
function scrNTTEFullSewerPizzaEntryProbe(_kind) {
    var _observer=instance_find(NTTEFullSewerPizzaNaturalEntryTest,0)
    if(!instance_exists(_observer) || _observer.restored) return;
    if(_kind=="GenCont.Destroy.after" && _observer.phase==1 && GameCont.area==area_sewers)
        with(_observer) scrNTTEFullSewerPizzaEntryGeometryLog("native GenCont.Destroy complete")
    if((_kind=="SludgePool.Step.before" || _kind=="SludgePool.Step.after") && _observer.phase==1 && instance_exists(GenCont)) {
        var _queens=[],_holes=[]
        with(FrogQueen) array_push(_queens,{position:[x,y],spawn:[xstart,ystart],previous:[xprevious,yprevious],
            velocity:[hspeed,vspeed],speed:speed,sprite:sprite_index,mask:mask_index})
        with(NTTEFullManhole) array_push(_holes,[x,y,sprite_index,image_index])
        scrNTTESmokeLog("SEWER PIZZA POOL NATIVE "+_kind+" "+json_stringify({rate:_observer.rates[_observer.pass_index],
            candidate:_observer.current_seed,frame:current_frame,random_state:random_get_seed(),native_states:global.rng_state,
            pool_position:[x,y],pool_sprite:sprite_index,pool_setup:setup,pool_floors:array_length(floors),queens:_queens,holes:_holes}))
    }
    if((_kind=="PizzaEntrance.Create.after" || _kind=="Manhole.Create.after") && _observer.phase==1)
        scrNTTESmokeLog("SEWER PIZZA CONSTRUCTOR "+_kind+" "+json_stringify({rate:_observer.rates[_observer.pass_index],
            candidate:_observer.current_seed,frame:current_frame,xy:[x,y],bbox:[bbox_left,bbox_top,bbox_right,bbox_bottom],
            random_state:random_get_seed(),native_states:global.rng_state}))
    if(_kind=="PizzaEntrance.Create.after" && _observer.phase==1)
        array_push(_observer.entrance_records,{id:id,x:(bbox_left+bbox_right)/2,y:(bbox_top+bbox_bottom)/2})
    if(_kind=="Manhole.Create.after" && _observer.phase==1)
        array_push(_observer.manhole_records,{id:id,x:x,y:y})
    if(_observer.phase==2) {
        if(_kind=="Rocket.Create.after") _observer.rocket_creations++
        if(_kind=="Explosion.Create.after") _observer.explosion_creations++
        if(id==_observer.hole) {
            if(_kind=="Manhole.Step.before" && place_meeting(x,y,Explosion)) _observer.saw_explosion_contact=true
            if(_kind=="Manhole.Destroy.before") {
                // Read-only native Destroy timing witness. A two-frame sprite
                // can advance and destroy within one Step at 30 fps, before
                // the guarded Step.after observer is able to run.
                scrNTTESmokeLog("SEWER PIZZA Manhole Destroy diagnostic @"+string(_observer.rates[_observer.pass_index])
                    +" phase="+string(_observer.phase)+" seed="+string(_observer.current_seed)
                    +" frame="+string(current_frame)+" step_scale="+string(timescale)
                    +" sprite="+sprite_get_name(sprite_index)+" image="+string(image_index)
                    +" start="+string(_observer.hole_start_image)+" count="+string(image_number)
                    +" explosion_contact="+string(_observer.saw_explosion_contact)
                    +" open_progress="+string(_observer.saw_open_progress)
                    +" fire_pulses="+string(_observer.input_fire_pulses)
                    +" rockets="+string(_observer.rocket_creations)+" explosions="+string(_observer.explosion_creations)
                    +" live_explosions="+string(instance_number(Explosion))
                    +" overlap_now="+string(place_meeting(x,y,Explosion))
                    +" ammo_initial="+string(_observer.initial_ammo)
                    +" ammo_now="+string(instance_exists(_observer.player)?_observer.player.ammo[Ammo.Explosives]:-1))
                // Observe the real final frame inside native Destroy, before
                // the source death body runs. At30 the source's two-frame
                // animation opens and destroys in the same Step; Step.after
                // cannot witness it. No sprite/frame/collision is changed.
                assert(sprite_index==_observer.hole_start_sprite && image_number==_observer.hole_start_frames
                    && _observer.hole_start_image==0 && image_number==2
                    && image_index>_observer.hole_start_image && image_index==image_number-1
                    && !contact && visible && _observer.saw_explosion_contact && place_meeting(x,y,Explosion),
                    "Native Manhole Destroy omitted original sprite/frames or actual explosion-opened source endpoint")
                _observer.saw_open_progress=true
                assert(_observer.saw_explosion_contact && _observer.saw_open_progress
                    && _observer.rocket_creations>0 && _observer.input_fire_pulses>0,
                    "Natural Manhole destroyed without real input/projectile/explosion/opening witnesses")
                _observer.manhole_destroy_seen=true
            }
        }
        if(_kind=="Portal.Create.after" && _observer.manhole_destroy_seen
            && point_distance(x,y,_observer.hole_x,_observer.hole_y)<1) {
            assert(_observer.portal==noone,"Natural Manhole created duplicate measured native Portals")
            _observer.portal=id;_observer.saw_spawn=sprite_index==sprPortalSpawn
            var _pending=GameCont.ntte_full_pending_destination
            assert(is_struct(_pending) && _pending.area==scrNTTEFullAreaId("pizza") && _pending.subarea==1
                && _pending.loops==0 && GameCont.area==area_sewers && GameCont.subarea==1,
                "Source Manhole failed Pizza0->final1 queue or changed active world before engine transition")
        }
    }
    if(id==_observer.portal) {
        if(sprite_index==sprPortal) _observer.saw_open=true
        if(sprite_index==sprPortalDisappear) _observer.saw_disappear=true
        if(_kind=="Portal.Collision.Player.after" && endgame<=30) _observer.saw_contact=true
        if(_kind=="Portal.Alarm1.before") _observer.native_restart_requested=true
    }
}
function scrNTTEFullSewerPizzaEntryStepBody() {
    elapsed+=timescale
    assert(elapsed<=3600,"Sewer/Pizza native entry timeout phase="+string(phase)+" seed="+string(scrNTTEFullValue(id,"current_seed",-1)))
    if(phase>0) scrNTTEFullSewerPizzaEntryRate("phase "+string(phase))
    if(instance_exists(player)) {
        player.hp=100000;player.max_hp=100000;player.lsthealth=100000;player.nexthurt=current_frame+100000
    }
    if(phase==0) {
        for(var _i=0;_i<array_length(smoke_drivers);++_i) {
            instance_activate_object(smoke_drivers[_i])
            if(instance_exists(smoke_drivers[_i])) instance_destroy(smoke_drivers[_i],false)
        }
        smoke_drivers=[]
        save_set_value("options","framerate",rates[pass_index]);save_set_value("options","autopause",false)
        save_set_value("options","keyboard",true);save_set_value("options","gamepad",false)
        save_set_value("visual","bossintro",false);save_set_value("visual","freezeframes",false)
        save_set_value("game","tutorial",false)
        UberCont.opt_framerate=rates[pass_index];UberCont.opt_autopause=false;UberCont.opt_keyboard=true
        UberCont.opt_gamepad=false;UberCont.opt_bossintro=false;UberCont.opt_freeze=0
        UberCont.paused=false;UberCont.want_pause=false;UberCont.block_input_frames=0;UberCont.block_input_fire=false
        game_set_speed(rates[pass_index],gamespeed_fps)
        scrNTTEFullSewerPizzaEntryAwait(19);return;
    }
    if(phase==19) {
        UberCont.daily_run=false;UberCont.weekly_run=false;UberCont.coop=false;UberCont.hardmode=false
        UberCont.continued_run=false
        UberCont.want_quit_to_menu=false;UberCont.show_leaderboards_menu=false
        global.is_server=true;global.index=0;global.crownpick=crwn_none
        scrGameCustomModeReset();scr_playerinstances_reset_all();my_player.race=Race.Fish;my_player.skin=0
        game_directory=scratch_root+string(rates[pass_index])+"/";directory_create(game_directory)
        var _files=["ntte-full-progress.json","ntte-full-progress.json.bak","ntte-full-progress.json.tmp","NuclearThrone.sav"]
        for(var _i=0;_i<array_length(_files);++_i) array_push(scratch_files,game_directory+_files[_i])
        // Replay the actual30-selected declared seed at60. The first seed
        // satisfying the launch profile can differ after live native frames;
        // do not select another60 seed or assume earlier profiles still fail.
        candidate_index=pass_index==0?0:array_get_index(candidate_seeds,selected_seed_30)
        assert(candidate_index>=0,"Previously selected Sewer seed left the declared candidates")
        scrNTTEFullSewerPizzaEntryCandidate();return;
    }
    if(phase==1) {
        if(!scrNTTEFullSewerPizzaEntryWorldReady()) return;
        assert(instance_number(Floor)>20 && instance_number(TopCont)==1 && !instance_exists(TutCont),
            "Initial actual Sewer generation omitted terrain/renderer or retained tutorial")
        if(!scrNTTEFullSewerPizzaEntryProfile()) {
            scrNTTESmokeLog("SEWER PIZZA candidate rejected: "+profile_reject+" seed="+string(current_seed))
            assert(pass_index==0,"Actual30-selected Sewer seed failed the unchanged60 natural entrance profile")
            assert(++candidate_index<array_length(candidate_seeds),"No reproducible natural Sewer entrance geometry in declared seed candidates")
            scrNTTEFullSewerPizzaEntryCandidate();return;
        }
        if(pass_index==0) selected_seed_30=current_seed
        else assert(current_seed==selected_seed_30,"Native30/60 selected different natural entrance seed profile")
        hole_x=hole.x;hole_y=hole.y;hole_start_image=hole.image_index
        hole_start_sprite=hole.sprite_index;hole_start_frames=hole.image_number
        assert(hole_start_image==0 && hole_start_frames==2
            && (hole_start_sprite==asset_get_index("sprNTTERefPizzaManholeI0")
                || hole_start_sprite==asset_get_index("sprNTTERefPizzaManholeI1")
                || hole_start_sprite==asset_get_index("sprNTTERefPizzaManholeI2")),
            "Natural Manhole did not retain an original two-frame closed source sprite")
        old_world=scrNTTEFullInstances([Floor,Wall,TopCont,SubTopCont]);old_game=GameCont.id;old_player=player.id
        old_hard=GameCont.hard;old_waypoints=GameCont.waypoints;hop_ends=room_ends;hop_starts=room_starts
        old_pizza_visits=scrNTTEFullValue(GameCont,"ntte_visits_pizza",0)
        // One controlled initial launch placement. All subsequent approach and
        // Portal contact use sampled native movement and source attraction.
        player.x=launch_x;player.y=launch_y;player.xprevious=launch_x;player.yprevious=launch_y
        player.speed=0;player.can_walk=false;player.can_aim=true
        initial_ammo=player.ammo[Ammo.Explosives];input_start_x=player.x;input_start_y=player.y
        scr_camera_set_position(hole_x,hole_y,fa_center,fa_middle)
        want_fire=true;want_move=false;scrNTTEFullSewerPizzaEntryAwait(2);return;
    }
    if(phase==2) {
        fire_clock+=timescale
        saw_native_ammo_spent=saw_native_ammo_spent || player.ammo[Ammo.Explosives]<initial_ammo
        if(instance_exists(hole)) return;
        assert(manhole_destroy_seen && instance_exists(portal) && saw_spawn && saw_explosion_contact
            && saw_open_progress && input_fire_pulses>0 && rocket_creations>0 && explosion_creations>0
            && saw_native_ammo_spent,"Natural source opening omitted actual player fire/ammo/Rocket/Explosion/Portal witnesses")
        assert(scrNTTEFullValue(GameCont,"ntte_visits_pizza",0)==old_pizza_visits,"Pizza entry visits must not advance at Manhole death before RoomEnd")
        want_fire=false;want_move=true;player.can_walk=true
        scrNTTESmokeLog("SEWER PIZZA actual native entrance replacement + sampled Bazooka fire/ammo + Rocket/explosion mask + Manhole animation/Destroy + source queued Pizza1/native Portal, seed="+string(current_seed)+" @"+string(rates[pass_index]))
        scrNTTEFullSewerPizzaEntryAwait(3);return;
    }
    if(phase==3) {
        if(instance_exists(portal)) {
            saw_open=saw_open || portal.sprite_index==sprPortal
            saw_disappear=saw_disappear || portal.sprite_index==sprPortalDisappear
            return;
        }
        if(native_restart_requested && (room_ends==hop_ends || room_starts==hop_starts)) {
            missing_portal_clock+=timescale
            assert(missing_portal_clock<=4,"Native Portal requested room_restart without engine RoomEnd/Start")
            return;
        }
        assert(saw_spawn && saw_open && saw_contact && saw_disappear && native_restart_requested
            && input_move_samples>0,"Natural native Portal omitted input approach/collision/real animation/Alarm1 restart")
        assert(room_ends==hop_ends+1 && room_starts==hop_starts+1,
            "Natural Sewer/Pizza transition did not execute exactly one engine RoomEnd and RoomStart")
        assert(GameCont.id==old_game && instance_exists(old_player) && Player.id==old_player
            && GameCont.area==scrNTTEFullAreaId("pizza") && GameCont.subarea==1 && GameCont.loops==0
            && is_undefined(GameCont.ntte_full_pending_destination),"Actual engine transition lost persistent Player/GameCont or final Pizza1 destination")
        assert(GameCont.hard==old_hard+1 && GameCont.waypoints==old_waypoints+1
            && GameCont.waypnt[old_waypoints]==scrNTTEFullAreaId("pizza") && GameCont.waysub[old_waypoints]==1,
            "Actual Manhole engine transition bypassed native difficulty/waypoint accounting")
        assert(scrNTTEFullValue(GameCont,"ntte_visits_pizza",0)==old_pizza_visits+1,
            "Original current-area Pizza0 finish visit missing: expected="+string(old_pizza_visits+1)+" actual="+string(scrNTTEFullValue(GameCont,"ntte_visits_pizza",0)))
        for(var _i=0;_i<array_length(old_world);++_i)
            assert(!instance_exists(old_world[_i]),"Actual engine room disposal retained old Sewer terrain/renderer")
        want_move=false;scrNTTEFullSewerPizzaEntryAwait(4);return;
    }
    if(phase==4) {
        if(!scrNTTEFullSewerPizzaEntryWorldReady()) return;
        assert(GameCont.area==scrNTTEFullAreaId("pizza") && GameCont.subarea==1
            && GameCont.ntte_full_active_pizza && instance_number(Floor)>20 && instance_number(TopCont)==1
            && instance_exists(BackCont) && instance_number(NTTEFullPizzaManholeCover)==1
            && instance_exists(NTTEFullPizzaTV),"Actual restarted Pizza1 did not finish source generation/start/entities/renderer")
        assert(NTTEFullPizzaTV.sprite_index==sprTV && sprite_exists(NTTEFullPizzaTV.myscreen),
            "Actually entered Pizza1 lost native TV cabinet/channel during scheduled8Draw")
        assert(scrNTTEFullValue(GameCont,"ntte_visits_pizza",0)==old_pizza_visits+1,"Pizza generation/start/Draw repeated entry visit accounting")
        scrNTTESmokeLog("PASS SEWER PIZZA NATURAL ENTRY: actual asynchronous Sewer1 native PizzaEntrance replacement, source Manhole Explosion/no-boss interaction, sampled native Bazooka+movement inputs, actual native Portal collision/animation/Alarm1 room_restart, exactly one engine RoomEnd/Start/native bookkeeping/old-world disposal, real Pizza1 complete+8Draw/native TV; controlled initial seed="+string(current_seed)+" loop0/Bazooka/launch placement/protected Player/XP suppression, no full campaign or iOS claim @"+string(rates[pass_index]))
        if(++pass_index<array_length(rates)) {scrNTTEFullSewerPizzaEntryAwait(0);return;}
        scrNTTEFullSewerPizzaEntryRestore()
        scrNTTESmokeLog("PASS full internal selected implemented branches x 30/60; not complete MOD coverage")
        game_end()
    }
}
function scrNTTEFullSewerPizzaEntryStep() {
    try {scrNTTEFullSewerPizzaEntryStepBody()}
    catch(_error) {scrNTTEFullSewerPizzaEntryRestore();throw _error}
}

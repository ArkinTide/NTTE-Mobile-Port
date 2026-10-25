// Controlled source factory; no regional provider/Boss/campaign/ground-Portal claim.
function scrNTTEFullQuestCarryClear() {
    var _keep=id
    with(all) if(id!=_keep && object_index!=UberCont && object_index!=Console) instance_destroy(id,false)
}

function scrNTTEFullQuestCarryRestore() {
    if(restored) return;
    restored=true
    if(path_exists(bot_path)) path_delete(bot_path)
    var _unchanged=ds_map_write(old_save_map)==old_savedata
    scrNTTEFullQuestCarryClear()
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

function scrNTTEFullQuestCarryTests() {
    assert(os_type==os_windows && scrNTTEFullSmokeEnabled(),"Controlled quest carry requires explicit Windows full smoke")
    assert(!instance_exists(NTTEFullQuestCarryTest),"Controlled quest carry observer duplicated")
    var _observer=instance_create(0,0,NTTEFullQuestCarryTest)
    with(_observer) {
        restored=false;scratch_files=[];portal=noone;portal_contacts=0;portal_alarms=0;teleports=0;old_global_vars=[]
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
        rates=[30,60];pass_index=0;part_index=0;phase=0;elapsed=0;draw_frames=0;world_ready_draw=-1
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
        scrNTTEFullQuestCarryClear()
    }
}

function scrNTTEFullQuestCarryAwait(_next) {
    phase=_next;elapsed=0;world_ready_draw=-1;diagnostic_clock=0;bot_path_clock=0
    scrNTTESmokeLog("QUEST CARRY phase="+string(phase)+" rate="+string(rates[pass_index]))
}

function scrNTTEFullQuestCarryWorldReady() {
    if(instance_exists(GenCont) || instance_exists(FloorMaker)) {world_ready_draw=-1;return false;}
    if(world_ready_draw<0) {world_ready_draw=draw_frames;return false;}
    return draw_frames-world_ready_draw>=8
}

function scrNTTEFullQuestCarryRate(_where) {
    assert(UberCont.saveData==fixture_save_map && ds_map_write(old_save_map)==old_savedata
        && game_get_speed(gamespeed_fps)==rates[pass_index] && timescale==30/rates[pass_index]
        && UberCont.opt_framerate==rates[pass_index] && !UberCont.opt_autopause
        && save_get_value("options","framerate",-1)==rates[pass_index]
        && !save_get_value("options","autopause",true),"Palace artifact rate/options changed: "+_where)
}

function scrNTTEFullQuestCarryStep() {
    try {scrNTTEFullQuestCarryStepBody()}
    catch(_error) {
        scrNTTEFullQuestCarryDiagnostic("before strict failure: "+_error.message)
        scrNTTEFullQuestCarryRestore();throw _error
    }
}
function scrNTTEFullQuestCarryStart() {
        for(var _i=0;_i<array_length(smoke_drivers);++_i) {
            instance_activate_object(smoke_drivers[_i])
            if(instance_exists(smoke_drivers[_i])) instance_destroy(smoke_drivers[_i],false)
        }
        smoke_drivers=[];scrNTTEFullQuestCarryClear()
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
        game_directory=scratch_root+string(rates[pass_index])+"-"+string(part_index)+"/";directory_create(game_directory)
        var _files=["ntte-full-progress.json","ntte-full-progress.json.bak","ntte-full-progress.json.tmp","NuclearThrone.sav"]
        for(var _i=0;_i<array_length(_files);++_i) array_push(scratch_files,game_directory+_files[_i])
        provider_records=[];factory_records=[];opened_records=[];load_calls=0;session_imports=0;player_loads=[]
        room_ends=0;room_starts=0;player_room_starts=[];gen_creates=0;gen_destroys=0
        source_chest=noone;source_pickup=noone;source_model=undefined;move_samples=0;pick_samples=0
        instance_create(0,0,GameCont);instance_create(0,0,BackCont);instance_create(0,0,MusCont);scrCreatePlayers(0)

        GameCont.area=area_desert;GameCont.subarea=1;GameCont.loops=0;GameCont.hard=0
        GameCont.can_advance_stage=true;GameCont.gocrib=false;GameCont.crown=crwn_none
        GameCont.ntte_full_pending_destination=undefined;GameCont.ntte_quest_spawned_part_index_list=[part_index]
        GameCont.proto=part_index==0
        GameCont.ntte_full_source_seed=scrNTTEFullSourceSeedBuild(701932)
        GameCont.ntte_full_source_pending_generation=undefined;global.ntte_full_sync_generation=false
        scrRngStatesReset();player=instance_find(Player,0);initial_player=player
        previous_model={wep:wep_wrench};previous_handle=scrNTTEFullWeaponNative(previous_model)
        player.wep=previous_handle;player.ntte_state=scrNTTEFullWeaponNativeState(previous_handle)
        player.bwep=wep_none;player.bntte_state=undefined
        assert(player.hp==8 && player.max_hp==8,"Controlled native Fish must keep actual8HP")
        scrNTTEFullFloorResetStyle();scrNTTEFullFloorResetAlign()
        for(var _x=-4;_x<=6;++_x) for(var _y=-2;_y<=2;++_y) instance_create(10000+32*_x,10000+32*_y,Floor)
        source_chest=scrNTTEFullQuestArtifactChest(10080,10016,part_index)
        assert(instance_is(source_chest,NTTEFullQuestChest),"Controlled actual artifact factory substituted chest")
        source_model=source_chest.wep;source_pickup=noone;portal=noone;portal_contacts=0;portal_alarms=0;teleports=0
        scrNTTEFullQuestCarryProgress(false);scrNTTEFullQuestCarryAwait(1)
        scrNTTESmokeLog("QUEST CARRY controlled source factory part="+string(part_index)+" current-run marker precondition/native Fish8HP/Wrench/seed701932; no regional acquisition/Boss claim")

}

function scrNTTEFullQuestCarryAbort(_error) {
    var _o=instance_find(NTTEFullQuestCarryTest,0)
    if(instance_exists(_o)) with(_o) scrNTTEFullQuestCarryRestore()
    throw _error
}
function scrNTTEFullQuestCarryDiagnostic(_where) {
    scrNTTESmokeLog("QUEST CARRY "+_where+" "+json_stringify({phase:phase,part:part_index,rate:rates[pass_index],elapsed:elapsed,
      player:player,alive:instance_exists(player),room_ends:room_ends,room_starts:room_starts,gen_create:gen_creates,gen_destroy:gen_destroys,
      loads:load_calls,imports:session_imports,teleports:teleports,contact:portal_contacts,alarm:portal_alarms}))
    if(phase==4 || phase==6 || phase==11) {
        var _pads=[],_crowns=[],_portals=[],_waypoint=undefined
        with(NTTEFullQuestTeleporterPad) array_push(_pads,{actor:id,x:x,y:y,to_x:teleport_x,to_y:teleport_y})
        with(CrownPickup) array_push(_crowns,{actor:id,x:x,y:y,bbox:[bbox_left,bbox_top,bbox_right,bbox_bottom]})
        with(Portal) array_push(_portals,{actor:id,x:x,y:y,close:close,endgame:endgame})
        var _count=path_exists(bot_path)?path_get_number(bot_path):0
        if(_count>0) {
            var _cursor=clamp(bot_path_cursor,0,_count-1)
            _waypoint=[path_get_point_x(bot_path,_cursor),path_get_point_y(bot_path,_cursor)]
        }
        scrNTTESmokeLog("QUEST CARRY NAV "+json_stringify({
            phase:phase,elapsed:elapsed,
            player:instance_exists(player)?[player.x,player.y,player.mask_index,player.speed]:undefined,
            depot:instance_exists(depot)?[depot.x,depot.y]:undefined,
            target_pickup:instance_exists(source_pickup)?[source_pickup.x,source_pickup.y]:undefined,
            path_goal:[bot_goal_x,bot_goal_y],path_points:_count,path_cursor:bot_path_cursor,waypoint:_waypoint,
            probe:scrNTTEFullValue(id,"bot_nav_probe",undefined),
            pads:_pads,crowns:_crowns,portals:_portals
        }))
        if(instance_exists(player)) {
            var _ground=scrNTTEFullQuestCarryGround(),_items=[];
            for(var _i=0;_i<array_length(_ground);++_i) array_push(_items,{actor:_ground[_i],
                exact:phase==6 && scrNTTEFullWeaponModel(_ground[_i].wep)==restored_model});
            scrNTTESmokeLog("QUEST CARRY INVENTORY "+json_stringify({phase:phase,main:player.wep,secondary:player.bwep,
                main_has:scrNTTEFullQuestWeaponHasPart(player.wep,part_index,player.ntte_state),
                secondary_has:scrNTTEFullQuestWeaponHasPart(player.bwep,part_index,player.bntte_state),
                main_exact:phase==6 && scrNTTEFullWeaponModel(player.wep)==restored_model,
                secondary_exact:phase==6 && scrNTTEFullWeaponModel(player.bwep)==restored_model,
                ground:_items,stored:scrNTTEFullUnlockGet("quest:part:"+string(part_index),false)}));
        }
    }
}
function scrNTTEFullQuestCarryNumbers(_a,_b) {
    if(!is_array(_a)||!is_array(_b)||array_length(_a)!=array_length(_b)) return false
    for(var _i=0;_i<array_length(_a);++_i) if(_a[_i]!=_b[_i]) return false
    return true
}
function scrNTTEFullQuestCarryProgress(_stored) {
    for(var _i=0;_i<4;++_i) assert(scrNTTEFullUnlockGet("quest:part:"+string(_i),false)==(_i==part_index && _stored),"Wrong actual persistent deposited-part flags")
    assert(!scrNTTEFullUnlockGet("race:beetle",false),"One part prematurely granted Beetle")
    assert(array_get_index(GameCont.ntte_quest_spawned_part_index_list,part_index)>=0 && !scrNTTEFullQuestArtifactAvailable(part_index),"Per-run artifact exclusion lost")
}
function scrNTTEFullQuestCarryGround() {
    var _out=[],_part=part_index
    with(WepPickup) if(scrNTTEFullQuestWeaponHasPart(wep,_part,scrNTTEFullValue(id,"ntte_state",undefined))) array_push(_out,id)
    return _out
}
function scrNTTEFullQuestCarryController() {
    var _out=noone,_part=part_index,_count=0
    with(NTTEFullQuestFloorCont) if(part_index==_part) {_out=id;_count++}
    assert(_count==1 && instance_exists(_out.target),"Native generated Hub lacks exactly one real part floor")
    return _out
}
function scrNTTEFullQuestCarryHeld() {
    assert(scrNTTEFullWeaponIsNative(player.wep) && scrNTTEFullWeaponIsNative(player.bwep),"Carry lost actual physical inventory handles")
    var _m=scrNTTEFullWeaponModel(player.wep),_b=scrNTTEFullWeaponModel(player.bwep)
    assert(scrNTTEFullCrabbonePartIndex(_m,player.ntte_state)==part_index && _m.type_index==part_index+1 && _m.ammo==1 && player.ntte_state.ammo==1
      && _m.ammo_wep==wep_none && player.ntte_state.ammo_wep==wep_none && player.ntte_state==_m.ntte_native_state && player.ntte_state.weapon==player.wep
      && scrNTTEFullWeaponRaw(_b)==wep_wrench && player.bntte_state==_b.ntte_native_state && player.bntte_state.weapon==player.bwep
      && player.curse==0 && player.bcurse==0,"Carry lost exact source part/Wrench/canonical states")
    assert(array_length(scrNTTEFullQuestCarryGround())==0,"Held artifact duplicated on ground")
    scrNTTEFullQuestCarryProgress(false)
}
function scrNTTEFullQuestCarryFingerprint(_continue=false) {
    var _roots=[scrNTTEFullWeaponModel(player.wep),player.ntte_state,scrNTTEFullWeaponModel(player.bwep),player.bntte_state],_g={originals:[],nodes:[]},_states=0
    for(var _i=1;_i<4;_i+=2) if(is_struct(_roots[_i])) {
        var _s=_roots[_i];_states++
        assert(_s.outstanding==0 && _s.charge==0 && _s.loaded,"No-fire physical graph has pending work")
    }
    var _root=scrNTTEFullWeaponNativeEncode(_roots,_g),_epochs=0
    for(var _i=0;_i<array_length(_g.nodes);++_i) if(!_g.nodes[_i].array) {
        var _e=_g.nodes[_i].entries
        if(_continue) for(var _j=0;_j<array_length(_e);++_j) if(_e[_j][0]=="epoch") {_e[_j][1].value+=1;_epochs++}
        array_sort(_e,function(_a,_b) {
            var _n=min(string_byte_length(_a[0]),string_byte_length(_b[0]))
            for(var _k=1;_k<=_n;++_k) {var _d=string_byte_at(_a[0],_k)-string_byte_at(_b[0],_k);if(_d!=0) return _d}
            return string_byte_length(_a[0])-string_byte_length(_b[0])
        })
        _g.nodes[_i].entries=_e
    }
    assert(!_continue || _epochs==_states,"No-fire graph canonical epoch count differs")
    return json_stringify({root:_root,nodes:_g.nodes,wep:player.wep,bwep:player.bwep,ammo:player.ammo,curse:player.curse,bcurse:player.bcurse})
}
function scrNTTEFullQuestCarryProbe(_where,_value=undefined) {
    var _o=instance_find(NTTEFullQuestCarryTest,0)
    if(_o.restored) return;
    if(_where=="GenCreate") _o.gen_creates++
    if(_where=="GenDestroy") _o.gen_destroys++
    if(_where=="PlayerRoomStart") array_push(_o.player_room_starts,id)
    if(_where=="Load") {assert((_o.phase==5 || _o.phase==8) && !_value,"Fixture bypassed full loader");_o.load_calls++}
    if(_where=="Session") {assert(scrNTTEFullQuestCarryNumbers(GameCont.ntte_quest_spawned_part_index_list,_o.saved_spawned),"Session import changed exact pre-generation numeric spawn list");_o.session_imports++}
    if(_where=="PlayerLoad") array_push(_o.player_loads,id)
    if(id==_o.portal && _where=="PortalContact") {assert(other.id==_o.player && close && alarm[1]>0,"Native Portal contact actor/alarm differs");_o.portal_contacts++}
    if(id==_o.portal && _where=="PortalAlarm") {assert(GameCont.is_level_ended,"Native Portal alarm did not end level");_o.portal_alarms++}
}
function scrNTTEFullQuestCarryTeleport(_pad,_actor) {
    var _o=instance_find(NTTEFullQuestCarryTest,0)
    if(_o.restored || _actor!=_o.player) return;
    assert(instance_is(_pad,NTTEFullQuestTeleporterPad) && point_distance(_actor.x,_actor.y,_pad.teleport_x,_pad.teleport_y-8)<3,"Native teleporter move witness differs")
    _o.teleports++
}
function scrNTTEFullQuestCarryBoundary() {
    boundary_ends=room_ends;boundary_starts=room_starts;boundary_gen=gen_creates;boundary_destroy=gen_destroys
    boundary_player=player;boundary_contacts=portal_contacts;boundary_alarms=portal_alarms
}
function scrNTTEFullQuestCarryPortal(_area,_sub,_phase) {
    scrNTTEFullQuestCarryHeld();live_model=scrNTTEFullWeaponModel(player.wep);live_previous=scrNTTEFullWeaponModel(player.bwep);live_fingerprint=scrNTTEFullQuestCarryFingerprint()
    scrNTTEFullQuestCarryBoundary();GameCont.can_advance_stage=true
    scrNTTEFullAreaSet(_area,_sub,GameCont.loops)
    portal=instance_create(player.x,player.y,Portal);scrNTTEFullQuestCarryAwait(_phase)
}
function scrNTTEFullQuestCarryArrival(_area,_sub) {
    if(room_ends==boundary_ends || !scrNTTEFullQuestCarryWorldReady()) return false
    assert(room_ends==boundary_ends+1 && room_starts==boundary_starts+1 && gen_creates==boundary_gen+1 && gen_destroys==boundary_destroy+1
      && portal_contacts==boundary_contacts+1 && portal_alarms==boundary_alarms+1 && instance_number(Player)==1 && Player.id==boundary_player
      && GameCont.area==_area && GameCont.subarea==_sub && array_get_index(player_room_starts,Player.id)>=0,"Queued controlled real Portal omitted native contact/alarm/restart/async Gen/eight Draws")
    player=Player.id;scrNTTEFullQuestCarryHeld()
    assert(scrNTTEFullWeaponModel(player.wep)==live_model && scrNTTEFullWeaponModel(player.bwep)==live_previous && scrNTTEFullQuestCarryFingerprint()==live_fingerprint,"Real room transit copied/mutated carried physical graph")
    return true
}
function scrNTTEFullQuestCarryContinue(_phase,_stored) {
    scrNTTEFullQuestCarryProgress(_stored);saved_fingerprint=scrNTTEFullQuestCarryFingerprint(true)
    saved_primary=scrNTTEFullWeaponModel(player.wep);saved_secondary=scrNTTEFullWeaponModel(player.bwep)
    saved_spawned=[];array_copy(saved_spawned,0,GameCont.ntte_quest_spawned_part_index_list,0,array_length(GameCont.ntte_quest_spawned_part_index_list))
    saved_loads=load_calls;saved_imports=session_imports;saved_player_loads=array_length(player_loads);scrNTTEFullQuestCarryBoundary()
    scrSavegameSave();assert(file_exists(savegame_file),"Full binary missing")
    var _b=buffer_load(savegame_file);assert(buffer_get_size(_b)>128,"Empty full binary");buffer_delete(_b)
    // Real JSON disk import is an explicit separate persistence boundary.
    assert(scrNTTEFullProgressLoad(),"Actual deposited/taken-back JSON disk import failed");scrNTTEFullQuestCarryProgress(_stored)
    scrNTTEFullQuestCarryClear();UberCont.want_quit_to_menu=false;scrNTTEFullQuestCarryAwait(_phase);room_restart()
}
function scrNTTEFullQuestCarryLoaded(_stored) {
    if(room_ends==boundary_ends || !scrNTTEFullQuestCarryWorldReady()) return false
    assert(room_ends==boundary_ends+1 && room_starts==boundary_starts+1 && gen_creates==boundary_gen+1 && gen_destroys==boundary_destroy+1
      && load_calls==saved_loads+1 && session_imports==saved_imports+1 && array_length(player_loads)==saved_player_loads+1
      && instance_number(Player)==1 && Player.id!=boundary_player && player_loads[saved_player_loads]==Player.id
      && array_get_index(player_room_starts,Player.id)>=0 && UberCont.continued_run && GameCont.is_level_continuation
      && GameCont.area==area_vault && GameCont.subarea==0,"Actual full binary Continue lacks new Player/session/registry/RoomStart/async world/eight Draws")
    player=Player.id;assert(player.hp>0,"Actual continued Fish died")
    assert(scrNTTEFullWeaponModel(player.wep)!=saved_primary && (!is_struct(saved_secondary)||scrNTTEFullWeaponModel(player.bwep)!=saved_secondary)
      && scrNTTEFullQuestCarryFingerprint()==saved_fingerprint,"Binary Continue retained old objects or changed exact held graph/aliases/ammo")
    scrNTTEFullQuestCarryProgress(_stored);return true
}
function scrNTTEFullQuestCarrySegmentSafe(_tx,_ty) {
    var _px=player.x,_py=player.y,_steps=max(1,ceil(point_distance(_px,_py,_tx,_ty)))
    for(var _s=1;_s<=_steps;++_s) {
        var _sx=lerp(_px,_tx,_s/_steps),_sy=lerp(_py,_ty,_s/_steps)
        if(!instance_exists(instance_position(_sx,_sy,Floor))) return false;
        var _blocked=false
        with(player) _blocked=place_meeting(_sx,_sy,Wall) || place_meeting(_sx,_sy,InvisiWall) || place_meeting(_sx,_sy,CrownPickup)
        if(_blocked) return false;
    }
    return true
}
function scrNTTEFullQuestCarryPath(_gx,_gy) {
    bot_path_clock-=timescale
    if(bot_path_clock<=0 || point_distance(_gx,_gy,bot_goal_x,bot_goal_y)>3) {
        bot_path_clock=20;bot_goal_x=_gx;bot_goal_y=_gy;bot_path_cursor=1
        var _left=infinity,_top=infinity,_right=-infinity,_bottom=-infinity
        with(Floor) {_left=min(_left,bbox_left);_top=min(_top,bbox_top);_right=max(_right,bbox_right);_bottom=max(_bottom,bbox_bottom)}
        var _l=floor((_left-64)/8)*8,_t=floor((_top-64)/8)*8,_grid=mp_grid_create(_l,_t,ceil((_right-_left+128)/8),ceil((_bottom-_top+128)/8),8,8)
        try {
            var _cx=floor((player.x-_l)/8),_cy=floor((player.y-_t)/8)
            bot_nav_probe={xy:[player.x,player.y],cell:[_cx,_cy],world_cell:[_l+8*_cx,_t+8*_cy,_l+8*_cx+7,_t+8*_cy+7]}
            mp_grid_add_rectangle(_grid,_l,_t,_right+64,_bottom+64)
            with(Floor) mp_grid_clear_rectangle(_grid,bbox_left,bbox_top,bbox_right,bbox_bottom)
            bot_nav_probe.terrain=mp_grid_get_cell(_grid,_cx,_cy)
            with(Wall) mp_grid_add_rectangle(_grid,bbox_left-5,bbox_top-3,bbox_right+5,bbox_bottom+3)
            bot_nav_probe.wall=mp_grid_get_cell(_grid,_cx,_cy)
            // Fixture pathfinding avoids the native automatic crown interaction.
            // These are observations of live masks; no world instance is changed.
            var _pl=player.bbox_left-player.x,_pr=player.bbox_right-player.x,
                _pt=player.bbox_top-player.y,_pb=player.bbox_bottom-player.y
            with(CrownPickup) mp_grid_add_rectangle(_grid,
                bbox_left-_pr-8,bbox_top-_pb-8,bbox_right-_pl+8,bbox_bottom-_pt+8)
            bot_nav_probe.crown=mp_grid_get_cell(_grid,_cx,_cy)
            if(bot_nav_probe.crown<0) {
                // Real inertia can put the bot in a padded grid cell even
                // while its actual native mask remains on walkable ground.
                // Walk toward a nearby free cell only after a 1px sampled
                // native-mask check; never clear the grid or move the actor.
                var _best=infinity,_escape=undefined,_px=player.x,_py=player.y
                for(var _dx=-4;_dx<=4;++_dx) for(var _dy=-4;_dy<=4;++_dy) {
                    var _nx=_cx+_dx,_ny=_cy+_dy
                    if(_nx<0 || _ny<0 || _nx>=ceil((_right-_left+128)/8) || _ny>=ceil((_bottom-_top+128)/8)) continue
                    if(mp_grid_get_cell(_grid,_nx,_ny)<0) continue
                    var _tx=_l+8*_nx+4,_ty=_t+8*_ny+4,_d=point_distance(_px,_py,_tx,_ty)
                    if(_d>=_best) continue
                    var _safe=scrNTTEFullQuestCarrySegmentSafe(_tx,_ty)
                    if(_safe) {_best=_d;_escape=point_direction(_px,_py,_tx,_ty)}
                }
                if(!is_undefined(_escape)) {
                    bot_path_clock=0
                    return _escape
                }
            }
            var _pads=scrNTTEFullInstances(NTTEFullQuestTeleporterPad),_nodes=[[player.x,player.y],[_gx,_gy]],_n=2+array_length(_pads)
            for(var _i=0;_i<array_length(_pads);++_i) array_push(_nodes,[_pads[_i].x,_pads[_i].y-8])
            var _edge=array_create(_n),_dist=array_create(_n,infinity),_prev=array_create(_n,-1),_seen=array_create(_n,false)
            for(var _i=0;_i<_n;++_i) _edge[_i]=array_create(_n,infinity)
            for(var _i=0;_i<_n;++_i) for(var _j=_i+1;_j<_n;++_j) {
                path_clear_points(bot_path)
                if(mp_grid_path(_grid,bot_path,_nodes[_i][0],_nodes[_i][1],_nodes[_j][0],_nodes[_j][1],false)) {
                    var _len=max(1,path_get_length(bot_path));_edge[_i][_j]=_len;_edge[_j][_i]=_len
                }
            }
            for(var _i=0;_i<array_length(_pads);++_i) for(var _j=0;_j<array_length(_pads);++_j)
                if(point_distance(_pads[_i].teleport_x,_pads[_i].teleport_y,_pads[_j].x,_pads[_j].y)<2) _edge[_i+2][_j+2]=40
            _dist[0]=0
            repeat(_n) {
                var _u=-1,_best=infinity
                for(var _i=0;_i<_n;++_i) if(!_seen[_i] && _dist[_i]<_best) {_best=_dist[_i];_u=_i}
                if(_u<0) break
                _seen[_u]=true
                for(var _v=0;_v<_n;++_v) if(_dist[_u]+_edge[_u][_v]<_dist[_v]) {_dist[_v]=_dist[_u]+_edge[_u][_v];_prev[_v]=_u}
            }
            bot_nav_probe.previous=_prev[1];bot_nav_probe.distance=_dist[1];bot_nav_probe.direct=_edge[0]
            path_clear_points(bot_path)
            if(_prev[1]>=0) {
                var _next=1,_guard=0
                while(_prev[_next]>0 && _guard++<_n) _next=_prev[_next]
                assert(_guard<_n,"Controlled navigation predecessor cycle")
                mp_grid_path(_grid,bot_path,player.x,player.y,_nodes[_next][0],_nodes[_next][1],false)
            }
        }
        finally {mp_grid_destroy(_grid)}
    }
    if(path_get_number(bot_path)<2 && (!variable_instance_exists(id,"bot_nav_last_blocked") || !bot_nav_last_blocked))
        scrNTTESmokeLog("QUEST CARRY FIRST NO PATH "+json_stringify(bot_nav_probe))
    bot_nav_last_blocked=path_get_number(bot_path)<2
    if(path_get_number(bot_path)<2) return undefined
    while(bot_path_cursor<path_get_number(bot_path)-1 && point_distance(player.x,player.y,path_get_point_x(bot_path,bot_path_cursor),path_get_point_y(bot_path,bot_path_cursor))<3) bot_path_cursor++
    var _chosen=-1,_last=min(path_get_number(bot_path)-1,bot_path_cursor+7)
    for(var _look=bot_path_cursor;_look<=_last;++_look) {
        var _lx=path_get_point_x(bot_path,_look),_ly=path_get_point_y(bot_path,_look)
        if(point_distance(player.x,player.y,_lx,_ly)>48) continue
        if(scrNTTEFullQuestCarrySegmentSafe(_lx,_ly)) _chosen=_look
    }
    if(_chosen<0) {bot_path_clock=0;return undefined;}
    bot_path_cursor=_chosen
    var _x=path_get_point_x(bot_path,_chosen),_y=path_get_point_y(bot_path,_chosen)
    return point_distance(player.x,player.y,_x,_y)<3?undefined:point_direction(player.x,player.y,_x,_y)
}
function scrNTTEFullQuestCarryInput(_k,_index) {
    var _o=instance_find(NTTEFullQuestCarryTest,0)
    if(_o.restored || !instance_exists(_o.player) || _o.player.index!=_index) return;
    var _moving=false,_dir=0,_pick=false
    with(_o) if(!instance_exists(GenCont) && !instance_exists(FloorMaker)) {
        var _target=noone
        if(phase==1) _target=source_chest
        if(phase==2 || phase==6) _target=source_pickup
        if(phase==4 || phase==11) _target=depot
        if(instance_exists(_target)) {
            var _next=scrNTTEFullQuestCarryPath(_target.x,_target.y)
            if(!is_undefined(_next)) {_moving=true;_dir=_next;move_samples++}
            _pick=phase==2 || phase==4 || phase==6 || phase==11
            // Sample separate ordinary presses with a release between them.
            // Holding press_pick true on every tick is not a key edge.
            _pick=_pick && (elapsed%10)<timescale
            if(_pick) pick_samples++
        }
    }
    _k.dir_move[_index]=_dir;_k.dir_fire[_index]=90;_k.moving[_index]=_moving?1:0
    _k.press_pick[_index]=_pick;_k.hold_pick[_index]=_pick
    _k.press_fire[_index]=false;_k.hold_fire[_index]=false;_k.release_fire[_index]=false
    _k.press_swap[_index]=false;_k.hold_swap[_index]=false;_k.hold_spec[_index]=false;_k.press_spec[_index]=false
    _k.aimassist[_index]=false;_k.precisemovement[_index]=true
    _k.hold_east[_index]=false;_k.hold_west[_index]=false;_k.hold_nort[_index]=false;_k.hold_sout[_index]=false
}
function scrNTTEFullQuestCarryStepBody() {
    elapsed+=timescale;diagnostic_clock-=timescale
    assert(elapsed<=7200,"Controlled artifact carry timeout phase="+string(phase))
    if(phase==0) {
        if(game_get_speed(gamespeed_fps)!=rates[pass_index] || timescale!=30/rates[pass_index]) {
            save_set_value("options","autopause",false);save_set_value("options","framerate",rates[pass_index])
            game_set_speed(rates[pass_index],gamespeed_fps);scrOptionsUpdate();return;
        }
        scrNTTEFullQuestCarryStart();return;
    }
    scrNTTEFullQuestCarryRate("ordinary frame")
    if(diagnostic_clock<=0) {diagnostic_clock=150;scrNTTEFullQuestCarryDiagnostic("periodic")}
    if(phase!=5 && phase!=8) assert(instance_exists(player) && player.hp>0,"Native Fish died; no health rescue")
    assert(!instance_exists(LevCont),"Unexpected real choice; no fixture dismissal")
    if(phase==1) {
        if(instance_exists(source_chest)) return;
        var _ground=scrNTTEFullQuestCarryGround();assert(array_length(_ground)==1 && scrNTTEFullWeaponModel(_ground[0].wep)==source_model && move_samples>0,"Controlled actual chest contact lost unique exact model pickup")
        source_pickup=_ground[0];scrNTTEFullQuestCarryAwait(2);return;
    }
    if(phase==2) {
        if(!scrNTTEFullQuestWeaponHasPart(player.wep,part_index,player.ntte_state)) return;
        scrNTTEFullQuestCarryHeld();assert(!instance_exists(source_pickup) && scrNTTEFullWeaponModel(player.wep)==source_model && scrNTTEFullWeaponModel(player.bwep)==previous_model && pick_samples>0,"Native sampled source pickup copied model/lost Wrench")
        scrNTTEFullQuestCarryPortal(area_vault,0,3);return;
    }
    if(phase==3) {if(!scrNTTEFullQuestCarryArrival(area_vault,0)) return;depot=scrNTTEFullQuestCarryController();scrNTTEFullQuestCarryAwait(4);return;}
    if(phase==4 || phase==11) {
        if(!scrNTTEFullUnlockGet("quest:part:"+string(part_index),false)) return;
        var _ground=scrNTTEFullQuestCarryGround();scrNTTEFullQuestCarryProgress(true)
        assert(array_length(_ground)==1 && scrNTTEFullWeaponModel(_ground[0].wep)==live_model && player.bwep==wep_none
          && scrNTTEFullWeaponRaw(scrNTTEFullWeaponModel(player.wep))==wep_wrench,"Actual sampled DROP lost exact root/restored Wrench or duplicated ground")
        if(phase==4) {dropped_model=live_model;scrNTTEFullQuestCarryContinue(5,true);return;}
        assert(teleports>0,"Hub lifecycle lacks actual native teleporter movement witness")
        scrNTTESmokeLog("PASS CONTROLLED QUEST CARRY part="+string(part_index)+" actual source factory/contact/input/carry/native Portal+Gen+8Draw/Hub DROP/disk progress reload/full binary Continue/new simple deposited part/take back/full binary Continue/revisit/actual teleports="+string(teleports)+"/redrop @"+string(rates[pass_index])+"; excludes regional provider/Boss/natural campaign/merged/ground-Portal")
        if(++part_index>=4) {part_index=0;pass_index++}
        if(pass_index<array_length(rates)) {scrNTTEFullQuestCarryAwait(0);return;}
        scrNTTEFullQuestCarryRestore();scrNTTESmokeLog("PASS full internal selected implemented branches x 30/60; not complete MOD coverage");game_end();return;
    }
    if(phase==5) {
        if(!scrNTTEFullQuestCarryLoaded(true)) return;
        depot=scrNTTEFullQuestCarryController();var _ground=scrNTTEFullQuestCarryGround()
        assert(array_length(_ground)==1 && instance_number(NTTEFullQuestChest)==0,"Deposited Continue duplicated active artifact/provider")
        source_pickup=_ground[0];var _m=scrNTTEFullWeaponModel(source_pickup.wep)
        assert(_m!=dropped_model && scrNTTEFullCrabbonePartIndex(_m)==part_index && _m.ammo==1 && _m.ammo_wep==wep_none,"Hub must restore one new independent simple deposited part")
        restored_model=_m;scrNTTEFullQuestCarryAwait(6);return;
    }
    if(phase==6) {
        if(!scrNTTEFullQuestWeaponHasPart(player.wep,part_index,player.ntte_state)) return;
        assert(!instance_exists(source_pickup) && scrNTTEFullWeaponModel(player.wep)==restored_model,"Take-back did not use exact restored ground model")
        scrNTTEFullQuestCarryAwait(7);return;
    }
    if(phase==7) {if(scrNTTEFullUnlockGet("quest:part:"+string(part_index),false)) return;scrNTTEFullQuestCarryHeld();scrNTTEFullQuestCarryContinue(8,false);return;}
    if(phase==8) {if(!scrNTTEFullQuestCarryLoaded(false)) return;scrNTTEFullQuestCarryHeld();assert(array_length(scrNTTEFullQuestCarryGround())==0,"Held Continue created stored duplicate");scrNTTEFullQuestCarryPortal(area_crib,1,9);return;}
    if(phase==9) {if(!scrNTTEFullQuestCarryArrival(area_crib,1)) return;scrNTTEFullQuestCarryPortal(area_vault,0,10);return;}
    if(phase==10) {
        if(!scrNTTEFullQuestCarryArrival(area_vault,0)) return;
        assert(array_length(scrNTTEFullQuestCarryGround())==0 && instance_number(NTTEFullQuestChest)==0,"Same-run Hub revisit duplicated ground/source chest")
        depot=scrNTTEFullQuestCarryController();scrNTTEFullQuestCarryAwait(11);return;
    }
}

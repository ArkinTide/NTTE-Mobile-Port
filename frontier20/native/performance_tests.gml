// The default stage contains no hot-path probe wrappers. A diagnostic stage
// opts in explicitly with build_frontier_stage.py --profile.
#macro FR_PROFILE_COMPILED false
function scrFRProfileEnter(_key) {
    if(!variable_global_exists("fr_profile") || !global.fr_profile) return undefined;
    if(!is_string(_key)) {
        if(is_method(_key)) _key=method_get_index(_key);
        _key=is_numeric(_key)?script_get_name(_key):string(_key);
    }
    var _token={key:_key,start:get_timer(),child:0};
    array_push(global.fr_profile_stack,_token);
    return _token;
}
function scrFRProfileExit(_token) {
    if(is_undefined(_token)) return;
    var _elapsed=get_timer()-_token.start;
    array_pop(global.fr_profile_stack);
    var _record=global.fr_profile_data[$ _token.key]??{calls:0,total_us:0,exclusive_us:0,max_us:0};
    _record.calls++;_record.total_us+=_elapsed;_record.exclusive_us+=max(0,_elapsed-_token.child);
    _record.max_us=max(_record.max_us,_elapsed);global.fr_profile_data[$ _token.key]=_record;
    var _depth=array_length(global.fr_profile_stack);
    if(_depth>0) global.fr_profile_stack[_depth-1].child+=_elapsed;
}
function scrFRPerformanceTestsStart(_driver) {
    _driver.persistent=true;
    _driver.fr_perf={index:-1,phase:0,wait:0,rows:[],cases:[
        {area:1,sub:1,loops:0,rate:60},
        {area:306,sub:1,loops:0,rate:60},
        {area:306,sub:1,loops:3,rate:60},
        {area:306,sub:1,loops:0,rate:30},
        {area:301,sub:1,loops:0,rate:60},
        {area:302,sub:1,loops:0,rate:60},
        {area:303,sub:1,loops:0,rate:60,seed:18334},
        {area:304,sub:3,loops:0,rate:60},
        {area:305,sub:2,loops:1,rate:60},
        {area:2,sub:1,loops:3,rate:60},
        {area:3,sub:2,loops:3,rate:60},
        {area:4,sub:1,loops:3,rate:60},
        {area:5,sub:1,loops:3,rate:60},
        {area:6,sub:1,loops:3,rate:60},
        {area:7,sub:1,loops:3,rate:60}]};
    global.fr_profile=false;global.fr_profile_data={};global.fr_profile_stack=[];
    save_set_value("game","tutorial",false);
    scrFRPerformanceTestsNext(_driver);
}
function scrFRPerformanceTestsNext(_driver) {
    var _state=_driver.fr_perf;
    global.fr_profile=false;
    if(++_state.index>=array_length(_state.cases)) {
        var _file=file_text_open_write("frontier-performance.json");
        file_text_write_string(_file,json_stringify({rows:_state.rows,physical_device_tested:false}));
        file_text_close(_file);_state.phase=3;return;
    }
    var _case=_state.cases[_state.index],_seed=_case[$ "seed"]??(7319+_case.area);
    save_set_value("options","framerate",_case.rate);
    save_set_value("options","autopause",false);save_set_value("visual","freezeframes",0);
    save_set_value("visual","bossintro",false);scrOptionsUpdate();
    UberCont.want_quit_to_menu=false;UberCont.want_restart=false;UberCont.want_menu=false;
    GameCont.area=_case.area;GameCont.subarea=_case.sub;GameCont.loops=_case.loops;
    GameCont.lastarea=area_labs;GameCont.lastsubarea=3;GameCont.hard=9;
    GameCont.proto=false;GameCont.gocrib=false;GameCont.killenemies=false;GameCont.crown=Crown.None;
    GameCont.maxsubarea=scrAreaGetMaxSubarea(_case.area);GameCont.finalsubarea=false;
    GameCont.baseseed=_seed;GameCont.levseed=_seed;
    GameCont.ntte_full_source_seed=scrNTTEFullSourceSeedBuild(_seed);
    GameCont.ntte_full_source_pending_generation=undefined;GameCont.ntte_full_pending_destination=undefined;
    GameCont.can_advance_stage=false;GameCont.is_level_ended=true;
    global.rng_state[@ RNGStates.Generation]=_seed;global.ntte_full_sync_generation=false;
    global.fr_continue_generation=undefined;global.fr_continue_events=undefined;
    scrFRModSet("area","robocenter","arenaGened",false);
    _state.phase=-1;_state.wait=0;_state.deep_input=false;
    scrNTTESmokeLog("FRONTIER PERFORMANCE GENERATE "+json_stringify(_case));room_restart();
}
function scrFRPerformanceTestsStep(_driver) {
    var _state=_driver.fr_perf;
    if(_state.phase==3) return true;
    if(_state.phase==-1) {
        if(!instance_exists(BackCont)) instance_create(0,0,BackCont);
        if(!instance_exists(MusCont)) instance_create(0,0,MusCont);
        global.fr_continue_events={game:GameCont.id,events:[]};
        var _generation=instance_create(0,0,GenCont);
        assert(instance_exists(_generation) && !_generation.ntte_full_sync_generation,
            "Performance fixture did not start real asynchronous native generation");
        _state.phase=0;return false;
    }
    if(instance_exists(GenCont) || instance_exists(FloorMaker) || !instance_exists(Player)) return false;
    GameCont.is_level_ended=true;
    with(Player) {hp=100000;max_hp=100000;nexthurt=current_frame+100000;speed=0;}
    if(_state.phase==0) {
        if(++_state.wait<30) return false;
        if(_state.cases[_state.index].area==303) {
            // Use a naturally generated authored Spin Turret encounter, not
            // the separate BecomeTurret markers for ordinary native Turrets.
            if(!_state.deep_input) {
                var _natural=scrFRMatching(enemy,"name","Spin Turret");
                assert(array_length(_natural)>0,
                    "Deep Labs performance seed omitted its real generated Spin Turrets");
                var _turret=_natural[0],_player=instance_find(Player,0),_floor=noone,_distance=infinity;
                with(Floor) {
                    var _px=x+16,_py=y+16,_d=point_distance(_px,_py,_turret.x,_turret.y),_blocked=false;
                    with(_player) _blocked=place_meeting(_px,_py,Wall)||place_meeting(_px,_py,InvisiWall);
                    if(!_blocked && _d<_distance) {_distance=_d;_floor=id;}
                }
                assert(instance_exists(_floor) && _distance<160,
                    "Deep Labs performance encounter has no reachable floor within turret range");
                scrFRAreaTestsMove(_player,_floor.x+16,_floor.y+16);
                _state.deep_input=true;_state.wait=0;return false;
            }
            var _turrets=scrFRMatching(enemy,"name","Spin Turret");
            assert(array_length(_turrets)>0,"Deep Labs generated turret encounter vanished before sampling");
            var _active=0,_visible_active=0;
            for(var _i=0;_i<array_length(_turrets);_i++) if(_turrets[_i].active) {
                _active+=1;
                if(scrFRPointSeen(_turrets[_i].x,_turrets[_i].y)) _visible_active+=1;
            }
            assert(_active>0,"Deep Labs performance input left every generated turret inactive");
            assert(_visible_active>0,"Deep Labs performance camera missed every active generated turret");
            scrNTTESmokeLog("FRONTIER PERFORMANCE REAL TURRET ENCOUNTER "+json_stringify({
                generated:array_length(_turrets),active:_active,visible_active:_visible_active,
                player_distance:point_distance(Player.x,Player.y,_turrets[0].x,_turrets[0].y)}));
        }
        scrNTTESmokeLog("FRONTIER PERFORMANCE TERRAIN "+json_stringify({
            scene:_state.cases[_state.index],floors:instance_number(Floor),
            walls:instance_number(Wall),invisible:instance_number(InvisiWall),
            enemies:instance_number(enemy),custom:instance_number(FRCustomObject)}));
        // Deeplabs deliberately uses authored room collision rather than
        // ordinary Wall entities. Keep the same real-terrain requirement as
        // the area campaign, including its native invisible collision.
        assert(instance_number(Floor)>20 && instance_number(Wall)+instance_number(InvisiWall)>0
            && instance_number(enemy)>0,
            "Performance sampling requires populated real terrain, collision and hostile actors");
        _state.phase=1;_state.wait=0;_state.start=get_timer();_state.frame=current_frame;
        _state.logic=FRWorld.logic_serial;_state.tick_start=0;_state.tick_actor=instance_create(16016,16016,FRCustomObject);
        _state.tick_actor.fr_perf_driver=_driver;
        _state.tick_actor.on_step=function(){fr_perf_driver.fr_perf.tick_start++;};
        global.fr_profile_data={};global.fr_profile_stack=[];global.fr_profile=FR_PROFILE_COMPILED;
        return false;
    }
    if(++_state.wait<120) return false;
    global.fr_profile=false;
    var _us=get_timer()-_state.start,_seconds=_us/1000000,
        _sim=(current_frame-_state.frame)/30,_logic=FRWorld.logic_serial-_state.logic,
        _row={scene:_state.cases[_state.index],seconds:_seconds,simulation_seconds:_sim,
            simulation_per_second:_sim/_seconds,source_ticks:_logic,actor_ticks:_state.tick_start,
            profile_instrumented:FR_PROFILE_COMPILED,
            objects:instance_count,enemies:instance_number(enemy),floors:instance_number(Floor),
            walls:instance_number(Wall),invisible_walls:instance_number(InvisiWall),profile:global.fr_profile_data};
    assert(_logic==120 && abs(_state.tick_start-120)<=1 && abs(_sim-4)<0.04,
        "Source simulation lost or doubled logical ticks during performance sampling");
    assert(game_get_speed(gamespeed_fps)==_row.scene.rate,
        "Native timing probe silently changed the requested frame policy");
    if(_row.scene.area==303 && FR_PROFILE_COMPILED) {
        var _draw=_row.profile[$ "scrFRDeeplabsSpinTurretDraw"]??{calls:0};
        assert(_draw.calls>0,"Deep Labs profile did not execute its visible generated turret renderer");
    }
    array_push(_state.rows,_row);
    scrNTTESmokeLog("FRONTIER PERFORMANCE RESULT "+json_stringify(_row));
    instance_destroy(_state.tick_actor,false);scrFRPerformanceTestsNext(_driver);return false;
}

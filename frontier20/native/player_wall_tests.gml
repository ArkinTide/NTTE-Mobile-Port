// Explicit isolated Windows regression. The driver only positions/configures
// a real Player at a scene boundary; native Step and engine Collision_Wall
// run normally between observations. No collision callback is invoked here.
function scrFRPlayerWallTestsStart(_driver) {
    assert(os_type==os_windows && scrNTTEFullSmokeEnabled() && scrFREnabled()
        && instance_exists(Player) && !instance_exists(GenCont),
        "Player wall regression requires the settled isolated NTUF runner");
    var _original_map=UberCont.saveData,_map=ds_map_create();
    ds_map_copy(_map,_original_map);UberCont.saveData=_map;
    _driver.fr_player_wall={world:scrNTTEFullWorldEventsNaturalWorldCapture(),
        original_map:_original_map,map_bytes:ds_map_write(_original_map),fixture_map:_map,
        phase:0,rate_index:0,form:0,scene_index:0,wait:0,rows:[],player:instance_find(Player,0),
        profiles:[
            ["recover-left",0,800000,800000,16],
            ["recover-seam",0,800000,800000,64],
            ["recover-negative",0,-800000,-800000,16],
            ["recover-fractional",0,800000.25,800000.5,16],
            ["recover-floor-tie",1,800000,800000,1],
            ["walk-left",2,800000,800000,80],
            ["slide-left",3,800000,800000,80],
            ["walk-seam",2,800000,800000,64],
            ["walk-negative",2,-800000,-800000,64],
            ["walk-fractional",2,800000.25,800000.5,64],
            ["roll-left",4,800000,800000,80],
            ["frog-left",5,800000,800000,80],
            ["hammer-right",6,800000,800000,88]],
        x:800000,y:800000,width:256,height:192};
}

function scrFRPlayerWallTestsPrepare(_state) {
    scrFRWallFixTestsReset(_state.world);
    GameCont.is_level_ended=true;
    var _profile=_state.profiles[_state.scene_index],_kind=_profile[1],
        _x=_profile[2],_y=_profile[3],_contact_y=_profile[4];
    _state.x=_x;_state.y=_y;_state.kind=_kind;_state.scene_name=_profile[0];
    // The nearest floor to the contacted LEFT tile is on the left. The
    // rectangle's remote centre is closer to the floor beyond its RIGHT edge.
    // Both representations have the same collision mask and floor geometry.
    var _left=instance_create(_x-32,_y+floor(_contact_y/32)*32,Floor),_far=noone;
    if(_kind==1) {
        _far=instance_create(_x+16,_y-16,Floor);
        // Read a REAL native tile's instance bbox. This runner's right and
        // bottom bounds differ from the inclusive sprite metadata bounds;
        // neither +7.5 nor +8 is hard-coded as the collision-centre oracle.
        var _reference=instance_create(_x+1024,_y,Wall),
            _cx=(_reference.bbox_left+_reference.bbox_right)/2-1024,
            _cy=(_reference.bbox_top+_reference.bbox_bottom)/2,
            _a=point_distance((_left.bbox_left+_left.bbox_right)/2,(_left.bbox_top+_left.bbox_bottom)/2,_cx,_cy),
            _b=point_distance((_far.bbox_left+_far.bbox_right)/2,(_far.bbox_top+_far.bbox_bottom)/2,_cx,_cy);
        instance_destroy(_reference,false);
        assert(_a==_b,"Equal-floor positive control was not exactly tied at the native instance bbox centre");
        _state.reference_center=[_cx,_cy];
    } else _far=instance_create(_x+256,_y+80,Floor);
    if(_state.form==0) {
        for(var _yy=0;_yy<192;_yy+=16) for(var _xx=0;_xx<256;_xx+=16)
            instance_create(_x+_xx,_y+_yy,Wall);
    } else scrNTTESolidWallBlock(_x,_y,256,192);
    if(_kind==1) {
        var _hit=collision_point(_x+1,_y+1,Wall,false,false),
            _contact=scrNTTESolidWallContact(_hit,_x+1,_y+1);
        assert(_contact[0]==_state.reference_center[0] && _contact[1]==_state.reference_center[1],
            "Packed contact centre differed from the same real 16px native tile's instance bbox centre");
    }
    var _player=instance_find(Player,0);_state.player=_player;
    with(_player) {
        // A small initial overlap models authored geometry being introduced
        // over an actor; it must recover to the adjacent floor without holes.
        x=_x+(_kind<=1?1:-24);y=_y+_contact_y;
        if(_kind==6) x=_x+256+12;
        xprevious=x;yprevious=y;
        mask_index=mskPlayer;image_xscale=1;image_yscale=1;
        race=Race.Venuz;roll=false;hammerhead=0;hammering=0;
        can_walk=false;can_aim=false;can_spec=false;can_shoot=false;bcan_shoot=false;
        speed=0;friction=0;maxspeed=4*timescale;ntte_player_physics_scale=timescale;angle=0;right=1;
        hp=10000;max_hp=10000;lsthealth=10000;nexthurt=current_frame+100000;
        if(_kind<=1) assert(place_meeting(x,y,Wall),
            "Player wall recovery control did not initially overlap its real wall mask");
        else assert(!place_meeting(x,y,Wall),
            "Player wall movement control did not start outside its real wall mask");
        if(_kind==4) {race=Race.Fish;roll=true;angle=1;direction=0;speed=6*timescale;}
        if(_kind==5) race=Race.Frog;
        if(_kind==6) {hammerhead=1;hammering=12;}
    }
    _state.wait=0;_state.phase=2;_state.elapsed=0;_state.bounced=false;
    _state.reached=false;_state.hammer_seen=false;
    _state.hammer_x=_x+248;_state.hammer_y=_y+88;
    scrFRPlayerWallTestsDrive(_state);
    scrNTTESmokeLog("FRONTIER PLAYER WALL scene "+json_stringify({rate:30/timescale,
        scene:_state.scene_name,form:_state.form==0?"tiles":"packed",start_x:_player.x,start_y:_player.y,
        wall_x:_x,wall_y:_y,wall_width:256,wall_height:192}));
}

function scrFRPlayerWallTestsDrive(_state) {
    var _kind=_state.kind;
    // Velocities are installed AFTER the observed EndStep; the next native
    // Player Step, friction, engine movement and collision remain scheduled.
    // Do not reapply a recovered position or manually invoke a wall callback.
    if(_kind<=1 || _kind==4 || (_kind==5 && _state.bounced)
        || (_kind==6 && _state.hammer_seen)) return;
    with(_state.player) {
        hspeed=(_kind==6?-4:4)*timescale;
        vspeed=(_kind==3?2:0)*timescale;
        if(_kind==6 && hammerhead>0) hammering=12;
    }
}

function scrFRPlayerWallTestsObserve(_state) {
    var _player=_state.player,_kind=_state.kind,_overlap=false;
    with(_player) _overlap=place_meeting(x,y,Wall);
    if(_player.hspeed<0) _state.bounced=true;
    if(_player.x>=_state.x-8 && _player.x<_state.x) _state.reached=true;
    if(_kind==6) {
        var _hammers=scrNTTEFullInstances(Hammerhead);
        if(array_length(_hammers)) {
            _state.hammer_seen=true;
            var _fx=_hammers[0];
            assert(_fx.x==_state.hammer_x && _fx.y==_state.hammer_y,
                "Scheduled Hammerhead effect used packed origin instead of its real right contact cell: "
                +json_stringify({form:_state.form,actual_x:_fx.x,actual_y:_fx.y,
                    expected_x:_state.hammer_x,expected_y:_state.hammer_y}));
            assert(position_meeting(_state.x+8,_state.y+8,Wall)
                && position_meeting(_state.x+8,_state.y+184,Wall),
                "Scheduled Hammerhead erased remote undamaged packed collision");
        }
    } else {
        assert(!_overlap && _player.x<_state.x,
            "Scheduled Player crossed/retained wall collision: "+json_stringify({scene:_state.scene_name,
                form:_state.form,x:_player.x-_state.x,y:_player.y-_state.y,overlap:_overlap}));
    }
    _state.elapsed+=timescale;
    return _kind<=1 || _state.elapsed>=18;
}

function scrFRPlayerWallTestsStep(_driver) {
    var _state=_driver.fr_player_wall;
    if(_state.phase==0) {
        var _rate=_state.rate_index==0?30:60;
        save_set_value("options","framerate",_rate);
        save_set_value("options","autopause",false);
        save_set_value("visual","freezeframes",0);
        scrOptionsUpdate();_state.wait=0;_state.phase=1;return false;
    }
    if(_state.phase==1) {
        _state.wait+=1;
        if(_state.wait<3) return false;
        assert(timescale==(_state.rate_index==0?1:0.5),
            "Player wall regression did not apply its real 30/60 Hz frame policy");
        scrFRPlayerWallTestsPrepare(_state);return false;
    }
    // This is an EndStep AFTER a full real Player Step, movement and engine
    // collision pass. Even a stationary overlap must recover naturally.
    if(!scrFRPlayerWallTestsObserve(_state)) {
        scrFRPlayerWallTestsDrive(_state);return false;
    }
    var _player=_state.player,_overlap=false;
    with(_player) _overlap=place_meeting(x,y,Wall);
    var _holes=0;
    for(var _yy=0;_yy<192;_yy+=16) for(var _xx=0;_xx<256;_xx+=16) {
        if(!position_meeting(_state.x+_xx+8,_state.y+_yy+8,Wall)) {_holes+=1;}
    }
    var _row={rate:30/timescale,scene:_state.scene_name,form:_state.form==0?"tiles":"packed",
        x:_player.x-_state.x,y:_player.y-_state.y,overlap:_overlap,holes:_holes,
        reached:_state.reached,bounced:_state.bounced,hammer:_state.hammer_seen};
    array_push(_state.rows,_row);scrNTTESmokeLog("FRONTIER PLAYER WALL observed "+json_stringify(_row));
    if(_state.kind==6) assert(_state.hammer_seen && _holes>0,
        "Scheduled Hammerhead never hit/broke its real contact cell: "+json_stringify(_row));
    else {
        assert(_holes==0,"Scheduled Player collision destroyed undamaged terrain: "+json_stringify(_row));
        if(_state.kind>=2 && _state.kind<=3) assert(_state.reached,
            "Scheduled walking control never actually reached the wall: "+json_stringify(_row));
        if(_state.kind==4 || _state.kind==5) assert(_state.bounced,
            "Scheduled roll/Frog control never actually bounced on the wall: "+json_stringify(_row));
    }
    _state.form+=1;
    if(_state.form<2) {scrFRPlayerWallTestsPrepare(_state);return false;}
    _state.form=0;
    _state.scene_index+=1;
    if(_state.scene_index<array_length(_state.profiles)) {scrFRPlayerWallTestsPrepare(_state);return false;}
    _state.scene_index=0;
    _state.rate_index+=1;
    if(_state.rate_index<2) {_state.phase=0;return false;}
    scrNTTEFullWorldEventsNaturalWorldRestore(_state.world);
    UberCont.saveData=_state.original_map;ds_map_destroy(_state.fixture_map);
    assert(ds_map_write(_state.original_map)==_state.map_bytes,
        "Player wall regression changed original permanent save bytes");
    scrNTTESmokeLog("PASS FRONTIER PLAYER WALL real tile/packed overlap/walk/slide/seam/negative/fractional/equal-floor/roll/Frog/Hammerhead at30/60Hz "+json_stringify(_state.rows));
    return true;
}

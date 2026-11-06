// Explicit isolated desktop regression. Only scene setup and sampled pick
// buttons are supplied here; the native engine schedules the actual Player
// exchange, WepPickup Step/movement/wall collision and subsequent re-pickup.
function scrFRGroundWeaponTestsStart(_driver) {
    assert(os_type==os_windows && scrNTTEFullSmokeEnabled() && scrFREnabled()
        && instance_exists(Player) && !instance_exists(GenCont),
        "Ground weapon regression requires the settled isolated NTUF runner");
    var _original_map=UberCont.saveData,_map=ds_map_create();
    ds_map_copy(_map,_original_map);UberCont.saveData=_map;
    _driver.fr_ground_weapon={world:scrNTTEFullWorldEventsNaturalWorldCapture(),
        original_map:_original_map,map_bytes:ds_map_write(_original_map),fixture_map:_map,
        phase:0,rate_index:0,form:0,wait:0,rows:[],player:instance_find(Player,0),
        incoming:noone,outgoing:noone,input_sent:false,x:810000,y:810000,seed:9181};
}

function scrFRGroundWeaponTestsAfterInputSample() {
    if(os_type!=os_windows || !scrNTTEFullSmokeEnabled()) return;
    var _driver=noone;
    with(FRIntegrationTest) if(variable_instance_exists(id,"fr_ground_weapon")) {_driver=id;break;}
    if(!instance_exists(_driver)) return;
    var _state=_driver.fr_ground_weapon;
    if(!instance_exists(_state.player)) return;
    var _pick=(_state.phase==2 || _state.phase==4) && !_state.input_sent;
    KeyCont.press_pick[_state.player.index]=_pick;
    KeyCont.press_swap[_state.player.index]=false;
    if(_pick) _state.input_sent=true;
}

function scrFRGroundWeaponTestsPrepare(_state) {
    scrFRWallFixTestsReset(_state.world);
    GameCont.is_level_ended=true;
    var _x=_state.x,_y=_state.y;
    for(var _yy=-32;_yy<256;_yy+=32) {
        instance_create(_x-64,_y+_yy,Floor);
        instance_create(_x-32,_y+_yy,Floor);
    }
    if(_state.form==1) {
        for(var _yy=0;_yy<192;_yy+=16) for(var _xx=0;_xx<256;_xx+=16)
            instance_create(_x+_xx,_y+_yy,Wall);
    } else if(_state.form==2) scrNTTESolidWallBlock(_x,_y,256,192);
    // Reset after constructing the alternative wall representation, so its
    // instance count cannot perturb either incoming or outgoing toss RNG.
    random_set_seed(_state.seed);
    var _player=instance_find(Player,0),_raw=global.fr_weapon_ids[$ "FR_TeminiteCannon"];
    _state.weapon_kind="lwo";
    if(_state.form==3) {_raw=wep_machinegun;_state.weapon_kind="original";}
    if(_state.form==4) {_raw=global.fr_weapon_ids[$ "FR_Blunderbuss"];_state.weapon_kind="ntuf";}
    if(_state.form==5) {
        _raw=scrNTTEFullWeaponNative(scrNTTEFullWeaponMerge(wep_revolver,
            {wep:global.fr_weapon_ids[$ "FR_Blunderbuss"]}));
        _state.weapon_kind="fusion";
    }
    _state.player=_player;
    with(_player) {
        x=_x-5;y=_y+160;xprevious=x;yprevious=y;
        mask_index=mskPlayer;image_xscale=1;image_yscale=1;
        race=Race.Venuz;roll=false;hammerhead=0;hammering=0;
        can_walk=false;can_aim=false;can_spec=false;can_shoot=false;bcan_shoot=false;can_pick=true;
        speed=0;friction=0;maxspeed=4*timescale;ntte_player_physics_scale=timescale;angle=0;right=1;
        hp=10000;max_hp=10000;lsthealth=10000;nexthurt=current_frame+100000;
        curse=false;bcurse=false;max_extra_weps=0;scrExtraWepsReset();
        wep=_raw;bwep=wep_revolver;
        ntte_state=scrNTTEFullWeaponIsNative(_raw)?scrNTTEFullWeaponNativeState(_raw):scrNTTENewState(_raw);
        bntte_state=scrNTTENewState(wep_revolver);
        fr_source_wep=undefined;fr_source_bwep=undefined;scrFRWeaponPrepare(_raw,true);
        assert(!place_meeting(x,y,Wall),"Ground weapon player fixture initially overlaps its wall");
    }
    _state.physical=_player.ntte_state;_state.physical.fr_ground_probe=9181;
    _state.source=scrFRWeaponSlotRead(_player,"wep");
    if(_state.weapon_kind=="lwo") _state.source.teminite=7;
    _state.incoming=scrWeaponPickupCreate(_x-5,_y+160,wep_shotgun);
    with(_state.incoming) {speed=0;autopick=false;visible=true;image_alpha=1;}
    _state.outgoing=noone;_state.phase=2;_state.elapsed=0;_state.input_sent=false;
    _state.row={rate:30/timescale,form:_state.form==1?"tiles":(_state.form==2?"packed":"floor"),
        weapon_kind:_state.weapon_kind,seed:_state.seed,
        incoming_x:_state.incoming.x-_x,incoming_y:_state.incoming.y-_y,
        player_x:_player.x-_x,player_y:_player.y-_y,swapped:false,existed:true,
        visible:true,overlap:false,repicked:false,source_preserved:false,
        physical_state_preserved:false,ground_copies:0,ground_after_repick:-1};
    scrNTTESmokeLog("FRONTIER GROUND WEAPON scene "+json_stringify(_state.row));
}

function scrFRGroundWeaponTestsFinishScene(_state) {
    var _row=_state.row;
    array_push(_state.rows,_row);
    scrNTTESmokeLog("FRONTIER GROUND WEAPON observed "+json_stringify(_row));
    _state.form+=1;
    if(_state.form<6) {scrFRGroundWeaponTestsPrepare(_state);return false;}
    _state.form=0;_state.rate_index+=1;
    if(_state.rate_index<2) {_state.phase=0;return false;}
    scrNTTEFullWorldEventsNaturalWorldRestore(_state.world);
    UberCont.saveData=_state.original_map;ds_map_destroy(_state.fixture_map);
    assert(ds_map_write(_state.original_map)==_state.map_bytes,
        "Ground weapon regression changed original permanent save bytes");
    for(var _i=0;_i<array_length(_state.rows);++_i) {
        var _result=_state.rows[_i];
        assert(_result.swapped && _result.existed && _result.visible && !_result.overlap
            && _result.repicked && _result.source_preserved && _result.physical_state_preserved
            && _result.ground_copies==1 && _result.ground_after_repick==0,
            "Natural manual ground exchange failed: "+json_stringify(_result));
        // The matched ordinary 16px-wall scene is the positive control. A
        // 28px pickup initially only overlaps its contacted lip by 10px, and
        // its ordinary small native toss settles within two tile widths.
        // A compact rectangle must not transport it to a remote wall edge.
        assert(_result.displacement<=32,
            "Natural ground pickup escaped through a remote packed-wall edge instead of its local native contact: "
            +json_stringify(_result));
    }
    scrNTTESmokeLog("PASS FRONTIER GROUND WEAPON natural same-seed floor/tile/packed manual drop, settling, collision and physical-source re-pickup at30/60Hz "+json_stringify(_state.rows));
    return true;
}

function scrFRGroundWeaponTestsStep(_driver) {
    var _state=_driver.fr_ground_weapon;
    if(_state.phase==0) {
        save_set_value("options","framerate",_state.rate_index==0?30:60);
        save_set_value("options","autopause",false);save_set_value("visual","freezeframes",0);
        scrOptionsUpdate();_state.wait=0;_state.phase=1;return false;
    }
    if(_state.phase==1) {
        _state.wait+=1;if(_state.wait<3) return false;
        assert(timescale==(_state.rate_index==0?1:0.5),
            "Ground weapon regression did not apply actual 30/60 Hz frame policy");
        scrFRGroundWeaponTestsPrepare(_state);return false;
    }
    _state.elapsed+=timescale;
    var _player=_state.player,_row=_state.row;
    if(_state.phase==2) {
        if(instance_exists(_state.incoming)) {
            assert(_state.elapsed<12,"Natural manual pickup did not exchange the scene's real incoming weapon");
            return false;
        }
        _row.swapped=_player.wep==wep_shotgun;
        with(WepPickup) if((self[$ "ntte_state"]??undefined)==_state.physical) {
            _state.outgoing=id;_row.ground_copies+=1;
        }
        assert(_row.swapped && instance_exists(_state.outgoing) && _row.ground_copies==1,
            "Natural manual exchange did not create its actual outgoing physical weapon: "+json_stringify(_row));
        _row.drop_x=_state.outgoing.x-_state.x;_row.drop_y=_state.outgoing.y-_state.y;
        _state.phase=3;_state.elapsed=0;return false;
    }
    if(_state.phase==3) {
        var _drop=_state.outgoing;
        if(!instance_exists(_drop)) {_row.existed=false;return scrFRGroundWeaponTestsFinishScene(_state);}
        _row.visible=_row.visible && _drop.visible && _drop.image_alpha>0;
        if(_state.elapsed<24) return false;
        var _overlap=false;with(_drop) _overlap=place_meeting(x,y,Wall);
        _row.x=_drop.x-_state.x;_row.y=_drop.y-_state.y;_row.speed=_drop.speed;
        _row.displacement=point_distance(_row.drop_x,_row.drop_y,_row.x,_row.y);
        _row.overlap=_overlap;
        _row.physical_state_preserved=_drop.ntte_state==_state.physical && _state.physical.fr_ground_probe==9181;
        _row.ground_copies=0;
        with(WepPickup) if((self[$ "ntte_state"]??undefined)==_state.physical) _row.ground_copies+=1;
        _row.source_preserved=scrFRWeaponSlotRead(_drop,"wep")==_state.source
            && (_state.weapon_kind!="lwo" || _state.source.teminite==7);
        // Move only the observer-controlled player to the closest legal
        // ground position. Never move/recreate the outgoing pickup to make
        // it accessible, and never invoke its Collision_Wall by hand.
        _player.x=(_state.form==1 || _state.form==2)?min(_drop.x,_state.x-5):_drop.x;_player.y=_drop.y;
        _player.xprevious=_player.x;_player.yprevious=_player.y;_player.speed=0;
        var _player_overlap=false;with(_player) _player_overlap=place_meeting(x,y,Wall);
        assert(!_player_overlap,"Re-pickup observer placement entered solid wall terrain");
        _state.phase=4;_state.elapsed=0;_state.input_sent=false;return false;
    }
    if(!instance_exists(_state.outgoing)) {
        _row.repicked=scrFRWeaponSlotRead(_player,"wep")==_state.source
            && (_state.weapon_kind!="lwo" || _state.source.teminite==7);
        _row.physical_state_preserved=_row.physical_state_preserved
            && _player.ntte_state==_state.physical && _state.physical.fr_ground_probe==9181;
        _row.ground_after_repick=0;
        with(WepPickup) if((self[$ "ntte_state"]??undefined)==_state.physical) _row.ground_after_repick+=1;
        return scrFRGroundWeaponTestsFinishScene(_state);
    }
    if(_state.elapsed>=8) return scrFRGroundWeaponTestsFinishScene(_state);
    return false;
}

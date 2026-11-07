// Real scheduled crush-trap movement and native wall collisions. The fixture
// places a player to trigger authored detection; it never assigns trap speed
// or calls its launch/collision callbacks directly.
function scrFRPalaceBlockTestsStart(_driver) {
    assert(os_type==os_windows && scrNTTEFullSmokeEnabled() && scrFREnabled()
        && instance_exists(Player) && !instance_exists(GenCont),
        "Palace block regression requires the settled isolated native runner");
    _driver.fr_palace_blocks={world:scrNTTEFullWorldEventsNaturalWorldCapture(),
        phase:0,rate:0,scene:0,wait:0,elapsed:0,rows:[],block:noone,player:noone,
        // Match ordinary generated Palace trap centres and wall tiles: the
        // source's stop snap is defined on the native 16-pixel map grid.
        enemy:noone,prop:noone,x:824992,y:824992};
}

function scrFRPalaceBlockTestsPrepare(_state) {
    scrFRWallFixTestsReset(_state.world);
    GameCont.area=area_palace;GameCont.is_level_ended=true;
    var _x=_state.x,_y=_state.y;
    for(var _yy=-64;_yy<=256;_yy+=32)
        for(var _xx=-64;_xx<=320;_xx+=32) instance_create(_x+_xx,_y+_yy,Floor);
    var _player=instance_find(Player,0);_state.player=_player;
    with(_player) {
        x=_x+(_state.scene==0?224:80);y=_y;xprevious=x;yprevious=y;
        mask_index=mskPlayer;image_xscale=1;image_yscale=1;
        race=Race.Venuz;roll=false;hammerhead=0;hammering=0;
        can_walk=false;can_aim=false;can_spec=false;can_shoot=false;bcan_shoot=false;
        speed=0;friction=0;hp=10000;max_hp=10000;nexthurt=current_frame+100000;
    }
    _state.wall=noone;_state.enemy=noone;_state.prop=noone;
    if(_state.scene>0) {
        for(var _i=-2;_i<=2;++_i) {
            var _wall=instance_create(_x+144,_y+16*_i,Wall);
            if(_i==0) _state.wall=_wall;
        }
        _state.prop=instance_create(_x+32,_y,FRCustomProp);
        _state.prop.sprite_index=sprBarrel;_state.prop.mask_index=sprBarrel;
        _state.prop.spr_idle=sprBarrel;_state.prop.spr_hurt=-1;
        _state.prop.max_hp=100;_state.prop.hp=100;
        if(_state.scene==2) {
            // An L-shaped pocket tests a grazing side contact as the victim
            // is pushed toward the front wall, not only a centred flat hit.
            instance_create(_x+112,_y+16,Wall);
            instance_create(_x+128,_y+16,Wall);
            _state.enemy=instance_create(_x+88,_y,FRCustomEnemy);
            _state.enemy.sprite_index=sprBanditIdle;_state.enemy.mask_index=mskBandit;
            _state.enemy.max_hp=1000;_state.enemy.hp=1000;_state.enemy.can_die=true;
            _state.enemy.speed=0;_state.enemy.friction=0;
        }
    }
    _state.block=scrFRModCallArray("mod","Frontier_Palace","CrushBlock_create",[_x,_y]);
    var _block=_state.block;
    assert(instance_exists(_block) && _block.crushspeed==6 && _block.damage==8 && _block.damage_enemy==30,
        "Palace fixture changed the actual source speed or authored player/enemy crush damage");
    _block.moveCooldown=0;_block.myWallGetReal=0;
    _block.fr_palace_test_driver=FRIntegrationTest.id;
    _state.row={rate:30/timescale,scene:_state.scene==0?"open":(_state.scene==1?"wall-prop":"corner-enemy"),
        start_x:_x,start_y:_y,launched:false,alive:true,proxy_alive:true,proxy_synced:true,
        physical_frames:0,maximum_x:_x,displacement:0,enemy_hp:1000,prop_destroyed:false,
        smush_created:0,smush_target_overlap:false,smush_hits:0,smush_damage:0,
        smush_team:0,enemy_team:0,enemy_x:0,enemy_y:0};
    _state.smush_seen={};
    _state.phase=2;_state.elapsed=0;
}

function scrFRPalaceBlockTestsObserve(_block) {
    var _driver=_block[$ "fr_palace_test_driver"]??noone;
    if(!instance_exists(_driver) || !variable_instance_exists(_driver,"fr_palace_blocks")) return;
    var _state=_driver.fr_palace_blocks,_row=_state.row;
    if(_state.block!=_block) return;
    _row.physical_frames+=1;
    _row.maximum_x=max(_row.maximum_x,_block.x);
    _row.displacement=_block.x-_row.start_x;
    if(instance_exists(_state.enemy)) {
        _row.enemy_hp=_state.enemy.hp;_row.enemy_x=_state.enemy.x;_row.enemy_y=_state.enemy.y;
    }
    with(FRCustomProjectile) if(creator==_block && (self[$ "fr_palace_smush"]??false)) {
        var _key=string(real(id));
        if(!(_state.smush_seen[$ _key]??false)) {
            _state.smush_seen[$ _key]=true;_row.smush_created++;
        }
        if(instance_exists(_state.enemy))
            _row.smush_target_overlap=_row.smush_target_overlap || place_meeting(x,y,_state.enemy);
    }
    if(_block.myWallisReal) {
        _row.proxy_alive=_row.proxy_alive && instance_exists(_block.mywall);
        if(instance_exists(_block.mywall)) {
            _row.proxy_synced=_row.proxy_synced
                && abs(_block.mywall.x-_block.x)<0.0001 && abs(_block.mywall.y-_block.y)<0.0001;
            assert(scrFRPalaceBlockProxy(_block.mywall),"Moving wall lost its native duplicate-culling exemption");
        }
    }
}

function scrFRPalaceBlockTestsSmushHit(_smush,_target,_before) {
    var _block=_smush.creator;
    if(!instance_exists(_block)) return;
    var _driver=_block[$ "fr_palace_test_driver"]??noone;
    if(!instance_exists(_driver) || !variable_instance_exists(_driver,"fr_palace_blocks")) return;
    var _state=_driver.fr_palace_blocks;
    if(_target!=_state.enemy) return;
    _state.row.smush_hits++;
    _state.row.smush_damage+=_before-(instance_exists(_target)?_target.hp:0);
    _state.row.smush_team=_smush.team;_state.row.enemy_team=_target.team;
}

function scrFRPalaceBlockTestsFinish(_state) {
    var _row=_state.row;
    _row.alive=instance_exists(_state.block);
    _row.prop_destroyed=_state.scene==0 || !instance_exists(_state.prop);
    if(instance_exists(_state.enemy)) _row.enemy_hp=_state.enemy.hp;
    assert(_row.launched && _row.alive && _row.proxy_alive && _row.proxy_synced && _row.physical_frames>0,
        "Palace trap failed real launch, survival or every-host-frame proxy synchronization: "+json_stringify(_row));
    if(_state.scene==0)
        assert(abs(_row.displacement-180)<=12,
            "Palace trap no longer moves at original six pixels per 30Hz source second: "+json_stringify(_row));
    else {
        assert(_row.maximum_x>_row.start_x+24 && _row.maximum_x<_row.start_x+144
            && _row.prop_destroyed && instance_exists(_state.wall),
            "Palace trap contact deleted the trap/static wall or failed to crush the authored prop: "+json_stringify(_row));
        if(_state.scene==2)
            assert(_row.enemy_hp==970 && _row.smush_hits==1 && _row.smush_damage==30,
                "Palace trap failed its real scheduled enemy crush damage exactly once: "+json_stringify(_row));
    }
    // The completed row is retained by reference. Stop its instrumentation
    // before rate switching allows more physical frames on the old block.
    _state.block.fr_palace_test_driver=noone;
    array_push(_state.rows,_row);scrNTTESmokeLog("NTUF PALACE BLOCK "+json_stringify(_row));
    _state.scene++;
    if(_state.scene<3) {scrFRPalaceBlockTestsPrepare(_state);return false;}
    _state.scene=0;_state.rate++;
    if(_state.rate<2) {_state.phase=0;return false;}
    scrNTTEFullWorldEventsNaturalWorldRestore(_state.world);
    scrNTTESmokeLog("PASS NTUF PALACE authored detection, 6px source velocity, real wall/prop/enemy collision and per-frame solid-wall synchronization at30/60Hz "+json_stringify(_state.rows));
    return true;
}

function scrFRPalaceBlockTestsStep(_driver) {
    var _state=_driver.fr_palace_blocks;
    if(_state.phase==0) {
        save_set_value("options","framerate",_state.rate==0?30:60);
        save_set_value("options","autopause",false);save_set_value("visual","freezeframes",0);
        scrOptionsUpdate();_state.wait=0;_state.phase=1;return false;
    }
    if(_state.phase==1) {
        if(++_state.wait<3) return false;
        assert(timescale==(_state.rate==0?1:0.5),"Palace block fixture did not apply native30/60Hz timing");
        scrFRPalaceBlockTestsPrepare(_state);return false;
    }
    _state.elapsed+=timescale;
    assert(instance_exists(_state.block),"Palace trap was destroyed by ordinary native scenery contact");
    if(_state.phase==2) {
        if(!_state.block.active) {
            assert(_state.elapsed<10,"Authored Palace trap did not launch toward its aligned player");
            return false;
        }
        assert(abs(_state.block.speed-6*timescale)<0.0001,
            "Palace trap launch lost its authored scaled speed");
        _state.row.launched=true;_state.elapsed=0;_state.phase=3;
        _state.row.start_x=_state.block.x;
        // Detection has happened. Move the invulnerable trigger player away
        // so the wall/enemy contact is the only measured collision.
        _state.player.y=_state.y+1000;_state.player.yprevious=_state.player.y;
        return false;
    }
    if(_state.elapsed>=(_state.scene==0?30:60)) return scrFRPalaceBlockTestsFinish(_state);
    return false;
}

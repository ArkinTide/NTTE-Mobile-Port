// Controlled standalone initial Trench2 only; native2->3 and native binary Trench3 continuation.
// NOT the frozen Fish1->2 continued chain. No Boss victory/City/final rewards claim.
// Parrot A ownership is an explicit initial prerequisite; no final reward is granted.
// Legal initial equipment/XP suppression are explicit; all later HP/ammo,
// enemy damage, AI, generation, clear, portals and continuation are native.
function scrNTTEFullTrenchSecondHopFileRead(_path) {
    return file_exists(_path)?buffer_load(_path):-1
}
function scrNTTEFullTrenchSecondHopFileSame(_path,_before) {
    if(_before<0) return !file_exists(_path);
    if(!file_exists(_path)) return false;
    var _after=buffer_load(_path),_same=buffer_get_size(_before)==buffer_get_size(_after)
    if(_same) for(var _i=0;_i<buffer_get_size(_before);++_i)
        if(buffer_peek(_before,_i,buffer_u8)!=buffer_peek(_after,_i,buffer_u8)) {_same=false;break;}
    buffer_delete(_after);return _same
}
function scrNTTEFullTrenchSecondHopClear() {
    var _keep=id
    with(all) if(id!=_keep && object_index!=UberCont && object_index!=Console) instance_destroy(id,false)
}
function scrNTTEFullTrenchSecondHopRestore() {
    if(restored) return;
    restored=true
    var _unchanged=ds_map_write(old_save_map)==old_savedata
    for(var _i=0;_i<array_length(original_files);++_i)
        _unchanged=_unchanged && scrNTTEFullTrenchSecondHopFileSame(original_files[_i].path,original_files[_i].bytes)
    scrNTTEFullTrenchSecondHopClear()
    if(path_exists(bot_path)) path_delete(bot_path)
    scrNTTEFullAreaGeneratorRestore(old_global_graph)
    for(var _i=0;_i<array_length(old_global_vars);++_i)
        variable_global_set(old_global_vars[_i][0],old_global_vars[_i][1])
    scrNTTEFullAreaGeneratorRestore(old_uber);UberCont.saveData=old_save_map
    if(ds_exists(fixture_save_map,ds_type_map)) ds_map_destroy(fixture_save_map)
    game_set_speed(old_game_speed,gamespeed_fps);game_directory=old_directory
    global.ntte_smoke_active=old_smoke;current_frame=old_clock
    // This is the existing reserved smoke binary, never the user's binary.
    if(old_smoke_continue>=0) {buffer_save(old_smoke_continue,savegame_file);buffer_delete(old_smoke_continue)}
    else if(file_exists(savegame_file)) file_delete(savegame_file)
    for(var _i=0;_i<array_length(scratch_files);++_i)
        if(file_exists(scratch_files[_i])) file_delete(scratch_files[_i])
    for(var _i=0;_i<array_length(original_files);++_i) {
        assert(scrNTTEFullTrenchSecondHopFileSame(original_files[_i].path,original_files[_i].bytes),"Trench campaign changed a read-only original physical file")
        if(original_files[_i].bytes>=0) buffer_delete(original_files[_i].bytes)
    }
    random_set_seed(old_seed)
    assert(_unchanged && ds_map_write(old_save_map)==old_savedata,"Trench campaign changed original save/options storage")
    instance_deactivate_object(UberCont)
}
function scrNTTEFullTrenchSecondHopConnectedTests() {
    assert(os_type==os_windows && scrNTTEFullSmokeEnabled() && scrNTTESmokeEnabled(),"Trench campaign requires a dedicated desktop smoke process")
    assert(savegame_file==working_directory+"smoke-save/savegame.dat","Trench campaign binary must use the reserved smoke path")
    assert(!instance_exists(NTTEFullTrenchSecondHopConnectedTest),"Duplicate Trench campaign observer")
    var _observer=instance_create(0,0,NTTEFullTrenchSecondHopConnectedTest)
    with(_observer) {
        restored=false;old_global_vars=[];scratch_files=[];original_files=[]
        old_directory=game_directory;old_smoke=global.ntte_smoke_active
        old_smoke_continue=scrNTTEFullTrenchSecondHopFileRead(savegame_file)
        old_seed=random_get_seed();old_game_speed=game_get_speed(gamespeed_fps);old_clock=current_frame
        old_save_map=UberCont.saveData;old_savedata=ds_map_write(old_save_map)
        old_uber=scrNTTEFullAreaGeneratorSnapshot(UberCont)
        var _names=variable_struct_get_names(global),_graph={nodes:[]}
        for(var _i=0;_i<array_length(_names);++_i) {
            var _name=_names[_i],_value=variable_global_get(_name)
            array_push(old_global_vars,[_name,_value]);scrNTTEFullAreaSnapshotContainer(_value,_graph)
        }
        old_global_graph={instances:[],containers:_graph.nodes}
        var _paths=[working_directory+"savegame.dat",old_directory+"ntte-full-progress.json",old_directory+"NuclearThrone.sav"]
        for(var _i=0;_i<array_length(_paths);++_i)
            array_push(original_files,{path:_paths[_i],bytes:scrNTTEFullTrenchSecondHopFileRead(_paths[_i])})
        fixture_save_map=ds_map_create();ds_map_copy(fixture_save_map,old_save_map);UberCont.saveData=fixture_save_map
        scratch_root=working_directory+"trench-connected-campaign-"+string(get_timer())+"/";directory_create(scratch_root)
        rates=[30,60];pass_index=0;phase=0;elapsed=0;draw_frames=0;world_ready_draw=-1;next_diagnostic=120
        current_seed=701932;room_ends=0;room_starts=0;bot_path=path_add();player=noone;portal=noone
        bot_was_fire=false;bot_target=noone;bot_path_clock=0;bot_path_cursor=0
        smoke_drivers=scrNTTEFullInstances(NTTESmokeTest)
        with(NTTESmokeTest) instance_deactivate_object(id)
        global.ntte_smoke_active=false;scrNTTEFullTrenchSecondHopClear()
    }
}
function scrNTTEFullTrenchSecondHopAwait(_phase) {phase=_phase;elapsed=0;world_ready_draw=-1;next_diagnostic=120}
function scrNTTEFullTrenchSecondHopWorldReady() {
    if(instance_exists(GenCont) || instance_exists(FloorMaker)) {world_ready_draw=-1;return false;}
    if(world_ready_draw<0) {world_ready_draw=draw_frames;return false;}
    return draw_frames-world_ready_draw>=8
}
function scrNTTEFullTrenchSecondHopRate(_where) {
    assert(game_get_speed(gamespeed_fps)==rates[pass_index] && timescale==30/rates[pass_index]
        && UberCont.opt_framerate==rates[pass_index] && !UberCont.opt_autopause
        && UberCont.saveData==fixture_save_map && ds_map_write(old_save_map)==old_savedata
        && save_get_value("options","framerate",-1)==rates[pass_index]
        && !save_get_value("options","autopause",true),"Trench campaign native rate/options isolation changed at "+_where)
}
function scrNTTEFullTrenchSecondHopHostiles() {
    var _count=0
    with(enemy) if(hp>0 && team!=team_player && !instance_is(id,Van) && !instance_is(id,BigDogMissile)) _count++
    return _count
}
function scrNTTEFullTrenchSecondHopFireBefore(_weapon) {
    var _o=instance_find(NTTEFullTrenchSecondHopConnectedTest,0)
    if(!instance_exists(_o) || _o.restored || _o.phase!=2 || id!=_o.player) return undefined;
    assert((_weapon==wep_auto_crossbow || _weapon==wep_minigun) && infammo==0 && !global.__debug_infammo,"Trench bot changed its legal initial weapon/ammo contract")
    return {weapon:_weapon,before:scrNTTEFullInstances([Bolt,Bullet1]),ammo:ammo[scr_weapon_get_type(_weapon)]}
}
function scrNTTEFullTrenchSecondHopFireDiagnostic(_sample,_shots,_new) {
    var _observer=instance_find(NTTEFullTrenchSecondHopConnectedTest,0),_player=id,_rows=[],_sources=[],_bursts=[]
    for(var _i=0;_i<array_length(_shots);++_i) {
        var _shot=_shots[_i]
        if(!instance_exists(_shot)) continue
        array_push(_rows,{id:_shot,object:_shot.object_index,name:object_get_name(_shot.object_index),
            creator:scrNTTEFullValue(_shot,"creator","<absent>"),
            creator_type:typeof(scrNTTEFullValue(_shot,"creator",undefined)),
            creator_matches:scrNTTEFullValue(_shot,"creator",noone)==_player,
            in_before:array_get_index(_sample.before,_shot)>=0,
            xy:[_shot.x,_shot.y],speed:_shot.speed,damage:scrNTTEFullValue(_shot,"damage","<absent>"),
            team:scrNTTEFullValue(_shot,"team","<absent>")})
    }
    var _projectiles=scrNTTEFullInstances(projectile)
    for(var _i=0;_i<array_length(_projectiles);++_i) {
        var _shot=_projectiles[_i]
        if(!instance_exists(_shot) || scrNTTEFullValue(_shot,"creator",noone)!=_player) continue
        array_push(_sources,{id:_shot,object:_shot.object_index,name:object_get_name(_shot.object_index),
            xy:[_shot.x,_shot.y],speed:_shot.speed,damage:scrNTTEFullValue(_shot,"damage","<absent>"),
            in_before:array_get_index(_sample.before,_shot)>=0})
    }
    with(projectileburst) array_push(_bursts,{id:id,object:object_index,
        creator:scrNTTEFullValue(id,"creator","<absent>"),
        weapon:string(scrNTTEFullValue(id,"wep","<absent>")),
        xy:[x,y],alarm0:alarm[0]})
    scrNTTESmokeLog("TRENCH FIRE AFTER READONLY "+json_stringify({frame:current_frame,
        rate:instance_exists(_observer)?_observer.rates[_observer.pass_index]:-1,
        phase:instance_exists(_observer)?_observer.phase:-1,elapsed:instance_exists(_observer)?_observer.elapsed:-1,
        caller:_player,caller_object:object_index,caller_xy:[x,y],hp:hp,max_hp:max_hp,
        sample_weapon:_sample.weapon,current_weapon:wep,backup_weapon:bwep,
        sample_ammo:_sample.ammo,current_ammo:ammo[scr_weapon_get_type(_sample.weapon)],ammo_array:ammo,
        expected_type:scr_weapon_get_type(_sample.weapon),expected_cost:scr_weapon_get_cost(_sample.weapon),
        expected_reload:scr_weapon_get_load(_sample.weapon),reload:reload,can_shoot:can_shoot,
        clicked:clicked,gunangle:gunangle,infammo:infammo,debug_infammo:global.__debug_infammo,
        hold_fire:KeyCont.hold_fire[index],press_fire:KeyCont.press_fire[index],
        new_owned_count:_new,before_ids:_sample.before,after_ids:_shots,projectile_rows:_rows,
        owned_projectile_rows:_sources,burst_rows:_bursts,
        merged_input:variable_global_exists("ntte_full_merged_input_weapon")?string(variable_global_get("ntte_full_merged_input_weapon")):"<absent>",
        merged_depth:variable_global_exists("ntte_full_merged_plain_depth")?variable_global_get("ntte_full_merged_plain_depth"):"<absent>"}))
}
// END TRENCH FIRE AFTER PURE READONLY DIAGNOSTIC
function scrNTTEFullTrenchSecondHopFireAfter(_sample) {
    if(!is_struct(_sample)) return;
    var _o=instance_find(NTTEFullTrenchSecondHopConnectedTest,0)
    if(!instance_exists(_o) || _o.restored || _o.phase!=2 || id!=_o.player) return;
    var _shots=scrNTTEFullInstances([Bolt,Bullet1]),_new=0
    for(var _i=0;_i<array_length(_shots);++_i) {
        var _shot=_shots[_i]
        if(array_get_index(_sample.before,_shot)>=0 || _shot.creator!=id) continue
        var _bolt=_sample.weapon==wep_auto_crossbow
        assert(_shot.object_index==(_bolt?Bolt:Bullet1) && _shot.damage==(_bolt?20:3)
            && _shot.speed>0 && point_distance(_shot.x,_shot.y,x,y)<40,"Trench combat changed original muzzle projectile damage/motion")
        array_push(_o.native_shots,{shot:_shot,x:_shot.x,y:_shot.y,damage:_shot.damage});_new++
    }
    if(_new==0 && ammo[scr_weapon_get_type(_sample.weapon)]!=_sample.ammo)
        scrNTTEFullTrenchSecondHopFireDiagnostic(_sample,_shots,_new)
    if(_new==0) {assert(ammo[scr_weapon_get_type(_sample.weapon)]==_sample.ammo,"Native no-shot attempt consumed Trench ammo");return;}
    assert(_new==1 && ammo[scr_weapon_get_type(_sample.weapon)]==_sample.ammo-scr_weapon_get_cost(_sample.weapon)
        && reload==scr_weapon_get_load(_sample.weapon) && !can_shoot,"Trench native ammo/reload bypass")
    _o.shot_count++;_o.ammo_spent+=scr_weapon_get_cost(_sample.weapon)
}
function scrNTTEFullTrenchSecondHopBulletBefore(_target) {
    var _o=instance_find(NTTEFullTrenchSecondHopConnectedTest,0)
    if(!instance_exists(_o) || _o.restored || _o.phase!=2 || creator!=_o.player
        || !instance_exists(_target) || !instance_is(_target,enemy) || _target.team==team) return undefined;
    var _record=undefined
    for(var _i=0;_i<array_length(_o.native_shots);++_i) if(_o.native_shots[_i].shot==id) {_record=_o.native_shots[_i];break;}
    assert(is_struct(_record) && damage==_record.damage && point_distance(x,y,_record.x,_record.y)>1,"Trench native enemy hit lacks original moving projectile provenance")
    return {target:_target,hp:_target.hp}
}
function scrNTTEFullTrenchSecondHopBulletAfter(_sample) {
    if(!is_struct(_sample)) return;
    var _o=instance_find(NTTEFullTrenchSecondHopConnectedTest,0)
    if(!instance_exists(_o) || _o.restored || _o.phase!=2) return;
    var _loss=instance_exists(_sample.target)?_sample.hp-_sample.target.hp:_sample.hp
    if(_loss>0) {_o.native_hits++;_o.native_damage+=_loss}
}
function scrNTTEFullTrenchSecondHopImportedPlayerAssert(_player,_where) {
    assert(instance_exists(_player) && _player.id!=saved_player && _player.race==NTTEFullRace.Parrot
        && _player.hp==saved_hp && _player.max_hp==saved_max_hp
        && _player.wep==saved_wep && _player.bwep==saved_bwep,
        "Trench3 native continuation changed saved original HP/loadout at "+_where)
    assert(array_length(_player.ammo)==array_length(saved_ammo),"Trench3 imported ammo shape changed")
    for(var _i=0;_i<array_length(saved_ammo);++_i)
        assert(_player.ammo[_i]==saved_ammo[_i],"Trench3 native continuation changed finite saved ammo at "+_where)
}
// BEGIN NTTE TRENCH SECOND HOP MOVEMENT DODGE HELPERS
// Fixture movement prediction only. No actor/input/world setters are used.
// Approximation: current momentum/friction; native pit drift/recoil/future AI are not replayed.
// Fixture-only actual Player masks. Trench pit Floor is legal Floor;
// no pit-grid substitution, actor movement, wall removal or native setters.
function scrNTTEFullTrenchSecondHopTarget() {
    var _best=infinity,_next=noone,_hidden=noone,_hidden_distance=infinity
    with(enemy) if(hp>0 && team!=other.player.team && !instance_is(id,Van) && !instance_is(id,BigDogMissile)) {
        var _distance=point_distance(x,y,other.player.x,other.player.y)
        if(visible && mask_index!=mskNone) {if(_distance<_best) {_best=_distance;_next=id}}
        else if(_distance<_hidden_distance) {_hidden_distance=_distance;_hidden=id}
    }
    return instance_exists(_next)?_next:_hidden
}
// BEGIN NTTE TRENCH SECOND HOP VERIFIED INPUT HELPERS
// Fixture movement prediction only. No actor/input/world setters are used.
// Approximation: current momentum/friction; native pit drift/recoil/future AI are not replayed.
// Fixture-only actual Player masks. Trench pit Floor is legal Floor;
// no pit-grid substitution, actor movement, wall removal or native setters.
function scrNTTETrenchSecondHopDodgePoint(_x,_y,_budget) {
    if(_budget.remaining<=0) {_budget.exhausted=true;return false;}
    _budget.remaining--;_budget.samples++
    var _wall=false,_floor=false
    with(player) {_wall=place_meeting(_x,_y,Wall);_floor=place_meeting(_x,_y,Floor)}
    return !_wall && _floor;
}
function scrNTTETrenchSecondHopDodgeSegment(_x1,_y1,_x2,_y2,_budget) {
    var _steps=max(1,ceil(point_distance(_x1,_y1,_x2,_y2)/2))
    for(var _i=0;_i<=_steps;++_i)
        if(!scrNTTETrenchSecondHopDodgePoint(lerp(_x1,_x2,_i/_steps),lerp(_y1,_y2,_i/_steps),_budget)) return false;
    return true;
}
function scrNTTETrenchSecondHopDodgeThreats() {
    var _out={complete:true,threats:[],explosions:0,vents:0,vent_sources:[]},_projectiles=instance_number(projectile),_explosions=instance_number(Explosion),_vents=instance_number(NTTEFullVent),
        _warnings=instance_number(HitWarning),_assassins=instance_number(MeleeBandit)
    if(_projectiles>256 || _explosions+_vents>64 || _warnings>64 || _assassins>64) {_out.complete=false;return _out;}
    for(var _i=0;_i<_projectiles;++_i) {
        var _actor=instance_find(projectile,_i)
        if(!instance_exists(_actor) || !_actor.visible || _actor.mask_index==mskNone
            || !variable_instance_exists(_actor,"team") || _actor.team==player.team
            || !variable_instance_exists(_actor,"damage") || _actor.damage<=0) continue;
        var _gap_x=max(_actor.bbox_left-player.bbox_right,player.bbox_left-_actor.bbox_right),
            _gap_y=max(_actor.bbox_top-player.bbox_bottom,player.bbox_top-_actor.bbox_bottom)
        if(max(_gap_x,_gap_y)>128) continue;
        array_push(_out.threats,{actor:_actor,warning:false,explosion:false,x:_actor.x,y:_actor.y,
            vx:_actor.hspeed,vy:_actor.vspeed,box:[_actor.bbox_left,_actor.bbox_top,_actor.bbox_right,_actor.bbox_bottom],
            slash:instance_is(_actor,EnemySlash)})
        if(array_length(_out.threats)>32) {_out.complete=false;return _out;}
    }
    // Explosion is a sibling of projectile, not part of that enumeration.
    // Source mskExplosion/Small have alpha only at frame1. Collect frame0 too
    // so ordinary walking can start before its already-visible damage phase.
    for(var _i=0;_i<_explosions;++_i) {
        var _actor=instance_find(Explosion,_i)
        if(!instance_exists(_actor) || !_actor.visible || _actor.team==player.team
            || _actor.damage<=0 || _actor.image_index<0 || _actor.image_index>=2
            || (_actor.mask_index!=mskExplosion && _actor.mask_index!=mskSmallExplosion)) continue;
        var _gap_x=max(_actor.bbox_left-player.bbox_right,player.bbox_left-_actor.bbox_right),
            _gap_y=max(_actor.bbox_top-player.bbox_bottom,player.bbox_top-_actor.bbox_bottom)
        if(max(_gap_x,_gap_y)>128) continue;
        array_push(_out.threats,{actor:_actor,warning:false,explosion:true,x:_actor.x,y:_actor.y,
            vx:_actor.hspeed,vy:_actor.vspeed,box:[_actor.bbox_left,_actor.bbox_top,_actor.bbox_right,_actor.bbox_bottom],
            slash:false,animation_index:_actor.image_index,image_rate:_actor.image_speed,
            mask_active_now:_actor.image_index>=1 && _actor.image_index<2})
        _out.explosions++
        if(array_length(_out.threats)>32) {_out.complete=false;return _out;}
    }
    // Potential Vent danger is planning geometry, never an actual damage phase.
    // Source Vent_death unconditionally creates large Bubble. Its native mask
    // edges plus original constructor jitter2 define these conservative bounds.
    for(var _i=0;_i<_vents;++_i) {
        var _actor=instance_find(NTTEFullVent,_i)
        if(!instance_exists(_actor) || !_actor.visible) continue;
        var _box=[_actor.x+sprite_get_bbox_left(mskExplosion)-sprite_get_xoffset(mskExplosion)-2,
            _actor.y+sprite_get_bbox_top(mskExplosion)-sprite_get_yoffset(mskExplosion)-2,
            _actor.x+sprite_get_bbox_right(mskExplosion)+1-sprite_get_xoffset(mskExplosion)+2,
            _actor.y+sprite_get_bbox_bottom(mskExplosion)+1-sprite_get_yoffset(mskExplosion)+2],
            _gap_x=max(_box[0]-player.bbox_right,player.bbox_left-_box[2]),
            _gap_y=max(_box[1]-player.bbox_bottom,player.bbox_top-_box[3])
        if(max(_gap_x,_gap_y)>128) continue;
        array_push(_out.threats,{actor:_actor,warning:false,explosion:false,vent_potential:true,
            x:_actor.x,y:_actor.y,vx:0,vy:0,box:_box,slash:false})
        array_push(_out.vent_sources,{id:_actor,hp:_actor.hp,xy:[_actor.x,_actor.y],potential_box:_box})
        _out.vents++
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
            array_push(_out.threats,{actor:_actor,warning:true,explosion:false,x:_actor.x,y:_actor.y,
                vx:_actor.hspeed,vy:_actor.vspeed,box:[],slash:true})
            if(array_length(_out.threats)>32) {_out.complete=false;return _out;}
        }
    }
    return _out;
}
// Fixture input only. Current native masks confirm overlap; frame0 uses the
// known frame1 bounding box conservatively. No actor is moved by these queries.
function scrNTTETrenchSecondHopDodgeExplosionSafety(_threats,_budget) {
    var _out={complete:true,unsafe:false,current_overlap:0,preactive_overlap:0}
    for(var _i=0;_i<array_length(_threats);++_i) {
        var _threat=_threats[_i]
        if(!_threat.explosion) continue;
        if(_budget.remaining<=0) {_budget.exhausted=true;_out.complete=false;return _out;}
        _budget.remaining--;_budget.samples++
        var _overlap=false
        if(_threat.mask_active_now) {
            with(player) _overlap=place_meeting(x,y,_threat.actor)
            if(_overlap) _out.current_overlap++
        }
        else {
            var _gap=max(_threat.box[0]-player.bbox_right,player.bbox_left-_threat.box[2],
                _threat.box[1]-player.bbox_bottom,player.bbox_top-_threat.box[3])
            _overlap=_gap<=0
            if(_overlap) _out.preactive_overlap++
        }
        _out.unsafe=_out.unsafe || _overlap
    }
    return _out;
}
function scrNTTETrenchSecondHopDodgeRisk(_moving,_direction,_threats,_terrain,_budget) {
    var _frames=ceil(8/timescale),_px=player.x,_py=player.y,_vx=player.hspeed,_vy=player.vspeed,
        _max=player.maxspeed,_friction=player.friction,_risk=0,_clearance=infinity,
        _explosion_risk=0,_vent_risk=0,_escape_clearance=infinity,
        _left=player.bbox_left-player.x,_top=player.bbox_top-player.y,
        _right=player.bbox_right-player.x,_bottom=player.bbox_bottom-player.y
    for(var _step=0;_step<=_frames;++_step) {
        if(_step>0) {
            var _speed=point_distance(0,0,_vx,_vy)
            if(_moving && _speed<_max) {
                _vx+=lengthdir_x(3*timescale,_direction);_vy+=lengthdir_y(3*timescale,_direction)
                _speed=point_distance(0,0,_vx,_vy)
            }
            if(_speed>_max) {_vx*=_max/_speed;_vy*=_max/_speed;_speed=_max;}
            var _drag=_speed>0?max(0,_speed-_friction)/_speed:0
            _vx*=_drag;_vy*=_drag
            var _nx=_px+_vx,_ny=_py+_vy
            if(_terrain && !scrNTTETrenchSecondHopDodgeSegment(_px,_py,_nx,_ny,_budget))
                return {complete:!_budget.exhausted,legal:false,risk:infinity,clearance:-infinity,
                    explosion_risk:infinity,escape_clearance:-infinity};
            _px=_nx;_py=_ny
        }
        for(var _i=0;_i<array_length(_threats);++_i) {
            if(_budget.remaining<=0) {_budget.exhausted=true;return {complete:false,legal:false,risk:infinity,
                clearance:-infinity,explosion_risk:infinity,escape_clearance:-infinity};}
            _budget.remaining--;_budget.samples++
            var _threat=_threats[_i],_shift_x=_threat.vx*_step,_shift_y=_threat.vy*_step,
                _gap=infinity,_hit=false,
                _vent=variable_struct_exists(_threat,"vent_potential") && _threat.vent_potential
            if(_vent && _step==_frames) {
                var _vent_end_gap=max(_threat.box[0]-(_px+_right),(_px+_left)-_threat.box[2],
                    _threat.box[1]-(_py+_bottom),(_py+_top)-_threat.box[3])
                _escape_clearance=min(_escape_clearance,_vent_end_gap)
            }
            if(_threat.explosion) {
                // A terminal geometric objective keeps ordinary escape input
                // useful when unavoidable near-term risk ties every candidate.
                // It never makes an expired mask continue to deal damage.
                if(_step==_frames) {
                    var _end_gap=max(_threat.box[0]+_shift_x-(_px+_right),(_px+_left)-(_threat.box[2]+_shift_x),
                        _threat.box[1]+_shift_y-(_py+_bottom),(_py+_top)-(_threat.box[3]+_shift_y))
                    _escape_clearance=min(_escape_clearance,_end_gap)
                }
                //7082 measured collision before this input-stage sample:
                // frame94 hit image1, then input sees1.2; frame95 hit1.4,
                // then input sees1.6. Forecast the NEXT collision from the
                // sampled image; a past step0 hit is not avoidable input cost.
                if(_step==0) continue;
                var _projected_image=_threat.animation_index+_threat.image_rate*(_step-1),
                    _projected_frame=current_frame+timescale*_step
                if(_projected_image<1 || _projected_image>=2 || (_projected_frame mod 1)>=timescale) continue;
            }
            if(_threat.warning) {
                _gap=point_distance(_px,_py,_threat.x+_shift_x,_threat.y+_shift_y)-72
            }
            else if(_vent) {
                // No native place_meeting against a Vent sprite; this is only
                // the possible future Bubble mask bound, at every planning step.
                _gap=max(_threat.box[0]-(_px+_right),(_px+_left)-_threat.box[2],
                    _threat.box[1]-(_py+_bottom),(_py+_top)-_threat.box[3])
            }
            else {
                var _query_x=_px-_shift_x,_query_y=_py-_shift_y
                with(player) _hit=place_meeting(_query_x,_query_y,_threat.actor)
                var _previous=max(0,_step-1),_margin=_threat.slash?6:3,
                    _sl=_threat.box[0]+min(_shift_x,_threat.vx*_previous)-_margin,
                    _st=_threat.box[1]+min(_shift_y,_threat.vy*_previous)-_margin,
                    _sr=_threat.box[2]+max(_shift_x,_threat.vx*_previous)+_margin,
                    _sb=_threat.box[3]+max(_shift_y,_threat.vy*_previous)+_margin
                _gap=max(_sl-(_px+_right),(_px+_left)-_sr,_st-(_py+_bottom),(_py+_top)-_sb)
            }
            _clearance=min(_clearance,_gap)
            var _collision_risk=_threat.explosion && _threat.mask_active_now ? _hit:(_hit || _gap<=0)
            if(_collision_risk) {
                var _cost=(_frames-_step+1)*(1+min(72,max(0,-_gap)))
                _risk+=_cost
                if(_threat.explosion) _explosion_risk+=_cost
                if(_vent) _vent_risk+=_cost
            }
        }
    }
    return {complete:!_budget.exhausted,legal:true,risk:_risk,clearance:_clearance,
        explosion_risk:_explosion_risk,escape_clearance:_escape_clearance,vent_risk:_vent_risk};
}
function scrNTTETrenchSecondHopDodgeMove(_moving,_direction) {
    var _answer={override:false,moving:_moving,direction:_direction},_started=get_timer()
    if(timescale<0.5 || timescale>1 || !player.can_walk || player.roll) return _answer;
    // This memory belongs only to the test controller, and resets with Player
    // identity/rate. It never writes Player/world/damage/save variables.
    if(!variable_instance_exists(id,"bot_trench_second_hop_explosion_escape")
        || !is_struct(bot_trench_second_hop_explosion_escape)
        || bot_trench_second_hop_explosion_escape.player_id!=player.id
        || bot_trench_second_hop_explosion_escape.rate!=rates[pass_index])
        bot_trench_second_hop_explosion_escape={player_id:player.id,rate:rates[pass_index],active:false,move_direction:_direction}
    var _state=bot_trench_second_hop_explosion_escape,_scan=scrNTTETrenchSecondHopDodgeThreats()
    if(!_scan.complete) return _answer;
    if(array_length(_scan.threats)==0) {
        if(_state.active) scrNTTESmokeLog("TRENCH SECOND HOP ESCAPE RELEASE "+json_stringify({rate:rates[pass_index],
            frame:current_frame,elapsed:elapsed,reason:"complete known-mask scan clear"}))
        _state.active=false
        return _answer;
    }
    var _budget={remaining:65536,samples:0,exhausted:false},
        _safety=scrNTTETrenchSecondHopDodgeExplosionSafety(_scan.threats,_budget)
    if(!_safety.complete) return _answer;
    var _base=scrNTTETrenchSecondHopDodgeRisk(_moving,_direction,_scan.threats,false,_budget)
    if(!_base.complete) return _answer;
    var _escape=_safety.unsafe || _base.explosion_risk>0 || _base.vent_risk>0
    if(!_escape) {
        if(_state.active) scrNTTESmokeLog("TRENCH SECOND HOP ESCAPE RELEASE "+json_stringify({rate:rates[pass_index],
            frame:current_frame,elapsed:elapsed,current_overlap:_safety.current_overlap,
            preactive_overlap:_safety.preactive_overlap,future_explosion_risk:_base.explosion_risk,future_vent_risk:_base.vent_risk,
            reason:"native active mask clear; preactive bound clear; predicted explosion and potential Vent risk zero"}))
        _state.active=false
        if(_base.risk<=0) return _answer;
    }
    var _best=_base,_chosen=-1,_has_best=!_escape,
        _directions=[_escape && _state.active?_state.move_direction:_direction],
        _moves=[_escape && _state.active?true:_moving]
    for(var _i=0;_i<16;++_i) {array_push(_directions,_i*22.5);array_push(_moves,true);}
    array_push(_directions,0);array_push(_moves,false)
    for(var _i=0;_i<array_length(_directions);++_i) {
        // While a real/predicted explosion still requires escape, evaluate
        // ordinary WALK choices. Standing is not the automatic tie fallback.
        if(_escape && !_moves[_i]) continue;
        var _sample=scrNTTETrenchSecondHopDodgeRisk(_moves[_i],_directions[_i],_scan.threats,true,_budget)
        if(!_sample.complete || _budget.exhausted) return _answer;
        if(!_sample.legal) continue;
        var _better=!_has_best || _sample.risk<_best.risk-0.001
        if(_has_best && abs(_sample.risk-_best.risk)<=0.001) {
            if(_escape) {
                _better=_sample.escape_clearance>_best.escape_clearance+0.25
                if(abs(_sample.escape_clearance-_best.escape_clearance)<=0.25)
                    _better=_sample.clearance>_best.clearance+0.25
            }
            else _better=_sample.clearance>_best.clearance+0.25
        }
        if(_better) {_best=_sample;_chosen=_i;_has_best=true;}
    }
    if(_chosen<0) {
        if(_escape) scrNTTESmokeLog("TRENCH SECOND HOP ESCAPE REFUSED "+json_stringify({rate:rates[pass_index],
            frame:current_frame,elapsed:elapsed,reason:"no complete terrain-legal moving candidate",samples:_budget.samples}))
        return _answer;
    }
    _answer.override=true;_answer.moving=_moves[_chosen];_answer.direction=_directions[_chosen]
    if(_escape) {_state.active=true;_state.move_direction=_answer.direction;}
    if(_escape || floor(elapsed) mod 15==0) scrNTTESmokeLog("TRENCH SECOND HOP PHASE CORRECT ESCAPE INPUT "+json_stringify({rate:rates[pass_index],
        phase:phase,elapsed:elapsed,frame:current_frame,seed:current_seed,xy:[player.x,player.y],
        threats:array_length(_scan.threats),explosions:_scan.explosions,vents:_scan.vents,vent_sources:_scan.vent_sources,escape_mode:_escape,
        current_overlap:_safety.current_overlap,preactive_overlap:_safety.preactive_overlap,
        original:[_moving,_direction,_base.risk,string(_base.clearance),_base.explosion_risk,string(_base.escape_clearance)],
        chosen:[_answer.moving,_answer.direction,_best.risk,string(_best.clearance),_best.explosion_risk,string(_best.escape_clearance)],
        vent_risks:[_base.vent_risk,_best.vent_risk],
        samples:_budget.samples,microseconds:get_timer()-_started,complete:true,terrain_legal:true,
        note:"future Explosion collision image uses sample+rate*(step-1); past step0 excluded; escape walking retained until real/predicted clear; positive risk is not a survival claim"}))
    return _answer;
}
// Fixture-only grid-first fallback. Endpoints alone never establish a route.
// Actual Player Wall/Floor masks include legal Trench pit Floor, unchanged.
// Native Player movement/fire remains the only way actors change position/HP.
function scrNTTETrenchSecondHopNativeNavPoint(_x,_y,_budget) {
    if(_budget.remaining<=0) {_budget.exhausted=true;return 0;}
    _budget.remaining--;_budget.samples++
    var _wall=false,_floor=false
    with(player) {_wall=place_meeting(_x,_y,Wall);_floor=place_meeting(_x,_y,Floor)}
    if(_wall) return 2;
    if(!_floor) return 3;
    return 1;
}
function scrNTTETrenchSecondHopNativeNavSegment(_x1,_y1,_x2,_y2,_budget) {
    var _steps=max(1,ceil(point_distance(_x1,_y1,_x2,_y2)/2))
    for(var _i=0;_i<=_steps;++_i)
        if(scrNTTETrenchSecondHopNativeNavPoint(lerp(_x1,_x2,_i/_steps),lerp(_y1,_y2,_i/_steps),_budget)!=1) return false;
    return true;
}
function scrNTTETrenchSecondHopNativeNavPose() {
    return [player,player.x,player.y,player.mask_index,player.sprite_index,player.image_index,
        player.image_xscale,player.image_yscale,player.image_angle,player.bbox_left,player.bbox_top,player.bbox_right,player.bbox_bottom];
}
function scrNTTETrenchSecondHopNativeNavBuild(_grid) {
    var _total=_grid.width*_grid.height,_budget={remaining:200000,samples:0,exhausted:false},
        _out={complete:false,status:"node_budget",budget:_budget,pose:scrNTTETrenchSecondHopNativeNavPose(),
            points:[],horizontal:[],vertical:[],members:[],parents:[],roots:[],visited:0}
    if(_total<=0 || _total>60000) return _out;
    var _points=array_create(_total,0),_horizontal=array_create(_total,0),_vertical=array_create(_total,0),
        _seen=array_create(_total,0),_parents=array_create(_total,-2),_roots=[],_queue=[],_head=0
    for(var _i=0;_i<_total && !_budget.exhausted;++_i)
        _points[_i]=scrNTTETrenchSecondHopNativeNavPoint(_grid.x+((_i mod _grid.width)+0.5)*8,
            _grid.y+(floor(_i/_grid.width)+0.5)*8,_budget)
    var _cx=floor((player.x-_grid.x)/8),_cy=floor((player.y-_grid.y)/8)
    for(var _dy=-1;_dy<=1;++_dy) for(var _dx=-1;_dx<=1;++_dx) {
        var _nx=_cx+_dx,_ny=_cy+_dy
        if(_nx<0 || _ny<0 || _nx>=_grid.width || _ny>=_grid.height) continue;
        var _index=_ny*_grid.width+_nx
        if(_points[_index]==1 && scrNTTETrenchSecondHopNativeNavSegment(player.x,player.y,
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
                else _code=scrNTTETrenchSecondHopNativeNavSegment(_x,_y,_grid.x+(_nx+0.5)*8,_grid.y+(_ny+0.5)*8,_budget)?1:2;
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
function scrNTTETrenchSecondHopNativeNavFallback(_grid,_goal_x,_goal_y) {
    var _endpoint_budget={remaining:2,samples:0,exhausted:false},
        _start_code=scrNTTETrenchSecondHopNativeNavPoint(player.x,player.y,_endpoint_budget),
        _goal_code=scrNTTETrenchSecondHopNativeNavPoint(_goal_x,_goal_y,_endpoint_budget)
    if(_start_code!=1 || _goal_code!=1 || _endpoint_budget.exhausted) {
        scrNTTESmokeLog("TRENCH SECOND HOP NATIVE FALLBACK ENDPOINT REFUSED "+json_stringify({seed:current_seed,rate:rates[pass_index],phase:phase,
            start:[player.x,player.y],goal:[_goal_x,_goal_y],start_code:_start_code,goal_code:_goal_code,budget:_endpoint_budget}))
        return false;
    }
    var _pose=scrNTTETrenchSecondHopNativeNavPose(),_graph=undefined
    if(variable_struct_exists(_grid,"ntte_trench_second_hop_nav_graph")) _graph=_grid.ntte_trench_second_hop_nav_graph;
    // Reuse only inside this same synchronous grid scope and exact Player pose.
    // Every ordinary movement replan creates a fresh grid and a fresh graph.
    if(!is_struct(_graph) || json_stringify(_graph.pose)!=json_stringify(_pose)) {
        _graph=scrNTTETrenchSecondHopNativeNavBuild(_grid);_grid.ntte_trench_second_hop_nav_graph=_graph
    }
    if(!_graph.complete || _graph.budget.exhausted) {
        scrNTTESmokeLog("TRENCH SECOND HOP NATIVE FALLBACK UNKNOWN "+json_stringify({seed:current_seed,rate:rates[pass_index],phase:phase,
            status:_graph.status,budget:_graph.budget,goal:[_goal_x,_goal_y]}))
        return false;
    }
    var _cx=floor((_goal_x-_grid.x)/8),_cy=floor((_goal_y-_grid.y)/8),_end=-1
    for(var _dy=-1;_dy<=1 && _end<0;++_dy) for(var _dx=-1;_dx<=1;++_dx) {
        var _nx=_cx+_dx,_ny=_cy+_dy
        if(_nx<0 || _ny<0 || _nx>=_grid.width || _ny>=_grid.height) continue;
        var _index=_ny*_grid.width+_nx
        if(_graph.members[_index] && scrNTTETrenchSecondHopNativeNavSegment(_goal_x,_goal_y,
            _grid.x+(_nx+0.5)*8,_grid.y+(_ny+0.5)*8,_graph.budget)) {_end=_index;break;}
    }
    if(_end<0 || _graph.budget.exhausted) {
        scrNTTESmokeLog("TRENCH SECOND HOP NATIVE FALLBACK NO ROUTE "+json_stringify({seed:current_seed,rate:rates[pass_index],phase:phase,
            start:[player.x,player.y],goal:[_goal_x,_goal_y],visited:_graph.visited,roots:_graph.roots,
            complete:_graph.complete,budget:_graph.budget}))
        return false;
    }
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
        if(!scrNTTETrenchSecondHopNativeNavSegment(_route[_i-1][0],_route[_i-1][1],_route[_i][0],_route[_i][1],_graph.budget)) return false;
    if(_graph.budget.exhausted || json_stringify(scrNTTETrenchSecondHopNativeNavPose())!=json_stringify(_pose)) return false;
    path_clear_points(bot_path);path_set_kind(bot_path,0);path_set_closed(bot_path,false)
    for(var _i=0;_i<array_length(_route);++_i) path_add_point(bot_path,_route[_i][0],_route[_i][1],100)
    bot_trench_second_hop_native_mask_path=true
    scrNTTESmokeLog("TRENCH SECOND HOP NATIVE FALLBACK PATH "+json_stringify({seed:current_seed,rate:rates[pass_index],phase:phase,
        start:_route[0],goal:[_goal_x,_goal_y],points:array_length(_route),visited:_graph.visited,
        budget:_graph.budget,whole_route_rechecked:true,route:_route}))
    return true;
}
function scrNTTETrenchSecondHopNativeNavFollow() {
    // Never skip a close corner using distance alone. Every proposed shortcut
    // is checked using the current real Player mask/Floor before native input.
    var _budget={remaining:512,samples:0,exhausted:false},_last=path_get_number(bot_path)-1,
        _first=clamp(bot_path_cursor,1,_last),_chosen=-1
    for(var _i=min(_last,_first+8);_i>=_first;--_i) {
        var _x=path_get_point_x(bot_path,_i),_y=path_get_point_y(bot_path,_i)
        if(point_distance(player.x,player.y,_x,_y)<0.01) continue;
        if(scrNTTETrenchSecondHopNativeNavSegment(player.x,player.y,_x,_y,_budget)) {_chosen=_i;break;}
    }
    if(_chosen<0 || _budget.exhausted) {bot_path_clock=0;return undefined;}
    bot_path_cursor=_chosen
    return point_direction(player.x,player.y,path_get_point_x(bot_path,_chosen),path_get_point_y(bot_path,_chosen));
}
// END NTTE TRENCH SECOND HOP VERIFIED INPUT HELPERS
function scrNTTEFullTrenchSecondHopBotAfterSample(_keycont,_index) {
    var _o=instance_find(NTTEFullTrenchSecondHopConnectedTest,0)
    if(!instance_exists(_o) || _o.restored || !instance_exists(_o.player) || _o.player.index!=_index) return;
    var _fire=false,_move=false,_direction=0,_swap=false,_aim=0
    if((_o.phase==2 || _o.phase==3) && !instance_exists(GenCont) && !instance_exists(FloorMaker)) with(_o) {
        var _combat=phase==2,_target=_combat?scrNTTEFullTrenchSecondHopTarget():portal
        if(instance_exists(_target)) {
            var _distance=point_distance(player.x,player.y,_target.x,_target.y),
                _clear=!collision_line(player.x,player.y,_target.x,_target.y,Wall,false,false)
            _direction=point_direction(player.x,player.y,_target.x,_target.y);_aim=_direction
            if(_combat) {
                var _type=scr_weapon_get_type(player.wep)
                _swap=player.ammo[_type]<=0 && player.ammo[scr_weapon_get_type(player.bwep)]>0
                _fire=!_swap && _clear && _distance<128 && _target.visible && _target.mask_index!=mskNone && player.ammo[_type]>0
                _move=(!_clear || _distance>96 || !_target.visible || _target.mask_index==mskNone) && _distance>24
            }
            else _move=_distance>2
            bot_path_clock-=timescale
            if(_move && !_clear) {
                if(bot_target!=_target || bot_path_clock<=0) {
                    bot_target=_target;bot_path_clock=20;bot_path_cursor=1
                    var _left=infinity,_top=infinity,_right=-infinity,_bottom=-infinity
                    with(Floor) {_left=min(_left,bbox_left);_top=min(_top,bbox_top);_right=max(_right,bbox_right);_bottom=max(_bottom,bbox_bottom)}
                    assert(_left<infinity,"Trench bot lost actual generated terrain")
                    _left=floor((_left-64)/8)*8;_top=floor((_top-64)/8)*8
                    var _grid=mp_grid_create(_left,_top,ceil((_right+64-_left)/8),ceil((_bottom+64-_top)/8),8,8)
                    with(Wall) mp_grid_add_rectangle(_grid,bbox_left-5,bbox_top-3,bbox_right+5,bbox_bottom+3)
                    path_clear_points(bot_path);mp_grid_path(_grid,bot_path,player.x,player.y,_target.x,_target.y,false);
                    // BEGIN NTTE TRENCH SECOND HOP NATIVE PLANNER FALLBACK PLAN
                    bot_trench_second_hop_native_mask_path=false
                    if(path_get_number(bot_path)<=1)
                        scrNTTETrenchSecondHopNativeNavFallback({x:_left,y:_top,width:ceil((_right+64-_left)/8),height:ceil((_bottom+64-_top)/8)},_target.x,_target.y)
                    // END NTTE TRENCH SECOND HOP NATIVE PLANNER FALLBACK PLAN
                    mp_grid_destroy(_grid)
                }
                if(path_get_number(bot_path)>1) {
                    // BEGIN NTTE TRENCH SECOND HOP NATIVE PLANNER FALLBACK FOLLOW
                    if(variable_instance_exists(id,"bot_trench_second_hop_native_mask_path") && bot_trench_second_hop_native_mask_path) {
                        var _ntte_trench_second_hop_native_direction=scrNTTETrenchSecondHopNativeNavFollow()
                        if(is_undefined(_ntte_trench_second_hop_native_direction)) _move=false
                        else _direction=_ntte_trench_second_hop_native_direction
                    }
                    else {
                        while(bot_path_cursor<path_get_number(bot_path)-1 && point_distance(player.x,player.y,path_get_point_x(bot_path,bot_path_cursor),path_get_point_y(bot_path,bot_path_cursor))<6) bot_path_cursor++
                        _direction=point_direction(player.x,player.y,path_get_point_x(bot_path,bot_path_cursor),path_get_point_y(bot_path,bot_path_cursor))
                    }
                    // END NTTE TRENCH SECOND HOP NATIVE PLANNER FALLBACK FOLLOW
                }
                else _move=false
            }
        }
        // BEGIN NTTE TRENCH SECOND HOP MOVEMENT DODGE INPUT
        if(phase==2) {
            var _ntte_trench_second_hop_dodge=scrNTTETrenchSecondHopDodgeMove(_move,_direction)
            if(_ntte_trench_second_hop_dodge.override) {_move=_ntte_trench_second_hop_dodge.moving;_direction=_ntte_trench_second_hop_dodge.direction;}
        }
        // END NTTE TRENCH SECOND HOP MOVEMENT DODGE INPUT
        if(_fire) bot_fire_samples++
        if(_move) bot_move_samples++
    }
    _keycont.dir_fire[_index]=_aim;_keycont.press_fire[_index]=_fire && !_o.bot_was_fire
    _keycont.hold_fire[_index]=_fire;_keycont.release_fire[_index]=!_fire && _o.bot_was_fire;_o.bot_was_fire=_fire
    _keycont.press_swap[_index]=_swap;_keycont.hold_swap[_index]=_swap
    _keycont.hold_spec[_index]=false;_keycont.press_spec[_index]=false
    _keycont.hold_pick[_index]=false;_keycont.press_pick[_index]=false
    _keycont.aimassist[_index]=false;_keycont.precisemovement[_index]=true
    _keycont.moving[_index]=_move?1:0;_keycont.dir_move[_index]=_direction
    _keycont.hold_east[_index]=false;_keycont.hold_west[_index]=false;_keycont.hold_nort[_index]=false;_keycont.hold_sout[_index]=false
}
function scrNTTEFullTrenchSecondHopProbe(_kind) {
    var _o=instance_find(NTTEFullTrenchSecondHopConnectedTest,0)
    if(!instance_exists(_o) || !variable_instance_exists(_o,"restored") || _o.restored) return;
    if(_kind=="GenCont.Create.after" && (_o.phase==1 || _o.phase==3 || _o.phase==4 || _o.phase==6)) {
        assert(!ntte_full_sync_generation,"Trench campaign substituted synchronous generation")
        if(_o.phase==1) _o.initial_generators++
        else if(_o.phase==6) _o.continued_generators++
        else _o.hop_generators++
    }
    if(_kind=="GenCont.Destroy.after" && (_o.phase==1 || _o.phase==3 || _o.phase==4 || _o.phase==6)) {
        assert(GameCont.area==scrNTTEFullAreaId("trench") && GameCont.subarea==(_o.phase==1?2:3),"Unexpected Trench campaign native generator completion")
        if(_o.phase==1) {_o.initial_generated=true;_o.initial_hostiles=scrNTTEFullTrenchSecondHopHostiles()}
        else {
            if(_o.phase==6) _o.continued_generated=true
            else _o.hop_generated=true
            assert(instance_number(NTTEFullPitSquid)==1,"Trench2->3 failed one natural PitSquid")
            var _boss=instance_find(NTTEFullPitSquid,0),_octos=0
            assert(_boss.hp==340 && _boss.max_hp==340 && _boss.hp==scrNTTEFullSewerBossHP(340)
                && _boss.mask_index==mskNone && _boss.x==0 && _boss.y==0
                && !_boss.ntte_full_intro && !_boss.ntte_full_can_intro && _boss.ntte_full_rise_delay==0,
                "Trench3 native generator changed source340HP hidden-root/intro/rise constructor")
            with(NTTEFullPet) if(pet=="Octo" && hiding) _octos++
            assert(_octos==1,"Trench3 generator omitted one natural hiding Octo")
            _o.boss_creation_checks++
        }
    }
    if(_o.phase==2 || _o.phase==3) {
        if(_kind=="Corpse.Alarm0.before" && !scr_check_enemies()) {_o.saw_clear_alarm=true;_o.clear_frame=current_frame}
        if(_kind=="Portal.Create.after") {
            assert(_o.phase==2 && _o.saw_clear_alarm && _o.clear_frame==current_frame && !scr_check_enemies()
                && scrNTTEFullTrenchSecondHopHostiles()==0 && _o.portal==noone,"Trench portal lacks genuine corpse/enemy-clear provenance")
            _o.portal=id;_o.saw_spawn=sprite_index==sprPortalSpawn
        }
    }
    if(instance_exists(_o.portal) && id==_o.portal) {
        if(sprite_index==sprPortal) _o.saw_open=true
        if(sprite_index==sprPortalDisappear) _o.saw_disappear=true
        if(_kind=="Portal.Contact.before") assert(other.id==_o.player && place_meeting(x,y,_o.player),"Trench exit contact lacks actual Player collision")
        if(_kind=="Portal.Contact.after" && endgame<=30) _o.saw_contact=true
        if(_kind=="Portal.Alarm1.before") {assert(_o.saw_contact,"Trench exit restarted without real contact");_o.restart_requested=true}
    }

    if(_kind=="Vlambeer.Create.before" && _o.phase==6) {
        assert(!instance_exists(GameCont) && file_exists(savegame_file),"Continuation did not cold-create native loader from reserved binary")
        _o.native_loader_seen=true
    }
    if(_kind=="GameCont.RoomStart.after" && _o.phase==6) {
        assert(_o.native_loader_seen && id!=_o.saved_game && instance_exists(Player) && Player.id!=_o.saved_player,"Continuation RoomStart lacks distinct loaded GameCont/Player")
        _o.continued_game_roomstarts++;_o.continued_roomstart_game=id;_o.continued_roomstart_player=Player.id
        with(_o) scrNTTEFullTrenchSecondHopImportedPlayerAssert(instance_find(Player,0),"GameCont.RoomStart.after")
        _o.continued_game_import_seen=true
    }
    if(_kind=="Player.RoomStart.after" && _o.phase==6) {
        assert(_o.native_loader_seen && id!=_o.saved_player && instance_exists(GameCont) && GameCont.id!=_o.saved_game,
            "Continuation Player.RoomStart lacks distinct loaded actors")
        var _imported_player=id
        with(_o) scrNTTEFullTrenchSecondHopImportedPlayerAssert(_imported_player,"Player.RoomStart.after")
        _o.continued_player_roomstarts++;_o.continued_player_import_seen=true
    }
}
function scrNTTEFullTrenchSecondHopLoadProbe(_only_first_part) {
    var _o=instance_find(NTTEFullTrenchSecondHopConnectedTest,0)
    if(!instance_exists(_o) || _o.restored || _o.phase!=6) return;
    assert(!_only_first_part && _o.native_loader_seen,"Continuation skipped native Vlambeer full binary load")
    _o.full_loads++
}
function scrNTTEFullTrenchSecondHopDiagnostic() {
    scrNTTESmokeLog("TRENCH SECOND HOP READONLY "+json_stringify({rate:rates[pass_index],phase:phase,elapsed:elapsed,
        frame:current_frame,area:scrNTTEFullValue(GameCont,"area","<absent>"),subarea:scrNTTEFullValue(GameCont,"subarea","<absent>"),
        player:player,player_live:instance_exists(player),hp:instance_exists(player)?player.hp:-1,max_hp:instance_exists(player)?player.max_hp:-1,
        ammo:instance_exists(player)?player.ammo:[],hostiles:scrNTTEFullTrenchSecondHopHostiles(),portal:portal,shots:shot_count,
        hits:native_hits,damage:native_damage,room_ends:room_ends,room_starts:room_starts,draws:draw_frames,
        generation:instance_number(GenCont),boss_creation_checks:boss_creation_checks,full_loads:full_loads,continued_starts:continued_game_roomstarts}))
}
function scrNTTEFullTrenchSecondHopWorldAssert(_subarea) {
    assert(GameCont.area==scrNTTEFullAreaId("trench") && GameCont.subarea==_subarea && GameCont.loops==0
        && GameCont.ntte_active_trench && GameCont.ntte_full_active_trench && GameCont.underwater
        && instance_number(Floor)>20 && instance_number(TopCont)==1 && TopCont.darkness && instance_exists(BackCont)
        && instance_number(NTTEFullPitRenderer)==1 && (_subarea<3 ? !instance_exists(NTTEFullPitSquid):instance_number(NTTEFullPitSquid)==1)
        && !scrNTTEFullUnlockGet("skin:parrot:1") && !scrNTTEFullUnlockGet("pack:trench"),"Trench2/3 actual world omitted source flags/terrain or granted final rewards")
    assert(variable_global_exists("ntte_full_trench_pit_grid")
        && ds_exists(global.ntte_full_trench_pit_grid,ds_type_grid)
        && global.ntte_full_trench_floor_count==instance_number(Floor),"Trench2/3 omitted a valid regenerated native pit grid")
}
function scrNTTEFullTrenchSecondHopStepBody() {
    elapsed+=timescale
    assert(elapsed<=5400,"Trench2->3 connected candidate timed out phase="+string(phase))
    if(phase>0) scrNTTEFullTrenchSecondHopRate("phase "+string(phase))
    if(phase>=2 && phase<=5) assert(instance_exists(player) && player.hp>0 && player.max_hp==initial_max_hp,"Original-HP Trench player died or maximum HP changed; do not weaken encounter")
    if(phase>=2 && elapsed>next_diagnostic) {scrNTTEFullTrenchSecondHopDiagnostic();next_diagnostic+=120}
    if(phase==0) {
        for(var _i=0;_i<array_length(smoke_drivers);++_i) {instance_activate_object(smoke_drivers[_i]);if(instance_exists(smoke_drivers[_i])) instance_destroy(smoke_drivers[_i],false)}
        smoke_drivers=[];scrNTTEFullTrenchSecondHopClear()
        game_directory=scratch_root+string(rates[pass_index])+"/";directory_create(game_directory)
        var _files=["ntte-full-progress.json","ntte-full-progress.json.bak","ntte-full-progress.json.tmp","NuclearThrone.sav"]
        for(var _i=0;_i<array_length(_files);++_i) array_push(scratch_files,game_directory+_files[_i])
        save_set_value("options","framerate",rates[pass_index]);save_set_value("options","autopause",false)
        save_set_value("options","keyboard",true);save_set_value("options","gamepad",false)
        save_set_value("visual","bossintro",false);save_set_value("visual","freezeframes",false);save_set_value("game","tutorial",false)
        UberCont.opt_framerate=rates[pass_index];UberCont.opt_autopause=false;UberCont.opt_keyboard=true;UberCont.opt_gamepad=false
        UberCont.opt_bossintro=false;UberCont.opt_freeze=0;UberCont.paused=false;UberCont.want_pause=false
        UberCont.block_input_frames=0;UberCont.block_input_fire=false;game_set_speed(rates[pass_index],gamespeed_fps)
        scrNTTEFullTrenchSecondHopAwait(19);return;
    }
    if(phase==19) {
        current_frame=0;global.alarm_topup_acc=0;global.custom_seed=current_seed;global.recontinued_times=0;global.__debug_infammo=false
        UberCont.daily_run=false;UberCont.weekly_run=false;UberCont.coop=false;UberCont.hardmode=false;UberCont.continued_run=false
        UberCont.want_quit_to_menu=false;UberCont.show_leaderboards_menu=false
        global.is_server=true;global.index=0;global.crownpick=crwn_none
        scrGameCustomModeReset();scr_playerinstances_reset_all();my_player.race=NTTEFullRace.Parrot;my_player.skin=0
        global.ntte_full_progress={schema:1,unlocks:{},loadouts:{},stats:{}};global.ntte_full_feature_ready={}
        // Controlled already-owned/selected Parrot A; no B/final pack grant.
        global.ntte_full_progress.unlocks[$ "race:parrot"]=true
        global.ntte_full_feature_ready[$ "race:parrot"]=true
        if(file_exists(savegame_file)) file_delete(savegame_file)
        instance_create(0,0,GameCont);instance_create(0,0,BackCont);instance_create(0,0,MusCont);scrCreatePlayers(0)
        player=instance_find(Player,0)
        assert(instance_number(Player)==1 && player.race==NTTEFullRace.Parrot && player.bskin==0 && player.max_hp==8 && player.hp==8 && GameCont.crown==crwn_none,"Controlled original-HP Parrot initialization failed")
        initial_max_hp=player.max_hp
        player.wep=wep_auto_crossbow;player.bwep=wep_minigun;player.infammo=0
        player.ammo[Ammo.Bolts]=typ_amax[Ammo.Bolts];player.ammo[Ammo.Bullets]=typ_amax[Ammo.Bullets]
        GameCont.area=scrNTTEFullAreaId("trench");GameCont.subarea=2;GameCont.loops=0;GameCont.hard=10
        GameCont.maxsubarea=scrAreaGetMaxSubarea(GameCont.area);GameCont.finalsubarea=false
        GameCont.can_advance_stage=true;GameCont.gocrib=false;GameCont.crown=crwn_none
        // Explicit controlled combat boundary: XP and mutation-choice UI excluded.
        GameCont.rad=-100000;GameCont.skillpoints=0;GameCont.crownpoints=0;GameCont.ultrapoints=0
        GameCont.ntte_full_pending_destination=undefined;GameCont.ntte_full_source_seed=scrNTTEFullSourceSeedBuild(current_seed)
        GameCont.ntte_full_source_pending_generation=undefined;global.ntte_full_sync_generation=false;scrRngStatesReset()
        initial_generated=false;initial_hostiles=0;room_ends=0;room_starts=0;portal=noone
        initial_generators=0;hop_generators=0;hop_generated=false;boss_creation_checks=0
        continued_generators=0;native_loader_seen=false;full_loads=0;continued_generated=false
        continued_game_roomstarts=0;continued_player_roomstarts=0;continued_game_import_seen=false;continued_player_import_seen=false
        shot_count=0;ammo_spent=0;native_shots=[];native_hits=0;native_damage=0;bot_fire_samples=0;bot_move_samples=0
        saw_clear_alarm=false;clear_frame=-1;saw_spawn=false;saw_open=false;saw_contact=false;saw_disappear=false;restart_requested=false
        bot_was_fire=false;bot_target=noone;bot_path_clock=0;bot_path_cursor=0;path_clear_points(bot_path)
        scrNTTEFullFloorResetStyle();scrNTTEFullFloorResetAlign();scrNTTEFullTrenchSecondHopAwait(1)
        var _gen=instance_create(0,0,GenCont)
        assert(!_gen.ntte_full_sync_generation && global.seed==current_seed,"Trench controlled seed/native async generation changed")
        scrNTTESmokeLog("TRENCH SECOND HOP CONTROLLED INITIAL Trench2/loop0/hard10/Parrot originalHP="+string(initial_max_hp)+"/legal AutoCrossbow+Minigun/max initial ammo/XP suppressed; no upstream Oasis claim @"+string(rates[pass_index]));return;
    }
    if(phase==1) {
        if(!scrNTTEFullTrenchSecondHopWorldReady()) return;
        scrNTTEFullTrenchSecondHopWorldAssert(2)
        assert(initial_generated && initial_generators==1 && initial_hostiles>0 && !instance_exists(Portal),"Trench2 lacks genuine generated encounter before clear")
        initial_game=GameCont.id;initial_player=player.id;old_world=scrNTTEFullInstances([Floor,Wall,TopCont,SubTopCont,NTTEFullPitRenderer])
        old_visits=scrNTTEFullValue(GameCont,"ntte_visits_trench",0);old_hard=GameCont.hard;old_waypoints=GameCont.waypoints
        hop_ends=room_ends;hop_starts=room_starts;scrNTTEFullTrenchSecondHopAwait(2);return;
    }
    if(phase==2) {
        if(!instance_exists(portal)) return;
        assert(saw_clear_alarm && !scr_check_enemies() && scrNTTEFullTrenchSecondHopHostiles()==0
            && initial_hostiles>0 && shot_count>0 && ammo_spent==shot_count && bot_fire_samples>0 && native_hits>0 && native_damage>0,
            "Trench2 clear lacks real encounter/input/ammo/moving-projectile damage/corpse Portal")
        assert(room_ends==hop_ends && room_starts==hop_starts,"Trench2 combat advanced engine before portal")
        scrNTTEFullTrenchSecondHopAwait(3);return;
    }
    if(phase==3) {
        if(room_ends==hop_ends) return;
        assert(saw_spawn && saw_open && saw_contact && saw_disappear && restart_requested && bot_move_samples>0,"Trench2 exit lacks actual portal contact/animation/Alarm1/native movement")
        assert(room_ends==hop_ends+1 && room_starts==hop_starts+1,"Trench2->3 did not execute exactly one engine RoomEnd/Start")
        assert(GameCont.id==initial_game && instance_exists(initial_player) && Player.id==initial_player
            && GameCont.area==scrNTTEFullAreaId("trench") && GameCont.subarea==3 && GameCont.loops==0
            && is_undefined(GameCont.ntte_full_pending_destination)
            && scrNTTEFullValue(GameCont,"ntte_visits_trench",0)==old_visits+1
            && scrNTTEFullValue(GameCont,"ntte_full_visits_trench",0)==old_visits+1,"Trench engine transition lost persistent actors/source once-only visits/final2/consumed queue")
        assert(GameCont.hard==old_hard+1 && GameCont.waypoints==old_waypoints+1
            && GameCont.waypnt[old_waypoints]==scrNTTEFullAreaId("trench") && GameCont.waysub[old_waypoints]==3,"Trench2->3 bypassed native hard/waypoint bookkeeping")
        for(var _i=0;_i<array_length(old_world);++_i) assert(!instance_exists(old_world[_i]),"Engine transition retained Trench2 terrain/pit renderer")
        scrNTTEFullTrenchSecondHopAwait(4);return;
    }
    if(phase==4) {
        if(!scrNTTEFullTrenchSecondHopWorldReady()) return;
        scrNTTEFullTrenchSecondHopWorldAssert(3);scrNTTEFullTrenchSecondHopDiagnostic()
        assert(hop_generated && hop_generators==1 && boss_creation_checks==1,
            "Trench3 arrival omitted one genuine async generator/source boss constructor witness")
        assert(instance_exists(player) && player.race==NTTEFullRace.Parrot && player.hp>0 && player.max_hp==8
            && player.infammo==0 && !global.__debug_infammo,
            "Trench3 arrival lost original-HP Parrot or finite native ammo")
        assert(GameCont.ntte_visits_trench==old_visits+1 && GameCont.ntte_full_visits_trench==old_visits+1
            && GameCont.hard==old_hard+1 && GameCont.waypoints==old_waypoints+1,
            "Trench3 Draw wait advanced stage or once-only source counters")
        assert(room_ends==hop_ends+1 && room_starts==hop_starts+1,
            "Trench3 arrival executed an extra engine transition")
        scrNTTEFullTrenchSecondHopRate("Trench3 arrival+8Draw")
        saved_game=GameCont.id;saved_player=player.id;saved_hp=player.hp;saved_max_hp=player.max_hp
        saved_ammo=[];for(var _i=0;_i<array_length(player.ammo);++_i) array_push(saved_ammo,player.ammo[_i])
        saved_wep=player.wep;saved_bwep=player.bwep;saved_visits=GameCont.ntte_visits_trench
        saved_hard=GameCont.hard;saved_waypoints=GameCont.waypoints
        saved_world=scrNTTEFullInstances([Floor,Wall,TopCont,SubTopCont,NTTEFullPitRenderer,NTTEFullPitSquid,NTTEFullPitSquidArm,NTTEFullPet])
        resume_ends=room_ends;resume_starts=room_starts;scrSavegameSave()
        assert(file_exists(savegame_file),"Production Trench3 binary save was not written")
        scrNTTEFullTrenchSecondHopAwait(6)
        scrNTTEFullTrenchSecondHopClear();UberCont.want_quit_to_menu=false
        // Engine restart recreates the room's own Vlambeer loader; never call Load.
        room_restart();return;
    }
    if(phase==6) {
        if(!scrNTTEFullTrenchSecondHopWorldReady()) return;
        player=instance_find(Player,0)
        assert(native_loader_seen && full_loads==1 && continued_generated && continued_generators==1 && continued_game_roomstarts==1
            && continued_player_roomstarts==1 && continued_game_import_seen && continued_player_import_seen
            && room_ends==resume_ends+1 && room_starts==resume_starts+1
            && instance_number(Player)==1 && instance_exists(player) && player.id!=saved_player && GameCont.id!=saved_game
            && continued_roomstart_game==GameCont.id && continued_roomstart_player==player.id && UberCont.continued_run,
            "Trench3 continuation lacks genuine full binary load/distinct actors/engine-delivered RoomStart/regeneration")
        scrNTTEFullTrenchSecondHopWorldAssert(3)
        // Exact imported HP/ammo were measured in both real RoomStart events,
        // before any Step. Regeneration+8Draw may legally expose the original-
        // HP Parrot to native enemy damage or pickups; never freeze/protect him.
        assert(player.hp>0 && player.hp<=player.max_hp && player.max_hp==saved_max_hp
            && player.wep==saved_wep && player.bwep==saved_bwep && player.infammo==0 && !global.__debug_infammo,
            "Continued Trench3 player died or changed original max HP/finite-ammo loadout")
        assert(GameCont.ntte_visits_trench==saved_visits && GameCont.ntte_full_visits_trench==saved_visits
            && GameCont.hard==saved_hard && GameCont.waypoints==saved_waypoints
            && is_undefined(GameCont.ntte_full_pending_destination),"Continuing Trench3 advanced stage/counters or restored a consumed destination")
        for(var _i=0;_i<array_length(saved_world);++_i) assert(!instance_exists(saved_world[_i]),"Continued Trench3 retained old terrain/pit renderer handles")
        scrNTTEFullTrenchSecondHopRate("continued Trench3+8Draw")
        assert(boss_creation_checks==2,"Trench3 native continuation omitted a second original340HP constructor witness")
        scrNTTEFullTrenchSecondHopDiagnostic()
        scrNTTESmokeLog("PASS TRENCH SECOND HOP NATIVE CONTINUE: controlled standalone ParrotA/HP8/Trench2/loop0/hard10/seed701932/legal initial finite ammo+XP suppression; actual native combat/original moving projectile damage/ammo/corpse clear/Portal walk contact+animation+Alarm1/engine2->3/visits+1/hard+1/waypoint+1/old world disposal/nativeTrench3+8Draw/340HP constructor+hidden Octo; production binary Save/cold loader full Load/distinct GameCont+Player/actual RoomStart/exact imported HP+ammo/no extra advance/regenerated340HP constructor+pit renderer/continuedTrench3+8Draw @"+string(rates[pass_index])+"; no continuous upstream1->2, Trench3 Boss victory, City, final rewards, natural XP or iPhone claim")
        if(++pass_index<array_length(rates)) {scrNTTEFullTrenchSecondHopAwait(0);return;}
        scrNTTEFullTrenchSecondHopRestore();scrNTTESmokeLog("PASS full internal selected implemented branches x 30/60; not complete MOD coverage");game_end()
    }
}
function scrNTTEFullTrenchSecondHopStep() {
    try {scrNTTEFullTrenchSecondHopStepBody()}
    catch(_error) {scrNTTEFullTrenchSecondHopRestore();throw _error}
}
function scrNTTEFullTrenchSecondHopAbort(_error) {
    var _o=instance_find(NTTEFullTrenchSecondHopConnectedTest,0)
    if(instance_exists(_o)) with(_o) scrNTTEFullTrenchSecondHopRestore()
    throw _error
}

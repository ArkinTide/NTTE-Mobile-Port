// Original preauthored artifact merge art witnessed in real hub frames.
// Real source objects/normal frames. Artifact factory inputs stand in for the
// four region discoveries; this does NOT certify a complete four-area quest.
function scrNTTEFullQuestStoredHubNaturalTests(_seed=41) {
    scrNTTEFullQuestHubNaturalTests()
    with(NTTEFullQuestHubNaturalTest) {ntte_quest_stored_fixture=true;ntte_quest_fixture_seed=_seed}
}
function scrNTTEFullQuestHubNaturalTests() {
    if(os_type!=os_windows || !scrNTTEFullSmokeEnabled()) throw "Quest hub acceptance requires explicit desktop full smoke"
    var _object=asset_get_index("NTTEFullQuestHubNaturalTest")
    assert(object_exists(_object) && !instance_exists(_object),"Quest hub live observer missing/duplicate")
    var _observer=instance_create(0,0,_object)
    with(_observer) {
        state=scrNTTEFullWorldEventsNaturalWorldCapture()
        player=instance_find(Player,0);old_pick=KeyCont.press_pick[player.index];want_pick=false
        old_directory=game_directory;scratch=working_directory+"quest-hub-natural-"+string(get_timer())+"/"
        directory_create(scratch);game_directory=scratch
        global.ntte_full_progress={schema:1,unlocks:{},loadouts:{},stats:{}}
        phase=0;elapsed=0;draw_frames=0;part_index=0;source_chest=noone;source_pickup=noone;diag_phase=-1;diag_next=0;input_injections=0
        deposits=[];hearts_seen=[];heart_areas=[];enemies_seen=[];shot_clock=0;shot_count=0
        merges_seen=[false,false,false];pair_a=noone;pair_b=noone;full_pickup=noone
        attraction_a=false;attraction_b=false;reward=noone;unlock_bones=0
        gate_sample=undefined;heart_gate_intervals=0;enemy_gate_intervals=0
        merge_diag_next=0
        visible=true;depth=-100000
    }
}
function scrNTTEFullQuestHubNaturalAfterSample(_keycont,_index) {
    if(os_type!=os_windows || !scrNTTEFullSmokeEnabled()) return;
    var _observer=instance_find(NTTEFullQuestHubNaturalTest,0)
    if(!instance_exists(_observer) || !_observer.want_pick) return;
    var _phase=_observer.phase
    if(_phase!=3 && _phase!=4 && _phase!=6 && _phase!=7) return;
    var _player=_observer.player
    if(!instance_exists(_player) || !instance_is(_player,Player) || _player.index!=_index) return;
    // Input has already been sampled. Only the normal native key is supplied;
    // actual Player pickup/Prompt and source controller Steps do the transfer.
    _keycont.press_pick[_index]=true
    _observer.input_injections++
}
function scrNTTEFullQuestHubNaturalMove(_x,_y) {
    player.x=_x;player.y=_y;player.xprevious=_x;player.yprevious=_y;player.speed=0
    scr_camera_set_position(_x,_y,fa_center,fa_middle)
}
function scrNTTEFullQuestHubNaturalChange(_phase) {phase=_phase;elapsed=0;want_pick=false}
function scrNTTEFullQuestHubNaturalDescribe(_hub) {
    var _state={hub_is_struct:is_struct(_hub),floor_count:instance_number(Floor),
        controller_count:instance_number(NTTEFullQuestFloorCont),locked_count:instance_number(NTTEFullLockedHugeQuestChest),
        floor_align:[global.ntte_full_floor_aw,global.ntte_full_floor_ah,global.ntte_full_floor_ax,global.ntte_full_floor_ay],
        floor_style:[global.ntte_full_floor_style,global.ntte_full_floor_area],
        progress:global.ntte_full_progress,spawned:GameCont.ntte_quest_spawned_part_index_list}
    if(is_struct(_hub)) {
        _state.mode=_hub.mode;_state.rooms=array_length(_hub.rooms);_state.pads=array_length(_hub.pads)
        var _main=_hub.main
        _state.main_is_struct=is_struct(_main)
        if(is_struct(_main)) {
            _state.controllers=array_length(_main.controllers);_state.stored=array_length(_main.stored)
            _state.chest=_main.chest;_state.chest_exists=instance_exists(_main.chest)
            if(instance_exists(_main.chest)) _state.is_unlockable=_main.chest.is_unlockable
            _state.controller_rows=[]
            for(var _i=0;_i<array_length(_main.controllers);++_i) {
                var _cont=_main.controllers[_i],_row={id:_cont,exists:instance_exists(_cont)}
                if(instance_exists(_cont)) {
                    _row.part=_cont.part_index;_row.x=_cont.x;_row.y=_cont.y
                    _row.target=_cont.target;_row.target_exists=instance_exists(_cont.target)
                }
                array_push(_state.controller_rows,_row)
            }
        }
    }
    else _state.hub_value=string(_hub)
    scrNTTESmokeLog("QUEST HUB LIVE construct "+json_stringify(_state))
}
function scrNTTEFullQuestHubNaturalHeartbeat() {
    if(diag_phase==phase && elapsed<diag_next) return;
    diag_phase=phase;diag_next=elapsed+300
    var _row={phase:phase,elapsed:elapsed,part:part_index,player:player.id,x:player.x,y:player.y,
        visible:player.visible,can_pick:player.can_pick,raw_weapon:string(player.wep),
        parts:scrNTTEFullQuestPartList(player.wep,scrNTTEFullValue(player,"ntte_state",undefined)),
        state:scrNTTEFullValue(player,"ntte_state",undefined),
        want_pick:want_pick,press_pick:KeyCont.press_pick[player.index],input_injections:input_injections,
        enemies:instance_number(enemy),chest:source_chest,chest_exists:instance_exists(source_chest),
        pickup:source_pickup,pickup_exists:instance_exists(source_pickup),prompts:[]}
    if(instance_exists(source_chest)) {
        _row.chest_x=source_chest.x;_row.chest_y=source_chest.y
        with(source_chest) _row.chest_touch=place_meeting(x,y,other.player)
    }
    if(instance_exists(source_pickup)) {
        _row.pickup_x=source_pickup.x;_row.pickup_y=source_pickup.y
        _row.pickup_visible=source_pickup.visible;_row.pickup_wep=string(source_pickup.wep)
        with(source_pickup) _row.pickup_touch=place_meeting(x,y,other.player)
    }
    with(NTTEFullPrompt) if(point_distance(x,y,other.player.x,other.player.y)<64)
        array_push(_row.prompts,{id:id,creator:creator,text:text,pick:pick,x:x,y:y,visible:visible})
    scrNTTESmokeLog("QUEST HUB LIVE heartbeat "+json_stringify(_row))
}
function scrNTTEFullQuestHubNaturalPartPickup(_part) {
    var _found=noone
    with(WepPickup) if(scrNTTEFullQuestWeaponHasPart(wep,_part,scrNTTEFullValue(id,"ntte_state",undefined))) _found=id
    return _found
}
function scrNTTEFullQuestHubNaturalShootEnemies() {
    shot_clock-=timescale
    if(shot_clock>0) return;
    shot_clock=10
    var _enemies=scrNTTEFullInstances(enemy)
    for(var _i=0;_i<array_length(_enemies);++_i) {
        var _enemy=_enemies[_i]
        if(array_get_index(enemies_seen,_enemy)<0) array_push(enemies_seen,_enemy)
        // This is fixture-controlled combat damage, using actual player-owned
        // native bullets and real collision/damage/death callbacks. No enemy or
        // HeartBullet is deleted to satisfy the source merge gate.
        if(_enemy.hp>0 && _enemy.team!=player.team && _enemy.mask_index!=mskNone) {
            var _shot=noone
            with(player) _shot=scr_projectile_create(_enemy.x,_enemy.y,Bullet1,0,0)
            _shot.damage=100000;_shot.speed=0;shot_count++
        }
    }
}
function scrNTTEFullQuestHubNaturalGateBegin() {
    gate_sample=undefined
    if(phase!=5 || !is_struct(hub) || !instance_exists(hub.main.chest)) return;
    var _chest=hub.main.chest
    gate_sample={chest:_chest,delay:_chest.merge_delay,
        hearts:scrNTTEFullInstances(NTTEFullCrystalHeartBullet),enemies:scrNTTEFullInstances(enemy)}
}
function scrNTTEFullQuestHubNaturalGateEndBody() {
    if(!is_struct(gate_sample) || !instance_exists(gate_sample.chest)) return;
    var _heart=noone,_enemy=noone
    for(var _i=0;_i<array_length(gate_sample.hearts);++_i)
        if(instance_exists(gate_sample.hearts[_i])) {_heart=gate_sample.hearts[_i];break}
    for(var _i=0;_i<array_length(gate_sample.enemies);++_i)
        if(instance_exists(gate_sample.enemies[_i])) {_enemy=gate_sample.enemies[_i];break}
    // A gate created after the chest's Step cannot block that earlier Step.
    // A same-ID gate surviving Begin through End must block the whole frame;
    // source freezes its current delay, including a previously advanced119.
    if(!instance_exists(_heart) && !instance_exists(_enemy)) return;
    assert(gate_sample.chest.merge_delay==gate_sample.delay,
        "Actual quest merge countdown changed across a whole-frame surviving HeartBullet/generated enemy gate")
    var _first=(instance_exists(_heart) && heart_gate_intervals==0)
        || (instance_exists(_enemy) && enemy_gate_intervals==0)
    if(instance_exists(_heart)) heart_gate_intervals++
    if(instance_exists(_enemy)) enemy_gate_intervals++
    if(_first) scrNTTESmokeLog("QUEST HUB LIVE whole-frame gate freeze "+json_stringify({
        heart:_heart,enemy:_enemy,before_delay:gate_sample.delay,after_delay:gate_sample.chest.merge_delay,
        heart_intervals:heart_gate_intervals,enemy_intervals:enemy_gate_intervals,logic_scale:timescale}))
}
function scrNTTEFullQuestHubNaturalGateEnd() {
    try {scrNTTEFullQuestHubNaturalGateEndBody()}
    catch(_error) {scrNTTEFullQuestHubNaturalFinish();throw _error}
}
function scrNTTEFullQuestHubNaturalMergeDiagnostic() {
    if(elapsed<merge_diag_next) return;
    merge_diag_next=elapsed+100
    var _chest=hub.main.chest,_floors=scrNTTEFullInstances(NTTEFullQuestFloorCont),
        _hearts=scrNTTEFullInstances(NTTEFullCrystalHeartBullet),_pickups=scrNTTEFullInstances(WepPickup),
        _row={elapsed:elapsed,frame:current_frame,fps_real:fps_real,runtime_fps:game_get_speed(gamespeed_fps),
            logic_scale:timescale,all_instances:instance_number(all),floors:instance_number(Floor),walls:instance_number(Wall),
            enemies:instance_number(enemy),generator:instance_exists(GenCont),floor_maker:instance_exists(FloorMaker),
            chest:_chest,chest_exists:instance_exists(_chest),heart_intervals:heart_gate_intervals,
            enemy_intervals:enemy_gate_intervals,hearts:[],controllers:[],main_controllers:hub.main.controllers,
            pickups:[],readonly_targets:[]}
    if(instance_exists(_chest)) {
        _row.chest_x=_chest.x;_row.chest_y=_chest.y;_row.merge_delay=_chest.merge_delay
        _row.max_merge_delay=_chest.max_merge_delay;_row.is_unlockable=_chest.is_unlockable
        with(_chest) _row.chest_player_distance=distance_to_object(Player)
    }
    for(var _i=0;_i<array_length(_hearts);++_i) {
        var _heart=_hearts[_i]
        array_push(_row.hearts,{id:_heart,x:_heart.x,y:_heart.y,area:_heart.area,subarea:_heart.subarea,
            area_goal:_heart.area_goal,speed:_heart.speed,hspeed:_heart.hspeed,vspeed:_heart.vspeed,
            direction:_heart.direction,friction:_heart.friction,setup:_heart.setup,
            timer:_heart.ntte_heart_bullet_timer,life:scrNTTEFullValue(_heart,"life",undefined),
            scale_x:_heart.image_xscale,scale_y:_heart.image_yscale,
            centre_on_floor:collision_point(_heart.x,_heart.y,Floor,false,false)})
    }
    for(var _f=0;_f<array_length(_floors);++_f) {
        var _floor=_floors[_f]
        array_push(_row.controllers,{id:_floor,part:_floor.part_index,x:_floor.x,y:_floor.y,
            target:_floor.target,target_exists:instance_exists(_floor.target)})
    }
    var _part_lists=[]
    for(var _i=0;_i<array_length(_pickups);++_i) {
        var _pickup=_pickups[_i],_parts=scrNTTEFullQuestPartList(_pickup.wep,scrNTTEFullValue(_pickup,"ntte_state",undefined))
        array_push(_part_lists,_parts)
        var _pickrow={id:_pickup,raw_weapon:string(_pickup.wep),parts:_parts,x:_pickup.x,y:_pickup.y,
            sprite:_pickup.sprite_index,mask:_pickup.mask_index,visible:_pickup.visible,solid:_pickup.solid,
            hspeed:_pickup.hspeed,vspeed:_pickup.vspeed,speed:_pickup.speed,friction:_pickup.friction,
            throw_pickup:scrNTTEFullValue(_pickup,"ntte_throw_pickup",false),
            throw_target:scrNTTEFullValue(_pickup,"ntte_throw_target",undefined),floor_rows:[]}
        for(var _f=0;_f<array_length(_floors);++_f) {
            var _floor=_floors[_f],_part=_floor.part_index,_can_move=array_get_index(_parts,_part)>=0,
                _dir=point_direction(_pickup.x,_pickup.y,_floor.x,_floor.y),
                _dx=lengthdir_x(3,_dir)*timescale,_dy=lengthdir_y(3,_dir)*timescale
            for(var _j=0;_j<array_length(_parts);++_j)
                if(_parts[_j]!=_part && abs(_parts[_j]-1.5)<=abs(_part-1.5)) _can_move=false
            var _floorrow={part:_part,x:_floor.x,y:_floor.y,
                distance:point_distance(_pickup.x,_pickup.y,_floor.x,_floor.y),
                wall_sightline:collision_line(_pickup.x,_pickup.y,_floor.x,_floor.y,Wall,false,false),
                source_middlest_eligible:_can_move}
            with(_pickup) {
                _floorrow.free_toward_h=place_free(x+_dx,y)
                _floorrow.free_toward_v=place_free(x,y+_dy)
            }
            array_push(_pickrow.floor_rows,_floorrow)
        }
        array_push(_row.pickups,_pickrow)
    }
    // Mirror only the source's nearest-visible membership lookup. Never call
    // Collect here: it writes pickup velocity/angle and consumes random values.
    var _targets=array_create(array_length(_floors),noone)
    for(var _part=0;_part<4;++_part) for(var _f=0;_f<array_length(_floors);++_f)
        if(_floors[_f].part_index==_part) {
            var _nearest=-1,_distance=8
            for(var _i=0;_i<array_length(_pickups);++_i) if(_pickups[_i].visible && array_get_index(_part_lists[_i],_part)>=0) {
                var _dis=point_distance(_pickups[_i].x,_pickups[_i].y,_floors[_f].x,_floors[_f].y)
                if(_dis<_distance) {_nearest=_i;_distance=_dis}
            }
            if(_nearest>=0) for(var _k=0;_k<array_length(_floors);++_k)
                if(array_get_index(_part_lists[_nearest],_floors[_k].part_index)>=0) _targets[_k]=_pickups[_nearest]
        }
    _row.readonly_targets=_targets
    scrNTTESmokeLog("QUEST HUB LIVE merge diagnostic "+json_stringify(_row))
}
function scrNTTEFullQuestHubNaturalObserveMerges() {
    var _hearts=scrNTTEFullInstances(NTTEFullCrystalHeartBullet)
    for(var _i=0;_i<array_length(_hearts);++_i) if(array_get_index(hearts_seen,_hearts[_i])<0) {
        array_push(hearts_seen,_hearts[_i]);array_push(heart_areas,_hearts[_i].area)
    }
    var _pickups=scrNTTEFullInstances(WepPickup)
    for(var _i=0;_i<array_length(_pickups);++_i) {
        var _pickup=_pickups[_i],_parts=scrNTTEFullQuestPartList(_pickup.wep,scrNTTEFullValue(_pickup,"ntte_state",undefined))
        if(array_length(_parts)==2 && array_get_index(_parts,0)>=0 && array_get_index(_parts,1)>=0 && !merges_seen[0]) {
            scrNTTEFullQuestArtifactSpriteAssert(_pickup.wep,scrNTTEFullValue(_pickup,"ntte_state",undefined),sprNTTERefQuestArtifactSubMerge0,[0,1],_pickup)
            merges_seen[0]=true;pair_a=_pickup;pair_a_x=_pickup.x;pair_a_y=_pickup.y
            assert(array_length(hearts_seen)==2,"First natural source merge did not emit exactly two real HeartBullets")
            scrNTTESmokeLog("QUEST HUB LIVE first actual0+1 merge; real two HeartBullets block next source stage")
        }
        if(array_length(_parts)==2 && array_get_index(_parts,2)>=0 && array_get_index(_parts,3)>=0 && !merges_seen[1]) {
            scrNTTEFullQuestArtifactSpriteAssert(_pickup.wep,scrNTTEFullValue(_pickup,"ntte_state",undefined),sprNTTERefQuestArtifactSubMerge1,[2,3],_pickup)
            merges_seen[1]=true;pair_b=_pickup;pair_b_x=_pickup.x;pair_b_y=_pickup.y
            assert(merges_seen[0] && array_length(hearts_seen)==4,"Second source2+3merge skipped previous real HeartBullet lifecycle")
            assert(attraction_a,"Source merged0+1pickup never moved by real hub attraction")
            scrNTTESmokeLog("QUEST HUB LIVE second actual2+3 merge after first heart exits/native area+enemy chain; actual0+1 attraction witnessed")
        }
        if(array_length(_parts)==4 && !merges_seen[2]) {
            scrNTTEFullQuestArtifactSpriteAssert(_pickup.wep,scrNTTEFullValue(_pickup,"ntte_state",undefined),sprNTTERefQuestArtifactMerge,[0,1,2,3],_pickup)
            merges_seen[2]=true;full_pickup=_pickup
            assert(merges_seen[0] && merges_seen[1] && array_length(hearts_seen)==8,
                "Final source1+2merge omitted ordered prerequisites/four real distinct-part hearts")
            assert(attraction_a && attraction_b && hub.main.chest.is_unlockable,
                "Source four-part natural merge omitted physical attraction or real unlockability transition")
            scrNTTESmokeLog("QUEST HUB LIVE final actual1+2merge/four-part graph/four more hearts; both physical attraction chains witnessed")
        }
    }
    if(instance_exists(pair_a)) {
        var _floor=hub.main.controllers[1]
        if(point_distance(pair_a.x,pair_a.y,_floor.x,_floor.y)<8
            && point_distance(pair_a.x,pair_a.y,pair_a_x,pair_a_y)>8) attraction_a=true
    }
    if(instance_exists(pair_b)) {
        var _floor=hub.main.controllers[2]
        if(point_distance(pair_b.x,pair_b.y,_floor.x,_floor.y)<8
            && point_distance(pair_b.x,pair_b.y,pair_b_x,pair_b_y)>8) attraction_b=true
    }
}
function scrNTTEFullQuestHubNaturalFinish() {
    var _state=state,_directory=old_directory,_scratch=scratch,_player=player,_pick=old_pick
    scrNTTEFullWorldEventsNaturalWorldRestore(_state)
    game_directory=_directory;KeyCont.press_pick[_player.index]=_pick
    var _files=[_scratch+"ntte-full-progress.json",_scratch+"ntte-full-progress.json.bak",_scratch+"ntte-full-progress.json.tmp"]
    for(var _i=0;_i<array_length(_files);++_i) if(file_exists(_files[_i])) file_delete(_files[_i])
}
function scrNTTEFullQuestHubNaturalStepBody() {
    elapsed+=timescale
    scrNTTEFullQuestHubNaturalHeartbeat()
    assert(elapsed<18000,"Actual quest hub normal-frame chain timed out phase="+string(phase)+" part="+string(part_index))
    with(player) {hp=100000;max_hp=100000;lsthealth=100000;nexthurt=current_frame+100000;speed=0;can_walk=false;can_aim=false;can_pick=true;visible=true}
    if(phase==0) {
        GameCont.area=area_vault;GameCont.subarea=0;GameCont.loops=0;GameCont.crown=Crown.None
        GameCont.nochest=0;GameCont.rad=0;GameCont.level=1;GameCont.skillpoints=0;GameCont.ultrapoints=0;GameCont.crownpoints=0
        GameCont.ntte_quest_spawned_part_index_list=[]
        global.ntte_full_sync_generation=false
        UberCont.opt_autopause=false;UberCont.paused=false;UberCont.want_pause=false;UberCont.opt_freeze=0;UberCont.opt_bossintro=false
        player.wep=wep_revolver;player.bwep=wep_none;player.ntte_state=undefined;player.bntte_state=undefined
        player.curse=0;player.bcurse=0;player.extra_weps=[];player.ntte_extra_states=[]
        if(!instance_exists(TopCont)) instance_create(0,0,TopCont)
        BackCont.visible=true
        // Capture parks every pre-existing native Floor. A real Vault supplies
        // reachable terrain >=96px from spawn; its source FloorRoomStart must
        // reject an empty world. Supply that actual terrain, never bypass it.
        scrNTTEFullFloorResetStyle();scrNTTEFullFloorResetAlign()
        for(var _tile=0;_tile<5;++_tile) instance_create(10000+32*_tile,10000,Floor)
        var _stored=scrNTTEFullValue(id,"ntte_quest_stored_fixture",false)
        if(_stored) {
            for(var _i=0;_i<4;++_i) scrNTTEFullUnlockSet("quest:part:"+string(_i),true)
            global.ntte_full_progress={schema:1,unlocks:{},loadouts:{},stats:{}}
            assert(scrNTTEFullProgressLoad(),"Stored quest entry could not load permanent deposits")
            for(var _i=0;_i<4;++_i) assert(scrNTTEFullUnlockGet("quest:part:"+string(_i)),"Stored quest entry lost a permanent component")
        }
        pedestal=instance_create(10016,10016,CrownPed);GameCont.proto=_stored
        scrNTTESmokeLog("QUEST HUB LIVE source preconditions: floors="+string(instance_number(Floor))
            +" pedestal="+string(pedestal)+" proto="+string(GameCont.proto)+" player="+string(player.id))
        random_set_seed(scrNTTEFullValue(id,"ntte_quest_fixture_seed",702643))
        hub=scrNTTEFullQuestVaultAtPedestal(pedestal,10016,10016)
        scrNTTEFullQuestHubNaturalDescribe(hub)
        assert(is_struct(hub) && array_length(hub.main.controllers)==4 && array_length(hub.main.stored)==(_stored?4:0)
            && instance_exists(hub.main.chest) && !hub.main.chest.is_unlockable,
            "Actual empty-progress source hub omitted four real floors/locked chest or invented stored artifacts")
        depot_x=hub.start.x;depot_y=hub.start.y
        if(_stored) {
            for(var _i=0;_i<4;++_i) {
                var _item=hub.main.stored[_i],_floor=hub.main.controllers[_i]
                assert(scrNTTEFullQuestWeaponHasPart(_item.wep,_i,_item.ntte_state)
                    && array_length(scrNTTEFullQuestPartList(_item.wep,_item.ntte_state))==1
                    && point_distance(_item.x,_item.y,_floor.x,_floor.y)<8,"Real stored component did not spawn at its native hub floor")
            }
            deposits=hub.main.stored;part_index=4
            scrNTTEFullQuestHubNaturalMove(hub.main.chest.x,hub.main.chest.y+64)
            floors_before_hearts=instance_number(Floor)
            scrNTTEFullQuestHubNaturalChange(5);return;
        }
        scrNTTEFullQuestHubNaturalChange(1);return;
    }
    if(phase==1) {
        scrNTTEFullQuestHubNaturalMove(depot_x,depot_y)
        source_chest=scrNTTEFullQuestArtifactChest(depot_x,depot_y,part_index)
        assert(instance_is(source_chest,NTTEFullQuestChest),"Fixture source artifact factory substituted chest unexpectedly")
        scrNTTEFullQuestHubNaturalChange(2);return;
    }
    if(phase==2) {
        if(instance_exists(source_chest)) return;
        source_pickup=scrNTTEFullQuestHubNaturalPartPickup(part_index)
        assert(instance_exists(source_pickup),"Actual artifact chest normal contact omitted native physical quest pickup")
        scrNTTEFullQuestHubNaturalMove(source_pickup.x,source_pickup.y)
        want_pick=true;phase=3;elapsed=0;return;
    }
    if(phase==3) {
        if(!scrNTTEFullQuestWeaponHasPart(player.wep,part_index,player.ntte_state)) {
            if(instance_exists(source_pickup)) scrNTTEFullQuestHubNaturalMove(source_pickup.x,source_pickup.y)
            return;
        }
        want_pick=false
        assert(!instance_exists(source_pickup),"Native artifact pickup duplicated held/ground ownership")
        var _floor=hub.main.controllers[part_index]
        scrNTTEFullQuestHubNaturalMove(_floor.x,_floor.y)
        want_pick=true;phase=4;elapsed=0;return;
    }
    if(phase==4) {
        if(!scrNTTEFullUnlockGet("quest:part:"+string(part_index))) return;
        want_pick=false
        assert(!scrNTTEFullQuestWeaponHasPart(player.wep,part_index,player.ntte_state),
            "Source actual QuestFloor DROP retained artifact in player hand")
        var _drop=scrNTTEFullQuestHubNaturalPartPickup(part_index),_floor=hub.main.controllers[part_index]
        assert(instance_exists(_drop) && point_distance(_drop.x,_drop.y,_floor.x,_floor.y)<8,
            "Actual QuestFloor Prompt/input/normal Step did not deposit physical artifact on correct source floor")
        array_push(deposits,_drop)
        scrNTTESmokeLog("QUEST HUB LIVE artifact"+string(part_index)+": actual chest contact/native WepPickup input/QuestFloor DROP Prompt/real permanent part state OK")
        if(++part_index<4) {scrNTTEFullQuestHubNaturalChange(1);return;}
        global.ntte_full_progress={schema:1,unlocks:{},loadouts:{},stats:{}}
        assert(scrNTTEFullProgressLoad(),"Actual QuestFloor deposits did not write reloadable real progress")
        for(var _i=0;_i<4;++_i) assert(scrNTTEFullUnlockGet("quest:part:"+string(_i)),"Actual source deposit JSON reload lost a distinct part")
        scrNTTEFullQuestHubNaturalMove(hub.main.chest.x,hub.main.chest.y+64)
        floors_before_hearts=instance_number(Floor)
        scrNTTEFullQuestHubNaturalChange(5);return;
    }
    if(phase==5) {
        scrNTTEFullQuestHubNaturalMergeDiagnostic()
        scrNTTEFullQuestHubNaturalObserveMerges()
        scrNTTEFullQuestHubNaturalShootEnemies()
        if(!merges_seen[2] || instance_exists(NTTEFullCrystalHeartBullet) || instance_exists(enemy)) return;
        assert(array_length(hearts_seen)==8 && instance_number(Floor)>floors_before_hearts,
            "Actual HeartBullets did not naturally exit and execute native submap generation")
        var _counts={}
        for(var _i=0;_i<array_length(heart_areas);++_i) {
            var _key=string(heart_areas[_i]);variable_struct_set(_counts,_key,scrNTTEFullValue(_counts,_key,0)+1)
            assert(!instance_exists(hearts_seen[_i]),"Actual source heart gate was cleared before a real bullet ended")
        }
        var _areas=[area_vault,area_palace,area_hq,scrNTTEFullAreaId("red")]
        for(var _i=0;_i<4;++_i) {
            var _area=_areas[_i]
            assert(scrNTTEFullValue(_counts,string(_area),0)==2,"Natural quest hub lost original each-part two area heart destinations")
        }
        assert(array_length(enemies_seen)>0 && shot_count>0,"Natural quest acceptance never exercised generated enemy/real combat clearing")
        assert(heart_gate_intervals>0 && enemy_gate_intervals>0,
            "Natural quest acceptance omitted whole-frame HeartBullet and generated enemy countdown-freeze witnesses")
        assert(instance_exists(full_pickup),"Naturally merged four-part physical pickup disappeared before native collection")
        scrNTTEFullQuestHubNaturalMove(full_pickup.x,full_pickup.y)
        want_pick=true;phase=6;elapsed=0;return;
    }
    if(phase==6) {
        if(array_length(scrNTTEFullQuestPartList(player.wep,player.ntte_state))<4) {
            if(instance_exists(full_pickup)) scrNTTEFullQuestHubNaturalMove(full_pickup.x,full_pickup.y)
            return;
        }
        want_pick=false
        scrNTTEFullQuestArtifactSpriteAssert(player.wep,player.ntte_state,sprNTTERefQuestArtifactMerge,[0,1,2,3])
        assert(!instance_exists(full_pickup),"Native four-part collection duplicated held/ground root")
        locked=hub.main.chest;unlock_bones=instance_number(NTTEFullCrabboneBone)
        scrNTTEFullQuestHubNaturalMove(locked.x,locked.y+8)
        want_pick=true;phase=7;elapsed=0;return;
    }
    if(phase==7) {
        if(instance_exists(locked)) return;
        want_pick=false
        assert(array_length(scrNTTEFullQuestPartList(player.wep,player.ntte_state))==0,
            "Actual source UNLOCK Prompt did not consume all four held physical parts")
        reward=instance_find(NTTEFullHugeQuestChest,0)
        assert(instance_exists(reward),"Actual source native UNLOCK Prompt omitted ultimate reward chest")
        var _broken=0
        with(NTTEFullCrabboneBone) if(broken && creator==other.player) _broken++
        assert(_broken==4 && instance_number(NTTEFullCrabboneBone)>=unlock_bones+4,
            "Actual UNLOCK native Step did not emit exactly four source broken artifact projectiles")
        scrNTTEFullQuestHubNaturalMove(reward.x,reward.y)
        scrNTTEFullQuestHubNaturalChange(8);return;
    }
    if(phase==8) {
        if(instance_exists(reward)) return;
        assert(scrNTTEFullUnlockGet("race:beetle"),"Actual ultimate chest contact after natural hub chain did not unlock Beetle")
        var _quasar=false
        with(WepPickup) if(wep==wep_ntte_ultra_quasar_rifle) _quasar=true
        assert(_quasar,"Actual source ultimate chest omitted its Ultra Quasar reward")
        global.ntte_full_progress={schema:1,unlocks:{},loadouts:{},stats:{}}
        assert(scrNTTEFullProgressLoad() && scrNTTEFullUnlockGet("race:beetle"),"Natural hub completion/Beetle ownership lost real progress JSON reload")
        draw_start=draw_frames;phase=9;return;
    }
    if(draw_frames-draw_start<8) return;
    var _shots=shot_count,_enemies=array_length(enemies_seen)
    scrNTTEFullQuestHubNaturalFinish()
    scrNTTESmokeLog("FULL QUEST HUB NATURAL: "+(scrNTTEFullValue(id,"ntte_quest_stored_fixture",false)?"real four persisted components/Proto stored entry/":"four artifact factory chest contacts/native pickup inputs/QuestFloor DROP/persisted deposits/")
        +"120tick ordered merges/real attraction/eight natural HeartBullet exits+submaps/player bullets+native enemy deaths/four-part pickup/UNLOCK Prompt/broken disposal/ultimate reward+persisted Beetle OK @"+string(30/timescale)+" shots="+string(_shots)+" enemies="+string(_enemies)+"; four-region discovery unproven")
    instance_destroy(id,false)
}
function scrNTTEFullQuestHubNaturalStep() {
    try {scrNTTEFullQuestHubNaturalStepBody()}
    catch(_error) {scrNTTEFullQuestHubNaturalFinish();throw _error}
}

// Controlled local source-condition fixture. Native Pet/Player Step events;
// no claim of natural HQ combat, physical device input, or full room traversal.
function scrNTTEFullGuardianMiddleAlarmCase(_tag,_dx,_dy,_mode,_success,_right,_speed,_gun) {
    var _before=scrNTTEFullInstances(all),_x=160000,_y=160000,_p=instance_find(Player,0)
    try {
        var _pet=scrNTTEFullPetCreate(_x,_y,"Guardian")
        instance_create(_x,_y,LastDie)
        var _middle=noone
        if(_mode!="empty") _middle=instance_create(_x+_dx,_y+_dy,FloorMiddle)
        if(_mode=="wrong") _middle.sprite_index=mskNone
        if(_mode=="wrong-near") {
            var _wrong=instance_create(_x+4,_y,FloorMiddle)
            _wrong.sprite_index=mskNone
        }
        if(_mode=="blocked-near") instance_create(_x-80,_y,FloorMiddle)
        if(_mode=="wall" || _mode=="blocked-near") {
            instance_create(_x+16,_y-8,Wall)
            assert(collision_line(_x,_y,_middle.x,_middle.y,Wall,false,false),"Guardian fixture wall misses actual LOS")
            if(_mode=="blocked-near") assert(!collision_line(_x,_y,_x-80,_y,Wall,false,false),"Guardian fixture farther candidate is not clear")
        }
        _p.x=_x-128;_p.y=_y;_p.speed=0
        _pet.visible=true;_pet.can_escape=_mode!="escape-off";_pet.can_take=false
        _pet.sprite_index=_pet.spr_idle;_pet.image_index=0
        _pet.walk=0;_pet.speed=_speed;_pet.direction=17;_pet.right=_right;_pet.ntte_pet_alarm=0
        if(_gun) _pet.gunangle=123
        if(_mode=="leader") _pet.leader=_p
        if(_mode=="follow") _pet.follow_delay=3
        if(_mode=="dash") _pet.dash_charge=6
        var _friction=_pet.friction,_expected_speed=max(_speed,_friction*timescale),_face=point_direction(_x,_y,_x+_dx,_y+_dy)
        with(_pet) event_perform(ev_step,ev_step_normal)
        // BEGIN GUARDIAN MIDDLE READONLY ALARM DIAGNOSTIC
        var _diagnostic={tag:_tag,mode:_mode,actual_timescale:timescale,pet_exists:instance_exists(_pet),
            middle_exists:instance_exists(_middle),floor_middle_count:instance_number(FloorMiddle),
            actual_lockstep_stop:lockstep_stop,menu_exists:instance_exists(Menu),gencont_exists:instance_exists(GenCont),
            levcont_exists:instance_exists(LevCont),floormaker_exists:instance_exists(FloorMaker),
            expected_speed:_expected_speed,input_speed:_speed,initial_raw_friction:_friction,expected_face:_face}
        _diagnostic.epsilon={engine_epsilon:math_get_epsilon(),zero_lt_original:0<0.00001,
            zero_lt_twice:0<0.00002,zero_eq_original:0==0.00001,scaled_zero_lt:0*1000000<10}
        if(instance_exists(_pet)) _diagnostic.pet={x:_pet.x,y:_pet.y,walk:_pet.walk,alarm:_pet.ntte_pet_alarm,
            direction:_pet.direction,right:_pet.right,visible:_pet.visible,hp:_pet.hp,leader_exists:instance_exists(_pet.leader),
            follow_delay:_pet.follow_delay,dash_charge:_pet.dash_charge,can_escape:_pet.can_escape,
            raw_friction:_pet.friction,speed:_pet.speed,ntte_game_exists:instance_exists(_pet.ntte_game),
            actual_angle_delta:angle_difference(_pet.direction,_face),
            matches_walk:_pet.walk==6,matches_alarm:_pet.ntte_pet_alarm==6,
            matches_direction:abs(angle_difference(_pet.direction,_face))<0.00001,
            matches_direction_scaled:abs(angle_difference(_pet.direction,_face))*1000000<10,
            matches_speed_original:abs(_pet.speed-_expected_speed)<0.00001,
            matches_speed_scaled:abs(_pet.speed-_expected_speed)*1000000<10}
        if(instance_exists(_middle)) _diagnostic.middle={x:_middle.x,y:_middle.y,sprite_actual:_middle.sprite_index,
            sprite_expected:sprFloorMiddle,sprite_matches:_middle.sprite_index==sprFloorMiddle}
        if(instance_exists(_pet) && instance_exists(_middle)) {
            _diagnostic.distance=point_distance(_pet.x,_pet.y,_middle.x,_middle.y)
            _diagnostic.wall_los_raw=collision_line(_pet.x,_pet.y,_middle.x,_middle.y,Wall,false,false)
            _diagnostic.wall_los_clear=!_diagnostic.wall_los_raw
        }
        scrNTTESmokeLog("GUARDIAN MIDDLE ALARM READONLY "+json_stringify(_diagnostic))
        // END GUARDIAN MIDDLE READONLY ALARM DIAGNOSTIC
        assert(instance_exists(_pet),"Actual Guardian Step destroyed controlled alarm receiver: "+_tag)
        if(_success) {
            assert(_pet.walk==6 && _pet.ntte_pet_alarm==6 && abs(angle_difference(_pet.direction,_face))*1000000<10,
                "Guardian alarm lost source six-tick walk/direction/return: "+_tag)
            assert(abs(_pet.speed-_expected_speed)*1000000<10,
                "Guardian alarm lost logical-speed/native-friction minimum: "+_tag)
            var _expected_right=(_face<90 || _face>270) ? 1:((_face>90 && _face<270) ? -1:_right)
            assert(_pet.right==_expected_right,"Guardian source facing/cardinal preservation changed: "+_tag)
            assert(variable_instance_exists(_pet,"gunangle")==_gun,"Guardian movement invented optional gunangle: "+_tag)
            if(_gun) assert(abs(angle_difference(_pet.gunangle,_face))*1000000<10,"Guardian source optional gunangle not updated: "+_tag)
        } else assert(_pet.walk==0 && _pet.ntte_pet_alarm==60,
            "Guardian alarm bypassed a source eligibility/nearest/LOS/strict16 gate: "+_tag)
        scrNTTESmokeLog("GUARDIAN MIDDLE ALARM "+_tag+" @"+string(30/timescale)
            +" raw_friction="+string(_friction)+" input_speed="+string(_speed)
            +" actual_speed="+string(_pet.speed)+" walk="+string(_pet.walk)+" alarm="+string(_pet.ntte_pet_alarm))
    } finally { scrNTTEFullMergedRuntimeTestCleanup(_before) }
}
function scrNTTEFullGuardianMiddlePortalCase(_tag,_distance,_mode,_snap) {
    var _before=scrNTTEFullInstances(all),_x=164000,_y=164000,_p=instance_find(Player,0)
    try {
        _p.x=_x;_p.y=_y;_p.speed=0;_p.visible=true;_p.can_pick=true
        KeyCont.hold_fire[_p.index]=false;KeyCont.hold_spec[_p.index]=false;KeyCont.press_pick[_p.index]=false
        instance_create(_x-16,_y-16,Floor)
        instance_create(_x+128,_y,Floor);instance_create(_x-128,_y,Floor)
        instance_create(_x,_y+128,Floor);instance_create(_x,_y-128,Floor)
        var _middle=noone
        if(_mode!="empty") _middle=instance_create(_x+_distance,_y,FloorMiddle)
        if(_mode=="wrong" || _mode=="wrong-near") _middle.sprite_index=mskNone
        if(_mode=="wrong-near") instance_create(_x-20,_y,FloorMiddle)
        if(_mode=="wall") {
            instance_create(_x+8,_y-8,Wall)
            assert(collision_line(_x,_y,_middle.x,_middle.y,Wall,false,false),"Guardian snap fixture wall misses LOS")
        }
        instance_create(_x,_y,LastDie)
        var _execute=instance_create(_x,_y,LastExecute),_pet=scrNTTEFullPetCreate(_x,_y,"Guardian")
        _pet.visible=true;_pet.can_escape=true;_pet.sprite_index=_pet.spr_idle;_pet.walk=0;_pet.speed=0;_pet.ntte_pet_alarm=120
        GameCont.area=area_palace;GameCont.subarea=3;GameCont.lastarea=area_labs;GameCont.lastsubarea=1
        GameCont.ntte_full_pending_destination=undefined
        with(_pet) event_perform(ev_step,ev_step_normal)
        var _prompt=_pet.escape_prompt
        assert(instance_exists(_prompt) && _prompt.pick<0,"Real Guardian Step did not create ESCAPE prompt: "+_tag)
        KeyCont.press_pick[_p.index]=true
        with(_p) event_perform(ev_step,ev_step_normal)
        KeyCont.press_pick[_p.index]=false
        assert(_prompt.pick==_p.index,"Real Player Step did not pick Guardian ESCAPE prompt: "+_tag)
        var _spawns=instance_number(IDPDSpawn)
        with(_pet) event_perform(ev_step,ev_step_normal)
        var _portal=instance_find(Portal,0),_pending=GameCont.ntte_full_pending_destination,
            _expected_x=_snap ? _middle.x:_x,_expected_y=_snap ? _middle.y:_y
        assert(instance_number(Portal)==1 && _portal.x==_expected_x && _portal.y==_expected_y,
            "Guardian Portal lost nearest-any-sprite/strict32/unrestricted-LOS snap: "+_tag)
        assert(_portal.xprevious==_expected_x && _portal.yprevious==_expected_y,
            "Guardian Portal snap did not synchronize previous coordinates: "+_tag)
        assert(!_pet.can_escape && !instance_exists(_prompt) && instance_number(IDPDSpawn)==_spawns+6
            && _execute.hp==999999 && _execute.alarm[0]==-1 && _execute.mask_index==mskNone,
            "Guardian snap changed escape prompt/help arrivals/execution cancellation: "+_tag)
        assert(is_struct(_pending) && _pending.area==area_labs && _pending.subarea==1
            && _pending.ntte_full_guardian_source_stage && GameCont.area==area_palace && GameCont.subarea==3,
            "Guardian snap bypassed source-stage queue: "+_tag)
        with(_pet) event_perform(ev_step,ev_step_normal)
        assert(instance_number(Portal)==1 && instance_number(IDPDSpawn)==_spawns+6,
            "Guardian escape duplicated Portal/help arrivals: "+_tag)
        scrNTTESmokeLog("GUARDIAN MIDDLE PORTAL "+_tag+" @"+string(30/timescale)
            +" x="+string(_portal.x)+" y="+string(_portal.y)+" previous="+string(_portal.xprevious)+","+string(_portal.yprevious))
    } finally { scrNTTEFullMergedRuntimeTestCleanup(_before) }
}
function scrNTTEFullGuardianMiddleNativeTests() {
    var _state=scrNTTEFullVanillaFixtureBegin(),_players=scrNTTEFullAreaGeneratorSnapshot(Player),
        _keys=scrNTTEFullAreaGeneratorSnapshot(KeyCont),_uber=scrNTTEFullAreaGeneratorSnapshot(UberCont),
        _mus=scrNTTEFullAreaGeneratorSnapshot(MusCont),_progress=global.ntte_full_progress,_stop=lockstep_stop,
        _parked=scrNTTEFullInstances([NTTEFullPet,NTTEFullPrompt,Portal,LastDie,LastExecute,YungCuz,WepPickup,FloorMiddle])
    for(var _i=0;_i<array_length(_parked);++_i) instance_deactivate_object(_parked[_i])
    global.ntte_full_progress={schema:1,unlocks:{},loadouts:{},stats:{}};lockstep_stop=false
    try {
        scrNTTEFullGuardianMiddleAlarmCase("eligible",40,0,"normal",true,-1,0,false)
        scrNTTEFullGuardianMiddleAlarmCase("escape-off",40,0,"escape-off",false,-1,0,false)
        scrNTTEFullGuardianMiddleAlarmCase("leader",40,0,"leader",false,-1,0,false)
        scrNTTEFullGuardianMiddleAlarmCase("no-marker",40,0,"empty",false,-1,0,false)
        scrNTTEFullGuardianMiddleAlarmCase("wrong-sprite-only",40,0,"wrong",false,-1,0,false)
        scrNTTEFullGuardianMiddleAlarmCase("blocked",40,0,"wall",false,-1,0,false)
        scrNTTEFullGuardianMiddleAlarmCase("blocked-nearest-clear-farther",40,0,"blocked-near",false,-1,0,false)
        scrNTTEFullGuardianMiddleAlarmCase("strict16",16,0,"normal",false,-1,0,false)
        scrNTTEFullGuardianMiddleAlarmCase("inside16",15.99,0,"normal",false,-1,0,false)
        scrNTTEFullGuardianMiddleAlarmCase("outside16",16.01,0,"normal",true,-1,0,false)
        scrNTTEFullGuardianMiddleAlarmCase("follow-delay",40,0,"follow",false,-1,0,false)
        scrNTTEFullGuardianMiddleAlarmCase("dash-charge",40,0,"dash",false,-1,0,false)
        scrNTTEFullGuardianMiddleAlarmCase("ignore-nearer-wrong-sprite",40,0,"wrong-near",true,-1,0,false)
        scrNTTEFullGuardianMiddleAlarmCase("north-preserve-negative",0,-40,"normal",true,-1,0,true)
        scrNTTEFullGuardianMiddleAlarmCase("north-preserve-positive",0,-40,"normal",true,1,0,false)
        scrNTTEFullGuardianMiddleAlarmCase("south-preserve-positive",0,40,"normal",true,1,0,true)
        scrNTTEFullGuardianMiddleAlarmCase("south-preserve-negative",0,40,"normal",true,-1,0,false)
        scrNTTEFullGuardianMiddleAlarmCase("west-optional-angle",-40,0,"normal",true,1,0,true)
        scrNTTEFullGuardianMiddleAlarmCase("fast-speed-preserved",40,0,"normal",true,-1,2*timescale,true)
        scrNTTEFullGuardianMiddlePortalCase("inside32",31.99,"normal",true)
        scrNTTEFullGuardianMiddlePortalCase("strict32",32,"normal",false)
        scrNTTEFullGuardianMiddlePortalCase("outside32",32.01,"normal",false)
        scrNTTEFullGuardianMiddlePortalCase("no-marker",0,"empty",false)
        scrNTTEFullGuardianMiddlePortalCase("any-sprite",7,"wrong",true)
        scrNTTEFullGuardianMiddlePortalCase("nearest-any-sprite",7,"wrong-near",true)
        scrNTTEFullGuardianMiddlePortalCase("snap-no-LOS-gate",31,"wall",true)
    } finally {
        for(var _i=0;_i<array_length(_parked);++_i) instance_activate_object(_parked[_i])
        scrNTTEFullAreaGeneratorRestore(_players);scrNTTEFullAreaGeneratorRestore(_keys)
        scrNTTEFullAreaGeneratorRestore(_uber);scrNTTEFullAreaGeneratorRestore(_mus)
        scrNTTEFullVanillaFixtureEnd(_state);global.ntte_full_progress=_progress;lockstep_stop=_stop
    }
    scrNTTESmokeLog("SOURCE GUARDIAN MIDDLE: 19 native Pet Step alarm cases, 7 genuine ESCAPE/native Player input/Portal cases; strict16/32, sprite distinction, nearest-before-LOS, cardinal/optional gunangle and raw-friction mapping OK @"+string(30/timescale))
}

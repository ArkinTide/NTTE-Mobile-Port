function scrNTTEFullGuardianEscapeDestinationNativeTests() {
    var _state=scrNTTEFullVanillaFixtureBegin(),_players=scrNTTEFullAreaGeneratorSnapshot(Player),
        _keys=scrNTTEFullAreaGeneratorSnapshot(KeyCont),_uber=scrNTTEFullAreaGeneratorSnapshot(UberCont),
        _mus=scrNTTEFullAreaGeneratorSnapshot(MusCont),_progress=global.ntte_full_progress,
        _parked=scrNTTEFullInstances([NTTEFullPet,NTTEFullPrompt,Portal,LastDie,LastExecute,YungCuz,WepPickup]),
        _pending=scrNTTEFullValue(GameCont,"ntte_full_pending_destination",undefined),_oldStop=lockstep_stop
    for(var _i=0;_i<array_length(_parked);++_i) instance_deactivate_object(_parked[_i])
    global.ntte_full_progress={schema:1,unlocks:{},loadouts:{},stats:{}}
    try {
        var _p=instance_find(Player,0),_cases=[
            [area_desert,1,area_desert,2,""],
            [area_labs,1,area_palace,1,""],
            [area_palace,2,area_palace,3,""],
            [201,2,201,3,"ntte_visits_coast"],
            [201,3,202,1,"ntte_visits_coast"],
            [205,3,area_city,1,"ntte_visits_trench"]]
        for(var _loop=0;_loop<=1;++_loop) for(var _case=0;_case<array_length(_cases);++_case) {
            var _before=scrNTTEFullInstances(all),_target=_cases[_case],_x=144000+_case*256,_y=144000+_loop*256
            GameCont.area=area_palace;GameCont.subarea=3;GameCont.loops=_loop
            GameCont.lastarea=_target[0];GameCont.lastsubarea=_target[1]
            GameCont.gocrib=false;GameCont.can_advance_stage=true;GameCont.win=false;GameCont.killenemies=false
            GameCont.ntte_full_pending_destination=undefined;lockstep_stop=false
            _p.x=_x+16;_p.y=_y+16;_p.visible=true;_p.can_pick=true;_p.speed=0
            KeyCont.hold_fire[_p.index]=false;KeyCont.hold_spec[_p.index]=false;KeyCont.press_pick[_p.index]=false
            instance_create(_x,_y,Floor)
            // Real native IDPDSpawn chooses a real Floor >64px from Player.
            // These four genuine support tiles keep its constructor's source
            // selection loop satisfiable; no fake spawn/mask is substituted.
            instance_create(_x+128,_y,Floor);instance_create(_x-128,_y,Floor)
            instance_create(_x,_y+128,Floor);instance_create(_x,_y-128,Floor)
            var _last=instance_create(_p.x,_p.y,LastDie)
            // Actual common native Step owns the deferred source LastDie setup.
            with(GameCont) event_perform(ev_step,ev_step_normal)
            var _guardian=noone
            with(NTTEFullPet) if(array_get_index(_before,id)<0 && pet=="Guardian") _guardian=id
            assert(instance_exists(_guardian) && _guardian.can_escape && _last.ntte_guardian_setup,
                "Actual LastDie/common GameCont Step did not create the source escape Guardian")
            var _execute=instance_create(_p.x,_p.y,LastExecute)
            with(_guardian) event_perform(ev_step,ev_step_normal)
            var _prompt=_guardian.escape_prompt
            assert(instance_exists(_prompt) && !_guardian.can_take && _prompt.pick<0
                && string_pos("ESCAPE",_prompt.text)>0,"Actual Guardian Step did not offer its source ESCAPE prompt")
            // Press the actual native pickup input; native Player Step dispatches
            // the shared Prompt selector, then real Pet Step consumes its result.
            _p.x=_guardian.x;_p.y=_guardian.y
            KeyCont.press_pick[_p.index]=true
            with(_p) event_perform(ev_step,ev_step_normal)
            assert(_prompt.pick==_p.index,"Native Player pickup input did not select the genuine escape prompt")
            KeyCont.press_pick[_p.index]=false
            var _spawns=instance_number(IDPDSpawn)
            with(_guardian) event_perform(ev_step,ev_step_normal)
            var _destination=GameCont.ntte_full_pending_destination
            assert(!_guardian.can_escape && !instance_exists(_prompt) && instance_exists(Portal)
                && is_struct(_destination) && _destination.area==_target[0] && _destination.subarea==_target[1]
                && _destination.loops==_loop && _destination.ntte_full_guardian_source_stage
                && GameCont.area==area_palace && GameCont.subarea==3,
                "Actual escape did not retain the active throne world and queue its original source stage")
            assert(instance_number(IDPDSpawn)==_spawns+6 && _execute.hp==999999
                && _execute.alarm[0]==-1 && _execute.mask_index==mskNone,
                "Actual Guardian escape lost source help arrivals or execution cancellation")
            var _hard=GameCont.hard,_waypoints=GameCont.waypoints,
                _visits=_target[4]=="" ? 0:scrNTTEFullValue(GameCont,_target[4],0)
            with(GameCont) event_perform(ev_other,ev_room_end)
            assert(GameCont.area==_target[2] && GameCont.subarea==_target[3] && GameCont.loops==_loop
                && is_undefined(GameCont.ntte_full_pending_destination),
                "Actual native Room End committed Guardian's pre-finish stage or advanced it twice")
            assert(GameCont.waypoints==_waypoints+1 && GameCont.waypnt[_waypoints]==_target[2]
                && GameCont.waysub[_waypoints]==_target[3] && GameCont.waylps[_waypoints]==_loop
                && GameCont.hard==_hard+(scrGameIsHardmode()?2:1),
                "Guardian escape bypassed native single difficulty/waypoint bookkeeping")
            if(_target[4]!="") assert(scrNTTEFullValue(GameCont,_target[4],0)==_visits+1,
                "Guardian escape skipped or duplicated original custom source area_finish visits")
            scrNTTEFullMergedRuntimeTestCleanup(_before)
        }
        // Ordinary AreaSet is explicitly a FINAL target. The new native hook
        // must leave its semantics alone even when that target could advance.
        GameCont.area=area_palace;GameCont.subarea=3;GameCont.loops=0
        GameCont.gocrib=false;GameCont.can_advance_stage=true;GameCont.win=false
        scrNTTEFullAreaSet(area_desert,1,0)
        with(GameCont) event_perform(ev_other,ev_room_end)
        assert(GameCont.area==area_desert && GameCont.subarea==1 && GameCont.loops==0,
            "Guardian source-stage handling changed ordinary final-destination AreaSet semantics")
    }
    finally {
        for(var _i=0;_i<array_length(_parked);++_i) instance_activate_object(_parked[_i])
        scrNTTEFullAreaGeneratorRestore(_players);scrNTTEFullAreaGeneratorRestore(_keys)
        scrNTTEFullAreaGeneratorRestore(_uber);scrNTTEFullAreaGeneratorRestore(_mus)
        scrNTTEFullVanillaFixtureEnd(_state)
        global.ntte_full_progress=_progress;GameCont.ntte_full_pending_destination=_pending;lockstep_stop=_oldStop
    }
    scrNTTESmokeLog("SOURCE GUARDIAN ESCAPE DESTINATION: actual LastDie/common GameCont Step/Guardian ESCAPE prompt/native Player pickup/native Pet Step/Portal/help arrivals/native Room End, source final-stage advancement and native/custom finish once, unrelated final destinations unchanged, loops0/1 OK @"+string(30/timescale))
}

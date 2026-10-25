// Independently selected async acceptance: real cleanup, next ordinary generated
// biome, then return. To preserve the desktop harness this stays in its room;
// nonpersistent old-room instances receive their genuine RoomEnd/CleanUp events
// explicitly. This is not evidence of an OS/native room_restart transition.
function scrNTTEFullWorldEventsNextRoomDispose(_state) {
    var _events=scrNTTEFullWorldEventGet(all),_prompts=scrNTTEFullInstances(NTTEFullPrompt),
        _actors=scrNTTEFullInstances([NTTEFullTrapSpin,NTTEFullOriginalTable,GatorSmoke]),_tops=scrNTTEFullInstances(TopCont),_dark=[]
    for(var _i=0;_i<array_length(_tops);++_i) if(surface_exists(_tops[_i].dark)) array_push(_dark,_tops[_i].dark)
    // Real native entrypoint must release source bindings before family teardown.
    scrCleanupAreaInstances()
    for(var _i=0;_i<array_length(_events);++_i) assert(!instance_exists(_events[_i]),"Native cleanup kept an old source event controller")
    // scrCleanupAreaInstances removes hitme/damagesource/terrain families.
    // OriginalTable and GatorSmoke inherit prop/hitme and belong to that pass;
    // parentless nonpersistent TrapSpin belongs to engine room disposal instead.
    for(var _i=0;_i<array_length(_actors);++_i) if(instance_exists(_actors[_i])) {
        var _actor=_actors[_i]
        assert(!_actor.persistent && !instance_is(_actor,hitme) && !instance_is(_actor,damagesource),
            "Native area cleanup retained an actor belonging to its immediate teardown families")
        scrNTTESmokeLog("WORLD NEXT ROOM DISPOSAL PENDING actor="+object_get_name(_actor.object_index)
            +" id="+string(_actor)+" nonpersistent / outside native immediate cleanup families")
    }
    for(var _i=0;_i<array_length(_prompts);++_i) assert(!instance_exists(_prompts[_i]),"Native owner cleanup orphaned a persistent source prompt")
    var _steam=instance_number(Breath)
    instance_create(10016,10016,RainSplash)
    assert(instance_number(Breath)==_steam,"Old FirePit steam hook remained bound after actual native cleanup")
    // Genuine RoomEnd handlers own surfaces such as TopCont.dark. Follow the
    // engine's room-disposal boundary rather than silently freeing test surfaces.
    var _old=scrNTTEFullInstances(all)
    for(var _i=0;_i<array_length(_old);++_i) {
        var _inst=_old[_i]
        if(_inst==id || array_get_index(_state.before,_inst)>=0 || _inst.persistent) continue
        with(_inst) event_perform(ev_other,ev_room_end)
        if(instance_exists(_inst)) instance_destroy(_inst)
    }
    for(var _i=0;_i<array_length(_dark);++_i) assert(!surface_exists(_dark[_i]),"Actual old-room TopCont.RoomEnd retained its darkness surface")
    for(var _i=0;_i<array_length(_actors);++_i)
        assert(!instance_exists(_actors[_i]),"Actual old-room disposal retained an old held Den/trap actor")
    for(var _i=0;_i<array_length(_prompts);++_i)
        assert(!instance_exists(_prompts[_i]),"Actual old-room owner disposal orphaned a persistent source prompt")
    assert(!instance_exists(NTTEFullWorldEvent) && !instance_exists(Floor) && !instance_exists(FloorMaker),
        "Old-world cleanup/disposal retained terrain or generation state")
}
function scrNTTEFullWorldEventsNextRoomTests() {
    if(os_type!=os_windows || !scrNTTEFullSmokeEnabled()) throw "Next-room fixture requires explicit desktop full smoke"
    var _object=asset_get_index("NTTEFullWorldEventsNextRoomTest")
    assert(object_exists(_object) && !instance_exists(_object),"Next-room observer missing or already active")
    var _observer=instance_create(0,0,_object)
    with(_observer) {
        state=scrNTTEFullWorldEventsNaturalWorldCapture()
        profiles=[[area_scrapyards,2,102029,["FirePit"]],
                  [area_sewers,2,101013,["GatorDen","SewerPool"]],
                  [area_scrapyards,2,102029,["FirePit"]]]
        profile_index=0;phase=0;ticks=0;draw_frames=0;draw_start=0;selected=[]
        visible=true;depth=-100000
    }
}
function scrNTTEFullWorldEventsNextRoomDrawWitness() {draw_frames++}
function scrNTTEFullWorldEventsNextRoomStep() {
    with(Player) {hp=100000;max_hp=100000;nexthurt=current_frame+100000;speed=0;can_walk=false;can_aim=false}
    if(phase==0) {
        var _profile=profiles[profile_index],_found=false
        for(var _attempt=0;_attempt<512 && !_found;++_attempt) {
            scrNTTEFullWorldEventsNaturalWorldConfigure(state,_profile,_profile[2]+_attempt)
            var _gen=instance_create(0,0,GenCont)
            selected=scrNTTEFullWorldEventGet(all);_found=true
            for(var _i=0;_i<array_length(_profile[3]);++_i)
                if(!instance_exists(scrNTTEFullWorldEventGet(_profile[3][_i]))) _found=false
            if(!_found) {scrNTTEFullWorldEventsCleanup();scrNTTEFullMergedRuntimeTestCleanup(state.before)}
        }
        assert(_found,"Next-room seed sweep did not naturally select "+string(_profile[3]))
        ticks=0;phase=1;return;
    }
    ticks++
    assert(ticks<3600,"Next-room actual floor/alarm/live-frame chain timed out")
    if(phase==1) {
        if(instance_exists(GenCont) || instance_exists(FloorMaker)) return;
        assert(instance_number(Floor)>20 && instance_number(TopCont)==1 && instance_number(SubTopCont)==1,
            "Next real generated biome lacks actual terrain or duplicated native render controllers")
        for(var _i=0;_i<array_length(selected);++_i) assert(selected[_i].ntte_event_generated,"Next native finalization omitted source event create")
        if(instance_exists(scrNTTEFullWorldEventGet("FirePit"))) {
            var _steam=instance_number(Breath)
            instance_create(10016,10016,RainSplash)
            assert(instance_number(Breath)==_steam+1,"New/returned FirePit did not bind exactly one actual rain steam callback")
        }
        draw_start=draw_frames;phase=2;return;
    }
    if(draw_frames-draw_start<8) return;
    scrNTTESmokeLog("WORLD NEXT BIOME "+string(profiles[profile_index][0])+" real generated map/source event bindings/BackCont+Draw x8 OK")
    scrNTTEFullWorldEventsNextRoomDispose(state)
    if(++profile_index<array_length(profiles)) {phase=0;return;}
    var _state=state
    scrNTTEFullWorldEventsNaturalWorldRestore(_state)
    scrNTTESmokeLog("FULL WORLD NEXT BIOME native cleanup/real next map/return/RoomEnd surface disposal/steam rebind complete @"+string(30/timescale)+"; same desktop room, not room_restart")
    instance_destroy(id,false)
}

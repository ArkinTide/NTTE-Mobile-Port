// Independently selected asynchronous acceptance on genuine generated maps.
// Disturb a real table / approach the real arena, then let the engine invoke
// NTTEFullWorldEvent.Step_0. No direct step call or manual event dispatch.
function scrNTTEFullWorldEventsScheduledWorldTests() {
    if(os_type!=os_windows || !scrNTTEFullSmokeEnabled()) throw "Scheduled world fixture requires explicit desktop full smoke"
    var _object=asset_get_index("NTTEFullWorldEventsScheduledWorldTest")
    assert(object_exists(_object) && !instance_exists(_object),"Scheduled world observer missing or already active")
    var _observer=instance_create(0,0,_object)
    with(_observer) {
        state=scrNTTEFullWorldEventsNaturalWorldCapture();old_stop=lockstep_stop
        profiles=[[area_sewers,2,101013,"GatorDen"],[area_scrapyards,2,102076,"RavenArena"]]
        profile_index=0;phase=0;ticks=0;draw_frames=0;draw_start=0;selected_event=noone;members=[]
        visible=true;depth=-100000
    }
}
function scrNTTEFullWorldEventsScheduledWorldDrawWitness() {draw_frames++}
function scrNTTEFullWorldEventsScheduledWorldStep() {
    with(Player) {hp=100000;max_hp=100000;nexthurt=current_frame+100000;speed=0;can_walk=false;can_aim=false}
    if(phase==0) {
        var _profile=profiles[profile_index],_found=false
        lockstep_stop=false
        for(var _attempt=0;_attempt<512 && !_found;++_attempt) {
            scrNTTEFullWorldEventsNaturalWorldConfigure(state,_profile,_profile[2]+_attempt)
            var _gen=instance_create(0,0,GenCont)
            selected_event=scrNTTEFullWorldEventGet(_profile[3]);_found=instance_exists(selected_event)
            if(!_found) {scrNTTEFullWorldEventsCleanup();scrNTTEFullMergedRuntimeTestCleanup(state.before)}
        }
        assert(_found,"Scheduled real-world seed sweep did not select "+_profile[3])
        ticks=0;phase=1;return;
    }
    ticks++
    assert(ticks<3600,"Scheduled world native floor/alarm/Step acceptance timed out")
    if(phase==1) {
        if(instance_exists(GenCont) || instance_exists(FloorMaker)) return;
        assert(instance_number(Floor)>20 && selected_event.ntte_event_generated,
            "Scheduled acceptance did not complete real native map generation")
        var _event=selected_event
        with(Player) {x=_event.x+1000;y=_event.y+1000;xprevious=x;yprevious=y}
        if(_event.event_name=="GatorDen") {
            assert(array_length(_event.inst)>=5,"Natural Den has no source held table/occupants to disturb")
            members=array_create(array_length(_event.inst));array_copy(members,0,_event.inst,0,array_length(_event.inst))
            assert(instance_is(members[0],NTTEFullOriginalTable),"Natural Den first member is not its original real table")
            // Real table destruction is the normal missing-member disturbance.
            lockstep_stop=true;instance_destroy(members[0])
        }
        else {
            assert(array_length(_event.inst_top)>0,"Natural RavenArena lacks its actual waiting audience")
            members=array_create(array_length(_event.inst_top));array_copy(members,0,_event.inst_top,0,array_length(_event.inst_top))
            lockstep_stop=true
            with(Player) {x=_event.x;y=_event.y;xprevious=x;yprevious=y}
        }
        ticks=0;draw_start=draw_frames;phase=2;return;
    }
    if(phase==2) {
        if(ticks<3) return;
        var _event=selected_event
        assert(lockstep_stop,"Scheduled guard fixture lost its lockstep pause")
        if(_event.event_name=="GatorDen") assert(array_length(_event.inst)==array_length(members),
            "Real Den Step ignored the registered lockstep-stop guard")
        else {
            assert(array_length(_event.inst_top)==array_length(members),
                "Real Arena Step ignored the registered lockstep-stop guard")
            for(var _i=0;_i<array_length(members);++_i) if(instance_exists(members[_i]))
                assert(members[_i].jump_time<0,"Arena audience flew during actual guarded frames")
        }
        lockstep_stop=false;ticks=0;phase=3;return;
    }
    if(ticks<3 || draw_frames-draw_start<8) return;
    var _event=selected_event
    if(_event.event_name=="GatorDen") {
        assert(array_length(_event.inst)==0,"Real registered Den Step did not release its entire disturbed group")
        for(var _i=1;_i<array_length(members);++_i) if(instance_exists(members[_i]))
            assert(!scrNTTEFullValue(members[_i],"ntte_full_den_hold",false),
                "Actual Den native occupant stayed held after scheduled disturbance")
    }
    else {
        assert(array_length(_event.inst_top)==0 && array_length(_event.inst_idle)==0,
            "Real registered Arena Step did not release audience and idle population within source96 radius")
        for(var _i=0;_i<array_length(members);++_i) if(instance_exists(members[_i]))
            assert(members[_i].jump_time>=0,"Actual Arena spectator retained its source negative hold timer")
    }
    scrNTTESmokeLog("WORLD SCHEDULED "+_event.event_name+" real generated map / lockstep guard / actual object Step release / BackCont+Draw OK")
    scrNTTEFullWorldEventsCleanup();scrNTTEFullMergedRuntimeTestCleanup(state.before)
    if(++profile_index<array_length(profiles)) {phase=0;return;}
    var _state=state,_stop=old_stop
    lockstep_stop=_stop;scrNTTEFullWorldEventsNaturalWorldRestore(_state)
    scrNTTESmokeLog("FULL WORLD SCHEDULED real natural Den/Arena native object Step/guard/group+audience release complete @"+string(30/timescale))
    instance_destroy(id,false)
}

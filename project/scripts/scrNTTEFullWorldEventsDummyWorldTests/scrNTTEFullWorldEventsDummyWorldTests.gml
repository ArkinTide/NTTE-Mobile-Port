// Real naturally chosen Dummy, actual generated walls/WantBoss, native target
// death and registered controller Step. No test-triggered callback dispatch.
function scrNTTEFullWorldEventsDummyWorldTests() {
    if(os_type!=os_windows || !scrNTTEFullSmokeEnabled()) throw "Dummy world fixture requires explicit desktop full smoke"
    var _object=asset_get_index("NTTEFullWorldEventsDummyWorldTest")
    assert(object_exists(_object) && !instance_exists(_object),"Dummy world observer missing or already active")
    var _observer=instance_create(0,0,_object)
    with(_observer) {
        state=scrNTTEFullWorldEventsNaturalWorldCapture();phase=0;ticks=0;draw_frames=0;draw_start=0
        selected_event=noone;chosen_seed=0;visible=true;depth=-100000
    }
}
function scrNTTEFullWorldEventsDummyWorldDrawWitness() {draw_frames++}
function scrNTTEFullWorldEventsDummyWorldStep() {
    with(Player) {hp=100000;max_hp=100000;nexthurt=current_frame+100000;speed=0;can_walk=false;can_aim=false}
    if(phase==0) {
        var _profile=[area_desert,2,100005],_found=false
        for(var _attempt=0;_attempt<1024 && !_found;++_attempt) {
            chosen_seed=_profile[2]+_attempt
            scrNTTEFullWorldEventsNaturalWorldConfigure(state,_profile,chosen_seed)
            GameCont.ntte_bigbandit_spawn=0
            // A marked Scorpion makes ScorpionCity certain. Its original
            // teevents933..947 replacement pass legitimately converts the
            // size1 TutorialTarget before the first live Dummy Step. This
            // target-death chain needs the ordinary unmarked-pet context;
            // combined-world acceptance separately keeps the marked City case.
            with(NTTEFullPet) if(pet=="Scorpion") scorpion_city=0
            var _gen=instance_create(0,0,GenCont)
            assert(!instance_exists(scrNTTEFullWorldEventGet("ScorpionCity")),
                "Unmarked real pet unexpectedly selected ScorpionCity in native Dummy target-death acceptance")
            selected_event=scrNTTEFullWorldEventGet("BlockedRoom")
            _found=instance_exists(selected_event) && selected_event.type=="Dummy"
            if(!_found) {scrNTTEFullWorldEventsCleanup();scrNTTEFullMergedRuntimeTestCleanup(state.before)}
        }
        assert(_found,"Natural source seed sweep never selected actual BlockedRoom Dummy variant")
        var _controllers=scrNTTEFullWorldEventGet(all),_names=[]
        for(var _i=0;_i<array_length(_controllers);++_i) array_push(_names,_controllers[_i].event_name)
        scrNTTESmokeLog("WORLD DUMMY NATURAL SELECTED seed="+string(chosen_seed)+" unmarked actual pet selected="+string(_names))
        ticks=0;phase=1;return;
    }
    ticks++
    assert(ticks<3600,"Natural Dummy/WantBoss/real target death acceptance timed out")
    if(phase==1) {
        if(instance_exists(GenCont) || instance_exists(FloorMaker)) return;
        scrNTTESmokeLog("WORLD DUMMY GENERATED seed="+string(chosen_seed)+" event_alive="+string(instance_exists(selected_event))
            +" generated="+string(scrNTTEFullValue(selected_event,"ntte_event_generated",false))
            +" dummy_spawn="+string(scrNTTEFullValue(selected_event,"dummy_spawn",-1))
            +" dummy_music="+string(scrNTTEFullValue(selected_event,"dummy_music",false))
            +" wantboss="+string(instance_number(WantBoss))+" bosses="+string(instance_number(BanditBoss))
            +" targets="+string(instance_number(TutorialTarget))+" tutorial="+string(instance_number(TutCont))
            +" debt="+string(GameCont.ntte_bigbandit_spawn)+" proto="+string(GameCont.proto)
            +" event_xy="+string([selected_event.x,selected_event.y])+" floors="+string(array_length(selected_event.floors))
            +" area_sub_max="+string([GameCont.area,GameCont.subarea,GameCont.maxsubarea]))
        var _diagnostic_event=selected_event
        with(TutorialTarget) scrNTTESmokeLog("WORLD DUMMY GENERATED target="+string(id)+" xy="+string([x,y])
            +" hp="+string(hp)+" center_overlap="+string(position_meeting(_diagnostic_event.x,_diagnostic_event.y,id)))
        with(WantBoss) scrNTTESmokeLog("WORLD DUMMY GENERATED want="+string(id)+" xy="+string([x,y])
            +" alarm0="+string(alarm[0])+" number="+string(number)+" enemies="+string(enemies)+" losthope="+string(losthope))
        assert(selected_event.ntte_event_generated && selected_event.dummy_spawn==1 && instance_exists(WantBoss),
            "Natural Dummy map lacks genuine selected room or native population WantBoss")
        var _event=selected_event,_count=0
        with(TutorialTarget) if(position_meeting(_event.x,_event.y,id)) {
            _count++;hp=0
        }
        assert(_count>0,"Actual natural Dummy create omitted its source eight-HP TutorialTarget")
        // Put the actual player close enough for WantBoss's genuine visibility
        // geometry. Source Step chooses its own real wall and restores position.
        with(Player) {x=_event.x;y=_event.y;xprevious=x;yprevious=y}
        ticks=0;draw_start=draw_frames;phase=2;return;
    }
    if(phase==2) {
        if(ticks<=4 || ticks mod 300==0) {
            scrNTTESmokeLog("WORLD DUMMY WAIT tick="+string(ticks)+" targets="+string(instance_number(TutorialTarget))
                +" dummy_spawn="+string(selected_event.dummy_spawn)+" dummy_music="+string(selected_event.dummy_music)
                +" want="+string(instance_number(WantBoss))+" bosses="+string(instance_number(BanditBoss))
                +" debt="+string(GameCont.ntte_bigbandit_spawn)+" lockstep="+string(lockstep_stop)
                +" source_attempt="+string(scrNTTEFullValue(selected_event,"ntte_dummy_spawn_trace",undefined)))
            var _event=selected_event
            with(Player) scrNTTESmokeLog("WORLD DUMMY WAIT player="+string(id)+" xy="+string([x,y])
                +" event_distance="+string(point_distance(x,y,_event.x,_event.y)))
            with(TutorialTarget) scrNTTESmokeLog("WORLD DUMMY WAIT target="+string(id)+" xy="+string([x,y])+" hp="+string(hp))
            with(WantBoss) scrNTTESmokeLog("WORLD DUMMY WAIT want="+string(id)+" xy="+string([x,y])+" target="+string(target)
                +" alarm0="+string(alarm[0])+" number="+string(number)+" enemies="+string(enemies)+" losthope="+string(losthope))
        }
        if(selected_event.dummy_spawn>0 || !instance_exists(BanditBoss)) return;
        assert(selected_event.dummy_spawn==0 && selected_event.dummy_music && GameCont.proto,
            "Actual scheduled Dummy Step omitted once-only spawn/music state")
        assert(GameCont.ntte_bigbandit_spawn==1,"Scheduled natural Dummy did not carry exactly one original BigBandit spawn debt")
        var _bosses=scrNTTEFullInstances(BanditBoss)
        assert(array_length(_bosses)==1,"Natural loop0 Dummy did not create exactly one real BanditBoss")
        assert(_bosses[0].hitid[1]=="BANDIT AMBUSH","Natural spawned boss missed source ambush hit identity")
        // Actual hp-driven native death must execute the inherited kill/drop
        // and boss music path, rather than destroying it without its events.
        _bosses[0].hp=0;ticks=0;phase=3;return;
    }
    if(instance_exists(BanditBoss) || ticks<4 || draw_frames-draw_start<8) return;
    assert(selected_event.dummy_spawn==0 && GameCont.ntte_bigbandit_spawn==1,
        "Actual boss death repeated natural Dummy spawn/debt")
    scrNTTESmokeLog("WORLD DUMMY NATURAL seed="+string(chosen_seed)+" real GenCont/WantBoss/8HP target death/registered Step/actual boss/debt1/native boss death+Draw OK")
    var _state=state
    scrNTTEFullWorldEventsNaturalWorldRestore(_state)
    scrNTTESmokeLog("FULL WORLD DUMMY NATURAL real scheduled target/boss/death chain complete @"+string(30/timescale))
    instance_destroy(id,false)
}

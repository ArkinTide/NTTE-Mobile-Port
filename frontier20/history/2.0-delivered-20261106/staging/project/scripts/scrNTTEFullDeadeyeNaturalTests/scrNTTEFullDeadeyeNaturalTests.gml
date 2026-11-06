// Explicit desktop acceptance only. BeginStep supplies controlled initial
// states; the engine owns Seal/Disc Step, native alarms, movement and collisions.
// Also observes actual visible-target AI in open/corner rooms. Audible mix and random encounter placement remain unverified.
function scrNTTEFullDeadeyeNaturalTests() {
    assert(os_type==os_windows && scrNTTEFullSmokeEnabled(),"Deadeye real-frame acceptance requires explicit desktop smoke")
    var _object=asset_get_index("NTTEFullDeadeyeNaturalTest")
    assert(object_exists(_object) && !instance_exists(_object),"Deadeye real-frame observer missing/duplicated")
    // The F9 harness can replace the engine speed with9990 after updating the
    // logical clock. The driver's selected pass is authoritative even when
    // that uncapped clock has subsequently returned timescale to1.
    var _driver=instance_find(NTTESmokeTest,0)
    assert(instance_exists(_driver),"Deadeye real-frame acceptance lost its selected smoke pass")
    var _selected_rate=_driver.rates[_driver.pass_index]
    assert(_selected_rate==30 || _selected_rate==60,"Deadeye real-frame acceptance only supports selected30/60")
    var _observer=instance_create(0,0,_object)
    with(_observer) {
        restored=false;old_save_map=UberCont.saveData;old_save_bytes=ds_map_write(old_save_map)
        fixture_save_map=ds_map_create();ds_map_copy(fixture_save_map,old_save_map);UberCont.saveData=fixture_save_map
        state=scrNTTEFullWorldEventsNaturalWorldCapture()
        old_trace=variable_global_exists("ntte_full_deadeye_observer")?global.ntte_full_deadeye_observer:undefined
        old_sounds=variable_global_exists("ntte_full_coast_sound_observer")?global.ntte_full_coast_sound_observer:undefined
        old_alarm_acc=global.alarm_topup_acc
        old_game_speed=game_get_speed(gamespeed_fps);old_time_scale=global.time_scale
        old_uncapped_requested=global.__debug_test_framerate_uncapped
        old_uncapped_active=UberCont.test_framerate_uncapped
        rate=_selected_rate;phase=-1;startup_frames=0;case_index=0;draw_frames=0;elapsed=0;all_traces=[]
        // The unrelated F9 test controllers execute from UberCont's ordinary
        // Step. Park their exact instances alongside the world, so they cannot
        // change the controlled player/disc between our real engine events.
        var _native_tests=scrNTTEFullInstances(TestCont)
        for(var _i=0;_i<array_length(_native_tests);++_i) {
            var _test=_native_tests[_i]
            if(array_get_index(state.parked,_test)<0) array_push(state.parked,_test)
            instance_deactivate_object(_test)
        }
        global.__debug_test_framerate_uncapped=false
        with(UberCont) {
            if(test_framerate_uncapped && game_get_speed(gamespeed_fps)==game_speed_uncaped)
                display_reset(display_aa,opt_vsync)
            test_framerate_uncapped=false
        }
        // OptionsUpdate can run from native menu destruction/Room Start.
        // Configure the private map too; never change the permanent options.
        save_set_value("options","framerate",rate)
        save_set_value("options","autopause",false)
        save_set_value("visual","freezeframes",0)
        save_set_value("visual","bossintro",false)
        UberCont.opt_framerate=rate;game_set_speed(rate,gamespeed_fps)
        // An uncapped background run can have gated off Draw events. The
        // fixture needs real Draw dispatch; restore the native gate at exit.
        draw_enable_drawevent(true)
        names=["source-cardinal-release","source-oblique-release","natural-open-hold","natural-wall-hold","actual-ai-open-two-disc","actual-ai-corner-two-disc"]
        player=instance_find(Player,0)
        global.ntte_full_progress=json_parse(json_stringify(state.progress))
        GameCont.area=area_desert;GameCont.loops=0;GameCont.crown=Crown.None;GameCont.ntte_full_active_coast=false
        GameCont.gocrib=false;GameCont.nochest=1;GameCont.noradch=1
        UberCont.opt_autopause=false;UberCont.paused=false;UberCont.want_pause=false
        UberCont.opt_freeze=0;UberCont.opt_bossintro=false
        scrNTTEFullFloorResetStyle();scrNTTEFullFloorResetAlign()
    }
}
function scrNTTEFullDeadeyeNaturalFinish() {
    if(restored) return;
    restored=true
    scrNTTEFullWorldEventsNaturalWorldRestore(state)
    global.ntte_full_deadeye_observer=old_trace;global.ntte_full_coast_sound_observer=old_sounds
    global.alarm_topup_acc=old_alarm_acc
    global.__debug_test_framerate_uncapped=old_uncapped_requested
    game_set_speed(old_game_speed,gamespeed_fps);global.time_scale=old_time_scale
    if(old_uncapped_active && old_game_speed==game_speed_uncaped) with(UberCont) display_reset(display_aa,false)
    if(old_uncapped_active && is_desktop)
        draw_enable_drawevent(((current_frame % 30)<timescale) || window_has_focus())
    UberCont.saveData=old_save_map
    if(ds_exists(fixture_save_map,ds_type_map)) ds_map_destroy(fixture_save_map)
    assert(ds_map_write(old_save_map)==old_save_bytes,"Deadeye fixture changed original permanent options/unlock map")
}
function scrNTTEFullDeadeyeNaturalSetup() {
    scrNTTEFullMergedRuntimeTestCleanup(state.before)
    // Captured native world instances are parked. A smaller32px-aligned origin
    // keeps native float32 position ULP below the unchanged0.001px oracle.
    player.x=4800;player.y=4928;player.xprevious=player.x;player.yprevious=player.y
    player.speed=0;player.can_walk=false;player.can_aim=false;player.hp=100000;player.max_hp=100000
    player.nexthurt=current_frame+100000;player.wep=wep_revolver;player.bwep=wep_revolver;player.ntte_pet=[]
    scr_camera_set_position(4800,4800,fa_center,fa_middle)
    scrNTTEFullFloorFill(4800,4800,15,15)
    if(case_index>=4) random_set_seed(210005+case_index)
    seal=instance_create(4800,4800,NTTEFullSeal)
    assert(seal.toss_ammo==2 && seal.toss==noone,"Deadeye native constructor lost original two-disc loadout")
    seal.type=NTTEFullSealType.Deadeye
    with(seal) scrNTTEFullSealSetup()
    seal.sprite_index=seal.spr_idle;
    if(case_index>=4) {scrNTTEFullDeadeyeAISetup();return;}
    seal.ntte_seal_timer1=1000;seal.ntte_seal_timer2=-1
    seal.walk=0;seal.slide=0;seal.speed=0;seal.wkick=0;seal.gunangle=0
    // Controlled final held disc. Its complete hold/release and subsequent
    // empty-loadout transition are measured through ordinary engine frames.
    seal.toss_ammo=0;seal.toss_time=60;seal.toss_speed=8;seal.toss_spin=0
    with(seal) toss=scrNTTEFullSealShot(NTTEFullSealDisc,0)
    disc=seal.toss;disc_start_team=disc.team
    assert(disc.creator==seal && disc.team==seal.team && instance_is(disc,Disc)
        && disc.damage==6 && disc.friction==0,"Deadeye fixture bypassed original native Disc factory/stats")
    global.ntte_full_deadeye_observer=[];global.ntte_full_coast_sound_observer=[]
    elapsed=0;frames=0;draw_start=draw_frames;release_elapsed=-1;wall_made=false
    seen_bounces=[];bounce_trace=[];motion_trace=[];saw_neutral=false;held_frames=0;last_disc_x=disc.x;last_disc_y=disc.y
    if(case_index<2) {
        source_angle=case_index==0?-90:30
        seal.toss_time=0;seal.toss_spin=48;seal.gunangle=source_angle+90
        disc.speed=8*timescale;disc.direction=source_angle-48*timescale
    }
    else if(case_index==3) {
        // A nearby side wall exercises the source's normal separation/orbit
        // logic. A second wall is placed ahead only after the real release,
        // supplying a native travel/collision witness without blocking an AI.
        side_wall=instance_create(seal.x-8,seal.y+20,Wall)
    }
    phase=1
}
function scrNTTEFullDeadeyeNaturalBeginBody() {
    if(phase==-1) {
        // Wait through one whole ordinary UberCont frame. Its native clock,
        // rather than a fixture assignment, establishes the measured scale.
        if(++startup_frames<2) return;
        phase=0
    }
    var _actual_rate=game_get_speed(gamespeed_fps),_expected_scale=30.0/rate,
        _scale_delta=timescale-_expected_scale,
        _rate_ok=_actual_rate==rate,
        // GML's default epsilon1e-5 makes even0<1e-6 false. Scale both sides
        // of the same1e-6 bound; never assign the native clock or its epsilon.
        _scale_ok=abs(_scale_delta)*1000000<1,
        _requested_ok=!global.__debug_test_framerate_uncapped,
        _uncapped_ok=!UberCont.test_framerate_uncapped
    var _clock={selected:rate,speed:_actual_rate,scale:timescale,option:UberCont.opt_framerate,
        saved:save_get_value("options","framerate",-1),requested:global.__debug_test_framerate_uncapped,
        uncapped:UberCont.test_framerate_uncapped,startup:startup_frames,
        native_tests:instance_number(TestCont),driver_active:instance_number(NTTESmokeTest),
        rate_ok:_rate_ok,scale_ok:_scale_ok,requested_ok:_requested_ok,uncapped_ok:_uncapped_ok,
        speed_precise:string_format(_actual_rate,0,15),scale_precise:string_format(timescale,0,15),
        expected_precise:string_format(_expected_scale,0,15),delta_precise:string_format(_scale_delta,0,15),
        epsilon_precise:string_format(math_get_epsilon(),0,15),legacy_scale_ok:abs(_scale_delta)<0.000001,
        zero_error_accepted:abs(0.0)*1000000<1,above_bound_rejected:!(abs(0.000002)*1000000<1)}
    if(phase==0 && case_index==0) scrNTTESmokeLog("DEADEYE REAL CLOCK "+json_stringify(_clock))
    assert(_rate_ok && _scale_ok && _requested_ok && _uncapped_ok,
        "Deadeye acceptance lost actual native frame rate "+json_stringify(_clock))
    if(phase==0) scrNTTEFullDeadeyeNaturalSetup()
    owner_begin_x=seal.x;owner_begin_y=seal.y
}
function scrNTTEFullDeadeyeNaturalCompleteCase() {
    var _trace={name:names[case_index],rate:rate,elapsed:elapsed,frames:frames,draws:draw_frames-draw_start,
        held_frames:held_frames,release_elapsed:release_elapsed,sounds:global.ntte_full_coast_sound_observer,
        branches:global.ntte_full_deadeye_observer,bounces:bounce_trace,motion:motion_trace}
    array_push(all_traces,_trace)
    scrNTTESmokeLog("DEADEYE REAL FRAMES "+json_stringify(_trace))
    if(++case_index<array_length(names)) {phase=0;return;}
    var _out=file_text_open_write(working_directory+"ntte-deadeye-real-frames-"+string(rate)+".json")
    file_text_write_string(_out,json_stringify(all_traces));file_text_close(_out)
    var _rate=rate
    scrNTTEFullDeadeyeNaturalFinish()
    scrNTTESmokeLog("FULL DEADEYE REAL FRAMES: independent source cardinal/oblique release coordinates after actual movement; original sixty-logical-tick hold, one ready pair/one spatial release pair, genuine native Disc Step+Alarm0 neutralization and Wall collision/DiscBounce trace, empty-loadout transition OK @"+string(_rate)+"; actual visible-target open/corner two-disc AI checked; audible mix and random encounter placement UNTESTED")
    instance_destroy(id,false)
}
function scrNTTEFullDeadeyeNaturalEndBody() {
    if(phase!=1) return;
    if(case_index>=4) {scrNTTEFullDeadeyeAIEnd();return;}
    elapsed+=timescale;frames++
    assert(elapsed<180,"Deadeye real-frame timeout case="+names[case_index])
    assert(instance_exists(seal) && instance_exists(disc),"Measured native Deadeye/disc vanished before acceptance")
    var _probe=global.ntte_full_deadeye_observer,_ready=0,_released=0,_release=undefined
    for(var _i=0;_i<array_length(_probe);++_i) {
        var _entry=_probe[_i]
        assert(_entry.owner==seal && _entry.disc==disc,"Deadeye trace included a foreign actor")
        if(_entry.kind=="ready") _ready++
        if(_entry.kind=="release") {_released++;_release=_entry}
    }
    assert(_ready<=1 && _released<=1,"Deadeye repeated actual ready/release sound branch for one held disc")
    var _sounds=global.ntte_full_coast_sound_observer
    assert(array_length(_sounds)==2*_released,"Deadeye duplicated/omitted actual spatial release sound pair")
    if(_released>0) {
        assert(_sounds[0].sound==sndDiscDie && _sounds[1].sound==sndMeleeFlip
            && _sounds[0].gain==2 && _sounds[1].gain==3
            && _sounds[0].pitch>=0.6 && _sounds[0].pitch<0.7 && _sounds[1].pitch>=0.8 && _sounds[1].pitch<1
            && _sounds[0].fade==64 && _sounds[1].fade==64 && _sounds[0].falloff==1 && _sounds[1].falloff==1
            && _sounds[0].x==_release.x && _sounds[0].y==_release.y
            && _sounds[1].x==_release.x && _sounds[1].y==_release.y,
            "Deadeye actual throw changed source sound, pitch, gain, falloff or release coordinates")
    }
    if(case_index<2) {
        var _expected_x=owner_begin_x+lengthdir_x(8,source_angle),_expected_y=owner_begin_y+lengthdir_y(8,source_angle),
            _raw_x=_expected_x-lengthdir_x(8*timescale,source_angle+90),
            _raw_y=_expected_y-lengthdir_y(8*timescale,source_angle+90)
        assert(frames==1 && _released==1 && _ready==0 && !instance_exists(seal.toss)
            && abs(_release.x-_raw_x)<0.001 && abs(_release.y-_raw_y)<0.001
            && abs(disc.x-_expected_x)<0.001 && abs(disc.y-_expected_y)<0.001,
            "Deadeye actual launch/movement disagrees with independent original logical/raw velocity oracle")
        array_push(motion_trace,{frame:current_frame,x:disc.x,y:disc.y,expected_x:_expected_x,expected_y:_expected_y})
        scrNTTEFullDeadeyeNaturalCompleteCase();return;
    }
    var _bounces=scrNTTEFullInstances(DiscBounce)
    for(var _i=0;_i<array_length(_bounces);++_i) if(array_get_index(seen_bounces,_bounces[_i])<0) {
        var _fx=_bounces[_i];array_push(seen_bounces,_fx)
        array_push(bounce_trace,{frame:current_frame,elapsed:elapsed,fx:_fx,x:_fx.x,y:_fx.y,held:instance_exists(seal.toss)})
    }
    if(instance_exists(seal.toss)) {
        held_frames++
        assert(_released==0 && disc.team==disc_start_team && disc.alarm[0]>=8 && disc.dist<=timescale+0.000001,
            "Actual native held Disc lost team/alarm refresh/distance reset")
        if(elapsed<=60) assert(seal.toss_time>=0,"Deadeye original hold timer underflowed before sixty ticks")
    }
    else if(release_elapsed<0) {
        assert(elapsed>60 && _ready==1 && _released==1,"Deadeye released before source sixty-tick hold or skipped one ready pair")
        release_elapsed=elapsed
        if(case_index==3) {
            var _wx=disc.x+lengthdir_x(48,disc.direction),_wy=disc.y+lengthdir_y(48,disc.direction)
            for(var _dx=-1;_dx<=1;++_dx) for(var _dy=-1;_dy<=1;++_dy)
                instance_create(_wx-8+16*_dx,_wy-8+16*_dy,Wall)
            wall_made=true
        }
    }
    if(disc.team==team_none) saw_neutral=true
    array_push(motion_trace,{frame:current_frame,elapsed:elapsed,x:disc.x,y:disc.y,speed:disc.speed,
        direction:disc.direction,alarm0:disc.alarm[0],dist:disc.dist,team:disc.team,held:instance_exists(seal.toss)})
    if(release_elapsed>=0 && elapsed-release_elapsed>=24) {
        assert(_ready==1 && _released==1 && held_frames>0 && saw_neutral && draw_frames-draw_start>=8
            && seal.type==NTTEFullSealType.None && seal.toss_speed==0 && seal.toss_spin==0,
            "Real-frame Deadeye omitted native Alarm0 neutralization, scheduled Draws or empty-loadout transition")
        if(case_index==3) assert(wall_made && array_length(bounce_trace)>0,
            "Deadeye wall scenario did not witness actual native Wall collision/DiscBounce sound branch")
        scrNTTEFullDeadeyeNaturalCompleteCase()
    }
}
function scrNTTEFullDeadeyeNaturalBegin() {
    try {scrNTTEFullDeadeyeNaturalBeginBody()}
    catch(_error) {scrNTTEFullDeadeyeNaturalFinish();throw _error}
}
function scrNTTEFullDeadeyeNaturalEnd() {
    try {scrNTTEFullDeadeyeNaturalEndBody()}
    catch(_error) {scrNTTEFullDeadeyeNaturalFinish();throw _error}
}

// Native Step/Alarm/motion/Collision remain the sole event drivers.
function scrNTTEFullDeadeyeAISetup() {
    player.x=5008;player.y=4904;player.xprevious=player.x;player.yprevious=player.y;
    player.wep=wep_none;player.bwep=wep_none;player.can_shoot=false;player.can_spec=false;
    seal.x=4938;seal.y=4842;seal.xprevious=seal.x;seal.yprevious=seal.y;seal.xstart=seal.x;seal.ystart=seal.y;
    if(case_index==5) {
        for(var _x=4904;_x<=4984;_x+=16) instance_create(_x,4816,Wall);
        for(var _y=4832;_y<=4928;_y+=16) instance_create(4904,_y,Wall);
    }
    assert(seal.toss_ammo==2 && seal.toss==noone && seal.ntte_seal_timer1>=20 && seal.ntte_seal_timer1<40,
        "AI fixture replaced source constructor/loadout");
    with(seal) {scrTarget();assert(instance_exists(target) && scrNTTEFullWorldTargetVisible()
        && !place_meeting(x,y,Wall),"AI target invisible or body inside Wall");}
    scr_camera_set_position(4938,4880,fa_center,fa_middle);
    global.ntte_full_deadeye_observer=[];global.ntte_full_coast_sound_observer=[];
    elapsed=0;frames=0;draw_start=draw_frames;release_elapsed=-1;held_frames=0;
    bounce_trace=[];motion_trace=[];ai_discs=[];ai_done_at=-1;ai_ammo=2;phase=1;
}
function scrNTTEFullDeadeyeAIEnd() {
    elapsed+=timescale;frames++;
    if(!instance_exists(seal) || seal.hp<=0 || elapsed>=900) {
        var _live=instance_exists(seal),_fault={name:names[case_index],rate:rate,elapsed:elapsed,frames:frames,
            alive:_live,hp:_live?seal.hp:undefined,ammo:ai_ammo,toss:_live?seal.toss:undefined,
            owner_x:_live?seal.x:undefined,owner_y:_live?seal.y:undefined,type:_live?seal.type:undefined,
            hold:_live?seal.toss_time:undefined,speed:_live?seal.toss_speed:undefined,spin:_live?seal.toss_spin:undefined,
            events:global.ntte_full_deadeye_observer,motion:motion_trace};
        var _out=file_text_open_write(working_directory+"ntte-deadeye-ai-failure-"+string(rate)+".json");
        file_text_write_string(_out,json_stringify(_fault));file_text_close(_out);
        assert(false,"Deadeye AI failure written: "+names[case_index]+" elapsed="+string(elapsed)+" alive="+string(_live));
    }
    assert(seal.toss_ammo>=0 && seal.toss_ammo<=ai_ammo,"AI duplicated source disc stock");ai_ammo=seal.toss_ammo;
    var _discs=scrNTTEFullInstances(NTTEFullSealDisc);
    for(var _i=0;_i<array_length(_discs);++_i) {
        var _d=_discs[_i],_known=false;if(_d.creator!=seal) continue;
        for(var _j=0;_j<array_length(ai_discs);++_j) if(ai_discs[_j].disc==_d) _known=true;
        if(_known) continue;
        assert(array_length(ai_discs)<2 && seal.toss==_d && seal.toss_time>0 && seal.toss_time<=60
            && seal.toss_speed>=7 && seal.toss_speed<=9 && _d.team==seal.team
            && _d.mask_index==mskNTTEFullSealDisc,"AI disc lost source loadout/hold/speed/team/mask");
        array_push(ai_discs,{disc:_d,created:current_frame,ready:0,released:0,wall:0,held_wall:0});
    }
    var _events=global.ntte_full_deadeye_observer,_released=0;
    for(var _j=0;_j<array_length(ai_discs);++_j) {
        var _r=ai_discs[_j];_r.ready=0;_r.released=0;_r.wall=0;_r.held_wall=0;
        for(var _i=0;_i<array_length(_events);++_i) {
            var _e=_events[_i];assert(_e.owner==seal,"Foreign actor in AI trace");if(_e.disc!=_r.disc) continue;
            if(_e.kind=="ready") _r.ready++;
            if(_e.kind=="release") {_r.released++;assert(_e.frame-_r.created>=60-timescale,"AI released before source hold");}
            if(_e.kind=="wall_bounce") {_r.wall++;if(_e.held) _r.held_wall++;}
        }
        assert(_r.ready<=1 && _r.released<=1 && (!_r.released || _r.ready==1),"AI repeated/skipped ready/release");
        _released+=_r.released;
    }
    assert(array_length(global.ntte_full_coast_sound_observer)==2*_released,"AI repeated/omitted spatial release pair");
    if(instance_exists(seal.toss)) {
        var _held=seal.toss;held_frames++;
        assert(_held.team==seal.team && _held.dist<=timescale+0.00001 && _held.alarm[0]>=8,"Held native Disc clock/team drift");
        array_push(motion_trace,{frame:current_frame,owner_x:seal.x,owner_y:seal.y,disc:real(_held),
            x:_held.x,y:_held.y,speed:_held.speed,direction:_held.direction,hold:seal.toss_time,spin:seal.toss_spin});
    }
    if(_released!=2 || seal.type!=NTTEFullSealType.None || instance_exists(seal.toss)) return;
    if(ai_done_at<0) ai_done_at=elapsed;if(elapsed-ai_done_at<24) return;
    assert(array_length(ai_discs)==2 && seal.toss_ammo==0 && seal.toss_speed==0 && seal.toss_spin==0
        && draw_frames-draw_start>=8,"AI failed original two-disc/unarmed/Draw lifecycle");
    bounce_trace=ai_discs;
    scrNTTESmokeLog("DEADEYE NATURAL AI "+json_stringify({name:names[case_index],rate:rate,discs:ai_discs}));
    scrNTTEFullDeadeyeNaturalCompleteCase();
}

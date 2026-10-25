// The observer schedules real Bullet1 collisions and normal engine Step/Draw.
// No measured production Step/Alarm/Destroy or animation is advanced manually.
function scrNTTEFullPitSquidKnockbackNativeTests() {
    assert(os_type==os_windows && scrNTTEFullSmokeEnabled(),"PitSquid regression needs desktop smoke")
    assert(!instance_exists(NTTEFullPitSquidKnockbackTest),"PitSquid observer duplicated")
    var _observer=instance_create(0,0,NTTEFullPitSquidKnockbackTest)
    with(_observer) {
        restored=false;old_save_map=UberCont.saveData;fixture_save_map=ds_map_create()
        ds_map_copy(fixture_save_map,old_save_map);UberCont.saveData=fixture_save_map
        state=scrNTTEFullWorldEventsNaturalWorldCapture()
        old_grid=variable_global_exists("ntte_full_trench_pit_grid")?global.ntte_full_trench_pit_grid:-1
        old_dirty=variable_global_exists("ntte_full_trench_pit_dirty")?global.ntte_full_trench_pit_dirty:false
        old_count=variable_global_exists("ntte_full_trench_floor_count")?global.ntte_full_trench_floor_count:-1
        old_sound=variable_global_exists("ntte_full_hurt_sound_observer")?global.ntte_full_hurt_sound_observer:undefined
        global.ntte_full_hurt_sound_observer=[]
        fixture_grid=ds_grid_create(1250,1250);ds_grid_clear(fixture_grid,true)
        global.ntte_full_trench_pit_grid=fixture_grid
        global.ntte_full_trench_pit_dirty=false
        rate=game_get_speed(gamespeed_fps)
        assert((rate==30 || rate==60) && abs(timescale-30/rate)<0.0001,"PitSquid requires actual30/60")
        player=instance_find(Player,0);phase=0;elapsed=0;draw_frames=0;hits=0;shots=0;next_shot=0;shot=noone
        checkpoint="configure"
        GameCont.area=area_desert;GameCont.lastarea=area_desert;GameCont.underwater=false
        GameCont.crown=Crown.None;GameCont.gocrib=false;GameCont.nochest=1;GameCont.noradch=1
        UberCont.opt_autopause=false;UberCont.paused=false;UberCont.want_pause=false;UberCont.opt_freeze=0
        UberCont.opt_bossintro=false
        player.x=18000;player.y=18000;player.xprevious=player.x;player.yprevious=player.y
        player.hp=100000;player.max_hp=100000;player.speed=0;player.can_walk=false;player.can_aim=false
        player.nexthurt=current_frame+100000;player.ntte_pet=[]
        scr_camera_set_position(player.x,player.y,fa_center,fa_middle)
        // The real Player Alarm10 removes nonboss enemies outside Floor.
        // Cover the arm's spawn and its scheduled movement, keeping that
        // normal cleanup alarm active throughout the collision regression.
        scrNTTEFullFloorResetStyle();scrNTTEFullFloorResetAlign();scrNTTEFullFloorFill(18128,18000,24,12)
        boss=instance_create(18128,18000,NTTEFullPitSquid)
        boss.ntte_full_intro=true;boss.ntte_full_can_intro=true;boss.ntte_full_timers=[-1,100000,100000,100000]
        boss.ntte_full_eye_laser=0;boss.ntte_full_eye_laser_delay=100000
        boss.max_hp=200;boss.hp=102;boss.ntte_full_ammo=0;boss.ntte_full_timers[2]=12
        boss.ntte_full_bite=0;boss.hspeed=1.25*timescale;boss.vspeed=-0.75*timescale
        var _boss=boss,_h=boss.hspeed,_v=boss.vspeed,_bx=boss.ntte_full_x,_by=boss.ntte_full_y
        // Direct/raw signed calls still own HP, source sound, half-health and
        // hidden coordinates. They do not reset the boss's existing velocity.
        with(player) scrNTTEFullRawHit(_boss,3,0)
        var _half_timer=boss.ntte_full_timers[2]
        assert(boss.hp==99 && boss.nexthurt==current_frame+6 && boss.ntte_full_bite==1
            && _half_timer>=45 && _half_timer<60 && boss.hspeed==_h && boss.vspeed==_v
            && boss.x==0 && boss.y==0 && boss.ntte_full_x==_bx && boss.ntte_full_y==_by,
            "PitSquid raw half-health callback lost HP/timer/velocity/hidden coordinates")
        with(player) {scrNTTEFullRawHit(_boss,1,0);scrNTTEFullRawHit(_boss,-1,0);scrNTTEFullRawHit(_boss,0,0)}
        var _hurt_count=0,_half_count=0
        for(var _i=0;_i<array_length(global.ntte_full_hurt_sound_observer);++_i) {
            var _e=global.ntte_full_hurt_sound_observer[_i]
            if(_e.target!=boss) continue
            if(_e.sound==boss.snd_hurt) {
                assert(_e.at && _e.x==_bx && _e.y==_by && _e.pitch>=1 && _e.pitch<=1.8 && _e.gain==3,
                    "PitSquid hurt must use real spatial coordinates, source pitch and gain3")
                _hurt_count++
            }
            if(_e.sound==boss.snd_lowh) {assert(_e.pitch==0.6,"PitSquid source Nothing2 half sound pitch changed");_half_count++}
        }
        assert(_hurt_count==4 && _half_count==1 && boss.hp==99 && boss.ntte_full_timers[2]==_half_timer,
            "PitSquid signed/zero raw handling or half-health once-only transition changed")
        var _probe=instance_create(18600,18000,Bullet1),_accepted=true
        with(_probe) _accepted=scr_projectile_hit(_boss,0,40*timescale,270)
        assert(!_accepted && boss.hp==99,"Ordinary nonpositive projectile boundary changed")
        with(_probe) {
            scrNTTEFullNativeProjectileDirectHit(_boss,0,40,270,0)
            scrNTTEFullNativeProjectileDirectHit(_boss,-1,40,270,0)
        }
        assert(boss.hp==100 && boss.hspeed==_h && boss.vspeed==_v,
            "Native-direct zero/signed callback appended force or lost authored damage")
        instance_destroy(_probe,false)
        // Frozen old generic tail oracle. Its force append is the defect,
        // independent of damage: twelve ordinary force7 hits accumulate84.
        var _legacy=instance_create(18512,18000,NTTEFullPitSquid)
        _legacy.speed=0
        repeat(12) with(_legacy) motion_add(0,7*timescale)
        legacy_speed=_legacy.speed/timescale
        assert(legacy_speed>=83.999,"Old force-tail oracle did not reproduce accumulated speed")
        instance_destroy(_legacy,false)
        boss.hp=10000;boss.max_hp=10000;boss.ntte_full_last_hp=boss.hp;boss.ntte_full_bite=0
        boss.ntte_full_timers=[-1,100000,100000,100000]
        with(boss) motion_set(0,1.5*timescale)
        start_x=boss.ntte_full_x;start_y=boss.ntte_full_y;peak_speed=boss.speed/timescale
        arm=instance_create(18208,18000,NTTEFullPitSquidArm)
        arm.creator=boss;arm.team=team_enemy;arm.hp=10000;arm.max_hp=10000
        arm.sprite_index=arm.spr_idle;arm.mask_index=arm.ntte_full_mask
        arm.ntte_full_timers=[-1,100000,100000,100000];arm.ntte_full_bomb=false
        arm_hp=arm.hp;boss_hp=boss.hp
        assert(position_meeting(arm.x,arm.y,Floor),"PitSquid arm fixture must start on native Floor support")
        checkpoint="configured"
        scrNTTESmokeLog("PIT SQUID FIXTURE "+json_stringify({player:player,boss:boss,arm:arm,observer:id,rate:rate,
            arm_hp:arm_hp,boss_hp:boss_hp,player_live:instance_exists(player),boss_live:instance_exists(boss),arm_live:instance_exists(arm)}))
    }
}
function scrNTTEFullPitSquidKnockbackFinish() {
    if(restored) return;
    restored=true
    // Restore grid ownership before restoring the parked natural world.
    global.ntte_full_trench_pit_grid=old_grid
    global.ntte_full_trench_pit_dirty=old_dirty;global.ntte_full_trench_floor_count=old_count
    if(ds_exists(fixture_grid,ds_type_grid)) ds_grid_destroy(fixture_grid)
    global.ntte_full_hurt_sound_observer=old_sound
    scrNTTEFullWorldEventsNaturalWorldRestore(state)
    UberCont.saveData=old_save_map
    if(ds_exists(fixture_save_map,ds_type_map)) ds_map_destroy(fixture_save_map)
}
function scrNTTEFullPitSquidKnockbackStepBody() {
    checkpoint="step identity"
    assert(game_get_speed(gamespeed_fps)==rate && abs(timescale-30/rate)<0.0001,
        "PitSquid native regression changed actual rate")
    assert(instance_exists(boss),"PitSquid fixture disappeared")
    assert(instance_exists(player),"PitSquid fixture player disappeared")
    checkpoint="player reset"
    player.speed=0;player.hp=100000;player.can_walk=false;player.can_aim=false;player.nexthurt=current_frame+100000
    elapsed+=timescale
    assert(elapsed<240,"PitSquid scheduled regression timed out phase="+string(phase))
    if(phase==0) {
        checkpoint="live arm identity"
        assert(instance_exists(arm),"PitSquid live arm disappeared during collision phase")
        assert(position_meeting(arm.x,arm.y,Floor),"PitSquid live arm left the fixture Floor support")
        checkpoint="live arm health"
        peak_speed=max(peak_speed,boss.speed/timescale)
        assert(boss.speed<=1.501*timescale,"Real arm projectile appended external force to hidden boss velocity")
        if(arm.hp<arm_hp) {
            var _loss=arm_hp-arm.hp
            assert(_loss==3 && boss_hp-boss.hp==_loss && !instance_exists(shot),
                "Actual Bullet1 collision lost native destruction or arm HP forwarding")
            hits++;arm_hp=arm.hp;boss_hp=boss.hp
        }
        if(shots<20 && elapsed>=next_shot && !instance_exists(shot)) {
            // The ordinary Bullet1 object/collision scheduler owns this hit.
            // Place an external stationary shot in the live arm's current mask;
            // its native damage3/knockback7 and actual collision remain intact.
            var _arm=arm,_shot=noone
            checkpoint="native Bullet1 creation"
            with(player) _shot=scr_projectile_create(_arm.x,_arm.y,Bullet1,0,0)
            shot=_shot
            shots++;next_shot=elapsed+7
        }
        if(hits<20) return;
        checkpoint="collision phase complete"
        assert(point_distance(start_x,start_y,boss.ntte_full_x,boss.ntte_full_y)>12 && draw_frames>=30,
            "PitSquid force fix disabled normal source movement or real drawing")
        instance_destroy(arm,false)
        // Scheduled source Decision must still add its authored motion. At
        // half emergence + pre-intro its source acceleration is unconditional.
        boss.ntte_full_intro=false;boss.ntte_full_pit_height=0.5;boss.ntte_full_sink=false
        boss.ntte_full_bite=0;boss.ntte_full_timers=[-1,1,100000,100000];boss.speed=0
        phase=1;elapsed=0;return;
    }
    if(phase==1) {
        checkpoint="scheduled AI witness"
        if(elapsed<2) return;
        assert(boss.speed>0,"PitSquid source AI decision lost its own acceleration")
        // A real grid land boundary tests the original EndStep reflection.
        // This is fixture terrain; no measured Step or bounce is invoked here.
        boss.ntte_full_intro=true;boss.ntte_full_pit_height=1;boss.ntte_full_sink=false
        boss.ntte_full_rise_delay=0;boss.ntte_full_timers=[-1,100000,100000,100000]
        boss.ntte_full_eye_laser=0;boss.ntte_full_eye_laser_delay=100000
        with(boss) {
            mask_index=ntte_full_mask;x=ntte_full_x;y=ntte_full_y-16
            other.boundary_col=floor((bbox_right-1)/16)+1
            mask_index=mskNone;x=0;y=0;motion_set(0,4*timescale)
        }
        ds_grid_set_region(fixture_grid,boundary_col,0,boundary_col,1249,false)
        bounce_start_x=boss.ntte_full_x;phase=2;elapsed=0;return;
    }
    if(phase==2) {
        checkpoint="scheduled reflection witness"
        if(boss.hspeed>=0) return;
        assert(boss.speed<=3.201*timescale && boss.ntte_full_x<bounce_start_x+32,
            "PitSquid source pit collision failed to retain rollback/reflection/speed*.8")
        var _rate=rate,_hits=hits,_peak=peak_speed,_old=legacy_speed,_draws=draw_frames
        scrNTTEFullPitSquidKnockbackFinish()
        scrNTTESmokeLog("FULL PIT SQUID KNOCKBACK NATIVE raw/signed/halfHP-once/spatial sound +20 real Bullet1-arm hits +no external force accumulation +AI acceleration +scheduled pit reflection OK @"
            +string(_rate)+"; hits="+string(_hits)+" oldTailSpeed="+string(_old)+" newPeak="+string(_peak)+" draws="+string(_draws)+"; mobile device not tested")
        instance_destroy(id,false)
    }
}
function scrNTTEFullPitSquidKnockbackStep() {
    try {scrNTTEFullPitSquidKnockbackStepBody()}
    catch(_error) {
        scrNTTESmokeLog("PIT SQUID FAILURE "+json_stringify({checkpoint:checkpoint,phase:phase,elapsed:elapsed,
            hits:hits,shots:shots,player:player,boss:boss,arm:arm,shot:shot,
            player_live:instance_exists(player),boss_live:instance_exists(boss),arm_live:instance_exists(arm),shot_live:instance_exists(shot)}))
        scrNTTEFullPitSquidKnockbackFinish();throw _error
    }
}

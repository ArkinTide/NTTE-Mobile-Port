// Every Bandit/Bullet1 collision, death and red-resource contact runs in normal frames.
function scrNTTEFullRedKillSourceNaturalTests() {
    assert(os_type==os_windows && scrNTTEFullSmokeEnabled(),"Red source acceptance requires explicit desktop smoke");
    var _object=asset_get_index("NTTEFullRedKillSourceNaturalTest"),_driver=instance_find(NTTESmokeTest,0);
    assert(object_exists(_object) && !instance_exists(_object) && instance_exists(_driver),"Red source observer/driver missing or duplicate");
    var _selected_rate=_driver.rates[_driver.pass_index],_observer=instance_create(0,0,_object);
    assert(_selected_rate==30 || _selected_rate==60,"Red source acceptance supports selected30/60 only");
    with(_observer) {
        restored=false;old_save_map=UberCont.saveData;old_save_bytes=ds_map_write(old_save_map);
        fixture_save_map=ds_map_create();ds_map_copy(fixture_save_map,old_save_map);UberCont.saveData=fixture_save_map;
        state=scrNTTEFullWorldEventsNaturalWorldCapture();test_skills=ds_list_create();
        old_alarm_acc=global.alarm_topup_acc;old_game_speed=game_get_speed(gamespeed_fps);old_time_scale=global.time_scale;
        old_uncapped_requested=global.__debug_test_framerate_uncapped;old_uncapped_active=UberCont.test_framerate_uncapped;
        old_console=global.console_active;global.console_active=false;
        old_directory=game_directory;scratch=working_directory+"red-kill-source-natural-"+string(get_timer())+"/";
        directory_create(scratch);game_directory=scratch;
        rate=_selected_rate;phase=-1;startup_frames=0;case_index=0;reward_index=0;elapsed=0;
        kill_target_count=32;weapons=[wep_ntte_annihilator,wep_ntte_entangler,wep_ntte_tunneller,wep_ntte_golden_tunneller];
        player=instance_find(Player,0);kill_rows=[];reward_rows=[];
        global.ntte_full_progress=json_parse(json_stringify(state.progress));
        // This isolated normal-run fixture owns the red pack; DiscoveryEndStep
        // correctly replaces unavailable carried weapons with bones otherwise.
        variable_struct_set(global.ntte_full_progress.unlocks,"pack:red",true);
        var _native_tests=scrNTTEFullInstances(TestCont);
        for(var _i=0;_i<array_length(_native_tests);++_i) {
            if(array_get_index(state.parked,_native_tests[_i])<0) array_push(state.parked,_native_tests[_i]);
            instance_deactivate_object(_native_tests[_i]);
        }
        global.__debug_test_framerate_uncapped=false;
        with(UberCont) {
            if(test_framerate_uncapped && game_get_speed(gamespeed_fps)==game_speed_uncaped) display_reset(display_aa,opt_vsync);
            test_framerate_uncapped=false;
        }
        save_set_value("options","framerate",rate);save_set_value("options","autopause",false);
        save_set_value("visual","freezeframes",0);save_set_value("visual","bossintro",false);
        UberCont.opt_framerate=rate;game_set_speed(rate,gamespeed_fps);
    }
}
function scrNTTEFullRedKillSourceNaturalFinish() {
    if(restored) return;
    restored=true;
    scrNTTEFullWorldEventsNaturalWorldRestore(state);
    global.alarm_topup_acc=old_alarm_acc;global.console_active=old_console;
    global.__debug_test_framerate_uncapped=old_uncapped_requested;
    game_set_speed(old_game_speed,gamespeed_fps);global.time_scale=old_time_scale;
    if(old_uncapped_active && old_game_speed==game_speed_uncaped) with(UberCont) display_reset(display_aa,false);
    UberCont.saveData=old_save_map;
    if(ds_exists(fixture_save_map,ds_type_map)) ds_map_destroy(fixture_save_map);
    if(ds_exists(test_skills,ds_type_list)) ds_list_destroy(test_skills);
    game_directory=old_directory;
    var _files=[scratch+"ntte-full-progress.json",scratch+"ntte-full-progress.json.bak",scratch+"ntte-full-progress.json.tmp"];
    for(var _i=0;_i<array_length(_files);++_i) if(file_exists(_files[_i])) file_delete(_files[_i]);
    assert(ds_map_write(old_save_map)==old_save_bytes,"Red source fixture changed permanent options/unlocks");
    assert(random_get_seed()==state.seed,"Red source fixture leaked engine RNG");
    for(var _i=0;_i<array_length(state.rng);++_i) assert(global.rng_state[_i]==state.rng[_i],"Red source fixture leaked RNG stream");
}
function scrNTTEFullRedKillSourceNaturalBase() {
    scrNTTEFullMergedRuntimeTestCleanup(state.before);
    scrNTTEFullAreaGeneratorRestore(state.game);scrNTTEFullAreaGeneratorRestore(state.players);
    ds_list_clear(test_skills);GameCont.skills=test_skills;GameCont.ntte_full_native_skill_counts={};
    GameCont.area=area_desert;GameCont.subarea=1;GameCont.loops=0;GameCont.maxsubarea=scrAreaGetMaxSubarea(area_desert);
    GameCont.finalsubarea=false;GameCont.crown=Crown.None;GameCont.gocrib=false;GameCont.underwater=false;
    GameCont.hard=5;GameCont.killenemies=false;GameCont.ntte_full_active_coast=false;
    GameCont.rad=0;GameCont.level=1;GameCont.skillpoints=0;GameCont.ultrapoints=0;GameCont.crownpoints=0;
    save_set_value("game","tutorial",false);
    UberCont.opt_autopause=false;UberCont.paused=false;UberCont.want_pause=false;UberCont.opt_freeze=0;UberCont.opt_bossintro=false;
    with(player) {
        x=9936;y=10016;xprevious=x;yprevious=y;speed=0;race=Race.Fish;
        hp=100000;max_hp=100000;lsthealth=100000;nexthurt=current_frame+100000;
        wep=wep_revolver;bwep=wep_none;ntte_state=undefined;bntte_state=undefined;
        curse=0;bcurse=0;extra_weps=[];ntte_extra_states=[];ntte_pet=[];
        can_walk=false;can_aim=false;can_pick=false;can_shoot=false;can_spec=false;
        ntte_red_ammo=0;ntte_red_amax=4;ntte_red_amax_muscle=0;
    }
    scrNTTEFullFloorResetStyle();scrNTTEFullFloorResetAlign();
    scrNTTEFullFloorFill(10112,10016,17,13);
    if(!instance_exists(TopCont)) instance_create(0,0,TopCont);
    scr_camera_set_position(10112,10016,fa_center,fa_middle);
}
function scrNTTEFullRedKillSourceNaturalClock() {
    var _scale_delta=timescale-30.0/rate;
    assert(game_get_speed(gamespeed_fps)==rate && UberCont.opt_framerate==rate
        && abs(_scale_delta)*1000000<1 && !global.__debug_test_framerate_uncapped && !UberCont.test_framerate_uncapped,
        "Red source acceptance lost selected native30/60 clock: "+json_stringify([rate,game_get_speed(gamespeed_fps),timescale]));
}
function scrNTTEFullRedKillSourceNaturalKillSetup() {
    scrNTTEFullRedKillSourceNaturalBase();
    raw_weapon=weapons[case_index div 2];raw_slot=case_index mod 2;
    assert(scrNTTEFullWeaponAvailable(raw_weapon),"Red-source fixture lacks authored red-pack ownership");
    player.wep=raw_slot==0?raw_weapon:wep_revolver;
    player.bwep=raw_slot==1?raw_weapon:wep_none;
    scrNTTESmokeLog("RED KILL SOURCE SLOT SETUP "+json_stringify({case_index:case_index,slot:raw_slot,expected:raw_weapon,wep:player.wep,bwep:player.bwep}));
    case_seed=704633+case_index*997;
    for(var _i=0;_i<array_length(global.rng_state);++_i) global.rng_state[@_i]=case_seed+_i*101;
    random_set_seed(case_seed);kills_before=GameCont.kills;
    victims=[];shots=[];damaged=[];
    for(var _i=0;_i<kill_target_count;++_i) {
        var _x=10112+32*(_i mod 8),_y=9968+32*(_i div 8),_enemy=instance_create(_x,_y,Bandit);
        assert(_enemy.hp==4 && _enemy.givekill && _enemy.team!=player.team,"Native Bandit creation/preconditions changed");
        array_push(victims,_enemy);
        var _sx=(_enemy.bbox_left+_enemy.bbox_right)/2,_sy=(_enemy.bbox_top+_enemy.bbox_bottom)/2,_shot=noone;
        with(player) _shot=scr_projectile_create(_sx,_sy,Bullet1,0,0);
        assert(instance_exists(_shot) && _shot.creator==player && _shot.team==player.team,"Native Bullet1 lost actual Player provenance");
        _shot.damage=100;_shot.knockback_speed=0;array_push(shots,_shot);
    }
    phase=1;elapsed=0;
}
function scrNTTEFullRedKillSourceNaturalNoKillReward() {
    var _legacy=scrNTTEFullInstances(NTTEPickup);
    for(var _i=0;_i<array_length(_legacy);++_i)
        assert(_legacy[_i].pickup_kind!=1,"Ordinary native enemy death emitted forbidden pilot red pickup: "+json_stringify([case_index,raw_weapon,raw_slot,case_seed,_legacy[_i].id]));
    assert(!instance_exists(NTTEFullRedAmmoPickup) && !instance_exists(NTTEFullRedAmmoChest),"Ordinary kills emitted unauthored canonical red resources");
    assert(player.ntte_red_ammo==0,"Ordinary native kills granted red energy without an authored resource source");
    assert((raw_slot==0?player.wep:player.bwep)==raw_weapon,
        "Kill source acceptance lost the raw-ID primary/secondary representation required to expose the pilot bug: "+json_stringify({case_index:case_index,phase:phase,elapsed:elapsed,slot:raw_slot,expected:raw_weapon,wep:player.wep,bwep:player.bwep,primary_raw:scrNTTEFullWeaponRaw(player.wep),secondary_raw:scrNTTEFullWeaponRaw(player.bwep)}));
}
function scrNTTEFullRedKillSourceNaturalKillEnd() {
    scrNTTEFullRedKillSourceNaturalNoKillReward();
    var _alive=0;
    for(var _i=0;_i<array_length(victims);++_i) {
        var _victim=victims[_i];
        if(instance_exists(_victim)) {
            _alive++;
            if(_victim.hp<=0 && array_get_index(damaged,_victim)<0) array_push(damaged,_victim);
        }
    }
    if(_alive>0 || elapsed<12) return;
    assert(array_length(damaged)==kill_target_count,"Acceptance missed actual lethal HP loss before native Bandit Step/Destroy");
    assert(GameCont.kills-kills_before==kill_target_count,"Native enemy death kill counter did not account for all actual Bandits");
    for(var _i=0;_i<array_length(shots);++_i) assert(!instance_exists(shots[_i]),"Native lethal Bullet1 did not execute its real collision/destruction path");
    var _row={case_index:case_index,raw_weapon:raw_weapon,raw_slot:raw_slot,seed:case_seed,
        victims:kill_target_count,accepted_lethal_hp:array_length(damaged),native_kills:GameCont.kills-kills_before,
        red_ammo:player.ntte_red_ammo,legacy_red_pickups:0,canonical_red_pickups:0};
    array_push(kill_rows,_row);scrNTTESmokeLog("RED KILL SOURCE NATURAL ordinary kills "+json_stringify(_row));
    case_index++;
    if(case_index<8) {phase=0;elapsed=0;return;}
    phase=2;elapsed=0;
}
function scrNTTEFullRedKillSourceNaturalRewardSetup() {
    scrNTTEFullRedKillSourceNaturalBase();
    player.wep=wep_revolver;player.bwep=wep_ntte_entangler;
    var _starts=[0,3,4,7,0,0],_expected=[1,4,4,8,1,2],_caps=[4,4,4,8,4,4];
    expected_ammo=_expected[reward_index];expected_cap=_caps[reward_index];player.ntte_red_ammo=_starts[reward_index];
    if(reward_index==3) {
        ds_list_add(test_skills,mut_back_muscle);
        GameCont.ntte_full_native_skill_counts[$ string(mut_back_muscle)]=1;
    }
    if(reward_index==5) GameCont.crown=crwn_haste;
    random_set_seed(809633+reward_index*101);
    reward_pull_seen=false;reward_start_distance=0;
    if(reward_index<4) reward=instance_create(player.x,player.y,NTTEFullRedAmmoChest);
    else {
        reward=instance_create(player.x+32,player.y,NTTEFullRedAmmoPickup);
        reward_start_distance=point_distance(reward.x,reward.y,player.x,player.y);
    }
    reward_num=reward.num;
    assert(reward_num==(reward_index==5?2:1),"Authored Red can/pickup quantity changed");
    phase=3;elapsed=0;
}
function scrNTTEFullRedKillSourceNaturalRewardEnd() {
    if(instance_exists(reward)) {
        if(reward_index>=4 && point_distance(reward.x,reward.y,player.x,player.y)<reward_start_distance) reward_pull_seen=true;
        return;
    }
    assert(player.ntte_red_ammo==expected_ammo && player.ntte_red_amax==expected_cap,
        "Actual native red resource contact lost authored quantity/capacity: "+json_stringify([reward_index,player.ntte_red_ammo,player.ntte_red_amax,expected_ammo,expected_cap]));
    if(reward_index>=4) assert(reward_pull_seen,"Actual red pickup did not attract to a secondary-slot red weapon before contact");
    phase=4;elapsed=0;
}
function scrNTTEFullRedKillSourceNaturalBegin() {
    try {
        if(phase<0) {
            startup_frames++;
            if(startup_frames<2) return;
            phase=0;
        }
        scrNTTEFullRedKillSourceNaturalClock();
        if(phase==0) scrNTTEFullRedKillSourceNaturalKillSetup();
        else if(phase==2) scrNTTEFullRedKillSourceNaturalRewardSetup();
        elapsed+=timescale;
        assert(elapsed<180,"Red source real-frame chain timed out: "+json_stringify([phase,case_index,reward_index,elapsed]));
        with(player) {
            hp=100000;max_hp=100000;lsthealth=100000;nexthurt=current_frame+100000;
            speed=0;can_walk=false;can_aim=false;can_pick=false;can_spec=false;
        }
    }
    catch(_error) {scrNTTEFullRedKillSourceNaturalFinish();throw _error}
}
function scrNTTEFullRedKillSourceNaturalEndBody() {
    if(phase<0) return;
    scrNTTEFullRedKillSourceNaturalClock();
    if(phase==1) {scrNTTEFullRedKillSourceNaturalKillEnd();return;}
    if(phase==3) {scrNTTEFullRedKillSourceNaturalRewardEnd();return;}
    if(phase!=4) return;
    assert(player.ntte_red_ammo==expected_ammo && player.ntte_red_amax==expected_cap,
        "A consumed native red source granted again after contact");
    if(elapsed<12) return;
    var _row={reward_index:reward_index,source:reward_index<4?"native-red-can":"native-red-pickup",
        num:reward_num,ammo:player.ntte_red_ammo,capacity:player.ntte_red_amax,
        secondary_pull:reward_pull_seen,haste:reward_index==5,stable_after_contact:elapsed};
    array_push(reward_rows,_row);scrNTTESmokeLog("RED KILL SOURCE NATURAL legal resource "+json_stringify(_row));
    reward_index++;
    if(reward_index<6) {phase=2;elapsed=0;return;}
    var _kills=kill_rows,_rewards=reward_rows,_rate=rate;
    scrNTTEFullRedKillSourceNaturalFinish();
    scrNTTESmokeLog("FULL RED KILL SOURCE NATURAL: four raw-ID red weapons x primary/secondary x32 actual Bandit/Bullet1 lethal collisions/native deaths, no unauthored red drops/grants; actual red cans +1/cap4/BackMuscle8 and secondary-attracted pickups/Haste2/one-time contact; original saves/options/RNG restored OK @"+string(_rate)+" kills="+json_stringify(_kills)+" rewards="+json_stringify(_rewards));
    instance_destroy(id,false);
}
function scrNTTEFullRedKillSourceNaturalEnd() {
    try {scrNTTEFullRedKillSourceNaturalEndBody()}
    catch(_error) {scrNTTEFullRedKillSourceNaturalFinish();throw _error}
}

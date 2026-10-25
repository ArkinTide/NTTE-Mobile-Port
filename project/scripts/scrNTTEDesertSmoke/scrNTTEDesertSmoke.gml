function scrNTTEDesertSmokeEnabled() {
    if (os_type!=os_windows) return false
    for(var _i=1;_i<=parameter_count();++_i)
        if (parameter_string(_i)=="--ntte-desert-smoke") return true
    return false
}

function scrNTTEDesertSmokeClear() {
    instance_destroy(GenCont,false)
    instance_destroy(FloorMaker,false)
    instance_destroy(Portal,false)
    instance_destroy(WantBoss,false)
    instance_destroy(WantPopo,false)
    instance_destroy(SpiralCont,false)
    instance_destroy(enemy,false)
    instance_destroy(prop,false)
    instance_destroy(chestprop,false)
    instance_destroy(projectile,false)
    instance_destroy(NTTEDesertDecor,false)
    instance_destroy(Floor,false)
    instance_destroy(Wall,false)
    instance_destroy(Top,false)
    instance_destroy(TutCont,false)
}

function scrNTTEDesertSmokeConnected() {
    var _start=instance_nearest(10016,10016,Floor),_queue=[_start],_seen=ds_map_create(),_pos=0
    _seen[? _start]=true
    while (_pos<array_length(_queue)) {
        var _f=_queue[_pos++]
        for(var _i=0;_i<4;++_i) {
            var _x=_f.x+16+round(lengthdir_x(32,_i*90)),_y=_f.y+16+round(lengthdir_y(32,_i*90)),
                _next=instance_position(_x,_y,Floor)
            if (instance_exists(_next) && !ds_map_exists(_seen,_next)) {
                _seen[? _next]=true
                array_push(_queue,_next)
            }
        }
    }
    var _count=ds_map_size(_seen)
    ds_map_destroy(_seen)
    assert(_count==instance_number(Floor),"NTTE generated disconnected room")
}

function scrNTTEDesertSmokeStep() {
    if (!variable_instance_exists(id,"desert_case")) {
        desert_case=0
        desert_rate=0
        desert_tick=0
        desert_generation=0
        desert_real=false
        desert_wait=0
        UberCont.custom=true
        UberCont.custom_options=new CustomModeOptions("NTTE DESERT SMOKE")
        variable_struct_remove(UberCont.custom_options,"ntte_desert_event")
        assert(scrNTTEDesertSetting()==0,"Old preset migration failed")
        // A non-desert map cannot receive even a forced desert event.
        GameCont.area=area_sewers
        var _count=instance_number(Floor)
        assert(scrNTTEDesertPopulate(NTTEDesertEvent.Camp)==NTTEDesertEvent.Off,"Desert event leaked into Sewers")
        assert(instance_number(Floor)==_count,"Non-desert guard altered geometry")
        scrNTTESmokeLog("DESERT MIGRATION AND AREA GUARD OK")
    }
    if (!instance_exists(Player)) { scrNTTESmokeLog("FAIL desert player lost"); game_end(); return; }
    with (Player) {
        hp=10000; max_hp=10000; lsthealth=10000
        nexthurt=current_frame+100
        can_walk=false; can_aim=false; speed=0
        x=10016; y=10016
        race=Race.Fish
    }
    if (desert_real) {
        desert_wait+=timescale
        if (instance_exists(GenCont)) {
            assert(desert_wait<900,"Native level generation timed out")
            return;
        }
        assert(GameCont.ntte_desert_last_event==desert_generation,"Native generation missed NTTE hook")
        scrNTTEDesertSmokeConnected()
        assert(instance_number(enemy)>0,"Generated event lost all enemies")
        scrNTTESmokeLog("NATIVE GENERATION OK "+scrNTTEDesertEventName(desert_generation))
        desert_real=false
        if (++desert_generation>3) {
            scrNTTESmokeLog("PASS DESERT 3 events x 3 rates; AI, death/cleanup, connected floors, migration, non-desert guard; 3 native generations")
            game_end()
            return;
        }
    }
    if (desert_rate>=3) {
        if (desert_generation==0) desert_generation=1
        scrNTTEDesertSmokeClear()
        GameCont.area=area_desert
        GameCont.subarea=3
        GameCont.hard=3
        GameCont.ntte_desert_last_event=0
        GameCont.rad=0
        UberCont.custom_options.ntte_desert_event=desert_generation
        save_set_value("game","tutorial",false)
        random_set_seed(4000+desert_generation)
        instance_create(0,0,GenCont)
        desert_real=true
        desert_wait=0
        return;
    }
    if (desert_tick==0) {
        scrNTTEDesertSmokeClear()
        var _fps=rates[desert_rate]
        UberCont.opt_framerate=_fps
        game_set_speed(_fps,gamespeed_fps)
        GameCont.area=area_desert; GameCont.subarea=3; GameCont.hard=3; GameCont.rad=0
        UberCont.custom_options.ntte_desert_event=desert_case+1
        random_set_seed(2500+desert_case)
        for(var _dx=-5;_dx<=5;++_dx) for(var _dy=-4;_dy<=4;++_dy)
            instance_create(10000+_dx*32,10000+_dy*32,Floor)
        with (Floor) mcr_floor_make_walls;
        instance_create(10016+96,10016,WeaponChest)
        instance_create(10016-96,10016,AmmoChest)
        instance_create(10016+144,10016,Cactus)
        var _chosen=scrNTTEDesertPopulate(desert_case+1)
        assert(_chosen==desert_case+1,"Forced event mismatch")
        scrNTTEDesertSmokeConnected()
        if (_chosen==NTTEDesertEvent.Camp) {
            assert(instance_number(NTTEBanditTent)==3,"Camp tent count")
            assert(instance_number(NTTECamperBandit)>=3 && instance_number(NTTEHikerBandit)==1,"Camp bandit spawns")
        }
        if (_chosen==NTTEDesertEvent.Nest) assert(instance_number(NTTEMaggotNest)==3,"Maggot nest count")
        if (_chosen==NTTEDesertEvent.Scorpions) assert(instance_number(NTTESilverScorpion)==1,"Silver scorpion spawn")
        // Place AI close enough to a real Player for visibility and burst tests.
        desert_baby=instance_create(10016+80,10016,NTTEBabyScorpion)
        desert_silver=instance_create(10016,10016+96,NTTESilverScorpion)
        desert_gold=instance_create(10016-80,10016,NTTEBabyScorpionGold)
        desert_baby.ntte_ai_timer=1; desert_silver.ntte_silver_decision=1; desert_gold.ntte_ai_timer=1
        scrNTTESmokeLog("DESERT START "+scrNTTEDesertEventName(_chosen)+" @"+string(_fps))
        desert_tick+=timescale
        return;
    }
    var _old=desert_tick
    desert_tick+=timescale
    if (_old<90 && desert_tick>=90) {
        assert(desert_baby.ntte_shots>0 && desert_gold.ntte_shots>0,"Baby scorpion did not fire")
        assert(desert_silver.ntte_shots>0,"Silver scorpion did not fire")
        with (NTTEMaggotNest) hp=0
        var _rock=instance_create(10096,10016,NTTEScorpionRock)
        _rock.hp=0
        instance_destroy(_rock)
    }
    if (_old<95 && desert_tick>=95) {
        assert(instance_number(NTTEMaggotNest)==0,"Dead nest retained")
        assert(instance_number(NTTEBabyScorpion)>=2,"Rock failed to release scorpion")
    }
    if (desert_tick>=120) {
        var _before=GameCont.kills
        instance_destroy(enemy,false)
        assert(GameCont.kills==_before,"Structural cleanup granted kills")
        instance_destroy(projectile,false)
        assert(instance_number(NTTEVenomPellet)==0,"Cleanup spawned secondary venom")
        scrNTTESmokeLog("DESERT OK "+string(desert_case+1)+" @"+string(rates[desert_rate]))
        desert_tick=0
        if (++desert_case>=3) { desert_case=0; ++desert_rate }
    }
}

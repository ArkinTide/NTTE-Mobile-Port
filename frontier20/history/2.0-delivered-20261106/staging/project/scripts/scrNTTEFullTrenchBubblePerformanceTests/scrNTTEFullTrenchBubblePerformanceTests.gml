// Frozen source hot-path oracles. Timings describe the desktop Runner.
function scrNTTEFullTrenchBubbleSmallOld() {
    if(lockstep_stop) return;
    if(!place_meeting(x,y,projectile)) return;
    var _me=id,_targets=[]
    with(projectile) if(team!=other.team && typ!=0) array_push(_targets,id)
    for(var _i=0;_i<array_length(_targets);++_i) {
        var _target=_targets[_i]
        if(instance_exists(_target) && place_meeting(x,y,_target))
            with(_target) if(place_meeting(x,y,_me)) instance_destroy()
    }
}
function scrNTTEFullTrenchBubbleSparksOld() {
    var _floors=[],_sparks=instance_number(NTTEFullPitSpark),_pits=scrNTTERefSprite("FloorTrenchB")
    with(Floor) if(sprite_index==_pits) array_push(_floors,id)
    ntte_full_timers[3]=random_range(1,12)+12*_sparks+30/max(1,array_length(_floors))
    if(ntte_full_pit_height<1 || !ntte_full_intro || array_length(_floors)==0) return;
    for(var _tries=0;_tries<10;++_tries) {
        var _floor=_floors[irandom(array_length(_floors)-1)],_fx=(_floor.bbox_left+(_floor.bbox_right-1)+1)/2,
            _fy=(_floor.bbox_top+(_floor.bbox_bottom-1)+1)/2,_distance=point_distance(_fx,_fy,x,y)
        if(_distance>96 && _distance<256 && !collision_rectangle(_floor.bbox_left,_floor.bbox_top,
            (_floor.bbox_right-1),(_floor.bbox_bottom-1),NTTEFullPitSpark,false,false)) {
            var _spark=instance_create(_fx,_fy,NTTEFullPitSpark)
            _spark.ntte_full_tentacle.move_dir=point_direction(x,y,_fx,_fy)
            break
        }
    }
}
function scrNTTEFullTrenchBubblePitCandidates(_clear,_fast) {
    var _result=[],_pits=scrNTTERefSprite("FloorTrenchB"),_xs=_clear.image_xscale,_ys=_clear.image_yscale
    _clear.image_xscale*=_clear.pit_clear;_clear.image_yscale*=_clear.pit_clear
    var _cl=_clear.bbox_left,_cr=_clear.bbox_right,_ct=_clear.bbox_top,_cb=_clear.bbox_bottom
    with(Floor) if(sprite_index!=_pits) {
        if(_fast && (bbox_right<_cl-1 || bbox_left>_cr+1 || bbox_bottom<_ct-1 || bbox_top>_cb+1)) continue
        if(place_meeting(x,y,_clear)) array_push(_result,id)
    }
    _clear.image_xscale=_xs;_clear.image_yscale=_ys
    return _result
}
function scrNTTEFullTrenchBubbleSparkRecords(_before) {
    var _records=[]
    with(NTTEFullPitSpark) if(array_get_index(_before,id)<0)
        array_push(_records,[x,y,sprite_index,image_index,image_angle,ntte_full_life,ntte_full_dark,ntte_full_tentacle])
    return json_stringify(_records)
}
function scrNTTEFullTrenchBubblePerformanceTests() {
    assert(os_type==os_windows && scrNTTEFullSmokeEnabled() && !instance_exists(GenCont),
        "Trench bubble performance requires a settled explicit desktop smoke")
    scrNTTEFullFloorInit()
    var _before=scrNTTEFullInstances(all),_area=GameCont.area,_water=GameCont.underwater,_crown=GameCont.crown,
        _seed=random_get_seed(),_native=scrNTTEFullArrayCopy(global.rng_state),_stop=lockstep_stop,
        _style=[global.ntte_full_floor_style,global.ntte_full_floor_area,global.ntte_full_floor_aw,
            global.ntte_full_floor_ah,global.ntte_full_floor_ax,global.ntte_full_floor_ay],
        _hidden=[],_particles=UberCont.opt_prtcls
    var _terrain=scrNTTEFullInstances([Floor,Wall,PortalClear,projectile])
    for(var _i=0;_i<array_length(_terrain);++_i) {
        array_push(_hidden,_terrain[_i]);instance_deactivate_object(_terrain[_i])
    }
    try {
        GameCont.area=area_desert;GameCont.underwater=true;GameCont.crown=Crown.None
        lockstep_stop=false;UberCont.opt_prtcls=true
        scrNTTEFullFloorResetStyle();scrNTTEFullFloorResetAlign()
        for(var _i=0;_i<128;++_i) {
            var _f=instance_create(15008+(_i mod 16)*64,15008+(_i div 16)*64,Floor)
            assert(instance_exists(_f),"Trench broad-phase fixture Floor rejected")
            _f.sprite_index=scrNTTERefSprite((_i mod 3)==0?"FloorTrenchB":"FloorTrench")
        }
        var _clear=instance_create(15112.25,15112.75,PortalClear)
        _clear.pit_clear=0.75
        for(var _case=0;_case<8;++_case) {
            _clear.image_xscale=(_case mod 2?-1:1)*(0.2+_case/7)
            _clear.image_yscale=0.2+_case/6;_clear.image_angle=17*_case
            var _old=scrNTTEFullTrenchBubblePitCandidates(_clear,false),
                _new=scrNTTEFullTrenchBubblePitCandidates(_clear,true)
            scrNTTEPerfOrderedEqual(_old,_new,"Pit exact masks/scaling/rotation "+string(_case))
        }
        var _pit_start=get_timer()
        repeat(64) scrNTTEFullTrenchBubblePitCandidates(_clear,false)
        var _pit_old_us=get_timer()-_pit_start
        _pit_start=get_timer()
        repeat(64) scrNTTEFullTrenchBubblePitCandidates(_clear,true)
        var _pit_new_us=get_timer()-_pit_start
        var _squid=instance_create(15024,15024,NTTEFullPitSquid)
        _squid.x=15024;_squid.y=15024
        for(var _case=0;_case<3;++_case) for(var _trial=0;_trial<8;++_trial) {
            _squid.ntte_full_intro=_case!=0;_squid.ntte_full_pit_height=_case==1?0.5:1
            var _baseline=scrNTTEFullInstances(all),_trial_seed=702710+_trial
            random_set_seed(_trial_seed)
            with(_squid) scrNTTEFullTrenchBubbleSparksOld()
            var _timer=_squid.ntte_full_timers[3],_rng=random(1),_records=scrNTTEFullTrenchBubbleSparkRecords(_baseline)
            scrNTTEFullMergedRuntimeTestCleanup(_baseline)
            random_set_seed(_trial_seed)
            with(_squid) scrNTTEFullPitSquidSparks()
            assert(_squid.ntte_full_timers[3]==_timer && random(1)==_rng
                && scrNTTEFullTrenchBubbleSparkRecords(_baseline)==_records,
                "PitSquid sparks changed timer/RNG/spawn records, state="+string(_case))
            scrNTTEFullMergedRuntimeTestCleanup(_baseline)
        }
        _squid.ntte_full_intro=false;_squid.ntte_full_pit_height=1
        // random_get_seed reports the selected seed, not a rewindable RNG
        // state. Reset both timed runs explicitly after the spawn trials.
        var _spark_seed=702818
        random_set_seed(_spark_seed)
        var _spark_start=get_timer()
        repeat(128) with(_squid) scrNTTEFullTrenchBubbleSparksOld()
        var _spark_old_us=get_timer()-_spark_start,_spark_final_probe=random(1),_spark_timer=_squid.ntte_full_timers[3]
        random_set_seed(_spark_seed);_spark_start=get_timer()
        repeat(128) with(_squid) scrNTTEFullPitSquidSparks()
        var _spark_new_us=get_timer()-_spark_start
        assert(random(1)==_spark_final_probe && _squid.ntte_full_timers[3]==_spark_timer,
            "Hidden squid optimization changed timer sequence or random stream")
        var _small=instance_create(17000.25,17000.25,NTTEFullBubbleExplosionSmall)
        _small.team=team_player;_small.image_index=1
        var _expected_alive=""
        for(var _pass=0;_pass<2;++_pass) {
            var _shots=[]
            for(var _i=0;_i<128;++_i) {
                var _shot=instance_create(_small.x+(_i<8?(_i-4)*2:128+_i*4),_small.y,NTTEVenomPellet)
                _shot.speed=0;_shot.team=(_i mod 3)==0?team_player:team_enemy;_shot.typ=(_i mod 7)==0?0:1
                array_push(_shots,_shot)
            }
            if(_pass==0) with(_small) scrNTTEFullTrenchBubbleSmallOld()
            else with(_small) scrNTTEFullBubbleExplosionSmallStep()
            var _alive=[]
            for(var _i=0;_i<array_length(_shots);++_i) array_push(_alive,instance_exists(_shots[_i]))
            if(_pass==0) _expected_alive=json_stringify(_alive)
            else assert(json_stringify(_alive)==_expected_alive,
                "Small bubble changed actual projectile faction/type/mask destruction")
            for(var _i=0;_i<array_length(_shots);++_i) if(instance_exists(_shots[_i])) instance_destroy(_shots[_i],false)
        }
        // Friendly overlap keeps the source meeting check active; far hostile
        // projectiles must survive both paths, with unchanged counts.
        var _benchmark=scrNTTEFullInstances(all)
        for(var _i=0;_i<513;++_i) {
            var _shot=instance_create(_small.x+(_i==0?0:256+_i*4),_small.y,NTTEVenomPellet)
            _shot.speed=0;_shot.team=_i==0?team_player:team_enemy;_shot.typ=1
        }
        var _shot_start=get_timer()
        repeat(32) with(_small) scrNTTEFullTrenchBubbleSmallOld()
        var _shot_old_us=get_timer()-_shot_start
        _shot_start=get_timer()
        repeat(32) with(_small) scrNTTEFullBubbleExplosionSmallStep()
        var _shot_new_us=get_timer()-_shot_start
        assert(instance_number(NTTEVenomPellet)==513,"Small bubble culled distant/friendly benchmark shots")
        scrNTTEFullMergedRuntimeTestCleanup(_benchmark)
        scrNTTESmokeLog("TRENCH BUBBLE PERFORMANCE "+json_stringify({rate:game_get_speed(gamespeed_fps),
            pit_old_us:_pit_old_us,pit_new_us:_pit_new_us,hidden_sparks_old_us:_spark_old_us,
            hidden_sparks_new_us:_spark_new_us,small_old_us:_shot_old_us,small_new_us:_shot_new_us,
            source_counts_unchanged:true,source_rng_unchanged:true,mobile_device_tested:false}))
    }
    finally {
        scrNTTEFullMergedRuntimeTestCleanup(_before)
        for(var _i=0;_i<array_length(_hidden);++_i) instance_activate_object(_hidden[_i])
        GameCont.area=_area;GameCont.underwater=_water;GameCont.crown=_crown
        UberCont.opt_prtcls=_particles;lockstep_stop=_stop;global.rng_state=_native;random_set_seed(_seed)
        scrNTTEFullFloorSetStyle(_style[0],_style[1]);scrNTTEFullFloorSetAlign(_style[2],_style[3],_style[4],_style[5])
    }
    scrNTTESmokeLog("FULL TRENCH BUBBLE old/new exact Floor masks/order + hidden/submerged/revealed spark timer/RNG/records + actual projectile destruction parity OK; no particle count/probability cap")
}

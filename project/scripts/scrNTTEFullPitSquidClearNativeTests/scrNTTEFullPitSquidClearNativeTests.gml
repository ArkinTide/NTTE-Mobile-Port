// Parent smoke driver supplies the real 30/60 engine rate; no rate mutation.
function scrNTTEFullPitSquidClearNativeTests() {
    assert(abs(timescale-1)<0.001 || abs(timescale-0.5)<0.001,"PitSquid clear case supports30/60 only")
    assert(!instance_exists(GenCont) && !lockstep_stop,"PitSquid terrain case needs completed unpaused world")
    var _before=scrNTTEFullInstances(all),_game=scrNTTEFullAreaGeneratorSnapshot(GameCont),
        _uber=scrNTTEFullAreaGeneratorSnapshot(UberCont),_music=scrNTTEFullAreaGeneratorSnapshot(MusCont),
        _seed=random_get_seed(),_tick=current_frame,
        _grid=variable_global_exists("ntte_full_trench_pit_grid")?global.ntte_full_trench_pit_grid:-1,
        _dirty=variable_global_exists("ntte_full_trench_pit_dirty")?global.ntte_full_trench_pit_dirty:false,
        _count=variable_global_exists("ntte_full_trench_floor_count")?global.ntte_full_trench_floor_count:-1
    global.ntte_full_trench_pit_grid=ds_grid_create(1250,1250)
    ds_grid_clear(global.ntte_full_trench_pit_grid,false)
    try {
        GameCont.area=scrNTTEFullAreaId("trench")
        for(var _loop=0;_loop<=2;_loop+=2) {
            var _case_before=scrNTTEFullInstances(all)
            GameCont.loops=_loop
            var _boss=instance_create(15024,15040,NTTEFullPitSquid),_clear=noone,
                _scale=1+0.1*_loop
            with(PortalClear) if(x==15024 && y==15024 && array_get_index(_case_before,id)<0) {
                assert(_clear==noone,"Squid constructor created multiple wall clears")
                _clear=id
            }
            assert(instance_exists(_clear),"Actual PitSquid constructor did not create original clear")
            assert(_clear.sprite_index==_boss.ntte_full_mask && _boss.mask_index==mskNone,
                "Constructor wall clear lost source temporary mask or exposed hidden boss collision")
            assert(abs(_clear.image_xscale-_scale*1.6)<0.001
                && abs(_clear.image_yscale-_scale*1.6)<0.001 && _clear.image_angle==_boss.image_angle,
                "Actual constructor clear did not grow independently with loop-scaled boss")
            assert(_clear.pit_clear==0.75 && !variable_instance_exists(_clear,"pit_smash"),
                "Constructor must open pits without source Step-only smash flag")
            var _land=instance_create(15008,15008,Floor),_chunks=instance_number(NTTEFullTrenchFloorChunk)
            _land.sprite_index=scrNTTERefSprite("FloorTrench");_land.styleb=false
            scrNTTEFullTrenchOpenPits()
            var _pit=collision_point(15024,15024,Floor,false,false)
            assert(instance_exists(_pit) && _pit.sprite_index==scrNTTERefSprite("FloorTrenchB")
                && scrNTTEFullTrenchPitGet(15024,15024),"Actual constructor PortalClear did not open real Trench floor")
            assert(instance_number(NTTEFullTrenchFloorChunk)==_chunks,
                "Constructor wrongly launched floor chunks reserved for rising Step")
            instance_destroy(_clear,false)

            // Exercise real registered Step, not a test reimplementation of rise.
            _boss.ntte_full_intro=true;_boss.ntte_full_can_intro=true
            _boss.ntte_full_sink=false;_boss.ntte_full_rise_delay=0;_boss.ntte_full_pit_height=0.99
            _boss.ntte_full_bite=0.05;_boss.ntte_full_timers=[-1,-1,-1,-1]
            _boss.speed=0;_boss.ntte_full_eye_laser=0;_boss.ntte_full_eye_laser_delay=0
            with(_boss) event_perform(ev_step,ev_step_normal)
            _clear=noone
            with(PortalClear) if(x==15024 && y==15024 && array_get_index(_case_before,id)<0) _clear=id
            assert(instance_exists(_clear) && _clear.pit_smash && _clear.pit_clear==0.75,
                "Actual ordinary rise did not create source smash clear")
            assert(abs(_clear.image_xscale-_scale*1.6)<0.001
                && abs(_clear.image_yscale-_scale*1.6)<0.001 && _clear.sprite_index==_boss.ntte_full_mask,
                "Actual ordinary rise clear geometry lost growing source footprint")
            instance_destroy(_clear,false)

            // Loop2 suppresses only source intro animation; the actual first-rise
            // Step still sets intro and applies the original extra1.5 footprint.
            if(_loop==2) {
                _boss.ntte_full_intro=false;_boss.ntte_full_pit_height=0.99
                _boss.ntte_full_bite=0.05;_boss.ntte_full_timers=[-1,-1,-1,-1]
                with(_boss) event_perform(ev_step,ev_step_normal)
                _clear=noone
                with(PortalClear) if(x==15024 && y==15024 && array_get_index(_case_before,id)<0) _clear=id
                assert(instance_exists(_clear) && _boss.ntte_full_intro && _clear.pit_smash,
                    "Actual first rise lost source intro/smash transition")
                assert(abs(_clear.image_xscale-_scale*2.4)<0.001
                    && abs(_clear.image_yscale-_scale*2.4)<0.001,
                    "Actual first rise omitted source extra1.5 clear footprint")
                instance_destroy(_clear,false)
            }

            // Guard generic wall_clear copying: independent signed axes/angle.
            _boss.image_xscale=1.75;_boss.image_yscale=-0.6;_boss.image_angle=27
            with(_boss) _clear=scrNTTEFullPitSquidSmash(false,true)
            assert(abs(_clear.image_xscale-2.8)<0.001 && abs(_clear.image_yscale+0.96)<0.001
                && _clear.image_angle==27 && _clear.sprite_index==_boss.ntte_full_mask,
                "Source wall_clear must copy independent signed axes and angle, not square X into Y")
            scrNTTEFullMergedRuntimeTestCleanup(_case_before)
        }
    }
    finally {
        scrNTTEFullMergedRuntimeTestCleanup(_before)
        scrNTTEFullAreaGeneratorRestore(_game);scrNTTEFullAreaGeneratorRestore(_uber)
        scrNTTEFullAreaGeneratorRestore(_music)
        ds_grid_destroy(global.ntte_full_trench_pit_grid)
        global.ntte_full_trench_pit_grid=_grid;global.ntte_full_trench_pit_dirty=_dirty
        global.ntte_full_trench_floor_count=_count
        random_set_seed(_seed);current_frame=_tick
    }
    scrNTTESmokeLog("FULL PIT SQUID SOURCE WALL_CLEAR loop0/2 constructor mask/scale/angle+real quiet terrain / actual ordinary+first-rise Step / signed independent axes OK @"+string(30/timescale))
}

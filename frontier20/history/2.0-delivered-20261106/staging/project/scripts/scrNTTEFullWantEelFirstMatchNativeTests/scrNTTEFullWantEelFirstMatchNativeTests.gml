// Controlled real Floor + WantEel constructors and registered Step clock.
// First run before production integration: land fallback must expose >1 clear.
function scrNTTEFullWantEelFirstMatchNativeTests() {
    assert(os_type==os_windows && scrNTTEFullSmokeEnabled() && !instance_exists(GenCont)
        && !instance_exists(Menu) && instance_exists(GameCont) && instance_number(Player)==1
        && instance_number(NTTEFullEel)==0 && instance_number(NTTEFullWantEel)==0,
        "WantEel first-match fixture needs a settled explicit desktop room and one real target")
    var _snapshot=scrNTTEFullInstances(all),_game=scrNTTEFullAreaGeneratorSnapshot(GameCont),
        _players=scrNTTEFullAreaGeneratorSnapshot(Player),_back=scrNTTEFullAreaGeneratorSnapshot(BackCont),
        _pit_actors=scrNTTEFullAreaGeneratorSnapshot([Corpse,ChestOpen,Debris,Shell,Feather]),
        _seed=random_get_seed(),_stop=lockstep_stop,_frame=current_frame,_rng_states=scrNTTEFullArrayCopy(global.rng_state),
        _p=instance_find(Player,0),_old_grid=variable_global_exists("ntte_full_trench_pit_grid")?global.ntte_full_trench_pit_grid:-1,
        _old_dirty=variable_global_exists("ntte_full_trench_pit_dirty")?global.ntte_full_trench_pit_dirty:false,
        _old_count=variable_global_exists("ntte_full_trench_floor_count")?global.ntte_full_trench_floor_count:-1,_grid=-1
    try {
        lockstep_stop=false;current_frame=floor(current_frame)
        assert(current_frame_active,"WantEel actual30/60 fixture needs active native frame")
        GameCont.area=scrNTTEFullAreaId("trench");GameCont.loops=0
        // A private real grid is rebuilt from the actual native floor masks;
        // the old settled room's grid handle is retained and restored intact.
        _grid=ds_grid_create(1250,1250);global.ntte_full_trench_pit_grid=_grid
        _p.x=16000;_p.y=16000;_p.xprevious=_p.x;_p.yprevious=_p.y
        var _modes=["land first match","pit first match","no legal floor","source population cap"]
        for(var _mode=0;_mode<array_length(_modes);++_mode) {
            var _before=scrNTTEFullInstances(all),_candidates=[]
            // Three genuine native floors all meet source distance<160. Other
            // settled-room floors remain far outside the source target radius.
            if(_mode!=2) for(var _i=0;_i<3;++_i) {
                var _floor=instance_create(15936+64*_i,16000,Floor)
                assert(instance_exists(_floor),"Controlled real Floor constructor was blocked")
                _floor.styleb=(_mode==1)
                _floor.sprite_index=scrNTTERefSprite(_mode==1?"FloorTrenchB":"FloorTrench")
                array_push(_candidates,_floor)
            }
            scrNTTEFullTrenchPitRebuild()
            if(_mode==1) for(var _i=0;_i<array_length(_candidates);++_i) {
                var _valid=false
                with(_candidates[_i]) _valid=!scrNTTEFullTrenchPitlessMeeting(x,y)
                assert(_valid,"Actual pit floor mask/grid did not meet original WantEel pit condition")
            }
            if(_mode==3) repeat(7) {
                var _active=instance_create(16600,16000,NTTEFullWantEel)
                _active.visible=true
            }
            var _want=instance_create(16512,16000,NTTEFullWantEel),_originx=_want.x,_originy=_want.y,
                _clears=instance_number(PortalClear),_initial_seed=48117+_mode,
                _expected=noone,_expected_clear_count=(_mode==0?1:0),_expectedx=0,_expectedy=0
            // Port alarms are source timers serviced by the registered native
            // Step, not an Alarm event. Only schedule the original slot1 due.
            _want.ntte_full_timers=[-1,timescale,-1,-1]
            if(_mode<2) {
                // Replay only the unchanged preselection RNG prefix and both
                // original shuffles, then read the first actual legal floor.
                // Reset this initial seed before executing the actual Step.
                random_set_seed(_initial_seed)
                var _burn=30+random(60);_burn=random(3)
                var _floors=[],_land=[],_pits=scrNTTERefSprite("FloorTrenchB"),_tx=_p.x,_ty=_p.y
                with(Floor) {
                    if(sprite_index==_pits) array_push(_floors,id)
                    else array_push(_land,id)
                }
                _floors=array_shuffle(_floors);_land=array_shuffle(_land)
                var _ordered=(_mode==1?_floors:_land),_legal_count=0
                for(var _i=0;_i<array_length(_ordered);++_i) {
                    var _f=_ordered[_i],_legal=false
                    with(_f) _legal=(_mode!=1 || !scrNTTEFullTrenchPitlessMeeting(x,y))
                        && point_distance((bbox_left+(bbox_right-1)+1)/2,(bbox_top+(bbox_bottom-1)+1)/2,_tx,_ty)<160
                    if(_legal) {
                        _legal_count+=1
                        if(!instance_exists(_expected)) _expected=_f
                    }
                }
                assert(instance_exists(_expected) && _legal_count==3,
                    "Controlled source selection must contain three distinct eligible native floors")
                _expectedx=(_expected.bbox_left+_expected.bbox_right)/2
                _expectedy=(_expected.bbox_top+_expected.bbox_bottom)/2
            }
            random_set_seed(_initial_seed)
            scrNTTESmokeLog("WANT EEL BEFORE REGISTERED TIMER STEP "+_modes[_mode]+" @"+string(30/timescale))
            with(_want) event_perform(ev_step,ev_step_normal)
            var _actual_clears=instance_number(PortalClear)-_clears
            scrNTTESmokeLog("WANT EEL FIRST MATCH observed PortalClear="+string(_actual_clears)
                +" expected="+string(_expected_clear_count)+" mode="+_modes[_mode]+" @"+string(30/timescale))
            assert(_actual_clears==_expected_clear_count,
                "Source WantEel land fallback must create one PortalClear only; actual="+string(_actual_clears)+" mode="+_modes[_mode])
            assert(instance_exists(_want) && _want.target==_p,"Registered WantEel Step failed real native player targeting")
            if(_mode<2) {
                assert(_want.visible && _want.x==_expectedx && _want.y==_expectedy
                    && _want.xprevious==_want.x && _want.yprevious==_want.y
                    && _want.ntte_full_timers[2]==30 && _want.ntte_full_timers[1]>=20 && _want.ntte_full_timers[1]<40
                    && _want.walk>=20 && _want.walk<=60,
                    "WantEel did not activate at the FIRST legal shuffled source floor with original timers/motion")
                if(_mode==0) with(PortalClear) if(array_get_index(_before,id)<0) {
                    assert(pit_clear==0.75 && pit_smash
                        && (x==_expected.bbox_left || x==_expected.bbox_right)
                        && (y==_expected.bbox_top || y==_expected.bbox_bottom),
                        "Single native PortalClear lost original corner/pit_clear/pit_smash settings")
                }
            }
            else assert(!_want.visible && _want.x==_originx && _want.y==_originy
                && _want.ntte_full_timers[2]==-1 && _want.ntte_full_timers[1]>=30 && _want.ntte_full_timers[1]<90,
                "WantEel ignored original absent-floor/population cap or changed failed activation timer")
            scrNTTESmokeLog("WANT EEL REGISTERED STEP "+_modes[_mode]+" actual floor/first candidate/PortalClear count and native continuation OK")
            scrNTTEFullMergedRuntimeTestCleanup(_before)
        }
    }
    finally {
        scrNTTEFullMergedRuntimeTestCleanup(_snapshot)
        if(ds_exists(_grid,ds_type_grid)) ds_grid_destroy(_grid)
        global.ntte_full_trench_pit_grid=_old_grid;global.ntte_full_trench_pit_dirty=_old_dirty
        global.ntte_full_trench_floor_count=_old_count
        scrNTTEFullAreaGeneratorRestore(_game);scrNTTEFullAreaGeneratorRestore(_players)
        scrNTTEFullAreaGeneratorRestore(_back)
        scrNTTEFullAreaGeneratorRestore(_pit_actors)
        global.rng_state=_rng_states;lockstep_stop=_stop;current_frame=_frame;random_set_seed(_seed)
    }
    scrNTTESmokeLog("WANT EEL FIRST MATCH native registered timer Step: one land clear, first legal shuffled pit/land, no eligible floor and source cap7>6 negatives OK @"+string(30/timescale)+"; controlled native callback fixture, natural campaign/iPhone untested")
}

// Controlled real native constructors and registered Steps; not a natural route.
// Run this exact fixture against unguarded production before applying the guard.
function scrNTTEFullLairEffectLifetimeTests() {
    assert(os_type==os_windows && scrNTTEFullSmokeEnabled() && !instance_exists(GenCont)
        && !instance_exists(Menu) && instance_exists(GameCont) && instance_exists(Player),
        "Lair effect lifetime requires a settled explicit desktop room")
    var _snapshot=scrNTTEFullInstances(all),_game=scrNTTEFullAreaGeneratorSnapshot(GameCont),
        _players=scrNTTEFullAreaGeneratorSnapshot(Player),_back=scrNTTEFullAreaGeneratorSnapshot(BackCont),
        _particles=UberCont.opt_prtcls,_seed=random_get_seed(),_stop=lockstep_stop,_frame=current_frame,
        _rng_states=scrNTTEFullArrayCopy(global.rng_state)
    try {
        lockstep_stop=false;current_frame=floor(current_frame)
        assert(current_frame_active,"Actual30/60 fixture clock must select native active frame")
        GameCont.area=scrNTTEFullAreaId("lair");GameCont.lastarea=GameCont.area
        GameCont.ntte_full_active_coast=false;GameCont.underwater=false
        // Disabled is deliberately first: the unpatched native Step must fail
        // here with the user's missing-instance access, before any later test.
        var _modes=["particles disabled","ground alive","underwater replacement","GenCont ancestry gate"]
        for(var _mode=0;_mode<array_length(_modes);++_mode) {
            var _before=scrNTTEFullInstances(all),_x=60000+_mode*256,_y=60000,_sentinel=noone
            UberCont.opt_prtcls=(_mode!=0);GameCont.underwater=(_mode==2)
            // The source deletes by the Floor anchor, not its bottom edge.
            // Keep it beyond every possible4..18 first-step front at80.
            var _floor=instance_create(_x,_y+128,Floor)
            assert(instance_exists(_floor),"Controlled native cave-in floor creation failed")
            if(_mode==3) {
                _sentinel=instance_create(_x,_y,NTTEFullDustLifetimeGenSentinel)
                assert(instance_exists(GenCont),"Actual Dust ancestry gate lacks real GenCont descendant")
            }
            var _probe_before=scrNTTEFullInstances(all),_bubbles=instance_number(Bubble),
                _probe=instance_create(_x,_y,Dust)
            assert(instance_exists(_probe)==(_mode==1) && instance_number(Bubble)==_bubbles+(_mode==2?1:0),
                "Actual native Dust constructor lifetime/replacement differs: "+_modes[_mode])
            scrNTTEFullMergedRuntimeTestCleanup(_probe_before)
            var _border=instance_create(_x,_y,NTTEFullLairBorder)
            _border.ntte_full_cavein=1;_border.ntte_full_cavein_distance=80
            var _effects=scrNTTEFullInstances(all),_dust=instance_number(Dust),_bubbles=instance_number(Bubble)
            assert(_floor.bbox_bottom-1>_border.y+_border.ntte_full_cavein_distance,
                "Controlled actual Floor did not reach native cave-in Dust branch")
            scrNTTESmokeLog("LAIR EFFECT BEFORE REAL BORDER STEP "+_modes[_mode]+" @"+string(30/timescale))
            with(_border) event_perform(ev_step,ev_step_normal)
            assert(instance_exists(_border) && _border.ntte_full_cavein==1
                && _border.ntte_full_cavein_distance<80 && _border.ntte_full_cavein_distance>0
                && !instance_exists(_floor),"Real cave-in Step failed source distance reduction/terrain disposal after optional Dust")
            var _added_dust=instance_number(Dust)-_dust,_added_bubbles=instance_number(Bubble)-_bubbles
            if(_mode==1) {
                assert(_added_dust>=1 && _added_dust<=2,"Native cave-in repeat lost authored1..2Dust")
                with(Dust) if(array_get_index(_effects,id)<0) {
                    assert(abs(image_xscale-1.4)<0.0001 && abs(image_yscale-1.4)<0.0001
                        && depth==-8 && vspeed<=-3*timescale && vspeed>=-7*timescale,
                        "Live cave-in Dust lost source doubled scale/depth/upward motion")
                }
            }
            else assert(_added_dust==0,"Dead native cave-in Dust remained alive")
            // Dust.Create's genuine water replacement was proved above. The
            // same native Border.Step then sweeps Bubble in GameObjects;
            // only Dust is exempt from the source cave-in disposal loop.
            if(_mode==2) assert(_added_bubbles==0,"Native cave-in did not clear underwater Bubble replacements beyond its front")
            else assert(_added_bubbles==0,"Native cave-in unexpectedly replaced Dust by Bubble")
            scrNTTESmokeLog("LAIR EFFECT AFTER REAL BORDER STEP source distance/terrain continuation "+_modes[_mode])
            scrNTTEFullMergedRuntimeTestCleanup(_before)

            // The second site is the real Rubble Create, including its original
            // four walls/forty HP and twelve native Dust constructor attempts.
            if(_mode==3) _sentinel=instance_create(_x,_y,NTTEFullDustLifetimeGenSentinel)
            var _dust=instance_number(Dust),_bubbles=instance_number(Bubble)
            scrNTTESmokeLog("LAIR EFFECT BEFORE REAL RUBBLE CREATE "+_modes[_mode])
            var _rubble=instance_create(_x,_y,NTTEFullPizzaRubble)
            assert(instance_exists(_rubble) && _rubble.hp==40 && _rubble.max_hp==40
                && !_rubble.ntte_full_peas && array_length(_rubble.ntte_full_saved)==0,
                "Real Rubble Create lost source40HP/state after optional Dust")
            assert(instance_number(Dust)==_dust+(_mode==1?12:0)
                && instance_number(Bubble)==_bubbles+(_mode==2?12:0),
                "Real Rubble Create changed twelve actual Dust/Bubble constructor outcomes")
            if(_mode==1) with(Dust) if(array_get_index(_before,id)<0) {
                assert(abs(image_xscale-1.4)<0.0001 && abs(image_yscale-1.4)<0.0001 && depth==-8,
                    "Live Rubble Create Dust lost authored scales/depth")
            }
            // Give the actual source hold callback one controlled native hitme.
            // Choose an initial RNG seed whose two original branch conditions
            // are true, then reset to it before the real Step. This preserves
            // the production probabilities and executes the real branch once.
            var _actor=instance_create(_x+64,_y+64,Bandit),_trigger_seed=-1
            _actor.speed=4*timescale;_actor.depth=-17
            _rubble.ntte_full_saved=[_actor]
            for(var _candidate=1;_candidate<=128;++_candidate) {
                random_set_seed(_candidate)
                if(!(random(4)<timescale) && random(2)<1) {_trigger_seed=_candidate;break}
            }
            assert(_trigger_seed>0,"No controlled initial seed reached the original saved-hitme Dust branch")
            random_set_seed(_trigger_seed)
            var _effects=scrNTTEFullInstances(all),_dust=instance_number(Dust),_bubbles=instance_number(Bubble)
            scrNTTESmokeLog("LAIR EFFECT BEFORE REAL RUBBLE STEP "+_modes[_mode]+" seed="+string(_trigger_seed))
            with(_rubble) event_perform(ev_step,ev_step_normal)
            assert(instance_exists(_rubble) && instance_exists(_actor)
                && _actor.x==_rubble.x && _actor.y==_rubble.y+16 && _actor.xprevious==_actor.x
                && _actor.yprevious==_actor.y && _actor.speed==0 && _actor.depth==-17,
                "Real Rubble Step optional Dust interrupted source saved-hitme hold/position/motion continuation")
            assert(instance_number(Dust)==_dust+(_mode==1?1:0)
                && instance_number(Bubble)==_bubbles+(_mode==2?1:0),
                "Real saved-hitme Step omitted one actual Dust/Bubble constructor attempt")
            if(_mode==1) with(Dust) if(array_get_index(_effects,id)<0) {
                assert(direction>=60 && direction<=120 && (depth==-17 || depth==-18),
                    "Live saved-hitme Dust changed source direction/depth range")
            }
            scrNTTESmokeLog("LAIR EFFECT REAL CALLERS native LairBorder.Step cave-in continuation + PizzaRubble.Create12 + PizzaRubble.Step saved-hitme hold "+_modes[_mode]+" OK")
            scrNTTEFullMergedRuntimeTestCleanup(_before)
        }
    }
    finally {
        scrNTTEFullMergedRuntimeTestCleanup(_snapshot)
        scrNTTEFullAreaGeneratorRestore(_game);scrNTTEFullAreaGeneratorRestore(_players)
        scrNTTEFullAreaGeneratorRestore(_back)
        global.rng_state=_rng_states;UberCont.opt_prtcls=_particles
        lockstep_stop=_stop;current_frame=_frame;random_set_seed(_seed)
    }
    scrNTTESmokeLog("LAIR EFFECT LIFETIME actual Dust off/alive/underwater/GenCont constructors and native Border.Step/Rubble.Create/Rubble.Step continuation OK @"+string(30/timescale)+"; controlled callback fixture, natural crossing/full Lair/iPhone untested")
}

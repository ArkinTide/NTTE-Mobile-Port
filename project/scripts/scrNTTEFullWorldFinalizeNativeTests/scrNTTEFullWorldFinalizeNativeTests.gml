function scrNTTEFullWorldFinalizeNativeTests() {
    var _state=scrNTTEFullVanillaFixtureBegin(),_extra=scrNTTEFullInstances([TopPot,Trap,NTTEFullWorldFinalize])
    for(var _i=0;_i<array_length(_extra);++_i) instance_deactivate_object(_extra[_i])
    try {
        var _trap=instance_create(98000,98000,Trap),_wall=instance_create(98000,98000,Wall),
            _unaffected=instance_create(98128,98000,Wall),_externally=instance_create(98256,98000,Wall),_removed=instance_create(98384,98000,Wall)
        _trap.solid=true;_wall.depth=0;_unaffected.depth=-5;_externally.depth=0;_removed.depth=0
        var _clear=instance_create(98000,98000,PortalClear);_clear.mask_index=mskFloor
        var _floor=instance_create(98000,98000,Floor),_pot=instance_create(98000,98000,TopPot)
        _pot.mask_index=mskFloor;_pot.x=98000;_pot.y=98000;_pot.dir=0
        random_set_seed(111);var _expected=random(100000);random_set_seed(111)
        var _result=scrNTTEFullWorldFinalizeLevelStart()
        assert(!_trap.solid && random(100000)==_expected,"Final native Trap collision repair failed or consumed source-free RNG")
        assert(array_length(_result.moved)==1 && _result.moved[0]==_pot && _pot.x==98032 && _pot.y==98000,
            "Final native TopPot did not move exactly two16px steps along dir out of cleared Wall and existing Floor")
        assert(_wall.depth==1 && _externally.depth==1 && _removed.depth==1 && _unaffected.depth==-5
            && array_length(_result.changed)==3 && instance_exists(_result.restore),
            "Final native Wall order repair changed nonzero depth or omitted source0->1transient")
        _externally.depth=-7;instance_destroy(_removed,false)
        var _restore=_result.restore
        with(_restore) event_perform(ev_step,ev_step_begin)
        assert(_wall.depth==0 && _externally.depth==-7 && _unaffected.depth==-5 && !instance_exists(_restore),
            "Actual next BeginStep order restore ignored original live-wall/depth-unchanged guard or leaked controller")
        scrNTTEFullCavesFixtureCleanup(_state.baseline)

        // No PortalClear at the Wall: source deliberately leaves residence
        // alone, even when it overlaps Floor. Test all cardinal exit dirs.
        for(var _dir=0;_dir<360;_dir+=90) {
            var _wall=instance_create(98000,98000,Wall),_pot=instance_create(98000,98000,TopPot)
            _wall.depth=4;_pot.mask_index=mskFloor;_pot.x=98000;_pot.y=98000;_pot.dir=_dir
            var _result=scrNTTEFullWorldFinalizeLevelStart()
            assert(array_length(_result.moved)==0 && _pot.x==98000 && _pot.y==98000 && !instance_exists(_result.restore),
                "Final native TopPot moved away from uncleared residence or created unnecessary depth restore")
            var _clear=instance_create(98000,98000,PortalClear);_clear.mask_index=mskFloor
            _result=scrNTTEFullWorldFinalizeLevelStart()
            var _expectedX=98000+round(lengthdir_x(_dir==0 || _dir==270?16:32,_dir)),
                _expectedY=98000+round(lengthdir_y(_dir==0 || _dir==270?16:32,_dir))
            // Native mask covers[0,32),Wall[0,16): right/down exit in16;
            // left/up need32 to clear the same wall from the other side.
            assert(array_length(_result.moved)==1 && abs(_pot.x-_expectedX)<=0.00001 && abs(_pot.y-_expectedY)<=0.00001,
                "Final native TopPot source cardinal16px displacement or collision exit changed")
            scrNTTEFullCavesFixtureCleanup(_state.baseline)
        }

        // Our optional grounded-enemy rescue is removed, including ordinary
        // actors which have an open exit. Original MOD TopPot handling above
        // remains independent. Exercise the production generation tail and
        // actual controller EndStep repeatedly, beyond the old retry window.
        GameCont.area=area_desert;
        var _wall=instance_create(239000,239000,Wall),
            _floor=instance_create(239016,239000,Floor),
            _enemy=instance_create(239008,239008,Bandit),
            _saved=[_enemy.x,_enemy.y,_enemy.hp,_enemy.team];
        scrNTTEFullWorldFinalizeLevelStart();
        repeat(ceil(180/timescale)) with(GameCont) event_perform(ev_step,ev_step_end);
        assert(instance_exists(_enemy) && _enemy.x==_saved[0] && _enemy.y==_saved[1]
            && _enemy.hp==_saved[2] && _enemy.team==_saved[3],
            "Removed agent recovery still relocates or kills a wall-overlapping actor");
        assert(!variable_instance_exists(_enemy,"ntte_wall_stable")
            && !variable_instance_exists(GameCont,"ntte_wall_recovery"),
            "Removed agent recovery still installs per-frame tracking state");
        scrNTTEFullCavesFixtureCleanup(_state.baseline);
    }
    finally {
        scrNTTEFullVanillaFixtureEnd(_state)
        for(var _i=0;_i<array_length(_extra);++_i) instance_activate_object(_extra[_i])
    }
    scrNTTESmokeLog("FINAL NATIVE WORLD: source RNG-free non-solid Trap, PortalClear-specific TopPot relocation across original wall/floor/cardinal16px steps and uncleared residence retention;actual temporary0->1Wall depth/next BeginStep guarded restore/deleted walls/controller cleanup OK")
}

// Exercises the actual native generation Destroy boundary, including the old
// blanket's two distinct branches: no Floor destroys, distant Floor teleports.
function scrNTTEFullGroundEnemyNoKillNativeTests() {
    assert(os_type==os_windows && scrNTTEFullSmokeEnabled(),"Wall-born preservation regression requires explicit Windows full smoke")
    var _old_map=UberCont.saveData,_old_bytes=ds_map_write(_old_map),_map=ds_map_create(),_state=undefined,
        _directory=game_directory,_scratch=working_directory+"wall-born-native-"+string(get_timer())+"/"
    ds_map_copy(_map,_old_map);UberCont.saveData=_map
    _state=scrNTTEFullWorldEventsNaturalWorldCapture()
    directory_create(_scratch);game_directory=_scratch
    try {
        for(var _case=0;_case<2;++_case) {
            scrNTTEFullAreaSetContextConfigure(_state,area_desert,1,785321+_case)
            var _gen=instance_create(0,0,GenCont)
            assert(instance_exists(_gen),"Wall-born fixture lost real native GenCont")
            _gen.ntte_full_set_area=false
            scrNTTEFullWorldEventsCleanup()
            instance_destroy(FloorMaker,false);instance_destroy(Floor,false)
            instance_destroy(Wall,false);instance_destroy(TopSmall,false)
            instance_destroy(enemy,false)
            if(_case==1) instance_create(10000,10000,Floor)
            assert(instance_number(Floor)==_case,"Wall-born fixture did not select exact no-Floor/distant-Floor branch")

            var _ground=instance_create(245008,245008,Bandit),
                _wall=instance_create(245512,245000,Wall),
                _fixed=instance_create(245520,245008,Bandit),
                _top_wall=instance_create(246024,245000,Wall),
                _actor=instance_create(246032,245008,Bandit)
            _fixed.ntte_full_intended_wall=true
            _actor.alarm[1]=17
            var _saved_mask=_actor.mask_index,_top=scrNTTEFullTopCreate(_actor.x,_actor.y,_actor,0,0),
                _resident_wall=instance_create(246536,245000,Wall),
                _resident=scrNTTEFullWallEnemyCreateAt(246544,245008)
            _wall.depth=4;_top_wall.depth=4;_resident_wall.depth=4
            assert(instance_exists(_resident) && instance_exists(_resident.target),"Wall-born fixture lacks genuine WallEnemy/TopPot")
            var _pot=_resident.target,_rows=[],_subjects=[_ground,_fixed,_actor]
            var _raven_top=scrNTTEFullTopCreate(247032,245008,NTTEFullTopRaven,0,0),
                _raven=_raven_top.target
            array_push(_subjects,_raven)
            for(var _i=0;_i<array_length(_subjects);++_i) {
                var _who=_subjects[_i]
                assert(!position_meeting(_who.x,_who.y,Floor),"Wall-born fixture enemy already has supporting Floor")
                array_push(_rows,[_who,_who.x,_who.y,_who.hp,_who.team])
            }
            var _resident_xy=[_resident.x,_resident.y],_pot_xy=[_pot.x,_pot.y],_top_xy=[_top.x,_top.y]
            with(_gen) event_perform(ev_destroy,0)
            instance_destroy(_gen,false)
            for(var _i=0;_i<array_length(_rows);++_i) {
                var _row=_rows[_i],_who=_row[0]
                assert(instance_exists(_who) && _who.x==_row[1] && _who.y==_row[2]
                    && _who.hp==_row[3] && _who.team==_row[4],
                    "Actual GenCont.Destroy killed/teleported unsupported enemy case="+string(_case)+" actor="+string(_i))
            }
            assert(GameCont.enemies==4 && scr_check_enemies(),"Generation count/portal gate discarded live wall-born enemies")
            var _seed=random_get_seed(),_native=json_stringify(global.rng_state)
            scrNTTEFullWorldFinalizeLevelStart()
            for(var _i=0;_i<array_length(_rows);++_i) {
                var _row=_rows[_i],_who=_row[0]
                assert(instance_exists(_who) && _who.x==_row[1] && _who.y==_row[2] && _who.hp==_row[3],
                    "Nonlethal finalizer changed unsupported/intended-wall/suspended target")
            }
            assert(instance_exists(_resident) && instance_exists(_pot) && _resident.target==_pot
                && _resident.x==_resident_xy[0] && _resident.y==_resident_xy[1]
                && _pot.x==_pot_xy[0] && _pot.y==_pot_xy[1]
                && instance_exists(_top) && _top.target==_actor && _actor.ntte_full_top_object==_top
                && _top.x==_top_xy[0] && _top.y==_top_xy[1]
                && _actor.mask_index==mskNone && _top.target_save.mask_index==_saved_mask
                && _actor.alarm[1]==-1 && _top.target_save.ntte_full_saved_alarms[1]==17
                && random_get_seed()==_seed && json_stringify(global.rng_state)==_native,
                "Generation/finalization altered original wall resident, top target suspension, or source-free RNG")

            // The remaining mobile death was Player.Alarm10, independently
            // of generation/controller recovery. Exercise that actual event
            // repeatedly while a genuine perched Raven has no Floor below.
            if(!instance_exists(Floor)) instance_create(10000,10000,Floor)
            var _player=instance_find(Player,0),_corpses=instance_number(CorpseActive)
            _player.race=Race.Fish
            repeat(8) {
                with(_player) event_perform(ev_alarm,10)
                with(_raven) event_perform(ev_step,ev_step_normal)
                for(var _i=0;_i<array_length(_rows);++_i) {
                    var _row=_rows[_i]
                    assert(instance_exists(_row[0]) && _row[0].hp==_row[3],
                        "Actual Player.Alarm10 killed a living off-floor/wall/perched actor")
                }
                assert(instance_exists(_raven_top) && _raven.top_object==_raven_top
                    && _raven.mask_index==mskNone && instance_number(CorpseActive)==_corpses,
                    "Perched Raven lost its wrapper or created a death corpse during periodic player alarm")
            }

            // Genuine hostile life still blocks the native portal alarm. Its
            // real HP death remains enabled; friendly survivors then use the
            // existing team-aware gate rather than any artificial wall kill.
            var _corpse=instance_create(10016,10016,Corpse)
            with(_corpse) event_perform(ev_alarm,0)
            assert(!instance_exists(Portal),"Native portal opened while preserved hostiles were alive")
            with(_ground) {hp=0;event_perform(ev_step,ev_step_normal)}
            assert(!instance_exists(_ground),"Normal zero-HP enemy death was disabled by wall preservation")
            _fixed.team=team_player;_actor.team=team_player;_raven.team=team_player
            assert(!scr_check_enemies(),"Friendly wall/top survivors incorrectly block portal gate")
            with(_corpse) event_perform(ev_alarm,0)
            assert(instance_exists(Portal) && instance_exists(_fixed) && instance_exists(_actor)
                && instance_exists(_resident) && instance_exists(_pot) && instance_exists(_raven),
                "Native portal failed after legitimate hostile death or deleted surviving wall/friendly actors")
            scrNTTESmokeLog("WALL BORN actual GenCont.Destroy branch="+string(_case)
                +" no blanket kill/teleport; actual Player.Alarm10 x8 and TopRaven.Step retain unsupported ground+wall+TopCreate+WallEnemy/TopPot+perched Raven; HP death and portal gates retained @"+string(30/timescale))
            scrNTTEFullMergedRuntimeTestCleanup(_state.before)
        }
    } finally {
        scrNTTEFullWorldEventsNaturalWorldRestore(_state)
        game_directory=_directory;UberCont.saveData=_old_map;ds_map_destroy(_map)
        assert(ds_map_write(_old_map)==_old_bytes,"Wall-born fixture mutated original permanent save")
    }
}

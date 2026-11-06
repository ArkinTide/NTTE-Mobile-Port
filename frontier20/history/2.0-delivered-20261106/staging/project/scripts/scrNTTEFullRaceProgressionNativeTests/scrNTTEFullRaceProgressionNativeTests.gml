function scrNTTEFullRaceProgressionNativeTests() {
    assert(scrNTTESmokeEnabled(),"Race progression fixture requires explicit desktop smoke harness")
    var _before=scrNTTEFullInstances(all),_game=scrNTTEFullAreaGeneratorSnapshot(GameCont),
        _players=scrNTTEFullAreaGeneratorSnapshot(Player),_seed=random_get_seed(),
        _progress=global.ntte_full_progress,_gameDirectory=game_directory,
        _scratch=working_directory+"race-progression-native-fixture/",
        _slots=global.playerinstance_list,_count=player_count,
        _hidden=scrNTTEFullInstances([GenCont,LevCont,SitDown])
    directory_create(_scratch);game_directory=_scratch
    global.ntte_full_progress={schema:1,unlocks:{},loadouts:{},stats:{}}
    global.playerinstance_list=[{race:NTTEFullRace.Beetle},{race:NTTEFullRace.Beetle},{race:NTTEFullRace.Parrot},{race:Race.Fish}]
    player_count=4
    for(var _i=0;_i<array_length(_hidden);++_i) instance_deactivate_object(_hidden[_i])
    with(Player) { race=NTTEFullRace.Beetle;visible=true }
    GameCont.ntte_race_stats_started=false;GameCont.kills=10;GameCont.area=area_desert;GameCont.subarea=2;GameCont.loops=3
    GameCont.ntte_kills_last=undefined
    try {
        assert(array_length(scrNTTEFullRaceProgressSelected(false))==3
            && array_length(scrNTTEFullRaceProgressSelected())==2,
            "Source progression lost per-slot runs versus distinct-race stats semantics")
        assert(scrNTTEFullRaceProgressRunStart() && !scrNTTEFullRaceProgressRunStart()
            && global.ntte_full_progress.stats[$ "race:beetle:runs"]==2
            && global.ntte_full_progress.stats[$ "race:parrot:runs"]==1,
            "Source run counts lost same-race co-op slots or replayed already-started run")
        // A real native seat object without its unrelated UI/audio Create side
        // effects is enough to exercise the source wins/sitting state chain.
        var _seat=instance_create(91000,91000,Floor)
        with(_seat) instance_change(SitDown,false)
        _seat.sit=false
        assert(scrNTTEFullRaceProgressWin(_seat) && !scrNTTEFullRaceProgressWin(_seat)
            && global.ntte_full_progress.stats[$ "race:beetle:wins"]==1
            && global.ntte_full_progress.stats[$ "race:parrot:wins"]==1,
            "Native win transition must count represented custom races once, including same-race co-op")
        var _p=instance_find(Player,0)
        assert(scrNTTEFullRaceProgressDeath(_p) && scrNTTEFullRaceProgressDeath(_p)
            && global.ntte_full_progress.stats[$ "race:beetle:lost"]==2,
            "Repeated real death/revive cycles on same native body ID lost source lost stat")
        GameCont.crown=NTTEFullCrown.Red;GameCont.area=area_campfire
        assert(scrNTTEFullRaceProgressCampfire() && scrNTTEFullUnlockGet("loadout:crown:red")
            && scrNTTEFullLoadoutGet("heart:spawn",0)==1
            && global.ntte_full_progress.stats[$ "race:beetle:loop"]==1
            && global.ntte_full_progress.stats[$ "race:parrot:loop"]==1,
            "Source campfire crown unlock/next-run CrystalHeart guarantee/per-race loop stats diverged")
        scrNTTEFullLoadoutSet("heart:spawn",4)
        GameCont.loops=0;scrNTTEFullRaceProgressCampfire()
        assert(scrNTTEFullLoadoutGet("heart:spawn",0)==4
            && global.ntte_full_progress.stats[$ "race:beetle:loop"]==1,
            "Unlooped campfire modified source loop stats or existing CrystalHeart guarantee")
        random_set_seed(28759)
        var _area=irandom_range(2,7),_sub=irandom_range(1,max(1,scrAreaGetMaxSubarea(_area)-1)),_heartState={}
        random_set_seed(28759)
        assert(scrNTTEFullCrystalHeartRunStart(_heartState) && scrNTTEFullLoadoutGet("heart:spawn",0)==3
            && _heartState.ntte_heart_spawn.area==_area && _heartState.ntte_heart_spawn.subarea==_sub
            && _heartState.ntte_heart_spawn.loops==0,
            "Source next-run CrystalHeart selection lost native RNG stream/exact2..7nonboss range/one charge")
        assert(!scrNTTEFullCrystalHeartRunStart(_heartState) && scrNTTEFullLoadoutGet("heart:spawn",0)==3,
            "Existing source guarantee was rerolled or consumed twice on run continuation")
        _heartState.ntte_heart_spawn=undefined
        assert(!scrNTTEFullCrystalHeartRunStart(_heartState) && scrNTTEFullLoadoutGet("heart:spawn",0)==3,
            "Consumed source heart field must prevent reselection even when explicitly undefined")
        GameCont.area=area_desert;GameCont.subarea=2;GameCont.loops=3
        scrNTTEFullRaceProgressEndStep()
        assert(GameCont.ntte_kills_last==10
            && !variable_struct_exists(global.ntte_full_progress.stats,"race:beetle:kill"),
            "Source first stat tick incorrectly counted pre-baseline run kills")
        GameCont.kills=15;scrNTTEFullRaceProgressEndStep()
        assert(global.ntte_full_progress.stats[$ "race:beetle:kill"]==5
            && global.ntte_full_progress.stats[$ "race:parrot:kill"]==5
            && global.ntte_full_progress.stats[$ "race:beetle:best:kill"]==15,
            "Source kills delta/best-run stats lost full team totals or duplicated same-race co-op")
        var _best=global.ntte_full_progress.stats[$ "race:beetle:best:area"]
        assert(_best[0]==area_desert && _best[1]==2 && _best[2]==3,
            "Source best run lost actual area/subarea/loop tuple")
        var _time=global.ntte_full_progress.stats[$ "race:beetle:time"]
        var _timePlayers=[]
        with(Player) array_push(_timePlayers,[id,race,visible])
        scrNTTESmokeLog("RACE PROGRESSION TIME DIAG "+json_stringify({time:_time,expected:2*timescale/30,
            ts:timescale,players:_timePlayers,gen:instance_number(GenCont),lev:instance_number(LevCont),
            seats:instance_number(SitDown),seatSit:_seat.sit,selected:scrNTTEFullRaceProgressSelected(),stats:global.ntte_full_progress.stats}))
        assert(abs(_time-2*timescale/30)<=0.001,
            "Source race elapsed time diverged from logical-frame seconds")
        with(GameCont) event_perform(ev_step,ev_step_end)
        var _native_time=global.ntte_full_progress.stats[$ "race:beetle:time"]
        assert(abs(_native_time-_time-timescale/30)<0.001,
            "Actual native EndStep duplicated or omitted race elapsed-time callback")
        _time=_native_time
        with(Player) visible=false
        scrNTTEFullRaceProgressEndStep()
        assert(global.ntte_full_progress.stats[$ "race:beetle:time"]==_time,
            "Hidden same-race native Player did not suppress source time counter")
        // Bare controllers model genuine native existence gates without
        // running generation/mutation UI constructors inside the fixture.
        var _lev=instance_create(91032,91000,Floor)
        with(_lev) instance_change(LevCont,false)
        scrNTTEFullRaceProgressEndStep()
        assert(abs(global.ntte_full_progress.stats[$ "race:beetle:time"]-_time-timescale/30)<=0.001,
            "Source LevCont override did not continue elapsed time despite hidden player")
        instance_destroy(_lev,false)
        with(Player) visible=true
        var _gen=instance_create(91064,91000,Floor)
        with(_gen) instance_change(GenCont,false)
        _time=global.ntte_full_progress.stats[$ "race:beetle:time"]
        scrNTTEFullRaceProgressEndStep()
        assert(global.ntte_full_progress.stats[$ "race:beetle:time"]==_time,
            "Source map generation did not suspend normal race elapsed time")
        instance_destroy(_gen,false)
        _seat.sit=true;scrNTTEFullRaceProgressEndStep()
        assert(global.ntte_full_progress.stats[$ "race:beetle:time"]==_time,
            "Native SitDown before sitting was mistaken for source PlayerSit time suppression")
        var _path=_scratch+"race-progression-roundtrip.json"
        assert(scrNTTEFullProgressSave(_path),"Source race progression JSON save failed")
        global.ntte_full_progress={schema:1,unlocks:{},loadouts:{},stats:{}}
        assert(scrNTTEFullProgressLoad(_path)
            && global.ntte_full_progress.stats[$ "race:beetle:runs"]==2
            && global.ntte_full_progress.stats[$ "race:parrot:kill"]==5
            && scrNTTEFullUnlockGet("loadout:crown:red") && scrNTTEFullLoadoutGet("heart:spawn",0)==3,
            "Source actual progress file lost stats/crown ownership/CrystalHeart next-run state")
    }
    finally {
        var _all=scrNTTEFullInstances(all)
        for(var _i=array_length(_all)-1;_i>=0;--_i) if(array_get_index(_before,_all[_i])<0 && instance_exists(_all[_i])) instance_destroy(_all[_i],false)
        for(var _i=0;_i<array_length(_hidden);++_i) instance_activate_object(_hidden[_i])
        scrNTTEFullAreaGeneratorRestore(_game);scrNTTEFullAreaGeneratorRestore(_players)
        global.playerinstance_list=_slots;player_count=_count
        global.ntte_full_progress=_progress;game_directory=_gameDirectory;random_set_seed(_seed)
    }
    scrNTTESmokeLog("FULL RACE PROGRESSION NATIVE: source per-slot runs/per-race wins/death same-ID revive/campfire loops+crown+heart/time visibility+generation+level-seat gates/team kills delta+best tuple/JSON persistence OK @"+string(30/timescale))
}

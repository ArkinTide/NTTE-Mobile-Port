function scrNTTEFullJungleChanceSeed(_success) {
    for(var _i=0;_i<256;++_i) {
        random_set_seed(_i)
        if((random(4)<1)==_success) return _i;
    }
    throw "Native Jungle fixture could not select a source1/4 chance branch";
}
function scrNTTEFullJungleLevelNativeTests() {
    var _before=scrNTTEFullInstances(all),_game=scrNTTEFullAreaGeneratorSnapshot(GameCont),
        _players=scrNTTEFullAreaGeneratorSnapshot(Player),_back=scrNTTEFullAreaGeneratorSnapshot(BackCont),
        _uber=scrNTTEFullAreaGeneratorSnapshot(UberCont),_mus=scrNTTEFullAreaGeneratorSnapshot(MusCont),
        _seed=random_get_seed(),_source=scrNTTEFullSourceSeedState(),_tick=current_frame,
        _vx=view_xview,_vy=view_yview,
        _sync=variable_global_exists("ntte_full_sync_generation")?global.ntte_full_sync_generation:false,
        _tutorial=save_get_value("game","tutorial",true),
        _parked=scrNTTEFullInstances([Floor,FloorMaker,Wall,TopSmall,Bones,enemy,prop,chestprop,RadChest,
            TopCont,SubTopCont,GenCont,NTTEFullTopObject,NTTEFullPet]),
        _bg=__background_get_colour_element(),_bgcolor=layer_background_get_blend(_bg[0])
    GameCont.ntte_full_source_seed=scrNTTEFullSourceSeedCopy(_source)
    for(var _i=0;_i<array_length(_parked);++_i) instance_deactivate_object(_parked[_i])
    try {
        GameCont.area=area_jungle;GameCont.loops=0;GameCont.subarea=1;GameCont.hard=1
        GameCont.gocrib=false;GameCont.crown=Crown.None;GameCont.underwater=false;UberCont.opt_bossintro=false
        var _yes=scrNTTEFullJungleChanceSeed(true),_no=scrNTTEFullJungleChanceSeed(false),
            _types=[Bush,JungleBandit,JungleFly,JungleAssassinHide]
        for(var _i=0;_i<4;++_i) {
            GameCont.loops=(_i==3)?1:0
            instance_create(250000,250000,Floor)
            var _target=instance_create(250016,250016,_types[_i]),_original=_target,
                _count=instance_number(_types[_i]),_wrap=noone
            random_set_seed(_yes);scrNTTEFullJungleLevelStart()
            with(NTTEFullTopObject) if(target==_original) _wrap=id
            assert(instance_exists(_wrap) && instance_exists(_original) && _wrap.target==_original
                && instance_number(_types[_i])==_count,
                "Original Jungle1/4 source variant must wrap the genuine existing instance without cloning or deleting it")
            assert(_original.ntte_full_top_object==_wrap && _wrap.spawn_dis>0 && _wrap.jump>=0,
                "Original Jungle provider bypassed genuine top_create heading/distance/height defaults")
            if(_i==2) assert(_wrap.jump==0 && _wrap.grav>=0.1 && _wrap.grav<=0.3,
                "Original JungleFly natural wall-top lost its real type-specific no-jump/low-gravity controller")
            // JungleAssassinHide inherits MeleeFake/prop, not enemy. Source
            // top_create suspends decision alarms only for actual enemies.
            if(instance_is(_original,enemy)) {
                assert(is_struct(_wrap.target_save)
                    && variable_struct_exists(_wrap.target_save,"ntte_full_saved_alarms"),
                    "Original Jungle enemy topify omitted saved native alarms: "+object_get_name(_types[_i]))
                for(var _a=0;_a<=10;++_a) assert(_original.alarm[_a]==-1,
                    "Original Jungle enemy topify did not suspend alarm "+string(_a)+": "+object_get_name(_types[_i]))
            }
            with(_wrap) event_perform(ev_step,ev_step_end)
            assert(instance_exists(_original) && _wrap.target==_original,
                "Actual Jungle wall-top EndStep lost ownership of its existing live target")
            scrNTTEFullMergedRuntimeTestCleanup(_before)
        }
        // Loop0 assassin is excluded entirely, even when next random would pass.
        GameCont.loops=0
        var _assassin=instance_create(251016,251016,JungleAssassinHide)
        random_set_seed(_yes);var _before_random=random_get_seed()
        scrNTTEFullJungleLevelStart()
        assert(!instance_exists(NTTEFullTopObject) && random_get_seed()==_before_random,
            "Original Jungle loop0 must exclude hidden Assassin without consuming its chance draw")
        instance_destroy(_assassin,false)
        var _bandit=instance_create(251016,251016,JungleBandit)
        random_set_seed(_no);scrNTTEFullJungleLevelStart()
        assert(!instance_exists(NTTEFullTopObject) && instance_exists(_bandit),
            "Original Jungle failed1/4 chance must retain an ordinary ground target")
        instance_destroy(_bandit,false)
        GameCont.area=area_desert
        instance_create(251016,251016,Bush);random_set_seed(_yes)
        scrNTTEFullJungleLevelStart()
        assert(!instance_exists(NTTEFullTopObject),"Original Jungle provider leaked top spawns into another area")
        scrNTTEFullMergedRuntimeTestCleanup(_before)
        // Exercise actual production native GenCont.Destroy hook at hard1.
        GameCont.area=area_jungle;GameCont.loops=1;save_set_value("game","tutorial",false)
        global.ntte_full_sync_generation=true
        var _gen=instance_create(0,0,GenCont)
        instance_destroy(FloorMaker,false);instance_destroy(Floor,false)
        for(var _i=0;_i<32;++_i) {
            var _x=252000+64*(_i mod 8),_y=252000+64*(_i div 8)
            instance_create(_x,_y,Floor);instance_create(_x+16,_y+16,JungleBandit)
        }
        with(_gen) event_perform(ev_destroy,0)
        instance_destroy(_gen,false)
        var _natural=0
        with(NTTEFullTopObject) if(instance_exists(target) && instance_is(target,JungleBandit)) {_natural+=1}
        assert(_natural>0 && _natural<32 && instance_number(JungleBandit)==32,
            "Actual native GenCont.Destroy omitted source Jungle provider or bypassed original1/4 chance/existing-target ownership")
    }
    finally {
        scrNTTEFullMergedRuntimeTestCleanup(_before)
        for(var _i=0;_i<array_length(_parked);++_i) instance_activate_object(_parked[_i])
        scrNTTEFullAreaGeneratorRestore(_game);scrNTTEFullAreaGeneratorRestore(_players)
        scrNTTEFullAreaGeneratorRestore(_back);scrNTTEFullAreaGeneratorRestore(_uber);scrNTTEFullAreaGeneratorRestore(_mus)
        GameCont.ntte_full_source_seed=_source;random_set_seed(_seed);current_frame=_tick
        save_set_value("game","tutorial",_tutorial);global.ntte_full_sync_generation=_sync
        layer_background_blend(_bg[0],_bgcolor);view_xview=_vx;view_yview=_vy
    }
    scrNTTESmokeLog("FULL JUNGLE LEVEL START: Bush/JungleBandit/JungleFly/loop hidden Assassin exact1/4 source selection/actual top_create existing target identity/default spawn/type gravity/native alarm suspension/real EndStep/loop0 excluded RNG/dry failed chance/area guard/actual GenCont Destroy natural provider hard1 OK @"+string(30/timescale))
}

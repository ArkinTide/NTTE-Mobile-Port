function scrNTTEFullChestDropNativeTests() {
    assert(scrNTTESmokeEnabled(),"Source chest chain requires explicit desktop fixture")
    var _before=scrNTTEFullInstances(all),_players=scrNTTEFullAreaGeneratorSnapshot(Player),
        _game=scrNTTEFullAreaGeneratorSnapshot(GameCont),_progress=global.ntte_full_progress,
        _seed=random_get_seed(),_rng=[],_hidden=scrNTTEFullInstances([GenCont,WeaponChest]),
        _oldpreview=variable_global_exists("ntte_chest_preview")?global.ntte_chest_preview:false,
        _tutorial=UberCont.showtutorial,_hardmode=UberCont.hardmode
    array_copy(_rng,0,global.rng_state,0,array_length(global.rng_state))
    global.ntte_full_progress={schema:1,unlocks:{},loadouts:{},stats:{}}
    global.ntte_full_progress.unlocks[$ "race:beetle"]=true
    for(var _i=0;_i<array_length(_hidden);++_i) instance_deactivate_object(_hidden[_i])
    GameCont.ntte_full_source_seed=scrNTTEFullSourceSeedBuild(1)
    try {
        // This source161-candidate seed intentionally targets a normal run;
        // the harness starts in the tutorial, whose native type mask shrinks
        // the pre-shuffle list. Test the real normal-run condition explicitly.
        UberCont.showtutorial=false;UberCont.hardmode=false
        with(Player) {wep=wep_revolver;bwep=wep_none;race=Race.Fish;}
        GameCont.hard=20;GameCont.crown=Crown.None;GameCont.area=area_desert;GameCont.subarea=2;GameCont.loops=1
        var _source=scrNTTEFullSourceSeedState()
        _source.wepseed=115;_source.levseed=891;_source.random=555
        GameCont.ntte_source_wepdrops=0;GameCont.nochest=9
        // Independent integer minstd shuffle reference: seed115 places raw
        // MOD candidate160 (Ultra Quasar) FIRST among the full161 candidates.
        // The real chest uses that same begin/counter/selector chain.
        var _box=instance_create(94000,94000,WeaponChest)
        _box.curse=1
        var _huge_before=instance_number(NTTEFullHugeWeaponChest),_pickups=instance_number(WepPickup),
            _native_before=random_get_seed(),_native_rng=[]
        array_copy(_native_rng,0,global.rng_state,0,array_length(global.rng_state))
        var _selected=scrNTTEFullBiggestWeaponChestLevelStart()
        assert(!instance_exists(_box) && instance_exists(_selected) && instance_is(_selected,NTTEFullHugeWeaponChest)
            && instance_number(NTTEFullHugeWeaponChest)==_huge_before+1
            && _selected.curse==1 && _selected.sprite_index==scrNTTERefSprite("HugeCursedChest")
            && _selected.spr_dead==scrNTTERefSprite("HugeCursedChestOpen") && _selected.snd_open==sndBigCursedChest,
            "Actual initial WeaponChest copy/collision did not identify Ultra and preserve cursed Huge reward art/state")
        assert(instance_number(WepPickup)==_pickups && GameCont.ntte_source_wepdrops==1 && GameCont.nochest==9
            && _source.random==555 && random_get_seed()==_native_before
            && !GameCont.ntte_can_spawn_ultra_quasar_rifle && !global.ntte_chest_preview,
            "Source Biggest preview leaked temporary physical loot/counter/RNG/nochest/audio mode/initial-chest gate")
        for(var _i=0;_i<array_length(_native_rng);++_i)
            assert(global.rng_state[_i]==_native_rng[_i],"Chest preview changed unrelated native RNG state")
        instance_destroy(_selected,false)
        // Cursed-big is explicitly absent from the source exact-object preview
        // list; a normal BigWeaponChest uses its REAL three-drop collision.
        GameCont.ntte_source_wepdrops=0;_source.random=321
        var _big=instance_create(94200,94000,BigWeaponChest),_excluded=instance_create(94400,94000,CursedBigChest)
        _big.curse=0
        _selected=scrNTTEFullBiggestWeaponChestLevelStart()
        assert(!instance_exists(_big) && instance_exists(_excluded) && instance_is(_selected,NTTEFullHugeWeaponChest)
            && instance_number(WepPickup)==_pickups && GameCont.ntte_source_wepdrops==1 && _source.random==321,
            "Source Biggest exact normal/big eligibility or real BigWeaponChest multi-drop cleanup diverged")
        instance_destroy(_selected,false);instance_destroy(_excluded,false)
        global.ntte_full_progress.unlocks[$ "race:beetle"]=false
        GameCont.ntte_source_wepdrops=3;_source.random=123
        var _ordinary=instance_create(94600,94000,WeaponChest),_old_count=GameCont.ntte_source_wepdrops
        _selected=scrNTTEFullBiggestWeaponChestLevelStart()
        assert(!instance_exists(_selected) && instance_exists(_ordinary)
            && GameCont.ntte_source_wepdrops==_old_count && _source.random==123
            && instance_number(WepPickup)==_pickups,
            "Unavailable Ultra preview replaced ordinary chest or failed complete no-match rollback")
        // Real chest collisions increment once, use source wepseed+counter,
        // choose through scrDecideWep's true entry and restore source levseed.
        var _expected_context={x:_ordinary.x,y:_ordinary.y,curse:_ordinary.curse},
            _snapshot=scrNTTEFullSourceSeedCopy(_source)
        scrNTTEFullSourceRandomSeed(_source.wepseed+_old_count)
        var _expected=scrNTTEFullWeaponDropDecide(_expected_context,1+2*_ordinary.curse,scrNTTEFullSourceRandom)
        GameCont.ntte_full_source_seed=_snapshot
        with(_ordinary) event_perform(ev_collision,PortalShock)
        assert(!instance_exists(_ordinary) && GameCont.ntte_source_wepdrops==_old_count+1
            && scrNTTEFullSourceSeedState().random==scrNTTEFullDropSeed(_source.levseed),
            "Real ordinary chest failed exactly-one source counter increment or level-seed restoration")
        var _new_pickup=noone
        with(WepPickup) if(array_get_index(_before,id)<0) {_new_pickup=id;break;}
        assert(instance_exists(_new_pickup) && _new_pickup.wep==_expected,
            "Native scrDecideWep entry bypassed original source-seeded candidate selector")
        // Source seed state/counter are plain native run fields and reset only
        // on a new stage. Other native independent streams remain independent.
        with(GameCont) scrRngStatesReset()
        assert(GameCont.ntte_source_wepdrops==0,"Real native next-level RNG reset retained previous source chest count")
        scrNTTEFullGoldChestNativeTests()
        scrNTTESmokeLog("PASS actual WeaponChest/BigWeaponChest copy+PortalShock preview, source161 shuffle seed115/Ultra discovery/cursed Huge, exact exclusions, complete no-match RNG+instance rollback, live scrDecideWep/counter/level-seed reset")
    }
    finally {
        var _all=scrNTTEFullInstances(all)
        for(var _i=array_length(_all)-1;_i>=0;--_i) if(array_get_index(_before,_all[_i])<0 && instance_exists(_all[_i])) instance_destroy(_all[_i],false)
        for(var _i=0;_i<array_length(_hidden);++_i) instance_activate_object(_hidden[_i])
        scrNTTEFullAreaGeneratorRestore(_game);scrNTTEFullAreaGeneratorRestore(_players)
        global.ntte_full_progress=_progress;global.rng_state=_rng;global.ntte_chest_preview=_oldpreview;random_set_seed(_seed)
        UberCont.showtutorial=_tutorial;UberCont.hardmode=_hardmode
    }
}
function scrNTTEFullGoldChestNativeTests() {
    var _game=scrNTTEFullAreaGeneratorSnapshot(GameCont),_players=scrNTTEFullAreaGeneratorSnapshot(Player),
        _p=instance_find(Player,0),_source=scrNTTEFullSourceSeedState(),_before=scrNTTEFullInstances(all),_rng=[]
    array_copy(_rng,0,global.rng_state,0,array_length(global.rng_state))
    GameCont.ultra_got=json_parse(json_stringify(GameCont.ultra_got))
    try {
        with(Player) {race=Race.Fish;wep=wep_golden_wrench;bwep=wep_golden_machinegun;}
        GameCont.crown=Crown.None;GameCont.loops=0
        var _list=scrNTTEFullGoldChestCandidates(_p)
        assert(array_length(_list)==4 && _list[0]==42 && _list[1]==43 && _list[2]==44 && _list[3]==45,
            "Original preloop gold pool lost exact native order or both-slot duplicate removal")
        _p.race=Race.Steroids
        assert(array_length(scrNTTEFullGoldChestCandidates(_p))==6,
            "Original gold selector lost Steroids duplicate exception")
        _p.race=Race.Fish;GameCont.loops=1
        _list=scrNTTEFullGoldChestCandidates(_p)
        assert(array_length(_list)==10 && _list[0]==42 && _list[4]==98 && _list[9]==103,
            "Original loop gold pool replaced the early six instead of appending the late six or admitted MOD aliases")
        // A numeric handle to a physical LWO must not compare equal to its
        // base raw ID in the source duplicate comparison.
        _p.wep={wep:wep_golden_wrench}
        assert(array_length(scrNTTEFullGoldChestCandidates(_p))==11,
            "Original GoldChest flattened a physical model while excluding native raw duplicates")
        _p.wep=wep_revolver;_p.bwep=wep_none
        _source.random=123
        var _probe=scrWeaponPickupCreate(95000,95000,wep_screwdriver),_value=0,_draws=0,
            _selector_rng=[],_goldseed=(48271*123) mod 2147483647,
            _index=floor(_goldseed/(2147483647/12)),_pool=[40,41,42,43,44,45,98,99,100,101,102,103]
        array_copy(_selector_rng,0,global.rng_state,0,array_length(global.rng_state))
        with(_probe) _value=scrDecideWepGold()
        assert(_value==_pool[_index] && _probe.wep==_value && _probe.roll && _source.random==_goldseed,
            "Actual scrDecideWepGold entry lost exactly-one source integer draw, exact pool order, caller writeback or WepPickup roll")
        for(var _i=0;_i<array_length(_selector_rng);++_i)
            assert(global.rng_state[_i]==_selector_rng[_i],"Original gold selector consumed Epsilon's unrelated native RNG stream")
        instance_destroy(_probe,false)
        // Genuine chest Player collision and PortalShock forwarding each use
        // one persistent source chest counter, independent native RNGStates,
        // original post-open levseed reset, and real per-copy golden pickups.
        for(var _ultra=0;_ultra<=1;++_ultra) {
            GameCont.ultra_got[Race.Steroids,UltraSkill.Ambidextrous]=_ultra
            _p.race=_ultra?Race.Steroids:Race.Fish
            _source.wepseed=123;_source.levseed=891;_source.random=555;GameCont.ntte_source_wepdrops=0
            var _box=instance_create(95200+64*_ultra,95000,GoldChest),_pickups=scrNTTEFullInstances(WepPickup),_open_rng=[]
            // Native chestprop.Create deliberately allocates dropseed from
            // WeaponDrops. Compare the source opening operation after that
            // real constructor, independently of this native allocation.
            array_copy(_open_rng,0,global.rng_state,0,array_length(global.rng_state))
            with(_box) event_perform(ev_collision,_ultra?PortalShock:Player)
            assert(!instance_exists(_box) && GameCont.ntte_source_wepdrops==1 && _source.random==891,
                "Real gold chest opening lost single source chest count, PortalShock path or level-seed restoration")
            var _new=scrNTTEFullInstances(WepPickup),_count=0,_newseed=123
            // Native instance enumeration is unspecified. Compare the
            // independent source RNG sequence as a multiset of real drops.
            var _expected=[]
            repeat(1+_ultra) {
                _newseed=(_newseed*48271) mod 2147483647
                array_push(_expected,_pool[floor(_newseed/(2147483647/12))])
            }
            for(var _j=0;_j<array_length(_new);++_j) if(array_get_index(_pickups,_new[_j])<0) {
                var _drop=_new[_j],_at=array_get_index(_expected,_drop.wep)
                assert(_at>=0 && _drop.roll && _drop.ammo==(scr_weapon_get_type(_drop.wep)!=Ammo.None)
                    && _drop.sprite_index==scr_weapon_get_sprite(_drop.wep),
                    "Actual gold chest produced wrong independent source choice, nonrolling pickup or wrong golden ammo/art")
                array_delete(_expected,_at,1);_count++
            }
            assert(_count==1+_ultra && array_length(_expected)==0,
                "Original GoldChest lost real1+Ambidextrous independently selected gold pickups")
            for(var _i=0;_i<array_length(_open_rng);++_i)
                assert(global.rng_state[_i]==_open_rng[_i],"Original gold opening consumed Epsilon's unrelated native RNG stream")
        }
        scrNTTESmokeLog("PASS original9940 GoldChest early6+loop12 exact order/raw duplicates/Steroids exception, actual gold selector source-one-draw/writeback/WepPickup roll, real Player+PortalShock chest counter/levelseed and independent1+Ambidextrous pickup art+ammo")
    }
    finally {
        var _all=scrNTTEFullInstances(all)
        for(var _i=array_length(_all)-1;_i>=0;--_i)
            if(array_get_index(_before,_all[_i])<0 && instance_exists(_all[_i])) instance_destroy(_all[_i],false)
        scrNTTEFullAreaGeneratorRestore(_game);scrNTTEFullAreaGeneratorRestore(_players);global.rng_state=_rng
    }
}

function scrNTTEFullWorldEarlyLevelNativeTests() {
    var _state=scrNTTEFullVanillaFixtureBegin(),_cacti=scrNTTEFullInstances([Cactus,NightCactus])
    for(var _i=0;_i<array_length(_cacti);++_i) instance_deactivate_object(_cacti[_i])
    try {
        GameCont.area=area_desert;GameCont.loops=0;GameCont.ntte_bigbandit_spawn=1
        var _want=instance_create(98000,98000,WantBoss)
        assert(_want.number==1,"Fixture did not create genuine native BigBandit WantBoss count")
        scrNTTEFullBigBanditDebtLevelStart()
        assert(!instance_exists(_want),"Previous BigBanditAmbush was not subtracted from next desert boss count")
        _want=instance_create(98000,98000,WantBoss);_want.number=3
        scrNTTEFullBigBanditDebtLevelStart();scrNTTEFullBigBanditDebtLevelStart()
        assert(_want.number==2 && _want.ntte_bigbandit_spawn==1,
            "BigBanditAmbush debt was not marked once on real WantBoss or got subtracted twice")
        GameCont.area=area_vault;scrNTTEFullBigBanditDebtLevelStart()
        assert(GameCont.ntte_bigbandit_spawn==1,"Secret area incorrectly erased carried BigBanditAmbush debt")
        GameCont.area=area_caves;scrNTTEFullBigBanditDebtLevelStart()
        assert(GameCont.ntte_bigbandit_spawn==0,"Next non-secret main area failed to reset carried BigBanditAmbush debt")
        scrNTTEFullCavesFixtureCleanup(_state.baseline)

        // Always consume the source flavor chance even if no cacti exist.
        GameCont.area=area_desert;random_set_seed(913);chance(1,9);var _expected=random(100000);random_set_seed(913)
        assert(scrNTTEFullFlavorCactusLevelStart()==noone && random(100000)==_expected,
            "Global flavor cactus branch changed original9-denominator/desert empty-list RNG")
        for(var _camp=0;_camp<2;++_camp) {
            GameCont.area=_camp?area_campfire:area_desert
            instance_create(98000,98000,Floor)
            var _old=instance_create(98016,98016,_camp?NightCactus:Cactus)
            _old.x=98016;_old.y=98016
            var _seed=scrNTTEFullVanillaFixtureSeed(1,_camp?3:9)
            random_set_seed(_seed);var _new=scrNTTEFullFlavorCactusLevelStart()
            assert(instance_is(_new,NTTEFullBigCactus) && !instance_exists(_old) && _new.xstart==98016 && _new.ystart==98016
                && _new.spr_idle==scrNTTERefSprite(_camp?"BigNightCactusIdle":"BigCactusIdle") && _new.hp==24,
                "Global flavor chance did not replace one real source cactus with correct source night/day BigCactus")
            scrNTTEFullCavesFixtureCleanup(_state.baseline)
        }

        GameCont.area=area_caves
        random_set_seed(699);_expected=random(100000);random_set_seed(699)
        assert(array_length(scrNTTEFullCrystalBabiesLevelStart())==0 && random(100000)==_expected,
            "No-spider level consumed crystal-baby RNG or created source-disallowed babies")
        var _adult=instance_create(98000,98000,Spider),_floor=instance_create(98208,98000,Floor),
            _crystal=instance_create(98224,98016,Crystal),_wallfloor=instance_create(98400,98000,Floor),
            _blocked=instance_create(98416,98016,Crystal),_wall=instance_create(98400,98000,Wall),
            _offfloor=instance_create(98700,98016,Crystal)
        _crystal.x=98224;_crystal.y=98016;_blocked.x=98416;_blocked.y=98016;_offfloor.x=98700;_offfloor.y=98016
        random_set_seed(771);var _babies=scrNTTEFullCrystalBabiesLevelStart()
        assert(array_length(_babies)>=1 && array_length(_babies)<=3 && instance_exists(_adult)
            && instance_exists(_crystal) && instance_exists(_blocked) && instance_exists(_offfloor),
            "Crystal babies source count/retained native crystal or adult behavior differs")
        for(var _i=0;_i<array_length(_babies);++_i)
            assert(_babies[_i].object_index==NTTEFullSpiderling && _babies[_i].xstart==98224 && _babies[_i].ystart==98016,
                "Crystal babies ignored actual floor/Wall filter or spawned at incorrect retained crystal position")
    }
    finally {
        for(var _i=0;_i<array_length(_cacti);++_i) instance_activate_object(_cacti[_i])
        scrNTTEFullVanillaFixtureEnd(_state)
    }
    scrNTTESmokeLog("FULL WORLD EARLY: real WantBoss BigBanditAmbush carry/subtract-once/secret preservation/main-area reset, original global cactus flavor chance and actual day/night replacement, crystal floor/wall/adult gate real1..3Spiderlings OK @"+string(30/timescale))
}

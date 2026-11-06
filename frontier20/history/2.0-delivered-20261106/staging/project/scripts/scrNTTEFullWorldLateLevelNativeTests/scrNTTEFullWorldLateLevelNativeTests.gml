function scrNTTEFullWorldLateLevelNativeTests() {
    var _state=scrNTTEFullVanillaFixtureBegin(),_progress=global.ntte_full_progress
    global.ntte_full_progress=json_parse(json_stringify(_progress))
    try {
        var _nest=instance_create(98000,98000,MaggotSpawn)
        random_set_seed(591);var _expected=random(100000);random_set_seed(591)
        assert(array_length(scrNTTEFullBabyScorpionsLevelStart())==0 && random(100000)==_expected
            && !variable_instance_exists(_nest,"babyscorp_drop"),
            "No-Scorpion natural baby pass consumed RNG or assigned absent nest drop")
        var _scorpion=instance_create(98100,98000,Scorpion),_choice=scrNTTEFullVanillaFixtureSeed(1,4)
        random_set_seed(_choice);var _babies=scrNTTEFullBabyScorpionsLevelStart()
        assert(array_length(_babies)>=1 && array_length(_babies)<=3 && instance_exists(_scorpion)
            && _nest.babyscorp_drop>=0 && _nest.babyscorp_drop<=1,
            "Natural normal Scorpion1/4 lost source1..3baby count/retained parent/nest chance")
        for(var _i=0;_i<array_length(_babies);++_i)
            assert(_babies[_i].object_index==NTTEFullBabyScorpion && !_babies[_i].gold,
                "Natural Scorpion created substitute or golden baby")
        scrNTTEFullCavesFixtureCleanup(_state.baseline)

        var _gold=instance_create(98000,98000,GoldScorpion),_nest=instance_create(98100,98000,MaggotSpawn)
        for(var _try=0;_try<64;++_try)
            assert(array_length(scrNTTEFullBabyScorpionsLevelStart())==0,"Natural gold Scorpion spawned babies outside ScorpionCity")
        var _city=instance_create(0,0,NTTEFullWorldEvent);_city.event_name="ScorpionCity"
        _choice=scrNTTEFullVanillaFixtureSeed(1,4);random_set_seed(_choice)
        _babies=scrNTTEFullBabyScorpionsLevelStart()
        assert(array_length(_babies)>=1 && array_length(_babies)<=3 && _nest.babyscorp_drop>=1 && _nest.babyscorp_drop<=2,
            "ScorpionCity lost golden babies1/4 or boosted1..2 nest death drop")
        for(var _i=0;_i<array_length(_babies);++_i)
            assert(_babies[_i].object_index==NTTEFullBabyScorpionGold && _babies[_i].gold && _babies[_i].max_hp==16,
                "ScorpionCity failed genuine golden baby art/stats/classification")
        var _before=instance_number(NTTEFullBabyScorpion),_count=_nest.babyscorp_drop
        _nest.hp=0;instance_destroy(_nest)
        assert(instance_number(NTTEFullBabyScorpion)==_before+_count && !instance_exists(_nest),
            "Actual native MaggotSpawn death did not consume source babyscorp_drop exactly once")
        var _replacement=instance_create(98100,98000,MaggotSpawn);_replacement.hp=0;_replacement.babyscorp_drop=2
        _before=instance_number(NTTEFullBabyScorpion);instance_destroy(_replacement,false)
        assert(instance_number(NTTEFullBabyScorpion)==_before,"Deleted/replaced native nest incorrectly released death babies")
        scrNTTEFullCavesFixtureCleanup(_state.baseline)

        for(var _loop=0;_loop<=1;++_loop) {
            GameCont.loops=_loop;var _dog=instance_create(98000,98000,BecomeScrapBoss),_tops=scrNTTEFullBigDogSpectatorsLevelStart()
            assert(array_length(_tops)>=2*(1+_loop) && array_length(_tops)<=6*(1+_loop) && instance_exists(_dog),
                "Natural BigDog spectators lost2..6*(1+loops) count or retained sleeping boss")
            for(var _i=0;_i<array_length(_tops);++_i) {
                var _top=_tops[_i]
                assert(_top.object_index==NTTEFullTopObject && instance_exists(_top.target)
                    && _top.target.object_index==NTTEFullTopRaven && _top.spawn_dis>=16 && _top.spawn_dis<=48,
                    "Natural BigDog spectator lost actual perched Raven/default enemy top separation")
            }
            scrNTTEFullCavesFixtureCleanup(_state.baseline)
        }
        GameCont.loops=0
        global.ntte_full_progress.unlocks[$ "orchid:seen"]=false
        var _rad=instance_create(98000,98000,RadChest)
        random_set_seed(999);_expected=random(100000);random_set_seed(999)
        assert(array_length(scrNTTEFullOrchidChestsLevelStart())==0 && instance_exists(_rad) && random(100000)==_expected,
            "Unseen Orchid converted RadChest or consumed source unlock-gated RNG")
        global.ntte_full_progress.unlocks[$ "orchid:seen"]=true;GameCont.rad=1800;GameCont.level=10
        var _orchids=scrNTTEFullOrchidChestsLevelStart()
        assert(array_length(_orchids)==1 && !instance_exists(_rad) && _orchids[0].object_index==NTTEFullOrchidChest
            && _orchids[0].xstart==98000 && _orchids[0].ystart==98000 && _orchids[0].alive,
            "Seen Orchid original rad*(level/10)/1800 failed actual live OrchidChest conversion")
        scrNTTEFullCavesFixtureCleanup(_state.baseline)

        var _nest=instance_create(98000,98000,MaggotSpawn),_bone=instance_create(98100,98000,BonePile),_sawMin=false,_sawMax=false,_sawBone=false
        // Isolate the nest0..2 result and attached bone1/2 fly through real RNG.
        for(var _try=1;_try<=128 && (!_sawMin || !_sawMax || !_sawBone);++_try) {
            random_set_seed(_try);var _flies=scrNTTEFullFliesLevelStart(),_nestCount=0
            for(var _i=0;_i<array_length(_flies);++_i) {
                var _fly=_flies[_i]
                assert(_fly.object_index==NTTEFullFlySpin,"Natural fly pass emitted substitute effect")
                if(_fly.target==_bone) {
                    _sawBone=true
                    assert(_fly.target_x>=-8 && _fly.target_x<=8 && _fly.target_y>=-8 && _fly.target_y<=0,
                        "Natural BonePile fly lost actual target/original8px orbit offsets")
                }
                else {
                    _nestCount++
                    assert(abs(_fly.xstart-_nest.x)<=12 && abs(_fly.ystart-_nest.y)<=8,
                        "Natural nest fly exceeded original12x8 spawn scatter")
                }
            }
            assert(_nestCount>=0 && _nestCount<=2,"Natural nest fly count exceeded original0..2")
            _sawMin=_sawMin || _nestCount==0;_sawMax=_sawMax || _nestCount==2
            for(var _i=0;_i<array_length(_flies);++_i) instance_destroy(_flies[_i],false)
        }
        assert(_sawMin && _sawMax && _sawBone,"Natural fly pass did not cover source0/2nest endpoints or attached bone fly")
        scrNTTEFullCavesFixtureCleanup(_state.baseline)

        GameCont.area=area_scrapyards;var _f=instance_create(98000,98000,Floor),_wrong=instance_create(98096,98000,Floor)
        _f.sprite_index=sprFloor3;_f.image_index=3;_wrong.sprite_index=sprFloor3;_wrong.image_index=2
        var _pools=scrNTTEFullBabySludgeLevelStart()
        assert(array_length(_pools)==1 && _pools[0].sprite_index==scrNTTERefSprite("msk.SludgePoolSmall")
            && _pools[0].spr_floor==sprFloor3 && array_length(_pools[0].floors)==1 && _pools[0].floors[0]==_f && _pools[0].setup,
            "Natural small sludge lost frame3 selector, original small mask or real existing-floor handoff")
        var _pool=_pools[0],_floors=instance_number(Floor)
        with(_pool) scrNTTEFullSludgePoolSetup()
        assert(instance_number(Floor)==_floors && _f.sprite_index==sprFloor3 && _f.image_index==3 && _wrong.image_index==2,
            "Natural small sludge re-excavated floor or changed source frame3/other-frame contract")
        assert(array_length(scrNTTEFullBabySludgeLevelStart())==0,"Natural small sludge duplicated an already-covered source floor")
    }
    finally {
        global.ntte_full_progress=_progress;scrNTTEFullVanillaFixtureEnd(_state)
    }
    scrNTTESmokeLog("NATURAL LATE WORLD: Scorpion/City gold/source baby/nest gates, actual one-shot native nest-death consumption/deletion suppression;real scaled-count BigDog perched Ravens;Orchid seen/RNG/rad-level conversion;real0..2nest+attached bone flies;small sludge frame3 mask/existing floor/no duplication OK")
}

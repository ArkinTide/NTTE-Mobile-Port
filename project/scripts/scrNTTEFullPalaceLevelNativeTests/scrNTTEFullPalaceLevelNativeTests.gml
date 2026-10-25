function scrNTTEFullPalaceLevelNativeTests() {
    var _state=scrNTTEFullVanillaFixtureBegin(),_carpets=scrNTTEFullInstances(Carpet)
    for(var _i=0;_i<array_length(_carpets);++_i) instance_deactivate_object(_carpets[_i])
    GameCont.area=area_palace
    try {
        GameCont.area=area_caves;random_set_seed(711);var _expected=random(100000);random_set_seed(711)
        scrNTTEFullPalaceLevelStart()
        assert(random(100000)==_expected,"Natural Palace provider consumed unrelated area RNG")
        GameCont.area=area_palace;GameCont.subarea=1
        var _carpet=instance_create(10016,9200,Carpet);_carpet.depth=22;_carpet.image_speed=0;_carpet.sprite_index=sprCarpet
        assert(array_length(scrNTTEFullPalaceNaturalStairs())==0 && _carpet.depth==22,
            "Natural Palace stairs ran outside third subarea")
        GameCont.subarea=3
        var _first=_carpet.bbox_top+128
        for(var _row=0;_row<20;++_row) for(var _column=0;_column<8;++_column)
            instance_create(9888+32*_column,_first+32*_row,Floor)
        var _stairs=scrNTTEFullPalaceNaturalStairs()
        assert(array_length(_stairs)==2 && _carpet.depth==9,
            "Natural Palace lost source368px step spacing, two ordinary bands or carpet depth9")
        for(var _band=0;_band<array_length(_stairs);++_band) {
            var _stair=_stairs[_band],_originY=_stair.y-27
            assert(_stair.object_index==NTTEFullPalaceStairs && _stair.x==9888 && _stair.image_xscale==8
                && !_stair.visible && _stair.mask_index==mskFloor,
                "Natural Palace ordinary band lost genuine staircase controller/mask/27px offset/eight-wide scale")
            for(var _image=0;_image<3;++_image) {
                var _plain=instance_position(9904,_originY+32*_image+16,Floor),
                    _left=instance_position(10000,_originY+32*_image+16,Floor),
                    _right=instance_position(10032,_originY+32*_image+16,Floor)
                assert(instance_exists(_plain) && _plain.sprite_index==scrNTTERefSprite("FloorPalaceStairs")
                    && _plain.image_index==_image && _plain.depth==8,
                    "Natural Palace stairs failed source3-row plain floor art/index/depth8")
                assert(instance_exists(_left) && instance_exists(_right)
                    && _left.sprite_index==scrNTTERefSprite("FloorPalaceStairsCarpet") && _right.sprite_index==_left.sprite_index
                    && _left.image_index==_image*2 && _right.image_index==_image*2+1,
                    "Natural Palace carpet stairs lost source alternating left/right six-frame artwork")
            }
        }
        scrNTTEFullCavesFixtureCleanup(_state.baseline)

        for(var _loop=0;_loop<=1;++_loop) {
            GameCont.loops=_loop;var _old=instance_create(98000,98000,Guardian),_choice=scrNTTEFullVanillaFixtureSeed(1,20)
            random_set_seed(_choice);var _new=scrNTTEFullPalaceGuardians()
            assert(array_length(_new)==1 && !instance_exists(_old) && _new[0].object_index==NTTEFullPortalGuardian
                && _new[0].xstart==98000 && _new[0].ystart==98000,
                "Natural Palace preloop/loop Guardian1/20 failed actual PortalGuardian replacement")
            scrNTTEFullCavesFixtureCleanup(_state.baseline)
        }
        GameCont.loops=0;var _bandit=instance_create(98000,98000,JungleBandit),_exploder=instance_create(98100,98000,ExploGuardian)
        random_set_seed(945);_expected=random(100000);random_set_seed(945)
        assert(array_length(scrNTTEFullPalaceGulls())==0 && array_length(scrNTTEFullPalaceExploGuardians())==0
            && random(100000)==_expected && instance_exists(_bandit) && instance_exists(_exploder),
            "Preloop Palace consumed Gull/ExploGuardian loop-only RNG or changed original entities")
        scrNTTEFullCavesFixtureCleanup(_state.baseline)

        GameCont.loops=1
        for(var _five=0;_five<=1;++_five) {
            var _f=instance_create(98000,98000,Floor),_bandit=instance_create(98016,98016,JungleBandit),_choice=-1
            for(var _candidate=1;_candidate<=10000 && _choice<0;++_candidate) {
                random_set_seed(_candidate);if(chance(1,5)==(_five==1)) _choice=_candidate
            }
            assert(_choice>=0,"Natural Palace fixture could not exercise original1-or5 Gull outcome")
            random_set_seed(_choice);var _gulls=scrNTTEFullPalaceGulls()
            assert(array_length(_gulls)==(_five?5:1) && instance_exists(_bandit),
                "Natural Palace loop changed source1-or5 gull count or deleted retained JungleBandit")
            var _top=noone
            with(NTTEFullTopObject) if(target==_bandit) _top=id
            assert(instance_exists(_top) && _top.target==_bandit && _bandit.ntte_full_top_object==_top
                && _top.spawn_dis>=16 && _top.spawn_dis<=48,
                "Natural Palace loop failed genuine retained JungleBandit wall-top/default16..48offset")
            for(var _i=0;_i<array_length(_gulls);++_i)
                assert(_gulls[_i].object_index==NTTEFullGull && abs(_gulls[_i].max_hp-8*(1+GameCont.loops/20))<=0.00001
                    && _gulls[_i].xstart==98016 && _gulls[_i].ystart==98016,
                    "Natural Palace spawned substitute Gull or moved it with the original JungleBandit")
            scrNTTEFullCavesFixtureCleanup(_state.baseline)
        }
        var _old=instance_create(98000,98000,ExploGuardian),_choice=scrNTTEFullVanillaFixtureSeed(1,10)
        random_set_seed(_choice);var _new=scrNTTEFullPalaceExploGuardians()
        assert(array_length(_new)==1 && !instance_exists(_old) && _new[0].object_index==NTTEFullPortalGuardian,
            "Natural Palace loop ExploGuardian1/10 failed real PortalGuardian substitution")
    }
    finally {
        scrNTTEFullVanillaFixtureEnd(_state)
        for(var _i=0;_i<array_length(_carpets);++_i) instance_activate_object(_carpets[_i])
    }
    scrNTTESmokeLog("NATURAL PALACE: area/subarea gates, ordinary368px staircase bands/native controllers/27offset/eightwide masks, actual3row/six-carpet-frame/depth art;Guardian20 preloop+loop, retained JungleBandit/default wall-top plus1-or5 real Gulls and ExploGuardian10 OK")
}

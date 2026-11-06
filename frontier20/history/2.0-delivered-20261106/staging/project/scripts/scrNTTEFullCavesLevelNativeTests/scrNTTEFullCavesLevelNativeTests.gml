function scrNTTEFullCavesFixtureSeed(_denominator) {
    for(var _seed=1;_seed<=10000;++_seed) {
        random_set_seed(_seed)
        if(chance(1,_denominator)) return _seed
    }
    assert(false,"Caves native fixture could not find eligible source chance seed")
}
function scrNTTEFullCavesFixtureCleanup(_before) {
    var _after=scrNTTEFullInstances(all)
    for(var _i=0;_i<array_length(_after);++_i)
        if(array_get_index(_before,_after[_i])<0 && instance_exists(_after[_i])) instance_destroy(_after[_i],false)
}
function scrNTTEFullCavesLevelNativeTests() {
    scrNTTEFullFloorInit()
    var _before=scrNTTEFullInstances(all),_game=scrNTTEFullAreaGeneratorSnapshot(GameCont),
        _seed=random_get_seed(),_hidden=scrNTTEFullInstances([enemy,prop,Floor,Wall,InvisiWall,PortalClear,GenCont,LevCont]),
        _active=scrNTTEFullValue(GameCont,"ntte_full_active_coast",false),
        _style=global.ntte_full_floor_style,_area=global.ntte_full_floor_area,
        _aw=global.ntte_full_floor_aw,_ah=global.ntte_full_floor_ah,_ax=global.ntte_full_floor_ax,_ay=global.ntte_full_floor_ay
    for(var _i=0;_i<array_length(_hidden);++_i) instance_deactivate_object(_hidden[_i])
    GameCont.ntte_full_active_coast=false;GameCont.crown=crwn_none;GameCont.loops=0;GameCont.subarea=1
    if(!instance_exists(TopCont)) { GameCont.area=area_desert;instance_create(0,0,TopCont) }
    GameCont.area=area_caves;scrNTTEFullFloorResetStyle();scrNTTEFullFloorSetAlign(32,32,0,0)
    var _baseline=scrNTTEFullInstances(all)
    try {
        GameCont.area=area_city;random_set_seed(5812);var _expected=random(100000);random_set_seed(5812)
        scrNTTEFullCavesLevelStartBeforePets();scrNTTEFullCavesLevelStartAfterPets()
        assert(random(100000)==_expected,"Natural caves consumed RNG outside both source cave areas")
        GameCont.area=area_caves
        var _near=instance_create(10100,10100,Bandit),_far=instance_create(98000,98000,Bandit),
            _miner=scrNTTEFullCavesMiner()
        assert(instance_exists(_miner) && _miner.object_index==NTTEFullMinerBandit && _miner.xstart==98000 && _miner.ystart==98000
            && _miner.hp==8 && !instance_exists(_far) && instance_exists(_near),
            "Natural caves Miner lost actual farthest Bandit replacement/native8HP constructor")
        scrNTTEFullCavesFixtureCleanup(_baseline)

        for(var _curse=0;_curse<=1;++_curse) {
            GameCont.area=_curse ? area_cursed_caves:area_caves
            var _spider=instance_create(98000,98000,Spider),_choice=scrNTTEFullCavesFixtureSeed(4)
            random_set_seed(_choice);var _babies=scrNTTEFullCavesSpiderlings()
            assert(!instance_exists(_spider) && array_length(_babies)==1 && _babies[0].object_index==NTTEFullSpiderling
                && _babies[0].curse==_curse && _babies[0].hp==4 && _babies[0].xstart==98000,
                "Natural cave Spiderling1/4 lost real native constructor or source area curse")
            scrNTTEFullCavesFixtureCleanup(_baseline)
            var _crystal=instance_create(98000,98000,_curse ? InvLaserCrystal:LaserCrystal)
            _choice=scrNTTEFullCavesFixtureSeed(5);random_set_seed(_choice)
            var _mortars=scrNTTEFullCavesMortars()
            assert(!instance_exists(_crystal) && array_length(_mortars)==1
                && _mortars[0].object_index==(_curse ? NTTEFullInvMortar:NTTEFullMortar)
                && _mortars[0].curse==_curse,
                "Natural cave1/5 exact laser crystal replacement lost actual Mortar or cursed class")
            scrNTTEFullCavesFixtureCleanup(_baseline)
        }
        GameCont.area=area_caves
        var _styled=instance_create(98000,98000,Floor);_styled.styleb=true
        var _crystal=instance_create(98016,98016,LaserCrystal),_choice=scrNTTEFullCavesFixtureSeed(5)
        random_set_seed(_choice);chance(1,5);_expected=random(100000);random_set_seed(_choice)
        assert(array_length(scrNTTEFullCavesMortars())==0 && instance_exists(_crystal) && random(100000)==_expected,
            "Natural Mortar ignored overlapping styled-floor guard or consumed chance in wrong order")
        scrNTTEFullCavesFixtureCleanup(_baseline)
        _crystal=instance_create(98000,98000,LightningCrystal);_choice=scrNTTEFullCavesFixtureSeed(5)
        random_set_seed(_choice)
        assert(array_length(scrNTTEFullCavesMortars())==0 && instance_exists(_crystal),
            "Natural Mortar incorrectly replaced a non-Laser crystaltype")
        scrNTTEFullCavesFixtureCleanup(_baseline)

        GameCont.loops=1
        for(var _curse=0;_curse<=1;++_curse) {
            var _spider=instance_create(98000,98000,_curse ? InvSpider:Spider),_choice=scrNTTEFullCavesFixtureSeed(6)
            random_set_seed(_choice);chance(1,6);var _angle=round(random(360)/90)*90
            random_set_seed(_choice);var _bats=scrNTTEFullCavesBats()
            assert(!instance_exists(_spider) && array_length(_bats)==2,
                "Natural loop cave CrystalBat1/6 did not replace native Spider with opposed pair")
            for(var _i=0;_i<2;++_i) {
                var _bat=_bats[_i],_direction=_angle+_i*180
                assert(_bat.object_index==(_curse ? NTTEFullInvCrystalBat:NTTEFullCrystalBat)
                    && abs(_bat.x-(98000+lengthdir_x(64,_direction)))<=0.00001
                    && abs(_bat.y-(98000+lengthdir_y(64,_direction)))<=0.00001,
                    "Natural CrystalBat pair lost actual curse class, rounded cardinal angle or two32px moves")
            }
            scrNTTEFullCavesFixtureCleanup(_baseline)
        }
        var _spider=instance_create(98000,98000,Spider)
        for(var _d=0;_d<360;_d+=90) instance_create(98000+lengthdir_x(32,_d),98000+lengthdir_y(32,_d),Wall)
        _choice=scrNTTEFullCavesFixtureSeed(6);random_set_seed(_choice)
        var _bats=scrNTTEFullCavesBats()
        assert(array_length(_bats)==2 && _bats[0].x==98000 && _bats[0].y==98000 && _bats[1].x==98000 && _bats[1].y==98000,
            "Natural CrystalBat placement crossed a real solid Wall")
        scrNTTEFullCavesFixtureCleanup(_baseline)
        GameCont.loops=0;random_set_seed(881);_expected=random(100000);random_set_seed(881)
        assert(array_length(scrNTTEFullCavesBats())==0 && random(100000)==_expected,
            "Preloop cave generated bats or consumed their RNG")

        for(var _blood=0;_blood<=1;++_blood) {
            GameCont.crown=_blood ? crwn_blood:crwn_none
            var _crystal=instance_create(98000,98000,LaserCrystal),_choice=scrNTTEFullCavesFixtureSeed(40*(_blood ? 0.7:1))
            random_set_seed(_choice);var _lightning=scrNTTEFullCavesLightning()
            assert(!instance_exists(_crystal) && array_length(_lightning)==1 && _lightning[0].object_index==LightningCrystal,
                "Natural preloop first-cave LightningCrystal lost original40/blood28 denominator")
            scrNTTEFullCavesFixtureCleanup(_baseline)
        }
        GameCont.subarea=2;var _crystal=instance_create(98000,98000,LaserCrystal)
        random_set_seed(82);_expected=random(100000);random_set_seed(82)
        assert(array_length(scrNTTEFullCavesLightning())==0 && instance_exists(_crystal) && random(100000)==_expected,
            "Natural preloop lightning ignored first subarea or consumed gated RNG")
        scrNTTEFullCavesFixtureCleanup(_baseline)

        for(var _curse=0;_curse<=1;++_curse) {
            GameCont.area=_curse ? area_cursed_caves:area_caves
            var _nearFloor=instance_create(10000,10000,Floor),_farFloor=instance_create(11008,11008,Floor),
                _near=instance_create(10016,10016,Crystal),_floating=instance_create(12000,12000,Crystal),
                _eligible=instance_create(11024,11024,Crystal),_choice=scrNTTEFullCavesFixtureSeed(2)
            _near.x=10016;_near.y=10016;_eligible.x=11024;_eligible.y=11024
            random_set_seed(_choice);var _big=scrNTTEFullCavesBigCrystal()
            assert(instance_exists(_big) && _big.object_index==NTTEFullBigCrystalProp && _big.curse==_curse && _big.hp==48
                && _big.xstart==11024 && _big.ystart==11024 && !instance_exists(_eligible)
                && instance_exists(_near) && instance_exists(_floating),
                "Natural big crystal lost shuffle/96px/floor eligibility or genuine cursed native48HP creation")
            var _num=instance_number(_curse ? NTTEFullInvCrystalBat:NTTEFullCrystalBat)
            assert(_num>=2 && _num<=3,"Natural big crystal omitted original two/three native bat guards")
            scrNTTEFullCavesFixtureCleanup(_baseline)
        }
    }
    finally {
        scrNTTEFullCavesFixtureCleanup(_before)
        for(var _i=0;_i<array_length(_hidden);++_i) instance_activate_object(_hidden[_i])
        scrNTTEFullAreaGeneratorRestore(_game);GameCont.ntte_full_active_coast=_active;random_set_seed(_seed)
        scrNTTEFullFloorSetStyle(_style,_area);scrNTTEFullFloorSetAlign(_aw,_ah,_ax,_ay)
    }
    scrNTTESmokeLog("NATURAL CAVES: farthest actual Miner, source Spiderling/Mortar/style/RNG, opposed normal/cursed bats/solid-wall placement, preloop lightning/blood/area gates, real big crystals/guards OK")
}
function scrNTTEFullCavesHyperPitNativeTests() {
    scrNTTEFullFloorInit()
    var _before=scrNTTEFullInstances(all),_game=scrNTTEFullAreaGeneratorSnapshot(GameCont),
        _seed=random_get_seed(),_hidden=scrNTTEFullInstances([enemy,prop,Floor,Wall,InvisiWall,PortalClear,GenCont,LevCont,NTTEFullManholeOpen]),
        _active=scrNTTEFullValue(GameCont,"ntte_full_active_coast",false),
        _style=global.ntte_full_floor_style,_area=global.ntte_full_floor_area,
        _aw=global.ntte_full_floor_aw,_ah=global.ntte_full_floor_ah,_ax=global.ntte_full_floor_ax,_ay=global.ntte_full_floor_ay
    for(var _i=0;_i<array_length(_hidden);++_i) instance_deactivate_object(_hidden[_i])
    GameCont.ntte_full_active_coast=false;GameCont.crown=crwn_none;GameCont.loops=1
    if(!instance_exists(TopCont)) { GameCont.area=area_desert;instance_create(0,0,TopCont) }
    scrNTTEFullFloorResetStyle();scrNTTEFullFloorSetAlign(32,32,0,0)
    var _baseline=scrNTTEFullInstances(all)
    try {
        for(var _curse=0;_curse<=1;++_curse) {
            GameCont.area=_curse ? area_cursed_caves:area_caves
            var _boss=instance_create(10300,10016,HyperCrystal),_oldX=_boss.x,_oldY=_boss.y,
                _bossId=real(_boss.id),_clears=scrNTTEFullInstances(PortalClear),_clearIds=[],_second=instance_create(10016,10300,HyperCrystal),
                _retained=instance_create(10032,10032,PortalClear)
            for(var _i=0;_i<array_length(_clears);++_i) array_push(_clearIds,real(_clears[_i].id))
            // Ensure one unrelated clear is beyond the source boss-local15-ID window.
            while(real(_retained.id)<=_bossId+15) _retained=instance_create(10032,10032,PortalClear)
            assert(scrNTTEFullCavesHyperPit()==noone && _boss.x==_oldX && _boss.y==_oldY,
                "Natural HyperCrystal pit created a room without an eligible FloorNormal")
            var _floor=instance_create(10336,10000,Floor),_hole=scrNTTEFullCavesHyperPit()
            assert(instance_exists(_hole) && _hole.object_index==NTTEFullManholeOpen && _hole.ntte_full_big
                && _hole.sprite_index==scrNTTERefSprite(_curse ? "CaveHoleCursed":"CaveHole")
                && _hole.mask_index==scrNTTERefSprite("msk.CaveHole") && !_hole.ntte_full_canportal,
                "Natural HyperCrystal pit lost actual big ManholeOpen class/source area artwork/mask/default portal state")
            assert(_boss.x==_hole.x && _boss.y==_hole.y && _boss.xprevious==_boss.x && _boss.yprevious==_boss.y
                && _boss.xstart==10300 && _boss.ystart==10016 && _second.x==10016 && _second.y==10300,
                "Natural HyperCrystal pit lost first-only relocation/previous correction or wrongly changed native spawn coordinates")
            for(var _i=0;_i<array_length(_clearIds);++_i) if(_clearIds[_i]>_bossId && _clearIds[_i]<=_bossId+15)
                assert(!instance_exists(_clearIds[_i]),"Natural HyperCrystal pit retained native boss-local PortalClear")
            assert(instance_exists(_retained),"Natural HyperCrystal pit removed unrelated PortalClear beyond source15-ID window")
            // The central5x5 room remains solid floor; two ring hallways extend
            // the source9x3/3x9 axes to144px without filling outer corners.
            assert(position_meeting(_hole.x,_hole.y,Floor)
                && position_meeting(_hole.x+128,_hole.y-32,Floor) && position_meeting(_hole.x-128,_hole.y+32,Floor)
                && position_meeting(_hole.x-32,_hole.y+128,Floor) && position_meeting(_hole.x+32,_hole.y-128,Floor)
                && !position_meeting(_hole.x+112,_hole.y+112,Floor),
                "Natural HyperCrystal pit omitted source5x5 arena/two orthogonal ring hallways or filled outer corners")
            scrNTTEFullCavesFixtureCleanup(_baseline)
        }
    }
    finally {
        scrNTTEFullCavesFixtureCleanup(_before)
        for(var _i=0;_i<array_length(_hidden);++_i) instance_activate_object(_hidden[_i])
        scrNTTEFullAreaGeneratorRestore(_game);GameCont.ntte_full_active_coast=_active;random_set_seed(_seed)
        scrNTTEFullFloorSetStyle(_style,_area);scrNTTEFullFloorSetAlign(_aw,_ah,_ax,_ay)
    }
    scrNTTESmokeLog("NATURAL HYPERCRYSTAL PIT: actual FloorNormal source5x5 arena/9x3+3x9 rings, first-boss previous-only relocation, source15-ID PortalClear window, actual normal/cursed big ManholeOpen/mask OK")
}

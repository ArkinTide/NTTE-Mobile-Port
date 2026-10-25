function scrNTTEFullVanillaFixtureBegin() {
    scrNTTEFullFloorInit()
    var _state={before:scrNTTEFullInstances(all),game:scrNTTEFullAreaGeneratorSnapshot(GameCont),seed:random_get_seed(),
        hidden:scrNTTEFullInstances([enemy,prop,chestprop,Floor,Wall,InvisiWall,PortalClear,GenCont,LevCont,NTTEFullWorldEvent,NTTEFullSawTrap]),
        active:scrNTTEFullValue(GameCont,"ntte_full_active_coast",false),
        style:global.ntte_full_floor_style,area:global.ntte_full_floor_area,
        aw:global.ntte_full_floor_aw,ah:global.ntte_full_floor_ah,ax:global.ntte_full_floor_ax,ay:global.ntte_full_floor_ay}
    for(var _i=0;_i<array_length(_state.hidden);++_i) instance_deactivate_object(_state.hidden[_i])
    GameCont.ntte_full_active_coast=false;GameCont.crown=crwn_none;GameCont.loops=0;GameCont.subarea=1;GameCont.area=area_desert
    if(!instance_exists(TopCont)) instance_create(0,0,TopCont)
    scrNTTEFullFloorResetStyle();scrNTTEFullFloorSetAlign(32,32,0,0)
    _state.baseline=scrNTTEFullInstances(all)
    return _state
}
function scrNTTEFullVanillaFixtureEnd(_state) {
    scrNTTEFullCavesFixtureCleanup(_state.before)
    for(var _i=0;_i<array_length(_state.hidden);++_i) instance_activate_object(_state.hidden[_i])
    scrNTTEFullAreaGeneratorRestore(_state.game);GameCont.ntte_full_active_coast=_state.active;random_set_seed(_state.seed)
    scrNTTEFullFloorSetStyle(_state.style,_state.area);scrNTTEFullFloorSetAlign(_state.aw,_state.ah,_state.ax,_state.ay)
}
function scrNTTEFullVanillaFixtureSeed(_numerator,_denominator) {
    for(var _seed=1;_seed<=10000;++_seed) { random_set_seed(_seed);if(chance(_numerator,_denominator)) return _seed }
    assert(false,"Natural biome fixture failed to find original chance seed")
}
function scrNTTEFullDesertLevelNativeTests() {
    var _state=scrNTTEFullVanillaFixtureBegin()
    try {
        GameCont.area=area_caves;random_set_seed(7331);var _expected=random(100000);random_set_seed(7331)
        scrNTTEFullDesertLevelStart();scrNTTEFullScrapyardLevelStart();scrNTTEFullLabsLevelStart()
        assert(random(100000)==_expected,"Natural base-biome providers consumed RNG in unrelated area")
        GameCont.area=area_desert
        var _near=instance_create(10000,10000,Floor),_eligible=instance_create(10320,10000,Floor),
            _wallFloor=instance_create(10416,10000,Floor),_wall=instance_create(10416,10000,Wall),
            _propFloor=instance_create(10512,10000,Floor),_prop=instance_create(10528,10016,BigSkull),
            _chestFloor=instance_create(10608,10000,Floor),_chest=instance_create(10624,10016,chestprop),
            _maggotFloor=instance_create(10704,10000,Floor),_maggot=instance_create(10720,10016,MaggotSpawn),
            _exploded=instance_create(10800,10000,FloorExplo)
        _prop.x=10528;_prop.y=10016;_chest.mask_index=mskFloor;_chest.x=10608;_chest.y=10000
        _maggot.x=10720;_maggot.y=10016
        var _candidates=scrNTTEFullDesertPropFloors()
        assert(array_length(_candidates)==1 && _candidates[0]==_eligible,
            "Natural desert prop candidates lost exact normal floor,48distance,wall/prop/chest/nest exclusions")
        scrNTTEFullCavesFixtureCleanup(_state.baseline)

        // No eligible floor: source last-subarea shark skull falls back to spawn.
        GameCont.subarea=3;var _oldSkull=instance_create(98000,98000,BigSkull)
        var _props=scrNTTEFullDesertProps(),_skull=noone,_dummy=noone
        with(NTTEFullCoastBossBecome) _skull=id
        with(chestprop) if(x==0 && y==0) _dummy=id
        assert(!instance_exists(_oldSkull) && instance_exists(_skull) && _skull.xstart==10016 && _skull.ystart==10016
            && _skull.max_hp==100 && instance_exists(_skull.prompt) && _skull.prompt.text=="DONATE",
            "Natural desert3 lost actual donation skull/default spawn or retained old BigSkull")
        assert(instance_exists(_dummy) && !_dummy.visible && _dummy.mask_index==mskNone,
            "Natural desert failed original invisible chestprop Oasis-skip blocker")
        assert(instance_number(BonePile)==0 && instance_number(NTTEFullScorpionRock)==0,
            "Natural desert invented props without a usable normal floor or on last subarea")
        scrNTTEFullCavesFixtureCleanup(_state.baseline)

        GameCont.subarea=1
        var _f=instance_create(10320,10000,Floor),_city=instance_create(0,0,NTTEFullWorldEvent)
        _city.event_name="ScorpionCity"
        _props=scrNTTEFullDesertProps()
        assert(instance_number(BonePile)==0 && instance_number(NTTEFullScorpionRock)==0,
            "Natural desert ignored active ScorpionCity prop suppression")
        instance_destroy(_city,false)
        _props=scrNTTEFullDesertProps();var _bone=instance_find(BonePile,0)
        assert(instance_exists(_bone) && _bone.xstart==10336 && _bone.ystart==10016,
            "Natural desert consistent skeleton did not use real BonePile at next shuffled floor center")
        // Existing bone consumes no floor, leaving the sole eligible floor for rock.
        _bone.x=98000;_bone.y=98000
        var _rock=noone
        for(var _attempt=0;_attempt<32 && !instance_exists(_rock);++_attempt) {
            _props=scrNTTEFullDesertProps();_rock=instance_find(NTTEFullScorpionRock,0)
        }
        assert(instance_exists(_rock) && _rock.xstart==10336 && _rock.ystart==10014 && _rock.hp==32,
            "Natural desert2/5 ScorpionRock lost real constructor/normal floor center minus2")
        assert(instance_number(BonePile)==1,"Natural desert duplicated existing BonePile")
        scrNTTEFullCavesFixtureCleanup(_state.baseline)

        var _nest=instance_create(98000,98000,MaggotSpawn),_park=instance_create(0,0,NTTEFullWorldEvent)
        _park.event_name="MaggotPark";random_set_seed(738);_expected=random(100000);random_set_seed(738)
        assert(array_length(scrNTTEFullDesertMaggotNests())==0 && instance_exists(_nest) && random(100000)==_expected,
            "Natural desert MaggotPark exclusion consumed chance or replaced existing nest")
        instance_destroy(_park,false);GameCont.loops=2
        var _choice=scrNTTEFullVanillaFixtureSeed(3,12);random_set_seed(_choice)
        var _new=scrNTTEFullDesertMaggotNests()
        assert(array_length(_new)==1 && !instance_exists(_nest) && _new[0].object_index==NTTEFullBigMaggotSpawn
            && _new[0].xstart==98000 && _new[0].ystart==98000 && abs(_new[0].max_hp-42*(1+GameCont.loops/20))<=0.00001
            && instance_number(NTTEFullFlySpin)==3 && instance_number(Maggot)>=3,
            "Natural desert loop-weighted nest failed genuine42HP/maggot/fly resident constructor")
    }
    finally { scrNTTEFullVanillaFixtureEnd(_state) }
    scrNTTESmokeLog("NATURAL DESERT: unrelated RNG gate, exact normal eligible floors, all prop exclusions, Oasis blocker, old skull removal/default real donation skull, ScorpionCity suppression, native BonePile/ScorpionRock, MaggotPark RNG gate and genuine loop-weighted large nest residents OK")
}
function scrNTTEFullScrapyardLevelNativeTests() {
    var _state=scrNTTEFullVanillaFixtureBegin();GameCont.area=area_scrapyards
    try {
        var _floor=instance_create(98000,98000,Floor),_bandit=instance_create(98016,98016,Bandit)
        GameCont.subarea=3;random_set_seed(928);var _expected=random(100000);random_set_seed(928)
        assert(array_length(scrNTTEFullScrapyardSaws())==0 && random(100000)==_expected,
            "Natural scrapyard3 consumed excluded saw chance")
        GameCont.subarea=1;var _choice=scrNTTEFullVanillaFixtureSeed(1,40);random_set_seed(_choice)
        var _saws=scrNTTEFullScrapyardSaws()
        assert(array_length(_saws)==1 && _saws[0].object_index==NTTEFullSawTrap && instance_exists(_bandit)
            && _saws[0].xstart==98016 && _saws[0].ystart==98016,
            "Natural scrapyard1/40 saw failed nearest exact Floor bbox center or replaced source enemy")
        scrNTTEFullCavesFixtureCleanup(_state.baseline)

        // Source landing pad inherits style/area only from floors older than car.
        var _old=instance_create(97904,98000,Floor);_old.styleb=true;_old.area=area_desert
        var _car=instance_create(98064,98016,CarVenus);_car.x=98064;_car.y=98016
        var _newer=instance_create(98048,98000,Floor);_newer.styleb=false;_newer.area=area_scrapyards
        var _pads=scrNTTEFullScrapyardCarPads()
        assert(array_length(_pads)==1 && array_length(_pads[0])==9 && _car.x==98064 && _car.y==98016,
            "Natural Venus landing pad lost actual3x3 floor fill/car position")
        for(var _i=0;_i<array_length(_pads[0]);++_i)
            assert(_pads[0][_i].styleb && _pads[0][_i].area==area_desert,
                "Natural Venus pad inherited newer or non-normal floor instead of source older floor style/area")
        assert(is_undefined(global.ntte_full_floor_style) && is_undefined(global.ntte_full_floor_area),
            "Natural Venus pad failed source floor_reset_style")
        scrNTTEFullCavesFixtureCleanup(_state.baseline)

        var _old=instance_create(98000,98000,Floor),_car=instance_create(98016,98016,CarVenus),
            _chest=instance_create(98016,98016,chestprop)
        _car.x=98016;_car.y=98016;_chest.mask_index=mskFloor;_chest.x=98000;_chest.y=98000
        _pads=scrNTTEFullScrapyardCarPads()
        assert(_car.x!=98016 || _car.y!=98016,"Natural overlapping Venus car did not relocate into actual1x1 side room")
        assert(is_undefined(global.ntte_full_floor_aw) && is_undefined(global.ntte_full_floor_ah),
            "Natural Venus overlap fix failed source floor_reset_align")
        scrNTTEFullCavesFixtureCleanup(_state.baseline)

        GameCont.subarea=1;random_set_seed(924);_expected=random(100000);random_set_seed(924)
        assert(!instance_exists(scrNTTEFullScrapyardPool()) && random(100000)==_expected,
            "Natural scrapyard pool ran outside second subarea")
        GameCont.subarea=2;instance_create(10336,10000,Floor)
        var _pool=scrNTTEFullScrapyardPool()
        assert(instance_exists(_pool) && _pool.object_index==NTTEFullSludgePool && _pool.num==3 && _pool.setup
            && instance_exists(NTTEFullSludgeDraw) && point_distance(10016,10016,_pool.x,_pool.y)>=96,
            "Natural scrapyard2 lost rounded4x4 side room/real delayed three-raven SludgePool")
        with(_pool) scrNTTEFullSludgePoolSetup()
        var _ravenCount=0
        with(NTTEFullBoneRaven) if(creator==_pool) { _ravenCount++ }
        assert(_ravenCount==3 && array_length(_pool.floors)>0,
            "Natural sludge pool did not execute genuine delayed floor style/three BoneRaven residents")
        scrNTTEFullCavesFixtureCleanup(_state.baseline)

        var _f=instance_create(98000,98000,Floor),_wall=instance_create(98000,98000,Wall)
        _choice=scrNTTEFullVanillaFixtureSeed(1,5);random_set_seed(_choice)
        var _tops=scrNTTEFullScrapyardSpectators()
        assert(array_length(_tops)==1 && _tops[0].object_index==NTTEFullTopObject
            && instance_exists(_tops[0].target) && _tops[0].target.object_index==NTTEFullTopRaven
            && _tops[0].spawn_dir==0 && _tops[0].spawn_dis==0,
            "Natural scrapyard wall spectator lost genuine TopRaven/TopObject/source zero offset contract")
        var _clear=instance_create(98000,98000,PortalClear);_clear.mask_index=mskFloor
        _choice=scrNTTEFullVanillaFixtureSeed(1,5);random_set_seed(_choice)
        assert(array_length(scrNTTEFullScrapyardSpectators())==0,
            "Natural scrapyard spectator ignored portal-clear exclusion")
        scrNTTEFullCavesFixtureCleanup(_state.baseline)

        var _raven=instance_create(98000,98000,Raven)
        GameCont.loops=0;random_set_seed(736);_expected=random(100000);random_set_seed(736)
        assert(array_length(scrNTTEFullScrapyardPelicans())==0 && instance_exists(_raven) && random(100000)==_expected,
            "Preloop scrapyard consumed Pelican RNG or removed Raven")
        GameCont.loops=1;GameCont.subarea=2;_choice=scrNTTEFullVanillaFixtureSeed(2,12);random_set_seed(_choice)
        var _pelicans=scrNTTEFullScrapyardPelicans()
        assert(array_length(_pelicans)==1 && !instance_exists(_raven) && _pelicans[0].object_index==NTTEFullPelican,
            "Natural scrapyard loop2/12 failed genuine Pelican substitution")
    }
    finally { scrNTTEFullVanillaFixtureEnd(_state) }
    scrNTTESmokeLog("NATURAL SCRAPYARD: excluded third-area saw RNG/retained enemy, real saw floor center, older-floor styled Venus3x3 pad/actual overlap room/reset, second-area rounded real sludge/three native BoneRavens, genuine perched Raven/portal exclusion and loop Pelican substitution OK")
}
function scrNTTEFullLabsLevelNativeTests() {
    var _state=scrNTTEFullVanillaFixtureBegin();GameCont.area=area_labs
    try {
        var _freak=instance_create(98000,98000,Freak)
        random_set_seed(873);var _expected=random(100000);random_set_seed(873)
        assert(array_length(scrNTTEFullLabsLoopSpawns())==0 && instance_exists(_freak) && random(100000)==_expected,
            "Preloop labs consumed replacement RNG or replaced Freak")
        instance_destroy(_freak,false);GameCont.loops=1
        var _types=[[Freak,5,BoneFish],[RhinoFreak,3,NTTEBat],[Ratking,5,NTTEBat],[LaserCrystal,4,NTTEFullPortalGuardian]]
        for(var _i=0;_i<array_length(_types);++_i) {
            var _row=_types[_i],_old=instance_create(98000,98000,_row[0]),_choice=scrNTTEFullVanillaFixtureSeed(1,_row[1])
            random_set_seed(_choice);var _new=scrNTTEFullLabsLoopSpawns()
            assert(array_length(_new)==1 && !instance_exists(_old) && _new[0].object_index==_row[2]
                && _new[0].xstart==98000 && _new[0].ystart==98000,
                "Natural loop labs failed source Freak/Rhino/Ratking/LaserCrystal chance or real native replacement")
            scrNTTEFullCavesFixtureCleanup(_state.baseline)
        }
        GameCont.loops=0
        var _near=instance_create(10000,10000,Floor),_choice=scrNTTEFullVanillaFixtureSeed(1,60)
        random_set_seed(_choice);var _chambers=scrNTTEFullLabsChambers()
        assert(array_length(_chambers)==0,"Natural labs chamber violated source128px spawn distance")
        instance_destroy(_near,false)
        var _far=instance_create(10320,10000,Floor),_wall=instance_create(10320,10000,Wall)
        random_set_seed(_choice);_chambers=scrNTTEFullLabsChambers()
        assert(array_length(_chambers)==0,"Natural labs chamber ignored native place_free wall exclusion")
        instance_destroy(_wall,false)
        random_set_seed(_choice);_chambers=scrNTTEFullLabsChambers()
        assert(array_length(_chambers)==1 && _chambers[0].object_index==NTTEFullFreakChamber
            && _chambers[0].x==10336 && _chambers[0].y==10016 && _chambers[0].setup
            && !_chambers[0].open && _chambers[0].alarm0==-1 && _chambers[0].spawnmoment>=0.3 && _chambers[0].spawnmoment<=0.9,
            "Natural labs chamber failed genuine delayed excavation constructor/normal floor center")
        var _chamber=_chambers[0]
        assert(_chamber.type=="Freak" || _chamber.type=="Rhino" || _chamber.type=="Explo" || _chamber.type=="Vat",
            "Natural labs chamber used wrong authored occupant pool")
        scrNTTEFullCavesFixtureCleanup(_state.baseline)
        var _explo=instance_create(10320,10000,FloorExplo)
        random_set_seed(612);_expected=random(100000);random_set_seed(612)
        assert(array_length(scrNTTEFullLabsChambers())==0 && random(100000)==_expected,
            "Natural labs treated FloorExplo as exact FloorNormal or consumed its chance")
    }
    finally { scrNTTEFullVanillaFixtureEnd(_state) }
    scrNTTESmokeLog("NATURAL LABS: preloop RNG gate, actual BoneFish/Bat/PortalGuardian replacements/chances, real delayed FreakChamber occupant pool/state,128px spawn/free-wall/exact-normal-floor exclusions OK")
}

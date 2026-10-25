function scrNTTEFullCrystalHeartLevelFixtureClear() {
    var _hearts=scrNTTEFullInstances(NTTEFullCrystalHeart)
    for(var _i=0;_i<array_length(_hearts);++_i) instance_destroy(_hearts[_i],false)
}
function scrNTTEFullCrystalHeartLevelFixtureSeed(_ordinary,_chaos) {
    for(var _seed=1;_seed<100000;++_seed) {
        random_set_seed(_seed)
        var _a=chance(2,410),_b=chance(1,5)
        if(_a==_ordinary && _b==_chaos) return _seed
    }
    assert(false,"Could not select reproducible source heart fixture seed")
    return 1
}
function scrNTTEFullCrystalHeartLevelNativeTests() {
    assert(scrNTTESmokeEnabled(),"Natural CrystalHeart fixture requires explicit desktop smoke harness")
    var _before=scrNTTEFullInstances(all),_game=scrNTTEFullAreaGeneratorSnapshot(GameCont),
        _players=scrNTTEFullAreaGeneratorSnapshot(Player),_seed=random_get_seed(),
        _hidden=scrNTTEFullInstances([Floor,Wall,enemy,GenCont,LevCont]),
        _oldGuarantee=scrNTTEFullValue(GameCont,"ntte_heart_spawn"),
        _oldVisit=scrNTTEFullValue(GameCont,"ntte_visits_loop_red",-1),
        _oldTesseract=scrNTTEFullValue(GameCont,"ntte_tesseract_loop",0),
        _active=scrNTTEFullValue(GameCont,"ntte_full_active_coast",false)
    for(var _i=0;_i<array_length(_hidden);++_i) instance_deactivate_object(_hidden[_i])
    GameCont.area=area_sewers;GameCont.subarea=2;GameCont.loops=0;GameCont.hard=2;GameCont.crown=crwn_none
    GameCont.ntte_full_active_coast=false;GameCont.ntte_visits_loop_red=-1;GameCont.ntte_tesseract_loop=0
    with(Player) { x=92760;y=93016 }
    try {
        var _good=instance_create(93000,93000,Floor),_wall=instance_create(93032,93000,Wall),
            _interior=instance_create(93000,93200,Floor),_near=instance_create(92760,93000,Floor),
            _blocked=instance_create(93032,93000,Floor),_broken=instance_create(93000,93032,FloorExplo),
            _enemy=instance_create(93016,93216,Bandit),_floors=scrNTTEFullCrystalHeartLevelFloors()
        assert(array_length(_floors)==1 && _floors[0]==_good,
            "Natural heart tiles lost actual FloorNormal/noWall/>128Player/<34Wall edge gates; floors="+string(_floors))
        var _noneSeed=scrNTTEFullCrystalHeartLevelFixtureSeed(false,false),
            _ordinarySeed=scrNTTEFullCrystalHeartLevelFixtureSeed(true,false),
            _chaosSeed=scrNTTEFullCrystalHeartLevelFixtureSeed(false,true)
        // No probability draws outside normal levels.
        GameCont.hard=1;GameCont.ntte_heart_spawn={area:area_sewers,subarea:2,loops:0}
        random_set_seed(_ordinarySeed);var _expected=random(100000)
        random_set_seed(_ordinarySeed)
        assert(!array_length(scrNTTEFullCrystalHeartLevelStart()) && random(100000)==_expected
            && is_struct(GameCont.ntte_heart_spawn),"Non-normal heart gate consumed RNG/guarantee or spawned")
        GameCont.hard=2;instance_destroy(_enemy,false)
        var _horror=instance_create(93016,93216,HostileHorror)
        assert(instance_number(enemy)==instance_number(HostileHorror)
            && !array_length(scrNTTEFullCrystalHeartLevelStart()) && is_struct(GameCont.ntte_heart_spawn),
            "Horror-only level incorrectly qualified as a source normal area")
        instance_destroy(_horror,false);_enemy=instance_create(93016,93216,Bandit)

        // An earlier setpiece can add an enemy after the source snapshot.
        // False must stay false and preserve both chance draws and guarantee.
        random_set_seed(_ordinarySeed);_expected=random(100000);random_set_seed(_ordinarySeed)
        assert(!array_length(scrNTTEFullCrystalHeartLevelStart(false)) && random(100000)==_expected
            && is_struct(GameCont.ntte_heart_spawn),"Frozen non-normal snapshot was replaced by current early enemy count")
        // Conversely, later removal of the last enemy cannot revoke a true
        // snapshot. The guarantee is a deterministic actual heart constructor.
        instance_destroy(_enemy,false);random_set_seed(_noneSeed)
        var _snapshotHearts=scrNTTEFullCrystalHeartLevelStart(true)
        assert(array_length(_snapshotHearts)==1 && is_undefined(GameCont.ntte_heart_spawn),
            "Frozen normal snapshot was revoked by early enemy removal")
        scrNTTEFullCrystalHeartLevelFixtureClear();_enemy=instance_create(93016,93216,Bandit)

        random_set_seed(_noneSeed)
        GameCont.ntte_heart_spawn={area:area_sewers,subarea:2,loops:0}
        var _spawned=scrNTTEFullCrystalHeartLevelStart(),_heart=_spawned[0]
        assert(array_length(_spawned)==1 && instance_is(_heart,enemy) && !_heart.white && !_heart.tesseract
            && _heart.area==scrNTTEFullAreaId("red") && _heart.hp==50
            && _heart.x==(_good.bbox_left+_good.bbox_right)/2 && _heart.y==(_good.bbox_top+_good.bbox_bottom)/2+2
            && is_undefined(GameCont.ntte_heart_spawn),
            "Natural matching guarantee failed genuine CrystalHeart/default red warp/50HP/center+2 or consumption")
        scrNTTEFullCrystalHeartLevelFixtureClear()
        random_set_seed(_noneSeed);GameCont.ntte_heart_spawn={area:area_labs,subarea:2,loops:0}
        assert(!array_length(scrNTTEFullCrystalHeartLevelStart()) && is_struct(GameCont.ntte_heart_spawn),
            "Wrong area consumed source natural guarantee")
        random_set_seed(_noneSeed);GameCont.ntte_heart_spawn={area:area_sewers,subarea:3,loops:0}
        assert(!array_length(scrNTTEFullCrystalHeartLevelStart()),"Wrong subarea spawned source guaranteed heart")
        random_set_seed(_noneSeed);GameCont.ntte_heart_spawn={area:area_sewers,subarea:2,loops:1}
        assert(!array_length(scrNTTEFullCrystalHeartLevelStart()),"Wrong loop spawned source guaranteed heart")

        // Original consumes a still-mismatched guarantee on random success,
        // before candidate selection, including a level with no eligible tile.
        instance_deactivate_object(_good);random_set_seed(_ordinarySeed)
        GameCont.ntte_heart_spawn={area:area_labs,subarea:2,loops:0}
        assert(!array_length(scrNTTEFullCrystalHeartLevelStart()) && is_undefined(GameCont.ntte_heart_spawn),
            "Source random success without floors did not consume mismatched guarantee before spawn search")
        instance_activate_object(_good)
        GameCont.area=area_hq;GameCont.ntte_heart_spawn=undefined;random_set_seed(_ordinarySeed)
        assert(!array_length(scrNTTEFullCrystalHeartLevelStart()),"Source HQ exclusion lost random ordinary-heart gate")
        GameCont.ntte_heart_spawn={};random_set_seed(_noneSeed)
        _spawned=scrNTTEFullCrystalHeartLevelStart()
        assert(array_length(_spawned)==1,"HQ must retain source guaranteed-heart path/default matching keys")
        scrNTTEFullCrystalHeartLevelFixtureClear()

        GameCont.area=area_sewers;GameCont.subarea=1;GameCont.loops=1;GameCont.crown=NTTEFullCrown.Red
        GameCont.ntte_heart_spawn={area:area_sewers,subarea:1,loops:1};random_set_seed(_chaosSeed)
        _spawned=scrNTTEFullCrystalHeartLevelStart()
        var _regular=0,_chaos=0,_tesseract=0
        for(var _i=0;_i<array_length(_spawned);++_i) {
            _heart=_spawned[_i];_tesseract+=_heart.tesseract
            if(_heart.white) {
                _chaos+=1
                assert(is_undefined(_heart.area) && _heart.sprite_index==scrNTTERefSprite("ChaosHeartIdle")
                    && _heart.spr_dead==scrNTTERefSprite("ChaosHeartDead") && _heart.hitid[1]=="CHAOS HEART",
                    "Genuine ChaosHeart variant lost source visuals/no warp/white flag")
            }
            else _regular+=1
            assert(_heart.x==(_good.bbox_left+_good.bbox_right)/2 && _heart.y==(_good.bbox_top+_good.bbox_bottom)/2+2,
                "Simultaneous source hearts did not sample candidate floors with replacement")
        }
        assert(_regular==1 && _chaos==2 && _tesseract==1 && GameCont.ntte_tesseract_loop==1,
            "Source Red crown first-subarea+1/5 hearts/ordinary guarantee/exactly one Tesseract-per-loop diverged")
        scrNTTEFullCrystalHeartLevelFixtureClear()
        GameCont.crown=crwn_none;GameCont.subarea=2
        GameCont.ntte_heart_spawn={};random_set_seed(_noneSeed);_spawned=scrNTTEFullCrystalHeartLevelStart()
        assert(array_length(_spawned)==1 && !_spawned[0].tesseract,
            "Natural ordinary heart repeated Tesseract within the same loop")
        scrNTTEFullCrystalHeartLevelFixtureClear()
        GameCont.ntte_visits_loop_red=1;GameCont.ntte_heart_spawn={};random_set_seed(_noneSeed)
        _spawned=scrNTTEFullCrystalHeartLevelStart()
        assert(array_length(_spawned)==1 && _spawned[0].white && is_undefined(_spawned[0].area),
            "Same-loop Red visit failed source forced Chaos replacement of ordinary heart")
        scrNTTEFullCrystalHeartLevelFixtureClear()
        GameCont.ntte_visits_loop_red=-1;GameCont.area=scrNTTEFullAreaId("red")
        GameCont.ntte_heart_spawn={};random_set_seed(_noneSeed);_spawned=scrNTTEFullCrystalHeartLevelStart()
        assert(array_length(_spawned)==1 && _spawned[0].white,"Red level failed source unconditional Chaos replacement")
        // The source permits wall-free layouts; it does not require an edge
        // when no Wall exists anywhere in the generated level.
        // Genuine FloorExplo.Create above spawns surrounding native Walls.
        // Explicitly remove the entire fixture wall set for the wall-free
        // branch, rather than only our one hand-placed edge Wall.
        instance_destroy(Wall,false);_floors=scrNTTEFullCrystalHeartLevelFloors()
        scrNTTESmokeLog("CRYSTAL HEART WALL-FREE DIAG "+json_stringify({floors:_floors,good:_good,interior:_interior,
            broken:_broken,near:_near,wallCount:instance_number(Wall),playerX:instance_find(Player,0).x,playerY:instance_find(Player,0).y,
            goodExists:instance_exists(_good),interiorExists:instance_exists(_interior),nearExists:instance_exists(_near),
            goodIndex:array_get_index(_floors,_good),interiorIndex:array_get_index(_floors,_interior),
            brokenIndex:array_get_index(_floors,_broken),nearIndex:array_get_index(_floors,_near)}))
        assert(array_get_index(_floors,_good)>=0 && array_get_index(_floors,_interior)>=0
            && array_get_index(_floors,_broken)<0 && array_get_index(_floors,_near)<0,
            "Wall-free natural hearts lost source interior-floor permission/normal-tile/player gate")
    }
    finally {
        var _all=scrNTTEFullInstances(all)
        for(var _i=array_length(_all)-1;_i>=0;--_i)
            if(array_get_index(_before,_all[_i])<0 && instance_exists(_all[_i])) instance_destroy(_all[_i],false)
        for(var _i=0;_i<array_length(_hidden);++_i) instance_activate_object(_hidden[_i])
        scrNTTEFullAreaGeneratorRestore(_game);scrNTTEFullAreaGeneratorRestore(_players)
        GameCont.ntte_heart_spawn=_oldGuarantee;GameCont.ntte_visits_loop_red=_oldVisit
        GameCont.ntte_tesseract_loop=_oldTesseract;GameCont.ntte_full_active_coast=_active
        random_set_seed(_seed)
    }
    scrNTTESmokeLog("FULL CRYSTAL HEART NATURAL LEVEL: genuine enemies/normal-only+Horror gate, exact FloorNormal distance/Wall candidates, current RNG, guarantee matching/defaults+pre-floor consumption, HQ random exclusion, Chaos variants/Red crown 2+1 with replacement, Red-visit replacement and once-per-loop Tesseract OK @"+string(30/timescale))
}

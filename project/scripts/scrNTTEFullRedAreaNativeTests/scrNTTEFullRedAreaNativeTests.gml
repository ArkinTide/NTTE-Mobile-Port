// Actual room and lifecycle prerequisites; no natural generator registration.
function scrNTTEFullRedAreaNativeTests() {
    var _before=scrNTTEFullInstances(all),_game=scrNTTEFullAreaGeneratorSnapshot(GameCont),
        _players=scrNTTEFullAreaGeneratorSnapshot(Player),_back=scrNTTEFullAreaGeneratorSnapshot(BackCont),
        _top=scrNTTEFullAreaGeneratorSnapshot(TopCont),_uber=scrNTTEFullAreaGeneratorSnapshot(UberCont),
        _seed=random_get_seed(),_tick=current_frame,_source_state=scrNTTEFullSourceSeedState(),
        _parked=scrNTTEFullInstances([Floor,FloorMaker,Wall,TopSmall,Bones,enemy,chestprop,RadChest,
            NOWALLSHEREPLEASE,NTTEFullWarp,NTTEFullWarpPortal,NTTEFullPet]),
        _view_x=view_xview,_view_y=view_yview,_progress_graph={nodes:[]}
    scrNTTEFullAreaSnapshotContainer(global.ntte_full_progress,_progress_graph)
    var _progress={instances:[],containers:_progress_graph.nodes}
    scrNTTEFullFloorInit()
    var _style=global.ntte_full_floor_style,_floor_area=global.ntte_full_floor_area,
        _aw=global.ntte_full_floor_aw,_ah=global.ntte_full_floor_ah,_ax=global.ntte_full_floor_ax,_ay=global.ntte_full_floor_ay
    GameCont.ntte_full_source_seed=scrNTTEFullSourceSeedCopy(_source_state)
    for(var _i=0;_i<array_length(_parked);++_i) instance_deactivate_object(_parked[_i])
    try {
        GameCont.area=206;GameCont.subarea=2;GameCont.loops=0;GameCont.gocrib=false;GameCont.crown=0
        UberCont.opt_prtcls=true
        scrNTTEFullFloorResetStyle();scrNTTEFullFloorResetAlign()
        with(Player) {x=10016;y=10016;visible=true}
        // Pre-unlock the skin only in this restored memory graph: the actual
        // RoomEnd can verify the achievement without touching the user's file.
        variable_struct_set(global.ntte_full_progress.unlocks,"skin:red crystal",true)
        variable_struct_set(global.ntte_full_progress.unlocks,"quest:part:3",false)
        GameCont.ntte_quest_spawned_part_index_list=[]
        var _tile=instance_create(98000,98000,Floor),_seeds=[1,4458,4449],
            _objects=[NTTEFullCrystalBrain,Bandit,NTTEFullRedSpider]
        for(var _i=0;_i<3;++_i) {
            scrNTTEFullSourceRandomSeed(_seeds[_i])
            var _count=instance_number(_objects[_i])
            with(_tile) assert(scrNTTEFullAreaPopEnemies(206),"Actual native population omitted Red callback")
            assert(instance_number(_objects[_i])==_count+1,"Red actual native per-floor weighted enemy branch changed")
        }
        GameCont.subarea=3
        var _count=instance_number(enemy)
        with(_tile) scrNTTEFullAreaPopEnemies(206)
        assert(instance_number(enemy)==_count,"Red boss subarea3 must suppress ordinary per-floor enemies")
        instance_destroy(_tile,false)
        // Establish a real32px-level spine, then use the actual shared room
        // helpers. The corridor's stop array was captured BEFORE room creation.
        for(var _i=-5;_i<=5;++_i) instance_create(10000+32*_i,10000,Floor)
        var _old_floors=scrNTTEFullRedNormalFloors()
        GameCont.subarea=2;scrNTTEFullSourceRandomSeed(1451)
        var _warp_count=instance_number(NTTEFullWarp),_room=scrNTTEFullRedWarpRoom()
        assert(is_struct(_room) && array_length(_room.floors)==4 && instance_number(NTTEFullWarp)==_warp_count+1,
            "Red actual2x2 Warp room omitted four genuine floor tiles/interactive native Warp")
        for(var _i=0;_i<4;++_i) {
            var _f=_room.floors[_i]
            assert(instance_exists(_f) && _f.styleb==1 && _f.sprite_index==scrNTTERefSprite("FloorRedRoom") && _f.image_index==_i,
                "Red actual Warp-room tile lost original style/depth/image order")
        }
        var _warp=instance_find(NTTEFullWarp,0)
        assert(_warp.x==_room.x && _warp.y==_room.y-4 && is_undefined(global.ntte_full_floor_style)
            && is_undefined(global.ntte_full_floor_aw),"Red room lost Warp offset or leaked floor style/alignment")
        var _added=0,_now=scrNTTEFullRedNormalFloors()
        for(var _i=0;_i<array_length(_now);++_i) if(array_get_index(_old_floors,_now[_i])<0 && array_get_index(_room.floors,_now[_i])<0) {_added+=1}
        assert(_added>0,"Red hallway stopped on newly created room floors instead of the captured level floors")
        // Real secret room owns its fake-wall corridor, source Quest side room
        // and neutral Twins pet; only new tops are hidden by instance threshold.
        GameCont.subarea=1;scrNTTEFullSourceRandomSeed(1351)
        var _fake=instance_number(NTTEFullWallFake),_pets=instance_number(NTTEFullPet),_secret=scrNTTEFullRedSecretRoom()
        assert(is_struct(_secret) && array_length(_secret.floors)==9 && instance_number(NTTEFullWallFake)>_fake
            && instance_number(NTTEFullPet)==_pets+1 && array_get_index(GameCont.ntte_quest_spawned_part_index_list,3)>=0,
            "Red actual3x3 secret room lost real fake walls/Quest part3/Twins")
        var _twins=noone
        with(NTTEFullPet) if(pet=="Twins") _twins=id
        assert(instance_exists(_twins) && _twins.x==_secret.x && _twins.y==_secret.y,
            "Red secret room did not place actual neutral Twins at the source center")
        var _bosses=instance_number(NTTEFullTesseract)
        UberCont.opt_bossintro=false;GameCont.subarea=3
        var _boss_room=scrNTTEFullRedBossRoom()
        assert(is_struct(_boss_room) && array_length(_boss_room.floors)==16 && instance_number(NTTEFullTesseract)==_bosses+1,
            "Red explicit subarea3 lost actual4x4 Tesseract room/boss")
        // Actual environment Alarm0 respects source logical timer and original
        // normal Red floor filtering. Epsilon has one shared native camera.
        view_xview=9900;view_yview=9900;with(Player) visible=true
        var _spark_count=instance_number(LaserCharge)
        with(BackCont) event_perform(ev_alarm,0)
        assert(instance_number(LaserCharge)==_spark_count+1 && BackCont.alarm[0]*timescale>=1
            && BackCont.alarm[0]*timescale<=40,"Red actual ambient alarm lost spark/source1..40 cadence")
        var _spark=noone
        with(LaserCharge) if(array_get_index(_before,id)<0) _spark=id
        assert(instance_exists(_spark) && _spark.alarm[0]*timescale>=40 && _spark.alarm[0]*timescale<=80
            && _spark.speed<=0.2*timescale && _spark.depth==-8,"Red actual sparkle lost lifetime/speed/depth")
        // First-wall-only spawn cleanup is exercised with the real Start.
        scrNTTEFullRedStart()
        assert(GameCont.ntte_active_red && GameCont.ntte_full_active_red,"Red Start omitted source active fields")
        // Selected Warp destinations must still record every Red completion.
        GameCont.subarea=3;GameCont.loops=2;GameCont.ntte_visits_red=4
        GameCont.ntte_full_pending_destination=undefined;GameCont.can_advance_stage=true
        with(GameCont) event_perform(ev_other,ev_room_end)
        assert(GameCont.area==206 && GameCont.subarea==1 && GameCont.loops==2
            && GameCont.ntte_visits_red==5 && GameCont.ntte_visits_loop_red==2
            && !GameCont.ntte_active_red && !GameCont.ntte_full_active_red,
            "Actual Red RoomEnd omitted self-loop/visits/visit loop/source active transit")
        scrNTTEFullRedStart();GameCont.loops=3;GameCont.can_advance_stage=true
        var _destination=scrNTTEFullAreaSet(area_city,2,4)
        _destination.lastarea=area_city;_destination.lastsubarea=1
        with(GameCont) event_perform(ev_other,ev_room_end)
        assert(GameCont.area==area_city && GameCont.subarea==2 && GameCont.loops==4
            && GameCont.ntte_visits_red==6 && GameCont.ntte_visits_loop_red==3
            && GameCont.lastarea==area_city && GameCont.lastsubarea==1,
            "Actual selected Warp RoomEnd skipped source Red visits or replaced destination/return fields")
    }
    finally {
        scrNTTEFullMergedRuntimeTestCleanup(_before)
        for(var _i=0;_i<array_length(_parked);++_i) instance_activate_object(_parked[_i])
        scrNTTEFullAreaGeneratorRestore(_game);scrNTTEFullAreaGeneratorRestore(_players)
        scrNTTEFullAreaGeneratorRestore(_back);scrNTTEFullAreaGeneratorRestore(_top);scrNTTEFullAreaGeneratorRestore(_uber)
        scrNTTEFullAreaGeneratorRestore(_progress)
        GameCont.ntte_full_source_seed=_source_state
        global.ntte_full_floor_style=_style;global.ntte_full_floor_area=_floor_area
        global.ntte_full_floor_aw=_aw;global.ntte_full_floor_ah=_ah;global.ntte_full_floor_ax=_ax;global.ntte_full_floor_ay=_ay
        view_xview=_view_x;view_yview=_view_y;random_set_seed(_seed);current_frame=_tick
    }
    scrNTTESmokeLog("FULL RED AREA: actual native population weights/boss3 exclusion/2x2 Warp+captured-floor corridor/style restore/3x3 secret+Quest part3+fake walls+Twins/4x4 Tesseract/actual ambient alarm/spark/Start/actual self-loop+selected-Warp RoomEnd/visits+visit loop/transit OK @"+string(30/timescale))
}

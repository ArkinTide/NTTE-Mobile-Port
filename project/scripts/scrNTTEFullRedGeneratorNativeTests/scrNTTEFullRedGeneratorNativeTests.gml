function scrNTTEFullRedGeneratorNativeTests() {
    var _before=scrNTTEFullInstances(all),_game=scrNTTEFullAreaGeneratorSnapshot(GameCont),
        _players=scrNTTEFullAreaGeneratorSnapshot(Player),_back=scrNTTEFullAreaGeneratorSnapshot(BackCont),
        _uber=scrNTTEFullAreaGeneratorSnapshot(UberCont),_mus=scrNTTEFullAreaGeneratorSnapshot(MusCont),
        _source=scrNTTEFullSourceSeedState(),_seed=random_get_seed(),
        _sync=variable_global_exists("ntte_full_sync_generation")?global.ntte_full_sync_generation:false,
        _tutorial=save_get_value("game","tutorial",true),_tick=current_frame,
        _vx=view_xview,_vy=view_yview,
        _context=variable_global_exists("ntte_full_heart_generation_context")?global.ntte_full_heart_generation_context:undefined,
        _parked=scrNTTEFullInstances([Floor,FloorMaker,Wall,InvisiWall,TopSmall,TopPot,Bones,enemy,chestprop,RadChest,
            NOWALLSHEREPLEASE,NTTEFullWarp,NTTEFullWarpPortal,NTTEFullPet,TopCont,SubTopCont,GenCont,
            NTTEFullWallFakeController,NTTEFullWallFakeHelper,NTTEFullWallFakeDrawBot,NTTEFullWallFakeDrawTop,
            NTTEFullWallFakeRevealBot,NTTEFullWallFakeRevealTop,NTTEFullRedWallShine]),
        _bg=__background_get_colour_element(),_bgcolor=layer_background_get_blend(_bg[0]),_progress_graph={nodes:[]}
    scrNTTEFullAreaSnapshotContainer(global.ntte_full_progress,_progress_graph)
    var _progress={instances:[],containers:_progress_graph.nodes}
    scrNTTEFullFloorInit()
    var _style=global.ntte_full_floor_style,_floor_area=global.ntte_full_floor_area,
        _aw=global.ntte_full_floor_aw,_ah=global.ntte_full_floor_ah,_ax=global.ntte_full_floor_ax,_ay=global.ntte_full_floor_ay
    GameCont.ntte_full_source_seed=scrNTTEFullSourceSeedCopy(_source)
    for(var _i=0;_i<array_length(_parked);++_i) instance_deactivate_object(_parked[_i])
    try {
        save_set_value("game","tutorial",false);GameCont.area=206;GameCont.subarea=2;GameCont.loops=0
        GameCont.hard=1;GameCont.crown=Crown.None;GameCont.gocrib=false;GameCont.noradch=0
        GameCont.maxsubarea=1;GameCont.finalsubarea=false;UberCont.opt_bossintro=false
        variable_struct_set(global.ntte_full_progress.unlocks,"skin:red crystal",true)
        variable_struct_set(global.ntte_full_progress.unlocks,"quest:part:3",false)
        scrNTTEFullFloorResetStyle();scrNTTEFullFloorResetAlign();scrNTTEFullAreaNativeInit()
        // Obtain an actual native GenCont/Maker without invoking the normal
        // asynchronous driver, then call the real source make-floor itself.
        global.ntte_full_sync_generation=true
        var _gen=instance_create(0,0,GenCont)
        _gen.safedist=120
        instance_destroy(FloorMaker,false);instance_destroy(Floor,false)
        var _maker=instance_create(140000,140000,FloorMaker),_start=instance_nearest(140000,140000,Floor)
        _maker.styleb=1;_start.styleb=1;_maker.x=140032;_maker.direction=0
        scrNTTEFullSourceRandomSeed(12345)
        var _expected=scrNTTEFullSourceSeedCopy(scrNTTEFullSourceSeedState())
        scrNTTEFullSourceRandom(7,_expected);scrNTTEFullSourceRandom(7,_expected)
        with(_maker) scrNTTEFullRedMakeFloor()
        assert(instance_number(Floor)==2 && instance_nearest(140000,140000,Floor).styleb==0 && _maker.styleb==0
            && _maker.direction==0 && !instance_exists(WeaponChest) && !instance_exists(AmmoChest)
            && scrNTTEFullSourceSeedState().random==_expected.random && _gen.safedist==120,
            "Red MakeFloor lost B-start replacement/local0 dead chest branch/RNG order/static safedist")
        instance_destroy(Floor,false);_maker.x=160032;_maker.y=160000;_maker.xstart=160000;_maker.ystart=160000
        _maker.direction=0;scrNTTEFullSourceRandomSeed(1)
        with(_maker) scrNTTEFullRedMakeFloor()
        assert(instance_number(Floor)==5 && position_meeting(160032,159968,Floor)
            && position_meeting(160000,160000,Floor) && position_meeting(160064,160000,Floor)
            && position_meeting(160032,160032,Floor) && _maker.direction==270,
            "Red source3x3 round diamond/center plus4arms/original final turn order changed")
        // safedist0 is used only by the actual Heart setup, not a countdown.
        _gen.safedist=0;_maker.x=160000;_maker.y=159968;_maker.direction=90;_maker.direction_start=0
        scrNTTEFullSourceRandomSeed(12345)
        with(_maker) scrNTTEFullRedMakeFloor()
        assert(_maker.x==160000 && _maker.y==160000 && _maker.direction==0
            && position_meeting(160000,159968,Floor),
            "Red source cone correction lost saved start heading/one step back or moved already-created tile")
        _gen.goal=0;_maker.x=170096;_maker.y=170000;_maker.styleb=1
        with(_gen) scrNTTEFullRedBuildNative()
        var _ending_chest=instance_nearest(170112,170016,RadChest),_ending_floor=instance_nearest(170096,170000,Floor)
        assert(!instance_exists(FloorMaker) && instance_exists(_ending_chest)
            && _ending_chest.x==170112 && _ending_chest.y==170016 && _ending_floor.x==170096
            && _ending_floor.y==170000 && _ending_floor.styleb==1,
            "Actual Red builder failed retained maker/over-goal final tile and RadChest before native chest population")
        scrNTTEFullMergedRuntimeTestCleanup(_before)
        // Actual normal GenCont Create/Alarm2/Alarm0/Alarm1/Destroy chain,
        // with no fixture builder callback or synchronous bridge involved.
        global.ntte_full_sync_generation=false;GameCont.subarea=1;GameCont.finalsubarea=true
        GameCont.ntte_quest_spawned_part_index_list=[]
        scrNTTEFullSourceRandomSeed(1351)
        _gen=instance_create(0,0,GenCont)
        assert(instance_exists(_gen) && !_gen.ntte_full_sync_generation && _gen.goal==60 && _gen.safedist==120
            && !instance_exists(FloorMaker) && instance_number(Floor)>60,
            "Actual Red GenCont Create did not use complete60goal/static120safedist/native builder")
        with(_gen) event_perform(ev_alarm,2)
        with(_gen) event_perform(ev_alarm,0)
        var _twins=noone
        with(NTTEFullPet) if(pet=="Twins") _twins=id
        assert(instance_number(enemy)>0 && instance_exists(NTTEFullWarp) && instance_exists(_twins)
            && instance_exists(NTTEFullWallFake) && instance_number(TopSmall)>0
            && array_get_index(GameCont.ntte_quest_spawned_part_index_list,3)>=0,
            "Actual Red population missed enemies/guaranteed Warp/secret fake hallway/Twins/Quest3/native tops")
        with(_gen) event_perform(ev_alarm,1)
        assert(!instance_exists(_gen) && GameCont.ntte_full_active_red && GameCont.ntte_active_red
            && !TopCont.darkness && BackCont.shadow_color==make_color_rgb(16,0,24)
            && instance_number(TopCont)==1 && instance_number(SubTopCont)==1,
            "Actual Red native finalization lost active flags/source light/shadow or duplicated HUD")
        scrNTTEFullMergedRuntimeTestCleanup(_before)
        GameCont.subarea=3;GameCont.finalsubarea=false;scrNTTEFullSourceRandomSeed(1451)
        _gen=instance_create(0,0,GenCont)
        with(_gen) event_perform(ev_alarm,2)
        with(_gen) event_perform(ev_alarm,0)
        assert(instance_number(NTTEFullTesseract)==1 && !instance_exists(NTTEFullWarp)
            && !instance_exists(NTTEFullRedSpider) && !instance_exists(NTTEFullCrystalBrain),
            "Actual explicit Red3 population lost4x4 Tesseract arena or added ordinary Red enemies/Warps")
        with(_gen) event_perform(ev_alarm,1)
        assert(!instance_exists(_gen) && GameCont.ntte_full_active_red,"Actual Red3 finalization never called source Start")
        scrNTTEFullMergedRuntimeTestCleanup(_before)
        // Real Heart setup's0goal/heading/safedist must survive the shared
        // synchronous driver. The positional probe makes re-creation visible:
        // immediate termination must emit a style1 final tile96px east. Native
        // scrPopChests subsequently deletes/replaces pre-population chests.
        GameCont.area=area_desert;GameCont.subarea=1
        var _old_area=GameCont.area,_px=Player.x,_py=Player.y
        global.ntte_full_heart_generation_context={goal:0,angle:90,seed:1351}
        var _probe=function() {
            scrNTTEFullCrystalHeartAreaSetup()
            assert(goal==0 && safedist==0 && FloorMaker.direction==90 && FloorMaker.goal==0,
                "Actual Heart setup did not edit real source GenCont/Maker fields")
            with(FloorMaker) {x+=96;styleb=1}
        }
        scrNTTEFullAreaGenerateNative(206,2,0,200016,200016,false,0,_probe)
        var _tile=instance_nearest(200096,200000,Floor)
        scrNTTESmokeLog("RED GENERATOR SYNC DIAGNOSTIC tile="+string(_tile)
            +" xy="+(instance_exists(_tile)?string(_tile.x)+","+string(_tile.y):"missing")
            +" style="+(instance_exists(_tile)?string(_tile.styleb):"missing")
            +" area="+string(GameCont.area)+"/"+string(_old_area)
            +" player="+string(Player.x)+","+string(Player.y)+"/"+string(_px)+","+string(_py)
            +" generators="+string(instance_number(GenCont))+","+string(instance_number(FloorMaker)))
        assert(instance_exists(_tile) && _tile.x==200096 && _tile.y==200000 && _tile.styleb==1,
            "Synchronous actual Red builder discarded Heart setup maker identity/goal/style")
        assert(GameCont.area==_old_area,"Synchronous actual Red generation leaked setArea=false destination")
        assert(Player.x==_px && Player.y==_py,"Synchronous actual Red generation failed actual player restoration")
        assert(!instance_exists(GenCont) && !instance_exists(FloorMaker),"Synchronous actual Red generation retained generators")
    }
    finally {
        scrNTTEFullMergedRuntimeTestCleanup(_before)
        for(var _i=0;_i<array_length(_parked);++_i) instance_activate_object(_parked[_i])
        scrNTTEFullAreaGeneratorRestore(_game);scrNTTEFullAreaGeneratorRestore(_players)
        scrNTTEFullAreaGeneratorRestore(_back);scrNTTEFullAreaGeneratorRestore(_uber);scrNTTEFullAreaGeneratorRestore(_mus)
        scrNTTEFullAreaGeneratorRestore(_progress)
        GameCont.ntte_full_source_seed=_source;global.ntte_full_sync_generation=_sync
        global.ntte_full_heart_generation_context=_context
        save_set_value("game","tutorial",_tutorial);random_set_seed(_seed);current_frame=_tick
        layer_background_blend(_bg[0],_bgcolor);view_xview=_vx;view_yview=_vy
        global.ntte_full_floor_style=_style;global.ntte_full_floor_area=_floor_area
        global.ntte_full_floor_aw=_aw;global.ntte_full_floor_ah=_ah;global.ntte_full_floor_ax=_ax;global.ntte_full_floor_ay=_ay
    }
    scrNTTESmokeLog("FULL RED GENERATOR: actual MakeFloor/local-zero/RNG/B-start/round diamond/static safedist/cone-backstep; actual normal GenCont60floor+population+Start/Warps/secret/Twins/Quest3; actual Red3/Tesseract; synchronous actual Heart setup/maker identity+goal+style retention/player-destination restore OK @"+string(30/timescale))
}

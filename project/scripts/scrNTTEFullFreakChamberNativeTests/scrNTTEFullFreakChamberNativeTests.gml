function scrNTTEFullFreakChamberNativeTests() {
    var _before=scrNTTEFullInstances(all),_terrain=scrNTTEFullInstances([Floor,Wall,TopSmall,SnowFloor]),
        _game=scrNTTEFullAreaGeneratorSnapshot(GameCont),_players=scrNTTEFullAreaGeneratorSnapshot(Player),
        _progress=global.ntte_full_progress,_seed=random_get_seed(),_p=instance_find(Player,0)
    global.ntte_full_progress=json_parse(json_stringify(_progress))
    for(var _i=0;_i<array_length(_terrain);++_i) instance_deactivate_object(_terrain[_i])
    GameCont.area=area_hq;GameCont.crown=0;GameCont.loops=2;GameCont.ntte_quest_spawned_part_index_list=[]
    global.ntte_full_progress.unlocks[$ "quest:part:2"]=false
    try {
        var _types=["Freak","Explo","Rhino","Vat","Popo"],_objects=[Freak,ExploFreak,RhinoFreak,Necromancer,-1]
        for(var _i=0;_i<array_length(_types);++_i) {
            var _c=instance_create(94000+256*_i,94000,NTTEFullFreakChamber)
            _c.type=_types[_i]
            with(_c) scrNTTEFullFreakChamberSetup()
            assert(!_c.setup,"FreakChamber failed to consume real one-time source type setup")
            if(_i<4) assert(_c.object==_objects[_i],"FreakChamber source occupant type substituted")
            switch(_i) {
                case 0: assert(_c.num>=8 && _c.num<=12 && _c.image_xscale==2,"FreakChamber source Freak loop/count/width diverged");break
                case 1: assert(_c.num==2 && _c.image_xscale==1 && _c.image_yscale==1,"FreakChamber Explo loop scaling diverged");break
                case 2: assert(_c.num==2 && _c.image_xscale==2,"FreakChamber Rhino loop scaling diverged");break
                case 3: assert(_c.image_xscale==3 && _c.image_yscale==3 && _c.hallway_size>=1 && _c.hallway_size<=3,"FreakChamber Vat room geometry diverged");break
                case 4: assert(_c.image_xscale==2 && _c.image_yscale==2 && _c.hallway_size==0.5 && !_c.styleb
                    && _c.slide_path[0][0]==45 && _c.slide_path[1][0]==6 && _c.slide_path[3][0]==13,
                    "FreakChamber Popo source room/hall/door sequence diverged");break
            }
            instance_destroy(_c,false)
        }
        GameCont.loops=3
        var _c=instance_create(96000,96000,NTTEFullFreakChamber)
        with(_c) scrNTTEFullFreakChamberSetup()
        assert(_c.object==PopoFreak,"HQ chamber loop3source did not replace ordinary IDPD with real PopoFreak")
        instance_destroy(_c,false);GameCont.loops=0
        // Real HQ3 source setup: exact208px three sides, entry relocation,
        // enemies1/-1 near-only gates and permanent/per-run stolen artifact.
        var _middle=instance_create(98016,98016,FloorMiddle),_hq=scrNTTEFullQuestHQAtMiddle(_middle)
        assert(_hq.entry.object==Player && _hq.entry.alarm0==1 && _hq.entry.open
            && _hq.entry.y==_middle.y+208 && _hq.entry.x==_middle.x
            && _hq.enemy.x==_middle.x+208*_hq.side && _hq.artifact.x==_middle.x-208*_hq.side
            && _hq.enemy.enemies==1 && _hq.enemy.spawnmoment==-1
            && _hq.artifact.enemies==1 && _hq.artifact.spawnmoment==-1 && _hq.artifact.object=="QuestChest",
            "HQ3 source three208px side-chambers/near-only gates/entry or actual stolen artifact provider diverged")
        assert(!scrNTTEFullQuestArtifactAvailable(2),"HQ3 stolen artifact run-spawn gate stayed open")
        var _again=scrNTTEFullQuestHQAtMiddle(_middle)
        assert(_again.artifact.object==-1,"HQ3 source generated duplicate stolen artifact in same run")
        GameCont.ntte_quest_spawned_part_index_list=[];global.ntte_full_progress.unlocks[$ "quest:part:2"]=true
        _again=scrNTTEFullQuestHQAtMiddle(_middle)
        assert(_again.artifact.object==-1,"HQ3 ignored permanent stolen artifact unlock")
        // Prepare actual source terrain, including its solid boundary, then
        // exercise complete chamber excavation + central physical QuestChest.
        // Native FloorSet deliberately adds surrounding walls only when the
        // level already owns a Wall. Deactivated smoke terrain needs one seed.
        instance_create(99500,99500,Wall)
        scrNTTEFullFloorSetAlign(32,32)
        var _base=scrNTTEFullFloorFill(100016,100016,5,5)
        scrNTTEFullFloorResetAlign()
        _p.x=100016;_p.y=100016;_p.visible=true
        var _wallCount=instance_number(Wall),_c=instance_create(100016,100224,NTTEFullFreakChamber),_opened=false
        _c.object="QuestChest";_c.open=true
        with(_c) { scrNTTEFullFreakChamberSetup();_opened=scrNTTEFullFreakChamberOpen() }
        assert(is_struct(_opened) && !instance_exists(_c) && array_length(_opened.floors)==4
            && array_length(_opened.hall)>=1 && array_length(_opened.occupants)==1,
            "Actual HQ chamber source failed real side-room excavation/self-disposal/2x2room occupants")
        scrNTTESmokeLog("CHAMBER DIAG pre-walls="+string(_wallCount)+" saved-walls="+string(array_length(_opened.walls))
            +" saved-tops="+string(array_length(_opened.tops))+" sliders="+string(array_length(_opened.slides))
            +" hall="+string(_opened.hall_x)+","+string(_opened.hall_y)+" dir="+string(_opened.direction))
        var _chest=_opened.occupants[0]
        assert(instance_is(_chest,NTTEFullQuestChest) && scrNTTEFullCrabbonePartIndex(_chest.wep)==2
            && _chest.x==_opened.center_x && _chest.y==_opened.center_y
            && _chest.xstart==_chest.x && _chest.ystart==_chest.y,
            "HQ chamber source did not create centered exact physical stolen artifact chest")
        var _small=noone
        with(FloorMiddle) if(x==_opened.center_x && y==_opened.center_y) _small=id
        assert(instance_exists(_small) && _small.sprite_index==scrNTTERefSprite("FloorMiddleSmall")
            && _small.mask_index==scrNTTERefSprite("msk.FloorMiddleSmall"),
            "HQ source chamber small FloorMiddle art/mask missing")
        assert(array_length(_opened.slides)>0,"HQ source excavation did not restore actual colliding sliding doors")
        for(var _i=0;_i<array_length(_opened.slides);++_i) {
            var _slide=_opened.slides[_i]
            assert(instance_is(_slide,NTTEFullWallSlide) && array_length(_slide.slide_inst)>0
                && instance_is(_slide.slide_inst[0],Wall) && _slide.slide_inst[0].solid,
                "HQ chamber door replaced genuine solid Wall with cosmetic effect")
        }
        var _reveal=instance_find(NTTEFullFloorReveal,0)
        assert(instance_exists(_reveal) && array_length(_reveal.list)>0,"Chamber excavation omitted delayed actual terrain reveal")
        // Actual WallSlide EndStep follows logical26tickpath at30/60/120,
        // consumes zero-time records and copies older tile top/style first.
        var _older=instance_create(104000,104000,Wall),_wall=instance_create(104000,104000,Wall)
        _older.image_blend=c_red;_older.topindex=7
        var _slide=instance_create(104000,104000,NTTEFullWallSlide)
        _slide.slide_inst=[_wall];_slide.slide_path=[[2,0,0],[16,0,1],[0],[8,90,1]]
        with(_slide) event_perform(ev_step,ev_step_end)
        assert(!instance_exists(_older) && _wall.image_blend==c_red && _wall.topindex==7,
            "WallSlide source tile override did not transfer older native wall appearance/dispose overlap")
        repeat(ceil(32/timescale)) if(instance_exists(_slide)) with(_slide) event_perform(ev_step,ev_step_end)
        assert(!instance_exists(_slide) && abs(_wall.x-104016)<=0.01 && abs(_wall.y-103992)<=0.01
            && _wall.depth>=0,"WallSlide source logical16right/8up displacement or final wall geometry changed with frame rate")
    }
    finally {
        var _all=scrNTTEFullInstances(all)
        for(var _i=array_length(_all)-1;_i>=0;--_i) if(array_get_index(_before,_all[_i])<0 && instance_exists(_all[_i])) instance_destroy(_all[_i],false)
        for(var _i=0;_i<array_length(_terrain);++_i) instance_activate_object(_terrain[_i])
        scrNTTEFullAreaGeneratorRestore(_game);scrNTTEFullAreaGeneratorRestore(_players)
        global.ntte_full_progress=_progress;random_set_seed(_seed);scrNTTEFullFloorResetAlign();scrNTTEFullFloorResetStyle()
    }
    scrNTTESmokeLog("FULL FREAK CHAMBER NATIVE: all5source types/loop scaling;HQ3exact208three-chamber/artifact gates;actual room excavation,solid sliding doors,2x2stolen artifact/FloorMiddleSmall,reveal;WallSlide native tile-override/zero-time records/logical16right8up/disposal OK @"+string(30/timescale))
}

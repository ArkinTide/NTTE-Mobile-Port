function scrNTTEFullQuestHubNativeTests() {
    var _before=scrNTTEFullInstances(all),_terrain=scrNTTEFullInstances([Floor,Wall,TopSmall,SnowFloor]),
        _game=scrNTTEFullAreaGeneratorSnapshot(GameCont),_uber=scrNTTEFullAreaGeneratorSnapshot(UberCont),
        _players=scrNTTEFullAreaGeneratorSnapshot(Player),_progress=global.ntte_full_progress,_seed=random_get_seed()
    global.ntte_full_progress=json_parse(json_stringify(_progress))
    for(var _i=0;_i<array_length(_terrain);++_i) instance_deactivate_object(_terrain[_i])
    GameCont.area=area_vault;GameCont.crown=0;GameCont.proto=true;GameCont.ntte_quest_spawned_part_index_list=[]
    global.ntte_full_progress.unlocks[$ "race:beetle"]=false
    for(var _part=0;_part<4;++_part) global.ntte_full_progress.unlocks[$ "quest:part:"+string(_part)]=false
    try {
        scrNTTESmokeLog("QUEST HUB PHASE ancient @"+string(30/timescale))
        instance_create(80000,80000,Floor)
        var _ped=instance_create(80016,80016,CrownPed),_ancient=scrNTTEFullQuestVaultAtPedestal(_ped,80016,80016)
        assert(is_struct(_ancient) && _ancient.mode=="ancient" && array_length(_ancient.room.floors)==4
            && instance_exists(_ancient.chest) && instance_is(_ancient.chest,NTTEFullQuestChest)
            && scrNTTEFullCrabbonePartIndex(_ancient.chest.wep)==0
            && array_get_index(GameCont.ntte_quest_spawned_part_index_list,0)>=0,
            "Natural crown-vault proto branch lost one source2x2Ancient artifact chest/run-spawn gate")
        assert(!scrNTTEFullQuestArtifactAvailable(0),"Ancient artifact source once-per-run gate did not close")
        var _images=[]
        for(var _i=0;_i<array_length(_ancient.room.floors);++_i) {
            var _f=_ancient.room.floors[_i]
            assert(_f.sprite_index==scrNTTERefSprite("VaultFlowerFloorSmall") && _f.depth==7,
                "Ancient artifact acquisition room lost source small flower floor art/depth")
            array_push(_images,_f.image_index)
        }
        array_sort(_images,true)
        assert(_images[0]==0 && _images[3]==3,"Ancient artifact2x2floor image order diverged")
        // Clear only this fixture's first branch before building another level;
        // old terrain stays deactivated, so native path tests remain local.
        var _all=scrNTTEFullInstances(all)
        for(var _i=array_length(_all)-1;_i>=0;--_i) if(array_get_index(_before,_all[_i])<0) instance_destroy(_all[_i],false)
        GameCont.ntte_quest_spawned_part_index_list=[]
        for(var _part=0;_part<4;++_part) global.ntte_full_progress.unlocks[$ "quest:part:"+string(_part)]=true
        // The real vault has reachable ordinary Floors at least96px from its
        // spawn. One lone tile correctly fails source FloorRoomStart's gate.
        var _base=noone
        for(var _tile=0;_tile<5;++_tile) _base=instance_create(82000+32*_tile,82000,Floor)
        _ped=instance_create(82016,82016,CrownPed)
        scrNTTESmokeLog("QUEST HUB PHASE three-room @"+string(30/timescale))
        var _hub=scrNTTEFullQuestVaultAtPedestal(_ped,82016,82016)
        assert(is_struct(_hub) && _hub.mode=="hub" && array_length(_hub.rooms)==3 && array_length(_hub.pads)==6,
            "Crown-vault stored Ancient branch failed source three disjoint rooms/six real paired teleporters")
        var _hall=_hub.rooms[2]
        assert(array_length(_hall.floors)==42 && abs(_hall.x2-_hall.x1-96)<=0.01 && abs(_hall.y2-_hall.y1-448)<=0.01,
            "Quest main source hall lost3x14actual native room dimensions")
        for(var _i=0;_i<array_length(_hub.pads);_i+=2) {
            var _a=_hub.pads[_i],_b=_hub.pads[_i+1]
            assert(instance_is(_a,NTTEFullQuestTeleporterPad) && instance_is(_b,NTTEFullQuestTeleporterPad)
                && instance_exists(_a.target) && instance_exists(_b.target)
                && _a.target.sprite_index==scrNTTERefSprite("QuestTeleporterFloor")
                && _b.target.sprite_index==scrNTTERefSprite("QuestTeleporterFloor")
                && _a.teleport_x==_b.x && _a.teleport_y==_b.y && _b.teleport_x==_a.x && _b.teleport_y==_a.y,
                "Quest hub source pair lost actual floor ownership/art or exact bidirectional destinations")
        }
        assert(array_length(_hub.main.controllers)==4 && array_length(_hub.main.stored)==4
            && instance_is(_hub.main.chest,NTTEFullLockedHugeQuestChest),
            "Quest main room did not restore four real artifact controllers/pickups or genuine locked ultimate chest")
        for(var _part=0;_part<4;++_part) {
            var _c=_hub.main.controllers[_part],_pickup=_hub.main.stored[_part]
            assert(_c.part_index==_part && instance_exists(_c.target) && _c.target.sprite_index==scrNTTERefSprite("QuestFloor")
                && _c.target.image_index==_part && scrNTTEFullCrabbonePartIndex(_pickup.wep)==_part
                && _pickup.x==_c.x && _pickup.y==_c.y
                && array_get_index(GameCont.ntte_quest_spawned_part_index_list,_part)>=0,
                "Quest hub restored wrong physical artifact/lore tile/position/run-spawn source state")
        }
        assert(instance_number(NTTEFullQuestPillar)>=8 && instance_number(NTTEFullQuestTorch)>=6,
            "Quest hall omitted source eight pillars/six torches and closet decoration")
        var _count=instance_number(NTTEFullLockedHugeQuestChest)
        global.ntte_full_progress.unlocks[$ "race:beetle"]=true
        scrNTTESmokeLog("QUEST HUB PHASE reward-suppression @"+string(30/timescale))
        var _room=scrNTTEFullFloorRoomCreate(85000,85000,3,14,"",90,30,224),_finished=scrNTTEFullQuestHubMain(_room)
        assert(_finished.chest==noone && instance_number(NTTEFullLockedHugeQuestChest)==_count,
            "Quest hub did not suppress ultimate locked chest after permanent source Beetle unlock")
    }
    finally {
        var _all=scrNTTEFullInstances(all)
        for(var _i=array_length(_all)-1;_i>=0;--_i) if(array_get_index(_before,_all[_i])<0 && instance_exists(_all[_i])) instance_destroy(_all[_i],false)
        for(var _i=0;_i<array_length(_terrain);++_i) instance_activate_object(_terrain[_i])
        scrNTTEFullAreaGeneratorRestore(_game);scrNTTEFullAreaGeneratorRestore(_uber);scrNTTEFullAreaGeneratorRestore(_players)
        global.ntte_full_progress=_progress;random_set_seed(_seed);scrNTTEFullFloorResetAlign()
    }
    scrNTTESmokeLog("FULL QUEST HUB NATIVE: source proto Ancient2x2/once-per-run branch;else three actual224-disjoint rooms/3x14hall/six real paired teleporter floors, four lore controllers/permanent artifact restoration, pillars/torches, Beetle reward suppression OK @"+string(30/timescale))
}

function scrNTTEFullQuestFloorNativeTests() {
    assert(scrNTTESmokeEnabled(),"Quest persistence fixture requires the explicit desktop smoke harness")
    var _before=scrNTTEFullInstances(all),_players=scrNTTEFullAreaGeneratorSnapshot(Player),
        _game=scrNTTEFullAreaGeneratorSnapshot(GameCont),_keys=scrNTTEFullAreaGeneratorSnapshot(KeyCont),
        _uber=scrNTTEFullAreaGeneratorSnapshot(UberCont),_frame=current_frame,_seed=random_get_seed(),
        _progress=global.ntte_full_progress,_enemies=scrNTTEFullInstances(enemy),_gameDirectory=game_directory,
        _scratch=working_directory+"quest-floor-native-fixture/"
    directory_create(_scratch);game_directory=_scratch
    var _path=_scratch+"quest-floor-native-fixture.json"
    global.ntte_full_progress=json_parse(json_stringify(_progress))
    for(var _i=0;_i<array_length(_enemies);++_i) instance_deactivate_object(_enemies[_i])
    GameCont.area=area_desert;GameCont.crown=0;current_frame=2
    try {
        var _player=instance_find(Player,0)
        _player.x=71016;_player.y=71016;_player.xprevious=_player.x;_player.yprevious=_player.y;_player.speed=0
        _player.visible=true;_player.can_pick=true;_player.curse=0;_player.bcurse=0
        _player.wep=wep_revolver;_player.ntte_state=undefined;_player.bwep=wep_shotgun;_player.bntte_state=undefined
        var _chest=instance_create(71300,71000,NTTEFullQuestChest),_part=scrNTTEFullCrabboneCreateModel(2)
        _chest.wep=_part
        assert(instance_is(_chest,NTTEFullCustomChest) && _chest.sprite_index==scrNTTERefSprite("QuestChest")
            && _chest.spr_dead==scrNTTERefSprite("QuestChestOpen") && _chest.spr_shadow==shd32,
            "QuestChest lost real CustomChest/source art/shadow")
        var _pickups=instance_number(WepPickup)
        with(_chest) scrNTTEFullCustomChestOpen(_player)
        assert(!instance_exists(_chest) && instance_number(WepPickup)==_pickups+1,"QuestChest real open did not emit one WepPickup")
        var _created=scrNTTEFullInstances(WepPickup),_pickup=noone
        for(var _i=0;_i<array_length(_created);++_i) if(array_get_index(_before,_created[_i])<0) _pickup=_created[_i]
        assert(instance_exists(_pickup) && scrNTTEFullWeaponModel(_pickup.wep)==_part
            && _pickup.ntte_state==_part.ntte_native_state && _pickup.ammo,
            "QuestChest copied/lost exact physical artifact/canonical state or source ammo flag")
        instance_destroy(_pickup,false)
        var _floor=instance_create(71000,71000,Floor),_controller=instance_create(71016,71016,NTTEFullQuestFloorCont)
        _controller.target=_floor;_controller.part_index=2
        assert(instance_exists(_controller.prompt) && _controller.prompt.creator==_controller
            && _controller.prompt.mask_index==mskWepPickup && _controller.last_weapon_pickup_num==-1,
            "Quest floor lost real native DROP prompt/source pickup observer initialization")
        assert(scrNTTEFullQuestFloorTouch(_player),"Actual quest target Floor did not exclude source artifact auto-stack")
        var _ordinary=scrNTTEFullCrabboneCreateModel(-1)
        _player.wep=scrNTTEFullWeaponNative(_ordinary);_player.ntte_state=scrNTTEFullWeaponNativeState(_ordinary)
        var _can=false
        with(_controller.prompt) _can=scrNTTEFullQuestFloorPromptMeet(_player)
        assert(!_can,"Ordinary bone was confused with a quest artifact")
        // Traverse the full inactive merged chain, and preserve the entire
        // physical root on drop. This artifact is behind a non-bone stock.
        var _model=scrNTTEFullWeaponMerge({wep:wep_revolver},_part)
        scrNTTEFullWeaponMergeActive(_model,false)
        _player.wep=scrNTTEFullWeaponNative(_model);_player.ntte_state=scrNTTEFullWeaponNativeState(_model)
        with(_controller.prompt) _can=scrNTTEFullQuestFloorPromptMeet(_player)
        assert(_can,"Quest floor ignored artifact behind inactive merged stock")
        _player.curse=1;var _count=instance_number(WepPickup),_held=_player.wep
        with(_controller) _pickup=scrNTTEFullQuestFloorDrop(_player)
        assert(_pickup==noone && instance_number(WepPickup)==_count && _player.wep==_held,
            "Quest floor accepted cursed source artifact or changed held ownership on rejection")
        _player.curse=0
        var _enemy=instance_create(71800,71000,Bandit)
        with(_controller.prompt) _can=scrNTTEFullQuestFloorPromptMeet(_player)
        assert(!_can && !scrNTTEFullQuestFloorTouch(_player),"Quest floor DROP/auto-stack exclusion ignored real live enemy gate")
        instance_destroy(_enemy,false)
        // Shared native pickup input, rather than a custom keyboard path.
        _controller.prompt.depth=-100;KeyCont.press_pick[_player.index]=true
        with(_player) scrNTTEFullPromptPlayerStep()
        assert(_controller.prompt.pick==_player.index,"Quest floor did not receive actual shared native pickup action")
        with(_controller) event_perform(ev_step,ev_step_normal)
        _pickup=instance_find(WepPickup,instance_number(WepPickup)-1)
        assert(instance_exists(_pickup) && scrNTTEFullWeaponModel(_pickup.wep)==_model
            && _pickup.ntte_state==_model.ntte_native_state && _pickup.image_index==1
            && _model.ammo==1 && _model.ammo_wep==wep_none && _model.ntte_native_state.ammo==1
            && _player.wep==wep_shotgun && _player.bwep==wep_none && _player.drawempty==30
            && scrNTTEFullUnlockGet("quest:part:2",false),
            "Quest floor real action lost full physical merged transfer/one ammo/secondary swap/permanent source part state")
        KeyCont.press_pick[_player.index]=false
        assert(scrNTTEFullProgressSave(_path),"Quest source permanent part state did not save")
        global.ntte_full_progress={schema:1,unlocks:{},loadouts:{},stats:{}}
        assert(scrNTTEFullProgressLoad(_path) && scrNTTEFullUnlockGet("quest:part:2",false),
            "Quest source permanent artifact state did not survive real progress save/reload")
        instance_destroy(_pickup,false)
        with(_controller) scrNTTEFullQuestFloorRemember()
        assert(!scrNTTEFullUnlockGet("quest:part:2",true),"Quest floor source pickup observer did not clear removed artifact state")
        // An artifact stack returns its exact previous physical weapon and
        // detaches only the deposited top, without swapping the other slot.
        var _previous=scrNTTEFullCrabboneCreateModel(1),_top=scrNTTEFullCrabboneCreateModel(2,2)
        _top.ammo_wep=_previous;_top.ntte_native_state.ammo_wep=_previous
        _player.wep=scrNTTEFullWeaponNative(_top);_player.ntte_state=scrNTTEFullWeaponNativeState(_top)
        with(_controller) _pickup=scrNTTEFullQuestFloorDrop(_player)
        assert(scrNTTEFullWeaponModel(_player.wep)==_previous && _player.ntte_state==_previous.ntte_native_state
            && scrNTTEFullWeaponModel(_pickup.wep)==_top && _top.ammo==1 && _top.ammo_wep==wep_none,
            "Quest floor stack deposit lost exact previous physical artifact or retained its ammo_wep chain in dropped top")
        instance_destroy(_floor,false)
        with(_controller) event_perform(ev_step,ev_step_normal)
        assert(!instance_exists(_controller),"Quest floor controller outlived its real target Floor")
    }
    finally {
        var _all=scrNTTEFullInstances(all)
        for(var _i=array_length(_all)-1;_i>=0;--_i) if(array_get_index(_before,_all[_i])<0 && instance_exists(_all[_i])) instance_destroy(_all[_i],false)
        for(var _i=0;_i<array_length(_enemies);++_i) instance_activate_object(_enemies[_i])
        scrNTTEFullAreaGeneratorRestore(_players);scrNTTEFullAreaGeneratorRestore(_game)
        scrNTTEFullAreaGeneratorRestore(_keys);scrNTTEFullAreaGeneratorRestore(_uber)
        global.ntte_full_progress=_progress;current_frame=_frame;random_set_seed(_seed)
        var _files=[_path,_path+".bak",_path+".tmp",_scratch+"ntte-full-progress.json",
            _scratch+"ntte-full-progress.json.bak",_scratch+"ntte-full-progress.json.tmp"]
        for(var _i=0;_i<array_length(_files);++_i) if(file_exists(_files[_i])) file_delete(_files[_i])
        game_directory=_gameDirectory
    }
    scrNTTESmokeLog("FULL QUEST CHEST/FLOOR NATIVE: actual CustomChest+physical artifact pickup; real DROP input, curse/enemy/ordinary gates, inactive merged traversal/whole transfer, exact stack pop/swap, permanent part save/reload/removal, live floor exclusion OK @"+string(30/timescale))
}

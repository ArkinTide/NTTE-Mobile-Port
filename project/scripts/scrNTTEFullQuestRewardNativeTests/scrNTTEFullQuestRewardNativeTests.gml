function scrNTTEFullQuestRewardNativeTests() {
    assert(scrNTTESmokeEnabled(),"Quest reward persistence fixture requires explicit desktop smoke harness")
    var _before=scrNTTEFullInstances(all),_game=scrNTTEFullAreaGeneratorSnapshot(GameCont),
        _back=scrNTTEFullAreaGeneratorSnapshot(BackCont),_uber=scrNTTEFullAreaGeneratorSnapshot(UberCont),
        _progress=global.ntte_full_progress,_gameDirectory=game_directory,_seed=random_get_seed(),
        _scratch=working_directory+"quest-reward-native-fixture/"
    directory_create(_scratch);game_directory=_scratch
    global.ntte_full_progress=json_parse(json_stringify(_progress))
    GameCont.area=area_vault;GameCont.crown=0
    try {
        var _player=instance_find(Player,0)
        for(var _ultra=0;_ultra<=1;++_ultra) {
            GameCont.ultra_got[Race.Steroids,UltraSkill.Ambidextrous]=_ultra
            var _chest=instance_create(75000+200*_ultra,75000,NTTEFullHugeWeaponChest),_count=instance_number(WepPickup)
            assert(instance_is(_chest,NTTEFullCustomChest) && _chest.sprite_index==scrNTTERefSprite("HugeWeaponChest")
                && _chest.wep==wep_ntte_ultra_quasar_rifle && _chest.nochest==2 && _chest.spr_shadow==shd64 && _chest.spr_shadow_y==4,
                "HugeWeaponChest lost actual CustomChest, genuine UltraQuasar reward/source2nochest/64shadow")
            _chest.curse=1;GameCont.nochest=8
            with(_chest) scrNTTEFullCustomChestOpen(_player)
            assert(!instance_exists(_chest) && instance_number(WepPickup)==_count+1+_ultra && GameCont.nochest==0
                && scrNTTEFullUnlockGet("race:beetle",false),
                "Real HugeWeaponChest open lost source1+Ambidextrous rewards/nochest clear/permanent Beetle unlock")
        }
        var _pickups=scrNTTEFullInstances(WepPickup),_reward=0
        for(var _i=0;_i<array_length(_pickups);++_i) if(array_get_index(_before,_pickups[_i])<0) {
            assert(_pickups[_i].wep==wep_ntte_ultra_quasar_rifle && _pickups[_i].ammo && _pickups[_i].curse==1,
                "HugeWeaponChest actual reward lost UltraQuasar/filled ammo/inherited curse")
            _reward+=1
        }
        assert(_reward==3,"HugeWeaponChest source single+Ambidextrous fixture total diverged")
        GameCont.ultra_got[Race.Steroids,UltraSkill.Ambidextrous]=0
        var _quest=instance_create(75600,75000,NTTEFullHugeQuestChest),_count=instance_number(WepPickup)
        assert(instance_is(_quest,NTTEFullHugeWeaponChest) && _quest.sprite_index==scrNTTERefSprite("HugeQuestChest")
            && _quest.spr_dead==scrNTTERefSprite("HugeQuestChestOpen") && _quest.spr_shadow_y==6,
            "HugeQuestChest lost genuine HugeWeaponChest reward inheritance/source art/6px shadow")
        with(_quest) scrNTTEFullCustomChestOpen(_player)
        assert(!instance_exists(_quest) && instance_number(WepPickup)==_count+1,
            "HugeQuestChest ultimate reward did not use actual inherited source opening")
    }
    finally {
        var _all=scrNTTEFullInstances(all)
        for(var _i=array_length(_all)-1;_i>=0;--_i) if(array_get_index(_before,_all[_i])<0 && instance_exists(_all[_i])) instance_destroy(_all[_i],false)
        scrNTTEFullAreaGeneratorRestore(_game);scrNTTEFullAreaGeneratorRestore(_back);scrNTTEFullAreaGeneratorRestore(_uber)
        global.ntte_full_progress=_progress;random_set_seed(_seed)
        var _files=[_scratch+"ntte-full-progress.json",_scratch+"ntte-full-progress.json.bak",_scratch+"ntte-full-progress.json.tmp"]
        for(var _i=0;_i<array_length(_files);++_i) if(file_exists(_files[_i])) file_delete(_files[_i])
        game_directory=_gameDirectory
    }
    scrNTTESmokeLog("FULL QUEST REWARD NATIVE: actual huge weapon/quest CustomChest inheritance, UltraQuasar1+Ambidextrous/filled ammo+curse, source nochest reset/permanent Beetle unlock/large clear+freeze FX OK @"+string(30/timescale))
}

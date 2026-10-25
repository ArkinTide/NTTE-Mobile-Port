function scrNTTEFullVaultHQLevelNativeTests() {
    var _state=scrNTTEFullVanillaFixtureBegin(),_progress=global.ntte_full_progress,
        _players=scrNTTEFullAreaGeneratorSnapshot(Player),_uber=scrNTTEFullAreaGeneratorSnapshot(UberCont),
        _skills=ds_list_create(),_oldSkills=GameCont.skills,
        _oldFlowerFlag=scrNTTEFullValue(GameCont,"ntte_vault_flower",true),
        _oldReroll=scrNTTEFullValue(GameCont,"ntte_reroll",undefined),
        _oldRerollHUD=scrNTTEFullValue(GameCont,"ntte_reroll_hud",undefined)
    global.ntte_full_progress=json_parse(json_stringify(_progress))
    GameCont.skills=_skills
    GameCont.ntte_full_skills=json_parse(json_stringify(GameCont.ntte_full_skills))
    GameCont.ntte_full_native_skill_counts={}
    GameCont.ntte_reroll=undefined;GameCont.ntte_reroll_hud=undefined
    try {
        GameCont.area=area_caves;random_set_seed(11492);var _expected=random(100000);random_set_seed(11492)
        assert(is_undefined(scrNTTEFullVaultHQLevelStart()) && random(100000)==_expected,
            "Natural Vault/HQ provider touched unrelated area or its RNG")
        GameCont.area=area_vault;GameCont.proto=true;GameCont.crown=0
        GameCont.ntte_vault_flower=true;GameCont.ntte_quest_spawned_part_index_list=[]
        global.ntte_full_progress.unlocks[$ "quest:part:0"]=false
        instance_create(10000,10000,Floor)
        var _ped=instance_create(10016,10016,CrownPed),_natural=scrNTTEFullVaultHQLevelStart()
        assert(array_length(_natural.flowers)==1 && array_length(_natural.quest)==1
            && _natural.quest[0].mode=="ancient" && instance_is(_natural.quest[0].chest,NTTEFullQuestChest),
            "Natural Vault gate did not invoke genuine flower room followed by original Ancient acquisition")
        var _froom=_natural.flowers[0],_flower=_froom.flower
        assert(array_length(_froom.room.floors)==9 && instance_is(_flower,NTTEFullVaultFlower)
            && _flower.x==_froom.room.x && _flower.y==_froom.room.y-8
            && instance_exists(_froom.light) && _froom.light.sprite_index==sprLightBeamVault,
            "Natural Vault lost actual3x3Flower room/8px prop offset/genuine Vault light")
        for(var _i=0;_i<array_length(_froom.room.floors);++_i) {
            var _f=_froom.room.floors[_i]
            assert(_f.sprite_index==scrNTTERefSprite("VaultFlowerFloor") && _f.image_index==_i && _f.depth==7,
                "Natural Vault Flower room source artwork/index/depth differs")
        }
        assert(!_flower.alive && _flower.prompt==noone && _flower.hp==30 && _flower.mask_index==mskBigSkull,
            "VaultFlower with no eligible owned mutation should wilt without an interactive prompt")
        with(_flower) scrNTTEFullVaultFlowerStep()
        assert(_flower.max_hp==9 && _flower.hp==9 && _flower.spr_idle==scrNTTERefSprite("VaultFlowerWiltedIdle"),
            "Wilted VaultFlower lost source9HP cap and wilted art")
        scrNTTEFullCavesFixtureCleanup(_state.baseline)

        // The source permadeath flag suppresses the flower only, never the
        // independent Ancient/quest-hub gate after it.
        GameCont.ntte_vault_flower=false;GameCont.ntte_quest_spawned_part_index_list=[]
        instance_create(10000,10000,Floor);instance_create(10016,10016,CrownPed)
        _natural=scrNTTEFullVaultHQLevelStart()
        assert(array_length(_natural.flowers)==0 && array_length(_natural.quest)==1 && _natural.quest[0].mode=="ancient",
            "VaultFlower death disabled the independent physical Ancient artifact acquisition")
        scrNTTEFullCavesFixtureCleanup(_state.baseline)

        // Actual prop damage/death creates exactly one Orchid and closes the
        // per-run source flower gate; deleting a prop without Destroy does not.
        ds_list_add(GameCont.skills,mut_last_wish);GameCont.ntte_vault_flower=true
        _flower=instance_create(98000,98000,NTTEFullVaultFlower)
        assert(_flower.alive && _flower.skill==mut_last_wish && instance_exists(_flower.prompt)
            && is_callable(_flower.prompt.on_meet) && _flower.hp==30,
            "Living VaultFlower lost LastWish preference/30HP/shared mutation-icon prompt")
        var _pets=instance_number(NTTEFullPet),_prompt=_flower.prompt
        _flower.hp=0;instance_destroy(_flower)
        assert(instance_number(NTTEFullPet)==_pets+1 && !GameCont.ntte_vault_flower && !instance_exists(_prompt),
            "Living VaultFlower death did not release exactly one Orchid, persist its run flag or clean up prompt")
        var _pet=instance_find(NTTEFullPet,0)
        assert(_pet.pet=="Orchid","Living VaultFlower death substituted a generic ally for genuine Orchid")
        scrNTTEFullCavesFixtureCleanup(_state.baseline)

        _flower=instance_create(98000,98000,NTTEFullVaultFlower);_flower.alive=false;_flower.hp=0
        _pets=instance_number(NTTEFullPet);instance_destroy(_flower)
        assert(instance_number(NTTEFullPet)==_pets,"Wilted VaultFlower emitted the living secret Orchid")
        scrNTTEFullCavesFixtureCleanup(_state.baseline)

        _flower=instance_create(98000,98000,NTTEFullVaultFlower)
        var _points=GameCont.skillpoints,_player=instance_find(Player,0)
        with(_flower) assert(scrNTTEFullVaultFlowerInteract(_player),"Actual living VaultFlower refused native player interaction")
        assert(scrNTTEFullSkillGet("reroll")==1 && scr_skill_get(mut_last_wish)==0
            && GameCont.ntte_reroll==mut_last_wish && GameCont.skillpoints==_points+1,
            "VaultFlower did not use real Reroll transfer to remove LastWish and enqueue one genuine mutation choice")
        with(_flower) scrNTTEFullVaultFlowerStep()
        assert(!_flower.alive && !_flower.prompt.visible,
            "VaultFlower did not close its prompt after genuine Reroll started")
        scrNTTEFullCavesFixtureCleanup(_state.baseline)

        // Natural HQ does not require a direct QuestHQGenerate fixture call.
        GameCont.area=area_hq;GameCont.subarea=3;GameCont.ntte_quest_spawned_part_index_list=[]
        global.ntte_full_progress.unlocks[$ "quest:part:2"]=false
        var _middle=instance_create(98016,98016,FloorMiddle),_want=instance_create(0,0,WantPopo),
            _floor=instance_create(98512,98000,Floor),_grunt=instance_create(98400,98000,Grunt)
        _natural=scrNTTEFullVaultHQLevelStart()
        assert(!instance_exists(_want) && !instance_exists(_grunt) && array_length(_natural.elevators)==1
            && instance_is(_natural.elevators[0],NTTEFullFreakChamber)
            && instance_is(_natural.security,NTTEFullPopoSecurity),
            "Natural HQ source gate lost actual WantPopo elevator and genuine one-troop Security conversion")
        assert(is_struct(_natural.side) && _natural.side.entry.object==Player && _natural.side.entry.open
            && _natural.side.entry.alarm0==1 && _natural.side.artifact.object=="QuestChest"
            && array_get_index(GameCont.ntte_quest_spawned_part_index_list,2)>=0,
            "Natural HQ3 lost genuine player entry/opposite chambers and physical stolen artifact run gate")
        scrNTTEFullCavesFixtureCleanup(_state.baseline)
        GameCont.subarea=2;_middle=instance_create(98016,98016,FloorMiddle)
        _natural=scrNTTEFullVaultHQLevelStart()
        assert(is_undefined(_natural.side),"Natural HQ inserted third-subarea artifact elevators into HQ2")
    }
    finally {
        scrNTTEFullAreaGeneratorRestore(_players);scrNTTEFullAreaGeneratorRestore(_uber)
        GameCont.skills=_oldSkills;ds_list_destroy(_skills);global.ntte_full_progress=_progress
        scrNTTEFullVanillaFixtureEnd(_state)
        GameCont.ntte_vault_flower=_oldFlowerFlag;GameCont.ntte_reroll=_oldReroll;GameCont.ntte_reroll_hud=_oldRerollHUD
    }
    scrNTTESmokeLog("FULL VAULT/HQ NATURAL: real3x3Flower/light then independent Ancient acquisition, wilt9HP, living30HP/LastWish prompt, real Orchid death/run suppression; HQ WantPopo/elevators/Security and third-subarea physical artifact entry OK @"+string(30/timescale))
}

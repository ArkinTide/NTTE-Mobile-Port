function scrNTTEFullPetWorldLevelNativeTests() {
    var _before=scrNTTEFullInstances(all),_game=scrNTTEFullAreaGeneratorSnapshot(GameCont),_seed=random_get_seed(),
        _hidden=scrNTTEFullInstances([CursedBigChest,GoldChest,GenCont,LevCont]),
        _active=scrNTTEFullValue(GameCont,"ntte_full_active_coast",false)
    for(var _i=0;_i<array_length(_hidden);++_i) instance_deactivate_object(_hidden[_i])
    GameCont.ntte_full_active_coast=false;GameCont.crown=crwn_none;GameCont.loops=0;GameCont.hard=0
    try {
        var _near=instance_create(10100,10100,CursedBigChest),_far=instance_create(98000,98000,CursedBigChest)
        GameCont.area=area_caves;random_set_seed(8129);var _expected=random(100000);random_set_seed(8129)
        assert(scrNTTEFullPetWorldLevelStart()==noone && random(100000)==_expected,
            "Native ordinary caves spawned original cursed-only Prism provider or consumed RNG")
        GameCont.area=area_cursed_caves
        var _prism=scrNTTEFullPetWorldLevelStart()
        assert(instance_exists(_prism) && _prism.object_index==NTTEFullPet && _prism.pet=="Prism"
            && _prism.x==_far.x && _prism.y==_far.y && _prism.spawn_loc[0]==_far.x && _prism.spawn_loc[1]==_far.y
            && _prism.mask_index==mskFrogEgg && instance_exists(_far) && instance_exists(_near),
            "Natural cursed Prism lost farthest actual BigCursedChest/shared real pet constructor or improperly removed source chest")
        GameCont.area=area_mansion;GameCont.hard=5
        var _goldNear=instance_create(10150,10150,GoldChest),_goldFar=instance_create(98500,98500,GoldChest)
        _goldNear.curse=1
        random_set_seed(5912)
        var _model=scrNTTEFullPetCreate(_goldNear.x,_goldNear.y,"Mimic"),
            _weapon=scrNTTEFullWeaponDecide(0,1+2*_model.curse+GameCont.hard,true,undefined,_model),_modelCurse=_model.curse
        instance_destroy(_model,false)
        random_set_seed(5912)
        var _mimic=scrNTTEFullPetWorldLevelStart()
        assert(instance_exists(_mimic) && _mimic.object_index==NTTEFullPet && _mimic.pet=="Mimic"
            && _mimic.x==10150 && _mimic.y==10150 && _mimic.wep==_weapon && _mimic.curse==_modelCurse
            && !instance_exists(_goldNear) && instance_exists(_goldFar) && _mimic.wep!=wep_none
            && instance_exists(_mimic.prompt_mimic),
            "Natural mansion Mimic lost nearest actual GoldChest removal, source pet-curse/default0 gold selection, shared constructor or DROP Prompt")
        assert(scr_weapon_is_golden(_mimic.wep),
            "Natural mansion Mimic gold selector produced a non-gold weapon")
    }
    finally {
        var _after=scrNTTEFullInstances(all)
        for(var _i=0;_i<array_length(_after);++_i) if(array_get_index(_before,_after[_i])<0) instance_destroy(_after[_i],false)
        for(var _i=0;_i<array_length(_hidden);++_i) instance_activate_object(_hidden[_i])
        scrNTTEFullAreaGeneratorRestore(_game);GameCont.ntte_full_active_coast=_active;random_set_seed(_seed)
    }
    scrNTTESmokeLog("NATURAL PRISM/MIMIC: cursed-caves farthest actual BigCursedChest retained/shared Prism; mansion nearest real GoldChest removal/shared Mimic/source pet-curse native gold selection OK")
}

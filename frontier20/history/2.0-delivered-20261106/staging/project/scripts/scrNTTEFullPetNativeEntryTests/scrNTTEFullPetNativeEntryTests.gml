function scrNTTEFullPetNativeEntryTests() {
    assert(scrNTTESmokeEnabled(),"Pet entry fixture requires explicit desktop smoke harness")
    var _before=scrNTTEFullInstances(all),_game=scrNTTEFullAreaGeneratorSnapshot(GameCont),
        _players=scrNTTEFullAreaGeneratorSnapshot(Player),_seed=random_get_seed(),
        _progress=global.ntte_full_progress,_hidden=scrNTTEFullInstances([LastDie,YungCuz])
    for(var _i=0;_i<array_length(_hidden);++_i) instance_deactivate_object(_hidden[_i])
    global.ntte_full_progress={schema:1,unlocks:{},loadouts:{},stats:{}}
    try {
        var _p=instance_find(Player,0),_last=instance_create(98000,98000,LastDie)
        _last.image_xscale=-1;_last.image_yscale=1
        var _count=instance_number(NTTEFullPet)
        scrNTTEFullPetNativeEntryStep()
        var _guardian=noone
        with(NTTEFullPet) if(array_get_index(_before,id)<0 && pet=="Guardian") _guardian=id
        assert(instance_exists(_guardian) && instance_number(NTTEFullPet)==_count+1
            && _last.team==0 && _guardian.team==0 && _guardian.sprite_index==_guardian.spr_appear
            && _guardian.can_escape && _guardian.ntte_pet_alarm==30 && _guardian.walk==15
            && abs(angle_difference(_guardian.direction,point_direction(0,0,1,-1)))<=0.001
            && abs(_guardian.speed-0.4*timescale)<=0.001 && _guardian.right==-1,
            "Actual LastDie did not produce source Guardian provider/appear/team/alarm/escape/walk+opposite-facing")
        _count=instance_number(NTTEFullPet);scrNTTEFullPetNativeEntryStep()
        assert(instance_number(NTTEFullPet)==_count,"Native LastDie setup spawned duplicate Guardians every Step")
        var _cuz=instance_create(_p.x+24,_p.y,YungCuz)
        _cuz.sprite_index=sprCuzInteract;_cuz.image_index=1
        var _sprite=_cuz.sprite_index,_image=_cuz.image_index
        scrNTTEFullPetNativeEntryStep()
        assert(instance_exists(_cuz.ntte_cuz) && _cuz.ntte_cuz.pet=="Cuz" && _cuz.ntte_cuz.cuz==_cuz
            && _cuz.spr_from==sprCuzInteractTo && _cuz.spr_to==sprCuzInteractFrom
            && _cuz.sprite_index==_sprite && _cuz.image_index==_image,
            "Actual YungCuz lost single companion binding/native animation-direction fix/original frame")
        _count=instance_number(NTTEFullPet);scrNTTEFullPetNativeEntryStep()
        assert(instance_number(NTTEFullPet)==_count,"Native YungCuz setup spawned duplicate Cuz companions")
        // Source custom/crying YungCuz cannot produce an ordinary Cuz pet.
        var _cry=instance_create(_p.x+128,_p.y,YungCuz)
        _cry.spr_idle=sprCuzCry;scrNTTEFullPetNativeEntryStep()
        assert(_cry.ntte_cuz==noone && instance_number(NTTEFullPet)==_count,
            "Nonstandard source YungCuz incorrectly produced an ordinary Cuz companion")
        // Source Cuz step creates its seated counterpart and binds it after
        // Create. The deferred setup must respect that already-real binding.
        var _bound=instance_create(_p.x+256,_p.y,YungCuz)
        _bound.ntte_cuz=_cuz.ntte_cuz
        scrNTTEFullPetNativeEntryStep()
        assert(_bound.ntte_cuz==_cuz.ntte_cuz && instance_number(NTTEFullPet)==_count,
            "Pet-created seated YungCuz duplicated its existing companion during native setup")
    }
    finally {
        var _all=scrNTTEFullInstances(all)
        for(var _i=array_length(_all)-1;_i>=0;--_i)
            if(array_get_index(_before,_all[_i])<0 && instance_exists(_all[_i])) instance_destroy(_all[_i],false)
        for(var _i=0;_i<array_length(_hidden);++_i) instance_activate_object(_hidden[_i])
        scrNTTEFullAreaGeneratorRestore(_game);scrNTTEFullAreaGeneratorRestore(_players)
        global.ntte_full_progress=_progress;random_set_seed(_seed)
    }
    scrNTTESmokeLog("FULL PET NATIVE ENTRY: real LastDie→Guardian provider+appear+team+escape+logical walk/alarm/one-shot setup/real YungCuz→Cuz bidirectional binding/crying and already-bound guards/native animation reversal preserves frame OK @"+string(30/timescale))
}

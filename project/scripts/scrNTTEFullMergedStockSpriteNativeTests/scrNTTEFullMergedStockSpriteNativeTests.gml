// Controlled real Bullet1 -> actual RuntimeReplace inputs, not a natural
// weapon-firing witness. No creation provenance is supplied to these shots.
function scrNTTEFullMergedStockSpriteCheckReturn(_weapon,_expected) {
    var _model=scrNTTEFullWeaponModel(_weapon),_merge=_model.temerge,
        _state=scrNTTEFullValue(_model,"ntte_native_state",undefined),_previous=_merge.is_active,
        _progress=global.ntte_full_progress,_progressBytes=json_stringify(_progress)
    try {
        for(var _active=0;_active<2;++_active) {
            _merge.is_active=(_active==1)
            var _bytes=json_stringify(_model),_flag=_merge.is_active,
                _sprite=scrNTTEFullMergedRuntimeStockSprite(_weapon)
            assert(_sprite==_expected && _model.temerge==_merge && _merge.is_active==_flag
                && scrNTTEFullValue(_model,"ntte_native_state",undefined)==_state
                && json_stringify(_model)==_bytes && global.ntte_full_progress==_progress
                && json_stringify(global.ntte_full_progress)==_progressBytes,
                "Physical stock query changed exact merge identity/activation, physical metadata or canonical state on return")
        }
    }
    finally {_merge.is_active=_previous}
}
function scrNTTEFullMergedStockSpriteRunShot(_part,_shotWep,_art,_retain,_expected,_hit) {
    var _p=instance_find(Player,0),_shot=instance_create(_p.x+200,_p.y,Bullet1),
        _frame=scrNTTEFullMergeFireFrame(_part,_p),_merge=_part.temerge,_flag=_merge.is_active,
        _state=scrNTTEFullValue(_part,"ntte_native_state",undefined),
        _ammo=json_stringify(_p.ammo),_rads=GameCont.rad,_hitBytes=json_stringify(_hit)
    _shot.wep=_shotWep;_shot.sprite_index=_art;_shot.creator=_p;_shot.team=_p.team
    _shot.hitid=_hit;_shot.ntte_stock_fixture_sentinel={value:17}
    var _sentinel=_shot.ntte_stock_fixture_sentinel,_creator=_shot.creator,_team=_shot.team
    assert(!_frame.has_shot,"Physical stock fixture unexpectedly enables child firing")
    var _result=scrNTTEFullMergedRuntimeReplace([_shot],_frame,{x:_p.x,y:_p.y,direction:0},0,[],true)
    assert(instance_exists(_shot)==_retain,"Actual RuntimeReplace disagreed with controlled physical-stock exemption")
    assert(array_length(_result)==0 && !_frame.has_shot && _frame.shot_count==0
        && _frame.shot_replace_count==0 && json_stringify(_p.ammo)==_ammo && GameCont.rad==_rads
        && _part.temerge==_merge && _merge.is_active==_flag
        && scrNTTEFullValue(_part,"ntte_native_state",undefined)==_state,
        "Physical stock matching changed fire counters/resources or physical merge/state identity")
    if(_retain) {
        assert(_shot.sprite_index==_expected && _shot.wep==_shotWep && _shot.creator==_creator && _shot.team==_team
            && _shot.ntte_stock_fixture_sentinel==_sentinel && _sentinel.value==17
            && json_stringify(_shot.hitid)==_hitBytes,
            "Retained physical-stock projectile lost original ID/model/creator/state or source literal hitid behavior")
        instance_destroy(_shot,false)
    }
}
function scrNTTEFullMergedStockSpriteNativeTests() {
    var _before=scrNTTEFullInstances(all),_players=scrNTTEFullAreaGeneratorSnapshot(Player),
        _game=scrNTTEFullAreaGeneratorSnapshot(GameCont),_back=scrNTTEFullAreaGeneratorSnapshot(BackCont),
        _uber=scrNTTEFullAreaGeneratorSnapshot(UberCont),_keys=scrNTTEFullAreaGeneratorSnapshot(KeyCont),
        _seed=random_get_seed(),_progress=global.ntte_full_progress,_progressBytes=json_stringify(_progress),
        _skills=ds_list_create()
    scrNTTEFullWeaponNativeInit()
    var _models=scrNTTEFullArrayCopy(global.ntte_full_native_weapon_models)
    try {
        global.ntte_full_progress=json_parse(_progressBytes)
        global.ntte_full_progress.unlocks[$ "wep:trident"]=true
        var _fixtureProgress=global.ntte_full_progress,_fixtureProgressBytes=json_stringify(_fixtureProgress)
        GameCont.skills=_skills;GameCont.ntte_full_native_skill_counts={};GameCont.area=1;GameCont.underwater=false
        GameCont.rad=100;GameCont.temerge_effect_vars_map={}
        with(Player) {race=Race.Fish;infammo=0}
        var _p=instance_find(Player,0)
        _p.x=197000;_p.y=197000;_p.xprevious=_p.x;_p.yprevious=_p.y
        _p.ammo=array_create(Ammo.NUM_AMMO_TYPES,100);_p.curse=0;_p.bcurse=0
        var _cases=[],_gold=scrNTTEFullWeaponMerge({wep:wep_ntte_teleport_gun,gold:true},wep_shotgun)
        array_push(_cases,{model:_gold,stock:scrNTTERefSprite("GoldTeleportGun"),different:true})
        var _coat=scrNTTEFullWeaponMerge({wep:wep_ntte_teleport_gun,gold:true},wep_shotgun),
            _coatHandle=global.ntte_full_weapon_skin(scrNTTEFullWeaponNative(_coat),"coat venuz",_p)
        assert(scrNTTEFullWeaponModel(_coatHandle)==_coat,"Coat fixture changed physical model")
        array_push(_cases,{model:_coat,stock:scrNTTERefSprite("CoatTeleportGun"),different:true})
        var _coatNative=scrNTTEFullWeaponMerge({wep:wep_golden_revolver},wep_shotgun)
        global.ntte_full_weapon_skin(scrNTTEFullWeaponNative(_coatNative),"coat venuz",_p)
        array_push(_cases,{model:_coatNative,stock:scrNTTERefSprite("CoatRevolver"),different:true})
        var _ordinaryGold=scrNTTEFullWeaponMerge(wep_golden_revolver,wep_shotgun)
        array_push(_cases,{model:_ordinaryGold,stock:scr_weapon_get_sprite(wep_golden_revolver),different:false})
        var _hidden=scrNTTEFullWeaponMerge({wep:wep_ntte_trident},wep_shotgun),
            _hiddenState=scrNTTEFullWeaponNativeState(_hidden)
        _hiddenState.visible=false
        array_push(_cases,{model:_hidden,stock:mskNone,different:true})
        var _bone=scrNTTEFullWeaponMerge({wep:wep_ntte_bone,ammo:0,type_index:0},wep_shotgun),
            _boneState=scrNTTEFullWeaponNativeState(_bone)
        _boneState.ammo=0
        array_push(_cases,{model:_bone,stock:mskNone,different:true})
        var _ordinary=scrNTTEFullWeaponMerge(wep_revolver,wep_shotgun)
        array_push(_cases,{model:_ordinary,stock:scr_weapon_get_sprite(wep_revolver),different:false})
        for(var _i=0;_i<array_length(_cases);++_i) {
            var _case=_cases[_i],_model=_case.model,_stock=_case.stock,
                _raw=scr_weapon_get_sprite(scrNTTEFullWeaponRaw(_model)),_full=scr_weapon_get_sprite(_model)
            assert(_stock!=_full && ((_stock!=_raw)==_case.different),
                "Controlled physical stock witness does not distinguish expected raw/physical/full sprites")
            scrNTTEFullMergedStockSpriteCheckReturn(_model,_stock)
            scrNTTEFullMergedStockSpriteCheckReturn(scrNTTEFullWeaponNative(_model),_stock)
            // Source compares hitid[1] to the full sprite, not to stock art.
            scrNTTEFullMergedStockSpriteRunShot(_model,_model,_stock,true,_full,[0,_full])
            scrNTTEFullMergedStockSpriteRunShot(_model,_model,_stock,true,_full,[0,_stock])
            scrNTTEFullMergedStockSpriteRunShot(_model,_model,_stock,true,_full,[0])
            scrNTTEFullMergedStockSpriteRunShot(_model,_model,_full,true,_full,19)
        }
        // Same raw is a legal source match. The stock query belongs to the
        // firing physical _part; the replacement art belongs to shot.wep.
        var _other=scrNTTEFullWeaponMerge({wep:wep_ntte_teleport_gun,gold:false},wep_revolver),
            _otherStock=scrNTTEFullMergedRuntimeStockSprite(_other),_otherFull=scr_weapon_get_sprite(_other),
            _goldStock=scrNTTERefSprite("GoldTeleportGun"),_goldFull=scr_weapon_get_sprite(_gold)
        assert(_otherStock!=_goldStock && _otherFull!=_goldFull && _otherStock!=_otherFull,
            "Same-raw physical fixture is not distinct")
        scrNTTEFullMergedStockSpriteRunShot(_gold,_other,_goldStock,true,_otherFull,[0,_otherFull])
        scrNTTEFullMergedStockSpriteRunShot(_gold,wep_ntte_teleport_gun,_goldStock,true,
            scr_weapon_get_sprite(wep_ntte_teleport_gun),19)
        scrNTTEFullMergedStockSpriteRunShot(_gold,_other,_otherStock,false,undefined,19)
        scrNTTEFullMergedStockSpriteRunShot(_gold,{wep:wep_shotgun},_goldStock,false,undefined,19)
        scrNTTEFullMergedStockSpriteRunShot(_gold,_gold,scrNTTERefSprite("Bone"),false,undefined,19)
        scrNTTEFullMergedStockSpriteRunShot(_gold,undefined,_goldStock,false,undefined,19)
        assert(scrNTTEFullMergedRuntimeStockSprite(wep_revolver)==scr_weapon_get_sprite(wep_revolver)
            && scrNTTEFullMergedRuntimeStockSprite({wep:wep_golden_revolver})==scr_weapon_get_sprite(wep_golden_revolver),
            "Unmerged numeric/physical stock query changed ordinary getter behavior")
        // A real malformed Bone sprite lookup throws from RefSprite bounds;
        // this is not a test-only injected production callback.
        var _bad=scrNTTEFullWeaponMerge({wep:wep_ntte_bone,ammo:1,type_index:1000},wep_revolver),
            _badState=scrNTTENewState(wep_ntte_bone),_badMerge=_bad.temerge
        _bad.ntte_native_state=_badState
        for(var _active=0;_active<2;++_active) {
            _badMerge.is_active=(_active==1)
            var _badBytes=json_stringify(_bad),_flag=_badMerge.is_active,_caught=false
            try {scrNTTEFullMergedRuntimeStockSprite(_bad)}
            catch(_error) {
                _caught=true
                assert(string_pos("QuestArtifact",string(_error))>0,"Exception fixture failed outside real physical Bone sprite lookup")
            }
            assert(_caught && _bad.temerge==_badMerge && _badMerge.is_active==_flag
                && _bad.ntte_native_state==_badState && json_stringify(_bad)==_badBytes,
                "Throwing physical stock query failed to restore exact merge identity/activation or physical canonical state")
        }
        assert(global.ntte_full_progress==_fixtureProgress && json_stringify(global.ntte_full_progress)==_fixtureProgressBytes,
            "Physical stock query/RuntimeReplace changed active private progress identity or contents")
        scrNTTESmokeLog("FULL MERGED PHYSICAL STOCK: controlled real Bullet1 RuntimeReplace gold/Coat/native/hiddenTrident/emptyBone, full-first/hitid, same-raw firing-part, foreign-art/source negatives and return/real-exception identity restoration OK @"+string(30/timescale))
    }
    finally {
        scrNTTEFullMergedRuntimeTestCleanup(_before)
        scrNTTEFullAreaGeneratorRestore(_players);scrNTTEFullAreaGeneratorRestore(_game)
        scrNTTEFullAreaGeneratorRestore(_back);scrNTTEFullAreaGeneratorRestore(_uber);scrNTTEFullAreaGeneratorRestore(_keys)
        global.ntte_full_native_weapon_models=_models;global.ntte_full_progress=_progress
        random_set_seed(_seed);ds_list_destroy(_skills)
        assert(global.ntte_full_progress==_progress && json_stringify(global.ntte_full_progress)==_progressBytes,
            "Physical stock fixture changed original progress identity or serialized contents")
    }
}

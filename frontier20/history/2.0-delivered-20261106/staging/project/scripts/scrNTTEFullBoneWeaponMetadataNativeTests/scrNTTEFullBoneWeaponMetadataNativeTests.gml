function scrNTTEFullBoneWeaponMetadataNativeTests() {
    scrNTTEFullWeaponNativeInit()
    var _models=scrNTTEFullArrayCopy(global.ntte_full_native_weapon_models),_progress=global.ntte_full_progress,
        _seed=random_get_seed(),_before=scrNTTEFullInstances(all),_players=scrNTTEFullAreaGeneratorSnapshot(Player),
        _keys=scrNTTEFullAreaGeneratorSnapshot(KeyCont),_game=scrNTTEFullAreaGeneratorSnapshot(GameCont),
        _p=instance_find(Player,0),_handles=[]
    global.ntte_full_progress=json_parse(json_stringify(_progress))
    try {
        global.ntte_full_progress.unlocks[$ "wep:scythe"]=true
        var _names=[loc("NTTE:Bone","BONE"),"ANCIENT ARTIFACT","GUARDED ARTIFACT","STOLEN ARTIFACT","MISSING ARTIFACT"],
            _tips=["BONE THE FISH","SECRETS LIE WITHIN","UNCONVENTIONAL WEAPONRY","BRING IT BACK","HARDLY FOUND, EASILY LOST"]
        for(var _i=0;_i<5;++_i) {
            var _model=scrNTTEFullCrabboneCreateModel(_i-1,2)
            // Original artifacts are type_index values on the same module.
            _model.wep=wep_ntte_bone
            var _w=scrNTTEFullWeaponNative(_model),_state=scrNTTEFullWeaponNativeState(_w),
                _sprite=_i==0?scrNTTERefSprite("Bone"):scrNTTERefSprite("QuestArtifact",_i-1),
                _alias=_i==0?wep_ntte_bone:wep_ntte_ancient_artifact+_i-1,
                _swap=_i==0?sndBloodGamble:sndSwapHammer
            array_push(_handles,_w)
            assert(scr_weapon_get_name(_w)==_names[_i] && scr_weapon_get_text(_w)==_tips[_i]
                && scr_weapon_get_sprite(_w)==_sprite && scrNTTEFullWeaponHUDSprite(_w)==_sprite
                && scrNTTEFullWeaponSwapSound(_w)==_swap,
                "Canonical Crabbone type_index failed source live name/text/art/HUD/swap metadata")
            assert(scr_weapon_get_name(_alias)==_names[_i] && scr_weapon_get_text(_alias)==_tips[_i]
                && scr_weapon_get_sprite(_alias)==_sprite && scrNTTEFullWeaponSwapSound(_alias)==_swap,
                "Native ordinary/artifact IDs lost the exact source Crabbone metadata")
            var _pickup=scrWeaponPickupCreate(156000+48*_i,156000,_w)
            assert(_pickup.name==_names[_i] && _pickup.sprite_index==_sprite && _pickup.ntte_state==_state,
                "Actual native Crabbone pickup ignored source physical type_index metadata/state")
            scrNTTEFullCrabboneSetAmmo(_w,0)
            scrNTTESmokeLog("BONE EMPTY METADATA DIAG "+json_stringify({weapon:_w,sourceIndex:_i,
                modelAmmo:_model.ammo,stateAmmo:_state.ammo,name:scr_weapon_get_name(_w),text:scr_weapon_get_text(_w),
                sprite:scr_weapon_get_sprite(_w),hud:scrNTTEFullWeaponHUDSprite(_w),
                swap:scrNTTEFullWeaponSwapSound(_w),expectedSwap:sndSwapCursed,
                sameState:scrNTTEFullWeaponNativeState(_w)==_state}))
            assert(scr_weapon_get_name(_w)=="DROP" && scr_weapon_get_text(_w)==""
                && scr_weapon_get_sprite(_w)==mskNone && scrNTTEFullWeaponHUDSprite(_w)==mskNone
                && scrNTTEFullWeaponSwapSound(_w)==sndSwapCursed && scrNTTEFullWeaponNativeState(_w)==_state,
                "Empty physical Crabbone failed original DROP/empty-tip/hidden-art/cursed-swap metadata")
            scrNTTEFullCrabboneSetAmmo(_w,2)
            assert(scr_weapon_get_name(_w)==_names[_i] && scr_weapon_get_sprite(_w)==_sprite,
                "Restoring real physical bone ammo retained stale empty metadata")
        }
        var _load=0
        _p.curse=1;_p.bcurse=0
        with(_p) _load=scr_weapon_get_load(_handles[0])
        assert(_load==30,"Source Crabbone load ignored actual primary-slot curse context")
        _p.curse=0;_p.bcurse=1
        with(_p) _load=scr_weapon_get_load(_handles[1])
        assert(_load==6,"Source Crabbone load incorrectly read back-slot curse instead of source primary curse")
        // Source native mode change updates one physical inventory handle.
        // The actual mounted state-slot Step owns the existing firing adapter.
        var _scytheModel={wep:wep_ntte_bone_scythe},_scythe=scrNTTEFullWeaponNative(_scytheModel),
            _state=scrNTTEFullWeaponNativeState(_scythe),
            _scytheTips=["@rREASSEMBLED","@wMARROW @sFROM A HUNDRED @gMUTANTS","@gRADIATION@s DETERIORATES @wBONES"],
            _scytheNames=["BONE SCYTHE","BONE SHOTBOW","BONE SLUGBOW"],
            _swaps=[sndBloodGamble,sndSwapMachinegun,sndSwapMotorized],_loads=[12,18,15],
            _normalSprites=["Weapon.scythe.sprWep","Weapon.scythe.sprShotbow","Weapon.scythe.sprSlugbow"],
            _hudSprites=["Weapon.scythe.sprWepHUD","Weapon.scythe.sprShotbow","Weapon.scythe.sprSlugbowHUD"]
        _state.ammo=7
        _p.wep=_scythe;_p.ntte_state=_state;_p.bwep=wep_none;_p.bntte_state=undefined
        _p.ntte_crabbone_scythe_frame=-1;_p.x=157000;_p.y=157000;_p.race=Race.Fish;_p.curse=0;_p.bcurse=0
        KeyCont.press_pick[_p.index]=false;_p.ntte_scythe_touch_frame=-1
        for(var _mode=0;_mode<3;++_mode) {
            var _raw=wep_ntte_bone_scythe+_mode
            assert(scr_weapon_get_load(_scythe)==_loads[_mode] && scr_weapon_get_load(_raw)==_loads[_mode],"Physical/raw Scythe reload must be12/18/15");
            assert(scrNTTEFullWeaponRaw(_scythe)==_raw && _p.wep==_scythe && scrNTTEFullWeaponNativeState(_scythe)==_state
                && scr_weapon_get_name(_scythe)==_scytheNames[_mode] && scr_weapon_get_text(_scythe)==_scytheTips[_mode]
                && scr_weapon_get_sprite(_scythe)==scrNTTERefSprite(_normalSprites[_mode])
                && scrNTTEFullWeaponHUDSprite(_scythe)==scrNTTERefSprite(_hudSprites[_mode])
                && scrNTTEFullWeaponSwapSound(_scythe)==_swaps[_mode] && scr_weapon_get_area(_scythe)==19,
                "Actual native Scythe physical mode change lost original source metadata or weapon/state identity")
            assert(scr_weapon_get_text(_raw)==_scytheTips[_mode] && scrNTTEFullWeaponSwapSound(_raw)==_swaps[_mode],
                "Raw native Scythe mode retained placeholder source text or generic swap sound")
            var _drop=scrWeaponPickupCreate(157500+48*_mode,157000,_scythe)
            assert(_drop.name==_scytheNames[_mode] && _drop.sprite_index==scrNTTERefSprite(_normalSprites[_mode])
                && _drop.ntte_state==_state,"Actual native mode pickup failed source name/art or shared physical state")
            if(_mode<2) {
                // PICK remains an interaction; only the dedicated mode command transforms.
                KeyCont.press_pick[_p.index]=true
                with(_p) scrNTTEFullMergedRuntimeStateStepSlots()
                assert(scrNTTEFullWeaponRaw(_scythe)==_raw && _p.wep==_scythe
                    && scrNTTEFullWeaponNativeState(_scythe)==_state && KeyCont.press_pick[_p.index],
                    "Metadata fixture PICK changed Scythe form/state or consumed interaction input")
                _p.ntte_scythe_touch_frame=current_frame
                with(_p) scrNTTEFullMergedRuntimeStateStepSlots()
                assert(scrNTTEFullWeaponRaw(_scythe)==_raw+1 && _p.wep==_scythe
                    && scrNTTEFullWeaponNativeState(_scythe)==_state && _p.ntte_scythe_touch_frame==-1,
                    "Dedicated mode command failed the genuine mounted Step or changed physical identity")
                with(_p) scrNTTEFullMergedRuntimeStateStepSlots()
                assert(scrNTTEFullWeaponRaw(_scythe)==_raw+1,
                    "One dedicated mode command advanced Scythe form more than once")
                KeyCont.press_pick[_p.index]=false
                assert(_state.ammo==7,"Metadata/source mode swap changed actual physical bone ammunition")
            }
        }
        global.ntte_full_progress.unlocks[$ "wep:scythe"]=false
        assert(scr_weapon_get_name(_scythe)=="LOCKED" && scr_weapon_get_sprite(_scythe)==scrNTTEFullWeaponLockedSprite(wep_ntte_bone_scythe)
            && scr_weapon_get_text(_scythe)==_scytheTips[2]
            && scrNTTEFullWeaponHUDSprite(_scythe)==scrNTTERefSprite(_hudSprites[2]) && scr_weapon_get_area(_scythe)==-1,
            "Source Scythe availability incorrectly hid unconditional text/HUD or exposed locked metadata")
        global.ntte_full_progress.unlocks[$ "wep:scythe"]=true
        var _encoded=json_parse(json_stringify(scrNTTEFullWeaponNativeExport()))
        scrNTTEFullWeaponNativeImport(_encoded)
        assert(scr_weapon_get_text(_scythe)==_scytheTips[2] && scr_weapon_get_name(_handles[3])=="STOLEN ARTIFACT"
            && scrNTTEFullWeaponNativeState(_scythe).ammo==7,
            "Native JSON continuation lost live artifact type or Scythe mode source metadata")
    }
    finally {
        scrNTTEFullMergedRuntimeTestCleanup(_before)
        scrNTTEFullAreaGeneratorRestore(_players);scrNTTEFullAreaGeneratorRestore(_keys);scrNTTEFullAreaGeneratorRestore(_game)
        global.ntte_full_native_weapon_models=_models;global.ntte_full_progress=_progress;random_set_seed(_seed)
    }
    scrNTTESmokeLog("FULL BONE SOURCE METADATA: canonical Crabbone type_index+raw artifact names/text/art/HUD/swap and live empty DROP restoration, actual pickup/state, source primary curse reload, genuine native Step physical Scythe three-mode metadata/pickup/availability and JSON continuation OK @"+string(30/timescale))
}

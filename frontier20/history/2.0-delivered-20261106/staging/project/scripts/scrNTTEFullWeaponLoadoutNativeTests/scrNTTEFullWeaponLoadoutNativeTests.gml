function scrNTTEFullWeaponLoadoutNativeTests() {
    assert(scrNTTESmokeEnabled(),"Weapon loadout fixture requires explicit desktop smoke harness")
    scrNTTEFullWeaponNativeInit()
    var _game=scrNTTEFullAreaGeneratorSnapshot(GameCont),_players=scrNTTEFullAreaGeneratorSnapshot(Player),
        _progress=global.ntte_full_progress,_directory=game_directory,
        _scratch=working_directory+"weapon-loadout-native-fixture/",
        _registry=global.ntte_full_native_weapon_models,_registryCount=array_length(global.ntte_full_native_weapon_models),_base=global.ntte_full_native_weapon_base,
        _cache=variable_global_exists("ntte_full_loadout_weapon_cache")?global.ntte_full_loadout_weapon_cache:undefined,
        _key="cswep_"+string(Race.Fish),_had=ds_map_exists(UberCont.saveData,_key),
        _saved=_had?UberCont.saveData[? _key]:undefined,_mywep=my_player.cwep,
        _custom=UberCont.custom,_customOptions=UberCont.custom_options
    directory_create(_scratch);game_directory=_scratch
    global.ntte_full_progress={schema:1,unlocks:{},loadouts:{},stats:{}}
    global.ntte_full_loadout_weapon_cache={}
    try {
        UberCont.custom=false
        assert(!scrNTTEFullLoadoutWeaponEligible(wep_golden_machinegun)
            && !scrNTTEFullLoadoutWeaponEligible(wep_ntte_venom_rifle)
            && !scrNTTEFullLoadoutWeaponEligible(scrNTTEFullWeaponMerge(wep_revolver,wep_shotgun)),
            "Source custom main loadout admitted ordinary native gold or nongolden mod/merge")
        var _shared={counter:11,sprite:sprLoadoutCrown},
            _stock={wep:wep_golden_machinegun,shared:_shared},_front={wep:wep_golden_shotgun,shared:_shared},
            _merged=scrNTTEFullWeaponMerge(_stock,_front)
        assert(scrNTTEFullLoadoutWeaponEligible(_merged)
            && scrNTTEFullLoadoutWeaponEligible(wep_ntte_golden_trident),
            "Source custom main must accept golden merged native weapons and golden mod raw weapon")
        var _packed=json_parse(json_stringify(scrNTTEFullLoadoutWeaponPack(_merged))),
            _copy=scrNTTEFullLoadoutWeaponUnpack(_packed),_copyFront=scrNTTEFullWeaponMergedPart(_copy)
        assert(_copy!=_merged && _copy.shared==_copyFront.shared && _copy.shared.counter==11
            && _copy.shared.sprite==sprLoadoutCrown && sprite_exists(_copy.shared.sprite),
            "Native graph main loadout copy lost merged aliases/value/source asset reference")
        _copy.shared.counter=24
        assert(_merged.shared.counter==11,"Custom main clone mutated the stored/source physical weapon")
        assert(scr_loadout_race_set_stored_weapon(Race.Fish,_merged),
            "Actual native stored-weapon setter did not route golden merged LWO into source main")
        var _preview=scrNTTEFullLoadoutWeaponStored(Race.Fish),_path=scrNTTEFullLoadoutWeaponKey(Race.Fish)
        assert(scrNTTEFullWeaponIsNative(_preview) && scrNTTEFullLoadoutWeaponStored(Race.Fish)==_preview
            && scrNTTEFullLoadoutGet(_path,"")=="main",
            "Source main missing stable native numeric menu preview/automatic selection")
        var _slots=scrNTTEFullLoadoutWeaponSlots(Race.Fish,wep_revolver,wep_golden_machinegun)
        assert(array_length(_slots)==3 && _slots[0]==wep_revolver && _slots[1]==wep_golden_machinegun
            && _slots[2]==_preview && scrNTTEFullLoadoutWeaponCurrent(Race.Fish,wep_revolver)==_preview,
            "Actual native menu slot chain lost source main or changed ordinary starter/golden slots")
        assert(scr_loadout_race_set_start_weapon(Race.Fish,_preview)
            && scrNTTEFullLoadoutGet(_path,"")=="main",
            "Actual native start-weapon selector failed source main choice")
        scr_loadout_race_set_start_weapon(Race.Fish,wep_revolver)
        assert(scrNTTEFullLoadoutGet(_path,"")==""
            && scrNTTEFullLoadoutWeaponCurrent(Race.Fish,wep_revolver)==wep_revolver,
            "Selecting ordinary native starter did not deselect custom main")
        var _portal={wep:wep_ntte_golden_teleport_gun,stored_data:{counter:8}}
        scrNTTEFullLoadoutWeaponStore(Race.Fish,_portal)
        var _p=instance_find(Player,0)
        _p.race=Race.Fish;_p.wep=wep_revolver;_p.bwep=wep_none
        _p.ntte_loadout_weapon_started=false;_p.ammo[Ammo.Bullets]=100;_p.ammo[Ammo.Energy]=5
        // Source teleport gun weapon_type is type_melee (native Ammo.None),
        // despite its energy-like artwork. It grants no energy pickups.
        var _bullets=max(0,100-3*typ_ammo[Ammo.Bullets]),_energy=5
        scrNTTEFullLoadoutWeaponGameStart()
        var _run=_p.wep,_model=scrNTTEFullWeaponModel(_run)
        scrNTTESmokeLog("WEAPON LOADOUT START DIAG "+json_stringify({wep:_run,raw:scrNTTEFullWeaponRaw(_run),
            expectedRaw:wep_ntte_golden_teleport_gun,model:_model,source:_portal,sameModel:_model==_portal,
            bullets:_p.ammo[Ammo.Bullets],expectedBullets:_bullets,energy:_p.ammo[Ammo.Energy],expectedEnergy:_energy,
            state:_p.ntte_state,canonical:scrNTTEFullWeaponNativeState(_run),
            sameState:_p.ntte_state==scrNTTEFullWeaponNativeState(_run),ts:timescale,
            types:[scr_weapon_get_type(wep_revolver),scr_weapon_get_type(wep_ntte_golden_teleport_gun)]}))
        assert(scrNTTEFullWeaponRaw(_run)==wep_ntte_golden_teleport_gun
            && _model!=_portal && _model.stored_data.counter==8
            && _p.ammo[Ammo.Bullets]==_bullets && _p.ammo[Ammo.Energy]==_energy
            && _p.ntte_state==scrNTTEFullWeaponNativeState(_run),
            "Source actual Player start replacement lost physical clone/three old-new ammo grants/canonical state")
        _model.stored_data.counter=99
        assert(!scrNTTEFullLoadoutWeaponStore(Race.Fish,_run)
            && scrNTTEFullWeaponModel(scrNTTEFullLoadoutWeaponStored(Race.Fish)).stored_data.counter==8,
            "Source same physical starting main mutated the permanent reset snapshot during generation")
        scrNTTEFullLoadoutWeaponGameStart()
        assert(_p.wep==_run && _p.ammo[Ammo.Energy]==_energy,
            "Run continuation replayed source main replacement or ammo grants")
        _p.wep=wep_revolver;_p.ntte_loadout_weapon_started=false
        scrNTTEFullLoadoutWeaponGameStart()
        assert(_p.wep!=_run && scrNTTEFullWeaponModel(_p.wep).stored_data.counter==8,
            "Next source run inherited previous run mutable main weapon fields")
        UberCont.custom=true;UberCont.custom_options=new CustomModeOptions("loadout-priority-private")
        // Run the actual GenCont.Create provider with both golden modules in
        // both slots, including physical native handles and numeric variants.
        // Two successive generation callbacks model custom level transitions.
        var _custom_before=json_stringify(global.ntte_full_progress),
            _custom_trident=scrNTTEFullWeaponNative({wep:wep_ntte_golden_trident}),
            _custom_tunneller=scrNTTEFullWeaponNative({wep:wep_ntte_golden_tunneller}),
            _custom_pairs=[[wep_ntte_golden_trident,_custom_tunneller],
                [_custom_tunneller,wep_ntte_golden_trident],
                [_custom_trident,wep_ntte_golden_tunneller],
                [wep_ntte_golden_tunneller,_custom_trident]]
        assert(scrNTTEFullProgressSave(),"Custom generation fixture baseline save failed")
        var _custom_file=_scratch+"ntte-full-progress.json",_custom_saved=file_read(_custom_file)
        for(var _case=0;_case<array_length(_custom_pairs);++_case) {
            var _pair=_custom_pairs[_case]
            _p.wep=_pair[0];_p.bwep=_pair[1]
            _p.ntte_state=scrNTTENewState(_p.wep);_p.bntte_state=scrNTTENewState(_p.bwep)
            var _front_state=_p.ntte_state,_back_state=_p.bntte_state
            repeat(2) with(GameCont) scrNTTEFullLoadoutWeaponGenerationStart()
            assert(!scrNTTEFullLoadoutWeaponStore(_p.race,_pair[0])
                && !scr_loadout_race_set_stored_weapon(_p.race,_pair[1]),
                "Custom direct/native stored-weapon entry accepted a temporary golden loadout")
            assert(_p.wep==_pair[0] && _p.bwep==_pair[1]
                && _p.ntte_state==_front_state && _p.bntte_state==_back_state
                && json_stringify(global.ntte_full_progress)==_custom_before
                && file_read(_custom_file)==_custom_saved,
                "Custom repeated GenCont generation changed held slots/state, permanent main selection/progress or saved bytes: "+string(_case))
        }
        var _explicit=[wep_shotgun,wep_none],_customState={custom_primary:true}
        for(var _case=0;_case<array_length(_explicit);++_case) {
            UberCont.custom_options.wep=_explicit[_case]
            _p.wep=_explicit[_case];_p.bwep=wep_crossbow;_p.ntte_state=_customState
            _p.ntte_loadout_weapon_started=false
            _p.ammo[Ammo.Bullets]=100;_p.ammo[Ammo.Energy]=5
            scrNTTEFullLoadoutWeaponGameStart()
            assert(_p.wep==_explicit[_case] && _p.bwep==wep_crossbow && _p.ntte_state==_customState
                && _p.ammo[Ammo.Bullets]==100 && _p.ammo[Ammo.Energy]==5
                && scrNTTEFullLoadoutGet(_path,"")=="main",
                "Stored golden main replaced explicit custom primary/empty slot or changed its ammo/secondary/state/selection")
        }
        UberCont.custom_options.wep=-1;_p.wep=wep_revolver;_p.ntte_loadout_weapon_started=false
        scrNTTEFullLoadoutWeaponGameStart()
        assert(scrNTTEFullWeaponRaw(_p.wep)==wep_ntte_golden_teleport_gun
            && scrNTTEFullWeaponModel(_p.wep).stored_data.counter==8,
            "Custom mode default primary lost saved golden starting weapon")
        UberCont.custom=false
        // A golden merge with an energy front really does use Energy; verify
        // old/new three-pickup exchange on that actual source property path.
        var _energyMain=scrNTTEFullWeaponMerge(wep_golden_machinegun,wep_golden_laser_pistol)
        assert(scrNTTEFullLoadoutWeaponStore(Race.Fish,_energyMain),"Golden energy merge loadout storage failed")
        _p.wep=wep_revolver;_p.ntte_loadout_weapon_started=false
        _p.ammo[Ammo.Bullets]=100;_p.ammo[Ammo.Energy]=5
        scrNTTEFullLoadoutWeaponGameStart()
        assert(scr_weapon_get_type(_p.wep)==Ammo.Energy && _p.ammo[Ammo.Bullets]==_bullets
            && _p.ammo[Ammo.Energy]==5+round(3*typ_ammo[Ammo.Energy]),
            "Source energy-front merge lost exact old/new three-pickup ammo grants")
        _p.wep=wep_revolver;_p.bwep=wep_ntte_golden_trident
        global.ntte_full_progress.unlocks[$ "wep:trident"]=true
        scrNTTEFullLoadoutWeaponGenerationStart()
        assert(scrNTTEFullWeaponRaw(scrNTTEFullLoadoutWeaponStored(Race.Fish))==wep_ntte_golden_trident,
            "Actual GenCont source setup failed secondary golden NTTE weapon acquisition")
        _p.wep=wep_revolver;_p.bwep=wep_none;_p.extra_weps=[wep_ntte_golden_tunneller]
        scrNTTEFullLoadoutWeaponGenerationStart()
        assert(scrNTTEFullWeaponRaw(scrNTTEFullLoadoutWeaponStored(Race.Fish))==wep_ntte_golden_trident,
            "Source custom main incorrectly stored third/extra inventory slot")
        global.ntte_full_progress.unlocks[$ "pack:red"]=true
        _p.wep=_custom_tunneller;_p.bwep=wep_none
        scrNTTEFullLoadoutWeaponGenerationStart()
        assert(scrNTTEFullWeaponAvailable(_p.wep)
            && scrNTTEFullWeaponRaw(scrNTTEFullLoadoutWeaponStored(Race.Fish))==wep_ntte_golden_tunneller,
            "Normal generation failed permanently unlocked primary native Golden Tunneller storage")
        var _file=_scratch+"weapon-loadout-roundtrip.json"
        assert(scrNTTEFullProgressSave(_file),"Custom main progress save failed")
        global.ntte_full_progress={schema:1,unlocks:{},loadouts:{},stats:{}}
        global.ntte_full_loadout_weapon_cache={}
        assert(scrNTTEFullProgressLoad(_file)
            && scrNTTEFullWeaponRaw(scrNTTEFullLoadoutWeaponStored(Race.Fish))==wep_ntte_golden_tunneller
            && scrNTTEFullLoadoutGet(_path,"")=="main",
            "Custom main JSON persistence lost independent physical weapon or menu selection")
        scrNTTEFullCustomRandomWeaponPriorityTests()
        scrNTTEFullStoredUnlockPopupTests();
    }
    finally {
        if(_had) UberCont.saveData[? _key]=_saved
        else ds_map_delete(UberCont.saveData,_key)
        my_player.cwep=_mywep
        UberCont.custom=_custom;UberCont.custom_options=_customOptions
        scrNTTEFullAreaGeneratorRestore(_game);scrNTTEFullAreaGeneratorRestore(_players)
        array_resize(_registry,_registryCount)
        global.ntte_full_native_weapon_models=_registry;global.ntte_full_native_weapon_base=_base
        global.ntte_full_loadout_weapon_cache=_cache
        global.ntte_full_progress=_progress;game_directory=_directory
    }
    scrNTTESmokeLog("FULL WEAPON LOADOUT NATIVE: custom repeated GenCont provider + direct/native setters reject both-slot numeric/native Golden Trident/Tunneller without progress/disk writes; normal golden storage/menu/graph aliases/per-run clone/ammo exchange/unlocked two-slot generation/JSON persistence OK @"+string(30/timescale))
}

function scrNTTEFullCustomRandomWeaponPriorityTests() {
    var _before=scrNTTEFullInstances(all),_players=scrNTTEFullInstances(Player),
        _game=scrNTTEFullAreaGeneratorSnapshot(GameCont),_uber=scrNTTEFullAreaGeneratorSnapshot(UberCont),
        _list=global.playerinstance_list,_count=player_count,_my=my_player,_seed=random_get_seed(),
        _types=[typ_name,typ_ammo,typ_amax],_active=scrNTTEFullArrayCopy(KeyCont.activeforever)
    try {
        for(var _i=0;_i<array_length(_players);++_i) instance_deactivate_object(_players[_i])
        var _pi=new PlayerInstance(0)
        _pi.reset_loadout();_pi.cwep=wep_shotgun;_pi.bwep=wep_crossbow
        global.playerinstance_list=array_create(INPUT_MAX_PLAYERS,undefined)
        global.playerinstance_list[0]=_pi;player_count=1;my_player=_pi
        UberCont.custom=true;UberCont.custom_options=new CustomModeOptions("random-primary-private")
        UberCont.custom_options.wep=wep_shotgun
        random_set_seed(27431)
        scrCreatePlayers(-1)
        var _body=instance_find(Player,0)
        assert(instance_exists(_body) && _pi.race!=Race.Random && _pi.randchar
            && _pi.cwep==wep_shotgun && _body.wep==wep_shotgun && _body.bwep==wep_crossbow,
            "Actual random-role player creation replaced the explicit custom primary with the role's saved/default weapon")
        scrNTTEFullLoadoutWeaponGameStart()
        assert(_body.wep==wep_shotgun && _body.bwep==wep_crossbow,
            "Actual custom random-role native start lost selected primary after saved NTTE main application")
        scrNTTESmokeLog("CUSTOM PRIMARY actual scrCreatePlayers random-role native construction and saved-main dispatch preserve explicit shotgun/crossbow")
    }
    finally {
        scrNTTEFullMergedRuntimeTestCleanup(_before)
        global.playerinstance_list=_list;player_count=_count;my_player=_my
        for(var _i=0;_i<array_length(_players);++_i) instance_activate_object(_players[_i])
        scrNTTEFullAreaGeneratorRestore(_game);scrNTTEFullAreaGeneratorRestore(_uber)
        typ_name=_types[0];typ_ammo=_types[1];typ_amax=_types[2]
        KeyCont.activeforever=_active;random_set_seed(_seed)
    }
}

// BEGIN STORED UNLOCK POPUP FOLLOWUP TESTS
// Exercise the genuine storage, room-start provider and win/loop provider.
function scrNTTEFullStoredUnlockPopupTests() {
    var _uber=scrNTTEFullAreaGeneratorSnapshot(UberCont),_players=scrNTTEFullAreaGeneratorSnapshot(Player),
        _game=scrNTTEFullAreaGeneratorSnapshot(GameCont),_queue=scrNTTEFullAreaGeneratorSnapshot(NTTEFullUnlockCont),
        _before=scrNTTEFullInstances(all),_progress=global.ntte_full_progress,
        _cache=global.ntte_full_loadout_weapon_cache,_save=UberCont.saveData,_save_bytes=ds_map_write(_save),
        _private=ds_map_create(),_mywep=my_player.cwep,_directory=game_directory,_alarms=[],
        _scratch=working_directory+"stored-unlock-popup-"+string(get_timer())+"/";
    ds_map_copy(_private,_save);UberCont.saveData=_private;
    directory_create(_scratch);game_directory=_scratch;
    global.ntte_full_progress={schema:1,unlocks:{},loadouts:{},stats:{}};
    global.ntte_full_loadout_weapon_cache={};
    for(var _a=0;_a<12;++_a) array_push(_alarms,UberCont.alarm[_a]);
    try {
        UberCont.custom=false;
        save_set_value("achievement",string(Achievement.GOOD_FIND),1);
        save_set_value("achievement",string(Achievement.GOOD_RIDDANCE),1);
        save_set_value("achievement",string(Achievement.CROWN_LIFE),1);
        var _p=instance_find(Player,0);
        _p.race=Race.Fish;_p.extra_weps=[];_p.wep=wep_golden_machinegun;_p.bwep=wep_none;
        UberCont.cwep[Race.Fish]=wep_revolver;
        UberCont.draw_unlock=false;UberCont.saving=0;
        scrPlayerTryUnlockGoldenWeapons(_p);
        assert(UberCont.cwep[Race.Fish]==wep_golden_machinegun && UberCont.draw_unlock,
            "First native golden storage lost its actual save/popup");
        _p.bwep=wep_golden_shotgun;
        for(var _i=0;_i<4;++_i) {
            UberCont.draw_unlock=false;UberCont.saving=0;
            scrPlayerTryUnlockGoldenWeapons(_p);
            assert(!UberCont.draw_unlock && UberCont.saving==0
                && UberCont.cwep[Race.Fish]==wep_golden_machinegun,
                "Room-start provider repeated same gold notification/save or alternated the secondary gold");
        }
        _p.wep=wep_golden_shotgun;_p.bwep=wep_golden_machinegun;
        scrPlayerTryUnlockGoldenWeapons(_p);
        assert(UberCont.draw_unlock && UberCont.cwep[Race.Fish]==wep_golden_shotgun,
            "A genuinely changed golden primary did not save/notify");
        _p.wep=scrNTTEFullWeaponNative({wep:wep_golden_shotgun});
        UberCont.draw_unlock=false;UberCont.saving=0;
        scrPlayerTryUnlockGoldenWeapons(_p);
        assert(!UberCont.draw_unlock && UberCont.saving==0 && UberCont.cwep[Race.Fish]==wep_golden_shotgun,
            "Same ordinary golden physical handle was treated as new permanent ownership");
        UberCont.cwep[Race.Fish]=wep_revolver;
        scrPlayerTryUnlockGoldenWeapons(_p);
        assert(UberCont.cwep[Race.Fish]==wep_golden_shotgun
            && save_get_value("cwep",string(Race.Fish))==wep_golden_shotgun,
            "Ordinary golden storage persisted a process-local physical handle");
        _p.wep=wep_revolver;_p.bwep=wep_none;_p.extra_weps=[wep_golden_machinegun];
        scrPlayerTryUnlockGoldenWeapons(_p);
        assert(UberCont.draw_unlock && UberCont.cwep[Race.Fish]==wep_golden_machinegun,
            "Extra-slot golden weapon lost its original storage eligibility");

        _p.extra_weps=[];_p.wep=wep_ntte_golden_trident;
        UberCont.draw_unlock=false;
        var _queued=instance_exists(NTTEFullUnlockCont)?array_length(NTTEFullUnlockCont.unlock):0;
        scrPlayerTryUnlockGoldenWeapons(_p);
        assert(!UberCont.draw_unlock && array_length(NTTEFullUnlockCont.unlock)==_queued+1
            && scrNTTEFullWeaponRaw(scrNTTEFullLoadoutWeaponStored(Race.Fish))==wep_ntte_golden_trident,
            "Source golden storage lost its single source notification or emitted duplicate base popup");
        _queued=array_length(NTTEFullUnlockCont.unlock);
        _p.bwep=wep_ntte_golden_tunneller;
        save_set_value("achievement",string(Achievement.GOOD_FIND),0);
        scrNTTEFullLoadoutWeaponGenerationStart();
        scrPlayerTryUnlockGoldenWeapons(_p);
        assert(save_get_value("achievement",string(Achievement.GOOD_FIND))==1,
            "Generation-prestored source gold lost its native discovery achievement");
        for(var _i=0;_i<3;++_i) {
            UberCont.draw_unlock=false;UberCont.saving=0;
            scrNTTEFullLoadoutWeaponGenerationStart();
            scrPlayerTryUnlockGoldenWeapons(_p);
            assert(!UberCont.draw_unlock && UberCont.saving==0 && array_length(NTTEFullUnlockCont.unlock)==_queued,
                "Repeated source golden storage requeued a notification/save");
        }
        _p.bwep=wep_none;
        _p.wep=scrNTTEFullWeaponNative(scrNTTEFullWeaponMerge(wep_golden_machinegun,wep_golden_shotgun));
        scrPlayerTryUnlockGoldenWeapons(_p);
        assert(!UberCont.draw_unlock && array_length(NTTEFullUnlockCont.unlock)==_queued+1,
            "First all-golden merged weapon did not produce exactly one source notification");
        _queued=array_length(NTTEFullUnlockCont.unlock);
        var _physical=scrNTTEFullWeaponModel(_p.wep);_physical.stored_counter=99;
        for(var _i=0;_i<3;++_i) scrPlayerTryUnlockGoldenWeapons(_p);
        assert(!UberCont.draw_unlock && array_length(NTTEFullUnlockCont.unlock)==_queued,
            "Mutable same-physical merged gold requeued its already stored template");

        _p.wep=wep_revolver;_p.bwep=wep_none;
        var _crown=Crown.Haste;
        UberCont.crowngot[Race.Fish,_crown]=false;GameCont.crown=_crown;
        UberCont.draw_unlock=false;
        scrUnlocksWinOrLoop();
        assert(UberCont.crowngot[Race.Fish,_crown] && UberCont.draw_unlock,
            "First native crown win/loop lost ownership or its first notification");
        for(var _i=0;_i<3;++_i) {
            UberCont.draw_unlock=false;
            scrUnlocksWinOrLoop();
            assert(!UberCont.draw_unlock,"Already-owned crown repeated its win/loop notification");
            assert(!scrCrownUnlock(Race.Fish,_crown),"Already-owned native crown returned a new award");
        }
        GameCont.crown=14;UberCont.draw_unlock=false;
        _queued=array_length(NTTEFullUnlockCont.unlock);
        save_set_value("achievement",string(Achievement.CROWN_LIFE),0);
        assert(scrNTTEFullCrownLoadoutUnlockCurrent(),"Actual pre-stored source crown did not unlock");
        scrUnlocksWinOrLoop();
        assert(scrNTTEFullUnlockGet("loadout:crown:"+scrNTTEFullCrownKey(14))
            && save_get_value("achievement",string(Achievement.CROWN_LIFE))==1
            && !UberCont.draw_unlock && array_length(NTTEFullUnlockCont.unlock)==_queued+1,
            "First source crown did not emit exactly one source ownership notice");
        _queued=array_length(NTTEFullUnlockCont.unlock);
        for(var _i=0;_i<3;++_i) scrUnlocksWinOrLoop();
        assert(!UberCont.draw_unlock && array_length(NTTEFullUnlockCont.unlock)==_queued
            && !scrCrownUnlock(Race.Fish,14),"Already-owned source crown repeated its notice");
        UberCont.custom=true;_p.wep=wep_ntte_golden_tunneller;GameCont.crown=Crown.Death;
        var _owned=json_stringify(global.ntte_full_progress),_gold=UberCont.cwep[Race.Fish];
        scrPlayerTryUnlockGoldenWeapons(_p);scrUnlocksWinOrLoop();
        assert(json_stringify(global.ntte_full_progress)==_owned && UberCont.cwep[Race.Fish]==_gold,
            "Custom win/room providers awarded permanent golden/crown ownership");
    }
    finally {
        scrNTTEFullMergedRuntimeTestCleanup(_before);
        scrNTTEFullAreaGeneratorRestore(_queue);scrNTTEFullAreaGeneratorRestore(_game);
        scrNTTEFullAreaGeneratorRestore(_players);scrNTTEFullAreaGeneratorRestore(_uber);
        UberCont.saveData=_save;ds_map_destroy(_private);my_player.cwep=_mywep;
        for(var _a=0;_a<12;++_a) UberCont.alarm[_a]=_alarms[_a];
        global.ntte_full_progress=_progress;global.ntte_full_loadout_weapon_cache=_cache;game_directory=_directory;
        assert(ds_map_write(_save)==_save_bytes,"Stored notification fixture changed real permanent progress");
    }
    scrNTTESmokeLog("FULL STORED UNLOCK POPUPS: actual golden room-provider and crown win/loop-provider first/change/unchanged; double-gold priority, physical-ID normalization, extra slot, source+merged single notice, custom exclusions OK @"+string(30/timescale));
}

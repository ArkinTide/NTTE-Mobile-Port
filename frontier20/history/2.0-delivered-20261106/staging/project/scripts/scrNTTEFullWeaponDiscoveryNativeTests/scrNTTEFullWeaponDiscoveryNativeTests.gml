function scrNTTEFullWeaponDiscoveryNativeTests() {
    assert(scrNTTESmokeEnabled(),"Weapon discovery requires the explicit desktop fixture")
    var _before=scrNTTEFullInstances(all),_players=scrNTTEFullAreaGeneratorSnapshot(Player),
        _game=scrNTTEFullAreaGeneratorSnapshot(GameCont),_back=scrNTTEFullAreaGeneratorSnapshot(BackCont),
        _uber=scrNTTEFullAreaGeneratorSnapshot(UberCont),_menus=scrNTTEFullAreaGeneratorSnapshot(MenuOptions),
        _had_progress=variable_global_exists("ntte_full_progress"),
        _progress=_had_progress?global.ntte_full_progress:undefined,
        _progressSerialized=_had_progress?json_stringify(_progress):"",
        _had_models=variable_global_exists("ntte_full_native_weapon_models"),
        _models=_had_models?global.ntte_full_native_weapon_models:undefined,
        _model_values=_had_models?scrNTTEFullArrayCopy(_models):[],
        _had_model_base=variable_global_exists("ntte_full_native_weapon_base"),
        _model_base=_had_model_base?global.ntte_full_native_weapon_base:undefined,
        _had_debug=variable_global_exists("__debug_infammo"),
        _debug=_had_debug?global.__debug_infammo:false,_seed=random_get_seed(),_directory=game_directory,
        _scratch=working_directory+"weapon-discovery-native-fixture/",
        _hidden=scrNTTEFullInstances([GenCont,LevCont])
    directory_create(_scratch);game_directory=_scratch
    global.ntte_full_progress={schema:1,unlocks:{},loadouts:{},stats:{}}
    scrGameCustomModeReset()
    for(var _i=0;_i<array_length(_hidden);++_i) instance_deactivate_object(_hidden[_i])
    try {
        var _p=instance_find(Player,0),_table=scrNTTEFullWeaponDropTable(),_avail_count=0
        with(Player) {wep=wep_none;bwep=wep_none;speed=0;visible=false;}
        GameCont.ntte_kills_last=GameCont.kills
        for(var _i=0;_i<array_length(_table);++_i) {
            var _record=_table[_i],_gate=scrNTTEFullWeaponAvailabilityRecord(_record.weapon)
            if(is_undefined(_gate)) continue
            _avail_count++
            assert(!scrNTTEFullWeaponAvailable(_record.weapon)
                && scr_weapon_get_name(_record.weapon)=="LOCKED"
                && scr_weapon_get_sprite(_record.weapon)==scrNTTERefSprite("Weapon."+_record.raw+".sprWepLocked")
                && scr_weapon_get_area(_record.weapon)==-1,"Locked registered source module leaked name/art/drop: "+_record.raw)
        }
        assert(_avail_count==28,"Explicit registered weapon_avail definitions changed")
        assert(scrNTTEFullWeaponAvailable(wep_revolver) && scrNTTEFullWeaponAvailable(wep_ntte_teleport_gun)
            && scrNTTEFullWeaponAvailable(wep_ntte_energy_bat)
            && is_undefined(scrNTTEFullWeaponAvailabilityRecord(wep_ntte_bone)),
            "Source availability was invented for a module with no weapon_avail definition")
        // Build handles while locked, then change the real mode flag. Public
        // metadata must follow the mode immediately instead of cached LOCKED.
        var _custom_bubble=scrNTTEFullWeaponNative({wep:wep_ntte_bubble_rifle}),
            _custom_gold=scrNTTEFullWeaponNative({wep:wep_ntte_golden_tunneller}),
            _custom_scythe=scrNTTEFullWeaponNative({wep:wep_ntte_bone_scythe}),
            _custom_before=json_stringify(global.ntte_full_progress)
        assert(scr_weapon_get_name(_custom_bubble)=="LOCKED" && scr_weapon_get_name(_custom_scythe)=="LOCKED",
            "Custom transition fixture did not begin with genuinely unowned native handles")
        assert(scrNTTEFullProgressSave(),"Custom discovery fixture baseline save failed")
        var _saved_custom=file_read(_scratch+"ntte-full-progress.json")
        UberCont.custom_options=new CustomModeOptions("locked-weapon-fixture")
        UberCont.custom=true
        var _selector=instance_create(0,0,CustomModeWeaponSelector)
        with(_selector) event_user(1)
        for(var _weapon=wep_ntte_rogue_carbine;_weapon<=wep_ntte_last;++_weapon)
            assert(array_contains(_selector.groups[_selector.group_count-1],_weapon),
                "Actual custom selector omitted a native NTTE weapon: "+string(_weapon))
        for(var _i=0;_i<array_length(_table);++_i) {
            var _record=_table[_i]
            if(is_undefined(scrNTTEFullWeaponAvailabilityRecord(_record.weapon))) continue
            assert(scrNTTEFullWeaponAvailable(_record.weapon) && scr_weapon_get_name(_record.weapon)!="LOCKED"
                && scr_weapon_get_sprite(_record.weapon)!=scrNTTEFullWeaponLockedSprite(_record.weapon),
                "Custom selector retained a locked name/art/availability: "+_record.raw)
        }
        assert(scr_weapon_get_name(_custom_bubble)!="LOCKED" && scr_weapon_get_name(_custom_scythe)=="BONE SCYTHE"
            && scr_weapon_get_name(_custom_gold)!="LOCKED"
            && scr_weapon_get_sprite(_custom_bubble)==scrNTTERefSprite("Weapon.bubble rifle.sprWep")
            && scr_weapon_get_sprite(_custom_gold)!=scrNTTEFullWeaponLockedSprite(_custom_gold)
            && scrNTTEFullWeaponDropArea("bubble rifle",_p)==-1
            && scrNTTEFullWeaponDropArea("scythe",_p)==-1,
            "Custom mode failed live native/golden/bone metadata or bypassed permanent natural-drop gates")
        // Exercise the real selector's primary/secondary/proto keys.
        scrCustomParamChange(_selector.get_weapon_key(),wep_ntte_sawblade_gun)
        _selector.choosing_secondary=true
        scrCustomParamChange(_selector.get_weapon_key(),_custom_gold)
        _selector.choosing_secondary=false;_selector.choosing_proto=true
        scrCustomParamChange(_selector.get_weapon_key(),_custom_scythe)
        assert(scrCustomParam("wep")==wep_ntte_sawblade_gun && scrCustomParam("bwep")==_custom_gold
            && scrCustomParam("protowep")==_custom_scythe,"Custom selector lost an unowned loadout slot")
        instance_destroy(_selector,false)
        _p.x=91000;_p.y=91000;_p.gunangle=0;_p.accuracy=0;_p.infammo=0;_p.wepangle=-1
        global.__debug_infammo=false
        _p.wep=scrCustomParam("wep");_p.bwep=scrCustomParam("bwep")
        _p.ntte_state=scrNTTENewState(_p.wep);_p.bntte_state=scrNTTENewState(_p.bwep)
        var _custom_state=_p.ntte_state,_custom_bstate=_p.bntte_state
        GameCont.crown=NTTEFullCrown.Bonus
        with(GameCont) event_perform(ev_step,ev_step_end)
        with(_p) assert(!scrNTTEFullDiscoveryPlayerEndStep(),"Direct custom discovery reported a permanent transition")
        assert(_p.wep==wep_ntte_sawblade_gun && _p.bwep==_custom_gold
            && _p.ntte_state==_custom_state && _p.bntte_state==_custom_bstate
            && scrNTTEFullWeaponStateSprite(_p.wep,_custom_state)!=scrNTTEFullWeaponLockedSprite(_p.wep),
            "Genuine custom End Step Boneified the selected weapon/state or kept locked held art")
        var _old_discs=scrNTTEFullInstances(NTTEFullBatDisc),_custom_disc=noone
        with(_p) scrFire(wep,false)
        with(NTTEFullBatDisc) if(array_get_index(_old_discs,id)<0) _custom_disc=id
        assert(instance_exists(_custom_disc) && _custom_disc.creator==_p && _custom_disc.state==_custom_state
            && _custom_state.ammo==2 && _custom_state.outstanding==1,
            "Real scrFire failed unowned custom weapon's physical projectile/magazine")
        with(_custom_disc) scrNTTEFullBatDiscCleanup()
        instance_destroy(_custom_disc,false)
        _p.wep=_custom_scythe;_p.ntte_state=scrNTTENewState(_custom_scythe)
        var _scythe_state=_p.ntte_state,_old_slashes=instance_number(NTTEFullBoneSlash)
        _scythe_state.ammo=20
        with(_p) scrFire(wep,false)
        assert(instance_number(NTTEFullBoneSlash)==_old_slashes+1 && _scythe_state.combo==1,
            "Unowned native custom scythe did not execute real melee fire")
        with(_p) scrNTTEFullScytheSwap()
        var _old_arrows=instance_number(NTTEFullBoneArrow)
        assert(_p.wep==_custom_scythe && _p.ntte_state==_scythe_state
            && scrNTTEFullWeaponRaw(_p.wep)==wep_ntte_bone_shotbow
            && scr_weapon_get_name(_p.wep)=="BONE SHOTBOW" && _scythe_state.ammo==20,
            "Custom scythe could not transform its actual held handle/state")
        with(_p) scrFire(wep,false)
        assert(instance_number(NTTEFullBoneArrow)==_old_arrows+3 && _scythe_state.ammo==15,
            "Unowned custom Shotbow did not execute real three-arrow fire/exact bone cost")
        with(_p) scrNTTEFullScytheSwap()
        assert(scrNTTEFullWeaponRaw(_p.wep)==wep_ntte_bone_slugbow
            && scr_weapon_get_name(_p.wep)=="BONE SLUGBOW" && _p.ntte_state==_scythe_state,
            "Custom scythe failed its second form or replaced physical state")
        assert(json_stringify(global.ntte_full_progress)==_custom_before
            && file_read(_scratch+"ntte-full-progress.json")==_saved_custom,
            "Custom selector/End Step/fire/transformation wrote permanent unlocks, found keys, crown achievement or progress")
        // Leave the very same physical handles equipped and reset through the
        // real normal-mode transition. No metadata/model re-registration.
        scrGameCustomModeReset();GameCont.crown=0
        assert(!scrNTTEFullWeaponAvailable(_custom_bubble) && !scrNTTEFullWeaponAvailable(_custom_scythe)
            && !scrNTTEFullWeaponAvailable(_custom_gold)
            && scr_weapon_get_name(_custom_bubble)=="LOCKED" && scr_weapon_get_name(_custom_scythe)=="LOCKED"
            && scr_weapon_get_name(_custom_gold)=="LOCKED"
            && scr_weapon_get_sprite(_custom_bubble)==scrNTTEFullWeaponLockedSprite(_custom_bubble)
            && scr_weapon_get_sprite(_custom_scythe)==scrNTTEFullWeaponLockedSprite(_custom_scythe)
            && scr_weapon_get_sprite(_custom_gold)==scrNTTEFullWeaponLockedSprite(_custom_gold)
            && scrNTTEFullWeaponDropArea("bubble rifle",_p)==-1 && scrNTTEFullWeaponDropArea("scythe",_p)==-1,
            "Custom-to-normal transition retained temporary availability/name/art/natural drops")
        with(GameCont) event_perform(ev_step,ev_step_end)
        assert(_p.wep==wep_ntte_bone && _p.bwep==wep_ntte_bone
            && json_stringify(global.ntte_full_progress)==_custom_before,
            "Normal End Step retained an unowned custom handle or contaminated permanent discovery")
        // The source checks outer raw only. A front weapon does not cause a
        // plain stock to Boneify; an unavailable outer stock still does.
        var _front=scrNTTEFullWeaponNative({wep:wep_ntte_bubble_rifle}),
            _outer_stock=scrNTTEFullWeaponNative(scrNTTEFullWeaponMerge(wep_revolver,scrNTTEFullWeaponModel(_front))),
            _outer_locked=scrNTTEFullWeaponNative(scrNTTEFullWeaponMerge(wep_ntte_bubble_rifle,wep_revolver))
        assert(scrNTTEFullWeaponAvailable(_outer_stock) && !scrNTTEFullWeaponAvailable(_outer_locked),
            "Source outer-only availability accidentally recursed through merged fronts")
        _p.wep=_outer_locked;_p.bwep=wep_ntte_golden_tunneller
        _p.ntte_state=scrNTTENewState(_outer_locked);_p.bntte_state=scrNTTENewState(_p.bwep)
        _p.ntte_state.ammo=42;_p.bntte_state.ammo=99
        _p.x=91000;_p.y=91000;_p.gunangle=17;_p.depth=-5
        var _effects=instance_number(NTTEFullGunWarrantEmpty),_smoke=instance_number(Smoke),
            _before_smoke=scrNTTEFullInstances(Smoke)
        GameCont.crown=NTTEFullCrown.Bonus
        // Execute the genuine GameCont End Step with its registered provider.
        with(GameCont) event_perform(ev_step,ev_step_end)
        assert(_p.wep==wep_ntte_bone && _p.bwep==wep_ntte_bone
            && _p.ntte_state.weapon==wep_ntte_bone && _p.bntte_state.weapon==wep_ntte_bone
            && _p.ntte_state.ammo==1 && _p.bntte_state.ammo==1
            && abs(_p.wepangle)==120 && abs(_p.bwepangle)==120,
            "Actual End Step failed independent physical-slot Boneify/state reset/source slot angles")
        assert(instance_number(NTTEFullGunWarrantEmpty)==_effects+2 && instance_number(Smoke)==_smoke+4,
            "Actual two-slot Boneify omitted per-slot warrant/two-Smoke source effects")
        var _new=scrNTTEFullInstances(Smoke)
        for(var _i=0;_i<array_length(_new);++_i) if(array_get_index(_before_smoke,_new[_i])<0)
            assert(_new[_i].depth==_p.depth-1 && abs(_new[_i].speed-2.5*timescale)<=0.001,
                "Boneify Smoke lost source logical speed/depth")
        assert(scrNTTEFullUnlockGet("pack:crown") && global.ntte_full_progress.stats[$ "found:bonus.crown"]
            && !scrNTTEFullValue(global.ntte_full_progress.stats,"found:bubble rifle.wep",false),
            "Crown discovery or unavailable-weapon found-stat exclusion changed")
        _p.wep=_outer_stock;_p.bwep=wep_ntte_teleport_gun
        var _untouched=scrNTTENewState(_outer_stock)
        _p.ntte_state=_untouched;_p.bntte_state=scrNTTENewState(_p.bwep)
        with(GameCont) event_perform(ev_step,ev_step_end)
        assert(_p.wep==_outer_stock && _p.ntte_state==_untouched && _p.bwep==wep_ntte_teleport_gun
            && !scrNTTEFullValue(global.ntte_full_progress.stats,"found:teleport gun.wep",false),
            "Source modules without availability were replaced or incorrectly tracked as discovered")
        // Trident's individually earned unlock is an explicit alternative to
        // the Coast pack; golden variants share availability but never drop.
        global.ntte_full_progress.unlocks[$ "wep:trident"]=true
        assert(scrNTTEFullWeaponAvailable(wep_ntte_trident) && scrNTTEFullWeaponAvailable(wep_ntte_golden_trident)
            && scr_weapon_get_area(wep_ntte_trident)==7 && scr_weapon_get_area(wep_ntte_golden_trident)==-1,
            "Trident fallback unlock or golden no-natural-drop rule changed")
        _p.wep=wep_ntte_golden_trident;_p.bwep=wep_ntte_bone_slugbow
        global.ntte_full_progress.unlocks[$ "wep:scythe"]=true
        with(GameCont) event_perform(ev_step,ev_step_end)
        assert(_p.wep==wep_ntte_golden_trident && _p.bwep==wep_ntte_bone_slugbow
            && global.ntte_full_progress.stats[$ "found:trident.wep"] && global.ntte_full_progress.stats[$ "found:scythe.wep"],
            "Golden/mode aliases lost source module raw found-key or were Boneified despite unlock")
        var _context={x:91000,y:91000,curse:0},_identity=function(_n){return _n-1}
        GameCont.ntte_can_spawn_ultra_quasar_rifle=true
        assert(scrNTTEFullWeaponDropSelect(["ultra quasar rifle"],0,30,_context,noone,_identity)==wep_screwdriver,
            "Natural source selector admitted Ultra Quasar without Beetle race unlock")
        global.ntte_full_progress.unlocks[$ "race:beetle"]=true
        assert(scrNTTEFullWeaponDropSelect(["ultra quasar rifle"],0,30,_context,noone,_identity)==wep_ntte_ultra_quasar_rifle
            && scrNTTEFullWeaponAvailable(wep_ntte_beetle_blaster),"Beetle ownership failed actual source selector/weapon availability")
        GameCont.ntte_can_spawn_ultra_quasar_rifle=false
        assert(scrNTTEFullWeaponDropSelect(["ultra quasar rifle"],0,30,_context,noone,_identity)==wep_screwdriver,
            "Beetle unlock bypassed initial-weapon-chest Ultra Quasar source gate")
        // Ordinary pack gates must react immediately without re-registering
        // tables or recaching a physical model's display name/sprite.
        global.ntte_full_progress.unlocks[$ "pack:oasis"]=true
        assert(scr_weapon_get_name(wep_ntte_bubble_rifle)!="LOCKED"
            && scr_weapon_get_sprite(wep_ntte_bubble_rifle)==scrNTTERefSprite("Weapon.bubble rifle.sprWep")
            && scrNTTEFullWeaponDropSelect(["bubble rifle"],0,30,_context,noone,_identity)==wep_ntte_bubble_rifle,
            "Live pack unlock failed public metadata or actual source drop selection")
        _p.wep=wep_ntte_bubble_rifle;_p.bwep=wep_ntte_beetle_blaster
        GameCont.crown=NTTEFullCrown.Crime;with(GameCont) event_perform(ev_step,ev_step_end)
        GameCont.crown=NTTEFullCrown.Red;with(GameCont) event_perform(ev_step,ev_step_end)
        var _path=_scratch+"discovery-roundtrip.json"
        assert(scrNTTEFullProgressSave(_path),"Discovery progress file save failed")
        global.ntte_full_progress={schema:1,unlocks:{},loadouts:{},stats:{}}
        assert(scrNTTEFullProgressLoad(_path) && scrNTTEFullUnlockGet("pack:crown")
            && global.ntte_full_progress.stats[$ "found:bonus.crown"] && global.ntte_full_progress.stats[$ "found:crime.crown"]
            && global.ntte_full_progress.stats[$ "found:red.crown"] && global.ntte_full_progress.stats[$ "found:beetle pistol.wep"]
            && global.ntte_full_progress.stats[$ "found:bubble rifle.wep"],"Actual JSON persistence lost found source keys/crown pack ownership")
        scrNTTESmokeLog("PASS custom selector all NTTE IDs, real EndStep/physical scrFire/scythe forms without permanent progress, immediate custom-to-normal gates/Boneify; normal outer-only discovery, aliases/Trident/race/pack/initial-chest natural gates, all3 crowns and JSON")
    }
    finally {
        var _all=scrNTTEFullInstances(all)
        for(var _i=array_length(_all)-1;_i>=0;--_i) if(array_get_index(_before,_all[_i])<0 && instance_exists(_all[_i])) instance_destroy(_all[_i],false)
        for(var _i=0;_i<array_length(_hidden);++_i) instance_activate_object(_hidden[_i])
        scrNTTEFullAreaGeneratorRestore(_game);scrNTTEFullAreaGeneratorRestore(_players);scrNTTEFullAreaGeneratorRestore(_back)
        scrNTTEFullAreaGeneratorRestore(_uber);scrNTTEFullAreaGeneratorRestore(_menus)
        if(_had_models) {
            array_resize(_models,array_length(_model_values))
            for(var _i=0;_i<array_length(_model_values);++_i) _models[_i]=_model_values[_i]
            global.ntte_full_native_weapon_models=_models
        }
        else variable_struct_remove(global,"ntte_full_native_weapon_models")
        if(_had_model_base) global.ntte_full_native_weapon_base=_model_base
        else variable_struct_remove(global,"ntte_full_native_weapon_base")
        if(_had_debug) global.__debug_infammo=_debug
        else variable_struct_remove(global,"__debug_infammo")
        if(_had_progress) global.ntte_full_progress=_progress
        else variable_struct_remove(global,"ntte_full_progress")
        game_directory=_directory;random_set_seed(_seed)
        if(_had_models) assert(global.ntte_full_native_weapon_models==_models
            && array_length(global.ntte_full_native_weapon_models)==array_length(_model_values),
            "Weapon discovery fixture changed original native registry identity/length")
        if(_had_progress) assert(global.ntte_full_progress==_progress
            && json_stringify(global.ntte_full_progress)==_progressSerialized,
            "Weapon discovery fixture changed original permanent progress identity/contents")
        assert(variable_global_exists("ntte_full_native_weapon_models")==_had_models
            && variable_global_exists("ntte_full_native_weapon_base")==_had_model_base
            && variable_global_exists("__debug_infammo")==_had_debug
            && variable_global_exists("ntte_full_progress")==_had_progress,
            "Weapon discovery fixture failed to restore optional global existence")
    }
}

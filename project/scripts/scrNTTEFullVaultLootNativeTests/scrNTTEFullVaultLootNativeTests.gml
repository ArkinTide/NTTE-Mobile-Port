function scrNTTEFullVaultLootNativeTests() {
    var _before=scrNTTEFullInstances(all),_players=scrNTTEFullAreaGeneratorSnapshot(Player),
        _game=scrNTTEFullAreaGeneratorSnapshot(GameCont),_back=scrNTTEFullAreaGeneratorSnapshot(BackCont),
        _music=scrNTTEFullAreaGeneratorSnapshot(MusCont),_uber=scrNTTEFullAreaGeneratorSnapshot(UberCont),
        _frame=current_frame,_seed=random_get_seed(),_skills=ds_list_create()
    GameCont.skills=_skills;GameCont.ntte_full_native_skill_counts={};GameCont.crown=0
    GameCont.area=area_desert;GameCont.subarea=1;GameCont.loops=0;GameCont.hard=5;GameCont.crownvisits=2;current_frame=2
    try {
        var _p=instance_find(Player,0)
        _p.x=63100;_p.y=63000;_p.hp=_p.max_hp;_p.race=Race.Fish
        var _chest=instance_create(63000,63000,NTTEFullBuriedVaultChest)
        assert(instance_is(_chest,NTTEFullCustomChest) && _chest.num==3 && _chest.spr_shadow==-1
            && _chest.sprite_index==scrNTTERefSprite("BuriedVaultChest"),
            "BuriedVaultChest lost actual CustomChest/source3goodies/no-shadow constructor")
        var _wraps=instance_number(NTTEFullBackpackPickup),_lids=instance_number(NTTEFullBuriedVaultChestDebris)
        with(_chest) scrNTTEFullCustomChestOpen(_p)
        assert(!instance_exists(_chest) && instance_number(NTTEFullBackpackPickup)==_wraps+3
            && instance_number(NTTEFullBuriedVaultChestDebris)==_lids+1,
            "Real BuriedVaultChest opening did not emit exactly3airborne real chests and source ballistic lid")
        var _wrappers=scrNTTEFullInstances(NTTEFullBackpackPickup),_seen=0
        for(var _i=0;_i<array_length(_wrappers);++_i) if(array_get_index(_before,_wrappers[_i])<0) {
            var _wrapper=_wrappers[_i],_item=_wrapper.target
            assert(instance_exists(_item) && (instance_is(_item,AmmoChest) || instance_is(_item,WeaponChest)
                || instance_is(_item,HealthChest) || instance_is(_item,NTTEFullBackpack) || instance_is(_item,NTTEFullOrchidChest))
                && _item.mask_index==mskNone && _wrapper.z>0 && _wrapper.zfriction==0.6
                && _wrapper.speed>=1.3*timescale && _wrapper.speed<=1.7*timescale,
                "BuriedVaultChest airborne reward lost source equal-pool real chest, disabled collision or1.5motion/.6gravity")
            _seen+=1
        }
        assert(_seen==3,"BuriedVaultChest native wrapper fixture missed source loot")
        ds_list_add(_skills,mut_open_mind);GameCont.ntte_full_native_skill_counts[$ string(mut_open_mind)]=-3
        _chest=instance_create(63000,63100,NTTEFullBuriedVaultChest)
        _wraps=instance_number(NTTEFullBackpackPickup);_lids=instance_number(NTTEFullBuriedVaultChestDebris)
        with(_chest) scrNTTEFullCustomChestOpen(_p)
        assert(instance_number(NTTEFullBackpackPickup)==_wraps && instance_number(NTTEFullBuriedVaultChestDebris)==_lids+1,
            "BuriedVaultChest OpenMind-3 should cancel all goodies but retain source ballistic lid")
        GameCont.ntte_full_native_skill_counts[$ string(mut_open_mind)]=0
        // Existing CrownPed means source CustomObject identity; none means
        // genuine CrownPed subtype. Preserve preexisting resources explicitly.
        var _crowns=scrNTTEFullInstances(CrownPed)
        with(CrownPed) instance_deactivate_object(id)
        var _ped=instance_create(63200,63000,NTTEFullBuriedVaultPedestal)
        assert(instance_is(_ped,CrownPed) && _ped.object_index==NTTEFullBuriedVaultCrownPed
            && _ped.spawn>=3 && _ped.spawn<=4 && _ped.mask_index==mskSalamander
            && _ped.spawn_time==0 && array_length(_ped.spawn_inst)==0,
            "Vault pedestal without CrownPed lost genuine CrownPed identity or source1..2+vaultvisits guardian count")
        var _second=instance_create(63400,63000,NTTEFullBuriedVaultPedestal)
        assert(!instance_is(_second,CrownPed) && _second.object_index==NTTEFullBuriedVaultPedestal,
            "Vault pedestal with existing CrownPed incorrectly added a second native CrownPed")
        // Explicit source selector branches through the real loot constructor.
        var _types=["BuriedVaultChest",BigWeaponChest,ProtoChest,ProtoStatue,HostileHorror]
        UberCont.protowep=wep_rusty_revolver
        for(var _i=0;_i<array_length(_types);++_i) {
            _second.x=63600+200*_i;_second.y=63000;_second.spawn=4
            if(instance_exists(_second.target)) instance_destroy(_second.target,false)
            var _bandits=instance_number(Bandit),_clear=instance_number(PortalClear),_radCount=instance_number(Rad)
            with(_second) scrNTTEFullBuriedVaultPedestalLoot(_types[_i])
            var _loot=_second.target
            assert(instance_exists(_loot) && instance_number(Rad)>=_radCount+15,
                "Vault pedestal source loot branch lost its actual target or15loose rads")
            if(_types[_i]=="BuriedVaultChest") assert(instance_is(_loot,NTTEFullBuriedVaultChest),"Vault pedestal replaced source custom reward")
            if(_types[_i]==BigWeaponChest) assert(instance_is(_loot,BigWeaponChest),"Vault pedestal lost real BigWeaponChest")
            if(_types[_i]==ProtoChest) assert(instance_is(_loot,ProtoChest) && scrNTTEFullWeaponHasMerge(_loot.wep)
                && _loot.sprite_index==scrNTTERefSprite("ProtoChestMerge"),"Vault pedestal rusty ProtoChest must hold actual merged reward")
            if(_types[_i]==ProtoStatue) assert(_loot.y==_second.y-10 && _loot.spr_shadow==-1
                && instance_number(Bandit)==_bandits && instance_number(PortalClear)==_clear,
                "Vault pedestal ProtoStatue lost12px lift/hidden shadow or kept native new bandits/PortalClear")
            if(_types[_i]==HostileHorror) assert(instance_is(_loot,HostileHorror) && _second.spawn==0,
                "Vault pedestal real HostileHorror reward did not waive guardians")
        }
        // Source selector excludes duplicate ProtoChest and subarea1 statues.
        var _proto=instance_create(64600,63000,ProtoChest)
        repeat(80) {
            var _selected=noone
            with(_second) _selected=scrNTTEFullBuriedVaultPedestalSelect()
            assert(_selected!=ProtoChest && _selected!=ProtoStatue,"Vault pedestal selector lost native Proto uniqueness/subarea2 condition")
        }
        // Hold source vault chest centered until removed, then animate and
        // perform exact30/10 logical-tick real guardian sequence.
        _ped.x=64800;_ped.y=63000
        _ped.target=instance_create(_ped.x,_ped.y,NTTEFullBuriedVaultChest)
        _ped.target.speed=4*timescale;_ped.image_index=1
        with(_ped) event_perform(ev_step,ev_step_normal)
        assert(_ped.image_index==0 && _ped.target.x==_ped.x && _ped.target.y==_ped.y && _ped.target.speed==0,
            "Vault pedestal did not hold actual buried chest centered/motionless before taking loot")
        instance_destroy(_ped.target,false);_ped.image_index=_ped.image_number-0.1
        with(_ped) event_perform(ev_step,ev_step_normal)
        assert(_ped.image_speed==0 && _ped.image_index==_ped.image_number-1,"Vault pedestal loot release animation did not finish")
        _ped.spawn=2;_ped.spawn_time=0
        var _found=scrNTTEFullValue(GameCont,"buried_vaults",0)
        with(_ped) event_perform(ev_step,ev_step_normal)
        assert(_ped.spawn_time==30 && GameCont.buried_vaults==_found+1,"Vault pedestal guardian start lost30tick countdown or discovery count")
        instance_create(_ped.x-16,_ped.y-16,Floor);instance_create(_ped.x+48,_ped.y-16,Floor)
        var _guards=instance_number(CrownGuardian)
        repeat(round(29/timescale)) with(_ped) event_perform(ev_step,ev_step_normal)
        assert(instance_number(CrownGuardian)==_guards,"Vault pedestal emitted guardian before30source ticks")
        repeat(round(1/timescale)) with(_ped) event_perform(ev_step,ev_step_normal)
        assert(instance_number(CrownGuardian)==_guards+1 && _ped.spawn==1 && _ped.spawn_time==10
            && array_length(_ped.spawn_inst)==1 && instance_is(_ped.spawn_inst[0],CrownGuardian)
            && _ped.spawn_inst[0].spr_idle==sprCrownGuardianAppear,
            "Vault pedestal first guardian lost actual CrownGuardian, source appearance/count/timing")
        repeat(round(10/timescale)) with(_ped) event_perform(ev_step,ev_step_normal)
        assert(instance_number(CrownGuardian)==_guards+2 && _ped.spawn==0 && array_length(_ped.spawn_inst)==2,
            "Vault pedestal second guardian lost10logical tick spacing or exact total")
        for(var _i=0;_i<array_length(_crowns);++_i) instance_activate_object(_crowns[_i])
    }
    finally {
        // Always reactivate source crowns if an assertion interrupted the test.
        instance_activate_object(CrownPed)
        var _all=scrNTTEFullInstances(all)
        for(var _i=array_length(_all)-1;_i>=0;--_i) if(array_get_index(_before,_all[_i])<0 && instance_exists(_all[_i])) instance_destroy(_all[_i],false)
        scrNTTEFullAreaGeneratorRestore(_players);scrNTTEFullAreaGeneratorRestore(_game);scrNTTEFullAreaGeneratorRestore(_back)
        scrNTTEFullAreaGeneratorRestore(_music);scrNTTEFullAreaGeneratorRestore(_uber)
        current_frame=_frame;random_set_seed(_seed);ds_list_destroy(_skills)
    }
    scrNTTESmokeLog("FULL VAULT LOOT NATIVE: real3+OpenMind airborne chest/lid, exact CrownPed identity, source weighted loot/native merged ProtoChest/clean ProtoStatue/Horror, centered hold/release/30+10tick real guardian sequence/discovery OK @"+string(30/timescale))
}

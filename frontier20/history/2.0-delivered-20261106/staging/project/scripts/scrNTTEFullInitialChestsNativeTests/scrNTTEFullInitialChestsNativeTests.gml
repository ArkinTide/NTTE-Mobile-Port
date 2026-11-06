function scrNTTEFullInitialChestsNativeTests() {
    assert(scrNTTESmokeEnabled(),"Initial system chests require explicit desktop fixture")
    scrNTTEFullFloorInit()
    var _before=scrNTTEFullInstances(all),_players=scrNTTEFullAreaGeneratorSnapshot(Player),
        _game=scrNTTEFullAreaGeneratorSnapshot(GameCont),_seed=random_get_seed(),
        _hidden=scrNTTEFullInstances([AmmoChest,Mimic,WeaponChest,RadChest,RogueChest,HealthChest,SuperMimic,GenCont,Floor,Wall,InvisiWall]),
        _floorstate=[global.ntte_full_floor_aw,global.ntte_full_floor_ah,global.ntte_full_floor_ax,global.ntte_full_floor_ay]
    for(var _i=0;_i<array_length(_hidden);++_i) instance_deactivate_object(_hidden[_i])
    try {
        var _p=instance_find(Player,0)
        with(Player) {wep=wep_revolver;bwep=wep_none;hp=max_hp;}
        // Palace final suppresses native random AmmoChest substitutions,
        // giving a genuine, stable physical constructor for source filtering.
        GameCont.area=area_palace;GameCont.subarea=GameCont.maxsubarea;GameCont.crown=NTTEFullCrown.Crime
        var _ammo=instance_create(91000,91000,AmmoChest),_mimic=instance_create(91064,91000,Mimic),
            _idpd=instance_create(91128,91000,IDPDChest),_cats=instance_number(NTTEFullCatChest)
        assert(instance_exists(_ammo) && scrNTTEFullCrimeInitialChests()
            && !instance_exists(_ammo) && !instance_exists(_mimic) && instance_exists(_idpd)
            && instance_number(NTTEFullCatChest)==_cats+2,
            "Source Crime ammo-category all-instance replacement lost Mimic/exact-IDPD exclusion")
        instance_destroy(_idpd,false)
        var _weapon=instance_create(91300,91000,WeaponChest),_big=instance_create(91400,91000,CursedBigChest),
            _giant=instance_create(91500,91000,GiantWeaponChest),_bats=instance_number(NTTEFullBatChest)
        _weapon.curse=1;_big.curse=1
        assert(scrNTTEFullCrimeInitialChests() && !instance_exists(_weapon) && !instance_exists(_big)
            && instance_exists(_giant) && instance_number(NTTEFullBatChest)==_bats+2,
            "Source Crime weapon-category lost real giant exclusion or multi-chest replacement")
        var _normalbat=instance_nearest(91300,91000,NTTEFullBatChest),_bigbat=instance_nearest(91400,91000,NTTEFullBatChest)
        assert(!_normalbat.big && _normalbat.curse==1 && _bigbat.big && _bigbat.curse==1,
            "Source Crime Bat chest lost original big/cursed per-physical-chest state")
        instance_destroy(_giant,false)
        var _rad=instance_create(91600,91000,RadChest),_hp=instance_create(91700,91000,HealthChest),
            _super=instance_create(91800,91000,SuperMimic),_rats=instance_number(NTTEFullRatChest)
        assert(scrNTTEFullCrimeInitialChests() && !instance_exists(_rad) && !instance_exists(_hp)
            && !instance_exists(_super) && instance_number(NTTEFullRatChest)==_rats+3,
            "Source Crime rad-category lost Health/SuperMimic alternatives")
        // Red checks both outer slots, independently of crown. The first
        // Rogue canister remains, with one additional floor-aligned red chest.
        GameCont.crown=Crown.None;_p.bwep=wep_ntte_annihilator
        var _f=scrNTTEFullFloorSet(92000,92000,true),_r=instance_create(92000,92000,RogueChest),
            _r2=instance_create(92200,92000,RogueChest),_r3=instance_create(92400,92000,RogueChest),
            _redrad=instance_create(92600,92000,RadChest),_redcount=instance_number(NTTEFullRedAmmoChest)
        scrNTTEFullFloorSet(91968,92000,true);scrNTTEFullFloorSet(92032,92000,true)
        scrNTTEFullFloorSet(92000,91968,true);scrNTTEFullFloorSet(92000,92032,true)
        // `with` traversal can differ from instance_find order as well as
        // constructor order. Record the exact traversal the source uses.
        var _first_rogue=noone
        with(RogueChest) {_first_rogue=id;break;}
        random_set_seed(5)
        var _red_result=scrNTTEFullRedInitialChests()
        scrNTTESmokeLog("Red exact-with diagnosis result="+string(_red_result)+" first="+string(_first_rogue)+" alive="+string(instance_exists(_first_rogue))+" rad="+string(instance_exists(_redrad))+" count="+string(instance_number(NTTEFullRedAmmoChest)-_redcount)+" survivors="+string(scrNTTEFullInstances(RogueChest)))
        assert(_red_result && instance_exists(_first_rogue) && !instance_exists(_redrad)
            && instance_number(NTTEFullRedAmmoChest)>=_redcount+2,
            "Source Red secondary-slot scan lost rad replacement or first-Rogue floor-room spawn")
        assert(is_undefined(global.ntte_full_floor_aw) && is_undefined(global.ntte_full_floor_ah),
            "Source Red floor-room alignment was not reset")
        // Bonus level-start conversion differs from the later Crown pickup
        // replacement bind: Health stays Health and unmodified pickups are
        // merely marked, preventing the bind from replacing them again.
        GameCont.crown=NTTEFullCrown.Bonus
        var _a=instance_create(93000,92000,AmmoChest),_h=instance_create(93100,92000,HealthChest),
            _m=instance_create(93200,92000,Mimic),_s=instance_create(93300,92000,SuperMimic),
            _pickup=instance_create(93400,92000,HPPickup),_excluded=instance_create(93500,92000,IDPDChest),
            _a0=instance_number(NTTEFullBonusAmmoChest),_h0=instance_number(NTTEFullBonusHealthChest),
            _m0=instance_number(NTTEFullBonusAmmoMimic),_s0=instance_number(NTTEFullBonusHealthMimic)
        assert(scrNTTEFullBonusInitialChests(false,1)==4 && !instance_exists(_a) && !instance_exists(_h)
            && !instance_exists(_m) && !instance_exists(_s) && instance_exists(_pickup) && _pickup.bonus_pickup_check
            && instance_exists(_excluded) && _excluded.bonus_pickup_check
            && instance_number(NTTEFullBonusAmmoChest)==_a0+1 && instance_number(NTTEFullBonusHealthChest)==_h0+1
            && instance_number(NTTEFullBonusAmmoMimic)==_m0+1 && instance_number(NTTEFullBonusHealthMimic)==_s0+1,
            "Source Bonus initial conversion lost distinct HP/ammo/mimic paths or marked-pickup/IDPD exclusion")
        assert(scrNTTEFullBonusInitialChests(false,1)==0,"Already-checked initial pickups were processed twice")
        scrNTTESmokeLog("PASS source initial Crime 3 real category chains/exclusions/Bat big+curse, Red both-slot/Rad/first-Rogue-floor alignment, initial Bonus distinct Health/Ammo/Mimic paths and one-time flags")
    }
    finally {
        var _all=scrNTTEFullInstances(all)
        for(var _i=array_length(_all)-1;_i>=0;--_i) if(array_get_index(_before,_all[_i])<0 && instance_exists(_all[_i])) instance_destroy(_all[_i],false)
        for(var _i=0;_i<array_length(_hidden);++_i) instance_activate_object(_hidden[_i])
        scrNTTEFullAreaGeneratorRestore(_game);scrNTTEFullAreaGeneratorRestore(_players)
        scrNTTEFullFloorSetAlign(_floorstate[0],_floorstate[1],_floorstate[2],_floorstate[3]);random_set_seed(_seed)
    }
}

function scrNTTEFullBackpackNativeTests() {
    var _before=scrNTTEFullInstances(all),_players=scrNTTEFullAreaGeneratorSnapshot(Player),
        _game=scrNTTEFullAreaGeneratorSnapshot(GameCont),_back=scrNTTEFullAreaGeneratorSnapshot(BackCont),
        _frame=current_frame,_seed=random_get_seed(),_skills=ds_list_create()
    GameCont.skills=_skills;GameCont.ntte_full_native_skill_counts={};GameCont.crown=0;current_frame=2
    try {
        var _p=instance_find(Player,0)
        _p.x=59000;_p.y=59000;_p.race=Race.Fish;_p.wep=wep_revolver;_p.bwep=wep_none;_p.hp=_p.max_hp
        var _bag=instance_create(59032,59000,NTTEFullBackpack)
        assert(_bag.num==2 && _bag.raddrop==8 && _bag.ally==0 && !_bag.curse,
            "Backpack constructor lost original two goodie rolls/eight rads/default no ally or crown-none curse")
        var _weps=instance_number(WepPickup),_rads=instance_number(Rad),_wraps=instance_number(NTTEFullBackpackPickup)
        with(_bag) scrNTTEFullCustomChestOpen(_p)
        assert(!instance_exists(_bag) && GameCont.ntte_backpack_opened && instance_number(WepPickup)==_weps+1
            && instance_number(Rad)==_rads+8 && instance_number(NTTEFullBackpackPickup)>=_wraps+2,
            "Actual Backpack opening lost remembered state/real merged weapon/eight rads/airborne native goodie wrappers")
        var _items=scrNTTEFullInstances(WepPickup),_weapon=_items[array_length(_items)-1].wep
        assert(scrNTTEFullWeaponHasMerge(_weapon)==true && scrNTTEFullWeaponRaw(_weapon)!=scrNTTEFullWeaponRaw(scrNTTEFullWeaponMergedPart(_weapon)),
            "Backpack weapon reward is not an actual two-part merged weapon with selector exclusion")
        _bag=instance_create(59100,59000,NTTEFullBackpack);_bag.num=0;_bag.raddrop=0;_bag.ally=2;_bag.curse=false
        var _allies=instance_number(NTTEFullCrystalAlly),_fire=instance_number(NTTEFullCrystalFireWeapon)
        _weps=instance_number(WepPickup)
        with(_bag) scrNTTEFullCustomChestOpen(_p)
        assert(instance_number(NTTEFullCrystalAlly)==_allies+2 && instance_number(NTTEFullCrystalFireWeapon)==_fire+2
            && instance_number(WepPickup)==_weps,
            "Backpack ally2 failed two real independently armed native Allies or also left their weapons as floor pickups")
        var _controllers=scrNTTEFullInstances(NTTEFullCrystalFireWeapon),_controlled=0
        for(var _i=0;_i<array_length(_controllers);++_i) {
            var _controller=_controllers[_i]
            if(instance_exists(_controller.creator) && _controller.creator.creator==_p) {
                with(_controller) scrNTTEFullCrystalFireWeaponStep()
                assert(scrNTTEFullWeaponHasMerge(_controller.wep)==true && _controller.creator.wep==_controller.wep,
                    "Backpack Ally weapon did not mount its actual physical merged firing controller")
                _controlled+=1
            }
        }
        assert(_controlled>=2,"Backpack Ally controllers lost opener ownership")
        // Real CursedAmmoChest releases ten source-configured1.5x ammo items,
        // each suspended in the existing native airborne wrapper lifecycle.
        var _chest=instance_create(59200,59000,NTTEFullCursedAmmoChest),_ammo=instance_number(NTTEFullSourceAmmoPickup)
        _wraps=instance_number(NTTEFullBackpackPickup)
        assert(_chest.num==10,"CursedAmmoChest source GetLoaded/default quantity changed")
        with(_chest) scrNTTEFullCustomChestOpen(_p)
        assert(instance_number(NTTEFullSourceAmmoPickup)==_ammo+10 && instance_number(NTTEFullBackpackPickup)==_wraps+10,
            "CursedAmmoChest did not emit exactly ten actual source ammo pickups with individual airborne wrappers")
        _items=scrNTTEFullInstances(NTTEFullSourceAmmoPickup)
        var _item=_items[array_length(_items)-1]
        assert(_item.ntte_full_ammo_num==1.5 && _item.cursed && _item.sprite_index==sprCursedAmmo
            && _item.alarm[0]<=150 && _item.alarm[0]>=120 && _item.mask_index==mskNone,
            "Cursed ammo lost original1.5x grant, short lifetime or airborne disabled collision")
        _p.ammo[Ammo.Bullets]=0
        var _expected=min(typ_amax[Ammo.Bullets],round(typ_ammo[Ammo.Bullets]*1.5))
        with(_p) with(_item) event_perform(ev_collision,Player)
        assert(!instance_exists(_item) && _p.ammo[Ammo.Bullets]==_expected,
            "Actual configured native ammo collision ignored original num1.5 or failed native type/cap handling")
        // The bag refreshes Strong Spirit recharge eligibility independently
        // of its item rolls and real weapon reward.
        GameCont.ntte_full_native_skill_counts[$ string(mut_strong_spirit)]=1;ds_list_add(_skills,mut_strong_spirit)
        _p.can_spirit=false;_bag=instance_create(59300,59000,NTTEFullBackpack);_bag.num=0;_bag.raddrop=0
        with(_bag) scrNTTEFullCustomChestOpen(_p)
        var _refill=false
        with(StrongSpiritRefill) if(creator==_p) {_refill=true;break}
        assert(_p.can_spirit && _refill,"Backpack did not restore native Strong Spirit recharge eligibility and real refill effect")
    }
    finally {
        var _all=scrNTTEFullInstances(all)
        for(var _i=array_length(_all)-1;_i>=0;--_i) if(array_get_index(_before,_all[_i])<0 && instance_exists(_all[_i])) instance_destroy(_all[_i],false)
        scrNTTEFullAreaGeneratorRestore(_players);scrNTTEFullAreaGeneratorRestore(_game);scrNTTEFullAreaGeneratorRestore(_back)
        current_frame=_frame;random_set_seed(_seed);ds_list_destroy(_skills)
    }
    scrNTTESmokeLog("FULL BACKPACK NATIVE: real opening/merged selector2parts/exclusions/eight rads/airborne goodies, independently armed native Ally2, real CursedAmmoChest10/individual airborne1.5x short-life ammo/native collection caps, Strong Spirit recharge+effect OK @"+string(30/timescale))
}

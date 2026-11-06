function scrNTTEFullCrabboneSupportNativeTests() {
    var _before=scrNTTEFullInstances(all),_players=scrNTTEFullAreaGeneratorSnapshot(Player),
        _game=scrNTTEFullAreaGeneratorSnapshot(GameCont),_seed=random_get_seed(),_skills=ds_list_create()
    GameCont.skills=_skills;GameCont.ntte_full_native_skill_counts={};GameCont.crown=crwn_none
    GameCont.ultra_got[Race.Robot,UltraSkill.Regurgitate]=0
    try {
        var _p=instance_find(Player,0)
        _p.x=6200;_p.y=6200;_p.xprevious=_p.x;_p.yprevious=_p.y;_p.visible=true;_p.speed=0
        _p.race=Race.Fish;_p.wep=wep_ntte_bone;_p.bwep=wep_shotgun;_p.extra_weps=[]
        _p.ntte_state=scrNTTENewState(wep_ntte_bone);_p.bntte_state=scrNTTENewState(wep_shotgun)
        // Execute the real AmmoPickup collision and native scrAmmoDecideType,
        // in both physical slot orders. The bone must redirect its type to
        // the other gun rather than introduce random fallback ammo grants.
        for(var _slot=0;_slot<2;++_slot) {
            if(_slot==1) with(_p) scrSwapWeps(false)
            repeat(6) {
                _p.ammo=array_create(Ammo.NUM_AMMO_TYPES,0)
                var _pickup=instance_create(_p.x,_p.y,AmmoPickup)
                with(_pickup) event_perform(ev_collision,Player)
                assert(!instance_exists(_pickup) && _p.ammo[Ammo.Shells]>0,
                    "Actual AmmoPickup failed Crabbone other-slot shell delegation")
                for(var _type=Ammo.Bullets;_type<Ammo.NUM_AMMO_TYPES;++_type)
                    if(_type!=Ammo.Shells) assert(_p.ammo[_type]==0,
                        "Actual AmmoPickup Crabbone slot fell through to unrelated random ammunition")
            }
        }
        scrNTTEFullMergedRuntimeTestCleanup(_before)
        // Real Robot eat keeps the base single-weapon grant, then adds the
        // original callback's two extra physical bones. No Regurgitate means
        // exactly three ammo pickups; two Throne Butts yield nine.
        _p.wep=wep_ntte_bone;_p.bwep=wep_shotgun;_p.ntte_state=scrNTTENewState(wep_ntte_bone)
        _p.ntte_state.ammo=3;_p.race=Race.Robot;_p.hp=8;_p.max_hp=8
        var _ammo=instance_number(AmmoPickup),_hp=instance_number(HPPickup)
        with(_p) scrRobotEat(wep)
        assert(instance_number(AmmoPickup)==_ammo+3 && instance_number(HPPickup)==_hp
            && _p.ntte_state.ammo==3,"Actual Robot stack callback lost one reward per physical bone")
        scrNTTEFullMergedRuntimeTestCleanup(_before)
        ds_list_add(_skills,mut_throne_butt);GameCont.ntte_full_native_skill_counts[$ string(mut_throne_butt)]=2
        _ammo=instance_number(AmmoPickup)
        with(_p) scrRobotEat(wep)
        assert(instance_number(AmmoPickup)==_ammo+9,"Actual stacked Robot Throne Butt did not grant three pickups per bone")
        // Count descriptors are the same source values drawn by the real HUD
        // hook, including inactive-secondary tint and source amax/amin fields.
        var _info=scrNTTEFullCrabboneHUDInfo(_p,_p.wep,0)
        assert(_info.text=="3" && _info.color==c_white,"Stacked primary Crabbone HUD count changed")
        _p.race=Race.Fish;_p.bwep=wep_ntte_bone;_p.bntte_state=scrNTTENewState(wep_ntte_bone)
        _p.bntte_state.ammo=7
        _info=scrNTTEFullCrabboneHUDInfo(_p,_p.bwep,1)
        assert(_info.text=="7" && _info.color==c_ltgray,"Crabbone HUD borrowed primary state or lost inactive tint")
        _p.bntte_state.ammo=1
        assert(is_undefined(scrNTTEFullCrabboneHUDInfo(_p,_p.bwep,1)),"Single bone wrongly drew stacked-only source ammo HUD")
        var _model=scrNTTEFullCrabboneCreateModel(0,2)
        _model.amax=20;_model.amin=5
        _info=scrNTTEFullCrabboneHUDInfo(_p,_model,0)
        assert(_info.text=="2" && _info.color==c_red,"Artifact source model amax/amin HUD fields were ignored")
        scrNTTESmokeLog("PASS Crabbone actual native AmmoPickup both-slot delegation, real Robot3-bone eat/TB2 x9 rewards, exact physical HUD counts/tints/model thresholds")
    }
    finally {
        scrNTTEFullMergedRuntimeTestCleanup(_before)
        scrNTTEFullAreaGeneratorRestore(_players);scrNTTEFullAreaGeneratorRestore(_game)
        random_set_seed(_seed);ds_list_destroy(_skills)
    }
}

function scrNTTEFullRobotEatNativeTests() {
    assert(scrNTTESmokeEnabled(),"Robot meals require the explicit desktop fixture")
    scrNTTEFullWeaponNativeInit()
    var _before=scrNTTEFullInstances(all),_players=scrNTTEFullAreaGeneratorSnapshot(Player),
        _game=scrNTTEFullAreaGeneratorSnapshot(GameCont),_uber=scrNTTEFullAreaGeneratorSnapshot(UberCont),
        _pickups=scrNTTEFullAreaGeneratorSnapshot(WepPickup),_portals=scrNTTEFullAreaGeneratorSnapshot(Portal),
        _keys=scrNTTEFullAreaGeneratorSnapshot(KeyCont),_seed=random_get_seed(),_skills=ds_list_create(),
        _registry=global.ntte_full_native_weapon_models,_registry_count=array_length(_registry)
    GameCont.skills=_skills;GameCont.ntte_full_native_skill_counts={};GameCont.crown=crwn_none
    GameCont.ultra_got[Race.Robot,UltraSkill.Regurgitate]=0
    try {
        var _p=instance_find(Player,0)
        _p.x=7200;_p.y=7200;_p.xprevious=_p.x;_p.yprevious=_p.y;_p.speed=0
        _p.visible=true;_p.race=Race.Robot;_p.hp=8;_p.max_hp=8;_p.curse=false;_p.gunangle=25
        _p.wep=wep_ntte_bone_scythe;_p.bwep=wep_revolver
        _p.ntte_state=scrNTTENewState(_p.wep);_p.bntte_state=scrNTTENewState(_p.bwep)
        // The real active-power entry consumes the original physical weapon
        // and refunds exactly three real, pickable Crabbones.
        KeyCont.press_spec[_p.index]=true
        var _bones=instance_number(WepPickup)
        with(_p) scrPowers()
        KeyCont.press_spec[_p.index]=false
        assert(_p.wep==wep_revolver && _p.bwep==wep_none && instance_number(WepPickup)==_bones+3,
            "Actual Robot active power did not consume Scythe/refund three Crabbones")
        with(WepPickup) if(array_get_index(_before,id)<0)
            assert(wep==wep_ntte_bone && sprite_index==scrNTTERefSprite("Bone")
                && name==scr_weapon_get_name(wep_ntte_bone) && type==Ammo.None && abs(x-_p.x)<=0.001 && abs(y-_p.y)<=0.001,
                "Scythe refund changed source bone identity or eater position")
        scrNTTEFullMergedRuntimeTestCleanup(_before)
        var _modes=[wep_ntte_bone_shotbow,wep_ntte_bone_slugbow]
        for(var _mode=0;_mode<array_length(_modes);++_mode) {
            _bones=instance_number(WepPickup)
            with(_p) scrRobotEat(_modes[_mode])
            assert(instance_number(WepPickup)==_bones+3,"Alternate Scythe mode lost original three-bone meal refund")
            scrNTTEFullMergedRuntimeTestCleanup(_before)
        }
        // A physical merged stock has one callback; its mounted front is not
        // another consumed weapon. Red getter still has its own source routing.
        var _front=scrNTTEFullWeaponNative({wep:wep_ntte_bone_scythe}),
            _model=scrNTTEFullWeaponNative(scrNTTEFullWeaponMerge(wep_revolver,scrNTTEFullWeaponModel(_front)))
        _bones=instance_number(WepPickup)
        with(_p) scrRobotEat(_model)
        assert(instance_number(WepPickup)==_bones,"Robot meal recursively ate an unconsumed merge front")
        scrNTTEFullMergedRuntimeTestCleanup(_before)
        var _red=instance_number(NTTEFullRedAmmoPickup),_clones=instance_number(NTTEFullCrystalClone)
        with(_p) scrRobotEat(wep_ntte_entangler)
        assert(instance_number(NTTEFullRedAmmoPickup)==_red+1 && instance_number(NTTEFullCrystalClone)==_clones+1,
            "Manual Entangler meal lost source clone plus one physical Red reward")
        scrNTTEFullMergedRuntimeTestCleanup(_before)
        _red=instance_number(NTTEFullRedAmmoPickup)
        with(_p) scrRobotEat(wep_ntte_annihilator)
        assert(instance_number(NTTEFullRedAmmoPickup)==_red+1,"Two-cost Red gun must still refund exactly one Red pickup")
        scrNTTEFullMergedRuntimeTestCleanup(_before)
        // Each actual armed PortalBullet Destroy teleports its real owner.
        var _teleports=[wep_ntte_teleport_gun,wep_ntte_golden_teleport_gun,wep_ntte_super_teleport_gun]
        for(var _i=0;_i<array_length(_teleports);++_i) {
            _p.x=7200;_p.y=7200;_p.speed=0
            var _bullets=instance_number(NTTEFullPortalBullet)
            with(_p) scrRobotEat(_teleports[_i])
            var _distance=point_distance(7200,7200,_p.x,_p.y)
            assert(instance_number(NTTEFullPortalBullet)==_bullets && _distance>=31.999 && _distance<=181,
                "Robot teleport meal failed real animation/Destroy owner travel: distance="+string(_distance))
            scrNTTEFullMergedRuntimeTestCleanup(_before)
        }
        _p.x=7200;_p.y=7200;_p.speed=0
        _p.wep=wep_ntte_ultra_quasar_rifle;_p.ntte_state=scrNTTENewState(_p.wep)
        var _old=instance_create(_p.x,_p.y,NTTEFullQuasarBeam)
        _old.ntte_full_scale_goal=1.7;_p.ntte_state.beam=_old
        ds_list_add(_skills,mut_throne_butt,mut_laser_brain)
        GameCont.ntte_full_native_skill_counts[$ string(mut_throne_butt)]=2
        GameCont.ntte_full_native_skill_counts[$ string(mut_laser_brain)]=3
        var _rings=instance_number(NTTEFullQuasarRing),_debris=instance_number(ScrapBossCorpse)
        with(_p) scrRobotEat(wep)
        var _ring=instance_find(NTTEFullQuasarRing,instance_number(NTTEFullQuasarRing)-1)
        assert(instance_number(NTTEFullQuasarRing)==_rings+1 && _ring.creator==_p && _ring.team==_p.team
            && _ring.image_yscale==0 && _ring.ntte_full_follow && _ring.ntte_full_ultra
            && abs(_ring.ntte_full_scale_goal-1.7)<=0.001 && abs(_ring.ntte_full_ring_size-1.728)<=0.001
            && _ring.ntte_full_shrink_delay==300 && _ring.damage==12 && _ring.mask_index==mskExploder,
            "Ultra meal ring lost physical beam inheritance, TB2 size, original base damage or owner")
        assert(instance_number(ScrapBossCorpse)==_debris+sprite_get_number(scrNTTERefSprite("UltraQuasarBlasterEat")),
            "Ultra meal did not emit one original corpse per debris frame")
        with(ScrapBossCorpse) if(array_get_index(_before,id)<0)
            assert(speed>=4*timescale-0.001 && speed<=8*timescale+0.001,
                "Ultra meal debris speed changed source logical-time scaling")
        scrNTTEFullMergedRuntimeTestCleanup(_before)
        ds_list_clear(_skills);GameCont.ntte_full_native_skill_counts={}
        // Real Portal Collision with a nearer decoy portal and TWO Robots.
        // Source custom callback happens once at the actual portal; native
        // per-Robot base pickup rewards retain their existing auto-collection.
        with(WepPickup) visible=false
        with(Player) race=Race.Fish
        _p.race=Race.Robot
        var _auto_weapons=[wep_ntte_bone_scythe,wep_ntte_entangler,wep_ntte_teleport_gun,
            wep_ntte_super_teleport_gun,wep_ntte_ultra_quasar_rifle,wep_ntte_annihilator]
        for(var _i=0;_i<array_length(_auto_weapons);++_i) {
            _p.x=7200;_p.y=7200;_p.visible=true
            var _p2=instance_create(7201,7201,Player)
            _p2.race=Race.Robot;_p2.hp=8;_p2.max_hp=8
            var _decoy=instance_create(7200,7200,Portal),_portal=instance_create(9000,9200,Portal)
            _portal.endgame=100;_portal.close=false
            GameCont.ultra_got[Race.Robot,UltraSkill.Regurgitate]=0
            GameCont.ultra_got[Race.Robot,UltraSkill.RefinedTaste]=1
            var _item=instance_create(7200,7200,WepPickup)
            _item.wep=_auto_weapons[_i];_item.visible=true;_item.curse=false;_item.persistent=false
            _bones=instance_number(WepPickup);_red=instance_number(NTTEFullRedAmmoPickup)
            _clones=instance_number(NTTEFullCrystalClone);_rings=instance_number(NTTEFullQuasarRing)
            with(_p) with(_portal) event_perform(ev_collision,Player)
            assert(_portal.close && _portal.endgame==30,"Real Portal entry did not run auto-eating lifecycle")
            var _refund=_auto_weapons[_i]==wep_ntte_bone_scythe?3:0,
                _red_refund=(_auto_weapons[_i]==wep_ntte_entangler || _auto_weapons[_i]==wep_ntte_annihilator)?1:0
            assert(instance_number(WepPickup)==_bones+_refund
                && instance_number(NTTEFullRedAmmoPickup)==_red+_red_refund
                && instance_number(NTTEFullCrystalClone)==_clones && instance_number(NTTEFullQuasarRing)==_rings,
                "Portal meal duplicated co-op callback or failed original Portal-only suppression")
            with(WepPickup) if(id!=_item && array_get_index(_before,id)<0)
                assert(wep==wep_ntte_bone && abs(x-_portal.x)<=0.001 && abs(y-_portal.y)<=0.001,
                    "Auto Scythe refund guessed nearest portal instead of actual Collision owner")
            with(NTTEFullRedAmmoPickup) if(array_get_index(_before,id)<0)
                assert(abs(x-_portal.x)<=0.001 && abs(y-_portal.y)<=0.001,
                    "Auto Red refund used Robot/nearest Portal coordinates")
            assert(instance_number(NTTEFullPortalBullet)==0 && abs(_p.x-7200)<=0.001 && abs(_p.y-7200)<=0.001,
                "Portal auto-eating incorrectly teleported a Robot")
            scrNTTEFullMergedRuntimeTestCleanup(_before)
        }
        scrNTTESmokeLog("PASS Robot real power Scythe3 refunds/modes, outer-only merge meal, Red one-per-gun, armed teleport Destroy, Ultra physical ring/TB2/debris, exact Portal Collision co-op once/suppression/coordinates")
    }
    finally {
        scrNTTEFullMergedRuntimeTestCleanup(_before)
        scrNTTEFullAreaGeneratorRestore(_players);scrNTTEFullAreaGeneratorRestore(_game);scrNTTEFullAreaGeneratorRestore(_uber)
        scrNTTEFullAreaGeneratorRestore(_pickups);scrNTTEFullAreaGeneratorRestore(_portals);scrNTTEFullAreaGeneratorRestore(_keys)
        while(array_length(global.ntte_full_native_weapon_models)>_registry_count)
            array_pop(global.ntte_full_native_weapon_models)
        random_set_seed(_seed);ds_list_destroy(_skills)
    }
}

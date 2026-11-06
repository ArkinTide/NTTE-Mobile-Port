function scrNTTEFullLightringWeaponTests() {
    var _before=scrNTTEFullInstances(all),_players=scrNTTEFullAreaGeneratorSnapshot(Player),
        _game=scrNTTEFullAreaGeneratorSnapshot(GameCont),_back=scrNTTEFullAreaGeneratorSnapshot(BackCont),
        _seed=random_get_seed(),_frame=current_frame,_skills=ds_list_create(),_p=instance_find(Player,0)
    GameCont.skills=_skills;GameCont.ntte_full_native_skill_counts={};current_frame=8
    try {
        _p.x=6000;_p.y=6000;_p.gunangle=45;_p.accuracy=0;_p.infammo=0
        _p.race=Race.Fish;_p.ammo=array_create(Ammo.NUM_AMMO_TYPES,100)
        _p.wep=wep_ntte_lightring_launcher;_p.ntte_state=scrNTTENewState(_p.wep)
        var _generic=instance_number(NTTELightningDisc)
        with(_p) scrFire(wep,true)
        var _shots=scrNTTEFullBubbleWeaponTestNew(_before,NTTEFullLightningDisc),_shot=_shots[0]
        assert(array_length(_shots)==1 && instance_number(NTTELightningDisc)==_generic
            && _shot.creator==_p && _shot.team==_p.team && _shot.ntte_full_primary
            && _shot.direction==45 && _shot.speed==10*timescale && _shot.ntte_full_charge==1
            && _shot.ntte_full_charge_speed==2 && _shot.ntte_full_stretch==1
            && _shot.ntte_full_radius==12 && _shot.ntte_full_super==-1
            && _p.ammo[Ammo.Energy]==97 && _p.reload==37,
            "Lightring Launcher ordinary fire retained old class or lost actual source defaults/cost3/load37")
        _p.wep=wep_ntte_lightring_cannon;_p.ntte_state=scrNTTENewState(_p.wep)
        _p.ammo=array_create(Ammo.NUM_AMMO_TYPES,100)
        var _now=scrNTTEFullInstances(all)
        with(_p) scrFire(wep,true)
        _shots=scrNTTEFullBubbleWeaponTestNew(_now,NTTEFullLightningDisc);_shot=_shots[0]
        assert(array_length(_shots)==1 && _shot.creator==_p && _shot.speed==14*timescale
            && _shot.ntte_full_charge==2.5 && _shot.ntte_full_charge_speed==1
            && _shot.ntte_full_stretch==1.2 && _shot.ntte_full_radius==16 && _shot.ntte_full_super==1.2
            && _p.ammo[Ammo.Energy]==92 && _p.reload==90,
            "Lightring Cannon ordinary fire lost source super/charge/stretch/radius or cost8/load90")
        // Source secondary property reaches actual physical follow behavior.
        _now=scrNTTEFullInstances(all)
        with(_p) scrNTTEFullLightringWeaponFire(wep_ntte_lightring_launcher,false)
        _shots=scrNTTEFullBubbleWeaponTestNew(_now,NTTEFullLightningDisc)
        assert(array_length(_shots)==1 && !_shots[0].ntte_full_primary,"Lightring secondary slot was discarded")
        var _npc=instance_create(6200,6200,Bandit),_players_count=instance_number(Player)
        _npc.gunangle=90;_npc.team=team_enemy
        var _result=scrNTTEFullActorFire(_npc,wep_ntte_lightring_cannon,90,0,false)
        _shots=scrNTTEFullMergedRuntimeTestShots(_result.shots,NTTEFullLightningDisc)
        assert(array_length(_shots)==1 && _shots[0].creator==_npc && _shots[0].team==team_enemy
            && _shots[0].direction==90 && instance_number(Player)==_players_count,
            "NPC Lightring lost actual constructor/owner/team or leaked synchronous proxy")
        // Actual replacement uses the source object table, not the old disc.
        var _weapon=scrNTTEFullWeaponMerge(wep_revolver,wep_ntte_lightring_launcher),_handle=scrNTTEFullWeaponNative(_weapon)
        _p.wep=_handle;_p.ntte_state=scrNTTEFullWeaponNativeState(_weapon)
        _p.ammo=array_create(Ammo.NUM_AMMO_TYPES,100)
        _result=scrNTTEFullMergedRuntimePlayerFire(_p,_handle,{creator:_p})
        _shots=scrNTTEFullMergedRuntimeTestShots(_result.shots,NTTEFullLightningDisc)
        assert(array_length(_shots)==1 && _shots[0].creator==_p
            && variable_instance_exists(_shots[0],"temerge_vars_list") && _p.wep==_handle,
            "Merged ordinary Lightring failed actual source projectile inheritance or mounted inventory")
    } finally {
        scrNTTEFullMergedRuntimeTestCleanup(_before)
        scrNTTEFullAreaGeneratorRestore(_players);scrNTTEFullAreaGeneratorRestore(_game)
        scrNTTEFullAreaGeneratorRestore(_back);ds_list_destroy(_skills)
        random_set_seed(_seed);current_frame=_frame
    }
    scrNTTESmokeLog("FULL LIGHTRING ORDINARY FIRE: source launcher/cannon actual native class/defaults/cost/load, secondary slot, durable NPC owner and actual merged front inheritance OK @"+string(30/timescale))
}

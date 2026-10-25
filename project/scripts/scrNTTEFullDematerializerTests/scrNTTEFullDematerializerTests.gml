function scrNTTEFullDematerializerTests() {
    var _before=scrNTTEFullInstances(all),_players=scrNTTEFullAreaGeneratorSnapshot(Player),
        _game=scrNTTEFullAreaGeneratorSnapshot(GameCont),_back=scrNTTEFullAreaGeneratorSnapshot(BackCont),
        _seed=random_get_seed(),_tick=current_frame,_p=instance_find(Player,0),_skills=ds_list_create()
    GameCont.skills=_skills;GameCont.ntte_full_native_skill_counts={};current_frame=8
    try {
        _p.x=84000;_p.y=84000;_p.team=team_player;_p.gunangle=0;_p.accuracy=0
        _p.race=Race.Fish;_p.infammo=0;_p.wep=wep_ntte_dematerializer
        _p.ntte_state=scrNTTENewState(_p.wep);_p.ammo=array_create(Ammo.NUM_AMMO_TYPES,100)
        _p.electroplasma_last=noone;_p.electroplasma_side=1
        var _generic=instance_number(NTTEAttack)
        with(_p) scrFire(wep,true)
        var _shots=scrNTTEFullBubbleWeaponTestNew(_before,NTTEFullElectroPlasma)
        assert(array_length(_shots)==1 && instance_number(NTTEAttack)==_generic
            && _p.ammo[Ammo.Energy]==100 && _p.reload==18,
            "Dematerializer literal source scrFire lost actual Electro, cost0/load18 or retained generic attack")
        var _shot=_shots[0]
        assert(_shot.creator==_p && _shot.team==team_player && _shot.speed==0
            && _shot.hyper=="true" && _shot.ntte_full_tether_inst==_p
            && _shot.ntte_full_tether_range==1200 && _shot.ntte_full_wave==0
            && _shot.ntte_demat_lifetime==19 && _p.electroplasma_last==_shot && _p.electroplasma_side==-1
            && abs(_shot.x-(_p.x+480))<=0.008,
            "Dematerializer source default-zero speed/hyper/range/owner/tether/lifetime/480move changed")
        _p.x+=32;_p.y+=24;_p.gunangle=90
        with(_p) scrNTTEFullDematerializerStep(true)
        assert(abs(_shot.x-_p.x)<=0.008 && abs(_shot.y-(_p.y-480))<=0.008
            && abs(_shot.ntte_demat_lifetime-(19-timescale))<0.0001
            && _shot.direction==90 && _shot.image_angle==90 && _shot.ntte_full_wave==0,
            "Dematerializer source step lost creator-relative480/liveaim/logical lifetime")
        // Important proven limitation of the supplied MOD: zero-speed source
        // projectile dies via ordinary ElectroPlasma.Step speed<=friction.
        // Hyper is only a written string field and no source/native code reads
        // it to exempt this check. Do not silently make up a speed/exemption.
        with(_shot) event_perform(ev_step,ev_step_normal)
        assert(!instance_exists(_shot),"Literal supplied Demat source unexpectedly gained lifetime exemption/default speed")
        scrNTTEFullMergedRuntimeTestCleanup(_before)
        // Source retention scans every Electro, no owner/weapon filtering;
        // preserve cross-owner/cannon case and its unchanged _last field.
        var _npc=instance_create(84300,84300,Bandit),_ordinary=noone,_cannon=noone
        _npc.team=team_enemy;_npc.gunangle=0
        with(_npc) {
            _ordinary=scrNTTEFullMergedBasicProjectileCreate(x,y,NTTEFullElectroPlasma,0,5)
            _cannon=scrNTTEFullMergedBasicProjectileCreate(x+20,y,NTTEFullElectroPlasmaBig,0,6)
        }
        _p.gunangle=0;_p.electroplasma_last=_ordinary;_p.electroplasma_side=1
        var _count=instance_number(NTTEFullElectroPlasma)
        with(_p) scrFire(wep,true)
        assert(instance_number(NTTEFullElectroPlasma)==_count && _ordinary.ntte_demat_lifetime==19
            && _cannon.ntte_demat_lifetime==19 && _p.electroplasma_last==_ordinary
            && _p.electroplasma_side==-1 && _ordinary.creator==_npc && _cannon.creator==_npc,
            "Demat source global retention gained owner/cannon filters, replaced retained ball or changed _last")
        _ordinary.ntte_demat_lifetime=1;_cannon.ntte_demat_lifetime=2
        with(_p) scrNTTEFullDematerializerStep(true)
        assert(abs(_ordinary.ntte_demat_lifetime-(1-timescale))<0.0001
            && abs(_cannon.ntte_demat_lifetime-(2-timescale))<0.0001,
            "Demat source step filtered retained cross-owner/cannon lifetime")
        _ordinary.ntte_demat_lifetime=0
        with(_p) scrNTTEFullDematerializerStep(true)
        assert(!instance_exists(_ordinary) && instance_exists(_cannon),"Demat source lifetime0 destruction changed")
    }
    finally {
        scrNTTEFullMergedRuntimeTestCleanup(_before)
        scrNTTEFullAreaGeneratorRestore(_players);scrNTTEFullAreaGeneratorRestore(_game);scrNTTEFullAreaGeneratorRestore(_back)
        ds_list_destroy(_skills);current_frame=_tick;random_set_seed(_seed)
    }
    scrNTTESmokeLog("FULL DEMATERIALIZER LITERAL SOURCE: actual class/cost0/load18, source global retention/chain, live480/19FT step; supplied MOD zero-speed next-Step destruction explicitly preserved (not a completed sustained weapon)")
}

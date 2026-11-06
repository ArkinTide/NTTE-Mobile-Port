function scrNTTEFullElectroWeaponTests() {
    var _before=scrNTTEFullInstances(all),_players=scrNTTEFullAreaGeneratorSnapshot(Player),
        _game=scrNTTEFullAreaGeneratorSnapshot(GameCont),_back=scrNTTEFullAreaGeneratorSnapshot(BackCont),
        _seed=random_get_seed(),_tick=current_frame,_skills=ds_list_create(),_p=instance_find(Player,0)
    GameCont.skills=_skills;GameCont.ntte_full_native_skill_counts={};current_frame=8
    try {
        _p.x=96000;_p.y=96000;_p.gunangle=0;_p.accuracy=1;_p.infammo=0;_p.race=Race.Fish
        _p.ammo=array_create(Ammo.NUM_AMMO_TYPES,100);_p.speed=0
        _p.wep=wep_ntte_electroplasma_rifle;_p.ntte_state=scrNTTENewState(_p.wep)
        _p.electroplasma_last=noone;_p.electroplasma_side=1
        var _generic=instance_number(NTTEAttack)
        with(_p) scrFire(wep,true)
        var _shots=scrNTTEFullBubbleWeaponTestNew(_before,NTTEFullElectroPlasma),
            _bursts=scrNTTEFullBubbleWeaponTestNew(_before,NTTEFullNativeFireBurst)
        assert(array_length(_shots)==1 && array_length(_bursts)==1 && instance_number(NTTEAttack)==_generic,
            "Actual ElectroPlasma Rifle retained generic attack or lost real source FireBurst")
        var _first=_shots[0],_controller=_bursts[0],_paid=_p.ammo[Ammo.Energy],
            _recoil=3*timescale+(1-timescale)*_p.friction/2
        assert(_first.creator==_p && _first.team==_p.team && _first.damage==3
            && _first.speed>=4*timescale && _first.speed<=4.4*timescale
            && _first.direction>=10 && _first.direction<=24 && _first.ntte_full_tether_inst==noone
            && _p.electroplasma_last==_first && _p.electroplasma_side==-1
            && abs(_p.speed-_recoil)<0.0001 && _paid==95 && _p.reload==20
            && _controller.ammo==2 && _controller.explicit_interval==3 && _controller.time_max==3,
            "Rifle source cost/load/speed/side/real-owner chain/initial recoil or explicit burst interval changed")
        _p.x=96100;_p.y=96200;_p.gunangle=90
        repeat(ceil(8/timescale)) if(instance_exists(_controller)) with(_controller) event_perform(ev_step,ev_step_normal)
        _shots=scrNTTEFullBubbleWeaponTestNew(_before,NTTEFullElectroPlasma)
        assert(array_length(_shots)==3 && _p.ammo[Ammo.Energy]==_paid && _p.reload==20
            && _p.x==96100 && _p.y==96200 && _p.gunangle==90,
            "Rifle delayed3rounds charged repeatedly/reset native reload or leaked temporary position")
        assert(_shots[1].ntte_full_tether_inst==_first && _shots[2].ntte_full_tether_inst==_shots[1]
            && _shots[1].direction>=66 && _shots[1].direction<=80
            && _shots[2].direction>=100 && _shots[2].direction<=114
            && _p.electroplasma_last==_shots[2] && _p.electroplasma_side==-1,
            "Rifle source later rounds lost creator-shared continuous chain, alternating side or live aim")
        // Shotgun continues the same creator chain across weapon changes.
        var _chain_tail=_shots[2]
        _p.wep=wep_ntte_electroplasma_shotgun;_p.ntte_state=scrNTTENewState(_p.wep)
        _p.ammo=array_create(Ammo.NUM_AMMO_TYPES,100);_p.gunangle=0;_p.speed=0
        var _shot_before=scrNTTEFullInstances(all)
        with(_p) scrFire(wep,true)
        _shots=scrNTTEFullBubbleWeaponTestNew(_shot_before,NTTEFullElectroPlasma)
        assert(array_length(_shots)==5 && _p.ammo[Ammo.Energy]==92 && _p.reload==27
            && _p.electroplasma_last==_shots[4] && _p.electroplasma_side==-1
            && abs(_p.speed-(4*timescale+(1-timescale)*_p.friction/2))<0.0001,
            "Actual Electro shotgun lost5physical projectiles, single cost8/load27, FT4 or mutated rifle side")
        for(var _i=0;_i<5;++_i) {
            var _shot=_shots[_i],_expect=(_i-2)*20,_spread=abs(_i-2)*6
            assert(_shot.creator==_p && _shot.team==_p.team && _shot.speed>=4*timescale && _shot.speed<=4.8*timescale
                && abs(angle_difference(_shot.direction,_expect))<=_spread+0.001
                && _shot.ntte_full_tether_inst==(_i==0?_chain_tail:_shots[_i-1]),
                "Shotgun source ordered i-2..2 independent spread/speed or previous-to-next tether changed")
        }
        var _last=_p.electroplasma_last
        _p.wep=wep_ntte_electroplasma_cannon;_p.ntte_state=scrNTTENewState(_p.wep)
        _p.ammo=array_create(Ammo.NUM_AMMO_TYPES,100);_p.accuracy=0;_p.speed=0
        _shot_before=scrNTTEFullInstances(all)
        with(_p) scrFire(wep,true)
        _shots=scrNTTEFullBubbleWeaponTestNew(_shot_before,NTTEFullElectroPlasmaBig)
        assert(array_length(_shots)==1 && _shots[0].creator==_p && _shots[0].team==_p.team
            && _shots[0].speed==6*timescale && _shots[0].damage==6 && _shots[0].typ==1
            && _shots[0].ntte_full_big==1 && _shots[0].ntte_full_tether_inst==noone
            && _p.electroplasma_last==_last && _p.ammo[Ammo.Energy]==90 && _p.reload==50,
            "Actual Electro cannon lost real big class speed6/damage6/typ1, cost10/load50 or incorrectly entered rifle chain")
        // NPC actual creator lives past synchronous Fish proxies and is also
        // the owner of persistent chain/side, across its delayed source burst.
        scrNTTEFullMergedRuntimeTestCleanup(_before)
        var _npc=instance_create(96400,96400,Bandit),_players_count=instance_number(Player)
        _npc.gunangle=0;_npc.team=team_enemy;_npc.electroplasma_last=noone;_npc.electroplasma_side=1
        var _result=scrNTTEFullActorFire(_npc,wep_ntte_electroplasma_rifle,0,0,false),
            _ctrls=scrNTTEFullMergedRuntimeTestShots(_result.shots,NTTEFullNativeFireBurst),
            _npc_shots=scrNTTEFullMergedRuntimeTestShots(_result.shots,NTTEFullElectroPlasma)
        assert(array_length(_npc_shots)==1 && array_length(_ctrls)==1
            && _npc.electroplasma_last==_npc_shots[0] && _npc.electroplasma_side==-1
            && _npc_shots[0].creator==_npc && instance_number(Player)==_players_count,
            "NPC initial Electro source chain was written to temporary proxy or lost actual creator")
        _npc.x=96500;_npc.y=96600;_npc.gunangle=90
        repeat(ceil(8/timescale)) if(instance_exists(_ctrls[0])) with(_ctrls[0]) event_perform(ev_step,ev_step_normal)
        _npc_shots=scrNTTEFullBubbleWeaponTestNew(_before,NTTEFullElectroPlasma)
        assert(array_length(_npc_shots)==3 && _npc.electroplasma_last==_npc_shots[2]
            && _npc.electroplasma_side==-1 && _npc_shots[1].ntte_full_tether_inst==_npc_shots[0]
            && _npc_shots[2].ntte_full_tether_inst==_npc_shots[1] && instance_number(Player)==_players_count,
            "NPC later FireBurst lost persistent true-creator tether/alternation or leaked synchronous proxies")
        for(var _i=1;_i<3;++_i) assert(_npc_shots[_i].creator==_npc && _npc_shots[_i].team==team_enemy
            && abs(angle_difference(_npc_shots[_i].direction,90))<0.0001,
            "NPC Electro delayed actual projectile lost real creator/team or live aim")
        // A real merged front retains the common ancestor on subsequent source
        // burst steps, while paying the native transaction only once.
        scrNTTEFullMergedRuntimeTestCleanup(_before)
        _p.x=96000;_p.y=96000;_p.gunangle=0;_p.accuracy=0
        _p.electroplasma_last=noone;_p.electroplasma_side=1;_p.ammo=array_create(Ammo.NUM_AMMO_TYPES,100)
        var _weapon=scrNTTEFullWeaponMerge(wep_heavy_revolver,wep_ntte_electroplasma_rifle),
            _handle=scrNTTEFullWeaponNative(_weapon)
        _p.wep=_handle
        _result=scrNTTEFullMergedRuntimePlayerFire(_p,_handle,{creator:_p})
        _ctrls=scrNTTEFullMergedRuntimeTestShots(_result.shots,NTTEFullNativeFireBurst)
        _shots=scrNTTEFullMergedRuntimeTestShots(_result.shots,NTTEFullElectroPlasma)
        assert(array_length(_shots)==1 && array_length(_ctrls)==1
            && _p.electroplasma_last==_shots[0] && variable_instance_exists(_ctrls[0],"ntte_merged_runtime_inherit"),
            "Merged Electro front replaced source burst as attack or wrote chain on ephemeral firing context")
        var _damage=_shots[0].damage,_force=_shots[0].knockback_speed,_merge=_shots[0].temerge_vars_list[0],
            _energy=_p.ammo[Ammo.Energy]
        _p.gunangle=90
        repeat(ceil(8/timescale)) if(instance_exists(_ctrls[0])) with(_ctrls[0]) event_perform(ev_step,ev_step_normal)
        _shots=scrNTTEFullBubbleWeaponTestNew(_before,NTTEFullElectroPlasma)
        assert(array_length(_shots)==3 && _p.ammo[Ammo.Energy]==_energy && _p.electroplasma_last==_shots[2]
            && _shots[2].damage==_damage && _shots[2].knockback_speed==_force
            && array_length(_shots[2].temerge_vars_list)==1 && _shots[2].temerge_vars_list[0]==_merge,
            "Real merged Electro delayed burst lost shared setup ancestor, actual creator chain or charged twice")
    } finally {
        scrNTTEFullMergedRuntimeTestCleanup(_before)
        scrNTTEFullAreaGeneratorRestore(_players);scrNTTEFullAreaGeneratorRestore(_game);scrNTTEFullAreaGeneratorRestore(_back)
        ds_list_destroy(_skills);current_frame=_tick;random_set_seed(_seed)
    }
    scrNTTESmokeLog("FULL ELECTRO WEAPONS: actual three scrFire/native objects, single costs/load, source3Step burst/speed/spread, cross-weapon creator tether, NPC actual owner/live aim and merged delayed inheritance OK")
}

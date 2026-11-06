function scrNTTEFullVampireTests() {
    var _before=scrNTTEFullInstances(all),_players=scrNTTEFullAreaGeneratorSnapshot(Player),
        _game=scrNTTEFullAreaGeneratorSnapshot(GameCont),_back=scrNTTEFullAreaGeneratorSnapshot(BackCont),
        _seed=random_get_seed(),_frame=current_frame,_skills=ds_list_create(),_p=instance_find(Player,0)
    GameCont.skills=_skills;GameCont.ntte_full_native_skill_counts={};current_frame=8
    try {
        _p.x=5000;_p.y=5000;_p.gunangle=0;_p.accuracy=0;_p.infammo=0;_p.race=Race.Fish
        _p.hp=8;_p.max_hp=8;_p.nexthurt=current_frame+1000;_p.shield=999
        _p.wep=wep_ntte_vampire;_p.ntte_state=scrNTTENewState(_p.wep)
        _p.ammo=array_create(Ammo.NUM_AMMO_TYPES,100)
        var _state=_p.ntte_state,_generic=instance_number(NTTECoil)
        // A normal Tesla coil does not suppress Vampire's first-shot effects.
        var _ordinary=instance_create(_p.x,_p.y,NTTEFullTeslaCoil)
        _ordinary.creator=_p;_ordinary.ntte_full_primary=true
        with(_p) scrFire(wep,true)
        var _shots=scrNTTEFullBubbleWeaponTestNew(_before,NTTEFullTeslaCoil),_coil=noone
        for(var _i=0;_i<array_length(_shots);++_i) if(scrNTTEFullValue(_shots[_i],"bat",false)) _coil=_shots[_i]
        assert(instance_exists(_coil) && _coil.creator==_p && _coil.team==_p.team
            && _coil.ntte_full_range==64 && _coil.ntte_full_time==7 && _coil.ntte_full_primary
            && _state.ammo==5 && _p.hp==8 && _p.wkick==8 && _p.reload==5
            && instance_number(NTTECoil)==_generic && _p.ammo[Ammo.Energy]==100,
            "Vampire retained generic coil or lost actual bat group/range64/time7/source magazine/first post")
        _p.wkick=2
        with(_p) scrFire(wep,true)
        assert(_p.wkick==2 && _state.ammo==4 && _p.hp==8,
            "Vampire overlapping bat coils repeated first-only recoil or refilled before magazine empty")
        repeat(4) with(_p) scrFire(wep,true)
        assert(_state.ammo==6 && _p.hp==7 && _p.nexthurt==current_frame+6
            && _p.ntte_last_hit[1]=="PLAYING GOD" && GameCont.deathcause[1]=="PLAYING GOD",
            "Vampire sixth shot failed refill/raw1 bypass of shield/immunity or source death attribution")
        // Match the authored differential formula on both mutation gain/loss.
        ds_list_add(_skills,mut_back_muscle);GameCont.ntte_full_native_skill_counts={}
        with(_p) scrNTTEMuscle(_state)
        assert(_state.capacity==12 && _state.ammo==12 && _state.muscle==1,
            "Vampire source Back Muscle gain lost base maximum differential")
        _state.ammo=1
        with(_p) scrFire(wep,true)
        assert(_state.ammo==24 && _state.capacity==12 && _p.hp==6,
            "Vampire source refill multiplies current amax again; adapter silently capped or flattened it")
        ds_list_clear(_skills);GameCont.ntte_full_native_skill_counts={}
        with(_p) scrNTTEMuscle(_state)
        assert(_state.capacity==6 && _state.ammo==24 && _state.muscle==0,
            "Vampire source mutation loss incorrectly clamped already acquired ammo")
        ds_list_add(_skills,mut_laser_brain);GameCont.ntte_full_native_skill_counts={}
        var _now=scrNTTEFullInstances(all)
        with(_p) scrNTTEFullVampireFire(false)
        _shots=scrNTTEFullBubbleWeaponTestNew(_now,NTTEFullTeslaCoil);_coil=_shots[0]
        var _fx=scrNTTEFullBubbleWeaponTestNew(_now,LaserBrain)
        assert(array_length(_shots)==1 && !_coil.ntte_full_primary && _coil.ntte_full_offy==-2
            && _coil.ntte_full_time==14 && array_length(_fx)==1 && _fx[0].creator==_p,
            "Vampire secondary coil/brain lifetime or per-shot actual LaserBrain effect changed")
        // Last blood reload can kill; raw cost must not leave an immortal1HP.
        _p.hp=1;_state.ammo=1;_p.infammo=0
        with(_p) scrFire(wep,true)
        assert(_p.hp==0 && _state.ammo==6,"Vampire lethal refill was prevented or failed magazine return")
        _p.hp=8;_state.ammo=1;_p.infammo=1
        with(_p) scrFire(wep,true)
        assert(_p.hp==8 && _state.ammo==1,"Vampire infinite ammo consumed blood or physical magazine")
        // Real NPC fire is collected after ownership restoration, with no
        // lasting Fish proxy. Its native infinite-ammo context does not bleed.
        var _npc=instance_create(5200,5200,Bandit),_players_count=instance_number(Player)
        _npc.team=team_enemy;_npc.gunangle=90
        var _result=scrNTTEFullActorFire(_npc,wep_ntte_vampire,90,0,false)
        _shots=scrNTTEFullMergedRuntimeTestShots(_result.shots,NTTEFullTeslaCoil)
        assert(array_length(_shots)==1 && _shots[0].creator==_npc && _shots[0].team==team_enemy
            && _shots[0].bat && instance_number(Player)==_players_count,
            "NPC Vampire lost durable ownership/team/collector or leaked firing proxy")
    } finally {
        scrNTTEFullMergedRuntimeTestCleanup(_before)
        scrNTTEFullAreaGeneratorRestore(_players);scrNTTEFullAreaGeneratorRestore(_game)
        scrNTTEFullAreaGeneratorRestore(_back);ds_list_destroy(_skills)
        random_set_seed(_seed);current_frame=_frame
    }
    scrNTTESmokeLog("FULL VAMPIRE: actual Tesla bat group/range/lifetime/secondary/brain FX, source six-shot blood refill/raw immunity bypass/lethal cause, exact Back Muscle differential+refill and infinite ammo, actual NPC ownership OK @"+string(30/timescale))
}

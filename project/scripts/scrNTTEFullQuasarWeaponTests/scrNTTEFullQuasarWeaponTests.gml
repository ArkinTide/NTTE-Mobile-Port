function scrNTTEFullQuasarWeaponTests() {
    var _before=scrNTTEFullInstances(all),_players=scrNTTEFullAreaGeneratorSnapshot(Player),
        _game=scrNTTEFullAreaGeneratorSnapshot(GameCont),_back=scrNTTEFullAreaGeneratorSnapshot(BackCont),
        _seed=random_get_seed(),_frame=current_frame,_skills=ds_list_create(),_p=instance_find(Player,0)
    GameCont.skills=_skills;GameCont.ntte_full_native_skill_counts={};current_frame=8
    try {
        _p.x=4000;_p.y=4000;_p.gunangle=0;_p.wepangle=0;_p.accuracy=0;_p.infammo=0
        _p.race=Race.Fish;_p.specfiring=false;_p.speed=0;_p.ammo=array_create(Ammo.NUM_AMMO_TYPES,100)
        _p.wep=wep_ntte_quasar_blaster;_p.ntte_state=scrNTTENewState(_p.wep)
        var _generic=instance_number(NTTEBeam)
        with(_p) scrFire(wep,true)
        var _shots=scrNTTEFullBubbleWeaponTestNew(_before,NTTEFullQuasarBeam),_beam=_shots[0]
        assert(array_length(_shots)==1 && instance_number(NTTEBeam)==_generic
            && _p.ammo[Ammo.Energy]==97 && _p.reload==15 && _beam.creator==_p
            && _beam.ntte_full_turn_factor==0.1 && _beam.ntte_full_shrink_delay==8
            && _beam.ntte_full_scale_goal==0.5 && _beam.ntte_full_bend_friction==0.4
            && _beam.image_xscale==0.5 && _beam.image_yscale==0.5 && _p.wkick==12,
            "Actual Quasar Blaster lost real native class/source cost/load/scales/bend")
        _p.wep=wep_ntte_quasar_rifle;_p.ntte_state=scrNTTENewState(_p.wep)
        _p.ammo=array_create(Ammo.NUM_AMMO_TYPES,100);_p.speed=0
        with(_p) scrFire(wep,true)
        _beam=_p.ntte_state.beam
        assert(instance_is(_beam,NTTEFullQuasarBeam) && _beam.creator==_p && _beam.image_yscale==0.6
            && _beam.ntte_full_offset==16 && _beam.ntte_full_turn_factor==0.01
            && _beam.ntte_full_shrink_delay==61 && _beam.ntte_full_primary && _p.ammo[Ammo.Energy]==90
            && _p.reload==60 && _p.wkick==14 && abs(_p.speed-(3*timescale+(1-timescale)*_p.friction/2))<0.0001,
            "Actual Quasar Rifle lost initial physical beam link/source timing/FT3")
        var _count=instance_number(NTTEFullQuasarBeam)
        with(_p) scrFire(wep,true)
        assert(_p.ntte_state.beam==_beam && instance_number(NTTEFullQuasarBeam)==_count
            && _beam.ntte_full_scale_goal==1 && _p.ammo[Ammo.Energy]==80,
            "Quasar Rifle retrigger replaced existing physical beam or failed first growth")
        ds_list_add(_skills,mut_laser_brain);GameCont.ntte_full_native_skill_counts={}
        _beam.image_yscale=1.2;_beam.ntte_full_scale_goal=1
        with(_p) scrFire(wep,true)
        assert(abs(_beam.ntte_full_scale_goal-1.25)<0.0001 && _beam.ntte_full_flash==current_frame+3,
            "Quasar Rifle growth used scale_goal accumulation instead of current thickness/brain normalization")
        _beam.image_yscale=1.5
        with(_p) scrFire(wep,true)
        assert(abs(_beam.ntte_full_scale_goal-1.35)<0.0001,"Quasar Rifle brain-dependent maximum changed")
        // Source YV pop-pop creates a new beam while the previous one remains.
        _p.specfiring=true
        with(_p) scrFire(wep,true)
        assert(_p.ntte_state.beam!=_beam && instance_exists(_beam),"Quasar Rifle special primary reused the old beam")
        _p.specfiring=false
        var _independent=scrNTTENewState(wep_ntte_quasar_rifle),_original=_p.ntte_state
        _p.ntte_state=_independent
        with(_p) scrFire(wep,true)
        assert(_independent.beam!=_original.beam && instance_exists(_original.beam),
            "Independent same-type Quasar weapons shared one beam reference")
        ds_list_clear(_skills);GameCont.ntte_full_native_skill_counts={}
        _p.wep=wep_ntte_quasar_cannon;_p.ntte_state=scrNTTENewState(_p.wep)
        _p.ammo=array_create(Ammo.NUM_AMMO_TYPES,100);_p.speed=0
        var _now=scrNTTEFullInstances(all)
        with(_p) scrFire(wep,true)
        _shots=scrNTTEFullBubbleWeaponTestNew(_now,NTTEFullQuasarRing);_beam=_shots[0]
        assert(array_length(_shots)==1 && _beam.speed==4*timescale && _beam.image_yscale==0
            && _beam.ntte_full_ring_size==0.6 && _beam.ntte_full_ring && !_beam.ntte_full_follow
            && _p.ammo[Ammo.Energy]==84 && _p.reload==159 && _p.wkick==20,
            "Quasar Cannon lost actual ring/source initial zero scale/speed4/cost16/load159")
        _p.wep=wep_ntte_ultra_quasar_rifle;_p.ntte_state=scrNTTENewState(_p.wep)
        _p.ammo=array_create(Ammo.NUM_AMMO_TYPES,100);GameCont.rad=200
        with(_p) scrFire(wep,true)
        _beam=_p.ntte_state.beam
        assert(instance_is(_beam,NTTEFullUltraQuasarBeam) && _beam.creator==_p
            && _beam.image_yscale==0 && _beam.ntte_full_offset==32 && _beam.ntte_full_scale_goal==0.3
            && _beam.ntte_full_shrink_delay==31 && _p.ammo[Ammo.Energy]==94 && GameCont.rad==150 && _p.wkick==16,
            "Ultra Quasar lost real Ultra class, per-weapon link, initial0/.3/offset32 or single rad50 charge")
        _beam.image_yscale=2;_count=instance_number(NTTEFullUltraQuasarBeam)
        with(_p) scrFire(wep,true)
        assert(_p.ntte_state.beam==_beam && instance_number(NTTEFullUltraQuasarBeam)==_count
            && abs(_beam.ntte_full_scale_goal-31/15)<0.0001 && GameCont.rad==100,
            "Ultra Quasar current-thickness growth acquired invented cap or replaced beam")
        // ActorFire must retain actual long-lived NPC ownership on the beam.
        var _npc=instance_create(4200,4200,Bandit);_npc.gunangle=90;_npc.team=team_enemy
        var _result=scrNTTEFullActorFire(_npc,wep_ntte_quasar_blaster,90,0,false)
        _shots=scrNTTEFullMergedRuntimeTestShots(_result.shots,NTTEFullQuasarBeam)
        assert(array_length(_shots)==1 && _shots[0].creator==_npc && _shots[0].team==team_enemy
            && _shots[0].ntte_full_primary && _shots[0].direction==90,
            "NPC Quasar retained ephemeral proxy owner or lost primary slot/actual direction")
        // Real merged front fire reuses that physical front's beam, even after
        // its raw state.weapon has been restored to the canonical native LWO.
        scrNTTEFullMergedRuntimeTestCleanup(_before)
        _p.speed=0;_p.specfiring=false;_p.ammo=array_create(Ammo.NUM_AMMO_TYPES,100)
        var _weapon=scrNTTEFullMergedRuntimePart(scrNTTEFullWeaponMerge(wep_revolver,wep_ntte_quasar_rifle)),
            _front=_weapon.temerge.wep[0],_handle=scrNTTEFullWeaponNative(_weapon)
        _p.wep=_handle;_p.ntte_state=scrNTTEFullWeaponNativeState(_weapon)
        _result=scrNTTEFullMergedRuntimePlayerFire(_p,_handle,{creator:_p})
        var _front_state=scrNTTEFullWeaponNativeState(_front)
        _beam=_front_state.beam;_count=instance_number(NTTEFullQuasarBeam)
        assert(instance_is(_beam,NTTEFullQuasarBeam) && _beam.creator==_p
            && scrNTTEFullWeaponModel(_front_state.weapon)==_front,
            "Merged Quasar front lost physical beam reference or state restoration")
        _result=scrNTTEFullMergedRuntimePlayerFire(_p,_handle,{creator:_p})
        assert(_front_state.beam==_beam && instance_number(NTTEFullQuasarBeam)==_count
            && _beam.ntte_full_scale_goal==1 && _p.wep==_handle,
            "Actual merged Quasar subsequent fire created another beam or corrupted mounted inventory")
    } finally {
        scrNTTEFullMergedRuntimeTestCleanup(_before)
        scrNTTEFullAreaGeneratorRestore(_players);scrNTTEFullAreaGeneratorRestore(_game)
        scrNTTEFullAreaGeneratorRestore(_back);ds_list_destroy(_skills)
        random_set_seed(_seed);current_frame=_frame
    }
    scrNTTESmokeLog("FULL QUASAR WEAPONS: actual four native entities/cost/load/rads, independent physical beam refs, current-thickness and brain growth, special replacement, cannon ring and actual NPC ownership OK @"+string(30/timescale))
}

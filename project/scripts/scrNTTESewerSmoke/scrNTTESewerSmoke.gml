function scrNTTESewerSmokeEnabled() {
    if (os_type!=os_windows) return false
    for(var _i=1;_i<=parameter_count();++_i) if (parameter_string(_i)=="--ntte-sewer-smoke") return true
    return false
}

function scrNTTEBoneSmoke() {
    // Called in Player context: use the real scrFire and slot state paths.
    infammo=0
    global.__debug_infammo=false
    race=Race.Fish
    wep=wep_ntte_bone
    bwep=wep_ntte_rogue_carbine
    ntte_state=scrNTTENewState(wep)
    bntte_state=scrNTTENewState(bwep)
    var _bone=ntte_state
    scrFire(wep)
    assert(wep==wep_ntte_bone,"Bone changed slot during scrFire")
    assert(_bone.ammo==0 && _bone.outstanding==0,"Ordinary bone was not spent permanently")
    scrNTTEConsumeBoneSlots()
    assert(wep==wep_ntte_rogue_carbine && bwep==0,"Bone did not auto-select secondary")
    var _p=instance_find(NTTEAttack,0)
    assert(instance_exists(_p) && _p.refund==0,"Bone projectile still refunds")
    with (_p) { speed=0; scrNTTEAttackStep() }
    assert(!instance_exists(_p) && instance_number(NTTEBoneShard)==2,"Bone did not split into two shards on ground")
    assert(_bone.ammo==0,"Bone debris returned ammo")
    with (NTTEBoneShard) {
        assert(!instance_is(id,WepPickup) && !instance_is(id,NTTEPickup) && !instance_is(id,hitme),"Shard is collectible or a damage target")
    }
    instance_destroy(NTTEBoneShard,false)
    // A stack remains until its last throw, then neither slot contains an empty bone.
    wep=wep_ntte_bone; bwep=wep_ntte_bone
    ntte_state=scrNTTENewState(wep); ntte_state.ammo=2; ntte_state.capacity=2
    bntte_state=scrNTTENewState(bwep)
    scrFire(wep)
    scrNTTEConsumeBoneSlots()
    assert(wep==wep_ntte_bone && ntte_state.ammo==1,"Bone stack consumed prematurely")
    scrFire(wep)
    // Steroids' secondary uses the same swapped-slot convention.
    scrSwapWeps(false)
    scrFire(wep,true,false)
    scrSwapWeps(false)
    scrNTTEConsumeBoneSlots()
    assert(wep==0 && bwep==0,"Empty primary or secondary bone remained in slots")
    var _legacy=scrNTTENewState(wep_ntte_bone)
    _legacy.ammo=0; _legacy.outstanding=1
    _legacy=scrNTTEStateRestored(json_parse(json_stringify(_legacy)))
    assert(_legacy.ammo==0 && _legacy.outstanding==0,"Old save resurrected a thrown bone")
    instance_destroy(NTTEAttack,false)
    assert(instance_number(NTTEBoneShard)==0,"Silent projectile cleanup created debris")
    // Hit and wall collisions must split, without creating weapon/ammo pickups.
    var _pickups=instance_number(WepPickup)+instance_number(NTTEPickup),_dummy=instance_create(x+32,y,Dummy)
    _dummy.hp=100; _dummy.max_hp=100
    _p=scrNTTEShot(NTTEKind.Bone,0,0); _p.weapon=wep_ntte_bone
    with (_p) scrNTTEAttackHit(_dummy)
    assert(!instance_exists(_p) && instance_number(NTTEBoneShard)==2 && _dummy.hp==66,"Bone impact damage or shards incorrect")
    instance_destroy(_dummy,false)
    _p=scrNTTEShot(NTTEKind.Bone,0,0); _p.weapon=wep_ntte_bone
    with (_p) scrNTTEAttackWall(noone)
    assert(!instance_exists(_p) && instance_number(NTTEBoneShard)==4,"Bone wall impact did not split")
    assert(instance_number(WepPickup)+instance_number(NTTEPickup)==_pickups,"Broken bone produced a pickup")
    instance_destroy(NTTEBoneShard,false)
    // Whole thrown weapons now leave their slots and land as physical pickups.
    for(var _i=0;_i<2;++_i) {
        wep=_i==0 ? wep_ntte_ancient_artifact:wep_ntte_trident
        ntte_state=scrNTTENewState(wep)
        ntte_state.charge=7
        var _state=ntte_state
        scrFire(wep)
        assert(_state.ammo==0 && _state.outstanding==0,"Thrown weapon reserved a remote refund")
        instance_destroy(NTTEAttack,false)
        assert(_state.ammo==0 && _state.outstanding==0,"Thrown weapon refunded from cleanup")
    }
    wep=wep_ntte_rogue_carbine; bwep=0
    ntte_state=scrNTTENewState(wep)
    bntte_state=undefined
}

function scrNTTESewerSmokeStep() {
    if (!variable_instance_exists(id,"sewer_rate")) {
        sewer_rate=0; sewer_tick=0; sewer_phase=0; sewer_generation=0; sewer_wait=0
        UberCont.custom=true
        UberCont.custom_options=new CustomModeOptions("NTTE SEWER TEST")
        variable_struct_remove(UberCont.custom_options,"ntte_sewer_event")
        assert(scrNTTESewerSetting()==0,"Sewer preset migration failed")
        GameCont.area=area_desert
        assert(scrNTTESewerPopulate(NTTESewerEvent.Den)==NTTESewerEvent.Off,"Sewer event leaked into desert")
        scrNTTESmokeLog("SEWER PRESET MIGRATION AND AREA GUARD OK")
    }
    with (Player) {
        hp=10000; max_hp=10000; lsthealth=10000; nexthurt=current_frame+100
        can_walk=false; can_aim=false; speed=0; x=10016; y=10016
        mask_index=mskPlayer; race=Race.Fish; gunangle=0
    }
    if (sewer_generation>0) {
        sewer_wait+=timescale
        assert(sewer_wait<900,"Sewer native generation timed out")
        if (instance_exists(GenCont)) return;
        assert(GameCont.ntte_sewer_last_event==NTTESewerEvent.Den,"Native generator missed sewer hook")
        assert(instance_number(NTTEBabyGator)==1 && instance_number(NTTEBoneGator)==1,"Native den missing new gators")
        scrNTTEDesertSmokeConnected()
        scrNTTESmokeLog("NATIVE SEWER GENERATION OK "+string(sewer_generation))
        if (sewer_generation>=3) {
            scrNTTESmokeLog("PASS SEWERS/BONES 3 rates; consumed slots, stack, collision shards, old-save migration, artifact/trident regression, AI burst, heal, death and silent cleanup, connected den; 3 native generations")
            game_end()
            return;
        }
        ++sewer_generation
        scrNTTESewerSmokeGenerate()
        return;
    }
    if (sewer_rate>=3) {
        sewer_generation=1
        scrNTTESewerSmokeGenerate()
        return;
    }
    if (sewer_tick==0) {
        scrNTTEDesertSmokeClear()
        instance_destroy(Corpse,false)
        instance_destroy(NTTEBoneShard,false)
        var _fps=rates[sewer_rate]
        UberCont.opt_framerate=_fps
        game_set_speed(_fps,gamespeed_fps)
        GameCont.area=area_sewers; GameCont.subarea=1; GameCont.hard=6; GameCont.loops=0; GameCont.rad=10000
        for(var _dx=-5;_dx<=5;++_dx) for(var _dy=-4;_dy<=4;++_dy) instance_create(10000+_dx*32,10000+_dy*32,Floor)
        with (Floor) mcr_floor_make_walls;
        with (Player) scrNTTEBoneSmoke()
        // Round-trip the actual Player serializer, including extra-slot arrays.
        var _saved_player=instance_find(Player,0)
        with (_saved_player) {
            scrExtraWepsReset()
            wep=wep_ntte_bone; ntte_state=scrNTTENewState(wep)
            ntte_state.ammo=0; ntte_state.outstanding=1
            scrExtraWepStoreCurrent()
            wep=wep_ntte_trident; ntte_state=scrNTTENewState(wep)
            curse=2; scrExtraWepStoreCurrent()
            wep=wep_ntte_bone; ntte_state=scrNTTENewState(wep)
            ntte_state.ammo=0; ntte_state.outstanding=1
            bwep=wep_ntte_rogue_carbine; bntte_state=scrNTTENewState(bwep)
            curse=0; bcurse=0
        }
        var _buffer=buffer_create(65535,buffer_grow,1)
        scrSavegamePlayers(_buffer,false)
        instance_destroy(_saved_player,false)
        buffer_seek(_buffer,buffer_seek_start,0)
        scrSavegamePlayers(_buffer,true)
        buffer_delete(_buffer)
        with (Player) {
            assert(ntte_state.ammo==0,"Actual Player load resurrected bone")
            scrNTTEConsumeBoneSlots()
            assert(wep==wep_ntte_rogue_carbine && bwep==wep_ntte_trident && bcurse==2,"Consumed bone blocked extra weapon carousel")
            assert(array_length(extra_weps)==0 && array_length(ntte_extra_states)==0,"Consumed extra bone left mismatched slot arrays")
            // Position belongs to level restore, outside scrSavegamePlayers.
            x=10016; y=10016; speed=0; mask_index=mskPlayer
        }
        scrNTTESmokeLog("BONE PLAYER SAVE/LOAD AND EXTRA SLOT CAROUSEL OK @"+string(_fps))
        scrNTTESmokeLog("BONE CONSUMPTION/COLLISION/RETURN REGRESSION OK @"+string(_fps))
        instance_create(10096,10016,WeaponChest)
        instance_create(9920,10016,AmmoChest)
        var _chests=instance_number(chestprop)
        assert(scrNTTESewerPopulate(NTTESewerEvent.Den)==NTTESewerEvent.Den,"Forced den failed")
        assert(instance_number(chestprop)==_chests,"Den duplicated chest rewards")
        scrNTTEDesertSmokeConnected()
        var _den=instance_find(NTTEBabyGator,0)
        assert(!_den.ntte_gator_awake,"Den gator started awake")
        with (_den) scrNTTESewerStep()
        assert(!_den.ntte_gator_awake,"Distant den woke prematurely")
        _den.hp-=1
        with (_den) scrNTTESewerStep()
        assert(_den.ntte_gator_awake,"Damage did not wake den gator")
        instance_destroy(enemy,false)
        instance_destroy(projectile,false)
        instance_destroy(Explosion,false)
        sewer_baby=instance_create(10096,10016,NTTEBabyGator)
        sewer_baby.ntte_gator_timer=1
        sewer_baby.hp=10000; sewer_baby.max_hp=10000
        // Exercise the probabilistic attack with a visible target before random
        // wandering or explosions can move this enemy outside its 160px range.
        with (sewer_baby) {
            scrTarget()
            assert(scrTargetIsVisible(target,160),"Baby gator fixture target not visible")
            repeat(32) scrNTTESewerDecision()
            assert(ntte_gator_shots>0,"Baby gator visible-target decision never fired")
            speed=0; walk=0
        }
        sewer_bone=instance_create(10016,10096,NTTEBoneGator)
        sewer_bone.hp=6; sewer_bone.max_hp=24
        var _e=instance_create(11000,11000,Explosion)
        with (_e) scr_projectile_hit(other.sewer_bone,20)
        assert(sewer_bone.hp==18,"Bone gator did not heal from explosion")
        with (_e) scr_projectile_hit(other.sewer_bone,20)
        assert(sewer_bone.hp==18,"Bone gator healed twice inside cooldown")
        instance_destroy(_e,false)
        var _bullet=instance_create(11000,11000,Bullet1)
        with (_bullet) scr_projectile_hit(other.sewer_bone,4)
        assert(sewer_bone.hp==14,"Bone gator ignored ordinary damage")
        instance_destroy(_bullet,false)
        sewer_bone.hp=10000; sewer_bone.max_hp=10000
        sewer_bone.ntte_gator_ammo=6
        sewer_bone.ntte_gator_timer=1
        sewer_phase=0
        scrNTTESmokeLog("SEWER DEN CONNECTIVITY, WAKE, EXPLOSION HEAL OK @"+string(_fps))
    }
    sewer_tick+=timescale
    if (sewer_phase==0 && sewer_tick>=25) {
        assert(sewer_bone.ntte_gator_shots==6 && sewer_bone.ntte_gator_final==1,"Bone gator burst must be 5 small + 1 final grenade")
        scrNTTESmokeLog("BONE GATOR SIX-SHOT BURST OK @"+string(rates[sewer_rate]))
        sewer_phase=1
    }
    if (sewer_tick>=450) {
        assert(sewer_baby.ntte_gator_shots>0,"Baby gator never attacked")
        instance_destroy(projectile,false)
        instance_destroy(Explosion,false)
        // Fire is intentionally only created over Floor in the original MOD.
        // Return the freely wandering subject to the fixture's interior.
        sewer_bone.x=10016; sewer_bone.y=10096
        sewer_bone.speed=0
        sewer_bone.hp=0
        instance_destroy(sewer_bone)
        assert(instance_number(Explosion)>=2 && instance_number(TrapFire)==20,"Bone gator death missing explosions/fire")
        with (Explosion) assert(team==-1,"Bone gator death explosion must be neutral")
        instance_destroy(projectile,false)
        instance_destroy(Explosion,false)
        var _silent=instance_create(10016,10096,NTTEBoneGator)
        instance_destroy(_silent,false)
        assert(instance_number(Explosion)==0 && instance_number(TrapFire)==0,"Silent sewer cleanup created death explosions")
        // Charm must use hostile targets and the shared portal/aiming team rules.
        sewer_baby.team=team_player; sewer_baby.ntte_charmed=true
        var _hostile=instance_create(10112,10016,Bandit)
        with (sewer_baby) scrTarget()
        assert(sewer_baby.target==_hostile,"Friendly gator targets player")
        assert(!scrNTTEAimTargetAllowed(sewer_baby,team_player),"Aim targets friendly sewer gator")
        scrNTTESmokeLog("SEWER AI, DEATH, SILENT CLEANUP, FRIENDLY TARGET OK @"+string(rates[sewer_rate]))
        ++sewer_rate
        sewer_tick=0
    }
}

function scrNTTESewerSmokeGenerate() {
    scrNTTEDesertSmokeClear()
    GameCont.area=area_sewers; GameCont.subarea=1; GameCont.hard=6; GameCont.rad=10000
    GameCont.ntte_sewer_last_event=0
    UberCont.custom_options.ntte_sewer_event=NTTESewerEvent.Den
    save_set_value("game","tutorial",false)
    random_set_seed(6200+sewer_generation)
    instance_create(0,0,GenCont)
    sewer_wait=0
}

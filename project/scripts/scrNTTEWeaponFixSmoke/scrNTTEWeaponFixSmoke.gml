function scrNTTEWeaponFixSmokeEnabled() {
    if (os_type!=os_windows) return false
    for(var _i=1;_i<=parameter_count();++_i) if (parameter_string(_i)=="--ntte-weapon-fix-smoke") return true
    return false
}

function scrNTTEFixTestDummy(_x,_y,_team=team_enemy) {
    var _e=instance_create(_x,_y,Bandit)
    _e.x=_x; _e.y=_y; _e.hp=10000; _e.max_hp=10000
    _e.team=_team; _e.speed=0; _e.nexthurt=0
    _e.walk=0; _e.alarm[1]=-1; _e.friction=1000*timescale*timescale
    return _e
}

function scrNTTEFixDecorTests() {
    var _sprites=[sprNTTEFloorScorpionTile,sprNTTERug,sprNTTEBanditCampfire,sprNTTECowSkull],_decor=[]
    for(var _i=0;_i<4;++_i) {
        var _d=instance_create(11000+32*_i,11000,NTTEDesertDecor)
        _d.sprite_index=_sprites[_i]
        array_push(_decor,_d)
        assert(!instance_is(_d,damagesource),"Scenery still inherits attack cleanup")
    }
    var _portal=instance_create(11000,11000,Portal)
    with (PortalShock) event_perform(ev_step,ev_step_normal)
    with (_portal) { sprite_index=sprPortalSpawn; event_perform(ev_other,ev_animation_end) }
    with (PortalShock) event_perform(ev_step,ev_step_normal)
    for(var _i=0;_i<4;++_i) assert(instance_exists(_decor[_i]) && _decor[_i].sprite_index==_sprites[_i],"Portal opening removed special floor or scenery")
    instance_destroy(Portal,false); instance_destroy(PortalShock,false); instance_destroy(PortalClear,false)
    scrNTTESmokeLog("NATIVE PORTAL OPENING PRESERVES FOUR SCENERY TYPES")
}

function scrNTTEFixCoilTests() {
    // Player context. Match the original targeting, mutation and ammo formulas.
    instance_destroy(enemy,false)
    instance_destroy(prop,false)
    instance_destroy(projectile,false)
    ds_list_clear(GameCont.skills)
    var _ally=scrNTTEFixTestDummy(x+40,y,team_player),
        _enemy=scrNTTEFixTestDummy(x+56,y,team_enemy),
        _popo=scrNTTEFixTestDummy(x+72,y,team_popo),_coil=scr_projectile_create(x,y,NTTECoil,0,0)
    with (_coil) { scrNTTECoilFollow(); scrNTTECoilTarget() }
    assert(_coil.target==_popo,"Tesla did not prefer IDPD over enemy/friendly")
    assert(_coil.life>=12 && _coil.life<=24,"Tesla target did not extend lifetime x1.5")
    instance_destroy(_popo,false)
    with (_coil) scrNTTECoilTarget()
    assert(_coil.target==_enemy,"Tesla chose friendly unit")
    _enemy.team=team_player
    _coil.target=noone
    with (_coil) scrNTTECoilTarget()
    assert(_coil.target==noone,"Tesla targeted an ally")
    instance_destroy(enemy,false)
    var _prop=instance_create(x+52,y,Cactus)
    with (_coil) scrNTTECoilTarget()
    assert(_coil.target==_prop,"Tesla did not fall back to destructible prop")
    instance_destroy(_prop,false)
    instance_destroy(_coil,false)
    // Mutations extend duration, never the 96/64 targeting radius.
    for(var _brain=0;_brain<=1;++_brain) {
        ds_list_clear(GameCont.skills)
        if (_brain) ds_list_add(GameCont.skills,mut_laser_brain)
        wep=wep_ntte_vampire; ntte_state=scrNTTENewState(wep)
        var _oldhp=hp
        scrFire(wep)
        _coil=instance_find(NTTECoil,0)
        assert(_coil.life==7*(1+_brain),"Vampire Laser Brain duration mismatch")
        with (_coil) scrNTTECoilOriginalStep()
        assert(_coil.range==64,"Vampire mutation incorrectly expanded range")
        assert(ntte_state.ammo==5 && hp==_oldhp,"Vampire spent health before sixth shot")
        instance_destroy(NTTECoil,false)
        ntte_state.ammo=1
        scrFire(wep)
        assert(ntte_state.ammo==6 && hp==_oldhp-1,"Vampire refill must cost exactly 1 HP after sixth shot")
        instance_destroy(NTTECoil,false)
    }
    ds_list_clear(GameCont.skills)
    ds_list_add(GameCont.skills,mut_back_muscle)
    wep=wep_ntte_vampire; ntte_state=scrNTTENewState(wep)
    scrNTTEMuscle(ntte_state)
    assert(ntte_state.capacity==12,"Vampire Back Muscle capacity mismatch")
    ntte_state.ammo=1
    var _oldhp=hp
    scrFire(wep)
    assert(ntte_state.ammo==12 && hp==_oldhp-1,"Vampire Back Muscle refill mismatch")
    instance_destroy(NTTECoil,false)
    ds_list_clear(GameCont.skills)
    // Raw blood cost must bypass invulnerability and custom difficulty scaling.
    UberCont.custom=true
    UberCont.custom_options=new CustomModeOptions("WEAPON FIX")
    UberCont.custom_options.damage_to_player=10
    ntte_state=scrNTTENewState(wep)
    ntte_state.ammo=1
    _oldhp=hp
    nexthurt=current_frame+1000
    scrFire(wep)
    assert(hp==_oldhp-1,"Vampire blood cost was blocked or modified")
    UberCont.custom_options.damage_to_player=0
    instance_destroy(NTTECoil,false)
    // The last HP can pay for a refill (test helper directly, before Player death).
    hp=1
    scrNTTEVampireRefill(ntte_state)
    assert(hp==0 && GameCont.deathcause[1]=="PLAYING GOD","Vampire final HP/death cause mismatch")
    hp=10000; max_hp=10000; lsthealth=10000
    wep=wep_ntte_rogue_carbine; bwep=0; ntte_state=scrNTTENewState(wep)
    // Caster and secondary offset must track the actual firing hand.
    right=-1; wkick=6; bwkick=9; speed=0; gunangle=0
    _coil=scr_projectile_create(x,y,NTTECoil,0,0)
    _coil.primary=false; _coil.creator_offy-=4
    with (_coil) scrNTTECoilFollow()
    assert(abs(_coil.x-(x+14))<0.01 && abs(_coil.y-(y-2))<0.01,"Tesla secondary muzzle offset mismatch")
    instance_destroy(_coil,false)
    right=1; wkick=0; bwkick=0
    // A wall blocks targeting and every damage segment.
    _enemy=scrNTTEFixTestDummy(x+80,y)
    var _wall=instance_create(x+48,y-8,Wall)
    _coil=scr_projectile_create(x,y,NTTECoil,0,0)
    with (_coil) { scrNTTECoilFollow(); scrNTTECoilTarget() }
    assert(_coil.target==noone,"Tesla targeted through a wall")
    _coil.target=_enemy; _coil.target_x=_enemy.x; _coil.target_y=_enemy.y
    with (_coil) scrNTTECoilArc()
    assert(_enemy.hp==10000 && !_coil.arc_visible,"Tesla arc damaged through wall")
    instance_destroy(_wall,false); instance_destroy(_coil,false); instance_destroy(_enemy,false)
}

function scrNTTEFixThrowTests() {
    instance_destroy(NTTEAttack,false)
    instance_destroy(WepPickup,false)
    var _weapons=[wep_ntte_trident,wep_ntte_golden_trident,wep_ntte_ancient_artifact,
                  wep_ntte_guarded_artifact,wep_ntte_stolen_artifact,wep_ntte_missing_artifact]
    for(var _i=0;_i<array_length(_weapons);++_i) {
        wep=_weapons[_i]; bwep=wep_ntte_rogue_carbine
        ntte_state=scrNTTENewState(wep); bntte_state=scrNTTENewState(bwep)
        ntte_state.charge=7; curse=(_i mod 3); bcurse=0
        var _state=ntte_state,_curse=curse
        scrFire(wep)
        assert(wep==_weapons[_i] && _state.ammo==0 && _state.outstanding==0,"Thrown weapon duplicated or changed inside scrFire")
        scrNTTEConsumeBoneSlots()
        assert(wep==wep_ntte_rogue_carbine && bwep==0,"Thrown weapon remained in toolbar")
        var _p=instance_find(NTTEAttack,0)
        assert(instance_exists(_p) && _p.refund==0,"Thrown projectile still remotely refunds")
        _p.x=x+96; _p.y=y; _p.speed=0; _p.stuck=true
        with (_p) scrNTTEAttackStep()
        var _drop=instance_find(WepPickup,0)
        assert(!instance_exists(_p) && instance_number(WepPickup)==1,"Thrown weapon did not land exactly once")
        assert(_drop.wep==_weapons[_i] && _drop.curse==_curse && !_drop.autopick,"Dropped weapon lost ID/curse or auto-returns")
        assert(abs(_drop.x-(x+96))<1 && abs(_drop.y-y)<1,"Thrown weapon did not remain at landing point")
        assert(_drop.ntte_state.ammo==1 && _drop.ntte_state.outstanding==0,"Landed weapon state was not restored")
        assert(_state.ammo==0,"Landing refunded the removed toolbar state")
        instance_destroy(_drop,false)
    }
    // Secondary throwing, old-state migration and silent room cleanup.
    race=Race.Steroids
    wep=wep_ntte_rogue_carbine; bwep=wep_ntte_trident
    ntte_state=scrNTTENewState(wep); bntte_state=scrNTTENewState(bwep)
    scrSwapWeps(false); ntte_state.charge=7
    scrFire(wep,true,false); scrSwapWeps(false)
    scrNTTEConsumeBoneSlots()
    assert(wep==wep_ntte_rogue_carbine && bwep==0,"Secondary thrown weapon remained in toolbar")
    instance_destroy(NTTEAttack,false)
    assert(instance_number(WepPickup)==0,"Silent projectile cleanup created a duplicate pickup")
    var _legacy=scrNTTENewState(wep_ntte_trident)
    _legacy.ammo=0; _legacy.outstanding=1
    _legacy=scrNTTEStateRestored(_legacy)
    assert(_legacy.ammo==0 && _legacy.outstanding==0,"Old save remotely restored a thrown weapon")
    race=Race.Fish
}

function scrNTTEWeaponFixSmokeStep() {
    if (!variable_instance_exists(id,"fix_rate")) { fix_rate=0; fix_tick=0; fix_phase=0 }
    var _player=instance_find(Player,0)
    with (_player) {
        hp=10000; max_hp=10000; lsthealth=10000; nexthurt=current_frame+100
        can_walk=false; can_aim=false; speed=0; x=10016; y=10016
        gunangle=0; mask_index=mskPlayer; can_pick=true
    }
    if (fix_tick==0 && fix_phase==0) {
        scrNTTEDesertSmokeClear()
        instance_destroy(Corpse,false)
        instance_destroy(WepPickup,false)
        GameCont.area=area_desert; GameCont.subarea=1; GameCont.loops=0
        GameCont.rad=10000; GameCont.underwater=false
        UberCont.opt_framerate=rates[fix_rate]
        game_set_speed(rates[fix_rate],gamespeed_fps)
        for(var _dx=-5;_dx<=5;++_dx) for(var _dy=-4;_dy<=4;++_dy) instance_create(10000+_dx*32,10000+_dy*32,Floor)
        with (Floor) mcr_floor_make_walls;
        scrNTTEFixDecorTests()
        with (_player) {
            scrExtraWepsReset(); infammo=0; global.__debug_infammo=false
            scrNTTEFixCoilTests()
            scrNTTEFixThrowTests()
            scrNTTEConditionalPickupTests()
        }
        scrNTTESmokeLog("COIL TARGET/PROP/WALL/MUTATION/RAW BLOOD AND SIX GROUND WEAPONS OK @"+string(rates[fix_rate]))
        instance_destroy(enemy,false)
        instance_destroy(projectile,false)
        fix_victim=scrNTTEFixTestDummy(10080,10016)
        fix_ally=scrNTTEFixTestDummy(10060,10016,team_player)
        with (_player) other.fix_coil=scr_projectile_create(x,y,NTTECoil,0,0)
        fix_coil.life=20; fix_coil.initialized=true
        fix_coil.target=fix_victim; fix_coil.target_x=fix_victim.x; fix_coil.target_y=fix_victim.y
        fix_coil.wave=0
        fix_phase=0
    }
    fix_tick+=timescale
    if (fix_phase==0 && fix_tick>=12) {
        scrNTTESmokeLog("ARC TRACE hp="+string(fix_victim.hp)+" hits="+string(fix_coil.hit_count)+" team="+string(fix_coil.team)+" xy="+string(fix_victim.x)+","+string(fix_victim.y)+" end="+string(fix_coil.target_x)+","+string(fix_coil.target_y))
        assert(fix_victim.hp<=10000-28,"Continuous Tesla arc did not damage over time")
        assert(fix_victim.hp>=10000-42,"Tesla damage multiplied with frame rate")
        assert(fix_ally.hp==10000,"Tesla arc damaged a friendly unit")
        assert(fix_coil.hit_count>=2 && fix_coil.hit_count<=3,"Tesla shared native invulnerability mismatch")
        scrNTTESmokeLog("LIVE CONTINUOUS ARC/FRIENDLY FILTER/DAMAGE WINDOW OK @"+string(rates[fix_rate]))
        instance_destroy(enemy,false); instance_destroy(projectile,false)
        with (_player) {
            wep=wep_ntte_trident; bwep=wep_ntte_rogue_carbine
            ntte_state=scrNTTENewState(wep); bntte_state=scrNTTENewState(bwep)
            ntte_state.charge=7; curse=0; bcurse=0
            scrFire(wep)
            scrNTTEConsumeBoneSlots()
        }
        var _p=instance_find(NTTEAttack,0)
        _p.x=10112; _p.y=10016; _p.speed=0; _p.stuck=true
        with (_p) scrNTTEAttackStep()
        fix_pickup=instance_find(WepPickup,0)
        fix_phase=1
        fix_tick=0
    }
    if (fix_phase==1) {
        _player.x=10112; _player.y=10016
        KeyCont.press_pick[_player.index]=false
        if (fix_tick>=4) {
            assert(!instance_exists(fix_pickup) && _player.wep==wep_ntte_trident,"Live no-input collision did not recover thrown weapon")
            assert(_player.bwep==wep_ntte_rogue_carbine && _player.ntte_state.ammo==1,"Live pickup lost second weapon or restored ammo")
            scrNTTESmokeLog("LIVE EMPTY SLOT AUTO PICKUP WITHOUT INPUT OK @"+string(rates[fix_rate]))
            instance_deactivate_object(id)
            scrCleanupAreaInstances()
            instance_activate_object(id)
            assert(instance_number(NTTEDesertDecor)==0 && instance_number(Floor)==0,"Level cleanup retained old scenery")
            scrNTTESmokeLog("LEVEL CLEANUP REMOVES OLD SCENERY @"+string(rates[fix_rate]))
            if (++fix_rate>=3) {
                scrNTTESmokeLog("PASS WEAPON FIX 30/60/120: coil and Vampire, physical throws, conditional native autopick in either empty slot, full-slot manual control and cleanup")
                game_end(); return;
            }
            fix_tick=0; fix_phase=0
        }
    }
}

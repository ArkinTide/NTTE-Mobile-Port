function scrNTTEBatSmokeEnabled() {
    if (os_type!=os_windows) return false
    for(var _i=1;_i<=parameter_count();++_i) if (parameter_string(_i)=="--ntte-bat-smoke") return true
    return false
}

function scrNTTEConditionalPickupTests() {
    var _player=id,_weapons=[wep_ntte_trident,wep_ntte_golden_trident,wep_ntte_ancient_artifact,
        wep_ntte_guarded_artifact,wep_ntte_stolen_artifact,wep_ntte_missing_artifact]
    instance_destroy(WepPickup,false)
    for(var _i=0;_i<6;++_i) for(var _slot=0;_slot<3;++_slot) {
        var _keep=scrNTTENewState(wep_ntte_rogue_carbine)
        _keep.charge=9
        wep=_slot==0 ? 0:wep_ntte_rogue_carbine
        bwep=_slot==1 ? 0:(_slot==2 ? 0:wep_ntte_rogue_carbine)
        if (_slot==2) wep=0
        ntte_state=scr_weapon_is_valid(wep) ? _keep:undefined
        bntte_state=scr_weapon_is_valid(bwep) ? _keep:undefined
        curse=scr_weapon_is_valid(wep) ? 1:0; bcurse=scr_weapon_is_valid(bwep) ? 1:0
        var _drop=scrWeaponPickupCreate(x,y,_weapons[_i])
        _drop.ntte_throw_pickup=true; _drop.curse=2
        _drop.ntte_state=scrNTTENewState(_weapons[_i]); _drop.speed=0
        _drop.autopick=false; _drop.visible=true
        can_pick=true; KeyCont.press_pick[index]=false
        with (_drop) with (_player) event_perform(ev_collision,WepPickup)
        assert(!instance_exists(_drop) && wep==_weapons[_i] && curse==2 && ntte_state.ammo==1,"Either-empty-slot autopick failed or lost thrown state")
        if (_slot<2) assert(bwep==wep_ntte_rogue_carbine && bcurse==1 && bntte_state.charge==9,"Automatic pickup replaced occupied weapon or state")
        else assert(bwep==0,"Both-empty-slot pickup created a second weapon")
        assert(instance_number(WepPickup)==0,"Empty primary produced an invalid/duplicate drop")
    }
    // A full player's contact must not make the shared pickup auto for others.
    wep=wep_ntte_rogue_carbine; bwep=wep_ntte_tesla_coil
    ntte_state=scrNTTENewState(wep); bntte_state=scrNTTENewState(bwep)
    curse=0; bcurse=0
    var _drop=scrWeaponPickupCreate(x,y,wep_ntte_trident)
    _drop.ntte_throw_pickup=true; _drop.speed=0; _drop.autopick=false; _drop.visible=true
    with (_drop) with (_player) event_perform(ev_collision,WepPickup)
    assert(instance_exists(_drop) && !_drop.autopick && wep==wep_ntte_rogue_carbine && bwep==wep_ntte_tesla_coil,"Full slots automatically replaced a weapon")
    KeyCont.press_pick[index]=true
    with (_drop) with (_player) event_perform(ev_collision,WepPickup)
    assert(!instance_exists(_drop) && wep==wep_ntte_trident && bwep==wep_ntte_tesla_coil,"Full slots manual pickup no longer works")
    assert(instance_number(WepPickup)==1 && WepPickup.wep==wep_ntte_rogue_carbine,"Manual replacement failed to drop former weapon")
    instance_destroy(WepPickup,false)
    bwep=0
    _drop=scrWeaponPickupCreate(x,y,wep_ntte_trident)
    _drop.speed=0; _drop.autopick=false; _drop.visible=true
    KeyCont.press_pick[index]=false
    with (_drop) with (_player) event_perform(ev_collision,WepPickup)
    assert(instance_exists(_drop),"Ordinary non-thrown weapon unexpectedly autocollected")
    _drop.ntte_throw_pickup=true; can_pick=false
    with (_drop) with (_player) event_perform(ev_collision,WepPickup)
    assert(instance_exists(_drop),"Autopick ignored can_pick gate")
    can_pick=true; _drop.visible=false
    with (_drop) with (_player) event_perform(ev_collision,WepPickup)
    assert(instance_exists(_drop),"Autopick collected invisible weapon")
    instance_destroy(WepPickup,false)
    scrNTTESmokeLog("SIX THROWN WEAPONS EITHER/BOTH EMPTY CURSE STATE FULL/MANUAL ORDINARY/GATES OK")
}

function scrNTTEBatUnitTests() {
    var _bat=instance_create(10096,10016,NTTEBat)
    assert(_bat.hp==30 && _bat.raddrop==12 && _bat.ntte_bat_stress==20,"Bat original health/stress/drop mismatch")
    scr_hit(_bat,3)
    assert(_bat.hp==27 && _bat.ntte_bat_stress==23,"Bat hurt stress mismatch")
    var _gas=instance_create(_bat.x,_bat.y,ToxicGas)
    _gas.team=team_player
    with (_gas) scr_hit(_bat,1)
    assert(_bat.hp==26 && _bat.ntte_bat_stress==20 && _bat.ntte_bat_screeches==1,"Bat gas reaction mismatch")
    var _wave=instance_find(NTTEBatScreech,0)
    assert(_wave.image_xscale==0.5 && _wave.team==team_enemy,"Bat gas screech scale/faction mismatch")
    instance_destroy(projectile,false)
    with (_bat) other.bat_wave=scrNTTEBatScreech()
    _wave=bat_wave
    // Exercise real collision handlers, including same-faction bullet clearing
    // but same-faction grenade preservation, as in original NTTE.
    for(var _side=0;_side<2;++_side) {
        var _p=instance_create(10096,10016,HeavyBullet)
        _p.team=_side ? team_enemy:team_player
        with (_p) with (_wave) event_perform(ev_collision,projectile)
        assert(!instance_exists(_p),"Screech failed to clear ordinary bullet")
    }
    var _grenade=instance_create(10096,10016,Grenade)
    _grenade.team=team_enemy
    with (_grenade) with (_wave) event_perform(ev_collision,projectile)
    assert(instance_exists(_grenade),"Screech destroyed same-team grenade")
    _grenade.team=team_player
    with (_grenade) with (_wave) event_perform(ev_collision,projectile)
    assert(!instance_exists(_grenade),"Screech failed to destroy hostile grenade")
    var _victim=scrNTTEFixTestDummy(10120,10016,team_player),_ally=scrNTTEFixTestDummy(10120,10032,team_enemy)
    with (_victim) with (_wave) event_perform(ev_collision,hitme)
    with (_ally) with (_wave) event_perform(ev_collision,hitme)
    assert(_victim.hp==10000 && _victim.hspeed>0 && _ally.speed==0,"Screech push damaged HP or pushed an ally")
    _wave.damage=4; _wave.ntte_bat_force=1.5
    _victim.nexthurt=0
    with (_victim) with (_wave) event_perform(ev_collision,hitme)
    with (_victim) with (_wave) event_perform(ev_collision,hitme)
    with (_ally) with (_wave) event_perform(ev_collision,hitme)
    assert(_victim.hp==9996 && _ally.hp==10000,"Damaging enemy screech ignored faction or repeated damage during native I-frames")
    _wave.team=team_player; _ally.nexthurt=0
    with (_ally) with (_wave) event_perform(ev_collision,hitme)
    with (_victim) with (_wave) event_perform(ev_collision,hitme)
    assert(_ally.hp==9996 && _victim.hp==9996,"Friendly damaging screech failed hostile-only damage")
    _wave.damage=0; _wave.ntte_bat_force=1; _wave.team=team_enemy
    _wave.candeflect=true
    var _p=instance_create(10112,10016,HeavyBullet)
    _p.team=team_player
    with (_p) with (_wave) event_perform(ev_collision,projectile)
    assert(instance_exists(_p) && _p.team==team_enemy && _p.deflected,"Screech deflection mismatch")
    _wave.candeflect=false
    with (Player) {
        wep=wep_ntte_trident; bwep=0; ntte_state=scrNTTENewState(wep); ntte_state.charge=7; curse=0
        scrFire(wep); scrNTTEConsumeBoneSlots()
    }
    _p=instance_find(NTTEAttack,0)
    with (_p) with (_wave) event_perform(ev_collision,projectile)
    assert(!instance_exists(_p) && instance_number(WepPickup)==1,"Screech erased recoverable whole weapon")
    instance_destroy(WepPickup,false)
    instance_destroy(enemy,false); instance_destroy(projectile,false); instance_destroy(Explosion,false)
    _bat=instance_create(10096,10016,NTTEBat)
    _bat.team=team_player; _bat.ntte_charmed=true
    var _hostile=instance_create(10128,10016,Bandit)
    with (_bat) { scrTarget(); other.bat_wave=scrNTTEBatScreech() }
    assert(_bat.target==_hostile && bat_wave.team==team_player && !scrNTTEAimTargetAllowed(_bat,team_player),"Friendly bat targeting/faction/aim mismatch")
    instance_destroy(enemy,false); instance_destroy(projectile,false)
    // Enter preparation through the actual visible-target decision. Previously
    // the harness forced canfire=true and skipped this missing-resource branch.
    instance_destroy(PlasmaTrail,false)
    _bat=instance_create(10096,10016,NTTEBat)
    with (_bat) {
        repeat(128) {
            scrNTTEBatDecision()
            if (ntte_bat_canfire) break
        }
        assert(ntte_bat_canfire && ntte_bat_timer==10,"Bat never entered visible-target preparation")
    }
    assert(instance_number(PlasmaTrail)==1 && PlasmaTrail.sprite_index==sprAssassinNotice,"Bat preparation did not display existing notice sprite")
    assert(PlasmaTrail.x==_bat.x+4*_bat.right && PlasmaTrail.y==_bat.y,"Bat preparation notice anchor changed")
    scrNTTESmokeLog("BAT VISIBLE TARGET NATURAL PREPARATION NOTICE OK @"+string(rates[bat_rate]))
    instance_destroy(PlasmaTrail,false); instance_destroy(enemy,false); instance_destroy(projectile,false)
    scrNTTESmokeLog("BAT HP HURT GAS BULLET GRENADE PUSH DEFLECT THROWN PICKUP FRIENDLY OK")
}

function scrNTTEBatSmokeStep() {
    if (!variable_instance_exists(id,"bat_rate")) { bat_rate=0; bat_tick=0; bat_phase=0 }
    with (Player) {
        hp=10000; max_hp=10000; lsthealth=10000; nexthurt=current_frame+100
        can_walk=false; can_aim=false; speed=0; x=10016; y=10016; race=Race.Fish
    }
    if (bat_tick==0 && bat_phase==0) {
        scrNTTEDesertSmokeClear(); instance_destroy(Explosion,false)
        UberCont.opt_framerate=rates[bat_rate]; game_set_speed(rates[bat_rate],gamespeed_fps)
        GameCont.area=area_sewers; GameCont.hard=8; GameCont.rad=10000
        for(var _dx=-5;_dx<=5;++_dx) for(var _dy=-4;_dy<=4;++_dy) instance_create(10000+_dx*32,10000+_dy*32,Floor)
        with (Floor) mcr_floor_make_walls;
        scrNTTEBatUnitTests()
        bat_enemy=instance_create(10096,10016,NTTEBat)
        bat_enemy.ntte_bat_timer=10; bat_enemy.ntte_bat_canfire=true
        bat_enemy.gunangle=180
    }
    bat_tick+=timescale
    if (bat_phase==0 && bat_tick>=11) {
        assert(bat_enemy.ntte_bat_shots==1 && !bat_enemy.ntte_bat_canfire,"Bat live ten-tick shot failed")
        assert(instance_number(NTTEVenomPellet)==6,"Bat volley must contain six pellets")
        with (NTTEVenomPellet) assert(team==team_enemy && damage==2 && creator==other.bat_enemy,"Bat pellet lost native damage/owner/faction")
        instance_destroy(projectile,false)
        with (bat_enemy) other.bat_wave=scrNTTEBatScreech()
        bat_enemy.ntte_bat_timer=1000
        bat_phase=1; bat_tick=0
        scrNTTESmokeLog("BAT LIVE SIX PELLETS TEN TICK SHOT OK @"+string(rates[bat_rate]))
    }
    else if (bat_phase==1 && bat_tick>=21) {
        assert(!instance_exists(bat_wave) && bat_enemy.sprite_index!=bat_enemy.spr_fire,"Screech/yell did not expire in twenty logical ticks")
        scrNTTESmokeLog("BAT LIVE SCREECH/YELL LIFETIME OK @"+string(rates[bat_rate]))
        instance_destroy(enemy,false); instance_destroy(projectile,false)
        // Explicit encounter generation on a real native floor grid.
        var _result=scrNTTESewerPopulate(NTTESewerEvent.Bats)
        assert(_result==NTTESewerEvent.Bats && instance_number(NTTEBat)==4,"BATS custom encounter missing connected chamber or four bats")
        with (NTTEBat) assert(!place_meeting(x,y,Wall) && place_meeting(x,y,Floor),"BATS encounter enemy spawned in wall/outside floor")
        scrNTTESmokeLog("NATIVE BATS SEWER ENCOUNTER OK @"+string(rates[bat_rate]))
        if (++bat_rate>=3) {
            scrNTTESmokeLog("PASS BAT 30/60/120: original pixels, hurt/gas, six-pellet volley, screech collision/factions/expiry, physical weapon recovery and custom connected encounter")
            game_end(); return;
        }
        bat_tick=0; bat_phase=0
    }
}

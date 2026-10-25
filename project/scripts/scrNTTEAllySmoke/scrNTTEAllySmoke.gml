function scrNTTEAllySmokeEnabled() {
    if (os_type!=os_windows) return false
    for(var _i=1;_i<=parameter_count();++_i) if (parameter_string(_i)=="--ntte-ally-smoke") return true
    return false
}

function scrNTTEAllySmokeStep() {
    if (!variable_instance_exists(id,"ally_case")) { ally_case=0; ally_tick=0; ally_phase=0 }
    if (!instance_exists(Player)) { scrNTTESmokeLog("FAIL ally player lost"); game_end(); return; }
    with (Player) { hp=10000; max_hp=10000; lsthealth=10000; nexthurt=current_frame+100; can_walk=false; can_aim=false; speed=0; x=10016; y=10016; race=Race.Fish; mask_index=mskPlayer }
    // Keep the actual portal alive for assertions without entering the next level.
    with (Portal) { close=true; endgame=100; x=10144; y=10112 }
    if (ally_tick==0) {
        scrNTTEDesertSmokeClear()
        instance_destroy(Corpse,false)
        instance_destroy(NTTEClone,false)
        var _fps=rates[ally_case]
        UberCont.opt_framerate=_fps
        game_set_speed(_fps,gamespeed_fps)
        GameCont.area=area_desert; GameCont.subarea=1; GameCont.maxsubarea=3; GameCont.loops=0
        GameCont.ntte_ally_portal_timer=0
        for(var _dx=-5;_dx<=5;++_dx) for(var _dy=-4;_dy<=4;++_dy) instance_create(10000+_dx*32,10000+_dy*32,Floor)
        with (Floor) mcr_floor_make_walls;
        ally=instance_create(10112,10016,Bandit)
        ally.team=team_player; ally.ntte_charmed=true; ally.hp=10000; ally.raddrop=0
        hostile=instance_create(9888,10016,Bandit)
        hostile.hp=10000
        assert(scr_check_enemies(),"Hostile not counted")
        assert(!scr_check_enemies(1),"Ally included in threshold count")
        var _pending=instance_create(10016,10016,becomenemy)
        assert(scr_check_enemies(1),"Pending reinforcement ignored")
        _pending.team=team_player
        assert(!scr_check_enemies(1),"Friendly transformation blocked clear")
        instance_destroy(_pending,false)
        var _van=instance_create(10200,10016,Van),_missile=instance_create(10200,10016,BigDogMissile)
        assert(!scr_check_enemies(1),"Original Van/missile exclusions lost")
        instance_destroy(_van,false); instance_destroy(_missile,false)
        // Test the actual Clone Hammer factory, not only a synthetic team flag.
        var _swing=noone
        with (Player) _swing=scr_projectile_create(10016,10016,NTTESwing,0,0)
        with (_swing) scrNTTECloneEnemy(Bandit,10144,10016,10)
        var _clone=instance_find(NTTEClone,0)
        assert(instance_exists(_clone) && _clone.target.team==team_player,"Clone factory team")
        instance_destroy(_clone.target,false); instance_destroy(_clone,false); instance_destroy(_swing,false)
        ally_tick+=timescale
        scrNTTESmokeLog("ALLY START @"+string(_fps))
        return;
    }
    ally_tick+=timescale
    if (ally_phase==0 && ally_tick>=40) {
        assert(!instance_exists(Portal),"Portal opened with a hostile alive")
        hostile.hp=0
        instance_destroy(hostile)
        assert(!scr_check_enemies(),"Friendly survivor still blocks clear")
        ally_phase=1
    }
    if (ally_phase==1 && ally_tick>=150) {
        assert(instance_exists(Portal),"Native corpse alarm did not create portal with ally alive")
        assert(instance_exists(ally) && ally.hp>0,"Ally removed to force clear")
        scrNTTESmokeLog("ALLY LAST HOSTILE DEATH PORTAL OK @"+string(rates[ally_case]))
        instance_destroy(Portal,false); instance_destroy(Corpse,false); instance_destroy(projectile,false)
        // No new death event: changing the last hostile's team must still open it.
        var _last=instance_create(9888,10016,Bandit)
        _last.team=team_player; _last.hp=10000
        GameCont.ntte_ally_portal_timer=0
        ally_phase=2
    }
    if (ally_phase==2 && ally_tick>=250) {
        assert(instance_exists(Portal),"Charm without corpse never opened portal")
        scrNTTESmokeLog("ALLY CHARM WITHOUT CORPSE PORTAL OK @"+string(rates[ally_case]))
        instance_destroy(enemy,false); instance_destroy(Portal,false); instance_destroy(Corpse,false); instance_destroy(projectile,false)
        silver=instance_create(10096,10016,NTTESilverScorpion)
        silver.ntte_silver_decision=1
        silver.hp=10000
        ally_phase=3
    }
    if (ally_phase==3 && ally_tick>=290) {
        assert(silver.ntte_shots==10,"Silver volley must fire exactly 10 bullets")
        assert(silver.ntte_silver_flaks==1,"Silver volley must create one VenomFlak")
        var _orb=instance_find(NTTEScorpionOrb,0)
        // It may hit the player/wall and explode after charging; validate deaths separately.
        instance_destroy(projectile,false)
        silver.hp=0
        instance_destroy(silver)
        assert(instance_number(EnemyBullet2)>=13,"Silver death missing flak and 12 bullets")
        assert(instance_number(NTTEVenomPellet)==12,"Silver death missing 12 immediate venom pellets")
        instance_destroy(projectile,false)
        var _test_flak=noone
        with (Player) _test_flak=scr_projectile_create(10016,10016,NTTEScorpionOrb,0,3)
        flak=_test_flak
        flak.ntte_charge=30
        flak.ntte_orb_x=10016; flak.ntte_orb_y=10016
        flak.creator=noone
        ally_phase=4
    }
    if (ally_phase==4 && ally_tick>=310) {
        assert(instance_exists(flak) && !flak.ntte_orb_fired,"Flak charged too early")
        assert(abs(flak.x-10016)<12 && abs(flak.y-10016)<12,"Charging flak moved away")
        ally_phase=5
    }
    if (ally_phase==5 && ally_tick>=322) {
        assert(instance_exists(flak) && flak.ntte_orb_fired && flak.typ==1,"Flak did not launch at 30 logical frames")
        instance_destroy(projectile,false)
        assert(instance_number(NTTEVenomPellet)==0,"Silent flak cleanup spawned a burst")
        var _test_flak=noone
        with (Player) _test_flak=scr_projectile_create(10016,10016,NTTEScorpionOrb,0,0)
        flak=_test_flak
        instance_destroy(flak)
        assert(instance_number(NTTEVenomPellet)==28,"VenomFlak explosion must emit 20 cross-line and 8 radial pellets")
        instance_destroy(projectile,false)
        scrNTTESmokeLog("SILVER 10 SHOTS / 1 FLAK / CHARGE / DEATH / 28-PELLET EXPLOSION / SILENT CLEANUP OK @"+string(rates[ally_case]))
        scrNTTEAimAndRopeSmoke()
        ally_phase=0; ally_tick=0
        if (++ally_case>=3) {
            scrNTTESmokeLog("PASS ALLY PORTAL AND SILVER 30/60/120")
            game_end()
        }
    }
}

function scrNTTEAimAndRopeSmoke() {
    instance_destroy(enemy,false)
    instance_destroy(Corpse,false)
    var _p=instance_find(Player,0),_ally=instance_create(10048,10016,Bandit),_enemy=instance_create(10112,10016,Bandit)
    _ally.team=team_player; _ally.hp=10000; _enemy.hp=10000
    assert(scrNTTENearestAimEnemy(10016,10016,team_player)==_enemy,"Full autoaim selected closer ally")
    with (_p) {
        aimassist_target=_ally
        can_aim=true
        KeyCont.aimassist[index]=true
        KeyCont.hold_fire[index]=true
        gunangle=0
        event_perform(ev_step,ev_step_normal)
        assert(aimassist_target!=_ally,"Assist retained newly friendly cached target")
        KeyCont.hold_fire[index]=false
        KeyCont.aimassist[index]=false
        can_aim=false
    }
    _enemy.team=team_player
    assert(scrNTTENearestAimEnemy(10016,10016,team_player)==noone,"Full autoaim selected ally when no hostiles")
    instance_destroy(enemy,false)
    instance_destroy(projectile,false)
    with (_p) {
        x=10016; y=10016; speed=0
        ntte_last_harpoon=noone
        var _first=scrNTTEShot(NTTEKind.Harpoon,0,0)
        scrNTTEPairHarpoon(_first)
        assert(_first.link==id,"First harpoon was not connected to player")
        _first.x=x+32; _first.y=y
        var _launch_x=x
        with (_first) scrNTTERopeStep()
        assert(x>_launch_x && hspeed>0,"Flying harpoon failed to tug player")
        x=10016; y=10016; speed=0
        _first.x=x+96; _first.y=y; _first.stuck=true; _first.rope_length=64
        var _oldx=x
        with (_first) scrNTTERopeStep()
        assert(x>_oldx && hspeed>0,"Anchored harpoon failed to pull player")
        var _second=scrNTTEShot(NTTEKind.Harpoon,0,0)
        scrNTTEPairHarpoon(_second)
        assert(_second.link==_first && _first.link==noone,"Second shot did not transfer player rope endpoint")
        assert(ntte_last_harpoon==noone,"Paired harpoon retained stale owner handle")
        instance_destroy(_first,false); instance_destroy(_second,false)
        x=10016; y=10016; speed=0
    }
    scrNTTESmokeLog("AIM FRIENDLY FILTER / ASSIST CACHE / HARPOON OWNER PULL AND PAIR OK @"+string(rates[ally_case]))
}

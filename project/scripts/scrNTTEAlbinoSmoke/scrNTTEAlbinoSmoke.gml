function scrNTTEAlbinoSmokeEnabled() {
    if (os_type!=os_windows) return false
    for(var _i=1;_i<=parameter_count();++_i) if (parameter_string(_i)=="--ntte-albino-smoke") return true
    return false
}

function scrNTTEAlbinoSmokeStep() {
    if (!variable_instance_exists(id,"albino_rate")) { albino_rate=0; albino_tick=0; albino_phase=0 }
    with (Player) {
        hp=10000; max_hp=10000; lsthealth=10000; nexthurt=current_frame+100
        can_walk=false; can_aim=false; speed=0; x=10016; y=10016; race=Race.Fish
    }
    if (albino_tick==0 && albino_phase==0) {
        scrNTTEDesertSmokeClear(); instance_destroy(Explosion,false)
        UberCont.opt_framerate=rates[albino_rate]; game_set_speed(rates[albino_rate],gamespeed_fps)
        GameCont.area=area_sewers; GameCont.hard=8; GameCont.rad=10000
        for(var _dx=-5;_dx<=5;++_dx) for(var _dy=-4;_dy<=4;++_dy) instance_create(10000+_dx*32,10000+_dy*32,Floor)
        with (Floor) mcr_floor_make_walls;
        albino_gator=instance_create(10096,10016,NTTEAlbinoGator)
        var _hp=albino_gator.hp
        assert(_hp==32 && albino_gator.ntte_albino_spirit==23,"Albino original health/shield mismatch")
        scr_hit(albino_gator,10)
        assert(albino_gator.hp==32 && albino_gator.ntte_albino_spirit==13,"Albino shield did not absorb damage")
        scr_hit(albino_gator,20)
        assert(albino_gator.hp==32 && !albino_gator.ntte_albino_spirit_ready,"Shield-breaking shot leaked into HP")
        scr_hit(albino_gator,4)
        assert(albino_gator.hp==32,"Albino shield break invulnerability missing")
        albino_gator.ntte_albino_spirit_hurt=current_frame
        scr_hit(albino_gator,4)
        assert(albino_gator.hp==28,"Unshielded Albino did not lose HP")
        // Guarantee the original thirty-tick aim phase, then run it in real Steps.
        albino_gator.ntte_albino_charge=30; albino_gator.ntte_albino_timer=1
        albino_gator.hp=10000; albino_gator.max_hp=10000
        albino_gator.ntte_albino_spirit=14; albino_gator.ntte_albino_spirit_timer=10
        albino_gator.walk=0; albino_phase=0
        scrNTTESmokeLog("ALBINO SHIELD/BREAK/IFRAMES/HP OK @"+string(rates[albino_rate]))
    }
    albino_tick+=timescale
    if (albino_phase==0 && albino_tick>=35) {
        assert(albino_gator.ntte_albino_shots==1,"Albino charged shot timing mismatch")
        assert(albino_gator.ntte_albino_spirit_ready && albino_gator.ntte_albino_spirit==23,"Albino shield failed to regenerate")
        instance_destroy(enemy,false); instance_destroy(projectile,false)
        var _p=instance_find(Player,0)
        with (_p) other.albino_bolt=scr_projectile_create(10080,10016,NTTEAlbinoBolt,0,0)
        albino_bolt.ntte_albino_stuck=true
        // Seven splinters appear over four ticks after 20+30 logical frames.
        albino_bolt.ntte_albino_life=1000
        albino_phase=1; albino_tick=0
        scrNTTESmokeLog("ALBINO LIVE CHARGE AND SHIELD REGEN OK @"+string(rates[albino_rate]))
    }
    else if (albino_phase==1 && albino_tick>=54) {
        assert(!instance_exists(albino_bolt),"Albino main bolt did not finish burst")
        var _splinters=0
        with (NTTEAlbinoBolt) { assert(small && damage==3 && team==team_player,"Splinter lost damage/team"); _splinters+=1 }
        assert(_splinters==7,"Albino burst must emit 1+2+2+2 splinters")
        instance_destroy(projectile,false)
        with (Player) other.albino_grenade=scr_projectile_create(10080,10016,NTTEAlbinoGrenade,0,0)
        albino_phase=2; albino_tick=0
        scrNTTESmokeLog("ALBINO LIVE DELAYED SEVEN SPLINTERS OK @"+string(rates[albino_rate]))
    }
    else if (albino_phase==2 && albino_tick>=81) {
        assert(!instance_exists(albino_grenade) && instance_number(NTTEBeam)==4,"Albino grenade missing four cross beams")
        with (NTTEBeam) assert(team==team_player && detached && scale_goal==0.8 && variable_instance_exists(id,"ntte_albino_turn"),"Albino cross beam lost faction/turn")
        assert(instance_number(Explosion)>0,"Albino grenade missing neutral explosion")
        with (Explosion) assert(team==team_none,"Albino grenade explosion must be neutral")
        instance_destroy(projectile,false); instance_destroy(Explosion,false)
        var _silent=instance_create(10080,10016,NTTEAlbinoGrenade)
        instance_destroy(_silent,false)
        assert(instance_number(NTTEBeam)==0 && instance_number(Explosion)==0,"Silent grenade cleanup exploded")
        var _friendly=instance_create(10080,10016,NTTEAlbinoGator),_hostile=instance_create(10112,10016,Bandit)
        _friendly.team=team_player; _friendly.ntte_charmed=true
        with (_friendly) scrTarget()
        assert(_friendly.target==_hostile && !scrNTTEAimTargetAllowed(_friendly,team_player),"Friendly Albino target/aim mismatch")
        scrNTTESmokeLog("ALBINO LIVE GRENADE/CROSS BEAMS/SILENT CLEANUP/ALLY OK @"+string(rates[albino_rate]))
        if (++albino_rate>=3) {
            scrNTTESmokeLog("PASS ALBINO 30/60/120: shield, break, regen, charged shot, delayed seven splinters, four-beam grenade, silent cleanup and friendly targeting")
            game_end(); return;
        }
        albino_tick=0; albino_phase=0
    }
}

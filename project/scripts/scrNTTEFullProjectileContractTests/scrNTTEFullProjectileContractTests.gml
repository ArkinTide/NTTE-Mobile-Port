// Reproduce the reported native collision paths, including their real caller
// scopes. No test-only fields are added to GammaGuts or VenomBlast.
function scrNTTEFullProjectileContractTests() {
    var _before=scrNTTEFullInstances(all),_players=scrNTTEFullAreaGeneratorSnapshot(Player),
        _game=scrNTTEFullAreaGeneratorSnapshot(GameCont),_back=scrNTTEFullAreaGeneratorSnapshot(BackCont),
        _seed=random_get_seed(),_frame=current_frame,_p=instance_find(Player,0)
    current_frame=8
    try {
        _p.x=70016;_p.y=70016
        var _boss=instance_create(71040,70016,NTTEFullPitSquid),
            _arm=instance_create(70016,70016,NTTEFullPitSquidArm),
            _sibling=instance_create(71200,70016,NTTEFullPitSquidArm),
            _gamma=instance_create(70016,70016,GammaGuts)
        _boss.hp=300;_boss.max_hp=400;_boss.ntte_full_last_hp=300;_boss.speed=0
        _arm.hp=30;_arm.creator=_boss;_arm.team=team_enemy;_arm.nexthurt=0
        _sibling.creator=_boss
        _gamma.creator=_p;_gamma.team=_p.team
        assert(!variable_instance_exists(_gamma,"hitid"),
            "GammaGuts contact fixture was changed into a projectile")
        with(_arm) with(_gamma) event_perform(ev_collision,enemy)
        assert(_arm.hp==24 && _boss.hp==294 && _sibling.nexthurt==current_frame+6
            && !variable_instance_exists(_gamma,"hitid") && _gamma.creator==_p,
            "Real GammaGuts collision failed contact damage, boss forwarding or source identity")
        // Raw callbacks have their own direction/force semantics and still
        // forward only the arm's pre-hit remaining HP through an ordinary hit.
        _arm.hp=2
        with(_gamma) scrNTTEFullRawHit(_arm,6,0)
        assert(_arm.hp==-4 && _boss.hp==292 && _boss.speed==0,
            "Non-projectile raw arm callback lost overkill cap or zero-force forwarding")

        var _blast=noone
        with(_p) _blast=scr_projectile_create(72016,70016,NTTEFullVenomBlast,35,0)
        var _screech=instance_create(72016,70016,NTTEBatScreech),
            _slash=instance_create(72016,70016,EnemySlash)
        _screech.team=team_enemy;_slash.team=team_enemy;_slash.direction=90;_slash.image_angle=90
        assert(_blast.typ==-1 && _blast.creator==_p && _blast.damage==2
            && _blast.knockback_speed==2*timescale && _blast.charge,
            "VenomBlast did not retain CustomProjectile immunity/owner/authored damage/charge")
        var _direction=_blast.direction,_angle=_blast.image_angle,_team=_blast.team,
            _scale=_blast.image_xscale,_deflects=instance_number(Deflect),_impacts=instance_number(ThrowHit)
        with(_blast) with(_screech) event_perform(ev_collision,projectile)
        assert(instance_exists(_blast) && _blast.direction==_direction && _blast.team==_team
            && instance_number(ThrowHit)==_impacts,
            "Real bat screech destroyed an immune close-range VenomBlast")
        _screech.candeflect=true
        with(_blast) with(_screech) event_perform(ev_collision,projectile)
        assert(instance_exists(_blast) && _blast.direction==_direction && _blast.team==_team
            && instance_number(Deflect)==_deflects,
            "Deflecting screech changed an immune VenomBlast")
        with(_blast) with(_slash) event_perform(ev_collision,projectile)
        assert(instance_exists(_blast) && _blast.direction==_direction && _blast.image_angle==_angle
            && _blast.image_xscale==_scale && _blast.team==_team && _blast.charge,
            "Real EnemySlash collision reflected/destroyed VenomBlast or changed its charge")
        // The fix must not disable real destructible projectiles globally.
        var _pellet=noone
        with(_p) _pellet=scr_projectile_create(72016,70016,NTTEVenomPellet,0,4)
        assert(_pellet.typ==2,"Destructible VenomPellet fixture lost source type")
        with(_pellet) with(_slash) event_perform(ev_collision,projectile)
        assert(!instance_exists(_pellet),"EnemySlash stopped destroying typ2 projectiles")
        var _bullet=noone
        with(_p) _bullet=scr_projectile_create(72016,70016,Bullet1,0,4)
        with(_bullet) with(_slash) event_perform(ev_collision,projectile)
        assert(instance_exists(_bullet) && _bullet.direction==_slash.direction
            && _bullet.image_angle==_slash.image_angle,"EnemySlash stopped reflecting typ1 projectiles")
    }
    finally {
        var _all=scrNTTEFullInstances(all)
        for(var _i=array_length(_all)-1;_i>=0;--_i)
            if(array_get_index(_before,_all[_i])<0 && instance_exists(_all[_i])) instance_destroy(_all[_i],false)
        scrNTTEFullAreaGeneratorRestore(_players);scrNTTEFullAreaGeneratorRestore(_game);scrNTTEFullAreaGeneratorRestore(_back)
        random_set_seed(_seed);current_frame=_frame
    }
    scrNTTESmokeLog("FULL PROJECTILE CONTRACT: real GammaGuts contact/raw arm forwarding, overkill cap, VenomBlast versus ordinary/deflecting screech and EnemySlash, typ1/2 controls OK @"+string(30/timescale))
}

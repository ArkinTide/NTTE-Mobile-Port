function scrNTTEFullNativeProjectileHitTests() {
    var _before=scrNTTEFullInstances(all),_players=scrNTTEFullAreaGeneratorSnapshot(Player),
        _game=scrNTTEFullAreaGeneratorSnapshot(GameCont),_back=scrNTTEFullAreaGeneratorSnapshot(BackCont),
        _seed=random_get_seed(),_p=instance_find(Player,0)
    try {
        var _shot=instance_create(92000,92000,Bullet1),_enemy=instance_create(92000,92032,Bandit)
        _shot.team=2;_shot.direction=0;_enemy.team=1;_enemy.hp=20;_enemy.nexthurt=current_frame+1000
        var _can=false
        with(_shot) _can=scrNTTEFullNativeProjectileCanHitNP(_enemy)
        assert(_can,"Original nonpiercing eligibility incorrectly respects enemy presentation invulnerability")
        _enemy.team=2
        with(_shot) _can=scrNTTEFullNativeProjectileCanHitNP(_enemy)
        assert(!_can,"Original nonpiercing eligibility admitted same-team target")
        _enemy.team=1;_enemy.hp=0
        with(_shot) _can=scrNTTEFullNativeProjectileCanHitNP(_enemy)
        assert(!_can,"Original nonpiercing eligibility admitted dead target")
        _p.team=1;_p.hp=20;_p.nexthurt=current_frame+1
        with(_shot) _can=scrNTTEFullNativeProjectileCanHitNP(_p)
        assert(!_can,"Original nonpiercing eligibility ignored Player invulnerability")
        _p.nexthurt=current_frame
        with(_shot) _can=scrNTTEFullNativeProjectileCanHitNP(_p)
        assert(_can,"Original nonpiercing eligibility rejected exactly expired Player invulnerability")
        _enemy.hp=20;_enemy.hspeed=0;_enemy.vspeed=0;_enemy.friction=0.2*timescale*timescale
        var _force=4*timescale+(1-timescale)*_enemy.friction/2
        with(_shot) scrNTTEFullNativeProjectileHitNP(_enemy,3,4,40)
        assert(_enemy.hp==17 && abs(_enemy.hspeed-_force)<0.0001 && abs(_enemy.vspeed)<0.0001
            && _enemy.nexthurt==current_frame+6 && _enemy.sprite_index==_enemy.spr_hurt,
            "Original native np damage/direction/friction-adjusted motion/hurt presentation differs")
        _enemy.hspeed=0;_enemy.vspeed=0
        with(_shot) scrNTTEFullNativeProjectileHitPush(_enemy,0,4)
        assert(_enemy.hp==17 && abs(_enemy.vspeed-_force)<0.0001 && abs(_enemy.hspeed)<0.0001,
            "Original native push lost radial origin direction or source zero-damage force")
        with(_shot) scrNTTEFullNativeProjectileHitNP(_enemy,-2,0,0)
        assert(_enemy.hp==19,"Original native np negative damage was silently clamped")
        var _damage_before=_p.totdamagetaken
        _p.x=92032;_p.y=92000;_p.hspeed=0;_p.vspeed=0;_p.friction=0
        with(_shot) scrNTTEFullNativeProjectileHitNP(_p,2,3,0)
        assert(_p.hp==18 && _p.totdamagetaken==_damage_before && abs(_p.hspeed-3*timescale)<0.0001,
            "Original native np Player branch entered Epsilon damage procs or lost radial force")
        var _baby=instance_create(92100,92100,NTTEBabyGator),_health=_baby.hp
        _baby.team=1
        var _smoke=instance_number(Smoke)
        with(_shot) scrNTTEFullNativeProjectileHitNP(_baby,1,0,40)
        assert(_baby.hp==_health-1 && instance_number(Smoke)==_smoke+1,
            "Original custom np hurt callback lost damage or ran BabyGator callback twice")
    } finally {
        var _all=scrNTTEFullInstances(all)
        for(var _i=array_length(_all)-1;_i>=0;--_i)
            if(array_get_index(_before,_all[_i])<0 && instance_exists(_all[_i])) instance_destroy(_all[_i],false)
        scrNTTEFullAreaGeneratorRestore(_players);scrNTTEFullAreaGeneratorRestore(_game);scrNTTEFullAreaGeneratorRestore(_back)
        random_set_seed(_seed)
    }
    scrNTTESmokeLog("FULL NATIVE PROJECTILE HIT: original team/health/Player iframe split, np vs radial push, zero/negative damage, friction-corrected force and authored custom hurt callback once OK @"+string(30/timescale))
}

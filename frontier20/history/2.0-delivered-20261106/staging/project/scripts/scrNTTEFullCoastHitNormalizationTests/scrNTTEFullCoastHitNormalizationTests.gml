function scrNTTEFullCoastHitNormalizationTests() {
    var _before=scrNTTEFullInstances(all),_tick=current_frame
    try {
        current_frame=20
        var _crab=instance_create(96000,96000,NTTEFullTrafficCrab),
            _bullet=instance_create(96000,96064,Bullet1),_force=2*timescale
        _bullet.direction=90;_crab.hspeed=0;_crab.vspeed=0
        var _hp=_crab.hp
        with(_bullet) scr_hit(_crab,1,HitId.None,false,undefined,_force)
        assert(_crab.hp==_hp-1 && abs(_crab.hspeed)<=0.00001
            && abs(_crab.vspeed+_force)<=0.00001,
            "TrafficCrab ordinary authored hurt ran before caller direction normalization")
        _crab.hspeed=0;_crab.vspeed=0
        with(_bullet) scr_hit(_crab,1,HitId.None,1,45,100)
        assert(_crab.hp==_hp-2 && _crab.speed==0,
            "TrafficCrab raw hurt bypassed source zero-force normalization")
    }
    finally {
        scrNTTEFullMergedRuntimeTestCleanup(_before)
        current_frame=_tick
    }
    scrNTTESmokeLog("FULL COAST HURT NORMALIZATION: actual Bullet caller direction and raw zero force before complete TrafficCrab callback OK @"+string(30/timescale))
}


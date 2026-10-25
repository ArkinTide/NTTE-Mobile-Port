// Source action QA; no ordinary combat/campaign/device claim.
function scrNTTEFullPitSquidEyeChargeOracle(_x,_y,_delay,_active) {
    if(!_active) return 0;
    if(random(_delay)<10*timescale) {
        if(random(7)<1) {
            var _inst=instance_create(_x+random_range(-12,12),_y,PortalL)
            var _sprites=[sprNTTERefPitSparkI0,sprNTTERefPitSparkI1,sprNTTERefPitSparkI2,sprNTTERefPitSparkI3,sprNTTERefPitSparkI4]
            _inst.sprite_index=_sprites[irandom(array_length(_sprites)-1)]
            if(random(2)<1) {
                _inst.sprite_index=asset_get_index("sprPortalL"+string(irandom_range(1,5)))
                return 2;
            }
            return 1;
        }
        var _inst=instance_create(_x+random_range(-16,16),_y,PlasmaTrail)
        _inst.sprite_index=sprNTTERefQuasarBeamTrail
        _inst.hspeed+=random_range(-1.5,1.5)*timescale
        _inst.vspeed+=random_range(-0.8,0.8)*timescale
        return 3;
    }
    return 0;
}
function scrNTTEFullPitSquidEyeChargeCapture(_before) {
    var _now=scrNTTEFullInstances(all),_rows=[]
    for(var _i=0;_i<array_length(_now);++_i) {
        var _fx=_now[_i]
        if(array_get_index(_before,_fx)>=0) continue;
        array_push(_rows,[_fx.object_index,_fx.sprite_index,_fx.x,_fx.y,_fx.image_index,_fx.image_speed,
            _fx.image_angle,_fx.image_xscale,_fx.image_yscale,_fx.hspeed,_fx.vspeed,_fx.depth,_fx.visible,
            scrNTTEFullValue(_fx,"animation_speed",-999),scrNTTEFullValue(_fx,"creator",-999)])
    }
    return _rows;
}
function scrNTTEFullPitSquidEyeChargeClean(_before) {
    var _now=scrNTTEFullInstances(all)
    for(var _i=0;_i<array_length(_now);++_i) if(array_get_index(_before,_now[_i])<0) instance_destroy(_now[_i],false)
}
function scrNTTEFullPitSquidEyeChargeOne(_squid,_seed,_delay,_active) {
    _squid.x=1000000;_squid.y=1000000;_squid.hspeed=0;_squid.vspeed=0
    _squid.ntte_full_eye_distance=-24;_squid.ntte_full_eye_dir=0;_squid.ntte_full_eye_turn=0
    _squid.ntte_full_eye_laser=_active?100:0;_squid.ntte_full_eye_laser_delay=_delay
    _squid.ntte_full_pit_height=1;_squid.ntte_full_intro=true
    _squid.ntte_full_spit=0;_squid.ntte_full_bite=0;_squid.image_speed=0.4*timescale
    _squid.ntte_full_eye=[{x:0,y:0,distance:0,dir:0,blink:true,frame:-100,laser:noone}]
    var _before=scrNTTEFullInstances(all)
    try {
        random_set_seed(_seed)
        var _kind=scrNTTEFullPitSquidEyeChargeOracle(1000000,1000000,_delay,_active)
        var _expected=scrNTTEFullPitSquidEyeChargeCapture(_before),_rng=[]
        repeat(6) array_push(_rng,random(1))
        scrNTTEFullPitSquidEyeChargeClean(_before);random_set_seed(_seed)
        with(_squid) scrNTTEFullPitSquidEyes()
        var _actual=scrNTTEFullPitSquidEyeChargeCapture(_before),_actual_rng=[]
        repeat(6) array_push(_actual_rng,random(1))
        assert(json_stringify(_actual)==json_stringify(_expected),"PitSquid eye charge real fields mismatch seed="+string(_seed)+" delay="+string(_delay)+" kind="+string(_kind)+" expected="+json_stringify(_expected)+" actual="+json_stringify(_actual))
        assert(json_stringify(_actual_rng)==json_stringify(_rng),"PitSquid eye charge next-six RNG mismatch seed="+string(_seed)+" delay="+string(_delay))
        return _kind;
    } finally {scrNTTEFullPitSquidEyeChargeClean(_before)}
}
function scrNTTEFullPitSquidEyeChargeFXTests() {
    assert(os_type==os_windows && scrNTTEFullSmokeEnabled(),"Eye charge QA requires explicit Windows smoke")
    var _rate=game_get_speed(gamespeed_fps)
    assert((_rate==30 || _rate==60) && abs(timescale-30/_rate)<0.0001,"Eye charge QA requires settled actual30/60 timing")
    var _old_seed=random_get_seed(),_before=scrNTTEFullInstances(all),_squid=noone
    try {
        _squid=instance_create(1000000,1000000,NTTEFullPitSquid)
        assert(instance_exists(_squid),"Real native PitSquid constructor failed")
        var _counts=[0,0,0,0],_delays=[0,1,60,120]
        for(var _d=0;_d<array_length(_delays);++_d) for(var _seed=1;_seed<=128;++_seed) {
            var _kind=scrNTTEFullPitSquidEyeChargeOne(_squid,_seed,_delays[_d],true)
            _counts[_kind]+=1
        }
        for(var _seed=1;_seed<=16;++_seed) assert(scrNTTEFullPitSquidEyeChargeOne(_squid,_seed,60,false)==0,"Inactive eye produced charge FX")
        for(var _kind=0;_kind<4;++_kind) assert(_counts[_kind]>0,"Source branch coverage missing "+string(_kind))
        scrNTTESmokeLog("PASS PITSQUID EYE CHARGE SOURCE: native Eyes;512 seeded actions+16 inactive;delay0/1/60/120;gate-false/PitSpark/plainPortalL/QuasarTrail="+json_stringify(_counts)+";exact native fields+RNG6 @"+string(_rate))
    } finally {scrNTTEFullPitSquidEyeChargeClean(_before);random_set_seed(_old_seed)}
}

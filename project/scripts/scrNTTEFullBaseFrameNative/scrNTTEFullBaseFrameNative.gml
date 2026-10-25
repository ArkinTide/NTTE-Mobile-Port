// ntte.mod.gml 3850..3892/3987..4017: adjustments to existing engine bodies.
// NTT Crown is Epsilon's CrownObject (same animated walking crown entity).
function scrNTTEFullBaseFrameStep() {
    with(CrownObject) if(hspeed!=0 && sign(image_xscale)!=sign(hspeed))
        image_xscale=abs(image_xscale)*sign(hspeed)
    if(instance_exists(SpiralCont) && (instance_exists(GenCont) || instance_exists(LevCont))) {
        with(WepPickup) {
            if(!instance_exists(scrNTTEFullValue(id,"portal_inst",noone))) {
                // The original visual is independent of the gameplay RNG.
                // Restore around the full native constructor, not only its
                // authored fields, since that constructor also draws randoms.
                var _seed=random_get_seed()
                portal_inst=instance_create(SpiralCont.x,SpiralCont.y,SpiralDebris)
                with(portal_inst) {
                    sprite_index=other.sprite_index;image_index=0
                    turnspeed=orandom(1);rotspeed=orandom(15);dist=random_range(80,120)
                }
                random_set_seed(_seed)
            }
            with(portal_inst) {
                sprite_index=other.sprite_index
                image_xscale=0.7+0.1*sin(-image_angle/400)
                image_yscale=image_xscale;grow=0
            }
        }
    }
}
function scrNTTEFullBaseFrameEndStep() {
    with(RavenFly) {
        if(depth> -6) {depth=-9;visible=true}
        // telib anim_end includes reverse playback; Epsilon stores the
        // actual per-frame image speed, already scaled to the current rate.
        if(sprite_index==sprRavenLand && depth==-9
            && (image_index+image_speed>=image_number || image_index+image_speed<0)) depth=-2
    }
    with(LilHunterFly) {
        if(depth> -6) {depth=-9;visible=true}
        if(sprite_index==sprLilHunterLand && depth==-9 && z>= -10*timescale) depth=-2
    }
}

// BEGIN NTTE PLAYER RATE BOOTSTRAP
function scrNTTEFullRateScale(_rate) {
    if(_rate>=game_speed_uncaped) return 1;
    return clamp(logic_rate_fps/max(1,_rate),0.01,1);
}
function scrNTTEFullPlayerRateSync() {
    var _now=timescale,_old=scrNTTEFullValue(id,"ntte_player_physics_scale",_now);
    if(!is_real(_old) || _old<=0) _old=_now;
    if(_old!=_now) {
        var _ratio=_now/_old;
        maxspeed*=_ratio;speed*=_ratio;friction*=_ratio*_ratio;image_speed*=_ratio;
    }
    ntte_player_physics_scale=_now;
}
function scrNTTEFullRateApply() {
    global.time_scale=scrNTTEFullRateScale(game_get_speed(gamespeed_fps));
    with(Player) scrNTTEFullPlayerRateSync();
}
function scrNTTEFullPlayerRateAfterLoad(_saved) {
    if(!variable_instance_exists(id,"maxspeed") || !variable_instance_exists(id,"race") || !variable_instance_exists(id,"footextra")) return;
    var _base=4;
    if(race==Race.Plant) _base=4.5;
    else if(race==Race.BigDog) _base=2;
    else if(race==Race.Skeleton) _base=3;
    var _canonical=_base+0.5*footextra;
    var _old=variable_struct_exists(_saved,"ntte_player_physics_scale")?_saved.ntte_player_physics_scale:(_canonical>0?maxspeed/_canonical:timescale);
    if(is_real(_old) && _old>0) maxspeed*=timescale/_old;
    else maxspeed=_canonical*timescale;
    ntte_player_physics_scale=timescale;
}
function scrNTTEFullPlayerWalkCap(_nominal) {
    return max(0,_nominal+friction*(1-1/timescale));
}
// END NTTE PLAYER RATE BOOTSTRAP

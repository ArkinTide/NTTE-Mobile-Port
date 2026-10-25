// Original 9940 scrEnemyCanHit/scrEnemyHit/scrPushHit, recovered read-only.
// These APIs are opt-in for faithful MOD objects, preserving the accepted
// ordinary Epsilon pipeline. Force arguments here are original logical units.
function scrNTTEFullNativeProjectileCanHitNP(_target) {
    return instance_exists(_target) && _target.team!=team && _target.hp>0
        && (!instance_is(_target,Player) || _target.nexthurt<=current_frame)
}
function scrNTTEFullNativeMotionAddFT(_target,_direction,_force) {
    with(_target) {
        // motion_add_ft = force*current_time_scale
        //                 +(1-current_time_scale)*native friction/2.
        motion_add(_direction,_force*timescale+(1-timescale)*friction/2)
        // Original speed_min(0), including friction compensation.
        speed=max(speed,-friction*(1/timescale-1))
    }
}
function scrNTTEFullNativeProjectileDirectHit(_target,_damage,_force,_direction,_freeze) {
    if(!instance_exists(_target)) return false
    if(instance_is(_target,Player)) {
        var _cause=scrNTTEFullValue(id,"hitid",HitId.None)
        if(is_array(_cause) || is_numeric(_cause)) {
            _target.ntte_last_hit=_cause
            if(scr_player_is_local(_target.index) && _damage>0) GameCont.deathcause=_cause
        }
    }
    if(scrNTTEFullRawHitCustom(_target)) {
        // Authored MOD hurt callbacks own damage, force, sprite and sound.
        // This internal mode permits source zero/negative hurt arguments and
        // retains their actual direction, unlike projectile_hit_raw.
        return scr_projectile_hit(_target,_damage,_force*timescale,_direction,true)
    }
    _target.hp-=_damage
    if(instance_is(_target,Player) && _freeze>0) sleep(_freeze)
    scrNTTEFullNativeMotionAddFT(_target,_direction,_force)
    scrNTTEFullRawHitNative(_target,0,1)
    return true
}
function scrNTTEFullNativeProjectileHitNP(_target,_damage,_force,_freeze) {
    if(!instance_exists(_target)) return false
    var _direction=instance_is(_target,Player)?point_direction(x,y,_target.x,_target.y):direction
    return scrNTTEFullNativeProjectileDirectHit(_target,_damage,_force,_direction,_freeze)
}
function scrNTTEFullNativeProjectileHitPush(_target,_damage,_force) {
    if(!instance_exists(_target)) return false
    return scrNTTEFullNativeProjectileDirectHit(_target,_damage,_force,
        point_direction(x,y,_target.x,_target.y),0)
}

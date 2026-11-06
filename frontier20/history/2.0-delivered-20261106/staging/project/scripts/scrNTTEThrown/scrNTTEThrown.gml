function scrNTTEIsGroundWeapon(_weapon) {
    return scrNTTEIsTrident(_weapon) || (_weapon>=wep_ntte_ancient_artifact && _weapon<=wep_ntte_missing_artifact)
}

function scrNTTEThrowLand() {
    if (!scrNTTEIsGroundWeapon(weapon)) return false
    // One physical weapon moves from the firing slot into this pickup. Cleanup
    // never refunds it or creates a second item during room transitions.
    var _pickup=scrWeaponPickupCreate(x,y,weapon),_restored=scrNTTENewState(weapon)
    if (is_struct(state)) _restored=json_parse(json_stringify(state))
    _restored.ammo=_restored.capacity
    _restored.outstanding=0
    _restored.charge=0
    _restored.epoch+=1
    _restored.loaded=true
    _pickup.ntte_state=_restored
    _pickup.curse=throw_curse
    _pickup.speed=0
    _pickup.image_angle=image_angle
    _pickup.ntte_throw_pickup=true
    _pickup.ntte_throw_target=instance_exists(target) && target.hp>0 ? target:noone
    _pickup.ntte_throw_x=stick_x
    _pickup.ntte_throw_y=stick_y
    _pickup.autopick=false
    _pickup.slowreturn=false
    _pickup.creator=noone
    // The pickup must be reachable from the floor side of a wall impact.
    if (_pickup.ntte_throw_target==noone) scrNTTEDesertBudge(_pickup)
    refund=0
    instance_destroy()
    return true
}

function scrNTTEGroundPickupStep() {
    if (!variable_instance_exists(id,"ntte_throw_pickup") || !ntte_throw_pickup) return;
    speed=0
    if (instance_exists(ntte_throw_target) && ntte_throw_target.hp>0) {
        x=ntte_throw_target.x+ntte_throw_x
        y=ntte_throw_target.y+ntte_throw_y
    }
    else if (ntte_throw_target!=noone) {
        ntte_throw_target=noone
        scrNTTEDesertBudge(id)
    }
}

function scrNTTEVampireRefill(_state) {
    _state.ammo=_state.capacity
    // Original projectile_hit_raw: an exact 1 HP blood-ammo cost, independent
    // of damage modifiers, Strong Spirit, shield immunity and hit invulnerability.
    if (!instance_is(id,Player)) return;
    hp=max(0,hp-1)
    GameCont.deathcause=[sprNTTEBatTether,"PLAYING GOD"]
    drawlowhp=30
    if (hp>0) {
        snd_play(sndGammaGutsProc,random_range(0.9,1.2))
        snd_play(sndHitFlesh,random_range(0.8,1.2))
        scr_screenshake(12)
    }
    else {
        snd_play(sndGammaGutsKill)
        scr_screenshake(24)
    }
}

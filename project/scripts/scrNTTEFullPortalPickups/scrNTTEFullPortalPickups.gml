// tecoast5831..5910. A single normal-step binder coalesces activation calls.
function scrNTTEFullPortalPickupsInit() {
    if (!instance_exists(NTTEFullPortalPickups)) instance_create(0,0,NTTEFullPortalPickups)
}
function scrNTTEFullWorldPickupTypes() {
    // Epsilon flattened the NTT Pickup ancestor into independent families.
    return [AmmoPickup,HPPickup,RogueAmmo,WepPickup,Rad,BigRad,CrownPickup,CursedPickup,NTTEPickup,NTTEFullCustomPickup]
}
function scrNTTEFullPortalPickups() {
    scrNTTEFullPortalPickupsInit()
    with (NTTEFullPortalPickups) visible=true
}
function scrNTTEFullPortalPickupsMove(_pickup,_distance) {
    with (_pickup) {
        var _player=instance_nearest(x,y,Player)
        if (instance_exists(_player)) {
            var _direction=point_direction(x,y,_player.x,_player.y),_x=x+lengthdir_x(_distance,_direction),_y=y+lengthdir_y(_distance,_direction)
            if (place_free(_x,y)) x=_x
            if (place_free(x,_y)) y=_y
        }
    }
}
function scrNTTEFullPortalPickupsStep() {
    if (lockstep_stop || !visible) return;
    visible=false
    if (instance_exists(Portal) || !instance_exists(Player)) return;
    var _pluto=scr_skill_get(mut_plutonium_hunger),_distance=30+40*_pluto,_types=[AmmoPickup,HPPickup,RogueAmmo]
    for(var _i=0;_i<array_length(_types);++_i) {
        var _pickups=scrNTTEFullInstances(_types[_i])
        for(var _j=0;_j<array_length(_pickups);++_j) {
            var _pickup=_pickups[_j],_player=instance_nearest(_pickup.x,_pickup.y,Player)
            if (instance_exists(_player) && point_distance(_pickup.x,_pickup.y,_player.x,_player.y)>=_distance) scrNTTEFullPortalPickupsMove(_pickup,6*timescale)
        }
    }
    _distance=80+60*_pluto
    var _rads=scrNTTEFullInstances(Rad),_big=scrNTTEFullInstances(BigRad)
    for(var _i=0;_i<array_length(_big);++_i) if (array_get_index(_rads,_big[_i])<0) array_push(_rads,_big[_i])
    for(var _i=0;_i<array_length(_rads);++_i) {
        var _rad=_rads[_i]
        with (_rad) if (speed==0) {
            var _proto=instance_nearest(x,y,ProtoStatue)
            if (!instance_exists(_proto) || distance_to_object(_proto)>=170 || collision_line(x,y,_proto.x,_proto.y,Wall,false,false)) {
                if (distance_to_object(Player)>=_distance) scrNTTEFullPortalPickupsMove(id,12*timescale)
            }
        }
    }
}
function scrNTTEFullPortalPickupsSmoke() {
    var _before=scrNTTEFullInstances(all),_player=instance_find(Player,0),_px=_player.x,_py=_player.y
    _player.x=65000; _player.y=65000
    // Test far beyond either source attraction radius, independent of equipped skills.
    var _ammo=instance_create(_player.x+1000,_player.y,AmmoPickup),_rad=instance_create(_player.x+1000,_player.y+200,Rad)
    _ammo.speed=0; _rad.speed=0
    var _ax=_ammo.x,_rx=_rad.x
    scrNTTEFullPortalPickups(); scrNTTEFullPortalPickups()
    with (NTTEFullPortalPickups) scrNTTEFullPortalPickupsStep()
    assert(abs((_ax-_ammo.x)-6*timescale)*1000000<=1,"Original portal pickup coalescing/manual6tick attraction changed")
    // At these 65k fixture coordinates native float32 positions round by up
    // to 0.002px per axis. The production movement remains unchanged.
    assert(_rad.x<_rx && point_distance(_rad.x,_rad.y,_rx,_player.y+200)<=12*timescale+0.004,"Original stationary rad manual12tick attraction changed")
    _ax=_ammo.x
    with (NTTEFullPortalPickups) scrNTTEFullPortalPickupsStep()
    assert(_ammo.x==_ax,"Original inactive portal pickup binder moved pickups twice")
    var _all=scrNTTEFullInstances(all)
    for(var _i=0;_i<array_length(_all);++_i) if (array_get_index(_before,_all[_i])<0) instance_destroy(_all[_i],false)
    _player.x=_px; _player.y=_py
    scrNTTESmokeLog("FULL WORLD ORIGINAL PORTAL PICKUP ACTIVATION COALESCING/6TICK AMMO+HP+ROGUE/12TICK STATIONARY RAD ATTRACTION/INACTIVE BINDER OK")
}

function scrRavenLift() {
    if object_index != Raven || nofly > 0 exit
    scrTarget()
    if !instance_exists(target) exit
    // Landing callers may target a different flock member with no opponent.
    // Use local candidates; never read a stale/uninitialized flight endpoint.
    var _land_x=x,_land_y=y,_found=false
    repeat(64) {
        var _angle=point_direction(mouse_x,mouse_y,target.x,target.y)+random(50)-25,
            _tx=x+lengthdir_x(128,_angle),_ty=y+lengthdir_y(128,_angle),
            _floor=instance_nearest(_tx,_ty,Floor)
        if !instance_exists(_floor) break
        _tx=_floor.x+16+random(96)-48;_ty=_floor.y+16+random(96)-48
        _floor=instance_nearest(_tx,_ty,Floor)
        if !instance_exists(_floor) break
        _land_x=_floor.x+16;_land_y=_floor.y+16
        if place_free(_land_x,_land_y) {_found=true;break}
    }
    if !_found || point_distance(x,y,_land_x,_land_y)<=16 exit
    targetx=_land_x;targety=_land_y
    repeat(6) with(instance_create(x+random(16)-8,y+random(16),Dust)) {
        motion_add(random_angle,(3+random(1))*timescale)
    }
    if x>view_xview && y>view_yview && x<view_xview+view_width && y<view_yview+view_height snd_play(sndRavenLift)
    z=0;image_index=0;nofly=50
    instance_change(RavenFly,false)
    lifespan=300
}

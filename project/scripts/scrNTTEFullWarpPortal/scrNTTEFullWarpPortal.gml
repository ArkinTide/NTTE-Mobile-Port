// tecaves4974..5128. Real invisible BigPortal retains native transition timing.
function scrNTTEFullWarpPortalCreate() {
    sprite_index=sprPortalClear; image_speed=0.4*timescale; depth=-9; mask_index=sprPortalShock
    image_xscale=0.6; image_yscale=image_xscale; area=scrNTTEFullAreaId("red"); subarea=1; loops=GameCont.loops; ntte_warp_fx_clock=0
    portal=instance_create(x,y,BigPortal); portal.x=x; portal.y=y; portal.sprite_index=sprBigPortal; portal.image_alpha=0
    instance_create(x,y,PortalShock)
    var _sound=snd_play(sndLastNotifyDeath,0.6+random(0.1),2)
    if (_sound>=0) audio_sound_set_track_position(_sound,0.4)
    with (MusCont) { snd_stop(song); snd_stop(amb) }
    repeat(30) {
        var _length=32+random(8),_direction=random(360),_fx=instance_create(x+lengthdir_x(_length,_direction),y+lengthdir_y(_length,_direction),Dust)
        with (_fx) { motion_set(_direction,(4+random(2))*timescale); friction=0.4*timescale*timescale; sprite_index=sprSmoke }
    }
    scrNTTEFullTrenchShake(x,y,50); sleep(100)
}
function scrNTTEFullWarpPortalStep() {
    if (lockstep_stop) return;
    if (!instance_exists(portal) || portal.endgame<100) {
        var _shrink=timescale/80
        if (image_xscale>0 && image_yscale>0) {
            image_xscale-=_shrink; image_yscale-=_shrink
            if (image_xscale<=0 || image_yscale<=0) {
                image_xscale=0; image_yscale=0
                with (instance_create(x,y,BulletHit)) sprite_index=sprThrowHit
            }
        }
    }
    if (place_meeting(x,y,Wall)) {
        var _area=GameCont.area; GameCont.area=area
        var _walls=scrNTTEFullInstances(Wall)
        for(var _i=0;_i<array_length(_walls);++_i) if (place_meeting(x,y,_walls[_i])) with (_walls[_i]) {
            instance_create(x,y,FloorExplo); instance_destroy()
        }
        GameCont.area=_area
    }
    var _players=scrNTTEFullInstances(Player)
    for(var _i=0;_i<array_length(_players);++_i) {
        var _player=_players[_i]
        with (_player) if (visible && (place_meeting(x,y,other.id) || position_meeting(x,y,other.id))) {
            visible=false; direction=point_direction(x,y,other.x,other.y)
            var _fx=instance_create(x,y,Dust)
            with (_fx) {
                speed=max(3*timescale,other.speed); direction=other.direction; sprite_index=other.spr_hurt; image_index=1
                image_xscale=abs(other.image_xscale*other.right); image_yscale=abs(other.image_yscale)
                image_angle=other.image_angle+other.angle+orandom(30); image_blend=other.image_blend; image_alpha=other.image_alpha; depth=-10; growspeed*=2/3
                with (instance_create(x,y,ThrowHit)) { motion_add(other.direction,timescale); image_speed=0.5*timescale; image_blend=make_color_rgb(255,0,80); depth=other.depth-1 }
            }
        }
    }
    if (current_frame_active) {
        var _length=64,_direction=random(360),_fx=instance_create(x+lengthdir_x(_length,_direction),y+lengthdir_y(_length,_direction),LaserCharge)
        with (_fx) {
            alarm[0]=random_range(15,20); motion_set(_direction+180,random_range(1,2)*timescale); sprite_index=sprSpiralStar
            direction=_direction+180; speed=_length/alarm[0]*timescale
        }
    }
    if (random(5)<timescale) {
        var _length=random_range(32,128),_direction=random(360)
        with (instance_create(x+lengthdir_x(_length,_direction),y+lengthdir_y(_length,_direction),BulletHit)) sprite_index=sprWepSwap
    }
    if (instance_exists(portal) && portal.image_index+portal.image_speed>=portal.image_number && portal.sprite_index==sprBigPortalDisappear) {
        scrNTTEFullWarpPortalDestination()
        with (portal) event_perform(ev_other,ev_animation_end)
    }
}
function scrNTTEFullWarpPortalDestination() {
    // Source first advances through red0, then red.area_finish229..237
    // consumes this surviving WarpPortal's destination. The mobile pending
    // bridge commits that final destination during the real Room End.
    var _destination=scrNTTEFullAreaSet(area,subarea,loops)
    _destination.lastarea=GameCont.lastarea
    _destination.lastsubarea=GameCont.lastsubarea
    if(!scrNTTEFullWorldAreaSecret(_destination.area)) {
        _destination.lastarea=_destination.area
        _destination.lastsubarea=_destination.subarea-1
    }
    return _destination
}
function scrNTTEFullWarpPortalDraw() {
    var _extra=random(3),_xs=image_xscale+_extra/sprite_get_width(sprite_index),_ys=image_yscale+_extra/sprite_get_height(sprite_index)
    draw_sprite_ext(sprite_index,image_index,x,y,_xs,_ys,image_angle,image_blend,abs(image_alpha))
}

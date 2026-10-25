// tesewers:5957..6133. These are neutral turtles watching TV, not allies or
// ordinary enemy Turtles. They become the actual native Turtle when angered.
function scrNTTEFullTurtleCoolCreate() {
    spr_idle=sprTurtleIdle; spr_walk=sprTurtleFire; spr_hurt=sprTurtleHurt; spr_dead=sprTurtleDead
    sprite_index=spr_idle; spr_shadow=shd24; image_speed=0.4*timescale; depth=-2
    snd_hurt=sndTurtleHurt; snd_dead=sndTurtleDead1
    mask_index=mskBandit; friction=0.4*timescale*timescale
    max_hp=15; hp=max_hp; ntte_full_maxspeed=2.5; size=4; team=team_none
    right=choose(-1,1); ntte_full_patience=random_range(30,40)
    ntte_full_notice_delay=random_range(1,8); ntte_full_notice_max=80
    ntte_full_notice=ntte_full_notice_max; ntte_full_become=Turtle; immmovable=false
    var _gate=instance_create(0,0,NTTEFullPortalPrevent)
    _gate.creator=id
}

function scrNTTEFullTurtleCoolStep() {
    if (lockstep_stop) return;
    if (ntte_full_patience>0 && !scrNTTEFullPortalPointSeen(x,y,-1)) return;
    var _players=[],_self=id
    with (Player) if (point_distance(x,y,other.x,other.y)<96) array_push(_players,id)
    if (ntte_full_notice<90) {
        for(var _i=0;_i<array_length(_players);++_i) {
            var _player=_players[_i]
            if (_player.reload>0) {
                ntte_full_notice=max(ntte_full_notice,8)
                ntte_full_notice+=(_player.reload/3+random(3))*timescale
            }
            if (_player.race==Race.Steroids && _player.breload>0) {
                ntte_full_notice=max(ntte_full_notice,8)
                ntte_full_notice+=(_player.breload/3+random(3))*timescale
            }
        }
    }
    if (array_length(_players)>0 && ntte_full_notice>0) {
        var _near=noone,_distance=infinity
        for(var _i=0;_i<array_length(_players);++_i) {
            var _player=_players[_i],_d=point_distance(x,y,_player.x,_player.y)
            if (_d<_distance) { _distance=_d; _near=_player }
        }
        if (ntte_full_notice_delay>0) {
            ntte_full_notice_delay-=timescale
            if (ntte_full_notice_delay<=0) { var _fx=instance_create(x,y,SteroidsTB); _fx.depth=-8 }
        }
        else { ntte_full_notice-=timescale; scrNTTESewerLook(point_direction(x,y,_near.x,_near.y)) }
    }
    else {
        var _tv=instance_nearest(x,y,TV)
        if (instance_exists(_tv) && point_distance(x,y,_tv.x,_tv.y)<96) scrNTTESewerLook(point_direction(x,y,_tv.x,_tv.y))
    }
    var _touch=scrNTTEFullRectInstances(bbox_left,bbox_top,bbox_right-1,bbox_bottom-1,hitme)
    for(var _i=0;_i<array_length(_touch);++_i) {
        var _v=_touch[_i]
        if (_v==id || !place_meeting(x,y,_v)) continue
        if (!instance_is(_v,prop)) with (_v) motion_add(point_direction(other.x,other.y,x,y),timescale)
        if (instance_is(_v,Player)) { ntte_full_notice=max(ntte_full_notice,30); ntte_full_patience-=timescale }
        motion_add(point_direction(_v.x,_v.y,x,y),timescale)
    }
    speed=min(speed,ntte_full_maxspeed*timescale)
    if (place_meeting(x+hspeed,y+vspeed,Wall)) {
        if (place_meeting(x+hspeed,y,Wall)) hspeed=0
        if (place_meeting(x,y+vspeed,Wall)) vspeed=0
    }
    var _angered=hp<max_hp || !instance_exists(TV)
    if (!_angered) with (Corpse) if ((sprite_index==sprTurtleDead || sprite_index==sprRatDead)
        && !collision_line(x,y,other.x,other.y,Wall,false,false)) { _angered=true; break }
    if (!_angered) {
        var _hostile=scrNTTEFullInstances([Turtle,Rat])
        for(var _i=0;_i<array_length(_hostile);++_i) {
            var _v=_hostile[_i]
            if (_v.hp<_v.max_hp && !collision_line(x,y,_v.x,_v.y,Wall,false,false)) { _angered=true; break }
        }
    }
    if (_angered) with (NTTEFullTurtleCool) if (ntte_full_patience>0) ntte_full_patience=0
    if (ntte_full_patience<=0) {
        var _damage=hp-max_hp,_xx=x,_yy=y,_nexthurt=nexthurt,_sprite=sprite_index,
            _frame=image_index,_sound=snd_dead,_right=right,_become=ntte_full_become
        instance_change(_become,true)
        if (instance_exists(id)) {
            hp+=_damage; alarm[1]=(10+random(10))
            x=_xx; y=_yy; nexthurt=_nexthurt; sprite_index=_sprite; image_index=_frame; snd_dead=_sound; right=_right
            snd_play_hit(sndTurtleMelee,0.3)
            var _fx=instance_create(x,y,NTTEFullAssassinNotice); _fx.depth=-8
            if (hp<max_hp) scrNTTESewerLook(direction+180)
        }
        with (NTTEFullPortalPrevent) if (creator==_self) instance_destroy()
    }
}

function scrNTTEFullTurtleCoolDraw() {
    if (lockstep_stop) return;
    draw_sprite_ext(sprite_index,image_index,x,y,right,image_yscale,image_angle,image_blend,image_alpha)
}

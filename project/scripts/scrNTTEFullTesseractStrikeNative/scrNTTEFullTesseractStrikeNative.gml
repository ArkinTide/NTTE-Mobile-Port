// tecaves4194..4386. Actual warning vector then source RedExplosion line.
function scrNTTEFullTesseractStrikeCreate() {
    name="TesseractStrike";sprite_index=scrNTTERefSprite("TesseractStrike")
    image_xscale=1/4;image_yscale=image_xscale;image_alpha=-1;image_speed=0.4*timescale;depth=-3
    mask_index=mskSuperFlakBullet;active=true;length=320;time=3;ammo=1;team=-1;hitid=-1;creator=noone
    ntte_strike_alarm=35
}
function scrNTTEFullTesseractStrikeStep() {
    if(lockstep_stop) return;
    if(ntte_strike_alarm>0) {
        ntte_strike_alarm-=timescale
        if(ntte_strike_alarm<=0) {
            ntte_strike_alarm=-1;scrNTTEFullTesseractStrikeAlarm()
            if(!instance_exists(id)) return;
        }
    }
    image_xscale=lerp(1,image_xscale,power(0.9,timescale))
    image_yscale=lerp(1,image_yscale,power(0.9,timescale))
    if(active && creator!=noone && !instance_exists(creator)) ntte_strike_alarm=min(ntte_strike_alarm,1)
}
function scrNTTEFullTesseractStrikeEndStep() {
    if(lockstep_stop) return;
    xstart+=hspeed;ystart+=vspeed
    if(!active) return;
    x=xstart;y=ystart
    var _distance=length*image_xscale,_direction=image_angle
    if(instance_exists(Wall)) {
        // Modern bbox_right is exclusive; source bbox_width is inclusive+1.
        var _length=max(1,bbox_right-bbox_left),_dx=lengthdir_x(_length,_direction),_dy=lengthdir_y(_length,_direction)
        while(_distance>0 && !place_meeting(x,y,Wall)) {_distance-=_length;x+=_dx;y+=_dy}
    }
    else {x+=lengthdir_x(_distance,_direction);y+=lengthdir_y(_distance,_direction)}
}
function scrNTTEFullTesseractStrikeDraw() {
    image_alpha=abs(image_alpha)
    var _x=xstart,_y=ystart,_length=max(abs(sprite_width*2/3),scrNTTEFullSourceDisplayScale()),
        _distance=point_distance(_x,_y,x,y),_direction=point_direction(_x,_y,x,y),
        _dx=lengthdir_x(_length,_direction),_dy=lengthdir_y(_length,_direction)
    while(_distance>0) {
        _distance-=_length;_x+=_dx;_y+=_dy
        draw_sprite_ext(sprite_index,image_index,_x,_y,image_xscale,image_yscale,_direction,image_blend,image_alpha)
    }
    image_alpha=-image_alpha
}
function scrNTTEFullTesseractStrikeAlarm() {
    ntte_strike_alarm=time
    var _distance=point_distance(xstart,ystart,x,y),_direction=point_direction(xstart,ystart,x,y),_instances=[],
        _length=34*image_xscale,_dx=lengthdir_x(_length,_direction),_dy=lengthdir_y(_length,_direction)
    if(ammo>0) repeat(ammo) {
        if(_distance>0) {
            _distance-=_length
            if(_distance>0 || (active && !array_length(_instances))) {
                xstart+=_dx;ystart+=_dy
                var _explosion=scrNTTEFullMergedBasicProjectileCreate(xstart,ystart,NTTEFullRedExplosion)
                _explosion.mask_index=mskPopoPlasmaImpact;array_push(_instances,_explosion)
            }
        }
        else break
    }
    if(active) {
        active=false;image_speed*=2
        scrNTTEFullFrameSleepRequest(15)
    }
    if(_distance<=0) instance_destroy()
}

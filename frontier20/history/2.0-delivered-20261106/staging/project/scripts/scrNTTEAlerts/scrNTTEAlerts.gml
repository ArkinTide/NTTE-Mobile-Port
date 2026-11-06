// NTTE tegeneral AlertIndicator/telib alert_create, using native camera bounds.
function scrNTTEAlertCreate(_x,_y,_sprite,_target=noone) {
    var _a=instance_create(_x,_y,NTTEAlert)
    _a.sprite_index=_sprite; _a.target=_target
    if (instance_exists(_target) && sprite_exists(_sprite)) {
        var _spr=_target.sprite_index
        _a.target_y=-(1+(sprite_exists(_spr)?abs(sprite_get_yoffset(_spr)-sprite_get_bbox_top(_spr)):0)
            +abs(sprite_get_bbox_bottom(_sprite)+1-sprite_get_yoffset(_sprite)))
    }
    if (sprite_exists(_sprite)) _a.alert_x=sprite_get_bbox_left(_sprite)-sprite_get_xoffset(_sprite)
    return _a
}

function scrNTTEAlertStep() {
    if (lockstep_stop) return;
    if (instance_exists(target)) {
        x=target.x+target_x; y=target.y+target_y
        target_x+=hspeed; target_y+=vspeed
    }
    if (flash>0) {
        flash-=timescale
        if (flash<=0) {
            snd_play(snd_flash); snd_play(sndCrownAppear,random_range(0.9,1.1))
            if (friction<=0) friction=0.5*timescale*timescale
        }
    }
    alert_age+=timescale
    if (alert_age>=alert_hold) {
        alert_on=(floor((alert_age-alert_hold)/2) mod 2)==1
        if (alert_age>=alert_hold+2*(blink+1)) instance_destroy()
    }
}

function scrNTTEAlertPosition(_vx,_vy,_vw,_vh) {
    var _l=0,_r=0,_t=0,_b=0
    if (sprite_exists(sprite_index)) {
        _l=sprite_get_bbox_left(sprite_index)-sprite_get_xoffset(sprite_index)
        _r=sprite_get_bbox_right(sprite_index)+1-sprite_get_xoffset(sprite_index)
        _t=sprite_get_bbox_top(sprite_index)-sprite_get_yoffset(sprite_index)
        _b=sprite_get_bbox_bottom(sprite_index)+1-sprite_get_yoffset(sprite_index)
    }
    if (sprite_exists(alert_sprite)) {
        _l=min(_l,alert_x+sprite_get_bbox_left(alert_sprite)-sprite_get_xoffset(alert_sprite)-1)
        _r=max(_r,alert_x+sprite_get_bbox_right(alert_sprite)+1-sprite_get_xoffset(alert_sprite)+1)
        _t=min(_t,alert_y+sprite_get_bbox_top(alert_sprite)-sprite_get_yoffset(alert_sprite)-1)
        _b=max(_b,alert_y+sprite_get_bbox_bottom(alert_sprite)+1-sprite_get_yoffset(alert_sprite)+2)
    }
    return {x:round(clamp(x,_vx-_l+1,_vx+_vw-_r-2)),
            y:round(clamp(y,_vy-_t+1,_vy+_vh-_b-1)),l:_l,r:_r,t:_t,b:_b}
}

function scrNTTEAlertDraw(_vx=view_xview,_vy=view_yview,_vw=view_width,_vh=view_height) {
    if (!alert_on || lockstep_stop) return;
    var _inside=x>=_vx && y>=_vy && x<_vx+_vw && y<_vy+_vh
    if (!canview && _inside) return;
    var _pos=scrNTTEAlertPosition(_vx,_vy,_vw,_vh),
        _f=max(1,flash),_ys=1/_f,_y=_pos.y+(3/_f)*(_f-1),
        _ax=_pos.x+alert_x,_ay=_y+alert_y*_ys
    if (sprite_exists(alert_sprite)) {
        for(var _ox=-1;_ox<=1;++_ox) for(var _oy=-1;_oy<=2;++_oy)
            draw_sprite_ext(alert_sprite,0,_ax+_ox,_ay+_oy*_ys,1,_ys,alert_angle,c_black,1)
    }
    if (sprite_exists(sprite_index)) draw_sprite_ext(sprite_index,image_index,_pos.x,_y,1,_ys,0,c_white,1)
    if (sprite_exists(alert_sprite)) draw_sprite_ext(alert_sprite,0,_ax,_ay,1,_ys,alert_angle,alert_color,1)
}

function scrNTTEAlertsDraw() {
    if (scrGameIsGenerationScreen() || !instance_exists(Player)) return;
    with (NTTEAlert) scrNTTEAlertDraw()
}

function scrNTTESewerWakeDen() {
    // As in GatorDen_step, one disturbed occupant wakes its seated group and
    // produces one Gator portrait, rather than repeated text from each enemy.
    var _cx=x,_cy=y,_woke=false
    with (enemy) if (variable_instance_exists(id,"ntte_gator_den") && ntte_gator_den
        && !ntte_gator_awake && point_distance(x,y,_cx,_cy)<160) {
        ntte_gator_awake=true; _woke=true
    }
    if (_woke) {
        var _a=scrNTTEAlertCreate(_cx,_cy-16,sprNTTEGatorAlert)
        _a.vspeed=-2*timescale; _a.snd_flash=sndBuffGatorHit
    }
}

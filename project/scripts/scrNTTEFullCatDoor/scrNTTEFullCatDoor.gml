// NTT BBOX NORMALIZED: source inclusive right/bottom = modern runner edge-1.
// tesewers CatDoor: opening force, shared HP and per-layer original sprite.
function scrNTTEFullCatDoorCreate() {
    sprite_index=scrNTTERefSprite("CatDoor"); spr_idle=sprite_index; spr_hurt=sprite_index
    image_speed=0; depth=-3; spr_shadow=mskNone; mask_index=scrNTTERefSprite("msk.CatDoor")
    snd_hurt=sndHitMetal; snd_dead=sndWallBreakScrap
    hp=15; max_hp=15; size=2; team=team_none; ntte_full_open_angle=0
    ntte_full_partner=noone; ntte_full_wall=noone; ntte_full_door_last_hp=hp
    ntte_door_surface=-1;ntte_door_last_angle=undefined
    if (GameCont.area==area_pizza_sewers || GameCont.area==scrNTTEFullAreaId("pizza")) {
        sprite_index=scrNTTERefSprite("PizzaDoor"); spr_idle=sprite_index; spr_hurt=sprite_index
    }
}

function scrNTTEFullCatDoorPair(_x,_y,_dir) {
    var _dx=_x+lengthdir_x(14,_dir),_dy=_y+lengthdir_y(14,_dir)+1,_partner=noone,_out=[]
    for(var _side=-1;_side<=1;_side+=2) {
        var _s=_side
        if (_dir<90 || _dir>270) _s*=-1
        var _door=instance_create(_dx+lengthdir_x(16*_s,_dir-90),_dy+lengthdir_y(16*_s,_dir-90),NTTEFullCatDoor)
        _door.image_angle=_dir; _door.image_yscale=-_s; _door.ntte_full_partner=_partner
        if (instance_exists(_partner)) _partner.ntte_full_partner=_door
        _partner=_door; array_push(_out,_door)
    }
    return _out
}

function scrNTTEFullCatDoorHurt(_amount,_attacker) {
    if (instance_exists(_attacker)) {
        ntte_full_open_angle+=lengthdir_x(_attacker.hspeed,image_angle)+lengthdir_y(_attacker.vspeed,image_angle)
    }
    if (_amount>0 && instance_exists(ntte_full_partner) && ntte_full_partner.hp>hp) {
        // Original projectile_hit invokes partner only while its HP is higher,
        // which prevents recursion. Retain the actual attacker / hitid.
        var _partner=ntte_full_partner,_hitid=instance_exists(_attacker) && variable_instance_exists(_attacker,"hitid") ? _attacker.hitid:HitId.None
        if (instance_exists(_attacker)) with (_attacker) scr_hit(_partner,_amount,_hitid)
        else scr_hit(_partner,_amount,_hitid)
    }
    ntte_full_door_last_hp=hp
}

function scrNTTEFullCatDoorStep() {
    if (lockstep_stop) return;
    x=xstart; y=ystart
    if (!instance_exists(ntte_full_wall)) {
        var _distance=8*image_yscale,_d=image_angle+90,
            _found=collision_point(x+lengthdir_x(_distance,_d),y+lengthdir_y(_distance,_d),Wall,false,false)
        if (instance_exists(_found)) ntte_full_wall=_found
        if (ntte_full_wall!=noone && !instance_exists(ntte_full_wall)) hp=0
    }
    var _push=0,_open=false,_list=ds_list_create()
    if (mask_index==mskNone) mask_index=mskFrogQueen
    collision_rectangle_list(bbox_left,bbox_top,(bbox_right-1),(bbox_bottom-1),hitme,true,true,_list,false)
    for(var _i=0;_i<ds_list_size(_list);++_i) {
        var _v=_list[| _i]
        if (!instance_exists(_v) || _v.team==team_none || _v.mask_index==mskNone || instance_is(_v,prop)) continue
        _open=true
        var _p=3*(lengthdir_x(_v.hspeed/timescale,image_angle)+lengthdir_y(_v.vspeed/timescale,image_angle))
        if (abs(_p)>abs(_push)) _push=_p
    }
    ds_list_destroy(_list)
    if (_open) {
        if (_push!=0) {
            if (abs(ntte_full_open_angle)<min(4,abs(_push))) {
                snd_play(sndMeleeFlip,1+random(0.4))
                snd_play(ntte_full_open_angle>0 ? sndAmmoChest:sndWeaponChest,0.4+random(0.2))
            }
            ntte_full_open_angle+=_push*timescale
        }
        ntte_full_open_angle=clamp(ntte_full_open_angle,-90,90)
    }
    else ntte_full_open_angle*=power(0.8,timescale)
    mask_index=(abs(ntte_full_open_angle)>20 ? mskNone:scrNTTERefSprite("msk.CatDoor"))
    if (hp<=0) { scrNTTEFullCatDoorBreak(); return; }
    speed=0
}

function scrNTTEFullCatDoorBreak() {
    snd_play(snd_dead,1.8+random(0.2),0.8); snd_play(snd_hurt,0.6+random(0.2),2)
    var _d=image_angle-90*image_yscale
    for(var _distance=0;_distance<=abs(sprite_height);_distance+=random_range(4,8)) {
        var _p=instance_create(x+lengthdir_x(_distance,_d),y+lengthdir_y(_distance,_d),NTTEFullCatDoorDebris)
        if (sprite_index==scrNTTERefSprite("PizzaDoor")) _p.sprite_index=scrNTTERefSprite("PizzaDoorDebris")
        with (_p) {
            if (other.speed==0) speed*=random_range(1,3)
            else motion_add(other.direction+orandom(20),clamp(other.speed/timescale,6,18)*random_range(0.6,1)*timescale)
        }
        var _fx=scrNTTEFullTrenchFX(_p.x,_p.y,0,min(speed/timescale,10)/2,Dust); /* NTTE DUST LIFETIME cat-door */ if(instance_exists(_fx)) {_fx.depth=1 }
    }
    instance_destroy()
}

function scrNTTEFullCatDoorDraw() {
    // tesewers3724..3759 draws the previous cache before refreshing it. Keep
    // that order and its >1 degree threshold, including the initial blank draw.
    var _w=2*max(abs(sprite_width),abs(sprite_height)),_h=_w+(image_number-1)*2,
        _x=x-_w/2,_y=y-_h/2,_scale=scrNTTEFullVisualQuality("main"),
        _sw=scrNTTEFullQualitySurfaceSize(_w,_scale),_sh=scrNTTEFullQualitySurfaceSize(_h,_scale)
    if(x+_w/2<view_xview || x-_w/2>view_xview+view_width || y+_h/2<view_yview || y-_h/2>view_yview+view_height) return;
    var _reset=!surface_exists(ntte_door_surface)
    if(!_reset) _reset=surface_get_width(ntte_door_surface)!=_sw || surface_get_height(ntte_door_surface)!=_sh
    if(_reset) {
        if(surface_exists(ntte_door_surface)) surface_free(ntte_door_surface)
        ntte_door_surface=surface_create(_sw,_sh)
    }
    if(!surface_exists(ntte_door_surface)) return;
    var _world=matrix_get(matrix_world),_view=matrix_get(matrix_view),_projection=matrix_get(matrix_projection),
        _color=draw_get_color(),_alpha=draw_get_alpha(),_active=false,_camera=-1
    gpu_push_state()
    try {
        draw_set_color(c_white);draw_set_alpha(1);gpu_set_blendmode(bm_normal);gpu_set_fog(false,0,0,0)
        if(_reset) {surface_set_target(ntte_door_surface);draw_clear_alpha(c_black,0);surface_reset_target();}
        if(nexthurt>=current_frame+4) gpu_set_fog(true,image_blend,0,0)
        draw_surface_ext(ntte_door_surface,_x,_y,1/_scale,1/_scale,0,image_blend,image_alpha)
        gpu_set_fog(false,0,0,0)
        if(_reset || is_undefined(ntte_door_last_angle) || abs(ntte_full_open_angle-ntte_door_last_angle)>1) {
            ntte_door_last_angle=ntte_full_open_angle
            surface_set_target(ntte_door_surface);_active=true;draw_clear_alpha(c_black,0)
            _camera=camera_create_view(_x,_y,_w,_h,0,noone,-1,-1,-1,-1)
            scrNTTEFullQualityCamera(_camera,_x,_y,_w,_h)
            for(var _i=0;_i<image_number;++_i)
                draw_sprite_ext(sprite_index,_i,x,y-_i,image_xscale,image_yscale,image_angle+ntte_full_open_angle*image_yscale,c_white,1)
            surface_reset_target();_active=false
        }
    }
    finally {
        if(_active) surface_reset_target()
        if(_camera>=0) camera_destroy(_camera)
        gpu_pop_state();matrix_set(matrix_world,_world);matrix_set(matrix_view,_view);matrix_set(matrix_projection,_projection)
        draw_set_color(_color);draw_set_alpha(_alpha)
    }
}
function scrNTTEFullCatDoorDrawCleanup() {
    if(surface_exists(ntte_door_surface)) surface_free(ntte_door_surface)
    ntte_door_surface=-1
}

function scrNTTEFullCatDoorDebrisCreate() {
    sprite_index=scrNTTERefSprite("CatDoorDebris"); image_index=irandom(image_number-1); image_speed=0
    friction*=2; ntte_full_flash=1
    motion_add(random(360),2*timescale)
}

function scrNTTEFullCatDoorDebrisDraw() {
    if (ntte_full_flash>0) {
        ntte_full_flash-=timescale/3
        draw_sprite_ext(sprite_index,image_index,x,y,image_xscale,image_yscale,image_angle,c_white,image_alpha)
    }
    else draw_self()
}

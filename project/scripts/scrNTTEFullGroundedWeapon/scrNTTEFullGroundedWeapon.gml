// tescrapyard:2880..3020. Real held WepPickup, released at its transformed tip.
function scrNTTEFullGroundedWeaponCreate() {
    spr_shadow=shd24; spr_shadow_x=0; spr_shadow_y=-9
    image_xscale=-1; image_yscale=choose(-1,1); image_angle=90+random_range(10,20)*choose(-1,1)
    depth=-1; mask_index=mskFlakBullet; sprite_index=-1
    target=noone; target_x=0; target_y=0; top_object=noone
    ntte_full_surface=-1
}

function scrNTTEFullGroundedWeaponEndStep() {
    if (lockstep_stop) return;
    var _stuck=instance_exists(target)
    if (_stuck) with (Portal) if (point_distance(x,y,other.x,other.y)<96
        && !collision_line(x,y,other.x,other.y,Wall,false,false)) { _stuck=false; break }
    if (!_stuck) { instance_destroy(); return; }
    if (instance_exists(top_object) && top_object.zfriction!=0) image_angle+=4*target.rotspeed*timescale
    else if (target.x!=target.xprevious || target.y!=target.yprevious)
        image_angle+=sin(current_frame*0.7)*target.rotspeed*sign(image_yscale)*timescale
    var _off=sprite_get_xoffset(target.sprite_index),_angle=image_angle,_scale=image_xscale
    if (_scale<0) _off=sprite_get_bbox_right(target.sprite_index)+1-_off
    else _off-=sprite_get_bbox_left(target.sprite_index)
    _off*=abs(_scale)
    target_x=lengthdir_x(_off,_angle); target_y=lengthdir_y(_off,_angle)+(_angle>180 ? -2:2)
    with (target) {
        x=other.x; y=other.y-8; xprevious=x; yprevious=y; speed=0
        // Epsilon rotates with image_angle rather than the NTT rotation field.
        image_angle=_angle+180*(_scale<0); image_alpha=0
        var _slow=random(0.02*timescale)
        if (image_index>_slow && image_index<1) image_index-=_slow
    }
}

function scrNTTEFullGroundedWeaponDraw() {
    if (!instance_exists(target)) return;
    var _sprite=target.sprite_index,_frame=target.image_index
    if (instance_exists(top_object) && top_object.zfriction!=0) {
        draw_sprite_ext(_sprite,_frame,x+target_x,y+target_y,image_xscale,image_yscale,image_angle,image_blend,image_alpha)
        return;
    }
    var _scale=scrNTTEFullVisualQuality("main"),_size=scrNTTEFullQualitySurfaceSize(64,_scale)
    if (!surface_exists(ntte_full_surface) || surface_get_width(ntte_full_surface)!=_size || surface_get_height(ntte_full_surface)!=_size) {
        if(surface_exists(ntte_full_surface)) surface_free(ntte_full_surface)
        ntte_full_surface=surface_create(_size,_size)
    }
    if (!surface_exists(ntte_full_surface)) return;
    var _view=matrix_get(matrix_view),_projection=matrix_get(matrix_projection),_world=matrix_get(matrix_world),
        _color=draw_get_color(),_alpha=draw_get_alpha(),_camera=camera_create_view(x-32,y-64,64,64,0,noone,-1,-1,-1,-1),_active=false
    gpu_push_state()
    try {
        gpu_set_blendmode(bm_normal);gpu_set_fog(false,0,0,0);draw_set_alpha(1);draw_set_color(c_white)
        surface_set_target(ntte_full_surface);_active=true
        scrNTTEFullQualityCamera(_camera,x-32,y-64,64,64);draw_clear_alpha(c_black,0)
        // Source target ends exactly at y: the part buried below the ground
        // is clipped by the surface rather than merely hidden by a sprite.
        draw_sprite_ext(_sprite,_frame,x+target_x,y+target_y,image_xscale,image_yscale,image_angle,image_blend,image_alpha)
        surface_reset_target();_active=false
        matrix_set(matrix_world,_world);matrix_set(matrix_view,_view);matrix_set(matrix_projection,_projection)
        draw_surface_ext(ntte_full_surface,x-32,y-64,1/_scale,1/_scale,0,c_white,1)
    }
    finally {
        if(_active) surface_reset_target()
        camera_destroy(_camera);gpu_pop_state()
        matrix_set(matrix_world,_world);matrix_set(matrix_view,_view);matrix_set(matrix_projection,_projection)
        draw_set_color(_color);draw_set_alpha(_alpha)
    }
}

function scrNTTEFullGroundedWeaponDeath() {
    if (instance_exists(target)) with (target) {
        x=other.x+other.target_x; y=other.y+other.target_y
        image_angle=other.image_angle+180*(other.image_xscale<0); image_alpha=1
        if (variable_instance_exists(id,"top_object") && instance_exists(top_object)) instance_destroy(top_object)
        repeat(3) scrNTTEFullTrenchFX(x,y,4,random(1),Dust)
        snd_play(sndWeaponPickup,0.7,0.8)
    }
    var _swap=instance_create(x,y,WepSwap); _swap.depth=depth-1
}

function scrNTTEFullGroundedWeaponCleanup() {
    if (surface_exists(ntte_full_surface)) surface_free(ntte_full_surface)
}

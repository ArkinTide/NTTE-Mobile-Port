// ntte4207..4355. These shadows project onto wall tops, after the ordinary
// native ground-shadow pass; they are unrelated to player body outlines.
function scrNTTEFullTopShadowEnsure() {
    if(!instance_exists(NTTEFullTopShadow)) instance_create(0,0,NTTEFullTopShadow)
}
function scrNTTEFullTopShadowCreate() {
    visible=false;ntte_top_shadow_mask=-1;ntte_top_shadow_surface=-1
    ntte_top_shadow_camera=camera_create_view(0,0,1,1,0,noone,-1,-1,-1,-1)
    ntte_top_shadow_x=undefined;ntte_top_shadow_y=undefined
    ntte_top_shadow_floors=-1;ntte_top_shadow_walls=-1
    ntte_top_shadow_marker=-1;ntte_top_shadow_reset=true
}
function scrNTTEFullTopShadowCleanup() {
    if(surface_exists(ntte_top_shadow_mask)) surface_free(ntte_top_shadow_mask)
    if(surface_exists(ntte_top_shadow_surface)) surface_free(ntte_top_shadow_surface)
    if(ntte_top_shadow_camera>=0) camera_destroy(ntte_top_shadow_camera)
    ntte_top_shadow_mask=-1;ntte_top_shadow_surface=-1;ntte_top_shadow_camera=-1
}
function scrNTTEFullTopShadowSeen(_who) {
    return _who.bbox_right>=view_xview-8 && _who.bbox_left<=view_xview+view_width+8
        && _who.bbox_bottom>=view_yview-8 && _who.bbox_top<=view_yview+view_height+8
}
function scrNTTEFullTopShadowDraw() {
    if(instance_exists(NothingSpiral) || !instance_exists(BackCont)) return;
    var _tops=[],_plasma=[],_pipes=[]
    with(NTTEFullTopObject) if(visible && spr_shadow!=-1 && z>=8) array_push(_tops,id)
    with(NTTEFullMortarPlasma) if(visible && spr_shadow!=-1 && z>=8) array_push(_plasma,id)
    with(NTTEFullBigPipe) if(visible && spr_shadow!=-1) array_push(_pipes,id)
    if(array_length(_tops)==0 && array_length(_plasma)==0 && array_length(_pipes)==0) return;
    var _w=view_width,_h=view_height,_vx=view_xview,_vy=view_yview,_scale=scrNTTEFullVisualQuality("minor"),
        _x=floor(_vx/_w)*_w,_y=floor(_vy/_h)*_h,
        _mw=scrNTTEFullQualitySurfaceSize(2*_w,_scale),_mh=scrNTTEFullQualitySurfaceSize(2*_h,_scale),
        _sw=scrNTTEFullQualitySurfaceSize(_w,_scale),_sh=scrNTTEFullQualitySurfaceSize(_h,_scale)
    if(!surface_exists(ntte_top_shadow_mask) || !surface_exists(ntte_top_shadow_surface)
        || surface_get_width(ntte_top_shadow_mask)!=_mw || surface_get_height(ntte_top_shadow_mask)!=_mh
        || surface_get_width(ntte_top_shadow_surface)!=_sw || surface_get_height(ntte_top_shadow_surface)!=_sh) {
        if(surface_exists(ntte_top_shadow_mask)) surface_free(ntte_top_shadow_mask)
        if(surface_exists(ntte_top_shadow_surface)) surface_free(ntte_top_shadow_surface)
        ntte_top_shadow_mask=surface_create(_mw,_mh);ntte_top_shadow_surface=surface_create(_sw,_sh)
        ntte_top_shadow_reset=true
    }
    if(!surface_exists(ntte_top_shadow_mask) || !surface_exists(ntte_top_shadow_surface)) return;
    var _floors=instance_number(Floor),_walls=instance_number(Wall),_floor=instance_find(Floor,0),_wall=instance_find(Wall,0),
        _world=matrix_get(matrix_world),_view=matrix_get(matrix_view),_projection=matrix_get(matrix_projection),
        _color=draw_get_color(),_alpha=draw_get_alpha(),_active=false
    gpu_push_state()
    try {
        draw_set_color(c_white);draw_set_alpha(1);gpu_set_fog(false,0,0,0);gpu_set_blendmode(bm_normal)
        if(ntte_top_shadow_reset || ntte_top_shadow_x!=_x || ntte_top_shadow_y!=_y
            || ntte_top_shadow_floors!=_floors || ntte_top_shadow_walls!=_walls
            || (instance_exists(_floor) && ntte_top_shadow_marker<real(_floor))
            || (instance_exists(_wall) && ntte_top_shadow_marker<real(_wall))) {
            ntte_top_shadow_reset=false;ntte_top_shadow_x=_x;ntte_top_shadow_y=_y
            ntte_top_shadow_floors=_floors;ntte_top_shadow_walls=_walls;ntte_top_shadow_marker=-1
            with(all) other.ntte_top_shadow_marker=max(other.ntte_top_shadow_marker,real(id))
            surface_set_target(ntte_top_shadow_mask);_active=true;draw_clear_alpha(c_black,0)
            scrNTTEFullQualityCamera(ntte_top_shadow_camera,_x,_y+8,2*_w,2*_h)
            with(Floor) if(scrNTTEFullRedWallShineInside(id,_x,_y,2*_w,2*_h)) draw_self()
            scrNTTEFullQualityCamera(ntte_top_shadow_camera,_x,_y,2*_w,2*_h)
            gpu_set_blendmode_ext(bm_zero,bm_inv_src_alpha)
            with(Wall) if(scrNTTEFullRedWallShineInside(id,_x,_y,2*_w,2*_h)) { if(sprite_exists(outspr)) draw_sprite(outspr,outindex,x,y); }
            gpu_set_blendmode(bm_normal);surface_reset_target();_active=false
        }
        surface_set_target(ntte_top_shadow_surface);_active=true;draw_clear_alpha(c_black,0)
        scrNTTEFullQualityCamera(ntte_top_shadow_camera,_vx,_vy,_w,_h)
        for(var _i=0;_i<array_length(_tops);++_i) with(_tops[_i]) if(scrNTTEFullTopShadowSeen(id))
            draw_sprite(spr_shadow,0,x+spr_shadow_x,y+spr_shadow_y-8)
        for(var _i=0;_i<array_length(_plasma);++_i) with(_plasma[_i]) if(scrNTTEFullTopShadowSeen(id)) {
            var _percent=z==8?1:clamp(96/(z-8),0.1,1),_ew=ceil(18*_percent),_eh=ceil(6*_percent)
            draw_ellipse(x-_ew/2,y-8-_eh/2,x+_ew/2,y-8+_eh/2,false)
        }
        for(var _i=0;_i<array_length(_pipes);++_i) with(_pipes[_i])
            draw_sprite_ext(spr_top_idle,image_index,x+spr_shadow_x,y+spr_shadow_y,image_xscale,image_yscale,image_angle,image_blend,image_alpha)
        gpu_set_blendmode_ext(bm_zero,bm_inv_src_alpha)
        draw_surface_ext(ntte_top_shadow_mask,_x,_y,1/_scale,1/_scale,0,c_white,1)
        gpu_set_blendmode(bm_normal);surface_reset_target();_active=false
        matrix_set(matrix_world,_world);matrix_set(matrix_view,_view);matrix_set(matrix_projection,_projection)
        // Epsilon stores the source BackCont.shadcol as shadow_color and its
        // ground-shadow alpha as the native BackCont.Draw constant0.4.
        gpu_set_fog(true,BackCont.shadow_color,0,0)
        draw_surface_ext(ntte_top_shadow_surface,_vx,_vy,1/_scale,1/_scale,0,c_white,0.4*0.9)
    }
    finally {
        if(_active) surface_reset_target()
        gpu_pop_state();matrix_set(matrix_world,_world);matrix_set(matrix_view,_view);matrix_set(matrix_projection,_projection)
        draw_set_color(_color);draw_set_alpha(_alpha)
    }
}

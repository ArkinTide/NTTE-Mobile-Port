// tetrench5320..5421: one persistent-between-Draw trail texture, shared by
// visible non-hiding Anglers and the rolling Angler Fish player skin.
function scrNTTEFullAnglerTrailEnsure() {
    if(!instance_exists(NTTEFullAnglerTrailDraw)) instance_create(0,0,NTTEFullAnglerTrailDraw)
}
function scrNTTEFullAnglerTrailCreate() {
    depth=-3;ntte_angler_trail=-1
    ntte_angler_camera=camera_create_view(0,0,1,1,0,noone,-1,-1,-1,-1)
}
function scrNTTEFullAnglerTrailCleanup() {
    if(surface_exists(ntte_angler_trail)) surface_free(ntte_angler_trail)
    if(ntte_angler_camera>=0) camera_destroy(ntte_angler_camera)
    ntte_angler_trail=-1;ntte_angler_camera=-1
}
function scrNTTEFullAnglerTrailDraw() {
    var _anglers=[],_players=[]
    with(NTTEFullAngler) if(!ntte_full_hiding && visible) array_push(_anglers,id)
    with(Player) if(visible && scrNTTEFullSkinKey(scrNTTEFullValue(id,"bskin",0))=="angler fish") array_push(_players,id)
    if(array_length(_anglers)==0 && array_length(_players)==0) return;
    var _w=view_width,_h=view_height,_vx=view_xview,_vy=view_yview,
        _x=floor(_vx/_w)*_w,_y=floor(_vy/_h)*_h,_scale=scrNTTEFullVisualQuality("minor"),
        _sw=scrNTTEFullQualitySurfaceSize(2*_w,_scale),_sh=scrNTTEFullQualitySurfaceSize(2*_h,_scale),
        _reset=!surface_exists(ntte_angler_trail)
    if(!_reset) _reset=surface_get_width(ntte_angler_trail)!=_sw || surface_get_height(ntte_angler_trail)!=_sh
    if(_reset) {
        if(surface_exists(ntte_angler_trail)) surface_free(ntte_angler_trail)
        ntte_angler_trail=surface_create(_sw,_sh)
    }
    if(!surface_exists(ntte_angler_trail)) return;
    var _world=matrix_get(matrix_world),_view=matrix_get(matrix_view),_projection=matrix_get(matrix_projection),
        _color=draw_get_color(),_alpha=draw_get_alpha(),_active=false
    gpu_push_state()
    try {
        draw_set_color(c_white);draw_set_alpha(1);gpu_set_fog(false,0,0,0);gpu_set_blendmode(bm_normal)
        surface_set_target(ntte_angler_trail);_active=true
        if(_reset) draw_clear_alpha(c_black,0)
        // The source intentionally fades in its caller's current projection
        // before selecting the snapped world projection for new trail stamps.
        if(current_frame_active) {
            gpu_set_blendmode_ext(bm_zero,bm_inv_src_alpha)
            draw_sprite_tiled(sprBullet1,0,32*dcos(current_frame*20),8*dsin(current_frame*17))
            gpu_set_blendmode(bm_normal)
        }
        scrNTTEFullQualityCamera(ntte_angler_camera,_x,_y,2*_w,2*_h)
        var _groups=[_anglers,_players]
        for(var _g=0;_g<2;++_g) for(var _i=0;_i<array_length(_groups[_g]);++_i) {
            var _who=_groups[_g][_i],_player=_g==1
            with(_who) {
                if(_player) {if(roll==0) continue;}
                else if(ntte_full_ammo<0 || sprite_index==ntte_full_appear) continue
                var _distance=point_distance(x,y,xprevious,yprevious),_direction=point_direction(x,y,xprevious,yprevious),
                    _sprite=scrNTTERefSprite(_player?"FishAnglerTrail":"AnglerTrail"),
                    _angle=_player?image_angle+angle:image_angle,
                    _charm=image_blend==c_white && scrNTTEFullValue(id,"ntte_charmed",false)
                if(_charm) gpu_set_fog(true,make_color_rgb(56,252,0),0,0)
                for(var _j=0;_j<=_distance;++_j)
                    draw_sprite_ext(_sprite,image_index,x+lengthdir_x(_j,_direction),y+lengthdir_y(_j,_direction),image_xscale*right,image_yscale,_angle,image_blend,image_alpha)
                if(_charm) gpu_set_fog(false,0,0,0)
            }
        }
        surface_reset_target();_active=false
        matrix_set(matrix_world,_world);matrix_set(matrix_view,_view);matrix_set(matrix_projection,_projection)
        gpu_set_blendmode(bm_add)
        draw_surface_ext(ntte_angler_trail,_x,_y,1/_scale,1/_scale,0,c_white,1)
    }
    finally {
        if(_active) surface_reset_target()
        gpu_pop_state();matrix_set(matrix_world,_world);matrix_set(matrix_view,_view);matrix_set(matrix_projection,_projection)
        draw_set_color(_color);draw_set_alpha(_alpha)
    }
}

// tecaves5335..5363,5583..5720. Native SubTopCont calls after its tops.
function scrNTTEFullRedWallShineEnsure() {
    if(!instance_exists(NTTEFullRedWallShine)) instance_create(0,0,NTTEFullRedWallShine)
    // Wall.Create already calls this before any child Create override. Mark
    // only; EndStep observes the completed child sprite/team/area state.
    // This also handles parent/child enumeration grouped by concrete type.
    if(instance_is(id,Wall)) with(NTTEFullRedWallShine) ntte_shine_walls_dirty=true
}
function scrNTTEFullRedWallShineCreate() {
    visible=false;ntte_shine_mask=-1;ntte_shine_surface=-1
    ntte_shine_x=undefined;ntte_shine_y=undefined;ntte_shine_reset=true
    ntte_shine_wall_count=-1;ntte_shine_marker=-1
    ntte_shine_first=noone;ntte_shine_last=noone;ntte_shine_walls_dirty=true
    ntte_shine_walls=[];ntte_shine_tops=[];ntte_shine_wave=0
}
function scrNTTEFullRedWallShineCleanup() {
    if(surface_exists(ntte_shine_mask)) surface_free(ntte_shine_mask)
    if(surface_exists(ntte_shine_surface)) surface_free(ntte_shine_surface)
    ntte_shine_mask=-1;ntte_shine_surface=-1
}
function scrNTTEFullRedWallShineEndStep() {
    if(lockstep_stop) return;
    var _count=instance_number(Wall),_first=instance_find(Wall,0),_last=(_count>0)?instance_find(Wall,_count-1):noone
    if(ntte_shine_walls_dirty || _count!=ntte_shine_wall_count || _first!=ntte_shine_first || _last!=ntte_shine_last
        || (instance_exists(_first) && ntte_shine_marker<real(_first)) || (instance_exists(_last) && ntte_shine_marker<real(_last))) {
        ntte_shine_reset=true;ntte_shine_wall_count=_count;ntte_shine_marker=-1
        ntte_shine_first=_first;ntte_shine_last=_last;ntte_shine_walls_dirty=false
        ntte_shine_walls=[];ntte_shine_tops=[]
        var _top=scrNTTERefSprite("WallRedTop"),_trans=scrNTTERefSprite("WallRedTrans")
        // Candidate: new Walls have monotonic IDs, so the maximum Wall ID
        // detects their arrival without enumerating unrelated particles.
        // The independent oracle fixture must gate count/identity/reactivation.
        with(Wall) {
            other.ntte_shine_marker=max(other.ntte_shine_marker,real(id))
            if(topspr==_top || topspr==_trans) array_push(other.ntte_shine_walls,id)
        }
        with(TopSmall) if(sprite_index==_top || sprite_index==_trans) array_push(other.ntte_shine_tops,id)
    }
    visible=array_length(ntte_shine_walls)>0 || array_length(ntte_shine_tops)>0
    if(visible && GameCont.area!=206 && scrNTTEFullSourceRandom(40)<timescale) scrNTTEFullRedEffect()
}
function scrNTTEFullRedWallShineInside(_who,_x,_y,_w,_h) {
    return _who.bbox_right-1>=_x && _who.bbox_left<=_x+_w && _who.bbox_bottom-1>=_y && _who.bbox_top<=_y+_h
}
function scrNTTEFullRedWallShineDraw() {
    if(!visible) return;
    var _vx=view_xview,_vy=view_yview,_gw=view_width,_gh=view_height,_scale=scrNTTEFullVisualQuality("minor"),
        _mw=scrNTTEFullQualitySurfaceSize(2*_gw,_scale),_mh=scrNTTEFullQualitySurfaceSize(2*_gh,_scale),
        _sw=scrNTTEFullQualitySurfaceSize(_gw,_scale),_sh=scrNTTEFullQualitySurfaceSize(_gh,_scale),
        _sx=floor(_vx/_gw)*_gw,_sy=floor(_vy/_gh)*_gh,
        _target=surface_get_target(),_camera=-1,
        _world=matrix_get(matrix_world),_view=matrix_get(matrix_view),_projection=matrix_get(matrix_projection),
        _color=draw_get_color(),_alpha=draw_get_alpha(),_fog=gpu_get_fog()
    if(!surface_exists(ntte_shine_mask) || !surface_exists(ntte_shine_surface)
        || surface_get_width(ntte_shine_mask)!=_mw || surface_get_height(ntte_shine_mask)!=_mh
        || surface_get_width(ntte_shine_surface)!=_sw || surface_get_height(ntte_shine_surface)!=_sh) {
        scrNTTEFullRedWallShineCleanup()
        ntte_shine_mask=surface_create(_mw,_mh);ntte_shine_surface=surface_create(_sw,_sh)
        ntte_shine_reset=true
    }
    gpu_push_state()
    try {
        draw_set_alpha(1);draw_set_color(c_white);gpu_set_fog(false,0,0,0);gpu_set_blendmode(bm_normal)
        if(ntte_shine_reset || ntte_shine_x!=_sx || ntte_shine_y!=_sy) {
            surface_set_target(ntte_shine_mask)
            _camera=camera_create_view(_sx,_sy,2*_gw,2*_gh,0,noone,-1,-1,-1,-1);camera_apply(_camera)
            draw_clear_alpha(c_black,0)
            var _background=__background_get_colour_element()
            if(layer_background_get_blend(_background[0])==make_color_rgb(235,0,67)) {
                draw_clear(make_color_rgb(235,0,67))
                gpu_set_blendmode_ext(bm_inv_src_alpha,bm_inv_src_alpha)
                with(Floor) if(scrNTTEFullRedWallShineInside(id,_sx,_sy,2*_gw,2*_gh)) draw_self()
                with(Wall) if(scrNTTEFullRedWallShineInside(id,_sx,_sy,2*_gw,2*_gh)) {
                    if(image_speed==0) draw_self()
                    else {
                        var _last=image_index
                        for(image_index=0;image_index<image_number;++image_index) draw_self()
                        image_index=_last
                    }
                    { if(sprite_exists(topspr)) draw_sprite(topspr,topindex,x,y-8); }
                }
                with(TopSmall) if(scrNTTEFullRedWallShineInside(id,_sx,_sy,2*_gw,2*_gh)) draw_sprite(sprite_index,image_index,x,y-8)
                gpu_set_blendmode(bm_normal)
            }
            for(var _i=array_length(ntte_shine_walls)-1;_i>=0;--_i) {
                var _wall=ntte_shine_walls[_i]
                if(!instance_exists(_wall)) {array_delete(ntte_shine_walls,_i,1);continue}
                with(_wall) { if(sprite_exists(topspr)) draw_sprite_ext(topspr,topindex,x,y-8,1,1,0,c_white,solid?1:0.9); }
            }
            for(var _i=array_length(ntte_shine_tops)-1;_i>=0;--_i) {
                var _top=ntte_shine_tops[_i]
                if(!instance_exists(_top)) {array_delete(ntte_shine_tops,_i,1);continue}
                with(_top) draw_sprite(sprite_index,image_index,x,y-8)
            }
            surface_reset_target();camera_destroy(_camera);_camera=-1
            ntte_shine_reset=false;ntte_shine_x=_sx;ntte_shine_y=_sy
        }
        ntte_shine_wave+=timescale*random_range(1,2)
        var _width=30+random_range(-2,2),_maximum=sqrt(2*sqr(max(_gw,_gh))),
            _distance=(10*ntte_shine_wave) mod (_maximum+2400),
            _x=_vx+lengthdir_x(_distance,45),_y=_vy+lengthdir_y(_distance,45)+_gh,
            _xo=lengthdir_x(_maximum,135),_yo=lengthdir_y(_maximum,135)
        if(_distance<_maximum) {
            surface_set_target(ntte_shine_surface)
            _camera=camera_create_view(_vx,_vy,_gw,_gh,0,noone,-1,-1,-1,-1);camera_apply(_camera)
            draw_clear_alpha(c_black,0);gpu_set_fog(true,c_black,0,0)
            draw_surface_ext(ntte_shine_mask,_sx,_sy,1/_scale,1/_scale,0,c_white,1);gpu_set_fog(false,0,0,0)
            draw_set_color(c_white);gpu_set_colorwriteenable(true,true,true,false)
            draw_line_width(_x+_xo,_y+_yo,_x-_xo,_y-_yo,_width)
            gpu_set_colorwriteenable(true,true,true,true)
            surface_reset_target();camera_destroy(_camera);_camera=-1
            // Return to caller's camera/target before additive composition.
            if(_target>=0 && surface_get_target()!=_target) surface_set_target(_target)
            matrix_set(matrix_world,_world);matrix_set(matrix_view,_view);matrix_set(matrix_projection,_projection)
            gpu_set_blendmode_ext(bm_src_alpha,bm_one);draw_set_alpha(0.1)
            draw_surface_ext(ntte_shine_surface,_vx,_vy,1/_scale,1/_scale,0,c_white,0.1)
        }
    }
    finally {
        if(surface_get_target()>=0 && surface_get_target()!=_target) surface_reset_target()
        if(_target>=0 && surface_get_target()!=_target) surface_set_target(_target)
        if(_camera>=0) camera_destroy(_camera)
        matrix_set(matrix_world,_world);matrix_set(matrix_view,_view);matrix_set(matrix_projection,_projection)
        gpu_pop_state();draw_set_color(_color);draw_set_alpha(_alpha)
    }
}

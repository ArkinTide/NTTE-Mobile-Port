// Spin Turret's source uses a full-view scratch surface for each turret every
// draw, then copies that full surface five times to outline a 64px gun stack.
// Keep the exact stack/outline order in a sprite-sized scratch surface. AI,
// collision, attacks, possession and all projectile factories stay authored.
function scrFRDeeplabsSpinTurretDraw() {
    if(!sprite_exists(spr_gun)) {gpu_set_fog(0,0,0,0);return;}
    var _frames=sprite_get_number(spr_gun),
        _rx=max(sprite_get_xoffset(spr_gun),sprite_get_width(spr_gun)-sprite_get_xoffset(spr_gun)),
        _ry=max(sprite_get_yoffset(spr_gun),sprite_get_height(spr_gun)-sprite_get_yoffset(spr_gun)),
        _radius=ceil(sqrt(_rx*_rx+_ry*_ry))+2,
        _width=_radius*2,_height=_width+_frames-1,
        _vx=scrFRViewCoordinate(0),_vy=scrFRViewCoordinate(1),
        _left=_vx+floor(x-_vx)-_radius,_top=_vy+floor(y-_vy)-_radius-(_frames-1);
    // Rendering has no RNG or source-state changes. A fully off-screen gun,
    // base and top can be skipped without suppressing any simulation work.
    if(_left>_vx+view_width+1 || _left+_width<_vx-1
        || _top>_vy+view_height+1 || _top+_height<_vy-1) {
        // The authored renderer clears fog after every call, even when its
        // gun/base/top are fully clipped. Retain that GPU postcondition.
        gpu_set_fog(0,0,0,0);return;
    }
    if(nexthurt>=scrFRSourceFrame()+4) gpu_set_fog(1,c_white,0,0);
    scrFRDrawSprite(spr_base,0,x,y);
    var _vars=global.fr_module_vars[$ "area:deeplabs"],_surface=_vars.surfaceSpinTurret;
    if(!surface_exists(_surface) || surface_get_width(_surface)!=_width || surface_get_height(_surface)!=_height) {
        if(surface_exists(_surface)) surface_free(_surface);
        _surface=surface_create(_width,_height);_vars.surfaceSpinTurret=_surface;
    }
    var _outer_target=surface_get_target();
    surface_set_target(_surface);
    draw_clear_alpha(c_white,0);
    for(var _frame=0;_frame<_frames;++_frame)
        scrFRDrawSpriteExt(spr_gun,_frame,x-_left,y-_frame-_top,1,1,drawAngle,image_blend,1);
    surface_reset_target();
    if(_outer_target>=0 && surface_get_target()!=_outer_target) surface_set_target(_outer_target);
    // The source clips the gun to its full-view scratch surface BEFORE it
    // shifts the outline. Preserve that crop, including at a fractional
    // camera origin, so an off-screen fragment cannot gain a one-pixel rim.
    var _sx=max(0,_vx-_left),_sy=max(0,_vy-_top),
        _sw=min(_width,_vx+view_width-_left)-_sx,
        _sh=min(_height,_vy+view_height-_top)-_sy;
    if(_sw>0 && _sh>0) {
        var _dx=_left+_sx,_dy=_top+_sy;
        draw_surface_part_ext(_surface,_sx,_sy,_sw,_sh,_dx+1,_dy,1,1,c_black,1);
        draw_surface_part_ext(_surface,_sx,_sy,_sw,_sh,_dx-1,_dy,1,1,c_black,1);
        draw_surface_part_ext(_surface,_sx,_sy,_sw,_sh,_dx,_dy+1,1,1,c_black,1);
        draw_surface_part_ext(_surface,_sx,_sy,_sw,_sh,_dx,_dy-1,1,1,c_black,1);
        draw_surface_part(_surface,_sx,_sy,_sw,_sh,_dx,_dy);
    }
    scrFRDrawSprite(spr_top,0,x,y);
    gpu_set_fog(0,0,0,0);
}

// tecaves5365..5412. The source boss shadow is its COMPLETE layered Draw,
// scaled0.9 and shifted by shadow offset, rather than the empty mskNone art.
function scrNTTEFullRedBossShadowDraw(_vx,_vy) {
    var _bosses=scrNTTEFullInstances([NTTEFullTesseract,NTTEFullTesseractDeath])
    for(var _i=0;_i<array_length(_bosses);++_i) with(_bosses[_i]) if(visible && spr_shadow==mskNone) {
        var _old_x=x,_old_y=y,_xs=image_xscale,_ys=image_yscale
        try {
            x+=spr_shadow_x-_vx;y+=spr_shadow_y-_vy
            image_xscale*=0.9;image_yscale*=0.9
            event_perform(ev_draw,0)
        }
        finally {x=_old_x;y=_old_y;image_xscale=_xs;image_yscale=_ys}
    }
}
function scrNTTEFullRedBloomEventDraw() {
    var _xs=image_xscale,_ys=image_yscale,_alpha=image_alpha
    try {
        image_xscale*=2;image_yscale*=2;image_alpha*=0.1
        event_perform(ev_draw,0)
    }
    finally {image_xscale=_xs;image_yscale=_ys;image_alpha=_alpha}
}
// Called inside the real scrDrawBloom additive pass. No second compositor.
function scrNTTEFullRedWorldBloomDraw() {
    with(NTTEFullWarpPortal) scrNTTEFullRedBloomEventDraw()
    with(NTTEFullCrystalHeartBullet) scrNTTEFullRedBloomEventDraw()
    with(NTTEFullRedSlash) draw_sprite_ext(sprite_index,image_index,x,y,1.2*image_xscale,1.2*image_yscale,image_angle,image_blend,0.1*image_alpha)
    with(NTTEFullRedShank) draw_sprite_ext(sprite_index,image_index,x,y,1.2*image_xscale,1.2*image_yscale,image_angle,image_blend,0.1*image_alpha)
    with(NTTEFullTesseractDeath) draw_sprite_ext(sprite_index,0.4*current_frame,x,y,2*image_xscale,2*image_yscale,image_angle,image_blend,(image_alpha*0.2)/max(1,1+throes))
}
// tecaves5555..5580. Apply sine distortion in world coordinates before the
// native target's view-local conversion, preserving the original moving edge.
function scrNTTEFullRedWorldDarkDraw(_gray,_vx,_vy) {
    var _vertices=15+30*_gray,_radius=24+48*_gray,_coefficient=2+_gray
    with(NTTEFullCrystalHeart) {
        var _r=_radius+random(2)
        draw_primitive_begin(pr_trianglefan);draw_vertex(x-_vx,y-_vy)
        for(var _i=0;_i<=_vertices+1;++_i) {
            var _x=x+lengthdir_x(_r,360/_vertices*_i),_y=y+lengthdir_y(_r,360/_vertices*_i)
            _x+=sin(_x*0.1)*_coefficient;_y+=sin(_y*0.1)*_coefficient
            draw_vertex(_x-_vx,_y-_vy)
        }
        draw_primitive_end()
    }
    with(NTTEFullTesseract) draw_circle(x-_vx,y-_vy,64+128*_gray+random(2),false)
}

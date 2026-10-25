// Read-only reference: original scrDrawSpiral 00585f96..00589a24.
// Keep the original with(Spiral) order: its final instance is the outer cap,
// not another sample. Only Red needs the source's authored two-color mesh.
function scrNTTEFullSpiralMeshData(_rings,_draw=false) {
    var _count=array_length(_rings),_vertices=[]
    if(_count<2) return _vertices;
    var _cx=0,_cy=0,_scale=1,_angle=0,_radius=1,
        _newx=[],_newy=[],_newcol=[c_black,c_black]
    if(_draw) draw_primitive_begin(pr_trianglelist);
    for(var _n=0;_n<_count;++_n) {
        var _ring=_rings[_n],_real=_n<_count-1
        if(_real) {
            _cx=_ring.x;_cy=_ring.y
            if(_n==0) _angle=_ring.angle;
            // Original scrCycle69c5c0: subtract min, fmod(range), add range
            // only when negative, then restore min. NTT helper is not native.
            var _turn=(_ring.angle-_angle+180) mod 360
            if(_turn<0) _turn+=360;
            _angle+=clamp(_turn-180,-15,15)
            _scale=_ring.scale;_radius=110*_scale
        } else {_radius*=sqrt(2);_angle+=45}
        if(_n==0) {_newx=array_create(4,_cx);_newy=array_create(4,_cy)}
        var _oldcol=[_newcol[0],_newcol[1]],_oldx=_newx,_oldy=_newy
        _newcol=[_ring.colors[0],_ring.colors[1]]
        if(_scale>=0.8) for(var _i=0;_i<2;++_i)
            _newcol[_i]=merge_color(c_black,_ring.colors[_i],clamp(0.2+_scale,0,1))
        // Source type3 removes the radial palette interpolation.
        if(_ring.type==3) _oldcol=[_newcol[0],_newcol[1]];
        _newx=[];_newy=[]
        for(var _i=0;_i<4;++_i) {
            _newx[_i]=_cx+lengthdir_x(_radius,_angle+_i*90)
            _newy[_i]=_cy+lengthdir_y(_radius,_angle+_i*90)
        }
        for(var _i=0;_i<4;++_i) {
            var _next=(_i+1) mod 4,_col=_i&1
            // Production emits directly, without thousands of transient
            // per-vertex arrays on each loading-screen frame.
            if(_draw) {
                draw_vertex_color(_oldx[_i],_oldy[_i],_oldcol[_col],1)
                draw_vertex_color(_oldx[_next],_oldy[_next],_oldcol[_col],1)
                draw_vertex_color(_newx[_i],_newy[_i],_newcol[_col],1)
                if(_real) {
                    draw_vertex_color(_oldx[_next],_oldy[_next],_oldcol[_col],1)
                    draw_vertex_color(_newx[_next],_newy[_next],_newcol[_col],1)
                    draw_vertex_color(_newx[_i],_newy[_i],_newcol[_col],1)
                }
            } else {
                array_push(_vertices,[_oldx[_i],_oldy[_i],_oldcol[_col]],
                    [_oldx[_next],_oldy[_next],_oldcol[_col]],
                    [_newx[_i],_newy[_i],_newcol[_col]])
                if(_real) array_push(_vertices,[_oldx[_next],_oldy[_next],_oldcol[_col]],
                    [_newx[_next],_newy[_next],_newcol[_col]],
                    [_newx[_i],_newy[_i],_newcol[_col]])
            }
        }
    }
    if(_draw) draw_primitive_end();
    return _vertices;
}
function scrNTTEFullSpiralMeshDraw(_vertices) {
    if(array_length(_vertices)==0) return;
    var _old_color=draw_get_color(),_old_alpha=draw_get_alpha()
    draw_primitive_begin(pr_trianglelist)
    for(var _i=0;_i<array_length(_vertices);++_i) {
        var _v=_vertices[_i]
        draw_vertex_color(_v[0],_v[1],_v[2],1)
    }
    draw_primitive_end()
    draw_set_color(_old_color);draw_set_alpha(_old_alpha)
}
function scrNTTEFullRedSpiralDraw(_width=undefined,_height=undefined) {
    if(is_undefined(_width)) {
        if(!surface_exists(application_surface)) return false;
        _width=surface_get_width(application_surface);_height=surface_get_height(application_surface)
    }
    // Original 0058509e multiplies width and height; this is an area threshold.
    if(_width*_height<=307200) return false;
    var _rings=[],_starfield=scrNTTERefSprite("SpiralStarfield")
    with(Spiral) {
        if(sprite_index!=_starfield || !variable_instance_exists(id,"colors")) return false;
        array_push(_rings,{x:view_xview+x,y:view_yview+y,angle:image_angle,
            scale:image_xscale,colors:colors,type:scrNTTEFullValue(id,"type",0)})
    }
    if(array_length(_rings)<2) return false;
    var _old_color=draw_get_color(),_old_alpha=draw_get_alpha()
    scrNTTEFullSpiralMeshData(_rings,true)
    draw_set_color(_old_color);draw_set_alpha(_old_alpha)
    return true;
}

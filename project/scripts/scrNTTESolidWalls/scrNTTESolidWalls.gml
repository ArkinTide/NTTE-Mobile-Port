// Static exterior collision, following the mobile Hardmode compact-wall model.
// Authored Wall and TopSmall tiles still own the edge and transition artwork.
// Empty ocean/abyss space is gameplay terrain, not an exterior wall.
function scrNTTESolidWallArea() {
    if(!instance_exists(GameCont) || instance_exists(MenuGen) || instance_exists(Menu)) return false;
    if(array_contains([201,202,204,205],GameCont.area)) return false;
    if(instance_exists(Nothing2) || instance_exists(Nothing2Appear) || instance_exists(Nothing2Death)) return false;
    return true;
}
function scrNTTESolidWallCreate() {
    ntte_solid_fill=true;ntte_fill_width=16;ntte_fill_height=16;
    area=GameCont.area;solid=true;visible=false;mask_index=mskWall;
    sprite_index=mskNone;image_speed=0;topspr=-1;outspr=-1;
    topindex=0;outindex=0;l=0;r=0;w=0;h=0;
}
function scrNTTESolidWallBlock(_x,_y,_w,_h) {
    // Bypass Wall.Create: packing must neither consume gameplay RNG nor spawn
    // hundreds of decorative controllers in the deep exterior.
    var _v=instance_create_depth(_x,_y,0,NTTESolidWall);
    _v.ntte_fill_width=_w;_v.ntte_fill_height=_h;
    _v.image_xscale=_w/16;_v.image_yscale=_h/16;
    return _v;
}
function scrNTTESolidWallSplit(_wall) {
    if(!instance_exists(_wall)) return [];
    var _w=_wall.ntte_fill_width,_h=_wall.ntte_fill_height;
    if(_w==16 && _h==16) return [_wall];
    var _x=_wall.x,_y=_wall.y,_area=_wall.area,_blend=_wall.image_blend,_out=[];
    instance_destroy(_wall,false);
    for(var _dy=0;_dy<_h;_dy+=16) for(var _dx=0;_dx<_w;_dx+=16) {
        var _v=scrNTTESolidWallBlock(_x+_dx,_y+_dy,16,16);
        _v.area=_area;_v.image_blend=_blend;array_push(_out,_v);
    }
    return _out;
}
function scrNTTESolidWallMaterialize(_x1,_y1,_x2,_y2) {
    var _list=ds_list_create(),_out=[];
    try {
        collision_rectangle_list(_x1,_y1,_x2,_y2,NTTESolidWall,false,false,_list,false);
        for(var _i=0;_i<ds_list_size(_list);++_i) {
            var _cells=scrNTTESolidWallSplit(_list[|_i]);
            for(var _j=0;_j<array_length(_cells);++_j) array_push(_out,_cells[_j]);
        }
    } finally {ds_list_destroy(_list);}
    return _out;
}
function scrNTTESolidWallCarve(_x,_y,_w,_h) {
    if(!instance_exists(NTTESolidWall)) return;
    var _cells=scrNTTESolidWallMaterialize(_x-32,_y-32,_x+_w+31,_y+_h+31);
    for(var _i=0;_i<array_length(_cells);++_i) if(instance_exists(_cells[_i])) with(_cells[_i]) {
        if(x<_x+_w && x+ntte_fill_width>_x && y<_y+_h && y+ntte_fill_height>_y) instance_destroy(id,false);
        else if(ntte_fill_width==16 && ntte_fill_height==16
            && collision_rectangle(x-16,y-16,x+31,y+31,Floor,false,false)!=noone) {
            // Only a newly exposed edge receives normal artwork. Unbroken
            // exterior collision remains packed and plain.
            image_xscale=1;image_yscale=1;ntte_solid_fill=false;
            instance_change(Wall,true);
        }
    }
}
function scrNTTESolidWallDestroy(_wall) {
    if(!instance_exists(_wall) || !instance_is(_wall,NTTESolidWall)
        || (_wall.ntte_fill_width==16 && _wall.ntte_fill_height==16)) return false;
    var _cause=id;
    if(_cause==_wall && instance_exists(other)) _cause=other.id;
    var _cx=_wall.x+8,_cy=_wall.y+8;
    if(instance_exists(_cause) && _cause!=_wall) {_cx=_cause.x;_cy=_cause.y;}
    var _cells=scrNTTESolidWallSplit(_wall),_nearest=noone,_distance=infinity;
    for(var _i=0;_i<array_length(_cells);++_i) {
        var _v=_cells[_i],_d=point_distance(_v.x+8,_v.y+8,_cx,_cy);
        if(_d<_distance) {_nearest=_v;_distance=_d;}
    }
    if(instance_exists(_nearest)) scrWallDestroy(_nearest);
    return true;
}
function scrNTTESolidWallGenerate() {
    if(!scrNTTESolidWallArea() || !instance_exists(Floor)) return;
    var _floors=scrNTTEFullInstances(Floor),_chunks=ds_map_create(),_order=[];
    try {
        // Sparse 64px chunks: distant authored rooms must not allocate a
        // rectangle covering all the empty space between their coordinates.
        // A 160px collar exceeds the normal visible exterior around floors.
        for(var _i=0;_i<array_length(_floors);++_i) {
            var _v=_floors[_i],_a=floor((_v.bbox_left-160)/64),_b=floor((_v.bbox_top-160)/64),
                _c=floor((_v.bbox_right+159)/64),_d=floor((_v.bbox_bottom+159)/64);
            for(var _cy=_b;_cy<=_d;++_cy) for(var _cx=_a;_cx<=_c;++_cx) {
                var _key=string(_cx)+","+string(_cy);
                if(ds_map_exists(_chunks,_key)) continue;
                var _chunk={x:_cx*64,y:_cy*64,mask:0};
                _chunks[? _key]=_chunk;array_push(_order,_chunk);
            }
        }
        var _occupied=scrNTTEFullInstances([Floor,Wall,InvisiWall]);
        for(var _i=0;_i<array_length(_occupied);++_i) {
            var _v=_occupied[_i],_a=floor(_v.bbox_left/16),_b=floor(_v.bbox_top/16),
                _c=ceil(_v.bbox_right/16)-1,_d=ceil(_v.bbox_bottom/16)-1;
            for(var _gy=_b;_gy<=_d;++_gy) for(var _gx=_a;_gx<=_c;++_gx) {
                var _cx=floor(_gx/4),_cy=floor(_gy/4),_key=string(_cx)+","+string(_cy);
                if(!ds_map_exists(_chunks,_key)) continue;
                var _chunk=_chunks[? _key],_bit=(_gy-_cy*4)*4+_gx-_cx*4;
                _chunk.mask|=1<<_bit;
            }
        }
        for(var _i=0;_i<array_length(_order);++_i) {
            var _chunk=_order[_i];
            for(var _y=0;_y<4;++_y) for(var _x=0;_x<4;++_x) {
                if((_chunk.mask & (1<<(_y*4+_x)))!=0) continue;
                var _size=1;
                for(var _candidate=4;_candidate>=2;_candidate/=2) {
                    if(_x+_candidate>4 || _y+_candidate>4) continue;
                    var _free=true;
                    for(var _dy=0;_dy<_candidate;++_dy) for(var _dx=0;_dx<_candidate;++_dx)
                        if((_chunk.mask & (1<<((_y+_dy)*4+_x+_dx)))!=0) _free=false;
                    if(_free) {_size=_candidate;break;}
                }
                scrNTTESolidWallBlock(_chunk.x+16*_x,_chunk.y+16*_y,16*_size,16*_size);
                for(var _dy=0;_dy<_size;++_dy) for(var _dx=0;_dx<_size;++_dx)
                    _chunk.mask|=1<<((_y+_dy)*4+_x+_dx);
            }
        }
    } finally {ds_map_destroy(_chunks);}
}
function scrNTTESolidWallDraw() {
    var _color=draw_get_color(),_alpha=draw_get_alpha();
    with(NTTESolidWall) if(x+ntte_fill_width>=view_xview && x<=view_xview+view_width
        && y+ntte_fill_height>=view_yview && y-8<=view_yview+view_height) {
        var _base=scrAreaGetBackroundColor(area,false);
        draw_set_color(make_color_rgb(color_get_red(_base)*color_get_red(image_blend)/255,
            color_get_green(_base)*color_get_green(image_blend)/255,color_get_blue(_base)*color_get_blue(image_blend)/255));
        draw_set_alpha(image_alpha);draw_rectangle(x,y-8,x+ntte_fill_width,y+ntte_fill_height-8,false);
    }
    draw_set_color(_color);draw_set_alpha(_alpha);
}

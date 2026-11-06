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
    // Retain actual source weather/area colour per packed piece.
    ntte_fill_color=scrFRWallBackgroundColor();ntte_fill_color_area=area;
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
function scrNTTESolidWallPiece(_x,_y,_w,_h,_state) {
    if(_w<=0 || _h<=0) return noone;
    var _v=scrNTTESolidWallBlock(_x,_y,_w,_h);
    _v.area=_state.area;_v.image_blend=_state.blend;_v.image_alpha=_state.alpha;
    scrFRWallCopyFillColor(_v,_state);
    return _v;
}
function scrNTTESolidWallSplit(_wall,_x1=undefined,_y1=undefined,_x2=undefined,_y2=undefined) {
    if(!instance_exists(_wall)) return [];
    var _w=_wall.ntte_fill_width,_h=_wall.ntte_fill_height;
    if(_w==16 && _h==16) return [_wall];
    var _x=_wall.x,_y=_wall.y,_out=[],
        _state={area:_wall.area,blend:_wall.image_blend,alpha:_wall.image_alpha,
            color:scrFRWallFillColor(_wall)};
    if(is_undefined(_x1)) {_x1=_x;_y1=_y;_x2=_x+_w-1;_y2=_y+_h-1;}
    var _a=clamp(floor((_x1-_x)/16)*16,0,_w),_b=clamp(floor((_y1-_y)/16)*16,0,_h),
        _c=clamp((floor((_x2-_x)/16)+1)*16,0,_w),_d=clamp((floor((_y2-_y)/16)+1)*16,0,_h);
    if(_a>=_c || _b>=_d) return [];
    instance_destroy(_wall,false);
    // Split only the contacted rectangle into 16px cells. Even a large packed
    // exterior stays at most four plain remainder blocks after a local hit.
    scrNTTESolidWallPiece(_x,_y,_a,_h,_state);
    scrNTTESolidWallPiece(_x+_c,_y,_w-_c,_h,_state);
    scrNTTESolidWallPiece(_x+_a,_y,_c-_a,_b,_state);
    scrNTTESolidWallPiece(_x+_a,_y+_d,_c-_a,_h-_d,_state);
    for(var _dy=_b;_dy<_d;_dy+=16) for(var _dx=_a;_dx<_c;_dx+=16)
        array_push(_out,scrNTTESolidWallPiece(_x+_dx,_y+_dy,16,16,_state));
    return _out;
}
function scrNTTESolidWallMaterialize(_x1,_y1,_x2,_y2) {
    if(!instance_exists(NTTESolidWall)) return [];
    var _list=ds_list_create(),_out=[];
    try {
        collision_rectangle_list(_x1,_y1,_x2,_y2,NTTESolidWall,false,false,_list,false);
        for(var _i=0;_i<ds_list_size(_list);++_i) {
            var _cells=scrNTTESolidWallSplit(_list[|_i],_x1,_y1,_x2,_y2);
            for(var _j=0;_j<array_length(_cells);++_j) array_push(_out,_cells[_j]);
        }
    } finally {ds_list_destroy(_list);}
    return _out;
}
// Layout/decorative probes describe the authored boundary, not its solid
// background fill. Gameplay collision continues to query the full Wall family.
function scrNTTESolidWallAuthored(_instances) {
    var _out=[];
    for(var _i=0;_i<array_length(_instances);++_i)
        if(instance_exists(_instances[_i]) && _instances[_i].object_index!=NTTESolidWall)
            array_push(_out,_instances[_i]);
    return _out;
}
function scrNTTESolidWallPlanRect(_x1,_y1,_x2,_y2,_objects=Wall) {
    return scrNTTEFullRectInstances(_x1,_y1,_x2,_y2,_objects,false,false,true);
}
function scrNTTESolidWallPlanPlace(_x,_y) {
    var _list=ds_list_create(),_found=false;
    try {
        instance_place_list(_x,_y,Wall,_list,false);
        for(var _i=0;_i<ds_list_size(_list);++_i)
            if(_list[|_i].object_index!=NTTESolidWall) {_found=true;break;}
    } finally {ds_list_destroy(_list);}
    return _found;
}
function scrNTTESolidWallPlanPoint(_x,_y) {
    var _list=ds_list_create(),_found=false;
    try {
        collision_point_list(_x,_y,Wall,false,false,_list,false);
        for(var _i=0;_i<ds_list_size(_list);++_i)
            if(_list[|_i].object_index!=NTTESolidWall) {_found=true;break;}
    } finally {ds_list_destroy(_list);}
    return _found;
}
function scrNTTESolidWallCellAt(_wall,_x,_y) {
    if(!instance_exists(_wall) || _wall.object_index!=NTTESolidWall) return _wall;
    var _tx=_wall.x+clamp(floor((_x-_wall.x)/16)*16,0,_wall.ntte_fill_width-16),
        _ty=_wall.y+clamp(floor((_y-_wall.y)/16)*16,0,_wall.ntte_fill_height-16),
        _cells=scrNTTESolidWallSplit(_wall,_tx,_ty,_tx+15,_ty+15);
    return array_length(_cells)?_cells[0]:noone;
}
// Nonmutating equivalent of the original tile origin/centre for collision
// response and impact artwork. Do not split terrain merely to read a point.
function scrNTTESolidWallContact(_wall,_x,_y,_center=true) {
    if(_wall.object_index!=NTTESolidWall)
        return _center?[(_wall.bbox_left+_wall.bbox_right)/2,(_wall.bbox_top+_wall.bbox_bottom)/2]:[_wall.x,_wall.y];
    var _offset=_center?8:0;
    return [_wall.x+clamp(floor((_x-_wall.x)/16)*16,0,_wall.ntte_fill_width-16)+_offset,
        _wall.y+clamp(floor((_y-_wall.y)/16)*16,0,_wall.ntte_fill_height-16)+_offset];
}
function scrNTTESolidWallMaterializeShape(_who,_expose=false) {
    if(!instance_exists(_who)) return;
    var _cells=scrNTTESolidWallMaterialize(_who.bbox_left,_who.bbox_top,_who.bbox_right-1,_who.bbox_bottom-1);
    if(!_expose) return;
    var _area=GameCont.area;
    try {
        for(var _i=0;_i<array_length(_cells);++_i) with(_cells[_i]) {
            if(!place_meeting(x,y,_who)) continue;
            GameCont.area=area;ntte_solid_fill=false;instance_change(Wall,true);
        }
    } finally {GameCont.area=_area;}
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
    // A native collision previously fired once per 16px tile. A packed block
    // fires once for its entire rectangle: clear EVERY contacted cell of a
    // wide explosion, boss mask or PortalClear tunnel, preserving the rest.
    if(instance_exists(_cause) && _cause!=_wall) {
        var _a=max(_wall.bbox_left,_cause.bbox_left),_b=max(_wall.bbox_top,_cause.bbox_top),
            _c=min(_wall.bbox_right-1,_cause.bbox_right-1),_d=min(_wall.bbox_bottom-1,_cause.bbox_bottom-1);
        if(_a<=_c && _b<=_d) {
            var _cells=scrNTTESolidWallSplit(_wall,_a,_b,_c,_d),_hits=0;
            for(var _i=0;_i<array_length(_cells);++_i) if(instance_exists(_cells[_i])) {
                var _cell=_cells[_i],_touch=false;
                with(_cell) _touch=place_meeting(x,y,_cause);
                if(_touch) {++_hits;scrWallDestroy(_cell);}
            }
            if(_hits>0) return true;
            // Some native collisions test the next position before integration.
            // Keep their contact-cell fallback without splitting the remainder.
            var _nearest=noone,_distance=infinity;
            for(var _i=0;_i<array_length(_cells);++_i) if(instance_exists(_cells[_i])) {
                var _v=_cells[_i],_dis=point_distance(_v.x+8,_v.y+8,_cause.x,_cause.y);
                if(_dis<_distance) {_nearest=_v;_distance=_dis;}
            }
            if(instance_exists(_nearest)) scrWallDestroy(_nearest);
            return true;
        }
    }
    var _cx=_wall.x+8,_cy=_wall.y+8;
    if(instance_exists(_cause) && _cause!=_wall) {_cx=_cause.x;_cy=_cause.y;}
    var _tx=_wall.x+clamp(floor((_cx-_wall.x)/16)*16,0,_wall.ntte_fill_width-16),
        _ty=_wall.y+clamp(floor((_cy-_wall.y)/16)*16,0,_wall.ntte_fill_height-16);
    var _cells=scrNTTESolidWallSplit(_wall,_tx,_ty,_tx+15,_ty+15),_nearest=noone,_distance=infinity;
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
        // Merge wholly empty adjacent 64px chunks before filling the partial
        // chunks. This reduces the native Wall collision-query population;
        // only existing sparse chunks participate, never the gap between rooms.
        for(var _i=0;_i<array_length(_order);++_i) {
            var _chunk=_order[_i];
            if(_chunk.mask!=0) continue;
            var _cx=_chunk.x/64,_cy=_chunk.y/64,_cw=1,_ch=1;
            while(_cw<4) {
                var _key=string(_cx+_cw)+","+string(_cy);
                if(!ds_map_exists(_chunks,_key) || _chunks[? _key].mask!=0) break;
                ++_cw;
            }
            while(_ch<4) {
                var _free=true;
                for(var _dx=0;_dx<_cw;++_dx) {
                    var _key=string(_cx+_dx)+","+string(_cy+_ch);
                    if(!ds_map_exists(_chunks,_key) || _chunks[? _key].mask!=0) {_free=false;break;}
                }
                if(!_free) break;
                ++_ch;
            }
            for(var _dy=0;_dy<_ch;++_dy) for(var _dx=0;_dx<_cw;++_dx) {
                var _key=string(_cx+_dx)+","+string(_cy+_dy);
                _chunks[? _key].mask=65535;
            }
            scrNTTESolidWallBlock(_chunk.x,_chunk.y,64*_cw,64*_ch);
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
// Cull once for artwork, shadows and plain exterior drawing. Plain collision
// never needs a TopSmall collision probe, sprite lookup or reflected shadow.
function scrNTTEWallVisibilityBuild(_left,_top,_right,_bottom,_cull) {
    var _walls=global.lis_walls_visible,_floors=global.lis_floors_visible,_fill=[];
    ds_list_clear(_walls);ds_list_clear(_floors);
    with(Wall) {
        if(_cull && (bbox_right<_left || bbox_bottom<_top || bbox_left>=_right || bbox_top>=_bottom)) continue;
        if(object_index==NTTESolidWall) array_push(_fill,id);
        else ds_list_add(_walls,id);
    }
    with(Floor) {
        if(!_cull || (bbox_right>=_left && bbox_bottom>=_top && bbox_left<_right && bbox_top<_bottom))
            ds_list_add(_floors,id);
    }
    // Managed array follows the controller lifetime; no extra surface, DS
    // allocation or stale map-wide cache to rebuild after terrain destruction.
    UberCont.ntte_fill_visible=_fill;
}
function scrNTTESolidWallColor(_base,_blend) {
    if(_blend==c_white) return _base;
    return make_color_rgb(color_get_red(_base)*color_get_red(_blend)/255,
        color_get_green(_base)*color_get_green(_blend)/255,color_get_blue(_base)*color_get_blue(_blend)/255);
}
function scrNTTESolidWallDraw() {
    if(!variable_instance_exists(UberCont,"ntte_fill_visible")) return;
    var _fill=UberCont.ntte_fill_visible,_color=draw_get_color(),_alpha=draw_get_alpha(),
        _last_color=-1,_last_alpha=-1;
    for(var _i=0;_i<array_length(_fill);++_i) {
        var _wall=_fill[_i];
        if(!instance_exists(_wall) || _wall.object_index!=NTTESolidWall) continue;
        with(_wall) {
            var _tint=scrNTTESolidWallColor(scrFRWallFillColor(id),image_blend);
            if(_tint!=_last_color) {draw_set_color(_tint);_last_color=_tint;}
            if(image_alpha!=_last_alpha) {draw_set_alpha(image_alpha);_last_alpha=image_alpha;}
            draw_rectangle(x,y-8,x+ntte_fill_width,y+ntte_fill_height-8,false);
        }
    }
    draw_set_color(_color);draw_set_alpha(_alpha);
}

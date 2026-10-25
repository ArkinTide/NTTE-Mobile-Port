// teevents.mod.gml:2653..3268 and telib floor/wall/path prerequisites.
// Native floor_normal is object_index==Floor; FloorExplo derives from Floor.
// Modern runner bbox_right/bottom are exclusive. NTT source treats them as
// inclusive pixel bounds; subtract one before applying original +1 arithmetic.
function scrNTTEFullInstances(_object,_normal=false) {
    var _out=[]
    if (is_array(_object)) {
        var _seen={}
        for(var _i=0;_i<array_length(_object);++_i) {
            var _part=scrNTTEFullInstances(_object[_i],_normal)
            for(var _j=0;_j<array_length(_part);++_j) {
                // A numeric ID and typed reference can denote the same
                // instance. Keep the Runner's original equality inside that
                // ID's bucket, including the first returned value's type.
                var _key=string(real(_part[_j])),_bucket=[]
                if(variable_struct_exists(_seen,_key)) {
                    _bucket=_seen[$ _key]
                    if(array_get_index(_bucket,_part[_j])>=0) continue
                }
                array_push(_bucket,_part[_j]);_seen[$ _key]=_bucket
                array_push(_out,_part[_j])
            }
        }
    }
    else if (object_exists(_object) || _object==all) {
        // Native with order differs from instance_find on this Runner. Keep
        // the source order: callers consume RNG and dispatch events per ID.
        var _n=instance_number(_object)
        for(var _i=0;_i<_n;++_i) {
            var _v=instance_find(_object,_i)
            if(instance_exists(_v) && (!_normal || _v.object_index==Floor)) array_push(_out,_v)
        }
    }
    else if (instance_exists(_object) && (!_normal || _object.object_index==Floor)) array_push(_out,_object)
    return _out
}

function scrNTTEFullRectInstances(_x1,_y1,_x2,_y2,_objects,_positions=false,_normal=false) {
    // Empty queries need no ordered result. Keep every nonempty result on
    // the original instance_find path; with order/reference types can differ.
    if(!scrNTTEFullRectHasAny(_x1,_y1,_x2,_y2,_objects,_positions,_normal)) return [];
    var _src=scrNTTEFullInstances(_objects,_normal),_out=[]
    for(var _i=0;_i<array_length(_src);++_i) {
        var _v=_src[_i]
        if (_positions ? (_v.x>=_x1 && _v.y>=_y1 && _v.x<=_x2 && _v.y<=_y2)
            : ((_v.bbox_right-1)>=_x1 && (_v.bbox_bottom-1)>=_y1 && _v.bbox_left<=_x2 && _v.bbox_top<=_y2)) array_push(_out,_v)
    }
    return _out
}

function scrNTTEFullRectHasAny(_x1,_y1,_x2,_y2,_objects,_positions=false,_normal=false) {
    if(is_array(_objects)) {
        for(var _i=0;_i<array_length(_objects);++_i)
            if(scrNTTEFullRectHasAny(_x1,_y1,_x2,_y2,_objects[_i],_positions,_normal)) return true;
        return false;
    }
    if(object_exists(_objects) || _objects==all) {
        var _found=false
        with(_objects) {
            if(_normal && object_index!=Floor) continue;
            if(_positions ? (x>=_x1 && y>=_y1 && x<=_x2 && y<=_y2)
                : ((bbox_right-1)>=_x1 && (bbox_bottom-1)>=_y1 && bbox_left<=_x2 && bbox_top<=_y2)) {
                _found=true;break;
            }
        }
        return _found;
    }
    if(!instance_exists(_objects) || (_normal && _objects.object_index!=Floor)) return false;
    return _positions ? (_objects.x>=_x1 && _objects.y>=_y1 && _objects.x<=_x2 && _objects.y<=_y2)
        : ((_objects.bbox_right-1)>=_x1 && (_objects.bbox_bottom-1)>=_y1 && _objects.bbox_left<=_x2 && _objects.bbox_top<=_y2);
}

function scrNTTEFullWorldNearestRectBBox(_x1,_y1,_x2,_y2,_objects) {
    var _src=scrNTTEFullInstances(_objects),_cx=(_x1+_x2)/2,_cy=(_y1+_y2)/2,_a=infinity,_b=infinity,_near=noone
    for(var _i=0;_i<array_length(_src);++_i) {
        var _v=_src[_i],_px=clamp(_cx,_v.bbox_left,(_v.bbox_right-1)+1),_py=clamp(_cy,_v.bbox_top,(_v.bbox_bottom-1)+1)
        var _da=point_distance(_px,_py,clamp(_px,_x1,_x2),clamp(_py,_y1,_y2)),_db=point_distance(_px,_py,_cx,_cy)
        if (_da<_a || (_da==_a && _db<_b)) { _a=_da; _b=_db; _near=_v }
    }
    return _near
}

// telib:3497..3578. A reveal is a mutable record, because callers extend its
// delay and clip its rectangle after creation (notably the Lair border).
function scrNTTEFullFloorReveal(_x1,_y1,_x2,_y2,_time) {
    var _controller=instance_find(NTTEFullFloorReveal,0)
    if (!instance_exists(_controller)) _controller=instance_create(0,0,NTTEFullFloorReveal)
    var _reveal={creator:_controller,x1:_x1,y1:_y1,x2:_x2,y2:_y2,ox:0,oy:-8,
        time:_time,time_max:_time,color:scrAreaGetBackroundColor(GameCont.area),flash:true,flash_color:c_white}
    _controller.visible=true
    array_push(_controller.list,_reveal)
    return _reveal
}

function scrNTTEFullFloorRevealDraw() {
    var _destroy=[FloorExplo,Explosion,PortalClear,EnergyHammerSlash]
    for(var _i=array_length(list)-1;_i>=0;--_i) {
        var _v=list[_i]
        if (_v.time>0 && (_v.time<=_v.time_max || array_length(scrNTTEFullRectInstances(_v.x1,_v.y1,_v.x2,_v.y2,_destroy))==0)) {
            var _num=clamp(_v.time/_v.time_max,0,1)
            var _color=_v.time>_v.time_max ? _v.color:merge_color(_v.flash_color,_v.color,_v.flash ? 1-_num:_num)
            draw_set_alpha(_num); draw_set_color(_color)
            draw_rectangle(_v.x1+_v.ox,_v.y1+_v.oy,_v.x2+_v.ox,_v.y2+_v.oy,false)
            _v.time-=timescale
        }
        else array_delete(list,_i,1)
    }
    draw_set_alpha(1)
    if (!array_length(list)) visible=false
}

function scrNTTEFullFloorTunnel(_x1,_y1,_x2,_y2) {
    var _tunnel=instance_create(_x1,_y1,PortalClear)
    with (_tunnel) {
        sprite_index=sprBoltTrail
        image_xscale=point_distance(x,y,_x2,_y2); image_yscale=16
        image_angle=point_direction(x,y,_x2,_y2)
        image_speed=image_xscale>0 ? 16/image_xscale*timescale:0
        if (instance_exists(Wall) && !place_meeting(x,y,Wall) && !place_meeting(x,y,Floor)) {
            var _near=scrNTTEFullWorldNearestRectBBox(x,y,x,y,Wall)
            if (instance_exists(_near)) instance_create(_near.x+floor((x-_near.x)/16)*16,_near.y+floor((y-_near.y)/16)*16,Wall)
        }
    }
    return _tunnel
}

function scrNTTEFullFloorInit() {
    if (!variable_global_exists("ntte_full_floor_initialized")) {
        global.ntte_full_floor_initialized=true
        global.ntte_full_floor_style=undefined; global.ntte_full_floor_area=undefined
        global.ntte_full_floor_aw=undefined; global.ntte_full_floor_ah=undefined
        global.ntte_full_floor_ax=undefined; global.ntte_full_floor_ay=undefined
    }
}

function scrNTTEFullFloorSetStyle(_style,_area=undefined) {
    scrNTTEFullFloorInit()
    global.ntte_full_floor_style=_style
    if (argument_count>1) global.ntte_full_floor_area=_area
}

function scrNTTEFullFloorResetStyle() { scrNTTEFullFloorSetStyle(undefined,undefined) }

function scrNTTEFullFloorSetAlign(_w,_h,_x=undefined,_y=undefined) {
    scrNTTEFullFloorInit()
    global.ntte_full_floor_aw=_w; global.ntte_full_floor_ah=_h
    if (argument_count>2) global.ntte_full_floor_ax=_x
    if (argument_count>3) global.ntte_full_floor_ay=_y
}

function scrNTTEFullFloorResetAlign() { scrNTTEFullFloorSetAlign(undefined,undefined,undefined,undefined) }

function scrNTTEFullFloorAlignRound(_n,_precision,_bias) {
    if (_precision==0) return _n
    var _v=_n/_precision
    if (_bias<0) _v=floor(_v)
    else if (_bias>0 || frac(_v)==0.5) _v=ceil(_v)
    else _v=round(_v)
    return _v*_precision
}

function scrNTTEFullFloorAlign(_x,_y,_w,_h,_type) {
    scrNTTEFullFloorInit()
    var _wa=is_undefined(global.ntte_full_floor_aw),_ha=is_undefined(global.ntte_full_floor_ah)
    var _xa=is_undefined(global.ntte_full_floor_ax),_ya=is_undefined(global.ntte_full_floor_ay)
    var _gw=_wa ? 16:global.ntte_full_floor_aw,_gh=_ha ? 16:global.ntte_full_floor_ah
    var _gx=_xa ? 10000:global.ntte_full_floor_ax,_gy=_ya ? 10000:global.ntte_full_floor_ay,_xb=0,_yb=0
    if (_wa || _ha || _xa || _ya) {
        if (!instance_exists(FloorMaker)) {
            if (_xa || _ya) {
                var _near=scrNTTEFullWorldNearestRectBBox(_x,_y,_x+_w,_y+_h,Floor)
                if (instance_exists(_near)) {
                    if (_xa) { _gx=_near.x; _xb=(_near.bbox_left+(_near.bbox_right-1)+1)/2-(_x+_w/2) }
                    if (_ya) { _gy=_near.y; _yb=(_near.bbox_top+(_near.bbox_bottom-1)+1)/2-(_y+_h/2) }
                }
            }
            var _fx=_gx+scrNTTEFullFloorAlignRound(_x-_gx,_gw,_xb),_fy=_gy+scrNTTEFullFloorAlignRound(_y-_gy,_gh,_yb)
            var _fwmax=_gw,_fhmax=_gh,_touch=scrNTTEFullRectInstances(_fx,_fy,_fx+_w-1,_fy+_h-1,Floor)
            for(var _i=0;_i<array_length(_touch);++_i) {
                var _v=_touch[_i],_fw=(_v.bbox_right-1)+1-_v.bbox_left,_fh=(_v.bbox_bottom-1)+1-_v.bbox_top
                if (_fw>=_fwmax) {
                    _fwmax=_fw; if (_wa) _gw=_fwmax
                    if (_xa) { _gx=_v.x; _xb=(_v.bbox_left+(_v.bbox_right-1)+1)/2-(_x+_w/2) }
                }
                if (_fh>=_fhmax) {
                    _fhmax=_fh; if (_ha) _gh=_fhmax
                    if (_ya) { _gy=_v.y; _yb=(_v.bbox_top+(_v.bbox_bottom-1)+1)/2-(_y+_h/2) }
                }
            }
            if (_xb!=0 || _yb!=0) {
                _fx=_gx+scrNTTEFullFloorAlignRound(_x-_gx,_gw,0); _fy=_gy+scrNTTEFullFloorAlignRound(_y-_gy,_gh,0)
                var _overlap=_type=="round"
                    ? (collision_rectangle(_fx+32,_fy,_fx+_w-33,_fy+_h-1,Floor,false,false)
                      || collision_rectangle(_fx,_fy+32,_fx+_w-1,_fy+_h-33,Floor,false,false))
                    : collision_rectangle(_fx,_fy,_fx+_w-1,_fy+_h-1,Floor,false,false)
                if (_overlap) { _xb=0; _yb=0 }
            }
        }
        else {
            var _maker=instance_nearest(_x+max(0,_w/2-16),_y+max(0,_h/2-16),FloorMaker)
            if (_xa) _gx=_maker.x
            if (_ya) _gy=_maker.y
            if (_wa) _gw=min(_w,32)
            if (_ha) _gh=min(_h,32)
        }
    }
    return [_gx+scrNTTEFullFloorAlignRound(_x-_gx,_gw,_xb),_gy+scrNTTEFullFloorAlignRound(_y-_gy,_gh,_yb)]
}

function scrNTTEFullWallDelete(_x1,_y1,_x2,_y2) {
    var _walls=scrNTTEFullRectInstances(_x1,_y1,_x2,_y2,[Wall,InvisiWall])
    for(var _i=0;_i<array_length(_walls);++_i) with (_walls[_i]) {
        var _wx=x,_wy=y
        with (TrapScorchMark) if (x==_wx && y==_wy) instance_destroy(id,false)
        instance_destroy(id,false)
    }
    // BEGIN NTTE WALLDELETE TOPS CANDIDATE 20261023
    // Exact family order and bbox predicate; no Cleanup in audited families.
    with(TopSmall) if((bbox_right-1)>=_x1 && (bbox_bottom-1)>=_y1 && bbox_left<=_x2 && bbox_top<=_y2) instance_destroy(id,false)
    with(TopPot) if((bbox_right-1)>=_x1 && (bbox_bottom-1)>=_y1 && bbox_left<=_x2 && bbox_top<=_y2) instance_destroy(id,false)
    with(Bones) if((bbox_right-1)>=_x1 && (bbox_bottom-1)>=_y1 && bbox_left<=_x2 && bbox_top<=_y2) instance_destroy(id,false)
    // END NTTE WALLDELETE TOPS CANDIDATE 20261023
}

function scrNTTEFullFloorWalls(_floor) {
    var _fs=scrNTTEFullInstances(_floor),_out=[]
    for(var _i=0;_i<array_length(_fs);++_i) with (_fs[_i]) {
        var _x1=bbox_left-16,_y1=bbox_top-16,_x2=(bbox_right-1)+17,_y2=(bbox_bottom-1)+17
        for(var _x=_x1;_x<_x2;_x+=16) for(var _y=_y1;_y<_y2;_y+=16) {
            if ((_x==_x1 || _y==_y1 || _x==_x2-16 || _y==_y2-16) && !position_meeting(_x,_y,Floor)) array_push(_out,instance_create(_x,_y,Wall))
        }
    }
    return _out
}

function scrNTTEFullWallUpdate(_x1,_y1,_x2,_y2) {
    var _ws=scrNTTEFullRectInstances(_x1,_y1,_x2,_y2,Wall,true)
    for(var _i=0;_i<array_length(_ws);++_i) with (_ws[_i]) {
        visible=place_meeting(x,y+16,Floor)
        l=place_free(x-16,y) ? 0:4; w=(place_free(x+16,y) ? 24:20)-l
        r=place_free(x,y-16) ? 0:4; h=(place_free(x,y+16) ? 24:20)-r
        instance_create(x-16,y-16,Top); instance_create(x-16,y,Top); instance_create(x,y-16,Top); instance_create(x,y,Top)
    }
}

function scrNTTEFullFloorDelete(_x1,_y1,_x2,_y2) {
    var _fs=scrNTTEFullRectInstances(_x1,_y1,_x2,_y2,Floor)
    for(var _i=0;_i<array_length(_fs);++_i) {
        if (!instance_exists(_fs[_i])) continue
        with (_fs[_i]) {
            for(var _x=bbox_left;_x<(bbox_right-1)+1;_x+=16) for(var _y=bbox_top;_y<(bbox_bottom-1)+1;_y+=16) {
                if (!rectangle_in_rectangle(_x,_y,_x+15,_y+15,_x1,_y1,_x2,_y2)
                    && !collision_rectangle(_x,_y,_x+15,_y+15,Floor,false,true)) {
                    var _shake=UberCont.opt_shake,_freeze=UberCont.opt_freeze,_snd=UberCont.opt_sndvol
                    UberCont.opt_shake=0; UberCont.opt_freeze=0; UberCont.opt_sndvol=0
                    var _explo=instance_create(_x,_y,FloorExplo),_new=scrNTTEFullInstances(all)
                    for(var _j=0;_j<array_length(_new);++_j) if (_new[_j].id>_explo.id) instance_destroy(_new[_j],false)
                    UberCont.opt_shake=_shake; UberCont.opt_freeze=_freeze; UberCont.opt_sndvol=_snd
                }
            }
            var _details=scrNTTEFullRectInstances(bbox_left,bbox_top,(bbox_right-1)+1,(bbox_bottom-1)+1,Detail,true)
            for(var _j=0;_j<array_length(_details);++_j) instance_destroy(_details[_j])
            var _snow=scrNTTEFullRectInstances(bbox_left,bbox_top,(bbox_right-1),(bbox_bottom-1),SnowFloor)
            for(var _j=0;_j<array_length(_snow);++_j) {
                var _v=_snow[_j]
                if (point_in_rectangle((_v.bbox_left+(_v.bbox_right-1)+1)/2,(_v.bbox_top+(_v.bbox_bottom-1)+1)/2,bbox_left,bbox_top,(bbox_right-1)+1,(bbox_bottom-1)+1)) instance_destroy(_v)
            }
            instance_destroy()
        }
    }
}

function scrNTTEFullFloorSet(_x,_y,_state) {
    scrNTTEFullFloorInit()
    var _inst=noone
    if (_state) {
        var _obj=_state>=2 ? FloorExplo:Floor,_mask=object_get_mask(_obj)
        var _w=sprite_get_bbox_right(_mask)+1-sprite_get_bbox_left(_mask),_h=sprite_get_bbox_bottom(_mask)+1-sprite_get_bbox_top(_mask)
        var _pos=scrNTTEFullFloorAlign(_x,_y,_w,_h,""); _x=_pos[0]; _y=_pos[1]
        if (!instance_exists(FloorMaker)) {
            if (_obj==FloorExplo) with (FloorExplo) { if (x==_x && y==_y) instance_destroy(id,false) }
            else scrNTTEFullFloorDelete(_x,_y,_x+_w-1,_y+_h-1)
        }
        var _maker=noone,_area=GameCont.area
        if (!is_undefined(global.ntte_full_floor_style)) {
            GameCont.area=area_campfire; _maker=instance_create(_x,_y,FloorMaker)
            with (Floor) if (id>_maker.id) instance_destroy(id,false)
            _maker.styleb=global.ntte_full_floor_style; GameCont.area=_area
        }
        if (!is_undefined(global.ntte_full_floor_area)) GameCont.area=global.ntte_full_floor_area
        _inst=instance_create(_x,_y,_obj)
        if (instance_exists(_maker)) instance_destroy(_maker)
        if (!instance_exists(FloorMaker) && instance_exists(_inst)) with (_inst) {
            scrNTTEFullWallDelete(bbox_left,bbox_top,(bbox_right-1),(bbox_bottom-1))
            if (_obj!=FloorExplo && random(6)<1) instance_create(random_range(bbox_left,(bbox_right-1)+1),random_range(bbox_top,(bbox_bottom-1)+1),Detail)
        }
        GameCont.area=_area
        if (instance_exists(Wall) && instance_exists(_inst)) with (_inst) {
            scrNTTEFullFloorWalls(id); scrNTTEFullWallUpdate(bbox_left-16,bbox_top-16,(bbox_right-1)+16,(bbox_bottom-1)+16)
        }
    }
    else {
        var _fs=scrNTTEFullRectInstances(_x,_y,_x,_y,Floor)
        for(var _i=0;_i<array_length(_fs);++_i) if (instance_exists(_fs[_i])) {
            var _f=_fs[_i],_x1=_f.bbox_left-16,_y1=_f.bbox_top-16,_x2=(_f.bbox_right-1)+16,_y2=(_f.bbox_bottom-1)+16
            var _snow=scrNTTEFullRectInstances(_f.bbox_left,_f.bbox_top,(_f.bbox_right-1),(_f.bbox_bottom-1),SnowFloor)
            for(var _j=0;_j<array_length(_snow);++_j) {
                var _s=_snow[_j]
                if (point_in_rectangle((_s.bbox_left+(_s.bbox_right-1)+1)/2,(_s.bbox_top+(_s.bbox_bottom-1)+1)/2,_f.bbox_left,_f.bbox_top,(_f.bbox_right-1)+1,(_f.bbox_bottom-1)+1)) instance_destroy(_s)
            }
            instance_destroy(_f)
            if (instance_exists(Wall)) {
                scrNTTEFullWallDelete(_x1,_y1,_x2,_y2)
                for(var _fx=_x1;_fx<_x2+1;_fx+=16) for(var _fy=_y1;_fy<_y2+1;_fy+=16) {
                    if (!position_meeting(_fx,_fy,Floor) && collision_rectangle(_fx-16,_fy-16,_fx+31,_fy+31,Floor,false,false)) instance_create(_fx,_fy,Wall)
                }
                scrNTTEFullWallUpdate(_x1-16,_y1-16,_x2+16,_y2+16)
            }
        }
    }
    return _inst
}

function scrNTTEFullFloorFill(_x,_y,_w,_h=undefined,_type="") {
    scrNTTEFullFloorInit()
    if (is_undefined(_h)) _h=_w
    _w*=32; _h*=32; _x-=_w/2; _y-=_h/2
    var _pos=scrNTTEFullFloorAlign(_x,_y,_w,_h,_type); _x=_pos[0]; _y=_pos[1]
    var _aw=global.ntte_full_floor_aw,_ah=global.ntte_full_floor_ah,_ax=global.ntte_full_floor_ax,_ay=global.ntte_full_floor_ay,_out=[]
    scrNTTEFullFloorSetAlign(32,32,_x,_y)
    for(var _oy=0;_oy<_h;_oy+=32) for(var _ox=0;_ox<_w;_ox+=32) {
        var _make=true
        if (_type=="round") _make=(_ox!=0 && _ox!=_w-32) || (_oy!=0 && _oy!=_h-32)
        else if (_type=="ring") _make=_ox==0 || _oy==0 || _ox==_w-32 || _oy==_h-32
        if (_make) array_push(_out,scrNTTEFullFloorSet(_x+_ox,_y+_oy,true))
    }
    scrNTTEFullFloorSetAlign(_aw,_ah,_ax,_ay)
    return _out
}

function scrNTTEFullPathCreate(_xs,_ys,_xt,_yt,_walls) {
    var _tile=16,_aw=ceil(abs(_xt-_xs)/16)*16+320,_ah=ceil(abs(_yt-_ys)/16)*16+320
    _aw=max(_aw,_ah); _ah=max(_aw,_ah)
    var _triesmax=4*ceil((_aw+_ah)/16)
    _xs=floor(_xs/16)*16; _ys=floor(_ys/16)*16; _xt=floor(_xt/16)*16; _yt=floor(_yt/16)*16
    var _gw=ceil(_aw/16),_gh=ceil(_ah/16),_gx=round(((_xs+_xt)/2-_aw/2)/16)*16,_gy=round(((_ys+_yt)/2-_ah/2)/16)*16
    var _grid=ds_grid_create(_gw,_gh),_cost=ds_grid_create(_gw,_gh)
    ds_grid_clear(_grid,-1); ds_grid_clear(_cost,0)
    var _ws=scrNTTEFullRectInstances(_gx,_gy,_gx+_aw,_gy+_ah,_walls,true)
    // BEGIN NTTE PATH WALL GRID BOUNDS
    for(var _i=0;_i<array_length(_ws);++_i) with (_ws[_i]) {
        var _wx=(x-_gx)/16,_wy=(y-_gy)/16
        // The source rectangle includes its right/bottom edge. Those origins
        // have cell index equal to grid width/height and cannot be written.
        // Ignore them; clamping would create a different in-grid obstacle.
        if (_wx>=0 && _wy>=0 && _wx<_gw && _wy<_gh && position_meeting(x,y,id))
            _grid[# _wx,_wy]=-2
    }
    // END NTTE PATH WALL GRID BOUNDS
    var _x1=(_xt-_gx)/16,_y1=(_yt-_gy)/16,_x2=(_xs-_gx)/16,_y2=(_ys-_gy)/16
    var _list=[[_x1,_y1,0]],_tries=_triesmax
    while (_tries-->0) {
        var _s=_list[0],_sx=_s[0],_sy=_s[1],_sp=_s[2]
        if (_sp>=infinity) break
        // GML arrays use copy-on-write. Updating a copied _s would never retire
        // the source frontier entry; explicitly write the array reference.
        _list[0][2]=infinity
        var _sofar=_cost[# _sx,_sy]
        for(var _a=0;_a<2*pi;_a+=pi/2) {
            var _nx=_sx+round(cos(_a)),_ny=_sy-round(sin(_a)),_nc=_sofar+1
            if (_nx>=0 && _ny>=0 && _nx<_gw && _ny<_gh && _grid[# _nx,_ny]==-1) {
                _cost[# _nx,_ny]=_nc; _grid[# _nx,_ny]=point_direction(_nx,_ny,_sx,_sy)
                array_push(_list,[_nx,_ny,point_distance(_x2,_y2,_nx,_ny)+abs(_x2-_nx)+abs(_y2-_ny)+_nc])
            }
            if (_nx==_x2 && _ny==_y2) { _tries=0; break }
        }
        array_sort(_list,function(_a,_b) { return _a[2]==_b[2] ? 0:(_a[2]<_b[2] ? -1:1) })
    }
    var _x=_xs,_y=_ys,_path=[[_x+8,_y+8]]
    _tries=_triesmax
    while (_tries-->0) {
        var _d=_grid[# (_x-_gx)/16,(_y-_gy)/16]
        if (_d>=0) {
            _x+=round(lengthdir_x(16,_d)); _y+=round(lengthdir_y(16,_d)); array_push(_path,[_x+8,_y+8])
        }
        else { _path=[]; break }
        if (_x==_xt && _y==_yt) break
    }
    if (_tries<=0) _path=[]
    ds_grid_destroy(_grid); ds_grid_destroy(_cost)
    return _path
}

function scrNTTEFullPathReaches(_path,_xt,_yt,_walls) {
    if (!is_array(_walls)) _walls=[_walls]
    var _n=array_length(_path)
    if (_n<=0) return false
    var _last=_path[_n-1]
    for(var _i=0;_i<array_length(_walls);++_i) if (collision_line(_last[0],_last[1],_xt,_yt,_walls[_i],false,false)) return false
    return true
}

function scrNTTEFullPathShrink(_path,_walls,_skipmax) {
    if (!is_array(_walls)) _walls=[_walls]
    var _out=[],_link=0,_n=array_length(_path)
    for(var _i=0;_i<_n;++_i) {
        var _save=_i<=0 || _i>=_n-1 || _i-_link>=_skipmax
        if (!_save) for(var _j=0;_j<array_length(_walls);++_j) {
            if (collision_line(_path[_i+1][0],_path[_i+1][1],_path[_link][0],_path[_link][1],_walls[_j],false,false)) { _save=true; break }
        }
        if (_save) { array_push(_out,_path[_i]); _link=_i }
    }
    return _out
}

function scrNTTEFullPathDirection(_path,_x,_y,_walls) {
    if (!is_array(_walls)) _walls=[_walls]
    var _dis=infinity,_near=-1,_n=array_length(_path)
    for(var _i=0;_i<_n;++_i) {
        var _px=_path[_i][0],_py=_path[_i][1],_d=point_distance(_x,_y,_px,_py)
        if (_d<_dis) {
            var _blocked=false
            for(var _j=0;_j<array_length(_walls);++_j) if (collision_line(_x,_y,_px,_py,_walls[_j],false,false)) { _blocked=true; break }
            if (!_blocked) { _dis=_d; _near=_i }
        }
    }
    if (_near<0) return undefined
    var _next=min(_near+1,_n-1),_nx=_path[_next][0],_ny=_path[_next][1]
    for(var _j=0;_j<array_length(_walls);++_j) if (collision_line(x,y,_nx,_ny,_walls[_j],false,false)) {
        _nx=_path[_near][0]; _ny=_path[_near][1]; break
    }
    return point_direction(x,y,_nx,_ny)
}

function scrNTTEFullFloorRoomStart(_sx,_sy,_sdis,_floor=Floor,_normal=true) {
    var _fs=scrNTTEFullInstances(_floor,_normal)
    _fs=array_shuffle(_fs)
    for(var _i=0;_i<array_length(_fs);++_i) {
        var _v=_fs[_i],_x=(_v.bbox_left+(_v.bbox_right-1)+1)/2,_y=(_v.bbox_top+(_v.bbox_bottom-1)+1)/2
        if (point_distance(_sx,_sy,_x,_y)<_sdis) continue
        var _reached=false
        if (position_meeting(_sx,_sy,Floor) && !position_meeting(_sx,_sy,Wall) && !position_meeting(_sx,_sy,InvisiWall)) {
            var _walls=[Wall,InvisiWall]
            for(var _fx=_v.bbox_left;_fx<(_v.bbox_right-1)+1;_fx+=16) {
                for(var _fy=_v.bbox_top;_fy<(_v.bbox_bottom-1)+1;_fy+=16) {
                    if (scrNTTEFullPathReaches(scrNTTEFullPathCreate(_fx+8,_fy+8,_sx,_sy,_walls),_sx,_sy,_walls)) { _reached=true; break }
                }
                if (_reached) break
            }
        }
        else _reached=true
        if (_reached) return {x:_x,y:_y,direction:point_direction(_sx,_sy,_x,_y),id:_v}
    }
    return noone
}

function scrNTTEFullFloorRoomCreate(_x,_y,_w,_h,_type,_dir_start,_dir_off,_floor_dis) {
    var _move=true,_distance=16,_ow=_w*16,_oh=_h*16,_sx=_x,_sy=_y
    if (!is_array(_dir_off)) _dir_off=[_dir_off]
    while (array_length(_dir_off)<2) array_push(_dir_off,0)
    while (_move) {
        var _x1=_x-_ow,_y1=_y-_oh,_x2=_x+_ow,_y2=_y+_oh
        var _fs=scrNTTEFullRectInstances(_x1-_floor_dis,_y1-_floor_dis,_x2+_floor_dis-1,_y2+_floor_dis-1,Floor,false,true)
        if (_type=="round" && _floor_dis<=0) {
            for(var _i=array_length(_fs)-1;_i>=0;--_i) {
                var _f=_fs[_i]
                if (((_f.bbox_right-1)<_x1+32 || _f.bbox_left>=_x2-32) && ((_f.bbox_bottom-1)<_y1+32 || _f.bbox_top>=_y2-32)) array_delete(_fs,_i,1)
            }
        }
        _move=false
        if (array_length(_fs)) {
            if (_floor_dis<=0) _move=true
            else for(var _i=0;_i<array_length(_fs);++_i) {
                var _f=_fs[_i],_fx=clamp(_x,_f.bbox_left,(_f.bbox_right-1)+1),_fy=clamp(_y,_f.bbox_top,(_f.bbox_bottom-1)+1)
                var _fd=_type=="round"
                    ? min(point_distance(_fx,_fy,clamp(_fx,_x1+32,_x2-32),clamp(_fy,_y1,_y2)),point_distance(_fx,_fy,clamp(_fx,_x1,_x2),clamp(_fy,_y1+32,_y2-32)))
                    : point_distance(_fx,_fy,clamp(_fx,_x1,_x2),clamp(_fy,_y1,_y2))
                if (_fd<_floor_dis) { _move=true; break }
            }
            if (_move) {
                var _d=round((_dir_start+random_range(_dir_off[0],_dir_off[1])*choose(-1,1))/90)*90
                _x+=round(lengthdir_x(_distance,_d)); _y+=round(lengthdir_y(_distance,_d))
            }
        }
    }
    var _before=array_length(scrNTTEFullInstances(Floor,true)),_floors=scrNTTEFullFloorFill(_x,_y,_w,_h,_type),_after=array_length(scrNTTEFullInstances(Floor,true))
    var _x1=_x,_y1=_y,_x2=_x,_y2=_y
    for(var _i=0;_i<array_length(_floors);++_i) {
        var _f=_floors[_i]
        if (!instance_exists(_f)) continue
        var _fx1=_f.bbox_left,_fy1=_f.bbox_top,_fx2=(_f.bbox_right-1),_fy2=(_f.bbox_bottom-1)
        if (_i==0) { _x1=_fx1; _y1=_fy1; _x2=_fx2+1; _y2=_fy2+1 }
        _x1=min(_x1,_fx1); _y1=min(_y1,_fy1); _x2=max(_x2,_fx2+1); _y2=max(_y2,_fy2+1)
        if (_floor_dis<=0 && _after==_before+array_length(_floors)) {
            var _walls=scrNTTEFullRectInstances(_fx1-1,_fy1,_fx2+1,_fy2,Wall)
            var _vertical=scrNTTEFullRectInstances(_fx1,_fy1-1,_fx2,_fy2+1,Wall)
            _walls=array_concat(_walls,_vertical)
            for(var _j=0;_j<array_length(_walls);++_j) if (instance_exists(_walls[_j])) with (_walls[_j]) {
                if (place_meeting(x,y,Floor)) {
                    var _decor=scrNTTEFullRectInstances(bbox_left,bbox_top,(bbox_right-1),(bbox_bottom-1),[Bones,TopPot])
                    for(var _k=0;_k<array_length(_decor);++_k) with (_decor[_k]) if (place_meeting(x,y,other.id)) instance_destroy(id,false)
                    instance_destroy(id,false)
                }
            }
        }
    }
    return {floors:_floors,x:(_x1+_x2)/2,y:(_y1+_y2)/2,x1:_x1,y1:_y1,x2:_x2,y2:_y2,xstart:_sx,ystart:_sy}
}

function scrNTTEFullFloorRoom(_sx,_sy,_sdis,_floor,_w,_h,_type,_dir_off,_floor_dis,_normal=true) {
    var _start=scrNTTEFullFloorRoomStart(_sx,_sy,_sdis,_floor,_normal)
    if (is_struct(_start)) return scrNTTEFullFloorRoomCreate(_start.x,_start.y,_w,_h,_type,_start.direction,_dir_off,_floor_dis)
    return noone
}

function scrNTTEFullFloorSmoke() {
    scrNTTEFullFloorInit()
    var _oldstyle=global.ntte_full_floor_style,_oldarea=global.ntte_full_floor_area
    var _aw=global.ntte_full_floor_aw,_ah=global.ntte_full_floor_ah,_ax=global.ntte_full_floor_ax,_ay=global.ntte_full_floor_ay
    var _snapshot=scrNTTEFullInstances(all)
    scrNTTEFullFloorResetStyle(); scrNTTEFullFloorSetAlign(32,32,20000,20000)
    assert(scrNTTEFullFloorAlignRound(16,32,0)==32 && scrNTTEFullFloorAlignRound(16,32,-1)==0,"Floor alignment half/bias diverged")
    var _full=scrNTTEFullFloorFill(20000,20000,3)
    assert(array_length(_full)==9,"Original3x3 floor fill changed")
    var _round=scrNTTEFullFloorFill(20320,20000,4,4,"round")
    assert(array_length(_round)==12,"Rounded4x4 floor fill retained corners")
    var _ring=scrNTTEFullFloorFill(20640,20000,4,4,"ring")
    assert(array_length(_ring)==12,"Ring4x4 floor fill retained inner floors")
    assert(global.ntte_full_floor_aw==32 && global.ntte_full_floor_ax==20000,"Floor fill leaked its local alignment")
    scrNTTEFullFloorSetStyle(true)
    var _styled=scrNTTEFullFloorSet(20960,20000,true)
    assert(instance_exists(_styled) && _styled.styleb,"FloorSet did not preserve requested temporary FloorMaker style")
    scrNTTEFullFloorResetStyle()
    var _path=scrNTTEFullPathCreate(20008,20008,20024,20008,[Wall,InvisiWall])
    assert(scrNTTEFullPathReaches(_path,20024,20008,[Wall,InvisiWall]),"Original path frontier failed adjacent open tiles")
    var _room=scrNTTEFullFloorRoomCreate(20000,20000,2,2,"",0,0,0)
    scrNTTESmokeLog("FLOOR ROOM DEBUG "+json_stringify(_room))
    for(var _di=0;_di<array_length(_room.floors);++_di) {
        var _df=_room.floors[_di]
        scrNTTESmokeLog("FLOOR ROOM TILE "+string(_df)+" EXISTS "+string(instance_exists(_df)))
        if (instance_exists(_df)) scrNTTESmokeLog("FLOOR ROOM BBOX "+string([_df.x,_df.y,_df.bbox_left,_df.bbox_top,(_df.bbox_right-1),(_df.bbox_bottom-1),_df.mask_index]))
    }
    assert(is_struct(_room) && array_length(_room.floors)==4 && _room.x2-_room.x1==64 && _room.y2-_room.y1==64,"Original floor_room_create dimensions changed")
    assert(_room.xstart==20000 && _room.ystart==20000 && _room.x>20000,"Room search lost original starting point/outward cardinal direction")
    var _fs=scrNTTEFullInstances(all)
    for(var _i=0;_i<array_length(_fs);++_i) if (array_get_index(_snapshot,_fs[_i])<0) instance_destroy(_fs[_i],false)
    scrNTTEFullFloorSetStyle(_oldstyle,_oldarea); scrNTTEFullFloorSetAlign(_aw,_ah,_ax,_ay)
    scrNTTESmokeLog("FULL WORLD FLOOR ALIGN/RECT/ROUND/RING/STYLE RESTORE + ORIGINAL PATH/ROOM DIMENSIONS OK")
}

// ntte.mapdata_get4479..4572 and six area_mapdata callbacks. Source Red
// evaluates a recursive fallback map once, then reconnects completed warps.
// Two explicit passes preserve that ordering without recursive Draw effects.
function scrNTTEFullRoadmapStep(_waypoint,_last,_warps) {
    var _area=_waypoint[0],_sub=_waypoint[1],_loops=_waypoint[2],
        _data={x:0,y:0,area:_area,subarea:_sub,loops:_loops,showdot:false,showline:true,warp:undefined}
    switch(scrNTTEFullAreaKey(_area)) {
        case "coast":_data.x=18.15+9*(_sub-1);_data.y=-9;_data.showdot=_sub==1;break;
        case "oasis":_data.x=44;_data.y=-9;_data.showdot=_sub==1;break;
        case "pizza":case "lair":_data.x=_last.area==206?27:_last.x;_data.y=9;break;
        case "trench":_data.x=44+9.9*(_sub-1);_data.y=9;_data.showdot=_sub==1;break;
        case "red":
            _data.x=_last.x;_data.y=max(0,_last.y)+9;_data.showdot=_sub==1
            for(var _i=0;_i<array_length(_warps);++_i) {
                var _warp=_warps[_i],_entry=_warp.last,_next=_warp.next
                if(_warp.subarea==_sub && _warp.loops==_loops && _entry.x==_last.x && _entry.y==_last.y
                    && _entry.area==_last.area && _entry.subarea==_last.subarea && _next.area!=206) {
                    _data.x=_next.x;_data.y=_next.y;_data.showdot=false;_data.showline=false;_data.warp=_warp
                    switch(_next.area) {
                        case area_oasis:_data.x=0;break;
                        case area_pizza_sewers:_data.x=27;break;
                        case area_mansion:_data.x=36;break;
                        case area_cursed_caves:_data.x=54;break;
                        case area_jungle:_data.x=72;break;
                    }
                    break
                }
            }
            break;
        default:
            if(_area<100) {
                var _num=3*ceil((floor(_area)-1)/2)+floor((floor(_area)-1)/2)+_sub-1+(_area-floor(_area))
                _data.x=9*_num
            }
            else {_data.x=_last.x;_data.y=9}
            _data.showdot=_sub==1
            break;
    }
    // Looping returns from the end to the beginning; it is not a traversed
    // segment across the whole map. Drawing that return in the new loop's
    // color painted every unfinished stage yellow on the very first stage.
    if(_last.area!=-1 && _last.loops!=_loops) _data.showline=false
    return _data
}
function scrNTTEFullRoadmapData(_waypoints=undefined) {
    if(is_undefined(_waypoints)) {
        _waypoints=[]
        for(var _i=0;_i<GameCont.waypoints;++_i) array_push(_waypoints,[GameCont.waypnt[_i],GameCont.waysub[_i],GameCont.waylps[_i]])
    }
    var _origin={x:0,y:0,area:-1,subarea:0,loops:0,showdot:false,showline:true,warp:undefined},
        _fallback=[_origin],_warps=[]
    for(var _i=0;_i<array_length(_waypoints);++_i)
        array_push(_fallback,scrNTTEFullRoadmapStep(_waypoints[_i],_fallback[_i],[]))
    // Source scans backward: later matching routes win when the same Red
    // entrance/subarea/loop is present multiple times in the history.
    for(var _i=array_length(_fallback)-2;_i>=1;--_i) {
        var _data=_fallback[_i]
        if(_data.area==206) array_push(_warps,{subarea:_data.subarea,loops:_data.loops,last:_fallback[_i-1],next:_fallback[_i+1]})
    }
    var _map=[_origin]
    for(var _i=0;_i<array_length(_waypoints);++_i)
        array_push(_map,scrNTTEFullRoadmapStep(_waypoints[_i],_map[_i],_warps))
    return _map
}
function scrNTTEFullRoadmapWarpDraw(_data,_origin_x,_origin_y,_color,_alpha) {
    var _warp=_data.warp
    if(!is_struct(_warp)) return;
    var _last=_warp.last,_next=_warp.next,
        _ax1=floor(_origin_x+_last.x),_ay1=floor(_origin_y+_last.y-!_last.showdot),
        _ax2=floor(_origin_x+_last.x),_ay2=floor(_origin_y+max(0,_last.y)+9),
        _bx1=floor(_origin_x+_data.x),_by1=floor(_origin_y+_next.y),
        _bx2=floor(_origin_x+_data.x),_by2=floor(_origin_y+min(0,_next.y)-9),
        _frame=current_frame*0.4,_sprite=scrNTTERefSprite("RedDot"),_old=draw_get_color(),_old_alpha=draw_get_alpha()
    draw_set_alpha(_alpha);draw_set_color(c_black)
    draw_line_width(_ax1+1,_ay1+1,_ax2+1,_ay2+1,1)
    draw_line_width(_bx1+1,_by1+1,_bx2+1,_by2+1,1)
    draw_set_color(_color)
    draw_line_width(_ax1,_ay1,_ax2,_ay2,1)
    draw_sprite_ext(_sprite,_frame,_ax2,_ay2,1,1,0,_color,_alpha)
    draw_line_width(_bx1,_by1,_bx2,_by2,1)
    draw_sprite_ext(_sprite,_frame,_bx2,_by2,1,1,0,_color,_alpha)
    draw_set_color(_old);draw_set_alpha(_old_alpha)
}
// Uses the actual native roadmap's supplied origin, so loading, pause and
// GameOver keep their own placement and animation instead of guessing a view.
function scrNTTEFullRoadmapDraw(_origin_x,_origin_y,_pos) {
    var _map=scrNTTEFullRoadmapData(),_count=clamp(floor(_pos),0,array_length(_map)-1),
        _old=draw_get_color(),_alpha=draw_get_alpha()
    for(var _i=1;_i<=_count;++_i) {
        var _last=_map[_i-1],_data=_map[_i],_x=_origin_x+_data.x,_y=_origin_y+_data.y,
            _px=_origin_x+_last.x,_py=_origin_y+_last.y
        if(_data.showdot) draw_sprite_ext(sprMapDotOut,0,_x,_y+1,1,1,0,c_black,1)
        if(_data.showline) {
            draw_line_pixelated(_px+1,_py+1,_x+1,_y+1,c_black,1)
            draw_line_pixelated(_px+2,_py,_x+1,_y,c_black,1)
            draw_line_pixelated(_px+2,_py+1,_x+1,_y+1,c_black,1)
        }
    }
    for(var _i=1;_i<=_count;++_i) {
        var _last=_map[_i-1],_data=_map[_i],_x=_origin_x+_data.x,_y=_origin_y+_data.y,
            _px=_origin_x+_last.x,_py=_origin_y+_last.y,_color=make_color_hsv((_data.loops*39)%255,200,200)
        if(_data.showdot) draw_sprite_ext(_data.area>=100?sprMapDotOut:sprMapDot,0,_x,_y+1,1,1,0,_color,1)
        if(_data.showline) draw_line_pixelated(_px+1,_py,_x+1,_y,_color,1)
        scrNTTEFullRoadmapWarpDraw(_data,_origin_x,_origin_y,_color,_alpha)
    }
    draw_set_color(_old)
    return [_origin_x+_map[_count].x,_origin_y+_map[_count].y]
}

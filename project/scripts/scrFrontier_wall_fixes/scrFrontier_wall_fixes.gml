// NTTE/NTUF mutable terrain colours belong to the generated piece, not a
// current-area lookup. This also keeps appended area-orb chunks local.
function scrFRWallBackgroundColor() {
    var _background=__background_get_colour_element();
    return layer_background_get_blend(_background[0]);
}
function scrFRWallFillColor(_wall) {
    if(variable_instance_exists(_wall,"ntte_fill_color")) {
        // Native border/recolour logic changes a particular wall's area.
        // Invalidate that wall's snapshot, even if it later returns to the
        // original biome. Global context changes alone never recolour it.
        var _source_area=variable_instance_exists(_wall,"ntte_fill_color_area")
            ?variable_instance_get(_wall,"ntte_fill_color_area"):_wall.area;
        if(_source_area!=_wall.area) {
            _wall.ntte_fill_color=scrAreaGetBackroundColor(_wall.area,false);
            _wall.ntte_fill_color_area=_wall.area;
        }
        return _wall.ntte_fill_color;
    }
    // Compatibility for live/continued instances created before the field
    // existed. A mixed-area wall never inherits another area's weather tint.
    return _wall.area==GameCont.area?scrFRWallBackgroundColor():scrAreaGetBackroundColor(_wall.area,false);
}
function scrFRWallCopyFillColor(_wall,_state) {
    // Existing native callers still supply {area,blend,alpha}. A colour is
    // optional, and an explicit snapshot belongs only to its source biome.
    var _color=_state[$ "color"]??undefined,_source_area=_state[$ "color_area"]??_state.area;
    if(is_undefined(_color) || _source_area!=_state.area)
        _color=scrAreaGetBackroundColor(_state.area,false);
    _wall.ntte_fill_color=_color;_wall.ntte_fill_color_area=_state.area;
}

function scrFRWallPrepareInRoomMerge(_old) {
    if(!instance_exists(NTTESolidWall)) return _old;
    // Compact collision is a representation of OLD 16px cells. Source telib
    // deletes overlapping cells; deleting one 256px representation instead
    // erased remote collision and let a local orb repaint a whole block.
    // Sync generators defer new fill, so every packed instance here is old.
    var _geometry=scrNTTEFullInstances([Floor,Wall,InvisiWall,TopSmall,TopPot,Bones]);
    for(var _i=0;_i<array_length(_geometry);++_i) {
        var _v=_geometry[_i];
        if(!instance_exists(_v) || _v.object_index==NTTESolidWall || array_get_index(_old,_v)>=0) continue;
        scrNTTESolidWallMaterialize(_v.bbox_left,_v.bbox_top,_v.bbox_right-1,_v.bbox_bottom-1);
    }
    var _pieces=scrNTTEFullInstances(NTTESolidWall);
    for(var _i=0;_i<array_length(_pieces);++_i)
        if(array_get_index(_old,_pieces[_i])<0) array_push(_old,_pieces[_i]);
    return _old;
}

function scrFRWallTopConstrainSpawn(_wrapper) {
    if(!instance_exists(_wrapper) || !instance_exists(_wrapper.target)
        || _wrapper.type!=enemy || _wrapper.spawn_dis<=0
        || _wrapper.target.object_index==JungleFly) return false;
    var _distance=infinity;
    with(_wrapper) _distance=distance_to_object(Floor);
    if(_distance<=64) return false;
    // Only the explicitly elevated ordinary enemy is considered. A native
    // grounded enemy, wall-resident prop or puzzle actor is never relocated.
    // Use a real authored wall whose floor-facing edge can start TopGlobalStep's
    // existing fall/jump; a deep compact rectangle is not a spawn candidate.
    var _walls=scrNTTEFullInstances(Wall),_chosen=undefined,_best=infinity;
    for(var _i=0;_i<array_length(_walls);++_i) {
        var _wall=_walls[_i];
        if(_wall.object_index==NTTESolidWall || instance_is(_wall,NTTEFullWallFake)
            || !sprite_exists(_wall.topspr)) continue;
        // A half-sized wrapper's shadow mask need not reach the floor from
        // the tile centre (its authored mask_y can even be negative). Inspect
        // the actual lip/corners as well, using the unchanged source contact
        // predicate rather than assuming a fixed eight-pixel shadow offset.
        var _xs=[_wall.bbox_left,(_wall.bbox_left+_wall.bbox_right)/2,_wall.bbox_right],
            _ys=[_wall.bbox_top,(_wall.bbox_top+_wall.bbox_bottom)/2,_wall.bbox_bottom];
        for(var _iy=0;_iy<3;++_iy) for(var _ix=0;_ix<3;++_ix) {
            var _cx=_xs[_ix],_cy=_ys[_iy],_floor_contact=false;
            with(_wrapper) _floor_contact=place_meeting(_cx+mask_x,_cy+mask_y,Floor);
            if(!_floor_contact) continue;
            var _d=point_distance(_wrapper.x,_wrapper.y,_cx,_cy);
            if(_d<_best) {_chosen=[_cx,_cy];_best=_d;}
        }
    }
    if(!is_array(_chosen)) return false;
    _wrapper.x=_chosen[0];_wrapper.y=_chosen[1];
    _wrapper.fr_wall_spawn_clamped=true;
    return true;
}

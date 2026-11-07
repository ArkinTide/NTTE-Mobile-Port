// JungleFly's ordinary native flight remains unchanged. An explicitly
// elevated NTTE wall spawn must finish its wall-to-floor descent first;
// otherwise its native sideways movement can carry a masked anchor away.
function scrFRFlyWallSpawn(_wrapper) {
    if(!instance_exists(_wrapper) || !instance_exists(_wrapper.target)
        || _wrapper.target.object_index!=JungleFly || _wrapper.type!=enemy
        || _wrapper.spawn_dis<=0) return false;
    var _chosen=undefined,_best=infinity,_fly=_wrapper.target;
    // Select a real landing point using the fly's still-restored native mask.
    // A shadow touching a floor at the wall lip is insufficient for this large
    // body: landing there could invoke unstick's destructive wall clearing.
    with(Floor) {
        var _cx=(bbox_left+bbox_right)/2,_cy=(bbox_top+bbox_bottom)/2,_free=false;
        with(_fly) _free=place_meeting(_cx,_cy,Floor)
            && !place_meeting(_cx,_cy,Wall) && !place_meeting(_cx,_cy,InvisiWall);
        if(!_free) continue;
        var _d=point_distance(_wrapper.x,_wrapper.y,_cx,_cy);
        if(_d<_best) {_best=_d;_chosen=[_cx,_cy];}
    }
    if(!is_array(_chosen)) return false;
    _wrapper.x=round(_chosen[0]);_wrapper.y=round(_chosen[1]);
    _wrapper.jump_x=_wrapper.x;_wrapper.jump_y=_wrapper.y;
    _wrapper.speed=0;_wrapper.canmove=false;
    _wrapper.zspeed=min(0,_wrapper.zspeed);_wrapper.zfriction=_wrapper.grav;
    _wrapper.fr_fly_wall_descent=true;
    return true;
}

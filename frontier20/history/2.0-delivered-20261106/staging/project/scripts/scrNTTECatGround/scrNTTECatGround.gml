// Only Cat and CatHole call these ground-placement helpers. No enemy is
// damaged, deleted, or classified by its wall position.
function scrNTTECatGroundClear(_x,_y) {
    if(place_meeting(_x,_y,Wall) || place_meeting(_x,_y,InvisiWall)) return false;
    var _l=_x+bbox_left-x,_r=_x+bbox_right-x,
        _t=_y+bbox_top-y,_b=_y+bbox_bottom-y;
    return position_meeting(_x,_y,Floor)
        && position_meeting(_l,_t,Floor) && position_meeting(_r,_t,Floor)
        && position_meeting(_l,_b,Floor) && position_meeting(_r,_b,Floor);
}
function scrNTTECatGroundPlace(_x,_y) {
    if(scrNTTECatGroundClear(_x,_y)) {x=_x;y=_y;return true;}
    // Called only at generation, reservation, or emergence. Search real
    // floor interiors instead of pushing through a wall or making new terrain.
    var _l=bbox_left-x,_r=bbox_right-x,_t=bbox_top-y,_b=bbox_bottom-y,
        _best=infinity,_bestx=x,_besty=y,_found=false;
    with(Floor) {
        if(bbox_right-bbox_left<_r-_l || bbox_bottom-bbox_top<_b-_t) continue;
        var _cx=clamp(_x,bbox_left-_l,bbox_right-_r),
            _cy=clamp(_y,bbox_top-_t,bbox_bottom-_b),
            _d=sqr(_cx-_x)+sqr(_cy-_y);
        if(_d>=_best) continue;
        with(other) if(scrNTTECatGroundClear(_cx,_cy)) {
            _best=_d;_bestx=_cx;_besty=_cy;_found=true;
        }
    }
    if(_found) {x=_bestx;y=_besty;}
    return _found;
}
function scrNTTECatHoleEnsure() {
    if(!scrNTTECatGroundPlace(x,y)) return false;
    xprevious=x;yprevious=y;xstart=x;ystart=y;
    if(instance_exists(hole)) {hole.x=x;hole.y=y;}
    return true;
}
// Cats are floor walkers. Check their completed engine movement, while
// keeping original prop/enemy perches and hidden manhole travel intact.
function scrNTTECatGroundEndStep() {
    if(lockstep_stop || instance_exists(GenCont) || hp<=0 || !ntte_cat_active
        || instance_exists(ntte_cat_sit)) return;
    if(GameCont.area!=scrNTTEFullAreaId("lair") && GameCont.area!=scrNTTEFullAreaId("pizza")) return;
    if(scrNTTECatGroundClear(x,y)) return;
    if(scrNTTECatGroundClear(xprevious,yprevious)) {x=xprevious;y=yprevious;}
    else if(!scrNTTECatGroundPlace(x,y)) return;
    speed=0;xprevious=x;yprevious=y;
}

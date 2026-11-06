// red.area_make_floor244..305. Local initialization proof is documented in
// the original LQ interpreter audit: new funcscope[3] slots are numeric zero.
function scrNTTEFullRedMakeFloor() {
    var _x=x,_y=y,_out_of_spawn=point_distance(x,y,10000,10000)>48,
        _trn=0 // original freshly allocated local, read before its declaration
    if(styleb!=0) {
        var _xs=xstart,_ys=ystart,_style=styleb
        with(Floor) if(xstart==_xs && ystart==_ys && styleb==_style) instance_destroy()
        styleb=0;instance_create(xstart,ystart,Floor)
    }
    instance_create(_x,_y,Floor)
    if(scrNTTEFullSourceRandom(7)<1) scrNTTEFullFloorFill(_x+16,_y+16,3,3,"round")
    // Literal source branch; initial zero makes it unreachable. Moving the
    // later turn selection here would invent chests and alter RNG history.
    if(_trn==180 && _out_of_spawn) instance_create(_x+16,_y+16,scrNTTEFullSourceChoose([WeaponChest,AmmoChest]))
    if(GenCont.safedist<=0) {
        if(!variable_instance_exists(id,"direction_start")) direction_start=direction
        var _ox=lengthdir_x(32,direction),_oy=lengthdir_y(32,direction)
        if(abs(angle_difference(direction_start,point_direction(xstart,ystart,x+_ox,y+_oy)))>60) {
            x-=_ox;y-=_oy;direction=round(direction_start/90)*90
        }
    }
    _trn=0
    if(scrNTTEFullSourceRandom(7)<3) _trn=scrNTTEFullSourceChoose([90,-90,180])
    direction+=_trn
}
function scrNTTEFullRedBuildNative() {
    // Normal GenCont already owns the original maker and starter tile;
    // synchronous CrystalHeart setup also edits that exact maker's heading.
    if(!instance_exists(FloorMaker)) instance_create(10000,10000,FloorMaker)
    with(FloorMaker) goal=other.goal
    var _tries=400,_last=instance_number(Floor)
    while(instance_exists(FloorMaker) && _tries-->0) {
        with(FloorMaker) {
            xprevious=x;yprevious=y
            if(instance_number(Floor)>goal) {
                if(point_distance(x,y,10016,10016)>48) {
                    instance_create(x,y,Floor);instance_create(x+16,y+16,RadChest)
                }
                instance_destroy()
            }
            else {
                x+=lengthdir_x(32,direction);y+=lengthdir_y(32,direction)
                scrNTTEFullRedMakeFloor()
            }
        }
        if(instance_number(Floor)>_last) {_last=instance_number(Floor);_tries=400}
    }
    if(instance_exists(FloorMaker)) throw "Red source generator did not converge";
}

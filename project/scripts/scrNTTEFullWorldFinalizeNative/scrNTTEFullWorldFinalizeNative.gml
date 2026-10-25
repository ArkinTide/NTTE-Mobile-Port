// ntte.mod2523..2565. Final source collision/placement/order repairs.
function scrNTTEFullWorldFinalizeLevelStart() {
    with(Trap) solid=false
    var _pots=scrNTTEFullInstances(TopPot),_moved=[]
    for(var _i=0;_i<array_length(_pots);++_i) with(_pots[_i]) {
        var _pot=id,_oldX=x,_oldY=y
        while(place_meeting(x,y,Wall)) {
            var _break=true,_walls=scrNTTEFullRectInstances(bbox_left,bbox_top,bbox_right-1,bbox_bottom-1,Wall)
            for(var _j=0;_j<array_length(_walls);++_j) with(_walls[_j]) {
                if(place_meeting(x,y,PortalClear) && place_meeting(x,y,_pot)) {
                    with(_pot) {
                        _break=false
                        while(place_meeting(x,y,Floor) || place_meeting(x,y,other.id)) {
                            x+=lengthdir_x(16,dir);y+=lengthdir_y(16,dir)
                        }
                    }
                }
            }
            if(_break) break
        }
        if(x!=_oldX || y!=_oldY) array_push(_moved,id)
    }
    var _walls=scrNTTEFullInstances(Wall),_changed=[]
    for(var _i=0;_i<array_length(_walls);++_i) if(_walls[_i].depth==0) {
        array_push(_changed,[_walls[_i],_walls[_i].depth]);_walls[_i].depth++
    }
    var _restore=noone
    if(array_length(_changed)) {
        _restore=instance_create(0,0,NTTEFullWorldFinalize)
        _restore.walls=_changed
    }
    scrNTTEFullSpawnVehicleSafety()
    return {moved:_moved,restore:_restore,changed:_changed}
}
// User-requested spawn safety for normal scrapyard and frozen-city cars.
// This runs once in the canonical post-generation tail, after MOD placement.
function scrNTTEFullSpawnVehicleSafety() {
    if(GameCont.area!=area_scrapyards && GameCont.area!=area_city) return;
    with(Car) if(object_index==Car) {
        var _unsafe=false,_left=bbox_left,_right=bbox_right-1,_top=bbox_top,_bottom=bbox_bottom-1
        with(Player) {
            // Include the whole vehicle's collision mask, not only its origin.
            if(point_distance(x,y,clamp(x,_left,_right),clamp(y,_top,_bottom))<=128) _unsafe=true
        }
        // Silent generation cleanup avoids the car's Destroy explosions/fire.
        // CarVenus descendants keep their access/quest behavior.
        if(_unsafe) instance_destroy(id,false)
    }
}
function scrNTTEFullWorldFinalizeCreate() { visible=false;walls=[] }
function scrNTTEFullWorldFinalizeBegin() {
    if(lockstep_stop) return;
    // Original fork/wait0 restores on the next event pass, only while the
    // original Wall is alive and no other system has changed the depth.
    for(var _i=0;_i<array_length(walls);++_i) {
        var _row=walls[_i],_wall=_row[0],_depth=_row[1]
        if(instance_exists(_wall) && _wall.depth==_depth+1) _wall.depth=_depth
    }
    instance_destroy()
}

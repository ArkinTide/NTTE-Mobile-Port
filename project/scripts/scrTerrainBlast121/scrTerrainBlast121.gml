// FloorExplo updates only walls whose origins are within32 pixels. Query that
// neighbourhood instead of entering every wall in the level for every tile.
function scrTerrainBlastRefreshWalls() {
    var _list=ds_list_create();
    try {
        // Native Wall mask encloses its origin. The margin includes its bbox;
        // retain the original exact origin-distance test below.
        collision_rectangle_list(x-64,y-64,x+64,y+64,Wall,false,true,_list,false);
        var _walls=[];
        for(var _i=0;_i<ds_list_size(_list);++_i) array_push(_walls,_list[| _i]);
        // Wall has no subclasses in this project. Native with(Wall) visits
        // newest first; preserve that order for dependent visibility updates.
        array_sort(_walls,function(_a,_b) {return real(_b)-real(_a);});
        for(var _i=0;_i<array_length(_walls);++_i) if(instance_exists(_walls[_i])) with(_walls[_i]) {
            if(point_distance(x,y,other.x,other.y)>32) continue;
            if(position_meeting(x,y,FloorExplo)) {instance_destroy();continue;}
            visible=place_meeting(x,y+16,Floor);
            if(place_free(x-16,y)) l=0;else l=4;
            if(place_free(x+16,y)) w=24-l;else w=20-l;
            if(place_free(x,y-16)) r=0;else r=4;
            if(place_free(x,y+16)) h=24-r;else h=20-r;
        }
    } finally {ds_list_destroy(_list);}
}

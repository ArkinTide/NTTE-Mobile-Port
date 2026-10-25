// Focused real native Wall/path acceptance. Does not execute a world generator.
function scrNTTEFullPathGridBoundsNativeTests() {
    var _old_area=GameCont.area,_old_seed=random_get_seed(),_owned=[],_boundary=[],_blocker=noone
    try {
        GameCont.area=area_desert
        var _xs=192008,_ys=192008,_xt=192248,_yt=192008,
            _aw=560,_ah=560,_gw=35,_gh=35,
            _gx=round(((floor(_xs/16)*16+floor(_xt/16)*16)/2-_aw/2)/16)*16,
            _gy=round(((floor(_ys/16)*16+floor(_yt/16)*16)/2-_ah/2)/16)*16
        var _empty=scrNTTEFullPathCreate(_xs,_ys,_xt,_yt,[])
        assert(array_length(_empty)==16 && scrNTTEFullPathReaches(_empty,_xt,_yt,[]),
            "Open native source path failed expected adjacent16tile straight route")
        // First row exactly reproduces reported [6,35] in a35x35grid. The
        // closed source origin query MUST select all three excluded edges.
        var _positions=[[_gx+6*16,_gy+_ah],[_gx+_aw,_gy+6*16],[_gx+_aw,_gy+_ah],
            [_gx+6*16,_gy+(_gh-1)*16],[_gx+(_gw-1)*16,_gy+6*16],[_gx,_gy]]
        for(var _i=0;_i<array_length(_positions);++_i) {
            var _wall=instance_create(_positions[_i][0],_positions[_i][1],Wall)
            assert(instance_exists(_wall) && position_meeting(_wall.x,_wall.y,_wall),
                "Actual native boundary Wall lacks source origin collision")
            array_push(_owned,_wall);array_push(_boundary,_wall)
        }
        var _selected=scrNTTEFullRectInstances(_gx,_gy,_gx+_aw,_gy+_ah,_boundary,true)
        assert(array_length(_selected)==6 && array_get_index(_selected,_boundary[0])>=0
            && array_get_index(_selected,_boundary[1])>=0 && array_get_index(_selected,_boundary[2])>=0,
            "Boundary fixture did not enter real closed origin query at right/bottom/corner")
        var _edges=scrNTTEFullPathCreate(_xs,_ys,_xt,_yt,_boundary)
        assert(json_stringify(_edges)==json_stringify(_empty),
            "Out-of-grid origins or retained distant legal border walls changed open source path")
        _blocker=instance_create(192112,192000,Wall);array_push(_owned,_blocker)
        var _blocked=array_concat(_boundary,[_blocker]),_detour=scrNTTEFullPathCreate(_xs,_ys,_xt,_yt,_blocked)
        assert(array_length(_detour)>array_length(_empty)
            && scrNTTEFullPathReaches(_detour,_xt,_yt,_blocked),
            "Legal in-grid source wall was discarded instead of preserving native detour")
        for(var _i=0;_i<array_length(_detour);++_i)
            assert(!collision_point(_detour[_i][0],_detour[_i][1],_blocker,false,false),
                "Native path crossed retained legal wall cell")
        var _sealed=array_concat(_boundary,[_blocker]),_around=[[192016,192000],[191984,192000],
            [192000,191984],[192000,192016]]
        for(var _i=0;_i<array_length(_around);++_i) {
            var _wall=instance_create(_around[_i][0],_around[_i][1],Wall)
            array_push(_owned,_wall);array_push(_sealed,_wall)
        }
        assert(array_length(scrNTTEFullPathCreate(_xs,_ys,_xt,_yt,_sealed))==0,
            "Fully enclosed source start incorrectly produced a route through legal walls")
        scrNTTESmokeLog("FULL PATH GRID BOUNDS: actual35x35 native closed-query edges[6,35]/[35,6]/[35,35], retained legal borders, exact open path, in-grid obstacle detour and enclosed rejection OK @"+string(30/timescale))
    }
    finally {
        for(var _i=0;_i<array_length(_owned);++_i) if(instance_exists(_owned[_i])) instance_destroy(_owned[_i],false)
        GameCont.area=_old_area;random_set_seed(_old_seed)
    }
}

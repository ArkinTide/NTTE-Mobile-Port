// Desktop-only observer installed after the original path_create wall pass.
// Capture the actual allocated grid before authored path search modifies it.
function scrFRPathGridTestObserve(_grid,_x,_y,_tile) {
    var _w=ds_grid_width(_grid),_h=ds_grid_height(_grid),_walls=[];
    for(var _gy=0;_gy<_h;++_gy) for(var _gx=0;_gx<_w;++_gx)
        if(_grid[# _gx,_gy]==-2) array_push(_walls,[_gx,_gy]);
    global.fr_path_grid_observed={x:_x,y:_y,w:_w,h:_h,tile:_tile,walls:_walls};
    global.fr_path_grid_observation_count++;
}
function scrFRPathGridTests() {
    var _before=scrNTTEFullInstances(all),_seed=scrFRSourceRandomGetSeed(),
        _old_observe=variable_global_exists("fr_path_grid_observe")?global.fr_path_grid_observe:false,
        _old_result=variable_global_exists("fr_path_grid_observed")?global.fr_path_grid_observed:undefined,
        _old_count=variable_global_exists("fr_path_grid_observation_count")?global.fr_path_grid_observation_count:0;
    try {
        // Original path_create computes a 28x28,16px grid at59840,59776
        // for this128px journey. Include real collision masks on both exact
        // upper edges, plus lower/interior/last-cell and outside controls.
        var _origins=[[59840,59776],[60064,60000],[60272,60208],
            [60288,60000],[60064,60224],[59824,60000],[60064,59760]],_walls=[];
        for(var _i=0;_i<array_length(_origins);++_i) {
            var _point=_origins[_i],_wall=instance_create(_point[0],_point[1],FRMarker);
            _wall.sprite_index=mskFloor;_wall.mask_index=mskFloor;
            array_push(_walls,real(_wall));
            assert(position_meeting(_point[0],_point[1],_wall),"Path boundary fixture lacks its actual collision mask");
        }
        var _raw=scrFRModCall("mod","libGeneral","instance_rectangle",59840,59776,60288,60224,_walls);
        assert(array_length(_raw)==5 && array_contains(_raw,_walls[3]) && array_contains(_raw,_walls[4])
            && !array_contains(_raw,_walls[5]) && !array_contains(_raw,_walls[6]),
            "Original inclusive wall query no longer demonstrates the outer-grid write hazard");
        global.fr_path_grid_observe=true;global.fr_path_grid_observed=undefined;global.fr_path_grid_observation_count=0;
        var _path=scrFRModCall("mod","libGeneral","path_create",60000,60000,60128,60000,_walls),
            _grid=global.fr_path_grid_observed;
        assert(global.fr_path_grid_observation_count==1 && is_struct(_grid)
            && _grid.x==59840 && _grid.y==59776 && _grid.w==28 && _grid.h==28 && _grid.tile==16,
            "Actual authored path_create did not expose its expected allocated grid");
        assert(array_length(_grid.walls)==3,"Path grid lost an interior collision cell or clamped an excluded outer wall");
        var _expected=[[0,0],[14,14],[27,27]],_matched=0;
        for(var _i=0;_i<array_length(_expected);++_i) for(var _j=0;_j<array_length(_grid.walls);++_j)
            if(_expected[_i][0]==_grid.walls[_j][0] && _expected[_i][1]==_grid.walls[_j][1]) _matched++;
        assert(_matched==3,"Actual authored grid changed lower, interior or last valid wall-cell placement");
        assert(is_array(_path) && array_length(_path)>2 && _path[0][0]==60008 && _path[0][1]==60008
            && _path[array_length(_path)-1][0]==60136 && _path[array_length(_path)-1][1]==60008,
            "Actual authored path_create failed its obstructed start/target route");
        var _detour=false;
        for(var _i=0;_i<array_length(_path);++_i) {
            var _point=_path[_i];
            assert(_point[0]>=59840 && _point[0]<60288 && _point[1]>=59776 && _point[1]<60224
                && !(_point[0]==60072 && _point[1]==60008),
                "Authored path leaves allocated terrain or walks through its marked wall");
            if(_point[1]!=60008) _detour=true;
        }
        assert(_detour,"Authored path did not route around its genuine interior wall cell");
        scrNTTESmokeLog("PASS FRONTIER actual libGeneral path grid inclusive-edge negative control, interior/last cells and obstructed route");
    } finally {
        global.fr_path_grid_observe=_old_observe;global.fr_path_grid_observed=_old_result;
        global.fr_path_grid_observation_count=_old_count;
        scrNTTEFullMergedRuntimeTestCleanup(_before);scrFRSourceRandomSetSeed(_seed);
    }
}

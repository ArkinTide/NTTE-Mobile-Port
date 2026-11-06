// Exercise the authored libAreas builders from their real data-map scopes.
// These maps intentionally contain no invented native instance fields.
function scrFRTerrainRoomTests() {
    var _before=scrNTTEFullInstances(all),_seed=scrFRSourceRandomGetSeed(),
        _fields=["floor_style","floor_area","floor_align_x","floor_align_y","floor_align_w","floor_align_h"],_saved=[];
    for(var _i=0;_i<array_length(_fields);++_i) array_push(_saved,scrFRModGet("mod","libAreas",_fields[_i]));
    try {
        scrFRModCall("mod","libAreas","floor_reset_style");
        scrFRModCall("mod","libAreas","floor_reset_align");
        var _seed_floors=[];
        for(var _i=0;_i<8;++_i) array_push(_seed_floors,instance_create(56000+32*_i,56000,Floor));
        var _native=_seed_floors[0],_start=scrFRModCall("mod","libAreas","floor_room_start",56016,56016,128,_seed_floors);
        scrNTTESmokeLog("FRONTIER TERRAIN NATIVE "+json_stringify({origin:[_native.x,_native.y],
            bounds:[_native.bbox_left,_native.bbox_top,_native.bbox_right,_native.bbox_bottom],
            mask_bounds:[sprite_get_bbox_left(mskFloor),sprite_get_bbox_top(mskFloor),sprite_get_bbox_right(mskFloor),sprite_get_bbox_bottom(mskFloor)],start:_start}));
        assert(is_struct(_start) && instance_exists(_start.id)
            && !variable_struct_exists(_start,"bbox_left") && !variable_struct_exists(_start,"bbox_right"),
            "Authored room start did not return its actual x/y/direction/id data map");
        assert(_native.bbox_right-_native.bbox_left==32 && _native.bbox_bottom-_native.bbox_top==32
            && sprite_get_bbox_right(mskFloor)==31 && sprite_get_bbox_bottom(mskFloor)==31,
            "Terrain probe changed the native exclusive edge or inclusive sprite descriptor contract");
        var _unsafe=(_native.bbox_right>=56032 && _native.bbox_left<=56063
                && _native.bbox_bottom>=56000 && _native.bbox_top<=56031),
            _safe=scrFRModCall("mod","libGeneral","instance_rectangle_bbox",56032,56000,56063,56031,[_native]);
        assert(_unsafe && array_length(_safe)==0
            && array_length(scrFRInstanceRectangleBBox(56032,56000,56063,56031,[_native]))==0,
            "Source rectangle query still treats a merely adjacent native floor edge as overlap");
        assert(scrFRFieldGet(_native,"bbox_right")==56031 && scrFRFieldGet(_native,"bbox_bottom")==56031,
            "Dynamic source bounding-box reads differ from the authored inclusive pixel bounds");
        var _data={id:real(_native),bbox_right:123,bbox_bottom:456};
        assert(scrFRFieldGet(_data,"bbox_right")==123 && scrFRSourceBBoxRead(_data,"bbox_bottom")==456,
            "Source bounding-box conversion altered ordinary data-map fields");
        var _probe=instance_create(58000.25,58000.75,FRMarker),_transforms=[[1,1,0],[-1.5,0.75,13],[1,1,90]];
        _probe.mask_index=mskFloor;_probe.sprite_index=mskFloor;
        for(var _i=0;_i<array_length(_transforms);++_i) {
            var _transform=_transforms[_i];
            _probe.image_xscale=_transform[0];_probe.image_yscale=_transform[1];_probe.image_angle=_transform[2];
            assert(scrFRFieldGet(_probe,"bbox_right")==_probe.bbox_right-1
                && scrFRFieldGet(_probe,"bbox_bottom")==_probe.bbox_bottom-1,
                "Source bounding-box conversion changed under native fractional, rotated or mirrored geometry");
            var _edge=scrFRModCall("mod","libGeneral","instance_rectangle_bbox",_probe.bbox_right,_probe.bbox_top,
                _probe.bbox_right+1,_probe.bbox_bottom-1,[_probe]);
            assert(array_length(_edge)==0,"Source transformed bounding-box query included its exclusive outer edge");
        }
        var _filled;
        with(_start) _filled=scrFRModCall("mod","libAreas","floor_fill",56400,56400,3,3,"");
        var _live=0,_trace=[];
        for(var _i=0;_i<array_length(_filled);++_i) {
            var _floor=_filled[_i],_alive=instance_exists(_floor),_entry={id:_floor,alive:_alive};
            if(_alive) {_live++;_entry.origin=[_floor.x,_floor.y];_entry.bounds=[_floor.bbox_left,_floor.bbox_top,_floor.bbox_right,_floor.bbox_bottom];}
            array_push(_trace,_entry);
        }
        scrNTTESmokeLog("FRONTIER TERRAIN FILL "+json_stringify({returned:array_length(_filled),live:_live,floors:_trace}));
        assert(array_length(_filled)==9 && _live==9,
            "Authored 3x3 floor_fill deleted adjacent native tiles or returned stale instance IDs");
        var _room=scrFRModCall("mod","libAreas","floor_room",56016,56016,128,_seed_floors,3,3,"",0,0);
        assert(is_struct(_room) && array_length(_room.floors)==9
            && _room.x2-_room.x1==96 && _room.y2-_room.y1==96,
            "Authored floor_room data-map callback lost its 3x3 native floor geometry");
        for(var _i=0;_i<array_length(_room.floors);++_i) {
            var _floor=_room.floors[_i];
            assert(instance_exists(_floor) && instance_is(_floor,Floor)
                && _floor.bbox_left>=_room.x1 && _floor.bbox_top>=_room.y1
                && _floor.bbox_right<=_room.x2 && _floor.bbox_bottom<=_room.y2,
                "Authored room map contains a stale floor or a tile outside its actual 96x96 bounds");
        }
        scrNTTESmokeLog("PASS FRONTIER actual libAreas start-map scope, 3x3 floor_fill and connected 96x96 floor_room");
    } finally {
        scrNTTEFullMergedRuntimeTestCleanup(_before);scrFRSourceRandomSetSeed(_seed);
        for(var _i=0;_i<array_length(_fields);++_i) scrFRModSet("mod","libAreas",_fields[_i],_saved[_i]);
    }
}

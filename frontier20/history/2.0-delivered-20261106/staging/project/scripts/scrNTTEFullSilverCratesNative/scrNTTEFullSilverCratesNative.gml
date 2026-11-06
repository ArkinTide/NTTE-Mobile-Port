// ntte.level_start1891..1919. Called after Events, before wall ecology.
function scrNTTEFullSilverCratesLevelStart(_sx=10016,_sy=10016,_normal_area=undefined) {
    var _num=scrNTTEFullSkillGet("silver tongue"),_rooms=[]
    if(is_undefined(_normal_area)) _normal_area=GameCont.hard>1 && instance_number(enemy)>instance_number(HostileHorror)
    if(_num<=0 || !_normal_area || GameCont.subarea!=1) return _rooms;
    repeat(_num) {
        var _w=irandom_range(1,2),_floors=array_shuffle(scrNTTEFullInstances(Floor,true))
        // A native with(instance) inside a for-loop would make break leave
        // only that inner with, creating multiple rooms for one stack.
        for(var _i=0;_i<array_length(_floors);++_i) {
            var _floor=_floors[_i],_x=(_floor.bbox_left+_floor.bbox_right)/2,_y=(_floor.bbox_top+_floor.bbox_bottom)/2
            if(point_distance(_sx,_sy,_x,_y)>32) {
                var _dir=round((point_direction(_sx,_sy,_x,_y)+choose(-90,90))/90)*90
                array_push(_rooms,scrNTTEFullFloorRoomCreate(_x,_y,_w,_w,"",_dir,0,0))
                break
            }
        }
    }
    for(var _i=0;_i<array_length(_rooms);++_i) if(is_struct(_rooms[_i])) {
        var _room=_rooms[_i],_crate=instance_create(_room.x,_room.y,NTTEFullWallCrate)
        _crate.crate_loot=scrNTTEFullLairChestCreate(_crate.x,_crate.y-4,choose("CatChest","BatChest","RatChest"),true)
    }
    return _rooms;
}

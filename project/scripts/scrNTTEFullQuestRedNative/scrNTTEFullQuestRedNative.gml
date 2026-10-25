// red.area465..492: called by the real Red generator while its32px alignment
// and ordinary secret-room floor style are active. WallFake is the real source
// excavation object supplied by the Red/world batch, never a solid Wall proxy.
function scrNTTEFullQuestRedSideRoom(_secret) {
    if(!scrNTTEFullQuestArtifactAvailable(3)) return undefined
    array_push(GameCont.ntte_quest_spawned_part_index_list,3)
    var _floors=[]
    for(var _i=0;_i<array_length(_secret.floors);++_i)
        if(instance_exists(_secret.floors[_i])) array_push(_floors,_secret.floors[_i])
    if(!array_length(_floors)) return undefined
    var _f=_floors[irandom(array_length(_floors)-1)],
        _room=scrNTTEFullFloorRoomCreate((_f.bbox_left+_f.bbox_right)/2,(_f.bbox_top+_f.bbox_bottom)/2,1,3,"",90,0,0),_walls=[]
    for(var _wx=_room.x1;_wx<_room.x2;_wx+=16) for(var _wy=_room.y1;_wy<_room.y2;_wy+=16)
        array_push(_walls,scrNTTEFullWorldCreateRequired("WallFake",_wx,_wy))
    return {room:_room,walls:_walls,chest:scrNTTEFullQuestArtifactChest(_room.x,_room.y1+16,3)}
}

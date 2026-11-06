// red.area.gml population/rooms/start/finish. Generator-local predeclaration
// and GenCont.safedist semantics remain separately audited before registration.
function scrNTTEFullRedSetupNative() {
    // NTT GenCont.Create uses120; the only150 exception is vanilla5-3.
    // The native getter has no periodic decrement (root's binary audit).
    goal=60;safedist=120;background_set_colour(make_color_rgb(235,0,67))
    with(BackCont) shadow_color=make_color_rgb(16,0,24)
    with(TopCont) darkness=false
}
function scrNTTEFullRedNormalFloors(_style=undefined) {
    var _all=scrNTTEFullInstances(Floor,true),_out=[]
    for(var _i=0;_i<array_length(_all);++_i) if(is_undefined(_style) || _all[_i].styleb==_style) array_push(_out,_all[_i])
    return _out
}
function scrNTTEFullRedNormalFloorAt(_x,_y,_floors=undefined) {
    if(is_undefined(_floors)) _floors=scrNTTEFullInstances(Floor,true)
    for(var _i=0;_i<array_length(_floors);++_i) {
        var _floor=_floors[_i]
        if(instance_exists(_floor) && _x>=_floor.bbox_left && _x<_floor.bbox_right && _y>=_floor.bbox_top && _y<_floor.bbox_bottom) return true;
    }
    return false
}
function scrNTTEFullRedPopEnemies() {
    if(GameCont.subarea==3) return;
    var _object=NTTEFullRedSpider
    if(scrNTTEFullSourceRandom(10)<1) _object=NTTEFullCrystalBrain
    else if(scrNTTEFullSourceRandom(7)<1) _object=Bandit
    instance_create(x+16,y+16,_object)
}
function scrNTTEFullRedCorridor(_room,_level_floors,_fake=false) {
    if(!is_struct(_room) || !array_length(_room.floors)) return;
    var _floor=_room.floors[scrNTTEFullSourceIRandom(array_length(_room.floors)-1)],
        _x=(_floor.bbox_left+_floor.bbox_right)/2,_y=(_floor.bbox_top+_floor.bbox_bottom)/2,_tries=4096
    while(point_distance(_x,_y,_room.xstart,_room.ystart)>16
        && (!position_meeting(_x,_y,Floor) || !scrNTTEFullRedNormalFloorAt(_x,_y,_level_floors))) {
        if(--_tries<=0) throw "Red source corridor did not reach existing normal floor";
        if(!position_meeting(_x,_y,Floor) || !scrNTTEFullRedNormalFloorAt(_x,_y)) {
            var _tile=scrNTTEFullFloorSet(_x-16,_y-16,true)
            if(instance_exists(_tile)) with(_tile) {
                if(_fake) {
                    depth=10
                    for(var _wx=bbox_left;_wx<bbox_right;_wx+=16) for(var _wy=bbox_top;_wy<bbox_bottom;_wy+=16)
                        instance_create(_wx,_wy,NTTEFullWallFake)
                }
                else scrNTTEFullRedPopProps()
            }
        }
        var _direction=round((point_direction(_x,_y,_room.xstart,_room.ystart)+scrNTTEFullSourceRandomRange(-60,60))/90)*90
        _x+=lengthdir_x(32,_direction);_y+=lengthdir_y(32,_direction)
    }
}
function scrNTTEFullRedWarpRoom() {
    var _floor_dis=scrNTTEFullSourceRandomRange(48,96),_level_floors=scrNTTEFullRedNormalFloors(),
        _floors=scrNTTEFullRedNormalFloors(0),_room=noone
    scrNTTEFullFloorSetAlign(32,32);scrNTTEFullFloorSetStyle(1)
    try {
        _room=scrNTTEFullFloorRoom(10016,10016,64,_floors,2,2,"",90,_floor_dis)
        if(is_struct(_room)) {
            scrNTTEFullRedCorridor(_room,_level_floors)
            for(var _i=0;_i<array_length(_room.floors);++_i) {
                var _floor=_room.floors[_i]
                if(instance_exists(_floor)) {_floor.sprite_index=scrNTTERefSprite("FloorRedRoom");_floor.image_index=_i}
            }
            instance_create(_room.x,_room.y-4,NTTEFullWarp)
        }
    }
    finally {scrNTTEFullFloorResetAlign();scrNTTEFullFloorResetStyle()}
    return _room
}
function scrNTTEFullRedPopProps() {
    if(scrNTTEFullSourceRandom(5)<1 && point_distance(x,y,10000,10000)>16
        && !place_meeting(x,y,NOWALLSHEREPLEASE) && !place_meeting(x,y,hitme)) {
        instance_create(x+scrNTTEFullSourceChoose([0,16]),y+scrNTTEFullSourceChoose([0,16]),Wall)
        instance_create(x,y,NOWALLSHEREPLEASE)
    }
    else if(scrNTTEFullSourceRandom(4)<1) instance_create(x+16,y+16,styleb?NTTEFullCrystalPropWhite:NTTEFullCrystalPropRed)
    if(styleb==0 && GameCont.subarea>0 && GameCont.subarea!=3
        && scrNTTEFullSourceRandom(12*instance_number(NTTEFullWarp))<1) scrNTTEFullRedWarpRoom()
}
function scrNTTEFullRedSecretRoom() {
    var _floor_dis=scrNTTEFullSourceRandomRange(80,160),_spawn=[],_floors=scrNTTEFullRedNormalFloors(),_room=noone
    scrNTTEFullFloorSetAlign(32,32);scrNTTEFullFloorSetStyle(1)
    try {
        for(var _i=0;_i<array_length(_floors);++_i) {
            var _floor=_floors[_i],_highest=true
            for(var _j=0;_j<array_length(_floors);++_j) if(_floors[_j].x==_floor.x && _floors[_j].y<_floor.y) {_highest=false;break}
            if(_highest) array_push(_spawn,_floor)
        }
        var _start=scrNTTEFullFloorRoomStart(10016,10016,64,_spawn)
        if(is_struct(_start)) {
            _room=scrNTTEFullFloorRoomCreate(_start.x,_start.y,3,3,"",90,60,_floor_dis)
            var _minimum_id=0
            with(all) _minimum_id=max(_minimum_id,real(id))
            scrNTTEFullRedCorridor(_room,_floors,true)
            scrNTTEFullQuestRedSideRoom(_room)
            with(Wall) if(real(id)>_minimum_id) topindex=0
            with(TopSmall) if(real(id)>_minimum_id) image_index=0
            scrNTTEFullPetCreate(_room.x,_room.y,"Twins")
        }
    }
    finally {scrNTTEFullFloorResetAlign();scrNTTEFullFloorResetStyle()}
    return _room
}
function scrNTTEFullRedBossRoom() {
    var _far=instance_furthest(10000,10000,Floor)
    if(!instance_exists(_far)) return noone;
    var _direction=point_direction(10016,10016,(_far.bbox_left+_far.bbox_right)/2,(_far.bbox_top+_far.bbox_bottom)/2),
        _room=scrNTTEFullFloorRoomCreate(10016,10016,4,4,"",_direction,30,-32)
    instance_create(_room.x,_room.y,NTTEFullTesseract)
    return _room
}
function scrNTTEFullRedPopExtras() {
    var _floors=scrNTTEFullRedNormalFloors()
    for(var _i=0;_i<array_length(_floors);++_i) if(scrNTTEFullSourceRandom(4)<3) scrNTTEFullFloorBones(_floors[_i],2,1/8)
    switch(GameCont.subarea) {
        case 1:scrNTTEFullRedSecretRoom();break;
        case 3:scrNTTEFullRedBossRoom();break;
    }
}
function scrNTTEFullRedPopulateNative() {scrPopulate();scrNTTEFullRedPopExtras()}
function scrNTTEFullRedStart() {
    GameCont.ntte_active_red=true;GameCont.ntte_full_active_red=true
    var _wall=instance_find(Wall,0)
    if(instance_exists(_wall)) with(_wall) {
        if(place_meeting(x,y,Floor) && abs(point_distance(10016,10016,x,y)-48)<12) instance_destroy()
    }
}
function scrNTTEFullRedFinish() {
    GameCont.ntte_visits_red=scrNTTEFullValue(GameCont,"ntte_visits_red",0)+1
    GameCont.ntte_visits_loop_red=GameCont.loops
    GameCont.area=206;GameCont.subarea=1
    scrNTTEFullUnlockSet("skin:red crystal",true)
    with(NTTEFullWarpPortal) if(!instance_exists(portal)) scrNTTEFullWarpPortalDestination()
}
function scrNTTEFullRedTransit() {GameCont.ntte_active_red=false;GameCont.ntte_full_active_red=false}
function scrNTTEFullRedEffect() {
    alarm[0]=scrNTTEFullSourceIRandomRange(1,40)/timescale
    var _players=[]
    with(Player) if(scrNTTEFullPlayerActive(id)) array_push(_players,id)
    if(!array_length(_players)) return;
    // Original picks a player index repeatedly, rather than choosing from a
    // compact active list. Epsilon shares one actual camera for local players.
    var _player=noone,_index=-1
    do {
        _index=scrNTTEFullSourceIRandom(player_count-1)
        for(var _i=0;_i<array_length(_players);++_i) if(_players[_i].index==_index) {_player=_players[_i];break}
    }
    until(instance_exists(_player))
    var _seen=[],_floors=scrNTTEFullRedNormalFloors()
    for(var _i=0;_i<array_length(_floors);++_i) {
        var _floor=_floors[_i]
        if(_floor.sprite_index==scrNTTERefSprite("FloorRed") && _floor.bbox_left<=view_xview+view_width
            && _floor.bbox_right-1>=view_xview && _floor.bbox_top<=view_yview+view_height && _floor.bbox_bottom-1>=view_yview)
            array_push(_seen,_floor)
    }
    if(array_length(_seen)>0) {
        var _floor=_seen[scrNTTEFullSourceIRandom(array_length(_seen)-1)],
            _spark=instance_create(scrNTTEFullSourceRandomRange(_floor.bbox_left,_floor.bbox_right),
                scrNTTEFullSourceRandomRange(_floor.bbox_top,_floor.bbox_bottom),LaserCharge)
        _spark.alarm[0]=scrNTTEFullSourceIRandomRange(40,80)/timescale
        _spark.direction=scrNTTEFullSourceRandom(360);_spark.speed=scrNTTEFullSourceRandom(0.2)*timescale;_spark.depth=-8
    }
}

// teevents1967..2162. Four cardinal igloo rooms around the royal plaza.
function scrNTTEFullSealPlazaSetup() {
    var _gen=array_concat(scrNTTEFullInstances(GenCont),scrNTTEFullInstances(FloorMaker))
    for(var _i=0;_i<array_length(_gen);++_i) with (_gen[_i]) if (goal>0) goal=ceil(goal*0.8)
}
function scrNTTEFullSealPlazaCreate(_spawn_floor=Floor) {
    var _before=scrNTTEFullInstances(Floor),_w=3,_h=3,_sx=spawn_x,_sy=spawn_y
    scrNTTEFullFloorSetAlign(32,32)
    var _room=scrNTTEFullFloorRoom(_sx,_sy,160,_spawn_floor,_w,_h,"",0,-32,true)
    if (is_struct(_room)) {
        var _cx=_room.x,_cy=_room.y,_royal=scrNTTEFullFloorFill(_cx,_cy,_w+2,_h+2)
        for(var _i=0;_i<array_length(_royal);++_i) with (_royal[_i]) { sprite_index=scrNTTERefSprite("FloorSealRoomBig"); image_index=_i }
        instance_create(_cx,_cy-6,NTTEFullPalankingStatue)
        for(var _dir=0;_dir<360;_dir+=90) {
            var _iw=3,_ih=3,_px1=_cx+lengthdir_x(16*(_w+2),_dir),_py1=_cy+lengthdir_y(16*(_h+2),_dir),_px2=_px1,_py2=_py1
            var _distance=point_distance(_cx,_cy,_sx,_sy),_x1=_cx-lengthdir_x(ceil(_iw/2)*32,_dir-90),_y1=_cy-lengthdir_y(ceil(_ih/2)*32,_dir-90),
                _x2=_cx+lengthdir_x(ceil(_iw/2)*32,_dir-90)+lengthdir_x(_distance,_dir),_y2=_cy+lengthdir_y(ceil(_ih/2)*32,_dir-90)+lengthdir_y(_distance,_dir)
            if (point_in_rectangle(_sx,_sy,min(_x1,_x2),min(_y1,_y2),max(_x1,_x2),max(_y1,_y2))) {
                _px2=_cx+lengthdir_x(max(0,_distance-64),_dir); _py2=_cy+lengthdir_y(max(0,_distance-64),_dir)
            }
            else {
                var _igloo_room=scrNTTEFullFloorRoomCreate(_cx,_cy,_iw,_ih,"",_dir,0,0)
                for(var _i=0;_i<array_length(_igloo_room.floors);++_i) with (_igloo_room.floors[_i]) { sprite_index=scrNTTERefSprite("FloorSealRoom"); image_index=_i }
                var _igloo=instance_create(_igloo_room.x,_igloo_room.y-2,NTTEFullIgloo)
                _igloo.chest=true
                _px2=_igloo_room.x-lengthdir_x(_iw*16,_dir); _py2=_igloo_room.y-lengthdir_y(_ih*16,_dir)
            }
            var _path_distance=point_distance(_px1,_py1,_px2,_py2)
            for(var _d=16;_d<_path_distance;_d+=32) {
                var _floor=scrNTTEFullFloorSet(_px1+lengthdir_x(_d,_dir)-16,_py1+lengthdir_y(_d,_dir)-16,true)
                if (!instance_exists(_floor)) continue
                _floor.sprite_index=scrNTTERefSprite("FloorSeal")
                with (_floor) {
                    if (random(5)<1 && !place_meeting(x,y,prop) && !place_meeting(x,y,chestprop)) {
                        with (instance_create((bbox_left+bbox_right)/2,(bbox_top+bbox_bottom)/2,choose(Hydrant,StreetLight,Car))) {
                            x=xstart; y=ystart
                            if (instance_is(id,StreetLight)) move_contact_solid(90,8)
                        }
                    }
                    var _props=scrNTTEFullRectInstances(bbox_left,bbox_top,bbox_right,bbox_bottom,prop)
                    for(var _i=0;_i<array_length(_props);++_i) with (_props[_i]) if (size<3 && (_dir==90 || _dir==270 || !instance_is(id,Car))) {
                        var _try=true,_off=choose(-90,90)
                        for(var _side=-1;_side<=1;_side+=2) {
                            var _x=x,_y=y
                            move_contact_solid(_dir+_off*_side,32)
                            if (!point_in_rectangle(x,y,_floor.bbox_left,_floor.bbox_top,_floor.bbox_right,_floor.bbox_bottom)
                                && !place_meeting(x,y,prop) && !place_meeting(x,y,chestprop)) { _try=false; break }
                            x=_x; y=_y
                        }
                        if (_try) move_contact_solid(_dir,32)
                    }
                }
            }
        }
        with (NTTEFullIgloo) if (x!=_cx) image_xscale=sign(_cx-x)
        repeat(3) instance_create(_cx,_cy,Bandit)
    }
    scrNTTEFullFloorResetAlign()
    var _floor_seal=[scrNTTERefSprite("FloorSeal"),scrNTTERefSprite("FloorSealRoom"),scrNTTERefSprite("FloorSealRoomBig")],
        _floor_snow=[scrNTTERefSprite("SnowFloorSeal"),scrNTTERefSprite("SnowFloorSealRoom"),scrNTTERefSprite("SnowFloorSealRoomBig")],_floors=scrNTTEFullInstances(Floor)
    for(var _i=0;_i<array_length(_floors);++_i) if (array_get_index(_before,_floors[_i])<0) with (_floors[_i]) {
        var _index=array_get_index(_floor_seal,sprite_index)
        if (_index>=0) {
            depth=8; traction=0.45
            material=(_index==0 || array_get_index([0,sqrt(image_number)-1,image_number-1,image_number-sqrt(image_number)],image_index)>=0) ? 2:1
            with (instance_create(x,y-1,SnowFloor)) { sprite_index=_floor_snow[_index]; image_index=other.image_index; image_speed=other.image_speed }
        }
        if (!place_meeting(x-32,y,Floor) && !place_meeting(x,y-32,Floor)) instance_create(x,y,Wall)
        if (!place_meeting(x+32,y,Floor) && !place_meeting(x,y-32,Floor)) instance_create(x+16,y,Wall)
        if (!place_meeting(x-32,y,Floor) && !place_meeting(x,y+32,Floor)) instance_create(x,y+16,Wall)
        if (!place_meeting(x+32,y,Floor) && !place_meeting(x,y+32,Floor)) instance_create(x+16,y+16,Wall)
    }
    return is_struct(_room)
}
function scrNTTEFullSealPlazaSmoke() {
    var _before=scrNTTEFullInstances(all),_area=GameCont.area
    GameCont.area=area_city; scrNTTEFullFloorResetStyle(); scrNTTEFullFloorResetAlign()
    var _fixture=scrNTTEFullFloorFill(53016,53016,11,7)
    var _event=instance_create(53016,53016,NTTEFullWorldEvent),_done=false
    _event.spawn_x=53016; _event.spawn_y=53016
    var _statues=instance_number(NTTEFullPalankingStatue),_igloos=instance_number(NTTEFullIgloo),_bandits=instance_number(Bandit)
    // The harness also has an unrelated floor at10000. Restrict the source
    // FloorNormal candidate collection to this fixture's connected level.
    with (_event) _done=scrNTTEFullSealPlazaCreate(_fixture)
    assert(_done && instance_number(NTTEFullPalankingStatue)==_statues+1 && instance_number(Bandit)==_bandits+3,"SealPlaza omitted original outward room/statue/three neighbors")
    var _num=instance_number(NTTEFullIgloo)-_igloos
    assert(_num>=3 && _num<=4,"SealPlaza failed cardinal igloo rooms/spawn avoidance")
    var _royal=0,_room=0,_snow=0,_road=0
    with (Floor) if (array_get_index(_before,id)<0) {
        if (sprite_index==scrNTTERefSprite("FloorSealRoomBig")) _royal++
        if (sprite_index==scrNTTERefSprite("FloorSealRoom")) _room++
        if (sprite_index==scrNTTERefSprite("FloorSeal")) _road++
        if (array_get_index([scrNTTERefSprite("FloorSealRoomBig"),scrNTTERefSprite("FloorSealRoom"),scrNTTERefSprite("FloorSeal")],sprite_index)>=0)
            assert(depth==8 && traction==0.45 && (material==1 || material==2),"SealPlaza floor depth/traction/material changed")
    }
    with (SnowFloor) if (array_get_index(_before,id)<0 && array_get_index([scrNTTERefSprite("SnowFloorSealRoomBig"),scrNTTERefSprite("SnowFloorSealRoom"),scrNTTERefSprite("SnowFloorSeal")],sprite_index)>=0) _snow++
    assert(_royal==25 && _room==9*_num && _snow==_royal+_room+_road,"SealPlaza original 5x5 royal floor/3x3 rooms/paired snow tiles changed")
    var _all=scrNTTEFullInstances(all)
    for(var _i=0;_i<array_length(_all);++_i) if (array_get_index(_before,_all[_i])<0) instance_destroy(_all[_i],false)
    GameCont.area=_area; scrNTTEFullFloorResetAlign(); scrNTTEFullFloorResetStyle()
    scrNTTESmokeLog("FULL WORLD SEAL PLAZA OUTWARD3x3 ROOM/FIVE BY FIVE ROYAL FLOOR/STATUE/CARDINAL IGLOOS+SPAWN AVOIDANCE/THREE BANDITS/PAIRED SNOW/TRACTION+MATERIAL OK")
}

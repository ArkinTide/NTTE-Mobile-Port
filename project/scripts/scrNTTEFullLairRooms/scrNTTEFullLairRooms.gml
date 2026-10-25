// areas/lair.area.gml room topology. Dimensions/layouts are original MOD data.
function scrNTTEFullLairRoomTypes() {
    var _t={
        Start:{w:3,h:3,carpet:1,special:true},
        Boss:{w:12,h:12,special:true,layout:[
            [0,0,0,1,1,1,1,1,1,0,0,0],[0,0,0,1,1,1,1,1,1,0,0,0],
            [0,0,1,1,1,1,1,1,1,1,0,0],[1,1,1,1,1,1,1,1,1,1,1,1],
            [1,1,1,1,1,1,1,1,1,1,1,1],[1,1,1,1,1,1,1,1,1,1,1,1],
            [1,1,1,1,1,1,1,1,1,1,1,1],[1,1,1,1,1,1,1,1,1,1,1,1],
            [1,1,1,1,1,1,1,1,1,1,1,1],[0,0,1,1,1,1,1,1,1,1,0,0],
            [0,0,0,1,1,1,1,1,1,0,0,0],[0,0,0,1,1,1,1,1,1,0,0,0]]},
        SmallClutter:{w:2,h:2},MediumClutter:{w:3,h:3},SmallPillars:{w:3,h:3},
        SmallRing:{w:2,h:2},WideSmallRing:{w:3,h:2},TallSmallRing:{w:2,h:3},
        MediumRing:{w:3,h:3,layout:[[1,1,1],[1,0,1],[1,1,1]]},
        Table:{w:3,h:3},Toilet:{w:3,h:2},SmallTriangle:{w:3,h:3,layout:[[1,0,0],[1,1,0],[1,1,1]]},Vault:{w:3,h:3},
        SmallAtrium:{w:6,h:6,layout:[[0,0,1,1,0,0],[0,0,1,1,0,0],[1,1,1,1,1,1],[1,1,1,1,1,1],[0,0,1,1,0,0],[0,0,1,1,0,0]]},
        Lounge:{w:5,h:4,layout:[[1,1,1,1,1],[1,1,1,1,1],[1,1,1,1,1],[1,0,0,0,1]]},
        Dining:{w:4,h:3,carpet:1/3},
        Cafeteria:{w:4,h:6,layout:[[0,1,0,0],[1,1,1,1],[1,1,1,1],[1,1,1,1],[1,1,1,1],[1,1,1,1]]},
        Office:{w:6,h:4,layout:[[0,0,1,1,0,0],[1,1,1,1,1,1],[1,1,1,1,1,1],[1,1,1,1,1,1]]},
        Garage:{w:4,h:3},LargeRing:{w:6,h:6,layout:[[1,1,1,1,1,1],[1,1,1,1,1,1],[1,1,0,0,1,1],[1,1,0,0,1,1],[1,1,1,1,1,1],[1,1,1,1,1,1]]}
    }
    var _names=variable_struct_get_names(_t)
    for(var _i=0;_i<array_length(_names);++_i) {
        var _room=_t[$ _names[_i]]
        if (!variable_struct_exists(_room,"carpet")) _room.carpet=0
        if (!variable_struct_exists(_room,"special")) _room.special=false
    }
    return _t
}

function scrNTTEFullLairRoomNew(_cx,_cy,_name,_types) {
    var _template=_types[$ _name],_room={x:_cx-floor(_template.w/2),y:_cy-floor(_template.h/2),
        w:_template.w,h:_template.h,type:_name,link:-1,floors:[],special:_template.special,
        carpeted:random(1)<_template.carpet,layout:[]}
    if (variable_struct_exists(_template,"layout")) _room.layout=_template.layout
    else for(var _iy=0;_iy<_room.h;++_iy) {
        var _row=array_create(_room.w,true); array_push(_room.layout,_row)
    }
    return _room
}

function scrNTTEFullLairPlan(_goal=100) {
    var _types=scrNTTEFullLairRoomTypes(),_names=variable_struct_get_names(_types),_ordinary=[],_rooms=[]
    for(var _i=0;_i<array_length(_names);++_i) if (!_types[$ _names[_i]].special) array_push(_ordinary,_names[_i])
    repeat(floor(4*(_goal/100))) {
        var _name=_ordinary[irandom(array_length(_ordinary)-1)]
        array_push(_rooms,scrNTTEFullLairRoomNew(irandom_range(-1,1),irandom_range(-1,1),_name,_types))
    }
    var _done=false,_tries=0
    while(!_done) {
        _tries+=1
        if (_tries>10000) show_error("Original Lair room packing failed to converge",true)
        _done=true
        for(var _i=0;_i<array_length(_rooms);++_i) {
            var _a=_rooms[_i],_x1=_a.x-1,_y1=_a.y-1,_x2=_a.x+_a.w+1,_y2=_a.y+_a.h+1
            for(var _j=0;_j<array_length(_rooms);++_j) if (_i!=_j) {
                var _b=_rooms[_j]
                if (rectangle_in_rectangle(_b.x,_b.y,_b.x+_b.w,_b.y+_b.h,_x1,_y1,_x2,_y2) && _b.type!="Start") {
                    var _d=round(point_direction(_a.x+_a.w/2,_a.y+_a.h/2,_b.x+_b.w/2,_b.y+_b.h/2)/90)*90
                    if (_a.x+_a.w/2==_b.x+_b.w/2 && _a.y+_a.h/2==_b.y+_b.h/2) _d=round(random(360)/90)*90
                    else if (random(2)<1) _d+=choose(-90,-90,90,90,180)
                    _b.x+=round(lengthdir_x(1,_d)); _b.y+=round(lengthdir_y(1,_d)); _done=false
                }
            }
            _a.y=min(-floor(_a.h/2),_a.y)
        }
        if (_done) {
            var _start=false,_boss=false
            for(var _i=0;_i<array_length(_rooms);++_i) {
                if (_rooms[_i].type=="Start") _start=true
                if (_rooms[_i].type=="Boss") _boss=true
            }
            if (!_start) {
                var _max_y=0
                for(var _i=0;_i<array_length(_rooms);++_i) if (_rooms[_i].y>_max_y) _max_y=_rooms[_i].y+floor(_rooms[_i].h/2)
                for(var _i=0;_i<array_length(_rooms);++_i) _rooms[_i].y-=_max_y
                array_push(_rooms,scrNTTEFullLairRoomNew(0,0,"Start",_types)); _done=false
            }
            else if (!_boss) {
                var _furthest=-1,_distance=-1
                for(var _i=0;_i<array_length(_rooms);++_i) {
                    var _r=_rooms[_i],_d=point_distance(0,0,_r.x+_r.w/2,_r.y+_r.h/2)
                    if (_d>_distance) { _distance=_d; _furthest=_i }
                }
                var _r=_rooms[_furthest]
                array_push(_rooms,scrNTTEFullLairRoomNew(_r.x+sign(_r.x),_r.y+sign(_r.y),"Boss",_types)); _done=false
            }
        }
    }
    for(var _pass=0;_pass<=1;++_pass) {
        for(var _i=0;_i<array_length(_rooms);++_i) {
            var _a=_rooms[_i]
            if (_a.link>=0) continue
            var _nearest=10000
            for(var _j=0;_j<array_length(_rooms);++_j) if (_i!=_j) {
                var _b=_rooms[_j],_distance=point_distance(_a.x+_a.w/2,_a.y+_a.h/2,_b.x+_b.w/2,_b.y+_b.h/2)
                if (_distance<_nearest && (_b.link<0 || _pass)) { _a.link=_j; _nearest=_distance }
            }
            if (_a.link>=0 && _rooms[_a.link].link==_i) _rooms[_a.link].link=-1
        }
    }
    return _rooms
}

function scrNTTEFullLairFloor(_x,_y,_hallway) {
    var _existing=collision_point(_x+16,_y+16,Floor,false,false)
    if (instance_exists(_existing)) return _existing
    var _floor=instance_create(_x,_y,Floor)
    _floor.styleb=_hallway; _floor.sprite_index=scrNTTERefSprite(_hallway ? "FloorLairB":"FloorLair")
    _floor.material=(_hallway ? 3:2); _floor.depth=(_hallway ? 8:9)
    return _floor
}

function scrNTTEFullLairBuildRooms(_rooms) {
    for(var _i=0;_i<array_length(_rooms);++_i) {
        var _r=_rooms[_i]
        for(var _iy=0;_iy<array_length(_r.layout);++_iy) {
            var _row=_r.layout[_iy]
            for(var _ix=0;_ix<array_length(_row);++_ix) if (_row[_ix]) {
                array_push(_r.floors,scrNTTEFullLairFloor(10000+(_r.x+_ix)*32,10000+(_r.y+_iy)*32,false))
            }
        }
    }
    for(var _i=0;_i<array_length(_rooms);++_i) {
        var _a=_rooms[_i]
        if (_a.link<0) continue
        var _b=_rooms[_a.link],_fx=_b.x+floor(_b.w/2),_fy=_b.y+floor(_b.h/2),
            _tx=_a.x+floor(_a.w/2),_ty=_a.y+floor(_a.h/2),_dir=round(point_direction(_fx,_fy,_tx,_ty)/90)*90,_tries=100
        while(_tries>0) {
            _tries-=1
            scrNTTEFullLairFloor(10000+_fx*32,10000+_fy*32,true)
            if (_fx==_tx || _fy==_ty) _dir=point_direction(_fx,_fy,_tx,_ty)
            for(var _angle=_dir;_angle<_dir+360;_angle+=90) {
                var _dx=round(_fx-_a.x+lengthdir_x(1,_angle)),_dy=round(_fy-_a.y+lengthdir_y(1,_angle))
                if (point_in_rectangle(_dx,_dy,0,0,_a.w-1,_a.h-1) && _a.layout[_dy][_dx]) {
                    scrNTTEFullCatDoorPair(10016+_fx*32,10016+_fy*32,_angle); _tries=0; break
                }
            }
            _fx+=round(lengthdir_x(1,_dir)); _fy+=round(lengthdir_y(1,_dir))
            if (_fx==_tx && _fy==_ty) break
        }
    }
    GameCont.ntte_full_lair_rooms=_rooms
}

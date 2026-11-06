// tesewers SewerDrain_destroy secret-room portion. All coordinates derive from
// the actual broken drain floor; rooms stay in the current gameplay room.
function scrNTTEFullSewerDrainRoom(_kind,_entrance) {
    var _x=(_entrance.bbox_left+_entrance.bbox_right)/2,_y=(_entrance.bbox_top+_entrance.bbox_bottom)/2
    var _snapshot=scrNTTEFullInstances(Floor),_room=scrNTTEFullFloorRoomCreate(_x,_y,4,3,"",90,0,32)
    if (!is_struct(_room)) return;
    var _tunnel=scrNTTEFullFloorTunnel(_room.x,_room.y2,_x,_y)
    with (_tunnel) scrNTTEFullFloorReveal(bbox_left,bbox_top,bbox_right-1,bbox_bottom-1,10)
    var _corners=[[_room.x1,_room.y1+16],[_room.x2-16,_room.y1+16],[_room.x1,_room.y2-32],[_room.x2-16,_room.y2-32]]
    for(var _i=0;_i<4;++_i) {
        var _wall=instance_create(_corners[_i][0],_corners[_i][1],Wall)
        if (random(2)<1) _wall.topindex=irandom_range(1,sprite_get_number(_wall.topspr)-1)
    }
    var _detail=4,_floors=array_shuffle(_room.floors)
    for(var _i=0;_i<array_length(_floors);++_i) with (_floors[_i]) {
        if (random(5)<1 || _detail-->0) {
            var _dx=random_range(bbox_left,bbox_right-1),_dy=random_range(bbox_top,bbox_bottom-1)
            var _d=instance_create(_dx,_dy,Detail)
            if (instance_exists(_d) && _kind=="Pizza") { _d.sprite_index=sprDetail102; _d.image_index=irandom_range(1,4) }
            if (_kind=="GatorStatue") {
                var _debris=instance_create(_dx,_dy,Debris)
                _debris.sprite_index=random(4)<1 ? sprShotShellBig:sprShotShell
                with (_debris) motion_add(random(360),random(1)*timescale)
                _debris.alarm[0]=-1
            }
        }
        repeat(2) {
            var _dx=random_range(bbox_left,bbox_right-1),_dy=random_range(bbox_top,bbox_bottom-1)
            var _dust=scrNTTEFullTrenchFX(_dx,_dy,point_direction(_dx,_dy,_x,_y)+orandom(30),3,Dust)
            // Native Dust may disappear in Create (particles off/underwater).
            // Source with(fx) skips that optional visual while room gen continues.
            if(instance_exists(_dust)) { _dust.image_xscale*=2.5; _dust.image_yscale*=2.5 }
        }
        if (_kind!="Pizza" && random(3)<2 && (_kind=="RedSpider" || (random(2)<1
            && !point_in_rectangle(_room.x,_room.y,bbox_left,bbox_top,bbox_right,bbox_bottom)))) {
            sprite_index=scrNTTERefSprite("FloorSewerWeb"); material=5; traction=2
        }
    }
    var _ox=24*choose(-1,1)
    switch(_kind) {
        case WeaponChest: case AmmoChest: case HealthChest: case "Backpack": case "LairChest":
            var _number=2+scr_skill_get(mut_open_mind),_objects=[_kind]
            if (_kind==HealthChest || _kind=="Backpack") _number-=1
            if (_kind=="LairChest") _objects=["BatChest","CatChest"]
            if (_number<=1) _ox=0
            for(var _i=0;_i<_number;++_i) scrNTTEFullLairChestCreate(_room.x+orandom(1)+lerp(-_ox,_ox,_i/max(1,_number-1)),
                _room.y+orandom(1),_objects[_i%array_length(_objects)],true)
            break
        case "Pizza":
            var _floor=scrNTTEFullWorldNearestRectBBox(_room.x+_ox,_room.y,_room.x+_ox,_room.y,Floor)
            if (instance_exists(_floor)) {
                var _fx=(_floor.bbox_left+_floor.bbox_right)/2,_fy=(_floor.bbox_top+_floor.bbox_bottom)/2
                scrNTTEFullSystemsCreate("Manhole",_fx,_fy)
                if (random(3)<2) {
                    var _px=_fx+orandom(4)+random(16*sign(_ox)),_py=_fy+orandom(4)
                    if (random(2)<1) scrNTTEFullSystemsCreate("PizzaStack",_px,_py)
                    else scrNTTEFullLairChestCreate(_px,_py,"PizzaChest",true)
                }
            }
            var _ground=scrNTTEFullSystemsCreate("WepPickupGrounded",_room.x-_ox,_room.y)
            _ground.target=scrWeaponPickupCreate(_ground.x,_ground.y,wep_grenade_launcher,true)
            break
        case "RedSpider":
            var _number=irandom_range(2,5),_floors=array_shuffle(_room.floors)
            for(var _i=0;_i<array_length(_floors) && _number>0;++_i) with (_floors[_i]) {
                if (place_meeting(x,y,Wall)) continue
                _number-=1
                var _cx=(bbox_left+bbox_right)/2,_cy=(bbox_top+bbox_bottom)/2
                if ((_number%2)==1) scrNTTEFullSystemsCreate("CrystalPropRed",_cx+orandom(8),_cy+orandom(8))
                else scrNTTEFullSystemsCreate("RedSpider",_cx,_cy)
            }
            break
        case FrogQueen:
            scrNTTEFullFloorSetStyle(1)
            scrNTTEFullFloorFill(_room.x1+16,_room.y,1,3); scrNTTEFullFloorFill(_room.x2-16,_room.y,1,3)
            scrNTTEFullFloorResetStyle()
            var _queen=instance_create(_room.x,_room.y,FrogQueen)
            _queen.max_hp=round(_queen.max_hp/2); _queen.hp=round(_queen.hp/2); _queen.alarm[3]=60
            _ox=48*sign(_ox)
            var _number=2+scr_skill_get(mut_open_mind)
            for(var _i=0;_i<_number;++_i) scrNTTEFullLairChestCreate(_queen.x+orandom(1)+lerp(-_ox,_ox,_i/max(1,_number-1)),
                _queen.y+orandom(1),choose(AmmoChest,WeaponChest),true)
            break
        case "GatorStatue":
            var _statue=scrNTTEFullSystemsCreate(_kind,_room.x,_room.y-4)
            var _light=scrNTTEFullLairLight(_statue.x,_statue.y-22)
            _light.image_xscale*=1.1
            break
    }
    repeat(2) scrNTTEFullAreaTopDecalCreate(_room.x,_room.y)
    var _after=scrNTTEFullInstances(Floor)
    for(var _i=0;_i<array_length(_after);++_i) if (array_get_index(_snapshot,_after[_i])<0) with (_after[_i])
        scrNTTEFullFloorReveal(bbox_left,bbox_top,bbox_right-1,bbox_bottom-1,10)
    sleep(100)
}

function scrNTTEFullSewerDrainArea() {
    var _sx=floor(x/32)*32,_sy=floor(y/32)*32-16,_border_y=_sy-ntte_full_hallway_size+72
    var _border=instance_create(x,_border_y,NTTEFullLairBorder),_direction=90,_path=[]
    instance_create(_sx+16,_sy+16,PortalClear)
    while (_sy>=_border_y-224) {
        var _floor=instance_create(_sx,_sy,Floor)
        array_push(_path,_floor)
        with (_floor) scrNTTEFullWallDelete(bbox_left,bbox_top,bbox_right-1,bbox_bottom-1)
        if (_sy>=_border_y-160 && _sy<=_border_y-32) {
            _direction+=choose(0,0,0,0,-90,90)
            if (abs(angle_difference(_direction,90))>90) _direction=90
        }
        else _direction=90
        _sx+=lengthdir_x(32,_direction); _sy+=lengthdir_y(32,_direction)
    }
    var _last_area=GameCont.area,_background=scrAreaGetBackroundColor(GameCont.area),_setup=undefined
    // Central dispatcher must generate the actual destination in this room.
    // No portal or empty-area substitute is permitted when not integrated.
    scrNTTEFullAreaGenerate(area,subarea,ntte_full_loops,_sx+16,_sy-16,true,0,_setup)
    var _walls=scrNTTEFullInstances(Wall)
    for(var _i=0;_i<array_length(_path);++_i) with (_path[_i]) {
        area=GameCont.area; styleb=true; sprite_index=scrNTTEFullAreaFloorSprite(area,true)
        scrNTTEFullFloorWalls(id)
        // floor_bones pipe decoration is applied by the shared destination
        // terrain decorator, with original area selected per border side.
        ntte_full_border_decor_area=y>_border_y ? _last_area:area
    }
    var _new_walls=scrNTTEFullInstances(Wall)
    for(var _i=0;_i<array_length(_new_walls);++_i) if (array_get_index(_walls,_new_walls[_i])<0) with (_new_walls[_i]) {
        instance_create(x-16,y-16,Top); instance_create(x-16,y,Top); instance_create(x,y-16,Top); instance_create(x,y,Top)
    }
    var _reveal_y=y-48,_wait=0,_time=7
    var _first=scrNTTEFullFloorReveal(bbox_left,_reveal_y,bbox_right-1,y-17,10)
    _first.color=_background; _wait+=_first.time-_time
    for(var _i=0;_i<array_length(_path);++_i) with (_path[_i]) {
        if (bbox_top>=_reveal_y) continue
        if (bbox_bottom-1>_border_y) {
            var _reveal=scrNTTEFullFloorReveal(bbox_left,bbox_top,bbox_right-1,min(_reveal_y-1,bbox_bottom-1),_time)
            _reveal.y1=max(_reveal.y1,_border_y-_reveal.oy); _reveal.time+=_wait; _reveal.color=_background
        }
        if (bbox_top<_border_y) {
            var _reveal=scrNTTEFullFloorReveal(bbox_left,bbox_top,bbox_right-1,bbox_bottom-1,_time)
            _reveal.y2=min(_reveal.y2,_border_y-_reveal.oy-1); _reveal.time+=_wait
        }
        _wait+=3
    }
    if (GameCont.area==scrNTTEFullAreaId("lair")) scrNTTEFullUnlockSet("crown:crime",true)
}

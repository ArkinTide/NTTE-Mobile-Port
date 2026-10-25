// tegeneral:1279..1640. Source hidden layout, excavation and mixed-area reveal.
// Inclusive source rectangles use modern exclusive bbox_right/bottom minus one.
function scrNTTEFullBuriedVaultMaxID() {
    var _all=scrNTTEFullInstances(all),_max=-1
    for(var _i=0;_i<array_length(_all);++_i) _max=max(_max,real(_all[_i].id))
    return _max
}
function scrNTTEFullBuriedVaultNew(_object,_min) {
    var _all=scrNTTEFullInstances(_object),_out=[]
    for(var _i=0;_i<array_length(_all);++_i) if(real(_all[_i].id)>_min) array_push(_out,_all[_i])
    return _out
}
// telib:3620. Do not update wall geometry: source wall_tops only creates Top.
function scrNTTEFullBuriedVaultWallTops(_wall) {
    var _min=scrNTTEFullBuriedVaultMaxID()
    with(_wall) {
        instance_create(x-16,y-16,Top);instance_create(x-16,y,Top)
        instance_create(x,y-16,Top);instance_create(x,y,Top)
    }
    return scrNTTEFullBuriedVaultNew(TopSmall,_min)
}
function scrNTTEFullBuriedVaultCreate() {
    visible=false;mask_index=mskWall;image_xscale=6;image_yscale=4
    floor_num=0;floor_min=0;floor_vars={};floor_room_vars={sprite_index:scrNTTERefSprite("VaultFlowerFloor")}
    layout=[];layout_delay=6;obj_prop=Torch
    obj_loot=GameCont.area==area_vault ? "GhostStatue":"BuriedVaultPedestal"
    area=area_vault;x=floor(bbox_left/16)*16;y=floor(bbox_top/16)*16
}
function scrNTTEFullBuriedVaultPointIn(_x,_y,_tiles) {
    for(var _i=0;_i<array_length(_tiles);++_i) if(instance_exists(_tiles[_i]) && collision_point(_x,_y,_tiles[_i],false,false)) return true
    return false
}
function scrNTTEFullBuriedVaultTinyEdges(_tiles,_chance,_append=false) {
    var _snapshot=[];array_copy(_snapshot,0,_tiles,0,array_length(_tiles))
    for(var _i=0;_i<array_length(_snapshot);++_i) if(instance_exists(_snapshot[_i])) with(_snapshot[_i]) {
        for(var _x=bbox_left-8;_x<bbox_right+8;_x+=8) for(var _y=bbox_top-8;_y<bbox_bottom+8;_y+=8) {
            if(!scrNTTEFullBuriedVaultPointIn(_x,_y,_tiles) && random(_chance)<1) {
                var _tiny=scrNTTEFullTopTinyCreate(_x,_y)
                if(_append && instance_exists(_tiny)) array_push(_tiles,_tiny)
            }
        }
    }
    return _tiles
}
function scrNTTEFullBuriedVaultGenerate() {
    var _oldarea=GameCont.area
    try {
        var _move=32,_dis=random_range(40,80)
        direction=random(360)
        var _near=scrNTTEFullWorldNearestRectBBox(x,y,x,y,Floor)
        if(instance_exists(_near)) direction=point_direction((_near.bbox_left+_near.bbox_right)/2,(_near.bbox_top+_near.bbox_bottom)/2,x,y)
        while(distance_to_object(Floor)<_dis) {
            x=floor((x+lengthdir_x(_move,direction))/16)*16
            y=floor((y+lengthdir_y(_move,direction))/16)*16
        }
        var _x1=random_range(bbox_left,bbox_right),_y1=random_range(bbox_top,bbox_bottom),
            _x2=random_range(bbox_left+16,bbox_right-16),_y2=random_range(bbox_top+16,bbox_bottom-16),_old=[],_new=[]
        // Both loops deliberately use image_xscale, exactly as original.
        for(var _ix=0;_ix<image_xscale;++_ix) for(var _iy=0;_iy<image_xscale;++_iy) {
            var _center=_ix>0 && _iy>0 && _ix<image_xscale-1 && _iy<image_xscale-1
            if(_center || random(3)<1) {
                var _sx=x+_ix*16,_sy=y+_iy*16
                if(!position_meeting(_sx,_sy,Floor) && !position_meeting(_sx,_sy,Wall) && !position_meeting(_sx,_sy,TopSmall)) {
                    var _tile=instance_create(_sx,_sy,TopSmall)
                    if(instance_exists(_tile)) {
                        if(collision_line(_x1,_y1,_x2,_y2,_tile,false,false)) {
                            GameCont.area=area
                            with(_tile) event_perform(ev_create,0)
                            if(instance_exists(_tile)) array_push(_new,_tile)
                        }
                        else array_push(_old,_tile)
                        if(instance_exists(_tile) && (position_meeting(_x2,_y2,_tile) || random(3)<2)) _tile.sprite_index=scrNTTEFullAreaWallSprite(GameCont.area,"Top")
                    }
                    GameCont.area=_oldarea
                }
            }
        }
        GameCont.area=area
        _new=scrNTTEFullBuriedVaultTinyEdges(array_shuffle(_new),10,true)
        GameCont.area=_oldarea;_old=array_shuffle(_old)
        for(var _i=0;_i<array_length(_old);++_i) if(instance_exists(_old[_i])) {
            var _tile=_old[_i],_touch=false
            for(var _j=0;_j<array_length(_new);++_j) if(instance_exists(_new[_j])) with(_tile) if(place_meeting(x,y,_new[_j])) { _touch=true;break }
            if(!_touch) {
                var _decal=scrNTTEFullAreaTopDecalCreate(irandom_range(_tile.bbox_left,_tile.bbox_right),irandom_range(_tile.bbox_top,_tile.bbox_bottom))
                if(instance_exists(_decal)) { _decal.x=_decal.xstart;_decal.y=_decal.ystart }
                break
            }
        }
        var _fx=floor((bbox_left+bbox_right)/32)*16,_fy=floor((bbox_top+bbox_bottom)/32)*16,
            _num=irandom_range(6,12),_dir=direction,_ped=true,_tries=100
        while(_num>0 && _tries-->0) {
            var _moveDir=round(_dir/90)*90
            _fx+=lengthdir_x(32,_moveDir);_fy+=lengthdir_y(32,_moveDir)
            var _spawnPed=random(1+(_num-1)*2)<real(_ped),_floorDis=48+32*_spawnPed,
                _near=scrNTTEFullWorldNearestRectBBox(_fx+16,_fy+16,_fx+16,_fy+16,Floor)
            if(!instance_exists(_near) || abs(_fx-_near.x)>_floorDis || abs(_fy-_near.y)>_floorDis) {
                _num-=1;_tries=100
                if(_spawnPed) {
                    _ped=false;var _room=0
                    for(var _oy=-32;_oy<=32;_oy+=32) for(var _ox=-32;_ox<=32;_ox+=32) { array_push(layout,{x:_fx+_ox,y:_fy+_oy,obj:Floor,room:_room});_room+=1 }
                    array_push(layout,{x:_fx+16,y:_fy+8,obj:obj_loot})
                    _fx+=lengthdir_x(32,_moveDir);_fy+=lengthdir_y(32,_moveDir)
                }
                else {
                    array_push(layout,{x:_fx,y:_fy,obj:Floor})
                    if(random(8)<1) array_push(layout,{x:_fx+16,y:_fy+16,obj:obj_prop})
                }
                _dir+=orandom(60)
            }
            else { _fx-=lengthdir_x(32,_moveDir);_fy-=lengthdir_y(32,_moveDir);_dir=_moveDir+180+orandom(90) }
        }
    }
    finally { GameCont.area=_oldarea }
}
function scrNTTEFullBuriedVaultExcavate(_sx,_sy) {
    var _oldarea=GameCont.area,_vaultArea=area
    try {
        GameCont.area=area
        for(var _i=0;_i<array_length(layout);++_i) {
            var _node=layout[_i]
            if(_node.obj==Floor) {
                scrNTTEFullWallDelete(_node.x-16,_node.y-16,_node.x+47,_node.y+47)
                var _floors=scrNTTEFullRectInstances(_node.x-16,_node.y-16,_node.x+47,_node.y+47,[Floor,SnowFloor])
                for(var _j=0;_j<array_length(_floors);++_j) instance_destroy(_floors[_j])
            }
        }
        var _min=scrNTTEFullBuriedVaultMaxID()
        for(var _i=0;_i<array_length(layout);++_i) {
            var _node=layout[_i],_room=scrNTTEFullValue(_node,"room",-1),_obj=_node.obj
            if(_room>=0 && !is_string(_obj) && (_obj==Floor || object_is_ancestor(_obj,Floor))) {
                var _floors=scrNTTEFullRectInstances(_node.x,_node.y,_node.x+31,_node.y+31,[Floor,SnowFloor])
                for(var _j=0;_j<array_length(_floors);++_j) instance_destroy(_floors[_j])
            }
            var _new=is_string(_obj) ? scrNTTEFullSystemsCreate(_obj,_node.x,_node.y):instance_create(_node.x,_node.y,_obj)
            if(instance_exists(_new) && instance_is(_new,Floor)) {
                if(_room>=0) _new.image_index=_room
                var _vars=_room<0 ? floor_vars:floor_room_vars,_names=variable_struct_get_names(_vars)
                for(var _j=0;_j<array_length(_names);++_j) variable_instance_set(_new,_names[_j],_vars[$ _names[_j]])
            }
        }
        var _tiles=[],_extraFloors=[]
        scrNTTEFullFloorWalls(scrNTTEFullBuriedVaultNew(Floor,_min))
        var _walls=scrNTTEFullBuriedVaultNew(Wall,_min),_oldFloors=scrNTTEFullInstances(Floor)
        for(var _i=array_length(_oldFloors)-1;_i>=0;--_i) if(real(_oldFloors[_i].id)>=_min) array_delete(_oldFloors,_i,1)
        for(var _i=0;_i<array_length(_walls);++_i) if(instance_exists(_walls[_i])) with(_walls[_i]) {
            if(array_length(scrNTTEFullRectInstances(bbox_left-1,bbox_top-1,bbox_right,bbox_bottom,_oldFloors))<=0) {
                if(random(5)<2) { GameCont.area=_oldarea;scrNTTEFullBuriedVaultWallTops(id);GameCont.area=other.area }
                else _tiles=array_concat(_tiles,scrNTTEFullBuriedVaultWallTops(id))
            }
            else { array_push(_extraFloors,instance_create(x,y,FloorExplo));instance_destroy() }
        }
        scrNTTEFullBuriedVaultTinyEdges(_tiles,5)
        for(var _i=0;_i<array_length(_extraFloors);++_i) if(instance_exists(_extraFloors[_i])) with(_extraFloors[_i]) {
            if(position_meeting(x-16,y,Wall) && position_meeting(x,y-16,Wall) && position_meeting(x+16,y,Wall) && position_meeting(x,y+16,Wall)) {
                var _clear=array_concat(scrNTTEFullRectInstances(bbox_left-16,bbox_top,bbox_right+15,bbox_bottom-1,Wall),
                    scrNTTEFullRectInstances(bbox_left,bbox_top-16,bbox_right-1,bbox_bottom+15,Wall))
                for(var _j=0;_j<array_length(_clear);++_j) if(instance_exists(_clear[_j])) with(_clear[_j]) {
                    if(real(id)<_min) GameCont.area=_oldarea
                    instance_create(x,y,FloorExplo);instance_destroy();GameCont.area=_vaultArea
                }
            }
        }
        GameCont.area=_oldarea
        scrNTTEFullTrenchShake(_sx,_sy,20);snd_play(sndStatueCharge,1.6+orandom(0.2));snd_play(sndStatueDead,0.4+random(0.1))
        var _reveal=scrNTTEFullBuriedVaultNew([Floor,Wall,TopSmall],_min)
        for(var _i=0;_i<array_length(_reveal);++_i) {
            var _tile=_reveal[_i],_record=scrNTTEFullFloorReveal(_tile.bbox_left,_tile.bbox_top,_tile.bbox_right-1,_tile.bbox_bottom-1,4)
            _record.time=(point_distance((_tile.bbox_left+_tile.bbox_right)/2,(_tile.bbox_top+_tile.bbox_bottom)/2,_sx,_sy)-32)/4.5;_record.flash=false
        }
    }
    finally { GameCont.area=_oldarea }
    instance_destroy()
}
function scrNTTEFullBuriedVaultStep() {
    if(array_length(layout)<=0) {
        if(layout_delay>0) layout_delay-=timescale
        else scrNTTEFullBuriedVaultGenerate()
    }
    else if(instance_exists(Floor)) {
        if(floor_num!=instance_number(Floor) || floor_min<real(Floor.id)) {
            floor_num=instance_number(Floor);floor_min=scrNTTEFullBuriedVaultMaxID()
            var _open=false,_sx=(bbox_left+bbox_right)/2,_sy=(bbox_top+bbox_bottom)/2
            if(place_meeting(x,y,Floor)) { _open=true;scrNTTEFullWorldWallClear(id) }
            for(var _i=0;_i<array_length(layout) && !_open;++_i) {
                var _node=layout[_i]
                if(_node.obj==Floor && collision_rectangle(_node.x-1,_node.y-1,_node.x+32,_node.y+32,Wall,false,false)) { _open=true;_sx=_node.x;_sy=_node.y }
            }
            if(_open) scrNTTEFullBuriedVaultExcavate(_sx,_sy)
        }
    }
}

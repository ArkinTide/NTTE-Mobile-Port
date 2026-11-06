// ntte.mod780..853,961..1041,1222..1259. Natural base-biome providers
// reuse the genuine authored entities rather than pilot set-piece objects.
function scrNTTEFullDesertPropFloors(_sx=10016,_sy=10016) {
    var _out=[],_floors=scrNTTEFullInstances(Floor,true)
    for(var _i=0;_i<array_length(_floors);++_i) with(_floors[_i]) {
        if(point_distance((bbox_left+bbox_right)/2,(bbox_top+bbox_bottom)/2,_sx,_sy)>48
            && !place_meeting(x,y,Wall) && !place_meeting(x,y,prop)
            && !place_meeting(x,y,chestprop) && !place_meeting(x,y,MaggotSpawn)) array_push(_out,id)
    }
    return array_shuffle(_out)
}
function scrNTTEFullDesertProps(_sx=10016,_sy=10016) {
    var _disable=instance_create(0,0,chestprop)
    if(instance_exists(_disable)) { _disable.visible=false;_disable.mask_index=mskNone }
    var _floors=scrNTTEFullDesertPropFloors(_sx,_sy),_index=array_length(_floors)-1,_out=[]
    with(BigSkull) instance_destroy(id,false)
    if(GameCont.subarea==3) {
        var _x=_sx,_y=_sy
        if(_index>=0) { var _f=_floors[_index--];_x=(_f.bbox_left+_f.bbox_right)/2;_y=(_f.bbox_top+_f.bbox_bottom)/2 }
        array_push(_out,instance_create(_x,_y,NTTEFullCoastBossBecome))
    }
    if(!instance_exists(BonePile) && !instance_exists(scrNTTEFullWorldEventGet("ScorpionCity"))) {
        if(_index>=0) {
            var _f=_floors[_index--]
            array_push(_out,instance_create((_f.bbox_left+_f.bbox_right)/2,(_f.bbox_top+_f.bbox_bottom)/2,BonePile))
        }
    }
    // Chance is deliberately evaluated before subarea/event exclusions.
    if(chance(2,5) && GameCont.subarea<scrAreaGetMaxSubarea(GameCont.area)
        && !instance_exists(scrNTTEFullWorldEventGet("ScorpionCity"))) {
        if(_index>=0) {
            var _f=_floors[_index--]
            array_push(_out,instance_create((_f.bbox_left+_f.bbox_right)/2,(_f.bbox_top+_f.bbox_bottom)/2-2,NTTEFullScorpionRock))
        }
    }
    return _out
}
function scrNTTEFullDesertMaggotNests() {
    var _out=[]
    if(instance_exists(scrNTTEFullWorldEventGet("MaggotPark"))) return _out
    var _nests=scrNTTEFullInstances(MaggotSpawn)
    for(var _i=0;_i<array_length(_nests);++_i) with(_nests[_i]) if(chance(1+GameCont.loops,12)) {
        array_push(_out,instance_create(x,y,NTTEFullBigMaggotSpawn));instance_destroy(id,false)
    }
    return _out
}
function scrNTTEFullDesertLevelStart() {
    if(GameCont.area!=area_desert) return;
    scrNTTEFullDesertProps()
    scrNTTEFullDesertMaggotNests()
}
function scrNTTEFullScrapyardSaws() {
    var _out=[]
    if(GameCont.subarea==3) return _out
    var _enemies=scrNTTEFullInstances(enemy),_floors=scrNTTEFullInstances(Floor,true)
    for(var _i=0;_i<array_length(_enemies);++_i) with(_enemies[_i]) if(chance(1,40) && place_meeting(x,y,Floor)) {
        var _f=scrNTTEFullWorldNearestRectBBox(x,y,x,y,_floors)
        if(instance_exists(_f)) array_push(_out,instance_create((_f.bbox_left+_f.bbox_right)/2,(_f.bbox_top+_f.bbox_bottom)/2,NTTEFullSawTrap))
    }
    return _out
}
function scrNTTEFullScrapyardCarPads() {
    var _out=[],_cars=scrNTTEFullInstances(CarVenus)
    for(var _i=0;_i<array_length(_cars);++_i) with(_cars[_i]) {
        if(place_meeting(x,y,chestprop) || place_meeting(x,y,prop)) {
            scrNTTEFullFloorSetAlign(32,32)
            var _room=scrNTTEFullFloorRoomCreate(x,y,1,1,"",random(360),0,0)
            if(is_struct(_room)) { x=_room.x;y=_room.y }
            scrNTTEFullFloorResetAlign()
        }
        var _normal=scrNTTEFullInstances(Floor,true),_older=[]
        for(var _j=0;_j<array_length(_normal);++_j) if(real(_normal[_j].id)<real(id)) array_push(_older,_normal[_j])
        var _f=scrNTTEFullWorldNearestRectBBox(x,y,x,y,_older)
        if(instance_exists(_f)) scrNTTEFullFloorSetStyle(_f.styleb,_f.area)
        array_push(_out,scrNTTEFullFloorFill(x,y,3))
        scrNTTEFullFloorResetStyle()
    }
    return _out
}
function scrNTTEFullScrapyardPool(_sx=10016,_sy=10016) {
    if(GameCont.subarea!=2) return noone
    var _out=noone
    scrNTTEFullFloorSetAlign(32,32)
    var _room=scrNTTEFullFloorRoom(_sx,_sy,96,Floor,4,4,"round",90,-32,true)
    if(is_struct(_room)) {
        repeat(3) {
            var _x=choose(_room.x1,_room.x2-32),_y=choose(_room.y1,_room.y2-32)
            if(!array_length(scrNTTEFullRectInstances(_x+16,_y+16,_x+16,_y+16,Floor,false,true))) scrNTTEFullFloorSet(_x,_y,true)
        }
        _out=instance_create(_room.x,_room.y,NTTEFullSludgePool);_out.num=3
    }
    scrNTTEFullFloorResetAlign()
    return _out
}
function scrNTTEFullScrapyardSpectators() {
    var _out=[],_walls=scrNTTEFullInstances(Wall)
    for(var _i=0;_i<array_length(_walls);++_i) with(_walls[_i]) if(chance(1,5)) {
        if(!place_meeting(x,y,PortalClear) && place_meeting(x,y,Floor))
            array_push(_out,scrNTTEFullTopCreate((bbox_left+bbox_right)/2+orandom(2),y-8+orandom(2),"TopRaven",0,0))
    }
    return _out
}
function scrNTTEFullScrapyardPelicans() {
    var _out=[]
    if(GameCont.loops<=0) return _out
    var _ravens=scrNTTEFullInstances(Raven)
    for(var _i=0;_i<array_length(_ravens);++_i) with(_ravens[_i]) if(chance(4-GameCont.subarea,12)) {
        array_push(_out,instance_create(x,y,NTTEFullPelican));instance_destroy(id,false)
    }
    return _out
}
function scrNTTEFullScrapyardLevelStart() {
    if(GameCont.area!=area_scrapyards) return;
    scrNTTEFullScrapyardSaws()
    scrNTTEFullScrapyardCarPads()
    scrNTTEFullScrapyardPool()
    scrNTTEFullScrapyardSpectators()
    scrNTTEFullScrapyardPelicans()
}
function scrNTTEFullLabsLoopSpawns() {
    var _out=[]
    if(GameCont.loops<=0) return _out
    var _types=[[Freak,5,BoneFish],[RhinoFreak,3,NTTEBat],[Ratking,5,NTTEBat],[LaserCrystal,4,NTTEFullPortalGuardian]]
    for(var _type=0;_type<array_length(_types);++_type) {
        var _row=_types[_type],_old=scrNTTEFullInstances(_row[0]),_denominator=_row[1],_object=_row[2]
        for(var _i=0;_i<array_length(_old);++_i) with(_old[_i]) if(chance(1,_denominator)) {
            array_push(_out,instance_create(x,y,_object));instance_destroy(id,false)
        }
    }
    return _out
}
function scrNTTEFullLabsChambers(_sx=10016,_sy=10016) {
    var _out=[],_floors=scrNTTEFullInstances(Floor,true)
    for(var _i=0;_i<array_length(_floors);++_i) with(_floors[_i]) if(chance(1+GameCont.loops,60+GameCont.loops)) {
        if(place_free(x,y) && point_distance((bbox_left+bbox_right)/2,(bbox_top+bbox_bottom)/2,_sx,_sy)>128)
            array_push(_out,instance_create((bbox_left+bbox_right)/2,(bbox_top+bbox_bottom)/2,NTTEFullFreakChamber))
    }
    return _out
}
function scrNTTEFullLabsLevelStart() {
    if(GameCont.area!=area_labs) return;
    scrNTTEFullLabsLoopSpawns()
    scrNTTEFullLabsChambers()
}

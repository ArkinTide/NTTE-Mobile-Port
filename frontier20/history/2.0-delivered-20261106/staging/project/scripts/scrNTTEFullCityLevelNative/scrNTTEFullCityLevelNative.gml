// ntte.mod.gml1173..1234. Original city natural rooms and loop species.
function scrNTTEFullCityIgloos(_sx=10016,_sy=10016) {
    var _out=[]
    if(!chance(1,GameCont.subarea)) return _out
    var _oldFloors=scrNTTEFullInstances(Floor)
    scrNTTEFullFloorSetAlign(32,32)
    repeat(irandom_range(1,3)) {
        var _distance=choose(0,-32),_room=scrNTTEFullFloorRoom(_sx,_sy,64,Floor,3,3,"",[30,90],_distance,true)
        if(is_struct(_room)) array_push(_out,instance_create(_room.x,_room.y,NTTEFullIgloo))
    }
    scrNTTEFullFloorResetAlign()
    var _floors=scrNTTEFullInstances(Floor)
    for(var _i=0;_i<array_length(_floors);++_i) if(array_get_index(_oldFloors,_floors[_i])<0) with(_floors[_i]) {
        if(!place_meeting(x-32,y,Floor) && !place_meeting(x,y-32,Floor) && !place_meeting(x,y,hitme) && !place_meeting(x,y,chestprop)) instance_create(x,y,Wall)
        if(!place_meeting(x+32,y,Floor) && !place_meeting(x,y-32,Floor) && !place_meeting(x,y,hitme) && !place_meeting(x,y,chestprop)) instance_create(x+16,y,Wall)
        if(!place_meeting(x-32,y,Floor) && !place_meeting(x,y+32,Floor) && !place_meeting(x,y,hitme) && !place_meeting(x,y,chestprop)) instance_create(x,y+16,Wall)
        if(!place_meeting(x+32,y,Floor) && !place_meeting(x,y+32,Floor) && !place_meeting(x,y,hitme) && !place_meeting(x,y,chestprop)) instance_create(x+16,y+16,Wall)
    }
    return _out
}
function scrNTTEFullCitySawTraps() {
    var _out=[]
    if(GameCont.loops<=0) return _out
    var _tanks=scrNTTEFullInstances(SnowTank)
    for(var _i=0;_i<array_length(_tanks);++_i) with(_tanks[_i]) if(chance(1,4))
        array_push(_out,instance_create(x,y,NTTEFullSawTrap))
    // Source SnowTank is retained underneath its additional saw.
    return _out
}
function scrNTTEFullCityNecroCats() {
    var _out=[]
    if(GameCont.loops<=0) return _out
    var _necros=scrNTTEFullInstances(Necromancer)
    for(var _i=0;_i<array_length(_necros);++_i) with(_necros[_i]) if(chance(1,2)) {
        array_push(_out,instance_create(x,y,NTTECat));instance_destroy(id,false)
    }
    return _out
}
function scrNTTEFullCityWolfCats() {
    var _out=[],_wolves=scrNTTEFullInstances(Wolf)
    for(var _i=0;_i<array_length(_wolves);++_i) with(_wolves[_i]) if(chance(1,GameCont.loops>0 ? 5:200)) {
        var _cat=instance_create(x,y,NTTECat)
        _cat.ntte_cat_sit=id;_cat.depth=depth-1
        array_push(_out,_cat)
    }
    return _out
}
function scrNTTEFullCityLevelStart() {
    if(GameCont.area!=area_city) return;
    scrNTTEFullCityIgloos()
    scrNTTEFullCitySawTraps()
    scrNTTEFullCityNecroCats()
    scrNTTEFullCityWolfCats()
}
function scrNTTEFullCityCatEnemySeatStep() {
    if(!instance_exists(ntte_cat_sit) || !instance_is(ntte_cat_sit,enemy)) return false
    if(position_meeting(ntte_cat_sit.x,ntte_cat_sit.y,Wall)) { scrNTTECatStand();return false }
    // Unlike furniture, a Cat on a Wolf stays at its actual position and
    // suppresses the Wolf's shooting alarm. Draw/fire uses its bbox top.
    x=ntte_cat_sit.x;y=ntte_cat_sit.y;xprevious=x;yprevious=y
    ntte_cat_sit.alarm[1]=max(ntte_cat_sit.alarm[1],30)
    return true
}
function scrNTTEFullCityCatEnemySeatDraw() {
    if(!instance_exists(ntte_cat_sit) || !instance_is(ntte_cat_sit,enemy)) return false
    var _x=x,_y=y
    x=ntte_cat_sit.x;y=ntte_cat_sit.bbox_top
    if(gunangle>180) draw_sprite_ext(sprite_index,image_index,x,y,right,1,0,image_blend,image_alpha)
    draw_sprite_ext(spr_weap,0,x+lengthdir_x(-wkick,gunangle),y+lengthdir_y(-wkick,gunangle),1,right,gunangle,image_blend,image_alpha)
    if(gunangle<=180) draw_sprite_ext(sprite_index,image_index,x,y,right,1,0,image_blend,image_alpha)
    x=_x;y=_y
    return true
}

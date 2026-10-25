// ntte.mod1256..1434. Natural Palace third-area stairs precede the guarded
// artifact room; actual base/loop enemies follow it. Keep JungleBandit alive.
function scrNTTEFullPalaceFloorNearest(_x,_y,_floors) {
    var _near=noone,_distance=infinity
    for(var _i=0;_i<array_length(_floors);++_i) if(instance_exists(_floors[_i])) {
        var _f=_floors[_i],_d=point_distance(_x,_y,_f.x,_f.y)
        if(_d<_distance) { _near=_f;_distance=_d }
    }
    return _near
}
function scrNTTEFullPalaceNaturalStairs() {
    var _out=[]
    if(GameCont.subarea!=3) return _out
    var _carpets=scrNTTEFullInstances(Carpet)
    for(var _c=0;_c<array_length(_carpets);++_c) with(_carpets[_c]) if(sprite_index==sprCarpet) {
        var _x1=x-128,_x2=x+128,_y1=bbox_top+128,_y2=10016,
            _sprite=scrNTTERefSprite("FloorPalaceStairs"),_number=sprite_get_number(_sprite),_floors=scrNTTEFullInstances(Floor,true)
        for(var _y=_y1;_y<_y2;_y+=368) {
            var _near=scrNTTEFullPalaceFloorNearest(_x1,_y,_floors)
            if(!instance_exists(_near)) continue
            var _stair=instance_create(_near.x,_near.y+32-5,NTTEFullPalaceStairs)
            _stair.image_xscale=(_x2-_x1)/32;array_push(_out,_stair)
            for(var _image=0;_image<_number;++_image) {
                var _row=scrNTTEFullRectInstances(_x1,_near.y+32*_image,_x2,_near.y+32*(_image+1)-1,_floors)
                for(var _i=0;_i<array_length(_row);++_i) with(_row[_i]) {
                    sprite_index=_sprite;image_index=_image;depth=8
                    if(place_meeting(x,y,Carpet)) {
                        sprite_index=scrNTTERefSprite("FloorPalaceStairsCarpet");image_index*=2
                        if((bbox_left+bbox_right)/2>(_x1+_x2)/2) { image_index++ }
                    }
                }
            }
        }
        depth=9
    }
    return _out
}
function scrNTTEFullPalaceGuardians() {
    var _out=[],_old=scrNTTEFullInstances(Guardian)
    for(var _i=0;_i<array_length(_old);++_i) with(_old[_i]) if(chance(1,20)) {
        array_push(_out,instance_create(x,y,NTTEFullPortalGuardian));instance_destroy(id,false)
    }
    return _out
}
function scrNTTEFullPalaceGulls() {
    var _out=[]
    if(GameCont.loops<=0) return _out
    var _old=scrNTTEFullInstances(JungleBandit)
    for(var _i=0;_i<array_length(_old);++_i) with(_old[_i]) {
        repeat(chance(1,5)?5:1) array_push(_out,instance_create(x,y,NTTEFullGull))
        // The original retains and moves the original JungleBandit onto wall.
        scrNTTEFullTopCreate(x,y,id,-1,-1)
    }
    return _out
}
function scrNTTEFullPalaceExploGuardians() {
    var _out=[]
    if(GameCont.loops<=0) return _out
    var _old=scrNTTEFullInstances(ExploGuardian)
    for(var _i=0;_i<array_length(_old);++_i) with(_old[_i]) if(chance(1,10)) {
        array_push(_out,instance_create(x,y,NTTEFullPortalGuardian));instance_destroy(id,false)
    }
    return _out
}
function scrNTTEFullPalaceLevelStart() {
    if(GameCont.area!=area_palace) return;
    if(GameCont.subarea==3) {
        scrNTTEFullPalaceNaturalStairs()
        scrNTTEFullQuestPalaceGenerate()
    }
    scrNTTEFullPalaceGuardians()
    scrNTTEFullPalaceGulls()
    scrNTTEFullPalaceExploGuardians()
}

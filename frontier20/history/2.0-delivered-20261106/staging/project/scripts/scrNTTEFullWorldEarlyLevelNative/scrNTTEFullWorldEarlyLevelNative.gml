// ntte350..390; separate exits preserve intervening source Manhole ordering.
function scrNTTEFullBigBanditDebtLevelStart() {
    if(GameCont.area==area_desert) {
        var _spawns=scrNTTEFullInstances(WantBoss)
        for(var _i=0;_i<array_length(_spawns);++_i) {
            var _want=_spawns[_i]
            if(!is_undefined(scrNTTEFullValue(_want,"ntte_bigbandit_spawn",undefined))) continue
            _want.ntte_bigbandit_spawn=scrNTTEFullValue(GameCont,"ntte_bigbandit_spawn",0)
            if(_want.ntte_bigbandit_spawn!=0) {
                _want.number-=_want.ntte_bigbandit_spawn
                if(_want.number==0) instance_destroy(_want)
            }
        }
    }
    else if(!scrNTTEFullWorldAreaSecret(GameCont.area)) GameCont.ntte_bigbandit_spawn=0
}
function scrNTTEFullFlavorCactusLevelStart() {
    // Original area_get_subarea ignores custom game area-size settings.
    var _info=scrNTTEFullAreaInfo(GameCont.area),_subareas=1
    if(!is_undefined(_info)) _subareas=_info.subareas
    else if(GameCont.area==area_hq || (GameCont.area<100 && GameCont.area%2!=0)) _subareas=3
    if(!chance(1,3*_subareas)) return noone
    var _list=scrNTTEFullInstances([Cactus,NightCactus])
    if(!array_length(_list)) return noone
    var _old=_list[irandom(array_length(_list)-1)],_new=instance_create(_old.x,_old.y,NTTEFullBigCactus)
    instance_destroy(_old,false)
    return _new
}
function scrNTTEFullCrystalBabiesLevelStart() {
    var _out=[]
    if(!instance_exists(Spider) && !instance_exists(InvSpider)) return _out
    // Epsilon combines the original CrystalProp/InvCrystal objects as Crystal.
    var _crystals=scrNTTEFullInstances(Crystal)
    for(var _i=0;_i<array_length(_crystals);++_i) with(_crystals[_i]) {
        if(place_meeting(x,y,Floor) && !place_meeting(x,y,Wall)) {
            repeat(irandom_range(1,3)) array_push(_out,instance_create(x,y,NTTEFullSpiderling))
        }
    }
    return _out
}

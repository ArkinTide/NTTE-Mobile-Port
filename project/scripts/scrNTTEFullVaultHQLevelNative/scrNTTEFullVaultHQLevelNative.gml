// ntte1409..1752,1781..1855. Natural CrownVault/HQ source provider.
function scrNTTEFullVaultFlowerRooms() {
    var _out=[]
    if(!scrNTTEFullValue(GameCont,"ntte_vault_flower",true)) return _out
    var _peds=scrNTTEFullInstances(CrownPed)
    for(var _i=0;_i<array_length(_peds);++_i) {
        var _ped=_peds[_i]
        scrNTTEFullFloorSetAlign(32,32)
        try {
            var _room=scrNTTEFullFloorRoomCreate(_ped.x,_ped.y,3,3,"",random(360),90,0)
            if(is_struct(_room)) {
                for(var _j=0;_j<array_length(_room.floors);++_j) if(instance_exists(_room.floors[_j])) {
                    var _floor=_room.floors[_j]
                    _floor.sprite_index=scrNTTERefSprite("VaultFlowerFloor");_floor.image_index=_j;_floor.depth=7
                }
                var _flower=instance_create(_room.x,_room.y-8,NTTEFullVaultFlower),_light=instance_create(_flower.x,_flower.y,LightBeam)
                _light.sprite_index=sprLightBeamVault
                array_push(_out,{room:_room,flower:_flower,light:_light})
            }
        }
        finally { scrNTTEFullFloorResetAlign() }
    }
    return _out
}
function scrNTTEFullVaultHQLevelStart() {
    if(GameCont.area==area_vault) {
        var _flowers=scrNTTEFullVaultFlowerRooms(),_quest=scrNTTEFullQuestVaultGenerate(10016,10016)
        return {flowers:_flowers,quest:_quest}
    }
    if(GameCont.area==area_hq) return scrNTTEFullQuestHQGenerate(10016,10016,GameCont.subarea)
    return undefined
}

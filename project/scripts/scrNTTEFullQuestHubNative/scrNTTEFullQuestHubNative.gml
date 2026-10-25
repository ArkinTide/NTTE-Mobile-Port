// ntte.mod1445..1748. Crown-vault Ancient acquisition OR exact three-room
// teleporter chain,3x14 hall, lore/artifact floors, source props and reward hub.
function scrNTTEFullQuestSpawnedInit() {
    if(!is_array(scrNTTEFullValue(GameCont,"ntte_quest_spawned_part_index_list",undefined))) GameCont.ntte_quest_spawned_part_index_list=[]
}
function scrNTTEFullQuestArtifactAvailable(_part) {
    scrNTTEFullQuestSpawnedInit()
    return !scrNTTEFullUnlockGet("quest:part:"+string(_part))
        && array_get_index(GameCont.ntte_quest_spawned_part_index_list,_part)<0
}
function scrNTTEFullQuestArtifactChest(_x,_y,_part) {
    var _chest=scrNTTEFullLairChestCreate(_x,_y,"QuestChest",true)
    // Source chest_create can apply Crown of Love's real substitution. Keep
    // that provider, but never write weapon fields on a substituted ammo chest.
    if(instance_exists(_chest) && instance_is(_chest,NTTEFullQuestChest)) _chest.wep=scrNTTEFullCrabboneCreateModel(_part)
// BEGIN NTTE PALACE ARTIFACT CONTINUE TEST FACTORY
if(os_type==os_windows && scrNTTEFullSmokeEnabled() && instance_exists(NTTEFullPalaceArtifactContinueTest)) try { scrNTTEFullPalaceArtifactContinueFactory(_chest,_part); }
catch(_ntte_palace_artifact_error) { scrNTTEFullPalaceArtifactContinueAbort(_ntte_palace_artifact_error); }
// END NTTE PALACE ARTIFACT CONTINUE TEST FACTORY
// BEGIN NTTE PALACE ARTIFACT PORTAL CARRY TEST FACTORY
if(os_type==os_windows && scrNTTEFullSmokeEnabled() && instance_exists(NTTEFullPalaceArtifactPortalCarryTest)) try { scrNTTEFullPalaceArtifactPortalCarryFactory(_chest,_part); }
catch(_ntte_palace_carry_error) { scrNTTEFullPalaceArtifactPortalCarryAbort(_ntte_palace_carry_error); }
// END NTTE PALACE ARTIFACT PORTAL CARRY TEST FACTORY
    return _chest
}
function scrNTTEFullQuestTeleporterPair(_tx,_ty,_fx,_fy) {
    var _to=scrNTTEFullFloorSet(_tx-16,_ty-16,true),_from=scrNTTEFullFloorSet(_fx-16,_fy-16,true)
    if(!instance_exists(_to) || !instance_exists(_from)) throw "NTTE source hub teleporter requires two actual native Floors"
    _to.sprite_index=scrNTTERefSprite("QuestTeleporterFloor");_from.sprite_index=_to.sprite_index
    _tx=(_to.bbox_left+_to.bbox_right)/2;_ty=(_to.bbox_top+_to.bbox_bottom)/2
    _fx=(_from.bbox_left+_from.bbox_right)/2;_fy=(_from.bbox_top+_from.bbox_bottom)/2
    var _a=instance_create(_tx,_ty,NTTEFullQuestTeleporterPad),_b=instance_create(_fx,_fy,NTTEFullQuestTeleporterPad)
    _a.target=_to;_a.teleport_x=_fx;_a.teleport_y=_fy
    _b.target=_from;_b.teleport_x=_tx;_b.teleport_y=_ty
    return [_a,_b]
}
function scrNTTEFullQuestHubMain(_room) {
    var _mainX=_room.x,_mainY=_room.y1+80,_propX=_room.x,_propY=_mainY+192,
        _chestX=_room.x,_chestY=_room.y1-16,_side=choose(-1,1),
        _propFloors=scrNTTEFullFloorFill(_propX,_propY,5,5)
    for(var _i=0;_i<5;++_i) repeat(2) {
        var _py=round(_propY+orandom(2)+64*lerp(1,-1,clamp((_i+orandom(0.05))/4,0,1)))
        if(_i!=2) scrNTTEFullWorldCreateRequired("QuestPillar",round(_propX+(64+random_range(-1,1))*_side),_py)
        else instance_create(_propX+72*_side-8,round(_py/16)*16-8,Wall)
        _side*=-1
    }
    for(var _i=0;_i<array_length(_propFloors);++_i) if(instance_exists(_propFloors[_i])) with(_propFloors[_i]) {
        if(place_meeting(x,y,prop) && !place_meeting(x,y,Wall)) {
            sprite_index=scrNTTERefSprite("VaultFlowerFloor");image_index=choose(0,2,4,6,8);image_blend=make_color_hsv(0,0,192+orandom(8))
        }
    }
    scrNTTEFullWorldCreateRequired("QuestTorch",_propX+48,_propY)
    scrNTTEFullWorldCreateRequired("QuestTorch",_propX-48,_propY)
    scrNTTEFullWorldCreateRequired("QuestTorch",_room.x1+16,_room.y2-16)
    scrNTTEFullWorldCreateRequired("QuestTorch",_room.x2-16,_room.y2-16)
    var _mainFloors=scrNTTEFullFloorFill(_mainX,_mainY,5,5)
    for(var _side=-1;_side<=1;_side+=2) {
        var _ox=64*_side
        scrNTTEFullWorldCreateRequired("QuestTorch",_mainX+_ox,_mainY-64)
        instance_create(_mainX+_ox+(_side>0?-16:0),_mainY+48,Wall)
    }
    for(var _i=0;_i<array_length(_mainFloors);++_i) if(instance_exists(_mainFloors[_i])) with(_mainFloors[_i])
        if(place_meeting(x,y,prop) || place_meeting(x,y,Wall)) image_blend=make_color_hsv(0,0,192+orandom(8))
    scrNTTEFullFloorFill(_mainX,_mainY,9,3)
    var _controllers=[],_stored=[]
    for(var _part=0;_part<4;++_part) {
        var _floor=scrNTTEFullFloorSet(_mainX+96*lerp(-1,1,_part/3)-16,_mainY-16,true)
        _floor.sprite_index=scrNTTERefSprite("QuestFloor");_floor.image_index=_part
        var _cont=instance_create((_floor.bbox_left+_floor.bbox_right)/2,(_floor.bbox_top+_floor.bbox_bottom)/2,NTTEFullQuestFloorCont)
        _cont.part_index=_part;_cont.target=_floor;array_push(_controllers,_cont)
        if(scrNTTEFullUnlockGet("quest:part:"+string(_part))) {
            scrNTTEFullQuestSpawnedInit();array_push(GameCont.ntte_quest_spawned_part_index_list,_part)
            var _pickup=scrWeaponPickupCreate(_cont.x,_cont.y,scrNTTEFullCrabboneCreateModel(_part))
            array_push(_stored,_pickup)
        }
    }
    var _chest=noone
    if(!scrNTTEFullUnlockGet("race:beetle")) {
        var _floors=scrNTTEFullFloorFill(_chestX,_chestY,3,3),_image=0
        for(var _i=0;_i<array_length(_floors);++_i) if(instance_exists(_floors[_i])) {
            _floors[_i].sprite_index=scrNTTERefSprite("VaultFlowerFloor");_floors[_i].image_index=_image;_floors[_i].depth=7;_image+=1
        }
        _chest=instance_create(_chestX,_chestY,NTTEFullLockedHugeQuestChest)
    }
    return {controllers:_controllers,stored:_stored,chest:_chest}
}
function scrNTTEFullQuestHubCreate(_spawnX,_spawnY) {
    var _start=scrNTTEFullFloorRoom(_spawnX,_spawnY,96,Floor,1,1,"",0,0)
    if(!is_struct(_start)) return noone
    var _rx=_start.x,_ry=_start.y,_rooms=[
        {width:irandom_range(1,3),height:irandom_range(1,3),direction:point_direction(_start.xstart,_start.ystart,_rx,_ry)},
        {width:irandom_range(1,3),height:irandom_range(1,3),direction:undefined},
        {width:3,height:14,direction:90}],_closets=[],_generated=[],_pads=[],_main=noone
    for(var _i=0;_i<array_length(_rooms);++_i) {
        var _spec=_rooms[_i]
        if(is_undefined(_spec.direction)) {
            var _dirs=[],_last=_rooms[_i-1].direction,_next=_rooms[_i+1].direction
            for(var _off=-90;_off<=90;_off+=90) if(angle_difference(_last+_off,_next+180)!=0) array_push(_dirs,_last+_off)
            _spec.direction=_dirs[irandom(array_length(_dirs)-1)]
        }
        var _room=scrNTTEFullFloorRoomCreate(_rx,_ry,_spec.width,_spec.height,"",_spec.direction,30,224)
        array_push(_generated,_room)
        var _tx=_rx,_ty=_ry,_fx=_room.x,_fy=_room.y2-16
        if(_i!=0) {
            do { _tx+=lengthdir_x(32,_spec.direction);_ty+=lengthdir_y(32,_spec.direction) }
            until(array_length(scrNTTEFullRectInstances(_tx-16,_ty-16,_tx+16,_ty+16,NTTEFullQuestTeleporterPad))<=0)
        }
        if(_i!=array_length(_rooms)-1) {
            _fx=_room.x;_fy=_room.y
            do { _fx-=lengthdir_x(32,_spec.direction);_fy-=lengthdir_y(32,_spec.direction) }
            until(array_length(scrNTTEFullRectInstances(_fx-16,_fy-16,_fx+16,_fy+16,NTTEFullQuestTeleporterPad))<=0)
        }
        _pads=array_concat(_pads,scrNTTEFullQuestTeleporterPair(_tx,_ty,_fx,_fy))
        if(_i<array_length(_rooms)-1) {
            var _list=[];array_copy(_list,0,_room.floors,0,array_length(_room.floors))
            for(var _j=0;_j<array_length(_room.floors);++_j) if(instance_exists(_room.floors[_j]) && random(4)<1) {
                var _dir=round(random(360)/90)*90,_floorX=_room.floors[_j].x+lengthdir_x(32,_dir),_floorY=_room.floors[_j].y+lengthdir_y(32,_dir)
                if(!position_meeting(_floorX,_floorY,Floor)) array_push(_list,scrNTTEFullFloorSet(_floorX,_floorY,true))
            }
            array_push(_closets,_list)
        }
        else _main=scrNTTEFullQuestHubMain(_room)
        _rx=_room.x;_ry=_room.y
    }
    for(var _i=0;_i<array_length(_closets);++_i) {
        var _floors=[]
        for(var _j=0;_j<array_length(_closets[_i]);++_j) if(instance_exists(_closets[_i][_j])) array_push(_floors,_closets[_i][_j])
        var _num=irandom_range(1,array_length(_floors)-2)
        if(_num>0) {
            _floors=array_shuffle(_floors)
            for(var _j=0;_j<array_length(_floors);++_j) {
                var _floor=_floors[_j]
                scrNTTEFullWorldCreateRequired(random(4)<1?"QuestTorch":"QuestPillar",round((_floor.bbox_left+_floor.bbox_right)/2+orandom(2)),round((_floor.bbox_top+_floor.bbox_bottom)/2+orandom(2)))
                _num-=1;if(_num<=0) break
            }
        }
    }
    return {mode:"hub",start:_start,rooms:_generated,pads:_pads,main:_main}
}
function scrNTTEFullQuestVaultAtPedestal(_ped,_spawnX,_spawnY) {
    if(!instance_exists(_ped)) return noone
    scrNTTEFullFloorSetAlign(32,32)
    try {
        if(GameCont.proto && scrNTTEFullQuestArtifactAvailable(0)) {
            array_push(GameCont.ntte_quest_spawned_part_index_list,0)
            var _room=scrNTTEFullFloorRoomCreate(_ped.x,_ped.y,2,2,"",random(360),90,0),_chest=noone
            if(is_struct(_room)) {
                _chest=scrNTTEFullQuestArtifactChest(_room.x,_room.y,0)
                var _image=0
                for(var _i=0;_i<array_length(_room.floors);++_i) if(instance_exists(_room.floors[_i])) {
                    _room.floors[_i].sprite_index=scrNTTERefSprite("VaultFlowerFloorSmall");_room.floors[_i].image_index=_image;_room.floors[_i].depth=7;_image+=1
                }
            }
            return {mode:"ancient",room:_room,chest:_chest}
        }
        return scrNTTEFullQuestHubCreate(_spawnX,_spawnY)
    }
    finally { scrNTTEFullFloorResetAlign() }
}
function scrNTTEFullQuestVaultGenerate(_spawnX,_spawnY) {
    var _peds=scrNTTEFullInstances(CrownPed),_out=[]
    for(var _i=0;_i<array_length(_peds);++_i) array_push(_out,scrNTTEFullQuestVaultAtPedestal(_peds[_i],_spawnX,_spawnY))
    return _out
}

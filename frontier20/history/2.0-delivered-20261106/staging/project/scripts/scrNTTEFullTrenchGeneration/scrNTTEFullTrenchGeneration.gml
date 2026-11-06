// NTT BBOX NORMALIZED: source inclusive right/bottom = modern runner edge-1.
// areas/trench callbacks. Native hook points are installed centrally by root.
// These adapters alone do not expose an unfinished area in normal progression.
function scrNTTEFullTrenchMakeFloor() {
    // Native scrMakeFloor advances its FloorMaker32px before dispatch.
    var _px=x,_py=y,_out=point_distance(x,y,10000,10000)>48
    styleb=false
    if (_out) {
        var _land=0,_pits=scrNTTERefSprite("FloorTrenchB")
        with (Floor) if (sprite_index!=_pits) _land+=1
        if (_land>=(1-GameCont.subarea*0.25)*GenCont.goal) styleb=true
    }
    if (random(7)<1 && _out) {
        var _width=irandom_range(3,5)
        scrNTTEFullFloorSetStyle(styleb)
        scrNTTEFullFloorFill(_px+16,_py+16,_width,8-_width)
        scrNTTEFullFloorResetStyle()
    }
    instance_create(_px,_py,Floor)
    var _turn=0
    if (random(7)<3) _turn=choose(90,-90,180)
    direction+=_turn
    if (_out && _turn==180) instance_create(_px+16,_py+16,WeaponChest)
    if (random(19+instance_number(FloorMaker))>=22) {
        if (_out) instance_create(_px+16,_py+16,AmmoChest)
        instance_destroy()
    }
    else if (random(5)<1) instance_create(_px,_py,FloorMaker)
    with (GenCont) if (instance_number(Floor)>goal && GameCont.subarea==2 && GameCont.crownvisits<3) {
        var _far=instance_furthest(10000,10000,Floor)
        if (instance_exists(_far)) {
            var _floor=instance_nearest((_far.x*2+10000)/3+orandom(64),(_far.y*2+10000)/3+orandom(64),Floor)
            instance_create(_floor.x+16,_floor.y+16,ProtoStatue)
        }
    }
}

function scrNTTEFullTrenchPopEnemies() {
    var _px=x+16,_py=y+16
    if (GameCont.loops>0 && random(styleb ? 16:6)<1) {
        if (styleb) instance_create(_px,_py,LightningCrystal)
        else instance_create(_px,_py,random(4)<1 ? FireBaller:NTTEFullCrystalBat)
    }
    else if (!styleb && random(15)<1) instance_create(_px+orandom(4),_py+orandom(4),NTTEFullAngler)
    else if (random(9)<1) {
        if (random(100)<5*(GameCont.loops+1)) {
            instance_create(_px,_py,NTTEFullJellyElite)
            repeat(3) instance_create(_px,_py,NTTEFullEel)
        }
        else { instance_create(_px,_py,NTTEFullJelly); instance_create(_px,_py,NTTEFullEel) }
    }
    else if (random(6)<1) instance_create(_px,_py,NTTEFullEel)
}

function scrNTTEFullTrenchPopProps() {
    if (random(styleb ? 3:12)<1 && point_distance(x,y,10000,10000)>96
        && !place_meeting(x,y,NOWALLSHEREPLEASE) && !place_meeting(x,y,hitme)) {
        instance_create(x+choose(0,16),y+choose(0,16),Wall); instance_create(x,y,NOWALLSHEREPLEASE)
    }
    else if (random(16)<1 && !styleb) {
        var _px=x+16,_py=y+16
        if (point_distance(_px,_py,10016,10016)>48) {
            if (random(10)<1) instance_create(_px,_py,NTTEFullEelSkull)
            else instance_create(_px+orandom(8),_py+orandom(8),choose(NTTEFullKelp,NTTEFullKelp,NTTEFullVent))
        }
    }
    if (random(80)<1) {
        var _top=instance_create(x+16,y+16,TopPot)
        _top.sprite_index=scrNTTERefSprite("TopDecalTrench"); _top.image_speed=0; _top.image_index=irandom(_top.image_number-1)
        if (random(6)<1 && point_distance(_top.x,_top.y,10016,10016)>128) {
            _top.sprite_index=scrNTTERefSprite("TopDecalTrenchMine")
            var _mine=instance_create(_top.x,_top.y,NTTEFullTopDecalWaterMine); _mine.creator=_top
        }
    }
}

function scrNTTEFullTrenchPopExtras() {
    with (chestprop) if (instance_is(id,WeaponChest) || instance_is(id,AmmoChest)) instance_create(x,y,NTTEFullDiver)
    with (RadChest) instance_create(x,y,NTTEFullDiver)
    with (Bandit) { instance_create(x,y,NTTEFullDiver); instance_destroy(id,false) }
    // Original iterates Eels while replacing until the live count is at cap.
    with (NTTEFullEel) {
        if (instance_number(NTTEFullEel)<=8+4*GameCont.loops) break
        instance_create(x,y,NTTEFullWantEel); instance_destroy(id,false)
    }
}

function scrNTTEFullTrenchStart() {
    GameCont.ntte_active_trench=true
    GameCont.ntte_full_active_trench=true
    scrNTTEFullTrenchPitRebuild()
    if (!instance_exists(NTTEFullPitRenderer)) instance_create(0,0,NTTEFullPitRenderer)
    var _big=[]
    with (RadChest) if (spr_idle==sprRadChestBig) array_push(_big,id)
    // Native Epsilon names the carried rad-chest count `noradch` (the NTTE
    // source refers to this field as `norads`).
    if (array_length(_big)>0 && GameCont.noradch>=1) {
        var _chest=_big[irandom(array_length(_big)-1)],_cx=_chest.x,_cy=_chest.y,
            _pits=scrNTTERefSprite("FloorTrenchB"),_land=[]
        GameCont.noradch=0
        with (Floor) if (sprite_index==_pits && point_distance((bbox_left+(bbox_right-1)+1)/2,(bbox_top+(bbox_bottom-1)+1)/2,_cx,_cy)<random_range(64,96)) array_push(_land,id)
        scrNTTEFullFloorSetStyle(false)
        for(var _i=0;_i<array_length(_land);++_i) if (instance_exists(_land[_i])) scrNTTEFullFloorSet(_land[_i].x,_land[_i].y,true)
        scrNTTEFullFloorResetStyle()
        instance_create(_cx,_cy,NTTEFullAnglerGold); instance_destroy(_chest,false)
    }
    if (GameCont.subarea==3) {
        var _floors=scrNTTEFullInstances(Floor)
        if (array_length(_floors)>0) {
            var _floor=_floors[irandom(array_length(_floors)-1)]
            var _octo=scrNTTEFullPetCreate((_floor.bbox_left+_floor.bbox_right)/2,(_floor.bbox_top+_floor.bbox_bottom)/2,"Octo")
            _octo.hiding=true
        }
        instance_create(10016+orandom(8),10016+random(8),NTTEFullPitSquid)
    }
    with (prop) if (size<=2 && !instance_is(id,RadChest) && scrNTTEFullTrenchPitGet(x,y)) {
        var _land=[]
        with (Floor) if (object_index==Floor) array_push(_land,id)
        _land=array_shuffle(_land)
        var _prop=id
        for(var _i=0;_i<array_length(_land);++_i) {
            var _floor=_land[_i],_cx=(_floor.bbox_left+_floor.bbox_right)/2,_cy=(_floor.bbox_top+_floor.bbox_bottom)/2,_can=false
            with(_floor) _can=distance_to_object(Player)>48 && !place_meeting(x,y,Wall) && !scrNTTEFullTrenchPitGet(_cx,_cy)
            if(_can) {_prop.x=_cx;_prop.y=_cy;break}
        }
    }
}

function scrNTTEFullTrenchFinish() {
    GameCont.ntte_visits_trench=scrNTTEFullValue(GameCont,"ntte_visits_trench",scrNTTEFullValue(GameCont,"ntte_full_visits_trench",0))+1
    GameCont.ntte_full_visits_trench=GameCont.ntte_visits_trench
    if (GameCont.subarea<3) GameCont.subarea+=1
    else {
        GameCont.area=area_city; GameCont.subarea=1
        // Original player_get_race queries selected player slots, including
        // a player who died before the remaining player reached this exit.
        for(var _slot=0;_slot<player_count;++_slot) {
            var _player=scr_playerinstance_find(_slot)
            if(is_struct(_player) && scrNTTEFullRaceKey(_player.race)=="parrot") {
                scrNTTEFullUnlockSet("skin:parrot:1",true);break
            }
        }
    }
}

function scrNTTEFullTrenchTransit() {
    GameCont.ntte_active_trench=false
    GameCont.ntte_full_active_trench=false
    scrNTTEFullTrenchPitReset(false)
}

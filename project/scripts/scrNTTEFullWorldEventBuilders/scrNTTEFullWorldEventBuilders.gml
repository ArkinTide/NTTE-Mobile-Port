// Complete create-only original events. Lifecycle manager owns eligibility and
// registration; these builders do not substitute rooms for other events.
function scrNTTEFullWorldCreateRequired(_name,_x,_y) {
    var _object=asset_get_index("NTTEFull"+_name)
    if (!object_exists(_object)) { show_error("Original NTTE entity has not been ported: "+_name,true); return noone }
    return instance_create(_x,_y,_object)
}

function scrNTTEFullBanditCampEvent(_spawnx,_spawny,_park=false,_city=false) {
    scrNTTEFullFloorSetAlign(32,32)
    var _room=scrNTTEFullFloorRoom(_spawnx,_spawny,128,Floor,5,4,"",30,-32)
    if (is_struct(_room)) {
        var _cx=_room.x,_cy=_room.y
        var _fire=instance_create(_cx,_cy,NTTEFullWorldEffect)
        _fire.sprite_index=scrNTTERefSprite("BanditCampfire"); _fire.image_xscale=choose(-1,1); _fire.depth=8
        var _flame=instance_create(_cx,_cy-2,GroundFlame); _flame.alarm[0]*=4
        var _angle=random(360),_chests=[],_all=scrNTTEFullInstances([chestprop,RadChest])
        for(var _i=0;_i<array_length(_all);++_i) with (_all[_i]) {
            if (object_index!=RadMaggotChest && place_meeting(x,y,Floor) && !place_meeting(x,y,Wall) && !position_meeting(x,y,PortalClear)) array_push(_chests,id)
        }
        for(var _dir=_angle;_dir<_angle+360;_dir+=120) {
            var _d=_dir+orandom(10),_tent=instance_create(_cx+lengthdir_x(40,_d),_cy+lengthdir_y(40,_d),NTTEFullBanditTent)
            var _near=noone,_best=infinity,_at=-1
            for(var _i=0;_i<array_length(_chests);++_i) {
                var _chest=_chests[_i],_dis=point_distance(_tent.x,_tent.y,_chest.x,_chest.y)
                if (_dis<_best) { _best=_dis; _near=_chest; _at=_i }
            }
            _tent.target=_near
            if (_at>=0) array_delete(_chests,_at,1)
            with (_tent) scrNTTEFullBanditTentStep()
        }
        instance_create(_cx,_cy,NTTEFullBanditHiker)
        var _maggots=scrNTTEFullInstances([MaggotSpawn,BigMaggot])
        for(var _i=0;_i<array_length(_maggots);++_i) with (_maggots[_i]) {
            if (random(point_distance(x,y,_cx,_cy)/(_park ? 64:160))<1) instance_destroy(id,false)
        }
        var _scorps=scrNTTEFullInstances([Scorpion,GoldScorpion])
        for(var _i=0;_i<array_length(_scorps);++_i) with (_scorps[_i]) {
            if (random(point_distance(x,y,_cx,_cy)/(_city ? 32:160))<1) instance_destroy(id,false)
        }
        var _floors=array_shuffle(scrNTTEFullInstances(Floor,true))
        for(var _i=0;_i<array_length(_floors);++_i) with (_floors[_i]) {
            if (styleb || random(point_distance(x,y,_cx,_cy)/24)>=1) continue
            if (place_meeting(x,y,Wall) || place_meeting(x,y,hitme)) continue
            var _fx=(bbox_left+bbox_right)/2,_fy=(bbox_top+bbox_bottom)/2,_fw=bbox_right-bbox_left
            if (point_distance(_fx,_fy,_spawnx,_spawny)<=64) continue
            var _side_start=choose(-1,1),_spawn=true
            for(var _side=_side_start;abs(_side)<=1;_side+=-2*_side_start) {
                if (_spawn && !place_meeting(x+_fw*_side,y,Floor)) {
                    _spawn=false
                    var _walltent=instance_create(_fx+(_fw/2-irandom_range(3,5))*_side,_fy-random(2),NTTEFullBanditTent)
                    with (_walltent) {
                        spr_idle=scrNTTERefSprite("BanditTentWallIdle"); spr_hurt=scrNTTERefSprite("BanditTentWallHurt"); spr_dead=scrNTTERefSprite("BanditTentWallDead")
                        sprite_index=spr_idle; image_xscale=-_side
                    }
                }
            }
            if (_spawn && !collision_rectangle(_fx-32,_fy-32,_fx+32,_fy+32,Wall,false,false)
                && !collision_rectangle(bbox_left-4,bbox_top-4,bbox_right+3,bbox_bottom+3,hitme,false,false))
                instance_create(_fx+orandom(8),_fy+orandom(8),random(3)<1 ? Barrel:NTTEFullBanditTent)
        }
        if (_city) {
            var _rides=array_shuffle(scrNTTEFullInstances([Scorpion,GoldScorpion])),_rn=0
            with (NTTEFullBanditCamper) {
                if (_rn>=array_length(_rides)) break
                if (random(2)<1) rider_target=_rides[_rn++]
            }
        }
    }
    scrNTTEFullFloorResetAlign()
    return _room
}

function scrNTTEFullSeaCreatureEvent(_spawnx,_spawny) {
    var _l=400,_d=random(360)
    with (Floor) {
        var _fx=(bbox_left+bbox_right)/2,_fy=(bbox_top+bbox_bottom)/2,_dis=point_distance(_spawnx,_spawny,_fx,_fy)
        if (_l<_dis) { _l=_dis; _d=point_direction(_spawnx,_spawny,_fx,_fy)+180 }
    }
    _l*=1.75
    var _creature=instance_create(_spawnx+lengthdir_x(_l,_d),_spawny+lengthdir_y(_l,_d),NTTEFullCreature)
    var _floors=array_shuffle(scrNTTEFullInstances(Floor,true))
    for(var _i=0;_i<array_length(_floors);++_i) {
        var _floor=_floors[_i],_fx=(_floor.bbox_left+_floor.bbox_right)/2,_fy=(_floor.bbox_top+_floor.bbox_bottom)/2
        if (point_distance(_fx,_fy,_spawnx,_spawny)>200) { instance_create(_fx,_fy,Gator); break }
    }
    return _creature
}

function scrNTTEFullEelGraveEvent(_spawnx,_spawny) {
    scrNTTEFullFloorSetAlign(32,32); scrNTTEFullFloorSetStyle(true,scrNTTEFullAreaId("trench"))
    var _room=scrNTTEFullFloorRoom(_spawnx,_spawny,80,Floor,6,6,"round",0,-32)
    if (is_struct(_room)) {
        var _cx=_room.x,_cy=_room.y
        scrNTTEFullFloorResetStyle(); scrNTTEFullFloorFill(_cx,_cy,4,4,"round")
        var _angle=random(360),_num=irandom_range(2,3)
        for(var _dir=_angle;_dir<_angle+360;_dir+=360/_num) {
            var _l=random_range(16,28),_d=_dir+orandom(30/_num)
            scrNTTEFullWorldCreateRequired("EelSkull",_cx+lengthdir_x(_l,_d),_cy+lengthdir_y(_l,_d))
        }
        repeat(15*(1+GameCont.loops)) {
            var _want=scrNTTEFullWorldCreateRequired("WantEel",_cx,_cy); _want.elite=150
        }
        instance_create(_cx-48,_cy-48,Wall); instance_create(_cx+32,_cy-48,Wall)
        instance_create(_cx+32,_cy+32,Wall); instance_create(_cx-48,_cy+32,Wall)
    }
    scrNTTEFullFloorResetAlign(); scrNTTEFullFloorResetStyle()
    return _room
}

function scrNTTEFullWorldEventBuildersSmoke() {
    var _snapshot=scrNTTEFullInstances(all),_oa=GameCont.area,_ol=GameCont.loops
    GameCont.area=area_desert; GameCont.loops=0
    scrNTTEFullFloorResetStyle(); scrNTTEFullFloorSetAlign(32,32,20000,20000)
    scrNTTEFullFloorFill(20000,20000,9)
    var _chests=[]
    for(var _i=0;_i<3;++_i) array_push(_chests,instance_create(20000+_i*32,20000,WeaponChest))
    var _room=scrNTTEFullBanditCampEvent(20000,20000)
    assert(is_struct(_room) && array_length(_room.floors)==20 && _room.x2-_room.x1==160 && _room.y2-_room.y1==128,"Original BanditCamp5x4 room changed")
    assert(instance_number(NTTEFullBanditHiker)==1 && instance_number(NTTEFullBanditTent)>=3,"Bandit camp omitted its hiker/three main tents")
    var _held=[]
    with (NTTEFullBanditTent) if (instance_exists(target)) {
        assert(array_get_index(_held,target)<0,"Camp main tents selected the same chest twice")
        array_push(_held,target)
        assert(target.x==x && target.y==y+4,"Camp main tent failed initial held-chest placement")
    }
    assert(array_length(_held)==3,"Camp did not distribute eligible chests across three main tents")
    instance_create(20304,20000,Floor);instance_create(20000,20304,Floor);instance_create(19696,20000,Floor)
    var _gators=instance_number(Gator)+instance_number(BuffGator),_c=scrNTTEFullSeaCreatureEvent(20000,20000)
    scrNTTESmokeLog("SEA CREATURE OFFSHORE DIAG "+json_stringify({x:_c.x,y:_c.y,
        distance:point_distance(_c.x,_c.y,20000,20000),xstart:_c.xstart,ystart:_c.ystart,
        floors:instance_number(Floor)}))
    // Native instance coordinates near20000 have float32 ULP1/512. The
    // observed full-world minimum ray measured699.9990234375 after rounding;
    // .002 bounds the two coordinate roundings without changing source700.
    assert(point_distance(_c.x,_c.y,20000,20000)>=700-0.002,"Sea Creature minimum original offshore distance changed")
    assert(instance_number(Gator)+instance_number(BuffGator)==_gators+1,"Sea Creature event must select exactly one distant Gator")
    var _new=scrNTTEFullInstances(all)
    for(var _i=0;_i<array_length(_new);++_i) if (array_get_index(_snapshot,_new[_i])<0) instance_destroy(_new[_i],false)
    scrNTTEFullFloorResetAlign(); scrNTTEFullFloorResetStyle()
    GameCont.area=_oa; GameCont.loops=_ol
    scrNTTESmokeLog("FULL WORLD BANDIT CAMP5x4/3UNIQUE CHESTS/HIKER + SEA CREATURE OFFSHORE/GATOR ORIGINAL BUILDERS OK")
}

function scrNTTEFullEelGraveSmoke() {
    var _snapshot=scrNTTEFullInstances(all),_oa=GameCont.area,_ol=GameCont.loops
    var _skull_obj=asset_get_index("NTTEFullEelSkull"),_want_obj=asset_get_index("NTTEFullWantEel")
    assert(object_exists(_skull_obj) && object_exists(_want_obj),"EelGrave actual entities have not been ported")
    GameCont.area=scrNTTEFullAreaId("trench"); GameCont.loops=1
    scrNTTEFullFloorResetStyle(); scrNTTEFullFloorSetAlign(32,32,24000,24000)
    scrNTTEFullFloorFill(24000,24000,9)
    var _ns=instance_number(_skull_obj),_nw=instance_number(_want_obj)
    var _room=scrNTTEFullEelGraveEvent(24000,24000)
    assert(is_struct(_room) && _room.x2-_room.x1==192 && _room.y2-_room.y1==192,"Original EelGrave6x6 room dimensions changed")
    var _skulls=instance_number(_skull_obj)-_ns
    assert(_skulls>=2 && _skulls<=3 && instance_number(_want_obj)==_nw+30,"EelGrave skull/loop-scaled eel counts changed")
    with (_want_obj) assert(elite==150,"EelGrave failed to create elite150 wants")
    var _pits=0,_island=0
    with (Floor) if (x>=_room.x1 && y>=_room.y1 && x<_room.x2 && y<_room.y2) {
        // floorDis=-32 intentionally overlaps existing level geometry. The
        // four omitted outer rounded corners are not part of the generated
        // room and may retain preexisting normal floors from that overlap.
        var _outer_corner=(x==_room.x1 || x==_room.x2-32) && (y==_room.y1 || y==_room.y2-32)
        if (_outer_corner) continue
        if (styleb) {
            ++_pits
            assert(sprite_index==scrNTTERefSprite("FloorTrenchB") && traction==0.1 && depth==9,"EelGrave outer pit lost original sprite/traction/depth")
        }
        else ++_island
    }
    scrNTTESmokeLog("EEL GRAVE GENERATED SHAPE pits="+string(_pits)+" island="+string(_island)+" room="+json_stringify(_room))
    assert(_pits==20 && _island==12,"EelGrave round pit/round island geometry changed")
    var _new=scrNTTEFullInstances(all)
    for(var _i=0;_i<array_length(_new);++_i) if (array_get_index(_snapshot,_new[_i])<0) instance_destroy(_new[_i],false)
    scrNTTEFullFloorResetAlign(); scrNTTEFullFloorResetStyle()
    GameCont.area=_oa; GameCont.loops=_ol
    scrNTTESmokeLog("FULL WORLD EEL GRAVE6x6ROUND/20PITS/12ISLAND + 2-3SKULLS/30LOOP1 ELITE150 WANTS OK")
}

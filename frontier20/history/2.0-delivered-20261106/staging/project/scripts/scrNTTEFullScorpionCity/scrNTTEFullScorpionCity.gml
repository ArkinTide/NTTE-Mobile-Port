// Original teevents891..1066. This consumes the actual Scorpion pet trigger,
// converts source population, and creates three separate rocky nest rooms.
function scrNTTEFullScorpionCitySetup() {
    with (GenCont) if (goal>0) goal=ceil(goal*0.85)
    with (FloorMaker) if (goal>0) goal=ceil(goal*0.85)
}
function scrNTTEFullScorpionCityEvent(_spawnx,_spawny) {
    with (NTTEFullPet) if (pet=="Scorpion" && scorpion_city>0) {
        scorpion_city--
        var _alert=scrNTTEAlertCreate(x,y,spr_icon,id); _alert.snd_flash=sndScorpionMelee
    }
    with (Wall) if (place_meeting(x,y,Floor)) {
        var _delete=true
        for(var _dir=0;_dir<360;_dir+=90) if (place_meeting(x+lengthdir_x(16,_dir),y+lengthdir_y(16,_dir),Wall)) { _delete=false; break }
        if (_delete) {
            var _before=scrNTTEFullInstances(Debris),_fx=instance_create(x,y,FloorExplo); _fx.depth=10
            with (Debris) if (array_get_index(_before,id)<0) instance_destroy(id,false)
            instance_destroy()
        }
    }
    var _enemies=scrNTTEFullInstances(enemy)
    for(var _i=0;_i<array_length(_enemies);++_i) with (_enemies[_i]) if (size<4) {
        var _fs=scrNTTEFullRectInstances(x,y,x,y,Floor),_styled=false
        for(var _j=0;_j<array_length(_fs);++_j) if (_fs[_j].styleb) { _styled=true; break }
        if (!_styled && (!instance_is(id,Bandit) || random(2)<1)) {
            var _gold=random(5)<size,_baby=size<=1,_object=_baby ? (_gold ? NTTEFullBabyScorpionGold:NTTEFullBabyScorpion):(_gold ? GoldScorpion:Scorpion)
            instance_create(x,y,_object); instance_destroy(id,false)
        }
    }
    with (NTTEFullBigMaggotSpawn) scorp_drop++
    var _before=scrNTTEFullInstances(Floor),_rooms=[]
    repeat(3) {
        var _w=irandom_range(3,5),_h=_w,_type=_w>3 ? "round":""
        scrNTTEFullFloorSetAlign(32,32); scrNTTEFullFloorSetStyle(true)
        var _room=scrNTTEFullFloorRoom(_spawnx,_spawny,64+_w*16,Floor,_w,_h,_type,90,0)
        if (is_struct(_room)) {
            array_push(_rooms,_room)
            var _tiles=_room.floors
            for(var _i=0;_i<array_length(_tiles);++_i) with (_tiles[_i]) if (area==area_desert) {
                sprite_index=scrNTTERefSprite("FloorScorpion"); image_index=irandom(image_number-1)
                depth=8; material=2; traction=0.45; styleb=false
                var _snow=instance_create(x+orandom(1),y-irandom_range(2,3),SnowFloor)
                _snow.sprite_index=scrNTTERefSprite("SnowFloorScorpion"); _snow.image_index=image_index
                _snow.image_speed=image_speed; _snow.image_angle+=orandom(1)
                instance_create(random_range(bbox_left,bbox_right),random_range(bbox_top,bbox_bottom),Detail)
            }
            repeat(max(1,(_w+_h)/2-2)) instance_create(_room.x,_room.y,random(5)<1 ? GoldScorpion:Scorpion)
            var _num=round(_w*_h/16+orandom(1)),_angle=random(360)
            for(var _dir=_angle;_dir<_angle+360;_dir+=360/_num) {
                var _d=_dir+orandom(30),_obj=choose(BonePile,BonePile,NTTEFullCowSkull)
                instance_create(round(_room.x+lengthdir_x(_w*16-24,_d)),round(_room.y+lengthdir_y(_h*16-24,_d)),_obj)
            }
        }
        scrNTTEFullFloorResetAlign(); scrNTTEFullFloorResetStyle()
    }
    var _after=scrNTTEFullInstances(Floor)
    for(var _i=0;_i<array_length(_after);++_i) if (array_get_index(_before,_after[_i])<0) with (_after[_i]) {
        var _x1=bbox_left,_y1=bbox_top,_x2=bbox_right,_y2=bbox_bottom,_cx=(_x1+_x2)/2,_cy=(_y1+_y2)/2
        var _w=_x2-_x1,_h=_y2-_y1,_stop=false
        // Source visits the corner16px cells. A FloorExplo is itself16px;
        // its first and last corner coincide, so visit that coordinate once
        // rather than entering the original zero-increment for-loop.
        var _cornersx=_w==16 ? [_x1]:[_x1,_x2-16],_cornersy=_h==16 ? [_y1]:[_y1,_y2-16]
        for(var _ix=0;_ix<array_length(_cornersx);++_ix) {
            var _x=_cornersx[_ix]
            for(var _iy=0;_iy<array_length(_cornersy);++_iy) {
                var _y=_cornersy[_iy]
                var _sx=sign(_x+8-_cx),_sy=sign(_y+8-_cy)
                if (!place_meeting(_x1+_w*_sx,_y1,Floor) && !place_meeting(_x1,_y1+_h*_sy,Floor)) {
                    instance_create(_x,_y,Wall)
                    var _decal=instance_create(_x+8-8*_sx,_y,Bones)
                    _decal.sprite_index=sprBones; _decal.image_index=irandom(_decal.image_number-1); _decal.image_xscale=-_sx
                    _stop=true; break
                }
            }
            if (_stop) break
        }
    }
    var _alpha=instance_furthest(_spawnx,_spawny,Scorpion)
    if (instance_exists(_alpha)) { instance_create(_alpha.x,_alpha.y,NTTESilverScorpion); instance_destroy(_alpha,false) }
    if (GameCont.loops>0) repeat(GameCont.loops) {
        var _scorpions=scrNTTEFullInstances([Scorpion,GoldScorpion])
        if (array_length(_scorpions)>0) {
            var _scorpion=_scorpions[irandom(array_length(_scorpions)-1)]
            instance_create(_scorpion.x,_scorpion.y,NTTESilverScorpion); instance_destroy(_scorpion,false)
        }
    }
    return _rooms
}
function scrNTTEFullScorpionCitySmoke() {
    var _snapshot=scrNTTEFullInstances(all),_area=GameCont.area,_loops=GameCont.loops
    GameCont.area=area_desert; GameCont.loops=0
    scrNTTEFullFloorResetStyle(); scrNTTEFullFloorSetAlign(32,32,26000,26000)
    // A five-tile test island has no tile meeting the source112..144px
    // starting-distance requirement. Use the connected nine-tile level shape
    // used by ordinary generation instead of bypassing path validation.
    scrNTTEFullFloorFill(26000,26000,9)
    var _pet=scrNTTEFullPetCreate(26000,26000,"Scorpion")
    var _marker=instance_create(26000,26000,NTTEFullBigMaggotSpawn),_drop=_marker.scorp_drop
    instance_create(26000,26000,Maggot)
    var _old_alpha=instance_number(NTTESilverScorpion),_rooms=scrNTTEFullScorpionCityEvent(26000,26000)
    assert(_pet.scorpion_city==0 && _marker.scorp_drop==_drop+1,"ScorpionCity did not consume actual pet trigger or update large nests")
    assert(array_length(_rooms)==3,"ScorpionCity did not produce all3 original nests")
    assert(instance_number(NTTESilverScorpion)==_old_alpha+1,"Loop0 ScorpionCity did not promote exactly one farthest Scorpion alpha")
    var _stone=0,_snow=0
    with (Floor) if (array_get_index(_snapshot,id)<0 && sprite_index==scrNTTERefSprite("FloorScorpion")) {
        _stone++
        assert(!styleb && material==2 && traction==0.45 && depth==8,"ScorpionCity rocky floor material/traction/depth changed")
    }
    with (SnowFloor) if (array_get_index(_snapshot,id)<0 && sprite_index==scrNTTERefSprite("SnowFloorScorpion")) _snow++
    assert(_stone>0 && _snow==_stone,"ScorpionCity original thickened floor layer is missing or duplicated")
    var _new=scrNTTEFullInstances(all)
    for(var _i=0;_i<array_length(_new);++_i) if (array_get_index(_snapshot,_new[_i])<0) instance_destroy(_new[_i],false)
    GameCont.area=_area; GameCont.loops=_loops; scrNTTEFullFloorResetAlign(); scrNTTEFullFloorResetStyle()
    scrNTTESmokeLog("FULL WORLD SCORPION CITY ACTUAL PET CONSUMPTION/LARGE NEST MODIFIER/THREE NESTS/ROCK MATERIAL+SNOW THICKNESS/FARTHEST SILVER ALPHA OK; SILVER COMBAT SEPARATE")
}

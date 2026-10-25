// Original ntte.mod.gml1043..1174. Area-specific cave generation consumes
// the same level_start stream, with Prism between lightning and big props.
function scrNTTEFullCavesStyledFloor(_x,_y) {
    var _floors=scrNTTEFullRectInstances(_x,_y,_x,_y,Floor)
    for(var _i=0;_i<array_length(_floors);++_i) if(_floors[_i].styleb) return true
    return false
}
function scrNTTEFullCavesMiner(_sx=10016,_sy=10016) {
    var _bandit=instance_furthest(_sx,_sy,Bandit)
    if(!instance_exists(_bandit)) return noone
    var _miner=instance_create(_bandit.x,_bandit.y,NTTEFullMinerBandit)
    instance_destroy(_bandit,false)
    return _miner
}
function scrNTTEFullCavesSpiderlings() {
    var _spiders=scrNTTEFullInstances(Spider),_out=[]
    for(var _i=0;_i<array_length(_spiders);++_i) with(_spiders[_i]) if(chance(1,4)) {
        array_push(_out,instance_create(x,y,NTTEFullSpiderling))
        instance_destroy(id,false)
    }
    return _out
}
function scrNTTEFullCavesMortars() {
    var _crystals=scrNTTEFullInstances(crystaltype),_out=[]
    for(var _i=0;_i<array_length(_crystals);++_i) with(_crystals[_i]) {
        // Source draws chance for every crystaltype before matching exact
        // native LaserCrystal/InvLaserCrystal and before style exclusion.
        if(chance(1,5) && !scrNTTEFullCavesStyledFloor(x,y)) {
            switch(object_index) {
                case LaserCrystal:
                    array_push(_out,instance_create(x,y,NTTEFullMortar));instance_destroy(id,false);break
                case InvLaserCrystal:
                    array_push(_out,instance_create(x,y,NTTEFullInvMortar));instance_destroy(id,false);break
            }
        }
    }
    return _out
}
function scrNTTEFullCavesBats() {
    var _out=[]
    if(GameCont.loops<=0) return _out
    var _spiders=scrNTTEFullInstances([Spider,InvSpider])
    for(var _i=0;_i<array_length(_spiders);++_i) with(_spiders[_i]) {
        if(chance(1,6) && !scrNTTEFullCavesStyledFloor(x,y)) {
            var _angle=round(random(360)/90)*90,
                _object=instance_is(id,InvSpider) ? NTTEFullInvCrystalBat:NTTEFullCrystalBat
            for(var _direction=_angle;_direction<_angle+360;_direction+=180) {
                var _bat=instance_create(x,y,_object)
                with(_bat) repeat(2) {
                    var _nx=x+lengthdir_x(32,_direction),_ny=y+lengthdir_y(32,_direction)
                    if(!place_free(_nx,_ny)) break
                    x=_nx;y=_ny
                }
                array_push(_out,_bat)
            }
            instance_destroy(id,false)
        }
    }
    return _out
}
function scrNTTEFullCavesLightning() {
    var _out=[]
    if(GameCont.loops>0 || GameCont.subarea>1) return _out
    var _crystals=scrNTTEFullInstances(LaserCrystal)
    for(var _i=0;_i<array_length(_crystals);++_i) with(_crystals[_i]) {
        if(chance(1,40*(GameCont.crown==crwn_blood ? 0.7:1))) {
            array_push(_out,instance_create(x,y,LightningCrystal));instance_destroy(id,false)
        }
    }
    return _out
}
function scrNTTEFullCavesBigCrystal(_sx=10016,_sy=10016) {
    if(!chance(1,2)) return noone
    // Epsilon combines original CrystalProp/InvCrystal in native Crystal.
    var _crystals=array_shuffle(scrNTTEFullInstances(Crystal))
    for(var _i=0;_i<array_length(_crystals);++_i) with(_crystals[_i]) {
        if(place_meeting(x,y,Floor) && point_distance(x,y,_sx,_sy)>=96) {
            var _big=instance_create(x,y,NTTEFullBigCrystalProp)
            instance_destroy(id,false)
            return _big
        }
    }
    return noone
}
function scrNTTEFullCavesHyperPit(_sx=10016,_sy=10016) {
    var _boss=instance_find(HyperCrystal,0)
    if(!instance_exists(_boss)) return noone
    // Original FloorNormal is Epsilon's exact Floor, not FloorExplo.
    var _room=scrNTTEFullFloorRoom(_sx,_sy,256,Floor,5,5,"",0,-32,true)
    if(!is_struct(_room)) return noone
    _boss.x=_room.x;_boss.y=_room.y;_boss.xprevious=_boss.x;_boss.yprevious=_boss.y
    // Restrict cleanup to the source boss-local native ID window. Other
    // PortalClears and a second HyperCrystal retain their own generation.
    var _bossId=real(_boss.id)
    for(var _instance=_bossId+1;_instance<=_bossId+15;++_instance)
        if(instance_is(_instance,PortalClear)) instance_destroy(_instance,false)
    scrNTTEFullFloorFill(_room.x,_room.y,9,3,"ring")
    scrNTTEFullFloorFill(_room.x,_room.y,3,9,"ring")
    var _hole=instance_create(_room.x,_room.y,NTTEFullManholeOpen)
    _hole.sprite_index=scrNTTERefSprite(GameCont.area==area_cursed_caves ? "CaveHoleCursed":"CaveHole")
    _hole.mask_index=scrNTTERefSprite("msk.CaveHole");_hole.ntte_full_big=true
    return _hole
}
function scrNTTEFullCavesLevelStartBeforePets() {
    if(GameCont.area!=area_caves && GameCont.area!=area_cursed_caves) return;
    scrNTTEFullCavesMiner()
    scrNTTEFullCavesSpiderlings()
    scrNTTEFullCavesMortars()
    scrNTTEFullCavesBats()
    scrNTTEFullCavesLightning()
}
function scrNTTEFullCavesLevelStartAfterPets() {
    if(GameCont.area!=area_caves && GameCont.area!=area_cursed_caves) return;
    scrNTTEFullCavesBigCrystal()
    scrNTTEFullCavesHyperPit()
}

// Original ntte.level_start2049..2233. Existing TopPot subclasses remain real
// native objects; every elevated actor uses the source-backed TopCreate.
function scrNTTEFullTopDesertIsland(_decal,_kind=undefined) {
    var _x=_decal.x,_y=_decal.y,_dis=64,_dir=random(360)
    if(is_undefined(_kind)) _kind=choose("Bandit","Cactus","Chest","Wep")
    if(instance_exists(Floor)) {
        var _near=scrNTTEFullNearestBBox(_x,_y,Floor),_d=_dir
        if(instance_exists(_near)) _d=point_direction((_near.bbox_left+_near.bbox_right)/2,(_near.bbox_top+_near.bbox_bottom)/2,_x,_y)
        var _tries=4096
        while(collision_circle(_x,_y,_dis,Floor,false,false)) {
            _x+=lengthdir_x(8,_d);_y+=lengthdir_y(8,_d)
            if(--_tries<=0) throw "Source Desert top island could not leave terrain";
        }
        _dir=_d
    }
    var _num=3,_ang=random(360),_decal_num=_num,_cactus_num=irandom_range(1,_num),_bandit_num=0,_fly_num=0
    if(GameCont.loops>0) _fly_num=irandom_range(1,_num)
    switch(_kind) {
        case "Bandit":
            _bandit_num=irandom_range(1,_num);_cactus_num=max(_cactus_num,_bandit_num-1)
            instance_create(_x,_y-4,NTTEFullWallEnemy)
            break
        case "Cactus":
            _cactus_num=_num;scrNTTEFullTopCreate(_x,_y-28,BonePile,0,0)
            var _l=160,_chest=scrNTTEFullLairChestCreate(_x+lengthdir_x(_l,_dir),_y+lengthdir_y(_l,_dir),BigWeaponChest)
            if(instance_exists(_chest)) {
                var _wrap=scrNTTEFullTopCreate(_chest.x,_chest.y,_chest,_dir,_l)
                if(instance_exists(_wrap)) {
                    var _ammo=scrNTTEFullLairChestCreate(_wrap.x+lengthdir_x(16,_dir),_wrap.y+lengthdir_y(16,_dir),AmmoChest)
                    if(instance_exists(_ammo)) scrNTTEFullTopCreate(_ammo.x,_ammo.y,_ammo,-1,-1)
                    scrNTTEFullTopCreate(_wrap.x,_wrap.y,Cactus,_dir+180+orandom(90),-1)
                }
                if(instance_is(_chest,BigWeaponChest)) GameCont.nochest-=2
            }
            break
        case "Chest":
            var _obj=AmmoChest
            if(scrCrownCheck(crwn_life) && random(3)<2) _obj=HealthChest
            else with(Player) if(hp<max_hp/2 && random(2)<1) _obj=HealthChest
            var _chest=scrNTTEFullLairChestCreate(_x,_y-16,_obj)
            if(instance_exists(_chest)) {
                var _wrap=scrNTTEFullTopCreate(_chest.x,_chest.y,_chest,0,0)
                if(instance_exists(_wrap)) _wrap.spr_shadow_y-=1
            }
            break
        case "Wep":
            _cactus_num=irandom_range(2,_num)
            var _ground=instance_create(_x,_y-16,NTTEFullWepPickupGrounded)
            _ground.target=instance_create(_ground.x,_ground.y,WepPickup)
            with(_ground.target) {
                ammo=true;roll=true
                wep=scrNTTEFullWeaponDecide(min(6,2+GameCont.hard),3+GameCont.hard,false,undefined,id)
                wep=scrNTTEFullWeaponNative(wep)
                if(scrNTTEFullWeaponIsNative(wep)) ntte_state=scrNTTEFullWeaponNativeState(wep)
                name=scr_weapon_get_name(wep);type=scr_weapon_get_type(wep);sprite_index=scr_weapon_get_sprite(wep)
            }
            _ground.top_object=scrNTTEFullTopCreate(_ground.x,_ground.y,_ground,0,0)
            break
    }
    for(var _a=_ang;_a<_ang+360;_a+=360/_num) {
        var _l=_dis*random_range(0.3,0.7),_d=_a+orandom(15)
        if(_decal_num>0) {
            _decal_num-=1
            var _rock=scrNTTEFullAreaTopDecalCreate(_x+lengthdir_x(_l,_d),_y+lengthdir_y(_l,_d))
            if(instance_exists(_rock)) {
                _rock.x=_rock.xstart;_rock.y=_rock.ystart
                instance_create(floor((_rock.x-16)/16)*16,floor((_rock.y-16)/16)*16,Top)
            }
        }
        _d+=(360/_num)/2
        if(_bandit_num>0) {
            _bandit_num-=1;instance_create(_x+lengthdir_x(_l,_d),_y+lengthdir_y(_l,_d),NTTEFullWallEnemy)
            _l*=random_range(0.5,0.7)
        }
        else _l=_dis*random_range(0.15,0.5)
        if(_cactus_num>0) {_cactus_num-=1;scrNTTEFullTopCreate(_x+lengthdir_x(_l,_d),_y-20+lengthdir_y(_l,_d),Cactus,0,0)}
        if(_fly_num>0) {
            _fly_num-=1;var _l=_dis*random_range(0.5,1)
            scrNTTEFullTopCreate(_x+lengthdir_x(_l,_d),_y-16+lengthdir_y(_l,_d),JungleFly,_d+orandom(30),_l)
        }
    }
    instance_destroy(_decal,false)
    return [_x,_y,_kind];
}
function scrNTTEFullTopEcologyLevelStart() {
    var _special=random(5)<1,_all=scrNTTEFullInstances(TopPot)
    // Source excludes bare TopPot before shuffling, so custom-area base pots
    // cannot consume shuffle slots or change ordinary target selection.
    for(var _i=array_length(_all)-1;_i>=0;--_i) if(_all[_i].object_index==TopPot) array_delete(_all,_i,1)
    _all=array_shuffle(_all)
    for(var _i=0;_i<array_length(_all);++_i) if(instance_exists(_all[_i])) {
        var _decal=_all[_i]
        switch(_decal.object_index) {
            case TopDecalNightDesert:
                if(random(2)<1) scrNTTEFullTopCreate(_decal.x,_decal.y-8,NightCactus,random(360),-1)
                break
            case TopDecalDesert:
                if(_special) {_special=false;scrNTTEFullTopDesertIsland(_decal)}
                else scrNTTEFullTopCreate(_decal.x,_decal.y-8,Cactus,random(360),-1)
                break
            case TopDecalScrapyard:
                if(random(2)<1) {
                    if(_decal.image_index>=1) scrNTTEFullTopCreate(_decal.x,_decal.y-16,NTTEFullTopRaven,0,0)
                    else scrNTTEFullTopCreate(_decal.x,_decal.y-8,NTTEFullTopRaven,random(360),-1)
                }
                break
            case TopDecalPalace:
                if(random(2)<1) {
                    var _near=scrNTTEFullNearestBBox(_decal.x,_decal.y,Floor)
                    if(instance_exists(_near)) scrNTTEFullTopCreate(_decal.x,_decal.y-8,Pillar,
                        point_direction(_decal.x,_decal.y,(_near.bbox_left+_near.bbox_right)/2,(_near.bbox_top+_near.bbox_bottom)/2),random_range(16,64))
                }
                break
        }
    }
}
function scrNTTEFullBigDecalLevelStart() {
    if(random(scrAreaGetMaxSubarea(GameCont.area)>1?8:4)<1) {
        var _tops=scrNTTEFullInstances(TopSmall)
        if(array_length(_tops)>0) {
            var _top=_tops[irandom(array_length(_tops)-1)]
            scrNTTEFullBigDecalSpawn(random_range(_top.bbox_left,_top.bbox_right),random_range(_top.bbox_top,_top.bbox_bottom))
        }
    }
}

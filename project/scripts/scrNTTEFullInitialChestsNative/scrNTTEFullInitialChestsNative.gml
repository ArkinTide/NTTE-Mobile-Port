// ntte.mod2333..2478. Individual providers preserve the source order with
// world-owned spectators/Orchid Chests before, between, and after these calls.
function scrNTTEFullCrimeInitialChests() {
    if(scrNTTEFullCrownKey(GameCont.crown)!="crime") return false
    var _ammo=[],_weapons=[],_rads=[]
    with(AmmoChest) if(object_index!=IDPDChest && object_index!=GiantAmmoChest) array_push(_ammo,id)
    with(Mimic) array_push(_ammo,id)
    with(WeaponChest) if(object_index!=GiantWeaponChest) array_push(_weapons,id)
    with(RadChest) array_push(_rads,id)
    with(RogueChest) array_push(_rads,id)
    with(HealthChest) array_push(_rads,id)
    with(SuperMimic) array_push(_rads,id)
    var _category=scrNTTEFullTunnellerPool([[0,array_length(_ammo)>0],[1,array_length(_weapons)>0],[2,array_length(_rads)>0]]),
        _list=_category==0?_ammo:(_category==1?_weapons:(_category==2?_rads:[])),
        _name=_category==0?"CatChest":(_category==1?"BatChest":"RatChest")
    for(var _i=0;_i<array_length(_list);++_i) if(instance_exists(_list[_i])) {
        var _old=_list[_i],_new=scrNTTEFullLairChestCreate(_old.x,_old.y,_name,true)
        if(_category==1 && instance_is(_new,NTTEFullBatChest)) {
            _new.big=instance_is(_old,BigWeaponChest) || instance_is(_old,CursedBigChest)
            _new.curse=_old.curse
        }
        instance_destroy(_old,false)
    }
    return array_length(_list)>0
}
function scrNTTEFullRedInitialChests() {
    var _red=false
    with(Player) if(scrNTTEFullRedAmmoWeaponCost(wep)>0 || scrNTTEFullRedAmmoWeaponCost(bwep)>0) {_red=true;break;}
    if(!_red) return false
    with(RadChest) {instance_create(x,y,NTTEFullRedAmmoChest);instance_destroy(id,false);}
    var _spawn=true
    with(RogueChest) {
        if(_spawn) {
            _spawn=false
            scrNTTEFullFloorSetAlign(32,32)
            var _room=scrNTTEFullFloorRoom(x,y,0,Floor,1,1,"",0,0)
            if(is_struct(_room)) instance_create(_room.x,_room.y,NTTEFullRedAmmoChest)
            scrNTTEFullFloorResetAlign()
        }
        else if(random(2)<1) {instance_create(x,y,NTTEFullRedAmmoChest);instance_destroy(id,false);}
    }
    return true
}
function scrNTTEFullBonusInitialChests(_normal,_hard) {
    var _targets=scrNTTEFullInstances([AmmoPickup,HPPickup,AmmoChest,HealthChest,Mimic,SuperMimic]),_changed=0
    for(var _i=0;_i<array_length(_targets);++_i) if(instance_exists(_targets[_i])) with(_targets[_i]) {
        if(!is_undefined(scrNTTEFullValue(id,"bonus_pickup_check",undefined))) continue
        bonus_pickup_check=(random(6)<1 && _normal && _hard>8) || scrNTTEFullCrownKey(GameCont.crown)=="bonus"
        if(!bonus_pickup_check) continue
        var _name=""
        if((instance_is(id,AmmoChest) && !instance_is(id,IDPDChest)) || instance_is(id,Mimic)) _name="Ammo"
        else if(instance_is(id,HealthChest) || instance_is(id,SuperMimic)) _name="Health"
        if(_name!="") {
            scrNTTEFullLairChestCreate(x,y,"Bonus"+_name+(instance_is(id,enemy)?"Mimic":"Chest"),true)
            instance_destroy(id,false);_changed++
        }
    }
    return _changed
}

// ntte.mod2282..2310,2393..2403,2489..2520 and tedesert2985..3000.
// Root orders these around source chest mutations; they are separate exits.
function scrNTTEFullBabyScorpionsLevelStart() {
    var _out=[]
    if(!instance_exists(Scorpion) && !instance_exists(GoldScorpion)) return _out
    var _city=instance_exists(scrNTTEFullWorldEventGet("ScorpionCity")),_normal=scrNTTEFullInstances(Scorpion),_gold=scrNTTEFullInstances(GoldScorpion)
    for(var _i=0;_i<array_length(_normal);++_i) with(_normal[_i]) if(chance(1+_city,4))
        repeat(irandom_range(1,3)) array_push(_out,instance_create(x,y,NTTEFullBabyScorpion))
    for(var _i=0;_i<array_length(_gold);++_i) with(_gold[_i]) if(chance(_city,4))
        repeat(irandom_range(1,3)) array_push(_out,instance_create(x,y,NTTEFullBabyScorpionGold))
    var _nests=scrNTTEFullInstances(MaggotSpawn)
    for(var _i=0;_i<array_length(_nests);++_i) _nests[_i].babyscorp_drop=chance(1,8)+_city
    return _out
}
function scrNTTEFullMaggotBabyDeath() {
    // Original BeginStep observes hp<=0 immediately before native nest death.
    // Native Destroy is the equivalent one-shot consumer; replacement/delete
    // (instance_destroy(false)) must not release babies.
    if(hp>0) return;
    repeat(scrNTTEFullValue(id,"babyscorp_drop",0)) instance_create(x,y,NTTEFullBabyScorpion)
}
function scrNTTEFullBigDogSpectatorsLevelStart() {
    var _out=[],_dogs=scrNTTEFullInstances(BecomeScrapBoss)
    for(var _i=0;_i<array_length(_dogs);++_i) with(_dogs[_i])
        repeat(irandom_range(2,6)*(1+GameCont.loops)) array_push(_out,scrNTTEFullTopCreate(x,y,"TopRaven",random(360),-1))
    return _out
}
function scrNTTEFullOrchidChestsLevelStart() {
    var _out=[]
    if(!scrNTTEFullUnlockGet("orchid:seen",false)) return _out
    var _chests=scrNTTEFullInstances(RadChest)
    for(var _i=0;_i<array_length(_chests);++_i) with(_chests[_i]) if(chance(GameCont.rad*(GameCont.level/10),600*3)) {
        array_push(_out,instance_create(x,y,NTTEFullOrchidChest));instance_destroy(id,false)
    }
    return _out
}
function scrNTTEFullFliesLevelStart() {
    var _out=[],_nests=scrNTTEFullInstances(MaggotSpawn),_bones=scrNTTEFullInstances(BonePile)
    for(var _i=0;_i<array_length(_nests);++_i) with(_nests[_i])
        repeat(irandom_range(0,2)) array_push(_out,instance_create(x+orandom(12),y+orandom(8),NTTEFullFlySpin))
    for(var _i=0;_i<array_length(_bones);++_i) with(_bones[_i]) if(chance(1,2)) {
        var _fly=instance_create(x,y,NTTEFullFlySpin)
        _fly.target=id;_fly.target_x=orandom(8);_fly.target_y=-random(8);array_push(_out,_fly)
    }
    return _out
}
function scrNTTEFullBabySludgeLevelStart() {
    var _out=[],_floors=scrNTTEFullInstances(Floor)
    for(var _i=0;_i<array_length(_floors);++_i) with(_floors[_i]) if(sprite_index==sprFloor3 && image_index==3) {
        if(!place_meeting(x,y,NTTEFullSludgePool)) {
            var _pool=instance_create((bbox_left+bbox_right)/2,(bbox_top+bbox_bottom)/2,NTTEFullSludgePool)
            _pool.sprite_index=scrNTTERefSprite("msk.SludgePoolSmall");_pool.spr_floor=sprite_index;_pool.floors=[id]
            array_push(_out,_pool)
        }
    }
    return _out
}

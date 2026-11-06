// Controlled exact production QA branch; no full-unfolding claim.
// Canonical extracted branch SHA256: 0a50051bf9f8837638caf46d17bec529d4dda7b4c3e6ee2182fa8b5ed3debeb8
function scrNTTEFullCrystalHeartCrownGuardianExtracted(_generation) {
    if (subarea==0) {
        var _remove=scrNTTEFullCrystalHeartNewInstances(PizzaEntrance,_generation)
        for(var _i=0;_i<array_length(_remove);++_i) instance_destroy(_remove[_i],false)
        var _crowns=scrNTTEFullCrystalHeartNewInstances(CrownPickup,_generation)
        for(var _i=0;_i<array_length(_crowns);++_i) with (_crowns[_i]) {
            var _num=2,_floor=array_shuffle(scrNTTEFullCrystalHeartNewInstances(Floor,_generation,true))
            scrNTTEFullCrystalCrownShuffled(_floor,_generation);
            for(var _j=0;_j<array_length(_floor) && _num>0;++_j) with (_floor[_j]) {
                var _cx=(bbox_left+bbox_right)/2,_cy=(bbox_top+bbox_bottom)/2
                if (point_distance(_cx,_cy,other.x,other.y)<96 && place_free(x,y)) { instance_create(_cx,_cy,CrownGuardian); if (--_num<=0) break }
            }
            scrNTTEFullCrystalCrownSealed();
            instance_destroy(id,false)
        }
        _remove=scrNTTEFullCrystalHeartNewInstances(CrownPed,_generation)
        for(var _i=0;_i<array_length(_remove);++_i) instance_destroy(_remove[_i],false)
    }
}

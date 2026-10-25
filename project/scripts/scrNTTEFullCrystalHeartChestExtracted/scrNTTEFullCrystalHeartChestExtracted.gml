// Controlled exact extracted Heart chest branch, not a full unfolding.
// Canonical extracted branch SHA256: f3fb55310d0274c92212293cea910e83ad66e8015324fa41b79720bcdbdf7bcf
function scrNTTEFullCrystalHeartChestExtracted(_generation) {
    for(var _i=0;_i<array_length(area_chest);++_i) {
        var _chest=area_chest[_i],_cx=x,_cy=y,_pos=area_chest_pos,_minimum=-1,_random_selected=false,
            _floor=array_shuffle(scrNTTEFullCrystalHeartNewInstances(Floor,_generation,true))
        scrNTTEFullCrystalChestShuffled(_floor,_generation,_i,_chest,_pos);
        // NTTE CRYSTAL HEART FIRST RANDOM CHEST CANDIDATE ONLY
        for(var _j=0;_j<array_length(_floor) && !_random_selected;++_j) with (_floor[_j]) {
            if (!place_meeting(x,y,Wall) && !place_meeting(x,y,prop) && !place_meeting(x,y,chestprop)) {
                var _can=true,_enemies=scrNTTEFullInstances(enemy)
                for(var _k=0;_k<array_length(_enemies);++_k) if (_enemies[_k].size>1 && place_meeting(x,y,_enemies[_k])) { _can=false; break }
                if (_can) {
                    var _x=(bbox_left+bbox_right)/2,_y=(bbox_top+bbox_bottom)/2
                    if (_pos=="random") { _cx=_x; _cy=_y; _random_selected=true; break }
                    else {
                        var _distance=point_distance(other.x,other.y,_x,_y)
                        if (_distance>_minimum) { _minimum=_distance; _cx=_x; _cy=_y }
                    }
                }
            }
        }
        scrNTTEFullCrystalChestBefore(_i,_cx,_cy,_chest);
        var _new=scrNTTEFullLairChestCreate(_cx,_cy,_chest,true)
        scrNTTEFullCrystalChestAfter(_i,_new);
        if (instance_exists(_new)) {
            var _crystals=scrNTTEFullInstances([Crystal,NTTEFullBigCrystalProp,NTTEFullCrystalPropRed,NTTEFullCrystalPropWhite])
            with (_new) for(var _j=0;_j<array_length(_crystals);++_j) if (place_meeting(x,y,_crystals[_j])) instance_destroy(_crystals[_j],false)
        }
    }
}

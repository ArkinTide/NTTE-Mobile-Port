// ntte.level_start1766..1779. Original top_create keeps the existing target,
// moves it to a real wall top, and owns alarm/mask/height restoration.
function scrNTTEFullJungleLevelStart() {
    if(GameCont.area!=area_jungle) return;
    var _types=[Bush,JungleBandit,JungleFly]
    if(GameCont.loops>0) array_push(_types,JungleAssassinHide)
    var _targets=scrNTTEFullInstances(_types)
    for(var _i=0;_i<array_length(_targets);++_i) {
        var _target=_targets[_i]
        if(instance_exists(_target) && random(4)<1)
            scrNTTEFullTopCreate(_target.x,_target.y,_target,-1,-1)
    }
}

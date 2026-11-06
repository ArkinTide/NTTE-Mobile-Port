// ntte.mod.gml591..654. Consume the current level_start RNG stream; the
// next-run guarantee is selected separately by source game_start.
function scrNTTEFullCrystalHeartLevelFloors() {
    var _floors=scrNTTEFullInstances(Floor,true),_out=[]
    for(var _i=0;_i<array_length(_floors);++_i) with(_floors[_i]) {
        if(distance_to_object(Player)>128 && !place_meeting(x,y,Wall)) {
            if(!instance_exists(Wall) || distance_to_object(Wall)<34) array_push(_out,id)
        }
    }
    return _out
}
function scrNTTEFullCrystalHeartLevelStart(_normal_area=undefined) {
    var _spawned=[]
    // Natural level_start freezes this before all early setpieces. Standalone
    // callers may omit it to capture their own current native world state.
    if(is_undefined(_normal_area)) _normal_area=GameCont.hard>1 && instance_number(enemy)>instance_number(HostileHorror)
    if(!_normal_area) return _spawned
    var _area=GameCont.area,_subarea=GameCont.subarea,_loops=GameCont.loops,
        _heartNum=chance(GameCont.hard,400+5*GameCont.hard) && _area!=area_hq,
        _chaosNum=((_subarea==1)+chance(1,5))*(GameCont.crown==NTTEFullCrown.Red),
        _guarantee=scrNTTEFullValue(GameCont,"ntte_heart_spawn")
    if(!is_undefined(_guarantee)) {
        if(scrNTTEFullValue(_guarantee,"area",_area)==_area
            && scrNTTEFullValue(_guarantee,"subarea",_subarea)==_subarea
            && scrNTTEFullValue(_guarantee,"loops",_loops)==_loops) _heartNum=max(_heartNum,1)
        // A random ordinary heart also consumes the guarantee, even when its
        // planned level differs or there are no suitable tiles this level.
        if(_heartNum>0) GameCont.ntte_heart_spawn=undefined
    }
    if(_heartNum<=0 && _chaosNum<=0) return _spawned
    var _floors=scrNTTEFullCrystalHeartLevelFloors()
    if(!array_length(_floors)) return _spawned
    var _chaosForce=(_area==scrNTTEFullAreaId("red")
        || scrNTTEFullValue(GameCont,"ntte_visits_loop_red",-1)>=_loops)
    while(_heartNum>0 || _chaosNum>0) {
        // Original instance_random picks with replacement; simultaneous
        // hearts can occupy the same floor. Do not shuffle/remove entries.
        var _floor=_floors[irandom(array_length(_floors)-1)],
            _heart=instance_create((_floor.bbox_left+_floor.bbox_right)/2,(_floor.bbox_top+_floor.bbox_bottom)/2+2,NTTEFullCrystalHeart)
        if(_chaosNum>0 || _chaosForce) with(_heart) {
            spr_idle=scrNTTERefSprite("ChaosHeartIdle");spr_walk=spr_idle
            spr_hurt=scrNTTERefSprite("ChaosHeartHurt");spr_dead=scrNTTERefSprite("ChaosHeartDead")
            hitid=[spr_idle,"CHAOS HEART"];sprite_index=spr_idle;white=true;area=undefined
        }
        // Keep chance first: ordinary hearts still consume this draw even
        // though the second operand guarantees their eligibility.
        if(chance(1,10) || _chaosNum<=0) {
            if(scrNTTEFullValue(GameCont,"ntte_tesseract_loop",0)<_loops) {
                GameCont.ntte_tesseract_loop=_loops;_heart.tesseract=true
            }
        }
        array_push(_spawned,_heart)
        if(_chaosNum>0) _chaosNum-=1
        else _heartNum-=1
    }
    return _spawned
}

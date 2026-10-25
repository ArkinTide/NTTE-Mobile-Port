// Source ntte103..125/710..775/2980/3540/3955..3986.
// Call at actual transitions. No readiness flag is enabled by these callbacks.
function scrNTTEFullRaceProgressSelected(_unique=true) {
    var _races=[]
    for(var _slot=0;_slot<player_count;++_slot) {
        var _p=scr_playerinstance_find(_slot)
        if(!is_struct(_p)) continue
        var _race=_p.race
        if(scrNTTEFullRaceKey(_race)=="") continue
        if(!_unique || array_get_index(_races,_race)<0) array_push(_races,_race)
    }
    return _races
}
function scrNTTEFullRaceProgressRunStart() {
    if(!instance_exists(GameCont) || scrNTTEFullValue(GameCont,"ntte_race_stats_started",false)) return false
    // Native GameCont fields are serialized by the existing run continuation.
    // Runs are per player slot, whereas wins/loops/time/kills are per race.
    GameCont.ntte_race_stats_started=true
    var _races=scrNTTEFullRaceProgressSelected(false)
    for(var _i=0;_i<array_length(_races);++_i)
        scrNTTEFullRaceStatAdd("race:"+scrNTTEFullRaceKey(_races[_i])+":runs",1)
    return true
}
function scrNTTEFullCrystalHeartRunStart(_state=GameCont) {
    // Source checks field existence, not truthiness: after a natural heart
    // consumes the guarantee, undefined must still prevent reselection.
    var _exists=is_struct(_state)?variable_struct_exists(_state,"ntte_heart_spawn")
        :variable_instance_exists(_state,"ntte_heart_spawn")
    if(_exists) return false
    var _num=scrNTTEFullLoadoutGet("heart:spawn",0)
    if(_num<=0) return false
    scrNTTEFullLoadoutSet("heart:spawn",_num-1)
    // The original uses the current game_start RNG stream; do not invent a
    // second seed. Main areas2..7 exclude Desert; final boss subareas excluded.
    var _area=irandom_range(2,7)
    _state.ntte_heart_spawn={area:_area,subarea:irandom_range(1,max(1,scrAreaGetMaxSubarea(_area)-1)),loops:0}
    return true
}
function scrNTTEFullRaceProgressWin(_seat) {
    if(!instance_exists(_seat) || scrNTTEFullValue(_seat,"ntte_race_stats_win",false)) return false
    _seat.ntte_race_stats_win=true
    var _races=scrNTTEFullRaceProgressSelected()
    for(var _i=0;_i<array_length(_races);++_i)
        scrNTTEFullRaceStatAdd("race:"+scrNTTEFullRaceKey(_races[_i])+":wins",1)
    return true
}
function scrNTTEFullRaceProgressDeath(_actor) {
    if(!instance_exists(_actor)) return false
    var _key=scrNTTEFullRaceKey(_actor.race)
    if(_key=="") return false
    // Call once immediately before the genuine Player->Revive/death branch.
    // Revive keeps this same ID in Epsilon, so never permanently mark the body.
    scrNTTEFullRaceStatAdd("race:"+_key+":lost",1)
    return true
}
function scrNTTEFullRaceProgressCampfire() {
    if(!instance_exists(GameCont) || GameCont.area!=area_campfire) return false
    scrNTTEFullCrownLoadoutUnlockCurrent()
    if(GameCont.loops<=0) return true
    var _heart=scrNTTEFullLoadoutGet("heart:spawn",0)
    if(_heart<=0) scrNTTEFullLoadoutSet("heart:spawn",_heart+1)
    var _races=scrNTTEFullRaceProgressSelected()
    for(var _i=0;_i<array_length(_races);++_i)
        scrNTTEFullRaceStatAdd("race:"+scrNTTEFullRaceKey(_races[_i])+":loop",1)
    return true
}
function scrNTTEFullRaceProgressEndStep() {
    if(!instance_exists(GameCont)) return;
    var _races=scrNTTEFullRaceProgressSelected(),_kills=GameCont.kills,
        _last=scrNTTEFullValue(GameCont,"ntte_kills_last",undefined),_sitting=false
    // Native SitDown is spawned before contact; source PlayerSit only starts
    // once sitting. Thus the actual native sit flag is the source equivalent.
    with(SitDown) if(sit) _sitting=true
    for(var _i=0;_i<array_length(_races);++_i) {
        var _race=_races[_i],_key="race:"+scrNTTEFullRaceKey(_race),_hidden=false
        with(Player) if(race==_race && !visible) _hidden=true
        if(((!_hidden && !instance_exists(GenCont)) || instance_exists(LevCont)) && !_sitting)
            scrNTTEFullRaceStatAdd(_key+":time",timescale/30)
        if(!is_undefined(_last) && _kills!=_last) {
            scrNTTEFullRaceStatAdd(_key+":kill",_kills-_last)
            if(_kills>=scrNTTEFullValue(global.ntte_full_progress.stats,_key+":best:kill",0)) {
                global.ntte_full_progress.stats[$ _key+":best:area"]=[GameCont.area,GameCont.subarea,GameCont.loops]
                global.ntte_full_progress.stats[$ _key+":best:kill"]=_kills
            }
        }
    }
    GameCont.ntte_kills_last=_kills
}

// petlib4792 + telib3174. Guardian supplies a source stage to advance from,
// whereas normal mobile AreaSet callers supply their already-final destination.
function scrNTTEFullGuardianEscapeQueue(_area,_subarea,_loops) {
    var _destination=scrNTTEFullAreaSet(_area,_subarea,_loops)
    _destination.ntte_full_guardian_source_stage=true
    // Preserve source area_set's last non-secret area bookkeeping. Its normal
    // Room End will subsequently update this again where the original does.
    var _remember=!scrNTTEFullWorldAreaSecret(GameCont.area)
    _destination.lastarea=_remember ? GameCont.area:GameCont.lastarea
    _destination.lastsubarea=_remember ? GameCont.subarea:GameCont.lastsubarea
    return _destination
}
function scrNTTEFullGuardianEscapeRoomEndBegin() {
    var _destination=scrNTTEFullValue(GameCont,"ntte_full_pending_destination",undefined)
    if(!is_struct(_destination) || !scrNTTEFullValue(_destination,"ntte_full_guardian_source_stage",false)) return false
    // Apply only as the real native Room End begins. Clearing this special
    // pending value lets native/custom area_finish and native waypoint/difficulty
    // bookkeeping execute once, without duplicating any next-area rules here.
    GameCont.ntte_full_pending_destination=undefined
    GameCont.area=_destination.area;GameCont.subarea=_destination.subarea;GameCont.loops=_destination.loops
    GameCont.lastarea=_destination.lastarea;GameCont.lastsubarea=_destination.lastsubarea
    return true
}

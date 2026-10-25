// Native mobile Portal restarts the room, and GameCont Room End advances the
// stage. Keep the target separate until that real transition; no early change
// to the active world's area/material/music is necessary.
function scrNTTEFullAreaSet(_area,_subarea,_loops) {
    if (is_string(_area)) _area=scrNTTEFullAreaId(_area)
    if (_area==area_caves && scrPlayerCountCursed(all)>0) _area=area_cursed_caves
    GameCont.ntte_full_pending_destination={area:_area,subarea:_subarea,loops:_loops}
    return GameCont.ntte_full_pending_destination
}

function scrNTTEFullAreaTakeDestination() {
    var _destination=scrNTTEFullValue(GameCont,"ntte_full_pending_destination",undefined)
    if (!is_struct(_destination)) return undefined
    GameCont.ntte_full_pending_destination=undefined
    return _destination
}

// A generator provider is installed only when its actual area callbacks and
// all dependencies are available. A missing provider fails loudly; callers
// must leave the corresponding natural entrance gate closed in that case.
function scrNTTEFullAreaGenerate(_area,_subarea,_loops,_x,_y,_set_area=true,_overlap_floor=0,_setup=undefined) {
    if (!variable_global_exists("ntte_full_area_generate") || !is_callable(global.ntte_full_area_generate))
        throw "NTTE area_generate bridge is not integrated"
    var _provider=global.ntte_full_area_generate;
    return _provider(_area,_subarea,_loops,_x,_y,_set_area,_overlap_floor,_setup)
}

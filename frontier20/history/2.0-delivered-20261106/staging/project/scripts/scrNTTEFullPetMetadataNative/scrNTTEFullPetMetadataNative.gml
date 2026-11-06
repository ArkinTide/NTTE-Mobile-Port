// petlib4894..4911. Native SkillIcon builds localized Throne Butt text each
// Draw instead of storing source text at setup; augment that final body.
function scrNTTEFullPetThroneButtDescription(_description) {
    var _salamander=false
    with(NTTEFullPet) if(pet=="Salamander") {_salamander=true;break}
    if(!_salamander) return _description
    for(var _i=0;_i<player_count;++_i) {
        var _p=scr_playerinstance_find(_i)
        if(is_undefined(_p)) continue
        var _race=_p.get_race(),_title=loc("Races",_race,"Name",scrRaceGetName(_race))
        if(string_pos(_title,_description)!=1) _description=_title+" - "+_description
        break
    }
    return _description+"@s#"+scrNTTEFullDisplay("SALAMANDER - @wPUNTED @sENEMIES @rEXPLODE@s")
}

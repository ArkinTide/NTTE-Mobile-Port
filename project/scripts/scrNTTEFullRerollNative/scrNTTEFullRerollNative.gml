// Original skills/reroll.skill.gml ntte_end_step, using the real acquisition
// ordered native DS list shared with custom mutations.
function scrNTTEFullRerollEndStep() {
    if(!instance_exists(GameCont)) return;
    var _hud=scrNTTEFullValue(GameCont,"ntte_reroll_hud",undefined)
    if(is_undefined(_hud)) {
        if(instance_exists(SkillText) && scrNTTEFullSkillGet("reroll")!=0) {
            var _order=GameCont.skills,_pos=ds_list_find_index(_order,NTTEFullSkill.Reroll)
            if(_pos>=0 && _pos+1<ds_list_size(_order)) {
                // The original takes the LAST later acquisition, not the
                // first, and does not filter it through skill availability.
                var _chosen=_order[|ds_list_size(_order)-1]
                scrNTTEFullRerollChosen(_chosen)
            }
        }
    }
    else if(scrNTTEFullSkillGet(_hud)==0) GameCont.ntte_reroll_hud=undefined
}

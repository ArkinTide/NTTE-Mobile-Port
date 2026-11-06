// ntte.mod.gml3674..3685. The source unlocks on the clear/Portal frame,
// before ntte_call(step), rather than waiting for RoomEnd or visiting again.
function scrNTTEFullWorldCompletionStep() {
    if(!instance_exists(GameCont) || instance_exists(GenCont) || instance_exists(LevCont)
        || !instance_exists(Player)) return false
    // NTTE COMPLETION SOURCE PORTALPREVENT BECOMENEMY
    if(!instance_exists(Portal) && (instance_exists(enemy) || instance_exists(becomenemy)
        || instance_exists(NTTEFullPortalPrevent) || instance_exists(CorpseActive))) return false
    var _key=scrNTTEFullAreaKey(GameCont.area)
    // Pizza is intentionally absent from the original completion pack list.
    if(array_get_index(["coast","oasis","trench","lair","red"],_key)<0) return false
    if(GameCont.subarea<scrNTTEFullAreaInfo(_key).subareas) return false
    return scrNTTEFullUnlockSet("pack:"+_key,true)
}

// Source crowns/*.crown_menu_avail is global loadout:crown:key ownership;
// native per-race crowngot arrays cannot represent that separate progression.
function scrNTTEFullCrownLoadoutSlots() {
    var _slots=[]
    for(var _id=0;_id<=13;++_id) array_push(_slots,_id)
    for(var _id=14;_id<=16;++_id) if(scrNTTEFullFeatureReady("crown:"+scrNTTEFullCrownKey(_id))) array_push(_slots,_id)
    return _slots
}
function scrNTTEFullCrownLoadoutAvailable(_race,_crown) {
    return scr_race_is_unlocked(_race) && scrNTTEFullFeatureReady("crown:"+scrNTTEFullCrownKey(_crown))
        && scrNTTEFullCrownAvailable(_crown,true)
}
function scrNTTEFullCrownLoadoutCount(_race) {
    var _count=0
    if(!scr_race_is_unlocked(_race)) return 0
    // Native count historically includes native non-none crowns but excludes
    // random. Count actual ownership to avoid adding custom crowns twice to a
    // previously cached crownmax16 total.
    for(var _id=1;_id<=13;++_id) if(_id>crwn_none && UberCont.crowngot[_race,_id]) _count+=1
    for(var _id=14;_id<=16;++_id) if(scrNTTEFullCrownLoadoutAvailable(_race,_id)) _count+=1
    return _count
}
function scrNTTEFullCrownLoadoutSprite(_crown,_unlocked=true) {
    if(_crown>=14 && _crown<=16) return [scrNTTEFullCrownSprite(_crown,"Loadout"),_unlocked?0:1]
    return [_unlocked?sprLoadoutCrown:sprLockedLoadoutCrown,_crown]
}
function scrNTTEFullCrownLoadoutUnlockCurrent() {
    var _key=scrNTTEFullCrownKey(GameCont.crown)
    if(_key=="") return false
    return scrNTTEFullUnlockSet("loadout:crown:"+_key,true)
}

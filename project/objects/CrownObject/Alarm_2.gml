visible = 1

crown = GameCont.crown

// BEGIN NTTE SOURCE CROWN OBJECT ART
if(crown>=14 && crown<=16) {
    spr_idle=scrNTTEFullCrownSprite(crown,"Idle")
    spr_walk=scrNTTEFullCrownSprite(crown,"Walk")
}
else {
spr_idle = asset_get_index("sprCrown" + string(crown) + "Idle")
spr_walk = asset_get_index("sprCrown" + string(crown) + "Walk")
}
// END NTTE SOURCE CROWN OBJECT ART

sprite_index = spr_idle
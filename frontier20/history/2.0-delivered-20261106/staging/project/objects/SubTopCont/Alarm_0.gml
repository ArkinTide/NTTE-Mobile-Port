var _bones = bones, _count = 0

with (Bones) _bones[_count++] = id

bonecount = _count

alarm[0] = 30

with (TopPot) {
    // NTTE wall occupants also sit on full Wall tiles. The Epsilon decal
    // cleanup otherwise removes their live collision target after one second,
    // before a player can find or break the special Spider nest.
    if (scrNTTEFullValue(id,"name","")=="NTTEWallEnemy" && place_meeting(x,y,Wall)) continue;
    if (!place_meeting(x, y, TopSmall)) instance_destroy()
}
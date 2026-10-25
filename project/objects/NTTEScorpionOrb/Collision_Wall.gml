// NTTE merged native collision entry, preserving inherited dispatch.
var _ntte_merge_collision=scrNTTEFullMergedNativeCollisionBegin(id,other.id);
if(!is_undefined(_ntte_merge_collision) && !_ntte_merge_collision.allow) { scrNTTEFullMergedNativeCollisionEnd(_ntte_merge_collision); exit; }
try {
if (lockstep_stop) exit
if (!ntte_orb_fired) scrWallDestroy(other.id)
else if (speed>timescale) {
    move_bounce_solid(true)
    speed=min(speed,8*timescale)
    snd_play(sndShotgunHitWall,1.2,1)
    snd_play(sndFrogEggHurt,0.7,0.3)
}
}
finally {
    scrNTTEFullMergedNativeCollisionEnd(_ntte_merge_collision);
}

// NTTE merged native collision entry, preserving inherited dispatch.
var _ntte_merge_collision=scrNTTEFullMergedNativeCollisionBegin(id,other.id);
if(!is_undefined(_ntte_merge_collision) && !_ntte_merge_collision.allow) { scrNTTEFullMergedNativeCollisionEnd(_ntte_merge_collision); exit; }
try {
if (lockstep_stop) exit
if (speed>0) {
    move_bounce_solid(false)
    speed/=3
    friction=0.4*timescale*timescale
    snd_play_hit(sndGrenadeHitWall,0.2)
}
}
finally {
    scrNTTEFullMergedNativeCollisionEnd(_ntte_merge_collision);
}

// NTTE merged native collision entry, preserving inherited dispatch.
var _ntte_merge_collision=scrNTTEFullMergedNativeCollisionBegin(id,other.id);
if(!is_undefined(_ntte_merge_collision) && !_ntte_merge_collision.allow) { scrNTTEFullMergedNativeCollisionEnd(_ntte_merge_collision); exit; }
try {
if lockstep_stop
	exit

move_bounce_solid(true)
move_outside_solid(point_direction(other.x + 8, other.y + 8, x, y), 2)
if (speed > (4) * timescale && mask_index != mskWepPickup) snd_play_hit(sndHitWall)
if (friction == 0) friction = (0.5) * timescale * timescale
speed *= 0.4
}
finally {
    scrNTTEFullMergedNativeCollisionEnd(_ntte_merge_collision);
}

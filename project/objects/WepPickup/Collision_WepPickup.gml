// NTTE merged native collision entry, preserving inherited dispatch.
var _ntte_merge_collision=scrNTTEFullMergedNativeCollisionBegin(id,other.id);
if(!is_undefined(_ntte_merge_collision) && !_ntte_merge_collision.allow) { scrNTTEFullMergedNativeCollisionEnd(_ntte_merge_collision); exit; }
try {
if lockstep_stop
	exit

if speed < (4) * timescale && visible {
	motion_add(point_direction(other.x, other.y, x, y), (2) * timescale)
	if (speed > (4) * timescale) speed = (4) * timescale
}
}
finally {
    scrNTTEFullMergedNativeCollisionEnd(_ntte_merge_collision);
}

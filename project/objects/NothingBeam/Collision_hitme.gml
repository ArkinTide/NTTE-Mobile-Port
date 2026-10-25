// NTTE merged native collision entry, preserving inherited dispatch.
var _ntte_merge_collision=scrNTTEFullMergedNativeCollisionBegin(id,other.id);
if(!is_undefined(_ntte_merge_collision) && !_ntte_merge_collision.allow) { scrNTTEFullMergedNativeCollisionEnd(_ntte_merge_collision); exit; }
try {
if (!disappear && scr_can_hit(other.id, (other.object_index == Player))) {
	scr_hit(other.id, 5, hitid)
	
	with (other) {
		motion_add(270, (12) * timescale)
		if (speed > (16) * timescale) speed = (16) * timescale
	}
}
}
finally {
    scrNTTEFullMergedNativeCollisionEnd(_ntte_merge_collision);
}

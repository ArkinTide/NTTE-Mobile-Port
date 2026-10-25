// NTTE merged native collision entry, preserving inherited dispatch.
var _ntte_merge_collision=scrNTTEFullMergedNativeCollisionBegin(id,other.id);
if(!is_undefined(_ntte_merge_collision) && !_ntte_merge_collision.allow) { scrNTTEFullMergedNativeCollisionEnd(_ntte_merge_collision); exit; }
try {
if (scr_projectile_generic_hit(false, false)) {
	instance_create(other.x, other.y, Smoke)
}

sleep(5)
}
finally {
    scrNTTEFullMergedNativeCollisionEnd(_ntte_merge_collision);
}

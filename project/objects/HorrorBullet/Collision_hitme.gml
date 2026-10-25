// NTTE merged native collision entry, preserving inherited dispatch.
var _ntte_merge_collision=scrNTTEFullMergedNativeCollisionBegin(id,other.id);
if(!is_undefined(_ntte_merge_collision) && !_ntte_merge_collision.allow) { scrNTTEFullMergedNativeCollisionEnd(_ntte_merge_collision); exit; }
try {
if other.object_index == ProtoStatue {
    with instance_create(x, y, Rad) {
		motion_add(other.direction, other.speed)
	}
	
    instance_destroy()
}
else if scr_projectile_generic_hit(true, false) {
	with (other) raddrop ++
}
}
finally {
    scrNTTEFullMergedNativeCollisionEnd(_ntte_merge_collision);
}

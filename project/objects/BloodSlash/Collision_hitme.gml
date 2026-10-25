// NTTE merged native collision entry, preserving inherited dispatch.
var _ntte_merge_collision=scrNTTEFullMergedNativeCollisionBegin(id,other.id);
if(!is_undefined(_ntte_merge_collision) && !_ntte_merge_collision.allow) { scrNTTEFullMergedNativeCollisionEnd(_ntte_merge_collision); exit; }
try {
if scr_projectile_generic_hit(false) {
	if instance_exists(other) {
		var _x, _y;
		
		with other {
			_x = bbox_center_x
			_y = bbox_center_y
		}
		
		instance_create(_x, _y, MeatExplosion)
	}
	
	hit = true
}
}
finally {
    scrNTTEFullMergedNativeCollisionEnd(_ntte_merge_collision);
}

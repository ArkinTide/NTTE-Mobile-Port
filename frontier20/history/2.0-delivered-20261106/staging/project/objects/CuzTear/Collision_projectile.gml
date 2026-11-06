// NTTE merged native collision entry, preserving inherited dispatch.
var _ntte_merge_collision=scrNTTEFullMergedNativeCollisionBegin(id,other.id);
if(!is_undefined(_ntte_merge_collision) && !_ntte_merge_collision.allow) { scrNTTEFullMergedNativeCollisionEnd(_ntte_merge_collision); exit; }
try {
if (other.typ != 0 && team != other.team) {
	instance_destroy(other.id)
	
	if (sprite_index != spr_fade) {
		sprite_index = spr_fade
		image_speed = (0.4) * timescale
		image_index = 0
		speed = 0
	}
}
}
finally {
    scrNTTEFullMergedNativeCollisionEnd(_ntte_merge_collision);
}

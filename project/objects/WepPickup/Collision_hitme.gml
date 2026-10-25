// NTTE merged native collision entry, preserving inherited dispatch.
var _ntte_merge_collision=scrNTTEFullMergedNativeCollisionBegin(id,other.id);
if(!is_undefined(_ntte_merge_collision) && !_ntte_merge_collision.allow) { scrNTTEFullMergedNativeCollisionEnd(_ntte_merge_collision); exit; }
try {
if (speed > (4) * timescale && mask_index != mskWepPickup && scr_can_hit(other.id)) {
	var _level = (instance_is(creator, Player) ? GameCont.level : 0)
	
	if (!scr_hit(other.id, 22 + 2 * _level)) exit
	
	instance_create(x, y, ThrowHit)
	
	// pierce through
	if (instance_is(creator, Player) && creator.race == Race.Chicken && scr_skill_get(mut_throne_butt)) {
		speed *= 0.8
	}
	else {
		friction = (0.5) * timescale * timescale
		motion_add(point_direction(other.x, other.y, x, y), speed * 1.5)
		speed /= 3
		speed ++
	}
}
}
finally {
    scrNTTEFullMergedNativeCollisionEnd(_ntte_merge_collision);
}

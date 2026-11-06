// NTTE merged native collision entry, preserving inherited dispatch.
var _ntte_merge_collision=scrNTTEFullMergedNativeCollisionBegin(id,other.id);
if(!is_undefined(_ntte_merge_collision) && !_ntte_merge_collision.allow) { scrNTTEFullMergedNativeCollisionEnd(_ntte_merge_collision); exit; }
try {
if other.object_index == Explosion || other.object_index == GreenExplosion {
	var _dir = point_direction(other.x + orandom(1), other.y + orandom(1), x, y)
	
	x += lengthdir_x(6, _dir) * timescale
    y += lengthdir_y(6, _dir) * timescale
}
else if other.object_index == SmallExplosion {
	var _dir = point_direction(other.x + orandom(1), other.y + orandom(1), x, y)
	
	x += lengthdir_x(6, _dir) * timescale
    y += lengthdir_y(6, _dir) * timescale
}
}
finally {
    scrNTTEFullMergedNativeCollisionEnd(_ntte_merge_collision);
}

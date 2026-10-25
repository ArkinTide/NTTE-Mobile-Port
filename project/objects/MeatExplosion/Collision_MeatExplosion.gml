// NTTE merged native collision entry, preserving inherited dispatch.
var _ntte_merge_collision=scrNTTEFullMergedNativeCollisionBegin(id,other.id);
if(!is_undefined(_ntte_merge_collision) && !_ntte_merge_collision.allow) { scrNTTEFullMergedNativeCollisionEnd(_ntte_merge_collision); exit; }
try {
x += lengthdir_x(8, point_direction(other.x, other.y, x, y)) * timescale
y += lengthdir_y(8, point_direction(other.x, other.y, x, y)) * timescale
}
finally {
    scrNTTEFullMergedNativeCollisionEnd(_ntte_merge_collision);
}

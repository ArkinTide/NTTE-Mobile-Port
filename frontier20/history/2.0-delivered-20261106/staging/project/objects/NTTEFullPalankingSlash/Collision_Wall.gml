// NTTE merged native collision entry, preserving inherited dispatch.
var _ntte_merge_collision=scrNTTEFullMergedNativeCollisionBegin(id,other.id);
if(!is_undefined(_ntte_merge_collision) && !_ntte_merge_collision.allow) { scrNTTEFullMergedNativeCollisionEnd(_ntte_merge_collision); exit; }
try {
// Source CustomSlash retains slash while overlapping a wall.
}
finally {
    scrNTTEFullMergedNativeCollisionEnd(_ntte_merge_collision);
}

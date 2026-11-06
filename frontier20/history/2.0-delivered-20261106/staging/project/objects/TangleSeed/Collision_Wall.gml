// NTTE merged native collision entry, preserving inherited dispatch.
var _ntte_merge_collision=scrNTTEFullMergedNativeCollisionBegin(id,other.id);
if(!is_undefined(_ntte_merge_collision) && !_ntte_merge_collision.allow) { scrNTTEFullMergedNativeCollisionEnd(_ntte_merge_collision); exit; }
try {
if lockstep_stop
	exit

with (instance_create(x, y, Tangle)) {
	creator = other.creator
            sprite_index=scrNTTEFullSkinTargetSprite(creator,sprite_index,"body")
	team = other.team
}
instance_create(x, y, Dust)
instance_destroy()
}
finally {
    scrNTTEFullMergedNativeCollisionEnd(_ntte_merge_collision);
}

// NTTE merged native collision entry, preserving inherited dispatch.
var _ntte_merge_collision=scrNTTEFullMergedNativeCollisionBegin(id,other.id);
if(!is_undefined(_ntte_merge_collision) && !_ntte_merge_collision.allow) { scrNTTEFullMergedNativeCollisionEnd(_ntte_merge_collision); exit; }
try {
if scr_can_hit(other.id, false) {
    with (instance_create(x, y, Tangle)) {
		team = other.team
		creator = other.creator
            sprite_index=scrNTTEFullSkinTargetSprite(creator,sprite_index,"body")
	}
    instance_create(x, y, Dust)
    instance_destroy()
}
}
finally {
    scrNTTEFullMergedNativeCollisionEnd(_ntte_merge_collision);
}

// NTTE merged native collision entry, preserving inherited dispatch.
var _ntte_merge_collision=scrNTTEFullMergedNativeCollisionBegin(id,other.id);
if(!is_undefined(_ntte_merge_collision) && !_ntte_merge_collision.allow) { scrNTTEFullMergedNativeCollisionEnd(_ntte_merge_collision); exit; }
try {
if scr_projectile_generic_hit(false) {
	instance_create(x, y, Smoke)
	snd_play(sndLightningHit)
}
}
finally {
    scrNTTEFullMergedNativeCollisionEnd(_ntte_merge_collision);
}

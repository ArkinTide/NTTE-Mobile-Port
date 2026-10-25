// NTTE merged native collision entry, preserving inherited dispatch.
var _ntte_merge_collision=scrNTTEFullMergedNativeCollisionBegin(id,other.id);
if(!is_undefined(_ntte_merge_collision) && !_ntte_merge_collision.allow) { scrNTTEFullMergedNativeCollisionEnd(_ntte_merge_collision); exit; }
try {
if (instance_is(other,NTTECat)) exit

if (instance_is(other, FrogQueen) || instance_is(other, Exploder)
	|| instance_is(other, SuperFrog) || (instance_is(other, Player) && !other.cantoxic)
) {
	exit
}

if instance_exists(other.id) && scr_can_hit(other.id) {
	scr_hit(other.id, damage, hitid)
	instance_destroy()
}
}
finally {
    scrNTTEFullMergedNativeCollisionEnd(_ntte_merge_collision);
}

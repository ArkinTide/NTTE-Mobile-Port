// NTTE merged native collision entry, preserving inherited dispatch.
var _ntte_merge_collision=scrNTTEFullMergedNativeCollisionBegin(id,other.id);
if(!is_undefined(_ntte_merge_collision) && !_ntte_merge_collision.allow) { scrNTTEFullMergedNativeCollisionEnd(_ntte_merge_collision); exit; }
try {
if (!instance_is(other, enemy) && !instance_is(other, prop)) {
	if (scr_projectile_generic_flame_hit()) exit
	
	if sprite_index != sprFireLilHunter {
	    x = xprevious
	    y = yprevious
	}
}
}
finally {
    scrNTTEFullMergedNativeCollisionEnd(_ntte_merge_collision);
}

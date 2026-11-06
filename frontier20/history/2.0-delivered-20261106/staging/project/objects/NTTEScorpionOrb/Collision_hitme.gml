// NTTE merged native collision entry, preserving inherited dispatch.
var _ntte_merge_collision=scrNTTEFullMergedNativeCollisionBegin(id,other.id);
if(!is_undefined(_ntte_merge_collision) && !_ntte_merge_collision.allow) { scrNTTEFullMergedNativeCollisionEnd(_ntte_merge_collision); exit; }
try {
if (lockstep_stop) exit
if (scr_can_hit(other.id,true) && scr_projectile_hit(other.id,damage,knockback_speed)) {
    if (instance_exists(other.id)) with (other.id) nexthurt=max(nexthurt,current_frame+40)
    if (ntte_orb_fired) instance_destroy()
}
}
finally {
    scrNTTEFullMergedNativeCollisionEnd(_ntte_merge_collision);
}

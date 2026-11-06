// NTT CustomProjectile outer team gate.
if(team==other.team) exit;
// NTTE merged native collision entry, preserving inherited dispatch.
var _ntte_merge_collision=scrNTTEFullMergedNativeCollisionBegin(id,other.id);
if(!is_undefined(_ntte_merge_collision) && !_ntte_merge_collision.allow) { scrNTTEFullMergedNativeCollisionEnd(_ntte_merge_collision); exit; }
try {
if(lockstep_stop) exit; scrNTTEFullBoneArrowSetup(); if(scr_can_hit(other.id,true)) scr_projectile_hit(other.id,damage+2*ntte_full_bonus,knockback_speed);
}
finally {
    scrNTTEFullMergedNativeCollisionEnd(_ntte_merge_collision);
}

// NTT CustomProjectile outer team gate.
if(team==other.team) exit;
// NTTE merged native collision entry, preserving inherited dispatch.
var _ntte_merge_collision=scrNTTEFullMergedNativeCollisionBegin(id,other.id);
if(!is_undefined(_ntte_merge_collision) && !_ntte_merge_collision.allow) { scrNTTEFullMergedNativeCollisionEnd(_ntte_merge_collision); exit; }
try {
scrNTTEFullCustomPlasmaHit(other.id);
}
finally {
    scrNTTEFullMergedNativeCollisionEnd(_ntte_merge_collision);
}

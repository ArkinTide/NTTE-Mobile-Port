// BEGIN NTTE CUZ CONNECTED TEST BULLET CONTACT BEFORE
var _ntte_cuz_hit_sample=undefined;
if(os_type==os_windows && scrNTTEFullSmokeEnabled() && instance_exists(NTTEFullCuzConnectedTest)) try { _ntte_cuz_hit_sample=scrNTTEFullCuzConnectedHitBefore(id,other.id); }
catch(_ntte_cuz_connected_error) { scrNTTEFullCuzConnectedAbort(_ntte_cuz_connected_error); }
// END NTTE CUZ CONNECTED TEST BULLET CONTACT BEFORE
// NTTE merged native collision entry, preserving inherited dispatch.
var _ntte_merge_collision=scrNTTEFullMergedNativeCollisionBegin(id,other.id);
if(!is_undefined(_ntte_merge_collision) && !_ntte_merge_collision.allow) { scrNTTEFullMergedNativeCollisionEnd(_ntte_merge_collision); exit; }
try {
scr_projectile_generic_hit(true, (team != team_player))
}
finally {
    scrNTTEFullMergedNativeCollisionEnd(_ntte_merge_collision);
}

// BEGIN NTTE CUZ CONNECTED TEST BULLET CONTACT AFTER
if(os_type==os_windows && scrNTTEFullSmokeEnabled() && instance_exists(NTTEFullCuzConnectedTest)) try { scrNTTEFullCuzConnectedHitAfter(_ntte_cuz_hit_sample); }
catch(_ntte_cuz_connected_error) { scrNTTEFullCuzConnectedAbort(_ntte_cuz_connected_error); }
// END NTTE CUZ CONNECTED TEST BULLET CONTACT AFTER
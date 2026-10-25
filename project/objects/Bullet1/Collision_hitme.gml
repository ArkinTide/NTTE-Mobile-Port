// BEGIN NTTE TRENCH SECOND HOP TEST BULLET BEFORE
var _ntte_trench_second_hop_collision_sample=undefined;
if(os_type==os_windows && scrNTTEFullSmokeEnabled() && instance_exists(NTTEFullTrenchSecondHopConnectedTest)) try { _ntte_trench_second_hop_collision_sample=scrNTTEFullTrenchSecondHopBulletBefore(other.id); }
catch(_ntte_trench_second_hop_error) { scrNTTEFullTrenchSecondHopAbort(_ntte_trench_second_hop_error); }
// END NTTE TRENCH SECOND HOP TEST BULLET BEFORE
// BEGIN NTTE TRENCH CONNECTED CAMPAIGN TEST BULLET BEFORE
var _ntte_trench_campaign_collision_sample=undefined;
if(os_type==os_windows && scrNTTEFullSmokeEnabled() && instance_exists(NTTEFullTrenchConnectedCampaignTest)) try { _ntte_trench_campaign_collision_sample=scrNTTEFullTrenchCampaignBulletBefore(other.id); }
catch(_ntte_trench_campaign_error) { scrNTTEFullTrenchCampaignAbort(_ntte_trench_campaign_error); }
// END NTTE TRENCH CONNECTED CAMPAIGN TEST BULLET BEFORE
// BEGIN NTTE OASIS TRENCH READONLY BULLET COLLISION BEFORE
var _ntte_oasis_trench_collision_sample=undefined;
if(os_type==os_windows && scrNTTEFullSmokeEnabled() && instance_exists(NTTEFullOasisTrenchNaturalEntryTest))
    _ntte_oasis_trench_collision_sample=scrNTTEFullOasisTrenchEntryBulletBefore(other.id);
// END NTTE OASIS TRENCH READONLY BULLET COLLISION BEFORE
// BEGIN NTTE PROTO STATUE ENTRY TEST BULLET BEFORE
var _ntte_proto_bullet_sample=undefined;
if(os_type==os_windows && scrNTTEFullSmokeEnabled() && instance_exists(NTTEFullProtoStatueNaturalEntryTest)) _ntte_proto_bullet_sample=scrNTTEFullProtoEntryBulletBefore(other.id);
// END NTTE PROTO STATUE ENTRY TEST BULLET BEFORE
// NTTE merged native collision entry, preserving inherited dispatch.
var _ntte_merge_collision=scrNTTEFullMergedNativeCollisionBegin(id,other.id);
if(!is_undefined(_ntte_merge_collision) && !_ntte_merge_collision.allow) { scrNTTEFullMergedNativeCollisionEnd(_ntte_merge_collision); exit; }
try {
// BEGIN NTTE PARROT B CONNECTED READONLY BULLET COLLISION
var _ntte_parrot_b_collision_sample=undefined;
if(os_type==os_windows && scrNTTEFullSmokeEnabled() && instance_exists(NTTEFullParrotBConnectedTest))
    _ntte_parrot_b_collision_sample=scrNTTEFullParrotBConnectedBulletBefore(other.id);
scr_projectile_generic_bullet_hit()
if(os_type==os_windows && scrNTTEFullSmokeEnabled() && instance_exists(NTTEFullParrotBConnectedTest))
    scrNTTEFullParrotBConnectedBulletAfter(_ntte_parrot_b_collision_sample);
// END NTTE PARROT B CONNECTED READONLY BULLET COLLISION
}
finally {
    scrNTTEFullMergedNativeCollisionEnd(_ntte_merge_collision);
}

// BEGIN NTTE PROTO STATUE ENTRY TEST BULLET AFTER
if(os_type==os_windows && scrNTTEFullSmokeEnabled() && instance_exists(NTTEFullProtoStatueNaturalEntryTest)) scrNTTEFullProtoEntryBulletAfter(_ntte_proto_bullet_sample);
// END NTTE PROTO STATUE ENTRY TEST BULLET AFTER
// BEGIN NTTE OASIS TRENCH READONLY BULLET COLLISION AFTER
if(os_type==os_windows && scrNTTEFullSmokeEnabled() && instance_exists(NTTEFullOasisTrenchNaturalEntryTest))
    scrNTTEFullOasisTrenchEntryBulletAfter(_ntte_oasis_trench_collision_sample);
// END NTTE OASIS TRENCH READONLY BULLET COLLISION AFTER
// BEGIN NTTE TRENCH CONNECTED CAMPAIGN TEST BULLET AFTER
if(os_type==os_windows && scrNTTEFullSmokeEnabled() && instance_exists(NTTEFullTrenchConnectedCampaignTest)) try { scrNTTEFullTrenchCampaignBulletAfter(_ntte_trench_campaign_collision_sample); }
catch(_ntte_trench_campaign_error) { scrNTTEFullTrenchCampaignAbort(_ntte_trench_campaign_error); }
// END NTTE TRENCH CONNECTED CAMPAIGN TEST BULLET AFTER
// BEGIN NTTE TRENCH SECOND HOP TEST BULLET AFTER
if(os_type==os_windows && scrNTTEFullSmokeEnabled() && instance_exists(NTTEFullTrenchSecondHopConnectedTest)) try { scrNTTEFullTrenchSecondHopBulletAfter(_ntte_trench_second_hop_collision_sample); }
catch(_ntte_trench_second_hop_error) { scrNTTEFullTrenchSecondHopAbort(_ntte_trench_second_hop_error); }
// END NTTE TRENCH SECOND HOP TEST BULLET AFTER
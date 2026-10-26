scrUGRoomStart();
novans = false

if (area == area_palace && subarea == maxsubarea) || (area == area_hq && subarea == maxsubarea)
|| loops == 0 || area == area_vault || area == area_campfire || area == area_crib {
	novans = true
}

if area == area_vault crownvisits ++
if area == area_jungle junglevisits ++

// BEGIN NTTE SOURCE AREA ROOMSTART UNDERWATER
// Original telib.area_get_underwater dispatches custom area_underwater first.
// Preserve vanilla Oasis and the two registered source-authored water areas.
underwater = (area == area_oasis || area == scrNTTEFullAreaId("oasis") || area == scrNTTEFullAreaId("trench"))
// END NTTE SOURCE AREA ROOMSTART UNDERWATER

is_level_ended = false

// No last-hostile timer may carry into another level, even within romGame.
scrNTTELastEnemyTimeoutReset()

scrAmmoUpdateTypeStats()
// BEGIN NTTE TRENCH CONNECTED CAMPAIGN TEST GameCont.RoomStart.after
if(os_type==os_windows && scrNTTEFullSmokeEnabled() && instance_exists(NTTEFullTrenchConnectedCampaignTest) && instance_exists(id)) try { scrNTTEFullTrenchCampaignProbe("GameCont.RoomStart.after"); }
catch(_ntte_trench_campaign_error) { scrNTTEFullTrenchCampaignAbort(_ntte_trench_campaign_error); }
// END NTTE TRENCH CONNECTED CAMPAIGN TEST GameCont.RoomStart.after
// BEGIN NTTE TRENCH SECOND HOP TEST GameCont.RoomStart.after
if(os_type==os_windows && scrNTTEFullSmokeEnabled() && instance_exists(NTTEFullTrenchSecondHopConnectedTest) && instance_exists(id)) try { scrNTTEFullTrenchSecondHopProbe("GameCont.RoomStart.after"); }
catch(_ntte_trench_second_hop_error) { scrNTTEFullTrenchSecondHopAbort(_ntte_trench_second_hop_error); }
// END NTTE TRENCH SECOND HOP TEST GameCont.RoomStart.after
// BEGIN NTTE PALACE ARTIFACT PORTAL CARRY TEST EXIT GameCont.RoomStart.after
if(os_type==os_windows && scrNTTEFullSmokeEnabled() && instance_exists(NTTEFullPalaceArtifactPortalCarryTest)) try { scrNTTEFullPalaceArtifactPortalCarryExitProbe("GameCont.RoomStart.after"); }
catch(_ntte_palace_carry_error) { scrNTTEFullPalaceArtifactPortalCarryAbort(_ntte_palace_carry_error); }
// END NTTE PALACE ARTIFACT PORTAL CARRY TEST EXIT GameCont.RoomStart.after

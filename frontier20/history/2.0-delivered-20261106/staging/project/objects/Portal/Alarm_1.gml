// BEGIN NTTE TRENCH SECOND HOP TEST Portal.Alarm1.before
if(os_type==os_windows && scrNTTEFullSmokeEnabled() && instance_exists(NTTEFullTrenchSecondHopConnectedTest) && instance_exists(id)) try { scrNTTEFullTrenchSecondHopProbe("Portal.Alarm1.before"); }
catch(_ntte_trench_second_hop_error) { scrNTTEFullTrenchSecondHopAbort(_ntte_trench_second_hop_error); }
// END NTTE TRENCH SECOND HOP TEST Portal.Alarm1.before
// BEGIN NTTE TRENCH CONNECTED CAMPAIGN TEST Portal.Alarm1.before
if(os_type==os_windows && scrNTTEFullSmokeEnabled() && instance_exists(NTTEFullTrenchConnectedCampaignTest) && instance_exists(id)) try { scrNTTEFullTrenchCampaignProbe("Portal.Alarm1.before"); }
catch(_ntte_trench_campaign_error) { scrNTTEFullTrenchCampaignAbort(_ntte_trench_campaign_error); }
// END NTTE TRENCH CONNECTED CAMPAIGN TEST Portal.Alarm1.before
// BEGIN NTTE LAIR BATTLE EXIT READONLY PROBE Portal.Alarm1.before
if(os_type==os_windows && scrNTTEFullSmokeEnabled() && instance_exists(id)
    && instance_exists(NTTEFullLairBattleExitNaturalTest))
    scrNTTEFullLairBattleExitProbe("Portal.Alarm1.before");
// END NTTE LAIR BATTLE EXIT READONLY PROBE Portal.Alarm1.before
// BEGIN NTTE OASIS TRENCH READONLY PROBE Portal.Alarm1.before
if(os_type==os_windows && scrNTTEFullSmokeEnabled() && instance_exists(id)
    && instance_exists(NTTEFullOasisTrenchNaturalEntryTest))
    scrNTTEFullOasisTrenchEntryProbe("Portal.Alarm1.before");
// END NTTE OASIS TRENCH READONLY PROBE Portal.Alarm1.before
// BEGIN NTTE PROTO STATUE ENTRY TEST Portal.Alarm1 before
if(os_type==os_windows && scrNTTEFullSmokeEnabled() && instance_exists(NTTEFullProtoStatueNaturalEntryTest)) scrNTTEFullProtoEntryProbe("Portal.Alarm1.before");
// END NTTE PROTO STATUE ENTRY TEST Portal.Alarm1 before
// BEGIN NTTE PARROT B CONNECTED READONLY PORTAL Alarm1.before
if(os_type==os_windows && scrNTTEFullSmokeEnabled() && instance_exists(NTTEFullParrotBConnectedTest))
    scrNTTEFullParrotBConnectedPortalProbe("Alarm1.before");
// END NTTE PARROT B CONNECTED READONLY PORTAL Alarm1.before
// BEGIN NTTE SEWER PIZZA TEST PROBE Portal.Alarm1.before
if(os_type==os_windows && scrNTTEFullSmokeEnabled() && instance_exists(id))
    scrNTTEFullSewerPizzaEntryProbe("Portal.Alarm1.before");
// END NTTE SEWER PIZZA TEST PROBE Portal.Alarm1.before
if instance_exists(TutCont) {
	game_restart()
	exit
}

with (WepPickup) {
	if (!visible || persistent) continue
	
    if (wep == wep_chicken_sword && GameCont.area == area_desert && GameCont.subarea == 1) {
        GameCont.blackswords ++
	}
}

snd_stop(sndPortalLoop)

GameCont.is_level_ended = true

instance_activate_all()

scrNTTEFullBeetleChestBeforeRoomEnd();
// BEGIN NTTE QUEST ARTIFACT CARRY LIFECYCLE TEST PORTAL ALARM
if(os_type==os_windows && scrNTTEFullSmokeEnabled() && instance_exists(NTTEFullQuestCarryTest)) try { scrNTTEFullQuestCarryProbe("PortalAlarm"); }
catch(_ntte_quest_carry_error) { scrNTTEFullQuestCarryAbort(_ntte_quest_carry_error); }
// END NTTE QUEST ARTIFACT CARRY LIFECYCLE TEST PORTAL ALARM
room_restart()
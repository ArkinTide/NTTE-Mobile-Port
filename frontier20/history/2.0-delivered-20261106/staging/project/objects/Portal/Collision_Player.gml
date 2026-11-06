// BEGIN NTTE PALACE ARTIFACT PORTAL CARRY TEST EXIT BigPortal.Contact.before
if(os_type==os_windows && scrNTTEFullSmokeEnabled() && instance_exists(NTTEFullPalaceArtifactPortalCarryTest)) try { scrNTTEFullPalaceArtifactPortalCarryExitProbe("BigPortal.Contact.before"); }
catch(_ntte_palace_carry_error) { scrNTTEFullPalaceArtifactPortalCarryAbort(_ntte_palace_carry_error); }
// END NTTE PALACE ARTIFACT PORTAL CARRY TEST EXIT BigPortal.Contact.before
// BEGIN NTTE TRENCH SECOND HOP TEST Portal.Contact.before
if(os_type==os_windows && scrNTTEFullSmokeEnabled() && instance_exists(NTTEFullTrenchSecondHopConnectedTest) && instance_exists(id)) try { scrNTTEFullTrenchSecondHopProbe("Portal.Contact.before"); }
catch(_ntte_trench_second_hop_error) { scrNTTEFullTrenchSecondHopAbort(_ntte_trench_second_hop_error); }
// END NTTE TRENCH SECOND HOP TEST Portal.Contact.before
// BEGIN NTTE TRENCH CONNECTED CAMPAIGN TEST Portal.Contact.before
if(os_type==os_windows && scrNTTEFullSmokeEnabled() && instance_exists(NTTEFullTrenchConnectedCampaignTest) && instance_exists(id)) try { scrNTTEFullTrenchCampaignProbe("Portal.Contact.before"); }
catch(_ntte_trench_campaign_error) { scrNTTEFullTrenchCampaignAbort(_ntte_trench_campaign_error); }
// END NTTE TRENCH CONNECTED CAMPAIGN TEST Portal.Contact.before
// BEGIN NTTE LAIR BATTLE EXIT READONLY PROBE Portal.Contact.before
if(os_type==os_windows && scrNTTEFullSmokeEnabled() && instance_exists(id)
    && instance_exists(NTTEFullLairBattleExitNaturalTest))
    scrNTTEFullLairBattleExitProbe("Portal.Contact.before");
// END NTTE LAIR BATTLE EXIT READONLY PROBE Portal.Contact.before
// BEGIN NTTE OASIS TRENCH READONLY PROBE Portal.Collision.Player.before
if(os_type==os_windows && scrNTTEFullSmokeEnabled() && instance_exists(id)
    && instance_exists(NTTEFullOasisTrenchNaturalEntryTest))
    scrNTTEFullOasisTrenchEntryProbe("Portal.Collision.Player.before");
// END NTTE OASIS TRENCH READONLY PROBE Portal.Collision.Player.before
// BEGIN NTTE PARROT B CONNECTED READONLY PORTAL Collision.Player.before
if(os_type==os_windows && scrNTTEFullSmokeEnabled() && instance_exists(NTTEFullParrotBConnectedTest))
    scrNTTEFullParrotBConnectedPortalProbe("Collision.Player.before");
// END NTTE PARROT B CONNECTED READONLY PORTAL Collision.Player.before
// BEGIN NTTE WORLD RESTART PORTAL DIAGNOSTIC
if(os_type==os_windows && instance_exists(NTTEFullWorldEventsRoomRestartTest))
    scrNTTEFullWorldEventsRoomRestartPortalProbe("Portal.Collision.Player.before");
// END NTTE WORLD RESTART PORTAL DIAGNOSTIC
if lockstep_stop
	exit

if (close) exit

other.depth = depth - 1
other.mask_index = mskNone
other.nexthurt = current_frame + 30

if (endgame > 30) {
	close = true
	
	alarm[1] = 90
	
	if (scr_ultra_get_from_race(Race.Robot) != -1) {
		var _tb = scr_skill_get(mut_throne_butt)
		
        var _ntte_eat_portal = id;
	    with (WepPickup) if (visible && !curse) {
            if (!persistent) with (_ntte_eat_portal) scrNTTEFullRobotEatWeapon(other.wep);
			with (Player) if (race == Race.Robot) {
				scrRobotEat(other.wep, true)
			}
			
			with (instance_create(x, y, RobotEat)) {
				if (_tb) sprite_index = sprRobotEatTB
			}
			
			instance_create(x, y, Smoke)
			ammo = false
		}
	}
	
	snd_play(sndPortalClose)
	endgame = 30
}

// BEGIN NTTE SEWER PIZZA TEST PROBE Portal.Collision.Player.after
if(os_type==os_windows && scrNTTEFullSmokeEnabled() && instance_exists(id))
    scrNTTEFullSewerPizzaEntryProbe("Portal.Collision.Player.after");
// END NTTE SEWER PIZZA TEST PROBE Portal.Collision.Player.after

// BEGIN NTTE WORLD RESTART PORTAL DIAGNOSTIC
if(os_type==os_windows && instance_exists(id) && instance_exists(NTTEFullWorldEventsRoomRestartTest))
    scrNTTEFullWorldEventsRoomRestartPortalProbe("Portal.Collision.Player.after");
// END NTTE WORLD RESTART PORTAL DIAGNOSTIC

// BEGIN NTTE PARROT B CONNECTED READONLY PORTAL Collision.Player.after
if(os_type==os_windows && scrNTTEFullSmokeEnabled() && instance_exists(NTTEFullParrotBConnectedTest))
    scrNTTEFullParrotBConnectedPortalProbe("Collision.Player.after");
// END NTTE PARROT B CONNECTED READONLY PORTAL Collision.Player.after
// BEGIN NTTE PROTO STATUE ENTRY TEST Portal.Contact after
if(os_type==os_windows && scrNTTEFullSmokeEnabled() && instance_exists(NTTEFullProtoStatueNaturalEntryTest)) scrNTTEFullProtoEntryProbe("Portal.Contact.after");
// END NTTE PROTO STATUE ENTRY TEST Portal.Contact after
// BEGIN NTTE OASIS TRENCH READONLY PROBE Portal.Collision.Player.after
if(os_type==os_windows && scrNTTEFullSmokeEnabled() && instance_exists(id)
    && instance_exists(NTTEFullOasisTrenchNaturalEntryTest))
    scrNTTEFullOasisTrenchEntryProbe("Portal.Collision.Player.after");
// END NTTE OASIS TRENCH READONLY PROBE Portal.Collision.Player.after
// BEGIN NTTE LAIR BATTLE EXIT READONLY PROBE Portal.Contact.after
if(os_type==os_windows && scrNTTEFullSmokeEnabled() && instance_exists(id)
    && instance_exists(NTTEFullLairBattleExitNaturalTest))
    scrNTTEFullLairBattleExitProbe("Portal.Contact.after");
// END NTTE LAIR BATTLE EXIT READONLY PROBE Portal.Contact.after
// BEGIN NTTE TRENCH CONNECTED CAMPAIGN TEST Portal.Contact.after
if(os_type==os_windows && scrNTTEFullSmokeEnabled() && instance_exists(NTTEFullTrenchConnectedCampaignTest) && instance_exists(id)) try { scrNTTEFullTrenchCampaignProbe("Portal.Contact.after"); }
catch(_ntte_trench_campaign_error) { scrNTTEFullTrenchCampaignAbort(_ntte_trench_campaign_error); }
// END NTTE TRENCH CONNECTED CAMPAIGN TEST Portal.Contact.after
// BEGIN NTTE TRENCH SECOND HOP TEST Portal.Contact.after
if(os_type==os_windows && scrNTTEFullSmokeEnabled() && instance_exists(NTTEFullTrenchSecondHopConnectedTest) && instance_exists(id)) try { scrNTTEFullTrenchSecondHopProbe("Portal.Contact.after"); }
catch(_ntte_trench_second_hop_error) { scrNTTEFullTrenchSecondHopAbort(_ntte_trench_second_hop_error); }
// END NTTE TRENCH SECOND HOP TEST Portal.Contact.after
// BEGIN NTTE PALACE ARTIFACT PORTAL CARRY TEST EXIT BigPortal.Contact.after
if(os_type==os_windows && scrNTTEFullSmokeEnabled() && instance_exists(NTTEFullPalaceArtifactPortalCarryTest)) try { scrNTTEFullPalaceArtifactPortalCarryExitProbe("BigPortal.Contact.after"); }
catch(_ntte_palace_carry_error) { scrNTTEFullPalaceArtifactPortalCarryAbort(_ntte_palace_carry_error); }
// END NTTE PALACE ARTIFACT PORTAL CARRY TEST EXIT BigPortal.Contact.after
// BEGIN NTTE QUEST ARTIFACT CARRY LIFECYCLE TEST PORTAL CONTACT
if(os_type==os_windows && scrNTTEFullSmokeEnabled() && instance_exists(NTTEFullQuestCarryTest)) try { scrNTTEFullQuestCarryProbe("PortalContact"); }
catch(_ntte_quest_carry_error) { scrNTTEFullQuestCarryAbort(_ntte_quest_carry_error); }
// END NTTE QUEST ARTIFACT CARRY LIFECYCLE TEST PORTAL CONTACT

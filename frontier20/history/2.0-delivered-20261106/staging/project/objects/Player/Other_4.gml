if (!instance_exists(GameCont)) exit

if (is_struct(ntte_state)) ntte_state.charge=0
if (is_struct(bntte_state)) bntte_state.charge=0

visible = true
sprite_index = spr_idle
depth = -2

if scr_player_is_local(index) {
	if (!UberCont.want_menu && !UberCont.want_restart) {
		scrUnlocksArea()
	}
	
	if (race == Race.Frog && !scrGameIsWeeklyRun()) scrRaceUnlock(Race.Frog)
	
    scrPlayerTryUnlockGoldenWeapons(id)
}

reload = 0
breload = 0

can_shoot = true
bcan_shoot = true

frogcharge = 0
froggas = 0

if !instance_exists(CrownObject) && GameCont.crown > 1 {
    with instance_create(x, y, CrownObject) {
        if (GameCont.area > 1)
		|| (GameCont.subarea > 1)
		|| ((GameCont.loops - UberCont.hardmode) > 0) {
            is_new = false
        }
    }
}

with CrownObject {
    x = other.x
    y = other.y

    spr_idle = GameCont.crown>=14 ? scrNTTEFullCrownSprite(GameCont.crown,"Idle"):asset_get_index("sprCrown" + string(GameCont.crown) + "Idle")
    spr_walk = GameCont.crown>=14 ? scrNTTEFullCrownSprite(GameCont.crown,"Walk"):asset_get_index("sprCrown" + string(GameCont.crown) + "Walk")
}

GameCont.deathcause = HitId.None

if (scrCrownCheck(Crown.Luck) && hp > 1) hp = 1

mask_index = mskPlayer

if race == Race.BigDog {
    mask_index = mskScrapBoss
}

if race == Race.Rebel {
    hp = min(hp + floor((max_hp - hp) / 2), max_hp)
	
	if bskin == SkinLetter.B {
	    if GameCont.area == area_city {
	        spr_idle = sprMutant10CIdle
	        spr_walk = sprMutant10CWalk
	        spr_hurt = sprMutant10CHurt
	        spr_dead = sprMutant10CDead
	    }
		else {
	        spr_idle = sprMutant10BIdle
	        spr_walk = sprMutant10BWalk
	        spr_hurt = sprMutant10BHurt
	        spr_dead = sprMutant10BDead
	    }
	}
}

scr_playerinstance_find(index).hp = hp

// BEGIN NTTE PALACE ARTIFACT CONTINUE TEST Player.RoomStart.after
if(os_type==os_windows && scrNTTEFullSmokeEnabled() && instance_exists(NTTEFullPalaceArtifactContinueTest)) try { scrNTTEFullPalaceArtifactContinueProbe("Player.RoomStart.after"); }
catch(_ntte_palace_artifact_error) { scrNTTEFullPalaceArtifactContinueAbort(_ntte_palace_artifact_error); }
// END NTTE PALACE ARTIFACT CONTINUE TEST Player.RoomStart.after
// BEGIN NTTE CUZ CONNECTED TEST Player.RoomStart
if(os_type==os_windows && scrNTTEFullSmokeEnabled() && instance_exists(NTTEFullCuzConnectedTest)) try { scrNTTEFullCuzConnectedProbe("Player.RoomStart",id); }
catch(_ntte_cuz_connected_error) { scrNTTEFullCuzConnectedAbort(_ntte_cuz_connected_error); }
// END NTTE CUZ CONNECTED TEST Player.RoomStart
// BEGIN NTTE TRENCH CONNECTED CAMPAIGN TEST Player.RoomStart.after
if(os_type==os_windows && scrNTTEFullSmokeEnabled() && instance_exists(NTTEFullTrenchConnectedCampaignTest) && instance_exists(id)) try { scrNTTEFullTrenchCampaignProbe("Player.RoomStart.after"); }
catch(_ntte_trench_campaign_error) { scrNTTEFullTrenchCampaignAbort(_ntte_trench_campaign_error); }
// END NTTE TRENCH CONNECTED CAMPAIGN TEST Player.RoomStart.after
// BEGIN NTTE TRENCH SECOND HOP TEST Player.RoomStart.after
if(os_type==os_windows && scrNTTEFullSmokeEnabled() && instance_exists(NTTEFullTrenchSecondHopConnectedTest) && instance_exists(id)) try { scrNTTEFullTrenchSecondHopProbe("Player.RoomStart.after"); }
catch(_ntte_trench_second_hop_error) { scrNTTEFullTrenchSecondHopAbort(_ntte_trench_second_hop_error); }
// END NTTE TRENCH SECOND HOP TEST Player.RoomStart.after
// BEGIN NTTE HQ STOLEN CONTINUE TEST Player.RoomStart.after
if(os_type==os_windows && scrNTTEFullSmokeEnabled() && instance_exists(NTTEFullHQStolenContinueTest)) try { scrNTTEFullHQStolenContinueProbe("Player.RoomStart.after"); }
catch(_ntte_hq_stolen_error) { scrNTTEFullHQStolenContinueAbort(_ntte_hq_stolen_error); }
// END NTTE HQ STOLEN CONTINUE TEST Player.RoomStart.after
// BEGIN NTTE PALACE ARTIFACT PORTAL CARRY TEST Player.RoomStart.after
if(os_type==os_windows && scrNTTEFullSmokeEnabled() && instance_exists(NTTEFullPalaceArtifactPortalCarryTest)) try { scrNTTEFullPalaceArtifactPortalCarryProbe("Player.RoomStart.after"); }
catch(_ntte_palace_carry_error) { scrNTTEFullPalaceArtifactPortalCarryAbort(_ntte_palace_carry_error); }
// END NTTE PALACE ARTIFACT PORTAL CARRY TEST Player.RoomStart.after
// BEGIN NTTE PALACE ARTIFACT PORTAL CARRY TEST EXIT Player.RoomStart.after
if(os_type==os_windows && scrNTTEFullSmokeEnabled() && instance_exists(NTTEFullPalaceArtifactPortalCarryTest)) try { scrNTTEFullPalaceArtifactPortalCarryExitProbe("Player.RoomStart.after"); }
catch(_ntte_palace_carry_error) { scrNTTEFullPalaceArtifactPortalCarryAbort(_ntte_palace_carry_error); }
// END NTTE PALACE ARTIFACT PORTAL CARRY TEST EXIT Player.RoomStart.after
// BEGIN NTTE QUEST ARTIFACT CARRY LIFECYCLE TEST PLAYER ROOM START
if(os_type==os_windows && scrNTTEFullSmokeEnabled() && instance_exists(NTTEFullQuestCarryTest)) try { scrNTTEFullQuestCarryProbe("PlayerRoomStart"); }
catch(_ntte_quest_carry_error) { scrNTTEFullQuestCarryAbort(_ntte_quest_carry_error); }
// END NTTE QUEST ARTIFACT CARRY LIFECYCLE TEST PLAYER ROOM START

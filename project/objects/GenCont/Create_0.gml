random_set_seed(global.rng_state[RNGStates.Generation])
instance_create(0, 0, TopCont)
wave = 0

with Player {
	x = 10016
	y = 10016
	xprevious = x
	yprevious = y
	xstart = x
	ystart = y
}

background_set_colour(scrAreaGetBackroundColor(GameCont.area))

scrTips()
scrNTTEFullLoadingTipsSetup(id);

goal = scrAreaGetGenerationGoal()

if (GameCont.area == area_campfire) {
    for (var xx = -2; xx <= 2; xx ++) {
        for (var yy = -1; yy <= 1; yy ++) {
            instance_create(10000 + xx * 32, 10000 + yy * 32, Floor)
        }
    }
	
    repeat (7) {
        with (instance_create(10000, 10000, FloorMaker)) goal = other.goal
    }
}

safespawn = scrAreaHasSafespawn()
safedir = choose(0, 90, 180, 270)

if save_get_value("game", "tutorial", true) {
	instance_create(x, y, TutCont)
	safespawn = true
    goal = 5
}

alarm[5] = 600

with instance_create(10000, 10000, FloorMaker) {
    goal = other.goal
}

with (GameCont) {
	if (!gocrib && scr_skill_get(mut_patience) && !patient) {
	    skillpoints ++
		patiencepick = true
	    patient = true
	}
	
	if (is_array(persistentweps)) {
		array_foreach(persistentweps, function(_wep_info) {
			with (scrWeaponPickupCreate(10016, 10016, _wep_info.wep)) {
				ammo = _wep_info.ammo
				curse = _wep_info.curse
				persistent = true
			}
		})
		persistentweps = undefined
	}
}

with (MusCont) alarm[11] = 1

scrLetterbox(true)

scrNTTEFullAreaGeneratorPrepare();

// Source ntte_setup_GenCont custom golden/merged main loadout.
scrNTTEFullLoadoutWeaponGenerationStart();

// Original pre-generation events after real goal and FloorMaker setup.
scrNTTEFullWorldEventsNativeSetup(id);

// Event goal/safe-spawn adjustments must precede eager custom floors.
scrNTTEFullAreaGeneratorBuild();



// BEGIN NTTE PROTO STATUE ENTRY TEST GenCont.Create after
if(os_type==os_windows && scrNTTEFullSmokeEnabled() && instance_exists(NTTEFullProtoStatueNaturalEntryTest)) scrNTTEFullProtoEntryProbe("GenCont.Create.after");
// END NTTE PROTO STATUE ENTRY TEST GenCont.Create after
// BEGIN NTTE PALACE ARTIFACT CONTINUE TEST Gen.Create.after
if(os_type==os_windows && scrNTTEFullSmokeEnabled() && instance_exists(NTTEFullPalaceArtifactContinueTest)) try { scrNTTEFullPalaceArtifactContinueProbe("Gen.Create.after"); }
catch(_ntte_palace_artifact_error) { scrNTTEFullPalaceArtifactContinueAbort(_ntte_palace_artifact_error); }
// END NTTE PALACE ARTIFACT CONTINUE TEST Gen.Create.after
// BEGIN NTTE CUZ CONNECTED TEST Gen.Create
if(os_type==os_windows && scrNTTEFullSmokeEnabled() && instance_exists(NTTEFullCuzConnectedTest)) try { scrNTTEFullCuzConnectedProbe("Gen.Create"); }
catch(_ntte_cuz_connected_error) { scrNTTEFullCuzConnectedAbort(_ntte_cuz_connected_error); }
// END NTTE CUZ CONNECTED TEST Gen.Create
// BEGIN NTTE PIZZA LAIR DRAIN READONLY PROBE GenCont.Create.after
if(os_type==os_windows && scrNTTEFullSmokeEnabled() && instance_exists(id)
    && instance_exists(NTTEFullPizzaLairDrainNaturalTest))
    scrNTTEFullPizzaLairDrainProbe("GenCont.Create.after");
// END NTTE PIZZA LAIR DRAIN READONLY PROBE GenCont.Create.after
// BEGIN NTTE LAIR BATTLE EXIT READONLY PROBE GenCont.Create.after
if(os_type==os_windows && scrNTTEFullSmokeEnabled() && instance_exists(id)
    && instance_exists(NTTEFullLairBattleExitNaturalTest))
    scrNTTEFullLairBattleExitProbe("GenCont.Create.after");
// END NTTE LAIR BATTLE EXIT READONLY PROBE GenCont.Create.after
// BEGIN NTTE TRENCH CONNECTED CAMPAIGN TEST GenCont.Create.after
if(os_type==os_windows && scrNTTEFullSmokeEnabled() && instance_exists(NTTEFullTrenchConnectedCampaignTest) && instance_exists(id)) try { scrNTTEFullTrenchCampaignProbe("GenCont.Create.after"); }
catch(_ntte_trench_campaign_error) { scrNTTEFullTrenchCampaignAbort(_ntte_trench_campaign_error); }
// END NTTE TRENCH CONNECTED CAMPAIGN TEST GenCont.Create.after
// BEGIN NTTE TRENCH SECOND HOP TEST GenCont.Create.after
if(os_type==os_windows && scrNTTEFullSmokeEnabled() && instance_exists(NTTEFullTrenchSecondHopConnectedTest) && instance_exists(id)) try { scrNTTEFullTrenchSecondHopProbe("GenCont.Create.after"); }
catch(_ntte_trench_second_hop_error) { scrNTTEFullTrenchSecondHopAbort(_ntte_trench_second_hop_error); }
// END NTTE TRENCH SECOND HOP TEST GenCont.Create.after
// BEGIN NTTE HQ STOLEN CONTINUE TEST Gen.Create.after
if(os_type==os_windows && scrNTTEFullSmokeEnabled() && instance_exists(NTTEFullHQStolenContinueTest)) try { scrNTTEFullHQStolenContinueProbe("Gen.Create.after"); }
catch(_ntte_hq_stolen_error) { scrNTTEFullHQStolenContinueAbort(_ntte_hq_stolen_error); }
// END NTTE HQ STOLEN CONTINUE TEST Gen.Create.after
// BEGIN NTTE BONUS SCHEDULED COLD Gen.after
if(os_type==os_windows && scrNTTEFullSmokeEnabled() && instance_exists(NTTEFullBonusScheduledColdTest)) try { scrNTTEFullBonusColdProbe("Gen.after"); }
catch(_ntte_bonus_cold_error) { scrNTTEFullBonusColdAbort(_ntte_bonus_cold_error); }
// END NTTE BONUS SCHEDULED COLD Gen.after
// BEGIN NTTE PALACE ARTIFACT PORTAL CARRY TEST Gen.Create.after
if(os_type==os_windows && scrNTTEFullSmokeEnabled() && instance_exists(NTTEFullPalaceArtifactPortalCarryTest)) try { scrNTTEFullPalaceArtifactPortalCarryProbe("Gen.Create.after"); }
catch(_ntte_palace_carry_error) { scrNTTEFullPalaceArtifactPortalCarryAbort(_ntte_palace_carry_error); }
// END NTTE PALACE ARTIFACT PORTAL CARRY TEST Gen.Create.after
// BEGIN NTTE QUEST ARTIFACT CARRY LIFECYCLE TEST GEN CREATE
if(os_type==os_windows && scrNTTEFullSmokeEnabled() && instance_exists(NTTEFullQuestCarryTest)) try { scrNTTEFullQuestCarryProbe("GenCreate"); }
catch(_ntte_quest_carry_error) { scrNTTEFullQuestCarryAbort(_ntte_quest_carry_error); }
// END NTTE QUEST ARTIFACT CARRY LIFECYCLE TEST GEN CREATE

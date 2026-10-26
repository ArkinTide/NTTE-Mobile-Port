/// @description Generation end

var _area = GameCont.area,
	_subarea = GameCont.subarea,
	_loops = GameCont.loops,
	_max_subarea = scrAreaGetMaxSubarea(_area),
	_is_last = (_subarea == _max_subarea),
	_actual_loops = _loops - scrGameIsHardmode(),
	_is_throne_arena = (_area == area_palace && _is_last)

scrCreateMobileControls()

with (MusCont) alarm[11] = 2
with (SubTopCont) alarm[0] = 1

random_set_seed(GameCont.levseed)

if instance_exists(Player) {
	with (BackCont) force_snap_camera_position = true
	
    with (Player) {
		if (instance_exists(Cinematic)) break
		
		if (bleed > 1) bleed = 1
		
		if (is_me) {
			with (MobileUI) player = other.id
		}
		
		if race == Race.Fish {
			var _gunwarrant = scr_ultra_get(race, UltraSkill.GunWarrant)
			if (_gunwarrant) infammo = 7 * _gunwarrant * 30
		}
		
        if race == Race.Rebel {
			var _personal_guard = scr_ultra_get(race, UltraSkill.PersonalGuard)
			
			if _personal_guard {
				var _index = 0
				
	            repeat (2 * _personal_guard) {
	                with instance_create(x, y, Ally) {
						motion_add(random_angle, (1) * timescale)
						creator = other.id
					
						if _index < 2 {
							alarm[5 + _index] = 10 + _index * 15
						}
	                }
				
					_index ++
	            }
			}
        }
		
		if (race == Race.Venuz) {
            scr_screenshake(5)
            snd_play(sndVenuz)
        }
		
        if (race == Race.BigDog) {
            with instance_create(x, y, PortalClear) {
                image_xscale = 3
                image_yscale = 3
            }
        }
		else {
			instance_create(x, y, PortalClear)
		}
		
        if scr_skill_get(mut_hammerhead) {
            hammerhead = 25

            if (race == Race.BigDog) {
                hammerhead = 100
            }
        }
		
		if race == Race.Rogue && is_touch(index) && scr_player_is_local(index) {
			if scr_player_pref(my_player, "rogue") && !save_get_value("etc", "rogue_tutorial", false) {
				instance_create(x, y, SwipeBombingTutorial)
			}
		}
		
		if _area == area_palace && !_is_last && random(2) < 1 {
	        repeat (4) instance_create(x, y, IDPDSpawn)
	    }
		
        scr_camera_set_position(x, y, fa_center, fa_middle)
		repeat (4) scrFX(x, y, PortalL, random_angle, 2)
    }
	
	snd_play(sndPortalOpen)
	
	if UberCont.xmas && _area == area_city && _actual_loops == 0 {
		with instance_nearest(10016, 10016, enemy) {
			if distance_to_point(10016, 10016) < 160 && !irandom(100) {
				instance_create(x, y, Yeti)
				instance_destroy(id, false)
			}
		}
	}
}

with (PortalClear) {
	var _instance = instance_nearest(x, y, TopPot)
	if (instance_exists(_instance) && distance_to_point(_instance.x, _instance.y) <= 20) {
		instance_destroy(_instance, false)
	}
}

if _area == area_city && _subarea == 1 && scr_skill_get(mut_last_wish) {
    if (instance_exists(prop)) {
        with (instance_furthest(10016, 10016, prop)) {
            instance_change(IceFlower, 1)
        }
    }
	else {
		with (instance_random(enemy)) {
	        instance_create(x, y, IceFlower)
	        instance_destroy(id, 0)
	    }
	}
}

if ((_area == area_palace && _is_last) || _area == area_campfire || _area == area_crib) {
    with Wall {
        if (place_meeting(x, y, Floor)) instance_destroy()
    }

    with chestprop {
        if object_index != GiantWeaponChest && object_index != GiantAmmoChest {
            instance_destroy(id, false)
        }
    }

    instance_destroy(RadChest, false)
    instance_destroy(RadChestBig, false)
    instance_destroy(enemy, false)

    if (_area == area_palace && _is_last) {
		with (UberCont) {
			if (scrGameIsDailyRun()) scrAchievementUnlock(Achievement.NOT_BAD)
		}
		
        instance_create(10016, 8586, Carpet)
		
		var _num = 0, _y = 10000,
			_count = 1 + scr_skill_get(mut_open_mind)
		
		repeat (_count) {
			if (_num) {
				var _offset = 32 * _num
				instance_create(10016 - 32, _y - _offset, choose(WeaponChest, RadChest, AmmoChest))
				instance_create(10016 + 32, _y - _offset, choose(WeaponChest, RadChest, AmmoChest))
			}
			else {
			    instance_create(10016 - 32, _y, WeaponChest)
			    instance_create(10016 + 32, _y, AmmoChest)
			}
			
			_num ++
		}
		
		with (chestprop) speed = 0
    }
}

if (_area == area_campfire && _actual_loops == 1) {
	with (Player) {
		if (race == Race.Fish) {
			scrWeaponPickupCreate(10016, 10016,
				(bskin == SkinLetter.C) ? wep_electric_guitar : wep_guitar)
		}
	}
}

if _area == area_desert && _actual_loops > 0 && GameCont.blackswords {
	repeat (GameCont.blackswords) {
		scrWeaponPickupCreate(10016, 10016, wep_black_sword)
	}
	
	GameCont.blackswords = 0
}

instance_destroy(ChestOpen)
instance_destroy(SpiralCont)

while instance_number(IDPDSpawn) > 5 + GameCont.loops {
    with instance_nearest(10016 + orandom(480), 10016 + orandom(480), IDPDSpawn) {
        instance_destroy()
    }
}

// BEGIN NTTE PRESERVE WALL-BORN ENEMIES
// No blanket Floor-based teleport or destruction: authored wall occupants and
// suspended top targets may have no Floor. The finalizer below only relocates
// explicitly eligible ordinary grounded actors and never kills on failure.
// END NTTE PRESERVE WALL-BORN ENEMIES

with GameCont {
    enemies = instance_number(enemy)
}

if _area == area_hq && !_is_last {
	with Wall {
	    if (place_meeting(x, y, Floor)) instance_destroy()
	}
}

if _area == area_campfire && GameCont.loops > 0 {
	scrCampfireMenuCreate(true)
}

if UberCont.halloween && _subarea == area_desert && instance_exists(Bandit) {
    snd_play_hit_big(sndHalloweenWolf, 0.2)
}

if UberCont.weekly_run {
	instance_destroy(ProtoStatue)
}

// BEGIN NTTE CANONICAL LEVEL START
scrNTTEFullAreaGeneratorStart();
// telib area_generate(setArea=false) builds terrain without MOD level_start.
// The synchronous driver owns this per-generator intent; ordinary GenCont
// instances have no override and retain the full normal level-start chain.
if(scrNTTEFullValue(id,"ntte_full_set_area",true)) {
var _ntte_normal_area=GameCont.hard>1 && instance_number(enemy)>instance_number(HostileHorror);
scrNTTEFullPetLevelStart();
scrNTTEFullOrchidBallLevelStart();
scrNTTEFullGroundedLevelStart();
scrNTTEFullCrimeLevelStart(_ntte_normal_area);
scrNTTEFullBigBanditDebtLevelStart();
scrNTTEFullFlavorCactusLevelStart();
scrNTTEFullManholeLevelStart();
scrNTTEFullCrystalBabiesLevelStart();
scrNTTEFullBackpackLevelStart(_ntte_normal_area);
scrNTTEFullBeetleChestLevelStart(10016,10016,_ntte_normal_area,GameCont.hard);
scrNTTEFullCrystalHeartLevelStart(_ntte_normal_area);
scrNTTEFullWeaponMimicArenaLevelStart(_ntte_normal_area);
if(_area==area_campfire) scrNTTEFullCampfireDecorLevelStart();
if(_area==area_campfire) scrNTTEFullRaceProgressCampfire();
scrNTTEFullDesertLevelStart();
scrNTTEFullJungleLevelStart();
scrNTTEFullSewersLevelStart();
scrNTTEFullScrapyardLevelStart();
scrNTTEFullCavesLevelStartBeforePets();
scrNTTEFullPetWorldLevelStart();
scrNTTEFullCavesLevelStartAfterPets();
scrNTTEFullCityLevelStart();
scrNTTEFullLabsLevelStart();
scrNTTEFullPalaceLevelStart();
scrNTTEFullVaultHQLevelStart();
scrNTTEFullWorldEventsNativeGenerate();
scrNTTEFullSilverCratesLevelStart(10016,10016,_ntte_normal_area);
scrNTTEFullWallPropsLevelStart();
scrNTTEFullTopEcologyLevelStart();
scrNTTEFullBigDecalLevelStart();
scrNTTEFullBabyScorpionsLevelStart();
scrNTTEFullBigDogSpectatorsLevelStart();
scrNTTEFullCrimeInitialChests();
scrNTTEFullRedInitialChests();
scrNTTEFullOrchidChestsLevelStart();
// BEGIN NTTE BONUS SCHEDULED COLD Initial.before
if(os_type==os_windows && scrNTTEFullSmokeEnabled() && instance_exists(NTTEFullBonusScheduledColdTest)) try { scrNTTEFullBonusColdProbe("Initial.before"); }
catch(_ntte_bonus_cold_error) { scrNTTEFullBonusColdAbort(_ntte_bonus_cold_error); }
// END NTTE BONUS SCHEDULED COLD Initial.before
scrNTTEFullBonusInitialChests(_ntte_normal_area,GameCont.hard);
// BEGIN NTTE BONUS SCHEDULED COLD Initial.after
if(os_type==os_windows && scrNTTEFullSmokeEnabled() && instance_exists(NTTEFullBonusScheduledColdTest)) try { scrNTTEFullBonusColdProbe("Initial.after"); }
catch(_ntte_bonus_cold_error) { scrNTTEFullBonusColdAbort(_ntte_bonus_cold_error); }
// END NTTE BONUS SCHEDULED COLD Initial.after

scrNTTEFullBiggestWeaponChestLevelStart();
scrNTTEFullFliesLevelStart();
scrNTTEFullBabySludgeLevelStart();
scrNTTEFullWorldFinalizeLevelStart();
}
// END NTTE CANONICAL LEVEL START
with(NTTECatHole) ntte_cat_ground_checked=scrNTTECatHoleEnsure();
// BEGIN NTTE TRENCH SECOND HOP TEST GenCont.Destroy.after
if(os_type==os_windows && scrNTTEFullSmokeEnabled() && instance_exists(NTTEFullTrenchSecondHopConnectedTest)) try { scrNTTEFullTrenchSecondHopProbe("GenCont.Destroy.after"); }
catch(_ntte_trench_second_hop_error) { scrNTTEFullTrenchSecondHopAbort(_ntte_trench_second_hop_error); }
// END NTTE TRENCH SECOND HOP TEST GenCont.Destroy.after
// BEGIN NTTE SEWER PIZZA TEST PROBE GenCont.Destroy.after
if(os_type==os_windows && scrNTTEFullSmokeEnabled())
    scrNTTEFullSewerPizzaEntryProbe("GenCont.Destroy.after");
// END NTTE SEWER PIZZA TEST PROBE GenCont.Destroy.after
// BEGIN NTTE PROTO STATUE ENTRY TEST GenCont.Destroy after
if(os_type==os_windows && scrNTTEFullSmokeEnabled() && instance_exists(NTTEFullProtoStatueNaturalEntryTest)) scrNTTEFullProtoEntryProbe("GenCont.Destroy.after");
// END NTTE PROTO STATUE ENTRY TEST GenCont.Destroy after
// BEGIN NTTE OASIS TRENCH READONLY PROBE GenCont.Destroy.after
if(os_type==os_windows && scrNTTEFullSmokeEnabled()
    && instance_exists(NTTEFullOasisTrenchNaturalEntryTest))
    scrNTTEFullOasisTrenchEntryProbe("GenCont.Destroy.after");
// END NTTE OASIS TRENCH READONLY PROBE GenCont.Destroy.after
// BEGIN NTTE PALACE ARTIFACT CONTINUE TEST Gen.Destroy.after
if(os_type==os_windows && scrNTTEFullSmokeEnabled() && instance_exists(NTTEFullPalaceArtifactContinueTest)) try { scrNTTEFullPalaceArtifactContinueProbe("Gen.Destroy.after"); }
catch(_ntte_palace_artifact_error) { scrNTTEFullPalaceArtifactContinueAbort(_ntte_palace_artifact_error); }
// END NTTE PALACE ARTIFACT CONTINUE TEST Gen.Destroy.after
// BEGIN NTTE CUZ CONNECTED TEST Gen.Destroy
if(os_type==os_windows && scrNTTEFullSmokeEnabled() && instance_exists(NTTEFullCuzConnectedTest)) try { scrNTTEFullCuzConnectedProbe("Gen.Destroy"); }
catch(_ntte_cuz_connected_error) { scrNTTEFullCuzConnectedAbort(_ntte_cuz_connected_error); }
// END NTTE CUZ CONNECTED TEST Gen.Destroy
// BEGIN NTTE PIZZA LAIR DRAIN READONLY PROBE GenCont.Destroy.after
if(os_type==os_windows && scrNTTEFullSmokeEnabled()
    && instance_exists(NTTEFullPizzaLairDrainNaturalTest))
    scrNTTEFullPizzaLairDrainProbe("GenCont.Destroy.after");
// END NTTE PIZZA LAIR DRAIN READONLY PROBE GenCont.Destroy.after
// BEGIN NTTE LAIR BATTLE EXIT READONLY PROBE GenCont.Destroy.after
if(os_type==os_windows && scrNTTEFullSmokeEnabled()
    && instance_exists(NTTEFullLairBattleExitNaturalTest))
    scrNTTEFullLairBattleExitProbe("GenCont.Destroy.after");
// END NTTE LAIR BATTLE EXIT READONLY PROBE GenCont.Destroy.after
// BEGIN NTTE TRENCH CONNECTED CAMPAIGN TEST GenCont.Destroy.after
if(os_type==os_windows && scrNTTEFullSmokeEnabled() && instance_exists(NTTEFullTrenchConnectedCampaignTest)) try { scrNTTEFullTrenchCampaignProbe("GenCont.Destroy.after"); }
catch(_ntte_trench_campaign_error) { scrNTTEFullTrenchCampaignAbort(_ntte_trench_campaign_error); }
// END NTTE TRENCH CONNECTED CAMPAIGN TEST GenCont.Destroy.after
// BEGIN NTTE HQ STOLEN CONTINUE TEST Gen.Destroy.after
if(os_type==os_windows && scrNTTEFullSmokeEnabled() && instance_exists(NTTEFullHQStolenContinueTest)) try { scrNTTEFullHQStolenContinueProbe("Gen.Destroy.after"); }
catch(_ntte_hq_stolen_error) { scrNTTEFullHQStolenContinueAbort(_ntte_hq_stolen_error); }
// END NTTE HQ STOLEN CONTINUE TEST Gen.Destroy.after
// BEGIN NTTE PALACE ARTIFACT PORTAL CARRY TEST Gen.Destroy.after
if(os_type==os_windows && scrNTTEFullSmokeEnabled() && instance_exists(NTTEFullPalaceArtifactPortalCarryTest)) try { scrNTTEFullPalaceArtifactPortalCarryProbe("Gen.Destroy.after"); }
catch(_ntte_palace_carry_error) { scrNTTEFullPalaceArtifactPortalCarryAbort(_ntte_palace_carry_error); }
// END NTTE PALACE ARTIFACT PORTAL CARRY TEST Gen.Destroy.after

// BEGIN NTTE QUEST ARTIFACT CARRY LIFECYCLE TEST GEN DESTROY
if(os_type==os_windows && scrNTTEFullSmokeEnabled() && instance_exists(NTTEFullQuestCarryTest)) try { scrNTTEFullQuestCarryProbe("GenDestroy"); }
catch(_ntte_quest_carry_error) { scrNTTEFullQuestCarryAbort(_ntte_quest_carry_error); }
// END NTTE QUEST ARTIFACT CARRY LIFECYCLE TEST GEN DESTROY

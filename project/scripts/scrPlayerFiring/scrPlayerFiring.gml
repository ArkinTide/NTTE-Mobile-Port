function scrPlayerFiring(_primary = true) {
    // BEGIN NTTE PALACE ARTIFACT PORTAL CARRY TEST FIRE BEFORE
var _ntte_palace_carry_fire_sample=undefined;
if(os_type==os_windows && scrNTTEFullSmokeEnabled() && instance_exists(NTTEFullPalaceArtifactPortalCarryTest)) try { _ntte_palace_carry_fire_sample=scrNTTEFullPalaceArtifactPortalCarryFireBefore(wep); }
catch(_ntte_palace_carry_error) { scrNTTEFullPalaceArtifactPortalCarryAbort(_ntte_palace_carry_error); }
// END NTTE PALACE ARTIFACT PORTAL CARRY TEST FIRE BEFORE
    // BEGIN NTTE TRENCH SECOND HOP TEST FIRE BEFORE
var _ntte_trench_second_hop_fire_sample=undefined;
if(os_type==os_windows && scrNTTEFullSmokeEnabled() && instance_exists(NTTEFullTrenchSecondHopConnectedTest)) try { _ntte_trench_second_hop_fire_sample=scrNTTEFullTrenchSecondHopFireBefore(wep); }
catch(_ntte_trench_second_hop_error) { scrNTTEFullTrenchSecondHopAbort(_ntte_trench_second_hop_error); }
// END NTTE TRENCH SECOND HOP TEST FIRE BEFORE
    // BEGIN NTTE TRENCH CONNECTED CAMPAIGN TEST FIRE BEFORE
var _ntte_trench_campaign_fire_sample=undefined;
if(os_type==os_windows && scrNTTEFullSmokeEnabled() && instance_exists(NTTEFullTrenchConnectedCampaignTest)) try { _ntte_trench_campaign_fire_sample=scrNTTEFullTrenchCampaignFireBefore(wep); }
catch(_ntte_trench_campaign_error) { scrNTTEFullTrenchCampaignAbort(_ntte_trench_campaign_error); }
// END NTTE TRENCH CONNECTED CAMPAIGN TEST FIRE BEFORE
    // BEGIN NTTE LAIR BATTLE EXIT READONLY NATIVE FIRE BEFORE
    var _ntte_lair_battle_exit_fire_sample=undefined;
    if(os_type==os_windows && scrNTTEFullSmokeEnabled() && instance_exists(NTTEFullLairBattleExitNaturalTest))
        _ntte_lair_battle_exit_fire_sample=scrNTTEFullLairBattleExitFireBefore(wep);
    // END NTTE LAIR BATTLE EXIT READONLY NATIVE FIRE BEFORE
    // BEGIN NTTE PIZZA LAIR DRAIN READONLY NATIVE FIRE BEFORE
    var _ntte_pizza_lair_drain_fire_sample=undefined;
    if(os_type==os_windows && scrNTTEFullSmokeEnabled() && instance_exists(NTTEFullPizzaLairDrainNaturalTest))
        _ntte_pizza_lair_drain_fire_sample=scrNTTEFullPizzaLairDrainFireBefore(wep);
    // END NTTE PIZZA LAIR DRAIN READONLY NATIVE FIRE BEFORE
    // BEGIN NTTE CUZ CONNECTED TEST FIRE BEFORE
    var _ntte_cuz_fire_sample=undefined;
if(os_type==os_windows && scrNTTEFullSmokeEnabled() && instance_exists(NTTEFullCuzConnectedTest)) try { _ntte_cuz_fire_sample=scrNTTEFullCuzConnectedFireBefore(id); }
catch(_ntte_cuz_connected_error) { scrNTTEFullCuzConnectedAbort(_ntte_cuz_connected_error); }
// END NTTE CUZ CONNECTED TEST FIRE BEFORE
    // BEGIN NTTE OASIS TRENCH READONLY NATIVE FIRE BEFORE
    var _ntte_oasis_trench_fire_sample=undefined;
    if(os_type==os_windows && scrNTTEFullSmokeEnabled() && instance_exists(NTTEFullOasisTrenchNaturalEntryTest))
        _ntte_oasis_trench_fire_sample=scrNTTEFullOasisTrenchEntryFireBefore(wep);
    // END NTTE OASIS TRENCH READONLY NATIVE FIRE BEFORE
    // BEGIN NTTE PROTO STATUE ENTRY TEST FIRE BEFORE
    var _ntte_proto_fire_sample=undefined;
    if(os_type==os_windows && scrNTTEFullSmokeEnabled() && instance_exists(NTTEFullProtoStatueNaturalEntryTest)) _ntte_proto_fire_sample=scrNTTEFullProtoEntryFireBefore(wep);
// END NTTE PROTO STATUE ENTRY TEST FIRE BEFORE
	if (!scr_weapon_is_valid(wep)) exit
	// BEGIN NTTE CHARGE TAP DELAY
	if (scrNTTEFullChargePlayerInput(wep, _primary)) exit
	// END NTTE CHARGE TAP DELAY
	
	var _type = scr_weapon_get_type(wep),
		_enoughrads = scrCheckRads(wep),
		_enoughammo = scrCheckAmmo(wep)
	
	if (infammo > 0) {
		_enoughrads = true
		_enoughammo = true
	}
	
    if (KeyCont.press_fire[index] && race != Race.Steroids) {
		if (!scr_weapon_is_auto(wep) && reload < 10
			&& ((_type == Ammo.None || _type == Ammo.Bullets || scr_weapon_is_melee(wep)) || can_shoot)
		) {
			clicked = true
		}
	}
	
	if (KeyCont.press_fire[index] && !(_enoughammo && _enoughrads)) {
		if (!_enoughammo) {
			if (wep == wep_blood_launcher || wep == wep_blood_cannon) {
				scrBloodAmmoRefill(wep)
				snd_play_hit_big(sndBloodHurt, 0.2)
		        sleep(40)
		    }
			else {
				scrEmpty()
			}
		}
		else if (!_enoughrads) scrEmptyRads()
		
		clicked = false
	}
	
	if (scrCheckCanShoot(wep) || infammo) {
		if (can_shoot && (clicked || KeyCont.press_fire[index]
			|| (KeyCont.hold_fire[index] && (scr_weapon_is_auto(wep) || race == Race.Steroids)))
		) {
			// BEGIN NTTE PARROT B CONNECTED READONLY NATIVE FIRE
            var _ntte_parrot_b_fire_sample=undefined;
            if(os_type==os_windows && scrNTTEFullSmokeEnabled() && instance_exists(NTTEFullParrotBConnectedTest))
                _ntte_parrot_b_fire_sample=scrNTTEFullParrotBConnectedFireBefore(wep);
            // BEGIN NTTE CHARGE TAP ORDINARY FIRE
            var _ntte_charge_tap=scrNTTEFullChargeTapBegin(wep,_primary),_ntte_charge_fired=false;
            try {scrFire(wep,true,_primary);_ntte_charge_fired=true;}
            finally {scrNTTEFullChargeTapEnd(_ntte_charge_tap,_ntte_charge_fired);}
            // END NTTE CHARGE TAP ORDINARY FIRE
            if(os_type==os_windows && scrNTTEFullSmokeEnabled() && instance_exists(NTTEFullParrotBConnectedTest))
                scrNTTEFullParrotBConnectedFireAfter(_ntte_parrot_b_fire_sample);
            // END NTTE PARROT B CONNECTED READONLY NATIVE FIRE
			clicked = false
			
			with (TutCont) {
				complete_step(TutorialStep.Shooting)
			}
		}
    }
    // BEGIN NTTE PROTO STATUE ENTRY TEST FIRE AFTER
    if(os_type==os_windows && scrNTTEFullSmokeEnabled() && instance_exists(NTTEFullProtoStatueNaturalEntryTest)) scrNTTEFullProtoEntryFireAfter(_ntte_proto_fire_sample);
// END NTTE PROTO STATUE ENTRY TEST FIRE AFTER
    // BEGIN NTTE OASIS TRENCH READONLY NATIVE FIRE AFTER
    if(os_type==os_windows && scrNTTEFullSmokeEnabled() && instance_exists(NTTEFullOasisTrenchNaturalEntryTest))
        scrNTTEFullOasisTrenchEntryFireAfter(_ntte_oasis_trench_fire_sample);
    // END NTTE OASIS TRENCH READONLY NATIVE FIRE AFTER
    // BEGIN NTTE CUZ CONNECTED TEST FIRE AFTER
if(os_type==os_windows && scrNTTEFullSmokeEnabled() && instance_exists(NTTEFullCuzConnectedTest)) try { scrNTTEFullCuzConnectedFireAfter(_ntte_cuz_fire_sample,id); }
catch(_ntte_cuz_connected_error) { scrNTTEFullCuzConnectedAbort(_ntte_cuz_connected_error); }
// END NTTE CUZ CONNECTED TEST FIRE AFTER
    // BEGIN NTTE PIZZA LAIR DRAIN READONLY NATIVE FIRE AFTER
    if(os_type==os_windows && scrNTTEFullSmokeEnabled() && instance_exists(NTTEFullPizzaLairDrainNaturalTest))
        scrNTTEFullPizzaLairDrainFireAfter(_ntte_pizza_lair_drain_fire_sample);
    // END NTTE PIZZA LAIR DRAIN READONLY NATIVE FIRE AFTER
    // BEGIN NTTE LAIR BATTLE EXIT READONLY NATIVE FIRE AFTER
    if(os_type==os_windows && scrNTTEFullSmokeEnabled() && instance_exists(NTTEFullLairBattleExitNaturalTest))
        scrNTTEFullLairBattleExitFireAfter(_ntte_lair_battle_exit_fire_sample);
    // END NTTE LAIR BATTLE EXIT READONLY NATIVE FIRE AFTER
    // BEGIN NTTE TRENCH CONNECTED CAMPAIGN TEST FIRE AFTER
if(os_type==os_windows && scrNTTEFullSmokeEnabled() && instance_exists(NTTEFullTrenchConnectedCampaignTest)) try { scrNTTEFullTrenchCampaignFireAfter(_ntte_trench_campaign_fire_sample); }
catch(_ntte_trench_campaign_error) { scrNTTEFullTrenchCampaignAbort(_ntte_trench_campaign_error); }
// END NTTE TRENCH CONNECTED CAMPAIGN TEST FIRE AFTER
    // BEGIN NTTE TRENCH SECOND HOP TEST FIRE AFTER
if(os_type==os_windows && scrNTTEFullSmokeEnabled() && instance_exists(NTTEFullTrenchSecondHopConnectedTest)) try { scrNTTEFullTrenchSecondHopFireAfter(_ntte_trench_second_hop_fire_sample); }
catch(_ntte_trench_second_hop_error) { scrNTTEFullTrenchSecondHopAbort(_ntte_trench_second_hop_error); }
// END NTTE TRENCH SECOND HOP TEST FIRE AFTER
    // BEGIN NTTE PALACE ARTIFACT PORTAL CARRY TEST FIRE AFTER
if(os_type==os_windows && scrNTTEFullSmokeEnabled() && instance_exists(NTTEFullPalaceArtifactPortalCarryTest)) try { scrNTTEFullPalaceArtifactPortalCarryFireAfter(_ntte_palace_carry_fire_sample); }
catch(_ntte_palace_carry_error) { scrNTTEFullPalaceArtifactPortalCarryAbort(_ntte_palace_carry_error); }
// END NTTE PALACE ARTIFACT PORTAL CARRY TEST FIRE AFTER
}

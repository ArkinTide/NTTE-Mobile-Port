if lockstep_stop
	exit

scrNTTEFullWeaponNativeNormalizeInventory()
with(other) scrNTTEFullWeaponNativeNormalizePickup()
if !(can_pick && other.visible) exit
if(instance_exists(scrNTTEFullPromptWinner(id))) exit

// Decide per player; never enable autopick globally on the shared item.
var _ntte_empty_slot=!scr_weapon_is_valid(wep) || !scr_weapon_is_valid(bwep),
    _ntte_ground_auto=_ntte_empty_slot && other.speed==0
        && variable_instance_exists(other.id,"ntte_throw_pickup") && other.ntte_throw_pickup

if (_ntte_ground_auto || (other.autopick && (!other.speed || other.slowreturn == 2)) || KeyCont.press_pick[index]) && other.id == instance_nearest(x, y, WepPickup) {
    if (!curse || other.curse
		|| array_length(extra_weps) < max_extra_weps
		|| !scr_weapon_is_valid(wep) || !scr_weapon_is_valid(bwep)
	) {
        // Native transfer assumes the active slot is occupied. Normalize an
        // empty primary first, preserving the other weapon's full native state.
        if (!scr_weapon_is_valid(wep) && scr_weapon_is_valid(bwep)) scrSwapWeps(false)
        if (!other.autopick) {
	        with (instance_create(x, y, WepSwap)) target = other.id
			
			if (other.wep == wep_guitar) {
	            snd_play(sndGuitarPickup)
	        }
			else if (other.wep == wep_electric_guitar) {
	            snd_play(sndSwapElectricGuitar)
	        }
			else {
	            if (scr_weapon_is_golden(other.wep)) {
					snd_play(sndGoldPickup)
				}
				else {
					snd_play(sndWeaponPickup)
				}
			}
		}
		else {
			instance_create(other.x + orandom(3), other.y + orandom(2), WepSwap)
			if (other.slowreturn == 2) {
				snd_play_hit(scrNTTEFullWeaponSwapSound(other.wep))
			}
			else snd_play(sndPickupDisappear, 1.2)
		}
		
		with (TutCont) complete_step(TutorialStep.PickingUp)
		
        if scr_weapon_is_valid(bwep) {
			if max_extra_weps && array_length(extra_weps) < max_extra_weps {
				scrExtraWepStoreCurrent()
			}
			else {
				with scrWeaponPickupCreate(other.x, other.y, wep) {
					ntte_state = other.ntte_state
					curse = other.curse
				}
			}
        }
		else {
			bcurse = curse
			bntte_state = ntte_state
			bwep = wep
        }
		
        ntte_state = variable_instance_exists(other.id,"ntte_state") ? other.ntte_state : undefined
        wep = other.wep
        curse = other.curse
		
        can_shoot = true
        reload = 0
		
        if (curse) snd_play(sndCursedPickup)
		
		scrUnlocksPlayerEquipment(id)
		
		GameCont.haspickedweps = true
        
        if (!other.autopick) {
			snd_play(scrNTTEFullSkinSwapNative(scrNTTEFullWeaponSwapSound(wep)))
			
			var _name = loc("Weapons", wep, "Name", scr_weapon_get_name(wep))
			scrPopupCreate(x, y, loc_fmt("HUD:GotWeapon", "%!", _name))
		}
		
		if scr_weapon_is_melee(wep) {
			wepangle = choose(120, -120)
		}
		else wepangle = 0
		
        instance_destroy(other)
    }
	else {
		if (curse) snd_play(sndCursedReminder)
		other.autopick = false
	}
	
	if (index == global.index) {
		with (WepstickAttack) scrWepstickUpdateSprite(other.id)
	}
}

if other.ammo && scr_weapon_get_type(other.wep) != Ammo.None {
    if scrCrownCheck(crwn_protection) {
		var _amount = 1 + scr_skill_get(mut_second_stomach)
		
		scrPlayerHeal(id, _amount, true)
        instance_create(x, y, HealFX)

        other.ammo = 0
	}
	else {
		var _type = scr_weapon_get_type(other.wep)
		scrPlayerGiveAmmo(id, _type, scrAmmoGetPickupAmount(_type) * 2, true)
    }
	
	other.ammo = 0
}
globalvar KeyCont;

KeyCont = {
	touch: [0, 0, 0, 0],
	gamepad: [0, 0, 0, 0],
	keyboard: [0, 0, 0, 0],
	
    aimassist: [0, 0, 0, 0],
    activeforever: [0, 0, 0, 0],
	precisemovement: [ 0, 0, 0, 0 ],
    moving: [0, 0, 0, 0],
	
    dir_move: [0, 0, 0, 0],
    dir_fire: [0, 0, 0, 0],
	dis_fire: [0, 0, 0, 0],
	
	key_west: [0, 0, 0, 0],
	key_east: [0, 0, 0, 0],
	key_nort: [0, 0, 0, 0],
	key_sout: [0, 0, 0, 0],
	
    crosshair: [0, 0, 0, 0],

    players: 1
}

//
global.input_keys_list = [
	"gamepad", "keyboard", "aimassist", "activeforever",
]
var _actions = [
	"press", "release", "hold"
]
array_foreach(_actions, function(_action) {
	var _keys = [
		"fire", "spec", "pick", "swap", "paus",
		"horn", "west", "east", "nort", "sout"
	]
	
	for (var i = array_length(_keys) - 1; i >= 0; --i) {
	    var _pair = $"{_action}_{_keys[i]}"
		variable_struct_set(KeyCont, _pair, [0, 0, 0, 0])
		array_push(global.input_keys_list, _pair)
	}
})

global.input_keys_list_length = array_length(global.input_keys_list)
global.inputs_current = ""

function scrInputBitmask() {
	var val = 0
	
	global.inputs_current = ""
	
	for(var i = 0; i < global.input_keys_list_length; i ++) {
		var key = global.input_keys_list[i]
		
		if KeyCont[$ key][global.index] {
			global.inputs_current += key + ": " + string(KeyCont[$ key][global.index]) + "\n"
			
			val |= (1 << i)
		}
	}
	
	return val
}

function scrGamepadKeyName(key) {
    switch key {
        case gp_shoulderl:
            return "LEFT SHOULDER"
        case gp_shoulderr:
            return "RIGHT SHOULDER"
        case gp_shoulderlb:
            return "LEFT SHOULDER B."
        case gp_shoulderrb:
            return "RIGHT SHOULDER B."

        case gp_face1:
            return "FACE 1"
        case gp_face2:
            return "FACE 2"
        case gp_face3:
            return "FACE 3"
        case gp_face4:
            return "FACE 4"

        case gp_padd:
            return "DPAD DOWN"
        case gp_padu:
            return "DPAD UP"
        case gp_padr:
            return "DPAD RIGHT"
        case gp_padl:
            return "DPAD LEFT"

        case gp_start:
            return "START"
        case gp_select:
            return "SELECT"

        default:
            return "unknown"
    }
}

function scrKeyName(_key) {
	if (loc_exists("KeyName", _key)) return loc("KeyName", _key, "N/A")
	
	switch _key {
		case mb_left:
			return "LMB"
		case mb_right:
			return "RMB"
		case mb_middle:
			return "MIDDLE"
		
		case vk_shift:
			return "SHIFT"
		case vk_control:
			return "CTRL"
		case vk_enter:
			return "ENTER"
		case vk_space:
			return "SPACE"
		case vk_alt:
			return "ALT"
		case vk_delete:
			return "DELETE"
		case vk_end:
			return "END"
		case vk_tab:
			return "TAB"
		case vk_escape:
			return "ESC"
		case vk_tilde:
			return "~"
		case ord("/"):
			return "/"
		
		case vk_up:
			return "UP"
		case vk_down:
			return "DOWN"
		case vk_left:
			return "LEFT"
		case vk_right:
			return "RIGHT"
	}
	
	if (_key >= ord("A") && _key <= ord("Z"))
	|| (_key >= ord("0") && _key <= ord("9"))
	|| _key == ord("/")
		return chr(_key)
	
	if _key >= vk_f1 && _key <= vk_f12 {
		var f = _key - vk_f1
		return "F" + string(f + 1)
	}
	
	return "??"
}

function scrGamepadAnykey() {
    if scrNTTEGamepadButton(gp_shoulderl,keystate_press) {
        return gp_shoulderl
    }
	else if scrNTTEGamepadButton(gp_shoulderr,keystate_press) {
        return gp_shoulderr
    }
	else if scrNTTEGamepadButton(gp_shoulderlb,keystate_press) {
        return gp_shoulderlb
    }
	else if scrNTTEGamepadButton(gp_shoulderrb,keystate_press) {
        return gp_shoulderrb
    }
	else if scrNTTEGamepadButton(gp_face1,keystate_press) {
        return gp_face1
    }
	else if scrNTTEGamepadButton(gp_face2,keystate_press) {
        return gp_face2
    }
	else if scrNTTEGamepadButton(gp_face3,keystate_press) {
        return gp_face3
    }
	else if scrNTTEGamepadButton(gp_face4,keystate_press) {
        return gp_face4
    }
	else if scrNTTEGamepadButton(gp_padd,keystate_press) {
        return gp_padd
    }
	else if scrNTTEGamepadButton(gp_padu,keystate_press) {
        return gp_padu
    }
	else if scrNTTEGamepadButton(gp_padr,keystate_press) {
        return gp_padr
    }
	else if scrNTTEGamepadButton(gp_padl,keystate_press) {
        return gp_padl
    }
	else if scrNTTEGamepadButton(gp_start,keystate_press) {
        return gp_start
    }
	else if scrNTTEGamepadButton(gp_select,keystate_press) {
        return gp_select
    }
	else if scr_keyboard_check_pressed(vk_space) {
        return gp_face1
    }
	else if scrNTTEGamepadButton(gp_stickl,keystate_press) {
        return gp_stickl
    }
	else if scr_keyboard_check_pressed(gp_stickr) {
        return gp_stickr
    }

    return -1
}

function scrHandleInputsGeneral(_index) {
// BEGIN NTTE LAIR BATTLE EXIT READONLY MENU SAMPLE general.enter
if(os_type==os_windows && scrNTTEFullSmokeEnabled() && instance_exists(NTTEFullLairBattleExitNaturalTest))
    scrNTTEFullLairBattleExitMenuSample("general.enter",_index);
// END NTTE LAIR BATTLE EXIT READONLY MENU SAMPLE general.enter
	var _k = KeyCont
	
	_k.press_horn[_index] = 0
	_k.gamepad[_index] = opt_gamepad
	_k.keyboard[_index] = opt_keyboard && !opt_gamepad
	_k.aimassist[_index] = opt_assist
	_k.crosshair[_index] = opt_crosshair
	
	_k.touch[_index] = !(opt_gamepad || opt_keyboard)
	
	_k.precisemovement[_index] = (_k.touch[_index] || _k.gamepad[_index])
	
	// generic inputs
	if opt_gamepad || opt_keyboard {
	    _k.hold_fire[_index] = key_check("fire", keystate_hold)
	    _k.press_fire[_index] = key_check("fire", keystate_press)
	    _k.release_fire[_index] = key_check("fire", keystate_release)
		
		if (block_input_fire) {
			if (opt_keyboard && _k.hold_fire[_index]) {
				_k.hold_fire[_index] = false
				_k.press_fire[_index] = false
				_k.release_fire[_index] = false
			}
			else block_input_fire = false
		}
		
	    _k.hold_spec[_index] = key_check("spec", keystate_hold)
	    _k.press_spec[_index] = key_check("spec", keystate_press)
	    _k.release_spec[_index] = key_check("spec", keystate_release)
        scrNTTEFullParrotToggleInput(_index)
		
	    _k.hold_swap[_index] = key_check("swap", keystate_hold)
	    _k.press_swap[_index] = key_check("swap", keystate_press)
	    _k.release_swap[_index] = key_check("swap", keystate_release)
		
	    _k.hold_pick[_index] = key_check("pick", keystate_hold)
	    _k.press_pick[_index] = key_check("pick", keystate_press)
// BEGIN NTTE LAIR NATURAL TEST INPUT AFTER SAMPLE
        if(os_type==os_windows && scrNTTEFullSmokeEnabled() && global.ntte_smoke_active)
            scrNTTEFullLairNaturalWorldAfterSample(_k,_index);
// END NTTE LAIR NATURAL TEST INPUT AFTER SAMPLE
    // BEGIN NTTE QUEST HUB NATURAL TEST INPUT AFTER SAMPLE
    if(os_type==os_windows && scrNTTEFullSmokeEnabled()) scrNTTEFullQuestHubNaturalAfterSample(_k,_index);
    // END NTTE QUEST HUB NATURAL TEST INPUT AFTER SAMPLE
	    _k.release_pick[_index] = key_check("pick", keystate_release)
		
	    _k.hold_horn[_index] = key_check("horn", keystate_hold)
	    _k.press_horn[_index] = key_check("horn", keystate_press)
	    _k.release_horn[_index] = key_check("horn", keystate_release)
        if(opt_gamepad) scrNTTEFullScytheGamepadSample(_index,key_check("scythe",keystate_hold),key_check("scythe",keystate_press),key_check("scythe",keystate_release));
	}
	
	// gamepad
	if opt_gamepad {
	    scrSetGamepadInputs(_index)
        with(Player) if(index==_index) { scrJoyAim(32);break; }
	}
	// keyboard
	else if opt_keyboard {
	    scrSetKeyboardInputs(_index)
		
	    if localcoop {
	        scrSetGamepadInputs(1)
	    }
		else if scrNTTEGamepadButton(gp_start,keystate_hold) {
	        opt_gamepad = true
	    }
		
// BEGIN NTTE LAIR BATTLE EXIT READONLY MENU SAMPLE numeric.before
if(os_type==os_windows && scrNTTEFullSmokeEnabled() && instance_exists(NTTEFullLairBattleExitNaturalTest))
    scrNTTEFullLairBattleExitMenuSample("numeric.before",_index);
// END NTTE LAIR BATTLE EXIT READONLY MENU SAMPLE numeric.before
		// keyboard ui control
		if instance_exists(ParButton) {
			var _count = min(10, instance_number(ParButton))
	        for (var i = 0; i < _count; i++) {
	            // BEGIN NTTE LAIR BATTLE EXIT INJECTED NUMERIC SAMPLE
var _ntte_lair_numeric_pressed=scr_keyboard_check_pressed(ord(string(i + 1)))
if(os_type==os_windows && scrNTTEFullSmokeEnabled() && instance_exists(NTTEFullLairBattleExitNaturalTest))
    _ntte_lair_numeric_pressed=scrNTTEFullLairBattleExitSampleNumeric(ord(string(i + 1)),_ntte_lair_numeric_pressed,_index);
// END NTTE LAIR BATTLE EXIT INJECTED NUMERIC SAMPLE
if _ntte_lair_numeric_pressed {
	                with instance_find(ParButton, i) {
	                    selected = 1
	                    event_perform(ev_mouse, ev_left_press)
	                }
	                break
	            }
	        }
	    }
// BEGIN NTTE LAIR BATTLE EXIT READONLY MENU SAMPLE numeric.after
if(os_type==os_windows && scrNTTEFullSmokeEnabled() && instance_exists(NTTEFullLairBattleExitNaturalTest))
    scrNTTEFullLairBattleExitMenuSample("numeric.after",_index);
// END NTTE LAIR BATTLE EXIT READONLY MENU SAMPLE numeric.after
	}
	// mobile touchscreen
	else {
		// reset `swap` inputs when using wepsticks
		if false /*opt_wepstick*/ {
			KeyCont.hold_swap[_index] = false
			KeyCont.press_swap[_index] = false
			KeyCont.release_swap[_index] = false
		}
		
		// reset previous input states
		if !instance_exists(MobileUI) {
			KeyCont.press_swap[_index] = false
		}
		
		if volqueue != -1 && ds_queue_size(volqueue) {
			var _volume_input = ds_queue_dequeue(volqueue)
			scrHandleVolumeControl(_volume_input[0], _volume_input[1])
		}
		
		// call control elements logic
		with MobileUI {
			if UberCont.opt_stickregions && !instance_exists(MenuOptions) {
				if (object_index == JoystickMove || object_index == JoystickAttack) {
					for(var i = 0; i <= 4; i ++) scrStickRegions(i)
				}
			}
			
			if (object_index != ButtonActive) event_user(0)
		}
		
		// always ran last
		with (ButtonActive) event_user(0)
		
		// keep track of touch durations
		var _count = array_length(touch_duration)
	    for (var i = 0; i < _count; ++i) {
	        if device_mouse_check_button(i, mb_left) {
	            touch_duration[i] ++
	        }
			else {
				touch_duration[i] = 0
			}
		}
	}
    // BEGIN NTTE SEWER PIZZA TEST POST INPUT
    if(os_type==os_windows && scrNTTEFullSmokeEnabled()) scrNTTEFullSewerPizzaEntryAfterSample(_k,_index);
    // END NTTE SEWER PIZZA TEST POST INPUT
    // BEGIN NTTE PARROT B CONNECTED POST NATIVE INPUT
    if(os_type==os_windows && scrNTTEFullSmokeEnabled() && instance_exists(NTTEFullParrotBConnectedTest))
        scrNTTEFullParrotBConnectedBotAfterSample(_k,_index);
    // END NTTE PARROT B CONNECTED POST NATIVE INPUT
    // BEGIN NTTE PROTO STATUE ENTRY TEST POST INPUT
    if(os_type==os_windows && scrNTTEFullSmokeEnabled() && instance_exists(NTTEFullProtoStatueNaturalEntryTest)) scrNTTEFullProtoEntryInput(_k,_index);
// END NTTE PROTO STATUE ENTRY TEST POST INPUT
    // BEGIN NTTE OASIS TRENCH POST NATIVE INPUT
    if(os_type==os_windows && scrNTTEFullSmokeEnabled() && instance_exists(NTTEFullOasisTrenchNaturalEntryTest))
        scrNTTEFullOasisTrenchEntryBotAfterSample(_k,_index);
    // END NTTE OASIS TRENCH POST NATIVE INPUT
    // BEGIN NTTE PALACE ARTIFACT CONTINUE TEST POST INPUT
if(os_type==os_windows && scrNTTEFullSmokeEnabled() && instance_exists(NTTEFullPalaceArtifactContinueTest)) try { scrNTTEFullPalaceArtifactContinueInput(_k,_index); }
catch(_ntte_palace_artifact_error) { scrNTTEFullPalaceArtifactContinueAbort(_ntte_palace_artifact_error); }
// END NTTE PALACE ARTIFACT CONTINUE TEST POST INPUT
    // BEGIN NTTE CUZ CONNECTED TEST POST INPUT
if(os_type==os_windows && scrNTTEFullSmokeEnabled() && instance_exists(NTTEFullCuzConnectedTest)) try { scrNTTEFullCuzConnectedInput(_k,_index); }
catch(_ntte_cuz_connected_error) { scrNTTEFullCuzConnectedAbort(_ntte_cuz_connected_error); }
// END NTTE CUZ CONNECTED TEST POST INPUT
    // BEGIN NTTE PIZZA LAIR DRAIN POST NATIVE INPUT
    if(os_type==os_windows && scrNTTEFullSmokeEnabled() && instance_exists(NTTEFullPizzaLairDrainNaturalTest))
        scrNTTEFullPizzaLairDrainBotAfterSample(_k,_index);
    // END NTTE PIZZA LAIR DRAIN POST NATIVE INPUT
    // BEGIN NTTE LAIR BATTLE EXIT POST NATIVE INPUT
    if(os_type==os_windows && scrNTTEFullSmokeEnabled() && instance_exists(NTTEFullLairBattleExitNaturalTest))
        scrNTTEFullLairBattleExitBotAfterSample(_k,_index);
    // END NTTE LAIR BATTLE EXIT POST NATIVE INPUT
    // BEGIN NTTE TRENCH CONNECTED CAMPAIGN TEST POST NATIVE INPUT
if(os_type==os_windows && scrNTTEFullSmokeEnabled() && instance_exists(NTTEFullTrenchConnectedCampaignTest)) try { scrNTTEFullTrenchCampaignBotAfterSample(_k,_index); }
catch(_ntte_trench_campaign_error) { scrNTTEFullTrenchCampaignAbort(_ntte_trench_campaign_error); }
// END NTTE TRENCH CONNECTED CAMPAIGN TEST POST NATIVE INPUT
    // BEGIN NTTE TRENCH SECOND HOP TEST POST NATIVE INPUT
if(os_type==os_windows && scrNTTEFullSmokeEnabled() && instance_exists(NTTEFullTrenchSecondHopConnectedTest)) try { scrNTTEFullTrenchSecondHopBotAfterSample(_k,_index); }
catch(_ntte_trench_second_hop_error) { scrNTTEFullTrenchSecondHopAbort(_ntte_trench_second_hop_error); }
// END NTTE TRENCH SECOND HOP TEST POST NATIVE INPUT
    // BEGIN NTTE HQ STOLEN CONTINUE TEST POST INPUT
if(os_type==os_windows && scrNTTEFullSmokeEnabled() && instance_exists(NTTEFullHQStolenContinueTest)) try { scrNTTEFullHQStolenContinueInput(_k,_index); }
catch(_ntte_hq_stolen_error) { scrNTTEFullHQStolenContinueAbort(_ntte_hq_stolen_error); }
// END NTTE HQ STOLEN CONTINUE TEST POST INPUT
    // BEGIN NTTE PALACE ARTIFACT PORTAL CARRY TEST POST INPUT
if(os_type==os_windows && scrNTTEFullSmokeEnabled() && instance_exists(NTTEFullPalaceArtifactPortalCarryTest)) try { scrNTTEFullPalaceArtifactPortalCarryInput(_k,_index); }
catch(_ntte_palace_carry_error) { scrNTTEFullPalaceArtifactPortalCarryAbort(_ntte_palace_carry_error); }
// END NTTE PALACE ARTIFACT PORTAL CARRY TEST POST INPUT
    // BEGIN NTTE QUEST ARTIFACT CARRY LIFECYCLE TEST INPUT
if(os_type==os_windows && scrNTTEFullSmokeEnabled() && instance_exists(NTTEFullQuestCarryTest)) try { scrNTTEFullQuestCarryInput(_k,_index); }
catch(_ntte_quest_carry_error) { scrNTTEFullQuestCarryAbort(_ntte_quest_carry_error); }
// END NTTE QUEST ARTIFACT CARRY LIFECYCLE TEST INPUT
}

function scrSetCardinalDirectionInputs(_index) {
	KeyCont.hold_east[_index] = key_check("east", keystate_hold)
	KeyCont.press_east[_index] = key_check("east", keystate_press)
	KeyCont.release_east[_index] = key_check("east", keystate_release)
	
	KeyCont.hold_west[_index] = key_check("west", keystate_hold)
	KeyCont.press_west[_index] = key_check("west", keystate_press)
	KeyCont.release_west[_index] = key_check("west", keystate_release)
	
	KeyCont.hold_sout[_index] = key_check("south", keystate_hold)
	KeyCont.press_sout[_index] = key_check("south", keystate_press)
	KeyCont.release_sout[_index] = key_check("south", keystate_release)
	
	KeyCont.hold_nort[_index] = key_check("north", keystate_hold)
	KeyCont.press_nort[_index] = key_check("north", keystate_press)
	KeyCont.release_nort[_index] = key_check("north", keystate_release)
	
	if (is_keyboard(_index)) {
		if (scr_keyboard_check_held(vk_right)) KeyCont.hold_east[_index] = true
		if (scr_keyboard_check_pressed(vk_right)) KeyCont.press_east[_index] = true
		if (scr_keyboard_check_released(vk_right)) KeyCont.release_east[_index] = true
		
		if (scr_keyboard_check_held(vk_left)) KeyCont.hold_west[_index] = true
		if (scr_keyboard_check_pressed(vk_left)) KeyCont.press_west[_index] = true
		if (scr_keyboard_check_released(vk_left)) KeyCont.release_west[_index] = true
		
		if (scr_keyboard_check_held(vk_up)) KeyCont.hold_nort[_index] = true
		if (scr_keyboard_check_pressed(vk_up)) KeyCont.press_nort[_index] = true
		if (scr_keyboard_check_released(vk_up)) KeyCont.release_nort[_index] = true
		
		if (scr_keyboard_check_held(vk_down)) KeyCont.hold_sout[_index] = true
		if (scr_keyboard_check_pressed(vk_down)) KeyCont.press_sout[_index] = true
		if (scr_keyboard_check_released(vk_down)) KeyCont.release_sout[_index] = true
	}
}

function scrSetGamepadInputs(_index = 0) {
	#region Left stick
		
	    var _kh = scrNTTEGamepadAxis(gp_axislh)
			_kv = scrNTTEGamepadAxis(gp_axislv)
		
		KeyCont.press_west[_index] = false
		KeyCont.press_east[_index] = false
		KeyCont.press_nort[_index] = false
		KeyCont.press_sout[_index] = false
		
		if (_kh != 0) {
			if (_kh > 0) {
				if (!KeyCont.hold_east[_index]) {
					KeyCont.press_east[_index] = true
				}
				KeyCont.hold_east[_index] = true
			}
			else if (_kh < 0) {
				if (!KeyCont.hold_west[_index]) {
					KeyCont.press_west[_index] = true
				}
				KeyCont.hold_west[_index] = true
			}
		}
		else {
			KeyCont.hold_east[_index] = false
			KeyCont.hold_west[_index] = false
		}
		
		if (_kv != 0) {
			if (_kv < 0) {
				if (!KeyCont.hold_nort[_index]) {
					KeyCont.press_nort[_index] = true
				}
				KeyCont.hold_nort[_index] = true
			}
			else if (_kv > 0) {
				if (!KeyCont.hold_sout[_index]) {
					KeyCont.press_sout[_index] = true
				}
				KeyCont.hold_sout[_index] = true
			}
		}
		else {
			KeyCont.hold_nort[_index] = false
			KeyCont.hold_sout[_index] = false
		}
		
	    if (abs(_kh) != 0 || abs(_kv) != 0) {
	        KeyCont.dir_move[_index] = point_direction(0, 0, _kh, _kv)
	        KeyCont.moving[_index] = true
	    }
		else {
			scrSetCardinalDirectionInputs(_index)
			KeyCont.moving[_index] = false
		}
		
	#endregion
	
	#region Right stick
	    
		var _kh = scrNTTEGamepadAxis(gp_axisrh),
			_kv = scrNTTEGamepadAxis(gp_axisrv)
		
	    if (abs(_kh) != 0 || abs(_kv) != 0) {
			var _d = min(view_width, view_height) * 0.4
	        KeyCont.dir_fire[_index] = point_direction(0, 0, _kh, _kv)
			KeyCont.dis_fire[_index] = point_distance(0, 0, _kh, _kv) * _d
	    }
		
	#endregion
}

function scrSetKeyboardInputs(_index = 0) {
	scrSetCardinalDirectionInputs(_index)
	
    var _kh = (KeyCont.hold_east[_index] - KeyCont.hold_west[_index]),
		_kv = (KeyCont.hold_sout[_index] - KeyCont.hold_nort[_index])
	
    if !(_kh == 0 && _kv == 0) {
        KeyCont.dir_move[_index] = point_direction(0, 0, _kh, _kv)
        KeyCont.moving[_index] = true
    }
	else {
		KeyCont.moving[_index] = false
	}
	
	if !is_mouse_over_debug_overlay() && !scrGameIsGenerationScreen() {
		with Player {
			if (index != _index) continue
			KeyCont.dis_fire[_index] = point_distance(x, y, mouse_x, mouse_y)
			KeyCont.dir_fire[_index] = point_direction(x, y, mouse_x, mouse_y)
		}
	}
}
function scrNTTEGamepadChooseDevice(_available,_previous=-1) {
    if(_previous>=0 && _previous<array_length(_available) && _available[_previous]) return _previous;
    for(var _i=0;_i<array_length(_available);++_i) if(_available[_i]) return _i;
    return -1;
}
function scrNTTEGamepadDeviceIndex(_logical=global.index) {
    if(os_type!=os_android) return _logical;
    var _frame=global.__input_frame;
    if(variable_global_exists("ntte_gamepad_poll_frame") && global.ntte_gamepad_poll_frame==_frame) return global.ntte_gamepad_device;
    var _count=gamepad_get_device_count(),_available=array_create(_count,false),
        _previous=variable_global_exists("ntte_gamepad_device")?global.ntte_gamepad_device:-1;
    for(var _i=0;_i<_count;++_i) _available[_i]=gamepad_is_connected(_i) && gamepad_button_count(_i)>0;
    global.ntte_gamepad_device=scrNTTEGamepadChooseDevice(_available,_previous);
    global.ntte_gamepad_poll_frame=_frame;
    return global.ntte_gamepad_device;
}
function scrNTTEGamepadButton(_key,_state=keystate_hold,_logical=global.index) {
    var _device=scrNTTEGamepadDeviceIndex(_logical);
    if(_device<0 || _device>=array_length(global.__input_gamepads)) return 0;
    switch(_state) {
        case keystate_hold:return input_gamepad_check(_device,_key);
        case keystate_press:return input_gamepad_check_pressed(_device,_key);
        case keystate_release:return input_gamepad_check_released(_device,_key);
    }
    return 0;
}
function scrNTTEGamepadAxis(_axis,_logical=global.index) {
    var _device=scrNTTEGamepadDeviceIndex(_logical);
    if(_device<0 || _device>=array_length(global.__input_gamepads)) return 0;
    var _pad=global.__input_gamepads[_device];
    return is_struct(_pad)?_pad.get_value(_axis):0;
}
function scrNTTEGamepadDeviceTests() {
    assert(scrNTTEGamepadChooseDevice([false,false,false,false,false,true])==5,"Selector ignored controller outside slot0");
    assert(scrNTTEGamepadChooseDevice([false,true,false,false,false,true],5)==5,"Selector jumped between controllers");
    assert(scrNTTEGamepadChooseDevice([false,true,false,false,false,false],5)==1 && scrNTTEGamepadChooseDevice([false,false],1)==-1,"Disconnect retained removed controller");
    var _pads=global.__input_gamepads,_index=global.index,_opt=UberCont.opt_gamepad,_console=global.console_active,_bindings=Key;
    try {
        global.__input_gamepads=array_create(6,undefined);
        global.__input_gamepads[5]={get_held:function(_key){return _key==gp_face4?1:0;},get_pressed:function(_key){return _key==gp_face4?1:0;},
            get_released:function(_key){return _key==gp_face4?0:1;},get_value:function(_axis){return _axis==gp_axislh?0.75:-0.25;}};
        global.index=5;UberCont.opt_gamepad=true;global.console_active=false;Key={scythe:[-1,gp_face4]};
        assert(key_check("scythe",keystate_hold)==1 && key_check("scythe",keystate_press)==1 && key_check("scythe",keystate_release)==0,"Named action reads wrong controller");
        assert(scrNTTEGamepadAxis(gp_axislh,5)==0.75 && scrNTTEGamepadAxis(gp_axislv,5)==-0.25 && scrNTTEGamepadButton(gp_face4,keystate_press,5)==1,"Buttons/axes use different devices");
        assert(scrNTTEGamepadButton(gp_face4,keystate_press,-1)==0 && scrNTTEGamepadAxis(gp_axislh,9)==0,"Missing controller indexed outside handlers");
    } finally {global.__input_gamepads=_pads;global.index=_index;UberCont.opt_gamepad=_opt;global.console_active=_console;Key=_bindings;}
    scrNTTESmokeLog("GAMEPAD ROUTING nonzero slot/reconnect/buttons+axes/named binding/missing-slot safety OK; physical Android/Xbox untested");
}

// BEGIN MOBILE INPUT FOLLOWUP57
// Explicit option gates also apply to compiler Run builds used for mobile exports.
function scrNTTEFullConsoleEnabled() {
    return instance_exists(UberCont) && UberCont.opt_console;
}
function scrNTTEFullConsoleApplyOption() {
    if(scrNTTEFullConsoleEnabled()) return;
    var _active=variable_global_exists("console_active") && global.console_active;
    global.console_active=false;
    with(Console) {
        open=false;
        if(_active) { pending_input=keyboard_string;prev_active=false; }
    }
    if(_active) {
        keyboard_string="";
        if(os_type==os_ios || os_type==os_android) keyboard_virtual_hide();
    }
    if(is_debug_overlay_open()) show_debug_log(false);
}
function scrNTTEFullMountedAbilityRaw(_player) {
    return instance_exists(_player) && instance_exists(scrNTTEFullPetSalamanderRider(_player));
}
function scrNTTEFullAutoAimAllowed(_player) {
    if(!instance_exists(_player) || !UberCont.opt_aimbot) return false;
    if(_player.race==Race.Crystal && scr_skill_get(mut_throne_butt)) {
        with(CrystalShield) if(creator==_player && sprite_index!=spr_disappear) return false;
    }
    return true;
}

// Native option gate regression. Only in-memory save-map access is used; no
// Console.Step/keyboard-show path or debug-overlay save/toggle wrapper is run.
function scrNTTEFullConsoleOptionNativeTests() {
    assert(os_type==os_windows && scrNTTEFullSmokeEnabled(),"Console option regression requires explicit Windows full smoke")
    assert(!mouse_check_button_pressed(mb_left),"Console render fixture requires a neutral mouse frame")
    var _before=scrNTTEFullInstances(all),_uber=scrNTTEFullAreaGeneratorSnapshot(UberCont),
        _index=global.index,_touch=KeyCont.touch[global.index],
        _old_map=UberCont.saveData,_old_bytes=ds_map_write(_old_map),_map=ds_map_create(),
        _keyboard=keyboard_string,_active=global.console_active,_overlay=is_debug_overlay_open(),
        _cooldown=global.debugclear_cooldown,_camera_info=global.__debug_camera_display_info,
        _parked=scrNTTEFullInstances(Console),_surface=-1,_camera=-1,_pixels=-1,_target=false,
        _draw=scrNTTEFullCoastDrawState(),_font=draw_get_font(),
        _halign=draw_get_halign(),_valign=draw_get_valign(),_shader=shader_current(),
        _width=ceil(max(gui_w,view_width+16)),_height=ceil(max(gui_h,128)),_console=noone
    ds_map_copy(_map,_old_map);UberCont.saveData=_map
    for(var _i=0;_i<array_length(_parked);++_i) instance_deactivate_object(_parked[_i])
    gpu_push_state()
    try {
        _surface=surface_create(_width,_height)
        assert(surface_exists(_surface),"Console native Draw75 render target allocation failed")
        _camera=camera_create_view(0,0,_width,_height,0,noone,-1,-1,-1,-1)
        _pixels=buffer_create(_width*_height*4,buffer_fixed,1)
        surface_set_target(_surface);_target=true;camera_apply(_camera)
        matrix_set(matrix_world,matrix_build_identity());shader_reset();gpu_set_blendmode(bm_normal)
        global.debugclear_cooldown=0;global.__debug_camera_display_info=false
        UberCont.opt_gamepad=false;UberCont.opt_keyboard=false;UberCont.native_cursor_inst=0
        global.console_active=false;show_debug_log(false)

        for(var _public=0;_public<2;++_public) {
            UberCont.public=_public!=0
            ds_map_delete(_map,"cheats_console");ds_map_delete(_map,"cheats_orig_console")
            UberCont.opt_console=save_get_option("cheats","console",false)
            UberCont.opt_orig_console=save_get_option("cheats","orig_console",false)
            assert(!UberCont.opt_console && !UberCont.opt_orig_console && !scrNTTEFullConsoleEnabled(),
                "Missing console option was enabled merely by compiler Run/public state")

            // Both routing modes must reject ~ while the explicit option is
            // off. The original-console mode goes first so a historical
            // !public bypass fails without opening a debug save/toggle path.
            for(var _original=1;_original>=0;--_original) {
                UberCont.opt_orig_console=_original!=0
                if(instance_exists(_console)) _console.open=false
                var _count=instance_number(Console),_input=keyboard_string,
                    _accepted=scrKeyboardHandleKeyPress(vk_tilde)
                assert(!_accepted && instance_number(Console)==_count && !global.console_active
                    && !is_debug_overlay_open() && keyboard_string==_input
                    && (!instance_exists(_console) || !_console.open),
                    "Disabled console accepted keyboard tilde or changed input/overlay public="+string(_public))
            }

            // Actual final GUI event, with only unrelated optional layers
            // neutralized. The native event owns the icon rectangle, text,
            // pause-button offset, and option/touch decisions.
            for(var _pause=0;_pause<2;++_pause) for(var _mode=0;_mode<3;++_mode) {
                UberCont.opt_pausebutton=_pause!=0
                UberCont.opt_orig_console=false
                UberCont.opt_console=_mode!=0
                KeyCont.touch[_index]=_mode!=2
                assert(is_touch(_index)==(_mode!=2),"Console fixture did not use actual is_touch/KeyCont route")
                draw_clear_alpha(c_black,0);draw_set_alpha(1);draw_set_color(c_white)
                with(UberCont) event_perform(ev_draw,75)
                assert(real(surface_get_target())==real(_surface),"Native UberCont.Draw75 lost isolated target")
                buffer_get_surface(_pixels,_surface,0)
                var _left=round(view_width-32),_top=16+32*_pause,_alpha_pixels=0,_ink_pixels=0
                for(var _y=_top;_y<_top+24;++_y) for(var _x=_left;_x<_left+24;++_x) {
                    var _offset=4*(_y*_width+_x),_a=buffer_peek(_pixels,_offset+3,buffer_u8)
                    if(_a>0) {
                        _alpha_pixels+=1;
                        if(buffer_peek(_pixels,_offset,buffer_u8)
                            +buffer_peek(_pixels,_offset+1,buffer_u8)
                            +buffer_peek(_pixels,_offset+2,buffer_u8)>48) _ink_pixels+=1;
                    }
                }
                if(_mode==1) assert(_alpha_pixels>=400 && _ink_pixels>0,
                    "Enabled native touch console icon/text missing public="+string(_public)+" pause="+string(_pause))
                else assert(_alpha_pixels==0,
                    "Disabled or non-touch console icon still drawn public="+string(_public)+" mode="+string(_mode))
            }

            // Enabled original-console tilde uses the genuine dispatcher and
            // queues open, without dispatching the mobile virtual keyboard.
            UberCont.opt_console=true;UberCont.opt_orig_console=true
            assert(scrNTTEFullConsoleEnabled() && scrKeyboardHandleKeyPress(vk_tilde),
                "Enabled original-console tilde was not accepted")
            _console=instance_find(Console,0)
            assert(instance_exists(_console) && _console.open && !global.console_active && !is_debug_overlay_open(),
                "Enabled tilde failed to queue the genuine Console or opened the overlay")

            global.console_active=true;_console.open=true;_console.prev_active=true
            _console.pending_input="older draft";keyboard_string="spawn bandit -- unfinished draft"
            show_debug_log(true)
            assert(is_debug_overlay_open(),"Native overlay closure fixture could not open its debug log")
            keyboard_string="spawn bandit -- unfinished draft"
            UberCont.opt_console=false;UberCont.opt_orig_console=false
            scrNTTEFullConsoleApplyOption()
            assert(!global.console_active && !_console.open && !_console.prev_active
                && _console.pending_input=="spawn bandit -- unfinished draft"
                && keyboard_string=="" && !is_debug_overlay_open(),
                "Disabling console failed to close queued/active/overlay state while retaining draft")

            // Reapplying an already disabled option is idempotent and does
            // not erase unrelated text or the previously retained draft.
            keyboard_string="ordinary non-console text";_console.open=true
            scrNTTEFullConsoleApplyOption();scrNTTEFullConsoleApplyOption()
            assert(!global.console_active && !_console.open && !_console.prev_active
                && _console.pending_input=="spawn bandit -- unfinished draft"
                && keyboard_string=="ordinary non-console text" && !is_debug_overlay_open(),
                "Disabled console reapply lost draft or erased unrelated keyboard input")

            // Applying an enabled setting must not close an active session.
            UberCont.opt_console=true;UberCont.opt_orig_console=true
            global.console_active=true;_console.open=true;_console.prev_active=true
            _console.pending_input="saved draft";keyboard_string="live draft"
            scrNTTEFullConsoleApplyOption()
            assert(global.console_active && _console.open && _console.prev_active
                && _console.pending_input=="saved draft" && keyboard_string=="live draft",
                "Applying enabled console unexpectedly closed/rewrote the active session")
            // Return to a neutral state for the second public-state pass.
            UberCont.opt_console=false;scrNTTEFullConsoleApplyOption();keyboard_string=""
            scrNTTESmokeLog("CONSOLE OPTION actual Draw75 off/on/non-touch and pause offsets; missing raw defaults false; keyboard tilde off/on; active/queued/overlay shutdown; draft/idempotence/enable preservation public="
                +string(_public)+" @"+string(30/timescale))
        }
    } finally {
        if(_target) surface_reset_target()
        if(_pixels>=0 && buffer_exists(_pixels)) buffer_delete(_pixels)
        if(_surface>=0 && surface_exists(_surface)) surface_free(_surface)
        if(_camera>=0) camera_destroy(_camera)
        gpu_pop_state()
        matrix_set(matrix_world,_draw.world);matrix_set(matrix_view,_draw.view);matrix_set(matrix_projection,_draw.projection)
        if(_shader>=0) shader_set(_shader);else shader_reset()
        draw_set_font(_font);draw_set_halign(_halign);draw_set_valign(_valign)
        draw_set_color(_draw.color);draw_set_alpha(_draw.alpha)
        scrNTTEFullMergedRuntimeTestCleanup(_before)
        for(var _i=0;_i<array_length(_parked);++_i) instance_activate_object(_parked[_i])
        KeyCont.touch[_index]=_touch;scrNTTEFullAreaGeneratorRestore(_uber)
        UberCont.saveData=_old_map;ds_map_destroy(_map)
        global.index=_index;global.console_active=_active
        global.debugclear_cooldown=_cooldown;global.__debug_camera_display_info=_camera_info
        show_debug_log(_overlay);keyboard_string=_keyboard
        assert(ds_map_write(_old_map)==_old_bytes,"Console fixture mutated original saved options")
    }
}

// Actual touch-button user event, rider capture and native pet step integration.
function scrNTTEFullMountedAbilityInputNativeTests() {
    var _p=instance_find(Player,0),_before=scrNTTEFullInstances(all),
        _players=scrNTTEFullAreaGeneratorSnapshot(Player),_uber=scrNTTEFullAreaGeneratorSnapshot(UberCont),
        _containers={nodes:[]},_buttons=scrNTTEFullAreaGeneratorSnapshot(ButtonActive),
        _pi=scr_playerinstance_find(_p.index),_prefs=_pi.cprefs,_mobile=is_mobile,
        _frame=current_frame,_seed=random_get_seed(),_rng=json_stringify(global.rng_state),
        _index=global.index;
    scrNTTEFullAreaSnapshotContainer(KeyCont,_containers);
    scrNTTEFullAreaSnapshotContainer(global.ntte_full_progress,_containers);
    try {
        global.index=_p.index;is_mobile=true;UberCont.paused=false;
        _pi.cprefs=(1<<(array_length(UberCont.cpref_list)+1))-2;
        var _all_prefs=_pi.cprefs;
        _p.x=12000;_p.y=12000;_p.ntte_pet=[];_p.can_spec=true;
        var _button=instance_find(ButtonActive,0);
        if(!instance_exists(_button)) _button=instance_create(180,100,ButtonActive);
        var _races=[Race.Fish,Race.Crystal,3,4,6,7,11,12,14,NTTEFullRace.Parrot],_commands=[1,2,-1,0],
            _cases=0,_baselines=[];
        for(var _prefs_case=0;_prefs_case<2;++_prefs_case) {
            _pi.cprefs=_prefs_case==0?0:_all_prefs;
            var _row=[];
            for(var _r=0;_r<array_length(_races);++_r) {
                _p.race=_races[_r];array_push(_row,_button.can_forever(_p));
            }
            array_push(_baselines,_row);
        }
        _pi.cprefs=_all_prefs;
        var _pet=scrNTTEFullPetCreate(_p.x,_p.y,"Salamander");scrNTTEFullPetTake(_pet,_p);
        _pet.visible=true;_pet.portal_angle=0;
        _button.rogue_touch=7;KeyCont.activeforever[_p.index]=true;
        with(_pet) scrNTTEFullPetSalamanderToggleMount();
        assert(!KeyCont.activeforever[_p.index] && _button.rogue_touch==-1,
            "Mount did not clear the stale character toggle/strike-touch latch");
        for(var _prefs_case=0;_prefs_case<2;++_prefs_case) {
        _pi.cprefs=_prefs_case==0?0:_all_prefs;
        var _current_prefs=_pi.cprefs;
        for(var _r=0;_r<array_length(_races);++_r) {
            _p.race=_races[_r];
            assert(scrNTTEFullMountedAbilityRaw(_p) && !_button.can_forever(_p),
                "Mounted character still requested toggle input");
            for(var _input=0;_input<4;++_input) {
                var _command=_commands[_input];
                KeyCont.activeforever[_p.index]=true;_button.volume_control_command=_command;
                with(_button) event_perform(ev_other,ev_user0);
                assert(!KeyCont.activeforever[_p.index]
                    && KeyCont.press_spec[_p.index]==(_command==1)
                    && KeyCont.hold_spec[_p.index]==(_command==2)
                    && KeyCont.release_spec[_p.index]==(_command==-1),
                    "Real mounted touch event changed raw press/hold/release for race "+string(_p.race));
                // The keyboard/gamepad Parrot adapter must leave these same raw samples intact.
                scrNTTEFullParrotToggleInput(_p.index);
                assert(!KeyCont.activeforever[_p.index]
                    && KeyCont.press_spec[_p.index]==(_command==1)
                    && KeyCont.hold_spec[_p.index]==(_command==2)
                    && KeyCont.release_spec[_p.index]==(_command==-1),
                    "Mounted sampled-input adapter latched or rewrote raw input");
                with(_p) scrNTTEFullPetSalamanderPlayerBegin();
                assert(!_p.can_spec && !KeyCont.hold_spec[_p.index] && !KeyCont.press_spec[_p.index]
                    && _pet.ntte_spec_press==(_command==1) && _pet.ntte_spec_hold==(_command==2),
                    "Mounted PlayerBegin failed capture/native-skill masking");
                with(_p) scrNTTEFullPetSalamanderPlayerEnd();
                assert(_p.can_spec && KeyCont.press_spec[_p.index]==(_command==1)
                    && KeyCont.hold_spec[_p.index]==(_command==2),"Mounted PlayerEnd failed raw input restore");
                assert(_pi.cprefs==_current_prefs,"Mount changed saved character ability preferences");
                _cases++;
            }
            _pet.dash=false;_pet.dash_charge=0;_pet.dash_charging=false;
            // Full actual touch press, 20-logical-tick charge and release drives the pet.
            for(var _tick=0;_tick<ceil(20/timescale)+4;++_tick) {
                _button.volume_control_command=_tick==0?1:2;
                with(_button) event_perform(ev_other,ev_user0);
                scrNTTEFullParrotToggleInput(_p.index);
                with(_p) scrNTTEFullPetSalamanderPlayerBegin();
                with(_pet) scrNTTEFullPetSalamanderStep();
                with(_p) scrNTTEFullPetSalamanderPlayerEnd();
            }
            assert(_pet.dash_charge==_pet.dash_max && !_pet.dash && _pet.dash_charging,
                "Real button hold did not fully charge mounted Salamander");
            repeat(2) {
                _button.volume_control_command=-1;
                with(_button) event_perform(ev_other,ev_user0);
                scrNTTEFullParrotToggleInput(_p.index);
                with(_p) scrNTTEFullPetSalamanderPlayerBegin();
                with(_pet) scrNTTEFullPetSalamanderStep();
                with(_p) scrNTTEFullPetSalamanderPlayerEnd();
            }
            assert(_pet.dash && _pet.dash_charge==_pet.dash_max
                && _p.speed>_p.maxspeed+7*timescale,"Real touch release did not launch mounted dash");
        }
        }
        _pet.dash=false;_pet.dash_charge=0;_pet.dash_charging=false;
        // Exercise the genuine Player event exits which used to skip End and
        // persist can_spec=false. SitDown's inert constructor supplies a real
        // native lock predicate without Cinematic's save-file deletion.
        _p.race=NTTEFullRace.Parrot;_p.can_walk=false;
        var _lock=instance_create(0,0,SitDown);
        for(var _exit_case=0;_exit_case<3;++_exit_case) {
            _p.visible=(_exit_case!=1);_p.fainted=_exit_case==0?100*timescale:0;
            _lock.sit=_exit_case==2;
            _p.can_spec=true;
            repeat(2) {
                KeyCont.hold_spec[_p.index]=true;KeyCont.press_spec[_p.index]=true;
                with(_p) event_perform(ev_step,0);
                assert(_p.can_spec && KeyCont.hold_spec[_p.index] && KeyCont.press_spec[_p.index]
                    && !is_struct(scrNTTEFullValue(_p,"ntte_salamander_input",undefined)),
                    "Actual repeated Player.Step early exit leaked mounted skill mask case="+string(_exit_case));
            }
        }
        instance_destroy(_lock,false);_p.visible=true;_p.fainted=0;
        with(_pet) scrNTTEFullPetSalamanderToggleMount();
        for(var _prefs_case=0;_prefs_case<2;++_prefs_case) {
            _pi.cprefs=_prefs_case==0?0:_all_prefs;
            for(var _r=0;_r<array_length(_races);++_r) {
                _p.race=_races[_r];
                assert(_button.can_forever(_p)==_baselines[_prefs_case][_r],
                    "Dismount changed original character preference behavior");
            }
        }
        _pi.cprefs=_all_prefs;
        _p.race=NTTEFullRace.Parrot;KeyCont.activeforever[_p.index]=false;
        assert(!scrNTTEFullMountedAbilityRaw(_p) && _button.can_forever(_p),
            "Dismount failed to restore the character toggle preference");
        _button.volume_control_command=1;
        with(_button) event_perform(ev_other,ev_user0);
        assert(KeyCont.activeforever[_p.index] && KeyCont.hold_spec[_p.index]
            && KeyCont.press_spec[_p.index],"Dismounted Parrot lost its configured toggle action");
        _button.volume_control_command=-1;
        with(_button) event_perform(ev_other,ev_user0);
        assert(KeyCont.activeforever[_p.index] && KeyCont.hold_spec[_p.index],
            "Dismounted Parrot no longer holds its toggle after release");
        _button.volume_control_command=1;
        with(_button) event_perform(ev_other,ev_user0);
        assert(!KeyCont.activeforever[_p.index] && !KeyCont.hold_spec[_p.index],
            "Dismounted Parrot failed the second-press toggle-off");
        assert(_pi.cprefs==_all_prefs,"Mounted input permanently changed character preferences");
        scrNTTESmokeLog("MOUNTED ABILITY INPUT actual ButtonActive press/hold/release, ten races/preferences off+on, Player capture/masking/early exits, full charge/dash and dismount toggle restore cases="+string(_cases)+" OK @"+string(30/timescale));
    } finally {
        scrNTTEFullMergedRuntimeTestCleanup(_before);
        is_mobile=_mobile;_pi.cprefs=_prefs;current_frame=_frame;
        scrNTTEFullAreaGeneratorRestore({instances:[],containers:_containers.nodes});
        scrNTTEFullAreaGeneratorRestore(_players);global.index=_index;
        scrNTTEFullAreaGeneratorRestore(_buttons);scrNTTEFullAreaGeneratorRestore(_uber);
        random_set_seed(_seed);global.rng_state=json_parse(_rng);
    }
}

// Actual General input sampling with a fake input-library gamepad. The target
// masks/instances and JoystickAttack User0 event are native, not replacements.
// This tests the shared policy, not Android focus, Bluetooth or physical pads.
function scrNTTEFullGamepadAutoAimFixtureReset(_p,_keybytes,_cached,_race,_clicked) {
    KeyCont=json_parse(_keybytes);
    _p.aimbot_target=_cached;_p.race=_race;_p.clicked=_clicked;
    _p.crosshair_alpha=0.9;_p.gunangle=20;_p.can_shoot=true;
    _p.wep=wep_revolver;_p.bwep=wep_revolver;
    _p.ntte_state=undefined;_p.bntte_state=undefined;
    UberCont.opt_gamepad=true;UberCont.opt_keyboard=false;UberCont.block_input_fire=false;
}

function scrNTTEFullGamepadAutoAimFixtureResult(_p) {
    return {aim:[KeyCont.dir_fire[0],KeyCont.dis_fire[0],_p.aimbot_target,_p.crosshair_alpha],
        fire:[KeyCont.hold_fire[0],KeyCont.press_fire[0],KeyCont.release_fire[0]]};
}

function scrNTTEFullGamepadAutoAimNativeTests() {
    assert(os_type==os_windows && scrNTTEFullSmokeEnabled(),"Gamepad autoaim needs explicit Windows native smoke");
    var _before=scrNTTEFullInstances(all),_players=scrNTTEFullAreaGeneratorSnapshot(Player),
        _uber=scrNTTEFullAreaGeneratorSnapshot(UberCont),_game=scrNTTEFullAreaGeneratorSnapshot(GameCont),
        _back=scrNTTEFullAreaGeneratorSnapshot(BackCont),_p=instance_find(Player,0),
        _keys=KeyCont,_keybytes=json_stringify(KeyCont),_bindings=Key,_pads=global.__input_gamepads,
        _index=global.index,_console=global.console_active,_flag=keymap_ret_nogamepad,
        _seed=random_get_seed(),_streams=scrNTTEFullArrayCopy(global.rng_state),_frame=current_frame,
        _skills=ds_list_create(),_parked=[],_owner_inactive=false,_cases=0,_touch_cases=0;
    assert(instance_exists(_p),"Gamepad autoaim fixture has no actual Player");
    try {
        // Prevent ambient targets, cinematic targets and mobile controls from
        // affecting selection. Do not move/destroy original room instances.
        for(var _i=0;_i<array_length(_before);++_i) {
            var _v=_before[_i];
            if(_v!=_p && (instance_is(_v,Player) || instance_is(_v,enemy) || instance_is(_v,Wall)
                || instance_is(_v,NothingInactive) || instance_is(_v,LastIntro) || instance_is(_v,BigGenerator)
                || instance_is(_v,CrystalShield) || instance_is(_v,MobileUI) || instance_is(_v,MenuOptions))) {
                array_push(_parked,_v);instance_deactivate_object(_v);
            }
        }
        Key=json_parse(json_stringify(_bindings));global.index=0;global.console_active=false;
        GameCont.skills=_skills;GameCont.ntte_full_native_skill_counts={};GameCont.ntte_full_skills={};
        GameCont.area=area_desert;GameCont.subarea=1;GameCont.loops=0;GameCont.crown=crwn_none;
        UberCont.opt_gamepad=true;UberCont.opt_keyboard=false;UberCont.opt_aimbot=true;
        UberCont.opt_splitfire=true;UberCont.block_input_fire=false;
        _p.index=0;_p.x=199000;_p.y=199000;_p.xprevious=_p.x;_p.yprevious=_p.y;
        _p.speed=0;_p.team=team_player;_p.race=Race.Fish;

        var _enemy=instance_create(_p.x+64,_p.y-48,Bandit),
            _far=instance_create(_p.x+160,_p.y+64,Bandit),
            _ally=instance_create(_p.x+16,_p.y-8,Bandit),
            _dead=instance_create(_p.x+8,_p.y-4,Bandit),
            _wall=instance_create(_p.x+100000,_p.y,Wall);
        _enemy.team=team_enemy;_enemy.hp=100;_far.team=team_enemy;_far.hp=100;
        _ally.team=team_player;_ally.hp=100;_dead.team=team_enemy;_dead.hp=0;
        // A real shield's no-Player constructor branch avoids playing sounds
        // or changing external audio emitter state while creating the fixture.
        var _shield_x=_p.x,_shield_y=_p.y;
        instance_deactivate_object(_p);_owner_inactive=true;
        var _shield=instance_create(_shield_x,_shield_y,CrystalShield);
        instance_activate_object(_p);_owner_inactive=false;
        _shield.creator=noone;_shield.sprite_index=_shield.spr_idle;
        var _stick=instance_create(0,0,JoystickAttack);
        assert(instance_exists(_stick),"Gamepad fixture's real JoystickAttack failed Create");
        _stick.get_nearest_touch=method(_stick,function(_radius){return -1;});
        _stick.index=-1;_stick.hold=0;_stick.dis=0;_stick.vdis=0;

        var _pad={lh:0,lv:1,rh:-1,rv:0,key:gp_shoulderr,held:true,pressed:true,released:false};
        _pad.get_held=method(_pad,function(_key){return _key==key && held;});
        _pad.get_pressed=method(_pad,function(_key){return _key==key && pressed;});
        _pad.get_released=method(_pad,function(_key){return _key==key && released;});
        _pad.get_value=method(_pad,function(_axis){
            switch(_axis) {
                case gp_axislh:return lh;case gp_axislv:return lv;
                case gp_axisrh:return rh;case gp_axisrv:return rv;
            }
            return 0;
        });
        global.__input_gamepads=[_pad];Key.fire=[-1,_pad.key];
        // These named actions still pass through genuine key_check. Separate
        // bindings keep the ordinary fire action out of Scythe remap conflicts.
        Key.spec=[-1,gp_face1];Key.pick=[-1,gp_face2];Key.swap=[-1,gp_face3];
        Key.horn=[-1,gp_select];Key.scythe=[-1,gp_face4];

        var _names=["nearest","cached-friend","cached-dead","only-friends","occluded",
            "option-off","clicked","crystal-no-tb","crystal-active-tb",
            "crystal-disappearing-tb","crystal-unowned-shield","released-fire"];
        for(var _case=0;_case<array_length(_names);++_case) {
            var _name=_names[_case],_race=(_case>=7 && _case<=10)?Race.Crystal:Race.Fish,
                _clicked=(_case==6),_cached=_case==1?_ally:(_case==2?_dead:noone);
            _enemy.team=team_enemy;_far.team=team_enemy;_wall.x=_p.x+100000;_wall.y=_p.y;
            _shield.creator=noone;_shield.sprite_index=_shield.spr_idle;ds_list_clear(_skills);
            if(_case==3) {_enemy.team=team_player;_far.team=team_player;_cached=_ally;}
            if(_case==4) {
                _wall.x=(_p.x+_enemy.x)/2;_wall.y=(_p.y+_enemy.y)/2;
                _wall.x+=(_p.x+_enemy.x)/2-(_wall.bbox_left+_wall.bbox_right)/2;
                _wall.y+=(_p.y+_enemy.y)/2-(_wall.bbox_top+_wall.bbox_bottom)/2;
                assert(collision_line(_p.x,_p.y,_enemy.x,_enemy.y,Wall,true,true)==_wall,
                    "Gamepad occlusion control did not use an actual native Wall mask");
            }
            if(_case>=8 && _case<=10) ds_list_add(_skills,mut_throne_butt);
            if(_case==8 || _case==9) _shield.creator=_p;
            if(_case==9) _shield.sprite_index=_shield.spr_disappear;
            UberCont.opt_aimbot=(_case!=5);
            _pad.held=(_case!=11);_pad.pressed=(_case mod 2==0 && _case!=11);_pad.released=(_case==11);

            // The actual raw stick sampler supplies the touch-equivalent
            // initial direction/distance, including a deflected right stick.
            scrNTTEFullGamepadAutoAimFixtureReset(_p,_keybytes,_cached,_race,_clicked);
            with(UberCont) scrSetGamepadInputs(0);
            var _rawbytes=json_stringify(KeyCont),_rawdir=KeyCont.dir_fire[0],
                _rawdis=KeyCont.dis_fire[0],_move=KeyCont.dir_move[0],_moving=KeyCont.moving[0];
            assert(abs(angle_difference(_rawdir,180))<0.0001 && _moving
                && abs(angle_difference(_move,270))<0.0001,
                "Gamepad fixture did not exercise the genuine left/right axis sampler");

            scrNTTEFullGamepadAutoAimFixtureReset(_p,_keybytes,_cached,_race,_clicked);
            with(UberCont) scrHandleInputsGeneral(0);
            var _actual=scrNTTEFullGamepadAutoAimFixtureResult(_p),
                _expected_fire=[_pad.held,_pad.pressed,_pad.released],
                _allowed=UberCont.opt_aimbot && _case!=8;
            assert(json_stringify(_actual.fire)==json_stringify(_expected_fire),
                "General automatic aim rewrote the real sampled fire transitions: "+_name);
            assert(scrNTTEFullAutoAimAllowed(_p)==_allowed,"Crystal/option autoaim gate disagrees: "+_name);
            if(!_allowed || _clicked) {
                assert(abs(angle_difference(_actual.aim[0],_rawdir))<0.0001
                    && abs(_actual.aim[1]-_rawdis)<0.0001 && _actual.aim[2]==_cached && _actual.aim[3]==0.9,
                    "Disabled/clicked/CrystalTB automatic aim changed manual stick input: "+_name);
            } else if(_case==3 || _case==4) {
                var _fallback=angle_lerp(_rawdir,angle_lerp(_rawdir,_move,0.5),0.75);
                assert(abs(angle_difference(_actual.aim[0],_fallback))<0.0001
                    && _actual.aim[1]==64*_moving && _actual.aim[3]==0.5,
                    "No visible target did not smoothly follow movement: "+_name);
                if(_case==3) assert(_actual.aim[2]==noone,"Only friendly/dead targets retained a target");
                // The existing touch algorithm retains a valid but occluded
                // cache while using movement aim. Preserve that old behavior.
                if(_case==4) assert(_actual.aim[2]==_enemy,"Occlusion changed source cache policy");
            } else {
                var _toward=point_direction(_p.x,_p.y,_enemy.x,_enemy.y),
                    _wanted=angle_lerp(_rawdir,_toward,0.75);
                assert(_actual.aim[2]==_enemy && abs(angle_difference(_actual.aim[0],_wanted))<0.0001
                    && abs(_actual.aim[1]-min(80,min(view_width,view_height)*0.4))<0.0001,
                    "Full automatic aim did not select the nearest live hostile: "+_name);
                assert(_actual.aim[2]!=_ally && _actual.aim[2]!=_dead,
                    "Autoaim accepted a friendly or dead cached target: "+_name);
            }

            // MobileUI still exists in a gamepad session. Its real event must
            // not run the same 0.75 interpolation and enemy scan a second time.
            with(_stick) event_user(0);
            var _after_ui=scrNTTEFullGamepadAutoAimFixtureResult(_p);
            assert(json_stringify(_actual)==json_stringify(_after_ui),
                "JoystickAttack repeated/changed General gamepad aim or fire: "+_name);

            // Independently exercise the exact shared call used by touch from
            // the same raw input. This also proves scrJoyAim itself leaves all
            // three fire states untouched, including release-only input.
            scrNTTEFullGamepadAutoAimFixtureReset(_p,_rawbytes,_cached,_race,_clicked);
            UberCont.opt_gamepad=false;KeyCont.hold_fire[0]=_pad.held;
            KeyCont.press_fire[0]=_pad.pressed;KeyCont.release_fire[0]=_pad.released;
            with(_p) scrJoyAim(_stick.rad);
            var _touch=scrNTTEFullGamepadAutoAimFixtureResult(_p);
            assert(json_stringify(_actual)==json_stringify(_touch),
                "General gamepad aim differs from the same Player touch call: "+_name);

            // The real touch event includes touch-only fire sampling. Compare
            // aim fields only. Active CrystalTB deliberately has a separate
            // movement-directed teleport cursor; do not erase that behavior.
            if(_case!=8) {
                scrNTTEFullGamepadAutoAimFixtureReset(_p,_rawbytes,_cached,_race,_clicked);
                UberCont.opt_gamepad=false;_stick.index=-1;_stick.hold=0;_stick.dis=0;_stick.vdis=0;
                with(_stick) event_user(0);
                var _event_touch=scrNTTEFullGamepadAutoAimFixtureResult(_p);
                assert(json_stringify(_actual.aim)==json_stringify(_event_touch.aim),
                    "Actual JoystickAttack touch aim differs from General: "+_name);
                _touch_cases++;
            }
            scrNTTESmokeLog("GAMEPAD AUTOAIM "+_name+" General/fake-axis+fire,shared-touch parity,native targets/UI-once OK");
            _cases++;
        }
    } finally {
        if(_owner_inactive) instance_activate_object(_p);
        scrNTTEFullMergedRuntimeTestCleanup(_before);
        for(var _i=0;_i<array_length(_parked);++_i) instance_activate_object(_parked[_i]);
        scrNTTEFullAreaGeneratorRestore(_players);scrNTTEFullAreaGeneratorRestore(_game);
        scrNTTEFullAreaGeneratorRestore(_back);scrNTTEFullAreaGeneratorRestore(_uber);
        KeyCont=_keys;Key=_bindings;global.__input_gamepads=_pads;global.index=_index;
        global.console_active=_console;keymap_ret_nogamepad=_flag;
        ds_list_destroy(_skills);current_frame=_frame;global.rng_state=_streams;random_set_seed(_seed);
        assert(KeyCont==_keys && json_stringify(KeyCont)==_keybytes,"Gamepad autoaim mutated original KeyCont");
    }
    scrNTTESmokeLog("PASS GAMEPAD AUTOAIM actual General/axis/named-fire,12 policy cases,"
        +string(_touch_cases)+" actual touch events,CrystalTB/wall/friendly/dead/once-only UI; physical pads untested @"+string(30/timescale));
}


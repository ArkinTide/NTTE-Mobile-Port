#macro savegame_file (scrNTTESmokeEnabled() ? working_directory+"smoke-save/savegame.dat" : "savegame.dat")

enum SavegamePart {
	SessionData,
	GlobalVars,
	PlayerData
}

function scrSavegameSave() {
	var _buffer = buffer_create(0xffff, buffer_grow, 1), _step_name;
// BEGIN NTTE SAVE BUFFER OWNERSHIP SAVE OPEN
try {
// END NTTE SAVE BUFFER OWNERSHIP SAVE OPEN
	
	try {
        GameCont.ntte_full_pet_save=scrNTTEFullPetExport()
        GameCont.ntte_full_orchid_save=scrNTTEFullOrchidExport()
        GameCont.ntte_full_native_weapon_save=scrNTTEFullWeaponNativeExport()
		scrSavegameSession(_buffer, false)
		scrSavegameGlobals(_buffer, false)
		scrSavegamePlayers(_buffer, false)
	}
	catch(e) {
		return print_exception($"Failed to write game save.", e)
	}
	
	if (buffer_exists(_buffer)) buffer_save(_buffer, savegame_file)
// BEGIN NTTE SAVE BUFFER OWNERSHIP SAVE CLOSE
}
finally {
    if (buffer_exists(_buffer)) buffer_delete(_buffer)
}
// END NTTE SAVE BUFFER OWNERSHIP SAVE CLOSE
}

function scrSavegameLoad(_only_first_part = false) {
// BEGIN NTTE CUZ CONNECTED TEST LOAD BEGIN
if(os_type==os_windows && scrNTTEFullSmokeEnabled() && instance_exists(NTTEFullCuzConnectedTest)) try { if(!_only_first_part) scrNTTEFullCuzConnectedProbe("Load.begin"); }
catch(_ntte_cuz_connected_error) { scrNTTEFullCuzConnectedAbort(_ntte_cuz_connected_error); }
// END NTTE CUZ CONNECTED TEST LOAD BEGIN
// BEGIN NTTE PALACE ARTIFACT CONTINUE TEST FULL LOAD BEGIN
if(os_type==os_windows && scrNTTEFullSmokeEnabled() && instance_exists(NTTEFullPalaceArtifactContinueTest)) try { scrNTTEFullPalaceArtifactContinueProbe("Load.begin",_only_first_part); }
catch(_ntte_palace_artifact_error) { scrNTTEFullPalaceArtifactContinueAbort(_ntte_palace_artifact_error); }
// END NTTE PALACE ARTIFACT CONTINUE TEST FULL LOAD BEGIN
// BEGIN NTTE TRENCH SECOND HOP TEST LOAD BEGIN
if(os_type==os_windows && scrNTTEFullSmokeEnabled() && instance_exists(NTTEFullTrenchSecondHopConnectedTest)) try { scrNTTEFullTrenchSecondHopLoadProbe(_only_first_part); }
catch(_ntte_trench_second_hop_error) { scrNTTEFullTrenchSecondHopAbort(_ntte_trench_second_hop_error); }
// END NTTE TRENCH SECOND HOP TEST LOAD BEGIN
// BEGIN NTTE TRENCH CONNECTED CAMPAIGN TEST LOAD BEGIN
if(os_type==os_windows && scrNTTEFullSmokeEnabled() && instance_exists(NTTEFullTrenchConnectedCampaignTest)) try { scrNTTEFullTrenchCampaignLoadProbe(_only_first_part); }
catch(_ntte_trench_campaign_error) { scrNTTEFullTrenchCampaignAbort(_ntte_trench_campaign_error); }
// END NTTE TRENCH CONNECTED CAMPAIGN TEST LOAD BEGIN
	var _buffer = buffer_load(savegame_file)
// BEGIN NTTE HQ STOLEN CONTINUE TEST FULL LOAD BEGIN
if(os_type==os_windows && scrNTTEFullSmokeEnabled() && instance_exists(NTTEFullHQStolenContinueTest)) try { scrNTTEFullHQStolenContinueProbe("Load.begin",_only_first_part); }
catch(_ntte_hq_stolen_error) { scrNTTEFullHQStolenContinueAbort(_ntte_hq_stolen_error); }
// END NTTE HQ STOLEN CONTINUE TEST FULL LOAD BEGIN
// BEGIN NTTE PALACE ARTIFACT PORTAL CARRY TEST FULL LOAD BEGIN
if(os_type==os_windows && scrNTTEFullSmokeEnabled() && instance_exists(NTTEFullPalaceArtifactPortalCarryTest)) try { scrNTTEFullPalaceArtifactPortalCarryProbe("Load.begin",_only_first_part); }
catch(_ntte_palace_carry_error) { scrNTTEFullPalaceArtifactPortalCarryAbort(_ntte_palace_carry_error); }
// END NTTE PALACE ARTIFACT PORTAL CARRY TEST FULL LOAD BEGIN
	
// BEGIN NTTE QUEST ARTIFACT CARRY LIFECYCLE TEST LOAD
if(os_type==os_windows && scrNTTEFullSmokeEnabled() && instance_exists(NTTEFullQuestCarryTest)) try { scrNTTEFullQuestCarryProbe("Load",_only_first_part); }
catch(_ntte_quest_carry_error) { scrNTTEFullQuestCarryAbort(_ntte_quest_carry_error); }
// END NTTE QUEST ARTIFACT CARRY LIFECYCLE TEST LOAD
	if (_only_first_part) {
// BEGIN NTTE SAVE BUFFER OWNERSHIP PREVIEW OPEN
try {
// END NTTE SAVE BUFFER OWNERSHIP PREVIEW OPEN
		while (buffer_tell(_buffer) < buffer_get_size(_buffer)) {
			var _part_index = buffer_read(_buffer, buffer_u8)
			if (_part_index == SavegamePart.SessionData) {
				buffer_seek(_buffer, buffer_seek_relative, -1)
				return scrSavegameSession(_buffer, true)
			}
		}
		exit
	// BEGIN NTTE SAVE BUFFER OWNERSHIP PREVIEW CLOSE
}
finally {
    if (buffer_exists(_buffer)) buffer_delete(_buffer)
}
// END NTTE SAVE BUFFER OWNERSHIP PREVIEW CLOSE
}
	
	try {
		scrSavegameSession(_buffer, true)
		scrSavegameGlobals(_buffer, true)
		scrSavegamePlayers(_buffer, true)
        scrNTTEFullOrchidImport(scrNTTEFullValue(GameCont,"ntte_full_orchid_save",undefined))
        scrNTTEFullPetImport(scrNTTEFullValue(GameCont,"ntte_full_pet_save",undefined))
		
		return true
	}
	finally {
		if (buffer_exists(_buffer)) buffer_delete(_buffer)
	}
	
	return false
}

function scrSavegameSession(_buffer, _is_load) {
    var _part_index = SavegamePart.SessionData, _session_info;
	
	if (_is_load) {
		assert(buffer_read(_buffer, buffer_u8) == _part_index, "Invalid session part index")
		_session_info = json_parse(buffer_read(_buffer, buffer_string))
		
		array_foreach(_session_info.players, function(_player_data) {
			if (!is_struct(_player_data)) exit
			
			var _pinst = scr_playerinstance_find(_player_data.index)
			
			if (is_undefined(_pinst)) {
				_pinst = new PlayerInstance()
				scr_playerinstance_add(_player_data.index, _pinst)
			}
			
			_pinst.read_from_struct(_player_data)
		})
		
		with (GameCont) {
			array_foreach(_session_info.session_data, function(_entry) {
				var _vname = _entry.name,
					_value = _entry.value
				
				if (_vname == "skills") {
					return ds_list_read(skills, _value)
				}
				
				variable_struct_set(self, _vname, _value)
			})
		}
		
        scrNTTEFullWeaponNativeImport(scrNTTEFullValue(GameCont,"ntte_full_native_weapon_save",undefined))
// BEGIN NTTE PALACE ARTIFACT CONTINUE TEST SESSION REGISTRY IMPORT
if(os_type==os_windows && scrNTTEFullSmokeEnabled() && instance_exists(NTTEFullPalaceArtifactContinueTest)) try { scrNTTEFullPalaceArtifactContinueProbe("Session.Import.after"); }
catch(_ntte_palace_artifact_error) { scrNTTEFullPalaceArtifactContinueAbort(_ntte_palace_artifact_error); }
// END NTTE PALACE ARTIFACT CONTINUE TEST SESSION REGISTRY IMPORT
// BEGIN NTTE QUEST ARTIFACT CARRY LIFECYCLE TEST SESSION
if(os_type==os_windows && scrNTTEFullSmokeEnabled() && instance_exists(NTTEFullQuestCarryTest)) try { scrNTTEFullQuestCarryProbe("Session"); }
catch(_ntte_quest_carry_error) { scrNTTEFullQuestCarryAbort(_ntte_quest_carry_error); }
// END NTTE QUEST ARTIFACT CARRY LIFECYCLE TEST SESSION
		global.recontinued_times = _session_info.recontinued_times
// BEGIN NTTE HQ STOLEN CONTINUE TEST SESSION REGISTRY IMPORT
if(os_type==os_windows && scrNTTEFullSmokeEnabled() && instance_exists(NTTEFullHQStolenContinueTest)) try { scrNTTEFullHQStolenContinueProbe("Session.Import.after"); }
catch(_ntte_hq_stolen_error) { scrNTTEFullHQStolenContinueAbort(_ntte_hq_stolen_error); }
// END NTTE HQ STOLEN CONTINUE TEST SESSION REGISTRY IMPORT
// BEGIN NTTE PALACE ARTIFACT PORTAL CARRY TEST SESSION REGISTRY IMPORT
if(os_type==os_windows && scrNTTEFullSmokeEnabled() && instance_exists(NTTEFullPalaceArtifactPortalCarryTest)) try { scrNTTEFullPalaceArtifactPortalCarryProbe("Session.Import.after"); }
catch(_ntte_palace_carry_error) { scrNTTEFullPalaceArtifactPortalCarryAbort(_ntte_palace_carry_error); }
// END NTTE PALACE ARTIFACT PORTAL CARRY TEST SESSION REGISTRY IMPORT
		
		with (UberCont) {
			// Old challenge saves resume as offline runs in the NTTE edition.
			daily_run = false
			weekly_run = false
			custom = _session_info.custom
			custom_options = _session_info.custom_options
			hardmode = _session_info.hardmode
			
			if (is_string(_session_info.weekly_data)) {
				if (!ds_exists(weekly_data, ds_type_map)) {
					weekly_data = ds_map_create()
				}
				
				ds_map_read(weekly_data, _session_info.weekly_data)
			}
		}
		
        scrUGRebaseLoadedValue(_session_info.persistentweps,"persistentweps");
		GameCont.persistentweps = _session_info.persistentweps
		
		array_foreach(_session_info.unlockscreens, function(_struct) {
			scrUnlockScreenCreate(_struct.race, _struct.bskin)
		})
	}
	else {
		_session_info = {
			players: scr_playerinstances_get_all(),
			
			// GameCont data
			session_data: [],
			
	        hardmode: UberCont.hardmode,
			recontinued_times: global.recontinued_times,
			
	        daily_run: UberCont.daily_run,
	        weekly_run: UberCont.weekly_run,
			weekly_data: undefined,
			
			custom: UberCont.custom,
			custom_options: UberCont.custom_options,
			
			persistentweps: [],
			unlockscreens: [],
			
	        ammo: undefined,
	        hp: undefined,
	        spirit: undefined,
			max_hp: undefined,
			headloses: undefined
	    }
		
		with (UberCont) if (is_numeric(weekly_data) && ds_exists(weekly_data, ds_type_map)) {
			_session_info.weekly_data = ds_map_write(weekly_data)
		}
		
		with (GameCont) {
			var _keys = variable_struct_get_names(id),
				_count = array_length(_keys)
			
			for(var i = 0; i < _count; ++i) {
				var _vname = _keys[i],
					_value = self[$ _vname]
				
				if (_vname == "skills") _value = ds_list_write(_value)
                if (_vname == "ntte_pet_history") _value = scrNTTEFullPetHistoryExport(_value)
				
				array_push(_session_info.session_data, {
					name: _vname, value: _value
				})
			}
		}

	    with Player {
	        _session_info.ammo = ammo
	        _session_info.hp = hp
	        _session_info.spirit = spirit
			_session_info.max_hp = max_hp
			_session_info.headloses = headloses
			
			with WepPickup if (persistent) {
				array_push(_session_info.persistentweps, {
					wep: wep, curse: curse, ammo: ammo
				})
		    }
			
			with UnlockScreen {
				array_insert(_session_info.unlockscreens, 0, {
					race: race, bskin: bskin
				})
			}
	    }
		
		buffer_write(_buffer, buffer_u8, _part_index)
	    buffer_write(_buffer, buffer_string, json_stringify(_session_info))
	}
}

function scrSavegameGlobals(_buffer, _is_load) {
	var _part_index = SavegamePart.GlobalVars, _globals;
	
	if (_is_load) {
		assert(buffer_read(_buffer, buffer_u8) == _part_index, "Invalid global variable part index")
		_globals = json_parse(buffer_read(_buffer, buffer_string))
		
		struct_foreach(_globals, function(_vname, _value) {
			variable_global_set(_vname, _value)
		})
	}
	else {
		_globals = {}
		
	    var _global_keys = [
			"rng_state", "index", "seed", "is_server", "custom_seed",
			"current_frame", "party_gun_special_drop", "crownpick",
			"recontinued_times",
		]
		
		with (_globals) array_foreach(_global_keys, function(_vname) {
			assert(variable_global_exists(_vname), $"Global variable \"{_vname}\" doesn't exist")
			self[$ _vname] = variable_global_get(_vname)
		})
		
		buffer_write(_buffer, buffer_u8, _part_index)
	    buffer_write(_buffer, buffer_string, json_stringify(_globals))
	}
}

function scrSavegamePlayers(_buffer, _is_load) {
	var _part_index = SavegamePart.PlayerData
	
	if (_is_load) {
		assert(buffer_read(_buffer, buffer_u8) == _part_index, "Invalid player data part index")
		var _player_data = json_parse(buffer_read(_buffer, buffer_string)),
			_count = array_length(_player_data)
		
		for(var i = 0; i < _count; ++i) {
			var _player_info = _player_data[i],
				_object_index = asset_get_index(_player_info.object_index_name)
			
			variable_struct_remove(_player_info, "object_index_name")
            scrUGRebaseLoadedValue(_player_info);
			
			with (instance_create(0, 0, _object_index)) {
				struct_foreach(_player_info, function(_vname, _value) {
					// 不覆盖方法成员：旧存档可能带回 pref 之类
					// 序列化残余（null/字符串），直接写入会让实例丢失方法（Android+Rogue 崩溃）。
					if (!variable_instance_exists(self, _vname) || !is_method(variable_instance_get(self, _vname))) {
						if (_vname=="ntte_last_harpoon") _value=noone
						if (_vname=="ntte_state" || _vname=="bntte_state") _value=scrNTTEStateRestored(_value)
						if (_vname=="ntte_extra_states" && is_array(_value)) {
							for(var _j=0;_j<array_length(_value);++_j) _value[_j]=scrNTTEStateRestored(_value[_j])
						}
						self[$ _vname] = _value
					}
				})
                scrNTTEFullPlayerRateAfterLoad(_player_info);
                scrNTTEFullWeaponNativeAfterLoad();
// BEGIN NTTE CUZ CONNECTED TEST PLAYER LOAD
if(os_type==os_windows && scrNTTEFullSmokeEnabled() && instance_exists(NTTEFullCuzConnectedTest)) try { scrNTTEFullCuzConnectedProbe("Player.Load",id); }
catch(_ntte_cuz_connected_error) { scrNTTEFullCuzConnectedAbort(_ntte_cuz_connected_error); }
// END NTTE CUZ CONNECTED TEST PLAYER LOAD
// BEGIN NTTE PALACE ARTIFACT CONTINUE TEST PLAYER REBIND
if(os_type==os_windows && scrNTTEFullSmokeEnabled() && instance_exists(NTTEFullPalaceArtifactContinueTest)) try { scrNTTEFullPalaceArtifactContinueProbe("Player.Load.after"); }
catch(_ntte_palace_artifact_error) { scrNTTEFullPalaceArtifactContinueAbort(_ntte_palace_artifact_error); }
// END NTTE PALACE ARTIFACT CONTINUE TEST PLAYER REBIND
// BEGIN NTTE QUEST ARTIFACT CARRY LIFECYCLE TEST PLAYER LOAD
if(os_type==os_windows && scrNTTEFullSmokeEnabled() && instance_exists(NTTEFullQuestCarryTest)) try { scrNTTEFullQuestCarryProbe("PlayerLoad"); }
catch(_ntte_quest_carry_error) { scrNTTEFullQuestCarryAbort(_ntte_quest_carry_error); }
// END NTTE QUEST ARTIFACT CARRY LIFECYCLE TEST PLAYER LOAD
                scrNTTEFullBonusAfterLoad();
                scrNTTEFullRaceNativeAfterLoad();
// BEGIN NTTE HQ STOLEN CONTINUE TEST PLAYER REBIND
if(os_type==os_windows && scrNTTEFullSmokeEnabled() && instance_exists(NTTEFullHQStolenContinueTest)) try { scrNTTEFullHQStolenContinueProbe("Player.Load.after"); }
catch(_ntte_hq_stolen_error) { scrNTTEFullHQStolenContinueAbort(_ntte_hq_stolen_error); }
// END NTTE HQ STOLEN CONTINUE TEST PLAYER REBIND
// BEGIN NTTE PALACE ARTIFACT PORTAL CARRY TEST PLAYER REBIND
if(os_type==os_windows && scrNTTEFullSmokeEnabled() && instance_exists(NTTEFullPalaceArtifactPortalCarryTest)) try { scrNTTEFullPalaceArtifactPortalCarryProbe("Player.Load.after"); }
catch(_ntte_palace_carry_error) { scrNTTEFullPalaceArtifactPortalCarryAbort(_ntte_palace_carry_error); }
// END NTTE PALACE ARTIFACT PORTAL CARRY TEST PLAYER REBIND
			}
		}
	}
	else {
		var _player_data = [],
			_object = Player
		
		repeat (2) {
			var _n = instance_number(_object)
			
			for(var i = 0; i < _n; ++i) with (instance_find(Player, i)) {
				var _player_info = {
					object_index_name: object_get_name(object_index)
				}
				
				var _keys = variable_struct_get_names(id)
				for(var j = array_length(_keys) - 1; j >= 0; --j) {
					var _key = _keys[j],
						_value = self[$ _key]
					
					// 跳过方法成员（如 `pref`）：方法属于代码而非状态，
					// JSON 无法还原（会变成不可调用值），读档写回时会覆盖新实例的方法并崩溃。
					//
					if (!is_method(_value) && scrNTTEFullBonusSaveField(_key)) _player_info[$ _key] = _value
				}
				
				array_push(_player_data, _player_info)
			}
			
			_object = Revive
		}
		
		buffer_write(_buffer, buffer_u8, _part_index)
		buffer_write(_buffer, buffer_string, json_stringify(_player_data))
	}
}

function scrPersistentJsonRead(_path,_validate=undefined) {
    if(!file_exists(_path)) return undefined
    var _file=file_text_open_read(_path),_json=""
    if(_file<0) return undefined
    try {
        while(!file_text_eof(_file)) { _json+=file_text_read_string(_file);file_text_readln(_file) }
    } finally { file_text_close(_file) }
    try {
        var _state=json_parse(_json)
        if(!is_struct(_state) || (is_callable(_validate) && !_validate(_state))) return undefined
        return _json
    } catch(_error) { return undefined }
}
function scrPersistentJsonLoad(_path,_validate=undefined) {
    var _paths=[_path,_path+".tmp",_path+".bak"]
    for(var _i=0;_i<array_length(_paths);++_i) {
        var _json=scrPersistentJsonRead(_paths[_i],_validate)
        if(!is_undefined(_json)) return _json
    }
    return undefined
}
function scrPersistentJsonSave(_path,_json,_validate=undefined) {
    var _tmp=_path+".tmp",_backup=_path+".bak",_file=file_text_open_write(_tmp)
    if(_file<0) return false
    try { file_text_write_string(_file,_json) } finally { file_text_close(_file) }
    if(scrPersistentJsonRead(_tmp,_validate)!=_json) return false
    // Only a validated previous primary may replace the last healthy backup.
    if(file_exists(_path)) {
        if(!is_undefined(scrPersistentJsonRead(_path,_validate))) {
            if(file_exists(_backup)) file_delete(_backup)
            file_rename(_path,_backup)
        } else {
            var _damaged=_path+".corrupt",_suffix=0
            while(file_exists(_damaged)) { _suffix++;_damaged=_path+".corrupt."+string(_suffix) }
            file_rename(_path,_damaged)
        }
        if(file_exists(_path)) return false
    }
    file_rename(_tmp,_path)
    return scrPersistentJsonRead(_path,_validate)==_json
}

function scrSave() {
    if(variable_global_exists("ntte_full_progress")) scrNTTEFullProgressSave()
    with UberCont {
		var stats = true,
			save = saveData,
			savepath = game_directory + "NuclearThrone.sav"
		
		if (!public) scr_debug_overlay_save()
		
        if (public && scr_debug_cheats_enabled()) {
			var data;
			
			var _previous=scrPersistentJsonLoad(savepath)
			if !is_undefined(_previous) {
				data = json_decode(_previous)
			}
			else {
				data = ds_map_create()
			}
			
			var options = [
				"cheats_console", "cheats_griller", "cheats_practice", "options_gamepad", "options_keyboard",
				"etc_nickname", "visual_resolution", "visual_fullscreen",
				// 白名单漏了 ORIGINAL CONSOLE →
				// 这个开关**从来没被写进存档**（其它 cheat 项都在名单里，所以只有它不持久）。
				"cheats_orig_console",
				"cheats_framerate_ingame",
				"options_framerate",
				"visual_particles",
			]
			
			for(var _race_id = 0; _race_id < array_length(cpref_list); _race_id ++)
				array_push(options, "cprefs_" + cpref_list[_race_id])
			
			for(var _race_id = 0; _race_id < array_length(options); _race_id ++) {
				var opt = options[_race_id]
				
				data[? opt] = saveData[? opt]
			}
			
			stats = false
			save = data
		}

        saving = 30
		
		if stats {
	        save_set_value("data", "tot_time", tot_time)
	        save_set_value("data", "tot_banditkills", tot_banditkills)
			
			if (!(scrGameIsEventRun() || scrGameIsCustomMode())) {
				save_set_value("etc", "protowep", protowep)
			}
			
	        for (var _race_id = Race.Fish; _race_id < Race.NUM_ALL_RACE_TYPES; ++_race_id) {
	            save_set_value("ctotkill", string(_race_id), ctot_kill[_race_id])
	            save_set_value("ctotdead", string(_race_id), ctot_dead[_race_id])
	            save_set_value("ctotloop", string(_race_id), ctot_loop[_race_id])
	            save_set_value("ctottime", string(_race_id), ctot_time[_race_id])
	            save_set_value("ctotwins", string(_race_id), ctot_wins[_race_id])
	            save_set_value("ctotuniq", string(_race_id), ctot_uniq[_race_id])
	            save_set_value("ctotruns", string(_race_id), ctot_runs[_race_id])
	            save_set_value("ctotwins", string(_race_id), ctot_wins[_race_id])
	            save_set_value("ctotdays", string(_race_id), ctot_days[_race_id])
	            save_set_value("ctothard", string(_race_id), ctot_hard[_race_id])
	            save_set_value("ctotstrk", string(_race_id), ctot_strk[_race_id])
	            save_set_value("cbstkill", string(_race_id), cbst_kill[_race_id])
	            save_set_value("cbstdiff", string(_race_id), cbst_diff[_race_id])
	            save_set_value("cbstloop", string(_race_id), cbst_loop[_race_id])
	            save_set_value("cbsttime", string(_race_id), cbst_time[_race_id])
	            save_set_value("cbstarea", string(_race_id), cbst_area[_race_id])
	            save_set_value("cbstsuba", string(_race_id), cbst_suba[_race_id])
	            save_set_value("cbstrace", string(_race_id), cbst_race[_race_id])
	            save_set_value("cbststrk", string(_race_id), cbst_strk[_race_id])
	            save_set_value("cbstfast", string(_race_id), cbst_fast[_race_id])
	            save_set_value("hbstkill", string(_race_id), hbst_kill[_race_id])
	            save_set_value("hbstarea", string(_race_id), hbst_area[_race_id])
	            save_set_value("hbstsuba", string(_race_id), hbst_suba[_race_id])
	            save_set_value("hbstloop", string(_race_id), hbst_loop[_race_id])
	            save_set_value("hbstrace", string(_race_id), hbst_race[_race_id])
	            save_set_value("dbstkill", string(_race_id), dbst_kill[_race_id])
	            save_set_value("dbstarea", string(_race_id), dbst_area[_race_id])
	            save_set_value("dbstsuba", string(_race_id), dbst_suba[_race_id])
	            save_set_value("dbstloop", string(_race_id), dbst_loop[_race_id])
	            save_set_value("dbstrace", string(_race_id), dbst_race[_race_id])
	            save_set_value("cwep",  string(_race_id), cwep[_race_id])
	            save_set_value("cgot",  string(_race_id), cgot[_race_id])
	            save_set_value("cskin", string(_race_id), cskin[_race_id])
				
				// 上游 BUG：scrRaceGetMaxSkinCount 的结果随「自定义模式
				// unlock_chars 参数 / ULTRA_MUTANT 成就」动态变化（Robot 3→4、Skeleton 3→2），而
				// cskingot 数组是启动时按当时的值建立的 → 之后重算变大即读越界崩溃（Android 实测：
				// index out of bounds request 3 maximum size is 3）。修行：以数组实际长度为准
				// （数组里有几个槽保存几个），与 scrInit 建数组的口径一致化，永不越界。
				var _skin_max = array_length(cskingot[_race_id])
				for(var _skin_id = 0; _skin_id < _skin_max; ++_skin_id) {
					save_set_value("cskingot" + string(_race_id), _skin_id, cskingot[_race_id, _skin_id])
				}
				
	            for(var _crown_id = 1; _crown_id <= crownmax; _crown_id++) {
	                save_set_value("crowngot" + string(_race_id), string(_crown_id), crowngot[_race_id, _crown_id])
	            }
	        }
			
	        var f = file_text_open_write(scrNTTESmokeEnabled() ? game_directory+"temp":"temp")
	        file_text_write_string(f, string(save_get_value("etc", "seed", -1)))
	        file_text_close(f)
		}
		
		var json = json_encode(save)
		
		if(!scrPersistentJsonSave(savepath,json)) show_debug_message("Native progress save could not be committed: "+savepath)
		if(!scrNTTESmokeEnabled() && savepath!="NuclearThrone.sav") scrPersistentJsonSave("NuclearThrone.sav",json)
		
		scrCustomModeSavePresets()
    }
}

if async_load[? "http_status"] != 200
or !is_string(async_load[? "result"])
	exit

if async_load[? "id"] == update_request {
    if !is_undefined(async_load[? "result"]) && async_load[? "result"] != -1 {
        var result = json_decode(async_load[? "result"])

        if (!is_undefined(result)) {
			var vname = BETA ? "versionBeta": "version"
            if result[? vname] > GAME_BUILD {
				var str = loc_fmt("A Build version #% is now available.\nOpen the download page?", string(result[? vname]))
                update_message = show_question_async(str)
				if (instance_exists(Player) && !scrGameIsPaused()) scrGamePause()
            }

			// Retain update information; this edition has no challenge service.
			leaderboards_allowed = false
            update_info = result
			if is_string(result[? "updateURL"]) update_url = result[? "updateURL"]
			update_notified = true
        }
    }
}

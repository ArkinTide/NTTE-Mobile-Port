#macro URL_TBAPI "https://raw.githubusercontent.com/toarch7/torcherdev/main/"

function tb_api(type) {
    if (type == "daily" || type == "weekly") return -1
    return scrHttpGet(URL_TBAPI + type + "data.json")
}

function scrGameQueryUpdateVersion() {
    return scrNTTEUpdateCheck(true)
}

function scrValidateWeeklyLoadout(_map) {
	random_set_seed(real(_map[? "seed"] ?? global.seed))
	
	_map[? "week"] = date_get_week(date_current_datetime())
	
	if (is_numeric(_map[? "char"])) {
		if (_map[? "char"] <= 0 || _map[? "char"] > Race.NUM_ALL_RACE_TYPES) {
			_map[? "char"] = irandom_range(Race.Fish, Race.Rogue)
		}
		
		if (_map[? "bskin"] <= 0 || _map[? "bskin"] > scrRaceGetMaxSkinCount(_map[? "char"])) {
			_map[? "bskin"] = irandom(scrRaceGetMaxSkinCount(_map[? "char"]))
		}
	}
	
	if (is_numeric(_map[? "crown"])) {
		if (_map[? "crown"] < 0 || _map[? "crown"] > crownmax) {
			_map[? "crown"] = irandom_range(crwn_none, crownmax)
		}
	}
	
	if (!scr_weapon_is_valid(_map[? "wep"])) {
		_map[? "wep"] = choose(
			irandom_range(2, 36), irandom_range(47, 55),
			irandom_range(57, 97), irandom_range(104, 125))
	}
}

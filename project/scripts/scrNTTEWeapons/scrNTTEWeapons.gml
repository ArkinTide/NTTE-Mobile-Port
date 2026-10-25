// Source ports from NTTE 2.062. Original weapon IDs 1..128 remain unchanged.
// This registers a native Epsilon weapon; it does not provide the NTT loader.
#macro wep_ntte_rogue_carbine 129
#macro wep_ntte_venom_rifle 130
#macro wep_ntte_beetle_blaster 131
#macro wep_ntte_lightring_launcher 132
#macro wep_ntte_lightring_cannon 133
#macro wep_ntte_last 173

function scrNTTEWeaponsInit() {
	var _id = wep_ntte_rogue_carbine
	wep_name[_id] = "ROGUE CARBINE"
	wep_text[_id] = "THERE'S NO TALKING TO THEM"
	wep_type[_id] = Ammo.Bullets
	wep_cost[_id] = 4
	wep_load[_id] = 5
	wep_auto[_id] = false
	wep_area[_id] = -1
	wep_sprt[_id] = sprNTTERogueCarbine
	wep_swap[_id] = sndSwapMachinegun
	wep_gold[_id] = false
	wep_rads[_id] = 0
	wep_lout[_id] = -1
	wep_mele[_id] = false
	wep_naim[_id] = false

	scrNTTERegisterBulletWeapon(wep_ntte_venom_rifle,
		"VENOM RIFLE", "A PIERCING STING", 2, 3, true, 7,
		sprHeavyARifle, sndSwapMachinegun)
	scrNTTERegisterBulletWeapon(wep_ntte_beetle_blaster,
		"BEETLE BLASTER", "A PIERCING STING", 1, 13, false, -1,
		sprNTTEBeetleBlaster, sndSwapPistol, sprNTTEBeetleBlasterLoadout)
	scrNTTERegisterBulletWeapon(wep_ntte_lightring_launcher,
		"LIGHTRING LAUNCHER", "JELLY TECHNOLOGY", 3, 37, true, 6,
		sprNTTELightringLauncher, sndSwapEnergy)
	scrNTTERegisterBulletWeapon(wep_ntte_lightring_cannon,
		"LIGHTRING CANNON", "EYE OF THE STORM", 8, 90, true, 13,
		sprNTTELightringCannon, sndSwapEnergy)
	scrNTTEAllInit()
    scrNTTEFullWeaponArtInit();
	wep_type[wep_ntte_lightring_launcher] = Ammo.Energy
	wep_type[wep_ntte_lightring_cannon] = Ammo.Energy
}

function scrNTTERegisterBulletWeapon(_id, _name, _text, _cost, _load, _auto,
	_area, _sprite, _swap, _loadout = -1) {
	wep_name[_id] = _name
	wep_text[_id] = _text
	wep_type[_id] = Ammo.Bullets
	wep_cost[_id] = _cost
	wep_load[_id] = _load
	wep_auto[_id] = _auto
	wep_area[_id] = _area
	wep_sprt[_id] = _sprite
	wep_swap[_id] = _swap
	wep_gold[_id] = false
	wep_rads[_id] = 0
	wep_lout[_id] = _loadout
	wep_mele[_id] = false
	wep_naim[_id] = false
}

// Called in the firing Player's context, after scrFire consumes ammo once.
function scrNTTEFireVenom(_weapon) {
    return scrNTTEFullVenomWeaponFire(_weapon);
	var _beetle = (_weapon == wep_ntte_beetle_blaster),
		_dir = gunangle + orandom((_beetle ? 5 : 4) * accuracy),
		_count = _beetle ? 2 : 3,
		_radius = (_beetle ? 6 : 9) * lerp(accuracy, 1, 2 / 3),
		_bounce = _beetle ? 4 * scr_skill_get(mut_shotgun_shoulders) : 0

	for (var _i = 0; _i < _count; ++_i) {
		var _angle = _dir + (_beetle ? (-90 + _i * 180) : _i * 120),
			_offset_angle = _angle + orandom((_beetle ? 10 : 2) * accuracy),
			_distance = _radius,
			_speed = _beetle ? 14 + orandom(1) : 16
		with (scr_projectile_create(
			x + lengthdir_x(_distance, _offset_angle),
			y + lengthdir_y(_distance, _offset_angle),
			NTTEVenomPellet, _dir, _speed)) {
			sprite_index = spr_spwn
			image_index = 0
			image_speed = timescale
			wallbounce = _bounce
			// Beetle's two side pellets must start outside solid walls.
			if (_beetle) {
				while (position_meeting(x, y, Wall) && _distance > 0) {
					_distance -= 1
					x -= lengthdir_x(1, _offset_angle)
					y -= lengthdir_y(1, _offset_angle)
				}
				xstart = x
				ystart = y
			}
		}
		if (_beetle) {
			with (instance_create(x, y, AcidStreak)) {
				motion_set(_dir + angle_difference(_angle, _dir) * 0.2, 5 * timescale)
				depth = 0
			}
		}
	}

	snd_play_gun(sndMachinegun, 0.3)
	if (_beetle) {
		snd_play_gun(sndFireballerFire, 0.3)
		snd_play_gun(sndScorpionHit, 0.3)
		scr_weapon_post(_dir, 5, 8, 2)
	}
	else scr_weapon_post(_dir, 4, 0, 2)
}

// NTTE 2.062 LightningDisc, implemented using Epsilon's lightning and walls.
// Merge hooks and Trench pack unlocks belong to later stages of the port.
function scrNTTELightRingFire(_weapon, _primary) {
	var _cannon = (_weapon == wep_ntte_lightring_cannon)
	// scrFire uses swapped player variables for secondary fire.
	// Both slots spawn from the firing player's current x/y and gunangle.
	with (scr_projectile_create(x, y, NTTELightningDisc, gunangle, _cannon ? 14 : 10)) {
		primary = _primary
		if (_cannon) {
			charge *= 2.5
			charge_spd /= 2
			stretch *= 1.2
			radius *= 4 / 3
			split_size = 1.2
		}
	}
	if (_cannon) snd_play(sndLightningCannon, 1.5, 0.6)
	snd_play(sndLightningCannonUpg, 0.5, 0.4)
}

function scrNTTELightRingZap(_target) {
	if (!instance_exists(_target) || !scr_can_hit(_target)) return false
	// Delay duplicate spawns until the real Lightning instances can collide.
	var _slot = -1
	for (var _i = 0; _i < array_length(zap_targets); ++_i) {
		if (zap_targets[_i] == _target) {
			if (current_frame < zap_times[_i]) return false
			_slot = _i
			break
		}
	}
	if (_slot < 0) {
		_slot = array_length(zap_targets)
		array_push(zap_targets, _target)
		array_push(zap_times, 0)
	}
	zap_times[_slot] = current_frame + 6
	if (charge <= 0) {
		x -= hspeed
		y -= vspeed
		direction = point_direction(x, y, _target.x, _target.y) + orandom(10)
	}
	var _d = random(360),
		_sx = x + lengthdir_x(radius * image_xscale, _d),
		_sy = y + lengthdir_y(radius * image_yscale, _d),
		_length = min(28, ceil(image_xscale + random(image_xscale * 2)))
	scrLightningCreate(_sx, _sy, point_direction(_sx, _sy, _target.x, _target.y) + orandom(12), max(1, _length))
	with (_target) instance_create(x, y, Smoke)
	snd_play(sndLightningHit)
	return true
}

function scrNTTELightRingClearWalls() {
	with (Wall) {
		if (!instance_is(self, InvisiWall) && place_meeting(x, y, other.id)) {
			instance_create(x, y, FloorExplo)
			instance_destroy()
		}
	}
}

function scrNTTELightRingSplit() {
	// Split only on lifetime expiry, never during room cleanup/death cleanup.
	var _start = random(360), _size = image_xscale / 1.2
	for (var _i = 0; _i < 5; ++_i) {
		var _dir = _start + _i * 72
		with (scr_projectile_create(x, y, NTTELightningDisc, _dir, 10)) {
			charge = _size
			creator_follow = false
			image_xscale = charge * 0.9
			image_yscale = image_xscale
		}
		instance_create(x + lengthdir_x(24, _dir), y + lengthdir_y(24, _dir), PortalClear)
	}
	snd_play(sndLightningPistolUpg, 0.7, 0.4)
	snd_play(sndLightningPistol, 0.7, 0.6)
	snd_play(sndGammaGutsKill, 0.5 + random(0.2), 0.7)
	scr_screenshake(8)
}

function scrNTTEDrawLightRing() {
	var _off = 360 / 10,
		_ysc = stretch * (0.5 + random(1))
	for (var _i = 0; _i < 10; ++_i) {
		var _d = image_angle + rotation + _i * _off,
			_ro = random(2),
			_rx = radius * image_xscale + _ro,
			_ry = radius * image_yscale + _ro,
			_x1 = x + lengthdir_x(_rx, _d),
			_y1 = y + lengthdir_y(_ry, _d),
			_x2 = x + lengthdir_x(_rx, _d + _off),
			_y2 = y + lengthdir_y(_ry, _d + _off)
		draw_sprite_ext(sprite_index, image_index, _x1, _y1,
			point_distance(_x1, _y1, _x2, _y2) / 2, _ysc,
			point_direction(_x1, _y1, _x2, _y2), image_blend, image_alpha)
	}
}

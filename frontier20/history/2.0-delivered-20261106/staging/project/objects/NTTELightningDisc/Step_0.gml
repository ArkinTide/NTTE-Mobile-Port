if (lockstep_stop) exit

if (setup) {
	setup = false
	var _skill = scr_skill_get(mut_laser_brain)
	charge *= power(1.2, _skill)
	stretch *= power(1.2, _skill)
	image_speed *= power(0.75, _skill)
	charge_timer = 20 * image_xscale / (charge * charge_spd)
}
rotation += rotspeed * timescale

if (charge > 0 && image_xscale < charge) {
	charge_timer += timescale
	image_xscale = charge * min(1, charge_timer * charge_spd / 20)
	image_yscale = image_xscale
	if (creator_follow && instance_exists(creator)) {
		x = creator.x
		y = creator.y + (primary ? 0 : -4)
		if (variable_instance_exists(creator, "gunangle")) direction = creator.gunangle
		image_angle = direction
		if (instance_is(creator, Player)) {
			if (primary) creator.wkick = 5 * image_xscale / charge
			else creator.bwkick = 5 * image_xscale / charge
		}
	}
	// Cancel this physical frame's engine movement while charging.
	xprevious = x
	yprevious = y
	x -= hspeed
	y -= vspeed
	if (current_frame_active) {
		snd_play(sndLightningHit, max(0.05, image_xscale / charge))
		snd_play(sndPlasmaReload, max(0.05, image_xscale / charge * 3))
	}
}
else {
	if (charge > 0) {
		scrNTTELightRingClearWalls()
		if (instance_exists(creator)) {
			with (creator) {
				if (instance_is(self, Player)) {
					if (other.primary) scr_weapon_post(other.direction, 16 * other.charge, 8 * other.charge, -4)
					else {
						scr_weapon_post(other.direction, 16 * other.charge, 8 * other.charge, wkick)
						bwkick = -4
					}
					other.direction += orandom(6 * accuracy)
				}
			}
		}
		snd_play(sndLightningCannonEnd, (3 + random(1)) / charge)
		with (instance_create(x, y, LightningSpawn)) image_angle = other.direction
		charge = 0
	}
	if (speed > maxspeed * timescale) speed = max(maxspeed * timescale, speed - timescale * timescale)
	if (current_frame_active && random(30) < 1) {
		var _nearest = noone, _distance = infinity
		with (hitme) {
			if (scr_can_hit(id, true, other.id)) {
				var _d = point_distance(x, y, other.x, other.y)
				if (_d < _distance && _d < 32 + other.radius * other.image_xscale) {
					_nearest = id
					_distance = _d
				}
			}
		}
		if (instance_exists(_nearest)) scrNTTELightRingZap(_nearest)
	}
	image_xscale -= shrink * timescale
	image_yscale = image_xscale
	if (split_size >= 0 && image_xscale <= split_size) {
		scrNTTELightRingSplit()
		instance_destroy()
		exit
	}
	if (image_xscale <= 0) {
		snd_play_hit(sndLightningHit, 0.5)
		instance_create(x, y, LightningHit)
		instance_destroy()
		exit
	}
}

if (current_frame_active && random(30) < image_xscale) {
	var _d = random(360), _r = random(radius) * image_xscale
	with (instance_create(x + lengthdir_x(_r, _d), y + lengthdir_y(_r, _d), PortalL)) {
		motion_add(random(360), timescale)
	}
}

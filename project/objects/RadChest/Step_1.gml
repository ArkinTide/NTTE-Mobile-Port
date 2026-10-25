if (hp <= 0) instance_destroy()

if sprite_index != spr_hurt {
	if image_index > 1 {
		image_index += (0.4) * timescale
		sprite_index = spr_idle
	} else
		image_index += (random(0.04)) * timescale
} else image_index += (0.4) * timescale

if sprite_index == spr_hurt {
	if image_index > 2
		sprite_index = spr_idle
}

if (speed > (1) * timescale) speed = (1) * timescale
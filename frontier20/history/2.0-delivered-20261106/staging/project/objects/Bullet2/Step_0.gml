if lockstep_stop
	exit

image_angle = direction

if speed < (6) * timescale && sprite_index != spr_fade {
    sprite_index = spr_fade
    image_index = 0
    image_speed = (0.4) * timescale
}
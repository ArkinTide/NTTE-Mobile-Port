event_inherited()

if sprite_index != spr_hurt and instance_exists(target) motion_add(mcr_target_direction, (0.1) * timescale * timescale)

if sprite_index = spr_hurt alarm[1] = 50

speed = (2) * timescale

if random(4) < (1) * timescale instance_create(xprevious, yprevious, Smoke)
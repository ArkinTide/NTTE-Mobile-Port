event_inherited()

if sprite_index != spr_hurt motion_add(direction, (0.5) * timescale * timescale)

if speed > (1 + rage * 2) * timescale speed = (1 + rage * 2) * timescale
if speed < (0.5) * timescale speed = (0.5) * timescale

if hspeed > 0 right = 1
else if hspeed < 0 right = -1
event_inherited()
if (hspeed > 0) right = 1
else if (hspeed < 0) right = -1
if (walk > 0) {
    walk -= (1) * timescale
    if (sprite_index != spr_hurt) motion_add(direction, (0.55) * timescale * timescale)
    else motion_add(walkdir, (1) * timescale * timescale)
}
if (speed > (4.5) * timescale) speed = (4.5) * timescale
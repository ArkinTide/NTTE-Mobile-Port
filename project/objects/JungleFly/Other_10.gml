event_inherited()

if sprite_index != spr_hurt {
    motion_add(direction, (1) * timescale * timescale)
}

if speed > (2 + (rage * 2)) * timescale {
    speed = (2 + (rage * 2)) * timescale
}

if speed < (1) * timescale {
    speed = (1) * timescale
}

if hspeed > 0 {
    right = 1
} else if hspeed < 0 {
    right = -1
}
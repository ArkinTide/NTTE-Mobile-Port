event_inherited()

if walk > 0 {
    walk -= (1) * timescale
    motion_add(gunangle, (1) * timescale * timescale)
}

if sprite_index = spr_fire {
    if speed > (3) * timescale speed = (3) * timescale
} else if speed > (1) * timescale speed = (1) * timescale
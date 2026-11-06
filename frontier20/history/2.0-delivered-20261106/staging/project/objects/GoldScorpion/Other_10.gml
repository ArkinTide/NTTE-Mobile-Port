event_inherited()

if walk > 0 {
    walk -= (1) * timescale
    motion_add(direction, (2) * timescale * timescale)
}

if speed > (3) * timescale speed = (3) * timescale

if speed < (1) * timescale and ammo < 1 speed = (1) * timescale
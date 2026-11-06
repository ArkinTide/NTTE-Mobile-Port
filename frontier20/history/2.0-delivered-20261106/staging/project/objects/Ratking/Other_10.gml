event_inherited()

if walk > 0 {
    walk -= (1) * timescale
    motion_add(direction, (0.5) * timescale * timescale)
}

if speed > (2) * timescale speed = (2) * timescale
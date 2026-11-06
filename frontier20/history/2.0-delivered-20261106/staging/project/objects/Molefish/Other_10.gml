event_inherited()

if walk > 0 {
    walk -= (1) * timescale
    motion_add(direction, (0.8) * timescale * timescale)
}

if speed > (3.5) * timescale speed = (3.5) * timescale
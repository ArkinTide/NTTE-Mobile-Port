event_inherited()

if walk > 0 {
    motion_add(direction, (1.5) * timescale * timescale)
    walk-= timescale
}

if speed > (4.5) * timescale speed = (4.5) * timescale
event_inherited()

if walk {
    motion_add(direction, (2) * timescale * timescale)
    walk-= timescale
}

if speed > (2.5) * timescale speed = (2.5) * timescale
event_inherited()

if (walk > 0) {
    motion_add(direction, (2) * timescale * timescale)
    walk -= timescale
}

if (speed > (4) * timescale) speed = (4) * timescale
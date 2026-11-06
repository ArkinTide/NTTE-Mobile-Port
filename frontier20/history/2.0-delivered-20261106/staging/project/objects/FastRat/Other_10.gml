event_inherited()

if walk > 0 {
    walk -= (1) * timescale
    motion_add(direction, (0.8) * timescale * timescale)
}

if hspeed > 0 right = 1
else if hspeed < 0 right = -1

if speed > (4.5) * timescale speed = (4.5) * timescale
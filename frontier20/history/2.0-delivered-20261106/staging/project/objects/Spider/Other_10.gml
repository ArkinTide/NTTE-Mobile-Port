event_inherited()

if walk > 0 {
    walk -= (1) * timescale
    motion_add(direction, (2) * timescale * timescale)
}

if hspeed > 0 right = 1
else if hspeed < 0 right = -1
if speed > maxspeed speed = maxspeed
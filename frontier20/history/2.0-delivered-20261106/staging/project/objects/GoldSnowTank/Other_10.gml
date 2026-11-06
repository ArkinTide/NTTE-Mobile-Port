event_inherited()

if sprite_index != spr_hurt && !rest {
    motion_add(direction, (0.6) * timescale * timescale)
}

if hspeed > 0 {
    right = 1
} else if hspeed < 0 {
    right = -1
}

if speed > (1.5) * timescale speed = (1.5) * timescale

if random(4) < (1) * timescale {
    instance_create(x + random(16) - 8, y + random(16) - 10, CaveSparkle)
}
friction = (0.4) * timescale * timescale


repeat(4) {
    with instance_create(x, y, Smoke)
    motion_add(random_angle, (random(2)) * timescale)
}

if sticky = 1 depth = -3
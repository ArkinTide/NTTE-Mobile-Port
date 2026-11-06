event_inherited()

ang = random_angle

repeat(10) {
    with instance_create(x, y, Dust)
    motion_add(other.ang, (3) * timescale)
    ang += 36
}
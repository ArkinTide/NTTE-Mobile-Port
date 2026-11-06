spawned = 0
image_speed = (0.4) * timescale
alarm[0] = 8


dir = random_angle
repeat(6) {
    with instance_create(x, y, Smoke)
    motion_add(other.dir, (4 + random(1)) * timescale)
    dir += 360 / 6
}
dir = random_angle
repeat(3) {
    with instance_create(x, y, AcidStreak) {
        motion_add(other.dir, (8) * timescale)
        image_angle = direction
    }
    dir += 120
}
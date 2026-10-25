// NTTE merged native terminal state capture.
scrNTTEFullMergedNativeDeathCapture(id);
repeat (16) {
    scr_projectile_create(x, y, EnemyBullet3, random_angle, random_range(8, 12))
}

sleep(20)

repeat (6) {
    with instance_create(x, y, Smoke)
    motion_add(random_angle, (random(3)) * timescale)
}

scr_screenshake(8)
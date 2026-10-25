scrTarget()
alarm[1] = 20 + random(10)

maxspeed = (3) * timescale
if instance_exists(target) {
    if collision_line(x, y, target.x, target.y, Wall, 0, 0) < 0 and point_distance(x, y, target.x, target.y) < 96 {
        maxspeed = (5) * timescale
        direction = mcr_target_direction + random(80) - 40
        speed = (0.4) * timescale
        walk = 15 + random(5)
        alarm[1] = walk + 5
    } else if random(2) < 1 {
        motion_add(random_angle, (0.4) * timescale)
        walk = 10 + random(10)
        alarm[1] = walk + 10 + random(10)
    }

} else if random(4) < 1 {
    motion_add(random_angle, (0.4) * timescale)
    walk = 10 + random(10)
    alarm[1] = walk + 10 + random(10)
}
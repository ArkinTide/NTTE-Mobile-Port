event_inherited()
if walk > 0 {
    walk -= (1) * timescale

    if !alarm[2] {
        motion_add(direction, (2) * timescale * timescale)
        if instance_exists(target) {
            mp_potential_step(target.x, target.y, (2) * timescale, 0)
        }
    }
}

if speed > (3) * timescale speed = (3) * timescale
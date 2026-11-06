event_inherited()

if walk > 0 {
    walk -= (1) * timescale
    motion_add(direction, (0.8) * timescale * timescale)
}

if gonnafire = 1 and alarm[2] > 5 and instance_exists(target) {
    gunangle = mcr_target_direction
}

if speed > (1.5) * timescale speed = (1.5) * timescale
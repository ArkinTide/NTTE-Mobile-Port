event_inherited()

if walk > 0 {
    walk -= (1) * timescale
    motion_add(direction, (0.8) * timescale * timescale)
}

if speed > (3.5) * timescale speed = (3.5) * timescale

if instance_exists(target) {
    if target.speed > 0 or hp < max_hp {
		freeze += (1) * timescale
	}
	
    if variable_instance_exists(target,"can_shoot") && !target.can_shoot {
		freeze += (3) * timescale
	}
}
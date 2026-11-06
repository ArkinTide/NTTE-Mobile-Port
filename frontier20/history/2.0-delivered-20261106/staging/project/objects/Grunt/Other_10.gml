event_inherited()

if roll = 0 {
    if walk > 0 {
        walk -= (1) * timescale
        motion_add(direction, (0.8) * timescale * timescale)
    }

    if speed > (3) * timescale speed = (3) * timescale

    if instance_exists(target) {
        if target.speed > 0 || hp < max_hp {
			freeze += (1) * timescale
		}
		
        if !scrNTTEFullValue(target,"can_shoot",false) {
			freeze += (3) * timescale
		}
	}
}
else {
    // Rolling
    speed = (5) * timescale
    angle += (40 * right) * timescale
    instance_create(x + random(6) - 3, y + random(6), Dust)

    if angle > 720 or - angle > 720 {
        angle = 0
        roll = 0
    }
}
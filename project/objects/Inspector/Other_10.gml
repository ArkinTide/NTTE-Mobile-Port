event_inherited()

if walk > 0 {
    walk -= (1) * timescale
    motion_add(direction, (0.8) * timescale * timescale)
}

if speed > (3) * timescale speed = (3) * timescale

if instance_exists(target) {
    if target.speed > 0 or hp < max_hp {
		freeze += (1) * timescale
	}
	
    if !scrNTTEFullValue(target,"can_shoot",false) {
		freeze += (3) * timescale
	}
}

if control = 1 {
    with Player {
        if(team==other.team && scrNTTEFullValue(other.id,"ntte_charmed",false)) continue;
        if point_distance(x, y, other.x, other.y) < 240 {
            if place_free(x + lengthdir_x(1, point_direction(x, y, other.x, other.y)), y) x += (lengthdir_x(1, point_direction(x, y, other.x, other.y))) * timescale
            if place_free(x, y + lengthdir_y(1, point_direction(x, y, other.x, other.y))) y += (lengthdir_y(1, point_direction(x, y, other.x, other.y))) * timescale
        }
    }
}
event_inherited();

if walk > 0 {
    walk -= timescale
	motion_add(direction, (0.8) * timescale * timescale)
}

if speed > (3.5) * timescale speed = (3.5) * timescale

if instance_exists(target) {
    if target.speed > 0 or hp < max_hp {
		freeze += timescale
	}
	
	if scrNTTEFullValue(target,"can_shoot",false) {
		freeze += (3) * timescale
	}
}

if control {
    with projectile {
        if team == other.team or typ == 0
			continue

        var dir = point_direction(other.x, other.y, x, y)

        if place_free(x + lengthdir_x(2, dir), y) x += (lengthdir_x(2, dir)) * timescale
        if place_free(x, y + lengthdir_y(2, dir)) y += (lengthdir_y(2, dir)) * timescale
    }

    with Player {
        if(team==other.team && scrNTTEFullValue(other.id,"ntte_charmed",false)) continue;
        if point_distance(x, y, other.x, other.y) < 160 {
            var dir = point_direction(x, y, other.x, other.y)
            if place_free(x + lengthdir_x(2, dir), y) x += (lengthdir_x(2, dir)) * timescale
            if place_free(x, y + lengthdir_y(2, dir)) y += (lengthdir_y(2, dir)) * timescale
        }
    }

    with Ally {
        if(team==other.team && scrNTTEFullValue(other.id,"ntte_charmed",false)) continue;
        if point_distance(x, y, other.x, other.y) < 160 {
            var dir = point_direction(x, y, other.x, other.y)
            if place_free(x + lengthdir_x(2, dir), y) x += (lengthdir_x(2, dir)) * timescale
            if place_free(x, y + lengthdir_y(2, dir)) y += (lengthdir_y(2, dir)) * timescale
        }
    }
}
if lockstep_stop
	exit

if instance_exists(Player) {
	var p = instance_nearest(x, y, Player)
	
    if point_distance(x, y, p.x, p.y) > 96 {
        if speed > (3) * timescale
			speed = (3) * timescale
		
		mp_potential_step(targetx, targety, (1) * timescale, false)
    }
	else if speed > (2) * timescale {
		speed = (2) * timescale
	}
}
else if speed > (2) * timescale {
	speed = (2) * timescale
}

friction = (0.2) * timescale * timescale

if walk > 0 {
    motion_add(direction, (1) * timescale * timescale)
    walk -= timescale
}

if speed > 0 {
	sprite_index = spr_walk
}
else sprite_index = spr_idle
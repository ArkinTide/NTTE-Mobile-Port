if lockstep_stop
	exit

motion_add(point_direction(other.x, other.y, x, y), (1) * timescale)

if speed > (8) * timescale
	speed = (8) * timescale
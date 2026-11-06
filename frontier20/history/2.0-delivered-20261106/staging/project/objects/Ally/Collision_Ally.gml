if lockstep_stop
	exit

if speed < (4) * timescale
	motion_add(point_direction(other.x + orandom(1), other.y + orandom(1), x, y), (0.5) * timescale)
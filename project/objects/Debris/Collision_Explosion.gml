if lockstep_stop
	exit

motion_add(point_direction(other.x, other.y, x, y), (3) * timescale)

if speed > (9) * timescale {
    speed = (9) * timescale
}
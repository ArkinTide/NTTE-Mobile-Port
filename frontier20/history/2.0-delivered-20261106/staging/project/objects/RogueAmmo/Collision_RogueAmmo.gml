if (speed < (4) * timescale) {
	motion_add(point_direction(other.x + orandom(1), other.y + orandom(1), x, y), (1) * timescale)
	if (speed > (4) * timescale) speed = (4) * timescale
}
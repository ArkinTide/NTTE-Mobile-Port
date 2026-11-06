if lockstep_stop
	exit

if active = 1 {
    instance_create(x, y, Smoke)
    if speed < (12) * timescale speed += (1) * timescale
}
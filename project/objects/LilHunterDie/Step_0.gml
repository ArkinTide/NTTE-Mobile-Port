if lockstep_stop
	exit

instance_create(x, y, Smoke)
image_angle = (direction - 90)
if (bounces <= 3) {
    if (speed < (6) * timescale) speed += (2) * timescale
    speed += (0.05) * timescale
    direction += trn
    trn += (random(1) - 0.5)
} else direction += 59
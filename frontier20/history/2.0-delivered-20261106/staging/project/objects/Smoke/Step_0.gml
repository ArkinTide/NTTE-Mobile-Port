if lockstep_stop
	exit

image_xscale += growspeed
image_yscale += growspeed

growspeed -= (0.001) * timescale
image_angle += (rot) * timescale

if image_xscale < 0 or instance_exists(Spiral)
	instance_destroy()

if current_frame % 3 == 0 && position_meeting(x, y, Wall)
	move_bounce_solid(true)
if lockstep_stop
	exit

move_bounce_solid(true)
if (current_frame_active) speed /= 2

if speed < (0.01) * timescale instance_destroy()
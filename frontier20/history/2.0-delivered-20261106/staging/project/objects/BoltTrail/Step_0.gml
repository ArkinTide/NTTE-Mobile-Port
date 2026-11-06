if lockstep_stop
	exit

image_yscale -= (0.2) * timescale
if image_yscale < 0 instance_destroy()
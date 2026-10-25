if lockstep_stop
	exit

image_yscale -= (0.25) * timescale

if image_yscale < 0 {
	instance_destroy()
}

img += (0.5) * timescale
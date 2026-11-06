image_xscale += growspeed
image_yscale += growspeed

growspeed -= (0.02) * timescale
image_angle += (rot) * timescale

if image_xscale < 0 instance_destroy()
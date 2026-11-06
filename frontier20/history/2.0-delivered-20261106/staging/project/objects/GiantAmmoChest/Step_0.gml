if lockstep_stop
	exit

if image_index < 1
image_index += (random(0.04)) * timescale
else
image_index += (0.4) * timescale

if speed > (4) * timescale
speed = (4) * timescale
/*
if instance_exists(GenCont)
{
x = xstart
y = ystart
}
*/
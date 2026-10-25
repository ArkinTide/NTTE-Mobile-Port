if lockstep_stop
	exit

var _floor = instance_nearest(x - 16, y - 16, Floor)

if instance_exists(_floor) && _floor.sprite_index == sprFloor5B {
    if (friction != (0.05) * timescale * timescale) friction = (0.05) * timescale * timescale
}
else if (friction != (1.5) * timescale * timescale) friction = (1.5) * timescale * timescale

event_inherited()

if (speed > (4) * timescale) speed = (4) * timescale
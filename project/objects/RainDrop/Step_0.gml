if lockstep_stop
	exit

addx -= (12) * timescale
addy -= (12) * timescale

if addx <= 0 {
    instance_destroy()
    if position_meeting(x, y, Floor) instance_create(x, y, RainSplash)
    else instance_create(x, y - 8, RainSplash)
}
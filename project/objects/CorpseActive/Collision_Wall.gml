if lockstep_stop
	exit

if speed > (16) * timescale {
    speed = (16) * timescale
}

if position_empty(x + hspeed, y + vspeed) {
    x -= hspeed
    y -= vspeed
}

move_bounce_solid(false)
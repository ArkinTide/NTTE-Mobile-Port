if lockstep_stop
	exit

if (hp <= 0) {
	instance_destroy()
	exit
}

if (sprite_index != sprSaplingAppear) {
	motion_add(direction, (0.2) * timescale * timescale)
	motion_add(wantdir, (0.6) * timescale * timescale)
	
	if (scrTargetIsVisible(target)) {
		motion_add(mcr_target_direction, (0.8) * timescale * timescale)
	}
}
else if (alarm[0] < 2) alarm[0] = 2

if (speed > (4) * timescale) speed = (4) * timescale
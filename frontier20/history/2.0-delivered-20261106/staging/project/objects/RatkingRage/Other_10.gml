event_inherited()

if walk > 0 {
    walk -= (1) * timescale
    motion_add(mydir, (1.5) * timescale * timescale)
    if walk <= 0 {
		snd_play(sndRatkingChargeEnd)
		//instance_destroy()
	}
}

if speed > (6) * timescale speed = (6) * timescale
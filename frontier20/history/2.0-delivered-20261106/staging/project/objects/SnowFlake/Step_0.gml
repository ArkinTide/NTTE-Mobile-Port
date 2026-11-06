if lockstep_stop
	exit

if addy > 0 {
    addx -= sin(wave / 5)
    addy -= 1 - sin(wave / 3) / 2
    wave += (0.2) * timescale
} else {
    image_alpha -= (0.05) * timescale
    if image_alpha < 0 instance_destroy()
}
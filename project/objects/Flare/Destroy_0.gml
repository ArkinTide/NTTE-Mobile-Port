// NTTE merged native terminal state capture.
scrNTTEFullMergedNativeDeathCapture(id);
sleep(100)

repeat (20) {
	with scr_projectile_create(x, y, Flame) {
		motion_add(random_angle, (random(1) + 4) * timescale)
	}
}

snd_play(sndFlareExplode)
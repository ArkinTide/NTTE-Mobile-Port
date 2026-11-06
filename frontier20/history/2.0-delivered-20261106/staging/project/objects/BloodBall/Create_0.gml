event_inherited()

typ = 1

damage = 45
knockback_speed = 6 * timescale

friction = (0.02) * timescale * timescale

image_speed = (0.4) * timescale
spin = ((10 + random(10)) * choose(1, -1))

snd = sndBloodCannonLoop
snd_play(snd)

alarm[0] = 300
alarm[1] = 1

// NTTE Coast constructor wading variables
scrNTTEFullCoastConstructWading();

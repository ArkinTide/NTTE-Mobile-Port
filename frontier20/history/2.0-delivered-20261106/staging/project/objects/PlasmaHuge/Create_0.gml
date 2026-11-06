event_inherited()
typ = 1 //0 = normal, 1 = deflectable, 2 = destructable, 3 = deflectable

damage = 25

if scr_skill_get(17) {
	image_xscale += 0.2
	image_yscale += 0.2
}

image_speed = (0.5) * timescale
sleep(100)

// NTTE Coast constructor wading variables
scrNTTEFullCoastConstructWading();

event_inherited()
spr_fade = sprBullet2Disappear
friction = (0.6) * timescale * timescale
wallbounce = 0

damage = 2

if scr_skill_get(mut_shotgun_shoulders) wallbounce = 1 * timescale

typ = 1
bonus = true
alarm[2] = 2

// NTTE Coast constructor wading variables
scrNTTEFullCoastConstructWading();

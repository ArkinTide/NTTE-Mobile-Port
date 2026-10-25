event_inherited()
alarm[0] = 1
alarm[2] = 2
knockback_speed = 14 * timescale
wallbounce = 0
typ = 1
bonus = true
if (scr_skill_get(mut_shotgun_shoulders)) wallbounce = 5 * timescale
speed = (12) * timescale
friction = (0.8) * timescale * timescale

damage = 26
knockback_speed = 9 * timescale

spr_fade = sprHeavySlugHit
// NTTE Coast constructor wading variables
scrNTTEFullCoastConstructWading();

event_inherited()
friction = (0.6) * timescale * timescale
wallbounce = 0
knockback_speed = 2 * timescale
damage = 2

if instance_exists(Player) {
    if (scr_skill_get(mut_shotgun_shoulders)) wallbounce = 5 * timescale
}

typ = 1
bonus = true
alarm[2] = 2

spr_fade = sprBullet2Disappear
// NTTE Coast constructor wading variables
scrNTTEFullCoastConstructWading();

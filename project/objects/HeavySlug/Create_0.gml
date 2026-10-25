event_inherited()
friction = (1) * timescale * timescale
wallbounce = 2 * timescale
knockback_speed = 14 * timescale
spr_fade = sprHeavySlugHit
damage = 60
if instance_exists(Player) {
    if scr_skill_get(mut_shotgun_shoulders) wallbounce = 6 * timescale
}
typ = 1
bonus = 10
alarm[2] = 2
// NTTE Coast constructor wading variables
scrNTTEFullCoastConstructWading();

event_inherited()
image_speed = (0.2 + random(0.1)) * timescale
projectile_direction_changes_angle = false
image_angle = random_angle
hitid = HitId.None
team = team_enemy
damage = 1
typ = 2

if (GameCont.area == area_oasis) {
	instance_create(x, y, Bubble)
	instance_destroy()
}
// NTTE Coast constructor wading variables
scrNTTEFullCoastConstructWading();

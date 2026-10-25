var area;

if !instance_exists(Menu) && instance_exists(GameCont) {
	area = GameCont.area
}
else area = 0

friction = (0.2) * timescale * timescale
sprite_index = scrNTTEFullAreaWallSprite(area,"Debris")
image_speed = 0
image_index = random(4)
image_angle = random_angle
depth = -1
size = 1
motion_add(random_angle, (6 + random(2)) * timescale)
alarm[0] = 200 + random(90)
time = 10
team = team_none

if speed > 0 alarm[1] = random(10) / speed * timescale + 1
// NTTE Coast constructor wading variables
scrNTTEFullCoastConstructWading();

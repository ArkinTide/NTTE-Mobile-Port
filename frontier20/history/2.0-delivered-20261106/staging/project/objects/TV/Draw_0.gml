if lockstep_stop
	exit

draw_sprite(sprite_index, -1, x, y)

anim += (0.4) * timescale

draw_sprite(myscreen, anim, x - 5, y - 5)

if instance_exists(Menu) && Menu.race == Race.Chicken {
	draw_sprite(sprTVPause, anim, x - 5, y - 5)
}
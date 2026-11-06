if lockstep_stop
	exit

motion_add(point_direction(other.x, other.y, x, y), (0.5) * timescale)

if (busycollisions) {
	var _wall = instance_place(x + hspeed, y + vspeed, Wall)
	
	if (instance_exists(_wall)) {
		var _contact=scrNTTESolidWallContact(_wall,x+hspeed,y+vspeed,false);
		motion_add(point_direction(_contact[0], _contact[1], x, y), (0.5) * timescale)
		if (!place_meeting(x + hspeed, y + vspeed, Wall)) {
			x += hspeed
			y += vspeed
		}
	}
	
	if (speed > (16) * timescale) speed = (16) * timescale
}

if (size > other.size && meleedamage > 0 && scr_can_hit(other.id)) {
	scr_hit(other.id, meleedamage, hitid)
}

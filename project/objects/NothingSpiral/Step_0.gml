if lockstep_stop
	exit

if ((current_frame % 30) < timescale) {
	var _cx = view_xview + view_width / 2,
		_cy = view_yview + view_height / 2
	
	with (projectile) {
	    if (point_distance(x, y, _cx, _cy) > 1000) instance_destroy()
	}
}

with (Wall) {
	var _wall=instance_create(x, y, InvisiWall);
    if(object_index==NTTESolidWall) {
        _wall.image_xscale=image_xscale;_wall.image_yscale=image_yscale;
    }
    instance_destroy(id, false)
}

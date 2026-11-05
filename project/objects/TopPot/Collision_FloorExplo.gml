if lockstep_stop
	exit

scrNTTESolidWallMaterializeShape(id);
with Wall {
    if (place_meeting(x, y, other)) scrWallDestroy(id)
}

instance_destroy()

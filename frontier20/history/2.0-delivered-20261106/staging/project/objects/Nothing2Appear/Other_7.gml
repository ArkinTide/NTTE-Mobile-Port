instance_create(x, y, Nothing2)

instance_destroy(TopSmall)
instance_destroy(Bones)

with (Wall) {
	var _wall=instance_create(x, y, InvisiWall)
    if(object_index==NTTESolidWall) {
        _wall.image_xscale=image_xscale;_wall.image_yscale=image_yscale;
    }
    instance_destroy(id, false)
}

instance_destroy()

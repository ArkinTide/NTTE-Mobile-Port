if lockstep_stop
	exit

var _wall=scrNTTESolidWallCellAt(other.id,x,y);
with (_wall) {
    instance_destroy()
    instance_create(x, y, FloorExplo)
}

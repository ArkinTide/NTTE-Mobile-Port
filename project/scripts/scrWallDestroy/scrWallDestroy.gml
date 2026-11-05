/// @function scrWallDestroy
/// @param wall_instance
function scrWallDestroy(_instance) {
	if (!instance_exists(_instance)) exit
    if(scrNTTESolidWallDestroy(_instance)) exit;
	// A newly authored 16px wall can overlap older packed fill. Normalize only
	// this footprint before the native duplicate-wall deletion loop runs.
	scrNTTESolidWallMaterialize(_instance.bbox_left,_instance.bbox_top,_instance.bbox_right-1,_instance.bbox_bottom-1);
	
	with (_instance) {
		do {
			instance_destroy(_instance)
			instance_create(x, y, FloorExplo)
			
			_instance = collision_rectangle(
				bbox_left, bbox_top, bbox_right, bbox_bottom, Wall, false, true)
		}
		until (!instance_exists(_instance))
	}
}

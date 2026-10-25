// Original NTT scoped merged Lightning constructor
if(variable_global_exists("ntte_full_merged_lightning_construct") && global.ntte_full_merged_lightning_construct) {
    event_perform_object(projectile,ev_create,0)
    scrNTTEFullMergedLightningConstruct()
    exit;
}
event_inherited()

typ = 0
image_speed = (0.4) * timescale

damage = 7

if object_index != EnemyLightning && scr_skill_get(mut_laser_brain) {
	image_speed = (0.3) * timescale
}

if GameCont.underwater {
	var _left = view_xview,
		_right = view_xview + view_width,
		_top = view_yview,
		_bottom = view_yview + view_height
		
	with hitme {
	    if point_in_rectangle(x, y, _left, _top, _right, _bottom) {
			scr_hit(id, 2, HitId.UnderwaterLightning)
			scr_screenshake(1)
	    }
	}
	
	exit
}
// NTTE Coast constructor wading variables
scrNTTEFullCoastConstructWading();

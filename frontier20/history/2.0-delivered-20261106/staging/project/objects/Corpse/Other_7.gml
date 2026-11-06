image_index = image_number - 1
image_speed = 0

if (forceportal || scr_check_enemies()) exit

// A later corpse animation must not restart an existing clear delay.
// Some authored corpse sprites finish repeatedly; resetting all alarms here
// can keep an empty room permanently one second away from opening its exit.
var _pending = false
with (Corpse) if (alarm[0] >= 0) { _pending = true; break }
if (!_pending) alarm[0] = 30
	
if !place_meeting(x, y, Floor) {
	with instance_nearest(x, y, Floor) {
		other.x = bbox_center_x
		other.y = bbox_center_y
	}
	xprevious = x
	yprevious = y
}
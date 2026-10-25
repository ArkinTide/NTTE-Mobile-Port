event_inherited()
// force disappear
alarm[0] = 300
knockback_speed = 8 * timescale
wallbreak = 4
if (place_meeting(x, y, Wall)) wallbreak --
can_decrement_this_frame = true
damage = 45
// NTTE Coast constructor wading variables
scrNTTEFullCoastConstructWading();

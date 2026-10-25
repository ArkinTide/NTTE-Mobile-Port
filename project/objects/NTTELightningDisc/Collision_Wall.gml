// NTTE merged native collision entry, preserving inherited dispatch.
var _ntte_merge_collision=scrNTTEFullMergedNativeCollisionBegin(id,other.id);
if(!is_undefined(_ntte_merge_collision) && !_ntte_merge_collision.allow) { scrNTTEFullMergedNativeCollisionEnd(_ntte_merge_collision); exit; }
try {
if (lockstep_stop) exit

if (image_xscale > 1.2 || image_yscale > 1.2) {
	scrNTTELightRingClearWalls()
}
else if (charge <= 0 && instance_exists(other.id)) {
	var _vx = hspeed, _vy = vspeed,
		_flipx = place_meeting(x + _vx, y, Wall),
		_flipy = place_meeting(x, y + _vy, Wall)
	if (_flipx) hspeed = -_vx
	if (_flipy) vspeed = -_vy
	if (!_flipx && !_flipy) {
		if (abs(x - (other.bbox_left + other.bbox_right + 1) / 2)
			> abs(y - (other.bbox_top + other.bbox_bottom + 1) / 2)) hspeed = -_vx
		else vspeed = -_vy
	}
	image_angle = direction
	instance_create(x, y, PortalL)
	snd_play_hit(sndLightningHit, 0.2)
}
}
finally {
    scrNTTEFullMergedNativeCollisionEnd(_ntte_merge_collision);
}

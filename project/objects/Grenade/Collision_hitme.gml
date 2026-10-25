// NTTE merged native collision entry, preserving inherited dispatch.
var _ntte_merge_collision=scrNTTEFullMergedNativeCollisionBegin(id,other.id);
if(!is_undefined(_ntte_merge_collision) && !_ntte_merge_collision.allow) { scrNTTEFullMergedNativeCollisionEnd(_ntte_merge_collision); exit; }
try {
if sticky {
	if scr_can_hit(other.id, false) {
		if speed > 0 {
			snd_play_hit(sndGrenadeStickWall)
			stick_target = other.id
			speed = 0
		}
		else if !instance_exists(stick_target) {
			stick_target = other.id
		}
		
		if other.id == stick_target {
			x = other.x + offx
			y = other.y + offy
		}
	}
	
	exit
}

scr_projectile_generic_grenade_hit(grenade_pierce_on_overkill)
}
finally {
    scrNTTEFullMergedNativeCollisionEnd(_ntte_merge_collision);
}

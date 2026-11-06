if(scrNTTEFullFriendlyMonsterShot(id,other.id)) exit;
// NTTE merged native collision entry, preserving inherited dispatch.
var _ntte_merge_collision=scrNTTEFullMergedNativeCollisionBegin(id,other.id);
if(!is_undefined(_ntte_merge_collision) && !_ntte_merge_collision.allow) { scrNTTEFullMergedNativeCollisionEnd(_ntte_merge_collision); exit; }
try {
if(instance_is(other.id,NTTEFullBubbleBomb)) exit;
if(instance_is(other.id,NTTEFullNetNade)) exit;
with other {
	if (!instance_is(self, Grenade) && team == other.team) || typ == 0 break
	
	if other.shank || typ == 2 {
		instance_destroy()
		break
    }
	
	if instance_is(self, Grenade) {
		motion_add(other.direction, (12) * timescale)
		
		friction = (0.1) * timescale * timescale
		alarm[1] = 6
		speed = (12) * timescale
		
		scr_screenshake(3)
		scrBulletHitFX(sprDeflect)
	}
	else if typ == 1 {
		team = other.team
		direction = other.direction
		image_angle = other.image_angle
		scrBulletHitFX(sprDeflect)
	}
}
}
finally {
    scrNTTEFullMergedNativeCollisionEnd(_ntte_merge_collision);
}

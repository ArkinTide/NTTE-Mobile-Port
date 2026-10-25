// NTTE merged native collision entry, preserving inherited dispatch.
var _ntte_merge_collision=scrNTTEFullMergedNativeCollisionBegin(id,other.id);
if(!is_undefined(_ntte_merge_collision) && !_ntte_merge_collision.allow) { scrNTTEFullMergedNativeCollisionEnd(_ntte_merge_collision); exit; }
try {
if lockstep_stop
	exit

if speed == 0 exit

snd_play_hit_big(sndBoltHitWall, 0.2)
move_contact_solid(direction, 16)
instance_create(x, y, Dust)
speed = 0

alarm[0] = 30
alarm[1] = 1
}
finally {
    scrNTTEFullMergedNativeCollisionEnd(_ntte_merge_collision);
}

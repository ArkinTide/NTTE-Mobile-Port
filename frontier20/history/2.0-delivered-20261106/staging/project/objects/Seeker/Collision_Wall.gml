// NTTE merged native collision entry, preserving inherited dispatch.
var _ntte_merge_collision=scrNTTEFullMergedNativeCollisionBegin(id,other.id);
if(!is_undefined(_ntte_merge_collision) && !_ntte_merge_collision.allow) { scrNTTEFullMergedNativeCollisionEnd(_ntte_merge_collision); exit; }
try {
if lockstep_stop
	exit

if speed > 0 && !place_meeting(x, y, hitme) {
    snd_play(sndBoltHitWall)

    speed = 0

    x = xprevious
    y = yprevious

    move_contact_solid(direction, 16)
    instance_create(x, y, Dust)
    alarm[0] = 30
}
}
finally {
    scrNTTEFullMergedNativeCollisionEnd(_ntte_merge_collision);
}

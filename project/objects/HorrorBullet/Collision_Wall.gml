// NTTE merged native collision entry, preserving inherited dispatch.
var _ntte_merge_collision=scrNTTEFullMergedNativeCollisionBegin(id,other.id);
if(!is_undefined(_ntte_merge_collision) && !_ntte_merge_collision.allow) { scrNTTEFullMergedNativeCollisionEnd(_ntte_merge_collision); exit; }
try {
if lockstep_stop
	exit

instance_destroy()
instance_create(x, y, Dust)

snd_play_hit(sndHitWall, 0.2)

if team != team_player && can_drop_rads {
    with instance_create(x, y, Rad) {
        motion_add(other.direction, other.speed)
        motion_add(random_angle, (8) * timescale)
        repeat(speed) speed *= 0.9
    }
}
}
finally {
    scrNTTEFullMergedNativeCollisionEnd(_ntte_merge_collision);
}

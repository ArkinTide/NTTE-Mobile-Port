// NTTE merged native collision entry, preserving inherited dispatch.
var _ntte_merge_collision=scrNTTEFullMergedNativeCollisionBegin(id,other.id);
if(!is_undefined(_ntte_merge_collision) && !_ntte_merge_collision.allow) { scrNTTEFullMergedNativeCollisionEnd(_ntte_merge_collision); exit; }
try {
if lockstep_stop
	exit

if team != other.team {

    if other.typ = 1 {
        other.team = team
        other.direction = point_direction(other.x, other.y, other.xstart, other.ystart)
        other.image_angle = other.direction
        other.speed /= 2
    }
    if other.typ = 2 {
        with other
        instance_destroy()
    }

}
}
finally {
    scrNTTEFullMergedNativeCollisionEnd(_ntte_merge_collision);
}

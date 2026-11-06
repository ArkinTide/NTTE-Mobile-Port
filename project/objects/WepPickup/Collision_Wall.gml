// NTTE merged native collision entry, preserving inherited dispatch.
var _ntte_merge_collision=scrNTTEFullMergedNativeCollisionBegin(id,other.id);
if(!is_undefined(_ntte_merge_collision) && !_ntte_merge_collision.allow) { scrNTTEFullMergedNativeCollisionEnd(_ntte_merge_collision); exit; }
try {
if lockstep_stop
	exit

// A compact wall must eject the pickup from its contacted native cell,
// rather than transporting it along the rectangle to a remote edge.
var _fr_pickup_wall_origin=scrNTTESolidWallContact(other.id,x,y,false);
move_bounce_solid(true)
move_outside_solid(point_direction(_fr_pickup_wall_origin[0]+8, _fr_pickup_wall_origin[1]+8, x, y), 2)
if (speed > (4) * timescale && mask_index != mskWepPickup) snd_play_hit(sndHitWall)
if (friction == 0) friction = (0.5) * timescale * timescale
speed *= 0.4
}
finally {
    scrNTTEFullMergedNativeCollisionEnd(_ntte_merge_collision);
}

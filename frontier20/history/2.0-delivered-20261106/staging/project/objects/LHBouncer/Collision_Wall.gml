// NTTE merged native collision entry, preserving inherited dispatch.
var _ntte_merge_collision=scrNTTEFullMergedNativeCollisionBegin(id,other.id);
if(!is_undefined(_ntte_merge_collision) && !_ntte_merge_collision.allow) { scrNTTEFullMergedNativeCollisionEnd(_ntte_merge_collision); exit; }
try {
if lockstep_stop
	exit

if bounce {
    instance_create(x, y, Dust)
    snd_play_hit(sndBouncerBounce)
    move_bounce_solid(true)
    bounce = false
	exit
}

instance_create(x, y, Dust)
snd_play_hit(sndHitWall, 0.2)
instance_destroy()
}
finally {
    scrNTTEFullMergedNativeCollisionEnd(_ntte_merge_collision);
}

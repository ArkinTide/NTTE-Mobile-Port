// NTTE merged native collision entry, preserving inherited dispatch.
var _ntte_merge_collision=scrNTTEFullMergedNativeCollisionBegin(id,other.id);
if(!is_undefined(_ntte_merge_collision) && !_ntte_merge_collision.allow) { scrNTTEFullMergedNativeCollisionEnd(_ntte_merge_collision); exit; }
try {
if lockstep_stop
	exit

if(instance_is(id,NTTEFullSealDisc)) scrNTTEFullSealDeadeyeObserve("wall_contact",creator,other.id)
move_bounce_solid(true)

if dist > 50 {
	snd_play(sndDiscDie)
if(instance_is(id,NTTEFullSealDisc)) scrNTTEFullSealDeadeyeObserve("wall_die",creator,other.id)
    instance_create(x, y, DiscDisappear)
    instance_destroy()
	exit
}

snd_play(sndDiscBounce)
if(instance_is(id,NTTEFullSealDisc)) scrNTTEFullSealDeadeyeObserve("wall_bounce",creator,other.id)

with instance_create(x, y, DiscBounce) {
	image_angle = other.image_angle
	depth = other.depth - 1
}
}
finally {
    scrNTTEFullMergedNativeCollisionEnd(_ntte_merge_collision);
}

// NTTE merged deferred emission dispatch around real native event.
var _ntte_runtime_event=scrNTTEFullMergedRuntimeEventBegin();
try {
// NTTE real-creator firing mount around deferred native event.
var _ntte_runtime_mount=scrNTTEFullMergedRuntimeMountedEventBegin();
try {
var _ntte_actor_anchor=scrNTTEFullMergedRuntimeFiringAnchor(id);
if (instance_exists(creator) && scrNTTEFullActorFiringAnchorExists(_ntte_actor_anchor)) {
    x = _ntte_actor_anchor.x + lengthdir_x(16, scrNTTEFullMergedRuntimeFiringAngle(id))
    y = _ntte_actor_anchor.y + lengthdir_y(16, scrNTTEFullMergedRuntimeFiringAngle(id))
    image_xscale += (0.02) * timescale
    image_yscale += (0.02) * timescale
}
}
finally {
    scrNTTEFullMergedRuntimeMountEnd(_ntte_runtime_mount);
}
}
finally {
    scrNTTEFullMergedRuntimeEventEnd(_ntte_runtime_event);
}

// NTTE merged deferred emission dispatch around real native event.
var _ntte_runtime_event=scrNTTEFullMergedRuntimeEventBegin();
try {
// NTTE real-creator firing mount around deferred native event.
var _ntte_runtime_mount=scrNTTEFullMergedRuntimeMountedEventBegin();
try {
var _ntte_actor_anchor=scrNTTEFullMergedRuntimeFiringAnchor(id);
/// @description Shot delay logic

if (!instance_exists(creator) || !scrNTTEFullActorFiringAnchorExists(_ntte_actor_anchor)) {
	instance_destroy()
	exit
}

alarm[0] = time

x = _ntte_actor_anchor.x
y = _ntte_actor_anchor.y

direction = scrNTTEFullMergedRuntimeFiringAngle(id)

if (-- ammo) >= 0 {
	event_user(1)
}
else instance_destroy()
}
finally {
    scrNTTEFullMergedRuntimeMountEnd(_ntte_runtime_mount);
}
}
finally {
    scrNTTEFullMergedRuntimeEventEnd(_ntte_runtime_event);
}

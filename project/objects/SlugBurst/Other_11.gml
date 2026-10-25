// NTTE merged deferred emission dispatch around real native event.
var _ntte_runtime_event=scrNTTEFullMergedRuntimeEventBegin();
try {
// NTTE real-creator firing mount around deferred native event.
var _ntte_runtime_mount=scrNTTEFullMergedRuntimeMountedEventBegin();
try {
/// @description Fire shots
snd_play(sndSlugger)

with scr_projectile_create(x, y, Slug, direction, 18) {
	scr_projectile_spread(4)
}

scr_weapon_post(direction, 8, 6, 8)
}
finally {
    scrNTTEFullMergedRuntimeMountEnd(_ntte_runtime_mount);
}
}
finally {
    scrNTTEFullMergedRuntimeEventEnd(_ntte_runtime_event);
}

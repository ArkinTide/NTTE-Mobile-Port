// NTTE merged deferred emission dispatch around real native event.
var _ntte_runtime_event=scrNTTEFullMergedRuntimeEventBegin();
try {
// NTTE real-creator firing mount around deferred native event.
var _ntte_runtime_mount=scrNTTEFullMergedRuntimeMountedEventBegin();
try {
/// @param Fire shots
snd_play_gun(sndGrenadeRifle)

with scr_projectile_create(x, y, SmallGrenade, direction, 13 + random(2)) {
	scr_projectile_spread(4)
}

scr_weapon_post(direction, 5, 1, 5)
}
finally {
    scrNTTEFullMergedRuntimeMountEnd(_ntte_runtime_mount);
}
}
finally {
    scrNTTEFullMergedRuntimeEventEnd(_ntte_runtime_event);
}

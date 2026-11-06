// NTTE merged deferred emission dispatch around real native event.
var _ntte_runtime_event=scrNTTEFullMergedRuntimeEventBegin();
try {
// NTTE real-creator firing mount around deferred native event.
var _ntte_runtime_mount=scrNTTEFullMergedRuntimeMountedEventBegin();
try {
/// @description Fire shots
snd_play_gun(sndPopgun)
scrBulletShotShellFX(Shell)

with scr_projectile_create(x, y, Bullet2, direction, 16) {
	scr_projectile_spread(8)
}

scr_weapon_post(direction, 4, 2, 2)
}
finally {
    scrNTTEFullMergedRuntimeMountEnd(_ntte_runtime_mount);
}
}
finally {
    scrNTTEFullMergedRuntimeEventEnd(_ntte_runtime_event);
}

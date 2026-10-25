// NTTE merged deferred emission dispatch around real native event.
var _ntte_runtime_event=scrNTTEFullMergedRuntimeEventBegin();
try {
// NTTE real-creator firing mount around deferred native event.
var _ntte_runtime_mount=scrNTTEFullMergedRuntimeMountedEventBegin();
try {
/// @description Fire shots
snd_play_gun(sndHeavyMachinegun)

scrBulletShotShellFX(HeavyShell)

with scr_projectile_create(x, y, HeavyBullet, direction, 16) {
	scr_projectile_spread(1)
}

scr_weapon_post(direction, 7, 3, 6)
}
finally {
    scrNTTEFullMergedRuntimeMountEnd(_ntte_runtime_mount);
}
}
finally {
    scrNTTEFullMergedRuntimeEventEnd(_ntte_runtime_event);
}

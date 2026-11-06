// NTTE merged deferred emission dispatch around real native event.
var _ntte_runtime_event=scrNTTEFullMergedRuntimeEventBegin();
try {
// NTTE real-creator firing mount around deferred native event.
var _ntte_runtime_mount=scrNTTEFullMergedRuntimeMountedEventBegin();
try {
/// @function Fire shots
snd_play(sndRogueRifle)

scrBulletShotShellFX(Shell)

with scr_projectile_create(x, y, Bullet1, direction, 16) {
	sprite_index = sprRogueBullet
	spr_fade = sprIDPDBulletHit
	scr_projectile_spread(2)
}

scr_weapon_post(direction, 6, 3, 4)
}
finally {
    scrNTTEFullMergedRuntimeMountEnd(_ntte_runtime_mount);
}
}
finally {
    scrNTTEFullMergedRuntimeEventEnd(_ntte_runtime_event);
}

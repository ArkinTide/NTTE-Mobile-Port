// NTTE merged deferred emission dispatch around real native event.
var _ntte_runtime_event=scrNTTEFullMergedRuntimeEventBegin();
try {
// NTTE real-creator firing mount around deferred native event.
var _ntte_runtime_mount=scrNTTEFullMergedRuntimeMountedEventBegin();
try {
var _ntte_actor_anchor=scrNTTEFullMergedRuntimeFiringAnchor(id);
ammo -= 1

alarm[0] = time
image_xscale /= 2
image_yscale /= 2

if (instance_exists(creator) && scrNTTEFullActorFiringAnchorExists(_ntte_actor_anchor)) {
    x = _ntte_actor_anchor.x + lengthdir_x(16, scrNTTEFullMergedRuntimeFiringAngle(id))
    y = _ntte_actor_anchor.y + lengthdir_y(16, scrNTTEFullMergedRuntimeFiringAngle(id))
	
	snd_play(scr_skill_get(mut_laser_brain) ? sndLaserCannonUpg : sndLaserCannon)
	
    with scr_projectile_create(x, y, Laser, scrNTTEFullMergedRuntimeFiringAngle(id)) {
        event_perform(ev_alarm, 0)
    }
	
	var _actor_angle=scrNTTEFullMergedRuntimeFiringAngle(id);
	with (creator) scr_weapon_post(_actor_angle, 3, 2, 5)
}

if (ammo <= 0) instance_destroy()
}
finally {
    scrNTTEFullMergedRuntimeMountEnd(_ntte_runtime_mount);
}
}
finally {
    scrNTTEFullMergedRuntimeEventEnd(_ntte_runtime_event);
}

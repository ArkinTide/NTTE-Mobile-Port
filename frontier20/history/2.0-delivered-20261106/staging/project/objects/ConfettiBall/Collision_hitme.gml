// NTTE merged native collision entry, preserving inherited dispatch.
var _ntte_merge_collision=scrNTTEFullMergedNativeCollisionBegin(id,other.id);
if(!is_undefined(_ntte_merge_collision) && !_ntte_merge_collision.allow) { scrNTTEFullMergedNativeCollisionEnd(_ntte_merge_collision); exit; }
try {
if scr_projectile_generic_grenade_hit(false) {
	if (instance_exists(other) && other.hp > 0) exit
	
	repeat 30 {
        with instance_create(x, y, Confetti) {
            motion_add(random_angle, (random(14)) * timescale)
            team = other.team
        }
    }
	
	var _snd = asset_get_index("sndConfetti" + string(irandom(6) + 1))
    if (!audio_exists(_snd)) _snd = sndConfetti1
    snd_play_hit_big(_snd, 0.2)
}
}
finally {
    scrNTTEFullMergedNativeCollisionEnd(_ntte_merge_collision);
}

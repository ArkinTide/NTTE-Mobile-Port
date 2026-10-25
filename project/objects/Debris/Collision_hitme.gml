if lockstep_stop
	exit

if size >= other.size - 1 && speed > (2) * timescale && scr_can_hit(other.id) {
    with other {
		if (scr_hit_self(floor(1 + other.speed * 0.1))) {
			motion_add(other.direction, other.speed / 2)
		}
    }
	
    // 同 Corpse：改为按 30Hz 逻辑帧结算
    if (current_frame_active) speed /= 2
}
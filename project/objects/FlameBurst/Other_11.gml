// NTTE merged deferred emission dispatch around real native event.
var _ntte_runtime_event=scrNTTEFullMergedRuntimeEventBegin();
try {
// NTTE real-creator firing mount around deferred native event.
var _ntte_runtime_mount=scrNTTEFullMergedRuntimeMountedEventBegin();
try {
/// @description Fire shots

repeat (2) {
	with scr_projectile_create(x, y, Flame, direction, random_range(6, 8)) {
		// 火焰生成在「枪口」（沿 direction 最多 14px），而不是角色自身。
		move_contact_solid(direction, 14)
		// 60/120 帧：补足「一个逻辑帧」的位移（30 帧下恒为 0 → 逐字节不变）
		// 火焰生成在玩家中心，贴墙时出生即与墙重叠；30 帧一帧走 6~8px 能脱离，
		// 60 帧只走 3~4px 脱离不了 → 被 move_bounce_solid 钉死在接触点（d1=0）。
		// 补足后，第一帧的总位移 == 30 帧的一帧位移。
		if (timescale < 1) {
			x += lengthdir_x(speed / timescale - speed, direction)
			y += lengthdir_y(speed / timescale - speed, direction)
		}
		image_angle = 0
	}
}

scr_weapon_post(direction, 3, 1, 2)
}
finally {
    scrNTTEFullMergedRuntimeMountEnd(_ntte_runtime_mount);
}
}
finally {
    scrNTTEFullMergedRuntimeEventEnd(_ntte_runtime_event);
}

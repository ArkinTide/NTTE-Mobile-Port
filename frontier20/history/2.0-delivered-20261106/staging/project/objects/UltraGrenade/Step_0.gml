if lockstep_stop
	exit

// 乘性反馈按 timescale 折算（S-2）：30 帧恒 0.1（逐字节不变），
// 60 帧 = 1 - 0.9^0.5 ≈ 0.0513/物理帧 → 每秒衰减量两侧同为 0.9^30（BackCont 同款写法）。
var _flash_k = 0.1
if (timescale != 1) _flash_k = 1 - power(0.9, timescale)
attract_flash = t_lerp(attract_flash, 0, _flash_k)

if !attract {
	
	if speed > (4) * timescale {
		alarm[0] = max(alarm[0], 60)
		alarm[2] = max(alarm[1], 6)
	}
	
	exit
}

// // 整块按 30Hz 逻辑帧结算（`current_frame_active`：30 帧恒真 → 逐字节不变；60 帧每 2 物理帧一次）。
// v2 的遗留：强度按 ×ts² 折算了，但「触发次数」仍是 60 帧 40 次/s vs 30 帧 20 次/s；
// 更关键的是下面两处**原本就没门控**（v2 未覆盖）：
//   ① `with hitme` 冲量（每物理帧一次）→ 60 帧敌人被吸快 2×；
//   ② `Dust` 生成（每物理帧一次）→ 60 帧粒子数 2×（F64 日志「行/帧」7~10 → 13~15 佐证）。
// v3 = 整块门控 + 增量回 ×ts（每个逻辑帧一次，与 30 帧逐帧同构）：
//   吸引 20 次/s（floor()%3 跳 1/3）· Dust 30 个/s · hitme 30 次/s —— 两侧完全一致。
// ⚠️ 本事件在吸引块之后已无其它逻辑，故用 `exit` 门控（等价于整块 if 包裹、且零缩进风险）。
if !current_frame_active
	exit

if alarm[0] > flash_at {
	with hitme {
	    if distance_to_object(other) <= 32
			motion_add(point_direction(x, y, other.x, other.y), (2) * timescale)
	}
	
	var ang = random_angle,
		len = 56 + random(8),
		xx = x + ldrx(len, ang),
		yy = y + ldry(len, ang)
	
	if place_meeting(xx, yy, Floor)
		instance_create(xx, yy, Dust)
}

if floor(current_frame) % 3 > 0 {
	var cap = 6 * timescale,
		accel = 2,
		dist = 32 + max(0, 90 - alarm[0]) / 2,
		rotation = (current_frame) % 360
	
	with Dust {
		if speed < cap && distance_to_object(other) <= dist {
			motion_add(point_direction(x, y, other.x, other.y), accel * timescale)
			motion_add(rotation, (1) * timescale)
		}
	}
	
	with Smoke {
		if speed < cap && distance_to_object(other) <= dist {
			motion_add(point_direction(x, y, other.x, other.y), accel * timescale)
			motion_add(rotation, (1) * timescale)
		}
	}
	
	with Feather {
		if speed < cap && distance_to_object(other) <= dist {
			motion_add(point_direction(x, y, other.x, other.y), accel * timescale)
			motion_add(rotation, (2) * timescale)
		}
	}
	
	with Debris {
		if speed < cap && distance_to_object(other) <= dist {
			motion_add(point_direction(x, y, other.x, other.y), accel * timescale)
			motion_add(rotation, (0.5) * timescale)
		}
	}
	
	/*
	
	with Corpse {
		if speed < cap && distance_to_object(other) <= dist {
			motion_add(point_direction(x, y, other.x, other.y), (accel / (1 + size / (size + 2))) * timescale)
			
			if speed > 0 && !instance_is(self, CorpseActive) {
				var spr = sprite_index,
					img = image_index,
					spd = image_speed
				
				instance_change(CorpseActive, false)
				
				sprite_index = spr
				image_index = img
				image_speed = spd
			}
		}
	}
	
	*/
}
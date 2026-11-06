/// @function scrRadDrop
/// @param x
/// @param y
/// @param amount
/// @param big_chunks=true
/// @param proc_stalker=true
function scrRadDrop(_x, _y, _amount, _can_big = true, _can_stalker = true) {
	var _high = instance_is(self, RadChest) ? 26 : 15, _speed, _direction;
	
	if (instance_is(self, prop)) {
		_direction = random_angle
		_speed = (16) * timescale
	}
	else {
		_direction = direction
		_speed = speed
	}
	
	if (_can_big) while (_amount > _high) {
		_amount -= 10
		
		with instance_create(_x, _y, BigRad) {
			motion_add(_direction, _speed)
			motion_add(random_angle, (random(_amount * 0.5) + 5) * timescale)
			
			// 循环次数按「逻辑步」折算：
			//   speed 是「每帧」速度（已被 timescale 缩放），循环次数应表达逻辑步速度。
			//   30fps(ts=1) 次数不变 → 行为不变；60fps(ts=0.5) 次数×2 → 缩减与 30fps 一致。
			repeat (round(speed / timescale)) speed *= 0.9
			
			if (_can_stalker) {
				repeat (4) scrStalkerProc()
			}
		}
	}
	
	repeat (_amount) {
		with instance_create(_x, _y, Rad) {
			motion_add(_direction, _speed)
			motion_add(random_angle, (random(_amount * 0.5) + 5) * timescale)
			
			// 循环次数按「逻辑步」折算：
			//   speed 是「每帧」速度（已被 timescale 缩放），循环次数应表达逻辑步速度。
			//   30fps(ts=1) 次数不变 → 行为不变；60fps(ts=0.5) 次数×2 → 缩减与 30fps 一致。
			repeat (round(speed / timescale)) speed *= 0.9
			
			if (_can_stalker) scrStalkerProc()
		}
	}
}

function scrStalkerProc() {
	if (!scr_ultra_get(Race.Horror, UltraSkill.Stalker)) exit
	
	var _x = x, _y = y, _direction = direction
	
	with Player {
		if (race != Race.Horror) continue
		
		with scr_projectile_create(_x, _y, HorrorBullet, _direction, 9) {
			/**/ if (other.bskin == SkinLetter.B) sprite_index = sprHorrorBBullet
			else if (other.bskin == SkinLetter.C) sprite_index = sprHorrorCBullet
		}
			
		snd_play_hit(sndHorrorA)
	}
}
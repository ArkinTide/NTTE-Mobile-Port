/// @function scr_projectile_create
/// @param x
/// @param y
/// @param object_index
/// @param {Undefined|Real|Array} direction=0
/// @param {Undefined|Real|Array} speed=0
/// @param default_struct
function scr_projectile_create(_x, _y, _object_index, _direction = undefined, _speed = undefined, _struct = undefined) {
	with (scr_damage_create(_x, _y, _object_index, _struct)) {
		if (is_array(_speed)) {
			speed = (random_range(_speed[0], _speed[1])) * timescale
		}
		else if (is_numeric(_speed)) {
			// 60帧适配：数值分支同样要缩放。
			// 原代码这里是 `speed = _speed`，导致所有以「数值」传速度的子弹
			// （箭矢/普通子弹/霰弹/ScorpionBullet/GuardianBullet/IDPDBullet…）
			// 在 60fps 下初速度翻倍。数组分支早已乘 timescale，这里补齐。
			speed = (_speed) * timescale
		}
		
		if (is_array(_direction)) {
			direction = random_range(_direction[0], _direction[1])
		}
		else if (is_numeric(_direction)) {
			direction = _direction
		}
		
		// 「开火黏度」中值化 —— 第一帧可见位置 = 全速位移的 3/4（30/60/120 帧一致）。
		// 背景：新生成的投射物要在本物理帧的运动阶段先走一帧 speed、然后才被绘制，
		// 因此「第一帧可见位置」= speed×1帧 = 30 帧走全速 / 60 帧只走半速 ——
		// 观感上前者「在枪口」、后者「贴（黏）在角色身上」，两端明显不同（用户 2026-10-16 截图确认）。
		// 用户决策：两端取中值 —— 30 帧与 60 帧都改为「3/4 全速位移」处出现（即各向中间靠拢 1/2）。
		// 公式：lead = speed×(0.75/timescale − 1)：ts=1 → −speed/4；ts=0.5 → +speed/4；ts=0.25(120帧) → +speed/2。
		// ⚠️ 本条目**刻意修改 30 帧**（经用户批准，本项目唯一一条）：30 帧首帧位置由全速 → 3/4 全速。
		// 例外：Flame（喷火器/Dragon：自带脱墙前移 + move_contact_solid 枪口推齐，F25 已验收）与
		// BouncerBullet（scrFire 自带脱墙前移）—— 它们的第一帧位移是「防卡墙」专用对齐，不能叠加本中值项。
		// 近战族（Slash 家族 + Shank/EnergyShank）初速仅
		// 2~3px/帧，「首帧黏度」收益 ≤1px 肉眼不可见，反而留下随帧率漂移的 1.0px 出生差（120 帧放大到 2.25px）；
		// 原版 PC 近战出生点恒 20.0（无 lead 补偿）→ 用户裁定排除，回归原版：出生 20.0/20.0、30 帧逐字节。
		var _melee_slash = (_object_index == NTTEFullClamShieldSlash || _object_index == NTTEFullBoneSlash || _object_index == Slash || _object_index == EnergySlash || _object_index == Shank
			|| _object_index == EnergyShank || _object_index == EnergyHammerSlash || _object_index == BloodSlash
			|| _object_index == LightningSlash || _object_index == UltraSlash)
		if (speed != 0 && _object_index != Flame && _object_index != BouncerBullet && !_melee_slash) {
			var _launch_lead = speed * (0.75 / timescale - 1)
			x += lengthdir_x(_launch_lead, direction)
			y += lengthdir_y(_launch_lead, direction)
		}
		
		// BUG: sometimes, somehow, this code proceeds way before the object has ran its create event,
		// which results in unset variable error. It's not very clear how that happens, so it is what it is
		if (self[$ "projectile_direction_changes_angle"]) {
			image_angle = direction
		}
		
		if (team != team_player && scr_skill_get(mut_euphoria)) {
			with instance_create(x, y, EuphoriaEffectDelay) {
				target = other.id
			}
		}
		
		return id
	}
	
	return noone
}

/// @function scr_projectile_spread
/// @param spread_angle
function scr_projectile_spread(_angle) {
	var _accuracy = scrNTTEFullActorAccuracy(id,instance_is(creator, Player) ? scrNTTEFullValue(creator,"accuracy",1) : 1)
	direction += orandom(_angle/* / 2*/) * _accuracy
	image_angle = direction
}

/// @function scr_projectile_shift
/// @param angle_shift
/// @param move_distance=0
// hitme includes native Allies without accuracy. Read fallback safely before
// ActorAccuracy applies the captured/dynamic deferred firing context.
function scr_projectile_shift(_angle, _move_amount = 0) {
	var _accuracy = scrNTTEFullActorAccuracy(id,instance_is(creator, hitme) ? scrNTTEFullValue(creator,"accuracy",1) : 1)
	
	if _angle != 0 {
		direction += _angle * _accuracy
		image_angle = direction
	}
	
	if _move_amount != 0 {
		x += ldrx(_move_amount, direction)
		y += ldry(_move_amount, direction)
	}
}

function scr_projectile_long_arms(_long_arms) {
	if (_long_arms != 0) {
		scr_projectile_shift(0, _long_arms * 20)
		motion_add(direction, (_long_arms * 3) * timescale)
		// 撤销 v2 的「首帧位移补齐」lead —— 2026-10-16 复核证实
		// #5（60 帧隔墙 slash 更远）的真因是**撞墙缓推的帧率不平衡**（见 8-6 v2 的注释：30 帧被墙
		// 冻住 / 60 帧贴墙穿过），并非首帧位移。且数学上「无 lead」时两侧在**每个动画帧**的位置
		// 严格相等（含 friction² 衰减项）：
		//   30 帧：动画帧 k 在 2.5k 物理帧 ⇒ 位移 3L×2.5k = 7.5L·k；
		//   60 帧：动画帧 k 在 5k 物理帧 ⇒ 位移 1.5L×5k = 7.5L·k。
		// lead 反而让 60 帧整体前移 1.5L，制造新差异。v3 = 只保留 `* timescale`，
		// 30 帧逐字节不变、60 帧逐动画帧对齐。
		longarms = _long_arms
		xprevious = x
		yprevious = y
		xstart = x
		ystart = y
	}}
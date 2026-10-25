// NTTE merged native collision entry, preserving inherited dispatch.
var _ntte_merge_collision=scrNTTEFullMergedNativeCollisionBegin(id,other.id);
if(!is_undefined(_ntte_merge_collision) && !_ntte_merge_collision.allow) { scrNTTEFullMergedNativeCollisionEnd(_ntte_merge_collision); exit; }
try {
// 撞墙响应：每物理帧只结算一次 + 从「帧起点」精确回退（30/60/120 帧同速、单调无回跳）。
// 要点：`x -= hspeed` 假定「引擎本帧的位移一定发生」，而贴墙帧的引擎位移参与度不稳定——
//   部分帧真实位移为 0（事件却照扣 −hspeed）→ 帧净位移在「+3×ts」与「−hspeed+3×ts」间摆动；
//   h > 3×ts 时连续净后退（长臂 / ultra shovel 最明显）= 所见「顿挫抽搐」。
// 正解：回退改用工程惯用的「帧起点」写法（xprevious/yprevious —— 原版 Seeker/TrapFire 撞墙同款）：
//   无论引擎本帧移动多少（正常 / 被挡 / 部分），都精确恢复到帧起点再统一追加推进
//   → 贴墙帧净位移恒 = +3×ts（快）或 0（慢）；30/60/120 帧严格同速（每 30Hz 仍是 +3px）。
if (!variable_instance_exists(id, "__wall_frame")) __wall_frame = -99999
if (__wall_frame != current_frame) {
    __wall_frame = current_frame

    x = xprevious
    y = yprevious

    if (speed > (2) * timescale) {
        x += lengthdir_x(3 * timescale, image_angle)
        y += lengthdir_y(3 * timescale, image_angle)
    }
}

if (walled || shank) exit

with other {
	var _cx = bbox_center_x,
		_cy = bbox_center_y,
		_angle = point_direction(other.x, other.y, _cx, _cy)
	
	with instance_create(_cx, _cy, MeleeHitWall) {
	    image_angle = _angle
	}
}

scr_screenshake(damage div 3)

walled = true

if guitar {
    var snd = asset_get_index("sndGuitarHit" + string(irandom(6) + 1))
	
    if audio_exists(snd) {
        snd_play_pitch(snd, 0.2)
	}
}
else snd_play(sndMeleeWall)
}
finally {
    scrNTTEFullMergedNativeCollisionEnd(_ntte_merge_collision);
}

// 60帧适配：与 alarm[0] 等价的按 timescale 计时兜底，
// 确保「变异选择提示文字」无论如何都会进入消失阶段（详见 Create_0.gml）。
// 显式比较：原 `if (!disappear)` 在 60 帧下会在 disappear=0.5 时
// 二次通过（0.5 判假）→ 把刚要结束的消失计时**无限重置**；`if disappear` 同理会在 0.5 处阻断递减。
// 两处改为显式比较（30 帧整数步进 → 行为与原来逐字节一致）。
if (disappear <= 0) {
    showtime += timescale
    if (showtime >= 40) disappear = 10
}

if (disappear > 0) {
    disappear -= timescale

    if (disappear <= 0) {
		instance_destroy()
	}
}

if lockstep_stop
	exit
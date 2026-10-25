/// @description Control pause states

// 60帧适配：alarm 时间补偿（整数安全版）
//
// 背景：GameMaker 的 alarm 由引擎每步固定递减 1，无法像普通变量那样用 timescale 门控。
// 全项目有 794 处 `alarm[...] = ...` 赋值，逐个改代价大且容易漏。
//
// ⚠️ 关键约束：**alarm 的值必须是整数**。
// 官方文档 alarm_set 明确写着「非整数值会被四舍五入到最接近的整数」。
// 因此上一版「alarm[i] += (1 - timescale)」的小数补偿会被取整吃掉，
// 净递减仍是每帧 1 → 60fps 下所有 alarm 时长减半
// （攻击频率、连发间隔、浮动文字、瞬移、死亡演出、无敌计时等全部 2 倍速）。
//
// 本版改用「累加器 + 整数补回」：把每帧应补的 (1 - timescale) 累加起来，
// 攒够 1 就给所有活跃 alarm 补 1。平均净递减 = 1 - (1 - timescale) = timescale。
//     30fps：timescale=1    → 补 0     → 与原版完全一致（整段被跳过，零开销）
//     60fps：timescale=0.5  → 每 2 帧补 1
//    120fps：timescale=0.25 → 每 4 帧补 3
//
// alarm 的「语义单位」仍与原来一致（逻辑步），因此全项目所有 alarm 比较/判断
// （如 `alarm[2] > 8`、`alarm[0] == 10`、`alarm[i] == -1`）都无需改动：
// 补 1 只会让某个整数多停留一帧，值仍会逐个经过所有整数点。
if (timescale < 1) {
	global.alarm_topup_acc += (1 - timescale)
	var _add = floor(global.alarm_topup_acc)
	if (_add > 0) {
		global.alarm_topup_acc -= _add
		with (all) {
			for (var _i = 0; _i < 12; ++_i) {
				if (alarm[_i] > 0) alarm[_i] += _add
			}
		}
	}
}

scrNTTEFullParrotCharmBeginStep();

if (want_pause > 0) {
	if (instance_exists(Player) && !instance_exists(GenCont) && !instance_exists(GameOver)) {
		if ((-- want_pause) <= 0) {
		    want_pause = 0
		
		    if (!bossintro) scrMakePauseButtons()
		
		    with (MobileUI) index = -1
		
		    instance_deactivate_all(true)
		    instance_activate_object(BackCont)
		    instance_activate_object(GameCont)
		    instance_activate_object(TopCont)
		    instance_activate_object(PauseButton)
		    instance_activate_object(CoopController)
		    instance_activate_object(MusCont)
		    instance_activate_object(Console)
			instance_activate_object(PauseImage)
			// BEGIN NTTE OWNED PAUSED UNLOCK PRESENTATION
			instance_activate_object(NTTEFullUnlockCont)
			// END NTTE OWNED PAUSED UNLOCK PRESENTATION
		}
	}
	else if (paused) scrGameUnpause()
}

if quit_pause {
	if (!instance_exists(GenCont) && !instance_exists(LevCont)) {
		with (MobileUI) instance_destroy()
		scrCreateMobileControls()
	}
	
	quit_pause = false
}

if !scrGameIsLockstep() && (want_restart || want_menu) {
	KeyCont.press_paus[global.index] = false
	
	if want_menu > 0 {
		if !(-- want_menu) {
			scrGameRestart(true)
		    want_quit_to_menu = true
		    want_menu = 0
		}
	}
	else if want_restart > 0 {
		if !(-- want_restart) {
			scrGameRestart(false)
		    want_restart = 0
		}
	}
}
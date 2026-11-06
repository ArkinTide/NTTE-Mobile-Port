function scrKeyboardHandleKeyPress(_keycode) {
	switch (_keycode) {
		case vk_escape:
			if instance_exists(DebugObjectSpawner) {
				instance_destroy(DebugObjectSpawner)
				return true
			}
			if is_debug_overlay_open() {
				scr_debug_overlay_toggle()
				return true
			}
			// 与 GM debug 面板**同一处理位置**：console 打开时 ESC 关闭它。
			// 返回 true → UberCont/KeyPress_1 会 keyboard_clear(vk_escape) → 同一帧不会再去暂停游戏。
			// （原版这里只处理 debug 面板；console 的关闭并入这里，就不必在 Console/Step_0 里每帧判断了。）
			if global.console_active {
				global.console_active = false
				with (Console) event_user(0)
				keyboard_clear(vk_escape)
				return true
			}
		break
		case vk_backspace:
			// Android：返回键 / 删除键关闭 console（与上面 ESC 同理）。
			if global.console_active && os_type == os_android {
				global.console_active = false
				with (Console) event_user(0)
				keyboard_clear(vk_backspace)
				return true
			}
			return instance_exists(DebugObjectSpawner)
		break
		case vk_tilde:
			#region Opening & closing debug overlay
			with (UberCont) {
				if (!scrNTTEFullConsoleEnabled()) break
				
				// 开启「原版控制台」时，「~」只切换游戏内 console，
				// 不打开 GM debug 面板（面板会抢走键盘输入 → console 打不了字）。
				if (opt_orig_console) {
					if (!instance_exists(Console)) instance_create(0, 0, Console)
					// 桌面端「~」打不开 console 的根因：
					// UberCont/KeyPress_1 在本次按键处理后会执行 keyboard_clear(vk_tilde)，
					// 把按键状态清掉 → Console/Step_0 里的 key_check("console", keystate_press)
					// 永远读到 false（Android 用的是「~」按钮直接置 open，所以没这个问题）。
					// 这里直接置 open，走与 Android 按钮完全相同的路径，绕过被清掉的按键状态。
					with (Console) open = true
					return true
				}
				
				scr_debug_overlay_toggle()
				
				if (is_debug_overlay_open()) {
					if (keyboard_check_pressed(vk_escape)
						|| (is_mobile && !keyboard_virtual_status() && keyboard_check_pressed(vk_backspace))
					) {
						if (is_desktop) {
							keyboard_clear(vk_escape)
						}
						show_debug_log(false)
					}
					instance_destroy(DebugObjectSpawner)
				}
				return true
			}
			#endregion
		break
	}
	
	return false
}


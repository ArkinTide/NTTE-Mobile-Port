var _index = global.index

if native_cursor_inst != -1
	native_cursor_update()

input_tick()

if (!block_input_frames) {
	scrHandleInputsGeneral(global.index)
	scrGamepadUIControl()
}
else {
	block_input_fire = true
	block_input_frames -= timescale
}

if (instance_exists(CoopController)) {
	with (CoopController) event_user(0)
}

if (paused) {
	if (splatindex < 3) splatindex += timescale
	
	// this is some sort of weird edge-case when
	// you minimize your game by opening another app and that
	// locks you into paused state with no UI elements
	if (!bossintro && !want_pause
		&& !instance_exists(PauseButton)
		&& !instance_exists(MenuOptions)
	) {
		scrGameUnpause()
	}
}

if (!KeyCont.press_paus[_index]) {
	KeyCont.press_paus[_index] = scr_keyboard_check_pressed(vk_escape)
		|| scr_keyboard_check_pressed(vk_backspace) || scrNTTEGamepadButton(gp_start,keystate_press)
	
	if !paused && !want_pause && (!is_desktop || (!instance_exists(CoopController) && opt_autopause)) {
		if (is_desktop ? (!window_has_focus()) : os_is_paused()) {
			KeyCont.press_paus[_index] = true
		}
	}
}


for (var i = 0; i < player_count; i++) {
	if (KeyCont.press_paus[i]) {
		KeyCont.press_paus[i] = false
		if (want_pause) break
		
		if scrGameIsPaused() {
			// Activate `Continue`
		    with PauseButton {
		        if image_index == 3 {
		            clicked = true
		            event_user(0)
		        }
		    }
		}
		else if !scrGameIsPaused() && scrGameCanPause() {
			scrGamePause()
		}
	}
}

if (!lockstep_stop && !paused && !instance_exists(PauseImage)) {
    var _left = view_xview - 32,
		_right = view_xview + view_width + 32,
		_top = view_yview - 32,
		_bottom = view_yview + view_height + 32,
		
		_wall_list = global.lis_walls_visible,
		_floor_list = global.lis_floors_visible,
		
		_camera_boundaries_check = (!instance_exists(Cinematic))
	
    ds_list_clear(_wall_list)
    ds_list_clear(_floor_list)
	
	if (_camera_boundaries_check) {
	    with (Wall) {
	        if (bbox_right >= _left && bbox_bottom >= _top && bbox_left < _right && bbox_top < _bottom) {
	            ds_list_add(_wall_list, id)
	        }
	    }
		with (Floor) {
	        if (bbox_right >= _left && bbox_bottom >= _top && bbox_left < _right && bbox_top < _bottom) {
	            ds_list_add(_floor_list, id)
	        }
	    }
	}
	else {
		with (Wall) ds_list_add(_wall_list, id)
		with (Floor) ds_list_add(_floor_list, id)
	}
}

if mainvol < 1 {
    mainvol = lerp(mainvol, 1, 0.4)
}

audio_emitter_gain(mainsound, opt_sndvol * mainvol)
camera_set_view_pos(view_camera[0], view_xview, view_yview)

// 60帧适配
// 1) 每步根据当前帧率重算 timescale（逻辑基准固定 30Hz）
// 2) current_frame 改为按 timescale 递增，而不是原来的 `current_frame ++`
//
// 原来的 `current_frame ++` 是整数递增，导致 `current_frame % 1` 恒等于 0，
// 于是 macros_gameplay.gml 里的 `current_frame_active` 门控恒为真 —— 那套
// 「隔帧执行」的机制从未生效过。
// 改为按 timescale 递增后：
//     30fps：timescale=1   → current_frame 为 0,1,2...   % 1 恒为 0 → 门控恒真（与原版一致）
//     60fps：timescale=0.5 → current_frame 为 0,.5,1,1.5 % 1 交替 0/.5 → 门控正确隔帧生效
// 同时，所有 `nexthurt = current_frame + N` 这类按帧计时也自动获得帧率无关性，
// 因为 current_frame 的单位从「帧」变成了「30Hz 逻辑单位」。
scrNTTEFullRateApply();
current_frame += timescale

// debugclear 冷静期倒计时（单位 = 30Hz 逻辑帧；30 帧 = 1 秒）。

// debugclear 冷静期倒计时（单位 = 30Hz 逻辑帧；30 帧 = 1 秒）。
// 由 `dear`/`debugclear` 置 60；这里每帧递减；归零即「关卡已稳定，可以开始测数据」。
// 左上角的小字倒计时（`UberCont/Draw_75`）读取这个值。
if (global.debugclear_cooldown > 0) {
	global.debugclear_cooldown -= timescale
	if (global.debugclear_cooldown < 0) global.debugclear_cooldown = 0
}


if (opt_keyboard && instance_exists(PauseButton)) {
	// Restart hotkey
	if (scr_keyboard_check_pressed(ord("R"))) {
		with PauseButton {
			if image_index == 1 || image_index == 6 {
				event_user(0)
				KeyCont.press_paus[_index] = false
				break
			}
		}
	}
	
	// Quit hotkey
	if scr_keyboard_check_pressed(vk_escape) || scr_keyboard_check_pressed(vk_backspace) {
		with PauseButton {
			if image_index == 3 {
				event_user(0)
				KeyCont.press_paus[_index] = false
				break
			}
		}
	}
}

if (is_desktop) {
	if (scr_keyboard_check_held(vk_alt) && scr_keyboard_check_pressed(vk_enter)) {
		opt_fullscreen = !opt_fullscreen
		scr_window_set_fullscreen(opt_fullscreen)
	}
	
	if (global.__window_borderless_fs_requested) {
		if (scr_window_get_fullscreen() != global.__window_borderless_fs_target) {
			if (window_has_focus()) {
				scr_window_set_fullscreen(global.__window_borderless_fs_target)
			}
		}
		else {
			global.__window_borderless_fs_requested = false
		}
	}
}

if (instance_exists(TestCont) && global.__debug_test_framerate_uncapped) {
	if (!test_framerate_uncapped) {
		if (game_get_speed(gamespeed_fps) != game_speed_uncaped) {
			game_set_speed(game_speed_uncaped, gamespeed_fps)
			display_reset(display_aa, false)
		}
		test_framerate_uncapped = true
	}
	else if (is_desktop) {
		draw_enable_drawevent(((current_frame % 30) < timescale) || window_has_focus())
	}
}
	else if (test_framerate_uncapped) {
		if (game_get_speed(gamespeed_fps) == game_speed_uncaped) {
			display_reset(display_aa, opt_vsync)
			// 退出无上限测试模式时，恢复「用户设置的帧率」，
			// 而不是写死的 30（opt_framerate 由 scrOptionsUpdate 在 Room Start 时读入）。
			game_set_speed(opt_framerate, gamespeed_fps)
		}
		test_framerate_uncapped = false
	}

if instance_exists(TestCont) {
	with (TestCont) event_user(0)
}

if (is_desktop) {
	if (!opt_keyboard || is_mouse_over_debug_overlay()) {
		if window_get_cursor() == cr_none {
			window_set_cursor(cr_default)
		}
	}
	else if (window_get_cursor() == cr_default) {
		window_set_cursor(cr_none)
	}
}

// manual handling for closing debug overlay console
// because gamemaker automatically puts you into typing mode
// once it opens the `scrKeyboardHandleKeyPress` doesn't get
// run from Keypress - Any becuse the event is suppressed
if (is_debug_overlay_open() && scrNTTEFullConsoleEnabled()
	&& (keyboard_check_pressed(vk_escape) || (!is_keyboard_used_debug_overlay() && keyboard_check_pressed(vk_backspace)))
) {
	scr_debug_overlay_toggle()
	keyboard_clear(vk_backspace)
	keyboard_clear(vk_escape)
}
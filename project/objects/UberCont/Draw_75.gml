// debugclear 冷静期倒计时（左上角小字；归零后自动消失）。
// 目的：调试时一眼看出「关卡什么时候稳定、可以开始测数据」（`dear` 的初衷就是不混脏数据）。
// 样式：默认字体 + scale 1 + 白色（不设 draw_set_font）。
// 另套用原版「抽动」效果（同 `MenuOptions/Other_10.gml` 的 `text_input_shake`：每帧给坐标加 `orandom`）。
// 白色 + 黑阴影 + 抖动 ⇒ 任何背景都看得清。
if (global.debugclear_cooldown > 0) {
	var _cd_str = "debugclear  " + string(round(global.debugclear_cooldown / 30 * 10) / 10) + "s",
		_cd_x = 8 + orandom(2),
		_cd_y = 8 + orandom(2)

	draw_reset_font()
	draw_set_halign(fa_left)
	draw_set_valign(fa_top)
	draw_text_nt(_cd_x + 1, _cd_y + 1, _cd_str, 1, 1, 0, c_black, 0.75)
	draw_text_nt(_cd_x, _cd_y, _cd_str, 1, 1, 0, c_white, 1)
	draw_set_color(c_white)
	draw_set_alpha(1)
	draw_reset_font()
}

if opt_gamepad && (instance_exists(MainMenuButton) or instance_exists(PlayButton) or instance_exists(MenuOptions)) {
	draw_set_halign(fa_right)
	draw_set_valign(fa_middle)
	
	var dx = gui_w - 8,
		dy = gui_h - 40,
		str = loc("MainMenu:Confirm", "CONFIRM")
	
	draw_text_nt(dx, dy, "@s" + str)
	
	draw_gamepad_button(gp_face1, 0, dx - 9 - font_get_string_width(str), dy)
	
	draw_set_halign(fa_left)
	draw_set_valign(fa_top)
	
}

if global.__debug_camera_display_info {
	var _str  = $"Camera width  ({camera_get_view_width(view_camera)}) (global = {view_width})\n"
	    _str += $"Camera height ({camera_get_view_height(view_camera)}) (global = {view_height})\n\n"
	    _str += $"Port     {view_wport[0]}/{view_hport[0]}\n"
	    _str += $"Window   {window_get_width()}/{window_get_height()}\n"
	    _str += $"Display  {scr_display_get_width()}/{scr_display_get_height()} ({scr_display_get_aspect_ratio()})\n\n"
	    _str += $"Surface  {surface_exists(application_surface) ? surface_get_width(application_surface) : "NULL"}/{surface_exists(application_surface) ? surface_get_height(application_surface) : "NULL"}\n"
		_str += $"GUI {gui_w} {gui_h}\nMouse {device_mouse_x(0)} {device_mouse_x(1)}\n\n"
		_str += $"Camera\nX {view_xview} \nY {view_yview}"
	
	draw_set_color(c_white)
	var _scale = scr_window_get_fullscreen() ? 0.5 : 1
	draw_text_nt(0, 0, _str, _scale, _scale, 0)
}

if (is_touch(global.index) && scrNTTEFullConsoleEnabled()) {
	var _size = 24,
		_left = view_width - 32,
		_top = 16,
		_right = _left + _size,
		_bottom = _top + _size
	
	if (opt_pausebutton) {
		_bottom += 32
		_top += 32
	}
	
    draw_set_color(c_black)
    draw_set_alpha(0.5)
    
	draw_rectangle(_left, _top, _right, _bottom, 0)
	
	draw_set_color(c_white)
    draw_set_alpha(1)
	
	draw_align(fa_center, fa_middle)
	draw_set_font(fntM1)
	
    draw_text_nt((_left + _right) * 0.5, (_top + _bottom) * 0.5, "~")
    
	draw_reset_font()
	draw_align()
    
    if (mouse_check_button_pressed(mb_left) && !is_mouse_over_debug_overlay()) {
        if (point_in_rectangle(gui_x, gui_y, _left, _top, _right, _bottom)) {
			// 触屏 ~ 按钮：开启原版控制台时路由到游戏内 console
			if (opt_orig_console) {
				if (!instance_exists(Console)) instance_create(0, 0, Console)
				with (Console) open = true
			}
			else scr_debug_overlay_toggle()
		}
    }
}

if native_cursor_inst == -1 && (is_desktop ? (window_get_cursor() == cr_none) : opt_keyboard) && scrCanDrawCursor() {
    draw_sprite_ext(sprCrosshair, opt_crosshair, device_mouse_x_to_gui(0), device_mouse_y_to_gui(0), 1, 1, 0, opt_cursorcol, 1)
}
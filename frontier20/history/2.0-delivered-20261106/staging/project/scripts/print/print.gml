#macro CONSOLE_LOG_CAPACITY 40

function print() {
	static _buffer = buffer_create(1024, buffer_grow, 1)
	
	buffer_seek(_buffer, buffer_seek_start, 0)
	
	//
	var _index = 1
	buffer_write(_buffer, buffer_text, string(argument[0]))
	repeat (argument_count - 1) {
		buffer_write(_buffer, buffer_text, " ")
		buffer_write(_buffer, buffer_text, string(argument[_index ++]))
	}
	
    buffer_write(_buffer, buffer_u8, 0)
	
	var _str = buffer_peek(_buffer, 0, buffer_text)
	scr_log_push(_str, c_white, false)
	show_debug_message(_str)
}

function scr_log_push(_message, _color = c_white, _output_echo = true) {
	if string_count("\n", _message) > 0 {
		var list = string_split(_message, "\n", true),
			count = array_length(list)
		
		// 配合下面的「追加」语义：按正序压入，
		// 多行消息在屏幕上仍是「第一行在上、末行在下」。
		for (var _i = 0; _i < count; _i++) {
			scr_log_push(list[_i], _color)
		}
		
		exit
	}
	
	// 日志顺序改为「最新在末尾」。
	// Console/Draw_75 的绘制循环本来就是「高 index 画在最下方」，
	// 所以改成追加之后，最新一行自然贴在输入行上方、越旧越往上滚（终端式布局）。
	// 用户 2026-10-08 实测原版（最新在最上）后决定改回这一版。
	if (array_length(global.log_output) >= CONSOLE_LOG_CAPACITY) {
		array_delete(global.log_output, 0, 1)
		array_delete(global.log_color, 0, 1)
	}
	
	array_push(global.log_output, _message)
	array_push(global.log_color, _color)
	
	if (_output_echo) show_debug_message(_message)
}

function scr_debug_print_stacktrace(_message = undefined, _start = 0) {
	var _trace = debug_get_callstack(99)
	array_pop(_trace)
	array_reverse_ext(_trace)
	
	var _string = string_join_ext("\n|- ", _trace, _start)
	if is_string(_message) {
		show_debug_message("|---" + string(_message) + "\n|- " + _string)
	}
	else {
		show_debug_message("\n|- " + string(_string))
	}
}
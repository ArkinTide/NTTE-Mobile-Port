/// @function font_string_measure
/// @param string
/// @param component_return_index=-1
function font_string_measure(_string, _component = -1) {
	static buffer = buffer_create(1024, buffer_grow, 1)
	static __font_info_cache = {}
	static __cache = {}
	
	var _font_name = font_get_name(draw_get_font()),
		_key = $"<{_font_name}:{_string}>"
	
	if (variable_struct_exists(__cache, _key)) {
		var _r = __cache[$ _key]
		/**/ if (_component == 0) return _r[0]
		else if (_component == 1) return _r[1]
		return _r
	}
	
	var _length = string_length(_string)
	if (_length == 0) return 0
	
	var _info = __font_info_cache[$ _font_name]
	
	if (is_undefined(_info)) {
		_info = font_get_info(draw_get_font())
		__font_info_cache[$ _font_name] = _info
	}
	
	#region Single element
	
	if (_length == 1) {
		var _g = _info.glyphs[$ _string]
		
		if (is_struct(_g)) {
			if (variable_struct_exists(_g, "shift")) {
				return _component ? _g.h : _g.shift
			}
			else {
				// fallback
				return _component
					? string_height(_string)
					: string_width(_string)
			}
		}
		else if (_string == "\n") {
			return _component ? 8 : 1
		}
		return _component ? string_height(_string) : string_width(_string)
	}
	
	#endregion
	
	var _ctx = {
		font: draw_get_font(),
		glyphs: _info.glyphs,
		fixed_line_height: 0,
		
		current_width: 0,
		max_width: 0,
		
		max_character_height: 0,
		total_height: 0
	}
	
	if (_ctx.font == fntM1) _ctx.fixed_line_height = 8
	// 编译期中文字体行距修正：运行时时代行距 ≈21（Silver 14pt 度量；与
	// fntCJK.yy 的 lineHeight=21 一致）。上述 21 为字体 hhea 理论值、
	// 非实际行距；三处旧版截图实测锚定：目标行距 = 字形高 12 + 1 = 13（统计 58px / 成就
	// 60px / 视频设置列表步进 21 = 13+8；物理像素均 ÷4.5）→ 修正为 13。
	if (_ctx.font == fntCJK) _ctx.fixed_line_height = 13
	
	with (_ctx) string_foreach(_string, function(_char) {
		var _g = glyphs[$ _char]
		
		if (is_undefined(_g) || !variable_struct_exists(_g, "shift")) {
			if (_char == "\n") {
				static __newline_struct = {
					shift: 1,
					h: 8
				}
				
				_g = __newline_struct
			}
			else {
				static __reusable_struct = {}
				__reusable_struct.shift = string_width(_char)
				__reusable_struct.h = string_height(_char)
				_g = __reusable_struct
			}
		}
		
		var _w = _g.shift,
			_h = (fixed_line_height ? fixed_line_height : (_g.h + 1))
		
		if (_char == "\n") {
			max_width = max(current_width, max_width)
			current_width = 0
			
			total_height += max_character_height
			max_character_height = fixed_line_height
		}
		else {
			current_width += _w
			
			if (_h > max_character_height) {
				max_character_height = _h
			}
		}
	})
	
	_r = [
		max(_ctx.current_width, _ctx.max_width),
		_ctx.max_character_height + _ctx.total_height
	]
	variable_struct_set(__cache, _key, _r)
	
	/**/ if (_component == 0) return _r[0]
	else if (_component == 1) return _r[1]
	return _r
}

/// @function font_get_string_width
/// @param {String} string
function font_get_string_width(_string) {
	gml_pragma("forceinline")
	return font_string_measure(string(_string), 0)
}

/// @function font_get_string_height
/// @param {String} string
function font_get_string_height(_string) {
	gml_pragma("forceinline")
	// fntCJK 高度封顶 13：编译期字体的单字符测量返回资源字形 h（27），
	// 会顶起 _def_height / 列表步进 / tooltip 等所有「高度基准」；运行时字形高 ≈12、
	// 行距 13。封顶后行高 = max(≤13, 13) = 13，与旧版一致。
	// 封顶须按行数扩展：N 行文本总高 = 13N（原一刀切 13 会压掉多行
	// 文本高度 → 技能描述/免责声明等「高度÷2」布局上移；2026-10-12 实机发现）。
	if (draw_get_font() == fntCJK) {
		var _cap = 13 * max(1, string_count("\n", string(_string)) + 1)
		return min(font_string_measure(string(_string), 1), _cap)
	}
	return font_string_measure(string(_string), 1)
}

function font_get_height_diff() {
	var _f = draw_get_font()
	
	if (_f == global.language_font_cjk) {
		switch (draw_get_valign()) {
			case fa_top: return 4
			case fa_middle: return 11
			case fa_bottom: return 0
		}
	}
	else if (_f == global.language_font_noto) {
		switch (draw_get_valign()) {
			case fa_top: return 2
			case fa_middle: return -2
			case fa_bottom: return 0
		}
	}
	
	return 0
}

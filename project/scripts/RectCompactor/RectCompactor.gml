#macro compactor_texturepage_width 2048
#macro compactor_texturepage_height 2048

function CustomTexturePageRect(_name, _image, _max_images, _width, _height, _sprite) constructor {
	assert(is_numeric(_sprite) && _sprite >= 0, _name)
	
	name = _name
	image_index = _image
	image_number = _max_images
	
	width = _width
	height = _height
	
	sprite = _sprite
	
	weight = _width * _height * _height
	
	x = 0
	y = 0
	
	// frame background color for debugging purposes
	image_blend = c_white
	
	is_sorted = false
	sort_index = -1
	
	static to_frame_entry = function(_texturepage_index) {
		return {
			"x": x,
			"y": y,
			"w": width,
			"h": height,
			"tp": _texturepage_index
		}
	}
}

function CustomTexturePageCompactor() constructor {
	rectangles = undefined
	
	static populate_textures = function(_texture_rects) {
		var _count = array_length(_texture_rects)
		
		rectangles = array_create(_count)
		
		array_copy(rectangles, 0, _texture_rects, 0, _count)
	}
	
	static count_rects = function() {
		return array_length(rectangles)
	}
	
	static find_tiniest_fit = function(_min_width, _from_index = 0) {
		var _rectangles = rectangles,
			_count = array_length(_rectangles),
			
			_result_index = -1,
			_max_width = 0
		
		for(var i = _from_index; i < _count; ++i) {
			var _rectangle = _rectangles[i]
			
			if (!_rectangle.is_sorted
				&& _rectangle.width < _min_width
				&& _rectangle.width > _max_width
			) {
				_max_width = _rectangle.width
				_result_index = i
			}
		}
		
		if (_result_index >= 0) {
			var _result = _rectangles[_result_index]
			array_delete(_rectangles, _result_index, 1)
			array_insert(_rectangles, _from_index, _result)
			return _result
		}
		
		return undefined
	}
	
	static process_texture_pages = function () {
		var _rectangles = rectangles,
			_rectangle_count = array_length(_rectangles),
			_texture_pages = [];
		
		_rectangles = rectangles
		_rectangle_count = count_rects()
		
		array_sort(_rectangles, function(a, b) {
			var _d = b.weight - a.weight
			if (_d == 0) _d = (b.image_number - a.image_number)
			if (_d == 0) _d = (a.name > b.name) ? -1 : 1
			return sign(_d)
		})
		
		var _px = 0,
			_py = 0,
			
			_grid_width = compactor_texturepage_width,
			_grid_height = compactor_texturepage_height,
			
			_max_rect_height = 0,
			
			_rectangle_index = 0,
			_skipped_index_start = -1,
			
			_sprite_data = {}
		
		while (_rectangle_index < _rectangle_count) {
			var _rectangle = _rectangles[_rectangle_index]
			
			if (_rectangle.is_sorted) {
				_rectangle_index ++
				continue
			}
			
			var _sprite_name = _rectangle.name,
				
				_width = _rectangle.width,
				_height = _rectangle.height,
				
				_is_present = variable_struct_exists(_sprite_data, _sprite_name),
				
				_all_good = true,
				_cannot_fit_whole = false,
				_new_page_requested = false
			
			// skip if we can't fit this sprite vertically
			if ((_py + _rectangle.height) >= _grid_height) {
				_new_page_requested = true
				_cannot_fit_whole = true
				_all_good = false
			}
			
			if (_all_good) {
				_rectangle.x = _px
				_rectangle.y = _py
				
				_rectangle.sort_index = _rectangle_index
				_rectangle.is_sorted = true
				
				_max_rect_height = max(_height, _max_rect_height)
				
				if ((_px + _width) >= _grid_width) {
					// 停用 find_tiniest_fit「行尾空隙拟合」。
					// 原实现把塞进行尾空隙的矩形只标记坐标，从不写入页数据、也从不绘制
					// （且所有拟合矩形坐标堆叠在同一处）——这些帧被静默丢弃，是 sprLightning /
					// sprBullet1 / EnergySword 等整只失效的根源。停用后它们改走正常放置路径。
					//
					
					if ((_py + _max_rect_height + _height) > _grid_height) {
						_new_page_requested = true
						_cannot_fit_whole = true
						_all_good = false
						// 本矩形在翻页前已被标记过 is_sorted；
						// 若不清掉，翻页后主循环会按其「已排序」直接跳过 → 该帧静默丢失。
						_rectangle.is_sorted = false
					}
					else {
						_px = 0
						_py += _max_rect_height
						
						_max_rect_height = _height
						
						if (_py < _grid_height) {
							_rectangle.x = _px
							_rectangle.y = _py
						}
						else {
							// TODO: resolve such cases
							show_error("fucky wucky", true)
							_rectangle.is_sorted = false
						}
					}
				}
				
				_px += _width
			}
			
			if (_new_page_requested) {
				// 翻页：先收起「已完成页」再开新页。
				// 原版先清空 _sprite_data 再 push → 断页前累计的整页从未入列，
				// 该页全部精灵被静默丢弃（Nothing2 出场动画等整批失效的根源）。
				//
				if (array_length(variable_struct_get_names(_sprite_data)) != 0) {
					array_push(_texture_pages, _sprite_data)
				}
				
				_sprite_data = {}
				
				if (_skipped_index_start >= 0) {
					_rectangle_index = _skipped_index_start
					_skipped_index_start = -1
				}
				
				_px = 0
				_py = 0
				_max_rect_height = 0
			}
			else if (_all_good) {
				if (_is_present) {
					array_push(_sprite_data[$ _sprite_name], _rectangle)
				}
				else {
					_sprite_data[$ _sprite_name] = [ _rectangle ]
				}
				_rectangle_index ++
			}
		}
		
		if (variable_struct_get_names(_sprite_data) != 0 && !array_contains(_texture_pages, _sprite_data)) {
			array_push(_texture_pages, _sprite_data)
		}
		
		file_write("texture_pages.json", json_stringify(_texture_pages, true))
		
		return _texture_pages
	}
	
	static write_texturegroup_info_and_textures = function(_texture_pages, _sprite_prefix = undefined) {
		var _grid_width = compactor_texturepage_width,
			_grid_height = compactor_texturepage_height,
			
			_surface = surface_create(_grid_width, _grid_height),
			
			_texture_page_count = array_length(_texture_pages),
			
			_texturegroup_textures = [],
			_texturegroup_sprite_data = {}
		
		#macro debug_render_custom_texturepage_backgrounds false
		#macro debug_texture_text_scale 1
		
		for(var _texturepage_index = 0; _texturepage_index < _texture_page_count; ++_texturepage_index) {
			surface_set_target(_surface)
			draw_clear_alpha(c_black, 0)
			
			// 资源包透明度修复
			// bm_normal 往 surface 上画时，颜色通道会被乘以 alpha（得到预乘颜色），
			// 而 PNG 格式的约定是直通 alpha。这种「预乘颜色 + 直通 alpha」的纹理页
			// 被 surface_save 写出、再作为纹理页绘制时，颜色会被二次乘以 alpha，
			// 导致半透明像素严重变暗甚至近乎消失，且 alpha 越低损失越严重。
			// 纹理页内各精灵互不重叠、surface 已 clear 为 (0,0,0,0)，
			// 所以这里改用纯拷贝混合（src=one, dst=zero），让 surface 存下精确的直通 RGBA。
			gpu_set_blendmode_ext_sepalpha(bm_one, bm_zero, bm_one, bm_zero)
			
			var _texturepage_sprites = _texture_pages[_texturepage_index],
				_keys = variable_struct_get_names(_texturepage_sprites)
			
			for(var i = array_length(_keys) - 1; i >= 0; --i) {
				var _key = _keys[i],
					
					_sprite_name = (is_string(_sprite_prefix) ? ($"{_sprite_prefix}{_key}") : _key),
					
					_frames = _texturepage_sprites[$ _key],
					
					_frame_count = array_length(_frames),
					
					_sprite_frames;
				
				if (variable_struct_exists(_texturegroup_sprite_data, _sprite_name)) {
					_sprite_frames = _texturegroup_sprite_data[$ _sprite_name].frames
				}
				else {
					// 数组按「精灵总帧数」建（原按「本页帧数」建，
					// 跨页精灵会出现越界扩展/丢帧）。image_number 即替换时的总帧数。
					var _total_frames = _frames[0].image_number
					_sprite_frames = array_create(max(_total_frames, _frame_count), undefined)
				}
				
				for(var j = _frame_count - 1; j >= 0; --j) {
					var _frame = _frames[j], _sprite = _frame.sprite;
					
					if (debug_render_custom_texturepage_backgrounds) {
						draw_set_color(_frame.image_blend)
						draw_rectangle(_frame.x, _frame.y, _frame.x + _frame.width, _frame.y + _frame.height, !_frame.is_sorted)
						
						draw_set_color(c_black)
						draw_text_transformed(_frame.x + 4, _frame.y + 3, _sprite_name, debug_texture_text_scale, debug_texture_text_scale, 0)
						draw_text_transformed(_frame.x + 4, _frame.y + 4, _sprite_name, debug_texture_text_scale, debug_texture_text_scale, 0)
						
						draw_set_color(c_white)
						draw_text_transformed(_frame.x + 3, _frame.y + 3, _sprite_name, debug_texture_text_scale, debug_texture_text_scale, 0)
					}
					
					draw_sprite(_sprite, _frame.image_index,
								
								_frame.x + sprite_get_xoffset(_sprite),
								_frame.y + sprite_get_yoffset(_sprite))
					
					_sprite_frames[_frame.image_index] = _frame.to_frame_entry(_texturepage_index)
				}
				
				// 写入门控放宽：原「首帧必须有效」会把跨页/首帧
				// 缺失的精灵整只跳过（数据装配类丢失）。改为「任一帧有效即写」，宽高取
				// 首个有效帧；后续页面继续合并，跨页精灵最终完整。
				var _first_valid = undefined
				for (var _fi = 0; _fi < array_length(_sprite_frames); _fi ++) {
					if (!is_undefined(_sprite_frames[_fi])) {
						_first_valid = _sprite_frames[_fi]
						break
					}
				}
				
				if (!is_undefined(_first_valid)) {
					variable_struct_set(_texturegroup_sprite_data, _sprite_name,
						{
							"width": _first_valid.w,
							"height": _first_valid.h,
							"frames": _sprite_frames
						})
				}
			}
			
			// 恢复默认混合模式，避免影响后续绘制
			gpu_set_blendmode(bm_normal)
			
			surface_reset_target()
			
			var _texture_name = $"texturepage_{_texturepage_index}.png"
			array_push(_texturegroup_textures, _texture_name)
			surface_save(_surface, _texture_name)
		}
		
		surface_free(_surface)
		
		return {
			textures: _texturegroup_textures,
			sprite_data: _texturegroup_sprite_data
		}
	}
}

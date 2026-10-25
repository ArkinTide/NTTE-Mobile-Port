/// @description scrDrawRoadmap(x,y,pos)
/// @param x
/// @param y
/// @param pos
function scrDrawRoadmap(_drawx, _drawy, _pos) {
	var _segment_length = 9,
		_start_area = area_desert,
		_total_map_size = 0
	
	// draw run mini stats
	draw_set_color(c_white)
	draw_align(fa_left, fa_middle)
	
	draw_sprite(sprScoreSplat, 2, _drawx - 68, _drawy - 15)
	draw_sprite(sprScoreSplat, 2, _drawx +  8, _drawy - 15)
	draw_sprite(sprKillsIcon,  0, _drawx + 14, _drawy - 15)
	
	var _area_name = scrAreaGetMapName(
			GameCont.area,
			GameCont.subarea,
			GameCont.loops)
	
	draw_text_nt(_drawx - 60, _drawy - 14, _area_name)
	draw_text_nt(_drawx + 23, _drawy - 14, string(GameCont.kills))
	
	draw_set_color(c_white)
	draw_align()
	
	// calc total map width
	for(var _area = _start_area; _area <= area_palace; ++_area) {
		_total_map_size += scrAreaGetMaxSubarea(_area) * _segment_length
	}
	_drawx -= (_total_map_size div 2)
	
	// map background
	var _map_x = _drawx,
		_map_y = _drawy
	
	for(var _area = _start_area; _area <= area_palace; ++_area) {
		var _px = _map_x, _py = _map_y
		
		draw_sprite_ext(sprMapDot, 0, _px + 0, _py + 2, 1, 1, 0, c_black, 1)
		draw_sprite_ext(sprMapDot, 0, _px + 1, _py + 2, 1, 1, 0, c_black, 1)
		draw_sprite_ext(sprMapDot, 0, _px + 1, _py + 1, 1, 1, 0, c_black, 1)
		
		_map_x += scrAreaGetMaxSubarea(_area) * _segment_length
		
		draw_line_pixelated(_px + 0, _py + 1, _map_x + 0, _map_y + 1, c_black, 1)
		draw_line_pixelated(_px + 1, _py + 0, _map_x + 1, _map_y + 0, c_black, 1)
		draw_line_pixelated(_px + 1, _py + 1, _map_x + 1, _map_y + 1, c_black, 1)
		draw_line_pixelated(_px + 1, _py, _map_x, _map_y, c_white, 1)
		
		if (_area == area_palace) {
			draw_sprite_ext(sprMapCrown, 0, _map_x - 3, _map_y + 1, 1, 1, 0, c_white, 1)
			if (scrAreaGetMaxSubarea(_area) <= 1) {
				break
			}
			draw_sprite_ext(sprPixel, 0, _map_x - 8, _map_y + 1, 1, 1, 0, c_black, 1)
		}
		
		draw_sprite_ext(sprMapDot, 0, _px, _py + 1, 1, 1, 0, c_white, 1)
	}
	
	// NTTE original custom-area/Red warp history geometry.
    var _roadmap=scrNTTEFullRoadmapDraw(_drawx,_drawy,_pos),_map_x=_roadmap[0],_map_y=_roadmap[1];
    draw_set_color(c_white);

	static _perplayer_offsets = [
		[-3, -3],
		[ 3,  3],
		[ 3, -3],
		[-3,  3]
	]
	
	for (var i = 0; i < player_count; ++i) {
		var _pinst = scr_playerinstance_find(i)
		if is_undefined(_pinst) continue

		var _sprite = scrNTTEFullSkinMenuSprite(_pinst.get_race(),_pinst.get_skin(),sprMapIcon),
			_image = scr_race_get_skin_subimage(
				_pinst.get_race(), _pinst.get_skin()),
			
			_xoff = 0,
			_yoff = 0

		if player_count > 1 {
			_xoff = _perplayer_offsets[i, 0]
			_yoff = _perplayer_offsets[i, 1]
		}
		
		if (_pinst.is_race(Race.Chicken) && _pinst.hp <= 0) {
			_sprite = sprMapIconChickenHeadless
			_image = _pinst.get_skin()
		}
		else if (_pinst.is_race(Race.Rebel)
			&& _pinst.get_skin() == SkinLetter.B
			&& GameCont.area == area_city
		) {
			_sprite = sprMapIconRebelBHooded
			_image = 0
		}
		
		draw_sprite(_sprite, _image, _map_x + _xoff, _map_y + _yoff)
        scrNTTEFullPetMapDraw(i,_map_x,_map_y)
	}
}

function draw_line_pixelated(_x1, _y1, _x2, _y2, _color, _alpha) {
	var _distance = point_distance(_x1, _y1, _x2, _y2),
		_direction = point_direction(_x1, _y1, _x2, _y2)
	
	if (_direction >= 90 && _direction < 270) {
		_y1 += 2
		_y2 += 2
	}
	else {
		_y1 ++
		_y2 ++
	}
	
	draw_sprite_ext(sprPixel, 0, _x1, _y1, _distance, 1, _direction, _color, _alpha)
}
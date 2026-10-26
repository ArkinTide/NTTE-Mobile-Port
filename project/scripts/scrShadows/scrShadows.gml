// Clip the reflected wall artwork to real floor footprints. A single point
// below a wall cannot describe the exposed corners of a Pizza room.
// Reuse one collision list for the pass; no additional surfaces or readbacks.
function scrNTTEFullPizzaWallShadowDraw(_vx,_vy,_floors) {
	if(!sprite_exists(outspr)) return;
	var _sw=sprite_get_width(outspr),_sh=sprite_get_height(outspr),
		_left=x-sprite_get_xoffset(outspr),
		_bottom=y+18+sprite_get_yoffset(outspr),_top=_bottom-_sh;
	ds_list_clear(_floors);
	collision_rectangle_list(_left,_top,_left+_sw-0.001,_bottom-0.001,Floor,false,true,_floors,false);
	collision_rectangle_list(_left,_top,_left+_sw-0.001,_bottom-0.001,FloorExplo,false,true,_floors,false);
	for(var _j=0;_j<ds_list_size(_floors);++_j) {
		var _floor=_floors[| _j],_x1=max(_left,_floor.bbox_left),_y1=max(_top,_floor.bbox_top),
			_x2=min(_left+_sw,_floor.bbox_right),_y2=min(_bottom,_floor.bbox_bottom);
		if(_x2>_x1 && _y2>_y1)
			draw_sprite_part_ext(outspr,outindex,_x1-_left,_bottom-_y2,_x2-_x1,_y2-_y1,
				_x1-_vx,_y2-_vy,1,-1,c_black,1);
	}
}

function scrShadows() {
	//shadow works

	if instance_exists(GenCont) exit

	if !surface_exists(shad) {
		shad = surface_create(view_width, view_height)
		if(!scrNTTEFullIOSShadowSourceTarget(shad,"recreate")) exit
		draw_clear_alpha(c_black, 0)
		surface_reset_target()
	}

	if(!scrNTTEFullIOSShadowSourceTarget(shad,"populate")) exit
	draw_clear_alpha(c_black, 0)
	
	var _xview = view_xview, _yview = view_yview
	
	#region Walls
	
	var _list = global.lis_walls_visible,
		_count = ds_list_size(_list),
		_pizza = GameCont.area==scrNTTEFullAreaId("pizza"),
		_floors = _pizza ? ds_list_create() : -1;
		
	try {
		for (var i = _count - 1; i >= 0; --i) {
			with _list[| i] {
				if !position_meeting(x, y + 16, TopSmall) {
					if(_pizza) scrNTTEFullPizzaWallShadowDraw(_xview,_yview,_floors);
					else if(sprite_exists(outspr)) draw_sprite_ext(outspr, outindex, x - _xview, y + 2 + 16 - _yview, 1, -1, 0, c_black, 1);
				}
			}
		}
	} finally {if(_pizza) ds_list_destroy(_floors);}
	
	#endregion
	
	with CrownObject {
		if (visible) draw_sprite(shd16, 0, x - _xview, y - _yview + 3)
	}
		
	with CrownPickup {
		draw_sprite(shd16, 0, x - _xview, y - _yview + 3)
	}
		
	with CarThrow {
		draw_sprite(shd32, 0, x - _xview, y - _yview)
	}
		
	with CampChar {
		if (sprite_exists(spr_shadow)) draw_sprite(spr_shadow, 0, x - _xview, y - _yview)
	}
	
	with chestprop {
		if (sprite_exists(spr_shadow)) draw_sprite(spr_shadow, 0, x - _xview + spr_shadow_x, y - _yview + spr_shadow_y)
	}
	
	with BigWeaponChest {
		draw_sprite(shd32, 0, x - _xview, y - _yview)
	}
	
	with SnowBotCar {
		draw_sprite(shd32, 0, x - _xview, y - _yview)
	}
	
	with BigDogExplo {
		draw_sprite(shd96, 0, x - _xview, y - _yview)
	}
	
	with CrystalShield {
		if (image_speed == 0) draw_sprite(shd64, 0, x - _xview, y - _yview + 2)
	}

	with hitme {
		if (visible && sprite_exists(spr_shadow)) draw_sprite(spr_shadow, 0, x - _xview + spr_shadow_x, y - _yview + spr_shadow_y)
	}

	with LilHunterFly {
		if (sprite_exists(spr_shadow)) draw_sprite(spr_shadow, 0, x - _xview + spr_shadow_x, y - _yview + spr_shadow_y)
	}
		
	with Yeti {
		if sprite_index != sprYetiBurrowed
		&& (sprite_index != sprYetiAppear || image_index >= 5)
		&& (sprite_index != sprYetiDisappear || image_index < 3) {
			draw_sprite(shd48, 0, x - _xview, y - _yview)
		}
	}
		
	with SodaCan {
		draw_sprite_ext(shd16, 0, x, bbox_bottom, 0.5, 0.5, 0, c_black, 1)
	}
		
	with RavenFly {
		if (sprite_exists(spr_shadow)) draw_sprite(spr_shadow, 0, x - _xview + spr_shadow_x, y - _yview + spr_shadow_y)
	}
	
	scrNTTEFullThroneIntroShadowDraw(_xview,_yview);
	scrNTTEFullWorldExtraShadowDraw(_xview,_yview);
	surface_reset_target()
}

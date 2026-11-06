/*	                Areas
	This is the Areas package of Lib, for
	generation on area creation and on the fly.
*/

/*
	Scripts:
		#define floor_fill(_x, _y, _w, _h, _type)
		#define area_generate(_area, _subarea, _loops, _x, _y, _setArea, _overlapFloor, _scrSetup)
		#define area_set(_area, _subarea, _loops)
		#define area_get_name(_area, _subarea, _loops)
		#define area_get_subarea(_area)
		#define area_get_secret(_area)
		#define area_get_underwater(_area)
		#define area_get_back_color(_area)
		#define area_get_shad_color(_area)
		#define area_get_sprite(_area, _spr)
		#define floor_walls()
		#define floor_bones(_num, _chance, _linked)
		#define floor_set_style(_style, _area)
		#define floor_reset_style()
		#define floor_set_align(_alignX, _alignY, _alignW, _alignH)
		#define floor_reset_align()
		#define floor_align(_x, _y, _w, _h, _type)
		#define floor_align_round(_num, _precision, _bias)
		#define floor_set(_x, _y, _state)
		#define floor_delete(_x1, _y1, _x2, _y2)
		#define floor_tunnel(_x1, _y1, _x2, _y2)
		#define floor_room_start(_spawnX, _spawnY, _spawnDis, _spawnFloor)
		#define floor_room_create(_x, _y, _w, _h, _type, _dirStart, _dirOff, _floorDis)
		#define floor_room(_spawnX, _spawnY, _spawnDis, _spawnFloor, _w, _h, _type, _dirOff, _floorDis)
		#define wall_clear(_x, _y)
		#define wall_delete(_x1, _y1, _x2, _y2)
		#define wall_tops()
		#define wall_update(_x1, _y1, _x2, _y2)
*/

//For internal use, adds the script to be easily usable.
#define addScript(name)
	lq_set(instances_matching(CustomObject, "name", "libGlobal")[0].scriptReferences, name, ["mod", mod_current, name]);

#define init
	//macros for calling functions easier
	#macro scr global.scr
	#macro call script_ref_call
	//Other macros
	#macro area_campfire     0
	#macro area_desert       1
	#macro area_sewers       2
	#macro area_scrapyards   3
	#macro area_caves        4
	#macro area_city         5
	#macro area_labs         6
	#macro area_palace       7
	#macro area_vault        100
	#macro area_oasis        101
	#macro area_pizza_sewers 102
	#macro area_mansion      103
	#macro area_cursed_caves 104
	#macro area_jungle       105
	#macro area_hq           106
	#macro area_crib         107

	#macro infinity 1/0

	#macro mod_current_type script_ref_create(0)[0]

	#macro instance_max instance_create(0, 0, DramaCamera)

	#macro current_frame_active ((current_frame % 1) < current_time_scale)

	#macro anim_end (image_index + image_speed_raw >= image_number || image_index + image_speed_raw < 0)

	#macro bbox_center_x (bbox_left + bbox_right + 1) / 2
	#macro bbox_center_y (bbox_top + bbox_bottom + 1) / 2
	#macro bbox_width    (bbox_right  + 1) - bbox_left
	#macro bbox_height   (bbox_bottom + 1) - bbox_top

	#macro FloorNormal instances_matching(Floor, "object_index", Floor)
	
	addScript("floor_fill");
	addScript("area_generate");
	addScript("area_set");
	addScript("area_get_name");
	addScript("area_get_subarea");
	addScript("area_get_secret");
	addScript("area_get_underwater");
	addScript("area_get_back_color");
	addScript("area_get_shad_color");
	addScript("area_get_sprite");
	addScript("floor_walls");
	addScript("floor_bones");
	addScript("floor_set_style");
	addScript("floor_reset_style");
	addScript("floor_set_align");
	addScript("floor_reset_align");
	addScript("floor_align");
	addScript("floor_align_round");
	addScript("floor_set");
	addScript("floor_delete");
	addScript("floor_tunnel");
	addScript("floor_room_start");
	addScript("floor_room_create");
	addScript("floor_room");
	addScript("wall_clear");
	addScript("wall_delete");
	addScript("wall_tops");
	addScript("wall_update");
	script_ref_call(["mod", "lib", "updateRef"]);
	global.isLoaded = true;
	script_ref_call(["mod", "lib", "getRef"], "mod", mod_current, "scr");
	
	//Setup functions for this module
	floor_reset_style();
	floor_reset_align();
	
#define floor_fill(_x, _y, _w, _h, _type)
	/*
		Creates a rectangular area of floors around the given position
		The type can be "" for default, "round" for no corners, or "ring" for no inner floors
		
		Ex:
			floor_fill(x, y, 3, 3, "")
				###
				###
				###
				
			floor_fill(x, y, 5, 4, "round")
				 ###
				#####
				#####
				 ###
				 
			floor_fill(x, y, 4, 4, "ring")
				####
				#  #
				#  #
				####
	*/
	
	var	_ow = 32,
		_oh = 32;
		
	_w *= _ow;
	_h *= _oh;
	
	 // Center & Align:
	_x -= (_w / 2);
	_y -= (_h / 2);
	var _gridPos = floor_align(_x, _y, _w, _h, _type);
	_x = _gridPos[0];
	_y = _gridPos[1];
	
	 // Floors:
	var	_ax   = global.floor_align_x,
		_ay   = global.floor_align_y,
		_aw   = global.floor_align_w,
		_ah   = global.floor_align_h,
		_inst = [];
		
	floor_set_align(_x, _y, _ow, _oh);
	
	for(var _oy = 0; _oy < _h; _oy += _oh){
		for(var _ox = 0; _ox < _w; _ox += _ow){
			var _make = true;
			
			 // Type-Specific:
			switch(_type){
				case "round": // No Corner Floors
					_make = ((_ox != 0 && _ox != _w - _ow) || (_oy != 0 && _oy != _h - _oh));
					break;
					
				case "ring": // No Inner Floors
					_make = (_ox == 0 || _oy == 0 || _ox == _w - _ow || _oy == _h - _oh);
					break;
			}
			
			if(_make){
				array_push(_inst, floor_set(_x + _ox, _y + _oy, true));
			}
		}
	}
	
	floor_set_align(_ax, _ay, _aw, _ah);
	
	return _inst;
	
#define area_generate(_area, _subarea, _loops, _x, _y, _setArea, _overlapFloor, _scrSetup)
	/*
		Deactivates the game, generates a given area, and reactivates the game
		Returns the ID of the GenCont used to create the area, or null if the area couldn't be generated
		
		Args:
			area/subarea/loops - Area to generate
			x/y                - Spawn position
			setArea            - Set the current area to the generated area
			                       True  : Sets the area, background_color, BackCont vars, TopCont vars, and calls .mod level_start scripts
			                       False : Maintains the current area and deletes new IDPD spawns
			overlapFloor       - Number 0 to 1, determines the percent of current level floors that can be overlapped
			scrSetup           - Script reference, called right before floor generation
			
		Ex:
			var _genID = area_generate(area_scrapyards, 3, GameCont.loops, x, y, false, 0, null);
			with(instances_matching_gt(chestprop, "id", _genID)){
				instance_delete(self);
			}
	*/
	
	if(is_real(_area) || is_string(_area)){
		var	_lastArea            = GameCont.area,
			_lastSubarea         = GameCont.subarea,
			_lastLoops           = GameCont.loops,
			_lastBackgroundColor = background_color,
			_lastLetterbox       = game_letterbox,
			_lastViewObj         = [],
			_lastViewPan         = [],
			_lastViewShk         = [],
			_lastObjVars         = [],
			_lastSolid           = [];
			
		 // Remember Stuff:
		for(var i = 0; i < maxp; i++){
			_lastViewObj[i] = view_object[i];
			_lastViewPan[i] = view_pan_factor[i];
			_lastViewShk[i] = view_shake[i];
		}
		with([BackCont, TopCont]){
			var	_obj  = self,
				_vars = [];
				
			with(variable_instance_get_names(_obj)){
				if(array_find_index(["id", "object_index", "bbox_bottom", "bbox_top", "bbox_right", "bbox_left", "image_number", "sprite_yoffset", "sprite_xoffset", "sprite_height", "sprite_width"], self) < 0){
					array_push(_vars, [self, variable_instance_get(_obj, self)]);
				}
			}
			array_push(_lastObjVars, [_obj, _vars]);
		}
		
		 // Fix Ghost Collision:
		with(instances_matching(all, "solid", true)){
			solid = false;
			array_push(_lastSolid, self);
		}
		
		 // Clamp to Grid:
		with(call(scr.instance_nearest_bbox, _x, _y, Floor)){
			_x = x + call(scr.pfloor, _x - x, 16);
			_y = y + call(scr.pfloor, _y - y, 16);
		}
		
		 // Floor Overlap Fixing:
		var	_overlapFloorBBox = [],
			_overlapFloorFill = [];
			
		if(_overlapFloor < 1){
			var	_floor = FloorNormal,
				_num = array_length(_floor) * (1 - _overlapFloor);
				
			with(call(scr.array_shuffle, _floor)){
				if(_num-- > 0){
					array_push(_overlapFloorBBox, [bbox_left, bbox_top, bbox_right, bbox_bottom]);
				}
				else break;
			}
		}
		
		 // No Duplicates:
		with(BackCont) with(self){
			event_perform(ev_other, ev_room_end);
			instance_destroy();
		}
		with(TopCont) with(self){
			darkness = true;
			event_perform(ev_other, ev_room_end);
			instance_destroy();
		}
		with(SubTopCont){
			instance_destroy();
		}
		
		 // Deactivate Objects:
		call(scr.game_deactivate);
		
		 // No Boss Death Music:
		if(_setArea){
			with(MusCont){
				alarm_set(3, -1);
			}
		}
		
		 // Generate Level:
		GameCont.area    = _area;
		GameCont.subarea = _subarea;
		GameCont.loops   = _loops;
		var _genID = instance_create(0, 0, GenCont);
		with(_genID) with(self){
			var	_ox = (_x - 10016),
				_oy = (_y - 10016);
				
			 // Music:
			if(_setArea){
				with(MusCont){
					alarm_set(11, 1);
				}
			}
			
			 // Delete Loading Spirals:
			with(SpiralCont  ) instance_destroy();
			with(Spiral      ) instance_destroy();
			with(SpiralStar  ) instance_destroy();
			with(SpiralDebris) instance_destroy(); // *might play a 0.1 pitched sound
			
			 // Custom Code:
			if(is_array(_scrSetup)){
				script_ref_call(_scrSetup);
			}
			
			 // Floors:
			var	_tries    = 100,
				_floorNum = 0;
				
			while(instance_exists(FloorMaker) && _tries-- > 0){
				with(FloorMaker){
					xprevious = x;
					yprevious = y;
					event_perform(ev_step, ev_step_normal);
				}
				if(instance_number(Floor) > _floorNum){
					_floorNum = instance_number(Floor);
					_tries    = 300;
				}
			}
			with(FloorMaker){
				instance_destroy();
			}
			
			 // Safe Spawns & Misc:
			event_perform(ev_alarm, 2);
			
			 // Remove Overlapping Floors:
			with(_overlapFloorBBox){
				var	_x1 = self[0] - _ox,
					_y1 = self[1] - _oy,
					_x2 = self[2] - _ox,
					_y2 = self[3] - _oy;
					
				with(call(scr.instance_rectangle_bbox, _x1, _y1, _x2, _y2, Floor)){
					array_push(_overlapFloorFill, [bbox_left + _ox, bbox_top + _oy, bbox_right + _ox, bbox_bottom + _oy]);
					instance_destroy();
				}
				with(call(scr.instance_rectangle_bbox, _x1, _y1, _x2, _y2, SnowFloor)){
					if(point_in_rectangle(bbox_center_x, bbox_center_y, _x1, _y1, _x2 + 1, _y2 + 1)){
						instance_destroy();
					}
				}
				with(call(scr.instance_rectangle_bbox, _x1, _y1, _x2, _y2, [chestprop, RadChest])){
					instance_delete(self);
				}
			}
			
			 // Populate Level:
			with(KeyCont) with(self){
				event_perform(ev_create, 0); // reset player counter
			}
			event_perform(ev_alarm, 0);
			if(!_setArea){
				with(WantPopo) instance_delete(self);
				with(WantVan ) instance_delete(self);
			}
			var _clearID = instance_max;
			event_perform(ev_alarm, 1);
			
			 // Player Reset:
			if(game_letterbox == false){
				game_letterbox = _lastLetterbox;
			}
			for(var i = 0; i < maxp; i++){
				if(view_object[i]     == noone) view_object[i]     = _lastViewObj[i];
				if(view_pan_factor[i] == null ) view_pan_factor[i] = _lastViewPan[i];
				if(view_shake[i]      == 0    ) view_shake[i]      = _lastViewShk[i];
				
				with(instances_matching(Player, "index", i)){
					 // Fix View:
					var	_vx1   = x - (game_width / 2),
						_vy1   = y - (game_height / 2),
						_vx2   = view_xview[i],
						_vy2   = view_yview[i],
						_shake = UberCont.opt_shake;
						
					UberCont.opt_shake = 1;
					gunangle = point_direction(_vx1, _vy1, _vx2, _vy2);
					weapon_post(0, point_distance(_vx1, _vy1, _vx2, _vy2), 0);
					UberCont.opt_shake = _shake;
					
					 // Delete:
					repeat(4) with(instance_nearest(x, y, PortalL)){
						instance_destroy();
					}
					instance_delete(self);
					break;
				}
			}
			with(instances_matching_gt(PortalClear, "id", _clearID)){
				instance_destroy();
			}
			
			 // Move Objects:
			with(instances_matching_ne(instances_matching_ne(instances_matching_gt(all, "id", _genID), "x", null), "y", null)){
				if(x != 0 || y != 0){
					x         += _ox;
					y         += _oy;
					xprevious += _ox;
					yprevious += _oy;
					xstart    += _ox;
					ystart    += _oy;
				}
			}
		}
		
		 // Call Funny Mod Scripts:
		if(_setArea){
			with(mod_get_names("mod")){
				try{
					mod_script_call_nc("mod", self, "level_start");
				}
				catch(_error){
					trace(_error);
				}
			}
		}
		
		 // Reactivate Objects:
		call(scr.game_activate);
		with(_lastSolid){
			solid = true;
		}
		
		 // Overlap Fixes:
		var	_overlapObject = [Floor, Wall, InvisiWall, TopSmall, TopPot, Bones],
			_overlapObj    = array_clone(_overlapObject);
			
		while(array_length(_overlapObj)){
			var _obj = _overlapObj[0];
			
			 // New Overwriting Old:
			var _objNew = instances_matching_gt(_obj, "id", _genID);
			with(instances_matching_lt(_overlapObj, "id", _genID)){
				if(place_meeting(x, y, _obj) && array_length(call(scr.instances_meeting, x, y, _objNew))){
					if(object_index == Floor){
						array_push(_overlapFloorFill, [bbox_left, bbox_top, bbox_right, bbox_bottom]);
					}
					instance_delete(self);
				}
			}
			
			 // Advance:
			_overlapObj = array_slice(_overlapObj, 1, array_length(_overlapObj) - 1);
			
			 // Old Overwriting New:
			var _objOld = instances_matching_lt(_obj, "id", _genID);
			with(instances_matching_gt(_overlapObj, "id", _genID)){
				if(place_meeting(x, y, _obj) && array_length(call(scr.instances_meeting, x, y, _objOld))){
					instance_delete(self);
				}
			}
		}
		var _wallOld = instances_matching_lt(Wall, "id", _genID);
		with(instances_matching_lt(hitme, "id", _genID)){
			if(place_meeting(x, y, Wall) && !array_length(call(scr.instances_meeting, x, y, _wallOld))){
				wall_clear(x, y);
			}
		}
		
		 // Fill Gaps:
		with(_overlapFloorFill){
			var	_x1 = self[0],
				_y1 = self[1],
				_x2 = self[2] + 1,
				_y2 = self[3] + 1;
				
			with(other){
				for(var _fx = _x1; _fx < _x2; _fx += 16){
					for(var _fy = _y1; _fy < _y2; _fy += 16){
						if(!position_meeting(_fx, _fy, Floor)){
							with(instance_create(_fx, _fy, FloorExplo)){
								with(call(scr.instances_meeting, x, y, _overlapObject)){
									instance_delete(self);
								}
							}
						}
					}
				}
			}
		}
		
		 // Reset Area:
		if(!_setArea){
			GameCont.area    = _lastArea;
			GameCont.subarea = _lastSubarea;
			GameCont.loops   = _lastLoops;
			background_color = _lastBackgroundColor;
			with(_lastObjVars){
				var	_obj  = self[0],
					_vars = self[1];
					
				with(_obj){
					with(_vars){
						variable_instance_set(other, self[0], self[1]);
					}
				}
			}
		}
		with(_lastObjVars){
			var	_obj  = self[0],
				_vars = self[1];
				
			if(_obj == TopCont){
				with(_vars){
					if(self[0] == "fogscroll"){
						with(_obj){
							variable_instance_set(self, other[0], other[1]);
						}
						break;
					}
				}
			}
		}
		
		return _genID;
	}
	
	return null;
	
#define area_set(_area, _subarea, _loops)
	/*
		Sets the area and remembers the last non-secret area
		Also turns Crystal Caves into Cursed Crystal Caves if a Player has a cursed weapon
	*/
	
	with(GameCont){
		 // Remember:
		if(!area_get_secret(area)){
			lastarea    = area;
			lastsubarea = subarea;
		}
		
		 // Set Area:
		area    = _area;
		subarea = _subarea;
		loops   = _loops;
		
		 // Cursed:
		if(area == area_caves){
			with(Player) if(curse > 0 || bcurse > 0){
				other.area = area_cursed_caves;
				break;
			}
		}
	}
	
#define area_get_name(_area, _subarea, _loops)
	/*
		Returns the given area's name as it would appear on the map
	*/
	
	var _name = [_area, "-", _subarea];
	
	 // Custom Area:
	if(is_string(_area)){
		_name = ["MOD"];
		if(mod_script_exists("area", _area, "area_name")){
			var _custom = mod_script_call("area", _area, "area_name", _subarea, _loops);
			if(is_string(_custom)){
				_name = [_custom];
			}
		}else{
			_name = [_area, "-", _subarea];
		}
	}
	
	 // Secret Area:
	else if(area_get_secret(_area)){
		switch(_area){
			case area_vault : _name = ["???"];             break;
			case area_hq    : _name = ["HQ", _subarea];    break;
			case area_crib  : _name = ["$$$"];             break;
			default         : _name = [_area - 100, "-?"];
		}
	}
	
	 // Victory:
	if(GameCont.win == true){
		if(_area == area_palace || _area == area_hq){
			_name = ["END", (area_get_secret(_area) ? 2 : 1)];
		}
	}
	
	 // Loop:
	if(real(_loops) > 0){
		array_push(_name, " " + ((UberCont.hardmode == true) ? "H" : "L"));
		array_push(_name, _loops);
	}
	
	 // Compile Name:
	var _text = "";
	with(_name){
		_text += (
			(is_real(self) && frac(self) != 0)
			? string_format(self, 0, 2)
			: string(self)
		);
	}
	
	return _text;
	
#define area_get_subarea(_area)
	/*
		Returns how many subareas are in the given area
	*/
	
	 // Custom Area:
	if(is_string(_area)){
		var _scrt = "area_subarea";
		if(mod_script_exists("area", _area, _scrt)){
			return mod_script_call("area", _area, _scrt);
		}else{
			trace(_area + " does not have " + _scrt);
			return 3;
		}
	}
	
	 // Normal Area:
	else if(is_real(_area)){
		 // Secret Areas:
		if(_area == area_hq) return 3;
		if(_area >= 100) return 1;
		
		 // Transition Area:
		if((_area % 2) == 0) return 1;
		
		return 3;
	}
	
	return 1;
	
#define area_get_secret(_area)
	/*
		Returns whether or not an area is secret
		
		Means the area:
			Is not returned to from other secret areas like Crib, IDPD HQ, Crown Vault, etc.
			Has no Proto Statues
			Doesn't spawn IDPD on new Crowns
			Doesn't create rad canisters when below the desired amount
			..?
	*/
	
	 // Custom Area:
	if(is_string(_area)){
		var _scrt = "area_secret";
		if(mod_script_exists("area", _area, _scrt)){
			return mod_script_call("area", _area, _scrt);
		}else{
			trace(_area + " does not have " + _scrt);
			return 0;
		}
	}
	
	 // Normal Area:
	else if(is_real(_area)){
		return (_area >= 100);
	}
	
	return false;
	
#define area_get_underwater(_area)
	/*
		Returns if a given area is underwater, like Oasis
	*/
	
	 // Custom Area:
	if(is_string(_area)){
		var _scrt = "area_underwater";
		if(mod_script_exists("area", _area, _scrt)){
			return mod_script_call("area", _area, _scrt);
		}else{
			trace(_area + " does not have " + _scrt);
			return 0;
		}
	}
	
	 // Normal Area:
	return (_area == area_oasis);
	
#define area_get_back_color(_area)
	/*
		Returns a given area's background color, but also supports custom areas
	*/
	
	 // Custom Area:
	if(is_string(_area)){
		var _scrt = "area_background_color";
		if(mod_script_exists("area", _area, _scrt)){
			return mod_script_call("area", _area, _scrt);
		}else{
			trace(_area + " does not have " + _scrt);
			return c_black;
		}
	}
	
	 // Normal Area:
	return area_get_background_color(_area);
	
#define area_get_shad_color(_area)
	/*
		Return's a given area's shadow color, but also supports custom areas
	*/
	
	 // Custom Area:
	if(is_string(_area)){
		var _scrt = "area_shadow_color";
		if(mod_script_exists("area", _area, _scrt)){
			return mod_script_call("area", _area, _scrt);
		}else{
			trace(_area + " does not have " + _scrt);
			return c_black;
		}
	}
	
	 // Normal Area:
	return area_get_shadow_color(_area);
	
#define area_get_sprite(_area, _spr)
	/*
		Returns a given area's variant of the given sprite
		
		Ex:
			area_get_sprite(area_sewers, sprFloor1) == sprFloor2
			area_get_sprite(area_city, sprDebris1)  == sprDebris5
			area_get_sprite(area_caves, sprBones)   == sprCaveDecal
	*/
	
	 // Store Sprites:
	if(!mod_variable_exists("mod", mod_current, "area_sprite_map")){
		var _map = ds_map_create();
		_map[? 0  ] = [sprFloor0,   sprFloor0,    sprFloor0Explo,   sprWall0Trans,   sprWall0Bot,   sprWall0Out,   sprWall0Top,   sprDebris0,   sprDetail0,   sprNightBones,      sprNightDesertTopDecal];
		_map[? 1  ] = [sprFloor1,   sprFloor1B,   sprFloor1Explo,   sprWall1Trans,   sprWall1Bot,   sprWall1Out,   sprWall1Top,   sprDebris1,   sprDetail1,   sprBones,           sprDesertTopDecal     ];
		_map[? 2  ] = [sprFloor2,   sprFloor2B,   sprFloor2Explo,   sprWall2Trans,   sprWall2Bot,   sprWall2Out,   sprWall2Top,   sprDebris2,   sprDetail2,   sprSewerDecal,      sprTopDecalSewers     ];
		_map[? 3  ] = [sprFloor3,   sprFloor3B,   sprFloor3Explo,   sprWall3Trans,   sprWall3Bot,   sprWall3Out,   sprWall3Top,   sprDebris3,   sprDetail3,   sprScrapDecal,      sprTopDecalScrapyard  ];
		_map[? 4  ] = [sprFloor4,   sprFloor4B,   sprFloor4Explo,   sprWall4Trans,   sprWall4Bot,   sprWall4Out,   sprWall4Top,   sprDebris4,   sprDetail4,   sprCaveDecal,       sprTopDecalCave       ];
		_map[? 5  ] = [sprFloor5,   sprFloor5B,   sprFloor5Explo,   sprWall5Trans,   sprWall5Bot,   sprWall5Out,   sprWall5Top,   sprDebris5,   sprDetail5,   sprIceDecal,        sprTopDecalCity       ];
		_map[? 6  ] = [sprFloor6,   sprFloor6B,   sprFloor6Explo,   sprWall6Trans,   sprWall6Bot,   sprWall6Out,   sprWall6Top,   sprDebris6,   sprDetail6,   -1,                 -1                    ];
		_map[? 7  ] = [sprFloor7,   sprFloor7B,   sprFloor7Explo,   sprWall7Trans,   sprWall7Bot,   sprWall7Out,   sprWall7Top,   sprDebris7,   -1,           -1,                 sprPalaceTopDecal     ];
		_map[? 100] = [sprFloor100, sprFloor100B, sprFloor100Explo, sprWall100Trans, sprWall100Bot, sprWall100Out, sprWall100Top, sprDebris100, -1,           -1,                 -1                    ];
		_map[? 101] = [sprFloor101, sprFloor101B, sprFloor101Explo, sprWall101Trans, sprWall101Bot, sprWall101Out, sprWall101Top, sprDebris101, sprDetail101, sprCoral,           -1                    ];
		_map[? 102] = [sprFloor102, sprFloor102B, sprFloor102Explo, sprWall102Trans, sprWall102Bot, sprWall102Out, sprWall102Top, sprDebris102, sprDetail102, sprPizzaSewerDecal, sprTopDecalPizzaSewers];
		_map[? 103] = [sprFloor103, sprFloor103B, sprFloor103Explo, sprWall103Trans, sprWall103Bot, sprWall103Out, sprWall103Top, sprDebris103, -1,           -1,                 -1                    ];
		_map[? 104] = [sprFloor104, sprFloor104B, sprFloor104Explo, sprWall104Trans, sprWall104Bot, sprWall104Out, sprWall104Top, sprDebris104, sprDetail104, sprInvCaveDecal,    sprTopDecalInvCave    ];
		_map[? 105] = [sprFloor105, sprFloor105B, sprFloor105Explo, sprWall105Trans, sprWall105Bot, sprWall105Out, sprWall105Top, sprDebris105, -1,           sprJungleDecal,     sprTopDecalJungle     ];
		_map[? 106] = [sprFloor106, sprFloor106B, sprFloor106Explo, sprWall106Trans, sprWall106Bot, sprWall106Out, sprWall106Top, sprDebris106, -1,           -1,                 sprTopPot             ];
		_map[? 107] = [sprFloor107, sprFloor107B, sprFloor107Explo, sprWall107Trans, sprWall107Bot, sprWall107Out, sprWall107Top, sprDebris107, -1,           -1,                 -1                    ];
		global.area_sprite_map = _map;
	}
	
	 // Convert to Desert Sprite:
	if(sprite_exists(_spr)){
		with(ds_map_values(global.area_sprite_map)){
			var i = array_find_index(self, _spr);
			if(i >= 0){
				_spr = global.area_sprite_map[? 1][i];
				if(_spr == sprDesertTopDecal) _spr = sprTopPot;
				break;
			}
		}
	}
	
	 // Custom:
	if(is_string(_area)){
		var s = mod_script_call("area", _area, "area_sprite", _spr);
		if(s != 0 && is_real(s)){
			return s;
		}
	}
	
	 // Normal:
	if(ds_map_exists(global.area_sprite_map, _area)){
		var	_list = global.area_sprite_map[? _area],
			i = array_find_index(global.area_sprite_map[? 1], _spr);
			
		if(i >= 0 && i < array_length(_list)){
			return _list[i];
		}
	}
	
	return -1;
	
#define floor_walls()
	var	_x1    = bbox_left   - 16,
		_y1    = bbox_top    - 16,
		_x2    = bbox_right  + 16 + 1,
		_y2    = bbox_bottom + 16 + 1,
		_minID = instance_max;
		
	for(var _x = _x1; _x < _x2; _x += 16){
		for(var _y = _y1; _y < _y2; _y += 16){
			if(_x == _x1 || _y == _y1 || _x == _x2 - 16 || _y == _y2 - 16){
				if(!position_meeting(_x, _y, Floor)){
					instance_create(_x, _y, Wall);
				}
			}
		}
	}
	
	return _minID;

#define floor_bones(_num, _chance, _linked)
	/*
		Checks if the current Floor is a vertical hallway and then creates Bones decals on the Walls left and right of the current Floor
		
		Args:
			num    - How many decals can be made vertically
			chance - Chance to create each decal
			linked - Decal should always spawn with one on the other side, true/false
			
		Ex:
			floor_bones(2, 1,    false) == DESERT / CAMPFIRE
			floor_bones(1, 1/10, true ) == SEWERS / PIZZA SEWERS / JUNGLE
			floor_bones(2, 1/7,  false) == SCRAPYARDS / FROZEN CITY
			floor_bones(2, 1/9,  false) == CRYSTAL CAVES / CURSED CRYSTAL CAVES / OASIS
	*/
	
	var _inst = [];
	
	if(!collision_rectangle(bbox_left - 16, bbox_top, bbox_right + 16, bbox_bottom, Floor, false, true)){
		for(var _y = bbox_top; _y < bbox_bottom + 1; _y += (32 / _num)){
			var _create = true;
			for(var _side = 0; _side <= 1; _side++){
				if(_side == 0 || !_linked){
					_create = (random(1) < _chance);
				}
				if(_create){
					var _x = lerp(bbox_left, bbox_right + 1, _side);
					with(call(scr.obj_create, _x, _y, "WallDecal")){
						image_xscale = ((_side > 0.5) ? -1 : 1);
						array_push(_inst, self);
					}
				}
			}
		}
	}
	
	return _inst;

#define floor_set_style(_style, _area)
	global.floor_style = _style;
	global.floor_area  = _area;
	
#define floor_reset_style()
	floor_set_style(null, null);
	
#define floor_set_align(_alignX, _alignY, _alignW, _alignH)
	global.floor_align_x = _alignX;
	global.floor_align_y = _alignY;
	global.floor_align_w = _alignW;
	global.floor_align_h = _alignH;
	
#define floor_reset_align()
	floor_set_align(null, null, null, null);
	
#define floor_align(_x, _y, _w, _h, _type)
	/*
		Returns the given rectangle's position aligned to the floor grid
		Has a bias towards nearby floors to help prevent the rectangle from being disconnected from the level
	*/
	
	var	_gridXAuto = is_undefined(global.floor_align_x),
		_gridYAuto = is_undefined(global.floor_align_y),
		_gridWAuto = is_undefined(global.floor_align_w),
		_gridHAuto = is_undefined(global.floor_align_h),
		_gridX     = (_gridXAuto ? 10000 : global.floor_align_x),
		_gridY     = (_gridYAuto ? 10000 : global.floor_align_y),
		_gridW     = (_gridWAuto ? 16    : global.floor_align_w),
		_gridH     = (_gridHAuto ? 16    : global.floor_align_h),
		_gridXBias = 0,
		_gridYBias = 0;
		
	if(_gridXAuto || _gridYAuto || _gridWAuto || _gridHAuto){
		if(!instance_exists(FloorMaker)){
			 // Align to Nearest Floor:
			if(_gridXAuto || _gridYAuto){
				with(call(scr.instance_nearest_rectangle_bbox, _x, _y, _x + _w, _y + _h, Floor)){
					if(_gridXAuto){
						_gridX     = x;
						_gridXBias = bbox_center_x - (_x + (_w / 2));
					}
					if(_gridYAuto){
						_gridY     = y;
						_gridYBias = bbox_center_y - (_y + (_h / 2));
					}
				}
			}
			
			 // Align to Largest Colliding Floor:
			var	_fx    = _gridX + floor_align_round(_x - _gridX, _gridW, _gridXBias),
				_fy    = _gridY + floor_align_round(_y - _gridY, _gridH, _gridYBias),
				_fwMax = _gridW,
				_fhMax = _gridH;
				
			with(call(scr.instance_rectangle_bbox, _fx, _fy, _fx + _w - 1, _fy + _h - 1, Floor)){
				var	_fw = bbox_width,
					_fh = bbox_height;
					
				if(_fw >= _fwMax){
					_fwMax = _fw;
					if(_gridWAuto){
						_gridW = _fwMax;
					}
					if(_gridXAuto){
						_gridX     = x;
						_gridXBias = bbox_center_x - (_x + (_w / 2));
					}
				}
				if(_fh >= _fhMax){
					_fhMax = _fh;
					if(_gridHAuto){
						_gridH = _fhMax;
					}
					if(_gridYAuto){
						_gridY     = y;
						_gridYBias = bbox_center_y - (_y + (_h / 2));
					}
				}
			}
			
			 // No Unnecessary Bias:
			if(_gridXBias != 0 || _gridYBias != 0){
				_fx = _gridX + floor_align_round(_x - _gridX, _gridW, 0);
				_fy = _gridY + floor_align_round(_y - _gridY, _gridH, 0);
				if(
					(_type == "round")
					? (
						collision_rectangle(_fx + 32, _fy,     _fx + _w - 32 - 1, _fy + _h - 1,      Floor, false, false) ||
						collision_rectangle(_fx,      _fy + 32, _fx + _w - 1,     _fy + _h - 32 - 1, Floor, false, false)
					)
					: collision_rectangle(_fx, _fy, _fx + _w - 1, _fy + _h - 1, Floor, false, false)
				){
					_gridXBias = 0;
					_gridYBias = 0;
				}
			}
		}
		
		 // FloorMaker:
		else with(instance_nearest(_x + max(0, (_w / 2) - 16), _y + max(0, (_h / 2) - 16), FloorMaker)){
			if(_gridXAuto) _gridX = x;
			if(_gridYAuto) _gridY = y;
			if(_gridWAuto) _gridW = min(_w, 32);
			if(_gridHAuto) _gridH = min(_h, 32);
		}
	}
	
	 // Align:
	return [
		_gridX + floor_align_round(_x - _gridX, _gridW, _gridXBias),
		_gridY + floor_align_round(_y - _gridY, _gridH, _gridYBias)
	];
	
#define floor_align_round(_num, _precision, _bias)
	var _value = _num;
	if(_precision != 0){
		_value /= _precision;
		
		if(_bias < 0){
			_value = floor(_value);
		}
		else if(_bias > 0 || frac(_value) == 0.5){ // No sig-fig rounding
			_value = ceil(_value);
		}
		else{
			_value = round(_value);
		}
		
		_value *= _precision;
	}
	return _value;
	
#define floor_set(_x, _y, _state) // imagine if floors and walls just used a ds_grid bro....
	var _inst = noone;
	
	 // Create Floor:
	if(_state){
		var	_obj = ((_state >= 2) ? FloorExplo : Floor),
			_msk = object_get_mask(_obj),
			_w = ((sprite_get_bbox_right (_msk) + 1) - sprite_get_bbox_left(_msk)),
			_h = ((sprite_get_bbox_bottom(_msk) + 1) - sprite_get_bbox_top (_msk));
			
		 // Align to Adjacent Floors:
		var _gridPos = floor_align(_x, _y, _w, _h, "");
		_x = _gridPos[0];
		_y = _gridPos[1];
		
		 // Clear Floors:
		if(!instance_exists(FloorMaker)){
			if(_obj == FloorExplo){
				with(instances_matching(instances_matching(_obj, "x", _x), "y", _y)){
					instance_delete(self);
				}
			}
			else{
				floor_delete(_x, _y, _x + _w - 1, _y + _h - 1);
			}
		}
		
		 // Auto-Style:
		var	_floormaker = noone,
			_lastArea = GameCont.area;
			
		if(!is_undefined(global.floor_style)){
			GameCont.area = area_campfire;
			with(instance_create(_x, _y, FloorMaker)){
				with(instances_matching_gt(Floor, "id", id)){
					instance_delete(self);
				}
				styleb = global.floor_style;
				_floormaker = self;
			}
			GameCont.area = _lastArea;
		}
		if(!is_undefined(global.floor_area)){
			GameCont.area = global.floor_area;
		}
		
		 // Floorify:
		_inst = instance_create(_x, _y, _obj);
		with(_floormaker) instance_destroy();
		GameCont.area = _lastArea;
		with(_inst){
			if(!instance_exists(FloorMaker)){
				 // Clear Area:
				wall_delete(bbox_left, bbox_top, bbox_right, bbox_bottom);
				
				 // Details:
				if(call(scr.chance, 1, 6)){
					instance_create(random_range(bbox_left, bbox_right + 1), random_range(bbox_top, bbox_bottom + 1), Detail);
				}
			}
			
			 // Wallerize:
			if(instance_exists(Wall)){
				floor_walls();
				wall_update(bbox_left - 16, bbox_top - 16, bbox_right + 16, bbox_bottom + 16);
			}
		}
	}
	
	 // Destroy Floor:
	else with(call(scr.instances_at, _x, _y, Floor)){
		var	_x1 = bbox_left   - 16,
			_y1 = bbox_top    - 16,
			_x2 = bbox_right  + 16,
			_y2 = bbox_bottom + 16;
			
		with(call(scr.instances_meeting, x, y, SnowFloor)){
			if(point_in_rectangle(bbox_center_x, bbox_center_y, other.bbox_left, other.bbox_top, other.bbox_right + 1, other.bbox_bottom + 1)){
				instance_destroy();
			}
		}
		
		instance_destroy();
		
		if(instance_exists(Wall)){
			with(other){
				 // Un-Wall:
				wall_delete(_x1, _y1, _x2, _y2);
				
				 // Re-Wall:
				for(var _fx = _x1; _fx < _x2 + 1; _fx += 16){
					for(var _fy = _y1; _fy < _y2 + 1; _fy += 16){
						if(!position_meeting(_fx, _fy, Floor)){
							if(collision_rectangle(_fx - 16, _fy - 16, _fx + 31, _fy + 31, Floor, false, false)){
								instance_create(_fx, _fy, Wall);
							}
						}
					}
				}
				wall_update(_x1 - 16, _y1 - 16, _x2 + 16, _y2 + 16);
			}
		}
	}
	
	return _inst;
	
#define floor_delete(_x1, _y1, _x2, _y2)
	/*
		Deletes all Floors and Floor-related objects within the given rectangular area
	*/
	
	with(call(scr.instance_rectangle_bbox, _x1, _y1, _x2, _y2, Floor)){
		for(var	_x = bbox_left; _x < bbox_right + 1; _x += 16){
			for(var	_y = bbox_top; _y < bbox_bottom + 1; _y += 16){
				if(
					!rectangle_in_rectangle(_x, _y, _x + 15, _y + 15, _x1, _y1, _x2, _y2)
					&& !collision_rectangle(_x, _y, _x + 15, _y + 15, Floor, false, true)
				){
					var	_shake = UberCont.opt_shake,
						_sleep = UberCont.opt_freeze,
						_sound = sound_play_pitchvol(0, 0, 0);
						
					UberCont.opt_shake  = 0;
					UberCont.opt_freeze = 0;
					
					with(instances_matching_gt(GameObject, "id", instance_create(_x, _y, FloorExplo))){
						instance_delete(self);
					}
					
					UberCont.opt_shake  = _shake;
					UberCont.opt_freeze = _sleep;
					
					for(var i = _sound; audio_is_playing(i); i++){
						sound_stop(i);
					}
				}
			}
		}
		with(call(scr.instance_rectangle, bbox_left, bbox_top, bbox_right + 1, bbox_bottom + 1, Detail)){
			instance_destroy();
		}
		with(call(scr.instances_meeting, x, y, SnowFloor)){
			if(point_in_rectangle(bbox_center_x, bbox_center_y, other.bbox_left, other.bbox_top, other.bbox_right + 1, other.bbox_bottom + 1)){
				instance_destroy();
			}
		}
		instance_destroy();
	}
	
#define floor_tunnel(_x1, _y1, _x2, _y2)
	/*
		Creates and returns a PortalClear that destroys all Walls between two given points, making a FloorExplo tunnel
		Tunnel's height defaults to 32 (image_yscale=16), set its 'image_yscale' to change
	*/
	
	with(instance_create(_x1, _y1, PortalClear)){
		var	_dis = point_distance(x, y, _x2, _y2),
			_dir = point_direction(x, y, _x2, _y2);
			
		sprite_index = sprBoltTrail;
		image_speed  = 16 / _dis;
		image_xscale = _dis;
		image_yscale = 16;
		image_angle  = _dir;
		
		 // Ensure Tunnel:
		if(instance_exists(Wall) && !place_meeting(x, y, Wall) && !place_meeting(x, y, Floor)){
			with(call(scr.instance_nearest_bbox, x, y, Wall)){
				instance_create(x + call(scr.pfloor, other.x - x, 16), y + call(scr.pfloor, other.y - y, 16), Wall);
			}
		}
		
		return self;
	}
	
	return noone;
	
#define floor_room_start(_spawnX, _spawnY, _spawnDis, _spawnFloor)
	/*
		Returns a safe starting x/y and direction to use with 'floor_room_create()'
		Searches through the given Floor tiles for one that is far enough away from the spawn and can be reached from the spawn (no Walls in between)
		
		Args:
			spawnX/spawnY - The spawn point
			spawnDis      - Minimum distance that the starting x/y must be from the spawn point
			spawnFloor    - Potential starting floors to search
			
		Ex:
			with(floor_room_start(10016, 10016, 128, FloorNormal)){
				floor_room_create(x, y, 2, 2, "", direction, [60, 90], 96);
			}
	*/
	
	with(call(scr.array_shuffle, instances_matching_ne(_spawnFloor, "id", null))){
		var	_x = bbox_center_x,
			_y = bbox_center_y;
			
		if(point_distance(_spawnX, _spawnY, _x, _y) >= _spawnDis){
			var _spawnReached = false;
			
			 // Make Sure it Reaches the Spawn Point:
			var _pathWall = [Wall, InvisiWall];
			for(var _fx = bbox_left; _fx < bbox_right + 1; _fx += 16){
				for(var _fy = bbox_top; _fy < bbox_bottom + 1; _fy += 16){
					if(call(scr.path_reaches, call(scr.path_create, _fx + 8, _fy + 8, _spawnX, _spawnY, _pathWall), _spawnX, _spawnY, _pathWall)){
						_spawnReached = true;
						break;
					}
				}
				if(_spawnReached) break;
			}
			
			 // Success bro!
			if(_spawnReached){
				return {
					"x"         : _x,
					"y"         : _y,
					"direction" : point_direction(_spawnX, _spawnY, _x, _y),
					"id"        : id
				};
			}
		}
	}
	
	return noone;
	
#define floor_room_create(_x, _y, _w, _h, _type, _dirStart, _dirOff, _floorDis)
	/*
		Moves toward a given direction until an open space is found, then creates a room based on the width, height, and type
		Rooms will always connect to the level as long as floorDis <= 0 (and the starting x/y is over a floor)
		Rooms will not overlap existing Floors as long as floorDis >= 0 (they can still overlap FloorExplo)
		
		Args:
			x/y      - The point to begin the search for an open space to create the room
			w/h      - Width/height of the room to create
			type     - The type of room to create (see 'floor_fill' script)
			dirStart - The direction to search towards for an open space
			dirOff   - Random directional offset to use while searching towards dirStart
			floorDis - How far from the level to create the room
			           Use 0 to spawn adjacent to the level, >0 to create an isolated room, <0 to overlap the level
			
		Ex:
			floor_room_create(10016, 10016, 5, 3, "round", random(360), 0, 0)
	*/
	
	 // Find Space:
	var	_move       = true,
		_floorAvoid = FloorNormal,
		_dis        = 16,
		_dir        = 0,
		_ow         = (_w * 32) / 2,
		_oh         = (_h * 32) / 2,
		_sx         = _x,
		_sy         = _y;
		
	if(!is_array(_dirOff)){
		_dirOff = [_dirOff];
	}
	while(array_length(_dirOff) < 2){
		array_push(_dirOff, 0);
	}
	
	while(_move){
		var	_x1   = _x - _ow,
			_y1   = _y - _oh,
			_x2   = _x + _ow,
			_y2   = _y + _oh,
			_inst = call(scr.instance_rectangle_bbox, _x1 - _floorDis, _y1 - _floorDis, _x2 + _floorDis - 1, _y2 + _floorDis - 1, _floorAvoid);
			
		 // No Corner Floors:
		if(_type == "round" && _floorDis <= 0){
			with(_inst){
				if((bbox_right < _x1 + 32 || bbox_left >= _x2 - 32) && (bbox_bottom < _y1 + 32 || bbox_top >= _y2 - 32)){
					_inst = call(scr.array_delete_value, _inst, self);
				}
			}
		}
		
		 // Floors in Range:
		_move = false;
		if(array_length(_inst)){
			if(_floorDis <= 0){
				_move = true;
			}
			
			 // Floor Distance Check:
			else with(_inst){
				var	_fx = clamp(_x, bbox_left, bbox_right + 1),
					_fy = clamp(_y, bbox_top, bbox_bottom + 1),
					_fDis = (
						(_type == "round")
						? min(
							point_distance(_fx, _fy, clamp(_fx, _x1 + 32, _x2 - 32), clamp(_fy, _y1,      _y2     )),
							point_distance(_fx, _fy, clamp(_fx, _x1,      _x2     ), clamp(_fy, _y1 + 32, _y2 - 32))
						)
						: point_distance(_fx, _fy, clamp(_fx, _x1, _x2), clamp(_fy, _y1, _y2))
					);
					
				if(_fDis < _floorDis){
					_move = true;
					break;
				}
			}
			
			 // Keep Searching:
			if(_move){
				_dir = call(scr.pround, _dirStart + (random_range(_dirOff[0], _dirOff[1]) * choose(-1, 1)), 90);
				_x += lengthdir_x(_dis, _dir);
				_y += lengthdir_y(_dis, _dir);
			}
		}
	}
	
	 // Create Room:
	var	_floorNumLast = array_length(FloorNormal),
		_floors       = mod_script_call_nc(mod_current_type, mod_current, "floor_fill", _x, _y, _w, _h, _type),
		_floorNum     = array_length(FloorNormal),
		_x1           = _x,
		_y1           = _y,
		_x2           = _x,
		_y2           = _y;
		
	if(array_length(_floors)){
		with(_floors[0]){
			_x1 = bbox_left;
			_y1 = bbox_top;
			_x2 = bbox_right  + 1;
			_y2 = bbox_bottom + 1;
		}
		with(_floors){
			var	_fx1 = bbox_left,
				_fy1 = bbox_top,
				_fx2 = bbox_right,
				_fy2 = bbox_bottom;
				
			 // Determine Room's Dimensions:
			_x1 = min(_x1, _fx1);
			_y1 = min(_y1, _fy1);
			_x2 = max(_x2, _fx2 + 1);
			_y2 = max(_y2, _fy2 + 1);
			
			 // Fix Potential Wall Softlock:
			if(_floorDis <= 0 && _floorNum == _floorNumLast + array_length(_floors)){
				with(call(scr.array_combine, 
					call(scr.instance_rectangle_bbox, _fx1 - 1, _fy1,     _fx2 + 1, _fy2,     Wall),
					call(scr.instance_rectangle_bbox, _fx1,     _fy1 - 1, _fx2,     _fy2 + 1, Wall)
				)){
					if(instance_exists(self) && place_meeting(x, y, Floor)){
						with(call(scr.instances_meeting, x, y, [Bones, TopPot])){
							if(place_meeting(x, y, other)){
								instance_delete(self);
							}
						}
						instance_delete(self);
					}
				}
			}
		}
	}
	
	 // Done:
	return {
		"floors" : _floors,
		"x"      : (_x1 + _x2) / 2,
		"y"      : (_y1 + _y2) / 2,
		"x1"     : _x1,
		"y1"     : _y1,
		"x2"     : _x2,
		"y2"     : _y2,
		"xstart" : _sx,
		"ystart" : _sy
	};
	
#define floor_room(_spawnX, _spawnY, _spawnDis, _spawnFloor, _w, _h, _type, _dirOff, _floorDis)
	/*
		Automatically creates a room a safe distance from the spawn point
		Rooms will always connect to the level as long as floorDis <= 0
		Rooms will not overlap existing Floors as long as floorDis >= 0 (they can still overlap FloorExplo)
		
		Args:
			spawnX/spawnY - The spawn point
			spawnDis      - Minimum distance from the spawn point to begin searching for an open space
			spawnFloor    - Potential starting floors to begin searching for an open space from
			w/h           - Width/height of the room to create
			type          - The type of room to create (see 'floor_fill' script)
			dirOff        - Random directional offset to use while moving away from the spawn point to find an open space
			floorDis      - How far from the level to create the room
			                Use 0 to spawn adjacent to the level, >0 to create an isolated room, <0 to overlap the level
			
		Ex:
			floor_room(10016, 10016, 96, FloorNormal, 4, 4, "round", 60, -32)
	*/
	
	with(floor_room_start(_spawnX, _spawnY, _spawnDis, _spawnFloor)){
		return floor_room_create(x, y, _w, _h, _type, direction, _dirOff, _floorDis);
	}
	
	return noone;
	
#define wall_clear(_x, _y)
	/*
		Creates and returns a PortalClear that destroys all Walls touching the calling instance at the given position
	*/
	
	with(instance_create(_x, _y, PortalClear)){
		sprite_index = ((other.mask_index < 0) ? other.sprite_index : other.mask_index);
		image_xscale = other.image_xscale;
		image_yscale = other.image_yscale;
		image_angle  = other.image_angle;
		
		return self;
	}
	
#define wall_delete(_x1, _y1, _x2, _y2)
	/*
		Deletes all Walls and Wall-related objects within the given rectangular area
	*/
	
	with(call(scr.instance_rectangle_bbox, _x1, _y1, _x2, _y2, [Wall, InvisiWall])){
		with(instances_matching(instances_matching(TrapScorchMark, "x", x), "y", y)){
			instance_delete(self);
		}
		instance_delete(self);
	}
	with(call(scr.instance_rectangle_bbox, _x1, _y1, _x2, _y2, [TopSmall, TopPot, Bones])){
		instance_delete(self);
	}
	
#define wall_tops()
	/*
		Creates the outer TopSmall tiles around the calling Wall instance
	*/
	
	var _minID = instance_max;
	
	instance_create(x - 16, y - 16, Top);
	instance_create(x - 16, y,      Top);
	instance_create(x,      y - 16, Top);
	instance_create(x,      y,      Top);
	
	return instances_matching_gt(TopSmall, "id", _minID);
	
#define wall_update(_x1, _y1, _x2, _y2)
	with(call(scr.instance_rectangle, _x1, _y1, _x2, _y2, Wall)){
		 // Fix:
		visible = place_meeting(x, y + 16, Floor);
		l = (place_free(x - 16, y) ?  0 :  4);
		w = (place_free(x + 16, y) ? 24 : 20) - l;
		r = (place_free(x, y - 16) ?  0 :  4);
		h = (place_free(x, y + 16) ? 24 : 20) - r;
		
		 // TopSmalls:
		wall_tops();
	}
	
#macro  scr																						global.scr
#macro  call																					script_ref_call
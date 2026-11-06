/*	                General
	This is the General package of Lib, for
	your basic Lib needs.
	Because Lib uses this for most 
*/

/*
	Scripts:
		#define obj_setup(_mod, _name)
		#define obj_setup_ext(_mod, _name, _type)
		#define obj_create(_x, _y, _name)
		#define instances_in_rectangle(_x1, _y1, _x2, _y2, _obj)
		#define player_swap(_player)
		#define projectile_create(inst, x, y, obj, ?dir=0, ?spd=0)
		#define projectile_euphoria(_inst)
		#define sound_play_at (x, y, sound, ?pitch=1, ?volume=1, ?fadeDis=64, ?fadeFactor=1)
		#define pool(_pool)
		#define fx(_x, _y, _motion, _object)
		#define game_activate()
		#define game_deactivate()
		#define array_delete(_array, _index)
		#define array_delete_value(_array, _value)
		#define instance_get_name(_inst)
		#define instance_nearest_array(_x, _y, _obj)
		#define instance_nearest_bbox(_x, _y, _obj)
		#define instance_nearest_rectangle(_x1, _y1, _x2, _y2, _obj)
		#define instance_nearest_rectangle_bbox(_x1, _y1, _x2, _y2, _obj)
		#define instances_at(_x, _y, _obj)
		#define instance_rectangle(_x1, _y1, _x2, _y2, _obj)
		#define instance_rectangle_bbox(_x1, _y1, _x2, _y2, _obj)
		#define instances_meeting(_x, _y, _obj)
		#define instances_seen(_obj, _bx, _by, _index)
		#define instances_seen_nonsync(_obj, _bx, _by)
		#define instance_random(_obj)
		#define instance_clone()
		#define data_clone(_value, _depth)
		#define ds_list_clone(_list)
		#define surface_clone(_surf)
		#define variable_instance_get_list(_inst)
		#define variable_instance_set_list(_inst, _list)
		#define variable_is_readonly(_inst, _varName)
		#define draw_lasersight(_x, _y, _dir, _disMax, _width)
		#define draw_surface_scale(_surf, _x, _y, _scale)
		#define string_delete_nt(_string)
		#define string_space(_string)
		#define orandom(_num)
		#define pround(_num, _precision)
		#define pfloor(_num, _precision)
		#define pceil(_num, _precision)
		#define array_count(_array, _value)
		#define array_flip(_array)
		#define array_combine(_array1, _array2)
		#define array_shuffle(_array)
		#define enemy_target(_x, _y)
		#define chest_create(_x, _y, _obj, _levelStart)
		#define object_is(_object, _parent)
		#define chance(_numer, _denom)
		#define chance_ct(_numer, _denom)
		#define lerp_ct(_val1, _val2, _amount)
		#define angle_lerp(_ang1, _ang2, _num)
		#define angle_lerp_ct(_ang1, _ang2, _num)
		#define path_create(_xstart, _ystart, _xtarget, _ytarget, _wall)
		#define path_shrink(_path, _wall, _skipMax)
		#define path_reaches(_path, _xtarget, _ytarget, _wall)
		#define path_direction(_path, _x, _y, _wall)
		#define path_draw(_path, _width)
		#define prompt_create(_text)
		#define is_9940()
		#define obj_fire(_gunangle, _wep, _x, _y, _creator, _affectcreator)
		#define seeded_random(_seed, _min, _max, _irandom)
		#define object_get_mouse(inst)
		#define run_movescan(_object, _mod)
		#define loc_format(key, default, values...)
*/

//For internal use, adds the script to be easily usable.
#define addScript(name)
	lq_set(instances_matching(CustomObject, "name", "libGlobal")[0].scriptReferences, name, ["mod", mod_current, name]);

#define init
	addScript("obj_setup");
	addScript("obj_setup_ext");
	addScript("obj_create");
	addScript("instances_in_rectangle");
	addScript("player_swap");
	addScript("projectile_create");
	addScript("projectile_euphoria");
	addScript("sound_play_at");
	addScript("pool");
	addScript("fx");
	addScript("game_activate");
	addScript("game_deactivate");
	addScript("array_delete");
	addScript("array_delete_value");
	addScript("instance_get_name");
	addScript("instance_nearest_array");
	addScript("instance_nearest_bbox");
	addScript("instance_nearest_rectangle");
	addScript("instance_nearest_rectangle_bbox");
	addScript("instances_at");
	addScript("instance_rectangle");
	addScript("instance_rectangle_bbox");
	addScript("instances_meeting");
	addScript("instances_seen");
	addScript("instances_seen_nonsync");
	addScript("instance_random");
	addScript("instance_clone");
	addScript("data_clone");
	addScript("ds_list_clone");
	addScript("surface_clone");
	addScript("variable_instance_get_list");
	addScript("variable_instance_set_list");
	addScript("variable_is_readonly");
	addScript("draw_lasersight");
	addScript("draw_surface_scale");
	addScript("string_delete_nt");
	addScript("string_space");
	addScript("orandom");
	addScript("pround");
	addScript("pfloor");
	addScript("pceil");
	addScript("array_count");
	addScript("array_flip");
	addScript("array_combine");
	addScript("array_shuffle");
	addScript("enemy_target");
	addScript("chest_create");
	addScript("object_is");
	addScript("chance");
	addScript("chance_ct");
	addScript("lerp_ct");
	addScript("angle_lerp");
	addScript("angle_lerp_ct");
	addScript("path_create");
	addScript("path_shrink");
	addScript("path_reaches");
	addScript("path_direction");
	addScript("path_draw");
	addScript("prompt_create");
	addScript("is_9940");
	addScript("obj_fire");
	addScript("seeded_random");
	addScript("object_get_mouse");
	addScript("run_movescan");
	addScript("loc_format");
	
	script_ref_call(["mod", "lib", "updateRef"]);
	global.isLoaded = true;
	
	global.objects = ds_map_create();
	
	script_ref_call(["mod", "lib", "getRef"], "mod", mod_current, "scr");
	
	obj_setup(mod_current, "LibPrompt");

#define step
	if(instance_exists(GenCont)){
		with(instances_matching(FireCont, "isLibFireCont", true)){
			instance_destroy();
		}
	}

#define late_step
	 // Prompts:
	//Note: This code IS basically just taken from TE, but it means that it works alongside TE prompts.
	var _inst = instances_matching(CustomObject, "name", "LibPrompt");
	if(array_length(_inst)){
		 // Reset:
		var _instReset = instances_matching_ne(_inst, "pick", -1);
		if(array_length(_instReset)){
			with(_instReset){
				pick = -1;
			}
		}
		
		 // Player Collision:
		if(instance_exists(Player)){
			_inst = instances_matching(_inst, "visible", true);
			if(array_length(_inst)){
				with(instances_matching(Player, "visible", true)){
					var _id = id;
					if(
						place_meeting(x, y, CustomObject)
						&& !place_meeting(x, y, IceFlower)
						&& !place_meeting(x, y, CarVenusFixed)
					){
						var _noVan = true;
						
						 // Van Check:
						if(instance_exists(Van) && place_meeting(x, y, Van)){
							with(instances_meeting(x, y, instances_matching(Van, "drawspr", sprVanOpenIdle))){
								if(place_meeting(x, y, other)){
									_noVan = false;
									break;
								}
							}
						}
						
						if(_noVan){
							var	_nearest  = noone,
								_maxDis   = null,
								_maxDepth = null;
								
							// Find Nearest Touching Indicator:
							if(instance_exists(nearwep)){
								_maxDis   = point_distance(x, y, nearwep.x, nearwep.y);
								_maxDepth = nearwep.depth;
							}
							with(instances_meeting(x, y, _inst)){
								if(place_meeting(x, y, other)){
									if(!instance_exists(creator) || creator.visible){
										if(!is_array(on_meet) || mod_script_call(on_meet[0], on_meet[1], on_meet[2])){
											if(_maxDepth == null || depth < _maxDepth){
												_maxDepth = depth;
												_maxDis   = null;
											}
											if(depth == _maxDepth){
												var _dis = point_distance(x, y, other.x, other.y);
												if(_maxDis == null || _dis < _maxDis){
													_maxDis  = _dis;
													_nearest = self;
												}
											}
										}
									}
								}
							}
							
							 // Secret IceFlower:
							with(_nearest){
								nearwep = instance_create(x + xoff, y + yoff, IceFlower);
								with(nearwep){
									name         = _nearest.text;
									x            = xstart;
									y            = ystart;
									xprevious    = x;
									yprevious    = y;
									visible      = false;
									mask_index   = mskNone;
									sprite_index = mskNone;
									spr_idle     = mskNone;
									spr_walk     = mskNone;
									spr_hurt     = mskNone;
									spr_dead     = mskNone;
									spr_shadow   = -1;
									snd_hurt     = -1;
									snd_dead     = -1;
									size         = 0;
									team         = 0;
									my_health    = 99999;
									nexthurt     = current_frame + 99999;
								}
								with(_id){
									nearwep = _nearest.nearwep;
									if(button_pressed(index, "pick")){
										_nearest.pick = index;
										if(instance_exists(_nearest.creator) && "on_pick" in _nearest.creator){
											with(_nearest.creator){
												if(!is_array(on_pick)){
													trace("on_pick needs to use script_ref_create");
												}
												script_ref_call(on_pick, _id.index, _nearest.creator, _nearest);
											}
										}
									}
								}
							}
						}
					}
				}
			}
		}
	}
	
#define obj_setup(_mod, _name)
/* Creator: Golden Epsilon
Description: 
	Sets up a custom object to be created using obj_create.
	Should only be run from .mod.gml-style mods
Arguments:
	_mod : the name of the mod that has the relevant scripts
	_name : the name of the object (make sure this is unique) (can be an array)
*/
	if(is_array(_name)){
		for(var i = 0; i < array_length(_name); i++){
			obj_setup(_mod, _name[i]);
		}
		return;
	}
	global.objects[? _name] = {
		setup : false,
		type : "mod", 
		modName : _mod, 
		name : _name
	};
	
#define obj_setup_ext(_mod, _name, _type)
/* Creator: Golden Epsilon
Description: 
	Sets up a custom object to be created using obj_create.
Arguments:
	_mod : the name of the mod that has the relevant scripts
	_name : the name of the object (make sure this is unique) (can be an array)
	_type : the type of the mod that has the object's scripts
*/
	if(is_array(_name)){
		for(var i = 0; i < array_length(_name); i++){
			obj_setup_ext(_mod, _name[i], _type);
		}
		return;
	}
	global.objects[? _name] = {
		setup : false,
		type : _type, 
		modName : _mod, 
		name : _name
	};

#define obj_create(_x, _y, _name)
/* Creator: Yokin (modified by Golden Epsilon)
Description: 
	Creates an object, vanilla or custom, and sets up scripts for it automatically.
	If it is a custom object, run obj_setup for it before running obj_create 
	(you only need to run obj_setup once for each object, though)
Arguments:
	_x : the x position of the object when created
	_y : the y position of the object when created
	_name : the name/id of the object to create (can be an array bcuz wynaut)
New Script Hooks: (in other words, stuff like Bandit_create)
	*_create(_x, _y) : This function will be run as the object is created. Should return the created object.
	*_pick(_index) : if you run create_prompt on this object and the player presses E to activate it, this script will run.
Returns:
	The created object.
*/
	if(is_array(_name)){
		var _insts = [];
		for(var i = 0; i < array_length(_name); i++){
			array_push(_insts, obj_create(_x, _y, _name[i]));
		}
		return _insts;
	}
    
     // Normal Object:
    if(is_real(_name) && object_exists(_name)){
        return instance_create(_x, _y, _name);
    }
	
     // Custom Object:
    if(ds_map_exists(global.objects, _name)){
		var obj = global.objects[? _name];
		if(!obj.setup){
			global.objects[? _name].setup = true;
			 // Auto Script Binding (thanks bee):
			with([
				
				 // General:
				"_begin_step",
				"_step",
				"_end_step",
				"_draw",
				"_destroy",
				"_cleanup",
				
				 // Hitme/Enemy:
				"_hurt",
				"_death",
				
				 // Projectile:
				"_anim",
				"_wall",
				"_hit",
				
				 // Slash:
				"_grenade",
				"_projectile",
				
				 // Lib stuff
				"_pick"// When there's an E prompt picked on this object
			]){
				var _var =  "on" + self,
					_scr = _name + self;
				
				if(mod_script_exists(obj.type, obj.modName, _scr)){
					var _ref = script_ref_create_ext(obj.type, obj.modName, _scr);
					variable_instance_set(global.objects[? _name], _var, _ref);
				} else {
					variable_instance_set(global.objects[? _name], _var, undefined);
				}
			}
		
			for(var i = 0; i <= 11; i++) {
				var _alrm = "_alrm" + string(i);
				
				if(mod_script_exists(obj.type, obj.modName, string(_name) + _alrm)){
					var _ref = script_ref_create_ext(obj.type, obj.modName, string(_name) + _alrm);
					variable_instance_set(global.objects[? _name], "on" + _alrm, _ref);
				} else {
					variable_instance_set(global.objects[? _name], "on" + _alrm, undefined);
				}
			}
			
			//need to update obj because setup probably added stuff to the variable behind it
			obj = global.objects[? _name];
		}
		
		var _inst = script_ref_call([obj.type, obj.modName, obj.name + "_create"], _x, _y);
            
		
         // No Return Value:
        if(is_undefined(_inst) || _inst == 0){
            _inst = noone;
        }
        
         // Auto Assign Things:
        if(instance_exists(_inst)){
			with([
				
				 // General:
				"_begin_step",
				"_step",
				"_end_step",
				"_draw",
				"_destroy",
				"_cleanup",
				
				 // Hitme/Enemy:
				"_hurt",
				"_death",
				
				 // Projectile:
				"_anim",
				"_wall",
				"_hit",
				
				 // Slash:
				"_grenade",
				"_projectile",
				
				 // Lib stuff
				"_pick"// When there's an E prompt picked on this object
			]){
				var _var =  "on" + self;
				if(variable_instance_get(_inst, _var) != undefined){
				}else if(variable_instance_get(global.objects[? _name], _var) != undefined){
					variable_instance_set(_inst, _var, variable_instance_get(global.objects[? _name], _var));
				} else {
					switch(self) {
						case "_step": 
							if(instance_is(_inst, CustomEnemy)) _inst.on_step = script_ref_create_ext(obj.type, obj.modName, "enemy_step"); 
							else if(instance_is(_inst, CustomHitme)) _inst.on_step = script_ref_create_ext(obj.type, obj.modName, "hitme_step"); 
						break;
						case "_hurt": if(instance_is(_inst, hitme)) _inst.on_hurt = script_ref_create_ext(obj.type, obj.modName, "enemy_hurt"); break;
						case "_death": if(instance_is(_inst, CustomEnemy)) _inst.on_death = script_ref_create_ext(obj.type, obj.modName, "enemy_death"); break;
						case "_draw": if(instance_is(_inst, CustomEnemy)) _inst.on_draw = script_ref_create_ext(obj.type, obj.modName, "draw_self_enemy"); break;
					}
				}
			}
			
			for(var i = 0; i <= 11; i++) {
				var _alrm = "_alrm" + string(i);
				
				if(variable_instance_get(global.objects[? _name], "on" + _alrm) != undefined){
					variable_instance_set(_inst, "on" + _alrm, variable_instance_get(global.objects[? _name], "on" + _alrm));
				}
			}
					
			if(instance_is(_inst, hitme)) {
				if(variable_instance_exists(_inst, "spr_idle")) _inst.sprite_index = _inst.spr_idle;
				if(instance_is(_inst, CustomEnemy)) _inst.target = noone;
			}
			
			_inst.name = _name;
		}
        
        return _inst;
    }
    
     // Return List of Objects:
    if(is_undefined(_name)){
        return ds_map_keys(global.objects);
    }
    
    return noone;
	
#define obj_create_ext(_x, _y, _name, _mod)
/* Creator: Golden Epsilon
Description: 
	Same as obj_create, but also runs obj_setup.
	Only here for if you're lazy, using obj_setup and obj_create separately is recommended.
Arguments:
	_x : the x position of the object when created
	_y : the y position of the object when created
	_name : the name/id of the object to create (can't be an array)
	_mod : the name of the mod the object is from
Returns:
	The created object.
*/
obj_setup(_mod, _name);
return obj_create(_x,_y,_name);

//This section of code is for obj_create, based on Tildebee code from Relics. Thanks bee!
#macro  infinity                                                                                1/0
#macro  anim_end                                                                                (image_index + image_speed >= image_number) || (image_index + image_speed < 0)
#macro  enemy_sprite                                                                            (sprite_index != spr_hurt || anim_end) ? ((speed == 0) ? spr_idle : spr_walk) : sprite_index
#macro  target_visible                                                                          !collision_line(x, y, target.x, target.y, Wall, false, false)
#macro  target_direction                                                                        point_direction(x, y, target.x, target.y)
#macro  target_distance                                                                         point_distance(x, y, target.x, target.y)
#macro  alarm0_run                                                                              alarm0 && !--alarm0 && !--alarm0 && (script_ref_call(on_alrm0) || !instance_exists(self))
#macro  alarm1_run                                                                              alarm1 && !--alarm1 && !--alarm1 && (script_ref_call(on_alrm1) || !instance_exists(self))
#macro  alarm2_run                                                                              alarm2 && !--alarm2 && !--alarm2 && (script_ref_call(on_alrm2) || !instance_exists(self))
#macro  alarm3_run                                                                              alarm3 && !--alarm3 && !--alarm3 && (script_ref_call(on_alrm3) || !instance_exists(self))
#macro  alarm4_run                                                                              alarm4 && !--alarm4 && !--alarm4 && (script_ref_call(on_alrm4) || !instance_exists(self))
#macro  alarm5_run                                                                              alarm5 && !--alarm5 && !--alarm5 && (script_ref_call(on_alrm5) || !instance_exists(self))
#macro  alarm6_run                                                                              alarm6 && !--alarm6 && !--alarm6 && (script_ref_call(on_alrm6) || !instance_exists(self))
#macro  alarm7_run                                                                              alarm7 && !--alarm7 && !--alarm7 && (script_ref_call(on_alrm7) || !instance_exists(self))
#macro  alarm8_run                                                                              alarm8 && !--alarm8 && !--alarm8 && (script_ref_call(on_alrm8) || !instance_exists(self))
#macro  alarm9_run                                                                              alarm9 && !--alarm9 && !--alarm9 && (script_ref_call(on_alrm9) || !instance_exists(self))

#define enemy_step
	 // Alarms:
	if("on_alrm0" in self and alarm0_run) exit;
	if("on_alrm1" in self and alarm1_run) exit;
	if("on_alrm2" in self and alarm2_run) exit;
	if("on_alrm3" in self and alarm3_run) exit;
	if("on_alrm4" in self and alarm4_run) exit;
	if("on_alrm5" in self and alarm5_run) exit;
	if("on_alrm6" in self and alarm6_run) exit;
	if("on_alrm7" in self and alarm7_run) exit;
	if("on_alrm8" in self and alarm8_run) exit;
	if("on_alrm9" in self and alarm9_run) exit;
	
	 // Movement:
	if(walk > 0){
		walk -= current_time_scale;
		speed += walkspeed * current_time_scale;
	}
	if(speed > maxspeed){
		speed = maxspeed;
	}
	
	 // Animate:
	sprite_index = enemy_sprite;
	
#define hitme_step
	if(place_meeting(x + hspeed, y + vspeed, Wall)) move_bounce_solid(true);
	
	 // Handle enemies:
	with(instances_meeting(x, y, enemy)){
		if(projectile_canhit_melee(other) && "canmelee" in self && canmelee && meleedamage > 0){
			projectile_hit(other, meleedamage);
		}
		
		with(other){
			if(projectile_canhit_melee(other)){
				projectile_hit(other, 3);
				sound_play_pitch(sndFreakMelee, 1.2 + random(0.4));
			}
		}
	}

#define draw_weapon(_sprite, _image, _x, _y, _angle, _angleMelee, _kick, _flip, _blend, _alpha)
	/*
		Drawing weapon sprites
		
		Ex:
			draw_weapon(sprBanditGun, gunshine, x, y, gunangle, 0, wkick, right, image_blend, image_alpha)
			draw_weapon(sprPipe, 0, x, y, gunangle, wepangle, wkick, wepflip, image_blend, image_alpha)
	*/
	
	 // Context Fix:
	if(!is_real(self) || !instance_exists(self)){
		with(UberCont){
			return draw_weapon(_sprite, _image, _x, _y, _angle, _angleMelee, _kick, _flip, _blend, _alpha);
		}
	}
	
	 // Melee Offset:
	if(_angleMelee != 0){
		_angle += _angleMelee * (1 - (_kick / 20));
	}
	
	 // Kick:
	if(_kick != 0){
		_x -= lengthdir_x(_kick, _angle);
		_y -= lengthdir_y(_kick, _angle);
	}
	
	 // Draw:
	draw_sprite_ext(_sprite, _image, _x, _y, 1, _flip, _angle, _blend, _alpha);
	
#define enemy_hurt(_damage, _force, _direction)
	my_health -= _damage;           // Damage
	nexthurt = current_frame + 6;   // I-Frames
	motion_add(_direction, _force); // Knockback
	sound_play_hit(snd_hurt, 0.2);  // Sound
	
	 // Hurt Sprite:
	sprite_index = spr_hurt;
	image_index  = 0;
	
#define enemy_death
	pickup_drop(20, 0);

//Now back to your regularly scheduled module code

#define instances_in_rectangle(_x1, _y1, _x2, _y2, _obj)
	/*
		Returns all instances of the given object whose positions overlap the given rectangle
		Much better performance than checking 'point_in_rectangle()' on every instance
		
		Args:
			x1/y1/x2/y2 - The rectangular area to search
			obj         - The object(s) to search
	*/
	
	return (
		instances_matching_le(
		instances_matching_le(
		instances_matching_ge(
		instances_matching_ge(
		_obj,
		"x", _x1),
		"y", _y1),
		"x", _x2),
		"y", _y2)
	);

#define player_swap(_player)
	/*
		Cycles the given player's weapon slots
	*/
	
	with(["%wep", "%curse", "%reload", "%wkick", "%wepflip", "%wepangle", "%can_shoot", "%clicked", "%interfacepop", "drawempty%"]){
		var	_name = [string_replace(self, "%", ""), string_replace(self, "%", "b")],
			_temp = variable_instance_get(_player, _name[0], 0);
			
		variable_instance_set(_player, _name[0], variable_instance_get(_player, _name[1], 0));
		variable_instance_set(_player, _name[1], _temp);
	}

#define projectile_create // inst, x, y, obj, dir=0, spd=0
	/*
		Creates a given projectile with the given motion applied
		Automatically sets 'team', 'creator', and 'hitid' based on the given instance
		Automatically applies Euphoria to the projectile if the creator is an enemy
		
		Ex:
			projectile_create(self, x, y, Bullet2, gunangle + orandom(30 * accuracy), 16)
			projectile_create(self, x, y, "DiverHarpoon", gunangle, 7)
			projectile_create(self, x, y, Explosion)
	*/
	
	var	_inst = argument[0],
		_x    = argument[1],
		_y    = argument[2],
		_obj  = argument[3],
		_dir  = ((argument_count > 4) ? argument[4] : 0),
		_spd  = ((argument_count > 5) ? argument[5] : 0),
		_proj = obj_create(_x, _y, _obj);
		
	with(_proj){
		 // Motion:
		direction += _dir;
		if(_spd != 0){
			motion_add(_dir, _spd);
		}
		image_angle += direction;
		
		 // Auto Setup:
		var	_team    = (("team" in _inst) ? _inst.team : (("team" in self) ? team : -1)),
			_creator = (("creator" in _inst && !instance_is(_inst, hitme)) ? _inst.creator : _inst);
			
		projectile_init(_team, _creator);
		
		if("team"    in self) team    = _team;
		if("creator" in self) creator = _creator;
		if("hitid"   in self) hitid   = (("hitid" in _inst) ? _inst.hitid : hitid);
		
		 // Euphoria:
		if(
			is_string(_obj)
			&& skill_get(mut_euphoria) != 0
			&& (instance_exists(_creator) ? instance_is(_creator, enemy) : (_team != 2))
			&& !instance_is(self, EnemyBullet1)
			&& !instance_is(self, EnemyBullet3)
			&& !instance_is(self, EnemyBullet4)
			&& !instance_is(self, HorrorBullet)
			&& !instance_is(self, IDPDBullet)
			&& !instance_is(self, PopoPlasmaBall)
			&& !instance_is(self, LHBouncer)
			&& !instance_is(self, FireBall)
			&& !instance_is(self, ToxicGas)
			&& !instance_is(self, Shank)
			&& !instance_is(self, Slash)
			&& !instance_is(self, EnemySlash)
			&& !instance_is(self, GuitarSlash)
			&& !instance_is(self, CustomSlash)
			&& !instance_is(self, BloodSlash)
			&& !instance_is(self, LightningSlash)
			&& !instance_is(self, EnergyShank)
			&& !instance_is(self, EnergySlash)
			&& !instance_is(self, EnergyHammerSlash)
			&& !instance_is(other, FireCont)
		){
			script_bind_begin_step(projectile_euphoria, 0, self);
		}
	}
	
	return _proj;
	
#define projectile_euphoria(_inst)
	with(_inst){
		speed *= power(0.8, skill_get(mut_euphoria));
	}
	instance_destroy();

#define sound_play_at // x, y, sound, pitch=1, volume=1, fadeDis=64, fadeFactor=1
	/*
		Plays the given sound with a volume based on the given position's distance to the nearest local Player
		Also takes advantage of surround sound systems like headphones to make the sound appear "3D"
		Volume = (playerDis / fadeDis) ^ -fadeFactor
		
		Args:
			x/y        - The sound's position
			sound      - The sound index to play
			pitch      - The played sound's initial pitch, defaults to 1
			volume     - The played sound's initial volume, defaults to 1 (combines with the fade effect)
			fadeDis    - The distance at which the sound begins to fade in volume
			fadeFactor - Determines how fast the sound's volume falls off after the 'fadeDis'
			
		Ex:
			sound_play_at(x, y, snd_hurt, 1 + orandom(0.1))
			sound_play_at(x, y, sndExplosion, 1 + orandom(0.1), 1, 320)
	*/
	
	var	_x          = argument[0],
		_y          = argument[1],
		_sound      = argument[2],
		_pitch      = ((argument_count > 3) ? argument[3] : 1),
		_volume     = ((argument_count > 4) ? argument[4] : 1),
		_fadeDis    = ((argument_count > 5) ? argument[5] : 64),
		_fadeFactor = ((argument_count > 6) ? argument[6] : 1),
		_listenX    = view_xview_nonsync + (game_width  / 2),
		_listenY    = view_yview_nonsync + (game_height / 2);
		
	 // Determine Listener Position:
	if(instance_exists(Player)){
		var _disMax = infinity;
		with(Player){
			var _dis = point_distance(x, y, _x, _y);
			if(_dis < _disMax){
				if(player_is_local_nonsync(index)){
					_disMax = _dis;
					_listenX = x;
					_listenY = y;
				}
			}
		}
	}
	
	 // Play Sound:
	audio_stop_sound(_sound);
	var _snd = audio_play_sound_at(_sound, _listenX - _x, _listenY - _y, 0, _fadeDis, 320, _fadeFactor, false, 0);
	audio_sound_pitch(_snd, _pitch);
	audio_sound_gain(_snd, _volume * audio_sound_get_gain(_snd), 0);
	
	return _snd;
	
#define pool(_pool)
	/*
		Accepts a LWO or array of value:weight pairs, and returns one of the values based on random chance
		
		Ex:
			pool({
				"A" : 4, // 50%
				"B" : 3, // 37.5%
				"C" : 1  // 12.5%
			})
			pool([
				[Bandit,    5], // 50%
				[Scorpion,  3], // 30%
				[BigMaggot, 1], // 10%
				[Maggot,    1]  // 10%
			])
	*/
	
	 // Turn LWO Into Array:
	if(is_object(_pool)){
		var _poolNew = [];
		for(var i = 0; i < lq_size(_pool); i++){
			array_push(_poolNew, [lq_get_key(_pool, i), lq_get_value(_pool, i)]);
		}
		_pool = _poolNew;
	}
	
	 // Roll Max Number:
	var _roll = 0;
	with(_pool){
		_roll += self[1];
	}
	_roll -= random(_roll);
	
	 // Find Rolled Value:
	if(_roll > 0){
		with(_pool){
			_roll -= self[1];
			if(_roll <= 0){
				return self[0];
			}
		}
	}
	
	return null;

#define fx(_x, _y, _motion, _object)
	/*
		Creates a given Effect object with the given motion applied
		Automatically reorients the effect towards its new direction
		
		Args:
			x/y    - Spawn position, can be a 2-element array for [position, randomized offset]
			motion - Can be a speed to apply toward a random direction, or a 2-element array to apply a [direction, speed]
			object - The effect's object index, or an NT:TE object name
			
		Ex:
			fx([x, 4], [y, 4], 3, Dust)
			fx(x, y, [90 + orandom(30), random(3)], AcidStreak);
	*/
	
	with(obj_create(
		(is_array(_x) ? (_x[0] + orandom(_x[1])) : _x),
		(is_array(_y) ? (_y[0] + orandom(_y[1])) : _y),
		_object
	)){
		var _face = (image_angle == direction || (speed == 0 && (object_index == AcidStreak || object_index == BloodStreak)));
		
		 // Motion:
		if(is_array(_motion)){
			motion_add(_motion[0], _motion[1]);
		}
		else{
			motion_add(random(360), _motion);
		}
		
		 // Facing:
		if(_face){
			image_angle = direction;
		}
		
		return self;
	}
	
	return noone;

#define game_activate()
	/*
		Reactivates all objects and unpauses the game
	*/
	
	with(UberCont) with(self){
		event_perform(ev_alarm, 2);
	}
	
#define game_deactivate()
	/*
		Deactivates all objects, except GmlMods & most controllers
	*/
	
	with(UberCont) with(self){
		var	_lastIntro = opt_bossintros,
			_lastLoops = GameCont.loops,
			_player    = noone;
			
		 // Ensure Boss Intro Plays:
		opt_bossintros = true;
		GameCont.loops = 0;
		if(!instance_exists(Player)){
			_player = instance_create(0, 0, GameObject);
			with(_player){
				instance_change(Player, false);
			}
		}
		
		 // Call Boss Intro:
		with(instance_create(0, 0, GameObject)){
			instance_change(BanditBoss, false);
			with(self){
				event_perform(ev_alarm, 6);
			}
			sound_stop(sndBigBanditIntro);
			instance_delete(self);
		}
		
		 // Reset:
		alarm2         = -1;
		opt_bossintros = _lastIntro;
		GameCont.loops = _lastLoops;
		with(_player){
			instance_delete(self);
		}
		
		 // Unpause Game, Then Deactivate Objects:
		event_perform(ev_alarm, 2);
		event_perform(ev_draw, ev_draw_post);
	}
	
#define array_delete(_array, _index)
	/*
		Returns a new array with the value at the given index removed
		
		Ex:
			array_delete([1, 2, 3], 1) == [1, 3]
	*/
	
	var _new = array_slice(_array, 0, _index);
	
	array_copy(_new, array_length(_new), _array, _index + 1, array_length(_array) - (_index + 1));
	
	return _new;
	
#define array_delete_value(_array, _value)
	/*
		Returns a new array with the given value removed
		
		Ex:
			array_delete_value([1, 2, 3, 2], 2) == [1, 3]
	*/
	
	var _new = _array;
	
	while(array_find_index(_new, _value) >= 0){
		_new = array_delete(_new, array_find_index(_new, _value));
	}
	
	return _new;
	
#define instance_get_name(_inst)
	/*
		Returns a displayable name for a given instance or object
	*/
	
	var _name  = "";
	
	 // Instance:
	if(instance_exists(_inst) && !object_exists(_inst)){
		 // Cause of Death:
		if("hitid" in _inst){
			var _hitid = _inst.hitid;
			
			if(is_real(_hitid)){
				_hitid = floor(_hitid);
				
				 // Built-In:
				var _list = ["bandit", "maggot", "rad maggot", "big maggot", "scorpion", "golden scorpion", "big bandit", "rat", "big rat", "green rat", "gator", "frog", "super frog", "mom", "assassin", "raven", "salamander", "sniper", "big dog", "spider", "new cave thing", "laser crystal", "hyper crystal", "snow bandit", "snowbot", "wolf", "snowtank", "lil hunter", "freak", "explo freak", "rhino freak", "necromancer", "turret", "technomancer", "guardian", "explo guardian", "dog guardian", "throne", "throne II", "bonefish", "crab", "turtle", "molefish", "molesarge", "fireballer", "super fireballer", "jock", "@p@qc@qu@qr@qs@qe@qd @qs@qp@qi@qd@qe@qr", "@p@qc@qu@qr@qs@qe@qd @qc@qr@qy@qs@qt@qa@ql", "mimic", "health mimic", "grunt", "inspector", "shielder", "crown guardian", "explosion", "small explosion", "fire trap", "shield", "toxic", "horror", "barrel", "toxic barrel", "golden barrel", "car", "venus car", "venus car fixed", "venus car 2", "icy car" , "thrown car", "mine", "crown of death", "rogue strike", "blood launcher", "blood cannon", "blood hammer", "disc", "@p@qc@qu@qr@qs@qe", "big dog missile", "halloween bandit", "lil hunter fly", "throne death", "jungle bandit", "jungle assassin", "jungle fly", "crown of hatred", "ice flower", "@p@qc@qu@qr@qs@qe@qd @qa@qm@qm@qo @qp@qi@qc@qk@qu@qp", "electrocution", "elite grunt", "blood gamble", "elite shielder", "elite inspector", "captain", "van", "buff gator", "generator", "lightning crystal", "golden snowtank", "green explosion", "small generator", "golden disc", "big dog explosion", "popo freak", "throne II death", "big fish"];
				if(_hitid >= 0 && _hitid < array_length(_list)){
					_name = loc(`CauseOfDeath:${_hitid}`, _list[_hitid]);
				}
				
				 // Sprite:
				else if(sprite_exists(_hitid)){
					_name = sprite_get_name(_hitid);
				}
			}
			
			 // Custom:
			else if(is_array(_hitid) && array_length(_hitid)){
				_name = string(_hitid[1]);
			}
		}
		
		 // Named:
		if(_name == ""){
			if("name" in _inst && string_pos("Custom", object_get_name(variable_instance_get(_inst, "object_index", -1))) == 1){
				_name = string(_inst.name);
				if(string_pos(" ", _name) <= 0){
					_name = string_space(_name);
				}
			}
		}
	}
	
	 // Object:
	if(_name == ""){
		var _obj = (
			object_exists(_inst)
			? _inst
			: variable_instance_get(_inst, "object_index", -1)
		);
		if(object_exists(_obj)){
			switch(_obj){
				case Bullet1      : _name = "Bullet";            break;
				case Bullet2      : _name = "Shell";             break;
				case EnemyBullet1 : _name = "Enemy Bullet";      break;
				case EnemyBullet2 : _name = "Venom";             break;
				case EnemyBullet3 : _name = "Enemy Shell";       break;
				case EnemyBullet4 : _name = "Sniper Bullet";     break;
				case EFlakBullet  : _name = "Enemy Flak Bullet"; break;
				case PlasmaBig    : _name = "Big Plasma";        break;
				case PlasmaHuge   : _name = "Huge Plasma";       break;
				default           : _name  = string_space(object_get_name(_obj));
			}
		}
	}
	
	return _name;
	
#define instance_nearest_array(_x, _y, _obj)
	/*
		Returns the instance closest to a given point from an array of instances
		
		Ex:
			instance_nearest_array(x, y, instances_matching_ne(hitme, "team", 2));
	*/
	
	var	_disMax  = infinity,
		_nearest = noone;
		
	with(instances_matching_ne(_obj, "id", null)){
		var _dis = point_distance(_x, _y, x, y);
		if(_dis < _disMax){
			_disMax  = _dis;
			_nearest = self;
		}
	}
	
	return _nearest;
	
#define instance_nearest_bbox(_x, _y, _obj)
	/*
		Returns the instance closest to a given point based on their bounding box
		Accepts an array argument like 'instance_nearest_array()' does
		
		Ex:
			instance_nearest_bbox(x, y, Floor);
	*/
	
	var	_disMax  = infinity,
		_nearest = noone;
		
	with(instances_matching_ne(_obj, "id", null)){
		var _dis = distance_to_point(_x, _y);
		if(_dis < _disMax){
			_disMax  = _dis;
			_nearest = self;
		}
	}
	
	return _nearest;
	
#define instance_nearest_rectangle(_x1, _y1, _x2, _y2, _obj)
	/*
		Returns the instance closest to a given rectangle based on their position
		If multiple instances are equally distant from the rectangle, a bias exists for the one closer to its center
		Accepts an array argument like 'instance_nearest_array()' does
		
		Ex:
			instance_nearest_rectangle(x, y, x + 160, y + 64, chestprop)
	*/
	
	var	_cx      = (_x1 + _x2) / 2,
		_cy      = (_y1 + _y2) / 2,
		_disAMax = infinity,
		_disBMax = infinity,
		_nearest = noone;
		
	with(instances_matching_ne(_obj, "id", null)){
		var	_disA = point_distance(x, y, clamp(x, _x1, _x2), clamp(y, _y1, _y2)),
			_disB = point_distance(x, y, _cx, _cy);
			
		if(_disA < _disAMax || (_disA == _disAMax && _disB < _disBMax)){
			_disAMax = _disA;
			_disBMax = _disB;
			_nearest = self;
		}
	}
	
	return _nearest;
	
#define instance_nearest_rectangle_bbox(_x1, _y1, _x2, _y2, _obj)
	/*
		Returns the instance closest to a given rectangle based on their bounding box
		If multiple instances are equally distant from the rectangle, a bias exists for the one closer to its center
		Accepts an array argument like 'instance_nearest_array()' does
		
		Ex:
			instance_nearest_rectangle_bbox(x - 16, y - 16, x + 16, y + 16, Floor)
	*/
	
	var	_cx      = (_x1 + _x2) / 2,
		_cy      = (_y1 + _y2) / 2,
		_disAMax = infinity,
		_disBMax = infinity,
		_nearest = noone;
		
	with(instances_matching_ne(_obj, "id", null)){
		var	_x    = clamp(_cx, bbox_left, bbox_right + 1),
			_y    = clamp(_cy, bbox_top, bbox_bottom + 1),
			_disA = point_distance(_x, _y, clamp(_x, _x1, _x2), clamp(_y, _y1, _y2)),
			_disB = point_distance(_x, _y, _cx, _cy);
			
		if(_disA < _disAMax || (_disA == _disAMax && _disB < _disBMax)){
			_disAMax = _disA;
			_disBMax = _disB;
			_nearest = self;
		}
	}
	
	return _nearest;
	
#define instances_at(_x, _y, _obj)
	/*
		Returns all given instances with their bounding boxes touching a given position
		Much better performance than manually performing 'position_meeting()' on every instance
	*/
	
	return instances_matching_le(instances_matching_ge(instances_matching_le(instances_matching_ge(_obj, "bbox_right", _x), "bbox_left", _x), "bbox_bottom", _y), "bbox_top", _y);
	
#define instance_rectangle(_x1, _y1, _x2, _y2, _obj)
	/*
		Returns all given instances with their coordinates touching a given rectangle
		Much better performance than manually performing 'point_in_rectangle()' on every instance
	*/
	
	return instances_matching_le(instances_matching_ge(instances_matching_le(instances_matching_ge(_obj, "x", _x1), "x", _x2), "y", _y1), "y", _y2);
	
#define instance_rectangle_bbox(_x1, _y1, _x2, _y2, _obj)
	/*
		Returns all given instances with their bounding box touching a given rectangle
		Much better performance than manually performing 'place_meeting()' on every instance
	*/
	
	return instances_matching_le(instances_matching_ge(instances_matching_le(instances_matching_ge(_obj, "bbox_right", _x1), "bbox_left", _x2), "bbox_bottom", _y1), "bbox_top", _y2);
	
#define instances_meeting(_x, _y, _obj)
	/*
		Returns all instances whose bounding boxes overlap the calling instance's bounding box at the given position
		Much better performance than manually performing 'place_meeting(x, y, other)' on every instance
	*/
	
	var	_tx = x,
		_ty = y;
		
	x = _x;
	y = _y;
	
	var _inst = instances_matching_ne(instances_matching_le(instances_matching_ge(instances_matching_le(instances_matching_ge(_obj, "bbox_right", bbox_left), "bbox_left", bbox_right), "bbox_bottom", bbox_top), "bbox_top", bbox_bottom), "id", id);
	
	x = _tx;
	y = _ty;
	
	return _inst;
	
#define instances_seen(_obj, _bx, _by, _index)
	/*
		Returns all given instances currently on a given player's screen
		Much better performance than manually performing 'point_seen()' or 'point_seen_ext()' on every instance
		
		Args:
			obj   - The object or instances to search
			bx/by - X/Y border offsets, like 'point_seen_ext()'
			index - The index of the player's screen, use -1 to search the overall bounding area of every player's screen
	*/
	
	var	_x1 = 0,
		_y1 = 0,
		_x2 = 0,
		_y2 = 0;
		
	 // All:
	if(_index < 0){
		_x1 = +infinity;
		_y1 = +infinity;
		_x2 = -infinity;
		_y2 = -infinity;
		for(var i = 0; i < maxp; i++){
			if(player_is_active(i)){
				var	_x = view_xview[i],
					_y = view_yview[i];
					
				if(_x < _x1) _x1 = _x;
				if(_y < _y1) _y1 = _y;
				if(_x > _x2) _x2 = _x;
				if(_y > _y2) _y2 = _y;
			}
		}
		_x2 += game_width;
		_y2 += game_width;
	}
	
	 // Normal:
	else{
		_x1 = view_xview[_index];
		_y1 = view_yview[_index];
		_x2 = _x1 + game_width;
		_y2 = _y1 + game_height;
	}
	
	return instances_matching_le(instances_matching_ge(instances_matching_le(instances_matching_ge(_obj, "bbox_right", _x1 - _bx), "bbox_left", _x2 + _bx), "bbox_bottom", _y1 - _by), "bbox_top", _y2 + _by);
	
#define instances_seen_nonsync(_obj, _bx, _by)
	/*
		Returns all given instances currently on the local player's screen
		Much better performance than manually performing 'point_seen()' or 'point_seen_ext()' on every instance
		!!! Beware of DESYNCS
		
		Args:
			obj   - The object or instances to search
			bx/by - X/Y border offsets, like 'point_seen_ext()'
	*/
	
	var	_x1 = view_xview_nonsync,
		_y1 = view_yview_nonsync,
		_x2 = _x1 + game_width,
		_y2 = _y1 + game_height;
		
	return instances_matching_le(instances_matching_ge(instances_matching_le(instances_matching_ge(_obj, "bbox_right", _x1 - _bx), "bbox_left", _x2 + _bx), "bbox_bottom", _y1 - _by), "bbox_top", _y2 + _by);
	
#define instance_random(_obj)
	/*
		Returns a random instance of the given object
		Also accepts an array of instances
	*/
	
	var	_inst = instances_matching_ne(_obj, "id", null),
		_size = array_length(_inst);
		
	return (
		(_size > 0)
		? _inst[irandom(_size - 1)]
		: noone
	);
	
#define instance_clone()
	/*
		Duplicates an instance like 'instance_copy(false)', but clones all of their variables
	*/
	
	var _inst = instance_copy(false);
	
	with(variable_instance_get_names(_inst)){
		var	_value = variable_instance_get(_inst, self),
			_clone = data_clone(_value, 0);
			
		if(_value != _clone){
			variable_instance_set(_inst, self, _clone);
		}
	}
	
	return _inst;
	
#define data_clone(_value, _depth)
	/*
		Returns an exact copy of the given value, and any data stored within the value based on the given depth
		
		Ex:
			list = [1, [ds_list_create(), 3], surface_create(1, 1)];
			data_clone(list, 0) == Returns a clone of the main array
			data_clone(list, 1) == Returns a clone of the main array, sub array, and surface
			data_clone(list, 2) == Returns a clone of the main array, sub array, surface, and ds_list
	*/
	
	if(_depth >= 0){
		_depth--;
		
		 // Array:
		if(is_array(_value)){
			var _clone = array_clone(_value);
			
			if(_depth >= 0){
				for(var i = array_length(_value) - 1; i >= 0; i--){
					_clone[i] = data_clone(_value[i], _depth);
				}
			}
			
			return _clone;
		}
		
		 // LWO:
		if(is_object(_value)){
			var _clone = lq_clone(_value);
			
			if(_depth >= 0){
				for(var i = lq_size(_value) - 1; i >= 0; i--){
					lq_set(_clone, lq_get_key(_value, i), data_clone(lq_get_value(_value, i), _depth));
				}
			}
			
			return _clone;
		}
		
		/* GM data structures are tied to mod files
		 // DS List:
		if(ds_list_valid(_value)){
			var _clone = ds_list_clone(_value);
			
			if(_depth >= 0){
				for(var i = ds_list_size(_value) - 1; i >= 0; i--){
					_clone[| i] = data_clone(_value[| i], _depth);
				}
			}
			
			return _clone;
		}
		
		 // DS Map:
		if(ds_map_valid(_value)){
			var _clone = ds_map_create();
			
			with(ds_map_keys(_value)){
				_clone[? self] = data_clone(_value[? self], _depth);
			}
			
			return _clone;
		}
		
		 // DS Grid:
		if(ds_grid_valid(_value)){
			var	_w     = ds_grid_width(_value),
				_h     = ds_grid_height(_value),
				_clone = ds_grid_create(_w, _h);
				
			for(var _x = _w - 1; _x >= 0; _x--){
				for(var _y = _h - 1; _y >= 0; _y--){
					_value[# _x, _y] = data_clone(_value[# _x, _y], _depth);
				}
			}
			
			return _clone;
		}
		*/
		
		 // Surface:
		if(surface_exists(_value)){
			return surface_clone(_value);
		}
	}
	
	return _value;
	
#define ds_list_clone(_list)
	/*
		Returns an exact copy of the given ds_list
	*/
	
	var _clone = ds_list_create();
	
	ds_list_add_array(_clone, ds_list_to_array(_list));
	
	return _clone;
	
#define surface_clone(_surf)
	/*
		Returns an exact copy of the given surface
	*/
	
	var _clone = surface_create(surface_get_width(_surf), surface_get_height(_surf));
	
	surface_set_target(_clone);
	draw_clear_alpha(0, 0);
	draw_surface(_surf, 0, 0);
	surface_reset_target();
	
	return _clone;
	
#define variable_instance_get_list(_inst)
	/*
		Returns all of a given instance's variable names and values as a LWO
	*/
	
	var _list = {};
	
	with(variable_instance_get_names(_inst)){
		lq_set(_list, self, variable_instance_get(_inst, self));
	}
	
	return _list;
	
#define variable_instance_set_list(_inst, _list)
	/*
		Sets all of a given LWO's variable names and values on a given instance
	*/
	
	if(instance_exists(_inst)){
		var	_listMax  = lq_size(_list),
			_isCustom = (string_pos("Custom", object_get_name(_inst.object_index)) == 1);
			
		for(var i = 0; i < _listMax; i++){
			var _name = lq_get_key(_list, i);
			if(!variable_is_readonly(_inst, _name)){
				if(_isCustom && string_pos("on_", _name) == 1){
					if(variable_instance_get(_inst, _name) != lq_get_value(_list, i)){
						try variable_instance_set(_inst, _name, lq_get_value(_list, i));
						catch(_error){}
					}
				}
				else variable_instance_set(_inst, _name, lq_get_value(_list, i));
			}
		}
	}
	
#define variable_is_readonly(_inst, _varName)
	/*
		Returns 'true' if the given variable on the given instance is read-only, 'false' otherwise
	*/
	
	if(array_find_index(["id", "object_index", "bbox_bottom", "bbox_top", "bbox_right", "bbox_left", "image_number", "sprite_yoffset", "sprite_xoffset", "sprite_height", "sprite_width"], _varName) >= 0){
		return true;
	}
	
	if(instance_is(_inst, Player)){
		if(array_find_index(["p", "index", "alias"], _varName) >= 0){
			return true;
		}
	}
	
	return false;
	
#define draw_lasersight(_x, _y, _dir, _disMax, _width)
	/*
		Performs hitscan and draws a laser sight line
		Returns the line's ending position
	*/
	
	var	_dis  = _disMax,
		_disX = lengthdir_x(_dis, _dir),
		_disY = lengthdir_y(_dis, _dir);
		
	 // Major Hitscan Mode (Start at max, halve distance until no collision line):
	while(_dis >= 1 && collision_line(_x, _y, _x + _disX, _y + _disY, Wall, false, false)){
		_dis  /= 2;
		_disX /= 2;
		_disY /= 2;
	}
	
	 // Minor Hitscan Mode (Increment until walled):
	if(_dis < _disMax){
		var	_disAdd  = max(2, _dis / 32),
			_disAddX = lengthdir_x(_disAdd, _dir),
			_disAddY = lengthdir_y(_disAdd, _dir);
			
		while(_dis > 0 && !position_meeting(_x + _disX, _y + _disY, Wall)){
			_dis  -= _disAdd;
			_disX += _disAddX;
			_disY += _disAddY;
		}
	}
	
	 // Draw:
	draw_line_width(
		_x - 1,
		_y - 1,
		_x - 1 + _disX,
		_y - 1 + _disY,
		_width
	);
	
	return [_x + _disX, _y + _disY];
	
#define draw_surface_scale(_surf, _x, _y, _scale)
	/*
		Draws a given surface at a given position with a given scale
		Useful when working with surfaces that support pixel scaling
	*/
	
	draw_surface_ext(_surf, _x, _y, _scale, _scale, 0, c_white, draw_get_alpha());
	
#define string_delete_nt(_string)
	/*
		Returns a given string with "draw_text_nt()" formatting removed
		
		Ex:
			string_delete_nt("@2(sprBanditIdle:0)@rBandit") == "  Bandit"
			string_width(string_delete_nt("@rHey")) == 3
	*/
	
	var	_split          = "@",
		_stringSplit    = string_split(_string, _split),
		_stringSplitMax = array_length(_stringSplit);
		
	for(var i = 1; i < _stringSplitMax; i++){
		if(_stringSplit[i - 1] != _split){
			var	_current = _stringSplit[i],
				_char    = string_upper(string_char_at(_current, 1));
				
			switch(_char){
				
				case "": // CANCEL : "@@rHey" -> "@rHey"
					
					if(i < _stringSplitMax - 1){
						_current = _split;
					}
					
					break;
					
				case "W":
				case "S":
				case "D":
				case "R":
				case "G":
				case "B":
				case "P":
				case "Y":
				case "Q": // BASIC : "@qHey" -> "Hey"
					
					_current = string_delete(_current, 1, 1);
					
					break;
					
				case "0":
				case "1":
				case "2":
				case "3":
				case "4":
				case "5":
				case "6":
				case "7":
				case "8":
				case "9": // SPRITE OFFSET : "@2(sprBanditIdle:1)Hey" -> "  Hey"
					
					if(string_char_at(_current, 2) == "("){
						_current = string_delete(_current, 1, 1);
						
						 // Offset if Drawing Sprite:
						var _spr = string_split(string_copy(_current, 2, string_pos(")", _current) - 2), ":")[0];
						if(
							real(_spr) > 0
							|| sprite_exists(asset_get_index(_spr))
							|| _spr == "sprKeySmall"
							|| _spr == "sprButSmall"
							|| _spr == "sprButBig"
						){
							// draw_text_nt uses width of "A" instead of " ", so this is slightly off on certain fonts
							if(string_width(" ") > 0){
								_current = string_repeat(" ", real(_char) * (string_width("A") / string_width(" "))) + _current;
							}
						}
					}
					
					 // NONE : "@2Hey" -> "@2Hey"
					else{
						_current = _split + _current;
						break;
					}
					
				case "(": // ADVANCED : "@(sprBanditIdle:1)Hey" -> "Hey"
					
					var	_bgn = string_pos("(", _current),
						_end = string_pos(")", _current);
						
					if(_bgn < _end){
						_current = string_delete(_current, _bgn, 1 + _end - _bgn);
						break;
					}
					
				default: // NONE : "@Hey" -> "@Hey"
					
					_current = _split + _current;
					
			}
			
			_stringSplit[i] = _current;
		}
	}
	
	return array_join(_stringSplit, "");
	
#define string_space(_string)
	/*
		Returns the given string with spaces inserted between numbers<->letters, letters<->numbers, and lowercase<->uppercase
		
		Ex:
			string_space("CoolGuy123") == "Cool Guy 123"
	*/
	
	var	_char     = "",
		_charLast = "",
		_charNext = "";
		
	for(var i = 0; i <= string_length(_string); i++){
		_charNext = string_char_at(_string, i + 1);
		
		if(
			(_char != string_lower(_char) && (_charLast != string_upper(_charLast) || (_charLast != string_lower(_charLast) && _charNext != string_upper(_charNext))))
			|| (string_digits(_char) != "" && string_letters(_charLast) != "")
			|| (string_letters(_char) != "" && string_digits(_charLast) != "") 
		){
			_string = string_insert(" ", _string, i);
			i++;
		}
		
		_charLast = _char;
		_char = _charNext;
	}
	
	return _string;

#define orandom(_num)
	/*
		For offsets
	*/
	
	return random_range(-_num, _num);
	
#define pround(_num, _precision)
	/*
		Precision 'round()'
		
		Ex:
			pround(7, 3) == 6
	*/
	
	if(_precision != 0){
		return round(_num / _precision) * _precision;
	}
	
	return _num;
	
#define pfloor(_num, _precision)
	/*
		Precision 'floor()'
		
		Ex:
			pfloor(2.7, 0.5) == 2.5
	*/
	
	if(_precision != 0){
		return floor(_num / _precision) * _precision;
	}
	
	return _num;
	
#define pceil(_num, _precision)
	/*
		Precision 'ceil()'
		
		Ex:
			pceil(-9, 5) == -5
	*/
	
	if(_precision != 0){
		return ceil(_num / _precision) * _precision;
	}
	
	return _num;
	
#define array_count(_array, _value)
	/*
		Returns the number of times a given value was found in the given array
	*/
	
	var _count = 0;
	
	if(array_find_index(_array, _value) >= 0){
		with(_array){
			if(self == _value){
				_count++;
			}
		}
	}
	
	return _count;
	
#define array_flip(_array)
	/*
		Flips a given array
		
		Ex:
			array_flip([1, 7, 5, 9]) == [9, 5, 7, 1]
	*/
	
	var	a = array_clone(_array),
		m = array_length(_array);
		
	for(var i = 0; i < m; i++){
		_array[@i] = a[(m - 1) - i];
	}
	
	return _array;
	
#define array_combine(_array1, _array2)
	/*
		Returns a new array made by joining the two given arrays
	*/
	
	var _new = array_clone(_array1);
	
	array_copy(_new, array_length(_new), _array2, 0, array_length(_array2));
	
	return _new;

#define array_shuffle(_array)
	var	_size = array_length(_array),
		j, t;
		
	for(var i = 0; i < _size; i++){
		j = irandom_range(i, _size - 1);
		if(i != j){
			t = _array[i];
			_array[@i] = _array[j];
			_array[@j] = t;
		}
	}
	
	return _array;
	
#define enemy_target(_x, _y)
	/*
		Base game targeting for consistency, cause with consistency u can have clever solutions
	*/
	
	if(instance_exists(Player)){
		target = instance_nearest(_x, _y, Player);
	}
	else if(target < 0){
		target = noone;
	}
	
	return instance_exists(target);
	
#define chest_create(_x, _y, _obj, _levelStart)
	/*
		Creates a given chest/mimic with some special spawn conditions applied, such as Crown of Love, Crown of Life, and Rogue
		!!! Don't use this for creating a custom area's basic chests during level gen, the game should handle that
		!!! Don't use this for replacing chests with custom chests, put that in level_start or something
		
		Ex:
			chest_create(x, y, WeaponChest, true)
			chest_create(x, y, "BatChest", false)
	*/
	
	if(
		is_string(_obj)
		|| object_is(_obj, chestprop)
		|| object_is(_obj, RadChest)
		|| object_is(_obj, Mimic)
		|| object_is(_obj, SuperMimic)
	){
		 // Rad Canisters:
		if(is_real(_obj) && object_is(_obj, RadChest)){
			if(_levelStart){
				 // Rogue:
				for(var i = 0; i < maxp; i++){
					if(player_get_race(i) == "rogue"){
						_obj = RogueChest;
						break;
					}
				}
				
				 // Low HP:
				if(chance(1, 2)){
					with(Player){
						if(my_health < (maxhealth + chickendeaths) / 2){
							_obj = HealthChest;
							break;
						}
					}
				}
				
				 // Legacy Revive Mode:
				var _players = 0;
				for(var i = 0; i < maxp; i++){
					_players += player_is_active(i);
				}
				if(instance_number(Player) < _players){
					_obj = HealthChest;
				}
			}
			
			 // More Health Chests:
			if(chance(2, 3) && crown_current == crwn_life){
				_obj = HealthChest;
			}
		}
		
		 // Only Ammo Chests:
		if(crown_current == crwn_love){
			if(!is_real(_obj) || !object_is(_obj, AmmoChest)){
				if(array_find_index([ProtoChest, RogueChest, "Backpack", "BonusAmmoChest", "BonusAmmoMimic", "BuriedVaultChest", "CatChest", "CursedAmmoChest", "CursedMimic", "SunkenChest"], _obj) < 0){
					var _name = (is_real(_obj) ? object_get_name(_obj) : _obj);
					if(string_pos("Mimic", _name) > 0){
						_obj = Mimic;
					}
					else if(string_pos("Giant", _name) > 0){
						_obj = GiantAmmoChest;
					}
					else{
						_obj = AmmoChest;
					}
				}
			}
		}
		
		if(_levelStart){
			 // Big Weapon Chests:
			if(chance(GameCont.nochest, 4) && _obj == WeaponChest){
				_obj = BigWeaponChest;
			}
			
			 // Mimics:
			if(!is_real(GameCont.area) || GameCont.area >= 2 || GameCont.loops >= 1){
				if(chance(1, 11) && is_real(_obj) && object_is(_obj, AmmoChest)){
					_obj = Mimic;
				}	
				if(chance(1, 51) && is_real(_obj) && object_is(_obj, HealthChest)){
					_obj = SuperMimic;
				}
			}
		}
	}
	
	 // Create:
	var	_inst   = noone,
		_rads   = GameCont.norads,
		_health = [];
		
	if(!_levelStart){
		GameCont.norads = 0;
		with(Player){
			array_push(_health, [self, my_health]);
			my_health = maxhealth;
		}
	}
	
	_inst = obj_create(_x, _y, _obj);
	
	if(!_levelStart){
		GameCont.norads = _rads;
		with(_health) with(self[0]){
			my_health = other[1];
		}
	}
	
	 // Replaced:
	if(!instance_exists(_inst)){
		with(instances_matching_gt([chestprop, RadChest, Mimic, SuperMimic], "id", _inst)){
			if(!instance_exists(_inst) || id < _inst){
				_inst = id;
			}
		}
	}
	
	return _inst;
	
#define object_is(_object, _parent)
	/*
		Returns whether the given object is a child of, or equal to, the given parent object (true) or not (false)
	*/
	
	return (_object == _parent || object_is_ancestor(_object, _parent));
	
#define chance(_numer, _denom)
	/*
		Returns true or false randomly, based on the given probability
		
		Ex:
			if(chance(1, 3)) trace("1/3 chance");
	*/
	
	return (random(_denom) < _numer);
	
#define chance_ct(_numer, _denom)
	/*
		Like 'chance()', but used when being called every frame (for timescale support)
	*/
	
	return (random(_denom) < _numer * current_time_scale);
	
#define lerp_ct(_val1, _val2, _amount)
	/*
		Like 'lerp()', but used when modifying a persistent value every frame (for timescale support)
	*/
	
	return lerp(_val2, _val1, power(1 - _amount, current_time_scale));
	
#define angle_lerp(_ang1, _ang2, _num)
	/*
		Linearly interpolates between the two given angles
		
		Ex:
			lerp(90, 180, 0.5) == 135
			lerp(20, 270, 0.1) == 9
	*/
	
	return _ang1 + (angle_difference(_ang2, _ang1) * _num);
	
#define angle_lerp_ct(_ang1, _ang2, _num)
	/*
		Like 'angle_lerp()', but used when modifying a persistent value every frame (for timescale support)
	*/
	
	return _ang2 + (angle_difference(_ang1, _ang2) * power(1 - _num, current_time_scale));

#define path_create(_xstart, _ystart, _xtarget, _ytarget, _wall)
	 // Auto-Determine Grid Size:
	var	_tileSize   = 16,
		_areaWidth  = pceil(abs(_xtarget - _xstart), _tileSize) + 320,
		_areaHeight = pceil(abs(_ytarget - _ystart), _tileSize) + 320;
		
	_areaWidth  = max(_areaWidth, _areaHeight);
	_areaHeight = max(_areaWidth, _areaHeight);
	
	var _triesMax = 4 * ceil((_areaWidth + _areaHeight) / _tileSize);
	
	 // Clamp Path X/Y:
	_xstart  = pfloor(_xstart,  _tileSize);
	_ystart  = pfloor(_ystart,  _tileSize);
	_xtarget = pfloor(_xtarget, _tileSize);
	_ytarget = pfloor(_ytarget, _tileSize);
	
	 // Grid Setup:
	var	_gridw    = ceil(_areaWidth  / _tileSize),
		_gridh    = ceil(_areaHeight / _tileSize),
		_gridx    = pround(((_xstart + _xtarget) / 2) - (_areaWidth  / 2), _tileSize),
		_gridy    = pround(((_ystart + _ytarget) / 2) - (_areaHeight / 2), _tileSize),
		_grid     = ds_grid_create(_gridw, _gridh),
		_gridCost = ds_grid_create(_gridw, _gridh);
		
	ds_grid_clear(_grid, -1);
	
	 // Mark Walls:
	with(instance_rectangle(_gridx, _gridy, _gridx + _areaWidth, _gridy + _areaHeight, _wall)){
		if(position_meeting(x, y, self)){
			_grid[# (x - _gridx) / _tileSize, (y - _gridy) / _tileSize] = -2;
		}
	}
	
	 // Pathing:
	var	_x1         = (_xtarget - _gridx) / _tileSize,
		_y1         = (_ytarget - _gridy) / _tileSize,
		_x2         = (_xstart  - _gridx) / _tileSize,
		_y2         = (_ystart  - _gridy) / _tileSize,
		_searchList = [[_x1, _y1, 0]],
		_tries      = _triesMax;
		
	while(_tries-- > 0){
		var	_search = _searchList[0],
			_sx     = _search[0],
			_sy     = _search[1],
			_sp     = _search[2];
			
		if(_sp >= infinity) break; // No more searchable tiles
		_search[2] = infinity;
		
		 // Sort Through Neighboring Tiles:
		var _costSoFar = _gridCost[# _sx, _sy];
		for(var i = 0; i < 2*pi; i += pi/2){
			var	_nx = _sx + cos(i),
				_ny = _sy - sin(i),
				_nc = _costSoFar + 1;
				
			if(
				_nx >= 0     &&
				_ny >= 0     &&
				_nx < _gridw &&
				_ny < _gridh &&
				_grid[# _nx, _ny] == -1
			){
				_gridCost[# _nx, _ny] = _nc;
				_grid[# _nx, _ny] = point_direction(_nx, _ny, _sx, _sy);
				
				 // Add to Search List:
				array_push(_searchList, [
					_nx,
					_ny,
					point_distance(_x2, _y2, _nx, _ny) + (abs(_x2 - _nx) + abs(_y2 - _ny)) + _nc
				]);
			}
			
			 // Path Complete:
			if(_nx == _x2 && _ny == _y2){
				_tries = 0;
				break;
			}
		}
		
		 // Next:
		array_sort_sub(_searchList, 2, true);
	}
	
	 // Pack Path into Array:
	var	_x     = _xstart,
		_y     = _ystart,
		_path  = [[_x + (_tileSize / 2), _y + (_tileSize / 2)]],
		_tries = _triesMax;
		
	while(_tries-- > 0){
		var _dir = _grid[# ((_x - _gridx) / _tileSize), ((_y - _gridy) / _tileSize)];
		if(_dir >= 0){
			_x += lengthdir_x(_tileSize, _dir);
			_y += lengthdir_y(_tileSize, _dir);
			array_push(_path, [_x + (_tileSize / 2), _y + (_tileSize / 2)]);
		}
		else{
			_path = []; // Couldn't find path
			break;
		}
		
		 // Done:
		if(_x == _xtarget && _y == _ytarget){
			break;
		}
	}
	if(_tries <= 0) _path = []; // Couldn't find path
	
	ds_grid_destroy(_grid);
	ds_grid_destroy(_gridCost);
	
	return _path;
	
#define path_shrink(_path, _wall, _skipMax)
	var	_pathNew = [],
		_link    = 0;
		
	if(!is_array(_wall)){
		_wall = [_wall];
	}
	
	for(var i = 0; i < array_length(_path); i++){
		 // Save Important Points on Path:
		var _save = (
			i <= 0                       ||
			i >= array_length(_path) - 1 ||
			i - _link >= _skipMax
		);
		
		 // Save Points Going Around Walls:
		if(!_save){
			var	_x1 = _path[i + 1, 0],
				_y1 = _path[i + 1, 1],
				_x2 = _path[_link, 0],
				_y2 = _path[_link, 1];
				
			for(var j = 0; j < array_length(_wall); j++){
				if(collision_line(_x1, _y1, _x2, _y2, _wall[j], false, false)){
					_save = true;
					break;
				}
			}
		}
		
		 // Store:
		if(_save){
			array_push(_pathNew, _path[i]);
			_link = i;
		}
	}
	
	return _pathNew;
	
#define path_reaches(_path, _xtarget, _ytarget, _wall)
	if(!is_array(_wall)) _wall = [_wall];
	
	var m = array_length(_path);
	if(m > 0){
		var	_x = _path[m - 1, 0],
			_y = _path[m - 1, 1];
			
		for(var i = 0; i < array_length(_wall); i++){
			if(collision_line(_x, _y, _xtarget, _ytarget, _wall[i], false, false)){
				return false;
			}
		}
		
		return true;
	}
	
	return false;
	
#define path_direction(_path, _x, _y, _wall)
	if(!is_array(_wall)) _wall = [_wall];
	
	 // Find Nearest Unobstructed Point on Path:
	var	_disMax  = infinity,
		_nearest = -1;
		
	for(var i = 0; i < array_length(_path); i++){
		var	_px = _path[i, 0],
			_py = _path[i, 1],
			_dis = point_distance(_x, _y, _px, _py);
			
		if(_dis < _disMax){
			var _walled = false;
			for(var j = 0; j < array_length(_wall); j++){
				if(collision_line(_x, _y, _px, _py, _wall[j], false, false)){
					_walled = true;
					break;
				}
			}
			if(!_walled){
				_disMax = _dis;
				_nearest = i;
			}
		}
	}
	
	 // Find Direction to Next Point on Path:
	if(_nearest >= 0){
		var	_follow = min(_nearest + 1, array_length(_path) - 1),
			_nx = _path[_follow, 0],
			_ny = _path[_follow, 1];
			
		 // Go to Nearest Point if Path to Next Point Obstructed:
		for(var j = 0; j < array_length(_wall); j++){
			if(collision_line(x, y, _nx, _ny, _wall[j], false, false)){
				_nx = _path[_nearest, 0];
				_ny = _path[_nearest, 1];
				break;
			}
		}
		
		return point_direction(x, y, _nx, _ny);
	}
	
	return null;
	
#define path_draw(_path, _width)
	var	_x = x,
		_y = y;
		
	with(_path){
		draw_line_width(self[0], self[1], _x, _y, _width);
		_x = self[0];
		_y = self[1];
	}
	
#define prompt_create(_text)
	/*
		Creates an E key prompt with the given text that targets the current instance
	*/
	
	with(obj_create(x, y, "LibPrompt")){
		text    = _text;
		creator = other;
		depth   = other.depth;
		
		return self;
	}
	
	return noone;
	
#define LibPrompt_create(_x, _y)
	with(instance_create(_x, _y, CustomObject)){
		 // Vars:
		mask_index = mskWepPickup;
		persistent = true;
		creator    = noone;
		nearwep    = noone;
		depth      = 0; // Priority (0==WepPickup)
		pick       = -1;
		xoff       = 0;
		yoff       = 0;
		
		 // Events:
		on_meet = null;
		
		return self;
	}
	
#define LibPrompt_begin_step
	with(nearwep){
		instance_delete(self);
	}
	
#define LibPrompt_end_step
	 // Follow Creator:
	if(creator != noone){
		if(instance_exists(creator)){
			if(instance_exists(nearwep)){
				with(nearwep){
					x += other.creator.x - other.x;
					y += other.creator.y - other.y;
					visible = true;
				}
			}
			x = creator.x;
			y = creator.y;
		}
		else instance_destroy();
	}
	
#define LibPrompt_cleanup
	with(nearwep){
		instance_delete(self);
	}

#define is_9940
/* Creator: Golden Epsilon
Description: 
	returns whether you are using a pre-GMS2 version
Usage:
	if(script_ref_call(["mod", "libGeneral", "is_9940"]){
		//do_stuff_for_9940
	}
*/
var retVal = false;
repeat(0){
	retVal = true;
}
return retVal;

#define obj_fire(_gunangle, _wep, _x, _y, _creator, _affectcreator)
with (instance_create(_x,_y,FireCont)){
	isLibFireCont = true;
	owner = _creator;
	wep = _wep;
	maxspeed = variable_instance_get(owner, "maxspeed", 4);
	team = variable_instance_get(owner, "team", 0);
	accuracy = variable_instance_get(owner, "accuracy", 1);
	curse = variable_instance_get(owner, "curse", 0);
	ammo = variable_instance_get(owner, "ammo", [1000, 255, 55, 55, 55, 55]);
	prevammo = variable_instance_get(owner, "ammo", undefined);
	maxhealth = variable_instance_get(owner, "maxhealth", 8);
	my_health = variable_instance_get(owner, "my_health", 8);
	lsthealth = variable_instance_get(owner, "lsthealth", 8);
	reloadspeed = variable_instance_get(owner, "reloadspeed", 1);
	footstep = variable_instance_get(owner, "footstep", 0);
	chickencorpse = variable_instance_get(owner, "chickencorpse", noone);
	frogcharge = variable_instance_get(owner, "frogcharge", 0);
	rogueammo = variable_instance_get(owner, "rogueammo", 1);
	canspec = variable_instance_get(owner, "canspec", 1);
	notoxic = variable_instance_get(owner, "notoxic", 0);
	horrornorad = variable_instance_get(owner, "horrornorad", 0);
	swapmove = variable_instance_get(owner, "swapmove", 0);
	bleed = variable_instance_get(owner, "bleed", 0);
	typ_amax = variable_instance_get(owner, "typ_amax", [1000, 255, 55, 55, 55, 55]);
	sprite_angle = variable_instance_get(owner, "sprite_angle", 0);
	wkick = variable_instance_get(owner, "wkick", 0);
	joyx = variable_instance_get(owner, "joyx", 0);
	can_shoot = variable_instance_get(owner, "can_shoot", 1);
	gunshine = variable_instance_get(owner, "gunshine", 0);
	nearwep = variable_instance_get(owner, "nearwep", 0);
	roll = variable_instance_get(owner, "roll", 0);
	joyaimx = variable_instance_get(owner, "joyaimx", 0);
	horrorstopsnd = variable_instance_get(owner, "horrorstopsnd", 0);
	hammering = variable_instance_get(owner, "hammering", 0);
	infammo = variable_instance_get(owner, "infammo", 0);
	wepflip = variable_instance_get(owner, "wepflip", 1);
	p = variable_instance_get(owner, "p", 0);
	race = variable_instance_get(owner, "race", "");
	canswap = variable_instance_get(owner, "canswap", 1);
	interfacepop = variable_instance_get(owner, "interfacepop", 1);
	bwep = variable_instance_get(owner, "bwep", 0);
	hammerhead = variable_instance_get(owner, "hammerhead", 0);
	canwalk = variable_instance_get(owner, "canwalk", 1);
	drawlowhp = variable_instance_get(owner, "drawlowhp", 0);
	lasthit = variable_instance_get(owner, "lasthit", -4);
	alias = variable_instance_get(owner, "alias", "");
	clicked = variable_instance_get(owner, "clicked", 1);
	bwepangle = variable_instance_get(owner, "bwepangle", 0);
	canspirit = variable_instance_get(owner, "canspirit", 1);
	wave = variable_instance_get(owner, "wave", 0); //?
	spiriteffect = variable_instance_get(owner, "spiriteffect", 0);
	chickendeaths = variable_instance_get(owner, "chickendeaths", 0);
	canaim = variable_instance_get(owner, "canaim", 1);
	canscope = variable_instance_get(owner, "canscope", 1);
	usespec = variable_instance_get(owner, "usespec", 0);
	smoke = variable_instance_get(owner, "smoke", 0);
	wepangle = variable_instance_get(owner, "wepangle", 0);
	canrogue = variable_instance_get(owner, "canrogue", 1);
	dogammo = variable_instance_get(owner, "dogammo", 15);
	size = variable_instance_get(owner, "size", 5);
	wepright = variable_instance_get(owner, "wepright", 1);
	bwepflip = variable_instance_get(owner, "bwepflip", 1);
	safeheadloss = variable_instance_get(owner, "safeheadloss", 0);
	drawemptyb = variable_instance_get(owner, "drawemptyb", 0);
	candie = variable_instance_get(owner, "candie", 1);
	binterfacepop = variable_instance_get(owner, "binterfacepop", 1);
	showhp = variable_instance_get(owner, "showhp", 0);
	canpick = variable_instance_get(owner, "canpick", 1);
	turn = variable_instance_get(owner, "turn", -1);
	bcan_shoot = variable_instance_get(owner, "bcan_shoot", 1);
	breload = variable_instance_get(owner, "breload", 0);
	typ_name = variable_instance_get(owner, "typ_name", ["MELEE", "BULLETS", "SHELLS", "BOLTS", "EXPLOSIVES", "ENERGY"]);
	back = variable_instance_get(owner, "back", 1);
	bwkick = variable_instance_get(owner, "bwkick", 0);
	footextra = variable_instance_get(owner, "footextra", 0);
	bskin = variable_instance_get(owner, "bskin", 0);
	raddrop = variable_instance_get(owner, "raddrop", 0);
	bcurse = variable_instance_get(owner, "bcurse", 0);
	footkind = variable_instance_get(owner, "footkind", 0);
	drawempty = variable_instance_get(owner, "drawempty", 0);
	boilcap = variable_instance_get(owner, "boilcap", 0);
	typ_ammo = variable_instance_get(owner, "typ_ammo", [264,40,10,9,8,13]);
	right = variable_instance_get(owner, "right", 1);
	horrorcharge = variable_instance_get(owner, "horrorcharge", 0);
	race_id = variable_instance_get(owner, "race_id", 0);
	angle = variable_instance_get(owner, "angle", 0);
	nexthurt = variable_instance_get(owner, "nexthurt", current_frame);
	canfire = variable_instance_get(owner, "canfire", 1);
	canfeet = variable_instance_get(owner, "canfeet", 1);
	index = variable_instance_get(owner, "index", 0);
	gunangle = _gunangle;
	creator = variable_instance_get(owner, "creator", _affectcreator ? owner : self);
	specfiring = 0;
	reload = variable_instance_get(owner, "reload", 0);
	familiar = 1;
	var _wep = is_object(wep) ? wep.wep : wep;
	if(is_string(_wep) && mod_script_exists("weapon", _wep, "step")){
		mod_script_call("weapon", _wep, "step", 1);
	}
	player_fire_ext(_gunangle,wep,_x,_y,team,creator);
	if(instance_exists(owner) && _affectcreator){
		if("wepangle" in owner){owner.wepangle = owner.wepangle * (weapon_is_melee(_wep) ? -1 : 1);}
		if("reload" in owner){owner.reload = reload;}
		if("ammo" in owner){owner.ammo = ammo;}
	}
	time = current_time;
	return self;
}

#define seeded_random(_seed, _min, _max, _irandom)
//Returns a random value from min to max, seeded to the given seed without affecting the overall random seed (if _irandom is true uses irandom)
var _lastSeed = random_get_seed();
random_set_seed(GameCont.baseseed + _seed);
random_set_seed(ceil(random(100000) * random(100000)));
var rand;
if(_irandom){
	rand = _min+irandom(_max-_min);
}else{
	rand = _min+random(_max-_min);
}
random_set_seed(_lastSeed);
return rand;

// Returns a LWO with three fields:
//    x and y: world space coordinates.
//    is_input: indicates whether the coordinates should be treated as an active control source.
//        A nuke for example might ignore the coords if they aren't coming from an actual mouse, as enemies don't really aim over time.
// Used for logic and should be syncronous.
// Of note, the format of the LWO and scr_get_mouse integration are what make this important, thats what ought to be standard.
// If you don't like other choices, feel free to replace them. 
#define object_get_mouse(inst)
    //Compat hook. If you need self, be sure to include it in your script ref as an argument.
    //Return a LWO in your script that would match the output of this one.
    //You can return to the default behavior by setting scr_get_mouse to something that isn't a script reference.
    if "scr_get_mouse" in inst && is_array(inst.scr_get_mouse) {
        with inst return script_ref_call(scr_get_mouse)
    }
    
    //If there is a mouse at play, use it.
    if instance_is(inst, Player) || ("index" in inst && player_is_active(inst.index)) {
        return {x: mouse_x[inst.index], y: mouse_y[inst.index], is_input: true}
    }
    
    //If there is a target, consider it the mouse position.
    if "target" in inst && instance_exists(inst.target) {
        return {x: target.x, y: target.y, is_input: false}
    }
    
    //If no real way to find mouse coords is found, then make some assumptions regarding generally intended behavior.
    //In this case, project a point a moderate distance from the source, with direction as the default angle, optionally picking up gunangle.
    var _length = 48, _dir = inst.direction;
    if "gunangle" in inst {
        _dir = inst.gunangle;
    }

    return {x: inst.x + lengthdir_x(_length, _dir), y: inst.y + lengthdir_y(_length, _dir), is_input: false}
	
#define run_movescan(_object, _mod)
with(_object){
	var _obj = self;
	var size = 0.8;
	repeat(_mod){
		if(!instance_exists(self)){continue;}
		event_perform(ev_step, ev_step_begin);
		if(!instance_exists(self)){continue;}
		event_perform(ev_step, ev_step_normal);
		if(!instance_exists(self)){continue;}
		for(var i = 0; i < 4; i++){//alarms for projectiles don't go past 3
			if(alarm_get(i) > 0){
				alarm_set(i, alarm_get(i) - current_time_scale);
				if(alarm_get(i) <= 0){
					event_perform(ev_alarm, i);
				}
			}
		}
		if(!instance_exists(self)){continue;}
		if(image_index >= image_number){
			event_perform(ev_other, ev_animation_end)
		}
		image_index += image_speed_raw;
		with(instance_create(x,y,Effect)){
			sprite_index = other.sprite_index;
			image_index = other.image_index;
			image_speed = 0;
			image_xscale = other.image_xscale * ("right" in other ? other.right : 1)// * size;
			image_yscale = other.image_yscale// * size;
			image_alpha = other.image_alpha * size;
			image_angle = other.image_angle;
			if(fork()){
				if(instance_exists(self)){
					image_alpha *= 0.5;
					//image_xscale *= 0.8;
					//image_yscale *= 0.8;
				}
				wait(1);
				if(instance_exists(self)){
					image_alpha *= 0.5;
					//image_xscale *= 0.8;
					//image_yscale *= 0.8;
				}
				wait(1);
				if(instance_exists(self)){
					image_alpha *= 0.5;
					//image_xscale *= 0.8;
					//image_yscale *= 0.8;
				}
				wait(1);
				if(instance_exists(self)){
					instance_destroy();
				}
				exit;
			}
		}
		xprevious = x;
		yprevious = y;
		x += hspeed_raw;
		y += vspeed_raw;
		var _inst = instances_meeting(x, y, [projectile, hitme, Wall]);
		with(_inst){
			if(!instance_exists(_obj)){continue;}
			if("nexthurt" in self){nexthurt -= current_time_scale;}
			with(_obj){
				event_perform(ev_collision, other.object_index);
				if(!instance_exists(self)){continue;}
			}
		}
		if(!instance_exists(self)){continue;}
		event_perform(ev_step, ev_step_end);
		size += 0.2/_mod
	}
	if(!instance_exists(self)){continue;}
	with(instance_create(x,y,Effect)){
		sprite_index = other.sprite_index;
		image_index = other.image_index;
		image_speed = 0;
		image_xscale = other.image_xscale * ("right" in other ? other.right : 1)// * size;
		image_yscale = other.image_yscale// * size;
		image_alpha = other.image_alpha * size;
		image_angle = other.image_angle;
		if(fork()){
			if(instance_exists(self)){
				image_alpha *= 0.5;
				//image_xscale *= 0.8;
				//image_yscale *= 0.8;
			}
			wait(1);
			if(instance_exists(self)){
				image_alpha *= 0.5;
				//image_xscale *= 0.8;
				//image_yscale *= 0.8;
			}
			wait(1);
			if(instance_exists(self)){
				image_alpha *= 0.5;
				//image_xscale *= 0.8;
				//image_yscale *= 0.8;
			}
			wait(1);
			if(instance_exists(self)){
				instance_destroy();
			}
			exit;
		}
	}
}
	
#define loc_format // key, default, ...values
	/*
		Like 'loc', but replaces "%" with a value argument if provided, or "%#" if multiple value arguments are provided
		
		Ex:
			loc_format("HUD:Health", "%1/%2", my_health, maxhealth)
			loc_format("HUD:InsAmmo:1", loc("HUD:InsAmmo", "NOT ENOUGH %", typ_ammo[1]))
	*/
	
	var _text = loc(argument[0], argument[1]);
	
	 // Replace Values:
	var _valuePos = 2;
	if(argument_count > _valuePos){
		 // Single Value:
		if(argument_count <= _valuePos + 1){
			_text = string_replace_all(_text, "%", string(argument[_valuePos]));
		}
		
		 // Multiple Values:
		else{
			var _split = string_split(_text, "%");
			for(var i = array_length(_split) - 1; i >= 1; i--){
				var _num = _valuePos + real(string_char_at(_split[i], 1)) - 1;
				_split[i] = ((_num >= _valuePos && _num < argument_count) ? string(argument[_num]) : "") + string_delete(_split[i], 1, 1);
			}
			_text = array_join(_split, "");
		}
	}
	
	return _text;
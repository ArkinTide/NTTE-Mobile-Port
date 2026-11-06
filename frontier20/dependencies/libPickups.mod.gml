/*	                
	This is the Pickups package of Lib, for
	functions/objects that help with custom pickups
*/

/*
	Scripts:
		#define pickup_text(text, ?type, ?num)
	
	Objects:
		LibChest
		LibPickup
*/

//For internal use, adds the script to be easily usable.
#define addScript(name)
	lq_set(instances_matching(CustomObject, "name", "libGlobal")[0].scriptReferences, name, ["mod", mod_current, name]);

#define init
	addScript("pickup_text");
	
	script_ref_call(["mod", "lib", "updateRef"]);
	global.isLoaded = true;
	
	 // Custom Pickup Instances (Used in step):
	global.pickup_custom = [];
	
	//Custom chest and pickup instances (to know what to call)
	global.libChests = [];
	global.libPickups = [];
	
	script_ref_call(["mod", "lib", "getRef"], "mod", mod_current, "scr");
	
	call(scr.obj_setup, mod_current, "LibChest");
	call(scr.obj_setup, mod_current, "LibPickup");
	
#macro scr global.scr
#macro call script_ref_call

#define step
	with(global.libChests){
		if(instance_exists(self)){
			LibChest_basestep();
		}else{
			call(scr.array_delete_value, global.libChests, self);
		}
	}
	with(global.libPickups){
		if(instance_exists(self)){
			LibPickup_basestep();
		}else{
			call(scr.array_delete_value, global.libPickups, self);
		}
	}

#define late_step
	if(instance_exists(Player)){	
		 // Eyes Custom Pickup Attraction:
		if(array_length(global.pickup_custom)){
			var _inst = instances_matching(Player, "race", "eyes");
			if(array_length(_inst)) with(_inst){
				if(player_active && canspec && button_check(index, "spec")){
					var	_vx = view_xview[index],
						_vy = view_yview[index];
						
					with(call(scr.instance_rectangle, _vx, _vy, _vx + game_width, _vy + game_height, global.pickup_custom)){
						if(!is_array(on_pull) || mod_script_call(on_pull[0], on_pull[1], on_pull[2])){
							var	_l = (1 + skill_get(mut_throne_butt)) * current_time_scale,
								_d = point_direction(x, y, other.x, other.y),
								_x = x + lengthdir_x(_l, _d),
								_y = y + lengthdir_y(_l, _d);
								
							if(place_free(_x, y)) x = _x;
							if(place_free(x, _y)) y = _y;
						}
					}
				}
			}
		}
	}
	// Grabbing Custom Pickups:
	if(array_length(global.pickup_custom)){
		if(instance_exists(Player) || instance_exists(Portal)){
			var _inst = instances_matching_ne([Player, Portal], "id", null);
			if(array_length(_inst)) with(_inst){
				if(place_meeting(x, y, Pickup)){
					with(call(scr.instances_meeting, x, y, global.pickup_custom)){
						if(instance_exists(self) && place_meeting(x, y, other)){
							var open = true;
							if(is_array(on_open)){
								if(openType == 0){
									open = !mod_script_call(on_open[0], on_open[1], on_open[2]);
								}else if(openType == 1){
									with(Player){
										with(other){
											open = !mod_script_call(on_open[0], on_open[1], on_open[2]);
										}
									}
								}else if(openType == 2){
									with(call(scr.instance_random, Player)){
										with(other){
											open = !mod_script_call(on_open[0], on_open[1], on_open[2]);
										}
									}
								}
							}
							if(open){
								 // Effects:
								if(sprite_exists(spr_open)){
									with(instance_create(x, y, SmallChestPickup)){
										sprite_index = other.spr_open;
										image_xscale = other.image_xscale;
										image_yscale = other.image_yscale;
										image_angle  = other.image_angle;
									}
								}
								sound_play(snd_open);
								
								instance_destroy();
							}
						}
					}
				}
			}
		}
		global.pickup_custom = [];
	}

#define LibChest_create(_x, _y)
	with(instance_create(_x, _y, chestprop)){
		 // Visual:
		sprite_index = sprAmmoChest;
		spr_dead     = sprAmmoChestOpen;
		spr_open     = sprFXChestOpen;
		
		 // Sound:
		snd_open = sndAmmoChest;
		
		 // Vars:
		nochest = 0; // Adds to GameCont.nochest if not grabbed
		
		 // Events:
		on_step = null;
		on_open = null;
		
		array_push(global.libChests, self);
		
		return self;
	}
	
#define LibChest_basestep
	 // Call Custom Step Event:
	if(is_array(on_step)){
		mod_script_call(on_step[0], on_step[1], on_step[2]);
	}
	
	 // Open Chest:
	var _meet = [Player, PortalShock];
	for(var i = 0; i < array_length(_meet); i++){
		if(place_meeting(x, y, _meet[i])){
			with(instance_nearest(x, y, _meet[i])) with(other){
				 // Hatred:
				if(crown_current == crwn_hatred){
					repeat(16) with(instance_create(x, y, Rad)){
						motion_add(random(360), random_range(2, 6));
					}
					if(instance_is(other, Player)){
						projectile_hit_raw(other, 1, true);
					}
				}
				
				 // Call Custom Open Event:
				if(is_array(on_open)){
					mod_script_call(on_open[0], on_open[1], on_open[2]);
				}
				
				 // Effects:
				if(sprite_exists(spr_dead)){
					with(instance_create(x, y, ChestOpen)){
						sprite_index = other.spr_dead;
					}
				}
				if(sprite_exists(spr_open)){
					with(instance_create(x, y, FXChestOpen)){
						sprite_index = other.spr_open;
					}
				}
				sound_play(snd_open);
				
				instance_destroy();
				exit;
			}
		}
	}
	
	 // Increase Big Weapon Chest Chance if Skipped:
	if(nochest != 0){
		with(GameCont){
			if(fork()){
				var _add = other.nochest;
				wait 0;
				if(!instance_exists(other) && instance_exists(self)){
					if(instance_exists(GenCont) || instance_exists(LevCont)){
						nochest += _add;
					}
				}
				exit;
			}
		}
	}
	
	
#define LibPickup_create(_x, _y)
	/*
		A basic customizable Pickup object
		
		Vars:
			shine      - Randomized animation speed multiplier for the sprite's first frame, use 1 to animate normally
			spr_open   - The sprite that plays when opened by a Player
			spr_fade   - The sprite that plays after disappearing
			snd_open   - The sound that plays when opened by a Player
			snd_fade   - The sound that plays after disappearing
			mask_index - The hitbox, use mskPickup to collide with Ammo/HP-style pickups
			num        - General multiplier for what it gives to Players
			blink      - How many times it can blink on or off before disappearing
			alarm0     - The number of frames before blinking starts
			pull_dis   - The range in which it gets attracted to Players
			pull_spd   - The speed at which it moves toward Players
			on_step    - Script reference, called every frame for general code
			on_pull    - Script reference, called to determine if the pickup should attract toward a given Player (other=Player)
			on_open    - Script reference, called when the pickup is opened by a Player or Portal (other=Player/Portal)
			on_fade    - Script reference, called when the pickup disappears
			openType   - What gets sent to on_open when a pickup is picked up by a Portal (0: it calls from the portal, 1: it calls from all players, 2: it calls from a random player)
	*/
	
	with(instance_create(_x, _y, Pickup)){
		 // Visual:
		sprite_index = sprAmmo;
		spr_open     = sprSmallChestPickup;
		spr_fade     = sprSmallChestFade;
		image_speed  = 0.4;
		shine        = 0.1;
		
		 // Sound:
		snd_open = sndAmmoPickup;
		snd_fade = sndPickupDisappear;
		
		 // Vars:
		mask_index = mskPickup;
		friction   = 0.2;
		num        = 1;
		blink      = 30;
		alarm0     = pickup_alarm(200 + random(30), 1/5);
		pull_dis   = 40 + (30 * skill_get(mut_plutonium_hunger));
		pull_spd   = 6;
		
		 // Events:
		on_step = null;
		on_pull = script_ref_create(LibPickup_pull);
		on_open = null;
		on_fade = null;
		
		openType = 1;
		
		array_push(global.libPickups, self);
		
		return self;
	}
	
#define LibPickup_pull
	return true;
	
#define LibPickup_basestep
	array_push(global.pickup_custom, self); // For step event management
	
	 // Animate:
	if(image_index < 1 && shine != 1){
		image_index -= image_speed_raw * (1 - random(shine * current_time_scale));
	}
	
	 // Fading:
	if(alarm0 >= 0 && --alarm0 == 0){
		 // Blink:
		if(blink >= 0){
			blink--;
			alarm0 = 2;
			visible = !visible;
		}
		
		 // Fade:
		else{
			 // Call Fade Event:
			if(is_array(on_fade)){
				mod_script_call(on_fade[0], on_fade[1], on_fade[2]);
			}
			
			 // Effects:
			if(sprite_exists(spr_fade)){
				with(instance_create(x, y, SmallChestFade)){
					sprite_index = other.spr_fade;
					image_xscale = other.image_xscale;
					image_yscale = other.image_yscale;
					image_angle  = other.image_angle;
				}
			}
			sound_play_hit(snd_fade, 0.1);
			
			instance_destroy();
			exit;
		}
	}
	
	 // Call Custom Step Event:
	if(is_array(on_step)){
		mod_script_call(on_step[0], on_step[1], on_step[2]);
	}
	
	 // Attraction:
	if(is_array(on_pull)){
		var	_disMax  = (instance_exists(Portal) ? infinity : pull_dis),
			_nearest = noone;
			
		 // Find Nearest Attractable Player:
		with(Player){
			var _dis = point_distance(x, y, other.x, other.y);
			if(_dis < _disMax){
				with(other){
					if(mod_script_call(on_pull[0], on_pull[1], on_pull[2])){
						_disMax  = _dis;
						_nearest = other;
					}
				}
			}
		}
		
		 // Move:
		if(_nearest != noone){
			var	_l = pull_spd * current_time_scale,
				_d = point_direction(x, y, _nearest.x, _nearest.y),
				_x = x + lengthdir_x(_l, _d),
				_y = y + lengthdir_y(_l, _d);
				
			if(place_free(_x, y)) x = _x;
			if(place_free(x, _y)) y = _y;
		}
	}
	
	 // Pickup Collision:
	if(mask_index == mskPickup && place_meeting(x, y, Pickup)){
		with(call(scr.instances_meeting, x, y, instances_matching(Pickup, "mask_index", mskPickup))){
			if(place_meeting(x, y, other)){
				if(object_index == AmmoPickup || object_index == HPPickup || object_index == RoguePickup){
					motion_add_ct(point_direction(other.x, other.y, x, y) + call(scr.orandom, 10), 0.8);
				}
				with(other){
					motion_add_ct(point_direction(other.x, other.y, x, y) + call(scr.orandom, 10), 0.8);
				}
			}
		}
	}
	
	 // Wall Collision:
	if(place_meeting(x + hspeed_raw, y + vspeed_raw, Wall)){
		if(place_meeting(x + hspeed_raw, y, Wall)) hspeed_raw *= -1;
		if(place_meeting(x, y + vspeed_raw, Wall)) vspeed_raw *= -1;
	}

#define pickup_alarm(_time, _loopDecay)
	/*
		Returns the alarm0 to set on a pickup, affected by loop and crown of haste
		
		Args:
			time      - The pickup's base alarm value
			loopDecay - The percentage decay per loop
	*/
	
	 // Loop:
	_time /= 1 + (GameCont.loops * _loopDecay);
	
	 // Haste:
	if(crown_current == crwn_haste){
		_time /= (instance_is(self, BigRad) ? 2 : 3);
	}
	
	return _time;
	
#define pickup_text // text, ?type, ?num
	/*
		Creates a PopupText with the given text modified by the given type (and number if using type "add")
		If called from a Player, the text will only appear on that Player's screen
		Automatically supports the current locale
		
		Args:
			text - The main text
			type - The modifier, can be "add", "max", "low", "ins", "out", or "got" (leave undefined for none)
			num  - The number to be used with type "add"
			
		Ex:
			pickup_text("BULLETS", "add", 32)                == "+32 BULLETS"
			pickup_text("HP", "max")                         == "MAX HP"
			pickup_text("RADS", "low")                       == "LOW RADS"
			pickup_text("RADS", "ins")                       == "NOT ENOUGH RADS"
			pickup_text("BOLTS", "out")                      == "EMPTY"
			pickup_text(weapon_get_name(wep_slugger), "got") == "SLUGGER!"
	*/
	
	var	_text     = argument[0],
		_type     = ((argument_count > 1) ? argument[1] : undefined),
		_num      = ((argument_count > 2) ? argument[2] : undefined),
		_ammo     = ["MELEE", "BULLETS", "SHELLS", "BOLTS", "EXPLOSIVES", "ENERGY"],
		_ammoType = -1;
		
	 // Determine Ammo Type (Auto-Locale Support):
	for(var i = array_length(_ammo) - 1; i >= 0; i--){
		if(_text == loc(`Ammo:Type:${i}`, _ammo[i])){
			_ammoType = i;
		}
	}
	
	 // Create Popup Text:
	with(instance_create(x, y, PopupText)){
		switch(_type){
			
			case "add": // +# TEXT
			
				switch(_text){
					
					case "HP":
					
						text = call(scr.loc_format, "Pickups:AddHealth", "+% HP", _num);
						
						break;
						
					case "PORTAL STRIKES":
					
						text = loc(
							`Pickups:AddStrikes:${_num}`,
							call(scr.loc_format, "Pickups:AddStrikes", "+% PORTAL STRIKES", _num)
						);
						
						break;
						
					default:
					
						 // Ammo Types:
						if(_ammoType >= 0){
							text = call(scr.loc_format,
								`Pickups:AddAmmo:${_ammoType}`,
								call(scr.loc_format, "Pickups:AddAmmo", "+%1 %2", "%", _text),
								_num
							);
						}
						
						 // Normal:
						else text = call(scr.loc_format, "Pickups:AddAmmo", "+%1 %2", _num, _text);
						
				}
				
				 // Flip Sign:
				if(_num < 0){
					text = string_replace_all(text, "+", "");
				}
				
				break;
				
			case "max": // MAX TEXT
			
				switch(_text){
					
					case "HP":
					
						text = loc("Pickups:MaxHealth", "MAX HP");
						
						break;
						
					case "PORTAL STRIKES":
					
						text = loc("Pickups:MaxStrikes", "MAX PORTAL STRIKES");
						
						break;
						
					default:
					
						text = call(scr.loc_format, "Pickups:MaxAmmo", "MAX %", _text);
						
						 // Ammo Types:
						if(_ammoType >= 0){
							text = loc(`Pickups:MaxAmmo:${_ammoType}`, text);
						}
						
				}
				
				break;
				
			case "low": // LOW TEXT
			
				switch(_text){
					
					case "HP":
					
						text = loc("HUD:LowHealth", "LOW HP");
						
						break;
						
					default:
					
						text = call(scr.loc_format, "HUD:LowAmmo", "LOW %", _text);
						
						 // Ammo Types:
						if(_ammoType >= 0){
							text = loc(`HUD:LowAmmo:${_ammoType}`, text);
						}
						
				}
				
				break;
				
			case "ins": // NOT ENOUGH TEXT
			
				switch(_text){
					
					case "RADS":
					
						text = loc("HUD:InsRads", "NOT ENOUGH RADS");
						
						break;
						
					default:
					
						text = call(scr.loc_format, "HUD:InsAmmo", "NOT ENOUGH %", _text);
						
						 // Ammo Types:
						if(_ammoType >= 0){
							text = loc(`HUD:InsAmmo:${_ammoType}`, text);
						}
						
				}
				
				break;
				
			case "out": // EMPTY
			
				text = call(scr.loc_format, "HUD:NoAmmo", "EMPTY", _text);
				
				 // Ammo Types:
				if(_ammoType >= 0){
					text = loc(`HUD:NoAmmo:${_ammoType}`, text);
				}
				
				break;
				
			case "got": // TEXT!
			
				text = call(scr.loc_format, "HUD:GotWeapon", "%!", _text);
				
				break;
				
			default: // TEXT
			
				text = _text;
				
		}
		
		 // Target Player's Screen:
		if(instance_is(other, Player)){
			target = other.index;
		}
		
		return self;
	}
	
	return noone;

#macro infinity 1/0
#macro player_active                                                                           visible && !instance_exists(GenCont) && !instance_exists(LevCont) && !instance_exists(SitDown) && !instance_exists(PlayerSit)
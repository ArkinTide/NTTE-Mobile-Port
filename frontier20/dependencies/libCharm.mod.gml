/*	               Charm
	This is the Charm package of Lib.
	It contains a method to charm enemies.
*/
	
// Original implementation taken from NTTE

/*
||||||||||||||||||||||||UNFINISHED PACKAGE||||||||||||||||||||||||||||
*/

//For internal use, adds the script to be easily usable.
#define addScript(name)
	lq_set(instances_matching(CustomObject, "name", "libGlobal")[0].scriptReferences, name, ["mod", mod_current, name]);

#define init
	script_ref_call(["mod", "lib", "updateRef"]);
	global.isLoaded = true;
	
	script_ref_call(["mod", "lib", "getRef"], "mod", mod_current, "scr");
	
	charm_object        = [hitme, becomenemy, ReviveArea, NecroReviveArea, RevivePopoFreak];
	charm_instance_list = [];
	charm_instance_vars = [];
	charm_bind_draw     = [];
	for(var i = -1; i < maxp; i++){
		array_push(charm_bind_draw, script_bind(CustomDraw, script_ref_create(charm_draw, [], i), 0, false));
	}

#define update(_newID)
	if(array_length(charm_instance_list)){
		 // Grab Charmed Objects:
		with(charm_object){
			if(instance_exists(self) && self.id > _newID){
				with(instances_matching_gt(self, "id", _newID)){
					 // 'instance_copy()' Fix:
					if("ntte_charm" in self && ntte_charm.charmed && array_find_index(charm_instance_list, self) < 0){
						ntte_charm = lq_clone(ntte_charm);
						array_push(charm_instance_list, self);
						array_push(charm_instance_vars, ntte_charm);
					}
					
					 // Inherit Charm from Creator:
					else if("creator" in self){
						var _hitme = (instance_is(self, hitme) || instance_is(self, becomenemy));
						with(charm_instance_list){
							if(other.creator == self || ("creator" in self && !instance_is(self, hitme) && other.creator == creator)){
								if(!_hitme || !instance_exists(self) || place_meeting(x, y, other)){
									var	_vars  = charm_instance_vars[array_find_index(charm_instance_list, self)],
										_charm = charm_instance(other, true);
										
									_charm.time    = _vars.time;
									_charm.index   = _vars.index;
									_charm.kill    = _vars.kill;
									_charm.feather = _vars.feather;
									
									if(_hitme){
										with(other){
											 // Kill When Uncharmed if Infinitely Spawned:
											if(instance_is(self, enemy) && !enemy_boss && kills <= 0){
												_charm.kill = true;
												raddrop = 0;
											}
											
											 // Featherize:
											if(_charm.feather && _charm.time >= 0){
												do{
													with(obj_create(x + orandom(24), y + orandom(24), "ParrotFeather")){
														target = other;
														index  = _charm.index;
														with(player_find(index)){
															other.bskin = bskin;
														}
														sprite_index = race_get_sprite(mod_current, sprite_index);
														_charm.time -= stick_time * 1.5;
													}
												}
												until(_charm.time <= 0);
												
												_charm.time = 15;
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
		
		 // Allied Crystal Fixes:
		if(instance_exists(crystaltype)){
			 // Charge Particles:
			if(instance_exists(LaserCrystal) || instance_exists(InvLaserCrystal)){
				if(instance_exists(LaserCharge) && LaserCharge.id > _newID){
					var _instCharm = instances_matching_ne([LaserCrystal, InvLaserCrystal], "ntte_charm", null);
					if(array_length(_instCharm)){
						with(instances_matching_gt(LaserCharge, "id", _newID)){
							with(_instCharm){
								if(ntte_charm.charmed){
									var	_x1  = other.xstart,
										_y1  = other.ystart,
										_x2  = x,
										_y2  = y,
										_dis = point_distance(_x1, _y1, _x2, _y2),
										_dir = point_direction(_x1, _y1, _x2, _y2);
										
									if(_dis < 5 || (other.alarm0 == floor(1 + (_dis / other.speed)) && abs(angle_difference(other.direction, _dir)) < 0.1)){
										team_instance_sprite(team, other);
										break;
									}
								}
							}
						}
					}
				}
			}
			
			 // Lightning:
			if(instance_exists(LightningCrystal)){
				if(instance_exists(EnemyLightning) && EnemyLightning.id > _newID){
					var _instCharm = instances_matching_ne(LightningCrystal, "ntte_charm", null);
					if(array_length(_instCharm)){
						with(instances_matching(instances_matching_gt(EnemyLightning, "id", _newID), "sprite_index", sprEnemyLightning)){
							if(!instance_exists(creator)){
								with(instances_matching(_instCharm, "team", team)){
									if(ntte_charm.charmed && distance_to_object(other) < 56){
										other.sprite_index = sprLightning;
										break;
									}
								}
							}
						}
					}
				}
			}
		}
	}
	
#define ntte_begin_step
	 // Charm Draw Setup:
	with(charm_bind_draw){
		if(instance_exists(id)){
			id.visible = false;
		}
		script[3] = [];
	}
	
	 // Charm Main Code:
	if(array_length(charm_instance_list)){
		var	_instNum  = 0,
			_instList = array_clone(charm_instance_list),
			_varsList = array_clone(charm_instance_vars);
			
		with(_instList){
			var _vars = _varsList[_instNum++];
			if(_vars.charmed){
				if(instance_exists(self)){
					 // Main Code:
					if("ntte_charm_override" not in self || !ntte_charm_override){
						var	_lastDir  = direction,
							_isCustom = (string_pos("Custom", object_get_name(object_index)) == 1);
							
						 // Emergency Target:
						if(!instance_exists(_vars.target)){
							with(charm_target(_vars)){
								with(self[0]){
									x = other[1];
									y = other[2];
								}
							}
						}
						
						 // Increased Aggro:
						if(alarm1 > 0 && current_frame_active && instance_is(self, enemy)){
							var _aggroSpeed = ceil(((10 / max(1, size)) - 1) * max(1, current_time_scale));
							
							 // Boss Intro Over:
							if("intro" not in self || intro){
								 // Not Attacking:
								if(
									alarm2 < 0
									&& ("ammo" not in self || ammo <= 0)
									&& (sprite_index == spr_idle || sprite_index == spr_walk || sprite_index == spr_hurt)
									&& (!instance_exists(projectile)      || !array_length(instances_matching(projectile,      "creator", self)))
									&& (!instance_exists(ReviveArea)      || !array_length(instances_matching(ReviveArea,      "creator", self)))
									&& (!instance_exists(NecroReviveArea) || !array_length(instances_matching(NecroReviveArea, "creator", self)))
								){
									 // Not Shielding:
									if(!instance_exists(PopoShield) || !array_length(instances_matching(PopoShield, "creator", self))){
										alarm1 = max(alarm1 - _aggroSpeed, 1);
									}
								}
							}
						}
						
						 // Custom (Override Step Event):
						if(_isCustom){
							if(!array_length(_vars.on_step) && is_array(on_step)){
								_vars.on_step = on_step;
								on_step = script_ref_create(charm_obj_step);
							}
						}
						
						 // Normal (Run Alarms):
						else{
							var _minID = undefined;
							
							for(var _alarmNum = 0; _alarmNum <= 10; _alarmNum++){
								var _alarm = alarm_get(_alarmNum);
								if(_alarm > 0 && _alarm <= ceil(current_time_scale)){
									var _playerPos = charm_target(_vars);
									
									if(is_undefined(_minID)){
										_minID = instance_max;
									}
									
									 // Call Alarm Event:
									with(self){
										if(_alarmNum != 2 || instance_exists(target) || !instance_is(self, Gator)){ // Gator Fix
											try{
												alarm_set(_alarmNum, 0);
												event_perform(ev_alarm, _alarmNum);
											}
											catch(_error){
												trace_error(_error);
											}
										}
									}
									
									 // Return Moved Players:
									with(_playerPos){
										with(self[0]){
											x = other[1];
											y = other[2];
										}
									}
									
									 // 1 Frame Extra:
									if(instance_exists(self)){
										_alarm = alarm_get(_alarmNum);
										if(_alarm > 0){
											alarm_set(_alarmNum, _alarm + 1);
										}
									}
									else break;
								}
							}
							
							 // Grab Spawned Things:
							if(!is_undefined(_minID)){
								charm_grab(_vars, _minID);
							}
						}
						
						 // Enemy Stuff:
						if(instance_is(self, enemy)){
							 // Add to Charm Drawing:
							if(visible){
								with(charm_bind_draw[_vars.index + 1].id){
									array_push(script[3], other);
									if(!visible || other.depth - 1 < depth){
										visible = true;
										depth   = other.depth - 1;
									}
								}
							}
							
							 // Follow Leader:
							if(instance_exists(Player)){
								if("ammo" not in self || ammo <= 0){
									if(
										meleedamage <= 0
										|| "gunangle" in self
										|| ("walk" in self && walk > 0 && !instance_is(self, ExploFreak))
									){
										if(
											!instance_exists(_vars.target)
											|| collision_line(x, y, _vars.target.x, _vars.target.y, Wall, false, false)
											|| distance_to_object(_vars.target) > 80
											|| distance_to_object(Player) > 256
										){
											 // Player to Follow:
											var _follow = player_find(_vars.index);
											if(!instance_exists(_follow)){
												_follow = instance_nearest(x, y, Player);
											}
											
											 // Stay in Range:
											if(instance_exists(_follow) && distance_to_object(_follow) > 32){
												motion_add_ct(point_direction(x, y, _follow.x, _follow.y), 1);
											}
										}
									}
								}
							}
							
							 // Contact Damage:
							if(place_meeting(x, y, enemy)){
								var _inst = instances_meeting(x, y, instances_matching_ne(enemy, "team", team));
								if(array_length(_inst)) with(_inst){
									if(place_meeting(x, y, other)) with(other){
										var	_lastFreeze   = UberCont.opt_freeze,
											_lastGamma    = skill_get(mut_gamma_guts),
											_lastNextHurt = (("nexthurt" in other) ? other.nexthurt : 0);
											
										 // Disable Freeze Frames:
										UberCont.opt_freeze = 0;
										
										 // Gamma Guts Fix (It breaks contact damage idk):
										skill_set(mut_gamma_guts, false);
										
										 // Speed Up 'canmelee' Reset:
										if(alarm11 > 0 && alarm11 < 26){
											with(self){
												event_perform(ev_alarm, 11);
											}
										}
										
										 // Collision:
										event_perform(ev_collision, Player);
										
										 // No I-Frames:
										if("nexthurt" in other){
											other.nexthurt = _lastNextHurt;
										}
										
										 // Reset Stuff:
										UberCont.opt_freeze = _lastFreeze;
										skill_set(mut_gamma_guts, _lastGamma);
									}
								}
							}
						}
						
						 // Object-Specifics:
						if(instance_exists(self) && !_isCustom){
							switch(object_index){
								
								case BigMaggot:
									
									if(
										alarm1 < 0
										&& instance_exists(_vars.target)
										&& !collision_line(x, y, _vars.target.x, _vars.target.y, Wall, false, false)
									){
										alarm1 = 900; // JW u did this to me
									}
									
									break;
									
								case MeleeBandit:
								case JungleAssassin:
									
									if(walk > 0){
										var _spd = ((object_index == JungleAssassin) ? 1 : 2) * current_time_scale;
										
										 // Fix Janky Movement:
										direction = _lastDir;
										
										 // Undo Player Following:
										if(instance_exists(Player)){
											var	_ox = lengthdir_x(_spd, _lastDir),
												_oy = lengthdir_y(_spd, _lastDir);
												
											if(place_free(x - _ox, y)) x -= _ox;
											if(place_free(x, y - _oy)) y -= _oy;
										}
										
										 // Move Towards Target:
										if(instance_exists(_vars.target)){
											mp_potential_step(_vars.target.x, _vars.target.y, _spd, false);
										}
									}
									
									break;
									
								case Sniper:
									
									 // Aim at Target:
									if(alarm2 > 5 && instance_exists(_vars.target)){
										gunangle = point_direction(x, y, _vars.target.x, _vars.target.y);
										script_bind_step(charm_sniper_gunangle, 0, self, gunangle);
									}
									
									break;
									
								case ScrapBoss:
									
									 // Move Towards Target:
									if(walk > 0 && instance_exists(_vars.target)){
										motion_add(point_direction(x, y, _vars.target.x, _vars.target.y), 0.5);
									}
									
									break;
									
								case ScrapBossMissile:
									
									 // Move Towards Target:
									if(sprite_index != spr_hurt && instance_exists(_vars.target)){
										motion_add_ct(point_direction(x, y, _vars.target.x, _vars.target.y), 0.2);
									}
									
									break;
									
								case LilHunterFly:
									
									 // Land on Enemies:
									if(sprite_index == sprLilHunterLand && z < -160){
										if(instance_exists(_vars.target)){
											x = _vars.target.x;
											y = _vars.target.y;
										}
									}
									
									break;
									
								case ExploFreak:
								case RhinoFreak:
									
									 // Move Towards Target:
									var _spd = current_time_scale;
									if(instance_exists(Player)){
										var	_ox = lengthdir_x(_spd, _lastDir),
											_oy = lengthdir_y(_spd, _lastDir);
											
										if(place_free(x - _ox, y)) x -= _ox;
										if(place_free(x, y - _oy)) y -= _oy;
									}
									if(instance_exists(_vars.target)){
										mp_potential_step(_vars.target.x, _vars.target.y, _spd, false);
									}
									
									break;
									
								case Shielder:
								case EliteShielder:
									
									 // Fix Shield Team:
									var _inst = instances_matching(PopoShield, "creator", self);
									if(array_length(_inst)) with(_inst){
										team = other.team;
									}
									
									break;
									
								case Inspector:
								case EliteInspector:
									
									 // Fix Telekinesis Pull:
									if(control == true){
										var _inst = instances_matching([Player, Ally], "team", team);
										if(array_length(_inst)){
											var _dis = (1 + (object_index == EliteInspector)) * current_time_scale;
											with(_inst){
												if(point_distance(x, y, other.x, other.y) < 160){
													var	_dir = point_direction(x, y, other.x, other.y),
														_ox  = lengthdir_x(_dis, _dir),
														_oy  = lengthdir_y(_dis, _dir);
														
													if(place_free(x + _ox, y)) x -= _ox;
													if(place_free(x, y + _oy)) y -= _oy;
												}
											}
										}
									}
									
									break;
									
								case EnemyHorror:
									
									 // Don't Shoot Beam at Player:
									if(ammo > 0 && instance_exists(_vars.target)){
										var _player = instance_nearest(x, y, Player);
										if(instance_exists(_player)){
											gunangle = point_direction(x, y, _player.x, _player.y);
											
											if(abs(angle_difference(point_direction(x, y, _vars.target.x, _vars.target.y), gunangle + gunoffset)) > 10){
												gunoffset = angle_difference(point_direction(x, y, _vars.target.x, _vars.target.y), gunangle) + orandom(10);
											}
										}
									}
									
									break;
									
							}
						}
					}
					
					 // Reset Step Event:
					else if(array_length(_vars.on_step)){
						on_step = _vars.on_step;
						_vars.on_step = [];
					}
					
					if(instance_is(self, hitme) || instance_is(self, becomenemy)){
						 // <3
						if(random(200) < current_time_scale){
							with(instance_create(x + orandom(8), y - random(8), AllyDamage)){
								sprite_index  = sprHealFX;
								image_xscale *= random_range(2/3, 1);
								image_yscale  = image_xscale;
								motion_add(other.direction, 1);
								speed /= 2;
							}
						}
						
						 // Level Over:
						if(_vars.kill && instance_is(self, enemy) && !array_length(instances_matching_ne(instances_matching_ne(enemy, "team", team), "object_index", Van))){
							charm_instance(self, false);
						}
						
						 // Charm Timer:
						else if(_vars.time >= 0){
							_vars.time -= min(_vars.time, current_time_scale);
							if(_vars.time <= 0 && instance_is(self, hitme)){
								charm_instance(self, false);
							}
						}
						
						 // Charm Bros Spawned on Death:
						switch(object_index){
							
							case BigMaggot:
							case MaggotSpawn:
							case JungleFly:
							case FiredMaggot:
							case RatkingRage:
							case InvSpider:
								
								if(
									my_health <= 0
									|| (object_index == FiredMaggot && place_meeting(x + hspeed_raw, y + vspeed_raw, Wall))
									|| (object_index == RatkingRage && walk > 0 && walk <= current_time_scale)
								){
									var _minID = instance_max;
									instance_destroy();
									with(instances_matching_gt(charm_object, "id", _minID)){
										creator = other;
									}
								}
								
								break;
								
						}
					}
					else if(!instance_exists(self)){
						_vars.charmed = false;
					}
				}
				else _vars.charmed = false;
			}
			
			 // Done:
			else{
				var _pos = array_find_index(charm_instance_list, self);
				charm_instance_list = array_delete(charm_instance_list, _pos);
				charm_instance_vars = array_delete(charm_instance_vars, _pos);
			}
		}
	}
	
#define charm_instance_raw(_inst, _charm)
	/*
		Charms or uncharms the given instance(s) and returns a LWO containing their charm-related vars
		
		Ex:
			with(charm_instance(Bandit, true)){
				time = 300;
			}
	*/
	
	var _instVars = [];
	
	with(instances_matching_ne(_inst, "id", null)){
		if("ntte_charm" not in self){
			ntte_charm = charm_vars;
		}
		
		var _vars = ntte_charm;
		
		if(_charm ^^ _vars.charmed){
			 // Reset:
			if(_charm){
				var _varsDefault = charm_vars;
				for(var i = lq_size(_varsDefault) - 1; i >= 0; i--){
					lq_set(_vars, lq_get_key(_varsDefault, i), lq_get_value(_varsDefault, i));
				}
			}
			
			 // Become Enemy:
			var	_lastObject = object_index,
				_lastZ      = (("z" in self) ? abs(z) : 0);
				
			if(fork()){
				if(instance_is(self, becomenemy)){
					 // GMS2:
					try{
						if(!null){
							var	_lastMask       = mask_index,
								_lastSprite     = sprite_index,
								_lastImage      = image_index,
								_lastDepth      = depth,
								_lastVisible    = visible,
								_lastPersistent = persistent,
								_lastSolid      = solid;
								
							instance_change(CustomEnemy, false);
							
							mask_index   = _lastMask;
							sprite_index = _lastSprite;
							image_index  = _lastImage;
							depth        = _lastDepth;
							visible      = _lastVisible;
							persistent   = _lastPersistent;
							solid        = _lastSolid;
						}
					}
					
					 // GMS1:
					catch(_error){
						while(instance_is(self, becomenemy) && "team" not in self){
							wait 0;
						}
					}
				}
				
				 // Set/Reset Team:
				if("team" in self){
					var _lastTeam = team;
					team = _vars.team;
					_vars.team = _lastTeam;
				}
				
				exit;
			}
			
			 // Charm:
			if(_charm){
				 // Override Step Event:
				if(string_pos("Custom", object_get_name(object_index)) == 1){
					if(!array_length(_vars.on_step) && is_array(on_step)){
						_vars.on_step = on_step;
						on_step = script_ref_create(charm_obj_step);
					}
				}
				
				 // Delay Alarms:
				else for(var i = 0; i <= 10; i++){
					if(alarm_get(i) > 0){
						alarm_set(i, alarm_get(i) + 1);
					}
				}
				
				 // Necromancer Charm:
				switch(sprite_index){
					case sprReviveArea      : sprite_index = spr.AllyReviveArea;      break;
					case sprNecroReviveArea : sprite_index = spr.AllyNecroReviveArea; break;
				}
				
				 // Add:
				if(array_find_index(charm_instance_list, self) < 0){
					array_push(charm_instance_list, self);
					array_push(charm_instance_vars, _vars);
				}
			}
			
			 // Uncharm:
			else{
				if(instance_is(self, hitme) || instance_is(self, becomenemy)){
					 // I-Frames:
					//nexthurt = current_frame + 12;
					
					 // Enemies:
					if(instance_is(self, enemy)){
						 // Untarget:
						target = noone;
						
						 // Delay Contact Damage:
						if(canmelee == true){
							alarm11  = 30;
							canmelee = false;
						}
					}
					
					 // Kill:
					if(_vars.kill){
						if("my_health" in self){
							my_health = 0;
							sound_play_pitchvol(sndEnemyDie, 2 + orandom(0.3), 3);
						}
					}
					
					 // Wake Up Alert:
					else{
						with(instance_create(x, bbox_top - _lastZ, AssassinNotice)){
							depth = min(-7, other.depth - 1);
						}
						sound_play_hit_ext(sndAssassinGetUp, random_range(1.2, 1.5), 1.2);
					}
					
					 // Effects:
					var _num = (("size" in self && size == 0) ? 5 : 10);
					for(var _ang = direction; _ang < direction + 360; _ang += (360 / _num)){
						with(scrFX(x, y - _lastZ, [_ang, 4], Dust)){
							depth = other.depth + 1;
						}
					}
				}
				
				 // Necromancer Charm:
				if(sprite_index == spr.AllyReviveArea){
					sprite_index = sprReviveArea;
				}
				else if(sprite_index == spr.AllyNecroReviveArea){
					sprite_index = sprNecroReviveArea;
				}
				
				 // Reset Step Event:
				if(array_length(_vars.on_step)){
					on_step = _vars.on_step;
					_vars.on_step = [];
				}
			}
			
			 // Unbecome Enemy:
			if(object_index != _lastObject){
				var	_lastMask       = mask_index,
					_lastSprite     = sprite_index,
					_lastImage      = image_index,
					_lastDepth      = depth,
					_lastVisible    = visible,
					_lastPersistent = persistent,
					_lastSolid      = solid;
					
				instance_change(_lastObject, false);
				
				mask_index   = _lastMask;
				sprite_index = _lastSprite;
				image_index  = _lastImage;
				depth        = _lastDepth;
				visible      = _lastVisible;
				persistent   = _lastPersistent;
				solid        = _lastSolid;
			}
			
			 // Teamerize Nearby Projectiles:
			if(instance_is(self, hitme)){
				var _searchDis = 32;
				motion_step(1);
				if(distance_to_object(projectile) <= _searchDis){
					with(instance_rectangle_bbox(
						bbox_left   - _searchDis,
						bbox_top    - _searchDis,
						bbox_right  + _searchDis,
						bbox_bottom + _searchDis,
						instances_matching(instances_matching(projectile, "team", _vars.team), "creator", self)
					)){
						motion_step(1);
						if(place_meeting(x, y, other)){
							team = other.team;
							if(sprite_get_team(sprite_index) != 3){
								team_instance_sprite(team, self);
								if(!instance_exists(self)){
									continue;
								}
							}
						}
						motion_step(-1);
					}
				}
				motion_step(-1);
			}
		}
		
		_vars.charmed = _charm;
		
		array_push(_instVars, _vars);
	}
	
	 // Return:
	if(array_length(_instVars)){
		return (
			(is_array(_inst) || array_length(_instVars) > 1)
			? _instVars
			: _instVars[0]
		);
	}
	
	return noone;
	
#define charm_target(_vars)
	/*
		Targets a nearby enemy and moves the player to their position
		Returns an array containing the moved players and their previous position, [id, x, y]
	*/
	
	var	_playerPos   = [],
		_targetCrash = (!instance_exists(Player) && instance_is(self, Grunt)); // References player-specific vars in its alarm event, causing a crash
		
	 // Targeting:
	if(
		!instance_exists(_vars.target)
		|| collision_line(x, y, _vars.target.x, _vars.target.y, Wall, false, false)
		|| !instance_is(_vars.target, hitme)
		|| _vars.target.team == variable_instance_get(self, "team")
		|| _vars.target.team == variable_instance_get(player_find(_vars.index), "team")
		|| _vars.target.mask_index == mskNone
	){
		_vars.target = noone;
		
		var _inst = instances_matching_ne(instances_matching_ne([enemy, Player, Sapling, Ally, SentryGun, CustomHitme], "team", 0), "mask_index", mskNone);
		if(array_length(_inst)){
			 // Team Check:
			if("team" in self){
				_inst = instances_matching_ne(_inst, "team", team);
			}
			if(player_is_active(_vars.index)){
				with(player_find(_vars.index)){
					_inst = instances_matching_ne(_inst, "team", team);
				}
			}
			
			 // Target Nearest:
			var _disMax = infinity;
			if(array_length(_inst)) with(_inst){
				var _dis = point_distance(x, y, other.x, other.y);
				if(_dis < _disMax){
					if(!instance_is(self, prop)){
						_disMax = _dis;
						_vars.target = self;
					}
				}
			}
		}
	}
	
	 // Move Players to Target (the key to this system):
	if("target" in self){
		if(!_targetCrash){
			target = _vars.target;
		}
		
		with(Player){
			array_push(_playerPos, [self, x, y]);
			
			if(instance_exists(_vars.target)){
				x = _vars.target.x;
				y = _vars.target.y;
			}
			
			else{
				var	_l = 10000,
					_d = random(360);
					
				x += lengthdir_x(_l, _d);
				y += lengthdir_y(_l, _d);
			}
		}
	}
	
	return _playerPos;
	
#define charm_grab(_vars, _minID)
	/*
		Finds any charmable instances above the given minimum ID to set 'creator' on unowned ones, and resprite any projectiles to the charmed enemy's team
	*/
	
	if(instance_exists(GameObject) && GameObject.id > _minID){
		 // Set Creator:
		var _inst = instances_matching(instances_matching_gt(charm_object, "id", _minID), "creator", null, noone);
		if(array_length(_inst)){
			var _creator = (
				("creator" in self && !instance_is(self, hitme))
				? creator
				: self
			);
			with(_inst){
				creator = _creator;
			}
		}
		
		 // Ally-ify Projectiles:
		if(instance_exists(projectile) || instance_exists(LaserCannon)){
			var _inst = instances_matching_gt([projectile, LaserCannon], "id", _minID);
			if(array_length(_inst)){
				if("creator" in self && !instance_is(self, hitme)){
					_inst = instances_matching(_inst, "creator", self, noone, creator);
				}
				else{
					_inst = instances_matching(_inst, "creator", self, noone);
				}
			}
		}
	}
	
#define charm_obj_step
	var _vars = ntte_charm;
	if(array_length(_vars.on_step) >= 3){
		var	_minID     = instance_max,
			_playerPos = charm_target(_vars);
			
		 // Call Step Event:
		if(fork()){
			on_step = _vars.on_step;
			_vars.on_step = [];
			script_ref_call(on_step);
			exit;
		}
		
		 // Return Moved Players:
		with(_playerPos){
			with(self[0]){
				x = other[1];
				y = other[2];
			}
		}
		
		 // Reset Step:
		if(instance_exists(self)){
			_vars.on_step = on_step;
			on_step = script_ref_create(charm_obj_step);
		}
		
		 // Grab Spawned Things:
		charm_grab(_vars, _minID);
	}
	
#define charm_draw(_inst, _index)
	/*
		Draws green eyes and outlines for charmed enemies
	*/
	
	if(array_length(_inst)){
		if(lag) trace_time();
		
		var _outline = option_get("outline:charm");
		
		if(_outline || option_get("shaders")){
			if(_index < 0){
				_index = player_find_local_nonsync();
			}
			
			var	_vx = view_xview_nonsync,
				_vy = view_yview_nonsync,
				_gw = game_width,
				_gh = game_height;
				
			with(surface_setup("CharmScreen", _gw, _gh, game_scale_nonsync)){
				x = _vx;
				y = _vy;
				
				 // Copy & Clear Screen:
				draw_set_blend_mode_ext(bm_one, bm_zero);
				surface_screenshot(surf);
				draw_set_blend_mode(bm_normal);
				draw_clear_alpha(c_black, 0);
				
				 // Call Enemy Draw Events:
				var _lastTimeScale = current_time_scale;
				current_time_scale = 1/1000000000000000;
				try{
					with(instances_seen(_inst, 24, 24, -1)){
						with(self){
							event_perform(ev_draw, 0);
						}
					}
				}
				catch(_error){
					trace(_error);
				}
				current_time_scale = _lastTimeScale;
				
				 // Copy Enemy Drawing:
				with(surface_setup("Charm", w, h, (_outline ? option_get("quality:main") : scale))){
					x = other.x;
					y = other.y;
					
					 // Copy Enemy Drawing:
					draw_set_blend_mode_ext(bm_one, bm_zero);
					surface_screenshot(surf);
					
					 // Unblend Color/Alpha:
					if(shader_setup("Unblend", surface_get_texture(surf), [1])){
						draw_surface_scale(surf, x, y, 1 / scale);
						shader_reset();
						surface_screenshot(surf);
					}
					else{
						draw_set_blend_mode_ext(bm_inv_src_alpha, bm_one); // Partial Unblend
						surface_screenshot(surf);
						draw_set_blend_mode_ext(bm_one, bm_zero);
					}
					
					 // Redraw Screen:
					with(other){
						draw_surface_scale(surf, x, y, 1 / scale);
					}
					draw_set_blend_mode(bm_normal);
					
					 // Outlines:
					if(_outline){
						surface_set_target(other.surf);
						
						 // Solid Color:
						draw_set_fog(true, player_get_color(_index), 0, 0);
						for(var _ang = 0; _ang < 360; _ang += 90){
							draw_surface_scale(
								surf,
								(x - other.x + dcos(_ang)) * other.scale,
								(y - other.y - dsin(_ang)) * other.scale,
								other.scale / scale
							);
						}
						draw_set_fog(false, 0, 0, 0);
						
						 // Cut Out Enemy:
						draw_set_blend_mode_ext(bm_zero, bm_inv_src_alpha);
						draw_surface_scale(surf, (x - other.x) * other.scale, (y - other.y) * other.scale, other.scale / scale);
						draw_set_blend_mode(bm_normal);
						
						surface_reset_target();
						
						 // Draw to Screen:
						with(other){
							draw_surface_scale(surf, x, y, 1 / scale);
						}
					}
					
					 // Eye Shader:
					if(shader_setup("Charm", surface_get_texture(surf), [w, h])){
						draw_surface_scale(surf, x, y, 1 / scale);
						shader_reset();
					}
				}
			}
		}
		
		if(lag) trace_time(script[2] + " " + string(_index));
	}
	
#define charm_sniper_gunangle(_inst, _direction)
	with(_inst){
		gunangle = _direction;
	}
	instance_destroy();
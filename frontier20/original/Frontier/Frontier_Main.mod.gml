#define init

	 // LIB:
	while(!mod_exists("mod", "lib")){wait(1);}
	script_ref_call(["mod", "lib", "getRef"], "mod", mod_current, "scr");
	#macro  scr			global.scr
	#macro  call		script_ref_call
	
	if(fork()){
		while(!mod_exists("mod", "libSaves")){wait(1);}
			
			// Save File:
			call(scr.save_load, "Frontier", {
				 // Meta:
				cache_level     		: 0, 
				
				 // Unlocks:
				unlock_bubbles			: 0,
				unlock_bubbles_bskin	: 0,
				unlock_bubbles_cskin	: 0,
				
				 // Stats:
				meals_eaten				: 0,
				surgeries_received  	: 0,
				augments_taken			: 0,
				pirate_conversions		: [],
				pirate_trades			: 0,
				caches_opened			: 0,
				deeplabs_finales		: 0,
				decryptors_collected	: 0,
				cyberspace_visits		: 0,
				hoarder_kills			: 0,
				hoarder_escapes			: 0,
				test_subjects_rescued	: 0,
				test_subjects_killed	: 0,
				test_subjects_abandoned	: 0,
				
				 // Bubbles Stats:
				bubbles_kills			: 0,
				bubbles_loops			: 0,
				bubbles_runs			: 0,
				bubbles_deaths			: 0,
				bubbles_wins			: 0,
				bubbles_time			: 0,
				bubbles_bubbles			: 0,
				bubbles_best_kills		: 0,
				bubbles_best_area		: 0
			});
	
		exit;
	}
    
     // VARS //
    global.levelStart				= false;
    global.desertSubarea			= 0;
   
     // SETTINGS //
    global.settingNewIDPD				= true;		// whether or not custom IDPD Units spawn. (default: true).
    global.settingVanillaGlow			= true; 	// If basegame things will glow in the dark that normally wouldn't (Trapfire, Salamanders, Fireballs, etc). (default: true).
    global.settingConfettiClean			= 1000;		// How much confetti is allowed at once before it will start being cleared. (default: 1000).
    global.settingVisualDecryptors		= true;		// Whether or not decryptors have visualized followers. (default: true).
    global.settingBigStrikeChests		= true;		// Whether or not big strike chests spawn. (default: true).
	global.settingThroneTeleporters		= true;		// Whether or not carpetskip teleporters spawn in throne room. (default:true).
	global.settingLabsRouteAltMode		= false;	// Whether or not labs route's new areas appear as alt areas instead of the standard alternate route. (default: false).
	global.settingSurgeriesBeta			= false;	// toggles the work-in-progress surgeries feature to appear in vaults. (default: false).
	global.settingAltCoveEntrance		= false;	// makes cove's entrance spawn in scrapyard instead of crystal caves.
	global.settingCyberspaceEnabled		= true;		// just here for the robot (!) icon.
	global.settingTradeFishMode			= "OFF";	// tradefish for tradeable weapons:
	global.settingNightEventSpawnChance	= 0.2;		// default chance for nightloops
	global.settingCrushTrapSpawnrate	= 1;		// spawn multiplier for crushtraps
    
     // SPRITES //
    global.sprFloorCrushBlock					= sprite_add("sprites/areas/palace/sprFloorCrushBlock.png", 					1, 0, 0);
    global.sprFloorProtoCache					= sprite_add("sprites/areas/vault/sprFloorProtoCache.png",						21, 0, 0);
    global.sprFloorBloodFountain				= sprite_add("sprites/areas/vault/sprFloorBloodFountain.png",					9, 0, 0);
    global.sprNewRobot							= sprite_add("sprites/menu/sprNewRobot.png",									1, 4, 4);	
    
     // Details+ //
	global.sprGraveyardProtoStatueDecal			= sprite_add("sprites/areas/graveyard/sprGraveyardProtoStatueDecal.png",		1, 32, 32);
	global.sprGraveyardProtoStatueDecalDead		= sprite_add("sprites/areas/graveyard/sprGraveyardProtoStatueDecalDead.png",	2, 32, 32);
	global.sprGraveyardScorch					=[	sprite_add("sprites/areas/graveyard/sprGraveyardScorch.png",				1, 24, 24),
													sprite_add("sprites/areas/graveyard/sprGraveyardScorch2.png",				1, 24, 24)];
	global.sprGraveyardScorchTop				=[	sprite_add("sprites/areas/graveyard/sprGraveyardScorchTop.png",				1, 24, 24),
													sprite_add("sprites/areas/graveyard/sprGraveyardScorchTop2.png",			1, 24, 24)];
	global.sprDesertBNightScorch				=[  sprite_add("sprites/areas/desert/night/sprDesertBNightScorch.png",			1, 24, 24)];
	global.sprDesertBNightScorchTop				=[	sprite_add("sprites/areas/desert/night/sprDesertBNightScorchTop.png",		1, 24, 24)];
	global.sprCityNightScorch					=[	sprite_add("sprites/areas/frozencity/night/sprCityNightScorch.png",			1, 24, 24),
													sprite_add("sprites/areas/frozencity/night/sprCityNightScorch2.png",		1, 24, 24)];
	global.sprCityNightScorchTop				=[	sprite_add("sprites/areas/frozencity/night/sprCityNightScorchTop.png",		1, 24, 24),
													sprite_add("sprites/areas/frozencity/night/sprCityNightScorchTop2.png",		1, 24, 24)];
	global.sprCityExploNightScorch				=[	sprite_add("sprites/areas/frozencity/night/sprCityExploNightScorch.png",	1, 24, 24),
													sprite_add("sprites/areas/frozencity/night/sprCityExploNightScorch2.png",	1, 24, 24)];
	global.sprCityBNightScorch					=[	sprite_add("sprites/areas/frozencity/night/sprCityBNightScorch.png",		1, 24, 24),
													sprite_add("sprites/areas/frozencity/night/sprCityBNightScorch2.png",		1, 24, 24)];
	global.sprCityBNightScorchTop				=[	sprite_add("sprites/areas/frozencity/night/sprCityBNightScorchTop.png",		1, 24, 24),
													sprite_add("sprites/areas/frozencity/night/sprCityBNightScorchTop2.png",	1, 24, 24)];
	global.sprCoastNightScorch					=[ sprite_add("sprites/areas/coast/night/sprCoastNightScorch.png",				1, 24, 24)];
	global.sprCoastNightScorchTop				=[ sprite_add("sprites/areas/coast/night/sprCoastNightScorchTop.png",			1, 24, 24)];

     // Labs Entrance:
	global.sprFloorEntranceFrocity      		= sprite_add("sprites/areas/outpost/sprSnowFloorOutpost.png",						4, 16, 16);
	global.sprWallEntranceFrocityBot    		= sprite_add("sprites/areas/FrozenCity/sprCityWallEntranceBot.png", 				3, 0, 0);
	global.sprWallEntranceFrocityBotNight    	= sprite_add("sprites/areas/FrozenCity/Night/sprCityWallEntranceBotNight.png",		3, 0, 0);
	global.sprWall5TopNight						= sprite_add("sprites/areas/frozencity/night/sprWall5TopNight.png", 				4, 0, 0);
	global.sprWall5OutNight						= sprite_add("sprites/areas/frozencity/night/sprWall5OutNight.png", 				2, 4, 12);
	global.sprSnowFloorEntrance			   		= sprite_add("sprites/areas/outpost/sprSnowFloorOutpostSnow.png",					4, 16, 16);
	global.sprSnowFloorEntranceNight			= sprite_add("sprites/areas/outpost/night/sprSnowFloorOutpostSnowNight.png",		4, 16, 16);
	
	#macro  current_frame_active 				frac(current_frame) < current_time_scale
	#macro  anim_end 							(image_index + image_speed >= image_number || image_index + image_speed < 0)
	#macro  FloorNormal							instances_matching(Floor, "object_index", Floor)
	#macro  bbox_center_x                       (bbox_left + bbox_right + 1) / 2;
	#macro  bbox_center_y                       (bbox_top + bbox_bottom + 1) / 2;
	#macro  currently_outside					(array_find_index([1, 3, 5, 0, 105, "coast"], GameCont.area) >= 0) || (is_string(GameCont.area) && (mod_script_call("area", GameCont.area, "area_outside") = true))
	
#define game_start

	 // Ensure Options are Loaded:
    if(mod_exists("mod", "Frontier_Options")){
    	mod_script_call("mod", "Frontier_Options", "ExternalOptions_load")
    }

	 // GameConts:
    with(GameCont){
        fr_decryptors			= 0;
        fr_captainCutlass		= 0;
        fr_bigStrikeChest		= 0;
		fr_mealChestChance		= 1;
        fr_casinoAlert			= false;
        fr_deeplabsDecal		= false;
        fr_visitedCyberspace	= false;
        fr_hoarderLoop			= GameCont.loops - 1;
        fr_prevLoop				= GameCont.loops - 1;
        fr_jungleToGraveyard	= false;
    }
    
     // Night Loop:
	mod_variable_set("mod", "Frontier_Events", "nightLoop", false);
	if(random(1) < global.settingNightEventSpawnChance){
		mod_variable_set("mod", "Frontier_Events", "nightLoop", true);
	}
    
     // bigtube init
    mod_script_call("area", "deeplabs", "BigTubeObjects_init");
	
	 // fix cyberspace bug + run compat pool check:
	mod_variable_set("area", "cyberspace", "reskinMe", false);
	mod_script_call("area", "cyberspace", "Processor_compat_additions")
	
	 // varia thundershock
	mod_variable_set("area", "graveyard", "variaThundershockBroken", false);
	
	 // check for mod projectiles:
	mod_script_call("weapon", "FR_Wormhole", "WormholeList_init")
	
	 // import alt areas:
	altareas_import_frontier();
	detailsPlus_import_frontier();

#define draw_bloom
	with(instances_matching_ne([CustomProjectile, CustomObject, CustomSlash], "fr_bloom", null)){
		draw_sprite_ext(sprite_index, image_index, x, y, (fr_bloom[0] * image_xscale), (fr_bloom[0] * image_yscale), image_angle, image_blend, fr_bloom[1]);
	}
	
#define draw_dark
	draw_set_color($808080);
	
	 // Main Draw:
	with(instances_matching_ne([CustomObject, CustomProjectile, CustomEnemy, CustomProp], "fr_glow", null)){
		draw_circle(x, y, fr_glow[1] + random(3), false);
	}
	 
	 // Special Cases:
	with(instances_matching(CustomObject,		"name", "fr_ProtoCache")) 				draw_circle(x, y - 10,	96 + sin(current_frame * 0.03) * 2 + random(1), false);
	with(instances_matching(CustomObject,		"name", "fr_TreasureMimic")) 			draw_circle(x, y,		32 + sin(current_frame * 0.03) * 2 + random(1), false);
	with(instances_matching(CustomProp,			"name", "fr_BloodFountain")) 			draw_circle(x, y + 10,	48 + sin(current_frame * 0.03) * 2 + random(1), false);
	 
	 // VanillaGlow:
	if(global.settingVanillaGlow = true){
		with(TrapFire)			draw_circle(x, y,		32 + random(3), false);
		with(FireBall)			draw_circle(x, y,		32 + random(3), false);
		with(FlameShell)		draw_circle(x, y,		48 + random(3), false);
		with(Salamander)		draw_circle(x, y,		48 + random(3), false);
		with(DogGuardian)		draw_circle(x, y,		48 + random(3), false);
		with(Guardian)			draw_circle(x, y - 6,	48 + random(3), false);
		with(ExploGuardian) 	draw_circle(x, y,		48 + random(3), false);
		with(CrownGuardian) 	draw_circle(x, y - 6,	48 + random(3), false);
		with(EnemyHorror)		draw_circle(x, y,		32 + random(3), false);
		with(GuardianStatue)	draw_circle(x, y,		48 + random(1), false);
		with(GroundFlame)		draw_circle(x, y,		20 + random(3), false);
		with(BlueFlame)			draw_circle(x, y,		20 + random(1), false);
	}
	
	// Half-Darkness Effect:			  
	with(instances_matching(CustomObject, "name", "fr_area_halfdark")) {
		draw_rectangle(view_xview_nonsync, view_yview_nonsync, view_xview_nonsync + game_width, view_yview_nonsync + game_width, 0);
	}

#define draw_dark_end
	draw_set_color($000000);
	
	// shine like a star!
	with(instances_matching_ne([CustomObject, CustomProjectile, CustomEnemy, CustomProp], "fr_glow", null)){
		draw_circle(x, y, fr_glow[0] + random(3), false);
	}
	
	 // Special Cases:
	with(instances_matching(CustomObject,		"name", "fr_ProtoCache")) 				draw_circle(x, y - 10,	64 + sin(current_frame * 0.03) * 2 + random(1), false);
	with(instances_matching(CustomObject,		"name", "fr_TreasureMimic")) 			draw_circle(x, y,		24 + sin(current_frame * 0.03) * 2 + random(1), false);
	with(instances_matching(instances_matching(CustomObject, "name", "fr_CarHonkController"), "lightsOn", true)){
		if(instance_exists(owner)){
			draw_sprite_ext(spr_light, 0, x - (45 * image_xscale), y, owner.image_xscale, owner.image_yscale + random(0.1), owner.image_angle, c_white, 1);	
		}
	}
	with(instances_matching(TopDecalCity,		"name", "fr_RobocenterDecal")) 			draw_circle(x, y - 8, fr_glow[1] + random(2), false);
	with(instances_matching(CustomProp,			"name", "fr_BloodFountain")) 			draw_circle(x, y + 10,	32 + sin(current_frame * 0.03) * 2 + random(1), false);

	 // VanillaGlow:
	if(global.settingVanillaGlow = true){
		with(TrapFire)			draw_circle(x, y,		24 + random(3), false);
		with(FireBall)			draw_circle(x, y,		24 + random(3), false);
		with(FlameShell)		draw_circle(x, y,		32 + random(3), false);
		with(Salamander)		draw_circle(x, y,		32 + random(3), false);
		with(DogGuardian)		draw_circle(x, y,		32 + random(3), false);
		with(Guardian)			draw_circle(x, y - 6,	32 + random(3), false);
		with(ExploGuardian) 	draw_circle(x, y,		32 + random(3), false);
		with(CrownGuardian) 	draw_circle(x, y - 6,	32 + random(3), false);
		with(EnemyHorror)		draw_circle(x, y,		16 + random(3), false);
		with(GuardianStatue)	draw_circle(x, y,		32 + random(1), false);
		with(GroundFlame)		draw_circle(x, y,		12 + random(3), false);
		with(BlueFlame)			draw_circle(x, y,		14 + random(1), false);
	}

//#define draw_shadows
/*
	theres not enough things using this to justify having it on atm

	with(instances_matching_ne(CustomObject, "fr_spr_shadow", null)){
		draw_sprite(fr_spr_shadow, 0, x, y + fr_spr_shadow_y);
	}
*/
#define step
	 // Character Buttons:
	if(instance_exists(CharSelect)){
		if(mod_exists("mod", "libSaves")){
	
			 // Lock CharSelects, and do the little icon (update list as needed):
			var _inst = instances_matching(CharSelect, "race", "bubbles"/*, "cactus"*/)
			
			with(_inst){
				var _name = race;
				with(instances_matching(CharSelect, "race", _name)){
					 // race_avail Click Fix:
					if(mod_script_exists("race", _name, "race_avail") && !mod_script_call_nc("race", _name, "race_avail")){
						noinput = 10;
					} 
					 // Draw New Race Icon:
					else {
						var _stat = _name + string("_runs")
						if(call(scr.save_get, "Frontier", _stat) <= 0){
							script_bind_draw(CharSelect_draw_new, depth - 1, self);
						}
					}
				}
			}
			
			 // draw robot passive icon
			with(instances_matching(CharSelect, "race", "robot")){
				if(global.settingCyberspaceEnabled = true){
					if((call(scr.save_get, "Frontier", "cyberspace_visits") <= 0) && (call(scr.save_get, "Frontier", "deeplabs_finales") > 0)){
						script_bind_draw(CharSelect_draw_robot, depth - 1, self);
					}
				}
			}
		}
	}

		// Confetti Cleanup:
	/*
	if(instance_number(Confetti) > global.settingConfettiClean){
    	with(Confetti){
        	if (random(5) < 1){ 
        		instance_destroy() 
        	}
    	} 
	}
	*/
		// Feathers Fade over Time:
	with(Feather){ 
		if("fr_featherlifetime" not in self){ 
			fr_featherlifetime = 80;
		}
		if(speed <= 0){ 
			fr_featherlifetime -= current_time_scale;
		}
		if(fr_featherlifetime <= 0){
			image_alpha -= (0.07 * current_time_scale); 
		}
	}

		// STRIKER SPAWNS // 
	if(global.settingNewIDPD = true){
    	// Spawn Airstrikes:
    	with(instances_matching(instances_matching(CustomObject, "name", "IDPDPortal"), "fr_StrikerCheck", null)){
    		fr_StrikerCheck = true;
    		if(van = 1){
	    		if(random(3) < 1) && (GameCont.popolevel >= 32) && (currently_outside){
	    			mod_script_call("mod", "Frontier_IDPD", "PopoAirstrikeSpawner_create", x, y)
	    		}
    		}
		}
	}
    
    // Level Start:
    if(instance_exists(GenCont)){
        global.levelStart = true;
    }
    else{
        if(global.levelStart){
        	var _normalArea = (GameCont.hard > 1 && (instance_number(enemy) > instance_number(EnemyHorror)) && !(GameCont.area = "deeplabs") && (GameCont.area != "village") && (GameCont.area != "cyberspace"));
        	
        	  // Night Loop Decider:
        	 with(GameCont){
        	 	if("fr_prevLoop" not in self){
        	 		GameCont.fr_prevLoop = GameCont.loops - 1;
        	 	}
        	 }
        	 if(GameCont.loops != GameCont.fr_prevLoop){
        		GameCont.fr_prevLoop = GameCont.loops;
        		if(GameCont.loops != 0){ // done in game start
	        		mod_variable_set("mod", "Frontier_Events", "nightLoop", false);
	        		if(chance(global.settingNightEventSpawnChance, 1)){
	        			mod_variable_set("mod", "Frontier_Events", "nightLoop", true);
	        		}
        		}
        	 }
        	 
        	 // TradeFish
        	if(global.settingTradeFishMode != "OFF"){
        		mod_script_call("mod", "Frontier_Caves", "TradeFishController_create", 10016, 10016);
        	}
        	
        	 //#region CHEST SPAWNS:

             // Meal Chests:
			if(GameCont.hard > 6 && GameCont.area != 106){
				if((random(12) < GameCont.fr_mealChestChance) && _normalArea){
					with(call(scr.array_shuffle, FloorNormal)){
						if(distance_to_object(Player) > 256 && !place_meeting(x, y, hitme) && !place_meeting(x, y, chestprop)){
							var _num = 1 + irandom(skill_get(mut_open_mind));
							if(_num > 0){
								repeat(_num){
									with(call(scr.floor_room, x, y, 0, FloorNormal, 1, 1, "", 0, 0)){
										if(random(13) < 1) && (GameCont.hard > 8){
											mod_script_call("mod", "Frontier_Pickups", "MealMimic_create", x, y);
										} else {
											mod_script_call("mod", "Frontier_Pickups", "MealChest_create", x, y);
										}
									}
								}
							}
							break;
						}
					}
				}
			}
			
			 // Big Strike Canisters
			if(global.settingBigStrikeChests = true){
				mod_script_call("mod", "Frontier_Pickups", "RogueChestBigController_create", 10016, 10016);
				with(RogueChest){
					if(random(1) < GameCont.fr_bigStrikeChest){
						mod_script_call("mod", "Frontier_Pickups", "RogueChestBig_create", x, y);
						instance_delete(self);
					}
				}
			}
       
        	 //#endregion
        	 //#region DECRYPTOR HANDLING:
			if(GameCont.fr_decryptors > 0 && global.settingVisualDecryptors = true){
				repeat(GameCont.fr_decryptors){
					mod_script_call("mod", "Frontier_Pickups", "DecryptorFollower_create", 10016, 10016, call(scr.instance_random, Player));
				}
			}

        	 //#endregion
        	 
        	 //#endregion
        	 //#region HOARDER !!:
/*			if(_normalArea && random(100) < 1){
				with(instance_furthest(10000, 10000, Floor)){
					with(instance_nearest((((x * 2) + 10000) / 3) + random_range(-64, 64), (((y * 2) + 10000) / 3) + random_range(-64, 64), Floor)){
						mod_script_call("mod", "Frontier_Objects", "Hoarder_create", x + 16, y + 16);
						instance_create(x, y, PortalClear);
					}
				}
			}
*/
        	 //#endregion
        	 
             //#region AREA CHANGES:
        	switch(GameCont.area){
        	
        		//#region DESERT:
        		case 1:
        		case "desert":
        	
        			// Current Level -  for Oasis Statue
        			global.desertSubarea = GameCont.subarea;
        			
        			// Maggot Strike Can:
        			with(RogueChest){
        				var _floor = instance_nearest(x, y, Floor){
        					if(_floor.styleb = true){
        					//	if(random(2) < 1){
        							mod_script_call("mod", "Frontier_Pickups", "RogueChestMaggot_create", x, y)
        							instance_delete(self);
        					//	}
        					}
        				}
        			}
        	
        		break;
        		//#endregion
        		//#region SEWER:
        		case 2:
        		case "sewers":
        		with(BuffGator){
            	    if(random(12) < 1){
            	    	mod_script_call("mod", "Frontier_Objects", "Paintor_create", x, y);
            	        instance_delete(self);
            	    }
            	}

        		break;
        		//#endregion        
        		//#region SCRAPYARDS:
        		case 3:
        			
        			if(GameCont.subarea == 1){
        			
        				var	_toolkitFloor = [],
							_toolkitIndex = -1
        			
        				 // Tool Chest on 3-1:
						with(FloorNormal){
							if(point_distance(bbox_center_x, bbox_center_y, 10016, 10016) > 48){
								if(!place_meeting(x, y, Wall) && !place_meeting(x, y, prop) && !place_meeting(x, y, chestprop)){
									array_push(_toolkitFloor, self);
									_toolkitIndex++;
								}
							}
						}
						call(scr.array_shuffle,(_toolkitFloor));
        				if(_toolkitIndex >= 0) with(_toolkitFloor[_toolkitIndex--]){ 
        					mod_script_call("mod", "Frontier_Pickups", "ToolKitChest_create", x + 16, y + 16); 
        				}
        			}
        			
        			 // theres still some juice in this one:
        			with(Car){
        				if(random(20) < 1){
							mod_script_call("mod", "Frontier_Objects", "CarHonkController_create", x, y, self);        					
        				}
        			}
        			
					 // Cove Entrance:					
					if(global.settingAltCoveEntrance = true){
	        			if(GameCont.subarea == 3){
	        		
	        				var	_coveEntranceFloor = [],
								_coveEntranceIndex = -1
	        	
	 						with(FloorNormal){
								if(point_distance(bbox_center_x, bbox_center_y, 10016, 10016) > 48){
									if(!place_meeting(x, y, Wall) && !place_meeting(x, y, prop) && !place_meeting(x, y, chestprop)){
										array_push(_coveEntranceFloor, self);
										_coveEntranceIndex++;
									}
								}
							}
							call(scr.array_shuffle,(_coveEntranceFloor));
	        				if(_coveEntranceIndex >= 0) with(_coveEntranceFloor[_coveEntranceIndex--]){
	        					var	_w          = 1,
									_h          = 1,
									_type       = "",
									_dirOff     = 0,
									_floorDis   = 0,
									_spawnX     = x,
									_spawnY     = y,
									_spawnDis   = 128,
									_spawnFloor = FloorNormal;
		
								with call(scr.floor_room,_spawnX, _spawnY, _spawnDis, _spawnFloor, _w, _h, _type, _dirOff, _floorDis) {
								var	_myx = x - 16,
		    						_myy = y - 16;
		    						
									// Make Entrance Object:
									mod_script_call("mod", "Frontier_Caves", "ScrapyardCoveEntrance_create", x, y);
								}		
	        				}
	        			}
					}
        	
        		break;
        		//#endregion
        
        
        		//#region CRYSTAL CAVES:
        		case 4:
        		case "caves":
        	
        				// Spike Traps:
					with(instances_matching(Floor, "object_index", Floor)){
						if(!styleb) && (random(30) < 1) && (distance_to_object(Player) > 32){
				    		mod_script_call("mod", "Frontier_Caves", "SpikeTrap_create", x, y, false)	
						}
					}  
	
        				// Spider Traps:
					with(instances_matching(Floor, "object_index", Floor)){
						if(random(40) < 1) && (distance_to_object(Player) > 32){
				    		mod_script_call("mod", "Frontier_Caves", "SpiderTrap_create", x + 16, y + 16, false);
						}
					}  
					
					 // Hyper Lightning Crystal:
					if(random(12) < 1){
						with(HyperCrystal){
							mod_script_call("mod", "Frontier_Caves", "LightningHyperCrystalController_create", 10016, 10016, self)
						}
					}

					 // Cove Entrance:					
					if(global.settingAltCoveEntrance = false){
	        			if (GameCont.subarea == 1){
	        		
	        				var	_coveEntranceFloor = [],
								_coveEntranceIndex = -1
	        	
	 						with(FloorNormal){
								if(point_distance(bbox_center_x, bbox_center_y, 10016, 10016) > 48){
									if(!place_meeting(x, y, Wall) && !place_meeting(x, y, prop) && !place_meeting(x, y, chestprop)){
										array_push(_coveEntranceFloor, self);
										_coveEntranceIndex++;
									}
								}
							}
							call(scr.array_shuffle,(_coveEntranceFloor));
	        				if(_coveEntranceIndex >= 0) with(_coveEntranceFloor[_coveEntranceIndex--]){
	        					var	_w          = 1,
									_h          = 1,
									_type       = "",
									_dirOff     = 0,
									_floorDis   = 0,
									_spawnX     = x,
									_spawnY     = y,
									_spawnDis   = 128,
									_spawnFloor = FloorNormal;
		
								with call(scr.floor_room,_spawnX, _spawnY, _spawnDis, _spawnFloor, _w, _h, _type, _dirOff, _floorDis) {
								var	_myx = x - 16,
		    						_myy = y - 16;
		    						
									// Make Entrance Object:
									mod_script_call("mod", "Frontier_Caves", "CoveEntrance_create", x, y, false);
								}		
	        				}
	        			}
					}
        			
        		break;
        		//#endregion
        	
        		//#region FROZEN CITY:
        		case 5:
        		case "city":
        	
        			 // LABS ROUTE ENTRANCE //
        			if(GameCont.subarea == 1){
        				 // dont spawn if alt mode on, overridden by blaacmode.
        				if(global.settingLabsRouteAltMode = false) || (mod_exists("area", "scorpionboss")){
	        		
	        				var	_entranceFloor = [],
								_entranceIndex = -1
	        	
	 						with(FloorNormal){
								if(point_distance(bbox_center_x, bbox_center_y, 10016, 10016) > 48){
									if(!place_meeting(x, y, Wall) && !place_meeting(x, y, prop) && !place_meeting(x, y, chestprop)){
										array_push(_entranceFloor, self);
										_entranceIndex++;
									}
								}
							}
							call(scr.array_shuffle,(_entranceFloor));
	        				if(_entranceIndex >= 0) with(_entranceFloor[_entranceIndex--]){
	        				var	_w          = 3,
								_h          = 3,
								_type       = "",
								_dirOff     = 0,
								_floorDis   = 0,
								_spawnX     = x,
								_spawnY     = y,
								_spawnDis   = 128,
								_spawnFloor = FloorNormal;
		
							with(call(scr.floor_room,_spawnX, _spawnY, _spawnDis, _spawnFloor, _w, _h, _type, _dirOff, _floorDis)){
								var	_myx = x - 16,
			    					_myy = y - 16;
		    			
								// Make Entrance Object:
								with(mod_script_call("mod", "Frontier_Labs", "LabsEntrance_create", x, y)){
									portalPusher = mod_script_call("mod", "Frontier_Objects", "PortalPusher_create", x, y, 72);
								}
								instance_create(x - 32, y - 32, Wall);
								instance_create(x + 16, y - 32, Wall);
								instance_create(x + 16, y + 16, Wall);
								instance_create(x - 32, y + 16, Wall);
								// Resprite Floors:
								for(var j = 0; j < array_length(floors); j++){
									with(floors[j]){
										fr_labsentrance_check = true;
										sprite_index	= global.sprFloorEntranceFrocity;
										image_index		= irandom(5);
										depth			-= 2;
	
										with(instance_create(x + irandom_range(-1, 1), y - irandom_range(2, 3), SnowFloor)){
											sprite_index	= (call(scr.event_get_active, "Aurora") ? global.sprSnowFloorEntranceNight : global.sprSnowFloorEntrance);
											image_speed		= other.image_speed;
											image_index		= other.image_index;
											image_angle	   += random_range(-1, 1)
											depth			= other.depth + 1;
										}
									}
								}
							}		
								// Resprite Walls:
								with(Wall){ 
									if(point_distance(x, y, _myx, _myy) < 72){
							
										fr_labsentrance_check = true;
								
										if(call(scr.event_get_active, "Aurora")){
											topspr       = global.sprWall5TopNight;
											outspr       = global.sprWall5OutNight;
											sprite_index = global.sprWallEntranceFrocityBotNight;
										} else { 
											topspr       = sprWall5Top;
											outspr       = sprWall5Out;
											sprite_index = global.sprWallEntranceFrocityBot;
										}
									}
								}
	        				}
	        			}
        			}
        			
    		 	break;
    	    	//#endregion
            
    		 	//#region LABS:	
        	    case 6:
        	    
        	     // spawn deeplabs entrance:
        	    if(global.settingLabsRouteAltMode = true){
        	    	if(!mod_exists("mod", "betterPVP")){
        	    		mod_script_call("area", "robocenter", "DeeplabsEntrance_create", 10016, 10016);	
        	    	}
        	    }
        	    
        	    case "labs":
            
				 // Loop Spawns:
				/*
				if(GameCont.loops > 0){
					 // Roller Turrets:
					with(RhinoFreak) if(random(4) < 1){
						mod_script_call("mod", "Frontier_Enemies", "RollerTurret_create", x, y);
					}
				}
				*/
				
        			// Security Traps:
        		/*
				with(instances_matching(Floor, "object_index", Floor)){
					if (random(40) < 1) && (distance_to_object(Player) > 128){
						if ((sprite_index = sprFloor6) || (sprite_index = sprFloor6B)){
							with(call(scr.floor_room, x, y, 0, self, 1, 1, "", 0, 0)){
								mod_script_call("mod", "Frontier_Labs", "SecurityTrap_create", x, y)
							}
						}
					}
				}
				*/
            
        			// Ball Traps:
				with(instances_matching(Floor, "object_index", Floor)){
					if(random(50) < 1) && (distance_to_object(Player) > 128){
						if((sprite_index = sprFloor6) || (sprite_index = sprFloor6B)){
							with(call(scr.floor_room, x, y, 0, self, 1, 1, "", 0, 0)){
								mod_script_call("mod", "Frontier_Labs", "BallTrap_create", x, y)
							}
						}
					}
				}
				
					// Fix Shadows:
				with(Server){
					spr_shadow		= shd32;
					spr_shadow_y	= 5;
				}
				with(Terminal){
					spr_shadow_y	= 1;
				}
				with(Tube){
					spr_shadow		= shd32;
					spr_shadow_y	= 7;
				}
				with(MutantTube){
					spr_shadow		= shd32;
					spr_shadow_y	= 7;
				}
            
        		break;
        		//#endregion
            
        		//#region PALACE:
        		case 7: 
        			
        			 // Throne Room Telepormers:
        			if(global.settingThroneTeleporters = true){
	        			if(GameCont.subarea = 3){
	        				mod_script_call("mod", "Frontier_Palace", "ThroneRoomTeleporter_create", 9912, 9992, -1);
	        			//	mod_script_call("mod", "Frontier_Palace", "ThroneRoomTeleporter_create", 10120, 9992, 1);
	        			}
        			}
        			
    			case "palace":
    			
    			if(GameCont.subarea != 3){
    			
        				// Crush Traps:
					with(instances_matching(Floor, "object_index", Floor)){
						if(chance(global.settingCrushTrapSpawnrate, 30)){
							if ((sprite_index = sprFloor7) || (sprite_index = sprFloor7B)){
								with(call(scr.floor_room, x, y, 0, self, 1, 1, "", 0, 0)){
									with(floors){
										if(distance_to_object(Player) > 64){
											mod_script_call("mod", "Frontier_Palace", "CrushBlock_create", x + 16, y + 16);
											sprite_index = global.sprFloorCrushBlock;
										}
									}
								}
							}
						}
					}
					
					with(instances_matching(CustomProjectile, "name", "fr_CrushBlock")){
						if(distance_to_point(10016, 10016) < 64){
							instance_destroy();
						}
					}
    			}
    			
    			if(GameCont.fr_deeplabsDecal = true){
	    			with(instance_nearest(10016, 10016, TopSmall)){
	    				mod_script_call("mod", "Frontier_Deeplabs", "DeeplabsPodDecal_create", x, y);
	    			}
    			}
    			GameCont.fr_deeplabsDecal = false;
    			
            		// Splitter Guardians:
            	with(DogGuardian){
            	    if(random(5) < 1){
            	    	mod_script_call("mod", "Frontier_Palace", "GupGuardian_create", x, y);
            	        instance_delete(self);
            	    }
            	}
            	with(Guardian){
            	    if(random(12) < 1){
            	    	mod_script_call("mod", "Frontier_Palace", "GeepGuardian_create", x, y);
            	    	instance_create(x, y, PortalClear);
            	        instance_delete(self);
            	    }
            	}
            
        		break;
        		//#endregion
            
        		//#region OASIS:
            	case 101:
            	case "oasis":
            	
            		if(GameCont.subarea = 1){
	            			// Vars:
	            		var	_statueFloor = [],
							_statueIndex = -1
	            
	            			// OASIS STATUE:
	             		with(FloorNormal){
							if(point_distance(bbox_center_x, bbox_center_y, 10016, 10016) > 80){
								if(!place_meeting(x, y, Wall) && !place_meeting(x, y, prop) && !place_meeting(x, y, chestprop)){
									array_push(_statueFloor, self);
									_statueIndex++;
								}
							}
						}
							// Statue Object:
	            		call(scr.array_shuffle,(_statueFloor));
	        			if(_statueIndex >= 0) with(_statueFloor[_statueIndex--]){ 
	        				with mod_script_call("mod", "Frontier_Objects", "OasisStatue_create", x + 16, y + 16, 5 - global.desertSubarea){
	        					instance_create(x, y, LightBeam)
	        					call(scr.floor_fill, x, y, 3, 3, "")
	        				}
	        			}
            		}
            		
            		 // Slaughter Skinner:
            		if(mod_exists("mod", "ntte")){
            			mod_script_call("mod", "Frontier_Objects", "SlaughterBSkinner_create", 10016, 10016);
            		}
            
            	break;
        		//#endregion
        
        		//#region MANSION:
            	case 103:
            	
        			if (GameCont.loops > 0){
            			// Vars:
            			var	_goldStationFloor = [],
							_goldStationIndex = -1
            
            			// Gold Station:
            			with(FloorNormal){
							if(point_distance(bbox_center_x, bbox_center_y, 10016, 10016) > 48){
								if(!place_meeting(x, y, Wall) && !place_meeting(x, y, prop) && !place_meeting(x, y, chestprop)){
									array_push(_goldStationFloor, self);
									_goldStationIndex++;
								}
							}
						}
							// Station Object:
            			call(scr.array_shuffle,(_goldStationFloor));
        				if(_statueIndex >= 0) with(_goldStationFloor[_goldStationIndex--]){ 
        					with mod_script_call("mod", "Frontier_Objects", "WeaponExchangerGold_create", x + 16, y){
        						call(scr.floor_fill, x, y, 3, 3, "")
        					}
        				}
        			}
            
        		break;
        		//#endregion
        
        		//#region CURSED CRYSTAL CAVES:
        		case 104:
        		case "cavesinv":
        			 // The Ourpler:
        			mod_script_call("mod", "Frontier_Caves", "HyperCrystalOurpler_create", 10016, 10016);
        	
        			 // Spike Traps:
					with(instances_matching(Floor, "object_index", Floor)){
						if(!styleb) && (random(30) < 1) && (distance_to_object(Player) > 32){
				    		mod_script_call("mod", "Frontier_Caves", "SpikeTrap_create", x, y, true)
						}
					}    
					
        				// Spider Traps:
					with(instances_matching(Floor, "object_index", Floor)){
						if(random(30) < 1) && (distance_to_object(Player) > 32){
				    		mod_script_call("mod", "Frontier_Caves", "SpiderTrap_create", x + 16, y + 16, true)	
						}
					}  
					
					 // Cove Entrance:					
					if(global.settingAltCoveEntrance = false){
	        			if (GameCont.subarea == 1){
	        		
	        				var	_coveEntranceFloor = [],
								_coveEntranceIndex = -1
	        	
	 						with(FloorNormal){
								if(point_distance(bbox_center_x, bbox_center_y, 10016, 10016) > 48){
									if(!place_meeting(x, y, Wall) && !place_meeting(x, y, prop) && !place_meeting(x, y, chestprop)){
										array_push(_coveEntranceFloor, self);
										_coveEntranceIndex++;
									}
								}
							}
							call(scr.array_shuffle,(_coveEntranceFloor));
	        				if(_coveEntranceIndex >= 0) with(_coveEntranceFloor[_coveEntranceIndex--]){
	        					var	_w          = 1,
									_h          = 1,
									_type       = "",
									_dirOff     = 0,
									_floorDis   = 0,
									_spawnX     = x,
									_spawnY     = y,
									_spawnDis   = 128,
									_spawnFloor = FloorNormal;
		
								with call(scr.floor_room,_spawnX, _spawnY, _spawnDis, _spawnFloor, _w, _h, _type, _dirOff, _floorDis) {
								var	_myx = x - 16,
		    						_myy = y - 16;
		    						
									// Make Entrance Object:
									mod_script_call("mod", "Frontier_Caves", "CoveEntrance_create", x, y, true);
								}		
	        				}
	        			}
					}
        	
        		break;
        		//#endregion

				//#region IDPD HQ:	
            	case 106:
            	case "hq":
            
            			// Vars:
            		var	_exitFloor = [],
						_exitIndex = -1,
						_stationFloor = [],
						_stationIndex = -1;
					
					// HQ EXIT:
				if (GameCont.subarea == 2){
				
					with(FloorNormal){
						if(point_distance(bbox_center_x, bbox_center_y, 10016, 10016) > 48){
							if(!place_meeting(x, y, Wall) && !place_meeting(x, y, prop) && !place_meeting(x, y, chestprop)){
								array_push(_exitFloor, self);
								_exitIndex++;
							}
						}
					}
						// Exit:
					call(scr.array_shuffle,(_exitFloor));
        			if(_exitIndex >= 0) with(_exitFloor[_exitIndex--]){ mod_script_call("mod", "Frontier_IDPD", "HQExit_create", x + 16, y + 16); }
				
				}
		
					// AUGMENT STATIONS:
				if (GameCont.subarea == 1) or (GameCont.subarea == 2){
				
					with(FloorNormal){
						if(point_distance(bbox_center_x, bbox_center_y, 10016, 10016) > 48){
							if(!place_meeting(x, y, Wall) && !place_meeting(x, y, prop) && !place_meeting(x, y, chestprop)){
								array_push(_stationFloor, self);
								_stationIndex++;
							}
						}
					}
					call(scr.array_shuffle,(_stationFloor));
        			if(_stationIndex >= 0) with(_stationFloor[_stationIndex--]){
	    					var	_w          = 5,
								_h          = 5,
								_type       = "",
								_dirOff     = 0,
								_floorDis   = 0,
								_spawnX     = x,
								_spawnY     = y,
								_spawnDis   = 256,
								_spawnFloor = FloorNormal;
						with call(scr.floor_room, _spawnX, _spawnY, _spawnDis, _spawnFloor, _w, _h, _type, _dirOff, _floorDis) {
								// Make Room Objects:
							mod_script_call("mod", "Frontier_IDPD", "AugmentStation_spawn", x + 32, y + 32);
							mod_script_call("mod", "Frontier_IDPD", "AugmentStation_spawn", x - 32, y + 32);
							mod_script_call("mod", "Frontier_IDPD", "AugmentStation_spawn", x + 32, y - 32);
							mod_script_call("mod", "Frontier_IDPD", "AugmentStation_spawn", x - 32, y - 32);
							instance_create(x + 64, y + 64, PlantPot);
							instance_create(x - 64, y + 64, PlantPot);
							instance_create(x + 64, y - 64, PlantPot);
							instance_create(x - 64, y - 64, PlantPot);
							mod_script_call("mod", "Frontier_IDPD", "AugmentMonolith_create", x, y - 8);
							mod_script_call("mod", "Frontier_Objects", "PortalPusher_create", x, y, 128);
								// Floor:
							mod_script_call("mod", "Frontier_IDPD", "AugmentStationFloor_create", x, y);
			
						}
        			}
				}
			
				break;
				//#endregion	
            }
            	       
        	global.levelStart = false;
        }
	}       
 
		//#region CROWN VAULT
    // Crown Vault weirdgen:
    if(instance_exists(GenCont)){
    	if(GenCont.alarm0 > 0 && GenCont.alarm0 <= room_speed){
	    
	    	 // Put Cache Area in Vault:
	    	with(instances_matching(CrownPed, "fr_protocache", null)){
	    		fr_protocache = "hihelloimhere";
	    		
		    	var	_w          = 5,
					_h          = 5,
					_type       = "round",
					_dirOff     = 0,
					_floorDis   = 0,
					_spawnX     = x,
					_spawnY     = y,
					_spawnDis   = 128,
					_spawnFloor = FloorNormal;
			
		    	with call(scr.floor_room, _spawnX, _spawnY, _spawnDis, _spawnFloor, _w, _h, _type, _dirOff, _floorDis) {
					var	_myx = x - 16,
		    			_myy = y - 16,
		    			_img = 0;
	
					with(floors){
						sprite_index = global.sprFloorProtoCache;
						image_index  = _img++;
						depth        = 7;
					}	
		    			
					// Make Cache:
					mod_script_call("mod", "Frontier_Palace", "ProtoCache_create", x, y);
		    	}
	    	}
	    	
	    	if(!skill_get("BurdenBlood") && GameCont.loops > 0){
	    		with(instances_matching(CrownPed, "fr_bloodfountain", null)){
		    		fr_bloodfountain = "ermGross";
		    		
			    	var	_w          = 3,
						_h          = 3,
						_type       = "",
						_dirOff     = 0,
						_floorDis   = 0,
						_spawnX     = x,
						_spawnY     = y,
						_spawnDis   = 64,
						_spawnFloor = FloorNormal;
				
			    	with call(scr.floor_room, _spawnX, _spawnY, _spawnDis, _spawnFloor, _w, _h, _type, _dirOff, _floorDis) {
						var	_myx = x - 16,
			    			_myy = y - 16,
			    			_img = 0;
		
						with(floors){
							sprite_index = global.sprFloorBloodFountain;
							image_index  = _img++;
							depth        = 7;
						}	
			    			
						// Make Fountain:
						mod_script_call("mod", "Frontier_Palace", "BloodFountain_create", x, y - 22);
			    	}
		    	}
	    	}
	    	
	    	if(global.settingSurgeriesBeta = true){
	    		with(instances_matching(CrownPed, "fr_surgerybeta", null)){
		    		fr_surgerybeta = "yupp";
		    		
			    	var	_w          = 3,
						_h          = 3,
						_type       = "",
						_dirOff     = 0,
						_floorDis   = 0,
						_spawnX     = x,
						_spawnY     = y,
						_spawnDis   = 128,
						_spawnFloor = FloorNormal;
				
			    	with call(scr.floor_room, _spawnX, _spawnY, _spawnDis, _spawnFloor, _w, _h, _type, _dirOff, _floorDis) {
						var	_myx = x - 16,
			    			_myy = y - 16,
			    			_img = 0;
		
						with(floors){
							sprite_index = global.sprFloorBloodFountain;
							image_index  = _img++;
							depth        = 7;
						}	
			    			
						// Make Surgery Stations:
						mod_script_call("mod", "Frontier_Objects", "BetaSurgeryStation_spawn", x + 28, y - 32, "SurgerySlot");
						mod_script_call("mod", "Frontier_Objects", "BetaSurgeryStation_spawn", x - 28, y - 32, "SurgerySlot2");
						mod_script_call("mod", "Frontier_Objects", "BetaSurgeryStation_spawn", x + 28, y + 24, "SurgerySlot3");
						mod_script_call("mod", "Frontier_Objects", "BetaSurgeryStation_spawn", x - 28, y + 24, "SurgerySlot4");
			    	}
		    	}
	    	}
    	}
    }

//#endregion
//#endregion
#define CharSelect_draw_new(_inst)
	with(instances_matching(_inst, "visible", true)){
		draw_sprite(sprNew, image_index, view_xview_nonsync + xstart + (alarm1 > 0), view_yview_nonsync + ystart - mouseover);
	}
	instance_destroy();
	
#define CharSelect_draw_robot(_inst)
	with(instances_matching(_inst, "visible", true)){
		draw_sprite(global.sprNewRobot, image_index, view_xview_nonsync + xstart + (alarm1 > 0), view_yview_nonsync + ystart - mouseover);
	}
	instance_destroy();

#define frontier_race_deathstat(_race)
	 // i moved how this works to wibbly
	var _stat = _race + string("_deaths");
	call(scr.save_set, "Frontier", _stat, ((call(scr.save_get, "Frontier", _stat)) + 1))
	mod_script_call("race", _race, "race_frontier_savestats")
	
#define frontier_race_winstat(_race)
	 // also in wibbly
	var _stat = _race + string("_wins");
	call(scr.save_set, "Frontier", _stat, ((call(scr.save_get, "Frontier", _stat)) + 1))
	mod_script_call("race", _race, "race_frontier_savestats");

#define altareas_import_frontier
	 // Check if in alternateareahandler array:
	if(mod_exists("area", "AlternateAreaHandler")){
		var _knownMods	= mod_variable_get("area", "AlternateAreaHandler", "knownMods"),
	        _knownIndex = 0,
	        _seeMe		= 0;
	    repeat(array_length(_knownMods)){
	        if(_knownMods[_knownIndex] = mod_current){
	            _seeMe += 1;
	        }
	        _knownIndex += 1;
	    }
	     // If not found, add self then run aree add functions
	    if(_seeMe <= 0){
	    	array_push(_knownMods, mod_current);
	    	mod_variable_set("area", "AlternateAreaHandler", "knownMods", _knownMods)
	    	
	    	 // Add altareas here:
	    	mod_script_call("area", "AlternateAreaHandler", "area_add", 5, ["graveyard",		"altLabsMode_check", true, false, mod_current]);
	       	mod_script_call("area", "AlternateAreaHandler", "area_add", 6, ["robocenter",		"altLabsMode_check", true, false, mod_current]);
	       	
	       	 // jungle to graveyard override
	    	mod_script_call("area", "AlternateAreaHandler", "area_add", 5, ["graveyard",		"jungleGraveyard_check", false, true, mod_current]);
	    }
	}
    
#define altLabsMode_check
	var _weight = (global.settingLabsRouteAltMode = true) ? 1 : 0;
	return _weight;
	
#define jungleGraveyard_check
	return GameCont.fr_jungleToGraveyard;

#define detailsPlus_import_frontier
	
	 // Details+ Import:
	if(mod_exists("mod", "Details+")){
		
			// import native details:
		var _knownMods	= mod_variable_get("mod", "Details+", "knownMods"),
	        _knownIndex = 0,
	        _seeMe		= 0;
	    repeat(array_length(_knownMods)){
	        if(_knownMods[_knownIndex] = mod_current){
	            _seeMe += 1;
	        }
	        _knownIndex += 1;
	    }
	    if(_seeMe <= 0){
	    	array_push(_knownMods, mod_current);
	    	mod_variable_set("mod", "Details+", "knownMods", _knownMods)

	    	 // Unique Statues:
	    	mod_script_call("mod", "Details+", "detailsPlus_add_statue", "graveyard", [global.sprGraveyardProtoStatueDecal, global.sprGraveyardProtoStatueDecalDead]);
	    	
	    	 // Unique Scorches:
			mod_script_call("mod", "Details+", "detailsPlus_add_scorch", mod_variable_get("area", "graveyard", "sprFloor"),  
			[global.sprGraveyardScorchTop[0],		global.sprGraveyardScorchTop[1]], 
			[global.sprGraveyardScorch[0], 			global.sprGraveyardScorch[1]]);
			
			mod_script_call("mod", "Details+", "detailsPlus_add_scorch", mod_variable_get("mod", "Frontier_Events", "sprFloor1BNight"),  
			[global.sprDesertBNightScorchTop[0],	global.sprDesertBNightScorchTop[0]], 
			[global.sprDesertBNightScorch[0], 		global.sprDesertBNightScorch[0]]);
			
			mod_script_call("mod", "Details+", "detailsPlus_add_scorch", mod_variable_get("mod", "Frontier_Events", "sprDetailsPlusFloorDesertBOutNight"),  
			[global.sprDesertBNightScorchTop[0],	global.sprDesertBNightScorchTop[0]], 
			[global.sprDesertBNightScorch[0], 		global.sprDesertBNightScorch[0]]);

			mod_script_call("mod", "Details+", "detailsPlus_add_scorch", mod_variable_get("mod", "Frontier_Events", "sprFloor5Night"),  
			[global.sprCityNightScorchTop[0],		global.sprCityNightScorchTop[1]], 
			[global.sprCityNightScorch[0], 			global.sprCityNightScorch[1]]);

			mod_script_call("mod", "Details+", "detailsPlus_add_scorch", mod_variable_get("mod", "Frontier_Events", "sprFloor5ExploNight"),  
			[global.sprCityNightScorchTop[0],		global.sprCityNightScorchTop[1]], 
			[global.sprCityExploNightScorch[0], 	global.sprCityExploNightScorch[1]]);

			mod_script_call("mod", "Details+", "detailsPlus_add_scorch", mod_variable_get("mod", "Frontier_Events", "sprFloor5BNight"),  
			[global.sprCityBNightScorchTop[0],		global.sprCityBNightScorchTop[1]], 
			[global.sprCityBNightScorch[0], 		global.sprCityBNightScorch[1]]);
		}
		
			// mod compat details:
		if(mod_exists("mod", "ntte")){
			var _knownMods	= mod_variable_get("mod", "Details+", "knownMods"),
		        _knownIndex = 0,
		        _seeMe		= 0;
		    repeat(array_length(_knownMods)){
		        if(_knownMods[_knownIndex] = "frontier_ntte_compat"){
		            _seeMe += 1;
		        }
		        _knownIndex += 1;
		    }
		    if(_seeMe <= 0){
		    	array_push(_knownMods, "frontier_ntte_compat");
		    	mod_variable_set("mod", "Details+", "knownMods", _knownMods)
				
				mod_script_call("mod", "Details+", "detailsPlus_add_scorch", mod_variable_get("mod", "Frontier_Events", "sprFloorCoastNight"),  
				[global.sprCoastNightScorchTop[0],	global.sprCoastNightScorchTop[0]], 
				[global.sprCoastNightScorch[0], 	global.sprCoastNightScorch[0]]);
			}			
		}
	}
	
#define chance(_numer, _denom)                                                      			return  random(_denom) < _numer;
	
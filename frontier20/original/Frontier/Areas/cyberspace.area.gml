#define init

		// LIB:
	while(!mod_exists("mod", "lib")){wait(1);}
	script_ref_call(["mod", "lib", "getRef"], "area", mod_current, "scr");
	#macro  scr			global.scr
	#macro  call		script_ref_call

		// SETTINGS //
	global.settingCyberspaceEnabled				= true;
	
		// SOUNDS //
	global.ambCyberspace						= sound_add("../sounds/ambience/ambCyberspace.ogg");
	global.sndSmileHurt							= sound_add("../sounds/enemies/cyberspace/sndSmileHurt.ogg");
	global.sndCyberspaceEnemyDead				= sound_add("../sounds/enemies/cyberspace/sndCyberspaceEnemyDead.ogg");
	global.sndCyberspaceEnemySpawn				= sound_add("../sounds/enemies/cyberspace/sndCyberspaceEnemySpawn.ogg");
	global.sndProcessorStart					= sound_add("../sounds/enemies/cyberspace/sndProcessorStart.ogg");
	global.sndProcessorComplete					= sound_add("../sounds/enemies/cyberspace/sndProcessorComplete.ogg");
	global.sndBlank								= sound_add("../sounds/sndBlank.ogg");
	
		// Area Sprites //
	global.sprFloor 							= sprite_add("../sprites/areas/Cyberspace/sprFloorCyberspace.png",			1, 0, 0);
	global.sprFloorB							= sprite_add("../sprites/areas/Cyberspace/sprFloorCyberspaceB.png", 		1, 0, 0);
	global.sprFloorExplo						= sprite_add("../sprites/areas/Cyberspace/sprFloorCyberspaceExplo.png", 	1, 1, 1);	
	global.sprWallBot							= sprite_add("../sprites/areas/Cyberspace/sprWallCyberspaceBot.png",		3, 0, 0);
	global.sprWallTop							= sprite_add("../sprites/areas/Cyberspace/sprWallCyberspaceTop.png",		1, 0, 0);
	global.sprWallOut							= sprite_add("../sprites/areas/Cyberspace/sprWallCyberspaceOut.png",		1, 4, 12);
	global.sprWallTrans 						= sprite_add("../sprites/areas/Cyberspace/sprWallCyberspaceTrans.png",		1, 0, 0);
	global.sprDebris							= sprite_add("../sprites/areas/Cyberspace/sprDebrisCyberspace.png", 		4, 4, 4);
	global.sprDetail							= sprite_add("../sprites/areas/Cyberspace/sprDetailCyberspace.png", 		6, 4, 4);
	//global.sprTopDecal						= sprite_add("sprites/areas/Cyberspace/sprCyberspaceTopDecal.png",			3,16,24);
	
	global.sprSpiralCyberspace					= sprite_add("../sprites/areas/Cyberspace/sprSpiralCyberspace.png", 		2, 32, 32);
	global.sprSpiralDebrisCyberspace			= sprite_add("../sprites/areas/Cyberspace/sprSpiralDebrisCyberspace.png",	2, 4, 4);
	
	global.sprWallBlob							= sprite_add("../sprites/areas/cyberspace/sprCyberspaceWallBlob.png",		6, 32, 32);
	global.sprWallBlob2							= sprite_add("../sprites/areas/cyberspace/sprCyberspaceWallBlob2.png",		6, 32, 32);
	global.sprBlueZone							= sprite_add("../sprites/areas/cyberspace/sprBlueZone.png", 				1, 0, 0);
	global.areaBackgroundPos					= 0;
	
	global.sprSmile								= sprite_add("../sprites/areas/cyberspace/sprSmile.png",					2, 10, 10);
	global.smileIndex							= 0;
	global.sprSmileDead							= sprite_add("../sprites/areas/cyberspace/sprSmileDead.png",				11, 10, 10);
	
	global.sprCyberspaceEnemyTrail				= sprite_add("../sprites/particles/sprCyberspaceEnemyTrail.png",			3, 4, 4);
	global.sprCyberspaceEnemyDie				= sprite_add("../sprites/particles/sprCyberspaceEnemyDie.png",				5, 10, 10);

	global.sprProcessorIdle						= sprite_add("../sprites/areas/Cyberspace/props/sprProcessorIdle.png", 		6, 24, 32);
	global.sprProcessorGood						= sprite_add("../sprites/areas/Cyberspace/props/sprProcessorGood.png", 		6, 24, 32);
	global.sprProcessorSpark					= sprite_add("../sprites/particles/sprProcessorSpark.png",					3, 4, 4);

	global.sprCyberspaceRobotIdle				= sprite_add("../sprites/skins/robotcyberspace/sprCyberspaceRobotIdle.png", 26, 12, 12);
	global.sprCyberspaceRobotWalk				= sprite_add("../sprites/skins/robotcyberspace/sprCyberspaceRobotWalk.png", 6, 12, 12);
	global.sprCyberspaceRobotHurt				= sprite_add("../sprites/skins/robotcyberspace/sprCyberspaceRobotHurt.png", 3, 12, 12);
	global.sprCyberspaceRobotDead				= sprite_add("../sprites/skins/robotcyberspace/sprCyberspaceRobotDead.png", 8, 12, 12);
	
	global.sprBluescreenBackground				= sprite_add("../sprites/menu/bluescreen/sprBluescreenBackground.png", 		1, 160, 120);
	global.sprBluescreenBackgroundDeny			= sprite_add("../sprites/menu/bluescreen/sprBluescreenBackgroundDeny.png", 	1, 160, 120);
	global.sprBluescreenBackgroundExt			= sprite_add("../sprites/menu/bluescreen/sprBluescreenBackgroundExt.png",	1, 8, 8);
	global.sprBluescreenBackgroundBar			= sprite_add("../sprites/menu/bluescreen/sprBluescreenBackgroundBar.png",	1, 1, 1);
	global.sprBluescreenBackgroundSearch		= sprite_add("../sprites/menu/bluescreen/sprBluescreenBackgroundSearch.png",4, 24, 2);
	global.sprBluescreenBackgroundReboot		= sprite_add("../sprites/menu/bluescreen/sprBluescreenBackgroundReboot.png",1, 72, 5);
	global.mskBluescreenButton					= sprite_add("../sprites/menu/bluescreen/mskBluescreenButton.png",			1, 32, 32);
	global.sprBluescreenButtonYes				= sprite_add("../sprites/menu/bluescreen/sprBluescreenButtonYes.png",		2, 32, 32);
	global.sprBluescreenButtonNo				= sprite_add("../sprites/menu/bluescreen/sprBluescreenButtonNo.png",		2, 32, 32);
	
	global.prevIdle								= [];
	global.prevWalk								= [];
	global.prevHurt								= [];
	global.prevDead								= [];
	global.reskinMe								= false;
	
	
	Processor_buildpools();
	
	
	 // CHANGE ROBOT'S PASSIVE TEXT:
	 // text only changes on mod load so if you disable cyberspace it wont get reverted until reloading the mod. this is fine, I doubt very many people will disable it anyways
	loc_set("races:8:passive", loc("Frontier:RobotPassive", "FINDS BETTER TECH#@bSYSTEM REBOOT@w"))
    
#define area_subarea        	return 1;
#define area_goal           	return 220;
#define area_next           	return [GameCont.lastarea, 1];
#define area_background_color	return make_color_rgb(65, 83, 124);
#define area_shadow_color   	return c_black;
#define area_shadow_alpha		return 0;
#define area_darkness       	return false;
#define area_secret         	return true;
#define area_outside			return true;
    
#define area_name
	return "!!!";

#define area_text
	return choose(
		"CONGRATULATIONS! YOU'VE WON!",
		"CONNECTION TERMINATED",
		"BLUER THAN THE SEA"
	);
	

    
#define area_sprite(_sprite)
	switch (_sprite) {
    	case sprFloor1: 			with([self, other]) if(instance_is(self, Floor)){ area_setup_floor(); break; } return global.sprFloor;
    	case sprFloor1B:			with([self, other]) if(instance_is(self, Floor)){ area_setup_floor(); break; } return global.sprFloorB;
    	case sprFloor1Explo:		return global.sprFloorExplo;
    	case sprWall1Trans: 		return global.sprWallTrans;
    	case sprWall1Bot:			return global.sprWallBot;
    	case sprWall1Out:			return global.sprWallOut;
    	case sprWall1Top:			return global.sprWallTop;
    	case sprDebris1:			return global.sprDebris;
		case sprDetail1:			return global.sprDetail;
	}

#define area_setup

	with(SpiralCont){
		type = 1;
		script_bind_step(area_spiral_step, 0, self)
		repeat(16){
			with(CyberspaceSpiralDebris_create(x, y)){
				image_xscale	= random_range(0.6, 1);
				image_yscale	= image_xscale;
			}
		}
	}
	
	with(Player){
		if(race = "robot"){
			global.prevIdle[index] = spr_idle;
			global.prevWalk[index] = spr_walk;
			global.prevHurt[index] = spr_hurt;
			global.prevDead[index] = spr_dead;
		
			spr_idle	= global.sprCyberspaceRobotIdle;
			spr_walk	= global.sprCyberspaceRobotWalk;
			spr_hurt	= global.sprCyberspaceRobotHurt;
			spr_dead	= global.sprCyberspaceRobotDead;
		}
		
		canwalk 		= true;
		canspec 		= true;
	}
	global.reskinMe	= true;

	sound_play_music(global.sndBlank);
	sound_play_ambient(global.ambCyberspace);
    
	goal             = area_goal();
	background_color = area_background_color();
	BackCont.shadcol = area_shadow_color();
	BackCont.shadalpha = area_shadow_alpha();
	TopCont.darkness = area_darkness();
	GameCont.norads	 = 1; // I HATE YOU HORROR
    safespawn		 = 1;
    
     // Area Step:
    script_bind_step(area_step, 0);
    script_bind_draw(area_background_draw, 30);
    script_bind_draw(cyberspace_enemy_draw, -3);
    
     // Wall Breaking Sounds:
    sound_assign(sndWallBreakRock, sndWallBreakLabs);

#define area_spiral_step(_spiral)
	if(!instance_exists(_spiral)){
		instance_destroy();
		exit;
	}
	
	with(instances_matching_ne(Spiral, "fr_spiralCont", true)){
		fr_spiralCont	= true;
		sprite_index	= global.sprSpiralCyberspace;
		colors			= [make_color_rgb(0, 33, 255), make_color_rgb(0, 33, 255)];
		
		if(random(5) < 1){
			CyberspaceSpiralDebris_create(x, y);
		}
	}
	
#define CyberspaceSpiralDebris_create(_x, _y)
	with(instance_create(x, y, SpiralStar)){
		sprite_index	= global.sprSpiralDebrisCyberspace;
		image_index		= irandom(1);
		image_angle		= 0;
		rotspeed		= 0;
		grow			/= 2;
		
		return self;
	}

#define area_setup_floor
	material = 3;
   
    
#define area_start
	 // STOP THAT PORTAL!!!!!!!
	instance_create(10016, 10016, becomenemy)
	instance_create(10016, 10016, BigWeaponChest);
	with(RadChest){
		instance_delete(self);
	}
	
	 // Stat:
	call(scr.save_set, "Frontier", "cyberspace_visits", ((call(scr.save_get, "Frontier", "cyberspace_visits")) + 1))
	
	with(Detail){
		instance_destroy();
	}
	
	repeat(3){
		with(call(scr.instance_random, instances_matching(FloorNormal, "fr_processor", null))){
			Processor_create(x + 16, y + 16);
			fr_processor = true;
			
			instance_create(x, y, PortalClear);
		}
	}
	
	with(Floor){
		if(distance_to_point(10016, 10016) > 96){
			fr_cyberfar = true;
		}
	}
	
	repeat(14 + (5 * GameCont.loops)){
		with(call(scr.instance_random, instances_matching(Floor, "fr_cyberfar", true))){
			Smile_create(x + 16, y + 16);
			fr_cyberfar	= false;
			
			instance_create(x, y, PortalClear);
		}
	}
	
	 // GET OUT
	if(instance_exists(WantPopo) || instance_exists(WantVan)){
		with(WantPopo){
			instance_delete(self);
		}
		with(WantVan){
			instance_delete(self);
		}
	}
	if(instance_exists(VanSpawn) || instance_exists(IDPDSpawn) || array_length(instances_matching(CustomObject, "name", "IDPDPortal")) > 0){
		with(IDPDSpawn){
			instance_delete(self);
		}
		with(VanSpawn){
			instance_delete(self);
		}
		with(instances_matching(CustomObject, "name", "IDPDPortal")){
			instance_delete(self);
		}
		sound_stop(sndIDPDPortalSpawn);
		sound_stop(sndEliteIDPDPortalSpawn);
		sound_stop(sndVanWarning);
	}
	
#define area_make_floor

	var _x = x,
		_y = y,
		_outOfSpawn = (point_distance(_x, _y, 10000, 10000) > 48);
		
	 // Place Floor:
    instance_create(_x, _y, Floor);
    
    // 3x3 Rooms:
	if(random(10) < 1) {
	scrFloorFill(_x, _y, 3, 3);
	}
	
     // Change Direction:
    var _turn = 0;
    if(random(2) < 1){
    	_turn = choose(90, 270, 270, 180);
    }
    direction += _turn;
    
     // Weapon Chests:
    if(_outOfSpawn && _turn == 180){
    	instance_create(_x + 16, _y + 16, WeaponChest);
    }
    
     // Ammo Chests and Dead Ends:
    if(random(19 + instance_number(FloorMaker)) > 20){
    	if(_outOfSpawn){
    		instance_create(_x + 16, _y + 16, AmmoChest);
    	}
    	instance_destroy();
    }
    
     // Branch Generation:
    if(random(7) < 1){
    	instance_create(_x, _y, FloorMaker);
    }

#define scrFloorFill(_x, _y, _w, _h)
    var o = 32;

     // Center Around x,y:
    _x -= floor((_w - 1) / 2) * o;
    _y -= floor((_h - 1) / 2) * o;

     // Floors:
    for(var _ox = 0; _ox < _w; _ox++){
        for(var _oy = 0; _oy < _h; _oy++){
            instance_create(_x + (_ox * o), _y + (_oy * o), Floor);
        }
    }
	
#define area_pop_props


#define area_finish

	 // Next Subarea:
	if(subarea < area_subarea()){
		subarea++;
	}
	
	 // Next Area:
	else{
		var _next = area_next();
		area    = _next[0];
		subarea = _next[1];
	}
    
#define area_transit
	if(global.reskinMe = true){
		with(Player){
			if(race = "robot"){
				spr_idle	= global.prevIdle[index];
				spr_walk	= global.prevWalk[index];
				spr_hurt	= global.prevHurt[index];
				spr_dead	= global.prevDead[index];
			}
		}
	}
	
    // Restore Wall Sounds:
    sound_restore(sndWallBreakRock);
    
#define area_step
	global.areaBackgroundPos += current_time_scale;
	global.smileIndex			= (current_frame * 0.2);

	with(instances_matching(TopSmall, "fr_cyberspace_blobIndex", null)){
		fr_cyberspace_blobIndex 	= irandom(14);
		fr_cyberspace_blobRotation	= choose(0, 90, 180, 270);
		fr_cyberspace_blobScale		= 1 + random(0.2);
		fr_cyberspace_blobRight 	= choose(-1, 1);
	}
	
	with(instances_matching_ne(enemy, "fr_processor", null)){
		if(random(2) < 1){
			with(instance_create(x + random_range(-(sprite_width / 3), (sprite_width / 3)), y + random_range(-(sprite_height / 3), (sprite_height / 3)), CaveSparkle)){
				sprite_index	= global.sprCyberspaceEnemyTrail;
				image_angle		= random(360);
				direction		= random(360);
				speed			= 0 + random(2);
			}	
		}
	}
	
	 // NO POPO
	if(instance_exists(WantPopo) || instance_exists(WantVan)){
		with(WantPopo){
			instance_delete(self);
		}
		with(WantVan){
			instance_delete(self);
		}
	}
	if(instance_exists(VanSpawn) || instance_exists(IDPDSpawn) || array_length(instances_matching(CustomObject, "name", "IDPDPortal")) > 0){
		with(IDPDSpawn){
			instance_delete(self);
		}
		with(VanSpawn){
			instance_delete(self);
		}
		with(instances_matching(CustomObject, "name", "IDPDPortal")){
			instance_delete(self);
		}
		sound_stop(sndIDPDPortalSpawn);
		sound_stop(sndEliteIDPDPortalSpawn);
		sound_stop(sndVanWarning);
	}

#define area_background_draw
	var _backgroundPos = global.areaBackgroundPos;
	
	draw_sprite_tiled(global.sprBlueZone, 0, x, y + _backgroundPos * 6)
	
    with(instances_matching_ne(TopSmall, "fr_cyberspace_blobIndex", null)){
		draw_sprite_ext(global.sprWallBlob, (current_frame * 0.4) + fr_cyberspace_blobIndex, x + 8, y + 8, fr_cyberspace_blobScale * fr_cyberspace_blobRight, fr_cyberspace_blobScale * fr_cyberspace_blobRight, fr_cyberspace_blobRotation, c_white, 1)
	}
	
#define cyberspace_enemy_draw
	with(instances_matching_ne(enemy, "fr_processor", null)){
		d3d_set_fog(true, c_red, 0, 0);
	//	if(array_length(instances_matching(enemy, "fr_processor", fr_processor)) <= 3){
		draw_set_alpha(0.05);
		draw_line_width(x, y, fr_processor.x, fr_processor.y - 16, 2);
		draw_set_alpha(1);
	//	}
		if(nexthurt >= current_frame + 3){ 
			d3d_set_fog(true, c_white, 0, 0);
		}
		draw_sprite_ext(sprite_index, image_index, x, y, image_xscale * right, image_yscale, image_angle, c_red, 1);
		draw_sprite_ext(sprite_index, image_index, x + random_range(-2, 2), y + random_range(-2, 2), image_xscale * right, image_yscale, image_angle, c_red, 1);
		d3d_set_fog(false, 0, 0, 0);
	}
	

		with(Player){
			if(instance_exists(Portal)){
				var _portal = instance_nearest(x, y, Portal);
				draw_set_alpha(0.2);
				draw_line_width_color(x, y, _portal.x, _portal.y, 2, make_color_rgb(0, 33, 255), make_color_rgb(0, 33, 255));
				draw_set_alpha(1);
			} else {
				if(race != "robot"){
					d3d_set_fog(true, make_color_rgb(0, 33, 255), 0, 0);
					draw_sprite_ext(sprite_index, image_index, x, y, image_xscale * right, image_yscale, angle, make_color_rgb(0, 33, 255), 1);
					d3d_set_fog(false, c_white, 0, 0);
				}
			}
		}	

#define Processor_create(_x, _y)
	with(instance_create(_x, _y, CustomObject)){
		
		name = "fr_robotprocessor";
		
		 // Visual:
		spr_idle		= global.sprProcessorIdle;
		spr_good		= global.sprProcessorGood;
		sprite_index	= spr_idle;
		image_speed		= 0.4;
		text			= "REBOOT?"
		depth			= -1;
		
		active			= false;
		enemyTime		= 50;
		enemiesSpawned	= 0;
		spawning		= true;
		availFloors		= noone;
		spawnPool		= [[[Bandit, "BASEGAME", ""], 1]];
		spawnCount		= 1;
		complete		= false;

		 // Fix Wiggle:
		x = round(x);
		y = round(y);
		
		on_step 		= Processor_step;
		
		with(call(scr.prompt_create, text)){ 
			on_step 	= ProcessorPrompt_step; 
			creator 	= other;
			mask_index	= mskBigMaggot;
		}
		
		Processor_choosePool();
		
		return self;
	}
	
#define Processor_step
	if(active = true){
		if(spawning = true){
			if(enemyTime <= 0){
				if(enemiesSpawned < spawnCount){
					enemiesSpawned	+= 1;
					enemyTime		+= (50 / spawnCount);
					
					with(call(scr.instance_random, availFloors)){
						ProcessorEnemy_create(x + 16, y + 16, other, call(scr.pool, other.spawnPool));
					}
				} else {
					spawning = false;
				}
			} else {
				enemyTime -= current_time_scale;
			}
			
		} else {
			 // u did it
			if(array_length(instances_matching(enemy, "fr_processor", self)) <= 0){
				active			= false;
				sprite_index	= spr_good;
				image_speed		= 0.4;
				complete		= true;
				
				repeat(12){
					with(instance_create(x, y, CaveSparkle)){
						sprite_index	= global.sprProcessorSpark;
						direction		= random(360);
						image_angle		= random(360);
						speed			= 4 + random(3);
						friction		= 0.3;
					}
				}
				repeat(3){
					with(instance_create(x, y, AmmoPickup)){
						direction	= random(360);
						speed		= 4;
					}
				}
				repeat(2){
					with(instance_create(x, y, HPPickup)){
						direction	= random(360);
						speed		= 4;
					}
				}
				
				sound_play_pitch(global.sndProcessorComplete, 0.9 + random(0.2));
				
				 // completed all proceesors:
				if(array_length(instances_matching(instances_matching(CustomObject, "name", "fr_robotprocessor"), "complete", false)) <= 0){
					with(instance_create(10016, 10016, Portal)){
						type = 3;
					}
					with(instances_matching(enemy, "name", "Smile")){
						with(instance_create(x, y, CaveSparkle)){
							sprite_index	= global.sprSmileDead;
						}
						instance_delete(self);
					}
				}
			}			
		}
	}
	
#define ProcessorPrompt_step
	
	 // Use:
	if(pick != -1){
	    with(creator){
	    	image_speed	= 0.8;
	    	active		= true;
	    	var _range	= 128;
	    	availFloors	= call(scr.instances_in_rectangle, x - _range, y - _range, x + _range, y + _range, FloorNormal);
	    }
	    sound_play(global.sndProcessorStart)
    	instance_destroy();
	}

#define Processor_buildpools


	global.spawnPools		= []
	global.spawnPoolNames	= ds_list_create();
	global.knownPoolAddons	= [];		// array external mods can push into to check if their additions have been made
	global.allowPoolPushing	= true; 	// if for whatever reason you need to tell frontier/other mods to not push compat pools into it.

	Processor_create_spawnpool("DESERT", 0, 9, 1);
	Processor_spawnpool_add("DESERT",		[Bandit,		"BASEGAME", ""],	1);
	Processor_spawnpool_add("DESERT",		[Scorpion,		"BASEGAME", ""],	0.7);
	Processor_spawnpool_add("DESERT",		[MeleeBandit,	"BASEGAME", ""],	0.4);
	
	Processor_create_spawnpool("SEWERS", 0, 12, 1);
	Processor_spawnpool_add("SEWERS",		[Rat,			"BASEGAME", ""],	2.2);
	Processor_spawnpool_add("SEWERS",		[Gator,			"BASEGAME", ""],	1);
	Processor_spawnpool_add("SEWERS",		[BuffGator,		"BASEGAME", ""],	0.2);
	Processor_spawnpool_add("SEWERS",		[Exploder,		"BASEGAME", ""],	1);
	
	Processor_create_spawnpool("SCRAPYARD", 3, 9, 1);
	Processor_spawnpool_add("SCRAPYARD",	[Sniper,		"BASEGAME", ""],	1);	
	Processor_spawnpool_add("SCRAPYARD",	[MeleeBandit,	"BASEGAME", ""],	0.6);
	Processor_spawnpool_add("SCRAPYARD",	[Salamander,	"BASEGAME", ""],	1);	
	Processor_spawnpool_add("SCRAPYARD",	[Exploder,		"BASEGAME", ""],	0.1);	

	Processor_create_spawnpool("CRYSTAL CAVES", 6, 12, 1);
	Processor_spawnpool_add("CRYSTAL CAVES",	[Spider,		"BASEGAME", ""],	1);	
	Processor_spawnpool_add("CRYSTAL CAVES",	[LaserCrystal,	"BASEGAME", ""],	0.6);	
	Processor_spawnpool_add("CRYSTAL CAVES",	[Gator,			"BASEGAME", ""],	0.1);	
	

	Processor_create_spawnpool("FROZEN CITY", 7, 9, 1);
	Processor_spawnpool_add("FROZEN CITY",	[SnowBot,		"BASEGAME", ""],	1);		
	Processor_spawnpool_add("FROZEN CITY",	[Wolf,			"BASEGAME", ""],	0.6);	
	
	Processor_create_spawnpool("LABS", 10, 18, 1);
	Processor_spawnpool_add("LABS",			[Freak,			"BASEGAME", ""],	2);	
	Processor_spawnpool_add("LABS",			[RhinoFreak,	"BASEGAME", ""],	0.4);	
	Processor_spawnpool_add("LABS",			[ExploFreak,	"BASEGAME", ""],	0.2);	

	Processor_create_spawnpool("PALACE", 11, 7, 1);
	Processor_spawnpool_add("PALACE",		[Guardian,		"BASEGAME", ""],	1);		
	Processor_spawnpool_add("PALACE",		[ExploGuardian,	"BASEGAME", ""],	0.1);	
	
	Processor_create_spawnpool("OASIS", 5, 15, 1);
	Processor_spawnpool_add("OASIS",		[BoneFish,		"BASEGAME", ""],	1);		
	Processor_spawnpool_add("OASIS",		[Crab,			"BASEGAME", ""],	0.1);	
	
	Processor_create_spawnpool("MANSION", 7, 12, 1);
	Processor_spawnpool_add("MANSION",		[Molesarge,		"BASEGAME", ""],	1);	
	Processor_spawnpool_add("MANSION",		[FireBaller,	"BASEGAME", ""],	0.4);	
	Processor_spawnpool_add("MANSION",		[Jock,			"BASEGAME", ""],	0.3);	
	
	Processor_create_spawnpool("JUNGLE", 10, 10, 1);
	Processor_spawnpool_add("JUNGLE",		[JungleBandit,	"BASEGAME", ""],	1);	
	Processor_spawnpool_add("JUNGLE",		[JungleAssassin,"BASEGAME", ""],	0.1);	
	
	Processor_create_spawnpool("ROBOCENTER", 11, 15, 1);
	Processor_spawnpool_add("ROBOCENTER",	["Swarmbot_create",	"MOD", "Frontier_Labs"],	1);	
	Processor_spawnpool_add("ROBOCENTER",	["MissileDrone",	"MOD", "Frontier_Labs"],	0.1);	
	
#define Processor_compat_additions
	if(global.allowPoolPushing = true){
		if(mod_exists("mod", "undergrowth")){
			if(array_find_index(global.knownPoolAddons, "Undergrowth") = -1){
				array_push(global.knownPoolAddons, "Undergrowth")
				
				Processor_create_spawnpool("UNDERGROWTH", 7, 12, 1);
				Processor_spawnpool_add("UNDERGROWTH", ["Firefly",		"OBJ", ["area", "undergrowth"]],	2);	
				Processor_spawnpool_add("UNDERGROWTH", ["PitcherPlant",	"OBJ", ["area", "undergrowth"]],	1);	
			}
		}
		
		if(mod_exists("mod", "ntte")){
			if(array_find_index(global.knownPoolAddons, "NTTE") = -1){
				array_push(global.knownPoolAddons, "NTTE")
				
				trace("PUSHTE")
				
				Processor_create_spawnpool("COAST", 6, 10, 1);
				Processor_spawnpool_add("COAST", ["Gull",			"OBJ", ["mod", "telib"]],	2);	
				Processor_spawnpool_add("COAST", ["TrafficCrab",	"OBJ", ["mod", "telib"]],	1);	
				Processor_spawnpool_add("COAST", ["Pelican",		"OBJ", ["mod", "telib"]],	0.4);	
				Processor_spawnpool_add("COAST", ["Diver",			"OBJ", ["mod", "telib"]],	0.8);	
				
				Processor_create_spawnpool("LAIR",	6, 13, 1);
				Processor_spawnpool_add("LAIR",	[Rat,			"BASEGAME", ""],				1.4);
				Processor_spawnpool_add("LAIR", ["Cat",			"OBJ", ["mod", "telib"]],		1);	
				Processor_spawnpool_add("LAIR", ["Bat",			"OBJ", ["mod", "telib"]],		0.6);	
				
				Processor_create_spawnpool("TRENCH", 8, 8, 1);
				Processor_spawnpool_add("TRENCH", ["Jelly",		"OBJ", ["mod", "telib"]],		1);	
		//		Processor_spawnpool_add("TRENCH", ["Angler",	"OBJ", ["mod", "telib"]],		0.4);
		//		eels have an on_death corpse spawn and anglers felt bad. welcome to jellyworld
				
				Processor_spawnpool_add("DESERT", ["BabyScorpion",	"OBJ", ["mod", "telib"]],		0.3);				
		//		Processor_spawnpool_add("SEWERS", ["Cat",			"OBJ", ["mod", "telib"]],		0.8);	
				Processor_spawnpool_add("SEWERS", ["BabyGator",		"OBJ", ["mod", "telib"]],		0.4);	
				Processor_spawnpool_add("SEWERS", ["AlbinoGator",	"OBJ", ["mod", "telib"]],		0.05);	
				Processor_spawnpool_add("OASIS", ["Puffer",			"OBJ", ["mod", "telib"]],		0.2);
				Processor_spawnpool_add("OASIS", ["HammerShark",	"OBJ", ["mod", "telib"]],		0.07);
				Processor_spawnpool_add("CRYSTAL CAVES", ["CrystalBat",	"OBJ", ["mod", "telib"]],	0.2);
				Processor_spawnpool_add("CRYSTAL CAVES", ["Mortar",	"OBJ", ["mod", "telib"]],		0.2);
				
			}
		}
	}

	
#define Processor_create_spawnpool(_name, _difficulty, _baseSpawnCount, _weight)
	ds_list_add(global.spawnPoolNames,	_name);			// add to name list
	array_push(global.spawnPools, [[], _difficulty, _baseSpawnCount, _weight, _name]) // adds array of values to list of spawn pools, array is empty, to be filled with spawnpool_add
#define Processor_spawnpool_add(_pool, _enemyArray, _weight)
	var _poolNum = ds_list_find_index(global.spawnPoolNames, _pool);
	array_push(global.spawnPools[_poolNum][0], [_enemyArray, _weight]);

#define Processor_choosePool

	var _spawnMultiplier	= 1 + GameCont.loops;
		
	 // get array of spawnpools within current difficulty level
	var _validPools = []
	var _index = 0;
	repeat(array_length(global.spawnPools)){
		var _array		= global.spawnPools[_index];
		var _difficulty = global.spawnPools[_index][1]
		if(GameCont.hard >= _difficulty){
			array_push(_validPools, [[_array[0], _array[2]], _array[3]])
		}
		_index += 1
	}

	var _chosenPool 	= call(scr.pool, _validPools);
	spawnPool			= _chosenPool[0];
	spawnCount			= _chosenPool[1] * _spawnMultiplier;

#define ProcessorEnemy_create(_x, _y, _processor, _object)
	switch(_object[1]){
		case "BASEGAME": {
			with(instance_create(_x, _y, _object[0])){
				ProcessorEnemy_spawnEffect(_processor);
			}
		}
		break;
		case "MOD": {
			with(mod_script_call("mod", _object[2], _object[0], _x, _y)){
				ProcessorEnemy_spawnEffect(_processor);
			}
		}
		break;
		case "OBJ": {
			with(mod_script_call(_object[2][0], _object[2][1], "obj_create", _x, _y, _object[0])){
				ProcessorEnemy_spawnEffect(_processor);
			}
		}
		break;
	}

#define ProcessorEnemy_spawnEffect(_processor)
	sound_play_pitch(global.sndCyberspaceEnemySpawn, 1.1 + random(0.4))

	fr_processor		= _processor;
	depth				= -1;
	spr_dead			= global.sprCyberspaceEnemyDie;
	snd_dead			= global.sndCyberspaceEnemyDead;
	raddrop				= 0;
	kills				= 0;
	hitid				= [global.sprCyberspaceEnemyDie, "MALWARE"];
	
	repeat(9){
		with(instance_create(x + random_range(-(sprite_width / 3), (sprite_width / 3)), y + random_range(-(sprite_height / 3), (sprite_height / 3)), CaveSparkle)){
			sprite_index	= global.sprCyberspaceEnemyTrail;
			image_angle		= random(360);
			direction		= random(360);
			speed			= 3 + random(3);
		}
	}
	
	return self;

#define Smile_create(_x, _y)
	with(instance_create(_x, _y, CustomEnemy)){
		
		name = "Smile";
		
		sprite_index	= global.sprSmile;
		spr_idle		= sprite_index;
		spr_walk		= sprite_index;
		spr_hurt		= sprite_index;
		spr_dead		= global.sprSmileDead;;
		hitid			= [sprite_index, "YOU STUPID"]
		depth			= -2;
		
		mask_index		= mskPlasma;
		direction		= random(360);
		smileSpeed		= 3;
		kills			= 0;
		canmelee		= true;
		meleedamage		= 1;
		my_health		= 1/0;
		smileCooldown	= 10;
		smilesMade		= 0;
		smilesMax		= 1;
		corpse			= false;
		size			= 3;
		
		snd_hurt		= global.sndSmileHurt;
		snd_mele		= global.sndSmileHurt;
		
		on_step 		= Smile_step;
		on_hurt			= Smile_hurt;
		
		return self;
	}

#define Smile_step
		speed = smileSpeed;
		smileCooldown -= current_time_scale;
		
		image_index	= global.smileIndex;
		
		 // Wall Bounce:
		if(place_meeting(x + hspeed_raw, y + vspeed_raw, Wall) || place_meeting(x + hspeed_raw, y + vspeed_raw, InvisiWall)){
			direction += 180 + random_range(-45, 45);
		}
		
#define Smile_hurt(_dmg, _spd, _dir)
	if(smilesMade < smilesMax){
		if(smileCooldown <= 0){
			with(Smile_create(x, y)){
				smilesMax = other.smilesMax - 1;
			}
			smileCooldown = 40;
			smilesMade += 1;
		}
	}
	
	sound_play_hit(snd_hurt, 0.3);
	motion_add(_dir, _spd);
	
	nexthurt   = current_frame + 6;
	my_health -= _dmg;

#define cyberspace_revive(_index)
		if(global.settingCyberspaceEnabled = true && GameCont.fr_visitedCyberspace = false){
		var _externalRevives = 0;
		
		 // YUNG CUZ
		if(mod_exists("mod", "ntte")){
			with(instances_matching(CustomHitme, "name", "NTTEPet")){
				if((pet = "Cuz") && (leader_index = _index)){
					_externalRevives += 1;
				}
			}
		}
		if(_externalRevives = 0){
			
			
			GameCont.fr_visitedCyberspace = true;
			
			robot_bluescreen(_index);
			sound_play_music(global.sndBlank);
			sound_play_ambient(global.sndBlank);
			
			
			
			 // Change Seed: (taken from warp zone)
			var _newSeed = GameCont.gameseed[(max(0, GameCont.atseed) + irandom(4)) % array_length(GameCont.gameseed)];
			with(GameCont){
				var _lastSeed = {};
				with(["mutseed", "junseed", "patseed", "codseed"]){
					var _seed = variable_instance_get(other, self);
					lq_set(_lastSeed, self, (is_array(_seed) ? array_clone(_seed) : _seed));
				}
				game_set_seed(_newSeed);
				for(var i = 0; i < lq_size(_lastSeed); i++){
					variable_instance_set(self, lq_get_key(_lastSeed, i), lq_get_value(_lastSeed, i));
				}
			}
			
			 // thank u yokin
			if(player_is_active(_index) && !GameCont.win){
				
				 // Destroy Items:
				with(Portal){
					instance_delete(self);
				}
				with(enemy){
					instance_delete(self);
				}
				with(becomenemy){
					instance_delete(self);
				}
				with(projectile){
					instance_delete(self);
				}
			//	with(WepPickup){
			//		instance_delete(self);
			//	}
				with(Trap){
					instance_destroy();
				}
				sound_stop(sndSalamanderFireLoop);
				sound_stop(sndFiretrap);
				
				 // stop deeplabs explo:
				with(instances_matching(CustomObject, "name", "fr_DeeplabsFinaleController")){
					instance_destroy();
				}
				mod_variable_set("area", "deeplabs", "esploded", true);
				with(instances_matching([CustomObject, Effect], "fr_coreDetoKill", true)){
						instance_delete(self);
				}
				
				instance_create(10016, 10016, becomenemy);
				respawnProtector_create(10016, 10016);
				
				 // robot racechange PART ONE
				/*
				var	_race     = "robot",
					_lastRace = player_get_race(_index);
					
				player_set_race(_index, _race);
				*/
				
				 // Make Player:
				with(instance_create(x, y, Revive)){
					p			= _index;
					index		= _index;
					canrevive	= true;
					with(instance_create(x, y, CustomHitme)){
						with(other){
							event_perform(ev_collision, Player);
						}
						instance_delete(self);
					}
					with(self){
						event_perform(ev_alarm, 0);
					}
				}
				with(player_find(_index)){
					sound_stop(snd_hurt);
					
					 // Setup:
		//			race        	= _race; ROBOT RACE CHANGE PART TWO
					nexthurt    	= current_frame + 30;
					spiriteffect	= 6;
					canwalk 		= false;
					canspec 		= false;
					if(skill_get(mut_strong_spirit) > 0){
						canspirit = false;
						GameCont.canspirit[index] = true;
					}
				}
				
					// robot race change PART THREE
				/*
				 // Swap Ultras:
				var _ultraSwap = true;
				for(var i = 0; i < maxp; i++){
					if(player_get_race(i) == _lastRace){
						_ultraSwap = false;
						break;
					}
				}
				if(_ultraSwap){
					var _ultraNum = ultra_count(_lastRace);
					for(var i = 1; i <= _ultraNum; i++){
						if(ultra_get(_lastRace, i) != 0){
							ultra_set(_lastRace, i, 0);
							ultra_set(_race, 1 + ((i - 1) % ultra_count(_race)), true);
						}
					}
				}
				*/
				
				 // Ammo:
				with(instances_matching(WepPickup, "ammo", 0)){
					ammo = 1;
				}
				
				
				 // Fixes:
				with(Crown){
					persistent = true;
				}
				with(instances_matching_lt(Portal, "endgame", 0)){
					endgame = 100;
					if(instance_is(self, BigPortal)){
						sprite_index = sprBigPortal;
					}
					else switch(type){
						case 1 : sprite_index = sprPortal;      break;
						case 2 : sprite_index = sprProtoPortal; break;
						case 3 : sprite_index = sprPopoPortal;  break;
					}
				}
				with(instances_matching(Revive, "p", _index)){
					instance_delete(self);
				}
				with(button){
					instance_destroy();
				}
				with(UnlockScreen){
					alarm_set(0, -1);
				}
				game_letterbox = false;
			}
		}
	}
	
#define respawnProtector_create(_x, _y)
	with(instance_create(_x, _y, CustomObject)){
		name = "fr_cyberspaceRespawnProtector"
		
		on_step 	= respawnProtector_step;
		
		return self;
	}
	
#define respawnProtector_step
	with(Player){
		my_health = maxhealth;
	}
	
#define robot_bluescreen(_index)
	with(BluescreenController_create(10016, 10016)){
		for(var i = 0; i < maxp; i++){
			view_object = other;
			view_pan_factor = 9999
		}		
	}

#define BluescreenController_create(_x, _y)
	with(instance_create(_x, _y, CustomObject)){
		
		
		name = "fr_bluescreenController";
		
		sprite_index	= global.sprBluescreenBackgroundExt;
		image_xscale	= 10000;
		image_yscale	= 10000;
		
		depth		= -20;
		barHeight	= 10;
		blueTime	= 0;
		blueChecks	= 0;
		drawDots	= true;
		drawConnect	= false;
		
		on_draw 	= bluescreen_draw;
		on_step 	= bluescreen_step;
	
		
		
		return self;
	}
	
#define bluescreen_step
	blueTime += current_time_scale;
	if(blueTime >= 30 && blueChecks = 0){
		sound_play_pitch(sndNoSelect, 1.1);
		barHeight -= 10;
		blueChecks += 1;
	}
	if(blueTime >= 80 && blueChecks = 1){
		sound_play_pitch(sndMutant8LowH, 0.8);
		drawDots	= false;
		barHeight -= 12;
		blueChecks += 1;
	}
	if(blueTime >= 100 && blueChecks = 2){
		sound_play_pitch(sndNoSelect, 1.1);
		barHeight -= 24;
		blueChecks += 1;
	}
	if(blueTime >= 115 && blueChecks = 3){
		sound_play_pitch(sndNoSelect, 1.2);
		BluescreenButton_create(x - 87, y + 51, other, global.sprBluescreenButtonYes, true);
		BluescreenButton_create(x - 16, y + 51, other, global.sprBluescreenButtonNo, false);
		barHeight -= 80;
		blueChecks += 1;
	}

#define bluescreen_draw
	if(instance_exists(Player)){
		draw_sprite_tiled(global.sprBluescreenBackgroundExt, 0, view_xview_nonsync, view_yview_nonsync);
		draw_sprite(global.sprBluescreenBackground, 0, view_xview_nonsync + (game_width / 2), view_yview_nonsync + (game_height / 2));
		if(drawDots = true){
			draw_sprite(global.sprBluescreenBackgroundSearch, current_frame * 0.2, view_xview_nonsync + (game_width / 2) + 106, view_yview_nonsync + (game_height / 2) - 2);
		}
		draw_sprite_stretched(global.sprBluescreenBackgroundBar, 0, view_xview_nonsync + (game_width / 2) - 160, view_yview_nonsync + (game_height / 2) - barHeight, 320, 200);
		if(drawConnect = true){
			draw_sprite(global.sprBluescreenBackgroundReboot, 0, view_xview_nonsync + (game_width / 2), view_yview_nonsync + (game_height / 2));	
			draw_sprite(global.sprBluescreenBackgroundSearch, current_frame * 0.2, view_xview_nonsync + (game_width / 2) + 81, view_yview_nonsync + (game_height / 2) + 2);	
		}
	}
	
#define bluescreen_accept(_controller)
	with(GameCont){
		area = "cyberspace";
		subarea = 0;
	}
	
	with(_controller){
		barHeight = 120;
		drawConnect	= true;
	}
	
	 // Portal!!
	with(call(scr.instance_random, Player)){
		with(instance_create(x, y, Portal)){
			type			= 3;
			
			 // bring weapons and trinkets and pets with u
			with(WepPickup){
				x = other.x;
				y = other.y;
			}
			with(instances_matching(CustomObject, "name", "tk_TrinketPickup")){
				x = other.x;
				y = other.y;
			}
			with(instances_matching(CustomHitme, "name", "NTTEPet")){
				x = other.x;
				y = other.y;
			}
		}
	}
	sound_stop(sndPortalAppear);
	sound_stop(sndPortalClose);
	
	 // change skin if u accept deal:
	with(Player){
		if(race = "robot"){
			var _newSkin = bskin;
			switch(bskin){
				case 0:
					_newSkin = "RobotBluescreened";
					
					 // v100 doesnt set sprites automaitcally anymore
					spr_idle	= mod_variable_get("skin", "RobotBluescreened", "sprIdle");
					spr_walk	= mod_variable_get("skin", "RobotBluescreened", "sprWalk");
					spr_hurt	= mod_variable_get("skin", "RobotBluescreened", "sprHurt");
					spr_dead	= mod_variable_get("skin", "RobotBluescreened", "sprDead");
					spr_sit1	= mod_variable_get("skin", "RobotBluescreened", "sprGoSit");
					spr_sit2	= mod_variable_get("skin", "RobotBluescreened", "sprSit");
	
				break;
				case 1:
					_newSkin = "RobotBluescreenedB";
					
					 // v100 doesnt set sprites automaitcally anymore
					spr_idle	= mod_variable_get("skin", "RobotBluescreenedB", "sprIdle");
					spr_walk	= mod_variable_get("skin", "RobotBluescreenedB", "sprWalk");
					spr_hurt	= mod_variable_get("skin", "RobotBluescreenedB", "sprHurt");
					spr_dead	= mod_variable_get("skin", "RobotBluescreenedB", "sprDead");
					spr_sit1	= mod_variable_get("skin", "RobotBluescreenedB", "sprGoSit");
					spr_sit2	= mod_variable_get("skin", "RobotBluescreenedB", "sprSit");
	
				break;
				case 2:
					_newSkin = "RobotBluescreenedC";
					 // this will probably conflict with hazmat robot on v9944 but I dont like hazmat robot so i dont care
					 // v100 doesnt set sprites automaitcally anymore
					spr_idle	= mod_variable_get("skin", "RobotBluescreenedC", "sprIdle");
					spr_walk	= mod_variable_get("skin", "RobotBluescreenedC", "sprWalk");
					spr_hurt	= mod_variable_get("skin", "RobotBluescreenedC", "sprHurt");
					spr_dead	= mod_variable_get("skin", "RobotBluescreenedC", "sprDead");
					spr_sit1	= mod_variable_get("skin", "RobotBluescreenedC", "sprGoSit");
					spr_sit2	= mod_variable_get("skin", "RobotBluescreenedC", "sprSit");
	
				break;
				case "turret":
					_newSkin = "RobotBluescreenedTurret";
					
					 // v100 doesnt set sprites automaitcally anymore
					spr_idle	= mod_variable_get("skin", "RobotBluescreenedTurret", "sprIdle");
					spr_walk	= mod_variable_get("skin", "RobotBluescreenedTurret", "sprWalk");
					spr_hurt	= mod_variable_get("skin", "RobotBluescreenedTurret", "sprHurt");
					spr_dead	= mod_variable_get("skin", "RobotBluescreenedTurret", "sprDead");
					spr_sit1	= mod_variable_get("skin", "RobotBluescreenedTurret", "sprHurt");
					spr_sit2	= mod_variable_get("skin", "RobotBluescreenedTurret", "sprHurt");
					
				break;
				case "bonus robot":
					_newSkin = "RobotBluescreenedBonus";
					
					 // v100 doesnt set sprites automaitcally anymore
					spr_idle	= mod_variable_get("skin", "RobotBluescreenedBonus", "sprIdle");
					spr_walk	= mod_variable_get("skin", "RobotBluescreenedBonus", "sprWalk");
					spr_hurt	= mod_variable_get("skin", "RobotBluescreenedBonus", "sprHurt");
					spr_dead	= mod_variable_get("skin", "RobotBluescreenedBonus", "sprDead");
					spr_sit1	= mod_variable_get("skin", "RobotBluescreenedBonus", "sprGoSit");
					spr_sit2	= mod_variable_get("skin", "RobotBluescreenedBonus", "sprSit");
	
				break;
				default:
					if(is_string(bskin)){
						if(mod_script_exists("skin", bskin, "skin_robot_bluescreened")){
							_newSkin = mod_script_call("skin", bskin, "skin_robot_bluescreened");
						}
					}
				break;
			}
			bskin = _newSkin;
			player_set_skin(index, _newSkin);
		}
	
		 // Fill Ammo:
		ammo[1] = typ_amax[1];
		ammo[2] = typ_amax[2];
		ammo[3] = typ_amax[3];
		ammo[4] = typ_amax[4];
		ammo[5] = typ_amax[5];
	}

#macro _tespr mod_variable_get("mod", "teassets", "spr");

#define bluescreen_deny
	var _deathCause = GameCont.deathcause;
	with(Player){
		instance_destroy();
	}
	GameCont.deathcause = _deathCause;
	script_bind_draw(denybluescreen_draw, -14);
	with(instances_matching(CustomObject, "name", "fr_bluescreenController")){
		instance_destroy();
	}

#define denybluescreen_draw
	draw_sprite_tiled(global.sprBluescreenBackgroundExt, 0, view_xview_nonsync, view_yview_nonsync);
	draw_sprite(global.sprBluescreenBackgroundDeny, 0, view_xview_nonsync + (game_width / 2), view_yview_nonsync + (game_height / 2));
	
#define BluescreenButton_create(_x, _y, _creator, _spr, _yes)
	with(call(scr.create_button, _x, _y, mskNone, BluescreenButton_click, BluescreenButton_hover)){
		fr_bluescreenbutton	= true;
		
		sprite_index	= _spr
		mask_index		= global.mskBluescreenButton;
		image_index		= 0;
		image_speed		= 0;
		depth			= -10010
		yesButton		= _yes;

		creator			= _creator;
		hoverTime   	= 0;
		done			= false;
		
		clickScr		= script_ref_create(BluescreenButton_click)
		hoverScr		= script_ref_create(BluescreenButton_hover)
		on_end_step 	= BluescreenButton_endstep;
	}

#define BluescreenButton_click
	if(yesButton = true){
		bluescreen_accept(creator);
	} else {
		bluescreen_deny();
	}
	with(instances_matching(CustomObject, "fr_bluescreenbutton", true)){
		done = true;
		// destroying here deos an error idk
	}
	
#define BluescreenButton_hover
	image_index	= 0;
	hoverTime = 2;
	
#define BluescreenButton_endstep
	if(hoverTime < 1){
		image_index = 1;
	}
	if(hoverTime > 0){
		hoverTime -= current_time_scale;
	}
	if(done = true){
		instance_destroy();
	}

#macro  anim_end																				((image_index + image_speed_raw) >= image_number || (image_index + image_speed_raw) < 0)
#macro  FloorNormal																				instances_matching(Floor, "object_index", Floor)
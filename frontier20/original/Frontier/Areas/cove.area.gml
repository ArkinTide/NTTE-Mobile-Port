#define init

		// LIB:
	while(!mod_exists("mod", "lib")){wait(1);}
	script_ref_call(["mod", "lib", "getRef"], "area", mod_current, "scr");
	#macro  scr			global.scr
	#macro  call		script_ref_call
	
		// SETTINGS //
	global.settingAltCoveEntrance		= false;


		// SOUNDS //
	global.musCove 						= sound_add("../sounds/music/musCove.ogg");
	global.sndAhoy 						= sound_add("../sounds/misc/sndAhoy.ogg");
	global.sndWoodBreak					= sound_add("../sounds/props/sndWoodBreak.ogg");
	global.sndGunpowderBarrelBreak		= sound_add("../sounds/props/sndGunpowderBarrelBreak.ogg");
	global.sndTreasureBarrelBreak		= sound_add("../sounds/props/sndTreasureBarrelBreak.ogg");

		// Area Sprites //
	global.sprAreaIcon					= sprite_add("../sprites/areas/cove/sprCoveIcon.png", 1, 5, 4);
	global.sprFloor 					= sprite_add("../sprites/areas/cove/sprFloorCove.png", 2, 0, 0);
//	global.sprFloorB					= sprite_add("../sprites/areas/cove/sprFloorCoveB.png", 1, 2, 2);
	global.sprFloorB					= sprite_add("../sprites/areas/cove/sprFloorCoveBBig.png", 2, 16, 16);
	global.sprFloorC					= sprite_add("../sprites/areas/cove/sprFloorCoveC.png", 6, 0, 0);
	global.sprSnowFloorC				= sprite_add("../sprites/areas/cove/sprSnowFloorCoveC.png", 1, 32, 32);	
	global.sprFloorExplo				= sprite_add("../sprites/areas/cove/sprFloorCoveExplo.png", 4, 1, 1);
	global.sprWallBot					= sprite_add("../sprites/areas/cove/sprWallCoveBot.png", 1, 0, 0);
	global.sprWallTop					= sprite_add("../sprites/areas/cove/sprWallCoveTop.png", 5, 0, 0);
	global.sprWallOut					= sprite_add("../sprites/areas/cove/sprWallCoveOut.png", 2, 4, 12);
	global.sprWallBotB					= sprite_add("../sprites/areas/cove/sprWallCoveBBot.png", 4, 0, 0);
	global.sprWallTopB					= sprite_add("../sprites/areas/cove/sprWallCoveBTop.png", 4, 0, 0);
	global.sprWallOutB					= sprite_add("../sprites/areas/cove/sprWallCoveBOut.png", 3, 4, 12);
	global.sprWallTrans					= sprite_add("../sprites/areas/cove/sprWallCoveTrans.png", 2, 0, 0);
	global.sprDebris					= sprite_add("../sprites/areas/cove/sprDebrisCove.png", 4, 4, 4);
	global.sprDetail					= sprite_add("../sprites/areas/cove/sprDetailCove.png", 5, 4, 4);
	global.sprTopDecal					= sprite_add("../sprites/areas/cove/sprTopDecalCove.png", 6, 16, 16);
	global.sprAHOY						= sprite_add("../sprites/areas/cove/sprAHOY.png", 1, 214, 120);
	global.sprCoveDrip					= sprite_add("../sprites/particles/sprCoveDrip.png", 5, 4, 14);
	global.sprGemSparkle				= sprite_add("../sprites/particles/sprGemSparkle.png", 5, 8, 8); 
	global.sprWallCoveBTransSpread		= sprite_add("../sprites/areas/cove/sprWallCoveBTransSpread.png", 	4, 24, 24);
	
		// Object Sprites //
	global.sprDabloons					= sprite_add("../sprites/particles/sprDabloons.png", 4, 3, 3);	
	
	 // Treasure Mimic:
	global.sprTreasureMimicIdle			= sprite_add("../sprites/areas/cove/props/sprTreasureMimicIdle.png", 1, 16, 16);
	global.sprTreasureMimicPeek			= sprite_add("../sprites/areas/cove/props/sprTreasureMimicPeek.png", 1, 16, 16);
	global.sprTreasureMimicStartPeek	= sprite_add("../sprites/areas/cove/props/sprTreasureMimicStartPeek.png", 3, 16, 16);
	global.sprTreasureMimicEndPeek		= sprite_add("../sprites/areas/cove/props/sprTreasureMimicEndPeek.png", 3, 16, 16);
	global.sprTreasureMimicStartHungry	= sprite_add("../sprites/areas/cove/props/sprTreasureMimicStartHungry.png", 3, 16, 16);
	global.sprTreasureMimicHungry		= sprite_add("../sprites/areas/cove/props/sprTreasureMimicHungry.png", 5, 16, 16);
	global.sprTreasureMimicEndHungry	= sprite_add("../sprites/areas/cove/props/sprTreasureMimicEndHungry.png", 3, 16, 16);
	global.sprTreasureMimicEat			= sprite_add("../sprites/areas/cove/props/sprTreasureMimicEat.png", 12, 32, 16);
	global.sprTreasureMimicDeny			= sprite_add("../sprites/areas/cove/props/sprTreasureMimicDeny.png", 6, 16, 16);

	 // Gunpowder Barrel:
	global.sprGunpowderBarrel			= sprite_add("../sprites/areas/cove/props/sprGunpowderBarrel.png", 1, 16, 16);
	global.sprGunpowderBarrelHurt		= sprite_add("../sprites/areas/cove/props/sprGunpowderBarrelHurt.png", 3, 16, 16);
	global.sprGunpowderBarrelDead		= sprite_add("../sprites/areas/cove/props/sprGunpowderBarrelDead.png", 3, 16, 16);
	global.shdGunpowderBarrel			= sprite_add("../sprites/areas/cove/props/shdGunpowderBarrel.png", 1, 16, 16);
    global.sprGunpowderBarrelDebris 	= sprite_add("../sprites/particles/sprGunpowderBarrelDebris.png",	3, 4, 4);
	
	 // Treasure Barrels:
	global.sprTreasureBarrel			= sprite_add("../sprites/areas/cove/props/sprTreasureBarrel.png", 1, 12, 12);
	global.sprTreasureBarrelHurt		= sprite_add("../sprites/areas/cove/props/sprTreasureBarrelHurt.png", 3, 12, 12);
	global.sprTreasureBarrelDead		= sprite_add("../sprites/areas/cove/props/sprTreasureBarrelDead.png", 3, 12, 12);
	global.sprTreasureBarrel2			= sprite_add("../sprites/areas/cove/props/sprTreasureBarrel2.png", 1, 12, 12);
	global.sprTreasureBarrel2Hurt		= sprite_add("../sprites/areas/cove/props/sprTreasureBarrel2Hurt.png", 3, 12, 12);
	global.sprTreasureBarrel2Dead		= sprite_add("../sprites/areas/cove/props/sprTreasureBarrel2Dead.png", 3, 12, 12);
	
	 // GROG!!!!!!:
	global.sprGrogBottleDebris			= sprite_add("../sprites/areas/cove/props/sprGrogBottleDebris.png", 4, 4, 4);	
	global.sprGrogBottle1				= sprite_add("../sprites/areas/cove/props/sprGrogBottle1.png", 1, 16, 14);	 
	global.sprGrogBottle1Hurt			= sprite_add("../sprites/areas/cove/props/sprGrogBottle1Hurt.png", 3, 16, 14);	 
	global.sprGrogBottle1Dead			= sprite_add("../sprites/areas/cove/props/sprGrogBottle1Dead.png", 3, 16, 14);	 
	global.sprGrogBottle2				= sprite_add("../sprites/areas/cove/props/sprGrogBottle2.png", 1, 16, 14);	 
	global.sprGrogBottle2Hurt			= sprite_add("../sprites/areas/cove/props/sprGrogBottle2Hurt.png", 3, 16, 14);	 
	global.sprGrogBottle2Dead			= sprite_add("../sprites/areas/cove/props/sprGrogBottle2Dead.png", 3, 16, 14);	 
	global.sprGrogBottle3				= sprite_add("../sprites/areas/cove/props/sprGrogBottle3.png", 1, 16, 14);	 
	global.sprGrogBottle3Hurt			= sprite_add("../sprites/areas/cove/props/sprGrogBottle3Hurt.png", 3, 16, 14);	 
	global.sprGrogBottle3Dead			= sprite_add("../sprites/areas/cove/props/sprGrogBottle3Dead.png", 3, 16, 14);	 
	
	 // Torch:
	global.sprCoveTorch					= sprite_add("../sprites/areas/cove/props/sprCoveTorch.png", 4, 8, 12);
	global.sprCoveTorchHurt				= sprite_add("../sprites/areas/cove/props/sprCoveTorchHurt.png", 3, 8, 12);
	global.sprCoveTorchDead				= sprite_add("../sprites/areas/cove/props/sprCoveTorchDead.png", 5, 8, 12);
	
	#macro  anim_end					((image_index + image_speed_raw) >= image_number || (image_index + image_speed_raw) < 0)
	#macro  FloorNormal					instances_matching(Floor, "object_index", Floor)
	
	pirateweps_init();

#define pirateweps_init
	global.pirateInput	= ds_list_create();
	global.pirateOutput = ds_list_create();
	
	global.pirateOverwriteInput		= ds_list_create();
	global.pirateOverwriteOutput	= ds_list_create();

	piratewep_add(wep_rogue_rifle,				"FR_RogueBlunderbuss");
	piratewep_add(wep_shotgun, 					"FR_Blunderbuss");
	piratewep_add(wep_wrench,					"FR_TideTurner");
	piratewep_add(wep_crossbow,					"FR_CoralCrossbow");
	piratewep_add(wep_grenade_launcher, 		"FR_Blunderball");
	piratewep_add(wep_screwdriver,				"FR_Hookpole");
	piratewep_add(wep_disc_gun, 				"FR_HullShredder");
	piratewep_add(wep_triple_machinegun, 		"FR_VolleyGun");
	piratewep_add(wep_double_shotgun, 			"FR_DoubleBlunderbuss");
	piratewep_add(wep_bazooka, 					"FR_Deckblazer");
	piratewep_add(wep_splinter_gun, 			"FR_SpikerRifle");
	piratewep_add(wep_toxic_bow, 				"FR_ToxicCoralCrossbow");
	piratewep_add(wep_lightning_pistol, 		"FR_StarPistol");
	piratewep_add(wep_heavy_crossbow, 			"FR_Ballista");
	piratewep_add(wep_flame_shotgun, 			"FR_PowderShotgun");
	piratewep_add(wep_auto_shotgun, 			"FR_AutoBlunderbuss");
	piratewep_add(wep_flak_cannon, 				"FR_Flaken");
	piratewep_add(wep_flare_gun, 				"FR_CandleLauncher");
	piratewep_add(wep_sawed_off_shotgun, 		"FR_Blunderbug");
	piratewep_add(wep_lightning_rifle, 			"FR_StarRifle");
	piratewep_add(wep_splinter_pistol, 			"FR_SpikerPistol");
	piratewep_add(wep_super_splinter_gun,		"FR_SuperSpiker");
	piratewep_add(wep_double_flame_shotgun, 	"FR_DoublePowderShotgun");
	piratewep_add(wep_auto_crossbow, 			"FR_CoralAutoCrossbow");
	piratewep_add(wep_super_crossbow, 			"FR_CoralSuperCrossbow");
	piratewep_add(wep_heavy_grenade_launcher, 	"FR_Blunderboulder");
	piratewep_add(wep_energy_screwdriver, 		"FR_PowderSpear");
	piratewep_add(wep_lightning_shotgun,		"FR_StarShotgun");
	piratewep_add(wep_auto_flame_shotgun, 		"FR_PowderPopper");
	piratewep_add(wep_nuke_launcher,			"FR_FireworkCannon");
	piratewep_add(wep_lightning_smg, 			"FR_StarSMG");
	piratewep_add(wep_flame_cannon, 			"FR_CandleBarrage");
	piratewep_add(wep_energy_hammer, 			"FR_PowderHammer");
	piratewep_add(wep_blood_hammer, 			"FR_GhostCutlass");
	piratewep_add(wep_super_disc_gun, 			"FR_HullMangler");
	piratewep_add(wep_quadruple_machinegun, 	"FR_Enfilader");
	piratewep_add(wep_super_flak_cannon, 		"FR_QuadBarrel");
	piratewep_add(wep_incinerator, 				"FR_Enfileter");
	piratewep_add(wep_heavy_auto_crossbow, 		"FR_AutoBallista");
	piratewep_add(wep_guitar, 					"FR_HurdyGurdy");
	piratewep_add(wep_ultra_laser_pistol,		"FR_TeminiteCannon");
	piratewep_add("WO_UltraLaserPistol",		"FR_TeminiteCannon");	
	
	piratewep_add(wep_golden_wrench, 			"FR_GildedTideTurner");
	piratewep_add(wep_golden_shotgun, 			"FR_GildedBlunderbuss");
	piratewep_add(wep_golden_crossbow, 			"FR_GildedCoralCrossbow");
	piratewep_add(wep_golden_grenade_launcher, 	"FR_GildedBlunderball");
	piratewep_add(wep_golden_splinter_gun, 		"FR_GildedSpikerRifle");
	piratewep_add(wep_golden_screwdriver, 		"FR_GildedHookpole");
	piratewep_add(wep_golden_bazooka, 			"FR_GildedDeckblazer");
	piratewep_add(wep_golden_disc_gun, 			"FR_GildedHullShredder");
	piratewep_add(wep_golden_nuke_launcher, 	"FR_GildedFireworkCannon");
	
	
	
	 // IRIS VARIANTS:
	piratewep_add_overwrite("triple bouncer machinegun", 		"bouncer volley gun",		"FR_VolleyGun");	 
	piratewep_add_overwrite("triple fire machinegun", 			"fire volley gun",			"FR_VolleyGun"); 
	piratewep_add_overwrite("triple gamma machinegun", 			"gamma volley gun",			"FR_VolleyGun");	 
	piratewep_add_overwrite("triple pest machinegun", 			"pest volley gun",			"FR_VolleyGun");	 
	piratewep_add_overwrite("triple psy machinegun", 			"psy volley gun",			"FR_VolleyGun");	 
	piratewep_add_overwrite("triple thunder machinegun", 		"thunder volley gun",		"FR_VolleyGun");	 

	piratewep_add_overwrite("quad bouncer machinegun",			"bouncer enfilader",		"FR_Enfilader");	 
	piratewep_add_overwrite("quad fire machinegun", 			"fire enfilader",			"FR_Enfilader"); 
	piratewep_add_overwrite("quad gamma machinegun", 			"gamma enfilader",			"FR_Enfilader");	 
	piratewep_add_overwrite("quad pest machinegun", 			"pest enfilader",			"FR_Enfilader");	 
	piratewep_add_overwrite("quad psy machinegun", 				"psy enfilader",			"FR_Enfilader");	 
	piratewep_add_overwrite("quad thunder machinegun", 			"thunder enfilader",		"FR_Enfilader");	 
	 
#define area_subarea        	return 1;
#define area_goal           	return 150;
#define area_next           	return (mod_exists("area", "city")) ? ["city", 1] : [5, 1];
#define area_background_color	return make_color_rgb(75, 96, 93);
#define area_shadow_color   	return c_black;
#define area_darkness       	return true;
#define area_secret         	return false;
#define area_outside			return false;
    
#define area_name
	return "4-"+`@1(${real(global.sprAreaIcon)}:0)`;

#define area_text
	return choose(
		"YOHO!! YARR!!",
		"AHOY",
		"DON'T GET SCURVY",
		"HOLD ON TO YE PLUNDER",
		"DRINK GROG",
		"GOOD MORNING MUTANT CREW",
		"STOP KILLING ALL ME CUSTOMERS"
	);
	
#define area_mapdata(_lastX, _lastY, _lastArea, _lastSubarea, _subarea, _loops)
    return [
        63 + (9.5 * (_subarea - 1)), -9, (_subarea == 1)
    ]

#define area_areaicon
	return [
		global.sprAreaIcon,
		"4-?"
	]
	
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
		case sprTopPot:				return global.sprTopDecal;
	}

#define area_setup

	sound_play_music(global.musCove);
    sound_play_ambient(amb7);
    
	goal             = area_goal();
	background_color = area_background_color();
	BackCont.shadcol = area_shadow_color();
	TopCont.darkness = area_darkness();
    safespawn		 = 1;
    
     // Area Step:
    script_bind_step(area_step, 0);
    
     // Draws:
	script_bind_draw(CoveWallTransOut_draw, -10);
    
     // Wall Breaking Sounds:
    sound_assign(sndWallBreakRock, sndWallBreakRock);
   
#define area_setup_floor

	 // Fix BFloor Depth:
	if(styleb){ 
		// This is one lower than normal because C-Floor stuff
		depth -= 3; 
	}
	
	 // Sounds:
	material = (styleb ? 4 : 2);
	
    
#define area_start

	 // Half-Dark:
	 // See Frontier_Main's draw_dark
	with(instance_create(0, 0, CustomObject)){
		name = "fr_area_halfdark"
	}
	
	// Top Decals: 
	with(Floor){ 
		if (random(8) < 1){
			with instance_create(x, y, TopPot){
				sprite_index	= global.sprTopDecal;
				image_index		= irandom(image_number)
				image_xscale	= choose(-1, 1)
				image_speed		= 0;
			}
		}
	}
	 
	 // Captain's Quarters Props:
	with(instances_matching(Floor, "fr_coveChestFloor", true)){
		instance_create(x + 16, y + 16, PortalClear)
		if(place_meeting(x + 16, y + 16, prop)){
			with(instance_nearest(x + 16, y + 16, prop)){
				if(!instance_is(self, RadChest)){
					instance_destroy();
				}
			}
		}
		if(!mod_exists("mod", "betterPVP")){
			TreasureMimic_create(x + 16, y + 16)
		}
		with(WoodSpreader_create(x + 16, y + 16)){
			woodRange	= 96;
		}
	}
			
	 // Shipwreck Chunks:
	with(instances_matching(CustomObject, "name", "fr_CoveWoodSpreader")){
		itsGoTime = true;
	}
	
	 // Bubbles Unlock:
	if(call(scr.save_get, "Frontier", "unlock_bubbles") = 0){
		call(scr.save_set, "Frontier", "unlock_bubbles", 1); 
		call(scr.unlock_splat_ext, "BUBBLES UNLOCKED", "BUBBLES", mod_script_call("race", "bubbles", "race_unlock"), mod_variable_get("race", "bubbles", "sprPortrait"), 0, sndCharUnlock);
	}
	 
	 // AHOY:
	if(random(112) < 1) && (call(scr.save_get, "Frontier", "unlock_bubbles") = 1){
		sound_play_pitchvol(global.sndAhoy, 1, 1)
		with instance_create(10016, 10016, CustomObject){
			with script_bind_draw(AHOY_draw, -16, self){
				alphaPercent	= 1;
				timeToGo		= 45;
			}
		}
	}
	
	
	 // Urp:
	if(global.settingAltCoveEntrance = true){
		if(GameCont.loops > 0){
			with(instance_furthest(10016, 10016, Floor)){
				mod_script_call("mod", "Frontier_Caves", "CoveHyperCrystal_create", x + 16, y + 16);
			}
		}
	}
	
#define area_make_floor

	var _x = x,
		_y = y,
		_outOfSpawn = (point_distance(_x, _y, 10000, 10000) > 48);
		
	 // Place Floor:
    instance_create(_x, _y, Floor);
	
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
	
    // 3x3 Rooms:
	if(random(10) < 1) {
		scrFloorFill(_x, _y, 3, 3);
	}
	
	
	 // Wood Time!!
	if(random(26) < 1) {
		if(!instance_exists(self)){ exit; }
		WoodSpreader_create(x + 16, y + 16)
	}
	
    // 3x3 Wood Rooms:
    with(Wall){
		if(random(10) < 1) && (_outOfSpawn) && (distance_to_object(Wall) < 48) {
			scrWoodFloorFill(_x, _y, 5, 5);
		}
    }
    
     // Captain's Quarters:
	with(GenCont) if(instance_number(Floor) > goal){
		with(instance_furthest(10016, 10016, Floor)){
			 // Check area_start for wood/chest spawning
			with(instance_nearest((((x * 2) + 10000) / 3) + random_range(-64, 64), (((y * 2) + 10000) / 3) + random_range(-64, 64), Floor)){
				fr_coveChestFloor = true;
				scrFloorFill(x, y, 3, 5);
				scrFloorFill(x, y, 5, 3);
			}
		}
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
	
#define scrWoodFloorFill(_x, _y, _w, _h)
    var o = 32;

     // Center Around x,y:
    _x -= floor((_w - 1) / 2) * o;
    _y -= floor((_h - 1) / 2) * o;

     // Floors:
    for(var _ox = 0; _ox < _w; _ox++){
        for(var _oy = 0; _oy < _h; _oy++){
            with instance_create(_x + (_ox * o), _y + (_oy * o), Floor) {
            	sprite_index = sprFloor1B;
            }
        }
    }


	
#define area_pop_enemies

	var _x = (bbox_left + bbox_right)  / 2,
		_y = (bbox_top  + bbox_bottom) / 2;
		
	if(random(3) < 1){
		if(random(6) < (1 + (GameCont.loops))){
			if(random(13) < 1 * (1 + GameCont.loops)){
				mod_script_call("mod", "Frontier_Caves", "EliteWhale_create", _x, _y);
			}
			else{
				mod_script_call("mod", "Frontier_Caves", "Whale_create", _x, _y);
			}
		}
		else{
			if(random(3) < 1){
				repeat(2 + irandom(2)){
					if(random(6) < 1 * (1 + GameCont.loops)){
						mod_script_call("mod", "Frontier_Caves", "EliteStarfish_create", _x, _y);
					} else {
						mod_script_call("mod", "Frontier_Caves", "Starfish_create", _x, _y);
					}
				}
			}
			else{
				repeat(irandom_range(2, 3)){
					mod_script_call("mod", "Frontier_Caves", "Parrot_create", _x, _y);
				}
			}
		}
	}
	
#define area_pop_props

	 // Lone Walls:
	if((random(7) < 1) && point_distance(x, y, 10000, 10000) > 96 && !place_meeting(x, y, NOWALLSHEREPLEASE) && !place_meeting(x, y, hitme)){
		instance_create(x + choose(0, 16), y + choose(0, 16), Wall);
		instance_create(x, y, NOWALLSHEREPLEASE);
	}
	else{
		var _x = (bbox_left + bbox_right)  / 2,
			_y = (bbox_top  + bbox_bottom) / 2,
			_outOfSpawn = (point_distance(x, y, 10000, 10000) > 48);
		
		
		 // Props:
		if(_outOfSpawn){
			if(random(5) < 1){
				if(styleb){
					if(random(3) < 2){
						 // B-Floor Prop:
					//	instance_create(_x, _y, CrystalProp)
					}
				}
				else{
					if(random(3) < 1){
						 // Gunpowder Barrels:
						GunpowderBarrel_create(_x, _y)
					}
					else{
						if(random(3) < 1){
							TreasureBarrel_create(_x, _y);
						} else {
							// Lights:
							CoveTorch_create(_x, _y)
						}
					}
				}
			}
		}
	}
	
	 // Light Beams:
	if(distance_to_object(instance_nearest(x, y, LightBeam)) > 64 && random(7) < 1){
		instance_create(x, y, LightBeam)
	}

#define area_finish

	 // Bubbles Campfire Weapons:
	with(instances_matching(WepPickup, "wep", "fr_CorsairCutlass")){
		GameCont.fr_captainCutlass += 1;
	}

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
    // Restore Wall Sounds:
    sound_restore(sndWallBreakRock);

#define area_step

	 // Water Droplet effects (yeah I stole this from Undergrowth, what're YOU gonna do about it HUH):
	with(BackCont){
		if(alarm0 > 0 && alarm0 <= ceil(current_time_scale)){
			alarm0 += 50 + random(90);
			
			if(instance_exists(Floor)){
				
				 // Random Player's Screen:
				var _index = null;
				do _index = irandom(maxp - 1);
				until player_is_active(_index);
				
				var _sl = view_xview[_index],
					_st = view_yview[_index],
					_sr = _sl + game_width,
					_sb = _st + game_height,
					_fl = instances_matching_le(instances_matching_le(instances_matching_ge(instances_matching_ge(Floor, "bbox_right", _sl), "bbox_bottom", _st), "bbox_left", _sr), "bbox_top", _sb);
					
				if(array_length(_fl)){
					with(_fl[irandom(array_length(_fl) - 1)]){
						
						 // Dripp:
						with instance_create(x, y, Drip){
							sprite_index = global.sprCoveDrip;
						}
					}
				}
			}
		}
	}

#define CoveWallTransOut_draw
	with(instances_matching_ne(TopSmall, "fr_topSmallCove", null)){
		draw_sprite_ext(global.sprWallCoveBTransSpread, fr_topSmallCove, x + 8, y, 1, 1, fr_topSmallCoveRot, c_white, 1);
	}
	
#define WoodSpreader_create(_x, _y)

	with instance_create(_x, _y, CustomObject){
	//	instance_create(x, y, Torch)
		name = "fr_CoveWoodSpreader"
		
		itsGoTime	= false;
		woodRange	= 32 + irandom(48)
		on_step 	= WoodSpreader_step;
		
		return self;
	}
	
#define WoodSpreader_step

	if(itsGoTime = true){
	 
		// MY PRECIOUS POWER SHIP! ITS CRAHSED FOREVER!
		with(Floor){
			if(distance_to_object(other) < other.woodRange) && (!styleb){
				sprite_index	= global.sprFloorC;
				image_index		= irandom(3);
				if(random(5) < 1){
					image_index	= choose(4, 5);
				}
				depth			= 8
				material		= 2;
				styleb			= false;
				fr_woodFloor	= true;
				with(instance_create(x + 16, y + 16, SnowFloor)){
					sprite_index	= global.sprSnowFloorC;
					image_speed		= other.image_speed;
					image_index		= other.image_index;
					depth			= other.depth + 1;
				}
				
				 // GROGGING OUT !! ! //
				if(!place_meeting(x, y, prop)) && (!place_meeting(x, y, chestprop)){
					if(distance_to_object(Wall) <= 16){
						if(random(10) < 1){
							GrogBottle_create(x + 16, y + 16);
						}
					}
				}
			}
		}
	
		with(Wall){
			if(distance_to_object(other) < (other.woodRange + 16)){
				sprite_index	= global.sprWallBotB;
				topspr			= global.sprWallTopB;
				outspr			= global.sprWallOutB;
			}
		}
		
		with(TopSmall){
			if(distance_to_object(other) < (other.woodRange + 16)){
				fr_topSmallCove		= irandom(3);
				fr_topSmallCoveRot	= choose(0, 90, 180, 270);
			}
		}
		
		 // No Stones on Sticks:
		with(TopPot){
			if (distance_to_object(other) < other.woodRange + 16){
				instance_delete(self);
			}
		}

		 // Swab the deck:
	/*	with(Detail){
			if (distance_to_object(other) < other.woodRange){
				instance_delete(self);
			}
		}
	*/		
		instance_destroy();
	}
	

//#region PROPS AND OBJECTS
#define Prop_hurt(_dmg, _spd, _dir)
	my_health -= _dmg;
	nexthurt   = current_frame + 6;
	
	sound_play_hit(snd_hurt, 0.3);
	
	sprite_index = spr_hurt;
	image_index  = 0;
	
//#region TREASURE MIMIC
#define weapon_can_exchange(_wep)
	return (ds_list_find_index(global.pirateInput, _wep) != -1);

#define piratewep_add(_input, _output)
	ds_list_add(global.pirateInput, _input);
	ds_list_add(global.pirateOutput, _output)
	
#define piratewep_add_overwrite(_input, _output, _overwrite)
	 // overrides what the output weapon tracks, for unique weapons stat.
	 /*
		EX : 
		piratewep_add_overwrite("triple bouncer machinegun", "bouncer volley gun",	"FR_VolleyGun");
		
		in this case the mimic is spitting out the bouncer volley gun, but for the unique trades stat its counting it as a normal volley gun
		this is only needed when the output weapon and the desired weapon to input into the stats array are different
		basically only iris weps are gonna need this, probably.
	 */
	ds_list_add(global.pirateInput, _input);
	ds_list_add(global.pirateOutput, _output);
	ds_list_add(global.pirateOverwriteInput, _input);
	ds_list_add(global.pirateOverwriteOutput, _overwrite);

#define TreasureMimic_create(_x, _y)
	with(instance_create(_x, _y, CustomObject)){
		
		name = "fr_TreasureMimic"
		
		 // Visual:
		spr_idle		= global.sprTreasureMimicIdle;
		spr_strtpeek	= global.sprTreasureMimicStartPeek;
		spr_endpeek		= global.sprTreasureMimicEndPeek;
		spr_peek		= global.sprTreasureMimicPeek;
		spr_swap		= global.sprTreasureMimicEat;
		spr_strthungry  = global.sprTreasureMimicStartHungry;
		spr_hungry		= global.sprTreasureMimicHungry;
		spr_endhungry	= global.sprTreasureMimicEndHungry;
		spr_deny		= global.sprTreasureMimicDeny;
		sprite_index	= spr_idle;
		spr_shadow		= shd64B;
		spr_shadow_y	= 0;
		image_speed 	= 0.4;
		depth			= 0;
		
		  // Vars:
		text			= "@(color:3516363)EXCHANGE#@wWEAPON?";
		pick			= -1;
		targetplayer	= noone;  // Player who is trading:
		playerwep		= noone;  // They weapon:
		outputwep		= noone;  // What to spit back out:
		validwep		= true;   // Checks if valid weapon was given:
		canswap			= true;   // Checks if can swap right now:
		playerNear		= false;
		hungry			= false;
		inputwep		= noone;
		
		 // Prompt:
		with call(scr.prompt_create,text) { 
			on_step = WeaponExchangerPrompt_step; creator = other;
		}
		
		 // Portal Pusher
		mod_script_call("mod", "Frontier_Objects", "PortalPusher_create", x, y, 96);
		
		 // Events:
		on_step	= TreasureMimic_step;
		on_draw	= TreasureMimic_draw;
		
		return self;
	}
	
#define WeaponExchangerPrompt_step
	if(pick != -1){ 
		with (creator) { 
			pick = 1; 
		} 
	}
	if !instance_exists(creator) { exit; }
	if (creator.canswap = false) { instance_destroy() }
	
#define TreasureMimic_step

	x = xstart;
	y = ystart;
	speed = 0;
	var me = self;
	
	 // Move Chests:
	if(distance_to_object(chestprop) < 8){
		with(instance_nearest(x, y, chestprop)){
			motion_add(point_direction(other.x, other.y, x, y) + random_range(-30, 30), 1);
		}
	}
	if(distance_to_object(RadChest) < 8){
		with(instance_nearest(x, y, RadChest)){
			motion_add(point_direction(other.x, other.y, x, y) + random_range(-30, 30), 1);
		}
	}
	
	 // My sparkly little guy:
	if(random(40) < 1){
		instance_create(x + random_range(-24, 24), y + random_range(-24, 24), CaveSparkle)
	}
	
		// Hungry boy..
	if(instance_exists(Player)){
		var myMan = instance_nearest(x, y, Player)
		if(is_string(myMan.wep) && mod_script_exists("weapon", myMan.wep, "wep_exchange_pirate")) || weapon_can_exchange(myMan.wep){
			hungry = true;
		} else {
			hungry = false;
		}
	}
	
	 // Hello?:
	if(distance_to_object(Player) < 48){
		if(sprite_index = spr_idle){
			sprite_index = spr_strtpeek;
			image_index = 0;
		}
		playerNear = true;
	} else {
		playerNear = false;
	}
	
	 // Animate:
	if(anim_end){
		// Hi hello
		if (sprite_index = spr_strtpeek){
			sprite_index = spr_peek;
		}
		
		 // feed me that guns
		if(sprite_index = spr_strthungry){
			sprite_index = spr_hungry;
		}
		if(sprite_index = spr_peek && hungry = true){
			sprite_index = spr_strthungry;
		}
		if(sprite_index = spr_endhungry){
			sprite_index = spr_peek;
		}
		
		 // not hungry anymore!
		if(sprite_index = spr_hungry){
			if(playerNear = false) || (hungry = false){
				sprite_index = spr_endhungry;
			}
		}

			// Noone's here...
		if(playerNear = false){
			if(sprite_index = spr_peek){
				sprite_index = spr_endpeek;
			}
		}
		if(sprite_index = spr_endpeek) and (anim_end){
			sprite_index = spr_idle;
		}
	}
	
	 // Use Prop:
	if(pick != -1) && (canswap = true){
		
		// Target Nearest Player and Disable Prompt:
		targetplayer = instance_nearest(x, y, Player)
		playerwep	 = targetplayer.wep
		if(targetplayer.curse = 1){
			sound_play(sndCursedReminder);
			pick = -1;
			exit;
		}
		validwep	 = false;
		canswap		 = false;	
		
		
		// Valid Weapon:
		if(targetplayer.wep != wep_none) && weapon_can_exchange(playerwep) || (is_string(playerwep) && mod_script_exists("weapon", playerwep, "wep_exchange_pirate")){
			
			// Set Sprite and Eat Your Weapon:
			sprite_index	 = spr_swap;
			image_index 	 = 0;
			targetplayer.wep = wep_none;
			validwep		 = true;
			with(targetplayer){
				player_swap(self)
				swapmove  = true;
				drawempty = 30;
			}
			
			 // Check Modded Weapon for Funny Script:
			if(is_string(playerwep)){
				if(mod_script_exists("weapon", playerwep, "wep_exchange_pirate")){
					outputwep = mod_script_call("weapon", playerwep, "wep_exchange_pirate")	
				}
			}
			var _inputwep = ds_list_find_index(global.pirateInput, playerwep);
			if(_inputwep != -1){
				inputwep	= ds_list_find_value(global.pirateInput, _inputwep);
				outputwep	= ds_list_find_value(global.pirateOutput, _inputwep)
			}
			
			sound_play_pitchvol(sndGoldUnlock, 1.2, 2);
		
		}
		
		// No Valid Weapon: (DENIED!!)
		else { 
			sound_play_pitchvol(sndVanHurt, 1.2, 1);
			sound_play_pitchvol(sndExplosionS, 1.8, 0.6)
			repeat(3){ 
				with instance_create(x + random_range(-5, 5), y + 6, Sweat){ 
					direction = 270 + random_range(-10, 10);
					speed = random(2)
				} 
			}
			sprite_index = spr_deny
			validwep     = false;
			
			with(instance_create(other.x, other.y, PopupText)){ 
				mytext = "DON'T WANT THAT!" 
			}
		}

		// After Animation Ends:
		wait(image_number / image_speed)
		if(!instance_exists(self)){ exit; }
		
		// Spit Out Weapon:
		if(validwep = true){
			with instance_create(x, y, WepPickup){ 
				wep 		= other.outputwep; 
				ammo		= 1;
				direction	= 270; 
				speed		= 6; 
				repeat(15){ 
					with instance_create(x + random_range(-5, 5), y + 6, Sweat){ 
						direction = 270 + random_range(-30, 30);
						speed = random(2)
					} 
				}
			}
			
				// Increase Stats:
				
			 // override output wep for things like iris.
			var _outputwep	= outputwep;
			var _overwrite	= ds_list_find_index(global.pirateOverwriteInput, inputwep)
			if(_overwrite != -1){
				_outputwep = ds_list_find_value(global.pirateOverwriteOutput, _overwrite);
			}
			
			 // Unique Weapons Traded:
			var _conversionArray = call(scr.save_get, "Frontier", "pirate_conversions")
			if(array_find_index(_conversionArray, _outputwep) < 0){
				array_push(_conversionArray, _outputwep)
				
				 // Bubbles B-Skin Unlock:
				if(call(scr.save_get, "Frontier", "unlock_bubbles_bskin") = 0){
					if(array_length(_conversionArray) >= 10){
						call(scr.save_set, "Frontier", "unlock_bubbles_bskin", 1); 
						call(scr.unlock_splat_ext, "BUBBLES B-SKIN UNLOCKED", "BUBBLES B", mod_script_call("race", "bubbles", "race_skin_unlock", 1), mod_variable_get("race", "bubbles", "sprPortrait"), 1, sndCharUnlock);
					}
				}
				
				 // push to session-tempoary array in Frontier_Projectiles:
				var _projArray = mod_variable_get("mod",  "Frontier_Projectiles", "foundPirateWeps");
				array_push(_projArray, _outputwep);
				
				 // Push New Array
				call(scr.save_set, "Frontier", "pirate_conversions", _conversionArray)
				

			}
			
			 // Total Weapons Traded:
			call(scr.save_set, "Frontier", "pirate_trades", ((call(scr.save_get, "Frontier", "pirate_trades")) + 1))
		}
		// Back to Normal: 
		sprite_index = spr_idle;
		canswap = true;
		pick = -1;
		
		// New Prompt:
		with call(scr.prompt_create, text){ 
			on_step = WeaponExchangerPrompt_step; 
			creator = me; 
		}
		
	}

#define TreasureMimic_draw
	draw_sprite_ext(spr_shadow, 0, x, y + spr_shadow_y, 1, 1, 0, c_white, 0.4)
	draw_sprite_ext(sprite_index, image_index, x, y, image_xscale, image_yscale, image_angle, image_blend, image_alpha)

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
	
//#endregion
//#region PROPS
#define Dabloon_create(_x, _y)
	with instance_create(_x, _y, CustomObject){
		sprite_index	= global.sprDabloons;
		image_index		= irandom(image_number);
		image_speed		= 0;
		image_angle		= random(360);
		
		speed			= 1 + random(2);
		friction		= 0.2;
		direction		= random(360);
		lifetime		= 120;
		
		on_step			= Dabloon_step;
		
		return self;
	}

#define Dabloon_step
	if(lifetime > 0){
		lifetime -= current_time_scale;
	} else {
		image_alpha -= 0.07 * current_time_scale;
		if(image_alpha <= 0){
			instance_destroy();
		}
	}
	
#define CoveTorch_create(_x, _y)
	with instance_create(_x, _y, CustomProp){
		name			= "fr_CoveTorch"
		
		 // Visual:
		spr_idle		= global.sprCoveTorch;
		spr_hurt		= global.sprCoveTorchHurt;
		spr_dead		= global.sprCoveTorchDead;
		image_index		= irandom(3);
        fr_glow			= [48, 64];
		
		 // Sounds:
		snd_hurt		= sndHitRock;
		snd_dead		= sndHitMetal;
		
		 // Vars:
		maxhealth		= 4;
		my_health		= maxhealth;
		team			= 0;
		
		return self;
	}
	
#define GunpowderBarrel_create(_x, _y)
	with instance_create(_x, _y, CustomProp){
		name			= "fr_TreasureBarrel"
		
		 // Visual:
		spr_idle		= global.sprGunpowderBarrel;
		spr_hurt		= global.sprGunpowderBarrelHurt;
		spr_dead		= global.sprGunpowderBarrelDead;
		spr_shadow		= global.shdGunpowderBarrel;
		spr_shadow_y	= -2;
		
		 // Sounds:
		snd_hurt		= sndHitPlant;
		snd_dead		= global.sndGunpowderBarrelBreak;
		
		 // Vars:
		mask_index		= mskBandit;
		maxhealth		= 8;
		my_health		= maxhealth;
		team			= 0;

		on_death		= GunpowderBarrel_destroy;
		
		return self;
	}

#define GunpowderBarrel_destroy

	 // Sounds:
	sound_play_pitchvol(sndScorpionMelee, 1.2 + random(0.3), 0.6);
	sound_play_pitch(global.sndWoodBreak, 0.8 + random(0.3));
	sound_play_pitch(snd_dead, 0.8 + random(0.3));

	 // Gunpowder:
	repeat(random_range(3, 5)){
		with mod_script_call("mod", "Frontier_Projectiles", "GunpowderCreep_create", x + random_range(-24, 24), y + random_range(-24, 24)){
			image_xscale	= choose(0.4, 0.5);
			image_yscale	= image_xscale;
		}
	}
	 // Particles:
	repeat(10 + irandom(10)){
		with instance_create(x, y, Smoke){
			sprite_index	= sprBreath;
			direction		= random(360);
			speed			= random(3);
			image_blend 	= make_colour_rgb(74, 60, 78);
		}
	}
	repeat(4 + irandom(3)){
		with(instance_create(x, y, Debris)){
			sprite_index	= global.sprGunpowderBarrelDebris;
			direction		= random(360);
			speed			= 1 + random(2);
		}
	}

#define TreasureBarrel_create(_x, _y)
	with instance_create(_x, _y, CustomProp){
		name			= "fr_TreasureBarrel"
		
		 // Visual:
		spr_idle	= global.sprTreasureBarrel;
		spr_hurt	= global.sprTreasureBarrelHurt;
		spr_dead	= global.sprTreasureBarrelDead;
		
		var _variant = irandom(1);
		
		switch(_variant){
			case 0:
				spr_idle		= global.sprTreasureBarrel;
				spr_hurt		= global.sprTreasureBarrelHurt;
				spr_dead		= global.sprTreasureBarrelDead;
				spr_shadow		= global.shdGunpowderBarrel;
				spr_shadow_y	= -3;
			break;
			case 1:
				spr_idle		= global.sprTreasureBarrel2;	
				spr_hurt		= global.sprTreasureBarrel2Hurt;
				spr_dead		= global.sprTreasureBarrel2Dead;
				spr_shadow		= shd32;
				spr_shadow_y	= 1;
			break;
		}
		
		 // Sounds:
		snd_hurt		= sndHitPlant;
		snd_dead		= global.sndTreasureBarrelBreak;
		
		 // Vars:
		mask_index		= mskBandit;
		maxhealth		= 8;
		my_health		= maxhealth;
		team			= 0;
		
		on_step			= TreasureBarrel_step;
		on_death		= TreasureBarrel_destroy;
		
		 // Im fixing this crap:
		x = round(x)
		y = round(y)

		return self;
	}

#define TreasureBarrel_step
	if(random(40) < 1){
		with instance_create(x + random_range(-14, 14), y + random_range(-14, 14), CaveSparkle){
			depth	= other.depth - 1;
			if(random(6) < 1){
				sprite_index = global.sprGemSparkle;
			}
		}
	}
	
#define TreasureBarrel_destroy
	repeat(5 + irandom(10)){
		Dabloon_create(x, y)
	}
	sound_play_pitch(snd_dead, 0.8 + random(0.3));

#define GrogBottle_create(_x, _y)
	with instance_create(_x, _y, CustomProp){
		name			= "fr_GrogBottle"
		
		 // Visual:
		spr_idle		= global.sprGrogBottle1;
		spr_hurt		= global.sprGrogBottle1Hurt;
		spr_dead		= global.sprGrogBottle1Dead;
		
		var _variant = irandom(2);
		
		switch(_variant){
			case 0:
				spr_idle = global.sprGrogBottle1;
				spr_hurt = global.sprGrogBottle1Hurt;
				spr_dead = global.sprGrogBottle1Dead;
			break;
			case 1:
				spr_idle = global.sprGrogBottle2;	
				spr_hurt = global.sprGrogBottle2Hurt;
				spr_dead = global.sprGrogBottle2Dead;
			break;
			case 2:
				spr_idle = global.sprGrogBottle3;
				spr_hurt = global.sprGrogBottle3Hurt;
				spr_dead = global.sprGrogBottle3Dead;
			break;
		}
		
		 // Sounds:
		snd_hurt		= sndHitMetal;
		snd_dead		= sndIcicleBreak;
		
		 // Vars:
		mask_index		= mskBandit;
		maxhealth		= 2;
		my_health		= maxhealth;
		team			= 0;
		
		on_death		= GrogBottle_destroy;
		
		return self;
	}

#define GrogBottle_destroy
	repeat(3 + irandom(3)){
		with(instance_create(x, y, Debris)){
			sprite_index	= global.sprGrogBottleDebris;
			image_index		= irandom(image_number)
			direction		= random(360);
			speed			= 1 + random(2);
		}
	}
	sound_play_pitch(snd_dead, 0.8 + random(0.1))
	
//#endregion
#define AHOY_draw(_creator)
	draw_sprite_ext(global.sprAHOY, 0, view_xview_nonsync + game_width / 2, view_yview_nonsync + game_height / 2, 1, 1, 0, c_white, alphaPercent)
	
	timeToGo -= current_time_scale;
	if(timeToGo <= 0){
		alphaPercent -= 0.05 * current_time_scale;
	}
	if(alphaPercent <= 0){
		with(_creator){
			instance_delete(self);
		}
		instance_destroy();
	}
	
/* AHOY
                     .ed"""" """$$$$be.
                   -"           ^""**$$$e.
                 ."                   '$$$c
                /                      "4$$b
               d  3                      $$$$
               $  *                   .$$$$$$
              .$  ^c           $$$$$e$$$$$$$$.
              d$L  4.         4$$$$$$$$$$$$$$b
              $$$$b ^ceeeee.  4$$ECL.F*$$$$$$$
  e$""=.      $$$$P d$$$$F $ $$$$$$$$$- $$$$$$
 z$$b. ^c     3$$$F "$$$$b   $"$$$$$$$  $$$$*"      .=""$c
4$$$$L        $$P"  "$$b   .$ $$$$$...e$$        .=  e$$$.
^*$$$$$c  %..   *c    ..    $$ 3$$$$$$$$$$eF     zP  d$$$$$
  "**$$$ec   "   %ce""    $$$  $$$$$$$$$$*    .r" =$$$$P""
        "*$b.  "c  *$e.    *** d$$$$$"L$$    .d"  e$$***"
          ^*$$c ^$c $$$      4J$$$$$% $$$ .e*".eeP"
             "$$$$$$"'$=e....$*$$**$cz$$" "..d$*"
               "*$$$  *=%4.$ L L$ P3$$$F $$$P"
                  "$   "%*ebJLzb$e$$$$$b $P"
                    %..      4$$$$$$$$$$ "
                     $$$e   z$$$$$$$$$$%
                      "*$c  "$$$$$$$P"
                       ."""*$$$$$$$$bc
                    .-"    .$***$$$"""*e.
                 .-"    .e$"     "*$c  ^*b.
          .=*""""    .e$*"          "*bc  "*$e..
        .$"        .z*"               ^*$e.   "*****e.
        $$ee$c   .d"                     "*$.        3.
        ^*$E")$..$"                         *   .ee==d%
           $.d$$$*                           *  J$$$e*
            """""                              "$$$"
// *

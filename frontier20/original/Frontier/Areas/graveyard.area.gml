#define init

		// LIB:
	while(!mod_exists("mod", "lib")){wait(1);}
	script_ref_call(["mod", "lib", "getRef"], "area", mod_current, "scr");
	#macro  scr			global.scr
	#macro  call		script_ref_call

			// SOUNDS //
	global.musGraveyard 						= sound_add("../sounds/music/musGraveyard.ogg");
	global.musGraveyardB 						= sound_add("../sounds/music/musGraveyardB.ogg");
	
		// AREA SPRITES // 
	global.sprAreaIcon							= sprite_add("../sprites/menu/sprLabsRouteIcon.png",						1, 4, 4);
	global.sprFloor 							= sprite_add("../sprites/areas/graveyard/sprFloorGraveyard.png",			7, 0, 0);
	global.sprFloorB							= sprite_add("../sprites/areas/graveyard/sprFloorGraveyardB.png",			4, 16, 16);
	global.sprSnowFloorGraveyard				= sprite_add("../sprites/areas/graveyard/sprSnowFloorGraveyard.png",		8, 16, 16);
	global.sprFloorExplo						= sprite_add("../sprites/areas/graveyard/sprFloorGraveyardExplo.png",		4, 1, 5);
	global.sprWallBot							= sprite_add("../sprites/areas/graveyard/sprWallGraveyardBot.png",			4, 0, 0);
	global.sprWallTop							= sprite_add("../sprites/areas/graveyard/sprWallGraveyardTop.png",			1, 0, 0);
	global.sprWallOut							= sprite_add("../sprites/areas/graveyard/sprWallGraveyardOut.png",			2, 4, 12);
	global.sprWallTrans 						= sprite_add("../sprites/areas/graveyard/sprWallGraveyardTrans.png",		1, 0, 0);
	global.sprDebris		    				= sprite_add("../sprites/areas/graveyard/sprDebrisGraveyard.png",			4, 4, 4);
	global.sprDetail							= sprite_add("../sprites/areas/graveyard/sprDetailGraveyard.png",			3, 4, 4);
	global.sprDecal								= sprite_add("../sprites/areas/graveyard/sprGraveyardDecal.png",			2, 16, 24);
	global.sprTopDecal							= sprite_add("../sprites/areas/graveyard/sprTopDecalGraveyard.png", 		3, 16, 16);
	global.sprTopDecal2							= sprite_add("../sprites/areas/graveyard/sprTopDecalGraveyard2.png",		1, 16, 48);
	
	 // save prop sprites with variants as arrays to make switching variant real easy
	 
	 // Particles:
	global.sprSnowFlakeGraveyard 			= sprite_add("../sprites/areas/graveyard/sprSnowFlakeGraveyard.png",			3, 4, 4);
	global.sprVoltergeistLightning	=[		sprite_add("../sprites/particles/sprVoltergeistLightning.png",               	5, 16, 16),
											sprite_add("../sprites/particles/sprVoltergeistLightning2.png",               	5, 16, 16),
											sprite_add("../sprites/particles/sprVoltergeistLightning3.png",               	5, 16, 16),
											sprite_add("../sprites/particles/sprVoltergeistLightning4.png",               	5, 16, 16),
											sprite_add("../sprites/particles/sprVoltergeistLightning5.png",               	5, 16, 16)];
	global.sprVoltergeistDust				= sprite_add("../sprites/particles/sprVoltergeistDust.png",                     5, 12, 12);	
	global.sprVoltergeistRevive				= sprite_add("../sprites/particles/sprVoltergeistRevive.png",                   8, 24, 40);	

		// PROP SPRITES //
		
	 // Mortar Spawns
	global.mskMortarSpawn =[					sprite_add("../sprites/areas/graveyard/props/mskMortarSpawn.png", 			1, 24, 32),
												sprite_add("../sprites/areas/graveyard/props/mskMortarSpawn2.png", 			1, 16, 20)]																					
	global.sprMortarSpawn =[					sprite_add("../sprites/areas/graveyard/props/sprMortarSpawn.png",			1, 24, 32),
												sprite_add("../sprites/areas/graveyard/props/sprMortarSpawn2.png",			1, 16, 20)]
	global.sprMortarSpawnHurt =[				sprite_add("../sprites/areas/graveyard/props/sprMortarSpawnHurt.png",		3, 24, 32),
												sprite_add("../sprites/areas/graveyard/props/sprMortarSpawn2Hurt.png",		3, 16, 20)]
	global.sprMortarSpawnDead =[				sprite_add("../sprites/areas/graveyard/props/sprMortarSpawnDead.png",		3, 24, 32),
												sprite_add("../sprites/areas/graveyard/props/sprMortarSpawn2Dead.png",		3, 16, 20)]
	
	 // Charger Spawns
	global.mskChargerSpawn =[					sprite_add("../sprites/areas/graveyard/props/mskChargerSpawn.png", 			1, 24, 32),
												sprite_add("../sprites/areas/graveyard/props/mskChargerSpawn2.png", 		1, 16, 20)];	
	global.sprChargerSpawn =[					sprite_add("../sprites/areas/graveyard/props/sprChargerSpawn.png",			1, 24, 32),
												sprite_add("../sprites/areas/graveyard/props/sprChargerSpawn2.png",			1, 16, 20)];
	global.sprChargerSpawnHurt =[				sprite_add("../sprites/areas/graveyard/props/sprChargerSpawnHurt.png",		3, 24, 32),
												sprite_add("../sprites/areas/graveyard/props/sprChargerSpawn2Hurt.png",		3, 16, 20)];
	global.sprChargerSpawnDead =[				sprite_add("../sprites/areas/graveyard/props/sprChargerSpawnDead.png",		3, 24, 32),
												sprite_add("../sprites/areas/graveyard/props/sprChargerSpawn2Dead.png",		3, 16, 20)];
												
	global.mskOrbiterSpawn =[					sprite_add("../sprites/areas/graveyard/props/mskOrbiterSpawn.png", 			1, 16, 16),
												sprite_add("../sprites/areas/graveyard/props/mskOrbiterSpawn2.png", 		1, 16, 16)]
	global.sprOrbiterSpawn =[					sprite_add("../sprites/areas/graveyard/props/sprOrbiterSpawn.png",			1, 16, 16),
												sprite_add("../sprites/areas/graveyard/props/sprOrbiterSpawn2.png",			1, 16, 16)]
	global.sprOrbiterSpawnHurt =[				sprite_add("../sprites/areas/graveyard/props/sprOrbiterSpawnHurt.png",		3, 16, 16),
												sprite_add("../sprites/areas/graveyard/props/sprOrbiterSpawn2Hurt.png",		3, 16, 16)]
	global.sprOrbiterSpawnDead =[				sprite_add("../sprites/areas/graveyard/props/sprOrbiterSpawnDead.png",		3, 16, 16),
												sprite_add("../sprites/areas/graveyard/props/sprOrbiterSpawn2Dead.png",		3, 16, 16)]
												
	 // Big Piles:
	global.mskBigPile = [						sprite_add("../sprites/areas/graveyard/props/mskBigPileFreaks.png", 		1, 32, 24),
												sprite_add("../sprites/areas/graveyard/props/mskBigPileFrocity.png", 		1, 32, 24)];
	global.sprBigPile = [						sprite_add("../sprites/areas/graveyard/props/sprBigPileFreaks.png", 		1, 32, 24),
												sprite_add("../sprites/areas/graveyard/props/sprBigPileFrocity.png", 		1, 32, 24)];
	global.sprBigPileHurt = [					sprite_add("../sprites/areas/graveyard/props/sprBigPileFreaksHurt.png", 	3, 32, 24),
												sprite_add("../sprites/areas/graveyard/props/sprBigPileFrocityHurt.png", 	3, 32, 24)];
	global.sprBigPileDead = [					sprite_add("../sprites/areas/graveyard/props/sprBigPileFreaksDead.png", 	3, 32, 24),
												sprite_add("../sprites/areas/graveyard/props/sprBigPileFrocityDead.png", 	3, 32, 24)];
	
	global.mskBigPileBossScrap					= sprite_add("../sprites/areas/graveyard/props/mskBigPileBossScrap.png",	1, 32, 32);
	global.sprBigPileBossScrap					= sprite_add("../sprites/areas/graveyard/props/sprBigPileBossScrap.png",	1, 32, 32);
	global.sprBigPileBossScrapHurt				= sprite_add("../sprites/areas/graveyard/props/sprBigPileBossScrapHurt.png",3, 32, 32);
	global.sprBigPileBossScrapDead				= sprite_add("../sprites/areas/graveyard/props/sprBigPileBossScrapDead.png",3, 32, 32);
	
	 // Snow Poff:
	global.sprSnowPoff							= sprite_add("../sprites/areas/graveyard/props/sprSnowPoff.png",			1, 13, 9);
	global.sprSnowPoffHurt						= sprite_add("../sprites/areas/graveyard/props/sprSnowPoffHurt.png",		3, 13, 9);
	global.sprSnowPoffDead						= sprite_add("../sprites/areas/graveyard/props/sprSnowPoffDead.png",		3, 13, 9);
	
	 // Floor Vent:
//	global.sprFloorVent							= sprite_add("../sprites/areas/graveyard/props/sprFloorVent.png",			1, 16, 16);		 

	 // Furnace:
	global.sprFurnace							= sprite_add("../sprites/areas/graveyard/props/sprFurnace.png",				4, 16, 16);
	global.sprFurnaceHurt						= sprite_add("../sprites/areas/graveyard/props/sprFurnaceHurt.png",			3, 16, 16);
	global.sprFurnaceDead						= sprite_add("../sprites/areas/graveyard/props/sprFurnaceDead.png",			3, 16, 16);
	global.sprFurnace2							= sprite_add("../sprites/areas/graveyard/props/sprFurnace2.png",			8, 16, 16);
	global.sprFurnace2Hurt						= sprite_add("../sprites/areas/graveyard/props/sprFurnace2Hurt.png",		3, 16, 16);
	global.sprFurnace2Dead						= sprite_add("../sprites/areas/graveyard/props/sprFurnace2Dead.png",		3, 16, 16);
	
	 // volter:
	global.sprVolterPump						= sprite_add("../sprites/areas/graveyard/props/sprVolterPump.png",			7, 16, 32);
	global.sprVolterPumpHurt					= sprite_add("../sprites/areas/graveyard/props/sprVolterPumpHurt.png",		3, 16, 32);
	global.sprVolterPumpDead					= sprite_add("../sprites/areas/graveyard/props/sprVolterPumpDead.png",		3, 16, 32);
	
	 // Particles:
	global.sprJunkDebris = [					sprite_add("../sprites/particles/sprJunkDebris.png",                			4, 4, 4),
												sprite_add("../sprites/particles/sprJunkDebris2.png",               			4, 4, 4),
												sprite_add("../sprites/particles/sprJunkDebris3.png",               			4, 4, 4),
												sprite_add("../sprites/particles/sprJunkDebris4.png",               			4, 4, 4)]
	
		// COMPAT SPRITES //
	
	 // Varia Thundershock Pile:
	global.mskVariaThundershockPile				= sprite_add("../sprites/areas/graveyard/props/mskVariaThundershockPile.png", 1, 32, 53);
	global.sprVariaThundershockPile				= sprite_add("../sprites/areas/graveyard/props/sprVariaThundershockPile.png", 1, 32, 53);
	global.sprVariaThundershockPileHurt			= sprite_add("../sprites/areas/graveyard/props/sprVariaThundershockPileHurt.png", 3, 32, 53);
	global.sprVariaThundershockPileDead 		= sprite_add("../sprites/areas/graveyard/props/sprVariaThundershockPileDead.png", 3, 32, 53);
	
	/*
	// Generic Masks
	global.mskTrashPileCommonHuge	  = sprite_add("../sprites/areas/graveyard/props/mskTrashPileCommonHuge.png", 1, 44, 30);
	global.mskTrashPileMedium		  = sprite_add("../sprites/areas/graveyard/props/mskTrashPileMedium.png", 1, 25, 13);
	global.mskTrashPileSmall		  = sprite_add("../sprites/areas/graveyard/props/sprTrashPileCommon.png", 1, 24, 28);
	// CommonPile
	global.sprTrashPileCommon		  = sprite_add("../sprites/areas/graveyard/props/sprTrashPileCommon.png", 1, 22, 22);
	global.sprTrashPileCommon1		  = sprite_add("../sprites/areas/graveyard/props/sprTrashPileCommon1.png", 1, 24, 28);
	global.sprTrashPileCommon1Hurt	  = sprite_add("../sprites/areas/graveyard/props/sprTrashPileCommon1Hurt.png", 3, 24, 28);
	global.sprTrashPileCommon1Dead    = sprite_add("../sprites/areas/graveyard/props/sprTrashPileCommon1Dead.png", 3, 24, 28);
	global.sprTrashPileCommon2		  = sprite_add("../sprites/areas/graveyard/props/sprTrashPileCommon2.png", 1, 24, 28);
	global.sprTrashPileCommon2Hurt	  = sprite_add("../sprites/areas/graveyard/props/sprTrashPileCommon2Hurt.png", 3, 24, 28);
	global.sprTrashPileCommon2Dead    = sprite_add("../sprites/areas/graveyard/props/sprTrashPileCommon2Dead.png", 3, 24, 28);
	global.sprTrashPileCommon3		  = sprite_add("../sprites/areas/graveyard/props/sprTrashPileCommon3.png", 1, 24, 28);
	global.sprTrashPileCommon3Hurt	  = sprite_add("../sprites/areas/graveyard/props/sprTrashPileCommon3Hurt.png", 3, 24, 28);
	global.sprTrashPileCommon3Dead    = sprite_add("../sprites/areas/graveyard/props/sprTrashPileCommon3Dead.png", 3, 24, 28);
	// TechPile1
	global.sprTrashPileTech1		  = sprite_add("../sprites/areas/graveyard/props/sprTrashPileTech1.png", 1, 25, 13);
	global.sprTrashPileTech1Hurt	  = sprite_add("../sprites/areas/graveyard/props/sprTrashPileTech1Hurt.png", 3, 25, 13);
	global.sprTrashPileTech1Dead	  = sprite_add("../sprites/areas/graveyard/props/sprTrashPileTech1Dead.png", 3, 25, 13);
	// Carpile
	global.mskTrashPileCar  		  = sprite_add("../sprites/areas/graveyard/props/mskTrashPileCar.png", 1, 20, 15);
	global.sprTrashPileCar  		  = sprite_add("../sprites/areas/graveyard/props/sprTrashPileCar.png", 1, 20, 15);
	// BossesPlusPile
	global.mskTrashPileBossesPlus  	  = sprite_add("../sprites/areas/graveyard/props/mskTrashPileBossesPlus.png", 1, 29, 25);
	global.sprTrashPileBossesPlus  	  = sprite_add("../sprites/areas/graveyard/props/sprTrashPileBossesPlus.png", 1, 29, 25);
	global.sprTrashPileBossesPlusHurt = sprite_add("../sprites/areas/graveyard/props/sprTrashPileBossesPlusHurt.png", 3, 29, 25);
	global.sprTrashPileBossesPlusDead = sprite_add("../sprites/areas/graveyard/props/sprTrashPileBossesPlusDead.png", 3, 29, 25);
	// RadPile
	global.sprTrashPileRad   		  = sprite_add("../sprites/areas/graveyard/props/sprTrashPileRad.png", 1, 12, 12);
	// RemovedWepsPile
	global.sprTrashPileRemovedWeps	  = sprite_add("../sprites/areas/graveyard/props/sprTrashPileRemovedWeps.png", 1, 12, 12);
	// EggplantPile
	global.sprTrashPileEggplant	   	  = sprite_add("../sprites/areas/graveyard/props/sprTrashPileEggplant.png", 1, 12, 12);
	// CommonPileHuge 
	global.sprTrashPileCommonHuge	  = sprite_add("../sprites/areas/graveyard/props/sprTrashPileCommonHuge.png", 1, 44, 30);
	// HugeEggplantPile
	global.sprTrashPileHugeEggplant   = sprite_add("../sprites/areas/graveyard/props/sprTrashPileHugeEggplant.png", 1, 44, 30);

	// Mod Compat Piles
	// Varia KendoPile
	global.sprVariaKendoPile		  = sprite_add("../sprites/areas/graveyard/props/sprVariaPileKendo.png", 1, 19, 24);
	global.sprVariaKendoPileHurt	  = sprite_add("../sprites/areas/graveyard/props/sprVariaPileKendoHurt.png", 3, 19, 24);
	global.sprVariaKendoPileDead	  = sprite_add("../sprites/areas/graveyard/props/sprVariaPileKendoDead.png", 3, 19, 24);
	*/

		 // ARRAYS //
		global.fr_smoke_array					= []
		global.fr_smokestack_array				= []
		
		 // VARS //
		global.variaThundershockBroken			= false;
		global.settingLabsRouteAltMode			= false;
			
			
		#macro current_frame_active 			frac(current_frame) < current_time_scale
		#macro  FloorNormal						instances_matching(Floor, "object_index", Floor)

#define area_subarea        	return 3;
#define area_goal           	return 95;
#define area_next           	return (global.settingLabsRouteAltMode = true && !mod_exists("area", "scorpionboss")) ? [6, 1] : ["robocenter", 1];
#define area_background_color	return make_color_rgb(130, 130, 147);
#define area_shadow_color   	return c_black;
#define area_darkness       	return false;
#define area_secret         	return false;
#define area_outside			return true;

#define area_name
	return (global.settingLabsRouteAltMode = true ? `@1(${real(global.sprAreaIcon)}:0)5-`+string(GameCont.subarea) : `@1(${real(global.sprAreaIcon)}:0)1-`+string(GameCont.subarea));

#define area_text
	return choose(
		"RUBBISH",
		"WHAT A WASTE",
		"ROT", 
		"RECYCLING"
	);

#define area_mapdata(_lastX, _lastY, _lastArea, _lastSubarea, _subarea, _loops)
    return [
        72 + (9.5 * (_subarea - 1)), -9, (_subarea == 1)
    ]
    
#define area_areaicon
	return [
		global.sprAreaIcon,
		(global.settingLabsRouteAltMode = true ? "5-" + string(GameCont.subarea) : "1-" + string(GameCont.subarea))
	]
    
#define area_sprite(q)
	switch (q) {
    	case sprFloor1:   with([self, other]) if(instance_is(self, Floor)){ area_setup_floor(); break; } return global.sprFloor;
    	case sprFloor1B:  with([self, other]) if(instance_is(self, Floor)){ area_setup_floor(); break; } return global.sprFloorB;
    	case sprFloor1Explo: return global.sprFloorExplo;
    	case sprWall1Trans: return global.sprWallTrans;
    	case sprWall1Bot: return global.sprWallBot;
    	case sprWall1Out: return global.sprWallOut;
    	case sprWall1Top: return global.sprWallTop;
    	case sprDebris1: return global.sprDebris;
		case sprDetail1: return global.sprDetail;
	}

#define area_setup
	if(GameCont.subarea == 1){
		if(/*(random(20) < 1) ||*/ array_length(instances_matching_le(Player, "my_health", 1))){
			if(GameCont.vaults < 3){
				GameCont.proto = true;
			}
		}
	}
	var _music = (GameCont.proto = true) ? global.musGraveyardB : global.musGraveyard;
	if(!audio_is_playing(global.musGraveyard) && !audio_is_playing(global.musGraveyardB)){
		sound_play_music(_music)
	}
	
    sound_play_ambient(amb5);
    
	goal             = area_goal();
	background_color = area_background_color();
	BackCont.shadcol = area_shadow_color();
	TopCont.darkness = area_darkness();
    safespawn		 = 1;
    
     // Area Step:
    script_bind_step(area_step, 0)
   
     // Wall Breaking Sounds:
    sound_assign(sndWallBreakRock, sndWallBreakLabs);
    
#define area_setup_floor

	 // Fix BFloor Depth:
	if(styleb){ 
		depth -= 2; 
	}
	
	 // Sounds:
	material = (styleb ? 3 : 1);
	
    
#define area_start

	 // Decals:
	with (Wall){
		if place_meeting(x + 16, y, Floor) && place_meeting(x + 48, y, Wall) && (random(5) < 1) {
			with instance_create(x + 16,y + 2, Bones){
				sprite_index	= global.sprDecal;
				image_xscale	= 1;
				image_index		= random(image_number)
			}
			with instance_create(x + 48, y + 2, Bones){
				sprite_index	= global.sprDecal;
				image_xscale	= -1;
				image_index		= random(image_number)
			}
		}
	}

	 // Top Decals:
	with(Floor){ 
		if(random(7) < 1){
			with instance_create(x, y, TopDecalCity){
				sprite_index	= global.sprTopDecal;
				dir 			= choose(-1, 1)
			}
		}
	}
	
	// Smokestacks Top Decals: 
	with(Floor){ 
		if (random(13) < 1){
			with instance_create(x, y, TopPot){
				sprite_index	= global.sprTopDecal2;
				image_xscale	= choose(-1, 1)
				dir 			= choose(-1, 1)
				array_push(global.fr_smokestack_array,self)
			}
		}
	}

	 // SnowFloors
	with(instances_matching(Floor, "styleb", 1)){ 
		with(instance_create(x + irandom_range(-1, 1), y - irandom_range(2, 3), SnowFloor)){
			sprite_index	= global.sprSnowFloorGraveyard;
			image_speed		= other.image_speed;
			image_index		= other.image_index;
			image_angle	   += random_range(-1, 1)
			depth			= other.depth + 1;
		}
	}
	
	 // Spawn big piles:
	with(instances_matching(Floor, "fr_graveyardBigPileFloor", true)){
		if(!styleb){
			var _bigPile = call(scr.pool, [
				["BigPile_create",				1],
		        ["BigPileBossScrap_create",		0.1],
			])
			mod_script_call("area", mod_current, _bigPile, x + 16, y  + 16);
		}
	}
	 // Clear weird lingering props by big piles
	with(instances_matching(prop, "fr_allowDespawn", true)){
		var _nearestBigPile = call(scr.instance_nearest_array, x, y, instances_matching(Floor, "fr_graveyardBigPileFloor", true));
		if(instance_exists(_nearestBigPile)){
			if(distance_to_object(_nearestBigPile) < 48){
				instance_delete(self);
			}
		}
	}
	
	 // NO BANDITS! DIE!
	with(Bandit){
		instance_delete(self);
	}
	
	 // Gold Tanks are hardcoded to replace tanks in subarea 2 I guess, I dont really want them here so this will make them be regular tanks again.
	with(GoldSnowTank){
		instance_create(x, y, SnowTank);
		instance_delete(self);
	}
	
	 // Thundershock Spawn:
	with(instances_matching(Floor, "fr_floorThundershock", true)){
		VariaThundershockPile_create(x + 16, y + 16)
	}
	
	 // Boss Spawning - on 1-3:
	if(GameCont.subarea = 3){
		instance_create(10016, 10016, WantLH);
		HunterMusicPlayer_create(10016, 10016);
		
		// will maybe reenable at some point when boss is in a state im happy with.        NVM PROBABLY NOT LOL!!!!!!!
		//mod_script_call("mod", "Frontier_Bosses", "GraveyardBossSpawner_create", 10016, 10016);
	}
	
	if(global.settingLabsRouteAltMode = true){
		if(skill_get(mut_last_wish) > 0){
			with(call(scr.instance_random, Floor)){
				with(call(scr.floor_room, x, y, 0, FloorNormal, 1, 1, "", 0, 0)){
					instance_create(x, y, IceFlower);
				}
			}
		}
	}


#define area_make_floor

	var _x = x,
		_y = y,
		_outOfSpawn = (point_distance(_x, _y, 10000, 10000) > 48);
		
	 // Place Floor:
    with(instance_create(_x, _y, Floor)){
	     // 3x3 Rooms with Piles:
		if(random(25) < 1){
			fr_graveyardBigPileFloor = true;
			scrFloorFill(_x, _y, 3, 3);
		}
    }
    
    // 3x3 Rooms:
	if(random(14) < 1) {
	scrFloorFill(_x, _y, 3, 3);
	}
	
     // Change Direction:
    var _turn = 0;
    if(random(5) < 1){
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
    if(random(5) < 1){
    	instance_create(_x, _y, FloorMaker);
    }

     // Proto Statue:
	with(GenCont) if(instance_number(Floor) > goal) && (GameCont.subarea == 2 && GameCont.vaults < 3){
		with(instance_furthest(10000, 10000, Floor)){
			with(instance_nearest(
				(((x * 2) + 10000) / 3) + random_range(-64, 64),
				(((y * 2) + 10000) / 3) + random_range(-64, 64),
				Floor
			)){
				instance_create(x + 16, y + 16, ProtoStatue);
			}
		}
	}
	
	 // Varia Thundershock Pile:
	with(GenCont) if(instance_number(Floor) > goal) && (GameCont.subarea == 1) && (global.variaThundershockBroken = false) && (mod_exists("weapon", "va_thundershock")){
		with(instance_furthest(10000, 10000, Floor)){
			with(instance_nearest(
				((x + 10000) / 2) + random_range(-64, 64),
				((y + 10000) / 2) + random_range(-64, 64),
				Floor
			)){
				scrFloorFill(x, y, 3, 3)
				fr_floorThundershock		= true;
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

#define area_pop_enemies
	var _x = (bbox_left + bbox_right) / 2,
		_y = (bbox_top  + bbox_bottom) / 2;
		
	var _enemy = call(scr.pool, [
        [["Cremator_create",		"MOD", "Frontier_Labs"],    	1.5],
        [["VesselMortar_spawn",		"MOD", "Frontier_Labs"],    	1],
        [["VesselOrbiter_spawn",	"MOD", "Frontier_Labs"],    	1.2],
        [["VesselCharger_spawn",	"MOD", "Frontier_Labs"],    	1],
        [["Voltergeist_create",		"MOD", "Frontier_Labs"],    	0.5],
        [[SnowTank,					"Basegame", ""],    			0.8 * (GameCont.loops > 0)],
        [[Guardian,					"Basegame", ""],    			0.8 * (GameCont.loops > 0)],
        [["GraveyardAssassin_create","MOD", "Frontier_Labs"],    	0.7 * (GameCont.loops > 0)],
	])
	
	if(random(2.5) < 1){
		switch(_enemy[1]){
			case "Basegame": {
				instance_create(_x, _y, _enemy[0]);
			}
			break;
			case "MOD": {
				mod_script_call("mod", _enemy[2], _enemy[0], _x, _y)
			}
			break;
			case "OBJ": {
				mod_script_call("mod", _enemy[2], "obj_create", _x, _y, _enemy[0])
			}
			break;
		}	
	}

#define area_pop_props
	var _x = (bbox_left + bbox_right) / 2,
		_y = (bbox_top  + bbox_bottom) / 2,
		_outOfSpawn = (point_distance(x, y, 10000, 10000) > 48);

	 // Props:
	if(_outOfSpawn){
		var _nearestBigPile = call(scr.instance_nearest_array, x, y, instances_matching(Floor, "fr_graveyardBigPileFloor", true));
		if(instance_exists(_nearestBigPile)){
			if(distance_to_object(_nearestBigPile) < 32){
				exit;
			}
		}
		if(random(2) < 1) && !(place_meeting(_x, _y, prop)){
			if(styleb){
				if(random(5) < 1){
					var _bFloorProp = call(scr.pool, [
				        ["Furnace_create",    	1],
				        ["Furnace2_create",    	1],
				        ["VolterPump_create",   0.3],
					]);
					mod_script_call("area", mod_current, _bFloorProp, _x, _y);
				}
			}
			else{
				var _prop = call(scr.pool, [	
			        ["MortarSpawn_create",    	0.5],
			        ["OrbiterSpawn_create",    	0.5],
			        ["ChargerSpawn_create",		0.5],
			        ["SnowPoff_create",    		0.2],
				]);
				mod_script_call("area", mod_current, _prop, _x, _y);
			}
		}
	}
	
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
    // Restore Wall Sounds:
    sound_restore(sndWallBreakRock);
    
    if(GameCont.fr_jungleToGraveyard = true){
    	if(GameCont.area != 5){
    		GameCont.fr_jungleToGraveyard = false;
    	}
    }
    
    if(global.settingLabsRouteAltMode = true){
    	if(GameCont.area = 105){
    		if(GameCont.lastarea = mod_current){
    			GameCont.fr_jungleToGraveyard = true;
    		}
    	}
    }
    
#define area_step

	var _smokeDirection = 120 + sin(current_frame * 0.06) * 20;
	
		// Smokestack Array - Create Smoke:
    if array_length(global.fr_smokestack_array){
        global.smokestack_array = instances_matching_ne(global.fr_smokestack_array, "id") 
        with(global.fr_smokestack_array){
			if instance_exists(self) && (random(2) < 1) && current_frame_active { 
				with instance_create(x, y - 30, Dust){ 
        			array_push(global.fr_smoke_array, self)
					sprite_index	= sprSmoke;
					direction		= _smokeDirection + random_range(-20, 20); 
					speed			= 1.5; 
					depth			= -7; 
					growspeed		= 0.14;
					friction		= -0.2;
				}
			} 
        }
    }
    
		// Smoke Array - Decrease Alpha:
    if array_length(global.fr_smoke_array){
        global.fr_smoke_array = instances_matching_ne(global.fr_smoke_array, "id") 
        with (global.fr_smoke_array){
        	if instance_exists(self) && (current_frame_active){
            	image_alpha -= 0.03;
        	}
        }
    }
    
	if(current_frame_active){     
		 // Snowflakes:
		if (random(3) < 1){
			with instance_create(view_xview + random(game_width * 2) - game_width / 2, view_yview + random(game_height * 2) - game_height / 2, SnowFlake){ 
				sprite_index = global.sprSnowFlakeGraveyard; 
			}		
		}
		
		 // Icy Breath:
		with(instances_matching(Player, "race_gets_chilly", true)){
			if(race != "robot" && race != "plant"){
				if(random(50) < 1){
					with(instance_create(x, y, Breath)){
						image_xscale	= other.right
					}
				}
			}
		}
	}

//#region PROPS
//#region POSSESSABLES

#define PossessablePropExample_create(_x, _y)
	with(instance_create(_x, _y, CustomProp)){
		
		name = "fr_PossessablePropExample";
		
		 // Visual:
		spr_idle		= sprHydrant;
		spr_hurt		= sprHydrantHurt;
		spr_dead		= sprHydrantDead;
		spr_debris		= sprDebris6;
		sprite_index	= spr_idle;
		
		 // Sounds:
		snd_hurt		= sndHitMetal;
		snd_dead		= sndHydrantBreak;
		
		 // Vars:
		fr_possessable	= true;
		fr_possessed	= false;
		maxhealth		= 10;
		my_health		= maxhealth;
		size			= 3;
		debrisRange		= 3;
		fr_possessor	= noone;
		
		on_possessed	= script_ref_create(PossessablePropExample_possessed);
	
		return self;
	}
	
#define PossessablePropExample_possessed
	with(fr_possessor){
		possess_target = instance_create(other.x, other.y, Bandit);
	}
	instance_destroy();
	
#define MortarSpawn_create(_x, _y)
	with(instance_create(_x, _y, CustomProp)){
		
		name = "fr_MortarSpawn";
		
		 // Visual:
		var _variant	= irandom(1)
		spr_idle		= global.sprMortarSpawn[_variant];
		spr_hurt		= global.sprMortarSpawnHurt[_variant];
		spr_dead		= global.sprMortarSpawnDead[_variant];
		spr_debris		= sprDebris6;
		sprite_index	= spr_idle;
		spr_shadow		= mskNone;
		
		 // Sounds:
		snd_hurt		= sndHitMetal;
		snd_dead		= sndHydrantBreak;
		
		 // Vars:
		mask_index		= global.mskMortarSpawn[_variant];
		fr_possessable	= true;
		fr_possessed	= false;
		maxhealth		= 35;
		my_health		= maxhealth;
		size			= 3;
		debrisRange		= 3;
		fr_possessor	= noone;
		fr_allowDespawn = true;
		
		on_possessed	= script_ref_create(MortarSpawn_possessed);
		
		 // Fix Wiggle:
		x = round(x);
		y = round(y);
	
		return self;
	}
	
#define MortarSpawn_possessed
	with(fr_possessor){
		possess_target = MortarSpawnVessel_create(other.x, other.y)
	}
	
	sound_play_pitchvol(sndSwapCursed, 0.6 + random(0.1), 1)
		
	 // FX:
	with(instance_create(x, y, ReviveFX)){
		sprite_index	= global.sprVoltergeistRevive;
		depth			= -3;
	}
	repeat(6){
		with(instance_create(x, y, BulletHit)){
			var _variant	= irandom(4);	 
			sprite_index	= global.sprVoltergeistLightning[_variant];
			depth			= -3;
			direction		= random(360);
			speed			= 2 + random(2);
		}
	}
	repeat(12){
		with(instance_create(x + random_range(-10, 10), y + random_range(-10, 10), Dust)){
			sprite_index	= global.sprVoltergeistDust;
			depth			= -3;
			direction		= random(360);
			speed			= 3 + random(2);
		}
	}
	instance_create(x, y, PortalClear);
	instance_destroy();

#define MortarSpawnVessel_create(_x, _y)
	with(mod_script_call("mod", "Frontier_Labs", "VesselMortar_create", _x, _y, true)){
		loading 		= false;
		loaded			= true;
		spr_idle		= spr_idle_loaded;
		spr_walk		= spr_walk_loaded;
		spr_hurt		= spr_hurt_loaded;
		spr_dead		= spr_dead_loaded;
		alarm1			= 20 + irandom(10);
		
		return self;
	}

#define OrbiterSpawn_create(_x, _y)
	with(instance_create(_x, _y, CustomProp)){
		
		name = "fr_OrbiterSpawn";
		
		 // Visual:
		var _variant	= irandom(1)
		spr_idle		= global.sprOrbiterSpawn[_variant];
		spr_hurt		= global.sprOrbiterSpawnHurt[_variant];
		spr_dead		= global.sprOrbiterSpawnDead[_variant];
		sprite_index	= spr_idle;
		
		 // Sounds:
		snd_hurt		= sndHitMetal;
		snd_dead		= sndHydrantBreak;
		
		 // Vars:
		mask_index		= global.mskOrbiterSpawn[_variant];
		fr_possessable	= true;
		fr_possessed	= false;
		maxhealth		= 20;
		my_health		= maxhealth;
		size			= 3;
		debrisRange		= 3;
		fr_possessor	= noone;
		fr_allowDespawn = true;
		
		on_possessed	= script_ref_create(OrbiterSpawn_possessed);
		
		 // Fix Wiggle:
		x = round(x);
		y = round(y);
	
		return self;
	}
	
#define OrbiterSpawn_possessed
	with(instance_create(x, y, PortalClear)){
		image_xscale	= 0.5;
		image_yscale	= image_xscale;
	}
	with(fr_possessor){
		possess_target = mod_script_call("mod", "Frontier_Labs", "VesselOrbiter_create", other.x, other.y)
	}
	
	sound_play_pitchvol(sndSwapCursed, 0.6 + random(0.1), 1)
		
	 // FX:
	with(instance_create(x, y, ReviveFX)){
		sprite_index	= global.sprVoltergeistRevive;
		depth			= -3;
	}
	repeat(6){
		with(instance_create(x, y, BulletHit)){
			var _variant	= irandom(4);	 
			sprite_index	= global.sprVoltergeistLightning[_variant];
			depth			= -3;
			direction		= random(360);
			speed			= 2 + random(2);
		}
	}
	repeat(12){
		with(instance_create(x, y, Dust)){
			sprite_index	= global.sprVoltergeistDust;
			depth			= -3;
			direction		= random(360);
			speed			= 2 + random(2);
		}
	}
	instance_destroy();

#define ChargerSpawn_create(_x, _y)
	with(instance_create(_x, _y, CustomProp)){
		
		name = "fr_ChargerSpawn";
		
		 // Visual:
		var _variant	= irandom(1)
		spr_idle		= global.sprChargerSpawn[_variant];
		spr_hurt		= global.sprChargerSpawnHurt[_variant];
		spr_dead		= global.sprChargerSpawnDead[_variant];
		spr_debris		= sprDebris6;
		sprite_index	= spr_idle;
		
		 // Sounds:
		snd_hurt		= sndHitMetal;
		snd_dead		= sndHydrantBreak;
		
		 // Vars:
		mask_index		= global.mskChargerSpawn[_variant];
		fr_possessable	= true;
		fr_possessed	= false;
		maxhealth		= 20;
		my_health		= maxhealth;
		size			= 3;
		debrisRange		= 3;
		fr_possessor	= noone;
		fr_allowDespawn = true;
		
		on_possessed	= script_ref_create(ChargerSpawn_possessed);
		
		 // Fix Wiggle:
		x = round(x);
		y = round(y);
	
		return self;
	}
	
#define ChargerSpawn_possessed
	with(instance_create(x, y, PortalClear)){
		image_xscale	= 0.5;
		image_yscale	= image_xscale;
	}
	with(fr_possessor){
		possess_target = mod_script_call("mod", "Frontier_Labs", "VesselCharger_create", other.x, other.y)
	}
	
	sound_play_pitchvol(sndSwapCursed, 0.6 + random(0.1), 1)
		
	 // FX:
	with(instance_create(x, y, ReviveFX)){
		sprite_index	= global.sprVoltergeistRevive;
		depth			= -3;
	}
	repeat(6){
		with(instance_create(x, y, BulletHit)){
			var _variant	= irandom(4);	 
			sprite_index	= global.sprVoltergeistLightning[_variant];
			depth			= -3;
			direction		= random(360);
			speed			= 2 + random(2);
		}
	}
	repeat(12){
		with(instance_create(x, y, Dust)){
			sprite_index	= global.sprVoltergeistDust;
			depth			= -3;
			direction		= random(360);
			speed			= 2 + random(2);
		}
	}
	instance_destroy();
	
//#endregion
#define SnowPoff_create(_x, _y)
	with(instance_create(_x, _y, CustomProp)){
		
		name = "fr_SnowPoff";
		
		 // Visual:
		spr_idle		= global.sprSnowPoff;
		spr_hurt		= global.sprSnowPoffHurt;
		spr_dead		= global.sprSnowPoffDead;
		spr_shadow		= -1;
		sprite_index	= spr_idle;
		
		 // Sounds:
		snd_hurt		= sndHitPlant;
		snd_dead		= sndMoneyPileBreak;
		
		 // Vars:
		maxhealth		= 2;
		my_health		= maxhealth;
		size			= 3;
		fr_allowDespawn = true;
		
		on_death		= SnowPoff_destroy;
		
		return self;
	}
	
#define SnowPoff_destroy
     // this... what is this?
	if(random(8) < 1){
		repeat(4){
			instance_create(x + random_range(-12, 12), y + random_range(-12, 12), Rad)
		}
	}

#define BigPile_create(_x, _y)

	with(instance_create(_x, _y, CustomProp)){
		
		name = "fr_BigPile";
		
		 // Visual:
		var _variant	= irandom(1)
		spr_idle		= global.sprBigPile[_variant];
		spr_hurt		= global.sprBigPileHurt[_variant];
		spr_dead		= global.sprBigPileDead[_variant];
		spr_debris		= sprDebris6;
		sprite_index	= spr_idle;
		
		 // Sounds:
		snd_hurt		= sndHitMetal;
		snd_dead		= sndHydrantBreak;
		
		 // Vars:
		mask_index		= global.mskBigPile[_variant];
		variant 		= _variant;
		maxhealth		= 80;
		my_health		= maxhealth;
		size			= 3;
		
		on_hit			= PileProp_hurt;
		
		 // Fix Wiggle:
		x = round(x);
		y = round(y);
	
		return self;
	}

#define BigPileBossScrap_create(_x, _y)
	with(instance_create(_x, _y, CustomProp)){
		
		name = "fr_BossScrap";
		
		 // Visual:
		spr_idle		= global.sprBigPileBossScrap;
		spr_hurt		= global.sprBigPileBossScrapHurt;
		spr_dead		= global.sprBigPileBossScrapDead;
		spr_shadow		= -1;
		sprite_index	= spr_idle;
		
		 // Sounds:
		snd_hurt		= sndHitMetal;
		snd_dead		= sndHydrantBreak;
		
		 // Vars:
		mask_index		= global.mskBigPileBossScrap
		maxhealth		= 80;
		my_health		= maxhealth;
		size			= 3;
		
		return self;
	}
	
#define FloorVent_create(_x, _y)
	with(instance_create(_x, _y, CustomProp)){
		
		name = "fr_FloorVent";
		
		 // Visual:
		spr_idle		= global.sprFloorVent;
		spr_hurt		= global.sprSnowPoffHurt;
		spr_dead		= global.sprSnowPoffDead;
		spr_shadow		= -1;
		sprite_index	= spr_idle;
		
		 // Sounds:
		snd_hurt		= sndHitMetal;
		snd_dead		= sndHydrantBreak;
		
		 // Vars:
		maxhealth		= 30;
		my_health		= maxhealth;
		size			= 3;
		fr_allowDespawn = true;
		
		on_step			= FloorVent_step;
		
		return self;
	}

#define FloorVent_step
	var _smokeDirection = 120 + sin(current_frame * 0.06) * 20;
	if(random(5) < 1){
		with(instance_create(x, y - 8, Dust)){ 
			array_push(global.fr_smoke_array, self)
			sprite_index	= sprSmoke;
			direction		= _smokeDirection + random_range(-20, 20); 
			speed			= 1.5; 
			depth			= -7; 
			growspeed		= 0.14;
			friction		= -0.2;
		}
	}
	
#define Furnace_create(_x, _y)
	with(instance_create(_x, _y, CustomProp)){
		
		name = "fr_Furnace";
		
		 // Visual:
		spr_idle		= global.sprFurnace;
		spr_hurt		= global.sprFurnaceHurt;
		spr_dead		= global.sprFurnaceDead;
		spr_shadow		= -1;
		sprite_index	= spr_idle;
		
		 // Sounds:
		snd_hurt		= sndHitMetal;
		snd_dead		= sndHydrantBreak;
		
		 // Vars:
		maxhealth		= 20;
		my_health		= maxhealth;
		size			= 3;
		fr_allowDespawn = true;
		
		on_step			= Furnace_step;
		
		return self;
	}
	
#define Furnace_step
	var _smokeDirection = 120 + sin(current_frame * 0.06) * 20;
	if(random(15) < 1){
		with(instance_create(x + (7 * image_xscale), y - 8, Dust)){ 
			array_push(global.fr_smoke_array, self)
			sprite_index	= sprSmoke;
			direction		= _smokeDirection + random_range(-20, 20); 
			speed			= 1.5; 
			depth			= -7; 
			growspeed		= 0.14;
			friction		= -0.2;
		}
	}
	
#define Furnace2_create(_x, _y)
	with(instance_create(_x, _y, CustomProp)){
		
		name = "fr_Furnace2";
		
		 // Visual:
		spr_idle		= global.sprFurnace2;
		spr_hurt		= global.sprFurnace2Hurt;
		spr_dead		= global.sprFurnace2Dead;
		spr_shadow		= -1;
		sprite_index	= spr_idle;
		
		 // Sounds:
		snd_hurt		= sndHitMetal;
		snd_dead		= sndHydrantBreak;
		
		 // Vars:
		maxhealth		= 20;
		my_health		= maxhealth;
		size			= 3;
		fr_allowDespawn = true;
		
		on_step			= Furnace2_step;
		
		return self;
	}
	
#define Furnace2_step
	var _smokeDirection = 120 + sin(current_frame * 0.06) * 20;
	if(random(15) < 1){
		with(instance_create(x - (6 * image_xscale), y - 8, Dust)){ 
			array_push(global.fr_smoke_array, self)
			sprite_index	= sprSmoke;
			direction		= _smokeDirection + random_range(-20, 20); 
			speed			= 1.5; 
			depth			= -7; 
			growspeed		= 0.14;
			friction		= -0.2;
		}
	}
	
#define VariaThundershockPile_create(_x, _y)
	with(instance_create(_x, _y, CustomProp)){
		
		name = "fr_VariaThundershockPile";
		
		 // Visual:
		spr_idle		= global.sprVariaThundershockPile;
		spr_hurt		= global.sprVariaThundershockPileHurt;
		spr_dead		= global.sprVariaThundershockPileDead;
		spr_shadow		= -1;
		sprite_index	= spr_idle;
		depth			= -1;
		
		 // Sounds:
		snd_hurt		= sndHitMetal;
		snd_dead		= sndServerBreak;
		
		 // Vars:
		mask_index		= global.mskVariaThundershockPile;
		maxhealth		= 50;
		my_health		= maxhealth;
		size			= 3;
		myWeapon		= "va_thundershock"
		
		on_death		= VariaThundershockPile_destroy;
		
		return self;
	}

#define VariaThundershockPile_destroy
	global.VariaThundershockBroken = true;
	with instance_create(x, y, WepPickup){
		wep 		= other.myWeapon;
		curse		= 1;
	}	
	
#define VolterPump_create(_x, _y)
	with(instance_create(_x, _y, CustomProp)){
		
		name = "fr_VolterPump";
		
		 // Visual:
		spr_idle		= global.sprVolterPump;
		spr_hurt		= global.sprVolterPumpHurt;
		spr_dead		= global.sprVolterPumpDead;
		spr_shadow		= -1;
		sprite_index	= spr_idle;
		depth			= -1;
		fr_glow 		= [32, 64];
		
		 // Sounds:
		snd_hurt		= sndHitMetal;
		snd_dead		= sndHydrantBreak;
		
		 // Vars:
		mask_index		= mskBandit;
		maxhealth		= 20;
		my_health		= maxhealth;
		size			= 2;
		fr_allowDespawn = true;
		
		on_step			= VolterPump_step;
		on_death		= VolterPump_destroy;
		
		return self;
	}
	
#define VolterPump_step
	var _smokeDirection = 120 + sin(current_frame * 0.06) * 20;
	if(random(30) < 1){
		with(instance_create(x, y - 16, Dust)){ 
			array_push(global.fr_smoke_array, self)
			sprite_index	= global.sprVoltergeistDust;
			image_alpha		= 1;
			direction		= _smokeDirection + random_range(-20, 20); 
			speed			= 1.5; 
			depth			= -7; 
			growspeed		= 0.04;
			friction		= -0.2;
		}
	}
	if(random(25) < 1){
		with(instance_create(x + random_range(-8, 8), y + random_range(-12, 6), BulletHit)){
			var _variant	= irandom(4);	 
			sprite_index	= global.sprVoltergeistLightning[_variant];
			depth			= -3;
			direction		= random(360);
		}
	}
	
#define VolterPump_destroy
	repeat(1 + irandom(1)){
		with(mod_script_call("mod", "Frontier_Labs", "Voltergeist_create", x, y)){
			direction	= random(360);
			speed		= 3 + random(2);
			alarm1		= 10 + irandom(5);
			armorLock	= 5;
		}
	}
	
#define HunterMusicPlayer_create(_x, _y)
	with(instance_create(_x, _y, CustomObject)){
		
		name = "fr_graveyardHunterMusic";
		
		on_step			= HunterMusicPlayer_step;
		
		return self;
	}
	
#define HunterMusicPlayer_step
	if(array_length(instances_matching(LilHunter, "intro", true)) > 0){
		if(!audio_is_playing(musBoss3)){
			sound_play_music(musBoss3)
		}
		instance_destroy();
	}
	
 // Some Generic Stuff:
#define PileProp_hurt(_dmg, _spd, _dir)
	my_health -= _dmg;
	nexthurt   = current_frame + 6;
	
	sound_play_hit(snd_hurt, 0.3);
	
	sprite_index = spr_hurt;
	image_index  = 0;
	
	repeat(irandom(debrisRange)){
		with(instance_create(x, y, Debris)){
			sprite_index	= spr_debris;
			image_index		= irandom(image_number);
			direction		= random(360);
			speed			= 1 + random(3);
		}
	}
	
#define PileWeaponDrop_destroy
	 // Drop my Cool Weapon:
	with instance_create(x, y, WepPickup){
		wep = other.myWeapon;
		if (weapon_get_type(wep) != 0){
			ammo = 1;
		} 
	}
	
//#endregion
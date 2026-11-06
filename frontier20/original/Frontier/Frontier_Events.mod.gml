#define init

/*
		Thunderstorm lightning strikes are stolen from defpack ty burg I dont know how to use vertexs
*/	

	 // LIB:
	while(!mod_exists("mod", "lib")){wait(1);}
	script_ref_call(["mod", "lib", "getRef"], "mod", mod_current, "scr");
	#macro  scr			global.scr
	#macro  call		script_ref_call
	
	 // EVENTS: //
//	call(scr.event_add, "LabsOutpost",		mod_current);
	call(scr.event_add, "PortalStorm",		mod_current);
//	call(scr.event_add, "FleshPlague",		mod_current);
	call(scr.event_add, "MeteorShower", 	mod_current);
//	call(scr.event_add, "Sandstorm", 		mod_current);	maybe later
//	call(scr.event_add, "SolarShower", 		mod_current);
	call(scr.event_add, "Casino",			mod_current);
	call(scr.event_add, "PaintorCamp",		mod_current);
//	call(scr.event_add, "SlimyPipes",		mod_current);
	call(scr.event_add, "Thunderstorm", 	mod_current);
	call(scr.event_add, "ScrapyardsNight",	mod_current);
	call(scr.event_add, "Blizzard", 		mod_current);
	call(scr.event_add, "Aurora",			mod_current);
	call(scr.event_add, "Blackout", 		mod_current);	
	call(scr.event_add, "BoilingWater", 	mod_current);	
	call(scr.event_add, "SerpentLair", 		mod_current);
	call(scr.event_add, "DebugEvent1", 		mod_current);
	call(scr.event_add, "CoastNight",		mod_current);
	call(scr.event_add, "HoarderSpawn",		mod_current);
	call(scr.event_add, "CurseSpread",		mod_current);
	call(scr.event_add, "HauntedCity",		mod_current);
	
	 // EVENT CHANCES //
	 // make sure these are the same in Frontier_Options.
	global.settingNightEventSpawnChance			= 0.2;
	global.settingPaintorCampEventSpawnChance	= 0.03;
	global.settingThunderstormEventSpawnChance	= 0.1;
	global.settingCurseSpreadEventSpawnChance	= 0.08;
	global.settingBlizzardEventSpawnChance		= 0.1;
	global.settingHauntedCityEventSpawnChance	= 0.06;
	global.settingBlackoutEventSpawnChance		= 0.2;
	global.settingSerpentLairEventSpawnChance	= 0.13;
	global.settingPortalStormEventSpawnChance	= 0.02;
	
	 // VARS //
	global.eventMusicPlaying		= false;	// whether or not Event music is currently playing, for compat use. // was only used for an unuploaded version of radioactive idk if anyone needs this
	global.eventAmbiencePlaying		= false;	// whether or not Event ambience is currently playing, for compat use.
	global.nightCredits				= 0;		// used for tracking if a night event should occur, keep at 0 here.
	global.casinoMusic				= -4;		// var for Casino.
	global.sewerMusic				= -4;		// var for Casino.
	global.blizzardSnowPos			= 0;		// Offset for blizzard snow tiling.
	global.isNight					= false; 	// whether or not its nighttime.
	global.pickupMeteorFalls		= 0;		// some var for meteor shower idk
	global.maxPickupMeteors			= 0;		// another meteor shower var
	global.nightLoop				= false;	// if current loop is a nightloop
	
     // SETTINGS //
    global.settingEventText			= false;	// Loading Screen Text for events. (default: false).
    global.settingEventDropdowns	= true;		// Dropdown cards for events. (default: true).
    global.settingLightningFlash	= true;     // Flash Effect when Lightning Strikes. (default: true).
    global.settingMaxAuroras		= 3;		// how many auroras are allowed. (default: 3).
	global.settingVeeOneHundred		= (game_version > 0);	// toggles v100-only features. (default: off).
	global.settingNightLoops		= false;	// if night events are based on loop instead of per-area. (default: off).
    
     // SOUNDS //
	global.musDesertNight 						= sound_add("sounds/music/musDesertNight.ogg");
	global.musCasino 							= sound_add("sounds/music/musCasino.ogg");
   	global.musThunderstorm 						= sound_add("sounds/music/musThunderstorm.ogg"); 
	global.musScrapyardsNight 					= sound_add("sounds/music/musScrapyardsNight.ogg");
	global.musFrozenCityNight 					= sound_add("sounds/music/musFrozenCityNight.ogg");
	global.ambBlizzard		 					= sound_add("sounds/ambience/ambBlizzard.ogg");
	
	global.sndEventIntroNight					= sound_add("sounds/events/sndEventIntroNight.ogg");
	global.sndEventIntroWeather					= sound_add("sounds/events/sndEventIntroWeather.ogg");
	global.sndEventIntroSerpent					= sound_add("sounds/events/sndEventIntroSerpent.ogg");
	global.sndImpostorAlert						= sound_add("sounds/events/sndImpostorAlert.ogg");
	global.sndBlank								= sound_add("sounds/sndBlank.ogg");	
	global.sndBlank2							= sound_add("sounds/sndBlank.ogg");	
	
	 // SPRITES //
	global.sprEventDropdowns      				= sprite_add("sprites/menu/sprEventDropdowns.png",							10, 64, 40);
	global.sprEventDropdownsBack      			= sprite_add("sprites/menu/sprEventDropdownsBack.png",						3, 64, 40);
	
	global.sprGenericTrail      				= sprite_add("sprites/particles/sprGenericTrail.png",						50, 0, 50);
	global.sprCasinoFloor						= sprite_add("sprites/areas/sewers/sprCasinoFloor.png", 					1, 83, 51);
    global.sprVignette							= sprite_add("sprites/particles/sprVignette.png",							1, 250, 250);
    global.sprVignetteOuter						= sprite_add("sprites/particles/sprVignetteOuter.png",						1, 960, 540);    
    global.sprVignetteOuterBlackout				= sprite_add("sprites/particles/sprVignetteOuterBlackout.png",				1, 960, 540);   
	global.sprSolidColorFog        				= sprite_add("sprites/particles/sprSolidColorFog.png",						1, 12, 12);
	global.sprPalaceTrapScorchMark        		= sprite_add("sprites/areas/palace/sprPalaceTrapScorchMark.png",			1, 32, 32);
    
	 // Meteor Shower:
	global.sprFloor1BNight						= sprite_add("sprites/areas/desert/night/sprFloor1BNight.png",				4, 2, 2);
	global.sprWindNightEvent					= sprite_add("sprites/particles/sprWindNightEvent.png", 					9, 12, 12);
	global.sprMeteorGlow						= sprite_add("sprites/particles/sprMeteorGlow.png",							4, 24, 24);
	global.sprMeteorSparkle						= sprite_add("sprites/particles/sprMeteorSparkle.png",						5, 8, 8);
	global.sprMeteorHit							= sprite_add("sprites/particles/sprMeteorHit.png",							4, 12, 12);
	global.sprBigSkullNight						= sprite_add("sprites/areas/desert/night/sprBigSkullNight.png", 			1, 24, 24);
	global.sprBigSkullHurtNight					= sprite_add("sprites/areas/desert/night/sprBigSkullHurtNight.png", 		3, 24, 24);
	global.sprBigSkullDeadNight					= sprite_add("sprites/areas/desert/night/sprBigSkullDeadNight.png", 		3, 24, 24);
	global.sprBigSkullOpenNight					= sprite_add("sprites/areas/desert/night/sprBigSkullOpenNight.png", 		1, 24, 24);
	global.sprBigSkullOpenHurtNight				= sprite_add("sprites/areas/desert/night/sprBigSkullOpenHurtNight.png", 	3, 24, 24);
	global.sprDesertProtoStatueDecalNight		= sprite_add("sprites/areas/desert/night/sprDesertProtoStatueDecalNight.png",		1, 32, 32);
	global.sprDesertProtoStatueDecalDeadNight	= sprite_add("sprites/areas/desert/night/sprDesertProtoStatueDecalDeadNight.png",	2, 32, 32);
	
	global.sprWall1BotBNight						= sprite_add("sprites/areas/desert/night/sprWall1BotBNight.png",			4, 0, 0);
	global.sprDetailsPlusSnowFloorDesertBNight		= sprite_add("sprites/areas/desert/night/sprSnowFloorDesertBNight.png",		6, 16, 16);
	global.sprDetailsPlusFloorDesertBOutNight		= sprite_add("sprites/areas/desert/night/sprFloorDesertBOutNight.png",		6, 16, 16);
	global.sprDetailsPlusDetailDesertBNight			= sprite_add("sprites/areas/desert/night/sprDetailDesertBNight.png",		4, 5, 5);
	global.sprDetailsPlusDetailDesertMudBNight		= sprite_add("sprites/areas/desert/night/sprDetailDesertMudBNight.png",		6, 5, 5);
	global.sprDetailsPlusDetailDesertMudBigNight	= sprite_add("sprites/areas/desert/night/sprDetailDesertMudBigNight.png",	4, 12, 12);
	
	 // Sandstorm
	//global.sprSandstormSand      				= sprite_add("sprites/particles/sprSandstormSand.png",						1, 128, 128);
	
	 // Solar Shower:
	//global.sprSolarFlareWarning					= sprite_add("sprites/projectiles/sprSolarFlareWarning.png",				1, 16, 16);
	//global.sprSolarFlareWarningBig				= sprite_add("sprites/projectiles/sprSolarFlareWarningBig.png", 			1, 32, 32);
	
	 // Thunderstorm:
	global.sprFogThunderstorm           		= sprite_add("sprites/particles/sprFogThunderstorm.png",					1, 0, 0);
	global.sprRainDropThunderstorm          	= sprite_add("sprites/particles/sprRainDropThunderstorm.png",				1, 64, 64);
	global.sprLightningWarningCircle            = sprite_add("sprites/particles/sprLightningStrikeWarning.png", 			4, 35, 45);
	global.sprLightningWarningCircleBlink       = sprite_add("sprites/particles/sprLightningStrikeWarningBlink.png",		4, 35, 45);
	global.sprLightningWarningCircleAce         = sprite_add("sprites/particles/sprLightningStrikeWarningAce.png",			4, 35, 45);
	global.sprLightningWarningCircleBlinkAce    = sprite_add("sprites/particles/sprLightningStrikeWarningBlinkAce.png", 	4, 35, 45);
	
	 // Night Scrapyards:
	global.sprFloor3Night						= sprite_add("sprites/areas/scrapyard/night/sprFloor3Night.png",			4, 0, 0)
	global.sprFloor3BNight						= sprite_add("sprites/areas/scrapyard/night/sprFloor3BNight.png",			3, 2, 2)
	global.sprFloor3ExploNight					= sprite_add("sprites/areas/scrapyard/night/sprFloor3ExploNight.png",		4, 1, 1)
	global.sprWall3BotNight						= sprite_add("sprites/areas/scrapyard/night/sprWall3BotNight.png",			4, 0, 0)
	global.sprWall3TopNight						= sprite_add("sprites/areas/scrapyard/night/sprWall3TopNight.png",			4, 0, 0)
	global.sprWall3TransNight					= sprite_add("sprites/areas/scrapyard/night/sprWall3TransNight.png",		3, 0, 0)
	global.sprWall3OutNight						= sprite_add("sprites/areas/scrapyard/night/sprWall3OutNight.png",			3, 4, 12)
	global.sprDebris3Night						= sprite_add("sprites/areas/scrapyard/night/sprDebris3Night.png",			4, 4, 4)
	global.sprDetail3Night						= sprite_add("sprites/areas/scrapyard/night/sprDetail3Night.png",			4, 4, 4)
	global.sprScrapDecalNight					= sprite_add("sprites/areas/scrapyard/night/sprScrapDecalNight.png",		2, 16, 24)
	global.sprTopDecalScrapyardNight			= sprite_add("sprites/areas/scrapyard/night/sprTopDecalScrapyardNight.png", 3, 16, 16)
	global.sprTrapNight							= sprite_add("sprites/areas/scrapyard/night/sprTrapNight.png",				1, 8, 8)
	global.sprTrapScorchMarkNight				= sprite_add("sprites/areas/scrapyard/night/sprTrapScorchMarkNight.png",	1, 32, 32)
	global.sprCarIdleNight						= sprite_add("sprites/areas/scrapyard/night/props/sprCarIdleNight.png", 	1, 16, 16)
	global.sprCarHurtNight						= sprite_add("sprites/areas/scrapyard/night/props/sprCarHurtNight.png", 	3, 16, 16)
	global.sprVenusCarIdleNight					= sprite_add("sprites/areas/scrapyard/night/props/sprVenusCarIdleNight.png", 1, 16, 16)
	global.sprVenusCarHurtNight					= sprite_add("sprites/areas/scrapyard/night/props/sprVenusCarHurtNight.png", 3, 16, 16)
	global.sprVenusCarIdleNight					= sprite_add("sprites/areas/scrapyard/night/props/sprVenusCarIdleNight.png", 1, 16, 16)
	global.sprTiresIdleNight					= sprite_add("sprites/areas/scrapyard/night/props/sprTiresIdleNight.png",	1, 12, 12)
	global.sprTiresHurtNight					= sprite_add("sprites/areas/scrapyard/night/props/sprTiresHurtNight.png",	3, 12, 12)
	global.sprTiresDeadNight					= sprite_add("sprites/areas/scrapyard/night/props/sprTiresDeadNight.png",	3, 12, 12)
	global.sprScrapyardProtoStatueDecalNight		= sprite_add("sprites/areas/scrapyard/night/sprScrapyardProtoStatueDecalNight.png",		1, 32, 32);
	global.sprScrapyardProtoStatueDecalDeadNight	= sprite_add("sprites/areas/scrapyard/night/sprScrapyardProtoStatueDecalDeadNight.png",	2, 32, 32);
	global.sprScrapyardCoveEntranceClosedNight		= sprite_add("sprites/areas/scrapyard/night/sprScrapyardCoveEntranceClosedNight.png",	1, 24, 24);	
	global.sprScrapyardCoveEntranceOpenNight		= sprite_add("sprites/areas/scrapyard/night/sprScrapyardCoveEntranceOpenNight.png",		1, 24, 24);	
	global.sprCoveEntranceDebrisNight			= sprite_add("sprites/areas/scrapyard/night/sprCoveEntranceDebrisNight.png",		3, 8, 8);	
	
	 // Aurora:
	global.sprFloor5Night			   			= sprite_add("sprites/areas/frozencity/night/sprFloor5Night.png",			8, 0, 0)	
	global.sprFloor5BNight			   			= sprite_add("sprites/areas/frozencity/night/sprFloor5BNight.png",			8, 16, 16)
	global.sprSnowFloorNight			   		= sprite_add("sprites/areas/frozencity/night/sprSnowFloorNight.png",		8, 16, 16);
	global.sprFloor5ExploNight					= sprite_add("sprites/areas/frozencity/night/sprFloor5ExploNight.png",		4, 1, 1)	
	global.sprWall5BotNight						= sprite_add("sprites/areas/frozencity/night/sprWall5BotNight.png", 		3, 0, 0)	
	global.sprWall5TopNight						= sprite_add("sprites/areas/frozencity/night/sprWall5TopNight.png", 		4, 0, 0)
	global.sprWall5TransNight					= sprite_add("sprites/areas/frozencity/night/sprWall5TransNight.png",		1, 0, 0)
	global.sprWall5OutNight						= sprite_add("sprites/areas/frozencity/night/sprWall5OutNight.png", 		2, 4, 12)
	global.sprDebris5Night						= sprite_add("sprites/areas/frozencity/night/sprDebris5Night.png",			4, 4, 4)
	global.sprDetail5Night						= sprite_add("sprites/areas/frozencity/night/sprDetail5Night.png",			3, 4, 4)
	global.sprIceDecalNight						= sprite_add("sprites/areas/frozencity/night/sprIceDecalNight.png", 		2, 16, 24)
	global.sprTopDecalCityNight					= sprite_add("sprites/areas/frozencity/night/sprTopDecalCityNight.png", 	3, 16, 16)
	global.sprFrozenCarNight					= sprite_add("sprites/areas/frozencity/night/props/sprFrozenCarNight.png",	1, 16, 16)
	global.sprFrozenCarHurtNight				= sprite_add("sprites/areas/frozencity/night/props/sprFrozenCarHurtNight.png", 3, 16, 16)
	global.sprStreetLightNight					= sprite_add("sprites/areas/frozencity/night/props/sprStreetLightNight.png", 1, 12, 37)
	global.sprStreetLightHurtNight				= sprite_add("sprites/areas/frozencity/night/props/sprStreetLightHurtNight.png", 3, 12, 37)
	global.sprStreetLightDeadNight				= sprite_add("sprites/areas/frozencity/night/props/sprStreetLightDeadNight.png", 3, 12, 37)
	global.sprSnowFlakeNight			   		= sprite_add("sprites/areas/frozencity/night/sprSnowFlakeNight.png",		3, 4, 4)
	global.sprHydrantNight			   			= sprite_add("sprites/areas/frozencity/night/props/sprHydrantNight.png",	1, 12, 12)
	global.sprHydrantHurtNight			   		= sprite_add("sprites/areas/frozencity/night/props/sprHydrantHurtNight.png", 3, 12, 12)	
	global.sprHydrantDeadNight			   		= sprite_add("sprites/areas/frozencity/night/props/sprHydrantDeadNight.png", 3, 12, 12)	
	global.sprIcicleNight			   			= sprite_add("sprites/areas/frozencity/night/props/sprIcicleNight.png", 	1, 12, 12)
	global.sprIcicleHurtNight			   		= sprite_add("sprites/areas/frozencity/night/props/sprIcicleHurtNight.png", 3, 12, 12)	
	global.sprIcicleDeadNight			   		= sprite_add("sprites/areas/frozencity/night/props/sprIcicleDeadNight.png", 4, 12, 12)	
	global.sprNewsStandNight			   		= sprite_add("sprites/areas/frozencity/night/props/sprNewsStandNight.png",	1, 12, 16)
	global.sprNewsStandHurtNight			   	= sprite_add("sprites/areas/frozencity/night/props/sprNewsStandHurtNight.png", 3, 12, 16)	
	global.sprNewsStandDeadNight			   	= sprite_add("sprites/areas/frozencity/night/props/sprNewsStandDeadNight.png", 3, 12, 16)	
	global.sprSodaMachineNight			   		= sprite_add("sprites/areas/frozencity/night/props/sprSodaMachineNight.png", 1, 16, 16)
	global.sprSodaMachineHurtNight			   	= sprite_add("sprites/areas/frozencity/night/props/sprSodaMachineHurtNight.png", 3, 16, 16)	
	global.sprSodaMachineDeadNight			    = sprite_add("sprites/areas/frozencity/night/props/sprSodaMachineDeadNight.png", 3, 16, 16)
	global.sprSnowManNight			   			= sprite_add("sprites/areas/frozencity/night/props/sprSnowManNight.png",	1, 16, 16)
	global.sprSnowManHurtNight			   		= sprite_add("sprites/areas/frozencity/night/props/sprSnowManHurtNight.png", 3, 16, 16)	
	global.sprSnowManDeadNight			   		= sprite_add("sprites/areas/frozencity/night/props/sprSnowManDeadNight.png", 3, 16, 16)
	global.sprCityProtoStatueDecalNight			= sprite_add("sprites/areas/frozencity/night/sprCityProtoStatueDecalNight.png",		1, 32, 32);
	global.sprCityProtoStatueDecalDeadNight		= sprite_add("sprites/areas/frozencity/night/sprCityProtoStatueDecalDeadNight.png",	2, 32, 32);

	 // Blizzard:
	global.sprBlizzardSnow         				= sprite_add("sprites/particles/sprBlizzardSnow.png",						2, 128, 128);
	global.sprBlizzardSnowNight        			= sprite_add("sprites/particles/sprBlizzardSnowNight.png",					2, 128, 128);
	
	 // Blackout:
	global.sprFogBlackout						= sprite_add("sprites/particles/sprFogBlackout.png",						6, 12, 12);
	global.sprWall6BotBlackout					= sprite_add("sprites/areas/labs/sprWall6BotBlackout.png",					4, 0, 0)
	global.sprServerOff							= sprite_add("sprites/areas/labs/props/sprServerOff.png",					2, 16, 16)
	global.sprServerOffHurt						= sprite_add("sprites/areas/labs/props/sprServerOffHurt.png",				3, 16, 16)
	global.sprTerminalOff						= sprite_add("sprites/areas/labs/props/sprTerminalOff.png", 				1, 12, 12);
	global.sprTerminalOffHurt					= sprite_add("sprites/areas/labs/props/sprTerminalOffHurt.png", 			3, 12, 12);
	
	global.blackoutScale						= 0; // this isn't a sprite but idc 
	
	 // Coast Night:
	global.sprFloorCoast			   			= sprite_add("sprites/areas/coast/night/sprFloorCoast.png", 				4, 2, 2); // storing locally since I gotta do a psuedo sprite_replace/restore.
	global.sprFloorCoastNight			   		= sprite_add("sprites/areas/coast/night/sprFloorCoastNight.png",			4, 2, 2);
	global.sprFloorCoastBNight			   		= sprite_add("sprites/areas/coast/night/sprFloorCoastBNight.png",			3, 2, 2);
	global.sprCoastTrans			   			= sprite_add("sprites/areas/coast/night/sprCoastTrans.png", 				1, 0, 0);
	global.sprCoastTransNight			   		= sprite_add("sprites/areas/coast/night/sprCoastTransNight.png", 			1, 0, 0);
	global.sprDetailCoastNight			   		= sprite_add("sprites/areas/coast/night/sprDetailCoastNight.png",			6, 4, 4);
//	global.sprSnowManDeadNight			   		= sprite_add("sprites/areas/coast/night/props/sprSnowManDeadNight.png", 	3, 16, 16);
	global.sprBloomingBushNight			   		= sprite_add("sprites/areas/coast/night/props/sprBloomingBushNight.png",	1, 12, 12);
	global.sprBloomingCactusNight			   	= sprite_add("sprites/areas/coast/night/props/sprBloomingCactusNight.png",		1, 12, 12);
	global.sprBloomingCactusHurtNight			= sprite_add("sprites/areas/coast/night/props/sprBloomingCactusHurtNight.png",	3, 12, 12);
	global.sprBloomingCactusDeadNight			= sprite_add("sprites/areas/coast/night/props/sprBloomingCactusDeadNight.png",	4, 12, 12);
	global.sprBloomingCactus2Night			   	= sprite_add("sprites/areas/coast/night/props/sprBloomingCactus2Night.png",		1, 12, 12);
	global.sprBloomingCactus2HurtNight			= sprite_add("sprites/areas/coast/night/props/sprBloomingCactus2HurtNight.png",	3, 12, 12);
	global.sprBloomingCactus2DeadNight			= sprite_add("sprites/areas/coast/night/props/sprBloomingCactus2DeadNight.png",	4, 12, 12);
	global.sprBloomingCactus3Night			   	= sprite_add("sprites/areas/coast/night/props/sprBloomingCactus3Night.png",		1, 12, 12);
	global.sprBloomingCactus3HurtNight			= sprite_add("sprites/areas/coast/night/props/sprBloomingCactus3HurtNight.png",	3, 12, 12);
	global.sprBloomingCactus3DeadNight			= sprite_add("sprites/areas/coast/night/props/sprBloomingCactus3DeadNight.png",	4, 12, 12);
	global.sprBigBloomingCactusNight			= sprite_add("sprites/areas/coast/night/props/sprBigBloomingCactusNight.png",	1, 16, 16);
	global.sprBigBloomingCactusHurtNight		= sprite_add("sprites/areas/coast/night/props/sprBigBloomingCactusHurtNight.png",	3, 16, 16);
	global.sprBigBloomingCactusDeadNight		= sprite_add("sprites/areas/coast/night/props/sprBigBloomingCactusDeadNight.png",	4, 16, 16);
	global.sprRock1IdleNight					= sprite_add("sprites/areas/coast/night/props/sprRock1IdleNight.png",		1, 16, 16);
	global.sprRock1HurtNight					= sprite_add("sprites/areas/coast/night/props/sprRock1HurtNight.png",		3, 16, 16);
	global.sprRock1DeadNight					= sprite_add("sprites/areas/coast/night/props/sprRock1DeadNight.png",		1, 16, 16);
	global.sprRock1BottNight					= sprite_add("sprites/areas/coast/night/props/sprRock1BottNight.png",		1, 16, 16);
	global.sprRock2IdleNight					= sprite_add("sprites/areas/coast/night/props/sprRock2IdleNight.png",		1, 16, 16);
	global.sprRock2HurtNight					= sprite_add("sprites/areas/coast/night/props/sprRock2HurtNight.png",		3, 16, 16);
	global.sprRock2DeadNight					= sprite_add("sprites/areas/coast/night/props/sprRock2DeadNight.png",		1, 16, 16);
	global.sprRock2BottNight					= sprite_add("sprites/areas/coast/night/props/sprRock2BottNight.png",		1, 16, 16);
	global.sprBuriedCarNight					= sprite_add("sprites/areas/coast/night/props/sprBuriedCarNight.png",		1, 16, 16);
	global.sprBuriedCarHurtNight				= sprite_add("sprites/areas/coast/night/props/sprBuriedCarHurtNight.png",	3, 16, 16);
	global.sprCompatTrafficCrabDead				= sprite_add("sprites/areas/coast/night/enemies/trafficcrab/sprTrafficCrabDead.png",	9, 24, 24);
	global.sprCompatTrafficCrabHide				= sprite_add("sprites/areas/coast/night/enemies/trafficcrab/sprTrafficCrabHide.png",	5, 24, 24);
	global.sprCompatPalmIdleNight				= sprite_add("sprites/areas/coast/night/props/sprPalmNight.png",			1, 24, 40);
	global.sprCompatPalmHurtNight				= sprite_add("sprites/areas/coast/night/props/sprPalmHurtNight.png",		3, 24, 40);
	global.sprCompatPalmDeadNight				= sprite_add("sprites/areas/coast/night/props/sprPalmDeadNight.png",		4, 24, 40);
	global.sprCompatPalmFortIdleNight			= sprite_add("sprites/areas/coast/night/props/sprPalmFortNight.png",		1, 32, 56);
	global.sprCompatPalmFortHurtNight			= sprite_add("sprites/areas/coast/night/props/sprPalmFortHurtNight.png",	3, 32, 56);
//	global.sprLeafNight							= sprite_add("sprites/areas/coast/night/sprLeafNight.png",					5, 4, 4);
	global.sprCompatShellIdleNight				= sprite_add("sprites/areas/coast/night/props/sprShellIdleNight.png",		1, 32, 32);
	global.sprCompatShellHurtNight				= sprite_add("sprites/areas/coast/night/props/sprShellHurtNight.png",		3, 32, 32);
	global.sprCompatShellDeadNight				= sprite_add("sprites/areas/coast/night/props/sprShellDeadNight.png",		6, 32, 32);
	global.sprCompatShellBottNight				= sprite_add("sprites/areas/coast/night/props/sprShellBottNight.png",		1, 32, 32);
	global.sprCompatPalankingChunk				= sprite_add("sprites/areas/coast/night/enemies/palanking/sprPalankingChunk.png",		5, 16, 16);
	global.sprCompatPalankingChunkNight			= sprite_add("sprites/areas/coast/night/enemies/palanking/sprPalankingChunkNight.png",	5, 16, 16);
	global.sprCompatPalankingBott				= sprite_add("sprites/areas/coast/night/enemies/palanking/sprPalankingBase.png",		1, 40, 24);
	global.sprCompatPalankingBottNight			= sprite_add("sprites/areas/coast/night/enemies/palanking/sprPalankingBaseNight.png",	1, 40, 24);
	global.sprCompatPalankingTaunt				= sprite_add("sprites/areas/coast/night/enemies/palanking/sprPalankingTaunt.png",		31, 40, 24);
	global.sprCompatPalankingCall				= sprite_add("sprites/areas/coast/night/enemies/palanking/sprPalankingCall.png",		9, 40, 24);
	global.sprCompatPalankingIdle				= sprite_add("sprites/areas/coast/night/enemies/palanking/sprPalankingIdle.png",		16, 40, 24);
	global.sprCompatPalankingWalk				= sprite_add("sprites/areas/coast/night/enemies/palanking/sprPalankingWalk.png",		16, 40, 24);
	global.sprCompatPalankingHurt				= sprite_add("sprites/areas/coast/night/enemies/palanking/sprPalankingHurt.png",		3, 40, 24);
	global.sprCompatPalankingDead				= sprite_add("sprites/areas/coast/night/enemies/palanking/sprPalankingDead.png",		11, 40, 24);
	global.sprCompatPalankingBurp				= sprite_add("sprites/areas/coast/night/enemies/palanking/sprPalankingBurp.png",		5, 40, 24);
	global.sprCompatPalankingFire				= sprite_add("sprites/areas/coast/night/enemies/palanking/sprPalankingFire.png",		11, 40, 24);
	global.sprCompatBloomingAssassinIdle		= sprite_add("sprites/areas/coast/night/enemies/bloomingass/sprBloomingAssassinIdle.png",	6, 16, 16);
	global.sprCompatBloomingAssassinWalk		= sprite_add("sprites/areas/coast/night/enemies/bloomingass/sprBloomingAssassinWalk.png",	6, 16, 16);
	global.sprCompatBloomingAssassinHurt		= sprite_add("sprites/areas/coast/night/enemies/bloomingass/sprBloomingAssassinHurt.png",	3, 16, 16);
	global.sprCompatBloomingAssassinDead		= sprite_add("sprites/areas/coast/night/enemies/bloomingass/sprBloomingAssassinDead.png",	6, 16, 16);
	global.sprCompatBloomingAssassinHide		= sprite_add("sprites/areas/coast/night/enemies/bloomingass/sprBloomingAssassinHide.png",	41, 16, 16);
	global.sprCoastProtoStatueDecalNight		= sprite_add("sprites/areas/coast/night/sprCoastProtoStatueDecalNight.png",		1, 32, 32);
	global.sprCoastProtoStatueDecalDeadNight	= sprite_add("sprites/areas/coast/night/sprCoastProtoStatueDecalDeadNight.png",	2, 32, 32);


	 // Plague of Flesh:
	global.sprFloorMeat							= sprite_add("sprites/areas/meat/sprFloorMeat.png", 						4, 0, 0);	
	global.sprSnowFloorMeat						= sprite_add("sprites/areas/meat/sprSnowFloorMeat.png", 					4, 8, 8);	
	global.sprWallMeatBot						= sprite_add("sprites/areas/meat/sprWallMeatBot.png",						4, 0, 0);
	global.sprWallMeatTop						= sprite_add("sprites/areas/meat/sprWallMeatTop.png",						2, 0, 0);
	global.sprWallMeatOut						= sprite_add("sprites/areas/meat/sprWallMeatOut.png",						2, 4, 12);
	global.sprMeatBones							= sprite_add("sprites/areas/meat/sprMeatBones.png", 						5, 16, 24);
	global.sprBloodCocoon						= sprite_add("sprites/areas/meat/props/sprBloodCocoon.png", 				1, 12, 12);
	global.sprBloodCocoonHurt					= sprite_add("sprites/areas/meat/props/sprBloodCocoonHurt.png", 			3, 12, 12);
	global.sprBloodCocoonDead					= sprite_add("sprites/areas/meat/props/sprBloodCocoonDead.png", 			3, 12, 12);
	global.sprBloodCactus						= sprite_add("sprites/areas/meat/props/sprBloodCactus.png", 				1, 12, 12);
	global.sprBloodCactusHurt					= sprite_add("sprites/areas/meat/props/sprBloodCactusHurt.png", 			3, 12, 12);
	global.sprBloodCactusDead					= sprite_add("sprites/areas/meat/props/sprBloodCactusDead.png", 			4, 12, 12);

	 // COMPAT SPRITES//
	
	 // Night Desert:
	global.sprCompatBigTopDecalDesert			= sprite_add("sprites/areas/desert/night/compat/sprBigTopDecalDesert.png",	1, 32, 56);	
	global.sprCompatBigTopDecalDesertScorpion	= sprite_add("sprites/areas/desert/night/compat/sprBigTopDecalScorpion.png", 1, 32, 56);	
	global.sprCompatWallBandit			   		= sprite_add("sprites/areas/desert/night/compat/sprWallBandit.png", 		9, 8, 8);	
	global.sprCompatWall1BotRubble				= sprite_add("sprites/areas/desert/night/compat/sprWall1BotRubble.png", 	4, 0, 0);	
	global.sprCompatWall1TopRubble				= sprite_add("sprites/areas/desert/night/compat/sprWall1TopRubble.png", 	4, 0, 0);	
	global.sprCompatWall1OutRubble				= sprite_add("sprites/areas/desert/night/compat/sprWall1OutRubble.png", 	4, 4, 12);	
	global.sprCompatScorpionRock			   	= sprite_add("sprites/areas/desert/night/compat/sprScorpionRock.png",		6, 16, 16);		
	global.sprCompatScorpionRockHurt			= sprite_add("sprites/areas/desert/night/compat/sprScorpionRockHurt.png",	3, 16, 16);			
	global.sprCompatScorpionRockDead			= sprite_add("sprites/areas/desert/night/compat/sprScorpionRockDead.png",	3, 16, 16);		
	global.sprCompatScorpionRockAlly			= sprite_add("sprites/areas/desert/night/compat/sprScorpionRockAlly.png",	6, 16, 16);	
	global.sprCompatFloorScorpion				= sprite_add("sprites/areas/desert/night/compat/sprFloorScorpion.png",		2, 8, 8);	
	global.sprCompatSnowFloorScorpion			= sprite_add("sprites/areas/desert/night/compat/sprSnowFloorScorpion.png",	1, 8, 8);	
	global.sprCompatCowSkullIdle				= sprite_add("sprites/areas/desert/night/compat/sprCowSkull.png",			1, 24, 24);	
	global.sprCompatCowSkullHurt				= sprite_add("sprites/areas/desert/night/compat/sprCowSkullHurt.png",		3, 24, 24);	
	global.sprCompatCowSkullDead				= sprite_add("sprites/areas/desert/night/compat/sprCowSkullDead.png",		3, 24, 24);	
/*	global.sprCompatCactuarSpawn				= sprite_add("sprites/areas/desert/night/compat/sprCactusSpawn.png",		8, 24, 24);	
	global.sprCompatCactuarIdle					= sprite_add("sprites/areas/desert/night/compat/sprCactusIdle.png", 		4, 24, 24);	
	global.sprCompatCactuarWalk					= sprite_add("sprites/areas/desert/night/compat/sprCactusWalk.png", 		6, 24, 24);	
	global.sprCompatCactuarHurt					= sprite_add("sprites/areas/desert/night/compat/sprCactusHurt.png", 		3, 24, 24);	
	global.sprCompatCactuarFire					= sprite_add("sprites/areas/desert/night/compat/sprCactusFire.png", 		14, 24, 24); */
	global.sprCompatCactuarFake					= sprite_add("sprites/areas/desert/night/compat/sprCactusFakeIdle.png", 	1, 24, 24);
	global.sprCompatCactuarFakeHurt				= sprite_add("sprites/areas/desert/night/compat/sprCactusFakeHurt.png", 	3, 24, 24);
	global.sprCompatCactuarFakeDead				= sprite_add("sprites/areas/desert/night/compat/sprCactusFakeDead.png", 	4, 24, 24);
	global.sprCompatTinyCactuarFake				= sprite_add("sprites/areas/desert/night/compat/sprTinyCactaurFake.png",	1, 8, 8);
	global.sprCompatTinyCactuarFakeHurt			= sprite_add("sprites/areas/desert/night/compat/sprTinyCactaurFake_Hurt.png", 3, 8, 8);
	global.sprCompatTinyCactuarFakeDead			= sprite_add("sprites/areas/desert/night/compat/sprTinyCactaurFake_Dead.png", 4, 8, 8);
	global.sprCompatTinyCactuarFake2			= sprite_add("sprites/areas/desert/night/compat/sprTinyCactaurFake2.png",	1, 8, 8);
	global.sprCompatTinyCactuarFake2Hurt		= sprite_add("sprites/areas/desert/night/compat/sprTinyCactaurFake2_Hurt.png", 3, 8, 8);
	global.sprCompatTinyCactuarFake3			= sprite_add("sprites/areas/desert/night/compat/sprTinyCactaurFake3.png",	1, 8, 8);
	global.sprCompatTinyCactuarFake3Hurt		= sprite_add("sprites/areas/desert/night/compat/sprTinyCactaurFake3_Hurt.png", 3, 8, 8);
	global.sprCompatTinyCactuarFake3Dead		= sprite_add("sprites/areas/desert/night/compat/sprTinyCactaurFake3_Dead.png", 4, 8, 8);
	global.sprCompatBanditCampfire  			= sprite_add("sprites/areas/desert/night/compat/sprBanditCampfire.png",  		1, 26, 26);
	global.sprCompatBanditTentIdle  			= sprite_add("sprites/areas/desert/night/compat/sprBanditTent.png",      		1, 24, 24);
	global.sprCompatBanditTentHurt  			= sprite_add("sprites/areas/desert/night/compat/sprBanditTentHurt.png",  		3, 24, 24);
	global.sprCompatBanditTentDead  			= sprite_add("sprites/areas/desert/night/compat/sprBanditTentDead.png",  		3, 24, 24);
	global.sprCompatBanditTentWallIdle			= sprite_add("sprites/areas/desert/night/compat/sprBanditTentWall.png",  		1, 24, 24);
	global.sprCompatBanditTentWallHurt			= sprite_add("sprites/areas/desert/night/compat/sprBanditTentWallHurt.png",		3, 24, 24);
	global.sprCompatBanditTentWallDead			= sprite_add("sprites/areas/desert/night/compat/sprBanditTentWallDead.png",		3, 24, 24);
	global.sprCompatBigFishBecomeIdle			= sprite_add("sprites/areas/desert/night/compat/sprBigFishBuild.png",   		4, 40, 38);
	global.sprCompatBigFishSpwn					= sprite_add("sprites/areas/desert/night/compat/sprBigFishSpawn.png",   		11, 32, 32);	
	global.sprCompatBigFishLeap					= sprite_add("sprites/areas/desert/night/compat/sprBigFishLeap.png",   			11, 32, 32);	
	global.sprCompatBigFishRise					= sprite_add("sprites/areas/desert/night/compat/sprBigFishRise.png",   			5, 32, 32);	
	
	 // Night Scrapyards:
	global.sprCompatBigTopDecalScrapyard		= sprite_add("sprites/areas/scrapyard/night/compat/sprBigTopDecalScrapyard.png", 1, 32, 48);		 
	global.sprCompatFirePitScorch				= sprite_add("sprites/areas/scrapyard/night/compat/sprFirePitScorch.png",	3, 16, 16);
	global.sprCompatSludgePool					= sprite_add("sprites/areas/scrapyard/night/compat/sprSludgePool.png",		4, 0, 0);
	global.sprCompatTopDecalScrapyardAlt		= sprite_add("sprites/areas/scrapyard/night/compat/sprTopDecalScrapyardAlt.png", 1, 16, 16);
	global.sprCompatTrapSpin					= sprite_add("sprites/areas/scrapyard/night/compat/sprTrapSpin.png",		8, 12, 12);
/*	global.sprCompatBigWheel					= sprite_add("sprites/areas/scrapyard/night/compat/sprBigWheel.png",		1, 16, 16);
	global.sprCompatBigWheelHurt				= sprite_add("sprites/areas/scrapyard/night/compat/sprBigWheelHurt.png",	3, 16, 16);
	global.sprCompatBigWheelDead				= sprite_add("sprites/areas/scrapyard/night/compat/sprBigWheelDead.png",	3, 16, 16); */
	
	 // Night Frocity:
	global.sprCompatFloorSeal					= sprite_add("sprites/areas/frozencity/night/compat/sprFloorSeal.png",		4, 16, 16);
	global.sprCompatFloorSealRoom				= sprite_add("sprites/areas/frozencity/night/compat/sprFloorSealRoom.png",	9, 16, 16);	
	global.sprCompatFloorSealRoomBig			= sprite_add("sprites/areas/frozencity/night/compat/sprFloorSealRoomBig.png", 25, 16, 16);	
	global.sprCompatIglooFront					= sprite_add("sprites/areas/frozencity/night/compat/sprIglooFront.png", 	1, 24, 24);	
	global.sprCompatIglooFrontHurt				= sprite_add("sprites/areas/frozencity/night/compat/sprIglooFrontHurt.png", 3, 24, 24);	
	global.sprCompatIglooFrontDead				= sprite_add("sprites/areas/frozencity/night/compat/sprIglooFrontDead.png", 3, 24, 24);	
	global.sprCompatIglooSide					= sprite_add("sprites/areas/frozencity/night/compat/sprIglooSide.png",		1, 24, 24);	
	global.sprCompatIglooSideHurt				= sprite_add("sprites/areas/frozencity/night/compat/sprIglooSideHurt.png",	3, 24, 24);	
	global.sprCompatIglooSideDead				= sprite_add("sprites/areas/frozencity/night/compat/sprIglooSideDead.png",	3, 24, 24);
	global.sprCompatPalankingStatue =[			 sprite_add("sprites/areas/frozencity/night/compat/sprPalankingStatue1.png", 1, 32, 32),
												 sprite_add("sprites/areas/frozencity/night/compat/sprPalankingStatue2.png", 1, 32, 32),	
												 sprite_add("sprites/areas/frozencity/night/compat/sprPalankingStatue3.png", 1, 32, 32),
												 sprite_add("sprites/areas/frozencity/night/compat/sprPalankingStatue4.png", 1, 32, 32)]
	global.sprCompatPalankingStatueDead			= sprite_add("sprites/areas/frozencity/night/compat/sprPalankingStatueDead.png", 3, 32, 32);
	
	 // Labs Outpost type stuff:
	global.sprSnowFloorOutpost     				= sprite_add("sprites/areas/outpost/sprSnowFloorOutpost.png",					4, 16, 16);
	global.sprSnowFloorOutpostSnow     			= sprite_add("sprites/areas/outpost/sprSnowFloorOutpostSnow.png",				4, 16, 16);
	global.sprSnowFloorOutpostSnowNight     	= sprite_add("sprites/areas/outpost/night/sprSnowFloorOutpostSnowNight.png",	4, 16, 16);
	global.sprCityWallOutpostBot				= sprite_add("sprites/areas/outpost/sprCityWallOutpostBot.png", 				2, 0, 0);
	global.sprCityWallOutpostBotNight			= sprite_add("sprites/areas/outpost/night/sprCityWallOutpostBotNight.png", 		2, 0, 0);

	 // Lightning Thangs
	vertex_format_begin()
	vertex_format_add_position()
	global.lightningformat = vertex_format_end()

#define game_start
	global.nightCredits			= 0;
	global.eventMusicPlaying	= false;
	
	if(mod_exists("mod", "teassets")){
		 // Restore Coast Sprite:
		with(_tespr){
			FloorCoast		= global.sprFloorCoast;
			CoastTrans		= global.sprCoastTrans;
			PalankingChunk	= global.sprCompatPalankingChunk;
			PalankingBott	= global.sprCompatPalankingBott;
		}
	}
	sprite_restore(sprWind);
	sprite_restore(sprLeaf);
	SerpentLair_cleanup();
	
	 // Stop v9944 RadioActive from playing:
	 // doesnt work if radioactive is loaded before frontier
	 // WHATEVER!!!!!!!!!
	if(call(scr.event_get_active, "MeteorShower")){
		if(mod_exists("mod", "radioactive")){
			if(mod_variable_exists("mod", "radioactive", "menuhandler")){
				if(fork()){
					wait(1);
					mod_variable_set("mod", "radioactive", "track_found", false);
	
					exit;
					wait(2);
					sound_play_music(global.musDesertNight)
				}
			}
		}
	}

#define draw_dark

	draw_set_color($808080);
	
	
	 // this isn't just darkness... this is... ADVANCED darkness
	if call(scr.event_get_active, "Blackout"){
		with(Player){

			// Eyes can see in the dark:
			switch(race){
				case "eyes":
				var _eyesRadius = 0.3;
				break;
			
				default: var _eyesRadius = 0;
			}
			draw_set_blend_mode(bm_normal)
			d3d_set_fog(1, c_white, 0, 0)
			draw_set_visible_all(false);
    		draw_set_visible(index, true);
			draw_sprite_ext(global.sprVignette, 0, x, y, global.blackoutScale + _eyesRadius + (skill_get("bat ears") * 0.3), global.blackoutScale + _eyesRadius + (skill_get("bat ears") * 0.3), 0, c_white, 1);
			draw_sprite_ext(global.sprVignetteOuterBlackout, 0, x, y, (global.blackoutScale + _eyesRadius + (skill_get("bat ears") * 0.3)) * 8, (global.blackoutScale + _eyesRadius + (skill_get("bat ears") * 0.3)) * 8, 0, c_white, 1) 
			draw_set_visible_all(true);
			d3d_set_fog(0, c_white, 0, 0)
		}
	}

#define draw_dark_end
	draw_set_color($000000);
	if(global.settingLightningFlash = true){ 
		with(instances_matching(CustomProjectile, "name", "Lightning Strike")){
			 draw_circle(x, y, 640 + random(7), false); 
		}
	}
	with(instances_matching(CustomObject, "name", "fr_meteor")) draw_circle(x, y, 20 + random(5), false);

//#region GENERIC EVENTS
//#region LABS OUTPOSTS
#define LabsOutpost_text			return (global.settingEventText = false) ? undefined : choose("UNWELCOME GUESTS", "FIELD TESTING");
#define LabsOutpost_area			return [1, 2, 3, 4, 5, 7]; // Main Path Only, excluding labs
#define LabsOutpost_chance			return 0;//(GameCont.hard < 8) or (GameCont.area = 7 and GameCont.subarea = 3) ? 0 : 0.05;

#define LabsOutpost_create
	
	
	// this needed to be fully redone so I just deleted it for now, these will be reimplemented later when labs heat is done.


//#region PORTAL STORM
#define PortalStorm_text		return (global.settingEventText = false) ? undefined : "@sJUST MORE @ePORTALS";
#define PortalStorm_area		return [1, 2, 3, 4, 5, 6, 7]; // Main Path Only:
#define PortalStorm_chance		return (GameCont.loops < 1) || (GameCont.area = 7 && GameCont.subarea = 3) ? 0 : global.settingPortalStormEventSpawnChance + ((crown_current = "storms") * 0.04); // Loop Exclusive, no 7-3
#define PortalStorm_hard		return 33;

#define PortalStorm_create

	 // Dropdown:
	if(global.settingEventDropdowns = true){
		EventDropdown_queue(7, 0, global.sndEventIntroWeather);
	}
	
	stormPortals		= 0;
	portalStormCooldown = 120;
	maxPortals			= 2 + GameCont.loops;
	
#define PortalStorm_step

    if(portalStormCooldown >= 0){ 
    	portalStormCooldown -= current_time_scale 
    }
    
    if(stormPortals < maxPortals){
		with(Floor){
			if (random(600) < 1){
				instance_create(x + random_range(-32, 32), y + random_range(-32, 32), PortalL)
			}
		}
		if(random(100) < current_time_scale) && (portalStormCooldown <= 0){ 
			with (call(scr.instance_random, Floor)){ 
				if(distance_to_object(ProtoStatue) > 64 && distance_to_object(Player) < 224){ 
					StormPortal_create(x, y) 
					other.stormPortals += 1;
				}
			} 
		}
    }

#define StormPortal_create(_x, _y)
	with(instance_create(_x, _y, CustomObject)){
		
		name			= "fr_stormportal"
		
		 // Visuals:
		spr_spwn		= sprBigPortalSpawn;
		spr_idle		= sprBigPortal;
		spr_gone		= sprBigPortalDisappear;
		sprite_index	= spr_spwn;
		image_speed		= 0.4;
		depth			= -1;
		fr_bloom		= [2, 0.1];
        fr_glow			= [64, 96];
		
		 // Vars:
		lifetime		= 100;
		ammo			= 0;
		portalDone		= false;

		 // Choose Area Pool:
		portalArea = call(scr.pool, {
			"Desert"		: 1,
			"Sewers"		: 1,
			"Scrapyards"	: 1,
			"Crystal Caves"	: 1,
			"Frozen City"	: 1,
			"Labs"			: 1,
			"Palace"		: 1,
			"Oasis"			: 1,
			"Pizza"			: 1,
			"Mansion"		: 1,
			"Cursed Caves"	: 1,
			"Jungle"		: 1,
			"Cove"			: call(scr.save_get, "Frontier", "unlock_bubbles"),
			"Robocenter"	: 1,
			"Coast" 		: mod_exists("mod", "ntte"),
			"Lair" 			: mod_exists("mod", "ntte"),
			"Warp Zone" 	: mod_exists("mod", "ntte"),
			"Undergrowth" 	: mod_exists("mod", "undergrowth")
		})
	
		 // Alarms:
		alarm1		= 0;
		
		 // Events:
		on_step		= StormPortal_step;
		on_alrm1	= script_ref_create(StormPortal_alrm1);

		return self;
	}
	
#define StormPortal_step

	if("on_alrm1" in self and alarm1_run) exit;

	 // Open:
	if(anim_end) && (sprite_index = spr_spwn){
		sprite_index = spr_idle;
		with instance_create(x, y, PortalClear) { 
			image_xscale = 2; 
			image_yscale = image_xscale; 
		}
		sound_play_pitchvol(sndPortalOpen, 0.6, 2)
		if(portalArea = "Oasis"){ 
			sound_play_pitchvol(sndOasisPortal, 0.5, 2) 
		}
		if(portalArea = "Mansion"){ 
			sound_play_pitchvol(sndVenuz, 0.9, 2) 
		}
		view_shake_at(x, y, 100)
		ammo   = 20 + irandom(15);
		alarm1 = 1;
	}
	
	 // Portal Particles:
	if(random(10) < 1) && (sprite_index = spr_idle){
		with instance_create(x + random_range(-40, 40), y + random_range(-40, 40), PortalL){
  			image_xscale = 1;
  			image_yscale = image_xscale;
		}
	}
	
	 // Portal Sounds:
	if(random(10) < 1) && (sprite_index = spr_idle){ 
		sound_play(asset_get_index("sndPortalLightning" + string(irandom_range(1, 8)))) 
	}
	 
	  // Get ooooout:
	if(portalDone = true){
		if(anim_end) && (sprite_index = spr_gone){
	 		instance_destroy();
		}
	}

#define StormPortal_alrm1
	alarm1 = 10;

	if(ammo > 0){
		alarm1 = 1;
		
		switch(portalArea){
			case "Desert": {
				var _portalObject = call(scr.pool, [
			        [[Bandit,		"Basegame", ""],    		12],
			        [[BigMaggot, 	"Basegame", ""],       		5],
			        [[Scorpion, 	"Basegame", ""],       		3],
			        [[GoldScorpion, "Basegame", ""],        	1]
				])
				break;
			}
			case "Sewers": {
				var _portalObject = call(scr.pool, [
			        [[Rat,			"Basegame", ""],    		10],
			        [[FrogEgg, 		"Basegame", ""],        	7],
			        [[Gator, 		"Basegame", ""],        	7],
			        [[Ratking,		"Basegame", ""],			5],
			        [[BuffGator, 	"Basegame", ""],       		3],
			        [[SuperFrog,	"Basegame", ""],       		2],
			       	[["Paintor_create",	"MOD", "Frontier_Objects"], 1],
			        [["Cat",		"OBJ", "telib"],			(4 * mod_exists("mod", "ntte"))]
				])
				break;
			}	
			case "Scrapyards": {
				var _portalObject = call(scr.pool, [
			        [[Raven,		"Basegame", ""],    		12],
			        [[MeleeBandit,	"Basegame", ""],			6],
			        [[Salamander, 	"Basegame", ""],        	5],
			        [[Sniper, 		"Basegame", ""],       		5],
			        [[Car, 			"Basegame", ""],       		3]
				])
				break;
			}
			case "Crystal Caves": {
				var _portalObject = call(scr.pool, [
			        [[Spider,		"Basegame", ""],    		12],
			        [[LaserCrystal,	"Basegame", ""],			6],
			        [["Mortar", 	"OBJ", "telib"],        	(4 * mod_exists("mod", "ntte"))]
				])
				break;
			}
			case "Frozen City": {
				var _portalObject = call(scr.pool, [
			        [[SnowBot,		"Basegame", ""],    		10],
			        [[Wolf,			"Basegame", ""],			10],
			        [[SnowTank,		"Basegame", ""],			4],
			        [[GoldSnowTank,	"Basegame", ""],			1],
			        [[Bandit,		"Basegame", "Snow"],		3]
				])
				break;
			}
			case "Labs": {
				var _portalObject = call(scr.pool, [
			        [[Freak,		"Basegame", ""],    		10],
			        [[ExploFreak,	"Basegame", ""],			7],
			        [[RhinoFreak,	"Basegame", ""],			4],
			        [[Necromancer,	"Basegame", ""],			2]
				])
				break;
			}
			case "Palace": {
				var _portalObject = call(scr.pool, [
			        [[Guardian,		"Basegame", ""],    		10],
			        [[ExploGuardian,"Basegame", ""],			7],
			        [[DogGuardian,	"Basegame", ""],			5],
			        [["PortalGuardian",	"OBJ", "telib"],		(2 * mod_exists("mod", "ntte"))],
			        [["GupGuardian_create",	"MOD", "Frontier_Palace"],	3]
				])
				break;
			}
			case "Oasis": {
				var _portalObject = call(scr.pool, [
			        [[BoneFish,		"Basegame", ""],    		12],
			        [[Crab,			"Basegame", ""],			5],
			        [["Diver",		"OBJ", "telib"],			(3 * mod_exists("mod", "ntte"))],
				])
				break;
			}
			case "Pizza": {
				var _portalObject = call(scr.pool, [
			        [[PizzaBox,		"Basegame", ""],    		60],
			        [[Turtle,		"Basegame", ""],    		4],
			        [[Rat,			"Basegame", ""],			1]
				])
				break;
			}
			case "Mansion": {
				var _portalObject = call(scr.pool, [
			        [[Molefish,		"Basegame", ""],    		12],
			        [[Molesarge,	"Basegame", ""],			7],
			        [[FireBaller,	"Basegame", ""],			6],
			        [[SuperFireBaller, "Basegame", ""],			3],
			        [[Jock, 		"Basegame", ""],			3]
				])
				break;
			}
			case "Cursed Caves": {
				var _portalObject = call(scr.pool, [
			        [[InvSpider,	"Basegame", ""],    		12],
			        [[InvLaserCrystal, "Basegame", ""],			6],
			        [["InvMortar", 	"OBJ", "telib"],        	4]
				])
				break;
			}
			case "Jungle": {
				var _portalObject = call(scr.pool, [
			        [[Bush,			"Basegame", ""],    		5],
			        [[JungleBandit,	"Basegame", ""],			15],
			        [[JungleAssassin, "Basegame", ""],			6],
			        [[JungleFly,	"Basegame", ""],			3]
				])
				break;
			}
			case "Cove": {
				var _portalObject = call(scr.pool, [
			        [["Parrot_create",		"MOD", "Frontier_Caves"],    	20],
			        [["Whale_create",		"MOD", "Frontier_Caves"],		9],
			        [["EliteWhale_create", "MOD", "Frontier_Caves"],		3],
			        [["Starfish_create",	"MOD", "Frontier_Caves"],		12],
			        [["EliteStarfish_create",	"MOD", "Frontier_Caves"], 6]
				])
				break;
			}
			case "Robocenter": {
				var _portalObject = call(scr.pool, [
			        [["Swarmbot_create",	"MOD", "Frontier_Labs"],    	10],
			        [["MissileDrone_create","MOD", "Frontier_Labs"],		2],
			        [["Engineer_create",	"MOD", "Frontier_Labs"],		4]
				])
				break;
			}
			case "Coast": {
				var _portalObject = call(scr.pool, [
			        [["Gull", 		"OBJ", "telib"],        	17],
			        [["Pelican", 	"OBJ", "telib"],        	4],
			        [["Diver", 		"OBJ", "telib"],        	9],
			        [["TrafficCrab", "OBJ", "telib"],        	7]
				])
				break;
			}
			case "Lair": {
				var _portalObject = call(scr.pool, [
			        [["Cat", 		"OBJ", "telib"],        	12],
			        [["Bat", 		"OBJ", "telib"],        	6],
			        [[Rat, 			"Basegame", ""],        	17]
				])
				break;
			}
			case "Warp Zone": {
				var _portalObject = call(scr.pool, [
			        [["RedSpider", 	"OBJ", "telib"],        	18],
			        [["CrystalBrain", "OBJ", "telib"],        	5]
				])
				break;
			}
			case "Undergrowth": {
				var _portalObject = call(scr.pool, [
			        [["Firefly", 		"OBJ", "undergrowth"], 		20],
			        [["PitcherPlant",	"OBJ", "undergrowth"], 		9],
			        [["Flytrap",		"OBJ", "undergrowth"], 		5],
			        [["GoldPitcherPlant", "OBJ", "undergrowth"],	1]
				])
				break;
			}
		}

		switch(_portalObject[1]){
			case "Basegame": {
				with(instance_create(x, y + 10, _portalObject[0])){
					 // Hiiiii snow bandits:
					if(_portalObject[2] = "Snow"){
						spr_idle	= sprSnowBanditIdle;
						spr_walk	= sprSnowBanditWalk;
						spr_hurt	= sprSnowBanditHurt;
						spr_dead	= sprSnowBanditDead;
						spr_weap	= sprSnowBanditGun;
					}
					
					image_xscale	= 0.3;
					image_yscale	= image_xscale;
					
					with(mod_script_call("mod", "Frontier_Objects", "ZAxisToss_create", x, y)){
						portalGuy	 = true;
						direction    = random(360);
						speed        = random_range(2, 4);
						zspeed       = 9;
						zfriction	 = 0.7;
						creator      = other;
						depth        = other.depth;
						mask_index   = other.mask_index;
						if("spr_shadow_y" in other ){
							spr_shadow_y = other.spr_shadow_y;
						}
					}
					mask_index	= mskNone;
				}
			}
			break;
			case "MOD": {
				with mod_script_call("mod", _portalObject[2], _portalObject[0], x, y + 10){
					image_xscale	= 0.3;
					image_yscale	= image_xscale;
					with(mod_script_call("mod", "Frontier_Objects", "ZAxisToss_create", x, y)){
						portalGuy	 = true;
						direction    = random(360);
						speed        = random_range(2, 4);
						zspeed       = 9;
						zfriction	 = 0.7;
						creator      = other;
						depth        = other.depth;
						mask_index   = other.mask_index;
						if("spr_shadow_y" in other ){
							spr_shadow_y = other.spr_shadow_y;
						}
					}
					mask_index	= mskNone;
				}
			}
			break;
			case "OBJ": {
				with mod_script_call("mod", _portalObject[2], "obj_create", x, y + 10, _portalObject[0]){
					image_xscale	= 0.3;
					image_yscale	= image_xscale;
					with(mod_script_call("mod", "Frontier_Objects", "ZAxisToss_create", x, y)){
						portalGuy	 = true;
						direction    = random(360);
						speed        = random_range(2, 4);
						zspeed       = 9;
						zfriction	 = 0.7;
						creator      = other;
						depth        = other.depth;
						mask_index   = other.mask_index;
						if("spr_shadow_y" in other ){
							spr_shadow_y = other.spr_shadow_y;
						}
					}
					mask_index	= mskNone;
				}
			}
			break;
		}
		
		 // End Portal:
		if(--ammo <= 0){
			portalDone		= true;
			sprite_index	= spr_gone;
		}
	}
	
	//#region HOARDER SPAWNING
#define HoarderSpawn_area		return [1, 2, 3, 4, 5, 6, 7, 104, 105, "cove", "graveyard", "robocenter", "coast"]
#define HoarderSpawn_chance		return (GameCont.area = 7 && GameCont.subarea = 3) ? 0 : (GameCont.fr_hoarderLoop = GameCont.loops) ? 0 : 0.03;
#define HoarderSpawn_hard		return 5;
#define HoarderSpawn_create
	HoarderSpawner_create(10016, 10016);
	
#define HoarderSpawner_create(_x, _y)
	with(instance_create(_x, _y, CustomObject)){
		name = "fr_hoarderSpawner";
		
		tries		= 0;
		maxTries	= 30; 
		hoarderSpawned	= false;
		
		on_step 	= HoarderSpawner_step;
		
		return self;
	}
	
#define HoarderSpawner_step
	 // stop when goal is hit or tried too much.
	if(tries >= maxTries || hoarderSpawned = true){
		instance_destroy();
		exit;
	}
	with(call(scr.instance_random, instances_matching(FloorNormal, "fr_hoarderSpawn", null))){
		fr_hoarderSpawn = true;
		if(distance_to_point(10016, 10016) > 256){
			with(mod_script_call("mod", "Frontier_Objects", "Hoarder_create", x + 16, y + 16)){
				if(place_meeting(x, y, Wall)){
					with(instance_create(x, y, PortalClear)){
						image_xscale = 0.5;
						image_yscale = image_xscale;
					}
				}
			}
			other.hoarderSpawned = true;
			GameCont.fr_hoarderLoop = GameCont.loops;
		}
		other.tries += 1;
	}

	//#endregion


	//#region PLAGUE OF FLESH
#define FleshPlague_area		return [1, 2, 3, 4, 7]; // Main Path Barring Labs and Frocity
#define FleshPlague_chance		return 0//(GameCont.area = 7 and GameCont.subarea = 3) ? 0 : 0.02 + (skill_get('BurdenPlagueOfFlesh') * 1);
#define FleshPlague_hard		return 8;
#define FleshPlague_create
	trace("MEAT")
	
	repeat(2) with(call(scr.instance_random, instances_matching(Floor, "object_index", Floor))){
		if (point_distance(x, y, 10000, 10000) > 128){
			PlagueSpreader_create(x + 16, y + 16)
		}
	}

#define PlagueSpreader_create(_x, _y)

	with instance_create(_x, _y, CustomObject){
		name = "fr_FleshPlagueSpreader"
		
		
		on_step = PlagueSpreader_step
		
		return self;
	}
	
#define PlagueSpreader_step

	 // This doesn't really matter actually since it can't spawn in frocity, im keeping it anyways idc:
	with(SnowFloor){
		if (distance_to_object(other) < 64){
			instance_delete(self);
		}
	}
	 
	 // floor is full of yuckstuff:
	with(Floor){
		if (distance_to_object(other) < 64){
			sprite_index	= global.sprFloorMeat;
			image_speed		= 0.4;
			material		= 4;
			traction		= 2;
			
			 // get goin:
			with(instance_create( x, y, SnowFloor)){
					sprite_index = global.sprSnowFloorMeat;
					image_index  = other.image_index;
					image_speed  = 0.4;
					image_angle += random_range(-1, 1);
			}
			
			if (random(40) < 1) and !place_meeting(x + 16, y + 16, prop){
				BloodCocoon_create(x + 16, y + 16)
			}
		}
	}
	
	 // cleanup:
	with(Detail){
		if (distance_to_object(other) < 64){
			instance_delete(self);
		}
	}
	
	 // THE FORBIDDEN ONE:
	with(Cactus){
		if (distance_to_object(other) < 64){
			spr_idle		= global.sprBloodCactus;
			spr_hurt		= global.sprBloodCactusHurt;
			spr_dead		= global.sprBloodCactusDead;
		}
	}
	
	 // Bones!
	with(Bones){
		if (distance_to_object(other) < 72){
			sprite_index	= global.sprMeatBones;
			image_index 	= irandom(image_number);
		}
	}
	
	 // ew look what you did my walls are all covered in this stuff whats wrong with you:
	with(Wall){
		if (distance_to_object(other) < 72){
			sprite_index	= global.sprWallMeatBot;
			topspr			= global.sprWallMeatTop;
			outspr			= global.sprWallMeatOut;
			
			
			 // BoooOOooOOoooOoones:
			if (random(3) < 1){
				var boneflip = choose(0, 16)
				with instance_create(x + boneflip, y, Bones){
					sprite_index	= global.sprMeatBones;
					image_index 	= irandom(image_number);
					if (boneflip = 0){ image_xscale = -1; }
				}
			}
		}
	}
	
	instance_destroy();

//#endregion

	// Debug event for testing prop spawns and some stuff with particles - gonna make a blizzard event with it probably, delete later.
#define DebugEvent1_area		return [1, 2, 3, 4, 5, 6, 7, "graveyard", "robocenter", "cove"]
#define DebugEvent1_chance		return 0.0005;
#define DebugEvent1_create
	debugActivated	= false;
	debugTimer		= 120;
	
	/*
	with(Floor){
		if(random(40) < 1){
			with instance_create(x, y, Cactus){
				sprite_index = choose(sprBarrel, sprBigFishFire);
				image_blend	 = choose(c_red, c_black);
			}
		}
	}
	*/

#define DebugEvent1_step
	if(debugTimer > 0){
		debugTimer -= current_time_scale;
	}
	if(debugActivated = false && debugTimer <= 0){
		if(random(10) < 1){
			with(instances_matching(Player, "index", 0)){ 
				 // move this from the boss file to devzone later if u need it again and didn't delete it yet - im tired rn.
				mod_script_call("mod", "Frontier_Bosses", "DebuggingObject_create", x + 400, y + random_range(-40, 40));
			}
			debugActivated = true;
		}
	}

//#region DESERT EVENTS
//#region METEOR SHOWER
#define MeteorShower_text		return (global.settingEventText = false) ? undefined : choose("A GIFT FROM THE STARS", "MOONLIGHT");
#define MeteorShower_area		return 1;
#define MeteorShower_chance		return (global.settingNightLoops) ? global.nightLoop : 
									!(GameCont.subarea = 1) && (global.nightCredits = 0) || (mod_exists("area", "scorpionboss"))? 0 
									: global.settingNightEventSpawnChance + ((crown_current = "storms") * 0.25) + (global.nightCredits > 0);
#define MeteorShower_hard		return 0; // can appear on 1-1
#define MeteorShower_setup

	 // Night Credits:
	if(GameCont.subarea = 1){
		global.nightCredits += 1;
	}
	
	global.isNight = true;
	
	 // this was here since originally it started on 1-2 instead of 1-1 if it was preloop
	/*
	if(GameCont.subarea = 2){
		global.nightCredits += 1;
	}
	*/
	
	 // Stop v9944 RadioActive from playing:
	if(mod_exists("mod", "radioactive")){
		if(mod_variable_exists("mod", "radioactive", "menuhandler")){
			if(fork()){
				wait(1);
				mod_variable_set("mod", "radioactive", "track_found", false);
				exit;
			}
		}
	}
	
	// Play Music:
	var _EventMusic = global.musDesertNight;
	if(!audio_is_playing(_EventMusic)){ 
		sound_play_music(_EventMusic); 
	}
	if(fork()){ // v100 60fps i hate you i hate you
		wait(1);
		if(!audio_is_playing(_EventMusic)){ 
			sound_play_music(_EventMusic); 
		}
		exit;
	}

	global.eventMusicPlaying = true;
	
	
	 // Resprite:
	script_bind_end_step(MeteorShower_applysprites, 0);
		
#define MeteorShower_create
	
	 // Dropdown:
	if(GameCont.subarea = 1){
		if(global.settingEventDropdowns = true){
			if(global.settingNightLoops = false){
				EventDropdown_queue(1, 0, global.sndEventIntroNight);
			}
		}
	}
	
	 // Half-Dark:
	with(instance_create(0, 0, CustomObject)){
		name = "fr_area_halfdark"
	}
	
	global.pickupMeteorFalls	= 0;
	global.maxPickupMeteors 	= 6 + (3 * GameCont.loops);
	compatCheck					= false;
	compatTimer					= 10;
	
    sprite_replace(sprWind, "sprites/particles/sprWindNightEvent.png", 9);

	// Scary!!
	with(TopCont) {
		darkness = 1;
	}
	
	// Back Color:
	background_color = make_color_rgb(106, 122, 175);

	// Set Night Sprites:
	with([Floor, FloorExplo, Wall, Top, TopSmall, Debris, Detail, Bones, prop, TopPot, Bones]) {
		if(instance_exists(self)) with(self) {
			fr_meteorshower_check = true;
			MeteorShower_sprite_set(object_index);
		}
	}
		
	// Replace Objects:
	with(instances_matching(Cactus, "spr_idle", sprCactus, sprCactus2, sprCactus3, sprCactusB, sprCactusB2, sprCactusB3)){
		instance_create(x, y, NightCactus)    	
        instance_delete(self);
    }
	with(BonePile){
		instance_create(x, y, BonePileNight)    	
        instance_delete(self);
    }
	with(TopDecalDesert){
		instance_create(x, y, TopDecalNightDesert)    	
        instance_delete(self);
    }
     
     // Big Skull:
	with(instances_matching(BigSkull, "spr_idle", sprBigSkullOpen)){
		spr_idle		= global.sprBigSkullOpenNight;
		spr_hurt		= global.sprBigSkullOpenHurtNight;
		spr_dead		= global.sprBigSkullDeadNight;
    }

#define MeteorShower_compatsprite
    
     // Pelagic Predicament Prop Color:
	with(instances_matching(CustomObject, "name", "fr_pelagicbottom")){
		image_blend	= background_color;
    }
		
	 // NT:TE //
    if mod_exists("mod", "ntte"){
    	
    	 // Wall Bandits:
		with(instances_matching(TopPot, "name", "NTTEWallEnemy")){
			sprite_index = global.sprCompatWallBandit;
		}
	
	 	// Scorpion Rock:
		with(instances_matching(CustomProp, "spr_idle", _tespr.ScorpionRock)){
			spr_idle = global.sprCompatScorpionRock;
			spr_hurt = global.sprCompatScorpionRockHurt;
			spr_dead = global.sprCompatScorpionRockDead;
		}
	
		 // Big Cactus:
		with(instances_matching(CustomProp, "spr_idle", _tespr.BigCactusIdle)){
			spr_idle = _tespr.BigNightCactusIdle;
			spr_hurt = _tespr.BigNightCactusHurt;
			spr_dead = _tespr.BigNightCactusDead;
		}
	
		 // Rubble Walls:	
		with (instances_matching(Wall, "topspr", _tespr.Wall1TopRubble)){
			sprite_index = global.sprCompatWall1BotRubble;
			topspr       = global.sprCompatWall1TopRubble;
			outspr       = global.sprCompatWall1OutRubble;
		}
	
		 // ScorpCity:	
		with (instances_matching(Floor, "sprite_index", _tespr.FloorScorpion)){
			sprite_index = global.sprCompatFloorScorpion;
			var scorpcity = true;
		}
		with (instances_matching(SnowFloor, "sprite_index", _tespr.SnowFloorScorpion)){
			sprite_index = global.sprCompatSnowFloorScorpion;
		}
		with (instances_matching(BigSkull, "spr_idle", _tespr.CowSkullIdle)){
			spr_idle = global.sprCompatCowSkullIdle;
			spr_hurt = global.sprCompatCowSkullHurt;
			spr_dead = global.sprCompatCowSkullDead;
			sprite_index = spr_idle;
		}

    	    	 // Big Decals:
		with(instances_matching(Bones, "name", "NTTEBigDecal")){
			sprite_index = global.sprCompatBigTopDecalDesert;

			if(scorpcity){
				sprite_index = global.sprCompatBigTopDecalDesertScorpion;
			}
		}
				
				// Big Fish:
		with(instances_matching(CustomHitme, "sprite_index", _tespr.BigFishBecomeIdle)){
			spr_idle	= global.sprCompatBigFishBecomeIdle;
		}
		NightBigFishController_create(10016, 10016);
		
				// Bandit Camp:
		with(instances_matching(CustomProp, "sprite_index", _tespr.BanditTentIdle)){
			spr_idle	= global.sprCompatBanditTentIdle;
			spr_hurt	= global.sprCompatBanditTentHurt;
			spr_dead	= global.sprCompatBanditTentDead;
		}
		with(instances_matching(CustomProp, "sprite_index", _tespr.BanditTentWallIdle)){
			spr_idle	= global.sprCompatBanditTentWallIdle;
			spr_hurt	= global.sprCompatBanditTentWallHurt;
			spr_dead	= global.sprCompatBanditTentWallDead;
		}
		with(instances_matching(Effect, "sprite_index", _tespr.BanditCampfire)){
			sprite_index	= global.sprCompatBanditCampfire;
		}

		 // Check topsmalls with normal wall sprites for buried vaults:
		with(instances_matching(TopSmall, "sprite_index", sprWall1Top)){
			sprite_index = sprWall0Top;
		}
		 // Also Check TopDecals for them too:
		with(instances_matching(TopDecalDesert, "sprite_index", sprDesertTopDecal)){
			sprite_index = sprNightDesertTopDecal;
		}
    }

	 // DETAILS + //
	if(mod_exists("mod", "Details+")){
		with(instances_matching_ne(Wall, "detailsPlus_mudWall", null)){
			if(sprite_index	= sprWall0Bot){
				sprite_index	= global.sprWall1BotBNight;
			}
		}
		
	     // Proto Statue Decal:
		with(instances_matching(CustomObject, "name", "detailsPlus_ProtoStatueDecal")){
			spr_idle		= global.sprDesertProtoStatueDecalNight;
			spr_dead		= global.sprDesertProtoStatueDecalDeadNight;
			sprite_index	= spr_idle;
	    }
	    
	     // Newww Muddd
	    with(instances_matching(Floor, "detailsPlus_isMud", true)){
	    	sprite_index = global.sprDetailsPlusFloorDesertBOutNight;
	    }
	    with(instances_matching(SnowFloor, "detailsPlus_isMud", true)){
	    	sprite_index = global.sprDetailsPlusSnowFloorDesertBNight;
	    }
	    
	     // B Details:
	    with(instances_matching(Detail, "detailsPlus_altDetail", true)){
	    	sprite_index	= global.sprDetailsPlusDetailDesertBNight;
	    }
	    
	     // B Floor details:
	    with(instances_matching(Effect, "detailsPlus_bdetail", true)){
	    	sprite_index = (detailsPlus_bdetailBig = true) ? global.sprDetailsPlusDetailDesertMudBigNight : global.sprDetailsPlusDetailDesertMudBNight;
	    }
	}
	
	 // VAGABONDS //
	if(mod_exists("mod", "vagabonds_master")){
		with(instances_matching(Cactus, "spr_idle", _vagabondsspr.Cactaur_FakeIdle)){
			spr_idle = global.sprCompatCactuarFake;
			spr_hurt = global.sprCompatCactuarFakeHurt;
			spr_dead = global.sprCompatCactuarFakeDead;
		}
		with(instances_matching(Cactus, "spr_idle", _vagabondsspr.TinyCactaur_Fake1Idle)){
			spr_idle = global.sprCompatTinyCactuarFake;
			spr_hurt = global.sprCompatTinyCactuarFakeHurt;
			spr_dead = global.sprCompatTinyCactuarFakeDead;
		}
		with(instances_matching(Cactus, "spr_idle", _vagabondsspr.TinyCactaur_Fake2Idle)){
			spr_idle = global.sprCompatTinyCactuarFake2;
			spr_hurt = global.sprCompatTinyCactuarFake2Hurt;
			spr_dead = global.sprCompatTinyCactuarFakeDead;
		}
		with(instances_matching(Cactus, "spr_idle", _vagabondsspr.TinyCactaur_Fake3Idle)){
			spr_idle = global.sprCompatTinyCactuarFake3;
			spr_hurt = global.sprCompatTinyCactuarFake3Hurt;
			spr_dead = global.sprCompatTinyCactuarFake3Dead;
		}
		// Vagabonds Spawns more Cacti so run this again:
		with(instances_matching(Cactus, "spr_idle", sprCactus, sprCactus2, sprCactus3, sprCactusB, sprCactusB2, sprCactusB3)){
			instance_create(x, y, NightCactus);	
        	instance_delete(self);
    	}
	}

#define MeteorShower_cleanup

	 // Night Credits:
	if(GameCont.area != 1) && (GameCont.area != 100){
		global.nightCredits = 0;
	}
	
	wait(2);
	if(fork()){
		while(instance_exists(mutbutton)){ wait(1); }
		if(!(call(scr.event_get_active, "MeteorShower"))){
			if(GameCont.area = 1){
				if(GameCont.proto = 1){
					sound_play_music(mus1b);	
				} else {
					sound_play_music(mus1);
				}
				global.eventMusicPlaying = false;
			}
		}
		exit;
	}
	sprite_restore(sprWind)
	global.isNight	= false;
	
#define MeteorShower_step

	 // Run compat sprites on a delay to avoid issues with mod load order:
	if(compatCheck = false){
		compatTimer -= current_time_scale;
		if(compatTimer <= 0){
			compatCheck = true;
			MeteorShower_compatsprite();
		}
	}

	 // you would not believe your eyes
	if (random(10) < current_time_scale){ 
		with (call(scr.instance_random, Floor)){ 
			instance_create(x, y, FireFly) 
		} 
	}

	 // MeteorFall
	if(random(100) < current_time_scale){ 
		with (call(scr.instance_random, FloorNormal)){ 
			FallenStar_create(x + 16, y + 16) 
		} 
	}

	if(global.pickupMeteorFalls > global.maxPickupMeteors){
		if(random(100) < current_time_scale){ 
			with(call(scr.instance_random, FloorNormal)){ 
				PickupStar_create(x + 16, y + 16);
				global.pickupMeteorFalls += 1;
			} 
		}
	}
	
	 // Big Skull:
	with(instances_matching(BigSkull, "spr_idle", sprBigSkull)){
		spr_idle		= global.sprBigSkullNight;
		spr_hurt		= global.sprBigSkullHurtNight;
		spr_dead		= global.sprBigSkullDeadNight;
	}

	 // TE compat - needs to run in step for rock:
	if(mod_exists("mod", "ntte")){
		
		 // Scorpion Rock:
		with(instances_matching(CustomProp, "spr_idle", global.sprCompatScorpionRock)){
			if (friendly && spr_idle == global.sprCompatScorpionRock){
				spr_idle		= global.sprCompatScorpionRockAlly;
				sprite_index	= spr_idle;
				image_index 	= 0;
			}
		}
	}


#define MeteorShower_applysprites
	with(instances_matching([Floor, FloorExplo, Wall, Top, TopSmall, Debris, Detail, Bones, prop, TopPot], "fr_meteorshower_check", null)) {
		if(instance_exists(self)) with(self) {
			fr_meteorshower_check = true;
			MeteorShower_sprite_set(object_index);
		}
	}

#define MeteorShower_sprite_set(_obj)
	switch(_obj) {
		case Floor:
			switch(area_current[0]) {
				default: if(!styleb) and (sprite_index = sprFloor1) sprite_index = sprFloor0;
				if(styleb) and (sprite_index = sprFloor1B) sprite_index = global.sprFloor1BNight;
				break;
			}
		break;
		
		case FloorExplo:
			switch(area_current[0]) {
				default: 
					sprite_index = sprFloor0Explo;
				break;
			}
		break;
		
		case Wall:
			switch(area_current[0]) {
				default: 
					if (sprite_index  = sprWall1Bot){
						sprite_index = sprWall0Bot;
						outspr		 = sprWall0Out;
						topspr       = sprWall0Top;
					}
				break;
			}
		break;
		
		case Top:
			switch(area_current[0]) {
				default: if (sprite_index = sprWall1Top) sprite_index = sprWall0Top; break;
			}
		break;
		
		case TopSmall:
			switch(area_current[0]) {
				default: sprite_index = sprWall0Trans; break;
			}
		break;
		
		case Debris:
			if(sprite_index = sprDebris1) sprite_index = sprDebris0;
		break;

	
		case Detail:
			if (sprite_index = sprDetail1){
				sprite_index = sprDetail0;
			}
		break;
		
		case Bones:
			if (sprite_index = sprBones){
				sprite_index = sprNightBones;
			}
		break;
	
	}
	
#define NightBigFishController_create(_x, _y)
	with(instance_create(_x, _y, CustomObject)){
		name = "fr_NightBigFishController";
		
		on_step = NightBigFishController_step;
		
		return self;
	}

#define NightBigFishController_step
	with(instances_matching(instances_matching(enemy, "bossname", "BIG FISH"), "fr_bigFishCheck", null)){
		fr_bigFishCheck = true;
		spr_spwn		= global.sprCompatBigFishSpwn;
		spr_dive    	= global.sprCompatBigFishLeap;
		spr_rise    	= global.sprCompatBigFishRise;
		sprite_index	= spr_spwn;
	}

//#endregion
//#region SOLAR SHOWER
#define SolarShower_text		return "HOT HOT HOT HOT HOT!"
#define SolarShower_area		return 1;
#define SolarShower_chance		return 0 //(call(scr.event_get_active, "MeteorShower")) ? 0 : 0.1 + ((crown_current = "storms") * 0.45); // Daytime Exclusive

#define SolarShower_create
	solarshowerCooldown = 60;
	
	script_bind_draw(SolidColorFog_add, -12, make_colour_rgb(255, 90, 0), 0.20);
	
#define SolarShower_step

		// Prevents getting blasted right away:
    if(solarshowerCooldown >= 0){ 
    	solarshowerCooldown -= current_time_scale;
    }

		// Should it be goin?
    if instance_exists(enemy) && (solarshowerCooldown <= 0) || instance_exists(BigMaggotBurrow) && (solarshowerCooldown <= 0){

		 // FLARED:
		if (random(8) < 1){ 
			with (call(scr.instance_random, Floor)){
				if (distance_to_object(ProtoStatue) > 64 && distance_to_object(Player) < 124){ 
					SolarFlareSpawn_create(x + random_range(-32, 32), y) 
				} 
			}
		}
    }

//#endregion
//#endregion
//#region SEWERS EVENTS

//#region CASINO
//#define Casino_text			return (global.settingEventText = false) ? undefined : "SPIN 2 WIN";
#define Casino_area				return [2, "sewers"];
#define Casino_chance			return ((mod_exists("area", "scorpionboss")) ? 0.05 : 0.25) + (((mod_exists("area", "scorpionboss")) ? 0.05 : 0.25) * skill_get(mut_rabbit_paw));
#define Casino_setup
	global.casinoMusic	= sound_loop(global.musCasino);
	sound_volume(global.casinoMusic, 0);
	global.sewerMusic	= -4;
		
	 // v100 Music Controls:
	if(global.settingVeeOneHundred = true){

		 // Takeover music during Portal:
		var _sewerTune = MusCont.song;

		if!(audio_is_playing(global.sewerMusic)){
			if(_sewerTune != sndBossWin){
				sound_stop(_sewerTune);
				global.sewerMusic = sound_loop(_sewerTune);
			}
		}		
		
	} else {
		 // ooouuuuhhhh its hooirrrribllleeeeee
		CasinoMusicHandler_create(0, 0);
	}


#define Casino_create
	GameCont.fr_casinoAlert = false;
	with(call(scr.array_shuffle,(FloorNormal))){
		if(!place_meeting(x, y, Wall)){
			var	_fx     = bbox_center_x,
				_fy     = bbox_center_y,
				_w      = 5 * 32,
				_h      = 3 * 32,
				_ang    = 90 * irandom(3),
				_border = 32,
				_end    = false;
				
			for(var _dir = _ang; _dir < _ang + 270; _dir += 90){
				if(!place_meeting(x + lengthdir_x(32, _dir), y + lengthdir_y(32, _dir), Floor)){
					for(var _dis = _border + choose(32, 64, 96); _dis >= _border; _dis -= 32){
						var	_hallXOff = lengthdir_x(_dis - _border, _dir + 180),
							_hallYOff = lengthdir_y(_dis - _border, _dir + 180),
							_cx = _fx + lengthdir_x(16 + _dis + (_w / 2), _dir),
							_cy = _fy + lengthdir_y(16 + _dis + (_h / 2), _dir);
							
						if(!collision_rectangle(
							_cx - (_w / 2) - _border + min(0, _hallXOff),
							_cy - (_h / 2) - _border + min(0, _hallYOff),
							_cx + (_w / 2) + _border + max(0, _hallXOff) - 1,
							_cy + (_h / 2) + _border + max(0, _hallYOff) - 1,
							Floor,
							false,
							false
						)){
							 // Floors:
							call(scr.floor_fill, _cx, _cy, _w / 32, _h / 32, "");
						
						
							// Entrance Hallway:
							for(var _l = _border; _l <= _dis; _l += 32){
								with(call(scr.floor_set, _fx - 16 + lengthdir_x(_l, _dir), _fy - 16 + lengthdir_y(_l, _dir), true)){
								}
							}
							
							 // Props:
							other.x = _cx;
							other.y = _cy;
							
							 // Floor:
							 with(CasinoCarpet_create(other.x, other.y)){
							
								 // Slot Machine:
								mod_script_call("mod", "Frontier_Sewers", "CasinoSlotMachine_create", x - 48, y - 38);
							
								 // Counter:
								with(mod_script_call("mod", "Frontier_Sewers", "Counter_create", x + 48, y - 25)){
									mod_script_call("mod", "Frontier_Sewers", "BartenderGator_create", x - 7, y - 14);
									mod_script_call("mod", "Frontier_Sewers", "CasinoSoda_create", 	x + 9, y - 14, self);
									mod_script_call("mod", "Frontier_Sewers", "CasinoSoda_create", 	x + 16, y - 15, self);
									mod_script_call("mod", "Frontier_Sewers", "CasinoSoda_create", 	x + 23, y - 16, self);
								}
								
								 // Couch:
								with(mod_script_call("mod", "Frontier_Sewers", "Couch_create", x + 48, y + 36)){
									mod_script_call("mod", "Frontier_Sewers", "CouchgoerGator_create", x + 8, y - 14);
									mod_script_call("mod", "Frontier_Sewers", "CouchgoerCat_create",	x - 9, y - 14);
								}
								
								 // TV:
								mod_script_call("mod", "Frontier_Sewers", "CasinoTV_create", x + 42, y + 4);
							}
							_end = true;
							break;
						}
					}
					if(_end) break;
				}
			}
			if(_end) break;
		}
	}

#define Casino_cleanup
	 // Cut that Out:
	if(audio_is_playing(global.casinoMusic)){
		sound_stop(global.casinoMusic);
	}
	if(audio_is_playing(global.sewerMusic)){
		sound_stop(global.sewerMusic);
	}

 // keeping here instead of Frontier_Sewers because it needs the global var
#define CasinoCarpet_create(_x, _y)
	with(instance_create(_x, _y, CustomObject)){
		name = "fr_CasinoCarpet";
		
		 // Visuals:
		sprite_index	= global.sprCasinoFloor;
		depth			= 8;
		
		on_step 		= (global.settingVeeOneHundred = true) ? CasinoCarpetV100_step : nothing;
		
		return self;
	}
	
#define CasinoMusicHandler_create(_x, _y)
	with(instance_create(_x, _y, CustomObject)){
		name		= "fr_casinoMusicHandler";
		
		sewerTune		= mod_exists("mod", "radioactive") ? mod_variable_get("mod", "radioactive", "ra2")			: mus2;
		
		ballMumTrack	= mod_exists("mod", "radioactive") ? mod_variable_get("mod", "radioactive", "raballMom")	: musBoss5;
		deadMumTrack	= mod_exists("mod", "radioactive") ? mod_variable_get("mod", "radioactive", "rabossDead")	: musBossDead;
		
		tesseract		= false;
		tinnitusStopper	= false;
		moved			= false;
		
		if(mod_exists("mod", "ntte")){
			tesseract = true;
			tesseractTrack		= _temus.Tesseract;
		}
		if(mod_exists("mod", "radioactive")){
			if(mod_variable_exists("mod", "radioactive", "menuhandler")){
				tinnitusStopper = true;
			}
		}
		
		mask_index		= global.sprCasinoFloor;
		
		sound_play_music(global.sndBlank);
		global.sewerMusic	= sound_loop(sewerTune);

		on_step 	= CasinoMusicHandler_step;
		
		return self;
	}
	
#define CasinoMusicHandler_step

	if(moved = false){
		if(array_length(instances_matching(CustomObject, "name", "fr_CasinoCarpet")) > 0){
			var _carpet = call(scr.instance_nearest_array, x, y, instances_matching(CustomObject, "name", "fr_CasinoCarpet"));
			x = _carpet.x;
			y = _carpet.y;
			moved = true;
		}
	}
	
	 // its the only way.
	if(tinnitusStopper){
		with(instances_matching(FrogQueen, "intro", 1)){
			intro = 2;
		}
	}

	 // DIE MUSIC DIE
	if(!audio_is_playing(sndBossWin)){
		if(!audio_is_playing(global.sndBlank)){
			  // Ballmum
			if((audio_is_playing(musBoss5) || (audio_is_playing(ballMumTrack))) && sewerTune != ballMumTrack){
				sewerTune = ballMumTrack;
				sound_stop(global.sewerMusic)
			}
			 // Tesseract:
			 // doesn't do the cool intro part but I should already get a medal for supporting this at all
			if(tesseract){
				if(audio_is_playing(tesseractTrack) && sewerTune != tesseractTrack){
					sewerTune = tesseractTrack;
					sound_stop(global.sewerMusic);
				}
			}
			
			sound_play_music(global.sndBlank);
		}
	} else {
		 // only boss dead can start when win sound is on:
		if(sewerTune != deadMumTrack){
			sewerTune = global.sndBlank2;
			sound_stop(global.sewerMusic);
		}
	}
	
		 // i can't believe shes dead:
	if((audio_is_playing(musBossDead) || (audio_is_playing(deadMumTrack))) && sewerTune != deadMumTrack){
		sewerTune = deadMumTrack;
		sound_stop(global.sewerMusic)
		global.sewerMusic = sound_loop(sewerTune);
		sound_play_music(global.sndBlank);
	}

	if(!audio_is_playing(global.sewerMusic)){
		if(sewerTune != null){
			sound_stop(sewerTune);
			global.sewerMusic = sound_loop(sewerTune);
		}
	}

	 // Only host gets to control music, sorry!
	with(instances_matching(Player, "index", 0)){
		if(!collision_line(x, y, other.x, other.y, Wall, false, false)){
			var _dis = distance_to_object(other);
			var _arcade_max = 70;
			var _sewer_max = 20;
			var _arcade_vol = (_arcade_max - _dis) / _arcade_max;
			var _sewer_vol = (_sewer_max - _dis) / _sewer_max;

			if(_dis > 40){
				global.music_setting = max(audio_sound_get_gain(other.sewerTune), 0);
			}
			sound_volume(global.sewerMusic, clamp(_sewer_vol * -1, 0, 1));
			sound_volume(global.casinoMusic, clamp(_arcade_vol * global.music_setting, 0, 1));
		}
		else{
			global.music_setting = max(audio_sound_get_gain(other.sewerTune), 0);
			sound_volume(global.sewerMusic, 1);
			sound_volume(global.casinoMusic, 0);
		}
	}
	
#define CasinoCarpetV100_step

	 // Music:
	var _sewerTune = MusCont.song;

	if!(audio_is_playing(global.sewerMusic)){
		if(_sewerTune != sndBossWin){
			sound_stop(_sewerTune);
			global.sewerMusic = sound_loop(_sewerTune);
		}
	}	
	
	 // Only host gets to control music, sorry!
	with(instances_matching(Player, "index", 0)){
		if(!collision_line(x, y, other.x, other.y, Wall, false, false)){
			var _dis = distance_to_object(other);
			var _arcade_max = 70;
			var _sewer_max = 20;
			var _arcade_vol = (_arcade_max - _dis) / _arcade_max;
			var _sewer_vol = (_sewer_max - _dis) / _sewer_max;
				
			if(_dis > 40){
				global.music_setting = max(audio_sound_get_gain(_sewerTune), 0);
			}
			sound_volume(global.sewerMusic, clamp(_sewer_vol * -1, 0, 1));
			sound_volume(global.casinoMusic, clamp(_arcade_vol * global.music_setting, 0, 1));
		}
		else{
			global.music_setting = max(audio_sound_get_gain(_sewerTune), 0);
			sound_volume(global.sewerMusic, 1);
			sound_volume(global.casinoMusic, 0);
		}
	}
	
//#endregion
//#region PAINTOR CAMP
#define PaintorCamp_area			return [2, "sewers", 102, "lair", 3, "scrapyard", 4, 6, "labs", 7, "palace", "cove", "robocenter"];
#define PaintorCamp_chance			return (GameCont.area = 7 && GameCont.subarea = 3) ? 0 : global.settingPaintorCampEventSpawnChance + ((crown_current = "crime") * 0.03);
#define PaintorCamp_create
	PaintorCampSpawner_create(10016, 10016); // Doing this in an object instead of event step so it deletes itself when done.
	
#define PaintorCampSpawner_create(_x, _y)
	with(instance_create(_x, _y, CustomObject)){
		name = "fr_paintorCampSpawner";
		
		tries		= 0;
		maxTries	= 30; 
		gatorGoal	= 3 + irandom(2) + GameCont.loops;
		
		on_step 	= PaintorCampSpawner_step;
		
		return self;
	}
	
#define PaintorCampSpawner_step
	 // stop when goal is hit or tried too much.
	if(tries >= maxTries || gatorGoal <= 0){
		instance_destroy();
		exit;
	}
	with(call(scr.instance_random, instances_matching(FloorNormal, "fr_paintorSpawned", null))){
		if(distance_to_point(10016, 10016) > 192){
			fr_paintorSpawned = true;
			with(mod_script_call("mod", "Frontier_Sewers", "Paintor_create", x + 16, y + 16)){
				if(place_meeting(x, y, Wall)){
					with(instance_create(x, y, PortalClear)){
						image_xscale = 0.5;
						image_yscale = image_xscale;
					}
				}
			}
			mod_script_call("mod", "Frontier_Sewers", "Graffiti_create", x + 16, y + 16);
			other.gatorGoal -= 1;
		}
		other.tries += 1;
	}

//#endregion
#define SlimyPipes_text			return (global.settingEventText = false) ? undefined : "CLOGGED PIPES";
#define SlimyPipes_chance		return 0.20 * !(call(scr.event_get_active, "Casino"));
#define SlimyPipes_area			return [2, "sewers"];
#define SlimyPipes_create
	/*
	var _maxPipes	= 5;
	with(Floor){
		if(!place_meeting(x, y, Player) || !place_meeting(x, y, chestprop) || !place_meeting(x, y, prop)){
			if(random(30) < 1){
				var myx = x + choose(0, 16);
				var myy = y + choose(0, 16);
				
				if(_maxPipes > 0){
					with(instance_create(myx, myy, Wall)){
						instance_create(x, y, NOWALLSHEREPLEASE)
						if(point_distance(myx, myy, Player.x, Player.y) > 90 && distance_to_object(BigWeaponChest) > 64){
							with(mod_script_call("mod", "Frontier_Objects", "SludgeTrap_create", myx, myy)){
								creator = other;
							}
							_maxPipes -= 1;
							trace(_maxPipes)
						}
					}
				}
			}
		}
	}
	*/
	
	var _maxPipes = 5;
	with(instances_matching(Wall, "fr_SludgeTrap", null)){
		fr_SludgeTrap	= true;
		if(place_meeting(x, y, Floor) && _maxPipes > 0){
			outindex = 0;
			with(mod_script_call("mod", "Frontier_Objects", "SludgeTrap_create", x, y)){
				creator = other;
			}			
			_maxPipes -= 1;
		}
	}
	
//#region SCRAPYARD EVENTS

//#region THUNDERSTORM
#define Thunderstorm_text		return (global.settingEventText = false) ? undefined : choose("STORM A-BREWIN'", "THUNDERSTRUCK");
#define Thunderstorm_area		return [3, "junkyard", "bigdog", "ravenboss"];
#define Thunderstorm_chance		return global.settingThunderstormEventSpawnChance + ((crown_current = "storms") * 0.65);

#define Thunderstorm_setup

	 // Stop v9944 RadioActive from playing:
	if(mod_exists("mod", "radioactive")){
		if(mod_variable_exists("mod", "radioactive", "menuhandler")){
			if(fork()){
				wait(1);
				mod_variable_set("mod", "radioactive", "track_found", false);
				exit;
			}
		}
	}
	
	 // Play Music: (Overrides Scrapyards Night - See Nightyards Setup)
	var _EventMusic = global.musThunderstorm;
	if(!audio_is_playing(_EventMusic)){ 
		sound_play_music(_EventMusic); 
	}
	if(fork()){ // v100 60fps i hate you i hate you
		wait(1);
		if(!audio_is_playing(_EventMusic)){ 
			sound_play_music(_EventMusic); 
		}
		exit;
	}

	global.eventMusicPlaying = true;
	
#define Thunderstorm_create
	
	 // Dropdown:
	if(global.settingEventDropdowns = true){
		EventDropdown_queue(4, 0, global.sndEventIntroWeather);
	}

	 // Half-Dark:
	with(instance_create(0, 0, CustomObject)){
		name = "fr_area_halfdark"
	}
	
	// Franes before lightning starts so you don't get absolutely SMACKED on level start:	
    thunderstormCooldown = 60;
    
    // Adds some lightbeams around for some Ambiance - I could probably disable it on scrapyards night because it doesn't make much sense but its pretty 
    // so im just going to pretend that its moonbeams or something instead
	with(Floor){ 
		if(random(25) < 1) { 
			instance_create(x, y, LightBeam) 
		}
	}
	
	// some little cloud effects, and the darkness effect.
	with(TopCont) {
		TopCont.fog = global.sprFogThunderstorm;
		darkness = 1;
	}

#define Thunderstorm_step

		// Prevents getting striked right away:
    if(thunderstormCooldown >= 0){ 
    	thunderstormCooldown -= current_time_scale 
    }

		// Should it be goin?
    if instance_exists(enemy) && (thunderstormCooldown <= 0) || instance_exists(RavenFly) && (thunderstormCooldown <= 0){
		
		if(current_frame_active){
				// More Rain:
			with(Player){ 
				repeat(random(8 / instance_number(Player))){
					with instance_create(x + random_range(-450, 450), y + random_range(-250, 250), RainDrop){ 
						sprite_index = global.sprRainDropThunderstorm; 
					} 
					repeat(4){ 
						instance_create(x + random_range(-450, 450), y + random_range(-250, 250), RainSplash) 
					}
				}	 
			} 
				
				// More Pain:
			if(random(50) < 1){ 
				with (call(scr.instance_random, Floor)){
					if (distance_to_object(ProtoStatue) > 64 && distance_to_object(Player) < 160){ 
						LightningStrikeSpawn_create(x, y) 
					} 
				}
			}
		}
    }
    
#define Thunderstorm_cleanup

	wait(2);
	if(fork()){
		while(instance_exists(mutbutton)){ wait(1); }
		if !(call(scr.event_get_active, "Thunderstorm")) && !(call(scr.event_get_active, "ScrapyardsNight")) { 
			if(GameCont.area = 3){
				if(GameCont.proto = 1){
					sound_play_music(mus3b);	
				} else {
					sound_play_music(mus3);
				}
				global.eventMusicPlaying = false;
			}
		}
		exit;
	}

//#region NIGHT SCRAPYARDS
#define ScrapyardsNight_text	return (global.settingEventText = false) ? undefined : "FIRELIGHT"
#define ScrapyardsNight_area	return [3, "junkyard", "bigdog", "ravenboss"];
#define ScrapyardsNight_chance	return (global.settingNightLoops) ? global.nightLoop :
									!(GameCont.subarea = 1) && (global.nightCredits = 0) ? 0 : 
									global.settingNightEventSpawnChance + ((crown_current = "storms") * 0.25) + (global.nightCredits > 0);

#define ScrapyardsNight_setup
	
	 // Night Credits:
	if(GameCont.subarea = 1){
		global.nightCredits += 1;
	}
	
	global.isNight = true;

	 // Stop v9944 RadioActive from playing:
	if(mod_exists("mod", "radioactive")){
		if(mod_variable_exists("mod", "radioactive", "menuhandler")){
			if(fork()){
				wait(1);
				mod_variable_set("mod", "radioactive", "track_found", false);
				exit;
			}
		}
	}


			

	// Play Music:
	var _EventMusic = global.musScrapyardsNight;
	if(!(call(scr.event_get_active, "Thunderstorm"))){
		if(!audio_is_playing(_EventMusic)){ 
			sound_play_music(_EventMusic); 
		}
		if(fork()){ // v100 60fps i hate you i hate you
			wait(1);
			if(!audio_is_playing(_EventMusic)){ 
				sound_play_music(_EventMusic); 
			}
			exit;
		}
	}
	global.eventMusicPlaying = true;

	 // Resprite:
	script_bind_end_step(ScrapyardsNight_applysprites, 0)
	
#define ScrapyardsNight_create

	 // Dropdown:
	if(GameCont.subarea = 1){
		if(global.settingEventDropdowns = true){
			if(global.settingNightLoops = false){
				EventDropdown_queue(2, 0, global.sndEventIntroNight);
			}
		}
	}

	 // Half-Dark:
	with(instance_create(0, 0, CustomObject)){
		name = "fr_area_halfdark"
	}
	
	compatCheck					= false;
	compatTimer					= 10;

    // Dark as the night:
	with(TopCont) {
		darkness = 1;
	}
	
	// BG:	
	background_color = make_color_rgb(83, 85, 119);

	// Set Night Sprites:
	with([Floor, FloorExplo, Wall, Top, TopSmall, Debris, Detail, prop, TopPot, Bones, TopDecalScrapyard]) {
		if(instance_exists(self)) with(self){
			fr_scrapyardsnight_check = true;
			ScrapyardsNight_sprite_set(object_index);
		}
	}
	
	with(Trap){
		sprite_index = global.sprTrapNight;
	}
		
	with(TrapScorchMark){
		if(sprite_index = sprTrapScorchMark){
			sprite_index = global.sprTrapScorchMarkNight;
		}
	}
		
	with(Tires){
		spr_idle = global.sprTiresIdleNight;
		spr_hurt = global.sprTiresHurtNight;
		spr_dead = global.sprTiresDeadNight;
	}
		
	with(CarVenus){
		spr_idle = global.sprVenusCarIdleNight;
		spr_hurt = global.sprVenusCarHurtNight;
	}
	

#define ScrapyardsNight_compatsprite

     // Proto Statue Decal:
	with(instances_matching(CustomObject, "name", "detailsPlus_ProtoStatueDecal")){
		spr_idle		= global.sprScrapyardProtoStatueDecalNight;
		spr_dead		= global.sprScrapyardProtoStatueDecalDeadNight;
		sprite_index	= spr_idle;
    }
    
     // Pelagic Predicament Prop Color:
	with(instances_matching(CustomObject, "name", "fr_pelagicbottom")){
		image_blend	= background_color;
    }
    
     // Alt Cove Entrance
 	with(instances_matching(CustomObject, "name", "fr_CoveEntrance")){
		spr_idle		= global.sprScrapyardCoveEntranceClosedNight;
		spr_open		= global.sprScrapyardCoveEntranceOpenNight;
		spr_debris		= global.sprCoveEntranceDebrisNight;
		sprite_index	= spr_idle;
    }   

     // NT:TE //
    if mod_exists("mod", "ntte"){
    	
    	    	 // Big Decals:
		with(instances_matching(Bones, "name", "NTTEBigDecal")){
			sprite_index = global.sprCompatBigTopDecalScrapyard;
		}
		
		 // Sludge Pool:	
		 // we throw all our weapons into the sludge...
		with(instances_matching(CustomObject, "spr_floor", _tespr.SludgePool)){
			with(floors){
				sprite_index = global.sprCompatSludgePool;
			}
		}
		
		 // Alt Top Decal:
		with(instances_matching(TopDecalScrapyard, "sprite_index", _tespr.TopDecalScrapyardAlt)){
			sprite_index = global.sprTopDecalScrapyardNight;
		}
		
		 // Fire Pit:	
		with(instances_matching(CustomObject, "sprite_index", _tespr.TrapSpin)){
			sprite_index = global.sprCompatTrapSpin;
		}
		with(instances_matching(Scorchmark, "sprite_index", _tespr.FirePitScorch)){
			sprite_index = global.sprCompatFirePitScorch;
		}
	
		 // Check topsmalls with normal wall sprites for buried vaults:
		with(instances_matching(TopSmall, "sprite_index", sprWall3Top)){
			sprite_index = global.sprWall3TopNight;
		}
		
		 // Make Sure Floors are textured
		with(instances_matching(Floor, "sprite_index", sprFloor3)){
			sprite_index = global.sprFloor3Night;
		}
		
    }
    
     // VAGABONDS //
    // this doesn't work due to how big wheels are drawn, sorry!
    /*
    if(mod_exists("mod", "vagabonds_master")){
    	with(instances_matching(hitme, "name", "BigWheel")){
    		spr_idle = global.sprCompatBigWheel;
    		spr_walk = global.sprCompatBigWheel;
    		spr_hurt = global.sprCompatBigWheelHurt;
    		spr_dead = global.sprCompatBigWheelDead;
    	}
    }   
   */

#define ScrapyardsNight_applysprites
	with(instances_matching([Floor, FloorExplo, Wall, Top, TopSmall, Debris, Detail, Bones, prop, TopPot], "fr_scrapyardsnight_check", null)){
		if(instance_exists(self)) with(self){
			fr_scrapyardsnight_check = true;
			ScrapyardsNight_sprite_set(object_index);
		}
	}
	
#define ScrapyardsNight_sprite_set(_obj)

	switch(_obj) {
		case Floor:
			switch(area_current[0]) {
				default: if(!styleb) and (sprite_index = sprFloor3) sprite_index = global.sprFloor3Night;
				if(styleb) and (sprite_index = sprFloor3B) sprite_index = global.sprFloor3BNight;
				break;
			}
		break;
		
		case FloorExplo:
			switch(area_current[0]) {
				default: 
					sprite_index = global.sprFloor3ExploNight;
				break;
			}
		break;
		
		case Wall:
			switch(area_current[0]) {
				default: 
					if (sprite_index  = sprWall3Bot){
						sprite_index = global.sprWall3BotNight;
						outspr		 = global.sprWall3OutNight;
						topspr       = global.sprWall3TopNight;
					}
				break;
			}
		break;
		
		case Top:
			switch(area_current[0]){
				default: sprite_index = global.sprWall3TopNight; break;
			}
		break;
		
		case TopSmall:
			switch(area_current[0]){
				default: if (sprite_index = sprWall3Trans) sprite_index = global.sprWall3TransNight; break;
			}
		break;
		
		case Debris:
			if(sprite_index = sprDebris3) sprite_index = global.sprDebris3Night;
		break;

	
		case Detail:
			if (sprite_index = sprDetail3){
				sprite_index = global.sprDetail3Night;
			}
		break;
		
		case Bones:
			if (sprite_index = sprScrapDecal){
				sprite_index = global.sprScrapDecalNight;
			}
		break;
		
		case TopDecalScrapyard:
			if (sprite_index = sprTopDecalScrapyard){
				sprite_index = global.sprTopDecalScrapyardNight;
			}
		break;

		case Car:
			spr_idle = global.sprCarIdleNight;
			spr_hurt = global.sprCarHurtNight;
		break;
	}
	
#define ScrapyardsNight_step
	 // Run compat sprites on a delay to avoid issues with mod load order:
	if(compatCheck = false){
		compatTimer -= current_time_scale;
		if(compatTimer <= 0){
			compatCheck = true;
			ScrapyardsNight_compatsprite();
		}
	}
	
#define ScrapyardsNight_cleanup
	
	 // Remove Night Credits:														// Hardmode Scrapyards Areas:
	if(GameCont.area != 3) && (GameCont.area != 100) && (GameCont.area != "bigdog") && (GameCont.area != "junkyard") && (GameCont.area != "ravenboss"){
		global.nightCredits = 0;
	}
	
	 // Reset Music:
	wait(2);
	if(fork()){
		while(instance_exists(mutbutton)){ wait(1); }
		if !(call(scr.event_get_active, "Thunderstorm")) && !(call(scr.event_get_active, "ScrapyardsNight")) { 
			if(GameCont.area = 3){
				if(GameCont.proto = 1){
					sound_play_music(mus3b);	
				} else {
					sound_play_music(mus3);
				}
				global.eventMusicPlaying = false;
			}
		}
		exit;
	}
	global.isNight	= false;

//#endregion
//#region CRYSTAL CAVES EVENTS
#define CurseSpread_area			return 4;
#define CurseSpread_chance			return global.settingCurseSpreadEventSpawnChance + ((crown_current = crwn_curses) * 0.12);
#define CurseSpread_create
	repeat(3 + irandom(2)){
		with(call(scr.instance_random, Floor)){
			mod_script_call("mod", "Frontier_Caves", "CurseCaveSpreader_create", x + 16, y + 16);
		}
	}
	with(Spider){
		if(random(4) < 1){
			instance_create(x, y, InvSpider)
			instance_delete(self);
		}
	}
	with(LaserCrystal){
		if(random(5) < 1){
			instance_create(x, y, InvLaserCrystal)
			instance_delete(self);
		}
	}
	with(call(scr.instance_random, WeaponChest)){
		instance_create(x, y, BigCursedChest)
		with(mod_script_call("mod", "Frontier_Caves", "CurseCaveSpreader_create", x, y)){
			curseRange = 48;
		}
		instance_delete(self);		
	}
	with(call(scr.instance_random, BigWeaponChest)){
		instance_create(x, y, BigCursedChest)
		with(mod_script_call("mod", "Frontier_Caves", "CurseCaveSpreader_create", x, y)){
			curseRange = 48;
		}
		instance_delete(self);			
	}
	
	if(mod_exists("mod", "ntte")){
		 // stop wallspread from clipping into topobject props:
		with(instances_matching_ne(prop, "top_object", null)){
			depth = -11;
		}
		
		with(instances_matching(CustomEnemy, "spr_idle", _tespr.MortarIdle)){
			if(random(4) < 1){
				mod_script_call("mod", "telib", "obj_create", x, y, "InvMortar");
				instance_delete(self);
			}
		}
		
		with(instances_matching(CustomEnemy, "spr_idle", _tespr.CrystalBatIdle)){
			if(random(3) < 1){
				mod_script_call("mod", "telib", "obj_create", x, y, "InvCrystalBat");
				instance_delete(self);
			}
		}
		
		// spiderlings dont inherit curse right so not doing them.
	}
	

//#endregion

//#region FROZEN CITY EVENTS

//#region BLIZZARD
#define Blizzard_text			return (global.settingEventText = false) ? undefined : choose("SO COLD", "THE WIND IS HOWLING");
#define Blizzard_area			return 5;
#define Blizzard_chance			return global.settingBlizzardEventSpawnChance + ((crown_current = "storms") * 0.55);

#define Blizzard_create

	 // Dropdown:
	if(global.settingEventDropdowns = true){
		EventDropdown_queue(5, 0, global.sndEventIntroWeather);
	}
	
	 // Vars:
	blizzardVignetteColor		= make_colour_rgb(107, 187, 255);
	blizzardFogColor			= make_color_rgb(7, 48, 83);
	spr_snowflakes				= global.sprBlizzardSnow;
	if(call(scr.event_get_active, "Aurora")) {
		blizzardVignetteColor	= make_colour_rgb(63, 43, 150);
		blizzardFogColor		= make_colour_rgb(70, 65, 210);
		spr_snowflakes			= global.sprBlizzardSnowNight;
	}

	global.blizzardSnowPos		= 0;
	var spr_snow				= spr_snowflakes;
	
	 // Get Goin!
	sound_play_ambient(global.ambBlizzard)
	script_bind_draw(SolidColorFog_add, -12, blizzardFogColor, 0.75);
	script_bind_draw(Blizzard_vignette, -13, x, y, blizzardVignetteColor);
	script_bind_draw(BlizzardSnow_draw, -9, spr_snow, -8, 2);
	
	 // Slap some snow on them right away
/*
	with(Player){
		repeat(8 / instance_number(Player)) { 
			with instance_create(x + random_range(-50, 50) + random(400), y + random_range(-100, 600), SnowFlake){
				sprite_index	= spr_snow; 
				direction		= 190; 
				speed			= 8; 
				fr_blizzardSnowCheck = true;
			}	
		}
	}
*/

#define Blizzard_cleanup
	wait(2);
	if(fork()){
		while(instance_exists(mutbutton)){ wait(1); }
		if !(call(scr.event_get_active, "Blizzard")) { 
			if(GameCont.area = 5){
				sound_play_ambient(amb5)
				global.eventAmbiencePlaying = false;
			}
		}
		exit;
	}
	
#define Blizzard_step

	var _snowDirection	= 190 + sin(current_frame * 0.06) * 20,
		_spr_snow		= spr_snowflakes;

		// Cool Snow: 
	/*
	with(Player){
		if random(32) < (4 / instance_number(Player)) { 
			with instance_create(x + random_range(-50, 50) + 400, y + random_range(-100, 600), SnowFlake){
				sprite_index			= _spr_snow; 
				direction				= _snowDirection; 
				speed					= 8; 
				fr_blizzardSnowCheck	= true;
			}	
		}
	}
	*/
	
	with(instances_matching(SnowFlake, "fr_blizzardSnowCheck", null)){ 
		sprite_index			= _spr_snow;
		direction				= _snowDirection; 
		speed					= 8;
		fr_blizzardSnowCheck	= true;
	}

	global.blizzardSnowPos += current_time_scale;

#define Blizzard_vignette(_x, _y, _color)
    
	with(Player){
			// See More:
		switch(race){
			case "eyes": 
			var eyesRadius = 0.3
    	break;
        	// Don't See More:
    	default: var eyesRadius = 0           
		}
		
		draw_set_visible_all(false);
    	draw_set_visible(index, true);
		draw_sprite_ext(global.sprVignette,	0, x, y, 0.6 + eyesRadius + (skill_get("bat ears") * 0.3), 0.6 + eyesRadius + (skill_get("bat ears") * 0.3), 0, _color, 1);
		draw_sprite_ext(global.sprVignetteOuter, 0, x, y, (0.6 + eyesRadius + (skill_get("bat ears") * 0.3)) * 3, (0.6 + eyesRadius + (skill_get("bat ears") * 0.3)) * 3, 0, _color, 1);
		draw_set_visible_all(true);
	}
 
#define BlizzardSnow_draw(_sprite, _xSpeed, _ySpeed)
	draw_sprite_tiled(_sprite, 0, global.blizzardSnowPos * _xSpeed, (global.blizzardSnowPos * _ySpeed) + sin(current_frame * 0.1) * 20)
	draw_sprite_tiled(_sprite, 1, global.blizzardSnowPos * _xSpeed * 0.8, ((global.blizzardSnowPos + 45) * _ySpeed) + sin(current_frame * 0.06) * 30)
   
#define SolidColorFog_add(_color, _alpha)
    draw_set_blend_mode(bm_add)
    draw_sprite_tiled_ext(global.sprSolidColorFog, 0, x, y, 160, 160, _color, _alpha);
    draw_set_blend_mode(bm_normal)

#define SolidColorFog_normal(_color, _alpha)
    draw_sprite_tiled_ext(global.sprSolidColorFog, 0, x, y, 160, 160, _color, _alpha);
    
//#endregion
//#region AURORA
#define Aurora_text				return (global.settingEventText = false) ? undefined : choose("PRETTY", "SHINING COLORS");
#define Aurora_area				return [5, "city"];
#define Aurora_chance			return (global.settingNightLoops) ? global.nightLoop :
									!(GameCont.subarea = 1) && (global.nightCredits = 0) ? 0 : 
									global.settingNightEventSpawnChance + ((crown_current = "storms") * 0.25) + (global.nightCredits > 0);

#define Aurora_setup

	 // Night Credits:
	if(GameCont.subarea = 1){
		global.nightCredits += 1;
	}

	global.isNight = true;
	
	 // Stop v9944 RadioActive from playing:
	if(mod_exists("mod", "radioactive")){
		if(mod_variable_exists("mod", "radioactive", "menuhandler")){
			if(fork()){
				wait(1);
				mod_variable_set("mod", "radioactive", "track_found", false);
				exit;
			}
		}
	}
	
	// Play Music:
	var _EventMusic = global.musFrozenCityNight;
	if(!audio_is_playing(_EventMusic)){ 
		sound_play_music(_EventMusic); 
	}
	if(fork()){ // v100 60fps i hate you i hate you
		wait(1);
		if(!audio_is_playing(_EventMusic)){ 
			sound_play_music(_EventMusic); 
		}
		exit;
	}
	global.eventMusicPlaying = true;

	 // Resprite:
	script_bind_end_step(Aurora_applysprites, 0);	
	
#define Aurora_create

	 // Dropdown:
	if(GameCont.subarea = 1){
		if(global.settingEventDropdowns = true){
			if(global.settingNightLoops = false){
				EventDropdown_queue(3, 0, global.sndEventIntroNight);
			}
		}
	}
	
	 // Half-Dark:
	with(instance_create(0, 0, CustomObject)){
		name = "fr_area_halfdark"
	}

	 // Event Vars:
	global.currentAuroras	= 0;
	allowAuroras			= true;
	changeSnow				= true;
	compatCheck				= false;
	compatTimer				= 10;
	
	 // Too Much Snow to see the lights!
	if(call(scr.event_get_active, "Blizzard")) {
		allowAuroras		= false;
		changeSnow			= false;
	}
	
	// Scary and Dark:
	with(TopCont) {
		darkness = 1;
	}
	
	// Back Color:
	background_color = make_color_rgb(77, 73, 127);

	// Set Night Sprites:
	with([Floor, FloorExplo, Wall, Top, TopSmall, Debris, Detail, prop, TopPot, Bones, TopDecalCity, SnowFloor, SnowMan, SnowBotCar, CarThrow]) {
		if(instance_exists(self)) with(self) {
			fr_aurora_check = true;
			Aurora_sprite_set(object_index);
		}
	}
    
    with(StreetLight){
		spr_idle = global.sprStreetLightNight;
		spr_hurt = global.sprStreetLightHurtNight;
		spr_dead = global.sprStreetLightDeadNight;
    }
		
	with(SodaMachine){
		spr_idle = global.sprSodaMachineNight;
		spr_hurt = global.sprSodaMachineHurtNight;
		spr_dead = global.sprSodaMachineDeadNight;
	}
		
	with(SnowMan){
		spr_idle = global.sprSnowManNight;
		spr_hurt = global.sprSnowManHurtNight;
		spr_dead = global.sprSnowManDeadNight;
	}

	with(Hydrant){
		if (spr_idle = sprHydrant){
			spr_idle = global.sprHydrantNight;
			spr_hurt = global.sprHydrantHurtNight;
			spr_dead = global.sprHydrantDeadNight;
		}
		if (spr_idle = sprNewsStand){
			spr_idle = global.sprNewsStandNight;
			spr_hurt = global.sprNewsStandHurtNight;
			spr_dead = global.sprNewsStandDeadNight;
		}
		if (spr_idle = sprIcicle){
			spr_idle = global.sprIcicleNight;
			spr_hurt = global.sprIcicleHurtNight;
			spr_dead = global.sprIcicleDeadNight;
		}
	}
    
#define Aurora_compatsprite

	 // other frocity ei stuff:
	with(instances_matching_ne([Wall, Floor, SnowFloor], "fr_aurorasprite", null)){
		sprite_index	= fr_aurorasprite;
		if("fr_auroratopspr" in self){
			topspr		= fr_auroratopspr;
			outspr		= fr_auroraoutspr;
		}
	}

     // Proto Statue Decal:
	with(instances_matching(CustomObject, "name", "detailsPlus_ProtoStatueDecal")){
		spr_idle		= global.sprCityProtoStatueDecalNight;
		spr_dead		= global.sprCityProtoStatueDecalDeadNight;
		sprite_index	= spr_idle;
    }
    
     // Pelagic Predicament Prop Color:
	with(instances_matching(CustomObject, "name", "fr_pelagicbottom")){
		image_blend	= background_color;
    }

     // NT:TE //
    if mod_exists("mod", "ntte"){
	
	 	// Igloos:
		with(instances_matching(CustomProp, "spr_idle", _tespr.IglooFrontIdle)){
			spr_idle = global.sprCompatIglooFront;
			spr_hurt = global.sprCompatIglooFrontHurt;
			spr_dead = global.sprCompatIglooFrontDead;
		}
		with(instances_matching(CustomProp, "spr_idle", _tespr.IglooSideIdle)){
			spr_idle = global.sprCompatIglooSide;
			spr_hurt = global.sprCompatIglooSideHurt;
			spr_dead = global.sprCompatIglooSideDead;
		}
	
		 // Seal Plaza:
		 // seal team 6
		with (instances_matching(Floor, "sprite_index", _tespr.FloorSeal)){
			sprite_index = global.sprCompatFloorSeal;
		}
		with (instances_matching(Floor, "sprite_index", _tespr.FloorSealRoom)){
			sprite_index = global.sprCompatFloorSealRoom;
		}
		with (instances_matching(Floor, "sprite_index", _tespr.FloorSealRoomBig)){
			sprite_index = global.sprCompatFloorSealRoomBig;
		}
		
		with(instances_matching(CustomProp, "spr_dead", _tespr.PalankingStatueDead)){
			spr_dead = global.sprCompatPalankingStatueDead;
		}

		 // Check topsmalls with normal wall sprites for buried vaults:
		with(instances_matching(TopSmall, "sprite_index", sprWall5Top)){
			sprite_index = global.sprWall5TopNight;
		}
    }

#define Aurora_step

	 // Run compat sprites on a delay to avoid issues with mod load order:
	if(compatCheck = false){
		compatTimer -= current_time_scale;
		if(compatTimer <= 0){
			compatCheck = true;
			Aurora_compatsprite();
		}
	}

						// Pretty!
	if (random(70) < current_time_scale) && (global.currentAuroras < global.settingMaxAuroras) && (allowAuroras = true) { 
		with (call(scr.instance_random, Floor)){ 
			AuroraLightController_create(x, y) global.currentAuroras += 1; 
		}
	}

	if(changeSnow = true){
		with(instances_matching(SnowFlake, "fr_aurora_check", null)) {
			if(instance_exists(self)) with(self) {
				fr_aurora_check = true;
				sprite_index	= global.sprSnowFlakeNight;
			}
		}
	}
	
	 // sometimes they pick up cars for some reason
	with(instances_matching(SnowBotCar, "spr_idle", sprSnowBotRedCarIdle)){
		if(instance_exists(self)) with(self) {
			fr_aurora_check = true;
			spr_idle = sprSnowBotCarIdle;
			spr_hurt = sprSnowBotCarHurt;
			spr_walk = sprSnowBotCarWalk;
		}
	}
	with(instances_matching(CarThrow, "fr_aurora_check", null)) {
		if(instance_exists(self)) with(self) {
			fr_aurora_check = true;
			sprite_index = sprFrozenCarThrown;
		}
	}
	
	// TE Compat (Seal King Statue)
	// I wish you had just used different variables for each phase but its fine this works too
	with(instances_matching(CustomProp, "spr_dead", global.sprCompatPalankingStatueDead)){
		spr_idle = global.sprCompatPalankingStatue[phase];
	}
		
#define AuroraLightController_create(_x,_y)
	with instance_create(_x, _y, CustomObject){
		name				= "fr_auroraController"
		sprite_index		= mskNone;
		
		color1				= choose(c_fuchsia, c_aqua, 16745694, c_teal);
		color2				= choose(c_lime, c_blue, c_lime);
		wavespeed			= random_range(2500, 4500);
		waveheight			= random_range(4, 6);
		auroraheight		= random_range(50, 70)
		aurorafade			= 0;
		lifetime			= random_range(600, 1000)
		aurorabobheight 	= random_range(10, 15)
		aurorabobspeed		= random_range(0.01, 0.015)
		
		on_step 			= AuroraLightController_step
		
	}
	
	// Draw Aurora:
#define AuroraLightController_step

	// Draw Aurora:
	with script_bind_draw(AuroraLights_draw, -12){
    	color1			= other.color1;
    	color2			= other.color2;
    	wavespeed		= other.wavespeed;
    	waveheight		= other.waveheight;
    	aurorafade		= other.aurorafade;
    	auroraheight	= other.auroraheight;
    	aurorabobheight = other.aurorabobheight;
    	aurorabobspeed	= other.aurorabobspeed;
    	x				= other.x
    	y				= other.y
	}
	
			

 	 // Controller Lifetime:
	if (lifetime > 0) { 
		lifetime -= current_time_scale;
	}
	 // Fade In:
	if (aurorafade < 0.5 && lifetime > 0) { 
		aurorafade += (0.005 * current_time_scale) 
	}
	 // Fade Out:
	if (aurorafade > 0 && lifetime <= 0) { 
		aurorafade -= (0.005 * current_time_scale) 
	}
	 // Destroy:
	if (aurorafade <= 0 && lifetime <= 0) { 
//		global.currentAuroras -= 1;
		instance_destroy() 
	}

			
#define AuroraLights_draw
	var aurorabob = sin(current_frame * aurorabobspeed) * aurorabobheight
	draw_primitive_begin(pr_trianglestrip)
    for(i = 10; i<= 30; i++){
        draw_vertex_color(view_xview_nonsync + i * (game_width / 16) - (game_width / 1.5), y + sin(current_time / wavespeed + i) * waveheight + aurorabob, color1, aurorafade) 
        draw_vertex_color(view_xview_nonsync + i * (game_width / 16) - (game_width / 1.5), y + sin(current_time / wavespeed + i) * waveheight + auroraheight + aurorabob, color2, 0) 
    }
	draw_primitive_end()
	instance_destroy()

#define Aurora_applysprites
	with(instances_matching([Floor, FloorExplo, Wall, Top, TopSmall, Debris, Detail, Bones, prop, TopPot, CarThrow, SnowBotCar], "fr_aurora_check", null)){
		if(instance_exists(self)) with(self){
			fr_aurora_check = true;
			Aurora_sprite_set(object_index);
		}
	}
		
#define Aurora_sprite_set(_obj)

	switch(_obj) {
		case Floor:
			switch(area_current[0]) {
				default: if(!styleb) and (sprite_index = sprFloor5) sprite_index = global.sprFloor5Night;
				if(styleb) and (sprite_index = sprFloor5B) sprite_index = global.sprFloor5BNight;
				break;
			}
		break;
		
		case FloorExplo:
			switch(area_current[0]) {
				default: 
					sprite_index = global.sprFloor5ExploNight;
				break;
			}
		break;
		
		case Wall:
			switch(area_current[0]) {
				default: 
					if (sprite_index  = sprWall5Bot){
						sprite_index = global.sprWall5BotNight;
						outspr		 = global.sprWall5OutNight;
						topspr       = global.sprWall5TopNight;
					}
				break;
			}
		break;
		
		case Top:
			switch(area_current[0]) {
				default: sprite_index = global.sprWall5TopNight; break;
			}
		break;
		
		case TopSmall:
			switch(area_current[0]) {
				default: if (sprite_index = sprWall5Trans) sprite_index = global.sprWall5TransNight; break;
			}
		break;
		
		case SnowFloor:
			sprite_index = global.sprSnowFloorNight;
		break;
		
		case Debris:
			if(sprite_index = sprDebris5) sprite_index = global.sprDebris5Night;
		break;

	
		case Detail:
			if (sprite_index = sprDetail5){
				sprite_index = global.sprDetail5Night;
			}
		break;
		
		case Bones:
			if (sprite_index = sprIceDecal){
				sprite_index = global.sprIceDecalNight;
			}
		break;
		
		case TopDecalCity:
			sprite_index = global.sprTopDecalCityNight;
		break;

		case Car:
			spr_idle = global.sprFrozenCarNight;
			spr_hurt = global.sprFrozenCarHurtNight;
		break;
	
	}
	
#define Aurora_cleanup

	 // Remove Night Credits:
	if(GameCont.area != 5) && (GameCont.area != 100) && (GameCont.area != 105) && (GameCont.area != "city"){
		global.nightCredits = 0;
	}

	wait(2);
	if(fork()){
		while(instance_exists(mutbutton)){ wait(1); }
		if !(call(scr.event_get_active, "Aurora")) {
			if(GameCont.area = 5){
				if(GameCont.proto = 1){
					sound_play_music(mus5b);	
				} else {
					sound_play_music(mus5);
				}
				global.eventMusicPlaying = false;
			}
		}
		exit;
	}
	global.isNight	= false;
	
//#endregion
//#region HAUNTED CITY
#define HauntedCity_area			return [5, "city"];
#define HauntedCity_chance			return global.settingHauntedCityEventSpawnChance;
#define HauntedCity_create
	
	with(instances_matching([SnowTank, SnowBot, Wolf, GoldSnowTank], "fr_hauntedcity", null)){
		fr_hauntedcity = true;
		
		 // possessed:
		if(random(4) < 1){
			with(mod_script_call("mod", "Frontier_Labs", "Voltergeist_create", x, y)){
				possess_target	= other;
				possessing		= true;
				depth			= -2;
				image_alpha		= 0;
				image_angle 	= 0;
				mask_index		= mskNone;
				possessionCreds -= 1;
				 
				 // apply possession:
				mod_script_call("mod", "Frontier_Labs", "Voltergeist_possess_manual")
			}
		}
	}
	
	 // place props:
	repeat(3 + irandom(3)){
		var	_ghostRoomFloor = [],
			_ghostRoomIndex = -1
	
	 	with(FloorNormal){
			if(point_distance(bbox_center_x, bbox_center_y, 10016, 10016) > 48){
				if(!place_meeting(x, y, Wall) && !place_meeting(x, y, prop) && !place_meeting(x, y, chestprop)){
					array_push(_ghostRoomFloor, self);
					_ghostRoomIndex++;
				}
			}
		}
		call(scr.array_shuffle,(_ghostRoomFloor));
		if(_ghostRoomIndex >= 0) with(_ghostRoomFloor[_ghostRoomIndex--]){
			var	_w          = 1,
				_h          = 1,
				_type       = "",
				_dirOff     = 0,
				_floorDis   = choose(0, -16),
				_spawnX     = x,
				_spawnY     = y,
				_spawnDis   = 128,
				_spawnFloor = FloorNormal;
		
			with(call(scr.floor_room,_spawnX, _spawnY, _spawnDis, _spawnFloor, _w, _h, _type, _dirOff, _floorDis)){
				var	_myx = x - 16,
					_myy = y - 16;
		
				// Resprite Floors:
				for(var j = 0; j < array_length(floors); j++){
					with(floors[j]){
						fr_labsentrance_check = true;
						sprite_index	= global.sprSnowFloorOutpost;
						image_index		= irandom(5);
						depth			-= 2;
		
						with(instance_create(x + irandom_range(-1, 1), y - irandom_range(2, 3), SnowFloor)){
							sprite_index	= global.sprSnowFloorOutpostSnow;
							image_speed		= other.image_speed;
							image_index		= other.image_index;
							image_angle	   += random_range(-1, 1)
							depth			= other.depth + 1;
							fr_aurorasprite	= global.sprSnowFloorOutpostSnowNight;
						}
						
						var _prop = choose("tube", "pump");
						switch(_prop){
							case "pump":
								mod_script_call("area", "graveyard", "VolterPump_create", x + 16, y + 16);
							break;
							
							case "tube":
								mod_script_call("area", "deeplabs", "VoltergeistTube_create", x + 16, y + 18);
							break;
						}
						
						
					}
				}
			}
			// Resprite Walls:
			with(Wall){ 
				if(point_distance(x, y, _myx, _myy) < 32) {
					fr_labsentrance_check	= true;
					topspr      			= sprWall5Top;
					outspr      			= sprWall5Out;
					sprite_index			= global.sprCityWallOutpostBot;
					fr_aurorasprite			= global.sprCityWallOutpostBotNight;
					fr_auroratopspr			= global.sprWall5TopNight;
					fr_auroraoutspr			= global.sprWall5OutNight;
				}
			}
		}
	}
	
//#endregion
//#region LABS EVENTS

//#region BLACKOUT
#define Blackout_text			return (global.settingEventText = false) ? undefined : choose("LIGHTS OUT", "SYSTEM FAILURE");
#define Blackout_chance			return global.settingBlackoutEventSpawnChance;
#define Blackout_area			return [6, "labs"];

#define Blackout_setup
	 // Resprite:
	script_bind_end_step(Blackout_applysprites, 0);
	
#define Blackout_create

	 // Dropdown:
	if(global.settingEventDropdowns = true){
		EventDropdown_queue(6, 1, sndFootPlaSand5);
	}

	blackoutScaleTime = 0;

    with script_bind_draw(Blackout_fog, -12){
		x			= other.x;
    	y			= other.y;
	}

	if(call(scr.event_get_active, "Blackout")){
		with(instances_matching(Wall, "fr_blackout_check", null)) {
			if(instance_exists(self)) with(self){
				fr_blackout_check = true;
				Blackout_sprite_set(object_index);
			}
		}
	}
	
	with(Server){
		spr_idle = global.sprServerOff;
		spr_hurt = global.sprServerOffHurt;
	}
	
	with(Terminal){
		TerminalOff_create(x,y)
		instance_delete(self);
	}

#define TerminalOff_create(_x, _y)
	with(instance_create(_x, _y, CustomProp)){
		 // Visual:
		spr_idle = global.sprTerminalOff;
		spr_hurt = global.sprTerminalOffHurt;
		spr_dead = sprTerminalDead;
		spr_shadow = shd24
		 // Sounds:
		snd_hurt = sndHitMetal;
		snd_dead = sndComputerBreak;
		 // Vars:
		maxhealth = 10;
		my_health = maxhealth;
		team = 0;
		
		return self;
	}
	
#define Blackout_applysprites
	with(instances_matching(Wall, "fr_blackout_check", null)){
		if(instance_exists(self)) with(self){
			fr_blackout_check = true;
			Blackout_sprite_set(object_index);
		}
	}
	
#define Blackout_sprite_set(_obj)

	switch(_obj) {
		case Wall:
			switch(area_current[0]) {
				default: 
					if (sprite_index = sprWall6Bot){ 
						sprite_index = global.sprWall6BotBlackout; 
					}
				break;
			}
		}
	
#define Blackout_step
//	global.blackoutScale = clamp(sin(current_frame * 0.03) * 1, 0.30, 1)

	// Play Alarm:
	if every(60){ 
		sound_play(global.sndImpostorAlert);
		blackoutScaleTime = 45;
	}
	if(blackoutScaleTime > 0){
		global.blackoutScale = clamp(blackoutScaleTime / 30, 0.25, 0.8);
		blackoutScaleTime -= current_time_scale;
	} else {
		global.blackoutScale = 0.25;
	}


		// Disable Ball Traps:
	with(instances_matching(instances_matching(CustomHitme, "name", "fr_ElectricityTrap"), "activated", true)){
		spr_idle	= spr_off;
		activated	= false;
		if(instance_exists(myBall)){
			with(myBall){
				instance_destroy();
			}
		}
		myBall		= noone;
	}

		// Vignette:
	//script_bind_draw(Blackout_vignette, -13, vignette_scale);

	// this vignette is now drawn in draw_dark so it actually works with things that light stuff up, for the mostpart at least
	// leaving this old version here because might as well in case I break something and need to go back to this way

#define Blackout_vignette(_scale)
	with (Player){
			// See More:
		switch race{
			case "eyes": 
			var eyesRadius = 0.3
    	break;
        	// Don't See More:
    	default: var eyesRadius = 0           
		}
		
		draw_set_visible_all(false);
    	draw_set_visible(index,true);
		draw_sprite_ext(
			global.sprVignette,
			0,
			x,
			y,
			_scale + eyesRadius + (skill_get("bat ears") * 0.3),
			_scale + eyesRadius + (skill_get("bat ears") * 0.3),
			0,
			make_colour_rgb(0, 0, 0),
			1,
		);
		draw_set_visible_all(true);
	}
 
    instance_destroy();

#define Blackout_fog
    draw_set_blend_mode(bm_add)
    draw_sprite_ext(global.sprFogBlackout, (current_frame / 10), view_xview_nonsync + 1000, view_yview_nonsync, 160, 160, random(360), c_white, 0.28)
    draw_set_blend_mode(bm_normal)
    
//#endregion
//#region PALACE EVENTS
#define BoilingWater_text		return (global.settingEventText = false) ? undefined : "ITS JUST @eBOILING WATER?";
#define BoilingWater_chance		return (GameCont.subarea = 3) ? 0 : 0.125;
#define BoilingWater_area		return [7, "palace"];

#define BoilingWater_create
	with(Floor){
		if(!place_meeting(x, y, Player) || !place_meeting(x, y, enemy) || !place_meeting(x, y, hitme) || !place_meeting(x, y, chestprop) || !place_meeting(x, y, prop)){
			if(random(30) < 1){
				var myx = x + choose(0, 16);
				var myy = y + choose(0, 16);
			
				with instance_create(myx, myy, Wall){
					instance_create(x, y, NOWALLSHEREPLEASE)
					if(point_distance(myx, myy, Player.x, Player.y) > 90 && distance_to_object(BigWeaponChest) > 64){
						with(mod_script_call("mod", "Frontier_Palace", "RadFlameTrap_create", myx, myy)){
							with(instance_create(x, y, TrapScorchMark)){
								sprite_index	= global.sprPalaceTrapScorchMark;
								depth			= 8;
							}
						}
					}
				}
			}
		}
	}

#define SerpentLair_text		return (global.settingEventText = false) ? undefined : choose("YOU'RE HISSTORY", "IT BITES");
#define SerpentLair_chance		return (GameCont.subarea = 3) ? 0 : global.settingSerpentLairEventSpawnChance;
#define SerpentLair_area		return [7, "palace"];
#define SerpentLair_create
	serpentLairCooldown = 110;

	 // Dropdown:
	if(global.settingEventDropdowns = true){
		EventDropdown_queue(8, 2, global.sndEventIntroSerpent);
	}
    
#define SerpentLair_step
    if(serpentLairCooldown >= 0){ 
    	serpentLairCooldown -= current_time_scale 
    }
    if(serpentLairCooldown <= 0){
		if(instance_exists(enemy) && instance_exists(Player)){
	    	if(random(50) < 1){
	    		with(instances_matching(CustomObject, "name", "fr_PalaceSerpent")){
	    			instance_destroy();
	    		}
	    		mod_script_call("mod", "Frontier_Palace", "PalaceSerpentSpawner_create", 10016, 10016);	
	    		serpentLairCooldown += 200
	    	}
		}
    }
   
#define SerpentLair_cleanup
	 // Cut that Out:
	var _serpentSound = mod_variable_get("mod", "Frontier_Palace", "serpentSound")
	if(audio_is_playing(_serpentSound)){
		sound_stop(_serpentSound);
	}
	var _serpentRumbleSound = mod_variable_get("mod", "Frontier_Palace", "serpentSoundRumble")
	if(audio_is_playing(_serpentRumbleSound)){
		sound_stop(_serpentRumbleSound);
	}

//#endregion
//#region DROPDOWNS
#define EventDropdown_queue(_mainIndex, _backIndex, _sound)
	var _controller = call(scr.instance_nearest_array, 10016, 10016, instances_matching(CustomObject, "name", "fr_EventDropdownController"));
	if(!instance_exists(_controller)){
		EventDropdownController_create(10016, 10016);
		var _controller = call(scr.instance_nearest_array, 10016, 10016, instances_matching(CustomObject, "name", "fr_EventDropdownController"));
	}
	with(_controller){
		array_push(dropdownsQueue, [_mainIndex, _backIndex]);
		array_push(soundsQueue, _sound);
	}
	
#define EventDropdownController_create(_x, _y)
	with(instance_create(_x, _y, CustomObject)){
		name	= "fr_EventDropdownController";
		
		sprite_index	= mskNone;
		
		removeMeID		= null;
		dropdownDelay	= 20;
		dropdownAllowed = true;
		arrayIndex		= 0;
		dropdownsQueue	= [];
		soundsQueue		= [];
		
		on_step			= EventDropdownController_step;
		
		return self;
	}
	
#define EventDropdownController_step

	 // DONE!
	if((array_length(dropdownsQueue) < 0)){
		instance_destroy();
		exit;
	}
	
	 // Drop it:
	if(dropdownDelay > 0){
		dropdownDelay -= current_time_scale;
	} else {
		if(dropdownAllowed = true && (arrayIndex <= array_length(dropdownsQueue) - 1)){
			var _dropdown	= dropdownsQueue[arrayIndex],
				_front		= _dropdown[0],
				_back		= _dropdown[1];
			with(script_bind_draw(EventDropdown_draw, -1000, self, _front, _back)){
				imDown			= false;
				upDelay			= 35;
				height			= -50;
				letsBounce		= false;
				bounceHeight	= 0;
				bouncedUp		= false;
				letsAGo			= false;
			}
			sound_play(soundsQueue[arrayIndex])
			arrayIndex += 1;
			dropdownDelay = 10;
			dropdownAllowed = false;
		}
	}
	
#define EventDropdown_draw(_controller, _front, _back)

	 // Lower Down:
	if(imDown = false){
		height += 6 * current_time_scale;
		if(height >= 20){
			imDown		= true;
			letsBounce	= true;
		}
	}
	
	 // Bouncy:
	if(letsBounce = true){
		if(bouncedUp = false){
			bounceHeight += 4 * current_time_scale;
			if(bounceHeight >= 8){
				bouncedUp = true;
			}
		} else {
			bounceHeight -= 2 * current_time_scale;
			if(bounceHeight <= 0){
				letsBounce		= false;
				bounceHeight	= 0;
			}
		}
	}
	
	 // Rise Back Up:
	if(imDown = true){
		if(upDelay > 0){
			upDelay -= current_time_scale;
		} else {
			 // Lil Bounce:
			if(letsAGo = false){
				bounceHeight += 4 * current_time_scale
				if(bounceHeight >= 12){
					letsAGo = true;
					var _dropdownExtraSpeed = 0;
				}
			} else {
				 // Let's getta OUTTA HERE!
				_dropdownExtraSpeed += 1;
				height -= (10 + _dropdownExtraSpeed) * current_time_scale;
			}
		}
		if(height <= -50){
			with(_controller){
				dropdownAllowed = true;
			}
			instance_destroy();
			exit;
		}
	}

	draw_sprite(global.sprEventDropdownsBack, _back, view_xview_nonsync + (game_width / 2), view_yview_nonsync + height);
	draw_sprite_ext(global.sprEventDropdowns, _front, view_xview_nonsync + (game_width / 2), view_yview_nonsync + height + bounceHeight, 1, 1,0, c_white, 1);
	
//#endregion
//#region NIGHT COAST
#define CoastNight_text		return (global.settingEventText = false) ? undefined : "MOONLIT WAVES"
#define CoastNight_area		return "coast";
#define CoastNight_chance	return (global.settingNightLoops) ? global.nightLoop :
								!(GameCont.subarea = 1) && (global.nightCredits = 0) ? 0 : 
								global.settingNightEventSpawnChance + ((crown_current = "storms") * 0.25) + (global.nightCredits > 0);
#define CoastNight_setup
	 // Replace Coast Floor Sprite:
	with(Floor){
		if(sprite_index = _tespr.FloorCoast){
			sprite_index	= global.sprFloorCoastNight;
		}
	}
	with(_tespr){
		FloorCoast		= global.sprFloorCoastNight;
		CoastTrans		= global.sprCoastTransNight;
		PalankingChunk	= global.sprCompatPalankingChunkNight;
		PalankingBott	= global.sprCompatPalankingBottNight;
	}
	
	global.isNight = true;

	 // Night Credits:
	if(GameCont.subarea = 1){
		global.nightCredits += 1;
	}
	
	// Play Music:
	var _EventMusic = _temus.CoastB;	// its probably not worth making a new track for this compat thing, and i think this works fine.
	if(!audio_is_playing(_EventMusic)){ 
		sound_play_music(_EventMusic); 
	}
	if(fork()){ // v100 60fps i hate you i hate you
		wait(1);
		if(!audio_is_playing(_EventMusic)){ 
			sound_play_music(_EventMusic); 
		}
		exit;
	}
	global.eventMusicPlaying = true;
	
	 // Resprite:
	script_bind_end_step(CoastNight_applysprites, 0);
	
#define CoastNight_create

	 // Dropdown:
	if(GameCont.subarea = 1){
		if(global.settingEventDropdowns = true){
			if(global.settingNightLoops = false){
				EventDropdown_queue(9, 0, global.sndEventIntroNight);
			}
		}
	}

	 // Half-Dark:
	with(instance_create(0, 0, CustomObject)){
		name = "fr_area_halfdark"
	}
	
	compatCheck					= false;
	compatTimer					= 10;

    // Dark as the night:
	with(TopCont){
		darkness = 1;
	}
	
    sprite_replace(sprWind, "sprites/particles/sprWindNightEvent.png", 9) 
	sprite_replace(sprLeaf, "sprites/areas/coast/night/sprLeafNight.png", 5) 
	
	// BG:	
	background_color = make_color_rgb(16, 21, 61);

	// Set Night Sprites:
	with([Floor, FloorExplo, Wall, Top, TopSmall, Debris, Detail, prop, TopPot, Bones, TopDecalScrapyard]) {
		if(instance_exists(self)) with(self){
			fr_coastnight_check = true;
			CoastNight_sprite_set(object_index);
		}
	}
	with(instances_matching(Detail, "sprite_index", _tespr.DetailCoast)){
		sprite_index = global.sprDetailCoastNight;
	}
	 // Cacti:
	with(instances_matching(Cactus, "spr_idle", _tespr.BloomingCactusIdle[0])){
		spr_idle	= global.sprBloomingCactusNight;
		spr_hurt	= global.sprBloomingCactusHurtNight;
		spr_dead	= global.sprBloomingCactusDeadNight;
	}		
	with(instances_matching(Cactus, "spr_idle", _tespr.BloomingCactusIdle[1])){
		spr_idle	= global.sprBloomingCactus2Night;	
		spr_hurt	= global.sprBloomingCactus2HurtNight;
		spr_dead	= global.sprBloomingCactus2DeadNight;
	}
	with(instances_matching(Cactus, "spr_idle", _tespr.BloomingCactusIdle[2])){
		spr_idle	= global.sprBloomingCactus3Night;		
		spr_hurt	= global.sprBloomingCactus3HurtNight;
		spr_dead	= global.sprBloomingCactus3DeadNight;
	}
	with(instances_matching(CustomProp, "spr_idle", _tespr.BigBloomingCactusIdle)){
		spr_idle	= global.sprBigBloomingCactusNight;		
		spr_hurt	= global.sprBigBloomingCactusHurtNight;
		spr_dead	= global.sprBigBloomingCactusDeadNight;
	}
	 // Rock:
	with(instances_matching(CustomProp, "spr_idle", _tespr.RockIdle[0])){
		spr_idle	= global.sprRock1IdleNight;
		spr_hurt	= global.sprRock1HurtNight;
		spr_dead	= global.sprRock1DeadNight;
		spr_bott	= global.sprRock1BottNight;
	}		
	with(instances_matching(CustomProp, "spr_idle", _tespr.RockIdle[1])){
		spr_idle	= global.sprRock2IdleNight;
		spr_hurt	= global.sprRock2HurtNight;
		spr_dead	= global.sprRock2DeadNight;
		spr_bott	= global.sprRock2BottNight;
	}	
	
	 // shelly
	with(instances_matching(CustomProp, "spr_idle", _tespr.ShellIdle)){
		spr_idle	= global.sprCompatShellIdleNight;
		spr_hurt	= global.sprCompatShellHurtNight;
		spr_dead	= global.sprCompatShellDeadNight;
		spr_bott	= global.sprCompatShellBottNight;
	}	
	
	 // Palms:
	with(instances_matching(CustomProp, "spr_idle", _tespr.PalmIdle)){
		spr_idle	= global.sprCompatPalmIdleNight;
		spr_hurt	= global.sprCompatPalmHurtNight;
		spr_dead	= global.sprCompatPalmDeadNight;
	}
	with(instances_matching(CustomProp, "spr_idle", _tespr.PalmFortIdle)){
		spr_idle	= global.sprCompatPalmFortIdleNight;
		spr_hurt	= global.sprCompatPalmFortHurtNight;
		spr_dead	= global.sprCompatPalmDeadNight;
	}	 
	 
	 // Car:
	with(instances_matching(CustomProp, "spr_idle", _tespr.BuriedCarIdle)){
		spr_idle	= global.sprBuriedCarNight;		
		spr_hurt	= global.sprBuriedCarHurtNight;
	}
	 // Booshes:
	with(instances_matching(Bush, "spr_idle", _tespr.BloomingBushIdle)){
		spr_idle	= global.sprBloomingBushNight;			
	}
	 // Traffic Crabs:
	with(instances_matching(CustomEnemy, "spr_hide", _tespr.CrabHide)){
		spr_hide	= global.sprCompatTrafficCrabHide;
		spr_dead	= global.sprCompatTrafficCrabDead;
		if(sprite_index = _tespr.CrabHide){
			sprite_index	= spr_hide;
		}
	}	
	
	 // evil seal king:
	with(instances_matching(CustomEnemy, "spr_bott", _tespr.PalankingBott)){
		spr_bott        = global.sprCompatPalankingBottNight;
		spr_taun        = global.sprCompatPalankingTaunt;
		spr_call        = global.sprCompatPalankingCall;
		spr_idle        = global.sprCompatPalankingIdle;
		spr_walk        = global.sprCompatPalankingWalk;
		spr_hurt        = global.sprCompatPalankingHurt;
		spr_dead        = global.sprCompatPalankingDead;
		spr_burp        = global.sprCompatPalankingBurp;
		spr_fire        = global.sprCompatPalankingFire;
	}	
	
	 // you want to be night colored sooo bad oooo
	with(instances_matching(CustomEnemy, "spr_idle", _tespr.BloomingAssassinHide)){
		spr_idle	= global.sprCompatBloomingAssassinHide;
		spr_walk	= global.sprCompatBloomingAssassinHide;
		spr_hurt	= global.sprCompatBloomingAssassinHurt;
		spr_dead	= global.sprCompatBloomingAssassinDead;
	}	
	
#define CoastNight_compatsprite

     // Proto Statue Decal:
	with(instances_matching(CustomObject, "name", "detailsPlus_ProtoStatueDecal")){
		spr_idle		= global.sprCoastProtoStatueDecalNight;
		spr_dead		= global.sprCoastProtoStatueDecalDeadNight;
		sprite_index	= spr_idle;
    }
	with(instances_matching(Detail, "sprite_index", _tespr.DetailCoast)){
		sprite_index = global.sprDetailCoastNight;
	}

#define CoastNight_applysprites
	with(instances_matching([Floor, FloorExplo, Wall, Debris, Detail, JungleAssassin], "fr_coastnight_check", null)) {
		if(instance_exists(self)) with(self){
			fr_coastnight_check = true;
			CoastNight_sprite_set(object_index);
		}
	}
    
#define CoastNight_sprite_set(_obj)
	switch(_obj){
		case Floor:
			switch(area_current[0]) {
				default: if(!styleb) && (sprite_index = _tespr.FloorCoast) sprite_index = global.sprFloorCoastNight;
				if(styleb) && (sprite_index = _tespr.FloorCoastB) sprite_index = global.sprFloorCoastBNight;
				break;
			}
		break;
		
		case FloorExplo:
			switch(area_current[0]) {
				default: 
					sprite_index = sprFloor0Explo;
				break;
			}
		break;
		
		case Wall:
			switch(area_current[0]) {
				default: 
					if (sprite_index  = sprWall1Bot){
						sprite_index = sprWall0Bot;
						outspr		 = sprWall0Out;
						topspr       = sprWall0Top;
					}
				break;
			}
		break;
		
		case Top:
			switch(area_current[0]) {
				default: if (sprite_index = sprWall1Top) sprite_index = sprWall0Top; break;
			}
		break;
		
		case Debris:
			if(sprite_index = sprDebris1) sprite_index = sprDebris0;
		break;
		
		case JungleAssassin:
			if(spr_idle = _tespr.BloomingAssassinIdle){
				spr_idle	= global.sprCompatBloomingAssassinIdle;
				spr_walk	= global.sprCompatBloomingAssassinWalk;
				spr_hurt	= global.sprCompatBloomingAssassinHurt;
				spr_dead	= global.sprCompatBloomingAssassinDead;
			}
		break;
	}
	
#define CoastNight_step
	 // Run compat sprites on a delay to avoid issues with mod load order:
	if(compatCheck = false){
		compatTimer -= current_time_scale;
		if(compatTimer <= 0){
			compatCheck = true;
			CoastNight_compatsprite();
		    with(instances_matching(instances_matching(Floor, "sprite_index", _tespr.FloorCoast), "fr_coastNightRetexture2", null)){
				fr_coastNightRetexture2	= true;
		    	sprite_index			= global.sprFloorCoastNight;
		    }
		}
	}
    with(instances_matching(instances_matching(Floor, "sprite_index", _tespr.FloorCoast), "fr_coastNightRetexture", null)){
		fr_coastNightRetexture	= true;
    	sprite_index			= global.sprFloorCoastNight;
    }
	
#define CoastNight_cleanup
	
	 // Remove Night Credits:												
	if(GameCont.area != "coast") && (GameCont.area != 100){
		global.nightCredits = 0;
		 // Restore Coast Sprite:
		with(_tespr){
			FloorCoast		= global.sprFloorCoast;
			CoastTrans		= global.sprCoastTrans;
			PalankingChunk	= global.sprCompatPalankingChunk;
			PalankingBott	= global.sprCompatPalankingBott;
		}
	}
	sprite_restore(sprWind);	// bleehhhhh
	sprite_restore(sprLeaf);
	
	wait(2);
	if(fork()){
		while(instance_exists(mutbutton)){ wait(1); }
		if !(call(scr.event_get_active, "CoastNight")) {
			if(GameCont.area = "coast"){
				if(GameCont.proto = 1){
					sound_play_music(_temus.CoastB);	
				} else {
					sound_play_music(_temus.Coast);
				}
				global.eventMusicPlaying = false;
			}
		}
		exit;
	}
	global.isNight	= false;
	
//#region EVENT OBJECTS
#define Prop_hurt(_dmg, _spd, _dir)
	my_health -= _dmg;
	nexthurt   = current_frame + 6;
	
	sound_play_hit(snd_hurt, 0.3);
	
	sprite_index = spr_hurt;
	image_index  = 0;

//#region FLESH PROPS
#define BloodCocoon_create(_x, _y)

	with(instance_create(_x, _y, CustomProp)){
		
		 // Visual:
		spr_idle = global.sprBloodCocoon;
		spr_hurt = global.sprBloodCocoonHurt;
		spr_dead = global.sprBloodCocoonDead;
		
		 // Sounds:
		snd_hurt = sndHitFlesh;
		snd_dead = sndCocoonBreak;
		
		 // Vars: 
		maxhealth = 12;
		my_health = maxhealth;
		
		on_death = BloodCocoon_destroy;
		
		return self;
	}

#define BloodCocoon_destroy
	mod_script_call('mod', 'Frontier_Pickups', 'BloodLustPickup_create', x, y)

//#endregion
	
//#endregion
//#region LIGHTNING STRIKES
#define LightningStrikeSpawn_create(_x, _y)

	// Check For Ace:
	var foundAce = false;
	with(Player){
		if(race == "ace"){
			foundAce = true;
			break;
		}
	}

	with instance_create(_x,_y,CustomObject){
	 name				  = "fr_lightningspawn"
     creator    		  = other
     team       		  = 1; 

    sprite_index = global.sprLightningWarningCircle; 
    spr_blink    = global.sprLightningWarningCircleBlink;    
    
	if foundAce = true {
    	sprite_index = global.sprLightningWarningCircleAce; 
    	spr_blink    = global.sprLightningWarningCircleBlinkAce;
	}
    
	 image_speed	= 0.4;
	 depth      	= -1;
	 timer      	= 45;
	 image_xscale	= 0.1;
	 image_yscale	= image_xscale;
	 fr_bloom 		= [1.1, 0.1];
	 
	 on_step    		  = LightningStrikeSpawn_step;
	 on_destroy 		  = LightningStrikeSpawn_destroy;
	 
	}

#define LightningStrikeSpawn_step

	if (current_frame_active){
		with instance_create(x + random_range(-20, 20), y + random_range(-20, 20), FireFly){ 
			sprite_index	= sprLightning;
			speed			= random(3);
			direction		= random(360); 
			depth			= -3; 
		}
		if image_xscale < 1 { image_xscale += 0.25; image_yscale = image_xscale }
	}

	if (timer > 0)  { timer -= current_time_scale }
	if (timer < 12) { sprite_index = spr_blink; }
	if (timer <= 0) { instance_destroy(); }

#define LightningStrikeSpawn_destroy
	LightningStrike_create(x, y)

#define LightningStrike_create(_x, _y)

	// Messed with Defpack's lightning strikes for these, big ty for letting me use them

	sound_play_pitchvol(sndExplosion, random_range(1.2, 1.5), 1.2)
	sound_play_pitchvol(sndExplosionS, random_range(0.6, 0.8), 1.2)
	sound_play_pitchvol(sndLightningPistolUpg, random_range(0.6, 0.8), 1.2)
	sound_play_pitchvol(sndLightningCannonUpg, random_range(0.7, 1.2), 1.4)
    with instance_create(_x, _y, CustomProjectile){
        vbuf = vertex_create_buffer()
        lightning_refresh()
        hitid		 = [sprLightningHit, "Lightning Strike"]
        name		 = "Lightning Strike"
        time		 = 4;
        timestart	 = time;
        create_frame = current_frame;
        colors		 = [c_black, c_white, c_white, merge_color(c_white, c_white,.3), c_white]
        wantdust	 = 1;
        damage		 = 100;
        force		 = 40;
        mask_index   = sprPlasmaBall;
        image_xscale = 2.5;
        image_yscale = 2.5;
        on_wall 	 = lightning_wall;
        on_draw      = lightning_draw;
        on_destroy   = lightning_destroy;
        on_step      = lightning_step;
        on_hit       = lightning_hit;
        depth	     = -8;
        hitlist		 = [];

        return id
    }

#define lightning_wall
	with (other){
		instance_create(x, y, FloorExplo)
		instance_destroy()
	}

#define lightning_draw
	d3d_set_fog(1, colors[min((current_frame - create_frame),array_length_1d(colors)-1)], 0, 0)
	vertex_submit(vbuf, pr_trianglestrip, -1)
	d3d_set_fog(0, 0, 0, 0)
	for (var i = 0; i < array_length(ypoints); i++){
		draw_sprite(sprLightningHit, 1 + irandom(2), xpoints[i], ypoints[i])
		//draw_line_width(xpoints[i],ypoints[i],xpoints[i-1],ypoints[i-1],i/10)
	}
	
#define lightning_hit
	if(array_find_index(hitlist,other) == -1){
		array_push(hitlist, other);
		with(other){
			if instance_is(self, Player){
				 switch(race){
    	    		case "robot": 
						mod_script_call('mod', "Frontier_StatusEffects", "status_apply_add", self, mod_variable_get('mod', "Frontier_StatusEffects", 'buffFirerateUp'), 450)
						mod_script_call('mod', "Frontier_StatusEffects", "status_apply_add", self, mod_variable_get('mod', "Frontier_StatusEffects", 'buffSpeedUp'), 450)
						my_health -= 3;
		
    				break;
        
	    			default: 
	    				if mod_script_exists("race", race, "race_fr_thunderstruck"){
	    					mod_script_call_self("race", race, "race_fr_thunderstruck")
						 }
           
						else{
							projectile_hit(self, other.damage, other.force)
							lasthit = [sprLightningHit, "LIGHTNING STRIKE"]
						}			
				}
    		}
   
		else{
				projectile_hit(self,other.damage,other.force)
				lasthit = [sprLightningHit, "LIGHTNING STRIKE"]
			}
		}
	}

#define lightning_refresh
	ypoints = []
	xpoints = []
	var mmax = 100;
	var mmin = -100;
	var xx = x;
	var yy = y;

	var ang = random_range(70, 110)
	var width = 0.8, length = 10
	var bwidth = 0.8                 // Thickness
	var n = 0
	vertex_begin(vbuf, global.lightningformat)
	vertex_position(vbuf, xx, yy)
	while yy > y - 2 * game_height{
		vertex_position(vbuf, xx + width * ((n mod 2) ? -1 : 1), yy)
    	n++
    	xx += lengthdir_x(length,ang)
    	yy += lengthdir_y(length,ang)
    	length = random(6)
    	width = (y - yy) / 75 + bwidth
    	ang = clamp(ang + random_range(7, 30) * choose(-1, 1) * (min((y - yy), 20)) / 20, 40, 140)
    	if ang = 40 or ang = 140 ang -= random_range(5, 20) * sign(ang - 90)
    	if !irandom(5) {
        	array_push(xpoints, xx)
        	array_push(ypoints, yy)
    	}
	}
vertex_end(vbuf)
vertex_freeze(vbuf)

#define slope(x1,x2,y1,y2)
return((y2-y1)/(x2-x1))

#define lightning_destroy
	if (global.settingLightningFlash = true){
		with script_bind_draw(lightning_flash, -30){
	    	fadeoutmax	= room_speed
	    	fadeout 	= fadeoutmax
	    	psuedowait	= 2;
		}
	}

	instance_create(x, y, MeltSplat)

	for (var i = 1; i < array_length_1d(ypoints); i++){
		if !irandom(4) with instance_create(xpoints[i], ypoints[i], FireFly){
			depth = other.depth;
			image_speed /= 1.5;
			sprite_index = sprLightning;
			hspeed += random_range(-0.5, 0.5);
			vspeed += random_range(-0.5, 0.5);
		}
	}
	vertex_delete_buffer(vbuf)

#define lightning_step
view_shake_max_at(x, y, 30)
if wantdust != 0{
    repeat(12){
  		with instance_create(x, y, Dust){
  		  motion_set(random(360),3 + random(5))
	    }
  	}
    repeat(8){
        with instance_create(x+random_range(-30, 30),y+random_range(-30, 30), LightningSpawn){
            image_angle = point_direction(other.x, other.y, x, y) + random_range(-8, 8)
        }
    }
  	if instance_exists(Floor){
  	    var closeboy = instance_nearest(x, y, Floor);
      	if point_in_rectangle(x, y,closeboy.x - 16, closeboy.y - 16, closeboy.x + 16, closeboy.y + 16){
      	    with instance_create(x,y,Scorchmark){
      	        time = 0;
      	        if fork(){
      	            while instance_exists(self) && time < 45{
      	                time += current_time_scale
      	                image_alpha -= current_time_scale / 45
      	                if PercentChance(45 - time){
      	                    with instance_create(x,y,Smoke){
      	                        motion_add(90, random_range(1, 2))
      	                        image_xscale = (1 - (other.time / 45)) * random_range(0.5, 1)
      	                        image_yscale = image_xscale
      	                        gravity = -friction
      	                    }
      	                }
      	                wait(0)
      	            }
      	            if instance_exists(self) instance_destroy()
      	            exit
      	        }
      	    }
      	}
  	}
  	wantdust = 0
}
time -= current_time_scale
if time <= 0 instance_destroy()


#define lightning_flash
	psuedowait -= current_time_scale
	if (psuedowait <= 0){
    	draw_set_blend_mode(bm_add)
    	draw_sprite_ext(sprSuperFlakBullet, 1, view_xview_nonsync + game_width / 2 ,view_yview_nonsync + game_height / 2, 100, 100, random(360), c_white, fadeout / fadeoutmax * 0.45)
    	draw_set_blend_mode(bm_normal)
    
    	fadeout -= 4
    
    	if !fadeout instance_destroy();
	}

//#endregion
//#region METEORS

#define PickupStar_create(_x, _y)
	with(FallenStar_create(_x, _y)){
		var _pickup = choose("ammo", "health", "rads")
		switch(_pickup){
			case "ammo":
				starColor	= $14cbf9;
				trailColor	= starColor;
				image_blend	= starColor;
				dropItem	= AmmoPickup;			
			break;
			case "health":
				starColor	= $7e74ff;
				trailColor	= starColor;
				image_blend	= starColor;
				dropItem	= HPPickup;
			break;
			case "rads":
				starColor	= $55ff47;
				trailColor	= starColor;
				image_blend	= starColor;
				dropItem	= BigRad;	
			break;
		}
				
		return self;
	}
	
#define FallenStar_create(_x, _y)
	with(instance_create(_x + random_range(-380, 380), _y - 1000, CustomObject)){
		name = "fr_fallenstar";
		
		 // Visuals:
		sprite_index	= global.sprMeteorGlow;
		depth			= -13;
		starColor		= choose($ffcf2d, $fff171, $e1ff71, $fff9bf);
		trailColor		= starColor;
		image_blend		= starColor;
		image_xscale	= 0.6
		trailDis		= -4; 
		rotSpeed		= (20 + random(15)) * choose(1, -1);
		image_speed		= 0.4;
		
		if(random(3) < 1){
			image_xscale	= 1;
			trailDis		= -8;

		}
		
		image_yscale	= image_xscale;
		 
		 // Vars:
		speed			= 10 + random(4);
		dropItem		= null;
		landingZone		= { x: _x, y: _y };
		direction		= point_direction(x, y, landingZone.x, landingZone.y)
		
		
		
		on_step 		= FallenStar_step;
		on_end_step		= FallenStar_endstep;
		on_destroy		= FallenStar_destroy;
		
		
		return self;
	}

#define FallenStar_step
	if(current_frame_active){
		image_angle += rotSpeed;
		
		if(random(4) < 1){
			with(instance_create(x, y, PlasmaTrail)){
				sprite_index	= global.sprMeteorSparkle;
				image_blend		= other.starColor;
				direction		= (other.direction + 180) + random_range(-35, 35);
				speed			= 3 + random(3);
				friction		= 0.4;
				depth			= other.depth - 1;
			}
		}
	}

	if(y > landingZone.y){
		instance_destroy();
	}

#define FallenStar_endstep
	var _x = x + lengthdir_x(trailDis, direction),
		_y = y + lengthdir_y(trailDis, direction),
		_xPrev = xprevious + lengthdir_x(trailDis, direction),
		_yPrev = yprevious + lengthdir_y(trailDis, direction);		
	with(GenericTrail_create(_x, _y)){
		depth			= other.depth + 1;
		image_xscale	= point_distance(_x, _y, _xPrev, _yPrev)
		image_yscale   *= other.image_xscale * 9;
		image_speed    *= 3;
		image_angle 	= point_direction(_x, _y, _xPrev, _yPrev)
		image_blend 	= other.trailColor;
		image_alpha		= 1
	    if fork(){
	        while(instance_exists(self)){
	            image_alpha -= 0.09;
	            wait(0)
	        }
	        exit
	    }
	}
	
#define FallenStar_destroy
	if(dropItem != null){
		instance_create(x, y, dropItem);
	}
	with(instance_create(x, y, BulletHit)){
		sprite_index	= global.sprMeteorHit;
		image_blend		= other.starColor;
	}
	repeat(7){
		with(instance_create(x, y, PlasmaTrail)){
			sprite_index	= global.sprMeteorSparkle;
			image_blend		= other.starColor;
			direction		= random(360);
			speed			= 3 + random(3);
			friction		= 0.4;
			image_angle		= random(360);
		}
	}
	
	sound_play_hit(sndHitWall, 0.2);
	
//#endregion
//#region SOLAR FLARES
#define SolarFlareSpawn_create(_x, _y)
	with(instance_create(_x, _y, CustomObject)){
		
		 // Visuals:
		sprite_index	= global.sprSolarFlareWarning;
		image_speed		= 0.4;
		depth			= -1;
		fr_bloom		= [1.2, 0.2];
		
		 // Vars:
		if(random(1) < 1){
			var big = true;
			sprite_index = global.sprSolarFlareWarningBig;
		} else {
			var big = false;
		}
		flare			= SolarFlare_create(_x, _y, big);
		
		 // Events:
		on_step			= SolarFlareSpawn_step;
		
		return self;
	}
	
#define SolarFlareSpawn_step
	image_angle += 4 * current_time_scale;

	if(!instance_exists(flare)){
		instance_destroy();
	}
	
#define SolarFlare_create(_x, _y, _big)
	with instance_create(_x + random_range(-380, 380), _y - 1000, CustomObject){
		
		name = "fr_solarflare"
		
		 // Visuals:
		sprite_index	= (_big ? sprPlasmaBallHuge : sprHeavyBullet);
		image_angle		= direction;
		image_index 	= 0;
		image_speed 	= 0;
		depth			= -9;
		fr_bloom 	    = [1.2, 0.2];
		
		 // Vars:
		target			= {x: _x, y:_y}
		direction		= point_direction(x, y, target.x, target.y)
		speed			= random_range(16, 20);
		bigFlare		= _big
		
		 // Events:
		on_step			= SolarFlare_step;
		
		return self;
	}

#define SolarFlare_step
	if(current_frame_active){
		if(random(5) < 1){
			with instance_create(x + random_range(-10, 10), y + random_range(-10, 10), BulletHit){
				depth		 = other.depth;
				sprite_index = global.sprMeteorSparkle;
				image_xscale = random_range(0.5, 1);
				image_yscale = image_xscale;
				speed		 = 5;
				friction	 = 0.4;
				direction	 = other.direction + 180;
			}
		}
	
		 // Hit!
		if(y > target.y){
			y = target.y;
		}
		if(y >= target.y){
			repeat(random_range(5, 9)){
				with instance_create(x + random_range(-10, 10), y + random_range(-10, 10), BulletHit){
					depth		 = other.depth;
					sprite_index = global.sprMeteorSparkle;
					image_xscale = random_range(0.5,1);
					image_yscale = image_xscale;
					speed		 = random(6);
					friction	 = 0.4;
					direction	 = random(360);
				}		
			}
			if(bigFlare = true){
				instance_create(x, y, Explosion)
			} else {
				instance_create(x, y, SmallExplosion)
			}
			sound_play_pitchvol(sndHitWall, random_range(0.5, 0.9), 0.5);
			instance_destroy();
		}
	}

	
//#endregion
#define PercentChance(percentage)
	return random(100) <= percentage * current_time_scale

#define nothing
//grrr!! im evil!!! waaa!!

#define every(_num) //every _num frames (objectively) trigger
	return frac(current_frame/_num) < current_time_scale/_num

#define GenericTrail_create(_x, _y) 
    with instance_create(_x, _y, Wind){
        sprite_index     = global.sprGenericTrail;
        mask_index       = mskNone;
        image_speed      = 2;
        image_yscale     = (1/50);
        image_xscale     = 1;
        depth			 = 0;
        
        return self;
    }

#macro current_frame_active 																	frac(current_frame) < current_time_scale
#macro anim_end 																				((image_index + image_speed_raw) >= image_number || (image_index + image_speed_raw) < 0)
#macro _tespr																					mod_variable_get("mod", "teassets", "spr");
#macro _temus																					mod_variable_get("mod", "teassets", "snd").mus;
#macro _vagabondsspr																			mod_variable_get("mod", "vagabonds_assets", "sprite");
#macro  area_current																			instance_exists(GameCont) ? [GameCont.area, GameCont.subarea] : [-1, -1] 
#macro  FloorNormal																				instances_matching(Floor, "object_index", Floor)
#macro  bbox_center_x                                                                           (bbox_left + bbox_right + 1) / 2
#macro  bbox_center_y                                                                           (bbox_top + bbox_bottom + 1) / 2
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
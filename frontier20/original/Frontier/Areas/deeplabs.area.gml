#define init

		// LIB:
	while(!mod_exists("mod", "lib")){wait(1);}
	script_ref_call(["mod", "lib", "getRef"], "area", mod_current, "scr");
	#macro  scr			global.scr
	#macro  call		script_ref_call
	
		// SETTINGS //
	global.settingDarkCoreExplosion				= false;
	global.settingLabsRouteAltMode				= false;
	global.settingVeeOneHundred					= (game_version > 0);
	
	global.settingEnemyRandomizer				= false // randomizes spawns from enemy elevators, for use with things like wnw slot machine mode
	global.enemyRandomizerSpawnpool				= [
											//		mod, spawn function, amount (range), spawnweight
											//		[["Basegame",		Bandit, 			[4, 8]], 1],
											//		[["Frontier_Labs", "Swarmbot_create",	[4, 8]], 1],
												]
	
		// DEBUG MODE //
	#macro deeplabsDebug						false;	// toggles debug visuals for deeplabs finale
	#macro autoBomb								true;	// toggles automatic bomb trigger for finale (leave on, meant for debugging)
	#macro reposition							true;	// changes spawn point to elevator platform, can turn off for debugging
	
		// Vars: //
	global.deeplabsSpecial						= false;
	global.surfaceSpinTurret					= -4;
	global.safeZone								= noone;
	global.areaBackgroundPos					= 0;
	global.bombTimer							= 120;
	global.subjectNodeNum						= 0;
	global.panelSound							= noone;
	deeplabsRoom_init();
	global.deeplabsMusic						= noone;
	global.deeplabsMusicVolume					= 0;
	global.esploded 							= false;
	
		// Sounds: //
	global.musDeeplabs							= sound_add("../sounds/music/musDeeplabs.ogg");
	global.sndDeeplabsOutro						= sound_add("../sounds/music/sndDeeplabsOutro.ogg");
	global.musDeeplabsAftermath					= sound_add("../sounds/music/musDeeplabsAftermath.ogg");
	global.ambDeeplabs							= sound_add("../sounds/ambience/ambDeeplabs.ogg");


	global.sndDeeplabsTremor = [				sound_add("../sounds/deeplabs/sndDeeplabsTremor.ogg"),
												sound_add("../sounds/deeplabs/sndDeeplabsTremor2.ogg"),
												sound_add("../sounds/deeplabs/sndDeeplabsTremor3.ogg"),
												sound_add("../sounds/deeplabs/sndDeeplabsTremor4.ogg"),
												sound_add("../sounds/deeplabs/sndDeeplabsTremor5.ogg"),
												sound_add("../sounds/deeplabs/sndDeeplabsTremor6.ogg"),
												sound_add("../sounds/deeplabs/sndDeeplabsTremor7.ogg")]
	global.sndBlank								= sound_add("../sounds/sndBlank.ogg");
	global.sndBlank2							= sound_add("../sounds/sndBlank.ogg");
	global.sndDeeplabsSpill						= sound_add("../sounds/deeplabs/sndDeeplabsSpill.ogg");
	global.sndDeeplabsCoreIdle = [
												sound_add("../sounds/deeplabs/sndDeeplabsCoreIdle.ogg"),
												sound_add("../sounds/deeplabs/sndDeeplabsCoreIdle2.ogg"),
												sound_add("../sounds/deeplabs/sndDeeplabsCoreIdle3.ogg"),
												sound_add("../sounds/deeplabs/sndDeeplabsCoreIdle4.ogg"),
												sound_add("../sounds/deeplabs/sndDeeplabsCoreIdle5.ogg")]

	global.sndDeeplabsCoreExplosion				= sound_add("../sounds/deeplabs/sndDeeplabsCoreExplosion.ogg");
	global.sndPuzzleCompleted					= sound_add("../sounds/deeplabs/sndPuzzleCompleted.ogg");
	global.sndDeeplabsPodFly					= sound_add("../sounds/deeplabs/sndDeeplabsPodFly.ogg");
	global.sndDeeplabsCoreControls				= sound_add("../sounds/deeplabs/sndAlienware.ogg");
	global.sndDeeplabsCoreControlsDanger		= sound_add("../sounds/deeplabs/sndAlienwareMeltdown.ogg");
	
		// Area Sprites //
	global.sprAreaIcon							= sprite_add("../sprites/menu/sprLabsRouteIcon.png",						1, 4, 4);
	global.sprFloor 							= sprite_add("../sprites/areas/deeplabs/sprFloorDeeplabs.png",				2, 0, 0);
	global.sprFloorB							= sprite_add("../sprites/areas/deeplabs/sprFloorDeeplabs.png",				2, 0, 0);
	global.sprFloorExplo						= sprite_add("../sprites/areas/deeplabs/sprFloorDeeplabsExplo.png", 		4, 1, 1);
	global.sprWallBot							= sprite_add("../sprites/areas/deeplabs/sprWallDeeplabsBot.png",			6, 0, 0);
	global.sprWallTop							= sprite_add("../sprites/areas/deeplabs/sprWallDeeplabsTop.png",			3, 0, 0);
	global.sprWallOut							= sprite_add("../sprites/areas/deeplabs/sprWallDeeplabsOut.png",			1, 4, 12);
	global.sprWallTrans							= sprite_add("../sprites/areas/deeplabs/sprWallDeeplabsTrans.png",			3, 0, 0);
	global.sprDebris							= sprite_add("../sprites/areas/deeplabs/sprDebrisDeeplabs.png", 			4, 4, 4);
	global.sprDetail							= sprite_add("../sprites/areas/deeplabs/sprDetailDeeplabs.png", 			6, 4, 4);
	global.sprFogDeeplabs						= sprite_add("../sprites/areas/deeplabs/sprFogDeeplabs.png",				1, 0, 0);
	global.sprFogDeeplabs2						= sprite_add("../sprites/areas/deeplabs/sprFogDeeplabs2.png",				1, 0, 0);
	
		// Prop Sprites //
	 // Terminal (Off):
	global.sprTerminalOff						= sprite_add("../sprites/areas/deeplabs/props/sprTerminalOff.png",			1, 12, 12);
	global.sprTerminalOffHurt					= sprite_add("../sprites/areas/deeplabs/props/sprTerminalOffHurt.png",		3, 12, 12);
	
	 // Tubes:
	global.sprBigTube							= sprite_add("../sprites/areas/deeplabs/props/sprBigTube.png",				1, 24, 24);
	global.sprBigTubeBack						= sprite_add("../sprites/areas/deeplabs/props/sprBigTubeBack.png",			1, 24, 24);
	global.mskBigTube							= sprite_add("../sprites/areas/deeplabs/props/mskBigTube.png",				1, 24, 24);
	global.sprBigTubeHurt						= sprite_add("../sprites/areas/deeplabs/props/sprBigTubeHurt.png",			3, 24, 24);
	global.sprBigTubeDead						= sprite_add("../sprites/areas/deeplabs/props/sprBigTubeDead.png",			3, 24, 24);
	global.sprTubeStreak						= sprite_add("../sprites/particles/sprTubeStreak.png",						7, 8, 8);
	global.sprTubeDebris						= sprite_add("../sprites/areas/deeplabs/props/sprDebrisTube.png",			4, 4, 4);
	global.sprTubeDebrisBig						= sprite_add("../sprites/areas/deeplabs/props/sprDebrisTubeBig.png",		3, 8, 8);
	global.sprProtoStatueTube					= sprite_add("../sprites/areas/deeplabs/props/sprProtoStatueTube.png",		1, 32, 40);
	global.sprProtoStatueTubeHurt				= sprite_add("../sprites/areas/deeplabs/props/sprProtoStatueTubeHurt.png",	3, 32, 40);
	global.sprProtoStatueTubeDead				= sprite_add("../sprites/areas/deeplabs/props/sprProtoStatueTubeDead.png",	3, 32, 40);
	global.sprProtoStatueTubeDeadFront			= sprite_add("../sprites/areas/deeplabs/props/sprProtoStatueTubeDeadFront.png",	2, 21, 7);
	global.sprProtoStatueTubeBack				= sprite_add("../sprites/areas/deeplabs/props/sprProtoStatueTubeBack.png",	1, 32, 40);
	global.mskHugeTube							= sprite_add("../sprites/areas/deeplabs/props/mskHugeTube.png",				1, 32, 40);
	global.sprHugeTube							= sprite_add("../sprites/areas/deeplabs/props/sprHugeTube.png",				1, 32, 40);
	global.sprHugeTubeBack						= sprite_add("../sprites/areas/deeplabs/props/sprHugeTubeBack.png",			1, 32, 40);
	global.sprHugeTubeHurt						= sprite_add("../sprites/areas/deeplabs/props/sprHugeTubeHurt.png",			3, 32, 40);
	global.sprHugeTubeDead						= sprite_add("../sprites/areas/deeplabs/props/sprHugeTubeDead.png",			3, 32, 40);
	global.shdHugeTube							= sprite_add("../sprites/areas/deeplabs/props/shdHugeTube.png",				1, 38, 11);
	global.sprVoltergeistTube					= sprite_add("../sprites/areas/deeplabs/props/sprVoltergeistTube.png",		1, 16, 20);
	global.sprVoltergeistTubeHurt				= sprite_add("../sprites/areas/deeplabs/props/sprVoltergeistTubeHurt.png",	3, 16, 20);
	global.sprVoltergeistTubeDead				= sprite_add("../sprites/areas/deeplabs/props/sprVoltergeistTubeDead.png",	3, 16, 20);
	
	 // BigTube Objects:
	global.sprBigTubeObjects					= sprite_add("../sprites/areas/deeplabs/props/tubeobjects/sprBigTubeObjects.png", 12, 24, 24);
	global.sprHugeTubeObjects					= sprite_add("../sprites/areas/deeplabs/props/tubeobjects/sprHugeTubeObjects.png", 2, 32, 32);
	
 	 // Generator:
	global.sprGenerator							= sprite_add("../sprites/areas/deeplabs/props/sprGenerator.png",			1, 16, 16);
	global.sprGeneratorHurt						= sprite_add("../sprites/areas/deeplabs/props/sprGeneratorHurt.png",		3, 16, 16);
	global.sprGeneratorDead						= sprite_add("../sprites/areas/deeplabs/props/sprGeneratorDead.png",		3, 16, 16);
	global.sprGeneratorActive					= sprite_add("../sprites/areas/deeplabs/props/sprGeneratorActive.png",		4, 16, 16);
	
	
		// FINALE:
	 // Bomb Timer:
	global.sprBombTimer							= sprite_add("../sprites/menu/sprBombTimer.png",							1, 41, 0);
	global.sprBombTimerBack						= sprite_add("../sprites/menu/sprBombTimerBack.png",						1, 25, 30);
	
	 // Start Room:
	 
	 // End Room:

	
	 // Catwalks:
	global.sprFloorCatwalk						= sprite_add("../sprites/areas/deeplabs/sprFloorCatwalk.png",				1, 0, 3);
	global.sprFloorCatwalkVertical				= sprite_add("../sprites/areas/deeplabs/sprFloorCatwalkVertical.png",		1, 8, 0);
	global.sprFloorCatwalkDownRight				= sprite_add("../sprites/areas/deeplabs/sprFloorCatwalkDownRight.png",		1, 0, 0);
	global.sprFloorCatwalkDestroyed				= sprite_add("../sprites/areas/deeplabs/sprFloorCatwalkDestroyed.png",		1, 40, 0);
//	global.sprCatwalkRailing					= sprite_add("../sprites/areas/deeplabs/sprCatwalkRailing.png",				1, 0, 5);
//	global.sprCatwalkRailingBack				= sprite_add("../sprites/areas/deeplabs/sprCatwalkRailingBack.png",			1, 0, 5);
//	global.sprCatwalkRailingVertical			= sprite_add("../sprites/areas/deeplabs/sprCatwalkRailing.png",				1, 0, 0);

	 // Barrier:
	global.sprBarrier							= sprite_add("../sprites/areas/deeplabs/sprBarrier.png",					4, 24, 20);	 
	global.sprBarrierOff						= sprite_add("../sprites/areas/deeplabs/sprBarrierOff.png",					1, 24, 20);	 
	global.sprBarrierZapper						= sprite_add("../sprites/areas/deeplabs/sprBarrierZapper.png",				4, 24, 20);	 
	global.mskBarrierZapper						= sprite_add("../sprites/areas/deeplabs/mskBarrierZapper.png",				1, 24, 24);	 
	global.sprBarrierVertical					= sprite_add("../sprites/areas/deeplabs/sprBarrierVertical.png",			4, 24, 34);	 
	global.sprBarrierVerticalOff				= sprite_add("../sprites/areas/deeplabs/sprBarrierVerticalOff.png",			1, 24, 34);	 
	global.sprBarrierVerticalBack				= sprite_add("../sprites/areas/deeplabs/sprBarrierVerticalBack.png",		4, 24, 30);	 
	global.sprBarrierVerticalBackOff			= sprite_add("../sprites/areas/deeplabs/sprBarrierVerticalBackOff.png",		1, 24, 30);	 
	global.sprBarrierZapperVertical				= sprite_add("../sprites/areas/deeplabs/sprBarrierZapperVertical.png",		4, 24, 30);	 
	global.mskBarrierZapperVertical				= sprite_add("../sprites/areas/deeplabs/mskBarrierZapperVertical.png",		1, 24, 30);	 
	global.sprBarrierGameover					= sprite_add("../sprites/areas/deeplabs/sprBarrierGameover.png",			4, 24, 24);	 
	global.sprBarrierFizzle	= [					sprite_add("../sprites/particles/sprBarrierFizzle.png",						4, 2, 2),	 
												sprite_add("../sprites/particles/sprBarrierFizzle2.png",					4, 2, 2),
												sprite_add("../sprites/particles/sprBarrierFizzle3.png",					4, 2, 2),
												sprite_add("../sprites/particles/sprBarrierFizzle4.png",					4, 2, 2)];
	global.sprBarrierIcon						= sprite_add("../sprites/menu/sprBarrierIcon.png",							1, 4, 4);	 	
	
	 // Spawn Objects:
	global.mskRoomHitbox						= sprite_add("../sprites/areas/deeplabs/mskRoomHitbox.png",					1, 16, 16);	 
	global.sprEnemyElevatorIdle					= sprite_add("../sprites/areas/deeplabs/props/sprEnemyElevatorIdle.png",	1, 32, 32);	 
	global.sprEnemyElevatorActive				= sprite_add("../sprites/areas/deeplabs/props/sprEnemyElevatorActive.png",	32, 32, 32);	
	global.sprEnemyElevatorDone					= sprite_add("../sprites/areas/deeplabs/props/sprEnemyElevatorDone.png",	1, 32, 32);	
	
	 // Color Puzzle:
	global.sprColorBulb							= sprite_add("../sprites/areas/deeplabs/props/sprColorBulb.png",			1, 8, 12);	 
	global.sprColorBulbOverlay					= sprite_add("../sprites/areas/deeplabs/props/sprColorBulbOverlay.png",		1, 8, 12);	 
	
	 // Pressure Plate:
	global.mskPressureButton					= sprite_add("../sprites/areas/deeplabs/props/mskColorButton.png",			1, 10, 10);	 
	global.sprPressureButton					= sprite_add("../sprites/areas/deeplabs/props/sprColorButton.png",			2, 10, 10);	 
	global.sprPressureButtonOverlay				= sprite_add("../sprites/areas/deeplabs/props/sprColorButtonOverlay.png",	2, 10, 10);	 
	
	 // Spin Turret:
	global.sprSpinTurretBase					= sprite_add("../sprites/enemies/spinturret/sprSpinTurretBase.png",			1, 16, 16);
	global.sprSpinTurretTop						= sprite_add("../sprites/enemies/spinturret/sprSpinTurretTop.png",			1, 16, 16);	 
	global.sprSpinTurretTopOff					= sprite_add("../sprites/enemies/spinturret/sprSpinTurretTopOff.png",		1, 16, 16);	 
	global.sprSpinTurretGun						= sprite_add("../sprites/enemies/spinturret/sprSpinTurretGun.png",			4, 32, 32);	
	global.sprSpinTurretDead					= sprite_add("../sprites/enemies/spinturret/sprSpinTurretDead.png",			6, 24, 29);	
	global.sprSpinTurretGameover				= sprite_add("../sprites/enemies/spinturret/sprSpinTurretGameover.png",		1, 24, 24);	
	global.sprSpinTurretTopPossessed			= sprite_add("../sprites/enemies/spinturret/sprSpinTurretTopPossessed.png",			1, 16, 16);	 
	global.sprSpinTurretTopOffPossessed			= sprite_add("../sprites/enemies/spinturret/sprSpinTurretTopOffPossessed.png",		1, 16, 16);	 
	global.sprSpinTurretGameoverPossessed		= sprite_add("../sprites/enemies/spinturret/sprSpinTurretGameoverPossessed.png",	1, 24, 24);	
	
	 // Laser Turret:
	global.sprLaserTurret						= sprite_add("../sprites/areas/deeplabs/sprLaserTurret.png",				1, 11, 6);	 
	global.sprLaserTurretGameover				= sprite_add("../sprites/areas/deeplabs/sprLaserTurretGameover.png",		2, 12, 11);	 
	global.sprLaserTurretSource					= sprite_add("../sprites/areas/deeplabs/sprLaserTurretSource.png",			1, 12, 12);	 
	global.sprLaserTurretSourceTop				= sprite_add("../sprites/areas/deeplabs/sprLaserTurretSourceTop.png",		1, 12, 12);
	global.sprLaserTrapBeam     				= sprite_add("../sprites/projectiles/sprLaserTrapBeam.png", 				1, 0, 6);
	global.mskLaserTrapBeam     				= sprite_add("../sprites/projectiles/mskLaserTrapBeam.png", 				1, 2, 6);
	global.sprLaserTrapBeamEnd  				= sprite_add("../sprites/particles/sprLaserTrapBeamEnd.png",				3, 5, 5);
	global.sprLaserTrapBeamStart				= sprite_add("../sprites/projectiles/sprLaserTrapBeamStart.png",			0, 8, 8);
	global.sprLaserTrapHead 					= sprite_add("../sprites/projectiles/sprLaserTrapHead.png", 				0, 8, 2)
	
	 // Structure Decals:
	global.sprBotLayer3x5						= sprite_add("../sprites/areas/deeplabs/roomdecals/sprBotLayer3x5.png",			1, 0, 0);	 
	global.sprColorPuzzleBack					= sprite_add("../sprites/areas/deeplabs/roomdecals/sprColorPuzzleBack.png",		1, 0, 0);	 	 // can merge with main
	global.sprColorPuzzleFront					= sprite_add("../sprites/areas/deeplabs/roomdecals/sprColorPuzzleFront.png",	1, 0, 0);	 
	global.sprLUpRoomMain						= sprite_add("../sprites/areas/deeplabs/roomdecals/sprLUpRoomMain.png",			1, 0, 0);	 
	global.sprLUpRoomFront						= sprite_add("../sprites/areas/deeplabs/roomdecals/sprLUpRoomFront.png",		1, 0, 0);	 
	global.sprFreakParkMain						= sprite_add("../sprites/areas/deeplabs/roomdecals/sprFreakParkMain.png",		1, 0, 0);	 
	global.sprFreakParkMainFront				= sprite_add("../sprites/areas/deeplabs/roomdecals/sprFreakParkMainFront.png",	1, 0, 0);	 
	global.sprFreakParkFront					= sprite_add("../sprites/areas/deeplabs/roomdecals/sprFreakParkFront.png",		1, 0, 0);	 
	global.spr6x6RDMain							= sprite_add("../sprites/areas/deeplabs/roomdecals/spr6x6RDMain.png",			1, 0, 0);	 
	global.spr6x6RDMainFront					= sprite_add("../sprites/areas/deeplabs/roomdecals/spr6x6RDMainFront.png",		1, 0, 0);	 
	global.spr6x6RDFront						= sprite_add("../sprites/areas/deeplabs/roomdecals/spr6x6RDFront.png",			1, 0, 0);	
	global.sprLDownRoomMain						= sprite_add("../sprites/areas/deeplabs/roomdecals/sprLDownRoomMain.png",		1, 0, 0);	 
	global.sprLDownRoomMainFront				= sprite_add("../sprites/areas/deeplabs/roomdecals/sprLDownRoomMainFront.png",	1, 0, 0);	 
	global.sprLDownRoomFront					= sprite_add("../sprites/areas/deeplabs/roomdecals/sprLDownRoomFront.png",		1, 0, 0);
	global.spr6x6RRMain							= sprite_add("../sprites/areas/deeplabs/roomdecals/spr6x6RRMain.png",			1, 0, 0);	 
	global.spr6x6RRFront						= sprite_add("../sprites/areas/deeplabs/roomdecals/spr6x6RRFront.png",			1, 0, 0);
	global.spr6x10UUMain						= sprite_add("../sprites/areas/deeplabs/roomdecals/spr6x10UUMain.png",			1, 0, 0);	
	global.spr6x10UUMainFront					= sprite_add("../sprites/areas/deeplabs/roomdecals/spr6x10UUMainFront.png",		1, 0, 0);	
	global.spr6x10UUFront						= sprite_add("../sprites/areas/deeplabs/roomdecals/spr6x10UUFront.png",			1, 0, 0);	
	global.spr9x9DRRoomMain						= sprite_add("../sprites/areas/deeplabs/roomdecals/spr9x9DRRoomMain.png",		1, 0, 0);	
	global.spr9x9DRRoomFront					= sprite_add("../sprites/areas/deeplabs/roomdecals/spr9x9DRRoomFront.png",		1, 0, 0);
	global.spr9x5DRMain							= sprite_add("../sprites/areas/deeplabs/roomdecals/spr9x5DRMain.png",			1, 0, 0);
	global.spr9x5DRFront						= sprite_add("../sprites/areas/deeplabs/roomdecals/spr9x5DRFront.png",			1, 0, 0);	 
	global.sprFiringSquadMain					= sprite_add("../sprites/areas/deeplabs/roomdecals/sprFiringSquadMain.png",		1, 0, 0);
	global.sprFiringSquadFront					= sprite_add("../sprites/areas/deeplabs/roomdecals/sprFiringSquadFront.png",	1, 0, 0);
	global.spr5x8URMain							= sprite_add("../sprites/areas/deeplabs/roomdecals/spr5x8URMain.png",			1, 0, 0);
	global.spr5x8URMainFront					= sprite_add("../sprites/areas/deeplabs/roomdecals/spr5x8URMainFront.png",		1, 0, 0);
	global.spr5x8URFront						= sprite_add("../sprites/areas/deeplabs/roomdecals/spr5x8URFront.png",			1, 0, 0);
	global.sprChokepointMain					= sprite_add("../sprites/areas/deeplabs/roomdecals/sprChokepointMain.png",		1, 0, 0);
	global.sprChokepointFront					= sprite_add("../sprites/areas/deeplabs/roomdecals/sprChokepointFront.png",		1, 0, 0);
	global.sprStartRoomMain						= sprite_add("../sprites/areas/deeplabs/roomdecals/sprStartRoomMain.png",		1, 0, 0);
	global.sprStartRoomFront					= sprite_add("../sprites/areas/deeplabs/roomdecals/sprStartRoomFront.png",		1, 0, 0);
	global.sprElevatorPlatformMain				= sprite_add("../sprites/areas/deeplabs/roomdecals/sprElevatorPlatformMain.png",1, 0, 0);
	global.sprStartTopRoomMain					= sprite_add("../sprites/areas/deeplabs/roomdecals/sprStartTopRoomMain.png",	1, 0, 0);
	global.sprStartTopRoomMainFront				= sprite_add("../sprites/areas/deeplabs/roomdecals/sprStartTopRoomMainFront.png",1, 0, 0);
	global.sprStartBotRoomMain					= sprite_add("../sprites/areas/deeplabs/roomdecals/sprStartBotRoomMain.png",	1, 0, 0);
	global.sprStartBotRoomFront					= sprite_add("../sprites/areas/deeplabs/roomdecals/sprStartBotRoomFront.png",	1, 0, 0);
	global.sprEndRoomMain						= sprite_add("../sprites/areas/deeplabs/roomdecals/sprEndRoomMain.png",			1, 0, 0);
	global.sprEndRoomMainFront					= sprite_add("../sprites/areas/deeplabs/roomdecals/sprEndRoomMainFront.png",	1, 0, 0);
	global.sprEndRoomFront						= sprite_add("../sprites/areas/deeplabs/roomdecals/sprEndRoomFront.png",		1, 0, 0);
	global.sprEndRoomRoof						= sprite_add("../sprites/areas/deeplabs/roomdecals/sprEndRoomRoof.png",			1, 0, 0);
	global.sprEndRoomForcefield					= sprite_add("../sprites/areas/deeplabs/roomdecals/sprEndRoomForcefield.png",	3, 20, 20);
	global.sprEndRoomMainCharred				= sprite_add("../sprites/areas/deeplabs/roomdecals/sprEndRoomMainCharred.png",		1, 0, 0);
	global.sprEndRoomMainFrontCharred			= sprite_add("../sprites/areas/deeplabs/roomdecals/sprEndRoomMainFrontCharred.png",	1, 0, 0);
	global.sprEndRoomFrontCharred				= sprite_add("../sprites/areas/deeplabs/roomdecals/sprEndRoomFrontCharred.png",		1, 0, 0);
	global.sprEndRoomRoofCharred				= sprite_add("../sprites/areas/deeplabs/roomdecals/sprEndRoomRoofCharred.png",		1, 0, 0);
//	global.mskEndRoom							= sprite_add("../sprites/areas/deeplabs/mskEndRoom.png",						1, 99, 6);
//	global.mskEndRoomVertical					= sprite_add("../sprites/areas/deeplabs/mskEndRoomVertical.png",				1, 6, 99);
	global.sprDoubleTowerMain					= sprite_add("../sprites/areas/deeplabs/roomdecals/sprDoubleTowerMain.png",		1, 0, 0);
	global.sprDoubleTowerFront					= sprite_add("../sprites/areas/deeplabs/roomdecals/sprDoubleTowerFront.png",	1, 0, 0);
	global.sprDoubleTowerMainFront				= sprite_add("../sprites/areas/deeplabs/roomdecals/sprDoubleTowerMainFront.png",	1, 0, 0);
	global.sprEndRoomConnectorDownMain			= sprite_add("../sprites/areas/deeplabs/roomdecals/sprEndRoomConnectorDownMain.png",	1, 0, 0);
	global.sprEndRoomConnectorDownFront			= sprite_add("../sprites/areas/deeplabs/roomdecals/sprEndRoomConnectorDownFront.png",	1, 0, 0);
	global.sprEndRoomConnectorRightMain			= sprite_add("../sprites/areas/deeplabs/roomdecals/sprEndRoomConnectorRightMain.png",	1, 0, 0);
	global.sprEndRoomConnectorRightFront		= sprite_add("../sprites/areas/deeplabs/roomdecals/sprEndRoomConnectorRightFront.png",	1, 0, 0);
	
	global.sprCoreIdle							= sprite_add("../sprites/areas/deeplabs/roomdecals/sprCoreIdle.png",			35, 88, 103);
	global.sprCoreDanger						= sprite_add("../sprites/areas/deeplabs/roomdecals/sprCoreDanger.png",			8, 88, 103);
	global.sprCorePupil							= sprite_add("../sprites/areas/deeplabs/roomdecals/sprCorePupil.png",			3, 4, 4);	
	global.sprCoreEyeCover						= sprite_add("../sprites/areas/deeplabs/roomdecals/sprCoreEyeCover.png",		1, 0, 0);	
	global.sprCoreEyeCoverStrt					= sprite_add("../sprites/areas/deeplabs/roomdecals/sprCoreEyeCoverStrt.png",	10, 0, 0);	
	global.sprCoreEyeCoverEnd					= sprite_add("../sprites/areas/deeplabs/roomdecals/sprCoreEyeCoverEnd.png",		6, 0, 0);	

	global.mskCoreControls						= sprite_add("../sprites/areas/deeplabs/props/mskCoreControls.png",				1, 50, 0);		
	global.sprCoreControlsIdle					= sprite_add("../sprites/areas/deeplabs/props/sprCoreControlsIdle.png",			8, 168, 134);	
	global.sprCoreControlsSpill					= sprite_add("../sprites/areas/deeplabs/props/sprCoreControlsSpill.png",		12, 168, 134);	
	global.sprCoreControlsDanger				= sprite_add("../sprites/areas/deeplabs/props/sprCoreControlsDanger.png",		4, 168, 134);	
	
	global.sprDangerScreen						= sprite_add("../sprites/areas/deeplabs/roomdecals/sprDangerScreen.png",		2, 30, 22);
	global.sprDangerScreenOff					= sprite_add("../sprites/areas/deeplabs/roomdecals/sprDangerScreenOff.png",		1, 30, 22);
	global.bombText								= "";
	global.bombController						= noone;

	global.sprEndRoomElevatorIdle				= sprite_add("../sprites/areas/deeplabs/props/sprEndRoomElevatorIdle.png",			1, 32, 36);	 
	global.sprEndRoomElevatorArrive				= sprite_add("../sprites/areas/deeplabs/props/sprEndRoomElevatorArrive.png",		18, 32, 36);	 
	global.sprEndRoomElevatorOpen				= sprite_add("../sprites/areas/deeplabs/props/sprEndRoomElevatorOpen.png",			1, 32, 36);	 
	global.sprEndRoomElevatorCoverOpen			= sprite_add("../sprites/areas/deeplabs/props/sprEndRoomElevatorCoverOpen.png",		1, 32, 36);	 
	global.sprEndRoomElevatorLeave				= sprite_add("../sprites/areas/deeplabs/props/sprEndRoomElevatorLeave.png",			19, 32, 36);
	global.sprEndRoomElevatorCoverLeave			= sprite_add("../sprites/areas/deeplabs/props/sprEndRoomElevatorCoverLeave.png",	19, 32, 36);
	global.sprEndRoomElevatorCoverGone			= sprite_add("../sprites/areas/deeplabs/props/sprEndRoomElevatorCoverGone.png",		1, 32, 36);
	global.sprEndRoomPod						= sprite_add("../sprites/areas/deeplabs/props/sprEndRoomPod.png",					1, 32, 64)
	
	global.sprFallingDebris						= sprite_add("../sprites/areas/deeplabs/sprFallingDebris.png",					5, 8, 8);
	global.sprFallingDebrisBig					= sprite_add("../sprites/areas/deeplabs/sprFallingDebrisBig.png",				3, 16, 16);
	global.sprCharSmoke							= sprite_add("../sprites/areas/deeplabs/sprCharSmoke.png",						5, 12, 12);		
	global.sprSolidColorFog						= sprite_add("../sprites/particles/sprSolidColorFog.png",						1, 12, 12);
	
	 // erm.. 
	 // this prevents a crash when reloading. its just for me! 
	with(instances_matching(CustomEnemy, "name", "Spin Turret")){
		instance_destroy();
	}
	
	BigTubeObjects_init();

#define cleanup	
	if surface_exists(global.surfaceSpinTurret){
		surface_destroy(global.surfaceSpinTurret)
	} 
	
#define area_subarea        	return 1;
#define area_goal           	return 130;
#define area_next           	return (mod_exists("area", "scorpionboss")) ? ["palace", 1] : [7, 1];
#define area_background_color	return make_color_rgb(20, 22, 23);
#define area_shadow_color   	return c_black;
#define area_darkness       	return true;
#define area_fog				return global.sprFogDeeplabs;
#define area_secret         	return false;  
#define area_outside			return false;
    
#define area_name
	return (global.settingLabsRouteAltMode = true ? `@1(${real(global.sprAreaIcon)}:0)6-?` : `@1(${real(global.sprAreaIcon)}:0)3-`+string(GameCont.subarea));

#define area_text
	return choose(
		"A CITY OF PROGRESS",
		"DONT SLIP OVER THE RAILING", 
	//	"FREAK TO FREAK COMMUNICATION",
		"TOTALLY TUBULAR"
	);

#define area_mapdata(_lastX, _lastY, _lastArea, _lastSubarea, _subarea, _loops)
    return [
        108 + (9.5 * (_subarea - 1)), -9, (_subarea == 1)
    ]

#define area_areaicon
	return [
		global.sprAreaIcon,
		(global.settingLabsRouteAltMode = true ? "6-?" : "3-" + string(GameCont.subarea))
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

	sound_play_music(global.sndBlank);
    sound_play_ambient(global.ambDeeplabs);
    
	goal             = area_goal();
	background_color = area_background_color();
	BackCont.shadcol = area_shadow_color();
	TopCont.darkness = area_darkness();
	TopCont.fog		 = area_fog();
 //	safespawn		 = 1;
 //   if(global.deeplabsSpecial = true){ 
    	safespawn = 0; 
    	goal = 1; 
 //   }
   
     // Wall Breaking Sounds:
    sound_assign(sndWallBreakRock, sndWallBreakLabs);
    
	room_list	= [];
	roomX		= 10000;
	roomY		= 10000;
	
	script_bind_draw(deeplabsFog_draw, 30);
	
	global.bombText			= "";
	global.subjectNodeNum	= 0;

#define area_setup_floor
	material = 3;
    
#define area_start
/*
	// Generator:
	if(GameCont.subarea == 1){
		with(instances_matching(Floor, "fr_secrettime", true)){
			if place_meeting(x, y, prop){ 
				with(other){ 
					instance_destroy(); 
				} 
			}
			DeeplabsGenerator_create(x + 16, y + 16)
		}		
	}
	
	// Place Tubes:
	with(instances_matching(Floor, "fr_tubetime", true)){
		if(!place_meeting(x, y + 2, prop)) && (!place_meeting(x, y + 2, chestprop)) && (!place_meeting(x, y + 2, RadChest)){ 
			BigTube_create(x, y + 2);
		}
	}
	
	 // Proto Statue Tube:
	with(instances_matching(Floor, "fr_tubeMeStatue", true)){
		ProtoStatueTube_create(x, y);
	}
	
	 // Clear props near priority props.
	with(instances_matching(prop, "fr_allowDespawn", true)){
		var _nearestBigPile = call(scr.instance_nearest_array, x, y, instances_matching(Floor, "fr_tubeMeStatue", true));
		if(instance_exists(_nearestBigPile)){
			if(distance_to_object(_nearestBigPile) < 48){
				instance_delete(self);
			}
		}
	}
	
	// Secret:
	if (global.deeplabsSpecial = true && GameCont.subarea = 2){
		global.deeplabsSpecial = false;
		with(Wall){ 
			if(distance_to_object(Player) < 64){ 
				instance_delete(self); 
			} 
		}
    	with(RadChest){ 
    		instance_delete(self); 
    	} 
    	with(HealthChest){ 
    		instance_delete(self) 
    	}
    	with(Detail){ 
    		instance_delete(self); 
    	} 
    	sound_play_music(global.musDeeplabsC)
	}
	
*/	
	 // Deeplabs Finale:
//	if(global.deeplabsSpecial = true && GameCont.subarea = 3){
//		global.deeplabsSpecial = false;
		
		 // Remove Specific Objects:
    	with(RadChest){ 	instance_delete(self);	} 
    	with(HealthChest){	instance_delete(self)	}
    	with(Detail){ 		instance_delete(self);	} 		
    	with(EnemyHorror){ 	instance_delete(self);	} 		
    	with(RogueChest){ 	instance_delete(self);	} 
   
   
		 // Fix WeirdGuy:
		with(Wall){ 
			if(distance_to_object(Player) < 64){ 
				instance_delete(self); 
			} 
		}
    	instance_create(10000, 10000, Floor)
    	
		 // No Walls:
		with(instances_matching(Wall, "area", mod_current)){
			if("fr_deeplabsWall" not in self){
				instance_create(x, y, InvisiWall);
				instance_delete(self);
			}
		}
		with(TopSmall){
			instance_delete(self);
		}
		
		 // BG Color:
		background_color	= c_black;
		
		 // Projectile Handler:
		DeeplabsFinaleProjectileHandler_create(10016, 10016);
		
		 // BOMB TIMER!!!!!! LOOK OUT!!! HELP!!!!!! HELP!!!!!!
		global.bombController = DeeplabsFinaleController_create(10016, 10016);
		
		 // turn on the lights:
		TopCont.darkness = false;
		
		 // Kill THESE guys in particular:
		script_bind_draw(BarrierEnemyIcon_draw, -3);
		
		 // Chests Tehee:
		with(instances_matching(CustomObject, "name", "fr_deeplabsBecomeChest")){
			instance_create(x, y, myChest);
			instance_destroy();
		}
		
		 // less mysterychests...
		with(AmmoChestMystery){
			instance_create(x, y, AmmoChest);
			instance_delete(self);
		}
		
		 // STOP THAT PORTAL!!!!!!!
		instance_create(10016, 10016, becomenemy);
		
		 // Move Players and Crown Buddies:
		if(reposition = true){
			with(Player){
				x = 9666;
				y = 10132;
			}
			with(Crown){
				x = 9666;
				y = 10132;
			}
			wait(2){
				with(WepPickup){
					x = 9666;
					y = 10132;
				}
			}
		}
		
		 // put this down after player is moved
		with(instances_matching(CustomObject, "name", "fr_deeplabsRoomDecalCore")){
			CoreEyeCover_create(x - 79, y - 10, self);
		}
		
		if(deeplabsDebug = true){
			with(Floor){
				if(sprite_index	= global.sprFloor){
					sprite_index = mod_variable_get("area", "devzone", "sprFloor")
				}
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
				
		 // what are you even doing man
		EndRoomStupid_create();
		
		if(global.settingEnemyRandomizer = true){
			with(instances_matching(CustomObject, "name", "fr_DeeplabsEnemySpawnTube")){
				var _newSpawn	= call(scr.pool, global.enemyRandomizerSpawnpool);
				var _range		= _newSpawn[2];
				
				enemyMod		= _newSpawn[0];
				enemyScript		= _newSpawn[1];
				enemyCount		= irandom_range(_range[0], _range[1]);
			}
		}
		
		
		
		
		
		
		
		
//	}
	
#define area_make_floor
	var	_x = 10016 - 16,
		_y = 10016 - 16;
		
	
	if(deeplabsDebug = true){
		trace_color("|", c_yellow);
		trace_color("START GENERATION!", c_yellow);
		trace_color("|", c_yellow);
	}
	
     // Starting Room:
	scrFloorFill(_x, _y, 8, 9)
	scrFloorFill(_x, _y + 160, 6, 1)
	scrFloorFillSprite(_x + 224, _y - 96, 6, 1, global.sprFloorCatwalk)
	scrFloorFillConnector(_x + 352, _y - 96, "right", global.sprFloorCatwalk)
	
	 // elevator platform
	scrFloorFillSprite(_x - 224, _y + 96, 6, 1, global.sprFloorCatwalk)
	scrFloorFill(_x - 352, _y + 96, 3, 3)
	RoomDecalStructure_create(_x - 400, _y + 29, global.sprElevatorPlatformMain);
	
	 // Extra room up:
	scrFloorFill(_x - 256, _y - 64, 4, 3);
	RoomDecalStructure_create(_x - 300, _y - 103, global.sprStartTopRoomMain);
	RoomDecalStructureFront_create(_x - 345, _y - 103, global.sprStartTopRoomMainFront);
	
	BigTube_spawn(_x - 263, _y - 32, "Loot");
	BigTube_spawn(_x - 223, _y - 32, -1);
	BigTube_spawn(_x - 183, _y - 32, -1);
	
	instance_create(_x - 183, _y - 93, Terminal);
	instance_create(_x - 203, _y - 93, Server);
	instance_create(_x - 227, _y - 93, Server);
	
	
	 // Extra room down:
	scrFloorFill(_x - 256, _y + 256, 6, 4)
	RoomDecalStructure_create(_x - 377, _y + 219, global.sprStartBotRoomMain).depth -= 1;
	RoomDecalFront_create(_x - 329, _y + 347, global.sprStartBotRoomFront);
	
	var _serverX = 0;
	repeat(5){
		instance_create(_x - 308 + _serverX, _y + 230, Server){
			image_xscale	= 1;
		}
		_serverX += 24;
	}
	BigTube_spawn(_x - 156, _y + 256, "Loot");
	BigTube_spawn(_x - 156, _y + 312, "Loot");
	
	 // Decals:
	RoomDecalStructure_create(_x - 188, _y - 178, global.sprStartRoomMain);
	RoomDecalFront_create(_x - 393, _y - 68, global.sprStartRoomFront);
	RoomDecalCore_create(_x + 32, _y + 13);
	
	StartRoomHitbox_create(_x - 96, _y + 16);
	DeeplabsCorePanel_create(_x + 32, _y - 128);
	PanelSoundController_create(_x + 32, _y - 200);

	if(call(scr.save_get, "Frontier", "deeplabs_finales") = 0){
		var _barrierX = _x;		
		repeat(3){
			with(Barrier_create(_barrierX + 240, _y - 73, false, null)){
				fr_starterBarrier	= true;
				playSound			= false;
			}	
			_barrierX -= 16;
		}
	}
	
	// nodes:
	TestSubjectNode_create(_x + 32, _y - 80); // leave core room:
	
	 // dont do that weird thing:
	roomDir = "right";
	
	 // Remove Starter Floor:
	if(instance_is(id + 1, Floor)){
		instance_delete(id + 1);
	}
	
	 // how many rooms:
	var _roomGoal	= 12 + (GameCont.loops) + irandom(2),
		_roomCount	= 0;
	repeat(_roomGoal){
		
		 // Choose and Spawn Room:
		var _pool		= global.deeplabsRoomsR,
			_dirID		= 0,
			_traceCol	= c_green;
		switch(roomDir){
			case "right":
				_pool		= global.deeplabsRoomsR
				_dirID		= 0;
				_traceCol	= c_green;
			break;
			case "up":
				_pool		= global.deeplabsRoomsU
				_dirID		= 1;
				_traceCol	= c_aqua;
			break;
			case "down":
				_pool		= global.deeplabsRoomsD
				_dirID		= 2;
				_traceCol	= c_orange;
			break;
		}
		var _roomType = call(scr.pool, _pool);
		global.roomLast[_dirID] = _roomType;
		if(_roomCount = _roomGoal - 1){
			_roomType = "EndRoom";
		}
		deeplabsRoom_create(roomX, roomY, _roomType);
		if(deeplabsDebug = true){
			trace_color(_roomType, _traceCol)
			DeeplabsRoomNametag_create(roomX, roomY, _roomType)
		}
		_roomCount += 1;
		
		// remake pool for repeat prevention
		deeplabsRoomPools_construct();
		
		 // End Level Gen:
		with(FloorMaker) instance_destroy();
	}
	
	

		
/*
	old gen from when it was a more normal level
	was never really finished. might as well keep it around

	var _x = x,
		_y = y,
		_outOfSpawn = (point_distance(_x, _y, 10000, 10000) > 48);
		
		
	// Default Generation:
	if (global.deeplabsSpecial = false){
			
		 // Place Floor:
	   with instance_create(_x, _y, Floor){ 
	   	
	   		 // 3x3 Tube Rooms
	   		if(random(7) < 1) {
	   			fr_tubetime = true 
				scrFloorFill(_x, _y, 3, 3);
	   		}
	   }
	   
		 // 3x3 Normal Rooms:
		if(random(20) < 1) {
			scrFloorFill(_x, _y, 3, 3);
		}
		
	     // Change Direction:
	    var _turn = 0;
	    if(random(3) < 1){
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
*/	    
	     // Mark Deeplabs Generator:
	    /*
		with(GenCont) if(instance_number(Floor) > goal) && (GameCont.subarea == 1){
			with(instance_furthest(10000, 10000, Floor)){
				with(instance_nearest(
					(((x * 2) + 10000) / 3) + random_range(-64, 64),
					(((y * 2) + 10000) / 3) + random_range(-64, 64),
					Floor
				)){
					scrFloorFill(x, y, 3, 3)
					fr_secrettime = true;
					if place_meeting(x, y, prop){ 
						with(other){ instance_destroy(); }
					}
				}
			}
		}
		*/
/*		
	     // Deeplabs Proto Statue:
		with(GenCont) if(instance_number(Floor) > goal) && (GameCont.subarea == 2) && (GameCont.loops > 0){
			with(instance_furthest(10000, 10000, Floor)){
				with(instance_nearest(
					(((x * 2) + 10000) / 3) + random_range(-64, 64),
					(((y * 2) + 10000) / 3) + random_range(-64, 64),
					Floor
				)){
					scrFloorFill(x, y, 3, 3);
					fr_tubeMeStatue = true;
				}
			}
		}
		
		
	}
	
		// Secret Generation:
	if (global.deeplabsSpecial = true && GameCont.subarea = 2){
		var	_xS = 10016 - 16,
			_yS = 10016 - 16;
	    
	    // Starting Area:
		scrFloorFill(_xS, _yS, 5, 5);
		
	    // Big Area 1:
		scrFloorFill(_xS, _yS - 256, 7, 18);	
	}
	
*/

		
#define deeplabsRoom_init
	global.room_count	= 0;
	global.roomStartX	= 10000;
	global.roomStartY	= 10000;
	global.roomDirect	= "right";
	global.roomDirectEnd= "right";
	global.roomLast		= [null, null, null];
	#macro roomX		global.roomStartX;
	#macro roomY		global.roomStartY;
	#macro roomDir		global.roomDirect;
	#macro roomDirEnd	global.roomDirectEnd;
	
	deeplabsRoomPools_construct();

#define deeplabsRoomPools_construct
	global.deeplabsRoomsR	= [
	//	["ColorPuzzle", 			1 - ((global.roomLast[0] = "ColorPuzzle") * 0.7)],
	//	["Doomspire",				0.5 * (global.roomLast[0] != "Doomspire")],
		["6x6RR",					1 - ((global.roomLast[0] = "6x6RR") * 0.5)],
		["6x6RD",					1 - ((global.roomLast[0] = "6x6RD") * 0.5)],
		["LUpRoom",					1 - ((global.roomLast[0] = "LUpRoom") * 0.5)],
		["LDownRoom",				1 - ((global.roomLast[0] = "LDownRoom") * 0.5)],
		["DoubleTower",				1 - ((global.roomLast[0] = "DoubleTower") * 0.8)],
	]
	
	global.deeplabsRoomsU	= [
		["5x8UR",					1 - ((global.roomLast[1] = "5x8UR") * 0.5)],
		["6x10UU",					1 - ((global.roomLast[1] = "6x10UU") * 0.5)],
		["FreakPark",				1 - ((global.roomLast[1] = "FreakPark") * 0.5)],
	]
	
	global.deeplabsRoomsD	= [
		["FiringSquad",				0.7 - ((global.roomLast[2] = "FiringSquad") * 0.5)],
		["Chokepoint",				1 - ((global.roomLast[2] = "Chokepoint") * 0.5)],
		["9x5DR",					1 - ((global.roomLast[2] = "9x5DR") * 0.5)],
		["9x9DR",					1 - ((global.roomLast[2] = "9x9DR") * 0.5)],
	]
	
#define deeplabsRoom_create(_x, _y, _type)

	var _dir		= "right",
		_layout 	= "";
	switch(_type){
		case "EndRoom":
		
		global.bombTimer = 120; // i coded roof fade weird whatever
		
		if(deeplabsDebug){
			trace("END ROOM DIR: " + roomDir)
		}
			switch(roomDir){
				case "right":
					scrFloorFillSprite(roomX + 64, roomY, 5, 1, global.sprFloorCatwalk); // right catwalk
					scrFloorFill(roomX + 192, roomY, 3, 3); // 3x3
					scrFloorFillSprite(roomX + 192, roomY - 128, 1, 4, global.sprFloorCatwalkVertical); // catwalk up
					scrFloorFillEndRoom(roomX + 192, roomY - 224, 1, 2, global.sprFloorCatwalkVertical); // safecatwalk
					scrFloorFillEndRoom(roomX + 192, roomY - 320, 5, 5, global.sprFloor);	 // safe room
					
					RoomDecalStructure_create(roomX + 128, roomY - 48, global.sprEndRoomConnectorRightMain);
					RoomDecalFront_create(roomX, roomY + 28, global.sprEndRoomConnectorRightFront);
					
					SafeRoom_populate(208, -304)

					TestSubjectNode_create(roomX + 208, roomY + 16); // platform:
					TestSubjectNode_create(roomX + 208, roomY - 304); // end room:
					
				break;
				
				case "up":
					scrFloorFillSprite(roomX, roomY - 64, 1, 4, global.sprFloorCatwalkVertical); // catwalk up
					scrFloorFillEndRoom(roomX, roomY - 160, 1, 2, global.sprFloorCatwalkVertical); // safecatwalk
					scrFloorFillEndRoom(roomX, roomY - 256, 5, 5, global.sprFloor);	// safe room
					
					SafeRoom_populate(16, -240)

					TestSubjectNode_create(roomX + 16, roomY - 240); // end room:
				break;
				
				case "down":
					scrFloorFillSprite(roomX, roomY + 32, 1, 3, global.sprFloorCatwalkVertical); // down catwalk
					scrFloorFill(roomX, roomY + 128, 3, 3); // first 3x3
					scrFloorFillSprite(roomX + 160, roomY + 128, 7, 1, global.sprFloorCatwalk); // right catwalk
					scrFloorFill(roomX + 320, roomY + 128, 3, 3); // second 3x3
					scrFloorFillSprite(roomX + 320, roomY, 1, 4, global.sprFloorCatwalkVertical); // up catwalk
					scrFloorFillEndRoom(roomX + 320, roomY - 96, 1, 2, global.sprFloorCatwalkVertical); // safecalkwalk
					scrFloorFillEndRoom(roomX + 320, roomY - 192, 5, 5, global.sprFloor) // safe room
					
					RoomDecalStructure_create(roomX - 64, roomY + 80, global.sprEndRoomConnectorDownMain);
					RoomDecalFront_create(roomX - 41, roomY + 156, global.sprEndRoomConnectorDownFront);
					
					SafeRoom_populate(336, -176)
					
					TestSubjectNode_create(roomX + 16, roomY + 144); // platform 1:
					TestSubjectNode_create(roomX + 336, roomY + 144); // platform 2:
					TestSubjectNode_create(roomX + 336, roomY - 176); // end room:
					
				break;
			}
			
			roomDirEnd = roomDir;
			
		break;
		/*
		case "ColorPuzzle":
			 // Main:
			scrFloorFillSprite(roomX + 32, roomY, 3, 1, global.sprFloorCatwalk);
			scrFloorFill(roomX + 160, roomY, 5, 3);
			scrFloorFillConnector(roomX + 256, roomY, "right", global.sprFloorCatwalk);
			
			 // Decals:
			RoomDecalBack_create(roomX - 288, roomY - 40, global.sprColorPuzzleBack);
			RoomDecalFront_create(roomX - 288, roomY + 28, global.sprColorPuzzleFront);
			RoomDecalStructure_create(roomX - 203, roomY - 49, global.sprBotLayer3x5);

			 // Mechanics:
			with(ColorPuzzleController_create(roomX, roomY, 4)){
				myBarrier = Barrier_create(roomX - 28, roomY + 20, false, null);
				
				
				 // Answer Bulbs:
				ColorBulb_create(roomX - 184,	roomY - 32, myPattern[0]);
				ColorBulb_create(roomX - 168,	roomY - 32, myPattern[1]);
				ColorBulb_create(roomX - 152,	roomY - 32, myPattern[2]);
				ColorBulb_create(roomX - 136,	roomY - 32, myPattern[3]);
				
				 // Submission Bulbs:
				myBulb[0]	= ColorBulb_create(roomX - 88,	roomY - 32, c_white);
				myBulb[1]	= ColorBulb_create(roomX - 72,	roomY - 32, c_white);
				myBulb[2]	= ColorBulb_create(roomX - 56,	roomY - 32, c_white);
				myBulb[3]	= ColorBulb_create(roomX - 40,	roomY - 32, c_white);
				
				 // Pressure Plates:
				var _buttonPattern	= [],
					_colorPattern	= myPattern,
					_colIndex		= 0;
			
				repeat(4){
					_colIndex	= irandom(array_length(_colorPattern) - 1);
					array_push(_buttonPattern, _colorPattern[_colIndex]);
					_colorPattern = array_delete(_colorPattern, _colIndex);
				}
				
				myButton[0]	= ColorButton_create(roomX - 160, roomY - 10,	_buttonPattern[0], self);
				myButton[1]	= ColorButton_create(roomX - 64, roomY - 10,	_buttonPattern[1], self);
				myButton[2]	= ColorButton_create(roomX - 160, roomY + 48,	_buttonPattern[2], self);
				myButton[3]	= ColorButton_create(roomX - 64, roomY + 48,	_buttonPattern[3], self);
				
				 // Hazard:
				var _hazard = choose("none", "ballTrap", "spinTurret");
				switch(_hazard){
					case "ballTrap":
						mod_script_call("mod", "Frontier_Labs", "BallTrap_create", roomX - 112, roomY + 16);
					break;
					case "spinTurret":
						SpinTurret_create(roomX - 112, roomY + 16);
					break;
				}
			}

			_dir = "right";
		break;
		*/
		/*
		case "Doomspire":
				
			 // Connecting Catwalk:
			scrFloorFillSprite(roomX, roomY, 2, 1, global.sprFloorCatwalk);
			
			 // Left (entry) Room:
			scrFloorFill(roomX + 96, roomY, 4, 4);
			
			 // Catwalk:
			scrFloorFillSprite(roomX + 288, roomY, 7, 4, sprFloor6B);		// horizontal
			scrFloorFillSprite(roomX + 272, roomY, 4, 6, sprFloor6B);		// vertical	
			
			 // Right Room:
			scrFloorFill(roomX + 448, roomY, 4, 4);
			
			 // Up Room:
			scrFloorFill(roomX + 272, roomY - 160, 4, 4);			
			
			 // Down Room:
			scrFloorFill(roomX + 272, roomY + 160, 4, 4);	
			
			 // Connector:
			scrFloorFillSprite(roomX + 544, roomY, 2, 1, global.sprFloorCatwalk);
			scrFloorFillConnector(roomX + 608, roomY, "right", global.sprFloorCatwalk);
			_dir = "right";
			
			 // Barrier:
			var _roomHitbox = EnemyRoomHitbox_create(roomX - 336, roomY + 32, 18, 15),
				_barrier	= Barrier_create(roomX - 96, roomY + 20, false, _roomHitbox);
				
				// Elevators:
			
			 // Left Room:
			BecomeChest_create(roomX - 464, roomY - 16, AmmoChest);
			BecomeChest_create(roomX - 464, roomY + 80, AmmoChest);
			
			 // Upper Room:
			EnemySpawnTube_create(roomX - 304, roomY - 192, _barrier, false, _roomHitbox, 0,
			choose(["Frontier_Labs", "MissileDrone_create", 1 + irandom(1)], ["Frontier_Labs", "Swarmbot_create", 5], ["Frontier_Deeplabs", "RavenAmalgam_create", 1 + irandom(1)]));
			
			EnemySpawnTube_create(roomX - 368, roomY - 192, _barrier, false, _roomHitbox, 0,
			choose(["Basegame", Freak, 7 + irandom(3)], ["Basegame", RhinoFreak, 1 + irandom(1)], ["Frontier_Labs", "Swarmbot_create", 5], ["Frontier_Deeplabs", "GatorAmalgam_create", 1 + irandom(1)]));
			
			EnemySpawnTube_create(roomX - 336, roomY - 96, _barrier, false, _roomHitbox, 0,
			choose(["Basegame", Freak, 7 + irandom(3)], ["Frontier_Labs", "Swarmbot_create", 5]));	
			
			 // Lower Room:
			EnemySpawnTube_create(roomX - 304, roomY + 224, _barrier, false, _roomHitbox, 0,
			choose(["Frontier_Labs", "MissileDrone_create", 1 + irandom(1)], ["Frontier_Labs", "Swarmbot_create", 5], ["Frontier_Deeplabs", "RavenAmalgam_create", 1 + irandom(1)]));
			
			EnemySpawnTube_create(roomX - 368, roomY + 224, _barrier, false, _roomHitbox, 0,
			choose(["Basegame", Freak, 7 + irandom(3)], ["Basegame", RhinoFreak, 1 + irandom(1)], ["Frontier_Labs", "Swarmbot_create", 5], ["Frontier_Deeplabs", "GatorAmalgam_create", 1 + irandom(1)]));
			
			EnemySpawnTube_create(roomX - 336, roomY + 128, _barrier, false, _roomHitbox, 0,
			choose(["Basegame", Freak, 7 + irandom(3)], ["Frontier_Labs", "Swarmbot_create", 5]));	
			
			 // Right Room:
			EnemySpawnTube_create(roomX - 160, roomY - 32, _barrier, true, _roomHitbox, 0,
			choose(["Frontier_Deeplabs", "GatorAmalgam_create", 1], ["Frontier_Deeplabs", "RavenAmalgam_create", 1 + irandom(1)]));	

			EnemySpawnTube_create(roomX - 160, roomY + 64, _barrier, true, _roomHitbox, 0,
			choose(["Frontier_Deeplabs", "GatorAmalgam_create", 1], ["Frontier_Deeplabs", "RavenAmalgam_create", 1 + irandom(1)]));
			
		break;
		*/
		
		case "6x6RR":
			scrFloorFillSprite(roomX, roomY, 2, 1, global.sprFloorCatwalk);
			scrFloorFill(roomX + 128, roomY + 64, 6, 6)
			scrFloorFillSprite(roomX + 256, roomY + 128, 2, 1, global.sprFloorCatwalk);
			scrFloorFillConnector(roomX + 320, roomY + 128, "right", global.sprFloorCatwalk);
			_dir = "right";
			
			 // Decals:
			RoomDecalStructure_create(roomX - 336, roomY - 144, global.spr6x6RRMain);
			RoomDecalFront_create(roomX - 352, roomY - 100, global.spr6x6RRFront);
			RoomDecalStructureExtraBomb_create(roomX - 260, roomY + 132, global.sprDangerScreen, global.sprDangerScreenOff, 0.6);
			
			_layout = choose("BallDodge", "BallFight");
			switch(_layout){
				case "BallDodge":
					mod_script_call("mod", "Frontier_Labs", "BallTrap_create", roomX - 240, roomY - 80);
					mod_script_call("mod", "Frontier_Labs", "BallTrap_create", roomX - 144, roomY - 80);		
					mod_script_call("mod", "Frontier_Labs", "BallTrap_create", roomX - 192, roomY - 32);
					mod_script_call("mod", "Frontier_Labs", "BallTrap_create", roomX - 240, roomY + 16);
					mod_script_call("mod", "Frontier_Labs", "BallTrap_create", roomX - 144, roomY + 16);			

					TestSubjectNode_create(roomX - 256, roomY - 112); // left entrance
					TestSubjectNode_create(roomX - 128, roomY + 16); // right exit
				break;
				
				case "BallFight":
				
					var _roomHitbox = EnemyRoomHitbox_create(roomX - 208, roomY - 32, 9, 6),
						_barrier	= Barrier_create(roomX - 88, roomY + 23, false, _roomHitbox);	
					
					mod_script_call("mod", "Frontier_Labs", "BallTrap_create", roomX - 192, roomY - 32);
					
					 // bot right
					EnemySpawnTube_create(roomX - 128, roomY + 32, _barrier, true, _roomHitbox, 0,
					choose(["Frontier_Deeplabs", "GatorAmalgam_create", 1], ["Frontier_Deeplabs", "RavenAmalgam_create", 2]));
					
					 // bot left
					EnemySpawnTube_create(roomX - 256, roomY + 32, _barrier, true, _roomHitbox, 0,
					choose(["Frontier_Deeplabs", "GatorAmalgam_create", 1], ["Frontier_Deeplabs", "RavenAmalgam_create", 2]));

					TestSubjectNode_create(roomX - 256, roomY - 112); // left entrance
					TestSubjectNode_create(roomX - 128, roomY + 16); // right exit
				break;
			}
			
		break;
		
		case "6x6RD":
			scrFloorFillSprite(roomX, roomY, 2, 1, global.sprFloorCatwalk);
			scrFloorFill(roomX + 128, roomY + 64, 6, 6);
			scrFloorFillSprite(roomX + 192, roomY + 192, 1, 1, global.sprFloorCatwalkVertical);
			scrFloorFillConnector(roomX + 192, roomY + 224, "down", global.sprFloorCatwalkVertical);
			_dir = "down";
			
			 // Decals:
			RoomDecalStructure_create(roomX - 196, roomY - 273, global.spr6x6RDMain);
			RoomDecalStructureFront_create(roomX - 196, roomY - 64, global.spr6x6RDMainFront);
			RoomDecalFront_create(roomX - 192, roomY - 228, global.spr6x6RDFront);
			
			 // Barrier:
			var _roomHitbox = EnemyRoomHitbox_create(roomX - 32, roomY - 160, 10, 8),
				_barrier	= Barrier_create(roomX + 16, roomY - 48, true, _roomHitbox);
				

			_layout = choose("LaserWhack", "Spin2Lose");
			switch(_layout){
				case "LaserWhack":
					LaserTurret_create(roomX - 32, roomY - 160, 1, 96, 2, 640)
		
					EnemySpawnTube_create(roomX + 32, roomY - 120, _barrier, true, _roomHitbox, 15,
					choose(["Frontier_Deeplabs", "GatorAmalgam_create", 1], ["Frontier_Deeplabs", "RavenAmalgam_create", 1 + irandom(1)]));
					
					EnemySpawnTube_create(roomX + 32, roomY - 208, _barrier, false, _roomHitbox, 0,
					choose(["Frontier_Deeplabs", "GatorAmalgam_create", 1], ["Frontier_Deeplabs", "RavenAmalgam_create", 1 + irandom(1)]));	
					
					TestSubjectNode_create(roomX - 96, roomY - 240); // left entrance
					TestSubjectNode_create(roomX + 16, roomY - 96); // bot exit
				break;
				
				case "Spin2Lose":
					SpinTurret_create(roomX - 96, roomY - 96, 1);
					SpinTurret_create(roomX + 32, roomY - 224, 1);
					
					BecomeChest_create(roomX + 32, roomY - 192, AmmoChest);
		
					 // middle
					EnemySpawnTube_create(roomX - 32, roomY - 224, _barrier, false, _roomHitbox, 0, choose(
						["Frontier_Labs",		"Swarmbot_create",		4 + irandom(2)], 
						["Frontier_Deeplabs",	"GatorAmalgam_create",	1 + irandom(1)], 
						["Basegame",		Freak,					8 + irandom(4)], 
					));

					EnemySpawnTube_create(roomX - 32, roomY - 128, _barrier, true, _roomHitbox, 10, choose(
						["Frontier_Labs",		"MissileDrone_create",	1 + irandom(2)], 
						["Frontier_Deeplabs",	"RavenAmalgam_create",	2 + irandom(1)], 
						["Basegame",		FireBaller,				2 + irandom(1)], 
						["Basegame",		RhinoFreak,				1 + irandom(1)], 
					));
					
					TestSubjectNode_create(roomX - 96, roomY - 240); // left entrance
					TestSubjectNode_create(roomX + 16, roomY - 96); // bot exit
				break;
			}
			

			
		break;

		case "FiringSquad":
			scrFloorFillSprite(roomX, roomY, 1, 3, global.sprFloorCatwalkVertical);
			scrFloorFill(roomX, roomY + 160, 3, 7);
			scrFloorFill(roomX - 96, roomY + 160, 1, 5);
			scrFloorFillSprite(roomX + 64, roomY + 224, 2, 1, global.sprFloorCatwalk);
			scrFloorFillConnector(roomX + 128, roomY + 224, "right", global.sprFloorCatwalk);
			_dir = "right";	
			
			 // Decals:
			RoomDecalStructure_create(roomX - 272, roomY - 176, global.sprFiringSquadMain);
			RoomDecalFront_create(roomX - 201, roomY + 28, global.sprFiringSquadFront);
			
			 // Barrier:
			var _roomHitbox = EnemyRoomHitbox_create(roomX - 176, roomY - 48, 5, 8),
				_barrier	= Barrier_create(roomX - 64, roomY + 23, false, _roomHitbox);

			BecomeTurret_create(roomX - 240, roomY - 112, _roomHitbox, 0, null);
			BecomeTurret_create(roomX - 240, roomY - 80, _roomHitbox, 5, null);
			BecomeTurret_create(roomX - 240, roomY - 48, _roomHitbox, 10, null);
			BecomeTurret_create(roomX - 240, roomY - 16, _roomHitbox, 15, null);
			BecomeTurret_create(roomX - 240, roomY + 16, _roomHitbox, 20, null);
			EnemySpawnTube_create(roomX - 144, roomY - 32, _barrier, true, _roomHitbox, 0, 
			choose(["Basegame", Freak, 7 + irandom(3)], ["Basegame", RhinoFreak, 1 + irandom(1)], ["Frontier_Labs", "Swarmbot_create", 5], ["Basegame", Spider, 2 + irandom(1)]));
			
			TestSubjectNode_create(_x + 16, _y + 96); // top entrance:
			TestSubjectNode_create(_x + 16, _y + 240); // exit right:
				
		break; 
		
		case "Chokepoint":
			scrFloorFillSprite(roomX, roomY, 1, 3, global.sprFloorCatwalkVertical);
			scrFloorFill(roomX, roomY + 96, 3, 3);
			scrFloorFill(roomX, roomY + 224, 11, 5);
			scrFloorFillSprite(roomX + 192, roomY + 256, 2, 1, global.sprFloorCatwalk);
			scrFloorFillConnector(roomX + 256, roomY + 256, "right", global.sprFloorCatwalk);
			_dir = "right";	
			
			var _wallX = 240;
			repeat(7){
				 // right wall
				DeeplabsWall_create(roomX - _wallX, roomY - 64)
				DeeplabsWall_create(roomX - _wallX, roomY - 48)
				 // left wall
				DeeplabsWall_create(roomX - _wallX - 176, roomY - 64)
				DeeplabsWall_create(roomX - _wallX - 176, roomY - 48)
				_wallX -= 16;
			}
			
			 // Decals:
			RoomDecalStructure_create(roomX - 506, roomY - 196, global.sprChokepointMain);
			RoomDecalFront_create(roomX - 457, roomY + 28, global.sprChokepointFront);
			
			
			 // Barrier:
			var _roomHitbox = EnemyRoomHitbox_create(roomX - 272, roomY - 64, 11, 11),
				_barrier	= Barrier_create(roomX - 88, roomY + 23, false, _roomHitbox);
				
			_layout = choose("Basic");
			switch(_layout){
				case "Basic":
					BecomeTurret_create(roomX - 432, roomY - 60, _roomHitbox, 20, null);
					BecomeTurret_create(roomX - 112, roomY - 60, _roomHitbox, 20, null);
					
					BecomeChest_create(roomX - 400, roomY - 16, AmmoChest);
					
					 // left:
					EnemySpawnTube_create(roomX - 416, roomY + 16, _barrier, true, _roomHitbox, 12, 
					choose(["Basegame", Freak, 7 + irandom(3)], ["Basegame", ExploFreak, 1 + irandom(1)], ["Frontier_Deeplabs", "RavenAmalgam_create", 2]));
					
					 // midleft
					EnemySpawnTube_create(roomX - 352, roomY + 16, _barrier, false, _roomHitbox, 0, 
					choose(["Basegame", Freak, 7 + irandom(3)], ["Basegame", RhinoFreak, 1], ["Frontier_Labs", "Swarmbot_create", 5], ["Basegame", Spider, 2 + irandom(1)]));
					
					 // midright
					EnemySpawnTube_create(roomX - 192, roomY + 16, _barrier, false, _roomHitbox, 0, 
					choose(["Basegame", Freak, 7 + irandom(3)], ["Basegame", RhinoFreak, 1], ["Frontier_Labs", "Swarmbot_create", 5], ["Basegame", Spider, 2 + irandom(1)]));
					
					 // right
					EnemySpawnTube_create(roomX - 128, roomY + 16, _barrier, false, _roomHitbox, 15, 
					choose(["Basegame", Freak, 7 + irandom(3)], ["Basegame", ExploFreak, 1 + irandom(1)], ["Frontier_Deeplabs", "RavenAmalgam_create", 2]));
				break;
			}
			
			TestSubjectNode_create(roomX - 272, roomY - 160); // entrance top
			TestSubjectNode_create(roomX - 272, roomY + 16); // center
			TestSubjectNode_create(roomX - 128, roomY + 16); // exit right

				
		break; 
	
		case "5x8UR":
			scrFloorFillSprite(roomX, roomY - 32, 1, 2, global.sprFloorCatwalkVertical);
			scrFloorFill(roomX, roomY - 192, 5, 8);
			scrFloorFillConnector(roomX + 96, roomY - 256, "right", global.sprFloorCatwalk)
			_dir = "right";
			
			 // Decals:
			RoomDecalStructure_create(roomX - 251, roomY - 48, global.spr5x8URMain);
			RoomDecalStructureFront_create(roomX - 251, roomY + 232, global.spr5x8URMainFront);
			RoomDecalFront_create(roomX - 201, roomY + 28, global.spr5x8URFront);

			var _roomHitbox = EnemyRoomHitbox_create(roomX - 112, roomY + 96, 5, 12),
				_barrier	= Barrier_create(roomX, roomY + 23, false, _roomHitbox);
				
			_layout = choose("Basic", "Split");
			switch(_layout){
				case "Basic":
					EnemySpawnTube_create(roomX - 136, roomY + 16, _barrier, true, _roomHitbox, 20, 
					choose(["Basegame", Freak, 7 + irandom(3)], ["Basegame", ExploFreak, 1 + irandom(1)], ["Frontier_Deeplabs", "RavenAmalgam_create", 2]));			
					
					EnemySpawnTube_create(roomX - 136, roomY + 80, _barrier, false, _roomHitbox, 15, 
					choose(["Basegame", Freak, 7 + irandom(3)], ["Basegame", ExploFreak, 1 + irandom(1)], ["Frontier_Deeplabs", "RavenAmalgam_create", 2]));	
					
					TestSubjectNode_create(roomX - 112, roomY + 192); // entrance bot:
					TestSubjectNode_create(roomX - 64, roomY + 16); // exit right:
					
				break;
				
				case "Split": 
				
					if(random(2) < 1){
						var _wallY = 0;
						repeat(3){
							DeeplabsWall_create(roomX - 128, (roomY + 32) + _wallY);
							DeeplabsWall_create(roomX - 112, (roomY + 32) + _wallY);
							
							DeeplabsWall_create(roomX - 128, (roomY + 112) + _wallY);
							DeeplabsWall_create(roomX - 112, (roomY + 112) + _wallY);
							_wallY += 16;
						}
						
						var _trap = choose("BallTrap", "SpinTurret", "LaserTrap", "Turret");
						switch(_trap){
							case "BallTrap":
								mod_script_call("mod", "Frontier_Labs", "BallTrap_create", roomX - 112, roomY + 96);
							break;
							case "SpinTurret":
								SpinTurret_create(roomX - 112, roomY + 96, 2);
							break;
							case "LaserTrap":
								LaserTurret_create(roomX - 112, roomY + 96, 2, 80, 3, 320);
							break;
							case "Turret":
								BecomeTurret_create(roomX - 112, roomY + 96, _roomHitbox, 4, null);
							break;
						}
					} else {
						var _wallY = 0;
						repeat(8){
							DeeplabsWall_create(roomX - 128, (roomY + 32) + _wallY);
							DeeplabsWall_create(roomX - 112, (roomY + 32) + _wallY);
							_wallY += 16;
						}
					}
					
					BigTube_spawn(roomX - 168, roomY + 192, -1);
					instance_create(roomX - 144, roomY + 144, Server);
					instance_create(roomX - 80, roomY + 144, Server)
					
					 // top left
					EnemySpawnTube_create(roomX - 152, roomY - 16, _barrier, true, _roomHitbox, 15, choose(
						["Frontier_Deeplabs",	"RavenAmalgam_create",	2 + irandom(1)], 
						["Frontier_Labs",		"MissileDrone_create",	1 + irandom(1)], 
						["Basegame",			Freak,					8 + irandom(4)], 
					));
					
					 // top right
					EnemySpawnTube_create(roomX - 72, roomY - 16, _barrier, true, _roomHitbox, 15, choose(
						["Frontier_Deeplabs",	"RavenAmalgam_create",	2 + irandom(1)], 
						["Frontier_Labs",		"MissileDrone_create",	1 + irandom(1)], 
						["Basegame",			Freak,					8 + irandom(4)], 
					));
					
					TestSubjectNode_create(roomX - 112, roomY + 192); // entrance bot:
					TestSubjectNode_create(roomX - 64, roomY + 192); 
					TestSubjectNode_create(roomX - 64, roomY + 16); // exit right:				
				break;
			
			}
			

			
		break;
		
		case "LUpRoom":
			 // Main:
			scrFloorFillSprite(roomX, roomY, 2, 1, global.sprFloorCatwalk);
			scrFloorFill(roomX + 160, roomY, 8, 4);
			scrFloorFill(roomX + 224, roomY - 128, 4, 4);
			scrFloorFillSprite(roomX + 256, roomY - 224, 1, 3, global.sprFloorCatwalkVertical);
			scrFloorFillConnector(roomX + 256, roomY - 288, "up", global.sprFloorCatwalkVertical);
			_dir = "up";
			
			 // Decals:
			RoomDecalStructure_create(roomX - 256, roomY + 32, global.sprLUpRoomMain);
			RoomDecalFront_create(roomX - 256, roomY + 348, global.sprLUpRoomFront);
			
			var _roomHitbox = EnemyRoomHitbox_create(roomX - 64, roomY + 288, 12, 8),
				_barrier	= Barrier_create(roomX + 16, roomY + 144, true, _roomHitbox)
				
			_layout = choose("Basic");
			switch(_layout){
				case "Basic":
					EnemySpawnTube_create(roomX + 16, roomY + 176, _barrier, true, _roomHitbox, 30, 
					choose(["Frontier_Labs", "MissileDrone_create", 1 + irandom(1)], ["Frontier_Deeplabs", "RavenAmalgam_create", 2], ["Frontier_Deeplabs", "GatorAmalgam_create", 1 + irandom(1)]));
					
					EnemySpawnTube_create(roomX + 16, roomY + 256, _barrier, false, _roomHitbox, 20, 
					choose(["Basegame", Freak, 7 + irandom(3)], ["Basegame", RhinoFreak, 1], ["Frontier_Labs", "Swarmbot_create", 5], ["Basegame", ExploFreak, 1 + irandom(1)]));
					
					EnemySpawnTube_create(roomX + 16, roomY + 336, _barrier, false, _roomHitbox, 10, 
					choose(["Basegame", Freak, 7 + irandom(3)], ["Basegame", RhinoFreak, 1], ["Frontier_Labs", "Swarmbot_create", 5], ["Basegame", ExploFreak, 1 + irandom(1)]));
					
					BigTube_spawn(roomX - 64, roomY + 384, -1);
					BigTube_spawn(roomX - 112, roomY + 384, -1);
					BigTube_spawn(roomX - 160, roomY + 384, -1);	
					
					TestSubjectNode_create(roomX - 160, roomY + 336); // left entry
					TestSubjectNode_create(roomX + 16, roomY + 336); // right corner
					TestSubjectNode_create(roomX + 16, roomY + 192); // top exit
				break;
			}
				

			
		break;
		
		case "LDownRoom":
			 // Main:
			scrFloorFillSprite(roomX, roomY, 2, 1, global.sprFloorCatwalk);
			scrFloorFill(roomX + 160, roomY, 8, 4);
			scrFloorFill(roomX + 224, roomY + 128, 4, 4);
			scrFloorFillSprite(roomX + 256, roomY + 224, 1, 3, global.sprFloorCatwalkVertical);
			scrFloorFillConnector(roomX + 256, roomY + 288, "down", global.sprFloorCatwalkVertical);
			_dir = "down";
			
			 // Decals:
			RoomDecalStructure_create(roomX - 248, roomY - 368, global.sprLDownRoomMain);
			RoomDecalStructureFront_create(roomX - 248, roomY - 88, global.sprLDownRoomMainFront);
			RoomDecalFront_create(roomX - 256, roomY - 299, global.sprLDownRoomFront);
			
			 // Barrier:
			var _roomHitbox = EnemyRoomHitbox_create(roomX - 64, roomY - 224, 11, 8),
				_barrier	= Barrier_create(roomX + 16, roomY - 80, true, _roomHitbox)
				
			_layout = choose("Basic");
			switch(_layout){
				case "Basic":
					EnemySpawnTube_create(roomX, roomY - 160, _barrier, false, _roomHitbox, 0, 
					choose(["Basegame", Freak, 7 + irandom(3)], ["Basegame", ExploFreak, 1 + irandom(1)], ["Frontier_Deeplabs", "RavenAmalgam_create", 2]));
					
					EnemySpawnTube_create(roomX, roomY - 272, _barrier, true, _roomHitbox, 10, 
					choose(["Basegame", Freak, 7 + irandom(3)], ["Basegame", RhinoFreak, 1], ["Frontier_Labs", "Swarmbot_create", 5], ["Basegame", Spider, 2 + irandom(1)]));
		
					EnemySpawnTube_create(roomX - 96, roomY - 272, _barrier, false, _roomHitbox, 0, 
					choose(["Basegame", Freak, 7 + irandom(3)], ["Basegame", RhinoFreak, 1], ["Frontier_Labs", "Swarmbot_create", 5], ["Basegame", Spider, 2 + irandom(1)]));
					
					BecomeTurret_create(roomX + 32, roomY - 320, _roomHitbox, 0, null);
					BecomeChest_create(roomX, roomY - 320, AmmoChest);		
					
					TestSubjectNode_create(roomX - 160, roomY - 304); // left entry
					TestSubjectNode_create(roomX + 16, roomY - 304); // right corner
					TestSubjectNode_create(roomX + 16, roomY - 128); // bot exit
				break;
			}
				

		break;
		
		case "6x10UU":
			 // Main:
			scrFloorFillSprite(roomX, roomY - 32, 1, 2, global.sprFloorCatwalkVertical);
			scrFloorFill(roomX + 32, roomY - 224, 6, 10);
			scrFloorFillConnector(roomX + 96, roomY - 384, "up", global.sprFloorCatwalkVertical);
			_dir = "up";
			
			 // Decals:
			RoomDecalStructure_create(roomX - 186, roomY + 48, global.spr6x10UUMain);
			RoomDecalStructureFront_create(roomX - 186, roomY + 392, global.spr6x10UUMainFront);
			RoomDecalFront_create(roomX - 137, roomY + 378, global.spr6x10UUFront);
			
			 // Barrier:
			var _roomHitbox = EnemyRoomHitbox_create(roomX - 32, roomY + 224, 6, 14),
				_barrier	= Barrier_create(roomX + 16, roomY + 48, true, _roomHitbox);
				
			_layout = choose("SlowWheels", "CoverShooter");
			switch(_layout){
				case "SlowWheels":
					LaserTurret_create(roomX - 96, roomY + 160, 3, 64, 1, 640)
					LaserTurret_create(roomX + 32, roomY + 288, 3, 64, 1, 640)
					
					EnemySpawnTube_create(roomX - 80, roomY + 288, _barrier, false, _roomHitbox, 0, 
					choose(["Basegame", Freak, 7 + irandom(3)], ["Basegame", RhinoFreak, 1], ["Frontier_Labs", "Swarmbot_create", 5], ["Basegame", Spider, 2 + irandom(1)]));
					
					EnemySpawnTube_create(roomX + 16, roomY + 96, _barrier, true, _roomHitbox, 30, 
					choose(["Basegame", Freak, 7 + irandom(3)], ["Basegame", RhinoFreak, 1 + irandom(1)], ["Frontier_Labs", "Swarmbot_create", 5], ["Frontier_Deeplabs", "GatorAmalgam_create", 1 + irandom(1)]));
					
					TestSubjectNode_create(roomX - 80, roomY + 352); // bot entry
					TestSubjectNode_create(roomX + 16, roomY + 96); // top exit
				break;
				
				case "CoverShooter":
					
					var _wallX = 0;
					repeat(5){
						DeeplabsWall_create(roomX - 48 + _wallX, roomY + 272);
						DeeplabsWall_create(roomX - 48 + _wallX, roomY + 288);
						_wallX += 16;
					}
					
					instance_create(roomX - 32, roomY + 320, Terminal);
					BigTube_spawn(roomX, roomY + 330, -1);
					
					if(random(3) < 1){
						BecomeTurret_create(roomX - 32, roomY + 256, _roomHitbox, 15, null);
					}
					
					BecomeChest_create(roomX, roomY + 256, AmmoChest);
					
					instance_create(roomX - 32, roomY + 128, Server); // top server
					VoltergeistTube_create(roomX - 32, roomY + 160);
					instance_create(roomX - 32, roomY + 192, Server); // bot server
					
					 // top left
					EnemySpawnTube_create(roomX - 96, roomY + 96, _barrier, true, _roomHitbox, 15, choose(
						["Frontier_Labs",		"MissileDrone_create",	2 + irandom(1)], 
						["Frontier_Deeplabs",	"RavenAmalgam_create",	1 + irandom(2)], 
						["Basegame",			SnowTank, 1 + irandom(1)], 
						["Basegame",			GoldSnowTank, 1], 
					));
					 // top right
					EnemySpawnTube_create(roomX + 32, roomY + 96, _barrier, false, _roomHitbox, 15, choose(
						["Frontier_Labs",		"MissileDrone_create",	2 + irandom(1)], 
						["Frontier_Deeplabs",	"RavenAmalgam_create",	1 + irandom(2)], 
						["Basegame",			SnowTank, 1 + irandom(1)], 
					));
					 // bot left
					EnemySpawnTube_create(roomX - 96, roomY + 192, _barrier, true, _roomHitbox, 5, choose(
						["Basegame",			SnowBot,	2 + irandom(1)], 
						["Frontier_Deeplabs",	"RavenAmalgam_create",	1 + irandom(2)], 
						["Frontier_Deeplabs",	"GatorAmalgam_create",	1], 
					));
					
					TestSubjectNode_create(roomX - 80, roomY + 352); // bot entry
					TestSubjectNode_create(roomX - 80, roomY + 288); // mid
					TestSubjectNode_create(roomX + 16, roomY + 96); // top exit
				break;
			}
			
		break;
		
		case "FreakPark":
			 // Main:
			scrFloorFillSprite(roomX, roomY - 32, 1, 3, global.sprFloorCatwalkVertical);
			scrFloorFill(roomX, roomY - 224, 9, 8);
			scrFloorFillSprite(roomX + 160, roomY - 224, 2, 1, global.sprFloorCatwalk);
			scrFloorFillConnector(roomX + 224, roomY - 224, "right", global.sprFloorCatwalk);
			_dir = "right";
			
			 // Horizontal Walls:
			var _wallX = 208;
			repeat(5){
				 // top right wall
				DeeplabsWall_create(roomX - _wallX, roomY - 64);
				DeeplabsWall_create(roomX - _wallX, roomY - 48);
				
				 // top left wall
				DeeplabsWall_create(roomX - _wallX - 144, roomY - 64);
				DeeplabsWall_create(roomX - _wallX - 144, roomY - 48);
				
				 // bot right wall
				DeeplabsWall_create(roomX - _wallX, roomY + 112);
				DeeplabsWall_create(roomX - _wallX, roomY + 96);
				
				 // bot left wall
				DeeplabsWall_create(roomX - _wallX - 144, roomY + 112);
				DeeplabsWall_create(roomX - _wallX - 144, roomY + 96);				
				_wallX -= 16;
			}
			
			 // Vertical Walls:
			var _wallY = 32;
	//		repeat(1){
				 // top right wall
				DeeplabsWall_create(roomX - 160, roomY - _wallY);
				DeeplabsWall_create(roomX - 144, roomY - _wallY);

				 // top left wall
				DeeplabsWall_create(roomX - 352, roomY - _wallY);
				DeeplabsWall_create(roomX - 336, roomY - _wallY);
				
				 // bot right wall
				DeeplabsWall_create(roomX - 160, roomY - _wallY + 112);
				DeeplabsWall_create(roomX - 144, roomY - _wallY + 112);

				 // bot left wall
				DeeplabsWall_create(roomX - 352, roomY - _wallY + 112);
				DeeplabsWall_create(roomX - 336, roomY - _wallY + 112);
				_wallY -= 16;
	//		}

			 // Decals:
			RoomDecalStructure_create(roomX - 448, roomY - 112, global.sprFreakParkMain);
			RoomDecalStructureFront_create(roomX - 448, roomY - 9, global.sprFreakParkMainFront);
			RoomDecalFront_create(roomX - 393, roomY + 28, global.sprFreakParkFront);
			
			 // Barrier:
			var _roomHitbox = EnemyRoomHitbox_create(roomX - 240, roomY + 48, 9, 13),
				_barrier	= Barrier_create(roomX - 77, roomY + 23, false, _roomHitbox);
				
			_layout = choose("FreakMode", "Haunted House");
			switch(_layout){
				case "FreakMode":
					EnemySpawnTube_create(roomX - 240, roomY + 8, _barrier, true, _roomHitbox, 0, 
					choose(["Basegame", Freak, 14 + irandom(6)]));
					
					EnemySpawnTube_create(roomX - 240, roomY - 48, _barrier, true, _roomHitbox, 0, 
					choose(["Basegame", Freak, 7 + irandom(3)]));
					
					instance_create(roomX - 304, roomY - 12, MutantTube);
					instance_create(roomX - 176, roomY - 12, MutantTube);
					instance_create(roomX - 304, roomY + 80, MutantTube);
					instance_create(roomX - 176, roomY + 80, MutantTube);	
					
					TestSubjectNode_create(roomX - 240, roomY + 128); // bot entrance
					TestSubjectNode_create(roomX - 240, roomY + 16); // middle
					TestSubjectNode_create(roomX - 112, roomY + 16); // right exit:
					
				break;
				
				case "Haunted House":
					
					VoltergeistTube_create(roomX - 304, roomY - 12);
					VoltergeistTube_create(roomX - 176, roomY - 12);
					
					HugeTube_spawn(roomX - 288, roomY + 64, "Frozen City");
					HugeTube_spawn(roomX - 192, roomY + 64, "Frozen City");
					
					 // top
					EnemySpawnTube_create(roomX - 240, roomY - 48, _barrier, true, _roomHitbox, 20, choose(
						["Frontier_Labs",		"MissileDrone_create",	2 + irandom(1)], 
						["Basegame",			SnowTank,				1 + irandom(1)], 
						["Basegame",			GoldSnowTank,			1], 
					));
					
					 // left
					EnemySpawnTube_create(roomX - 336, roomY + 8, _barrier, false, _roomHitbox, 0, choose(
						["Frontier_Labs",		"VesselOrbiter_spawn",	2 + irandom(1)], 
						["Basegame",			SnowTank,				1 + irandom(1)], 
						["Basegame",			Wolf,					2 + irandom(1)], 
						["Basegame",			SnowBot,				2 + irandom(1)], 
					));

					 // right
					EnemySpawnTube_create(roomX - 144, roomY + 8, _barrier, false, _roomHitbox, 0, choose(
						["Frontier_Labs",		"VesselOrbiter_spawn",	2 + irandom(1)], 
						["Basegame",			SnowTank,				1 + irandom(1)], 
						["Basegame",			Wolf,					2 + irandom(1)], 
						["Basegame",			SnowBot,				2 + irandom(1)], 
					));
					
					TestSubjectNode_create(roomX - 240, roomY + 128); // bot entrance
					TestSubjectNode_create(roomX - 240, roomY + 16); // middle
					TestSubjectNode_create(roomX - 112, roomY + 16); // right exit:
					
				break;
			}
				
		break;

		case "9x5DR":
			scrFloorFillSprite(roomX, roomY, 1, 3, global.sprFloorCatwalkVertical);
			scrFloorFill(roomX + 96, roomY + 128, 9, 5);
			scrFloorFillSprite(roomX + 256, roomY + 128, 2, 1, global.sprFloorCatwalk);
			scrFloorFillConnector(roomX + 320, roomY + 128, "right", global.sprFloorCatwalk);
			_dir = "right";	
			
			 // Decals:
			RoomDecalStructure_create(roomX - 408, roomY - 80, global.spr9x5DRMain);
			RoomDecalFront_create(roomX - 393, roomY + 28, global.spr9x5DRFront);
			
			 // Barrier:
			var _roomHitbox = EnemyRoomHitbox_create(roomX - 240, roomY, 9, 8),
				_barrier	= Barrier_create(roomX - 77, roomY + 23, false, _roomHitbox);
				
			_layout = choose("Spider Chamber", "City Slickers");
			_layout = "City Slickers"
			switch(_layout){
				case "Spider Chamber":
					EnemySpawnTube_create(roomX - 160, roomY - 40, _barrier, true, _roomHitbox, 0, choose(
						["Basegame",		Spider,				3 + irandom(2)], 
						["Basegame",		InvSpider,			2 + irandom(2)], 
						["Basegame",		LaserCrystal,		2 + irandom(1)], 
					));
					
					EnemySpawnTube_create(roomX - 160, roomY + 40, _barrier, false, _roomHitbox, 0, choose(
						["Basegame",		Spider,				3 + irandom(2)], 
						["Basegame",		InvSpider,			2 + irandom(2)], 
						["Basegame",		LaserCrystal,		2 + irandom(1)], 
					));
					
					
					BigTube_spawn(roomX - 352, roomY + 48, "Spider");
					BigTube_spawn(roomX - 304, roomY + 48, choose("Spider", "Loot"));
					BigTube_spawn(roomX - 256, roomY + 48, "Spider");
					instance_create(roomX - 224, roomY + 60, Terminal);	
					
					TestSubjectNode_create(roomX - 336, roomY - 32); // entrance top
					TestSubjectNode_create(roomX - 128, roomY + 16); // exit right
					
				break;
				
				case "City Slickers":
					EnemySpawnTube_create(roomX - 160, roomY - 40, _barrier, true, _roomHitbox, 0, choose(
						["Basegame",		SnowTank,			1 + irandom(1)], 
						["Basegame",		SnowBot,			2 + irandom(2)], 
						["Basegame",		Wolf,				2 + irandom(1)], 
						["Basegame",		GoldSnowTank,		1], 
					));
					
					EnemySpawnTube_create(roomX - 160, roomY + 40, _barrier, false, _roomHitbox, 0, choose(
						["Basegame",		SnowTank,			1 + irandom(1)], 
						["Basegame",		SnowBot,			2 + irandom(2)], 
						["Basegame",		Wolf,				2 + irandom(1)], 
					));
					
					
					HugeTube_spawn(roomX - 336, roomY + 64, "Frozen City");
					HugeTube_spawn(roomX - 256, roomY + 64, "Frozen City");
					BigTube_spawn(roomX - 256, roomY - 48, -1);
					
					TestSubjectNode_create(roomX - 336, roomY - 32); // entrance top
					TestSubjectNode_create(roomX - 128, roomY + 16); // exit right
					
				break;
			}
			
		break; 
		
		case "9x9DR":
			scrFloorFillSprite(roomX, roomY, 1, 3, global.sprFloorCatwalkVertical);
			scrFloorFill(roomX + 64, roomY + 64, 7, 1);
			scrFloorFill(roomX + 64, roomY + 192, 9, 7);
			scrFloorFill(roomX + 64, roomY + 320, 7, 1);
			scrFloorFillSprite(roomX + 224, roomY + 192, 2, 1, global.sprFloorCatwalk);
			scrFloorFillConnector(roomX + 288, roomY + 192, "right", global.sprFloorCatwalk);
			_dir = "right";	
			
			 // Decals:
			RoomDecalStructure_create(roomX - 448, roomY - 144, global.spr9x9DRRoomMain);
			RoomDecalFront_create(roomX - 392, roomY + 28, global.spr9x9DRRoomFront);
				
			_layout = choose("Turbine", "Big Turbine");
			switch(_layout){
				case "Big Turbine":
				
					 // Barrier:
					var _roomHitbox = EnemyRoomHitbox_create(roomX - 240, roomY - 16, 9, 11),
						_barrier	= Barrier_create(roomX - 77, roomY + 23, false, _roomHitbox);
						
					LaserTurret_create(roomX - 240, roomY + 16, 2, 160, 3, 640);
					BecomeChest_create(roomX - 208, roomY - 16, AmmoChest);
					
				//	LaserTurret_create(roomX - 240, roomY + 16, 2, 48, 8, 640);
					
					var _wallX = 288;
					repeat(6){
						 // top wall
						DeeplabsWall_create(roomX - _wallX, roomY - 48)
						
						 // bot wall
						DeeplabsWall_create(roomX - _wallX, roomY + 64)
						_wallX -= 16;
					}
					
					instance_create(roomX - 240, roomY + 96, Terminal);
					
					 // top right
					EnemySpawnTube_create(roomX - 176, roomY - 108, _barrier, true, _roomHitbox, 5, choose(
						["Frontier_Labs",		"MissileDrone_create",	1 + irandom(1)], 
						["Frontier_Labs",		"Swarmbot_create",		4 + irandom(2)], 
						["Basegame",		RhinoFreak, 				1 + irandom(1)],
						["Basegame",		Freak,						5 + irandom(4)], 
						["Basegame",		ExploFreak, 				1 + irandom(1)], 
						["Frontier_Deeplabs",	"GatorAmalgam_create",	1 + irandom(1)]
					));
			
					 // bot right
					EnemySpawnTube_create(roomX - 176, roomY + 108, _barrier, false, _roomHitbox, 0, 
					choose(["Frontier_Labs", "MissileDrone_create", 1 + irandom(1)], ["Frontier_Labs", "Swarmbot_create", 5], ["Frontier_Deeplabs", "RavenAmalgam_create", 1 + irandom(1)]));
					 // bot left
					EnemySpawnTube_create(roomX - 304, roomY + 108, _barrier, false, _roomHitbox, 0, 
					choose(["Frontier_Labs", "MissileDrone_create", 1 + irandom(1)], ["Frontier_Labs", "Swarmbot_create", 5], ["Frontier_Deeplabs", "RavenAmalgam_create", 1 + irandom(1)]));
					
					TestSubjectNode_create(roomX - 304, roomY - 96); // entance top
					TestSubjectNode_create(roomX - 176, roomY - 96); // top right
					TestSubjectNode_create(roomX - 112, roomY + 16); // exit right
					
				break;
				
				case "Turbine":

				 // Barrier:
				var _roomHitbox = EnemyRoomHitbox_create(roomX - 240, roomY - 16, 9, 11),
					_barrier	= Barrier_create(roomX - 77, roomY + 23, false, _roomHitbox);
				
					LaserTurret_create(roomX - 240, roomY + 16, 3, 50, 16, 640)
					
					EnemySpawnTube_create(roomX - 304, roomY + 112, _barrier, false, _roomHitbox, 15, 
					choose(["Basegame", Freak, 7 + irandom(3)], ["Basegame", RhinoFreak, 1], ["Frontier_Labs", "Swarmbot_create", 5], ["Basegame", Spider, 2 + irandom(1)]));
					
					EnemySpawnTube_create(roomX - 240, roomY + 112, _barrier, false, _roomHitbox, 0, 
					choose(["Frontier_Labs", "MissileDrone_create", 1 + irandom(1)], ["Frontier_Labs", "Swarmbot_create", 5], ["Frontier_Deeplabs", "RavenAmalgam_create", 1 + irandom(1)]));
					
					EnemySpawnTube_create(roomX - 176, roomY + 112, _barrier, true, _roomHitbox, 15, 
					choose(["Basegame", Freak, 7 + irandom(3)], ["Basegame", RhinoFreak, 1], ["Frontier_Labs", "Swarmbot_create", 5], ["Basegame", Spider, 2 + irandom(1)]));
					
					EnemySpawnTube_create(roomX - 160, roomY - 112, _barrier, true, _roomHitbox, 30, 
					choose(["Frontier_Labs", "MissileDrone_create", 1 + irandom(1)], ["Frontier_Labs", "Swarmbot_create", 5], ["Frontier_Deeplabs", "RavenAmalgam_create", 1 + irandom(1)]));	
					
					TestSubjectNode_create(roomX - 304, roomY - 96); // entance top
					TestSubjectNode_create(roomX - 112, roomY + 16); // exit right
					
				break;
			}

			
		break; 
		
		case "DoubleTower":
			scrFloorFillSprite(roomX + 32, roomY, 3, 1, global.sprFloorCatwalk);
			scrFloorFill(roomX + 128, roomY, 4, 6)
			scrFloorFillSprite(roomX + 256, roomY - 48, 4, 1, global.sprFloorCatwalk);
			scrFloorFillSprite(roomX + 256, roomY + 64, 4, 1, global.sprFloorCatwalk);
			scrFloorFill(roomX + 384, roomY, 4, 6)
			scrFloorFillSprite(roomX + 480, roomY, 1, 1, global.sprFloorCatwalk);
			scrFloorFillConnector(roomX + 512, roomY, "right", global.sprFloorCatwalk);
			_dir = "right";
			
			 // Decals:
			RoomDecalStructure_create(roomX - 512, roomY - 80, global.sprDoubleTowerMain);
			RoomDecalStructureFront_create(roomX - 308, roomY - 39, global.sprDoubleTowerMainFront);
			RoomDecalFront_create(roomX - 544, roomY - 20, global.sprDoubleTowerFront);
			
			_layout = choose("Normal", "Scorp Tower");
			switch(_layout){
				case "Normal":
					 // Barrier:
					var _roomHitbox = EnemyRoomHitbox_create(roomX - 288, roomY + 32, 14, 6),
						_barrier	= Barrier_create(roomX - 50, roomY + 23, false, _roomHitbox);	
						
					BigTube_spawn(roomX - 416, roomY - 48, -1);
					BigTube_spawn(roomX - 380, roomY - 48, -1);
					
					instance_create(roomX - 432, roomY + 88, Server);

					 // bot left
					EnemySpawnTube_create(roomX - 384, roomY + 80, _barrier, true, _roomHitbox, 10, choose(
						["Frontier_Labs",		"Swarmbot_create",	4 + irandom(2)], 
						["Basegame",		Freak,					5 + irandom(4)], 
						["Basegame",		RhinoFreak,				1 + irandom(1)],
						["Basegame",		ExploFreak,				1 + irandom(1)]
					));
					
					 // bot right
					EnemySpawnTube_create(roomX - 112, roomY + 80, _barrier, false, _roomHitbox, 5, choose(
						["Frontier_Labs",		"MissileDrone_create",	2 + irandom(1)], 
						["Frontier_Deeplabs",	"RavenAmalgam_create",	1 + irandom(2)], 
						["Frontier_Deeplabs",	"GatorAmalgam_create",	1 + irandom(1)]
					));
					
					 // top right
					EnemySpawnTube_create(roomX - 112, roomY - 64, _barrier, false, _roomHitbox, 5, choose(
						["Frontier_Labs",		"MissileDrone_create",	2 + irandom(1)], 
						["Frontier_Deeplabs",	"RavenAmalgam_create",	1 + irandom(2)], 
						["Frontier_Deeplabs",	"GatorAmalgam_create",	1 + irandom(1)]
					));
					
					TestSubjectNode_create(roomX - 416, roomY + 16); // entrance left:
					TestSubjectNode_create(roomX - 352, roomY + 80); // catwalk bot left:
					TestSubjectNode_create(roomX - 156, roomY + 80); // catwalk bot right:
					TestSubjectNode_create(roomX - 96, roomY + 16); // exit right:
					
				break;
				
				case "Scorp Tower":
					 // Barrier:
					var _roomHitbox = EnemyRoomHitbox_create(roomX - 288, roomY + 32, 14, 6),
						_barrier	= Barrier_create(roomX - 50, roomY + 23, false, _roomHitbox);	
						
					var _wallY = 0;
					repeat(5){
						DeeplabsWall_create(roomX - 368, (roomY + 48) - _wallY);
						_wallY += 16;
					}	
					
					instance_create(roomX - 336, roomY, Server);
					instance_create(roomX - 336, roomY + 48, Server);
					
						
					BigTube_spawn(roomX - 416, roomY - 48, -1);

					 // bot left
					EnemySpawnTube_create(roomX - 416, roomY + 80, _barrier, true, _roomHitbox, 10, choose(
						["Frontier_Labs",		"Swarmbot_create",	4 + irandom(2)], 
						["Basegame",		Freak,					5 + irandom(4)], 
						["Basegame",		RhinoFreak,				1 + irandom(1)],
						["Basegame",		ExploFreak,				1 + irandom(1)]
					));
					
					 // bot right
					EnemySpawnTube_create(roomX - 112, roomY + 80, _barrier, false, _roomHitbox, 5, choose(
						["Basegame",		Scorpion,				2 + irandom(1)], 
						["Basegame",		Scorpion,				2 + irandom(1)], 
						["Basegame",		GoldScorpion,			1], 
					));
					
					 // top right
					EnemySpawnTube_create(roomX - 112, roomY - 64, _barrier, false, _roomHitbox, 5, choose(
						["Basegame",		Scorpion,				2 + irandom(1)], 
						["Basegame",		Scorpion,				2 + irandom(1)], 
						["Basegame",		GoldScorpion,			1], 
					));
					
					TestSubjectNode_create(roomX - 416, roomY + 16); // entrance left:
					TestSubjectNode_create(roomX - 416, roomY + 64); 
					TestSubjectNode_create(roomX - 352, roomY + 80); // catwalk bot left:
					TestSubjectNode_create(roomX - 156, roomY + 80); // catwalk bot right:
					TestSubjectNode_create(roomX - 96, roomY + 16); // exit right:
					
				break;
			}
			
		break;
		
	}

	 // output direction
	roomDir = _dir;

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
    
#define scrFloorFillSprite(_x, _y, _w, _h, _sprite)
    var o = 32;

     // Center Around x,y:
    _x -= floor((_w - 1) / 2) * o;
    _y -= floor((_h - 1) / 2) * o;

     // Floors:
    for(var _ox = 0; _ox < _w; _ox++){
        for(var _oy = 0; _oy < _h; _oy++){
            with(instance_create(_x + (_ox * o), _y + (_oy * o), Floor)){
				sprite_index		= _sprite;
            }
        }
    }

#define scrFloorFillConnector(_x, _y, _dir, _sprite)
    var o = 32,
	_w = 1,
	_h = 1;
	
     // Center Around x,y:
    _x -= floor((_w - 1) / 2) * o;
    _y -= floor((_h - 1) / 2) * o;

     // Floors:
    for(var _ox = 0; _ox < _w; _ox++){
        for(var _oy = 0; _oy < _h; _oy++){
            with(instance_create(_x + (_ox * o), _y + (_oy * o), Floor)){
	            sprite_index	= _sprite;
            	image_blend		= deeplabsDebug ? c_aqua : c_white;
            	
            	switch(_dir){
            		case "right":
		            	roomX		= x + 32;
		            	roomY		= y;
	            	break;
            		case "up":
		            	roomX		= x;
		            	roomY		= y - 32;
	            	break;
            		case "down":
		            	roomX		= x;
		            	roomY		= y + 32;	    
	            	break;
            	}
            }
        }
    }
	
#define scrFloorFillEndRoom(_x, _y, _w, _h, _sprite)
    var o = 32;

     // Center Around x,y:
    _x -= floor((_w - 1) / 2) * o;
    _y -= floor((_h - 1) / 2) * o;

     // Floors:
    for(var _ox = 0; _ox < _w; _ox++){
        for(var _oy = 0; _oy < _h; _oy++){
            with(instance_create(_x + (_ox * o), _y + (_oy * o), Floor)){
				sprite_index		= _sprite;
				fr_endroom			= true;
            }
        }
    }
    
#define scrFloorFillStupid(_x, _y, _w, _h)
    var o = 32;

     // Center Around x,y:
    _x -= floor((_w - 1) / 2) * o;
    _y -= floor((_h - 1) / 2) * o;

     // Floors:
    for(var _ox = 0; _ox < _w; _ox++){
        for(var _oy = 0; _oy < _h; _oy++){
            with(instance_create(_x + (_ox * o), _y + (_oy * o), Floor)){
            	sprite_index		= mskNone;
				image_blend			= c_red;
				fr_endroom			= true;
            }
        }
    }
    
#define area_pop_enemies
/*
	if(!global.deeplabsSpecial){
		var _x = (bbox_left + bbox_right) / 2,
			_y = (bbox_top  + bbox_bottom) / 2;
			
		var _enemy = call(scr.pool, [
	        [["GatorAmalgam_create",	"Frontier", "Frontier_Deeplabs"],  0.6],
	        [["RavenAmalgam_create",	"Frontier", "Frontier_Deeplabs"],  1],	        
	       // [["MothAmalgam_create",	"Frontier", "Frontier_Deeplabs"],  1],
	        [["Surgeon_create",			"Frontier", "Frontier_Deeplabs"],  0.6],	    
	        [[InvSpider,				"Basegame", ""],    		0.3 * (GameCont.loops > 0)],
	        [[LightningCrystal,			"Basegame", ""],    		0.2 * (GameCont.loops > 0)],
		])
		
		if(random(3) < 1){
			switch(_enemy[1]){
				case "Basegame": {
					instance_create(_x, _y, _enemy[0]);
				}
				break;
				case "Frontier": {
					mod_script_call("mod", _enemy[2], _enemy[0], _x, _y)
				}
				break;
				case "OBJ": {
					mod_script_call("mod", _enemy[2], "obj_create", _x, _y, _enemy[0])
				}
				break;
			}	
		}
	}
*/	
#define area_pop_props
/*
	if(!global.deeplabsSpecial){
		var _x = (bbox_left + bbox_right) / 2,
			_y = (bbox_top  + bbox_bottom) / 2,
			_outOfSpawn = (point_distance(x, y, 10000, 10000) > 48);
	
		 // Props:
		if(_outOfSpawn){
			if(random(18) < 1) && !(place_meeting(_x, _y, prop)){
				var _prop = call(scr.pool, [	
			        ["TerminalOff_create",    	0.3],
			        ["Terminal_create",    		1],
				]);
				mod_script_call("area", mod_current, _prop, _x, _y);
			}
		}
	}
*/
#define area_pop_extras

	
#define area_finish

	 // Next Subarea:
	if(subarea < area_subarea()){
		subarea++;
		/*
		if(subarea = 3){
			global.deeplabsSpecial = true; // enable finale
		}
		*/
	}
	
	 // Next Area:
	else{
		var _next = area_next();
		area    = _next[0];
		subarea = _next[1];
	}
	
	if(global.settingVeeOneHundred = true){
		sound_stop(global.deeplabsMusic);
	}
	
#define area_transit

	sound_stop(global.panelSound);
	
    // Restore Wall Sounds:
    sound_restore(sndWallBreakRock);

#define deeplabsFog_draw
	var _backgroundPos = global.areaBackgroundPos;
	draw_set_alpha(0.6)
	draw_sprite_tiled(global.sprFogDeeplabs2,	0, x - _backgroundPos * 0.3 + 128, y - 64)
	draw_set_alpha(0.4)
	draw_sprite_tiled(global.sprFogDeeplabs2,	0, x - _backgroundPos * 0.5, y)
	draw_set_alpha(1)
	
#define SafeRoom_populate(_safeX, _safeY)
	global.safeZone	= SafeZone_create(roomX + _safeX, roomY + _safeY);

	mod_script_call("mod", "Frontier_Pickups", "DeeplabsCache_create", roomX + _safeX, roomY + (_safeY + 40));
	
	EndRoomElevator_create(roomX + _safeX, roomY + _safeY - 72);
	
	 // elevator side walls:
	var _wallY = 0;
	repeat(3){
		instance_create(roomX + (_safeX - 32), (roomY + _safeY - 80) + _wallY, InvisiWall);
		instance_create(roomX + (_safeX + 16), (roomY + _safeY - 80) + _wallY, InvisiWall);
		_wallY += 16;
	}
	
	BigTube_spawn(roomX + (_safeX - 60), roomY + (_safeY - 66), "Loot");
	BigTube_spawn(roomX + (_safeX + 60), roomY + (_safeY - 66), "Loot");
	

	
	with(RoomDecalStructure_create(roomX + (_safeX - 160), roomY + (_safeY - 173), global.sprEndRoomMain)){
		fr_coreDetoKill = false;
		depth			= 7;
		spr_charred		= global.sprEndRoomMainCharred;
	}
	with(RoomDecalStructureFront_create(roomX + (_safeX - 160), roomY + (_safeY + 51), global.sprEndRoomMainFront)){
		fr_coreDetoKill = false;
		spr_charred		= global.sprEndRoomMainFrontCharred;
	}
	with(RoomDecalFront_create(roomX + (_safeX - 112), roomY + (_safeY + 17), global.sprEndRoomFront)){
		fr_coreDetoKill = false;
		spr_charred 	= global.sprEndRoomFrontCharred;
	}
	EndRoomRoof_create(roomX + (_safeX - 112), roomY + (_safeY - 169));
	
	
//#region PROPS
#define Terminal_create(_x, _y)
	instance_create(_x, _y, Terminal);
	
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
	
#define BigTube_create(_x, _y)
	#macro normalRotSpeed 	random_range(0.7, 1.5)
	#macro normalBobSpeed	random_range(0.04, 0.06) * choose(-1, 1);
	
	with(instance_create(_x, _y, CustomProp)){
		name = "fr_BigTube";
		
		 // Visual:
		spr_idle		= global.sprBigTube;
		spr_hurt		= global.sprBigTubeHurt;
		spr_dead		= global.sprBigTubeDead;
		spr_back		= global.sprBigTubeBack;
		spr_shadow		= shd64B;
		spr_shadow_y	= 9;
		depth			= -1;
		
		huge			= false;
		
		 // Sounds:
		snd_hurt		= sndHitMetal;
		snd_dead		= sndLabsTubeBreak;
		
		 // Vars:
		truemaxhealth	= 10;
		maxhealth		= 1/0; // dont break offscreen:
		my_health		= maxhealth;
		size			= 12;
		mask_index		= global.mskBigTube;
		image_xscale	= 1; //no flippin
		team			= 0;
		fr_allowDespawn = true;
		tubeHealthed	= false;
		
		 // Object Visual:
		spr_object			= sprBanditIdle;
		spr_object_index	= 1;
		object_startangle	= 0;
		object_rotspeed		= normalRotSpeed;
		object_bobspeed		= normalBobSpeed;
		object_bobheight	= 2;
		object_flip			= choose(1, -1);
		object_color		= make_color_rgb(40, 87, 9);
		
		 // Object Vars:
		object				= Bandit;
		object_spawntype	= "Basegame";
		object_mod			= null;
		object_throw		= true;
		object_debris		= true;
			
		on_step 		= BigTube_step;
		on_death		= BigTube_destroy;

		script_bind_draw(BigTube_draw_back, depth + 1, self);		

		return self;
	}

#define BigTube_step
	object_startangle += (object_rotspeed * current_time_scale);
	if(tubeHealthed = false){
		if(distance_to_object(Player) < 320){
			tubeHealthed = true;
			maxhealth	= truemaxhealth;
			my_health	= maxhealth;
		}
	}

#define BigTube_draw_back(_tube)
	if(!instance_exists(_tube)){
		instance_destroy();
		exit;
	}
	with(_tube){
		draw_sprite_ext(spr_back, 0, x, y, image_xscale, image_yscale, image_angle, image_blend, image_alpha);
		var _y = y + sin(current_frame * object_bobspeed) * object_bobheight
		draw_sprite_ext(spr_object, spr_object_index, x, _y, object_flip, image_yscale, object_startangle, object_color, image_alpha);
	}

#define BigTube_destroy

	 // Particles / Debris:
	if(object_debris = true){
		with(instance_create(x, y, BulletHit)){ 
			sprite_index		= sprExploderExplo 
		}
		repeat(random_range(3, 5)){
			with(instance_create(x, y, Debris)){ 
				sprite_index	= global.sprTubeDebris; 
				direction		= random(360); 
				speed			= random(5); 
			} 
		}
		repeat(random_range(2, 4)){
			with(instance_create(x, y, Debris)){ 
				sprite_index	= global.sprTubeDebrisBig; 
				direction		= random(360); 
				speed			= random(5);  
			} 
		}
		repeat(random_range(3, 6)){
			with(instance_create(x + random_range(-12, 12), y + random_range(-12, 12), BloodStreak)){ 
				sprite_index	= global.sprTubeStreak 
				direction		= irandom(360); 
			} 
		}		
		
		if(huge = true){
			repeat(random_range(3, 6)){
				with(instance_create(x + random_range(-32, 32), y + random_range(-24, 24), BloodStreak)){ 
					sprite_index	= global.sprTubeStreak 
					direction		= irandom(360); 
				} 
			}	
			repeat(4){
				with(instance_create(x + random_range(-32, 23), y + random_range(-20, 20), BulletHit)){ 
					sprite_index		= sprExploderExplo 
				}				
			}
			repeat(random_range(2, 4)){
				with(instance_create(x, y, Debris)){ 
					sprite_index	= global.sprTubeDebrisBig; 
					direction		= random(360); 
					speed			= 3 + random(3);  
				} 
			}
		}
	}
	
	 // Object:
	switch(object_spawntype){
		case "Basegame":
			with(instance_create(x, y, object)){
				if(other.object_throw = true){
					BigTube_throw();		
					mask_index = mskNone;
				}
			}
		break;
		
		case "Mod":
			with(mod_script_call("mod", object_mod, object, x, y)){
				if(other.object_throw = true){
					BigTube_throw();
					mask_index = mskNone;
				}				
			}
		break;
		
		case "OBJ":
			with(mod_script_call("mod", object_mod, "obj_create", x, y, object)){
				if(other.object_throw = true){
					BigTube_throw();
					mask_index = mskNone;
				}				
			}
		break;
		/*
		case "Hardcoded":
			switch(object){
				case "FishFreak":
					with(instance_create(x, y, Corpse)){ 
						sprite_index	= global.sprFishFreakDead; 
						image_index 	= 0; 
						direction		= random(360); 
						speed			= 4 + random(5); 
					}				
				break;
			}
		break;
		*/
	}

#define BigTube_throw
	with(mod_script_call("mod", "Frontier_Objects", "ZAxisToss_create", x, y)){
		z				= 14;
		direction   	= random(360);
		speed       	= 2 + random(2);
		zspeed      	= 4 + random(2);
		zfriction		= 0.7;
		creator     	= other;
		depth       	= other.depth;
		mask_index  	= other.mask_index;
		if("spr_shadow_y" in other){
			spr_shadow_y = other.spr_shadow_y;
		}	
	}
	
#define BigTube_spawn(_x, _y, _pool)
	if(_pool = -1){
		_pool = call(scr.pool, [
			["Basic", 1],
			["Loot", 0.1],
		]);
	}
	
	var _object = "Ammo Chest";
	
	switch(_pool){
		case "Basic":
			_object = call(scr.pool, [
				["Bandit", 1],
				["Ballguy", 1],
				["Fish Freak", 0.2],
				["Spider", 0.7],
			]);
		break;
		
		case "Loot":
			_object = call(scr.pool, [
				["Ammo Chest", 2],
				["Weapon Chest", 0.6],
				["Strike Canister", 0.8],
				["Mystery Chest", 0.4],
				["Mimic", 0.3],
				["Health Mimic", 0.3],
	        	["Weapon Mimic", (0.3 * (game_version > 0))],
				["Meal Chest", 0.4],
				["Trinket Chest", 0.15 * mod_exists("mod", "TreasureTrove")],
				["Cat Chest", 0.08 * mod_exists("mod", "ntte")],
				["Bat Chest", 0.08 * mod_exists("mod", "ntte")],
				["Rat Chest", 0.08 * mod_exists("mod", "ntte")],
				["Orchid Chest", 0.15 * mod_exists("mod", "ntte")],
				["Bonus Ammo Chest", 0.4 * mod_exists("mod", "ntte")],
				["Bonus Health Chest", 0.4 * mod_exists("mod", "ntte")],
				["HammerHead Chest", 0.15 * mod_exists("mod", "ntte")],
				["Spirit Chest", 0.06 * mod_exists("mod", "ntte")],
				["Red Ammo Chest", 0.06 * mod_exists("mod", "ntte")],
			]);
		break;
		
		case "Spider":
			_object = call(scr.pool, [
				["Spider", 1],
				["Cursed Spider", 0.7],
				["Cocoon", 0.5],
			]);
		break;
	}

	BigTube_forceSpawn(_x, _y, _object);
	
#define BigTube_forceSpawn(_x, _y, _object)

	var _objectIndex	= ds_list_find_index(global.tubeObjectName, _object),
		_objectVars		= ds_list_find_value(global.tubeObjectVars, _objectIndex)
	
	with(BigTube_create(_x, _y)){
		
		var _rotRange	= _objectVars[7],
			_bobRange	= _objectVars[8]
		
		 // Object Vars:
		object				= _objectVars[0];
		object_spawntype	= _objectVars[1];
		object_mod			= _objectVars[2];
		object_throw		= _objectVars[3];
		object_debris		= _objectVars[10];		

		 // Object Visual:
		spr_object			= _objectVars[4];
		spr_object_index	= _objectVars[5];
		object_startangle	= random(_objectVars[6]);
		object_rotspeed		= random_range(_rotRange[0], _rotRange[1]) * choose(1, -1);
		object_bobspeed		= random_range(_bobRange[0], _bobRange[1]);
		object_bobheight	= _objectVars[9];
		
		return self;
	}	

#define BigTubeObjects_init
	#macro _tespr			mod_variable_get("mod", "teassets", "spr");
	
	// causes errors on v9944 if not using numbers
	#macro WepMimicID		553
	#macro WepMimicIdle		2087

	global.tubeObjectName	= ds_list_create();
	global.tubeObjectVars	= ds_list_create();
	
	#macro normalRotRange	[0.7, 1.5];
	#macro normalBobRange	[0.04, 0.06]

	BigTubeObject_add("Bandit", Bandit, "Basegame", null, true, global.sprBigTubeObjects, 0, 360, normalRotRange, normalBobRange, 2, true);
	BigTubeObject_add("Ballguy", Exploder, "Basegame", null, true, global.sprBigTubeObjects, 8, 0, [0, 0], normalBobRange, 2, true);
	BigTubeObject_add("Spider", Spider, "Basegame", null, true, global.sprBigTubeObjects, 2, 0, [0, 0], normalBobRange, 2, true);
	BigTubeObject_add("Cursed Spider", InvSpider, "Basegame", null, true, global.sprBigTubeObjects, 3, 0, [0, 0], normalBobRange, 2, true);
	BigTubeObject_add("Cocoon", Cocoon, "Basegame", null, true, global.sprBigTubeObjects, 7, 360, normalRotRange, normalBobRange, 2, true);
	BigTubeObject_add("Fish Freak", "FishFreakCorpse_create", "Mod", "Frontier_Deeplabs", false, global.sprBigTubeObjects, 1, 360, normalRotRange, normalBobRange, 3, true);
	
	BigTubeObject_add("Ammo Chest", "TubeAmmoChest_create", "Mod", "Frontier_Deeplabs", 0, sprAmmoChest, 0, 360, normalRotRange, normalBobRange, 3, true);
	BigTubeObject_add("Weapon Chest", WeaponChest, "Basegame", null, true, sprWeaponChest, 0, 360, normalRotRange, normalBobRange, 3, true);
	BigTubeObject_add("Mystery Chest", AmmoChestMystery, "Basegame", null, true, sprAmmoChestMystery, 0, 360, normalRotRange, normalBobRange, 3, true);
	BigTubeObject_add("Health Chest", HealthChest, "Basegame", null, true, sprHealthChest, 0, 360, normalRotRange, normalBobRange, 3, true);
	BigTubeObject_add("Mimic", Mimic, "Basegame", null, true, sprMimicIdle, 0, 360, normalRotRange, normalBobRange, 3, true);
	BigTubeObject_add("Health Mimic", SuperMimic, "Basegame", null, true, sprSuperMimicIdle, 0, 360, normalRotRange, normalBobRange, 3, true);
	BigTubeObject_add("Weapon Mimic", WepMimicID, "Basegame", null, true, WepMimicIdle, 0, 360, normalRotRange, normalBobRange, 3, true);
	BigTubeObject_add("Strike Canister", RogueChest, "Basegame", null, true, sprRogueAmmoChest, 0, 360, normalRotRange, normalBobRange, 3, true);
	BigTubeObject_add("Meal Chest", "MealChest_create", "Mod", "Frontier_Pickups", true, mod_variable_get("mod", "Frontier_Pickups", "sprMealChest"), 0, 360, normalRotRange, normalBobRange, 3, true);

	if(mod_exists("mod", "TreasureTrove")){
		BigTubeObject_add("Trinket Chest", "TrinketChest_create", "Mod", "Trinkets", true, mod_variable_get("mod", "Trinkets", "sprTrinketChest"), 0, 360, normalRotRange, normalBobRange, 3, true);		
	}
	
	if(mod_exists("mod", "ntte")){
		BigTubeObject_add("Bat Chest", "BatChest", "OBJ", "telib", true, _tespr.BatChest, 0, 360, normalRotRange, normalBobRange, 3, true);	
		BigTubeObject_add("Cat Chest", "CatChest", "OBJ", "telib", true, _tespr.CatChest, 0, 360, normalRotRange, normalBobRange, 3, true);	
		BigTubeObject_add("Rat Chest", "RatChest", "OBJ", "telib", true, _tespr.RatChest, 0, 360, normalRotRange, normalBobRange, 3, true);	
		BigTubeObject_add("Orchid Chest", "OrchidChest", "OBJ", "telib", true, global.sprBigTubeObjects, 9, 0, [0, 0], normalBobRange, 2, true);	
		BigTubeObject_add("Bonus Ammo Chest", "BonusAmmoChest", "OBJ", "telib", true, _tespr.BonusAmmoChest, 0, 360, normalRotRange, normalBobRange, 3, true);	
		BigTubeObject_add("Bonus Health Chest", "BonusHealthChest", "OBJ", "telib", true, _tespr.BonusHealthChest, 0, 360, normalRotRange, normalBobRange, 3, true);	
		BigTubeObject_add("HammerHead Chest", "HammerHeadChest", "OBJ", "telib", true, _tespr.HammerHeadChest, 0, 360, normalRotRange, normalBobRange, 3, true);	
		BigTubeObject_add("Spirit Chest", "SpiritChest", "OBJ", "telib", true, _tespr.SpiritChest, 0, 360, normalRotRange, normalBobRange, 3, true);		
		BigTubeObject_add("Red Ammo Chest", "RedAmmoChest", "OBJ", "telib", true, _tespr.RedAmmoChest, 0, 360, normalRotRange, normalBobRange, 3, true);	
	}
	
	BigTubeObject_add("Snow Tank", SnowTank, "Basegame", null, false, global.sprHugeTubeObjects, 0, 0, [0, 0], normalBobRange, 3, true);
	BigTubeObject_add("Golden Snow Tank", GoldSnowTank, "Basegame", null, false, global.sprHugeTubeObjects, 1, 0, [0, 0], normalBobRange, 3, true);
	BigTubeObject_add("Frozen Car", "FrozenCar_spawn", "Mod", "Frontier_Deeplabs", false, sprFrozenCar, 1, 360, normalRotRange, normalBobRange, 3, true);
	
#define BigTubeObject_add(_name, _object, _objectSpawntype, _objectMod, _objectThrow, _objectSprite, _objectSpriteIndex, _objectStartAngleRandom, _objectRotSpeedRange, _objectBobSpeedRange, _objectBobHeight, _objectDebris)
	ds_list_add(global.tubeObjectName, _name);
	ds_list_add(global.tubeObjectVars, [_object, _objectSpawntype, _objectMod, _objectThrow, _objectSprite, _objectSpriteIndex, _objectStartAngleRandom, _objectRotSpeedRange, _objectBobSpeedRange, _objectBobHeight, _objectDebris])


#define HugeTube_create(_x, _y)
	with(BigTube_create(_x, _y)){
		spr_idle	= global.sprHugeTube;
		spr_hurt	= global.sprHugeTubeHurt;
		spr_dead	= global.sprHugeTubeDead;
		spr_back	= global.sprHugeTubeBack;
		spr_shadow	= global.shdHugeTube;
		spr_shadow_y= 16;
		
		huge		= true;
		
		truemaxhealth	= 18;;
		mask_index	= global.mskHugeTube;
		
		object_bobheight	= 8;
		
		return self;
	}
	
#define HugeTube_spawn(_x, _y, _pool)
	var _object = "Ammo Chest";
	
	switch(_pool){
		case "Frozen City":
			_object = call(scr.pool, [
				["Snow Tank", 1],
				["Golden Snow Tank", 0.2],
				["Frozen Car", 1],
			]);
		break;
	}

	HugeTube_forceSpawn(_x, _y, _object);
	
#define HugeTube_forceSpawn(_x, _y, _object)

	var _objectIndex	= ds_list_find_index(global.tubeObjectName, _object),
		_objectVars		= ds_list_find_value(global.tubeObjectVars, _objectIndex)
	
	with(HugeTube_create(_x, _y)){
		
		var _rotRange	= _objectVars[7],
			_bobRange	= _objectVars[8]
		
		 // Object Vars:
		object				= _objectVars[0];
		object_spawntype	= _objectVars[1];
		object_mod			= _objectVars[2];
		object_throw		= _objectVars[3];
		object_debris		= _objectVars[10];		

		 // Object Visual:
		spr_object			= _objectVars[4];
		spr_object_index	= _objectVars[5];
		object_startangle	= random(_objectVars[6]);
		object_rotspeed		= random_range(_rotRange[0], _rotRange[1]) * choose(1, -1);
		object_bobspeed		= random_range(_bobRange[0], _bobRange[1]);
		object_bobheight	= _objectVars[9];
		
		return self;
	}	
	
#define ProtoStatueTube_create(_x, _y)
	with(instance_create(_x + 16, _y + 2, CustomProp)){
		name = "fr_ProtoStatueTube";
		
		 // Visual:
		spr_idle		= global.sprProtoStatueTube;
		spr_hurt		= global.sprProtoStatueTubeHurt;
		spr_dead		= global.sprProtoStatueTubeDead;
		spr_back		= global.sprProtoStatueTubeBack;
		spr_object		= sprPStat1Idle;
		spr_object_2	= global.sprBigTubeObjects;
		spr_shadow		= shd64B;
		spr_shadow_y	= 9;
		depth			= -2;
		color			= make_color_rgb(40, 87, 9);
		banditRot		= random(360);
		banditRot2		= random(360);
		banditRot3		= random(360);
		
		 // Sounds:
		snd_hurt		= sndHitMetal;
		snd_dead		= sndLabsTubeBreak;
		
		 // Vars:
		maxhealth		= 34;
		my_health		= maxhealth;
		size			= 12;
		mask_index		= global.mskBigTube;
		image_xscale	= 1; //no flippin
		team			= 0;
		myStatue		= null;

		on_step			= ProtoStatueTube_step;		
		on_death		= ProtoStatueTube_destroy;

		script_bind_draw(ProtoStatueTube_draw_back, depth + 1, self);		

		return self;
	}
	
#define ProtoStatueTube_step
	banditRot  += (2 * current_time_scale)
	banditRot2 += (3 * current_time_scale)
	banditRot3 += (1 * current_time_scale)
		
#define ProtoStatueTube_draw_back(_tube)
var _bob = sin(current_frame * 0.04) * 4,
	_rotBob = sin(current_frame * 0.06) * 8;
	
	if(!instance_exists(_tube)){
		instance_destroy();
		exit;
	}
	with(_tube){
		draw_sprite_ext(spr_back, 0, x, y, image_xscale, image_yscale, image_angle, image_blend, image_alpha);
		var _y = y + 5 + _bob;
		draw_sprite_ext(spr_object_2, 0, x - 14, _y + 7, image_xscale, image_yscale, banditRot, color, image_alpha);
		draw_sprite_ext(spr_object, 0, x, _y, image_xscale, image_yscale, _rotBob, color, image_alpha);
		draw_sprite_ext(spr_object_2, 0, x + 12, _y + 15, image_xscale, image_yscale, banditRot2, color, image_alpha);
		draw_sprite_ext(spr_object_2, 0, x - 12, _y - 9, -image_xscale, image_yscale, banditRot3, color, image_alpha);
	}

#define ProtoStatueTube_destroy

	// Particles / Debris:
	repeat(4){
		with(instance_create(x + random_range(-45, 45), y + random_range(-45, 45), BulletHit)){ 
			sprite_index		= sprExploderExplo 
		}
	}
	repeat(12){
		with(instance_create(x + random_range(-20, 20), y + random_range(-20, 20), Dust)){ 
			speed			= 2 + random(2);
			direction		= random(360);
		}
	}
	repeat(random_range(5, 7)){
		with(instance_create(x, y, Debris)){ 
			sprite_index	= global.sprTubeDebris; 
			direction		= random(360); 
			speed			= 5 + random(2); 
		} 
	}
	repeat(random_range(4, 7)){
		with(instance_create(x, y, Debris)){ 
			sprite_index	= global.sprTubeDebrisBig; 
			direction		= random(360); 
			speed			= 5 + random(2); 
		} 
	}
	repeat(random_range(6, 9)){
		with(instance_create(x + random_range(-12, 12), y + random_range(-12, 12), BloodStreak)){ 
			sprite_index	= global.sprTubeStreak;
			depth			= -3;
			speed			= 4;
			direction		= random(360); 
			image_angle		= direction;
		} 
	}

	 // I was originally gonna have it just exist but these things are EVIL.
	instance_create(x, y + 22, ProtoStatue)
	 // oooougugh
	OOOOUGH_create(x, y)

#define OOOOUGH_create(_x, _y)
	with(instance_create(_x, _y, CustomObject)){
		on_step = OOOOUGH_step
		
		return self;
	}
	
#define OOOOUGH_step
	var _me = self;
	with(instances_matching(Corpse, "sprite_index", global.sprProtoStatueTubeDead)){
		ProtoStauteTubeDeadFront_create(x, y + 33, self);
		with(_me){
			instance_destroy();
		}
	}
	
#define ProtoStauteTubeDeadFront_create(_x, _y, _corpse)
	with(instance_create(_x, _y, CustomObject)){
		sprite_index	= global.sprProtoStatueTubeDeadFront
		image_index		= 0;
		image_speed		= 0;
		depth			= -2;
		myCorpse		= _corpse;
		on_step 		= ProtoStauteTubeDeadFront_step;
			
		return self;
	}
	
#define ProtoStauteTubeDeadFront_step
	if(!instance_exists(myCorpse)){
		instance_destroy();
		exit;
	}
	if(myCorpse.image_index	= 2){
		image_index	= 1;
	}
	
#define VoltergeistTube_create(_x, _y)
	with(instance_create(_x, _y, CustomProp)){
		name = "fr_voltergeisttube";
		
		 // Visual:
		spr_idle		= global.sprVoltergeistTube;
		spr_hurt		= global.sprVoltergeistTubeHurt;
		spr_dead		= global.sprVoltergeistTubeDead;
		spr_shadow		= shd32;
		spr_shadow_y	= 3;
		sprite_index	= spr_idle;
		fr_glow 		= [32, 64];
		depth			= -1;
		
		 // Sounds:
		snd_hurt		= sndHitMetal;
		snd_dead		= sndHydrantBreak;
		
		 // Vars:
		truemaxhealth	= 8
		maxhealth		= 1/0;
		my_health		= maxhealth;
		trueHealthed	= false;
		
		on_step			= VoltergeistTube_step;
		on_death		= VoltergeistTube_destroy;
		
		return self;
	}

#define VoltergeistTube_step
	if(trueHealthed = false){
		if(distance_to_object(Player) < 320){
			trueHealthed = true;
			maxhealth	= truemaxhealth;
			my_health	= maxhealth;
			on_step 	= nothing;
		}
	}
	
#define VoltergeistTube_destroy
	repeat(2 + irandom(2)){
		with(mod_script_call("mod", "Frontier_Labs", "Voltergeist_create", x, y)){
			direction	= random(360);
			speed		= 3 + random(2);
			alarm1		= 10 + irandom(5);
			armorLock	= 5;
		}
	}
	
#define TestSubjectNode_create(_x, _y)
	with(instance_create(_x, _y, CustomObject)){
		name = "fr_subjectNode";
		
		sprite_index	= mskNone;
		mask_index		= mskPlasma;
		
		if(deeplabsDebug = true){
			sprite_index	= sprFlakBullet;
			image_speed		= 0;
			image_blend		= c_aqua;
		}
		
		active			= false;
		fr_subjectNode 	= global.subjectNodeNum;
		
		global.subjectNodeNum += 1;
		
		return self;
	}
	
#define DeeplabsGenerator_create(_x, _y)
	with(instance_create(_x, _y, CustomProp)){
		
		name = "fr_DeeplabsGenerator"
		
		 // Visual:
		spr_idle	 = global.sprGenerator;
		spr_hurt	 = global.sprGeneratorHurt;
		spr_dead	 = global.sprGeneratorDead;
		spr_open	 = global.sprGeneratorActive;
		spr_shadow	 = shd32;
		spr_shadow_y = 5;
		image_xscale = 1;
		
		 // Sounds:
		snd_hurt	= sndHitMetal;
		snd_dead	= sndComputerBreak;
		
		 // Vars:
		mask_index  = mskMaggot;
		maxhealth	= 100;
		my_health	= maxhealth;
		team		= 0;
		text        = "ENTER?"
		active		= false;
		size		= 10;
		
		 // Go Go Go:
		on_step 	= DeeplabsGenerator_step;
		
		return self;
	
	}

#define DeeplabsGenerator_step

	// Activate:
	if (active = false and place_meeting(x, y, Lightning)){
		
		// Prompt Create:
		with call(scr.prompt_create, text) { 
			on_step = DeeplabsGeneratorPrompt_step; 
			opened	= false;
		}
		// Sounds:
		sound_play_pitchvol(sndLightningHit, 0.6, 2);
		sound_play_pitchvol(sndLightningReload, 0.6, 2);
		sound_play_pitchvol(sndStrongSpiritLost, 0.4, 0.5);
		
		// Sprite:
		spr_idle = spr_open;
	}


#define DeeplabsGeneratorPrompt_step
	x = xstart;
	y = ystart;
	speed = 0;
	
	 // Use:
	if(pick != -1 && opened = false){
	    
	      // Get me OUTTA Here:
		instance_create(x, y, Portal)
		global.deeplabsSpecial	= true;
		opened					= true;
		
        sound_play(sndPortalAppear)
        
	}
	
	
	

#define DeeplabsFinaleProjectileHandler_create(_x, _y)
	with(instance_create(_x ,_y, CustomObject)){
		name = "fr_DeeplabsFinaleProjectileHandler";
		
		on_begin_step	= DeeplabsFinaleProjectileHandler_beginstep;
		on_step 		= DeeplabsFinaleProjectileHandler_step;
		
		return self;
	}

#define DeeplabsFinaleProjectileHandler_beginstep
	 // Taken from NT:TE's coast:
	if(instance_exists(Player)){
		 // Destroy Projectiles Too Far Away:
		if(instance_exists(projectile)){
			var _inst = instances_matching_gt(projectile, "speed", 0);
			if(array_length(_inst)) with(_inst){
				if(distance_to_object(Player) > 1000 && distance_to_object(Floor) > 1000){
					instance_destroy();
				}
			}
		}
	}
	
	 // Weird fix for ultra bolts destroying themselves when not touching a floor:
	if(instance_exists(UltraBolt)){
		if("fr_deeplabs_ultrabolt_floors" not in GameCont){
			GameCont.fr_deeplabs_ultrabolt_floors = [];
		}
		with(UltraBolt){
			if(!place_meeting(x, y, Floor)){
				with(instance_create(0, 0, Floor)){
					name       = "UltraBoltCoastFix";
					mask_index = sprBoltTrail;
					x          = other.x;
					y          = other.y;
					xprevious  = x;
					yprevious  = y;
					visible    = false;
					creator    = other;
					array_push(GameCont.fr_deeplabs_ultrabolt_floors, self);
				}
			}
		}
	}

#define DeeplabsFinaleProjectileHandler_step
	global.areaBackgroundPos += current_time_scale;

	 // Ultra Bolt Fix Pt.2:
	if("fr_deeplabs_ultrabolt_floors" in GameCont && array_length(GameCont.fr_deeplabs_ultrabolt_floors)){
		with(instances_matching_ne(GameCont.fr_deeplabs_ultrabolt_floors, "id")){
			instance_delete(self);
		}
		GameCont.fr_deeplabs_ultrabolt_floors = [];
	}
	

#define DeeplabsFinaleController_create(_x, _y)
	with(instance_create(_x, _y, CustomObject)){
		name	= "fr_DeeplabsFinaleController";
		
		sprite_index		= mskNone;
		
		global.esploded		= false;
		
		bombStarted			= false;
		bombTimer			= 120; //180;		// time in seconds:
		dropDowned			= false;
		goalCountdown		= 60;
		goalBomb			= false;
		lastTremorSound		= -1;
		exploEffected		= false;
		playedOutro			= false;
		
		global.bombTimer	= bombTimer;
		
		
		on_step 			= DeeplabsFinaleController_step;
		on_end_step			= DeeplabsFinaleController_endstep;
		
	//	script_bind_draw(Catwalk_draw, -4)
	//	script_bind_draw(CatwalkBack_draw, 9)	
		
		return self;
	}
	
#define DeeplabsFinaleController_step

	if(instance_exists(Sniper) || instance_exists(Wolf) || instance_exists(Bandit)){
		with(Sniper){
			if(distance_to_object(Player) > 768){
				kills = 0;
				instance_destroy();
			}
		}
		with(Wolf){
			if(distance_to_object(Player) > 768){
				kills = 0;
				instance_destroy();
			}
		}
		with(Bandit){
			if(distance_to_object(Player) > 768){
				kills = 0;
				instance_destroy();
			}
		}
	}
		
	if(bombStarted = true){
		
		 // tremors:
		if(current_frame_active){
			if(random(45 + bombTimer) < 1){
				DeeplabsDoTremor(lastTremorSound);
			}
		}
		
		with(Player){
			mod_script_call('mod', 'Frontier_StatusEffects', 'status_apply_set', self, mod_variable_get('mod', 'Frontier_StatusEffects', 'buffDeeplabsSpeedUp'), 4);
			if("fr_deeplabsIMSAFE" not in self){
				fr_deeplabsIMSAFE = false;
			}
			fr_deeplabsIMSAFE = place_meeting(x, y, global.safeZone);
		}
		
		if(dropDowned = false){
			
			 // play that beat:
			if(global.settingVeeOneHundred = true){
				global.deeplabsMusic	= sound_loop(global.musDeeplabs);
				global.deeplabsMusicVolume	= audio_sound_get_gain(global.sndBlank);
				sound_volume(global.deeplabsMusic, global.deeplabsMusicVolume);
			} else {
				sound_play_music(global.musDeeplabs);
			}
			sound_play_ambient(global.sndBlank2);
			
			dropDowned = true;
			with(script_bind_draw(DeeplabsFinaleDropdown_draw, -1000)){
				imDown			= false;
				upDelay			= 35;
				height			= -50;
				letsBounce		= false;
				bounceHeight	= 0;
				bouncedUp		= false;
				letsAGo			= false;
			}
		}
		
		bombTimer -= (current_time_scale / 30);
		global.bombTimer = bombTimer;
		
		if(goalBomb = true && bombTimer >= 2.5){
			global.bombText = choose("@r!:X?:!=", "@rX:?!:X?", "@r=:+X:?X");
		} else {
			global.bombText	=	 "@r" + string_lpad(string(floor((bombTimer / power(60, 1)) % 60)), "-1", 2)	// Minutes:
								+ ":" + string_lpad(string(floor((bombTimer / power(60, 0)) % 60)), "0", 2) 	// Seconds:
								+ ":" + string_lpad(string(floor((bombTimer / power(100, -1)) % 100)), "0", 2)	// Smaller Seconds:
		}
		
		 // explode early if players all there:
		 // this also just works for exploding early if all players died too
		if(array_length(instances_matching(Player, "fr_deeplabsIMSAFE", true)) = instance_number(Player)){
			
			 // stop music on v100:
			if(!instance_exists(Player)){
				if(global.settingVeeOneHundred = true){
					sound_stop(global.deeplabsMusic);
				}
			}
			goalCountdown -= current_time_scale;
		}
		if(goalCountdown <= 0 && goalBomb = false){
			goalBomb	= true;
			if(bombTimer > 3){
				bombTimer	= 3;
			}
		}
		
		if(global.settingVeeOneHundred = true){
			if(audio_sound_get_gain(global.sndBlank) != global.deeplabsMusicVolume){
				global.deeplabsMusicVolume = audio_sound_get_gain(global.sndBlank);
				sound_volume(global.deeplabsMusic, global.deeplabsMusicVolume);
			}
		}
		
		 // Music Outro:
		if(playedOutro = false){
			if(bombTimer <= 2.8){
				playedOutro = true;
				if(instance_exists(Player)){
					if(global.settingVeeOneHundred = true){
						sound_play_pitchvol(global.sndDeeplabsOutro, 1, audio_sound_get_gain(global.sndBlank));
						sound_stop(global.deeplabsMusic);
						sound_play_ambient(global.ambDeeplabs);
					} else {
						sound_play_pitchvol(global.sndDeeplabsOutro, 1, audio_sound_get_gain(global.musDeeplabs));
						sound_play_music(global.sndBlank);
						sound_play_ambient(global.ambDeeplabs);
					}
				}
			}
		}
		
		if(bombTimer <= 0){
			if(exploEffected = false){
				exploEffected = true;
				TopCont.fog = -1;
				ExploEffect_create(x, y);
				
				sound_stop(global.panelSound);
				
				 // stop the tunes:
				sound_play_music(global.sndBlank);

				sound_play_pitchvol(global.sndDeeplabsCoreExplosion, 0.95 + random(0.2), 1.5);
				
				 // roof is like that for a bit
				with(instances_matching(CustomObject, "name", "fr_deeplabsEndRoof")){
					notYet		= false;
					canfade 	= true;
					image_alpha	= 15;
				}
			}
			global.bombText = "@rX:XX:XX"
			
			if(bombTimer <= -1){
				bombStarted		= false;
				global.esploded	= true;
				
				 // KILL EVERYONE:
				with(hitme){
					if(!place_meeting(x, y, global.safeZone)){
						if(instance_is(self, Player)){
							lasthit 	= [global.sprDangerScreen, "CORE DETONATION"];
							my_health	= 0;
							instance_destroy();
						} else {
							instance_delete(self);
						}
					}
				}
				
				 // destroy everythang:
				with(instances_matching([CustomObject, Effect], "fr_coreDetoKill", true)){
						instance_delete(self);
				}
				with(instances_matching([CustomObject, Effect], "fr_coreDetoKill", false)){
					if("spr_charred" in self){
						sprite_index	= spr_charred;
					}
				}
				with(instances_matching(CustomProjectile, "name", "fr_DeeplabsBarrierZapper")){
					instance_delete(self);
				}
				with(WepPickup){
					if(!place_meeting(x, y, global.safeZone)){
						instance_delete(self);
					}
				}
				with(chestprop){
					if(!place_meeting(x, y, global.safeZone)){
						instance_delete(self);
					}
				}
				with(Corpse){
					if(!place_meeting(x, y, global.safeZone)){
						instance_delete(self);
					}
				}
				with(Floor){
					if("fr_endroom" not in self){
						instance_destroy();
					}
				}
				with(Wall){
					if(!place_meeting(x, y, global.safeZone)){
						instance_delete(self);
					}				
				}
	
				 // stay in there:
				with(global.safeZone){
					instance_create(x, y + 144, InvisiWall);
					instance_create(x - 16, y + 144, InvisiWall);
					
					with(instance_create(x, y + 112, CustomObject)){
						sprite_index	= global.sprFloorCatwalkDestroyed;
						depth			= 9;
					}
					
					SmokeFader_create(x, y);
					SmokeGeyser_create(x - 112, y - 80);
					SmokeGeyser_create(x - 128, y + 16);
					SmokeGeyser_create(x - 96, y + 96);
					SmokeGeyser_create(x + 64, y + 180);
				}
				
				 // unlock cache:
				with(instances_matching(CustomObject, "name", "fr_deeplabsCache")){
					active = true;
				}
				
				with(instances_matching(CustomObject, "name", "fr_DeeplabsEndElevator")){
					startArrive = true;
				}
			}
		}
	}
	
#define DeeplabsFinaleController_endstep
	
	with(enemy){
		 // yokin wall collision code
	    if(place_meeting(x, y, InvisiWall)){
	        x = xprevious;
	        y = yprevious;
	        var f = friction;
	        if(place_meeting(x + hspeed, y, InvisiWall)) hspeed *= -1;
	        if(place_meeting(x, y + vspeed, InvisiWall)) vspeed *= -1;
	        while(hspeed != 0 && place_meeting(x + hspeed, y, InvisiWall)) hspeed -= clamp(hspeed, -f, f);
	        while(vspeed != 0 && place_meeting(x, y + vspeed, InvisiWall)) vspeed -= clamp(vspeed, -f, f);
	    }
	}
	with(Pickup){
		 // yokin wall collision code
	    if(place_meeting(x, y, InvisiWall)){
	        x = xprevious;
	        y = yprevious;
	        var f = friction;
	        if(place_meeting(x + hspeed, y, InvisiWall)) hspeed *= -1;
	        if(place_meeting(x, y + vspeed, InvisiWall)) vspeed *= -1;
	        while(hspeed != 0 && place_meeting(x + hspeed, y, InvisiWall)) hspeed -= clamp(hspeed, -f, f);
	        while(vspeed != 0 && place_meeting(x, y + vspeed, InvisiWall)) vspeed -= clamp(vspeed, -f, f);
	    }
	}
	with(chestprop){
		 // yokin wall collision code
	    if(place_meeting(x, y, InvisiWall)){
	        x = xprevious;
	        y = yprevious;
	        var f = friction;
	        if(place_meeting(x + hspeed, y, InvisiWall)) hspeed *= -1;
	        if(place_meeting(x, y + vspeed, InvisiWall)) vspeed *= -1;
	        while(hspeed != 0 && place_meeting(x + hspeed, y, InvisiWall)) hspeed -= clamp(hspeed, -f, f);
	        while(vspeed != 0 && place_meeting(x, y + vspeed, InvisiWall)) vspeed -= clamp(vspeed, -f, f);
	    }
	}
	with(Debris){
		 // yokin wall collision code
	    if(place_meeting(x, y, InvisiWall)){
	        x = xprevious;
	        y = yprevious;
	        var f = friction;
	        if(place_meeting(x + hspeed, y, InvisiWall)) hspeed *= -1;
	        if(place_meeting(x, y + vspeed, InvisiWall)) vspeed *= -1;
	        while(hspeed != 0 && place_meeting(x + hspeed, y, InvisiWall)) hspeed -= clamp(hspeed, -f, f);
	        while(vspeed != 0 && place_meeting(x, y + vspeed, InvisiWall)) vspeed -= clamp(vspeed, -f, f);
	    }
	}
	
#define DeeplabsFinaleDropdown_draw(_controller)
	if(instance_exists(Player)){
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
			if(global.esploded = true){
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
					height -= (3 + _dropdownExtraSpeed) * current_time_scale;
				}
			}
			if(height <= -50){
				instance_destroy();
				exit;
			}
		}
																						
		draw_sprite(global.sprBombTimerBack, 0, view_xview_nonsync + (game_width / 2), view_yview_nonsync + height);
		draw_sprite_ext(global.sprBombTimer, 0, view_xview_nonsync + (game_width / 2), view_yview_nonsync + height + bounceHeight, 1, 1,0, c_white, 1);
		draw_text_nt(view_xview_nonsync + (game_width / 2), view_yview_nonsync + height + bounceHeight + 12, global.bombText);
	}
#define RoomDecalFront_create(_x, _y, _sprite)
	with(instance_create(_x, _y, Effect)){
		
		name = "fr_deeplabsRoomDecal"
		
		fr_coreDetoKill	= true;
		
		 // Visual:
		sprite_index	= _sprite;
		image_speed		= 0.4;
		depth			= -4;

		return self;
	}

#define RoomDecalBack_create(_x, _y, _sprite)
	with(instance_create(_x, _y, Effect)){
		
		name = "fr_deeplabsRoomDecal"
		
		fr_coreDetoKill	= true;
		
		 // Visual:
		sprite_index	= _sprite;
		image_speed		= 0.4;
		depth			= 8;

		return self;
	}

#define RoomDecalStructure_create(_x, _y, _sprite)
	with(instance_create(_x, _y, Effect)){
		
		name = "fr_deeplabsRoomDecal"
		
		fr_coreDetoKill	= true;
		
		 // Visual:
		sprite_index	= _sprite;
		image_speed		= 0.4;
		depth			= 9;

		return self;
	}
	
#define RoomDecalStructureExtra_create(_x, _y, _sprite, _spd)
	with(instance_create(_x, _y, Effect)){
		
		name = "fr_deeplabsRoomDecal"
		
		fr_coreDetoKill	= true;
		
		 // Visual:
		sprite_index	= _sprite;
		image_speed		= _spd;
		depth			= 8;

		return self;
	}
	
#define RoomDecalStructureExtraBomb_create(_x, _y, _sprite, _pre_sprite, _spd)
	with(instance_create(_x, _y, Effect)){
		
		name = "fr_deeplabsRoomDecalBombChange"
		
		fr_coreDetoKill	= true;
		
		 // Visual:
		sprite_index	= _pre_sprite;
		spr_postBomb	= _sprite;
		image_speed		= 0.4;
		depth			= 8;

		return self;
	}
	
#define RoomDecalStructureFront_create(_x, _y, _sprite)
	with(instance_create(_x, _y, Effect)){
		
		name = "fr_deeplabsRoomDecal"
		
		fr_coreDetoKill	= true;
		
		 // Visual:
		sprite_index	= _sprite;
		image_speed		= 0.4;
		depth			= 11;

		return self;
	}
	
#define RoomDecalCore_create(_x, _y)
	with(instance_create(_x, _y, CustomObject)){
		
		name = "fr_deeplabsRoomDecalCore"
		
		 // Visual:
		spr_idle		= global.sprCoreIdle;
		spr_uhoh		= global.sprCoreDanger;
		sprite_index	= spr_idle;
		image_speed		= 0.4;
		depth			= 9;
		
		fr_coreDetoKill	= true;
		
		CoreEye_create(x - 35, y + 67, self, 3, 0);
		CoreEye_create(x - 64, y + 67, self, 3, 0);

		CoreEye_create(x - 28, y + 53, self, 2, 1);
		CoreEye_create(x - 71, y + 54, self, 2, 1);
		
		CoreEye_create(x - 25, y + 41, self, 2, 2);
		CoreEye_create(x - 75, y + 42, self, 2, 2);
		
		return self;
	}
	
#define RoomDecalCore_activate
	with(instances_matching(CustomObject, "name", "fr_deeplabsCoreEye")){
		instance_destroy();
	}
	with(instances_matching(CustomObject, "name", "fr_deeplabsCoreEyeCover")){
		sprite_index	= spr_end;
		image_index 	= 0;
	}
	with(instances_matching(CustomObject, "name", "fr_deeplabsRoomDecalCore")){
		sprite_index	= spr_uhoh;
	}
	
	 // finales stat:
	call(scr.save_set, "Frontier", "deeplabs_finales", ((call(scr.save_get, "Frontier", "deeplabs_finales")) + 1));
	
#define CoreEyeCover_create(_x, _y, _core)
	with(instance_create(_x, _y, CustomObject)){
		
		name = "fr_deeplabsCoreEyeCover"
		
		 // Visual:
		mask_index		= mskBandit;
		spr_strt		= global.sprCoreEyeCoverStrt;
		spr_idle		= global.sprCoreEyeCover;
		spr_end 		= global.sprCoreEyeCoverEnd;
		sprite_index	= spr_strt;
		didIt			= false;
		image_index		= 0;
		image_speed		= 0;
		depth			= 7;
		myCore			= _core;
		soundCooldown	= 0;
		lastSound		= -1;
		
		on_step 		= CoreEyeCover_step;
		
		return self;
	}
	
#define CoreEyeCover_step
	if(didIt = false){
		if(instance_exists(Player)){
			var _nearestPlayer = instance_nearest(myCore.x, myCore.y, Player);
			with(_nearestPlayer){
				if(distance_to_object(other.myCore) < 56){
					other.image_speed 	= 0.4;
					other.didIt			= true;
				}
			}
		}
	} else {
		if(sprite_index = spr_strt){
			if(image_index >= image_number - 1){
				with(instances_matching(CustomObject, "name", "fr_deeplabsCoreEye")){
					moveSpeed	= 2;
					canGo		= true;
				}
			}
			if(anim_end){
				sprite_index = spr_idle;
			}
		}
	}
	if(instance_exists(Player)){
		if(distance_to_object(Player) < 224){
			if(soundCooldown > 0){
				soundCooldown -= current_time_scale;
			} else {
				if(random(120) < 1){
					soundCooldown += 60;
					 // reduce repeat sounds:
					var _sound = irandom(array_length(global.sndDeeplabsCoreIdle) - 1);
					if(_sound = lastSound){
						_sound = irandom(array_length(global.sndDeeplabsCoreIdle) - 1);
					}
					
					lastSound = _sound;
					
					 // SFX:
					sound_play_pitch(global.sndDeeplabsCoreIdle[_sound], 1 + random_range(-0.1, 0.1));		
				}
			}
		}
	}
	if(sprite_index = spr_end){
		if(anim_end){
			instance_destroy();
		}
	}
	
#define CoreEye_create(_x, _y, _core, _range, _eyeIndex)
	with(instance_create(_x, _y - 45, CustomObject)){
		name			= "fr_deeplabsCoreEye"
		sprite_index	= global.sprCorePupil;
		image_index		= _eyeIndex;
		image_speed 	= 0;
		depth			= 8;
		
		creator			= _core;
		xPos			= _x;
		yPos			= _y;
		xgoal			= _x;
		ygoal			= _y;
		moveSpeed		= 0;
		distance		= _range;
		eyepos			= 0
		canGo			= false;
		
		on_step 		= CoreEye_step;
		
		return self;
	}
	
#define CoreEye_step
	if(!instance_exists(creator)){
		instance_destroy();
		exit;
	}
	if(instance_exists(Player)){
		var _player = instance_nearest(creator.x, creator.y, Player){
			eyepos = point_direction(x, y, _player.x, _player.y);
		}
	}

	 // Position Me:
	if(canGo = true){
	    x += approach(x, xgoal, moveSpeed, 0.3 * current_time_scale) - lengthdir_x(0, eyepos)
	    y += approach(y, ygoal, moveSpeed, 0.3 * current_time_scale) - lengthdir_y(0, eyepos) 
	    xgoal = xPos + lengthdir_x(distance, eyepos)
	    ygoal = yPos + lengthdir_y(distance, eyepos) - 45;
	}

#define approach(a, b, n, dn)
	return (b - a) * (1 - power((n - 1)/n, dn)) 
	
#define EndRoomRoof_create(_x, _y)
	with(instance_create(_x, _y, CustomObject)){
		
		name = "fr_deeplabsEndRoof"
		
		 // Visual:
		sprite_index	= global.sprEndRoomRoof;
		spr_charred		= global.sprEndRoomRoofCharred;
		spr_forcefield	= global.sprEndRoomForcefield;
		image_speed		= 0.4;
		depth			= -11;
		
		fr_endRoom		= true;
		canfade			= true;
		notYet			= true;
		fr_coreDetoKill	= false;
		
		 // this is stupid... it sucks... i dont car....
		 // nevermind i do... its awfelllllll
	//	EndRoomHitbox_create(x + 115, y + 48, false);	// top
	//	EndRoomHitbox_create(x + 115, y + 256, false); // bot
	//	EndRoomHitbox_create(x + 131, y + 198, true); // left
			
		on_step 		= EndRoomRoof_step;
		on_draw 		= EndRoomRoof_draw;

		return self;
	}

#define EndRoomRoof_step
	if(notYet = true && global.bombTimer <= 2){
		canfade = false;
	}
	if(canfade = true && place_meeting(x, y, Player)){
		if(image_alpha > 0){
			image_alpha -= 0.1 * current_time_scale;
		}
	} else {
		if(image_alpha < 1){
			image_alpha += 0.1 * current_time_scale;
		}
	}

/*
//#define EndRoomHitbox_create(_x, _y, _vertical)
	with(instance_create(_x, _y, CustomSlash)){
		
		name = "fr_deeplabsEndRoomHitbox"
		
		 // Visual:
		sprite_index	= _vertical ? global.mskEndRoomVertical : global.mskEndRoom;
		mask_index		= _vertical ? global.mskEndRoomVertical : global.mskEndRoom;
		
		fr_endRoom		= true;
		
		on_anim			= nothing;
		on_hit			= nothing;
		on_wall 		= nothing;
		on_projectile	= EndRoomHitbox_projectile;
		on_grenade		= EndRoomHitbox_projectile;

		return self;
	}

//#define EndRoomHitbox_projectile
	with(other){
		instance_create(x, y, ThrowHit);
		sound_play_pitch(sndHitMetal, 0.8 + random(0.4));
		instance_destroy();
	}
*/

#define EndRoomRoof_draw
	draw_sprite_ext(spr_forcefield, current_frame * 0.4, x + 112, y + 249, 1, 1, 0, c_white, clamp(image_alpha, 0, 0.6));
	draw_sprite_ext(spr_forcefield, current_frame * 0.4, x + 112, y + 249, 1.1, 1.1, 0, c_white, clamp(image_alpha, 0, 0.2));
	
#define EndRoomStupid_create
	with(instance_create(10016, 10016, CustomObject)){
		name = "fr_stupidCrapForMorons";

		switch(roomDirEnd){
			case "right":
				stupidX = roomX + 288;
				stupidY = roomY - 320;
			break;
			
			case "up":
				stupidX = roomX + 96;
				stupidY = roomY - 256;			
			break;
			
			case "down":
				stupidX = roomX + 416;
				stupidY = roomY - 192;			
			break;
		}

		
		on_step = EndRoomStupid_step;
		
		return self;
	}
	
#define EndRoomStupid_step

	 // right:
	scrFloorFillStupid(stupidX, stupidY, 2, 7);
	 // left:
	scrFloorFillStupid(stupidX - 224, stupidY, 2, 7);
	 // up:
	scrFloorFillStupid(stupidX - 96, stupidY - 128, 9, 2);
	 // down:
	scrFloorFillStupid(stupidX - 96, stupidY + 96, 9, 2);
	
	
	 // Right Walls:
	var _wallOffX = 0;
		_wallOffY = 0;
	repeat(4){
		var _wallOffY = 0;
		repeat(18){
			instance_create(stupidX + _wallOffX, stupidY + _wallOffY - 128, InvisiWall);
			_wallOffY += 16;
		}
		_wallOffX += 16;
	}
	
	 // Left Walls:
	var _wallOffX = 0;
		_wallOffY = 0;
	repeat(4){
		var _wallOffY = 0;
		repeat(18){
			instance_create(stupidX + _wallOffX - 224, stupidY + _wallOffY - 128, InvisiWall);
			_wallOffY += 16;
		}
		_wallOffX += 16;
	}
	
	 // Top Walls:
	var _wallOffX = 0;
		_wallOffY = 0;
	repeat(18){
		var _wallOffY = 0;
		repeat(4){
			instance_create(stupidX + _wallOffX - 224, stupidY + _wallOffY - 128, InvisiWall);
			_wallOffY += 16;
		}
		_wallOffX += 16;
	}
	
	 // Bot Walls Left:
	var _wallOffX = 0;
		_wallOffY = 0;
	repeat(4){
		var _wallOffY = 0;
		repeat(4){
			instance_create(stupidX + _wallOffX - 160, stupidY + _wallOffY + 96, InvisiWall);
			_wallOffY += 16;
		}
		_wallOffX += 16;
	}
	 // Bot Walls Right:
	var _wallOffX = 0;
		_wallOffY = 0;
	repeat(4){
		var _wallOffY = 0;
		repeat(4){
			instance_create(stupidX + _wallOffX - 64, stupidY + _wallOffY + 96, InvisiWall);
			_wallOffY += 16;
		}
		_wallOffX += 16;
	}
	
	EndRoomWallHandler_create(stupidX, stupidY);
	
	instance_destroy();
	
#define EndRoomWallHandler_create(_stupidX, _stupidY)
	with(instance_create(10016, 10016, CustomObject)){
		name = "fr_whateverman";
		
		on_end_step	= EndRoomWallHandler_endstep;
		
		stupidX = _stupidX;
		stupidY = _stupidY;
		
	}
	
#define EndRoomWallHandler_endstep
	if(array_length(instances_matching(Wall, "fr_woahwow", true)) < 42){
		if(!instance_exists(Portal)){
			
			 // Right:
			var _wallOffY = 0;
			repeat(12){
				with(instance_create(stupidX, stupidY + _wallOffY - 80, Wall)){
					sprite_index	= mskNone;
					topspr			= mskNone;
					outspr			= mskNone;
					fr_woahwow		= true;
				}
				_wallOffY += 16;
			}
			
			 // Left:
			var _wallOffY = 0;
			repeat(12){
				with(instance_create(stupidX - 176, stupidY + _wallOffY - 80, Wall)){
					sprite_index	= mskNone;
					topspr			= mskNone;
					outspr			= mskNone;
					fr_woahwow		= true;
				}
				_wallOffY += 16;
			}
			
			 // Top:
			var _wallOffX = 0;
			repeat(10){
				with(instance_create(stupidX - 160 + _wallOffX, stupidY - 80, Wall)){
					sprite_index	= mskNone;
					topspr			= mskNone;
					outspr			= mskNone;
					fr_woahwow		= true;
				}
				_wallOffX += 16;
			}
			
			 // Bot Left:
			var _wallOffX = 0;
			repeat(4){
				with(instance_create(stupidX - 160 + _wallOffX, stupidY + 96, Wall)){
					sprite_index	= mskNone;
					topspr			= mskNone;
					outspr			= mskNone;
					fr_woahwow		= true;
				}
				_wallOffX += 16;
			}
			
			 // Bot Right:
			var _wallOffX = 0;
			repeat(4){
				with(instance_create(stupidX - 64 + _wallOffX, stupidY + 96, Wall)){
					sprite_index	= mskNone;
					topspr			= mskNone;
					outspr			= mskNone;
					fr_woahwow		= true;
				}
				_wallOffX += 16;
			}
		}
	}

#define DeeplabsCorePanel_create(_x, _y)
	with(instance_create(_x, _y, CustomObject)){
		
		name = "fr_DeeplabsCorePanel"
		
		 // Visual:
		spr_idle		= global.sprCoreControlsIdle;
		spr_strt		= global.sprCoreControlsSpill;
		spr_active		= global.sprCoreControlsDanger;
		sprite_index	= spr_idle;
		image_speed		= 0.4;
		
		 // Vars:
		text        	= "SPILL?"
		active			= false;
		bombStarted		= false;
		fr_coreDetoKill	= true;
		
		 // Go Go Go:
		on_step 		= DeeplabsCorePanel_step;
		with(call(scr.prompt_create, text)){ 
			on_step 	= DeeplabsCorePanelPrompt_step; 
			used		= false;
			creator 	= other;
			mask_index	= global.mskCoreControls;
		}
		
		return self;
	
	}

#define DeeplabsCorePanel_step
	x = xstart;
	y = ystart;
	speed = 0;
	
	if(active = true){
		if(sprite_index = spr_strt && bombStarted = false){
			if(anim_end){
			    with(instances_matching(CustomObject, "name", "fr_DeeplabsFinaleController")){
			    	bombStarted	= true;
			    }	
			    bombStarted 	= true;
			    sprite_index	= spr_active;
			    image_index		= 0;
			    
			    sound_stop(global.panelSound);
			    global.panelSound = sound_loop(global.sndDeeplabsCoreControlsDanger);
			    with(instances_matching(CustomObject, "name", "fr_PanelSoundController")){
			    	soundRange	= dangerSoundRange;
			    }
	    
			    with(instances_matching(instances_matching(CustomObject, "name", "fr_DeeplabsBarrier"), "fr_starterBarrier", true)){
			    	Barrier_deactivate();
			    }	
			    with(instances_matching(CustomObject, "name", "fr_deeplabsRoomDecalBombChange")){
			    	sprite_index	= spr_postBomb;
			    }
			}
		}
	}


#define DeeplabsCorePanelPrompt_step
	x = xstart;
	y = ystart;
	speed = 0;
	
	 // Use:
	if(pick != -1 && used = false){
	    with(creator){
	    	active			= true;
	    	sprite_index	= spr_strt
	    	image_index		= 0;
	    	
	    	sound_play(global.sndDeeplabsSpill);
	    	
	    	 // Core Detonations State:
			RoomDecalCore_activate();
	    }
    	instance_destroy();
    	exit;
	}
	with(creator){
		if(active){
			with(other){
				instance_destroy();
			}
		}
	}
	
#define SafeZone_create(_x, _y)
	with(instance_create(_x, _y, CustomObject)){
		name = "fr_deeplabsSafeZone";
		
		sprite_index	= global.mskRoomHitbox;
		image_alpha		= deeplabsDebug ? 0.2 : 0;
		image_xscale	= 5;
		image_yscale	= 5.5;
		
		return self;
	}
	
#define EndRoomElevator_create(_x, _y)
	with(instance_create(_x, _y, CustomObject)){
		
		name = "fr_DeeplabsEndElevator"
		
		 // Visual:
		spr_idle		= global.sprEndRoomElevatorIdle;
		spr_arrive		= global.sprEndRoomElevatorArrive;
		spr_open		= global.sprEndRoomElevatorOpen;
		spr_cover_open	= global.sprEndRoomElevatorCoverOpen;
		spr_leave		= global.sprEndRoomElevatorLeave;
		spr_cover_leave	= global.sprEndRoomElevatorCoverLeave;
		spr_cover_gone	= global.sprEndRoomElevatorCoverGone;
		sprite_index	= spr_idle;
		spr_cover		= mskNone;
		image_speed		= 0.6;
		depth			= 5;
		
		 // Vars:
		text        	= "EXIT"
		arrived 		= false;
		leftthestation	= false;
		leaveTime		= 90;
		spawnedPortal	= false;
		launchedPod 	= false;
		arrivalTime		= 270;
		startArrive 	= false;
		musicks			= false;
	
		 // Go Go Go:
		on_step 		= EndRoomElevator_step;
	
		
		 // Draw Cover:
		with(script_bind_draw(EndRoomElevatorCover_draw, -5, self)){
			x = other.x;
			y = other.y;
		}
		
		 // Epic InvisiWall:
		with(instance_create(x, y + 16, InvisiWall)){
			fr_elevwall = true;
		}
		with(instance_create(x - 16, y + 16, InvisiWall)){
			fr_elevwall = true;
		}
		
		return self;
	}
	
#define EndRoomElevator_step
	if(arrived = false){
		if(startArrive = true){
			if(arrivalTime > 0){
				
				if(arrivalTime <= 100){
					if(musicks = false){
						musicks = true;
						if(instance_exists(Player)){
							sound_play_music(global.musDeeplabsAftermath);
						}
					}
				}
				
				arrivalTime -= current_time_scale;
			} else {
				startArrive 		= false;
				
				if(sprite_index != spr_arrive){
					image_index		= 0;
					sprite_index	= spr_arrive;
					
					repeat(10){
						with(instance_create(x, y + random_range(-8, 8) + 16, Dust)){
							sprite_index	= mod_variable_get("mod", "Frontier_Labs", "sprWhiteSmoke");
							direction		= choose(90, 270)
							speed			= 3;
						}
					}
					if(instance_exists(Player)){
						sound_play_pitch(sndToxicBoltGas, 0.75 + random(0.1));
					}
				}
			}
		}
		if(sprite_index = spr_arrive){
			if(anim_end){
				arrived			 = true;
			
				if(instance_exists(Player)){
					sound_play_pitchvol(sndCursedReminder, 3, 2);
				}
								
				sprite_index	= spr_open;
				spr_cover		= spr_cover_open
				image_index		= 0;
				
				 // have walls:
				with(instances_matching(InvisiWall, "fr_elevwall", true)){
					instance_delete(self);
				}
				
				 // make prompt:
				with(call(scr.prompt_create, text)){ 
					creator = other;
					on_step = EndRoomElevatorPrompt_step; 
				}
			}
		}
	} else {
		if(sprite_index	= spr_leave){
			if(anim_end){
				sprite_index	= spr_idle;
				spr_cover		= spr_cover_gone;
				leftthestation	= true;
			}
		}
		if(leftthestation = true){
			with(Player){
				x = other.x;
				y = other.y;
			}
			if(leaveTime > 0){
				leaveTime -= current_time_scale;
				if(leaveTime < 60){
					if(launchedPod = false){
						launchedPod	= true;
						EndRoomPod_create(x, y);
						GameCont.fr_deeplabsDecal	= true;
						sound_play_pitchvol(global.sndDeeplabsPodFly, 1, 1.5);
						sound_play_pitch(sndExplosionS, 0.7);
						sound_play_pitch(sndClusterLauncher, 0.7);
					}
				}
			} else {
				if(spawnedPortal = false){
					spawnedPortal = true;
					with(instance_create(x, y, Portal)){
						image_alpha	= 0;
					}
					sound_play_pitch(sndExplosionS, 0.8)
					
					 // particle burst to go along with portal view pan:
					with(instances_matching(CustomObject, "name", "fr_endroompod")){
						repeat(15){
							with(instance_create(x, y, Dust)){
								sprite_index	= sprSmoke;
								growspeed		= 0.25;
								depth			= other.depth + 1;
								direction	= 270 + random_range(-50, 50);
								speed		= 6 + random(2);
							}
						}
					}
				}
			}
		}
	}

#define EndRoomElevatorCover_draw(_elevator)
	draw_sprite(_elevator.spr_cover, _elevator.image_index, x, y)
	
#define EndRoomElevatorPrompt_step
	if(pick != -1){
		with(creator){
			sprite_index	= spr_leave;
			spr_cover		= spr_cover_leave;
			
			sound_play_pitchvol(sndCursedReminder, 1.5, 2);
			
			 // Epic InvisiWall:
			with(instance_create(x, y + 16, InvisiWall)){
				fr_elevwall = true;
			}
			with(instance_create(x - 16, y + 16, InvisiWall)){
				fr_elevwall = true;
			}			
		}
		instance_destroy();
	}	
	
#define EndRoomPod_create(_x, _y)
	with(instance_create(_x, _y, CustomObject)){
		name = "fr_endroompod";
		
		sprite_index	= global.sprEndRoomPod;
		depth			= 12;
		
		direction		= 90;
		speed			= 14;
		friction		= -0.01;
		
		with(Player){
			view_object[index] = other;
		}
		
		on_step 		= EndRoomPod_step
		
		return self;
	}
	
#define EndRoomPod_step

	if(speed > 14.08){
		depth = -12;
	}

	if(current_frame_active){
		with(instance_create(x, y, Dust)){
			sprite_index	= sprSmoke;
			growspeed		= 0.25;
			depth			= 16;
			direction		= 270 + random_range(-12, 12);
			speed			= 5;
		}
		repeat(2){
			with(instance_create(x + random_range(-5, 5), y + random_range(-16, 16), BulletHit)){
				sprite_index	= choose(sprGroundFlameDisappear, sprGroundFlameBigDisappear, sprTrapFire);
				image_speed		= 0.25;
				direction		= 270 + random_range(-24, 24)
				image_angle 	= random(360);
				speed			= 6;
				image_yscale	= -random_range(1, 1.5)
				depth			= 15;
			}
		}
	}
	
#define Barrier_create(_x, _y, _horizontal, _spawnHitbox)
	with(instance_create(_x, _y, CustomObject)){
		name = "fr_DeeplabsBarrier"
		
		sprite_index	= _horizontal ? global.sprBarrier			: global.sprBarrierVertical;
		spr_inactive	= _horizontal ? global.sprBarrierOff		: global.sprBarrierVerticalOff;
		vertical		= _horizontal;
		image_speed		= 0.4;
		playSound		= true;
		
		solvedMyRiddles	= false;
		myZapper		= noone;
		myBack			= noone;
		enemyMode		= false;
		enemyModeTime	= 750 // 25 seconds:
		startHitbox		= _spawnHitbox;
		fr_coreDetoKill	= true;
		
		 // if vertical idk why its negative
		if(!_horizontal){
			myBack		= BarrierBack_create(x, y, vertical);
			depth		= -3;
		}
		
		on_step 		= Barrier_step;
		
		return self;
	}
	
#define Barrier_step
	if(solvedMyRiddles = false){
		if(!instance_exists(myZapper)){
			myZapper = BarrierZapper_create(x, y, vertical, self);
		}
		if(enemyMode = true){
			if(enemyModeTime > 0){
				enemyModeTime -= current_time_scale;
			}
			 // if time out or all enemies dead:
			if(enemyModeTime <= 0 || array_length(instances_matching(enemy, "fr_myBarrier", self)) <= 0){
				Barrier_deactivate();
			}
		}
	}
	
#define Barrier_deactivate
	solvedMyRiddles	= true;
	sprite_index	= spr_inactive;
	
	 // Back Sprite:
	if(instance_exists(myBack)){
		with(myBack){
			sprite_index	= spr_inactive;
		}
	}
	
	 // Clear Enemies:
	with(instances_matching(enemy, "fr_myBarrier", self)){
		fr_myBarrier = null;
	}
	
	 // You Did It!
	if(playSound = true){
		if(distance_to_object(Player) < 512){
			sound_play(global.sndPuzzleCompleted);
			sound_play_pitchvol(sndLightningHit, 1 + random(0.2), 1);
		}
	}
	
	 // Shut Down Zapper:
	if(instance_exists(myZapper)){
		with(myZapper){
			repeat(6){
				with(instance_create(x, y, BulletHit)){
					sprite_index	= global.sprBarrierFizzle[other.image_index];
					direction		= random(360);
					speed			= 1 + random(2);
				}
			}
			instance_destroy();
		}
	}
	
#define BarrierBack_create(_x, _y, _horizontal)
	with(instance_create(_x, _y, CustomObject)){
		name = "fr_DeeplabsBarrierBack"
		
		fr_coreDetoKill	= true;
		
		sprite_index	= global.sprBarrierVerticalBack;
		spr_inactive	= global.sprBarrierVerticalBackOff;
		depth			= 0;
		image_speed 	= 0.4;
		
		return self;
	}
	
#define BarrierZapper_create(_x, _y, _vertical, _creator)
	with(instance_create(_x, _y, CustomProjectile)){
		name = "fr_DeeplabsBarrierZapper"
		
		sprite_index	= _vertical ? global.sprBarrierZapper : global.sprBarrierZapperVertical;
		fr_bloom		= _vertical ? [2, 0.1] : [1.2, 0.1];
		depth			= -3;
		image_speed		= 0.4;
		image_index		= _creator.image_index;
		
		mask_index		= _vertical ? global.mskBarrierZapper : global.mskBarrierZapperVertical;
		damage			= 6;
		
		on_hit			= BarrierZapper_hit;
		on_wall 		= nothing;
		
		team			= 9910;
		
		return self;
	}
	
#define BarrierZapper_hit
	if(projectile_canhit_melee(other)){
		with(other){
			lasthit = [global.sprBarrierGameover, "BARRIER"];
			projectile_hit(self, other.damage);
		}
	}

#define EnemyRoomHitbox_create(_x, _y, _xScale, _yScale)
	with(instance_create(_x, _y, CustomObject)){
		name	= "fr_deeplabsRoomStartHitbox";
		active	= false;
		
		sprite_index	= global.mskRoomHitbox;
		image_alpha		= deeplabsDebug ? 0.2 : 0;
		image_xscale	= _xScale;
		image_yscale	= _yScale;
		
		on_step 		= EnemyRoomHitbox_step;
		
		return self;
	}

#define EnemyRoomHitbox_step
	if(place_meeting(x, y, Player)){
		active = true;
	} 
	if(active = true){
		with(instances_matching(CustomObject, "spawnHitbox", self)){
			active = true;
		}
		instance_destroy();
	}
	
#define StartRoomHitbox_create(_x, _y)
	with(instance_create(_x, _y, CustomObject)){
		name	= "fr_deeplabsStartingRoomHitbox";
		active	= false;
		
		sprite_index	= global.mskRoomHitbox;
		image_alpha		= deeplabsDebug ? 0.1 : 0;
		image_xscale	= 21;
		image_yscale	= 21;
		active			= false;
		
		on_step 		= StartRoomHitbox_step;
		
		return self;
	}

#define StartRoomHitbox_step
	with(Player){
		if(distance_to_object(other) > 16){
			with(other){
				active = true;
			}
		}
	}
	if(active = true){
		if(autoBomb = true){
			with(instances_matching(CustomObject, "name", "fr_DeeplabsFinaleController")){
				if(bombStarted = false){
					RoomDecalCore_activate();
					bombStarted = true;
				}
			}
			with(instances_matching(CustomObject, "name", "fr_DeeplabsCorePanel")){
				if(active = false){
					active			= true;
					sprite_index	= spr_strt;
					
					sound_stop(global.panelSound);
					global.panelSound = sound_loop(global.sndDeeplabsCoreControlsDanger);
				    with(instances_matching(CustomObject, "name", "fr_PanelSoundController")){
				    	soundRange	= dangerSoundRange;
				    }
			    
				}
			}
		}
		instance_destroy();
	}
	
#define DeeplabsDoTremor(_lastTremorSound)
	with(call(scr.instance_random, Player)){
		
		 // reduce repeat sounds:
		var _sound = irandom(array_length(global.sndDeeplabsTremor) - 1);
		if(_sound = _lastTremorSound){
			_sound = irandom(array_length(global.sndDeeplabsTremor) - 1);
		}
		
		other.lastTremorSound = _sound;
		
		 // SFX:
		sound_play_pitch(global.sndDeeplabsTremor[_sound], 1 + random_range(-0.1, 0.1));
		
		 // ScreenShake:
		var _shakes = 1 + irandom(10),
			_power	= 50 + irandom(70);
		ShakeItShakeIt_create(self, _power, _shakes);
		
		 // Falling Debris:
		repeat(_shakes / 3){
			FallingDebris_spawn(x + random_range(-96, 96), y - random(256));
		}
	}

#define FallingDebris_spawn(_x, _y)
	with(FallingDebris_create(_x, _y - 384)){
		var _back = choose(true, false);
		depth = (_back = true) ? 12 : -12;
		isback = (_back = true) ? true : false;
	}
	
#define FallingDebris_create(_x, _y)
	with(instance_create(_x, _y, CustomObject)){
		name	= "fr_deeplabsFallingDebris";
		
		sprite_index	= (random(5) < 1) ? global.sprFallingDebrisBig : global.sprFallingDebris;
		image_index		= irandom(image_number);
		image_speed		= 0;
		image_alpha		= 0;
		lifeTime		= 90;
		fallspeed		= (10 + random(6)) * current_time_scale;
		rotspeed		= (12 + random(20)) * current_time_scale;
		isback			= false;
		floortime		= 0;
		
		on_step 		= FallingDebris_step;
		on_destroy		= FallingDebris_destroy;
		
		return self;
	}	
	
#define FallingDebris_step

	 // fade in:
	if(image_alpha < 1){
		image_alpha += 0.05;
	}

	 // move it
	y += fallspeed
	image_angle	+= rotspeed
	
	 // fall behind stuff
	if(isback){
		if(place_meeting(x, y, Floor)){
			floortime += 2 * current_time_scale;
			if(floortime >= 20){
				lifeTime = 0
			}
		}
	}
	
	 // partical
	if(random(2) < 1){
		if!(isback && place_meeting(x, y, Floor)){
			with(instance_create(x + random_range(-5, 5), y, BulletHit)){
				sprite_index	= choose(sprGroundFlameDisappear, sprGroundFlameBigDisappear);
				var _dir		= random_range(-35, 35);
				image_index		= 1;
				image_angle 	= 180 + _dir
				direction		= 270 + _dir;
				speed			= 2;
				image_yscale	= -random_range(1, 1.5)
				depth			= other.depth - 1;
			}
		}
	}
	
	 // get outta here
	lifeTime -= current_time_scale;
	if(lifeTime <= 0){
		instance_destroy();
		exit;
	}
	
#define FallingDebris_destroy
	repeat(6){
		with(instance_create(x + random_range(-5, 5), y, BulletHit)){
			sprite_index	= choose(sprGroundFlameDisappear, sprGroundFlameBigDisappear);
			image_index		= 1;
			direction		= random(360);
			image_angle 	= direction
			speed			= 2;
			image_yscale	= -random_range(1, 1.5)
			depth			= other.depth - 1;
		}
	}
	
#define ShakeItShakeIt_create(_player, _power, _times)
	with(instance_create(10016, 10016, CustomObject)){
		name	= "fr_deeplabsTremorShaker";

		shaker			= _player;
		shakePower		= _power;
		shakes			= 1 + _times;
		shakeTime		= 2;
		
		on_step 		= ShakeItShakeIt_step;
		
		return self;
	}		

#define ShakeItShakeIt_step
	shakeTime -= current_time_scale;
	if(shakeTime <= 0){
		if(shakes > 0 && instance_exists(shaker)){
			shakes -= 1;
			shakeTime = 2;
			view_shake_at(shaker.x, shaker.y, shakePower);
			shakePower *= 0.75;
		} else {
			instance_destroy();
		}
	}

#define ColorPuzzleController_create(_x, _y, _count)
	with(instance_create(_x, _y, CustomObject)){
		name			= "fr_colorPuzzleController";
		
		
		
		 // Choose Colors:
		myPattern	= [];
		repeat(_count){
			var _color = call(scr.pool, [
				[make_color_rgb(252, 58, 0),		array_find_index(myPattern, make_color_rgb(252, 58, 0))		= -1],
				[make_color_rgb(255, 133, 0),		array_find_index(myPattern, make_color_rgb(255, 133, 0))	= -1],
				[make_color_rgb(255, 230, 0),		array_find_index(myPattern, make_color_rgb(255, 230, 0))	= -1],
				[make_color_rgb(67, 255, 0),		array_find_index(myPattern, make_color_rgb(67, 255, 0))		= -1],
				[make_color_rgb(0, 255, 255),		array_find_index(myPattern, make_color_rgb(0, 255, 255))	= -1],
				[make_color_rgb(253, 58, 255),		array_find_index(myPattern, make_color_rgb(253, 58, 255))	= -1],
			])
			array_push(myPattern, _color);
		}

		patternLength	= _count;
		inputPattern	= [];
		myBarrier		= noone;
		myButton		= [];
		myBulb			= [];
		puzzleSolved	= false;
		currentBulb		= 0;
		
		on_step 		= ColorPuzzleController_step;
		
		return self;
	}
	
#define ColorPuzzleController_step

	 // Fully Inputted Pattern:
	if(array_length(inputPattern) >= patternLength){
		if(array_equals(inputPattern, myPattern)){
			puzzleSolved = true;
			
			 // Disable Buttons:
			var _button = 0;
			repeat(array_length(myButton)){
				with(myButton[_button]){
					color = c_gray;
					PressureButton_disable();
				}
				_button += 1;
			}
			
		} else {
			 // Reset Pattern:
			inputPattern	= [];
			currentBulb		= 0;
			
			 // Reset Bulb:s
			var _bulb = 0;
			repeat(array_length(myBulb)){
				with(myBulb[_bulb]){
					color = c_white;
				}
				_bulb += 1;
			}
		}
	}

	if(puzzleSolved = true){
		with(myBarrier){
			Barrier_deactivate();
		}
		instance_destroy();
		exit;
	}
	
#define ColorBulb_create(_x, _y, _color)
	with(instance_create(_x, _y, CustomObject)){
		name	= "fr_colorBulb";
		
		sprite_index	= global.sprColorBulb;
		spr_overlay		= global.sprColorBulbOverlay;
		color			= _color;
		fr_coreDetoKill	= true;
		
		on_draw 		= ColorBulb_draw;
		
		return self;
	}
	
#define ColorBulb_draw
	draw_self();
	draw_sprite_ext(spr_overlay, 0, x, y, 1, 1, 0, color, 1);
	draw_sprite_ext(spr_overlay, 0, x, y + 1, 1.2, 1.2, 0, color, 0.4);
	
#define ColorButton_create(_x, _y, _color, _owner)
	with(instance_create(_x, _y, CustomObject)){
		name = "fr_DeeplabsPressureButton"
		
		sprite_index	= global.sprPressureButton;
		spr_overlay		= global.sprPressureButtonOverlay;
		image_index		= 0;
		depth			= 0;
		image_speed 	= 0;
		color			= _color;
		
		mask_index		= global.mskPressureButton;
		pressed 		= false;
		outputSignal	= false;
		owner			= _owner;
		pressDelay		= 30;
		fr_coreDetoKill	= true;
		
		on_step 		= ColorButton_step;
		on_draw 		= PressureButton_draw;

		return self;
	}

#define ColorButton_step
	if(place_meeting(x, y, Player)){
		pressed			= true;
		pressDelay		= 20;
		image_index		= 1;
		if(outputSignal = false){
			outputSignal = true;
			 // Update Pattern + Bulb:
			var _buttonColor = color;
			with(owner){
				with(myBulb[currentBulb]){
					color = _buttonColor;
				}
				array_push(inputPattern, _buttonColor);
				currentBulb += 1;
			}
			sound_play_pitch(sndClick, 0.7 + random(0.2));
		}
	} else {
		if(pressDelay > 0){
			pressDelay -= current_time_scale;
			if(pressed = true && pressDelay <= 0){
				pressed 		= false;
				image_index		= 0;
				outputSignal	= false;
			}
		}
	}

#define PressureButton_draw
	draw_self();
	draw_sprite_ext(spr_overlay, image_index, x, y, 1, 1, 0, color, 1);
	
#define PressureButton_disable
	image_index	= 1;
	on_step 	= nothing;
	
#define SpinTurret_create(_x, _y, _speedMultiplier)
	with(instance_create(_x, _y, CustomEnemy)){
		
		name				= "Spin Turret"
		
		 // Visuals:	
		spr_base			= global.sprSpinTurretBase;
		spr_top_on 			= global.sprSpinTurretTop;
		spr_top_off			= global.sprSpinTurretTopOff;
		spr_top 			= spr_top_off;
		spr_gun 			= global.sprSpinTurretGun;
		spr_gameover		= global.sprSpinTurretGameover;
		spr_dead			= global.sprSpinTurretDead;
		sprite_index		= spr_idle;
		image_speed			= 0.4;
		depth				= -1;
		hitid				= [spr_gameover, "SPIN TURRET"];
		spr_shadow			= shd24;
		spr_shadow_y		= 4;
		
		 // Sounds:
		snd_hurt			= sndTurretHurt;
		snd_dead			= sndTurretDead;
		
		 // Vars:
		team				= 1;
		mask_index			= mskBandit;
		maxhealth			= 200;
		my_health			= maxhealth;
		active				= true;
		shootAngle			= random(360);
		drawAngle			= shootAngle;
		shootTime			= 60;
		size				= 5;
		shootDivide			= _speedMultiplier;
        fr_possessable		= true;
        fr_possessed		= false;
		
		on_step				= SpinTurret_step;
		on_hurt				= Prop_hurt;
		on_draw 			= SpinTurret_draw;
		on_possessed		= script_ref_create(SpinTurret_possessed)
		
		return self;
	}
	
#define SpinTurret_step

	x = xstart;
	y = ystart;
	speed = 0;
	
	if(anim_end){
		sprite_index = spr_idle;
	}
	
	if(distance_to_object(Player) < 160){
		active = true;
		spr_top = spr_top_on;
	} else {
		active = false;
		spr_top = spr_top_off;
	}
	if(active = true){
		shootTime -= current_time_scale;
		drawAngle -= (angle_difference(drawAngle, shootAngle) * power(0.1, current_time_scale));
		if(shootTime <= 0){
			for(i = 0; i < 360; i += 90){
		    	with instance_create(x + lengthdir_x(14, other.i + other.shootAngle), y + lengthdir_y(14, other.i + other.shootAngle), EnemyBullet1){
		    		speed		= 8;
		    		damage		= 3;
					direction	= other.i + other.shootAngle;
					image_angle	= direction;
					team		= other.team;
					creator 	= other;
					hitid		= other.hitid;
		    	}
			}
			shootTime = 60 / shootDivide;
			shootAngle += 33;
			sound_play_pitch(sndTurretFire, 0.7 + random(0.3))
		}
	}
	
	
 	 // DIE:
	if(my_health <= 0){
		with(instance_create(x, y, Corpse)){
			sprite_index = other.spr_dead;
			image_xscale = other.image_xscale;
			size		 = other.size;
		}
		sound_play(snd_dead)
		
		 // Goodbye:
		instance_destroy();
	}
	
#define SpinTurret_draw
	if(nexthurt >= current_frame + 4){ 
		d3d_set_fog(1, c_white, 0, 0);
	}
		
	draw_sprite(spr_base, 0, x, y)
	
	if(!surface_exists(global.surfaceSpinTurret)){
		global.surfaceSpinTurret = surface_create(game_width, game_height);
	}

	surface_set_target(global.surfaceSpinTurret)
		
	var ns_x		= view_xview_nonsync; 
	var ns_y		= view_yview_nonsync;
	var stack		= 1; // repeats in a single pixel stack
	var height		= 4; // frames/height of spritestack
	
	draw_clear_alpha(c_white, 0) 

	for (var i = 0; i <= height; i ++;){
		for (var s = 1; s <= stack; s ++;){
			var o = ((s - 1) / stack);

			for(i = 0; i < sprite_get_number(spr_gun); i++){
				draw_sprite_ext(spr_gun, i, x - ns_x, y - (i - o) - ns_y, 1, 1, drawAngle, image_blend, 1);
			}
		}
	}
	
	surface_reset_target()
	
	 // Outlines:
	draw_surface_ext(global.surfaceSpinTurret, ns_x + 1, ns_y, 1, 1, 0, c_black, 1)
	draw_surface_ext(global.surfaceSpinTurret, ns_x - 1, ns_y, 1, 1, 0, c_black, 1)
	draw_surface_ext(global.surfaceSpinTurret, ns_x, ns_y + 1, 1, 1, 0, c_black, 1)
	draw_surface_ext(global.surfaceSpinTurret, ns_x, ns_y - 1, 1, 1, 0, c_black, 1)

	draw_surface(global.surfaceSpinTurret, ns_x, ns_y)
	
	draw_sprite(spr_top, 0, x, y)
	d3d_set_fog(0, 0, 0, 0);
	
#define SpinTurret_possessed
	 // Status Effect:
	mod_script_call('mod', 'Frontier_StatusEffects', 'status_apply_set', self, mod_variable_get('mod', 'Frontier_StatusEffects', 'buffVoltergeist'), 1/0);
	
	 // Apply Sprites:
	hitid			= [spr_idle, "POSSESSED#SPIN TURRET"];
	spr_top_on 		= global.sprSpinTurretTopPossessed;
	spr_top_off		= global.sprSpinTurretTopOffPossessed;
	spr_gameover	= global.sprSpinTurretGameoverPossessed;
	
	 // yeah:
	shootDivide	*= 2;
	
#define LaserTurret_create(_x, _y, _laserCount, _laserLength, _laserSpeed, _laserDis)
	with(instance_create(_x, _y, CustomObject)){
		name				= "Laser Turret"
		
		 // Visuals:	
		spr_idle			= global.sprLaserTurret;
		spr_gameover		= global.sprLaserTurretGameover;
		sprite_index		= spr_idle;
		image_speed			= 0.4;
		depth				= 5;
		hitid				= [spr_gameover, "LASER TURRET"];
		spr_shadow			= shd24;
		spr_shadow_y		= 4;
		
		 // Sounds:
		snd_hurt			= sndTurretHurt;
		snd_dead			= sndTurretDead;
		
		 // Vars:
		team				= 1;
		mask_index			= mskBandit;
		active				= false;
		shootAngle			= random(360);
		size				= 5;
		laserCount			= _laserCount;
		laserLength 		= _laserLength;
		laserSpeed			= _laserSpeed;
		activeDis			= _laserDis;
		fr_coreDetoKill		= true;
		
		on_step				= LaserTurret_step;
		
    	LaserTurretSourceTop_create(x, y);
    	LaserTurretSource_create(x, y);
		
		return self;
	}
	
#define LaserTurret_step

	x = xstart;
	y = ystart;
	speed = 0;
	
	if(distance_to_object(Player) < activeDis){
		if(active = false){
			active		= true;
			for(var i = 0; i < 360; i += (360 / laserCount)){
				LaserTurretBeam_create(x, y, shootAngle, i, laserLength);
			}
		}
	} else {
		if(active = true){
			active		= false;
			with(instances_matching(instances_matching(CustomProjectile, "name", "fr_LaserTurretBeam"), "creator", self)){
				instance_destroy();
			}
		}
	}
	shootAngle += laserSpeed * current_time_scale;
	
#define LaserTurretBeam_create(_x ,_y, _direction, _offset, _length)
	with instance_create(_x, _y, CustomProjectile){
		name			= "fr_LaserTurretBeam";
	
		// Visuals:
    	image_angle 	= _direction;
		sprite_index	= global.sprLaserTrapBeam;
		mask_index  	= global.mskLaserTrapBeam;
		spr_tail    	= global.sprLaserTrapBeamStart;
		spr_head    	= global.sprLaserTrapHead;
		image_speed		= 0;
		
		// Vars:
    	direction		= _direction;
    	creator 		= other;
    	team			= 1;
    	typ 			= 0;
    	offset			= _offset;
    	length			= _length
       
		// Functions:
    	on_step			= LaserTurretBeam_step;
		on_hit  		= LaserTurretBeam_hit;
    	on_wall 		= nothing;
		on_draw 		= LaserTurretBeam_draw;
	
		var scanLength	= binary_search(script_ref_create(check_laser_style), length);
    	x				= xstart + lengthdir_x(scanLength, image_angle);
    	y				= ystart + lengthdir_y(scanLength, image_angle);
    	image_xscale	= scanLength / 2;
    	xprevious		= x
    	yprevious		= y

	}

#define LaserTurretBeam_step

	if(instance_exists(creator)){
		if(creator.active = false){
			instance_destroy();
			exit;
		}

    		// Direction:
    	direction		= creator.shootAngle + offset;
    	image_angle		= direction;
		var _scanLength	= binary_search(script_ref_create(check_laser_style), length);
    	x				= xstart + lengthdir_x(_scanLength, image_angle);
    	y				= ystart + lengthdir_y(_scanLength, image_angle);
    	image_xscale	= _scanLength / 2;
    	xprevious		= x
    	yprevious		= y
    	
    		// Particles:
    	if(random(15) < 1){
    	var _r = random_range(0, image_xscale * 2 + 12)
        	with instance_create(x - lengthdir_x(_r, direction) + random_range(-5, 5), y - lengthdir_y(_r, direction) + random_range(-5, 5), BulletHit) {
        		sprite_index	= global.sprLaserTrapBeamEnd
        		image_angle 	= other.direction
				image_speed 	= 0.4;
        		motion_set(other.direction,choose(1, 2))
        	}
    	}
    		// Flooby Beam:
    	image_yscale = 1 * random_range(0.8, 1.1)
    
	}
	else instance_destroy()   
	
#define binary_search(checkScript, searchLength)
    var length = searchLength,
        lenDiff = searchLength;
    
    //First check, if missed, exit early.
    if (script_ref_call(checkScript, length)) {
        lenDiff /= 2;
        length -= lenDiff;
    }
    else {
        return searchLength;
    }
    
    while (lenDiff > 1) {
        lenDiff /= 2;
        //Hit something, reduce length
        if (script_ref_call(checkScript, length)) {
            length -= lenDiff;
        }
        //Miss, increase length
        else {
            length += lenDiff;
        }
    }
    return length;
    
//The script called by binary_search
#define check_laser_style(length)
    //Remember, the scope is already the laser since this is in its step event
    x = xstart + lengthdir_x(length, image_angle);
    y = ystart + lengthdir_y(length, image_angle);
    image_xscale = length / 2;
    //We don't have to reset coordinates or scale because it gets reset anyhow.
    return place_meeting(x, y, Wall);  //|| place_meeting(x, y, enemy) ||; this pierces things so just dont have this part - plus it should prob be HitMe or Player or something

#define LaserTurretBeam_hit
	var _team = team,
	    _ang  = direction
	with(other){
		if("fr_trapImmune" not in self){
			if nexthurt <= current_frame{
				projectile_hit(self,other.damage)
				lasthit = [global.sprLaserTurretGameover, "LASER TURRET"];
			}
		}
	}
	
#define LaserTurretBeam_draw
	draw_sprite_ext(sprite_index, image_index, xstart, ystart, image_xscale, image_yscale, image_angle, image_blend, 1.0);
//	if x != xstart draw_sprite_ext(spr_tail, 1, xstart, ystart, 1, image_yscale, image_angle, image_blend, 1.0);
	if x != xstart draw_sprite_ext(spr_head, 0, x, y, image_yscale * 2, image_yscale * 2, image_angle - 45, image_blend, 1.0);

	// BLOOM:
	draw_sprite_ext(sprite_index, image_index, xstart, ystart, image_xscale, image_yscale*1.7, image_angle, image_blend, 0.2);
//	if x != xstart draw_sprite_ext(spr_tail, 1, xstart, ystart, 1, image_yscale*1.5, image_angle, image_blend, 0.2); 
	if x != xstart draw_sprite_ext(spr_head, 0, x, y, image_yscale * 2.7, image_yscale * 2.7, image_angle - 45, image_blend, 0.2); 

#define LaserTurretSourceTop_create(_x, _y)
	with(instance_create(_x, _y, CustomObject)){
		name	= "fr_LaserTurretSource";
		
		fr_coreDetoKill	= true;
		sprite_index	= global.sprLaserTurretSourceTop;
		depth			= -1;
		fr_bloom		= [1.6, 0.1];
		
		on_step 		= LaserTurretSource_step;
		
		return self;
	}
	
#define LaserTurretSource_create(_x, _y)
	with(instance_create(_x, _y, CustomObject)){
		name	= "fr_LaserTurretSource";
		
		fr_coreDetoKill	= true;
		sprite_index	= global.sprLaserTurretSource;
		depth			= 4;
		fr_bloom		= [1.6, 0.1];
		
		on_step 		= LaserTurretSource_step;
		
		return self;
	}
	
#define LaserTurretSource_step
	image_xscale	= 1 + random_range(-0.1, 0.1);
	image_yscale	= image_xscale;
	
	
#define EnemySpawnTube_create(_x, _y, _barrier, _activateBarrier, _spawnHitbox, _delay, _enemy)
	with(instance_create(_x, _y, CustomObject)){
		name = "fr_DeeplabsEnemySpawnTube"
		
		spr_idle		= global.sprEnemyElevatorIdle;
		spr_active		= global.sprEnemyElevatorActive;
		spr_done		= global.sprEnemyElevatorDone;
		sprite_index	= spr_idle;
		image_index		= 0;
		depth			= 5;
		image_speed 	= 0.8;
		enemyMod		= _enemy[0];
		enemyScript		= _enemy[1];
		enemyCount		= _enemy[2];
		myBarrier		= _barrier;
		activateDis		= 192;
		active			= false;
		spawned 		= false;
		imDone			= false;
		activateDelay	= _delay;
		spriteProcced	= false;
		activateBarrier = _activateBarrier;
		spawnHitbox		= _spawnHitbox;
		fr_coreDetoKill	= true;
		
		on_step 		= EnemySpawnTube_step;

		return self;
	}
	
#define EnemySpawnTube_step
	if(imDone = false){
		if(active = true){
			if(activateDelay > 0){
				activateDelay -= current_time_scale;
			} else {
				if(spriteProcced = false){
					spriteProcced	= true;
					sprite_index	= spr_active;
					sound_play_pitchvol(sndToxicBoltGas, 1.3 + random(0.2), 0.8);
				}
				if(image_index >= 13 && spawned = false){
					spawned = true;
					sound_play_pitchvol(sndCursedReminder, 3, 2);
					
					repeat(enemyCount * (1 + (GameCont.loops * 0.7) + (crown_current = crwn_blood || skill_get("BurdenBlood") * 0.3))){
						switch(enemyMod){
							case "Basegame":
								with(instance_create(x, y + 12, enemyScript)){
									fr_myBarrier = other.myBarrier;
									image_alpha		= 0;
									script_bind_draw(EnemyFade_draw, (other.depth - 1), self)
								}							
							break;
					
							default:
								with(mod_script_call("mod", enemyMod, enemyScript, x, y + 12)){
									fr_myBarrier = other.myBarrier;
									image_alpha		= 0;
									script_bind_draw(EnemyFade_draw, (other.depth - 1), self);
									alarm1			*= 0.12;
								}
							break;
						}
					}
					if(myBarrier != null && activateBarrier = true){
						if(myBarrier.enemyMode = false){
							myBarrier.enemyMode = true;
						}
					}
				}
				if(sprite_index	= spr_active && anim_end){
					sprite_index	= spr_done;
					imDone			= true;
				}				
			}
		}
	}
	
#define BecomeTurret_create(_x, _y, _spawnHitbox, _delay, _barrier)
	with(instance_create(_x, _y, CustomObject)){
		name = "fr_DeeplabsBecomeTurret"
		
		myBarrier		= _barrier;
		active			= false;
		activateDelay	= _delay;
		spawnHitbox		= _spawnHitbox;
		
		on_step 		= BecomeTurret_step;

		return self;		
	}
	
#define BecomeTurret_step
	if(active = true){
		if(activateDelay > 0){
			activateDelay -= current_time_scale;			
		} else {
			with(instance_create(x, y, Turret)){
				x			= other.x;
				y			= other.y;
				fr_myBarrier = other.myBarrier;
				alarm1		= 20;
			}
			instance_destroy();
		}
	}
	
#define DeeplabsWall_create(_x, _y)
	with(instance_create(_x, _y, Wall)){
		fr_deeplabsWall = true;
		
		return self;
	}
	
#define ExploEffect_create(_x, _y)
	with(instance_create(_x, _y, CustomObject)){
		spr_explo	= global.sprSolidColorFog;
		explo_alpha	= 0;
		fadeOut		= false;
		depth		= -15;
		
		exploColor	= global.settingDarkCoreExplosion = true ? c_black : c_white;
		
		on_step 	= ExploEffect_step;
		on_draw 	= ExploEffect_draw;
		
		return self;
	}

#define ExploEffect_step
	if(fadeOut = false){
		if(explo_alpha < 2.5){
			explo_alpha += 0.1 * current_time_scale;
		} else {
			fadeOut = true;
		}
	} else {
		if(instance_exists(Player)){
			if(explo_alpha > 0){
				explo_alpha -= 0.025 * current_time_scale;
			} else {
				instance_destroy();
			}
		}
	}
	
#define ExploEffect_draw
	draw_sprite_tiled_ext(spr_explo, 0, view_xview_nonsync + game_width / 2 ,view_yview_nonsync + game_height / 2, 10, 10, exploColor, explo_alpha)
	
#define BarrierEnemyIcon_draw
	with(instances_matching_ne(enemy, "fr_myBarrier", null)){
		draw_sprite(global.sprBarrierIcon, 0, x, y - (sprite_height / 2) - 2);
	}
	
#define EnemyFade_draw(_target)

	if(!instance_exists(_target)){
		instance_destroy();
		exit;
	}
	
	with(_target){
		image_alpha += (0.1 * current_time_scale)
	}
	
	if(_target.image_alpha >= 1){
		instance_destroy();
	}
	
#define DeeplabsRoomNametag_create(_x, _y, _name)
	with(instance_create(_x, _y, CustomObject)){
		roomName = _name;
		
		on_draw = DeeplabsRoomNametag_draw
		
		return self;
	}
	
#define DeeplabsRoomNametag_draw
	draw_text_nt(x, y, roomName);
	
#define BecomeChest_create(_x, _y, _chest)
	with(instance_create(_x, _y, CustomObject)){
		name	= "fr_deeplabsBecomeChest"
		myChest = _chest;
		
		return self;
	}
	
#define SmokeGeyser_create(_x, _y)
	with(instance_create(_x, _y, CustomObject)){
		smokeCount	= 0.3 + random(0.13);
		
		on_step 	= SmokeGeyser_step;
		
		return self;
	}
	
#define SmokeGeyser_step
	if(current_frame_active){
		if(random(3) < 1){
			with(instance_create(x, y, Dust)){
				sprite_index	= global.sprCharSmoke;
				direction		= 90;
				speed			= other.smokeCount * 4; 
				depth			= -7; 
				friction		= -0.4;
				depth			= -12;
				growspeed		= clamp(other.smokeCount, 0, 0.25);
				fr_fadesmoke	= true;
			}
		}
	}
	if(smokeCount > 0.02){
		smokeCount -= 0.0005 * current_time_scale;
	} else {
		instance_destroy();
	}
	
#define SmokeFader_create(_x, _y)
	with(instance_create(_x, _y, CustomObject)){

		on_step 	= SmokeFader_step;
		
		return self;
	}
	
#define SmokeFader_step
	with(instances_matching(Dust, "fr_fadesmoke", true)){
		image_alpha	-= 0.05;
	}
	
#define PanelSoundController_create(_x, _y)
	with(instance_create(_x, _y, CustomObject)){
		name = "fr_PanelSoundController"
		
		 // Visual:
		sprite_index	= mskNone;
		
		global.panelSound = sound_loop(global.sndDeeplabsCoreControls);
        sound_volume(global.panelSound, 0);
        
        nearestX		= x;
        nearestY		= y;
        
        soundRange			= 232;
        dangerSoundRange	= 420;
		
		 // Go Go Go:
		on_step 		= PanelSoundController_step;
		
		return self;
	}
	
#define PanelSoundController_step
	if(!instance_exists(Player) || distance_to_object(Player) > 1000){
		sound_stop(global.panelSound);
		instance_destroy();
		exit;
	}
	var _nearest	= instance_nearest(x, y, Player);
	if(instance_exists(_nearest)){
		nearestX		= _nearest.x;
		nearestY		= _nearest.y;
		var	_dis			= distance_to_point(nearestX, nearestY),
			_panelVol		= (soundRange - _dis) / soundRange;
			
		sound_volume(global.panelSound, clamp(_panelVol, 0, 1));
	}

	
#define Prop_hurt(_dmg, _spd, _dir)
	my_health -= _dmg;
	nexthurt   = current_frame + 6;
	
	sound_play_hit(snd_hurt, 0.3);
	
	sprite_index = spr_hurt;
	image_index  = 0;

#define nothing

#define array_delete // array, index, count=1
	/*
		Returns a new array with the value(s) at the given index removed
		
		Args:
			array - The array to copy and delete from
			index - The position of the first value to remove 
			count - The number of values to remove after the index, defaults to 1
			
		Ex:
			array_delete([1, 2, 3], 1)    == [1, 3]
			array_delete([1, 2, 3], 0, 2) == [3]
	*/
	
	var	_array = argument[0],
		_index = argument[1],
		_count = ((argument_count > 2) ? argument[2] : 1),
		_clone = array_slice(_array, 0, _index);
		
	array_copy(_clone, array_length(_clone), _array, _index + _count, array_length(_array) - (_index + _count));
	
	return _clone;

#macro current_frame_active 																	frac(current_frame) < current_time_scale
#macro  anim_end                                                                                ((image_index + image_speed_raw) >= image_number || (image_index + image_speed_raw) < 0)
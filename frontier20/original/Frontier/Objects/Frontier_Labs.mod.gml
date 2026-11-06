#define init

	 // LIB:
	while(!mod_exists("mod", "lib")){wait(1);}
	script_ref_call(["mod", "lib", "getRef"], "mod", mod_current, "scr");
	#macro  scr			global.scr
	#macro  call		script_ref_call
	
	
		// SETTINGS //
	global.settingBlaacTank					= false; // this is for making possessed goldtanks use sprites that support blaac's resprite, not in settings menu.
	
	    // SOUNDS //
	global.sndCrematorHurt					= sound_add("../sounds/enemies/graveyard/sndCrematorHurt.ogg");    
	global.sndCrematorDead					= sound_add("../sounds/enemies/graveyard/sndCrematorDead.ogg");    
	global.sndCoreapheeHurt					= sound_add("../sounds/enemies/graveyard/sndCoreapheeHurt.ogg");    
	global.sndCoreapheeDead					= sound_add("../sounds/enemies/graveyard/sndCoreapheeDead.ogg");    
	global.sndDatadriverHurt				= sound_add("../sounds/enemies/graveyard/sndDatadriverHurt.ogg");    
	global.sndDatadriverDead				= sound_add("../sounds/enemies/graveyard/sndDatadriverDead.ogg");   
	global.sndDatadriverDig					= sound_add("../sounds/enemies/graveyard/sndDatadriverDig.ogg");   
	global.sndDatadriverReplace				= sound_add("../sounds/enemies/graveyard/sndDatadriverReplace.ogg");   
	global.sndRammrHurt						= sound_add("../sounds/enemies/graveyard/sndRammrHurt.ogg");    
	global.sndRammrDead						= sound_add("../sounds/enemies/graveyard/sndRammrDead.ogg");  
	global.sndRammrRam						= sound_add("../sounds/enemies/graveyard/sndRammrRam.ogg");  
	global.sndVoltergeistHurt				= sound_add("../sounds/enemies/graveyard/sndVoltergeistHurt.ogg");    
	global.sndVoltergeistDead				= sound_add("../sounds/enemies/graveyard/sndVoltergeistDead.ogg");   	
	global.sndVoltergeistFly				= sound_add("../sounds/enemies/graveyard/sndVoltergeistFly.ogg");   	
	global.sndVoltergeistPossess			= sound_add("../sounds/enemies/graveyard/sndVoltergeistPossess.ogg");   
	
	global.sndSwarmerHurt					= sound_add("../sounds/enemies/robocenter/sndSwarmerHurt.ogg");    
	global.sndSwarmerDead					= sound_add("../sounds/enemies/robocenter/sndSwarmerDead.ogg");    
	global.sndSwarmerCharge					= sound_add("../sounds/enemies/robocenter/sndSwarmerCharge.ogg");    
	global.sndSwarmerCharge2				= sound_add("../sounds/enemies/robocenter/sndSwarmerCharge2.ogg");    
	global.sndSwarmerCharge3				= sound_add("../sounds/enemies/robocenter/sndSwarmerCharge3.ogg");    
	global.sndBombardierHurt				= sound_add("../sounds/enemies/robocenter/sndBombardierHurt.ogg");    
	global.sndBombardierDead				= sound_add("../sounds/enemies/robocenter/sndBombardierDead.ogg");  
	global.sndBombardierFire				= sound_add("../sounds/enemies/robocenter/sndBombardierFire.ogg");  

	global.sndSmartIdle	=[					sound_add("../sounds/enemies/Smart/sndSmartIdle.ogg"),
											sound_add("../sounds/enemies/Smart/sndSmartIdle2.ogg"),
											sound_add("../sounds/enemies/Smart/sndSmartIdle3.ogg"),
											sound_add("../sounds/enemies/Smart/sndSmartIdle4.ogg"),
											sound_add("../sounds/enemies/Smart/sndSmartIdle5.ogg"),
											sound_add("../sounds/enemies/Smart/sndSmartIdle6.ogg")];
	global.sndSmartHurt	=[					sound_add("../sounds/enemies/Smart/sndSmartHurt.ogg"),
											sound_add("../sounds/enemies/Smart/sndSmartHurt2.ogg"),
											sound_add("../sounds/enemies/Smart/sndSmartHurt3.ogg"),
											sound_add("../sounds/enemies/Smart/sndSmartHurt4.ogg"),
											sound_add("../sounds/enemies/Smart/sndSmartHurt5.ogg"),
											sound_add("../sounds/enemies/Smart/sndSmartHurt6.ogg"),
											sound_add("../sounds/enemies/Smart/sndSmartHurt7.ogg"),
											sound_add("../sounds/enemies/Smart/sndSmartHurt8.ogg")];
	global.sndSmartLeave					= sound_add("../sounds/enemies/Smart/sndSmartLeave.ogg");	
	global.sndSmartDead						= sound_add("../sounds/enemies/Smart/sndSmartDead.ogg");
	 
	    // SPRITES //
	
	 // Labs Route Entrance:
	global.sprLabsEntrance				    = sprite_add("../sprites/areas/labs/sprLabsEntrance.png",                       1, 48, 18);
	global.sprLabsEntranceUnlocked		    = sprite_add("../sprites/areas/labs/sprLabsEntranceUnlocked.png",               1, 48, 18);
	global.sprLabsEntranceOpening		    = sprite_add("../sprites/areas/labs/sprLabsEntranceOpening.png",                4, 48, 18);
	global.sprLabsEntranceOpen			    = sprite_add("../sprites/areas/labs/sprLabsEntranceOpen.png",                   1, 48, 18);
	
	 // Security Trap:	
	/*
	global.sprSecurityTrap				    = sprite_add("sprites/areas/labs/sprSecurityTrap.png", 1, 16, 16);
	global.sprSecurityTrapTop			    = sprite_add("sprites/areas/labs/sprSecurityTrapTop.png", 1, 16, 16);
	global.sprSecurityTrapHurt			    = sprite_add("sprites/areas/labs/sprSecurityTrapHurt.png", 3, 16, 16);
	global.sprSecurityTrapDead			    = sprite_add("sprites/areas/labs/sprSecurityTrapDead.png", 3, 16, 16);
	global.sprSecurityTrapOpening		    = sprite_add("sprites/areas/labs/sprSecurityTrapOpening.png", 4, 16, 16);
	global.sprSecurityTrapOpen			    = sprite_add("sprites/areas/labs/sprSecurityTrapOpen.png", 1, 16, 16);
	global.sprSecurityTrapOpenHurt		    = sprite_add("sprites/areas/labs/sprSecurityTrapOpenHurt.png", 3, 16, 16);
	global.mskSecurityTrapScan			    = sprite_add("sprites/areas/labs/mskSecurityTrapScan.png", 1, 48, 48);
	global.sprSecurityTrapScan			    = sprite_add("sprites/areas/labs/sprSecurityTrapScan.png", 1, 48, 48);
	*/
		
	 // Electricity Trap:
	global.sprBallTrap					    = sprite_add("../sprites/areas/labs/sprBallTrap.png",                           4, 16, 16);
	global.sprBallTrapHurt				    = sprite_add("../sprites/areas/labs/sprBallTrapHurt.png",                       3, 16, 16);
	global.sprBallTrapDead				    = sprite_add("../sprites/areas/labs/sprBallTrapDead.png",                       3, 16, 16);
	global.sprBallTrapOff				    = sprite_add("../sprites/areas/labs/sprBallTrapOff.png",                        1, 16, 16);
	global.shdBallTrap					    = sprite_add("../sprites/areas/labs/shdBallTrap.png",                           1, 12, 12);
	global.mskBallTrapBall				    = sprite_add("../sprites/projectiles/mskBallTrapBall.png",                      1, 16, 16);
	global.sprBallTrapBall				    = sprite_add("../sprites/projectiles/sprBallTrapBall.png",                      4, 16, 16);
	global.sprBallTrapBallDisappear		    = sprite_add("../sprites/projectiles/sprBallTrapBallDisappear.png",             5, 16, 16);
	global.sprBallTrapBallTrail			    = sprite_add("../sprites/particles/sprBallTrapBallTrail.png",                   3, 4, 4);

	 // smartest boy in the whole wide world:
	global.sprNecromancerSmartIdle			= sprite_add("../sprites/enemies/NecromancerSmart/sprNecromancerSmartIdle.png",	4, 16, 16);	
	global.sprNecromancerSmartWalk			= sprite_add("../sprites/enemies/NecromancerSmart/sprNecromancerSmartWalk.png",	6, 16, 16);	
	global.sprNecromancerSmartHurt			= sprite_add("../sprites/enemies/NecromancerSmart/sprNecromancerSmartHurt.png",	3, 16, 16);	
	
	 // Voltergeist Sprites:
	global.sprVoltergeistIdle				= sprite_add("../sprites/enemies/voltergeist/sprVoltergeistIdle.png",			6, 8, 16);	 
	global.sprVoltergeistFly				= sprite_add("../sprites/enemies/voltergeist/sprVoltergeistFly.png",			2, 8, 16);
	global.sprVoltergeistHurt				= sprite_add("../sprites/enemies/voltergeist/sprVoltergeistHurt.png",			3, 8, 16);
	global.sprVoltergeistDead				= sprite_add("../sprites/enemies/voltergeist/sprVoltergeistDead.png",			9, 16, 16);
	
	 // Cremator:
	global.shdCremator			    		= sprite_add("../sprites/enemies/cremator/shdCremator.png",                     1, 12, 12);
	global.mskCremator		    			= sprite_add("../sprites/enemies/cremator/mskCremator.png",                 	1, 16, 11);
	global.sprCrematorIdle		    		= sprite_add("../sprites/enemies/cremator/sprCrematorIdle.png",                 16, 16, 11);
	global.sprCrematorWalk			    	= sprite_add("../sprites/enemies/cremator/sprCrematorWalk.png",                 6, 16, 11);
	global.sprCrematorHurt			    	= sprite_add("../sprites/enemies/cremator/sprCrematorHurt.png",                 3, 16, 11);
	global.sprCrematorDead				    = sprite_add("../sprites/enemies/cremator/sprCrematorDead.png",                 6, 16, 11);	
	global.sprCrematorFire				    = sprite_add("../sprites/enemies/cremator/sprCrematorFire.png",                 4, 16, 11);
	global.sprCrematorPossessedIdle	    	= sprite_add("../sprites/enemies/cremator/sprCrematorPossessedIdle.png",        16, 16, 11);
	global.sprCrematorPossessedWalk		    = sprite_add("../sprites/enemies/cremator/sprCrematorPossessedWalk.png",        6, 16, 11);
	global.sprCrematorPossessedFire	    	= sprite_add("../sprites/enemies/cremator/sprCrematorPossessedFire.png",        4, 16, 11);	
	
	 // Mortar Vessel:
	global.mskVesselMortar					= sprite_add("../sprites/enemies/vesselmortar/mskVesselMortar.png",         	1, 24, 24);	
	global.mskVesselMortarLoaded			= sprite_add("../sprites/enemies/vesselmortar/mskVesselMortarLoaded.png",       1, 24, 24);	
	global.sprVesselMortarIdle		    	= sprite_add("../sprites/enemies/vesselmortar/sprVesselMortarIdle.png",         8, 24, 24);	
	global.sprVesselMortarWalk		    	= sprite_add("../sprites/enemies/vesselmortar/sprVesselMortarWalk.png",         6, 24, 24);	
	global.sprVesselMortarHurt		    	= sprite_add("../sprites/enemies/vesselmortar/sprVesselMortarHurt.png",         3, 24, 24);	
	global.sprVesselMortarDead		    	= sprite_add("../sprites/enemies/vesselmortar/sprVesselMortarDead.png",         6, 24, 24);	
	global.sprVesselMortarReload		    = sprite_add("../sprites/enemies/vesselmortar/sprVesselMortarReload.png",       12, 24, 24);	
	global.sprVesselMortarLoadedIdle		= sprite_add("../sprites/enemies/vesselmortar/sprVesselMortarLoadedIdle.png",   8, 24, 24);	
	global.sprVesselMortarLoadedWalk		= sprite_add("../sprites/enemies/vesselmortar/sprVesselMortarLoadedWalk.png",   6, 24, 24);	
	global.sprVesselMortarLoadedHurt		= sprite_add("../sprites/enemies/vesselmortar/sprVesselMortarLoadedHurt.png",   3, 24, 24);	
	global.sprVesselMortarLoadedDead		= sprite_add("../sprites/enemies/vesselmortar/sprVesselMortarLoadedDead.png",   6, 24, 24);	
/*
	global.mskVesselMortar		    		= sprite_add("../sprites/enemies/vesselmortar/mskVesselMortar.png",         	1, 24, 24);	
	global.mskVesselMortarGrounded		    = sprite_add("../sprites/enemies/vesselmortar/mskVesselMortarGrounded.png",     1, 24, 24);	
	global.sprVesselMortarIdle		    	= sprite_add("../sprites/enemies/vesselmortar/sprVesselMortarIdle.png",         4, 24, 24);	
	global.sprVesselMortarWalk		    	= sprite_add("../sprites/enemies/vesselmortar/sprVesselMortarWalk.png",         8, 24, 24);	
	global.sprVesselMortarHurt		    	= sprite_add("../sprites/enemies/vesselmortar/sprVesselMortarHurt.png",         3, 24, 24);	
	global.sprVesselMortarDead		    	= sprite_add("../sprites/enemies/vesselmortar/sprVesselMortarDead.png",         6, 24, 24);	
	global.sprVesselMortarStartGround		= sprite_add("../sprites/enemies/vesselmortar/sprVesselMortarStartGround.png",	11, 24, 24);
	global.sprVesselMortarEndGround			= sprite_add("../sprites/enemies/vesselmortar/sprVesselMortarEndGround.png",	8, 24, 24);		
	global.sprVesselMortarGroundedIdle		= sprite_add("../sprites/enemies/vesselmortar/sprVesselMortarGroundedIdle.png", 1, 24, 24);	
	global.sprVesselMortarGroundedHurt		= sprite_add("../sprites/enemies/vesselmortar/sprVesselMortarGroundedHurt.png", 3, 24, 24);		
	global.sprVesselMortarGroundedDead		= sprite_add("../sprites/enemies/vesselmortar/sprVesselMortarGroundedDead.png", 6, 24, 24);		
	global.sprVesselMortarFire		    	= sprite_add("../sprites/enemies/vesselmortar/sprVesselMortarFire.png",         10, 24, 24);	
*/

	 // Orbiter Vessel:
	global.mskVesselOrbiter					= sprite_add("../sprites/enemies/vesselorbiter/mskVesselOrbiter.png",       	1, 24, 24);	
	global.sprVesselOrbiterIdle				= sprite_add("../sprites/enemies/vesselorbiter/sprVesselOrbiterIdle.png",       8, 24, 24);	
	global.sprVesselOrbiterHurt				= sprite_add("../sprites/enemies/vesselorbiter/sprVesselOrbiterHurt.png",       3, 24, 24);	
	global.sprVesselOrbiterDead				= sprite_add("../sprites/enemies/vesselorbiter/sprVesselOrbiterDead.png",       6, 24, 24);	
	
	 // Charger Vessel:
	global.sprVesselChargerIdle				= sprite_add("../sprites/enemies/vesselcharger/sprVesselChargerIdle.png",       6, 16, 16);	
	global.sprVesselChargerWalk				= sprite_add("../sprites/enemies/vesselcharger/sprVesselChargerWalk.png",       6, 16, 16);	
	global.sprVesselChargerHurt				= sprite_add("../sprites/enemies/vesselcharger/sprVesselChargerHurt.png",       3, 16, 16);	
	global.sprVesselChargerDead				= sprite_add("../sprites/enemies/vesselcharger/sprVesselChargerDead.png",       6, 16, 16);	
	global.sprVesselChargerTell				= sprite_add("../sprites/enemies/vesselcharger/sprVesselChargerTell.png",       1, 16, 16);	
	global.sprVesselChargerChrg				= sprite_add("../sprites/enemies/vesselcharger/sprVesselChargerChrg.png",       3, 16, 16);	
	
	 // Possessed Enemies:
	global.sprSnowTankPossessedIdle			= sprite_add("../sprites/enemies/possessed/sprSnowTankPossessedIdle.png",		4, 24, 24);	
	global.sprSnowTankPossessedWalk			= sprite_add("../sprites/enemies/possessed/sprSnowTankPossessedWalk.png",		8, 24, 24);
	global.sprGoldTankPossessedIdle			= sprite_add("../sprites/enemies/possessed/sprGoldTankPossessedIdle.png",		4, 24, 24);	
	global.sprGoldTankPossessedWalk			= sprite_add("../sprites/enemies/possessed/sprGoldTankPossessedWalk.png",		8, 24, 24);	
	global.sprBlaacGoldTankPossessedIdle	= sprite_add("../sprites/enemies/possessed/sprBlaacGoldTankPossessedIdle.png",	4, 24, 24);	
	global.sprBlaacGoldTankPossessedWalk	= sprite_add("../sprites/enemies/possessed/sprBlaacGoldTankPossessedWalk.png",	8, 24, 24);		
	global.sprTurretPossessedIdle			= sprite_add("../sprites/enemies/possessed/sprTurretPossessedIdle.png",			1, 12, 12);	
	global.sprTurretPossessedHurt			= sprite_add("../sprites/enemies/possessed/sprTurretPossessedHurt.png",			3, 12, 12);
	global.sprTurretPossessedFire			= sprite_add("../sprites/enemies/possessed/sprTurretPossessedFire.png",			3, 12, 12);
	global.sprSniperPossessedIdle	    	= sprite_add("../sprites/enemies/possessed/sprSniperPossessedIdle.png",     	4, 12, 12);
	global.sprSniperPossessedWalk		    = sprite_add("../sprites/enemies/possessed/sprSniperPossessedWalk.png",     	6, 12, 12);
	global.sprWolfPossessedIdle	    		= sprite_add("../sprites/enemies/possessed/sprWolfPossessedIdle.png",       	11, 24, 24);
	global.sprWolfPossessedWalk	    		= sprite_add("../sprites/enemies/possessed/sprWolfPossessedWalk.png",       	6, 24, 24);
	global.sprWolfPossessedFire	    		= sprite_add("../sprites/enemies/possessed/sprWolfPossessedFire.png",       	12, 24, 24);
	global.sprSnowBotPossessedIdle	    	= sprite_add("../sprites/enemies/possessed/sprSnowBotPossessedIdle.png",    	6, 24, 24);
	global.sprSnowBotPossessedWalk	    	= sprite_add("../sprites/enemies/possessed/sprSnowBotPossessedWalk.png",    	6, 24, 24);
	global.sprSnowBotPossessedFire	    	= sprite_add("../sprites/enemies/possessed/sprSnowBotPossessedFire.png",    	3, 24, 24);
	/*
	global.sprSnowBotPossessedCarLift	    	= sprite_add("../sprites/enemies/snowbotpossessed/sprSnowBotPossessedCarLift.png",     4, 32, 32);	
	global.sprSnowBotPossessedCarIdle	    	= sprite_add("../sprites/enemies/snowbotpossessed/sprSnowBotPossessedCarIdle.png",     6, 32, 32);	
	global.sprSnowBotPossessedCarWalk	    	= sprite_add("../sprites/enemies/snowbotpossessed/sprSnowBotPossessedCarWalk.png",     8, 32, 32);	
	global.sprSnowBotPossessedCarThrow	    	= sprite_add("../sprites/enemies/snowbotpossessed/sprSnowBotPossessedCarThrow.png",    5, 32, 32);	
	global.sprSnowBotPossessedRedCarLift	    = sprite_add("../sprites/enemies/snowbotpossessed/sprSnowBotPossessedRedCarLift.png",     4, 32, 32);	
	global.sprSnowBotPossessedRedCarIdle	    = sprite_add("../sprites/enemies/snowbotpossessed/sprSnowBotPossessedRedCarIdle.png",     6, 32, 32);	
	global.sprSnowBotPossessedRedCarWalk	    = sprite_add("../sprites/enemies/snowbotpossessed/sprSnowBotPossessedRedCarWalk.png",     8, 32, 32);	
	global.sprSnowBotPossessedRedCarThrow	    = sprite_add("../sprites/enemies/snowbotpossessed/sprSnowBotPossessedRedCarThrow.png",    5, 32, 32);	
	*/
	
	 // Graveyard Assassin:
	global.sprSnowAssassinIdle				= sprite_add("../sprites/enemies/snowassassin/sprSnowAssassinIdle.png",			6, 16, 16);	
	global.sprSnowAssassinWalk				= sprite_add("../sprites/enemies/snowassassin/sprSnowAssassinWalk.png",			6, 16, 16);	
	global.sprSnowAssassinHurt				= sprite_add("../sprites/enemies/snowassassin/sprSnowAssassinHurt.png",			3, 16, 16);	
	global.sprSnowAssassinDead				= sprite_add("../sprites/enemies/snowassassin/sprSnowAssassinDead.png",			7, 16, 16);	
	 // Swarmer:
	global.sprSwarmBotIdle					= sprite_add("../sprites/enemies/swarmbot/sprSwarmbotIdle.png",					5, 16, 16);
	global.sprSwarmBotWalk					= sprite_add("../sprites/enemies/swarmbot/sprSwarmbotWalk.png",					4, 16, 16);
	global.sprSwarmBotHurt					= sprite_add("../sprites/enemies/swarmbot/sprSwarmbotHurt.png",					3, 16, 16);
	global.sprSwarmBotDead					= sprite_add("../sprites/enemies/swarmbot/sprSwarmbotDead.png",					6, 16, 16);
	global.sprSwarmBotChrg					= sprite_add("../sprites/enemies/swarmbot/sprSwarmbotChrg.png",					3, 16, 16);
	global.sprSwarmBotFired 			    = sprite_add("../sprites/enemies/swarmbot/sprSwarmbotFired.png",                1, 9, 8);
	global.sprSwarmBotPossessedIdle			= sprite_add("../sprites/enemies/swarmbot/sprSwarmBotPossessedIdle.png",		5, 16, 16);
	global.sprSwarmBotPossessedWalk			= sprite_add("../sprites/enemies/swarmbot/sprSwarmBotPossessedWalk.png",		4, 16, 16);
	global.sprSwarmBotPossessedChrg			= sprite_add("../sprites/enemies/swarmbot/sprSwarmBotPossessedChrg.png",		3, 16, 16);
	
	 // Engineer:
	global.sprEngineerIdle					= sprite_add("../sprites/enemies/engineer/sprEngineerIdle.png",					4, 16, 20);
	global.sprEngineerWalk					= sprite_add("../sprites/enemies/engineer/sprEngineerWalk.png",					6, 16, 20);
	global.sprEngineerHurt					= sprite_add("../sprites/enemies/engineer/sprEngineerHurt.png",					3, 16, 20);
	global.sprEngineerDead					= sprite_add("../sprites/enemies/engineer/sprEngineerDead.png",					6, 16, 20);
	global.sprEngineerCannon				= sprite_add("../sprites/enemies/engineer/sprEngineerCannon.png",				1, 6, 0);
	global.sprEngineerWrench				= sprite_add("../sprites/enemies/engineer/sprEngineerWrench.png",				1, 6, 0);
	
	 // Bombardier:
	global.mskMissileDrone					= sprite_add("../sprites/enemies/missiledrone/mskMissileDrone.png",				1, 24, 16);
	global.shdMissileDrone					= sprite_add("../sprites/enemies/missiledrone/shdMissileDrone.png",				1, 24, 16);
	global.sprMissileDroneIdle				= sprite_add("../sprites/enemies/missiledrone/sprMissileDroneIdle.png",			8, 24, 16);
	global.sprMissileDroneWalk				= sprite_add("../sprites/enemies/missiledrone/sprMissileDroneWalk.png",			4, 24, 16);
	global.sprMissileDroneHurt				= sprite_add("../sprites/enemies/missiledrone/sprMissileDroneHurt.png",			3, 24, 16);
	global.sprMissileDroneDead				= sprite_add("../sprites/enemies/missiledrone/sprMissileDroneDead.png",			6, 24, 16);
	global.sprMissileDronePossessedIdle		= sprite_add("../sprites/enemies/missiledrone/sprMissileDronePossessedIdle.png",8, 24, 16);
	global.sprMissileDronePossessedWalk		= sprite_add("../sprites/enemies/missiledrone/sprMissileDronePossessedWalk.png",4, 24, 16);
	
	 // Freak Shells:
	global.sprFreakShellWarning				= sprite_add("../sprites/enemies/FreakShell/sprFreakShellWarning.png",			1, 26, 26);
	global.sprFreakShellFall				= sprite_add("../sprites/enemies/FreakShell/sprFreakShellFall.png", 			1, 16, 24);
	global.sprFreakShellIdle				= sprite_add("../sprites/enemies/FreakShell/sprFreakShellIdle.png", 			1, 16, 24);
	global.sprFreakShellHurt				= sprite_add("../sprites/enemies/FreakShell/sprFreakShellHurt.png", 			3, 16, 24);
	global.sprFreakShellOpening				= sprite_add("../sprites/enemies/FreakShell/sprFreakShellOpening.png",			3, 16, 24);
	global.sprFreakShellOpen				= sprite_add("../sprites/enemies/FreakShell/sprFreakShellOpen.png", 			1, 16, 24);
	global.sprFreakShellOpenHurt			= sprite_add("../sprites/enemies/FreakShell/sprFreakShellOpenHurt.png", 		3, 16, 24);
	global.mskRhinoFreakShell				= sprite_add("../sprites/enemies/FreakShell/mskRhinoFreakShell.png",			1, 32, 56);
	global.sprRhinoFreakShellWarning		= sprite_add("../sprites/enemies/FreakShell/sprRhinoFreakShellWarning.png", 	1, 35, 35);
	global.sprRhinoFreakShellFall			= sprite_add("../sprites/enemies/FreakShell/sprRhinoFreakShellFall.png",		1, 32, 56);
	global.sprRhinoFreakShellIdle			= sprite_add("../sprites/enemies/FreakShell/sprRhinoFreakShellIdle.png",		1, 32, 56);
	global.sprRhinoFreakShellHurt			= sprite_add("../sprites/enemies/FreakShell/sprRhinoFreakShellHurt.png",		3, 32, 56);
	global.sprRhinoFreakShellOpen			= sprite_add("../sprites/enemies/FreakShell/sprRhinoFreakShellOpen.png",		1, 32, 56);
	global.sprRhinoFreakShellOpenHurt		= sprite_add("../sprites/enemies/FreakShell/sprRhinoFreakShellOpenHurt.png",	3, 32, 56);
	global.sprRhinoFreakShellDoor			= sprite_add("../sprites/enemies/FreakShell/sprRhinoFreakShellDoor.png",		1, 32, 56);

	
	 // Projectiles / Effects:
	global.sprGenericTrail  			    = sprite_add("../sprites/particles/sprGenericTrail.png",                        50, 0, 50);
	global.sprWhiteSmoke				    = sprite_add("../sprites/particles/sprWhiteSmoke.png",                          5, 12, 12);
    global.sprEnemyStreak 	    		    = sprite_add("../sprites/particles/sprEnemyStreak.png",                         7, 8, 8);
    global.sprCrematorShell	    		    = sprite_add("../sprites/projectiles/sprCrematorShell.png",                     2, 8, 8);
    global.sprCrematorShellDisappear	    = sprite_add("../sprites/projectiles/sprCrematorShellDisappear.png",            5, 8, 8);
    global.sprCrematorShellChrg	    	    = sprite_add("../sprites/projectiles/sprCrematorShellCharged.png",              2, 8, 8);
    global.sprCrematorShellDisappearChrg    = sprite_add("../sprites/projectiles/sprCrematorShellChargedDisappear.png",     5, 8, 8);
	global.sprCreep  					    = sprite_add("../sprites/projectiles/sprCreep.png",                             3, 24, 24);
    global.sprFlameStreak 	    		    = sprite_add("../sprites/particles/sprFlameStreak.png",                         7, 8, 8);
    global.sprFlameCreepBubble 	    	    = sprite_add("../sprites/particles/sprFlameCreepBubble.png",                    6, 8, 8);
    global.sprFlameStreakCharged	        = sprite_add("../sprites/particles/sprFlameStreakCharged.png",                  7, 8, 8);
    global.sprFlameCreepBubbleCharged 	    = sprite_add("../sprites/particles/sprFlameCreepBubbleCharged.png",             6, 8, 8);
	global.sprGatorCreep  					= sprite_add("../sprites/projectiles/sprGatorCreep.png",                        3, 12, 12);
	global.mskLabsRocket				    = sprite_add("../sprites/projectiles/mskLabsRocket.png",                        1, 6, 4);
	global.sprLabsRocket				    = sprite_add("../sprites/projectiles/sprLabsRocket.png",                        1, 6, 4);
	global.sprLabsRocketFlame			    = sprite_add("../sprites/particles/sprLabsRocketFlame.png",                 	3, 15, 3);
	global.sprLabsRocketTrail			    = sprite_add("../sprites/particles/sprLabsRocketTrail.png",                 	3, 4, 4);
	global.sprLabsRocketExplosion		    = sprite_add("../sprites/projectiles/sprLabsRocketExplosion.png",               7, 12, 12);
	global.sprServerBundle					= sprite_add("../sprites/projectiles/sprServerBundle.png",                      1, 16, 16);
	global.sprServerBundleDebris			= sprite_add("../sprites/particles/sprJunkDebris3.png",               			4, 4, 4);
/*	global.sprLobbedJunk					= sprite_add("../sprites/projectiles/sprLobbedJunk.png",                        4, 16, 16);
	global.sprLobbedJunkDebris = [			sprite_add("../sprites/particles/sprLobbedJunkDebris.png",                		4, 4, 4),
											sprite_add("../sprites/particles/sprLobbedJunkDebris2.png",               		4, 4, 4),
											sprite_add("../sprites/particles/sprLobbedJunkDebris3.png",               		4, 4, 4),
											sprite_add("../sprites/particles/sprLobbedJunkDebris4.png",               		4, 4, 4)]
*/
	global.sprVoltergeistLightning	=[		sprite_add("../sprites/particles/sprVoltergeistLightning.png",               	5, 16, 16),
											sprite_add("../sprites/particles/sprVoltergeistLightning2.png",               	5, 16, 16),
											sprite_add("../sprites/particles/sprVoltergeistLightning3.png",               	5, 16, 16),
											sprite_add("../sprites/particles/sprVoltergeistLightning4.png",               	5, 16, 16),
											sprite_add("../sprites/particles/sprVoltergeistLightning5.png",               	5, 16, 16)];
	global.sprVoltergeistDust				= sprite_add("../sprites/particles/sprVoltergeistDust.png",                     5, 12, 12);		
	global.sprVoltergeistRevive				= sprite_add("../sprites/particles/sprVoltergeistRevive.png",                   8, 24, 40);		
	global.sprLobbedJunkWarning				= sprite_add("../sprites/projectiles/sprLobbedJunkWarning.png",                 1, 24, 24);
	global.sprOrbiterBullet					= sprite_add("../sprites/projectiles/sprOrbiterBullet.png",                 	1, 8, 8);
	global.sprOrbiterBulletTrail			= sprite_add("../sprites/particles/sprOrbiterBulletTrail.png",              	3, 4, 4);
    global.sprBlasterShell	    		    = sprite_add("../sprites/projectiles/sprBlasterShell.png",                  	2, 8, 8);
    global.sprBlasterShellDisappear	    	= sprite_add("../sprites/projectiles/sprBlasterShellDisappear.png",             6, 8, 8);
	global.sprLaserTrapBeamEnd  			= sprite_add("../sprites/particles/sprLaserTrapBeamEnd.png",					3, 5, 5);
	global.sprGibs							= sprite_add("../sprites/particles/sprGibs.png",								3, 5, 5);
	global.sprHoneypotHeal					= sprite_add("../sprites/particles/sprHoneypotHeal.png",						7, 8, 8);
	global.sprSwarmerEggDebris				= sprite_add("../sprites/particles/sprSwarmerEggDebris.png",					1, 9, 4);
	
//#region OBJECTS
#define LabsEntrance_create(_x, _y)
	with(instance_create(_x, _y, CustomObject)){
		name = "fr_LabsEntrance";
		
		 // Visuals:
		spr_idle		= global.sprLabsEntrance;
		spr_unlocked	= global.sprLabsEntranceUnlocked;
		spr_opening		= global.sprLabsEntranceOpening;
		spr_open		= global.sprLabsEntranceOpen;
		sprite_index	= spr_idle;
		image_speed 	= 0.4;
		depth			= 5;
		
		 // Vars:
		prompt			= noone;
		text			= "ENTER";
		pick			= -1;
		locked			= true;
		portalPusher	= noone;
		 
		 // Hello:
		on_step         = script_ref_create(LabsEntrance_step);
		
		return self;
	}
	
#define LabsEntrancePrompt_step
	 // Enter Area:
	if(pick != -1) and (open = false){
		
		with(GameCont){
			area = "graveyard";
			subarea = 0;
		}
		 // Portal!!
		with(instance_create(x, y, Portal)){
			image_alpha 	= 0;
		}
		with(creator.portalPusher){
			instance_destroy();
		}
		
		 // Opening:
		creator.sprite_index = creator.spr_opening;
		
		open = true;
		fr_glow = [48, 64];
		
	}
	
#define LabsEntrance_step
	x = xstart;
	y = ystart;
	speed = 0;

	if(locked = true && instance_exists(Portal)){
		locked			= false;
		sprite_index	= spr_unlocked;
		
		 // Hydraulics:
		repeat(10){
			with(instance_create(x, y + random_range(-8, 8), Dust)){
				sprite_index	= global.sprWhiteSmoke;
				direction		= choose(90, 270)
				speed			= 3;
			}
		}
		sound_play_pitch(sndToxicBoltGas, 0.75 + random(0.1));
		
			// Prompt:
		with(call(scr.prompt_create, text)){ 
			on_step = LabsEntrancePrompt_step;
			creator = other;
			open	= false;
		}
	}
	if (sprite_index = spr_opening) && (anim_end){
		sprite_index = spr_open;
	}
	
	var _yuck = call(scr.instances_meeting, x, y, Corpse);
	with(_yuck){
		if(place_meeting(x, y, other)){ 
			motion_add(point_direction(other.x, other.y, x, y) + random_range(-30, 30), 0.7) 
		}
	}

#define BallTrap_create(_x, _y)
	with(instance_create(_x, _y, CustomHitme)){
		
		name				= "fr_ElectricityTrap"
		
		 // Visuals:	
		spr_idle			= global.sprBallTrap;
		spr_hurt			= global.sprBallTrapHurt;
		spr_dead			= global.sprBallTrapDead;
		spr_off				= global.sprBallTrapOff;
		sprite_index		= spr_idle;
		image_speed			= 0.4;
		depth				= -1;
		hitid				= [spr_idle, "ELECTRIC TRAP"];
		spr_shadow			= global.shdBallTrap;
		spr_shadow_y		= 4;
		
		 // Sounds:
		snd_hurt			= sndTurretHurt;
		snd_dead			= sndTurretDead;
		
		 // Vars:
		team				= 1;
		mask_index			= mskBandit;
		maxhealth			= 200;
		my_health			= maxhealth;
		activated			= true;
		
		myBall				= BallTrapBall_create(x, y, self, random(360))
		
		on_step				= BallTrap_step;
		on_hurt				= Prop_hurt;
		
		return self;
	}
	
#define BallTrap_step

	x = xstart;
	y = ystart;
	speed = 0;

	 // Animate:
	if(anim_end){
		sprite_index = spr_idle;
	}
	
	 // New Ball:
	if(!instance_exists(myBall) && activated = true){
		myBall = BallTrapBall_create(x, y, self, random(360))
	}
	
	 // Time to Sleep:
	if(instance_exists(Portal) && activated = true){
		activated = false;
		spr_idle  = spr_off;
		with(myBall){
			instance_destroy();
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

#define BallTrapBall_create(_x, _y, _creator, _angle)
	with(instance_create(_x, _y, CustomProjectile)){
		
		name				= "fr_BallTrapBall"
		
		 // Visusals
		sprite_index		= global.sprBallTrapBall;
		image_speed			= 0.4;
		depth				= -7;
		hitid				= _creator.hitid;
		fr_bloom			= [1.5, 0.2];
        fr_glow				= [24, 32];
	
		 // Vars:
		damage				= 3;
		creator				= _creator;
		mask_index			= global.mskBallTrapBall;
		typ					= 0;
		ammo_type			= -1;
		team				= _creator.team;
		angle				= _angle;
		dist				= 0;
		maxDist				= 60;
		
		on_step				= BallTrapBall_step;
		on_end_step			= BallTrapBall_endstep;
		on_hit				= BallTrapBall_hit;
		on_wall				= BallTrapBall_wall;
		on_destroy			= BallTrapBall_destroy;
		
		xprevious = creator.x + lengthdir_x(dist, angle);
		yprevious = creator.y + lengthdir_y(dist, angle);
		x = creator.x + lengthdir_x(dist, angle);
		y = creator.y + lengthdir_y(dist, angle);
		
		return self;
	}

#define BallTrapBall_step
	if(!instance_exists(creator)){
		instance_destroy();
		exit;
	}
	
	 // Move Out:
	if(dist < maxDist){
		dist += 0.5 * current_time_scale;
	}

	if(random(4) < 1){
		with instance_create(x + orandom(8), y + orandom(8), BulletHit){
			sprite_index	= global.sprBallTrapBallTrail;
			image_angle		= random(360);
			depth			= other.depth
		}
	}
	
	 // Set Size and Speen:
	angle += 3.5 * current_time_scale;
	image_angle += 12 * current_time_scale;

#define BallTrapBall_endstep
	if(instance_exists(creator)){
		xprevious = creator.x + lengthdir_x(dist, angle);
		yprevious = creator.y + lengthdir_y(dist, angle);
		x = creator.x + lengthdir_x(dist, angle);
		y = creator.y + lengthdir_y(dist, angle);
	}

#define BallTrapBall_hit
	if(projectile_canhit_melee(other)){
		with(other){
			if("fr_trapImmune" not in self && !instance_is(self, prop)){
				lasthit = [global.sprBallTrap, "ELECTRIC TRAP"];
				projectile_hit(self, other.damage);
			}
		}
	}

#define BallTrapBall_wall
	xprevious = x + hspeed;
	yprevious = y + vspeed;
	
#define BallTrapBall_destroy
	with(instance_create(x, y, BulletHit)){ 
		sprite_index	= global.sprBallTrapBallDisappear;
		image_angle		= other.image_angle;
		depth			= -3; 
		image_xscale	= 0.8; 
		image_yscale	= image_xscale;
	}
	
/*
//#define SecurityTrap_create(_x, _y)
	with(instance_create(_x, _y, CustomHitme)){
		
		name				= "fr_SecurityTrap"
		
		 // Visuals:	
		spr_idle			= global.sprSecurityTrap;
		spr_top				= global.sprSecurityTrapTop;
		spr_hurt			= global.sprSecurityTrapHurt;
		spr_dead			= global.sprSecurityTrapDead;
		spr_open			= global.sprSecurityTrapOpening;
		spr_done			= global.sprSecurityTrapOpen;
		spr_hurt_open		= global.sprSecurityTrapOpenHurt;
		sprite_index		= spr_idle;
		image_speed			= 0.4;
		depth				= -1;
		spr_shadow			= shd32;
		spr_shadow_y		= 6;
		
		 // Sounds:
		snd_hurt			= sndTurretHurt;
		snd_dead			= sndTurretDead;
		
		 // Vars:
		mask_index			= mskRhinoFreak;
		maxhealth			= 200;
		my_health			= maxhealth;
		activated			= false;
		searching			= true;
		foundYou			= false;
		goTime				= 45;
		cameraAngle			= random(360);
		freaks				= 0;
		freakTime			= 0;
		
		myScan				= SecurityTrapScan_create(x + lengthdir_x(48, cameraAngle), y + lengthdir_y(48, cameraAngle) - 8, self)
		
		on_step				= SecurityTrap_step;
		on_hurt				= Prop_hurt;
		
		return self;
	}

//#define SecurityTrap_step

	x = xstart;
	y = ystart;
	speed = 0;
	
	 // Im Looking....
	if(searching = true){
		cameraAngle	+= (2 * current_time_scale);
	}
	
	 // Animate:
	if(sprite_index != spr_open && anim_end){
		sprite_index = spr_idle;
	}
	
	 // Got You!
	var myGuy = instance_nearest(x, y, Player);
	if(searching = false){
		cameraAngle -= (angle_difference(cameraAngle, point_direction(x, y, myGuy.x, myGuy.y)) * power(0.1 * 2, current_time_scale));
	}
	if(searching = true && foundYou = true){
		searching = false;
		sound_play_pitchvol(sndIDPDNadeAlmost, 0.5, 1.2)
	}
	
	 // ENGAGE EVIL:
	if(searching = false && activated = false){
		if(goTime > 0){
			goTime -= current_time_scale;
		}
		if(goTime <= 0){
			activated = true;
			with(myScan){
				instance_destroy();
			}
			sprite_index = spr_open;
		}
	}
	if(sprite_index = spr_open && anim_end){
		freaks			= 12 + irandom(5);
		freakTime		= 2;
		sound_play_pitch(sndToxicBoltGas, 0.5 + random(0.1))
		spr_idle		= spr_done;
		spr_hurt		= spr_hurt_open;
		sprite_index	= spr_idle;
	}
	 
	 // SpawnEm
	if(freaks > 0){
		if(freakTime <= 0){
			with instance_create(x, y, Freak){
				image_alpha	= 0.4;
				script_bind_draw(TrapFreak_draw, other.depth - 1, self)
			}
			freaks -= 1;
			freakTime += 2;
		}
		freakTime -= current_time_scale;
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

//#define SecurityTrapScan_create(_x, _y, _creator)
	with(instance_create(_x, _y, CustomObject)){
		
		name				= "fr_SecurityTrapScan"
		
		 // Visusals
		sprite_index		= global.sprSecurityTrapScan;
		image_speed			= 0;
		depth				= -7;
		image_alpha			= 0;
	
		 // Vars:
		creator				= _creator;
		mask_index			= global.mskSecurityTrapScan;
		
		on_step				= SecurityTrapScan_step;
		on_draw				= SecurityTrapScan_draw;
		
		return self;
	}

//#define SecurityTrapScan_step
	
	if(!instance_exists(creator)){
		instance_destroy();
		exit;
	}
	
	x			= creator.x + lengthdir_x(48, creator.cameraAngle);
	y			= creator.y + lengthdir_y(48, creator.cameraAngle) - 8;
	image_angle	= creator.cameraAngle;
	
	if(place_meeting(x, y, Player)){
		creator.foundYou = true;
	}

//#define SecurityTrapScan_draw
	if(!instance_exists(creator)){ exit; }
	if(creator.nexthurt > current_frame + 4){
		d3d_set_fog(1, c_white, 0, 0)
	}
	draw_sprite_ext(global.sprSecurityTrapScan, 0, x, y, 1, 1, image_angle, c_white, 0.4)
	draw_sprite_ext(creator.spr_top, 0, creator.x, creator.y, creator.image_xscale, creator.image_yscale, creator.image_angle, creator.image_blend, creator.image_alpha)
	d3d_set_fog(0, c_white, 0, 0)

//#define TrapFreak_draw(_target)

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
*/


//#endregion
//#region ENEMIES
#define SmartestNecromancer_create(_x, _y)
	with(instance_create(_x, _y, CustomEnemy)){
    	name = "Smartest Guy Ever"
    	
         // Visuals: 
        spr_idle		= global.sprNecromancerSmartIdle;
		spr_walk		= global.sprNecromancerSmartWalk;
		spr_hurt		= global.sprNecromancerSmartHurt; 
		spr_dead		= mskNone;
		sprite_index    = spr_idle;
		image_speed     = 0.4;
		depth           = -2;
		hitid           = [spr_idle, "NECROMANCER"]
        spr_shadow      = shd24;	
        spr_shadow_y	= 2;
        
         // Sounds:
        snd_hurt		= global.sndSmartHurt[irandom(array_length(global.sndSmartHurt) - 1)];
        snd_dead		= global.sndSmartDead;
        snd_idle		= global.sndSmartIdle[irandom(array_length(global.sndSmartIdle) - 1)];
        
         // Vars:
        mask_nrml		= mskMaggot;
        mask_index		= mask_nrml
        direction   	= random(360);
        maxhealth   	= 20;
       	my_health   	= maxhealth;
        raddrop     	= 2;
        maxspeed    	= 3;
        walkspeed   	= maxspeed;
        size			= 1;
        canmelee    	= 0;
        team        	= 1; 
        targetvisible	= 0;
        target      	= 0;
        walk        	= 0;
		prevHealth		= maxhealth;
		voiceCooldown	= 0;
        
         // Alarms:
        alarm1 = 20 + irandom(30);

         // Scripts:
        on_step  = script_ref_create(SmartestNecromancer_step);
        on_draw  = BasicEnemy_draw;
        on_hurt  = Enemy_hurt;
        on_death = SmartestNecromancer_death;
        on_alrm1 = script_ref_create(SmartestNecromancer_alrm1);		
		
		return self;
	}
	
#define SmartestNecromancer_step

	 // Alarms:
	if("on_alrm1" in self and alarm1_run) exit;

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

	 // Hurt Sound Variants:
	if(my_health != prevHealth){
		sound_stop(snd_idle);
		snd_hurt = global.sndSmartHurt[irandom(array_length(global.sndSmartHurt) - 1)]
	}
	prevHealth = my_health;
	
	if(voiceCooldown > 0){
		voiceCooldown -= current_time_scale;
	}
	
	right = (direction + 270) mod 360 > 180 ? 1 : -1;

#define SmartestNecromancer_alrm1
	alarm1 = 40 + irandom(20);
	
	if(distance_to_object(Player) < 128) && (voiceCooldown <= 0){
		if(chance(2, 5)){
			snd_idle = global.sndSmartIdle[irandom(array_length(global.sndSmartIdle) - 1)];
			sound_play(snd_idle)
			voiceCooldown += 90;
		}
	}
	
    if(chance(1, 4)){
	    enemy_walk(random(360), alarm1 - 10);
	    enemy_look(direction);
    }
    
#define SmartestNecromancer_death
	sound_stop(snd_hurt);
	
	if(my_health <= 0){
		repeat(6){
			Gib_create(x, y)
		}
		repeat(6){
			with(instance_create(x, y, BloodStreak)){
				direction	= random(360);
				speed		= 2;
			}
		}
	}

#define Gib_create(_x, _y)
	with(instance_create(x, y, CustomObject)){
		sprite_index	= global.sprGibs;
		image_index		= irandom(2);
		image_speed		= 0;
		speed			= 2.5 + random(1);
		friction		= 0.1;
		direction		= random(360);
		despawnTime		= 120;
		on_step			= Gib_step;
	
		with(mod_script_call("mod", "Frontier_Objects", "ZAxisToss_create", x, y)){
			direction   	= other.direction;
			speed       	= 2 + random(2)
			zspeed      	= 3 + random(1);
			zfriction		= 0.6;
			creator     	= other;
			depth       	= other.depth;
			mask_index  	= other.mask_index;
			impactEffect	= false;
		}
			
		return self;
	}

#define Gib_step
	despawnTime -= current_time_scale;
	if(despawnTime <= 0){
		instance_destroy();
	}

//#region GRAVEYARD ENEMIES
#define Voltergeist_create(_x, _y)
         // Spawn Controller:
	if(array_length(instances_matching(CustomObject, "name", "fr_VoltergeistController")) = 0){
    	VoltergeistController_create(10016, 10016);
     }
	     
	with instance_create(_x, _y, CustomEnemy){
   
    	name = "Voltergeist"
    	
         // Visuals: 
        spr_idle		= global.sprVoltergeistIdle;
		spr_walk		= global.sprVoltergeistIdle;
		spr_fly 		= global.sprVoltergeistFly;
		spr_hurt		= global.sprVoltergeistHurt; 
		spr_dead		= global.sprVoltergeistDead;
		sprite_index    = spr_idle;
		image_speed     = 0.4;
		depth           = -3;
		hitid           = [spr_idle, "VOLTERGEIST"];
		trailColor		= make_color_rgb(255, 217, 70);
        nts_color_blood = [c_aqua, c_yellow]
        
         // Sounds:
        snd_hurt		= global.sndVoltergeistHurt;
        snd_dead		= global.sndVoltergeistDead;
        snd_fly			= global.sndVoltergeistFly;
        snd_possess 	= global.sndVoltergeistPossess;
        
         // Vars:
        mask_nrml		= mskMaggot;
        mask_index		= mask_nrml
        direction   	= random(360);
        maxhealth   	= 16;
       	my_health   	= maxhealth;
        raddrop     	= 1;
        maxspeed    	= 3;
        walkspeed   	= maxspeed;
        size			= 1;
        canmelee    	= 0;
        team        	= 1; 
        targetvisible	= 0;
        target      	= 0;
        walk        	= 0;
        canfly			= true;
        possess_target  = noone;
        omw2possess		= false;
        possessing		= false;
        possessionCreds	= 2;
        armorLock		= 0;
        
         // Alarms:
        alarm1 = 20 + irandom(30);

         // Scripts:
        on_step 	= script_ref_create(Voltergeist_step);
        on_end_step = Voltergeist_endstep;
        on_draw 	= BasicEnemy_draw;
        on_hurt 	= Voltergeist_hurt;
        on_death	= nothing;
        on_alrm1	= script_ref_create(Voltergeist_alrm1);
        
        return self;
	}
	
#define Voltergeist_step

		// Alarms:
	if("on_alrm1" in self and alarm1_run) exit;
	
	
		// Destroy if no possessables and not possessing:
	if(array_length(instances_matching(hitme, "fr_possessable", true)) <= 0) && (possessing = false){
		my_health = 0;
		exit; 
	}
	 // Boost HP for a bit after losing vessel:
	if(armorLock > 0){
		armorLock -= current_time_scale;
	} else {
		if(possessing = false) && (my_health > maxhealth){
			my_health = maxhealth;
		}
	}
	
		// What possessed you to do something like this:
	if(omw2possess = true){
		possess_target = call(scr.instance_nearest_array, x, y, instances_matching(hitme, "fr_possessable", true));
		
		 // dont go after things super far away
		if(distance_to_object(possess_target) > 480){
			my_health = 0;
		}
		
        direction	-= angle_difference(direction, point_direction(x, y, possess_target.x, possess_target.y)) * power(0.1 * 2, current_time_scale);
        image_angle	= direction - 90;
		enemy_walk(direction + orandom(20), 1)
		
		 // Go In!
		if(distance_to_object(possess_target) < 6){
			
			sound_play_pitch(snd_possess, 0.95 + random(0.1));
			
			possessionCreds -= 1;
			my_health	= (maxhealth * 5)
			possessing	= true;
			omw2possess = false;
			maxspeed	/= 3;
			depth		= -2;
			image_alpha	= 0;
			image_angle = 0;
			with(possess_target){
				fr_possessable	= false;
				fr_possessed	= true;
				fr_possessor	= other;
				
				if("on_possessed" in self){
					script_ref_call(on_possessed);
				} else {
					 // For Basegame Enemies:
					switch(object_index){
						case SnowTank:
							spr_idle	= global.sprSnowTankPossessedIdle;
							spr_walk	= global.sprSnowTankPossessedWalk;
							hitid		= [spr_idle, "POSSESSED#SNOWTANK"];
						break;
						case GoldSnowTank:
							spr_idle	= (global.settingBlaacTank = true) ? global.sprBlaacGoldTankPossessedIdle : global.sprGoldTankPossessedIdle;
							spr_walk	= (global.settingBlaacTank = true) ? global.sprBlaacGoldTankPossessedWalk : global.sprGoldTankPossessedWalk;
							hitid		= [spr_idle, "POSSESSED GOLDEN#SNOWTANK"];
						break;
						case Wolf:
							spr_idle	= global.sprWolfPossessedIdle;
							spr_walk	= global.sprWolfPossessedWalk;
							spr_fire	= global.sprWolfPossessedFire;
							hitid		= [spr_idle, "POSSESSED#WOLF"];
						break;
						case Turret:
							spr_idle	= global.sprTurretPossessedIdle;
							spr_walk	= spr_idle;
							spr_hurt	= global.sprTurretPossessedHurt;
							spr_fire	= global.sprTurretPossessedFire;
							hitid		= [spr_idle, "POSSESSED#TURRET"];
						break;
						case Sniper:
							spr_idle	= global.sprSniperPossessedIdle;
							spr_walk	= global.sprSniperPossessedWalk;
							hitid		= [spr_idle, "POSSESSED#SNIPER"];
						break;
						case SnowBot:
							 // snowbot's being hardcoded is like evil.. i hate them...
							 // sprites are set by voltergeist controller
							 
							 // Hate. Let me tell you how much I've come to hate you since I began to live.
							
							/*
							switch(spr_idle){
								case sprSnowBotCarIdle:
									spr_idle	= global.sprSnowBotPossessedCarIdle;
									spr_walk	= global.sprSnowBotPossessedCarWalk;		
									spr_p_style	= 0;
								break;
								case sprSnowBotRedCarIdle:
									spr_idle	= global.sprSnowBotPossessedRedCarIdle;
									spr_walk	= global.sprSnowBotPossessedRedCarWalk;				
									spr_p_style	= 1;
								break;
								default:
									spr_idle	= global.sprSnowBotPossessedIdle;
									spr_walk	= global.sprSnowBotPossessedWalk;	
									spr_p_style	= 0;
							}
							spr_fire		= global.sprSnowBotPossessedFire;
							spr_p_carlift	= [global.sprSnowBotPossessedCarLift,	global.sprSnowBotPossessedRedCarLift];
							spr_p_caridle	= [global.sprSnowBotPossessedCarIdle,	global.sprSnowBotPossessedRedCarIdle];
							spr_p_carwalk	= [global.sprSnowBotPossessedCarWalk,	global.sprSnowBotPossessedRedCarWalk];
							spr_p_carthrow	= [global.sprSnowBotPossessedCarThrow,	global.sprSnowBotPossessedRedCarThrow];
							spr_p_idle		= global.sprSnowBotPossessedIdle; // for setting sprites back after car's thrown.
							spr_p_walk		= global.sprSnowBotPossessedWalk;
							spr_p_throwcheck= false;
							*/
							spr_idle		= global.sprSnowBotPossessedIdle;
							spr_walk		= global.sprSnowBotPossessedWalk;
							spr_fire		= global.sprSnowBotPossessedFire;
							hitid			= [spr_idle, "POSSESSED#SNOWBOT"];
						break;						
					}
					 // Give Status Effect - should be run in on_possessed for modded enemies that want to use it for the possession buff:
					mod_script_call('mod', 'Frontier_StatusEffects', 'status_apply_set', self, mod_variable_get('mod', 'Frontier_StatusEffects', 'buffVoltergeist'), 1/0);
					
					 // Particles:
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
				}
			}
		}
	}
	
	if(possessing = true){
		if(instance_exists(possess_target)){
			x = possess_target.x;
			y = possess_target.y;
		} else {
			Voltergeist_end_possession();
		}
	}
	
	 // Zappy Particles:
	if(random(30) < 1){
		with(instance_create(x, y, BulletHit)){
			var _variant	= irandom(4);	 
			sprite_index	= global.sprVoltergeistLightning[_variant];
		}
	}
	
		// Movement:
	if(walk > 0){ walk -= current_time_scale;   speed += walkspeed * current_time_scale;   gunangle = direction }
	
		//Speed Cap:
	if(speed > maxspeed){ speed = maxspeed; }
	
	 // Animate:
	if(sprite_index != spr_fly && anim_end){ 
		sprite_index = spr_idle; 
	}
	if(omw2possess = true){
		if(sprite_index != spr_hurt){
			sprite_index = spr_fly;
		}
	}	
	
		//Use Your Eyes:
	right = (direction + 270) mod 360 > 180 ? 1 : -1;

#define Voltergeist_endstep
		// Trail:
	if(omw2possess = true){
		with(GenericTrail_create(x, y)){
			depth			= other.depth + 1;
			image_xscale	= point_distance(x, y, other.xprevious, other.yprevious)
			image_yscale   *= 2;
			image_speed    *= 4;
			image_angle 	= point_direction(x, y, other.xprevious, other.yprevious)
			image_blend 	= other.trailColor;
		}
	}

#define Voltergeist_end_possession
	armorLock		= 30;
	mask_index		= mask_nrml;
	possessing		= false;
	image_alpha 	= 1;
	alarm1			= 10; 
	sprite_index	= spr_idle;
	if(possessionCreds <= 0){
		my_health = 0;
		exit; 
	}
	
#define Voltergeist_alrm1
	if(possessing = false){
		alarm1 = 40 + irandom(30);
		
		 // Just die if nearest possessable is super far away. this avoids raven moments.
		var _nearestPossessable = call(scr.instance_nearest_array, x, y, instances_matching(hitme, "fr_possessable", true));
		if(distance_to_object(_nearestPossessable) > 512){
			my_health	= 0;
			exit;
		}

		if(omw2possess = false){
			if(distance_to_object(target) < 96 || my_health < (maxhealth / 2)){
				omw2possess = true;
				maxspeed   *= 3;
				mask_index	= mskNone;
				depth		= -8;
				
				sound_play_pitch(snd_fly, 0.95 + random(0.1));
				
				exit;
			}
			enemy_walk(random(360), 30);
			enemy_look(direction);
		}
	}
	
#define Voltergeist_hurt(_dmg, _spd, _dir)
	sprite_index = spr_hurt;
	image_index  = 0;
	
	motion_add(_dir, _spd);
	
	nexthurt   = current_frame + 6;
	my_health -= _dmg;
	
	 // apparently every enemy in the game plays their hit sound alongside their death sound, who knew.
	 // this fixes that for voltergeists specifically cause it sounds nicer.
	if(my_health > 0){
		sound_play_hit(snd_hurt, 0.3);
	}

#define VoltergeistController_create(_x, _y)
	with(instance_create(_x, _y, CustomObject)){
		name = "fr_VoltergeistController";
		
		sprite_index	= mskNone;
		on_step	= VoltergeistController_step;
	}

#define VoltergeistController_step
	with(instances_matching([SnowTank, GoldSnowTank, SnowBot, Wolf, Sniper, Turret], "fr_possessable", null)){
		fr_possessable	= true;
		fr_possessed	= false;
	}
	 // snowbots not be a pain to work with for once challenge (IMPOSSIBLE):
	 // they were gonna work like normal but I couldn't get the sprites to work right so voltergeists leave when they grab cars, and return credit.
	with(instances_matching(SnowBot, "fr_possessed", true)){
		if(sprite_index = spr_fire){
			 // yeah whatever
			speed += 0.5;
		}
		if(instance_is(self, SnowBotCar)){
			with(fr_possessor){
				possessionCreds += 1;
				Voltergeist_end_possession();
			}
			fr_possessed = false;
			fr_possessable = false;
			mod_script_call('mod', 'Frontier_StatusEffects', 'status_apply_set', self, mod_variable_get('mod', 'Frontier_StatusEffects', 'buffVoltergeist'), 0);
		}
	}	
		
		 // i hate you so much
		/*
		if(spr_idle = sprSnowBotCarLift){
			spr_p_style = 0;
			spr_idle = spr_p_carlift[spr_p_style];
		}
		if(spr_idle = sprSnowBotRedCarLift){
			spr_p_style = 1;
			spr_idle = spr_p_carlift[spr_p_style];
		}
		if(spr_idle = sprSnowBotCarIdle || spr_idle = sprSnowBotRedCarIdle){
			spr_idle = spr_p_caridle[spr_p_style];
			spr_walk = spr_p_carwalk[spr_p_style];
		}
		if(spr_idle = sprSnowBotCarThrow || spr_idle = sprSnowBotRedCarThrow){
			trace("RAHHHH")
			spr_idle = spr_p_carthrow[spr_p_style];
			spr_p_throwcheck = true;
		}
		if(spr_p_throwcheck = true){
			if(spr_idle != spr_p_carthrow[spr_p_style]){
				spr_idle = spr_p_idle;
				spr_walk = spr_p_walk;
				spr_p_throwcheck = false;
			}
		}
		*/
		
#define Voltergeist_possess_manual

	 // might be worth reworking this for voltergeists to just use this when possessing but its fine ig
	 // for now is only used by Haunted City event to possess some robots.
	with(possess_target){
		fr_possessable	= false;
		fr_possessed	= true;
		fr_possessor	= other;
		
		if("on_possessed" in self){
			script_ref_call(on_possessed);
		} else {
			 // For Basegame Enemies:
			switch(object_index){
				case SnowTank:
					spr_idle	= global.sprSnowTankPossessedIdle;
					spr_walk	= global.sprSnowTankPossessedWalk;
					hitid		= [spr_idle, "POSSESSED#SNOWTANK"];
				break;
				case GoldSnowTank:
					spr_idle	= (global.settingBlaacTank = true) ? global.sprBlaacGoldTankPossessedIdle : global.sprGoldTankPossessedIdle;
					spr_walk	= (global.settingBlaacTank = true) ? global.sprBlaacGoldTankPossessedWalk : global.sprGoldTankPossessedWalk;
					hitid		= [spr_idle, "POSSESSED GOLDEN#SNOWTANK"];
				break;
				case Wolf:
					spr_idle	= global.sprWolfPossessedIdle;
					spr_walk	= global.sprWolfPossessedWalk;
					spr_fire	= global.sprWolfPossessedFire;
					hitid		= [spr_idle, "POSSESSED#WOLF"];
				break;
				case Turret:
					spr_idle	= global.sprTurretPossessedIdle;
					spr_walk	= spr_idle;
					spr_hurt	= global.sprTurretPossessedHurt;
					spr_fire	= global.sprTurretPossessedFire;
					hitid		= [spr_idle, "POSSESSED#TURRET"];
				break;
				case Sniper:
					spr_idle	= global.sprSniperPossessedIdle;
					spr_walk	= global.sprSniperPossessedWalk;
					hitid		= [spr_idle, "POSSESSED#SNIPER"];
				break;
				case SnowBot:
					spr_idle		= global.sprSnowBotPossessedIdle;
					spr_walk		= global.sprSnowBotPossessedWalk;
					spr_fire		= global.sprSnowBotPossessedFire;
					hitid			= [spr_idle, "POSSESSED#SNOWBOT"];
				break;						
			}
			 // Give Status Effect - should be run in on_possessed for modded enemies that want to use it for the possession buff:
			mod_script_call('mod', 'Frontier_StatusEffects', 'status_apply_set', self, mod_variable_get('mod', 'Frontier_StatusEffects', 'buffVoltergeist'), 1/0);
		}
	}
			
	
	
#define VesselMortar_create(_x, _y, _breakIt)
	with instance_create(_x, _y, CustomEnemy){
   
    	name = "Datadriver"
    	
         // Visuals: 
        spr_idle		= global.sprVesselMortarIdle;
		spr_walk		= global.sprVesselMortarWalk;
		spr_hurt		= global.sprVesselMortarHurt;
		spr_dead		= global.sprVesselMortarDead;
		spr_loading		= global.sprVesselMortarReload;
		spr_idle_loaded = global.sprVesselMortarLoadedIdle;
		spr_walk_loaded	= global.sprVesselMortarLoadedWalk;
		spr_hurt_loaded	= global.sprVesselMortarLoadedHurt;
		spr_dead_loaded	= global.sprVesselMortarLoadedDead;
		spr_idle_nrml	= spr_idle;
		spr_hurt_nrml	= spr_hurt;
		spr_walk_nrml	= spr_walk;
		spr_dead_nrml	= spr_dead;
		sprite_index    = spr_idle;
		image_speed     = 0.4;
		depth           = -2;
		hitid           = [spr_idle_loaded, "DATADRIVER"]
        spr_shadow      = shd48;	
        spr_shadow_y	= 8;
        nts_color_blood = [make_color_rgb(96, 59, 52), c_black]
        
         // Sounds:
        snd_hurt		= global.sndDatadriverHurt;
        snd_dead		= global.sndDatadriverDead;
        snd_load		= global.sndDatadriverReplace;
        snd_dig			= global.sndDatadriverDig;
        
         // Vars:
        mask_index  	= global.mskVesselMortar;
        msk_nrml		= global.mskVesselMortar;
        msk_loaded		= global.mskVesselMortarLoaded;
        direction   	= random(360);
        maxhealth   	= 42;
       	my_health   	= maxhealth;
        raddrop     	= 10;
        maxspeed    	= 2.6;
        walkspeed   	= maxspeed;
        size			= 3;
        canmelee    	= 0;
        meleedamage		= 0;
        team        	= 1; 
        targetvisible	= 0;
        target      	= 0;
        walk        	= 0;
        target_x		= 10016;
        target_y		= 10016;
        loading			= false;
        loaded			= false;
        doReloadSound	= false;
        if(_breakIt = true){
        	with(instance_create(x, y, PortalClear)){
        		image_xscale	= 0.6;
        		image_yscale	= image_xscale;
        	}
        }
        
         // Alarms:
        alarm1 = 20 + irandom(10);
        alarm2 = 0;

         // Scripts:
        on_step  = script_ref_create(VesselMortar_step);
        on_draw  = BasicEnemy_draw;
        on_hurt  = Enemy_hurt;
        on_death = VesselMortar_death;
        on_alrm1 = script_ref_create(VesselMortar_alrm1);
        on_alrm2 = script_ref_create(VesselMortar_alrm2);
        
        return self;
	}

#define VesselMortar_step

	 // Alarms:
	if("on_alrm1" in self and alarm1_run) exit;
	if("on_alrm2" in self and alarm2_run) exit;
	
	 // RELEASE MEEEEE:
	if(place_meeting(x, y, Wall)){
		instance_create(x, y, PortalClear);
	}

	 // Movement:
	if(walk > 0){ 
		walk -= current_time_scale;   
		speed += walkspeed * current_time_scale;   
	}
	if(speed > maxspeed){ 
		speed = maxspeed; 
	}
	
	 // Animate: 
	if(loading = false){
		if(sprite_index != spr_loading && anim_end){ 
			sprite_index = (speed > 0) ? spr_walk : spr_idle; 
		} else {
			sprite_index = enemy_sprite;
		}
	} else {
		if(sprite_index = spr_hurt && anim_end){
			 // Cancel Reload:
			loading = false;
		}
	}
	
	 // Load Up:
	if(sprite_index = spr_loading){
		// play reload sound:
		if(doReloadSound = true){
			if(image_index >= 7){
				sound_play_pitch(snd_load, 0.95 + random(0.1));
				doReloadSound	= false;
			}
		}
		
		 // done loading:
		if(anim_end){
			loading 		= false;
			loaded			= true;
			spr_idle		= spr_idle_loaded;
			spr_walk		= spr_walk_loaded;
			spr_hurt		= spr_hurt_loaded;
			spr_dead		= spr_dead_loaded;
			mask_index		= msk_loaded;
			sprite_index	= spr_idle;			
		}
	}


	right = (direction + 270) mod 360 > 180 ? 1 : -1;


#define VesselMortar_alrm1
	alarm1 = 40 + irandom(30);
	
	if(enemy_target(x, y) && target_visible){
		enemy_look(target_direction);
		
		// Get Loaded!:
		if(loaded = false){
			if(chance(3, 4)){
				if(loading = false){
					alarm1			= 30 + irandom(15);
					loading			= true;
					image_index		= 0;
					sprite_index	= spr_loading;
					doReloadSound	= true;
					sound_play_pitch(snd_dig, 0.9 + random(0.2))
				}
			 // Stroll:
			} else {
			    enemy_walk(random(360), alarm1 - 10);
			    enemy_look(direction);
			}
		} else {
			
			 // FIRE !! 
			if(target_distance < 160){
				if(chance(4, 5)){
					alarm1			= 40 + irandom(20);
					loaded			= false;

					 // Target:
					if(instance_exists(target)){
						target_x = target.x + (target.hspeed) + random_range(-24, 24);
						target_y = target.y + (target.vspeed) + random_range(-24, 24);
					}					
					
					 // Projectile:
					with(MortarJunk_create(x, y)){
						mask_index		= mskNone;
						z				= 13;
						zspeed  		= 11 + random(2);
						zfriction		= 0.6;
						direction		= point_direction(x, y, other.target_x, other.target_y);
						speed   		= (point_distance(x, y, other.target_x, other.target_y) * zfriction) / (zspeed * 2);
						image_angle 	= direction;
						target_x		= other.target_x;
						target_y		= other.target_y;
						team        	= other.team;
						creator 		= other;
						hitid			= other.hitid;
						
						with(script_bind_draw(MortarJunk_warningDraw, -1, target_x, target_y)){
							speen	= random(360);
							creator = other;
						}
					}
					
					 // FX:
					repeat(8){
						with(instance_create(x, y, Smoke)){
							direction	= random(360);
							depth		= other.depth - 1;
							speed		= 2 + random(2);
						}
					}
					 
					 // Sounds:
					 sound_play_pitch(sndExplosionS, 0.8 + random(0.2));
					 sound_play_pitch(sndExplosion, 1.5 + random(0.2));
					
					 // Reset Sprites:
					spr_idle	= spr_idle_nrml;
					spr_walk	= spr_walk_nrml;
					spr_hurt	= spr_hurt_nrml;
					spr_dead	= spr_dead_nrml;
					mask_index	= msk_nrml;
					
				 // Random Stroll:
				} else {
					enemy_walk(random(360), alarm1 - 10);
			    	enemy_look(direction);
				}
			 // Approach Target Distance
			} else {
				if(chance(2, 3)){
					alarm1 = 30 + irandom(15);
					enemy_walk(target_direction + orandom(85), alarm1 - 5);
				}				
			}
		}
	}
    // Wander Around Town:
    else{
	    if(chance(2, 3) && loading = false){
		    enemy_walk(random(360), alarm1 - 10);
		    enemy_look(direction);
	    }
	}
	
#define VesselMortar_alrm2
	alarm1 = 40 + irandom(30);

#define VesselMortar_death
	pickup_drop(55, 15);
	
#define VesselMortar_spawn(_x, _y)
	with(VesselMortar_create(_x, _y, false)){
		loading 		= false;
		loaded			= true;
		spr_idle		= spr_idle_loaded;
		spr_walk		= spr_walk_loaded;
		spr_hurt		= spr_hurt_loaded;
		spr_dead		= spr_dead_loaded;
		mask_index		= msk_loaded;
        alarm1			= 50 + irandom(10);
		with(Voltergeist_create(x, y)){
			possess_target	= other;
			possessing		= true;
			depth			= -2;
			image_alpha		= 0;
			image_angle 	= 0;
			mask_index		= mskNone;
			possessionCreds -= 1;
		}
	}

#define VesselOrbiter_create(_x, _y)
	with instance_create(_x, _y, CustomEnemy){
   
    	name = "Coreaphee"
    	
         // Visuals: 
        spr_idle		= global.sprVesselOrbiterIdle;
		spr_walk		= global.sprVesselOrbiterIdle;
		spr_hurt		= global.sprVesselOrbiterHurt;
		spr_dead		= global.sprVesselOrbiterDead;
		sprite_index    = spr_idle;
		image_speed     = 0.4;
		depth           = -2;
		hitid           = [spr_idle, "COREAPHEE"]
        spr_shadow      = shd24;	
        spr_shadow_y	= 10;
        nts_color_blood = [make_color_rgb(96, 59, 52), c_black];
        right			= 1;
        
         // Sounds:
        snd_hurt		= global.sndCoreapheeHurt;
        snd_dead		= global.sndCoreapheeDead;
        
         // Vars:
        mask_index  	= global.mskVesselOrbiter;
        direction   	= random(360);
        maxhealth   	= 14;
       	my_health   	= maxhealth;
        raddrop     	= 4;
        maxspeed    	= 2.5;
        walkspeed   	= maxspeed;
        size			= 2;
        canmelee    	= 1;
        meleedamage		= 2;
        team        	= 1; 
        targetvisible	= 0;
        target      	= 0;
        walk        	= 0;
		currentOrbitals = 0;
        
         // Alarms:
        alarm1 = 20 + irandom(10);

         // Scripts:
        on_step  = script_ref_create(VesselOrbiter_step);
        on_draw  = BasicEnemy_draw;
        on_hurt  = Enemy_hurt;
        on_death = VesselOrbiter_death;
        on_alrm1 = script_ref_create(VesselOrbiter_alrm1);

        return self;
	}
	
#define VesselOrbiter_step

	 // Alarms:
	if("on_alrm1" in self and alarm1_run) exit;

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

#define VesselOrbiter_alrm1
	alarm1 = 70 + irandom(20);
	
	// Create Orbital:
	if(currentOrbitals < 3){
		if(chance(3, 4)){
			currentOrbitals += 1;
			with(VesselOrbital_create(x, y, other, random(360))){
				maxDist			= 20 + irandom(25);
				orbitSpeed		= 2 + random(3);
				with(instance_create(x, y, BulletHit)){
					sprite_index	= sprEnemyBulletHit;
					depth			= -2;
				}
			}
		}
	}

	if(enemy_target(x, y) && target_visible){
		enemy_look(target_direction);
		
			// GET YOU:
		if(target_distance > 42){
			alarm1 = 20 + irandom(10);
			enemy_walk(target_direction + orandom(20), alarm1);
		}
	}
    // Wander Around Town:
    else{
	    enemy_walk(random(360), alarm1);
	    enemy_look(direction);
	}
	
		//Use Your Eyes:
	right = (direction + 270) mod 360 > 180 ? 1 : -1;
	
#define VesselOrbiter_death
	pickup_drop(20, 0);
	
#define VesselOrbiter_spawn(_x, _y)
	with(VesselOrbiter_create(_x, _y)){
		alarm1 = 30 + irandom(10);
		with Voltergeist_create(x, y){
			possess_target	= other;
			possessing		= true;
			depth			= -2;
			image_alpha		= 0;
			image_angle 	= 0;
			mask_index		= mskNone;
			possessionCreds -= 1;
		}
	}

#define VesselCharger_create(_x, _y)
	with(instance_create(_x, _y, CustomEnemy)){
   
    	name = "Charger Vessel"
    	
        // Visuals: 
        spr_idle		= global.sprVesselChargerIdle;
		spr_walk		= global.sprVesselChargerWalk;
		spr_hurt		= global.sprVesselChargerHurt;
		spr_dead		= global.sprVesselChargerDead;;
		spr_tell		= global.sprVesselChargerTell;
		spr_chrg		= global.sprVesselChargerChrg;
		sprite_index    = spr_idle;
		image_speed     = 0.4;
		depth           = -2;
		hitid           = [spr_idle, "RAMMR"]
        spr_shadow      = shd32;	
        spr_shadow_y	= 5;
        nts_color_blood = [make_color_rgb(96, 59, 52), c_black]
        
        // Sounds:
        snd_hurt		= global.sndRammrHurt;
        snd_dead		= global.sndRammrDead;
        snd_charge		= global.sndRammrRam;
        
        // Vars:
        mask_index  	= mskSnowBot;
        direction   	= random(360);
        maxhealth   	= 20;
       	my_health   	= maxhealth;
        raddrop     	= 4;
        maxspeed    	= 3;
        walkspeed   	= maxspeed;
        size			= 3;
        canmelee    	= 1;
        normal_damage	= 2;
        charge_damage	= 4;
        meleedamage		= normal_damage;
        team        	= 1; 
        targetvisible	= 0;
        target      	= 0;
        walk        	= 0;
        charge			= 0;
        charge_wait		= 0;
        charge_dir		= 0;
        charge_speed	= 0;
        charge_tokens	= 3;
        
        // Alarms:
        alarm1 = 20 + irandom(10);

        // Scripts:
        on_step  = script_ref_create(VesselCharger_step);
        on_draw  = BasicEnemy_draw;
        on_hurt  = Enemy_hurt;
        on_death = VesselCharger_death;
        on_alrm1 = script_ref_create(VesselCharger_alrm1);
        
        return self;
	}
	
#define VesselCharger_step

	 // Alarms:
	if("on_alrm1" in self and alarm1_run) exit;

		// Movement:
	if(walk > 0){ 
		walk	-= current_time_scale;   
		speed	+= walkspeed * current_time_scale;   
	}
	
		// Speed Cap:
	if(speed > maxspeed){ 
		speed = maxspeed; 
	}

		 // Animate:
	if(sprite_index != spr_chrg && sprite_index != spr_tell || anim_end){
		sprite_index = enemy_sprite;
	}
	
		// Charging:
	if(charge > 0 || charge_wait > 0){
		direction = charge_dir;
		enemy_look(direction);
	}
	if(charge_wait > 0){
		charge_wait -= current_time_scale;
		
		x += (orandom(1) - lengthdir_x(charge_wait / 10, charge_dir)) * current_time_scale;
		y += (orandom(1) - lengthdir_y(charge_wait / 10, charge_dir)) * current_time_scale;
		if(sprite_index != spr_hurt){
			sprite_index = spr_tell;
		}
		
		 // Start Charge:
		if(charge_wait <= 0){
			sound_play_pitch(snd_charge, 0.9 + random(0.2));
		}
	}
	else if(charge > 0){
		
		 // SLOW DOWN ! 
		charge_speed -= (0.25 * current_time_scale);
		if(charge_speed <= 0){
			meleedamage	= normal_damage;
			charge		= 0;
		}
		
		 // MOVE!:
		motion_add(direction, charge_speed);
		enemy_look(direction);
		
		 // Sprite:
		if(sprite_index != spr_hurt){
			sprite_index = spr_chrg;
		}
		
		 // Dust:
		with(instance_create(x, y, Dust)){
			sprite_index	= global.sprWhiteSmoke;
			image_xscale	= 0.5;
			image_yscale	= image_xscale;
		}

		 // Wall Bounce:
		if(place_meeting(x + hspeed_raw, y + vspeed_raw, Wall)){
			meleedamage		= normal_damage;
			charge_speed	= 0;
			charge			= 0;
			
			with(instance_create(x, y, PortalClear)){
				image_xscale	= 0.8;
				image_yscale	= 0.8;
			}
			
			sound_play_pitch(sndBouncerBounce, 0.7 + random(0.1))
			instance_create(x, y, Dust);
		}
	}
	
		//Use Your Eyes:
	right = (direction + 270) mod 360 > 180 ? 1 : -1;

#define VesselCharger_alrm1
	alarm1 = 20 + irandom(10);

	if(enemy_target(x, y) && target_visible) {
		if(target_distance > 144){
			 // Move Towards Target
			if(chance(2, 3)){
				enemy_walk(target_direction + random_range(-20, 20), alarm1);
			}			
		} else {
			if(chance(3, 4)){
				if(charge_tokens > 0){
					charge_tokens	-= 1;
					meleedamage		= charge_damage;
					charge			= 20;
					charge_wait 	= 7;
					charge_dir		= target_direction;
					charge_speed	= 6;
					alarm1      	= (charge + charge_wait) + 5;
				} else {
					alarm1 = 45 + irandom(10);
					enemy_walk(target_direction + 180 + random_range(-20, 20), alarm1);
					charge_tokens	+= 3;
				}
			}
		}
	}
	
	 // Wander Around Town:
	else{
		enemy_walk(random(360), alarm1);
		enemy_look(direction);
	}
	
#define VesselCharger_death
	pickup_drop(45, 8)

#define VesselCharger_spawn(_x, _y)
	with(VesselCharger_create(_x, _y)){
		alarm1 = 40 + irandom(10);
		with Voltergeist_create(x, y){
			possess_target	= other;
			possessing		= true;
			depth			= -2;
			image_alpha		= 0;
			image_angle 	= 0;
			mask_index		= mskNone;
			possessionCreds -= 1;
		}
	}
	
#define Cremator_create(_x, _y)
	with instance_create(_x, _y, CustomEnemy){
   
    	name = "Cremator"
    	
         // Visuals: 
        spr_idle		= global.sprCrematorIdle;
		spr_walk		= global.sprCrematorWalk;
		spr_hurt		= global.sprCrematorHurt;
		spr_dead		= global.sprCrematorDead;
		spr_fire		= global.sprCrematorFire;
		spr_idle_pos	= global.sprCrematorPossessedIdle;
		spr_walk_pos	= global.sprCrematorPossessedWalk;
		spr_fire_pos	= global.sprCrematorPossessedFire;
		sprite_index    = spr_idle;
		image_speed     = 0.4;
		depth           = -2;
		hitid           = [spr_idle, "CREMATOR"]
        spr_shadow      = global.shdCremator;	
        spr_shadow_y	= 5;
        fr_glow			= [32, 48];
        nts_color_blood = [make_color_rgb(96, 59, 52), c_black]
        
         // Sounds:
        snd_hurt		= global.sndCrematorHurt;
        snd_dead		= global.sndCrematorDead;
        
         // Vars:
        mask_index  	= global.mskCremator;
        direction   	= random(360);
        maxhealth   	= 20;
       	my_health   	= maxhealth;
        raddrop     	= 4;
        maxspeed    	= 3;
        walkspeed   	= maxspeed;
        size			= 1;
        canmelee    	= 1;
        meleedamage		= 2;
        team        	= 1; 
        targetvisible	= 0;
        target      	= 0;
        walk        	= 0;
        gunangle		= 0;
        ammo			= 0;
        possessed		= false;
        firing			= 0;
        spd				= 0;
        fr_possessable	= true;
        fr_possessed	= false;
        
         // Alarms:
        alarm1 = 45 + irandom(10);

         // Scripts:
        on_step  = script_ref_create(Cremator_step);
        on_draw  = BasicEnemy_draw;
        on_hurt  = Enemy_hurt;
        on_death = Cremator_death;
        on_alrm1 = script_ref_create(Cremator_alrm1);
        on_possessed	= script_ref_create(Cremator_possessed)
        
        if(possessed){
        	spr_idle = spr_idle_pos;
        	spr_walk = spr_walk_pos;
        	spr_fire = spr_fire_pos;
			hitid    = [spr_idle, "CREMATOR"]
			maxspeed += 1;
        }
        
        return self;
	}

#define Cremator_step

	 // Alarms:
	if("on_alrm1" in self and alarm1_run) exit;

	 // Movement:
	if(walk > 0){ 
		walk -= current_time_scale;   
		speed += walkspeed * current_time_scale;   
		gunangle = direction; 
	}
	if(speed > maxspeed){ 
		speed = maxspeed; 
	}
	
	 // Animate:
	if(sprite_index != spr_fire || anim_end){
		sprite_index = enemy_sprite;
	}
	if(firing > 0){
		if(sprite_index != spr_hurt){
			sprite_index = spr_fire;
		}
	}	
	right = (gunangle + 270) mod 360 > 180 ? 1 : -1;

#define Cremator_alrm1
	alarm1 = 40 + irandom(20) - (possessed * 12);

	 // Attacking:
	if(ammo > 0){
		alarm1 = 2;
		
		spd += 0.8;
		
    	 // Sound:
    	sound_play_pitch(sndFireShotgun, 0.6 + random(0.2));
    	sound_play_pitch(sndFireballerFire, 1.4 + random(0.2));
    				
    	 // Projectiles:
   		with CrematorProjectile_create(x, y, possessed){
   			direction   	= other.gunangle + orandom(15);
   			speed			= (3 + other.spd)
   			image_angle 	= direction;
   			team        	= other.team;
   			OGteam			= other.team;
   			creator 		= other;
    		hitid			= other.hitid;
   		}
   		
    	repeat(irandom(2)){
    		with(instance_create(x, y, TrapFire)){
    			if(other.possessed = true){
    				sprite_index = sprFireLilHunter;
    			}
    			direction   	= other.gunangle + orandom(25);
    			speed			= 2 + random(2);
    			image_angle 	= direction;
    			team        	= other.team;
    			OGteam			= other.team;
    			creator 		= other;
    			hitid			= other.hitid;
    		}
    	}
    	
    	
    	 // Effects:
		repeat(2){
			with instance_create(x + lengthdir_x(16, other.gunangle), y + lengthdir_y(16, other.gunangle), Smoke){
				motion_add(other.gunangle + orandom(5), 2 + random(3));
				image_xscale	= 0.5 + random(0.5);
				image_yscale	= image_xscale;
			}
		}
    				
		 // End Attack:
		if(--ammo <= 0){
			image_index	= 8;
			alarm1	= 20 + irandom(20) - (possessed * 10);
			firing	= 0;
			spd		= 0;
		}
	} 
	
	 // Normal:
	else{
		if(enemy_target(x, y) && target_visible){
			enemy_look(target_direction);
		
				// GET YOU:
			if(target_distance > 112 && chance(3, 4)){
				alarm1 = 30 + irandom(15);
				enemy_walk(target_direction + orandom(30), alarm1);
			}
			 // If in range:
			if(target_distance < 160){
			
				 // Start Attack:
				if(chance(4, 5)){
					sound_play_pitch(sndSalamanderCharge, 1.6)
					instance_create(x, y + 4, AssassinNotice)
					
					walk			= 0;
					gunangle		= target_direction;
					direction		= target_direction;
 					alarm1			= 14;
					ammo			= 6;
					firing			= 1;
					spd				= 0;
					
				} else {
					enemy_walk(random(360), 20);
					enemy_look(direction);	
				}
			}
		}
	
	    // Wander Around Town:
	    else{
		    if(chance(2, 3)){
			    enemy_walk(random(360), alarm1 - 10);
			    enemy_look(direction);
		    }
		}
	}

#define Cremator_death
	pickup_drop(22, 15);

#define Cremator_possessed
	possessed	= true;
    spr_idle	= spr_idle_pos;
    spr_walk	= spr_walk_pos;
    spr_fire	= spr_fire_pos;
	hitid   	= [spr_idle, "CREMATOR"]
	maxspeed	+= 1;
	
	sound_play_pitchvol(sndSwapCursed, 0.6 + random(0.1), 1)
	
	 // FX:
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
	
#define GraveyardAssassin_create(_x, _y)
	with(instance_create(_x, _y, MeleeBandit)){
		spr_idle	= global.sprSnowAssassinIdle;
		spr_walk	= global.sprSnowAssassinWalk;
		spr_hurt	= global.sprSnowAssassinHurt;
		spr_dead	= global.sprSnowAssassinDead;
		hitid		= [spr_idle, "ASSASSIN"];
		
		return self;
	}

//#endregion
//#region ROBOCENTER ENEMIES
#define Swarmbot_create(_x, _y)
	with instance_create(_x, _y, CustomEnemy){
   
    	name = "Swarmer"
    	
         // Visuals: 
        spr_idle		= global.sprSwarmBotIdle;
		spr_walk		= global.sprSwarmBotWalk;
		spr_hurt		= global.sprSwarmBotHurt;
		spr_dead		= global.sprSwarmBotDead;
		spr_launched	= global.sprSwarmBotFired;
		spr_tell		= global.sprSwarmBotChrg;
		spr_chrg		= global.sprSwarmBotChrg;
		sprite_index    = spr_idle;
		image_speed     = 0.4;
		depth           = -2;
		hitid           = [spr_idle, "SWARMER"]
        spr_shadow      = shd24;	
        spr_shadow_y	= -3;
        nts_color_blood = [make_color_rgb(96, 59, 52), c_black];
        
         // Sounds:
        snd_hurt		= global.sndSwarmerHurt;
        snd_dead		= global.sndSwarmerDead;
        snd_chrg		= global.sndSwarmerCharge;
        snd_chrg2		= global.sndSwarmerCharge2;
        snd_chrg3		= global.sndSwarmerCharge3;
        
         // Vars:
        mask_index  	= mskFreak;
        direction   	= random(360);
        maxhealth   	= 9;
       	my_health   	= maxhealth;
        raddrop     	= 2;
        maxspeed    	= 3.5;
        walkspeed   	= maxspeed;
        size			= 1;
        canmelee    	= 1;
        meleedamage		= 2;
        team        	= 1; 
        targetvisible	= 0;
        target      	= 0;
        walk        	= 0;
        launched		= false;
        launchAngle		= 0;
        launchspeed		= 10;
        commander		= false;
        myCommander		= noone;
        commanderMaxDis = 48;
        commAvailable	= false;
        charge_tokens	= 0;
        charge			= 0;
        charge_wait		= 0;
        charge_dir		= 0;
        attackZone		= [10016, 10016];
        charge_speed	= 0;
        fr_possessable	= true;
        fr_possessed	= false;
        dropPercent 	= 14; // pickup drops, changeable for roboboss ones.
        
         // Alarms:
        alarm1 = 20 + irandom(10);

         // Events:
        on_step  = script_ref_create(Swarmbot_step);
        on_draw  = BasicEnemy_draw;
        on_hurt  = Enemy_hurt;
        on_death = Swarmbot_death;
        on_alrm1 = script_ref_create(Swarmbot_alrm1);
        on_possessed	= script_ref_create(Swarmbot_possessed);
        
         // Controller:
 		if(array_length(instances_matching(CustomObject, "name", "fr_SwarmbotController")) = 0){
			SwarmbotController_create(10016, 10016);
    	}
        
        return self;
	}
	
#define Swarmbot_step
	
	 // Alarms:
	if("on_alrm1" in self and alarm1_run) exit;

		// Movement:
	if(walk > 0){ 
		walk	-= current_time_scale;   
		speed	+= walkspeed * current_time_scale;   
	}
	
		// Speed Cap:
	if(speed > maxspeed){ 
		speed = maxspeed; 
	}
	
		 // Animate:
	if(sprite_index != spr_chrg && sprite_index != spr_launched || anim_end){
		sprite_index = enemy_sprite;
	}
	
		// Charging:
	if(charge > 0 || charge_wait > 0){
		direction = charge_dir;
		enemy_look(direction);
	}
	if(charge_wait > 0){
		charge_wait -= current_time_scale;
		
		x += (orandom(1) - lengthdir_x(charge_wait / 10, charge_dir)) * current_time_scale;
		y += (orandom(1) - lengthdir_y(charge_wait / 10, charge_dir)) * current_time_scale;
		if(sprite_index != spr_hurt){
			sprite_index = spr_chrg;
		}
		
		 // Start Charge:
		if(charge_wait <= 0){
			
			
			/* doing it this way makes the sounds not cut eachother out, which is nice in small numbers but deafening when theres a lot of them.
			var _sound = audio_play_sound(choose(snd_chrg, snd_chrg2, snd_chrg3), 0, 0);
			audio_sound_pitch(_sound, 0.8 + random_nonsync(0.2));
			audio_sound_gain(_sound, 0.7 + random_nonsync(0.15), 0);
			*/
			
			//sound_play_pitch(choose(snd_chrg, snd_chrg2, snd_chrg3), 0.8 + random(0.2));
			
			// using sound play hit makes it 3d. not sure if ill keep it that or not.
			sound_play_hit_ext(choose(snd_chrg, snd_chrg2, snd_chrg3), 0.8 + random(0.2), 1);

		}
	}
	else if(charge > 0){
		charge -= current_time_scale;
		
		 // SLOW DOWN ! 
		charge_speed -= (0.2 * current_time_scale);
		if(charge_speed <= 0){
			charge = 0;
		}
		
		 // MOVE!:
		motion_add(direction, charge_speed);
		enemy_look(direction);
		
		 // Sprite:
		if(sprite_index != spr_hurt){
			sprite_index = spr_chrg;
		}
		
		 // Particles:
		if(random(5) < 1){
			with(instance_create(x, y, Dust)){
				depth		= other.depth + choose(-1, 1);
				direction	= random(360);
				speed		= 2 + random(2);
			}
		}
	}
	
	 // Launched Behavior:
	if(launched){
		alarm1			= 20;
		maxspeed		= launchspeed;
		sprite_index	= spr_launched;
		direction		= launchAngle;
		speed			= launchspeed;
		
		 // Particles:
		if(current_frame_active){
			with(instance_create(x, y, Smoke)){ 
				sprite_index	= global.sprWhiteSmoke; 
				image_xscale	= 0.5; 
				image_yscale	= image_xscale; 
				growspeed		= -0.08; 
				image_alpha		= 0.80;
			} 
		}
		
		 // Stop Launch:
		if(place_meeting(x + hspeed_raw, y + vspeed_raw, Wall)) || (place_meeting(x, y, Player)) || (my_health < maxhealth){
			sound_play_pitch(sndMeleeWall, 1.2 + random(0.2));
			sound_play_pitch(sndBouncerBounce, 1.3 + random(0.1))
			
	    	 // Particles:
			with(instance_create(x, y, ImpactWrists)){ 
				depth = -3; 
			}
			repeat(5){ 
				with instance_create(x, y, Dust){ 
					direction	= random(360); 
					speed		= 4; 
				} 
			}
			repeat(2){
				with(instance_create(x, y, Debris)){
					sprite_index	= global.sprSwarmerEggDebris;
					mask_index		= mskNone;
					speed			= 2;
				}
			}
			
			image_angle = 0;
			launched	= 0;
			spr_shadow	= shd24;
			maxspeed	= walkspeed;
		}
	}
	
		// Swarming Behavior:
	if(commander = true){
		 // Check if full and recruit nearest if not:
		if(array_length(instances_matching(instances_matching(enemy, "name", "Swarmer"), "myCommander", self)) >= 4){
			commAvailable = false;
    	} else {
    		commAvailable = true;
    		var _nearestRecruit = call(scr.instance_nearest_array, x, y, instances_matching(instances_matching(enemy, "name", "Swarmer"), "myCommander", noone))
 			if(instance_exists(_nearestRecruit)){
 				with(_nearestRecruit){
					myCommander = other;			
 				}
 			}
    	}
	}
	
		//Use Your Eyes:
	right = (direction + 270) mod 360 > 180 ? 1 : -1;

#define Swarmbot_alrm1
	alarm1 = 10 + irandom(5);
	
	 // Normal Behavior:
	if(commander = false){
		if(charge_tokens <= 0){
			if(instance_exists(myCommander)){
				 // Stay by commander:
				if(distance_to_object(myCommander) > commanderMaxDis){
					direction = point_direction(x, y, myCommander.x, myCommander.y)
					enemy_walk(direction, alarm1);
				} else {
					 // Stroll Around when Idle:
					if(chance(1, 2)){
						direction = random(360);
						enemy_walk(direction, alarm1);
					}				
				}
			}
		} else {
			charge_tokens -= 1;
			charge			= 8;
			charge_dir		= point_direction(x, y, attackZone[0], attackZone[1]);
			charge_wait 	= 2;
			charge_speed	= 4;
			alarm1      	= (charge + charge_wait) + 5;
			
			if(charge_tokens <= 0){
				alarm1 = 30;
			}
		}
		
		
		// Commander Behavior:
	} else {
		 // Approach Target:
		if(charge_tokens <= 0){
			if(enemy_target(x, y) && target_visible){
				if(target_distance > 72){
					 // Move Towards Target:
					if(chance(3, 4)){
						enemy_walk(target_direction + random_range(-20, 20), alarm1);
					}			
					// Start Attacking:
				} else {
					if(chance(4, 5)){
						attackZone		= [target.x, target.y];
						charge_tokens	= 3 + irandom(2);
						
						with(instances_matching(instances_matching(enemy, "name", "Swarmer"), "myCommander", self)){
							charge_tokens	= other.charge_tokens
							attackZone		= other.attackZone;
						} 
						
						charge			= 8;
						charge_dir		= point_direction(x, y, attackZone[0], attackZone[1]);
						charge_wait 	= 2;
						charge_speed	= 5;
						alarm1      	= (charge + charge_wait) + 5;
					}
				}
			}
			else {
				 // Stroll Around when Idle:
				if(chance(1, 2)){
					direction = random(360);
					enemy_walk(direction, alarm1);
				}
			}
		} else {
			charge_tokens -= 1;
			charge			= 8;
			charge_dir		= point_direction(x, y, attackZone[0], attackZone[1]);
			charge_wait 	= 2;
			charge_speed	= 5;
			alarm1      	= (charge + charge_wait) + 5;
			
			if(charge_tokens <= 0){
				alarm1 = 30;
			}
		}
	}
	
#define Swarmbot_death
	pickup_drop(dropPercent, 0);
	if(commander = true){
		with(instances_matching(instances_matching(enemy, "name", "Swarmer"), "myCommander", self)){
			myCommander	= noone;
		}
	}
	
#define Swarmbot_possessed
	 // Status Effect:
	mod_script_call('mod', 'Frontier_StatusEffects', 'status_apply_set', self, mod_variable_get('mod', 'Frontier_StatusEffects', 'buffVoltergeist'), 1/0);
	
	 // Apply Sprites:
	spr_idle	= global.sprSwarmBotPossessedIdle;
	spr_walk	= global.sprSwarmBotPossessedWalk;
	spr_chrg	= global.sprSwarmBotPossessedChrg;
	hitid		= [spr_idle, "POSSESSED#SWARMER"];
	
	 // give them speed boost why not
	maxspeed	+= 1.5;

	 // Particles:
	repeat(6){
		with(instance_create(x, y, BulletHit)){
			var _variant	= irandom(4);	 
			sprite_index	= global.sprVoltergeistLightning[_variant];
			depth			= -3;
			direction		= random(360);
			speed			= 2 + random(2);
		}
	}
	repeat(6){
		with(instance_create(x, y, Dust)){
			sprite_index	= global.sprVoltergeistDust;
			depth			= -3;
			direction		= random(360);
			speed			= 2 + random(2);
		}
	}
					
#define SwarmbotController_create(_x, _y)
	with(instance_create(_x, _y, CustomObject)){
		name		= "fr_SwarmbotController";
		
		on_step 	= SwarmbotController_step;
		
		return self;
	}
	
#define SwarmbotController_step
	if(array_length(instances_matching(instances_matching(enemy, "name", "Swarmer"), "commAvailable", true)) <= 0){
		with(call(scr.instance_random, instances_matching(instances_matching(enemy, "name", "Swarmer"), "myCommander", noone))){
			commander	= true;
			myCommander = self;
		}
	}
	
#define Swarmbot_spawn(_x, _y)
	with(Swarmbot_create(_x, _y)){
		repeat(3){
			Swarmbot_create(x, y);
		}
	}
	
#define Engineer_create(_x, _y)
	with instance_create(_x, _y, CustomEnemy){
   
    	name = "Engineer"
    	
         // Visuals: 
        spr_idle		= global.sprEngineerIdle;
		spr_walk		= global.sprEngineerWalk;
		spr_hurt		= global.sprEngineerHurt;
		spr_dead		= global.sprEngineerDead;
		spr_weap		= global.sprEngineerCannon;
		spr_weap_melee	= global.sprEngineerWrench;
		sprite_index    = spr_idle;
		image_speed     = 0.4;
		depth           = -2;
		hitid           = [spr_idle, "ENGINEER"]
        spr_shadow      = shd24;	
        spr_shadow_y	= 1;
        nts_color_blood = [c_red, make_color_rgb(134, 44, 35)]
        
         // Sounds:
        snd_hurt		= sndNecromancerHurt;
        snd_dead		= sndNecromancerDead;
        
         // Vars:
        mask_index  	= mskBandit;
        direction   	= random(360);
        maxhealth   	= 8;
       	my_health   	= maxhealth;
        raddrop     	= 6;
        maxspeed    	= 2.5;
        walkspeed   	= maxspeed;
        size			= 1;
        canmelee    	= 0;
        meleedamage		= 0;
        team        	= 1; 
        targetvisible	= 0;
        target      	= 0;
        walk        	= 0;
        gunangle		= 0;
        wepangle		= 110;
        meleeMode		= false;
        
         // Alarms:
        alarm1 = 30 + irandom(10);
        alarm2 = 0;

         // Events:
        on_step  = script_ref_create(Engineer_step);
        on_draw  = Engineer_draw;
        on_hurt  = Enemy_hurt;
        on_death = Engineer_death;
        on_alrm1 = script_ref_create(Engineer_alrm1);
        on_alrm2 = script_ref_create(Engineer_alrm2);
        
        return self;
	}

#define Engineer_step

	 // Alarms:
	if("on_alrm1" in self and alarm1_run) exit;
	if("on_alrm2" in self and alarm2_run) exit;

	 // Movement:
	if(walk > 0){ 
		walk -= current_time_scale;   
		speed += walkspeed * current_time_scale;   
		gunangle = direction; 
	}
	if(speed > maxspeed){ 
		speed = maxspeed; 
	}
	
	 // Switch Modes:
	if(distance_to_object(target) < 60 && target_visible){
		if(meleeMode = false){
			meleeMode = true
			instance_create(x + lengthdir_x(12, gunangle), y + lengthdir_y(12, gunangle), WepSwap);
			sound_play_pitchvol(sndSwapHammer, 1, 0.6);
		}
		if(random(5) < 1){
			instance_create(x, y, Sweat);
		}
	} else {
		if(meleeMode = true){
			meleeMode = false;
			instance_create(x + lengthdir_x(12, gunangle), y + lengthdir_y(12, gunangle), WepSwap);
			sound_play_pitchvol(sndSwapExplosive, 1, 0.6);
		}
	}
	
	 // Animate:
	sprite_index = enemy_sprite;
	right = (gunangle + 270) mod 360 > 180 ? 1 : -1;
	
#define Engineer_alrm1
	alarm1 = 40 + irandom(20);

	 
	if(enemy_target(x, y) && target_visible){
		enemy_look(target_direction);
		
		 // Gun:
		if(meleeMode = false){
			if(target_distance > 192){
				alarm1 = 30 + irandom(15);
				enemy_walk(target_direction + orandom(30), alarm1 - 10);
			} else {
				
				 // Attack:
				if(chance(2, 3) && (target_distance > 60)){
					alarm1 = 100 + irandom(20);

					gunangle = target_direction;
			
		    		 // Sound:
		    		sound_play_pitch(sndGrenadeRifle, 1.3 + random(0.2));
		    			
		    		 // Kick:
		    		wkick = 12;
		    
		    		 // Projectile:
		    		with Swarmbot_create(x, y){
		    			launchAngle		= other.gunangle;
		    			image_angle 	= launchAngle;
		    			team        	= other.team;
		    			creator 		= other;
		    			launched		= true;
		    			kills			= 0;
		    			raddrop			= 0;
		    			spr_shadow		= mskNone;
		   			}    
	    			 // Particles:
					repeat(12){
						with instance_create(x + lengthdir_x(10, other.gunangle), y + lengthdir_y(10, other.gunangle), Smoke){
							sprite_index	= global.sprWhiteSmoke;
							image_xscale    = 0.2 + random_range(0.1, 0.5);
							image_yscale    = image_xscale;
							motion_add(other.gunangle + random_range(-10, 10), 2 + random(2)) 
						}
					}
				}
				// Move Away From Target:
				else{
					alarm1 = 40 + irandom(15);
					enemy_walk(gunangle + 180 + orandom(30), alarm1 - 10);
				}
			}			
		}
		
		 // Melee:
		else{
			
				// If in range:
			if(target_distance < 60){
				
				// Attack:
				if(chance(2, 3) && target_distance > 4){
					alarm1 = 50 + irandom(15);
					instance_create(x, y, AssassinNotice)
					alarm2   = 10;
					gunangle = target_direction;
					enemy_look(target_direction);
				}
				
				 // Move Away From Target:
				else{
					alarm1 = 30 + irandom(15);
					enemy_walk(gunangle + 180 + orandom(30), alarm1 - 10);
				}
			}
		}
	} else {
		 // Wander:
		if(chance(1, 3)){
			alarm1 = 40 + irandom(15);
			enemy_walk(random(360), alarm1 - 10);
			enemy_look(direction);
		}
	}

#define Engineer_alrm2
	with instance_create(x, y, EnemySlash){
		damage		= 3;
		speed		= 2;
		direction	= other.gunangle + random_range(-3, 3);
		image_angle = direction;
		creator		= other;
		team		= other.team
		hitid		= other.hitid;
	}
	motion_add(gunangle, 3.5);
	wkick	 = -4;
	wepangle *= -1;
	sound_play(sndAssassinAttack);
	sound_play_pitch(sndWrench, 0.7 + random(0.3));	

#define Engineer_draw
	if(meleeMode = false){
		if(gunangle < 180){ 
			draw_sprite_ext(spr_weap, 0, x + lengthdir_x(-wkick, gunangle), y + lengthdir_y(-wkick, gunangle), 1, right, gunangle, image_blend, image_alpha);
		} 
		draw_sprite_ext(sprite_index, image_index, x, y, image_xscale * right, image_yscale, image_angle, image_blend, image_alpha); 
		if gunangle >= 180{ 
			draw_sprite_ext(spr_weap, 0, x + lengthdir_x(-wkick, gunangle), y + lengthdir_y(-wkick, gunangle), 1, right, gunangle, image_blend, image_alpha);
		}	
	}
	else{
		if(gunangle <= 180){
			draw_weapon(spr_weap_melee, 0, x, y, gunangle, wepangle, wkick, 1, image_blend, image_alpha);		
		}
		draw_sprite_ext(sprite_index, image_index, x, y, image_xscale * right, image_yscale, image_angle, image_blend, image_alpha); 
		if(gunangle >  180){ 
			draw_weapon(spr_weap_melee, 0, x, y, gunangle, wepangle, wkick, 1, image_blend, image_alpha);	
		}
	}
	
#define Engineer_death
	pickup_drop(55, 0)
	
#define MissileDrone_create(_x, _y)
	with instance_create(_x, _y, CustomEnemy){
   
    	name = "Bombardier"
    	
         // Visuals: 
        spr_idle		= global.sprMissileDroneIdle;
		spr_walk		= global.sprMissileDroneWalk;
		spr_hurt		= global.sprMissileDroneHurt;
		spr_dead		= global.sprMissileDroneDead;
		sprite_index    = spr_idle;
		image_speed     = 0.4;
		depth           = -2;
		hitid           = [spr_idle, "BOMBARDIER"]
        spr_shadow      = global.shdMissileDrone;	
        spr_shadow_y	= 0;
        nts_color_blood = [make_color_rgb(96, 59, 52), c_black]
        
         // Sounds:
        snd_hurt		= global.sndBombardierHurt;
        snd_dead		= global.sndBombardierDead;
        snd_fire		= global.sndBombardierFire;
        
         // Vars:
        mask_index  	= global.mskMissileDrone;
        direction   	= random(360);
        maxhealth   	= 20;
       	my_health   	= maxhealth;
        raddrop     	= 4;
        maxspeed    	= 3;
        walkspeed   	= maxspeed;
        size			= 2;
        canmelee    	= 0;
        meleedamage		= 0;
        team        	= 1; 
        targetvisible	= 0;
        target      	= 0;
        walk        	= 0;
        gunangle		= 0;
        ammo			= 0;
        laserAngle		= 0;
        fr_possessable	= true;
        fr_possessed	= false;
        
         // Alarms:
        alarm1 = 50 + irandom(10);
        alarm2 = 0;

         // Scripts:
        on_step  = script_ref_create(MissileDrone_step);
        on_draw  = MissileDrone_draw;
        on_hurt  = Enemy_hurt;
        on_death = MissileDrone_death;
        on_alrm1 = script_ref_create(MissileDrone_alrm1);
        on_alrm2 = script_ref_create(MissileDrone_alrm2);
        on_possessed	= script_ref_create(MissileDrone_possessed);
        
        return self;
	}

#define MissileDrone_step

	 // Alarms:
	if("on_alrm1" in self and alarm1_run) exit;
	if("on_alrm2" in self and alarm2_run) exit;

	 // Movement:
	if(walk > 0){ 
		walk -= current_time_scale;   
		speed += walkspeed * current_time_scale;   
		gunangle = direction; 
	}
	if(speed > maxspeed){ 
		speed = maxspeed; 
	}
	
	 // Animate:
	sprite_index = enemy_sprite;
	right = (gunangle + 270) mod 360 > 180 ? 1 : -1;
	
	 // Lasersight:
	if(laserAngle < 6){ 
		laserAngle += current_time_scale; 
	}

#define MissileDrone_alrm1
	alarm1 = 40 + irandom(30);

	if(enemy_target(x, y) && target_visible){
		if(alarm2 <= 0){
			enemy_look(target_direction);
			
				// Move Away From Target:
			if(target_distance < 48){
				alarm1 = 10 + irandom(10);
				enemy_walk(target_direction - 180 + orandom(30), alarm1 - 5);
			}
			
				// Move Towards target when too far away:
			if(target_distance > 272){
				alarm1 = 20 + irandom(15);
				enemy_walk(target_direction + orandom(30), alarm1 - 5);
			} else {
				 // If in range:
				 // Attack:
				 // Not too close!
				if(chance(4, 5)){
					if((target_distance > 48)){
						alarm1		= 90 + irandom(20);
						gunangle	= target_direction;
						
						// ENGAGE LASER:!
						alarm2		= 25;
						laserAngle	= 0;
						ammo		= 6;
						enemy_face(gunangle);
						walk		= 0;
						
						sound_play_pitch(sndSniperTarget,	0.5 + random(0.3));
						sound_play_pitch(sndIDPDNadeAlmost, 0.5 + random(0.3));
					}
				} else {
					if chance(2, 3){
						alarm1 = 30 + irandom(25);
						enemy_walk(random(360), alarm1 - 5);
					}				
				}
			}	
		}
	}
	
	 // Wander Around Town:
	else{
		if(chance(3, 5) && (alarm2 <= 0)){
			direction = random(360);
			enemy_walk(direction, alarm1);
		}
	}
	
#define MissileDrone_alrm2
	 // Attacking:
	if(ammo > 0){
		alarm2 = 1;
		
    	 // Sound:
    	sound_play_pitchvol(sndRocket,	1.1 + random(0.2), 0.75);
		var _sound = audio_play_sound(snd_fire, 0, 0);
		audio_sound_pitch(_sound, 0.75 + random_nonsync(0.25));
		audio_sound_gain(_sound, 0.3 + random_nonsync(0.15), 0);
    				
    	 // Projectiles:
		with(LabsRocket_create(x, y)){
			team	    = other.team
			direction   = other.gunangle + random_range(-10, 10)
			image_angle = direction
			hitid		= other.hitid;
		}
   		
   		 // Effects:
		with instance_create(x, y + 5, Smoke){
			depth			= (other.depth - 1);
			direction		= other.gunangle;
			speed			= random(3);
		}
    				
		 // End Attack:
		if(--ammo <= 0){
			alarm1	= 100 + irandom(20);
		}
	}
	
#define MissileDrone_draw
	draw_sprite_ext(sprite_index, image_index, x, y, image_xscale * right, image_yscale, image_angle, image_blend, image_alpha);
	
	if(alarm2 > 0){
		draw_set_color(make_color_rgb(250, 54, 0));
		call(scr.draw_lasersight, x, y, gunangle, 1000, 2);
		draw_set_alpha(0.5);
		call(scr.draw_lasersight, x, y, gunangle + laserAngle / 1.5, 1000, 1);
		call(scr.draw_lasersight, x, y, gunangle - laserAngle / 1.5, 1000, 1);
		draw_set_color(c_white);
		draw_set_alpha(1)
	}

#define MissileDrone_death
	pickup_drop(40, 15);
	
#define MissileDrone_possessed
	 // Status Effect:
	mod_script_call('mod', 'Frontier_StatusEffects', 'status_apply_set', self, mod_variable_get('mod', 'Frontier_StatusEffects', 'buffVoltergeist'), 1/0);
	
	 // Apply Sprites:
	spr_idle	= global.sprMissileDronePossessedIdle;
	spr_walk	= global.sprMissileDronePossessedWalk;
	hitid		= [spr_idle, "POSSESSED#BOMBARDIER"];
	
	 // give them speed boost why not
	maxspeed	+= 1;
	
	 // Particles:
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

#define Honeypot_create(_x, _y)
	with(instance_create(_x, _y, CustomEnemy)){
   
    	name = "Honeypot"
    	
         // Visuals: 
        image_blend		= c_red;
        spr_idle		= sprBigMaggotIdle;
		spr_walk		= sprBigMaggotIdle;
		spr_hurt		= sprBigMaggotHurt;
		spr_dead		= sprBigMaggotDead;
		sprite_index    = spr_idle;
		image_speed     = 0.4;
		depth           = -2;
		hitid           = [spr_idle, "HONEYPOT"]
        spr_shadow      = global.shdCremator;	
        spr_shadow_y	= 5;
        nts_color_blood = [make_color_rgb(96, 59, 52), c_black]
        
         // Sounds:
        snd_hurt		= sndTurretHurt;
        snd_dead		= sndTurretDead;
        
         // Vars:
        mask_index  	= mskBigMaggot;
        direction   	= random(360);
        maxhealth   	= 20;
       	my_health   	= maxhealth;
        raddrop     	= 4;
        maxspeed    	= 3.5;
        walkspeed   	= maxspeed;
        size			= 2;
        canmelee    	= 1;
        meleedamage		= 1;
        team        	= 1; 
        targetvisible	= 0;
        target      	= 0;
        walk        	= 0;
		healingRange	= 64;
		healCooldown	= 75;
        
         // Alarms:
        alarm1 = 20 + irandom(10);
        alarm2 = 0;

         // Scripts:
        on_step  = script_ref_create(Honeypot_step);
        on_draw  = BasicEnemy_draw;
        on_hurt  = Enemy_hurt;
        on_death = Honeypot_death;
        on_alrm1 = script_ref_create(Honeypot_alrm1);
        
         // Spawn Controller:
	if(array_length(instances_matching(CustomObject, "name", "fr_HoneypotController")) = 0){
    	HoneypotController_create(10016, 10016);
     }

        return self;
	}
	
#define Honeypot_step

	 // Alarms:
	if("on_alrm1" in self and alarm1_run) exit;

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
	right = (direction + 270) mod 360 > 180 ? 1 : -1;
	
	 // Wounded in Range:
	var _woundedNearMe = call(scr.instances_in_rectangle, x - healingRange, y - healingRange, x + healingRange, y + healingRange, instances_matching(enemy, "fr_Wounded", true));
	if(array_length(_woundedNearMe) > 0){	
		 // Heal Cooldown Timer:
		if(healCooldown > 0){
			healCooldown -= current_time_scale;
		}
		
		 // Heal Nearby Wounded Enemies:
		if(healCooldown <= 0){
			healCooldown += 75;
			with(_woundedNearMe){
				 // Heal Based on Max Hp:
				my_health += round(maxhealth / 5);
				if(my_health > maxhealth){
					my_health = maxhealth; // if this messes with someones overheal mechanic sorry but u should have also changed maxhealth I think
				}
				 
				 // FX:
				with(instance_create(x, y, FrogHeal)){
					sprite_index	= global.sprHoneypotHeal
					depth			= other.depth - 1;
					creator 		= other;
				}
			}
		}
		 // Tether FX:
		with(_woundedNearMe){
			if(random(5) < 1){
				HoneypotHealParticle_create(other.x + orandom(16), other.y + orandom(16), self);
			}
		}
	}

#define Honeypot_alrm1
	alarm1 = 15 + irandom(10);
	
	var _nearestWounded = call(scr.instance_nearest_array, x, y, instances_matching(instances_matching(enemy, "team", team), "fr_Wounded", true))
	
	if(!instance_exists(_nearestWounded)){
		if(chance(2, 3)){
		    enemy_walk(random(360), alarm1 - 10);
		    enemy_look(direction);
	    }
	} else {
		target = _nearestWounded;
		if(target_visible) && (target_distance > healingRange - (healingRange / 3)){
			enemy_look(target_direction);
			if(chance(4, 5)){
				enemy_walk(target_direction + orandom(30), alarm1 - 5);
			}
		} else {
		    if(chance(2, 3)){
			    enemy_walk(random(360), alarm1 - 10);
			    enemy_look(direction);
		    }			
		}
	}

#define Honeypot_death

	 // FX:
	repeat(5){
		with(instance_create(x, y, BloodStreak)){
			sprite_index	= sprBloodStreak;
			speed			= 1 + random(2);
			direction		= random(360);
		}
	}
	
	 // Splash:
	HoneypotHealSplash_create(x, y)

#define HoneypotController_create(_x, _y)
	with(instance_create(_x, _y, CustomObject)){
		name			= "fr_HoneypotController";
		on_step			= HoneypotController_step;
	}
	
#define HoneypotController_step
	with(instances_matching_ne(enemy, "name", "Honeypot")){
		if(my_health < maxhealth){
			fr_Wounded = true;
		} else {
			fr_Wounded = false;
		}
	}
	
//#endregion
//#region FREAK SHELLS
#define FreakShell_create(_x, _y)
	with(instance_create(_x, _y, CustomHitme)){
		
		name = "Freak Shell"
		
		 // Visuals:
		dir				= choose(-1, 1)
		spr_warn		= global.sprFreakShellWarning;
		spr_idle		= global.sprFreakShellFall;
		spr_land		= global.sprFreakShellIdle;
		spr_hurt		= global.sprFreakShellHurt;
		spr_dead		= sprMutantTubeDead;
		spr_opening		= global.sprFreakShellOpening
		spr_open		= global.sprFreakShellOpen;
		spr_openhurt	= global.sprFreakShellOpenHurt;
		sprite_index	= spr_idle;
		image_speed		= 0.4;
		image_angle		= random_range(30, 45) * -dir;
		image_xscale	= dir;
		depth			= -10;
		spr_shadow		= mskNone;
		hitid			= [spr_idle, "FREAK SHELL"]
		height			= 700;
		x_height		= 700 * dir;
		spr_warn_y		= 12;
		flightAngle		= image_angle;
		warnspin		= 0;
		
        //Sounds:
        snd_hurt		= sndTurretHurt;
        snd_dead		= sndTurretDead;
		
		 // Vars:
		mask_index		= mskNone;
		maxhealth		= 40;
		my_health		= maxhealth;
		size			= 3;
		freaks			= 12 + irandom(6);
		landed			= false;
		open			= false;
		FREAKED_OUT		= false;
		openTimer		= 40;
		freakTimer		= 25;
		
		 // Alarms:
		alarm1			= 0;
		
		on_step			= FreakShell_step;
		on_draw			= FreakShell_draw;
		on_hurt			= Prop_hurt;
		on_destroy		= FreakShell_destroy;
		on_alrm1		= script_ref_create(FreakShell_alrm1);
	}

#define FreakShell_step

	x = xstart;
	y = ystart;
	speed = 0;
	 
	 // Alarms:
	if("on_alrm1" in self and alarm1_run) exit;

	 // Animate:
	if(anim_end){
		sprite_index = spr_idle;
	}
	
	 // Fall Joke: 
	if(height > 0){
		warnspin += 4 * current_time_scale;
		height -= 20 * current_time_scale;
		x_height -= (20 * dir) * current_time_scale;
		
			with(instance_create(x + x_height, y - height, Smoke)){
				sprite_index	= global.sprWhiteSmoke;
				depth			= -10;
				image_xscale	= 1 + random(0.3);
				image_yscale	= image_xscale;
				image_alpha		= 0.6;
			}
	}
	 
	 // Landin:
	if(height <= 0 && landed = false){
		spr_idle	= spr_land;
		landed		= true;
		mask_index	= sprMutantTube;
		spr_shadow	= shd48;
		depth		= 0;

		repeat(5 + random(4)){
			with(instance_create(x, y, Debris)){
				direction	= random(360);
				speed		= 1 + random(4);
			}
		}
		repeat(2 + random(2)){
			instance_create(x + random_range(-18, 18), y + random_range(-10, 18), Scorch);
		}
		repeat(3 + random(2)){
			instance_create(x + random_range(-18, 18), y + random_range(-10, 18), MeltSplat);
		}
		with instance_create(x, y + 12, Explosion){
			hitid	= other.hitid;
		}
		sound_play_pitch(sndExplosionCar, 1.3 + random(0.2))
	}
	
	 // Open the Pod:
	if(landed = true && openTimer > 0){
		openTimer -= current_time_scale;
	}
	if(openTimer <= 0 && open = false){
		
		open			= true;
		sprite_index	= spr_opening;
		spr_idle		= spr_open;
		spr_hurt		= spr_openhurt;
		
		sound_play_pitchvol(sndToxicBoltGas, 0.6 + random(0.1), 0.5)
		repeat(8){
			with(instance_create(x, y, Smoke)){
				sprite_index	= global.sprWhiteSmoke;
				direction		= 90 + random(50 * -other.dir);
				speed			= 1 + random(3);
				image_alpha		= 0.8;
			}
		}
	}
	if(freakTimer > 0 && open = true){
		freakTimer -= current_time_scale;
	}
	 
	 // Holy FREAK!!
	if(open = true && FREAKED_OUT = false && freakTimer <= 0){
		FREAKED_OUT = true;
		alarm1		= 2;
	}
	
	 // DIE:
	if(!instance_exists(self)){ exit; }
	if(my_health <= 0){
		with(instance_create(x, y, Corpse)){
			sprite_index = other.spr_dead;
			image_xscale = other.image_xscale;
			size		 = other.size;
		}
		 // Goodbye:
		instance_destroy();
	}

#define FreakShell_draw
	if(height > 0){
		draw_sprite_ext(spr_warn, image_index, x, y + spr_warn_y, 1, 1, warnspin, image_blend, image_alpha)
		draw_sprite_ext(spr_warn, image_index, x, y + spr_warn_y, 1.1, 1.1, warnspin, image_blend, 0.3)
	}
	draw_sprite_ext(sprite_index, image_index, x + x_height, y - height, image_xscale, image_yscale, image_angle, image_blend, image_alpha)

#define FreakShell_destroy
	sound_play_pitch(sndExplosionL, 1.3 + random(0.2))
	with instance_create(x, y, Explosion){
		hitid	= other.hitid;
	}
	
#define FreakShell_alrm1
	if(freaks > 0){
		alarm1 = 1 + irandom(3);
		freaks -= 1;
		
		var _dir = dir;
		
		with(instance_create(x, y - 6, Freak)){
			with(mod_script_call("mod", "Frontier_Objects", "ZAxisToss_create", x, y)){
				switch(_dir){
					case 1:
						direction = 0 + random_range(-40, 40)
					break;
					case -1:
						direction = 180 + random_range(-40, 40)
					break;
				}
				speed       	= 3;
				zspeed      	= 4 + random(2);
				zfriction		= 0.7;
				creator     	= other;
				depth       	= other.depth;
				mask_index  	= other.mask_index;
				if("spr_shadow_y" in other ){
					spr_shadow_y = other.spr_shadow_y;
				}	
			}
		}
	}
	
#define RhinoFreakShell_create(_x, _y)
	with(instance_create(_x, _y, CustomHitme)){
		
		name = "Rhino Freak Shell"
		
		 // Visuals:
		dir				= choose(-1, 1)
		spr_warn		= global.sprRhinoFreakShellWarning;
		spr_idle		= global.sprRhinoFreakShellFall;
		spr_land		= global.sprRhinoFreakShellIdle;
		spr_hurt		= global.sprRhinoFreakShellHurt;
		spr_dead		= sprMutantTubeDead;
		spr_open		= global.sprRhinoFreakShellOpen;
		spr_openhurt	= global.sprRhinoFreakShellOpenHurt;
		sprite_index	= spr_idle;
		image_speed		= 0.4;
		image_angle		= random_range(25, 45) * -dir;
		image_xscale	= dir;
		depth			= -10;
		spr_shadow		= mskNone;
		hitid			= [spr_idle, "FREAK SHELL"]
		height			= 1050;
		x_height		= 1050 * dir;
		spr_warn_y		= 20;
		flightAngle		= image_angle;
		warnspin		= 0;
		
         // Sounds:
        snd_hurt		= sndTurretHurt;
        snd_dead		= sndTurretDead;
		
		 // Vars:
		mask_index		= mskNone;
		maxhealth		= 90;
		my_health		= maxhealth;
		size			= 5;
		freaks			= 5 + irandom(3);
		landed			= false;
		open			= false;
		FREAKED_OUT		= false;
		openTimer		= 40;
		freakTimer		= 25;
		
		 // Alarms:
		alarm1			= 0;
		
		on_step			= RhinoFreakShell_step;
		on_draw			= FreakShell_draw;
		on_hurt			= Prop_hurt
		on_destroy		= RhinoFreakShell_destroy;
		on_alrm1		= script_ref_create(RhinoFreakShell_alrm1);
	}
	
#define RhinoFreakShell_step

	x = xstart;
	y = ystart;
	speed = 0;
	
	 // Alarms:
	if("on_alrm1" in self and alarm1_run) exit;

	 // Animate:
	if(anim_end){
		sprite_index = spr_idle;
	}
	
	 // Fall Joke: 
	if(height > 0){
		warnspin += 4 * current_time_scale;
		height -= 30 * current_time_scale;
		x_height -= (30 * dir) * current_time_scale;
		
		repeat(3){
			with(instance_create(x + x_height + random_range(-25, 25), y - height + random_range(-25, 25), Smoke)){
				sprite_index	= global.sprWhiteSmoke;
				depth			= -10;
				image_xscale	= 1 + random(0.3);
				image_yscale	= image_xscale;
				image_alpha		= 0.6;
			}
		}
	}
	 
	 // Landin:
	if(height <= 0 && landed = false){
		spr_idle	= spr_land;
		landed		= true;
		mask_index	= global.mskRhinoFreakShell;
		spr_shadow	= shd48;
		depth		= 0;

		repeat(8 + random(4)){
			with(instance_create(x, y, Debris)){
				direction	= random(360);
				speed		= 1 + random(4);
			}
		}
		repeat(4 + random(2)){
			instance_create(x + random_range(-45, 45), y + 20 + random_range(-20, 20), Scorch);
		}
		repeat(5 + random(2)){
			instance_create(x + random_range(-45, 45), y + 20 + random_range(-20, 20), MeltSplat);
		}
		
		with(instance_create(x, y + 20, PortalClear)){
			image_xscale	= 1.5;
			image_yscale	= image_xscale;
		}
		sound_play_pitch(sndExplosionL, 0.8 + random(0.2))
		for (i = 0; i < 360; i += 72){
			with instance_create(x, y + 20, Explosion){
				hitid	= other.hitid;
			}
		}
	}
	
	 // Open the Pod:
	if(landed = true && openTimer > 0){
		openTimer -= current_time_scale;
	}
	if(openTimer <= 0 && open = false){
		
		open			= true;
		sprite_index	= spr_open;
		spr_idle		= spr_open;
		spr_hurt		= spr_openhurt;
		
		sound_play_pitch(sndToxicBoltGas, 0.6 + random(0.1))
		sound_play_pitch(sndExplosionS, 0.8 + random(0.1))
		with instance_create(x, y, Debris){
			sprite_index	= global.sprRhinoFreakShellDoor;
			image_angle		= other.image_angle;
			direction		= 270 + random_range(-20, 20);
			speed			= 5 + random(3);
			depth			= other.depth - 1;
		}
		repeat(12){
			with(instance_create(x, y, Smoke)){
				sprite_index	= global.sprWhiteSmoke;
				direction		= random(360)
				speed			= 2 + random(2);
				image_alpha		= 0.8;
			}
		}
		
	}
	if(freakTimer > 0 && open = true){
		freakTimer -= current_time_scale;
	}
	 
	 // Holy FREAK!!
	if(open = true && FREAKED_OUT = false && freakTimer <= 0){
		FREAKED_OUT = true;
		alarm1 = 2;
	}
	
	 // DIE:
	if(!instance_exists(self)){ exit; }
	if(my_health <= 0){
		with(instance_create(x, y, Corpse)){
			sprite_index = other.spr_dead;
			image_xscale = other.image_xscale;
			size		 = other.size;
		}
		 // Goodbye:
		instance_destroy();
	}
	
#define RhinoFreakShell_destroy
	sound_play_pitch(sndExplosionL, 0.8 + random(0.2))
	for (i = 0; i < 360; i += 72){
		with instance_create(x, y, Explosion){
			hitid	= other.hitid;
		}
	}

#define RhinoFreakShell_alrm1
	if(freaks > 0){
		alarm1 = 5 + irandom(5);
		freaks -= 1;
		
		var _dir = dir;
		
		with(instance_create(x, y + lengthdir_y(10, image_angle), RhinoFreak)){
			image_alpha		= 0;
			script_bind_draw(ShellFreak_draw, (other.depth - 1), self)
		}
	}
	
	
#define ShellFreak_draw(_target)

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

//#endregion
//#endregion
//#region ENEMY PROJECTILES
#define BlasterShell_create(_x, _y)
    with instance_create(_x, _y, CustomProjectile){
    	name = "fr_BlasterShell";
        
         // Visuals:
        sprite_index    = global.sprBlasterShell;
        spr_fade		= global.sprBlasterShellDisappear;
        spr_dead		= global.sprBlasterShellDisappear;
        image_angle		= random(360);
        fr_bloom		= [2, 0.2];
        
         // Vars:
        speed           = (10 + random(2)) * power(0.8, skill_get(mut_euphoria));
        friction		= 0.35;
        typ             = 1;
        damage          = 2;
        creator         = other;
        team            = other.team;
        hitid           = [sprite_index, "BLASTER SHELL"];
        minspeed		= 2;
        hitList			= [];
        
        on_anim			= BlasterShell_anim;
        on_step         = BlasterShell_step;
        on_hit			= BlasterShell_hit;
        on_wall			= BlasterShell_wall;
        
        return self;
    }
    
#define BlasterShell_anim
	if(sprite_index != spr_fade){
		image_speed = 0;
		image_index = image_number - 1;
	}
	
	 // Poof:
	else instance_destroy();
    
#define BlasterShell_step
    if(random(32) < 1){
        with(instance_create(x + random_range(-8, 8), y + random_range(-8, 8), PlasmaTrail)){
        	sprite_index	= global.sprLaserTrapBeamEnd;
        	direction		= other.direction;
        	image_angle		= direction;
			motion_add(other.direction + 180 + orandom(10), (other.speed / 2))
        }
    }
    
	 // Disappear:
	if(speed < minspeed && sprite_index != spr_fade){
		sprite_index = spr_fade;
		image_index  = 0;
		image_speed  = 0.4;
	}

#define BlasterShell_hit
    if(array_find_index(hitList, other) == -1){
        projectile_hit(other, damage, damage, direction);
        array_push(hitList, other);
    }
	
#define BlasterShell_wall
	instance_create(x, y, Smoke);
	if(speed > minspeed){
		sound_play_hit(sndShotgunHitWall, 0.2);
	}

	 // Bounce:
	move_bounce_solid(true);
	image_angle = direction;
	speed = speed * 0.6;
	
#define CrematorProjectile_create(_x, _y, _charged)
    with instance_create(_x, _y, CustomProjectile){
    	name = "fr_CrematorShell";
        
         // Visuals:
        sprite_index    = global.sprCrematorShell;
        spr_fade		= global.sprCrematorShellDisappear;
        spr_dead		= global.sprCrematorShellDisappear;
        image_angle		= random(360);
        fr_bloom		= [2, 0.2];
        fr_glow 		= [32, 48];
        
         // Vars:
        speed           = (10 + random(2)) * power(0.8, skill_get(mut_euphoria));
        friction		= 0.25;
        typ             = 1;
        damage          = 1;
        creator         = other;
        team            = other.team;
        OGteam			= other.team;
        hitid           = [sprite_index, "CREMATOR SHELL"];
        minspeed		= 2;
        charged			= _charged;
        
        if(charged){
        	sprite_index	= global.sprCrematorShellChrg;
    		spr_fade		= global.sprCrematorShellDisappearChrg;
        	spr_dead		= global.sprCrematorShellDisappearChrg;
        }
        
        on_anim			= CrematorProjectile_anim;
        on_step         = CrematorProjectile_step;
        on_hit			= CrematorProjectile_hit;
        on_wall			= CrematorProjectile_wall;
        
        return self;
    }
    
#define CrematorProjectile_anim
	if(!instance_exists(self)){ exit; }
	if(sprite_index != spr_fade){
		image_speed = 0;
		image_index = image_number - 1;
	}
	
	 // Poof:
	else instance_destroy();
    
#define CrematorProjectile_step
    if(random(16) < 1){
        with(instance_create(x + random_range(-8, 8), y + random_range(-8, 8), Smoke)){
			motion_add(other.direction + 180 + orandom(10), (other.speed / 2))
        }
    }
    
	 // Disappear:
	if(speed < minspeed && sprite_index != spr_fade){
		CrematorProjectile_spreadcreep();
		sprite_index = spr_fade;
		image_index  = 0;
		image_speed  = 0.4;
	}

#define CrematorProjectile_hit
	if(projectile_canhit(other)){
		var dmg = damage
		if("boilcap" in other){
			dmg = min(damage, max(0, other.my_health - other.boilcap * skill_get(mut_boiling_veins)))
		}
		projectile_hit(other, dmg)
	}
	if(!instance_is(other, prop)){
		instance_destroy();
	}
	
#define CrematorProjectile_wall
	instance_create(x, y, Smoke);
	if(speed > minspeed){
		sound_play_hit(sndShotgunHitWall, 0.2);
	}

	 // Bounce:
	move_bounce_solid(true);
	image_angle = direction;
	speed = speed * 0.8;
	
#define CrematorProjectile_spreadcreep
    sound_play_pitchvol(sndExplosionS, 1.4 + random(0.1), 0.6);
    sound_play_pitchvol(sndFrogEggHurt, 1.3 + random(0.1), 0.4);
    
    if(charged = true){
    	with(CrematorCreep_create(x, y)){
    		spr_bubble		= global.sprFlameCreepBubbleCharged;
    		creep_color		= make_color_rgb(15, 189, 255);
    		creep_color_2	= make_color_rgb(0, 114, 250);
    		image_blend		= creep_color;
    		damage			= 2;
    		maxSize			= 1;
			image_xscale	= choose(0.4, 0.5);
			image_yscale	= image_xscale;
			hitid			= other.hitid;
			team			= other.OGteam; // prevent team change when deflected
		}
    } else {
		with(CrematorCreep_create(x, y)){
			image_xscale	= choose(0.4, 0.5);
			image_yscale	= image_xscale;
			hitid			= other.hitid;
			team			= other.OGteam; // prevent team change when deflected
		}
    }
    repeat(2){
        with(instance_create(x, y, BloodStreak)){
        	sprite_index	= (other.charged ? global.sprFlameStreakCharged : global.sprFlameStreak)
            direction   	= random(360);
            image_angle		= direction;
            speed       	= 3 + random(3);
        }
    }
    
#define CrematorCreep_create(_x, _y)
	with(instance_create(_x, _y, CustomProjectile)){
		name = "fr_CrematorCreep";
		
         // Visuals:
        sprite_index    = global.sprCreep;
        spr_bubble		= global.sprFlameCreepBubble;
        image_index		= irandom(image_number);
        image_speed		= 0;
        image_angle		= random(360);
        depth			= 4;
        creep_color		= make_color_rgb(252, 56, 0)
        creep_color_2	= make_color_rgb(160, 30, 0)
        image_blend		= creep_color;
        fr_bloom		= [2, 0.1];
    	fr_glow			= [0, 0];
        underwater_fx	= (array_find_index([101, "oasis"], GameCont.area) >= 0) || (is_string(GameCont.area) && (mod_script_call("area", GameCont.area, "area_underwater") = true));
        
         // Vars:
        speed           = 0;
        typ             = 0;
        damage          = 1;
        creator         = other;
        team            = other.team;
        hitid           = [sprite_index, "MOLTEN CREEP"];
        lifetime		= 120;
        allGrownUp		= false;
        maxSize			= 0.7;
    	fr_ignitePowder = true;
        
        on_step         = CrematorCreep_step;
        on_hit			= CrematorCreep_hit;
        on_wall			= nothing;
        
        script_bind_draw(CrematorCreepLow_draw, (depth + 1), self)
        
        return self;
	}
	
#define CrematorCreep_step
	x			= xstart;
	y			= ystart;
	speed		= 0;
	lifetime -= current_time_scale;

	 // Update Glow:
    fr_glow	= [32 * image_xscale, 48 * image_xscale]
    
     // Underwater FX:
    if(underwater_fx){
    	if(random(10) < 1){
    		instance_create(x + orandom(16), y + orandom(16), Bubble)
    	}
    }
        
	 // Grow:
	if(image_xscale < maxSize && allGrownUp = false){
		image_xscale += 0.1;
		image_yscale = image_xscale;
		if(image_xscale >= maxSize){
			allGrownUp = true;
		}
	}
	if(allGrownUp = true && lifetime > 0){
		image_xscale	= maxSize + orandom(0.02);
		image_yscale	= image_xscale;
		if(current_frame_active){
			if(random(20) < 1){
				with(instance_create(x + orandom(16 * maxSize), y + orandom(16 * maxSize), PlasmaTrail)){
					sprite_index = other.spr_bubble;
				}
			}
		}
	}
	
	 // ByeBye:
	if(lifetime <= 0){
		image_xscale -= 0.05;
		image_yscale  = image_xscale;
		if(image_xscale <= 0){
			instance_destroy();
		}
	}
	
#define CrematorCreep_hit
	if(projectile_canhit_melee(other)){
		var _dmg = damage
		if("boilcap" in other){
			_dmg = min(damage, max(0, other.my_health - other.boilcap * skill_get(mut_boiling_veins)))
		}
		if(instance_is(other, prop)){
			_dmg = damage * 3 
		}
		projectile_hit(other, _dmg)
		sound_play_pitchvol(sndBurn, 0.8 + random(0.3), 0.7);
	}

#define CrematorCreepLow_draw(_creep)
	if(!instance_exists(_creep)){
		instance_destroy();
		exit;
	}
	with(_creep){
		draw_sprite_ext(sprite_index, image_index, x, y + 1, image_xscale, image_yscale, image_angle, creep_color_2, image_alpha)
	}

#define GatorCreep_create(_x, _y)
	with(instance_create(_x, _y, CustomProjectile)){
		name = "fr_GatorCreep";
		
         // Visuals:
        sprite_index    = global.sprGatorCreep;
        image_index		= irandom(image_number);
        image_speed		= 0;
        image_angle		= random(360);
        depth			= 4;
        creep_color		= make_color_rgb(133, 249, 26);
        creep_color_2	= make_color_rgb(130, 189, 5);
        image_blend		= creep_color;
        fr_bloom		= [2, 0.1];
    	fr_glow			= [0, 0];
        
         // Vars:
        speed           = 0;
        typ             = 0;
        damage          = 0;
        creator         = other;
        team            = other.team;
        hitid           = [sprite_index, "GATOR CREEP"];
        lifetime		= 90;
        allGrownUp		= false;
        glowSize		= [16, 32];
        maxSize			= 1;
        
        on_step         = GatorCreep_step;
        on_hit			= GatorCreep_hit;
        on_wall			= nothing;
        
        script_bind_draw(CrematorCreepLow_draw, (depth + 1), self)
        
        return self;
	}
	
#define GatorCreep_step
	x			= xstart;
	y			= ystart;
	speed		= 0;
	lifetime -= current_time_scale;

	 // Update Glow:
    fr_glow	= [glowSize[0] * image_xscale, glowSize[1] * image_xscale]
        
	 // Grow:
	if(image_xscale < maxSize && allGrownUp = false){
		image_xscale += 0.1;
		image_yscale = image_xscale;
		if(image_xscale >= maxSize){
			allGrownUp = true;
		}
	}
	if(allGrownUp = true && lifetime > 0){
		image_xscale	= maxSize + orandom(0.02);
		image_yscale	= image_xscale;
	}
	
	 // ByeBye:
	if(lifetime <= 0){
		image_xscale -= 0.05;
		image_yscale  = image_xscale;
		if(image_xscale <= 0){
			instance_destroy();
		}
	}
	
#define GatorCreep_hit
	with(other){
		x = (xprevious + (0.5 * hspeed));
		y = (yprevious + (0.5 * vspeed));
	}
	
#define GatorCreepBig_create(_x, _y)
	with(GatorCreep_create(_x, _y)){
		sprite_index	= global.sprCreep;
		maxSize			= 1;
        glowSize		= [32, 48];
		
		return self;
	}

	
#define MortarJunk_create(_x, _y)
    with instance_create(_x, _y, CustomProjectile){
    	name = "lobbedJunk"
        
         // Visuals:
        sprite_index    = global.sprServerBundle;
        image_index		= irandom(3);
        spr_debris		= global.sprServerBundleDebris;
        image_speed		= 0;
        image_angle		= random(360);
        
         // Vars:
        speed           = 12 * power(0.8, skill_get(mut_euphoria));
        typ             = 1;
        damage          = 1;
        creator         = other;
        team            = other.team;
        hitid           = [sprite_index, "TRASH"];
        z				= 0;
		zspeed  		= 0;
		zfriction		= 1;
		turnspeed		= 3 + random(2) * choose(-1, 1);
		target_x		= 0;
		target_y		= 0;
		
        on_step         = MortarJunk_step;
        on_destroy      = MortarJunk_destroy;
        on_draw			= MortarJunk_draw;
        
        return self;
    }
    
#define MortarJunk_step

	 // Particles:
	if(random(4) < 1){
        with(instance_create(x + random_range(-8, 8), (y - z) + random_range(-8, 8), Dust)){
			sprite_index	= sprBreath;
			direction       = other.direction + 180 + (other.z / 70) + random_range(-20, 20);
			speed			= random(1);
			image_blend 	= make_colour_rgb(74, 60, 78);
		}
	}
	
	image_angle += turnspeed;
	
	 // Z-Axis:
	z += zspeed * current_time_scale;
	zspeed -= zfriction * current_time_scale;
	image_angle -= sign(hspeed) * (abs(vspeed / 2) + abs(hspeed));
	
	 // Set Mask:
	if(z <= 12){
		mask_index	= mskSuperFlakBullet;
	} else {
		mask_index  = mskNone;
	}
	
	 // Set Z Goin:
	if(z <= 0){
		friction	= 0.4;
		depth		= -3;
		
		 // Movement:
		if(speed > 0){
			if(speed > 4) speed = 4;
		}
		
		 // Impact:
		instance_destroy();
	}
	
	 // While In Air:
	else{
		friction	= 0;
		depth		= -10;
	}

#define MortarJunk_destroy
	repeat(6){
		with instance_create(x, y, Debris){
			sprite_index	= other.spr_debris;
			direction		= random(360);
			speed			= 2;
			hitid			= other.hitid;
		}
		with instance_create(x, y, EnemyBullet3){
			direction		= random(360);
			image_angle		= direction;
			speed			= 6 + random(1);
			hitid			= other.hitid;
		}
	}
	with(instance_create(x, y, Explosion)){
		hitid	= other.hitid;
	}
	
	sound_play_pitch(sndExplosionL, 1.1 + random(0.3));
	sound_play_pitchvol(sndHitMetal, 0.7 + random(0.2), 0.4);
	sound_play_pitchvol(sndWallBreakScrap, 1.5 + random(0.2), 0.2);
	
#define MortarJunk_draw
  	draw_sprite_ext(sprite_index, image_index, x, (y - z), (image_xscale + z / 260), (image_yscale + z / 260), image_angle, image_blend, image_alpha);
  	
#define MortarJunk_warningDraw(_target_x, _target_y)
	speen += 6 * current_time_scale;
	if(!instance_exists(creator)){
		instance_destroy();
		exit
	}
	draw_sprite_ext(global.sprLobbedJunkWarning, 0, _target_x, _target_y, 1, 1, speen, c_white, 1);

#define VesselOrbital_create(_x, _y, _creator, _angle)
	with instance_create(_x, _y, CustomProjectile){
		name = "fr_VesselOrbital";
		
		 // Visual:
		sprite_index	= global.sprOrbiterBullet;
		spr_destroy		= sprEnemyBulletHit;
		spr_trail		= global.sprOrbiterBulletTrail;
		image_speed		= 0;
		depth			= -10;
		image_angle		= random(360);
		speed			= 0;
		fr_bloom		= [1.4, 0.2];
		hitid			= _creator.hitid;
		image_xscale	= 0;
		image_yscale	= 0;
		
		 // Vars:
		mask_index		= mskEnemyBullet1;
		damage			= 3;
		creator			= _creator;
		team			= _creator.team;
		typ				= 0;
		ammo_type		= -1;
		angle			= _angle;
		dist			= 0;
		maxDist			= 60;
		orbitSpeed		= 5 + irandom(3);
		
		
		 // Functions:
		on_wall 		= nothing;
		on_hit			= VesselOrbital_hit;
		on_step 		= VesselOrbital_step;
		on_end_step		= VesselOrbital_endstep;
		on_destroy		= VesselOrbital_destroy;
				
		return self;
	}
	
#define VesselOrbital_step
	 // Goodbye:
	if!instance_exists(creator){
		instance_destroy();
		exit;
	}
	
	if(image_xscale < 1){
		image_xscale	+= 0.1 * current_time_scale;
		image_yscale	= image_xscale;
	}
	
	 // Move Out:
	if(dist < maxDist){
		dist += 0.5 * current_time_scale;
	}
	
	 // Trail:
	if(current_frame_active){
		if(random(2) < 1){
			with(instance_create(x, y, BulletHit)){
				sprite_index	= other.spr_trail;
				depth			= other.depth + 1;
			}
		}
	}
	
	 // Set Size and Speen:
	angle += orbitSpeed * current_time_scale;
	image_angle = angle

#define VesselOrbital_wall
	xprevious = x + hspeed;
	yprevious = y + vspeed;
	
#define VesselOrbital_hit
	if(!instance_is(other, prop)){
		with(other){
			projectile_hit(self, other.damage)
			lasthit = other.hitid;
		}
		instance_destroy();
	}
	
#define VesselOrbital_endstep
	if(instance_exists(creator)){
		xprevious = creator.x + lengthdir_x(dist, angle);
		yprevious = creator.y + lengthdir_y(dist, angle);
		x = creator.x + lengthdir_x(dist, angle);
		y = creator.y + lengthdir_y(dist, angle);
	}
	
#define VesselOrbital_destroy
	with(instance_create(x, y, BulletHit)){
		sprite_index	= other.spr_destroy;
	}
	if!instance_exists(creator){ exit; }
	with(creator){
		currentOrbitals -= 1;
	}

#define LabsRocket_create(_x, _y)
	with(instance_create(_x, _y, CustomProjectile)){
		name = "fr_LabsRocket";
		
         // Visuals:
        sprite_index    = global.sprLabsRocket;
        spr_flame		= global.sprLabsRocketFlame;
        image_angle		= random(360);
        
         // Vars:
        speed           = 14 * power(0.8, skill_get(mut_euphoria));
        typ             = 1;
        damage          = 1;
        creator         = other;
        team            = other.team;
        hitid           = [sprite_index, "MICROMISSILE"];
        
         // Events:
        on_step         = LabsRocket_step;
        on_destroy		= LabsRocket_destroy;
        on_draw			= LabsRocket_draw;       
        
        return self;
	}
	
#define LabsRocket_step
	if(current_frame_active){
		with instance_create(x + random_range(-4, 4), y + random_range(-4, 4), PlasmaTrail){ 
			sprite_index	= global.sprLabsRocketTrail; 
			direction		= other.direction; 
			speed			= 2; 
			image_xscale	= 0.7; 
			image_yscale	= image_xscale; 
		}
	}
    
#define LabsRocket_destroy
	sound_play_pitchvol(sndExplosion,	0.5 + random_range(0.8, 1.3), 0.8)
	sound_play_pitchvol(sndPlasma,		0.5 + random_range(0.8, 1.3), 1.2)
	with LabsRocketExplosion_create(x, y){
    	team	= other.team;
    	creator = other.creator;
    	hitid	= other.hitid;
	}
	
#define LabsRocket_draw
    draw_sprite_ext(spr_flame, current_frame * 0.4, x, y, 1, 1.2, image_angle, c_white, image_alpha);
    draw_set_blend_mode(bm_add);
	draw_sprite_ext(spr_flame, current_frame * 0.4, x, y, 1.8 * image_xscale, 1.8 * image_yscale, image_angle, c_white, 0.2);
    draw_set_blend_mode(bm_normal);
    draw_self();

#define LabsRocketExplosion_create(_x,_y)
	with(instance_create(_x, _y, CustomProjectile)){
		name = "fr_LabsRocketExplosion";
		
         // Visuals:
        sprite_index    = global.sprLabsRocketExplosion;
        image_speed		= 0.4;
        image_angle		= random(360);
        fr_bloom		= [2, 0.1];
    	fr_glow			= [48, 96];
        
         // Vars:
        mask_index		= mskSmallExplosion;
        speed           = 0;
        typ             = 0;
        damage          = 2;
        creator         = other;
        team            = other.team;
        hitid           = [sprite_index, "MICROMISSILE EXPLOSION"];
		hitList			= [];
    	fr_ignitePowder = true;
 
         // Events:
        on_step			= LabsRocketExplosion_step;
        on_hit      	= LabsRocketExplosion_hit;
        on_wall			= nothing;
        
        return self;
	}
    
#define LabsRocketExplosion_hit
    if(array_find_index(hitList, other) == -1){
        projectile_hit(other, damage, damage, direction);
        array_push(hitList, other);
    }
    
#define LabsRocketExplosion_step
	if (image_index + image_speed >= image_number){ 
		instance_destroy(); 
	}
	
#define HoneypotHealParticle_create(_x, _y, _target)
	with(instance_create(_x, _y, CustomObject)){
		name = "fr_honeypotHealParticle"
		
		sprite_index	= sprPopoPlasmaTrail
		image_index		= irandom(image_number);
		depth			= -7;
		image_alpha		= 1;
		image_speed		= 0//0.4;
		fr_bloom		= [1.5, 0.3]

		speed			= 5;
		creator			= _target;
	
		on_step			= HoneypotHealParticle_step;
		
		return self;
	}

#define HoneypotHealParticle_step
	if(instance_exists(creator) && instance_exists(self)){
		direction = point_direction(x, y, creator.x, creator.y)
		if(place_meeting(x, y, creator)){
			instance_destroy();
			exit;
		}
	} else {
		instance_destroy();
	}
	
#define HoneypotHealSplash_create(_x,_y)
	with(instance_create(_x, _y, CustomProjectile)){
		name = "fr_HoneypotHealSplash";
		
         // Visuals:
        sprite_index    = global.sprLabsRocketExplosion;
        image_speed		= 0.4;
        image_angle		= random(360);
        fr_bloom		= [2, 0.1];
    	fr_glow			= [48, 96];
        
         // Vars:
        mask_index		= mskSmallExplosion;
        speed           = 0;
        typ             = 0;
        damage          = 0;
        creator         = other;
        team            = other.team;
        hitid           = [sprite_index, "HOW DID YOU DIE TO THIS"];
		hitList			= [];
 
         // Events:
        on_step			= HoneypotHealSplash_step;
        on_hit      	= HoneypotHealSplash_hit;
        on_wall			= nothing;
        
        return self;
	}
    
#define HoneypotHealSplash_hit
    if(array_find_index(hitList, other) == -1){
        with(other){
        	if(instance_is(self, Player)){
        		var _heal = 1 + skill_get(mut_second_stomach)
	            my_health = min(my_health + _heal, maxhealth)
	            with instance_create(x, y, BloodLust){ 
	            	sprite_index    = global.sprHoneypotHeal; 
	        		creator         = other;
	        	}
	            sound_play(sndHPPickup);
        	}
        	if(instance_is(other, enemy)){
				 // Heal Based on Max Hp:
				my_health += round(maxhealth / 5);
				if(my_health > maxhealth){
					my_health = maxhealth; // if this messes with someones overheal mechanic sorry but u should have also changed maxhealth I think
				}
	            with instance_create(x, y, FrogHeal){ 
	            	sprite_index    = global.sprHoneypotHeal;
	            	depth			= other.depth - 1;
	        		creator         = other;
	        	}
        	}
        }
        array_push(hitList, other);
    }
    
#define HoneypotHealSplash_step
	if (image_index + image_speed >= image_number){ 
		instance_destroy(); 
	}
	
	
//#endregion
//#region GENERIC FUNCTIONS
#macro  anim_end                                                                                ((image_index + image_speed_raw) >= image_number || (image_index + image_speed_raw) < 0)
#macro  current_frame_active                                                                    frac(current_frame) < current_time_scale
#macro  target_visible                                                                          !collision_line(x, y, target.x, target.y, Wall, false, false)
#macro  target_direction                                                                        point_direction(x, y, target.x, target.y)
#macro  target_distance                                                                         point_distance(x, y, target.x, target.y)
#macro  enemy_sprite                                                                            (sprite_index != spr_hurt || anim_end) ? ((speed == 0) ? spr_idle : spr_walk) : sprite_index
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
#define orandom(_num)                                                                   		return  random_range(-_num, _num);
#define chance(_numer, _denom)                                                          		return  random(_denom) < _numer;
#define chance_ct(_numer, _denom)                                                       		return  random(_denom) < _numer * current_time_scale;
#define angle_lerp_ct(_ang1, _ang2, _num)                                               		return  _ang2 + (angle_difference(_ang1, _ang2) * power(1 - _num, current_time_scale));
#define enemy_walk(_dir, _num)                                                                  direction = _dir; walk = _num; if(speed < friction) speed = friction;
#define enemy_face(_dir)                                                                        _dir = ((_dir % 360) + 360) % 360; if(_dir < 90 || _dir > 270) right = 1; else if(_dir > 90 && _dir < 270) right = -1;
#define enemy_look(_dir)                                                                        _dir = ((_dir % 360) + 360) % 360; if(_dir < 90 || _dir > 270) right = 1; else if(_dir > 90 && _dir < 270) right = -1; if('gunangle' in self) gunangle = _dir;
#define enemy_target(_x, _y)                                                            		target = (instance_exists(Player) ? instance_nearest(_x, _y, Player) : ((instance_exists(target) && target >= 0) ? target : noone)); return (target != noone);
#define BasicEnemy_draw                             											draw_sprite_ext(sprite_index, image_index, x, y, image_xscale * right, image_yscale, image_angle, image_blend, image_alpha);
#define GunEnemy_draw                               											if gunangle < 180{ draw_sprite_ext(spr_weap,0,x + lengthdir_x(-wkick,gunangle), y + lengthdir_y(-wkick, gunangle), 1, right, gunangle, image_blend, image_alpha);} draw_sprite_ext(sprite_index,image_index,x,y,image_xscale * right, image_yscale, image_angle, image_blend, image_alpha); if gunangle >= 180{ draw_sprite_ext(spr_weap,0,x + lengthdir_x(-wkick,gunangle), y + lengthdir_y(-wkick, gunangle), 1, right, gunangle, image_blend, image_alpha);}
#define MeleeEnemy_draw																			if(gunangle <= 180) draw_weapon(spr_weap, 0, x, y, gunangle, wepangle, wkick, 1, image_blend, image_alpha); image_xscale *= right; draw_self(); image_xscale /= right; if(gunangle >  180) draw_weapon(spr_weap, 0, x, y, gunangle, wepangle, wkick, 1, image_blend, image_alpha);
#define MortarEnemy_draw																		if(gunangle <= 180) draw_weapon(spr_weap, 0, x, y, lerp(90, 45, dcos(gunangle)), 0, wkick, right, image_blend, image_alpha); image_xscale *= right; draw_self(); image_xscale /= right; if(gunangle >  180) draw_weapon(spr_weap, 0, x, y, lerp(90, 45, dcos(gunangle)), 0, wkick, right, image_blend, image_alpha);
#define nothing
#define Enemy_hurt(_dmg, _spd, _dir)
	sprite_index = spr_hurt;
	image_index  = 0;
	
	sound_play_hit(snd_hurt, 0.3);
	motion_add(_dir, _spd);
	
	nexthurt   = current_frame + 6;
	my_health -= _dmg;
	
#define Prop_hurt(_dmg, _spd, _dir)
	my_health -= _dmg;
	nexthurt   = current_frame + 6;
	
	sound_play_hit(snd_hurt, 0.3);
	
	sprite_index = spr_hurt;
	image_index  = 0;

#define draw_weapon(_sprite, _image, _x, _y, _angle, _angleMelee, _kick, _flip, _blend, _alpha)
	/*
		Drawing weapon sprites
		
		Ex:
			draw_weapon(sprBanditGun, gunshine, x, y, gunangle, 0, wkick, right, image_blend, image_alpha)
			draw_weapon(sprPipe, 0, x, y, gunangle, wepangle, wkick, wepflip, image_blend, image_alpha)
	*/
	
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
	
#define sound_play_hit_ext(_sound, _pitch, _volume)
	/*
		'sound_play_hit()' distance-based sound, but with pitch and volume arguments
	*/
	
	var _snd = sound_play_hit(_sound, 0);
	
	sound_pitch(_snd, _pitch);
	sound_volume(_snd, audio_sound_get_gain(_snd) * _volume);
	
	return _snd;
	
#define MuzzleFlash_anim
    image_index = 1;
    image_speed = 0;

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

//#endregion
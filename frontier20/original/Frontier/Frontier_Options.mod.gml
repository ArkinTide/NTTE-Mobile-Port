#define init

	 // LIB:
	while(!mod_exists("mod", "lib")){wait(1);}
	script_ref_call(["mod", "lib", "getRef"], "mod", mod_current, "scr");
	
	
	 // SPRITES:
	global.sprSettingsIcons									= sprite_add("sprites/menu/sprSettingsIcons.png",			36, 4, 4);
	global.mskStatsPageButton								= sprite_add("sprites/menu/mskStatsPageButton.png", 		1, 28, 4);
	global.mskStatsCharacterButton							= sprite_add("sprites/menu/mskStatsCharacterButton.png",	1, 8, 8);
	global.sprStatsPortraits								= sprite_add("sprites/menu/sprStatsPortraits.png",			1, 110, 100);
	global.sprStatsCharacters								= sprite_add("sprites/menu/sprStatsCharacters.png", 		4, 10, 10);
	global.sprStatsCharSplat								= sprite_add("sprites/menu/sprStatsCharSplat.png",			1, 80, 32);
	global.sprStatsPageSelectorSplat						= sprite_add("sprites/menu/sprStatsPageSelector.png",		1, 56, 32);
	global.sprCoveIcon										= sprite_add("sprites/menu/sprCoveIcon.png",				1, 5, 4);
	global.sprCreditsSplattie								= sprite_add("sprites/menu/sprCreditsSplattie.png",			32, 24, 16);
	
	 // VARS:
	global.selectedStatsPage		= "general";
	global.selectedCharacterPage	= null;
	global.statsCharacterPageCheck	= false;
	global.statsPageController		= noone;
	global.statsCharPageController	= noone;

	 // bubbles' page is open by default if hes unlocked
	if(mod_exists("mod", "libSaves")){
		if(call(scr.save_get, "Frontier", "unlock_bubbles") > 0){
			global.selectedCharacterPage = "bubbles"
		}
	}
					
	#macro pirate_conversions		45
	
	 // OPTIONS:
    mod_current_type = script_ref_create(0)[0];
    
    global.options = {
    	"settingVanillaGlow"    				: true,
    	"settingEventDropdowns" 				: true,
    	"settingLightningFlash" 				: true, 
    	"settingMaxAuroras" 					: 3,
    	"settingGreenAugments"      			: false,
    	"settingAugmentProjectiles" 			: true,
    	"settingVisualDecryptors"   			: true,
    	"settingVeeOneHundred"  				: false,
    	"settingNewIDPD"						: true,
    	"settingEventText"  					: false,
    	"settingBigStrikeChests"				: true,
    	"settingThroneTeleporters"				: true,
    	"settingMainPoolPirateWeps"				: false,
    	"settingMainPoolAugments"				: false,
    	"settingLabsRouteAltMode"				: false,
    	"settingMainPoolLabsWeps"				: false,
    	"settingPelagicBubbles"					: true,
    	"settingSurgeriesBeta"					: false,
    	"settingCyberspaceEnabled"				: true,
    	"settingLowQualityParrots"				: false,
    	"settingLowQualitySerpent"				: false,
    	"settingDarkCoreExplosion"				: false,
    	"settingAltCoveEntrance"				: false,
    	"settingNightLoops"						: false,
    	"settingTradeFishMode"					: "OFF",
    	"settingNightEventSpawnChance"			: 0.2,
    	"settingPaintorCampEventSpawnChance"	: 0.03,
    	"settingThunderstormEventSpawnChance"	: 0.1,
    	"settingCurseSpreadEventSpawnChance"	: 0.08,
    	"settingBlizzardEventSpawnChance"		: 0.1,
    	"settingHauntedCityEventSpawnChance"	: 0.06,
     	"settingBlackoutEventSpawnChance"		: 0.2,
    	"settingSerpentLairEventSpawnChance"	: 0.13,
    	"settingPortalStormEventSpawnChance"	: 0.02,
    	"settingCrushTrapSpawnrate"				: 1,
    };
    
    global.loaded = false;
	
    if fork() {
    	// wait for Custom Options to load
    	while !mod_script_exists("mod", "custom_options", "scr_import") {
    		wait 0;
    	}
    	
    	// Custom Options is loaded, we can import now
    	if mod_script_exists("mod", "custom_options", "scr_import") {
    		// import Custom Options' scripts to our `global.scr` variable (change name if desired)
    		mod_script_call_nc("mod", "custom_options", "scr_import", script_ref_create(0), "scr");
    	}
    	
    	global.loaded = true;
    	
    	// add options with `option_add` and `option_add_page`
    	// see `api.txt` for the API and `fields.txt` for the fields of each option type
    	call(scr.option_add_page, mod_current_type, mod_current, "options", "visuals", {
    		"options": [
    			{
    				"option"    : "settingVanillaGlow",
    				"kind"      : "bool",
    				"name": {
    					"text"  : `@1(${real(global.sprSettingsIcons)}:1)` + " VANILLAGLOW"
    				},
    				"desc": {
    					"text"  : "@wSOME BASEGAME OBJECTS AND EFFECTS
    								#@yGLOW IN THE DARK
    								#@sDEFAULT: @wON"
    				}
    			},
    		
    			{
    				"option"    : "settingEventDropdowns",
    				"kind"      : "bool",
    				"name": {
    					"text"  : `@1(${real(global.sprSettingsIcons)}:2)` + " EVENT DROPDOWNS"
    				},
    				"desc": {
    					"text"  : "@(color:6983599)EVENTS @wHAVE DROPDOWN CARDS
    								#WHEN STARTING THE LEVEL
    								#@sDEFAULT: @wON"
    				}
    			},

    			{
    				"option"    : "settingLightningFlash",
    				"kind"      : "bool",
    				"name": {
    					"text"  : `@1(${real(global.sprSettingsIcons)}:3)` + " LIGHTNING FLASH"
    				},
    				"desc": {
    					"text"  : "@(color:6983599)LIGHTNING STRIKES @wCAUSE THE SCREEN
    								#TO FLASH WHEN STRIKING@s
    								#(@(color:6382049)DISABLE IF PHOTOSENSITIVE@s)
    								#@sDEFAULT: @wON"
    				}
    			},
    			
    			{
    				"option"    : "settingMaxAuroras",
    				"kind"      : "range",
    				"name": {
    					"text"  : `@1(${real(global.sprSettingsIcons)}:4)` + " MAX AURORAS"
    				},
    				"desc": {
    					"text"  : "@wHOW MANY EXTRA @(color:6983599)AURORAS@w#CAN RENDER AT THE SAME TIME
    								#@s(@(color:6382049)LOWER IF AURORAS ARE LAGGING@s)
    								#@sDEFAULT: @w3"
    				},
    				"range": {
    					"minimum": 0,
    					"maximum": 5
    				}
    			},


     			{
    				"option"    : "settingGreenAugments",
    				"kind"      : "bool",
    				"name": {
    					"text"  : `@1(${real(global.sprSettingsIcons)}:6)` + " GREEN AUGMENT EFFECTS"
    				},
    				"desc": {
    					"text"  : "@(color:16776960)AUGMENT @wEFFECTS ARE @(color:65280)GREEN
    								#@s(AVOIDS CONFUSION WITH IDPD ENEMIES)
    								#@(color:6381921)(IT DOESNT LOOK AS GOOD THOUGH)
    								#@sDEFAULT: @wOFF"
    				}
    			},
    			
    			{
    				"option"    : "settingAugmentProjectiles",
    				"kind"      : "bool",
    				"name": {
    					"text"  : `@1(${real(global.sprSettingsIcons)}:7)` + " AUGMENTED PROJECTILES"
    				},
    				"desc": {
    					"text"  : "@wSOME @(color:16776960)AUGMENTS @wRESPRITE PROJECTILES
    								#@sDEFAULT: @wON"
    				}
    			},
    		
    			{
    				"option"    : "settingPelagicBubbles",
    				"kind"      : "bool",
    				"name": {
    					"text"  : `@1(${real(global.sprSettingsIcons)}:17)` + " PELAGIC WATER BUBBLES"
    				},
    				"desc": {
    					"text"  : "@wWATER-BREATHING ENEMIES SPAWNED 
    								#BY @(color:13160785)PELAGIC PREDICAMENT @wHAVE BUBBLES
    								#@sDEFAULT: @wON"
    				}
    			},
    			
    			{
    				"option"    : "settingLowQualityParrots",
    				"kind"      : "bool",
    				"name": {
    					"text"  : `@1(${real(global.sprSettingsIcons)}:20)` + " LOWER QUALITY PARROTS"
    				},
    				"desc": {
    					"text"  : "@wREDUCES VISUAL QUALITY OF PARROTS
    								#@s(@(color:6382049)ENABLE IF PARROTS ARE LAGGING@s)
    								#@sDEFAULT: @wOFF"
    				}
    			},
    			
    			{
    				"option"    : "settingLowQualitySerpent",
    				"kind"      : "bool",
    				"name": {
    					"text"  : `@1(${real(global.sprSettingsIcons)}:21)` + " LOWER QUALITY SERPENT"
    				},
    				"desc": {
    					"text"  : "@wREDUCES VISUAL QUALITY OF 
    								#PALACE SERPENT
    								#@s(@(color:6382049)ENABLE IF SERPENT IS LAGGING@s)
    								#@sDEFAULT: @wOFF"
    				}
    			},

    			{
    				"option"    : "settingDarkCoreExplosion",
    				"kind"      : "bool",
    				"name": {
    					"text"  : `@1(${real(global.sprSettingsIcons)}:22)` + " DARK CORE EXPLOSION"
    				},
    				"desc": {
    					"text"  : "@wCHANGES COLOR OF
    								#@(color:8220209)CORE EXPLOSION EFFECT @wTO BLACK
    								#@sDEFAULT: @wOFF"
    				}
    			},
    		]
    	});

     	call(scr.option_add_page, mod_current_type, mod_current, "options", "gameplay", {
    		"options": [
    			/*
    			{
    				"option"    : "settingVeeOneHundred",
    				"kind"      : "bool",
    				"name": {
    					"text"  : `@1(${real(global.sprSettingsIcons)}:8)` + " V100 COMPATIBILITY MODE"
    				},
    				"desc": {
    					"text"  : "@wALTERS SOME FEATURES
    								#THAT BREAK IN V100
    								#@s(@(color:6382049)DISABLE IF NOT ON NTT V100+@s)
    								#@sDEFAULT: @wOFF"
    				}
    			},
				*/
				/*
    			{
    				"option"    : "settingEventText",
    				"kind"      : "bool",
    				"name": {
    					"text"  : `@1(${real(global.sprSettingsIcons)}:10)` + " EVENT LOADING TEXT"
    				},
    				"desc": {
    					"text"  : "@(color:6983599)EVENTS HAVE LOADING TEXTS
    								#@s(RECOMMENDED TO USE DROPDOWNS INSTEAD)
    								#@sDEFAULT: @wOFF"
    				}
    			},
    			*/
				
    			{
    				"option"    : "settingBigStrikeChests",
    				"kind"      : "bool",
    				"name": {
    					"text"  : `@1(${real(global.sprSettingsIcons)}:11)` + " BIG STRIKE CANISTERS"
    				},
    				"desc": {
    					"text"  : "@wTOGGLES @bLARGE STRIKE CANISTERS
    								#@sDEFAULT: @wON"
    				}
    			},
    			
    			{
    				"option"    : "settingNewIDPD",
    				"kind"      : "bool",
    				"name": {
    					"text"  : `@1(${real(global.sprSettingsIcons)}:9)` + " NEW I.D.P.D."
    				},
    				"desc": {
    					"text"  : "@wTOGGLES NEW @bI.D.P.D. @wUNITS
    								#@w(ALSO TOGGLES @bSTRIKERS@w)
    								#
    								#@sTO USE ALONGSIDE @(color:16776960)POPO @sMOD SEE
    								#@sWIGGLERCOLA.ITCH.IO/CUSTOM-IDPD-HANDLER
    								#@sFOR INSTRUCTIONS
    								#@sDEFAULT: @wON"
    				}
    			},
    			
	 			{
					"option"	: "settingTradeFishMode",
					"kind"		: "choice",
					"name": {
						"text"	: `@1(${real(global.sprSettingsIcons)}:25)` + " TRADEFISH MODE"
					},
					"desc": {
						"text"	: "@(color:3516363)TRADEABLE @wWEAPON DROPS#GET @(color:9959231)GHOSTLY INDICATORS
									#@s(APPLIES ON LEVEL START)
									#
									#@(color:3516363)NEW@s: @wNEVER BEFORE TRADED WEPS ONLY
									#@(color:3516363)ALL@s: @wALL TRADEABLE WEAPONS
									#@sDEFAULT: @wOFF"
					},
					"values"	: ["OFF", "NEW", "ALL"],
					"display"	: ["OFF", "NEW", "ALL"]
				}, 

    			{
    				"option"    : "settingThroneTeleporters",
    				"kind"      : "bool",
    				"name": {
    					"text"  : `@1(${real(global.sprSettingsIcons)}:12)` + " THRONE ROOM TELEPORTER"
    				},
    				"desc": {
    					"text"  : "@wTOGGLES @gTHRONE ROOM TELEPORTER
    								#@sDEFAULT: @wON"
    				}
    			},

    			{
    				"option"    : "settingLabsRouteAltMode",
    				"kind"      : "bool",
    				"name": {
    					"text"  : `@1(${real(global.sprSettingsIcons)}:13)` + " LABS ROUTE ALT MODE"
    				},
    				"desc": {
    					"text"  : "@wTOGGLES LABS ROUTE AREAS APPEARING
    								#AS ALT AREAS INSTEAD OF A NEW ROUTE
    								#
    								#@(color:9667202)GRAVEYARD HAS A 50% CHANCE
    								#TO REPLACE FROZEN CITY
    								#@(color:9856357)ROBOTICS CENTER HAS A 50% CHANCE
    								#TO REPLACE NORMAL LABS
    								#
    								#@s(LABS ROUTE ENTRANCE DISABLED)
    								#@(color:6381921)(ADDS A DEEPLABS ENTRANCE TO 6-1)
    								#@s(OVERRIDDEN BY BLAAC'S HARDMODE@s)
    								#@sDEFAULT: @wOFF"
    				}
    			},
    			
    			{
    				"option"    : "settingAltCoveEntrance",
    				"kind"      : "bool",
    				"name": {
    					"text"  : `@1(${real(global.sprSettingsIcons)}:23)` + " ALT COVE ENTRANCE"
    				},
    				"desc": {
    					"text"  : "@wCHANGES @(color:6721553)COVE'S @wENTRANCE TO APPEAR
    								#IN @sSCRAPYARD @w(3-3)
    								#
    								#@sACTS AS A CRYSTAL CAVES ALTERNATIVE
    								#INSTEAD OF AS AN ADDITIONAL LEVEL
    								#@sDEFAULT: @wOFF"
    				}
    			},
    			
        		{
    				"option"    : "settingCrushTrapSpawnrate",
    				"kind"      : "slider",
    				"suffix"	: "%",
    				"name": {
    					"text"  : `@1(${real(global.sprSettingsIcons)}:35)` + " CRUSHTRAP SPAWNRATE"
    				},
    				"desc": {
    					"text"  : "@wCHANGES SPAWNRATE MULTIPLIER#FOR CRUSH TRAPS IN PALACE#@sDEFAULT: @w100%"
    				},
    				"range": {
    					"minimum": 0,
    					"maximum": 2
    				},
    				"steps"     : 0.01,
					"format": {
						"dec": 0
					}
    			},

    		]
    	});
    	
     	call(scr.option_add_page, mod_current_type, mod_current, "options", "gameplay2", {
    		"options": [
    			{
    				"option"    : "settingMainPoolPirateWeps",
    				"kind"      : "choice",
    				"name": {
    					"text"  : `@1(${real(global.sprSettingsIcons)}:14)` + " MAIN POOL PIRATE WEPS"
    				},
    				"desc": {
    					"text"  : "@wTOGGLES @(color:3516363)PIRATE VARIANT WEAPONS
    								#@wAPPEARING IN THE NORMAL WEAPON POOL
    								#
									#@(color:3516363)FOUND@s: @wONLY PREVIOUSLY TRADED WEPS DROP
									#@(color:6382049)SETTING INTENDED FOR ALT GAMEMODES
									#POTENTIALLY UNBALANCED IN NORMAL PLAY
    								#@sDEFAULT: @wOFF"
    				},
    				"values"	: [0, 1, "FOUND"],
					"display"	: ["OFF", "ON", "FOUND"]
    			},
    			
    			{
    				"option"    : "settingMainPoolLabsWeps",
    				"kind"      : "bool",
    				"name": {
    					"text"  : `@1(${real(global.sprSettingsIcons)}:15)` + " MAIN POOL CACHE WEPS"
    				},
    				"desc": {
    					"text"  : "@wTOGGLES @(color:8220209)CACHE-EXCLUSIVE WEAPONS
    								#@wAPPEARING IN THE NORMAL WEAPON POOL
    								#
									#@(color:6382049)SETTING INTENDED FOR ALT GAMEMODES
									#POTENTIALLY UNBALANCED IN NORMAL PLAY
    								#@sDEFAULT: @wOFF"
    				}
    			},
    			
    			{
    				"option"    : "settingMainPoolAugments",
    				"kind"      : "bool",
    				"name": {
    					"text"  : `@1(${real(global.sprSettingsIcons)}:16)` + " MAIN POOL AUGMENTS"
    				},
    				"desc": {
    					"text"  : "@wTOGGLES @(color:16776960)AUGMENTS @wAPPEARING
    								#IN THE NORMAL MUTATION POOL
    								#
    								#@(color:6382049)SETTING INTENDED FOR ALT GAMEMODES
    								#POTENTIALLY UNBALANCED IN NORMAL PLAY
    								#@sDEFAULT: @wOFF"
    				}
    			},

    			{
    				"option"    : "settingCyberspaceEnabled",
    				"kind"      : "bool",
    				"name": {
    					"text"  : `@1(${real(global.sprSettingsIcons)}:19)` + " ROBOT ADDITIONS"
    				},
    				"desc": {
    					"text"  : "@wTOGGLES ROBOT'S @bNEW EXTRA PASSIVE
    								#@sDEFAULT: @wON"
    				}
    			},
    			
       			{
    				"option"    : "settingSurgeriesBeta",
    				"kind"      : "bool",
    				"name": {
    					"text"  : `@1(${real(global.sprSettingsIcons)}:18)` + " SURGERIES (BETA)"
    				},
    				"desc": {
    					"text"  : "@wTOGGLES @(color:2964223)SURGERIES @wAPPEARING
    								#INSIDE OF @gVAULTS
    								#
    								#@sSURGERIES ARE RANDOMLY GENERATED
    								#STAT-SWAPPING MUTATIONS
    								#(RANDOMIZED ON VAULT VISIT)
    								#@(color:6381921)(NOT PLANNED TO STAY IN VAULTS)
    								#(MAY NOT EVER GET IMPLEMENTED FULLY)
    								#
    								#@(color:6382049)THIS FEATURE IS SOMEWHAT INCOMPLETE
    								#AND PROBABLY UNBALANCED,
    								#USE AT YOUR OWN RISK!
    								#@sDEFAULT: @wOFF"
    				}
    			},
    		]
    	});
    	
     	call(scr.option_add_page, mod_current_type, mod_current, "options", "events", {
    		"options": [
      			{
    				"option"    : "settingNightLoops",
    				"kind"      : "bool",
    				"name": {
    					"text"  : `@1(${real(global.sprSettingsIcons)}:26)` + " NIGHT LOOPS"
    				},
    				"desc": {
    					"text"  : "@wCHANGES @(color:11500138)NIGHT EVENTS @wTO APPEAR BASED
    								#ON LOOP INSTEAD OF PER-AREA
    								#@sDEFAULT: @wOFF"
    				}
    			},  	
    			
       			{
    				"option"    : "settingNightEventSpawnChance",
    				"kind"      : "slider",
    				"suffix"	: "%",
    				"name": {
    					"text"  : `@1(${real(global.sprSettingsIcons)}:24)` + " NIGHT EVENTS"
    				},
    				"desc": {
    					"text"  : "@wBASE CHANCE FOR NIGHT EVENTS TO OCCUR#@s(ALSO AFFECTS NIGHT LOOPS)#@sDEFAULT: @w20%"
    				},
    				"steps"     : 0.01,
					"format": {
						"dec": 0
					}
    			},
    			
        		{
    				"option"    : "settingPaintorCampEventSpawnChance",
    				"kind"      : "slider",
    				"suffix"	: "%",
    				"name": {
    					"text"  : `@1(${real(global.sprSettingsIcons)}:27)` + " PAINTOR CAMP"
    				},
    				"desc": {
    					"text"  : "@wBASE CHANCE FOR PAINTOR CAMP TO SPAWN#@sDEFAULT: @w3%"
    				},
    				"steps"     : 0.01,
					"format": {
						"dec": 0
					}
    			},
    			
        		{
    				"option"    : "settingThunderstormEventSpawnChance",
    				"kind"      : "slider",
    				"suffix"	: "%",
    				"name": {
    					"text"  : `@1(${real(global.sprSettingsIcons)}:28)` + " THUNDERSTORM"
    				},
    				"desc": {
    					"text"  : "@wBASE CHANCE FOR THUNDERSTORM TO OCCUR#@sDEFAULT: @w10%"
    				},
    				"steps"     : 0.01,
					"format": {
						"dec": 0
					}
    			},
    			
        		{
    				"option"    : "settingCurseSpreadEventSpawnChance",
    				"kind"      : "slider",
    				"suffix"	: "%",
    				"name": {
    					"text"  : `@1(${real(global.sprSettingsIcons)}:29)` + " CURSE SPREAD"
    				},
    				"desc": {
    					"text"  : "@wBASE CHANCE FOR SPREADING CURSE TO OCCUR#@sDEFAULT: @w8%"
    				},
    				"steps"     : 0.01,
					"format": {
						"dec": 0
					}
    			},
    			
        		{
    				"option"    : "settingBlizzardEventSpawnChance",
    				"kind"      : "slider",
    				"suffix"	: "%",
    				"name": {
    					"text"  : `@1(${real(global.sprSettingsIcons)}:30)` + " BLIZZARD"
    				},
    				"desc": {
    					"text"  : "@wBASE CHANCE FOR BLIZZARD TO OCCUR#@sDEFAULT: @w10%"
    				},
    				"steps"     : 0.01,
					"format": {
						"dec": 0
					}
    			},
    			
        		{
    				"option"    : "settingHauntedCityEventSpawnChance",
    				"kind"      : "slider",
    				"suffix"	: "%",
    				"name": {
    					"text"  : `@1(${real(global.sprSettingsIcons)}:31)` + " HAUNTED CITY"
    				},
    				"desc": {
    					"text"  : "@wBASE CHANCE FOR HAUNTED CITY TO OCCUR#@sDEFAULT: @w6%"
    				},
    				"steps"     : 0.01,
					"format": {
						"dec": 0
					}
    			},
 
        		{
    				"option"    : "settingBlackoutEventSpawnChance",
    				"kind"      : "slider",
    				"suffix"	: "%",
    				"name": {
    					"text"  : `@1(${real(global.sprSettingsIcons)}:32)` + " BLACKOUT"
    				},
    				"desc": {
    					"text"  : "@wBASE CHANCE FOR BLACKOUT TO OCCUR#@sDEFAULT: @w20%"
    				},
    				"steps"     : 0.01,
					"format": {
						"dec": 0
					}
    			},
 
        		{
    				"option"    : "settingSerpentLairEventSpawnChance",
    				"kind"      : "slider",
    				"suffix"	: "%",
    				"name": {
    					"text"  : `@1(${real(global.sprSettingsIcons)}:33)` + " SERPENT LAIR"
    				},
    				"desc": {
    					"text"  : "@wBASE CHANCE FOR SERPENT LAIR TO OCCUR#@sDEFAULT: @w13%"
    				},
    				"steps"     : 0.01,
					"format": {
						"dec": 0
					}
    			},
    			
         		{
    				"option"    : "settingPortalStormEventSpawnChance",
    				"kind"      : "slider",
    				"suffix"	: "%",
    				"name": {
    					"text"  : `@1(${real(global.sprSettingsIcons)}:34)` + " PORTAL STORM"
    				},
    				"desc": {
    					"text"  : "@wBASE CHANCE FOR PORTAL STORM TO OCCUR#@sDEFAULT: @w2%"
    				},
    				"steps"     : 0.01,
					"format": {
						"dec": 0
					}
    			},
     		]
    	});
    	
		call(scr.option_add_page, mod_current_type, mod_current, "options", "stats", {
			"reference": script_ref_create(page_stats_draw)
		});
		
		call(scr.option_add_page, mod_current_type, mod_current, "options", "credits", {
			"reference": script_ref_create(page_credits_draw)
		});
    	
    	call(scr.option_set_mod_display_name, mod_current_type, mod_current, "FRONTIER");
    	call(scr.option_set_page_display_name, mod_current_type, mod_current, "visuals",	"VISUALS");
    	call(scr.option_set_page_display_name, mod_current_type, mod_current, "gameplay",   "GAMEPLAY");
    	call(scr.option_set_page_display_name, mod_current_type, mod_current, "gameplay2",  "GAMEPLAY");
    	call(scr.option_set_page_display_name, mod_current_type, mod_current, "events", 	"EVENTS");
    	call(scr.option_set_page_display_name, mod_current_type, mod_current, "stats",  	"STATS");
    	call(scr.option_set_page_display_name, mod_current_type, mod_current, "credits",  	"CREDITS");
    	
    	exit;
    }
    
    CustomOptions_load();
	
#define ExternalOptions_load
	var _options = global.options;
    	
     // Main:
	mod_variable_set("mod", "Frontier_Main", "settingNewIDPD", 						_options.settingNewIDPD);
	mod_variable_set("mod", "Frontier_Main", "settingBigStrikeChests", 				_options.settingBigStrikeChests);
	mod_variable_set("mod", "Frontier_Main", "settingVanillaGlow", 					_options.settingVanillaGlow);
	mod_variable_set("mod", "Frontier_Main", "settingVisualDecryptors",				_options.settingVisualDecryptors);
	mod_variable_set("mod", "Frontier_Main", "settingThroneTeleporters",			_options.settingThroneTeleporters);
	mod_variable_set("mod", "Frontier_Main", "settingLabsRouteAltMode",				_options.settingLabsRouteAltMode);
	mod_variable_set("mod", "Frontier_Main", "settingSurgeriesBeta",				_options.settingSurgeriesBeta);
	mod_variable_set("mod", "Frontier_Main", "settingAltCoveEntrance",				_options.settingAltCoveEntrance);
	mod_variable_set("mod", "Frontier_Main", "settingCyberspaceEnabled",			_options.settingCyberspaceEnabled);
	mod_variable_set("mod", "Frontier_Main", "settingTradeFishMode",				_options.settingTradeFishMode);
	mod_variable_set("mod", "Frontier_Main", "settingCrushTrapSpawnrate",			_options.settingCrushTrapSpawnrate);	
	
	 // Sloppers:
	mod_variable_set("mod", "Frontier_Events", 			"settingEventText", 		_options.settingEventText);
	mod_variable_set("mod", "Frontier_Events", 			"settingEventDropdowns", 	_options.settingEventDropdowns);
	mod_variable_set("mod", "Frontier_Events", 			"settingLightningFlash", 	_options.settingLightningFlash);
	mod_variable_set("mod", "Frontier_Events", 			"settingMaxAuroras", 		_options.settingMaxAuroras);
//	mod_variable_set("mod", "Frontier_Events", 			"settingVeeOneHundred", 	_options.settingVeeOneHundred);
	mod_variable_set("mod", "Frontier_Events", 			"settingNightLoops", 		_options.settingNightLoops);
	
	mod_variable_set("mod", "Frontier_StatusEffects",	"settingGreenAugments", 	_options.settingGreenAugments);
	
	mod_variable_set("area", "graveyard",				"settingLabsRouteAltMode",	_options.settingLabsRouteAltMode);
	mod_variable_set("area", "robocenter",				"settingLabsRouteAltMode",	_options.settingLabsRouteAltMode);
	mod_variable_set("area", "deeplabs",				"settingLabsRouteAltMode",	_options.settingLabsRouteAltMode);
//	mod_variable_set("area", "deeplabs",				"settingVeeOneHundred",		_options.settingVeeOneHundred);
	mod_variable_set("area", "cyberspace",				"settingCyberspaceEnabled",	_options.settingCyberspaceEnabled);
	mod_variable_set("area", "deeplabs",				"settingDarkCoreExplosion",	_options.settingDarkCoreExplosion);	
	mod_variable_set("area", "cove",					"settingAltCoveEntrance",	_options.settingAltCoveEntrance);
	
	 // Objects:
	mod_variable_set("mod", "Frontier_Projectiles2",	"settingGreenAugments", 		_options.settingGreenAugments);
	mod_variable_set("mod", "Frontier_Projectiles",		"settingNaturalPirateWeps", 	_options.settingMainPoolPirateWeps);
	mod_variable_set("mod", "Frontier_Projectiles",		"settingNaturalLabsWeps",		_options.settingMainPoolLabsWeps);
	mod_variable_set("mod", "Frontier_IDPD",			"settingNewIDPD", 				_options.settingNewIDPD);
	mod_variable_set("mod", "Frontier_IDPD",			"settingMainPoolAugments",		_options.settingMainPoolAugments);
	mod_variable_set("mod", "Frontier_Pickups",			"settingVisualDecryptors",		_options.settingVisualDecryptors);
	mod_variable_set("mod", "Frontier_Caves",			"settingLowQualityParrots",		_options.settingLowQualityParrots);
	mod_variable_set("mod", "Frontier_Caves",			"settingTradeFishMode",			_options.settingTradeFishMode);
	mod_variable_set("mod", "Frontier_Palace",			"settingLowQualitySerpent",		_options.settingLowQualitySerpent);
	
	 // Mutations:
	mod_variable_set("skill", "AugmentBloodlust",		"settingGreenAugments", 	_options.settingGreenAugments);
	mod_script_call("skill",  "AugmentBoilingVeins",	"load_options", _options)
	mod_variable_set("skill", "AugmentEuphoria",		"settingGreenAugments", 	_options.settingGreenAugments);
	mod_variable_set("skill", "AugmentExtraFeet",		"settingGreenAugments", 	_options.settingGreenAugments);
	mod_variable_set("skill", "AugmentImpactWrists",	"settingGreenAugments", 	_options.settingGreenAugments);
	mod_script_call("skill",  "AugmentLaserBrain",		"load_options", _options)
	mod_variable_set("skill", "AugmentLastWish",		"settingGreenAugments", 	_options.settingGreenAugments);
	mod_variable_set("skill", "AugmentLuckyShot",		"settingGreenAugments", 	_options.settingGreenAugments);
	mod_variable_set("skill", "AugmentOpenMind",		"settingGreenAugments", 	_options.settingGreenAugments);
	mod_variable_set("skill", "AugmentRabbitPaw",		"settingGreenAugments", 	_options.settingGreenAugments);
	mod_variable_set("skill", "AugmentSharpTeeth",		"settingGreenAugments", 	_options.settingGreenAugments);
	mod_variable_set("skill", "BurdenPelagicPredicament", "settingPelagicBubbles", 	_options.settingPelagicBubbles);
//	mod_variable_set("skill", "BurdenPelagicPredicament", "settingVeeOneHundred", 	_options.settingVeeOneHundred);

	 // Event Chances:
	mod_variable_set("mod", "Frontier_Main",	"settingNightEventSpawnChance", 		_options.settingNightEventSpawnChance);
	mod_variable_set("mod", "Frontier_Events",	"settingNightEventSpawnChance", 		_options.settingNightEventSpawnChance);
	mod_variable_set("mod", "Frontier_Events",	"settingPaintorCampEventSpawnChance", 	_options.settingPaintorCampEventSpawnChance);
	mod_variable_set("mod", "Frontier_Events",	"settingThunderstormEventSpawnChance", 	_options.settingThunderstormEventSpawnChance);
	mod_variable_set("mod", "Frontier_Events",	"settingCurseSpreadEventSpawnChance", 	_options.settingCurseSpreadEventSpawnChance);
	mod_variable_set("mod", "Frontier_Events",	"settingBlizzardEventSpawnChance", 		_options.settingBlizzardEventSpawnChance);
	mod_variable_set("mod", "Frontier_Events",	"settingHauntedCityEventSpawnChance", 	_options.settingHauntedCityEventSpawnChance);
	mod_variable_set("mod", "Frontier_Events",	"settingBlackoutEventSpawnChance", 		_options.settingBlackoutEventSpawnChance);
	mod_variable_set("mod", "Frontier_Events",	"settingSerpentLairEventSpawnChance", 	_options.settingSerpentLairEventSpawnChance);
	mod_variable_set("mod", "Frontier_Events",	"settingPortalStormEventSpawnChance", 	_options.settingPortalStormEventSpawnChance);

#define page_stats_draw

	 // Controller:
	if(!instance_exists(global.statsPageController)){
		global.statsPageController = statsPageController_create(screen_center_x, screen_center_y)
	}
	with(global.statsPageController){
		keepMeAlive = 2;
	}

	 // Page Selector Splat:
	if(instance_exists(CampChar)){
		draw_sprite(global.sprStatsPageSelectorSplat, 0, screen_center_x + 130, screen_center_y + 65)
	}
	
	#macro genstat_x		screen_center_x
	#macro genstat_y		screen_center_y - 48
	#macro charstat_x		screen_center_x + 32
	#macro charstat_y		screen_center_y - 64
	#macro covestat_y		genstat_y + 58

	switch(statsPage){
		case "general":{

			var _halign = draw_get_halign(),
				_valign = draw_get_valign();
				
				draw_set_valign(0);
	
				 // Category Name:
				draw_set_halign(fa_center);
				draw_text_nt(genstat_x, genstat_y - 10, "@wGENERAL");
				
				 // Stat Names:
				draw_set_halign(fa_right);
				draw_text_nt(genstat_x + 32, genstat_y,
					"@sMEALS EATEN
					#AUGMENTS TAKEN
					#PROTO CACHES OPENED
					#CORE DETONATIONS
					#HOARDER K/E RATIO
					#CYBERSPACE VISITS
					"
				);
				
				 // Stat Numbers:
				draw_set_halign(fa_left);
				draw_text_nt(genstat_x + 36, genstat_y,
					"@w" 
					+ string(call(scr.save_get, "Frontier", "meals_eaten"))
					+ "#" + string(call(scr.save_get, "Frontier", "augments_taken"))
					+ "#" + string(call(scr.save_get, "Frontier", "caches_opened"))
					+ "#" + string(call(scr.save_get, "Frontier", "deeplabs_finales"))
					+ "#" + string(call(scr.save_get, "Frontier", "hoarder_kills")) + "@s:@w" + string(call(scr.save_get, "Frontier", "hoarder_escapes"))
					+ "#" + string(call(scr.save_get, "Frontier", "cyberspace_visits"))
				);	
				
				 // Category Name:
				draw_set_halign(fa_center);
				draw_text_nt(genstat_x - 4, covestat_y, "@wWEAPONS TRADED");
				draw_text_nt(genstat_x, covestat_y + 14, `@1(${real(global.sprCoveIcon)}:0)`)
				
				 // Stat Names:
				draw_set_halign(fa_right);
				draw_text_nt(genstat_x - 6, covestat_y + 10,
					"@sTOTAL
					#UNIQUE#"
				);
				
				 // Stat Numbers:
				draw_set_halign(fa_left);
				draw_text_nt(genstat_x + 6, covestat_y + 10,
					"@w" 
					+ string(call(scr.save_get, "Frontier", "pirate_trades"))
					+ "#" + string(array_length(call(scr.save_get, "Frontier", "pirate_conversions"))) + "@s/@w" + string(pirate_conversions)
				);		

				draw_set_halign(_halign)
				draw_set_valign(_valign)

			
			break;
		}
		case "characters":{
			
			var _halign = draw_get_halign(),
				_valign = draw_get_valign();
				
				draw_set_valign(0);
				
			switch(charPage){
				
				case "bubbles":{
					
						// BUBBLES:
					// Name + Port:
					draw_sprite(global.sprStatsPortraits, 0, screen_center_x - 100, screen_center_y - 20)
					draw_sprite(global.sprStatsCharSplat, 0, screen_center_x - 100, screen_center_y + 56)					
					draw_set_font(fntBigName);
					draw_set_halign(fa_left);
					draw_set_valign(fa_top);
					draw_text_nt(screen_center_x - 156, screen_center_y + 48, "@(color:0)BUBBLES")
					draw_text_nt(screen_center_x - 156, screen_center_y + 47, "BUBBLES")
												
					draw_set_font(fntM)
					
					 // Stat Names:
					draw_set_halign(fa_right);
					draw_text_nt(charstat_x + 32, charstat_y,
						"@sKILLS
						#LOOPS
						#RUNS
						#DEATHS
						#WINS
						#TIME
						#BUBBLES
						"
					);
					
					 // Stat Numbers:
					draw_set_halign(fa_left);
					draw_text_nt(charstat_x + 36, charstat_y,
						"@w" 
						+ string(call(scr.save_get, "Frontier", "bubbles_kills"))
						+ "#" + string(call(scr.save_get, "Frontier", "bubbles_loops"))
						+ "#" + string(call(scr.save_get, "Frontier", "bubbles_runs"))
						+ "#" + string(call(scr.save_get, "Frontier", "bubbles_deaths"))
						+ "#" + string(call(scr.save_get, "Frontier", "bubbles_wins"))
						+ "#" 
						+ string_lpad(string(floor(((call(scr.save_get, "Frontier", "bubbles_time")) / power(60, 2)))), "0", 1) + ":"
						+ string_lpad(string(floor(((call(scr.save_get, "Frontier", "bubbles_time")) / power(60, 1)) % 60)), "0", 2) + ":"
						+ string_lpad(string(floor(((call(scr.save_get, "Frontier", "bubbles_time")) / power(60, 0)) % 60)), "0", 2)
						+ "#" + string(call(scr.save_get, "Frontier", "bubbles_bubbles"))
					);	
					
					 // BEST RUN
					var _bestArea = "N/A" 
					if(is_string(call(scr.save_get, "Frontier", "bubbles_best_area")[0])){
						_bestArea = (!mod_exists("area", (call(scr.save_get, "Frontier", "bubbles_best_area")[0]))) ? "@rAREA NOT LOADED" 
						: string(call(scr.area_get_name, (call(scr.save_get, "Frontier", "bubbles_best_area")[0]), (call(scr.save_get, "Frontier", "bubbles_best_area")[1]), (call(scr.save_get, "Frontier", "bubbles_best_area")[2])))
					} else {
						_bestArea = string(call(scr.save_get, "Frontier", "bubbles_best_area")[0]) + "-" 
									+ string(call(scr.save_get, "Frontier", "bubbles_best_area")[1]) + " L"
									+ string(call(scr.save_get, "Frontier", "bubbles_best_area")[2])
					}
					
					 // Category Name:
					draw_set_halign(fa_center);
					draw_text_nt(charstat_x + 30, charstat_y + 64, "@wBEST RUN");
					
					 // Stat Names:
					draw_set_halign(fa_right);
					draw_text_nt(charstat_x + 32, charstat_y + 74,
						"@sAREA
						#KILLS"
					);
					
					 // Stat Numbers:
					draw_set_halign(fa_left);
					draw_text_nt(charstat_x + 36, charstat_y + 74,
						"@w" 
						+ _bestArea
						+ "#" + string(call(scr.save_get, "Frontier", "bubbles_best_kills"))
					);		
					
					
					
					draw_set_halign(_halign)
					draw_set_valign(_valign)
					
					break;
				}
			}
			
				 // Controller:
				if(!instance_exists(global.statsCharPageController)){
					global.statsCharPageController = statsCharacterPageController_create(screen_x, screen_y)
				}
				with(global.statsCharPageController){
					keepMeAlive = 2;
				}
				
				draw_sprite_ext(global.sprStatsCharSplat, 0, screen_center_x - 110, screen_center_y - 54, 1, 1, 180, c_white, 1)
				
				 // I have to draw the buttons here because of a bizzare bug with custom options(?) thats causing things not to draw specifically in this area
				draw_sprite(global.sprStatsCharacters, ((call(scr.save_get, "Frontier", "unlock_bubbles")) ? 1 : 0), screen_center_x - 112, screen_center_y - 76)
			
				draw_set_halign(_halign);
				draw_set_valign(_valign);
		
			break;
		}
		
		case "unlocks": {
			
			var _halign = draw_get_halign(),
				_valign = draw_get_valign();
				
			draw_set_valign(0)
			
			draw_set_halign(fa_center);
			draw_text_nt(screen_center_x, screen_center_y - 24, "nothing to see here")
			draw_sprite(sprSalamanderWalk, current_frame * 0.8, screen_center_x, screen_center_y)
			draw_sprite(sprSalamanderWalk, current_frame * 0.8, screen_center_x + 48, screen_center_y)
			draw_sprite(sprSalamanderWalk, current_frame * 0.8, screen_center_x - 48, screen_center_y)

			draw_set_halign(_halign);
			draw_set_valign(_valign);	
			
			break;
		}
		
	}
	
#define page_credits_draw
	#macro spec_x screen_center_x - 150
	#macro spec_y screen_center_y - 60
	#macro cred_x screen_center_x + 20 
	#macro cred_y screen_center_y - 64 // -48
	
	var _halign = draw_get_halign(),
		_valign = draw_get_valign();
	
	draw_set_valign(0)	
	draw_set_halign(0)
	
	 // SPECIAL THANKS
	 // these guys did something at some point that was helpful, thanks!
	draw_text_nt(spec_x, spec_y,			"-SPECIAL THANKS-");
	draw_text_nt(spec_x, spec_y + 11,		"@sAEVUSONIAN");
	draw_text_nt(spec_x, spec_y + 22,		"CRINGERHOMBUS");
	draw_text_nt(spec_x, spec_y + 33,		"@sDRAGONSTRIVE");
	draw_text_nt(spec_x, spec_y + 44,		"GECKOBONE");
	draw_text_nt(spec_x, spec_y + 55,		"@sGOLDEN EPSILON");
	draw_text_nt(spec_x, spec_y + 66,		"JSBURG");
	draw_text_nt(spec_x, spec_y + 77,		"@sMCCHOMK");
	draw_text_nt(spec_x, spec_y + 88,		"SANIBLUES");
	draw_text_nt(spec_x, spec_y + 99,		"@sSQUIDDY");
	draw_text_nt(spec_x, spec_y + 110,		"YOKIN");

	
//	draw_sprite(sprSalamanderWalk, current_frame * 0.8, cred_x + 40, cred_y + 10)	
	draw_text_nt(cred_x, cred_y + 22,		"WIGGLERCOLA");
	draw_set_font(fntSmall)
	draw_text_nt(cred_x - 4, cred_y + 30,		"@(color:16745694)WIGGLERCOLA MAKE MOD");
	draw_set_font(fntM);

//	draw_sprite(global.sprCreditsSplattie, current_frame * 0.4, cred_x + 33, cred_y + 60)	// ill put it back when i make one for meself it looks weird all alone
	draw_text_nt(cred_x, cred_y + 77,		"SPLATTIE");
	draw_set_font(fntSmall)
	draw_text_nt(cred_x - 4, cred_y + 85,		"@(color:65280)MUSIC AND SFX");
	draw_set_font(fntM);
	
	draw_set_halign(_halign);
	draw_set_valign(_valign);	

#define cleanup
    if(global.loaded){
    	call(scr.option_remove_mod, mod_current_type, mod_current);
    }

#define CustomOptions_load
    if (fork()){
    	var _path = CONFIG_FILE;
    	
    	file_load(_path);
    	
    	while (!file_loaded(_path)){
    		wait(0);
    	}
    	
    	if (file_exists(_path)){
    		var _options = json_decode(string_load(_path));
    		
    		if (_options == json_error){
    			trace(json_error_text);
    			exit;
    		}
    		
    		var option_count = lq_size(global.options);
    		
    		var _obj = {};
    		
    		for (var i = 0; option_count > i; i ++){
    			var _key = lq_get_key(global.options, i);
    			lq_set(_obj, _key, lq_defget(_options, _key, lq_get(global.options, _key)));
    		}
    		
    		global.options = _obj;
    	}
    	
    	else{
    		CustomOptions_save();
    	}
    	
    	file_unload(_path);
    	
    	global.loaded = true;
    	
    	exit;
    }
    
    ExternalOptions_load();
    
#define CustomOptions_save
    string_save(json_encode(global.options, chr(9)), CONFIG_FILE);
    
    ExternalOptions_load();

    #macro scr                              global.scr
    #macro call                             script_ref_call
    #macro mod_current_type                 global.mod_current_type
	#macro CONFIG_FILE                      mod_current + " config.json"
	#macro screen_center_x					(game_width / 2)
	#macro screen_center_y 					(game_height / 2)
	#macro screen_x 						view_xview_nonsync + (game_width / 2)
	#macro screen_y 						view_yview_nonsync + (game_height / 2)
	#macro statsPage						global.selectedStatsPage
	#macro charPage							global.selectedCharacterPage
	
	
	
	
		// WRETCHED STATS PAGE CONTROLLER FROM HELL:
#define statsPageController_create(_x, _y)
	with(instance_create(_x, _y, CustomObject)){
		keepMeAlive = 2;
		
		on_step		= statsPageController_step;
		
		 // Page Selection Buttons:
		statsPageSelectorButton_create(screen_x + 128, screen_y + 64, self, "general", "general")
																// 58
		statsPageSelectorButton_create(screen_x + 128, screen_y + 74, self, "mutants", "characters")
																// 68
	//	statsPageSelectorButton_create(screen_x + 128, screen_y + 78, self, "unlocks", "unlocks")
		
		return self
	}
	
#define statsPageController_step
	keepMeAlive -= current_time_scale;
	if(keepMeAlive <= 0){
		global.statsPageController = noone;
		with(instances_matching(CustomObject, "fr_isThisMyStatsButton", true)){
			instance_delete(self);
		}
		instance_destroy();
	}

#define statsPageSelectorButton_create(_x, _y, _creator, _text, _page)
	with(call(scr.create_button, _x, _y, mskNone, statsPageSelectorButton_click, statsPageSelectorButton_hover)){
		fr_isThisMyStatsButton = true;
		
		sprite_index	= global.mskStatsPageButton
		text			= _text;
		textColor		= "@s";
		depth			= -10010
		
		page			= _page;
		creator			= _creator;
		hoverTime   	= 0;
		
		clickScr	= script_ref_create(statsPageSelectorButton_click)
		hoverScr	= script_ref_create(statsPageSelectorButton_hover)
		on_end_step = statsPageSelectorButton_endstep;
		on_draw		= statsPageSelectorButton_draw;
		
	}

#define statsPageSelectorButton_click
	global.selectedStatsPage = page
	sound_play(sndClick)

#define statsPageSelectorButton_hover
	textColor = "@s";
	hoverTime = 2;
	
#define statsPageSelectorButton_endstep
	if(global.selectedStatsPage = page){
		textColor = "@w";
	} else {
		if(hoverTime < 1){
			textColor = "@(color:4210752)";
		}
	}
	if(hoverTime > 0){
		hoverTime -= current_time_scale;
	}

#define statsPageSelectorButton_draw

	 // For some reason when not in the main menu this draw gets moved over, idk why
//	var onMainMenu = instance_exists(CampChar);
//	draw_text_nt(onMainMenu ? x - 28 : x, y - 4,  textColor + text)

	var _halign = draw_get_halign(),
		_valign = draw_get_valign();
		
	draw_set_valign(0)
	draw_set_halign(fa_center)
	draw_text_nt(x, y - 4,  textColor + text)
	
	draw_set_halign(_halign)
	draw_set_valign(_valign)
	
#define statsCharacterPageController_create(_x, _y)
	with(instance_create(_x, _y, CustomObject)){
		keepMeAlive = 2;
		
		on_step		= statsCharacterPageController_step;
		
		 // Page Selection Buttons:
		statsCharacterPageSelectorButton_create(screen_x - 112, screen_y - 76, noone, 1, 0, "bubbles", "BUBBLES", call(scr.save_get, "Frontier", "unlock_bubbles"))
		
		return self
	}
	
#define statsCharacterPageController_step
	keepMeAlive -= current_time_scale;
	if(keepMeAlive <= 0){
		global.statsCharPageController = noone;
		with(instances_matching(CustomObject, "fr_isThisMyCharacterStatsButton", true)){
			instance_delete(self);
		}
		instance_destroy();
	}
	
#define statsCharacterPageSelectorButton_create(_x, _y, _creator, _unlockedframe, _lockedframe, _characterPage, _name, _unlock)
	with(call(scr.create_button, _x, _y, mskNone, statsCharacterPageSelectorButton_click, statsCharacterPageSelectorButton_hover)){
		fr_isThisMyCharacterStatsButton = true;

		sprite_index	= global.mskStatsCharacterButton
		image_frame		= _unlockedframe;
		depth			= -10010
		text			= _name;
		
		characterPage	= _characterPage;
		creator			= _creator;
		hovering		= false;
		hoverTime		= 0;
		
		clickScr	= script_ref_create(statsCharacterPageSelectorButton_click)
		hoverScr	= script_ref_create(statsCharacterPageSelectorButton_hover)
		on_end_step = statsCharacterPageSelectorButton_endstep;
		on_draw		= statsCharacterPageSelectorButton_draw;
		
		if(_unlock = 0){
			image_frame = _lockedframe;
			text		= "LOCKED";
			clickScr	= script_ref_create(statsCharacterPageSelectorButtonLocked_click)
		}
		
	}

#define statsCharacterPageSelectorButton_click
	global.selectedCharacterPage = characterPage;
	sound_play(sndClick)
	
#define statsCharacterPageSelectorButtonLocked_click
	sound_play(sndEmpty)

#define statsCharacterPageSelectorButton_hover
	hoverTime = 2;
	
#define statsCharacterPageSelectorButton_endstep
	if(hoverTime > 1){
		hovering = true
	} else {
		hovering = false;
	}
	if(hoverTime > 0){
		hoverTime -= current_time_scale;
	}

#define statsCharacterPageSelectorButton_draw
	if(hovering = true){
		draw_tooltip(x, y - 8, text)
	}
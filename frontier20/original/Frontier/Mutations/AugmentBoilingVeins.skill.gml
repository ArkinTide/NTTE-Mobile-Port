#define init

	 // Sprites:
	global.sprSkillIcon 					= sprite_add("../sprites/mutations/sprAugmentBoilingVeins.png", 	1, 12, 16);
	global.sprSkillHud  					= sprite_add("../sprites/mutations/sprAugmentBoilingVeinsIcon.png",	1, 8, 9);
	
	global.levelStart						= (instance_exists(GenCont) || instance_exists(Menu));
	global.spritesReplaced					= false;
	global.settingAugmentProjectiles		= true;
	global.settingGreenAugments				= false;

	global.sprNull							= sprite_add("../sprites/particles/sprAugmentSharpTeethNull.png",					3, 8, 8);	
	global.sprGreenNull						= sprite_add("../sprites/particles/sprGreenAugmentSharpTeethNull.png",				3, 8, 8);
	
	global.sprPopoGunpowderCreep			= sprite_add("../sprites/projectiles/popoexplo/sprPopoGunpowderCreep.png",			18, 24, 24);
	global.sprPopoFireSlash  				= sprite_add("../sprites/projectiles/popoexplo/sprPopoFireSlash.png",				3, 0, 24);	
	global.sprPopoFlameTrail  				= sprite_add("../sprites/projectiles/popoexplo/sprPopoFlameTrail.png",				7, 2, 2);	
	global.sprPopoFlameBullet				= sprite_add("../sprites/projectiles/popoexplo/sprPopoFlameBullet.png", 			2, 8, 8);
	global.sprPopoFlameBulletHit			= sprite_add("../sprites/projectiles/popoexplo/sprPopoFlameBulletHit.png", 			4, 8, 8);
	global.sprPopoFireFly					= sprite_add("../sprites/particles/sprPopoFireFly.png", 							13, 0, 0);
	global.sprPopoFlameRocket				= sprite_add("../sprites/projectiles/popoexplo/sprPopoFlameRocket.png", 			1, 9, 4);
	global.sprPopoFlameCreepBubble			= sprite_add("../sprites/projectiles/popoexplo/sprPopoFlameCreepBubble.png", 		6, 8, 8);
    global.sprPopoGunpowderShell	    	= sprite_add("../sprites/projectiles/popoexplo/sprPopoGunpowderShell.png", 			2, 8, 8);
    global.sprPopoGunpowderShellDisappear	= sprite_add("../sprites/projectiles/popoexplo/sprPopoGunpowderShellDisappear.png",	4, 8, 8);
	
	global.sprPopoFireBullet				= sprite_add("../sprites/projectiles/popoexplo/sprPopoFireBullet.png", 				3, 8, 8);
	global.sprPopoFireBulletHit				= sprite_add("../sprites/projectiles/popoexplo/sprPopoFireBulletHit.png", 			4, 8, 8);
	global.sprPopoHeavyFireBullet			= sprite_add("../sprites/projectiles/popoexplo/sprPopoHeavyFireBullet.png", 		3, 12, 12);
	global.sprPopoHeavyFireBulletHit		= sprite_add("../sprites/projectiles/popoexplo/sprPopoHeavyFireBulletHit.png", 		4, 12, 12);
	global.sprPopoFireBulletBounce			= sprite_add("../sprites/projectiles/popoexplo/sprPopoFireBulletBounce.png", 		3, 6, 8);
	global.sprPopoHeavyFireBulletBounce		= sprite_add("../sprites/projectiles/popoexplo/sprPopoHeavyFireBulletBounce.png", 	3, 9, 12);
	global.sprPopoFireGunhammerSlash		= sprite_add("../sprites/projectiles/popoexplo/sprPopoFireGunhammerSlash.png", 		4, 0, 24);
	global.sprPopoFireShot					= sprite_add("../sprites/projectiles/popoexplo/sprPopoFireShot.png", 				3, 12, 12);
	global.sprPopoFireFlak					= sprite_add("../sprites/projectiles/popoexplo/sprPopoFireFlak.png", 				2, 11, 10);	
	global.sprPopoFireMuzzle				= sprite_add("../sprites/projectiles/popoexplo/sprPopoFireMuzzle.png", 				1, 7, 7);	
	global.sprPopoGasFire					= sprite_add("../sprites/projectiles/popoexplo/sprPopoGasFire.png", 				6, 10, 10);	 
	global.sprPopoMegaFireBullet			= sprite_add("../sprites/projectiles/popoexplo/sprPopoMegaFireBullet.png", 			3, 18, 18);	 

	global.sprPopoEmber						= sprite_add("../sprites/projectiles/popoexplo/sprPopoEmber.png",					7, 2, 2);	
	global.sprPopoDirectionalExplosion		= sprite_add("../sprites/projectiles/popoexplo/sprPopoDirectionalExplosion.png",	7, 12, 12);	
	global.sprPopoLavaSheet					= sprite_add("../sprites/projectiles/popoexplo/sprPopoLavaSheet.png",				8, 8, 0);	
	global.sprPopoLavaStreak				= sprite_add("../sprites/projectiles/popoexplo/sprPopoLavaStreak.png",				6, 0, 8);	
	global.sprPopoLavaSplash				= sprite_add("../sprites/projectiles/popoexplo/sprPopoLavaSplash.png",				4, 0, 16);	
	global.sprPopoMushroomExplosion			= sprite_add("../sprites/projectiles/popoexplo/sprPopoMushroomExplosion.png",		20, 128, 128);	
	global.sprPopoFlamePuff					= sprite_add("../sprites/projectiles/popoexplo/sprPopoFlamePuff.png",				6, 8, 8);
	global.sprPopoFlameSparkle				= sprite_add("../sprites/projectiles/popoexplo/sprPopoFlameSparkle.png",			6, 8, 8);
	global.sprPopoFlameSparkleBig			= sprite_add("../sprites/projectiles/popoexplo/sprPopoFlameSparkleBig.png",			6, 16, 16);
	global.sprPopoLavaBomb					= sprite_add("../sprites/projectiles/popoexplo/sprPopoLavaBomb.png", 				2, 12, 12);	
	global.sprPopoLavaBombBig				= sprite_add("../sprites/projectiles/popoexplo/sprPopoLavaBombBig.png", 			2, 16, 16);
	global.sprPopoLavaSlash					= sprite_add("../sprites/projectiles/popoexplo/sprPopoLavaSlash.png", 				3, 0, 24);	
	global.sprPopoFireflyIdle				= sprite_add("../sprites/projectiles/popoexplo/sprPopoFireflyIdle.png",				12, 16, 16);	
	global.sprPopoFireflyWalk				= sprite_add("../sprites/projectiles/popoexplo/sprPopoFireflyWalk.png",				6, 16, 16);	
	global.sprPopoFireflyHurt				= sprite_add("../sprites/projectiles/popoexplo/sprPopoFireflyHurt.png",				3, 16, 16);	
	global.sprPopoFireflyDead				= sprite_add("../sprites/projectiles/popoexplo/sprPopoFireflyDead.png",				15, 16, 16);	
	global.sprPopoFireflyExplode			= sprite_add("../sprites/projectiles/popoexplo/sprPopoFireflyExplode.png",			5, 16, 16);	
	global.sprPopoFlytrapIdle				= sprite_add("../sprites/projectiles/popoexplo/sprPopoFlytrapIdle.png",				6, 32, 32);	
	global.sprPopoFlytrapWalk				= sprite_add("../sprites/projectiles/popoexplo/sprPopoFlytrapWalk.png",				8, 32, 32);	
	global.sprPopoFlytrapHurt				= sprite_add("../sprites/projectiles/popoexplo/sprPopoFlytrapHurt.png",				3, 32, 32);	
	global.sprPopoFlytrapDead				= sprite_add("../sprites/projectiles/popoexplo/sprPopoFlytrapDead.png",				16, 48, 48);	
	global.sprPopoFlytrapChrg				= sprite_add("../sprites/projectiles/popoexplo/sprPopoFlytrapChrg.png",				1, 32, 32);	
	global.sprPopoFlytrapFire				= sprite_add("../sprites/projectiles/popoexplo/sprPopoFlytrapFire.png",				4, 32, 32);	
	global.sprPopoPitcherPlantIdle			= sprite_add("../sprites/projectiles/popoexplo/sprPopoPitcherPlantIdle.png",		8, 24, 24);	
	global.sprPopoPitcherPlantWalk			= sprite_add("../sprites/projectiles/popoexplo/sprPopoPitcherPlantWalk.png",		8, 24, 24);	
	global.sprPopoPitcherPlantHurt			= sprite_add("../sprites/projectiles/popoexplo/sprPopoPitcherPlantHurt.png",		3, 24, 24);	
	global.sprPopoPitcherPlantDead			= sprite_add("../sprites/projectiles/popoexplo/sprPopoPitcherPlantDead.png",		11, 24, 24);	
	global.sprPopoPitcherPlantCharge		= sprite_add("../sprites/projectiles/popoexplo/sprPopoPitcherPlantCharge.png",		2, 24, 24);	
	global.sprPopoPitcherPlantFire			= sprite_add("../sprites/projectiles/popoexplo/sprPopoPitcherPlantFire.png",		4, 24, 24);	
	global.sprPopoHealFire					= sprite_add("../sprites/projectiles/popoexplo/sprPopoHealFire.png",				8, 8, 16);	
	
	global.sprGreenPopoGunpowderCreep			= sprite_add("../sprites/projectiles/popoexplo/sprGreenPopoGunpowderCreep.png",			18, 24, 24);
	global.sprGreenPopoFireSlash  				= sprite_add("../sprites/projectiles/popoexplo/sprGreenPopoFireSlash.png",				3, 0, 24);	
	global.sprGreenPopoFlameTrail  				= sprite_add("../sprites/projectiles/popoexplo/sprGreenPopoFlameTrail.png",				7, 2, 2);	
	global.sprGreenPopoFlameBullet				= sprite_add("../sprites/projectiles/popoexplo/sprGreenPopoFlameBullet.png", 			2, 8, 8);
	global.sprGreenPopoFlameBulletHit			= sprite_add("../sprites/projectiles/popoexplo/sprGreenPopoFlameBulletHit.png", 		4, 8, 8);
	global.sprGreenPopoFireFly					= sprite_add("../sprites/projectiles/popoexplo/sprGreenPopoFireFly.png", 				13, 0, 0);
	global.sprGreenPopoFlameRocket				= sprite_add("../sprites/projectiles/popoexplo/sprGreenPopoFlameRocket.png", 			1, 9, 4);
	global.sprGreenPopoFlameCreepBubble			= sprite_add("../sprites/projectiles/popoexplo/sprGreenPopoFlameCreepBubble.png", 		6, 8, 8);
    global.sprGreenPopoGunpowderShell	    	= sprite_add("../sprites/projectiles/popoexplo/sprGreenPopoGunpowderShell.png", 			2, 8, 8);
    global.sprGreenPopoGunpowderShellDisappear	= sprite_add("../sprites/projectiles/popoexplo/sprGreenPopoGunpowderShellDisappear.png",	4, 8, 8);
	
	global.sprGreenPopoFireBullet				= sprite_add("../sprites/projectiles/popoexplo/sprGreenPopoFireBullet.png", 			3, 8, 8);
	global.sprGreenPopoFireBulletHit			= sprite_add("../sprites/projectiles/popoexplo/sprGreenPopoFireBulletHit.png", 			4, 8, 8);
	global.sprGreenPopoHeavyFireBullet			= sprite_add("../sprites/projectiles/popoexplo/sprGreenPopoHeavyFireBullet.png", 		3, 12, 12);
	global.sprGreenPopoHeavyFireBulletHit		= sprite_add("../sprites/projectiles/popoexplo/sprGreenPopoHeavyFireBulletHit.png", 	4, 12, 12);
	global.sprGreenPopoFireBulletBounce			= sprite_add("../sprites/projectiles/popoexplo/sprGreenPopoFireBulletBounce.png", 		3, 6, 8);
	global.sprGreenPopoHeavyFireBulletBounce	= sprite_add("../sprites/projectiles/popoexplo/sprGreenPopoHeavyFireBulletBounce.png",	3, 9, 12);
	global.sprGreenPopoFireGunhammerSlash		= sprite_add("../sprites/projectiles/popoexplo/sprGreenPopoFireGunhammerSlash.png", 	4, 0, 24);
	global.sprGreenPopoFireShot					= sprite_add("../sprites/projectiles/popoexplo/sprGreenPopoFireShot.png", 				3, 12, 12);
	global.sprGreenPopoFireFlak					= sprite_add("../sprites/projectiles/popoexplo/sprGreenPopoFireFlak.png", 				2, 11, 10);	
	global.sprGreenPopoFireMuzzle				= sprite_add("../sprites/projectiles/popoexplo/sprGreenPopoFireMuzzle.png", 			1, 7, 7);	
	global.sprGreenPopoGasFire					= sprite_add("../sprites/projectiles/popoexplo/sprGreenPopoGasFire.png", 				6, 10, 10);	 
	global.sprGreenPopoMegaFireBullet			= sprite_add("../sprites/projectiles/popoexplo/sprGreenPopoMegaFireBullet.png", 		3, 18, 18);	 

	global.sprGreenPopoEmber					= sprite_add("../sprites/projectiles/popoexplo/sprGreenPopoEmber.png",					7, 2, 2);	
	global.sprGreenPopoDirectionalExplosion		= sprite_add("../sprites/projectiles/popoexplo/sprGreenPopoDirectionalExplosion.png",	7, 12, 12);	
	global.sprGreenPopoLavaSheet				= sprite_add("../sprites/projectiles/popoexplo/sprGreenPopoLavaSheet.png",				8, 8, 0);	
	global.sprGreenPopoLavaStreak				= sprite_add("../sprites/projectiles/popoexplo/sprGreenPopoLavaStreak.png",				6, 0, 8);	
	global.sprGreenPopoLavaSplash				= sprite_add("../sprites/projectiles/popoexplo/sprGreenPopoLavaSplash.png",				4, 0, 16);	
	global.sprGreenPopoMushroomExplosion		= sprite_add("../sprites/projectiles/popoexplo/sprGreenPopoMushroomExplosion.png",		20, 128, 128);	
	global.sprGreenPopoFlamePuff				= sprite_add("../sprites/projectiles/popoexplo/sprGreenPopoFlamePuff.png",				6, 8, 8);
	global.sprGreenPopoFlameSparkle				= sprite_add("../sprites/projectiles/popoexplo/sprGreenPopoFlameSparkle.png",			6, 8, 8);
	global.sprGreenPopoFlameSparkleBig			= sprite_add("../sprites/projectiles/popoexplo/sprGreenPopoFlameSparkleBig.png",		6, 16, 16);
	global.sprGreenPopoLavaBomb					= sprite_add("../sprites/projectiles/popoexplo/sprGreenPopoLavaBombBig.png", 			2, 12, 12);
	global.sprGreenPopoLavaBombBig				= sprite_add("../sprites/projectiles/popoexplo/sprGreenPopoLavaBombBig.png", 			2, 16, 16);
	global.sprGreenPopoLavaSlash				= sprite_add("../sprites/projectiles/popoexplo/sprGreenPopoLavaSlash.png", 				3, 0, 24);	
	
	AugmentBoilingVeins_spriteinit(); 

	game_start();

#define AugmentBoilingVeins_spriteinit
	var _path		= "../sprites/projectiles/popoexplo/",
		_freakPath	= "../sprites/enemies/explofreakcharged/"
	global.augmentBaseSprites = [
		[sprExplosion,		`${_path}sprPopoRegExplosion.png`,		`${_path}sprGreenPopoRegExplosion.png`,			9, 24, 24],
		[sprSmallExplosion,	`${_path}sprPopoSmallRegExplosion.png`,	`${_path}sprGreenPopoSmallRegExplosion.png`, 	7, 12, 12],
		[sprWeaponFire,		`${_path}sprPopoFire.png`,				`${_path}sprGreenPopoFire.png`, 				7, 8, 8],
		[sprDragonFire,		`${_path}sprPopoFire.png`,				`${_path}sprGreenPopoFire.png`, 				7, 8, 8],
		[sprCannonFire,		`${_path}sprPopoFire.png`,				`${_path}sprGreenPopoFire.png`, 				7, 8, 8],
		[sprFlameBall,		`${_path}sprPopoFlameBall.png`,			`${_path}sprGreenPopoFlameBall.png`, 			6, 16, 16],
		[sprFireShell,		`${_path}sprPopoFireShell.png`,			`${_path}sprGreenPopoFireShell.png`, 			2, 8, 8],
		[sprRocketFlame,	`${_path}sprPopoRocketFlame.png`,		`${_path}sprGreenPopoRocketFlame.png`, 			3, 26, 6],
		[sprNukeFlame,		`${_path}sprPopoNukeFlame.png`,			`${_path}sprGreenPopoNukeFlame.png`, 			3, 32, 12],
		[sprNuke,			`${_path}sprPopoNuke.png`,				`${_path}sprGreenPopoNuke.png`, 				1, 6, 8],
		[sprFlare,			`${_path}sprPopoFlare.png`,				`${_path}sprGreenPopoFlare.png`, 				2, 3, 3],
		
		[sprExploFreakIdle,	`${_freakPath}sprExploFreakChargedIdle.png`,	undefined, 6, 16, 16],
		[sprExploFreakWalk,	`${_freakPath}sprExploFreakChargedWalk.png`,	undefined, 4, 16, 16],
		[sprExploFreakHurt,	`${_freakPath}sprExploFreakChargedHurt.png`,	undefined, 3, 16, 16],
		[sprExploFreakDead,	`${_freakPath}sprExploFreakChargedDead.png`,	undefined, 6, 16, 16],
	]
	
	global.augmentBaseSpritesRestore = [
		sprExplosion,
		sprSmallExplosion,
		sprWeaponFire,
		sprDragonFire,
		sprCannonFire,
		sprFlameBall,
		sprFireShell,
		sprRocketFlame,
		sprNukeFlame,
		sprNuke,
		sprFlare,
		sprExploFreakIdle,
		sprExploFreakWalk,
		sprExploFreakHurt,
		sprExploFreakDead,
	]
	
	global.augmentSpritesMods	= [];
	global.augmentSpriteStorage	= ds_list_create();
	global.augmentSprites		= ds_list_create();

	AugmentBoilingVeins_addsprite("mod", "Frontier_Projectiles", "sprGunpowderCreep",			global.sprPopoGunpowderCreep, 			global.sprGreenPopoGunpowderCreep);	
	AugmentBoilingVeins_addsprite("mod", "Frontier_Projectiles", "sprFireSlash",				global.sprPopoFireSlash, 				global.sprGreenPopoFireSlash);	
	AugmentBoilingVeins_addsprite("mod", "Frontier_Projectiles", "sprFlameTrail",				global.sprPopoFlameTrail,				global.sprGreenPopoFlameTrail);
	AugmentBoilingVeins_addsprite("mod", "Frontier_Projectiles", "sprFlameBullet",				global.sprPopoFlameBullet, 				global.sprGreenPopoFlameBullet);	
	AugmentBoilingVeins_addsprite("mod", "Frontier_Projectiles", "sprFlameBulletHit",			global.sprPopoFlameBulletHit,			global.sprGreenPopoFlameBulletHit);
	AugmentBoilingVeins_addsprite("mod", "Frontier_Projectiles", "sprGunpowderFireFly",			global.sprPopoFireFly, 					global.sprGreenPopoFireFly);	
	AugmentBoilingVeins_addsprite("mod", "Frontier_Projectiles", "sprFlameRocket",				global.sprPopoFlameRocket, 				global.sprGreenPopoFlameRocket);	
	AugmentBoilingVeins_addsprite("mod", "Frontier_Projectiles", "oilColors",					[make_color_rgb(15, 189, 255),			make_color_rgb(0, 114, 250)], [make_color_rgb(0, 255, 0), make_color_rgb(63, 156, 0)]) // yeah this works with any var :)
	AugmentBoilingVeins_addsprite("mod", "Frontier_Projectiles", "sprFlameCreepBubble",			global.sprPopoFlameCreepBubble, 		global.sprGreenPopoFlameCreepBubble);
	AugmentBoilingVeins_addsprite("mod", "Frontier_Projectiles", "sprGunpowderShell",			global.sprPopoGunpowderShell, 			global.sprGreenPopoGunpowderShell);
	AugmentBoilingVeins_addsprite("mod", "Frontier_Projectiles", "sprGunpowderShellDisappear",	global.sprPopoGunpowderShellDisappear, 	global.sprGreenPopoGunpowderShellDisappear);
	
#define game_start
	
	 // Defpack Sprites:
	if(mod_exists("mod", "defpack tools")){
		var _knownIndex = 0;
		var _seeMe		= 0;
		var _sprPath	= mod_variable_get("mod", "defpack tools", "spr")
	    repeat(array_length(global.augmentSpritesMods)){
	        if(global.augmentSpritesMods[_knownIndex] = "defpack tools"){
	            _seeMe += 1;
	        }
	        _knownIndex += 1;
	    }
	    if(_seeMe <= 0){
	    	array_push(global.augmentSpritesMods, "defpack tools");
	    	with(_sprPath){
				AugmentBoilingVeins_addsprite_ext("mod", "defpack tools", "spr", FireBullet, "FireBullet", global.sprPopoFireBullet, global.sprGreenPopoFireBullet);	  
				AugmentBoilingVeins_addsprite_ext("mod", "defpack tools", "spr", FireBulletHit, "FireBulletHit", global.sprPopoFireBulletHit, global.sprGreenPopoFireBulletHit);
				AugmentBoilingVeins_addsprite_ext("mod", "defpack tools", "spr", HeavyFireBullet, "HeavyFireBullet", global.sprPopoHeavyFireBullet, global.sprGreenPopoHeavyFireBullet);	  
				AugmentBoilingVeins_addsprite_ext("mod", "defpack tools", "spr", HeavyFireBulletHit, "HeavyFireBulletHit", global.sprPopoHeavyFireBulletHit, global.sprGreenPopoHeavyFireBulletHit);	  
				AugmentBoilingVeins_addsprite_ext("mod", "defpack tools", "spr", FireBulletBounce, "FireBulletBounce", global.sprPopoFireBulletBounce, global.sprGreenPopoFireBulletBounce);
				AugmentBoilingVeins_addsprite_ext("mod", "defpack tools", "spr", HeavyFireBulletBounce, "HeavyFireBulletBounce", global.sprPopoHeavyFireBulletBounce, global.sprGreenPopoHeavyFireBulletBounce);
				AugmentBoilingVeins_addsprite_ext("mod", "defpack tools", "spr", GasFire, "GasFire", global.sprPopoGasFire, undefined);
	    	}
	    	AugmentBoilingVeins_addsprite("weapon", "flame shot cannon",	"sprShotBullet",				global.sprPopoFireShot, 			global.sprGreenPopoFireShot);	
	    	AugmentBoilingVeins_addsprite("weapon", "fire moby",			"FireBullet",					global.sprPopoFireBullet, 			global.sprGreenPopoFireBullet);	
	    	AugmentBoilingVeins_addsprite("weapon", "big fire iron",		"FireBullet",					global.sprPopoFireBullet, 			global.sprGreenPopoFireBullet);	
			AugmentBoilingVeins_addsprite("weapon", "fire subata",			"sprBullet",					global.sprPopoFireBullet, 			global.sprGreenPopoFireBullet);	
	    	AugmentBoilingVeins_addsprite("weapon", "fire gunhammer",		"sprFireGunhammerSlash",		global.sprPopoFireGunhammerSlash, 	global.sprGreenPopoFireGunhammerSlash);	
	    	AugmentBoilingVeins_addsprite("weapon", "heavy fire gunhammer",	"sprHeavyFireGunhammerSlash",	global.sprPopoFireGunhammerSlash, 	global.sprGreenPopoFireGunhammerSlash);	
	    	AugmentBoilingVeins_addsprite("weapon", "mega fire revolver",	"sprMegaFireBullet",			global.sprPopoMegaFireBullet, 		global.sprGreenPopoMegaFireBullet);	
	    	AugmentBoilingVeins_addsprite("weapon", "sniper fire rifle",	"sprFireMuzzle",				global.sprPopoFireMuzzle, 			global.sprGreenPopoFireMuzzle);	
	    	AugmentBoilingVeins_addsprite("weapon", "sniper fire shotgun",	"sprFireMuzzle",				global.sprPopoFireMuzzle, 			global.sprGreenPopoFireMuzzle);	
	    	AugmentBoilingVeins_addsprite("mod", "defpack tools 2", 		"sprFireFlak",					global.sprPopoFireFlak, 			global.sprGreenPopoFireFlak);	
	    	
	    }
	}
	
	 // Undergrowth Sprites:
	if(mod_exists("mod", "undergrowth")){
		var _knownIndex = 0;
		var _seeMe		= 0;
	    repeat(array_length(global.augmentSpritesMods)){
	        if(global.augmentSpritesMods[_knownIndex] = "undergrowth"){
	            _seeMe += 1;
	        }
	        _knownIndex += 1;
	    }
	    if(_seeMe <= 0){
	    	array_push(global.augmentSpritesMods, "undergrowth");
	  
	    	AugmentBoilingVeins_addsprite("area", "undergrowth",			"sprEmber",						global.sprPopoEmber, 				global.sprGreenPopoEmber);
	    	AugmentBoilingVeins_addsprite("area", "undergrowth",			"sprDirectionalExplosion",		global.sprPopoDirectionalExplosion, global.sprGreenPopoDirectionalExplosion);
	    	AugmentBoilingVeins_addsprite("area", "undergrowth",			"sprLavaSheet",					global.sprPopoLavaSheet, 			global.sprGreenPopoLavaSheet);
	    	AugmentBoilingVeins_addsprite("area", "undergrowth",			"sprLavaStreak",				global.sprPopoLavaStreak, 			global.sprGreenPopoLavaStreak);
	    	AugmentBoilingVeins_addsprite("area", "undergrowth",			"sprLavaSplash",				global.sprPopoLavaSplash, 			global.sprGreenPopoLavaSplash);
	    	AugmentBoilingVeins_addsprite("area", "undergrowth",			"sprMushroomExplosion",			global.sprPopoMushroomExplosion, 	global.sprGreenPopoMushroomExplosion);
	    	AugmentBoilingVeins_addsprite("area", "undergrowth",			"sprFlamePuff",					global.sprPopoFlamePuff, 			global.sprGreenPopoFlamePuff);
	    	AugmentBoilingVeins_addsprite("area", "undergrowth",			"sprFlameSparkle",				global.sprPopoFlameSparkle, 		global.sprGreenPopoFlameSparkle);
	    	AugmentBoilingVeins_addsprite("area", "undergrowth",			"sprFlameSparkleBig",			global.sprPopoFlameSparkleBig, 		global.sprGreenPopoFlameSparkleBig);

			AugmentBoilingVeins_addsprite("weapon", "fossil gun",			"sprLavaBomb",					global.sprPopoLavaBomb, 			global.sprGreenPopoLavaBomb);	    	
			AugmentBoilingVeins_addsprite("weapon", "fossil cannon",		"sprLavaBombBig",				global.sprPopoLavaBombBig, 			global.sprGreenPopoLavaBombBig);
			AugmentBoilingVeins_addsprite("weapon", "fossil hammer",		"sprLavaSlash",					global.sprPopoLavaSlash, 			global.sprGreenPopoLavaSlash);
			
			 // i went a little overboard but them having orange mouths while shooting blue fire annoying me
	    	AugmentBoilingVeins_addsprite("area", "undergrowth",			"sprFireflyIdle",				global.sprPopoFireflyIdle, 			undefined);
	    	AugmentBoilingVeins_addsprite("area", "undergrowth",			"sprFireflyWalk",				global.sprPopoFireflyWalk, 			undefined);
	    	AugmentBoilingVeins_addsprite("area", "undergrowth",			"sprFireflyHurt",				global.sprPopoFireflyHurt, 			undefined);
	    	AugmentBoilingVeins_addsprite("area", "undergrowth",			"sprFireflyDead",				global.sprPopoFireflyDead, 			undefined);
	    	AugmentBoilingVeins_addsprite("area", "undergrowth",			"sprFireflyExplode",			global.sprPopoFireflyExplode, 		undefined);
	    	AugmentBoilingVeins_addsprite("area", "undergrowth",			"sprFlytrapIdle",				global.sprPopoFlytrapIdle, 			undefined);
	    	AugmentBoilingVeins_addsprite("area", "undergrowth",			"sprFlytrapWalk",				global.sprPopoFlytrapWalk, 			undefined);
	    	AugmentBoilingVeins_addsprite("area", "undergrowth",			"sprFlytrapHurt",				global.sprPopoFlytrapHurt, 			undefined);
	    	AugmentBoilingVeins_addsprite("area", "undergrowth",			"sprFlytrapDead",				global.sprPopoFlytrapDead, 			undefined);
	    	AugmentBoilingVeins_addsprite("area", "undergrowth",			"sprFlytrapChrg",				global.sprPopoFlytrapChrg, 			undefined);
	    	AugmentBoilingVeins_addsprite("area", "undergrowth",			"sprFlytrapFire",				global.sprPopoFlytrapFire, 			undefined);
	    	AugmentBoilingVeins_addsprite("area", "undergrowth",			"sprPitcherPlantIdle",			global.sprPopoPitcherPlantIdle, 	undefined);
	    	AugmentBoilingVeins_addsprite("area", "undergrowth",			"sprPitcherPlantWalk",			global.sprPopoPitcherPlantWalk, 	undefined);
	    	AugmentBoilingVeins_addsprite("area", "undergrowth",			"sprPitcherPlantHurt",			global.sprPopoPitcherPlantHurt, 	undefined);
	    	AugmentBoilingVeins_addsprite("area", "undergrowth",			"sprPitcherPlantDead",			global.sprPopoPitcherPlantDead, 	undefined);
	    	AugmentBoilingVeins_addsprite("area", "undergrowth",			"sprPitcherPlantCharge",		global.sprPopoPitcherPlantCharge, 	undefined);
	    	AugmentBoilingVeins_addsprite("area", "undergrowth",			"sprPitcherPlantFire",			global.sprPopoPitcherPlantFire, 	undefined);
	    	AugmentBoilingVeins_addsprite("area", "undergrowth",			"sprHealFire",					global.sprPopoHealFire, 			undefined);

	    }
	}
	
	 // Restore Sprites on run restart:
	if(global.spritesReplaced = true && !skill_get(mod_current)){
		wait(1); // doesnt work without it. I dont know why. It should be ok to put this wait here
		AugmentBoilingVeins_restoresprite();
		exit;
	}
	

#define load_options(_options)

	var _prevSettingProjectiles			= global.settingAugmentProjectiles,
		_prevSettingGreen				= global.settingGreenAugments;
	
	global.settingAugmentProjectiles	= _options.settingAugmentProjectiles;
	global.settingGreenAugments			= _options.settingGreenAugments;
	
	 // Update Sprites on setting changes:
	if(skill_get(mod_current)){
		if(global.spritesReplaced = true && global.settingAugmentProjectiles = false){
			AugmentBoilingVeins_restoresprite();
		}
		if(global.spritesReplaced = false && global.settingAugmentProjectiles != _prevSettingProjectiles){
			AugmentBoilingVeins_resprite();
		}
		if(global.spritesReplaced = true && global.settingAugmentProjectiles != _prevSettingGreen){
			AugmentBoilingVeins_restoresprite();
			AugmentBoilingVeins_resprite();
		}
	}
	
#define skill_name			return loc("Frontier:AugmentBoilingVeins:0", "OVERCHARGED FUEL");
#define skill_text			return loc("Frontier:AugmentBoilingVeins:1", "@wFIRE/EXPLOSIVES @sDEAL MORE DAMAGE#@wEXPLOSIONS @(color:16776960)DESTROY @wENEMY BULLETS");
#define skill_tip			return "BURNS SO BRIGHT";
#define skill_button		sprite_index = global.sprSkillIcon;
#define skill_icon			return global.sprSkillHud;
#define skill_avail			return (mod_variable_get("mod", "Frontier_IDPD", "settingMainPoolAugments") = true) ? 1 : 0;
#define skill_wepspec		return 1;
#define skill_sacrifice		return false;
#define skill_augment		return mut_boiling_veins; 

#define cleanup
	if(global.spritesReplaced = true){
		AugmentBoilingVeins_restoresprite();
	}
	
#define skill_take
	AugmentBoilingVeinsController_create(10016, 10016);
	if(global.settingAugmentProjectiles = true){
		AugmentBoilingVeins_resprite();
	}
	
#define skill_lose
	with(instances_matching(CustomObject, "name", "fr_AugmentBoilingVeinsController")){
		instance_destroy();
	}
	AugmentBoilingVeins_restoresprite();
	
#define step
	if(instance_exists(GenCont) || instance_exists(Menu)){
		global.levelStart = true;
	}
	else if(global.levelStart){
		global.levelStart = false;
		AugmentBoilingVeinsController_create(10016, 10016);
	}

#define AugmentBoilingVeinsController_create(_x, _y)
	with(instance_create(_x, _y, CustomObject)){
		name				= "fr_AugmentBoilingVeinsController"
		on_end_step			= AugmentBoilingVeins_endstep;
	}
	
#define AugmentBoilingVeins_endstep
	with(instances_matching([Flame, FlameBall, FlameShell, Explosion, MeatExplosion], "fr_augmentBoilingVeins", undefined)){
		AugmentBoilingVeins_projectileEffect();
	}
	with(instances_matching(instances_matching(projectile, "is_flame", true), "fr_augmentBoilingVeins", undefined)){
		AugmentBoilingVeins_projectileEffect();
	}
	with(instances_matching(instances_matching(projectile, "is_explosion", true), "fr_augmentBoilingVeins", undefined)){
		AugmentBoilingVeins_projectileEffect();
	}
	with(instances_matching(instances_matching(projectile, "fr_augBoilDmg", true), "fr_augmentBoilingVeins", undefined)){
		AugmentBoilingVeins_projectileEffect();
	}

#define AugmentBoilingVeins_projectileEffect
	if("is_explosion" in self || instance_is(self, Explosion)){
		if(!instance_is(self, PopoExplosion)){
			BoilRadius_create(x, y, self);
		}
	}
	fr_augmentBoilingVeins	= true;
	damage					= round(damage * (1.5 * (skill_get(mod_current))))
	
#define BoilRadius_create(_x, _y, _creator)
	with(instance_create(_x, _y, CustomSlash)){
		name			= "fr_AugmentBoilRadius";
		creator 		= _creator;
		lifeTime		= 3;
		team			= 2;
		
		if(creator.mask_index != undefined){
			mask_index	= creator.mask_index;
		} else {
			mask_index	= creator.sprite_index;
		}
		
		on_anim			= nothing;
		on_step			= BoilRadius_step;
		on_wall			= nothing;
		on_hit			= nothing;
		on_projectile	= BoilRadius_nullify;
		
		return self;
	}
	
#define BoilRadius_step
	lifeTime -= current_time_scale;
	if(!instance_exists(creator) || lifeTime <= 0){
		instance_destroy();
		exit;
	}
	x = creator.x;
	y = creator.y;

#define BoilRadius_nullify
	if(instance_exists(self)) && (other.typ > 0){ 
		with(other){
			if("name" in self){
				if(name = "DirectionalExplosion"){
					exit;
				}
			}
			sound_play_pitchvol(sndPickupDisappear, 1.3 + random(0.2), 0.4)
			with instance_create(x, y, ImpactWrists){ 
				sprite_index = (global.settingGreenAugments ? global.sprGreenNull : global.sprNull);
			}
			instance_destroy();
		} 
	}

#define AugmentBoilingVeins_addsprite(_baseModType, _baseMod, _baseVar, _popospr, _greenspr)
	ds_list_add(global.augmentSpriteStorage, [[_baseModType, _baseMod, _baseVar, undefined, undefined], mod_variable_get(_baseModType, _baseMod, _baseVar)]);
	ds_list_add(global.augmentSprites, [[_baseModType, _baseMod, _baseVar, undefined, undefined], _popospr, _greenspr]);
	
#define AugmentBoilingVeins_addsprite_ext(_baseModType, _baseMod, _spriteVar, _sprite, _spriteName, _popospr, _greenspr)
	 // Same as above but for use with mods like defpack and ntte that use .spr path things for storing sprites.
	var _sprSource	= mod_variable_get(_baseModType, _baseMod, _spriteVar);
	with(_sprSource){
		ds_list_add(global.augmentSpriteStorage, [[_baseModType, _baseMod, _spriteVar, _sprite, _spriteName], _sprite]);
		ds_list_add(global.augmentSprites, [[_baseModType, _baseMod, _spriteVar, _sprite, _spriteName], _popospr, _greenspr]);
	}

#define AugmentBoilingVeins_resprite
	var _color	= global.settingGreenAugments ? 2 : 1
	 // Basegame Sprites:
	var _spr	= global.augmentBaseSprites
    for(var i = 0; i < array_length(_spr); i++){
    	if(_spr[i][_color] != undefined){
        	sprite_replace(_spr[i][0], _spr[i][_color], _spr[i][3], _spr[i][4], _spr[i][5]);
    	}
    }
     // Mod Sprites:
    var _sprites = global.augmentSprites;
    for(var i = 0; i < ds_list_size(_sprites); i++){
        var _spr = ds_list_find_value(_sprites, i)
        	
         // for .spr paths:
        if(_spr[0][3] != undefined){
 	        if(_spr[_color] != undefined){
	        	var _sprSource = mod_variable_get(_spr[0][0], _spr[0][1], _spr[0][2]);
	        	lq_set(_sprSource, _spr[0][4], _spr[1])
	        }       	
	     // normal sprites:
        } else {
	        if(_spr[_color] != undefined){
	        	mod_variable_set(_spr[0][0], _spr[0][1], _spr[0][2], _spr[_color]);
	        }
        }
    }
    global.spritesReplaced = true;
    
#define AugmentBoilingVeins_restoresprite
	 // Basegame Sprites:
    for(var i = 0; i < array_length(global.augmentBaseSpritesRestore); i++){
        sprite_restore(global.augmentBaseSpritesRestore[i]);
    }
     // Mod Sprites:
    var _storage = global.augmentSpriteStorage;
    for(var i = 0; i < ds_list_size(_storage); i++){
        var _spr = ds_list_find_value(_storage, i)
         // for .spr paths:
        if(_spr[0][3] != undefined){
	    	var _sprSource = mod_variable_get(_spr[0][0], _spr[0][1], _spr[0][2]);
	    	lq_set(_sprSource, _spr[0][4], _spr[1])
	     // normal sprites:
        } else {
	        mod_variable_set(_spr[0][0], _spr[0][1], _spr[0][2], _spr[1]);
        }
    }
    global.spritesReplaced = false;
    
#define nothing
#define init

	 // LIB:
	while(!mod_exists("mod", "lib")){wait(1);}
	script_ref_call(["mod", "lib", "getRef"], "mod", mod_current, "scr");
	#macro  scr			global.scr
	#macro  call		script_ref_call
	
		// SETTINGS //
	global.settingLowQualitySerpent			= false; // reduced visual quality of palace serpent
	
		// SOUNDS //
	global.sndPalaceSerpent					= sound_add("../sounds/events/sndPalaceSerpent.ogg");
	global.sndPalaceSerpentRumble			= sound_add("../sounds/events/sndPalaceSerpentRumble.ogg");
	global.sndPalaceSerpentWarning			=[sound_add("../sounds/events/sndPalaceSerpentWarning1.ogg"),
											  sound_add("../sounds/events/sndPalaceSerpentWarning2.ogg"),
											  sound_add("../sounds/events/sndPalaceSerpentWarning3.ogg")]
		
	 
		// SPRITES //
	global.sprGenericTrail  				= sprite_add("../sprites/particles/sprGenericTrail.png",						50, 0, 50);
	
	 // Crush Blocks:
	//global.shdCrushBlock					= sprite_add("../sprites/areas/palace/shdCrushBlock.png",						1, 17, 0);
	global.sprCrushBlockBot					= sprite_add("../sprites/areas/palace/sprCrushBlockBot.png",					1, 18, 34);
	global.sprCrushBlockTop					= sprite_add("../sprites/areas/palace/sprCrushBlockTop.png",					1, 18, 34);
	global.sprCrushBlockTopOff				= sprite_add("../sprites/areas/palace/sprCrushBlockTopOff.png",					1, 18, 34);
	global.sprCrushBlockTopInactive			= sprite_add("../sprites/areas/palace/sprCrushBlockTopInactive.png",			1, 18, 34);
	global.sprCrushBlockGameover			= sprite_add("../sprites/areas/palace/sprCrushBlock.png",						1, 18, 20);
	global.mskCrushBlock					= sprite_add("../sprites/areas/palace/mskCrushBlock.png",						1, 16, 16);
	global.mskCrushBlockInner				= sprite_add("../sprites/areas/palace/mskCrushBlockInner.png", 					1, 16, 16);
	global.sprCrushBlockScorch				= sprite_add("../sprites/areas/palace/sprCrushBlockScorch.png",					1, 18, 25);
	global.sprCrushBlockDebris				= sprite_add("../sprites/areas/palace/sprCrushBlockDebris.png",					6, 16, 16);
	global.sprCrushBlockDestroy				= sprite_add("../sprites/particles/sprCrushBlockDestroy.png",					5, 32, 32);
	
	 // Proto Cache:
	global.shdProtoCache					= sprite_add("../sprites/areas/vault/shdProtoCache.png",						1, 32, 32);
	global.sprProtoCacheBase				= sprite_add("../sprites/areas/vault/sprProtoCacheBase.png",					1, 32, 24);
	global.sprProtoCacheLayerHigh			= sprite_add("../sprites/areas/vault/sprProtoCacheLayerHigh.png",				8, 16, 16);
	global.sprProtoCacheLayerTopLow			= sprite_add("../sprites/areas/vault/sprProtoCacheLayerTopLow.png",				8, 16, 16);
	global.sprProtoCacheLayerTopMid			= sprite_add("../sprites/areas/vault/sprProtoCacheLayerTopMid.png",				8, 16, 16);
	global.sprProtoCacheLayerTopHigh		= sprite_add("../sprites/areas/vault/sprProtoCacheLayerTopHigh.png",			8, 16, 16);
	
	 // Blood Fountain:
	global.mskBloodFountain					= sprite_add("../sprites/areas/vault/mskBloodFountain.png",						1, 24, 12);	 
	global.mskBloodFountainPrompt			= sprite_add("../sprites/areas/vault/mskBloodFountainPrompt.png",				1, 32, 12);	 
	global.sprBloodFountain					= sprite_add("../sprites/areas/vault/sprBloodFountain.png",						4, 24, 12);	 
	global.sprBloodFountainHurt				= sprite_add("../sprites/areas/vault/sprBloodFountainHurt.png",					3, 24, 12);	 
	global.sprBloodFountainDead				= sprite_add("../sprites/areas/vault/sprBloodFountainDead.png",					3, 24, 12);	 
	global.sprBloodFountainUse				= sprite_add("../sprites/areas/vault/sprBloodFountainUse.png",					6, 24, 12);	 
	global.sprBloodFountainUsed				= sprite_add("../sprites/areas/vault/sprBloodFountainUsed.png",					1, 24, 12);	 
	global.sprBloodFountainUsedHurt			= sprite_add("../sprites/areas/vault/sprBloodFountainUsedHurt.png",				3, 24, 12);	 
	global.sprBloodBlossomHarvest			= sprite_add("../sprites/particles/sprBloodBlossomHarvest.png",					4, 16, 12);	 
	global.sprBurdenSparkle					= sprite_add("../sprites/particles/sprBurdenSparkle.png",						4, 8, 8);
	global.sprDarkBloodStreak				= sprite_add("../sprites/particles/sprDarkBloodStreak.png",						7, 8, 8);
	global.sprBloodBlossomPetal				= sprite_add("../sprites/particles/sprBloodBlossomPetal.png",					3, 1, 1);
		
	 // Splitter Guardian:
	global.shdGupGuardian					= sprite_add("../sprites/enemies/gupguardian/shdGupGuardian.png",				1, 32, 48);
	global.mskGupGuardian					= sprite_add("../sprites/enemies/gupguardian/mskGupGuardian.png",				1, 32, 32);
	global.sprGupGuardianIdle				= sprite_add("../sprites/enemies/gupguardian/sprGupGuardianIdle.png",			5, 32, 32);
	global.sprGupGuardianWalk				= sprite_add("../sprites/enemies/gupguardian/sprGupGuardianWalk.png",			8, 32, 32);
	global.sprGupGuardianHurt				= sprite_add("../sprites/enemies/gupguardian/sprGupGuardianHurt.png",			3, 32, 32);
	global.sprGupGuardianDead				= sprite_add("../sprites/enemies/gupguardian/sprGupGuardianDead.png",			8, 32, 32);
	global.sprGeepGuardianIdle				= sprite_add("../sprites/enemies/gupguardian/sprGeepGuardianIdle.png",			5, 24, 24);
	global.sprGeepGuardianWalk				= sprite_add("../sprites/enemies/gupguardian/sprGeepGuardianWalk.png",			8, 24, 24);
	global.sprGeepGuardianHurt				= sprite_add("../sprites/enemies/gupguardian/sprGeepGuardianHurt.png",			3, 24, 24);	
	global.sprGeepGuardianDead				= sprite_add("../sprites/enemies/gupguardian/sprGeepGuardianDead.png",			8, 32, 32);
	global.sprGipGuardianIdle				= sprite_add("../sprites/enemies/gupguardian/sprGipGuardianIdle.png",			5, 15, 19);
	global.sprGipGuardianWalk				= sprite_add("../sprites/enemies/gupguardian/sprGipGuardianWalk.png",			8, 15, 19);
	global.sprGipGuardianHurt				= sprite_add("../sprites/enemies/gupguardian/sprGipGuardianHurt.png",			3, 15, 19);
	global.sprGipGuardianDead				= sprite_add("../sprites/enemies/gupguardian/sprGipGuardianDead.png",			7, 24, 24);
	
	 // Palace Serpent:
	global.mskPalaceSerpent					= sprite_add("../sprites/areas/palace/mskPalaceSerpent.png",					1, 1184, 70);
	global.sprPalaceSerpentHead				= sprite_add("../sprites/areas/palace/sprPalaceSerpentHead.png",				1, 55, 54); 
	global.sprPalaceSerpentBody				= sprite_add("../sprites/areas/palace/sprPalaceSerpentBody.png",				8, 33, 33); 
	global.sprPalaceSerpentBodyBack			= sprite_add("../sprites/areas/palace/sprPalaceSerpentBodyBack.png",			1, 33, 33); 
	global.sprPalaceSerpentRing				= sprite_add("../sprites/areas/palace/sprPalaceSerpentRings.png",				1, 62, 93); 
	global.sprPalaceSerpentTail				= sprite_add("../sprites/areas/palace/sprPalaceSerpentTail.png",				1, 62, 93);
	global.sprSerpentPath					= sprite_add("../sprites/areas/palace/sprPalaceSerpentPath.png",				6, 230, 37);
	global.sprPalaceSerpentTrail			= sprite_add("../sprites/areas/palace/sprPalaceSerpentTrail.png",				6, 4, 4);
	global.sprPalaceSerpentTrail2			= sprite_add("../sprites/areas/palace/sprPalaceSerpentTrail2.png",				6, 4, 4);
	global.sprPalaceSerpentGameover			= sprite_add("../sprites/areas/palace/sprPalaceSerpentGameover.png",			1, 64, 27); 
	global.sprLQPalaceSerpent				= sprite_add("../sprites/areas/palace/sprLQPalaceSerpent.png",					1, 2368, 69); 

	 // Palace Flametrap:
	global.sprTrapPalace					= sprite_add("../sprites/areas/palace/sprFlameTrapPalace.png", 					1, 8, 8);
	global.sprTrapPalaceGameover			= sprite_add("../sprites/areas/palace/sprFlameTrapPalaceGameover.png", 			1, 16, 16);
	global.sprRadTrapFire					= sprite_add("../sprites/projectiles/sprRadTrapFire.png",						7, 8, 8);
	
	 // Throne Room Telepormer:
	global.mskThroneTeleporter  			= sprite_add("../sprites/areas/palace/mskThroneTeleporter.png",					1, 32, 16);
	global.sprThroneTeleporter  			= sprite_add("../sprites/areas/palace/sprThroneTeleporter.png",					8, 32, 16);
	global.sprThroneTeleporterInactive  	= sprite_add("../sprites/areas/palace/sprThroneTeleporterInactive.png",			1, 32, 16);

		// VARS //
	global.surfaceProtoCache				= -4;
	global.serpentSound						= -4;
	global.serpentSoundRumble				= -4;

#define cleanup
	if surface_exists(global.surfaceProtoCache){
		surface_destroy(global.surfaceProtoCache);
	}
	
//#region OBJECTS

	// ty spazprojects (I redeemed my christmas coupon so he helped a Lot with these, he did the original code these are based on)
#define CrushBlock_create(_x, _y)
	with instance_create(_x, _y, CustomProjectile){
		
		name				= "fr_CrushBlock";
		
		sprite_index		= global.sprCrushBlockBot;
		spr_top_on			= global.sprCrushBlockTop;
		spr_top_off			= global.sprCrushBlockTopOff;
		spr_top_inactive	= global.sprCrushBlockTopInactive;
		spr_top 			= spr_top_off;
		spr_gameover		= global.sprCrushBlockGameover;
	//	spr_shadow			= global.shdCrushBlock;
	//	spr_shadow_y		= 16;
		mask_index			= global.mskCrushBlockInner;
		depth				= 0;
		hitid				= [spr_gameover, "CRUSH TRAP"]
		
		detect_radius		= 240;
		active				= false;
		moveCooldown		= 90; // cooldown for a sec so no spawnkill
		moveCooldownMax		= 40;
		smushCooldown		= 0;
		
		crushspeed			= 6;
		damage				= 8;
		damage_enemy		= 30;
		typ					= 0;
		solid				= true;
		
		jailTime			= 0;	
									
		myWallGetReal		= 12;	// moving this to be created a bit later because it has issues where they break during levelgen if next to other traps
		myWallisReal		= false;
		mywall				= noone;
		
		on_step 			= script_ref_create(crushBlock_step);
		on_end_step 		= script_ref_create(crushBlock_endstep);
		on_hit				= nothing
		on_wall				= script_ref_create(CrushBlock_wall);
		on_destroy			= script_ref_create(CrushBlock_destroy);
		
		script_bind_draw(CrushBlock_draw, -7, self)
		
				
		return self;
	}

#define CrushBlock_draw(_block)

	if(!instance_exists(_block)){
		instance_destroy();
		exit;
	}
	draw_sprite_ext(_block.spr_top, _block.image_index, _block.x, _block.y, _block.image_xscale, _block.image_yscale, _block.image_angle, _block.image_blend, _block.image_alpha)
	//draw_sprite_ext(_block.spr_shadow, 0, _block.x, _block.y + _block.spr_shadow_y, _block.image_xscale, _block.image_yscale, 0, c_white, 0.4)

#define crushBlock_step

	// Spawn Wall - doing it after inital spawn prevents weird issues when they spawn next to eachother:
	if(myWallGetReal > 0){
		myWallGetReal -= current_time_scale;
	}
	if(myWallGetReal <= 0 && !instance_exists(mywall) && myWallisReal = false){
		myWallisReal = true;
		mywall = crushBlock_wall_create(self);
		CrushBlockController_create(x, y, self, mywall)
	}

	//mywall tracking
	if(!instance_exists(mywall) && myWallisReal = true){
		instance_destroy();
		exit;
	}

	// Prevent softlocks - go to jail
	/* pretty much is for telling it to just blow up if the player has been next to it for like 5 minutes  // its 30 seconds now. what was he thinking
		technically you could just stand next to one thats not softlocking you but whatever
		the lore reason for this happening is the player is using their mind to destroy the crushtrap by pure willpower alone
		you must remain uncaged. you will not stay in stupid baby jail for more than 5 minutes.
	*/
	if(distance_to_object(Player) < 24){
		jailTime += current_time_scale;
	} else {
		if(jailTime > 0){
			jailTime -= (4 * current_time_scale);
		}
	}
	if(jailTime = 1000){
		with(mywall){
			instance_destroy();
			exit;
		}
	}
	
	//inactive code
	if (!active && moveCooldown <= 0){
		var detected = noone;
		
		//track players
		with(Player){
			//save vars
			var dx = x - other.x;
			var dy = y - other.y;
			var absx = abs(dx);
			var absy = abs(dy);
			

			
			// x movement tracking:
			other.mywall.x += 100000;
			if(
				(absy <= 16) 
				&& (absx <= other.detect_radius)
				&& !collision_line(other.x,other.y + 8, x, other.y + 8, Wall, false, false)
				&& !collision_line(other.x,other.y - 8, x, other.y - 8, Wall, false, false)
			){
				other.direction 	= (sign(dx) ? 0 : 180);
				detected			= self;
			}
			
			//y movement tracking
			if(
				(absx <= 16) 
				&& (absy <= other.detect_radius)
				&& !collision_line(other.x + 8,other.y, other.x + 8, y, Wall, false, false)
				&& !collision_line(other.x - 8,other.y, other.x - 8, y, Wall, false, false)
			){
				other.direction 	= (sign(dy) ? 270 : 90);
				detected			= self;
			}
			other.mywall.x -= 100000;
		}
		
		//if a player is found
		if detected != noone {
			//set speed and active
			other.speed 		= crushspeed;
			other.active		= true;
			sound_play_pitchvol(sndMenuOptions, 1.1 + random(0.1), 1.2);
			sound_play_pitchvol(sndNukeFire, 1.6 + random(0.1), 0.7);
		}
	}
	
	 // Cosmetics:
	if(active = true){
		spr_top = spr_top_on;
		
		with(instance_create(x + random_range(-16, 16), y + random_range(-16, 16), Sweat)){
			image_blend		= make_colour_rgb(190, 253, 8);
			direction		= other.direction + 180;
		}
		
		if(random(3) < 1){
			with(instance_create(x + random_range(-16, 16), y + random_range(-16, 16), Dust)){
				direction		= other.direction + 180;
				speed			= 1 + random(3);
			}	
		}
		
		if(random(8) < 1){
			with(instance_create(x, y, ScorchTop)){
				sprite_index	= global.sprCrushBlockScorch;
				image_angle		= other.direction + 90 + random_range(-4, 4);
			}
		}
		
	} else {
		spr_top = spr_top_off
	//	spr_top = moveCooldown <= 0) ? spr_top_off : spr_top_inactive; loser mode
	}

	 // Cooldowns:
	if(moveCooldown > 0){
		moveCooldown -= current_time_scale;
	}
	if(smushCooldown > 0){
		smushCooldown -= current_time_scale;
	}
	
	
	 // Push Objects:
	x += hspeed_raw;
	y += vspeed_raw;
	
	var inst = call(scr.instances_in_rectangle, x - 16 - speed, y - 16 - speed, x + 16 + speed, y + 16 + speed, [hitme, chestprop]);
	with (inst){
		
		 // Crush Props:
		if(instance_is(self, prop)){
			instance_destroy();
			exit;
		}
		
		 // HammerHead:
		if(instance_is(self, Player)){
			if(hammerhead > 0) || skill_get(mut_hammerhead){
				with(other.mywall){
					sound_play_pitchvol(sndHammerHeadProc, 0.6, 3)
					sound_play_pitch(sndHammerHeadEnd, 0.8)
					instance_destroy();
					exit;
				}
			}
		}
		
		var xcollide = false;
		var ycollide = false;
		
		if (other.hspeed != 0 && place_meeting(x + hspeed_raw, y, other)){
			xcollide = true;
			hspeed = 0;
		}
		
		if (other.vspeed != 0 && place_meeting(x, y + vspeed_raw, other)){
			ycollide = true;
			vspeed = 0;
		}

		if (xcollide){
			var oldX = x;
			
			x += other.hspeed_raw;
			move_outside_solid(other.direction, other.speed);
			
			 // Prevent Clipping when pressed up to walls:
			var newX = x - other.hspeed_raw;
			if(newX != oldX){ direction = other.direction; }
			
		}
		if (ycollide){
			var oldY = y;
			
			y += other.vspeed_raw;
			move_outside_solid(other.direction, other.speed);
			
			 // Prevent Clipping when pressed up to walls:
			var newY = y - other.vspeed_raw;
			if(newY != oldY){ direction = other.direction; }
		}
		
			
	}
	
	x -= hspeed_raw;
	y -= vspeed_raw;

	
#define crushBlock_endstep
	if !instance_exists(mywall){
		exit;
	}

	 // Move Self & Wall:
	x = xprevious + hspeed_raw;
	y = yprevious + vspeed_raw;
	xprevious = x;
	yprevious = y;
	mywall.x = x
	mywall.y = y
	mywall.xprevious = mywall.x;
	mywall.yprevious = mywall.y;

	 // Lock to Grid:
	if (active = false && speed >= 0){
		y = yprevious;
		y = round(y / 16) * 16;
		x = xprevious;
		x = round(x / 16) * 16;
	}

#define CrushBlock_wall

     // Collide into Wall:
	if(other = mywall){
		xprevious = x;
		yprevious = y;
	} else {
			
		 // CRUSH!
		 // JUDGEMENT!
		 // DIE!
		if(smushCooldown <= 0){
			CrushBlockSmush_create(x, y, self)
			smushCooldown += 1;
		}
		
		 // Im Done!
		speed			= 0;
		active			= false;
		moveCooldown	= moveCooldownMax
		
		
		 // FX + SFX:
		view_shake_at(x, y, 100);
		sound_play_pitchvol(sndWallBreak, 0.8 + random(0.2), 1);
		sound_play_pitchvol(sndMeleeWall, 0.3 + random(0.2), 1);
		repeat(12){
			with instance_create(x + random_range(-12, 12), y + random_range(-12, 12), Dust){
				direction	= other.direction + 180 + random_range(-40, 40)
				speed		= 2 + random(2);
			}
		}
	}
	
#define CrushBlock_destroy

	sound_play_pitchvol(sndGeneratorBreak, 1, 3)
	sound_play_pitchvol(sndBigGeneratorBreak, 1.3, 0.3)
	instance_create(x, y, Scorch)
	with(instance_create(x, y, BulletHit)){
		sprite_index	= global.sprCrushBlockDestroy;
	}
	repeat(5 + random(3)){
		with instance_create(x, y, Debris){
			sprite_index	= global.sprCrushBlockDebris;
			image_index		= irandom(image_number)
			direction		= random(360);
			speed			= 3 + random(3);
		}
	}
	
	if(instance_exists(mywall)){
		with(mywall){
			instance_destroy();
		}
	}

#define CrushBlockSmush_create(_x, _y, _creator)
	with instance_create(_x, _y, CustomProjectile){
		creator			= _creator;
		damage			= creator.damage;
		damage_enemy	= creator.damage_enemy;
		hitid			= creator.hitid;
		mask_index		= global.mskCrushBlock;
		typ				= 0;
		swipswap		= false;
		
		on_wall			= nothing;
		on_hit			= CrushBlockSmush_hit;
		on_step			= CrushBlockSmush_step;
	}

#define CrushBlockSmush_hit
	
	 // Deal more damage to enemies than players:
	if(instance_is(other, Player)){
		projectile_hit(other, damage)
	} else {
		projectile_hit(other, damage_enemy)
	}
	
	if(swipswap = false){
		swipswap			= true;
		if(!instance_exists(creator)){ exit; }
		creator.active		= true;
		creator.speed		= creator.crushspeed;
		creator.direction  += 180
	}

#define CrushBlockSmush_step
	wait(1);
	if(!instance_exists(self)){ exit; }
	instance_destroy();
	exit;

#define crushBlock_wall_create(_creator)
	with instance_create(_creator.x, _creator.y, Wall){
		
		sprite_index	= mskNone;
		topspr			= mskNone;
		outspr			= mskNone;
		spr_shadow		= mskNone;
		mask_index		= global.mskCrushBlock;
		creator			= _creator;
		image_blend 	= c_aqua;
		
		return self;
	}
	
 // Crush Block Controller:
 // this thing is needed so portalshocks dont ruin everything
#define CrushBlockController_create(_x, _y, _block, _wall)
	with instance_create(_x, _y, CustomObject){
		name				= "fr_CrushBlockController"
		block				= _block;
		mywall				= _wall;
		
		on_step				= CrushBlockController_step;
	}

#define CrushBlockController_step
	
	if(!instance_exists(mywall) && !instance_exists(block)){
		CrushBlock_destroy();
		instance_delete(self);
		exit;
	}
	
	if(instance_exists(mywall) && !instance_exists(block)){
		CrushBlock_destroy();
		with(mywall){
			instance_destroy();
		}
		instance_delete(self);
		exit;
	}
	
	x = block.x;
	y = block.y;

//#endregion
//#region VAULT OBJECTS
#define ProtoCache_create(_x, _y)
	with(instance_create(_x, _y, CustomObject)){
		name = "fr_ProtoCache";
		
         // Upgrade Cache:
    	call(scr.save_set, "Frontier", "cache_level", ((call(scr.save_get, "Frontier", "cache_level")) + 1));
    
         // Keep at Max of 15:
    	if((call(scr.save_get, "Frontier", "cache_level")) > 15){ 
    		call(scr.save_set, "Frontier", "cache_level", 15); 
    	}
   
		cacheValue 		= (call(scr.save_get, "Frontier", "cache_level"))
		
		 // should hopefully fix a weird bug some have experience with cache values of -1.
		if(cacheValue <= 0){
			cacheValue = 1;
		}
		
		 // Visuals:
		sprite_index	= mskNone;
		spr_shadow      = global.shdProtoCache;
		spr_shadow_y	= -12
		layerAngle		= 0;
		text			= "OPEN?"
		extraSpeen		= 0;
		layerCount		= ceil(cacheValue / 3)

		layerSprites	= [global.sprProtoCacheLayerHigh, global.sprProtoCacheLayerHigh, global.sprProtoCacheLayerHigh, global.sprProtoCacheLayerHigh, global.sprProtoCacheLayerHigh]
		
		 // This Is Crap but idk how to fix it and it only runs on the object creation so its not too bad, fix later if u figure it out.
		if(cacheValue <= 3){
			if(cacheValue = 1){ layerSprites[0] = global.sprProtoCacheLayerTopLow;	}
			if(cacheValue = 2){ layerSprites[0] = global.sprProtoCacheLayerTopMid;	}
			if(cacheValue = 3){ layerSprites[0] = global.sprProtoCacheLayerTopHigh; }
		}
		if(cacheValue <= 6){
			if(cacheValue = 4){ layerSprites[1] = global.sprProtoCacheLayerTopLow;	}
			if(cacheValue = 5){ layerSprites[1] = global.sprProtoCacheLayerTopMid;	}
			if(cacheValue = 6){ layerSprites[1] = global.sprProtoCacheLayerTopHigh; }
		}
		if(cacheValue <= 9){
			if(cacheValue = 7){ layerSprites[2] = global.sprProtoCacheLayerTopLow;	}
			if(cacheValue = 8){ layerSprites[2] = global.sprProtoCacheLayerTopMid;	}
			if(cacheValue = 9){ layerSprites[2] = global.sprProtoCacheLayerTopHigh; }
		}
		if(cacheValue <= 12){
			if(cacheValue = 10){ layerSprites[3] = global.sprProtoCacheLayerTopLow;	 }
			if(cacheValue = 11){ layerSprites[3] = global.sprProtoCacheLayerTopMid;	 }
			if(cacheValue = 12){ layerSprites[3] = global.sprProtoCacheLayerTopHigh; }
		}
		if(cacheValue <= 15){
			if(cacheValue = 13){ layerSprites[4] = global.sprProtoCacheLayerTopLow;	 }
			if(cacheValue = 14){ layerSprites[4] = global.sprProtoCacheLayerTopMid;	 }
			if(cacheValue = 15){ layerSprites[4] = global.sprProtoCacheLayerTopHigh; }
		}
		
		layerTop		= layerCount;
		layerTop_y		= [0, 12, 20, 28, 36, 44];
		
		 // Vars:
		mask_index		= mskNone;
		prompt      	= noone;
		openCheck		= false
		opened      	= false;
		lootDelay		= 60;
		loot			= 0;
		lootRewards		= [];
		
		 // Events:
		on_step			= script_ref_create(ProtoCache_step);
		on_draw			= ProtoCache_draw;
		on_cleanup		= script_ref_create(ProtoCache_cleanup);
		on_alrm2		= script_ref_create(ProtoCache_alrm2)
		
		 // Alarms:
		
		 // Prompt:
		with(call(scr.prompt_create, text)){ 
			on_step = ProtoCachePrompt_step;
			creator = other;
		}
		
		 // Baseplate:
		with(instance_create(_x, _y, CustomObject)){
			sprite_index	= global.sprProtoCacheBase;
			mask_index		= mskNone;
			image_speed 	= 0;
			depth			= 6;
			speed			= 0;
		}
		
		return self;
	}
	
#define ProtoCachePrompt_step
	if(pick != -1){ 
		with(creator){
			opened = true;
	    	 // Update Stat:
			call(scr.save_set, "Frontier", "caches_opened", ((call(scr.save_get, "Frontier", "caches_opened")) + 1));
		}
		instance_destroy();
		exit;
	}
	if !instance_exists(creator){ 
		instance_destroy();
	}

#define ProtoCache_step
	x = xstart;
	y = ystart;
	speed = 0;
	
	 // Alarms:
	if("on_alrm2" in self and alarm2_run) exit;

	 // Clear Torches:
	if(distance_to_object(Torch) < 20){ 
		with(instance_nearest(x, y, Torch)){ 
			instance_delete(self); 
		} 
	}
	
	 // Spin...
	if(opened = false){
		layerAngle += 1.5 * current_time_scale;
	}
	
	 // Open:
	if(opened = true){
		
		 // Spin!!
		if(extraSpeen < 20){ 
			extraSpeen += 0.4;
		}
		layerAngle += extraSpeen * current_time_scale;
		if(current_frame_active){
			with instance_create(x, y - layerTop_y[layerTop], PlasmaTrail){ 
				sprite_index	= choose(sprEatBigRad, sprEatRad) 
				direction		= 90 + random_range(-40,40); 
				speed			= 3 + random(2); 
				depth			= -10; 
			}
		}
		
		 // Open Cache:
		if(lootDelay > 0){
			lootDelay -= current_time_scale;
		} else {
			if(openCheck = false){
				openCheck = true;
				 // Reset Cache Level:
		    	call(scr.save_set, "Frontier", "cache_level", 0);
		    	
		    	 // Start Opening Process:
				alarm2 = 10;
				
				 // Generate Lootpool:
				 
				 // LOOT VALUES!!
				var _cacheLoot_rads			= (20 + 20 * cacheValue),
					_cacheLoot_ammo			= (cacheValue * 2),
					_cacheLoot_health		= (cacheValue),
					_cacheLoot_weapon		= (cacheValue / 1.5),
					_cacheLoot_maxRads		= (cacheValue / 5),
					_cacheLoot_maxAmmo		= (cacheValue / 5),
					_cacheLoot_maxHealth	= (cacheValue / 5)
					

				 // Max Health Pickups:
				if(cacheValue >= 11){
					repeat(_cacheLoot_maxHealth){
						array_push(lootRewards, "MaxHealthPickup_create");
					}	
				}
				 // Max Ammo Pickups:
				if(cacheValue >= 9){
					repeat(_cacheLoot_maxAmmo + irandom(_cacheLoot_maxAmmo / 5)){
						array_push(lootRewards, "MaxAmmoPickup_create");
					}	
				}
				 // Max Rad Pickups:
				if(cacheValue >= 6){
					repeat(_cacheLoot_maxRads + irandom(_cacheLoot_maxRads / 3)){
						array_push(lootRewards, "MaxRadPickup_create");
					}
				}
				 // Weapons:
				if(cacheValue >= 3){
					repeat(_cacheLoot_weapon + irandom(_cacheLoot_weapon / 3)){
						array_push(lootRewards, WeaponChest);
						if(cacheValue > 7) && (random(3) < 1){
							array_push(lootRewards, BigWeaponChest);
						}
					}
					repeat(_cacheLoot_ammo + irandom(_cacheLoot_ammo / 3)){
						array_push(lootRewards, AmmoPickup);
					}
				}
				 // Health:
				repeat(_cacheLoot_health + irandom(_cacheLoot_health / 2)){
					array_push(lootRewards, HPPickup);
					if(cacheValue > 6) && (random(3) < 1){
						array_push(lootRewards, HealthChest);
					}
				}
				 // Ammo:
				repeat(_cacheLoot_ammo + irandom(_cacheLoot_ammo / 3)){
					array_push(lootRewards, AmmoPickup);
				}
				
				loot  = array_length(lootRewards);
				
				 // Sounds:
				sound_play_pitchvol(sndBigGeneratorBreak,	1.6, 1);
				sound_play_pitchvol(sndPillarBreak, 		1.2, 1);
				sound_play_pitchvol(sndBigWeaponChest,		1.2, 1);
				sound_play_pitchvol(sndMutLastWish, 		0.8, 3);
				
				 // Rads:
				 // Rads just burst out right at the start so just spawn them here:
				if(_cacheLoot_rads < 100){
					repeat(_cacheLoot_rads){
						with instance_create(x, y, Rad){
							direction	= random(360);
							speed		= 4;
						}
					}
				} else {
					repeat(_cacheLoot_rads / 8){
						with instance_create(x, y, BigRad){
							direction	= random(360);
							speed		= 4;
						}
					}
				}
			}
		}
	}
	

#define ProtoCache_alrm2
	
	if(loot > 0){
		alarm2 = 1;
		
		 // Spawn Loot:
		var _lootObject = lootRewards[loot - 1]
		if(is_string(_lootObject)){
			with(mod_script_call("mod", "Frontier_Pickups", _lootObject, x, y - layerTop_y[layerTop])){
				with(mod_script_call("mod", "Frontier_Objects", "ZAxisToss_create", x, y)){
					direction   	= random(360);
					speed       	= 3 + random(3)
					zspeed      	= 7;
					zfriction		= 0.7;
					creator     	= other;
					depth       	= other.depth;
					mask_index  	= other.mask_index;
					if("spr_shadow_y" in other){
						spr_shadow_y = other.spr_shadow_y;
					}	
				}
			}
		} else {
			with(instance_create(x, y - layerTop_y[layerTop - 1], _lootObject)){
				with(mod_script_call("mod", "Frontier_Objects", "ZAxisToss_create", x, y)){
					direction   	= random(360);
					speed       	= 3 + random(3)
					zspeed      	= 7;
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
    				
		 // End Opening:
		if(--loot <= 0){
			alarm2 = 40;
		}
	} else {
		alarm2		= 8;
		
		layerTop   -= 1;
		with instance_create(x, y - layerTop_y[layerTop] - 8, PlasmaTrail){ 
			sprite_index	= sprGreenExplosion; 
		}
		sound_play_pitchvol(sndExplosionS, 0.7 + random(0.2), 1);
		
		if(--layerCount <= 0){
			instance_destroy();
		}
	}

#define ProtoCache_draw

	 // Shadow:
	draw_sprite_ext(spr_shadow, 0, x, y + spr_shadow_y, 1, 1, 0, c_white, 0.3)
	
	if !surface_exists(global.surfaceProtoCache){
		global.surfaceProtoCache = surface_create(game_width, game_height)
	}
	
	surface_set_target(global.surfaceProtoCache)
		
	var ns_x		= view_xview_nonsync; 
	var ns_y		= view_yview_nonsync;
	var stack		= 1; // repeats in a single pixel stack
	var height		= 8; // frames/height of spritestack
	
	draw_clear_alpha(c_white, 0) 
	
	for (var i = 0; i <= height; i ++;){
		for (var s = 1; s <= stack; s ++;){
			var o = ((s - 1) / stack);

			if(layerCount >= 1){
				for(i = 0; i < sprite_get_number(layerSprites[0]); i++){
					draw_sprite_ext(layerSprites[0], i, x - ns_x, y - (i - o) - layerTop_y[1] - ns_y, image_xscale, image_yscale, layerAngle + direction, image_blend, image_alpha);
				}
			}
			if(layerCount >= 2){
				for(i = 0; i < sprite_get_number(layerSprites[0]); i++){
					draw_sprite_ext(layerSprites[1], i, x - ns_x, y - (i - o) - layerTop_y[2] - ns_y, image_xscale, image_yscale, -layerAngle + direction + 180, image_blend, image_alpha);
				}
			}
			if(layerCount >= 3){
				for(i = 0; i < sprite_get_number(layerSprites[0]); i++){
					draw_sprite_ext(layerSprites[2], i, x - ns_x, y - (i - o) - layerTop_y[3] - ns_y, image_xscale, image_yscale, layerAngle + direction, image_blend, image_alpha);
				}
			}
			if(layerCount >= 4) {
				for(i = 0; i < sprite_get_number(layerSprites[0]); i++){
					draw_sprite_ext(layerSprites[3], i, x - ns_x, y - (i - o) - layerTop_y[4] - ns_y, image_xscale, image_yscale, -layerAngle + direction + 180, image_blend, image_alpha);
				}
			}
			if(layerCount >= 5) {
				for(i = 0; i < sprite_get_number(layerSprites[0]); i++){
					draw_sprite_ext(layerSprites[4], i, x - ns_x, y - (i - o) - layerTop_y[5] - ns_y, image_xscale, image_yscale, layerAngle + direction, image_blend, image_alpha);
				}
			}
		}
	}
		
	surface_reset_target()
	
	 // Outlines:
	draw_surface_ext(global.surfaceProtoCache, ns_x + 1, ns_y, 1, 1, 0, c_black,1)
	draw_surface_ext(global.surfaceProtoCache, ns_x - 1, ns_y, 1, 1, 0, c_black,1)
	draw_surface_ext(global.surfaceProtoCache, ns_x, ns_y + 1, 1, 1, 0, c_black,1)
	draw_surface_ext(global.surfaceProtoCache, ns_x, ns_y - 1, 1, 1, 0, c_black,1)

	draw_surface(global.surfaceProtoCache, ns_x, ns_y)
	

#define ProtoCache_cleanup
	if surface_exists(global.surfaceProtoCache){
		surface_destroy(global.surfaceProtoCache);
	}

#define BloodFountain_create(_x, _y, _level)
	with(instance_create(_x, _y, CustomProp)){
		
		name = "fr_BloodFountain";
		
		 // Visual:
		spr_idle		= global.sprBloodFountain;
		spr_hurt		= global.sprBloodFountainHurt;
		spr_dead		= global.sprBloodFountainDead;
		spr_use			= global.sprBloodFountainUse;
		spr_used		= global.sprBloodFountainUsed;
		spr_hurt_used	= global.sprBloodFountainUsedHurt;
		sprite_index	= spr_idle;
		image_speed 	= 0.4;
		
		  // Vars:
		mask_index		= global.mskBloodFountain;
		snd_hurt		= sndHitRock;
		snd_dead		= sndPillarBreak;
		activated		= false;
		text			= loc("Frontier:BloodFountainPrompt",	"@wHARVEST?#@sMORE @wENEMIES#@sLESS @gRADS");
		burden_text		= loc("Frontier:BloodFountainText:0",	"BURDENED WITH");
		burden_subtext	= loc("Frontier:BloodFountainText:1",	"BLOSSOMING#BLOODSHED");
		pick			= -1;
		maxhealth		= 60;
		my_health		= maxhealth;
		VAGGYBONDESPLSNOSHOOT = true;
		
		on_step	= BloodFountain_step;
		on_hurt = Prop_hurt;
		
		 // Events:
		with(call(scr.prompt_create, text)){ 
			mask_index	= global.mskBloodFountainPrompt;
			on_step 	= BloodFountainPrompt_step; 
			creator 	= other; 
		}
		
		return self;
	}
	
#define BloodFountainPrompt_step
	if(pick != -1){ 
		with(creator){ 
			pick = 1; 
		} 
	}
	if(!instance_exists(creator)){ 
		exit; 
	}
	if(creator.activated = true){ 
		instance_destroy();
	}
	
#define BloodFountain_step
	x = xstart;
	y = ystart;
	speed = 0;
	
	 // Animate:
	if(anim_end){
		if(spr_idle = spr_use){
			spr_idle = spr_used;
		}
		sprite_index = spr_idle;
	}

	 // ACTIVATE!
	if(pick != -1 && activated = false){
		 // Fountain Effects:
		activated		= true;
		image_index		= 0;
		spr_idle		= spr_use;
		sprite_index	= spr_idle;
		spr_hurt		= spr_hurt_used;
		
		with(instance_create(x, y - 6, BulletHit)){
			sprite_index	= global.sprBloodBlossomHarvest;
			depth			= -5;
		}
		repeat(5){
			with(instance_create(x, y, BloodStreak)){
				sprite_index	= global.sprDarkBloodStreak;
				image_index		= irandom(1);
				speed			= 2 + random(2);
				direction		= random(360);
			}
		}
		repeat(12){
			with(instance_create(x, y, Feather)){
				sprite_index	= global.sprBloodBlossomPetal;
				image_index		= irandom(2);
				image_speed		= 0;
				depth			= other.depth - 1;
				fall			= 30 + irandom(20);
				speed			= 4 + random(3);
				friction		= 0.05;
				direction		= random(360);
			}
		}

		 // Game Changers:
		skill_set("BurdenBlood", 1)
		
		 // Sounds:
		sound_play_pitchvol(sndStrongSpiritLost, 0.7, 1)
		sound_play_pitchvol(sndBloodCannon, 1.2, 1)
		
		
		// Burden Text:
		with(mod_script_call("mod", "Frontier_Objects", "SpecialPopupText_create", x, y - 40, burden_text, burden_subtext)){
			sub_color	 = make_colour_rgb(156, 17, 17);
			sub_sound	 = sndCursedReminder;
		}

		// Yikes!
		mod_script_call("mod", "Frontier_Objects", "SpecialPopupTextJinkies_create", x + 35, y - 25);
		
    	// Particles on Take:
		with(Player){
    		with(instance_create(x,y,ImpactWrists)){ image_blend = make_colour_rgb(136, 86, 180); depth = -3; }
				repeat(8) with(instance_create(x + random_range(-16, 16), y + random_range(-16, 16), BulletHit)){
				sprite_index	= global.sprBurdenSparkle;
				image_index		= choose(0, 1);
				image_xscale	= random_range(0.5, 1);
				image_yscale	= image_xscale;
				direction		= 90 + random_range(-32, 32);
				speed			= random(3);
        	}
    	}
	}
	
	 // DIE:
	if !instance_exists(self){ exit; }
	if(my_health <= 0){
		with(instance_create(x, y, Corpse)){
			sprite_index = other.spr_dead;
			image_xscale = other.image_xscale;
			size		 = other.size;
		}
		 // Goodbye:
		instance_destroy();
	}
	
//#endregion
//#region PALACE ENEMIES
#define GupGuardian_create(_x, _y)
	with instance_create(_x, _y, CustomEnemy){
    
    	name = "Splitter Guardian"
    	
        //Visuals:
        spr_idle = global.sprGupGuardianIdle;
		spr_walk = global.sprGupGuardianWalk;
		spr_hurt = global.sprGupGuardianHurt; 
		spr_dead = global.sprGupGuardianDead;
		sprite_index    = spr_walk;
		image_speed     = 0.4;
		depth           = -2;
		image_index 	= random(7);
		hitid           = [spr_idle, "SPLITTER GUARDIAN"]
        spr_shadow      = global.shdGupGuardian;	
        spr_shadow_y    = 19;
        fr_glow			= [48, 64];
        nts_color_blood = [make_color_rgb(190, 253, 8), c_lime]
        
        //Sounds:
        snd_hurt = sndDogGuardianHurt;
        //snd_dead = sndDogGuardianDead;
        snd_mele = sndDogGuardianMelee;
        
        //Vars:
        mask_index    = global.mskGupGuardian;
        direction     = random(360);
        maxhealth     = 100;
       	my_health     = maxhealth;
        raddrop       = 12;
        maxspeed      = 1.3;
        walkspeed     = maxspeed;
        canmelee      = 1;
        meleedamage   = 6;
        team          = 1;
        targetvisible = 0;
        target        = 0;
        walk          = 0;
        gupwalk		  = 0;
        jumpframego   = 2;
        jumpframestop = 7;
        size		  = 3;
        
        //Alarms:
        alarm1 = 20 + irandom(30);

        //Scripts:
        on_step  = script_ref_create(GupGuardian_step);
        on_draw  = BasicEnemy_draw;
        on_hurt  = Enemy_hurt;
        on_death = GupGuardian_death;
        on_alrm1 = script_ref_create(GupGuardian_alrm1);
        
		instance_create(x, y, PortalClear);
        
        return self;
	}
	
#define GupGuardian_step

	 // Alarms:
	if("on_alrm0" in self and alarm0_run) exit;
	if("on_alrm1" in self and alarm1_run) exit;

		// Movement:
	if(walk > 0){ walk -= current_time_scale;   speed += walkspeed * current_time_scale;   gunangle = direction }
	
		//Speed Cap:
	if(speed > maxspeed){ speed = maxspeed; }
	

	
		// Hop to u:
	if(instance_exists(target) and target_visible){
		if sprite_index != spr_hurt { sprite_index = spr_walk }
			if image_index > jumpframego and image_index < jumpframestop {
		motion_add(direction - (angle_difference(direction, point_direction(x, y, target.x, target.y)) * 0.3), walkspeed);
		enemy_face(direction);
			}
	}
	
		// Hop to anyone
	if(gupwalk > 0){
		gupwalk -= current_time_scale;
			if image_index > jumpframego and image_index < jumpframestop {
		motion_add(direction, walkspeed / 2);
		enemy_face(direction);
			// Make sure you follow through
		if gupwalk = 1 { gupwalk = 2 }
			}
	}

		 // Animate:
	sprite_index = enemy_sprite;
	right = (direction + 270) mod 360 > 180 ? 1 : -1;

#define GupGuardian_alrm1
	alarm1 = 30 + irandom(5);
	
	if(chance(1, 4)) && (!instance_exists(target) || !target_visible){
		direction = random(360);
		gupwalk += alarm1
	}
	
	
#define GupGuardian_death
	instance_create(x, y, PortalClear)
	pickup_drop(40, 5);
	sound_play_pitch(sndExploGuardianDeadCharge, random_range(0.7, 0.8))
	repeat(4){ 
		GeepGuardian_create(x, y) 
	}

#define GeepGuardian_create(_x, _y)
	with instance_create(_x, _y, CustomEnemy){
    
    	name = "Splitter Guardian"
    	
         // Visuals:
        spr_idle		= global.sprGeepGuardianIdle;
		spr_walk		= global.sprGeepGuardianWalk;
		spr_hurt		= global.sprGeepGuardianHurt; 
		spr_dead		= global.sprGeepGuardianDead;
		sprite_index    = spr_walk;
		image_speed     = 0.4;
		depth           = -2;
		image_index 	= random(7);
		depth           = -2;
		hitid           = [spr_idle, "SPLITTER GUARDIAN"]
        spr_shadow      = shd48;	
        spr_shadow_y    = 8;
        fr_glow			= [28, 44];
        nts_color_blood = [make_color_rgb(190, 253, 8), c_lime]
        
         // Sounds:
        snd_hurt = sndExploGuardianHurt;
        //snd_dead = sndExploGuardianDead;
        snd_mele = sndDogGuardianMelee;
        
         // Vars:
        mask_index    = mskExploGuardian;
        direction     = random(360);
        maxhealth     = 25;
       	my_health     = maxhealth;
        raddrop       = 4;
        maxspeed      = 1.7;
        walkspeed     = maxspeed;
        canmelee      = 1;
        meleedamage   = 4;
        team          = 1;
        targetvisible = 0;
        target        = 0;
        walk          = 0;
        gupwalk		  = 0;
        jumpframego   = 2;
        jumpframestop = 7;
        size		  = 2;
        
         // Alarms:
        alarm1 = 20 + irandom(30);

         // Scripts:
        on_step  = script_ref_create(GupGuardian_step);
        on_draw  = BasicEnemy_draw;
        on_hurt  = Enemy_hurt;
        on_death = GeepGuardian_death;
        on_alrm1 = script_ref_create(GeepGuardian_alrm1);
        
        return self;
	}

#define GeepGuardian_alrm1
	alarm1 = 20 + irandom(5);
	
	if(chance(1, 3)) && (!instance_exists(target) || !target_visible){
		direction = random(360);
		gupwalk += alarm1
	}
		
#define GeepGuardian_death
	with instance_create(x, y, PortalClear){ 
		image_xscale = 0.8; 
		image_yscale = image_xscale; 
	}
	
	repeat(4){ 
		GipGuardian_create(x,y) 
	}
	
	pickup_drop(10, 0);
	sound_play_pitch(sndExploGuardianDeadCharge, random_range(1,1.1))

#define GipGuardian_create(_x, _y)
	with instance_create(_x, _y, CustomEnemy){
    
    	name = "Splitter Guardian"
    	whocouldibe = "GipGuardian"
    	
        //Visuals:
        spr_idle		= global.sprGipGuardianIdle;
		spr_walk		= global.sprGipGuardianWalk;
		spr_hurt		= global.sprGipGuardianHurt; 
		spr_dead		= global.sprGipGuardianDead;
		sprite_index    = spr_walk;
		image_speed     = 0.4;
		depth           = -2;
		image_index 	= random(7);
		depth           = -2;
		hitid           = [spr_idle, "SPLITTER GUARDIAN"]
        spr_shadow      = shd24;	
        spr_shadow_y    = 0.5;
        fr_glow			= [16, 32];
        nts_color_blood = [make_color_rgb(190, 253, 8), c_lime]
        
        //Sounds:
        snd_hurt		= sndGuardianHurt;
        snd_dead		= sndGuardianDead;
        snd_mele		= sndDogGuardianMelee;
        
        //Vars:
        mask_index    = mskBandit;
        direction     = random(360);
        maxhealth     = 6;
       	my_health     = maxhealth;
        raddrop       = 2;
        maxspeed      = 2;
        walkspeed     = maxspeed;
        canmelee      = 1;
        meleedamage   = 2;
        team          = 1;
        targetvisible = 0;
        target        = 0;
        walk          = 0;
        gupwalk		  = 0;
        jumpframego   = 2;
        jumpframestop = 7;
        size		  = 1;
        
        //Alarms:
        alarm1 = 20 + irandom(30);

        //Scripts:
        on_step  = script_ref_create(GupGuardian_step);
        on_draw  = BasicEnemy_draw;
        on_hurt  = Enemy_hurt;
        on_death = GipGuardian_death;
        on_alrm1 = script_ref_create(GipGuardian_alrm1);
        
        return self;
	}

#define GipGuardian_alrm1
	alarm1 = 10 + irandom(5);
	
	if(chance(1, 3)) && (!instance_exists(target) || !target_visible){
		direction = random(360);
		gupwalk += alarm1
	}
		
#define GipGuardian_death
	speed = max(3);
	pickup_drop(3, 0);
	
#define PalaceSerpentSpawner_create(_x, _y)
	with instance_create(_x, _y, CustomObject){
		
		name = "fr_PalaceSerpentSpawn"
		
		sprite_index	= mskNone;
		on_step 		= PalaceSerpentSpawner_step;
	
		return self;
	}
	
#define PalaceSerpentSpawner_step
		if(!instance_exists(Player)){
			instance_delete(self);
			exit;
		}
		var who2kill = call(scr.instance_random, Player)
		PalaceSerpent_create(who2kill.x, who2kill.y)
		instance_delete(self);
	
#define PalaceSerpent_create(_x, _y)
	with instance_create(_x, _y, CustomObject){
		name			= "fr_PalaceSerpent"
		
		 // our friend apep
	
		 // Visual:
		spr_head		= global.sprPalaceSerpentHead;
		spr_body		= global.sprPalaceSerpentBody;
		spr_body_back	= global.sprPalaceSerpentBodyBack;
		spr_tail		= global.sprPalaceSerpentTail;
		spr_ring		= global.sprPalaceSerpentRing;
		spr_telegraph	= global.sprSerpentPath;
		spr_gameover	= global.sprPalaceSerpentGameover;
		sprite_index	= mskNone;
		image_alpha		= 1;
		image_xscale	= 1;
		image_yscale	= 1;
		direction   	= choose(0, 180);
		if(direction = 180){
			image_yscale = -1;
		}
		image_angle 	= direction;
		depth			= -11;
		telegraph_alpha	= 0;
		hitid			= [spr_gameover, "SERPENT"]
        segments		= 50//570;
        tail_segments	= 1;
        segment_dis		= (direction = 180 ? 46 : -46);
        doTrail 		= true;
	
		 // Vars:
		team			= 1;
		lifetime		= 300;
		striked			= false;
		wentBy			= false;
		didit			= false;
		telegraph_real	= false;
		serpent_dis		= -1800;
		serpent_speed	= 24;
		serpent_x		= x + lengthdir_x(serpent_dis, direction);
		serpent_y		= y;
        myHitbox		= PalaceSerpentHitbox_create(x + lengthdir_x(serpent_dis, direction), y, hitid, serpent_speed, (direction = 180 ? "left" : "right"));
        nearestX		= x;
        nearestY		= y;
        
		on_step			= PalaceSerpent_step;
		on_end_step		= PalaceSerpent_endstep
		on_draw			= PalaceSerpent_draw;
		on_destroy		= PalaceSerpent_destroy;
		
		 // Look into my epic wicked 6 eyes...
		if(global.settingLowQualitySerpent = false){
			SerpentEyeglow_create(serpent_x, serpent_y, self, depth - 1, 32 * image_yscale * -1, 14);
			SerpentEyeglow_create(serpent_x, serpent_y, self, depth - 1, 19 * image_yscale * -1, 14);
			SerpentEyeglow_create(serpent_x, serpent_y, self, depth - 1, 6	* image_yscale * -1, 14);
			SerpentEyeglow_create(serpent_x, serpent_y, self, depth + 1, 32 * image_yscale * -1, -28);
			SerpentEyeglow_create(serpent_x, serpent_y, self, depth + 1, 19 * image_yscale * -1, -28);
			SerpentEyeglow_create(serpent_x, serpent_y, self, depth + 1, 6	* image_yscale * -1, -28);
		} else {
			on_draw 		= PalaceSerpentLQ_draw;
			spr_body		= global.sprLQPalaceSerpent;
			doTrail 		= false;
		}

		 // grrrr.. .
		sound_play_pitchvol(global.sndPalaceSerpentWarning[irandom(2)], 0.9 + random(0.1), 2);
        global.serpentSoundRumble	= sound_loop(global.sndPalaceSerpentRumble);
        sound_volume(global.serpentSoundRumble, 0);
        sound_set_track_position(global.serpentSoundRumble, random(14));
	
		return self;
	}

#define PalaceSerpent_step
	// Striker on The Move:
	serpent_dis 	+= (current_time_scale * serpent_speed);
	serpent_x		= x + lengthdir_x(serpent_dis, direction);
	
	 // Hitbox:
    if(!instance_exists(myHitbox)){
        myHitbox = PalaceSerpentHitbox_create(x + lengthdir_x(serpent_dis, direction), y, hitid, serpent_speed, (direction = 180 ? "left" : "right"));
    }
	
	 // Telegraph Fade In:
	if(telegraph_alpha <= 1 && telegraph_real = false){
		telegraph_alpha += 0.1 * current_time_scale;
		if(telegraph_alpha >= 1){
			telegraph_real = true;
		}
	}
	
	 // Went By
	if(serpent_dis > -420){
		wentBy = true
		if(telegraph_alpha > 0){
			telegraph_alpha -= 0.1;
		}
	}


	if((instance_exists(Player)) && (serpent_dis < 100)){
		var _dis			= distance_to_object(myHitbox),
			_rumbleVol		= (2000 - _dis) / 2000;
		sound_volume(global.serpentSoundRumble, clamp(1 * _rumbleVol, 0, 10));
	} else {
		sound_volume(global.serpentSoundRumble, 0);
	}
	
	

	 // Trail:
	if(doTrail){
		if(current_frame_active){
			repeat(3){
				with(instance_create(serpent_x + random(-2300 * image_yscale), serpent_y + random_range(-20, 20), CaveSparkle)){
					sprite_index	= choose(global.sprPalaceSerpentTrail, global.sprPalaceSerpentTrail2);
					depth			= other.depth + 1;
					direction		= (other.direction + 180) + random_range(-45, 45);
					image_angle		= random(360);
					speed			= 5;
				}
			}
		}
	}
	
	
	// Live your lifetime
	lifetime -= current_time_scale;
	if(lifetime <= 0){
		instance_destroy();
		exit;
	}

#define PalaceSerpent_endstep
	script_bind_draw(PalaceSerpentTelegraph_draw, 0, spr_telegraph, x, y, image_angle, telegraph_alpha)
		
#define PalaceSerpent_draw
	var _segmentX		= 0,
		_segmentBackX	= 0,
		_segOff 		= 20,
		_segSpeed		= 15,
		_segCap			= 24,
		_ringX			= 0;
		
	 // Back Segments:
	for(var i = 0; i < segments; i++){
		var _sprite 	= spr_body_back
		var _segmentY	= (dsin((current_frame * _segSpeed) + i * _segOff) * _segCap) - (_segCap / 2)
		draw_sprite_ext(_sprite, 0, serpent_x + _segmentBackX, serpent_y + _segmentY, 1 * (image_yscale * -1), 1, 0, c_white, 1);
		_segmentBackX += segment_dis;
	}
	
	 // Front Segments:
	for(var i = 0; i < segments + tail_segments; i++){
		var _sprite 	= i >= segments ? spr_tail : spr_body
		var _segmentY	= (dsin((current_frame * _segSpeed) + i * _segOff) * _segCap) - (_segCap / 2)
		draw_sprite_ext(_sprite, (i * 4.4) + current_frame * 0.4, serpent_x + _segmentX, serpent_y + _segmentY, 1 * (image_yscale * -1), 1, 0, c_white, 1);
		_segmentX += segment_dis;
	}
	
	 // Rings:
	for(var i = 0; i < segments; i++){
		var _segmentY = (dsin((current_frame * _segSpeed) + i * _segOff) * _segCap) - (_segCap / 2)
		if(i mod 5 == 0 && i != 0){
			draw_sprite_ext(spr_ring, current_frame * 0.8 + i, serpent_x + _ringX, serpent_y + _segmentY, i % 3 == 1 ? -1 : 1, 1, 0, c_white, 1);
		}
		_ringX += segment_dis;
	}
	
	var _headY = (dsin((current_frame * _segSpeed)) * _segCap) - (_segCap / 2)
	draw_sprite_ext(spr_head, current_frame * 0.4, serpent_x, serpent_y + _headY - 16, image_xscale, image_yscale, image_angle, c_white, image_alpha);
//	draw_sprite_ext(spr_tail, current_frame * 0.4, serpent_x + _segmentX, serpent_y + _segmentY, image_xscale, image_yscale, image_angle, c_white, image_alpha);

#define PalaceSerpentTelegraph_draw(_spr_telegraph, _x, _y, _angle, _alpha)
	draw_sprite_ext(_spr_telegraph, current_frame, _x, _y, 1, 1, _angle, c_white, _alpha);
	instance_destroy();
	
#define PalaceSerpentLQ_draw
	draw_sprite_ext(spr_body, 0, serpent_x, serpent_y, image_yscale, 1, 0, c_white, 1);
	
#define PalaceSerpent_destroy
	with(myHitbox){
		instance_destroy();
	}
	if(array_length(instances_matching(CustomObject, "name", "fr_PalaceSerpent") = 1)){
		sound_stop(global.serpentSound);	
		sound_stop(global.serpentSoundRumble);	
	}
	if(!instance_exists(Player)){
		sound_stop(global.serpentSound);	
		sound_stop(global.serpentSoundRumble);			
	}

#define PalaceSerpentHitbox_create(_x, _y, _hitid, _serp_speed, _serp_dir)
    with(instance_create(_x, _y, CustomSlash)){
        name            = "fr_SerpentHitbox";
        
        mask_index		= global.mskPalaceSerpent;
        sprite_index	= mskNone;
        depth			= -100
        team            = 1;
        hitid           = _hitid
        serp_dir		= _serp_dir;
        x				= _x + (serp_dir = "left" ? 1130 : -1130);
        serp_speed		= _serp_speed;
        typ 			= -1;
        global.serpentSound	= sound_loop(global.sndPalaceSerpent);
        sound_set_track_position(global.serpentSound, random(13));
        sound_volume(global.serpentSound, 0);
        
        on_anim 		= nothing;
        on_hit			= SerpentHitbox_hit;
        on_end_step		= SerpentHitbox_endstep;
		on_wall			= nothing;
        on_anim         = nothing;
        on_projectile	= PalaceSerpentHitbox_nullify;
        on_grenade		= PalaceSerpentHitbox_nullify;
        
        return self;
    }

#define SerpentHitbox_hit
    if(projectile_canhit_melee(other)){
        with(other){
	    	repeat(12){
	    		with instance_create(x, y, Dust){
	    			direction		= random(360);
	    			speed			= 2 + random(2);
	    			sprite_index	= sprSmoke;
	    		}
	    	}
    	    sound_play_pitchvol(sndBurn, 0.8, 2)
    	    lasthit 	= other.hitid;
	        projectile_hit(self, 80)
        }
    }
    
#define SerpentHitbox_endstep
	if(serp_dir = "right"){
		x += (current_time_scale * serp_speed);
	} 
	if(serp_dir = "left"){
		x -= (current_time_scale * serp_speed);
	}
	
	if(instance_exists(Player)){
		var _nearest	= instance_nearest(x, y, Player);
		if(instance_exists(_nearest)){
			nearestX		= _nearest.x;
			nearestY		= _nearest.y;
			var	_dis			= distance_to_point(nearestX, nearestY),
				_serpVol		= (640 - _dis) / 640,
				_shake			= clamp(300 / distance_to_point(nearestX, nearestY), 0, 20);
				view_shake_at(nearestX, nearestY, _shake);
			sound_volume(global.serpentSound, clamp(1 * _serpVol, 0, 10));
		}
	}
	
#define PalaceSerpentHitbox_nullify
	if(instance_exists(self)) && (other.typ > 0){ 
		with(other){
			sound_play_pitchvol(sndPickupDisappear, 1.3 + random(0.2), 0.4)
			with instance_create(x, y, BulletHit){ 
				sprite_index = sprGuardianBulletHit;
			}
			instance_destroy();
		} 
	}	
	
#define SerpentEyeglow_create(_x, _y, _creator, _depth, _xOff, _yOff)
	with(instance_create(_x, _y, CustomObject)){
		name = "fr_serpentEye";
		
		creator		= _creator;
		depth		= _depth;
		xOff		= _xOff;
		yOff		= _yOff;
		
		on_end_step	= SerpentEyeglow_endstep
	}
	
#define SerpentEyeglow_endstep
	if(!instance_exists(creator)){
		instance_destroy();
		exit;
	}
	var _headY = (dsin((current_frame * 15) * 1) * 24) - 12
	
	x		= creator.serpent_x + xOff;
	y		= creator.serpent_y + _headY + yOff
	

	var	_x1 = x,
		_y1 = y,
		_x2 = xprevious,
		_y2 = yprevious;

	with(GenericTrail_create(x, y)){
		depth			= other.depth;
		image_xscale	= point_distance(_x1, _y1, _x2, _y2);
		image_yscale   *= 2;
		image_speed    *= 4;
		image_angle 	= point_direction(_x1, _y1, _x2, _y2);
		image_blend 	= make_color_rgb(222, 255, 126);
	}
	
#define RadFlameTrap_create(_x, _y)

	with instance_create(_x,_y, CustomObject){
		with instance_create(x, y, TrapScorchMark){ 
			depth = 10; 
		}
		
		 // Visual:
		sprite_index	= global.sprTrapPalace;
		hitid			= [global.sprTrapPalaceGameover, "FIRE TRAP"]
		depth			= -1;
		
		 // Vars:
		creator 		= instance_position(x, y, Wall);
		alarm1			= 80 + random_range(0, 30);
		fire_mode		= choose(1, 2);
		fullAmmo		= 48;
		ammo			= fullAmmo;
		active			= true;
		
		 // Events:
		on_step 	= RadFlameTrap_step;
		on_alrm1	= script_ref_create(RadFlameTrap_alrm1);
		
		return self;
	}
    
#define RadFlameTrap_step
	if("on_alrm1" in self and alarm1_run) exit;

	 // Destroy if Wall Dead:
	if !instance_exists(creator){ instance_destroy(); exit; }
    
    var _prevActive = active;
    active			= (instance_exists(Portal) ? false : true);
    
	 if(active != _prevActive){
	 	if(active = true){
	 		alarm1 = 90;
	 		ammo   = 48;
	 	}
	 }

#define RadFlameTrap_alrm1
	if(active = true){
		switch(fire_mode){
		
			case 1:
		
			if(ammo = fullAmmo){
				sound_play_pitch(sndFiretrap, 0.8 + random(0.2));
			}
			if(ammo > 0){
				
				// South:
				if !instance_position(x,y + 16, Wall){
					with instance_create(x + 8, y + 16, TrapFire){
						direction		= 270;
						sprite_index	= global.sprRadTrapFire;
						speed			= 5;
						team			= 1;
						hitid			= other.hitid;
					}
				}
			
				// North:
				if !instance_position(x, y - 16, Wall){
					with instance_create(x + 8, y - 8, TrapFire){
						direction		= 90;
						sprite_index	= global.sprRadTrapFire;
						speed			= 5;
						team			= 1;
						hitid			= other.hitid;
					}
				}
				alarm1 = 1;
			}
			if(--ammo <= 0){
				fire_mode	= 2;
				alarm1		= 90;
				ammo		= 48;
			}
			break;
		
			case 2:
			
			if(ammo = fullAmmo){
				sound_play_pitch(sndFiretrap, 0.8 + random(0.2));
			}
			if(ammo > 0){
				
				// South:
				if !instance_position(x,y + 16, Wall){
					with instance_create(x - 2, y + 8, TrapFire){
						direction		= 180;
						sprite_index	= global.sprRadTrapFire;
						speed			= 5;
						team			= 1;
						hitid			= other.hitid;
					}
				}
			
				// North:
				if !instance_position(x, y - 16, Wall){
					with instance_create(x + 16, y + 8, TrapFire){
						direction		= 0;
						sprite_index	= global.sprRadTrapFire;
						speed			= 5;
						team			= 1;
						hitid			= other.hitid;
					}
				}
				alarm1 = 1;
			}
			if(--ammo <= 0){
				fire_mode	= 1;
				alarm1		= 90;
				ammo		= 48;
			}
			break;
		}
	}

#define ThroneRoomTeleporter_create(_x, _y, _xscale)
    with(instance_create(_x, _y, CustomObject)){
        name            = "fr_ThroneRoomTeleporter";
        
        sprite_index	= global.sprThroneTeleporter;
        spr_inactive	= global.sprThroneTeleporterInactive;
        image_speed		= 0.4;
        depth			= 0;
    	image_xscale	= _xscale;
        
        mask_index		= global.mskThroneTeleporter;
        active			= true;
        
        telepormed		= false;
        doQuickThrone	= true;
        quickThrone		= false;

		on_step 		= ThroneRoomTeleporter_step;
		
        return self;
    }

#define ThroneRoomTeleporter_step
	if(active = true){
		if(place_meeting(x, y, Player)){
			var _teleX = 10016,
				_teleY = 8768;
				
				var _x = x;
				var _y = y
			
			telepormed = true; // i teleported someone!
				
			 // Move Player:
			with(instance_nearest(x, y, Player)){
				x = _teleX;
				y = _teleY;
				
				 // Shift Camera:
				view_shift(index, point_direction(other.x, other.y, _teleX, _teleY), point_distance(other.x, other.y, _teleX, _teleY));
			//	call(scr.view_shift, index, point_direction(x, y, other.x, other.y), point_distance(x, y, other.x, other.y));
	
				 // Teleport FX:
				with(instance_create(x, y, Wind)){
					sprite_index = sprOldGuardianDeflect;
					depth        = other.depth - 1;
				}
				with(instance_create(_teleX, _teleY, Wind)){
					sprite_index = sprOldGuardianDeflect;
					depth        = other.depth - 1;
				}
			
				 // Sounds:
				sound_play_pitchvol(sndPortalAppear, 4 + orandom(0.4), 0.4);
				sound_play_pitch(sndCrownGuardianHurt, 0.5 + orandom(0.2));
			}
		}
		
		if(telepormed = true && doQuickThrone = true && quickThrone = false){
			with(BecomeNothing){
				sound_stop(sndBecomeNothingRumble);
				alarm0				= 10;
				other.quickThrone	= true;	
			}
		}
		
		if(instance_exists(enemy)){
			active = false;
			sprite_index = spr_inactive;
		}
	}

#define view_shift(_index, _dir, _pan)
	// taken from telib will use lib when the module is updated.
	/*
		Moves a given player's screen a given distance toward a given direction
		Basically the second argument of "weapon_post()", but usable outside of a Player object
	*/
	
	 // All Players:
	if(_index < 0){
		for(var i = 0; i < maxp; i++){
			view_shift(i, _dir, _pan);
		}
	}
	
	 // Normal:
	else{
		var _shake = UberCont.opt_shake;
		UberCont.opt_shake = 1;
		
		with(instance_create(0, 0, Revive)){
			try{
				p = _index;
				instance_change(Player, false);
				gunangle = _dir;
				weapon_post(0, _pan * current_time_scale, 0);
			}
			catch(_error){
				trace(_error);
			}
			instance_delete(self);
		}
		
		UberCont.opt_shake = _shake;
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
    
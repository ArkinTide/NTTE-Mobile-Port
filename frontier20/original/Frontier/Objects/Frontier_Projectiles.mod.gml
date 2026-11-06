/*
    This file is for projectiles that are fired by the player (usually), enemy projectiles are gonna in their respective enemy's file.
    moved labs/idpd projectile to frontier_projectiles2   (hit tha token limit)
*/

#define init

	 // LIB:
	while(!mod_exists("mod", "lib")){wait(1);}
	script_ref_call(["mod", "lib", "getRef"], "mod", mod_current, "scr");
	#macro  scr			global.scr
	#macro  call		script_ref_call



		// SETTINGS //
	global.settingNaturalPirateWeps			= false;	// causes pirate variant weps to appear in the main weapon pool. wep spawn areas likely not super well balanced
	global.settingNaturalLabsWeps			= false;	// same as above, but with labs cache weps.
	
	
	/*
		this is a list of pirate variants that the player has discovered for use with the found setting option for piratewep spawns
		the mimic adds to this global array when a new one is discovered along with adding to the savefile
		I'm not sure if calling the save file a bunch in 50+ weapon_area checks has any potential performance ramifications so it only checks it here.
	*/
	
	global.foundPirateWeps					= array_clone(call(scr.save_get, "Frontier", "pirate_conversions"));
	
        // SPRITES //
     // Generic Sprites:
	global.sprGenericTrail  				= sprite_add("../sprites/particles/sprGenericTrail.png",						50, 0, 50);
	global.sprWhiteSmoke					= sprite_add("../sprites/particles/sprWhiteSmoke.png",							5, 12, 12);
	
	 // PIRATE LEGEND Projectiles:
	global.mskGunpowderCreep				= sprite_add("../sprites/projectiles/mskGunpowderCreep.png",					1, 24, 24);
	global.sprGunpowderCreep				= sprite_add("../sprites/projectiles/sprGunpowderCreep.png",					18, 24, 24);
	global.sprGunpowderFireFly				= sprite_add("../sprites/particles/sprGunpowderFireFly.png",					13, 24, 24);
	global.sprGrapeshot						= sprite_add("../sprites/projectiles/sprGrapeshot.png", 						2, 7, 7);
	global.sprGrapeshotDisappear			= sprite_add("../sprites/projectiles/sprGrapeshotDisappear.png",				4, 4, 4);
	global.sprGoldGrapeshotDisappear		= sprite_add("../sprites/projectiles/sprGoldGrapeshotDisappear.png",			4, 4, 4);
	global.sprPopoGrapeshot					= sprite_add("../sprites/projectiles/sprPopoGrapeshot.png", 					2, 7, 7);
	global.sprPopoGrapeshotDisappear		= sprite_add("../sprites/projectiles/sprPopoGrapeshotDisappear.png",			4, 4, 4);
	global.sprEpicCannonball				= sprite_add("../sprites/projectiles/sprEpicCannonball.png",					1, 8, 8);
	global.sprEpicStreak					= sprite_add("../sprites/particles/sprEpicStreak.png",							7, 8, 8);
	global.sprEpicTrail						= sprite_add("../sprites/particles/sprEpicTrail.png",							3, 4, 4);
	global.sprEpicShrapnel					= sprite_add("../sprites/projectiles/sprEpicShrapnel.png",						1, 7, 3);
	global.sprEpicPlasmaImpact				= sprite_add("../sprites/projectiles/sprEpicPlasmaImpact.png",					7, 16, 16);
	global.mskPlasmaImpactSmall  			= sprite_add("../sprites/projectiles/mskPlasmaImpactSmall.png", 				7, 16, 16);
	global.sprEpicPlasmaImpactSmall  		= sprite_add("../sprites/projectiles/sprEpicPlasmaImpactSmall.png", 			7, 8, 8);
	global.sprEpicBeam     					= sprite_add("../sprites/projectiles/sprEpicBeam.png", 							1, 0, 4);
	global.mskEpicBeam     					= sprite_add("../sprites/projectiles/mskEpicBeam.png", 							1, 2, 4);
	global.sprEpicBeamStart					= sprite_add("../sprites/projectiles/sprEpicBeamStart.png",						0, 8, 8);
	global.sprEpicBeamHead 					= sprite_add("../sprites/projectiles/sprEpicBeamHead.png", 						0, 8, 2);
	global.sprSpikerSplinter				= sprite_add("../sprites/projectiles/sprSpike.png", 							2, -6, 3);
	global.sprGoldSpikerSplinter			= sprite_add("../sprites/projectiles/sprGoldSpike.png",							2, -6, 3);
	global.sprGunpowderShank				= sprite_add("../sprites/projectiles/sprGunpowderShank.png", 					2, -5, 8);
	global.mskSharpSlash					= sprite_add("../sprites/projectiles/mskSharpSlash.png", 						1, 24, 32);
	global.sprSharpSlash					= sprite_add("../sprites/projectiles/sprSharpSlash.png", 						3, 24, 32);
	global.sprGunpowderProjectile			= sprite_add("../sprites/projectiles/sprGunpowderProjectile.png", 				1, 12, 12);
    global.sprFireSlash						= sprite_add("../sprites/projectiles/sprFireSlash.png", 						3, 0, 24);
	global.sprBlunderball					= sprite_add("../sprites/projectiles/sprBlunderball.png", 						1, 9, 9);
	global.sprBlunderballDebris				= sprite_add("../sprites/particles/sprBlunderballDebris.png", 					4, 4, 4);
	global.sprHeavyBlunderball				= sprite_add("../sprites/projectiles/sprHeavyBlunderball.png", 					1, 13, 13);
	global.sprGoldBlunderball				= sprite_add("../sprites/projectiles/sprGoldBlunderball.png", 					1, 9, 9);
	global.sprGoldBlunderballDebris			= sprite_add("../sprites/particles/sprGoldBlunderballDebris.png", 				4, 4, 4);
	global.sprFlameBullet					= sprite_add("../sprites/projectiles/sprFlameBullet.png", 						2, 8, 8);
	global.sprFlameBulletHit				= sprite_add("../sprites/projectiles/sprFlameBulletHit.png", 					4, 8, 8);
	global.mskSawblade						= sprite_add("../sprites/projectiles/mskSawblade.png", 							1, 9, 9);
	global.sprSawblade						= sprite_add("../sprites/projectiles/sprSawblade.png", 							1, 9, 9);
	global.sprGoldSawblade					= sprite_add("../sprites/projectiles/sprGoldSawblade.png", 						1, 9, 9);
	global.sprMagnet						= sprite_add("../sprites/projectiles/sprMagnet.png", 							2, 8, 8);
	global.sprMagnetHook					= sprite_add("../sprites/projectiles/sprMagnetHook.png", 						5, 8, 8);
	global.sprMagnetBlink					= sprite_add("../sprites/projectiles/sprMagnetBlink.png", 						2, 8, 8);
	global.sprMagnetSuck					= sprite_add("../sprites/particles/sprMagnetSuck.png", 							2, 1, 1);
	global.sprGoldMagnet					= sprite_add("../sprites/projectiles/sprGoldMagnet.png", 						2, 8, 8);
	global.sprGoldMagnetHook				= sprite_add("../sprites/projectiles/sprGoldMagnetHook.png", 					5, 8, 8);
	global.sprBallistaBolt					= sprite_add("../sprites/projectiles/sprBallistaBolt.png", 						2, 8, 8);
	global.sprBallistaSubBolt				= sprite_add("../sprites/projectiles/sprBallistaSubBolt.png", 					1, 11, 3);
	global.sprFlameTrail					= sprite_add("../sprites/particles/sprFlameTrail.png", 							7, 2, 2);
	global.sprPetrolStreak					= sprite_add("../sprites/particles/sprPetrolStreak.png",						7, 8, 8);
	global.sprStarBullet					= sprite_add("../sprites/projectiles/sprStarBullet.png", 						2, 5, 5);
	global.sprStarBulletHit					= sprite_add("../sprites/projectiles/sprStarBulletHit.png", 					4, 8, 8);
	global.sprStarBulletTrail				= sprite_add("../sprites/particles/sprStarBulletTrail.png", 					3, 4, 4);
	global.sprStarBig						= sprite_add("../sprites/projectiles/sprStarBig.png", 							1, 51, 51);
	global.sprInkBigFlak					= sprite_add("../sprites/projectiles/sprInkBigFlak.png", 						1, 10, 7);	
	global.sprInkFlak						= sprite_add("../sprites/projectiles/sprInkFlak.png", 							1, 7, 4);	
	global.sprInkShrapnel					= sprite_add("../sprites/projectiles/sprInkShrapnel.png", 						1, 4, 3);	
	global.sprInkSmoke						= sprite_add("../sprites/particles/sprInkSmoke.png", 							5, 12, 12);
	global.sprOilGrenade					= sprite_add("../sprites/projectiles/sprOilGrenade.png", 						1, 6, 6);	
	global.sprFlameRocket					= sprite_add("../sprites/projectiles/sprFlameRocket.png", 						1, 9, 4);
	global.oilColors						= [make_color_rgb(252, 56, 0), make_color_rgb(160, 30, 0)];
	global.sprCreep  						= sprite_add("../sprites/projectiles/sprCreep.png",								3, 24, 24);
    global.sprFlameCreepBubble 	    		= sprite_add("../sprites/particles/sprFlameCreepBubble.png",					6, 8, 8);
	global.sprGoldFlameRocket				= sprite_add("../sprites/projectiles/sprGoldFlameRocket.png", 					1, 9, 4);
    global.sprGhostSkull					= sprite_add("../sprites/projectiles/sprGhostSkull.png", 						4, 16, 16);
    global.sprTideBubble					= sprite_add("../sprites/projectiles/sprTideBubble.png", 						4, 8, 8);
    global.sprTideBubbleActive				= sprite_add("../sprites/projectiles/sprTideBubbleActive.png", 					1, 3, 8);
    global.sprTideBubbleExplosion			= sprite_add("../sprites/projectiles/sprTideBubbleExplosion.png", 				7, 12, 12);
    global.sprTideBubbleSpray				= sprite_add("../sprites/particles/sprTideBubbleSpray.png", 					6, 8, 8);
    global.sprTideBubbleTrail				= sprite_add("../sprites/particles/sprTideBubbleTrail.png", 					3, 8, 8);
    global.sprTideBubbleNullify				= sprite_add("../sprites/particles/sprTideBubbleNullify.png", 					4, 24, 24);
    global.sprTideSlash						= sprite_add("../sprites/projectiles/sprTideSlash.png", 						3, 0, 24);
    global.sprGunpowderShell				= sprite_add("../sprites/projectiles/sprGunpowderShell.png", 					2, 8, 8);
    global.sprFireworkSpark					= sprite_add("../sprites/projectiles/sprFireworkSpark.png", 					1, 4, 4);
    global.sprFireworkSparkMiddle			= sprite_add("../sprites/projectiles/sprFireworkSparkMiddle.png", 				1, 4, 4);
    global.sprFireworkFlame					= sprite_add("../sprites/projectiles/sprFireworkFlame.png", 					7, 8, 8);
    global.sprFireworkTrail					= sprite_add("../sprites/particles/sprFireworkTrail.png", 						4, 4, 4);
    global.sprFireworkExplosion				= sprite_add("../sprites/projectiles/sprFireworkExplosion.png", 				9, 24, 24);
    global.sprFireworkSmallExplosion		= sprite_add("../sprites/projectiles/sprFireworkSmallExplosion.png", 			7, 12, 12);
    global.sprFireworkCandle				= sprite_add("../sprites/projectiles/sprFireworkCandle.png", 					3, 14, 8);
    global.sprFireworkCandleBase			= sprite_add("../sprites/projectiles/sprFireworkCandleBase.png", 				3, 14, 8);
    global.sprFireworkCandleTrail       	= sprite_add("../sprites/particles/sprFireworkCandleTrail.png", 				3, 4, 4);
	global.sprFireworkCandleTrail2      	= sprite_add("../sprites/particles/sprFireworkCandleTrail2.png",				12, 20, 8);
	global.sprFireworkSparkle       		= sprite_add("../sprites/particles/sprFireworkSparkle.png", 					5, 8, 8);
    global.sprFireworkRocket				= sprite_add("../sprites/projectiles/sprFireworkRocket.png", 					1, 14, 5);
    global.sprGoldFireworkRocket			= sprite_add("../sprites/projectiles/sprGoldFireworkRocket.png", 				1, 14, 5);
    global.sprGunpowderShell	    		= sprite_add("../sprites/projectiles/sprGunpowderShell.png", 					2, 8, 8);
    global.sprGunpowderShellDisappear		= sprite_add("../sprites/projectiles/sprGunpowderShellDisappear.png",			4, 8, 8);
    global.sprCoralBolt						= sprite_add("../sprites/projectiles/sprCoralBolt.png",							2, 8, 8);
    global.sprCoralCluster					= sprite_add("../sprites/projectiles/sprCoralCluster.png",						1, 9, 9);
    global.sprCoralClusterBig				= sprite_add("../sprites/projectiles/sprCoralClusterBig.png",					1, 13, 13);
	global.sprCoralShard					= sprite_add("../sprites/projectiles/sprCoralShard.png",						2, 8, 3);
    global.sprCoralPowerShard				= sprite_add("../sprites/projectiles/sprCoralPowerShard.png",					2, 8, 3);
 	global.sprCoralShardHit					= sprite_add("../sprites/projectiles/sprCoralShardHit.png", 					4, 8, 8);
 	global.sprCoralPowerShardHit			= sprite_add("../sprites/projectiles/sprCoralPowerShardHit.png", 				4, 8, 8);
    global.sprCoralGrowthHit				= sprite_add("../sprites/projectiles/sprCoralGrowthHit.png",					4, 24, 24);
    global.sprToxicCoralCluster				= sprite_add("../sprites/projectiles/sprToxicCoralCluster.png",					1, 13, 13);
    global.sprToxicCoralBolt				= sprite_add("../sprites/projectiles/sprToxicCoralBolt.png",					2, 8, 8);
    global.sprToxicCoralPowerShard			= sprite_add("../sprites/projectiles/sprToxicCoralPowerShard.png",				2, 8, 3);
 	global.sprToxicCoralPowerShardHit		= sprite_add("../sprites/projectiles/sprToxicCoralPowerShardHit.png", 			4, 8, 8);
 	

#define check_piratedrops(_wep, _area)
	switch(global.settingNaturalPirateWeps){
		 // nuh uh
		case 0:
			return -1;
		break;
		
		 // whole pool can drop
		case 1:
			return _area;
		break;
		
		 // only previously found weps can drop
		case "FOUND":
			var _yeah = -1;
			if(array_find_index(global.foundPirateWeps, _wep) > -1){
				_yeah = _area;
			}
			return _yeah;
		break;
	}

#define weapon_tutorial_text(_x, _y, _type)
	with(instance_create(_x, _y + 12, PopupText)){
		mytext = "OOPS!"
		switch(_type){
			case "chargeWep":			mytext = "@sHOLD FIRE TO @wCHARGE!"; break;
			case "blunderball": 		mytext = "@sSMACK BLUNDERBALL FOR#@wMORE POWER!!"; break;
			case "blunderboulder":		mytext = "@sSMACK BLUNDERBOULDER FOR#@wMORE POWER!!"; break;
	//		case "stickybomb":			mytext = "@sHOLD FIRE TO @wDETONATE BOMBS" ; break;
		}
		alarm1 *= 1.4;
	}
	
	//#region PIRATE PROJECTILES
#define GunpowderCreep_create(_x, _y)
	with(instance_create(_x, _y, CustomSlash)){
		
         // Visuals:
        sprite_index    = global.sprGunpowderCreep;
        spr_firefly		= global.sprGunpowderFireFly;
        image_index		= 0;
        image_speed		= 0.4;
        image_angle		= random(360);
        depth			= 4;
        
         // Vars:
        mask_index		= mskExplosion;
        speed           = 0;
        typ             = -1;
        damage          = 0;
        team			= 1724;
        hitid           = [sprite_index, "GUNPOWDER"];
        lifetime		= 200;
        allGrownUp		= false;
        maxSize			= 1;
    	fr_glow			= [0, 0];
        
        on_anim			= nothing;
        on_step         = GunpowderCreep_step;
        on_projectile	= GunpowderCreep_projectile;
        on_grenade		= nothing;
        on_hit			= nothing;
        on_wall			= nothing;
        
        return self;
	}
	
#define GunpowderCreep_step
	x			= xstart;
	y			= ystart;
	speed		= 0;
	lifetime -= current_time_scale;
	
	 // Update Glow:
    fr_glow	= [32 * image_xscale, 48 * image_xscale]

	 // Grow:
	if(image_xscale < maxSize && allGrownUp = false){
		image_xscale += 0.1;
		image_yscale = image_xscale;
		if(image_xscale >= maxSize){
			allGrownUp = true;
		}
	}
	if(random(35) < 1){
		with instance_create(x + orandom(16 * image_xscale), y + orandom(16 * image_xscale), FireFly){
			sprite_index	= other.spr_firefly
		}
	}
	if(random(20) < 1){
		with instance_create(x + orandom(16 * image_xscale), y + orandom(16 * image_xscale), Dust){
			sprite_index	= sprBreath;
			direction		= random(360);
			speed			= random(1);
			image_blend 	= make_colour_rgb(74, 60, 78);
		}
	}
	
	 // Explode 2:
	 // explosions don't work in on_projectile:
	if(distance_to_object(Explosion) < 2){
		GunpowderCreep_ignite();
		exit;
	}
	
	 // ByeBye:
	if(lifetime <= 0){
		image_xscale -= 0.05;
		image_yscale  = image_xscale;
		if(image_xscale <= 0){
			instance_destroy();
		}
	}	
	
#define GunpowderCreep_projectile
	if(instance_is(other, Flame)) || 
	   instance_is(other, TrapFire) || 
	   instance_is(other, FlameShell) ||
	   ("is_flame" in other && other.is_fire == true) || 
	   ("is_explosion" in self && other.is_explosion == true) || 
	   ("fr_ignitePowder" in other && other.fr_ignitePowder == true){
		GunpowderCreep_ignite();
	}
	
#define GunpowderCreep_ignite
	if(image_xscale >= (maxSize / 2)){
		with instance_create(x, y, Explosion){
			hitid = other.hitid;
		}
		sound_play_pitch(sndExplosion, 0.9 + random(0.2));
		sound_play_pitch(sndScorpionFire, 0.7 + random(0.2));
		repeat(irandom(2)){
			with instance_create(x + orandom(8), y + orandom(8), SmallExplosion){
				hitid = other.hitid;
			}
		}
	}
	if(image_xscale <= (maxSize / 2)){
		sound_play_pitch(sndExplosionS, 0.9 + random(0.2));
		instance_create(x, y, SmallExplosion);
	}
	instance_destroy();
	
#define GunpowderProjectile_create(_x, _y)
	with(instance_create(_x, _y, CustomProjectile)){
		
         // Visuals:
        sprite_index    = global.sprGunpowderProjectile;
        image_index		= 0;
        image_speed		= 0.4;
        image_angle		= random(360);
        depth			= 4;
        hitid           = [sprite_index, "GUNPOWDER SPREAD"];
        
         // Vars:
        mask_index		= mskNone;
        speed           = 12;
        friction		= 0.2;
        typ             = 0;
        damage          = 0;
        creator			= other;
        team			= other.team;
        z				= 12;
		zspeed  		= 10;
		zfriction		= 1;
		wib_projspeed	= true; // not affected by projectile speed bonuses
        
        on_step         = GunpowderProjectile_step;
		on_destroy		= GunpowderProjectile_destroy;
		on_draw			= GunpowderProjectile_draw;
        
        return self;
	}

#define GunpowderProjectile_step
	 // Particles:
	if(random(4) < 1){
        with(instance_create(x + random_range(-8, 8), (y - z) + random_range(-8, 8), Dust)){
			sprite_index	= sprBreath;
			direction       = other.direction + 180 + (other.z / 70) + random_range(-20, 20);
			speed			= random(1);
			image_blend 	= make_colour_rgb(74, 60, 78);
		}
	}
	
	 // Z-Axis:
	z += zspeed * current_time_scale;
	zspeed -= zfriction * current_time_scale;
	image_angle -= sign(hspeed) * (abs(vspeed / 2) + abs(hspeed));
	
	 // Set Mask:
	if(z <= 12){
		mask_index	= mskFlakBullet;
	} else {
		mask_index  = mskNone;
	}
	
	 // Set Z Goin:
	if(z <= 0){
		friction	= 0.4;
		depth		= -3;
		
		 // Movement:
		if(speed > 0){
			var m = 4;
			if(speed > m) speed = m;
		}
		
		 // Impact:
		if(zspeed < -10){
			if(z < 0){
				instance_destroy();
			}
		}
	}
	
	 // While In Air:
	else{
		friction	= 0;
		depth		= -9;
	}

#define GunpowderProjectile_destroy
	sound_play_pitch(sndBurn, 1.2 + random(0.5));
	repeat(5){
		with(instance_create(x, y, Smoke)){
			direction	= random(360);
			speed		= 3;
		}
	}
	with(GunpowderCreep_create(x, y)){
		image_xscale	= choose(0.4, 0.5);
		image_yscale	= image_xscale;
	}
	
#define GunpowderProjectile_draw
  	draw_sprite_ext(sprite_index, image_index, x, (y - z), (image_xscale + z / 140), (image_yscale + z / 140), image_angle, image_blend, image_alpha);

#define GunpowderShank_create(_x, _y)
	with(instance_create(_x, _y, CustomSlash)){
		
         // Visuals:
        sprite_index    = global.sprGunpowderShank;
        image_speed		= 0.4;
        image_angle		= direction;
        hitid           = [sprite_index, "GUNPOWDER SHANK"];
        
         // Vars:
        speed           = 2;
        friction		= 0.2;
        typ             = 0;
        damage          = 12;
        creator			= other;
        team			= other.team;
        canfix			= false;
        canreflect		= false;
        is_melee		= true;
        
		on_destroy		= GunpowderShank_destroy;
        
        return self;
	}
	
#define GunpowderShank_destroy
	with instance_create(x + lengthdir_x(45, direction), y + lengthdir_y(45, direction), Explosion){
		hitid = other.hitid;
	}
	sound_play_pitch(sndExplosion, 0.9 + random(0.2));
	sound_play_pitch(sndScorpionFire, 0.7 + random(0.2));
	repeat(irandom(4)){
		with instance_create(x + lengthdir_x(45, direction) + orandom(8), y + lengthdir_y(45, direction) + orandom(8), SmallExplosion){
			hitid = other.hitid;
		}
	}	
	
#define SharpSlash_create(_x, _y)
	with(instance_create(_x, _y, CustomSlash)){
		
         // Visuals:
        sprite_index    = global.sprSharpSlash;
        image_speed		= 0.4;
        image_angle		= direction;
        hitid           = [sprite_index, "SHARP SLASH"];
        
         // Vars:
        mask_index		= global.mskSharpSlash;
        speed           = 2;
        friction		= 0.2;
        typ             = 0;
        damage          = 12;
        force			= 12;
        creator			= other;
        team			= other.team;
        canfix			= false;
        canreflect		= false;
        walled			= false;
        is_melee		= true;
        
		on_hit			= SharpSlash_hit;
		on_wall			= SharpSlash_wall;
        
        return self;
	}
	
#define SharpSlash_hit
	if(projectile_canhit_melee(other)){
		projectile_hit(other, damage, force)
	}
	
#define SharpSlash_wall
	if(!walled){
		walled = true;
		friction = 0.4;
		
		x += hspeed_raw;
		y += vspeed_raw;
		
		x -= hspeed_raw;
		y -= vspeed_raw;
	}
	
#define FireSlash_create(_x, _y)
	with(instance_create(_x, _y, CustomSlash)){
		
         // Visuals:
        sprite_index    = global.sprFireSlash;
        image_speed		= 0.4;
        image_angle		= direction;
        hitid           = [sprite_index, "FIRE SLASH"];
        fr_bloom		= [1.1, 0.1];
        
         // Vars:
        mask_index		= mskSlash;
        speed           = 2;
        friction		= 0.2;
        typ             = 0;
        damage          = 32;
        force			= 12;
        creator			= other;
        team			= other.team;
        canfix			= false;
        canreflect		= true;
        walled			= false;
        fr_ignitePowder	= true;
        fr_augBoilDmg	= true;
        is_melee		= true;
        
		on_hit			= FireSlash_hit;
		on_wall			= FireSlash_wall;
        
        return self;
	}
	
#define FireSlash_hit
	if(projectile_canhit_melee(other)){
		projectile_hit(other, damage, force)
	}
	
#define FireSlash_wall
	if(!walled){
		walled = true;
		friction = 0.4;
		
		x += hspeed_raw;
		y += vspeed_raw;
		
		x -= hspeed_raw;
		y -= vspeed_raw;
	}

	x -= hspeed_raw;
	y -= vspeed_raw;
		
	with(other){
		instance_create(x, y, FloorExplo);
		instance_destroy();
	}

#define Grapeshot_create(_x, _y)
	with(instance_create(_x, _y, CustomProjectile)){
		
         // Visuals:
        sprite_index    = global.sprGrapeshot;
        spr_fade		= global.sprGrapeshotDisappear;
        spr_dead		= sprBulletHit;
        image_speed		= 0.4;
        image_angle		= random(360);
        fr_bloom		= [2, 0.1];
        
         // Vars:
        speed           = 16;
        friction		= 0.55;
        typ             = 1;
        damage          = 4;
        force			= 2;
        creator         = other;
        team            = other.team;
        hitid           = [sprite_index, "GRAPESHOT"];
		bonus       	= true;
		bonus_damage	= 2;
		minspeed    	= 6;
		maxspeed    	= 16;
		wallbounce  	= 4 * skill_get(mut_shotgun_shoulders);
        ammo_type		= 2;
        is_shell		= true;
       
		 // Alarms:
		alarm2			= 2;
		
		 // Events:
        on_anim			= Grapeshot_anim;
        on_step         = Grapeshot_step;
        on_hit			= Grapeshot_hit;
        on_wall			= Grapeshot_wall;
        on_alrm2		= script_ref_create(Grapeshot_alrm2);		
		
		return self;
	}
	
#define Grapeshot_anim
	
	 // Begone:
	if(sprite_index != spr_fade){
		image_speed = 0;
		image_index = image_number - 1;
	}
	
	 // Poof:
	else instance_destroy();
    
#define Grapeshot_step

	 // Alarms:
	if(alarm2_run) exit;
    
	 // Disappear:
	if(speed < minspeed && sprite_index != spr_fade){
		damage		 /= 2;
		sprite_index = spr_fade;
		image_index  = 0;
		image_speed  = 0.4;
	}
	
#define Grapeshot_alrm2
	bonus = false;

#define Grapeshot_hit
	if(projectile_canhit(other)){
		projectile_hit(other, damage + (bonus_damage * bonus), force);
		
		 // Goodbye:
		with(instance_create(x, y, BulletHit)){
			sprite_index	= other.spr_dead;
		}
		instance_destroy();
	}
	
#define Grapeshot_wall
	instance_create(x, y, Dust);
	if(speed > minspeed){
		sound_play_hit(sndShotgunHitWall, 0.2);
	}

	 // Reset Bonus Damage:
	if(wallbounce > 0 && !bonus){
		bonus = true;
		alarm2 = 2;
	}
	
	 // Bounce:
	move_bounce_solid(true);
	image_angle = direction;
	speed = min((speed * 0.55) + wallbounce, maxspeed);
	wallbounce *= 0.95;
	
#define GoldGrapeshot_create(_x, _y)
	with(Grapeshot_create(_x, _y)){
		spr_fade	= global.sprGoldGrapeshotDisappear;
		friction	= 0.5;
		wallbounce  = 5 * skill_get(mut_shotgun_shoulders);
		minspeed	= 5;
		
		return self;
	}
	
#define PopoGrapeshot_create(_x, _y)
	with(Grapeshot_create(_x, _y)){
		sprite_index	= global.sprPopoGrapeshot;
		spr_fade		= global.sprPopoGrapeshotDisappear;
		spr_dead		= sprIDPDBulletHit;
		wallbounce  	= 4 * skill_get(mut_shotgun_shoulders);
		minspeed		= 5.5;
		
		return self;
	}

#define Blunderball_create(_x, _y)

		// the bestest projectile of all time?
	with instance_create(_x, _y, CustomProjectile){
		
         // Visuals:
        sprite_index    = global.sprBlunderball;
        spr_debris		= global.sprBlunderballDebris;
        image_angle		= random(360);
        trailColor		= c_white;
        depth			= -3;
        sparkly 		= false;
        
         // Vars:
        mask_index		= mskEnemyBullet1;
        speed           = 16;
        friction		= 0;
        typ             = 1;
        maxDamage		= 30;
        damage          = maxDamage;
        force			= 2;
        creator         = other;
        team            = other.team;
        hitid           = [sprite_index, "BLUNDERBALL"];
        ammo_type		= 4;
        is_explosive	= true;
        z				= 0;
        zfriction		= 0;
        endBounce		= false;
        TURBOMODE		= false;
        rotspeed		= 12 * current_time_scale;
        wallBreaks		= 8;
		
		 // Events:
        on_step         = Blunderball_step;
        on_end_step		= Blunderball_endstep;
        on_hit			= Blunderball_hit;
        on_wall			= Blunderball_wall;
        on_destroy		= Blunderball_destroy;
        on_draw			= Blunderball_draw;
		
		return self;
	}
	
#define Blunderball_step
	 // Particles & Spin:
	if(speed > 1){
		image_angle += rotspeed;
		if(current_frame_active){
			if(random(1.5) < 1){
				with(instance_create(x, y, Dust)){
					speed		= 5;
					direction	= other.direction + 180 + random_range(-20, 20);
				}
			}
			if(sparkly = true){
				if(random(3) < 1){
					with(instance_create(x, y, CaveSparkle)){
						speed		= 5;
						direction	= other.direction + 180 + random_range(-20, 20);
					}
				}
			}
		}
	}
	
	 // Z Axis:
	if(speed <= 12){
		if(endBounce = false){
			image_angle += rotspeed * 2;
			z += (1 + (3 - zfriction)) * current_time_scale;
			zfriction += 0.1;
			if(z >= 30){
				endBounce = true;
				zfriction = 0;
			}
		} else {
			image_angle += rotspeed * 2;
			z -= (zfriction) * current_time_scale;
			zfriction += 0.7;
			if(z < 0){
				instance_destroy();
				exit;
			}
		}
	}
	
	 // RED EXPLOSION GOGO:
	if(place_meeting(x, y, Explosion)){
		with(instance_create(x, y, Explosion)){
			hitid = [sprite_index, "BLUNDERBALL EXPLOSION"]
		}
		repeat(3){
			with(instance_create(x, y, SmallExplosion)){
				hitid = [sprite_index, "BLUNDERBALL EXPLOSION"]
			}
		}
		sound_play_pitch(sndExplosionCar, 1.1)
		instance_destroy();
	}

#define Blunderball_endstep
	if(TURBOMODE = true){
		with(GenericTrail_create(x, y)){
			depth			= other.depth + 1;
			image_xscale	= point_distance(x, y, other.xprevious, other.yprevious)
			image_yscale   *= 4;
			image_speed    *= 4;
			image_angle 	= point_direction(x, y, other.xprevious, other.yprevious)
			image_blend 	= other.trailColor;
			image_alpha		= 0.7;
		}
	} else {
		if(place_meeting(x, y, projectile)){
		    var _inst = call(scr.instances_meeting, x, y, [Slash, GuitarSlash, BloodSlash, EnergySlash, EnergyHammerSlash, LightningSlash, CustomSlash]);
		    if(array_length(_inst)) with(_inst){
		    	if("ammo_type" not in self || ammo_type != -1){
			        if(place_meeting(x, y, other)) && (other.z <= 24){
			            event_perform(ev_collision, Grenade);
			            with(other){
			            	Blunderball_smackdown();
			            }
			            if(!instance_exists(other)) exit;
			        }
		    	}
		    }
		}		
	}
	
#define Blunderball_smackdown
	TURBOMODE	= true;
	z			= 0;
	zfriction	= 0;
    endBounce	= false;
    speed		= 18;
    damage		= maxDamage
    depth		= -3;
	repeat(12){
		with(instance_create(x, y, Dust)){
			direction	= other.direction + random_range(-45, 45);
			speed		= 5 + random(3);
			depth		= other.depth - 1;
		}
	}
//	sound_play_pitch(sndBlackSwordMega, 1.4 + random(0.1));
	sound_play_pitch(sndExplosionS, 1.5 + random(0.1));
	sound_play_pitch(sndScrewdriver, 1.3 + random(0.1));
	

#define Blunderball_hit
	if(damage > 0){
		if(projectile_canhit(other)){
			if(TURBOMODE = false){
				if(damage > other.maxhealth){
					var _myHealth = other.maxhealth;
					projectile_hit(other, damage, force);
					damage -= _myHealth;
				} else {
					projectile_hit(other, damage, force);
					damage	= 0;
					speed	= 1;
					depth	= -9;
					sound_play_pitch(sndHitRock, 0.6 + random(0.1));
					sound_play_pitch(sndCrownGuardianDead, 1.7 + random(0.1));
					repeat(5){
						with(instance_create(x, y, Dust)){
							direction	= random(360);
							speed		= 3 + random(2);
						}
					}					
				}
			} else {
				projectile_hit(other, damage, force)
			}
		}
	}
	
#define Blunderball_wall
	if(TURBOMODE = false){
		instance_destroy();
		exit;
	} else {
		if(wallBreaks > 0){
			wallBreaks -= 1;
			with(other){
				instance_create(x, y, FloorExplo);
				instance_destroy();
			}
		} else {
			instance_destroy();
		}
	}
	
#define Blunderball_destroy
	repeat(12){
		with(instance_create(x, y, Dust)){
			direction	= random(360);
			speed		= 4 + random(2);
		}
	}
	repeat(5){
		with(instance_create(x, y, Debris)){
			sprite_index	= other.spr_debris;
			direction		= random(360);
			speed			= 2 + random(2);
		}
	}
	sound_play_pitch(sndExplosionS, 1.2 + random(0.1));
	sound_play_pitch(sndWallBreak, 1.2 + random(0.1));
	
	with(instance_create(x, y, SmallExplosion)){
		hitid = [sprite_index, "BLUNDERBALL EXPLOSION"]
	}
	
#define Blunderball_draw
  	draw_sprite_ext(sprite_index, image_index, x, (y - z), (image_xscale + z / 70), (image_yscale + z / 70), image_angle, image_blend, image_alpha);
  	
#define HeavyBlunderball_create(_x, _y)
	with(instance_create(_x, _y, CustomProjectile)){
		
         // Visuals:
        sprite_index    = global.sprHeavyBlunderball;
        spr_debris		= global.sprBlunderballDebris;
        image_angle		= random(360);
        trailColor		= c_lime;
        depth			= -3;
        sparkly 		= false;
        
         // Vars:
        mask_index		= mskSuperFlakBullet;
        speed           = 13;
        friction		= 0;
        typ             = 1;
        maxDamage		= 60;
        damage          = maxDamage;
        force			= 2;
        creator         = other;
        team            = other.team;
        hitid           = [sprite_index, "BLUNDERBOULDER"];
        ammo_type		= 4;
        is_explosive	= true;
        z				= 0;
        zfriction		= 0;
        endBounce		= false;
        TURBOMODE		= false;
        rotspeed		= 8 * current_time_scale;
        wallBreaks		= 18;
		
		 // Events:
        on_step         = Blunderball_step;
        on_end_step		= Blunderball_endstep;
        on_hit			= Blunderball_hit;
        on_wall			= Blunderball_wall;
        on_destroy		= HeavyBlunderball_destroy;
        on_draw			= Blunderball_draw;
		
		return self;
	}

#define HeavyBlunderball_destroy
	repeat(12){
		with(instance_create(x, y, Dust)){
			direction	= random(360);
			speed		= 4 + random(2);
		}
	}
	repeat(9){
		with(instance_create(x, y, Debris)){
			sprite_index	= other.spr_debris;
			direction		= random(360);
			speed			= 2 + random(2);
		}
	}
	sound_play_pitch(sndExplosionL, 1.2 + random(0.1));
	sound_play_pitch(sndWallBreak, 1.2 + random(0.1));
	
	with(instance_create(x, y, GreenExplosion)){
		hitid = [sprite_index, "BLUNDERBALL EXPLOSION"]
	}
	
#define GoldenBlunderball_create(_x, _y)
	with(Blunderball_create(_x, _y)){
		sprite_index	= global.sprGoldBlunderball;
		spr_debris		= global.sprGoldBlunderballDebris;
		trailColor		= make_color_rgb(203, 167, 58);
		sparkly			= true;
		
		maxDamage		= 34;
		damage			= maxDamage;
		
		on_destroy		= GoldBlunderball_destroy;
		
		return self;
	}
	
#define GoldBlunderball_destroy
	repeat(12){
		with(instance_create(x, y, Dust)){
			direction	= random(360);
			speed		= 4 + random(2);
		}
	}
	repeat(5){
		with(instance_create(x, y, Debris)){
			sprite_index	= other.spr_debris;
			direction		= random(360);
			speed			= 2 + random(2);
		}
	}
	sound_play_pitch(sndExplosion, 1.2 + random(0.1));
	sound_play_pitch(sndWallBreak, 1.2 + random(0.1));
	
	with(instance_create(x, y, Explosion)){
		hitid = [sprite_index, "BLUNDERBALL EXPLOSION"]
	}
	
	
#define EpicCannonball_create(_x, _y)
	with instance_create(_x, _y, CustomProjectile){
		
         // Visuals:
        sprite_index    = global.sprEpicCannonball;
        image_angle		= random(360);
        fr_bloom		= [2, 0.1];
        
         // Vars:
        speed           = 16;
        typ             = 1;
        damage          = 16;
        force			= 20;
        creator         = other;
        team            = other.team;
        hitid           = [sprite_index, "EPIC AS HELL CANNONBALL"];
        ammo_type		= 5;
		
		 // Events:
        on_step         = EpicCannonball_step;
		on_destroy		= EpicCannonball_destroy;		
		
		return self;
	}
	
#define EpicCannonball_step
	if(current_frame_active){
		if(random(2) < 1){
			with(instance_create(x + random_range(-8, 8), y + random_range(-8, 8), PlasmaTrail)){
				sprite_index	= global.sprEpicTrail;
				speed			= other.speed / 4;
				direction		= other.direction + random_range(-3, 3) + 180;
				image_angle		= random(360);
			}
		}
		if(random(4) < 1){
			with(instance_create(x + random_range(-8, 8), y + random_range(-8, 8), Smoke)){
				speed			= other.speed / 4;
				direction		= other.direction + random_range(-3, 3) + 180;
			}
		}
	}
	
#define EpicCannonball_destroy
	with(instance_create(x, y, PortalClear)){
		image_xscale		= 0.8;
		image_yscale		= image_xscale;
	}
	with(instance_create(x, y, PlasmaImpact)){
		sprite_index		= global.sprEpicPlasmaImpact;
	}
	repeat(8){
		with(instance_create(x, y, BloodStreak)){
			sprite_index	= global.sprEpicStreak;
			direction		= random(360);
			image_angle		= direction;
			speed			= 4;
		}
	}
	for (i = 0; i < 360; i += 30){
    	with(EpicShrapnel_create(x, y)){
    		speed		+= random(2);
			direction	= other.direction + other.i + random_range(-16, 16);
			image_angle	= direction;
			creator 	= other.creator;
    	}
	}

#define EpicShrapnel_create(_x, _y)
	with instance_create(_x, _y, CustomProjectile){
		
         // Visuals:
        sprite_index    = global.sprEpicShrapnel;
        image_angle		= random(360);
        fr_bloom		= [2, 0.1]
        
         // Vars:
        speed           = 8;
        friction		= 0.7;
        typ             = 1;
        damage          = 5;
        force			= 2;
        creator         = other;
        team            = other.team;
        hitid           = [sprite_index, "EPIC AS HELL SHRAPNEL FROM EPIC AS HELL CANNONBALL"];
        ammo_type		= 5;
        minspeed		= 2;
        maxspeed		= 8;
		wallbounce  	= 1 * skill_get(mut_laser_brain);
		
		 // Events:
        on_step         = EpicShrapnel_step;
        on_wall			= EpicShrapnel_wall;
		on_destroy		= EpicShrapnel_destroy;		
		
		return self;
	}

#define EpicShrapnel_step
	if(speed < minspeed){
		instance_destroy();
	}

#define EpicShrapnel_wall
	move_bounce_solid(true);
	image_angle = direction;
	speed = min((speed * 0.55) + wallbounce, maxspeed);

#define EpicShrapnel_destroy
	sound_play_pitchvol(sndPlasmaHit, random_range(1.1, 1.3), 0.8)
	with instance_create(x, y, PlasmaImpact){
		damage			= 2;
		team			= other.team;
		sprite_index	= global.sprEpicPlasmaImpactSmall;
		mask_index		= global.mskPlasmaImpactSmall;
		hitid			= other.hitid;
	}

#define EpicBeam_create(_x, _y, _direction)
	with instance_create(_x, _y, CustomProjectile){
		name			= "fr_EpicBeam";
	
		// Visuals:
    	image_angle 	= _direction;
		sprite_index	= global.sprEpicBeam;
		mask_index  	= global.mskEpicBeam;
		spr_tail    	= global.sprEpicBeamStart;
		spr_head    	= global.sprEpicBeamHead;
		image_speed		= 0;
		
		// Vars:
    	direction		= _direction;
    	creator 		= other;
    	team			= other.team;
    	lifetime		= 3 * (skill_get(mut_laser_brain));
    	damage			= 15;
       
		// Functions:
    	on_step			= EpicBeam_step;
		on_hit  		= EpicBeam_hit;
    	on_wall 		= nothing;
		on_draw 		= EpicBeam_draw;
	
		var _scanLength	= binary_search(script_ref_create(check_laser_style), 500);
    	x				= xstart + lengthdir_x(_scanLength, image_angle);
    	y				= ystart + lengthdir_y(_scanLength, image_angle);
    	image_xscale	= _scanLength / 2;
    	xprevious		= x;
    	yprevious		= y;
	}

#define EpicBeam_step
	if instance_exists(creator){
		
		xstart			= creator.x + creator.hspeed_raw;
		ystart			= creator.y + creator.vspeed_raw 
		var _scanLength	= binary_search(script_ref_create(check_laser_style), 500);
    	x				= xstart + lengthdir_x(_scanLength, image_angle);
    	y				= ystart + lengthdir_y(_scanLength, image_angle);
    	image_xscale	= _scanLength / 2;
    	xprevious		= x;
    	yprevious		= y;
	    direction		= creator.gunangle
	    image_angle 	= direction
	
			// Lifetime:
    	lifetime -= current_time_scale;
    	if(lifetime <= 0){
    		instance_destroy(); 
    		exit
    	}
    
    		// Particles:
    	if(random(2) < 1){
    	var _r = random_range(0, image_xscale * 2 + 12);
        	with instance_create(x - lengthdir_x(_r, direction) + random_range(-5, 5), y - lengthdir_y(_r, direction) + random_range(-5, 5), BulletHit) {
        		sprite_index	= global.sprEpicTrail;
        		image_angle 	= other.direction
				image_speed 	= 0.4;
        		motion_set(other.direction, choose(1, 2));
        	}
    	}
    		// Flooby Beam:
    	image_yscale = 1 * random_range(0.8, 1.1)
    
	}
	else{
		instance_destroy();
	}

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
        if (script_ref_call(checkScript, length)) {
            length -= lenDiff;
        }
        else {
            length += lenDiff;
        }
    }
    return length;
    
//The script called by binary_search
#define check_laser_style(length)
    x = xstart + lengthdir_x(length, image_angle);
    y = ystart + lengthdir_y(length, image_angle);
    image_xscale = length / 2;
    return place_meeting(x, y, Wall);

#define EpicBeam_hit
	var _team = team,
	    _ang  = direction
	with(other){
		if(nexthurt <= current_frame){
			projectile_hit(self, other.damage);
		}
	}
	
#define EpicBeam_draw
	draw_sprite_ext(sprite_index, image_index, xstart, ystart, image_xscale, image_yscale, image_angle, image_blend, 1.0);
	if x != xstart draw_sprite_ext(spr_tail, 1, xstart, ystart, 1, image_yscale, image_angle, image_blend, 1.0);
	if x != xstart draw_sprite_ext(spr_head, 0, x, y, image_yscale * 2, image_yscale * 2, image_angle - 45, image_blend, 1.0);

	// BLOOM:
	draw_sprite_ext(sprite_index, image_index, xstart, ystart, image_xscale, image_yscale*1.7, image_angle, image_blend, 0.2);
	if x != xstart draw_sprite_ext(spr_tail, 1, xstart, ystart, 1, image_yscale*1.5, image_angle, image_blend, 0.2); 
	if x != xstart draw_sprite_ext(spr_head, 0, x, y, image_yscale * 2.7, image_yscale * 2.7, image_angle - 45, image_blend, 0.2); 

#define SpikerSplinter_create(_x, _y)
	with(instance_create(_x, _y, Splinter)){
		speed			= 18 + random(4);
		damage			= 5;
		
		sprite_index	= global.sprSpikerSplinter;
		
		return self;
	}
	
#define GoldSpikerSplinter_create(_x, _y)
	with(instance_create(_x, _y, Splinter)){
		speed			= 18 + random(4);
		damage			= 5;
		
		sprite_index	= global.sprGoldSpikerSplinter;
		
		return self;
	}
	
#define FlameBullet_create(_x, _y)
	with(instance_create(_x, _y, CustomProjectile)){
		
         // Visuals:
        sprite_index    = global.sprFlameBullet;
        spr_dead		= global.sprFlameBulletHit;
        fr_bloom		= [2, 0.2]
        fr_glow 		= [32, 48];
        
         // Vars:
        mask_index		= mskBullet1;
        speed           = 16;
        force			= 8;
        typ             = 1;
        gland			= 1;
        damage          = 3;
        creator         = other;
        team            = other.team;
        hitid           = [sprite_index, "FLAME BULLET"];
        ammo_type		= 1;
        is_bullet		= true;
		
		 // Events:
		on_anim 		= FlameBullet_anim;
		on_hit			= FlameBullet_hit;
		on_wall			= FlameBullet_wall;
		on_destroy		= FlameBullet_destroy;		
		
		return self;
	}

#define FlameBullet_anim
	image_index = image_number - 1;
	image_speed = 0;

#define FlameBullet_hit
	if(projectile_canhit(other)){
		 // Recycle Gland:
		if(gland != 0 && instance_is(creator, Player)){
			if(chance(3 * skill_get(mut_recycle_gland), 5)){
				var	_ammo = creator.ammo[1],
					_amax = creator.typ_amax[1];
					
				if(_ammo < _amax){
					creator.ammo[1] = min(_ammo + gland, _amax);
					instance_create(x, y, RecycleGland);
					sound_play_hit(sndRecGlandProc, 0.1);
				}
			}
		}
		
		 // Damage:
		projectile_hit(other, damage, force);
		instance_destroy();
	}
	
#define FlameBullet_wall
	move_bounce_solid(true);
	instance_create(x, y, Smoke);
	sound_play_hit(sndHitWall, 0.2);
	instance_destroy();
	
	
#define FlameBullet_destroy
	with(instance_create(x, y, Flame)){
		team		= other.team;
		creator 	= other;
		hitid		= other.hitid;
		direction	= other.direction;
		speed		= 3 + random(2);
	}
	with(instance_create(x, y, BulletHit)){
		sprite_index = other.spr_dead;
	}

#define Magnet_create(_x, _y, _targetX, _targetY)
	with(instance_create(_x, _y, CustomProjectile)){
		
         // Visuals:
        sprite_index    = global.sprMagnet;
        spr_hook		= global.sprMagnetHook;
        spr_blink		= global.sprMagnetBlink;
        hitid           = [sprite_index, "MAGNET"];
        blinkStart		= false;
        
         // Vars:
        mask_index		= mskBolt;
        speed           = 18;
        targetX 		= _targetX;
        targetY 		= _targetY;
        force			= 4;
        typ             = 1;
        damage          = 0;
        creator         = other;
        team            = other.team;
        grounded		= false;
        seekGround		= true;
        fr_magnetic		= true;
        lifeTime		= 400;
        stuckOn			= noone;
        ammo_type		= 3;
		
		 // Events:
		on_anim 		= Magnet_anim;
		on_step 		= Magnet_step;
		on_hit			= Magnet_hit;
		on_wall			= Magnet_wall;
		on_destroy		= Magnet_destroy;		
		
		return self;
	}

#define Magnet_anim
	if(blinkStart = false){
		image_index = image_number - 1;
		image_speed = 0;
	}
	
#define Magnet_step
	lifeTime -= current_time_scale;
	if(lifeTime <= 0){
		instance_destroy();
		exit;
	}
	
	if(random(25) < 1){
		with(instance_create(x + orandom(24), y + orandom(24), CaveSparkle)){
			sprite_index	= global.sprMagnetSuck;
			image_angle		= random(360);
			direction		= point_direction(x, y, other.x, other.y);
			speed			= 2 + random(2);
		}
	}
	
	if(stuckOn != noone && grounded = false){
		if(!instance_exists(stuckOn)){
			grounded		= true;
			sprite_index	= spr_hook;
			image_speed		= 0.4;
			image_angle 	= 270;
			speed			= 0;
			exit;
		} else {
			x = (stuckOn.x + lengthdir_x(-16, direction));
			y = (stuckOn.y + lengthdir_y(-16, direction));
		}
	}
	
	 // Land at cursor:
	if(seekGround = true){
		if(distance_to_point(targetX, targetY) <= 0){
			friction = 6;
		}
		if(speed <= 1){
			speed			= 0;
			seekGround		= false;
			grounded		= true;
			sprite_index	= spr_hook;
			image_speed		= 0.4;
			image_angle 	= 270;
			speed			= 0;
			mask_index		= mskNone;	
			repeat(3){
				with(instance_create(x, y, Dust)){
					direction	= random(360);
					speed		= 4 + random(2);
				}
			}
			sound_play_hit(sndBoltHitWall, 0.2);
		}
	}
	
	 // Start blinking:
	if(lifeTime <= 50 && blinkStart = false){
		blinkStart		= true;
		sprite_index	= spr_blink;
		image_speed		= 0.4;
	}
	
#define Magnet_hit
	if(projectile_canhit(other)){
		
		 // Stick:
		if(other.my_health > damage){
			stuckOn 	= other;
			seekGround	= false;
			speed		= 0;
			mask_index	= mskNone;
		}
		
		 // Damage:
		projectile_hit(other, damage, force);
	}
	
#define Magnet_wall
	 // Stick in Wall:
	if(speed > 0 && seekGround = true){
		speed		= 0;
		seekGround	= false;
		mask_index	= mskNone;
		instance_create(x, y, Dust);
		
		move_contact_solid(direction, 16);

		xprevious = x;
		yprevious = y;
		
		 // FX:
		sound_play_hit(sndBoltHitWall, 0.2);
		instance_create(x, y, Dust);
	}
	
#define Magnet_destroy
	repeat(5){
		with(instance_create(x, y, Dust)){
			direction	= random(360);
			speed		= 2 + random(2);
		}
	}
	sound_play_pitchvol(sndHitMetal, 1.4 + random(0.1), 0.5)

#define Sawblade_create(_x, _y)
	with(instance_create(_x, _y, CustomProjectile)){
		
         // Visuals:
        sprite_index    = global.sprSawblade;
        spr_trail		= sprDiscTrail;
        image_angle		= random(360);
        hitid           = [sprite_index, "SAWBLADE"];
        trailColor		= c_white;
        depth			= -1;
        
         // Vars:
        mask_index		= global.mskSawblade;
        speed           = 9;
        force			= 8;
        typ             = 1;
        damage          = 5;
        creator         = other;
        team            = other.team;
        ammo_type		= 3;
        lifeTime		= 200;
        wallCooldown	= 0;
        nearestMagnet	= noone;
		
		 // Events:
		on_anim 		= Sawblade_anim;
		on_step			= Sawblade_step;
		on_end_step 	= Sawblade_endstep;
		on_hit			= Sawblade_hit;
		on_wall			= Sawblade_wall;
		on_destroy		= Sawblade_destroy;		
		
		return self;
	}

#define Sawblade_anim
	image_index = image_number - 1;
	image_speed = 0;

#define Sawblade_step
	image_angle += 20 * current_time_scale;
	lifeTime -= current_time_scale;
	if(wallCooldown > 0){
		wallCooldown -= current_time_scale;
	}
	
	 // Go to nearest magnet:
	nearestMagnet = call(scr.instance_nearest_array, x, y, instances_matching(projectile, "fr_magnetic", true));
	if(distance_to_object(nearestMagnet) < 64){
		if(current_frame_active){
			direction -= (angle_difference(direction, point_direction(x, y, nearestMagnet.x, nearestMagnet.y)) * power(0.15 + (0.10 * skill_get(mut_bolt_marrow)), 1));
		}
	}
	
#define Sawblade_endstep
	with(GenericTrail_create(x, y)){
		depth			= 0;
		image_xscale	= point_distance(x, y, other.xprevious, other.yprevious)
		image_yscale   *= 4;
		image_speed    *= 1 + (3 - (skill_get(mut_bolt_marrow) * 1.5));
		image_angle 	= point_direction(x, y, other.xprevious, other.yprevious)
		image_blend 	= other.trailColor;
		image_alpha		= 0.7;
	}

#define Sawblade_hit
	if(projectile_canhit_melee(other)){
		
		 // Damage:
		projectile_hit(other, damage, force);
		if(distance_to_object(nearestMagnet) > 64){
			lifeTime -= 50;
		}
	}
	
#define Sawblade_wall
	if(lifeTime <= 0){
		instance_destroy();
		exit;
	}
	
	 // makes saws stuck in walls delete much faster
	wallCooldown += 2;
	if(wallCooldown >= 12){
		lifeTime -= 20;
	}
	move_bounce_solid(true);
	sound_play_pitchvol(sndDiscBounce, 0.7 + random(0.2), 0.4);
	with(instance_create(x, y, DiscBounce)){
		image_angle 	= other.direction - 180
	}
	

#define Sawblade_destroy
	sound_play_hit(sndDiscDie, 0.2);
	instance_create(x, y, DiscDisappear);
	
#define GoldSawblade_create(_x, _y)
	with(Sawblade_create(_x, _y)){
		
		 // Visuals:
		sprite_index	= global.sprGoldSawblade;
		trailColor		= make_color_rgb(203, 167, 58);
		
		 // Vars:
		speed			= 10
		damage			= 6;
        lifeTime		= 220;
		
		return self;
	}
	
#define GoldMagnet_create(_x, _y, _targetX, _targetY)
	with(Magnet_create(_x, _y, _targetX, _targetY)){
		
		 // Visuals:
		sprite_index	= global.sprGoldMagnet;
		spr_hook		= global.sprGoldMagnetHook;
		
		 // Vars:
        lifeTime		= 450;
		
		return self;
	}
	
#define BallistaBolt_create(_x, _y)
	with(instance_create(_x, _y, CustomProjectile)){
		
         // Visuals:
        sprite_index    = global.sprBallistaBolt;
        spr_trail		= global.sprFlameTrail;
        hitid           = [sprite_index, "BALLISTA BOLT"];
        trailColor		= c_white;
        depth			= -1;
        
         // Vars:
        mask_index		= mskHeavyBolt;
        speed           = 16;
        force			= 8;
        typ             = 1;
        damage          = 20;
        creator         = other;
        team            = other.team;
        ammo_type		= 3;
        is_bolt 		= true;
		home_inst   	= noone;
		home_dir    	= 0;
		stuckOn			= noone;
		lifeTime		= 200;
		wallOffset		= -16;
		subSpread		= -24;
		subCount		= 4;
		
		 // Events:
		on_anim 		= BallistaBolt_anim;
		on_step			= BallistaBolt_step;
		on_end_step 	= BallistaBolt_endstep;
		on_hit			= BallistaBolt_hit;
		on_wall			= BallistaBolt_wall;
		on_destroy		= BallistaBolt_destroy;		
		
		return self;
	}
	
#define BallistaBolt_anim
	image_index = image_number - 1;
	image_speed = 0;
	
#define BallistaBolt_step
	 // homing taken from ntte:
	if(stuckOn = noone){
		if(home_inst != noone){
			if(instance_exists(home_inst) && projectile_canhit_melee(home_inst)){
				 // Homing:
				if(
					abs(angle_difference(point_direction(x, y, home_inst.x, home_inst.y), home_dir)) < 90
					&&
					!place_meeting(x + lengthdir_x(speed, home_dir), y + lengthdir_y(speed, home_dir), home_inst)
				){
					var	_tx = home_inst.x - lengthdir_x(speed, home_dir),
						_ty = home_inst.y - lengthdir_y(speed, home_dir),
						_diff = angle_difference(point_direction(x, y, _tx, _ty), direction) * 0.5 * current_time_scale;
						
					direction += _diff;
					image_angle += _diff;
				}
				
				 // Done Homing:
				else{
					home_inst = noone;
					direction = home_dir;
					image_angle = direction;
				}
			}
			
			 // Return to Original Direction:
			else if(direction != home_dir){
				var _diff = angle_difference(home_dir, direction);
				if(abs(_diff) > 10) _diff = _diff * 0.5 * current_time_scale;
				direction += _diff;
				image_angle += _diff;
			}
			
			 // Done Homing:
			else home_inst = noone;
		}
		
		else{
			home_dir = direction;
			
			 // Home on Nearest Enemy:
			var _disMax = 24 * skill_get(mut_bolt_marrow);
			if(_disMax > 0){
				var _nearest = noone;
				with(instances_matching_ne(hitme, "team", team, 0)){
					if(!instance_is(self, prop)){
						var _dis = distance_to_point(other.x + other.hspeed, other.y + other.vspeed);
						if(_dis < _disMax){
							if(place_meeting(other.x, other.y, other)){
								_disMax  = _dis;
								_nearest = self;
							}
						}
					}
				}
				home_inst = _nearest;
			}
		}
		if(speed > 0){
			if(current_frame_active){
				with(instance_create(x, y, Smoke)){
					direction	= other.direction + 180 + random_range(-45, 45);
					speed		= 2 + random(2);
				}
				if(random(2) < 1){
					with(instance_create(x, y, BulletHit)){
						sprite_index	= other.spr_trail;
						direction		= other.direction + 180 + random_range(-30, 30);
						speed			= 3 + random(2);
						friction		= 0.02;
						depth			= -2;
					}
				}
				/*
				if(random(10) < 1){
					with instance_create(x + orandom(16 * image_xscale), y + orandom(16 * image_xscale), FireFly){
						image_blend 	= c_orange;
					}
				}
				if(random(10) < 1){
					with instance_create(x + orandom(16 * image_xscale), y + orandom(16 * image_xscale), Dust){
						sprite_index	= sprBreath;
						direction		= random(360);
						speed			= random(1);
						image_blend 	= make_colour_rgb(74, 60, 78);
					}
				}
				*/
			}
		}
	} else {
		if(!instance_exists(stuckOn)){
			instance_destroy();
			exit;
		} else {
			x = (stuckOn.x + lengthdir_x(wallOffset, direction));
			y = (stuckOn.y + lengthdir_y(wallOffset, direction));
		}
	}
	if(speed <= 0 && stuckOn = noone){
		lifeTime -= current_time_scale;
		if(lifeTime <= 0){
			instance_destroy();
		}	
	}
	
#define BallistaBolt_hit
	var _ang	= direction,
		_spread = subSpread;
	projectile_hit(other, damage);
	repeat(subCount){
		with(BallistaSubBolt_create(x, y)){
			direction	= _ang + _spread;
			image_angle	= direction;
		}
		_spread 	+= 16;
	}
	with(instance_create(x, y, Explosion)){
		creator = other.creator;
		hitid = [sprite_index, "EXPLOSION"]
	}
	sound_play_pitch(sndExplosion, 1.1 + random(0.1))
	sound_play_pitch(sndBoltHitWall, 0.7 + random(0.1));
	sound_play_pitch(sndCrossbow, 0.7 + random(0.1));
	
	instance_destroy();
	
#define BallistaBolt_endstep
	if(stuckOn = noone){
		var	_x1 = x,
			_y1 = y,
			_x2 = xprevious,
			_y2 = yprevious;
		
		with(instance_create(x, y, BoltTrail)){
			image_xscale	= point_distance(_x1, _y1, _x2, _y2);
			image_yscale	= 1.2;
			image_angle 	= point_direction(_x1, _y1, _x2, _y2);
		}
	}
	
#define BallistaBolt_wall
	 // Stick in Wall:
	if(speed > 0){
		speed		= 0;
		mask_index	= mskNone;
		instance_create(x, y, Dust);
		
		move_contact_solid(direction, 8);

		xprevious = x;
		yprevious = y;
		
		 // FX:
		sound_play_hit(sndBoltHitWall, 0.2);
		instance_create(x, y, Dust);
	}

#define BallistaBolt_destroy
	instance_create(x, y, Smoke);
	
#define BallistaSubBolt_create(_x, _y)
	with(instance_create(_x, _y, CustomProjectile)){
         // Visuals:
        sprite_index    = global.sprBallistaSubBolt;
        spr_trail		= global.sprFlameTrail;
        hitid           = [sprite_index, "BALLISTA SPLINTER"];
        trailColor		= c_white;
        depth			= -1;
        
         // Vars:
       // mask_index		= mskBolt;
        speed           = 18;
        force			= 8;
        typ             = 1;
        damage          = 15;
        creator         = other;
        team            = other.team;
        ammo_type		= 3;
        is_bolt 		= true;
		home_inst   	= noone;
		home_dir    	= 0;
		stuckOn			= noone;
		lifeTime		= 200;
		wallOffset		= 16;
		
		 // Events:
		on_step			= BallistaBolt_step;
		on_end_step 	= BallistaBolt_endstep;
		on_hit			= BallistaSubBolt_hit;
		on_wall			= BallistaBolt_wall;
		on_destroy		= BallistaBolt_destroy;		
		
		return self;
	}

#define BallistaSubBolt_hit
	if(projectile_canhit_melee(other)){
		
		 // Damage:
		projectile_hit(other, damage, force);
		if(other.my_health > 0){
			stuckOn 	= other;
			speed		= 0;
			mask_index	= mskNone;			
		}
		
		instance_create(x, y, SmallExplosion);
		sound_play_pitch(sndExplosionS, 1.1 + random(0.1));
	}

#define OilCreep_create(_x, _y)
	with(instance_create(_x, _y, CustomSlash)){
		name			= "fr_OilCreep";
		
         // Visuals:
        sprite_index    = global.sprCreep;
        spr_bubble		= global.sprFlameCreepBubble;
        image_index		= irandom(image_number);
        image_speed		= 0;
        image_angle		= random(360);
        depth			= 4;
        creep_color		= make_color_rgb(26, 23, 38)
        creep_color_2	= make_color_rgb(0, 0, 0)
        image_blend		= creep_color;
        underwater_fx	= (array_find_index([101, "oasis"], GameCont.area) >= 0) || (is_string(GameCont.area) && (mod_script_call("area", GameCont.area, "area_underwater") = true));
        
         // Vars:
        mask_index		= global.mskGunpowderCreep;
        speed           = 0;
        typ             = -1;
        damage          = 0;
        team			= 1724;
        hitid           = [sprite_index, "OIL"];
        lifetime		= 350;
        allGrownUp		= false;
        maxSize			= 1;
        ignited 		= false;
        fr_ignitePowder	= false;
        ogTeam			= other.team;
        
        on_anim			= nothing;
        on_step         = OilCreep_step;
        on_projectile	= OilCreep_projectile;
        on_grenade		= nothing;
        on_hit			= nothing;
        on_wall			= nothing;
        
        hitbox			= OilCreepBuffBox_create(x, y, self);
        script_bind_draw(PlayerCreepLow_draw, (depth + 1), self)
         
        return self;
	}
	
#define OilCreep_step
	x			= xstart;
	y			= ystart;
	speed		= 0;
	lifetime -= current_time_scale;

	 // Grow:
	if(image_xscale < maxSize && allGrownUp = false){
		image_xscale += 0.1;
		image_yscale = image_xscale;
		if(image_xscale >= maxSize){
			allGrownUp = true;
		}
	}
	
	if(ignited = false){
		 // Explode 2:
		 // explosions don't work in on_projectile:
		if(distance_to_object(Explosion) < 2){
			OilCreep_ignite();
		}

	} else {
		 // Update Glow:
	    fr_glow	= [32 * image_xscale, 48 * image_xscale];
    
		if(allGrownUp = true && lifetime > 0){
			image_xscale	= maxSize + orandom(0.02);
			image_yscale	= image_xscale;
			if(random(20) < 1){
				with(instance_create(x + orandom(16 * maxSize), y + orandom(16 * maxSize), PlasmaTrail)){
					sprite_index = other.spr_bubble;
				}
			}
		}		
	}
	
	if(!place_meeting(x, y, Floor)){
		instance_destroy();
		exit;
	}

	 // ByeBye:
	if(lifetime <= 0){
		image_xscale -= 0.05;
		image_yscale  = image_xscale;
		if(image_xscale <= 0){
			instance_destroy();
		}
	}	
	
#define OilCreep_projectile
	if(instance_is(other, Flame)) || 
	   instance_is(other, TrapFire) || 
	   instance_is(other, FlameShell) ||
	   ("is_flame" in other && other.is_fire == true) || 
	   ("is_explosion" in self && other.is_explosion == true) || 
	   ("fr_ignitePowder" in other && other.fr_ignitePowder == true){
	   	if(ignited = false){
			OilCreep_ignite();
	   	}
	}
	
#define OilCreep_ignite
	ignited			= true;
	fr_ignitePowder	= true;
    fr_bloom		= [2, 0.1];
	fr_glow			= [0, 0];
    creep_color		= global.oilColors[0];
    creep_color_2	= global.oilColors[1];
    image_blend		= creep_color;
	sound_play_pitch(sndExplosionS, 0.9 + random(0.2));
	sound_play_pitch(sndScorpionFire, 0.7 + random(0.2));
	lifetime		= 100;
	
	on_projectile	= nothing;
	
	with(hitbox){
		igniteTimer = 2;
	}
	
#define PlayerCreepLow_draw(_creep)
	if(!instance_exists(_creep)){
		instance_destroy();
		exit;
	}
	with(_creep){
		draw_sprite_ext(sprite_index, image_index, x, y + 1, image_xscale, image_yscale, image_angle, creep_color_2, image_alpha)
	}
	
#define OilCreepBuffBox_create(_x, _y, _owner)
	with(instance_create(_x, _y, CustomProjectile)){
		name			= "fr_OilCreepBox";
		
         // Visuals:
        sprite_index    = _owner.sprite_index;
        image_angle		= _owner.image_angle;
        image_index		= _owner.image_index;
        image_xscale	= _owner.image_xscale;
        image_yscale	= image_xscale;
        image_speed		= 0;
        image_alpha		= 0;
        spr_gameover	= _owner.spr_bubble;
        
         // Vars:
        speed           = 0;
        typ             = -1;
        damage          = 0;
        team			= 1724;
        hitid           = [spr_gameover, "BURNING OIL"];
        creator			= _owner;
        fr_ignitePowder	= false;
        igniteTimer 	= 0;
        ogTeam			= _owner.ogTeam;
        playerDamage	= 0;
        
        on_step         = OilCreepBuffBox_step;
        on_hit			= OilCreepBuffBox_hit;
        on_wall			= nothing;
        
        return self;
	}

#define OilCreepBuffBox_step
	if(!instance_exists(creator)){
		instance_destroy();
		exit;
	}
	if(igniteTimer > 0){
		igniteTimer -= current_time_scale;
		if(igniteTimer <= 0){
			fr_ignitePowder = true;
			team			= 1723;
			creator.team	= 1723;
			damage			= 6;
			fr_augBoilDmg	= true;
			playerDamage	= 2 + skill_get("AugmentBoilingVeins");
			repeat(5){
				with(instance_create(x, y, Flame)){
					team		= other.ogTeam;
					direction	= random(360);
					speed		= 4;
				}
			}
		}
	}
	image_xscale	= creator.image_xscale;
	image_yscale	= image_xscale;
	
#define OilCreepBuffBox_hit
	if(!instance_exists(creator)){
		exit;
	}
	if(creator.ignited = false){
		with(other){
			if(instance_is(self, Player)){
				mod_script_call('mod', 'Frontier_StatusEffects', 'status_apply_set', self, mod_variable_get('mod', 'Frontier_StatusEffects', 'buffOiledUp'), 30);
			}
		}
	} else {
		if(projectile_canhit_melee(other)){
			var _dmg = damage
			if("boilcap" in other){
				_dmg = min(playerDamage, max(0, other.my_health - other.boilcap * skill_get(mut_boiling_veins)))
			}
			projectile_hit(other, _dmg)
			sound_play_pitchvol(sndBurn, 0.8 + random(0.3), 0.7);
		}		
	}
	
#define OilGrenade_create(_x, _y)
    with(instance_create(_x, _y, CustomProjectile)){
        
         // Visuals:
        sprite_index    = global.sprOilGrenade;
        
         // Vars:
        speed           = 10;
        friction		= 0.45;
        typ             = 1;
        damage          = 1;
        force			= 2;
        creator         = other;
        team            = other.team;
        hitid           = [sprite_index, "OIL BUBBLE"];
		bonus       	= true;
		minspeed    	= 4;
		maxspeed    	= 16;
        ammo_type		= 4;
        is_grenade		= true;
        oilTime			= 3;
        oilDis			= 36;
        
         // Events:
        on_step         = OilGrenade_step;
        on_wall			= OilGrenade_wall;
        on_destroy		= OilGrenade_destroy;
        
        return self;
    }

#define OilGrenade_step
	 // Disappear:
	if(speed < minspeed){
		instance_destroy();
		exit;
	}
	
	 // Drop Oil:
	oilTime -= current_time_scale;
	if(oilTime <= 0){
		oilTime = 35 / speed;
		OilGrenade_spreadcreep(x, y);
		sound_play_pitchvol(sndFrogEggHurt, 1.3 + random(0.1), 0.4);
	}
	
	 // Particles:
	if(random(2) < 1){
		with(instance_create(x, y, AcidStreak)){
			sprite_index	= global.sprPetrolStreak;
			direction		= other.direction + 180 + random_range(-20, 20);
			image_angle		= direction;
		}		
	}
	
#define OilGrenade_wall
	sound_play_pitch(sndGrenadeHitWall, 1.2 + random(0.2))

	 // Bounce:
	move_bounce_solid(true);
	image_angle = direction;
	speed = min((speed * 0.8), maxspeed);
	
#define OilGrenade_destroy
	var _offset = random(360);
	for(var i = 0; i < 360; i += 72){
		OilGrenade_spreadcreep(x + lengthdir_x(oilDis, i + _offset), y + lengthdir_y(oilDis, i + _offset));
	}
	OilGrenade_spreadcreep(x, y);
	
    sound_play_pitchvol(sndExplosionS, 1.4 + random(0.1), 0.6);
    sound_play_pitchvol(sndFrogEggHurt, 1.3 + random(0.1), 0.4);
	
#define OilGrenade_spreadcreep(_x, _y)
	with(OilCreep_create(_x, _y)){
		ogTeam			= other.team;
		image_xscale	= choose(0.4, 0.5);
		image_yscale	= image_xscale;
	}
	
    repeat(2){
        with(instance_create(_x, _y, AcidStreak)){
        	sprite_index	= global.sprPetrolStreak;
            direction   	= random(360);
            image_angle		= direction;
            speed       	= 3 + random(3);
        }
    }

#define FlameRocket_create(_x, _y)
	with(instance_create(_x, _y, CustomProjectile)){
	    
    	 // Visuals:
    	sprite_index	= global.sprFlameRocket;
    	spr_trail		= sprRocketFlame;
    	image_angle		= direction;
	  
    	 // Vars:
   // 	mask_index	= global.mskPopoRocketSmall;
    	speed 		= 2;
    	maxspeed	= 12;
    	friction	= -0.5;
    	typ   		= 1;
    	damage		= 3;
    	ammo_type	= 4;
    	is_rocket	= true;
    	creator		= other;
    	team  		= other.team;
    	hitid 		= [sprite_index, "FLAME ROCKET"];

    	on_step		= FlameRocket_step;
    	on_destroy	= FlameRocket_destroy;
    	on_draw		= FlameRocket_draw;

		return self;
    }


#define FlameRocket_step
	if(speed >= maxspeed){
		friction = 0;
	}
	
	if(current_frame_active){
		with(instance_create(x, y, Flame)){
			team			= other.team;
			creator 		= other;
			hitid			= other.hitid;
		}
	}
    
#define FlameRocket_destroy
	sound_stop(sndRocketFly)
	with(instance_create(x, y, Explosion)){
    	team            = other.team;
    	creator         = other.creator;
    	hitid           = other.hitid;
	}
	var _offset = random(360);
	for(var i = 0; i < 360; i += 30){
		with(instance_create(x, y, Flame)){
			direction		= i + _offset;
			speed			= 3;
	    	team            = other.team;
	    	creator         = other.creator;
	    	hitid           = other.hitid;
		}
	}
	
	sound_play_hit_big_ext(sndExplosion, 0.5 + random_range(0.8, 1.3), 0.8)
	sound_play_hit_big_ext(sndFlareExplode, 0.7 + random_range(0.8, 1.3), 1.2)
	
#define FlameRocket_draw
    draw_sprite_ext(spr_trail, current_frame * 0.4, x, y, 1, 1.2, image_angle, c_white, image_alpha);
    draw_set_blend_mode(bm_add);
	draw_sprite_ext(spr_trail, current_frame * 0.4, x, y, 1.8 * image_xscale, 1.8 * image_yscale, image_angle, c_white, 0.2);
    draw_set_blend_mode(bm_normal);
    draw_self();
    
#define GoldFlameRocket_create(_x, _y)
	with(FlameRocket_create(_x, _y)){
		sprite_index	= global.sprGoldFlameRocket;
		speed			= 3;
		maxspeed		= 14;
		friction		= -0.7
		
		return self;
	}
    
#define StarBullet_create(_x, _y)
	with(instance_create(_x, _y, CustomProjectile)){
		
         // Visuals:
        sprite_index    = global.sprStarBullet;
        spr_dead		= global.sprStarBulletHit;
        fr_bloom		= [2, 0.2]
        fr_glow 		= [16, 32];
        trailColor		= c_white;
        trailColor2		= make_color_rgb(122, 134, 236);
        turnSpeed		= (10 + random(5)) * choose(-1, 1);
        depth			= -1;
        image_xscale	= 1 + (skill_get(mut_laser_brain) * 0.1) + (mod_variable_get("mod", "Frontier_Events", "isNight") * 0.15);
        image_yscale	= image_xscale;
        
         // Vars:
        speed           = 11 + random(3);
        typ             = 1;
        damage          = 3;
        homerRange		= 16 + (mod_variable_get("mod", "Frontier_Events", "isNight") * 4);
        creator         = other;
        team            = other.team;
        hitid           = [sprite_index, "STAR BULLET"];
        ammo_type		= 5;
        friction		= 0.5;
        starDir 		= choose(-1, 1);
        minscale		= 0.5;
        
		
		 // Events:
		on_anim 		= StarBullet_anim;
		on_step 		= StarBullet_step;
		on_end_step		= StarBullet_endstep;
		on_hit			= StarBullet_hit;
		on_wall			= StarBullet_wall;
		on_destroy		= StarBullet_destroy;		
		
		return self;
	}
	
#define StarBullet_anim
	image_index = image_number - 1;
	image_speed = 0;
	
#define StarBullet_step
	if(current_frame_active){
		image_angle += turnSpeed;
		if(random(10) < 1){
			direction += (30 + random(20)) * starDir;
			starDir *= -1
		}
		if(random(24) < 1){
			with(instance_create(x, y, PlasmaTrail)){
				sprite_index	= global.sprStarBulletTrail;
				direction		= other.direction + 180 + orandom(10);
				speed			= other.speed / 8;
			}
		}
	}
	if(distance_to_object(enemy) < homerRange){
		var _enemy = instance_nearest(x, y, enemy);
		direction = point_direction(x, y, _enemy.x, _enemy.y)
	}
	if(speed <= 2 || image_xscale <= minscale){
		instance_destroy();
	}

#define StarBullet_endstep
	with(GenericTrail_create(x, y)){
		depth			= other.depth + 1;
		image_xscale	= point_distance(x, y, other.xprevious, other.yprevious)
		image_yscale   *= 2;
		image_speed    *= 2;
		image_angle 	= point_direction(x, y, other.xprevious, other.yprevious)
		image_blend 	= other.trailColor;
		image_alpha		= 0.8;
		trailColor2 	= other.trailColor2;
	    if fork(){
	        while(instance_exists(self)){
	            image_blend = merge_color(image_blend, trailColor2, 0.18 * current_time_scale);
	            wait(0)
	        }
	        exit
	    }
	}

#define StarBullet_hit
	if(projectile_canhit_np(other) && current_frame_active){
		projectile_hit_push(other, round(damage * image_xscale), force);
		image_xscale -= 0.2;
		image_yscale -= 0.2;
		x            -= hspeed_raw;
		y            -= vspeed_raw;
	}

#define StarBullet_wall
	move_bounce_solid(true);
	speed *= 0.7;
	sound_play_hit(sndHitWall, 0.2);
	
	
#define StarBullet_destroy
	with(instance_create(x, y, BulletHit)){
		sprite_index = other.spr_dead;
	}
	
#define StarBulletTrail_create(_x, _y)
	with(instance_create(_x, _y, PlasmaTrail)){
		sprite_index	= global.sprStarBulletTrail;
		
		return self;
	}
	
#define StarBig_create(_x, _y)
	with(instance_create(_x, _y, CustomProjectile)){
		
         // Visuals:
        sprite_index    = global.sprStarBig;
        spr_dead		= global.sprStarBulletHit;
        fr_bloom		= [1.3, 0.2]
        fr_glow 		= [16, 32];
        trailColor		= c_white;
        trailColor2		= make_color_rgb(122, 134, 236);
        turnSpeed		= (4 + random(2)) * choose(-1, 1);
        depth			= -1;
        image_xscale	= 0.3;
        image_yscale	= image_xscale;

        
         // Vars:
        speed           = 12;
        typ             = 1;
        damage          = 3;
        creator         = other;
        team            = other.team;
        hitid           = [sprite_index, "STAR BULLET"];
        ammo_type		= 5;
        friction		= 0.5;
        minscale		= 0.2;
        maxScale		= 1 + (skill_get(mut_laser_brain) * 0.2) + (mod_variable_get("mod", "Frontier_Events", "isNight") * 0.2);
        time2Grow		= false;
        grown			= false;
        lifeTime		= 40;
		
		 // Events:
		on_step 		= StarBig_step;
		on_end_step		= StarBullet_endstep;
		on_hit			= StarBig_hit;
		on_wall			= StarBullet_wall;
		on_destroy		= StarBullet_destroy;		
		
		return self;
	}
	
#define StarBig_step
	if(current_frame_active){
		if(random(24) < 1){
			with(instance_create(x, y, PlasmaTrail)){
				sprite_index	= global.sprStarBulletTrail;
				direction		= other.direction + 180 + orandom(10);
				speed			= other.speed / 8;
			}
		}
		
		image_angle += turnSpeed;
		
		if(grown = false){
			if(time2Grow = false){
				if(speed <= 2){
					time2Grow = true;
				}
			} else {
				if(image_xscale < maxScale){
					image_xscale += 0.05;
					image_yscale	= image_xscale;
				} else {
					grown		= true;
				}
			}
		} else {
			if(random(2) < 1){
				with(StarBullet_create(x, y)){
					direction	= random(360);
					speed		= 8 + random(3);
					team		= other.team;
					creator 	= other;
				}
			}
			
			 // lifetime
			lifeTime -= 1;
			if(lifeTime <= 0){
				if(image_xscale > 0){
					image_xscale -= 0.12;
					image_yscale	= image_xscale;
				} else {
					instance_destroy();
					exit;				
				}
			}
		}
	}
	
#define StarBig_hit
	if(projectile_canhit_melee(other)){
		speed *= 0.85
		lifeTime -= 0.3;
		projectile_hit(other, damage);
	}

	
#define InkBigFlak_create(_x, _y)
	with(instance_create(_x, _y, CustomProjectile)){
		
         // Visuals:
        sprite_index    = global.sprInkBigFlak;
        depth			= -1;
        
         // Vars:
        speed           = 12;
        typ             = 1;
        damage          = 6;
        creator         = other;
        team            = other.team;
        hitid           = [sprite_index, "BIG INK FLAK"];
        ammo_type		= 2;
        flakTime		= 3;
        flakCount		= 6;
        
		
		 // Events:
		on_step 		= InkBigFlak_step;
		on_hit			= InkFlak_hit;
		on_wall			= InkBigFlak_wall;
		on_destroy		= InkBigFlak_destroy;		
		
		return self;
	}
	
#define InkBigFlak_step
	flakTime -= current_time_scale;
	if(flakTime <= 0){
		repeat(5){
			with(instance_create(x, y, Smoke)){
				sprite_index	= global.sprInkSmoke;
				speed			= 1 + random(2);
				direction		= other.direction + random_range(-40, 40);
			}
		}
		instance_destroy();
	}

#define InkBigFlak_wall
	move_bounce_solid(true);
	with(instance_create(x, y, Smoke)){
		sprite_index	= global.sprInkSmoke;
	}
	sound_play_hit(sndHitWall, 0.2);
	instance_destroy();	
	
#define InkBigFlak_destroy
	repeat(flakCount){
		with(InkFlak_create(x, y)){
			direction	= other.direction + random_range(-25, 25);
			image_angle	= direction;
			team		= other.team;
			creator 	= other.creator;
		}
	}

#define InkFlak_create(_x, _y)
	with(instance_create(_x, _y, CustomProjectile)){
		
         // Visuals:
        sprite_index    = global.sprInkFlak;
        trailColor		= make_color_rgb(20, 18, 22);
        depth			= -1;
        
         // Vars:
        speed           = 11 + random(5);
        typ             = 1;
        damage          = 6;
        creator         = other;
        team            = other.team;
        hitid           = [sprite_index, "INK FLAK"];
        ammo_type		= 2;
        flakCount		= 4;
        friction		= 0.25;
        minspeed		= 4;
        inkSway 		= 3 * random_range(-1, 1);
        
		
		 // Events:
		on_step 		= InkFlak_step;
		on_end_step 	= InkFlak_endstep;
		on_hit			= InkFlak_hit;
		on_wall			= InkFlak_wall;
		on_destroy		= InkFlak_destroy;		
		
		return self;
	}

#define InkFlak_step
	if(current_frame_active){
		direction += inkSway;
		image_angle	= direction;
	}
	if(speed <= minspeed){
		instance_destroy();
	}
	
#define InkFlak_endstep
	with(GenericTrail_create(x, y)){
		depth			= other.depth + 1;
		image_xscale	= point_distance(x, y, other.xprevious, other.yprevious)
		image_yscale   *= 3;
		image_speed    *= 4.5;
		image_angle 	= point_direction(x, y, other.xprevious, other.yprevious)
		image_blend 	= other.trailColor;
		image_alpha		= 1
	    if fork(){
	        while(instance_exists(self)){
	            image_alpha -= 0.08 * current_time_scale;
	            wait(0)
	        }
	        exit
	    }
	}

#define InkFlak_hit
	if(projectile_canhit(other)){
		projectile_hit(other, damage, force);
		
		 // Goodbye:
		with(instance_create(x, y, Smoke)){
			sprite_index	= global.sprInkSmoke;
		}
		instance_destroy();
	}
	
#define InkFlak_wall
	move_bounce_solid(true);
	with(instance_create(x, y, Smoke)){
		sprite_index	= global.sprInkSmoke;
	}
	sound_play_hit(sndOasisShoot, 0.2);
	sound_play_pitchvol(sndToxicBoltGas, 0.7 + random(0.1), 0.2);
	instance_destroy();	

#define InkFlak_destroy
	repeat(flakCount){
		with(InkShrapnel_create(x, y)){
			direction	= random(360);
			image_angle	= direction;
			team		= other.team;
			creator		= other.creator;
		}
	}
	
#define InkShrapnel_create(_x, _y)
	with(instance_create(_x, _y, CustomProjectile)){
		
         // Visuals:
        sprite_index    = global.sprInkShrapnel;
        trailColor		= make_color_rgb(20, 18, 22);
        depth			= -1;
        
         // Vars:
        speed           = 4 + random(3);
        typ             = 1;
        damage          = 2;
        creator         = other;
        team            = other.team;
        hitid           = [sprite_index, "INK SHRAPNEL"];
        ammo_type		= 2;
        friction		= clamp(0.25 - (0.1 * skill_get(mut_shotgun_shoulders)), 0.02, 0.25);
        minspeed		= clamp(2 - skill_get(mut_shotgun_shoulders), 0.5, 2);
        inkSway 		= 2 * choose(-1, 1);
        
		
		 // Events:
		on_step 		= InkFlak_step;
		on_end_step		= InkFlak_endstep;
		on_hit			= InkFlak_hit;
		on_destroy		= InkShrapnel_destroy;		
		
		return self;
	}

#define InkShrapnel_destroy
	with(instance_create(x, y, Smoke)){
		sprite_index	= global.sprInkSmoke;
		image_xscale	= 0.6;
		image_yscale	= image_xscale;
		direction		= other.direction;
	}

#define DabloonBullet_create(_x, _y)
	with(instance_create(_x, _y, CustomProjectile)){
		name			= "fr_dabloonerbullet";
		
         // Visuals:
        sprite_index    = sprBullet1;
        spr_trail		= sprDiscTrail;
        image_angle		= random(360);
        hitid           = [sprite_index, "DABLOONER BULLET"];
        trailColor		= c_white;
        depth			= -1;
        
         // Vars:
        mask_index		= global.mskSawblade;
        speed           = 20;
        creator         = other;
        team            = other.team;
        fr_coinable		= true;
		
		 // Events:
		on_anim			= DabloonBullet_anim;
		on_destroy		= DabloonBullet_destroy;
		on_coined		= script_ref_create(DabloonBullet_coined);
		
		return self;
	}

#define DabloonBullet_anim
	image_index = image_number - 1;
	image_speed = 0;
	
#define DabloonBullet_destroy
	instance_create(x, y, BulletHit);

#define DabloonBullet_coined
	with(instances_matching(CustomObject, "fr_coin", true)){
		pauseTime = 10;
	}
	
	
#define Dabloon_create(_x, _y)
	with(instance_create(_x, _y, CustomObject)){
		name			= "fr_dabloon";
		
         // Visuals:
        sprite_index    = global.sprGoldSawblade;
        spr_trail		= sprDiscTrail;
        image_angle		= random(360);
        hitid           = [sprite_index, "DABLOON"];
        trailColor		= c_white;
        depth			= -10;
        image_alpha		= 0;
        
         // Vars:
        mask_index		= global.mskSawblade;
        speed           = 4;
        coinspeed		= speed;
        creator         = other;
        team            = other.team;
        z				= 4;
		zspeed  		= 5;
		zfriction		= 0.35;
		fr_coin 		= true;
		pauseTime		= 0;
		
		 // Events:
		on_step			= Dabloon_step;
		on_destroy		= Dabloon_destroy;	
		on_draw 		= Dabloon_draw;
		
		CoinTrail_create(x, y, self, c_yellow)
		
		return self;
	}

#define Dabloon_step

	 // Projectile 
	var _nearestCoinable = call(scr.instance_nearest_array, x, y, instances_matching(projectile, "fr_coinable", true));
	if(place_meeting(x, y - z, _nearestCoinable)){
		with(_nearestCoinable){
			script_ref_call(on_coined);
		}
	}
	
	if(pauseTime > 0){
		pauseTime	-= current_time_scale;
		speed		= 0;
		if(pauseTime <= 1){
			speed = coinspeed;
		}
	} else {
		 // Z-Axis:
		z += zspeed * current_time_scale;
		zspeed -= zfriction * current_time_scale;
		coinspeed = speed;
		
		 // Set Z Goin:
		if(z <= 0){
			friction	= 0.4;
			
			 // Impact:
			instance_destroy();
		}
	}
	
	
#define Dabloon_draw
	draw_sprite_ext(sprite_index, image_index, x, y - z, image_xscale, image_yscale, image_angle, image_blend, 1);

#define Dabloon_destroy
	sound_play_hit(sndDiscDie, 0.2);
	instance_create(x, y, DiscDisappear);
	
#define CoinTrail_create(_x, _y, _coin, _color)
	with(instance_create(_x, _y, CustomObject)){
		creator 	= _coin;
		trailColor	= _color;
		
		on_end_step 	= CoinTrail_endstep;
	}
	
#define CoinTrail_endstep
	if(!instance_exists(creator)){
		instance_destroy();
		exit;
	}
	x = creator.x;
	y = creator.y - creator.z;
	
	with(GenericTrail_create(x, y)){
		depth			= -10;
		image_xscale	= point_distance(x, y, other.xprevious, other.yprevious)
		image_yscale   *= 4;
		image_speed    *= 4;
		image_angle 	= point_direction(x, y, other.xprevious, other.yprevious)
		image_blend 	= other.trailColor;
		image_alpha		= 0.7;
	}

/*	
//#define GhostSlash_create(_x, _y)
	with(instance_create(_x, _y, CustomSlash)){
		name			= "fr_ghostslash";
		
         // Visuals:
        sprite_index    = global.sprGhostSlash;
        image_speed		= 0.4;
        image_angle		= direction;
        hitid           = [sprite_index, "GHOST SLASH"];
        image_alpha		= 0.8;
        
         // Vars:
        mask_index		= mskSlash;
        speed           = 2;
        friction		= 0.2;
        typ             = 0;
        damage          = 26;
        force			= 12;
        creator			= other;
        team			= other.team;
        canfix			= false;
        canreflect		= true;
        walled			= false;
        is_melee		= true;
        
		on_hit			= GhostSlash_hit;
		on_wall			= GhostSlash_wall;
        
        return self;
	}
	
//#define GhostSlash_hit
	if(projectile_canhit_melee(other)){
		projectile_hit(other, damage, force)
		if(other.my_health <= 0 && other.size > 0){
			with(GhostSkull_create(other.x, other.y)){
				speed = 3 + random(2);	
			}
		}
	}
	
//#define GhostSlash_wall
	if(!walled){
		walled = true;
		friction = 0.4;
		
		x -= hspeed_raw;
		y -= vspeed_raw;
	}

*/
#define GhostSkull_create(_x, _y)
	with(instance_create(_x, _y, CustomProjectile)){
		name			= "fr_ghostskull"
		
         // Visuals:
        sprite_index    = global.sprGhostSkull;
        image_speed 	= 0.4;
        depth			= -7;
        fr_bloom		= [1.5, 0.1];
        
         // Vars:
        speed           = 5;
        typ             = 1;
        damage          = 6;
        creator         = other;
        team            = other.team;
        hitid           = [sprite_index, "SCARY SKULL!!"];
        lifeTime		= 120;
        
		
		 // Events:
		on_step 		= GhostSkull_step;
	//	on_end_step 	= GhostSkull_endstep;
//		on_hit			= GhostSkull_hit;
		on_wall			= GhostSkull_wall;
//		on_destroy		= GhostSkull_destroy;		
		
		return self;
	}
	
#define GhostSkull_step
	lifeTime -= current_time_scale;
	if(lifeTime <= 0){
		instance_destroy();
		exit;
	}
	image_yscale = (image_angle + 270) mod 360 > 180 ? 1 : -1;

     // Homing:
    if(instance_exists(enemy)){
        var myTarget	= instance_nearest(x, y, enemy);
        direction		-= angle_difference(direction, point_direction(x, y, myTarget.x, myTarget.y)) * power(0.1, current_time_scale);
        image_angle		= direction;
    }
    
     // Particles:
    if(current_frame_active) && (random(4) < 1){
	    with instance_create(x + random_range(-4, 4), y + random_range(-4, 4), Smoke){ 
		    direction		= other.direction; 
		    speed			= 2; 
		    image_xscale	= 0.5; 
		    image_yscale	= image_xscale; 
	    }
    }
    
#define GhostSkull_wall
	xprevious = x + hspeed_raw;
	yprevious = y + vspeed_raw;


#define TideSlash_create(_x, _y)
	with(instance_create(_x, _y, CustomSlash)){
		name			= "fr_tideslash";
		
         // Visuals:
        sprite_index    = global.sprTideSlash;
        image_speed		= 0.4;
        image_angle		= direction;
        hitid           = [sprite_index, "TIDE SLASH"];
        
         // Vars:
        mask_index		= mskSlash;
        speed           = 5;
        friction		= 0.2;
        typ             = 0;
        damage          = 16;
        force			= 12;
        creator			= other;
        team			= other.team;
        canfix			= false;
        canreflect		= true;
        walled			= false;
        is_melee		= true;
        bubbles 		= 0;
        maxBubbles		= 13;
        
		on_hit			= TideSlash_hit;
		on_wall			= TideSlash_wall;
		on_projectile	= TideSlash_projectile;
        
        return self;
	}
	
#define TideSlash_hit
	if(projectile_canhit_melee(other)){
		projectile_hit(other, damage, force)
	}
	
#define TideSlash_wall
	if(!walled){
		walled = true;
		friction = 0.4;
		
		x -= hspeed_raw;
		y -= vspeed_raw;
	}
	
#define TideSlash_projectile
	var _team	= team,
		_dir	= direction;
	if(instance_exists(self)) && (other.typ > 0){ 
		with(other){
			if(other.bubbles < other.maxBubbles){
				with(TideBubble_create(x, y)){
					direction	= _dir + random_range(-35, 35);
					speed		= 3 + random(2);
					team		= _team;
				}
				other.bubbles += 1;
			}
			sound_play_pitchvol(sndPickupDisappear, 1.3 + random(0.2), 0.4)
			with(instance_create(x, y, BulletHit)){
				sprite_index	= global.sprTideBubbleNullify;
			}
			instance_destroy();
		} 
	}

#define TideBubble_create(_x, _y)
	with(instance_create(_x, _y, CustomProjectile)){
	    
    	 // Visuals:
    	sprite_index	= global.sprTideBubble;
    	spr_active		= global.sprTideBubbleActive;
    	image_speed		= 0.4;
    	image_angle		= direction;
    	image_index		= irandom(3);
    	trailColor		= make_color_rgb(42, 111, 92);
		bubble_tiltspeed= random_range(0.18, 0.26);
		bubble_tiltrange= random_range(35, 55);
		fr_bloom		= [1.4, 0.1];
	  
    	 // Vars:
    	mask_index	= mskBullet1;
    	speed 		= 3;
    	friction	= 0.2;
    	maxspeed	= 12;
    	typ   		= 2;
    	damage		= 4;
    	ammo_type	= -1;
    	creator		= other;
    	team  		= other.team;
    	hitid 		= [sprite_index, "TIDE BUBBLE"];
    	active			= false;
    	activeTimer		= 25 + irandom(20);
    	deactiveTimer	= 10; 

    	on_step		= TideBubble_step;
    	on_end_step	= TideBubble_endstep;
    	on_hit		= TideBubble_hit;
    	on_wall 	= TideBubble_wall;
    	on_destroy	= TideBubble_destroy;

		return self;
    }


#define TideBubble_step
	if(activeTimer > 0){
		activeTimer -= current_time_scale;
		if(activeTimer <= 0){
			active			= true;
			speed			= 8 + random(2);
			friction		= -0.1;
			sprite_index	= spr_active;
			
			if(instance_exists(enemy)){
				var _target 	= instance_nearest(x, y, enemy);
				direction		= point_direction(x, y, _target.x + random_range(-65, 65), _target.y + random_range(-65, 65));
			}

			
			repeat(1 + irandom(1)){
				with(instance_create(x, y, BulletHit)){
					sprite_index	= global.sprTideBubbleSpray;
					image_index		= irandom(1);
					speed			= 1 + random(2);
					direction		= other.direction + 180 + random_range(-40, 40);
				}
			}
			
			
		}
	}
     // Homing:
    if(active = true){
    	deactiveTimer -= current_time_scale;
    	if(deactiveTimer > 0){
	    	if(current_frame_active){
			    if(instance_exists(enemy)){
			        var _target		= instance_nearest(x, y, enemy);
			        direction		-= angle_difference(direction, point_direction(x, y, _target.x + random_range(-35, 35), _target.y + random_range(-35, 35))) * power(0.2, 1);
			    }
	    	}
    	} else {
    		direction += random_range(-5, 5);
    	}
    	image_angle		= direction;
    	
    	if(current_frame_active){
    		if(random(6) < 1){
	    		with(instance_create(x, y, BulletHit)){
	    			sprite_index	= global.sprTideBubbleTrail;
	    			speed			= 2 + random(2);
	    			direction		= other.direction + 180 + random_range(-25, 25);
	    		}
    		}
    	}
    	
    } else {
		image_angle = 0 + sin(current_frame * bubble_tiltspeed) * bubble_tiltrange
    }
    
#define TideBubble_endstep
	if(active = true){
		with(GenericTrail_create(x, y)){
			depth			= other.depth + 1;
			image_xscale	= point_distance(x, y, other.xprevious, other.yprevious)
			image_yscale   *= 3;
			image_speed    *= 3;
			image_angle 	= point_direction(x, y, other.xprevious, other.yprevious)
			image_blend 	= other.trailColor;
			if fork(){
		        while(instance_exists(self)){
		            image_alpha -= 0.1;
		            wait(0)
		        }
		        exit
		    }
		}
	}
    
#define TideBubble_wall
	if(active = true){
		instance_destroy();
		exit;
	} else {
		move_bounce_solid(true);
	}

#define TideBubble_hit
	if(active = true){
		projectile_hit(other, damage);
		instance_destroy();
	}
	
#define TideBubble_destroy
	with(instance_create(x, y, SmallExplosion)){
		damage			= 3;
		sprite_index	= global.sprTideBubbleExplosion;
    	team            = other.team;
    	creator         = other.creator;
    	hitid           = other.hitid;
    	
    	fr_augmentBoilingVeins = false; //unaffected by overcharged fuel
	}
	
	sound_play_hit_ext(sndOasisExplosionSmall, 0.9 + random(0.3), 0.8);
	
#define FireworkRocket_create(_x, _y)
	with(instance_create(_x, _y, CustomProjectile)){
	    
    	 // Visuals:
    	sprite_index	= global.sprFireworkRocket;
    	image_speed		= 0.4;
    	image_angle		= direction;
    	var _color		= random(255);
    	sparkColor		= make_color_hsv(_color, 200, 255);
		fireworkColor	= make_color_hsv(_color, random_range(210, 255), 255);
    	var _color2		= random(255);
		sparkColor2		= make_color_hsv(_color2, 200, 255);
		fireworkColor2	= make_color_hsv(_color2, random_range(210, 255), 255);
		fr_bloom		= [1.4, 0.1];
		fr_glow 		= [24, 32];
	  
    	 // Vars:
    	mask_index	= mskBullet1;
    	speed 		= 15;
    	friction	= 0.3;
    	damage		= 7;
    	ammo_type	= 4;
    	creator		= other;
    	team  		= other.team;
    	hitid 		= [sprite_index, "FIREWORK ROCKET"];
		lifeTime	= 20;

    	on_step		= FireworkRocket_step;
    //	on_end_step	= TideBubble_endstep;
    	on_wall 	= FireworkRocket_wall;
    	on_destroy	= FireworkRocket_destroy;

		return self;
    }
    
#define FireworkRocket_step
	if(lifeTime <= 0){
		instance_destroy();
		exit;
	}
	lifeTime -= current_time_scale;
	
	if(current_frame_active){
		with(instance_create(x, y, BulletHit)){
			sprite_index	= global.sprFireworkSparkle;
			image_blend		= choose(other.fireworkColor, other.fireworkColor, other.fireworkColor2);
			direction		= other.direction + 180 + random_range(-20, 20);
			speed			= other.speed / 3;
			image_xscale	= 0.6 + random(0.4);
			image_yscale	= image_xscale;
		}
		if(random(3) < 1){
			with(instance_create(x, y, Dust)){
				sprite_index	= global.sprWhiteSmoke;
				image_xscale	= 0.5;
				image_yscale	= image_xscale;
				speed			= 4;
				direction		= other.direction + 180 + random_range(-30, 30);
			}
		}
		if(random(4) < 1){
			with(instance_create(x, y, BulletHit)){
				sprite_index	= global.sprFireworkCandleTrail2;
				image_xscale	= random_range(0.3, 0.6)
			  	image_yscale	= image_xscale;
			  	image_speed 	= random_range(0.4, 0.8)
			  	speed			= 0.3;
			  	direction		= random(360);
			}
		}
	}
	
#define FireworkRocket_wall
	move_bounce_solid(true);
	image_angle		= direction;
	speed *= 0.7
	
#define FireworkRocket_destroy
	FireworkExplosion_spawn(x, y, fireworkColor, sparkColor, 2, team, creator, true);
	FireworkExtraBursts_create(x, y, fireworkColor2, sparkColor2, 5, 2, [0.1, 0.2], [7, 12], 0.8, team, creator);

#define GoldFireworkRocket_create(_x, _y)
	with(FireworkRocket_create(_x, _y)){
		
		 // Visuals:
		sprite_index	= global.sprGoldFireworkRocket;
		
		var _type		= choose("gold", "color");
		if(_type = "gold"){
			sparkColor		= make_color_rgb(203, 180, 105);
			fireworkColor   = make_color_rgb(203, 167, 58);
		} else {
			var _color		= random_range(100, 140);
			sparkColor		= make_color_hsv(_color, 200, 255);
			fireworkColor	= make_color_hsv(_color, random_range(210, 255), 255);
		}
		
		var _type		= choose("gold", "color", "color");
		if(_type = "gold"){
			sparkColor2		= make_color_rgb(203, 180, 105);
			fireworkColor2  = make_color_rgb(203, 167, 58);
		} else {
			var _color		= random_range(100, 140);
			sparkColor2		= make_color_hsv(_color, 200, 255);
			fireworkColor2	= make_color_hsv(_color, random_range(210, 255), 255);
		}
		
		return self;
	}
	
#define FireworkCandle_create(_x, _y)
	with(instance_create(_x, _y, CustomProjectile)){
	    
    	 // Visuals:
    	sprite_index	= global.sprFireworkCandle;
    	spr_base		= global.sprFireworkCandleBase;
    	image_speed		= 0.4;
    	image_angle		= direction;
    	var _color		= random(255);
    	sparkColor		= make_color_hsv(_color, 200, 255);
		fireworkColor	= make_color_hsv(_color, random_range(215, 255), 255);
		/*
		if(skill_get("AugmentBoilingVeins")){
			if(random(2) < 1){
				fireworkColor	= make_color_hsv(127 + random_range(-10, 60), 255, 255);
			}
		}
		*/
		image_blend		= fireworkColor;
		fr_bloom		= [2, 0.2];
		fr_glow 		= [32, 48];
	  
    	 // Vars:
    	mask_index	= mskBullet1;
    	speed 		= 14;
    	damage		= 12;
    	ammo_type	= 4;
    	creator		= other;
    	team  		= other.team;
    	hitid 		= [sprite_index, "FIREWORK CANDLE"];

    	on_step		= FireworkCandle_step;
    	on_end_step	= FireworkCandle_endstep;
    	on_destroy	= FireworkCandle_destroy;
    	on_draw 	= FireworkCandle_draw;

		return self;
    }
    
#define FireworkCandle_step
	if(current_frame_active){
		if(random(3) < 1){
			with(instance_create(x, y, Dust)){
				sprite_index	= global.sprWhiteSmoke;
				image_xscale	= 0.5;
				image_yscale	= image_xscale;
				speed			= 4;
				direction		= other.direction + 180 + random_range(-30, 30);
			}
		}
		if(random(7) < 1){
			with(instance_create(x, y, BulletHit)){
				sprite_index	= global.sprFireworkCandleTrail;
			  	speed			= 3;
			  	direction		= other.direction + 180 + random_range(-30, 30);
			}
		}
		if(random(6) < 1){
			with(instance_create(x, y, BulletHit)){
				sprite_index	= global.sprFireworkCandleTrail2;
				image_xscale	= random_range(0.3, 0.6)
			  	image_yscale	= image_xscale;
			  	image_speed 	= random_range(0.4, 0.8)
			  	speed			= 0.3;
			  	direction		= random(360);
			}
		}
	}

#define FireworkCandle_endstep
	with(GenericTrail_create(x, y)){
		depth			= other.depth + 1;
		image_xscale	= point_distance(x, y, other.xprevious, other.yprevious)
		image_yscale   *= 3;
		image_speed    *= 6;
		image_angle 	= point_direction(x, y, other.xprevious, other.yprevious)
		image_blend 	= other.fireworkColor;
	}


#define FireworkCandle_destroy
	FireworkExplosion_spawn(x, y, fireworkColor, sparkColor, random_range(0.4, 0.6), team, creator, false);
	
#define FireworkCandle_draw
	draw_sprite_ext(sprite_index, image_index, x, y, image_xscale, image_yscale, image_angle, image_blend, 1);
	draw_set_blend_mode(bm_add);
	draw_sprite_ext(spr_base, current_frame * .4, x, y, 1, 1, image_angle, c_white, image_alpha);
	draw_set_blend_mode(bm_normal);
	
#define FireworkSpark_create(_x, _y)
	with(instance_create(_x, _y, CustomProjectile)){
	    
    	 // Visuals:
    	sprite_index	= global.sprFireworkSparkMiddle;
    	image_speed		= 0.4;
		fireworkColor	= c_red;
	//	image_blend		= fireworkColor;
		fr_bloom		= [1.4, 0.1];
		depth			= -2;
		fr_glow			= [48, 64];
	 
    	 // Vars:
    	mask_index	= mskBullet1;
    	speed 		= 6 + random(7);
    	friction	= 0.4 + random(0.2);
    	damage		= 4;
    	ammo_type	= 4;
    	creator		= other;
    	team  		= other.team;
    	hitid 		= [sprite_index, "TIDE BUBBLE"];
    	dirAngle	= random(4) * choose(1, -1);
    	hitlist 	= [];

    	on_step		= FireworkSpark_step;
    	on_end_step	= FireworkSpark_endstep;
    	on_hit		= FireworkSpark_hit;
    	on_wall 	= FireworkRocket_wall;
    	on_destroy	= FireworkSpark_destroy;
    //	on_draw 	= FireworkSpark_draw;

		return self;
    }
    
#define FireworkSpark_step
	if(speed <= 0){
		instance_destroy();
		exit;
	}
	if(current_frame_active){
		direction += dirAngle;
		
		if(random(7) < 1){
			with(instance_create(x + random_range(-5, 5), y + random_range(-5, 5), BulletHit)){
				sprite_index	= global.sprFireworkTrail;
				image_blend		= other.fireworkColor;
				depth			= other.depth - 1;
				direction		= other.direction + 180 + random_range(-20, 20);
				speed			= other.speed / 4;
			}
		}
		
		if(random(15) < 1){
			with(instance_create(x, y, Flame)){
				sprite_index	= global.sprFireworkFlame;
				image_blend		= other.fireworkColor;
				team			= other.team;
				image_speed		= 0.4;
			}
		}
	}
	
#define FireworkSpark_endstep
	with(GenericTrail_create(x, y)){
		depth			= other.depth + 1;
		image_xscale	= point_distance(x, y, other.xprevious, other.yprevious)
		image_yscale   *= 3;
		image_speed    *= 2;
		image_angle 	= point_direction(x, y, other.xprevious, other.yprevious)
		image_blend 	= other.fireworkColor;
		if fork(){
	        while(instance_exists(self)){
	            image_alpha -= 0.06 * current_time_scale;
	            wait(0)
	        }
	        exit
	    }
	}
	
#define FireworkSpark_hit
	if(array_find_index(hitlist,other) == -1){
		array_push(hitlist, other);
		projectile_hit(other, damage);
		with(instance_create(x, y, Flame)){
			sprite_index	= global.sprFireworkFlame;
			image_blend		= other.fireworkColor;
			team			= other.team;
			image_speed		= 0.4;
		}
		speed *= 0.5;
	}
	
#define FireworkSpark_destroy
	with(instance_create(x, y, Flame)){
		sprite_index	= global.sprFireworkFlame;
		image_blend		= other.fireworkColor;
		team			= other.team;
		image_speed		= 0.4;
	}

#define FireworkExplosion_spawn(_x, _y, _color, _sparkColor, _size, _team, _creator, _sparkI)

	 // Explosion:
	if(_size >= 1){
		sound_play_pitchvol(sndExplosion, 0.5 + random(0.2), 1.5);
		sound_play_pitchvol(sndExplosionS, 0.5 + random(0.2), 1.5);
		
		view_shake_at(_x, _y, 40);
		
		repeat(_size){
			with(instance_create(_x, _y, Explosion)){
				sprite_index	= global.sprFireworkExplosion;
				image_blend		= _color;
				hitid			= [sprExplosion, "FIREWORK EXPLOSION"];
			}
			with(instance_create(_x, _y, SmallExplosion)){
				sprite_index	= global.sprFireworkSmallExplosion;
				image_blend		= _color;
				hitid			= [sprExplosion, "FIREWORK EXPLOSION"];
			}	
		}
		
		 // Flames:
		var _offset = random(360);
		for(var i = 0; i < 360; i += 30){
			with(instance_create(_x, _y, Flame)){
				sprite_index	= global.sprFireworkFlame;
				image_blend		= _color;
				direction		= i + _offset;
				speed			= 3;
		    	team            = other.team;
		    	creator         = other.creator;
		    	hitid			= [sprFlameBall, "FIREWORK EXPLOSION"];
				image_speed		= 0.4;
			}
		}
	} else {
		sound_play_pitchvol(sndExplosionS, 0.5 + random(0.3), 1.4);
		
		view_shake_at(_x, _y, 12);
		
		with(instance_create(_x, _y, SmallExplosion)){
			sprite_index	= global.sprFireworkSmallExplosion;
			image_blend		= _color;
			hitid			= [sprExplosion, "FIREWORK EXPLOSION"];
		}	
		
		 // Flames:
		var _offset = random(360);
		for(var i = 0; i < 360; i += 60){
			with(instance_create(_x, _y, Flame)){
				sprite_index	= global.sprFireworkFlame;
				image_blend		= _color;
				direction		= i + _offset;
				speed			= 2.5;
		    	team            = other.team;
		    	creator         = other.creator;
		    	hitid			= [sprFlameBall, "FIREWORK EXPLOSION"];
				image_speed		= 0.4;
			}
		}
	}
	
	 // Sparks:
	for(var i = 0; i < 360; i += (30 / _size)){
		with(FireworkSpark_create(_x, _y)){
			fireworkColor	= _color;
			image_blend		= _sparkColor;
			direction		= (_sparkI = true) ? i + random_range(-20, 20) : random(360);
			image_angle		= direction;
	    	team            = other.team;
	    	creator         = other.creator;
	    	hitid			= [sprFlameBall, "FIREWORK EXPLOSION"];
		}
	}
	
	 // Extra Flames:
	repeat(3 * _size){
		with(instance_create(_x, _y, Flame)){
			sprite_index	= global.sprFireworkFlame;
			image_blend		= _color;
			direction		= random(360);
			speed			= (4 + random(_size / 3))
	    	team            = other.team;
	    	creator         = other.creator;
	    	hitid			= [sprFlameBall, "FIREWORK EXPLOSION"];
			image_speed		= 0.4;
		}
	}
	
#define FireworkExtraBursts_create(_x, _y, _color, _sparkcolor, _bursts, _burstTime, _sizeRange, _speedRange, _friction, _team, _creator)
	with(instance_create(_x, _y, CustomObject)){
		sprite_index	= mskNone;
		
		bursts			= _bursts;
		burstTime		= _burstTime;
		maxBurstTime	= _burstTime;
		minSpeed		= _speedRange[0];
		maxSpeed		= _speedRange[1];
		bulFric 		= _friction;
		minSize 		= _sizeRange[0];
		maxSize 		= _sizeRange[1];
		team			= _team;
		creator 		= _creator;
		color			= _color;
		sparkcolor		= _sparkcolor;
		
		on_step 		= FireworkExtraBursts_step
		
		return self;
	}
	
#define FireworkExtraBursts_step
	if(bursts > 0){
		burstTime -= current_time_scale;
		if(burstTime <= 0){
			burstTime = maxBurstTime;
			bursts -= 1;
			FireworkBurstBullet_create(x, y, color, sparkcolor, [minSize, maxSize], [minSpeed, maxSpeed], bulFric, team, creator)
		}
		
	} else {
		instance_destroy();
	}


#define FireworkBurstBullet_create(_x, _y, _color, _sparkcolor, _sizeRange, _speedRange, _friction, _team, _creator)
	with(instance_create(_x, _y, CustomProjectile)){
		sprite_index	= mskNone;
		mask_index		= mskBullet1;
		color			= _color;
		sparkcolor		= _sparkcolor;

		direction		= random(360);	
		speed			= random_range(_speedRange[0], _speedRange[1]);
		friction		= _friction
		lifeTime		= 20;
		minSize 		= _sizeRange[0];
		maxSize 		= _sizeRange[1];
		team			= _team;
		creator 		= _creator;
		
		on_step 		= FireworkBurstBullet_step;
		on_destroy		= FireworkBurstBullet_destroy;
		
		return self;
	}
	
#define FireworkBurstBullet_step
	if(speed <= 0 || lifeTime <= 0){
		instance_destroy();
		exit;
	}
	
	lifeTime -= current_time_scale;
	
#define FireworkBurstBullet_destroy
	FireworkExplosion_spawn(x, y, color, sparkcolor, random_range(minSize, maxSize), team, creator, false);

#define GunpowderShell_create(_x, _y, _owner)
    with(instance_create(_x, _y, CustomProjectile)){
        
         // Visuals:
        sprite_index    = global.sprGunpowderShell;
        spr_fade		= global.sprGunpowderShellDisappear;
        spr_dead		= global.sprGunpowderShellDisappear;
        fr_bloom		= [2, 0.1];
        fr_glow 		= [16, 24];
        trailColor		= c_yellow;
        
         // Vars:
        speed           = 16;
        friction		= 0.6;
        typ             = 1;
        damage          = 1;
        force			= 2;
        creator         = other;
        team            = other.team;
        hitid           = [sprite_index, "GUNPOWDER SHELL"];
		bonus       	= true;
		bonus_damage	= 2;
		minspeed    	= 8;
		maxspeed    	= 16;
		wallbounce  	= 2 * skill_get(mut_shotgun_shoulders);
        ammo_type		= 2;
        is_shell		= true;
		
		 // Alarms:
		alarm2			= 2;
        
         // Events:
        on_anim			= GunpowderShell_anim;
        on_step         = GunpowderShell_step;
        on_hit			= GunpowderShell_hit;
        on_wall			= GunpowderShell_wall;
        on_destroy		= GunpowderShell_destroy;
        on_alrm2		= script_ref_create(GunpowderShell_alrm2);
        
        return self;
    }

#define GunpowderShell_anim
	
	 // Begone:
	if(sprite_index != spr_fade){
		image_speed = 0;
		image_index = image_number - 1;
	}
	
	 // Poof:
	else instance_destroy();
	
#define GunpowderShell_step

	 // Alarms:
	if(alarm2_run) exit;
	
	if(current_frame_active){
	    if(random(16) < 1){
	        with(instance_create(x + random_range(-2, 2), y + random_range(-2, 2), FireFly)){
				sprite_index	= global.sprGunpowderFireFly;
				image_angle		= other.direction + 90 + random_range(-20, 20);
	        }
	    }
	}
	
	 // Disappear:
	if(speed < minspeed && sprite_index != spr_fade){
		sprite_index = spr_fade;
		image_index  = 0;
		image_speed  = 0.4;
	}

#define GunpowderShell_wall
	instance_create(x, y, Smoke);
	if(speed > minspeed){
		sound_play_hit(sndShotgunHitWall, 0.2);
	}

	 // Reset Bonus Damage:
	if(wallbounce > 0 && !bonus){
		bonus = true;
		alarm2 = 2;
	}
	
	 // Bounce:
	move_bounce_solid(true);
	image_angle = direction;
	speed = min((speed * 0.9) + wallbounce, maxspeed);
	wallbounce *= 0.95;
	
#define GunpowderShell_alrm2
	bonus = false;
	
#define GunpowderShell_hit
	if(projectile_canhit(other)){
		projectile_hit(other, damage + (bonus_damage * bonus), force);
		instance_destroy();
	}
	
#define GunpowderShell_destroy
	with(instance_create(x, y, SmallExplosion)){
		hitid = [sprite_index, "GUNPOWDER SHELL#EXPLOSION"]
		damage *= 0.8;
	}
	sound_play_pitchvol(sndExplosionS, 1.1 + random(0.4), 0.7);

#define CoralBolt_create(_x, _y)
	with(instance_create(_x, _y, CustomProjectile)){
		name = "fr_coralBolt";
	    
    	 // Visuals:
    	sprite_index	= global.sprCoralBolt;
    	image_angle		= direction;
    	coralColor		= choose(
    		make_color_rgb(101, 84, 182),	// ourple
    		make_color_rgb(101, 84, 182),	// ourple
    		make_color_rgb(101, 84, 182),	// ourple
    		make_color_rgb(101, 84, 182),	// ourple
    		make_color_rgb(253, 129, 148),	// pink
    		make_color_rgb(251, 45, 76),	// red
    		make_color_rgb(255, 127, 80),	// orang
    		make_color_rgb(255, 148, 110),	// i think this color is called coral
    		make_color_rgb(213, 135, 255)	// ourple
		)
    	image_blend		= coralColor;
	  
    	 // Vars:
    	mask_index	= mskBolt;
    	speed 		= 22;
    	damage		= 12;
    	ammo_type	= 3;
        is_bolt 	= true;
		home_inst   = noone;
		home_dir    = 0;
    	creator		= other;
    	team  		= other.team;
    	hitid 		= [sprite_index, "CORAL BOLT"];
    	typ 		= 2;

		on_anim 	= CoralBolt_anim;
    //	on_step		= FireworkRocket_step;
    	on_end_step	= CoralBolt_endstep;
    	on_hit		= CoralBolt_hit;
    	on_wall 	= CoralBolt_wall;
    //	on_destroy	= FireworkRocket_destroy;

		return self;
    }

#define CoralBolt_anim
	image_index = image_number - 1;
	image_speed = 0;
	
#define CoralBolt_endstep

	 // homing taken from ntte:
	if(home_inst != noone){
		if(instance_exists(home_inst) && projectile_canhit_melee(home_inst)){
			 // Homing:
			if(
				abs(angle_difference(point_direction(x, y, home_inst.x, home_inst.y), home_dir)) < 90
				&&
				!place_meeting(x + lengthdir_x(speed, home_dir), y + lengthdir_y(speed, home_dir), home_inst)
			){
				var	_tx = home_inst.x - lengthdir_x(speed, home_dir),
					_ty = home_inst.y - lengthdir_y(speed, home_dir),
					_diff = angle_difference(point_direction(x, y, _tx, _ty), direction) * 0.5 * current_time_scale;
					
				direction += _diff;
				image_angle += _diff;
			}
			
			 // Done Homing:
			else{
				home_inst = noone;
				direction = home_dir;
				image_angle = direction;
			}
		}
		
		 // Return to Original Direction:
		else if(direction != home_dir){
			var _diff = angle_difference(home_dir, direction);
			if(abs(_diff) > 10) _diff = _diff * 0.5 * current_time_scale;
			direction += _diff;
			image_angle += _diff;
		}
		
		 // Done Homing:
		else home_inst = noone;
	}
	
	else{
		home_dir = direction;
		
		 // Home on Nearest Enemy:
		var _disMax = 24 * skill_get(mut_bolt_marrow);
		if(_disMax > 0){
			var _nearest = noone;
			with(instances_matching_ne(hitme, "team", team, 0)){
				if(!instance_is(self, prop)){
					var _dis = distance_to_point(other.x + other.hspeed, other.y + other.vspeed);
					if(_dis < _disMax){
						if(place_meeting(other.x, other.y, other)){
							_disMax  = _dis;
							_nearest = self;
						}
					}
				}
			}
			home_inst = _nearest;
		}
	}

	 // TRAIL
	var	_x1 = x,
		_y1 = y,
		_x2 = xprevious,
		_y2 = yprevious;
	
	with(instance_create(x, y, BoltTrail)){
		image_xscale	= point_distance(_x1, _y1, _x2, _y2);
		image_yscale	= 1.2;
		image_angle 	= point_direction(_x1, _y1, _x2, _y2);
		coralColor		= other.coralColor;
	    if fork(){
	        while(instance_exists(self)){
	            image_blend = merge_color(image_blend, coralColor, 0.18 * current_time_scale);
	            wait(0)
	        }
	        exit
	    }
	}
	
#define CoralBolt_hit

	 // Stick:
	if(other.my_health > damage){
		projectile_hit(other, damage, force);
	
		with(CoralGrowth_create(x, y, other, direction, team)){
			coralColor	= other.coralColor;
			image_blend	= coralColor;
	//		team		= other.team;
	
			with(instance_create(x, y, BulletHit)){
				sprite_index	= global.sprCoralGrowthHit;
				image_blend		= other.image_blend;
				depth			= other.depth + 1;
				image_xscale	= 0.5;
				image_yscale	= image_xscale;
			}
		}
		
		sound_play_pitchvol(sndPillarBreak, 1 + random(0.4), 0.7);
		
		
		instance_destroy();
		exit;
	}
		
	 // Damage:
	projectile_hit(other, damage, force);
	
#define CoralBolt_wall
	with(CoralGrowth_create(x, y, other, direction, team)){
		coralColor		= other.coralColor;
		image_blend		= coralColor;
	//	team			= other.team;
		walled			= true;
		move_contact_solid(direction, 16);
		
		with(instance_create(x, y, BulletHit)){
			sprite_index	= global.sprCoralGrowthHit;
			image_blend		= other.image_blend;
			depth			= other.depth + 1;
			image_xscale	= 0.5;
			image_yscale	= image_xscale;
		}
		
		sound_play_pitchvol(sndPillarBreak, 1 + random(0.4), 0.7);
	}
	instance_destroy();	

#define CoralGrowth_create(_x, _y, _host, _dir, _team)
  	with(instance_create(_x, _y, CustomSlash)){
		name = "fr_coralGrowth";
	    
    	 // Visuals:
    	sprite_index	= global.sprCoralClusterBig;
    	image_angle		= random(360);
    	image_xscale	= 0.2;
    	image_yscale	= image_xscale;
    	depth			= -1;
	  
    	 // Vars:
    	speed 			= 0;
    	direction		= _dir;
    	damage			= 0;
    	ammo_type		= -1;
    	creator			= other;
    	team  			= 2335;
    	trueTeam		= _team;
    	hitid 			= [sprite_index, "CORAL GROWTH"];
    	wallOffset		= -8;
    	host			= _host;
    	walled			= false;
    	if("my_health" in _host){
    		hostHealth	= _host.my_health;
    	}
    	grown			= false;
    	canreflect		= false;
    	deathTime		= -1;

		on_anim			= nothing;
    	on_end_step		= CoralGrowth_endstep;
    	on_projectile	= CoralGrowth_projectile;
    	on_grenade		= nothing;
    	on_hit			= nothing;
    	on_destroy		= CoralGrowth_destroy;

		return self;
    }
    
#define CoralGrowth_endstep
	if(!instance_exists(host)){
		if(walled = true){
			grown = true;
		}
		instance_destroy();
		exit;
	}
	
	if(grown = false){
		if(image_xscale >= 1){
			grown = true;
		} else {
			image_xscale	+= 0.1 * current_time_scale;
			image_yscale	= image_xscale;
		}
	}
	
	if(walled = false){
		
		x = (host.x + lengthdir_x(wallOffset, direction));
		y = (host.y + lengthdir_y(wallOffset, direction));
		
		if(grown = true){
			if("my_health" not in host || host.my_health < hostHealth){
				instance_destroy();
				exit;
			}
			
			hostHealth = host.my_health;
		}
		
	}

	
#define CoralGrowth_projectile
	if(grown = true){
		if("typ" in other && other.typ != -1){
			instance_destroy();
		}
	}
    
#define CoralGrowth_destroy
	if(grown = true){
		with(instance_create(x, y, PortalClear)){
			image_xscale	= 0.5;
			image_yscale	= image_xscale;
		}
		repeat(5){
			with(CoralPowerShard_create(x, y)){
				direction	= random(360);
				image_angle	= direction;
				team		= other.trueTeam;
			}
		}
		repeat(12){
			with(CoralShard_create(x, y)){
				direction	= random(360);
				image_angle	= direction;
				team		= other.trueTeam;
				
				coralColor	= other.coralColor;
				image_blend	= coralColor;
			//	hitlist 	= [other.host];
			}
		}
		with(instance_create(x, y, BulletHit)){
			sprite_index	= global.sprCoralGrowthHit;
			image_blend		= other.image_blend;
			depth			= other.depth + 1;
		}
		
		sound_play_pitchvol(sndWallBreakJungle, 2 + random(0.4), 0.55);
	}

#define CoralShard_create(_x, _y)
	with(instance_create(_x, _y, CustomProjectile)){
		name = "fr_coralShard";
	    
    	 // Visuals:
    	sprite_index	= global.sprCoralShard;
    	spr_dead		= global.sprCoralShardHit;
    	image_angle		= direction;
    	image_speed		= 0;
    	image_index		= irandom(image_number);
	  
    	 // Vars:
    	mask_index	= mskBolt;
    	speed 		= 8 + random(6);
    	mySpeed 	= speed;
    	friction	= 0.8 + random(0.2);
    	damage		= 2;
    	ammo_type	= 3;
    	creator		= other;
    	team  		= other.team;
    	hitid 		= [sprite_index, "CORAL SHARD"];
    	hitlist 	= [];

    //	on_step		= FireworkRocket_step;
    	on_end_step	= CoralShard_endstep;
    	on_hit		= CoralShard_hit;
    	on_wall 	= CoralShard_wall;
    	on_destroy	= CoralShard_destroy;

		return self;
    }

#define CoralShard_endstep
	image_xscale = (speed / (mySpeed / 3));
	
	if(speed <= 0){
		instance_destroy();
	}
	
#define CoralShard_hit
	if(array_find_index(hitlist, other) == -1){
		array_push(hitlist, other);
		projectile_hit(other, damage);
	}
	
#define CoralShard_wall
	move_bounce_solid(true);
	image_angle	= direction;
	
#define CoralShard_destroy
	with(instance_create(x, y, BulletHit)){
		sprite_index	= other.spr_dead;
		image_blend		= other.image_blend;
	}
	
#define CoralPowerShard_create(_x, _y)
	with(CoralShard_create(_x, _y)){
		
		sprite_index	= global.sprCoralPowerShard;
		spr_dead		= global.sprCoralPowerShardHit;
		image_blend 	= c_white;
		trailColor		= make_color_rgb(220, 156, 82);
		fr_bloom		= [2, 0.1];
		
		damage			= 4;
		speed			= 7 + random(5);
		friction		= 1.4;
		home_inst   	= noone;
		home_dir    	= 0;
		turnspeed		= 4 * choose(1, -1);
		
		on_end_step		= CoralPowerShard_endstep;
		on_destroy		= CoralPowerShard_destroy;
		
		return self;
	}
	
#define CoralPowerShard_endstep

	direction += turnspeed;
	image_angle	= direction;

	 // homing taken from ntte:
	if(home_inst != noone){
		if(instance_exists(home_inst) && projectile_canhit_melee(home_inst)){
			 // Homing:
			if(
				abs(angle_difference(point_direction(x, y, home_inst.x, home_inst.y), home_dir)) < 90
				&&
				!place_meeting(x + lengthdir_x(speed, home_dir), y + lengthdir_y(speed, home_dir), home_inst)
			){
				var	_tx = home_inst.x - lengthdir_x(speed, home_dir),
					_ty = home_inst.y - lengthdir_y(speed, home_dir),
					_diff = angle_difference(point_direction(x, y, _tx, _ty), direction) * 0.5 * current_time_scale;
					
				direction += _diff;
				image_angle += _diff;
			}
			
			 // Done Homing:
			else{
				home_inst = noone;
				direction = home_dir;
				image_angle = direction;
			}
		}
		
		 // Return to Original Direction:
		else if(direction != home_dir){
			var _diff = angle_difference(home_dir, direction);
			if(abs(_diff) > 10) _diff = _diff * 0.5 * current_time_scale;
			direction += _diff;
			image_angle += _diff;
		}
		
		 // Done Homing:
		else home_inst = noone;
	}
	
	else{
		home_dir = direction;
		
		 // Home on Nearest Enemy:
		var _disMax = 24 * skill_get(mut_bolt_marrow);
		if(_disMax > 0){
			var _nearest = noone;
			with(instances_matching_ne(hitme, "team", team, 0)){
				if(!instance_is(self, prop)){
					var _dis = distance_to_point(other.x + other.hspeed, other.y + other.vspeed);
					if(_dis < _disMax){
						if(place_meeting(other.x, other.y, other)){
							_disMax  = _dis;
							_nearest = self;
						}
					}
				}
			}
			home_inst = _nearest;
		}
	}


	image_xscale = (speed / (mySpeed / 3));
	
	var	_x1 = x,
		_y1 = y,
		_x2 = xprevious,
		_y2 = yprevious;
	
	with(instance_create(x, y, BoltTrail)){
		image_blend		= other.trailColor;
		image_xscale	= point_distance(_x1, _y1, _x2, _y2);
		image_yscale	= 2;
		image_angle 	= point_direction(_x1, _y1, _x2, _y2);
	}
	
	if(speed <= 0){
		instance_destroy();
	}
	
#define CoralPowerShard_destroy
	with(instance_create(x, y, BulletHit)){
		sprite_index	= other.spr_dead;
	}

#define ToxicCoralBolt_create(_x, _y)
	with(instance_create(_x, _y, CustomProjectile)){
		name = "fr_toxicCoralBolt";
	    
    	 // Visuals:
    	sprite_index	= global.sprToxicCoralBolt;
    	image_angle		= direction;
    	coralColor		= choose(
    		make_color_rgb(165, 180, 105),
    		make_color_rgb(116, 150, 88),
    		make_color_rgb(90, 130, 70),
		)
    	image_blend		= coralColor;
	  
    	 // Vars:
    	mask_index	= mskBolt;
    	speed 		= 22;
    	damage		= 12;
    	ammo_type	= 3;
        is_bolt 	= true;
		home_inst   = noone;
		home_dir    = 0;
    	creator		= other;
    	team  		= other.team;
    	hitid 		= [sprite_index, "TOXICORAL BOLT"];
    	typ 		= 2;

		on_anim 	= CoralBolt_anim;
    	on_end_step	= CoralBolt_endstep;
    	on_hit		= ToxicCoralBolt_hit;
    	on_wall 	= ToxicCoralBolt_wall;

		return self;
    }
	
#define ToxicCoralBolt_hit

	 // Stick:
	if(other.my_health > damage){
		projectile_hit(other, damage, force);
	
		with(ToxicCoralGrowth_create(x, y, other, direction, team)){
			coralColor	= other.coralColor;
			image_blend	= coralColor;
	//		team		= other.team;
	
			with(instance_create(x, y, BulletHit)){
				sprite_index	= global.sprCoralGrowthHit;
				image_blend		= other.image_blend;
				depth			= other.depth + 1;
				image_xscale	= 0.5;
				image_yscale	= image_xscale;
			}
		}
		
		sound_play_pitchvol(sndPillarBreak, 1 + random(0.4), 0.7);
		
		
		instance_destroy();
		exit;
	}
		
	 // Damage:
	projectile_hit(other, damage, force);
	
#define ToxicCoralBolt_wall
	with(ToxicCoralGrowth_create(x, y, other, direction, team)){
		coralColor		= other.coralColor;
		image_blend		= coralColor;
	//	team			= other.team;
		walled			= true;
		move_contact_solid(direction, 16);
		
		with(instance_create(x, y, BulletHit)){
			sprite_index	= global.sprCoralGrowthHit;
			image_blend		= other.image_blend;
			depth			= other.depth + 1;
			image_xscale	= 0.5;
			image_yscale	= image_xscale;
		}
		
		sound_play_pitchvol(sndPillarBreak, 1 + random(0.4), 0.7);
	}
	instance_destroy();	

#define ToxicCoralGrowth_create(_x, _y, _host, _dir, _team)
  	with(CoralGrowth_create(_x, _y, _host, _dir, _team)){
		name = "fr_coralGrowth";
	    
    	 // Visuals:
    	sprite_index	= global.sprToxicCoralCluster;
	  
    	 // Vars:
    	direction		= _dir;
    	creator			= other;
    	trueTeam		= _team;
    	hitid 			= [sprite_index, "TOXICORAL GROWTH"];
    	host			= _host;
    	if("my_health" in _host){
    		hostHealth	= _host.my_health;
    	}
    	
    	on_destroy		= ToxicCoralGrowth_destroy;

		return self;
    }
    
#define ToxicCoralGrowth_destroy
	if(grown = true){
		with(instance_create(x, y, PortalClear)){
			image_xscale	= 0.5;
			image_yscale	= image_xscale;
		}
		repeat(8){
			with(ToxicCoralPowerShard_create(x, y)){
				direction	= random(360);
				image_angle	= direction;
				team		= other.trueTeam;
			}
		}
		repeat(7){
			with(CoralShard_create(x, y)){
				direction	= random(360);
				image_angle	= direction;
				team		= other.trueTeam;
				
				coralColor	= other.coralColor;
				image_blend	= coralColor;
			//	hitlist 	= [other.host];
			}
		}
		with(instance_create(x, y, BulletHit)){
			sprite_index	= global.sprCoralGrowthHit;
			image_blend		= other.image_blend;
			depth			= other.depth + 1;
		}
		
		repeat(5){
			with(instance_create(x, y, ToxicGas)){
				speed		= 0.5 + random(0.5);
				direction	= random(360);
				friction	= 0.05;
			}
		}
		
		sound_play_pitchvol(sndWallBreakJungle, 2 + random(0.4), 0.4);
		sound_play_pitchvol(sndToxicBoltGas, 0.6 + random(0.3), 0.8);
	}

#define ToxicCoralPowerShard_create(_x, _y)
	with(CoralShard_create(_x, _y)){
		
		sprite_index	= global.sprToxicCoralPowerShard;
		spr_dead		= global.sprToxicCoralPowerShardHit;
		image_blend 	= c_white;
		trailColor		= make_color_rgb(207, 204, 84);
		fr_bloom		= [2, 0.1];
		
		damage			= 3;
		speed			= 7 + random(5);
		friction		= 1.4;
		home_inst   	= noone;
		home_dir    	= 0;
		turnspeed		= 4 * choose(1, -1);
		
		on_end_step		= CoralPowerShard_endstep;
		on_destroy		= ToxicCoralPowerShard_destroy;
		
		return self;
	}
	
#define ToxicCoralPowerShard_destroy
	with(instance_create(x, y, BulletHit)){
		sprite_index	= other.spr_dead;
	}
	repeat(3){
		with(instance_create(x, y, ToxicGas)){
			speed		= 1 + random(2);
			direction	= random(360);
			friction	= 0.05;
			growspeed	/= 8;
		}
	}
	
#define Pufferbomb_create(_x, _y)
  	with(instance_create(_x, _y, CustomProjectile)){
		name = "fr_Pufferbomb";
	    
    	 // Visuals:
    	sprite_index	= sprStickyGrenade;
    	spr_blink		= sprGrenadeBlink;
    	image_angle		= random(360);
    	depth			= -3;
    	image_speed		= 0.4;
	  
    	 // Vars:
    	speed 			= 12;
    	friction		= 0.4;
    	damage			= 0;
    	ammo_type		= 4;
    	creator			= other;
    	hitid 			= [sprite_index, "PUFFERBOMB"];
    	host			= noone;
    	grown			= false;
    	canreflect		= false;
    	lifeTime		= 40;
    	wallOffset		= -8 + random(3);
    	wallHit 		= false;

    	on_end_step		= Pufferbomb_endstep;
    	on_wall 		= Pufferbomb_wall;
    	on_hit			= Pufferbomb_hit;
    	on_destroy		= Pufferbomb_destroy;

		return self;
    }
    
#define Pufferbomb_endstep
	if(host != noone){
		if(instance_exists(host)){
			x = (host.x + lengthdir_x(wallOffset, direction));
			y = (host.y + lengthdir_y(wallOffset, direction));
		} else {
			host = noone;
		}
	}
	if(place_meeting(x, y, Explosion)){
		instance_destroy();
		exit;
	}
	
	lifeTime -= current_time_scale;
	if((lifeTime < 10) && (sprite_index != spr_blink)){
		sprite_index	= spr_blink;
	}
	if(lifeTime <= 0){
		instance_destroy();
	}
	/*
	if(deathTime != -4){
		if(deathTime > 0){
			deathTime -= current_time_scale
		} else {
			instance_destroy();
		}
	}
	*/
		
#define Pufferbomb_hit
	if(host = noone){
		host = other;	
	}
	
#define Pufferbomb_wall
	if(wallHit = false){
		speed = 0;
		sound_play_pitch(sndGrenadeStickWall, 0.7 + random(0.2));
	}
	
#define Pufferbomb_destroy
	with(instance_create(x, y, Explosion)){
		hitid	= other.hitid;
	}
	repeat(3){
		with(instance_create(x, y, SmallExplosion)){
			hitid	= other.hitid;
		}
	}
	
	repeat(12){
		with(CoralShard_create(x, y)){
			direction		= random(360);
			image_angle		= direction;
			speed			= 12 + random(4);
			friction		= 1.2 + random(0.3);
			image_yscale	= 0.5;
			
			team			= other.team;
			creator			= other;
			hitid			= other.hitid;
		}
	}
	
	sound_play_pitch(sndExplosion, 0.7 + random(0.2));

	//#endregion

	//#region WEAPON BURST
#define WeaponBurst_create(_x, _y)
    with(instance_create(_x, _y, CustomObject)){
        name = "WeaponBurst";
        
         // Vars:
        accuracy    = 1;
        team        = -1;
        creator     = noone;
        ammo        = 0;
        time        = 0;
        time_max    = 0;
        burst       = 0;
        wep         = wep_none;
        spec        = false;
        
         // Events:
        on_step     = script_ref_create(WeaponBurst_step);
        
        return self;
    }
    
#define WeaponBurst_step
    if(time > 0 && ammo > 0){
        
        time -= current_time_scale;
        if(time <= 0){
            
            time += time_max;
            ammo -= 1;
            
            burst++;
            
             // Fire:
            if(instance_exists(creator)){
                x = creator.x;
                y = creator.y;
                if("gunangle" in creator){
                    direction = creator.gunangle;
                }
                
                if(instance_is(creator, Player)){
                    with(creator){
                        
                        if(other.spec){
                            player_swap(self);
                            specfiring = true;
                        }
                        
                        var _accuracy = accuracy,
                            _team     = team;
                            
                        accuracy = other.accuracy;
                        team     = other.team;
                        
                        mod_script_call("weapon", other.wep, "weapon_fire");
                        
                        accuracy = _accuracy;
                        team     = _team;
                        
                        if(other.spec){
                            player_swap(self);
                            specfiring = false;
                        }
                    }
                }
                else{
                    
                     // Non-Player Firing:
                    with(player_fire_ext(direction, wep_none, x, y, team, creator, accuracy)){
                        wep = other.wep;
                        mod_script_call("weapon", wep, "weapon_fire");
                        
                         // Pass Variables:
                        with(other.creator){
                            if(friction != 0){
                                hspeed += other.hspeed;
                                vspeed += other.vspeed;
        						if("wkick"    in self) wkick    = other.wkick;
        						if("wepangle" in self) wepangle = other.wepangle * ((abs(other.wepangle) > 1) ? sign(wepangle) : wepangle);
        						if("reload"   in self) reload  += other.reload;
                            }
                        }
                    }
                }
            }
        }
    }
    else{
        
         // Goodbye:
        instance_destroy();
    }

#define charge_weapon_fire_init(_wep)
	// CODE TAKEN FROM NT:TE, thank u yokin
	
	/*
		Called from a weapon mod's 'weapon_fire' script to do some basic setup
		Returns a LWO with some useful variables
		
		Vars:
			wep     - The weapon's value, may be modified from the given argument
			creator - The actual instance firing, for 'player_fire_ext()' support
			primary - The weapon is in the primary slot (true) or secondary slot (false)
			wepheld - The weapon is physically stored in the creator's 'wep' variable
			spec    - The weapon is being shot by an active (YV, Steroids, Skeleton)
	*/
	
	var _fire = {
		"wep"     : _wep,
		"creator" : noone,
		"primary" : true,
		"wepheld" : false,
		"spec"    : false
	};
	
	 // Creator:
	_fire.creator = self;
	if(instance_is(self, FireCont) && "creator" in self && instance_exists(creator)){
		_fire.creator = creator;
	}
	
	 // Weapon Held by Creator:
	_fire.wepheld = ("wep" in _fire.creator && _fire.creator.wep == _fire.wep);
	
	 // Active / Secondary Firing:
	_fire.spec = (("specfiring" in self) ? specfiring : false);
	if(race == "steroids" && _fire.spec){
		_fire.primary = false;
	}

	var _other = other;
	with(instance_exists(_fire.creator) ? _fire.creator : self){
		 // Charge Weapon:
		if(weapon_get("chrg", _fire.wep) && _fire.wep.chrg >= 0){
			var	_load = (("reloadspeed" in self) ? reloadspeed : 1) * current_time_scale,
				_auto = ((other.race == "steroids") ? (weapon_get("auto", _fire.wep) >= 0) : weapon_get("auto", _fire.wep));
				
			 // Charging (chrg: -1==Released, 0==None, 1==Charging, 2==Charged):
			_fire.wep.chrg = ((_fire.wep.chrg_num < _fire.wep.chrg_max) ? 1 : 2);
			switch(_fire.wep.chrg){
				
				case 1: // Charging
					
					_fire.wep.chrg_num = min(_fire.wep.chrg_num + _load, _fire.wep.chrg_max);
					
					 // Pop Pop:
					if(_fire.spec && _fire.primary){
						_fire.wep.chrg_num = _fire.wep.chrg_max;
					}
					
					break;
					
				case 2: // Fully Charged - Blink
					
					if(((current_frame /*+epsilon*/) % 12) < current_time_scale){
						with(_fire.creator) if(instance_is(self, Player)){
							gunshine = 2;
						}
					}
					
					break;
					
			}
			
			 // Hold to Charge:
			if(_auto || _fire.wep.chrg_num >= _fire.wep.chrg_max){
				 // Manual Reload:
				other.reload = min(other.reload, _load);
				
				 // Charge Controller:
				with(other){
					var _inst = instances_matching(instances_matching(CustomObject, "name", "fr_FireCharge"), "wep", _fire.wep);
					if(array_length(_inst) < 1){
						_inst = FireCharge_create(x, y)
						with(_inst){
							wep = _fire.wep;
						}
					}
					with(_inst){
						x         = other.x;
						y         = other.y;
						direction = other.gunangle;
						accuracy  = other.accuracy;
						team      = other.team;
						creator   = _fire.creator;
						primary   = _fire.primary;
						fire      = !_auto;
					}
				}
			}
		}
	}
	
	return _fire;
	
#define FireCharge_create(_x, _y)
	/*
		Controller object used for NT:TE's burst weapons
	*/
	
	with(instance_create(_x, _y, CustomObject)){
		name = "fr_FireCharge";
		
		 // Vars:
		accuracy = 1;
		team     = -1;
		creator  = noone;
		primary  = true;
		wep      = wep_none;
		fire     = false;
		
		on_step	 = FireCharge_step;
		
		return self;
	}
	
#define FireCharge_step
	if(fire){
		if(is_object(wep) && "chrg" in wep){
			if(wep.chrg){
				wep.chrg = -1;
				if(instance_exists(creator) && creator.visible){
					x = creator.x;
					y = creator.y;
					if(variable_instance_get(creator, (primary ? "wep" : "bwep"), wep) == wep){
						 // Player:
						if(instance_is(creator, Player)){
							var	_team     = team,
								_accuracy = accuracy,
								_primary  = primary;
								
							with(creator){
								 // Steroids:
								if(!_primary){
									player_swap(self)
									specfiring = true;
								}
								
								 // Fire:
								var	_type = weapon_get_type(wep),
									_cost = weapon_get_cost(wep),
									_rads = weapon_get_rads(wep),
									_ammo = ammo[_type];
									
								if(infammo != 0 || (_ammo >= _cost && GameCont.rad >= _rads)){
									var	_lastTeam     = team,
										_lastAccuracy = accuracy;
										
									team     = _team;
									accuracy = _accuracy;
									
									player_fire(other.direction);
									
									if(team     == _team    ) team     = _lastTeam;
									if(accuracy == _accuracy) accuracy = _lastAccuracy;
									else if(_accuracy != 0){
										accuracy = _lastAccuracy * (accuracy / _accuracy);
									}
								}
								
								 // Low Ammo:
								else{
									wkick     = -2;
									clicked   = false;
									drawempty = 30;
									if(_ammo < _cost){
										sound_play(sndEmpty);
										call(scr.pickup_text, typ_name[_type], ((_ammo > 0) ? "ins" : "out"));
									}
									else{
										sound_play(sndUltraEmpty);
										call(scr.pickup_text, "RADS", "ins");
									}
								}
								
								 // Steroids:
								if(!_primary){
									specfiring = false;
									call(scr.player_swap, self);
								}
							}
						}
						
						 // Non-Player:
						else FireCont_end(player_fire_ext(direction, wep, x, y, team, creator, accuracy));
					}
				}
				wep.chrg = 0;
			}
			wep.chrg_num = 0;
		}
		instance_destroy();
	}
	else fire = true;
	
	
#define player_swap(_player)
	/*
	    Code lifted directly from NT:TE
		Cycles the given player's weapon slots
	*/
	
	with(["%wep", "%curse", "%reload", "%wkick", "%wepflip", "%wepangle", "%can_shoot", "%clicked", "%interfacepop", "drawempty%"]){
		var	_name = [string_replace(self, "%", ""), string_replace(self, "%", "b")],
			_temp = variable_instance_get(_player, _name[0], 0);
			
		variable_instance_set(_player, _name[0], variable_instance_get(_player, _name[1], 0));
		variable_instance_set(_player, _name[1], _temp);
	}

#define weapon_get(_eventName, _wep)
	/*
		Calls the given event of the given weapon and returns its returned value
		If the given event is "fire", the return value is the instance used to fire the given weapon
		
		Ex:
			weapon_get("chrg", "trident") == true
	*/
	
	var _baseWep = _wep;
	
	 // Find Base Weapon:
	while(is_object(_baseWep) && "wep" in _baseWep){
		_baseWep = _baseWep.wep;
	}
	
	 // Call Script:
	if(is_string(_baseWep)){
		var _scriptName = "weapon_" + _eventName;
		if(mod_script_exists("weapon", _baseWep, _scriptName)){
			var _call = [0];
			if(fork()){
				_call[0] = (
					(is_real(self) && instance_exists(self))
					? (
						(is_real(other) && instance_exists(other))
						? mod_script_call("weapon", _baseWep, _scriptName, _wep)
						: mod_script_call_self("weapon", _baseWep, _scriptName, _wep)
					)
					: mod_script_call_nc("weapon", _baseWep, _scriptName, _wep)
				);
				exit;
			}
			return (
				(_eventName == "fire")
				? self
				: _call[0]
			);
		}
	}
	
	 // Default:
	switch(_eventName){
		
		case "avail":
		case "burst":
		
			return 1;
			
		case "fire":
		
			var	_minID        = instance_max,
				_lastRads     = GameCont.rad,
				_lastLoad     = reload,
				_lastCanShoot = can_shoot,
				_fireInst     = self;
				
			 // Fire:
			if(instance_is(self, Player)){
				var	_lastAmmo     = array_clone(ammo),
					_lastDraw     = drawempty,
					_lastWep      = wep;
					
				wep = _wep;
				player_fire();
				
				 // Revert Values:
				array_copy(ammo, 0, _lastAmmo, 0, array_length(_lastAmmo));
				drawempty = _lastDraw;
				wep       = _lastWep;
			}
			else _fireInst = player_fire_ext(
				gunangle,
				_wep,
				x,
				y,
				team,
				(("creator" in self) ? creator : self),
				accuracy
			);
			
			 // Revert Values:
			GameCont.rad = _lastRads;
			reload       = _lastLoad;
			can_shoot    = _lastCanShoot;
			
			 // Delete Effects:
			if(instance_exists(LaserBrain) || instance_exists(SteroidsTB)){
				for(var _id = instance_max - 1; _id >= _minID; _id--){
					if("object_index" in _id){
						switch(_id.object_index){
							case LaserBrain:
								instance_delete(_id);
								break;
								
							case SteroidsTB:
								if(instance_is(_id + 1, PopupText)){
									instance_delete(_id + 1);
								}
								instance_delete(_id);
								break;
						}
					}
				}
			}
			
			return _fireInst;
			
		case "loadout":
		
			switch(_baseWep){
				case wep_revolver                : return sprRevolverLoadout;
				case wep_golden_revolver         : return sprGoldRevolverLoadout;
				case wep_chicken_sword           : return sprChickenSwordLoadout;
				case wep_rogue_rifle             : return sprRogueRifleLoadout;
				case wep_rusty_revolver          : return sprRustyRevolverLoadout;
				case wep_golden_wrench           : return sprGoldWrenchLoadout;
				case wep_golden_machinegun       : return sprGoldMachinegunLoadout;
				case wep_golden_shotgun          : return sprGoldShotgunLoadout;
				case wep_golden_crossbow         : return sprGoldCrossbowLoadout;
				case wep_golden_grenade_launcher : return sprGoldGrenadeLauncherLoadout;
				case wep_golden_laser_pistol     : return sprGoldLaserPistolLoadout;
				case wep_golden_screwdriver      : return sprGoldScrewdriverLoadout;
				case wep_golden_assault_rifle    : return sprGoldAssaultRifleLoadout;
				case wep_golden_slugger          : return sprGoldSluggerLoadout;
				case wep_golden_splinter_gun     : return sprGoldSplintergunLoadout;
				case wep_golden_bazooka          : return sprGoldBazookaLoadout;
				case wep_golden_plasma_gun       : return sprGoldPlasmaGunLoadout;
				case wep_golden_nuke_launcher    : return sprGoldNukeLauncherLoadout;
				case wep_golden_disc_gun         : return sprGoldDiscgunLoadout;
				case wep_golden_frog_pistol      : return sprGoldToxicGunLoadout;
			}
			
			break;
			
		case "raw":
		
			return (is_object(_wep) ? wep_none : _wep);
			
	}
	
	return 0;

#define FireCont_end // inst=self
	/*
		Transfers a given FireCont instance's variables to its creator
	*/
	
	with((argument_count > 0) ? argument[0] : self){
		if("creator" in self){
			with(creator){
				if(friction != 0){
					hspeed += other.hspeed;
					vspeed += other.vspeed;
				}
				if("wkick"    in self) wkick    = other.wkick;
				if("wepangle" in self) wepangle = other.wepangle * ((abs(other.wepangle) > 1) ? sign(wepangle) : wepangle);
				if("reload"   in self) reload  += other.reload;
			}
		}
	}		

#define WhiteSmoke_create(_x, _y)
	with(instance_create(_x, _y, Smoke)){
		sprite_index	= global.sprWhiteSmoke;
		return self;
	}
	
#define WhiteDust_create(_x, _y)
	with(instance_create(_x, _y, Dust)){
		sprite_index	= global.sprWhiteSmoke;
		return self;
	}

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
    
#define sound_play_hit_ext(_sound, _pitch, _volume)
	var _sound = sound_play_hit(_sound, 1);
	audio_sound_pitch(_sound, _pitch);
	audio_sound_gain(_sound, _volume, 0);
	
#define sound_play_hit_big_ext(_sound, _pitch, _volume)
	var _sound = sound_play_hit_big(_sound, 1);
	audio_sound_pitch(_sound, _pitch);
	audio_sound_gain(_sound, _volume, 0);
    
#macro current_frame_active 																	frac(current_frame) < current_time_scale
#macro  anim_end																				((image_index + image_speed_raw) >= image_number || (image_index + image_speed_raw) < 0)
#macro  alarm0_run                                                                              alarm0 && !--alarm0 && !--alarm0 && (script_ref_call(on_alrm0) || !instance_exists(self));
#macro  alarm1_run                                                                              alarm1 && !--alarm1 && !--alarm1 && (script_ref_call(on_alrm1) || !instance_exists(self));
#macro  alarm2_run                                                                              alarm2 && !--alarm2 && !--alarm2 && (script_ref_call(on_alrm2) || !instance_exists(self));
#macro  alarm3_run                                                                              alarm3 && !--alarm3 && !--alarm3 && (script_ref_call(on_alrm3) || !instance_exists(self));
#macro  alarm4_run                                                                              alarm4 && !--alarm4 && !--alarm4 && (script_ref_call(on_alrm4) || !instance_exists(self));
#macro  alarm5_run                                                                              alarm5 && !--alarm5 && !--alarm5 && (script_ref_call(on_alrm5) || !instance_exists(self));
#macro  alarm6_run                                                                              alarm6 && !--alarm6 && !--alarm6 && (script_ref_call(on_alrm6) || !instance_exists(self));
#macro  alarm7_run                                                                              alarm7 && !--alarm7 && !--alarm7 && (script_ref_call(on_alrm7) || !instance_exists(self));
#macro  alarm8_run                                                                              alarm8 && !--alarm8 && !--alarm8 && (script_ref_call(on_alrm8) || !instance_exists(self));
#macro  alarm9_run                                                                              alarm9 && !--alarm9 && !--alarm9 && (script_ref_call(on_alrm9) || !instance_exists(self));
#macro  instance_max                                                                            instance_create(0, 0, DramaCamera);
#macro  bbox_center_x                       													(bbox_left + bbox_right + 1) / 2;
#macro  bbox_center_y                       													(bbox_top + bbox_bottom + 1) / 2;
#define orandom(_num)                                                                   		return  random_range(-_num, _num);
#define nothing
#define chance(_numer, _denom)                                                      			return  random(_denom) < _numer;	
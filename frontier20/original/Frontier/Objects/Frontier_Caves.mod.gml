#define init

	 // LIB:
	while(!mod_exists("mod", "lib")){wait(1);}
	script_ref_call(["mod", "lib", "getRef"], "mod", mod_current, "scr");
	#macro  scr			global.scr
	#macro  call		script_ref_call

		// SETTINGS //
	global.settingLowQualityParrots			= false; // reduced visual quality of parrots
	global.settingTradeFishMode				= "OFF";

		// SOUNDS //
	global.sndWhaleHurt						= sound_add("../sounds/enemies/cove/sndWhaleHurt.ogg");	
	global.sndWhaleDead						= sound_add("../sounds/enemies/cove/sndWhaleDead.ogg");	
	global.sndEliteWhaleHurt				= sound_add("../sounds/enemies/cove/sndEliteWhaleHurt.ogg");	
	global.sndEliteWhaleDead				= sound_add("../sounds/enemies/cove/sndEliteWhaleDead.ogg");	
	global.sndStarfishHurt					= sound_add("../sounds/enemies/cove/sndStarfishHurt.ogg");	
	global.sndStarfishDead					= sound_add("../sounds/enemies/cove/sndStarfishDead.ogg");
	global.sndStarfishSing					= sound_add("../sounds/enemies/cove/sndStarfishSing.ogg"); 
	global.sndGunParrotHurt					= sound_add("../sounds/enemies/cove/sndGunParrotHurt.ogg");	
	global.sndGunParrotDead					= sound_add("../sounds/enemies/cove/sndGunParrotDead.ogg");
	global.sndSwordParrotHurt				= sound_add("../sounds/enemies/cove/sndSwordParrotHurt.ogg");	
	global.sndSwordParrotDead				= sound_add("../sounds/enemies/cove/sndSwordParrotDead.ogg");		 
	 
		// SPRITES //
	 // Spike Traps:
	global.sprSpikeTrapIdle					= sprite_add("../sprites/areas/caves/sprSpikeTrapIdle.png", 					1, 0, 0);
	global.sprSpikeTrapSpiking				= sprite_add("../sprites/areas/caves/sprSpikeTrapSpiking.png",					14, 0, 32);
	global.sprSpikeTrapGameover				= sprite_add("../sprites/areas/caves/sprSpikeTrapSpiking.png",					14, 16, 44);
	global.sprSpikeTrapCursedIdle			= sprite_add("../sprites/areas/caves/sprSpikeTrapCursedIdle.png",				1, 0, 0);
	global.sprSpikeTrapCursedSpiking		= sprite_add("../sprites/areas/caves/sprSpikeTrapCursedSpiking.png",			14, 0, 32);
	global.sprSpikeTrapCursedGameover		= sprite_add("../sprites/areas/caves/sprSpikeTrapCursedSpiking.png",			14, 16, 44);
	global.mskSpikeTrap						= sprite_add("../sprites/areas/caves/mskSpikeTrap.png", 						1, 0, 0);
	
	 // Descending Spiders:
	global.sprSpiderDescend					= sprite_add("../sprites/areas/caves/sprSpiderDescend.png", 					1, 11, 22);
	global.sprInvSpiderDescend				= sprite_add("../sprites/areas/caves/sprInvSpiderDescend.png", 					1, 11, 22);
	global.sprSpiderDescendingWeb			= sprite_add("../sprites/areas/caves/sprSpiderDescendWeb.png", 					1, 2, 0);
	global.sprSpiderDescendingWebEnd		= sprite_add("../sprites/areas/caves/sprSpiderDescendWebEnd.png", 				1, 1, 2);
	global.sprSpiderDescendingWebStart		= sprite_add("../sprites/areas/caves/sprSpiderDescendWebStart.png", 			1, 0, 12);

	 // Ourple Hyper Crystal:
	global.sprInvHyperCrystalIdle			= sprite_add("../sprites/enemies/invhypercrystal/sprInvHyperCrystalIdle.png",	6, 48, 64);	 
	global.sprInvHyperCrystalHurt			= sprite_add("../sprites/enemies/invhypercrystal/sprInvHyperCrystalHurt.png",	3, 48, 64);	 
	global.sprInvHyperCrystalDead			= sprite_add("../sprites/enemies/invhypercrystal/sprInvHyperCrystalDead.png",	23, 48, 64);

	 // Lightning Hyper Crystal:
	global.sprLightningHyperCrystalIdle		= sprite_add("../sprites/enemies/lightninghypercrystal/sprLightningHyperCrystalIdle.png",	6, 48, 64);	 
	global.sprLightningHyperCrystalHurt		= sprite_add("../sprites/enemies/lightninghypercrystal/sprLightningHyperCrystalHurt.png",	3, 48, 64);	 
	global.sprLightningHyperCrystalDead		= sprite_add("../sprites/enemies/lightninghypercrystal/sprLightningHyperCrystalDead.png",	23, 48, 64);
	
	 // Greennnn hyper crystal...
	global.sprCoveHyperCrystalIdle			= sprite_add("../sprites/enemies/Covehypercrystal/sprCoveHyperCrystalIdle.png",	6, 48, 64);	 
	global.sprCoveHyperCrystalHurt			= sprite_add("../sprites/enemies/Covehypercrystal/sprCoveHyperCrystalHurt.png",	3, 48, 64);	 
	global.sprCoveHyperCrystalDead			= sprite_add("../sprites/enemies/Covehypercrystal/sprCoveHyperCrystalDead.png",	23, 48, 64);
	
	 // Spread Curse:
	global.sprWall104TopSpread				= sprite_add("../sprites/areas/caves/sprWall104TopSpread.png", 					2, 24, 24);
	global.sprWall104TransSpread			= sprite_add("../sprites/areas/caves/sprWall104TransSpread.png", 				4, 24, 24);
	global.sprSnowFloor104					= sprite_add("../sprites/areas/caves/sprSnowFloor104.png", 						2, 16, 16);
	
	 // Cove Entrance:
	global.sprCoveEntranceDebris			= sprite_add("../sprites/areas/caves/sprCoveEntranceDebris.png",				3, 8, 8);	
	global.sprCoveEntranceClosed			= sprite_add("../sprites/areas/caves/sprCoveEntranceClosed.png",				1, 24, 24);	
	global.sprCoveEntranceOpen				= sprite_add("../sprites/areas/caves/sprCoveEntranceOpen.png",					1, 24, 24);	
	global.sprInvCoveEntranceClosed			= sprite_add("../sprites/areas/caves/sprInvCoveEntranceClosed.png",				1, 24, 24);	
	global.sprInvCoveEntranceOpen			= sprite_add("../sprites/areas/caves/sprInvCoveEntranceOpen.png",				1, 24, 24);	
	global.sprScrapyardCoveEntranceClosed	= sprite_add("../sprites/areas/scrapyard/sprScrapyardCoveEntranceClosed.png",	1, 24, 24);	
	global.sprScrapyardCoveEntranceOpen		= sprite_add("../sprites/areas/scrapyard/sprScrapyardCoveEntranceOpen.png",		1, 24, 24);	
	
	 // Whale Sprites:
	global.sprWhaleIdle						= sprite_add("../sprites/enemies/whale/sprWhaleIdle.png",						11, 24, 24);
	global.sprWhaleWalk						= sprite_add("../sprites/enemies/whale/sprWhaleWalk.png",						6, 24, 24);
	global.sprWhaleHurt						= sprite_add("../sprites/enemies/whale/sprWhaleHurt.png",						3, 24, 24);
	global.sprWhaleDead						= sprite_add("../sprites/enemies/whale/sprWhaleDead.png",						11, 32, 32);
	global.sprWhaleWeap						= sprite_add("../sprites/enemies/whale/sprWhaleWeap.png",						1, 10, 4);
	
	 // Elite Whale Sprites:
	global.sprEliteWhaleIdle				= sprite_add("../sprites/enemies/moby/sprEliteWhaleIdle.png",					11, 24, 24);
	global.sprEliteWhaleWalk				= sprite_add("../sprites/enemies/moby/sprEliteWhaleWalk.png",					6, 24, 24);
	global.sprEliteWhaleHurt				= sprite_add("../sprites/enemies/moby/sprEliteWhaleHurt.png",					3, 24, 24);
	global.sprEliteWhaleDead				= sprite_add("../sprites/enemies/moby/sprEliteWhaleDead.png",					11, 32, 32);
	global.sprEliteWhaleWeap				= sprite_add("../sprites/enemies/moby/sprEliteWhaleWeap.png",					1, 11, 0);
	
	 // Parrot Sprites:
	global.sprParrotTopLayerIdle[1]			= sprite_add("../sprites/enemies/parrot/sprParrotTopLayerIdle1.png",			4, 12, 12);
	global.sprParrotTopLayerIdle[2]			= sprite_add("../sprites/enemies/parrot/sprParrotTopLayerIdle2.png",			4, 12, 12);
	global.sprParrotTopLayerIdle[3]			= sprite_add("../sprites/enemies/parrot/sprParrotTopLayerIdle3.png",			4, 12, 12);
	global.sprParrotTopLayerIdle[4]			= sprite_add("../sprites/enemies/parrot/sprParrotTopLayerIdle4.png",			4, 12, 12);
	global.sprParrotMiddleLayerIdle			= sprite_add("../sprites/enemies/parrot/sprParrotMiddleLayerIdle.png", 			4, 12, 12);
	global.sprParrotBaseLayerIdle			= sprite_add("../sprites/enemies/parrot/sprParrotBaseLayerIdle.png",			4, 12, 12);
	global.sprParrotTopLayerWalk[1]			= sprite_add("../sprites/enemies/parrot/sprParrotTopLayerWalk1.png",			6, 12, 12);
	global.sprParrotTopLayerWalk[2]			= sprite_add("../sprites/enemies/parrot/sprParrotTopLayerWalk2.png",			6, 12, 12);
	global.sprParrotTopLayerWalk[3]			= sprite_add("../sprites/enemies/parrot/sprParrotTopLayerWalk3.png",			6, 12, 12);
	global.sprParrotTopLayerWalk[4]			= sprite_add("../sprites/enemies/parrot/sprParrotTopLayerWalk4.png",			6, 12, 12);
	global.sprParrotMiddleLayerWalk			= sprite_add("../sprites/enemies/parrot/sprParrotMiddleLayerWalk.png", 			6, 12, 12);	
	global.sprParrotBaseLayerWalk			= sprite_add("../sprites/enemies/parrot/sprParrotBaseLayerWalk.png",			6, 12, 12);	
	global.sprParrotTopLayerHurt[1]			= sprite_add("../sprites/enemies/parrot/sprParrotTopLayerHurt1.png",			3, 12, 12);
	global.sprParrotTopLayerHurt[2]			= sprite_add("../sprites/enemies/parrot/sprParrotTopLayerHurt2.png",			3, 12, 12);
	global.sprParrotTopLayerHurt[3]			= sprite_add("../sprites/enemies/parrot/sprParrotTopLayerHurt3.png",			3, 12, 12);
	global.sprParrotTopLayerHurt[4]			= sprite_add("../sprites/enemies/parrot/sprParrotTopLayerHurt4.png",			3, 12, 12);
	global.sprParrotMiddleLayerHurt			= sprite_add("../sprites/enemies/parrot/sprParrotMiddleLayerHurt.png", 			3, 12, 12);
	global.sprParrotBaseLayerHurt			= sprite_add("../sprites/enemies/parrot/sprParrotBaseLayerHurt.png",			3, 12, 12);
	global.sprParrotDead					= sprite_add("../sprites/enemies/parrot/sprParrotDead.png",						6, 12, 12);
	global.sprParrotGameover				= sprite_add("../sprites/enemies/parrot/sprParrotGameover.png",					4, 12, 12);
	global.sprParrotFeather					= sprite_add("../sprites/enemies/parrot/sprParrotFeather.png", 					1, 4, 4);
	global.sprParrotWeapCutlass				= sprite_add("../sprites/enemies/parrot/sprParrotWeapCutlass.png", 				1, 3, 0);
	global.sprParrotWeapFlintlock			= sprite_add("../sprites/enemies/parrot/sprParrotWeapFlintlock.png",			1, 0, 1);
	global.sprParrotLQIdle					= sprite_add("../sprites/enemies/parrot/sprParrotLQIdle.png",					4, 12, 12);	
	global.sprParrotLQWalk					= sprite_add("../sprites/enemies/parrot/sprParrotLQWalk.png",					6, 12, 12);	
	global.sprParrotLQHurt					= sprite_add("../sprites/enemies/parrot/sprParrotLQHurt.png",					3, 12, 12);	
	
	 // Starfish Sprites:
	global.shdStarfish						= sprite_add("../sprites/enemies/starfish/shdStarfish.png",						1, 16, 16);
	global.sprStarfishIdle					= sprite_add("../sprites/enemies/starfish/sprStarfishIdle.png",					1, 16, 16);
	global.sprStarfishWalk					= sprite_add("../sprites/enemies/starfish/sprStarfishWalk.png",					6, 16, 16);
	global.sprStarfishHurt					= sprite_add("../sprites/enemies/starfish/sprStarfishHurt.png",					3, 16, 16);
	global.sprStarfishDead					= sprite_add("../sprites/enemies/starfish/sprStarfishDead.png",					5, 16, 16);
	global.sprStarfishTell					= sprite_add("../sprites/enemies/starfish/sprStarfishTell.png",					4, 16, 16);
	global.sprStarfishChrg					= sprite_add("../sprites/enemies/starfish/sprStarfishChrg.png",					2, 16, 16);
	
	 // Elite Starfish Sprites:
	global.sprEliteStarfishIdle				= sprite_add("../sprites/enemies/elitestarfish/sprEliteStarfishIdle.png",		1, 16, 16);
	global.sprEliteStarfishWalk				= sprite_add("../sprites/enemies/elitestarfish/sprEliteStarfishWalk.png",		6, 16, 16);
	global.sprEliteStarfishHurt				= sprite_add("../sprites/enemies/elitestarfish/sprEliteStarfishHurt.png",		3, 16, 16);
	global.sprEliteStarfishDead				= sprite_add("../sprites/enemies/elitestarfish/sprEliteStarfishDead.png",		5, 16, 16);
	global.sprEliteStarfishTell				= sprite_add("../sprites/enemies/elitestarfish/sprEliteStarfishTell.png",		4, 16, 16);
	global.sprEliteStarfishChrg				= sprite_add("../sprites/enemies/elitestarfish/sprEliteStarfishChrg.png",		2, 16, 16);
	global.sprEliteStarfishChrgLight		= sprite_add("../sprites/enemies/elitestarfish/sprEliteStarfishChrgLight.png", 	2, 16, 16);
	
	 // Singin Starfish Sprites:
	global.sprStarfishSingIdle				= sprite_add("../sprites/enemies/singfish/sprStarfishSingIdle.png",				5, 16, 16);
	global.sprStarfishSingWalk				= sprite_add("../sprites/enemies/singfish/sprStarfishSingWalk.png",				6, 16, 16);
	global.sprStarfishSingHurt				= sprite_add("../sprites/enemies/singfish/sprStarfishSingHurt.png",				3, 16, 16);
	global.sprStarfishSingDead				= sprite_add("../sprites/enemies/singfish/sprStarfishSingDead.png",				5, 16, 16);
	global.sprMusicNote						= sprite_add("../sprites/particles/sprMusicNote.png",							5, 8, 8);
	
	 // Falling Rock:
	global.sprFallingRockWarning			= sprite_add("../sprites/projectiles/sprFallingRockWarning.png",				1, 16, 16);
	
	 // Tradefish							
	global.sprTradefish						= sprite_add("../sprites/particles/sprTradeFish.png",							4, 5, 4);
	global.sprTradefishTrail				= sprite_add("../sprites/particles/sprTradeFishTrail.png",						3, 1, 1);
	
	 // Geen:
	global.sprCoveLaserCrystalIdle			= sprite_add("../sprites/enemies/covelasercrystal/sprCoveLaserCrystalIdle.png",	5, 24, 24);
	global.sprCoveLaserCrystalHurt			= sprite_add("../sprites/enemies/covelasercrystal/sprCoveLaserCrystalHurt.png",	3, 24, 24);
	global.sprCoveLaserCrystalDead			= sprite_add("../sprites/enemies/covelasercrystal/sprCoveLaserCrystalDead.png",	10, 24, 24);
	global.sprCoveHyperCrystalIdle			= sprite_add("../sprites/enemies/coveHypercrystal/sprCoveHyperCrystalIdle.png",	6, 48, 64);
	global.sprCoveHyperCrystalHurt			= sprite_add("../sprites/enemies/coveHypercrystal/sprCoveHyperCrystalHurt.png",	3, 48, 64);
	global.sprCoveHyperCrystalDead			= sprite_add("../sprites/enemies/coveHypercrystal/sprCoveHyperCrystalDead.png",	23, 48, 64);
	
	 // Projectiles / Effects:
	global.sprWhiteSmoke					= sprite_add("../sprites/particles/sprWhiteSmoke.png",							5, 12, 12);
    global.mskCannonball 	    			= sprite_add("../sprites/projectiles/mskCannonball.png",						1, 10, 10);
    global.sprCannonball 	    			= sprite_add("../sprites/projectiles/sprCannonball.png",						1, 10, 10);
    global.sprCannonballTrail 				= sprite_add("../sprites/particles/sprCannonballTrail.png",						2, 4, 4);
    global.sprMortarBarrel 	    			= sprite_add("../sprites/projectiles/sprGunpowderBarrel.png",					1, 16, 16);
    global.sprMortarBarrelDebris 	    	= sprite_add("../sprites/particles/sprGunpowderBarrelDebris.png",				3, 4, 4);
    global.sprEnemyStreak 	    			= sprite_add("../sprites/particles/sprEnemyStreak.png",							7, 8, 8);

//#region OBJECTS
#define TradeFishController_create(_x, _y)
	with(instance_create(_x, _y, CustomObject)){
		name = "fr_tradeFishController"
		
		myNumber	= irandom(100000); // for weps that get sucked in portals
		tradedWeps	= call(scr.save_get, "Frontier", "pirate_conversions");
		
		on_step = TradeFishController_step;
		
		return self;
	}
	
#define TradeFishController_step
	with(instances_matching_ne(WepPickup, "fr_tradefishcheck", myNumber)){
		fr_tradefishcheck = other.myNumber;
		
		if(global.settingTradeFishMode = "NEW"){
			
			var _inputIndex = ds_list_find_index(mod_variable_get("area", "cove", "pirateInput"), wep)
			if(_inputIndex != -1){
				var _output = ds_list_find_value(mod_variable_get("area", "cove", "pirateOutput"), _inputIndex);
				if(array_find_index(other.tradedWeps, _output) = -1){
					TradeFish_create(x, y, self);
				}
			}
			
			 // weapon_exchange_pirate check
			if(is_string(wep) && mod_script_exists("weapon", wep, "wep_exchange_pirate")){
				if(array_find_index(other.tradedWeps, mod_script_call("weapon", wep, "wep_exchange_pirate")) = -1){
					TradeFish_create(x, y, self);
				}
			}
		}
		
		if(global.settingTradeFishMode = "ALL"){
			var _inputIndex = ds_list_find_index(mod_variable_get("area", "cove", "pirateInput"), wep)
			if(_inputIndex != -1){
				TradeFish_create(x, y, self);
			}
			
			 // weapon_exchange_pirate check
			if(is_string(wep) && mod_script_exists("weapon", wep, "wep_exchange_pirate")){			
				TradeFish_create(x, y, self);
			}
			
		}
	}

#define TradeFish_create(_x, _y, _weppickup)
	with(instance_create(_x, _y, CustomObject)){
		name = "fr_TradeFish";
		
		sprite_index	= global.sprTradefish;
		image_angle		= 270;
		image_speed		= 0.3;
		fr_bloom		= [1.5, 0.1];
		image_alpha		= 0.5;
		
		dist			= 8;
		orbitSpeed		= 3;
		rotSpeed		= 3;
		angle			= 0;
		owner		= _weppickup;
		
		on_end_step = TradeFish_endstep;
		
		return self;
	}
	
#define TradeFish_endstep
	if(!instance_exists(owner) || owner.visible = false){
		instance_destroy();
		exit;
	}
	
	if(current_frame_active){
		if(random(10) < 1){
			with(instance_create(x, y, BulletHit)){
				sprite_index	= global.sprTradefishTrail;
				image_alpha		= 0.3;
				speed			= 1.4;
				direction		= random(360);
			}
		}
	}
	
	angle		+= orbitSpeed * current_time_scale;
	image_angle += (rotSpeed * current_time_scale);
	
	xprevious	= owner.x + lengthdir_x(dist, angle);
	yprevious	= owner.y + lengthdir_y(dist, angle);
	x 			= owner.x + lengthdir_x(dist, angle);
	y 			= owner.y + lengthdir_y(dist, angle);
	
#define SpikeTrap_create(_x, _y, _cursed)
	with(instance_create(_x, _y, CustomObject)){
		
		name = "fr_SpikeTrap";
		
		 // Visuals:
		spr_idle		= global.sprSpikeTrapIdle;
		spr_spiking		= global.sprSpikeTrapSpiking;
		spr_gameover	= global.sprSpikeTrapGameover;
		if(_cursed){
			spr_idle		= global.sprSpikeTrapCursedIdle;
			spr_spiking 	= global.sprSpikeTrapCursedSpiking;
			spr_gameover	= global.sprSpikeTrapCursedGameover;
		}
		
		sprite_index	= spr_idle;
		image_speed		= 0.4;
		depth			= 5;
		
		 // Vars:
		canspike		= true;
		spiking			= false;
		cursed			= false;
		
		 // Events:
		on_step			= SpikeTrap_step;
		
		return self;
	}

#define SpikeTrap_step

	var me = self;

		if (sprite_index = spr_spiking) && (anim_end){
			sprite_index = spr_idle;
			spiking		 = false;
		}
		
	if (place_meeting(x, y, Player)) && (spiking = false) && (canspike = true) {
		
		canspike = false;
		
		// Activate Trap:
		spiking = true;
		sprite_index = spr_spiking;
		sound_play_pitchvol(sndCrystalShield,1.6 + random(0.3),0.3)
		wait(18);
		if(!instance_exists(self)){ exit; }
		
			// Spiky Hitbox:
			with instance_create(x, y, CustomProjectile){ 
				
				sound_play_pitchvol(sndCrystalJuggernaut, 1.6 + random(0.3), 0.5)
				sound_play_pitch(sndChickenSword, 1.4 + random(0.3))
				sound_play_pitchvol(sndCrystalShield, 1.3 + random(0.3), 1.3)

				
				sprite_index	= mskNone;
				mask_index		= global.mskSpikeTrap;
				lifetime		= 10;
				hitlist			= [];
				damage			= 2;
				hitid			= [other.spr_gameover,"SPIKE TRAP"]
				speed			= 0;
				team			= 1;
				
				on_step			= SpikeHitbox_step;
				on_hit			= SpikeHitbox_hit;
				on_wall			= nothing;
			
			}
	}
	
	// Clean me Up:
	var bigmessy = call(scr.instances_meeting, x, y, Corpse);
	with (bigmessy){
		if(place_meeting(x, y, other)){ 
			motion_add(point_direction(other.x, other.y, x, y) + random_range(-30, 30), 0.7) 
		}
	}
	
	// Go Again?
	if (!place_meeting(x, y, Player)){
		canspike = true;
	}
	
#define SpikeHitbox_step
	lifetime -= current_time_scale;
	if (lifetime <= 0) { 
		instance_destroy();
	}

#define SpikeHitbox_hit
	if array_find_index(hitlist, other) == -1 {
		array_push(hitlist, other)
		with(other){
			projectile_hit(self, other.damage)
			lasthit	= other.hitid;
		}
	}
	
#define CoveEntrance_create(_x, _y, _curse)

	with(instance_create(_x, _y, CustomObject)){
		
		name = "fr_CoveEntrance";
		
		 // Visual:
		spr_idle		= _curse ? global.sprInvCoveEntranceClosed : global.sprCoveEntranceClosed;
		spr_open		= _curse ? global.sprInvCoveEntranceOpen : global.sprCoveEntranceOpen;
		spr_debris		= global.sprCoveEntranceDebris;
		sprite_index	= spr_idle;
		image_speed 	= 0.4;
		depth			= 5;
		
		 // Vars:
		open			= false;
		opened			= false;
		bossType		= HyperCrystal;
		portalPusher	= mod_script_call("mod", "Frontier_Objects", "PortalPusher_create", x, y, 72);
		 
		 // Hello:
		on_step 		= script_ref_create(CoveEntrance_step);
		
		return self;
	}
	
#define CoveEntrance_step
	x = xstart;
	y = ystart;
	speed = 0;
	
	if(!instance_exists(chestprop) && !instance_exists(RadChest) && !instance_exists(HyperCrystal) && !instance_exists(bossType) && !instance_exists(BecomeScrapBoss) && open = false){
		open			= true;
		sprite_index	= spr_open;
		sound_play_pitch(sndWallBreakJungle, 1.3)
		instance_create(x, y, PortalClear)
		repeat(12){
			with(instance_create(x, y, Dust)){
				direction		= random(360);
				speed			= 1 + random(2);
			}
		}
		repeat(6){
			with instance_create(x, y, Debris){
				sprite_index	= other.spr_debris;
				direction		= random(360);
				speed			= 3 + random(2);
			}
		}
	}
	if(place_meeting(x, y, Player) && opened = false && open = true){
		opened = true;
		
		with(GameCont){
			area		= "cove"
			subarea 	= 0;
			killenemies = false;
		}
		
		with(portalPusher){
			instance_destroy();
		}
		
		 // Portal!
		with instance_create(x, y, Portal){
			image_alpha 	= 0;
		}		
	}

	// Clean me Up:
	var bigmessy = call(scr.instances_meeting, x, y, Debris);
	with(bigmessy){
		if (place_meeting(x, y, other)){ motion_add(point_direction(other.x, other.y, x, y) + random_range(-30, 30), 0.7) }
	}
	
#define ScrapyardCoveEntrance_create(_x, _y)
	with(CoveEntrance_create(_x, _y, false)){
		bossType		= ScrapBoss;
		spr_idle		= global.sprScrapyardCoveEntranceClosed;
		spr_open		= global.sprScrapyardCoveEntranceOpen;
		sprite_index	= spr_idle;
		
		return self;
	}
	
#define SpiderTrap_create(_x, _y, _curse)
	with(instance_create(_x, _y, CustomObject)){
		name = "fr_SpiderTrap";
		
		 // Visuals:
		spr_spider		= (_curse ? global.sprInvSpiderDescend : global.sprSpiderDescend);
		depth			= -10;
		
		 // Vars:
		curse			= _curse;
		z				= 200;
		z_start			= z;
		z_friction		= 0;
		mySpider		= noone; //CoolSpider_create(x, y - z_start, _curse);
		droppingSpider	= false;
		droppedSpider	= false;
		spiderSpawned	= false;
		sinOffset		= irandom(30);
		myCoolSine		= 0;
		manualActivate	= false;
		
		on_step 		= CrystalSpiderDescend_step;
		on_draw			= CrystalSpiderDescend_draw;
		
		return self;
	}
	
#define CoolSpider_create(_x, _y, _curse)
	with(instance_create(_x, _y, (_curse ? InvSpider : Spider))){
		mask_index	= mskNone;
		spr_shadow	= mskNone;
		canfly		= true;
		depth		= -11;

		return self;
	}
	
#define CrystalSpiderDescend_step
	myCoolSine		= 0.2 + sin((current_frame + sinOffset) * 0.06) * 0.15;
	
	if((distance_to_object(Player)) < 6 || manualActivate = true) && (spiderSpawned = false){
		sound_play_pitchvol(sndSpiderMelee, 1.1 + random(0.1), 0.6)
		spiderSpawned	= true;
		droppingSpider	= true;
		mySpider		= CoolSpider_create(x, y - z_start, curse);
	}

	if(spiderSpawned = true){
		if(droppingSpider = true){
			if(z > 0){
				z -= clamp(8 - z_friction, 3, 8) * current_time_scale;
			}
			z_friction += (0.10 + (z_friction / 50)) * current_time_scale;
			with(mySpider){
				x				= other.x;
				y				= other.y - other.z;
				sprite_index	= other.spr_spider;
				speed			= 0;
				right			= 1;
			}
			if(z <= 20){
				with(mySpider){
					canfly		= false;
					mask_index	= mskSpider;
				}		
			}
			if(z <= 0){
				with(mySpider){
					spr_shadow	= shd24;
					depth		= -2;
					repeat(8){
						with(instance_create(x, y, Dust)){
							depth		= other.depth - 1;
							direction	= 270 + random_range(-90, 90)
							speed		= 2 + random(1);
						}
					}
				}
				mySpider		= noone;
				droppingSpider	= false;
				droppedSpider	= true;
				z_friction		= 0;
				sound_play_pitchvol(sndCocoonBreak, 1.4 + random(0.2), 0.4);
			}
		} else {
			if(z <= z_start){
				z += 16 * current_time_scale;
				image_alpha -= 0.05 * current_time_scale
			} else {
				instance_destroy();
			}
		}
	}
	
#define CrystalSpiderDescend_draw
	if(droppedSpider = false){
		draw_sprite_ext(shd24, 0, x, y, clamp(((z_start / z) / 4) + myCoolSine, 0.3, 1), 1, 0, c_white, clamp(((z_start / z) / 4) + myCoolSine / 2, 0.05, 0.4))		
	}
	if(spiderSpawned = true){
		draw_set_alpha(image_alpha);
		draw_sprite(global.sprSpiderDescendingWebStart, 0, x, y - z_start)
		draw_sprite_stretched(global.sprSpiderDescendingWeb, 0, x, y - z_start, 3, z_start - z)
		draw_sprite(global.sprSpiderDescendingWebEnd, 0, x, y - z)
		draw_set_alpha(1);
	}

#define HyperCrystalOurpler_create(_x, _y)
	with(instance_create(_x, _y, CustomObject)){
		name	= "fr_hypercrystalOurper"
		
		on_step = HyperCrystalOurpler_step;
		
		return self;
	}
	
#define HyperCrystalOurpler_step
	with(instances_matching(HyperCrystal, "spr_idle", sprHyperCrystalIdle)){
		spr_idle	= global.sprInvHyperCrystalIdle;
		spr_walk	= global.sprInvHyperCrystalIdle;
		spr_hurt	= global.sprInvHyperCrystalHurt;
		spr_dead	= global.sprInvHyperCrystalDead;
	} 
	with(HyperCrystal){
		if(alarm3 = 1){
			intro = true;
			with(mod_script_call("mod", "Frontier_Bosses", "boss_intro", "OurpleCursedHyperCrystal")){ 				
				loops = GameCont.loops; 			
			}
			alarm3 = 0;		
		}
	}
	
#define LightningHyperCrystalController_create(_x, _y, _crystal)
	with(instance_create(_x, _y, CustomObject)){
		name		= "fr_lightningHyperController"
		myCrystal	= _crystal;
		with(_crystal){
			spr_idle	= global.sprLightningHyperCrystalIdle;
			spr_walk	= global.sprLightningHyperCrystalIdle;
			spr_hurt	= global.sprLightningHyperCrystalHurt;
			spr_dead	= global.sprLightningHyperCrystalDead;		
			raddrop		= round(raddrop * 1.14);
		}
		on_step 	= LightningHyperCrystalController_step;
		
		return self;
	}

#define LightningHyperCrystalController_step
	with(myCrystal){
		if(alarm3 = 1){
			intro = true;
			with(mod_script_call("mod", "Frontier_Bosses", "boss_intro", "LightningHyperCrystal")){ 				
				loops = GameCont.loops; 			
			}
			alarm3 = 0;
		}
		var _crystalArray = crystal
		with(crystal){
			if(instance_is(self, LaserCrystal)){
				instance_change(LightningCrystal, false)
				spr_idle	= sprLightningCrystalIdle;
				spr_walk	= sprLightningCrystalIdle;
				spr_hurt	= sprLightningCrystalHurt;
				spr_dead	= sprLightningCrystalDead;
				spr_fire	= sprLightningCrystalFire;
				raddrop		= round(raddrop * 1.14);
			}
		}
	}
	
#define CoveHyperCrystal_create(_x, _y)
	with(instance_create(_x, _y, HyperCrystal)){
		spr_idle	= global.sprCoveHyperCrystalIdle;
		spr_walk	= global.sprCoveHyperCrystalIdle;
		spr_hurt	= global.sprCoveHyperCrystalHurt;
		spr_dead	= global.sprCoveHyperCrystalDead;
		
		hitid		= [spr_idle, "HYPER CRYSTAL"];
		
		sprite_index	= spr_idle;
		
		CoveHyperCrystalController_create(_x, _y, self);
		
		return self;
	}
	
#define CoveHyperCrystalController_create(_x, _y, _crystal)
	with(instance_create(_x, _y, CustomObject)){
		name		= "fr_coveHyperController"
		myCrystal	= _crystal;

		on_step 	= CoveHyperCrystalController_step;
		
		return self;
	}

#define CoveHyperCrystalController_step
	with(myCrystal){
		if(alarm3 = 1){
			intro = true;
			with(mod_script_call("mod", "Frontier_Bosses", "boss_intro", "CoveHyperCrystal")){ 				
				loops = GameCont.loops; 			
			}
			alarm3 = 0;
		}
		var _crystalArray = crystal
		with(crystal){
			if(instance_exists(self) && ("fr_ahoyed" not in self)){
				fr_ahoyed	= true;
				spr_idle	= global.sprCoveLaserCrystalIdle;
				spr_walk	= global.sprCoveLaserCrystalIdle;
				spr_hurt	= global.sprCoveLaserCrystalHurt;
				spr_dead	= global.sprCoveLaserCrystalDead;
				hitid		= [spr_idle, "LASER CRYSTAL"];
			}
		}
	}
	
#define CurseCaveSpreader_create(_x, _y)
	with instance_create(_x, _y, CustomObject){
	//	instance_create(x, y, Torch)
		name = "fr_CurseCaveSpreader"
		
		curseRange	= 32 + (8 * irandom(5));
		on_step 	= CurseCaveSpreader_step;
		
		if(array_length(instances_matching(CustomObject, "name", "fr_cursecavedraws")) = 0){
			CurseCaveDraws_create(10016, 10016);
    	}
		
		return self;
	}
	
#define CurseCaveSpreader_step

	with(Spider){
		if(distance_to_object(other) < other.curseRange){
			instance_create(x, y, InvSpider);
			instance_delete(self);
		}
	}
	
	with(LaserCrystal){
		if(distance_to_object(other) < other.curseRange){
			instance_create(x, y, InvLaserCrystal);
			instance_delete(self);
		}
	}
	
	with(Floor){
		if(distance_to_object(other) < other.curseRange){
			if(sprite_index	= sprFloor4 || sprite_index = sprFloor4B){
			var _sprite = (styleb = true) ? sprFloor104B : sprFloor104;
				sprite_index	= _sprite;
				depth			-= 2;
				with(instance_create(x + irandom_range(-1, 1), y - irandom_range(2, 3), SnowFloor)){
					sprite_index	= global.sprSnowFloor104;
					image_speed		= other.image_speed;
					image_index		= irandom(7);
					image_angle	   += random_range(-1, 1)
					depth			= other.depth + 1;
				}
			}
		}
	}

	with(FloorExplo){
		if(distance_to_object(other) < other.curseRange){
			if(sprite_index	= sprFloor4Explo){
				sprite_index	= sprFloor104Explo;
			}
		}
	}
	
	with(Wall){
		if(distance_to_object(other) < (other.curseRange + 8)){
			if(sprite_index	= sprWall4Bot){
				sprite_index	= sprWall104Bot;
				topspr			= sprWall104Top;
				outspr			= sprWall104Out;
				image_index		= irandom(image_number);
				fr_topSmallCurse = null;
			}
		}
		if(distance_to_object(other) < (other.curseRange + 32) && distance_to_object(other) > (other.curseRange + 8)){
			if(sprite_index	= sprWall4Bot){
				if(distance_to_object(Bones) > 16 && distance_to_object(TopDecalCave) > 16){
					sprite_index	= sprWall104Bot;
					topspr			= sprWall104Top;
					outspr			= sprWall104Out;
					image_index		= irandom(image_number);
					fr_topSmallCurse= irandom(1);
				}
			}
		}
	}
	
	with(TopSmall){
		if(distance_to_object(other) < (other.curseRange + 32)){
			if(sprite_index	= sprWall4Trans){
				sprite_index		= sprWall104Trans;
				image_index			= irandom(image_number);
				fr_topSmallCurse	= irandom(3);
				fr_topSmallCurseRot	= choose(0, 90, 180, 270);
			}
		}
	}
	
	with(TopDecalCave){
		if(distance_to_object(other) < other.curseRange + 8){
			if(sprite_index	= sprTopDecalCave){
				sprite_index	= sprTopDecalInvCave;
			}
		}
	}
	
	with(Bones){
		if(distance_to_object(other) < other.curseRange + 8){
			if(sprite_index	= sprCaveDecal){
				sprite_index	= sprInvCaveDecal;
			}
		}
	}
	
	with(Detail){
		if(distance_to_object(other) < other.curseRange + 16){
			if(sprite_index	= sprDetail4){
				sprite_index	= sprDetail104;
				image_index		= irandom(image_number);
			}
		}
	}
	
	with(CrystalProp){
		if(distance_to_object(other) < other.curseRange){
			if(spr_idle = sprCrystalProp){
				instance_create(x, y, InvCrystal);
				instance_delete(self);
			}
		}
	}
	
	with(instances_matching(CustomObject, "name", "fr_CoveEntrance")){
		if(distance_to_object(other) < other.curseRange){
			spr_idle		= global.sprInvCoveEntranceClosed;
			spr_open		= global.sprInvCoveEntranceOpen;
			sprite_index	= spr_idle;
		}
	}
	
	with(instances_matching(CustomObject, "name", "fr_SpikeTrap")){
		if(distance_to_object(other) < other.curseRange){
			spr_idle		= global.sprSpikeTrapCursedIdle;
			spr_spiking 	= global.sprSpikeTrapCursedSpiking;
			spr_gameover	= global.sprSpikeTrapCursedGameover;
			sprite_index	= spr_idle;
		}
	}
	
	with(instances_matching(CustomObject, "name", "fr_SpiderTrap")){
		if(chance(1, 2)){
			SpiderTrap_create(x, y, true);
			instance_delete(self);
		}
	}
	
	if(mod_exists("mod", "ntte")){
		 // stop wallspread from clipping into topobject props:
		 // moved to event creation
		/*
		with(instances_matching_ne(prop, "top_object", null)){
			depth = -11;
		}
		*/
		
		with(instances_matching(Bones, "name", "NTTEBigDecal")){
			if(distance_to_object(other) < other.curseRange - 16){
				if(sprite_index = _tespr.BigTopDecal[? 4]){
					with(CurseCaveSpreader_create(x, y)){
						curseRange = 32;
					}
					sprite_index = _tespr.BigTopDecal[? 104];
				}
			}
		}
		
		with(instances_matching(CrystalProp, "spr_idle", _tespr.BigCrystalPropIdle)){
			if(distance_to_object(other) < other.curseRange){
				spr_idle = _tespr.InvBigCrystalPropIdle;
				spr_hurt = _tespr.InvBigCrystalPropHurt;
				spr_dead = _tespr.InvBigCrystalPropDead;
			}
		}
		
		with(instances_matching(CustomEnemy, "spr_idle", _tespr.MortarIdle)){
			if(distance_to_object(other) < other.curseRange){
				mod_script_call("mod", "telib", "obj_create", x, y, "InvMortar");
				instance_delete(self);
			}
		}
		
		with(instances_matching(CustomEnemy, "spr_idle", _tespr.CrystalBatIdle)){
			if(distance_to_object(other) < other.curseRange){
				mod_script_call("mod", "telib", "obj_create", x, y, "InvCrystalBat");
				instance_delete(self);
			}
		}
		
		// spiderlings dont inherit curse right so not doing them.
	}
	
	instance_destroy();
	
#define CurseCaveDraws_create(_x, _y)
	with(instance_create(_x, _y, CustomObject)){
		name = "fr_cursecavedraws";
		
		script_bind_draw(CurseCaveWallTransOut_draw, -6);
		script_bind_draw(CurseCaveWallTopOut_draw, -10);
		
		return self;
	}

#define CurseCaveWallTransOut_draw
	with(instances_matching_ne(TopSmall, "fr_topSmallCurse", null)){
		draw_sprite_ext(global.sprWall104TransSpread, fr_topSmallCurse, x + 8, y, 1, 1, fr_topSmallCurseRot, c_white, 1);
	}
	
#define CurseCaveWallTopOut_draw
	with(instances_matching_ne(Wall, "fr_topSmallCurse", null)){
		draw_sprite_ext(global.sprWall104TopSpread, fr_topSmallCurse, x + 8, y, 1, 1, 0, c_white, 1);
	}

//#endregion
//#region ENEMIES
//#region COVE ENEMIES
#define Whale_create(_x, _y)
	with instance_create(_x, _y, CustomEnemy){
   
    	name = "Whale";
    	
        // Visuals: 
        spr_idle		= global.sprWhaleIdle;
		spr_walk		= global.sprWhaleWalk;
		spr_hurt		= global.sprWhaleHurt; 
		spr_dead		= global.sprWhaleDead;
		spr_weap		= global.sprWhaleWeap;
		sprite_index    = spr_idle;
		image_speed     = 0.4;
		depth           = -2;
		hitid           = [spr_idle, "WHALE"]
        spr_shadow      = shd48;	
        spr_shadow_y	= 2;
        nts_color_blood = [c_red, make_color_rgb(134, 44, 35)]
        water_breathing = true;
        spr_bubble  	= -1;
        spr_bubble_pop	= -1;
        spr_bubble_x	= 0;
        spr_bubble_y	= 0;
        
        // Sounds:
        snd_hurt		= global.sndWhaleHurt;
        snd_dead		= global.sndWhaleDead;
        
        // Vars:
        mask_index  	= mskRhinoFreak;
        direction   	= random(360);
        maxhealth   	= 56;
       	my_health   	= maxhealth;
        raddrop     	= 17;
        maxspeed    	= 2;
        walkspeed   	= maxspeed;
        size			= 3;
        canmelee    	= 0;
        team        	= 1; 
        targetvisible	= 0;
        target      	= 0;
        walk        	= 0;
        gunangle    	= 180;
		wepangle    	= 110;
		fuseTime		= 0;
        
        // Alarms:
        alarm1 = 20 + irandom(30);
        alarm2 = 0;

        // Scripts:
        on_step  = script_ref_create(Whale_step);
        on_draw  = GunEnemy_draw;
        on_hurt  = Enemy_hurt;
        on_death = Whale_death;
        on_alrm1 = script_ref_create(Whale_alrm1);
        on_alrm2 = script_ref_create(Whale_alrm2);
        
        return self;
	}
	
#define Whale_step

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

#define Whale_alrm1
	alarm1 = 40 + irandom(30);

	if(enemy_target(x, y) && target_visible) {
		enemy_look(target_direction);
		
			// GET YOU:
		if(target_distance > 160){
			alarm1 = 30 + irandom(15);
			enemy_walk(target_direction + orandom(30), alarm1 - 10);
		}
			 // If in range:
		else{
			 // Attack:
			 // Not too close!
			if(chance(2, 3) && (target_distance > 32)){
				alarm1 = 100 + irandom(20);
    
    			 // Fuse:
    			alarm2 = 1;
    			fuseTime = 30;
			/*	with(instance_create(x, y, AssassinNotice)){
					depth = other.depth - 1;
				} */
    			sound_play_pitch(sndToxicBarrelGas, 1.2 + random(0.2))
			}
			
			 // Move Away From Target:
			else{
				alarm1 = 50 + irandom(15);
				enemy_walk(gunangle + 180 + orandom(30), alarm1 - 10);
			}
		}
	}
	
	 // Wander Around Town:
	else{
		enemy_walk(random(360), 30);
		enemy_look(direction);
	}

#define Whale_alrm2
	if(fuseTime > 0){
		alarm2 = 1;
		
		 // Smoke:
    	if(random(3) < 1){
		   	with instance_create(x + lengthdir_x(25, other.gunangle), y + lengthdir_y(25, other.gunangle), Smoke){
			   	image_xscale = 0.2 + random(0.3);
			   	image_yscale = image_xscale;
			   	motion_add(other.gunangle + other.right * 100, 1 + random(2));
		   	}
       	}
       	
       	 // Track Target:
	     if(instance_exists(target) && target_visible){
	    	gunangle = angle_lerp_ct(gunangle, target_direction, 0.12)
	     }
       	

		 // FIRE!
		if(--fuseTime <= 0){
			
    		 // Sound:
    		sound_play_pitch(sndGrenadeRifle, 0.6 + random(0.2));
    		sound_play_pitch(sndExplosion, 1.4 + random(0.2));
    			
    		 // Kick:
    		wkick = 12;
    
    		 // Projectile:
    		with Cannonball_create(x, y){
    			direction   	= other.gunangle;
    			image_angle 	= direction;
    			team        	= other.team;
    			creator 		= other;
   				hitid			= other.hitid;
      
    			 // Particles:
				repeat(12){
					with instance_create(x + lengthdir_x(10, other.gunangle), y + lengthdir_y(10, other.gunangle), Smoke){
						image_xscale    = 0.2 + random_range(0.1, 0.5);
						image_yscale    = image_xscale;
						motion_add(other.direction + random_range(-10, 10), 2 + random(2)) 
					}
				}
				repeat(6){
					with instance_create(x + lengthdir_x(16, other.gunangle), y + lengthdir_y(16, other.gunangle), BloodStreak){
			    		sprite_index    = global.sprEnemyStreak;
               			direction       = other.direction + random_range(-40, 40);
               			image_angle     = direction;
               			speed           = 3 + random(4);
						image_xscale    = 0.2 + random_range(0.1, 0.5);
						image_yscale    = image_xscale;
					}
				}
   			}
		}
	}

#define Whale_death
	pickup_drop(50, 20);
	
#define EliteWhale_create(_x, _y)
	with instance_create(_x, _y, CustomEnemy){
   
    	name = "Moby"
    	
        // Visuals: 
        spr_idle		= global.sprEliteWhaleIdle;
		spr_walk		= global.sprEliteWhaleWalk;
		spr_hurt		= global.sprEliteWhaleHurt; 
		spr_dead		= global.sprEliteWhaleDead;
		spr_weap		= global.sprEliteWhaleWeap;
		sprite_index    = spr_idle;
		image_speed     = 0.4;
		depth           = -2;
		hitid           = [spr_idle, "MOBY"]
        spr_shadow      = shd48;	
        spr_shadow_y	= 2;
        nts_color_blood = [c_red, make_color_rgb(134, 44, 35)]
        water_breathing = true;
        spr_bubble  	= -1;
        spr_bubble_pop	= -1;
        spr_bubble_x	= 0;
        spr_bubble_y	= 0;
        
        // Sounds:
        snd_hurt		= global.sndEliteWhaleHurt;
        snd_dead		= global.sndEliteWhaleDead;
        
        // Vars:
        mask_index  	= mskRhinoFreak;
        direction   	= random(360);
        maxhealth   	= 70;
       	my_health   	= maxhealth;
        raddrop     	= 24;
        maxspeed    	= 2;
        walkspeed   	= maxspeed;
        size			= 3;
        canmelee    	= 0;
        team        	= 1; 
        targetvisible	= 0;
        target      	= 0;
		target_x		= 0;
		target_y		= 0;
        walk        	= 0;
        gunangle    	= 180;
		wepangle    	= 120;
		ammoType		= "Barrel";
		fuseTime		= 0;
        
        // Alarms:
        alarm1 = 20 + irandom(30);
        alarm2 = 0;

        // Scripts:
        on_step  = script_ref_create(EliteWhale_step);
        on_draw  = MortarEnemy_draw;
        on_hurt  = Enemy_hurt;
        on_death = EliteWhale_death;
        on_alrm1 = script_ref_create(EliteWhale_alrm1);
        on_alrm2 = script_ref_create(EliteWhale_alrm2);
        
        return self;
	}
	
#define EliteWhale_step

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

#define EliteWhale_alrm1
	alarm1 = 40 + irandom(30);
	
	if(enemy_target(x, y)) {
		enemy_look(target_direction);
		
			// GET YOU:
		if(target_distance > 176){
			alarm1 = 30 + irandom(15);
			enemy_walk(target_direction + orandom(30), alarm1 - 10);
		}
			 // If in range:
		else{
			 // Attack:
			 // Not too close!
			if(chance(2, 3) && (target_distance > 32)){
				alarm1 = 100 + irandom(20);
    
    			 // Fuse:
    			alarm2 = 1;
    			fuseTime = 30;
			/*	with(instance_create(x, y, AssassinNotice)){
					depth = other.depth - 1;
				} */
    			sound_play_pitch(sndToxicBarrelGas, 1.2 + random(0.2))
			}
			
			 // Move Away From Target:
			else{
				alarm1 = 50 + irandom(15);
				enemy_walk(gunangle + 180 + orandom(30), alarm1 - 10);
			}
		}
	}
	
	 // Wander Around Town:
	else{
		enemy_walk(random(360), 30);
		enemy_look(direction);
	}
	
#define EliteWhale_alrm2
	if(fuseTime > 0){
		alarm2 = 1;
		
		 // Smoke:
    	if(random(3) < 1){
		   	with instance_create(x + lengthdir_x(25, other.gunangle), y + lengthdir_y(25, other.gunangle), Smoke){
			   	image_xscale = 0.2 + random(0.3);
			   	image_yscale = image_xscale;
			   	motion_add(other.gunangle + other.right * 100, 1 + random(2));
		   	}
       	}

	       	 // Track Target:
       	if(ammoType = "Barrel"){
			if(instance_exists(target)){
				gunangle = target_direction;
				target_x = target.x;
				target_y = target.y;
			}
       	}
       	

		 // FIRE!
		if(--fuseTime <= 0){
			
			 // Sound:
			sound_play_pitch(sndGrenadeRifle, 0.6 + random(0.2));
			sound_play_pitch(sndExplosion, 1.4 + random(0.2));
			
			 // Kick:
			wkick = 12;
			
			 // Barrel:
			if(ammoType = "Barrel"){
				with MortarBarrel_create(x, y){
					zspeed  		= 10;
					direction		= point_direction(x, y, other.target_x, other.target_y);
					speed   		= (point_distance(x, y, other.target_x, other.target_y) * zfriction) / (zspeed * 2);
					image_angle 	= direction;
					team        	= other.team;
					creator 		= other;
					hitid			= other.hitid;
					
		  			// Particles:
					repeat(12){
						with instance_create(x + lengthdir_x(10, other.gunangle), y + lengthdir_y(10, other.gunangle), Smoke){							
							image_xscale    = 0.2 + random_range(0.1, 0.5);
							image_yscale    = image_xscale;
							motion_add(other.direction + random_range(-10, 10), 2 + random(2)) 
						}
					}
				}
				fuseTime += 25;
				ammoType = "Cannonball";
			} else {
	
				 // Sound:
				sound_play_pitch(sndGrenadeRifle, 0.6 + random(0.2));
				sound_play_pitch(sndExplosion, 1.4 + random(0.2));
				
				 // Kick:
				if(!instance_exists(self)){ exit; } // it spat an error for this line one time so im just gonna put this here
				wkick = 12;
				
				 // Cannonball:
				with MortarCannonball_create(x, y){
					zspeed  		= 10;
					direction		= point_direction(x, y, other.target_x, other.target_y);
					speed   		= (point_distance(x, y, other.target_x, other.target_y) * zfriction) / (zspeed * 2);
					image_angle 	= direction;
					team        	= other.team;
					creator 		= other;
					hitid			= other.hitid;
	
	  
					 // Particles:
					repeat(12){
						with instance_create(x + lengthdir_x(10, other.gunangle), y + lengthdir_y(10, other.gunangle), Smoke){
							image_xscale    = 0.2 + random_range(0.1, 0.5);
							image_yscale    = image_xscale;
							motion_add(other.direction + random_range(-10, 10), 2 + random(2)) 
						}
					}
				}
				ammoType = "Barrel";
			}
		}
	}
	
#define EliteWhale_death
	pickup_drop(70, 25);

#define Parrot_create(_x, _y)
	with(instance_create(_x, _y, CustomEnemy)){
   
    	name = "Parrot"
    	
         // Visuals: 
        var topStyle    = choose(1, 2, 3, 4);
    	spr_idle		= global.sprParrotTopLayerIdle[topStyle]
		spr_idle2		= global.sprParrotBaseLayerIdle;
		spr_idle3		= global.sprParrotMiddleLayerIdle;
		spr_walk		= global.sprParrotTopLayerWalk[topStyle];
		spr_walk2		= global.sprParrotBaseLayerWalk;
		spr_walk3		= global.sprParrotMiddleLayerWalk;
		spr_hurt		= global.sprParrotTopLayerHurt[topStyle]; 
		spr_hurt2		= global.sprParrotBaseLayerHurt;
		spr_hurt3		= global.sprParrotMiddleLayerHurt;
		spr_dead		= global.sprParrotDead;
		spr_gameover	= global.sprParrotGameover;
		sprite_index    = spr_idle;
		sprite_index2	= spr_idle2;
		sprite_index3	= spr_idle3;
		spr_weap		= sprHammer; // Fallback
		 
		 // Visual Vars:
		var colorHue	= random(255);
		pColor1			= make_color_hsv(colorHue, 155 + random(100), 255);
		pColor2			= choose(c_white, make_color_hsv(30 + random(170), 155 + random(100), 255))
		image_speed     = 0.4;
		depth           = -2;
		hitid           = [spr_gameover, "PARROT"]
        spr_shadow      = shd24;	
        nts_color_blood = [c_red, make_color_rgb(134, 44, 35)]
        
         // Sounds:
        snd_hurt		= global.sndGunParrotHurt;
        snd_dead		= global.sndGunParrotDead;
        
         // Vars:
        mask_index  	= mskBandit;
        direction   	= random(360);
        maxhealth   	= 10;
       	my_health   	= maxhealth;
        raddrop     	= 3;
        maxspeed    	= 4;
        walkspeed   	= maxspeed;
        size			= 1;
        canmelee    	= 0;
        team        	= 1; 
        targetvisible	= 0;
        target      	= 0;
        walk        	= 0;
        gunangle    	= 180;
		wepangle		= -140;
		meleeWeapon		= false;
		
		 // Weapon:
		myWeapon		= choose("flintlock", "cutlass")
		switch(myWeapon){
			case "flintlock": {
				meleeWeapon = false;
				spr_weap	= global.sprParrotWeapFlintlock;
        		snd_hurt	= global.sndGunParrotHurt;
        		snd_dead	= global.sndGunParrotDead;
				break;
			}
			case "cutlass": {
				meleeWeapon = true;
				spr_weap	= global.sprParrotWeapCutlass;
        		snd_hurt	= global.sndSwordParrotHurt;
        		snd_dead	= global.sndSwordParrotDead;
        		
        		maxspeed	= 4.5;
        		
				break;
			}
		}
        
         // Alarms:
        alarm1 = 20 + irandom(30);
        alarm2 = 0;

         // Scripts:
        on_step  = script_ref_create(Parrot_step);
        on_draw  = Parrot_draw;
        on_hurt  = Parrot_hurt;
        on_death = Parrot_death;
        on_alrm1 = script_ref_create(Parrot_alrm1);
        on_alrm2 = script_ref_create(Parrot_alrm2);
        
        
        if(global.settingLowQualityParrots = true){
        	spr_idle	= global.sprParrotLQIdle;
        	spr_walk	= global.sprParrotLQWalk;
        	spr_hurt	= global.sprParrotLQHurt;
        	pColor1		= make_color_rgb(0, 184, 0);
        	
        	on_step 	= ParrotLQ_step;
        	on_draw 	= ParrotLQ_draw;
        }
        
        return self;
	}
	
#define Parrot_step
#macro  p_sprite2 (sprite_index != spr_hurt2 || anim_end) ? ((speed == 0) ? spr_idle2 : spr_walk2) : sprite_index
#macro  p_sprite3 (sprite_index != spr_hurt3 || anim_end) ? ((speed == 0) ? spr_idle3 : spr_walk3) : sprite_index

	 // Alarms:
	if("on_alrm1" in self and alarm1_run) exit;
	if("on_alrm2" in self and alarm2_run) exit;

		// Movement:
	if(walk > 0){ walk -= current_time_scale;   speed += walkspeed * current_time_scale;   gunangle = direction }
	
		//Speed Cap:
	if(speed > maxspeed){ speed = maxspeed; }
	
		 // Animate:
	sprite_index  = enemy_sprite;
	sprite_index2 = p_sprite2;
	sprite_index3 = p_sprite3;
	right = (gunangle + 270) mod 360 > 180 ? 1 : -1;

#define Parrot_alrm1
	alarm1 = 30 + irandom(30);

	if(enemy_target(x, y) && target_visible){
		enemy_look(target_direction);
		
		 // Cutlass:
		if(meleeWeapon = true){
				// GET YOU:
			if(target_distance > 48){
				alarm1 = 5 + irandom(10);
				enemy_walk(target_direction + orandom(50), alarm1 - 5);
			}
			
				// If in range:
			if(target_distance < 64){
				
				// Attack:
				if(chance(4, 5) && target_distance > 4){
					with(instance_create(x, y, AssassinNotice)){
						depth = other.depth - 1;
					}
					walk		= 0;
					alarm1		= 20 + irandom(10);
					fuseTime	= 12;
					alarm2  	= 1;
					gunangle	= target_direction;
				}
				
				 // Move Away From Target:
				else{
					alarm1 = 10 + irandom(5);
					enemy_walk(gunangle + 180 + orandom(30), alarm1 - 10);
				}
			}
		}
		 
		 // GUN:
		if(meleeWeapon = false){
			
				// GET YOU:
			if(target_distance > 160){
				alarm1 = 30 + irandom(15);
				enemy_walk(target_direction + orandom(30), alarm1 - 10);
			} else {
				
				 // Attack:
				if(chance(2, 3) && (target_distance > 48)){
					alarm1 = 40 + irandom(10);

    				// Fuse:
    				fuseTime	= 16;
    				alarm2		= 1;
    				gunangle	= target_direction;
    			//	instance_create(x, y, AssassinNotice)
    				sound_play_pitch(sndEmpty, 1.3 + random(0.2))
    				sound_play_pitch(sndSwapMachinegun, 1.3 + random(0.2))
				}
				// Move Away From Target:
				else{
					alarm1 = 40 + irandom(15);
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

#define Parrot_alrm2
	if(fuseTime > 0){
		alarm2 = 1;
		
			// Smoke:
		if(meleeWeapon = false){
			if(fuseTime >= 8){
			    if(instance_exists(target) && target_visible){
			    	gunangle = target_direction;
			    }
			}
	    	if(random(3) < 1){
				with(instance_create(x + lengthdir_x(12, other.gunangle), y + lengthdir_y(12, other.gunangle), Smoke)){
    				image_xscale = 0.2 + random(0.3);
    				image_yscale = image_xscale;
    				motion_add(other.gunangle + other.right * 100, 1 + random(2));
				}
	       	}
		}

		 // FIRE!
		if(--fuseTime <= 0){
			if(meleeWeapon = true){
				with(instance_create(x, y, EnemySlash)){
					damage		= 3;
					speed		= 2;
					direction	= other.gunangle + random_range(-3, 3);
					image_angle = direction;
					creator		= other;
					team		= other.team
					hitid		= other.hitid;
				}
				motion_add(gunangle, 1.5);
				wkick	 = -4;
				wepangle *= -1;
				sound_play(sndAssassinAttack);
				sound_play_pitch(sndScrewdriver, 0.7 + random(0.3));				
			} else {
				// Sound:
				sound_play_pitch(sndExplosionS, 1.4 + random(0.2));
	   			sound_play_pitch(sndHeavyRevoler, 1.4 + random(0.2));
			
				 // Kick:
				wkick = 12;
	
				// Projectile:
				with(instance_create(x, y, EnemyBullet4)){
					damage          = 3;
					speed           = 13 * power(0.8, skill_get(mut_euphoria));
					direction		= other.gunangle + random_range(-10, 10);
					image_angle		= direction;
					creator         = other;
					team            = other.team;
					hitid			= other.hitid;
				}
	
				repeat(irandom_range(6, 12)){
					with(instance_create(x, y, Smoke)){
						sprite_index	= global.sprWhiteSmoke;
						direction		= other.gunangle + random_range(-45, 45);
						speed			= 1 + random(2);
					}
				}
				repeat(7){
					with(instance_create(x, y, EnemyBullet3)){
						speed           = 6 + random(3) * power(0.8, skill_get(mut_euphoria));
						direction		= other.gunangle + random_range(-45, 45);
						image_angle		= direction;
						creator         = other;
						team            = other.team;
						hitid			= other.hitid;							
					}
				}
			}
		}
	}

#define Parrot_hurt(_dmg, _spd, _dir)
	sprite_index	= spr_hurt;
	sprite_index2	= spr_hurt2;
	sprite_index3	= spr_hurt3;
	image_index 	= 0;
	
	sound_play_hit(snd_hurt, 0.3);
	motion_add(_dir, _spd);
	
	nexthurt   = current_frame + 6;
	my_health -= _dmg;

#define Parrot_death
	repeat(6 + irandom(4)){
		with instance_create(x, y, Feather){
			sprite_index	= global.sprParrotFeather;
			image_blend 	= other.pColor1;
		}
	}
	pickup_drop(20, 0)
	
#define Parrot_draw

	 // Gun:
	if(meleeWeapon = false){
		if (gunangle < 180){ 
			draw_sprite_ext(spr_weap, 0, x + lengthdir_x(-wkick, gunangle), y + lengthdir_y(-wkick, gunangle), 1, right, gunangle, image_blend, image_alpha); 
		} 
		
		draw_sprite_ext(sprite_index2, image_index, x, y, image_xscale * right, image_yscale, image_angle, pColor1, image_alpha); 
		draw_sprite_ext(sprite_index3, image_index, x, y, image_xscale * right, image_yscale, image_angle, pColor2, image_alpha); 
		draw_sprite_ext(sprite_index,  image_index, x, y, image_xscale * right, image_yscale, image_angle, image_blend, image_alpha);
		
		if (gunangle >= 180){ 
			draw_sprite_ext(spr_weap, 0, x + lengthdir_x(-wkick, gunangle), y + lengthdir_y(-wkick, gunangle), 1, right, gunangle, image_blend, image_alpha);
		}
	 // Melee:
	} else {
		if (gunangle < 180){ 
			draw_weapon(spr_weap, 0, x, y, gunangle, wepangle, wkick, 1, image_blend, image_alpha); 
		}
		
		draw_sprite_ext(sprite_index2, image_index, x, y, image_xscale * right, image_yscale, image_angle, pColor1, image_alpha); 
		draw_sprite_ext(sprite_index3, image_index, x, y, image_xscale * right, image_yscale, image_angle, pColor2, image_alpha); 
		draw_sprite_ext(sprite_index,  image_index, x, y, image_xscale * right, image_yscale, image_angle, image_blend, image_alpha); 
		
		if (gunangle >= 180){ 
			draw_weapon(spr_weap, 0, x, y, gunangle, wepangle, wkick, 1, image_blend, image_alpha); 
		}		
	}
	
#define ParrotLQ_step

	 // Alarms:
	if("on_alrm1" in self and alarm1_run) exit;
	if("on_alrm2" in self and alarm2_run) exit;

		// Movement:
	if(walk > 0){ walk -= current_time_scale;   speed += walkspeed * current_time_scale;   gunangle = direction }
	
		//Speed Cap:
	if(speed > maxspeed){ speed = maxspeed; }
	
		 // Animate:
	sprite_index  = enemy_sprite;
	right = (gunangle + 270) mod 360 > 180 ? 1 : -1;
	
#define ParrotLQ_draw

	 // Gun:
	if(meleeWeapon = false){
		if (gunangle < 180){ 
			draw_sprite_ext(spr_weap, 0, x + lengthdir_x(-wkick, gunangle), y + lengthdir_y(-wkick, gunangle), 1, right, gunangle, image_blend, image_alpha); 
		} 

		draw_sprite_ext(sprite_index,  image_index, x, y, image_xscale * right, image_yscale, image_angle, image_blend, image_alpha);
		
		if (gunangle >= 180){ 
			draw_sprite_ext(spr_weap, 0, x + lengthdir_x(-wkick, gunangle), y + lengthdir_y(-wkick, gunangle), 1, right, gunangle, image_blend, image_alpha);
		}
	 // Melee:
	} else {
		if (gunangle < 180){ 
			draw_weapon(spr_weap, 0, x, y, gunangle, wepangle, wkick, 1, image_blend, image_alpha); 
		}
		
		draw_sprite_ext(sprite_index,  image_index, x, y, image_xscale * right, image_yscale, image_angle, image_blend, image_alpha); 
		
		if (gunangle >= 180){ 
			draw_weapon(spr_weap, 0, x, y, gunangle, wepangle, wkick, 1, image_blend, image_alpha); 
		}		
	}
	
#define Starfish_create(_x, _y)
	with(instance_create(_x, _y, CustomEnemy)){
   
    	name = "Starfish"
    	
        // Visuals: 
        spr_idle		= global.sprStarfishIdle;
		spr_walk		= global.sprStarfishWalk;
		spr_hurt		= global.sprStarfishHurt;
		spr_dead		= global.sprStarfishDead;
		spr_tell		= global.sprStarfishTell;
		spr_chrg		= global.sprStarfishChrg;
		sprite_index    = spr_idle;
		image_speed     = 0.4;
		depth           = -2;
		hitid           = [spr_idle, "STARFISH"]
        spr_shadow      = global.shdStarfish;	
        nts_color_blood = [c_orange, make_color_rgb(135, 70, 35)]
        water_breathing = true;
        spr_bubble  	= -1;
        spr_bubble_pop	= -1;
        spr_bubble_x	= 0;
        spr_bubble_y	= 0;
        
        // Sounds:
        snd_hurt		= global.sndStarfishHurt;
        snd_dead		= global.sndStarfishDead;
        
        // Vars:
        mask_index  	= mskBandit;
        direction   	= random(360);
        maxhealth   	= 8;
       	my_health   	= maxhealth;
        raddrop     	= 2;
        maxspeed    	= 1;
        walkspeed   	= maxspeed;
        size			= 1;
        canmelee    	= 1;
        meleedamage		= 2;
        team        	= 1; 
        targetvisible	= 0;
        target      	= 0;
        walk        	= 0;
        charge			= 0;
        charge_wait		= 0;
        charge_dir		= 0;
        charge_speed	= 0;
        
        // Alarms:
        alarm1 = 20 + irandom(10);

        // Scripts:
        on_step  = script_ref_create(Starfish_step);
        on_draw  = Starfish_draw;
        on_hurt  = Enemy_hurt;
        on_death = Starfish_death;
        on_alrm1 = script_ref_create(Starfish_alrm1);
        
        return self;
	}
	
#define Starfish_step

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
			sound_play_pitch(sndRatkingCharge, 1.5 + random(0.2));
		}
	}
	else if(charge > 0){
		charge		-= current_time_scale;
		image_angle = charge_dir;
		right		= 1;
		
		 // SLOW DOWN ! 
		charge_speed -= (0.1 * current_time_scale);
		if(charge_speed <= 1 || charge <= 0){
			charge		= 0;
			image_angle	= 0;
		}
		
		 // MOVE!:
		motion_add(direction, charge_speed);
		enemy_look(direction);
		
		 // Sprite:
		if(sprite_index != spr_hurt){
			sprite_index = spr_chrg;
		}

		 // Wall Bounce:
		if(place_meeting(x + hspeed_raw, y + vspeed_raw, Wall)){
			charge_dir		+= 180;
			charge_speed	-= 1;
			
			sound_play_pitch(sndBouncerBounce, 0.7 + random(0.1))
			instance_create(x, y, Dust);
		}
	}
	
		//Use Your Eyes:
	right = (direction + 270) mod 360 > 180 ? 1 : -1;

#define Starfish_alrm1
	alarm1 = 20 + irandom(10);

	if(enemy_target(x, y) && target_visible) {
		if(target_distance > 140){
			 // Move Towards Target
			if(chance(2, 3)){
				enemy_walk(target_direction + random_range(-20, 20), alarm1);
			}			
		} else {
			if(chance(3, 4)){
				charge			= 40;
				charge_wait 	= 10;
				charge_dir		= target_direction;
				charge_speed	= 5;
				alarm1      	= (charge + charge_wait) + (20 + irandom(15));
			}
		}
	}
	
	 // Wander Around Town:
	else{
		if(chance(1, 3)){
			enemy_walk(random(360), alarm1);
			enemy_look(direction);
		}
	}
	
#define Starfish_death
	pickup_drop(10, 0);
	
#define Starfish_draw
	if(charge <= 0){
		draw_sprite_ext(sprite_index, image_index, x, y, image_xscale * right, image_yscale, image_angle, image_blend, image_alpha);
	} else {
		draw_sprite_ext(sprite_index, image_index, x, y, image_xscale, image_yscale, image_angle, image_blend, image_alpha);
	}
	
#define EliteStarfish_create(_x, _y)
	with instance_create(_x, _y, CustomEnemy){
   
    	name = "Powderfish"
    	
        // Visuals: 
        spr_idle		= global.sprEliteStarfishIdle;
		spr_walk		= global.sprEliteStarfishWalk;
		spr_hurt		= global.sprEliteStarfishHurt;
		spr_dead		= global.sprEliteStarfishDead;
		spr_tell		= global.sprEliteStarfishTell;
		spr_chrg		= global.sprEliteStarfishChrg;
		spr_glow		= global.sprEliteStarfishChrgLight;
		sprite_index    = spr_idle;
		image_speed     = 0.4;
		depth           = -2;
		hitid           = [spr_idle, "POWDERFISH"]
        spr_shadow      = global.shdStarfish;	
        nts_color_blood = [c_orange, make_color_rgb(135, 70, 35)]
        water_breathing = true;
        spr_bubble  	= -1;
        spr_bubble_pop	= -1;
        spr_bubble_x	= 0;
        spr_bubble_y	= 0;
        
        // Sounds:
        snd_hurt		= global.sndStarfishHurt;
        snd_dead		= global.sndStarfishDead;
        
        // Vars:
        mask_index  	= mskBandit;
        direction   	= random(360);
        maxhealth   	= 16;
       	my_health   	= maxhealth;
        raddrop     	= 9;
        maxspeed    	= 1.8;
        walkspeed   	= maxspeed;
        size			= 1;
        canmelee    	= 1;
        meleedamage		= 2;
        team        	= 1; 
        targetvisible	= 0;
        target      	= 0;
        walk        	= 0;
        charge			= 0;
        charge_wait		= 0;
        charge_dir		= 0;
        charge_speed	= 0;
        charge_bounces  = 0;
        
        // Alarms:
        alarm1 = 20 + irandom(10);

        // Scripts:
        on_step  = script_ref_create(EliteStarfish_step);
        on_draw  = EliteStarfish_draw;
        on_hurt  = Enemy_hurt;
        on_death = EliteStarfish_death;
        on_alrm1 = script_ref_create(EliteStarfish_alrm1);
        
        return self;
	}
	
#define EliteStarfish_step

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
			sound_play_pitch(sndRatkingCharge, 1.5 + random(0.2));
		}
	}
	else if(charge > 0){
		
		 // SLOW DOWN ! 
		if(charge_bounces <= 0){
			charge_speed -= (0.6 * current_time_scale);
		}
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
		
		 // Fire:
		with(instance_create(x + random_range(-6, 6), y + random_range(-6, 6), TrapFire)){
			direction	= other.direction + 180 + random_range(-15, 15);
			image_speed	= 0.8;
			speed		= 2;
			team		= other.team;
			creator		= other;
			hitid		= other.hitid;
		}

		 // Wall Bounce:
		if(place_meeting(x + hspeed_raw, y + vspeed_raw, Wall)){
			charge_dir		+= 180 + orandom(30);
			charge_speed	-= 1;
			charge_bounces	-= 1;
			
			sound_play_pitch(sndBouncerBounce, 0.7 + random(0.1))
			instance_create(x, y, Dust);
		}
	}
	
		//Use Your Eyes:
	right = (direction + 270) mod 360 > 180 ? 1 : -1;

#define EliteStarfish_alrm1
	alarm1 = 20 + irandom(10);

	if(enemy_target(x, y) && target_visible && charge <= 0){
		if(target_distance > 172){
			 // Move Towards Target
			if(chance(2, 3)){
				enemy_walk(target_direction + random_range(-20, 20), alarm1);
			}			
		} else {
			if(chance(4, 5)){
				charge			= 1;
				charge_wait 	= 20;
				charge_dir		= target_direction;
				charge_speed	= 7;
				charge_bounces	= 3;
				alarm1      	= (charge + charge_wait) + (20 + irandom(15));
			}
		}
	}
	
	 // Wander Around Town:
	else{
		if(charge <= 0){
			enemy_walk(random(360), alarm1);
			enemy_look(direction);
		}
	}
	
#define EliteStarfish_draw
	draw_sprite_ext(sprite_index, image_index, x, y, image_xscale * right, image_yscale, image_angle, image_blend, image_alpha);
	if(charge > 0 && charge_wait <= 0){
		draw_sprite_ext(spr_glow, image_index, x, y, image_xscale * right * 1.5, image_yscale * 1.5, image_angle, image_blend, image_alpha - 0.6);
	}
	
#define EliteStarfish_death
	pickup_drop(16, 0);
	
#define StarfishSing_create(_x, _y)
	with(instance_create(_x, _y, CustomEnemy)){
   
    	name = "Starfish"
    	
        // Visuals: 
        spr_idle		= global.sprStarfishSingIdle;
		spr_walk		= global.sprStarfishSingWalk;
		spr_hurt		= global.sprStarfishSingHurt;
		spr_dead		= global.sprStarfishSingDead;
		sprite_index    = spr_idle;
		image_speed     = 0.4;
		depth           = -2;
		hitid           = [spr_idle, "STARFISH"]
        spr_shadow      = global.shdStarfish;	
        nts_color_blood = [c_orange, make_color_rgb(135, 70, 35)]
        water_breathing = true;
        spr_bubble  	= -1;
        spr_bubble_pop	= -1;
        spr_bubble_x	= 0;
        spr_bubble_y	= 0;
        
        // Sounds:
        snd_hurt		= global.sndStarfishHurt;
        snd_dead		= global.sndStarfishDead;
        
        // Vars:
        mask_index  	= mskBandit;
        direction   	= random(360);
        maxhealth   	= 16;
       	my_health   	= maxhealth;
        raddrop     	= 4;
        maxspeed    	= 1;
        walkspeed   	= maxspeed;
        size			= 1;
        canmelee    	= 0;
        meleedamage		= 0;
        team        	= 1; 
        targetvisible	= 0;
        target      	= 0;
        walk        	= 0;
        sndSing 		= noone;
        
        // Alarms:
        alarm1 = 20 + irandom(10);

        // Scripts:
        on_step  = script_ref_create(StarfishSing_step);
        on_draw  = BasicEnemy_draw;
        on_hurt  = Enemy_hurt;
        on_death = StarfishSing_death;
        
        return self;
	}
	
#define StarfishSing_step

		// Speed Cap:
	if(speed > maxspeed){ 
		speed = maxspeed; 
	}
	
	 // Animate:
	sprite_index = enemy_sprite;
	right = (direction + 270) mod 360 > 180 ? 1 : -1;
	
	if(!audio_is_playing(sndSing)){
		sndSing = sound_play(global.sndStarfishSing);
	}
	if(instance_exists(Player)){
		var _nearestPlayer	= instance_nearest(x, y, Player),
			_dis			= distance_to_object(_nearestPlayer),
			_honkVol		= (256 - _dis) / 256;
		sound_volume(sndSing, clamp(1 * _honkVol, 0, 10));
	}
	if(random(10) < 1){
		MusicNote_create(x + random_range(-10, 10), y - 10)
	}

#define StarfishSing_death
	sound_stop(sndSing);

#define MusicNote_create(_x, _y)
	with(instance_create(_x, _y, CustomObject)){
		sprite_index	= global.sprMusicNote;
		image_index		= irandom(image_number)
		image_speed		= 0;
		speed			= 1 + random(1.5);
		direction		= 90;
		lifetime		= 10;
		
		on_step 		= MusicNote_step
		
		return self;	
	}
	
#define MusicNote_step
	lifetime -= current_time_scale;
	if(lifetime < 0){
		instance_destroy();
	}
	
//#endregion
//#endregion
//#region ENEMY PROJECTILES
#define Cannonball_create(_x, _y)
    with instance_create(_x, _y, CustomProjectile){
        
         // Visuals:
        sprite_index    = global.sprCannonball;
        
         // Vars:
        mask_index		= global.mskCannonball;
        speed           = 12 * power(0.8, skill_get(mut_euphoria));
        typ             = 1;
        damage          = 2;
        creator         = other;
        team            = other.team;
        hitid           = [sprite_index, "CANNONBALL"];
        
        on_step         = Cannonball_step;
        on_destroy      = Cannonball_destroy;
        
        return self;
    }
    
#define Cannonball_step
    if(random(3) < 1){
        with(instance_create(x + random_range(-8, 8), y + random_range(-8, 8), Sweat)){
            image_blend     = c_black;
            direction       = other.direction + 180 + random_range(-20, 20);
        }
    }
    if(random(5) < 1){
        with(instance_create(x + random_range(-8, 8), y + random_range(-8, 8), BulletHit)){
            sprite_index    = global.sprCannonballTrail;
            direction       = other.direction + 180 + random_range(-20, 20);
            speed           = 3;
        }
    }
    image_angle += 40 * current_time_scale;
    
#define Cannonball_destroy
    sound_play(sndExplosionL);
    sound_play(sndExplosionS);
    with instance_create(x, y, Explosion){
    	hitid		 = other.hitid;
    }
	for (i = 0; i < 360; i += 90){
		with instance_create(x, y, SmallExplosion){
			hitid		= other.hitid;
		}
	}
    repeat(5){
        with(instance_create(x, y, EnemyBullet3)){
            direction   = random(360);
            speed       = 6 + random(3);
            hitid		= other.hitid;
        }
    }
    
#define MortarBarrel_create(_x, _y)
    with instance_create(_x, _y, CustomProjectile){
    	name = "lobbedBarrel"
        
         // Visuals:
        sprite_index    = global.sprMortarBarrel;
        
         // Vars:
        speed           = 12 * power(0.8, skill_get(mut_euphoria));
        typ             = 1;
        damage          = 1;
        creator         = other;
        team            = other.team;
        hitid           = [sprite_index, "BARREL"];
        z				= 5;
		zspeed  		= 0;
		zfriction		= 1;
		
        on_step         = MortarBarrel_step;
        on_destroy      = MortarBarrel_destroy;
        on_draw			= MortarBarrel_draw;
        
        return self;
    }
    
#define MortarBarrel_step

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
	if(z <= 4){
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
			if(distance_to_object(Floor) < 20 || place_meeting(x, y, Player)){
				instance_destroy();
			}
		}
	}
	
	 // While In Air:
	else{
		friction	= 0;
		depth		= -10;
	}

#define MortarBarrel_destroy
	repeat(5){
		with mod_script_call("mod", "Frontier_Projectiles", "GunpowderCreep_create", x + orandom(32), y + orandom(32)){
			image_xscale	= choose(0.4, 0.5);
			image_yscale	= image_xscale;
			hitid			= other.hitid;
		}
	}
	repeat(4 + irandom(3)){
		with(instance_create(x, y, Debris)){
			sprite_index	= global.sprMortarBarrelDebris;
			direction		= random(360);
			speed			= 2 + random(2);
		}
	}
	sound_play_pitch(sndWallBreakJungle, 1.2 + random(0.2));
	
#define MortarBarrel_draw
  	draw_sprite_ext(sprite_index, image_index, x, (y - z), (image_xscale + z / 70), (image_yscale + z / 70), image_angle, image_blend, image_alpha);

#define MortarCannonball_create(_x, _y)
    with instance_create(_x, _y, CustomProjectile){
    	name = "lobbedCannonball"
        
         // Visuals:
        sprite_index    = global.sprCannonball;
        
         // Vars:
        speed           = 12 * power(0.8, skill_get(mut_euphoria));
        typ             = 1;
        damage          = 3;
        creator         = other;
        team            = other.team;
        hitid           = [sprite_index, "CANNONBALL"];
        z				= 5;
		zspeed  		= 0;
		zfriction		= 1;
		
        on_step         = MortarCannonball_step;
        on_destroy      = Cannonball_destroy;
        on_draw			= MortarBarrel_draw;
        
        return self;
    }
    
#define MortarCannonball_step

	 // Particles:
    if(random(3) < 1){
        with(instance_create(x + random_range(-8, 8), (y - z) + random_range(-8, 8), Sweat)){
            image_blend     = c_black;
            direction       = other.direction + 180 + (other.z / 70) + random_range(-20, 20);
            image_xscale	= (1 + other.z / 70);
            image_yscale	= image_xscale;
        }
    }
    if(random(5) < 1){
        with(instance_create(x + random_range(-8, 8), (y - z) + random_range(-8, 8), BulletHit)){
            sprite_index    = global.sprCannonballTrail;
            direction       = other.direction + 180 + (other.z / 70) + random_range(-20, 20);
            speed           = 3;
            image_xscale	= (1 + other.z / 70);
            image_yscale	= image_xscale;
        }
    }

	 // Z-Axis:
	z += zspeed * current_time_scale;
	zspeed -= zfriction * current_time_scale;
	image_angle -= sign(hspeed) * (abs(vspeed / 2) + abs(hspeed));
	
	 // Set Mask:
	if(z <= 4){
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
			var _m = 4;
			if(speed > _m) speed = _m;
		}
		
		 // Impact:
		if(zspeed < -10){
			if(distance_to_object(Floor) < 20 || place_meeting(x, y, Player)){
				instance_destroy();
			}
		}
	}
	
	 // While In Air:
	else{
		friction	= 0;
		depth		= -10;
	}

#define FallingRock_create(_x, _y)
	// make projectile that falls that u can hit outta tha way.. push with eyes..
	with(instance_create(_x, _y, CustomProjectile)){
		
         // Visuals:
        sprite_index    = sprDebris4;
        image_index		= irandom(image_number);
        image_alpha		= 0;
        image_speed		= 0;
        image_angle		= random(360);
        depth			= -10;
        turnSpeed		= (4 + random(6)) * choose(-1, 1);
        
         // Vars:
        speed           = 0;
        typ             = 1;
        damage          = 6;
        hitid           = [sprite_index, "FALLING ROCK"];
        ammo_type		= -1;
		z				= 300;
		zspeed			= -8;
		team			= "rock";
		smacked 		= false;
        
		
		 // Events:
		on_step 		= FallingRock_step;
		on_hit			= FallingRock_hit;
		on_destroy		= FallingRock_destroy;	
		on_draw 		= FallingRock_draw;
		
		with(script_bind_draw(FallingRock_warningDraw, -1)){
			creator			= other;
			telegraph_angle	= 0;
			telegraph_scale	= 0;
		}
		
		return self;
	}

#define FallingRock_step
	image_angle += turnSpeed;

	if(smacked = false){
		if(team != "rock"){
			smacked 		= true;
			speed			= 14;
			turnSpeed		= 12 + choose(-1, 1);
			z				= 0
			telegraph_scale	= 0;
			exit;
		}

		z += zspeed * current_time_scale;
		
		 // Fade In:
		if(z <= 150 && image_alpha < 1){
			image_alpha += 0.1;
		}
	
		 // Set Mask:
		if(z <= 12){
			mask_index	= mskSuperFlakBullet;
		} else {
			mask_index  = mskNone;
		}
		
		 // Set Z Goin:
		if(z <= 0){
			depth		= -3;
	
			 // Impact:
			instance_destroy();
			exit;
		}
	}
#define FallingRock_hit
	if(projectile_canhit(other)){
		if(instance_is(other, Player)){
			projectile_hit(other, damage);
		} else {
			projectile_hit(other, damage * 3);
		}
	}
	
#define FallingRock_destroy

#define FallingRock_draw
	draw_sprite_ext(sprite_index, image_index, x, (y - z), (image_xscale + z / 260), (image_yscale + z / 260), image_angle, image_blend, image_alpha);

#define FallingRock_warningDraw
	telegraph_angle += 6;
	if(telegraph_scale < 1){
		telegraph_scale	+= 0.1;
	}
	draw_sprite_ext(global.sprFallingRockWarning, 0, x, y, telegraph_scale, telegraph_scale, telegraph_angle, c_white, 1);
	if(!instance_exists(creator)){ 
		instance_destroy();
		exit;
	}

//#endregion
//#region GENERIC FUNCTIONS
#macro _tespr																					mod_variable_get("mod", "teassets", "spr");
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
    
#define init

		// LIB:
	while(!mod_exists("mod", "lib")){wait(1);}
	script_ref_call(["mod", "lib", "getRef"], "mod", mod_current, "scr");

	#macro  scr					global.scr
	#macro  call				script_ref_call
	
	 // SETTINGS //
    global.settingVisualDecryptors	= true;		// Whether or not decryptors have visualized followers. (default: true).

	global.libChests = [];
	
	 // SPRITES: //
	global.sprMealPickup       				= sprite_add("../sprites/pickups/sprMealPickup.png",							7, 16, 16);
	global.sprFishPickup       				= sprite_add("../sprites/pickups/sprFishPickup.png",							21, 16, 16);
	global.sprBloodLustPickup       		= sprite_add("../sprites/pickups/sprBloodLustPickup.png",						7, 7, 6);
	global.sprMaxHealthPickup       		= sprite_add("../sprites/pickups/sprMaxHealthPickup.png",						7, 6, 6);
	global.sprMaxAmmoPickup         		= sprite_add("../sprites/pickups/sprMaxAmmoPickup.png", 						7, 6, 6);
	global.sprMaxRadPickup          		= sprite_add("../sprites/pickups/sprMaxRadPickup.png",							7, 6, 6);
	global.sprWeaponCapsule         		= sprite_add("../sprites/pickups/sprWeaponCapsule.png", 						1, 6, 6);
	global.sprWeaponCapsuleDebris   		= sprite_add("../sprites/pickups/sprWeaponCapsuleDebris.png",					1, 6, 4);
	global.sprMealChest		        		= sprite_add("../sprites/pickups/sprMealChest.png", 							7, 9, 6);
	global.sprMealChestOpen		        	= sprite_add("../sprites/pickups/sprMealChestOpen.png", 						1, 9, 6);
	global.sprMealChestCursed		    	= sprite_add("../sprites/pickups/sprMealChestCursed.png",						7, 9, 6);
	global.sprMealChestCursedOpen			= sprite_add("../sprites/pickups/sprMealChestCursedOpen.png",					1, 9, 6);
	global.sprMealChestBig					= sprite_add("../sprites/pickups/sprMealChestBig.png",							7, 13, 10);
	global.sprMealChestBigOpen				= sprite_add("../sprites/pickups/sprMealChestBigOpen.png",						1, 13, 10);
	global.sprMealChestBigCursed			= sprite_add("../sprites/pickups/sprMealChestBigCursed.png",					7, 13, 10);
	global.sprMealChestBigCursedOpen		= sprite_add("../sprites/pickups/sprMealChestBigCursedOpen.png",				1, 13, 10);
	global.sprToolbox		        		= sprite_add("../sprites/pickups/sprToolbox.png",								7, 9, 8);
	global.sprToolboxOpen       			= sprite_add("../sprites/pickups/sprToolboxOpen.png",							1, 9, 8);
	global.sprDecryptor						= sprite_add("../sprites/pickups/sprDecryptor.png", 							1, 9, 9); 
	global.sprRogueChestBig					= sprite_add("../sprites/pickups/sprRogueChestBig.png", 						7, 12, 10);  
	global.sprRogueChestBigOpen				= sprite_add("../sprites/pickups/sprRogueChestBigOpen.png", 					1, 12, 10);  
	global.sprRogueChestMaggot				= sprite_add("../sprites/pickups/sprRogueChestMaggot.png", 						7, 12, 10);  
	global.sprRogueChestMaggotHurt			= sprite_add("../sprites/pickups/sprRogueChestMaggotHurt.png", 					3, 12, 10);  
	global.sprRogueChestMaggotDead			= sprite_add("../sprites/pickups/sprRogueChestMaggotDead.png", 					4, 12, 10);  
	global.shdDeeplabsCache					= sprite_add("../sprites/pickups/shdDeeplabsCache.png", 						1, 48, 16);  
	global.sprDeeplabsCache					= sprite_add("../sprites/pickups/sprDeeplabsCache.png", 						1, 31, 19);  
	global.sprDeeplabsCacheOpening			= sprite_add("../sprites/pickups/sprDeeplabsCacheOpening.png", 					12, 31, 19);  
	global.sprDeeplabsCacheOpen				= sprite_add("../sprites/pickups/sprDeeplabsCacheOpen.png", 					1, 31, 19);  
	global.sprDeeplabsCacheDone				= sprite_add("../sprites/pickups/sprDeeplabsCacheDone.png", 					1, 31, 19);  
	global.mskDeeplabsCache					= sprite_add("../sprites/pickups/mskDeeplabsCache.png", 						1, 31, 19);  
	global.sprHoarderBag					= sprite_add("../sprites/pickups/sprHoarderBag.png", 							7, 16, 16);  
	global.sprHoarderBagOpen				= sprite_add("../sprites/pickups/sprHoarderBagOpen.png", 						1, 16, 16);  
	global.sprAugmentAmmoPickup				= sprite_add("../sprites/pickups/sprAugmentAmmoPickup.png", 					7, 6, 6);  
	global.sprAugmentAmmoPickupBig			= sprite_add("../sprites/pickups/sprAugmentAmmoPickupBig.png", 					7, 7, 7);  
	global.sprAugmentAmmoPickupHuge			= sprite_add("../sprites/pickups/sprAugmentAmmoPickupHuge.png", 				7, 8, 6);  
	global.sprAugmentHealthPickup			= sprite_add("../sprites/pickups/sprAugmentHPPickup.png",						7, 6, 6);
	global.sprAugmentHealthPickupBig		= sprite_add("../sprites/pickups/sprAugmentHPPickupBig.png",					7, 7, 6);
	global.sprAugmentHealthPickupHuge		= sprite_add("../sprites/pickups/sprAugmentHPPickupHuge.png",					7, 8, 7);
	
	global.sprGenericTrail  				= sprite_add("../sprites/particles/sprGenericTrail.png",						50, 0, 50);
	global.sprWhiteSmoke					= sprite_add("../sprites/particles/sprWhiteSmoke.png",							5, 12, 12);
	global.sprMealSparkle  					= sprite_add("../sprites/particles/sprMealSparkle.png", 						5, 8, 8);
	
	global.sprMealMimicIdle  				= sprite_add("../sprites/enemies/mealmimic/sprMealMimicIdle.png",				1, 16, 16);
	global.sprMealMimicFire 				= sprite_add("../sprites/enemies/mealmimic/sprMealMimicFire.png",				4, 16, 16);
	global.sprMealMimicHurt  				= sprite_add("../sprites/enemies/mealmimic/sprMealMimicHurt.png",				3, 16, 16);
	global.sprMealMimicDead  				= sprite_add("../sprites/enemies/mealmimic/sprMealMimicDead.png",				6, 16, 16);
	global.sprMealMimicTell 				= sprite_add("../sprites/enemies/mealmimic/sprMealMimicTell.png",				12, 16, 16);
	global.sprCursedMealMimicIdle  			= sprite_add("../sprites/enemies/mealmimic/sprCursedMealMimicIdle.png", 		1, 16, 16);
	global.sprCursedMealMimicFire 			= sprite_add("../sprites/enemies/mealmimic/sprCursedMealMimicFire.png", 		4, 16, 16);
	global.sprCursedMealMimicHurt  			= sprite_add("../sprites/enemies/mealmimic/sprCursedMealMimicHurt.png", 		3, 16, 16);
	global.sprCursedMealMimicDead  			= sprite_add("../sprites/enemies/mealmimic/sprCursedMealMimicDead.png", 		6, 16, 16);
	global.sprCursedMealMimicTell 			= sprite_add("../sprites/enemies/mealmimic/sprCursedMealMimicTell.png", 		12, 16, 16);
	
	 // Tasty Time
	meal_init()
	list_finalize(global.MealDirectory, global.defaultMeal)
	meal_rank()
	mealCurses_init()
	list_finalize(global.MealCursesDirectory, global.defaultMealCurse)
	mealCurses_rank()
	
	 // ACTIVATE FISHING EXTREME:
	fish_init()
	list_finalize(global.FishDirectory, global.defaultFish)
	 // so messed up that I had to delete the funnyname for optmization :pensive: //fish_fin_alize()
	fish_rank()

	DeeplabsCache_init();

#define game_start
	DeeplabsCache_init();



/*
	These decryptors are just for visuals, the actual count is stored in a GameCont var.
	These are spawned/updated in Frontier_Main's level start, and from sources that give/take decryptors.
*/
#define Decryptor_spawn(_x, _y)
	if(global.settingVisualDecryptors = true){
		DecryptorFollower_create(_x, _y, call(scr.instance_random, Player));
	}
	GameCont.fr_decryptors += 1;

#define DecryptorFollower_create(_x, _y, _leader)
	with(instance_create(_x, _y, CustomObject)){
		name = "fr_DecryptorFollower"
		
		sprite_index	= global.sprDecryptor;
		depth			= -8;
		image_alpha		= 0; // Drawn in draw
		image_speed		= 0.4;
		right			= 0;
		offset			= random_range(-35, 35);
		distance		= 40 + random(40);
		tilt			= 0;

		leader			= _leader;
		friction		= 0.5;
		xgoal			= _leader.x;
		ygoal			= _leader.y;
		flightspeed		= 4;
	
		on_step			= DecryptorFollower_step;
		on_end_step		= DecryptorFollower_end_step;
		on_draw			= DecryptorFollower_draw;
		
		return self;
	}
	
#define DecryptorFollower_step

	 // What were we doing again?
	if(!instance_exists(leader)){
		if(!instance_exists(Player)){
			with(instance_create(x, y, ChickenB)){
				image_blend	= make_color_rgb(0, 255, 0)
			}
			instance_destroy();
			exit;
		} else {
			leader = call(scr.instance_random, Player)
		}
	}

	 // Displace! Displace!
	if(random(250) < 1){
		offset = random_range(-35, 35);
		distance = 40 + random(40);
	}
	 // Change Leader!
	if(instance_number(Player) > 1){
		if(random(1000) < 1){
			leader = call(scr.instance_random, Player)
		}
	}
	
	 // Position Me:
    x += approach(x, xgoal, flightspeed, 0.3 * current_time_scale) - lengthdir_x(0, leader.direction)
    y += approach(y, ygoal, flightspeed, 0.3 * current_time_scale) - lengthdir_y(0, leader.direction) 
    y = y + sin(current_frame * 0.06) * 0.2;
    xgoal = leader.x - lengthdir_x(distance, leader.direction + offset)
    ygoal = leader.y - lengthdir_y(distance, leader.direction + offset)
	
	 // Tilt n' Tumble:
	tilt = ((leader.speed * 4) * -right);
	
	 // Flip:
	right = (leader.direction + 270) mod 360 > 180 ? 1 : -1;

#define DecryptorFollower_end_step
		with generic_trail_create(x, y){
			depth			= other.depth + 1;
    		image_xscale	= point_distance(x, y, other.xprevious, other.yprevious)
    		image_yscale   *= 2;
    		image_speed    *= 4;
    		image_angle 	= point_direction(x, y, other.xprevious, other.yprevious)
			image_blend 	= make_color_rgb(0, 255, 0);
		}
	
#define DecryptorFollower_draw
	draw_set_blend_mode(bm_normal);
	draw_sprite_ext(sprite_index, image_index, x, y, image_xscale * right, image_yscale, tilt, image_blend, 1);

#define WeaponCapsule_create(_x, _y)
	with(instance_create(_x, _y, CustomObject)){
		sprite_index = global.sprWeaponCapsule;
		timer		 = 25;
		friction	 = 0.15;
		
		on_step		 = WeaponCapsule_step;
	
		return self;
	}
	
#define WeaponCapsule_step
	timer -= current_time_scale
	if (timer <= 0) {
		pickup_drop(0, 100, 1)
		repeat(2){ 
			with instance_create(x, y, Debris){ 
				sprite_index	= global.sprWeaponCapsuleDebris; 
				friction		= 1; 
			} 
		}
		instance_create(x, y, SmallChestFade);
		sound_play_pitch(sndBouncerBounce, 1.4);
		instance_destroy();
	}
	
#define BloodLustPickup_create(_x, _y)
	with(call(scr.obj_create, _x, _y, "LibPickup")){
		name = "fr_BloodLustPickup";
		sprite_index = global.sprBloodLustPickup;
		on_open      = script_ref_create(BloodLustPickup_open)
		alarm0       = 600;
		pull_dis     = 30 + (15 * skill_get(mut_plutonium_hunger));
		pull_spd     = 4;
		
		return self;
	}
	
#define BloodLustPickup_open
    sound_play_pitchvol(sndStrongSpiritLost, 0.5, 1)
	repeat(4){
	    with instance_create(x, y, BloodStreak) { 
	    	direction		= random(360); 
	    }
	}

	with(instance_is(other, Player) ? other : Player){
		with(instance_create(other.x, other.y, PopupText)) {
        	mytext = "@w+60 SECONDS OF#@(color:2964142)BONUS BLOODLUST"
		}
		if ("fr_buffBloodLust_time" not in self){ fr_buffBloodLust_time = 0; }
		mod_script_call('mod', 'Frontier_StatusEffects', 'status_apply_add', self, mod_variable_get('mod', 'Frontier_StatusEffects', 'buffBloodLust'), 1800)
	}
	return false;
		
//#region PROTO CACHE PICKUPS
#define MaxHealthPickup_create(_x, _y)
	with(call(scr.obj_create, _x, _y, "LibPickup")){
		name = "MaxHealthPickup";
		sprite_index = global.sprMaxHealthPickup;
		on_open      = script_ref_create(MaxHealthPickup_open)
		alarm0       = -1;
		pull_dis     = 20 + (5 * skill_get(mut_plutonium_hunger));
		pull_spd     = 3;
		snd_open     = sndHPPickup;
		
		return self;
	}
	
#define MaxHealthPickup_open
    sound_play_pitchvol(sndGuardianAppear, 0.5, 1)
	repeat(4){
	    with instance_create(x, y, EatRad) { 
	    	sprite_index	= sprEatBigRadPlut;
	    	speed			= 2; 
	    	direction		= random(360); 
	    }
	}

	with(instance_is(other, Player) ? other : Player){
		
    	maxhealth += 1;
		my_health += 1;
		my_health = min(my_health, maxhealth)
		
		
		with(instance_create(other.x, other.y, PopupText)) {
        	mytext = "@(color:589246)+1 " + loc("Frontier:MaxHealthPickup", "MAX HP")
		}
	}
	return false;
	
#define MaxAmmoPickup_create(_x, _y)
	with(call(scr.obj_create, _x, _y, "LibPickup")){
		name = "MaxAmmoPickup";
		sprite_index = global.sprMaxAmmoPickup;
		on_open      = script_ref_create(MaxAmmoPickup_open)
		alarm0       = -1;
		pull_dis     = 20 + (5 * skill_get(mut_plutonium_hunger));
		pull_spd     = 3;
		
		return self;
	}
	
#define MaxAmmoPickup_open
    sound_play_pitchvol(sndGuardianAppear, 0.5, 1);
	repeat(4){
	    with instance_create(x, y, EatRad) { 
	    	sprite_index	= sprEatBigRadPlut;
	    	speed			= 2; 
	    	direction		= random(360); 
	    }
	}
    
	with(instance_is(other, Player) ? other : Player){
		for(var i = 1; i < array_length(ammo); i++){
			mod_script_call("mod", "wibbly", "ammoMaxBonus_add", index, i, 5);
			mod_script_call("mod", "wibbly", "ammoMaxBonus_add", index, 1, 4); // boolets
		}		
		/*
		we dont need this stupid crap anymore!! wibbly is here!!! yes!!!
		for(var i = 1; i < array_length(ammo); i++){
			typ_amax[i] += 5;
            typ_amax[1] += 4;
		}
		*/
		with(instance_create(x, y, PopupText)) {
        	mytext = "@(color:589246)+5 " + loc("Frontier:MaxAmmoPickup", "MAX AMMO")
		}
	}
	return false;

#define MaxRadPickup_create(_x, _y)
	with(call(scr.obj_create, _x, _y, "LibPickup")){
		name = "MaxRadPickup";
		sprite_index = global.sprMaxRadPickup;
		on_open      = script_ref_create(MaxRadPickup_open)
		alarm0       = -1;
		pull_dis     = 20 + (5 * skill_get(mut_plutonium_hunger));
		pull_spd     = 3;
		snd_open     = sndEXPChest;
		
		return self;
	}
		
#define MaxRadPickup_open
    sound_play_pitchvol(sndGuardianAppear, 0.5, 1)
	repeat(4){
	    with instance_create(x,y,EatRad) { 
	    	sprite_index	= sprEatBigRadPlut;
	    	speed			= 2; 
	    	direction		= random(360); 
	    }
	}
    
     // add rads:
	mod_script_call("mod", "wibbly", "radMaxBonus_add", 60);

	with(instance_create(other.x, other.y, PopupText)) {
		mytext = "@(color:589246)+60 " + loc("Frontier:MaxRadPickup", "MAX RADS")
	}
	return false;


//#endregion


//#region CHESTS
#define ToolKitChest_create(_x, _y)
	with(call(scr.obj_create, _x, _y, "LibChest")){
		name = "fr_ToolKitChest";
		
		sprite_index	= global.sprToolbox;
		spr_dead		= global.sprToolboxOpen;
		spr_open		= sprFXChestOpen
		snd_open    	= sndAmmoChest;
		on_open     	= script_ref_create(ToolKitChest_open)
		
		return self;
	}

#define ToolKitChest_open

		 // can we fix it:
	var _difficulty = GameCont.hard + 1;
	var _toolPool = [
		[wep_wrench,     						0.55], // lowering it's rate a bit because I like the other weps more, can always spawn so i dont need duplicate screwdrivers
		[wep_jackhammer,     					(_difficulty >= weapon_get_area(wep_jackhammer))],
		[wep_energy_screwdriver,     			(_difficulty >= weapon_get_area(wep_energy_screwdriver))],
		[wep_energy_screwdriver,     			((_difficulty >= 6) * 0.2)], // lol
		[wep_golden_screwdriver,     			(_difficulty >= 6) * 0.05],  //rare
		[wep_golden_wrench,     				(_difficulty >= 6) * 0.05],  //rare
		["hand_spade",     						(_difficulty >= 4 									&& mod_exists("wep", "hand_spade"))], //dragonstrive said he was gonna do a weird thing with these so using manual number
		["hand_saw",     						(_difficulty >= 4  									&& mod_exists("wep", "hand_saw"))],
		["mcleod",     							(_difficulty >= 4  									&& mod_exists("wep", "mcleod"))],
		["tree_pruner",     					(_difficulty >= 4  									&& mod_exists("wep", "tree_pruner"))],
		["chainsaw",     						(_difficulty >= weapon_get_area("chainsaw")			&& mod_exists("wep", "chainsaw"))],
		["energy chainsaw",     				(_difficulty >= weapon_get_area("energy chainsaw")	&& mod_exists("wep", "energy chainsaw"))],
		["nail gun",     						(_difficulty >= weapon_get_area("nail gun") 		&& mod_exists("wep", "nail gun"))],
		["rivet gun",     						(_difficulty >= weapon_get_area("rivet gun")		&& mod_exists("wep", "rivet gun"))]
	];

	var coolTool = call(scr.pool, _toolPool);
	
	 // Guranteed Screwdriver:
	with instance_create(x, y, WepPickup){
		wep 	= wep_screwdriver;
		ammo	= 1;
	}
	 // Wow! awesome weapon man
	with instance_create(x, y, WepPickup){
		wep 	= coolTool;
		ammo	= 1;
	}

#define MealChest_create(_x, _y)
	with(call(scr.obj_create, _x, _y, "LibChest")){
		name = "fr_MealChest";
		
		 // Visuals:
		sprite_index	= global.sprMealChest;
		spr_dead		= global.sprMealChestOpen;
		spr_open		= sprFXChestOpen
		snd_open    	= sndAmmoChest;
		
		 // Cursed:
		switch(crown_current){
			case crwn_none   : curse = false;       	break;
			case crwn_curses : curse = (random(3) < 2)	break;
			default          : curse = (random(7) < 1);
		}
		if(curse > 0){
			sprite_index	= global.sprMealChestCursed;
			spr_dead    	= global.sprMealChestCursedOpen;
			snd_open		= sndCursedChest;
		}
		
		 // Vars:
		meal			= global.mealList[round(random_range(0, array_length_1d(global.mealList) - 1))];
		mealHot			= meal.mealHot;
		mealCursed		= curse;
	
		on_open     	= script_ref_create(MealChest_open)
		
		return self;
	}
	
#define MealChest_open
	
	 // Spawn Meal:
	with MealPickup_create(x, y, meal){
		mealCursed	= other.mealCursed;
	}
	 
	 // Ding!
	sound_play_pitchvol(sndCursedReminder, 1.4, 2)
	sound_play_pitchvol(sndHitMetal, 2.8 + random(0.3), 1.6)
		
	 // Waaah!! so Hot!!
	if(mealHot = true){
		repeat(7 + random(5)){
			with(instance_create(x, y, Smoke)){
				sprite_index	= global.sprWhiteSmoke;
				direction		= 90 + random_range(-30, 30);
				speed			= 1 + random(2);
				image_xscale	= 0.4 + random(0.4);
				image_yscale	= image_xscale;
			}
		}
	}
	
#define BigMealChest_create(_x, _y)
	with(MealChest_create(_x, _y)){
		name			= "fr_BigMealChest";
		
		sprite_index	= global.sprMealChestBig;
		spr_dead		= global.sprMealChestBigOpen;
		spr_shadow		= shd32
		spr_shadow_y	= 1;
		
		meal			= global.MealDirectory[? "big_burger"]
		
		 // Cursed:
		if(curse > 0){
			sprite_index	= global.sprMealChestBigCursed;
			spr_dead		= global.sprMealChestBigCursedOpen;
		}
		
		return self;
	}

#define RogueChestBig_create(_x, _y)
	with(call(scr.obj_create, _x, _y, "LibChest")){
		name = "fr_RogueChestBig";
		
		sprite_index		= global.sprRogueChestBig;
		spr_dead			= global.sprRogueChestBigOpen;
		spr_open			= sprFXChestOpen
		snd_open    		= sndRogueCanister;
		spr_shadow_y		= 1;
		
		on_step 			= script_ref_create(RogueChestBig_step);
		on_open     		= script_ref_create(RogueChestBig_open);
		fr_bigStrikeChest	= 1;
		
		return self;
	}

#define RogueChestBigController_create(_x, _y)
	with(instance_create(_x, _y, CustomObject)){
		name = "fr_RogueChestBigController";
		
		on_step 		= RogueChestBigController_step;
		
		return self;
	}

#define RogueChestBigController_step
	with(RogueChest){
		with(GameCont){
			if(fork()){
				wait 0;
				if(!instance_exists(other) && instance_exists(self)){
					if(instance_exists(GenCont) || instance_exists(LevCont)){
						fr_bigStrikeChest += 1;
					}
				}
				exit;
			}
		}
	}

#define RogueChestBig_step
	if(fr_bigStrikeChest != 0){
		with(GameCont){
			if(fork()){
				var _add = other.fr_bigStrikeChest;
				wait 0;
				if(!instance_exists(other) && instance_exists(self)){
					if(instance_exists(GenCont) || instance_exists(LevCont)){
						fr_bigStrikeChest += _add;
					}
				}
				exit;
			}
		}
	}
	
#define RogueChestBig_open
	GameCont.fr_bigStrikeChest	= 0; // Reset Strike Cont:

	if(instance_is(other, Player)){
		with(other){
			if(race = "rogue" || race = "vanthro"){
				repeat(2){
					instance_create(x, y, RoguePickup);
				}
			} else {
				 // Filthy Mutant:
				repeat(15){
					with(instance_create(x, y, Rad)){
						direction	= random(360);
						speed		= 2 + random(4);
					}
				}
				repeat(2){
					with(instance_create(x, y, BigRad)){
						direction	= random(360);
						speed		= 2 + random(2);
					}
				}
			}
		}
	} else {
		// Force Strikes when opened by portals (or other sources, just in case)
		repeat(2){
			instance_create(x, y, RoguePickup);
		}
	}
	return false;
	
#define RogueChestMaggot_create(_x, _y)
	with(instance_create(_x, _y, CustomProp)){
		name = "fr_RogueChestMaggot";
		
		spr_idle			= global.sprRogueChestMaggot;
		spr_hurt			= global.sprRogueChestMaggotHurt;
		spr_dead			= global.sprRogueChestMaggotDead;
		sprite_index		= spr_idle;
		spr_shadow_y		= -1;
		image_speed 		= 0.4;
		shine				= 1/16;
		snd_hurt			= sndHitFlesh;
		snd_dead			= sndEXPChest;
		right				= 1;
		image_xscale		= 1;
		
		maxhealth			= 8;
		my_health			= maxhealth;
		
		on_step 			= RogueChestMaggot_step;
		on_death			= RogueChestMaggot_open;
	}
	
#define RogueChestMaggot_step
	if(image_index < 1 && shine != 1 && sprite_index = spr_idle){
		image_index -= image_speed_raw * (1 - random(shine * current_time_scale));
	}
	if(place_meeting(x, y, Player)){
		RogueChestMaggot_open();
		instance_destroy();
	}

#define RogueChestMaggot_open
	repeat(2){
		with(instance_create(x, y, RoguePickup)){
			speed		= 3;
			direction	= random(360);
		}
	}
	if(array_length(instances_matching(CustomObject, "name", "fr_popoMaggotController")) <= 0){
		mod_script_call("mod", "Frontier_IDPD", "PopoMaggotController_create", x, y);
	}
	mod_script_call("mod", "Frontier_IDPD", "PopoMaggots_spawn", x, y);
	
#define HoarderBag_create(_x, _y)
	with(call(scr.obj_create, _x, _y, "LibChest")){
		name = "fr_HoarderBag";
		
		sprite_index		= global.sprHoarderBag;
		spr_dead			= global.sprHoarderBagOpen;
		spr_open			= sprFXChestOpen
		snd_open    		= sndRogueCanister;
		spr_shadow_y		= 1;
		
		on_open     		= script_ref_create(HoarderBag_open);
		
		
		return self;
	}

#define HoarderBag_open
	instance_create(x, y, PortalClear);
	HoarderBagSpit_create(x, y);
	
#define HoarderBagSpit_create(_x, _y)
	with(instance_create(_x, _y, CustomProp)){
		name = "fr_HoarderBagSpit";
		
		sprite_index		= mskNone;
																													// you know it
		treasureSpits		= ((clamp((8 + irandom(2)) + (GameCont.hard / 2), 1, 100 * (1 + (0.45 * skill_get(mut_open_mind))))) * 1 + (0.3 * skill_get(mut_open_mind)));
		spitDelay			= 0;
		spitAngle			= random(360);
		
		on_step 			= HoarderBagSpit_step;
	}
	
#define HoarderBagSpit_step
	if(spitDelay > 0){
		spitDelay -= current_time_scale;
	} else {
		if(treasureSpits > 0){
			repeat(1 + irandom(1)){
				HoarderBagTreasure_create(x, y, spitAngle + random_range(-20, 20));
				treasureSpits	-= 1;
				spitDelay		+= 1;
				spitAngle		+= 20;
			}
		} else {
			instance_destroy();
		}
	}

#define HoarderBagTreasure_create(_x, _y, _dir)
	// causes errors on v9944 if not using numbers
	#macro WepMimicID		553

		 // Spawn Loot:
		var _lootPool = call(scr.pool, [
	        [[AmmoPickup,				"Basegame", ""],    			clamp(40 - GameCont.hard, 0, 40)],
	        [[HPPickup,					"Basegame", ""],    			clamp(40 - GameCont.hard, 0, 40)],
	        [[BigRad,					"Basegame", ""],    			clamp(20 - GameCont.hard, 0, 40)],
	        [[AmmoChest,				"Basegame", ""],    			12],	 
	    	[[WeaponChest,				"Basegame", ""],    			5],	
	    	[[BigWeaponChest,			"Basegame", ""],    			0.4],	
	        [[HealthChest,				"Basegame", ""],    			4],	    
	        [[RogueChest,				"Basegame", ""],    			1],	  
	        [[RadChest,					"Basegame", ""],    			5],	  
	        [["MealChest_create",		"Mod", mod_current],    		1.5],	   
	        [[Mimic,					"Basegame", ""],    			0.5],
	        [[SuperMimic,				"Basegame", ""],    			0.3],
	        [[WepMimicID,				"Basegame", ""],				(0.3 * (game_version > 0))],
	        [["MealChestMimic_create",	"Mod", mod_current],    		0.1],	 
	        [["TrinketChest_create",	"Mod", "Trinkets"],    			4 * mod_exists("mod", "TreasureTrove")],	 
	        [["BonusAmmoChest", 		"OBJ", "telib"],    			0.8 * mod_exists("mod", "telib")],
	        [["BonusHealthChest",		"OBJ", "telib"],    			0.8 * mod_exists("mod", "telib")],
	        [["CatChest",				"OBJ", "telib"],    			0.5 * mod_exists("mod", "telib")],
	        [["BatChest",				"OBJ", "telib"],    			0.5 * mod_exists("mod", "telib")],
	        [["RatChest",				"OBJ", "telib"],    			0.5 * mod_exists("mod", "telib")],
	        [["OrchidChest",			"OBJ", "telib"],    			0.8 * mod_exists("mod", "telib")],
	        [["RedChest",				"OBJ", "telib"],    			0.4 * mod_exists("mod", "telib")],
	        [["RedAmmoChest",			"OBJ", "telib"],    			0.3 * mod_exists("mod", "telib")],
	        [["HammerHeadChest",		"OBJ", "telib"],    			0.5 * mod_exists("mod", "telib")],
	        [["SpiritChest",			"OBJ", "telib"],    			0.4 * mod_exists("mod", "telib")],
		])
		
		switch(_lootPool[1]){
			case "Basegame": {
				with(instance_create(_x, _y, _lootPool[0])){
					with(mod_script_call("mod", "Frontier_Objects", "ZAxisToss_create", x, y)){
						z				= 8;
						direction   	= _dir;
						speed       	= 2 + random(3);
						zspeed      	= 4 + random(4);
						zfriction		= 0.7;
						creator     	= other;
						depth       	= other.depth;
						mask_index  	= other.mask_index;
						if("spr_shadow_y" in other){
							spr_shadow_y = other.spr_shadow_y;
						}	
					}
					mask_index			= mskNone;
				}
			}
			break;
			case "Mod": {
				with(mod_script_call("mod", _lootPool[2], _lootPool[0], _x, _y)){
					with(mod_script_call("mod", "Frontier_Objects", "ZAxisToss_create", x, y)){
						z				= 8;
						direction   	= _dir;
						speed       	= 2 + random(3);
						zspeed      	= 4 + random(4);
						zfriction		= 0.7;
						creator     	= other;
						depth       	= other.depth;
						mask_index  	= other.mask_index;
						if("spr_shadow_y" in other){
							spr_shadow_y = other.spr_shadow_y;
						}	
					}
					mask_index			= mskNone;
				}
			}
			break;
			case "OBJ": {
				with(mod_script_call("mod", _lootPool[2], "obj_create", _x, _y, _lootPool[0])){
					with(mod_script_call("mod", "Frontier_Objects", "ZAxisToss_create", x, y)){
						z				= 8;
						direction   	= _dir;
						speed       	= 2 + random(3);
						zspeed      	= 4 + random(4);
						zfriction		= 0.7;
						creator     	= other;
						depth       	= other.depth;
						mask_index  	= other.mask_index;
						if("spr_shadow_y" in other){
							spr_shadow_y = other.spr_shadow_y;
						}	
					}
					mask_index			= mskNone;
				}
			}
			break;
		}	

#define DeeplabsCache_create(_x, _y)
	with(instance_create(_x, _y, CustomObject)){
		
		name			= "fr_deeplabsCache";
		
		sprite_index	= global.sprDeeplabsCache;
		spr_opening		= global.sprDeeplabsCacheOpening;
		spr_open		= global.sprDeeplabsCacheOpen;
		spr_done		= global.sprDeeplabsCacheDone;
		image_speed		= 0.4;
		depth			= 1;
		spr_shadow		= global.shdDeeplabsCache;

		mask_index		= global.mskDeeplabsCache;
		opened			= false;
		popTime 		= 30;
		wepSpit 		= 3;
		done			= false;
		hydraulics		= false;
		active			= false;
		openTime		= 150;
		
		on_step 		= DeeplabsCache_step;
		on_draw 		= DeeplabsCache_draw;
		
		return self;
	}
	
	
#define DeeplabsCache_step

	var _getOFF = call(scr.instances_meeting, x, y, [Player, WepPickup]);
	with(_getOFF){
		if(place_meeting(x, y, other)){ 
			motion_add(point_direction(other.x, other.y, x, y) + random_range(-30, 30), 3) 
		}
	}
	
	if(active = true){
		if(openTime > 0){
			openTime -= current_time_scale;
		} else {
			if((distance_to_object(Player) < 32) && (opened = false)){
				opened			= true;
				image_index		= 0;
				sprite_index	= spr_opening;
				sound_play_pitch(sndIDPDNadeAlmost, 0.5)
			}
			if(sprite_index	= spr_opening){
				if(image_index >= 6){
					if(hydraulics = false){
						 // Hydraulics:
						repeat(10){
							with(instance_create(x, y + random_range(-12, 3), Dust)){
								sprite_index	= global.sprWhiteSmoke;
								direction		= choose(90, 270)
								speed			= random(3);
								image_xscale	= 0.5;
								image_yscale	= 0.5;
							}
						}
						sound_play_pitch(sndToxicBoltGas, 0.5 + random(0.1));
						hydraulics = true;
					}
				}
				if(anim_end){
					sprite_index	= spr_open;
					opened			= true;
				}
			}
			if(opened = true && done = false){
				if(popTime >= 0){
					popTime -= current_time_scale;
				} else {
					 // spit out weapons:
					if(wepSpit > 0){
						wepSpit -= 1;
						popTime += 20;
						
						 // check next wep, shuffle is no more repeats
						if(global.deeplabsWepIndex = ds_list_size(global.deeplabsCacheWeps)){
							DeeplabsCache_init();
						}
						
						 // create wep:
						with(instance_create(x, y, WepPickup)){
							wep 		= ds_list_find_value(global.deeplabsCacheWeps, global.deeplabsWepIndex);
							ammo		= 1;
							with(mod_script_call("mod", "Frontier_Objects", "ZAxisWeaponToss_create", x, y)){
								z				= 8;
								direction   	= 90 + random_range(-60, 60);
								speed       	= 2 + random(2);
								zspeed      	= 4 + random(4);
								zfriction		= 0.7;
								creator     	= other;
								depth       	= other.depth;
								mask_index  	= other.mask_index;
								if("spr_shadow_y" in other){
									spr_shadow_y = other.spr_shadow_y;
								}	
							}
							 // convert bulletwep:
							if(skill_get("prismaticiris")){
								if(wep = "FR_TemporalRifle"){
									roll		= true;
									prismatic	= null;
								}
							}
						}
						repeat(5){
							with(instance_create(x, y, Dust)){
								sprite_index	= global.sprWhiteSmoke;
								direction		= 90 + random_range(-35, 35);
								speed			= 5 + random(2);
								image_xscale	= 0.5;
								image_yscale	= 0.5;
								depth			= -11;
							}
						}
						
						sound_play_pitch(sndBouncerShotgun, 1.2 + random(0.2));
						sound_play_pitch(sndGrenadeRifle, 1.8 + random(0.2));
						
						 // next wep
						global.deeplabsWepIndex += 1;
						
					 // fully done:
					} else {
						sprite_index	= spr_done;
						doned			= true;
					}
				}
			}
		}
	}
	
#define DeeplabsCache_draw
	 // i dont wanna use draw_shadows atm
	draw_sprite_ext(spr_shadow, 0, x, y + 10, 1, 1, 0, c_white, 0.4);
	draw_sprite(sprite_index, image_index, x, y);
	
#define DeeplabsCache_init

	global.deeplabsWepIndex		= 0;
	global.deeplabsCacheWeps	= ds_list_create();

	ds_list_add(global.deeplabsCacheWeps, "FR_TemporalRifle");
	ds_list_add(global.deeplabsCacheWeps, "FR_GluonSlugger");
	ds_list_add(global.deeplabsCacheWeps, "FR_Plaguebringer");
	ds_list_add(global.deeplabsCacheWeps, "FR_HiveLauncher");	
	ds_list_add(global.deeplabsCacheWeps, "FR_AR3");
	ds_list_add(global.deeplabsCacheWeps, "FR_Wormhole");
	
	
	ds_list_shuffle(global.deeplabsCacheWeps);
	
#define AugmentAmmoPickup_resprite
		if("fr_augmentAmmoOGSprite" not in self){
			fr_augmentAmmoOGSprite = sprite_index;
		}
		 // only resprite normal ammo pickups
		if(fr_augmentAmmoOGSprite = sprAmmo){
			if("fr_augmentAmmoTier" in self){
				if(fr_augmentAmmoTier >= 1){
					sprite_index = global.sprAugmentAmmoPickup;
				}
				if(fr_augmentAmmoTier >= 2){
					sprite_index = global.sprAugmentAmmoPickupBig;
				}
				if(fr_augmentAmmoTier >= 3){
					sprite_index = global.sprAugmentAmmoPickupHuge;
				}
			}
		}
		
#define AugmentHealthPickup_resprite
		if("fr_augmentHealthOGSprite" not in self){
			fr_augmentHealthOGSprite = sprite_index;
		}
		
		if(skill_get(mut_second_stomach)){
			if("fr_augmentHealthTier" in self){
				fr_augmentHealthTier += 1;
			}
		}
		
		 // only resprite normal ammo pickups
		if(fr_augmentHealthOGSprite = sprHP){
			if("fr_augmentHealthTier" in self){
				if(fr_augmentHealthTier >= 1){
					sprite_index = global.sprAugmentHealthPickup;
				}
				if(fr_augmentHealthTier >= 2){
					sprite_index = global.sprAugmentHealthPickupBig;
				}
				if(fr_augmentHealthTier >= 3){
					sprite_index = global.sprAugmentHealthPickupHuge;
				}
			}
		}

//#endregion
//#region MIMICS
#define MealMimic_create(_x, _y)
	with(instance_create(_x, _y, CustomEnemy)){
		
		 // Visual:
		spr_idle   = global.sprMealMimicIdle;
		spr_walk   = global.sprMealMimicFire;
		spr_hurt   = global.sprMealMimicHurt;
		spr_dead   = global.sprMealMimicDead;
		spr_chrg   = global.sprMealMimicTell;
		spr_shadow = shd24;
		hitid      = [spr_chrg, "MEAL MIMIC"];
		
		 // Sounds:
		snd_hurt = sndMimicHurt;
		snd_dead = sndMimicDead;
		snd_mele = sndMimicMelee;
		snd_tell = sndMimicSlurp;
		
		 // Cursed:
		switch(crown_current){
			case crwn_none   : curse = false;       	break;
			case crwn_curses : curse = (random(3) < 2)	break;
			default          : curse = (random(7) < 1);
		}
		if(curse > 0){
			spr_idle   = global.sprCursedMealMimicIdle;
			spr_walk   = global.sprCursedMealMimicFire;
			spr_hurt   = global.sprCursedMealMimicHurt;
			spr_dead   = global.sprCursedMealMimicDead;
			spr_chrg   = global.sprCursedMealMimicTell;
			hitid      = [spr_chrg, "CURSED MEAL MIMIC"];
		}
		
		 // Vars:
		mask_index  	= -1;
		maxhealth		= 12;
		my_health		= maxhealth;
		raddrop     	= 6;
		size        	= 1;
		maxspeed    	= 2;
		meleedamage 	= 3;
		tell_wait_min	= 90;
		tell_wait_max	= 240;
		meal			= global.mealList[round(random_range(0, array_length_1d(global.mealList) - 1))];
		mealCursed		= curse;
		tk_canBag		= true;
		
		 // Alarms:
		alarm1		= random_range(tell_wait_min, tell_wait_max);
		
		 // Events:
		on_step		= MealMimic_step;
		on_death	= MealMimic_death;
		on_alrm1	= script_ref_create(MealMimic_alrm1);
		
		return self;
	}
	
#define MealMimic_step

	 // Alarms:
	if(alarm1_run) exit;
	
	 // Clamp Speed:
	if(speed > maxspeed){
		speed = maxspeed;
	}
	
	 // Animate:
	if(sprite_index != spr_chrg || anim_end){
		sprite_index = enemy_sprite;
	}
	if(sprite_index != spr_hurt && enemy_target(x, y) && place_meeting(x, y, target)){
		sprite_index = spr_walk;
	}
	
#define MealMimic_alrm1
	alarm1 = random_range(tell_wait_min, tell_wait_max);
	
	 // Tell:
	sprite_index = spr_chrg;
	image_index  = 0;
	sound_play_hit(snd_tell, 0.1);

#define MealMimic_death
	with MealPickup_create(x, y, meal){
		mealCursed	= other.mealCursed;
	}
	
//#endregion
//#region MEAL PICKUPS
#define MealPickup_create(_x, _y, _meal)

	with(instance_create(_x, _y, CustomObject)){
		
		name = "fr_MealPickup";
		
		// im not entirely sure what the issue is, but I can't override this properly, so I had to use the new _meal var.
		// so if you're trying to spawn just random meals go look at what the chest does I guess.
		// meal_index		= global.mealList[round(random_range(0, array_length_1d(global.mealList) - 1))];
		
		 // Choose Meal:
		meal_index		= _meal;
		
		 // Visual:
		sprite_index	= mskNone;
		meal_sprite	    = meal_index.meal_sprite;
		image_index		= meal_index.spr_index;
		ybob			= y;
		mask_index		= mskWepPickup;
		spr_shadow		= shd16;
		image_speed 	= 0;
		depth			= -1;
		
		 // Vars:
		mod2Call		= meal_index.mod2Call;
		script2Call		= meal_index.script2Call;
		meal_name		= meal_index.meal_name;
		meal_text		= meal_index.meal_text;
		mealCursed		= meal_index.mealCursed;
		mealCursedCheck	= false;
		
		 // im sure theres a better way to do multiple effects, but this will work for now, I shouldn't need any more than like 2-3 anyways.
		status1Effect	= meal_index.status1Effect;
		status1Time		= meal_index.status1Time;
		status2Effect	= meal_index.status2Effect;
		status2Time		= meal_index.status2Time;
		status3Effect	= meal_index.status3Effect;
		status3Time		= meal_index.status3Time;
		status4Effect	= meal_index.status4Effect;
		status4Time		= meal_index.status4Time;
		
		
		 // Events:
		with call(scr.prompt_create, "") { 
			on_step 	= MealPickupPrompt_step 
			on_end_step = MealPickupPrompt_end_step;
			meal_name	= other.meal_name;
			meal_text	= other.meal_text;
			creator 	= other;
		}
		on_draw		= MealPickup_draw;
		
		return self;
	}
	
#define meal_init

	 // Meal Map:
	global.MealDirectory = ds_map_create();
	global.defaultMeal = {
		mod2Call	  : "Frontier_StatusEffects",	// Mod to call staus functions from, changeable so others can add their own meals.
		script2Call   : "status_apply_add",			// Script to call from mod2Call.
    	meal_name     : "DEFAULT",					// Meal Name.
    	meal_text	  : "DESCRIPTION",				// Meal Subtext.
    	meal_sprite	  : global.sprMealPickup,		// Meal Sprite.
    	spr_index     : 0,							// Sprite Index (meals are stored on a big strip).
   		mealHot		  : false,						// whether the meal is Hot or not, controls steam effects.
		mealCursed	  : false,						// whether or not a meal is cursed, dont really need to set here.
		
		status1Effect : 'buffBloodLust',			// Meal Effect 1 (check Frontier_StatusEffects for names).
		status1Time   : 60,							// Time effect lasts, in frames.
		status2Effect : undefined,			
		status2Time   : undefined,
		status3Effect : undefined,					// these are the same as the first two effects, don't need to list them if not in use
		status3Time   : undefined,
		status4Effect : undefined, 
		status4Time   : undefined,
	};

	global.MealDirectory[? "none"] = { 
		meal_name		: "EXAMPLE MEAL", 
		meal_text		: "@g+@w2 SECONDS@s OF @(color:2964142)BONUS BLOODLUST", 
		spr_index		: 0, 
		status1Effect	: 'buffBloodLust', 
		status1Time 	: 60
	};
	global.MealDirectory[? "bonusammogain"] = { 
		meal_name		: loc("Frontier:Meal1:Name", "MUNITIONS MUNCHY"), 
		meal_text		: loc("Frontier:Meal1:Text", "@g+@w60 SECONDS @sOF @yBONUS AMMO GAIN"), 
		spr_index		: 1, 
		status1Effect	: 'buffAmmoGain', 
		status1Time 	: 1800
	};
	global.MealDirectory[? "bonusmaxhealth"] = { 
		meal_name		: loc("Frontier:Meal2:Name", "SALUBRIOUS SASHIMI"), 
		meal_text		: loc("Frontier:Meal2:Text", "@g+@w60 SECONDS @sOF @rBONUS MAX HEALTH"), 
		spr_index		: 2, 
		mealHot			: true,
		status1Effect	: 'buffHealthUp', 
		status1Time 	: 1800
	};
	global.MealDirectory[? "bonushealing"] = { 
		meal_name		: loc("Frontier:Meal3:Name", "HEARTY SALAD"), 
		meal_text		: loc("Frontier:Meal3:Text", "@g+@w60 SECONDS @sOF @rBONUS HEALING"), 
		spr_index		: 3, 
		status1Effect	: 'buffBonusHeal', 
		status1Time 	: 1800
	};
	global.MealDirectory[? "reloadspeed"] = { 
		meal_name		: loc("Frontier:Meal4:Name", "SPEEDLOAD SMOOTHIE"), 
		meal_text		: loc("Frontier:Meal4:Text", "@g+@w60 SECONDS @sOF @wBONUS RELOAD SPEED"),
		spr_index		: 5, // we're skipping 4, thats for the burger. 
		status1Effect	: 'buffFirerateUp', 
		status1Time 	: 1800
	};
	global.MealDirectory[? "speedup"] = { 
		meal_name		: loc("Frontier:Meal5:Name", "SAILFISH SLIDERS"), 
		meal_text		: loc("Frontier:Meal5:Text", "@g+@w60 SECONDS @sOF @wBONUS MOVEMENT SPEED"),
		spr_index		: 6, 
		mealHot			: true,
		status1Effect	: 'buffSpeedUp', 
		status1Time 	: 1800
	};
	global.MealDirectory[? "poppop"] = { 
		meal_name		: "JALAPEÑO POPPERS", 
		meal_text		: "@g+@w60 SECONDS @sOF @wSHOT DUPLICATION CHANCE",
		spr_index		: 7,
		mealHot			: true,
		status1Effect	: 'buffPoppop', 
		status1Time 	: 1800
	};
	
	 // Special Meals:
	global.MealDirectory[? "big_burger"] = { 
		meal_name		: loc("Frontier:Meal100:Name", "THE BIG BURGER"), 
		meal_text		: loc("Frontier:Meal100:Text",
						  "@g+@w60 SECONDS @sOF @yBONUS AMMO GAIN#
						   @g+@w60 SECONDS @sOF @rBONUS MAX HEALTH#
						   @g+@w60 SECONDS @sOF @rBONUS HEALING#
						   @g+@w60 SECONDS @sOF @wBONUS RELOAD SPEED#
						   @g+@w60 SECONDS @sOF @wBONUS MOVEMENT SPEED"), 
		spr_index		: 4, 
		status1Effect	: undefined, 
		status1Time 	: undefined,
		mod2Call	    : "Frontier_Pickups",	
		script2Call     : "meal_status_bigburger",		
	};

#define meal_status_bigburger
	with(instance_nearest(x, y, Player)){
    	mod_script_call('mod', "Frontier_StatusEffects", "status_apply_add", instance_nearest(x, y, Player), mod_variable_get('mod', "Frontier_StatusEffects", 'buffAmmoGain'),	1800)
       	mod_script_call('mod', "Frontier_StatusEffects", "status_apply_add", instance_nearest(x, y, Player), mod_variable_get('mod', "Frontier_StatusEffects", 'buffHealthUp'),	1800)
    	mod_script_call('mod', "Frontier_StatusEffects", "status_apply_add", instance_nearest(x, y, Player), mod_variable_get('mod', "Frontier_StatusEffects", 'buffBonusHeal'),	1800)
    	mod_script_call('mod', "Frontier_StatusEffects", "status_apply_add", instance_nearest(x, y, Player), mod_variable_get('mod', "Frontier_StatusEffects", 'buffFirerateUp'), 1800)
    	mod_script_call('mod', "Frontier_StatusEffects", "status_apply_add", instance_nearest(x, y, Player), mod_variable_get('mod', "Frontier_StatusEffects", 'buffSpeedUp'),	1800)
	}
	
#define meal_rank

	 // LIST THEM!
	global.mealList	= [ 
		global.MealDirectory[? "bonusammogain"],
		global.MealDirectory[? "bonusmaxhealth"],
		global.MealDirectory[? "bonushealing"],
		global.MealDirectory[? "reloadspeed"],
		global.MealDirectory[? "speedup"]
	];
	
#define mealCurses_init

	 // Meal Map:
	global.MealCursesDirectory = ds_map_create()
	global.defaultMealCurse = {
		Mod2Call			: "Frontier_StatusEffects",		// Mod to call staus functions from, changeable so others can add their own curses.
		Script2Call			: "status_apply_add",			// Script to call from mod2Call.
		curseStatusEffect	: 'buffBloodLust',
    	curseName   		: "DEFAULT EFFECT",				// Effect Name.
    	curseTime			: [0, 0, 0]						// Effect time options, as an array.
	};

	global.MealCursesDirectory[? "none"] = { 
		curseStatusEffect	: 'buffBloodLust',
    	curseName   		: "BLANK CURSE EFFECT",				
    	curseTime			: [0, 0, 0]										
	};
	global.MealCursesDirectory[? "maxhealthloss"] = { 
		curseStatusEffect	: 'debuffHealthDown',
    	curseName   		: loc("Frontier:MealCurseText:0", "LOST MAX HEALTH"),				
    	curseTime			: [900, 1350, 1800, 2250, 2700]										
	};
	global.MealCursesDirectory[? "blight"] = { 
		curseStatusEffect	: 'debuffBlight',
    	curseName   		: loc("Frontier:MealCurseText:1", "BLIGHT"),				
    	curseTime			: [900, 1050, 1200, 1350, 1500, 1650, 1800]										
	};
	
#define mealCurses_rank

	 // LIST THEM!
	global.mealCursesList	= [ 
		global.MealCursesDirectory[? "maxhealthloss"],
		global.MealCursesDirectory[? "blight"]
	];

#define INCITE_MEAL_HEX

	// I would have just done this in create but it seems like it doesn't work for whatever reason.
	// I guess this may also be useful if theres something that curses pickups and they want to support meals or something idk.

	meal_curse			= global.mealCursesList[round(random_range(0, array_length_1d(global.mealCursesList) - 1))];
			
	 // Vars:
	statusCurseName		= meal_curse.curseName;
	statusCurseTime		= meal_curse.curseTime[irandom(array_length(meal_curse.curseTime) - 1)]
	statusCurseEffect	= meal_curse.curseStatusEffect;
			
	 // Visuals:
	meal_name			= "@q" + string(meal_name); // Shaky Name:
	meal_text			= string(meal_text) + "#@(color:4529874)+@w" + string(statusCurseTime / 30) + " SECONDS @sOF @(color:4529874)" + string(statusCurseName)
	image_blend			= make_colour_rgb(143, 99, 182);
	
#define MealPickupPrompt_step


	 // Cursed:
	if(instance_exists(creator)){
		with(creator){
			if(mealCursed){
				if(random(5) < 1){
					instance_create(x + random_range(-5, 5), y + random_range(-5, 5), Curse);
				}
				if(mealCursedCheck = false){
					mealCursedCheck = true;
					INCITE_MEAL_HEX()
				}
			} else {
				if(random(60) < 1){
					with instance_create(x + random_range(-10, 10), y + random_range(-10, 10), CaveSparkle){
						sprite_index	= global.sprMealSparkle;
						speed			= 0.5;
						direction		= 90;
						depth			= -2;
					}
				}
			}
		}
	}

	 // Use:
	if(pick != -1){
	    
	     // Yum Yum:
    	sound_play_pitchvol(sndBloodlustProc, 0.8, 1)
    	
    	 // Apply Status Effect(s):
		if(creator.status1Effect != undefined){
    		mod_script_call('mod', creator.mod2Call, creator.script2Call, instance_nearest(x, y, Player), 
    		mod_variable_get('mod', creator.mod2Call, creator.status1Effect), creator.status1Time)
		}
		if(creator.status2Effect != undefined){
    		mod_script_call('mod', creator.mod2Call, creator.script2Call, instance_nearest(x, y, Player), 
    		mod_variable_get('mod', creator.mod2Call, creator.status2Effect), creator.status2Time)
		}
		if(creator.status3Effect != undefined){
    		mod_script_call('mod', creator.mod2Call, creator.script2Call, instance_nearest(x, y, Player), 
    		mod_variable_get('mod', creator.mod2Call, creator.status3Effect), creator.status3Time)
		}
		if(creator.status4Effect != undefined){
    		mod_script_call('mod', creator.mod2Call, creator.script2Call, instance_nearest(x, y, Player), 
    		mod_variable_get('mod', creator.mod2Call, creator.status4Effect), creator.status4Time)
		}
		
		 // Special Effects:
		if(creator.status1Effect = undefined){
    		mod_script_call('mod', creator.mod2Call, creator.script2Call)			
		}
		
		 // Curse Effect:
		if(creator.mealCursed = true){
			mod_script_call('mod', creator.mod2Call, creator.script2Call, instance_nearest(x, y, Player), 
    		mod_variable_get('mod', creator.mod2Call, creator.statusCurseEffect), creator.statusCurseTime)
		}
		
		  // Update Stat:
		call(scr.save_set, "Frontier", "meals_eaten", ((call(scr.save_get, "Frontier", "meals_eaten")) + 1))
        
	      // Delete ME!:
		with[creator, self]{ instance_destroy(); }
        
	}
	
#define MealPickupPrompt_end_step
	 // Follow Creator:
	if(creator != noone){
		if(instance_exists(creator)){
			if(instance_exists(nearwep)){
				with(nearwep){
					x += other.creator.x - other.x;
					y += other.creator.y - other.y;
					visible = true;
				}
				if instance_exists(creator){
					script_bind_draw(MealPickup_text, -1000, round(creator.x), round(creator.y), creator.meal_name, creator.meal_text)
				}
			}
			x = creator.x;
			y = creator.y;
		}
		else instance_destroy();
	}

#define MealPickup_draw
	ybob = y + (sin(current_frame * 0.10) * 2);
	draw_sprite_ext(meal_sprite, meal_index.spr_index, x, ybob, image_xscale, image_yscale, image_angle, image_blend, image_alpha)
	
#define MealPickup_text(_x, _y, _mealName, _description)
	instance_destroy()
	
	var halign = draw_get_halign(),
		valign = draw_get_valign(),
		yoff = (6 * round(string_count("#", _description) + 1)) + 22
	
	draw_set_font(fntSmall);
	draw_set_halign(1)
	draw_set_valign(0)
	draw_text_nt(_x, _y - yoff, _description)
	draw_set_font(fntM);
	draw_set_valign(2)
	draw_text_nt(_x, _y - yoff - 1, _mealName)
	draw_set_halign(halign)
	draw_set_valign(valign)

	
//#endregion
//#region FISHING

#define fish_init

	 // Check for LibSaves:
	if(fork()){
		while(!mod_exists("mod", "libSaves")){wait(1);}
	
		 // Fishing Save File:
		 // I probably could leave these all blank and have them autofill, but it might get weirdly that way
		call(scr.save_load, "Frontier_Fishing", {
			fish_caught     		: 0,
			bonefish_caught			: 0,
			bonefish_record			: 0,
			bucket_crab_caught		: 0,
			bucket_crab_record		: 0,
			gator_gar_caught		: 0,
			gator_gar_record		: 0,
			coldsnapper_caught		: 0,
			coldsnapper_record		: 0,
			blue_jelly_caught		: 0,
			blue_jelly_record		: 0,
			green_jelly_caught		: 0,
			green_jelly_record		: 0,
			purple_jelly_caught		: 0,
			purple_jelly_record		: 0,
			crystal_jelly_caught	: 0,
			crystal_jelly_record	: 0,
			dopey_fish_caught		: 0,
			dopey_fish_record		: 0,
			toxfin_caught			: 0,
			toxfin_record			: 0,
			bulbler_caught			: 0,
			bulbler_record			: 0,
			pisces_caught			: 0,
			pisces_record			: 0,
			grey_kingfish_caught	: 0,
			grey_kingfish_record	: 0,
			clownfish_caught		: 0,
			clownfish_record		: 0,
			maggot_fish_caught		: 0,
			maggot_fish_record		: 0,
			holesquid_caught		: 0,
			holesquid_record		: 0,
			clam_caught				: 0,
			clam_record				: 0,
			golden_clam_caught		: 0,
			golden_clam_record		: 0,
			kelpie_caught			: 0,
			kelpie_record			: 0,
			bombino_caught			: 0,
			bombino_record			: 0
		});

		exit;
	}

	 // Fish Map:
	global.FishDirectory = ds_map_create()
	global.defaultFish = {
    	fish_name   : "DEFAULT",	  // Fish Name
    	spr_index   : 0,			  // Sprite Index (fish are stored on a big strip)
  		min_weight	: 0,			  // Maximum Weight
  		max_weight  : 0,		 	  // Minimum Weight
  		save_stat   : "default" 	  // Which Stat to save to:
	};

	// originally these were all formatted nicely like the defaultFish above, but I decided I didn't want like 600 lines of just fish map because of how many there are
	global.FishDirectory[? "none"]				= { fish_name: "NO FISH",			spr_index : 0,	min_weight: 0,	max_weight: 0, save_stat: "none" };
	global.FishDirectory[? "bonefish"]			= { fish_name: "BONEFISH",			spr_index: 1,	min_weight: 12, max_weight: 40, save_stat: "bonefish" };
	global.FishDirectory[? "bucket_crab"]		= { fish_name: "BUCKET CRAB",		spr_index: 2,	min_weight: 5,	max_weight: 30, save_stat: "bucket_crab" };
	global.FishDirectory[? "gator_gar"] 		= { fish_name: "GATOR GAR", 		spr_index: 3,	min_weight: 90, max_weight: 320, save_stat: "gator_gar" };
	global.FishDirectory[? "coldsnapper"]		= { fish_name: "COLDSNAPPER",		spr_index: 4,	min_weight: 20, max_weight: 45, save_stat: "coldsnapper" };
	global.FishDirectory[? "blue_jelly"]		= { fish_name: "BLUE JELLY",		spr_index: 5,	min_weight: 0.5, max_weight: 6, save_stat: "blue_jelly"	};
	global.FishDirectory[? "green_jelly"]		= { fish_name: "GREEN JELLY",		spr_index: 6,	min_weight: 0.5, max_weight: 6, save_stat: "green_jelly" };
	global.FishDirectory[? "purple_jelly"]		= { fish_name: "PURPLE JELLY",		spr_index: 7,	min_weight: 0.5, max_weight: 6, save_stat: "purple_jelly" };
	global.FishDirectory[? "crystal_jelly"] 	= { fish_name: "CRYSTAL JELLY", 	spr_index: 8,	min_weight: 3, max_weight: 12, save_stat: "crystal_jelly" };
	global.FishDirectory[? "dopey_fish"]		= { fish_name: "DOPEY FISH",		spr_index: 9,	min_weight: 100, max_weight: 400, save_stat: "dopey_fish" };
	global.FishDirectory[? "toxfin"]			= { fish_name: "TOXFIN",			spr_index: 10,	min_weight: 4, max_weight: 30, save_stat: "toxfin" };
	global.FishDirectory[? "bulbler"]			= { fish_name: "BULBLER",			spr_index: 11,	min_weight: 30, max_weight: 80, save_stat: "bulbler" };
	global.FishDirectory[? "pisces"]			= { fish_name: "PISCES",			spr_index: 12,	min_weight: 20, max_weight: 50, save_stat: "pisces" };
	global.FishDirectory[? "grey_kingfish"] 	= { fish_name: "GREY KINGFISH", 	spr_index: 13,	min_weight: 50, max_weight: 110, save_stat: "grey_kingfish" };
	global.FishDirectory[? "clownfish"] 		= { fish_name: "CLOWNFISH", 		spr_index: 14,	min_weight: 5, max_weight: 30, save_stat: "clownfish" };
	global.FishDirectory[? "maggot_fish"]		= { fish_name: "MAGGOT FISH",		spr_index: 15,	min_weight: 2, max_weight: 16, save_stat: "maggot_fish" };
	global.FishDirectory[? "holesquid"] 		= { fish_name: "HOLESQUID", 		spr_index: 16,	min_weight: 20, max_weight: 32, save_stat: "holesquid" };
	global.FishDirectory[? "clam"]				= { fish_name: "CLAM",				spr_index: 17,	min_weight: 5, max_weight: 30, save_stat: "clam" };
	global.FishDirectory[? "golden_clam"]		= { fish_name: "GOLDEN CLAM",		spr_index: 18,	min_weight: 15, max_weight: 60, save_stat: "golden_clam" };
	global.FishDirectory[? "kelpie"]			= { fish_name: "KELPIE",			spr_index: 19,	min_weight: 5, max_weight: 35, save_stat: "kelpie" };
	global.FishDirectory[? "bombino"]			= { fish_name: "BOMBINO",			spr_index: 20,	min_weight: 50, max_weight: 140, save_stat: "bombino" };
  
  
  
	global.FishDirectory[? "rainbow_trout"] 	= { fish_name: "RAINBOW TROUT", 	spr_index: 0, min_weight: 20, max_weight: 50, save_stat: "rainbow_trout" };
	global.FishDirectory[? "coelacanth"]		= { fish_name: "COELACANTH",		spr_index: 0, min_weight: 150, max_weight: 220, save_stat: "coelacanth" };
	global.FishDirectory[? "abyss_coelacanth"]	= { fish_name: "ABYSSAL COELACANTH", spr_index: 0, min_weight: 350, max_weight: 530, save_stat: "abyss_coelacanth" };
  
#define fish_rank

	 // TIER THEM!
	global.CommonFish		= [ 
		global.FishDirectory[? "bonefish"], 
		global.FishDirectory[? "bucket_crab"], 
		global.FishDirectory[? "gator_gar"], 
		global.FishDirectory[? "blue_jelly"], 
		global.FishDirectory[? "clam"], 
		global.FishDirectory[? "kelpie"]
	];
	global.UncommonFish 	= [ 
		global.FishDirectory[? "coldsnapper"], 
		global.FishDirectory[? "green_jelly"], 
		global.FishDirectory[? "purple_jelly"], 
		global.FishDirectory[? "toxfin"],
		global.FishDirectory[? "pisces"], 
		global.FishDirectory[? "bombino"]
	];
	
	global.RareFish			= [ 
		global.FishDirectory[? "crystal_jelly"], 
		global.FishDirectory[? "bulbler"], 
		global.FishDirectory[? "clownfish"], 
		global.FishDirectory[? "maggot_fish"],
		global.FishDirectory[? "golden_clam"]
	];
	
	global.UltraFish		= [
		global.FishDirectory[? "dopey_fish"], 
		global.FishDirectory[? "holesquid"] 
	];
	
	
#define FishingPickup_create(_x, _y)

	with(instance_create(_x, _y, CustomObject)){
		
		name = "fr_FishingPickup";
		
		// Put a pool here when theres more than one rarity please
	//	fish_index = global.CommonFish[round(random_range(0, array_length_1d(global.CommonFish) - 1))]
		// here u go
		
		 // Choose Rarity:
		var _FishPool = [
			[global.CommonFish[round(random_range(0, array_length_1d(global.CommonFish) - 1))],     	70],
			[global.UncommonFish[round(random_range(0, array_length_1d(global.UncommonFish) - 1))],     24],
			[global.RareFish[round(random_range(0, array_length_1d(global.RareFish) - 1))],				5],
			[global.UltraFish[round(random_range(0, array_length_1d(global.UltraFish) - 1))], 		    1]
		];

		fish_index = call(scr.pool, _FishPool);
		
		 // Visual:
		sprite_index	= mskNone;
		fish_sprite	    = global.sprFishPickup;
		image_index		= fish_index.spr_index;
		mask_index		= mskBigRad;
		ybob			= y;
		tilt			= 0;
		spr_shadow		= shd16;
		image_speed 	= 0;
		depth			= -1;
		vbob_speed		= random(0.15);
		hbob_speed		= random(0.08);
		deposit_real	= false;
		depositme		= false;
		deposit_x		= x;
		deposit_y		= y;
		my_deposit		= noone;
		
		 // Vars:
		fish_name		= fish_index.fish_name;
		
		var weightnum   = random_range(fish_index.min_weight, fish_index.max_weight)
		var weightdiff  = weightnum - fish_index.min_weight
		var weightcalc	= weightnum - (random(weightdiff) / 2) - (random(weightdiff) / 3)
		var weightfinal	= clamp(round(weightcalc * 100) / 100, fish_index.min_weight, fish_index.max_weight)
		weight			= weightfinal
		weight_text		= string_format(weightfinal, 0, 2) + '@sLB'
		current_record	= (call(scr.save_get, "Frontier_Fishing", fish_index.save_stat + '_record'))


		/*
		trace_color(string(weight), c_yellow)
		trace_color(string(current_record), c_aqua)
		if(weight > current_record){
			trace_color("NEW RECORD", c_lime)
		}
		if(weight < current_record){
			trace_color("NOT A RECORD", c_red)
		}
		*/
		
		
		 // Events:
		with call(scr.prompt_create, "") { 
			mask_index = mskBigRad; 
			on_step 		= FishingPickupPrompt_step; 
			creator 		= other; 
			fish_index		= other.fish_index;
			weight			= other.weight;
			current_record	= other.current_record;
		}
		on_step		= FishingPickup_step
		on_end_step = FishingPickup_end_step;
		on_draw		= FishingPickup_draw;
		
		return self;
	}

#define FishingPickup_step

	ybob = y + (sin(current_frame * vbob_speed) * 3);
	tilt = (sin(current_frame * hbob_speed) * 10);
	
	if (depositme = true){
		if (deposit_real = false){
			repeat(5){
				with instance_create(x, y, Dust){
					speed		= random(5);
					direction	= random(360);
				}
			}
			instance_destroy();
			exit;
		}
		
		if (deposit_real = true){
			motion_add(point_direction(x, y, deposit_x, deposit_y), 0.5)
			if (speed > 10){ speed = 10 }
			tilt = (speed * 10)
			
			with (my_deposit){
				activetime = 10;
			}
			
			if place_meeting(x, y, my_deposit){
				instance_destroy();
			}
		}
	}
		
#define FishingPickupPrompt_step


	 // Use:
	if(pick != -1){
	    
		sound_play_pitchvol(sndBloodlustProc,0.8,1)

				 // STATS!
		var saveFish = fish_index.save_stat;
		 // Generic Fish Caught Stat += 1
		call(scr.save_set, "Frontier_Fishing", "fish_caught", ((call(scr.save_get, "Frontier_Fishing", "fish_caught")) + 1)) 
		 // Specific Fish Caught Stat += 1
		call(scr.save_set, "Frontier_Fishing", saveFish+'_caught', ((call(scr.save_get, "Frontier_Fishing", saveFish+'_caught')) + 1)) 
	
		 // New Record!
    	if (weight > current_record) { 
    		call(scr.save_set, "Frontier_Fishing", saveFish + '_record', string_format(weight, 0, 2)); 
    	
    		 // First Catch!
    		if call(scr.save_get, "Frontier_Fishing", saveFish + '_caught') = 1 {
    			with instance_create(x, y, PopupText){
    				mytext = loc("Frontier:Fishing:0", "FIRST CATCH!");
    			}
    		}
    		else{
    	    	with instance_create(x, y, PopupText){
    				mytext = loc("Frontier:Fishing:1", "NEW RECORD!");
    			}		
    		}
    	
    		sound_play(sndPartyHorn)
    		repeat(30){
    			with instance_create(x, y, Confetti){
    				speed		= random(5)
    				direction	= random(360)
    				z			= random(3)
    			}
    		}
    	}
		
	      // Consume:
		with(creator){
			depositme = true;
		}
	}
	
	if (!instance_exists(creator)){
		instance_destroy();
	}
	
#define FishingPickup_end_step

	if (instance_place(x, y, Player)){
		script_bind_draw(FishingPickup_text, -11, x, y, fish_name, weight_text, instance_nearest(x, y, Player))
	}

#define FishingPickup_text(_x, _y, _fish_name, _weight, _player)
	instance_destroy()
	
	
	var halign = draw_get_halign(),
		valign = draw_get_valign();
		
	var	yoff = (6 * round(string_count("#", _weight) + 1)) + 22,
	replacey = yoff - (6 * round(string_count("#", _weight) + 1)) - 12,
	xtextoff = 0;
	
	draw_set_font(fntSmall);
	draw_set_halign(1)
	draw_set_valign(0)
	draw_text_nt(_x + xtextoff, _y - yoff, _weight)
	draw_set_font(fntM);
	draw_set_valign(2)
	draw_text_nt(_x + xtextoff, _y - yoff - 1, _fish_name)
	draw_set_halign(halign)
	draw_set_valign(valign)

#define FishingPickup_draw
	draw_sprite_ext(fish_sprite, fish_index.spr_index, x, ybob, image_xscale, image_yscale, tilt, image_blend, image_alpha)

//#endregion
//#region GENERAL FUNCTIONS

 // Used for Finalizing lists of items, for things like meals and fish.
#define list_finalize(_directory, _defaultItem)
  var keys = ds_map_keys(_directory),
      len  = array_length(keys),
      _item,
      _defkeys = [],
      _defvalues = [],
      _defn = 0;
  for var o = 0; o < lq_size(_defaultItem); o++ {
      array_push(_defkeys, lq_get_key(_defaultItem, o))
      array_push(_defvalues, lq_get_value(_defaultItem, o))
  }
  for var i = 0; i < len; i++ {
      _item = _directory[? keys[i]];
      _item.key = keys[i]
      _defn = 0
      with _defkeys {
          lq_set(_item, self, lq_defget(_item, self, _defvalues[_defn++]))
      }
  }
  
#define approach(a, b, n, dn)
	return (b - a) * (1 - power((n - 1)/n, dn)) 
  
#define generic_trail_create(_x, _y) 
    with instance_create(_x, _y, Wind){
        sprite_index     = global.sprGenericTrail;
        mask_index       = mskNone;
        image_speed      = 2;
        image_yscale     = (1/50);
        image_xscale     = 1;
        depth			 = 0;
        
        return self;
    }
    
#define TrinketChest_create(_x, _y)
	mod_script_call("mod", "Trinkets", "TrinketChest_create", _x, _y)
    
#macro  target_visible                                                                          !collision_line(x, y, target.x, target.y, Wall, false, false)
#macro  target_direction                                                                        point_direction(x, y, target.x, target.y)
#macro  target_distance                                                                         point_distance(x, y, target.x, target.y)
#macro  anim_end																				((image_index + image_speed_raw) >= image_number || (image_index + image_speed_raw) < 0)
#macro  enemy_sprite                                                                            (sprite_index != spr_hurt || anim_end) ? ((speed == 0) ? spr_idle : spr_walk) : sprite_index
#macro  alarm0_run                                                                              alarm0 && !--alarm0 && !--alarm0 && (script_ref_call(on_alrm0) || !instance_exists(self))
#macro  alarm1_run                                                                              alarm1 && !--alarm1 && !--alarm1 && (script_ref_call(on_alrm1) || !instance_exists(self))
#macro  alarm2_run                                                                              alarm2 && !--alarm2 && !--alarm2 && (script_ref_call(on_alrm2) || !instance_exists(self))
#define enemy_target(_x, _y)                                                            		target = (instance_exists(Player) ? instance_nearest(_x, _y, Player) : ((instance_exists(target) && target >= 0) ? target : noone)); return (target != noone);

//#endregion
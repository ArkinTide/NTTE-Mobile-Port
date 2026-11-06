#define init

	 // LIB:
	while(!mod_exists("mod", "lib")){wait(1);}
	script_ref_call(["mod", "lib", "getRef"], "mod", mod_current, "scr");
	#macro  scr			global.scr
	#macro  call		script_ref_call

		// SPRITES (and Sounds!) //
	 // Oasis Statue:
	global.sprOasisStatue					= sprite_add("../sprites/areas/oasis/props/sprOasisStatue.png", 				1, 32, 16);	
	global.sprOasisStatueHurt				= sprite_add("../sprites/areas/oasis/props/sprOasisStatueHurt.png", 			3, 32, 16);	
	global.sprOasisStatueDead				= sprite_add("../sprites/areas/oasis/props/sprOasisStatueDead.png", 			3, 32, 16);
	global.sprOasisStatueActive				= sprite_add("../sprites/areas/oasis/props/sprOasisStatueActive.png",			5, 32, 16);	
	global.sprOasisDust						= sprite_add("../sprites/particles/sprOasisDust.png",							5, 8, 8);
	global.sprOasisSparkle					= sprite_add("../sprites/particles/sprOasisSparkle.png",						5, 8, 8);
	global.mskOasisStatuePrompt				= sprite_add("../sprites/areas/oasis/props/mskOasisStatuePrompt.png", 			1, 40, 32);	
	
	 // Gilding Station:
	global.sprGoldExchanger					= sprite_add("../sprites/areas/venuz/props/sprGoldExchanger.png",				1, 16, 16);			
	global.sprGoldExchangerHurt				= sprite_add("../sprites/areas/venuz/props/sprGoldExchangerHurt.png",			3, 16, 16);	
	global.sprGoldExchangerDead				= sprite_add("../sprites/areas/venuz/props/sprGoldExchangerDead.png",			3, 16, 16);	
	global.sprGoldExchangerSwap				= sprite_add("../sprites/areas/venuz/props/sprGoldExchangerSwap.png",			6, 16, 16);	
	
	 // Honk Honk:
	global.sprCarHeadlights					= sprite_add("../sprites/areas/scrapyard/sprCarHeadlights.png",					2, 16, 16);	
	global.sprCarLight						= sprite_add("../sprites/areas/scrapyard/sprCarLight.png",						1, 32, 24);	
	global.sndCarHonk						= sound_add("../sounds/props/sndCarHonk.ogg");	
	
	 // Hoarder:
	global.sprHoarderIdle					= sprite_add("../sprites/enemies/hoarder/sprHoarderIdle.png",					6, 24, 24);	
	global.sprHoarderWalk					= sprite_add("../sprites/enemies/hoarder/sprHoarderWalk.png",					6, 24, 24);	
	global.sprHoarderHurt					= sprite_add("../sprites/enemies/hoarder/sprHoarderHurt.png",					3, 24, 24);	
	global.sprHoarderDead					= sprite_add("../sprites/enemies/hoarder/sprHoarderDead.png",					6, 24, 24);	
	global.sprHoarderScare					= sprite_add("../sprites/enemies/hoarder/sprHoarderScare.png",					5, 24, 24);	
	global.sprHoarderSprint					= sprite_add("../sprites/enemies/hoarder/sprHoarderSprint.png",					4, 24, 24);	
	global.sprHoarderEscape					= sprite_add("../sprites/enemies/hoarder/sprHoarderEscape.png",					20, 24, 24);	
	global.sprHoarderBell					= sprite_add("../sprites/particles/sprHoarderBell.png", 						4, 3, 3);	
	global.sndHoarderLoop					= sound_add("../sounds/enemies/hoarder/sndHoarderLoop.ogg");
	global.sndHoarderStop					= sound_add("../sounds/enemies/hoarder/sndHoarderStop.ogg");
	global.sndHoarderJingle	= [				sound_add("../sounds/enemies/hoarder/sndHoarderJingle.ogg"),
											sound_add("../sounds/enemies/hoarder/sndHoarderJingle2.ogg"),
											sound_add("../sounds/enemies/hoarder/sndHoarderJingle3.ogg")]
	
	 // Projectiles and Effects:
	global.sprBurdenSparkle					= sprite_add("../sprites/particles/sprBurdenSparkle.png",						4, 8, 8);
	global.sprSurgerySparkle				= sprite_add("../sprites/particles/sprSurgerySparkle.png",						4, 8, 8);
	
	global.sprBetaSurgeryStation			= sprite_add("../sprites/areas/vault/sprBetaSurgeryStation.png",				2, 11, 7);		
	
	 // Slaughter B
	global.sprSlaughterBIcon				= sprite_add("../sprites/allies/SlaughterB/sprPetSlaughterBIcon.png",				1, 6, 6);	
	global.sprSlaughterBIdle				= sprite_add("../sprites/allies/SlaughterB/sprPetSlaughterBIdle.png",				4, 12, 12);	
	global.sprSlaughterBWalk				= sprite_add("../sprites/allies/SlaughterB/sprPetSlaughterBWalk.png",				6, 12, 12);	
	global.sprSlaughterBHurt				= sprite_add("../sprites/allies/SlaughterB/sprPetSlaughterBHurt.png",				3, 12, 12);	
	global.sprSlaughterBDead				= sprite_add("../sprites/allies/SlaughterB/sprPetSlaughterBDead.png",				10, 24, 24);	
	global.sprSlaughterBSpwn				= sprite_add("../sprites/allies/SlaughterB/sprPetSlaughterBSpwn.png",				7, 24, 24);	
	global.sprSlaughterBBite				= sprite_add("../sprites/allies/SlaughterB/sprPetSlaughterBBite.png",				6, 8, 12);	
	global.sprSlaughterBTransform			= sprite_add("../sprites/allies/SlaughterB/sprSlaughterBTransform.png",			4, 16, 12);	
	
	
	
		// WEAPON EXCHANGER LISTS //
	// these are needed for the basegame weapons, modded weps just have a define u can set (listed above array).
	
	// update: i changed how this works for the treasure mimic, and i think it works better
	// i dont really need to update the gold one at all atm so im not going to bother
	
		// Example Weapon Swap Array:
	// define wep_exchange_template
	global.fr_exchange_example							= [];
	global.fr_exchange_example							= array_clone(array_create(128, null));
	//global.arrayname[inputweapon]						= outputweapon
	global.fr_exchange_example[wep_double_shotgun]		= wep_double_flame_shotgun
	global.fr_exchange_example[wep_shotgun] 			= wep_flame_shotgun
	
		// GILDING STATION CONVERSIONS:
	// define wep_exchange_gold
	global.fr_exchange_gold								= [];
	global.fr_exchange_gold								= array_clone(array_create(128, null));
	global.fr_exchange_gold[wep_revolver]				= wep_golden_revolver
	global.fr_exchange_gold[wep_wrench] 				= wep_golden_wrench
	global.fr_exchange_gold[wep_machinegun] 			= wep_golden_machinegun
	global.fr_exchange_gold[wep_shotgun] 				= wep_golden_shotgun
	global.fr_exchange_gold[wep_crossbow] 				= wep_golden_crossbow
	global.fr_exchange_gold[wep_grenade_launcher] 		= wep_golden_grenade_launcher
	global.fr_exchange_gold[wep_laser_pistol] 			= wep_golden_laser_pistol
	global.fr_exchange_gold[wep_plasma_gun] 			= wep_golden_plasma_gun
	global.fr_exchange_gold[wep_slugger] 				= wep_golden_slugger
	global.fr_exchange_gold[wep_splinter_gun] 			= wep_golden_splinter_gun
	global.fr_exchange_gold[wep_screwdriver] 			= wep_golden_screwdriver
	global.fr_exchange_gold[wep_bazooka] 				= wep_golden_bazooka
	global.fr_exchange_gold[wep_assault_rifle] 			= wep_golden_assault_rifle
	global.fr_exchange_gold[wep_nuke_launcher] 			= wep_golden_nuke_launcher
	global.fr_exchange_gold[wep_disc_gun] 				= wep_golden_disc_gun

#define ZAxisToss_create(_x, _y)
	with(instance_create(_x, _y, CustomObject)){
		
		 // Visuals:
		depth       	= -2;
		mask_index  	= mskPlayer;
		spr_shadow_y	= 0;
		
		 // Vars:
		direction		= random(360);
		friction		= 0.1;
		creator 		= noone;
		z       		= 0;
		zspeed  		= 8;
		zfriction		= 0.5;
		team    		= -1;
		portalGuy		= false;
		impactEffect	= true;
		
		 // Events:
		on_end_step		= script_ref_create(ZAxisToss_end_step);
		on_cleanup		= script_ref_create(ZAxisToss_cleanup);
		
		return self;
	}
	
#define ZAxisToss_end_step

	 // Zzzz Zzzz Zzzz Mimimimimi:
	z += zspeed * current_time_scale;
	zspeed -= zfriction * current_time_scale;
	
	if(instance_exists(creator) && (z > 0 || zspeed > 0)){
		
			
			// Don't go over walls:
		if(place_meeting(x + hspeed_raw, y + vspeed_raw, Wall) || distance_to_object(InvisiWall) < 16){
			speed = 0;	
			 // also fall faster so it doesn't look as weird:
			z += (zspeed * current_time_scale) / 2
		} else {
			 // Cap Speed otherwise:
			speed = clamp(speed, 2, 6);
		}
		
		with(creator){
			 // Can't touch me! I'm all the way up here!
			x			= other.x;
			y			= other.y - other.z;
			mask_index	= mskNone;
			depth		= -10;
			 
			 // Don't Die if out of bounds:
			if(instance_is(self, enemy)){
				canfly = true;
			}
			
			 // Shadow for Enemies/Props:
			if("spr_shadow_y" in self){
				spr_shadow_y = other.spr_shadow_y + other.z;
			}
			
			 // Aerodynamic:
			var _ang = point_direction(0, 0, other.hspeed, -other.zspeed) - 90;
		
			if("angle" in self){
				angle = _ang;	
			} else { 
				image_angle = _ang;
			}
	
			 // Portal Increase:
			if(other.portalGuy = true){
				sprite_index = spr_hurt;
				image_index  = 1;
				if(image_xscale < 1){
					image_xscale += 0.1;
					image_yscale = image_xscale;
				}
			}
		}
	}
	else{
		script_ref_call(on_cleanup);
		on_cleanup = [];
		
		with(creator){
			 // Damage:
			if(instance_is(self, hitme) && (place_meeting(x, y, Floor) || GameCont.area != "coast")){
				with(other){
					projectile_hit(other, 1);
				}
			}
			
			 // Failsafe
			if(other.portalGuy = true){
				if(image_xscale < 1){
					image_xscale = 1;
					image_yscale = image_xscale;
				}
			}
			
			 // On Walls:
			if(!place_meeting(x, y, Floor) || place_meeting(x, y, Wall)){
				instance_create(x, y, PortalClear)
			}
		}
		
		 // Effects:
		if(impactEffect = true){
			repeat(5 + variable_instance_get(creator, "size", 0)){
				with(instance_create(x, y, Dust)){
					motion_add(random(360), 3);
					motion_add(other.direction, 1);
				}
			}
		}
		
		instance_destroy();
	}
	
#define ZAxisToss_cleanup
	 // Reset Vars:
	with(creator){
		mask_index = other.mask_index;
		depth = other.depth;
		if("spr_shadow_y" in self) spr_shadow_y = other.spr_shadow_y;
		if("angle" in self) angle = 0;
		else image_angle = 0;
		if(instance_is(self, enemy) && place_meeting(x, y, Floor)){
			canfly = false;
		}
	}
	
#define ZAxisWeaponToss_create(_x, _y)
	with(instance_create(_x, _y, CustomObject)){
		
		 // Visuals:
		depth       	= -2;
		mask_index  	= mskPlayer;
		spr_shadow_y	= 0;
		
		 // Vars:
		direction		= random(360);
		friction		= 0.1;
		creator 		= noone;
		z       		= 0;
		zspeed  		= 8;
		zfriction		= 0.5;
		team    		= -1;
		impactEffect	= true;
		landangle		= random(360);
		
		 // Events:
		on_end_step		= script_ref_create(ZAxisWeaponToss_end_step);
		on_cleanup		= script_ref_create(ZAxisWeaponToss_cleanup);
		
		return self;
	}
	
#define ZAxisWeaponToss_end_step

	 // Zzzz Zzzz Zzzz Mimimimimi:
	z += zspeed * current_time_scale;
	zspeed -= zfriction * current_time_scale;
	
	if(instance_exists(creator) && (z > 0 || zspeed > 0)){
		
			
			// Don't go over walls:
		if(place_meeting(x + hspeed_raw, y + vspeed_raw, Wall)){
			speed = 0;	
			 // also fall faster so it doesn't look as weird:
			z += (zspeed * current_time_scale) / 2
		} else {
			 // Cap Speed otherwise:
			speed = clamp(speed, 2, 6);
		}
		
		with(creator){
			 // Can't touch me! I'm all the way up here!
			x			= other.x;
			y			= other.y - other.z;
			mask_index	= mskNone;
			depth		= -10;
			
			 // Aerodynamic:
			var _ang = point_direction(0, 0, other.hspeed, -other.zspeed) - other.landangle;
			rotation = _ang;
		}
	}
	else{
		script_ref_call(on_cleanup);
		on_cleanup = [];
		
		with(creator){
			 // On Walls:
			if(!place_meeting(x, y, Floor) || place_meeting(x, y, Wall)){
				instance_create(x, y, PortalClear)
			}
		}
		
		 // Effects:
		if(impactEffect = true){
			repeat(5){
				with(instance_create(x, y, Dust)){
					motion_add(random(360), 3);
					motion_add(other.direction, 1);
				}
			}
		}
		
		instance_destroy();
	}
	
#define ZAxisWeaponToss_cleanup
	 // Reset Vars:
	with(creator){
		mask_index = other.mask_index;
		depth = other.depth;
		if("spr_shadow_y" in self) spr_shadow_y = other.spr_shadow_y;
		if("angle" in self) angle = 0;
		else image_angle = 0;
		if(instance_is(self, enemy) && place_meeting(x, y, Floor)){
			canfly = false;
		}
	}
	
#macro burden_splashtexts choose("JINKIES!", "YIKES!", "UH OH!", "OH NO", "WOAH!", "EEK!", "AHH!!", "AIEEE!!!")	
#define SpecialPopupText_create(_x, _y, _text, _subtext)
	with(instance_create(_x, _y, CustomObject)){
		
		name			= "fr_popup"
		
		 // Visual:
		depth			= -1000;
		image_angle		= 0;
		
		 // Normal Text:
		text			= _text;
		text_color		= c_white;
		lifetime		= 100;
		shake			= 6;
		
		 // Subtext:
		subtext			= _subtext;
		sub_color		= c_white;
		sub_lifetime 	= 80;
		sub_shake		= 6;
		sub_sound		= sndRecGlandProc
		sub_sound_pitch = 1.75;
	
		on_draw			= SpecialPopupText_draw;
		on_step     	= SpecialPopupText_step;
		
		return self;
	}

#define SpecialPopupText_step

	lifetime -= current_time_scale
	
	 // Shake n Bake:
	shake = max(shake - current_time_scale, 0)
	if(lifetime < sub_lifetime){
		sub_shake = max(sub_shake - current_time_scale, 0)
		if(sub_shake = 6 - current_time_scale){
			sound_play_pitch(sub_sound, sub_sound_pitch);
		}
	}
	 // Destroy:
	if lifetime <= 0 instance_destroy()

#define SpecialPopupText_draw
	var align = draw_get_halign()
	draw_set_halign(1)
	if (lifetime > 30) or (lifetime mod 3 < 2) {
		draw_text_tilt_shadow(x + random(shake), y + random(shake), text, image_angle, text_color)

		if (lifetime < sub_lifetime) {
			draw_text_tilt_shadow(x + random(sub_shake) + lengthdir_x(8, image_angle - 90), y + random(sub_shake) + lengthdir_y(8, image_angle - 90), subtext, image_angle, sub_color)
		}
	}
	draw_set_halign(align)

#define draw_text_tilt_shadow(x, y, str, angle, color)
	draw_text_transformed_color(x + 1, y + 1, str, 1, 1, angle, c_black, c_black, c_black, c_black, 1)
	draw_text_transformed_color(x, y, str, 1, 1, angle, color, color, color, color, 1)	

#define SpecialPopupTextJinkies_create(_x, _y)
	with(SpecialPopupText_create(_x , _y ,"", burden_splashtexts)){
		sub_lifetime	= 60;
		image_angle		= 5;
		sub_color		= c_gray;
		sub_sound_pitch = 0;
		
		return self;
	}

#define OasisStatue_create(_x, _y, _level)
	with(instance_create(_x, _y, CustomProp)){
		
		name = "fr_OasisStatue";
		
		 // Visual:
		spr_idle		= global.sprOasisStatue;
		spr_hurt		= global.sprOasisStatueHurt;
		spr_dead		= global.sprOasisStatueDead;
		spr_active		= global.sprOasisStatueActive;
		sprite_index	= spr_idle;
		spr_shadow		= mskNone;
		image_speed 	= 0.4;
		right			= 1;
		image_xscale	= 1;
		
		  // Vars:
		snd_hurt		= sndOasisHurt;
		snd_dead		= sndOasisExplosionSmall;
		hard_level		= _level;
		activated		= false;
		text			= loc("Frontier:OceanStatuePrompt",	"ACTIVATE?");
		use_text		= loc("Frontier:OceanStatueText:0", "DIFFICULTY LEVEL");
		use_subtext		= loc("Frontier:OceanStatueText:1", "RESTORED");
		burden_text		= loc("Frontier:OceanStatueText:2", "BURDENED WITH");
		burden_subtext	= loc("Frontier:OceanStatueText:3", "PELAGIC#PREDICAMENT");
		pick			= -1;
		maxhealth		= 200;
		my_health		= maxhealth;
		VAGGYBONDESPLSNOSHOOT = true;
		giveDifficulty	= mod_exists("area", "oasis") ? false : true;
		
		if activated	= true { 
			spr_idle = spr_active 
		}
		
		on_step	= OasisStatue_step;
		on_hurt = Prop_hurt;
		
		 // Events:
		with call(scr.prompt_create, text) { 
			mask_index	= global.mskOasisStatuePrompt;
			on_step 	= OasisStatuePrompt_step; 
			creator 	= other; 
		}
		
		return self;
	}
	
#define OasisStatuePrompt_step
	if pick != -1 { with (creator) { pick = 1; } }
	if !instance_exists(creator) { exit; }
	if (creator.activated) = true { instance_destroy() }
	
#define OasisStatue_step
	x = xstart;
	y = ystart;
	speed = 0;
	
	 // Animate:
	if(anim_end){
		sprite_index = spr_idle;
	}
	
	 // Bubbles:
	if (random(15) < 1){ with instance_create(x + 8,  y  - 3, Bubble){ friction = 0.2; motion_set(90 + random_range(-5,5), random_range(3, 5)); } }
	if (random(15) < 1){ with instance_create(x + 6,  y  - 10,Bubble){ friction = 0.2; motion_set(90 + random_range(-5,5), random_range(3, 5)); } }
	if (random(15) < 1){ with instance_create(x - 20, y  - 9, Bubble){ friction = 0.2; motion_set(90 + random_range(-5,5), random_range(3, 5)); } }
	
	 // ACTIVATE!
	if(pick != -1 and activated = false){
		 // Statue Effects:
		activated = true;
		spr_idle = spr_active;
		view_shake_at(x, y, 100)
		repeat(20) { with instance_create(x,y,Bubble){ direction = random(360); speed = random(5); } }
		repeat(20) { with instance_create(x + random_range(-30,30),y + random_range(-20,20),CaveSparkle){ direction = random(360); speed = random(3); sprite_index = global.sprOasisSparkle; image_angle = random(360); } }
		repeat(20) { with instance_create(x + random_range(-35,30),y + 13,Smoke){ direction = random(360); speed = random(2); sprite_index = global.sprOasisDust } }

		 // Sounds:
		sound_play_pitchvol(sndStrongSpiritLost,0.7,1)
		sound_play_pitchvol(sndOasisBossMelee,0.6,1)
		
		if(giveDifficulty = true){
			 // Game Changers:
			GameCont.hard += hard_level;
			
			   // Texts:
			   // Difficulty:
			with SpecialPopupText_create(x ,y - 60 , use_text, use_subtext){
				sub_lifetime = 100;
				sub_color	 = make_colour_rgb(81, 209, 200);
			}
		}
		
		if !skill_get("BurdenPelagicPredicament"){
			// Burden Text:
			with SpecialPopupText_create(x ,y - 40 , burden_text, burden_subtext){
				sub_color	 = make_colour_rgb(81, 209, 200);
				sub_sound	 = sndCursedReminder;
			}
			// Yikes!
			with SpecialPopupText_create(x + 50 ,y - 25 ,"", burden_splashtexts){
				sub_lifetime	= 60;
				image_angle		= 5;
				sub_color		= c_gray;
				sub_sound_pitch = 0;
			}
		
			// Give Burden:
			skill_set("BurdenPelagicPredicament", 1)
			
        	// Particles on Take:
    		with(Player){
	    		with(instance_create(x, y, ImpactWrists)){ 
	    			image_blend = make_colour_rgb(136, 86, 180); 
	    			depth = -3; 
	    		}
				repeat(8){ 
					with(instance_create(x + random_range(-16, 16), y + random_range(-16, 16), BulletHit)){
						sprite_index	= global.sprBurdenSparkle;
						image_index		= choose(0, 1);
						image_xscale	= random_range(0.5, 1);
						image_yscale	= image_xscale;
						direction		= 90 + random_range(-32, 32);
						speed			= random(3);
					}
	        	}
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
	
#define weapon_can_exchange(_wep, _array)
return (is_real(_wep) && floor(_wep) == _wep && _wep < 128 && _array[_wep] != null);
	
#define WeaponExchangerPrompt_step
	if(pick != -1){ 
		with(creator){ 
			pick = 1; 
		} 
	}
	if !instance_exists(creator){ 
		exit; 
	}
	if (creator.canswap = false){ 
		instance_destroy() 
	}
	
#define WeaponExchangerGold_create(_x, _y)
	with(instance_create(_x, _y, CustomHitme)){
		
		name = "fr_GoldExchanger";
		
		var me = self;
		
		 // Visual:
		spr_idle		= global.sprGoldExchanger;
		spr_hurt		= global.sprGoldExchangerHurt;
		spr_dead		= global.sprGoldExchangerDead;
		spr_swap		= global.sprGoldExchangerSwap;
		spr_deny		= global.sprGoldExchanger;
		sprite_index	= spr_idle;
		spr_shadow		= shd64;
		spr_shadow_y	= 6;
		image_speed 	= 0.4;
		depth			= 0;
		
		  // Vars:
		snd_hurt		= sndHitMetal;
		snd_dead		= sndComputerBreak;
		text			= "@(color:3844043)EXCHANGE#@wWEAPON?";
		pick			= -1;
		targetplayer	= noone;  // Player who is trading:
		playerwep		= noone;  // They weapon:
		outputwep		= noone;  // What to spit back out:
		validwep		= true;   // Checks if valid weapon was given:
		canswap			= true;   // Checks if can swap right now:
		maxhealth		= 200;
		my_health		= maxhealth;
		team			= 0;
		VAGGYBONDESPLSNOSHOOT = true;
		
		 // Prompt:
		with call(scr.prompt_create,text) { 
			on_step = WeaponExchangerPrompt_step; creator = me;
		}
		
		 // Events:
		on_step	= WeaponExchangerGold_step;
		on_hurt = Prop_hurt;
		
		return self;
	}
	
#define WeaponExchangerGold_step

	x = xstart;
	y = ystart;
	speed = 0;
	var me = self;

	 // Animate:
	if(anim_end){
		sprite_index = spr_idle;
	}
	
	 // Use Prop:
	if(pick != -1) and (canswap = true){
		
		
		// Target Nearest Player and Disable Prompt:
		targetplayer = instance_nearest(x, y, Player)
		playerwep	 = targetplayer.wep
		if(targetplayer.curse = 1){
			sound_play(sndCursedReminder);
			pick = -1;
			exit;
		}
		validwep	 = false;
		canswap		 = false;
		
		// Valid Weapon:
		if targetplayer.wep != 0 and weapon_can_exchange(playerwep,global.fr_exchange_gold) or (is_string(playerwep) and mod_script_exists("weapon",playerwep,"wep_exchange_gold")) {
			
			// Set Sprite and Eat Your Weapon:
			sprite_index	 = spr_swap;
			targetplayer.wep = wep_none;
			validwep		 = true;
			with(targetplayer){
				player_swap(self)
				swapmove  = true;
				drawempty = 30;
			}
			
			 // Check Modded Weapon for Funny Script:
			if is_string(playerwep){
				if mod_script_exists("weapon",playerwep,"wep_exchange_gold"){
					outputwep = mod_script_call("weapon",playerwep,"wep_exchange_gold")	
				}
			}
			 // Basegame Weapon:
			else { outputwep = global.fr_exchange_gold[playerwep] }
			
			sound_play_pitchvol(sndGoldUnlock,1.2,2);
		
		}
		
		

		// No Valid Weapon: (DENIED!!)
		else { 
			sound_play_pitchvol(sndVanHurt, 1.2, 1);
			sound_play_pitchvol(sndExplosionS, 1.8, 0.6)
			repeat(5){ 
				with instance_create(x, y, Smoke){ 
					direction = random(360); 
					speed = random(3); 
				} 
			}
			sprite_index = spr_deny
			validwep     = false;
			
			with(instance_create(other.x, other.y, PopupText)) { mytext = "NOT VENUZ#APPROVED!" }
		}

		// After Animation Ends:
		wait(image_number / image_speed)
		
		// Spit Out Weapon:
		if (validwep = true) {
			with instance_create(x, y, WepPickup){ 
				wep 		= other.outputwep; 
				direction	= 270; 
				speed		= 6; 
				repeat(15){ 
					with instance_create(x, y, CaveSparkle){ 
						direction	= 270 + random_range(-70, 70); 
						image_angle = random(360); 
						speed		= random(3); 
						depth		= -2; 
					} 
				}
				repeat(15){ 
					with instance_create(x, y, Feather) {
						sprite_index	= sprMoney;
						image_angle 	= random(360);
						motion_set(random(360), random_range(2, 4));
					}
				}
			}
		}
		
		// Back to Normal: 
		sprite_index	= spr_idle;
		canswap 		= true;
		pick			= -1;
		
		// New Prompt:
		with call(scr.prompt_create,text) { on_step = WeaponExchangerPrompt_step; creator = me; }
		
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

#define player_swap(_player)
	/*
		Cycles the given player's weapon slots
	*/
	
	with(["%wep", "%curse", "%reload", "%wkick", "%wepflip", "%wepangle", "%can_shoot", "%clicked", "%interfacepop", "drawempty%"]){
		var	_name = [string_replace(self, "%", ""), string_replace(self, "%", "b")],
			_temp = variable_instance_get(_player, _name[0], 0);
			
		variable_instance_set(_player, _name[0], variable_instance_get(_player, _name[1], 0));
		variable_instance_set(_player, _name[1], _temp);
	}

#define CarHonkController_create(_x, _y, _owner)
	with(instance_create(_x, _y, CustomObject)){
		name = "fr_CarHonkController"
		
		 // Visual:
		sprite_index	= global.sprCarHeadlights;
		spr_light		= global.sprCarLight;
		image_xscale	= _owner.image_xscale;
		depth			= -1;
		image_speed 	= 0;
		lightsOn		= false;
		
		 // Vars:
		mask_index  	= mskNone;
		owner			= _owner;
		active			= false;
		honkTime		= 0;
		mySound			= noone;
		honkOffset		= irandom_range(-6, 6)
		
		 // Go Go Go:
		on_step 		= CarHonkController_step;
		on_draw 		= CarHonkController_draw;
		
		return self;
	}
	
#define CarHonkController_step
	if(!instance_exists(owner)){
		instance_destroy();
		exit;
	} else {
		if(owner.nexthurt >= current_frame + 4){ 
			if(random(3) < 1){
				active = true;
			}
		}
		x = owner.x;
		y = owner.y
	}
	if(active = true){
		honkTime -= current_time_scale;
		if(honkTime <= 0){
			lightsOn	= false;
			image_index	= 0;
		}
		if(every(30 + honkOffset)){
			mySound 	= sound_play_pitch(global.sndCarHonk, 1 + orandom(0.02))
			lightsOn	= true;
			honkTime	= 15;
			image_index	= 1;
		}
		if(instance_exists(Player)){
			var _nearestPlayer	= instance_nearest(x, y, Player),
				_dis			= distance_to_object(_nearestPlayer),
				_honkVol		= (320 - _dis) / 320;
			sound_volume(mySound, clamp(1 * _honkVol, 0, 10));
		}
	}
	
#define CarHonkController_draw
	if(instance_exists(owner)){
		if(owner.nexthurt >= current_frame + 4){ 
			d3d_set_fog(1, c_white, 0, 0);
		}
	}
	draw_self();
	d3d_set_fog(0, 0, 0, 0);

#define PortalPusher_create(_x, _y, _dis)
	with(instance_create(_x, _y, CustomObject)){
		name = "fr_PortalPusher"
		
		 // Visual:
		sprite_index	= mskNone;
		
		 // Vars:
		mask_index  	= mskNone;
		portalDis		= _dis;
		
		 // Go Go Go:
		on_step 		= PortalPusher_step;
		
		return self;
	}	

#define PortalPusher_step
	if(distance_to_object(Portal) < portalDis){
		if(current_frame_active){
			with(instance_nearest(x, y, Portal)){
				motion_add(point_direction(other.x, other.y, x, y) + random_range(-30, 30), 0.4);
				friction = 0.3;
			}
		}
	}
	
#define BetaSurgeryStation_create(_x, _y, _skill)
	with(instance_create(_x, _y, CustomObject)){
		
		name = "fr_SurgeryStation";
		
		 // Visual:
		sprite_index	= global.sprBetaSurgeryStation;
		fr_glow			= [48, 64];
		image_speed 	= 0;
		depth			= -1;
		
		 // Vars:
		mask_index		= mskWepPickup;
		text			= "";
		opened			= false;
		pick			= -1;
		newskill		= _skill;
		surgeryname 	= "SURGERY NAME";
		description 	= "@sSURGERY DESCRIPTION";
		
		
		image_index	= !skill_get(newskill) ? 0 : 1;
		
		 // Working...:
		if(!skill_get(newskill)){
			on_step 		= script_ref_create(BetaSurgeryStation_step);
			on_end_step 	= script_ref_create(BetaSurgeryStation_end_step);
			with call(scr.prompt_create, text) { 
				on_step 		= BetaSurgeryStationPrompt_step;
				creator 		= other;
			}
		}
		
		return self;
	}

#define BetaSurgeryStation_spawn(_x, _y, _skill)
	 // Make Station:
	with(BetaSurgeryStation_create(_x,_y, _skill)){
		if(!skill_get(_skill)){
			mod_script_call("skill", _skill, "surgery_setup");
		}
		surgeryname = mod_script_call("skill", _skill, "skill_name");
		description = mod_script_call("skill", _skill, "skill_text");
	}

#define BetaSurgeryStationPrompt_step
	if(pick != -1){ 
		with(creator){
			pick = 1;
		}
		instance_destroy();
	}
	
#define BetaSurgeryStation_step
	x		= xstart;
	y		= ystart;
	speed	= 0;
	
	 // Use Station:
	if((pick != -1) && (opened = false)){			
    	 // Set Station Object Vars:
    	opened			= true;
    	image_index		= 1;
    	name			= "fr_AugmentStationOpened";

    	skill_set(newskill, 1);
    	
    	 // Update Stat:
		call(scr.save_set, "Frontier", "surgeries_received", ((call(scr.save_get, "Frontier", "surgeries_received")) + 1));
   
    	 // Sounds:
		sound_play_pitch(sndBloodLauncher, 0.8 + random(0.3));
    
    	 // Particles on Take:
		with(Player){
    		with(instance_create(x, y, ImpactWrists)){ 
    			image_blend = make_colour_rgb(88, 15, 22); 
    			depth = -3; 
    		}
			repeat(8){ 
				with(instance_create(x + random_range(-16, 16), y + random_range(-16, 16), BulletHit)){
					sprite_index	= global.sprSurgerySparkle;
					image_index		= choose(0, 1);
					image_xscale	= random_range(0.5, 1);
					image_yscale	= image_xscale;
					direction		= 90 + random_range(-32, 32);
					speed			= random(3);
				}
        	}
    	}

	}
	

	
#define BetaSurgeryStation_end_step
	var _fadeIn = 0;
	
	if(opened = false) && instance_place(x, y, Player){
		script_bind_draw(BetaSurgeryStation_text, -1000, x, y, surgeryname, description, instance_nearest(x, y, Player))
		_fadeIn = 0.4;
	}

	if(opened = false){
		script_bind_draw(BetaSurgeryStation_effects, -10, x, y, newskill, _fadeIn, instance_nearest(x, y, Player))		
	}
	
#define BetaSurgeryStation_effects(_x, _y, _newskill, _fadeIn)
var _bob = sin(current_frame * 0.1) * 2,
	_rotBob = sin(current_frame * 0.2) * 8,
	_holoBob = sin(current_frame * 0.05) * 0.15,
	_icon = call(scr.skill_get_icon, _newskill),
	_spr  = _icon[0],
	_img  = _icon[1];
	
	draw_sprite_ext(_spr, _img, _x, _y - 32 + _bob , 1, 1, 0 + _rotBob, c_white, 0.6 + _fadeIn)
	instance_destroy()
	
#define BetaSurgeryStation_text(_x, _y, _surgeryName, _description, _player)
	
	var _bob = sin(current_frame * 0.1) * 1
	
	var _halign = draw_get_halign(),
		_valign = draw_get_valign();
		
	var	_yoff = (16 * round(string_count("#", _description) + 1)) + 28 + _bob,
		_xtextoff = 0;
	
	draw_set_font(fntSmall);
	draw_set_halign(1)
	draw_set_valign(0)
	draw_text_nt(_x + _xtextoff, _y - _yoff, _description)
	draw_set_font(fntM);
	draw_set_valign(2)
	draw_text_nt(_x + _xtextoff, _y - _yoff - 1, _surgeryName)

	draw_set_halign(_halign)
	draw_set_valign(_valign)
	
	instance_destroy();

#define Hoarder_create(_x, _y)
	with(instance_create(_x, _y, CustomEnemy)){
   
    	name = "Hoarder"
    	
         // Visuals: 
        spr_idle		= global.sprHoarderIdle;
		spr_walk		= global.sprHoarderWalk;
		spr_hurt		= global.sprHoarderHurt;
		spr_dead		= global.sprHoarderDead;
		spr_scare		= global.sprHoarderScare;
		spr_sprint		= global.sprHoarderSprint;
		spr_leave		= global.sprHoarderEscape;
		sprite_index    = spr_idle;
		image_speed     = 0.4;
		depth           = -2;
		hitid           = [spr_idle, "HOARDER"]
        spr_shadow      = shd24;	
        spr_shadow_y	= 5;
        fr_glow			= [20, 30];
        
         // Sounds:
        snd_hurt		= global.sndHoarderJingle[2];
        snd_dead		= global.sndHoarderStop;
        snd_loop		= global.sndHoarderLoop;
        
         // Vars:
        mask_index  	= mskBandit;
        direction   	= random(360);
        maxhealth   	= 32;
       	my_health   	= maxhealth;
        raddrop     	= 8;
        maxspeed    	= 3;
        walkspeed   	= maxspeed;
        sprintspeed 	= 5.5;
        size			= 2;
        team        	= 1; 
        targetvisible	= 0;
        target      	= 0;
        walk        	= 0;
        panic			= false;
        chaseTime		= 120;
        leaving 		= false;
        dropLoot		= true;
        getOut			= false;
        myDanger		= null;
        leaveIndex		= 0;
        lastJingle		= -1;
        
         // Alarms:
        alarm1 = 30 + irandom(10);
        alarm2 = 0;

         // Events:
        on_step  = script_ref_create(Hoarder_step);
        on_draw  = BasicEnemy_draw;
        on_hurt  = Hoarder_hurt;
        on_death = Hoarder_death;
        on_alrm1 = script_ref_create(Hoarder_alrm1);
        
		Hoarder_jingle(lastJingle, 1280);	
        
        return self;
	}

#define Hoarder_step

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

	if(panic = true){
		
		if(current_frame_active){
			if(random(5) < 1) && (leaveIndex = 0){
				instance_create(x, y, Sweat);
			}
		}
		
		chaseTime -= current_time_scale;
		if(chaseTime <= 0){
			if(audio_is_playing(snd_loop)){
				sound_play(global.sndHoarderStop);
				sound_stop(snd_loop);
			}
			leaving = true;
			walk	= 0;
			if(sprite_index	!= spr_leave){
				image_index		= 0;
				sprite_index	= spr_leave;
			} else{
				leaveIndex		= image_index;
				if(anim_end){
					my_health	= 0;
					exit;
				}
				if(chaseTime <= -40 && getOut = false){
					getOut = true;
					image_index	= 14;
				}
				if(image_index >= 14 && dropLoot = true){
					mask_index	= mskNone;
					spr_dead	= mskNone;
					dropLoot	= false;
					snd_dead	= -1;
					kills		= 0;
					raddrop 	= 0;
					canfly		= true;
					spr_shadow	= mskNone;
					getOut		= true;
			
					sound_play_pitchvol(sndExplosionS, 1.4 + random(0.1), 0.3);
					sound_play_pitchvol(sndBurn, 1.4 + random(0.1), 0.6);
					
					repeat(10){
						with(mod_script_call("mod", "Frontier_Projectiles", "WhiteSmoke_create", x, y)){
							image_xscale	= 0.5 + random(0.5);
							image_yscale	= image_xscale;
							direction		= random(360);
							speed			= 1 + random(2);
						}
					}
				}
			}
		} else {
			if(instance_exists(Player) && speed > 3){
				if(!audio_is_playing(snd_loop)){
					snd_loop = sound_play(global.sndHoarderLoop);
				}
				var _nearestPlayer	= instance_nearest(x, y, Player),
					_dis			= distance_to_object(_nearestPlayer),
					_sprintVol		= (640 - _dis) / 640;
				sound_volume(snd_loop, clamp(1 * _sprintVol, 0, 10));
			}
		}
	} else {
		
		if(chance(1, 100)){
			Hoarder_jingle(lastJingle, 320);
		}
		
		var _nearestProjectile = call(scr.instance_nearest_array, x, y, instances_matching_ne(projectile, "team", team));
		if((distance_to_object(Player) < 128 && target_visible) || (distance_to_object(_nearestProjectile) < 96) || my_health < maxhealth){
			panic			= true;
			image_index		= 0;
			sprite_index	= spr_scare;
			spr_walk		= spr_sprint
			maxspeed		= sprintspeed;
			alarm1			= 13;
			walk			= 0;
			
			sound_play_pitch(sndMutant6Slct, 2)
		}
	}

		 // Animate:
	if(sprite_index != spr_scare && sprite_index != spr_leave || anim_end){
		sprite_index = enemy_sprite;
	}
	right = (direction + 270) mod 360 > 180 ? 1 : -1;
	
#define Hoarder_alrm1
	alarm1 = 20 + irandom(10);
	if(leaving = false){
		if(enemy_target(x, y) && panic = true){
			var _nearestProjectile = call(scr.instance_nearest_array, x, y, instances_matching_ne(projectile, "team", team));
			var _nearestPlayer = instance_nearest(x, y, Player);
			
			if(distance_to_object(_nearestProjectile) < distance_to_object(_nearestPlayer)){
				myDanger = _nearestProjectile;
			} else {
				myDanger = _nearestPlayer;
			}
			enemy_walk(point_direction(x, y, myDanger.x, myDanger.y) + 180 + random_range(-30, 30), alarm1);
		} else {
			 // Wander:
			alarm1 = 40 + irandom(15);
			enemy_walk(random(360), alarm1 - 10);
			enemy_look(direction);
		}
	}

#define Hoarder_hurt(_dmg, _spd, _dir)
	sprite_index = spr_hurt;
	image_index  = 0;
	
	if(chance(1, 4)){
		var _object = choose(AmmoPickup, HPPickup, BigRad);
		with(instance_create(x, y, _object)){
			with(mod_script_call("mod", "Frontier_Objects", "ZAxisToss_create", x, y)){
				z				= 8;
				direction   	= random(360);
				speed       	= 2;
				zspeed      	= 4;
				zfriction		= 0.7;
				creator     	= other;
				depth       	= other.depth;
				mask_index  	= other.mask_index;
				if("spr_shadow_y" in other){
					spr_shadow_y = other.spr_shadow_y;
				}	
			}
			mask_index	= mskNone;
		}
	}
	audio_sound_pitch(sound_play_hit(sndMutant6Slct, 0.5), 2.3);
	motion_add(_dir, 5);
	
	nexthurt   = current_frame + 6;
	my_health -= _dmg;
	
#define Hoarder_death
	if(dropLoot = true){
		with(mod_script_call("mod", "Frontier_Pickups", "HoarderBag_create", x, y)){
			with(mod_script_call("mod", "Frontier_Objects", "ZAxisToss_create", x, y)){
				z				= 8;
				direction   	= random(360);
				speed       	= 2;
				zspeed      	= 4;
				zfriction		= 0.7;
				creator     	= other;
				depth       	= other.depth;
				mask_index  	= other.mask_index;
				if("spr_shadow_y" in other){
					spr_shadow_y = other.spr_shadow_y;
				}	
			}
			mask_index	= mskNone;
		}
		
		 // you got them
		call(scr.save_set, "Frontier", "hoarder_kills", ((call(scr.save_get, "Frontier", "hoarder_kills")) + 1));
		
		repeat(6 + irandom(6)){
			HoarderBell_create(x, y);
		}
	} else {
		 // you suck
		call(scr.save_set, "Frontier", "hoarder_escapes", ((call(scr.save_get, "Frontier", "hoarder_escapes")) + 1));
	}
	if(audio_is_playing(snd_loop)){
		sound_play(global.sndHoarderStop);
		sound_stop(snd_loop);
	}
	
#define Hoarder_jingle(_lastJingle, _maxDis)

	if(instance_exists(Player)){
		var _nearestPlayer	= instance_nearest(x, y, Player),
			_dis			= distance_to_object(_nearestPlayer),
			_jingleVol		= (_maxDis - _dis) / _maxDis;
			
		 // reduce repeat sounds:
		var _sound = irandom(array_length(global.sndHoarderJingle) - 1);
		if(_sound = _lastJingle){
			_sound = irandom(array_length(global.sndHoarderJingle) - 1);
		}
		
		lastJingle = _sound;
	
		sound_play_pitchvol(global.sndHoarderJingle[_sound], 1 + random(0.15), _jingleVol)
	}
		
	
#define HoarderBell_create(_x, _y)
	with instance_create(_x, _y, CustomObject){
		sprite_index	= global.sprHoarderBell;
		image_index		= irandom(image_number);
		image_speed		= 0;
		image_angle		= random(360);
		
		speed			= 1 + random(4);
		friction		= 0.2;
		direction		= random(360);
		lifetime		= 120;
		
		on_step			= HoarderBell_step;
		
		return self;
	}

#define HoarderBell_step
	if(lifetime > 0){
		lifetime -= current_time_scale;
	} else {
		image_alpha -= 0.07 * current_time_scale;
		if(image_alpha <= 0){
			instance_destroy();
		}
	}
	
#define SlaughterBSkinner_create(_x, _y)
	with(instance_create(_x, _y, CustomObject)){
		name = "fr_slaughterskinner";
		
		on_step 	= SlaughterBSkinner_step;
	}
	
#define SlaughterBSkinner_step
	with(instances_matching(instances_matching(CustomHitme, "name", "NTTEPet"), "fr_slaughterskinner", null)){
		if(leader != noone){
			fr_slaughterskinner = true;
			if(pet = "Slaughter"){
				if(instance_exists(leader)){
					if(leader.race = "bubbles" && leader.bskin = 1){
						SlaughterB_applyskin();
					}
				}
			}
		}
	}

#define SlaughterB_applyskin
	mod_script_call("mod", "petlib", "pet_set_skin", self, ["mod", "Frontier_Objects", "SlaughterSkeleton"])
	
	with(instance_create(x, y, BulletHit)){
		sprite_index	= global.sprSlaughterBTransform;
		depth			= -3;
	}
	sound_play_pitchvol(sndStrongSpiritLost, 1.2, 1)
	
	fr_skeletonized = true;

#define SlaughterSkeleton_sprite(_name)
	switch(_name){
		case "icon"       : return global.sprSlaughterBIcon;
		case "idle"       : return global.sprSlaughterBIdle;
		case "walk"       : return global.sprSlaughterBWalk;
		case "hurt"       : return global.sprSlaughterBHurt;
		case "dead"       : return global.sprSlaughterBDead;
		case "spwn"       : return global.sprSlaughterBSpwn;
		case "fire"       : return global.sprSlaughterBBite;
		case "shadow_y"   : return -2;
		case "bubble"     : return -1;
		case "bubble_pop" : return -1;
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
#define every(_num)																				return frac(current_frame/_num) < current_time_scale/_num
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
    
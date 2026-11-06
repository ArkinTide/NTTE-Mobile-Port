#define init

	 // Sprites:
	global.sprSkillIcon 					= sprite_add("../sprites/mutations/sprAugmentOpenMind.png", 1, 12, 16)
	global.sprSkillHud  					= sprite_add("../sprites/mutations/sprAugmentOpenMindIcon.png", 1, 8, 9)
	global.sprBeacon						= sprite_add("../sprites/areas/hq/sprBeacon.png", 6, 16, 8)
	global.sprBeaconRadius					= sprite_add("../sprites/areas/hq/sprBeaconRadius.png", 1, 60, 60)
	global.sprPopoFireFly					= sprite_add("../sprites/particles/sprPopoFireFly.png", 13, 0, 0)
	
	global.sprGreenBeacon					= sprite_add("../sprites/areas/hq/sprGreenBeacon.png", 6, 16, 8)
	global.sprGreenBeaconRadius				= sprite_add("../sprites/areas/hq/sprGreenBeaconRadius.png", 1, 60, 60)
	global.sprGreenPopoFireFly				= sprite_add("../sprites/particles/sprGreenPopoFireFly.png", 13, 0, 0)

	global.level_start						= (instance_exists(GenCont) || instance_exists(Menu));
	global.settingGreenAugments				= false;

	 // LIB:
	while(!mod_exists("mod", "lib")){wait(1);}
	script_ref_call(["mod", "lib", "getRef"], "skill", mod_current, "scr");
	#macro  scr			global.scr
	#macro  call		script_ref_call
	
#define skill_name			return loc("Frontier:AugmentOpenMind:0", "CONVERSENT GUIDANCE");
#define skill_text			return loc("Frontier:AugmentOpenMind:1", "@wEMPOWERING @(color:16776960)BEACONS#@wSPAWN @sIN LEVELS");
#define skill_tip			return "TRULY GOOD PLACEMENT";
#define skill_button		sprite_index = global.sprSkillIcon;
#define skill_icon			return global.sprSkillHud;
#define skill_avail			return (mod_variable_get("mod", "Frontier_IDPD", "settingMainPoolAugments") = true) ? 1 : 0;
#define skill_wepspec		return 1;
#define skill_sacrifice		return false;
#define skill_augment		return mut_open_mind;

#define skill_take
	with(Player){
		if("fr_buffAugmentBeacon_ammo" not in self){ 
			fr_buffAugmentBeacon_ammo		= false; 
			fr_inbeacon 					= false; 
			fr_buffAugmentBeacon_prevhealth	= my_health;
		}
	}
	global.level_start = false;
	
#define step
	if(instance_exists(GenCont) || instance_exists(Menu)){
		global.level_start = true;
	}
	else if(global.level_start){
		global.level_start = false;
		repeat(3 * skill_get(mod_current)) {
			with (call(scr.instance_random, instances_matching(Floor, "object_index", Floor))){ 
				Beacon_create(x + 16, y + 16)
			}
		}
	}
	
#define Beacon_create(_x, _y)
	with(instance_create(_x, _y, CustomObject)){
		
		name			= "fr_AugmentBeacon"
		
		 // Visual
		sprite_index	= (global.settingGreenAugments ? global.sprGreenBeacon			: global.sprBeacon);
		spr_radius		= (global.settingGreenAugments ? global.sprGreenBeaconRadius	: global.sprBeaconRadius);
		spr_firefly		= (global.settingGreenAugments ? global.sprGreenPopoFireFly 	: global.sprPopoFireFly);
		mask_index		= mskEnemyBullet1;
		image_speed		= 0.4;
        fr_glow			= [70, 94];
		
		 // Work:
		on_step			= Beacon_step;
		on_draw 		= Beacon_draw;
		
		with(instance_create(x, y, ImpactWrists)){ 
			image_blend = make_colour_rgb(0, 255, 255); 
			depth		= -3; 
		}
		
		return self;
	}

#define Beacon_step
	// Some of Particle:
	if(random(6) < 1){
		with(instance_create(x + random_range(-40, 40), y + random_range(-40, 40), FireFly)){ 
			sprite_index = other.spr_firefly;
		}
	}
	
	// Status Effect:
	with(Player){ 
		if(distance_to_object(other) <= 60){
			fr_inbeacon = true;
			status_apply_beaconed(self, 3)
		}
		else{ 
			fr_inbeacon = false; 
		}	
	}
	
	// Buff Pickups
	with(instances_matching(AmmoPickup, "fr_augmentBeaconed", null)){
		if(distance_to_object(other) <= 60){
			fr_augmentBeaconed = true;

			 // Stats:
			num += 0.5;
			
			 // Resprite:
			if("fr_augmentAmmoTier" not in self){
				fr_augmentAmmoTier = 0;
			}
			fr_augmentAmmoTier += 1;
			mod_script_call("mod", "Frontier_Pickups", "AugmentAmmoPickup_resprite")
			
			 // Effect:
			with(instance_create(x, y, ImpactWrists)){ 
				image_blend 		= (global.settingGreenAugments ? make_colour_rgb(0, 255, 0) : make_colour_rgb(0, 255, 255));
				depth				= -3; 
				image_xscale		= 0.4; 
				image_yscale		= image_xscale;
			}			
		}
	}
	
	with(instances_matching(HPPickup, "fr_augmentBeaconed", null)){
		if(distance_to_object(other) <= 60){
			fr_augmentBeaconed = true;
			
			 // Stats:
			num	+= 1;
			
			 // Resprite:
			if("fr_augmentHealthTier" not in self){
				fr_augmentHealthTier = 0;
			}
			fr_augmentHealthTier += 1;
			mod_script_call("mod", "Frontier_Pickups", "AugmentHealthPickup_resprite")
			
			 // Effect:
			with(instance_create(x, y, ImpactWrists)){ 
				image_blend 		= (global.settingGreenAugments ? make_colour_rgb(0, 255, 0) : make_colour_rgb(0, 255, 255));
				depth				= -3; 
				image_xscale		= 0.4; 
				image_yscale		= image_xscale;
			}			
		}
	}

	
#define Beacon_draw
	var beaconsine = sin(current_frame * 0.02) * 0.9;
	
	draw_sprite_ext(shd24, 1, x, y - 8, 1, 1.5, 0, c_white, 0.2)
	draw_self()
	draw_sprite_ext(spr_radius, 1, x, y, 1 + random(0.02), 1 + random(0.02), 0, c_white, 0.5)
	draw_sprite_ext(spr_radius, 1, x, y, 1.06 + random(0.02), 1.06 + random(0.02), 0, c_white, 0.3)
	draw_sprite_ext(spr_radius, 1, x, y, beaconsine, beaconsine, 0, c_white, 0.2)

#define status_apply_beaconed(_target, _duration)
	mod_script_call(
		'mod', 'Frontier_StatusEffects', 
		'status_apply_set', 
		_target, 
		mod_variable_get('mod', 'Frontier_StatusEffects', 'buffAugmentBeacon'), 
		_duration
	)
		
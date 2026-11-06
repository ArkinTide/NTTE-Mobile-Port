#define init

	 // Sprites:
	global.sprSkillIcon 					= sprite_add("../sprites/mutations/sprAugmentRabbitPaw.png", 1, 12, 16);
	global.sprSkillHud  					= sprite_add("../sprites/mutations/sprAugmentRabbitPawIcon.png", 1, 8, 8);
	
	global.settingGreenAugments				= false;
	
#define skill_name			return loc("Frontier:AugmentRabbitPaw:0", "MICRO REFINERY");
#define skill_text			return loc("Frontier:AugmentRabbitPaw:1", "@wSOME PICKUPS @sARE @(color:16776960)UPGRADED");
#define skill_tip			return "FROM TRASH TO TREASURE";
#define skill_button		sprite_index = global.sprSkillIcon;
#define skill_icon			return global.sprSkillHud;
#define skill_avail			return (mod_variable_get("mod", "Frontier_IDPD", "settingMainPoolAugments") = true) ? 1 : 0;
#define skill_wepspec		return 0;
#define skill_sacrifice		return false;
#define skill_augment		return mut_rabbit_paw; 
	
#define step
	 // Upgrade Ammo:
	with(instances_matching(AmmoPickup, "fr_augmentRabbitPaw_check", null)){
		fr_augmentRabbitPaw_check	= true;
		
		if(random(4) < 1){
			
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
	
	 // Upgrade Medkits:
	with(instances_matching(HPPickup, "fr_augmentRabbitPaw_check", null)){
		fr_augmentRabbitPaw_check	= true;
		if(random(5) < 2){
			
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

    

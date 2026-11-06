#define init

	 // Sprites:
	global.sprSkillIcon 					= sprite_add("../sprites/mutations/sprAugmentSecondStomach.png", 1, 12, 16);
	global.sprSkillHud  					= sprite_add("../sprites/mutations/sprAugmentSecondStomachIcon.png", 1, 8, 8);
	
#define skill_name			return loc("Frontier:AugmentSecondStomach:0", "SHELLULAR DIVISION");
#define skill_text			return loc("Frontier:AugmentSecondStomach:1", "@wMORE @yAMMO @sFROM PICKUPS");
#define skill_tip			return "TWICE AS NICE";
#define skill_button		sprite_index = global.sprSkillIcon;
#define skill_icon			return global.sprSkillHud;
#define skill_avail			return (mod_variable_get("mod", "Frontier_IDPD", "settingMainPoolAugments") = true) ? 1 : 0;
#define skill_wepspec		return 0;
#define skill_sacrifice		return false;
#define skill_augment		return mut_second_stomach; 
	
#define step

	 // Upgrade Ammo:
	with(instances_matching(AmmoPickup, "fr_augmentSecondStomach_check", null)){
		fr_augmentSecondStomach_check	= true;

			 // Stats:
			num += 0.5;
			
			 // Resprite:
			if("fr_augmentAmmoTier" not in self){
				fr_augmentAmmoTier = 0;
			}
			fr_augmentAmmoTier += 1;
			mod_script_call("mod", "Frontier_Pickups", "AugmentAmmoPickup_resprite")

	}

    

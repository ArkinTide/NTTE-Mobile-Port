#define init

	 // Sprites:
	global.sprSkillIcon 					= sprite_add("../sprites/mutations/sprAugmentEagleEyes.png", 1, 12, 16);
	global.sprSkillHud  					= sprite_add("../sprites/mutations/sprAugmentEagleEyesIcon.png", 1, 8, 8);

#define skill_name			return loc("Frontier:AugmentEagleEyes:0", "HURRICANE ROCKET SYSTEM");
#define skill_text			return loc("Frontier:AugmentEagleEyes:1", "@wCHANCE TO FIRE @(color:16776960)MICROMISSILES#@wWHEN SPENDING OR GAINING @yAMMO");
#define skill_tip			return "SOPHISTICATED TRACKING SOFTWARE";
#define skill_button		sprite_index = global.sprSkillIcon;
#define skill_icon			return global.sprSkillHud;
#define skill_avail			return (mod_variable_get("mod", "Frontier_IDPD", "settingMainPoolAugments") = true) ? 1 : 0;
#define skill_wepspec		return 1;
#define skill_sacrifice		return false;
#define skill_augment		return mut_eagle_eyes; 
	
#define step
	with(Player){
		 // apply vars if u die
		if("fr_augmentEagleEyes_chanceBoost" not in self){
			fr_augmentEagleEyes_prevBullet	= ammo[1];
			fr_augmentEagleEyes_prevShell	= ammo[2];
			fr_augmentEagleEyes_prevExplo	= ammo[3];
			fr_augmentEagleEyes_prevBolt	= ammo[4];
			fr_augmentEagleEyes_prevEnergy	= ammo[5];
			fr_augmentEagleEyes_chanceBoost	= 0;
		}
		
		 // i was going to just check to see if 'ammo' was different but its like cursed or something it kept updating the var by itself when i tried it. the devil.
		 // check if ammo changed:
		if(ammo[1] != fr_augmentEagleEyes_prevBullet) ||
		(ammo[2] != fr_augmentEagleEyes_prevShell) ||
		(ammo[3] != fr_augmentEagleEyes_prevExplo) ||
		(ammo[4] != fr_augmentEagleEyes_prevBolt) ||
		(ammo[5] != fr_augmentEagleEyes_prevEnergy){
			 // update ammo value:
			fr_augmentEagleEyes_prevBullet	= ammo[1];
			fr_augmentEagleEyes_prevShell	= ammo[2];
			fr_augmentEagleEyes_prevExplo	= ammo[3];
			fr_augmentEagleEyes_prevBolt	= ammo[4];
			fr_augmentEagleEyes_prevEnergy	= ammo[5];			

			 // fire rocket:
        	if(random(8 - fr_augmentEagleEyes_chanceBoost) < skill_get(mod_current)){
				with(mod_script_call("mod", "Frontier_Projectiles2", "PopoRocketSmall_create", x, y)){
					team		= other.team;
					direction	= other.gunangle + (random_range(-8, 8) * other.accuracy);
					image_angle	= direction;
				}			
				fr_augmentEagleEyes_chanceBoost = 0;
        	} else { // increase fire chance per fail
        		fr_augmentEagleEyes_chanceBoost += 1;
        	}
		}
	}
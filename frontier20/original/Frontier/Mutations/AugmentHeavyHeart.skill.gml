#define init

	 // Sprites:
	global.sprSkillIcon 					= sprite_add("../sprites/mutations/sprAugmentHeavyHeart.png", 1, 12, 16);
	global.sprSkillHud  					= sprite_add("../sprites/mutations/sprAugmentHeavyHeartIcon.png", 1, 8, 8);

#define skill_name			return loc("Frontier:AugmentHeavyHeart:0", "ARMAMENT EJECTOR");
#define skill_text			return loc("Frontier:AugmentHeavyHeart:1", "@sFRESH @wWEAPON DROPS#@sFIRE @(color:16776960)MICROMISSILES");
#define skill_tip			return "I LOVE RECYCLING!!";
#define skill_button		sprite_index = global.sprSkillIcon;
#define skill_icon			return global.sprSkillHud;
#define skill_avail			return (mod_variable_get("mod", "Frontier_IDPD", "settingMainPoolAugments") = true) ? 1 : 0;
#define skill_wepspec		return 0;
#define skill_sacrifice		return false;
#define skill_augment		return mut_heavy_heart; 
	
#define step

	with(instances_matching(WepPickup, "fr_augmentHeavyHeart", undefined)){
		fr_augmentHeavyHeart = true;
		if(ammo > 0){
			AugmentMissileController_create(x, y)
		}
	}
    
#define AugmentMissileController_create(_x, _y)
	sound_play_pitchvol(sndRocketFly, 1.4, 2)
	with(instance_create(_x, _y, CustomObject)){
		sprite_index	= mskNone;
		var myPlayer	= instance_nearest(x, y, Player)
		team			= myPlayer.team;
		missiles		= (8 * skill_get(mod_current))
		
		on_step			= AugmentMissileController_step;
	}
	
#define AugmentMissileController_step
	if(missiles > 0){
	missiles -= (4 * current_time_scale)
		repeat(4){
			with(mod_script_call("mod", "Frontier_Projectiles2", "PopoRocketSmall_create", x, y)){
				team		= other.team;
				direction	= random(360);
				image_angle	= direction;
			}
		}
	} else {
		instance_destroy();
	}
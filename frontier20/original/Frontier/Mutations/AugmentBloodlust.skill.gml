#define init

	 // Sprites:
	global.sprSkillIcon 					= sprite_add("../sprites/mutations/sprAugmentBloodlust.png", 1, 12, 16);
	global.sprSkillHud  					= sprite_add("../sprites/mutations/sprAugmentBloodlustIcon.png", 1, 8, 8);
	global.sprAugmentBloodlustProc 			= sprite_add("../sprites/particles/sprAugmentBloodlustProc.png", 11, 12, 28);
	
	global.sprGreenAugmentBloodlustProc 	= sprite_add("../sprites/particles/sprGreenAugmentBloodlustProc.png", 11, 12, 28);
	
	global.augmentBloodlustCount			= 0;
	global.settingGreenAugments				= false;
	
	 // LIB:
	while(!mod_exists("mod", "lib")){wait(1);}
	script_ref_call(["mod", "lib", "getRef"], "skill", mod_current, "scr");
	#macro  scr			global.scr
	#macro  call		script_ref_call
	
#define skill_name			return loc("Frontier:AugmentBloodlust:0", "CARNIVOROUS ENZYMES");
#define skill_text			return loc("Frontier:AugmentBloodlust:1", "@wREGENERATE @rHP#@(color:16776960)EVERY @w13 @(color:16776960)KILLS");
#define skill_tip			return "ITS OK TO EAT NOW";
#define skill_button		sprite_index = global.sprSkillIcon;
#define skill_icon			return global.sprSkillHud;
#define skill_avail			return (mod_variable_get("mod", "Frontier_IDPD", "settingMainPoolAugments") = true) ? 1 : 0;
#define skill_wepspec		return 0;
#define skill_sacrifice		return false;
#define skill_augment		return mut_bloodlust; 

#define skill_lose
	global.augmentBloodlustCount = 0;
	
#define step

	with(instances_matching(instances_matching_le(enemy, "my_health", 0), "fr_AugmentBloodlust", null)){
		fr_AugmentBloodlust = true;
		global.augmentBloodlustCount += 1;
	}
	
	if(global.augmentBloodlustCount >= 13){
		global.augmentBloodlustCount = 0;
		with(Player){
			with instance_create(x, y, BloodLust){
				creator			= other;
				sprite_index	= (global.settingGreenAugments ? global.sprGreenAugmentBloodlustProc : global.sprAugmentBloodlustProc);
			}
			sound_play_pitch(sndBloodlustProc, 1.2);
			sound_play_pitchvol(sndGruntFire, 0.7, 0.5);
			
			if(my_health < maxhealth){
				my_health += skill_get(mod_current);
			}
			
			if(my_health >= maxhealth){
				call(scr.pickup_text, "HP", "max")
			} else {
				call(scr.pickup_text, "HP", "add", 1)
			}
		}
	}
    

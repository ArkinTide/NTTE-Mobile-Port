#define init

	 // Sprites:
	global.sprSkillIcon 					= sprite_add("../sprites/mutations/sprAugmentLuckyShot.png", 1, 12, 16);
	global.sprSkillHud  					= sprite_add("../sprites/mutations/sprAugmentLuckyShotIcon.png", 1, 9, 9);
	global.sprAugmentLuckyShotProc 			= sprite_add("../sprites/particles/sprAugmentLuckyShotProc.png", 7, 12, 28);
	
	global.sprGreenAugmentLuckyShotProc 	= sprite_add("../sprites/particles/sprGreenAugmentLuckyShotProc.png", 7, 12, 28);
	
	global.augmentLuckyShotCount			= 0;
	global.settingGreenAugments				= false;
	
	 // LIB:
	while(!mod_exists("mod", "lib")){wait(1);}
	script_ref_call(["mod", "lib", "getRef"], "skill", mod_current, "scr");
	#macro  scr			global.scr
	#macro  call		script_ref_call
	
#define skill_name			return loc("Frontier:AugmentLuckyShot:0", "DETRITUS ROUNDS");
#define skill_text			return loc("Frontier:AugmentLuckyShot:1", "@wREGENERATE @yAMMO#@(color:16776960)EVERY @w13 @(color:16776960)KILLS");
#define skill_tip			return "BONES TO BULLETS";
#define skill_button		sprite_index = global.sprSkillIcon;
#define skill_icon			return global.sprSkillHud;
#define skill_avail			return (mod_variable_get("mod", "Frontier_IDPD", "settingMainPoolAugments") = true) ? 1 : 0;
#define skill_wepspec		return 0;
#define skill_sacrifice		return false;
#define skill_augment		return mut_lucky_shot; 

#define skill_lose
	global.augmentLuckyShotCount = 0;
	
#define step

	with(instances_matching(instances_matching_le(enemy, "my_health", 0), "fr_AugmentLuckyShot", null)){
		fr_AugmentLuckyShot = true;
		global.augmentLuckyShotCount += 1;
	}
	
	if(global.augmentLuckyShotCount >= (13 / skill_get(mod_current))){
		global.augmentLuckyShotCount = 0;
		with(Player){
			with instance_create(x, y, BloodLust){
				creator			= other;
				sprite_index	= (global.settingGreenAugments ? global.sprGreenAugmentLuckyShotProc : global.sprAugmentLuckyShotProc);
			}
			sound_play_pitch(sndLuckyShotProc, 1.2)
			sound_play_pitchvol(sndGruntFire, 0.7, 0.5)

			
			var _type = irandom_range(1, 5); 
			ammo[_type] = min(ammo[_type] + typ_ammo[_type], typ_amax[_type]);
			
			 // Text:
			if(ammo[_type] >= typ_amax[_type]){
				call(scr.pickup_text, typ_name[_type], "max")
			} else {
				call(scr.pickup_text, typ_name[_type], "add", typ_ammo[_type])
			}
		}
	}
    

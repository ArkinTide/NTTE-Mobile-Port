#define init

	 // Sprites:
	global.sprSkillIcon 	= sprite_add("../sprites/mutations/sprAugmentGammaGuts.png", 1, 12, 16);
	global.sprSkillHud  	= sprite_add("../sprites/mutations/sprAugmentGammaGutsIcon.png", 1, 8, 8);
	
	global.mskRadius		= sprite_add("../sprites/projectiles/mskAugmentGammaGutsRadius.png", 1, 70, 70);
	global.sprRadius		= sprite_add("../sprites/projectiles/sprAugmentGammaGutsRadius.png", 1, 80, 80);
	global.sprGreenRadius	= sprite_add("../sprites/projectiles/sprGreenAugmentGammaGutsRadius.png", 1, 80, 80);
	
	global.settingGreenAugments				= false;
	
#define skill_name			return loc("Frontier:AugmentGammaGuts:0", "NANITE SWARM");
#define skill_text			return loc("Frontier:AugmentGammaGuts:1", "@wDEAL @(color:16776960)BONUS DAMAGE#@wTO @(color:16776960)NEARBY @wENEMIES");
#define skill_tip			return "NONE IS MORE FUN";
#define skill_button		sprite_index = global.sprSkillIcon;
#define skill_icon			return global.sprSkillHud;
#define skill_avail			return (mod_variable_get("mod", "Frontier_IDPD", "settingMainPoolAugments") = true) ? 1 : 0;
#define skill_wepspec		return 0;
#define skill_sacrifice		return false;
#define skill_augment		return mut_gamma_guts;

#define skill_lose
	with(instances_matching(CustomProjectile, "name", "fr_augmentGammaGutsRadius")){
		instance_delete(self);
	}
	
#define step
	with(Player){
		if(("fr_augmentGammaGutsRadius" not in self) || (!instance_exists(fr_augmentGammaGutsRadius))){
			fr_augmentGammaGutsRadius = DamageRadius_create(x, y, self);
		}
	}
	
#define DamageRadius_create(_x, _y, _owner)
	with(instance_create(x, y, CustomProjectile)){
		name			= "fr_augmentGammaGutsRadius";
		
		sprite_index	= (global.settingGreenAugments ? global.sprGreenRadius : global.sprRadius);
		depth			= -10;
		image_alpha		= 0;
		
		mask_index		= global.mskRadius;
		creator			= _owner;
		team			= creator.team;
		typ				= -1;
		damage			= 0;
		
		on_anim			= nothing;
		on_end_step		= DamageRadius_endstep;
		on_wall			= nothing;
		on_hit			= DamageRadius_hit;
		
		return self;
	}
	
#define DamageRadius_endstep
	if(instance_exists(creator)){
		x = creator.x;
		y = creator.y;
	} else {
		instance_destroy();
		exit;
	}
	
//	image_xscale	= 1 + random(0.02);
//	image_yscale	= image_xscale;
/*
	if(image_alpha > 0){
		image_alpha -= (0.05 * current_time_scale)
	}
*/	
#define DamageRadius_hit
/*
	if(image_alpha < 1.2){
		image_alpha += (0.1 * current_time_scale)
	}
*/
	if("my_health" in other){
		mod_script_call("mod", "Frontier_StatusEffects", "status_apply_set", other, mod_variable_get("mod", "Frontier_StatusEffects", "debuffAugmentGammaGuts"), 3)
	}
	
#define nothing
 // holy crap
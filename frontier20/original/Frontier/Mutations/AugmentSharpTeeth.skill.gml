#define init

	 // Sprites:
	global.sprSkillIcon 	= sprite_add("../sprites/mutations/sprAugmentSharpTeeth.png", 1, 12, 16);
	global.sprSkillHud  	= sprite_add("../sprites/mutations/sprAugmentSharpTeethIcon.png", 1, 8, 9);
	global.sprRadius		= sprite_add("../sprites/particles/sprAugmentSharpTeethRadius.png", 1, 160, 160);
	global.sprNull			= sprite_add("../sprites/particles/sprAugmentSharpTeethNull.png", 3, 8, 8);
	
	global.sprGreenRadius	= sprite_add("../sprites/particles/sprGreenAugmentSharpTeethRadius.png", 1, 160, 160);
	global.sprGreenNull		= sprite_add("../sprites/particles/sprGreenAugmentSharpTeethNull.png", 3, 8, 8);
	
	global.settingGreenAugments				= false;
	
#define skill_name			return loc("Frontier:AugmentSharpTeeth:0", "NULL PLATING");
#define skill_text			return loc("Frontier:AugmentSharpTeeth:1", "@(color:16776960)NULLIFICATION BLAST#@sWHEN @wTAKING DAMAGE");
#define skill_tip			return "NONE IS MORE FUN";
#define skill_button		sprite_index = global.sprSkillIcon;
#define skill_icon			return global.sprSkillHud;
#define skill_avail			return (mod_variable_get("mod", "Frontier_IDPD", "settingMainPoolAugments") = true) ? 1 : 0;
#define skill_wepspec		return 0;
#define skill_sacrifice		return false;
#define skill_augment		return mut_sharp_teeth;
	
#define step
	with(Player){
		if("fr_blast_armor" not in self){
			fr_blast_armor = false;
		}
		if (my_health < lsthealth && sprite_index == spr_hurt){
			if (fr_blast_armor = true){ 
				NullRadius_create(x, y)
				sound_play_pitchvol(sndGruntFire, 0.4 + random(0.2), 0.6)
			}
			fr_blast_armor = false;
		}
    	else { 
    		fr_blast_armor = true; 
    	}
	}
	
#define NullRadius_create(_x, _y)
	with instance_create(x, y, CustomSlash){
		sprite_index	= (global.settingGreenAugments ? global.sprGreenRadius : global.sprRadius);
		depth			= -10;
		image_xscale	= 0;
		image_yscale	= 0;
		
		creator			= other;
		team			= creator.team;
		typ				= 0;
		
		on_anim			= nothing;
		on_end_step		= NullRadius_endstep;
		on_wall			= nothing;
		on_hit			= nothing;
		on_projectile	= NullRadius_nullify;
		
		return self;
	}
	
#define NullRadius_endstep
	if(instance_exists(creator)){
		x = creator.x;
		y = creator.y;
	}
	
	image_xscale += (0.1 / skill_get(mod_current)) * current_time_scale;
	image_yscale = image_xscale;
	image_alpha	 -= (0.1 / skill_get(mod_current)) * current_time_scale;

	if(image_xscale >= 1){
		wait(1);
		instance_destroy();
		exit
	}
	
#define NullRadius_nullify
	if(instance_exists(self)) && (other.typ > 0){ 
		with(other){
			sound_play_pitchvol(sndPickupDisappear, 1.3 + random(0.2), 0.4)
			with instance_create(x, y, BulletHit){ 
				sprite_index = (global.settingGreenAugments ? global.sprGreenNull : global.sprNull);
			}
			instance_destroy();
		} 
	}
	
#define nothing
 // holy crap
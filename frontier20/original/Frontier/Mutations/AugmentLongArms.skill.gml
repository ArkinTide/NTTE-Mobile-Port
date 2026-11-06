#define init
	global.sprSkillIcon 					= sprite_add("../sprites/mutations/sprAugmentLongArms.png", 1, 12, 16)
	global.sprSkillHud  					= sprite_add("../sprites/mutations/sprAugmentLongArmsIcon.png", 1, 8, 8)

#define skill_name			return loc("Frontier:AugmentLongArms:0", "PHOTON BLADES");
#define skill_text			return loc("Frontier:AugmentLongArms:1", "@wMELEE ATTACKS @sCREATE#@(color:16776960)AFTERSHOCKS");
#define skill_tip			return "HIGH SPEED DISSECTION";
#define skill_button		sprite_index = global.sprSkillIcon;
#define skill_icon			return global.sprSkillHud;
#define skill_avail			return (mod_variable_get("mod", "Frontier_IDPD", "settingMainPoolAugments") = true) ? 1 : 0;
#define skill_wepspec		return 1;
#define skill_sacrifice		return false;
#define skill_augment		return mut_long_arms;
	
#define step
	var inst = [Slash, LightningSlash, EnergySlash, EnergyHammerSlash, BloodSlash, Shank, EnergyShank, GuitarSlash];
	var inst2 = instances_matching(CustomSlash, "is_melee", true);
	if array_length(inst2){
		with inst2 {
			array_push(inst, self);
		}
	}

	with(Player){
		with instances_matching(instances_matching(inst, "zelda", null), "team", team){
			zelda = true;
			aftershock();
		}
	}

#define aftershock
	with instance_create(x, y, CustomProjectile){
		
		 // Visuals:
		sprite_index	= other.sprite_index;
		image_index 	= 0;
		image_speed 	= 0;
		image_xscale	= other.image_xscale * 0.9;
		image_yscale	= other.image_yscale * 0.95;
		image_alpha 	= 0;
		
		 // Vars:
		speed			= 0;
		friction		= 0.4;
		direction		= other.direction;
		image_angle 	= other.image_angle;
		team			= other.team;
		creator 		= other.creator;
		damage			= max(1,round(other.damage * 0.15 * skill_get(mod_current)));
		timer			= 2;
		stored_mask 	= other.mask_index;
		mask_index		= mskNone;
		speedcap		= 8;
		hitlist 		= [];
		
		on_step 		= aftershock_step
		on_wall 		= aftershock_wall
		on_hit			= aftershock_hit
		on_draw 		= aftershock_draw
	}

#define aftershock_step

	xprevious = x + hspeed * 0.4;
	yprevious = y + vspeed * 0.4;

	if timer != -1 timer = max(0, timer - current_time_scale);
	
	if (timer == 0) {
		timer		= -1;
		image_alpha = 0.6;
		mask_index	= stored_mask;
		speed		= 22;
		friction	= 1.5;
	}
	else if (timer == -1){
		if (speed <= speedcap){
			image_speed = 0.4;
			
			if (image_index + image_speed >= image_number){
				instance_destroy();
				exit;
			}
		}
	}
	
#define aftershock_wall
	speed *= 0.8;

#define aftershock_hit
	if array_find_index(hitlist, other) == -1 {
		var n_h = other.nexthurt;
		projectile_hit(other, damage, 5, direction);
		array_push(hitlist, other);
		other.nexthurt = n_h;
	}
	
#define aftershock_draw
	draw_set_blend_mode(bm_add);
	draw_sprite_ext(
		sprite_index,
		image_index,
		x,
		y,
		image_xscale,
		image_yscale,
		image_angle,
		c_white,
		image_alpha * 0.75
	)
	
	draw_sprite_ext(
		sprite_index,
		image_index,
		x,
		y,
		image_xscale * 1.2,
		image_yscale * 1.2,
		image_angle,
		c_white,
		image_alpha * 0.6
	)
	draw_set_blend_mode(bm_normal);
	
	draw_sprite_ext(
		sprite_index,
		image_index,
		x,
		y,
		image_xscale * 0.9,
		image_yscale * 0.9,
		image_angle,
		c_white,
		image_alpha * 0.3
	)
    
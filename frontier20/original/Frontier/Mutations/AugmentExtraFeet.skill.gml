#define init

	 // Sprites:
	global.sprSkillIcon 					= sprite_add("../sprites/mutations/sprAugmentExtraFeet.png", 1, 12, 16);
	global.sprSkillHud   					= sprite_add("../sprites/mutations/sprAugmentExtraFeetIcon.png", 1, 8, 10);
	
	global.sprGreenIDPDPortalCharge			= sprite_add("../sprites/particles/sprGreenIDPDPortalCharge.png", 4, 4, 4);
	
	global.settingGreenAugments				= false;
	
#define skill_name			return loc("Frontier:AugmentExtraFeet:0", "POCKET TELEPORTER");
#define skill_text			return loc("Frontier:AugmentExtraFeet:1", "@wDOUBLE-TAP @sMOVEMENT#@sKEYS TO PERFORM A#@(color:16776960)TELEPORTATION DASH");
#define skill_tip			return "VWOOP";
#define skill_button		sprite_index = global.sprSkillIcon;
#define skill_icon			return global.sprSkillHud;
#define skill_avail			return (mod_variable_get("mod", "Frontier_IDPD", "settingMainPoolAugments") = true) ? 1 : 0;
#define skill_wepspec		return 0;
#define skill_sacrifice		return false;
#define skill_augment		return mut_extra_feet;

#define skill_take
	with(Player){
		fr_dashaugment_lastx		= x
		fr_dashaugment_lasty		= y
		fr_dashaugment_cooldown 	= 0;
		fr_dashaugment_angle		= -1;
		fr_dashaugment_swapcooldown = 0
		fr_dashaugment_lstebutton	= 0;
		fr_dashaugment_lstnbutton	= 0;
		fr_dashaugment_lstwbutton	= 0;
		fr_dashaugment_lstsbutton	= 0;
	}
	
#define step

		// this is really scuffed but its old and doesnt seem to error so WHATEVER. i was probably gonna replace this one anyways.
		// Check Keys:
	with(Player){
		
		if ("fr_dashaugment_cooldown" not in self){
			fr_dashaugment_lastx		= x
			fr_dashaugment_lasty		= y
			fr_dashaugment_cooldown 	= 0;
			fr_dashaugment_angle		= -1;
			fr_dashaugment_swapcooldown = 0
			fr_dashaugment_lstebutton	= 0;
			fr_dashaugment_lstnbutton	= 0;
			fr_dashaugment_lstwbutton	= 0;
			fr_dashaugment_lstsbutton	= 0;
		}
		
		 
		if(canwalk > 0){
			if(button_pressed(index, "east") && (fr_dashaugment_cooldown <= 0)){
				if fr_dashaugment_lstebutton >= current_frame - (7 / current_time_scale) && fr_dashaugment_swapcooldown <= current_frame {
					fr_dashaugment_swapcooldown = current_frame + (7 / current_time_scale);
					dash();
				}
				fr_dashaugment_lstebutton = current_frame;
			}

			if(button_pressed(index, "nort")&& (fr_dashaugment_cooldown <= 0)){
				if fr_dashaugment_lstnbutton >= current_frame - (7 / current_time_scale) && fr_dashaugment_swapcooldown <= current_frame {
					fr_dashaugment_swapcooldown = current_frame + (7 / current_time_scale);
					dash();
				}
				fr_dashaugment_lstnbutton = current_frame;
			}

			if(button_pressed(index, "west") && (fr_dashaugment_cooldown <= 0)){
				if fr_dashaugment_lstwbutton >= current_frame - (7 / current_time_scale) && fr_dashaugment_swapcooldown <= current_frame {
					fr_dashaugment_swapcooldown = current_frame + (7 / current_time_scale);
					dash();
				}
				fr_dashaugment_lstwbutton = current_frame;
			}
	
			if(button_pressed(index, "sout") && (fr_dashaugment_cooldown <= 0)){
				if(fr_dashaugment_lstsbutton >= current_frame - (7 / current_time_scale) && fr_dashaugment_swapcooldown <= current_frame){
					fr_dashaugment_swapcooldown = current_frame + (7 / current_time_scale);
					dash();
				}
				fr_dashaugment_lstsbutton = current_frame;
			}

			 // Timer and a bit o friction:
			if(fr_dashaugment_cooldown > 0){
				speed += 1
				after_image();
				fr_dashaugment_cooldown -= current_time_scale;
			}
		}
	}

#define dash
		// Based this off of Patrol's Dash (xef wrote the original code).

		 // the reason the dashangle has to be hardcoded is with inputting direction (or multiple of 45 of direction) it causes the wall bug.
		if button_check(index, "east") fr_dashaugment_angle = 000;
		if button_check(index, "nort") fr_dashaugment_angle = 090;
		if button_check(index, "west") fr_dashaugment_angle = 180;
		if button_check(index, "sout") fr_dashaugment_angle = 270;
	
		if button_check(index, "east") && button_check(index, "nort") fr_dashaugment_angle = 045;
		if button_check(index, "nort") && button_check(index, "west") fr_dashaugment_angle = 135;
		if button_check(index, "west") && button_check(index, "sout") fr_dashaugment_angle = 225;
		if button_check(index, "sout") && button_check(index, "east") fr_dashaugment_angle = 315;
		
		var _gogogo				= true;
		fr_dashaugment_length	= 0;
			
		while(_gogogo){
			if((collision_line(x, y, x + lengthdir_x(fr_dashaugment_length, fr_dashaugment_angle), y + lengthdir_y(fr_dashaugment_length, fr_dashaugment_angle), Wall, 0, 1)) || (collision_line(x, y, x + lengthdir_x(fr_dashaugment_length, fr_dashaugment_angle), y + lengthdir_y(fr_dashaugment_length, fr_dashaugment_angle), InvisiWall, 0, 1)) || (fr_dashaugment_length >= 50 * skill_get(mod_current))){
				var blinklengthfix;
				var blink50fix;
				if(fr_dashaugment_length >= 40){
					blink50fix = (fr_dashaugment_length - 40) / 10 * 8;
				}
				while((place_meeting(x + lengthdir_x(fr_dashaugment_length - blinklengthfix + blink50fix, fr_dashaugment_angle), y + lengthdir_y(fr_dashaugment_length - blinklengthfix + blink50fix, fr_dashaugment_angle), Wall) || place_meeting(x + lengthdir_x(fr_dashaugment_length - blinklengthfix + blink50fix, fr_dashaugment_angle), y + lengthdir_y(fr_dashaugment_length - blinklengthfix + blink50fix, fr_dashaugment_angle), InvisiWall)) && (blinklengthfix <= 14)){
					blinklengthfix += 2;
				}
				blinklengthfix *= 2;
				fr_dashaugment_length -= blinklengthfix;
				_gogogo = false;
			}
			else fr_dashaugment_length += 1;
		}
		
		lastx = x;
		lasty = y;
		x = x + lengthdir_x(fr_dashaugment_length, fr_dashaugment_angle);
		y = y + lengthdir_y(fr_dashaugment_length, fr_dashaugment_angle);
		
		fr_dashaugment_cooldown = 5;
		
			// VFX and SFX:
		repeat(6){ 
			with instance_create(x, y, PlasmaTrail) { 
				sprite_index	= (global.settingGreenAugments ? global.sprGreenIDPDPortalCharge : sprIDPDPortalCharge);
				image_index 	= choose(0, 1); 
				direction		= random(360); 
				speed			= random(1); 
			} 
		}
		repeat(random_range(5, 7)) with instance_create(x, y + 10, Dust){
			speed = random_range(5, 7) * other.fr_dashaugment_length / 50;
			direction = other.fr_dashaugment_angle + random_range(-35, 35);
		}
		
		sound_play_pitchvol(sndFrogPistol, random_range(1.25, 1.65), 0.5);
		sound_play_pitchvol(sndDogGuardianBounce, random_range(0.50, 0.70), 0.6);
		
		repeat(6){ 
			with instance_create(x, y, PlasmaTrail) { 
				sprite_index	= (global.settingGreenAugments ? sprPlasmaTrail : sprPopoPlasmaTrail);
				image_index 	= choose(0, 1); 
				direction		= other.direction + 180 + random_range(-20,20); 
				speed			= random(5);
			} 
		}
		repeat(6){ 
			with instance_create(x, y, PlasmaTrail) { 
				sprite_index	= (global.settingGreenAugments ? global.sprGreenIDPDPortalCharge : sprIDPDPortalCharge);
				image_index 	= choose(0, 1); 
				direction		= random(360); 
				speed			= random(1); 
			} 
		}
    
		
	// Stole this afterimage effect from Spaz
#define after_image
    with(instance_create(x, y, CustomObject)){
    	sprite_index = other.sprite_index;
    	image_index = other.image_index;
    	image_xscale = other.right * other.image_xscale;
    	image_yscale = other.image_yscale;
    	image_angle = other.angle + other.sprite_angle;
    	image_blend = other.image_blend;
    	image_alpha = other.image_alpha;
    	image_speed = 0;
    	depth = other.depth;
    	on_step = blur_step;
    	on_draw = blur_draw;
    }
   
#define blur_step
	depth += 0.01;
	image_alpha *= 0.5;
	if(image_alpha <= 0.01) instance_destroy();

#define blur_draw
draw_self()
#define init

     // Sprites:
    global.sprWeapon 	        = sprite_add_weapon("../Sprites/Weapons/sprPowderHookpole.png", 10, 2);
    global.sprWeaponHud			= sprite_add_weapon("../Sprites/Weapons/HudSprites/sprPowderPole.png", 1, 4);
    global.sprGunpowderSlash	= sprite_add("../Sprites/Projectiles/sprGunpowderSlash.png", 3, 0, 24);
   // global.sprWeaponHud 	    = sprite_add_weapon("../Sprites/Weapons/Hudsprites/sprBubblesCutlassHud.png", 0, 4);
  
#define weapon_name(_wep)
	if instance_is(self, WepPickup) && instance_is(other, Player){
		if(sprite_index = sprScrewDriver){
	    	weapon_drop(other)
		}
	}
	return "POWDER POLE"
#define weapon_text         return "SPARKLER";
#define weapon_sprt         return global.sprWeapon;
#define weapon_sprt_hud		return global.sprWeaponHud;
#define weapon_type         return 4;
#define weapon_melee        return true;
#define weapon_area         return mod_script_call("mod", "Frontier_Projectiles", "check_piratedrops", mod_current, 10);
#define weapon_auto         return false;
#define weapon_load         return 10;
#define weapon_cost         return 1;
#define weapon_swap         return sndSwapSword;
#define weapon_handy		return true;
#define weapon_handy_data	return	{ x : 0, y : 3, bhand : true, bx : 14, by : 3 }

#define weapon_fire(_wep)


     // FireCont Support:
	var c = ((instance_is(self, FireCont) && "creator" in self) ? creator : self);

	 // Sounds:
	audio_sound_pitch(sound_play_gun(sndScrewdriver,	 0, 0.8), 0.75 + random(0.2));  
	sound_play_pitchvol(sndChickenSword,		random_range(0.85, 0.95), 0.3);	

	 // Spear Head Shank:
	with(mod_script_call("mod", "Frontier_Projectiles", "GunpowderShank_create", x + lengthdir_x(25, gunangle), y + lengthdir_y(25, gunangle))){
		image_xscale	= 1.2;
		image_yscale	= 0.8;
		direction		= other.gunangle + random_range(-1, 1) * other.accuracy;
		image_angle 	= direction;
		
		speed			= 2 + (3 * skill_get(mut_long_arms));
		team			= other.team;
    	creator 		= other;
	}
	
	 // Spear Body Shank:
	with instance_create(x, y, Shank){
		sprite_index	= global.sprGunpowderSlash;
		image_yscale	= 0.15;
		depth			= other.depth - 1;
		
		direction		= other.gunangle + random_range(-1, 1) * other.accuracy;
		image_angle 	= direction;
		mask_index		= mskSlash;
		speed			= 2 + (skill_get(mut_long_arms));
		damage			= 6;
		canfix			= false;
		canreflect		= false;
		team			= other.team;
    	creator 		= other;
	}
    
	 // Kick, Shift, Shake:
	weapon_post(-20, 11, 8);
	
	 // Melee Schmoovement:
	wepangle = -wkick;
	motion_add(other.gunangle, 3);
	instance_create(x, y, Dust)
    
#define weapon_reloaded
	sound_play(sndMeleeFlip)
	wepflip = sign(wepangle)
	
#define weapon_drop(_player)
	_player.wepangle = 120 * sign(_player.wepangle)
    
#define step(_primary) 
	var _wep = (_primary ? wep : bwep);

	if ("right" in self){var _right = right;}
	else{var _right = 1;}
	
	if(_primary){ 
		wepflip = right;
		wepangle = max(0.1, -0.1 * wkick ) * right;
		wkick += 0.8 * current_time_scale;
	}
	else{
		bwepflip = -1 * right;
		bwepangle = max(0.1,-0.1 * bwkick ) * right;
	}
	
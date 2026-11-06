#define init

     // Sprites:
    global.sprWeapon 	        = sprite_add_weapon("../Sprites/Weapons/sprGildedTideTurner.png", 4, 4);
  
#define weapon_name         return "SHORES OF GOLD";          
#define weapon_text         return "THE GOLDEN COAST";
#define weapon_sprt         return global.sprWeapon;
#define weapon_type         return 3;
#define weapon_melee        return true;
#define weapon_area         return -1;
#define weapon_auto         return false;
#define weapon_load         return 12;
#define weapon_cost         return 1;
#define weapon_swap         return sndSwapSword;
#define weapon_laser_sight	return false;
#define weapon_handy		return true;
#define weapon_handy_data	return	{ x : 0, y : 1, bhand : false }

#define weapon_fire(_wep)


     // FireCont Support:
	var c = ((instance_is(self, FireCont) && "creator" in self) ? creator : self);

     // Sounds:
	sound_play_pitchvol(sndHammer,				random_range(0.9, 1.2), 1);
	sound_play_pitchvol(sndGoldWrench,			random_range(1.1, 1.3), 0.75);
	sound_play_pitchvol(sndOasisExplosionSmall,	random_range(1.1, 1.4), 0.6);
		
     // Projectiles:
	var _disjoint = (0 + 15 * skill_get(mut_long_arms));
	with(mod_script_call("mod", "Frontier_Projectiles", "TideSlash_create", x + lengthdir_x(_disjoint, gunangle), y + lengthdir_y(_disjoint, gunangle))){
    	speed			= 2 + (skill_get(13) * 3.5);
		direction		= other.gunangle;
		image_angle     = direction;
		team            = other.team;
		creator         = other;
    }
   
     // Melee Schmoovement:
	wepangle = -wepangle;
	weapon_post(-4, 8, 3);
	motion_add(gunangle, 3.5);
	instance_create(x, y, Dust);
    
#define weapon_reloaded
	sound_play(sndMeleeFlip)
	wepflip = sign(wepangle)
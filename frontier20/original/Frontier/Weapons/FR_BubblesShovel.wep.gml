#define init

     // Sprites:
    global.sprWeapon 	        = sprite_add_weapon("../Sprites/Weapons/sprBubblesShovel.png", 7, 6);
    global.sprWeaponHud 	    = sprite_add_weapon("../Sprites/Weapons/Hudsprites/sprBubblesShovelHud.png", 0, 5);
    global.sprWeaponArt 		= sprite_add_weapon("../Sprites/Weapons/Loadout/sprBubblesShovelLoadout.png", 24, 18);
  
#define weapon_name         return "HOARDER SHOVEL";          
#define weapon_text         return "24 KARAT";
#define weapon_sprt         return global.sprWeapon;
#define weapon_sprt_hud		return global.sprWeaponHud;
#define weapon_loadout		return global.sprWeaponArt;
#define weapon_type         return 0;
#define weapon_melee        return true;
#define weapon_area         return -1;
#define weapon_auto         return false;
#define weapon_load         return 22;
#define weapon_cost         return 0;
#define weapon_swap         return sndSwapSword;
//#define wep_exchange_pirate return "FR_CorsairCutlass";
#define weapon_handy		return true;
#define weapon_handy_data	return	{ x : 2, y : 1, bhand : true, bx : 11, by : 1 }

#define weapon_fire(_wep)


     // FireCont Support:
	var c = ((instance_is(self, FireCont) && "creator" in self) ? creator : self);

     // Sounds:
	sound_play_pitchvol(sndShovel,	        0.9 + random(0.3), 0.75);
	sound_play_pitchvol(sndGoldScrewdriver,	0.8 + random(0.2), 1);
		
     // Projectiles:
	var _disjoint = (0 + 15 * skill_get(mut_long_arms));
	with instance_create(x + lengthdir_x(_disjoint, gunangle), y + lengthdir_y(_disjoint, gunangle), Slash){
    	speed		    = 1.5 + (skill_get(13) * 4);
		direction		= other.gunangle;
		image_angle     = direction;
		damage			= 9;
		team            = other.team;
		creator         = other;
    }
   
     // Melee Schmoovement:
	wepangle = -wepangle;
	weapon_post(-4, 8, 3);
	motion_add(gunangle, 3.5);
	instance_create(x, y, Dust)
    
#define weapon_reloaded
	sound_play(sndMeleeFlip)
	wepflip = sign(wepangle)
	
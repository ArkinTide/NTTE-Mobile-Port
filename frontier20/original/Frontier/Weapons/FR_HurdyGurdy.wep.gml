#define init

     // Sprites:
    global.sprWeapon 	        = sprite_add_weapon("../Sprites/Weapons/sprHurdyGurdy.png", 3, 5);
  
#define weapon_name         return "HURDY-GURDY";          
#define weapon_text         return "CRANK THAT";
#define weapon_sprt         return global.sprWeapon;
#define weapon_type         return 0;
#define weapon_melee        return true;
#define weapon_area         return -1;
#define weapon_auto         return false;
#define weapon_load         return 26;
#define weapon_cost         return 0;
#define weapon_swap         return sndSwapSword;
#define weapon_handy		return true;
#define weapon_handy_data	return	{ x : 1, y : 2, bhand : false }

#define weapon_fire(_wep)

     // FireCont Support:
	var c = ((instance_is(self, FireCont) && "creator" in self) ? creator : self);

     // Sounds:
	sound_play_pitchvol(sndGuitar,	        0.9 + random(0.3), 0.75);;
		
     // Projectiles:
	var _disjoint = (0 + 15 * skill_get(mut_long_arms));
	with instance_create(x + lengthdir_x(_disjoint, gunangle), y + lengthdir_y(_disjoint, gunangle), GuitarSlash){
		sprite_index	= sprHeavySlash;
    	speed		    = 1.5 + (skill_get(13) * 4);
		direction		= other.gunangle;
		image_angle     = direction;
		damage			= 28;
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
	
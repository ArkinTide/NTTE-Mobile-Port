#define init

     // Sprites:
	global.sprWeapon 	        = sprite_add_weapon("../Sprites/Weapons/sprTempGun.png", 6, 2);

#define weapon_name         return "YOU SHOULDNT HAVE THIS";          
#define weapon_text         return "IDK";
#define weapon_sprt         return global.sprWeapon;
#define weapon_type         return 3;
#define weapon_melee        return false;
#define weapon_area         return -1;
#define weapon_auto         return true;
#define weapon_load         return 20;
#define weapon_cost         return 2;
#define weapon_swap         return sndSwapShotgun;

#define weapon_fire(_wep)

     // FireCont Support:
	var c = ((instance_is(self, FireCont) && "creator" in self) ? creator : self);

     // Sounds:
	sound_play_gun((sndPistol), 1, 1 + random(0.2));
		
     // Projectiles:
    repeat(1){
	    with(mod_script_call("mod", "Frontier_Projectiles", "Pufferbomb_create", x, y)){
			direction		= other.gunangle + (random_range(-1, 1) * other.accuracy);
			image_angle     = direction;
			team            = other.team;
			creator         = other;
	    }
    }
    
   
     // Kick, Shift, Shake:
    weapon_post(8, 2, 2);
    motion_add(gunangle + 180, 1)
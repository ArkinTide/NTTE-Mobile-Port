#define init

     // Sprites:
    global.sprWeapon 	        = sprite_add_weapon("../Sprites/Weapons/sprEnfileter.png", 5, 4);
  
#define weapon_name         return "ENFILETER";          
#define weapon_text         return "TOASTY";
#define weapon_sprt         return global.sprWeapon;
#define weapon_type         return 1;
#define weapon_melee        return false;
#define weapon_area         return mod_script_call("mod", "Frontier_Projectiles", "check_piratedrops", mod_current, 16);
#define weapon_auto         return true;
#define weapon_load         return 13;
#define weapon_cost         return 8;
#define weapon_swap         return sndSwapMachinegun;
#define weapon_handy		return true;
#define weapon_handy_data	return	{ x : 1, y : 5, bhand : true, bx : 10, by : 5 }

#define weapon_fire(_wep)

     // FireCont Support:
	var c = ((instance_is(self, FireCont) && "creator" in self) ? creator : self);

     // Sounds:
	sound_play_pitchvol(sndFireShotgun,	    	0.9 + random(0.3), 0.75);
	sound_play_pitchvol(sndHeavyMachinegun,	    1.2 + random(0.3), 1);
	sound_play_pitchvol(sndIncinerator,	    	1.2 + random(0.3), 1);
		
     // Projectiles:
    repeat(10){
		with(mod_script_call("mod", "Frontier_Projectiles", "FlameBullet_create", x, y)){
			speed			= 16 + random_range(-3, 3);
			direction		= other.gunangle + (random_range(-12, 12) * other.accuracy);
			image_angle     = direction;
			team            = other.team;
			creator         = other;
		}
    }
	
     // Kick, Shift, Shake:
    weapon_post(10, 2, 2);
    motion_add(gunangle + 180, 1)
   
	 // Dust:
	repeat(6){
		with(instance_create(x, y, Smoke)){
			direction	= other.gunangle + random_range(-45, 45);
			speed		= 3 + random(2);
		}
	}
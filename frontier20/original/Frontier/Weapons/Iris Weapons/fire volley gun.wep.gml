#define init

     // Sprites:
    global.sprWeapon 	        = sprite_add_weapon("../../Sprites/Weapons/Iris/sprFireVolleyGun.png", 5, 2);
  
#define weapon_name         return "FIRE VOLLEY GUN";          
#define weapon_text         return "FIRE IN THE HOLE";
#define weapon_sprt         return global.sprWeapon;
#define weapon_type         return 1;
#define weapon_melee        return false;
#define weapon_area         return -1;
#define weapon_auto         return true;
#define weapon_load         return 10;
#define weapon_cost         return 7;
#define weapon_swap         return sndSwapMachinegun;
#define weapon_handy		return true;
#define weapon_handy_data	return	{ x : 2, y : 5, bhand : true, bx : 10, by : 5 }
#define weapon_fire(_wep)

     // FireCont Support:
	var c = ((instance_is(self, FireCont) && "creator" in self) ? creator : self);

     // Sounds:
	sound_play_pitchvol(sndDoubleFireShotgun,	0.9 + random(0.3), 0.75);
	sound_play_pitchvol(sndHeavyMachinegun,	    1.2 + random(0.3), 1);
		
     // Projectiles:
    repeat(9){
		with(mod_script_call("mod", "defpack tools", "create_fire_bullet", x, y)){
			speed			= 14 + random_range(-5, 7);
			direction		= other.gunangle + (random_range(-18, 18) * other.accuracy);
			image_angle     = direction;
			team            = other.team;
			creator         = other;
		}
    }
	
     // Kick, Shift, Shake:
    weapon_post(10, 16, 20);
    motion_add(gunangle + 180, 1)
   
	 // Dust:
	repeat(6){
		with(instance_create(x, y, Dust)){
			sprite_index	= sprSmoke;
			direction		= other.gunangle + random_range(-45, 45);
			speed			= 3 + random(2);
		}
	}
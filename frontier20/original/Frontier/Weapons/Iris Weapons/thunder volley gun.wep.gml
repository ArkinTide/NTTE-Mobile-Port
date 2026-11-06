#define init

     // Sprites:
    global.sprWeapon 	        = sprite_add_weapon("../../Sprites/Weapons/Iris/sprThunderVolleyGun.png", 5, 2);
  
#define weapon_name         return "THUNDER VOLLEY GUN";          
#define weapon_text         return "SHOCK VALUE";
#define weapon_sprt         return global.sprWeapon;
#define weapon_type         return 1;
#define weapon_melee        return false;
#define weapon_area         return -1;
#define weapon_auto         return true;
#define weapon_load         return 22;
#define weapon_burst        return 3;
#define weapon_burst_time   return 2;
#define weapon_cost         return 10;
#define weapon_swap         return sndSwapMachinegun;
#define weapon_handy		return true;
#define weapon_handy_data	return	{ x : 2, y : 5, bhand : true, bx : 10, by : 5 }
#define weapon_fire(_wep)

     // FireCont Support:
	var c = ((instance_is(self, FireCont) && "creator" in self) ? creator : self);

     // Sounds:
	sound_play_pitchvol(sndSawedOffShotgun,		1.1 + random(0.3), 0.75);
	sound_play_pitchvol(sndHeavyMachinegun,	    1.2 + random(0.3), 1);
	sound_play_pitchvol((skill_get(mut_laser_brain)) ? sndLightningCannonUpg : sndLightningCannon, 1.2 + random(0.3), 1);
		
     // Projectiles:
    repeat(5){
		with(mod_script_call("mod", "defpack tools", "create_lightning_bullet", x, y)){
			speed			= 10 + random_range(-2, 3);
			direction		= other.gunangle + (random_range(-9, 9) * other.accuracy);
			image_angle     = direction;
			team            = other.team;
			creator         = other;
		}
    }
	
     // Kick, Shift, Shake:
    weapon_post(10, 10, 12);
    motion_add(gunangle + 180, 1)
   
	 // Dust:
	repeat(2){
		with(instance_create(x, y, Dust)){
			sprite_index	= sprSmoke;
			direction		= other.gunangle + random_range(-45, 45);
			speed			= 3 + random(2);
		}
	}
	
     // Burst:
    if(array_find_index(instances_matching(CustomObject, "name", "WeaponBurst"), other) < 0){
        with(mod_script_call("mod", "Frontier_Projectiles", "WeaponBurst_create", x, y)){
            accuracy = other.accuracy;
            creator  = other;
            team     = other.team;
            spec     = other.specfiring;
            wep      = _wep;
            ammo     = weapon_burst() - 1;
            time_max = weapon_burst_time();
            time     = time_max;
        }
    }
#define init

     // Sprites:
    global.sprWeapon 	        = sprite_add_weapon("../Sprites/Weapons/sprAutoBallista.png", 5, 5);

#define weapon_name         return "ARBLAST";          
#define weapon_text         return "FIREWALL";
#define weapon_sprt 		return global.sprWeapon;
#define weapon_type         return 3;
#define weapon_melee        return false;
#define weapon_area			return mod_script_call("mod", "Frontier_Projectiles", "check_piratedrops", mod_current, 16);
#define weapon_auto         return true;
#define weapon_load         return 20;
#define weapon_burst        return 3;
#define weapon_burst_time   return 3;
#define weapon_cost         return 4;
#define weapon_swap         return sndSwapBow;
#define weapon_laser_sight	return false;
#define weapon_handy		return true;
#define weapon_handy_data	return	{ x : 1, y : 3, bhand : true, bx : 10, by : 5 }

#define weapon_fire(_wep)

     // FireCont Support:
	var c = ((instance_is(self, FireCont) && "creator" in self) ? creator : self);

     // Sounds:
	sound_play_gun((sndHeavyCrossbow), 1, 0.8 + random(0.2));
	sound_play_gun((sndCrossbow), 1, 0.8 + random(0.2));
		
     // Projectiles:
	with(mod_script_call("mod", "Frontier_Projectiles", "BallistaBolt_create", x, y)){
		speed			= 16;
		direction		= other.gunangle + (random_range(-6, 6) * other.accuracy);
		image_angle		= direction;
		team            = other.team;
		creator         = other;
		subCount		= 2;
		subSpread		= -8;
	}
	
     // Kick, Shift, Shake:
    weapon_post(6, 30, 1.5);
    motion_add(gunangle + 180, 2)
	
     // Burst:
    if(array_find_index(instances_matching(CustomObject, "name", "WeaponBurst"), other) < 0){
        with(mod_script_call("mod", "Frontier_Projectiles", "WeaponBurst_create", x, y)){
            accuracy = other.accuracy;
            creator  = other;
            team     = other.team;
            spec     = other.specfiring;
            wep      = "FR_AutoBallista";
            ammo     = weapon_burst() - 1;
            time_max = weapon_burst_time();
            time     = time_max;
        }
    }

#define weapon_reloaded
	sound_play_pitch(sndCrossReload, 0.7 + random(0.1));
	
#define init

     // Sprites:
    global.sprWeapon 	        = sprite_add_weapon("../Sprites/Weapons/sprCandleBarrage.png", 7, 8);

#define weapon_name         return "CANDLE BARRAGE";          
#define weapon_text         return "CATASTROPHIC COLORS";
#define weapon_sprt 		return global.sprWeapon;
#define weapon_type         return 4;
#define weapon_melee        return false;
#define weapon_area         return mod_script_call("mod", "Frontier_Projectiles", "check_piratedrops", mod_current, 13);
#define weapon_auto         return true;
#define weapon_load         return 12;
#define weapon_burst        return 3;
#define weapon_burst_time   return 4;
#define weapon_cost         return 2;
#define weapon_swap         return sndSwapExplosive;
#define weapon_handy		return true;
#define weapon_handy_data	return	{ x : 1, y : 3, bhand : true, bx : 8, by : 5 }

#define weapon_fire(_wep)

     // FireCont Support:
	var c = ((instance_is(self, FireCont) && "creator" in self) ? creator : self);

     // Sounds:
	sound_play_pitch(sndFireShotgun, 1.3 + random(0.2));
		
     // Projectiles:
	with(mod_script_call("mod", "Frontier_Projectiles", "FireworkCandle_create", x, y)){
		speed			= 15 + random(3);
		direction		= other.gunangle + (random_range(-15, 15) * other.accuracy);
		image_angle		= direction;
		team            = other.team;
		creator         = other;
	}
	
     // Smoke:
    repeat(3){
    	with(mod_script_call("mod", "Frontier_Projectiles", "WhiteDust_create", x, y)){
    		speed			= 3 + random(6);
			direction		= other.gunangle + (random_range(-50, 50) * other.accuracy);
			team            = other.team;
			creator         = other;
    	}
    }
	
	
     // Kick, Shift, Shake:
    weapon_post(6, 12, 0.8);
    motion_add(gunangle + 180, 2)
    
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
	
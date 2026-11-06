#define init

     // Sprites:
    global.sprWeapon 	        = sprite_add_weapon("../Sprites/Weapons/sprStarlightSMG.png",	2, 4);

#define weapon_name         return "URSA MAJOR";          
#define weapon_text         return "CONSTELLATIONS";
#define weapon_sprt         return global.sprWeapon;
#define weapon_type         return 5;
#define weapon_melee        return false;
#define weapon_area         return mod_script_call("mod", "Frontier_Projectiles", "check_piratedrops", mod_current, 14);
#define weapon_auto         return true;
#define weapon_load         return 10;
#define weapon_burst        return 5;
#define weapon_burst_time   return 2;
#define weapon_cost         return 2;
#define weapon_swap         return sndSwapShotgun;
#define weapon_handy		return true;
#define weapon_handy_data	return	{ x : 8, y : 7, bhand : true, bx : 14, by : 7 }

#define weapon_fire(_wep)


     // FireCont Support:
	var c = ((instance_is(self, FireCont) && "creator" in self) ? creator : self);

     // Sounds:
	if(skill_get(mut_laser_brain) > 0){
		sound_play_pitch(sndSwapGold, 1.1 + random(0.2));
		sound_play_pitch(sndEnergyScrewdriverUpg, 1.2 + random(0.2));		
		sound_play_pitchvol(sndEnergySword, 1.3 + random(0.2), 0.6);					
	} else {
		sound_play_pitch(sndSwapGold, 1.1 + random(0.2));
		sound_play_pitch(sndEnergyScrewdriverUpg, 1.2 + random(0.2));
	}
		
     // Projectiles:
    with(mod_script_call("mod", "Frontier_Projectiles", "StarBullet_create", x + lengthdir_x(14, gunangle), y + lengthdir_y(14, gunangle))){
		direction		= other.gunangle + (random_range(-6, 6) * other.accuracy);
		image_angle     = direction;
		team            = other.team;
		creator         = other;
    }
    
     // Particles:
    repeat(2){
	    with(mod_script_call("mod", "Frontier_Projectiles", "StarBulletTrail_create", x + lengthdir_x(14, gunangle), y + lengthdir_y(14, gunangle))){
			direction		= other.gunangle + (random_range(-24, 24) * other.accuracy);
			image_angle     = direction;
			team            = other.team;
			creator         = other;
			speed			= 3 + random(3);
			depth			= -3;
	    }
    }
    
   
     // Kick, Shift, Shake:
    weapon_post(3, 2, 2);
    motion_add(gunangle + 180, 0.8)
   
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
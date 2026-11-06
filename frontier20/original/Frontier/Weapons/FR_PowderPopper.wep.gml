#define init

     // Sprites:
    global.sprWeapon 	        = sprite_add_weapon("../Sprites/Weapons/sprPowderPopper.png", 4, 3);
    global.sprGunpowderShellSmall	= sprite_add("../Sprites/Particles/sprGunpowderShellSmall.png", 1, 2, 2);
    global.sprGunpowderShell		= sprite_add("../Sprites/Particles/sprGunpowderShell.png", 1, 2, 2);

#define weapon_name         return "POWDER POPPER";          
#define weapon_text         return "POP AND SIZZLE";
#define weapon_sprt         return global.sprWeapon;
#define weapon_type         return 2;
#define weapon_melee        return false;
#define weapon_area         return mod_script_call("mod", "Frontier_Projectiles", "check_piratedrops", mod_current, 9);
#define weapon_auto         return true;
#define weapon_load         return 7;
#define weapon_burst        return 4;
#define weapon_burst_time   return 2;
#define weapon_cost         return 2;
#define weapon_swap         return sndSwapShotgun;
#define weapon_handy		return true;
#define weapon_handy_data	return	{ x : 2, y : 4, bhand : true, bx : 10, by : 3 }

#define weapon_fire(_wep)


     // FireCont Support:
	var c = ((instance_is(self, FireCont) && "creator" in self) ? creator : self);

     // Sounds:
	sound_play_pitchvol((sndFireShotgun), 1.5 + random(0.2), 0.6);
	sound_play_gun((sndPopgun), 1, 0.8 + random(0.2));
		
     // Projectiles:
    with(mod_script_call("mod", "Frontier_Projectiles", "GunpowderShell_create", x, y)){
    	speed			= 11 + random(5);
		direction		= other.gunangle + (random_range(-15, 15) * other.accuracy);
		image_angle     = direction;
		team            = other.team;
		creator         = other;
    }
    
   
     // Kick, Shift, Shake:
    weapon_post(5, 5, 8);
    motion_add(gunangle + 180, 1)
   
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
    
#define weapon_reloaded
	repeat(3){
		with(instance_create(x, y, Shell)){
			sprite_index = skill_get(mut_shotgun_shoulders) ? global.sprGunpowderShell : global.sprGunpowderShellSmall;
			motion_add(other.gunangle + (other.right * 90) + random_range(-40, 40), 2 + random(2));
		}
	}
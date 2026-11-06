#define init

     // Sprites:
    global.sprWeapon 	        = sprite_add_weapon("../../Sprites/Weapons/Iris/sprPsyTemporalRifle.png", 6, 3);
    global.sprTemporalShell 	= sprite_add("../../Sprites/Particles/sprTemporalPsyShell.png", 1, 2, 3);

#define weapon_name         return "TEMPORAL PSY RIFLE";          
#define weapon_text         return "CAN YOU REMEMBER?";
#define weapon_sprt         return global.sprWeapon;
#define weapon_type         return 1;
#define weapon_melee        return false;
#define weapon_area         return -1;
#define weapon_auto         return true;
#define weapon_load         return 4;
#define weapon_burst        return 2;
#define weapon_burst_time   return 2;
#define weapon_cost         return 3;
#define weapon_swap         return sndSwapMachinegun;
#define weapon_handy		return true;
#define weapon_handy_data	return	{ x : 4, y : 4, bhand : true, bx : 14, by : 4 }

#define weapon_fire(_wep)


     // FireCont Support:
	var c = ((instance_is(self, FireCont) && "creator" in self) ? creator : self);

     // Sounds:
	sound_play_pitchvol((sndOasisShoot), 0.5 + random(0.4), 0.4);
	sound_play_pitchvol((sndPlasma), 1.8 + random(0.4), 0.4);
	sound_play_pitchvol(sndCursedReminder,	    0.8 + random(0.4), 0.8);
	
     // Projectiles:
    with(mod_script_call("mod", "Frontier_Projectiles2", "TelePsyBullet_create", x + lengthdir_x(8, gunangle), y + lengthdir_y(8, gunangle))){
		direction		= other.gunangle + (random_range(-13, 13) * other.accuracy);
		image_angle     = direction;
		team            = other.team;
		creator         = other;
    }

	with(instance_create(x, y, Shell)){
		sprite_index = global.sprTemporalShell;
		motion_add(other.gunangle + (other.right * 90) + random_range(-40, 40), 2 + random(3));
	}
	
   
     // Kick, Shift, Shake:
    weapon_post(6, 4, 4);
    motion_add(gunangle + 180, 0.5)
   
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
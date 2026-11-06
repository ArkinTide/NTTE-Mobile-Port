#define init

     // Sprites:
    global.sprWeapon 	        = sprite_add_weapon("../Sprites/Weapons/sprSpikerRifle.png", 2, 3);

#define weapon_name         return "SPIKER";          
#define weapon_text         return "PUT A PIN IN IT";
#define weapon_sprt         return global.sprWeapon;
#define weapon_type         return 3;
#define weapon_melee        return false;
#define weapon_area         return mod_script_call("mod", "Frontier_Projectiles", "check_piratedrops", mod_current, 7);
#define weapon_auto         return true;
#define weapon_load         return 18;
#define weapon_burst        return 6;
#define weapon_burst_time   return 2;
#define weapon_cost         return 2;
#define weapon_swap         return sndSwapBow;
#define weapon_handy		return true;
#define weapon_handy_data	return	{ x : 4, y : 4, bhand : false }

#define weapon_fire(_wep)


     // FireCont Support:
	var c = ((instance_is(self, FireCont) && "creator" in self) ? creator : self);

     // Sounds:
    sound_play_pitchvol(sndCrossbow, 1.2 + random(0.2), 1);
    sound_play_pitchvol(sndDiscgun, 1.2 + random(0.2), 1);
		
     // Projectiles:
    with(mod_script_call("mod", "Frontier_Projectiles", "SpikerSplinter_create", x, y)){
		direction		= other.gunangle + (random_range(-8, 8) * other.accuracy);
		image_angle     = direction;
		team            = other.team;
		creator         = other;
    }
    
   
     // Kick, Shift, Shake:
    weapon_post(3, 2, 2);
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
#define init

     // Sprites:
    global.sprWeapon 	        = sprite_add_weapon("../Sprites/Weapons/sprDoubleBlunderbuss.png", 4, 5);

#define weapon_name         return "BLUNDERBARREL";          
#define weapon_text         return "YOU CAN'T MAKE WINE WITH THIS"; // its cause grape(shot) in barrel and they would st whatever you get it
#define weapon_sprt         return global.sprWeapon;
#define weapon_type         return 2;
#define weapon_melee        return false;
#define weapon_area         return mod_script_call("mod", "Frontier_Projectiles", "check_piratedrops", mod_current, 8);
#define weapon_auto         return false;
#define weapon_load         return 48;
#define weapon_cost         return 4;
#define weapon_swap         return sndSwapShotgun;
#define weapon_handy		return true;
#define weapon_handy_data	return	{ x : 4, y : 4, bhand : true, bx : 10, by : 6 }

#define weapon_fire(_wep)


     // FireCont Support:
	var c = ((instance_is(self, FireCont) && "creator" in self) ? creator : self);

     // Sounds:
	sound_play_gun((sndFireShotgun), 1, 1 + random(0.2));
	sound_play_gun((sndFlakCannon), 1, 1 + random(0.2));
		
     // Projectiles:
    repeat(36){
    	with(mod_script_call("mod", "Frontier_Projectiles", "Grapeshot_create", x, y)){
    		speed			= 9 + random(6);
			direction		= other.gunangle + (random_range(-24, 24) * other.accuracy);
			team            = other.team;
			creator         = other;
    	}
    }
   
     // Smoke:
    repeat(12){
    	with(mod_script_call("mod", "Frontier_Projectiles", "WhiteDust_create", x, y)){
    		speed			= 3 + random(5);
			direction		= other.gunangle + (random_range(-28, 28) * other.accuracy);
			team            = other.team;
			creator         = other;
			depth			= -3;
    	}
    }
    
     // Kick, Shift, Shake:
    weapon_post(8, 10, 20);
    motion_add(gunangle + 180, 2)

#define weapon_reloaded
	sound_play_pitchvol(sndClick, 1.2 + random(0.3), 0.45);
	wkick -= 3;
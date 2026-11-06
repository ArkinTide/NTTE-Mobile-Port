#define init

     // Sprites:
    global.sprWeapon 	        = sprite_add_weapon("../Sprites/Weapons/sprCandleLauncher.png", 3, 4);

#define weapon_name         return "CANDLE LAUNCHER";          
#define weapon_text         return "ROMAN WARFARE";
#define weapon_sprt 		return global.sprWeapon;
#define weapon_type         return 4;
#define weapon_melee        return false;
#define weapon_area         return mod_script_call("mod", "Frontier_Projectiles", "check_piratedrops", mod_current, 7);
#define weapon_auto         return true;
#define weapon_load         return 12;
#define weapon_cost         return 2;
#define weapon_swap         return sndSwapExplosive;
#define weapon_handy		return true;
#define weapon_handy_data	return	{ x : 1, y : 3, bhand : true, bx : 7, by : 5 }

#define weapon_fire(_wep)

     // FireCont Support:
	var c = ((instance_is(self, FireCont) && "creator" in self) ? creator : self);

     // Sounds:
	sound_play_pitch(sndFireShotgun, 1.2 + random(0.2));
		
     // Projectiles:
	with(mod_script_call("mod", "Frontier_Projectiles", "FireworkCandle_create", x, y)){
		speed			= 16;
		direction		= other.gunangle + (random_range(-6, 6) * other.accuracy);
		image_angle		= direction;
		team            = other.team;
		creator         = other;
	}
	
     // Smoke:
    repeat(4){
    	with(mod_script_call("mod", "Frontier_Projectiles", "WhiteDust_create", x, y)){
    		speed			= 3 + random(5);
			direction		= other.gunangle + (random_range(-25, 25) * other.accuracy);
			team            = other.team;
			creator         = other;
    	}
    }
	
     // Kick, Shift, Shake:
    weapon_post(6, 30, 1.5);
    motion_add(gunangle + 180, 2)


	
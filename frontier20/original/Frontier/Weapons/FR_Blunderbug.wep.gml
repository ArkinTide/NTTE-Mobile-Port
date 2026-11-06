#define init

     // Sprites:
    global.sprWeapon 	        = sprite_add_weapon("../Sprites/Weapons/sprBlunderbug.png", 4, 3);

#define weapon_name         return "BLUNDERBUG";          
#define weapon_text         return "WAIT THATS NOT- HOLD ON";
#define weapon_sprt         return global.sprWeapon;
#define weapon_type         return 2;
#define weapon_melee        return false;
#define weapon_area         return mod_script_call("mod", "Frontier_Projectiles", "check_piratedrops", mod_current, 10);
#define weapon_auto         return false;
#define weapon_load         return 30;
#define weapon_cost         return 3;
#define weapon_swap         return sndSwapShotgun;
#define weapon_handy		return true;
#define weapon_handy_data	return	{ x : 4, y : 4, bhand : true, bx : 10, by : 5 }

#define weapon_fire(_wep)

     // FireCont Support:
	var c = ((instance_is(self, FireCont) && "creator" in self) ? creator : self);

     // Sounds:
	sound_play_gun((sndFireShotgun), 1, 1 + random(0.2));
	sound_play_gun((sndSawedOffShotgun), 1, 1 + random(0.2));
		
     // Projectiles:
    repeat(28){
    	with(mod_script_call("mod", "Frontier_Projectiles", "Grapeshot_create", x, y)){
    		speed			= 5 + random(12);
			direction		= other.gunangle + (random_range(-6, 6) * other.accuracy);
			team            = other.team;
			creator         = other;
    	}
    }
    
     // Smoke:
    repeat(8){
    	with(mod_script_call("mod", "Frontier_Projectiles", "WhiteDust_create", x, y)){
    		speed			= 3 + random(10);
			direction		= other.gunangle + (random_range(-12, 12) * other.accuracy);
			team            = other.team;
			creator         = other;
			depth			= -3;
    	}
    }
   
     // Kick, Shift, Shake:
    weapon_post(8, 6, 10);
    motion_add(gunangle + 180, 2)

#define weapon_reloaded


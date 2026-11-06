#define init

     // Sprites:
    global.sprWeapon 	        = sprite_add_weapon("../Sprites/Weapons/sprAutoBlunderbuss.png", 4, 2);

#define weapon_name         return "BLUNDUNDERBUSS";          
#define weapon_text         return "G-G-G-G-GRAPES!";
#define weapon_sprt         return global.sprWeapon;
#define weapon_type         return 2;
#define weapon_melee        return false;
#define weapon_area         return (mod_variable_get("mod", "Frontier_Projectiles", "settingNaturalPirateWeps") = true) ? 10 : -1;
#define weapon_auto         return true;
#define weapon_load         return 5;
#define weapon_cost         return 1;
#define weapon_swap         return sndSwapShotgun;
#define weapon_handy		return true;
#define weapon_handy_data	return	{ x : 6, y : 4, bhand : true, bx : 14, by : 5 }

#define weapon_fire(_wep)

     // FireCont Support:
	var c = ((instance_is(self, FireCont) && "creator" in self) ? creator : self);

     // Sounds:
	sound_play_gun((sndFireShotgun), 1, 1 + random(0.2));
	sound_play_gun((sndShotgun), 1, 1 + random(0.2));
		
     // Projectiles:
    repeat(5){
    	with(mod_script_call("mod", "Frontier_Projectiles", "Grapeshot_create", x, y)){
    		speed			= 10 + random(6);
			direction		= other.gunangle + (random_range(-19, 19) * other.accuracy);
			team            = other.team;
			creator         = other;
    	}
    }
    
     // Smoke:
    repeat(3){
    	with(mod_script_call("mod", "Frontier_Projectiles", "WhiteDust_create", x, y)){
    		speed			= 3 + random(5);
			direction		= other.gunangle + (random_range(-27, 27) * other.accuracy);
			team            = other.team;
			creator         = other;
			depth			= -3;
    	}
    }
   
     // Kick, Shift, Shake:
    weapon_post(5, 6, 10);

#define weapon_reloaded
	wkick -= 3;

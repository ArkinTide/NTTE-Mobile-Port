#define init

     // Sprites:
    global.sprWeapon 	        = sprite_add_weapon("../Sprites/Weapons/sprGildedFireworkCannon.png", 12, 9);
    global.sndFireworkCannon	= mod_variable_get("weapon", "FR_FireworkCannon", "sndFireworkCannon")

#define weapon_name         return "GILDED FIREWORK CANNON";          
#define weapon_text         return "TOO BRIGHT!!!";
#define weapon_sprt         return global.sprWeapon;
#define weapon_type         return 4;
#define weapon_melee        return false;
#define weapon_area         return -1;
#define weapon_auto         return true;
#define weapon_load         return 24;
#define weapon_cost         return 2;
#define weapon_swap         return sndSwapShotgun;
#define weapon_handy		return true;
#define weapon_handy_data	return	{ x : -1, y : 5, bhand : true, bx : 10, by : 5 }

#define weapon_fire(_wep)

     // FireCont Support:
	var c = ((instance_is(self, FireCont) && "creator" in self) ? creator : self);

     // Sounds:
	sound_play_pitch((global.sndFireworkCannon), 1 + random(0.2));
	sound_play_gun((sndConfettiGun), 1, 0.7 + random(0.2));
	sound_play_gun((sndGoldPistol), 1, 1.2 + random(0.2));
	
     // Projectiles:
	with(mod_script_call("mod", "Frontier_Projectiles", "GoldFireworkRocket_create", x, y)){
		direction		= other.gunangle + (random_range(-4, 4) * other.accuracy);
		image_angle		= direction;
		team            = other.team;
		creator         = other;
	}
  
    
     // Smoke:
    repeat(12){
    	with(mod_script_call("mod", "Frontier_Projectiles", "WhiteDust_create", x, y)){
    		speed			= 3 + random(5);
			direction		= other.gunangle + (random_range(-45, 45) * other.accuracy);
			team            = other.team;
			creator         = other;
    	}
    }
   
     // Kick, Shift, Shake:
    weapon_post(8, 6, 10);
    motion_add(gunangle + 180, 2)


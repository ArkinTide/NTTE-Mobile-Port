#define init

     // Sprites:
	global.sprWeapon 	        = sprite_add_weapon("../Sprites/Weapons/sprCoralAutoCrossbow.png", 6, 6);

#define weapon_name         return "CORAL REEFPEATER";          
#define weapon_text         return "GET IT? IT'S LIKE- NEVERMIND";
#define weapon_sprt         return global.sprWeapon;
#define weapon_type         return 3;
#define weapon_melee        return false;
#define weapon_area         return mod_script_call("mod", "Frontier_Projectiles", "check_piratedrops", mod_current, 12);
#define weapon_auto         return true;
#define weapon_load         return 14;
#define weapon_cost         return 3;
#define weapon_swap         return sndSwapBow;
#define weapon_handy		return true;
#define weapon_handy_data	return	{ x : 2, y : 4, bhand : true, bx : 10, by : 6 }

#define weapon_fire(_wep)

     // FireCont Support:
	var c = ((instance_is(self, FireCont) && "creator" in self) ? creator : self);

     // Sounds:
	sound_play_gun((sndCrossbow), 1, 1 + random(0.2));
	sound_play_pitchvol(sndPlantFire, 1.1 + random(0.2), 0.8);
		
     // Projectiles:
    with(mod_script_call("mod", "Frontier_Projectiles", "CoralBolt_create", x, y)){
		direction		= other.gunangle + (random_range(-5, 5) * other.accuracy);
		image_angle     = direction;
		team            = other.team;
		creator         = other;
    }
    
   
     // Kick, Shift, Shake:
    weapon_post(8, 2, 2);
    motion_add(gunangle + 180, 1)
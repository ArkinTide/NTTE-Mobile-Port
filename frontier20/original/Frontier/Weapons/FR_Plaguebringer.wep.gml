#define init

     // Sprites:
	global.sprWeapon 	        = sprite_add_weapon("../Sprites/Weapons/sprPlaguebringer.png", 6, 5);

#define weapon_name         return "PLAGUEBRINGER";          
#define weapon_text         return "DON'T STAND TOO CLOSE";
#define weapon_sprt         return global.sprWeapon;
#define weapon_type         return 3;
#define weapon_melee        return false;
#define weapon_area         return (mod_variable_get("mod", "Frontier_Projectiles", "settingNaturalLabsWeps") = true) ? 21 : -1;
#define weapon_auto         return false;
#define weapon_load         return 55;
#define weapon_cost         return 5;
#define weapon_swap         return sndSwapBow;

#define weapon_handy		return true;
#define weapon_handy_data	return	{ x : 0, y : 2, bhand : true, bx : 8, by : 7 }

#define weapon_fire(_wep)

     // FireCont Support:
	var c = ((instance_is(self, FireCont) && "creator" in self) ? creator : self);

     // Sounds:
	sound_play_gun((sndSuperCrossbow), 1, 1 + random(0.2));
	sound_play_gun((sndToxicLauncher), 1, 1 + random(0.2));
		
     // Projectiles:
    with(mod_script_call("mod", "Frontier_Projectiles2", "PlagueBolt_create", x, y)){
		direction		= other.gunangle + (random_range(-1, 1) * other.accuracy);
		image_angle     = direction;
		team            = other.team;
		creator         = other;
    }
    
   
     // Kick, Shift, Shake:
    weapon_post(8, 2, 2);
    motion_add(gunangle + 180, 1)
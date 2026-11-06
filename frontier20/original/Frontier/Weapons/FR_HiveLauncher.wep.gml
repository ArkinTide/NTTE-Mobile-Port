#define init

     // Sprites:
    global.sprWeapon 	        = sprite_add_weapon("../Sprites/Weapons/sprHiveLauncher.png", 12, 11);
  
#define weapon_name         return "HIVE LAUNCHER";          
#define weapon_text         return "OUGH! BUGS!";
#define weapon_sprt         return global.sprWeapon;
#define weapon_type         return 4;
#define weapon_melee        return false;
#define weapon_area         return (mod_variable_get("mod", "Frontier_Projectiles", "settingNaturalLabsWeps") = true) ? 21 : -1;
#define weapon_auto         return true;
#define weapon_load         return 32;
#define weapon_cost         return 5;
#define weapon_swap         return sndSwapMachinegun;
#define weapon_handy		return true;
#define weapon_handy_data	return	{ x : 2, y : 5, bhand : true, bx : 10, by : 6 }

#define weapon_fire(_wep)

     // FireCont Support:
	var c = ((instance_is(self, FireCont) && "creator" in self) ? creator : self);

     // Sounds:
	sound_play_pitchvol(sndSuperBazooka,	    0.9 + random(0.3), 0.75);
	sound_play_pitchvol(sndHeavyMachinegun,	    1.2 + random(0.3), 1);
	sound_play_pitchvol(sndRocketFly,	    	0.7 + random(0.2), 1);
		
     // Projectiles:
	for(var i = -14; i <= 14; i += 14){
		with(mod_script_call("mod", "Frontier_Projectiles2", "HiveRocket_create", x + lengthdir_x(10, gunangle), y + lengthdir_y(10, gunangle))){
			direction	= other.gunangle + (i * other.accuracy);
			image_angle = direction;
		}
	}
	
     // Kick, Shift, Shake:
    weapon_post(10, 30, 20);
    motion_add(gunangle + 180, 1)
   
	 // Dust:
	repeat(6){
		with(instance_create(x, y, Smoke)){
			direction	= other.gunangle + random_range(-45, 45);
			speed		= 3 + random(2);
		}
	}
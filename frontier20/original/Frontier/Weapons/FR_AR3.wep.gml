#define init

     // Sprites:
    global.sprWeapon 	        = sprite_add_weapon("../Sprites/Weapons/sprAR3.png", 8, 5);
  
#define weapon_name         return "H.E.P.V.O.D.D.";          
#define weapon_text         return "'HIGH ENERGY PELLET'-BASED#VAPORIZATION-ORIENTED#DISTURBANCE DISRUPTOR";
#define weapon_sprt         return global.sprWeapon;
#define weapon_type         return 5;
#define weapon_melee        return false;
#define weapon_area         return (mod_variable_get("mod", "Frontier_Projectiles", "settingNaturalLabsWeps") = true) ? 21 : -1;
#define weapon_auto         return true;
#define weapon_load         return 24;
#define weapon_cost         return 6;
#define weapon_swap         return sndSwapMachinegun;
#define weapon_handy		return true;
#define weapon_handy_data	return	{ x : 1, y : 5, bhand : true, bx : 10, by : 5 }

#define weapon_fire(_wep)

     // FireCont Support:
	var c = ((instance_is(self, FireCont) && "creator" in self) ? creator : self);

     // Sounds:
	if(skill_get(mut_laser_brain) > 0){
		sound_play_pitch(sndEnergyHammerUpg, 0.7 + random(0.3));
		sound_play_pitch(sndPlasmaHit, 0.45 + random(0.3));
		sound_play_pitch(sndPlasmaUpg, 1.15 + random(0.3));					
	} else {
		sound_play_pitch(sndEnergyHammerUpg, 0.7 + random(0.3));
		sound_play_pitch(sndPlasmaHit, 0.45 + random(0.3));
		sound_play_pitch(sndPlasma, 1.15 + random(0.3));	
	}
		
     // Projectiles:
	with(mod_script_call("mod", "Frontier_Projectiles2", "EnergyPellet_create", x, y)){
		direction	= other.gunangle + (random_range(-4, 4) * other.accuracy);
		image_angle = direction;
	}
	
     // Kick, Shift, Shake:
    weapon_post(10, 2, 2);
    motion_add(gunangle + 180, 1)
   
	 // Dust:
	repeat(3){
		with(instance_create(x, y, Dust)){
			sprite_index	= sprSmoke;
			direction		= other.gunangle + random_range(-45, 45);
			speed			= 3 + random(2);
			depth			= -3
		}
	}
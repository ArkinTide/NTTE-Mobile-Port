#define init

     // Sprites:
	global.sprWeapon 	        = sprite_add_weapon("../Sprites/Weapons/sprCoralSuperCrossbow.png", 10, 11);

#define weapon_name         return "REEFSEEDER";          
#define weapon_text         return "A LITTLE LATE FOR THAT";
#define weapon_sprt         return global.sprWeapon;
#define weapon_type         return 3;
#define weapon_melee        return false;
#define weapon_area         return mod_script_call("mod", "Frontier_Projectiles", "check_piratedrops", mod_current, 14);
#define weapon_auto         return true;
#define weapon_load         return 38;
#define weapon_cost         return 7;
#define weapon_swap         return sndSwapBow;
#define weapon_laser_sight	return 0;
#define weapon_handy		return true;
#define weapon_handy_data	return	{ x : 2, y : 5, bhand : true, bx : 9, by : 4 }

#define weapon_fire(_wep)

     // FireCont Support:
	var c = ((instance_is(self, FireCont) && "creator" in self) ? creator : self);

     // Sounds:
	sound_play_gun((sndCrossbow), 1, 0.5 + random(0.2));
	sound_play_pitch((sndGrenadeRifle), 1.3 + random(0.2));
	sound_play_pitchvol(sndPlantSnare, 1.2 + random(0.2), 0.7);
		
     // Projectiles:
    var _spread = -8 * accuracy,
    	_angle	= gunangle
    	
    repeat(3){
	    with(mod_script_call("mod", "Frontier_Projectiles", "CoralBolt_create", x, y)){
	    	image_blend		= coralColor;
	    	
			direction		= _angle + _spread;
			image_angle		= direction;
			_spread 		+= 8 * other.accuracy;
			team            = other.team;
			creator         = other;
	    }
    }
    
   
     // Kick, Shift, Shake:
    weapon_post(8, 2, 2);
    motion_add(gunangle + 180, 1)
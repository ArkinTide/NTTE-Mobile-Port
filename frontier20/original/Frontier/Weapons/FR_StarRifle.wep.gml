#define init

     // Sprites:
    global.sprWeapon 	        = sprite_add_weapon("../Sprites/Weapons/sprStarlightRifle.png",	4, 3);

#define weapon_name         return "URSA MINOR";          
#define weapon_text         return "STARLIGHT FIGHTS";
#define weapon_sprt         return global.sprWeapon;
#define weapon_type         return 5;
#define weapon_melee        return false;
#define weapon_area         return mod_script_call("mod", "Frontier_Projectiles", "check_piratedrops", mod_current, 11);
#define weapon_auto         return true;
#define weapon_load         return 15;
#define weapon_cost         return 5;
#define weapon_swap         return sndSwapShotgun;
#define weapon_handy		return true;
#define weapon_handy_data	return	{ x : 4, y : 5, bhand : true, bx : 10, by : 6 }

#define weapon_fire(_wep)


     // FireCont Support:
	var c = ((instance_is(self, FireCont) && "creator" in self) ? creator : self);

     // Sounds:
	if(skill_get(mut_laser_brain) > 0){
		sound_play_pitch(sndSwapGold, 1.1 + random(0.2));
		sound_play_pitch(sndExplosion, 1.2 + random(0.2));
		sound_play_pitch(sndEnergyHammer, 1.2 + random(0.2));					
	} else {
		sound_play_pitch(sndSwapGold, 1.1 + random(0.2));
		sound_play_pitch(sndExplosionS, 1.2 + random(0.2));
		sound_play_pitch(sndEnergyHammer, 1.2 + random(0.2));	
	}

		
     // Projectiles:
    var _spd = 0;
    repeat(8){
	    with(mod_script_call("mod", "Frontier_Projectiles", "StarBullet_create", x + lengthdir_x(12, gunangle), y + lengthdir_y(12, gunangle))){
	    	speed			= 10 + _spd;
			direction		= other.gunangle + (random_range(-3, 3) * other.accuracy);
			image_angle     = direction;
			team            = other.team;
			creator         = other;
	    }
	    _spd += 1;
    }
    
     // Particles:
    repeat(12){
	    with(mod_script_call("mod", "Frontier_Projectiles", "StarBulletTrail_create", x + lengthdir_x(8, gunangle), y + lengthdir_y(8, gunangle))){
			direction		= other.gunangle + (random_range(-24, 24) * other.accuracy);
			image_angle     = direction;
			team            = other.team;
			creator         = other;
			speed			= 3 + random(3);
			depth			= -3;
	    }
    }
    
   
     // Kick, Shift, Shake:
    weapon_post(3, 2, 2);
    motion_add(gunangle + 180, 1)
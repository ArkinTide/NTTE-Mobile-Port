#define init

     // Sprites:
    global.sprWeapon 	        = sprite_add_weapon("../Sprites/Weapons/sprDoublePowderShotgun.png", 4, 3);
    global.sprGunpowderShell	= sprite_add("../Sprites/Particles/sprGunpowderShell.png", 1, 2, 2);
    global.sprGunpowderShellBig	= sprite_add("../Sprites/Particles/sprGunpowderShellBig.png", 1, 3, 3);

#define weapon_name         return "DOUBLE POWDER SHOTGUN";          
#define weapon_text         return "THINGS ARE HEATING UP";
#define weapon_sprt         return global.sprWeapon;
#define weapon_type         return 2;
#define weapon_melee        return false;
#define weapon_area         return mod_script_call("mod", "Frontier_Projectiles", "check_piratedrops", mod_current, 10);
#define weapon_auto         return false;
#define weapon_load         return 42;
#define weapon_cost         return 6;
#define weapon_swap         return sndSwapShotgun;
#define weapon_handy		return true;
#define weapon_handy_data	return	{ x : 4, y : 4, bhand : true, bx : 14, by : 5 }

#define weapon_fire(_wep)


     // FireCont Support:
	var c = ((instance_is(self, FireCont) && "creator" in self) ? creator : self);

     // Sounds:
	sound_play_gun((sndGrenadeShotgun), 1, 1.2 + random(0.2));
	sound_play_gun((sndDoubleFireShotgun), 1, 0.8 + random(0.2));
		
     // Projectiles:
    repeat(13){
    	with(mod_script_call("mod", "Frontier_Projectiles", "GunpowderShell_create", x, y)){
    		speed			= 10 + random(7);
			direction		= other.gunangle + (random_range(-26, 26) * other.accuracy);
			image_angle     = direction;
			team            = other.team;
			creator         = other;
    	}
    }
   
     // Kick, Shift, Shake:
    weapon_post(8, 7, 7);
    motion_add(gunangle + 180, 3)

#define weapon_reloaded
	wkick = -4;
	sound_play(sndShotReload);
	repeat(weapon_cost()){
		with(instance_create(x, y, Shell)){
			sprite_index = skill_get(mut_shotgun_shoulders) ? global.sprGunpowderShellBig : global.sprGunpowderShell;
			motion_add(other.gunangle + (other.right * 90) + random_range(-40, 40), 2 + random(2));
		}
	}

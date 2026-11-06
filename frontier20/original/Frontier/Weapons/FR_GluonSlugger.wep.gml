#define init

     // Sprites:
    global.sprWeapon 	        = sprite_add_weapon("../Sprites/Weapons/sprGluonSlugger.png", 4, 3);
    global.sprGluonSlugShell 	= sprite_add("../Sprites/Particles/sprGluonSlugShell.png", 1, 2, 3);
    global.sprGluonSlugShellBig = sprite_add("../Sprites/Particles/sprGluonSlugShellBig.png", 1, 3, 4);

#define weapon_name         return "SLUGLUON";          
#define weapon_text         return "ITS QUARKY!!!!!";
#define weapon_sprt         return global.sprWeapon;
#define weapon_type         return 2;
#define weapon_melee        return false;
#define weapon_area         return (mod_variable_get("mod", "Frontier_Projectiles", "settingNaturalLabsWeps") = true) ? 21 : -1;
#define weapon_auto         return true;
#define weapon_load         return 40;
#define weapon_cost         return 4;
#define weapon_swap         return sndSwapShotgun;

#define weapon_handy		return true;
#define weapon_handy_data	return	{ x : 2, y : 4, bhand : true, bx : 13, by : 5 }

#define weapon_fire(_wep)


     // FireCont Support:
	var c = ((instance_is(self, FireCont) && "creator" in self) ? creator : self);

     // Sounds:
	sound_play_gun((sndHeavySlugger), 1.2, 1 + random(0.2));
	sound_play_gun((sndPlasmaHit), 1.2, 1 + random(0.2));
		
     // Projectiles:
    with(mod_script_call("mod", "Frontier_Projectiles2", "GluonSlug_create", x + lengthdir_x(10, gunangle), y + lengthdir_y(10, gunangle))){
		direction		= other.gunangle + (random_range(-8, 8) * other.accuracy);
		image_angle     = direction;
		team            = other.team;
		creator         = other;
    }
    
   
     // Kick, Shift, Shake:
    weapon_post(14, 40, 30);
    motion_add(gunangle + 180, 1)
    
#define weapon_reloaded
	wkick = -4
	sound_play(sndShotReload)
	sound_play_pitch(sndPlasmaReloadUpg, 0.8)
	with(instance_create(x, y, Shell)){
		sprite_index = skill_get(mut_shotgun_shoulders) ? global.sprGluonSlugShellBig : global.sprGluonSlugShell;
		motion_add(other.gunangle + (other.right * 90) + random_range(-40, 40), 2 + random(2));
	}
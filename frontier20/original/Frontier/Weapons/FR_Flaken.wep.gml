#define init

     // Sprites:
    global.sprWeapon 	        = sprite_add_weapon("../Sprites/Weapons/sprFlaken.png", 						4, 3);
	global.sprInkFlakRing		= sprite_add("../sprites/particles/sprInkFlakRing.png", 						6, 5, 13);

#define weapon_name         return "FLAKEN";          
#define weapon_text         return choose("DON'T STAND TOO CLOSE", "I CANT SEE");
#define weapon_sprt         return global.sprWeapon;
#define weapon_type         return 2;
#define weapon_melee        return false;
#define weapon_area         return mod_script_call("mod", "Frontier_Projectiles", "check_piratedrops", mod_current, 12);
#define weapon_auto         return false;
#define weapon_load         return 25;
#define weapon_cost         return 2;
#define weapon_swap         return sndSwapShotgun;
#define weapon_handy		return true;
#define weapon_handy_data	return	{ x : 1, y : 4, bhand : true, bx : 10, by : 5 }

#define weapon_fire(_wep)

     // FireCont Support:
	var c = ((instance_is(self, FireCont) && "creator" in self) ? creator : self);

     // Sounds:
	sound_play_gun((sndOasisChest), 1, 1 + random(0.2));
	sound_play_gun((sndSlugger), 1, 1 + random(0.2));
		
     // Projectiles:
	with(mod_script_call("mod", "Frontier_Projectiles", "InkBigFlak_create", x, y)){
		direction		= other.gunangle + (random_range(-3, 3) * other.accuracy);
		image_angle		= direction;
		team            = other.team;
		creator         = other;
	}
   
	with(instance_create(x + lengthdir_x(14, gunangle), y + lengthdir_y(14, gunangle), CaveSparkle)){
		sprite_index	= global.sprInkFlakRing;
		image_speed		= 0.6;
		image_angle		= other.gunangle;
	}
   
     // Kick, Shift, Shake:
    weapon_post(8, 6, 10);
    motion_add(gunangle + 180, 2)

#define weapon_reloaded
	sound_play_pitchvol(sndOasisShoot, 1.2 + random(0.3), 0.45);
	wkick -= 3;

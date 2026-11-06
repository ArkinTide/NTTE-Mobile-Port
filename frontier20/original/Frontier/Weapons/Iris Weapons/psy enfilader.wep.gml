#define init

     // Sprites:
    global.sprWeapon 	        = sprite_add_weapon("../../Sprites/Weapons/Iris/sprPsyEnfilader.png", 6, 4);
  
#define weapon_name         return "PSY ENFILADER";          
#define weapon_text         return "PSYCHIC ATTACK AGAIN";
#define weapon_sprt         return global.sprWeapon;
#define weapon_type         return 1;
#define weapon_melee        return false;
#define weapon_area         return -1;
#define weapon_auto         return true;
#define weapon_load         return 16;
#define weapon_cost         return 10;
#define weapon_swap         return sndSwapMachinegun;
#define weapon_handy		return true;
#define weapon_handy_data	return	{ x : 2, y : 5, bhand : true, bx : 10, by : 6 }
#define weapon_fire(_wep)

     // FireCont Support:
	var c = ((instance_is(self, FireCont) && "creator" in self) ? creator : self);

     // Sounds:
	sound_play_pitchvol(sndSawedOffShotgun,		1.1 + random(0.3), 0.75);
	sound_play_pitchvol(sndHitMetal,	    	1.2 + random(0.3), 1);
	sound_play_pitchvol(sndCursedReminder,	    0.8 + random(0.3), 1);
	sound_play_pitchvol(sndQuadMachinegun,	    1.2 + random(0.3), 0.6);
		
     // Projectiles:
    repeat(14){
		with(mod_script_call("mod", "defpack tools", "create_psy_bullet", x, y)){
			speed			= 8 + random_range(-2, 4);
			direction		= other.gunangle + (random_range(-14, 14) * other.accuracy);
			image_angle     = direction;
			team            = other.team;
			creator         = other;
		}
    }
	
     // Kick, Shift, Shake:
    weapon_post(10, 16, 20);
    motion_add(gunangle + 180, 1)
   
	 // Dust:
	repeat(6){
		with(instance_create(x, y, Dust)){
			sprite_index	= sprSmoke;
			direction		= other.gunangle + random_range(-45, 45);
			speed			= 3 + random(2);
		}
	}
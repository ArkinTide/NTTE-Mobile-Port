#define init

     // Sprites:
    global.sprWeapon 	        = sprite_add_weapon("../../Sprites/Weapons/Iris/sprGammaEnfilader.png", 5, 4);
  
#define weapon_name         return "GAMMA ENFILADER";          
#define weapon_text         return "HORROR SHOW";
#define weapon_sprt         return global.sprWeapon;
#define weapon_type         return 1;
#define weapon_melee        return false;
#define weapon_area         return -1;
#define weapon_auto         return true;
#define weapon_load         return 16;
#define weapon_cost         return 10;
#define weapon_swap         return sndSwapMachinegun;
#define weapon_handy		return true;
#define weapon_handy_data	return	{ x : 2, y : 5, bhand : true, bx : 10, by : 5 }
#define weapon_fire(_wep)

     // FireCont Support:
	var c = ((instance_is(self, FireCont) && "creator" in self) ? creator : self);

     // Sounds:
	sound_play_pitchvol(sndSawedOffShotgun,	    0.9 + random(0.3), 0.75);
	sound_play_pitchvol(sndHeavyMachinegun,	    1.2 + random(0.3), 1);
	sound_play_pitchvol(sndUltraPistol,	    	0.8 + random(0.3), 1);
	sound_play_pitchvol(sndQuadMachinegun,	    1.2 + random(0.3), 1);
		
     // Projectiles:
    repeat(14){
		with(mod_script_call("mod", "defpack tools", "create_gamma_bullet", x, y)){
			speed			= 12 + random_range(-5, 10);
			direction		= other.gunangle + (random_range(-20, 20) * other.accuracy);
			image_angle     = direction;
			team            = other.team;
			creator         = other;
		}
    }
    repeat(14){
		with(mod_script_call("mod", "defpack tools", "create_gamma_bullet", x, y)){
			speed			= 12 + random_range(-5, 10);
			direction		= other.gunangle + (random_range(-35, 35) * other.accuracy);
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
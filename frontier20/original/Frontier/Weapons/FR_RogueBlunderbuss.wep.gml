#define init

     // Sprites:
    global.sprWeapon 	        = sprite_add_weapon("../Sprites/Weapons/sprRogueBlunderbuss.png", 4, 2);

#define weapon_name         return "MUTINEER BLUNDERBUSS";          
#define weapon_text         return "MUTANTNEER!!";
#define weapon_sprt         return global.sprWeapon;
#define weapon_type         return 2;
#define weapon_melee        return false;
#define weapon_area         return -1;
#define weapon_auto         return false;
#define weapon_load         return 24;
#define weapon_cost         return 2;
#define weapon_swap         return sndSwapShotgun;
#define weapon_handy		return true;
#define weapon_handy_data	return	{ x : 6, y : 4, bhand : true, bx : 12, by : 4 }

#define weapon_fire(_wep)

     // FireCont Support:
	var c = ((instance_is(self, FireCont) && "creator" in self) ? creator : self);

     // Sounds:
	sound_play_gun((sndRogueRifle), 1, 1 + random(0.2));
	sound_play_gun((sndDoubleShotgun), 1, 1 + random(0.2));
		
     // Projectiles:
    repeat(14){
    	with(mod_script_call("mod", "Frontier_Projectiles", "PopoGrapeshot_create", x, y)){
    		speed			= 12 + random(5);
			direction		= other.gunangle + (random_range(-13, 13) * other.accuracy);
			team            = other.team;
			creator         = other;
    	}
    }
    
     // Smoke:
    repeat(8){
    	with(instance_create(x, y, Smoke)){
    		speed			= 3 + random(5);
			direction		= other.gunangle + (random_range(-22, 22) * other.accuracy);
			team            = other.team;
			creator         = other;
			depth			= -3;
    	}
    }
   
     // Kick, Shift, Shake:
    weapon_post(8, 6, 10);
    motion_add(gunangle + 180, 2)

#define weapon_reloaded
	sound_play_pitchvol(sndClick, 1.2 + random(0.3), 0.45);
	wkick -= 3;

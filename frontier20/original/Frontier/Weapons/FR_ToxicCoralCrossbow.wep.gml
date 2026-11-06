#define init

     // Sprites:
    global.sprWeapon 	        = sprite_add_weapon("../Sprites/Weapons/sprToxicCoralCrossbow.png",	8, 8);
 
#define weapon_name         return "TOXICORAL BOWCANNON";          
#define weapon_text         return "ROTTED REEFS"; 
#define weapon_sprt 		return global.sprWeapon;
#define weapon_type         return 3;
#define weapon_melee        return false;
#define weapon_area         return mod_script_call("mod", "Frontier_Projectiles", "check_piratedrops", mod_current, 10);
#define weapon_auto         return true;
#define weapon_load         return 26;
#define weapon_cost         return 3;
#define weapon_swap         return sndSwapBow;
#define weapon_handy		return true;
#define weapon_handy_data	return	{ x : 2, y : 4, bhand : true, bx : 13, by : 3 }

#define weapon_fire(_wep)

     // FireCont Support:
	var c = ((instance_is(self, FireCont) && "creator" in self) ? creator : self);

     // Sounds:
	sound_play_gun((sndCrossbow), 1, 0.5 + random(0.2));
	sound_play_pitch((sndGrenadeRifle), 1.3 + random(0.2));
	sound_play_pitchvol(sndToxicBoltGas, 1.2 + random(0.2), 0.7);
		
     // Projectiles:
    repeat(1){
	    with(mod_script_call("mod", "Frontier_Projectiles", "ToxicCoralBolt_create", x, y)){
	    	
			direction		= other.gunangle + (random_range(-1, 1) * other.accuracy);
			image_angle     = direction;
			team            = other.team;
			creator         = other;
	    }
    }
    
   
     // Kick, Shift, Shake:
    weapon_post(8, 2, 2);
    motion_add(gunangle + 180, 1)

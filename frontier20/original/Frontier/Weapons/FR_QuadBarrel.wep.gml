#define init

     // Sprites:
    global.sprWeapon 	        = sprite_add_weapon("../Sprites/Weapons/sprQuadBarrel.png", 4, 7);

#define weapon_name         return "QUAD-BARREL";          
#define weapon_text         return "BLOW THE MAN DOWN";
#define weapon_sprt         return global.sprWeapon;
#define weapon_type         return 2;
#define weapon_melee        return false;
#define weapon_area         return mod_script_call("mod", "Frontier_Projectiles", "check_piratedrops", mod_current, 12);
#define weapon_auto         return false;
#define weapon_load         return 120;
#define weapon_cost         return 15;
#define weapon_swap         return sndSwapShotgun;
#define weapon_handy		return true;
#define weapon_handy_data	return	{ x : 7, y : 5, bhand : true, bx : 14, by : 7 }

#define weapon_fire(_wep)

     // FireCont Support:
	var c = ((instance_is(self, FireCont) && "creator" in self) ? creator : self);

     // Sounds:
	sound_play_gun((sndSuperFlakCannon), 1, 1 + random(0.2));
	sound_play_gun((sndDoubleShotgun), 1, 1 + random(0.2));
	sound_play_gun((sndNukeExplosion), 1, 1 + random(0.2));
	
	 // WOW!!!!!!
	instance_create(x, y, PortalClear);
		
     // Projectiles:
    repeat(56){
    	with(mod_script_call("mod", "Frontier_Projectiles", "Grapeshot_create", x, y)){
    		speed			= 10 + random(10);
			direction		= other.gunangle + (random_range(-32, 32) * other.accuracy);
			team            = other.team;
			creator         = other;
    	}
    }
    repeat(16){
    	with(instance_create(x, y, Bullet2)){
    		speed			= 4 + random(16);
			direction		= other.gunangle + (random_range(-32, 32) * other.accuracy);
			image_angle		= direction
        	friction		= 0.4 + random_range(-0.2, 0.2);
			team            = other.team;
			creator         = other;
    	}
    }
    repeat(4){
    	with(instance_create(x, y, FlakBullet)){
    		speed			= 4 + random(16);
			direction		= other.gunangle + (random_range(-32, 32) * other.accuracy);
			image_angle		= direction
        	friction		= 0.4 + random_range(-0.2, 0.2);
			team            = other.team;
			creator         = other;
    	}
    }
    repeat(12){
    	with(instance_create(x, y, Slug)){
    		speed			= 4 + random(16);
			direction		= other.gunangle + (random_range(-32, 32) * other.accuracy);
			image_angle		= direction
        	friction		= 0.4 + random_range(-0.2, 0.2);
			team            = other.team;
			creator         = other;
    	}
    }
    
     // Smoke:
    repeat(16){
    	with(mod_script_call("mod", "Frontier_Projectiles", "WhiteDust_create", x, y)){
    		speed			= 5 + random(8);
			direction		= other.gunangle + (random_range(-22, 22) * other.accuracy);
			team            = other.team;
			creator         = other;
			depth			= -3;
    	}
    }
   
     // Kick, Shift, Shake:
    weapon_post(16, 70, 70);
    motion_add(gunangle + 180, 20)

#define weapon_reloaded
	sound_play_pitchvol(sndClick, 0.5 + random(0.3), 0.45);
	wkick -= 3;


#define init

     // Sprites:
    global.sprWeapon 	        = sprite_add_weapon("../Sprites/Weapons/sprHeavyBlunderballCannon.png", 9, 7);
  
#define weapon_name         return "BLUNDERBOULDER CANNON";          
#define weapon_text         return "SMACK IT";
#define weapon_sprt         return global.sprWeapon;
#define weapon_type         return 4;
#define weapon_melee        return false;
#define weapon_area         return mod_script_call("mod", "Frontier_Projectiles", "check_piratedrops", mod_current, 9);
#define weapon_auto         return false;
#define weapon_load         return 38;
#define weapon_cost         return 4;
#define weapon_swap         return sndSwapExplosive;
#define weapon_handy		return true;
#define weapon_handy_data	return	{ x : -3, y : 4, bhand : true, bx : 10, by : 6 }

#define weapon_fire(_wep)

     // FireCont Support:
	var c = ((instance_is(self, FireCont) && "creator" in self) ? creator : self);

     // Sounds:
	sound_play_pitchvol(sndHeavyNader,	        0.9 + random(0.3), 0.75);
	sound_play_pitchvol(sndGrenadeRifle,	    1.2 + random(0.3), 1);
		
     // Projectiles:
	with(mod_script_call("mod", "Frontier_Projectiles", "HeavyBlunderball_create", x, y)){
		direction		= other.gunangle + (random_range(-3, 3) * other.accuracy);
		image_angle     = direction;
		team            = other.team;
		creator         = other;
	}
	
     // Kick, Shift, Shake:
    weapon_post(10, 2, 2);
    motion_add(gunangle + 180, 1)
   
	 // Dust:
	repeat(6){
		with(instance_create(x, y, Dust)){
			direction	= other.gunangle + random_range(-45, 45);
			speed		= 3 + random(2);
		}
	}
	
#define step
	 // did you sersiously make it an LWO just for the popuptext
    var _wep = (argument0 ? wep : bwep);
	if(!is_object(_wep)){
		lwo_initialize(_wep); 
		exit;
	};

#define lwo_initialize(_wep)
		// yeah
	var _creator = ((instance_is(self, FireCont) && "creator" in self) ? creator : self);
	_wep = { 
		"wep"			: _wep, 
	};
	
	 // Tutorial Text:
	mod_script_call("mod", "Frontier_Projectiles", "weapon_tutorial_text", x, y, "blunderboulder");
	
	if("wep" in _creator && _creator.wep == _wep.wep){
		_creator.wep = _wep;
	}
	if("bwep" in _creator && _creator.bwep == _wep.wep){
		_creator.bwep = lq_clone(_wep);
	}
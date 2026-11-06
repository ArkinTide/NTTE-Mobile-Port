#define init

     // Sprites:
    global.sprWeapon 	        = sprite_add_weapon("../Sprites/Weapons/sprBallista.png", 5, 5);
    global.sprWeaponLoaded		= sprite_add_weapon("../Sprites/Weapons/sprBallistaLoaded.png", 5, 5);

#define weapon_name         return "BOOMLLISTA";          
#define weapon_text         return "THERES NO WAY THIS IS A GOOD IDEA";
#define weapon_sprt(_wep)   return !is_object(_wep) ? global.sprWeapon : _wep.sprt;
#define weapon_type         return 3;
#define weapon_melee        return false;
#define weapon_area         return mod_script_call("mod", "Frontier_Projectiles", "check_piratedrops", mod_current, 10);
#define weapon_auto         return false;
#define weapon_load         return 30;
#define weapon_cost         return 4;
#define weapon_swap         return sndSwapBow;
#define weapon_laser_sight	return false;
#define weapon_handy		return true;
#define weapon_handy_data	return	{ x : 1, y : 3, bhand : true, bx : 10, by : 5 }

#define weapon_fire(_wep)


     // FireCont Support:
	var c = ((instance_is(self, FireCont) && "creator" in self) ? creator : self);

     // Sounds:
	sound_play_gun((sndHeavyCrossbow), 1, 0.7 + random(0.2));
	sound_play_gun((sndCrossbow), 1, 0.7 + random(0.2));
		
     // Projectiles:
	with(mod_script_call("mod", "Frontier_Projectiles", "BallistaBolt_create", x, y)){
		speed			= 16;
		direction		= other.gunangle + (random_range(-1, 1) * other.accuracy);
		image_angle		= direction;
		team            = other.team;
		creator         = other;
	}
   
     // Kick, Shift, Shake:
    weapon_post(8, 40, 2);
    motion_add(gunangle + 180, 2)
    
    _wep.sprt = global.sprWeapon;

#define weapon_reloaded(_active)
	var _wep = (_active ? wep : bwep);
	if(!is_object(_wep)){
		lwo_initialize(_wep); 
		exit;
	};
	_wep.sprt = global.sprWeaponLoaded;
	with(instance_create(x + lengthdir_x(10, gunangle), y + lengthdir_y(10, gunangle), ThrowHit)){
		image_xscale	= 0.5;
		image_yscale	= 0.5;
		depth			= -3;
	}
	sound_play_pitch(sndCrossReload, 0.7 + random(0.1))
	weapon_post(-2, 0, 0)
	

#define step
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
		"sprt"			: global.sprWeaponLoaded,
	};
	
	if("wep" in _creator && _creator.wep == _wep.wep){
		_creator.wep = _wep;
	}
	if("bwep" in _creator && _creator.bwep == _wep.wep){
		_creator.bwep = lq_clone(_wep);
	}
#define init

     // Sprites:
    global.sprWeapon 	        = sprite_add_weapon("../Sprites/Weapons/sprGildedCoralCrossbow.png",		8, 7);
    global.sprWeaponLoaded		= sprite_add_weapon("../Sprites/Weapons/sprGildedCoralCrossbowLoaded.png",	8, 7);
	global.sprCoralReload		= sprite_add("../sprites/particles/sprCoralReload.png",						3, 4, 4);
 
#define weapon_name         return "BLEACHED CORAL CROSSBOW";          
#define weapon_text         return "I THOUGHT IT'D BE GOLD TOO"; 
#define weapon_sprt(_wep)   return !is_object(_wep) ? global.sprWeapon : _wep.sprt;
#define weapon_type         return 3;
#define weapon_melee        return false;
#define weapon_area         return -1
#define weapon_auto         return true;
#define weapon_load         return 28;
#define weapon_cost         return 3;
#define weapon_swap         return sndSwapBow;
#define weapon_handy		return true;
#define weapon_handy_data	return	{ x : 1, y : 3, bhand : true, bx : 9, by : 4 }

#define weapon_fire(_wep)

     // FireCont Support:
	var c = ((instance_is(self, FireCont) && "creator" in self) ? creator : self);

     // Sounds:
	sound_play_gun((sndCrossbow), 1, 0.7 + random(0.2));
	sound_play_pitchvol(sndPlantFire, 1.2 + random(0.2), 0.7);
		
     // Projectiles:
    with(mod_script_call("mod", "Frontier_Projectiles", "CoralBolt_create", x, y)){
    	coralColor		= make_color_rgb(208, 207, 191); 
    	image_blend		= coralColor;
    	
		direction		= other.gunangle + (random_range(-1, 1) * other.accuracy);
		image_angle     = direction;
		team            = other.team;
		creator         = other;
    }

    
   
     // Kick, Shift, Shake:
    weapon_post(8, 2, 2);
    motion_add(gunangle + 180, 1)
    
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
	
	repeat(6){
		with(instance_create(x, y, CaveSparkle)){
			sprite_index	= global.sprCoralReload;
			speed			= 1 + random(2);
			image_blend		= make_color_rgb(208, 207, 191);
			direction		= (other.gunangle + 180) + random_range(-55, 55);
			image_angle		= random(360);
			depth			= other.depth - 1;
		}
	}
	
	sound_play_pitchvol(sndPillarBreak, 1.4 + random(0.4), 0.4);
	sound_play_pitch(sndCrossReload, 0.8 + random(0.1))
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
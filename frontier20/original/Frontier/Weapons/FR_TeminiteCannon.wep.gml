#define init

     // Sprites:
    global.sprWeapon 	        = sprite_add_weapon("../Sprites/Weapons/sprTeminiteCannon.png", 7, 8);
	global.sprEpicStreak		= sprite_add("../sprites/particles/sprEpicStreak.png",			7, 8, 8);
    
    global.sndTeminiteFireA		= sound_add("../Sounds/weapons/sndTeminiteFireA.ogg");
    global.sndTeminiteFireB1	= sound_add("../Sounds/weapons/sndTeminiteFireB1.ogg");
    global.sndTeminiteFireB2	= sound_add("../Sounds/weapons/sndTeminiteFireB2.ogg");
    global.sndTeminiteFireC		= sound_add("../Sounds/weapons/sndTeminiteFireC.ogg");
	global.sndTeminiteSwap		= sound_add("../Sounds/weapons/sndTeminiteSwap.ogg");

#define weapon_name         return "TEMINITE CANNON";          
#define weapon_text         return choose("SEND THEM TO THE DEPTHS", "RAISE THE BLACK FLAG")
#define weapon_sprt         return global.sprWeapon;
#define weapon_type         return 5;
#define weapon_melee        return false;
#define weapon_area         return mod_script_call("mod", "Frontier_Projectiles", "check_piratedrops", mod_current, 22);
#define weapon_auto         return true;
#define weapon_load(_wep)   
	if(!is_object(argument0)){
		return 9;
	} else {
		return (argument0.teminite < 4 ? 9 : 3);
	}
#define weapon_cost 
	if(!is_object(argument0)){
		return 3;
	} else {
		return (argument0.teminite < 4 ? 3 : 1);
	}
	
#define weapon_swap         return global.sndTeminiteSwap;

#define weapon_handy		return true;
#define weapon_handy_data	return	{ x : 1, y : 6, bhand : true, bx : 10, by : 7 }


#define weapon_fire(_wep)
   if(!is_object(argument0)){
   	lwo_initialize(argument0);
   }
	var _creator = ((instance_is(self, FireCont) && "creator" in self) ? creator : self);


	switch(argument0.teminite){
		case 1:
		case 2:
		case 3:
			sound_play_pitchvol(global.sndTeminiteFireA, 1, 1);
		break;
		case 4:
		case 6:
			sound_play_pitchvol(global.sndTeminiteFireB1, 1, 1);
		break;
		case 5:
			sound_play_pitchvol(global.sndTeminiteFireB2, 1, 1);
		break;
		default:
			sound_play_pitchvol(global.sndTeminiteFireC, 1 + ((9 - argument0.teminite) * 0.2), 1);
		break;
	}
	
		// Projectiles + Effects:
	if(argument0.teminite <= 3){
	    with(mod_script_call("mod", "Frontier_Projectiles", "EpicCannonball_create", x, y)){
			direction		= other.gunangle + (random_range(-10, 10) * other.accuracy);
			image_angle     = direction;
			team            = other.team;
			creator         = other;
	    }
	    repeat(5){
	    	with(instance_create(x, y, BloodStreak)){
	    		sprite_index	= global.sprEpicStreak;
	    		speed			= 4 + random(4);
	    		direction		= other.gunangle + random_range(-60, 60);
	    		image_angle		= direction;
	    		image_index		= choose(0, 1);
	    	}
	    }
	}
	else{
	    with(mod_script_call("mod", "Frontier_Projectiles", "EpicBeam_create", x, y, other.gunangle + (random_range(-6, 6) * accuracy))){
			image_angle     = direction;
			team            = other.team;
			creator         = other;
	    }
	    repeat(3){
	    	with(instance_create(x, y, BloodStreak)){
	    		sprite_index	= global.sprEpicStreak;
	    		speed			= 4 + random(4);
	    		direction		= other.gunangle + random_range(-25, 25);
	    		image_angle		= direction;
	    		image_index		= choose(0, 1);
	    	}
	    }
	}
    
     // Kick, Shift, Shake:
    weapon_post(8, 2, 2);
    motion_add(gunangle + 180, 3)
	
	//increase combo
	_wep.teminite = (_wep.teminite >= _wep.teminite_max ? 1 : _wep.teminite + 1);
	

#define step
    var _wep = (argument0 ? wep : bwep);
	if(!is_object(_wep)){
		lwo_initialize(_wep); 
		exit;
	};

#define lwo_initialize(_wep)
	var _creator = ((instance_is(self, FireCont) && "creator" in self) ? creator : self);
	_wep = { 
		"wep"			: _wep, 
		"teminite"  	: 1, 
		"teminite_max"	: 9,
	};
	
	if("wep" in _creator && _creator.wep == _wep.wep){
		_creator.wep = _wep;
	}
	if("bwep" in _creator && _creator.bwep == _wep.wep){
		_creator.bwep = lq_clone(_wep);
	}

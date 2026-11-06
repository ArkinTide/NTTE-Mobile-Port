#define init

	 // LIB:
	while(!mod_exists("mod", "lib")){wait(1);}
	script_ref_call(["mod", "lib", "getRef"], "weapon", mod_current, "scr");
	#macro  scr			global.scr
	#macro  call		script_ref_call
	
     // Sprites:
    global.sprWeapon 	        = sprite_add_weapon("../Sprites/Weapons/sprHullmangler.png", 5, 7);

#define weapon_name         return "HULLMANGLER";          
#define weapon_text         return "TO SHREDS YOU SAY?";
#define weapon_sprt         return global.sprWeapon;
#define weapon_type         return 3;
#define weapon_type_string	return "BOLTS";
#define weapon_melee        return false;
#define weapon_area         return mod_script_call("mod", "Frontier_Projectiles", "check_piratedrops", mod_current, 16);;
#define weapon_load         return 20;
#define weapon_cost         return 0;
#define weapon_true_cost	return 12;
#define weapon_chrg_cost	return 1;
#define weapon_swap         return sndSwapBow;
#define weapon_handy		return true;
#define weapon_handy_data	return	{ x : 2, y : 4, bhand : true, bx : 11, by : 7 }

#define weapon_chrg         return true;
#define weapon_charge_max   return 13;
#define weapon_laser_sight	return 0;
#define weapon_auto
	if(instance_is(self, Player)){
		 return (ammo[weapon_type()] < weapon_chrg_cost() ? false : true);
	} else {
		return true;
	}
	
#define weapon_reloaded
	
#define weapon_fire(_wep)

	 // Ammo Check:
    if(instance_is(self, Player)){
        if ammo[weapon_type()] < weapon_chrg_cost(){
			call(scr.pickup_text, weapon_type_string(), "ins")
            sound_play(sndEmpty);
            wkick		= 6;
			reload		= 10;   
			exit;
        }
    }
    
	var _fire = mod_script_call("mod", "Frontier_Projectiles", "charge_weapon_fire_init", _wep)
	_wep = _fire.wep;
	
	var _charge = (_wep.chrg_num / _wep.chrg_max);
	
	 // Charging:
	if(_wep.chrg){
		 // Pullback:
		weapon_post(5 * _charge, 8 * _charge * current_time_scale, 0);
		
		 // Effects:
		if(_wep.chrg == 1){
			
			 // Charging Sound:
			if(_charge >= 0.25){
				if(current_frame_active){
					sound_play_pitch(sndMeleeFlip, 1 / (1 - (0.25 * _charge)));
					sound_play_pitchvol(sndSwapBow, 0.3 + (2 * _charge), 0.3);
				}
			}
			
			 // Full:
			if(_charge >= 1){
				
				 // Sound:
				sound_play_pitch(sndCrystalRicochet, 3);
				sound_play_pitch(sndSewerDrip,       3);
				 // Flash:
				var	_lx = 22 - wkick,
					_ly = 2 * variable_instance_get(_fire.creator, "wepflip", 1),
					_d  = gunangle + (wepangle * (1 - (wkick / 20)));
					
				 // Flash:
				with(instance_create(x + hspeed_raw + lengthdir_x(_lx, _d) + lengthdir_x(_ly, _d - 90), y + vspeed_raw + lengthdir_y(_lx, _d) + lengthdir_y(_ly, _d - 90), ThrowHit)){
					depth = other.depth - 1;
					instance_create(x, y, ImpactWrists);
				}
			}
		}
	}
	
	 // Fire:
	else if(_charge > 0){
		if(_charge < 1){
			
			 // Ammo Check:
		    if(instance_is(self, Player)){
		        if ammo[weapon_type()] < weapon_true_cost(){
					call(scr.pickup_text, weapon_type_string(), "ins")
		            sound_play(sndEmpty);
		            wkick		= 6;
					reload		= 10;   
					exit;
		        }
		    }
			
		     // Sounds:
		    sound_play_pitchvol(sndSuperDiscGun, 0.7 + random(0.2), 1);
		    sound_play_pitchvol(sndSeekerShotgun, 0.8 + random(0.2), 1);
			
		     // Projectiles:
			var _spread = -30 * accuracy;
		    repeat(5){
				with(mod_script_call("mod", "Frontier_Projectiles", "Sawblade_create", x + lengthdir_x(14, gunangle), y + lengthdir_y(14, gunangle))){
					direction		= other.gunangle + (random_range(-4, 4) * other.accuracy) + _spread;
					image_angle     = direction;
					team            = other.team;
					creator         = other;
			    }
			    _spread += 15 * accuracy;
		    }
		  
			consume_true_ammo();
		    
		     // Kick, Shift, Shake:
		    weapon_post(12, 24, 25);
		    
			 // Dust:
			repeat(9){
				with(instance_create(x, y, Smoke)){
					direction	= other.gunangle + random_range(-25, 25);
					speed		= 3 + random(2);
				}
			}
		}
		
		 // Fully Charged Attack:
		else{
			
		     // Sounds:
		    sound_play_pitchvol(sndCrossbow, 1.3 + random(0.2), 1);
			
		     // Projectiles:
	    	with(mod_script_call("mod", "Frontier_Projectiles", "Magnet_create", x, y, mouse_x[other.index], mouse_y[other.index])){
				direction		= point_direction(x, y, mouse_x[other.index], mouse_y[other.index]);
				image_angle     = direction;
				team            = other.team;
				creator         = other;
	    	}
			consume_ammo();
		    
		     // Kick, Shift, Shake:
		    weapon_post(5, 2, 2);
		}
	}
	
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
		"chrg"  		: false,
		"chrg_num"		: 0,
		"chrg_max"		: weapon_charge_max(),
		"auto"			: true,
	};
	
	 // Tutorial Text:
	mod_script_call("mod", "Frontier_Projectiles", "weapon_tutorial_text", x, y, "chargeWep");
	
	if("wep" in _creator && _creator.wep == _wep.wep){
		_creator.wep = _wep;
	}
	if("bwep" in _creator && _creator.bwep == _wep.wep){
		_creator.bwep = lq_clone(_wep);
	}
	
#define consume_ammo
	if instance_is(self, Player){
		if(infammo == 0){
			ammo[weapon_type()] -= min(ammo[weapon_type()], weapon_chrg_cost()); 
		}
	}

#define consume_true_ammo
	if instance_is(self, Player){
		if(infammo == 0){
			ammo[weapon_type()] -= min(ammo[weapon_type()], weapon_true_cost()); 
		}
	}
	
#define wep_get(_primary, _name, _default)                                              	return  variable_instance_get(self, (_primary ? '' : 'b') + _name, _default);
#define wep_set(_primary, _name, _value)                                                	if(((_primary ? '' : 'b') + _name) in self) variable_instance_set(self, (_primary ? '' : 'b') + _name, _value);
#macro  current_frame_active																frac(current_frame) < current_time_scale
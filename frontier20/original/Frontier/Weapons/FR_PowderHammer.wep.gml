#define init

	 // LIB:
	while(!mod_exists("mod", "lib")){wait(1);}
	script_ref_call(["mod", "lib", "getRef"], "weapon", mod_current, "scr");
	#macro  scr			global.scr
	#macro  call		script_ref_call
	
     // Sprites:
    global.sprWeapon 	        = sprite_add_weapon("../Sprites/Weapons/sprPowderHammer.png", 6, 10);
    global.sprGunpowderSlash	= sprite_add("../Sprites/Projectiles/sprGunpowderSlash.png", 3, 0, 24);

#define weapon_name         return "KEG KRUSHER";          
#define weapon_text         return "SLAM BAM";
#define weapon_sprt         return global.sprWeapon;
#define weapon_type         return 4;
#define weapon_type_string	return "EXPLOSIVES";
#define weapon_melee        return true;
#define weapon_area         return mod_script_call("mod", "Frontier_Projectiles", "check_piratedrops", mod_current, 12);
#define weapon_load         return 19;
#define weapon_cost         return 0;
#define weapon_chrg_cost	return 4;
#define weapon_swap         return sndSwapHammer;
#define weapon_chrg         return true;
#define weapon_charge_max   return 14;
#define weapon_auto
	if(instance_is(self, Player)){
		 return (ammo[weapon_type()] < weapon_chrg_cost() ? false : true);
	} else {
		return true;
	}

#define weapon_handy		return true;
#define weapon_handy_data	return	{ x : 0, y : 2, bhand : true, bx : 10, by : 2 }
	
#define weapon_reloaded(_primary)
	 // prevent melee nightmare:
	var _wep = wep_get(_primary, "wep", mod_current);
	if(lq_defget(_wep, "chrg", false)){
		wep_set(_primary, "wepflip", -wep_get(_primary, "wepflip", 1));
	}
	else{
		sound_play(sndMeleeFlip);
	}
	
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
		weapon_post(-5 * _charge, 8 * _charge * current_time_scale, 0);
		
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
			
		     // Sounds:
		    sound_play_pitchvol(sndHammer, 0.7 + random(0.2), 1);
		    sound_play_pitchvol(sndFlare, 1.2 + random(0.2), 1);
			
		     // Projectiles:
		    repeat(12){
		    	with(instance_create(x, y, Flame)){
					direction		= other.gunangle + random_range(-25, 25);
					speed   		= 5 + random(2);
					image_angle     = direction;
					team            = other.team;
					creator         = other;
		    	}
		    }
		    	
			var _disjoint = (0 + 15 * skill_get(mut_long_arms));
			with(mod_script_call("mod", "Frontier_Projectiles", "FireSlash_create", x + lengthdir_x(_disjoint, gunangle), y + lengthdir_y(_disjoint, gunangle))){
		    	speed			= 1.5 + (skill_get(13) * 3.5);
				direction		= other.gunangle;
				image_angle     = direction;
				team            = other.team;
				creator         = other;
		    }
		  
			consume_ammo();
		    
			wepangle = -wepangle;
			weapon_post(-4, 8, 5);
			motion_add(gunangle, 3.5);
			instance_create(x, y, Dust)
		}
		
		 // Fully Charged Attack:
		else{
			
		     // Sounds:
		    sound_play_pitchvol(sndHammer, 1.3 + random(0.2), 1);
			
		     // Projectiles:
		    repeat(6){
		    	with(mod_script_call("mod", "Frontier_Projectiles", "GunpowderProjectile_create", x, y)){
					direction		= point_direction(x, y, mouse_x[other.index], mouse_y[other.index]) + (random_range(-20, 20) * other.accuracy);
					speed   		= clamp((point_distance(x, y, mouse_x[other.index], mouse_y[other.index]) * zfriction) / (zspeed * 2), 3, 7) + random(2);
					image_angle     = direction;
					team            = other.team;
					creator         = other;
					zspeed			+= random_range(-1, 1)
		    	}
		    }
		    
			var _disjoint = (0 + 15 * skill_get(mut_long_arms));
			with instance_create(x + lengthdir_x(_disjoint, gunangle), y + lengthdir_y(_disjoint, gunangle), Slash){
				sprite_index	= global.sprGunpowderSlash;
		    	speed			= 1.5 + (skill_get(13) * 4);
				direction		= other.gunangle;
				image_angle     = direction;
				damage			= 8;
				team            = other.team;
				creator         = other;
		    }
		  
			consume_ammo();
		    
			wepangle = -wepangle;
			weapon_post(-4, 8, 5);
			motion_add(gunangle, 3.5);
			instance_create(x, y, Dust)
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

#define wep_get(_primary, _name, _default)                                              	return  variable_instance_get(self, (_primary ? '' : 'b') + _name, _default);
#define wep_set(_primary, _name, _value)                                                	if(((_primary ? '' : 'b') + _name) in self) variable_instance_set(self, (_primary ? '' : 'b') + _name, _value);
#macro  current_frame_active																frac(current_frame) < current_time_scale
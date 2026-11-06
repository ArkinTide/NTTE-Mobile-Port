#define init
    trace("WIBBLY 0.3.2 LOADED!!");
    // WIGGLERCOLA ULTIMATE SHARED FUNCTION LIBRARY!!!!!!!! //
    /*
        CURRENT FEATURES
        BONUS MAX AMMO APPLIES CORRECTLY WHEN BACK MUSCLE CHANGES
        STAT BONUSES APPLY CORRECTLY ON RESPAWN (Max Ammo, Ammo Gain, Max Speed, Reload Speed, Accuracy)
        PROJECTILE SPEED BONUS HANDLER
        RAD MAX BONUS HANDLER
        DEATH HANDLER FOR FRONTIER AND TREASURE TROVE FEATURES
        
    	ammoMaxBonus_add(_index, _ammoType, _count);
    	ammoGainBonus_add(_index, _ammoType, _count);
    	speedBonus_add(_index, _speed);
    	reloadBonus_add(_index, _bonus);
    	accuracyBonus_add(_index, _bonus);				// stops at 0. might cause problems, look into it
    	projectileSpeedBonus_add(_index, _bonus);
    	radMaxBonus_add(_bonus);						// waits until level ultra to apply changes 
    	
    	
    		'raw' versions of stat increases that dont apply stats to the player
    		trinkets use these when clearing stat boosts on player death.
    	ammoMaxBonus_add_raw(_index, _ammoType, _count);
    	ammoGainBonus_add_raw(_index, _ammoType, _count);
    	speedBonus_add_raw(_index, _speed);
    	reloadBonus_add_raw(_index, _bonus);
    	accuracyBonus_add_raw(_index, _bonus);
    	
    	
    */
    
    /*
        TODO
        right now if u get a stat that has a minimum past its minimum then it doesn't gain properly, starting at minimum instead of the negative
        not a huge deal at all u can probably just leave it.. maybe itll end up with a trinket having something exploitable, maybe that would be cool though
        if i dont fix it then ill call it a feature
    */


	#macro minProjSpeedBonus		3
	#macro maxProjSpeedBonus		26
	
	#macro ammoMaxBonus    			GameCont.wib_ammoMaxBonus;
	#macro ammoGainBonus    		GameCont.wib_ammoGainBonus;
	#macro speedBonus				GameCont.wib_speedBonus;
	#macro reloadBonus				GameCont.wib_reloadBonus;
	#macro accuracyBonus			GameCont.wib_accuracyBonus;
	#macro projectileSpeedBonus		GameCont.wib_projectileSpeedBonus;
	#macro radMaxBonus				GameCont.wib_radMaxBonus;
	
	
	global.level_start		    			= (instance_exists(GenCont) || instance_exists(Menu));
    setup_gamecont();
    
#define setup_gamecont
    with(instances_matching(GameCont, "wibbly", null)){
        wibbly                      = true;
        wib_ammoMaxBonus			= [[0, 0, 0, 0, 0], [0, 0, 0, 0, 0], [0, 0, 0, 0, 0], [0, 0, 0, 0, 0]];
        wib_ammoGainBonus			= [[0, 0, 0, 0, 0], [0, 0, 0, 0, 0], [0, 0, 0, 0, 0], [0, 0, 0, 0, 0]];
        wib_speedBonus				= [0, 0, 0, 0];
        wib_reloadBonus				= [0, 0, 0, 0];
        wib_accuracyBonus			= [0, 0, 0, 0];
        wib_projectileSpeedBonus	= [0, 0, 0, 0];
        wib_wantStatsController     = false;
        wib_wantProjectileController= false;
        wib_radMaxBonus				= 0;
    }  
    global.wantRadMaxBuffer = false;

#define game_start
    setup_gamecont();

#define step
	if(instance_exists(GenCont) || instance_exists(Menu)){
		global.level_start = true;
	}
	else if(global.level_start){
		global.level_start = false;
		level_start();
	}
	
		// Max Rad Buffer:
	if(global.wantRadMaxBuffer = true){
	    with(instances_matching(instances_matching(GameCont, "level", 10), "wib_radMaxBuffered", null)){
			radMaxBonus_add(radMaxBonus) 
			wib_radMaxBuffered		= true;
			global.wantRadMaxBuffer = false;
	    }
	}

#define level_start
	 // Player Manager:
	PlayerManager_create(10016, 10016);
	
	 // Projectile Speed Bonus Controller:
	if(GameCont.wib_wantProjectileController = true){
		ProjectileSpeedController_spawn();
		
		// stop spawning controller if not needed:
		var _needController = false;
    	for(var _index = 0; _index < maxp; _index++){	
    		_needController += abs(projectileSpeedBonus[_index]);
    	}
    	if(!_needController){
    		GameCont.wib_wantProjectileController = false;
    	}
	}
	
	// input -1 to affect all players, raws don't have that
#define ammoMaxBonus_add(_index, _ammoType, _count)
	var _player = _index = -1 ? Player : instances_matching(Player, "index", _index);
    with(_player){
        typ_amax[_ammoType] += _count;
        ammoMaxBonus[index][@_ammoType - 1] += _count;
    }

#define ammoGainBonus_add(_index, _ammoType, _count)
	var _player = _index = -1 ? Player : instances_matching(Player, "index", _index);
    with(_player){
        typ_ammo[_ammoType] += _count;
        if(typ_ammo[_ammoType] < 1){
        	typ_ammo[_ammoType] = 1;
        }
        ammoGainBonus[index][@_ammoType - 1] += _count;
    }

#define speedBonus_add(_index, _speed)
	var _player = _index = -1 ? Player : instances_matching(Player, "index", _index);
    with(_player){
    	maxspeed += _speed;
    	if(maxspeed != 0 && maxspeed < 2.1){
    		maxspeed = 2.1; // minimum speed needed to not get stuck forever on cobwebs
    	}
    	speedBonus[index] += _speed;
    }

#define reloadBonus_add(_index, _bonus)
	var _player = _index = -1 ? Player : instances_matching(Player, "index", _index);
    with(_player){
    	reloadspeed += _bonus;
    	if(reloadspeed < 0.05){
    		reloadspeed = 0.05;
    	}
    	reloadBonus[index] += _bonus;
    }
    
#define accuracyBonus_add(_index, _bonus)
	var _player = _index = -1 ? Player : instances_matching(Player, "index", _index);
    with(_player){
    	accuracy -= _bonus;
    	if(accuracy < 0){ // negative makes it wrap around again
       		accuracy = 0;
    	}
    	accuracyBonus[index] += _bonus;
    }

#define projectileSpeedBonus_add(_index, _bonus)
	var _player = _index = -1 ? Player : instances_matching(Player, "index", _index);
    with(_player){
    	projectileSpeedBonus[index] += _bonus;
    }
    ProjectileSpeedController_spawn();
    
#define radMaxBonus_add(_bonus)
		radMaxBonus += _bonus;
	if(GameCont.level != 10){
		global.wantRadMaxBuffer = true;
	} else {
		GameCont.radmaxextra += _bonus
		 // always keep 20 rad capacity at least.
		if(radMaxBonus < -580){
			GameCont.radmaxextra = -580;
		}
	}
    
#define ammoMaxBonus_add_raw(_index, _ammoType, _count)
    ammoMaxBonus[_index][@_ammoType - 1] += _count;

#define ammoGainBonus_add_raw(_index, _ammoType, _count)
    ammoGainBonus[_index][@_ammoType - 1] += _count;

#define speedBonus_add_raw(_index, _speed)
    speedBonus[_index] += _speed;

#define reloadBonus_add_raw(_index, _bonus)
    reloadBonus[_index] += _bonus;
    
#define accuracyBonus_add_raw(_index, _bonus)
    accuracyBonus[_index] += _bonus;


//#define PlayerManager_spawn
/*
 	if(array_length(instances_matching(CustomObject, "name", "wib_PlayerStatsController")) = 0){
		PlayerStatsController_create(10016, 10016);
		GameCont.wib_wantStatsController = true;
	}
*/

#define PlayerManager_create(_x, _y)
    with(instance_create(_x, _y, CustomObject)){
        name            = "wib_PlayerManager";
            
        prev_muscle     = skill_get(mut_back_muscle);
		livingPlayers	= [
							array_length(instances_matching(Player, "index", 0)), 
							array_length(instances_matching(Player, "index", 1)), 
							array_length(instances_matching(Player, "index", 2)), 
							array_length(instances_matching(Player, "index", 3))
						];
		playerX 		= [_x, _x, _x, _x];
		playerY 		= [_y, _y, _y, _y];
		playerRace		= ["", "", "", ""];
        
        on_step         = PlayerManager_step;
        
        return self;
    }
    
#define PlayerManager_step
	 // Fix if Back Muscle Changes:
    if(prev_muscle != skill_get(mut_back_muscle)){
        
         // apply ammo changes
        with(Player){
            var _ammoType = 1;
            repeat(5){
                typ_amax[_ammoType] += ammoMaxBonus[index][_ammoType - 1];
                if(typ_amax[_ammoType] < 1){
                	typ_amax[_ammoType] = 1;
                }
                _ammoType += 1;
            }
        }
        
         // remember....
        prev_muscle = skill_get(mut_back_muscle);
    }
    
     // i know where u are:
    with(Player){
		other.playerX[index]	= x;
		other.playerY[index]	= y;
		other.playerRace[index] = race;
    }
    
	 // Run respawn and death functions:
    for(var _index = 0; _index < maxp; _index++){
    	if(array_length(instances_matching(Player, "index", _index)) = 0){
    		if(livingPlayers[_index] != 0){
    			 // player has died :(
    			livingPlayers[_index] = 0;	
	    			 // Frontier functions:
	    			if(mod_exists("mod", "Frontier_Main")){
	    				 // Death Stat + Cyberspace:
	    				if(!GameCont.win){ 
							if(is_string(playerRace[_index]) && mod_script_exists("race", playerRace[_index], "race_frontier")){
								mod_script_call("mod", "Frontier_Main", "frontier_race_deathstat", playerRace[_index]);
							}
							if(array_find_index(playerRace, "robot") != -1){
								if(!instance_exists(Player)){
									mod_script_call("area", "cyberspace", "cyberspace_revive", array_find_index(playerRace, "robot"));
								}
							}
						 // Win Stat:
	    				} else {
							if(is_string(playerRace[_index]) && mod_script_exists("race", playerRace[_index], "race_frontier")){
								mod_script_call("mod", "Frontier_Main", "frontier_race_winstat", playerRace[_index]);
							}	    					
	    				}
	    			}
	    	
	    			 // Trinket functions:
	    			if(mod_exists("mod", "Trinkets")){
	    				if(!GameCont.win){
	    					mod_script_call("mod", "Trinkets", "drop_my_items_please", _index, playerX[_index], playerY[_index]);
	    				}
	    			}
    		}
    	} else {
    		 // player has respawned!! :)
    		if(livingPlayers[_index] = 0){
    			with(instances_matching(Player, "index", _index)){
	    			 // Reapply Max Ammo and Ammo Gain:
		            var _ammoType = 1;
		            repeat(5){
		                typ_amax[_ammoType] += ammoMaxBonus[index][_ammoType - 1];
		                typ_ammo[_ammoType] += ammoGainBonus[index][_ammoType - 1];	               
		                _ammoType += 1;
		            }			
		            
		            // Reapply Max Speed:
		           maxspeed += speedBonus[index];
		           
		            // Reapply Reload Speed:
		           reloadspeed += reloadBonus[index];	            
		            
		        	// Reapply Accuracy:
		           accuracy -= accuracyBonus[index];	  
		           if(accuracy < 0){ // negative makes it wrap around again
		           		accuracy = 0;
		           }
    			}
    		}
    		livingPlayers[_index] = 1;	
    	}
    }

#define ProjectileSpeedController_spawn
 	if(array_length(instances_matching(CustomObject, "name", "wib_ProjectileSpeedController")) = 0){
		ProjectileSpeedController_create(10016, 10016);
		GameCont.wib_wantProjectileController = true;
	}
	
#define ProjectileSpeedController_create(_x, _y)
    with(instance_create(_x, _y, CustomObject)){
        name            = "wib_ProjectileSpeedController";
        
        on_step         = ProjectileSpeedController_step;
        
        return self;
    }
    
#define ProjectileSpeedController_step
	if(instance_exists(projectile)){
		with(Player){
			var _proj = instances_matching(instances_matching(projectile, "wib_projspeed", null), "creator", self.id),
				_index = index;
			
			if(array_length(_proj)){
				with(_proj){
					wib_projspeed = true;
					if("is_melee" not in self || is_melee = false){
						if(array_find_index([TangleSeed, ThrownWep, HorrorBullet, ToxicGas, Laser, EnemyLaser, Slash, LightningSlash, EnergySlash, EnergyHammerSlash, BloodSlash, Shank, EnergyShank, GuitarSlash], object_index) == - 1){
							var _ogSpeed	= speed,
								_speedBonus = projectileSpeedBonus[_index],
								_newSpeed	= _ogSpeed;
								
							if(_ogSpeed > 0 && _ogSpeed < maxProjSpeedBonus){
								_newSpeed = clamp(_ogSpeed * (1 + _speedBonus), minProjSpeedBonus, maxProjSpeedBonus);
							}
							speed = _newSpeed;
						}
						
						 // they hardcoded these yay...
						if(array_find_index([Nuke, Rocket, PlasmaBall, PlasmaBig, PlasmaHuge], object_index) + 1){
							switch(object_index){
								case PlasmaBall:
								case Seeker:
								case Nuke:
									_ogSpeed	= 7;
								break;
								case PlasmaBig:
								case PlasmaHuge:
									_ogSpeed	= 6;
								break;
								case Rocket:
									_ogSpeed	= 12;
								break;
							}
							
							_newSpeed = clamp(_ogSpeed * (1 + _speedBonus), minProjSpeedBonus, maxProjSpeedBonus);
							if fork(){
								while(instance_exists(self)){ 
									speed = (_newSpeed)
									wait 0;
								}
								exit;
							}
						}
					}
				}
			}
		}
	}
    
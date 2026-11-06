#define init

	 // LIB: //
	while(!mod_exists("mod", "lib")){wait(1);}
	script_ref_call(["mod", "lib", "getRef"], "mod", mod_current, "scr");

	#macro  scr																						global.scr
	#macro  call																					script_ref_call
	
	 // SPRITES: /
	global.sprGenericTrail  				= sprite_add("sprites/particles/sprGenericTrail.png",							50, 0, 50);
	global.sprBuffBloodLust 				= sprite_add("sprites/particles/sprBuffBloodLust.png",							11, 12, 28);
	global.sprBuffAmmoGain					= sprite_add("sprites/particles/sprBuffAmmoGain.png",							8, 12, 12);
	global.sprBuffBonusHeal 				= sprite_add("sprites/particles/sprBuffBonusHeal.png",							5, 8, 8);
	global.sprBuffBonusHealEnd 				= sprite_add("sprites/particles/sprBuffBonusHealEnd.png",						11, 12, 28);
	global.sprBuffMaxHealthGainStart		= sprite_add("sprites/particles/sprBuffMaxHealthGainStart.png", 				9, 12, 32);
	global.sprBuffMaxHealthGainEnd			= sprite_add("sprites/particles/sprBuffMaxHealthGainEnd.png",					9, 12, 32);
	global.sprDebuffMaxHealthLossStart		= sprite_add("sprites/particles/sprDebuffMaxHealthLossStart.png",				9, 12, 32);
	global.sprDebuffMaxHealthLossEnd		= sprite_add("sprites/particles/sprDebuffMaxHealthLossEnd.png", 				9, 12, 32);
	global.sprDebuffMaxHealthLossGameover	= sprite_add("sprites/particles/sprDebuffMaxHealthLossEnd.png", 				9, 12, 16);
	global.sprDebuffBlight					= sprite_add("sprites/particles/sprDebuffBlight.png",							6, 4, 4);
	global.sprDebuffBlightStreak			= sprite_add("sprites/particles/sprDebuffBlightStreak.png", 					7, 8, 8);
	global.sprVoltergeistLightning	=[		sprite_add("sprites/particles/sprVoltergeistLightning.png",               		5, 16, 16),
											sprite_add("sprites/particles/sprVoltergeistLightning2.png",               		5, 16, 16),
											sprite_add("sprites/particles/sprVoltergeistLightning3.png",               		5, 16, 16),
											sprite_add("sprites/particles/sprVoltergeistLightning4.png",               		5, 16, 16),
											sprite_add("sprites/particles/sprVoltergeistLightning5.png",               		5, 16, 16)];
	global.sprPetrolStreak					= sprite_add("sprites/particles/sprPetrolStreak.png",							7, 8, 8);
	global.sprDebuffPlague					= sprite_add("sprites/particles/sprDebuffPlague.png",							6, 4, 4);
	global.sprDebuffPlagueStreak			= sprite_add("sprites/particles/sprDebuffPlagueStreak.png", 					7, 8, 8);
	global.sprDebuffAugmentGammaGuts		= sprite_add("sprites/particles/sprDebuffAugmentGammaGuts.png", 				6, 4, 3);
	global.sprDebuffAugmentGammaGutsGreen	= sprite_add("sprites/particles/sprDebuffAugmentGammaGutsGreen.png", 			6, 4, 3);
	
	 // SETTINGS: //
	global.settingGreenAugments = false;
	
	 // ADD STATUSES: //
	status_effects_init();
	
#define step

	// Tick down all the timers for effects:
	if(!instance_exists(SpiralCont)){
		with(global.statusEffects){
			for(var i = array_length(targets) - 1; i >= 0; i--) {
				if instance_exists(targets[i]){
    				var value = variable_instance_get(targets[i], key) - current_time_scale; 
    				variable_instance_set(targets[i], key, value)	
				}
    			if(value <= 0){
					targets = array_delete(targets, i)
    			}
			}
		}
	
		//#region BEACON AUGMENT BUFF
		with(global.buffAugmentBeacon.targets){
			if instance_exists(self){
				if("fr_buffAugmentBeacon_ammo" not in self){
					fr_buffAugmentBeacon_ammo		= false;
					fr_buffAugmentBeacon_prevhealth	= my_health;
				}
				if(current_frame_active){
		
					 // Increased Ammo Gain:
					if (fr_buffAugmentBeacon_ammo = false){
						fr_buffAugmentBeacon_ammo = true;
					    with(instance_create(x, y, ImpactWrists)){ 
					    	image_blend 	= (global.settingGreenAugments ? make_colour_rgb(0, 255, 0) : make_colour_rgb(0, 255, 255));
					        depth			= -3; 
					        image_xscale	= 0.8; 
					        image_yscale	= image_xscale;
						}
						sound_play_pitchvol(sndRogueCanister, 1.4, 0.6)
					    sound_play_pitchvol(sndFrogPistol, 0.9, 0.6)
					}
					
					 // Shoot fast blast blast
					if (reload >= 0){ 
						reload -= 0.5; 
					}
				
					 // damage reduction
				    var _diff = fr_buffAugmentBeacon_prevhealth - my_health
				    if(_diff > 1){
						if(fr_buffAugmentBeacon_prevhealth > my_health){
							my_health += 1;
						}
				    }
				    fr_buffAugmentBeacon_prevhealth = my_health;
	    
					 // Particles:
					if (random(5) < 1) {
						with instance_create(x, y, BulletHit){ 
							sprite_index	= (global.settingGreenAugments ? sprPlasmaTrail : sprPopoPlasmaTrail); 
							speed			= 1.5; 
							direction		= random(360); 
						} 
					}
			
				     // Cleanup Beacon Effect:
		            if(fr_buffAugmentBeacon_time <= 1) && (fr_buffAugmentBeacon_ammo = true){ 
					    fr_buffAugmentBeacon_ammo = false;
					    with(instance_create(x, y, ImpactWrists)){ 
					    	image_blend 	= (global.settingGreenAugments ? make_colour_rgb(0, 255, 0) : make_colour_rgb(0, 255, 255));
					    	depth			= -3; 
					    	image_xscale	= 0.8; 
					    	image_yscale	= image_xscale;
					    }
					    sound_play_pitchvol(sndFrogPistol, 0.7, 0.6)
					}
				}
			}
		}	
		//#endregion
		//#region BLOODLUST BUFF
		if(array_length(global.buffBloodLust.targets) > 0){
			with(instances_matching_le(enemy, "my_health", 0)){
	            if("fr_buffBloodLust_check" not in self){
	                fr_buffBloodLust_check = true;
	                
					with (global.buffBloodLust.targets){
						if instance_exists(self){
							if (random(13) < 1){
								
								sound_play(sndBloodlustProc)
								
								with instance_create(x, y, BloodLust){
									creator			= other;
									sprite_index	= global.sprBuffBloodLust;
								}
								
								if(my_health >= maxhealth) || ((my_health + 1) = maxhealth){
									call(scr.pickup_text, "HP", "max")
								} else {
									my_health += 1;
									call(scr.pickup_text, "HP", "add", 1)
								}
							}
						}
					}	
	                break;
	            }
	        }
		}
		with (global.buffBloodLust.targets){
			if instance_exists(self){
				if (random(13) < 1){		
					with instance_create(x, y, Sweat){
						image_blend = make_colour_rgb(133, 27, 0)
						direction   = random_range(60, 120)
					}
				}
				if (fr_buffBloodLust_time <= 1){
					sound_play_pitchvol(sndBloodLauncherExplo, 0.7, 0.5)
					sound_play_pitchvol(sndBloodHammer, 0.5, 0.4)
					repeat(30){
						with instance_create(x, y, Sweat){
							image_blend = make_colour_rgb(133 + random_range(-20, 20), 27 + random_range(-20, 20), 0)
						}
					}
					repeat(2){
						with instance_create(x, y, BloodStreak){
							direction = random(360);
						}
					}
				}
			}	
		}
		//#endregion
		//#region AMMO GAIN BUFF
		with (global.buffAmmoGain.targets){
			if instance_exists(self){
	
				 // Increased Ammo Gain:
				if ("fr_buffAmmoGain_ammo" not in self){ 
					fr_buffAmmoGain_ammo = false; 
				}
				if (fr_buffAmmoGain_ammo = false){
					fr_buffAmmoGain_ammo = true;
	
					sound_play_pitchvol(sndEmpty, 1.4, 0.6)
				    sound_play_pitchvol(sndAmmoPickup, 0.9, 0.6)
				        
					typ_ammo[1] += 8;	// +8 Bullets
					typ_ammo[2] += 2;	// +2 Shells
					typ_ammo[3] += 2;	// +2 Bolts
					typ_ammo[4] += 2;	// +2 Explosives
					typ_ammo[5] += 3;	// +3 Energy
				}
				
				 // Particles:
				if(random(15) < current_time_scale){
					with instance_create(x, y, RecycleGland){
						sprite_index	= global.sprBuffAmmoGain;
						speed			= 1.5; 
						direction		= random(360); 
					} 
				}
		
			     // Cleanup Status Effect:
	            if (fr_buffAmmoGain_time <= 1) && (fr_buffAmmoGain_ammo = true){ 
				    fr_buffAmmoGain_ammo = false;
				    sound_play_pitchvol(sndEmpty, 0.7, 0.6)
				    
					repeat(15){ 
						with instance_create(x, y, RecycleGland){ 
							sprite_index	= global.sprBuffAmmoGain;
							image_index		= irandom(2);
							speed			= 1.5; 
							direction		= random(360); 
						} 
					}
	                
	                // Undo Ammo Gain:
					typ_ammo[1] -= 8;	// +8 Bullets
					typ_ammo[2] -= 2;	// +2 Shells
					typ_ammo[3] -= 2;	// +2 Bolts
					typ_ammo[4] -= 2;	// +2 Explosives
					typ_ammo[5] -= 3;	// +3 Energy
				}
			}
		}	
		//#endregion
		//#region MAX HEALTH UP BUFF
		with (global.buffHealthUp.targets){
			if instance_exists(self){
	
				 // Increased Max Health:
				if ("fr_buffHealthUp_hp" not in self){ 
					fr_buffHealthUp_hp = false; 
				}
				if (fr_buffHealthUp_hp = false){
					fr_buffHealthUp_hp = true;
					with instance_create(x, y, BloodLust){
						creator			= other;
						sprite_index	= global.sprBuffMaxHealthGainStart;
					}
					sound_play_pitchvol(sndHealthChest, 1.4, 0.6)
				    sound_play_pitchvol(sndHPPickupBig, 0.9, 0.6)
				    
				     // More Health:
					maxhealth += 2;
					my_health += 2;
				}
		
			     // Cleanup Status Effect:
	            if (fr_buffHealthUp_time <= 1) && (fr_buffHealthUp_hp = true){ 
				    fr_buffHealthUp_hp = false;
				    sound_play_pitchvol(sndHealthChest, 0.7, 0.6)
				   
					with instance_create(x, y, BloodLust){
						creator			= other;
						sprite_index	= global.sprBuffMaxHealthGainEnd;
					}
	                
	                 // Undo Max Health Gain:
	                maxhealth -= 2;
					if(my_health >= maxhealth){ 
						my_health -= 2;
					}
				}
			}
		}	
		//#endregion
		
		//#region BONUS HEALING BUFF
		with (global.buffBonusHeal.targets){
			if instance_exists(self){
				
				 // Active Particles:
				if(random(40) < current_time_scale){		
					with instance_create(x, y - 10, HealFX){
						sprite_index	= global.sprBuffBonusHeal;
						speed			= 1 + random(0.5);
						direction   	= random_range(60, 180)
					}
				}
				if ("fr_BonusHealStatusPrevHealth" not in self){ 
					fr_BonusHealStatusPrevHealth = my_health;
				}
	    		var diff = fr_BonusHealStatusPrevHealth - my_health;
	    
	    		if (diff != 0){ 
	        		if(diff < 0){ 
	            		if(my_health < maxhealth){ 
	            			my_health += 1;
	            			if(my_health = maxhealth){
								call(scr.pickup_text, "HP", "max")
	            			} else {
	            				call(scr.pickup_text, "HP", "add", 1);
	            			}
	            		}
	            		repeat(3){		
							with instance_create(x, y - 8, HealFX){
								sprite_index	= global.sprBuffBonusHeal;
								speed			= 1 + random(2);
								direction   	= random_range(60, 180);
							}
						}
	        		}
	        	}
	    		fr_BonusHealStatusPrevHealth = my_health;
				
				 // Lose Status Particles:
				if (fr_buffBonusHeal_time <= 1){
					sound_play_pitchvol(sndHitFlesh, 0.7, 0.5)
					sound_play_pitchvol(sndHPPickup, 0.3, 0.2)
					with instance_create(x, y, BloodLust){
						creator			= other;
						sprite_index	= global.sprBuffBonusHealEnd;
					}
				}
			}	
		}
		//#endregion
		//#region FIRERATE UP BUFF
		with (global.buffFirerateUp.targets){
			if instance_exists(self){
	
				 // Increased Firerate:
				if ("fr_buffFirerateUp_check" not in self){ 
					fr_buffFirerateUp_check = false; 
				}
				if(fr_buffFirerateUp_check = false){
					if(fr_buffFirerateUp_time >= 1){ // 60fps fix
						fr_buffFirerateUp_check = true;
		
						sound_play_pitchvol(sndAmmoChest, 1.4, 0.6)
					    sound_play_pitchvol(sndSwapPistol, 1.5, 0.6)
					    
					     // More reload:
						reloadspeed += 0.25;
					}
				}
				
				 // Particles:
				if (random(15) < 1){
					var _spr = weapon_get_sprite(wep),
				    	_wth = sprite_get_width(_spr) - sprite_get_xoffset(_spr),
				    	_hth = sprite_get_width(_spr) - sprite_get_yoffset(_spr);
					with instance_create(x + lengthdir_x(random(_wth), wepangle +  gunangle) + random_range(-2, 2), y + lengthdir_y(random(_hth), wepangle + gunangle) + random_range(-2, 2), CaveSparkle){
						speed		= 0.6;
						direction	= 90;
						image_index	= choose(0, 1);
						depth		= other.depth - 1;
					} 
				}
		
			     // Cleanup Status Effect:
	            if (fr_buffFirerateUp_time <= 1) && (fr_buffFirerateUp_check = true){ 
				    fr_buffFirerateUp_check = false;
				    sound_play_pitchvol(sndEmpty, 0.7, 0.6)
				   
	                 // Undo Firerate Gain:
					reloadspeed -= 0.25;
				}
			}
		}	
		//#endregion
	
		//#region SPEED UP BUFF
		with(global.buffSpeedUp.targets){
			if instance_exists(self){
	
				if ("fr_buffSpeedUp_check" not in self){ 
					fr_buffSpeedUp_check = false; 
				}
				if(fr_buffSpeedUp_check = false){
					fr_buffSpeedUp_check = true;
	
					sound_play_pitchvol(sndSwapHammer, 1.4, 0.6);
				    
				     // More Speed:
				    if(maxspeed > 0){
						maxspeed += 0.75;
				    }
				}
				
				 // Particles:
				if(random(3) < current_time_scale){
					with generic_trail_create(x - (hspeed * 3) + random_range(-5, 5), y - (vspeed * 3) + random_range(-5, 5)){
	    				image_xscale	= other.speed * 1.6;
	    				image_yscale	= 0.025;
	    				image_speed     = 6;
	    				image_angle 	= other.direction;
						image_blend 	= c_white;
						direction		= other.direction + 180;
						speed			= 1;
					} 
				}
		
			     // Cleanup Status Effect:
	            if (fr_buffSpeedUp_time <= 1) && (fr_buffSpeedUp_check = true){ 
				    fr_buffSpeedUp_check = false;
				    sound_play_pitchvol(sndAmmoChest, 1.4, 0.6)
				   
	                 // Undo Speed Gain:
					maxspeed -= 0.75;
				}
			}
		}	
		//#endregion
		
		//#region DEEPLABS SPEED UP BUFF
		with(global.buffDeeplabsSpeedUp.targets){
			if instance_exists(self){
	
				if ("fr_buffDeeplabsSpeedUp_check" not in self){ 
					fr_buffDeeplabsSpeedUp_check = false; 
				}
				if(fr_buffDeeplabsSpeedUp_check = false){
					fr_buffDeeplabsSpeedUp_check = true;
	
					sound_play_pitchvol(sndSwapHammer, 1.4, 0.6);
				    
				     // More Speed:
				    if(maxspeed > 0){
						maxspeed += 1;
				    }
				}
				
				 // Particles:
				if(random(5) < current_time_scale){
					with generic_trail_create(x - (hspeed * 3) + random_range(-5, 5), y - (vspeed * 3) + random_range(-5, 5)){
	    				image_xscale	= other.speed * 1.6;
	    				image_yscale	= 0.025;
	    				image_speed     = 6;
	    				image_angle 	= other.direction;
						image_blend 	= c_white;
						direction		= other.direction + 180;
						speed			= 1;
					} 
				}
		
			     // Cleanup Status Effect:
	            if (fr_buffDeeplabsSpeedUp_time <= 1) && (fr_buffDeeplabsSpeedUp_check = true){ 
				    fr_buffDeeplabsSpeedUp_check = false;
				   
	                 // Undo Speed Gain:
					maxspeed -= 1;
				}
			}
		}	
		//#endregion
		
		
		/*
		//#region CREEP TRAIL BUFF
		with (global.buffCreepTrail.targets){
			if instance_exists(self){
				
				 // Creep Trail:
				if(speed > 1){
					with(mod_script_call("mod", "Frontier_Projectiles", "PlayerCreep_create", x, y)){
						image_xscale	= choose(0.2, 0.3);
						image_yscale	= image_xscale;
						particle_chance = 80;
						maxSize 		= 0.5;
						lifetime		= 90;
						team			= other.team;
						creator 		= other;
					}
				}
				
				 // Particles:
				if(random(3) < 1){
					with(instance_create(x, y, BulletHit)){
						sprite_index	= sprSweat;
						direction		= random(360);
						speed			= 2 + random(2);
						image_blend		= choose(make_color_rgb(252, 56, 0), make_color_rgb(255, 164, 14), make_color_rgb(255, 255, 0))
					} 
				}
		
			     // Cleanup Status Effect:
	            if (fr_buffCreepTrail_time <= 1){ 
				    sound_play_pitchvol(sndAmmoChest, 1.4, 0.6)
				}
			}
		}	
		//#endregion
		*/
		
		//#region VOLTERGEIST POSSESSION BUFF
			// ENEMIES ONLY ! !
		with(global.buffVoltergeist.targets){
			if instance_exists(self){
				 // Particles:
				if(random(30) < current_time_scale){
					with(instance_create(x, y, BulletHit)){
						var _variant	= irandom(4);	 
						sprite_index	= global.sprVoltergeistLightning[_variant];
						depth			= other.depth - 1;
					}
				}
				
				 // Speed Up Alarms:
				 // right now this is only used on snowtanks so just gonna do it simple like this
				 // if youre making a possessable enemy for whatever reason dont use this effect for it
				if(alarm1 > 3){
					alarm1 -= 1; // just double speed alarms essentially
				}
			}
		}	
		//#endregion
		
		//#region OILED UP BUFF
		with (global.buffOiledUp.targets){
			if(instance_exists(self)){
	
				if ("fr_buffOiledUp_check" not in self){ 
					fr_buffOiledUp_check = false; 
				}
				if(fr_buffOiledUp_check = false){
					fr_buffOiledUp_check = true;
	
				     // More Speed:
				    if(maxspeed > 0){
						maxspeed += 2;
				    }
				}
				
				 // Particles:
				if(random(3) < current_time_scale){
					with(instance_create(x, y + 6, AcidStreak)){
						sprite_index	= global.sprPetrolStreak;
						depth			= other.depth + 1;
						direction		= other.direction + 180 + random_range(-35, 35);
						image_angle		= direction;
					}
				}
		
			     // Cleanup Status Effect:
	            if (fr_buffOiledUp_time <= 1) && (fr_buffOiledUp_check = true){ 
				    fr_buffOiledUp_check = false;
				   
	                 // Undo Speed Gain:
					maxspeed -= 2;
				}
			}
		}	
		//#endregion
		/*
		//#region BURNING DEBUFF
		with (global.debuffBurning.targets){
			if instance_exists(self){
				instance_create(x, y, Flame)
			}
		}
		//#endregion
		*/
		/*
		//#region FREEZE DEBUFF
		with (global.debuffFreezing.targets){
			if instance_exists(self){
				
				 // Slow Movement Speed:
				speed *= (1 * 0.5);
				
				color_revert($ffe08c)
				
				 // Oh so Frozen
				if ("fr_debuffFrozen" not in self){ fr_debuffFrozen = false; }
				if (fr_debuffFreezing_time > (size * 100)) { 
					if (fr_debuffFrozen = false){
						color_revert($ffe08c)
					}
					fr_debuffFrozen = true;
				}
				if(fr_debuffFrozen = true){
					speed			= 0;
					x				= xprevious;
					y				= yprevious;
					image_index 	= 0;
					canmelee		= false;
				}
				
				 // If Player:
				if(instance_is(self, Player)){
					
				} else {
					 // If Enemy:
					if every(10){
						/// Slow Alarms, taken from Coldsnap freeze:
						if (variable_instance_get(self,"alarm" + string(1)) > 0){
							variable_instance_set(self,"alarm" + string(1), 
							variable_instance_get(self,"alarm" + string(1)) + (self ? 2 * (min(50, fr_debuffFreezing_time) / 20) : 0));
						}
						if variable_instance_exists(self,"alrm" + string(1)){
							if (variable_instance_get(self,"alrm" + string(1)) > 0){
								variable_instance_set(self,"alrm" + string(1), 
								variable_instance_get(self,"alrm" + string(1)) + (self ? 2 * (min(50, fr_debuffFreezing_time) / 20) : 0));
							}
						}
						if(fr_debuffFrozen = true){
							if (variable_instance_get(self,"alarm" + string(1)) > 0){
								variable_instance_set(self,"alarm" + string(1), 
								variable_instance_get(self,"alarm" + string(1)) + (self ? 2 * (min(50, fr_debuffFreezing_time) / 15) : 0));
							}
							if variable_instance_exists(self,"alrm" + string(1)){
								if (variable_instance_get(self,"alrm" + string(1)) > 0){
									variable_instance_set(self,"alrm" + string(1), 
									variable_instance_get(self,"alrm" + string(1)) + (self ? 2 * (min(50, fr_debuffFreezing_time) / 15) : 0));
								}
							}
						}
					}	
					
				}
	
				 // Cleanup Freeze:
				if (fr_debuffFreezing_time <= 1){
					 // UNFREEZE!
					fr_debuffFrozen = false;
					sound_play_pitchvol(sndHitFlesh, 0.7, 0.5)
					sound_play_pitchvol(sndHPPickup, 0.3, 0.2)
					with instance_create(x, y, BloodLust){
						creator			= other;
						sprite_index	= global.sprBuffBonusHealEnd;
					}
				}
			}
		}
		//#endregion
		*/
		//#region MAX HEALTH DOWN DEBUFF
		with (global.debuffHealthDown.targets){
			if instance_exists(self){
	
				 // Decreased Max Health:
				if ("fr_debuffHealthDown_hp" not in self){ 
					fr_debuffHealthDown_hp = false; 
				}
				if (fr_debuffHealthDown_hp = false){
					fr_debuffHealthDown_hp = true;
					
					with instance_create(x, y, BloodLust){
						creator			= other;
						sprite_index	= global.sprDebuffMaxHealthLossStart;
					}
					
					sound_play_pitchvol(sndCursedReminder, 1.4, 0.6)
				    sound_play_pitchvol(sndHealthChest, 0.4, 0.6)
				    
				     // Less Health:
					maxhealth -= 2;
					if (my_health >= maxhealth) { 
						my_health -= 2; 
						lasthit	= [global.sprDebuffMaxHealthLossGameover, "BAD DIET CHOICES"]
					}
				}
		
			     // Cleanup Status Effect:
	            if (fr_debuffHealthDown_time <= 1) && (fr_debuffHealthDown_hp = true){ 
				    fr_debuffHealthDown_hp = false;
				    sound_play_pitchvol(sndHealthChest, 0.7, 0.6)
				    
					with instance_create(x, y, BloodLust){
						creator			= other;
						sprite_index	= global.sprDebuffMaxHealthLossEnd;
					}
					
	                
	                 // Undo Max Health Loss:
	                maxhealth += 2;
					my_health += 2;
				}
			}
		}	
		//#endregion
	
		//#region BLIGHT (DoT) DEBUFF
		with (global.debuffBlight.targets){
			if instance_exists(self){
				if ("fr_debuffBlight_tick" not in self){ 
					fr_debuffBlight_tick = 300; 
				}
				
				
				if(random(18) < current_time_scale){
					with(instance_create(x + random_range(-5, 5), y + random_range(-5, 5), Bubble)){
						sprite_index		= global.sprDebuffBlight;
						direction			= 90 + random_range(-20, 20);
						speed				= 0.5 + random(1);
					}
				}
				
				 // Tick Damage
				if (fr_debuffBlight_tick <= 0){
					fr_debuffBlight_tick += 240
					
					 // Ow!
					if(my_health > 1){
						lasthit = [global.sprDebuffBlight, "UNINTENDED GAME DESIGN"]
						projectile_hit_raw(self, 1, snd_hurt)
						with(instance_create(x, y, PopupText)){
							mytext = "@(color:11412616)-1 HP"
						}
						sound_play_pitchvol(sndBloodHurt, 1.2, 0.6);
						sound_play_pitch(sndCursedReminder, 0.4);
						
						repeat(6){
							with(instance_create(x, y, Curse)){
								sprite_index	= global.sprDebuffBlight;
								direction		= random(360);
								speed			= 1 + random(2);
							}
				    	}
				    	repeat(2 + random(2)){
				    		with(instance_create(x, y, BloodStreak)){
				    			sprite_index	= global.sprDebuffBlightStreak;
				    			direction		= random(360);
				    		}
				    	}
					}
				} else {
					fr_debuffBlight_tick -= current_time_scale;
				}
				
			     // Cleanup Status Effect:
	            if (fr_debuffBlight_time <= 1){ 
				    sound_play_pitchvol(sndStrongSpiritGain, 0.4, 0.6)
				    
				    repeat(8){
						with instance_create(x, y, Curse){
							sprite_index	= global.sprDebuffBlight;
							direction		= random(360);
							speed			= 0.5 + random(1);
						}
				    }
				    
				     // Reset Timer:
				    fr_debuffBlight_tick = 300;
				}
			}
		}	
	}
	//#endregion
	
	//#region PLAGUE DEBUFF
	with(global.debuffPlague.targets){
		if instance_exists(self){
			if ("fr_debuffPlague_tick" not in self){ 
				fr_debuffPlague_tick = 25; 
			}
			
			if(instance_is(self, hitme)){
				
				if(random(18) < current_time_scale){
					with(instance_create(x + random_range(-5, 5), y + random_range(-5, 5), Bubble)){
						sprite_index		= global.sprDebuffPlague;
						direction			= 90 + random_range(-20, 20);
						speed				= 0.5 + random(1);
					}
				}
				
				 // Tick Damage
				// toxic immunity works on plague
				if((!instance_is(self, Player)) || ("notoxic" in self && notoxic = false)){
					if (fr_debuffPlague_tick <= 0){
						fr_debuffPlague_tick += 25
						
						 // Ow!
						lasthit = [global.sprDebuffPlague, "PLAGUE"]
						var _dmg = instance_is(self, Player) ? 1 : 6;
							projectile_hit_raw(self, _dmg, snd_hurt)
						
						repeat(2){
							with(instance_create(x, y, Curse)){
								sprite_index	= global.sprDebuffPlague;
								direction		= random(360);
								speed			= 1 + random(2);
							}
				    	}
				    	repeat(1 + random(2)){
				    		with(instance_create(x, y, BloodStreak)){
				    			sprite_index	= global.sprDebuffPlagueStreak;
				    			direction		= random(360);
				    		}
				    	}
				    	
					} else {
						fr_debuffPlague_tick -= current_time_scale;
					}
				}
				
		    	 // enemy died
		    	if(my_health <= 0){
					if(fr_plagueLevel > 0){
						repeat(clamp(size * 2, 1, 100)){
							with(mod_script_call("mod", "Frontier_Projectiles", "PlagueGas_create", x, y, fr_plagueLevel - 1)){
								direction	= random(360);
							}
						}
					}
		    	}
				
			     // Cleanup Status Effect:
	            if (fr_debuffPlague_time <= 1){ 
	
				     // Reset Timer:
				    fr_debuffPlague_tick	= 25;
				    fr_plagueLevel			= -1;
				}
			
			}
		}
	}	
	//#endregion
	
	//#region GAMMA GUTS AUGMENT DEBUFF
	with(global.debuffAugmentGammaGuts.targets){
		if instance_exists(self){
			if(instance_is(self, hitme)){
				if("fr_debuffAugmentGammaGuts_prevhealth" not in self){
					fr_debuffAugmentGammaGuts_prevhealth	= my_health;
					fr_debuffAugmentGammaGuts_reset 		= true; 
				}
				if(fr_debuffAugmentGammaGuts_reset			= true){
					fr_debuffAugmentGammaGuts_prevhealth	= my_health;
					fr_debuffAugmentGammaGuts_reset			= false;
				}
				
				 // damage reduction
			    var _diff = fr_debuffAugmentGammaGuts_prevhealth - my_health
			    if(_diff > 0){
					if(fr_debuffAugmentGammaGuts_prevhealth > my_health){
						my_health -= (_diff * 0.65)
						repeat(2 + irandom(2)){
							with(instance_create(x, y, BulletHit)){
								sprite_index	= (global.settingGreenAugments ? global.sprDebuffAugmentGammaGutsGreen : global.sprDebuffAugmentGammaGuts)
								direction		= random(360);
								image_angle		= direction;
								speed			= sprite_get_width(sprite_index) / 2;
								friction		= 0.3;
								image_index		= choose(0, 1);
								depth			= other.depth - 1;
							}
						}
					}
			    }
			    fr_debuffAugmentGammaGuts_prevhealth = my_health;
			    
			     // Cleanup Status Effect:
	            if(fr_debuffAugmentGammaGuts_time <= 1){ 
					fr_debuffAugmentGammaGuts_reset = true;
				}
			}
		}
	}	
	//#endregion

#define status_effects_init

	 // STATUS EFFECTS: //
	global.statusEffects = []
	
	 // Buffs:
	global.buffAugmentBeacon = {
		targets : [],
		key 	: "fr_buffAugmentBeacon_time"
	}
	global.buffBloodLust = {
		targets : [],
		key 	: "fr_buffBloodLust_time"
	}
	global.buffAmmoGain = {
		targets : [],
		key 	: "fr_buffAmmoGain_time"
	}
	global.buffHealthUp = {
		targets : [],
		key 	: "fr_buffHealthUp_time"
	}
	global.buffBonusHeal = {
		targets : [],
		key 	: "fr_buffBonusHeal_time"
	}
	global.buffFirerateUp = {
		targets : [],
		key 	: "fr_buffFirerateUp_time"
	}
	global.buffSpeedUp = {
		targets : [],
		key 	: "fr_buffSpeedUp_time"
	}
	/*
	global.buffCreepTrail = {
		targets : [],
		key 	: "fr_buffCreepTrail_time"
	}
	*/
	global.buffVoltergeist = {
		targets : [],
		key 	: "fr_buffVoltergeist_time"
	}
	global.buffOiledUp = {
		targets : [],
		key 	: "fr_buffOiledUp_time"
	}
	global.buffDeeplabsSpeedUp = {
		targets : [],
		key 	: "fr_buffDeeplabsSpeedUp_time"
	}
	
	 // Debuffs:
	/*
	global.debuffBurning = {
		targets : [],
		key 	: "fr_debuffBurn_time"
	}
	*/
	/*
	global.debuffFreezing = {
		targets : [],
		key 	: "fr_debuffFreezing_time"
	}
	*/
	global.debuffHealthDown = {
		targets : [],
		key 	: "fr_debuffHealthDown_time"
	}
	global.debuffBlight = {
		targets : [],
		key 	: "fr_debuffBlight_time"
	}
	global.debuffPlague = {
		targets : [],
		key 	: "fr_debuffPlague_time"
	}
	global.debuffAugmentGammaGuts = {
		targets : [],
		key 	: "fr_debuffAugmentGammaGuts_time"
	}
	
	 // Add (Timed) Statuses to Array:
	array_push(global.statusEffects, global.buffAugmentBeacon); 
	array_push(global.statusEffects, global.buffBloodLust); 
	array_push(global.statusEffects, global.buffAmmoGain); 
	array_push(global.statusEffects, global.buffHealthUp); 
	array_push(global.statusEffects, global.buffBonusHeal);
	array_push(global.statusEffects, global.buffFirerateUp);
	array_push(global.statusEffects, global.buffSpeedUp);
//	array_push(global.statusEffects, global.buffCreepTrail);
	array_push(global.statusEffects, global.buffVoltergeist);
	array_push(global.statusEffects, global.buffOiledUp);
	array_push(global.statusEffects, global.buffDeeplabsSpeedUp);
	
//	array_push(global.statusEffects, global.debuffBurning); 
//	array_push(global.statusEffects, global.debuffFreezing);
	array_push(global.statusEffects, global.debuffHealthDown);
	array_push(global.statusEffects, global.debuffBlight);
	array_push(global.statusEffects, global.debuffPlague);
	array_push(global.statusEffects, global.debuffAugmentGammaGuts);

#define status_apply_set(_target, _status, _duration)

	// SETS the status effect time to a specific amount on the target.
	
	var effectTime = variable_instance_get(_target, _status.key); 	
	if (effectTime == undefined){ effectTime = 0; }				
	effectTime = max(_duration, effectTime)
  
	variable_instance_set(_target, _status.key, effectTime)		
	if (array_find_index(_status.targets, _target) == -1) { 
    	array_push(_status.targets, _target)
	}


#define status_apply_add(_target, _status, _duration)
	
	// ADDS status effect time to the target.

	var effectTime = variable_instance_get(_target, _status.key); 
	if (effectTime == undefined){ effectTime = 0; }	
	if (effectTime > 0){ effectTime += _duration; }
	effectTime = max(_duration, effectTime)
	
	variable_instance_set(_target, _status.key, effectTime)			
	if (array_find_index(_status.targets, _target) == -1) { 
    	array_push(_status.targets, _target)
	}
	
#define array_delete(_array, _index)

	var _new = array_slice(_array, 0, _index);
	array_copy(_new, _index, _array, _index + 1, array_length(_array) - (_index + 1)); 
	return _new; 

#define every(_num) //every _num frames (objectively) trigger
	return frac(current_frame/_num) < current_time_scale/_num

#define color(_e, _from, _to)
    with _e if image_blend == _from image_blend = _to
    instance_destroy()
    
#define color_revert(_col) //set to a color, while tracking the previous color to revert to
    script_bind_end_step(color, 0, self, _col, image_blend)
    image_blend = _col
    
#define generic_trail_create(_x, _y) 
    with instance_create(_x, _y, Wind){
        sprite_index     = global.sprGenericTrail;
        mask_index       = mskNone;
        image_speed      = 2;
        image_yscale     = (1/50);
        image_xscale     = 1;
        depth			 = 0;
        
        return self;
    }
    
#macro  current_frame_active 				frac(current_frame) < current_time_scale
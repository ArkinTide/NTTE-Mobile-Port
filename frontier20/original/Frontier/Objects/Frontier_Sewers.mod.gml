#define init

	 // LIB:
	while(!mod_exists("mod", "lib")){wait(1);}
	script_ref_call(["mod", "lib", "getRef"], "mod", mod_current, "scr");
	#macro  scr			global.scr
	#macro  call		script_ref_call
	
	    // SOUNDS //
	global.sndWoodBreak							= sound_add("../sounds/props/sndWoodBreak.ogg")

        // SPRITES //
	 // Casino Gator Sprites:
	global.sprCasinoGatorIdle				    = sprite_add("../sprites/enemies/CasinoGator/sprCasinoGatorIdle.png",			8, 12, 12);
	global.sprCasinoGatorWalk				    = sprite_add("../sprites/enemies/CasinoGator/sprCasinoGatorWalk.png",			6, 12, 12);
	global.sprCasinoGatorHurt				    = sprite_add("../sprites/enemies/CasinoGator/sprCasinoGatorHurt.png",			3, 12, 12);
	global.sprCasinoGatorDead				    = sprite_add("../sprites/enemies/CasinoGator/sprCasinoGatorDead.png",			6, 12, 12);
	global.sprCasinoGatorWeap				    = sprite_add("../sprites/enemies/CasinoGator/sprCasinoGatorWeap.png",			1, 4, 1);
	
	 // Paintor Sprites:
	global.sprPaintorIdle					    = sprite_add("../sprites/enemies/Paintor/sprPaintorIdle.png",					8, 16, 16);
	global.sprPaintorOverlayIdle			    = sprite_add("../sprites/enemies/Paintor/sprPaintorOverlayIdle.png",			8, 16, 16);
	global.sprPaintorWalk					    = sprite_add("../sprites/enemies/Paintor/sprPaintorWalk.png",					6, 16, 16);
	global.sprPaintorOverlayWalk			    = sprite_add("../sprites/enemies/Paintor/sprPaintorOverlayWalk.png",			6, 16, 16);
	global.sprPaintorHurt					    = sprite_add("../sprites/enemies/Paintor/sprPaintorHurt.png",					3, 16, 16);
	global.sprPaintorOverlayHurt			    = sprite_add("../sprites/enemies/Paintor/sprPaintorOverlayHurt.png",			3, 16, 16);
	global.sprPaintorDead					    = sprite_add("../sprites/enemies/Paintor/sprPaintorDead.png",					6, 16, 16);
	global.sprPaintorWeap					    = sprite_add("../sprites/enemies/Paintor/sprPaintorWeap.png",					1, 3, 2);
	global.sprPaintorGameover				    = sprite_add("../sprites/enemies/Paintor/sprPaintorGameover.png",				8, 16, 12);
	
	 // Sludge Trap:
	global.sprSludgeTrap					    = sprite_add("../sprites/areas/sewers/sprSludgeTrap.png",						1, 8, 7);
	global.sprSludgeSplat					    = sprite_add("../sprites/areas/sewers/sprSludgeSplat.png",						1, 32, 32)
	
	 // Projectiles/Effects:
	global.sprPaintGas						    = sprite_add("../sprites/particles/sprPaintGas.png",							1, 24, 24);
	global.sprPaintGasSmall					    = sprite_add("../sprites/particles/sprPaintGasSmall.png",						1, 16, 16);
	global.sprPaintGasBig					    = sprite_add("../sprites/particles/sprPaintGasBig.png",							1, 64, 64);
	global.sprPaintShell					    = sprite_add("../sprites/projectiles/sprPaintShell.png",						2, 8, 8);	
	global.sprPaintShellOverlay				    = sprite_add("../sprites/projectiles/sprPaintShellOverlay.png",					2, 8, 8);	
	global.sprPaintShellDisappear			    = sprite_add("../sprites/projectiles/sprPaintShellDisappear.png",				6, 8, 8);		
	global.sprPaintShellDisappearOverlay	    = sprite_add("../sprites/projectiles/sprPaintShellDisappearOverlay.png",		6, 8, 8);	
	global.sprPaintStreak					    = sprite_add("../sprites/particles/sprPaintStreak.png",							7, 8, 8);	
	global.sprPaintBomb						    = sprite_add("../sprites/projectiles/sprPaintBomb.png",							1, 5, 5);	
	global.sprPaintSplat					    = sprite_add("../sprites/particles/sprPaintSplat.png",							1, 24, 24);
	global.sprPaintDust							= sprite_add("../sprites/particles/sprPaintDust.png",							5, 12, 12);
	
	 // Casino:
	global.sprSlotMachine						= sprite_add("../sprites/areas/sewers/props/sprSlotMachine.png",				1, 15, 16);	
	global.sprSlotMachineHurt					= sprite_add("../sprites/areas/sewers/props/sprSlotMachineHurt.png",			3, 15, 16);	
	global.sprSlotMachineDead					= sprite_add("../sprites/areas/sewers/props/sprSlotMachineDead.png",			3, 15, 16);	
	global.sprSlotMachineSpin					= sprite_add("../sprites/areas/sewers/props/sprSlotMachineSpin.png",			4, 15, 16);	
	global.sprSlotMachineLights					= sprite_add("../sprites/areas/sewers/props/sprSlotMachineLights.png", 			5, 12, 2);	
	global.sprSlotMachineLightsLoser			= sprite_add("../sprites/areas/sewers/props/sprSlotMachineLightsLoser.png",		3, 12, 2);	
	global.sprSlotMachineLightsWinner			= sprite_add("../sprites/areas/sewers/props/sprSlotMachineLightsWinner.png",	3, 12, 2);
	global.sprSlotMachineLightsSpinning	=[		sprite_add("../sprites/areas/sewers/props/sprSlotMachineLightsSpinning0.png",	3, 12, 2),
												sprite_add("../sprites/areas/sewers/props/sprSlotMachineLightsSpinning1.png",	3, 12, 2),
												sprite_add("../sprites/areas/sewers/props/sprSlotMachineLightsSpinning2.png",	3, 12, 2),
												sprite_add("../sprites/areas/sewers/props/sprSlotMachineLightsSpinning3.png",	3, 12, 2)];
	global.sprSlotSpinning						= sprite_add("../sprites/areas/sewers/props/sprSlotSpinning.png",				12, 4, 4);
	global.sprSlot = [							sprite_add("../sprites/areas/sewers/props/sprSlotAmmo.png",						1, 4, 4),
												sprite_add("../sprites/areas/sewers/props/sprSlotHP.png",						1, 4, 4),
												sprite_add("../sprites/areas/sewers/props/sprSlotRads.png",						1, 4, 4),
												sprite_add("../sprites/areas/sewers/props/sprSlotWeapon.png",					1, 4, 4)];
	global.sprCounter							= sprite_add("../sprites/areas/sewers/props/sprCounter.png",					1, 32, 16);	
	global.sprCounterHurt						= sprite_add("../sprites/areas/sewers/props/sprCounterHurt.png",				3, 32, 16);
	global.sprCounterDead						= sprite_add("../sprites/areas/sewers/props/sprCounterDead.png",				3, 32, 16);
	global.sprSodaCans							= sprite_add("../sprites/areas/sewers/props/sprSodaCans.png",					18, 4, 8);	
	global.sprBartenderGator					= sprite_add("../sprites/areas/sewers/props/sprBartenderGator.png",				5, 12, 12);
	global.shdCounter							= sprite_add("../sprites/areas/sewers/props/shdCounter.png",					1, 32, 16);	
	global.mskCounter							= sprite_add("../sprites/areas/sewers/props/mskCounter.png",					1, 32, 16);
	global.sprCouch								= sprite_add("../sprites/areas/sewers/props/sprCouch.png", 						1, 24, 16);	
	global.sprCouchHurt							= sprite_add("../sprites/areas/sewers/props/sprCouchHurt.png", 					3, 24, 16);	
	global.sprCouchDead							= sprite_add("../sprites/areas/sewers/props/sprCouchDead.png", 					3, 24, 16);	
	global.sprCouchgoerGator					= sprite_add("../sprites/areas/sewers/props/sprCouchgoerGator.png",				1, 8, 4);
	global.sprCouchgoerCat						= sprite_add("../sprites/areas/sewers/props/sprCouchgoerCat.png",				24, 8, 4);	
	global.sprCasinoTV							= sprite_add("../sprites/areas/sewers/props/sprCasinoTV.png",					1, 24, 16);	
	global.sprCasinoTVHurt						= sprite_add("../sprites/areas/sewers/props/sprCasinoTVHurt.png",				3, 24, 16);	
	global.sprCasinoTVDead						= sprite_add("../sprites/areas/sewers/props/sprCasinoTVDead.png",				3, 24, 16);	
	global.sprCasinoTVCraft =[					sprite_add("../sprites/areas/sewers/props/sprCasinoTVCraft1.png",				2, 10, 6),	
												sprite_add("../sprites/areas/sewers/props/sprCasinoTVCraft2.png",				2, 10, 6),	
												sprite_add("../sprites/areas/sewers/props/sprCasinoTVCraft3.png",				2, 10, 6)];
	global.sprCasinoTVUpturned =[				sprite_add("../sprites/areas/sewers/props/sprCasinoTVUpturned1.png",			2, 10, 6),	
												sprite_add("../sprites/areas/sewers/props/sprCasinoTVUpturned2.png",			2, 10, 6),	
												sprite_add("../sprites/areas/sewers/props/sprCasinoTVUpturned3.png",			2, 10, 6)];		
	
	 // Paintor Decals:
	global.sprGraffiti							= sprite_add("../sprites/areas/sewers/sprGraffiti.png", 						9, 32, 32);	
	
	
#define CasinoGator_create(_x, _y)
	with(instance_create(_x, _y, CustomEnemy)){
    	name = "Bartender"
    	
        //Visuals:
        spr_idle		= global.sprCasinoGatorIdle;
		spr_walk		= global.sprCasinoGatorWalk;
		spr_hurt		= global.sprCasinoGatorHurt;
		spr_dead		= global.sprCasinoGatorDead;
		spr_weap		= global.sprCasinoGatorWeap;
		sprite_index    = spr_idle;
		image_speed     = 0.4;
		depth           = -2;
		hitid           = [spr_idle, "BARTENDER"]
        spr_shadow      = shd24;	
        nts_color_blood = [c_red, make_color_rgb(134, 44, 35)]
        
        //Sounds:
        snd_hurt		= sndGatorHit;
        snd_dead		= sndGatorDie;
        
        //Vars:
        mask_index  	= mskBandit;
        direction   	= random(360);
        maxhealth   	= 18;
       	my_health   	= maxhealth;
        raddrop     	= 12;
        maxspeed    	= 3.5;
        walkspeed   	= maxspeed;
        canmelee    	= 0;
        meleedamage 	= 0;
        team        	= 1;
        targetvisible	= 0;
        target      	= 0;
        walk        	= 0;
        gunangle    	= 180;

        //Alarms:
        alarm1 = 10;

        //Scripts:
        on_step  = script_ref_create(CasinoGator_step);
        on_draw  = GunEnemy_draw;
        on_hurt  = Enemy_hurt;
        on_death = CasinoGator_death;
        on_alrm1 = script_ref_create(CasinoGator_alrm1);
        on_alrm2 = script_ref_create(CasinoGator_alrm2);
        
        return self;
	}

#define CasinoGator_step

	 // Alarms:
	if("on_alrm1" in self and alarm1_run) exit;
	if("on_alrm2" in self and alarm2_run) exit;

		// Movement:
	if(walk > 0){ walk -= current_time_scale;   speed += walkspeed * current_time_scale;   gunangle = direction }
	
		//Speed Cap:
	if(speed > maxspeed){ speed = maxspeed; }
	
		 // Animate:
	sprite_index = enemy_sprite;
	right = (gunangle + 270) mod 360 > 180 ? 1 : -1;

#define CasinoGator_alrm1
	alarm1 = 40 + irandom(30);

	if(enemy_target(x, y) and target_visible) {
		enemy_look(target_direction);
		
			// GET YOU:
		if(target_distance > 128){
			alarm1 = 30 + irandom(15);
			enemy_walk(target_direction + orandom(30), alarm1 - 10);
		}
			 // If in range:
		if(target_distance < 128){
			 // Attack:
			 // Not too close!
			if(chance(3, 4) && (target_distance > 32)){
				alarm1 = 45 + irandom(20);
				instance_create(x, y, AssassinNotice)
				alarm2 = 10;
			}
			
					 // Move Away From Target:
			else{
				alarm1 = 30 + irandom(15);
				enemy_walk(gunangle + 180 + orandom(30), alarm1 - 10);
			}
		}
	}
	
	 // Wander Around Town:
	else{
		enemy_walk(random(360), 30);
		enemy_look(direction);
	}
	
#define CasinoGator_alrm2
	var _spd = 1;
	repeat(12){
		with instance_create(x, y, EnemyBullet3){
			speed		= 8 + (_spd)
			direction	= other.gunangle + random_range(-3, 3);
			image_angle = direction;
			creator		= other;
			team		= other.team
			hitid		= other.hitid;
		}
		_spd += 1;
		sound_play_pitch(sndFireShotgun, 1.1 + random(0.3));
		sound_play_pitch(sndEraser, 1.1 + random(0.3));
		motion_add(gunangle, -1)
	}
	
#define CasinoGator_death
	pickup_drop(200, 0);

#define Paintor_create(_x, _y)
	with(instance_create(_x, _y, CustomEnemy)){
    	name = "Paintor"
    	
            // Visuals:
        spr_idle		= global.sprPaintorIdle;
    	spr_idle2		= global.sprPaintorOverlayIdle;
		spr_walk		= global.sprPaintorWalk;
    	spr_walk2		= global.sprPaintorOverlayWalk;
		spr_hurt		= global.sprPaintorHurt;
    	spr_hurt2		= global.sprPaintorOverlayHurt;
		spr_dead		= global.sprPaintorDead;
		spr_weap		= global.sprPaintorWeap;
		spr_gameover	= global.sprPaintorGameover;
		sprite_index    = spr_idle;
		sprite_index2	= spr_idle2;
		image_speed     = 0.4;
		depth           = -2;
		hitid           = [spr_gameover, "PAINTOR"]
        spr_shadow      = shd24;	
        spr_shadow_y	= -1;
        nts_color_blood = [c_red, make_color_rgb(134, 44, 35)]
        
         // Color:
		var _colorHue	= choose(random(50), 106 + random(149)); // Skip Green:
		color			= make_color_hsv(_colorHue, 255, 255);
		color2			= make_color_hsv(_colorHue, 255, 230 + irandom(10));
		color3			= make_color_hsv(_colorHue, 255, 200 + irandom(10));
        
        //Sounds:
        snd_hurt		= sndGatorHit;
        snd_dead		= sndGatorDie;
        
        //Vars:
        mask_index  	= mskBandit;
        direction   	= random(360);
        maxhealth   	= 18;
       	my_health   	= maxhealth;
        raddrop     	= 12;
        maxspeed    	= 3;
        walkspeed   	= maxspeed;
        canmelee    	= 0;
        meleedamage 	= 0;
        team        	= 1;
        targetvisible	= 0;
        target      	= 0;
        walk        	= 0;
        gunangle    	= 180;
        ammo			= 0;
        target_x		= 10016;
        target_y		= 10016;

        //Alarms:
        alarm1			= 45;
        alarm2			= 0;

        //Scripts:
        on_step 		= script_ref_create(Paintor_step);
        on_draw 		= Paintor_draw;
        on_hurt 		= Paintor_hurt;
        on_death		= Paintor_death;
        on_alrm1		= script_ref_create(Paintor_alrm1);
        on_alrm2		= script_ref_create(Paintor_alrm2);
        
        return self;
	}

#define Paintor_step
	#macro  p_sprite2 (sprite_index2 != spr_hurt2 || anim_end) ? ((speed == 0) ? spr_idle2 : spr_walk2) : sprite_index

	 // Alarms:
	if("on_alrm1" in self and alarm1_run) exit;
	if("on_alrm2" in self and alarm2_run) exit;

		// Movement:
	if(walk > 0){ walk -= current_time_scale;   speed += walkspeed * current_time_scale;   gunangle = direction }
	
		//Speed Cap:
	if(speed > maxspeed){ speed = maxspeed; }
	
		// Animate:
	if(anim_end){ 
		sprite_index  = (speed > 0) ? spr_walk  : spr_idle; 
		sprite_index2 = (speed > 0) ? spr_walk2 : spr_idle2; 
	}
	else{	
		sprite_index  = enemy_sprite;
		if(sprite_index2 != spr_hurt2){
			sprite_index2 = p_sprite2;
		}
	}
	
	/*
	if(random(10) < 1){
		with(instance_create(x, y, Dust)){
			sprite_index	= global.sprPaintDust;
			image_blend		= choose(other.color, other.color2, other.color3);
			direction		= random(360);
			speed			= 2 + random(2);
			image_xscale	= 0.5;
			image_yscale	= 0.5;
			depth			= -10;
		}
	}
	*/
	
		//Use Your Eyes:
	right = (gunangle + 270) mod 360 > 180 ? 1 : -1;

#define Paintor_alrm1
	alarm1 = 40 + irandom(30);
	
	 // Attack:
	if(ammo > 0){
		alarm1 = 3;
		
		if(enemy_target(x, y)){
			gunangle = gunangle + clamp(angle_difference(target_direction, gunangle), -10, 10) + random_range(-5, 5);
			enemy_look(gunangle);
			
			 // Normal Projectile:
			with(instance_create(x, y, EnemyBullet3)){
				speed		= 14 + random_range(-2, 2);
				direction	= other.gunangle + random_range(-10, 10);
				image_angle = direction;
				creator		= other;
				team		= other.team
				hitid		= other.hitid;
			}
			
			 // Random Color:
			var _randColorHue	= choose(random(50), 106 + random(149)),
			_randColor			= make_color_hsv(_randColorHue, 255, 255),
			_randColor2			= make_color_hsv(_randColorHue, 255, 230 + irandom(10)),
			_randColor3			= make_color_hsv(_randColorHue, 255, 200 + irandom(10)),
			_shellColor			= choose("Random", "Gator");
			
			 // 50/50 for random or preferred color:
			switch(_shellColor){
				case "Random":
					 // Projectile:
					with(PaintShell_create(x, y, _randColor, _randColor2, _randColor3)){
						speed		= 14 + random_range(-2, 2);
						direction	= other.gunangle + random_range(-10, 10);
						image_angle = direction;
						creator		= other;
						team		= other.team
						hitid		= other.hitid;
					}	
					 // Streaks:
					repeat(2){
						with(instance_create(x, y, BloodStreak)){
							sprite_index	= global.sprPaintStreak;
							image_index		= irandom(1);
							image_blend		= _randColor;
							direction		= other.gunangle + random_range(-45, 45);
							image_angle 	= direction;
							speed			= 2 + random(3);
						}
					}
				break;
				case "Gator":
					 // Projectile:
					with(PaintShell_create(x, y, color, color2, color3)){
						speed		= 14 + random_range(-2, 2);
						direction	= other.gunangle + random_range(-10, 10);
						image_angle = direction;
						creator		= other;
						team		= other.team
						hitid		= other.hitid;
					}	
					 // Streaks:
					repeat(2){
						with(instance_create(x, y, BloodStreak)){
							sprite_index	= global.sprPaintStreak;
							image_index		= irandom(1);
							image_blend		= other.color;
							direction		= other.gunangle + random_range(-45, 45);
							image_angle 	= direction;
							speed			= 2 + random(3);
						}
					}
				break;
			}
			
			 // SFX and (other) VFX:
			sound_play_pitch(sndPopgun, 1.1 + random(0.3));
			sound_play_pitch(sndHitFlesh, 1.1 + random(0.3));
			wkick += 3;
		}

		 // End Attack:
		if(--ammo <= 0){
			alarm1	= 60;
			 // Throw Paint Bomb (low chance):
			if(chance(1, 8) && alarm2 <= 0){
				alarm2 = 1;
			}
		}
		
	 // Normal Behavior:
	} else {
		if(enemy_target(x, y)){
			
				// GET YOU:
			if(target_distance > 160){
				if(target_visible){
					alarm1 = 30 + irandom(15);
					enemy_walk(target_direction + orandom(30), alarm1 - 10);
					 // Throw Paint Bomb (high chance):
					if(chance(1, 4) && alarm2 <= 0){
						alarm2 = 1;
					} else {
						if(chance(1, 3)){
							enemy_walk(random(360), alarm1);
							enemy_look(direction);	
						}
					}
				}
			}
				 // If in range:
			if(target_distance < 160 && target_visible){
				 //  Start Attack:
				if(chance(3, 4) && (target_distance > 48)){
					instance_create(x, y, AssassinNotice);
					enemy_look(target_direction);
					alarm1	= 8;
					ammo	= 5; 
				}
					 // Move Away From Target:
				else{
					alarm1 = 30 + irandom(15);
					enemy_walk(gunangle + 180 + orandom(30), alarm1 - 10);
					// Throw Paint Bomb (higher chance):
					if(chance(1, 3) && alarm2 <= 0){
						alarm2 = 1;
					}
				}
			} else {
				if(chance(1, 3)){
					enemy_walk(random(360), alarm1);
					enemy_look(direction);	
				}				
			}
		}
		
		 // Wander Around Town:
		else{
			if(chance(1, 3)){
				enemy_walk(random(360), 30);
				enemy_look(direction);
			}
		}
	}

#define Paintor_alrm2

	 // Target:
	if(instance_exists(target)){
		if(target_distance < 224){
			target_x = target.x + (target.hspeed) + random_range(-24, 24);
			target_y = target.y + (target.vspeed) + random_range(-24, 24);
			
			 // Random Color:
			var _randColorHue	= choose(random(50), 106 + random(149)),
			_randColor			= make_color_hsv(_randColorHue, 255, 255),
			_randColor2			= make_color_hsv(_randColorHue, 255, 230 + irandom(10)),
			_randColor3			= make_color_hsv(_randColorHue, 255, 200 + irandom(10)),
			_bombColor			= choose("Random", "Gator", "Gator");
			
			 // 50/50 for random or preferred color:
			 // what is he talking about? no it isn't???
			switch(_bombColor){
				case "Random":
					 // Projectile:
					with(PaintBomb_create(x, y, _randColor, _randColor2, _randColor3)){		// why didn't you just make it an array? you don't need 3 of these and 3 color vars. whatever im not fixing it it works.
						mask_index		= mskNone;
						z				= 13;
						zspeed  		= 11 + random(2);
						zfriction		= 0.6;
						direction		= point_direction(x, y, other.target_x, other.target_y);
						speed   		= (point_distance(x, y, other.target_x, other.target_y) * zfriction) / (zspeed * 2);
						image_angle 	= direction;
						target_x		= other.target_x;
						target_y		= other.target_y;
						team        	= other.team;
						creator 		= other;
						hitid			= other.hitid;
					}
				break;
				case "Gator":
					 // Projectile:
					with(PaintBomb_create(x, y, color, color2, color3)){
						mask_index		= mskNone;
						z				= 13;
						zspeed  		= 11 + random(2);
						zfriction		= 0.6;
						direction		= point_direction(x, y, other.target_x, other.target_y);
						speed   		= (point_distance(x, y, other.target_x, other.target_y) * zfriction) / (zspeed * 2);
						image_angle 	= direction;
						target_x		= other.target_x;
						target_y		= other.target_y;
						team        	= other.team;
						creator 		= other;
						hitid			= other.hitid;
					}	
				break;
			}
			 // SFX:
			sound_play_pitchvol(sndMeleeFlip, 0.8 + random(0.1), 1.5);
			
			 // Alarm:
			alarm2 = 380;
		} else {
			alarm2 = 60;
		}
	}
	
#define Paintor_hurt(_dmg, _spd, _dir)
	image_index 	= 0;
	sprite_index	= spr_hurt;
	sprite_index2	= spr_hurt2;
	
	sound_play_hit(snd_hurt, 0.3);
	motion_add(_dir, _spd);
	
	nexthurt   = current_frame + 6;
	my_health -= _dmg;
	
#define Paintor_draw
	if (gunangle < 180){ 
		draw_sprite_ext(spr_weap, 0, x + lengthdir_x(-wkick, gunangle), y + lengthdir_y(-wkick, gunangle), 1, right, gunangle, image_blend, image_alpha); 
	} 
	
	draw_sprite_ext(sprite_index,  image_index, x, y, image_xscale * right, image_yscale, image_angle, image_blend, image_alpha);
	draw_sprite_ext(sprite_index2, image_index, x, y, image_xscale * right, image_yscale, image_angle, color, image_alpha);
	
	if(gunangle >= 180){ 
		draw_sprite_ext(spr_weap, 0, x + lengthdir_x(-wkick, gunangle), y + lengthdir_y(-wkick, gunangle), 1, right, gunangle, image_blend, image_alpha);
	}
	
#define Paintor_death
	pickup_drop(22, 10);
	repeat(6){
		with(PaintGas_create(x, y, choose(true, false))){
			image_blend	= choose(other.color, other.color2, other.color3);
			direction	= random(360);
			speed		= 5;
			friction	= 0.7;
			lifetime	= 100 + irandom(20);
		}
		with(instance_create(x, y, BloodStreak)){
			sprite_index	= global.sprPaintStreak;
			image_index		= irandom(1);
			image_blend		= other.color;
			direction		= random(360);
			image_angle 	= direction;
			speed			= 5 + random(3);
		}
	}
		
#define PaintBombLinger_create(_x, _y, _color, _color2, _color3)
	with(instance_create(_x, _y, CustomProjectile)){
		color			= _color;
		color2			= _color2;
		color3			= _color3;
		image_blend		= color;
		
         // Visuals:
        sprite_index    = global.sprPaintGasBig;
        depth			= -8;
        image_angle		= random(360);
        rotateSpeed 	= 1.2;
        image_xscale	= 0.5;
        image_yscale	= image_xscale;
        fr_bloom		= [1.2, 0.1];  
     
        
         // Vars:
        mask_index		= mskNone;
        lifetime		= 300;
        range			= 60;
        allGrownUp		= false;
        maxSize 		= 1;
        
        on_step         = PaintBombLinger_step;
        on_hit			= nothing;
        on_wall 		= nothing;
        
        return self;
	}
	
#define PaintBombLinger_step
	if(random(20) < 1){
		with(PaintGas_create(x + random_range(-range, range), y + random_range(-range, range), false)){
			direction	= random(360);
			speed		= random(2);
			friction	= 0.05;
			image_blend	= choose(other.color, other.color2, other.color3)
		}
	}
	if(random(12) < 1){
		with(PaintGas_create(x + random_range(-range, range), y + random_range(-range, range), true)){
			direction	= random(360);
			speed		= random(2);
			friction	= 0.05;
			image_blend	= choose(other.color, other.color2, other.color3)
		}
	}

	lifetime -= current_time_scale;
	image_angle += rotateSpeed;
	
	 // Grow:
	if(image_xscale < maxSize && allGrownUp = false){
		image_xscale += 0.2;
		image_yscale = image_xscale;
		if(image_xscale >= maxSize){
			allGrownUp = true;
		}
	}
	
	if(lifetime <= 0){
		image_xscale -= 0.05;
		image_yscale  = image_xscale;
		if(image_xscale <= 0){
			instance_destroy();
		}
	}	
	
#define PaintGas_create(_x, _y, _small)
	with(instance_create(_x, _y, CustomProjectile)){
		
         // Visuals:
        sprite_index    = global.sprPaintGas;
        image_index		= irandom(image_number);
        image_speed		= 0;
        image_angle		= random(360);
        depth			= -9;
        rotateSpeed 	= (random_range(2, 5) * choose(-1, 1)) * current_time_scale;
        image_xscale	= 0;
        image_yscale	= image_xscale;
        fr_bloom		= [1.5, 0.1];  
        
         // Vars:
        mask_index		= mskNone;
        speed           = 0;
        typ             = 0;
        damage          = 0;
        team			= 0;
        hitid           = [sprite_index, "PAINT"];
        lifetime		= 200;
        allGrownUp		= false;
        maxSize			= 1;
        
        on_step         = PaintGas_step;
        on_hit			= nothing;
        
        if(_small = true){
        	sprite_index	= global.sprPaintGasSmall;
        }
        
        return self;
	}
	
#define PaintGas_step
	lifetime -= current_time_scale;
	image_angle += rotateSpeed;
	
	 // Grow:
	if(image_xscale < maxSize && allGrownUp = false){
		image_xscale += 0.2;
		image_yscale = image_xscale;
		if(image_xscale >= maxSize){
			allGrownUp = true;
		}
	}
	
	if(lifetime <= 0){
		image_xscale -= 0.05;
		image_yscale  = image_xscale;
		if(image_xscale <= 0){
			instance_destroy();
		}
	}	

#define PaintShell_create(_x, _y, _color, _color2, _color3)
    with instance_create(_x, _y, CustomProjectile){
    	name = "fr_PaintShell";
        
         // Visuals:
        sprite_index    = global.sprPaintShell;
        spr_overlay		= global.sprPaintShellOverlay;
        spr_fade		= global.sprPaintShellDisappear;
        spr_fade_over	= global.sprPaintShellDisappearOverlay
        spr_dead		= global.sprPaintShellDisappear;
        color			= _color;
        color2			= _color2;
        color3			= _color3;
        
         // Vars:
        speed           = (10 + random(2)) * power(0.8, skill_get(mut_euphoria));
        friction		= 0.6;
        typ             = 1;
        damage          = 1;
        creator         = other;
        team            = other.team;
        hitid           = [sprite_index, "PAINT SHELL"];
        minspeed		= 1.2;
        
        on_anim			= PaintShell_anim;
        on_step         = PaintShell_step;
        on_wall			= PaintShell_wall;
        on_hit			= PaintShell_hit;
        on_draw 		= PaintShell_draw;
        
        return self;
    }
    
#define PaintShell_anim
	if(!instance_exists(self)){ exit; }
	if(sprite_index != spr_fade){
		image_speed = 0;
		image_index = image_number - 1;
	}
	
	 // Poof:
	else instance_destroy();
    
#define PaintShell_step
    if(random(16) < 1){
        with(instance_create(x + random_range(-8, 8), y + random_range(-8, 8), Smoke)){
			motion_add(other.direction + 180 + orandom(10), (other.speed / 2))
        }
    }
    
	 // Disappear:
	if(speed < minspeed && sprite_index != spr_fade){
		PaintShell_spreadpaint();
		sprite_index = spr_fade;
		spr_overlay	 = spr_fade_over;
		image_index  = 0;
		image_speed  = 0.4;
	}
	
#define PaintShell_wall
	instance_create(x, y, Smoke);
	if(speed > minspeed){
		sound_play_hit(sndShotgunHitWall, 0.2);
	}

	 // Bounce:
	move_bounce_solid(true);
	image_angle = direction;
	speed = speed * 0.9;
	
#define PaintShell_spreadpaint
	sound_play_pitch(sndHitFlesh, 1.1 + random(0.2));
	sound_play_pitch(sndToxicBoltGas, 1.2 + random(0.2));
	repeat(4){
		with(PaintGas_create(x, y, choose(true, false))){
			image_blend	= choose(other.color, other.color2, other.color3);
			direction	= random(360);
			speed		= 5;
			friction	= 0.5;
			lifetime	= 80 + irandom(20);
		}
		with(instance_create(x, y, BloodStreak)){
			sprite_index	= global.sprPaintStreak;
			image_index		= irandom(1);
			image_blend		= other.color;
			direction		= random(360);
			image_angle 	= direction;
			speed			= 5 + random(3);
		}
	}

#define PaintShell_hit
	projectile_hit(other, damage);
	PaintShell_spreadpaint();
	instance_destroy();

#define PaintShell_draw
	draw_self();
	draw_sprite_ext(spr_overlay, image_index, x, y, image_xscale, image_yscale, image_angle, color, image_alpha)
	draw_set_blend_mode(bm_add);
	draw_sprite_ext(sprite_index, image_index, x, y, image_xscale * 1.6, image_yscale * 1.6, image_angle, image_blend, 0.3);
	draw_sprite_ext(spr_overlay, image_index, x, y, image_xscale * 1.6, image_yscale * 1.6, image_angle, color, 0.3);
	draw_set_blend_mode(bm_normal);
	
#define PaintBomb_create(_x, _y, _color, _color2, _color3)
    with instance_create(_x, _y, CustomProjectile){
    	name = "fr_PaintBomb";
        
         // Visuals:
        sprite_index    = global.sprPaintBomb;
        color			= _color;
        color2			= _color2;
        color3			= _color3;
        
         // Vars:
        speed           = (10 + random(2)) * power(0.8, skill_get(mut_euphoria));
        friction		= 0.6;
        typ             = 1;
        damage          = 0;
        creator         = other;
        team            = other.team;
        hitid           = [sprite_index, "PAINT BOMB"];
        z				= 0;
		zspeed  		= 0;
		zfriction		= 1;
		turnspeed		= (10 * choose(-1, 1)) * current_time_scale;
		target_x		= 0;
		target_y		= 0;
        
        on_step         = PaintBomb_step;
        on_destroy		= PaintBomb_destroy;
        on_draw 		= PaintBomb_draw;
        
        return self;
    }

#define PaintBomb_step

	 // Particles:
	if(random(4) < 1){
        with(instance_create(x + random_range(-8, 8), (y - z) + random_range(-8, 8), Dust)){
			sprite_index	= sprBreath;
			depth			= -11;
			direction       = other.direction + 180 + (other.z / 70) + random_range(-20, 20);
			speed			= random(1);
			image_blend 	= other.color;
		}
	}
	
	image_angle += turnspeed;
	
	 // Z-Axis:
	z += zspeed * current_time_scale;
	zspeed -= zfriction * current_time_scale;
	image_angle -= sign(hspeed) * (abs(vspeed / 2) + abs(hspeed));
	
	 // Set Mask:
	if(z <= 12){
		mask_index	= mskEnemyBullet1;
	} else {
		mask_index  = mskNone;
	}
	
	 // Set Z Goin:
	if(z <= 0){
		friction	= 0.4;
		depth		= -3;
		
		 // Movement:
		if(speed > 0){
			var m = 4;
			if(speed > m) speed = m;
		}
		
		 // Impact:
		instance_destroy();
	}
	
	 // While In Air:
	else{
		friction	= 0;
		depth		= -10;
	}

#define PaintBomb_destroy

	sound_play_pitch(sndHitFlesh, 1.1 + random(0.2));
	sound_play_pitch(sndToxicBarrelGas, 1.2 + random(0.2));
	sound_play_pitch(sndExplosionS, 1.1 + random(0.1));
	PaintBombLinger_create(x, y, color, color2, color3);
	repeat(8){
		with(PaintGas_create(x, y, choose(true, false))){
			image_blend	= choose(other.color, other.color2, other.color3);
			direction	= random(360);
			speed		= 8;
			friction	= 0.5;
			lifetime	= 80 + irandom(20);
		}
		with(instance_create(x, y, BloodStreak)){
			sprite_index	= global.sprPaintStreak;
			image_index		= irandom(1);
			image_blend		= other.color;
			direction		= random(360);
			image_angle 	= direction;
			speed			= 8 + random(3);
		}
	}
	PaintSplat_create(x, y, other.color)

#define PaintSplat_create(_x, _y, _color)
	with(instance_create(_x, _y, CustomObject)){
		name = "fr_paintSplat";
		
		sprite_index	= global.sprPaintSplat;
		image_angle		= random(360);
		image_blend		= _color;
		depth			= 7;
		
		return self;
	}

#define PaintBomb_draw
  	draw_sprite_ext(sprite_index, image_index, x, (y - z), (image_xscale + z / 260), (image_yscale + z / 260), image_angle, color, image_alpha);
  	
#define SludgeTrap_create(_x, _y)
	with(instance_create(_x,_y, CustomObject)){
		with instance_create(x, y, TrapScorchMark){ 
			sprite_index	= global.sprSludgeSplat;
			depth			= 7; 
		}
		
		 // Visual:
		sprite_index		= global.sprSludgeTrap;
		depth				= -1;
		
		 // Vars:
		creator 			= instance_position(x, y, Wall);
		fire_timer			= 80 + random_range(0, 30);
		fire_mode			= choose(1, 2)
		
		 // Events::
		on_step 			= SludgeTrap_step;
		
		return self;
	}
    
#define SludgeTrap_step

	 // Destroy if Wall Dead:
	if !instance_exists(creator){ instance_destroy(); exit; }
    
 	 // Timer:
	if(fire_timer > 0){ 
		fire_timer -= current_time_scale; 
	}
    
     // Active if No Portal:
	if(!instance_exists(Portal) && (fire_timer <= 0)){ 
		fire_timer += 180; 
		SludgeTrap_fire()
	}

#define SludgeTrap_fire
	if(distance_to_object(Player) < 192){
		sound_play_pitch(sndOasisMelee, 0.8 + random(0.2));
		sound_play_pitch(sndOasisChest, 0.8 + random(0.2));
	}
			
	switch(fire_mode){
	
		case 1:
			
			if(!instance_position(x + 8, y + 20, Wall)){
				with(SludgeTrapProjectile_create(x + 8, y + 16)){
					direction		= 270;
				}
				repeat(2 + irandom(2)){
					with(instance_create(x + 8, y + 20, AcidStreak)){
						speed		= 2 + random(2);
						direction	= 270 + random_range(-45, 45);
						image_angle	= direction;
					}
				}
			}
		
			if(!instance_position(x + 8, y - 16, Wall)){
				with(SludgeTrapProjectile_create(x + 8, y - 8)){
					direction		= 90;
				}
				repeat(2 + irandom(2)){
					with(instance_create(x + 8, y - 16, AcidStreak)){
						speed		= 2 + random(2);
						direction	= 90 + random_range(-45, 45);
						image_angle	= direction;
					}
				}
			}
	
			fire_mode = 2;
	
		break;
	
		case 2:
			
			if(!instance_position(x - 16, y + 4, Wall)){
				with(SludgeTrapProjectile_create(x - 2, y + 8)){
					direction		= 180;
				}
				repeat(2 + irandom(2)){
					with(instance_create(x - 16, y + 4, AcidStreak)){
						speed		= 2 + random(2);
						direction	= 180 + random_range(-45, 45);
						image_angle	= direction;
					}
				}
			}
	
			if(!instance_position(x + 24, y + 4, Wall)){
				with(SludgeTrapProjectile_create(x + 16, y + 8)){
					direction		= 0;
				}
				repeat(2 + irandom(2)){
					with(instance_create(x + 16, y + 8, AcidStreak)){
						speed		= 2 + random(2);
						direction	= 0 + random_range(-45, 45);
						image_angle	= direction;
					}
				}
			}
		
			fire_mode = 1;
	
		break;
	}
	
#define SludgeTrapProjectile_create(_x, _y)
	with(instance_create(_x, _y, CustomProjectile)){
		sprite_index	= mskNone;
		mask_index		= mskEnemyBullet1;
		speed			= 5;
		damage			= 0;
		sludgeDelay 	= 0;
		
		on_step 		= SludgeTrapProjectile_step;	
		on_hit			= nothing;
		on_destroy		= SludgeTrapProjectile_destroy;
		
		return self;
	}
	
#define SludgeTrapProjectile_step
	sludgeDelay -= current_time_scale;
	if(sludgeDelay <= 0){
		sludgeDelay += speed / 2;
		with(mod_script_call("mod", "Frontier_Labs", "GatorCreep_create", x, y)){
			image_xscale	= choose(0.4, 0.5);
			image_yscale	= image_xscale;
			lifetime		= 180;
		}
		instance_create(x, y, AcidStreak)
	}
	if(speed <= 0){
		instance_destroy();
	}
	
#define SludgeTrapProjectile_destroy
	repeat(3 + irandom(2)){
		with(instance_create(x, y, AcidStreak)){
			direction	= other.direction + 180 + random_range(-25, 25);
			speed		= 5 + random(2);
			image_angle	= direction;
		}
	}
	with(mod_script_call("mod", "Frontier_Labs", "GatorCreepBig_create", x, y)){
		image_xscale	= choose(0.4, 0.5);
		image_yscale	= image_xscale;
		lifetime		= 180;
	}
	
//#region CASINO PROPS
#define CasinoSlotMachine_create(_x, _y)
	with(instance_create(_x, _y, CustomHitme)){
		name = "fr_CasinoSlotMachine";
		
		 // Visuals:
		spr_idle		= global.sprSlotMachine;
		spr_hurt		= global.sprSlotMachineHurt;
		spr_dead		= global.sprSlotMachineDead;
		spr_spin		= global.sprSlotMachineSpin;
		spr_lights		= global.sprSlotMachineLights;
		spr_slots		= [global.sprSlot[irandom(3)], global.sprSlot[irandom(3)], global.sprSlot[irandom(3)]];
		spr_shadow		= shd64;
		spr_shadow_y	= 6;
		sprite_index	= spr_idle;
		image_speed		= 0.4;
		depth			= -1;
		
		 // Sounds:
		snd_hurt		= sndHitMetal;
		snd_dead		= sndComputerBreak;
		
		 // Vars:
		mask_index		= mskBandit;
		maxhealth		= 150;
		my_health		= maxhealth;
		team			= 0;
		cost			= 15;
		pick			= -1;
		text			= "SPIN?#" + string(cost) + "@g RADS";

		spinning		= false;
		spinTime		= 0;
		spins			= 0;
		
		spinLuck		= 0;
		slotScores		= [0, 0, 0, 0];
		lastScore		= -1;
		
		 // Events:
		on_step			= CasinoSlotMachine_step;
		on_draw 		= CasinoSlotMachine_draw;
		on_hurt 		= Prop_hurt;

		with(call(scr.prompt_create, text)){ 
			on_step = CasinoSlotMachinePrompt_step; 
			creator = other; 
		}
		
		return self;
	}
	
#define CasinoSlotMachinePrompt_step
	if(!instance_exists(creator) || creator.spinning = true){
		instance_destroy();
		exit; 
	}
	if(pick != -1){ 
		with(creator){
			CasinoSlotMachine_startspin();
		}
	}

#define CasinoSlotMachine_step
	
	// DIE:
	if !instance_exists(self){ exit; }
	if(my_health <= 0){
		with(instance_create(x, y, Corpse)){
			sprite_index = other.spr_dead;
			image_xscale = other.image_xscale;
			size		 = other.size;
		}
		 // Goodbye:
		instance_destroy();
		exit;
	}
	
	x = xstart;
	y = ystart;
	speed = 0;

	 // Animate:
	if(anim_end){
		sprite_index = spr_idle;
	}

	if(spinning = true){
		
		if(spinTime > 0){
			spinTime -= current_time_scale;
			
			 // spinnn sound
			if(spins < 3){
				if(spinTime % 3 == 0){
					sound_play_pitchvol(sndHitMetal, 2.8 + random(0.3), 0.4);
				}
			}
			
		} else {
			if(spins < 3){

				spinTime	= 27;
				spins		+= 1;
				
				var _roll = call(scr.pool, [
		        	[scoreAmmo,    			1 + ((lastScore = scoreAmmo)	* spinLuck)], // Ammo:
		        	[scoreHealth,        	1 + ((lastScore = scoreHealth)	* spinLuck)], // Health:
		        	[scoreRads,				1 + ((lastScore = scoreRads)	* spinLuck)], // Rads:
		    		[scoreWeapon,			1 + ((lastScore = scoreWeapon)	* spinLuck)]  // Weapon:
				])
				
				slotScores[_roll]	+= 1;
				lastScore			= _roll;
				
				 // Update Sprites:
				spr_slots[spins - 1]	= global.sprSlot[_roll]
				spr_lights				= global.sprSlotMachineLightsSpinning[spins];
				
				 // Sound:
				sound_play_pitch(sndMenuCredits, 0.7);
				
			} else {

				spinning	= false
				canspin 	= true;
				
				CasinoSlotMachine_endspin();
	
			}
		}
		
	}
	
#macro scoreAmmo	0
#macro scoreHealth	1
#macro scoreRads	2
#macro scoreWeapon	3
	
#define CasinoSlotMachine_startspin
	
	 // You Can't Do it!
	if(GameCont.rad < cost){
		
		with(instance_create(x, y, PopupText)){
			text = "NOT ENOUGH RADS!"
		}		
		
		CasinoSlotMachine_lose()

	} else {
		
		GameCont.rad -= cost;
		
		spinning	= true;
		spins		= 0;
		spinTime	= 27;
		
		 // yes...
		sound_play(sndServerBreak)
		
		 // Spin Sprites:
		sprite_index	= spr_spin;
		spr_lights		= global.sprSlotMachineLightsSpinning[0];
		spr_slots		= [global.sprSlotSpinning, global.sprSlotSpinning, global.sprSlotSpinning];		
		
		 // Reset Scores:
		slotScores		= [0, 0, 0, 0];
		lastScore		= -1;
		spinLuck		= 0;
			
			// INCREASE LUCK!!
		 // Rabbit Paw:
		spinLuck += (skill_get(mut_rabbit_paw) * 2)
		 // Horsie:
		var _targetplayer = instance_nearest(x, y, Player)
		if(_targetplayer.race = "horsie"){
			spinLuck += 2;
		}
		
	}

#define CasinoSlotMachine_endspin
	var _fail = true;
		
	 // Dispense Rewards:
	if(slotScores[scoreAmmo] >= 2){
		repeat(slotScores[scoreAmmo]){
			with instance_create(x, y + 10, AmmoPickup){
				motion_add(270 + random_range(-20, 20), 3);
			}
		}
		sound_play_pitchvol(sndCanBounce2, 0.6, 3)
		_fail = false;
	}
	if(slotScores[scoreHealth] >= 2){
		repeat(slotScores[scoreHealth] - 1){
			with instance_create(x, y + 10, HPPickup){
				motion_add(270 + random_range(-20, 20), 3);
			}
		}
		sound_play_pitchvol(sndCanBounce2, 0.6, 3)
		_fail = false;
	}
	if(slotScores[scoreRads] >= 2){
		repeat(slotScores[scoreRads] * 15){
			with instance_create(x, y + 10, Rad){
				motion_add(270 + random_range(-20, 20), 3);
			}
		}
		sound_play_pitchvol(sndCanBounce2, 0.6, 3)
		_fail = false;
	}
	if(slotScores[scoreWeapon] >= 2){
		repeat(slotScores[scoreWeapon] - 1){
			with mod_script_call('mod', 'Frontier_Pickups', 'WeaponCapsule_create', x, y + 10){ 
				motion_add(270 + random_range(-20, 20), 3);
			}
		}
		sound_play_pitchvol(sndCanBounce2, 0.6, 3)
		_fail = false;
	}
	
	 // Prompt:
	with(call(scr.prompt_create, text)){ 
		on_step = CasinoSlotMachinePrompt_step; 
		creator = other; 
	}
	
	if(_fail = true){
		CasinoSlotMachine_lose();
	} else {
		CasinoSlotMachine_win();
	}

	
#define CasinoSlotMachine_win
	 // fix this later WHO CARES
	spr_lights = global.sprSlotMachineLightsWinner;	
	sound_play_pitchvol(sndCursedReminder, 1, 2);
	wait(4);
	if !instance_exists(self){ exit; }
	sound_play_pitchvol(sndCursedReminder, 1.3, 2);
	wait(4);
	if !instance_exists(self){ exit; }
	sound_play_pitchvol(sndCursedReminder, 1.6, 2);
	wait(8);
	spr_lights	= global.sprSlotMachineLights;
	if !instance_exists(self){ exit; }
		
#define CasinoSlotMachine_lose
	spr_lights = global.sprSlotMachineLightsLoser;

	 // maybe get rid of waits later but like im tired I wanna play l4d2
	sound_play_pitchvol(sndCursedReminder, 1, 2);
	wait(2);
	if(!instance_exists(self)){ exit; }
	sound_play_pitchvol(sndCursedReminder, 0.8, 2);	
	wait(16);
	if(!instance_exists(self)){ exit; }
	spr_lights	= global.sprSlotMachineLights;
	
	
#define CasinoSlotMachine_draw
	draw_self();

	if (sprite_index != spr_hurt){
		draw_sprite(spr_lights, 	current_frame * 0.4, x + 1, y - 4)
		draw_sprite(spr_slots[0],	current_frame * 1.6, x - 7, y + 3)
		draw_sprite(spr_slots[1],	current_frame + 1 * 1.6, x + 1, y + 3)
		draw_sprite(spr_slots[2],	current_frame + 2 * 1.6, x + 9, y + 3)
	}

#define Counter_create(_x, _y)

	with(instance_create(_x, _y, CustomProp)){
		name = "fr_CasinoCounter";
		
		 // Visual:
		spr_idle	= global.sprCounter;
		spr_hurt	= global.sprCounterHurt;
		spr_dead	= global.sprCounterDead;
		spr_shadow	= global.shdCounter;
		mask_index	= global.mskCounter;
		
		 // Sounds:
		snd_hurt	= sndHitPlant;
		snd_dead	= global.sndWoodBreak;
		
		 // Vars:
		team		= 0;
		maxhealth	= 15;
		my_health	= maxhealth;
		size		= 3;
		allowSpecial= true;
		
		 // Events:
		on_death	= Couch_destroy;
		
		return self;
	}

#define CasinoSoda_create(_x, _y, _table)
	with instance_create(_x, _y, CustomProp){
		name			= "fr_CasinoSoda"
		
		 // Visual:
		spr_idle		= global.sprSodaCans;
		spr_hurt		= mskNone;
		spr_dead		= mskNone;
		sprite_index	= spr_idle;
		image_speed		= 0;
		depth			= _table.depth - 1;
		sodaIndex		= 0;
		
		 // Vars:
		table			= _table;
		maxhealth		= 1;
		my_health		= maxhealth;
		team			= 0;
		wepDrop 		= null;
		
		
		 // Choose Soda:
		var _specialAllowed = _table.allowSpecial;
		var _soder = call(scr.pool, [
	        [[0, true,  "expresso"],							1	* _specialAllowed * mod_exists("mod", "defpack tools")],
	        [[1, true,  "extra double triple coffee"],			1	* _specialAllowed * mod_exists("mod", "defpack tools")],
	        [[2, true,  "frog milk"],							0.9 * _specialAllowed * mod_exists("mod", "defpack tools")],
	        [[3, true,  "guardian juice"],						0.8 * _specialAllowed * mod_exists("mod", "defpack tools")],
	        [[4, true,  "munitions mist"],						1	* _specialAllowed * mod_exists("mod", "defpack tools")],
	        [[5, true,  "saltshake"],							1	* _specialAllowed * mod_exists("mod", "defpack tools")],
	        [[7, true,  "sunset mayo"],							1	* _specialAllowed * mod_exists("mod", "defpack tools") * (skill_get(mut_boiling_veins) > 0)],
	        [[8, true,  "pheromone fizz"],						0.9	* _specialAllowed * mod_exists("mod", "defpack tools") * mod_exists("mod", "ntte")],
	        [[9, false, "chug splash"],							1],
	        [[10, false, "vodka"],								1.2],
	        [[11, false, "glass"],								1.2],
	        [[12, false, "choccy milk"],						0.9],
	        [[13, false, "melonlimeorsomething"],				1],
	        [[14, false, "yellow!!"],							1],
	        [[15, false, "ourple"],								1],
	        [[16, false, "crossroads cola"],					0.8],
	        [[17, false, "venuz special"],						0.9],
		])
		
		 // Text Tu Are:
		image_index		= _soder[0];
		sodaIndex		= _soder[0];
		
		 // If Special:
		if(_soder[1] = true){
			with(_table){
				allowSpecial = false;
			}
			wepDrop = _soder[2];
		}
		
		on_step			= CasinoSoda_step;
		on_death		= CasinoSoda_destoy;
		
		return self;
	}
	
#define CasinoSoda_step
	if(!instance_exists(table)){ 
		CasinoSoda_destoy();
		instance_destroy();
	}
	
#define CasinoSoda_destoy
	GameCont.fr_casinoAlert = true;
	var _index = sodaIndex;
	
	if(wepDrop != null){
		with(instance_create(x, y, WepPickup)){
			wep = other.wepDrop;
		}		
	}
	else{
		 // Just A Can:
		sound_play_pitch(choose(sndCanBounce1, sndCanBounce2), 0.8 + random(0.3));
		with(instance_create(x, y, Shell)){
			motion_add(random(360), 3);
			
			sprite_index	= global.sprSodaCans;
			image_index		= _index;
			image_speed		= 0;
			image_angle		= direction;
		}
	}


#define Couch_create(_x, _y)
	with(instance_create(_x, _y, CustomProp)){
		name = "fr_CasinoCouch";
		
		 // Visual:
		spr_idle	= global.sprCouch;
		spr_hurt	= global.sprCouchHurt;
		spr_dead	= global.sprCouchDead;
		depth		= -3;
		
		 // Sounds:
		snd_hurt	= sndHitPlant;
		snd_dead	= sndWheelPileBreak;
		
		 // Vars:
		maxhealth	= 10;
		my_health	= maxhealth;
		size		= 3;
		team		= 0;
		
		on_death = Couch_destroy;
		
		return self;
	}
	
#define Couch_destroy
	GameCont.fr_casinoAlert = true;

#define BartenderGator_create(_x, _y)
	with(instance_create(_x, _y, CustomHitme)){
		name = "fr_CasinoBartender";
		
		 // Visual:
		spr_idle		= global.sprBartenderGator;
		sprite_index	= spr_idle;
		image_speed		= 0.4;
		depth			= -1;
		
		 // Vars:
		team			= 1;
		maxhealth		= 12;
		my_health		= maxhealth;
		VAGGYBONDESPLSNOSHOOT = true;

		on_step			= Couchgoer_step;
		on_hurt			= BartenderGator_hurt;
		
		return self;
	}
	
#define BartenderGator_hurt(_dmg, _spd, _dir)
	GameCont.fr_casinoAlert = true;
	with(CasinoGator_create(x, y + 8)){
		instance_create(x, y, AssassinNotice)
		if(_dmg > 0){ 
			projectile_hit(self, _dmg) 
		}
	}
	instance_destroy();
	
#define CouchgoerGator_create(_x, _y)
	with(instance_create(_x, _y, CustomHitme)){
		 // Visual:
		spr_idle		= global.sprCouchgoerGator;
		sprite_index	= spr_idle;
		image_speed		= 0.4;
		depth			= -3;
		
		 // Vars:
		team			= 1;
		maxhealth		= 12;
		my_health		= maxhealth;
		VAGGYBONDESPLSNOSHOOT = true;

		on_step			= Couchgoer_step;
		on_hurt			= CouchgoerGator_hurt;
		
		return self;
	}
#define CouchgoerGator_hurt(_dmg, _spd, _dir)
	GameCont.fr_casinoAlert = true;
	with instance_create(x, y, Gator){
		instance_create(x, y, AssassinNotice)
		if (_dmg > 0){ 
			projectile_hit(self, _dmg) 
		}
	}
instance_destroy()

#define CouchgoerCat_create(_x, _y)
	with(instance_create(_x, _y, CustomHitme)){
		 // Visual:
		spr_idle		= global.sprCouchgoerCat;
		sprite_index    = spr_idle;
		image_speed		= 0.4;
		depth			= -3;
		
		 // Vars:
		team			= 1;
		maxhealth		= 10;
		my_health		= maxhealth;
		VAGGYBONDESPLSNOSHOOT = true;

		on_step			= Couchgoer_step;
		on_hurt			= CouchgoerCat_hurt;
		
		return self;
	}
#define CouchgoerCat_hurt(_dmg, _spd, _dir)
	GameCont.fr_casinoAlert = true;

	if mod_exists("mod", "tesewers"){
		with mod_script_call("mod", "telib", "obj_create", x, y, "Cat"){
			instance_create(x, y, AssassinNotice);
			if(_dmg > 0){ 
				projectile_hit(self, _dmg);
			}
		}
	}
	else{
		repeat(6){
			with instance_create(x, y, Smoke){
				direction = random(360);
				speed	  = random(2);
			}
		}
	}
	instance_destroy()

#define CasinoTV_create(_x, _y)
	with(instance_create(_x, _y, CustomHitme)){
	    
		 // Visual:
		spr_idle		= global.sprCasinoTV;
		spr_hurt		= global.sprCasinoTVHurt;
		spr_dead		= global.sprCasinoTVDead;
		spr_screen		= choose(global.sprCasinoTVCraft, global.sprCasinoTVUpturned);
		spr_scene		= spr_screen[irandom(2)];
		scene_index		= 0;
		sprite_index	= spr_idle
		spr_shadow		= shd32;
		spr_shadow_y	= 2;
		
		 // Sounds:
		snd_hurt		= sndHitPlant;
		snd_dead		= sndPlantPotBreak;
		
		 // Vars:
		team			= 0;
		maxhealth		= 5;
		my_health		= maxhealth;
		screen_timer	= 1;
		VAGGYBONDESPLSNOSHOOT = true;
		
		 // Events:
		on_step			= CasinoTV_step;
		on_draw	    	= CasinoTV_draw;
		on_hurt			= Prop_hurt;
		on_destroy  	= CasinoTV_destroy;
		
		return self;
	}
	
#define Couchgoer_step
	if(GameCont.fr_casinoAlert = true){ 
		projectile_hit(self, 0);
	}

#define CasinoTV_step

	x = xstart;
	y = ystart;
	speed = 0;

	 // Animate:
	if(anim_end){
		sprite_index = spr_idle;
	}
	
	 // Change Scene:
	if(screen_timer > 0){ 
		screen_timer -= current_time_scale 
	}
	else{
		screen_timer	= 60 + irandom(40);
		screen_index	= irandom(2);
		spr_scene		= spr_screen[screen_index];
	}
	
	// DIE:
	if(my_health <= 0){
		with(instance_create(x, y, Corpse)){
			sprite_index = other.spr_dead;
			image_xscale = other.image_xscale;
			size		 = other.size;
		}
		 // Goodbye:
		instance_destroy();
	}

#define CasinoTV_draw
	draw_self()
	if(sprite_index != spr_hurt){
		draw_sprite(spr_scene, current_frame * 0.4, x - 1, y + 3)
	}
	
#define CasinoTV_destroy
	GameCont.fr_casinoAlert = true;
	
#define Graffiti_create(_x, _y)
	with(instance_create(_x, _y, CustomObject)){
		name = "fr_graffitiDecal";
		
		sprite_index	= global.sprGraffiti;
		image_index		= irandom(image_number);
		image_speed		= 0;
		depth			= 7;
		
		return self;
	}
	
//#region GENERIC FUNCTIONS
#macro  anim_end                                                                                ((image_index + image_speed_raw) >= image_number || (image_index + image_speed_raw) < 0)
#macro  current_frame_active                                                                    frac(current_frame) < current_time_scale
#macro  target_visible                                                                          !collision_line(x, y, target.x, target.y, Wall, false, false)
#macro  target_direction                                                                        point_direction(x, y, target.x, target.y)
#macro  target_distance                                                                         point_distance(x, y, target.x, target.y)
#macro  enemy_sprite                                                                            (sprite_index != spr_hurt || anim_end) ? ((speed == 0) ? spr_idle : spr_walk) : sprite_index
#macro  alarm0_run                                                                              alarm0 && !--alarm0 && !--alarm0 && (script_ref_call(on_alrm0) || !instance_exists(self))
#macro  alarm1_run                                                                              alarm1 && !--alarm1 && !--alarm1 && (script_ref_call(on_alrm1) || !instance_exists(self))
#macro  alarm2_run                                                                              alarm2 && !--alarm2 && !--alarm2 && (script_ref_call(on_alrm2) || !instance_exists(self))
#macro  alarm3_run                                                                              alarm3 && !--alarm3 && !--alarm3 && (script_ref_call(on_alrm3) || !instance_exists(self))
#macro  alarm4_run                                                                              alarm4 && !--alarm4 && !--alarm4 && (script_ref_call(on_alrm4) || !instance_exists(self))
#macro  alarm5_run                                                                              alarm5 && !--alarm5 && !--alarm5 && (script_ref_call(on_alrm5) || !instance_exists(self))
#macro  alarm6_run                                                                              alarm6 && !--alarm6 && !--alarm6 && (script_ref_call(on_alrm6) || !instance_exists(self))
#macro  alarm7_run                                                                              alarm7 && !--alarm7 && !--alarm7 && (script_ref_call(on_alrm7) || !instance_exists(self))
#macro  alarm8_run                                                                              alarm8 && !--alarm8 && !--alarm8 && (script_ref_call(on_alrm8) || !instance_exists(self))
#macro  alarm9_run                                                                              alarm9 && !--alarm9 && !--alarm9 && (script_ref_call(on_alrm9) || !instance_exists(self))
#define orandom(_num)                                                                   		return  random_range(-_num, _num);
#define chance(_numer, _denom)                                                          		return  random(_denom) < _numer;
#define chance_ct(_numer, _denom)                                                       		return  random(_denom) < _numer * current_time_scale;
#define angle_lerp_ct(_ang1, _ang2, _num)                                               		return  _ang2 + (angle_difference(_ang1, _ang2) * power(1 - _num, current_time_scale));
#define enemy_walk(_dir, _num)                                                                  direction = _dir; walk = _num; if(speed < friction) speed = friction;
#define enemy_face(_dir)                                                                        _dir = ((_dir % 360) + 360) % 360; if(_dir < 90 || _dir > 270) right = 1; else if(_dir > 90 && _dir < 270) right = -1;
#define enemy_look(_dir)                                                                        _dir = ((_dir % 360) + 360) % 360; if(_dir < 90 || _dir > 270) right = 1; else if(_dir > 90 && _dir < 270) right = -1; if('gunangle' in self) gunangle = _dir;
#define enemy_target(_x, _y)                                                            		target = (instance_exists(Player) ? instance_nearest(_x, _y, Player) : ((instance_exists(target) && target >= 0) ? target : noone)); return (target != noone);
#define BasicEnemy_draw                             											draw_sprite_ext(sprite_index, image_index, x, y, image_xscale * right, image_yscale, image_angle, image_blend, image_alpha);
#define GunEnemy_draw                               											if gunangle < 180{ draw_sprite_ext(spr_weap,0,x + lengthdir_x(-wkick,gunangle), y + lengthdir_y(-wkick, gunangle), 1, right, gunangle, image_blend, image_alpha);} draw_sprite_ext(sprite_index,image_index,x,y,image_xscale * right, image_yscale, image_angle, image_blend, image_alpha); if gunangle >= 180{ draw_sprite_ext(spr_weap,0,x + lengthdir_x(-wkick,gunangle), y + lengthdir_y(-wkick, gunangle), 1, right, gunangle, image_blend, image_alpha);}
#define MeleeEnemy_draw																			if(gunangle <= 180) draw_weapon(spr_weap, 0, x, y, gunangle, wepangle, wkick, 1, image_blend, image_alpha); image_xscale *= right; draw_self(); image_xscale /= right; if(gunangle >  180) draw_weapon(spr_weap, 0, x, y, gunangle, wepangle, wkick, 1, image_blend, image_alpha);
#define MortarEnemy_draw																		if(gunangle <= 180) draw_weapon(spr_weap, 0, x, y, lerp(90, 45, dcos(gunangle)), 0, wkick, right, image_blend, image_alpha); image_xscale *= right; draw_self(); image_xscale /= right; if(gunangle >  180) draw_weapon(spr_weap, 0, x, y, lerp(90, 45, dcos(gunangle)), 0, wkick, right, image_blend, image_alpha);
#define nothing
#define every(_num)																				return frac(current_frame/_num) < current_time_scale/_num
#define Enemy_hurt(_dmg, _spd, _dir)
	sprite_index = spr_hurt;
	image_index  = 0;
	
	sound_play_hit(snd_hurt, 0.3);
	motion_add(_dir, _spd);
	
	nexthurt   = current_frame + 6;
	my_health -= _dmg;
	
#define Prop_hurt(_dmg, _spd, _dir)
	my_health -= _dmg;
	nexthurt   = current_frame + 6;
	
	sound_play_hit(snd_hurt, 0.3);
	
	sprite_index = spr_hurt;
	image_index  = 0;
	
#define draw_weapon(_sprite, _image, _x, _y, _angle, _angleMelee, _kick, _flip, _blend, _alpha)
	/*
		Drawing weapon sprites
		
		Ex:
			draw_weapon(sprBanditGun, gunshine, x, y, gunangle, 0, wkick, right, image_blend, image_alpha)
			draw_weapon(sprPipe, 0, x, y, gunangle, wepangle, wkick, wepflip, image_blend, image_alpha)
	*/
	
	 // Melee Offset:
	if(_angleMelee != 0){
		_angle += _angleMelee * (1 - (_kick / 20));
	}
	
	 // Kick:
	if(_kick != 0){
		_x -= lengthdir_x(_kick, _angle);
		_y -= lengthdir_y(_kick, _angle);
	}
	
	 // Draw:
	draw_sprite_ext(_sprite, _image, _x, _y, 1, _flip, _angle, _blend, _alpha);
	
/*
    moved labs/idpd projectiles into this one, hit the token limit on the first
    enemy projectiles are in their respective owner's file
*/

#define init

     // SETITNGS:
	global.settingGreenAugments				= false;
	
        // SPRITES //
     // Generic Sprites:
	global.sprGenericTrail  				= sprite_add("../sprites/particles/sprGenericTrail.png",						50, 0, 50);

	 // Labs Projectiles:
    global.sprCreepShell	    			= sprite_add("../sprites/projectiles/sprCrematorShell.png", 					2, 8, 8);
    global.sprCreepShellDisappear			= sprite_add("../sprites/projectiles/sprCrematorShellDisappear.png",			5, 8, 8);
	global.sprCreep  						= sprite_add("../sprites/projectiles/sprCreep.png",								3, 24, 24);
    global.sprFlameCreepBubble 	    		= sprite_add("../sprites/particles/sprFlameCreepBubble.png",					6, 8, 8);
    global.sprFlameStreak 	    			= sprite_add("../sprites/particles/sprFlameStreak.png", 						7, 8, 8);
	global.sprSwarmRocket  					= sprite_add("../sprites/projectiles/sprSwarmRocket.png",						1, 5, 4);
	global.sprSwarmRocketBig  				= sprite_add("../sprites/projectiles/sprSwarmRocketBig.png",					1, 8, 5);
	global.sprSwarmRocketExplosion  		= sprite_add("../sprites/projectiles/sprSwarmRocketExplosion.png",				7, 12, 12);
	global.sprSwarmRocketTrail  			= sprite_add("../sprites/particles/sprSwarmRocketTrail.png",					3, 4, 4);
	global.sprSwarmRocketFlame 				= sprite_add("../sprites/particles/sprSwarmRocketFlame.png",					3, 26, 6);
	global.sprFriendLabsRocketExplosion  	= sprite_add("../sprites/projectiles/sprFriendLabsRocketExplosion.png",			7, 12, 12);
	global.sprPelletFizzle					= sprite_add("../sprites/particles/sprPelletFizzle.png",						3, 1, 1);
	global.mskEnergyPellet					= sprite_add("../sprites/projectiles/mskEnergyPellet.png",						1, 10, 10);
	global.sprEnergyPellet					= sprite_add("../sprites/projectiles/sprEnergyPellet.png",						4, 10, 10);
	global.sprEnergyPelletDisappear			= sprite_add("../sprites/projectiles/sprEnergyPelletDisappear.png",				5, 24, 24);
	global.sprEnergyPelletTrail				= sprite_add("../sprites/particles/sprEnergyPelletTrail.png",					3, 4, 4);
	global.sprPlagueGas						= sprite_add("../sprites/projectiles/sprPlagueGas.png",							5, 12, 12);
	global.sprPlagueBolt					= sprite_add("../sprites/projectiles/sprPlagueBolt.png", 						2, 8, 8);
    global.sprGluonSlug	    				= sprite_add("../sprites/projectiles/sprGluonSlug.png", 						2, 16, 16);
    global.sprGluonSlugDisappear			= sprite_add("../sprites/projectiles/sprGluonSlugDisappear.png",				6, 16, 16);
    global.sprGluonSlugHit					= sprite_add("../sprites/projectiles/sprGluonSlugHit.png",						4, 24, 24);
    global.sprQuarkShell	    			= sprite_add("../sprites/projectiles/sprQuarkShell.png", 						2, 8, 8);
    global.sprQuarkShellDisappear			= sprite_add("../sprites/projectiles/sprQuarkShellDisappear.png",				5, 8, 8);
    global.sprTeleBulletEnter				= sprite_add("../sprites/particles/sprTeleBulletEnter.png",						5, 8, 8);
    global.sprTeleBulletExit				= sprite_add("../sprites/particles/sprTeleBulletExit.png",						5, 8, 8);
	global.sprTeleBullet					= sprite_add("../sprites/projectiles/sprTeleBullet.png", 						2, 8, 8);
	global.sprTeleBulletHit					= sprite_add("../sprites/projectiles/sprTeleBulletHit.png", 					4, 8, 8);
	global.sprTeleBulletTrail      			= sprite_add("../sprites/particles/sprTeleBulletTrail.png",						12, 20, 8);
	global.sprTeleBouncerBullet				= sprite_add("../sprites/projectiles/sprTeleBouncerBullet.png", 				2, 8, 8);
	global.sprTeleFireBullet				= sprite_add("../sprites/projectiles/sprTeleFireBullet.png", 					2, 8, 8);
	global.sprTeleFireBulletHit				= sprite_add("../sprites/projectiles/sprTeleFireBulletHit.png", 				4, 8, 8);
	global.sprTeleFireBulletFlame			= sprite_add("../sprites/projectiles/sprTeleFireBulletFlame.png", 				7, 8, 8);
	global.sprTeleGammaBullet				= sprite_add("../sprites/projectiles/sprTeleGammaBullet.png", 					2, 8, 8);
	global.sprTeleGammaBulletHit			= sprite_add("../sprites/projectiles/sprTeleGammaBulletHit.png", 				4, 8, 8);
	global.sprTelePestBullet				= sprite_add("../sprites/projectiles/sprTelePestBullet.png", 					2, 8, 8);
	global.sprTelePestBulletHit				= sprite_add("../sprites/projectiles/sprTelePestBulletHit.png", 				4, 8, 8);
	global.sprTelePestBulletGas				= sprite_add("../sprites/projectiles/sprTelePestBulletGas.png", 				5, 12, 12);
	global.sprTelePsyBullet					= sprite_add("../sprites/projectiles/sprTelePsyBullet.png", 					2, 8, 8);
	global.sprTelePsyBulletHit				= sprite_add("../sprites/projectiles/sprTelePsyBulletHit.png", 					4, 8, 8);
	global.sprTeleThunderBullet				= sprite_add("../sprites/projectiles/sprTeleThunderBullet.png", 				2, 8, 8);
	global.sprTeleThunderBulletHit			= sprite_add("../sprites/projectiles/sprTeleThunderBulletHit.png", 				4, 8, 8);

	
     // IDPD Projectiles:
	global.mskPopoRocketSmall				= sprite_add("../sprites/projectiles/mskPopoRocketSmall.png",					1, 6, 4);
	global.sprPopoRocketSmall				= sprite_add("../sprites/projectiles/sprPopoRocketSmall.png",					1, 6, 4);
	global.sprPopoRocketFlameSmall			= sprite_add("../sprites/particles/sprPopoRocketFlameSmall.png",				3, 15, 3);
	global.sprPopoExplosionSmall			= sprite_add("../sprites/projectiles/sprPopoExplosionSmall.png",				7, 12, 12);
	
	global.sprGreenRogueExplosion			= sprite_add("../sprites/projectiles/sprGreenRogueExplosion.png",				8, 24, 24);
	global.sprGreenPopoRocketSmall			= sprite_add("../sprites/projectiles/sprGreenPopoRocketSmall.png",				1, 6, 4);
	global.sprGreenPopoRocketFlameSmall		= sprite_add("../sprites/particles/sprGreenPopoRocketFlameSmall.png", 			3, 15, 3);
	global.sprGreenPopoExplosionSmall		= sprite_add("../sprites/projectiles/sprGreenPopoExplosionSmall.png",			7, 12, 12);


	//#region LABS PROJECTILES
#define CreepShell_create(_x, _y, _charged)
    with instance_create(_x, _y, CustomProjectile){
        
         // Visuals:
        sprite_index    = global.sprCreepShell;
        spr_fade		= global.sprCreepShellDisappear;
        spr_dead		= global.sprCreepShellDisappear;
        fr_bloom		= [2, 0.2];
        fr_glow 		= [32, 48];
        
         // Vars:
        speed           = 16;
        friction		= 0.6;
        typ             = 1;
        damage          = 2;
        force			= 2;
        creator         = other;
        team            = other.team;
        hitid           = [sprite_index, "CREEP SHELL"];
		bonus       	= true;
		bonus_damage	= 1;
		minspeed    	= 6;
		maxspeed    	= 16;
		wallbounce  	= 4 * skill_get(mut_shotgun_shoulders);
        ammo_type		= 2;
        is_shell		= true;
		
		 // Alarms:
		alarm2			= 2;
        
         // Events:
        on_anim			= CreepShell_anim;
        on_step         = CreepShell_step;
        on_hit			= CreepShell_hit;
        on_wall			= CreepShell_wall;
        on_alrm2		= script_ref_create(CreepShell_alrm2);
        
        return self;
    }
    
#define CreepShell_anim
	
	 // Begone:
	if(sprite_index != spr_fade){
		image_speed = 0;
		image_index = image_number - 1;
	}
	
	 // Poof:
	else instance_destroy();
    
#define CreepShell_step

	 // Alarms:
	if(alarm2_run) exit;
	
    if(random(16) < 1){
        with(instance_create(x + random_range(-8, 8), y + random_range(-8, 8), Smoke)){
			motion_add(other.direction + 180 + orandom(10), (other.speed / 2))
        }
    }
    
	 // Disappear:
	if(speed < minspeed && sprite_index != spr_fade){
		CreepShell_spreadcreep();
		sprite_index = spr_fade;
		image_index  = 0;
		image_speed  = 0.4;
	}
	
#define CreepShell_alrm2
	bonus = false;

#define CreepShell_hit
	if(projectile_canhit(other)){
		projectile_hit(other, damage + (bonus_damage * bonus), force);
		
		 // Goodbye:
		with(instance_create(x, y, BulletHit)){
			sprite_index = other.spr_dead;
		}
		CreepShell_spreadcreep();
		instance_destroy();
	}
	
#define CreepShell_wall
	instance_create(x, y, Smoke);
	if(speed > minspeed){
		sound_play_hit(sndShotgunHitWall, 0.2);
	}

	 // Reset Bonus Damage:
	if(wallbounce > 0 && !bonus){
		bonus = true;
		alarm2 = 2;
	}
	
	 // Bounce:
	move_bounce_solid(true);
	image_angle = direction;
	speed = min((speed * 0.8) + wallbounce, maxspeed);
	wallbounce *= 0.95;
	
#define CreepShell_spreadcreep
    sound_play_pitchvol(sndExplosionS, 1.4 + random(0.1), 0.6);
    sound_play_pitchvol(sndFrogEggHurt, 1.3 + random(0.1), 0.4);
    
	with PlayerCreep_create(x, y){
		image_xscale	= choose(0.4, 0.5);
		image_yscale	= image_xscale;
		hitid			= other.hitid;
	}
	
    repeat(2){
        with(instance_create(x, y, BloodStreak)){
        	sprite_index	= global.sprFlameStreak;
            direction   	= random(360);
            image_angle		= direction;
            speed       	= 3 + random(3);
        }
    }
    
#define PlayerCreep_create(_x, _y)
	with(instance_create(_x, _y, CustomProjectile)){
		
         // Visuals:
        sprite_index    = global.sprCreep;
        spr_bubble		= global.sprFlameCreepBubble;
        image_index		= irandom(image_number);
        image_speed		= 0;
        image_angle		= random(360);
        depth			= 4;
        creep_color		= make_color_rgb(252, 56, 0)
        creep_color_2	= make_color_rgb(160, 30, 0)
        image_blend		= creep_color;
        fr_bloom		= [2, 0.1];
    	fr_glow			= [0, 0];
        underwater_fx	= (array_find_index([101, "oasis"], GameCont.area) >= 0) || (is_string(GameCont.area) && (mod_script_call("area", GameCont.area, "area_underwater") = true));
        particle_chance	= 20;
        
         // Vars:
        speed           = 0;
        typ             = 0;
        damage          = 2;
        creator         = other;
        team            = other.team;
        hitid           = [sprite_index, "MOLTEN CREEP"];
        lifetime		= 120;
        allGrownUp		= false;
        maxSize			= 1;
        fr_ignitePowder = true;
        
        on_step         = PlayerCreep_step;
        on_hit			= PlayerCreep_hit;
        on_wall			= nothing;
        
        script_bind_draw(PlayerCreepLow_draw, (depth + 1), self)
        
        return self;
	}
	
#define PlayerCreep_step
	x			= xstart;
	y			= ystart;
	speed		= 0;
	lifetime -= current_time_scale;
	
	 // Update Glow:
    fr_glow	= [32 * image_xscale, 48 * image_xscale]
    
     // Underwater FX:
    if(underwater_fx){
    	if(random(10) < 1){
    		instance_create(x + orandom(16), y + orandom(16), Bubble)
    	}
    }

	 // Grow:
	if(image_xscale < maxSize && allGrownUp = false){
		image_xscale += 0.1;
		image_yscale = image_xscale;
		if(image_xscale >= maxSize){
			allGrownUp = true;
		}
	}
	if(allGrownUp = true && lifetime > 0){
		image_xscale	= maxSize + orandom(0.02);
		image_yscale	= image_xscale;
		if(random(particle_chance) < 1){
			with(instance_create(x + orandom(16 * maxSize), y + orandom(16 * maxSize), PlasmaTrail)){
				sprite_index = other.spr_bubble;
			}
		}
	}
	
	 // ByeBye:
	if(lifetime <= 0){
		image_xscale -= 0.05;
		image_yscale  = image_xscale;
		if(image_xscale <= 0){
			instance_destroy();
		}
	}
	
#define PlayerCreep_hit
	if(projectile_canhit_melee(other)){
		var dmg = damage
		if("boilcap" in other){
			dmg = min(damage, max(0, other.my_health - other.boilcap * skill_get(mut_boiling_veins)))
		}
		projectile_hit(other, dmg)
	}

#define PlayerCreepLow_draw(_creep)
	if(!instance_exists(_creep)){
		instance_destroy();
		exit;
	}
	with(_creep){
		draw_sprite_ext(sprite_index, image_index, x, y + 1, image_xscale, image_yscale, image_angle, creep_color_2, image_alpha)
	}
	
#define HiveRocket_create(_x, _y)
	with(instance_create(_x, _y, CustomProjectile)){
	    
    	 // Visuals:
    	sprite_index	= global.sprSwarmRocketBig;
    	spr_trail		= global.sprSwarmRocketFlame;
    	image_angle		= direction;
	  
    	 // Vars:
   // 	mask_index	= global.mskPopoRocketSmall;
    	speed 		= 2;
    	maxspeed	= 12;
    	friction	= -0.5;
    	typ   		= 1;
    	damage		= 3;
    	ammo_type	= 4;
    	is_rocket	= true;
    	creator		= other;
    	team  		= other.team;
    	hitid 		= [sprite_index, "HIVE ROCKET"];

    	on_step		= HiveRocket_step;
    	on_destroy	= HiveRocket_destroy;
    	on_draw		= HiveRocket_draw;

		return self;
    }


#define HiveRocket_step
	if(speed >= maxspeed){
		friction = 0;
	}
    
#define HiveRocket_destroy
	sound_stop(sndRocketFly)
	with(instance_create(x, y, SmallExplosion)){
		sprite_index	= global.sprSwarmRocketExplosion;
    	team            = other.team;
    	creator         = other.creator;
    	hitid           = other.hitid;
	}
	var _offset = random(360);
	for(var i = 0; i < 360; i += 90){
		with(SwarmRocket_create(x, y)){
			direction		= i + _offset;
	    	team            = other.team;
	    	creator         = other.creator;
	    	hitid           = other.hitid;
		}
	}
	
	sound_play_hit_big_ext(sndExplosion, 0.9 + random(0.3), 0.8);
	sound_play_hit_ext(sndRocket, 0.9 + random(0.3), 0.8);

	
#define HiveRocket_draw
    draw_sprite_ext(spr_trail, current_frame * 0.4, x, y, 1, 1.2, image_angle, c_white, image_alpha);
    draw_set_blend_mode(bm_add);
	draw_sprite_ext(spr_trail, current_frame * 0.4, x, y, 1.8 * image_xscale, 1.8 * image_yscale, image_angle, c_white, 0.2);
    draw_set_blend_mode(bm_normal);
    draw_self();
    
#define SwarmRocket_create(_x, _y)
	with(instance_create(_x, _y, CustomProjectile)){
	    
    	 // Visuals:
    	sprite_index	= global.sprSwarmRocket;
    	spr_trail		= sprRocketFlame;
    	image_angle		= direction;
    	trailColor		= make_color_rgb(234, 255, 66);
	  
    	 // Vars:
   // 	mask_index	= global.mskPopoRocketSmall;
    	speed 		= 3;
    	friction	= -0.1;
    	maxspeed	= 12;
    	typ   		= 1;
    	damage		= 3;
    	ammo_type	= 4;
    	is_rocket	= true;
    	creator		= other;
    	team  		= other.team;
    	hitid 		= [sprite_index, "SWARM ROCKET"];
    	active		= false;
    	activeTimer	= 10;

    	on_step		= SwarmRocket_step;
    	on_end_step	= SwarmRocket_endstep;
    	on_hit		= SwarmRocket_hit;
    	on_wall 	= SwarmRocket_wall;
    	on_destroy	= SwarmRocket_destroy;

		return self;
    }


#define SwarmRocket_step
	if(activeTimer > 0){
		activeTimer -= current_time_scale;
		if(activeTimer <= 0){
			active = true;
			speed		= 8;
			repeat(2){
				with(instance_create(x, y, PlasmaTrail)){
					sprite_index	= global.sprSwarmRocketTrail;
					image_angle		= random(360);
					image_index		= irandom(1);
					speed			= 1 + random(2);
					direction		= other.direction + 180 + random_range(-20, 20);
				}
			}
		}
	}
     // Homing:
    if(active = true){
    	if(current_frame_active){
		    if(instance_exists(enemy)){
		        var myTarget	= instance_nearest(x, y, enemy);
		        direction		-= angle_difference(direction, point_direction(x, y, myTarget.x, myTarget.y)) * power(0.12, 1);
		    }
    	}
    }
	image_angle		= direction;
    
#define SwarmRocket_endstep
	if(active = true){
		with(GenericTrail_create(x, y)){
			depth			= other.depth + 1;
			image_xscale	= point_distance(x, y, other.xprevious, other.yprevious)
			image_yscale   *= 1.5;
			image_speed    *= 8;
			image_angle 	= point_direction(x, y, other.xprevious, other.yprevious)
			image_blend 	= other.trailColor;
		}
	}
    
#define SwarmRocket_wall
	if(active = true){
		instance_destroy();
		exit;
	}
	direction += 180;

#define SwarmRocket_hit
	if(active = true){
		projectile_hit(other, damage);
		instance_destroy();
	}
	
#define SwarmRocket_destroy
	with(instance_create(x, y, SmallExplosion)){
		sprite_index	= global.sprSwarmRocketExplosion;
    	team            = other.team;
    	creator         = other.creator;
    	hitid           = other.hitid;
	}
	
	sound_play_hit_ext(sndExplosion, 0.5 + random_range(0.8, 1.3), 0.8);
	sound_play_hit_ext(sndFlareExplode, 0.7 + random_range(0.8, 1.3), 1.2);
	
#define EnergyPellet_create(_x, _y)
	with(instance_create(_x, _y, CustomProjectile)){
	    
    	 // Visuals:
    	sprite_index	= global.sprEnergyPellet;
    	spr_dead		= global.sprEnergyPelletDisappear;
    	image_speed		= 0.4;
    	spr_trail		= global.sprEnergyPelletTrail;
    	image_angle		= random(360);
		fr_bloom		= [2, 0.1];
		fr_glow			= [32, 48];
	  
    	 // Vars:
    	mask_index	= global.mskEnergyPellet;
    	speed 		= 7;
    	friction	= -0.1;
    	maxspeed	= 12;
    	typ   		= 1;
    	damage		= 22;
    	ammo_type	= 5;
    	creator		= other;
    	team  		= other.team;
    	hitid 		= [sprite_index, "ENERGY PELLET"];
    	lifeTime	= 60 + (30 * skill_get(mut_laser_brain));
    	force		= 6;

    	on_step		= EnergyPellet_step;
    	on_hit		= EnergyPellet_hit;
    	on_wall 	= EnergyPellet_wall;
    	on_destroy	= EnergyPellet_destroy;

		return self;
    }
    
#define EnergyPellet_step
	lifeTime -= current_time_scale;
	if(lifeTime <= 0){
		instance_destroy();
		exit;
	}
	
	image_angle	+= 6;
	if(current_frame_active){
		if(random(4) < 1){
			with(instance_create(x + random_range(-8, 8), y + random_range(-8, 8), PlasmaTrail)){
				sprite_index	= global.sprEnergyPelletTrail;
				speed			= (other.speed / 6);
				direction		= other.direction + 180;
			}
		}
	}

#define EnergyPellet_hit
	if(projectile_canhit_melee(other)){
		 // Hit:
		projectile_hit_push(other, damage, force);
		lasthit = other;

		 // Bounce:
		if(other.my_health > 0){
			direction = point_direction(other.x, other.y, x, y);
		}
		 
		 // Move to next enemy:
		direction = point_direction(other.x, other.y, x, y);
		if(instance_number(enemy) > 1){
			with(other){
			var _enemy = instance_furthest(x, y, enemy);
				with(other){
					if(lasthit != _enemy){
						direction -= angle_difference(direction, point_direction(x, y, _enemy.x, _enemy.y)) / (random(other.size + 0.5) + 1);
					}
				}
			}
		}
		
		 // special dissolve fx:
		with(other){
			var _me = self;
			 // can i melt you:
			if(!instance_is(self, prop) && !instance_is(self, SnowTank) && !instance_is(self, GoldSnowTank) && !instance_is(self, LilHunter) && !instance_is(self, TechnoMancer) && my_health <= 0 && size < 4){
				if("corpse" in self){
					if(corpse = true){
						with(EnergyPelletCorpse_create(x, y, _me.spr_hurt)){
							motion_add(_me.direction, _me.speed / 3);
						}
						
						sound_play_hit_ext(sndPlasmaBig, 1.5 + random(0.4), 0.8);

						 // corpse still exists... for melting and softlock prevention, hopefully doesnt look weird with some enemies.
						spr_dead = mskNone;
					}
				}
			}
		}
	}

#define EnergyPellet_wall
	move_bounce_solid(true);
	direction += random_range(-5, 5);
	if(random(2) < 1){
		if(instance_exists(enemy)){
			var _enemy = instance_nearest(x, y, enemy);
			direction = point_direction(x, y, _enemy.x, _enemy.y)
		}
	}
	
	repeat(3){
		with(instance_create(x, y, PlasmaTrail)){
			sprite_index	= global.sprEnergyPelletTrail;
			direction		= other.direction + random_range(-45, 45);
			speed			= 2 + random(2);
			image_xscale	= 2;
			image_yscale	= image_xscale;
		}
	}

	sound_play_hit_ext(sndDogGuardianBounce, 0.8 + random(0.3), 0.8);
	sound_play_hit_ext(sndBouncerBounce, 0.3 + random(0.3), 0.8);

#define EnergyPellet_destroy
	with(instance_create(x, y, BulletHit)){
		image_angle		= other.image_angle;
		sprite_index	= other.spr_dead;
	}
	
	repeat(10){
		with(instance_create(x, y, PlasmaTrail)){
			sprite_index	= global.sprEnergyPelletTrail;
			direction		= random(360);
			speed			= 2 + random(2);
			image_xscale	= 2;
			image_yscale	= image_xscale;
		}
	}

	repeat(5){
		with(instance_create(x, y, Dust)){
			sprite_index	= sprSmoke;
			direction		= random(360);
			speed			= 4 + random(2);
		}
	}
	
	sound_play_pitchvol(sndDogGuardianHurt, 1.1 + random(0.2), 0.6);
	sound_play_pitchvol(sndLightningCannonEnd, 1.1 + random(0.2), 0.6);

#define EnergyPelletCorpse_create(_x, _y, _spr)
	with(instance_create(_x, _y, CustomObject)){
		name = "fr_energypelletcorpse";
		
		sprite_index	= _spr;
		image_speed		= 0;
		depth			= -15;
		image_xscale	= other.image_xscale * (("right" in other) ? other.right : 1);
		image_blend		= make_color_rgb(255, 207, 163);
		lifeTime		= 30;
		turnSpeed		= random_range(0.5, 1.5) * current_time_scale;
		fr_bloom		= [2, 0.1];
	
		on_step 		= EnergyPelletCorpse_step;
		on_draw 		= EnergyPelletCorpse_draw;
		
		return self;
	}

#define EnergyPelletCorpse_step
	if(current_frame_active){
		y -= 1;
		image_angle += image_xscale * turnSpeed;
		if(current_frame_active){
			if(random(5) < 1){
				with(instance_create(x + random_range(-sprite_width / 2, sprite_width / 2), y + random_range(-sprite_height / 2, sprite_height / 2), Sweat)){
					sprite_index	= global.sprPelletFizzle;
					direction		= 90 + random_range(-20, 20);
					speed			= 1 + random(1);
					depth			= other.depth;
				}
			}
		}
	}
	
	lifeTime -= current_time_scale;
	if(lifeTime <= 0){
		repeat(8){
			with(instance_create(x, y, Sweat)){
				sprite_index	= global.sprPelletFizzle;
				direction		= random(360);
				speed			= 1 + random(2);
				depth			= other.depth;
			}
		}

		instance_destroy();
		exit;
	}
	
#define EnergyPelletCorpse_draw
	draw_sprite_ext(sprite_index, image_index, x, y, image_xscale, image_yscale, image_angle, (lifeTime > 1) ? c_black : make_color_rgb(255, 207, 163), image_alpha * (lifeTime / 30));

#define InflictPlague(_target, _length, _gasLevel)
	 // Plague:
	if(instance_is(_target, Player)){
		mod_script_call('mod', 'Frontier_StatusEffects', 'status_apply_set', _target, mod_variable_get('mod', 'Frontier_StatusEffects', 'debuffPlague'), _length / 3);
		with(_target){
			if("fr_plagueLevel" not in self){
				fr_plagueLevel = -1
			}
		}
	} else {
		mod_script_call('mod', 'Frontier_StatusEffects', 'status_apply_set', _target, mod_variable_get('mod', 'Frontier_StatusEffects', 'debuffPlague'), _length);
		with(_target){
			if("fr_plagueLevel" not in self || fr_plagueLevel = -1){
				fr_plagueLevel = _gasLevel;
			}
		}
	}

#define PlagueBolt_create(_x, _y)
	with(instance_create(_x, _y, CustomProjectile)){
		
         // Visuals:
        sprite_index    = global.sprPlagueBolt;
        hitid           = [sprite_index, "PLAGUE BOLT"];
        trailColor		= make_color_rgb(176, 60, 129);
        depth			= -1;
        
         // Vars:
        mask_index		= mskHeavyBolt;
        speed           = 16;
        force			= 8;
        typ             = 1;
        damage          = 50;
        creator         = other;
        team            = other.team;
        ammo_type		= 3;
        is_bolt 		= true;
		home_inst   	= noone;
		home_dir    	= 0;
		stuckOn			= noone;
		lifeTime		= 90;
		wallOffset		= -24;
		
		 // Events:
		on_anim 		= PlagueBolt_anim;
		on_step			= PlagueBolt_step;
		on_end_step 	= PlagueBolt_endstep;
		on_hit			= PlagueBolt_hit;
		on_wall			= PlagueBolt_wall;
		on_destroy		= PlagueBolt_destroy;		
		
		return self;
	}
	
#define PlagueBolt_anim
	image_index = image_number - 1;
	image_speed = 0;
	
#define PlagueBolt_step
	 // homing taken from ntte:
	if(stuckOn = noone){
		if(home_inst != noone){
			if(instance_exists(home_inst) && projectile_canhit_melee(home_inst)){
				 // Homing:
				if(
					abs(angle_difference(point_direction(x, y, home_inst.x, home_inst.y), home_dir)) < 90
					&&
					!place_meeting(x + lengthdir_x(speed, home_dir), y + lengthdir_y(speed, home_dir), home_inst)
				){
					var	_tx = home_inst.x - lengthdir_x(speed, home_dir),
						_ty = home_inst.y - lengthdir_y(speed, home_dir),
						_diff = angle_difference(point_direction(x, y, _tx, _ty), direction) * 0.5 * current_time_scale;
						
					direction += _diff;
					image_angle += _diff;
				}
				
				 // Done Homing:
				else{
					home_inst = noone;
					direction = home_dir;
					image_angle = direction;
				}
			}
			
			 // Return to Original Direction:
			else if(direction != home_dir){
				var _diff = angle_difference(home_dir, direction);
				if(abs(_diff) > 10) _diff = _diff * 0.5 * current_time_scale;
				direction += _diff;
				image_angle += _diff;
			}
			
			 // Done Homing:
			else home_inst = noone;
		}
		
		else{
			home_dir = direction;
			
			 // Home on Nearest Enemy:
			var _disMax = 24 * skill_get(mut_bolt_marrow);
			if(_disMax > 0){
				var _nearest = noone;
				with(instances_matching_ne(hitme, "team", team, 0)){
					if(!instance_is(self, prop)){
						var _dis = distance_to_point(other.x + other.hspeed, other.y + other.vspeed);
						if(_dis < _disMax){
							if(place_meeting(other.x, other.y, other)){
								_disMax  = _dis;
								_nearest = self;
							}
						}
					}
				}
				home_inst = _nearest;
			}
		}
		if(speed > 0){
			if(current_frame_active){
				if(lifeTime <= 82){
					with(PlagueGas_create(x, y, 2)){
						direction	= other.direction + 180 + 45 + sin(current_frame * 0.2) * 20;
						lifeTime /= 2;
					}
					with(PlagueGas_create(x, y, 2)){
						direction	= other.direction + 180 - 45 + sin(current_frame * 0.2) * 20;
						lifeTime /= 2;
					}
				}
				/*
				if(random(10) < 1){
					with instance_create(x + orandom(16 * image_xscale), y + orandom(16 * image_xscale), FireFly){
						image_blend 	= c_orange;
					}
				}
				if(random(10) < 1){
					with instance_create(x + orandom(16 * image_xscale), y + orandom(16 * image_xscale), Dust){
						sprite_index	= sprBreath;
						direction		= random(360);
						speed			= random(1);
						image_blend 	= make_colour_rgb(74, 60, 78);
					}
				}
				*/
			}
		}
	} else {
		if(!instance_exists(stuckOn)){
			instance_destroy();
			exit;
		} else {
			x = (stuckOn.x + lengthdir_x(wallOffset, direction));
			y = (stuckOn.y + lengthdir_y(wallOffset, direction));
			if(current_frame_active){
				if(random(2) < 1){
					with(PlagueGas_create(stuckOn.x, stuckOn.y, 2)){
						direction	= random(360);
					}
				}
			}
		}
	}
	if(stuckOn = noone){
		lifeTime -= current_time_scale;
		if(lifeTime <= 0){
			instance_destroy();
			exit;
		}	
	}
	
	if(speed <= 0 && stuckOn = noone){
		if(current_frame_active){
			if(lifeTime <= 82){
				if(random(2) < 1){
					with(PlagueGas_create(x + lengthdir_x(-5, direction), y + lengthdir_y(-5, direction), 3)){
						direction	= other.direction + 180 + 45 + sin(current_frame * 0.2) * 20
					}
					with(PlagueGas_create(x + lengthdir_x(-5, direction), y + lengthdir_y(-5, direction), 3)){
						direction	= other.direction + 180 - 45 + sin(current_frame * 0.2) * 20
					}
				}
			}
		}
	}
	
#define PlagueBolt_hit
	if(projectile_canhit(other)){
		
		InflictPlague(other, 600, 3);
		
		 // Stick:
		if(other.my_health > damage){
			stuckOn 	= other;
			speed		= 0;
			mask_index	= mskNone;
		}
		
		 // Damage:
		projectile_hit(other, damage, force);
	}
	
#define PlagueBolt_endstep
	if(stuckOn = noone){
		var	_x1 = x,
			_y1 = y,
			_x2 = xprevious,
			_y2 = yprevious;
		
		with(instance_create(x, y, BoltTrail)){
			image_blend		= other.trailColor;
			image_xscale	= point_distance(_x1, _y1, _x2, _y2);
			image_yscale	= 1.2;
			image_angle 	= point_direction(_x1, _y1, _x2, _y2);
		}
	}
	
#define PlagueBolt_wall
	 // Stick in Wall:
	if(speed > 0){
		speed		= 0;
		mask_index	= mskNone;
		instance_create(x, y, Dust);
		
		move_contact_solid(direction, 8);

		xprevious = x;
		yprevious = y;
		
		 // FX:
		sound_play_hit(sndBoltHitWall, 0.2);
		sound_play_hit(sndToxicBarrelGas, 0.2);
		instance_create(x, y, Dust);
	}

#define PlagueBolt_destroy
	instance_create(x, y, Smoke);
	
#define PlagueGas_create(_x, _y, _level)
	with(instance_create(_x, _y, CustomProjectile)){
		
         // Visuals:
        sprite_index    = global.sprPlagueGas;
        image_index		= irandom(image_number);
        image_speed		= 0;
        image_angle		= random(360);
        image_xscale	= 0.5;
        image_yscale	= 0.5;
        hitid           = [sprite_index, "PLAGUE"];
        depth			= -1;
        rotateSpeed 	= (random_range(2, 5) * choose(-1, 1)) * current_time_scale;
        fr_bloom		= [1.5, 0.1];  
        
         // Vars:
        speed           = 3 + random(2);
        friction		= 0.20;
        force			= 1;
        typ             = 2;
        damage          = 2;
        creator         = other;
        team            = 22;
        ammo_type		= -1;
        is_gas 			= true;
		lifeTime		= 12;
		allGrownUp		= false;
		maxSize 		= 1;
		plagueLevel 	= _level;
		
		 // Events:
		on_step			= PlagueGas_step;
		on_hit			= PlagueGas_hit;
		on_wall			= PlagueGas_wall;
		
		return self;
	}

#define PlagueGas_step
	lifeTime -= current_time_scale;
	image_angle += rotateSpeed;
	
	 // Grow:
	if(image_xscale < maxSize && allGrownUp = false){
		image_xscale += 0.1;
		image_yscale = image_xscale;
		if(image_xscale >= maxSize){
			allGrownUp = true;
		}
	}
	
	if(lifeTime <= 0){
		image_xscale -= 0.05;
		image_yscale  = image_xscale;
		if(image_xscale <= 0){
			instance_destroy();
		}
	}	
	
#define PlagueGas_hit
	InflictPlague(other, 600, plagueLevel);

#define PlagueGas_wall
	move_bounce_solid(true);

#define GluonSlug_create(_x, _y)
    with(instance_create(_x, _y, CustomProjectile)){
        
         // Visuals:
        sprite_index    = global.sprGluonSlug;
        spr_fade		= global.sprGluonSlugDisappear;
        spr_dead		= global.sprGluonSlugHit;
        fr_bloom		= [2, 0.2];
        fr_glow 		= [32, 48];
        
         // Vars:
        mask_index		= mskHeavyBullet;
        speed           = 8 + random(2);
        friction		= 0.01;
        typ             = 1;
        damage          = 65;
        force			= 2;
        creator         = other;
        team            = other.team;
        hitid           = [sprite_index, "GLUON SLUG"];
		bonus       	= true;
		bonus_damage	= 15;
		minspeed    	= 5;
		maxspeed    	= 16;
		wallbounce  	= 2 * skill_get(mut_shotgun_shoulders);
        ammo_type		= 2;
        is_shell		= true;
        is_slug 		= true;
        startX			= _x;
        startY			= _y;
        lifeTime		= 60;
		
		 // Alarms:
		alarm2			= 2;
        
         // Events:
        on_anim			= GluonSlug_anim;
        on_step         = GluonSlug_step;
        on_hit			= GluonSlug_hit;
        on_wall			= GluonSlug_wall;
        on_alrm2		= script_ref_create(GluonSlug_alrm2);
        
		repeat(16){
			with(QuarkShell_create(x, y, self)){
				direction	= random(360);
				speed		= other.speed / 2;
				depth		= other.depth - 1;
				team		= other.team;
			}
		}
        
        return self;
    }
    
#define GluonSlug_anim
	
	 // Begone:
	if(sprite_index != spr_fade){
		image_speed = 0;
		image_index = image_number - 1;
	}
	
	 // Poof:
	else instance_destroy();
    
#define GluonSlug_step

	 // Alarms:
	if(alarm2_run) exit;
    
    if(speed > maxspeed){
    	speed = maxspeed;
    }
	
	lifeTime -= current_time_scale;
	if(lifeTime <= 0){
		with(instance_create(x, y, BulletHit)){
			sprite_index	= other.spr_fade;
			direction		= other.direction;
			image_angle		= other.image_angle;
			speed			= other.speed / 2;
		}
		instance_destroy();
	}
	
#define GluonSlug_alrm2
	bonus = false;

#define GluonSlug_hit
	if(other.my_health > 0){
		var _health = other.my_health;
		if(other.my_health - damage < 0){
			projectile_hit(other, damage + (bonus_damage * bonus), force);
			damage -= _health / 2;
			
			repeat(3){
				with(QuarkShell_create(x, y, self)){
					direction	= random(360);
					speed		= other.speed / 2;
					depth		= other.depth - 1;
					team		= other.team;
				}
			}
		
		} else {
			projectile_hit(other, damage + (bonus_damage * bonus), force);
			
			 // Goodbye:
			with(instance_create(x, y, BulletHit)){
				sprite_index = other.spr_dead;
			}
			instance_destroy();	
		}
	}

#define GluonSlug_wall
	instance_create(x, y, Smoke);
	if(speed > minspeed){
		sound_play_hit(sndShotgunHitWall, 0.2);
	}

	 // Reset Bonus Damage:
	if(wallbounce > 0 && !bonus){
		bonus = true;
		alarm2 = 2;
	}
	
	with(instance_create(x, y, PortalClear)){
		image_xscale	= 0.5;
		image_yscale	= image_xscale;
	}
	
	 // Bounce:
	move_bounce_solid(true);
	direction += random_range(-20, 20);
	image_angle = direction;
	speed = min((speed * 0.9) + wallbounce, maxspeed);
	wallbounce *= 0.95;
	
#define QuarkShell_create(_x, _y, _owner)
    with(instance_create(_x, _y, CustomProjectile)){
        
         // Visuals:
        sprite_index    = global.sprQuarkShell;
        spr_fade		= global.sprQuarkShellDisappear;
        spr_dead		= global.sprQuarkShellDisappear;
        fr_bloom		= [2, 0.1];
        fr_glow 		= [16, 24];
        trailColor		= c_yellow;
        
         // Vars:
        mask_index		= mskBullet2;
        speed			= 5 + random(7);
        friction		= 0.2;
        typ             = 1;
        damage          = 6;
        force			= 2;
        creator         = other;
        team            = other.team;
        hitid           = [sprite_index, "QUARK SHELL"];
		bonus       	= true;
		bonus_damage	= 1;
		minspeed    	= 5;
		maxspeed    	= 16;
		wallbounce  	= 4 * skill_get(mut_shotgun_shoulders);
        ammo_type		= 2;
        is_shell		= true;
        weDidIt 		= false;
        lifeTime		= 240;
        homingPower		= 0.50 + random(0.30);
        owner			= _owner;
        imOnIt			= true;
		
		 // Alarms:
		alarm2			= 2;
        
         // Events:
        on_anim			= GluonSlug_anim;
        on_step         = QuarkShell_step;
        on_hit			= QuarkShell_hit;
        on_wall			= QuarkShell_wall;
        
        return self;
    }
    
#define QuarkShell_step
	if(imOnIt = true){
		if(instance_exists(owner)){
			if(current_frame_active){
				motion_add(point_direction(x, y, owner.x, owner.y), homingPower + (owner.speed / 16));
			}
		} else {
			QuarkShell_detach();
		}
	}
	
	image_angle	= direction;
 
	 // Disappear:
	if((speed < minspeed && sprite_index != spr_fade) && imOnIt = false){
		sprite_index = spr_fade;
		image_index  = 0;
		image_speed  = 0.4;
	}

#define QuarkShell_wall
	if(imOnIt = false){
		if(speed > minspeed){
			sound_play_hit(sndShotgunHitWall, 0.2);
		}
	
		 // Reset Bonus Damage:
		if(wallbounce > 0 && !bonus){
			bonus = true;
			alarm2 = 2;
		}
	}
	
	 // Bounce:
	move_bounce_solid(true);
	image_angle = direction;
	speed = min((speed * 0.8) + wallbounce, maxspeed);
	wallbounce *= 0.95;
#define QuarkShell_hit
	if(projectile_canhit(other)){
		projectile_hit(other, damage + (bonus_damage * bonus), force);
		
		 // Goodbye:
		with(instance_create(x, y, BulletHit)){
			sprite_index = other.spr_dead;
		}
		
		instance_destroy();
	}
	
#define QuarkShell_detach
	imOnIt		= false;
	if(instance_exists(enemy)){
		var _enemy	= instance_nearest(x, y, enemy);
		direction	= point_direction(x, y, _enemy.x, _enemy.y) + random_range(-60, 60);
	}
	if(random(3) < 1){
		direction	= random(360);
	}
	speed		= maxspeed - random(4);	

#define TeleBullet_create(_x, _y)
	with(instance_create(_x, _y, CustomProjectile)){
		
         // Visuals:
        sprite_index    = global.sprTeleBullet;
        spr_dead		= global.sprTeleBulletHit;
        spr_enter		= global.sprTeleBulletEnter;
        spr_exit		= global.sprTeleBulletExit;
        spr_trail		= global.sprTeleBulletTrail;
        fr_bloom		= [2, 0.2]
        fr_glow 		= [32, 48];
        fx_color		= make_color_rgb(107, 214, 185);
        
         // Vars:
        mask_index		= mskBullet1;
        speed           = 12;
        force			= 8;
        typ             = 1;
        gland			= 1;
        damage          = 4;
        creator         = other;
        team            = other.team;
        hitid           = [sprite_index, "TEMPORAL BULLET"];
        ammo_type		= 1;
        is_bullet		= true;
        teleporms		= 2;
		
		 // Events:
		on_anim 		= TeleBullet_anim;
		on_step 		= TeleBullet_step;
		on_hit			= TeleBullet_hit;
		on_wall			= TeleBullet_wall;
		on_destroy		= TeleBullet_destroy;		
		
		return self;
	}

#define TeleBullet_anim
	image_index = image_number - 1;
	image_speed = 0;
	
#define TeleBullet_step
	if(current_frame_active){
		if(random(10) < 1){
			with(instance_create(x, y, BulletHit)){
				sprite_index	= other.spr_trail;
				image_blend		= other.fx_color;
				image_xscale	= 0.7 + random(0.3);
				image_yscale	= image_xscale;
				image_speed		= 0.7;
			}
		}
	}

#define TeleBullet_hit
	if(projectile_canhit(other)){
		
		with(instance_create(x, y, BulletHit)){
			sprite_index = other.spr_dead;
		}
		
		 // Recycle Gland:
		if(gland != 0 && instance_is(creator, Player)){
			if(chance(3 * skill_get(mut_recycle_gland), 5)){
				var	_ammo = creator.ammo[1],
					_amax = creator.typ_amax[1];
					
				if(_ammo < _amax){
					creator.ammo[1] = min(_ammo + gland, _amax);
					instance_create(x, y, RecycleGland);
				//	sound_play_hit(sndRecGlandProc, 0.1);
				}
			}
		}
		
		 // Damage:
		projectile_hit(other, damage, force);
		if(teleporms < 1){
			instance_destroy();
			exit;
		} else {
			TeleBullet_teleporm();			
		}
	}
	
	
#define TeleBullet_wall
    if(teleporms > 0){
	
		 // Enter Wall VFX:
		with(instance_create(x + hspeed_raw, y + vspeed_raw, BulletHit)){
			sprite_index	= other.spr_enter;
			image_blend		= other.fx_color;
			image_angle 	= other.image_angle;
		}
	
		TeleBullet_teleporm();
    }
    else{
        sound_play_pitch(sndHitWall, random_range(0.9, 1.1));
        instance_destroy();
    }

#define TeleBullet_teleporm

	teleporms	-= 1;
	direction	+= random_range(-10, 10);
	image_angle	= direction;

	 // Teleporm:
	move_outside_solid(direction + 180, speed);
    move_contact_solid(direction + 180, 800);
    
     // Exit Wall VFX:
	with(instance_create(x, y, BulletHit)){
		sprite_index	= other.spr_exit;
		image_blend		= other.fx_color;
		image_angle 	= other.image_angle + 180;
	}
	
#define TeleBullet_destroy
	with(instance_create(x, y, BulletHit)){
		sprite_index = other.spr_dead;
	}
	
#define TeleBouncerBullet_create(_x, _y)
	with(instance_create(_x, _y, CustomProjectile)){
		
         // Visuals:
        sprite_index    = global.sprTeleBouncerBullet;
        spr_dead		= global.sprTeleBulletHit;
        spr_enter		= global.sprTeleBulletEnter;
        spr_exit		= global.sprTeleBulletExit;
        spr_trail		= global.sprTeleBulletTrail;
        fr_bloom		= [2, 0.2]
        fr_glow 		= [32, 48];
        fx_color		= make_color_rgb(107, 214, 185);
        turnspeed		= 9 * choose(-1, 1);
        
         // Vars:
        mask_index		= mskBouncerBullet;
        speed           = 5;
        force			= 8;
        typ             = 1;
        gland			= 1;
        damage          = 5;
        creator         = other;
        team            = other.team;
        hitid           = [sprite_index, "TEMPORAL BOUNCER BULLET"];
        ammo_type		= 1;
        is_bullet		= true;
        teleporms		= 2;
		
		 // Events:
		on_anim 		= TeleBullet_anim;
		on_step 		= TeleBouncerBullet_step;
		on_hit			= TeleBouncerBullet_hit;
		on_wall			= TeleBullet_wall;
		on_destroy		= TeleBullet_destroy;		
		
		return self;
	}
	
#define TeleBouncerBullet_step
	if(current_frame_active){
		image_angle += turnspeed;
		if(random(15) < 1){
			with(instance_create(x, y, BulletHit)){
				sprite_index	= other.spr_trail;
				image_blend		= other.fx_color;
				image_xscale	= 0.7 + random(0.3);
				image_yscale	= image_xscale;
				image_speed		= 0.7;
			}
		}
	}

#define TeleBouncerBullet_hit
	if(projectile_canhit(other)){
		
		with(instance_create(x, y, BulletHit)){
			sprite_index = other.spr_dead;
		}
		
		 // Recycle Gland:
		if(gland != 0 && instance_is(creator, Player)){
			if(chance(3 * skill_get(mut_recycle_gland), 5)){
				var	_ammo = creator.ammo[1],
					_amax = creator.typ_amax[1];
					
				if(_ammo < _amax){
					creator.ammo[1] = min(_ammo + gland, _amax);
					instance_create(x, y, RecycleGland);
				//	sound_play_hit(sndRecGlandProc, 0.1);
				}
			}
		}
		
		 // Damage:
		projectile_hit(other, damage, force);
		if(teleporms < 1){
			instance_destroy();
			exit;
		} else {
			direction += 180;
			TeleBullet_teleporm();	
		}
	}

//#define TeleBouncerBullet_wall
/*
	if(bouncy = true){
		move_bounce_solid(true);
		sound_play_pitchvol(sndBouncerBounce, 1.2 + random(0.2), 0.8);
		instance_create(x, y, Dust);
		bouncy = false;
	} else {
	    if(teleporms > 0){
		
			 // Enter Wall VFX:
			with(instance_create(x + hspeed_raw, y + vspeed_raw, BulletHit)){
				sprite_index	= other.spr_enter;
				image_blend		= other.fx_color;
				image_angle 	= other.image_angle;
			}
		
			TeleBullet_teleporm();
	    }
	    else{
	        sound_play_pitch(sndHitWall, random_range(0.9, 1.1));
	        instance_destroy();
	    }		
	}
*/

#define TeleFireBullet_create(_x, _y)
	with(instance_create(_x, _y, CustomProjectile)){
		
         // Visuals:
        sprite_index    = global.sprTeleFireBullet;
        spr_dead		= global.sprTeleFireBulletHit;
        spr_enter		= global.sprTeleBulletEnter;
        spr_exit		= global.sprTeleBulletExit;
        spr_trail		= global.sprTeleBulletTrail;
        fr_bloom		= [2, 0.2]
        fr_glow 		= [32, 48];
        fx_color		= make_color_rgb(107, 144, 214);
        
         // Vars:
        mask_index		= mskBullet1;
        speed           = 12;
        force			= 8;
        typ             = 1;
        gland			= 1;
        damage          = 4;
        creator         = other;
        team            = other.team;
        hitid           = [sprite_index, "TEMPORAL FIRE BULLET"];
        ammo_type		= 1;
        is_bullet		= true;
        teleporms		= 2;
		
		 // Events:
		on_anim 		= TeleBullet_anim;
		on_step 		= TeleBullet_step;
		on_hit			= TeleFireBullet_hit;
		on_wall			= TeleBullet_wall;
		on_destroy		= TeleFireBullet_destroy;		
		
		return self;
	}
	
#define TeleFireBullet_hit
	if(projectile_canhit(other)){
		
		with(instance_create(x, y, BulletHit)){
			sprite_index = other.spr_dead;
		}
		
		 // Recycle Gland:
		if(gland != 0 && instance_is(creator, Player)){
			if(chance(3 * skill_get(mut_recycle_gland), 5)){
				var	_ammo = creator.ammo[1],
					_amax = creator.typ_amax[1];
					
				if(_ammo < _amax){
					creator.ammo[1] = min(_ammo + gland, _amax);
					instance_create(x, y, RecycleGland);
				//	sound_play_hit(sndRecGlandProc, 0.1);
				}
			}
		}
		
		 // Damage:
		projectile_hit(other, damage, force);
		with(instance_create(x, y, Flame)){
			team = other.team;
			sprite_index	= global.sprTeleFireBulletFlame;
			motion_add(other.direction, random_range(4, 6))
			friction		= 2;
		    damage			= 1;
		}
		if(teleporms < 1){
			instance_destroy();
			exit;
		} else {
			TeleBullet_teleporm();	
		}
	}

#define TeleFireBullet_destroy
	with(instance_create(x, y, BulletHit)){
		sprite_index	= other.spr_dead;
		image_index		= 1;
	}
	with(instance_create(x, y, Flame)){
		team = other.team;
		sprite_index	= global.sprTeleFireBulletFlame;
		motion_add(other.direction, random_range(4, 6))
		friction		= 2;
	    damage			= 1;
	}
	
#define TeleGammaBullet_create(_x, _y)
	with(instance_create(_x, _y, CustomProjectile)){
		
         // Visuals:
        sprite_index    = global.sprTeleGammaBullet;
        spr_dead		= global.sprTeleGammaBulletHit;
        spr_enter		= global.sprTeleBulletEnter;
        spr_exit		= global.sprTeleBulletExit;
        spr_trail		= global.sprTeleBulletTrail;
        fr_bloom		= [2, 0.15]
        fr_glow 		= [32, 48];
        fx_color		= make_color_rgb(149, 255, 98);
        
         // Vars:
        mask_index		= mskBullet1;
        speed           = 12;
        force			= 8;
        typ             = 1;
        gland			= 1;
        damage          = 3;
        creator         = other;
        team            = other.team;
        hitid           = [sprite_index, "TEMPORAL GAMMA BULLET"];
        ammo_type		= 1;
        is_bullet		= true;
        teleporms		= 2;
        pierce  		= 1;
        lasthit 		= noone;
		
		 // Events:
		on_anim 		= TeleBullet_anim;
		on_step 		= TeleBullet_step;
		on_hit			= TeleGammaBullet_hit;
		on_wall			= TeleGammaBullet_wall;
		on_destroy		= TeleBullet_destroy;		
		
		return self;
	}

#define TeleGammaBullet_hit
	if(projectile_canhit(other)){
		if(lasthit != other){
			lasthit = other;
		
			with(instance_create(x, y, BulletHit)){
				sprite_index = other.spr_dead;
			}
			
			 // Recycle Gland:
			if(gland != 0 && instance_is(creator, Player)){
				if(chance(3 * skill_get(mut_recycle_gland), 5)){
					var	_ammo = creator.ammo[1],
						_amax = creator.typ_amax[1];
						
					if(_ammo < _amax){
						creator.ammo[1] = min(_ammo + gland, _amax);
						instance_create(x, y, RecycleGland);
					//	sound_play_hit(sndRecGlandProc, 0.1);
					}
				}
			}
			
			 // Damage:
			projectile_hit(other, damage, force);
			if(teleporms < 1){
				if((--pierce < 0)){
					instance_destroy();
				}
				exit;
			} else {
				if((--pierce < 0)){
					TeleBullet_teleporm();	
					lasthit = noone;
					pierce	= 1;
				}
			}
		}
	}
	
#define TeleGammaBullet_wall
    if(teleporms > 0){
    	lasthit = noone;
    	pierce	= 1;
	
		 // Enter Wall VFX:
		with(instance_create(x + hspeed_raw, y + vspeed_raw, BulletHit)){
			sprite_index	= other.spr_enter;
			image_blend		= other.fx_color;
			image_angle 	= other.image_angle;
		}
	
		TeleBullet_teleporm();
    }
    else{
        sound_play_pitch(sndHitWall, random_range(0.9, 1.1));
        instance_destroy();
    }
    
#define TelePestBullet_create(_x, _y)
	with(instance_create(_x, _y, CustomProjectile)){
		
         // Visuals:
        sprite_index    = global.sprTelePestBullet;
        spr_dead		= global.sprTelePestBulletHit;
        spr_enter		= global.sprTeleBulletEnter;
        spr_exit		= global.sprTeleBulletExit;
        spr_trail		= global.sprTeleBulletTrail;
        fr_bloom		= [2, 0.2]
        fr_glow 		= [32, 48];
        fx_color		= make_color_rgb(133, 255, 11);
        
         // Vars:
        mask_index		= mskBullet1;
        speed           = 12;
        force			= 8;
        typ             = 1;
        gland			= 1;
        damage          = 4;
        creator         = other;
        team            = other.team;
        hitid           = [sprite_index, "TEMPORAL PEST BULLET"];
        ammo_type		= 1;
        is_bullet		= true;
        teleporms		= 2;
		
		 // Events:
		on_anim 		= TeleBullet_anim;
		on_step 		= TeleBullet_step;
		on_hit			= TelePestBullet_hit;
		on_wall			= TeleBullet_wall;
		on_destroy		= TelePestBullet_destroy;		
		
		return self;
	}
	
#define TelePestBullet_hit
	if(projectile_canhit(other)){
		
		with(instance_create(x, y, BulletHit)){
			sprite_index = other.spr_dead;
		}
		
		 // Recycle Gland:
		if(gland != 0 && instance_is(creator, Player)){
			if(chance(3 * skill_get(mut_recycle_gland), 5)){
				var	_ammo = creator.ammo[1],
					_amax = creator.typ_amax[1];
					
				if(_ammo < _amax){
					creator.ammo[1] = min(_ammo + gland, _amax);
					instance_create(x, y, RecycleGland);
				//	sound_play_hit(sndRecGlandProc, 0.1);
				}
			}
		}
		
		 // Damage:
		projectile_hit(other, damage, force);
		repeat(choose(1, 1, 2)){
			with(instance_create(x, y, ToxicGas)){
				sprite_index	= global.sprTelePestBulletGas;
				friction		*= 10;
				growspeed		/= 8;
				move_contact_solid(other.direction, other.speed);
			}
		}
		if(teleporms < 1){
			instance_destroy();
			exit;
		} else {
			TeleBullet_teleporm();	
		}
	}

#define TelePestBullet_destroy
	with(instance_create(x, y, BulletHit)){
		sprite_index	= other.spr_dead;
		image_index		= 1;
	}
	repeat(choose(1, 1, 2)){
		with(instance_create(x, y, ToxicGas)){
			sprite_index	= global.sprTelePestBulletGas;
			friction		*= 10;
			growspeed		/= 8;
			move_contact_solid(other.direction, other.speed);
		}
	}
	
#define TelePsyBullet_create(_x, _y)
	with(instance_create(_x, _y, CustomProjectile)){
		
         // Visuals:
        sprite_index    = global.sprTelePsyBullet;
        spr_dead		= global.sprTelePsyBulletHit;
        spr_enter		= global.sprTeleBulletEnter;
        spr_exit		= global.sprTeleBulletExit;
        spr_trail		= global.sprTeleBulletTrail;
        fr_bloom		= [2, 0.2]
        fr_glow 		= [32, 48];
        fx_color		= make_color_rgb(185, 107, 214);
        
         // Vars:
        mask_index		= mskBullet1;
        speed           = 7;
        force			= 8;
        typ             = 1;
        gland			= 1;
        damage          = 4;
        creator         = other;
        team            = other.team;
        hitid           = [sprite_index, "TEMPORAL PSY BULLET"];
        ammo_type		= 1;
        is_bullet		= true;
        teleporms		= 2;
        timer			= 6 + irandom(4);
        turnspeed		= 0.3;
        range			= 70;
		
		 // Events:
		on_anim 		= TeleBullet_anim;
		on_step 		= TelePsyBullet_step;
		on_hit			= TeleBullet_hit;
		on_wall			= TeleBullet_wall;
		on_destroy		= TeleBullet_destroy;		
		
		return self;
	}
	
#define TelePsyBullet_step
	if(current_frame_active){
		timer -= 1;
		 // taken directly from psybullet
		if(timer <= 0){
			var closeboy = instance_nearest_matching_ne(x,y,hitme,"team",team)
			if instance_exists(closeboy) && distance_to_object(closeboy) < range && collision_line(x,y,closeboy.x,closeboy.y,Wall,0,0) < 0{
				var dir, spd, dif;
		
				dir = point_direction(x, y, closeboy.x, closeboy.y);
				spd = speed * 5 * current_time_scale
		        dif = clamp(angle_approach(direction, dir, 1/turnspeed, current_time_scale), -spd, spd)
		
				direction -= dif; //Smoothly rotate to aim position.
				image_angle -= dif
			}
		}

		if(random(10) < 1){
			with(instance_create(x, y, BulletHit)){
				sprite_index	= other.spr_trail;
				image_blend		= other.fx_color;
				image_xscale	= 0.7 + random(0.3);
				image_yscale	= image_xscale;
				image_speed		= 0.7;
			}
		}
	}


#define angle_approach(a, b, n, dn)
return angle_difference(a, b) * (1 - power((n - 1)/n, dn))

#define instance_nearest_matching_ne(_x,_y,obj,varname,value)
var num = instance_number(obj),
    man = instance_nearest(_x,_y,obj),
    mans = [],
    n = 0,
    found = -4;
if instance_exists(obj){
    while ++n <= num && variable_instance_get(man,varname) = value || (instance_is(man,prop) && !instance_is(man,Generator)){
        man.x += 10000
        array_push(mans,man)
        man = instance_nearest(_x,_y,obj)
    }
    if variable_instance_get(man,varname) != value && (!instance_is(man,prop) || instance_is(man,Generator)) found = man
    with mans x-= 10000
}
return found

#define TeleThunderBullet_create(_x, _y)
	with(instance_create(_x, _y, CustomProjectile)){
		
         // Visuals:
        sprite_index    = global.sprTeleThunderBullet;
        spr_dead		= global.sprTeleThunderBulletHit;
        spr_enter		= global.sprTeleBulletEnter;
        spr_exit		= global.sprTeleBulletExit;
        spr_trail		= global.sprTeleBulletTrail;
        fr_bloom		= [2, 0.2]
        fr_glow 		= [32, 48];
        fx_color		= make_color_rgb(168, 242, 251);
        
         // Vars:
        mask_index		= mskBullet1;
        speed           = 12;
        force			= 8;
        typ             = 1;
        gland			= 1;
        damage          = 4;
        creator         = other;
        team            = other.team;
        hitid           = [sprite_index, "TEMPORAL THUNDER BULLET"];
        ammo_type		= 1;
        is_bullet		= true;
        teleporms		= 2;
        charge			= choose(1, 1, 2);
		
		 // Events:
		on_anim 		= TeleBullet_anim;
		on_step 		= TeleBullet_step;
		on_hit			= TeleThunderBullet_hit;
		on_wall			= TeleBullet_wall;
		on_destroy		= TeleThunderBullet_destroy;		
		
		return self;
	}

#define TeleThunderBullet_hit
	if(projectile_canhit(other)){
		
		with(instance_create(x, y, BulletHit)){
			sprite_index = other.spr_dead;
		}
		
		 // Recycle Gland:
		if(gland != 0 && instance_is(creator, Player)){
			if(chance(3 * skill_get(mut_recycle_gland), 5)){
				var	_ammo = creator.ammo[1],
					_amax = creator.typ_amax[1];
					
				if(_ammo < _amax){
					creator.ammo[1] = min(_ammo + gland, _amax);
					instance_create(x, y, RecycleGland);
				//	sound_play_hit(sndRecGlandProc, 0.1);
				}
			}
		}
		
		 // Damage:
		projectile_hit(other, damage, force);
		
		 // taken from thunder bullets:
		if "thunder_charge" not in other {
			other.thunder_charge = 0
		}
		other.thunder_charge += charge
		var _team = team, _c = creator;
		var laserbrain = ceil(skill_get(mut_laser_brain));
		if other.my_health <= 0 {
			var _charge = max(other.thunder_charge, 5);
			while(_charge) > 0 {
				var r = min(irandom(_charge) + 1 + laserbrain, 12 + laserbrain);
				with instance_create(other.x, other.y, Lightning) {
					image_angle = random(360)
					direction = image_angle
					ammo = r + 1
					creator = _c
					team = _team
					alarm0 = irandom(1) + 1
				}
				_charge -= max(r - laserbrain, 1)
			}
			view_shake_at(other.x, other.y, other.thunder_charge/5)
			sound_play_pitchvol(sndLightningCannonEnd, 1 + max(1 - other.thunder_charge/30, -.8), .4)
			if laserbrain {
				sound_play_pitchvol(sndLightningPistolUpg, .8, .4)
			}
		}
	
	
		if(teleporms < 1){
			instance_destroy();
			exit;
		} else {
			TeleBullet_teleporm();			
		}
	}
	
#define TeleThunderBullet_destroy
	with(instance_create(x, y, BulletHit)){
		sprite_index	= other.spr_dead;
	}
	instance_create(x + random_range(-5, 5), y + random_range(-5, 5), LightningHit)

	//#endregion
    //#region IDPD PROJECTILES
#define PopoRocketSmall_create(_x, _y)
	with instance_create(_x, _y, CustomProjectile){
	    
    	 // Visuals:
    	sprite_index	= (global.settingGreenAugments ? global.sprGreenPopoRocketSmall 		: global.sprPopoRocketSmall);
    	spr_trail		= (global.settingGreenAugments ? global.sprGreenPopoRocketFlameSmall	: global.sprPopoRocketFlameSmall);
    	image_angle		= direction;
	  
    	 // Vars:
    	mask_index	= global.mskPopoRocketSmall;
    	speed 		= 10;
    	typ   		= 1;
    	damage		= 5;
    	creator		= other;
    	team  		= other.team;
    	hitid 		= [sprite_index, "IDPD MICROMISSILE"];

    	on_step		= PopoRocketSmall_step;
    	on_destroy	= PopoRocketSmall_destroy;
    	on_draw		= PopoRocketSmall_draw;

		return self;
    }
    
#define PopoRocketSmall_destroy
	with(instance_create(x, y, SmallExplosion)){
	    sprite_index    = (global.settingGreenAugments ? global.sprGreenPopoExplosionSmall : global.sprPopoExplosionSmall);
	    mask_index      = mskSmallExplosion;
    	team            = other.team;
    	creator         = other.creator;
    	hitid           = other.hitid;
	}

	sound_play_hit_ext(sndExplosionS, 0.5 + random_range(0.8, 1.3), 0.8);
	sound_play_hit_ext(sndIDPDNadeExplo, 0.7 + random_range(0.8, 1.3), 1.2);

#define PopoRocketSmall_step
     // Homing:
    if(current_frame_active){
	    if(instance_exists(enemy)){
	        var myTarget	= instance_nearest(x, y, enemy);
	        direction		-= angle_difference(direction, point_direction(x, y, myTarget.x, myTarget.y)) * power(0.1 * 2, 1);
	        image_angle		= direction;
	    }
	     // Particles:
	    if(random(4) < 1){
		    with instance_create(x + random_range(-4, 4), y + random_range(-4, 4), Smoke){ 
			    direction		= other.direction; 
			    speed			= 2; 
			    image_xscale	= 0.5; 
			    image_yscale	= image_xscale; 
		    }
	    }
    
    }

//#endregion
//#region GENERIC FUNCTIONS
#define PopoRocketSmall_draw
    draw_sprite_ext(spr_trail, current_frame * 0.4, x, y, 1, 1.2, image_angle, c_white, image_alpha);
    draw_set_blend_mode(bm_add);
	draw_sprite_ext(spr_trail, current_frame * 0.4, x, y, 1.8 * image_xscale, 1.8 * image_yscale, image_angle, c_white, 0.2);
    draw_set_blend_mode(bm_normal);
    draw_self();

#define GenericTrail_create(_x, _y) 
    with instance_create(_x, _y, Wind){
        sprite_index     = global.sprGenericTrail;
        mask_index       = mskNone;
        image_speed      = 2;
        image_yscale     = (1/50);
        image_xscale     = 1;
        depth			 = 0;
        
        return self;
    }
    
#define sound_play_hit_ext(_sound, _pitch, _volume)
	var _sound = sound_play_hit(_sound, 1);
	audio_sound_pitch(_sound, _pitch);
	audio_sound_gain(_sound, _volume, 0);
	
#define sound_play_hit_big_ext(_sound, _pitch, _volume)
	var _sound = sound_play_hit_big(_sound, 1);
	audio_sound_pitch(_sound, _pitch);
	audio_sound_gain(_sound, _volume, 0);
    
#macro current_frame_active 																	frac(current_frame) < current_time_scale
#macro  anim_end																				((image_index + image_speed_raw) >= image_number || (image_index + image_speed_raw) < 0)
#macro  alarm0_run                                                                              alarm0 && !--alarm0 && !--alarm0 && (script_ref_call(on_alrm0) || !instance_exists(self));
#macro  alarm1_run                                                                              alarm1 && !--alarm1 && !--alarm1 && (script_ref_call(on_alrm1) || !instance_exists(self));
#macro  alarm2_run                                                                              alarm2 && !--alarm2 && !--alarm2 && (script_ref_call(on_alrm2) || !instance_exists(self));
#macro  alarm3_run                                                                              alarm3 && !--alarm3 && !--alarm3 && (script_ref_call(on_alrm3) || !instance_exists(self));
#macro  alarm4_run                                                                              alarm4 && !--alarm4 && !--alarm4 && (script_ref_call(on_alrm4) || !instance_exists(self));
#macro  alarm5_run                                                                              alarm5 && !--alarm5 && !--alarm5 && (script_ref_call(on_alrm5) || !instance_exists(self));
#macro  alarm6_run                                                                              alarm6 && !--alarm6 && !--alarm6 && (script_ref_call(on_alrm6) || !instance_exists(self));
#macro  alarm7_run                                                                              alarm7 && !--alarm7 && !--alarm7 && (script_ref_call(on_alrm7) || !instance_exists(self));
#macro  alarm8_run                                                                              alarm8 && !--alarm8 && !--alarm8 && (script_ref_call(on_alrm8) || !instance_exists(self));
#macro  alarm9_run                                                                              alarm9 && !--alarm9 && !--alarm9 && (script_ref_call(on_alrm9) || !instance_exists(self));
#macro  instance_max                                                                            instance_create(0, 0, DramaCamera);
#macro  bbox_center_x                       													(bbox_left + bbox_right + 1) / 2;
#macro  bbox_center_y                       													(bbox_top + bbox_bottom + 1) / 2;
#define orandom(_num)                                                                   		return  random_range(-_num, _num);
#define nothing
#define chance(_numer, _denom)                                                      			return  random(_denom) < _numer;
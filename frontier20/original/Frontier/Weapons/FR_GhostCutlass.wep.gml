#define init

	 // LIB:
	while(!mod_exists("mod", "lib")){wait(1);}
	script_ref_call(["mod", "lib", "getRef"], "weapon", mod_current, "scr");
	#macro  scr			global.scr
	#macro  call		script_ref_call

     // Sprites:
    global.sprWeapon 	        = sprite_add_weapon("../Sprites/Weapons/sprGhostCutlassInactive.png",	7, 5);
    global.sprWeaponOn 	        = sprite_add("../Sprites/Weapons/sprGhostCutlassActive.png",			4, 5, 9);
    global.sprWeaponGlow 	    = sprite_add("../Sprites/Weapons/sprGhostCutlassActiveGlow.png",		4, 10, 9);
    global.sprWeaponHud 	    = sprite_add("../Sprites/Weapons/Hudsprites/sprGhostCutlassHud.png",	1, 0, 6);
    global.sprGhostSlash		= sprite_add("../sprites/projectiles/sprGhostSlash.png", 				3, 0, 24);
	global.sprGhostNull			= sprite_add("../sprites/particles/sprGhostNull.png",					3, 8, 8);
    
    global.sprFollower			= sprite_add("../Sprites/Projectiles/sprGhostCutlassFollower.png",		4, 10, 16); 
    global.sprFollowerGlow		= sprite_add("../Sprites/Projectiles/sprGhostCutlassFollowerGlow.png",	4, 10, 16); 
    
#define weapon_name         return "GHASTLY CUTLASS";          
#define weapon_text         return "@qITS WHISPERING";
#define weapon_sprt(_wep)   
	 // When Held:
    if(instance_is(self, Player) && (wep = _wep)){
        with(script_bind_draw(PlayerGhostCutlass_draw, depth + 1)){
            gunangle		= other.gunangle;
            wepangle		= other.wepangle;
            wkick			= other.wkick;
            right 			= other.right;
            wepflip 		= other.wepflip;
            sprite_index	= global.sprWeaponOn; 
            creator 		= other;
            image_blend		= player_get_color(other.index)
            x				= other.x + other.hspeed_raw;
            y				= other.y + other.vspeed_raw;
            if(other.gunangle > 180){
                depth		= other.depth - 2;
            } else{
            	depth 		= other.depth + 1;
            }
        }
        return mskNone;
    } else {
    	 // When in Offhand:
    	if(instance_is(self, Player) && (bwep = _wep)){
    		return mskNone;
    	} else {
    		 // When on Ground:
    		return global.sprWeapon;
    	}
    }
    
#define weapon_sprt_hud		return global.sprWeaponHud;
#define weapon_type         return 0;
#define weapon_melee        return true;
#define weapon_area         return mod_script_call("mod", "Frontier_Projectiles", "check_piratedrops", mod_current, 14);
#define weapon_auto         return false;
#define weapon_load         return 15;
#define weapon_cost         return 0;
#define weapon_swap         
	sound_play_pitchvol(sndSwapCursed, 0.7, 1.2);
	return sndSwapSword

#define weapon_fire(_wep)
	// FIGURE OUT WHAT TO DO FOR STERIODS

     // FireCont Support:
	var c = ((instance_is(self, FireCont) && "creator" in self) ? creator : self);

     // Sounds:
	sound_play_pitchvol(sndPlasma,			1.3 + random(0.3), 0.75);
	sound_play_pitchvol(sndBloodLauncher,	1.1 + random(0.3), 0.4);
		
	var _disjoint = (0 + 15 * skill_get(mut_long_arms));
	with instance_create(x + lengthdir_x(_disjoint, gunangle), y + lengthdir_y(_disjoint, gunangle), Slash){
		sprite_index	= global.sprGhostSlash;
		image_alpha		= 0.7;
    	speed			= 1.5 + (skill_get(13) * 4);
		direction		= other.gunangle;
		image_angle     = direction;
		damage			= 24;
		team            = other.team;
		creator         = other;
    }
   
     // Melee Schmoovement:
	wepangle = -wepangle;
	weapon_post(-4, 16, 5);
	motion_add(gunangle, 3.5);
	instance_create(x, y, Dust);
	
#define weapon_reloaded
	sound_play(sndMeleeFlip)
	wepflip = sign(wepangle)
	
#define step
    var _wep = (argument0 ? wep : bwep);
	if(!is_object(_wep)){
		lwo_initialize(_wep); 
		exit;
	};
	
	 // Spawn Follower:
	if(other.wep != _wep){
		if(other.race != "steroids"){
			if(array_length(instances_matching(CustomObject, "fr_ghostsword", other)) = 0){
				with(other){
					GhostCutlassFollower_create(x, y, self);
				}
			}
		}
	}
	
#define lwo_initialize(_wep)
	var _creator = ((instance_is(self, FireCont) && "creator" in self) ? creator : self);
	_wep = { 
		"wep"			: _wep, 
		"fr_ghostsword" : true,
	};
	
	if("wep" in _creator && _creator.wep == _wep.wep){
		_creator.wep = _wep;
	}
	if("bwep" in _creator && _creator.bwep == _wep.wep){
		_creator.bwep = lq_clone(_wep);
	}
	
#define PlayerGhostCutlass_draw
    if(!instance_exists(other)){
        instance_destroy();
        exit;
    }
    draw_weapon_evilsword(sprite_index, current_frame * 0.4, x, y, gunangle, wepangle, wkick, 1, wepflip, c_white, 1)
    draw_weapon_evilsword(global.sprWeaponGlow, current_frame * 0.4, x, y, gunangle, wepangle, wkick, 1.5, 1.5 * wepflip, c_white, 0.4)
	instance_destroy();
	

#define draw_weapon_evilsword(_sprite, _image, _x, _y, _angle, _angleMelee, _kick, _xscale, _flip, _blend, _alpha)
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
	draw_sprite_ext(_sprite, _image, _x, _y, _xscale, _flip, _angle, _blend, _alpha);	

#define GhostCutlassFollower_create(_x, _y, _leader)
	with(instance_create(_x, _y, CustomObject)){
		name = "fr_GhostCutlass";
		
		sprite_index	= global.sprFollower;
		spr_glow		= global.sprFollowerGlow;
		spr_dead		= global.sprGhostNull;
		depth			= -8;	
		image_alpha		= 0; // drawn manually:
		right			= 0;
		tilt			= 0;
		bobHeight		= 0.3;
		bobSpeed		= 0.06;
		fr_glow			= [32, 48];
		
		leader			= _leader;
		xGoal			= _leader.x;
		yGoal			= _leader.y;
		team			= _leader.team;
		fr_ghostsword	= _leader;
		flightspeed		= 5;
		offset			= 0;
		distance		= 30;
		attacking		= false;
		attackCooldown	= 0;
		attackRange		= 96 + (skill_get(mut_long_arms) * 32);
		hitbox			= noone;
		target			= noone;
		graceTime		= 0;

		on_step 		= GhostCutlassFollower_step;
		on_draw 		= GhostCutlassFollower_draw;
		on_destroy		= GhostCutlassFollower_destroy;
		
		return self;
	}
	
#define GhostCutlassFollower_step
	 // Destroy when its time:
	if(!instance_exists(leader)){
		instance_destroy();
		exit;
	}
	if(!is_object(leader.bwep) || ("fr_ghostsword" not in leader.bwep)){
		with(hitbox){
			instance_destroy();
		}
		instance_destroy();
		exit;
	}
	if(hitbox = noone){
		hitbox = SwordHitbox_create(x, y, self);
	}
	
	 // follow normal:
	if(attacking = false){
		 // Position Me:
		x += approach(x, xGoal, 2, 0.4 * current_time_scale) - lengthdir_x(0, leader.gunangle)
		y += approach(y, yGoal, 2, 0.4 * current_time_scale) - lengthdir_y(0, leader.gunangle) 
		y = y + sin(current_frame * bobSpeed) * bobHeight;
		xGoal = leader.x - lengthdir_x(distance, leader.gunangle + offset)
		yGoal = leader.y - lengthdir_y(distance, leader.gunangle + offset)
			
		 // Tilt n' Tumble:
		tilt = 0 + sin(current_frame * 0.12) * 16
		
		 // Flip:
		right = (leader.gunangle + 270) mod 360 > 180 ? 1 : -1;
		
		 // woahhh
		if(random(50) < 1){
			offset = irandom_range(-40, 40);
			distance = 20 + irandom(16)
		}
		

		var _enemy = instance_nearest(leader.x, leader.y, enemy);
		with(leader){
			if((distance_to_object(_enemy) < other.attackRange) && (!collision_line(x, y, _enemy.x, _enemy.y, Wall, false, false))){
				other.target			= _enemy;
				other.attacking			= true;
				other.attackCooldown	= 0;
			}
		}
	} else {
		if(current_frame_active){
			if(instance_exists(target)){
				tilt -= (angle_difference(tilt, point_direction(x, y, target.x, target.y) + 90) * power(0.2, 1));
				if(speed > 2){
					direction -= (angle_difference(direction, point_direction(x, y, target.x, target.y)) * power(0.1, 1));
				}
			}
			attackCooldown	-= 1; // using current frame active here, idk what the deal is with this it was weird in 60fps
			graceTime		-= 1;
			speed = clamp(speed - (speed / 12), 2, 18);
			if(attackCooldown <= 0){
				if(instance_exists(target)){
					direction		= point_direction(x, y, target.x, target.y);
				}
				speed			= clamp(distance_to_object(target) / 4, 12, 30);
				attackCooldown	= 20;
				graceTime		= 15;
			} else {
				var _enemy = instance_nearest(leader.x, leader.y, enemy);
				with(leader){
					
					 // return:
					if((distance_to_object(_enemy) > other.attackRange) || (collision_line(x, y, _enemy.x, _enemy.y, Wall, false, false))){
						if(other.graceTime <= 0){
							other.attacking = false;
							other.speed	= 0;
						}
					
					 // kill
					} else {
						other.target = _enemy;
					}
				}
			}
		}
	}
	
#define GhostCutlassFollower_destroy
	with(instance_create(x, y, BulletHit)){
		sprite_index	= other.spr_dead;
	}
	
#define SwordHitbox_create(_x, _y, _creator)
	with(instance_create(_x, _y, CustomSlash)){
		sprite_index	= mskNone;
		creator			= _creator;
		team			= _creator.team;
		mask_index		= mskFlakBullet;
		damage			= 8;
		typ				= 0;
		ammo_type		= -1;
		
		on_anim			= nothing;
		on_projectile	= SwordHitbox_nullify;
		on_grenade		= nothing;
		on_hit			= SwordHitbox_hit;
		on_wall			= nothing;
		on_end_step		= SwordHitbox_endstep;
		on_destroy		= SwordHitbox_destroy;
		
		return self;
	}

#define SwordHitbox_hit
	if(projectile_canhit_melee(other)){
		with(other){
			projectile_hit(self, other.damage);
		}
	}

#define SwordHitbox_nullify
	if(instance_exists(self)) && (other.typ > 0){ 
		with(other){
			sound_play_pitchvol(sndCursedPickupDisappear, 1.3 + random(0.2), 0.4)
			with instance_create(x, y, ImpactWrists){ 
				sprite_index = global.sprGhostNull;
			}
			instance_destroy();
		} 
	}
	
#define SwordHitbox_endstep
	if(!instance_exists(creator)){ instance_destroy(); exit; }
	x = creator.x
	y = creator.y
	
	if(creator.attacking = true){
		with(mod_script_call("mod", "Frontier_Projectiles", "GenericTrail_create", x, y)){
			depth			= -7;
			image_xscale	= point_distance(x, y, other.xprevious, other.yprevious)
			image_yscale   *= 2;
			image_speed    *= 4;
			image_angle 	= point_direction(x, y, other.xprevious, other.yprevious)
			image_blend 	= make_color_rgb(63, 247, 151);
			image_alpha		= 0.7;
		}
	}
	
#define SwordHitbox_destroy
	if(instance_exists(creator)){ 
		creator.hitbox = noone;
	}
	
#define nothing

#define GhostCutlassFollower_draw
	draw_sprite_ext(sprite_index, current_frame * 0.4, x, y, image_xscale * right, image_yscale, tilt, c_white, 1);
	draw_sprite_ext(spr_glow, current_frame * 0.4, x, y, (image_xscale * 1.5) * right, (image_yscale * 1.5), tilt, c_white, 0.4);

#define approach(a, b, n, dn)
	return (b - a) * (1 - power((n - 1)/n, dn)) 

#macro  current_frame_active 				frac(current_frame) < current_time_scale
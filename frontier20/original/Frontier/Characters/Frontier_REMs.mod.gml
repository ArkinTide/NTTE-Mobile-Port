#define init
    global.sprBubblesProjectile					= sprite_add("../sprites/Characters/Bubbles/sprBubblesProjectile.png", 4, 8, 8);
	global.sprBubblesProjectileBig				= sprite_add("../sprites/Characters/Bubbles/sprBubblesProjectileBig.png", 4, 12, 12);
	global.sprBubblesProjectileTrail			= sprite_add("../sprites/Characters/Bubbles/sprBubblesTrail.png",3, 4, 4);
    global.sprBubblesProjectileExplosion		= sprite_add("../sprites/Characters/Bubbles/sprBubblesExplosion.png",7, 12, 12);
	global.sprBubblesProjectileSpray  			= sprite_add("../sprites/Characters/Bubbles/sprBubblesSprayParticle.png",5, 8, 8);
	global.sprBubbleProjectileNullify			= sprite_add("../sprites/Characters/Bubbles/sprBubblesProjectileNullify.png", 4, 24, 24);
	global.mskBubbleProjectile					= sprite_add("../sprites/Characters/Bubbles/mskBubblesProjectile.png",1, 8, 8);

    // Import REM Scripts
mod_current_type = script_ref_create(0)[0];

var _import = [
	["mod", REM_BASE, "scr"]
];

with(_import){
	if (fork()){
		while (!mod_script_exists(self[0], self[1], "scr_import")){
			wait(0);
		}
		
		if (mod_script_exists(self[0], self[1], "scr_import")){
			mod_script_call_nc(self[0], self[1], "scr_import", script_ref_create(0), self[2]);
		}
		
		exit;
	}
}

#macro REM_BASE "revivable_enemy_mutants"
#macro REM_CONTROLLER REM_BASE + ".mod controller"

#macro scr global.scr
#macro call script_ref_call

#macro mod_current_type global.mod_current_type
#macro CONTROLLER mod_current + "." + mod_current_type + " controller"

#macro obj global.obj

#macro animation_end (image_index + image_speed_raw >= image_number || image_index + image_speed_raw < 0)

#macro bbox_center_x ((bbox_right + bbox_left + 1) >> 1)
#macro bbox_center_y ((bbox_bottom + bbox_top + 1) >> 1)

#macro no_wep wep == wep_none || wep == "" || (is_object(wep) && !lq_size(wep))
#macro no_bwep bwep == wep_none || bwep == "" || (is_object(bwep) && !lq_size(bwep))


global.mutants = [
	["REM_Bubbles", false]
];

global.ready = false;

global.events = [

];

enum Independence{
	FOLLOW_CREATOR = (1 << 0),
	STAY_CLOSE = (1 << 1),
	HOLD_YOUR_FIRE = (1 << 2),
	REMAIN_HERE = (1 << 3),
}

enum Walk{
	MIN = 0,
	MAX = 64,
}

if (fork()){
	while (!mod_variable_exists("mod", REM_BASE, "ready") || !mod_variable_get("mod", REM_BASE, "ready")){
		wait(0);
	}
	
	if (mod_variable_get("mod", REM_BASE, "ready")){
		with(global.mutants){
			call(scr.rem_mutant_register, mod_current_type, mod_current, self[0], self[1]);
		}
		
		with(global.events){
			call(scr.obj_event_register, self[0], self[1], self[2]);
		}
		
		global.ready = true;
	}
	
	exit;
}


#define cleanup
if (global.ready){
	with(global.mutants){
		call(scr.rem_mutant_deregister, mod_current_type, mod_current, self[0]);
	}
	
	with(global.events){
		call(scr.obj_event_deregister, self[0], self[1], self[2]);
	}
}

#define game_start
	if(mod_exists("mod", "revivable_enemy_mutants")){
		obj = mod_variable_get("mod", REM_BASE, "obj");
	}

#define REM_Bubbles_create(_x, _y)
with(call(scr.obj_create, _x, _y, "REM_RevivableMutant")){
	call(scr.when_you_fight_the_boss, 8);
	
	spr_idle = mod_variable_get("race", "bubbles", "sprIdle")[0];
	spr_walk = mod_variable_get("race", "bubbles", "sprWalk")[0];
	spr_hurt = mod_variable_get("race", "bubbles", "sprHurt")[0];
	spr_dead = mod_variable_get("race", "bubbles", "sprDead")[0];
	spr_fire = mod_variable_get("race", "bubbles", "sprFire")[0];
	sprite_index = spr_idle;
	
	hitid = [spr_idle, "BUBBLES"];
	
	snd_hurt = mod_variable_get("race", "bubbles", "sndBubblesHurt");
	snd_dead = mod_variable_get("race", "bubbles", "sndBubblesDead");
	snd_fire = mod_variable_get("race", "bubbles", "sndBubblesLowA");
	
	water_breathing = true;
	
	bubbles_maxBubbleCharge = 50;					
	bubbles_bubbleCharge    = bubbles_maxBubbleCharge; 
	bubbles_bubbleCooldown  = 0;
	bubbles_ultraOrbitalSize=1;
	bubbles_ultraOrbitals	= [noone, noone, noone];
	
	
	return self;
}

#define REM_Bubbles_active(_dir)
	
	 // VFX:
	sprite_index = spr_fire
	
	 // Boost:
	motion_add(gunangle, -3)
	speed += 2
	
	 // Cooldown:
	bubbles_bubbleCharge -= ((5 * current_time_scale) + (skill_get(mut_throne_butt) * 12));
	if(skill_get(mut_throne_butt)){
		bubbles_bubbleCooldown += 5;
	}
	
	 // Projectiles:
	with(BubbleProjectile_create(x, y)){
		direction	= _dir + random_range(-20, 20)
		team		= other.team;
		sound_play_pitchvol(choose(
			mod_variable_get("race", "bubbles", "sndBubblesSpec"), 
			mod_variable_get("race", "bubbles", "sndBubblesSpec2"), 
			mod_variable_get("race", "bubbles", "sndBubblesSpec3")
		), random_range(0.8, 1.1), 0.5);
		sound_play_pitchvol(sndOasisHurt, random_range(0.8, 1.2), 0.4);	
	}	

#define REM_Bubbles_step
	 // attack nearest projectiles
	var _nearestProjectile = instance_nearest_array(x, y, instances_matching_ne(projectile, "team", team));
	if(bubbles_bubbleCooldown <= 0 && bubbles_bubbleCharge > 0){
		if((distance_to_object(_nearestProjectile) < 72) && (!collision_line(x, y, _nearestProjectile.x, _nearestProjectile.y, Wall, false, false))){
			REM_Bubbles_active(point_direction(x, y, _nearestProjectile.x, _nearestProjectile.y));
		}		
	}

		// Bubble Recharge:
	if(bubbles_bubbleCharge < bubbles_maxBubbleCharge){ 
		bubbles_bubbleCharge += current_time_scale;
	}
	
		// Bubblecharge Cap:
	if(bubbles_bubbleCharge > bubbles_maxBubbleCharge){
		bubbles_bubbleCharge = bubbles_maxBubbleCharge;
	}
	
	 // if charge empty, add a cooldown:
	if(bubbles_bubbleCharge <= 0){ 
		bubbles_bubbleCooldown = 75; 
	}
	 // Cooldown Counter:
	if (bubbles_bubbleCooldown > 0){ 
		bubbles_bubbleCooldown -= current_time_scale; 
	}

	if(ultra_get("bubbles", 1) > 0){
		
			// Create Orbitals:
		if(!instance_exists(bubbles_ultraOrbitals[0]) || !instance_exists(bubbles_ultraOrbitals[1]) || !instance_exists(bubbles_ultraOrbitals[2])){
			bubbles_ultraOrbitals		= [noone, noone, noone]
			bubbles_ultraOrbitals[0]	= BubbleOrbital_create(x, y, self, 0, 19);
			bubbles_ultraOrbitals[1]	= BubbleOrbital_create(x, y, self, 120, 19);
			bubbles_ultraOrbitals[2]	= BubbleOrbital_create(x, y, self, 240, 19);
		}	
		 
			// Regrow Orbitals:
		if(bubbles_ultraOrbitalSize < 1){ 
			bubbles_ultraOrbitalSize += (0.04 * current_time_scale);
		} else {
			bubbles_ultraOrbitalSize = 1;
		}
		if(bubbles_ultraOrbitalSize < 0){ 
			bubbles_ultraOrbitalSize = 0; 
		}
	}

#define BubbleProjectile_create(_x, _y)
	
	// Boost Particle:
	repeat(2){
		with(instance_create(_x, _y, FishBoost)){
			direction		= other.gunangle + random_range(-45, 45);
			image_angle		= random(360);
			speed			= 1 + random(2);
			depth       	= -3;
			sprite_index	= mod_variable_get("race", "bubbles", "sprBubbleSprayParticle")[0];
		}
	}
		// Bubble Particle:
	if (random(3) < 1){ 
		instance_create(x, y, Bubble) 
	}
				
		// Projectile:
	with(instance_create(_x, _y, CustomSlash)){
		name = "bubbles_REMbubbleProjectile"
				
		 // Visuals:
		sprite_index	= mod_variable_get("race", "bubbles", "sprBubbleProjectile")[0];
		mask_index  	= mod_variable_get("race", "bubbles", "mskBubbleProjectile");
		spr_bubbletrail = mod_variable_get("race", "bubbles", "sprBubbleTrail")[0];
		spr_bubbleexplo	= mod_variable_get("race", "bubbles", "sprSmallBubbleExplosion")[0];
		spr_nullify		= mod_variable_get("race", "bubbles", "sprBubbleProjectileNullify")[0];
		spr_burst		= mod_variable_get("race", "bubbles", "sprBubbleProjectileBurst")[0];
		spr_burstbullet = mod_variable_get("race", "bubbles", "sprBubbleProjectileBurstBullet")[0];
		rotation_speed	= (random_range(5, 10) * current_time_scale)
		image_speed 	= 0//0.4;
		image_index 	= 0;
		image_xscale	= random_range(0.8, 1.3);
		image_yscale	= image_xscale;
		image_angle 	= 0;
		depth			= -3;
		image_alpha		= 0.8;
		fr_bloom		= [1.2, 0.05];
		trailRange		= 6;
		bubble_tiltspeed= random_range(0.17, 0.2);
		bubble_tiltrange= random_range(35, 50);
				
		 // Vars:
		damage			= 1 + (skill_get(mut_throne_butt) * 3)
		team			= other.team;
		speed			= 5.5 + random_range(0.8, 2.3);
		friction		= 0.2 + skill_get(mut_throne_butt) * 0.4;
		ultra_b_charges	= 0;	
				
		 // Projectile Nomenclature:
		ammo_type = -1;
				
		// Thronebutt Vars:
		if skill_get(mut_throne_butt){
			sprite_index	= mod_variable_get("race", "bubbles", "sprBubbleProjectileBig")[0];
			mask_index  	= mskSuperFlakBullet;
			friction    	= 0.1;
			speed       	= 2.5 + random_range(0.8, 2.3);
			trailRange		= 12;
		}
					
		lifeTime		= skill_get(mut_throne_butt) ? 75 : 0;
					
				
		// Functions:
		on_projectile = BubbleProjectile_nullify;
		on_anim       = nothing;
		on_step       = BubbleProjectile_step;
		on_wall       = BubbleProjectile_wall;
		on_hit        = BubbleProjectile_hit;
		on_destroy    = BubbleProjectile_destroy;
		
		return self;
	}
				
 // Bubble Projectile:
#define BubbleProjectile_step 

	// Spin:
	image_angle = 0 + sin(current_frame * bubble_tiltspeed) * bubble_tiltrange
	
	// Trail:
	if(random(25) < current_time_scale){
		with(instance_create(x + random_range(-trailRange, trailRange),y + random_range(-trailRange, trailRange), BulletHit)){ 
			sprite_index	= other.spr_bubbletrail; 
			speed			= other.speed / 4;
			direction		= other.direction + 180 + random_range(-15, 15);
		}
	} 
	if((speed < 2)){ 
		if(lifeTime > 0){
			lifeTime -= current_time_scale;
		}
		else{
			instance_destroy();
			exit;
		}
	}

#define BubbleProjectile_nullify
	if(instance_exists(self)){
		var me = self;
		if(other.typ > 0){
			with(other){
				with instance_create(x, y, ImpactWrists){ 
					sprite_index = me.spr_nullify; 
				}
				instance_destroy();
			} 
			if(ultra_get("bubbles", 2) > 0){
				ultra_b_charges += 1;
			}
		}
	}
	
#define BubbleProjectileSub_nullify
	if(instance_exists(self)){
		var me = self;
		if(other.typ > 0){
			with(other){
				with instance_create(x, y, ImpactWrists){ 
					sprite_index = me.spr_nullify; 
				}
				instance_destroy();
			} 
		}
	}

#define BubbleProjectile_wall    
	move_bounce_solid(true); 
	speed *= 0.7;
    with instance_create(x + hspeed, y + vspeed, MeleeHitWall){
		image_angle = (direction + 180) - angle_difference(other.direction, (direction + 180))
		image_yscale = random_range(0.5, 0.8);
		image_speed *= 2;
		image_index = irandom(1);
	}
        
#define BubbleProjectile_hit     
	projectile_hit(other, damage); 
	instance_destroy();
	
#define BubbleProjectile_destroy

	if(ultra_b_charges > 0){
		BubbleProjectileBurst_create(x, y, ultra_b_charges)
	}

		//Sounds:
	sound_play_pitchvol(sndOasisHurt,			random_range(0.8, 1.2), 0.1);
	sound_play_pitchvol(sndOasisExplosionSmall, random_range(0.8, 1.2), 0.2);
	sound_play_pitchvol(mod_variable_get("race", "bubbles", "sndBubblePop"),	random_range(0.5, 1.2), 0.75);	
	
		//Particles:
	repeat(irandom(3)){
		with instance_create(x + random_range(-1, 1), y + random_range(-1, 1), Bubble){ 
			image_yscale = image_xscale;
		}
	}
	
		//Explosion:
	with(instance_create(x, y, CustomSlash)){
		sprite_index	= mod_variable_get("race", "bubbles", "sprSmallBubbleExplosion")[0];
		mask_index		= mskSmallExplosion;
		spr_nullify		= mod_variable_get("race", "bubbles", "sprBubbleProjectileNullify")[0];
		image_speed 	= 0.4;
		image_alpha		= 0.8;
		fr_bloom		= [1.2, 0.05];
				
	
		ammo_type		= -1;
		speed			= 0;
		team			= other.team;
		creator			= other.creator;
		ultra_b_charges	= 0;
	
		on_projectile	= BubbleProjectileSub_nullify;
		on_wall 		= nothing;
		on_hit  		= nothing;
	}

		// ULTRA B PROJECTILES //
#define BubbleProjectileBurst_create(_x, _y, _charges)
	with(instance_create(_x, _y, CustomProjectile)){
		name = "bubbles_ProjectileBurst"	
		
		sprite_index	= other.spr_burst;
		spr_burstbullet	= other.spr_burstbullet;
		spr_bubbleexplo	= other.spr_bubbleexplo;
		spr_nullify		= other.spr_nullify;
		spr_bubbletrail	= other.spr_bubbletrail;
		image_index		= 2;
		image_speed		= 0;
		image_alpha		= 0.8;
		fr_bloom		= [1.2, 0.1];
		
		ammo			= _charges;
		burstDelay		= 4;
		team			= other.team;
		creator			= other.creator;
		
		on_step			= BubbleProjectileBurst_step
		on_hit			= nothing;
		on_wall			= nothing;
		
		return self;
	}

#define BubbleProjectileBurst_step
	image_angle += 10 * current_time_scale;

	if(burstDelay > 0){
		burstDelay -= current_time_scale;
	}

	if(ammo > 0){
		if(burstDelay <= 0){
			sound_play_pitchvol(sndOasisShoot, 1.2 + random(0.2), 0.7)
			BubbleProjectileBurstBullet_create(x, y, other.spr_burstbullet, other.spr_bubbleexplo, other.spr_nullify, other.spr_bubbletrail)
			burstDelay = 2;
			ammo -= 1;
		}
	}
	
	if(ammo <= 0){
		image_xscale -= 0.2;
		image_yscale = image_xscale;
		if(image_xscale <= 0){
			instance_destroy();
		}
	}

#define BubbleProjectileBurstBullet_create(_x, _y, _sprite, _spr_explo, _spr_null, _spr_trail)
	with(instance_create(x, y, CustomSlash)){
		name	= "bubbles_ProjectileBurstBullet";
		
		sprite_index	= _sprite;
		spr_bubbleexplo	= _spr_explo;
		spr_nullify		= _spr_null;
		spr_trail		= _spr_trail;
		image_speed		= 0.4;
		image_alpha		= 0.8;
		fr_bloom		= [1.2, 0.1];
		
		if(instance_exists(enemy)){
			var _nearestGuy = instance_nearest(x, y, enemy);
			if(!collision_line(x, y, _nearestGuy.x, _nearestGuy.y, Wall, false, false)){
				direction	= point_direction(x, y, _nearestGuy.x, _nearestGuy.y) + random_range(-15, 15);
			} else {
				direction = random(360);
			}
		} else {
			direction = random(360);
		}
				
		mask_index		= mod_variable_get("race", "bubbles", "mskBubbleProjectileBurstBullet");
		damage			= 5;
		speed			= 11 + random(2);
		team			= other.team;
		image_angle		= direction;
		ultra_b_charges = 0;
				
		on_anim			= nothing;
		on_step			= BubbleProjectileBurstBullet_step;
		on_hit			= BubbleProjectile_hit;
		on_wall			= BubbleProjectileBurstBullet_wall;
		on_destroy		= BubbleProjectile_destroy;
		on_projectile	= BubbleProjectileSub_nullify;
		
		return self;
	}
	
#define BubbleProjectileBurstBullet_step
	if(random(10) < 1){
		with(instance_create(x, y, BulletHit)){
			sprite_index	= other.spr_trail;
			image_index		= choose(0, 1);
			direction		= (other.direction + 180) + random_range(-5, 5)
		}
	}
	
#define BubbleProjectileBurstBullet_wall
	instance_destroy();
	
	// ULTRA A ORBITALS // 
#define BubbleOrbital_create(_x, _y, _creator, _angle, _dist)
	with instance_create(_x, _y, CustomSlash){
		name = "bubbles_ultraOrbital";
		
		 // Visual:
		sprite_index	= mod_variable_get("race", "bubbles", "sprBubbleProjectile")[0];
		spr_nullify		= mod_variable_get("race", "bubbles", "sprBubbleProjectileNullify")[0];
		image_speed		= 0;
		depth			= -3;
		image_xscale	= other.bubbles_ultraOrbitalSize;
		image_yscale	= image_xscale;
		direction		= _creator.gunangle;
		image_angle		= _creator.gunangle
		image_alpha		= 0.8;
		speed			= 0;
		fr_bloom		= [1.2, 0.05];
		
		 // Vars:
		ownerid 		= other.id;
		angle			= _angle;
		dist		    = _dist;
		creator			= _creator;
		team			= _creator.team;
		typ				= 0;
		ammo_type		= -1;
		prism_duplicate = true;
		
		
		 // Functions:
		on_wall 		= nothing;
		on_hit			= nothing;
		on_projectile	= BubbleOrbital_nullify;
		on_grenade		= nothing;
		on_step 		= BubbleOrbital_step;
		on_end_step		= BubbleOrbital_endstep;
		on_destroy		= BubbleOrbital_destroy;
				
		return self;
	}

#define BubbleOrbital_nullify
	// Delete Projectile:
	if(instance_exists(self)) && (other.typ > 0) && (creator.bubbles_ultraOrbitalSize > 0.2){ 
	var me = self;
		with(other){ 
			with instance_create(x, y, ImpactWrists){ 
				sprite_index = me.spr_nullify; 
			}
			instance_destroy();
		} 
	} 
	
	// Shrink Orbitals:
	if(instance_exists(creator)){
		with(creator){ 
			if(bubbles_ultraOrbitalSize > 0){ 
				bubbles_ultraOrbitalSize -= 0.10; 
			}
		}
	}

#define BubbleOrbital_step
	 // Goodbye:
	if !instance_exists(creator) || !(ultra_get("bubbles", 1) > 0){
		instance_destroy();
		exit;
	}
	
	if(current_frame_active){
		if(random(2) > 1){
			with instance_create(x, y, BulletHit){
				sprite_index = mod_variable_get("race", "bubbles", "sprBubbleTrail")[0];
			}
		}
	}
	
	 // Set Size and Speen:
	image_xscale	= creator.bubbles_ultraOrbitalSize;
	image_yscale	= image_xscale;
	angle += 6 * current_time_scale;
	direction		= angle;
	image_angle += 12 * current_time_scale;

#define BubbleOrbital_wall
	xprevious = x + hspeed;
	yprevious = y + vspeed;
	
#define BubbleOrbital_endstep
	with(ownerid){
		other.xprevious = x + lengthdir_x(other.dist, other.angle);
		other.yprevious = y + lengthdir_y(other.dist, other.angle);
		other.x 		= x + lengthdir_x(other.dist, other.angle);
		other.y 		= y + lengthdir_y(other.dist, other.angle);
	}
	
#define BubbleOrbital_destroy
	if !instance_exists(creator){ exit; }
	 // Clear Other Orbitals:
	with(instances_matching(instances_matching(CustomSlash, "name", "bubbles_ultraOrbital"), "ownerid", ownerid)){
		if(instance_exists(self)){
			instance_destroy();
		}
	}

#define nothing

#define instance_nearest_array(_x, _y, _obj)
	/*
		Returns the instance closest to a given point from an array of instances
		
		Ex:
			instance_nearest_array(x, y, instances_matching_ne(hitme, "team", 2));
	*/
	
	var	_disMax  = 1/0, //infinity
		_nearest = noone;
		
	with(instances_matching_ne(_obj, "id", null)){
		var _dis = point_distance(_x, _y, x, y);
		if(_dis < _disMax){
			_disMax  = _dis;
			_nearest = self;
		}
	}
	
	return _nearest;

#macro current_frame_active 		frac(current_frame) < current_time_scale
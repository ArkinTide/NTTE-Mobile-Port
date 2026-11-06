#define init

	 // Sprites:
	global.sprSkillIcon 					= sprite_add("../sprites/mutations/sprAugmentImpactWrists.png", 1, 12, 16);
	global.sprSkillHud  					= sprite_add("../sprites/mutations/sprAugmentImpactWristsIcon.png", 1, 8, 8);
	global.mskAugmentImpactDroneHitbox  	= sprite_add("../sprites/projectiles/mskAugmentImpactDroneHitbox.png", 1, 32, 32);
	global.sprAugmentDroneImpactWrists  	= sprite_add("../sprites/areas/hq/sprAugmentDroneImpactWrists.png", 1, 10, 7);
	global.sprAugmentDroneImpactWristsGlow  = sprite_add("../sprites/areas/hq/sprAugmentDroneImpactWristsGlow.png", 1, 10, 7);
	global.sprGenericTrail  				= sprite_add("../sprites/particles/sprGenericTrail.png", 50, 0, 50);

	global.sprGreenAugmentDroneImpactWrists  		= sprite_add("../sprites/areas/hq/sprGreenAugmentDroneImpactWrists.png", 1, 10, 7);
	global.sprGreenAugmentDroneImpactWristsGlow 	= sprite_add("../sprites/areas/hq/sprGreenAugmentDroneImpactWristsGlow.png", 1, 10, 7);
	global.sprGreenIDPDPortalCharge					= sprite_add("../sprites/particles/sprGreenIDPDPortalCharge.png", 4, 4, 4);
	global.sprGreenRogueExplosion					= sprite_add("../sprites/projectiles/sprGreenRogueExplosion.png", 8, 24, 24);
	
	global.levelStart						= (instance_exists(GenCont) || instance_exists(Menu));
	global.droneCharge						= 0;
	global.settingGreenAugments				= false;
	
	#macro current_frame_active 			frac(current_frame) < current_time_scale
	
	 // LIB:
	while(!mod_exists("mod", "lib")){wait(1);}
	script_ref_call(["mod", "lib", "getRef"], "skill", mod_current, "scr");
	#macro  scr			global.scr
	#macro  call		script_ref_call
	
#define skill_name			return loc("Frontier:AugmentImpactWrists:0", "ACOLYTE DRONE 'IAPETUS'");
#define skill_text			return loc("Frontier:AugmentImpactWrists:1", "@wKILLS @sCHARGE UP A#@(color:16776960)POWERFUL PIERCING DRONE");
#define skill_tip			return "HIGH IMPACT";
#define skill_button		sprite_index = global.sprSkillIcon;
#define skill_icon			return global.sprSkillHud;
#define skill_avail			return (mod_variable_get("mod", "Frontier_IDPD", "settingMainPoolAugments") = true) ? 1 : 0;
#define skill_wepspec		return 0;
#define skill_sacrifice		return false;
#define skill_augment		return mut_impact_wrists; 

#define game_start
	global.droneCharge = 0;

#define skill_take
	with call(scr.instance_random, Player){
		ImpactDrone_create(x, y, self)
	}

#define skill_lose
	global.droneCharge = 0;
	with(instances_matching(CustomObject, "name", "fr_ImpactDrone")){
		with(instance_create(x, y, ImpactWrists)){
			image_blend	= (global.settingGreenAugments ? make_colour_rgb(0, 255, 0) : make_colour_rgb(0, 255, 255));
		}
		instance_destroy();
	}
	
#define step
   
	if(instance_exists(GenCont) || instance_exists(Menu)){
		global.levelStart = true;
	}
	else if(global.levelStart){
		global.levelStart = false;
		with call(scr.instance_random, Player){
			ImpactDrone_create(x, y, self)
		}
	}
	
		 // Ooooughhh im charging up ooooungu:
	with(instances_matching(instances_matching_le(enemy, "my_health", 0), "fr_ImpactDroneCharged", null)){
		fr_ImpactDroneCharged = true;
		with(instances_matching(CustomObject, "name", "fr_ImpactDrone")){
			global.droneCharge += skill_get(mod_current);
			ImpactDroneChargeParticle_create(x + random_range(-40, 40), y + random_range(-40, 40), self)
		}
	}
    

#define ImpactDrone_create(_x, _y, _leader)
	with(instance_create(_x, _y, CustomObject)){
		name = "fr_ImpactDrone"
		
		sprite_index	= (global.settingGreenAugments ? global.sprGreenAugmentDroneImpactWrists		: global.sprAugmentDroneImpactWrists);
		spr_glow		= (global.settingGreenAugments ? global.sprGreenAugmentDroneImpactWristsGlow	: global.sprAugmentDroneImpactWristsGlow);
		depth			= -8;
		image_alpha		= 0; // Drawn in draw
		image_speed		= 0.4;
		trailColor		= (global.settingGreenAugments ? make_colour_rgb(0, 255, 0)	: make_colour_rgb(0, 255, 255));
		droneBobHeight	= 0.3;
		droneBobSpeed	= 0.06;
		right			= 0;
		offset			= 30;
		distance		= 50;
		tilt			= 0;
		fr_glow			= [16, 24];

		leader			= _leader;
		xGoal			= _leader.x;
		yGoal			= _leader.y;
		team			= _leader.team;
		friction		= 0.4;
		flightspeed		= 3.5;
		chargeMax		= 150;
		wantHitbox		= false;
		droneAttacking  = false;
		droneHitbox		= noone;
		
	
		on_step			= ImpactDrone_step;
		on_end_step		= ImpactDrone_endstep;
		on_draw			= ImpactDrone_draw;
		
		return self;
	}
	
#define ImpactDrone_step

	 // Uh Oh they died:
	if(!instance_exists(leader)){
		if(!instance_exists(Player)){
			with(instance_create(x, y, ImpactWrists)){
				image_blend	= (global.settingGreenAugments ? make_colour_rgb(0, 255, 0) : make_colour_rgb(0, 255, 255));
			}
			instance_destroy();
			exit;
		} else {
			leader = call(scr.instance_random, Player)
		}
	}
	
	if(droneAttacking = false){

		 // Position Me:
    	x += approach(x, xGoal, flightspeed, 0.3 * current_time_scale) - lengthdir_x(0, leader.gunangle)
    	y += approach(y, yGoal, flightspeed, 0.3 * current_time_scale) - lengthdir_y(0, leader.gunangle) 
    	y = y + sin(current_frame * droneBobSpeed) * droneBobHeight;
    	xGoal = leader.x - lengthdir_x(distance, leader.gunangle + offset)
    	yGoal = leader.y - lengthdir_y(distance, leader.gunangle + offset)
    	
		 // Tilt n' Tumble:
		tilt = ((leader.speed * 4) * -right);
	
		 // Flip:
		right = (leader.gunangle + 270) mod 360 > 180 ? 1 : -1;
	
		if(global.droneCharge >= chargeMax){
			droneAttacking = true;
			ImpactDrone_attack();
		}
	} else {
		
		 // Tilt n' Tumble:
		tilt = ((speed * 4) * -right);
	
		 // Flip:
		right = (direction + 270) mod 360 > 180 ? 1 : -1;
		
		if(current_frame_active && speed > 5){
			with(instance_create(x + random_range(-25, 25), y + random_range(-25, 25), BulletHit)){
				sprite_index	= (global.settingGreenAugments ? choose(global.sprGreenIDPDPortalCharge, sprPlasmaTrail) : choose(sprIDPDPortalCharge, sprPopoPlasmaTrail));
				image_index		= irandom(image_number)
				speed			= 5;
				direction		= other.direction + 180;
			}
		}
	}
	
	if(wantHitbox = true){
		if(instance_exists(leader)){
			if !instance_exists(droneHitbox){
				droneHitbox	= ImpactDroneHitbox_create(x, y, self);
			}
		}
	}

#define ImpactDrone_endstep
	if(droneAttacking = true){
		with generic_trail_create(x, y){
			depth			= other.depth + 1;
    		image_xscale	= point_distance(x, y, other.xprevious, other.yprevious)
    		image_yscale   *= 3;
    		image_speed    *= 4;
    		image_angle 	= point_direction(x, y, other.xprevious, other.yprevious)
			image_blend 	= other.trailColor;		
		}
	}

#define ImpactDrone_attack
	
	sound_play_pitchvol(sndVanWarning, 2, 0.4);
	sound_play_pitchvol(sndLaserCannonCharge, 1.6, 0.5)
	
	 // GET READY TO RUMBLE:
	repeat(25){
		if(!instance_exists(self)){ exit; }
		with(instance_create(x + random_range(-48, 48), y + random_range(-48, 48), IDPDPortalCharge)){
    		motion_add(point_direction(x, y, other.x, other.y), 3 + random(1));
        	alarm0 = (point_distance(x, y, other.x, other.y) / speed) + 1;
        	if(global.settingGreenAugments = true){
        		sprite_index = global.sprGreenIDPDPortalCharge;
        	}
    	}
    	wait(1);
	}

	 // Target Direction:
	if(instance_exists(enemy)){
		with(leader){
			var nearestGuy = instance_nearest(x, y, enemy)
		}
		var attackDirection = point_direction(x, y, nearestGuy.x, nearestGuy.y)
	} else {
		attackDirection	= random(360);
	}

	 // Bump:
	direction	= attackDirection + 180;
	speed		= 4;
	wait(10);
	if(!instance_exists(self)){ exit; }
	
	 // KILL:
	sound_play_pitchvol(sndLaserCannon, 0.8, 2)
	sound_play_pitchvol(sndEnergyHammer, 0.6, 2)
	
	 // Target Again!
	if(instance_exists(enemy)){
		with(leader){
			var nearestGuy = instance_nearest(x, y, enemy)
		}
		var attackDirection = point_direction(x, y, nearestGuy.x, nearestGuy.y)
	} else {
		attackDirection = random(360);
	}
	
	wantHitbox	= true;
	direction	= attackDirection;
	speed		= 30;
	wait(20);
	if(!instance_exists(self)){ exit; }
	wantHitbox	= false;
	speed		= 0;
	
	 
	 // Back2Normal:
	global.droneCharge = 0;
	droneAttacking = false;
	
#define ImpactDroneHitbox_create(_x, _y, _creator)
	with(instance_create(_x, _y, CustomProjectile)){
		
		sprite_index	= mskNone; //global.mskAugmentImpactDroneHitbox
		creator			= _creator;
		team			= _creator.team;
		mask_index		= global.mskAugmentImpactDroneHitbox;
		damage			= 30;
		hitlist			= [];
		typ				= 0;
		ammo_type		= -1;
		
		on_hit			= ImpactDroneHitbox_hit;
		on_wall			= nothing;
		on_end_step		= ImpactDroneHitbox_endstep;
		on_destroy		= ImpactDroneHitbox_destroy;
	}

#define ImpactDroneHitbox_hit
	if(array_find_index(hitlist, other) == -1){
		array_push(hitlist, other)
		var drone = self;
		with(other){
			projectile_hit(self, drone.damage)
			sound_play_pitchvol(sndExplosion, 1 + random_range(0.1, 0.3), 1.2)
			with(instance_create(x, y, PopoExplosion)){
				sprite_index	= (global.settingGreenAugments ? global.sprGreenRogueExplosion : sprRogueExplosion);
				mask_index		= mskExplosion;
				team			= drone.team;
				creator			= drone;
			}
		}
	}
	
#define ImpactDroneHitbox_endstep
	if(!instance_exists(creator) || creator.wantHitbox = false){ instance_destroy(); exit; }
	x = creator.x
	y = creator.y

#define ImpactDroneHitbox_destroy
	creator.droneHitbox = noone;
	
#define ImpactDrone_draw
	draw_sprite_ext(sprite_index, image_index, x, y, image_xscale * right, image_yscale, tilt, image_blend, 1);
	draw_sprite_ext(spr_glow, image_index, x, y, 1 * right, 1, tilt, image_blend, clamp(global.droneCharge / chargeMax, 0, 1));
    draw_set_blend_mode(bm_add)
	draw_sprite_ext(spr_glow, image_index, x, y, clamp(1 + global.droneCharge / chargeMax, 1, 2) * right, clamp(1 + global.droneCharge / chargeMax, 1, 2), tilt, image_blend, clamp(global.droneCharge / chargeMax, 0, 0.2));
    draw_set_blend_mode(bm_normal)
	
#define ImpactDroneChargeParticle_create(_x, _y, _drone)
	with(instance_create(_x, _y, CustomObject)){
		name = "fr_ImpactDroneChargeParticle"
		
		sprite_index	= (global.settingGreenAugments ? global.sprGreenIDPDPortalCharge : sprIDPDPortalCharge);
		image_index		= irandom(image_number);
		depth			= -7;
		image_alpha		= 0.6;
		image_speed		= 0//0.4;

		speed			= 7;
		creator			= _drone;
	
		on_step			= ImpactDroneChargeParticle_step;
		
		return self;
	}

#define ImpactDroneChargeParticle_step
	if instance_exists(creator) && instance_exists(self){
		direction = point_direction(x, y, creator.x, creator.y)
		if(place_meeting(x, y, creator)){
			instance_destroy();
			exit;
		}
	} else {
		instance_destroy();
	}

#define approach(a, b, n, dn)
	return (b - a) * (1 - power((n - 1)/n, dn)) 
	
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

#define nothing
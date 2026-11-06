#define init

	 // Sprites:
	global.sprSkillIcon 					= sprite_add("../sprites/mutations/sprAugmentEuphoria.png", 1, 12, 16);
	global.sprSkillHud  					= sprite_add("../sprites/mutations/sprAugmentEuphoriaIcon.png", 1, 8, 8);
	global.mskAugmentEuphoriaDroneHitbox	= sprite_add("../sprites/projectiles/mskAugmentEuphoriaDroneHitbox.png", 1, 12, 12);
	global.sprAugmentDroneEuphoria  		= sprite_add("../sprites/areas/hq/sprAugmentDroneEuphoria.png", 1, 6, 8);
	global.sprGenericTrail  				= sprite_add("../sprites/particles/sprGenericTrail.png", 50, 0, 50);
	global.sprNull							= sprite_add("../sprites/particles/sprAugmentSharpTeethNull.png", 3, 8, 8);

	global.sprGreenAugmentDroneEuphoria 	= sprite_add("../sprites/areas/hq/sprGreenAugmentDroneEuphoria.png", 1, 6, 8);
	global.sprGreenNull						= sprite_add("../sprites/particles/sprGreenAugmentSharpTeethNull.png", 3, 8, 8);
	
	global.levelStart						= (instance_exists(GenCont) || instance_exists(Menu));
	global.settingGreenAugments				= false;
	
	#macro current_frame_active 			frac(current_frame) < current_time_scale
	
	 // LIB:
	while(!mod_exists("mod", "lib")){wait(1);}
	script_ref_call(["mod", "lib", "getRef"], "skill", mod_current, "scr");
	#macro  scr			global.scr
	#macro  call		script_ref_call
	
#define skill_name			return loc("Frontier:AugmentEuphoria:0", "ACOLYTE DRONE 'ENCELADUS'");
#define skill_text			return loc("Frontier:AugmentEuphoria:1", "@sGAIN A @(color:16776960)PROJECTILE#DESTROYING DRONE");
#define skill_tip			return "@(color:16745694)COOL TIP";
#define skill_button		sprite_index = global.sprSkillIcon;
#define skill_icon			return global.sprSkillHud;
#define skill_avail			return (mod_variable_get("mod", "Frontier_IDPD", "settingMainPoolAugments") = true) ? 1 : 0;
#define skill_wepspec		return 0;
#define skill_sacrifice		return false;
#define skill_augment		return mut_euphoria; 

#define skill_lose
	with(instances_matching_ne(Player, "fr_myEuphoriaDrone", null)){
		fr_myEuphoriaDrone = null;
	}
	with(instances_matching(CustomObject, "name", "fr_EuphoriaDrone")){
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
		with(instances_matching_ne(Player, "fr_myEuphoriaDrone", null)){	
			fr_myEuphoriaDrone = null;
		}
	}
	with(instances_matching(Player, "fr_myEuphoriaDrone", null)){
		fr_myEuphoriaDrone = EuphoriaDrone_create(x, y, self);
	}
	
    

#define EuphoriaDrone_create(_x, _y, _leader)
	with(instance_create(_x, _y, CustomObject)){
		name = "fr_EuphoriaDrone"
		
		sprite_index	= (global.settingGreenAugments ? global.sprGreenAugmentDroneEuphoria		: global.sprAugmentDroneEuphoria);
		depth			= -8;
		image_alpha		= 0; // Drawn in draw
		image_speed		= 0.4;
		trailColor		= (global.settingGreenAugments ? make_colour_rgb(0, 255, 0)	: make_colour_rgb(0, 255, 255));
		droneBobHeight	= 0.3;
		droneBobSpeed	= 0.06;
		right			= 0;
		offset			= 0;
		distance		= 40;
		tilt			= 0;
		fr_glow			= [16, 24];

		leader			= _leader;
		xGoal			= _leader.x;
		yGoal			= _leader.y;
		team			= _leader.team;
		friction		= 0.4;
		flightspeed		= 5;
		chargeMax		= 150;
		wantHitbox		= false;
		imDoingIt		= false;
		returnCooldown	= 0;
		droneHitbox		= noone;
		
	
		on_step			= EuphoriaDrone_step;
		on_end_step		= EuphoriaDrone_endstep;
		on_draw			= EuphoriaDrone_draw;
		
		return self;
	}
	
#define EuphoriaDrone_step

	 // Uh Oh they died:
	if(!instance_exists(leader)){
		with(instance_create(x, y, ImpactWrists)){
			image_blend	= (global.settingGreenAugments ? make_colour_rgb(0, 255, 0) : make_colour_rgb(0, 255, 255));
		}
		instance_destroy();
		exit;
	}
	
	var _nearestBullet = call(scr.instance_nearest_array, leader.x, leader.y, instances_matching_ne(instances_matching_ne(projectile, "typ", 0), "team", leader.team)){
		with(leader){
			if(distance_to_object(_nearestBullet) < 56){
				other.imDoingIt 		= true;
				other.wantHitbox		= true;
				other.returnCooldown	= 5;
			} else {
				_nearestBullet			= noone;
				if(other.returnCooldown <= 0){
					other.imDoingIt 	= false;
					other.wantHitbox	= false;
				}
			}
		} 
	}
	
	if(imDoingIt = false){
		 // Position Me:
		x += approach(x, xGoal, flightspeed, 0.3 * current_time_scale) - lengthdir_x(0, leader.gunangle)
		y += approach(y, yGoal, flightspeed, 0.3 * current_time_scale) - lengthdir_y(0, leader.gunangle) 
		y = y + sin(current_frame * droneBobSpeed) * droneBobHeight;
		xGoal = leader.x - lengthdir_x(distance, leader.gunangle + offset)
		yGoal = leader.y - lengthdir_y(distance, leader.gunangle + offset)
	} else {
		if(instance_exists(_nearestBullet)){
			x += approach(x, xGoal, flightspeed, current_time_scale);
			y += approach(y, yGoal, flightspeed, current_time_scale);
			xGoal = _nearestBullet.x;
			yGoal = _nearestBullet.y;
		}
	}
	
	 // Return Cooldown:
	if(returnCooldown > 0){
		returnCooldown -= current_time_scale;
	}
	
	 // Tilt n' Tumble:
	tilt = ((leader.speed * 4) * -right);

	 // Flip:
	right = (leader.gunangle + 270) mod 360 > 180 ? 1 : -1;
	
	 // Spawn Hitbox:
	if(wantHitbox = true){
		if(!instance_exists(droneHitbox)){
			droneHitbox	= EuphoriaDroneHitbox_create(x, y, self);
		}
	}

#define EuphoriaDrone_endstep
	if(imDoingIt = true){
		with(generic_trail_create(x, y)){
			depth			= other.depth + 1;
			image_xscale	= point_distance(x, y, other.xprevious, other.yprevious)
			image_yscale   *= 3;
			image_speed    *= 4;
			image_angle 	= point_direction(x, y, other.xprevious, other.yprevious)
			image_blend 	= other.trailColor;		
		}
	}

#define EuphoriaDroneHitbox_create(_x, _y, _creator)
	with(instance_create(_x, _y, CustomSlash)){
		
		sprite_index	= mskNone; //global.mskAugmentEuphoriaDroneHitbox;
		creator			= _creator;
		team			= _creator.team;
		mask_index		= global.mskAugmentEuphoriaDroneHitbox;
		damage			= 0;
		typ				= 0;
		ammo_type		= -1;
		prism_duplicate	= false;
		
		on_anim			= nothing;
		on_hit			= nothing;
		on_wall			= nothing;
		on_projectile	= EuphoriaDroneHitbox_projectile;
		on_grenade		= nothing;
		on_end_step		= EuphoriaDroneHitbox_endstep;
		on_destroy		= EuphoriaDroneHitbox_destroy;
	}

#define EuphoriaDroneHitbox_projectile
	if(instance_exists(self)) && (other.typ > 0){ 
		with(other){
			sound_play_pitchvol(sndPickupDisappear, 1.3 + random(0.2), 0.4)
			with instance_create(x, y, ImpactWrists){ 
				sprite_index = (global.settingGreenAugments ? global.sprGreenNull : global.sprNull);
			}
			instance_destroy();
		} 
	}
	
#define EuphoriaDroneHitbox_endstep
	if(!instance_exists(creator) || creator.wantHitbox = false){ instance_destroy(); exit; }
	x = creator.x
	y = creator.y

#define EuphoriaDroneHitbox_destroy
	if(instance_exists(creator)){
		creator.droneHitbox = noone;
	}
	
#define EuphoriaDrone_draw
	draw_sprite_ext(sprite_index, image_index, x, y, image_xscale * right, image_yscale, tilt, image_blend, 1);

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
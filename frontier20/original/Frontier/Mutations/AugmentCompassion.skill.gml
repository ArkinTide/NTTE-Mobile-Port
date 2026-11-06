#define init

	 // Sprites:
	global.sprSkillIcon 					= sprite_add("../sprites/mutations/sprAugmentCompassion.png", 1, 12, 16);
	global.sprSkillHud  					= sprite_add("../sprites/mutations/sprAugmentCompassionIcon.png", 1, 8, 9);
	
	global.sprShockRadius					= sprite_add("../sprites/projectiles/sprAugmentCompassionShock.png",	4, 35, 45);
	global.sprNull							= sprite_add("../sprites/particles/sprAugmentSharpTeethNull.png",		3, 8, 8);
	global.sprAugmentDroneCompassion		= sprite_add("../sprites/areas/hq/sprAugmentDroneCompassion.png",		2, 6, 6);
	
	global.sprGreenShockRadius				= sprite_add("../sprites/projectiles/sprGreenAugmentCompassionShock.png",	4, 35, 45);
	global.sprGreenNull						= sprite_add("../sprites/particles/sprGreenAugmentSharpTeethNull.png",		3, 8, 8);
	global.sprGreenAugmentDroneCompassion	= sprite_add("../sprites/areas/hq/sprGreenAugmentDroneCompassion.png",		2, 6, 6);
	
	global.settingGreenAugments				= false;
	
	 // LIB:
	while(!mod_exists("mod", "lib")){wait(1);}
	script_ref_call(["mod", "lib", "getRef"], "skill", mod_current, "scr");
	#macro  scr			global.scr
	#macro  call		script_ref_call
	
#define skill_name			return loc("Frontier:AugmentCompassion:0", "ATTENDANT DRONE 'HYPERION'");
#define skill_text			return loc("Frontier:AugmentCompassion:1", "@wPETS @sGAIN A @(color:16776960)SHOCKWAVE DRONE");
#define skill_tip			return "A PET FOR YOUR PET";
#define skill_button		sprite_index = global.sprSkillIcon;
#define skill_icon			return global.sprSkillHud;
#define skill_avail			return (mod_variable_get("mod", "Frontier_IDPD", "settingMainPoolAugments") = true) ? mod_exists("skill", skill_augment()) * 1 : 0;
#define skill_wepspec		return 0;
#define skill_sacrifice		return false;
#define skill_augment		return "compassion"; 

#define skill_lose
	with(instances_matching(CustomSlash, "name", "fr_compassiondrone")){
		with(instance_create(x, y, ImpactWrists)){
			image_blend	= (global.settingGreenAugments ? make_colour_rgb(0, 255, 0) : make_colour_rgb(0, 255, 255));
		}
		instance_destroy();
	}

#define step
	with(instances_matching(CustomHitme, "name", "NTTEPet")){
		if("fr_augmentCompassion" not in self){
			fr_augmentCompassion = noone;
		}
		if(!instance_exists(fr_augmentCompassion)){
			if(leader != noone){
				fr_augmentCompassion = CompassionDrone_create(x, y, self);
			}
		}
	}

#define CompassionDrone_create(_x, _y, _pet)
	with(instance_create(_x, _y, CustomSlash)){
		name = "fr_compassiondrone";
		
		sprite_index	= (global.settingGreenAugments ? global.sprGreenAugmentDroneCompassion : global.sprAugmentDroneCompassion);
		image_index		= 0;
		image_speed		= 0;
		rotSpeed		= 9;
		image_angle		= 0;
		
		owner			= _pet;
		angle			= random(360);
		dist			= 20;
		orbitSpeed		= 6;
		prevOwnerHealth	= owner.my_health;
		shockCooldown	= 0;
		
		team			= 2//owner.team;
		
		on_anim			= nothing;
		on_end_step		= CompassionDrone_endstep;
		on_wall			= nothing;
		on_hit			= nothing;
		on_projectile	= DroneShock_nullify;
		
		with instance_create(x + lengthdir_x(dist, angle), y + lengthdir_y(dist, angle), BulletHit){ 
			sprite_index	= (global.settingGreenAugments ? global.sprGreenNull : global.sprNull);
			depth			= other.depth - 1;
		}
		
		return self;
	}
	
#define CompassionDrone_endstep
	if(!instance_exists(owner) || owner.leader = noone){
		instance_destroy();
		exit;
	}
	
	angle		+= orbitSpeed * current_time_scale;
	
	image_angle += rotSpeed * current_time_scale;
	
	xprevious	= owner.x + lengthdir_x(dist, angle);
	yprevious	= owner.y + lengthdir_y(dist, angle);
	x 			= owner.x + lengthdir_x(dist, angle);
	y 			= owner.y + lengthdir_y(dist, angle);
	
	 // Shock on hurt:
	if(owner.my_health < prevOwnerHealth){
		DroneShock_create(x, y, 1);
	}
	
	if(shockCooldown <= 5){
		image_index	= 0;
	}
	
	if(shockCooldown <= 0){

		var _nearestProjectile = call(scr.instance_nearest_array, x, y, instances_matching_ne(instances_matching_ne(projectile, "typ", 0), "team", team));
		if(distance_to_object(enemy) < 48 || distance_to_object(_nearestProjectile) < 64){
			DroneShock_create(x, y, 0.8);
			shockCooldown = 45;
			image_index	= 1;
		}
	}
	
	prevOwnerHealth = owner.my_health;
	shockCooldown -= current_time_scale;

#define DroneShock_create(_x, _y, _maxSize)
//	sound_play_pitchvol(sndLightningHit, 1.2 + random(0.2), 0.7);

	with instance_create(x, y, CustomSlash){
		sprite_index	= (global.settingGreenAugments ? global.sprGreenShockRadius : global.sprShockRadius);
		depth			= -3;
		image_xscale	= 0;
		image_yscale	= 0;
		image_speed		= 0.5;
		image_alpha		= 0;
		image_angle		= random(360);
		image_index		= irandom(image_number);
		fr_bloom		= [1.1, 0.1];
		
		
		damage			= 3;
		creator			= other;
		team			= creator.team;
		typ				= 0;
		maxSize			= _maxSize;
		
		on_anim			= nothing;
		on_end_step		= DroneShock_endstep;
		on_wall			= nothing;
		on_hit			= DroneShock_hit;
		on_projectile	= DroneShock_nullify;
		
		return self;
	}
	
#define DroneShock_endstep
	if(instance_exists(creator)){
		x = creator.x;
		y = creator.y;
	}
	

	image_angle += 4 * current_time_scale;

	if(image_xscale >= maxSize){
		image_alpha -= 0.05 * current_time_scale;
		if(image_alpha <= 0){
			instance_destroy();
			exit;
		}
	} else {
		image_alpha	 += (0.1 / skill_get(mod_current));
		image_xscale += (0.1 / skill_get(mod_current));
		image_yscale = image_xscale;
	}
	
#define DroneShock_nullify
	if(instance_exists(self)) && (other.typ > 0){ 
		with(other){
			sound_play_pitchvol(sndPickupDisappear, 1.3 + random(0.2), 0.4)
			with instance_create(x, y, BulletHit){ 
				sprite_index = (global.settingGreenAugments ? global.sprGreenNull : global.sprNull);
			}
			instance_destroy();
		} 
	}

#define DroneShock_hit
	if(projectile_canhit_melee(other)){
		projectile_hit(other, damage);
	}
	
#define nothing
 // holy crap
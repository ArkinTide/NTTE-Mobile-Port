#define init

	 // Sprites:
	global.sprSkillIcon 					= sprite_add("../sprites/mutations/sprAugmentLastWish.png", 1, 12, 16);
	global.sprSkillHud  					= sprite_add("../sprites/mutations/sprAugmentLastWishIcon.png", 1, 8, 10);
	global.sprRationerChest					= sprite_add("../sprites/areas/hq/sprRationerChest.png", 3, 16, 16);
	global.sprRationerChestGlow				= sprite_add("../sprites/areas/hq/sprRationerChestGlow.png", 3, 16, 16);
	global.sprRationerProc					= sprite_add("../sprites/particles/sprAugmentRationerProc.png", 3, 8, 8);
	
	global.sprGreenRationerProc				= sprite_add("../sprites/particles/sprGreenAugmentRationerProc.png", 3, 8, 8);
	
	global.level_start						= (instance_exists(GenCont) || instance_exists(Menu));
	global.storedHPPickups					= 0;
	global.storedAmmoPickups				= 0;
	global.storedTotalPickups				= 0;
	global.procced							= true;
	global.procTime							= 0;
	
	global.settingGreenAugments				= false;

	 // LIB:
	while(!mod_exists("mod", "lib")){wait(1);}
	script_ref_call(["mod", "lib", "getRef"], "skill", mod_current, "scr");
	#macro  scr			global.scr
	#macro  call		script_ref_call
	
#define skill_name			return loc("Frontier:AugmentLastWish:0", "RATIONER");
#define skill_text			return loc("Frontier:AugmentLastWish:1", "@(color:16776960)DUPLICATE @wAND @(color:16776960)STORE @wSOME#PICKUPS @sFOR THE @wNEXT @sLEVEL");
#define skill_tip			return "AMMO MANAGEMENT IS IMPORTANT!";
#define skill_button		sprite_index = global.sprSkillIcon;
#define skill_icon			return global.sprSkillHud;
#define skill_avail			return (mod_variable_get("mod", "Frontier_IDPD", "settingMainPoolAugments") = true) ? 1 : 0;
#define skill_wepspec		return 0;
#define skill_sacrifice		return false;
#define skill_augment		return mut_last_wish;

#define game_start
	global.storedHPPickups					= 0;
	global.storedAmmoPickups				= 0;
	global.storedTotalPickups				= 0;

#define skill_lose
	global.storedHPPickups					= 0;
	global.storedAmmoPickups				= 0;
	global.storedTotalPickups				= 0;	
	
#define step

	 // Level Start:
	if(instance_exists(GenCont) || instance_exists(Menu)){
		global.level_start = true;
	}
	else if(global.level_start){
		global.level_start	= false;
		global.procced		= false;
		global.procTime 	= 12;
	}
	if(global.procTime > 0){
		global.procTime -= current_time_scale;
	}
	if(global.procced = false && global.procTime <= 0){
		global.procced = true
		with(call(scr.instance_random, Player)){ 
			if(global.storedTotalPickups > 0){
				with RationerChest_create(x, y){
					with(mod_script_call("mod", "Frontier_Objects", "ZAxisToss_create", x, y)){
						direction    = random(360);
						speed        = 2
						zspeed       = 4;
						zfriction	 = 0.7;
						creator      = other;
						depth        = other.depth;
						mask_index   = other.mask_index;
						if("spr_shadow_y" in other ){
							spr_shadow_y = other.spr_shadow_y;
						}
					}
				}
			}
		}
	}

	 // Store Health Pickups:
	with(instances_matching(HPPickup, "fr_rationer", null)){
		fr_rationer = false;
	}
	with(instances_matching(HPPickup, "fr_rationer", false)){
		if(distance_to_object(Player) < 12 || distance_to_object(Portal) < 12){
			fr_rationer = true;
			if(random(5) < 1){
				with instance_create(x, y, BulletHit){
					sprite_index = (global.settingGreenAugments ? global.sprGreenRationerProc : global.sprRationerProc);
				}
				global.storedHPPickups		+= 1;
				global.storedTotalPickups	+= 1;
			}
		}
	}
	
	 // Store Ammo Pickups:
	with(instances_matching(AmmoPickup, "fr_rationer", null)){
		fr_rationer = false;
	}
	with(instances_matching(AmmoPickup, "fr_rationer", false)){
		if(distance_to_object(Player) < 12){
			fr_rationer = true;
			if(random(5) < 1){
				with instance_create(x, y, BulletHit){
					sprite_index = (global.settingGreenAugments ? global.sprGreenRationerProc : global.sprRationerProc);
				}
				global.storedAmmoPickups	+= 1;
				global.storedTotalPickups	+= 1;
			}
		}
	}
	
#define RationerChest_create(_x, _y)
	with(instance_create(_x, _y, CustomObject)){
		sprite_index	= global.sprRationerChest;
		spr_glow		= global.sprRationerChestGlow;
		image_speed		= 0;
		
		 // Size Em Up:
		if(global.storedTotalPickups <= 10){
			image_index = 0;
		} else {
			image_index = 1;
		}
		if(global.storedTotalPickups >= 50){
			image_index = 2;
		}
		
		popTime			= 45;
		opened			= false;
		
		 // Events:
		on_step			= RationerChest_step;
		on_draw			= RationerChest_draw;
			
		return self;
	}

#define RationerChest_step
	if(popTime > 0){
		popTime -= current_time_scale;
	} else {
		if(opened = false){
			opened = true;
			
			 // Pickups:
			repeat(global.storedHPPickups * skill_get(mod_current)){
				with instance_create(x + random_range(-10, 10), y + random_range(-10, 10), HPPickup){
					fr_rationer = true;
				}
			}	
			repeat(global.storedAmmoPickups * skill_get(mod_current)){
				with instance_create(x + random_range(-10, 10), y + random_range(-10, 10), AmmoPickup){
					fr_rationer = true;
				}
			}	
			
			instance_create(x, y, PortalClear);
			
			global.storedHPPickups			= 0;
			global.storedAmmoPickups		= 0;
			global.storedTotalPickups		= 0;
			
			sound_play_pitch(sndAmmoChest, 1.3);
			sound_play_pitch(sndIDPDNadeAlmost, 1.3);
			
			repeat(10){ 
				with instance_create(x, y, Dust){
					direction	= random(360);
					speed		= random(3);
				}
			}
			
			instance_destroy();
		}
	}

#define RationerChest_draw
	draw_self();
	draw_sprite_ext(spr_glow, image_index, x, y, image_xscale, image_yscale, image_angle, make_colour_rgb(0, 255, 255), clamp(1 / popTime, 0, 1))


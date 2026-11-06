#define init

	 // LIB:
	while(!mod_exists("mod", "lib")){wait(1);}
	script_ref_call(["mod", "lib", "getRef"], "mod", mod_current, "scr");
	#macro  scr			global.scr
	#macro  call		script_ref_call

	    // SOUNDS //
	global.sndSlicerHurt					= sound_add("../sounds/enemies/deeplabs/sndSlicerHurt.ogg");  
	global.sndSlicerDead					= sound_add("../sounds/enemies/deeplabs/sndSlicerDead.ogg");  
	global.sndSlicerChrg					= sound_add("../sounds/enemies/deeplabs/sndSlicerChrg.ogg");  
	global.sndSlicerFire					= sound_add("../sounds/enemies/deeplabs/sndSlicerFire.ogg");  
	global.sndThrasherHurt					= sound_add("../sounds/enemies/deeplabs/sndThrasherHurt.ogg");  
	global.sndThrasherDead					= sound_add("../sounds/enemies/deeplabs/sndThrasherDead.ogg");  
	global.sndThrasherMele					= sound_add("../sounds/enemies/deeplabs/sndThrasherMele.ogg");  
	global.sndThrasherChrg					= sound_add("../sounds/enemies/deeplabs/sndThrasherChrg.ogg");  
	global.sndThrasherSpit					= sound_add("../sounds/enemies/deeplabs/sndThrasherSpit.ogg");  
	global.sndThrasherBubblePop				= sound_add("../sounds/enemies/deeplabs/sndThrasherBubblePop.ogg");  
	
	    // SPRITES // 
     // Thrashers:
	global.mskThrasher						= sprite_add("../sprites/enemies/Thrasher/mskThrasher.png",						1, 24, 24);
	global.sprThrasherIdle					= sprite_add("../sprites/enemies/Thrasher/sprThrasherIdle.png",					8, 24, 24);
	global.sprThrasherWalk					= sprite_add("../sprites/enemies/Thrasher/sprThrasherWalk.png",					6, 24, 24);
	global.sprThrasherHurt					= sprite_add("../sprites/enemies/Thrasher/sprThrasherHurt.png",					3, 24, 24);
	global.sprThrasherDead					= sprite_add("../sprites/enemies/Thrasher/sprThrasherDead.png",					7, 24, 24);
	global.sprThrasherTell					= sprite_add("../sprites/enemies/Thrasher/sprThrasherTell.png",					3, 24, 24);
	global.sprThrasherChrg					= sprite_add("../sprites/enemies/Thrasher/sprThrasherCharge.png",				4, 24, 24);
	global.sprThrasherSpit					= sprite_add("../sprites/enemies/Thrasher/sprThrasherSpit.png",					5, 24, 24);
	
	 // Slicers:
	global.sprSlicerIdle					= sprite_add("../sprites/enemies/Slicer/sprSlicerIdle.png",						10, 16, 16);
	global.sprSlicerWalk					= sprite_add("../sprites/enemies/Slicer/sprSlicerWalk.png",						6, 16, 16);
	global.sprSlicerHurt					= sprite_add("../sprites/enemies/Slicer/sprSlicerHurt.png",						3, 16, 16);
	global.sprSlicerDead					= sprite_add("../sprites/enemies/Slicer/sprSlicerDead.png",						6, 16, 16);
	global.sprSlicerFire					= sprite_add("../sprites/enemies/Slicer/sprSlicerFire.png",						7, 32, 16);
	
	 // Surgeons:
	global.sprSurgeonIdle					= sprite_add("../sprites/enemies/Surgeon/sprSurgeonIdle.png",					4, 16, 16);
	global.sprSurgeonWalk					= sprite_add("../sprites/enemies/Surgeon/sprSurgeonWalk.png",					6, 16, 16);
	global.sprSurgeonHurt					= sprite_add("../sprites/enemies/Surgeon/sprSurgeonHurt.png",					3, 16, 16);
	global.sprSurgeonDead					= sprite_add("../sprites/enemies/Surgeon/sprSurgeonDead.png",					6, 16, 16);
	global.sprSurgeonWeap					= sprite_add("../sprites/enemies/Surgeon/sprSurgeonWeap.png",					1, 6, 0);
	global.sprSurgeonWeapMelee				= sprite_add("../sprites/enemies/Surgeon/sprSurgeonWeapMelee.png",				1, 6, 0);
//	global.sprSurgeonLasersight				= sprite_add("../sprites/enemies/Surgeon/sprSurgeonLasersight.png",				1, 0, -2);

	 // Surgeon Minions:
	global.mskSurgeonMinion					= sprite_add("../sprites/enemies/SurgeonMinion/mskSurgeonMinion.png",			1, 16, 16);
	global.sprSurgeonMinion					= sprite_add("../sprites/enemies/SurgeonMinion/sprSurgeonMinion.png",			5, 16, 16);
	global.sprSurgeonMinionHurt				= sprite_add("../sprites/enemies/SurgeonMinion/sprSurgeonMinionHurt.png",		3, 16, 16);
	global.sprSurgeonMinionDead				= sprite_add("../sprites/enemies/SurgeonMinion/sprSurgeonMinionDead.png",		7, 16, 16);
	
	 // Deeplabs Pod Decal:
	global.sprDeeplabsPod					= sprite_add("../sprites/areas/palace/sprDeeplabsPod.png",						1, 32, 50);
	global.mskDeeplabsPod					= sprite_add("../sprites/areas/palace/mskDeeplabsPod.png",						1, 30, 14);
	
	 // Tube Objects:
	global.sprFishFreakDead					= sprite_add("../sprites/areas/deeplabs/props/tubeobjects/sprFishFreakDead.png", 6, 12, 12);
	
	 // Projectiles / Effects:
	global.mskGatorBubble					= sprite_add("../sprites/projectiles/mskGatorBubble.png",               		1, 32, 32);
	global.mskGatorBubbleSlowBox			= sprite_add("../sprites/projectiles/mskGatorBubbleSlowBox.png",               	1, 32, 32);
	global.sprGatorBubble  			        = sprite_add("../sprites/projectiles/sprGatorBubble.png",                       1, 32, 32);
	global.sprGatorBubblePop  			    = sprite_add("../sprites/projectiles/sprGatorBubblePop.png",                	4, 24, 24);
	global.sprGatorBubbleTrail  			= sprite_add("../sprites/particles/sprGatorBubbleTrail.png",                	5, 6, 6);
	global.sprRavenSlicer  			    	= sprite_add("../sprites/projectiles/sprRavenSlicer.png",                		1, 8, 8);
	global.sprRavenSlicerTrail  			= sprite_add("../sprites/particles/sprRavenSlicerTrail.png",                	3, 3, 3);
//	global.sprSurgeonBullet  				= sprite_add("../sprites/projectiles/sprSurgeonBullet.png",                		6, 8, 8);
//	global.sprSurgeonBulletTrail  			= sprite_add("../sprites/particles/sprSurgeonBulletTrail.png",                	3, 3, 3);
//	global.sprSurgeonBulletHit 				= sprite_add("../sprites/projectiles/sprSurgeonBulletHit.png",                	4, 8, 8);
	global.sprSoulSmoke				    	= sprite_add("../sprites/particles/sprSoulSmoke.png",                       	5, 12, 12);
	
	#macro subjectFollowRange				104
	#macro subjectNodeRange					320

#define TestSubject_create(_x, _y)
	with(instance_create(_x, _y, CustomHitme)){
   
    	name = "Test Subject"
    	
         // Visuals: 
        spr_idle		= sprGatorIdle;
		spr_walk		= sprGatorWalk;
		spr_hurt		= sprGatorHurt;
		spr_dead		= sprGatorDead;
		sprite_index    = spr_idle;
		image_speed     = 0.4;
		depth           = -2;
		hitid           = [spr_idle, "TEST SUBJECT"]
        spr_shadow      = shd24;	
        spr_shadow_y	= 0;
        
         // Sounds:
        snd_hurt		= sndRavenHit;
        snd_dead		= sndRavenDie;
        
         // Vars:
        mask_index  	= mskPlayer;
        direction   	= random(360);
        maxhealth   	= 24;
       	my_health   	= maxhealth;
        raddrop     	= 8;
        maxspeed    	= 4.5;
        walkspeed   	= maxspeed;
        size			= 2;
        canmelee    	= false;
        team        	= 9910; 
        targetvisible	= 0;
        target      	= 0;
        walk        	= 0;
        friction		= 0.4;
        gunangle		= 0;
        
        goalX			= null;
        goalY			= null;
        nodding			= false;
        desiredNode		= -1;
        currentNode		= -1;
        currentNodeNum	= -1;
        nodeDirection	= 1;
        fr_trapImmune	= true;
        regenTime		= 60;
        
        imSafe			= false;
        
        
         // Alarms:
        alarm1 = 30 + irandom(10);
        alarm2 = 0;

         // Events:
        on_step 	= script_ref_create(TestSubject_step);
        on_end_step = TestSubject_endstep;
        on_draw 	= BasicEnemy_draw;
        on_hurt 	= Enemy_hurt;
        on_destroy	= TestSubject_death;
        on_alrm1	= script_ref_create(TestSubject_alrm1);
        
        return self;
	}
	
#define TestSubject_step

	 // Alarms:
	if("on_alrm1" in self and alarm1_run) exit;

	 // Movement:
	if(walk > 0){ 
		walk -= current_time_scale;   
		speed += walkspeed * current_time_scale;   
		gunangle = direction; 
	}
	if(speed > maxspeed){ 
		speed = maxspeed; 
	}
	
	if(nodding = true){
		if(distance_to_object(Player) < subjectFollowRange + 16){
			nodding = false;
			currentNodeNum	= -1;
			currentNode		= -1;
			desiredNode		= null;
		}
		if(distance_to_object(currentNode) <= 4){
			if(currentNode != desiredNode){
				currentNode	= call(scr.instance_nearest_array, x, y, instances_matching(CustomObject, "fr_subjectNode", currentNodeNum + nodeDirection));
				currentNodeNum = currentNode.fr_subjectNode;
			} else {
				nodding = false;
				currentNodeNum	= -1;
				currentNode		= -1;
				desiredNode		= null;
			}
		}
	}
	
	if(my_health < maxhealth){
		if(regenTime > 0){
			regenTime -= current_time_scale;
		} else {
			my_health += 1;
			regenTime += 75;
		}
	}
	

		 // Animate:
	sprite_index	= enemy_sprite;
	right = (gunangle + 270) mod 360 > 180 ? 1 : -1;
	
	if(my_health <= 0){
		instance_destroy();
	}
	
#define TestSubject_endstep
		// wall collisions:
    if(place_meeting(x, y, InvisiWall)){
        x = xprevious;
        y = yprevious;
        var f = friction;
        if(place_meeting(x + hspeed, y, InvisiWall)) hspeed *= -1;
        if(place_meeting(x, y + vspeed, InvisiWall)) vspeed *= -1;
        while(hspeed != 0 && place_meeting(x + hspeed, y, InvisiWall)) hspeed -= clamp(hspeed, -f, f);
        while(vspeed != 0 && place_meeting(x, y + vspeed, InvisiWall)) vspeed -= clamp(vspeed, -f, f);
    }
    if(place_meeting(x, y, Wall)){
        x = xprevious;
        y = yprevious;
        var f = friction;
        if(place_meeting(x + hspeed, y, Wall)) hspeed *= -1;
        if(place_meeting(x, y + vspeed, Wall)) vspeed *= -1;
        while(hspeed != 0 && place_meeting(x + hspeed, y, Wall)) hspeed -= clamp(hspeed, -f, f);
        while(vspeed != 0 && place_meeting(x, y + vspeed, Wall)) vspeed -= clamp(vspeed, -f, f);
    }
  
#define TestSubject_alrm1
	alarm1 = 10 + irandom(20);
	 
	if(nodding = false){
		if(enemy_target(x, y)){
			if(target_distance > subjectFollowRange){
				if(target_distance > subjectNodeRange || collision_line(x, y, target.x, target.y, InvisiWall, false, false)){
					
					nodding = true;
					
					 // find nearest node to player:
					var _player = instance_nearest(x, y, Player);
					var _node = call(scr.instance_nearest_array, _player.x, _player.y, instances_matching(CustomObject, "name", "fr_subjectNode"));
					var _nearestNode = call(scr.instance_nearest_array, x, y, instances_matching(CustomObject, "name", "fr_subjectNode"));
					
					 // end goal:
					desiredNode 	= _node;
					currentNode		= _nearestNode;
					currentNodeNum	= _nearestNode.fr_subjectNode;
					
					nodeDirection	= currentNodeNum < desiredNode.fr_subjectNode ? 1 : -1;
					
					alarm1 = 8;
					
				} else {
					enemy_look(target_direction);
					
					alarm1 = 20 + irandom(15);
					enemy_walk(target_direction + orandom(30), alarm1);
				}
			} 		
		} else {
			 // Wander:
			if(chance(1, 3)){
				alarm1 = 40 + irandom(15);
				enemy_walk(random(360), alarm1 - 10);
				enemy_look(direction);
			}
		}
	} else {
		direction = point_direction(x, y, currentNode.x, currentNode.y);
		gunangle = direction;
		alarm1	= 4;
		enemy_walk(direction, alarm1);
		enemy_face(direction);

	}
	
#define TestSubject_death
	repeat(6 + irandom(4)){
		with(instance_create(x, y, Feather)){
			sprite_index	= sprRavenFeather;
		}
	}
	pickup_drop(55, 0)
	
	with(instance_create(x, y, Corpse)){
		size         = other.size;
		sprite_index = other.spr_dead;
		image_xscale = (("right" in other) ? other.right : other.image_xscale);
		direction    = other.direction;
		speed        = other.speed;

		mask_index = other.mask_index;
		speed += max(0, -other.my_health / 5);
		speed += 8 * skill_get(mut_impact_wrists);

		 // Clamp Speed:
		speed = min(speed, 16);
		
		return self;
	}
	
#define DeeplabsPodDecal_create(_x, _y)
	with(instance_create(_x, _y, CustomObject)){
		sprite_index	= global.sprDeeplabsPod;
		mask_index		= global.mskDeeplabsPod;
		
		depth			= -9;
		
		on_step 		= DeeplabsPodDecal_step;
		
		 // Relocate:
		 // I stole the orginal code from nt:te... thank you... ..  
		var	_xoff  = (sprite_get_xoffset(mask_index) - ((sprite_get_bbox_left(mask_index) + sprite_get_bbox_right(mask_index) + 1) / 2)) * image_xscale,
			_yoff  = (sprite_get_yoffset(mask_index) - ((sprite_get_bbox_top(mask_index) + sprite_get_bbox_bottom(mask_index) + 1) / 2)) * image_yscale,
			_dis   = 48,
			_dir   = random(360),
			_tries = 20;
		
		
		with(call(scr.instance_nearest_bbox, 10016, 10016, Floor)){
			var _top = instance_nearest(x, y, Floor);
			_dir = point_direction(bbox_center_x, bbox_center_y, _top.x, _top.y);
		}
		
		x = pround(_x, 16) + _xoff;
		y = pround(_y, 16) + _yoff;
		
		while(
			_tries-- > 0
			&& (
				place_meeting(x, y, Floor)       ||
				place_meeting(x, y, Bones)       ||
				place_meeting(x, y, TopPot)      ||
				place_meeting(x, y, PortalClear) ||
				place_meeting(x, y, CustomObject)
			)
		){
			x = pround(x - _xoff + lengthdir_x(_dis, _dir), 16) + _xoff;
			y = pround(y - _yoff + lengthdir_y(_dis, _dir), 16) + _yoff;
		}

		
		return self;
	}
	
#define DeeplabsPodDecal_step
	if(current_frame_active){
		if(random(3) < 1){
			with(instance_create(x + 28, y + 20, Dust)){
				fr_fadesmoke	= true;
				sprite_index	= sprSmoke;
				direction		= 90;
				speed			= 3 
				friction		= -0.1;
				depth			= -10;
				growspeed		= 0.10;
				fr_fadesmoke	= true;
			}
		}
		if(random(3) < 1){
			with(instance_create(x + 6, y - 16, Dust)){
				fr_fadesmoke	= true;
				sprite_index	= sprSmoke;
				direction		= 90;
				speed			= 3 
				friction		= -0.1;
				depth			= -7;
				growspeed		= 0.10;
				fr_fadesmoke	= true;
			}
		}
	}
	
	with(instances_matching(Dust, "fr_fadesmoke", true)){
		image_alpha	-= 0.07;
	}
	
	
	if(place_meeting(x, y, Floor)){
		repeat(8){
			with(instance_create(x, y, Explosion)){
				depth	= -12;
				damage	= 0;
				hitid	= [sprExplosion, "HOW"]
			}
		}
		
		sound_play(sndExplosionCar);
		instance_destroy();
	}
	
	
//#region DEEPLABS ENEMIES
#define GatorAmalgam_create(_x, _y)
	with(instance_create(_x, _y + 8, CustomEnemy)){
   
    	name = "Thrasher"
    	
        // Visuals: 
        spr_idle		= global.sprThrasherIdle;
		spr_walk		= global.sprThrasherWalk;
		spr_hurt		= global.sprThrasherHurt;
		spr_dead		= global.sprThrasherDead;
		spr_tell		= global.sprThrasherTell;
		spr_chrg		= global.sprThrasherChrg;
		spr_fire		= global.sprThrasherSpit;
		sprite_index    = spr_idle;
		image_speed     = 0.4;
		depth           = -2;
		hitid           = [spr_idle, "THRASHER"]
        spr_shadow      = shd64;	
        spr_shadow_y	= -1;
        nts_color_blood = [make_color_rgb(96, 59, 52), c_black]
        
        // Sounds:
        snd_hurt		= global.sndThrasherHurt;
        snd_dead		= global.sndThrasherDead;
        snd_mele		= global.sndThrasherMele;
        snd_chrg		= global.sndThrasherChrg;
        snd_spit		= global.sndThrasherSpit;
        
        // Vars:
        mask_index  	= global.mskThrasher;
        direction   	= random(360);
        maxhealth   	= 48;
       	my_health   	= maxhealth;
        raddrop     	= 4;
        maxspeed    	= 2;
        walkspeed   	= maxspeed;
        size			= 3;
        canmelee    	= true;
        meleedamage		= 4;
        team        	= 1; 
        targetvisible	= 0;
        target      	= 0;
        walk        	= 0;
        gunangle		= 0;
        charge			= 0;
        charge_wait		= 0;
        charge_dir		= 0;
        charge_speed	= 0;
        myBubble		= noone;
        fr_bubblePopper = true;
        
        // Alarms:
        alarm1 = 20 + irandom(10);

        // Scripts:
        on_step  = script_ref_create(GatorAmalgam_step);
        on_draw  = BasicEnemy_draw;
        on_hurt  = Enemy_hurt;
        on_death = GatorAmalgam_death;
        on_alrm1 = script_ref_create(GatorAmalgam_alrm1);
        
        return self;
	}
	
#define GatorAmalgam_step

	 // Alarms:
	if("on_alrm1" in self and alarm1_run) exit;

		// Movement:
	if(walk > 0){ 
		walk	-= current_time_scale;   
		speed	+= walkspeed * current_time_scale;   
	}
	
		// Speed Cap:
	if(speed > maxspeed){ 
		speed = maxspeed; 
	}

		 // Animate:
	if(sprite_index != spr_chrg && sprite_index != spr_tell && sprite_index != spr_fire || anim_end){
		sprite_index = enemy_sprite;
	}
	
		// Charging:
	if(charge > 0 || charge_wait > 0){
		direction = charge_dir;
		enemy_look(direction);
	}
	if(charge_wait > 0){
		charge_wait -= current_time_scale;
		
		x += (orandom(1) - lengthdir_x(charge_wait / 10, charge_dir)) * current_time_scale;
		y += (orandom(1) - lengthdir_y(charge_wait / 10, charge_dir)) * current_time_scale;
		if(sprite_index != spr_hurt){
			sprite_index = spr_tell;
		}
		
		 // Start Charge:
		if(charge_wait <= 0){
			sound_play_pitchvol(snd_chrg, 0.9 + random(0.2), 0.7);
		}
	}
	else if(charge > 0){
		var _nearestBubble	= call(scr.instance_nearest_array, x, y, instances_matching(CustomProjectile, "name", "fr_GatorBubble"));
		
		 // Pop Bubbles:
		if(place_meeting(x, y, _nearestBubble)){
			with(_nearestBubble){
				if(image_xscale >= maxSize){
					powerPopped = true;
					instance_destroy();
				}
			}
		}
		
		 // SLOW DOWN ! 
		charge_speed -= (0.10 * current_time_scale);
		if(charge_speed <= 0){
			charge		= 0;
			image_index	= 7;
		}
		
		 // MOVE!:
		motion_add(direction, charge_speed);
		enemy_look(direction);
		
		 // Sprite:
		if(sprite_index != spr_hurt){
			sprite_index = spr_chrg;
		}
		
		 // Dust:
		with(instance_create(x, y, Dust)){
		//	sprite_index	= global.sprWhiteSmoke;
			image_xscale	= 0.5;
			image_yscale	= image_xscale;
		}

		 // Wall Bounce:
		if(place_meeting(x + hspeed_raw, y + vspeed_raw, Wall) || place_meeting(x + hspeed_raw, y + vspeed_raw, InvisiWall)){
			charge_speed	= 0;
			charge			= 0;
			image_index		= 7;
			
			with(instance_create(x, y, PortalClear)){
				image_xscale	= 0.8;
				image_yscale	= 0.8;
			}
			
			sound_play_pitch(sndBouncerBounce, 0.7 + random(0.1))
			instance_create(x, y, Dust);
		}
	}
	
		//Use Your Eyes:
	right = (direction + 270) mod 360 > 180 ? 1 : -1;

#define GatorAmalgam_alrm1
	alarm1 = 40 + irandom(10);

	var _bubbleCount	= array_length(instances_matching(projectile, "name", "fr_GatorBubble")),
		_nearestBubble	= call(scr.instance_nearest_array, x, y, instances_matching(projectile, "name", "fr_GatorBubble"));

	if(enemy_target(x, y) && target_visible){
		 // In attack Range:
		if(target_distance < 144 && chance(4, 5)){
			var _spitBubble = true;
			
			 // less likely to do bubble when close:
			if(target_distance < 72 && chance(1, 3)){
				_spitBubble = false;
			}
			
			 // Spit Bubble:
			if(!instance_exists(myBubble) && chance(2, 3) && _spitBubble = true){
				alarm1			= 10;
				image_index		= 0;
				sprite_index	= spr_fire;
				gunangle		= target_direction;
				direction		= target_direction;
				with(GatorBubble_create(x, y)){
					direction		= other.gunangle + random_range(-15, 15);
					speed			= 10;
					other.myBubble	= self;
					team			= other.team;
					creator 		= other;
				}
				
				sound_play_pitch(snd_spit, 0.9 + random(0.2))
				
				repeat(5){
			    	with(instance_create(x + random_range(-16, 16), y + random_range(-16, 16), PlasmaTrail)){
			    		sprite_index	= global.sprGatorBubbleTrail;
			    		depth			= other.depth - 1;
			    		image_index		= choose(0, 1);
			    		direction		= other.gunangle + random_range(-30, 30)
			    		image_angle		= random(360);
			    		speed			= 1 + random(1);
			    	}	
				}
			 // Charge!!
			} else {
				var _validDir	= (_bubbleCount > 0 && distance_to_object(_nearestBubble) < 144) ? choose(point_direction(x, y, _nearestBubble.x, _nearestBubble.y), target_direction, target_direction) : target_direction;
				charge_dir		= _validDir;
				charge			= 30;
				charge_wait 	= 10;
				charge_speed	= 6.5;
				alarm1      	= (charge + charge_wait) + 30;
			}
		} else {
			 // Move Towards Target
			if(chance(2, 3)){
				enemy_walk(target_direction + random_range(-20, 20), alarm1);
			}			
		}
	}
	
	 // Wander Around Town:
	else{
		enemy_walk(random(360), alarm1);
		enemy_look(direction);
	}
	
#define GatorAmalgam_death
	pickup_drop(45, 8)

#define RavenAmalgam_create(_x, _y)
	with(instance_create(_x, _y, CustomEnemy)){
   
    	name = "Slicer"
    	
         // Visuals: 
        spr_idle		= global.sprSlicerIdle;
		spr_walk		= global.sprSlicerWalk;
		spr_hurt		= global.sprSlicerHurt;
		spr_dead		= global.sprSlicerDead;
		spr_fire		= global.sprSlicerFire;
		sprite_index    = spr_idle;
		image_speed     = 0.4;
		depth           = -2;
		hitid           = [spr_idle, "SLICER"]
        spr_shadow      = shd32;	
        spr_shadow_y	= 3;
        nts_color_blood = [c_red, make_color_rgb(134, 44, 35)]
        
         // Sounds:
        snd_hurt		= global.sndSlicerHurt;
        snd_dead		= global.sndSlicerDead;
        
         // Vars:
        mask_index  	= mskBandit;
        direction   	= random(360);
        maxhealth   	= 24;
       	my_health   	= maxhealth;
        raddrop     	= 8;
        maxspeed    	= 3;
        walkspeed   	= maxspeed;
        size			= 3;
        canmelee    	= true;
        meleedamage		= 2;
        team        	= 1; 
        targetvisible	= 0;
        target      	= 0;
        walk        	= 0;
        gunangle		= 0;
        
         // Alarms:
        alarm1 = 30 + irandom(10);
        alarm2 = 0;

         // Events:
        on_step  = script_ref_create(RavenAmalgam_step);
        on_draw  = BasicEnemy_draw;
        on_hurt  = Enemy_hurt;
        on_death = RavenAmalgam_death;
        on_alrm1 = script_ref_create(RavenAmalgam_alrm1);
        on_alrm2 = script_ref_create(RavenAmalgam_alrm2);
        
        return self;
	}

#define RavenAmalgam_step

	 // Alarms:
	if("on_alrm1" in self and alarm1_run) exit;
	if("on_alrm2" in self and alarm2_run) exit;

	 // Movement:
	if(walk > 0){ 
		walk -= current_time_scale;   
		speed += walkspeed * current_time_scale;   
		gunangle = direction; 
	}
	if(speed > maxspeed){ 
		speed = maxspeed; 
	}
	
		 // Animate:
	if(sprite_index != spr_fire || anim_end){
		sprite_index = enemy_sprite;
	}
	right = (gunangle + 270) mod 360 > 180 ? 1 : -1;
	
#define RavenAmalgam_alrm1
	alarm1 = 30 + irandom(20);
	 
	if(enemy_target(x, y) && target_visible){
		enemy_look(target_direction);
		
		if(target_distance > 144){
			alarm1 = 20 + irandom(15);
			enemy_walk(target_direction + orandom(30), alarm1);
		} else {
			 // Attack:
			if(chance(2, 3)){
				alarm1 = 80 + irandom(20);
				alarm2 = 6;

				sound_play_pitch(global.sndSlicerChrg, 0.9 + random(0.2));
	
				gunangle		= target_direction;
				sprite_index	= spr_fire;
				image_index		= 0;
		
			} else {
				alarm1 = 20 + irandom(15);
				enemy_walk(random(360), alarm1)
			}
		}			
	} else {
		 // Wander:
		if(chance(1, 3)){
			alarm1 = 40 + irandom(15);
			enemy_walk(random(360), alarm1 - 10);
			enemy_look(direction);
		}
	}
	
#define RavenAmalgam_alrm2
	if(instance_exists(target)){
		gunangle = target_direction;
	}

	 // Sound:
	sound_play_pitch(global.sndSlicerFire, 0.9 + random(0.2));

	 // Projectile:
	var _spread = -24;
	repeat(3){
		with(RavenSlicer_create(x, y)){
			team		= other.team;
			creator 	= other;
			hitid		= other.hitid;
			direction	= other.gunangle + _spread;
			image_angle	= direction;
		}
		_spread += 24;
	}
	
#define RavenAmalgam_death
	repeat(6 + irandom(4)){
		with(instance_create(x, y, Feather)){
			sprite_index	= sprRavenFeather;
		}
	}
	pickup_drop(55, 0)
	
#define MothAmalgam_create(_x, _y)
	with(instance_create(_x, _y, CustomEnemy)){
   
    	name = "Seer"
    	
         // Visuals: 
        spr_idle		= sprNecromancerIdle;
		spr_walk		= sprNecromancerWalk;
		spr_hurt		= sprNecromancerHurt;
		spr_dead		= sprNecromancerDead;
		spr_fire		= sprRhinoFreakIdle;
		sprite_index    = spr_idle;
		image_speed     = 0.4;
		depth           = -2;
		hitid           = [spr_idle, "SEER"]
        spr_shadow      = shd24;	
        spr_shadow_y	= 1;
        nts_color_blood = [c_red, make_color_rgb(134, 44, 35)]
        
         // temp:
        image_blend		= c_yellow;
        
         // Sounds:
        snd_hurt		= sndNecromancerHurt;
        snd_dead		= sndNecromancerDead;
        
         // Vars:
        mask_index  	= mskBandit;
        direction   	= random(360);
        maxhealth   	= 15;
       	my_health   	= maxhealth;
        raddrop     	= 6;
        maxspeed    	= 2.5;
        walkspeed   	= maxspeed;
        size			= 1;
        canmelee    	= false;
        team        	= 1; 
        targetvisible	= 0;
        target      	= 0;
        walk        	= 0;
        gunangle		= 0;
        
         // Alarms:
        alarm1 = 30 + irandom(10);
        alarm2 = 0;

         // Events:
        on_step  = script_ref_create(MothAmalgam_step);
        on_draw  = BasicEnemy_draw;
        on_hurt  = Enemy_hurt;
        on_death = MothAmalgam_death;
        on_alrm1 = script_ref_create(MothAmalgam_alrm1);
        
        return self;
	}

#define MothAmalgam_step

	 // Alarms:
	if("on_alrm1" in self and alarm1_run) exit;

	 // Movement:
	if(walk > 0){ 
		walk -= current_time_scale;   
		speed += walkspeed * current_time_scale;   
		gunangle = direction; 
	}
	if(speed > maxspeed){ 
		speed = maxspeed; 
	}
	
		 // Animate:
	if(sprite_index != spr_fire || anim_end){
		sprite_index = enemy_sprite;
	}
	right = (gunangle + 270) mod 360 > 180 ? 1 : -1;
	
#define MothAmalgam_alrm1
	alarm1 = 30 + irandom(20);
	 
	if(enemy_target(x, y)){
		enemy_look(target_direction);
		
		if(target_distance > 192){
			alarm1 = 30 + irandom(15);
			enemy_walk(target_direction + orandom(30), alarm1 - 10);
		} else {
			if((target_distance > 32)){
				 // Attack:
				if(chance(1, 3)){
					alarm1 = 100 + irandom(20);
	
					gunangle		= target_direction;
					sprite_index	= spr_fire;
			
		    		 // Sound:
		    		sound_play_pitch(sndGrenadeRifle, 1.3 + random(0.2));
		    			
		    		 // Kick:
		    		wkick = 12;
		    
		    		 // Projectile:
		    		/*
		    		with(Mothball_create(x, y)){
		    			team		= other.team;
		    			creator 	= other;
		    			hitid		= other.hitid;
		    			direction	= other.gunangle;
		    			image_angle	= direction;
		    		}
		    		*/
		    		
	    			 // Particles:
					repeat(12){
						with instance_create(x + lengthdir_x(10, other.gunangle), y + lengthdir_y(10, other.gunangle), Smoke){
							sprite_index	= sprSmoke;
							image_xscale    = 0.2 + random_range(0.1, 0.5);
							image_yscale    = image_xscale;
							motion_add(other.gunangle + random_range(-10, 10), 2 + random(2)) 
						}
					}
				} else {
					alarm1 = 20 + irandom(15);
					enemy_walk(random(360), alarm1)
				}
			}
			// Move Away From Target:
			else{
				alarm1 = 20 + irandom(15);
				enemy_walk(target_direction + 180 + orandom(30), alarm1);
			}
		}			
	} else {
		 // Wander:
		if(chance(1, 3)){
			alarm1 = 40 + irandom(15);
			enemy_walk(random(360), alarm1 - 10);
			enemy_look(direction);
		}
	}
	
#define MothAmalgam_death
	pickup_drop(55, 0)

#define Surgeon_create(_x, _y)
	with(instance_create(_x, _y, CustomEnemy)){
   
    	name = "Surgeon"
    	
         // Visuals: 
        spr_idle		= global.sprSurgeonIdle;
		spr_walk		= global.sprSurgeonWalk;
		spr_hurt		= global.sprSurgeonHurt;
		spr_dead		= global.sprSurgeonDead;
		spr_fire		= global.sprSurgeonIdle;
		spr_fire_strt	= sprSniperIdle;
		spr_fire_end	= sprSniperIdle;
		spr_weap		= mskNone;
		spr_weap_melee	= global.sprSurgeonWeapMelee;
		sprite_index    = spr_idle;
		image_speed     = 0.4;
		depth           = -2;
		hitid           = [spr_idle, "SURGEON"]
        spr_shadow      = shd24;	
        spr_shadow_y	= 1;
        nts_color_blood = [c_red, make_color_rgb(134, 44, 35)]
        
         // Sounds:
        snd_hurt		= sndNecromancerHurt;
        snd_dead		= sndNecromancerDead;
        
         // Vars:
        mask_index  	= mskBandit;
        direction   	= random(360);
        maxhealth   	= 8;
       	my_health   	= maxhealth;
        raddrop     	= 6;
        maxspeed    	= 3;
        walkspeed   	= maxspeed;
        size			= 1;
        canmelee    	= false;
        meleedamage		= 0;
        canmelee    	= false;
        team        	= 1; 
        targetvisible	= 0;
        target      	= 0;
        walk        	= 0;
        gunangle		= 0;
        wepangle		= 110;
        meleeMode		= false;
        hasBalls		= false;
		orbiterTime		= 0;
		ballCount		= 0;
        
         // Alarms:
        alarm1 = 30 + irandom(10);
        alarm2 = 0;

         // Events:
        on_step  = script_ref_create(Surgeon_step);
        on_draw  = MeleeEnemy_draw;
        on_hurt  = Enemy_hurt;
        on_death = Surgeon_death;
        on_alrm1 = script_ref_create(Surgeon_alrm1);
        on_alrm2 = script_ref_create(Surgeon_alrm2);
        
        return self;
	}

#define Surgeon_step

	 // Alarms:
	if("on_alrm1" in self and alarm1_run) exit;
	if("on_alrm2" in self and alarm2_run) exit;

	 // Movement:
	if(walk > 0){ 
		walk -= current_time_scale;   
		speed += walkspeed * current_time_scale;   
		gunangle = direction; 
	}
	if(speed > maxspeed){ 
		speed = maxspeed; 
	}
	
	 // Switch Modes:
	if(alarm2 <= 0){
		if(distance_to_object(target) < 48 && target_visible){
			if(meleeMode = false && alarm2 <= 0){
				meleeMode	= true
				spr_weap	= spr_weap_melee;
				instance_create(x + lengthdir_x(12, gunangle), y + lengthdir_y(12, gunangle), WepSwap);
				sound_play_pitchvol(sndSwapHammer, 1, 0.6);
			}
		} else {
			if(meleeMode = true && alarm3 <= 0){
				meleeMode	= false;
				spr_weap	= mskNone;
				instance_create(x + lengthdir_x(12, gunangle), y + lengthdir_y(12, gunangle), WepSwap);
			}
		}
	}
	
		 // Animate:
	if(sprite_index != spr_fire && sprite_index != spr_fire_strt && sprite_index != spr_fire_end || anim_end){
		sprite_index = enemy_sprite;
	}
	right = (gunangle + 270) mod 360 > 180 ? 1 : -1;
	
#define Surgeon_alrm1
	alarm1 = 30 + irandom(20);
	if(enemy_target(x, y) && target_visible){
		enemy_look(target_direction);
		
		if(target_distance > 160){
			alarm1 = 20 + irandom(15);
			enemy_walk(target_direction + orandom(30), alarm1);
		} else {
			 // Attack:
			if(chance(3, 5)){
				if(meleeMode = true){
					with(instance_create(x, y, AssassinNotice)){
						depth = other.depth - 1;
					}
					alarm2 = 10;
					alarm1	= 60 + irandom(30);
				} else {
					sprite_index	= spr_fire_strt;
					alarm1			= 200;
					alarm2			= 30;
					orbiterTime		= 70;
				}
		
			} else {
				alarm1 = 20 + irandom(15);
				enemy_walk(random(360), alarm1)
			}
		}			
	} else {
		 // Wander:
		if(chance(1, 3)){
			alarm1 = 40 + irandom(15);
			enemy_walk(random(360), alarm1 - 10);
			enemy_look(direction);
		}
	}
	
#define Surgeon_alrm2
	if(meleeMode = true){
		gunangle = target_direction;
	
		 // Sound:
		sound_play_pitch(sndSwapSword, 0.6 + random(0.2));
		sound_play(sndAssassinAttack);
		
		with(instance_create(x, y, EnemySlash)){
			damage		= 3;
			speed		= 2;
			direction	= other.gunangle + random_range(-3, 3);
			image_angle = direction;
			creator		= other;
			team		= other.team
			hitid		= other.hitid;
		}
		
		motion_add(gunangle, 3.5);
		wkick	 = -4;
		wepangle *= -1;
	
	} else {
		if(orbiterTime > 0){
			alarm2 = 1;
			
			if(hasBalls = false){
				sprite_index	= spr_fire;
				hasBalls		= true;
				var _angle		= 0;
				repeat(3){
					with(SurgeonMinion_create(x, y, _angle, self)){
						team			= other.team;
						fr_surgeonBall	= other;
					}
					_angle += 120;
					ballCount += 1;
				}
			} else {
				if(ballCount = 0){
					orbiterTime = 1;
				}
			}
			
			if(--orbiterTime <= 0){
				if(ballCount > 0){
					gunangle = target_direction;
					with(instances_matching(CustomObject, "fr_surgeonBall", self)){
						orbitMode = false;
						var _dir = other.gunangle + 180 + orandom(30);
						motion_set(_dir, 5 + random(2));
						direction	= _dir;
						image_angle	= _dir;
						turnDelay	= 5;
					}
					with(instances_matching(CustomEnemy, "fr_surgeonBall", self)){
						orbitMode = false;
					}
					sound_play_pitch(sndFireShotgun, 1.1 + random(0.3));
					sound_play_pitch(sndEraser, 1.1 + random(0.3));
					instance_create(x, y, PortalClear);
				}
			
				sprite_index	= spr_fire_end;
				hasBalls		= false;
				orbiterTime		= 0;
				ballCount		= 0;
			}
		}
	}
	
#define Surgeon_death
	pickup_drop(55, 0)
	repeat(5){
		with(instance_create(x, y, Dust)){
			sprite_index	= global.sprSoulSmoke;
			depth			= other.depth + 1;
			image_xscale	= 0.4 + random(0.2);
			image_yscale	= image_xscale;
			direction		= random(360);
			speed			= random(4);
		}
	}

#define SurgeonMinion_create(_x, _y, _angle, _creator)
	with(instance_create(_x, _y, CustomEnemy)){
		name = "Spectre";
		
         // Visuals:
        spr_idle		= global.sprSurgeonMinion;
		spr_hurt		= global.sprSurgeonMinionHurt;
		spr_dead		= global.sprSurgeonMinionDead;
        spr_trail		= sprPlasmaTrail;
		sprite_index    = spr_idle;
        image_speed		= 0.4;
        hitid           = [sprite_index, "SPECTRE"];
        depth           = -9;
        image_xscale	= 1;
        right			= 1;
        
         // Vars:
         image_xscale	= 1.5;
         image_yscale	= 1.5;
       // mask_index		= global.mskSurgeonMinion;
        maxhealth		= 4;
        my_health		= maxhealth;
        speed           = 0;
        friction		= 0.20;
        size			= 1;
        canmelee    	= true;
        meleedamage		= 2;
        team			= 1;
        lifeTime        = 450;
        kills			= 0;
     //   corpse			= false;
        size			= 1;
		fr_surgeonBall	= noone;
		creator 		= _creator;
		pather			= SurgeonMinionPather_create(x, y, _angle, _creator);
		orbitMode		= true;
		canfly			= true;

        on_step 		= script_ref_create(SurgeonMinion_step);
        on_end_step		= script_ref_create(SurgeonMinion_endstep);
        on_draw 		= BasicEnemy_draw;
        on_hurt 		= SurgeonMinion_hurt;
        on_death		= SurgeonMinion_death;
        
        return self;
	}

#define SurgeonMinion_step	
	 // Animate:
	if(sprite_index = spr_hurt && anim_end){
		sprite_index	= spr_idle;
	}
	
	if(orbitMode = true){
		if(!instance_exists(creator)){
			pather.orbitMode = false;
			orbitMode = false;
		}
	}
	
	 // VFX:
	if(random(25) < 1){
		with(instance_create(x, y, Dust)){
			sprite_index	= global.sprSoulSmoke;
			depth			= other.depth + 1;
			image_xscale	= 0.4 + random(0.2);
			image_yscale	= image_xscale;
		}
	}
	
	lifeTime -= current_time_scale;
	if(lifeTime <= 0){
		my_health	= 0;
	}
	
	
#define SurgeonMinion_endstep
	if(instance_exists(pather)){
		x			= pather.x;
		y			= pather.y;
		image_angle	= pather.image_angle;
	}

#define SurgeonMinion_hurt(_dmg, _spd, _dir)
	sprite_index = spr_hurt;
	image_index  = 0;
	
	sound_play_hit(snd_hurt, 0.3);
	motion_set(_dir, _spd);
	direction	= _dir;
	turnDelay	= 6;
	
	nexthurt   = current_frame + 6;
	my_health -= _dmg;

#define SurgeonMinion_death
	if(instance_exists(creator) && orbitMode = true){
		creator.ballCount -= 1;
	}
	if(instance_exists(pather)){
		with(pather){
			instance_destroy();
		}
	}
	with(instance_create(x, y, CaveSparkle)){
		sprite_index	= other.spr_dead;
		image_angle		= other.image_angle;
		depth			= other.depth;
	}
	repeat(3){
		with(instance_create(x, y, Dust)){
			sprite_index	= global.sprSoulSmoke;
			depth			= other.depth + 1;
			image_xscale	= 0.4 + random(0.2);
			image_yscale	= image_xscale;
			direction		= random(360);
			speed			= random(4);
		}
	}
	
#define SurgeonMinionPather_create(_x, _y, _angle, _creator)
	with(instance_create(_x, _y, CustomObject)){
		name = "fr_SpectrePather";
		
         // Visuals:
        sprite_index	= mskNone;
        
         // Vars:
        maxhealth		= 3;
        my_health		= maxhealth;
        speed           = 3;
        friction		= 0.20;
        turnPower		= 0.2;
        normalspeed		= 2.5;
        turnDelay		= 0;
		angle			= _angle;
		dist			= 0;
		maxDist			= 25;
		orbitSpeed		= 5;
		orbitMode		= true;
		fr_surgeonBall	= _creator;
		pather			= noone;
		creator 		= _creator

        on_step 		= script_ref_create(SurgeonMinionPather_step);
        on_end_step		= script_ref_create(SurgeonMinionPather_endstep);
        
        return self;
	}
	
#define SurgeonMinionPather_step
	if(orbitMode = true){
		if!instance_exists(creator){
			instance_destroy();
			exit;
		}
		
		 // Move Out:
		if(dist < maxDist){
			dist += 1 * current_time_scale;
		}
		 // Set Size and Speen:
		angle += orbitSpeed * current_time_scale;
		image_angle = angle	+ 90;		
	} else {
		target = instance_nearest(x, y, Player);
		if(turnDelay <= 0){
			if(instance_exists(target)){
				direction	-= (angle_difference(direction, point_direction(x, y, target.x, target.y)) * power(turnPower, current_time_scale));
			}
		} else {
			turnDelay -= current_time_scale;
		}
		image_angle	= direction;
		
		 // Woooah:
		if(random(20) < 1 && turnDelay <= 0){
			direction += random(360);
			motion_set(direction, 4 + random(2));
			turnDelay	= 5;
		}
		 // Speed Check:
		if(speed != normalspeed){
			if(speed > normalspeed){
				speed -= 0.25;
			} else {
				speed += 0.5;
			}
		}
	}
	
#define SurgeonMinionPather_endstep
	if(orbitMode = true){
		xprevious = creator.x + lengthdir_x(dist, angle);
		yprevious = creator.y + lengthdir_y(dist, angle);
		x = creator.x + lengthdir_x(dist, angle);
		y = creator.y + lengthdir_y(dist, angle);
	}

//#endregion
//#region PROJECTILES	

#define GatorBubble_create(_x, _y)
	with(instance_create(_x, _y, CustomProjectile)){
	    name = "fr_GatorBubble"
	    
         // Visuals:
        sprite_index    = global.sprGatorBubble;
        spr_dead		= global.sprGatorBubblePop;
        spr_trail		= global.sprGatorBubbleTrail;
        image_speed		= 0.4;
        image_angle		= random(360);
        hitid           = [sprite_index, "SLUDGE BUBBLE"];
        depth           = -3;
        turnspeed       = (3 + random(2)) * choose(1, -1);
        fr_bloom        = [1.1, 0.2];
        image_xscale    = 0.2;
        image_yscale    = image_xscale;
        maxSize			= 0.8 + random(0.2);
 		bubble_tiltspeed= random_range(0.03, 0.1);
		bubble_tiltrange= random_range(25, 45);		

         // Vars:
        mask_index		= global.mskGatorBubble;
        speed           = 2;
        friction		= 0.20;
        typ             = 0;
        damage          = 0;
        team			= 1;
        lifeTime        = 250;
        maxed           = false;
        growspeed		= 0.025;
        powerPopped		= false;
        slowBox			= GatorBubbleSlowBox_create(x, y, self);
        
        on_step         = GatorBubble_step;
		on_hit			= nothing;
		on_wall			= GatorBubble_wall;
		on_destroy		= GatorBubble_destroy;
		
		return self;
	}

    
#define GatorBubble_step
	if(!instance_exists(slowBox)){
		instance_destroy();
		exit;
	}

     // Spin:
	image_angle = 0 + sin(current_frame * bubble_tiltspeed) * bubble_tiltrange
	
	 // Grow with me!
	if(maxed = false){
	    image_xscale += growspeed;
	    image_yscale = image_xscale;
	    if(image_xscale >= maxSize){
	    	maxed = true;
	    	instance_create(x, y, PortalClear);
		    repeat(5){
		    	with(instance_create(x + random_range(-16, 16), y + random_range(-16, 16), AcidStreak)){
		    		direction	= point_direction(other.x, other.y, x, y);
		    		image_angle	= direction;
		    		speed		= 2 + random(3);
		    	}
	    	}
	    }
	} 
	
	if(speed > 0){
		if(random(8) < 1){
	    	with(instance_create(x + random_range(-16, 16), y + random_range(-16, 16), PlasmaTrail)){
	    		sprite_index	= other.spr_trail;
	    		depth			= other.depth - 1;
	    		image_index		= choose(0, 1);
	    		direction		= other.direction + 180 + random_range(-45, 45)
	    		image_angle		= random(360);
	    		speed			= 2 + random(3);
	    	}		
		}
	}
	
	 // Invisiwall Bouncing
	if(place_meeting(x + hspeed_raw, y + vspeed_raw, InvisiWall)){
		GatorBubble_wall();
	}
	
	lifeTime -= current_time_scale;
	if(lifeTime <= 0){
	    image_xscale -= 0.05;
	    image_yscale = image_xscale;
	    if(image_xscale <= 0.2){
	        instance_destroy();
	        exit;
	    }
	}
	
	slowBox.image_xscale	= image_xscale;
	slowBox.image_yscale	= image_yscale;
	
#define GatorBubble_wall
    move_bounce_solid(true);
    if(speed > 0){
    	var _wall = other;
	    repeat(2){
	    	with(instance_create(x + random_range(-16, 16), y + random_range(-16, 16), AcidStreak)){
	    		direction	= point_direction(_wall.x, _wall.y, x, y);
	    		image_angle	= direction;
	    		speed		= 2 + random(3);
	    	}
		}	
    	sound_play_pitch(sndBouncerBounce, 0.4 + random(0.2));
    }
    speed	= speed * 0.70;

#define GatorBubble_destroy
	if(instance_exists(slowBox)){
		with(slowBox){
			instance_destroy();
		}
	}

	sound_play_pitch(global.sndThrasherBubblePop, 0.9 + random(0.1));
//	sound_play_pitchvol(sndOasisExplosionSmall, 0.7 + random(0.1), 0.2);
	with(instance_create(x, y, BulletHit)){
		sprite_index	= other.spr_dead;
	}
    repeat(5){
    	with(instance_create(x + random_range(-8, 8), y + random_range(-8, 8), AcidStreak)){
    		direction	= point_direction(other.x, other.y, x, y);
    		image_angle	= direction;
    		speed		= 4 + random(2);
    	}
    	with(instance_create(x + random_range(-16, 16), y + random_range(-16, 16), PlasmaTrail)){
    		sprite_index	= other.spr_trail;
    		depth			= other.depth - 1;
    		image_index		= choose(0, 1);
    		direction		= point_direction(other.x, other.y, x, y);
    		image_angle		= random(360);
    		speed			= 2 + random(3);
    	}	
	}
	if(powerPopped = true){
		repeat(18){
			with(instance_create(x, y, EnemyBullet2)){
				direction	= random(360);
				image_angle	= direction;
				speed		= 4 + random(2);
				team		= other.team;
				hitid		= other.hitid;
				creator 	= other;
			}
		}
	}

#define GatorBubbleSlowBox_create(_x, _y, _bubble)
	with(instance_create(_x, _y, CustomProjectile)){
	    name = "fr_GatorBubbleSlowBox"
		
        sprite_index    = global.mskGatorBubbleSlowBox;
        image_alpha		= 0;

		creator 		= _bubble;
		team			= creator.team;
        
        on_wall 		= nothing;
        on_hit			= GatorBubbleSlowBox_hit;
        on_end_step 	= GatorBubbleSlowBox_endstep;
        
        return self;
	}

#define GatorBubbleSlowBox_hit
    with(other){
    	x = (xprevious + ((0.5 * current_time_scale) * hspeed));
    	y = (yprevious + ((0.5 * current_time_scale) * vspeed));
    }
    
#define GatorBubbleSlowBox_endstep
	if(instance_exists(creator)){
		x = creator.x;
		y = creator.y;
	}
	
#define RavenSlicer_create(_x, _y)
	with(instance_create(_x, _y, CustomProjectile)){
		name = "fr_ravenslicer";
		
         // Visuals:
        sprite_index    = global.sprRavenSlicer;
        spr_dead		= sprDiscBounce;
        spr_trail		= global.sprRavenSlicerTrail;
        image_speed		= 0.4;
        image_angle		= random(360);
        fr_bloom		= [2, 0.1];
	    spinAngle		= 1;
	    depth			= -3;
        
         // Vars:
        mask_index		= mskEnemyBullet1;
        maxspeed		= 7 * power(0.8, skill_get(mut_euphoria));
        speed           = maxspeed - 1;
        friction		= 0.1;
        typ             = 1;
        damage          = 3;
        creator         = other;
        team            = other.team;
        hitid           = [sprite_index, "RAVEN SLICER"];
		reverse 		= false;
        
        on_step         = RavenSlicer_step;
        on_wall 		= RavenSlicer_wall;
        on_destroy		= RavenSlicer_destroy;
        
        return self;
	}
	
#define RavenSlicer_step
	image_angle += (18 + (speed * 5)) * current_time_scale;
	if(speed <= 0.5 && reverse = false){
		reverse 		= true;
		direction		+= 180;
		friction		= -0.3;
		
		repeat(3){
			with(instance_create(x + orandom(6), y + orandom(6), BulletHit)){
				sprite_index	= other.spr_trail;
				depth			= other.depth + 1;
				speed			= 1 + random(2);
				direction		= other.direction + 180;
			}
		}
	}
	if(reverse = true){
		if(speed >= maxspeed){
			friction = 0;
		}
	}
	if(random(10) < 1){
		with(instance_create(x + orandom(6), y + orandom(6), BulletHit)){
			sprite_index	= other.spr_trail;
			depth			= other.depth + 1;
			speed			= 1 + random(2);
			direction		= other.direction + 180;
		}
	}

#define RavenSlicer_wall
	sound_play_pitch(sndHitWall, 0.7 + random(0.2));
	instance_destroy();

#define RavenSlicer_destroy
	with(instance_create(x, y, BulletHit)){
		sprite_index	= other.spr_dead;
	}
	
#define SurgeonBullet_create(_x, _y)
	with(instance_create(_x, _y, CustomProjectile)){
		name = "fr_surgeonBullet";
		
         // Visuals:
        sprite_index    = global.sprSurgeonBullet;
        image_index		= irandom(image_number);
        spr_dead		= global.sprSurgeonBulletHit;
        spr_trail		= global.sprSurgeonBulletTrail;
        image_speed		= 0.4;
        image_angle		= random(360);
        fr_bloom		= [2, 0.1];
        image_alpha		= 0.8;
        
         // Vars:
        mask_index		= mskEnemyBullet1;
        maxspeed		= 8 * power(0.8, skill_get(mut_euphoria));
        speed           = maxspeed - 1;
        friction		= 0.2;
        typ             = 1;
        damage          = 2;
        creator         = other;
        team            = other.team;
        hitid           = [sprite_index, "GLOBBLOB"];
        
        on_step         = SurgeonBullet_step;
        on_destroy		= SurgeonBullet_destroy;
        
        return self;
	}
	
#define SurgeonBullet_step
	if(random(10) < 1){
		with(instance_create(x + orandom(6), y + orandom(6), BulletHit)){
			sprite_index	= other.spr_trail;
			depth			= other.depth + 1;
			speed			= 1 + random(2);
			direction		= other.direction + 180;
		}
	}
	if(speed <= 0){
		instance_destroy();
	}
	
#define SurgeonBullet_destroy
	with(instance_create(x, y, BulletHit)){
		sprite_index	= other.spr_dead;
	}
	
#define DeeplabsOutputDecal_create(_x, _y)
	with(instance_create(_x, _y, CustomObject)){
		name	= "fr_deeplabsOutputDecal";
		
		sprite_index	= mskNone;
		depth			= 7;

		return self;
	}	
	
#define TubeAmmoChest_create(_x, _y)
	with(instance_create(_x, _y, AmmoChest)){
		mod_script_call("area", "deeplabs", "BigTube_throw")
		
		return self;
	}
	TubeAmmoChestController_create(_x, _y);
	
#define TubeAmmoChestController_create(_x, _y)
	with(instance_create(_x, _y, CustomObject)){
		eep 		= 1;
		
		on_step		= TubeAmmoChestController_step;
		
		return self;
	}


#define TubeAmmoChestController_step
	if(eep > 0){
		eep -= current_time_scale;
	} else {
		with(instance_nearest(x, y, chestprop)){
			if(instance_is(self, AmmoChestMystery)){
				instance_change(AmmoChest, 0);
				mod_script_call("area", "deeplabs", "BigTube_throw")
			}
		}
		instance_destroy();
	}

//#endregion

//#region TUBE OBJECTS
 // these are over here since I didnt want to add a modtype var to the deeplabs tube spawning
 // I also didnt want to move them over here so
#define FishFreakCorpse_create(_x, _y)
	with(instance_create(_x, _y, Corpse)){ 
		sprite_index	= global.sprFishFreakDead; 
		image_index 	= 0; 
		direction		= random(360); 
		speed			= 4 + random(5);
		
		return self;
	}	

#define FrozenCar_spawn(_x, _y)
	with(instance_create(_x, _y, Car)){ 
		spr_idle		= sprFrozenCar;
		spr_hurt		= sprFrozenCarHurt;
		sprite_index	= spr_idle;
		
		return self;
	}	
	
//#endregion
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
#macro  bbox_center_x                                                                           (bbox_left + bbox_right + 1) / 2
#macro  bbox_center_y                                                                           (bbox_top + bbox_bottom + 1) / 2
#define pround(_num, _precision)                                                        		return  (_precision == 0) ? _num : round(_num / _precision) * _precision;
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
	
#define sound_play_hit_ext(_sound, _pitch, _volume)
	/*
		'sound_play_hit()' distance-based sound, but with pitch and volume arguments
	*/
	
	var _snd = sound_play_hit(_sound, 0);
	
	sound_pitch(_snd, _pitch);
	sound_volume(_snd, audio_sound_get_gain(_snd) * _volume);
	
	return _snd;
	
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

//#endregion
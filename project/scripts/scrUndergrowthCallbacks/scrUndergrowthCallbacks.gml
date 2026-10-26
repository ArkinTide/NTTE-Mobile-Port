// Undergrowth area::area_subarea
function scrUG_area_subarea() {
return 1;
}

// Undergrowth area::area_background_color
function scrUG_area_background_color() {
return make_color_rgb(102, 78, 24);
}

// Undergrowth area::area_shadow_color
function scrUG_area_shadow_color() {
return make_color_rgb(28, 0, 14);
}

// Undergrowth area::area_darkness
function scrUG_area_darkness() {
return true;
}

// Undergrowth area::area_secret
function scrUG_area_secret() {
return true;
}

// Undergrowth area::area_music
function scrUG_area_music() {
return musUGUndergrowth;
}

// Undergrowth area::area_ambient
function scrUG_area_ambient() {
return amb4;
}

// Undergrowth area::area_mapdata
function scrUG_area_mapdata(_x, _y) {
return [54, 0];
}

// Undergrowth area::area_name
function scrUG_area_name() {
return "???";
}

// Undergrowth area::area_text
function scrUG_area_text() {
return choose("MILLIPEDES DRINK OIL", "CAREFUL WITH THE MUSHROOMS", "REMEMBER THEIR GREED", "PETROLEUM WETLANDS", "WAS IT WORTH IT", "VENGEFUL NATURE", "FOSSIL FUELS", "BLACK GOLD", "IGNIVOROUS");
}

// Undergrowth area::area_setup_floor
function scrUG_area_setup_floor() {
if(styleb){
        depth = 8;
    }
    
                 
    material = (styleb ? 1 : 4);
}

// Undergrowth area::area_make_floor
function scrUG_area_make_floor() {
var _x = x,
		_y = y,
		_outOfSpawn = (point_distance(_x, _y, 10000, 10000) > 48);
		
	                
    instance_create(_x, _y, Floor);
	
	                
	if(_outOfSpawn && random(3) < 1){
		instance_create(_x + 32, _y,	  Floor);
		instance_create(_x - 32, _y,	  Floor);
		instance_create(_x,		 _y - 32, Floor);
		instance_create(_x, 	 _y + 32, Floor);
	}
    
                         
    var _turn = 0;
    if(random(3) < 1){
    	_turn = choose(90, 90, 270, 270, 180);
    }
    direction += _turn;
    
                      
    if(_outOfSpawn && _turn == 180){
    	instance_create(_x + 16, _y + 16, WeaponChest);
    }
    
                                  
    if(random(19 + instance_number(FloorMaker)) > 20){
    	if(_outOfSpawn){
    		instance_create(_x + 16, _y + 16, AmmoChest);
    	}
    	
    	            
    	instance_destroy();
    }
    
                          
    if(random(7) < 1){
    	instance_create(_x, _y, FloorMaker);
    }
}

// Undergrowth area::area_pop_props
function scrUG_area_pop_props() {
if(
		(random(10) < 1)
		&& point_distance(x, y, 10000, 10000) > 96
		&& !place_meeting(x, y, NOWALLSHEREPLEASE)
		&& !place_meeting(x, y, hitme)
	){
		instance_create(x + choose(0, 16), y + choose(0, 16), Wall);
		instance_create(x, y, NOWALLSHEREPLEASE);
	}
	else{
		var _x = (bbox_left + bbox_right)  / 2,
			_y = (bbox_top  + bbox_bottom) / 2,
			_outOfSpawn = (point_distance(x, y, 10000, 10000) > 48);
		
		
		          
		if(_outOfSpawn){
			if(random(10) < 1){          
				if(styleb){
					if(random(3) < 2){
						              
						scrUGCreate(_x + orandom(1), _y + orandom(1), "BugBones");
					}
					else{
						          
						scrUGCreate(_x + orandom(2), _y + orandom(2), "Vine");
					}
				}
				else{
					if(random(2) < 1){         
						                   
						scrUGCreate(_x + orandom(4), _y + orandom(4), "Mushroom");
					}
					else{
						                
						scrUGCreate(_x + orandom(2), _y + orandom(2), "Vine");
					}
				}
			}
		}
	}
	
	               
	                     
	if(random(40) < 1){
	    for(var _ug_each0=scrNTTEFullInstances(instance_create(x, y, TopPot)),_ug_each0i=0;_ug_each0i<array_length(_ug_each0);++_ug_each0i) with(_ug_each0[_ug_each0i]){
	        sprite_index = scrUG_area_sprite(sprite_index);
	        image_index  = irandom(image_number - 1);
	        image_speed=( 0)*timescale;
	    }
	}
	
	                
	if(distance_to_object(instance_nearest(x, y, LightBeam)) > 64 && random(7) < 1){
		for(var _ug_each1=scrNTTEFullInstances(instance_create(x, y, LightBeam)),_ug_each1i=0;_ug_each1i<array_length(_ug_each1);++_ug_each1i) with(_ug_each1[_ug_each1i]){
			sprite_index = sprUGLightBeamUndergrowth;
		}
	}
}

// Undergrowth area::area_pop_extras
function scrUG_area_pop_extras() {
for(var _ug_each0=scrNTTEFullInstances(chestprop),_ug_each0i=0;_ug_each0i<array_length(_ug_each0);++_ug_each0i) with(_ug_each0[_ug_each0i]){
        scrUGCreate(x, y, "UndergrowthBandit");
    }
    
                        
    for(var _ug_each1=scrNTTEFullInstances(scrUGMatching(Floor, "mask_index", mskFloor)),_ug_each1i=0;_ug_each1i<array_length(_ug_each1);++_ug_each1i) with(_ug_each1[_ug_each1i]){
    	if(!collision_rectangle(bbox_left - 16, bbox_top, bbox_right + 16, bbox_bottom, Floor, false, true)){
		    
		                        
    		if(styleb){
	    		var _right = 1;
	    		for(var h = 0; h <= 32; h += 32){
	    			for(var v = 0; v <= 16; v += 16){
	    				if(random(6) < 5){
		    				for(var _ug_each2=scrNTTEFullInstances(instance_create(x + h, y + v, Bones)),_ug_each2i=0;_ug_each2i<array_length(_ug_each2);++_ug_each2i) with(_ug_each2[_ug_each2i]){
		    					image_xscale = _right;
		    					sprite_index = scrUG_area_sprite(sprite_index);
		    				}
	    				}
	    			}
	    			_right = -1;
	    		}
    		}
    		else{
    			
    			          
	    		for(var i = 0; i <= 1; i++){
	    			var _y = y + (i * 16);
	    			
	    			if(random(5) < 3){
			    		for(var _ug_each3=scrNTTEFullInstances(instance_create(x + 16, _y, Bones)),_ug_each3i=0;_ug_each3i<array_length(_ug_each3);++_ug_each3i) with(_ug_each3[_ug_each3i]){
			    			sprite_index = sprUGUndergrowthDecalVine;
			    			mask_index   = mskUGUndergrowthDecalVine;
			    			image_xscale = choose(-1, 1);
			    			image_index  = irandom(i);
			    		}
	    			}
	    		}
    		}
    	}
    }
    
            
    if(random(80) < 1){
    	for(var _ug_each4=scrNTTEFullInstances(instance_nearest(10016, 10016, chestprop)),_ug_each4i=0;_ug_each4i<array_length(_ug_each4);++_ug_each4i) with(_ug_each4[_ug_each4i]){
    		scrUGCreate(x, y, "Woo");
    	}
    }
    
                             
    for(var _ug_each5=scrNTTEFullInstances(instance_furthest(10000, 10000, WeaponChest)),_ug_each5i=0;_ug_each5i<array_length(_ug_each5);++_ug_each5i) with(_ug_each5[_ug_each5i]){
    	scrUGCreate(x, y, "VineChest");
    	instance_create(x, y, PortalClear);
    	
    	scrUGDelete(id);
    }
    
                    
    for(var _ug_each6=scrNTTEFullInstances(instance_furthest(10000, 10000, Floor)),_ug_each6i=0;_ug_each6i<array_length(_ug_each6);++_ug_each6i) with(_ug_each6[_ug_each6i]){
    	var _x = (bbox_left + bbox_right)  / 2,
    		_y = (bbox_top  + bbox_bottom) / 2;
    	
		scrUGCreate(_x, _y, "Millipede");
    }
}

// Undergrowth area::area_pop_enemies
function scrUG_area_pop_enemies() {
var _x = (bbox_left + bbox_right)  / 2,
		_y = (bbox_top  + bbox_bottom) / 2;
		
	if(random(4) < 3){
		if(random(7) < 1){
			scrUGCreate(_x, _y, "Flytrap");
			  
              
                                    
    
        
                                  
    
     
		}
		else{
			if(random(3) < 2){
				if(random(3) < 1){
					if(random(100) < 5 * (1 + GameCont.loops)){
						scrUGCreate(_x, _y, "GoldPitcherPlant");
					}
					else{
						scrUGCreate(_x, _y, "PitcherPlant");
					}
				}
				else{
					scrUGCreate(_x, _y, "Firefly");
					  
                                    
                                                
                                      
      
          
                                    
      
       
				}
			}
		}
	}
}

// Undergrowth area::BugBones_create
function scrUG_BugBones_create(_x, _y) {
for(var _ug_each0=scrNTTEFullInstances(instance_create(_x, _y, UGProp)),_ug_each0i=0;_ug_each0i<array_length(_ug_each0);++_ug_each0i) with(_ug_each0[_ug_each0i]){
		name = "BugBones";
		
		           
		spr_idle = sprUGBugBones1Idle;
		spr_hurt = sprUGBugBones1Hurt;
		spr_dead = sprUGBugBones1Dead;
		spr_shadow = -1;
		sprite_index = spr_idle;
		
		           
		snd_hurt = sndHitRock;
		snd_dead = sndPillarBreak;
		
		         
		max_hp = 16;
		hp = max_hp;
		size = 1;
		
		return id;
	}
}

// Undergrowth area::DirectionalExplosion_create
function scrUG_DirectionalExplosion_create(_x, _y) {
for(var _ug_each0=scrNTTEFullInstances(instance_create(_x, _y, UGProjectile)),_ug_each0i=0;_ug_each0i<array_length(_ug_each0);++_ug_each0i) with(_ug_each0[_ug_each0i]){
		name = "DirectionalExplosion";
		
		           
		hitid = [sprUGDirectionalExplosion, "EXPLOSION"];
		
		         
		mask_index   = mskUGLilHunterDie;
		direction    = random(360);
		spacing		 = 25;
		ammo		 = 5;
		team		 = -1;
		delay		 = 0;
		delay_max    = 2;
		angle_offset = 0;
		angle_random = 0;
		damage		 = 2;
		force		 = 6;
		creator 	 = noone;
		target		 = noone;
		pitch		 = random_range(0.9, 1.2);
		sound		 = scrUGSoundPitchVol(sndNothingBeamLoop, pitch, 0.7);
		typ		     = 1;
		setup		 = true;
		ultra		 = false;
		
		            
		on_step    = scrUGRef(scrUG_DirectionalExplosion_step);
		on_end_step = scrUGRef(scrUG_DirectionalExplosion_end_step);
		on_wall	   = scrUGRef(scrUGNothing);
		on_hit	   = scrUGRef(scrUGNothing);
		on_destroy = scrUGRef(scrUG_DirectionalExplosion_destroy);
		on_cleanup = scrUGRef(scrUG_DirectionalExplosion_cleanup);
		
		return id;
	}
}

// Undergrowth area::DirectionalExplosion_setup
function scrUG_DirectionalExplosion_setup() {
if(GameCont.crown == crwn_death){
		ammo++;
	}
	
	              
	if(!instance_is(creator, Player)){
		var _skill = scr_skill_get(mut_euphoria);
		if(_skill > 0){
			delay_max *= 1 + (0.2 * _skill);
		}
	}
}

// Undergrowth area::DirectionalExplosion_step
function scrUG_DirectionalExplosion_step() {
if(setup){
		scrUG_DirectionalExplosion_setup();
		setup = false;
	}
	
	if((ammo > 0 && target == noone) || (instance_exists(target) && !place_meeting(x, y, target))){
		delay -= timescale;
		
		if(delay <= 0){
			ammo--;
			
			  
              
                                                                                     
              
    
     
			
			                    
			for(var _ug_each0=scrNTTEFullInstances(instance_create(x, y, SmallExplosion)),_ug_each0i=0;_ug_each0i<array_length(_ug_each0);++_ug_each0i) with(_ug_each0[_ug_each0i]){
				sprite_index = other.ultra ? sprUGGreenDirectionalExplosion : sprUGDirectionalExplosion;
				image_xscale = other.image_xscale;
				image_yscale = other.image_yscale;
				image_angle  = other.direction;
				
				name	= other.name;        
				damage	= other.damage;
				force	= other.force;
				team	= other.team;
				hitid	= other.hitid;
				creator = other.creator;
			}
			
			direction += angle_offset;
			
			                
			if(instance_exists(target)){
				var _tdir = point_direction(x, y, target.x, target.y);
				direction += angle_difference(_tdir, direction) * 2/3;
			}
			
			                     
			direction += random_range(-angle_random, angle_random);
		}
	}
	else{
		 
		            
		instance_destroy();
	}
}

// Undergrowth area::DirectionalExplosion_end_step
function scrUG_DirectionalExplosion_end_step() {
if(delay <= 0){
		delay = delay_max;
		
		x += lengthdir_x(spacing, direction);
		y += lengthdir_y(spacing, direction);
	}
}

// Undergrowth area::DirectionalExplosion_destroy
function scrUG_DirectionalExplosion_destroy() {
if(place_meeting(x, y, target)){
		for(var _ug_each0=scrNTTEFullInstances(instance_create(x, y, Explosion)),_ug_each0i=0;_ug_each0i<array_length(_ug_each0);++_ug_each0i) with(_ug_each0[_ug_each0i]){
			hitid = other.hitid;
		}
	}
	else if(ammo > 0){
		for(var _ug_each1=scrNTTEFullInstances(instance_create(x, y, SmallExplosion)),_ug_each1i=0;_ug_each1i<array_length(_ug_each1);++_ug_each1i) with(_ug_each1[_ug_each1i]){
			hitid = other.hitid;
		}
	}
	
	           
	audio_sound_set_track_position(scrUGSoundPitch(sndFlameCannonEnd, pitch), 0.185);
}

// Undergrowth area::DirectionalExplosion_cleanup
function scrUG_DirectionalExplosion_cleanup() {
audio_stop_sound(sound);
}

// Undergrowth area::Dragonfly_create
function scrUG_Dragonfly_create(_x, _y) {
for(var _ug_each0=scrNTTEFullInstances(instance_create(_x, _y, UGEnemy)),_ug_each0i=0;_ug_each0i<array_length(_ug_each0);++_ug_each0i) with(_ug_each0[_ug_each0i]){
		name = "Dragonfly";
		
		           
		spr_idle = sprUGDragonflyIdle;
		spr_walk = sprUGDragonflyWalk;
		spr_turn = sprUGDragonflyTurn;
		spr_hurt = sprUGDragonflyHurt;
		spr_dead = sprUGDragonflyDead;
		spr_shadow = shd64B;
		spr_shadow_y = 12;
		sprite_index = spr_idle;
		depth = -3;
		hitid = [sprite_index, "DRAGONFLY"];
		
		           
		snd_hurt = sndFlyHurt;
		snd_dead = sndFlyDead;
		
		         
		mask_index = mskBigMaggot;
		friction=( 0.2)*sqr(timescale);
		max_hp = 30;
		hp = max_hp;
		raddrop = 150;
		maxspeed = 3.2;
		minspeed = 0.8;
		walkspeed = 0.4;
		size = 3;
		canmelee = true;
		meleedamage = 5;
		gunangle = 0;
		walk = 0;
		direction = random(360);
		
		           
		alarm1 = 90;
		
		           
		on_step = scrUGRef(scrUG_Dragonfly_step);
		on_draw = scrUGRef(scrUG_enemy_draw);
		on_hurt = scrUGRef(scrUG_enemy_hurt);
		on_alrm1 = scrUGRef(scrUG_Dragonfly_alrm1);
		
		return id;
	}
}

// Undergrowth area::Dragonfly_step
function scrUG_Dragonfly_step() {
if(scrUGAlarm(1)) return;

	            
	if(((image_index+image_speed)>=image_number || (image_index+image_speed)<0)){
		sprite_index = ((speed/timescale) <= minspeed) ? spr_idle : spr_walk;
	}
	
	             
	if(walk > 0){
		walk -= timescale;
		scrUGMotionAddCT(direction, walkspeed);
	}
	speed=( clamp((speed/timescale), minspeed, maxspeed))*timescale;
	
	                  
	if(place_meeting(x + hspeed, y + vspeed, Wall)){
		if(place_meeting(x + hspeed, y, Wall)){
			hspeed*=( -1);
			right  *= -1;
		}
		if(place_meeting(x, y + vspeed, Wall)){
			vspeed*=( -1);
		}
	}
}

// Undergrowth area::Dragonfly_alrm1
function scrUG_Dragonfly_alrm1() {
alarm1 = 60 + random(60);
	target = scrUGTarget();
	
	walk = 20 + random(20);
	
	sprite_index = spr_walk;
	image_index  = 0;
	
	direction += orandom(60);
	
	scrUGMotionAdd(direction, (friction/sqr(timescale)));
	scrUGFace(direction);
}

// Undergrowth area::Ember_create
function scrUG_Ember_create(_x, _y) {
for(var _ug_each0=scrNTTEFullInstances(instance_create(_x, _y, BulletHit)),_ug_each0i=0;_ug_each0i<array_length(_ug_each0);++_ug_each0i) with(_ug_each0[_ug_each0i]){
		name = "Ember";
		
		           
		sprite_index = sprUGEmber;
		image_xscale = random_range(0.25, 0.75);
		image_yscale = image_xscale;
		image_index  = random(1);
		
		         
		speed=( random_range(2, 4))*timescale;
		direction		  = random(360);
		friction=( 0.1)*sqr(timescale);
		gravity=( 0.1)*sqr(timescale);
		gravity_direction = 90;
		
		return id;
	}
}

// Undergrowth area::FireFlower_create
function scrUG_FireFlower_create(_x, _y) {
for(var _ug_each0=scrNTTEFullInstances(instance_create(_x, _y, UGHitme)),_ug_each0i=0;_ug_each0i<array_length(_ug_each0);++_ug_each0i) with(_ug_each0[_ug_each0i]){
		name = "FireFlower";
		
		           
		spr_idle = sprUGEntryVineIdle;
		spr_hurt = sprUGEntryVineHurt;
		spr_dead = sprUGEntryVineDead;
		spr_exit = sprUGEntryVineExit;
		spr_shadow = shdUGEntryVine;
		sprite_index = spr_idle;
		image_speed=( 0.4)*timescale;
		hitid = [sprite_index, "VINE"];
		depth = -1;
		
		           
		snd_hurt = sndHitPlant;
		snd_dead = -1;
		
		         
		hp = 500;
		size = 1;
		prompt = scrNTTEFullPromptCreate(id,"VINE");
		prompt.on_meet = method(prompt,scrUGFlowerPromptMeet);
		text = "VINE";
		pick = -1;
		xoff = 0;
		yoff = 0;
		                                                       
		
		           
		on_begin_step = scrUGRef(scrUGNothing);
		on_step = scrUGRef(scrUG_FireFlower_step);
		on_end_step = scrUGRef(scrUGNothing);
		on_hurt = scrUGRef(scrUG_FireFlower_hurt);
		on_cleanup = scrUGRef(scrUG_FireFlower_cleanup);
		
		return id;
	}
}

// Undergrowth area::FireFlower_begin_step
function scrUG_FireFlower_begin_step() {
return;
}

// Undergrowth area::FireFlower_step
function scrUG_FireFlower_step() {
scrUGFlowerStep();
}

// Undergrowth area::FireFlower_end_step
function scrUG_FireFlower_end_step() {
return;
}

// Undergrowth area::FireFlower_hurt
function scrUG_FireFlower_hurt(_dmg, _spd, _dir) {
hp -= _dmg;
	nexthurt   = current_frame + 6;
	
	snd_play_hit(snd_hurt, 0.3);
	
	sprite_index = spr_hurt;
	image_index  = 0;
}

// Undergrowth area::FireFlower_cleanup
function scrUG_FireFlower_cleanup() {
if(instance_exists(prompt)){
		scrUGDelete(prompt);
	}
}

// Undergrowth area::Firefly_create
function scrUG_Firefly_create(_x, _y) {
for(var _ug_each0=scrNTTEFullInstances(instance_create(_x, _y, UGEnemy)),_ug_each0i=0;_ug_each0i<array_length(_ug_each0);++_ug_each0i) with(_ug_each0[_ug_each0i]){
		name = "Firefly";
		
		           
		spr_idle = sprUGFireflyIdle;
		spr_walk = sprUGFireflyWalk;
		spr_hurt = sprUGFireflyHurt;
		spr_dead = sprUGFireflyDead;
		spr_shadow = shd24;
		spr_shadow_y = 5;
		sprite_index = spr_idle;
		hitid = [sprite_index, "FIREFLY"];
		depth = -2;
		
		           
		snd_hurt = sndFlyHurt;
		snd_dead = sndFlyDead;
		snd_mele = sndBurn;
		
		         
		mask_index = mskBandit;
		direction = random(360);
		max_hp = 7;
		hp = max_hp;
		canmelee = true;
		meleedamage = 3;
		size = 1;
		raddrop = 2;      
		right = choose(-1, 1);
		walk = 0;
		walkspeed = 0.8;
		maxspeed = 3.6;
		minspeed = 1.2;
		
		           
		alarm1 = 60 + random(60);
		
		           
		on_step  = scrUGRef(scrUG_Firefly_step);
		on_alrm1 = scrUGRef(scrUG_Firefly_alrm1);
		on_death = scrUGRef(scrUG_Firefly_death);
		on_hurt  = scrUGRef(scrUG_enemy_hurt);
		on_draw  = scrUGRef(scrUG_enemy_draw);
		
		return id;
	}
}

// Undergrowth area::Firefly_step
function scrUG_Firefly_step() {
if(scrUGAlarm(1)) return;

	            
	if(((image_index+image_speed)>=image_number || (image_index+image_speed)<0)){
		sprite_index = ((speed/timescale) <= minspeed) ? spr_idle : spr_walk;
	}
	
	           
	if(walk > 0){
		walk -= timescale;
		scrUGMotionAddCT(direction, walkspeed);
	}
	
	speed=( clamp((speed/timescale), minspeed, maxspeed))*timescale;
	
	                  
	if(place_meeting(x + hspeed, y + vspeed, Wall)){
		if(place_meeting(x + hspeed, y, Wall)){
			hspeed*=( -1);
			right  *= -1;
		}
		if(place_meeting(x, y + vspeed, Wall)){
			vspeed*=( -1);
		}
	}
}

// Undergrowth area::Firefly_alrm1
function scrUG_Firefly_alrm1() {
alarm1 = 20 + random(20);
	target = scrUGTarget();
	
	if(
		instance_exists(target) 
		&& point_distance(x, y, target.x, target.y) < 96
		&& !collision_line(x, y, target.x, target.y, Wall, false, false)
	){
		walk = 40;
		direction = point_direction(x, y, target.x, target.y);
		
		sprite_index = spr_walk;
		image_index  = 0;
		
		scrUGMotionAdd(direction, (friction/sqr(timescale)));
		scrUGFace(direction);
	}
	else{
		if(random(3) < 1){
			
			           
			walk = 10 + random(30);
			direction += orandom(90);
			
			sprite_index = spr_walk;
			image_index  = 0;
			
			scrUGMotionAdd(direction, (friction/sqr(timescale)));
			scrUGFace(direction);
		}
	}
}

// Undergrowth area::Firefly_death
function scrUG_Firefly_death() {
instance_create(x, y, Smoke);

	repeat(3){
		scrUGCreate(x, y, "Ember");
	}
	
	scrNTTEFullWorldPickupDrop(10, 0);      
	
	           
	var _snd = snd_play_hit(sndJungleAssassinAttack, 0);
	audio_sound_pitch(_snd, 0.3 + random(0.3));
	audio_sound_set_track_position(_snd, 0.2);
}

// Undergrowth area::FireflyExplode_create
function scrUG_FireflyExplode_create(_x, _y) {
for(var _ug_each0=scrNTTEFullInstances(instance_create(_x, _y, UGObject)),_ug_each0i=0;_ug_each0i<array_length(_ug_each0);++_ug_each0i) with(_ug_each0[_ug_each0i]){
		name = "FireflyExplode";
		
		           
		spr_idle = sprUGFireflyHurt;
		spr_dead = sprUGFireflyExplode;
		spr_shadow = shd24;
		spr_shadox_x = 0;
		spr_shadow_y = 0;
		sprite_index = spr_idle;
		image_speed=( 0.4)*timescale;
		depth		 = -3;
		hitid		 = [mskNone, ""];
		
		         
		creator = noone;
		team    = 0;
		size	= 0;
		
		           
		alarm0 = 30 + random(10);
		
		           
		on_step = scrUGRef(scrUG_FireflyExplode_step);
		on_alrm0 = scrUGRef(scrUG_FireflyExplode_alrm0);
		 
		return id;
	}
}

// Undergrowth area::FireflyExplode_step
function scrUG_FireflyExplode_step() {
if(scrUGAlarm(0)) return;
	
	          
	if((current_frame % 1) < timescale){
		x += orandom(1);
		y += orandom(1);
	}
	
	                  
	if(place_meeting(x + hspeed, y + vspeed, Wall)){
		if(place_meeting(x + hspeed, y, Wall)){
			hspeed*=( -1);
			
			         
			if((hspeed/timescale) > 0){
				image_xscale = sign((hspeed/timescale));
			}
		}
		if(place_meeting(x, y + vspeed, Wall)){
			vspeed*=( -1);
		}
		
	}
	
	            
	if(instance_exists(creator) && random(3) < (2 * timescale)){
		var l = random(16),
			d = point_direction(x, y, creator.x, creator.y);
			
		for(var _ug_each0=scrNTTEFullInstances(scrUGCreate(x + lengthdir_x(l, d) + orandom(4), y + lengthdir_y(l, d) + orandom(4), "FlameSparkle")),_ug_each0i=0;_ug_each0i<array_length(_ug_each0);++_ug_each0i) with(_ug_each0[_ug_each0i]){
			direction = d;
			speed=( 2 + random(2))*timescale;
		}
	}
	
	            
	if(random(3) < timescale){
		scrUGCreate(random_range(bbox_left, bbox_right), random_range(bbox_top, bbox_bottom), "FlamePuff");
	}
}

// Undergrowth area::FireflyExplode_alrm0
function scrUG_FireflyExplode_alrm0() {
if(instance_exists(creator)){
		
		             
		var l = 12,
			d = point_direction(x, y, creator.x, creator.y);
			
		for(var _ug_each0=scrNTTEFullInstances(scrUGCreate(x + lengthdir_x(l, d), y + lengthdir_y(l, d), "DirectionalExplosion")),_ug_each0i=0;_ug_each0i<array_length(_ug_each0);++_ug_each0i) with(_ug_each0[_ug_each0i]){
			direction	 = d;
			ammo		 = 0;
			team		 = other.team;
			hitid		 = other.hitid;
			target	     = other.creator;
			creator		 = other.id;
			delay_max	 = 3;
			angle_random = 17;
		}
	}
		
	for(var _ug_each1=scrNTTEFullInstances(instance_create(x, y, SmallExplosion)),_ug_each1i=0;_ug_each1i<array_length(_ug_each1);++_ug_each1i) with(_ug_each1[_ug_each1i]){
		hitid = other.hitid;
		team  = other.team;
	}
	
	for(var _ug_each2=scrNTTEFullInstances(instance_create(x, y, Corpse)),_ug_each2i=0;_ug_each2i<array_length(_ug_each2);++_ug_each2i) with(_ug_each2[_ug_each2i]){
		sprite_index = other.spr_dead;
		size		 = other.size;
	}
	
	           
	snd_play_hit(sndExplosionS, 0.3);
	
	            
	instance_destroy();
}

// Undergrowth area::FlamePuff_create
function scrUG_FlamePuff_create(_x, _y) {
for(var _ug_each0=scrNTTEFullInstances(instance_create(_x, _y, RecycleGland)),_ug_each0i=0;_ug_each0i<array_length(_ug_each0);++_ug_each0i) with(_ug_each0[_ug_each0i]){
		name = "FlamePuff";
		
		           
		sprite_index = sprUGFlamePuff;
		image_xscale = choose(-1, 1);
		
		         
		direction = 90;
		speed=( 2)*timescale;
		
		return id;
	}
}

// Undergrowth area::FlameSparkle_create
function scrUG_FlameSparkle_create(_x, _y) {
for(var _ug_each0=scrNTTEFullInstances(instance_create(_x, _y, ThrowHit)),_ug_each0i=0;_ug_each0i<array_length(_ug_each0);++_ug_each0i) with(_ug_each0[_ug_each0i]){
		name = "FlameSparkle";
		
		           
		sprite_index = sprUGFlameSparkle;
		
		return id;
	}
}

// Undergrowth area::FlameSparkleBig_create
function scrUG_FlameSparkleBig_create(_x, _y) {
for(var _ug_each0=scrNTTEFullInstances(instance_create(_x, _y, ThrowHit)),_ug_each0i=0;_ug_each0i<array_length(_ug_each0);++_ug_each0i) with(_ug_each0[_ug_each0i]){
		name = "FlameSparkleBig";
		
		           
		sprite_index = sprUGFlameSparkleBig;
		
		return id;
	}
}

// Undergrowth area::Flytrap_create
function scrUG_Flytrap_create(_x, _y) {
for(var _ug_each0=scrNTTEFullInstances(instance_create(_x, _y, UGEnemy)),_ug_each0i=0;_ug_each0i<array_length(_ug_each0);++_ug_each0i) with(_ug_each0[_ug_each0i]){
		name = "Flytrap";
		
		           
		spr_idle = sprUGFlytrapIdle;
		spr_walk = sprUGFlytrapWalk;
		spr_hurt = sprUGFlytrapHurt;
		spr_dead = sprUGFlytrapDead;
		spr_fire = sprUGFlytrapFire;
		spr_shadow = shd64B;
		spr_shadow_y = 6;
		sprite_index = spr_idle;
		hitid = [sprite_index, "FIREFLY TRAP"];
		depth = -3;
		
		           
		snd_hurt = sndSuperFireballerHurt;
		snd_dead = sndSuperFireballerDead;
		snd_mele = sndJungleAssassinWake;
		
		         
		mask_index = mskUGFlytrap;
		max_hp = 34;
		hp = max_hp;
		size = 3;
		raddrop = 30;
		right = choose(-1, 1);
		walk = 0;
		meleedamage = 4;
		canmelee = true;
		walkspeed = 0.6;
		maxspeed = 2.2;
		nextfire = 0;
		spawns = 0;
		max_spawns = 10;
		ammo = 0;
		gunangle = 0;
		light_coeff = 0;
		light_delta = 0;
		wave = random(90);
		draw_hurt = 0;
		
		           
		alarm1 = 60 + random(60);
		alarm2 = -1;
		
		           
		on_step  = scrUGRef(scrUG_Flytrap_step);
		on_alrm1 = scrUGRef(scrUG_Flytrap_alrm1);
		on_alrm2 = scrUGRef(scrUG_Flytrap_alrm2);
		on_death = scrUGRef(scrUG_Flytrap_death);
		on_hurt  = scrUGRef(scrUG_plant_hurt);
		on_draw  = scrUGRef(scrUG_plant_draw);
		
		return id;
	}
}

// Undergrowth area::Flytrap_step
function scrUG_Flytrap_step() {
if(scrUGAlarm(1)) return;
	if(scrUGAlarm(2)) return;

	         
	wave += timescale;

	            
	if(((image_index+image_speed)>=image_number || (image_index+image_speed)<0) && sprite_index != spr_fire){
		sprite_index = ((speed/timescale) == 0) ? spr_idle : spr_walk;
	}
	
	           
	if(walk > 0){
		walk -= timescale;
		direction += sin(wave / 40) * 8;
		scrUGMotionAddCT(direction, walkspeed);
	}
	if((speed/timescale) > maxspeed){
		speed=( maxspeed)*timescale;
	}
	
	if(sprite_index == spr_fire && ammo <= 0){
		if(random(5) < (2 * timescale)){
			for(var _ug_each0=scrNTTEFullInstances(scrUGCreate(x + (random_range(-4, 20) * right), y - random_range(2, 20), "FlameSparkle")),_ug_each0i=0;_ug_each0i<array_length(_ug_each0);++_ug_each0i) with(_ug_each0[_ug_each0i]){
				sprite_index = (random(5) < 2) ? sprUGFlameSparkleBig : sprUGFlameSparkle;
				depth = other.depth - 1;
				speed*=( 2);
			}
			
			           
			audio_sound_gain(snd_play_hit(sndGammaGutsProc, 0.3), 0.3, 0);
			
			var _snd = snd_play_hit(sndJungleAssassinWake, 0);
			audio_sound_pitch(_snd, 1.3 + random(0.3));
			audio_sound_gain(_snd, 0.3, 0);
			audio_sound_set_track_position(_snd, 0.2);
		}
	}
	
	          
	light_coeff = clamp(light_coeff + (light_delta * timescale), 0, 1);
	
	                                  
	scrUG_plant_heal();
}

// Undergrowth area::Flytrap_alrm1
function scrUG_Flytrap_alrm1() {
alarm1 = 40 + random(40);
	target = scrUGTarget();
	
	                   
	if(ammo > 0){
		ammo--;
		spawns++;
		
		             
		for(var _ug_each0=scrNTTEFullInstances(scrUGCreate(x, y, "Firefly")),_ug_each0i=0;_ug_each0i<array_length(_ug_each0);++_ug_each0i) with(_ug_each0[_ug_each0i]){
			direction = other.gunangle + orandom(30);
			speed=( maxspeed)*timescale;
			alarm1 = 20 + random(20);
			walk = alarm1;
			givekill = 0;
			raddrop = 0;
			
			scrUGContact(direction, (speed/timescale));
			scrUGFace(direction);
		}
		
		            
		scrUGCreate(x + (random(20) - 4) * right, y - random_range(8, 12), "LavaSheet");
		for(var _ug_each1=scrNTTEFullInstances(scrUGCreate(x, y - 12, "LavaStreak")),_ug_each1i=0;_ug_each1i<array_length(_ug_each1);++_ug_each1i) with(_ug_each1[_ug_each1i]){
			direction	= other.gunangle + orandom(30);
			image_angle = direction;
			speed=( 4 + random(2))*timescale;
		}
		
		           
		audio_sound_gain(snd_play_hit(sndFlyFire, 0.3), 0.7, 0);
		
		var _snd = snd_play_hit(sndPlantSnareTrapper, 0);
		audio_sound_pitch(_snd, 0.7);
		audio_sound_gain(_snd, 0.7, 0);
		audio_sound_set_track_position(_snd, 0.3);
		
		var _snd = snd_play_hit(sndPlasmaBigUpg, 0);
		audio_sound_pitch(_snd, 0.3);
		audio_sound_gain(_snd, 0.7, 0);
		audio_sound_set_track_position(_snd, 0.5);
		
		               
		if(ammo <= 0){
			
			alarm1 = 60 + random(90);
			alarm2 = 1;
		}
		else{
			
			                   
			alarm1 = 4 + irandom(4);
		}
	}
	else{
		
		if(
			instance_exists(target) 
			&& !collision_line(x, y, target.x, target.y, Wall, false, false)
			&& point_distance(x, y, target.x, target.y) < 160
			&& random(5) < 3
		){
			
			                    
			if(spawns < max_spawns){
				
				ammo = 3 + irandom(1 + GameCont.loops);
				alarm1 = 1;
				gunangle = point_direction(x, y, target.x, target.y);
				
				light_delta = 0.1;
				light_coeff = 2/3;
				
				scrUGMotionAdd(gunangle + 180, 2);
				scrUGFace(gunangle);
				
				sprite_index = spr_fire;
				image_index  = 0;
				
				instance_create(x, y, PortalClear);
				
				           
				audio_sound_set_track_position(snd_play_hit(sndPlantSnareTB, 0.3), 0.1);
				audio_sound_gain(snd_play_hit(sndHammer, 0.3), 0.8, 0);
				
				var _snd = snd_play_hit(sndJungleAssassinWake, 0);
				audio_sound_pitch(_snd, 0.6 + random(0.3));
				audio_sound_gain(_snd, 0.5, 0);
				audio_sound_set_track_position(_snd, 0.2);
			}
			else{
				
				           
				var _scrl = view_xview,
					_scrt = view_yview,
					_scrr = _scrl + view_width,
					_scrb = _scrt + view_height,
					_inst = scrUGMatchingLE(scrUGMatchingLE(scrUGMatchingGE(scrUGMatchingGE(scrUGMatchingGT(scrUGMatching(UGEnemy, "name", "Firefly"), "my_health", 0), "x", _scrl), "y", _scrt), "x", _scrr), "y", _scrb),
					_amnt = min(array_length(_inst), 2 + irandom(1))
					
				                                 
				if(_amnt > 0){
					
					spawns--;
					alarm1 += 90;
					alarm2  = 45;
					
					light_delta = 0.1;
					light_coeff = 2/3;
					
					sprite_index = spr_fire;
					image_index  = 0;
					
					           
					audio_sound_set_track_position(snd_play_hit(sndPlantSnareTB, 0.3), 0.1);
					audio_sound_gain(snd_play_hit(sndHammer, 0.3), 0.8, 0);
					
					var _snd = snd_play_hit(sndJungleAssassinWake, 0);
					audio_sound_pitch(_snd, 0.6 + random(0.3));
					audio_sound_gain(_snd, 0.5, 0);
					audio_sound_set_track_position(_snd, 0.2);
					
					                           
					var _list = [];
					repeat(_amnt){
						var _nearest = noone,
							_maxdist = infinity;
							
						for(var _ug_each2=scrNTTEFullInstances(_inst),_ug_each2i=0;_ug_each2i<array_length(_ug_each2);++_ug_each2i) with(_ug_each2[_ug_each2i]){
							
							var _mydist = point_distance(x, y, other.target.x, other.target.y);
							if(_mydist < _maxdist && array_get_index(_list, id) < 0){
								
								_maxdist = _mydist;
								_nearest = id;
							}
						}
						
						array_push(_list, _nearest);
					}
					
					             
					var _creator = id,
						_xavg	 = 0;
						
					for(var _ug_each3=scrNTTEFullInstances(_list),_ug_each3i=0;_ug_each3i<array_length(_ug_each3);++_ug_each3i) with(_ug_each3[_ug_each3i]){
						
						_xavg += x;
						
						for(var _ug_each4=scrNTTEFullInstances(scrUGCreate(x, y, "FireflyExplode")),_ug_each4i=0;_ug_each4i<array_length(_ug_each4);++_ug_each4i) with(_ug_each4[_ug_each4i]){
							image_xscale = other.right;
							direction = other.direction;
							speed=( (other.speed/timescale))*timescale;
							friction=( (other.friction/sqr(timescale)) / 2)*sqr(timescale);
							spr_shadox = other.spr_shadow;
							spr_shadow_x = other.spr_shadow_x;
							spr_shadow_y = other.spr_shadow_y;
							creator = _creator;
							hitid = _creator.hitid;
							team = _creator.team;
							size = other.size;
						}
						
						for(var _ug_each5=scrNTTEFullInstances(scrUGCreate(x, y, "FlameSparkle")),_ug_each5i=0;_ug_each5i<array_length(_ug_each5);++_ug_each5i) with(_ug_each5[_ug_each5i]){
							sprite_index = sprUGFlameSparkleBig;
						}
						
						            
						corpse = 0;
						hp = 0;
					}
					
					_xavg /= array_length(_list);
					var _face = sign(_xavg - x);
					
					if(_face != 0){
						right = _face;
					}
				}
				else{
					
					                  
					                                       
					                                                
					walk = 60 + random(60);
					direction = point_direction(x, y, target.x, target.y);
					
					sprite_index = spr_walk;
					image_index  = 0;
					
					scrUGMotionAdd(direction, (friction/sqr(timescale)));
					scrUGFace(direction);
				}
			}
		}
		else{
			           
			walk = 15 + random(15);
			direction += orandom(60);
			
			sprite_index = spr_walk;
			image_index  = 0;
			
			scrUGMotionAdd(direction, (friction/sqr(timescale)));
			scrUGFace(direction);
		}
	}
}

// Undergrowth area::Flytrap_alrm2
function scrUG_Flytrap_alrm2() {
sprite_index = spr_idle;
	image_index  = 0;
	
	light_delta = -0.2;
	
	           
	var _snd = snd_play_hit(sndJungleAssassinAttack, 0);
	audio_sound_pitch(_snd, 0.4 + random(0.3));
	audio_sound_set_track_position(_snd, 0.15);
}

// Undergrowth area::Flytrap_death
function scrUG_Flytrap_death() {
var l = 12;
	for(var d = 0; d < 360; d += 90){
		for(var _ug_each0=scrNTTEFullInstances(scrUGCreate(x + lengthdir_x(l, d), y + lengthdir_y(l, d), "DirectionalExplosion")),_ug_each0i=0;_ug_each0i<array_length(_ug_each0);++_ug_each0i) with(_ug_each0[_ug_each0i]){
			direction	 = d;
			ammo		 = 4;
			team		 = other.team;
			hitid		 = other.hitid;
			creator		 = other.id;
			delay_max	 = 3;
			angle_random = 12;
		}
	}
	
	for(var _ug_each1=scrNTTEFullInstances(instance_create(x, y, Explosion)),_ug_each1i=0;_ug_each1i<array_length(_ug_each1);++_ug_each1i) with(_ug_each1[_ug_each1i]){
		hitid = other.hitid;
		team  = other.team;
	}
	repeat(3){
		for(var _ug_each2=scrNTTEFullInstances(instance_create(x, y, SmallExplosion)),_ug_each2i=0;_ug_each2i<array_length(_ug_each2);++_ug_each2i) with(_ug_each2[_ug_each2i]){
			hitid = other.hitid;
			team  = other.team;
		}
	}
	
	scrNTTEFullWorldPickupDrop(60, 0);
	scrNTTEFullWorldPickupDrop(40, 5, 0);
	
	           
	snd_play_hit(sndExplosionL, 0.3);
}

// Undergrowth area::GoldPitcherPlant_create
function scrUG_GoldPitcherPlant_create(_x, _y) {
for(var _ug_each0=scrNTTEFullInstances(scrUGCreate(_x, _y, "PitcherPlant")),_ug_each0i=0;_ug_each0i<array_length(_ug_each0);++_ug_each0i) with(_ug_each0[_ug_each0i]){
		name = "GoldPitcherPlant";
		
		           
		spr_idle = sprUGGoldPitcherPlantIdle;
		spr_walk = sprUGGoldPitcherPlantWalk;
		spr_hurt = sprUGGoldPitcherPlantHurt;
		spr_dead = sprUGGoldPitcherPlantDead;
		spr_chrg = sprUGGoldPitcherPlantCharge;
		spr_fire = sprUGGoldPitcherPlantFire;
		sprite_index = spr_idle;
		hitid = [sprite_index, "GOLDEN PITCHER PLANT"];
		
		           
		snd_hurt = sndFireballerHurt;
		snd_dead = sndSuperFireballerDead;
		
		         
		max_hp = 40;
		hp = max_hp;
		raddrop = 50;
		gold = true;
		ammo = 0;
		
		           
		on_alrm1 = scrUGRef(scrUG_GoldPitcherPlant_alrm1);
		on_alrm2 = scrUGRef(scrUG_GoldPitcherPlant_alrm2);
		on_death = scrUGRef(scrUG_GoldPitcherPlant_death);
		on_hurt  = scrUGRef(scrUG_GoldPitcherPlant_hurt);
		
		return id;
	}
}

// Undergrowth area::GoldPitcherPlant_alrm1
function scrUG_GoldPitcherPlant_alrm1() {
alarm1 = 20 + random(20);
	target = scrUGTarget();
	
	if(instance_exists(target) && !collision_line(x, y, target.x, target.y, Wall, false, false)){
		gunangle = point_direction(x, y, target.x, target.y);
		var _dis = point_distance(x, y, target.x, target.y);
		
		if(_dis < 128){
			if(random(5) < 3){
				sprite_index = spr_chrg;
				image_index  = 0;
				
				scrUGMotionAdd(gunangle + 180, 2);
				instance_create(x, y, PortalClear);
				
				alarm1 = -1;
				alarm2 = 13;
				
				light_coeff = 2/3;
				light_delta = 0.1;
				
				ammo = 3;
				angle_coeff *= -1;
				
				           
				audio_sound_set_track_position(snd_play_hit(sndPlantSnare, 0.3), 0.1);
				audio_sound_set_track_position(snd_play_hit(sndGoldPlasma, 0.3), 0.6);
			}
		}
		else{
			               
			if(_dis < 240){
				
				walk = 25 + random(10);
				direction = gunangle + orandom(30);
				
				sprite_index = spr_walk;
				image_index  = 0;
				
				scrUGMotionAdd(direction, (friction/sqr(timescale)));
			}
		}
	}
	else{
		gunangle = direction;
		
		walk = 20 + random(5);
		direction += orandom(90);
		
		sprite_index = spr_walk;
		image_index  = 0;
		
		scrUGMotionAdd(direction, (friction/sqr(timescale)));
	}
	
	               
	scrUGFace(gunangle);
}

// Undergrowth area::GoldPitcherPlant_alrm2
function scrUG_GoldPitcherPlant_alrm2() {
sprite_index = spr_fire;
	image_index  = 0;
	
	            
	for(var _ug_each0=scrNTTEFullInstances(scrUGCreate(x, y, "LavaSplash")),_ug_each0i=0;_ug_each0i<array_length(_ug_each0);++_ug_each0i) with(_ug_each0[_ug_each0i]){
		sprite_index = sprUGLavaSplashUltra;
		image_angle  = other.gunangle;
		depth		 = other.depth - 1;
	}
	
	                     
	if(ammo > 0){
		
		                          
		var l = 16,
			d = gunangle;
			
		for(var _ug_each1=scrNTTEFullInstances(scrUGCreate(x + lengthdir_x(l, d), y + lengthdir_y(l, d), "GreenDirectionalExplosion")),_ug_each1i=0;_ug_each1i<array_length(_ug_each1);++_ug_each1i) with(_ug_each1[_ug_each1i]){
			direction	 = d;
			ammo		 = 6 + irandom(3);
			team		 = other.team;
			hitid		 = other.hitid;
			creator		 = other.id;
			delay_max	 = 3;
			angle_random = 7;
			angle_offset = 12 * other.angle_coeff;
		}
		
		scrUGMotionAdd(gunangle, 4);
		scrUGContact(direction, (speed/timescale));
		
		scrUGFace(gunangle);
		gunangle += (angle_coeff * 120);
		
		             
		if(--ammo > 0){
			alarm2 = 4;
		}
	}
	else{
		var l = 16,
			d = gunangle;
			
		for(var _ug_each2=scrNTTEFullInstances(scrUGCreate(x + lengthdir_x(l, d), y + lengthdir_y(l, d), "GreenDirectionalExplosion")),_ug_each2i=0;_ug_each2i<array_length(_ug_each2);++_ug_each2i) with(_ug_each2[_ug_each2i]){
			direction	 = d;
			ammo		 = 9 + irandom(3);
			team		 = other.team;
			hitid		 = other.hitid;
			creator		 = other.id;
			delay_max	 = 3;
			angle_random = 12;
		}
		
		scrUGMotionAdd(gunangle, 4);
	}
	
	               
	if(ammo <= 0){
		light_delta = -0.2;
		alarm1 = 30 + random(30);
	}
	
	           
	var _snd = snd_play_hit(sndGoldLaser, 0.3);
	audio_sound_gain(_snd, 0.7, 0);
	audio_sound_set_track_position(_snd, 0.1);
	audio_sound_set_track_position(snd_play_hit(sndJungleAssassinWake, 0.2), 0.1);
	audio_sound_set_track_position(snd_play_hit(sndPlantSnareTrapperTB, 0.2), 0.3);
}

// Undergrowth area::GoldPitcherPlant_hurt
function scrUG_GoldPitcherPlant_hurt(_dmg, _spd, _dir) {
scrUG_plant_hurt(_dmg, _spd, _dir);
	
	var _snd = snd_play_hit(sndGoldLaser, 0.3);
	audio_sound_gain(_snd, 0.5, 0);
	audio_sound_set_track_position(_snd, 0.1);
	audio_sound_gain(snd_play_hit(sndNothingHurtHigh, 0.3), 0.6, 0);
}

// Undergrowth area::GoldPitcherPlant_death
function scrUG_GoldPitcherPlant_death() {
var l = 12;
	for(var o = 0; o < 360; o += 90){
		var d = o + 45;
		for(var _ug_each0=scrNTTEFullInstances(scrUGCreate(x + lengthdir_x(l, d), y + lengthdir_y(l, d), "GreenDirectionalExplosion")),_ug_each0i=0;_ug_each0i<array_length(_ug_each0);++_ug_each0i) with(_ug_each0[_ug_each0i]){
			direction	 = d;
			ammo		 = 3;
			team		 = other.team;
			hitid		 = other.hitid;
			creator		 = other.id;
			delay_max	 = 4;
			angle_random = 6;
		}
	}
	
	for(var _ug_each1=scrNTTEFullInstances(instance_create(x, y, GreenExplosion)),_ug_each1i=0;_ug_each1i<array_length(_ug_each1);++_ug_each1i) with(_ug_each1[_ug_each1i]){
		hitid = other.hitid;
		team  = other.team;
	}
	
	repeat(3){
		for(var _ug_each2=scrNTTEFullInstances(instance_create(x, y, SmallExplosion)),_ug_each2i=0;_ug_each2i<array_length(_ug_each2);++_ug_each2i) with(_ug_each2[_ug_each2i]){
			hitid = other.hitid;
			team  = other.team;
		}
	}
	
	           
	var _snd = snd_play_hit(sndNothingHurtMid, 0.3);
	audio_sound_gain(_snd, 0.6, 0);
	audio_sound_set_track_position(_snd, 0.1);
	
	audio_sound_set_track_position(snd_play_hit(sndGoldLaserUpg, 0.3), 0.2);
	audio_sound_gain(snd_play_hit(sndGoldRocketFly, 0), 0.3, 0);
	snd_play_hit(sndExplosion, 0.3);
	
	          
	scrNTTEFullWorldPickupDrop(80, 0);
	scrNTTEFullWorldPickupDrop(60, 20);
}

// Undergrowth area::GreenDirectionalExplosion_create
function scrUG_GreenDirectionalExplosion_create(_x, _y) {
for(var _ug_each0=scrNTTEFullInstances(scrUGCreate(_x, _y, "DirectionalExplosion")),_ug_each0i=0;_ug_each0i<array_length(_ug_each0);++_ug_each0i) with(_ug_each0[_ug_each0i]){
		name = "GreenDirectionalExplosion";
		
		           
		hitid = [sprUGGreenDirectionalExplosion, "EXPLOSION"];
		
		         
		ultra = true;
		damage = 4;
		
		return id;
	}
}

// Undergrowth area::LavaSplash_create
function scrUG_LavaSplash_create(_x, _y) {
for(var _ug_each0=scrNTTEFullInstances(instance_create(_x, _y, AnimParticle)),_ug_each0i=0;_ug_each0i<array_length(_ug_each0);++_ug_each0i) with(_ug_each0[_ug_each0i]){
		name = "LavaSplash";
		
		           
		sprite_index = sprUGLavaSplash;
		image_yscale = choose(-1, 1);
		
		return id;
	}
}

// Undergrowth area::LavaSheet_create
function scrUG_LavaSheet_create(_x, _y) {
for(var _ug_each0=scrNTTEFullInstances(instance_create(_x, _y, RecycleGland)),_ug_each0i=0;_ug_each0i<array_length(_ug_each0);++_ug_each0i) with(_ug_each0[_ug_each0i]){
		name = "LavaSheet";
		
		           
		sprite_index = sprUGLavaSheet;
		image_xscale = choose(-1, 1);
		
		return id;
	}
}

// Undergrowth area::LavaStreak_create
function scrUG_LavaStreak_create(_x, _y) {
for(var _ug_each0=scrNTTEFullInstances(instance_create(_x, _y, BloodStreak)),_ug_each0i=0;_ug_each0i<array_length(_ug_each0);++_ug_each0i) with(_ug_each0[_ug_each0i]){
		name = "LavaStreak";
		
		           
		sprite_index = sprUGLavaStreak;
		image_yscale = choose(-1, 1);
		
		return id;
	}
}

// Undergrowth area::Millipede_create
function scrUG_Millipede_create(_x, _y) {
var _inst = [],
		_last = noone,
		_wave = random(90),
		_amnt = 13 + irandom(GameCont.loops) + (4 * (GameCont.crown == crwn_blood));
		
	repeat(_amnt){
		for(var _ug_each0=scrNTTEFullInstances(scrUGCreate(_x, _y, "MillipedeSegment")),_ug_each0i=0;_ug_each0i<array_length(_ug_each0);++_ug_each0i) with(_ug_each0[_ug_each0i]){
			wave = _wave;
			_wave += 10;
			
			parent = _last;
			for(var _ug_each1=scrNTTEFullInstances(_last),_ug_each1i=0;_ug_each1i<array_length(_ug_each1);++_ug_each1i) with(_ug_each1[_ug_each1i]){
				child = other.id;
			}
			
			array_push(_inst, id);
			_last = id;
		}
	}
	
	                  
	for(var _ug_each2=scrNTTEFullInstances(_inst),_ug_each2i=0;_ug_each2i<array_length(_ug_each2);++_ug_each2i) with(_ug_each2[_ug_each2i]){
		type = ((parent != noone) ? ((child != noone) ? "body" : "tail") : "head");
		
		scrUG_MillipedeSegment_setup();
	}
	
	return _inst;
}

// Undergrowth area::MillipedeSegment_create
function scrUG_MillipedeSegment_create(_x, _y) {
for(var _ug_each0=scrNTTEFullInstances(instance_create(_x, _y, UGEnemy)),_ug_each0i=0;_ug_each0i<array_length(_ug_each0);++_ug_each0i) with(_ug_each0[_ug_each0i]){
		name = "MillipedeSegment";
		
		           
		spr_idle_array = [
			sprUGMillipedeBodyIdle1,
			sprUGMillipedeBodyIdle2,
			sprUGMillipedeBodyIdle3,
			sprUGMillipedeBodyIdle4
		];
		spr_hurt_array = [
			sprUGMillipedeBodyHurt1,
			sprUGMillipedeBodyHurt2,
			sprUGMillipedeBodyHurt3,
			sprUGMillipedeBodyHurt4
		];
		spr_idle = spr_idle_array[0];
		spr_hurt = spr_hurt_array[0];
		spr_dead = sprUGMillipedeDead;
		spr_foot_idle = sprUGMillipedeFootIdle;
		spr_foot_hurt = sprUGMillipedeFootHurt;
		spr_shadow = shd64B;
		spr_shadow_hold = -1;
		spr_shadow_x = 0;
		spr_shadow_y = 6;
		sprite_index = spr_idle;
		image_speed=( 0.4)*timescale;
		hitid = [sprUGMillipedeHeadIdle8, "MILLIPEDE"];
		
		           
		snd_hurt = sndScorpionHit;
		snd_dead = sndScorpionDie;
		snd_mele = sndScorpionMelee;
		
		         
		mask_index = mskUGMillipede;
		friction=( 0.8)*sqr(timescale);
		max_hp = 60;
		hp = max_hp;
		size = 5;
		meleedamage = 3;
		canmelee = true;
		team = 1;
		target = noone;
		maxspeed = 5;
		walkspeed = 1;
		walk = false;
		gunangle = random(360);
		canfly = true;
		active = true;
		custom_spd = 0;
		custom_dir = 0;
		parent = noone;
		child  = noone;
		type   = "";
		meeting_wall = false;
		z = 0;
		z_max = 8;
		wave = 0;
		
		           
		alarm1 = -1;
		
		           
		on_step = scrUGRef(scrUG_MillipedeSegment_step);
		on_end_step = scrUGRef(scrUG_MillipedeSegment_end_step);
		on_draw = scrUGRef(scrUG_MillipedeSegment_draw);
		on_hurt = scrUGRef(scrUG_MillipedeSegment_hurt);
		on_death = scrUGRef(scrUG_MillipedeSegment_death);
		on_alrm1 = scrUGRef(scrUG_MillipedeSegment_alrm1);
		
		return id;
	}
}

// Undergrowth area::MillipedeSegment_setup
function scrUG_MillipedeSegment_setup() {
switch(type){
		case "head":
			           
			spr_idle_array = [
				sprUGMillipedeHeadIdle1,
				sprUGMillipedeHeadIdle2,
				sprUGMillipedeHeadIdle3,
				sprUGMillipedeHeadIdle4,
				sprUGMillipedeHeadIdle5,
				sprUGMillipedeHeadIdle6,
				sprUGMillipedeHeadIdle7,
				sprUGMillipedeHeadIdle8
			];
			spr_hurt_array = [
				sprUGMillipedeHeadHurt1,
				sprUGMillipedeHeadHurt2,
				sprUGMillipedeHeadHurt3,
				sprUGMillipedeHeadHurt4,
				sprUGMillipedeHeadHurt5,
				sprUGMillipedeHeadHurt6,
				sprUGMillipedeHeadHurt7,
				sprUGMillipedeHeadHurt8
			];
			
			         
			meleedamage = 5;
			
			           
			alarm1 = 90 + random(60);
			
			  
             
                  
                  
    
                                 
                
                             
                   
     
    
   
                                   
                                                      
                                                         
    
     
			
			break;
			
		case "tail":
			           
			spr_idle_array = [
				sprUGMillipedeTailIdle1,
				sprUGMillipedeTailIdle2,
				sprUGMillipedeTailIdle3,
				sprUGMillipedeTailIdle4
			];			
			spr_hurt_array = [
				sprUGMillipedeTailHurt1,
				sprUGMillipedeTailHurt2,
				sprUGMillipedeTailHurt3,
				sprUGMillipedeTailHurt4
			];
			
			         
			canmelee = false;
			
			break;
	}
}

// Undergrowth area::MillipedeSegment_step
function scrUG_MillipedeSegment_step() {
if(scrUGAlarm(1)) return;
	
	            
	if(((image_index+image_speed)>=image_number || (image_index+image_speed)<0)){
		sprite_index = spr_idle;
	}
	
	                    
	if(sprite_index == spr_idle || sprite_index == spr_hurt){
		var _idle  = (sprite_index == spr_idle),
			_index = array_get_index((_idle ? spr_idle_array : spr_hurt_array), sprite_index),
			_angle = round((((gunangle % 360) + 360) % 360) / 45) % array_length(_idle ? spr_idle_array : spr_hurt_array);
			
		if(_index != _angle){
			if(_idle){
				spr_idle = spr_idle_array[_angle];
			}
			else{
				spr_hurt = spr_hurt_array[_angle];
			}
			
			var _frame = image_index;
			sprite_index = (_idle ? spr_idle : spr_hurt);
			image_index  = _frame;
			
			image_angle = _angle * 45;
		}
	}
	
	             
	if(walk){
		var _dir = scrUGRound(gunangle, 45) + sin(current_frame / 8) * 16;
		scrUGMotionAddCT(_dir, walkspeed);
	}
	if((speed/timescale) > maxspeed){
		speed=( maxspeed)*timescale;
	}
	
	                
	var _addz = 0;
	if(meeting_wall){
		_addz = 1;
		
		if(place_meeting(x, y, Floor)){
			if(!place_meeting(x, y, Wall)){
				meeting_wall = false;
				instance_create(x, y, Smoke);
			}
			
			if(!sprite_exists(spr_shadow)){
				spr_shadow = spr_shadow_hold;
			}
		}
		else{
			if(sprite_exists(spr_shadow)){
				spr_shadow_hold = spr_shadow;
				spr_shadow = -1;
			}
		}
	}
	else{
		_addz = -2;
		
		if(place_meeting(x, y, Wall)){
			meeting_wall = true;
			instance_create(x, y, Smoke);
		}
	}
	z = clamp(z + _addz * timescale, 0, z_max);
	
	                          
	if(instance_exists(SharpTeeth)){
		var _depth = -8,
			_inst  = scrUGMatchingGT(scrUGMatching(SharpTeeth, "creator", id), "depth", _depth);
			
		if(array_length(_inst)) for(var _ug_each0=scrNTTEFullInstances(_inst),_ug_each0i=0;_ug_each0i<array_length(_ug_each0);++_ug_each0i) with(_ug_each0[_ug_each0i]){
			depth = _depth;
		}
	}
	
	                
	if(random(30) < timescale){
		for(var _ug_each1=scrNTTEFullInstances(scrUGCreate(random_range(bbox_left, bbox_right), random_range(bbox_top, y) - z, "LavaSheet")),_ug_each1i=0;_ug_each1i<array_length(_ug_each1);++_ug_each1i) with(_ug_each1[_ug_each1i]){
			sprite_index = sprUGFuelSheet;
		}
	}
	
	                    
	if(parent != noone && !instance_exists(parent)){
		parent = noone;
		
		                          
		if(type == "tail"){
			hp = 0;
		}
		else{
			
			                
			type = "head";
			
			scrUG_MillipedeSegment_setup();
			alarm1 = 20;
			
			                       
			var _inst = parent;
			while(instance_exists(_inst)){
				for(var _ug_each2=scrNTTEFullInstances(_inst),_ug_each2i=0;_ug_each2i<array_length(_ug_each2);++_ug_each2i) with(_ug_each2[_ug_each2i]){
					other.speed=( (speed/timescale))*timescale;
					other.direction = direction;
					
					_inst = parent;
				}
			}
		}
	}
	if(child != noone && !instance_exists(child)){
		child = noone;
		
		                          
		if(type == "head"){
			hp = 0;
		}
		else{
			
			                
			type = "tail";
			scrUG_MillipedeSegment_setup();
		}
	}
	
	                  
	                                     
	custom_spd = max(0, (speed - friction));
	custom_dir = direction;
	xprevious  = x + lengthdir_x(custom_spd, custom_dir);
	yprevious  = y + lengthdir_y(custom_spd, custom_dir);
}

// Undergrowth area::MillipedeSegment_end_step
function scrUG_MillipedeSegment_end_step() {
if(x == (xprevious + hspeed)) x -= hspeed;
	if(y == (yprevious + vspeed)) y -= vspeed;
	
	                   
	speed = custom_spd;
	direction = custom_dir;

	              
	if(type == "head"){
		
		var _inst = id,
			_kill = !active,
			_x1   = +infinity,
			_y1   = +infinity,
			_x2   = -infinity,
			_y2   = -infinity;
			
		                            
		for(var i = 0; i < 1; i++){
			var _x = view_xview,
				_y = view_yview;
				
			if(_x < _x1) _x1 = _x;
			if(_y < _y1) _y1 = _y;
			if(_x > _x2) _x2 = _x;
			if(_y > _y2) _y2 = _y;
		}
		
		_x2 += view_width;
		_y2 += view_height;
		
		                              
		while(instance_exists(_inst)){
			for(var _ug_each0=scrNTTEFullInstances(_inst),_ug_each0i=0;_ug_each0i<array_length(_ug_each0);++_ug_each0i) with(_ug_each0[_ug_each0i]){
				
				                   
				if(id != other.id){
				
					                    
					var _fd = 16 + (16 * abs(dcos(gunangle))),                                       
						_pd = point_distance(x, y, parent.x, parent.y);
					
					if(_pd > _fd){
						var l = _pd - _fd,
							d = point_direction(x, y, parent.x, parent.y);
							
						x += lengthdir_x(l, d);
						y += lengthdir_y(l, d);
						
						gunangle = d;
						scrUGFace(gunangle);
						
						                   
						wave += l;
					}
					
				}
				
				                      
				var _xo = sprite_width  / 2,
					_yo = sprite_height / 2;
					
				visible = (x >= (_x1 - _xo) && y >= (_y1 - _yo) && x <= (_x2 + _xo) && y <= (_y2 + _yo));
				if(visible && _kill){
					_kill = false;
				}
				
				                        
				_inst = child;
			}
		}
		
		            
		if(_kill){
			
			            
			                                   
			                                                 
			for(var _ug_each1=scrNTTEFullInstances([Corpse, instance_nearest(x, y, Floor), id]),_ug_each1i=0;_ug_each1i<array_length(_ug_each1);++_ug_each1i) with(_ug_each1[_ug_each1i]){
				if(instance_exists(id)){
					for(var _ug_each2=scrNTTEFullInstances(instance_create(x, y, Corpse)),_ug_each2i=0;_ug_each2i<array_length(_ug_each2);++_ug_each2i) with(_ug_each2[_ug_each2i]){
						mask_index = mskNone;
						size	   = 0;
					}
					
					                                   
					                                                   
					                                               
					instance_create(x, y, Smoke);
					
					break;
				}
			}
			
			                        
			var _inst = id;
			while(instance_exists(_inst)){
				for(var _ug_each3=scrNTTEFullInstances(_inst),_ug_each3i=0;_ug_each3i<array_length(_ug_each3);++_ug_each3i) with(_ug_each3[_ug_each3i]){
					
					_inst = child;
					instance_destroy();
				}
			}
			
			          
			if(!scr_check_enemies()){
				snd_play(sndLastEnemy);
			}
		}
	}
}

// Undergrowth area::MillipedeSegment_draw
function scrUG_MillipedeSegment_draw() {

	
	y -= z;
	var _angle  = image_angle;
	image_angle = 0;
	
	draw_self();
	
	y += z;
	image_angle = _angle;
}

// Undergrowth area::MillipedeSegment_alrm1
function scrUG_MillipedeSegment_alrm1() {
alarm1 = 30 + random(60);
	target = scrUGTarget();
	
	if(type == "head"){
		walk = true;
		
		               
		if(active){
			
			// Friendly actors must not keep the whole chain in combat.
			if(instance_exists(Portal) || !scrUGCombatRemains(true)){
				
				                    
				var _inst = id;
				while(instance_exists(_inst)){
					for(var _ug_each0=scrNTTEFullInstances(_inst),_ug_each0i=0;_ug_each0i<array_length(_ug_each0);++_ug_each0i) with(_ug_each0[_ug_each0i]){
						
						maxspeed = 7;
						active   = false;
						canmelee = false;
						
						_inst = child;
					}
				}
			}
		}
		
		if(instance_exists(target)){
			alarm1 = 1;
			
			if(active){
			
				var _tdis = point_distance(x, y, target.x, target.y);
				if((!place_meeting(x, y, Floor) || _tdis > 320) && _tdis > 160){
					
					var _tdir = point_direction(x, y, target.x, target.y);
					gunangle += angle_difference(_tdir, gunangle) * 1/24;         
				}
			}
			else{
				
				               
				var _tdir = point_direction(target.x, target.y, x, y);
				gunangle += angle_difference(_tdir, gunangle) * 1/16;
			}
		}
	}
}

// Undergrowth area::MillipedeSegment_hurt
function scrUG_MillipedeSegment_hurt(_dmg, _spd, _dir) {
speed = custom_spd;
	direction = custom_dir;
	
	scrUG_enemy_hurt(_dmg, _spd, _dir);
	
	custom_spd = speed;
	custom_dir = direction;
	
	          
	var _snd = snd_play_hit(sndPlantSnareTrapper, 0);
	audio_sound_pitch(_snd, 0.8 + random(0.3));
	audio_sound_set_track_position(_snd, 0.4);
	
	audio_sound_set_track_position(snd_play_hit(sndEnergyHammer, 0.3), 0.05);
	audio_sound_pitch(snd_play_hit(snd_hurt, 0), 0.7 + random(0.3));
}

// Undergrowth area::MillipedeSegment_death
function scrUG_MillipedeSegment_death() {
instance_create(x, y, PortalClear);
	
	for(var d = 0; d < 360; d += (360 / 4)){
		for(var _ug_each0=scrNTTEFullInstances(instance_create(x, y, BloodStreak)),_ug_each0i=0;_ug_each0i<array_length(_ug_each0);++_ug_each0i) with(_ug_each0[_ug_each0i]){
			sprite_index = sprUGFuelStreak;
			direction	 = d + orandom(10);
			image_angle  = direction;
			speed=( 4)*timescale;
		}
	}
	
	                       
	scrNTTEFullWorldPickupDrop(20, 0);
	
	           
	var _snd = snd_play_hit(sndPlantSnareTrapperTB, 0);
	audio_sound_pitch(_snd, 0.8 + random(0.3));
	audio_sound_set_track_position(_snd, 0.2);
	
	var _snd = snd_play_hit(sndPlasmaBigUpg, 0);
	audio_sound_pitch(_snd, 0.3);
	audio_sound_gain(_snd, 0.7, 0);
	audio_sound_set_track_position(_snd, 0.5);
	
	audio_sound_set_track_position(snd_play_hit(sndEnergyHammer, 0.3), 0.05);
	audio_sound_pitch(snd_play_hit(snd_dead, 0), 0.7 + random(0.3));
}

// Undergrowth area::Mushroom_create
function scrUG_Mushroom_create(_x, _y) {
for(var _ug_each0=scrNTTEFullInstances(instance_create(_x, _y, UGProp)),_ug_each0i=0;_ug_each0i<array_length(_ug_each0);++_ug_each0i) with(_ug_each0[_ug_each0i]){
		name = "Mushroom";
		
		           
		spr_idle = sprUGMushroom1Idle;
		spr_hurt = sprUGMushroom1Hurt;
		spr_dead = sprUGMushroom1Dead;
		spr_fire = sprUGMushroom1Explode;
		spr_shadow = shd16;
		spr_shadow_y = 5;
		sprite_index = spr_idle;
		hitid = [sprite_index, "MUSHROOM BOMB"];
		
		           
		snd_hurt = sndHitPlant;
		snd_dead = sndPlantSnareTB;
		
		         
		max_hp = 17;
		hp = max_hp;
		size = 5;
		
		           
		on_death = scrUGRef(scrUG_Mushroom_death);
		
		return id;
	}
}

// Undergrowth area::Mushroom_death
function scrUG_Mushroom_death() {
for(var _ug_each0=scrNTTEFullInstances(scrUGCreate(x, y, "MushroomExplode")),_ug_each0i=0;_ug_each0i<array_length(_ug_each0);++_ug_each0i) with(_ug_each0[_ug_each0i]){
		spr_dead	 = other.spr_dead;
		spr_shadow	 = other.spr_shadow;
		spr_shadox_x = other.spr_shadow_x;
		spr_shadow_y = other.spr_shadow_y;
		sprite_index = other.spr_fire;
		image_xscale = other.image_xscale;
		depth		 = other.depth;
		hitid		 = other.hitid;
		size		 = other.size;
	}
}

// Undergrowth area::MushroomExplode_create
function scrUG_MushroomExplode_create(_x, _y) {
for(var _ug_each0=scrNTTEFullInstances(instance_create(_x, _y, UGObject)),_ug_each0i=0;_ug_each0i<array_length(_ug_each0);++_ug_each0i) with(_ug_each0[_ug_each0i]){
		name = "MushroomExplode";
		
		           
		spr_dead	 = sprUGMushroom1Dead;
		spr_shadow	 = shd16;
		spr_shadow_x = 0;
		spr_shadow_y = 0;
		sprite_index = sprUGMushroom1Explode;
		image_speed=( 0.4)*timescale;
		hitid		 = [mskNone, ""];
		
		         
		size = 0;
		
		           
		on_step = scrUGRef(scrUG_MushroomExplode_step);
		
		return id;
	}
}

// Undergrowth area::MushroomExplode_step
function scrUG_MushroomExplode_step() {
x = xstart;
	y = ystart;
	speed=( 0)*timescale;
	
	if(random(5) < timescale){
		for(var _ug_each0=scrNTTEFullInstances(scrUGCreate(random_range(bbox_left, bbox_right), random_range(bbox_top, bbox_bottom), "FlamePuff")),_ug_each0i=0;_ug_each0i<array_length(_ug_each0);++_ug_each0i) with(_ug_each0[_ug_each0i]){
			
		}
	}
	
	if(((image_index+image_speed)>=image_number || (image_index+image_speed)<0)){
		for(var _ug_each1=scrNTTEFullInstances(scrUGCreate(x, y, "MushroomExplosion")),_ug_each1i=0;_ug_each1i<array_length(_ug_each1);++_ug_each1i) with(_ug_each1[_ug_each1i]){
			hitid = other.hitid;
		}
		
		for(var _ug_each2=scrNTTEFullInstances(instance_create(x, y, Corpse)),_ug_each2i=0;_ug_each2i<array_length(_ug_each2);++_ug_each2i) with(_ug_each2[_ug_each2i]){
			sprite_index = other.spr_dead;
			size		 = other.size;
		}
		
		            
		instance_destroy();
	}
}

// Undergrowth area::MushroomExplosion_create
function scrUG_MushroomExplosion_create(_x, _y) {
for(var _ug_each0=scrNTTEFullInstances(instance_create(_x, _y, Explosion)),_ug_each0i=0;_ug_each0i<array_length(_ug_each0);++_ug_each0i) with(_ug_each0[_ug_each0i]){
		name = "MushroomExplosion";
		
		           
		sprite_index = sprUGMushroomExplosion;
		image_speed=( 0.4)*timescale;
		image_alpha  = -1;
		hitid		 = [sprite_index, "EXPLOSION"];
		
		         
		mask_index = mskUGMushroomExplosion;
		depth = -7;
		team = -1;
		force = 6;
		damage = 5;
		
		          
		for(var _ug_each1=scrNTTEFullInstances(instance_create(x, y, PortalClear)),_ug_each1i=0;_ug_each1i<array_length(_ug_each1);++_ug_each1i) with(_ug_each1[_ug_each1i]){
			image_xscale = 3/2;
			image_yscale = 3/2;
		}
		
		scrNTTEFullFrameSleepRequest(60);
		scrNTTEFullTrenchShake(x, y, 80);
		
		var _pitch = audio_sound_get_pitch(snd_play_gun(sndExplosionL, 0.3, -0.5));
		scrUGSoundPitchVol(sndFlameCannon,    _pitch, 0.65);
		scrUGSoundPitchVol(sndFlameCannonEnd, _pitch, 0.65);	
		scrUGSoundPitchVol(sndExplosionXL,    _pitch, 0.75);
		
		return id;
	}
}

// Undergrowth area::MushroomSpawn_create
function scrUG_MushroomSpawn_create(_x, _y) {
for(var _ug_each0=scrNTTEFullInstances(instance_create(_x, _y, UGObject)),_ug_each0i=0;_ug_each0i<array_length(_ug_each0);++_ug_each0i) with(_ug_each0[_ug_each0i]){
		name = "MushroomSpawn";
		
		           
		sprite_index = sprUGMushroom1Spawn;
		image_xscale = choose(-1, 1);
		image_speed=( 0.4)*timescale;
		
		         
		delay = random(30);
		
		           
		on_step = scrUGRef(scrUG_MushroomSpawn_step);
		
		return id;
	}
}

// Undergrowth area::MushroomSpawn_step
function scrUG_MushroomSpawn_step() {
if(delay > 0){
		delay -= timescale;
		image_index -= image_speed;
		
		           
		if(delay <= 0){
			audio_sound_pitch(snd_play_hit(sndBouncerBounce, 0), 0.5);
		}
	}

	if(((image_index+image_speed)>=image_number || (image_index+image_speed)<0)){
		for(var _ug_each0=scrNTTEFullInstances(scrUGCreate(x, y, "Mushroom")),_ug_each0i=0;_ug_each0i<array_length(_ug_each0);++_ug_each0i) with(_ug_each0[_ug_each0i]){
			image_xscale = other.image_xscale;
		}
		
		            
		instance_destroy();
	}
}

// Undergrowth area::PitcherPlant_create
function scrUG_PitcherPlant_create(_x, _y) {
for(var _ug_each0=scrNTTEFullInstances(instance_create(_x, _y, UGEnemy)),_ug_each0i=0;_ug_each0i<array_length(_ug_each0);++_ug_each0i) with(_ug_each0[_ug_each0i]){
		name = "PitcherPlant";
		
		           
		spr_idle = sprUGPitcherPlantIdle;
		spr_walk = sprUGPitcherPlantWalk;
		spr_hurt = sprUGPitcherPlantHurt;
		spr_dead = sprUGPitcherPlantDead;
		spr_chrg = sprUGPitcherPlantCharge;
		spr_fire = sprUGPitcherPlantFire;
		spr_shadow = shd32;
		spr_shadow_y = 6;
		sprite_index = spr_idle;
		hitid = [sprite_index, "PITCHER PLANT"];
		depth = -2;
		
		           
		snd_hurt = sndFireballerHurt;
		snd_dead = sndFireballerDead;
		
		         
		mask_index = mskLaserCrystal;
		max_hp = 25;
		hp = max_hp;
		size = 2;
		raddrop = 20;
		maxspeed = 2.8;
		friction=( 0.4)*sqr(timescale);
		walkspeed = 0.6;
		right = choose(-1, 1);
		walk = 0;
		gunangle = 0;
		nextfire = 0;
		light_coeff = 0;
		light_delta = 0;
		draw_hurt = 0;
		gold = false;
		ammo = 0;
		angle_coeff = choose(-1, 1);
		
		           
		alarm1 = 60 + random(60);
		alarm2 = -1;
		
		           
		on_step  = scrUGRef(scrUG_PitcherPlant_step);
		on_death = scrUGRef(scrUG_PitcherPlant_death);
		on_draw  = scrUGRef(scrUG_plant_draw);
		on_hurt  = scrUGRef(scrUG_plant_hurt);
		on_alrm1 = scrUGRef(scrUG_PitcherPlant_alrm1);
		on_alrm2 = scrUGRef(scrUG_PitcherPlant_alrm2);
		
		return id;
	}
}

// Undergrowth area::PitcherPlant_step
function scrUG_PitcherPlant_step() {
if(scrUGAlarm(1)) return;
	if(scrUGAlarm(2)) return;

	            
	if(((image_index+image_speed)>=image_number || (image_index+image_speed)<0) && sprite_index != spr_chrg){
		sprite_index = ((speed/timescale) == 0) ? spr_idle : spr_walk;
	}
	
	           
	if(walk > 0){
		walk -= timescale;
		scrUGMotionAddCT(direction, walkspeed);
	}
	if((speed/timescale) > maxspeed){
		speed=( maxspeed)*timescale;
	}
	
	          
	light_coeff = clamp(light_coeff + (light_delta * timescale), 0, 1);
	
	            
	if(gold){
		if(random(60) < timescale){
			for(var _ug_each0=scrNTTEFullInstances(instance_create(random_range(bbox_left, bbox_right), random_range(bbox_top, bbox_bottom), RecycleGland)),_ug_each0i=0;_ug_each0i<array_length(_ug_each0);++_ug_each0i) with(_ug_each0[_ug_each0i]){
				depth		 = other.depth - 1;
				sprite_index = choose(sprEatRad, sprEatRadPlut, sprEatBigRad, sprEatBigRadPlut);
				image_speed=( 1)*timescale;
			}
		}
	}
	 
	                                  
	scrUG_plant_heal();
}

// Undergrowth area::PitcherPlant_alrm1
function scrUG_PitcherPlant_alrm1() {
alarm1 = 30 + random(20);
	target = scrUGTarget();
	
	if(instance_exists(target) && !collision_line(x, y, target.x, target.y, Wall, false, false)){
		gunangle = point_direction(x, y, target.x, target.y);
		var _dis = point_distance(x, y, target.x, target.y);
		
		                 
		if(_dis < 96){
			if(random(5) < 3){
				sprite_index = spr_chrg;
				image_index  = 0;
				
				scrUGMotionAdd(gunangle + 180, 2);
				
				alarm2 = 13;
				alarm1 = -1;
				
				light_coeff = 2/3;
				light_delta = 0.1;
				
				instance_create(x, y, PortalClear);
				
				           
				audio_sound_set_track_position(snd_play_hit(sndPlantSnare, 0.3), 0.1);
			}
		}
		else if(_dis < 240){
			
			walk = 25 + random(10);
			direction = gunangle + orandom(30);
			
			sprite_index = spr_walk;
			image_index  = 0;
			
			scrUGMotionAdd(direction, (friction/sqr(timescale)));
		}
	}
	else{
		gunangle = direction;
		
		walk = 20 + random(5);
		direction += orandom(90);
		
		sprite_index = spr_walk;
		image_index  = 0;
		
		scrUGMotionAdd(direction, (friction/sqr(timescale)));
	}
	
	               
	scrUGFace(gunangle);
}

// Undergrowth area::PitcherPlant_alrm2
function scrUG_PitcherPlant_alrm2() {
alarm1 = 60 + random(30);

	sprite_index = spr_fire;
	image_index  = 0;
	
	scrUGMotionAdd(gunangle, 4);
	
	                          
	var l = 12,
		d = gunangle;
		
	for(var _ug_each0=scrNTTEFullInstances(scrUGCreate(x + lengthdir_x(l, d), y + lengthdir_y(l, d), "DirectionalExplosion")),_ug_each0i=0;_ug_each0i<array_length(_ug_each0);++_ug_each0i) with(_ug_each0[_ug_each0i]){
		direction	 = d;
		ammo		 = 5 + irandom(2);
		team		 = other.team;
		hitid		 = other.hitid;
		creator		 = other.id;
		delay_max	 = 2;
		angle_random = 17;
	}
	
	light_delta = -0.2;
	
	            
	for(var _ug_each1=scrNTTEFullInstances(scrUGCreate(x, y, "LavaSplash")),_ug_each1i=0;_ug_each1i<array_length(_ug_each1);++_ug_each1i) with(_ug_each1[_ug_each1i]){
		sprite_index = sprUGLavaSplash;
		image_angle  = other.gunangle;
		depth		 = other.depth - 1;
	}
	
	           
	audio_sound_set_track_position(snd_play_hit(sndPlantSnareTrapperTB,  0.2), 0.3);
	audio_sound_set_track_position(snd_play_hit(sndJungleAssassinAttack, 0.2), 0.1);
}

// Undergrowth area::PitcherPlant_death
function scrUG_PitcherPlant_death() {
for(var _ug_each0=scrNTTEFullInstances(instance_create(x, y, Explosion)),_ug_each0i=0;_ug_each0i<array_length(_ug_each0);++_ug_each0i) with(_ug_each0[_ug_each0i]){
		hitid = other.hitid;
		team  = other.team;
	}
	
	snd_play_hit(sndExplosion, 0.3);
	
	scrNTTEFullWorldPickupDrop(35, 4);
}

// Undergrowth area::UndergrowthBandit_create
function scrUG_UndergrowthBandit_create(_x, _y) {
for(var _ug_each0=scrNTTEFullInstances(instance_create(_x, _y, Bandit)),_ug_each0i=0;_ug_each0i<array_length(_ug_each0);++_ug_each0i) with(_ug_each0[_ug_each0i]){
		name = "UndergrowthBandit";
		
		           
		spr_idle	 = sprUGUndergrowthBanditIdle;
		spr_walk	 = sprUGUndergrowthBanditWalk;
		spr_hurt	 = sprUGUndergrowthBanditHurt;
		spr_dead	 = sprUGUndergrowthBanditDead;
		gunspr		 = sprUGUndergrowthBanditGun;
		sprite_index = spr_idle;
		hitid		 = [sprite_index, "BANDIT"];
		
		         
		max_hp = 8;
		hp = max_hp;
		
		return id;
	}
}

// Undergrowth area::Vine_create
function scrUG_Vine_create(_x, _y) {
for(var _ug_each0=scrNTTEFullInstances(instance_create(_x, _y, UGProp)),_ug_each0i=0;_ug_each0i<array_length(_ug_each0);++_ug_each0i) with(_ug_each0[_ug_each0i]){
		name = "Vine";
		
		           
		var _num=irandom_range(1,2);
spr_idle=(_num==1?sprUGVine1Idle:sprUGVine2Idle);
spr_hurt=(_num==1?sprUGVine1Hurt:sprUGVine2Hurt);
spr_dead=(_num==1?sprUGVine1Dead:sprUGVine2Dead);
spr_shadow=-1;
		sprite_index = spr_idle;
		
		           
		snd_hurt = sndHitPlant;
		snd_dead = sndPlantSnare;
		
		         
		max_hp = 12;
		hp = max_hp;
		size = 1;
		
		return id;
	}
}

// Undergrowth area::VineChest_create
function scrUG_VineChest_create(_x, _y) {
for(var _ug_each0=scrNTTEFullInstances(instance_create(_x, _y, chestprop)),_ug_each0i=0;_ug_each0i<array_length(_ug_each0);++_ug_each0i) with(_ug_each0[_ug_each0i]){
		name = "VineChest";
		
		           
		spr_dead = sprUGVineChestOpen;
		sprite_index = sprUGVineChest;
		spr_shadow = shd32;
		
		return id;
	}
}

// Undergrowth area::Woo_create
function scrUG_Woo_create(_x, _y) {
for(var _ug_each0=scrNTTEFullInstances(instance_create(_x, _y, UGEnemy)),_ug_each0i=0;_ug_each0i<array_length(_ug_each0);++_ug_each0i) with(_ug_each0[_ug_each0i]){
		name = "Woo";
		
		           
		spr_idle = sprUGWooIdle;
		spr_walk = sprUGWooWalk;
		spr_hurt = sprUGWooHurt;
		spr_dead = sprUGWooDead;
		spr_shadow = shd24;
		spr_shadow_y = -1;
		sprite_index = spr_idle;
		depth = -2;
		hitid = [sprite_index, "???"];
		
		           
		snd_hurt = sndMolefishHurt;
		snd_dead = sndMolefishDead;
		
		         
		mask_index = mskBandit;
		max_hp = 30;
		hp = max_hp;
		canmelee = true;
		meleedamage = 1;
		size = 1;
		walk = 0;
		walkspeed = 0.8;
		maxspeed = 2.4;
		
		           
		alarm1 = 30;
		
		           
		on_step = scrUGRef(scrUG_Woo_step);
		on_hurt = scrUGRef(scrUG_enemy_hurt);
		on_draw = scrUGRef(scrUG_enemy_draw);
		on_alrm1 = scrUGRef(scrUG_Woo_alrm1);
		
		return id;
	}
}

// Undergrowth area::Woo_step
function scrUG_Woo_step() {
if(scrUGAlarm(1)) return;
	
	            
	if(((image_index+image_speed)>=image_number || (image_index+image_speed)<0)){
		sprite_index = ((speed/timescale) > 0) ? spr_walk : spr_idle;
	}
	
	             
	if(walk > 0){
		walk -= timescale;
		scrUGMotionAddCT(direction, walkspeed);
	}
	if((speed/timescale) > maxspeed){
		speed=( maxspeed)*timescale;
	}
}

// Undergrowth area::Woo_alrm1
function scrUG_Woo_alrm1() {
alarm1 = 30 + random(30);
	target = scrUGTarget();
	
	walk = 20 + random(20);
	
	sprite_index = spr_walk;
	image_index  = 0;
	
	direction += orandom(90);

	scrUGMotionAdd(direction, (friction/sqr(timescale)));
	scrUGFace(direction);
	
	var _mush = true;
	if(instance_exists(UGProp)){
		var _inst = scrUGMatching(UGProp, "name", "Mushroom");
		if(array_length(_inst)) for(var _ug_each0=scrNTTEFullInstances(_inst),_ug_each0i=0;_ug_each0i<array_length(_ug_each0);++_ug_each0i) with(_ug_each0[_ug_each0i]){
			if(point_distance(x, y, other.x, other.y) <= 24){
				_mush = false;
				return;
			}
		}
	}
	if(_mush){
		scrUGCreate(x, y, "MushroomSpawn");
	}
}

// Undergrowth area::enemy_draw
function scrUG_enemy_draw() {
draw_sprite_ext(sprite_index, image_index, x, y, image_xscale * right, image_yscale, image_angle, image_blend, image_alpha);
}

// Undergrowth area::plant_draw
function scrUG_plant_draw() {
var _hurt = (sprite_index != spr_hurt && draw_hurt > current_frame);
	if(_hurt) scrUGDrawHurt(true, image_blend, 0, 0);
	
	scrUG_enemy_draw();
	
	if(_hurt) scrUGDrawHurt(false, c_white, 0, 0);
}

// Undergrowth area::enemy_hurt
function scrUG_enemy_hurt(_dmg, _spd, _dir) {
sprite_index = spr_hurt;
	image_index  = 0;
	
	snd_play_hit(snd_hurt, 0.3);
	scrUGMotionAdd(_dir, _spd);
	
	nexthurt   = current_frame + 6;
	hp -= _dmg;
}

// Undergrowth area::plant_hurt
function scrUG_plant_hurt(_dmg, _spd, _dir) {
if(sprite_index == spr_idle || sprite_index == spr_walk || sprite_index == spr_hurt){
		sprite_index = spr_hurt;
		image_index  = 0;
	}
	
	snd_play_hit(snd_hurt, 0.3);
	scrUGMotionAdd(_dir, _spd);
	
	hp -= _dmg;
	
	                  
	if(sprite_index != spr_chrg){
		nexthurt = current_frame + 6;
	}
	
	                
	draw_hurt = current_frame + (timescale / (image_speed/timescale));
}

// Undergrowth area::plant_heal
function scrUG_plant_heal() {
if(nextfire <= current_frame){
		if(place_meeting(x, y, Explosion)){
			var _inst = scrUGMeeting(x, y, scrUGMatchingNE(scrUGMatching(scrUGMatchingNE(Explosion, "object_index", PopoExplosion), "team", team), "creator", id));
			
			if(array_length(_inst)){
				for(var _ug_each0=scrNTTEFullInstances(_inst),_ug_each0i=0;_ug_each0i<array_length(_ug_each0);++_ug_each0i) with(_ug_each0[_ug_each0i]){
					if(place_meeting(x, y, other.id)){
						
						var _ultra = (instance_is(id, GreenExplosion) || (variable_instance_exists(id,"name") && (name == "SmallGreenExplosion" || name == "GreenDirectionalExplosion" || name == "GreenMushroomExplosion"))),                              
							_heal  = damage;
							
						for(var _ug_each1=scrNTTEFullInstances(other.id),_ug_each1i=0;_ug_each1i<array_length(_ug_each1);++_ug_each1i) with(_ug_each1[_ug_each1i]){
							
							          
							for(var _ug_each2=scrNTTEFullInstances(instance_create(x, bbox_top, UGPlantHeal)),_ug_each2i=0;_ug_each2i<array_length(_ug_each2);++_ug_each2i) with(_ug_each2[_ug_each2i]){
								sprite_index = _ultra ? sprUGHealFireUltra : sprUGHealFire;
								depth		 = other.depth - 1;
								creator		 = other.id;
							}
							
							         
							hp = min(hp + _heal, max_hp);
							nextfire  = current_frame + 6;
						}
						
						return;
					}
				}
			}
		}
	}
}

// Undergrowth weapons/fossil cannon.wep.gml::weapon_sprt
function scrUG_fossil_cannon_weapon_sprt() {
return sprUGFossilCannon;
}

// Undergrowth weapons/fossil cannon.wep.gml::weapon_name
function scrUG_fossil_cannon_weapon_name() {
return "FOSSIL CANNON";
}

// Undergrowth weapons/fossil cannon.wep.gml::weapon_text
function scrUG_fossil_cannon_weapon_text() {
return "DINOSAUR HUNTER";
}

// Undergrowth weapons/fossil cannon.wep.gml::weapon_type
function scrUG_fossil_cannon_weapon_type() {
return 4;
}

// Undergrowth weapons/fossil cannon.wep.gml::weapon_cost
function scrUG_fossil_cannon_weapon_cost() {
return 4;
}

// Undergrowth weapons/fossil cannon.wep.gml::weapon_auto
function scrUG_fossil_cannon_weapon_auto() {
return false;
}

// Undergrowth weapons/fossil cannon.wep.gml::weapon_load
function scrUG_fossil_cannon_weapon_load() {
return 30;
}

// Undergrowth weapons/fossil cannon.wep.gml::weapon_area
function scrUG_fossil_cannon_weapon_area() {
return 11;
}

// Undergrowth weapons/fossil cannon.wep.gml::weapon_swap
function scrUG_fossil_cannon_weapon_swap() {
audio_sound_set_track_position(scrUGSoundPitchVol(sndWallBreakJungle, 1.2, 1.2), 0.65);
	return sndSwapExplosive;
}

// Undergrowth weapons/fossil cannon.wep.gml::weapon_reloaded
function scrUG_fossil_cannon_weapon_reloaded() {
repeat(3) scrUGCreate(x, y, "Ember");
}

// Undergrowth weapons/fossil cannon.wep.gml::weapon_fire
function scrUG_fossil_cannon_weapon_fire() {
var l = 8,
    	d = gunangle + (accuracy * orandom(4));
      
    for(var _ug_each0=scrNTTEFullInstances(scrUG_fossil_cannon_LavaBombBig_create(x, y)),_ug_each0i=0;_ug_each0i<array_length(_ug_each0);++_ug_each0i) with(_ug_each0[_ug_each0i]){
    	scrUGContact(d, l);
    	
        creator     = other.id;
        team        = other.team;
        accuracy	= other.accuracy;
        image_angle = d;
        direction   = d;
        speed=( 10)*timescale;
        
	    for(var _ug_each1=scrNTTEFullInstances(scrUGCreate(x, y, "LavaStreak")),_ug_each1i=0;_ug_each1i<array_length(_ug_each1);++_ug_each1i) with(_ug_each1[_ug_each1i]){
	    	image_angle = d;
	    	direction   = d;
	    	speed=( 4)*timescale;
        }
    }
    
                  
    scrUGWeaponPost(24, 24, 16);
    scrNTTEFullFrameSleepRequest(90);
    
    var _dir = gunangle + 180;
    scrUGMotionAdd(_dir, 4);
    scrUGContact(_dir, 8);
    
                   
    scrUGCreate(x, y, "FlamePuff");
        
               
    snd_play_gun(sndDoubleFireShotgun, 0.3, 0.3);
    scrUGSoundPitch(sndJungleAssassinAttack, 1.5);
    audio_sound_set_track_position(scrUGSoundPitchVol(sndBloodGamble, 0.8, 0.8), 0.07);
    
                  
	for(var _ug_each2=scrNTTEFullInstances(instance_create(x,y,UGKnockback)),_ug_each2i=0;_ug_each2i<array_length(_ug_each2);++_ug_each2i) with(_ug_each2[_ug_each2i]){
		creator   = other.id;
		time	  = 3;
		speed=( 6)*timescale;
		direction = _dir;
	}
}

// Undergrowth weapons/fossil cannon.wep.gml::knockback_step
function scrUG_fossil_cannon_knockback_step() {
for(var _ug_each0=scrNTTEFullInstances(creator),_ug_each0i=0;_ug_each0i<array_length(_ug_each0);++_ug_each0i) with(_ug_each0[_ug_each0i]){
		direction = other.direction; 
		speed=( (other.speed/timescale))*timescale;
	}
	
	        
	time -= timescale;
	if(time <= 0){
		instance_destroy();
	}
}

// Undergrowth weapons/fossil cannon.wep.gml::LavaBombBig_create
function scrUG_fossil_cannon_LavaBombBig_create(_x, _y) {
for(var _ug_each0=scrNTTEFullInstances(instance_create(_x, _y, UGProjectile)),_ug_each0i=0;_ug_each0i<array_length(_ug_each0);++_ug_each0i) with(_ug_each0[_ug_each0i]){
		name = "LavaBombBig";
		
		           
		sprite_index = sprUGLavaBombBig;
		image_speed=( 0.4)*timescale;
		
		         
		mask_index = mskSuperFlakBullet;
		friction=( 0.1)*sqr(timescale);
		damage = 4;     
		force = 8;
		typ = 1;
		accuracy = 1;
		
		               
		ammo_type	 = 4;
		is_explosive = true;
		
		           
		alarm0 = 6;
		
		           
		on_step = scrUGRef(scrUG_fossil_cannon_LavaBombBig_step);
		on_wall = scrUGRef(scrUG_fossil_cannon_LavaBombBig_wall);
		on_hit = scrUGRef(scrUG_fossil_cannon_LavaBombBig_hit);
		on_alrm0 = scrUGRef(scrUG_fossil_cannon_LavaBombBig_alrm0);
		on_destroy = scrUGRef(scrUG_fossil_cannon_LavaBombBig_destroy);
		
		return id;
	}
}

// Undergrowth weapons/fossil cannon.wep.gml::LavaBombBig_step
function scrUG_fossil_cannon_LavaBombBig_step() {
if(scrUGAlarm(0)) return;
	
	            
	if(random(5) < (2 * timescale)){
		scrUGCreate(random_range(bbox_left, bbox_right), random_range(bbox_top, bbox_bottom), "FlameSparkle");
	}
	
	            
	if((speed/timescale) <= 0.8){
	    instance_destroy();
	}
}

// Undergrowth weapons/fossil cannon.wep.gml::LavaBombBig_wall
function scrUG_fossil_cannon_LavaBombBig_wall() {
var d = direction,
		l = 24;
	
	scrUGBounce(false);
	speed*=( 0.6);
	
	for(var _ug_each0=scrNTTEFullInstances(scrUGCreate(x + lengthdir_x(l, d), y + lengthdir_y(l, d), "LavaSplash")),_ug_each0i=0;_ug_each0i<array_length(_ug_each0);++_ug_each0i) with(_ug_each0[_ug_each0i]){
		image_angle = d + 180;
		depth		= other.depth - 1;
	}
}

// Undergrowth weapons/fossil cannon.wep.gml::LavaBombBig_hit
function scrUG_fossil_cannon_LavaBombBig_hit() {
if(scrUGCanHit(other.id)){
		scrUGHit(other.id, damage, force, direction);
		
		              
		scrNTTEFullFrameSleepRequest(10 + (10 * other.size));
		
		               
		if(!instance_is(other.id, prop)){
			speed*=( (1 - (friction/sqr(timescale))));
		}
	}
}

// Undergrowth weapons/fossil cannon.wep.gml::LavaBombBig_alrm0
function scrUG_fossil_cannon_LavaBombBig_alrm0() {
friction=( 0.4)*sqr(timescale);
}

// Undergrowth weapons/fossil cannon.wep.gml::LavaBombBig_destroy
function scrUG_fossil_cannon_LavaBombBig_destroy() {
scrNTTEFullFrameSleepRequest(45);
    
    repeat(5){
		for(var _ug_each0=scrNTTEFullInstances(instance_create(x, y, SmallExplosion)),_ug_each0i=0;_ug_each0i<array_length(_ug_each0);++_ug_each0i) with(_ug_each0[_ug_each0i]){
			hitid = 56;                   
		}
    }
    
	for(var _ug_each1=scrNTTEFullInstances(instance_create(x, y, Explosion)),_ug_each1i=0;_ug_each1i<array_length(_ug_each1);++_ug_each1i) with(_ug_each1[_ug_each1i]){
		hitid = 55;             
	}
    
    for(var o = 0; o < 360; o += (360 / 7)){
    	var d = image_angle + o;
    	
	      
                                                    
                          
                                      
                           
                          
                          
                                            
                           
      
       
	    for(var _ug_each2=scrNTTEFullInstances(scrUGCreate(x, y, "DirectionalExplosion")),_ug_each2i=0;_ug_each2i<array_length(_ug_each2);++_ug_each2i) with(_ug_each2[_ug_each2i]){
	        direction    = d;
	        creator      = other.creator;
	        ammo         = 4 + irandom(1);
	        damage       = 4;
	        force        = 8;
	        angle_random = 12 * other.accuracy;
	    }
    }
}

// Undergrowth weapons/fossil gun.wep.gml::weapon_sprt
function scrUG_fossil_gun_weapon_sprt() {
return sprUGFossilGun;
}

// Undergrowth weapons/fossil gun.wep.gml::weapon_name
function scrUG_fossil_gun_weapon_name() {
return "FOSSIL GUN";
}

// Undergrowth weapons/fossil gun.wep.gml::weapon_text
function scrUG_fossil_gun_weapon_text() {
return "PREHISTORIC";
}

// Undergrowth weapons/fossil gun.wep.gml::weapon_area
function scrUG_fossil_gun_weapon_area() {
return 9;
}

// Undergrowth weapons/fossil gun.wep.gml::weapon_type
function scrUG_fossil_gun_weapon_type() {
return 4;
}

// Undergrowth weapons/fossil gun.wep.gml::weapon_cost
function scrUG_fossil_gun_weapon_cost() {
return 3;
}

// Undergrowth weapons/fossil gun.wep.gml::weapon_auto
function scrUG_fossil_gun_weapon_auto() {
return false;
}

// Undergrowth weapons/fossil gun.wep.gml::weapon_load
function scrUG_fossil_gun_weapon_load() {
return 20;
}

// Undergrowth weapons/fossil gun.wep.gml::weapon_swap
function scrUG_fossil_gun_weapon_swap() {
audio_sound_set_track_position(scrUGSoundPitchVol(sndWallBreakJungle, 1.2, 1.2), 0.65);
	return sndSwapExplosive;
}

// Undergrowth weapons/fossil gun.wep.gml::weapon_reloaded
function scrUG_fossil_gun_weapon_reloaded() {
repeat(2) scrUGCreate(x, y, "Ember");
}

// Undergrowth weapons/fossil gun.wep.gml::weapon_fire
function scrUG_fossil_gun_weapon_fire() {
var o = 24 * accuracy,
    	l = 8;
    	
                   
    for(var i = -1; i <= 1; i++){
    	var d = gunangle + (o * i) + (accuracy * orandom(2));
    	
	    for(var _ug_each0=scrNTTEFullInstances(scrUG_fossil_gun_LavaBomb_create(x, y)),_ug_each0i=0;_ug_each0i<array_length(_ug_each0);++_ug_each0i) with(_ug_each0[_ug_each0i]){
	    	scrUGContact(d, l);
	    	
	        creator     = other.id;
	        team        = other.team;
	        accuracy	= other.accuracy;
	        image_angle = d;
	        direction   = d;
	        speed=( 8)*timescale;
	        
		    for(var _ug_each1=scrNTTEFullInstances(scrUGCreate(x, y, "LavaStreak")),_ug_each1i=0;_ug_each1i<array_length(_ug_each1);++_ug_each1i) with(_ug_each1[_ug_each1i]){
		    	image_angle = d;
		    	direction   = d;
		    	speed=( 4)*timescale;
		    }
	    }
    }
    
                  
    scrUGWeaponPost(16, 16, 8);
    scrNTTEFullFrameSleepRequest(60);
    
    var _dir = gunangle + 180;
    scrUGMotionAdd(_dir, 4);
    scrUGContact(_dir, 8);
    
                   
    scrUGCreate(x, y, "FlamePuff");
    
               
    snd_play_gun(sndFireShotgun, 0.3, 0.3);
    scrUGSoundPitch(sndJungleAssassinAttack, 1.5);
    audio_sound_set_track_position(scrUGSoundPitchVol(sndBloodGamble, 0.8, 0.8), 0.07);
}

// Undergrowth weapons/fossil gun.wep.gml::LavaBomb_create
function scrUG_fossil_gun_LavaBomb_create(_x, _y) {
for(var _ug_each0=scrNTTEFullInstances(instance_create(_x, _y, UGProjectile)),_ug_each0i=0;_ug_each0i<array_length(_ug_each0);++_ug_each0i) with(_ug_each0[_ug_each0i]){
		name = "LavaBomb";
		
		           
		sprite_index = sprUGLavaBomb;
		image_speed=( 0.4)*timescale;
		
		         
		mask_index = mskFlakBullet;
		friction=( 0.1)*sqr(timescale);
		damage = 3;     
		force = 8;
		typ = 1;
		accuracy = 1;
		
		               
		ammo_type	 = 4;
		is_explosive = true;
		
		           
		alarm0 = 6;
		
		           
		on_step = scrUGRef(scrUG_fossil_gun_LavaBomb_step);
		on_wall = scrUGRef(scrUG_fossil_gun_LavaBomb_wall);
		on_hit = scrUGRef(scrUG_fossil_gun_LavaBomb_hit);
		on_alrm0 = scrUGRef(scrUG_fossil_gun_LavaBomb_alrm0);
		on_destroy = scrUGRef(scrUG_fossil_gun_LavaBomb_destroy);
		
		return id;
	}
}

// Undergrowth weapons/fossil gun.wep.gml::LavaBomb_step
function scrUG_fossil_gun_LavaBomb_step() {
if(scrUGAlarm(0)) return;
	
	            
	if(random(4) < timescale){
		scrUGCreate(random_range(bbox_left, bbox_right), random_range(bbox_top, bbox_bottom), "FlameSparkle");
	}
	
	            
	if((speed/timescale) <= 0.8){
	    instance_destroy();
	}
}

// Undergrowth weapons/fossil gun.wep.gml::LavaBomb_wall
function scrUG_fossil_gun_LavaBomb_wall() {
var d = direction,
		l = 24;
	
	scrUGBounce(false);
	speed*=( 0.6);
	
	for(var _ug_each0=scrNTTEFullInstances(scrUGCreate(x + lengthdir_x(l, d), y + lengthdir_y(l, d), "LavaSplash")),_ug_each0i=0;_ug_each0i<array_length(_ug_each0);++_ug_each0i) with(_ug_each0[_ug_each0i]){
		image_angle = d + 180;
		depth		= other.depth - 1;
	}
}

// Undergrowth weapons/fossil gun.wep.gml::LavaBomb_hit
function scrUG_fossil_gun_LavaBomb_hit() {
if(scrUGCanHit(other.id)){
		scrUGHit(other.id, damage, force, direction);
		
		              
		scrNTTEFullFrameSleepRequest(10 + (10 * other.size));
		
		               
		if(!instance_is(other.id, prop)){
			speed*=( (1 - (friction/sqr(timescale))) - 0.2);
		}
	}
}

// Undergrowth weapons/fossil gun.wep.gml::LavaBomb_alrm0
function scrUG_fossil_gun_LavaBomb_alrm0() {
friction=( 0.4)*sqr(timescale);
}

// Undergrowth weapons/fossil gun.wep.gml::LavaBomb_destroy
function scrUG_fossil_gun_LavaBomb_destroy() {
scrNTTEFullFrameSleepRequest(10);
	
	for(var _ug_each0=scrNTTEFullInstances(instance_create(x,y,SmallExplosion)),_ug_each0i=0;_ug_each0i<array_length(_ug_each0);++_ug_each0i) with(_ug_each0[_ug_each0i]){
		hitid = 56;                   
	}
    for(var _ug_each1=scrNTTEFullInstances(scrUGCreate(x, y, "DirectionalExplosion")),_ug_each1i=0;_ug_each1i<array_length(_ug_each1);++_ug_each1i) with(_ug_each1[_ug_each1i]){
        direction    = other.image_angle;
        creator      = other.creator;
        ammo         = 4 + irandom(1);
        damage       = 4;
        force        = 8;
        angle_random = 4 * other.accuracy;
    }
}

// Undergrowth weapons/fossil hammer.wep.gml::weapon_sprt
function scrUG_fossil_hammer_weapon_sprt() {
return sprUGFossilHammer;
}

// Undergrowth weapons/fossil hammer.wep.gml::weapon_name
function scrUG_fossil_hammer_weapon_name() {
return "FOSSIL HAMMER";
}

// Undergrowth weapons/fossil hammer.wep.gml::weapon_text
function scrUG_fossil_hammer_weapon_text() {
return "PRIMITIVE";
}

// Undergrowth weapons/fossil hammer.wep.gml::weapon_area
function scrUG_fossil_hammer_weapon_area() {
return 9;
}

// Undergrowth weapons/fossil hammer.wep.gml::weapon_type
function scrUG_fossil_hammer_weapon_type() {
return 4;
}

// Undergrowth weapons/fossil hammer.wep.gml::weapon_cost
function scrUG_fossil_hammer_weapon_cost() {
return 3;
}

// Undergrowth weapons/fossil hammer.wep.gml::weapon_auto
function scrUG_fossil_hammer_weapon_auto() {
return false;
}

// Undergrowth weapons/fossil hammer.wep.gml::weapon_load
function scrUG_fossil_hammer_weapon_load() {
return 30;
}

// Undergrowth weapons/fossil hammer.wep.gml::weapon_melee
function scrUG_fossil_hammer_weapon_melee() {
return true;
}

// Undergrowth weapons/fossil hammer.wep.gml::weapon_swap
function scrUG_fossil_hammer_weapon_swap() {
audio_sound_set_track_position(scrUGSoundPitchVol(sndWallBreakJungle, 1.2, 1.2), 0.65);
	return sndSwapHammer;
}

// Undergrowth weapons/fossil hammer.wep.gml::weapon_reloaded
function scrUG_fossil_hammer_weapon_reloaded() {
repeat(2) scrUGCreate(x, y, "Ember");
    
    snd_play(sndMeleeFlip);
    audio_sound_set_track_position(scrUGSoundPitchVol(sndWallBreakJungle, 1.1 + random(0.2), 0.5), 0.65);
}

// Undergrowth weapons/fossil hammer.wep.gml::step
function scrUG_fossil_hammer_step(_primary) {
if(_primary && reload <= 15 && scrUGButton(index, "fire")){
		clicked = true;
	}
}

// Undergrowth weapons/fossil hammer.wep.gml::weapon_fire
function scrUG_fossil_hammer_weapon_fire() {
var _skill = scr_skill_get(mut_long_arms),
    	_len   = 20 * _skill,
        _dir   = gunangle,
        _x     = x + lengthdir_x(_len, _dir),
        _y     = y + lengthdir_y(_len, _dir);
        
                      
    for(var _ug_each0=scrNTTEFullInstances(scrUG_fossil_hammer_LavaSlash_create(_x, _y)),_ug_each0i=0;_ug_each0i<array_length(_ug_each0);++_ug_each0i) with(_ug_each0[_ug_each0i]){
        creator     = other.id;
        team        = other.team;
        accuracy	= other.accuracy;
        image_angle = _dir;
        direction   = _dir;
        speed=( lerp(2, 5, _skill))*timescale;
    }
    
                  
    wepangle *= -1;
    scrUGWeaponPost(-5, 5, 5);
    scrUGMotionAdd(gunangle, 4);
    
                
    scrUGCreate(x, y, "FlamePuff");
    
               
    snd_play_gun(sndHammer, 0.3, 0.3);
    scrUGSoundPitch(sndJungleAssassinAttack, 1.2);
    audio_sound_set_track_position(scrUGSoundPitchVol(sndBloodGamble, 0.8, 0.5), 0.07);
}

// Undergrowth weapons/fossil hammer.wep.gml::LavaSlash_create
function scrUG_fossil_hammer_LavaSlash_create(_x, _y) {
for(var _ug_each0=scrNTTEFullInstances(instance_create(_x, _y, UGSlash)),_ug_each0i=0;_ug_each0i<array_length(_ug_each0);++_ug_each0i) with(_ug_each0[_ug_each0i]){
		name = "LavaSlash";
		
		           
		sprite_index = sprUGLavaSlash;
		image_yscale = choose(-1, 1);
		image_speed=( 0.4)*timescale;
		
		         
		mask_index = mskSlash;
		damage = 23;
		force = 8;
		walled = false;
		accuracy = 1;
		candeflect = true;
		
		               
		ammo_type	 = 4;
		is_explosive = true;
		is_melee	 = true;
		
		           
		on_anim = scrUGRef(scrUG_fossil_hammer_LavaSlash_anim);
		on_hit  = scrUGRef(scrUG_fossil_hammer_LavaSlash_hit);
		on_wall = scrUGRef(scrUG_fossil_hammer_LavaSlash_wall);
		
		return id;
	}
}

// Undergrowth weapons/fossil hammer.wep.gml::LavaSlash_anim
function scrUG_fossil_hammer_LavaSlash_anim() {
instance_destroy();
}

// Undergrowth weapons/fossil hammer.wep.gml::LavaSlash_hit
function scrUG_fossil_hammer_LavaSlash_hit() {
if(scrUGCanHit(other.id)){
		scrUGHit(other.id, damage, force, direction);
		
		                                                                  
		scrNTTEFullFrameSleepRequest(35 + (10 * other.size));
		
		          
		snd_play_hit(sndExplosionS, 0.3);
		
		               
		if(!instance_is(other.id, prop)){
			
			for(var _ug_each0=scrNTTEFullInstances(instance_create(other.x, other.y, SmallExplosion)),_ug_each0i=0;_ug_each0i<array_length(_ug_each0);++_ug_each0i) with(_ug_each0[_ug_each0i]){
				hitid = 56;                   
			}
			for(var _ug_each1=scrNTTEFullInstances(scrUGCreate(other.x, other.y, "DirectionalExplosion")),_ug_each1i=0;_ug_each1i<array_length(_ug_each1);++_ug_each1i) with(_ug_each1[_ug_each1i]){
				direction	 = other.direction + (orandom(24) * other.accuracy);
				ammo		 = 3 + irandom(2);
				team		 = -1;
				hitid		 = other.hitid;
				creator		 = other.creator;
				delay_max	 = 2;
				angle_random = 24 * other.accuracy;
			}
		}
	}
}

// Undergrowth weapons/fossil hammer.wep.gml::LavaSlash_wall
function scrUG_fossil_hammer_LavaSlash_wall() {
if(!walled){
		walled = true;
		
		x += hspeed;
		y += vspeed;
		
		           
		var	_scx = (bbox_left + bbox_right)  / 2,
			_scy = (bbox_top  + bbox_bottom) / 2,
			_col = make_color_rgb(252, 56, 0);
			
		for(var _ug_each0=scrNTTEFullInstances(other.id),_ug_each0i=0;_ug_each0i<array_length(_ug_each0);++_ug_each0i) with(_ug_each0[_ug_each0i]){
			var _wcx = (bbox_left + bbox_right)  / 2,
				_wcy = (bbox_top  + bbox_bottom) / 2;
				
			for(var _ug_each1=scrNTTEFullInstances(instance_create(_wcx, _wcy, MeleeHitWall)),_ug_each1i=0;_ug_each1i<array_length(_ug_each1);++_ug_each1i) with(_ug_each1[_ug_each1i]){
				image_angle = point_direction(_scx, _scy, x, y);
				image_blend = _col;
				
				snd_play_hit(sndMeleeWall, 0.3);
				
				var _snd = snd_play_hit(sndWallBreakBrick, 0);
				audio_sound_gain(_snd, 0.5, 0);
				audio_sound_pitch(_snd, 1.4);
				audio_sound_set_track_position(_snd, 0.4);
			}
		}
		
		x -= hspeed;
		y -= vspeed;
	}
}

// Undergrowth weapons/fossil pistol.wep.gml::weapon_sprt
function scrUG_fossil_pistol_weapon_sprt() {
return sprUGFossilPistol;
}

// Undergrowth weapons/fossil pistol.wep.gml::weapon_name
function scrUG_fossil_pistol_weapon_name() {
return "FOSSIL PISTOL";
}

// Undergrowth weapons/fossil pistol.wep.gml::weapon_text
function scrUG_fossil_pistol_weapon_text() {
return "WISHBONE";
}

// Undergrowth weapons/fossil pistol.wep.gml::weapon_area
function scrUG_fossil_pistol_weapon_area() {
return 8;
}

// Undergrowth weapons/fossil pistol.wep.gml::weapon_type
function scrUG_fossil_pistol_weapon_type() {
return 4;
}

// Undergrowth weapons/fossil pistol.wep.gml::weapon_cost
function scrUG_fossil_pistol_weapon_cost() {
return 1;
}

// Undergrowth weapons/fossil pistol.wep.gml::weapon_auto
function scrUG_fossil_pistol_weapon_auto() {
return false;
}

// Undergrowth weapons/fossil pistol.wep.gml::weapon_load
function scrUG_fossil_pistol_weapon_load() {
return 10;
}

// Undergrowth weapons/fossil pistol.wep.gml::weapon_swap
function scrUG_fossil_pistol_weapon_swap() {
audio_sound_set_track_position(scrUGSoundPitchVol(sndWallBreakJungle, 1.2, 1.2), 0.65);
	return sndSwapExplosive;
}

// Undergrowth weapons/fossil pistol.wep.gml::weapon_reloaded
function scrUG_fossil_pistol_weapon_reloaded() {
repeat(1) scrUGCreate(x, y, "Ember");
}

// Undergrowth weapons/fossil pistol.wep.gml::weapon_fire
function scrUG_fossil_pistol_weapon_fire() {
var l = 8,
    	d = gunangle + (accuracy * orandom(8));
    	
                   
    for(var _ug_each0=scrNTTEFullInstances(scrUG_fossil_gun_LavaBomb_create(x,y)),_ug_each0i=0;_ug_each0i<array_length(_ug_each0);++_ug_each0i) with(_ug_each0[_ug_each0i]){
    	scrUGContact(d, l);
    	
        creator     = other.id;
        team        = other.team;
        accuracy	= other.accuracy;
        image_angle = d;
        direction   = d;
        speed=( 7)*timescale;
        
	    for(var _ug_each1=scrNTTEFullInstances(scrUGCreate(x, y, "LavaStreak")),_ug_each1i=0;_ug_each1i<array_length(_ug_each1);++_ug_each1i) with(_ug_each1[_ug_each1i]){
	    	image_angle = d;
	    	direction   = d;
	    	speed=( 3)*timescale;
	    }
    }
    
                  
    scrUGWeaponPost(12, 8, 8);
    scrNTTEFullFrameSleepRequest(30);
    
    var _dir = gunangle + 180;
    scrUGMotionAdd(_dir, 4);
    
                   
    scrUGCreate(x, y, "FlamePuff");
    
               
    audio_sound_pitch(snd_play_gun(sndFireShotgun, 0, 0.3), 1.2 + random(0.3));
    scrUGSoundPitch(sndJungleAssassinAttack, 1.7);
    audio_sound_set_track_position(scrUGSoundPitchVol(sndBloodGamble, 1, 0.7), 0.07);
    audio_sound_set_track_position(scrUGSoundPitchVol(sndLaserUpg, 1.3, 1.5), 0.4);
}

// Undergrowth weapons/mega grenade launcher.wep.gml::weapon_sprt
function scrUG_mega_grenade_launcher_weapon_sprt() {
return sprUGMegaGrenadeLauncher;
}

// Undergrowth weapons/mega grenade launcher.wep.gml::weapon_name
function scrUG_mega_grenade_launcher_weapon_name() {
return "MEGA GRENADE LAUNCHER";
}

// Undergrowth weapons/mega grenade launcher.wep.gml::weapon_text
function scrUG_mega_grenade_launcher_weapon_text() {
return "DANGEROUS";
}

// Undergrowth weapons/mega grenade launcher.wep.gml::weapon_type
function scrUG_mega_grenade_launcher_weapon_type() {
return 4;
}

// Undergrowth weapons/mega grenade launcher.wep.gml::weapon_cost
function scrUG_mega_grenade_launcher_weapon_cost() {
return 3;
}

// Undergrowth weapons/mega grenade launcher.wep.gml::weapon_auto
function scrUG_mega_grenade_launcher_weapon_auto() {
return false;
}

// Undergrowth weapons/mega grenade launcher.wep.gml::weapon_load
function scrUG_mega_grenade_launcher_weapon_load() {
return 20;
}

// Undergrowth weapons/mega grenade launcher.wep.gml::weapon_swap
function scrUG_mega_grenade_launcher_weapon_swap() {
if(instance_is(id, Player)){
		scrNTTEFullTrenchShake(x, y, 10);
		scrNTTEFullFrameSleepRequest(10);
	}
	
	return sndSwapExplosive;
}

// Undergrowth weapons/mega grenade launcher.wep.gml::weapon_area
function scrUG_mega_grenade_launcher_weapon_area() {
return scrNTTEFullValue(id,"curse",0)>0 ? 8:-1;
}

// Undergrowth weapons/mega grenade launcher.wep.gml::weapon_fire
function scrUG_mega_grenade_launcher_weapon_fire() {
for(var _ug_each0=scrNTTEFullInstances(scrUG_mega_grenade_launcher_MegaGrenade_create(x, y)),_ug_each0i=0;_ug_each0i<array_length(_ug_each0);++_ug_each0i) with(_ug_each0[_ug_each0i]){
        team        = other.team;
        creator     = other.id;
        speed=( 10)*timescale;
        direction   = other.gunangle + (other.accuracy * orandom(4));
        image_angle = direction;
        
        scrUGContact(direction, (speed/timescale));
        for(var _ug_each1=scrNTTEFullInstances(instance_create(x, y, ThrowHit)),_ug_each1i=0;_ug_each1i<array_length(_ug_each1);++_ug_each1i) with(_ug_each1[_ug_each1i]){
        	depth = -3;
        }
    }
    
                
    var d = gunangle;
    repeat(12){
    	
    	var l = random(32);
    	instance_create(x + lengthdir_x(l, d) + orandom(3), y + lengthdir_y(l, d) + orandom(3), Smoke);
    }
    
                  
    scrUGWeaponPost(27, 7, 33);
    scrNTTEFullFrameSleepRequest(50);
    
    var _dir = gunangle + 180;
    scrUGContact(_dir, 10);
    scrUGMotionAdd(_dir, 4);
    
               
    var _sound = snd_play_gun(sndHeavyNader, 0.3, 0.3),
    	_pitch = audio_sound_get_pitch(_sound) - 1;
    	
    scrUGSoundPitchVol(sndHyperSlugger, 0.7 + _pitch, 0.9);
    scrUGSoundPitchVol(sndServerBreak,  3   + _pitch, 0.9);
    
                  
	for(var _ug_each2=scrNTTEFullInstances(instance_create(x,y,UGKnockback)),_ug_each2i=0;_ug_each2i<array_length(_ug_each2);++_ug_each2i) with(_ug_each2[_ug_each2i]){
		creator   = other.id;
		time	  = 6;
		speed=( 6)*timescale;
		direction = _dir;
	}
}

// Undergrowth weapons/mega grenade launcher.wep.gml::knockback_step
function scrUG_mega_grenade_launcher_knockback_step() {
for(var _ug_each0=scrNTTEFullInstances(creator),_ug_each0i=0;_ug_each0i<array_length(_ug_each0);++_ug_each0i) with(_ug_each0[_ug_each0i]){
		direction = other.direction; 
		speed=( (other.speed/timescale))*timescale;
	}
	
	        
	time -= timescale;
	if(time <= 0){
		instance_destroy();
	}
}

// Undergrowth weapons/mega grenade launcher.wep.gml::MegaGrenade_create
function scrUG_mega_grenade_launcher_MegaGrenade_create(_x, _y) {
for(var _ug_each0=scrNTTEFullInstances(instance_create(_x, _y, UGProjectile)),_ug_each0i=0;_ug_each0i<array_length(_ug_each0);++_ug_each0i) with(_ug_each0[_ug_each0i]){
		name = "MegaGrenade";
		
		           
		spr_dead = sprUGMegaGrenadeBlink;
		sprite_index = sprUGMegaGrenade;
		image_speed=( 0.4)*timescale;
		
		         
		mask_index = sprGrenade;
		friction=( 0.1)*sqr(timescale);                   
		damage = 30;                                                                                
		force = 10;            
		typ = 1;
		
		               
		ammo_type	 = 4;
		is_explosive = true;
		is_grenade	 = true;
		
		           
		alarm0 = 70;                                                     
		alarm1 = 6;                             
		alarm2 = 50;                           
		
		           
		on_step    = scrUGRef(scrUG_mega_grenade_launcher_MegaGrenade_step);
		on_wall    = scrUGRef(scrUG_mega_grenade_launcher_MegaGrenade_wall);
		on_hit     = scrUGRef(scrUG_mega_grenade_launcher_MegaGrenade_hit);
		on_alrm0   = scrUGRef(scrUG_mega_grenade_launcher_MegaGrenade_alrm0);
		on_alrm1   = scrUGRef(scrUG_mega_grenade_launcher_MegaGrenade_alrm1);
		on_alrm2   = scrUGRef(scrUG_mega_grenade_launcher_MegaGrenade_alrm2);
		on_destroy = scrUGRef(scrUG_mega_grenade_launcher_MegaGrenade_destroy);
		
		return id;
	}
}

// Undergrowth weapons/mega grenade launcher.wep.gml::MegaGrenade_step
function scrUG_mega_grenade_launcher_MegaGrenade_step() {
if(scrUGAlarm(0)) return;
	if(scrUGAlarm(1)) return;
	if(scrUGAlarm(2)) return;
	
	            
	if(place_meeting(x, y, projectile)){
		var _inst = scrUGMatchingLE(scrUGMatchingLE(scrUGMatchingGE(scrUGMatchingGE(scrUGMatchingNE([BloodSlash, UGSlash, EnergyHammerSlash, EnergySlash, Slash, LightningSlash, Slash], "id", id), "bbox_right", bbox_left), "bbox_bottom", bbox_top), "bbox_left", bbox_right), "bbox_top", bbox_bottom);
		
		if(array_length(_inst)) for(var _ug_each0=scrNTTEFullInstances(_inst),_ug_each0i=0;_ug_each0i<array_length(_ug_each0);++_ug_each0i) with(_ug_each0[_ug_each0i]){
			if(place_meeting(x, y, other.id)){
				
				event_perform(ev_collision, Grenade);
				if(!instance_exists(other.id)) exit;
			}
		}
	}
	 
	          
	if(place_meeting(x, y, Explosion)){
		instance_destroy();
	}
}

// Undergrowth weapons/mega grenade launcher.wep.gml::MegaGrenade_wall
function scrUG_mega_grenade_launcher_MegaGrenade_wall() {
instance_create(x, y, Dust);
	scrUGBounce(false);
	
	speed*=( 0.4);        
	
	var _snd = snd_play_hit(sndGrenadeHitWall, 0);
	audio_sound_pitch(_snd, 0.8 + random(0.3));
	
	              
	scrNTTEFullFrameSleepRequest(20);
	
	                         
	if((speed/timescale) > 2){
		if(instance_is(other.id, Wall)) for(var _ug_each0=scrNTTEFullInstances(other.id),_ug_each0i=0;_ug_each0i<array_length(_ug_each0);++_ug_each0i) with(_ug_each0[_ug_each0i]){
			instance_create(x, y, FloorExplo);
			instance_destroy();
		}
	}
}

// Undergrowth weapons/mega grenade launcher.wep.gml::MegaGrenade_hit
function scrUG_mega_grenade_launcher_MegaGrenade_hit() {
if((speed/timescale) > (friction/sqr(timescale)) && scrUGCanHit(other.id)){
		scrUGHit(other.id, damage, force, direction);
		
		scrNTTEFullFrameSleepRequest(45 + (15 * other.size));
		
		if(other.hp > 0){
			instance_destroy();
		}
	}
}

// Undergrowth weapons/mega grenade launcher.wep.gml::MegaGrenade_alrm0
function scrUG_mega_grenade_launcher_MegaGrenade_alrm0() {
instance_destroy();
}

// Undergrowth weapons/mega grenade launcher.wep.gml::MegaGrenade_alrm1
function scrUG_mega_grenade_launcher_MegaGrenade_alrm1() {
friction=( 0.4)*sqr(timescale);
}

// Undergrowth weapons/mega grenade launcher.wep.gml::MegaGrenade_alrm2
function scrUG_mega_grenade_launcher_MegaGrenade_alrm2() {
sprite_index = spr_dead;
}

// Undergrowth weapons/mega grenade launcher.wep.gml::MegaGrenade_destroy
function scrUG_mega_grenade_launcher_MegaGrenade_destroy() {
scrUGCreate(x, y, "MushroomExplosion");
	
	scrNTTEFullFrameSleepRequest(120);
	
	                        
	for(var _ug_each0=scrNTTEFullInstances(scrUGMatchingNE(scrUGMatchingLE(hitme, "size", 1), "team", team)),_ug_each0i=0;_ug_each0i<array_length(_ug_each0);++_ug_each0i) with(_ug_each0[_ug_each0i]){
		
		if(distance_to_object(other.id) < 96){
			if(!collision_line(x, y, other.x, other.y, Wall, false, false)){
				
				for(var _ug_each1=scrNTTEFullInstances(other.id),_ug_each1i=0;_ug_each1i<array_length(_ug_each1);++_ug_each1i) with(_ug_each1[_ug_each1i]){
					if(scrUGCanHit(other.id)){
						scrNTTEFullNativeProjectileHitPush(other.id, damage, force);
						
						instance_create(other.x, other.y, ThrowHit);
					}
				}
			}
		}
	}
}

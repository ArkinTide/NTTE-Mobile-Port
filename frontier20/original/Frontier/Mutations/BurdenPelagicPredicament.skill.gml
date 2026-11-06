#define init

	 // Sprites:
	global.sprSkillIcon         			= sprite_add("../sprites/mutations/sprBurdenPelagicPredicament.png", 1, 12, 16)
	global.sprSkillHud          			= sprite_add("../sprites/mutations/sprBurdenPelagicPredicamentIcon.png", 1, 8, 8)
	global.sprPelagicPipe	    			= sprite_add("../sprites/areas/oasis/props/sprPelagicPipe.png", 1, 24, 24);	
	global.sprPelagicPipeHurt				= sprite_add("../sprites/areas/oasis/props/sprPelagicPipeHurt.png", 3, 24, 24);	
	global.sprPelagicPipeDead				= sprite_add("../sprites/areas/oasis/props/sprPelagicPipeDead.png", 3, 24, 24);
	global.sprPelagicPipeBottom	    		= sprite_add("../sprites/areas/oasis/props/sprPelagicPipeBottom.png", 1, 24, 24);
	
	global.sprCrabDeadClean					= sprite_add("../sprites/areas/oasis/sprCrabDeadClean.png", 10, 24, 24);	
	global.sprPelagicBubbleSmall			= sprite_add("../sprites/areas/oasis/sprPelagicBubbleSmall.png", 1, 16, 16);	
	global.sprPelagicBubbleSmallPop			= sprite_add("../sprites/areas/oasis/sprPelagicBubbleSmallPop.png", 4, 18, 18);	
	global.sprPelagicBubbleMed				= sprite_add("../sprites/areas/oasis/sprPelagicBubbleMed.png", 1, 16, 16);	
	global.sprPelagicBubbleBig				= sprite_add("../sprites/areas/oasis/sprPelagicBubbleBig.png", 1, 24, 25);	
	global.sprPelagicBubbleBigPop			= sprite_add("../sprites/areas/oasis/sprPelagicBubbleBigPop.png", 4, 32, 32);	
	global.sprPelagicBubbleShark			= sprite_add("../sprites/areas/oasis/sprPelagicBubbleShark.png", 1, 25, 24);	
	
	global.level_start		    			= (instance_exists(GenCont) || instance_exists(Menu));
	global.settingPelagicBubbles			= true;
	global.settingVeeOneHundred				= (game_version > 0);

	 // LIB:
	while(!mod_exists("mod", "lib")){wait(1);}
	script_ref_call(["mod", "lib", "getRef"], "skill", mod_current, "scr");
	#macro  scr			global.scr
	#macro  call		script_ref_call

#define skill_name			return loc("Frontier:BurdenOcean:0", "PELAGIC PREDICAMENT");
#define skill_text			return loc("Frontier:BurdenOcean:1", "@q@(color:13160785)THE SEA CALLS");
#define skill_tip			return "SOMETHING SMELLS FISHY";
#define skill_button		sprite_index = global.sprSkillIcon;
#define skill_icon			return global.sprSkillHud;
#define skill_avail			return 0;
#define skill_wepspec		return 0;
#define skill_sacrifice		return false;
#define skill_burden		return true;

#define skill_take
	global.level_start = false;
	
#define step
	if(instance_exists(GenCont) || instance_exists(Menu)){
		global.level_start = true;
	}
	else if(global.level_start){
        var _normalArea = (GameCont.hard > 1 && (instance_number(enemy) > instance_number(EnemyHorror)) && !(GameCont.area = "deeplabs") && (GameCont.area != "village") && (GameCont.area != "cyberspace"));
		global.level_start = false;
		if(_normalArea || GameCont.area = "devzone"){
			var _spawns = random_range(-3, 3 * skill_get(mod_current));
			repeat(_spawns){
				with(call(scr.instance_random, instances_matching(Floor, "object_index", Floor))){ 
			    	if !place_meeting(x, y, prop) && !place_meeting(x, y, chestprop) && (point_distance(x, y, 10000, 10000) > 128){
			    	
			        	 // Play Sound:
			        	sound_play_pitchvol(sndOasisExplosionSmall, 0.4 + random(0.3), 1)
			        
			    	     // Create Object:
			    		PelagicProp_create(x + 16, y + 16);
			        
			        	 // "Telegraph" Bubbles:
			        	with(Player){ 
			        		repeat(5){ 
			        			instance_create(x, y, Bubble); 
			        		} 
			    	    }
				    }
				}
			}
			if(global.settingPelagicBubbles = true){
				if(_spawns > 0 && area_get_underwater(GameCont.area) = false){
					PelagicEnemyController_create(10016, 10016);
				}
			}
		}
	}
	
#define PelagicProp_create(_x, _y)
    with(instance_create(_x, _y, CustomProp)){
        
         // Clear Area:
        call(scr.floor_fill, x, y, 3, 3, "")
        
         // Spawn Freaks and Fiends:
        repeat(3 + (GameCont.hard / 3)){
            PelagicEnemies_spawn(x, y)
        }
        
		name = "fr_pelagicprop"
		
		 // Visual:
		spr_idle	= global.sprPelagicPipe;
		spr_hurt	= global.sprPelagicPipeHurt;
		spr_dead	= global.sprPelagicPipeDead;
		spr_shadow	= shd24
		
		 // Sounds:
		snd_hurt	= sndHitMetal;
		snd_dead	= sndSewerPipeBreak;
		
		 // Vars:
		maxhealth	= 12;
		my_health	= maxhealth;
		team		= 1;
		
		 // wahoohee:
		on_step 	= PelagicProp_step;
		
		PelagicBottom_create(x, y, image_xscale)
		
		return self;        
    }
    
#define PelagicBottom_create(_x, _y, _flip)
    with(instance_create(_x, _y, CustomObject)){
    	name			= "fr_pelagicbottom";
    	
		sprite_index	= global.sprPelagicPipeBottom;
		image_blend		= (global.settingVeeOneHundred = true) ? area_get_background_color(GameCont.area) : (is_string(GameCont.area) ? background_color : area_get_background_color(GameCont.area));
		image_xscale	= _flip;
		
		return self;        
    }	
    
#define PelagicProp_step
    if(random(40) < 1){
        instance_create(x, y, Bubble)
    }
 
#define PelagicEnemies_spawn(_x, _y)

	 // Choose Freaky Creech:
	var _creechure = call(scr.pool, [
        ["BoneFish",    	6],
        ["Crab",        	1],
        ["Whale",			(0.6 * (GameCont.hard >= 10))],
        ["Moby",			(0.1 * (GameCont.hard >= 14))],
        ["Starfish",		(1 * (GameCont.hard >= 7))],
        ["Elite Starfish",	(1 * (GameCont.hard >= 10))],
        ["Puffer",			(1.5 * (GameCont.hard >= 5)) * mod_exists("mod", "ntte")],
        ["HammerShark",		(0.3 * (GameCont.hard >= 18)) * mod_exists("mod", "ntte")], 
        ["Eel",				(2 * (GameCont.hard >= 10)) * mod_exists("mod", "ntte")],   
        ["Jelly",			(1 * (GameCont.hard >= 11)) * mod_exists("mod", "ntte")],   
        ["Elite Jelly",		(0.4 * (GameCont.hard >= 18)) * mod_exists("mod", "ntte")],   
	])
	
	switch(_creechure){
		case "BoneFish": {
			with(instance_create(x, y, BoneFish)){
				spr_pelagicbubble			= global.sprPelagicBubbleSmall;
				spr_pelagicbubblepop		= global.sprPelagicBubbleSmallPop;
				spr_pelagicbubble_tiltspeed	= random_range(0.15, 0.3);
				spr_pelagicbubble_tiltrange	= random_range(18, 30);
			}
			break;
		}
		case "Crab": {
			with(instance_create(x, y, Crab)){
				spr_dead = global.sprCrabDeadClean;
			}
			break;
		}
		case "Whale": {
			mod_script_call("mod", "Frontier_Caves", "Whale_create", x, y);
			break;
		}
		case "Moby": {
			mod_script_call("mod", "Frontier_Caves", "EliteWhale_create", x, y);
			break;
		}
		case "Starfish": {
			mod_script_call("mod", "Frontier_Caves", "Starfish_create", x, y);
			break;
		}
		case "Elite Starfish": {
			mod_script_call("mod", "Frontier_Caves", "EliteStarfish_create", x, y);
			break;
		}
		case "Puffer": {
			with(mod_script_call("mod", "telib", "obj_create", x, y, "Puffer")){
				spr_pelagicbubble			= global.sprPelagicBubbleMed;
				spr_pelagicbubblepop		= global.sprPelagicBubbleSmallPop;
				spr_pelagicbubble_tiltspeed	= random_range(0.15, 0.3);
				spr_pelagicbubble_tiltrange	= random_range(18, 30);
			}
			break;
		}
		case "HammerShark": {
			with(mod_script_call("mod", "telib", "obj_create", x, y, "HammerShark")){
				spr_pelagicbubble			= global.sprPelagicBubbleShark;
				spr_pelagicbubblepop		= global.sprPelagicBubbleBigPop;
				spr_pelagicbubble_tiltspeed	= random_range(0.15, 0.3);
				spr_pelagicbubble_tiltrange	= random_range(18, 22);
			}
			break;
		}
		case "Eel": {
			with(mod_script_call("mod", "telib", "obj_create", x, y, "Eel")){
				spr_pelagicbubble			= global.sprPelagicBubbleSmall;
				spr_pelagicbubblepop		= global.sprPelagicBubbleSmallPop;
				spr_pelagicbubble_tiltspeed	= random_range(0.15, 0.3);
				spr_pelagicbubble_tiltrange	= random_range(18, 30);
			}
			break;
		}
		case "Jelly": {
			with(mod_script_call("mod", "telib", "obj_create", x, y, "Jelly")){
				spr_pelagicbubble			= global.sprPelagicBubbleBig;
				spr_pelagicbubblepop		= global.sprPelagicBubbleBigPop;
				spr_pelagicbubble_tiltspeed	= random_range(0.15, 0.3);
				spr_pelagicbubble_tiltrange	= random_range(18, 30);
			}
			break;
		}
		case "Elite Jelly": {
			with(mod_script_call("mod", "telib", "obj_create", x, y, "JellyElite")){
				spr_pelagicbubble			= global.sprPelagicBubbleBig;
				spr_pelagicbubblepop		= global.sprPelagicBubbleBigPop;
				spr_pelagicbubble_tiltspeed	= random_range(0.15, 0.3);
				spr_pelagicbubble_tiltrange	= random_range(18, 30);
			}
			break;
		}
	}
	
#define PelagicEnemyController_create(_x, _y)
	with(instance_create(_x, _y, CustomObject)){
		name = "fr_pelagiccontroller";
		
		sprite_index	= mskNone;
		
		on_end_step = PelagicEnemyController_endstep;
		
		script_bind_draw(PelagicBubble_draw, -3);
	}

#define PelagicEnemyController_endstep
	with(instances_matching_ne(enemy, "spr_pelagicbubble", null)){
		if(random(100) < 1){
			instance_create(x + random_range(-sprite_width / 2, sprite_width / 2), y + random_range(-sprite_height / 2, sprite_height / 2), Bubble)
		}
		if(my_health <= 0){
			with(instance_create(x, y, BubblePop)){
				sprite_index	= other.spr_pelagicbubblepop;
			}
			repeat(4){
				instance_create(x, y, Bubble);
			}
		}
	}
	
#define PelagicBubble_draw
	with(instances_matching_ne(enemy, "spr_pelagicbubble", null)){
		draw_sprite_ext(spr_pelagicbubble, 0, x, y, image_xscale, image_yscale, image_angle + sin(current_frame * spr_pelagicbubble_tiltspeed) * spr_pelagicbubble_tiltrange, c_white, 1);
	}

#define area_get_underwater(_area)
	/*
		Returns if a given area is underwater, like Oasis
	*/
	
	 // Custom Area:
	if(is_string(_area)){
		var _scrt = "area_underwater";
		if(mod_script_exists("area", _area, _scrt)){
			return mod_script_call("area", _area, _scrt);
		}
	}
	
	 // Normal Area:
	return (_area == 101);
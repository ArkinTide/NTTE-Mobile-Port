#define init

	 // Sprites:
	global.sprSkillIcon         			= sprite_add("../sprites/mutations/sprBurden.png", 1, 12, 16)
	global.sprSkillHud          			= sprite_add("../sprites/mutations/sprBurdenPelagicPredicamentIcon.png", 1, 8, 8)
	global.level_start		    			= (instance_exists(GenCont) || instance_exists(Menu));

	 // LIB:
	while(!mod_exists("mod", "lib")){wait(1);}
	script_ref_call(["mod", "lib", "getRef"], "skill", mod_current, "scr");
	#macro  scr			global.scr
	#macro  call		script_ref_call

#define skill_name			return "AUTOMOTIVE APOCALYPSE"
#define skill_text			return "@q@(color:2832791)ROAD RAGE"
#define skill_tip			return "WRENCH CAN'T FIX IT";
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
		var _normalArea = (GameCont.hard > 1 && (instance_number(enemy) > instance_number(EnemyHorror)) && !(GameCont.area = "deeplabs") && (GameCont.area != "village"));
		global.level_start = false;
		if(_normalArea){
			repeat(irandom_range(16, 24 * skill_get(mod_current))) with(call(scr.instance_random, instances_matching_ne(instances_matching(Floor, "object_index", Floor), "fr_autoparts", true))){ 
		    	if !place_meeting(x, y, prop) && !place_meeting(x, y, chestprop) && (point_distance(x, y, 10000, 10000) > 128){
					fr_autoparts = true;
					instance_create(x + 16, y + 16, Car)
			    }
			}
			repeat(irandom_range(3, 12 * skill_get(mod_current))) with(call(scr.instance_random, instances_matching_ne(instances_matching(Floor, "object_index", Floor), "fr_minibot", true))){ 
		    	if !place_meeting(x, y, prop) && !place_meeting(x, y, chestprop) && (point_distance(x, y, 10000, 10000) > 128){
					fr_minibot = true;
					MicroSnowbot_create(x + 16, y + 16)
			    }
			}
		}
	}

#define MicroSnowbot_create(_x, _y)
	with(instance_create(_x, _y, SnowBot)){
		image_xscale	= 0.5;
		image_yscale	= 0.5;
		
		maxhealth		= 2;
		my_health		= maxhealth;
	}
#define init

	global.sprSkillIcon 					= sprite_add("../sprites/mutations/sprAugmentScarierFace.png", 1, 12, 16)
	global.sprSkillHud  					= sprite_add("../sprites/mutations/sprAugmentScarierFaceIcon.png", 1, 9, 10)
	
	 // LIB:
	while(!mod_exists("mod", "lib")){wait(1);}
	script_ref_call(["mod", "lib", "getRef"], "skill", mod_current, "scr");
	#macro  scr			global.scr
	#macro  call		script_ref_call

	#macro enemy_boss   ('boss' in self) ? boss : ('intro' in self || array_find_index([Nothing, Nothing2, BigFish, OasisBoss], object_index) >= 0)

#define skill_name			return loc("Frontier:AugmentScarierFace:0", "SABOTAGE");
#define skill_text			return loc("Frontier:AugmentScarierFace:1", "@(color:16776960)BOSSES @sARE @wWEAKER @sAND#@wDROP MORE LOOT");
#define skill_tip			return "CALCULATED STRIKE";
#define skill_button		sprite_index = global.sprSkillIcon;
#define skill_icon			return global.sprSkillHud;
#define skill_avail			return (mod_variable_get("mod", "Frontier_IDPD", "settingMainPoolAugments") = true) ? 1 : 0;
#define skill_wepspec		return 0;
#define skill_sacrifice		return false;
#define skill_augment		return mut_scarier_face;
	
#define step
   
	 // Mark Bosses:
	with(instances_matching(enemy, "fr_augmentSabotage", null)){
		if ("fr_augmentSabotage" not in self) { 
			fr_augmentSabotage = true; 
		}
		if(enemy_boss){
			
			// Stat Decrease:
			maxhealth /= 2 * skill_get(mod_current);
			
			if(my_health > maxhealth){ 
				my_health = maxhealth;
			}
			
			if ("fr_augmentSabotageBoss" not in self){ 
				fr_augmentSabotageBoss = true;
			}
		}
	}    

	 // Boss Loot:
	with(instances_matching(enemy, "fr_augmentSabotageBoss", true)){
		
			// LOOT ! !
		if(my_health <= 0){
			repeat(3 + irandom(2)){
				var _lootPool = call(scr.pool, [
			        [[AmmoChest,	"Basegame", ""],    						12],	 
			        [[WeaponChest,	"Basegame", ""],    						7],			        
			        [[HealthChest,	"Basegame", ""],    						5],	    
			        [[RogueChest,	"Basegame", ""],    						(array_length(instances_matching(Player, "race", "rogue", "vanthro")) > 0) * 5],	  
			        [[RadChest,		"Basegame", ""],    						5],	  
			        [["MealChest_create",		"MOD", "Frontier_Pickups"],    	3],	  
			        [["TrinketChest_create",	"MOD", "Frontier_Pickups"],    	3 * mod_exists("mod", "TreasureTrove")],	  
			        [["BonusAmmoChest", 		"OBJ", "telib"],    			2 * mod_exists("mod", "telib")],
			        [["BonusHealthChest",		"OBJ", "telib"],    			2 * mod_exists("mod", "telib")],
			        [["CatChest",				"OBJ", "telib"],    			1 * mod_exists("mod", "telib")],
			        [["BatChest",				"OBJ", "telib"],    			1 * mod_exists("mod", "telib")],
			        [["RatChest",				"OBJ", "telib"],    			1 * mod_exists("mod", "telib")],
			        [["OrchidChest",			"OBJ", "telib"],    			1 * mod_exists("mod", "telib")],
			        [["RedChest",				"OBJ", "telib"],    			0.5 * mod_exists("mod", "telib")],
			        [["RedAmmoChest",			"OBJ", "telib"],    			1 * mod_exists("mod", "telib")],
			        [["HammerHeadChest",		"OBJ", "telib"],    			3 * mod_exists("mod", "telib")],
				])
				switch(_lootPool[1]){
					case "Basegame": {
						instance_create(x, y, _lootPool[0]);
					}
					break;
					case "MOD": {
						mod_script_call("mod", _lootPool[2], _lootPool[0], x, y)
					}
					break;
					case "OBJ": {
						mod_script_call("mod", _lootPool[2], "obj_create", x, y, _lootPool[0])
					}
					break;
				}	
			}
		}
	}

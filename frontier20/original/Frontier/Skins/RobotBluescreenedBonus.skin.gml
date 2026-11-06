#define init
		// SPRITES //
    global.sprIdle 	        	= sprite_add("../Sprites/Skins/RobotBluescreenedBonus/sprRobotBluescreenedBonusIdle.png", 		15, 12, 12);
    global.sprWalk 	        	= sprite_add("../Sprites/Skins/RobotBluescreenedBonus/sprRobotBluescreenedBonusWalk.png", 		6, 12, 12);
    global.sprHurt 	        	= sprite_add("../Sprites/Skins/RobotBluescreenedBonus/sprRobotBluescreenedBonusHurt.png", 		3, 12, 12);
    global.sprDead 	        	= sprite_add("../Sprites/Skins/RobotBluescreenedBonus/sprRobotBluescreenedBonusDead.png", 		6, 12, 12);
    global.sprGoSit 	       	= sprite_add("../Sprites/Skins/RobotBluescreenedBonus/sprRobotBluescreenedBonusGoSit.png",		3, 12, 12); 
    global.sprSit 	        	= sprite_add("../Sprites/Skins/RobotBluescreenedBonus/sprRobotBluescreenedBonusSit.png",		1, 12, 12);
    global.sprPortrait 	       	= sprite_add("../Sprites/Skins/RobotBluescreenedBonus/sprRobotBluescreenedBonusPortrait.png",	1, 40, 243);
    global.sprLoadout 	       	= sprite_add("../Sprites/Skins/RobotBluescreenedBonus/sprRobotBluescreenedBonusLoadout.png",	1, 16, 16);
    global.sprMapIcon 	       	= sprite_add("../Sprites/Skins/RobotBluescreenedBonus/sprRobotBluescreenedBonusMapIcon.png",	1, 10, 10);
    
    global.sprBackupPortrait 	= sprite_add("../Sprites/Skins/RobotBluescreenedBonus/sprRobotBonusPortraitBackup.png",			1, 40, 243);
    
#define skin_button		sprite_index = skin_sprite(sprLoadoutSkin);
#define skin_race      return "/";
#define skin_name      return "BLUESCREENED BONUS";
#define skin_lock      return "N/A";
#define skin_unlock    return "N/A";
#define skin_ttip      return choose("SYSTEM CRITICAL");
#define skin_portrait  return instance_exists(Player) ? skin_sprite(sprBigPortrait) : global.sprBackupPortrait;
#define skin_mapicon   return skin_sprite(sprMapIcon);

#define skin_sprite(_spr)
	switch(_spr){
		case sprMutant8Idle  : return global.sprIdle;
		case sprMutant8Walk  : return global.sprWalk;
		case sprMutant8Hurt  : return global.sprHurt;
		case sprMutant8Dead  : return global.sprDead;
		case sprMutant8GoSit : return global.sprGoSit;
		case sprMutant8Sit   : return global.sprSit;
		case sprBigPortrait  : return global.sprPortrait;
		case sprLoadoutSkin  : return global.sprLoadout;
		case sprMapIcon      : return global.sprMapIcon;
	}
	
#define game_start
	with(instances_matching(Player, "bskin", mod_current)){
		bskin = "bonus robot";
		player_set_skin(index, "bonus robot");
		
		 // v100 doesnt set sprites automaitcally anymore
		spr_idle	= _tespr.RobotBonusIdle;
		spr_walk	= _tespr.RobotBonusWalk;
		spr_hurt	= _tespr.RobotBonusHurt;
		spr_dead	= _tespr.RobotBonusDead;
		spr_sit1	= _tespr.RobotBonusGoSit;
		spr_sit2	= _tespr.RobotBonusSit;
	}
	
#macro _tespr mod_variable_get("mod", "teassets", "spr");
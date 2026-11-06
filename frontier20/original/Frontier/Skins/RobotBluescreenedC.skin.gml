#define init
		// SPRITES //
    global.sprIdle 	        	= sprite_add("../Sprites/Skins/RobotBluescreenedC/sprRobotBluescreenedCIdle.png", 		26, 12, 12);
    global.sprWalk 	        	= sprite_add("../Sprites/Skins/RobotBluescreenedC/sprRobotBluescreenedCWalk.png", 		6, 12, 12);
    global.sprHurt 	        	= sprite_add("../Sprites/Skins/RobotBluescreenedC/sprRobotBluescreenedCHurt.png", 		3, 12, 12);
    global.sprDead 	        	= sprite_add("../Sprites/Skins/RobotBluescreenedC/sprRobotBluescreenedCDead.png", 		6, 12, 12);
    global.sprGoSit 	       	= sprite_add("../Sprites/Skins/RobotBluescreenedC/sprRobotBluescreenedCGoSit.png",		3, 12, 12);
    global.sprSit 	        	= sprite_add("../Sprites/Skins/RobotBluescreenedC/sprRobotBluescreenedCSit.png",		1, 12, 12);
    global.sprPortrait 	       	= sprite_add("../Sprites/Skins/RobotBluescreenedC/sprRobotBluescreenedCPortrait.png",	1, 40, 243);
    global.sprLoadout 	       	= sprite_add("../Sprites/Skins/RobotBluescreenedC/sprRobotBluescreenedCLoadout.png",	1, 16, 16);
    global.sprMapIcon 	       	= sprite_add("../Sprites/Skins/RobotBluescreenedC/sprRobotBluescreenedCMapIcon.png",	1, 10, 10);
    
    global.sprBackupPortrait 	= sprite_add("../Sprites/Skins/RobotBluescreenedC/sprRobotCPortraitBackup.png",			1, 40, 243);
    
#define skin_button		sprite_index = skin_sprite(sprLoadoutSkin);
#define skin_race      return "/";
#define skin_name      return "BLUESCREENED C SKIN";
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
		bskin = 2;
		player_set_skin(index, 2);
		
		 // v100 doesnt set sprites automaitcally anymore
		spr_idle	= sprMutant8CIdleID;
		spr_walk	= sprMutant8CWalkID;
		spr_hurt	= sprMutant8CHurtID;
		spr_dead	= sprMutant8CDeadID;
		spr_sit1	= sprMutant8CGoSitID;
		spr_sit2	= sprMutant8CSitID;
	}

#macro sprMutant8CIdleID	1320
#macro sprMutant8CWalkID	1322
#macro sprMutant8CHurtID	1319
#macro sprMutant8CDeadID	1317
#macro sprMutant8CGoSitID	1318
#macro sprMutant8CSitID		1321

#define init
		// SPRITES //
    global.sprIdle 	        	= sprite_add("../Sprites/Skins/RobotBluescreenedB/sprRobotBluescreenedBIdle.png", 		26, 12, 12);
    global.sprWalk 	        	= sprite_add("../Sprites/Skins/RobotBluescreenedB/sprRobotBluescreenedBWalk.png", 		6, 12, 12);
    global.sprHurt 	        	= sprite_add("../Sprites/Skins/RobotBluescreenedB/sprRobotBluescreenedBHurt.png", 		3, 12, 12);
    global.sprDead 	        	= sprite_add("../Sprites/Skins/RobotBluescreenedB/sprRobotBluescreenedBDead.png", 		6, 12, 12);
    global.sprGoSit 	       	= sprite_add("../Sprites/Skins/RobotBluescreenedB/sprRobotBluescreenedBGoSit.png",		3, 12, 12);
    global.sprSit 	        	= sprite_add("../Sprites/Skins/RobotBluescreenedB/sprRobotBluescreenedBSit.png",		1, 12, 12);
    global.sprPortrait 	       	= sprite_add("../Sprites/Skins/RobotBluescreenedB/sprRobotBluescreenedBPortrait.png",	1, 40, 243);
    global.sprLoadout 	       	= sprite_add("../Sprites/Skins/RobotBluescreenedB/sprRobotBluescreenedBLoadout.png",	1, 16, 16);
    global.sprMapIcon 	       	= sprite_add("../Sprites/Skins/RobotBluescreenedB/sprRobotBluescreenedBMapIcon.png",	1, 10, 10);
    
    global.sprBackupPortrait 	= sprite_add("../Sprites/Skins/RobotBluescreenedB/sprRobotBPortraitBackup.png",			1, 40, 243);
    
#define skin_button		sprite_index = skin_sprite(sprLoadoutSkin);
#define skin_race      return "/";
#define skin_name      return "BLUESCREENED B SKIN";
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
		bskin = 1;
		player_set_skin(index, 1);
		
		 // v100 doesnt set sprites automaitcally anymore
		spr_idle	= sprMutant8BIdle;
		spr_walk	= sprMutant8BWalk;
		spr_hurt	= sprMutant8BHurt;
		spr_dead	= sprMutant8BDead;
		spr_sit1	= sprMutant8BGoSit;
		spr_sit2	= sprMutant8BSit;
	}
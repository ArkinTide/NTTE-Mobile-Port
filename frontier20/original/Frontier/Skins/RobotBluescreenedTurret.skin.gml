#define init
		// SPRITES //
    global.sprIdle 	        	= sprite_add("../Sprites/Skins/RobotBluescreenedTurret/sprRobotBluescreenedTurretIdle.png", 	15, 12, 12);
    global.sprWalk 	        	= sprite_add("../Sprites/Skins/RobotBluescreenedTurret/sprRobotBluescreenedTurretWalk.png", 	6, 12, 12);
    global.sprHurt 	        	= sprite_add("../Sprites/Skins/RobotBluescreenedTurret/sprRobotBluescreenedTurretHurt.png", 	3, 12, 12);
    global.sprDead 	        	= sprite_add("../Sprites/Skins/RobotBluescreenedTurret/sprRobotBluescreenedTurretDead.png", 	6, 12, 12);
    global.sprGoSit 	       	= sprite_add("../Sprites/Skins/RobotBluescreened/sprRobotBluescreenedGoSit.png",				3, 12, 12); //he was so real for not bothering with sit sprites
    global.sprSit 	        	= sprite_add("../Sprites/Skins/RobotBluescreened/sprRobotBluescreenedSit.png",					1, 12, 12);
    global.sprPortrait 	       	= sprite_add("../Sprites/Skins/RobotBluescreenedTurret/sprRobotBluescreenedTurretPortrait.png", 1, 35, 230);
    global.sprLoadout 	       	= sprite_add("../Sprites/Skins/RobotBluescreenedTurret/sprRobotBluescreenedTurretLoadout.png",	1, 16, 16);
    global.sprMapIcon 	       	= sprite_add("../Sprites/Skins/RobotBluescreenedTurret/sprRobotBluescreenedTurretMapIcon.png",	1, 10, 10);
    
    global.sprBackupPortrait 	= sprite_add("../Sprites/Skins/RobotBluescreenedTurret/sprRobotTurretPortraitBackup.png",		1, 35, 230);
    
#define skin_button		sprite_index = skin_sprite(sprLoadoutSkin);
#define skin_race      return "/";
#define skin_name      return "BLUESCREENED TURRET";
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
		bskin = "turret";
		player_set_skin(index, "turret");
		
		 // v100 doesnt set sprites automaitcally anymore
		spr_idle	= mod_variable_get("skin", "turret", "spr_idle");
		spr_walk	= mod_variable_get("skin", "turret", "spr_walk");
		spr_hurt	= mod_variable_get("skin", "turret", "spr_hurt");
		spr_dead	= mod_variable_get("skin", "turret", "spr_dead");
		spr_sit1	= mod_variable_get("skin", "turret", "spr_hurt");
		spr_sit2	= mod_variable_get("skin", "turret", "spr_hurt");
	}
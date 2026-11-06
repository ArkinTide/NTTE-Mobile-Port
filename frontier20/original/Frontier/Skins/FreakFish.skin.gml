#define init
		// SPRITES //
    global.sprIdle 	        	= sprite_add("../Sprites/Skins/FishFreak/sprFishFreakIdle.png", 8, 12, 12);
    global.sprWalk 	        	= sprite_add("../Sprites/Skins/FishFreak/sprFishFreakWalk.png", 6, 12, 12);
    global.sprHurt 	        	= sprMutant1BHurt;
    global.sprDead 	        	= sprMutant1BDead;
    global.sprGoSit 	       	= sprMutant1BGoSit;
    global.sprSit 	        	= sprMutant1BSit;
    global.sprPortrait 	       	= mskNone;
    global.sprLoadout 	       	= sprFreak1Idle;
    global.sprMapIcon 	       	= sprFreak1Walk;
    
    global.sprLabsIcon			= sprite_add("../Sprites/Menu/sprLabsRouteIcon.png", 1, 4, 4);
    
#define skin_button
	sprite_index = skin_sprite(sprLoadoutSkin);
	image_index  = !skin_avail();

#define skin_race      return "/"; // "fish";
#define skin_name      return ((argument_count <= 0 || argument0) ? "FREAK" : skin_lock());
#define skin_lock      return "COMPLETE " + `@1(${real(global.sprLabsIcon)}:0)` + "3-1";
#define skin_unlock    return "FOR COMPLETING " + `@1(${real(global.sprLabsIcon)}:0)` + "3-1";
#define skin_ttip      return choose("SOMETHINGS WRONG");
#define skin_avail     return 1;
#define skin_portrait  return skin_sprite(sprBigPortrait);
#define skin_mapicon   return skin_sprite(sprMapIcon);

#define skin_sprite(_spr)
	switch(_spr){
		case sprMutant1Idle  : return global.sprIdle;
		case sprMutant1Walk  : return global.sprWalk;
		case sprMutant1Hurt  : return global.sprHurt;
		case sprMutant1Dead  : return global.sprDead;
		case sprMutant1GoSit : return global.sprGoSit;
		case sprMutant1Sit   : return global.sprSit;
		case sprBigPortrait  : return global.sprPortrait;
		case sprLoadoutSkin  : return global.sprLoadout;
		case sprMapIcon      : return global.sprMapIcon;
	}
#define init


	// bubbles was my first character mod so this file is probably pretty scuffed, since some chunks of its code is like 5 years old at the time of writing this.

	 // STAT GLOBAL VARS //
	global.lastKills	= 0;
	global.lastTime		= 0;
	global.lastLoop		= 0;
	global.lastBubbles	= 0;


	
	 // SOUNDS //
	global.sndBubblesSlct					= sound_add("../Sounds/Characters/Bubbles/sndBubblesSlct.ogg");
	global.sndBubblesCnfm					= sound_add("../Sounds/Characters/Bubbles/sndBubblesCnfm.ogg");
	global.sndBubblesWrld					= sound_add("../Sounds/Characters/Bubbles/sndBubblesWrld.ogg");
	global.sndBubblesHurt					= sound_add("../Sounds/Characters/Bubbles/sndBubblesHurt.ogg");
	global.sndBubblesDead					= sound_add("../Sounds/Characters/Bubbles/sndBubblesDead.ogg");
	global.sndBubblesLowA					= sound_add("../Sounds/Characters/Bubbles/sndBubblesLowA.ogg");
	global.sndBubblesLowH					= sound_add("../Sounds/Characters/Bubbles/sndBubblesLowH.ogg");
	global.sndBubblesChst					= sound_add("../Sounds/Characters/Bubbles/sndBubblesChst.ogg");
	global.sndBubblesValt					= sound_add("../Sounds/Characters/Bubbles/sndBubblesValt.ogg");
	global.sndBubblesCrwn					= sound_add("../Sounds/Characters/Bubbles/sndBubblesCrwn.ogg");
	global.sndBubblesSpch					= sound_add("../Sounds/Characters/Bubbles/sndBubblesSpch.ogg");
	global.sndBubblesIDPD					= sound_add("../Sounds/Characters/Bubbles/sndBubblesIDPD.ogg");
	global.sndBubblesCptn					= sound_add("../Sounds/Characters/Bubbles/sndBubblesCptn.ogg");
	global.sndBubblesSpec					= sound_add("../Sounds/Characters/Bubbles/sndBubblesSpec.ogg");
	global.sndBubblesSpec2					= sound_add("../Sounds/Characters/Bubbles/sndBubblesSpec2.ogg");
	global.sndBubblesSpec3					= sound_add("../Sounds/Characters/Bubbles/sndBubblesSpec3.ogg");
	global.sndBubblePop						= sound_add("../Sounds/Characters/Bubbles/sndBubblePop.ogg");
	global.sndBoom							= sound_add("../sounds/misc/sndBoom.ogg");	 
	global.sndBubblesUltraA					= sound_add("../Sounds/Characters/Bubbles/sndBubblesUltraA.ogg");	 
	global.sndBubblesUltraB					= sound_add("../Sounds/Characters/Bubbles/sndBubblesUltraB.ogg");	
	
	 // SPRITES //
	global.mskBubbleProjectile				= sprite_add("../sprites/Characters/Bubbles/mskBubblesProjectile.png",				1, 8, 8);
	global.mskBubbleProjectileBurstBullet	= sprite_add("../sprites/Characters/Bubbles/mskBubblesProjectileBurstBullet.png",	1, 8, 8);
	global.sprCoveIcon						= sprite_add("../sprites/Characters/Bubbles/sprUnlockCoveIcon.png", 				1, 5, 4);
	global.sprReviveChest					= sprite_add("../sprites/Characters/Bubbles/sprBubblesReviveChest.png", 			6, 16, 16);
	
     // A-Skin:
	global.sprIdle[0]   					= sprite_add("../sprites/Characters/Bubbles/sprBubblesIdle.png",					8, 16, 15);
	global.sprWalk[0]   					= sprite_add("../sprites/Characters/Bubbles/sprBubblesWalk.png",					6, 16, 15);
	global.sprHurt[0]   					= sprite_add("../sprites/Characters/Bubbles/sprBubblesHurt.png",					3, 16, 15);
	global.sprDead[0]   					= sprite_add("../sprites/Characters/Bubbles/sprBubblesDead.png",					10, 16, 15);
	global.sprGoSit[0]  					= sprite_add("../sprites/Characters/Bubbles/sprBubblesGoSit.png",					3, 12, 12);
	global.sprSit[0]    					= sprite_add("../sprites/Characters/Bubbles/sprBubblesSit.png",						1, 12, 12);
    global.sprFire[0]   					= sprite_add("../sprites/Characters/Bubbles/sprBubblesFire.png",					1, 16, 15);
	global.sprBubbleProjectile[0]			= sprite_add("../sprites/Characters/Bubbles/sprBubblesProjectile.png",				4, 8, 8);
	global.sprBubbleProjectileBig[0]		= sprite_add("../sprites/Characters/Bubbles/sprBubblesProjectileBig.png",			4, 12, 12);
	global.sprBubbleTrail[0]    			= sprite_add("../sprites/Characters/Bubbles/sprBubblesTrail.png",					3, 4, 4);
	global.sprBubbleProjectileNullify[0]	= sprite_add("../sprites/Characters/Bubbles/sprBubblesProjectileNullify.png",		4, 24, 24);
    global.sprSmallBubbleExplosion[0]		= sprite_add("../sprites/Characters/Bubbles/sprBubblesExplosion.png",				7, 12, 12);
	global.sprBubbleSprayParticle[0]    	= sprite_add("../sprites/Characters/Bubbles/sprBubblesSprayParticle.png",			6, 8, 8);
	global.sprBubbleProjectileBurst[0]		= sprite_add("../sprites/Characters/Bubbles/sprBubblesProjectileBurst.png", 		1, 24, 24);
	global.sprBubbleProjectileBurstBullet[0]= sprite_add("../sprites/Characters/Bubbles/sprBubblesProjectileBurstBullet.png",	1, 8, 8);
	
	 // B-Skin:
	global.sprIdle[1]   					= sprite_add("../sprites/Characters/Bubbles/sprBubblesBIdle.png",					8, 16, 15);
	global.sprWalk[1]   					= sprite_add("../sprites/Characters/Bubbles/sprBubblesBWalk.png",					6, 16 , 15);
	global.sprHurt[1]   					= sprite_add("../sprites/Characters/Bubbles/sprBubblesBHurt.png",					3, 16, 15);
	global.sprDead[1]   					= sprite_add("../sprites/Characters/Bubbles/sprBubblesBDead.png",					9, 16 , 15);
	global.sprGoSit[1]  					= sprite_add("../sprites/Characters/Bubbles/sprBubblesBGoSit.png",					3, 12, 12);
	global.sprSit[1]    					= sprite_add("../sprites/Characters/Bubbles/sprBubblesBSit.png",					1, 12, 12);
    global.sprFire[1]   					= sprite_add("../sprites/Characters/Bubbles/sprBubblesBFire.png",					1, 16, 15);
	global.sprBubbleProjectile[1]			= sprite_add("../sprites/Characters/Bubbles/sprBubblesBProjectile.png",				4, 8, 8);
	global.sprBubbleProjectileBig[1]		= sprite_add("../sprites/Characters/Bubbles/sprBubblesBProjectileBig.png",			4, 12, 12);
	global.sprBubbleTrail[1]    			= sprite_add("../sprites/Characters/Bubbles/sprBubblesBTrail.png",					3, 4, 4);
	global.sprBubbleProjectileNullify[1]	= sprite_add("../sprites/Characters/Bubbles/sprBubblesBProjectileNullify.png",		4, 24, 24);
    global.sprSmallBubbleExplosion[1]		= sprite_add("../sprites/Characters/Bubbles/sprBubblesBExplosion.png",				7, 12, 12);
	global.sprBubbleSprayParticle[1]    	= sprite_add("../sprites/Characters/Bubbles/sprBubblesBSprayParticle.png",			6, 8, 8);
	global.sprBubbleProjectileBurst[1]		= sprite_add("../sprites/Characters/Bubbles/sprBubblesBProjectileBurst.png",		1, 24, 24);
	global.sprBubbleProjectileBurstBullet[1]= sprite_add("../sprites/Characters/Bubbles/sprBubblesBProjectileBurstBullet.png",	1, 8, 8);
	
	 // Selection / Map:
	global.sprSelect 						= sprite_add("../sprites/Characters/Bubbles/sprBubblesSelect.png",					2, 0, 0);
	global.sprPortrait 						= sprite_add("../sprites/Characters/Bubbles/sprBubblesPortrait.png",				race_skins(), 40, 243);
	global.sprSkinIcon[0]					= sprite_add("../sprites/Characters/Bubbles/sprBubblesLoadout.png",					2, 16, 16);
	global.sprSkinIcon[1]					= sprite_add("../sprites/Characters/Bubbles/sprBubblesBLoadout.png",				2, 16, 16);
	global.sprMapIcon 						= sprite_add("../sprites/Characters/Bubbles/sprBubblesMapIcon.png", 				race_skins(), 10, 10);
	
	 // Ultras:
	global.sprUltra[1]						= sprite_add("../sprites/Characters/Bubbles/sprEGSkillIconA.png",					1, 12, 16);
	global.sprUltra[2]						= sprite_add("../sprites/Characters/Bubbles/sprEGSkillIconB.png",					1, 12, 16);
	global.sprUltraIcon[1]					= sprite_add("../sprites/Characters/Bubbles/sprEGIconHUDA.png", 					1, 8, 9);
	global.sprUltraIcon[2]					= sprite_add("../sprites/Characters/Bubbles/sprEGIconHUDB.png", 					1, 8, 9);
	
	 // Campfire:
	global.sprCampfireSlct  				= sprite_add("../sprites/Characters/Bubbles/sprBubblesMenuSlct.png",				30, 20, 36); 
	global.sprCampfireMenu  				= sprite_add("../sprites/Characters/Bubbles/sprBubblesMenu.png",					23, 20, 36); 
	global.sprCampfireTo    				= sprite_add("../sprites/Characters/Bubbles/sprBubblesMenuTo.png",					20, 20, 36);  
	global.sprCampfireFrom  				= sprite_add("../sprites/Characters/Bubbles/sprBubblesMenuFrom.png",				16, 20, 84);  
	
	 // Guardian:
	global.sprGuardianBubble				= sprite_add("../sprites/Characters/Bubbles/sprGuardianBubble.png",					4, 8, 8);
	global.sprGuardianBubbleTrail    		= sprite_add("../sprites/Characters/Bubbles/sprGuardianBubbleTrail.png",			3, 4, 4);
	global.sprGuardianBubbleNullify			= sprite_add("../sprites/Characters/Bubbles/sprGuardianBubbleNullify.png",			4, 24, 24);
    global.sprGuardianBubbleExplosion		= sprite_add("../sprites/Characters/Bubbles/sprGuardianBubbleExplosion.png",		7, 12, 12);	


	 // LIB // 
	while(!mod_exists("mod", "lib")){wait(1);}
	script_ref_call(["mod", "lib", "getRef"], "race", mod_current, "scr");
	#macro  scr			global.scr
	#macro  call		script_ref_call
	
	#macro current_frame_active 		frac(current_frame) < current_time_scale
	

	 // Reapply sprites if the mod is reloaded:
	with(instances_matching(Player, "race", mod_current)) { 
		assign_sprites();
		assign_sounds();
	}
	
#define guh
	with(instance_create(mouse_x, mouse_y, CampChar)){
		race = "bubbles";
		spr_to		= global.sprCampfireFrom;
		spr_from	= global.sprCampfireTo;
		spr_slct	= global.sprCampfireSlct;
		spr_menu	= global.sprCampfireMenu;
	}

	// GENERAL //
#define race_name					return loc("Frontier:BubblesName", "BUBBLES");
#define race_text					return loc("Frontier:BubblesText", "@wLESS @sENEMY @wCONTACT DAMAGE#@(color:16234606)BUBBLE @wSPRAY"); 	
#define race_tb_text				return loc("Frontier:BubblesThronebutt", "@wHEAVIER @(color:16234606)BUBBLES");
#define race_lock					return "REACH " + "4-"+`@1(${real(global.sprCoveIcon)}:0)`;
#define race_unlock					return "FOR REACHING COVE";
#define race_avail					return call(scr.save_get, "Frontier", "unlock_bubbles");	
#define race_portrait				return global.sprPortrait; 
#define race_mapicon				return global.sprMapIcon; 
#define race_menu_button			sprite_index = global.sprSelect; image_index = !race_avail();	
#define race_revive_sprite			return global.sprReviveChest;

#define race_ttip

	 // Ultra Tips:
	if(GameCont.level >= 10 && chance(1, 5)){
		return choose(
			"ILL BE YOUR KILLER FISH#FOR THE EVENING",
			"SHIVER ME TIMBERS",
			"ALL HANDS ON DECK",
			"LEVIATHAN"
		);
	}
	
	 // Normal:
	return choose(
		"@(color:16234606)BUBBLES @wDESTROY PROJECTILES",                  
		"FISH N' CHIPS",
		"HEAD EMPTY",
		"STAY HYDRATED",
		"FISHY BUSINESS",
		"FIND SHINIES",
		"FOLLOW THE CODE"
	);
	
#define race_menu_select			return global.sndBubblesSlct;
#define race_menu_confirm			return global.sndBubblesCnfm;

	// CAMPFIRE //
#define race_cf						return true;
#define race_cf_sprnotselected		return global.sprCampfireMenu;
#define race_cf_sprselected			return global.sprCampfireSlct;
#define race_cf_sprselecting		return global.sprCampfireTo;
#define race_cf_sprdeselecting		return global.sprCampfireFrom;
#define race_cf_shadowx				return 0;
#define race_cf_shadowy		    	return 0;
#define race_cf_corpse				return true;
#define race_cf_spawnparticles
	repeat(15){
		with instance_create(x, y, Dust){
			speed        = random_range(2, 3);
			direction    = random(360);
			sprite_index = sprFishBoost;
			depth        = -16;
		}
	}
	repeat(6){ 
		with instance_create(x, y, Bubble){
			speed = random_range(1, 2); 
		}
	}
	repeat(3){ 
		with instance_create(x, y, BubblePop){
			speed     = random_range(1,3);
			direction = random(360); 
		}
	}
	repeat(5){
		with instance_create(x, y, FishBoost){
			speed     = random_range(1, 2);
			direction = random(360);
			depth     = -16; 
		}
	}

	 // Hey Check This Out:
	if(random(50) < 1 ){ 
		sound_play(global.sndBoom); 
	}		

	// SKINS //
#define race_skins					return 2;
#define race_skin_button(_skin)		sprite_index = global.sprSkinIcon[argument0]; image_index = !race_skin_avail(_skin);
#define race_skin_avail(_skin)
	switch(_skin){
		case 0 : return 1;
		case 1 : return call(scr.save_get, "Frontier", "unlock_bubbles_bskin");	
	//	case 2 : return 1//call(scr.save_get, "Frontier", "unlock_bubbles_cskin");	
	}

#define race_skin_lock(_skin)
	switch(_skin){
		case 0 : return "YOU MESSED UP#YOUR FILE SOMEHOW LOL";
		case 1 : return "TRADE 10#UNIQUE WEAPONS#" + `@1(${global.sprCoveIcon}:0)` + "@s(@w" + string(array_length(call(scr.save_get, "Frontier", "pirate_conversions"))) + "@s/@w10@s)" + `@1(${global.sprCoveIcon}:0)`;
	//	case 2 : return "C SKIN UNLOCK";
	}
	
#define race_skin_unlock(_skin)
	switch(_skin){
		case 1 : return "FOR TRADING 15 UNIQUE WEAPONS";
	//	case 2 : return "FOR DOING C SKIN UNLOCK";
	}
	
#define race_skin_name(_skin)
	if(race_skin_avail(_skin)){
		return chr(65 + _skin) + " SKIN";
	}
	else{
		return race_skin_lock(_skin);
	}
	
#define race_swep
    switch(player_get_skin(("index" in other) ? other.index : 0)){
        case 1  : return "FR_BubblesShovel";    // B Skin
    //  case 2  : return "FR_BubblesWelder";    // C Skin
        default : return "FR_BubblesCutlass";   // A Skin
    } 
	
	// ULTRAS //
#define race_ultra_button			sprite_index = global.sprUltra[argument0];
#define race_ultra_icon				return global.sprUltraIcon[argument0];
#define race_ultra_name
	switch(argument0){
		case 1: return loc("Frontier:BubblesUltraA:Name", "BUBBLE BARRICADE");
		case 2: return loc("Frontier:BubblesUltraB:Name", "BUBBLE BARRAGE");
	}
#macro ult_Barricade	1 
#macro ult_Barrage		2

#define race_ultra_text
	switch(argument0){
		case 1: return loc("Frontier:BubblesUltraA:Text", "@sGAIN @wDEFENSIVE @(color:16234606)BUBBLE @wORBITALS#@sTAKE @wEVEN LESS @sCONTACT DAMAGE");
		case 2: return loc("Frontier:BubblesUltraB:Text", "@(color:16234606)BUBBLES @wCONVERT @sAND @wREFIRE#@sABSORBED @wPROJECTILES @sWHEN POPPED");
	}

#define race_ultra_take
	if(instance_exists(mutbutton)) switch(argument0){
		case 1:	sound_play(global.sndBubblesUltraA); break;
		case 2: sound_play(global.sndBubblesUltraB); break;
	}

	// HANDY SUPPORT //
#define race_handy					return true;
#define race_handy_data0
	return {
		"hand_color"	: make_color_rgb(0, 184, 0),
		"dual_fire"		: false
	}
#define race_handy_data1		
	return {
		"hand_color"	: make_color_rgb(174, 155, 126),
		"dual_fire"		: false
	}
#define race_handy_data2	
	return {
		"hand_color"	: make_color_rgb(201, 209, 222),
		"dual_fire"		: false
	}
	
	// CREATE PLAYER // 
#define create

	 // Random lets you play locked characters:
	if(!race_avail()){
		race = "fish";
		player_set_race(index, race);
		exit;
	}
	
	 // Set these to support cheats & campfire corpse:
	spr_idle = global.sprIdle[bskin];		
	spr_dead = global.sprDead[bskin];
	
	 // bubble sprites for ntte:
	spr_bubble = -1;
	spr_bubble_pop = -1;

	 // Variables:
	bubbles_maxBubbleCharge = 100;						// max bubble charge
	bubbles_bubbleCharge    = bubbles_maxBubbleCharge; 	// starting bubble charge
	bubbles_bubbleCooldown  = 0;						// cooldown for firing bubbles, keep set to 0
	bubbles_reducedEnemies 	= [];						// array for Passive:
	
	 // Ultra A Vars:
	bubbles_ultraOrbitalSize= 1;						// Orbital Size:
	 
	 // Other Stuff:
    water_breathing			= true;			// Underwater Bubble
    race_gets_chilly		= true;			// Cold area breath
    hatOffset				= [0, 2]		// Hats Mod positioning
    alcoholTolerance		= 50;			// goodmod alchohol tolerance
    charisma				= 1;			// goodmod charisma

	assign_sprites();
	assign_sounds();

#define assign_sprites
	if(object_index = Player){
		spr_idle	= global.sprIdle[bskin];
		spr_walk	= global.sprWalk[bskin];
		spr_hurt	= global.sprHurt[bskin];
		spr_dead	= global.sprDead[bskin];
		spr_sit1	= global.sprGoSit[bskin];
		spr_sit2	= global.sprSit[bskin];
		spr_fire	= global.sprFire[bskin];

		spr_bubbleprojectile    = global.sprBubbleProjectile[bskin];
		spr_bubbleprojectilebig = global.sprBubbleProjectileBig[bskin];
		spr_bubbletrail 		= global.sprBubbleTrail[bskin];
		spr_bubbleexplo			= global.sprSmallBubbleExplosion[bskin];
		spr_nullify				= global.sprBubbleProjectileNullify[bskin];
		spr_sprayparticle		= global.sprBubbleSprayParticle[bskin];
		spr_burst				= global.sprBubbleProjectileBurst[bskin];
		spr_burstbullet			= global.sprBubbleProjectileBurstBullet[bskin];
	}

#define assign_sounds
	snd_wrld	= global.sndBubblesWrld;
	snd_hurt	= global.sndBubblesHurt;
	snd_dead	= global.sndBubblesDead;	
	snd_lowa	= global.sndBubblesLowA;	
	snd_lowh	= global.sndBubblesLowH;	
	snd_chst	= global.sndBubblesChst;	
	snd_valt	= global.sndBubblesValt;
	snd_crwn	= global.sndBubblesCrwn;
	snd_spch	= global.sndBubblesSpch;
	snd_idpd	= global.sndBubblesIDPD;
	snd_cptn	= global.sndBubblesCptn;
	
	
	// SAVE STATS //
#define race_frontier					return true;
#define race_frontier_savestats
	 /*
		This is the part that saves Kills, Best Run, Loops, and Playtime on characters
		death and win stats are done by wibbly
	 */

	 // Kills:
	var newKills = (GameCont.kills - global.lastKills)
		global.lastKills = GameCont.kills
	call(scr.save_set, "Frontier", mod_current + string("_kills"), ((call(scr.save_get, "Frontier", mod_current + string("_kills"))) + newKills))
	
	 // Loops:
	var newLoop = (GameCont.loops - global.lastLoop)
		global.lastLoop = GameCont.loops
	if (newLoop > 0){
		call(scr.save_set, "Frontier", mod_current + string("_loops"), ((call(scr.save_get, "Frontier", mod_current + string("_loops"))) + newLoop))
	}
	
	 // Time:
	call(scr.save_set, "Frontier", mod_current + string("_time"), ((call(scr.save_get, "Frontier", mod_current + string("_time"))) + global.lastTime))	
	global.lastTime = 0;
		
	 // Bubbles:
	call(scr.save_set, "Frontier", mod_current + string("_bubbles"), ((call(scr.save_get, "Frontier", mod_current + string("_bubbles"))) + global.lastBubbles))	
	global.lastBubbles = 0;
	
	 // Best Run:
	if(GameCont.kills >= call(scr.save_get, "Frontier", mod_current + string("_best_kills"))){
		call(scr.save_set, "Frontier", mod_current + string("_best_area"), [GameCont.area, GameCont.subarea, GameCont.loops]);
		call(scr.save_set, "Frontier", mod_current + string("_best_kills"), GameCont.kills);
	}
	
#define game_start

	 // Reset Stat Global Vars:
	global.lastKills	= 0;
	global.lastTime 	= 0;
	global.lastLoop		= 0;
	global.lastBubbles	= 0;
	
	 // Total Runs Stat:
	call(scr.save_set, "Frontier", mod_current + string("_runs"), ((call(scr.save_get, "Frontier", mod_current + string("_runs"))) + 1))

	// GAMEPLAY //
#define level_start
	 // Update Stats:
	race_frontier_savestats()
	
	 // Refill Bubbles:
	bubbles_bubbleCharge = bubbles_maxBubbleCharge;
	
	 // Skeletonize Slaughter:
	if(mod_exists("mod", "ntte")){
		if(bskin = 1){
			with(instances_matching(instances_matching(CustomHitme, "name", "NTTEPet"), "pet", "Slaughter")){
				if(leader = other){
					if("fr_skeletonized" not in self){
						mod_script_call("mod", "Frontier_Objects", "SlaughterB_applyskin");
					}
				}
			}
		}
	}
	
#define step

	 // Track Playtime:
	global.lastTime += (current_time_scale / 30);
	
	
		// PASSIVE - CONTACT DAMAGE REDUCTION //
		
	// ty dragonstrive and derome
	// Reset Damage on Enemies Too Far Away
    if(array_length(bubbles_reducedEnemies)){
        var _temp = []; 
        with(instances_matching_gt(array_prune(bubbles_reducedEnemies), "meleedamage", 0)){
            if(distance_to_object(other) < 10){
                array_push(_temp, self);
            }
            else{ 
                meleedamage = base_contact_damage;
            }
        }
        bubbles_reducedEnemies = _temp;
    }

	// Set Damage Reduction on Nearby Enemies:
    with(instance_nearest(x, y, enemy)){ 
    	if(meleedamage <= 0){
    		continue;
    	}
        if("base_contact_damage" not in self){ 
        	base_contact_damage = meleedamage;
        }
        if(array_find_index(other.bubbles_reducedEnemies, self) == -1){ 		// if the enemy is not in the array
    		if(distance_to_object(other) < 10){ 
                array_push(other.bubbles_reducedEnemies, self); 				// add them to the array and reduce damage
                var _reduction = 2 + ultra_get(mod_current, ult_Barricade); 	// 2 + 1 for ultra A									
                meleedamage = max(1, meleedamage - _reduction);					// set melee damage
            }
    	}
    }

		// ACTIVE - BUBBLE SPRAY //
		
		// Bubble Recharge:
	if(bubbles_bubbleCharge < bubbles_maxBubbleCharge){ 
		bubbles_bubbleCharge += current_time_scale;
	}
	
		// Bubblecharge Cap:
	if(bubbles_bubbleCharge > bubbles_maxBubbleCharge){
		bubbles_bubbleCharge = bubbles_maxBubbleCharge;
	}
	
		// Active / Use Bubble Bar:
	if((canspec) && (bubbles_bubbleCharge > 0) && (bubbles_bubbleCooldown <= 0)){
		if button_check(index, "spec"){

			 // Drain Meter:
			bubbles_bubbleCharge -= ((5 * current_time_scale) + (skill_get(mut_throne_butt) * 7)); 

			 // Sounds:
			if(current_frame_active){
				sound_play_pitchvol(choose(global.sndBubblesSpec, global.sndBubblesSpec2, global.sndBubblesSpec3), random_range(0.8, 1.1), 0.5);
				sound_play_pitchvol(sndOasisHurt, random_range(0.8, 1.2), 0.4);				
			}

			 // Firing Sprite:
			if(sprite_index != spr_hurt){ 
				sprite_index = spr_fire 
			}
			
			 // Bubble Boost Propulsion:
			speed = maxspeed + 2; 
			motion_add(gunangle,-3);

			 // Bubble Projectile Spray:
			if(current_frame_active){
				BubbleProjectile_spray();
				if skill_get(mut_throne_butt){
					bubbles_bubbleCooldown += 3;
				}
			}
		}
	}

			// Active Cooldowns:
	 // when charge hits 0, adds a cooldown:
	if(bubbles_bubbleCharge <= 0){ 
		bubbles_bubbleCooldown = 30; 
	}
	 // Cooldown Counter:
	if (bubbles_bubbleCooldown > 0){ 
		bubbles_bubbleCooldown -= current_time_scale; 
	}
  
	
	
		// ULTRA A - PROJECTILE NULLIFYING ORBITALS //
	if(ultra_get(mod_current, ult_Barricade) > 0){
		
			// Create Orbitals:
		if(array_length(instances_matching(instances_matching(CustomSlash, "name", "bubbles_ultraOrbital"), "ownerid", self)) != 3){
			if(!instance_exists(PortalShock)){
				BubbleOrbital_create(x, y, self, 0, 19);
				BubbleOrbital_create(x, y, self, 120, 19);
				BubbleOrbital_create(x, y, self, 240, 19);
				 // reset orbitals if excess:
				if(array_length(instances_matching(instances_matching(CustomSlash, "name", "bubbles_ultraOrbital"), "ownerid", self)) > 3){
					with(instances_matching(instances_matching(CustomSlash, "name", "bubbles_ultraOrbital"), "ownerid", self)){
						instance_destroy();	
					}
				}
			}
		}
		 
			// Regrow Orbitals:
		if(bubbles_ultraOrbitalSize < 1){ 
			bubbles_ultraOrbitalSize += (0.04 * current_time_scale);
		} else {
			bubbles_ultraOrbitalSize = 1;
		}
		if(bubbles_ultraOrbitalSize < 0){ 
			bubbles_ultraOrbitalSize = 0; 
		}
	}
	
	// BUBBLE PROJECTILES //
#define BubbleProjectile_spray
			
	 // Update Stat:	
	global.lastBubbles += 1;
			
	// Boost Particle:
	repeat(2){
		with(instance_create(x, y, FishBoost)){
			direction		= other.gunangle + random_range(-45, 45);
			image_angle		= random(360);
			speed			= 1 + random(2);
			depth       	= -3;
			sprite_index	= other.spr_sprayparticle;
		}
	}
		// Bubble Particle:
	if (random(3) < 1){ 
		instance_create(x, y, Bubble) 
	}
				
		// Projectile:
	with(instance_create(x + lengthdir_x(3, gunangle),y + lengthdir_y(3, gunangle), CustomSlash)){
		name = "bubbles_bubbleProjectile"
				
		 // Visuals:
		sprite_index	= other.spr_bubbleprojectile;
		mask_index  	= global.mskBubbleProjectile;
		spr_bubbletrail = other.spr_bubbletrail;
		spr_bubbleexplo	= other.spr_bubbleexplo;
		spr_nullify		= other.spr_nullify;
		spr_burst		= other.spr_burst;
		spr_burstbullet = other.spr_burstbullet;
		rotation_speed	= (random_range(5, 10) * current_time_scale)
		image_speed 	= 0//0.4;
		image_index 	= 0;
		image_xscale	= random_range(0.8, 1.3);
		image_yscale	= image_xscale;
		image_angle 	= 0;
		depth			= -3;
		image_alpha		= 0.8;
		fr_bloom		= [1.2, 0.05];
		trailRange		= 6;
		bubble_tiltspeed= random_range(0.17, 0.2);
		bubble_tiltrange= random_range(35, 50);
				
		 // Vars:
		damage			= 1 + (skill_get(mut_throne_butt) * 3)
		direction		= point_direction(x, y, mouse_x[other.index], mouse_y[other.index]) + (random_range(-20, 20))
		team			= other.team;
		speed			= 5.5 + random_range(0.8, 2.3);
		friction		= 0.2 + skill_get(mut_throne_butt) * 0.4;
		ultra_b_charges	= 0;	
				
		 // Projectile Nomenclature:
		ammo_type = -1;
				
		// Thronebutt Vars:
		if skill_get(mut_throne_butt){
			sprite_index	= other.spr_bubbleprojectilebig;
			mask_index  	= mskSuperFlakBullet;
			friction    	= 0.1;
			speed       	= 2.5 + random_range(0.8, 2.3);
			trailRange		= 12;
		}
					
		lifeTime		= skill_get(mut_throne_butt) ? 75 : 0;
					
				
		// Functions:
		on_projectile = BubbleProjectile_nullify;
		on_anim       = nothing;
		on_step       = BubbleProjectile_step;
		on_wall       = BubbleProjectile_wall;
		on_hit        = BubbleProjectile_hit;
		on_destroy    = BubbleProjectile_destroy;
		
		return self;
	}
				
 // Bubble Projectile:
#define BubbleProjectile_step 

	// Spin:
	image_angle = 0 + sin(current_frame * bubble_tiltspeed) * bubble_tiltrange
	
	// Trail:
	if(random(25) < current_time_scale){
		with(instance_create(x + random_range(-trailRange, trailRange),y + random_range(-trailRange, trailRange), BulletHit)){ 
			sprite_index	= other.spr_bubbletrail; 
			speed			= other.speed / 4;
			direction		= other.direction + 180 + random_range(-15, 15);
		}
	} 
	if((speed < 2)){ 
		if(lifeTime > 0){
			lifeTime -= current_time_scale;
		}
		else{
			instance_destroy();
			exit;
		}
	}

#define BubbleProjectile_nullify
	if(instance_exists(self)){
		var me = self;
		if(other.typ > 0){
			with(other){
				with instance_create(x, y, ImpactWrists){ 
					sprite_index = me.spr_nullify; 
				}
				instance_destroy();
			} 
			if(ultra_get(mod_current, ult_Barrage) > 0){
				ultra_b_charges += 1;
			}
		}
	}
	
#define BubbleProjectileSub_nullify
	if(instance_exists(self)){
		var me = self;
		if(other.typ > 0){
			with(other){
				with instance_create(x, y, ImpactWrists){ 
					sprite_index = me.spr_nullify; 
				}
				instance_destroy();
			} 
		}
	}

#define BubbleProjectile_wall    
	move_bounce_solid(true); 
	speed *= 0.7;
    with instance_create(x + hspeed, y + vspeed, MeleeHitWall){
		image_angle = (direction + 180) - angle_difference(other.direction, (direction + 180))
		image_yscale = random_range(0.5, 0.8);
		image_speed *= 2;
		image_index = irandom(1);
	}
        
#define BubbleProjectile_hit     
	projectile_hit(other, damage); 
	instance_destroy();
	
#define BubbleProjectile_destroy

	if(ultra_b_charges > 0){
		BubbleProjectileBurst_create(x, y, ultra_b_charges)
	}

		//Sounds:
	sound_play_pitchvol(sndOasisHurt,			random_range(0.8, 1.2), 0.1);
	sound_play_pitchvol(sndOasisExplosionSmall, random_range(0.8, 1.2), 0.2);
	sound_play_pitchvol(global.sndBubblePop,	random_range(0.5, 1.2), 0.75);	
	
		//Particles:
	repeat(irandom(3)){
		with instance_create(x + random_range(-1, 1), y + random_range(-1, 1), Bubble){ 
			image_yscale = image_xscale;
		}
	}
	
		//Explosion:
	with(instance_create(x, y, CustomSlash)){
		sprite_index	= other.spr_bubbleexplo;
		mask_index		= mskSmallExplosion;
		spr_nullify		= other.spr_nullify;
		image_speed 	= 0.4;
		image_alpha		= 0.8;
		fr_bloom		= [1.2, 0.05];
				
	
		ammo_type		= -1;
		speed			= 0;
		team			= other.team;
		creator			= other.creator;
		ultra_b_charges	= 0;
	
		on_projectile	= BubbleProjectileSub_nullify;
		on_wall 		= nothing;
		on_hit  		= nothing;
	}

		// ULTRA B PROJECTILES //
#define BubbleProjectileBurst_create(_x, _y, _charges)
	with(instance_create(_x, _y, CustomProjectile)){
		name = "bubbles_ProjectileBurst"	
		
		sprite_index	= other.spr_burst;
		spr_burstbullet	= other.spr_burstbullet;
		spr_bubbleexplo	= other.spr_bubbleexplo;
		spr_nullify		= other.spr_nullify;
		spr_bubbletrail	= other.spr_bubbletrail;
		image_index		= 2;
		image_speed		= 0;
		image_alpha		= 0.8;
		fr_bloom		= [1.2, 0.1];
		
		ammo			= _charges;
		burstDelay		= 4;
		team			= other.team;
		creator			= other.creator;
		
		on_step			= BubbleProjectileBurst_step
		on_hit			= nothing;
		on_wall			= nothing;
		
		return self;
	}

#define BubbleProjectileBurst_step
	image_angle += 10 * current_time_scale;

	if(burstDelay > 0){
		burstDelay -= current_time_scale;
	}

	if(ammo > 0){
		if(burstDelay <= 0){
			sound_play_pitchvol(sndOasisShoot, 1.2 + random(0.2), 0.7)
			BubbleProjectileBurstBullet_create(x, y, other.spr_burstbullet, other.spr_bubbleexplo, other.spr_nullify, other.spr_bubbletrail)
			burstDelay = 2;
			ammo -= 1;
		}
	}
	
	if(ammo <= 0){
		image_xscale -= 0.2;
		image_yscale = image_xscale;
		if(image_xscale <= 0){
			instance_destroy();
		}
	}

#define BubbleProjectileBurstBullet_create(_x, _y, _sprite, _spr_explo, _spr_null, _spr_trail)
	with(instance_create(x, y, CustomSlash)){
		name	= "bubbles_ProjectileBurstBullet";
		
		sprite_index	= _sprite;
		spr_bubbleexplo	= _spr_explo;
		spr_nullify		= _spr_null;
		spr_trail		= _spr_trail;
		image_speed		= 0.4;
		image_alpha		= 0.8;
		fr_bloom		= [1.2, 0.1];
		
		if(instance_exists(enemy)){
			var _nearestGuy = instance_nearest(x, y, enemy);
			if(!collision_line(x, y, _nearestGuy.x, _nearestGuy.y, Wall, false, false)){
				direction	= point_direction(x, y, _nearestGuy.x, _nearestGuy.y) + random_range(-15, 15);
			} else {
				direction = random(360);
			}
		} else {
			direction = random(360);
		}
				
		mask_index		= global.mskBubbleProjectileBurstBullet;
		damage			= 5;
		speed			= 11 + random(2);
		team			= other.team;
		image_angle		= direction;
		ultra_b_charges = 0;
				
		on_anim			= nothing;
		on_step			= BubbleProjectileBurstBullet_step;
		on_hit			= BubbleProjectile_hit;
		on_wall			= BubbleProjectileBurstBullet_wall;
		on_destroy		= BubbleProjectile_destroy;
		on_projectile	= BubbleProjectileSub_nullify;
		
		return self;
	}
	
#define BubbleProjectileBurstBullet_step
	if(random(10) < 1){
		with(instance_create(x, y, BulletHit)){
			sprite_index	= other.spr_trail;
			image_index		= choose(0, 1);
			direction		= (other.direction + 180) + random_range(-5, 5)
		}
	}
	
#define BubbleProjectileBurstBullet_wall
	instance_destroy();
	
	// ULTRA A ORBITALS // 
#define BubbleOrbital_create(_x, _y, _creator, _angle, _dist)
	with instance_create(_x, _y, CustomSlash){
		name = "bubbles_ultraOrbital";
		
		 // Visual:
		sprite_index	= _creator.spr_bubbleprojectile;
		spr_nullify		= _creator.spr_nullify;
		image_speed		= 0;
		depth			= -3;
		image_xscale	= other.bubbles_ultraOrbitalSize;
		image_yscale	= image_xscale;
		direction		= _creator.gunangle;
		image_angle		= _creator.gunangle
		image_alpha		= 0.8;
		speed			= 0;
		fr_bloom		= [1.2, 0.05];
		
		 // Vars:
		ownerid 		= other.id;
		angle			= _angle;
		dist		    = _dist;
		creator			= _creator;
		team			= _creator.team;
		typ				= 0;
		ammo_type		= -1;
		prism_duplicate = true;
		
		
		 // Functions:
		on_wall 		= nothing;
		on_hit			= nothing;
		on_projectile	= BubbleOrbital_nullify;
		on_grenade		= nothing;
		on_step 		= BubbleOrbital_step;
		on_end_step		= BubbleOrbital_endstep;
				
		return self;
	}

#define BubbleOrbital_nullify
	// Delete Projectile:
	if(instance_exists(self)) && (other.typ > 0) && (creator.bubbles_ultraOrbitalSize > 0.2){ 
	var me = self;
		with(other){ 
			with instance_create(x, y, ImpactWrists){ 
				sprite_index = me.spr_nullify; 
			}
			instance_destroy();
		} 
	} 
	
	// Shrink Orbitals:
	if(instance_exists(creator)){
		with(creator){ 
			if(bubbles_ultraOrbitalSize > 0){ 
				bubbles_ultraOrbitalSize -= 0.10; 
			}
		}
	}

#define BubbleOrbital_step
	 // Goodbye:
	if !instance_exists(creator) || !(ultra_get(mod_current, ult_Barricade) > 0){
		instance_destroy();
		exit;
	}
	
	if(current_frame_active){
		if(random(2) > 1){
			with instance_create(x, y, BulletHit){
				sprite_index = other.creator.spr_bubbletrail;
			}
		}
	}
	
	 // Set Size and Speen:
	image_xscale	= creator.bubbles_ultraOrbitalSize;
	image_yscale	= image_xscale;
	angle += 6 * current_time_scale;
	direction		= angle;
	image_angle += 12 * current_time_scale;

#define BubbleOrbital_wall
	xprevious = x + hspeed;
	yprevious = y + vspeed;
	
#define BubbleOrbital_endstep
	with(ownerid){
		other.xprevious = x + lengthdir_x(other.dist, other.angle);
		other.yprevious = y + lengthdir_y(other.dist, other.angle);
		other.x 		= x + lengthdir_x(other.dist, other.angle);
		other.y 		= y + lengthdir_y(other.dist, other.angle);
	}
	
	// NT:TE GUARDIAN SUPPORT //
#define race_ntte_guardian_step
	with(other){ 
		if(speed > 5){
			GuardianBubble_create(x, y);
			instance_create(x, y, Bubble);
		}
	}
	
#define GuardianBubble_create(_x, _y)
	// Projectile:
	with(instance_create(_x, _y, CustomSlash)){
		name = "bubbles_guardianBubble"
				
		 // Visuals:
		sprite_index	= global.sprGuardianBubble;
		mask_index  	= global.mskBubbleProjectile;
		spr_bubbletrail = global.sprGuardianBubbleTrail;
		spr_bubbleexplo	= global.sprGuardianBubbleExplosion;
		spr_nullify		= global.sprGuardianBubbleNullify;
		rotation_speed	= (random_range(5, 10) * current_time_scale)
		image_speed 	= 0//0.4;
		image_index 	= 0;
		image_xscale	= random_range(0.8, 1.3);
		image_yscale	= image_xscale;
		image_angle 	= 0;
		depth			= -3;
		image_alpha		= 0.8;
		fr_bloom		= [1.2, 0.05];
		trailRange		= 6;
		bubble_tiltspeed= random_range(0.17, 0.2);
		bubble_tiltrange= random_range(35, 50);
				
		 // Vars:
		damage			= 5;
		direction		= other.direction + random_range(-80, 80);
		team			= other.team;
		speed			= 3;
		friction		= 0.2;
		ultra_b_charges	= 0;	
		lifeTime		= 75;
				
		 // Projectile Nomenclature:
		ammo_type = -1;
					
				
		// Functions:
		on_projectile = BubbleProjectile_nullify;
		on_anim       = nothing;
		on_step       = BubbleProjectile_step;
		on_wall       = BubbleProjectile_wall;
		on_hit        = BubbleProjectile_hit;
		on_destroy    = BubbleProjectile_destroy;
		
		return self;
	}


	
	// GENERIC FUNCTIONS //
#define nothing
#define chance(_numer, _denom)				return  random(_denom) < _numer;
#define array_prune(_array) 				return instances_matching_ne(_array, "id");	
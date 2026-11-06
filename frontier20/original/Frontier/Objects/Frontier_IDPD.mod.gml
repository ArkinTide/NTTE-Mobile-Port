#define init

	 // LIB:
	while(!mod_exists("mod", "lib")){wait(1);}
	script_ref_call(["mod", "lib", "getRef"], "mod", mod_current, "scr");
	#macro  scr			global.scr
	#macro  call		script_ref_call
	
		// SETTINGS: //
	global.settingMainPoolAugments				= false;	// causes augments to appear in the main mutation pool. wont be balanced and might break, use at your own risk.
	global.settingNewIDPD						= true; 	// toggles new idpd units:
	
		// SOUNDS //
	global.sndStrikerWarning					= sound_add("../sounds/enemies/sndStrikerWarning.ogg")
	global.sndStrikerFly						= sound_add("../sounds/enemies/sndStrikerFly.ogg")		
	 
		// SPRITES //

	 // Augment Stations:
	global.sprAugmentStation 					= sprite_add("../sprites/areas/hq/sprAugmentStation.png",						1, 16, 22);
	global.sprAugmentStationOpen 				= sprite_add("../sprites/areas/hq/sprAugmentStationOpen.png",					1, 16, 22);
	global.sprAugmentStationDeny 				= sprite_add("../sprites/areas/hq/sprAugmentStationDeny.png",					3, 16, 22);
	global.sprAugmentStationHolo 				= sprite_add("../sprites/areas/hq/sprAugmentStationHolo.png",					1, 16, 22);
	global.sprAugmentStationFloor				= sprite_add("../sprites/areas/hq/sprAugmentStationFloor.png",					1, 80, 80);
	global.sprAugmentMonolith 					= sprite_add("../sprites/areas/hq/props/sprAugmentMonolith.png",				4, 16, 24);
	global.sprAugmentMonolithHurt 				= sprite_add("../sprites/areas/hq/props/sprAugmentMonolithHurt.png",			3, 16, 24);
	global.sprAugmentMonolithDead 				= sprite_add("../sprites/areas/hq/props/sprAugmentMonolithDead.png",			6, 16, 24);
	global.sprPopoSparkles 						= sprite_add("../sprites/particles/sprPopoSparkles.png",						3, 6, 6);
	global.sprAugmentTextBackground				= sprite_add("../sprites/areas/hq/sprAugmentTextBackground.png",				1, 1, 1);

	 // IDPD Portals:
	global.sprPopoPortalBig      				= sprite_add("../sprites/areas/hq/sprPopoPortalBig.png",						5, 24, 24);
	global.sprPopoPortalBigClose     			= sprite_add("../sprites/areas/hq/sprPopoPortalBigClose.png",					14, 24, 24);
	global.sprPopoPortalBigDisappear      		= sprite_add("../sprites/areas/hq/sprPopoPortalBigDisappear.png",				5, 24, 24);
	
	 // HQ Exit:
	global.sprHQExit  				    		= sprite_add("../sprites/areas/hq/sprHQExit.png",								11, 16, 16);
	
	 // Baraquiel Guardian:
	global.sprPopoBaraquielPortal				= sprite_add("../sprites/enemies/popobaraquiel/sprPopoBaraquielPortal.png", 	4, 8, 8);
	global.sprPopoBaraquielSpotlight			= sprite_add("../sprites/enemies/popobaraquiel/sprPopoBaraquielSpotlight.png",	1, 40, 32);
	global.sprPopoBaraquielRingFront			= sprite_add("../sprites/enemies/popobaraquiel/sprPopoBaraquielRingFront.png",	4, 32, 24);
	global.sprPopoBaraquielRingBack				= sprite_add("../sprites/enemies/popobaraquiel/sprPopoBaraquielRingBack.png",	4, 32, 24);
	global.sprPopoBaraquielGameover				= sprite_add("../sprites/enemies/popobaraquiel/sprPopoBaraquielGameover.png",	4, 32, 24);
	global.mskPopoBaraquiel						= sprite_add("../sprites/enemies/popobaraquiel/mskPopoBaraquiel.png",			1, 24, 24);
	global.sprPopoBaraquielIdle					= sprite_add("../sprites/enemies/popobaraquiel/sprPopoBaraquielIdle.png",		4, 24, 24);
	global.sprPopoBaraquielHurt					= sprite_add("../sprites/enemies/popobaraquiel/sprPopoBaraquielHurt.png",		3, 24, 24);
	global.sprPopoBaraquielFly					= sprite_add("../sprites/enemies/popobaraquiel/sprPopoBaraquielFly.png",		4, 24, 24);
	
	 // Battety Guardian
	global.sprPopoBatteryIdle					= sprite_add("../sprites/enemies/popobattery/sprPopoBatteryIdle.png",			4, 16, 16);
	global.sprPopoBatteryHurt					= sprite_add("../sprites/enemies/popobattery/sprPopoBatteryHurt.png",			3, 16, 16);
	global.sprPopoBatteryDead					= sprite_add("../sprites/enemies/popobattery/sprPopoBatteryDead.png",			7, 24, 24);
		
	 // Popo Striker:
	global.sprPopoStriker						= sprite_add("../sprites/enemies/popostriker/sprPopoStriker.png",				11, 64, 64);
	global.sprPopoStrikerPath					= sprite_add("../sprites/enemies/popostriker/sprPopoStrikerPath.png",			6, 230, 37);
	global.sprPopoStrikerGameover				= sprite_add("../sprites/enemies/popostriker/sprPopoStrikerGameover.png",		1, 61, 61);
	global.sprPopoStrikerFlame					= sprite_add("../sprites/enemies/popostriker/sprPopoStrikerFlame.png",			5, 40, 20);
	
	 // Popo Maggot:
	global.sprPopoMaggotIdle					= sprite_add("../sprites/enemies/popomaggot/sprPopoMaggotIdle.png",				4, 8, 8);
	global.sprPopoMaggotHurt					= sprite_add("../sprites/enemies/popomaggot/sprPopoMaggotHurt.png",				3, 8, 8);
	global.sprPopoMaggotDead					= sprite_add("../sprites/enemies/popomaggot/sprPopoMaggotDead.png",				6, 8, 8);
	
	 // Projectiles / Effects:
	global.sprPopoSkybeam       				= sprite_add("../sprites/projectiles/sprPoposkybeam.png",						1, 24, 112);
	global.sprPopoSkybeamEnd       				= sprite_add("../sprites/projectiles/sprPoposkybeamEnd.png",					2, 40, 24);
	global.sprPopoSkybeamTrail       			= sprite_add("../sprites/particles/sprPoposkybeamTrail.png",					3, 5, 5);
	global.sprPopoSkybeamEndTrail       		= sprite_add("../sprites/particles/sprPoposkybeamEndTrail.png",					4, 9, 4);
	global.sprPopoSkybeamWarning        		= sprite_add("../sprites/projectiles/sprPopoSkybeamWarning.png",				1, 48, 48);
	global.sprPopoSkybeamWarningBlink   		= sprite_add("../sprites/projectiles/sprPopoSkybeamWarningBlink.png",			2, 48, 48);
	global.mskPlasmaImpactSmall  				= sprite_add("../sprites/projectiles/mskPlasmaImpactSmall.png", 				7, 16, 16);
	global.sprPopoPlasmaSmall  					= sprite_add("../sprites/projectiles/sprPopoPlasmaSmall.png",					2, 8, 8);
	global.sprPopoPlasmaImpactSmall  			= sprite_add("../sprites/projectiles/sprPopoPlasmaImpactSmall.png", 			7, 8, 8);
	global.sprPopoExplosionSmall				= sprite_add("../sprites/projectiles/sprPopoExplosionSmall.png",				7, 12, 12);
	global.sprPopoStreak						= sprite_add("../sprites/particles/sprPopoStreak.png",							7, 8, 8);
	

		// VARS //
	global.fr_deactivemuts_array		= [];
	global.fr_spawnedaugments_array 	= [];
	global.fr_deactivemuts_array		= [];
	global.fr_augments_array			= [];
	global.fr_augments_og_array         = []; 
	
		// SURFACES // 
	global.surfacePopoAirstrike			= -4;	
	
		// AUGMENT LIST //
	var _allMuts = mod_get_names("skill");

    with(_allMuts){
    	if(mod_exists("skill", self) && mod_script_exists("skill", self, "skill_augment")){
			var _push = true;
			
			 // dont add to list if original skill doesnt exist:
			var _ogSkill = mod_script_call("skill", self, "skill_augment");
			if(is_string(_ogSkill)){
				if(!mod_exists("skill", _ogSkill)){
					_push = false;
				}
			}
			
			if(_push = true){
	    		array_push(global.fr_augments_array, self);
	        	array_push(global.fr_augments_og_array, mod_script_call("skill", self, "skill_augment"));
			}
        }
    }	
   
     // Import new IDPD:
   // customIDPD_import();

#define cleanup	
	if surface_exists(global.surfacePopoAirstrike){
		surface_destroy(global.surfacePopoAirstrike)
	}
	
#define game_start
	/*
		This part is really important because it makes whatever mutations the augment system disable actually renable themselves at the start of a run.
		It also resets the active augments thing that prevents duplicates.
	*/

	with (global.fr_deactivemuts_array) { 
		skill_set_active(self, 1) 
	}
	global.fr_deactivemuts_array			= [];
	global.fr_spawnedaugments_array 		= [];
	global.fr_augments_array				= [];
	global.fr_augments_og_array             = []; 


	 // Generate list of valid loaded augments:
    var _allMuts = mod_get_names("skill");

    with(_allMuts){
    	if(mod_exists("skill", self) && mod_script_exists("skill", self, "skill_augment")){
			var _push = true;
			
			 // dont add to list if original skill doesnt exist:
			var _ogSkill = mod_script_call("skill", self, "skill_augment");
			if(is_string(_ogSkill)){
				if(!mod_exists("skill", _ogSkill)){
					_push = false;
				}
			}
			
			if(_push = true){
	    		array_push(global.fr_augments_array, self);
	        	array_push(global.fr_augments_og_array, mod_script_call("skill", self, "skill_augment"));
			}
        }
    }
    
     // Import new IDPD:
    customIDPD_import();
 
#define customIDPD_import   
	if(global.settingNewIDPD = true){
		 // Check if in customidpd array:
		var _knownMods	= mod_variable_get("mod", "CustomIDPDHandler", "knownMods"),
	        _knownIndex = 0,
	        _seeMe		= 0;
	    repeat(array_length(_knownMods)){
	        if(_knownMods[_knownIndex] = mod_current){
	            _seeMe += 1;
	        }
	        _knownIndex += 1;
	    }
	     // If not found, add self then run idpd add functions:
	    if(_seeMe <= 0){
	    	array_push(_knownMods, mod_current);
	    	mod_variable_set("mod", "CustomIDPDHandler", "knownMods", _knownMods)
	
	    	 // Baraquiel Guardians:
	        mod_script_call("mod", "CustomIDPDHandler", "CustomIDPDSpawn_add", 
	            "elite", 
	            92,
	            [mod_current, "Baraquiel_elitecheck"],
	            [mod_current, "Baraquiel_spawn"], 
	            [mod_current, "Baraquiel_create"], 
	            undefined
	        );
	        mod_script_call("mod", "CustomIDPDHandler", "CustomIDPDSpawn_add", 
	            "freak", 
	            92,
	            [mod_current, "Baraquiel_freakcheck"],
	            [mod_current, "Baraquiel_spawn"], 
	            [mod_current, "Baraquiel_create"], 
	            undefined
	        );
	        mod_script_call("mod", "CustomIDPDHandler", "CustomIDPDSpawn_add", 
	            "elitefreak", 
				92,
	            [mod_current, "Baraquiel_elitefreakcheck"],
	            [mod_current, "Baraquiel_spawn"], 
	            [mod_current, "Baraquiel_create"], 
	            undefined
	        );
	    }        
	}
    
#define Baraquiel_create
	spr_open	= global.sprPopoPortalBigClose;
    
#define Baraquiel_spawn
	with(PopoGuardianBaraquiel_create(x + random_range(-2, 2), y + random_range(-2, 2))){
		speed = 4;
	}
	
#define Baraquiel_elitecheck
	var _weight = (global.settingNewIDPD = true && GameCont.loops >= 2) ? 15 : 0;
	return _weight;

#define Baraquiel_freakcheck
	var _weight = (global.settingNewIDPD = true && GameCont.loops >= 2) ? 8 : 0;
	return _weight;

#define Baraquiel_elitefreakcheck
	var _weight = (global.settingNewIDPD = true && GameCont.loops >= 2) ? 10 : 0;
	return _weight;


//#endregion
//#region OBJECTS
#define AugmentStation_create(_x, _y)
	with(instance_create(_x, _y, CustomObject)){
		
		name = "fr_AugmentStation";
		
		 // Visual:
		spr_idle		= global.sprAugmentStation;
		spr_dead		= global.sprAugmentStationOpen;
		spr_deny		= global.sprAugmentStationDeny;
		spr_open		= global.sprAugmentStationOpen;
		
		holocolor		= make_colour_rgb(0,255,255);
		spr_shadow		= shd32;
		spr_shadow_y	= 20;
		sprite_index	= spr_idle;
		image_speed 	= 0.4;
		hitid			= [sprite_index, "Augment Station"];
		depth			= -1;
		
		 // Sounds:
		snd_hurt		= sndHitPlant;
		snd_dead		= -1;
		
		 // Vars:
		mask_index		= mskWepPickup;
		text			= "";
		opened			= false;
		pick			= -1;
		oldskill		= mut_rhino_skin;   // Skill that the Augment Replaces
		newskill		= "AugmentExample"; // Augment Gained
		augmentname 	= "AUGMENT NAME";
		description 	= "@sAUGMENT DESCRIPTION";
		
		
		  // Prompt:
		with call(scr.prompt_create, text) { 
			on_step = AugmentStationPrompt_step;
			creator = other;
		}
		
		 // Working...:
		on_step 		= script_ref_create(AugmentStation_step);
		on_end_step 	= script_ref_create(AugmentStation_end_step);
		
		return self;
	}

#define AugmentStation_spawn(_x,_y)

	// ty chomk for making this part actually work automatically instead of me having to set them manually like before.
	 // Choose Guaranteed Augments:	
    var _augmentList = {};
    
    for (var i = 0; i < array_length(global.fr_augments_array); i++){
        lq_set(_augmentList, global.fr_augments_array[i], (skill_get(global.fr_augments_og_array[i]) > 0) & !(array_find_index(global.fr_spawnedaugments_array, global.fr_augments_array[i]) > -1));
    }

    // Choose Guaranteed Augments:    
    var _myAugment = lq_size(_augmentList) > 0 ? call(scr.pool, _augmentList) : undefined;
			
	 // Random Augment Spawns/Fallback:
	var sexy_big_balls = global.fr_augments_array[irandom(array_length(global.fr_augments_array) - 1)];
	if(_myAugment = undefined){ 
		_myAugment = choose(sexy_big_balls) 
	}
	
	 // Prevent Repeat Spawns:
	array_push(global.fr_spawnedaugments_array, _myAugment)
	
	 // Make Station:
	with AugmentStation_create(_x,_y){
		augment 	= _myAugment;
		newskill    = augment;
		augmentname = mod_script_call('skill', augment, 'skill_name')
		description = mod_script_call('skill', augment, 'skill_text')
		oldskill	= mod_script_call('skill', augment, 'skill_augment')
	}

#define AugmentStationPrompt_step
	if(pick != -1){ 
		with(creator){
			pick = 1;
		}
	}
	if !instance_exists(creator){ 
		exit; 
	}
	if(creator.opened = true){ 
		instance_destroy();
	}
	
#define AugmentStation_step
	x		= xstart;
	y		= ystart;
	speed	= 0;
	
	 // Animate:
	if(anim_end && opened = false){
		sprite_index = spr_idle;
	}
	if(anim_end &&  opened = true){
		sprite_index = spr_open;
	}

	
	 // Use Station:
	if((pick != -1) && (opened = false)){			
		if(skill_get(oldskill)) && /*checks for NT:TE temp mut*/ (array_length(instances_matching(instances_matching_ne(CustomObject, "star_scale", null), "skill", oldskill)) <= 0){
	    
	    	 // Set Station Object Vars:
	    	opened			= true;
	    	sprite_index	= spr_open;
	    	name			= "fr_AugmentStationOpened";
   	 
	    /*
	    	// this version allows keeping original mut if you have it stacked when trading (3 Boiling Veins -> 1 Overcharged Fuel and 2 Boiling Veins)
	    	skill_set(oldskill, (skill_get(oldskill) - 1));
	    	skill_set_active(oldskill, 0);
			array_push(global.fr_deactivemuts_array, oldskill);
	    	skill_set(newskill, 1);
		*/
			
			 // this version fully replaces stacks (2 Boiling Veins -> 2 Overcharged Fuel)
			var _stack = skill_get(oldskill);
	    	skill_set(oldskill, 0);
	    	skill_set_active(oldskill, 0);
			array_push(global.fr_deactivemuts_array, oldskill);
	    	skill_set(newskill, _stack);
	    	
	    	 // Update Stat:
			call(scr.save_set, "Frontier", "augments_taken", ((call(scr.save_get, "Frontier", "augments_taken")) + 1));
	   
	    	 // Sounds:
        	sound_play_pitchvol(sndIDPDNadeLoad, 1.6, 1)
			sound_play_pitchvol(sndRogueCanister, 1.1, 1)
        
        	 // Particles on Take:
        	with(Player){
        		with(instance_create(x, y, ImpactWrists)){ 
        			image_blend = make_colour_rgb(0, 255, 255); 
        			depth		= -3; 
        		}
        		repeat(5){
        			if(!instance_exists(self)){ exit; }
    				repeat(2){ 
    					with(instance_create(x + random_range(-32, 32), y + random_range(-32, 32), PlasmaTrail)){
    						sprite_index = choose(global.sprPopoSparkles, sprPopoPlasmaTrail, sprIDPDPortalCharge)
        					motion_add(point_direction(x, y, other.x, other.y), 3 + random(1));
        					wait(1);
    					}
            		}
        		}
        	}
		}
	 	 // You can't have this!
		else{
			pick			= -1;
			holocolor		= c_red;
			sprite_index	= spr_deny;
			sound_play_pitchvol(sndComputerBreak, 1.6, 1)
			wait(3)
			if !instance_exists(self){ exit; }
			sound_play_pitchvol(sndSwapGuitar, 1.6, 1)
			wait(3)
			if !instance_exists(self){ exit; }
			holocolor		= make_colour_rgb(0, 255, 255)
		}		
	}
	

	
#define AugmentStation_end_step
	var _fade = 0;
	if(opened = false){
		 // text + icon alpha control
		if(instance_place(x, y, Player)){
			script_bind_draw(AugmentStation_text, -1000, x, y, augmentname, description, oldskill);
			_fade = 1;
		}
		
		 // icon:
		script_bind_draw(AugmentStation_effects, -10, x, y, newskill, _fade, holocolor);
	}
	
#define AugmentStation_effects(_x, _y, _newskill, _fadeIn, _holoColor)
var _bob = sin(current_frame * 0.1) * 2,
	_rotBob = sin(current_frame * 0.2) * 8,
	_holoBob = sin(current_frame * 0.05) * 0.15,
	_icon = call(scr.skill_get_icon, _newskill),
	_spr  = _icon[0],
	_img  = _icon[1];
	
	instance_destroy()
	draw_sprite_ext(global.sprAugmentStationHolo, 1, _x, _y, 1 + _holoBob, 1, 0, _holoColor, 0.4)
	draw_sprite_ext(_spr, _img, _x, _y - 32 + _bob , 1, 1, 0 + _rotBob, c_white, 0.6 + _fadeIn)
	
#define AugmentStation_text(_x, _y, _augmentname, _description, _oldSkill, _player)
	instance_destroy();
	
	var _bob = sin(current_frame * 0.1) * 1
	
	var _halign = draw_get_halign(),
		_valign = draw_get_valign();
		
		
	var _descriptionLength	= string_width(_description),
		_nameLength			= string_length(_augmentname),
		_textLength 		= max((4 * _nameLength), (0.09 * _descriptionLength));
		
	var	_yoff		= 67 + (6 * round(string_count("#", _description) + 1)) + _bob,
		_replacey	= _yoff - (6 * round(string_count("#", _description) + 1)) - 13,
		_xtextoff	= 0,
		_bg_xscale	= 3 + _textLength,
		_bg_yscale	= 20 + (3 * round(string_count("#", _description)));
		
	draw_sprite_ext(global.sprAugmentTextBackground, 2, _x + _xtextoff, _y - _yoff + 8, _bg_xscale, _bg_yscale, 0, c_white, 0.3)
//	draw_sprite_ext(global.sprAugmentTextBackground, 2, _x + _xtextoff, _y - _yoff + 8, _bg_xscale + 3, _bg_yscale + 3, 0, c_white, 0.3)
	
	draw_set_font(fntSmall);
	draw_set_halign(1)
	draw_set_valign(0)
	draw_text_nt(_x + _xtextoff, _y - _yoff, _description)
	draw_set_font(fntM);
	draw_set_valign(2)
	draw_text_nt(_x + _xtextoff, _y - _yoff - 1, _augmentname)
	draw_text_nt(_x + _xtextoff - 8, _y - _replacey, "REPLACES")
	var	_icon = call(scr.skill_get_icon, _oldSkill),
	_spr  = _icon[0],
	_img  = _icon[1];
	
	draw_sprite(_spr, _img, _x + _xtextoff + 33, _y - _replacey - 4)
	draw_set_halign(_halign)
	draw_set_valign(_valign)

#define AugmentStationFloor_create(_x,_y)

	with instance_create(x,y,CustomObject){
		name		 = "fr_AugmentStationFloor";
		sprite_index = global.sprAugmentStationFloor;
		mask_index	 = mskNone;
		image_speed  = 0;
		depth		 = 8;
		speed		 = 0;
	}
	
#define AugmentMonolith_create(_x, _y)
	with(instance_create(_x, _y, CustomProp)){
		
		name = "fr_augmentmonolith"
		
		 // Visual:
		spr_idle	= global.sprAugmentMonolith;
		spr_hurt	= global.sprAugmentMonolithHurt;
		spr_dead	= global.sprAugmentMonolithDead;
		
		 // Sounds:
		snd_hurt	= sndHitMetal;
		snd_dead	= sndComputerBreak;
		
		 // Vars:
		maxhealth	= 35;
		my_health	= maxhealth;
		team		= 3;
		
		 // Go Go Go:
		on_step 	= AugmentMonolith_step;
		on_death	= AugmentMonolith_destroy;
		
		return self;
	
	}

#define AugmentMonolith_step
	x		= xstart;
	y		= ystart;
	speed	= 0;

	if (random(10) < 1){
		with instance_create(x, y, BulletHit){
			sprite_index	= choose(global.sprPopoSparkles, sprPopoPlasmaTrail)
			direction		= choose(45, 135, 225, 315) + random_range(-10, 10)
			speed			= 4;
		}
	}
	
#define AugmentMonolith_destroy
	PopoGuardianBattery_create(x, y)

//#region HQ EXIT
#define HQExit_create(_x, _y)
	with(instance_create(_x, _y, CustomObject)){
		name = "fr_HQExit";
		
		 // Visual:
		spr_idle		= global.sprHQExit;
		spr_shadow		= shd16;
		sprite_index	= spr_idle;
		image_speed 	= 0.4;
		hitid			= [sprite_index, "HQ EXIT"];
		depth			= 8;
		
		 // Sounds:
		snd_hurt		= sndHitPlant;
		snd_dead		= -1;
		
		 // Vars:
		my_health		= 500;
		size			= 1;
		text			= "EXIT";
		team			= 3;
		
		 // Prompt:
		with call(scr.prompt_create, text) { 
			on_step = HQExit_step; 
			opened	= false;
		}
		
		return self;
	}
	
#define HQExit_step
	x		= xstart;
	y		= ystart;
	speed	= 0;
	
	 // Use Station:
	if(pick != -1 && opened = false){
	    
	    // Set Object Vars:
	    opened = true;
	    name = "fr_HQExitOpened";
	    
	      // Exit HQ:
		with instance_create(x, y, Portal){ 
			type = 3; 
		}
		with(GameCont){
			area = lastarea
		}

        sound_play_pitchvol(sndIDPDPortalSpawn, 1.2, 1);
        sound_play(sndPortalAppear);
	}
	
//#endregion
//#region POPOMAGGOTS
#define PopoMaggots_spawn(_x, _y)
	repeat(3){
		with(instance_create(x, y, AcidStreak)){
			sprite_index	= global.sprPopoStreak;
			depth			= -3;
		}
	}
	repeat(20){
		with(instance_create(x, y, RadMaggot)){
			spr_idle		= global.sprPopoMaggotIdle;
			spr_walk		= global.sprPopoMaggotIdle;
			spr_hurt		= global.sprPopoMaggotHurt;
			spr_dead		= global.sprPopoMaggotDead;
			hitid			= [spr_idle, "STRIKE MAGGOT"];
			sprite_index	= spr_idle;
			raddrop 		-= 1;
			fr_maggotPopo	= true;
			team			= 3;
		}
	}

#define PopoMaggotController_create(_x, _y)
	with(instances_matching(CustomObject, "name", "fr_popoMaggotController")){
		instance_delete(self);
	}
	with(instance_create(_x, _y, CustomObject)){
		name		= "fr_popoMaggotController";
		
		on_end_step 	= PopoMaggotController_endstep;
	}
	
#define PopoMaggotController_endstep
	with(instances_matching_lt(instances_matching_ne(RadMaggot, "fr_maggotPopo", null), "my_health", 0)){
		if(random(4) < 1){
			sound_play_hit_ext(sndExplosionS, 0.5 + random_range(0.8, 1.3), 0.8);
			sound_play_hit_ext(sndExplosionS, 0.7 + random_range(0.8, 1.3), 1.2);
			with(PopoExplosionSmall_create(x, y)){
				hitid	= [global.sprPopoMaggotIdle, "STRIKE MAGGOT"];
				damage	= 1;
			}
		}
	}

//#endregion
//#region ENEMIES
#define PopoGuardianBaraquiel_create(_x, _y)

	with instance_create(_x, _y, CustomEnemy){
   
    	name = "Baraquiel Guardian"
    	
        // Visuals:
        spr_idle		= global.sprPopoBaraquielIdle;
		spr_walk		= global.sprPopoBaraquielIdle;
		spr_hurt		= global.sprPopoBaraquielHurt; 
		spr_dead		= global.sprPopoBatteryDead;
		spr_gameover	= global.sprPopoBaraquielGameover;
		spr_port		= global.sprPopoBaraquielPortal;
		spr_look		= global.sprPopoBaraquielSpotlight;
		spr_ring_front	= global.sprPopoBaraquielRingFront;
		spr_ring_back	= global.sprPopoBaraquielRingBack;
		spr_wing		= global.sprPopoBaraquielFly;
		sprite_index    = spr_idle;
		image_speed     = 0.4;
		depth           = -7;
		hitid           = [spr_gameover, "BARAQUIEL GUARDIAN"]
        spr_shadow      = shd64;	
        spr_shadow_y    = 16;
        nts_color_blood = [c_aqua, make_color_rgb(14, 19, 134)]
        
        // Sounds:
        snd_hurt		= sndCrownGuardianHurt;
        snd_dead		= sndCrownGuardianDead;
        
        // Vars:
        mask_index  	= global.mskPopoBaraquiel;
        mask_save		= mask_index;
        direction   	= random(360);
        maxhealth   	= 120;
       	my_health   	= maxhealth;
        raddrop     	= 0;
        maxspeed    	= 2;
        walkspeed   	= maxspeed;
        flightspeed		= 5.5;
        size			= 3;
        canmelee    	= 0;
        canfly			= true;
        flying			= false;
        eyepos			= 0;
        eyeright		= 1;
        lookscale		= 0;
        team        	= 3; 
        targetvisible	= 0;
        target      	= 0;
        walk        	= 0;
        freeze			= 0;
        z				= 0;
        flying			= false;
        timeToLand		= false;
        landingZone		= noone;
        
        // Alarms:
        alarm1 = 20 + irandom(30);

        // Scripts:
        on_step  = script_ref_create(PopoGuardianBaraquiel_step);
        on_draw  = PopoGuardianBaraquiel_draw;
        on_hurt  = Enemy_hurt;
        on_death = PopoBaraquiel_death;
        on_alrm1 = script_ref_create(PopoGuardianBaraquiel_alrm1);
        
        return self;
	}
	
#define PopoGuardianBaraquiel_step

	 // Alarms:
	if("on_alrm1" in self and alarm1_run) exit;

		// Movement:
	if(walk > 0){ walk -= current_time_scale;   speed += walkspeed * current_time_scale; gunangle = direction }
	
		//Speed Cap:
	if(speed > maxspeed){ speed = maxspeed; }
	
	 // Animate:
	if(sprite_index != spr_wing && anim_end){ 
		sprite_index = spr_idle; 
	}
	if(flying = true){
		if(sprite_index != spr_hurt){
			sprite_index = spr_wing;
		}
	}

	 // LOOK AT ME!! LOOK AT ME!!!
	if instance_exists(target){
		eyepos = target_direction;
		eyeright = (eyepos + 270) mod 360 > 180 ? 1 : -1;
	
		// Enable/Disable Spotlight:
		if (target_distance < 100){ 
			if (lookscale < 1){ lookscale += 0.2 * current_time_scale } 
		} else{ 
			if (lookscale > 0){ lookscale -= 0.2 * current_time_scale } 
		}
	}
	else{
		eyeright = (eyepos + 270) mod 360 > 180 ? 1 : -1;
		if (lookscale > 0){ lookscale -= 0.2 * current_time_scale } 
	}
	
		// Flip Correctly:
	right = (direction + 270) mod 360 > 180 ? 1 : -1;
	
		// Danger, in every passing stranger:
	if(instance_exists(Player)){
		with(Player){
			if(speed > 1.5 || other.my_health < other.maxhealth){
				other.freeze += current_time_scale;
			}
			if(can_shoot == false){
				other.freeze += 3 * current_time_scale;
			}
		}
	}

#define PopoGuardianBaraquiel_alrm1
	alarm1 = 50 + irandom(5);
	
	if(flying = true){
		
		 // Get Goin!
		if(timeToLand = false){
			if(z < 40){
				alarm1 = 1;
				y -= 2;
				z += 2;
				spr_shadow_y += 2;
			} else {
				alarm1 = round(distance_to_object(landingZone) / maxspeed);
				enemy_walk(point_direction(x, y, landingZone.x, landingZone.y), alarm1)
				timeToLand	= true;
			}
		} else {
			if(z > 0){
				alarm1 = 1;
				y += 2.5;
				z -= 2.5;
				spr_shadow_y -= 2.5;
			} else {
				 
				 // LAND! 
				flying			= false;
				sprite_index	= spr_idle;
				maxspeed		= walkspeed;
				depth			= -7;
				with instance_create(x, y, PortalClear){
					image_xscale	= 0.6;
					image_yscale	= image_xscale;
				}
				repeat(12){
					with(instance_create(x, y + 8, Dust)){
						direction	= random(360);
						speed		= random(5);
					}
				}
			}
		}
		
		 // Set Mask based off Height:
		if(z <= 12){
			mask_index	= mask_save;
		} else {
			mask_index  = mskNone;
		}
	} else {
		
		if(instance_exists(target)){
			if(target_distance < 96 && chance(1, 3)){
				PopoGuardianBaraquiel_fly();
			}
		}
				
			// STRIKE HIM DOWN:
		if(enemy_target(x, y) && instance_exists(target) && freeze != 0 && chance(1, 2)){
			with PopoSkybeamSpawn_create(target.x + (target.hspeed * random_range(10, 20)), target.y + (target.vspeed * random_range(10, 20))){
				hitid	= other.hitid;
				team	= other.team;
				creator = other;
			}
		}
		
		   // Strollin around at the speed of sound:
		else {
			direction = random(360);
			enemy_walk(direction, alarm1);
		}
	}
	
#define PopoGuardianBaraquiel_fly
	with(instance_furthest(x, y, Floor)){
		var _validZones 	= instances_meeting_rectangle(x - 96, y - 96, x + 96, y + 96, Floor);
		other.landingZone	= call(scr.instance_random, _validZones)
	}
	
	flying			= true;
	timeToLand		= false;
	alarm1			= 1;
	maxspeed		= flightspeed;
	depth			= -10;
	
	sound_play_pitch(sndCrownGuardianAppear, 0.8);
	
	repeat(15){
		with(instance_create(x, y + 8, Dust)){
			direction	= random(360);
			speed		= random(7);
		}
	}
	
#define PopoGuardianBaraquiel_draw

	var _y			= (y + sin(current_frame * 0.06) * 4),
		_ring1rot	= image_angle + sin(current_frame * (0.06)) * 75,
		_ring2rot	= image_angle + sin(current_frame * (0.04)) * -75;
	
	 // White if Hurt:
	if(nexthurt >= current_frame + 4){ 
		d3d_set_fog(1, c_white, 0, 0);
	}
	
	 // Back of Rings:
	draw_sprite_ext(spr_ring_back, current_frame * 0.4, x, _y, image_xscale * right, image_yscale, _ring1rot, image_blend, image_alpha)
	draw_sprite_ext(spr_ring_back, current_frame * 0.4, x, _y, image_xscale * right, image_yscale, _ring2rot, image_blend, image_alpha)
	
	 // ME!
	draw_sprite_ext(sprite_index, image_index, x, _y, image_xscale * right, image_yscale, image_angle, image_blend, image_alpha);
	draw_sprite_ext(spr_port, current_frame * 0.4, x + lengthdir_x(11, eyepos), _y + lengthdir_y(11, eyepos), 1 * eyeright, 1, 0, c_white, 1);
	

	 // Front of Rings:
	draw_sprite_ext(spr_ring_front, current_frame * 0.4, x, _y, image_xscale * right, image_yscale, _ring1rot, image_blend, image_alpha)
	draw_sprite_ext(spr_ring_front, current_frame * 0.4, x, _y, image_xscale * right, image_yscale, _ring2rot, image_blend, image_alpha)
	
	// Spotlight:
	if(lookscale > 0 && flying = false){
		var spotbob = sin(current_frame * 0.05) * 0.15
		draw_sprite_ext(spr_look, current_frame * 0.4, x + lengthdir_x(44, eyepos), _y + lengthdir_y(44, eyepos), 1, lookscale + spotbob, eyepos, c_white, 0.3);
	}
	
	 // Reset Fog:
	d3d_set_fog(0, 0, 0, 0)
	
#define PopoBaraquiel_death
/*
	with(instance_create(x, y, PopoExplosion)){
		sprite_index	= sprRogueExplosion;
		mask_index		= mskExplosion;
	}
*/
	pickup_drop(120, 20);

#define PopoGuardianBattery_create(_x, _y)

	with instance_create(_x, _y, CustomEnemy){
   
    	name = "Battery Guardian"
    	
        // Visuals: 
        spr_idle		= global.sprPopoBatteryIdle;
		spr_walk		= global.sprPopoBatteryIdle;
		spr_hurt		= global.sprPopoBatteryHurt; 
		spr_dead		= global.sprPopoBatteryDead;
		sprite_index    = spr_idle;
		image_speed     = 0.4;
		depth           = -2;
		hitid           = [spr_idle, "BATTERY GUARDIAN"]
        spr_shadow      = shd24;	
        spr_shadow_y	= 4;
        nts_color_blood = [c_aqua, make_color_rgb(14, 19, 134)]
        
        // Sounds:
        snd_hurt		= sndCrownGuardianHurt;
        snd_dead		= sndCrownGuardianDead;
        
        // Vars:
        mask_index  	= mskBandit;
        direction   	= random(360);
        maxhealth   	= 16;
       	my_health   	= maxhealth;
        raddrop     	= 0;
        maxspeed    	= 2;
        walkspeed   	= maxspeed;
        size			= 1;
        canmelee    	= 0;
        team        	= 3; 
        targetvisible	= 0;
        target      	= 0;
        walk        	= 0;
        freeze			= 0;
        
        // Alarms:
        alarm1 = 20 + irandom(30);

        // Scripts:
        on_step  = script_ref_create(PopoGuardianBattery_step);
        on_draw  = BatteryGuardian_draw;
        on_hurt  = Enemy_hurt;
        on_death = PopoGuardianBattery_death;
        on_alrm1 = script_ref_create(PopoGuardianBattery_alrm1);
        
        return self;
	}
	
#define PopoGuardianBattery_step

	 // Alarms:
	if("on_alrm1" in self and alarm1_run) exit;

		// Movement:
	if(walk > 0){ walk -= current_time_scale;   speed += walkspeed * current_time_scale; gunangle = direction }
	
		//Speed Cap:
	if(speed > maxspeed){ speed = maxspeed; }
	
	 // Animate:
	if(anim_end){ sprite_index = spr_idle; }
	
		// Flip Correctly:
	right = (direction + 270) mod 360 > 180 ? 1 : -1;
	
		// Danger, in every passing stranger:
	if(instance_exists(Player)){
		with(Player){
			if(speed > 1.5 || other.my_health < other.maxhealth){
				other.freeze += current_time_scale;
			}
			if(can_shoot == false){
				other.freeze += 3 * current_time_scale;
			}
		}
	}

#define PopoGuardianBattery_alrm1
	alarm1 = 50 + irandom(5);
				
		// MURDER:
	if(enemy_target(x, y) and (target_visible) and freeze != 0 and chance(1, 3)){
		gunangle = target_direction;
		with MiniPlasma_create(x, y) {
			team	    = other.team;
			direction   = other.gunangle + random_range(-5, 5);
			image_angle = direction;
			hitid		= other.hitid;
		}
		
		motion_add(gunangle, -3)
		sound_play_pitchvol(sndEliteShielderFire, (0.6 + random(0.3)), 0.8)
		
		repeat(10){
			with instance_create(x, y, PlasmaTrail){
				sprite_index	= sprPopoPlasmaTrail;
				direction		= random(360);
				speed			= random(2);
			}
		}
		
	}
	
	   // im just goin:
	else {
		direction = random(360);
		enemy_walk(direction, alarm1);
	}

#define PopoGuardianBattery_death
	pickup_drop(40, 0)
	
#define BatteryGuardian_draw
	var _y = y + sin(current_frame * 0.06) * 4.5
	draw_set_blend_mode(bm_normal);
	draw_sprite_ext(sprite_index, image_index, x, _y, image_xscale * right, image_yscale, image_angle, image_blend, image_alpha);
	
#define PopoAirstrikeSpawner_create(_x, _y)

	with instance_create(_x, _y, CustomObject){
		
		name = "fr_AirstrikeSpawn"
		
		sprite_index	= mskNone;
		alarm0			= 100 + irandom(200)
		on_step 		= PopoAirstrikeSpawner_step;
	
		return self;
	}
	
#define PopoAirstrikeSpawner_step
	alarm0 -= current_time_scale;
	if(alarm0 <= 0){
		if(instance_exists(Player)){
			var who2kill = call(scr.instance_random, Player)
			PopoAirstrike_create(who2kill.x, who2kill.y)
		}
		instance_delete(self);
	}
	
#define PopoAirstrike_create(_x, _y)

	with instance_create(_x, _y, CustomObject){
	
		 // VRRRVRVRRRRR:
		sound_play(global.sndStrikerWarning);

		name			= "STRIKER"
	
		 // Visual:
		spr_striker		= global.sprPopoStriker;
		spr_airstrike	= global.sprPopoStrikerPath;
		spr_flames		= global.sprPopoStrikerFlame;
		sprite_index	= sprRogueStrikeTB;
		image_alpha		= 0;
		image_xscale	= 2;
		image_yscale	= 1.3;
		direction   	= random(360);
		image_angle 	= direction;
		depth			= -11;
		striker_dis		= -2200;
		striker_x		= x + lengthdir_x(striker_dis, direction);
		striker_y		= y + lengthdir_y(striker_dis, direction);
	
		 // Vars:
		team			= 3;
		lifetime		= 135;
		striked			= false;
		flownby			= false;
		didit			= false;
		freaked			= false;
		if(GameCont.loops >= 3){
			freaked	= true;
		}

		on_step			= PopoAirstrike_step;
		on_end_step		= PopoAirstrike_endstep
		on_draw			= PopoStriker_draw;
		on_destroy		= PopoStriker_destroy;
		
	
		return self;
	}

#define PopoAirstrike_step
	// Striker on The Move:
	striker_dis 	+= (current_time_scale * 30);
	striker_x		= x + lengthdir_x(striker_dis, direction);
	striker_y		= y + lengthdir_y(striker_dis, direction);
	
	if (striker_dis > 50 && flownby = false) {
		sound_play_pitch(sndNothingDeath2, 2.5)
		sound_play(global.sndStrikerFly)
		view_shake_at(x, y, 300)
		flownby = true
	}
	
	// Bombing Run
	lifetime -= current_time_scale;
	if (lifetime < 50 && striked = false){
		AirstrikeBomb_spawn();
		sprite_index = mskNone;
		striked = true;
	}
	
	 // Extra Particles:
	if(freaked = true){
		if(current_frame_active){
			with instance_create(striker_x + random_range(-30, 30), striker_y + random_range(-30, 30), Smoke){
				image_xscale	= 1.5 + random(0.5);
				image_yscale	= image_xscale;
				speed			= 3 + random(2);
				direction		= other.direction + 180;
				depth			= -10;
			}
		}
	}
	
	// Live your lifetime
	if(lifetime <= 0){
		instance_destroy();
	}

#define PopoAirstrike_endstep
	if(flownby = false){
		script_bind_draw(PopoAirstrike_draw, 0, spr_airstrike, x, y, image_angle)
	}
		
#define PopoAirstrike_draw(_spr_airstrike, _x, _y, _angle)
	draw_sprite_ext(_spr_airstrike, current_frame, _x, _y, 1, 1, _angle, c_white, 1)
	instance_destroy();

#define PopoStriker_draw

	if(!surface_exists(global.surfacePopoAirstrike)){
		global.surfacePopoAirstrike = surface_create(game_width, game_height);
	}

	surface_set_target(global.surfacePopoAirstrike)
		
	var ns_x		= view_xview_nonsync; 
	var ns_y		= view_yview_nonsync;
	var stack		= 1; // repeats in a single pixel stack
	var height		= 11; // frames/height of spritestack
	
	draw_clear_alpha(c_white, 0) 

	for (var i = 0; i <= height; i ++;){
		for (var s = 1; s <= stack; s ++;){
			var o = ((s - 1) / stack);

			for(i = 0; i < sprite_get_number(spr_striker); i++){
				draw_sprite_ext(spr_striker, i, striker_x - ns_x, striker_y - (i - o) - ns_y, 1, 1, direction, image_blend, 1);
			}
		}
	}
	
	surface_reset_target()
	
	 // Outlines:
	draw_surface_ext(global.surfacePopoAirstrike, ns_x + 1, ns_y, 1, 1, 0, c_black, 1)
	draw_surface_ext(global.surfacePopoAirstrike, ns_x - 1, ns_y, 1, 1, 0, c_black, 1)
	draw_surface_ext(global.surfacePopoAirstrike, ns_x, ns_y + 1, 1, 1, 0, c_black, 1)
	draw_surface_ext(global.surfacePopoAirstrike, ns_x, ns_y - 1, 1, 1, 0, c_black, 1)

	draw_surface(global.surfacePopoAirstrike, ns_x, ns_y)
	
	 // Flames:
	if(freaked = true){
		draw_sprite_ext(spr_flames, current_frame * 0.4, striker_x + lengthdir_x(-80, direction), striker_y + lengthdir_y(-40, direction), image_xscale, image_yscale, direction, image_blend, 1);
		draw_sprite_ext(spr_flames, 2 + (current_frame * 0.4), striker_x + lengthdir_x(-20, direction), striker_y + lengthdir_y(-60, direction), image_xscale, image_yscale, direction, image_blend, 1);
	}

#define PopoStriker_destroy
	if(freaked = true){
		sound_play_pitchvol(sndNukeExplosion, 0.8 + random(0.1), 0.3)
	}
	
#define AirstrikeBomb_spawn

	for (var i = -4; 4 >= i; i ++){
		var _length = (sprite_width * i) / 8;
	
		with(instance_create(x + lengthdir_x(_length, direction) + random_range(-25, 25), y + lengthdir_y(_length, direction) + random_range(-25, 25), CustomObject)){
			team		= other.team;
			lifetime	= (i + 2) * 2 + 1;
			on_step 	= AirstrikeBomb_step;
		}
	}
	
#define AirstrikeBomb_step
	lifetime -= current_time_scale;
	if(lifetime <= 0){
		with(instance_create(x, y, PopoExplosion)){
			sprite_index	= sprRogueExplosionTB;
			mask_index		= mskPopoExplo;
			hitid			= [global.sprPopoStrikerGameover, "STRIKER"];
			team			= other.team;

			sound_play_hit_big(sndExplosion, 0.3);
			sound_play_hit_big(sndIDPDNadeExplo, 0.2);
		
			repeat(15){
				with instance_create(x + random_range(-50,50), y + random_range(-50,50), BlueFlame){
					sprite_index = sprBlueFlameBig;
				}
			}
		}
		instance_destroy();
	}	
	
//#endregion
//#region ENEMY PROJECTILES
#define PopoSkybeamSpawn_create(_x, _y)

	with instance_create(_x,_y, CustomObject){
		
		sound_play_pitchvol(sndIDPDNadeLoad, random_range(1.3,1.4), 1.4)
			
		name			= "fr_skybeamspawn"

    	sprite_index	= global.sprPopoSkybeamWarning; 
    	spr_blink   	= global.sprPopoSkybeamWarningBlink;   
		image_speed		= 0.4;
		image_angle		= random(360);
		depth      		= -1;
		image_xscale	= 0.1;
		image_yscale	= image_xscale;
		fr_bloom 		= [1.1, 0.1];
		speenspeed		= 0;
		
		timer      		= 35;
    	creator			= other;
    	team   			= other.team; 
    	hitid			= other.hitid;
	 
		on_step    		= PopoSkybeamSpawn_step;
		on_destroy 		= PopoSkybeamSpawn_destroy;
	 
		return self;
	 
	}

#define PopoSkybeamSpawn_step

	if(current_frame_active){
		image_angle += (4 + speenspeed);
		speenspeed += 0.8;
	}

	if(image_xscale < 1){ 
		image_xscale += 0.25 * current_time_scale; 
		image_yscale = image_xscale 
	}
	if(timer > 0){ 
		timer -= current_time_scale 
	}
	if(timer < 15){ 
		sprite_index = spr_blink; 
	}
	if(timer <= 0){ 
		instance_destroy(); 
	}

#define PopoSkybeamSpawn_destroy
	PopoSkybeam_create(x, y)

#define PopoSkybeam_create(_x, _y)

	sound_play_pitchvol(sndIDPDNadeExplo, random_range(0.5,0.7), 1)
	sound_play_pitchvol(sndExplosionL, random_range(1.2,1.4), 1)
	sound_play_pitchvol(sndStrongSpiritLost, random_range(0.5,0.6), 1)
	sound_play_pitchvol(sndStrongSpiritGain, random_range(0.3,0.4), 0.7)
	sound_play_pitchvol(sndPlasmaHuge, random_range(0.5,0.7), 0.7)
	


    with instance_create(_x, _y, CustomProjectile){
    	
    	// Break Walls:
    	instance_create(x, y, PortalClear)
    	
    	// Scorched Earth:
    	instance_create(x, y, Scorch)
    	repeat(11){
    		with instance_create(x + random_range(-20, 20), y, Smoke){
      			motion_add(90, random(2))
      			image_xscale = random_range(0.5, 1.5)
    			image_yscale = image_xscale
      			gravity 	 = -friction
      			depth		 = -9;
      		}
  			with instance_create(x, y, Dust){
  				motion_set(random(360), 3 + random(5))
	    	}
	    	with instance_create(x + random_range(-20, 20), y + random_range(-20, 20), BlueFlame){
	    		sprite_index = choose(sprBlueFlame, sprBlueFlameBig);
	    	}
    	}
  	
    	
    	// Visuals:
        mask_index  	= sprPlasmaBall;
        image_xscale	= 2.5;
        image_yscale	= 2.5;
    	depth			= -8;
    	beamscale		= 3;
    	
    	// Vars:
    	damage			= 6;
        hitlist			= [];
        hitid			= other.hitid;
        team			= other.team;
        creator			= other.creator;
        
        on_step			= PopoSkybeam_step;
        on_hit			= PopoSkybeam_hit;
        on_wall			= nothing;
        on_draw			= PopoSkybeam_draw;

        return self;
    }

#define PopoSkybeam_step
	if (random(3) < 1){
		with instance_create(x + random_range(-16, 16), y + random_range(-120, 10), BulletHit){
			sprite_index	= global.sprPopoSkybeamTrail;
			depth			= -9;
			speed			= random(6);
			direction		= 270;
			image_angle		= direction;
		}
	}

  	with instance_create(x, y, Dust){
  		motion_set(random(360), 3 + random(3))
	}
	
	if (random(3) < 1){
		with instance_create(x + random_range(-26, 26), y + 20, BulletHit){
			sprite_index	= global.sprPopoSkybeamEndTrail;
			depth			= -9;
			speed			= random(6);
			direction		= 90 + random_range(-25, 25)
			image_angle		= direction;
		}
	}	
	    	
	beamscale -= 0.08 * current_time_scale;
	image_xscale = beamscale;
	image_yscale = image_xscale;
	if (beamscale <= 0){ instance_destroy(); }

#define PopoSkybeam_hit

	if array_find_index(hitlist,other) == -1 {
	array_push(hitlist,other)
		with(other){
			projectile_hit(self,other.damage,other.force)
			lasthit = other.hitid
		}
	}

#define PopoSkybeam_draw
	// Main:
	draw_sprite_ext(global.sprPopoSkybeam, 1, x, y - 96, clamp(beamscale, 0, 1) + random(0.2), 1, 0, c_white, 1);
	// Bloom:
	draw_sprite_ext(global.sprPopoSkybeam, 1, x, y - 96, clamp(beamscale, 0, 1) * 1.1, 1, 0, c_white, 0.4);
	// Splash:
	draw_sprite_ext(global.sprPopoSkybeamEnd, current_frame * 0.4, x, y + 12, clamp(beamscale, 0, 1), 1, 0, c_white, 1);


 // Mini Plasma
#define MiniPlasma_create(_x, _y)
	with instance_create(_x, _y, CustomProjectile){
		
    	// Visuals:
    	sprite_index	= global.sprPopoPlasmaSmall;
    	spr_trail		= sprPopoPlasmaTrail;
    	spr_explo		= global.sprPopoPlasmaImpactSmall;
    	image_angle		= direction;
    	fr_bloom		= [2, 0.1];
	  
    	// Vars:
    	speed 		= 7 * power(0.8, skill_get(mut_euphoria));
    	typ   		= 1;
    	damage		= 2;
    	creator		= other;
    	team  		= other.team;
    	hitid 		= [sprite_index, "MINI PLASMA"];

		on_anim		= MuzzleFlash_anim;
    	on_step		= MiniPlasma_step;
		on_wall		= MiniPlasma_wall;
    	on_destroy	= MiniPlasma_destroy;

		return self;
    }
    
#define MiniPlasma_step
	if(random(4) < 1){
		with instance_create(x + random_range(-4, 4), y + random_range(-4, 4), PlasmaTrail){ 
			sprite_index	= other.spr_trail; 
			direction		= other.direction; 
		}
	}
	
	if (image_xscale < 0.8 ){ 
		instance_destroy(); 
	}

#define MiniPlasma_wall
	image_xscale -= 0.1;
	image_yscale = image_xscale;
	x = xprevious;
	y = yprevious;
	sound_play_pitchvol(sndHitWall, random_range(0.9, 1.2), 1)
	with instance_create(x, y, Dust){
		image_xscale = 0.5;
		image_yscale = image_xscale;
	}
    
#define MiniPlasma_destroy
	sound_play_pitchvol(sndPlasmaHit, random_range(1.1, 1.3), 0.8)
	with instance_create(x, y, PlasmaImpact){
		damage			= 2;
		team			= other.team;
		sprite_index	= other.spr_explo;
		mask_index		= global.mskPlasmaImpactSmall;
		hitid			= other.hitid;
	}
	
#define PopoExplosionSmall_create(_x, _y)
	with(instance_create(_x, _y, PopoExplosion)){
		sprite_index	= global.sprPopoExplosionSmall;
		mask_index		= mskSmallExplosion;
		team			= 3;
		
		return self;
	}
	
//#endregion
//#region GENERIC FUNCTIONS
#macro  anim_end                                                                                ((image_index + image_speed_raw) >= image_number || (image_index + image_speed_raw) < 0)
#macro  current_frame_active                                                                    frac(current_frame) < current_time_scale
#macro  target_visible                                                                          !collision_line(x, y, target.x, target.y, Wall, false, false)
#macro  target_direction                                                                        point_direction(x, y, target.x, target.y)
#macro  target_distance                                                                         point_distance(x, y, target.x, target.y)
#macro  anim_end																				((image_index + image_speed_raw) >= image_number || (image_index + image_speed_raw) < 0)
#macro  enemy_sprite                                                                            (sprite_index != spr_hurt || anim_end) ? ((speed == 0) ? spr_idle : spr_walk) : sprite_index
#macro  alarm0_run                                                                              alarm0 && !--alarm0 && !--alarm0 && (script_ref_call(on_alrm0) || !instance_exists(self))
#macro  alarm1_run                                                                              alarm1 && !--alarm1 && !--alarm1 && (script_ref_call(on_alrm1) || !instance_exists(self))
#macro  alarm2_run                                                                              alarm2 && !--alarm2 && !--alarm2 && (script_ref_call(on_alrm2) || !instance_exists(self))
#macro  alarm3_run                                                                              alarm3 && !--alarm3 && !--alarm3 && (script_ref_call(on_alrm3) || !instance_exists(self))
#macro  alarm4_run                                                                              alarm4 && !--alarm4 && !--alarm4 && (script_ref_call(on_alrm4) || !instance_exists(self))
#macro  alarm5_run                                                                              alarm5 && !--alarm5 && !--alarm5 && (script_ref_call(on_alrm5) || !instance_exists(self))
#macro  alarm6_run                                                                              alarm6 && !--alarm6 && !--alarm6 && (script_ref_call(on_alrm6) || !instance_exists(self))
#macro  alarm7_run                                                                              alarm7 && !--alarm7 && !--alarm7 && (script_ref_call(on_alrm7) || !instance_exists(self))
#macro  alarm8_run                                                                              alarm8 && !--alarm8 && !--alarm8 && (script_ref_call(on_alrm8) || !instance_exists(self))
#macro  alarm9_run                                                                              alarm9 && !--alarm9 && !--alarm9 && (script_ref_call(on_alrm9) || !instance_exists(self))
#define orandom(_num)                                                                   		return  random_range(-_num, _num);
#define chance(_numer, _denom)                                                          		return  random(_denom) < _numer;
#define chance_ct(_numer, _denom)                                                       		return  random(_denom) < _numer * current_time_scale;
#define angle_lerp_ct(_ang1, _ang2, _num)                                               		return  _ang2 + (angle_difference(_ang1, _ang2) * power(1 - _num, current_time_scale));
#define enemy_walk(_dir, _num)                                                                  direction = _dir; walk = _num; if(speed < friction) speed = friction;
#define enemy_face(_dir)                                                                        _dir = ((_dir % 360) + 360) % 360; if(_dir < 90 || _dir > 270) right = 1; else if(_dir > 90 && _dir < 270) right = -1;
#define enemy_look(_dir)                                                                        _dir = ((_dir % 360) + 360) % 360; if(_dir < 90 || _dir > 270) right = 1; else if(_dir > 90 && _dir < 270) right = -1; if('gunangle' in self) gunangle = _dir;
#define enemy_target(_x, _y)                                                            		target = (instance_exists(Player) ? instance_nearest(_x, _y, Player) : ((instance_exists(target) && target >= 0) ? target : noone)); return (target != noone);
#define BasicEnemy_draw                             											draw_sprite_ext(sprite_index, image_index, x, y, image_xscale * right, image_yscale, image_angle, image_blend, image_alpha);
#define GunEnemy_draw                               											if gunangle < 180{ draw_sprite_ext(spr_weap,0,x + lengthdir_x(-wkick,gunangle), y + lengthdir_y(-wkick, gunangle), 1, right, gunangle, image_blend, image_alpha);} draw_sprite_ext(sprite_index,image_index,x,y,image_xscale * right, image_yscale, image_angle, image_blend, image_alpha); if gunangle >= 180{ draw_sprite_ext(spr_weap,0,x + lengthdir_x(-wkick,gunangle), y + lengthdir_y(-wkick, gunangle), 1, right, gunangle, image_blend, image_alpha);}
#define MeleeEnemy_draw																			if(gunangle <= 180) draw_weapon(spr_weap, 0, x, y, gunangle, wepangle, wkick, 1, image_blend, image_alpha); image_xscale *= right; draw_self(); image_xscale /= right; if(gunangle >  180) draw_weapon(spr_weap, 0, x, y, gunangle, wepangle, wkick, 1, image_blend, image_alpha);
#define MortarEnemy_draw																		if(gunangle <= 180) draw_weapon(spr_weap, 0, x, y, lerp(90, 45, dcos(gunangle)), 0, wkick, right, image_blend, image_alpha); image_xscale *= right; draw_self(); image_xscale /= right; if(gunangle >  180) draw_weapon(spr_weap, 0, x, y, lerp(90, 45, dcos(gunangle)), 0, wkick, right, image_blend, image_alpha);
#define nothing
#define Enemy_hurt(_dmg, _spd, _dir)
	sprite_index = spr_hurt;
	image_index  = 0;
	
	sound_play_hit(snd_hurt, 0.3);
	motion_add(_dir, _spd);
	
	nexthurt   = current_frame + 6;
	my_health -= _dmg;
	
#define Prop_hurt(_dmg, _spd, _dir)
	my_health -= _dmg;
	nexthurt   = current_frame + 6;
	
	sound_play_hit(snd_hurt, 0.3);
	
	sprite_index = spr_hurt;
	image_index  = 0;

#define draw_weapon(_sprite, _image, _x, _y, _angle, _angleMelee, _kick, _flip, _blend, _alpha)
	/*
		Drawing weapon sprites
		
		Ex:
			draw_weapon(sprBanditGun, gunshine, x, y, gunangle, 0, wkick, right, image_blend, image_alpha)
			draw_weapon(sprPipe, 0, x, y, gunangle, wepangle, wkick, wepflip, image_blend, image_alpha)
	*/
	
	 // Melee Offset:
	if(_angleMelee != 0){
		_angle += _angleMelee * (1 - (_kick / 20));
	}
	
	 // Kick:
	if(_kick != 0){
		_x -= lengthdir_x(_kick, _angle);
		_y -= lengthdir_y(_kick, _angle);
	}
	
	 // Draw:
	draw_sprite_ext(_sprite, _image, _x, _y, 1, _flip, _angle, _blend, _alpha);

#define instances_meeting_rectangle(_x1, _y1, _x2, _y2, _obj)
	/*
		Returns all instances of the given object whose bounding boxes overlap the given rectangle
		Much better performance than checking 'collision_rectangle()' on every instance
		
		Args:
			x1, y1, x2, y2 - The rectangular area to search
			obj            - The object(s) or instance(s) to search
	*/
	
	return (
		instances_matching_le(
		instances_matching_le(
		instances_matching_ge(
		instances_matching_ge(
		_obj,
		"bbox_right",  _x1),
		"bbox_bottom", _y1),
		"bbox_left",   _x2),
		"bbox_top",    _y2)
	);
	
#define sound_play_hit_ext(_sound, _pitch, _volume)
	/*
		'sound_play_hit()' distance-based sound, but with pitch and volume arguments
	*/
	
	var _snd = sound_play_hit(_sound, 0);
	
	sound_pitch(_snd, _pitch);
	sound_volume(_snd, audio_sound_get_gain(_snd) * _volume);
	
	return _snd;
	
#define MuzzleFlash_anim
    image_index = 1;
    image_speed = 0;

#define GenericTrail_create(_x, _y) 
    with instance_create(_x, _y, Wind){
        sprite_index     = global.sprGenericTrail;
        mask_index       = mskNone;
        image_speed      = 2;
        image_yscale     = (1/50);
        image_xscale     = 1;
        depth			 = 0;
        
        return self;
    }
    
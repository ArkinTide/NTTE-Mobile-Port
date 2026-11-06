#define init
	// Jsburg is the only reason why the lasertraps exist/work at all, tyty
	
	
	// youve GOT to fix enemies getting stuck in lasertraps later
	
		// LIB:
	while(!mod_exists("mod", "lib")){wait(1);}
	script_ref_call(["mod", "lib", "getRef"], "area", mod_current, "scr");
	#macro  scr			global.scr
	#macro  call		script_ref_call
	
		// Sounds //
	global.musRobocenter 						= sound_add("../sounds/music/musRobocenter.ogg");
	global.ambRobocenter 						= sound_add("../sounds/ambience/ambRobocenter.ogg");
	
		// Area Sprites //
	global.sprAreaIcon							= sprite_add("../sprites/menu/sprLabsRouteIcon.png",						1, 4, 4);
//	global.sprFloor 							= sprite_add("../sprites/areas/robocenter/sprFloorRobocenter.png",			1, 0, 0);
	global.sprFloor 							= sprite_add("../sprites/areas/robocenter/sprFloorRobocenterBig.png",		1, 16, 16);
	global.sprFloorB							= sprite_add("../sprites/areas/robocenter/sprFloorRobocenterB.png", 		3, 0, 0);
	global.sprFloorExplo						= sprite_add("../sprites/areas/robocenter/sprFloorRobocenterExplo.png", 	4, 1, 1);
	global.sprWallBot							= sprite_add("../sprites/areas/robocenter/sprWallRobocenterBot.png",		6, 0, 0);
	global.sprWallTop				    		= sprite_add("../sprites/areas/robocenter/sprWallRobocenterTop.png",		8, 0, 0);
	global.sprWallOut							= sprite_add("../sprites/areas/robocenter/sprWallRobocenterOut.png",		1, 4, 12);
	global.sprWallTrans 						= sprite_add("../sprites/areas/robocenter/sprWallRobocenterTrans.png",		5, 0, 0);
	global.sprDebris							= sprite_add("../sprites/areas/robocenter/sprDebrisRobocenter.png", 		4, 4, 4);
	global.sprDetail							= sprite_add("../sprites/areas/robocenter/sprDetailRobocenter.png", 		3, 4, 4);
	global.sprTopDecal							= sprite_add("../sprites/areas/robocenter/sprTopDecalRobocenter.png", 		2, 16, 16);

		// Laser Trap Sprites //
	global.sprLaserTrap 						= sprite_add("../sprites/areas/robocenter/sprLaserTrap.png",				1, 12, 16);
	global.sprLaserTrapGameover 				= sprite_add("../sprites/areas/robocenter/sprLaserTrap.png",				1, 11, 8);
	global.sprLaserTrapBeam     				= sprite_add("../sprites/projectiles/sprLaserTrapBeam.png", 				1, 0, 6);
	global.mskLaserTrapBeam     				= sprite_add("../sprites/projectiles/mskLaserTrapBeam.png", 				1, 2, 6);
	global.sprLaserTrapBeamEnd  				= sprite_add("../sprites/particles/sprLaserTrapBeamEnd.png",				3, 5, 5);
	global.sprLaserTrapBeamStart				= sprite_add("../sprites/projectiles/sprLaserTrapBeamStart.png",			0, 8, 8);
	global.sprLaserTrapHead 					= sprite_add("../sprites/projectiles/sprLaserTrapHead.png", 				0, 8, 2)
	global.sprWarningLaser      				= sprite_add("../sprites/projectiles/sprWarningLaser.png",					1, 0, 6);
	global.sprLaserTrapTop						= sprite_add("../sprites/areas/robocenter/sprLaserTrapTop.png", 			1, 0, 0);
	global.sprLaserTrapOff 						= sprite_add("../sprites/areas/robocenter/sprLaserTrapOff.png", 			1, 12, 16);
	global.sprLaserTrapTopOff					= sprite_add("../sprites/areas/robocenter/sprLaserTrapTopOff.png",			1, 0, 0);

		// Props //
	global.mskBattery							= sprite_add("../sprites/areas/robocenter/props/mskBattery.png",			1, 24, 29);
	global.sprBattery							= sprite_add("../sprites/areas/robocenter/props/sprBattery.png",			10, 24, 29);
	global.sprBatteryHurt						= sprite_add("../sprites/areas/robocenter/props/sprBatteryHurt.png",		3, 24, 29);
	global.sprBatteryDead						= sprite_add("../sprites/areas/robocenter/props/sprBatteryDead.png",		3, 24, 29);
	global.mskAssembler							= sprite_add("../sprites/areas/robocenter/props/mskAssembler.png",			1, 16, 16);
	global.sprAssembler							= sprite_add("../sprites/areas/robocenter/props/sprAssembler.png",			10, 16, 16);
	global.sprAssemblerHurt						= sprite_add("../sprites/areas/robocenter/props/sprAssemblerHurt.png",		3, 16, 16);
	global.sprAssemblerDead						= sprite_add("../sprites/areas/robocenter/props/sprAssemblerDead.png",		3, 16, 16);
	global.sprDeeplabsEntranceClosed			= sprite_add("../sprites/areas/robocenter/sprDeeplabsEntrance.png", 		1, 48, 18);
	global.sprDeeplabsEntranceOpening			= sprite_add("../sprites/areas/robocenter/sprDeeplabsEntranceOpening.png",	4, 48, 18);
	global.sprDeeplabsEntranceOpen				= sprite_add("../sprites/areas/robocenter/sprDeeplabsEntranceOpen.png", 	1, 48, 18);

	#macro minSearchDiff				1
	#macro lasertrap_spawnchance    	60
	#macro anim_end 					((image_index + image_speed_raw) >= image_number || (image_index + image_speed_raw) < 0)
	#macro current_frame_active 		(current_frame < floor(current_frame) + current_time_scale)
	global.arenaGened					= false;
	global.settingLabsRouteAltMode		= false;

#define area_subarea        	return 1;
#define area_goal           	return 145;
#define area_next           	return (global.settingLabsRouteAltMode = true && !mod_exists("area", "scorpionboss")) ? [7, 1] : (mod_exists("area", "scorpionboss")) ? ["labs", 1] : [6, 1];
#define area_background_color	return make_color_rgb(21, 21, 39);
#define area_shadow_color   	return c_black;
#define area_darkness       	return true;
#define area_secret         	return false;
#define area_outside			return false;
    
#define area_name
	return (global.settingLabsRouteAltMode = true ? `@1(${real(global.sprAreaIcon)}:0)6-`+string(GameCont.subarea) : `@1(${real(global.sprAreaIcon)}:0)2-`+string(GameCont.subarea));

#define area_text
	return choose(
		"DOING WORK",
		"WATCH OUT FOR THE BEAMS", 
		"ASSEMBLERS",
		"THE ANSWER IS BENEATH US",
		"ONE MILLION SPRINGS"
	);
	
#define area_mapdata(_x, _y)
    return [99, -9];
   
#define area_areaicon
	return [
		global.sprAreaIcon,
		(global.settingLabsRouteAltMode = true ? "6-" + string(GameCont.subarea) : "2-" + string(GameCont.subarea))
	]
    
#define area_sprite(_sprite)

	switch (_sprite) {
    	case sprFloor1: 			with([self, other]) if(instance_is(self, Floor)){ area_setup_floor(); break; } return global.sprFloor;
    	case sprFloor1B:			with([self, other]) if(instance_is(self, Floor)){ area_setup_floor(); break; } return global.sprFloorB;
    	case sprFloor1Explo:		return global.sprFloorExplo;
    	case sprWall1Trans: 		return global.sprWallTrans;
    	case sprWall1Bot:			return global.sprWallBot;
    	case sprWall1Out:			return global.sprWallOut;
    	case sprWall1Top:			return global.sprWallTop;
    	case sprDebris1:			return global.sprDebris;
		case sprDetail1:			return global.sprDetail;
	}

#define area_setup

	sound_play_music(global.musRobocenter)
    sound_play_ambient(global.ambRobocenter);
    
	goal             = area_goal();
	background_color = area_background_color();
	BackCont.shadcol = area_shadow_color();
	TopCont.darkness = area_darkness();
    safespawn		 = 1;
    
     // Wall Breaking Sounds:
    sound_assign(sndWallBreakRock, sndWallBreakLabs);
   
#define area_setup_floor

	 // Fix BFloor Depth:
	if(styleb){ 
		depth += 1; 
	}
	
	material = 3;
   
#define area_start

	 // Half-Dark:
	 // See Frontier_Main's draw_dark
	with(instance_create(0, 0, CustomObject)){
		name = "fr_area_halfdark"
	}

	 // Top Decals:
	with(Floor){ 
		if(random(20) < 1){
			with instance_create(x, y, TopDecalCity){
				name			= "fr_RobocenterDecal";
				sprite_index	= global.sprTopDecal;
				image_speed		= 0.4;
				image_xscale	= choose(-1, 1);
				dir 			= choose(-1, 1);
				fr_glow			= [48, 64];
			}
		}
	}
	
	 // Deeplabs Entrance:
	if(!mod_exists("mod", "betterPVP")){
		with(DeeplabsEntrance_create(10016, 10016)){
			portalPusher = mod_script_call("mod", "Frontier_Objects", "PortalPusher_create", x, y, 72);
		}
	}
	
	
	 // Laser Traps:
	var lasertrap_amount = 0;
	with(Floor){
		if !place_meeting(x, y, AmmoChest || WeaponChest || RadChest || prop || enemy){
			if random(lasertrap_spawnchance) < 1 || (lasertrap_amount < 3){
				var myx = x + choose(0, 16);
				var myy = y + choose(0, 16);

				if (point_distance(myx, myy, Player.x, Player.y)) > 90 && (distance_to_object(BigWeaponChest) > 64){
					with(instance_create(myx, myy, Wall)){
						instance_create(x, y, NOWALLSHEREPLEASE)
						LaserTrap_create(myx + 8, myy + 8);
						lasertrap_amount += 1;
						topspr = global.sprLaserTrapTop;
					}
				}
			}
		}
	}

	 // Boss Spawning - Loop Exclusive:
	with(instances_matching(Floor, "fr_robobossSpawn", true)){
		mod_script_call("mod", "Frontier_Bosses", "RoboBoss_create", x + 16, y + 16);
	}
	
	 // Fix Enemies stuck in lasertraps:
	with(enemy){
		if(place_meeting(x, y, Wall)){
			var _furthestFloor = instance_furthest(10016, 10016, Floor);
			x = _furthestFloor.x; 
			y = _furthestFloor.y;
			instance_create(_furthestFloor.x, _furthestFloor.y, PortalClear);
		}
	}
	
#define area_make_floor

	var _x = x,
		_y = y,
		_outOfSpawn = (point_distance(_x, _y, 10000, 10000) > 48);
		
	 // Place Floor:
    instance_create(_x, _y, Floor);
    
    // 3x3 Rooms:
	if(random(14) < 1) {
	scrFloorFill(_x, _y, 3, 3);
	}
	
     // Change Direction:
    var _turn = 0;
    if(random(3) < 1){
    	_turn = choose(90, 270, 270, 180);
    }
    direction += _turn;
    
     // Weapon Chests:
    if(_outOfSpawn && _turn == 180){
    	instance_create(_x + 16, _y + 16, WeaponChest);
    }
    
     // Ammo Chests and Dead Ends:
    if(random(19 + instance_number(FloorMaker)) > 20){
    	if(_outOfSpawn){
    		instance_create(_x + 16, _y + 16, AmmoChest);
    	}
    	instance_destroy();
    }
    
     // Branch Generation:
    if(random(7) < 1){
    	instance_create(_x, _y, FloorMaker);
    }
  
     // Boss Arena:
	with(GenCont) if(instance_number(Floor) > goal / 1.5) && (global.arenaGened = false) && (GameCont.loops >= 1){ 
		var _furthestFloor = instance_furthest(10016, 10016, Floor);
		with(_furthestFloor){
			fr_robobossSpawn = true;
		}
		scrFloorFill(_furthestFloor.x, _furthestFloor.y, 7, 9);
		scrFloorFill(_furthestFloor.x, _furthestFloor.y, 9, 7);
		global.arenaGened = true;
	}

#define scrFloorFill(_x, _y, _w, _h)
    var o = 32;

     // Center Around x,y:
    _x -= floor((_w - 1) / 2) * o;
    _y -= floor((_h - 1) / 2) * o;

     // Floors:
    for(var _ox = 0; _ox < _w; _ox++){
        for(var _oy = 0; _oy < _h; _oy++){
            instance_create(_x + (_ox * o), _y + (_oy * o), Floor);
        }
    }
    
#define area_pop_enemies
	var _x = (bbox_left + bbox_right) / 2,
		_y = (bbox_top  + bbox_bottom) / 2;
		
	var _enemy = call(scr.pool, [
        [["Swarmbot_spawn",			"MOD", "Frontier_Labs"],    	2],
        [["Engineer_create",		"MOD", "Frontier_Labs"],    	2],
        [["MissileDrone_create",	"MOD", "Frontier_Labs"],    	2],
  //      [["Honeypot_create",		"MOD", "Frontier_Labs"],    	0],
        [[BecomeTurret, 			"Basegame", ""],				1],
        [[Wolf,						"Basegame", ""],    			1 * (GameCont.loops > 0)],
	])
	
	if(random(2.5) < 1){
		switch(_enemy[1]){
			case "Basegame": {
				instance_create(_x, _y, _enemy[0]);
			}
			break;
			case "MOD": {
				mod_script_call("mod", _enemy[2], _enemy[0], _x, _y)
			}
			break;
			case "OBJ": {
				mod_script_call("mod", _enemy[2], "obj_create", _x, _y, _enemy[0])
			}
			break;
		}	
	}
	
#define area_pop_props
	var _x = (bbox_left + bbox_right) / 2,
		_y = (bbox_top  + bbox_bottom) / 2,
		_outOfSpawn = (point_distance(x, y, 10000, 10000) > 48);

	 // Props:
	if(_outOfSpawn){
		if(random(18) < 1) && !(place_meeting(_x, _y, prop)){
			var _prop = call(scr.pool, [	
		        ["Battery_create",    	1],
		        ["Assembler_create",    1],
			]);
			mod_script_call("area", mod_current, _prop, _x, _y);
		}
	}
	
#define area_finish

	 // Next Subarea:
	if(subarea < area_subarea()){
		subarea++;
	}
	
	 // Next Area:
	else{
		var _next = area_next();
		area    = _next[0];
		subarea = _next[1];
	}
	
	global.arenaGened = false;
    
#define area_transit
    // Restore Wall Sounds:
    sound_restore(sndWallBreakRock);
    
	sound_stop(mod_variable_get("mod", "Frontier_Bosses", "bulwarkLaserLoop"));
	sound_stop(mod_variable_get("mod", "Frontier_Bosses", "bulwarkShockLoop"));
    
//#region LASERTRAP SCRIPTS

#define LaserTrap_create(_myx, _myy)

	with(instance_create(_myx, _myy, CustomObject)){
		
		// Visual:
		depth = -6;
		spr_active		= global.sprLaserTrap;
		spr_off 		= global.sprLaserTrapOff;
		spr_top_active	= global.sprLaserTrapTop;
		spr_top_off		= global.sprLaserTrapTopOff;
		sprite_index	= global.sprLaserTrap;
		
		// Vars:
		creator 	= instance_position(x, y, Wall);
		fire_timer	= 80 + irandom(30);
		fire_mode	= choose(1, 2)
		active		= true;
		
		// Functions:
		on_step = LaserTrap_step;
	}
		


	
#define LaserTrap_step

	 // Destroy if Wall Dead:
	if !instance_exists(creator){ instance_destroy(); exit; }
    
	 // Timer:
	if (fire_timer > 0) { 
		fire_timer -= current_time_scale; 
	}
    
    
     // Turn Off:
    if(active = true && instance_exists(Portal)){
    	active			= false;
    	sprite_index	= spr_off;
    	creator.topspr	= spr_top_off;
    }
     
     // Turn Back On:
    if(active = false && !instance_exists(Portal)){
    	active			= true;
    	sprite_index	= spr_active;
    	creator.topspr	= spr_top_active;
    	fire_timer		+= 50 + irandom(30);
    }
    
     // Active if No Portal:
	if(active = true && fire_timer <= 0){ 
		fire_timer += 60; 
		LaserTrap_fire()
	}


#define LaserTrap_fire

switch(fire_mode) {
	// this code is pretty crap, but it works, I might clean it up later, the OG code is from 2021
	
	case 1:
				// Warning:
	repeat(3){
		if !instance_exists(self){ exit;}
		
	if !instance_position(x, y + 16, Wall){
		WarningBeam_create(x, y + 8, 270.014)
	}

	if !instance_position(x, y - 16, Wall){
		WarningBeam_create(x, y - 8, 90.014)
	}

	if !instance_exists(self){ exit;}
		wait(5); }
	if !instance_exists(self){ exit;}

				// Laser:
	if !instance_position(x, y + 16, Wall){
		Beam_create(x,y + 16, 270.014)
	}

	if !instance_position(x, y - 16, Wall){
		Beam_create(x, y - 16 , 90.014)
	}

		fire_mode = 2;
	
	break;
	
	case 2:
				// Warning:
	repeat(3){
		if !instance_exists(self){ exit;}

	if !instance_position(x - 16, y, Wall){
		WarningBeam_create(x - 8, y, 180)
	}

	if !instance_position(x + 16, y, Wall){
		WarningBeam_create(x + 8, y, 0)
	}

	if !instance_exists(self){ exit;}
		wait(5); }
	if !instance_exists(self){ exit;}

				// Laser:
	if !instance_position(x - 16, y, Wall){
		Beam_create(x - 16, y, 180)
	}

	if !instance_position(x + 16, y, Wall){
		Beam_create(x + 16, y, 0)
	}
	
		fire_mode = 1;
	
	break;
	
}

#define WarningBeam_create(_x, _y, _direction)

	with instance_create(_x, _y, CustomProjectile){
	
		// Visuals:
    	image_angle 	= _direction;
 		sprite_index	= global.sprWarningLaser;
		mask_index  	= mskLaser;
		image_speed		= 0;
	
		// Vars:
    	direction		= _direction;
    	creator 		= other;
    	team			= 1;
    	lifetime		= 3;
    	typ 			= 0;
       
		// Functions:
    	on_step			= WarningBeam_step;
		on_hit  		= nothing;
    	on_wall 		= nothing;
		on_draw 		= warning_draw;
	
		var scanLength = binary_search(script_ref_create(check_laser_style), 500);
    	x = xstart + lengthdir_x(scanLength, image_angle);
    	y = ystart + lengthdir_y(scanLength, image_angle);
    	image_xscale = scanLength/2;
    	xprevious = x
    	yprevious = y
	
		return self;
	}

#define Beam_create(_x ,_y, _direction)

	with instance_create(_x, _y, CustomProjectile){
		name			= "fr_LaserTrapBeam";
	
		// Visuals:
    	image_angle 	= _direction;
		sprite_index	= global.sprLaserTrapBeam;
		mask_index  	= global.mskLaserTrapBeam;
		spr_tail    	= global.sprLaserTrapBeamStart;
		spr_head    	= global.sprLaserTrapHead;
		image_speed		= 0;
		
		// Vars:
    	direction		= _direction;
    	creator 		= other;
    	team			= 1;
    	lifetime		= 25;
    	typ 			= 0;
       
		// Functions:
    	on_step			= Beam_step;
		on_hit  		= Beam_hit;
    	on_wall 		= nothing;
		on_draw 		= Beam_draw;
	
		var scanLength	= binary_search(script_ref_create(check_laser_style), 500);
    	x				= xstart + lengthdir_x(scanLength, image_angle);
    	y				= ystart + lengthdir_y(scanLength, image_angle);
    	image_xscale	= scanLength / 2;
    	xprevious		= x
    	yprevious		= y
    
		sound_set_track_position(sndEnergyHammerUpg, 0.3)
		sound_pitch(sndEnergyHammerUpg, 0)
		sound_play_pitchvol(sndEnergyHammerUpg, 0.4 * random_range(0.9, 1.1), 0.25)
		sound_play_pitchvol(sndLaserCannon, 1.5 + random(0.3), 0.2)
	
		return self;
	}

#define Beam_step

	if instance_exists(creator){
	
			// Lifetime:
    	lifetime -= current_time_scale
    	if lifetime <= 0 {instance_destroy(); exit}
    
    		// Particles:
    	if (random(5) < 1){
    	var _r = random_range(0, image_xscale * 2 + 12)
        	with instance_create(x - lengthdir_x(_r, direction) + random_range(-5, 5), y - lengthdir_y(_r, direction) + random_range(-5, 5), BulletHit) {
        		sprite_index	= global.sprLaserTrapBeamEnd
        		image_angle 	= other.direction
				image_speed 	= 0.4;
        		motion_set(other.direction,choose(1, 2))
        	}
    	}
    		// Flooby Beam:
    	image_yscale = 1 * random_range(0.8, 1.1)
    
	}
	else instance_destroy()   

#define binary_search(checkScript, searchLength)
    var length = searchLength,
        lenDiff = searchLength;
    
    //First check, if missed, exit early.
    if (script_ref_call(checkScript, length)) {
        lenDiff /= 2;
        length -= lenDiff;
    }
    else {
        return searchLength;
    }
    
    while (lenDiff > minSearchDiff) {
        lenDiff /= 2;
        //Hit something, reduce length
        if (script_ref_call(checkScript, length)) {
            length -= lenDiff;
        }
        //Miss, increase length
        else {
            length += lenDiff;
        }
    }
    return length;
    
//The script called by binary_search
#define check_laser_style(length)
    //Remember, the scope is already the laser since this is in its step event
    x = xstart + lengthdir_x(length, image_angle);
    y = ystart + lengthdir_y(length, image_angle);
    image_xscale = length / 2;
    //We don't have to reset coordinates or scale because it gets reset anyhow.
    return place_meeting(x, y, Wall);  //|| place_meeting(x, y, enemy) ||; this pierces things so just dont have this part - plus it should prob be HitMe or Player or something

#define Beam_hit
	var _team = team,
	    _ang  = direction
	with(other){
		if("fr_beamVaporize" in self){
			if(fr_beamVaporize = true){
				my_health	= 0;
				snd_hurt	= sndFootPlaSand5;
				snd_dead	= sndFootPlaSand5;
				repeat(10){
					with(instance_create(x + random_range(-10, 10), y + random_range(-10, 10), BulletHit)){
						sprite_index	= global.sprLaserTrapBeamEnd;
						direction		= random(360);
						speed			= 1 + random(2);
					}
				}
			}
		}
		if nexthurt <= current_frame{
			projectile_hit(self,other.damage)
			lasthit = [global.sprLaserTrapGameover, "LASER TRAP"];
		}
	}
	
#define Beam_draw
	draw_sprite_ext(sprite_index, image_index, xstart, ystart, image_xscale, image_yscale, image_angle, image_blend, 1.0);
	if x != xstart draw_sprite_ext(spr_tail, 1, xstart, ystart, 1, image_yscale, image_angle, image_blend, 1.0);
	if x != xstart draw_sprite_ext(spr_head, 0, x, y, image_yscale * 2, image_yscale * 2, image_angle - 45, image_blend, 1.0);

	// BLOOM:
	draw_sprite_ext(sprite_index, image_index, xstart, ystart, image_xscale, image_yscale*1.7, image_angle, image_blend, 0.2);
	if x != xstart draw_sprite_ext(spr_tail, 1, xstart, ystart, 1, image_yscale*1.5, image_angle, image_blend, 0.2); 
	if x != xstart draw_sprite_ext(spr_head, 0, x, y, image_yscale * 2.7, image_yscale * 2.7, image_angle - 45, image_blend, 0.2); 

#define WarningBeam_step
	if instance_exists(creator){
		// Lifetime:
    	lifetime -= current_time_scale
    	if (lifetime <= 0) {instance_destroy(); exit}
	} 
	else instance_destroy();
#define warning_draw
	draw_sprite_ext(sprite_index, image_index, xstart, ystart, image_xscale, image_yscale, image_angle, image_blend, 1.0);
	draw_sprite_ext(sprite_index, image_index, xstart, ystart, image_xscale, image_yscale*1.7, image_angle, image_blend, 0.2);//bloom
	
#define nothing
	// nothing to see here..

//#region PROPS
#define Battery_create(_x, _y)
	with(instance_create(_x, _y, CustomProp)){
		
		name = "fr_RoboBattery";
		
		 // Visual:
		spr_idle		= global.sprBattery;
		spr_hurt		= global.sprBatteryHurt;
		spr_dead		= global.sprBatteryDead;
		sprite_index	= spr_idle;
		image_index		= irandom(image_number);
		depth			= -1;
		spr_shadow		= -1;
		fr_glow			= [32, 48];
		
		 // Sounds:
		snd_hurt		= sndHitMetal;
		snd_dead		= sndComputerBreak;
		
		 // Vars:
		mask_index		= global.mskBattery;
		maxhealth		= 20;
		my_health		= maxhealth;
		size			= 3;
		fr_beamVaporize = true;

		 // Fix Wiggle:
		x = round(x);
		y = round(y);
		
		return self;
	}
	
#define Assembler_create(_x, _y)
	with(instance_create(_x, _y, CustomProp)){
		
		name = "fr_RoboAssembler";
		
		 // Visual:
		spr_idle		= global.sprAssembler;
		spr_hurt		= global.sprAssemblerHurt;
		spr_dead		= global.sprAssemblerDead;
		sprite_index	= spr_idle;
		image_index		= irandom(image_number);
		depth			= -1;
		spr_shadow		= -1;
		
		 // Sounds:
		snd_hurt		= sndHitMetal;
		snd_dead		= sndComputerBreak;
		
		 // Vars:
		mask_index		= global.mskAssembler;
		maxhealth		= 24;
		my_health		= maxhealth;
		size			= 3;
		fr_beamVaporize = true;

		 // Fix Wiggle:
		x = round(x);
		y = round(y);
		
		return self;
	}

//#region DEEPLABS ENTRANCE
#define DeeplabsEntrance_create(_x, _y)
	with(instance_create(_x, _y, CustomObject)){
		
		name = "fr_DeeplabsEntrance";
		
		 // Visual:
		spr_closed		= global.sprDeeplabsEntranceClosed;
		spr_opening 	= global.sprDeeplabsEntranceOpening;
		spr_open		= global.sprDeeplabsEntranceOpen;
		sprite_index	= spr_closed;
		image_speed 	= 0.4;
		depth			= 5;
		fr_glow 		= [0, 0];
		portalPusher	= noone;
		
		 // Vars:
		entranceopen = false;
		
		 // Events:
		on_step = script_ref_create(DeeplabsEntrance_step);
		
		return self;
	}
	
#define DeeplabsEntrance_step

	x = xstart;
	y = ystart;
	speed = 0;

	 // Enter Area:
	if(instance_exists(Portal) && place_meeting(x, y, Player) && entranceopen = true){
		with(GameCont){
			area = "deeplabs";
			subarea = 0;
		}
		with(instance_create(x, y, Portal)){
			image_alpha = 0;
		}
		with(portalPusher){
			instance_destroy();
		}
		entranceopen = false;
	}
	
	 //Checks if a portal exists to open it
	if instance_exists(Portal) && (sprite_index != spr_open){
		sprite_index = spr_opening;
		image_speed = 0.4;
		fr_glow = [48, 64];
			if(anim_end) && (sprite_index != spr_open) && (sprite_index != spr_closed){
				entranceopen = true
			}
		if (entranceopen = true){
			sound_play(sndGeneratorBreak)
			sprite_index = spr_open;
		}
	}
	
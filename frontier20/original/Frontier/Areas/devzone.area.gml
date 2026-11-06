#define init
	
	 // stops idpd from spawning in devzone
	global.noPopo	= true;

		// Area Sprites //
	global.sprAreaIcon				= sprite_add("../sprites/areas/devzone/sprAreaIconDevzone.png", 1, 4, 4);	
	global.sprFloor 				= sprite_add("../sprites/areas/devzone/sprFloorDevzone.png", 1, 0, 0);
	global.sprFloorB				= sprite_add("../sprites/areas/devzone/sprFloorDevzoneB.png", 1, 0, 0);
	global.sprFloorExplo			= sprite_add("../sprites/areas/devzone/sprFloorDevzoneExplo.png", 4, 1, 1);	
	global.sprWallBot				= sprite_add("../sprites/areas/devzone/sprWallDevzoneBot.png", 3, 0, 0);
	global.sprWallTop				= sprite_add("../sprites/areas/devzone/sprWallDevzoneTop.png", 1, 0, 0);
	global.sprWallOut				= sprite_add("../sprites/areas/devzone/sprWallDevzoneOut.png", 1, 4, 12);
	global.sprWallTrans 			= sprite_add("../sprites/areas/devzone/sprWallDevzoneTrans.png", 1, 0, 0);
	global.sprDebris				= sprite_add("../sprites/areas/devzone/sprDebrisDevzone.png", 4, 4, 4);
	global.sprDetail				= sprite_add("../sprites/areas/devzone/sprDetailDevzone.png", 6, 4, 4);
	//global.sprTopDecal			= sprite_add("sprites/areas/devzone/sprDevzoneTopDecal.png",3,16,24);
	
	 // Devbox:
	global.sprDevbox1				 = sprite_add("../sprites/areas/devzone/props/sprDevbox1.png", 1, 12, 12);
	global.sprDevbox1Hurt			 = sprite_add("../sprites/areas/devzone/props/sprDevbox1Hurt.png", 3, 12, 12);
	global.sprDevbox2				 = sprite_add("../sprites/areas/devzone/props/sprDevbox2.png", 1, 12, 12);
	global.sprDevbox2Hurt			 = sprite_add("../sprites/areas/devzone/props/sprDevbox2Hurt.png", 3, 12, 12);
	global.sprDevbox3				 = sprite_add("../sprites/areas/devzone/props/sprDevbox3.png", 1, 12, 12);
	global.sprDevbox3Hurt		     = sprite_add("../sprites/areas/devzone/props/sprDevbox3Hurt.png", 3, 12, 12);
	global.sprDevbox1Dead			 = sprite_add("../sprites/areas/devzone/props/sprDevboxDead.png", 4, 12, 12);
	
	 // Devcone:
	global.sprDevcone				 = sprite_add("../sprites/areas/devzone/props/sprDevcone.png", 1, 12, 14);
	global.sprDevconeHurt			 = sprite_add("../sprites/areas/devzone/props/sprDevconeHurt.png", 3, 12, 14);
	global.sprDevconeDead			 = sprite_add("../sprites/areas/devzone/props/sprDevconeDead.png", 4, 12, 14);
	
	 // Devlight:
//	global.sprDevLight				 = sprite_add("../sprites/areas/devzone/props/sprDevLight.png", 1, 16, 52);
//	global.sprDevLightHurt			 = sprite_add("../sprites/areas/devzone/props/sprDevLightHurt.png", 3, 16, 52);
//	global.sprDevLightDead			 = sprite_add("../sprites/areas/devzone/props/sprDevLightDead.png", 3, 16, 52);

#define area_subarea        	return 99;
#define area_goal           	return 130;
#define area_next           	return [1, 1];
#define area_background_color	return make_color_rgb(65, 83, 124);
#define area_shadow_color   	return c_black;
#define area_darkness       	return false;
#define area_secret         	return false;
#define area_outside			return true;
    
#define area_name
	return `@1(${real(global.sprAreaIcon)}:0)D-`+string(GameCont.subarea);

#define area_text
	return choose(
		"WHAT",
		"TESTING TESTING",
		"WAIT HOLD ON",
		"IS IT WORKING",
		"CTRL+S!!!"
	);
	
#define area_mapdata(_x, _y)
    return [99, -9];
    
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

	sound_play_music(mus3b)
    sound_play_ambient(amb6);
    
	goal             = area_goal();
	background_color = area_background_color();
	BackCont.shadcol = area_shadow_color();
	TopCont.darkness = area_darkness();
	GameCont.norads	 = 1; // I HATE YOU HORROR
    safespawn		 = 1;
    
     // Area Step:
    script_bind_step(area_step, 0);
    
     // Wall Breaking Sounds:
    sound_assign(sndWallBreakRock, sndWallBreakLabs);
   
#define area_setup_floor
	material = 3;
   
    
#define area_start
	 // STOP THAT PORTAL!!!!!!!
	instance_create(10016, 10016, becomenemy)
	
#define area_make_floor

	var _x = x,
		_y = y,
		_outOfSpawn = (point_distance(_x, _y, 10000, 10000) > 48);
		
	 // Place Floor:
    instance_create(_x, _y, Floor);
    
    // 3x3 Rooms:
	if(random(10) < 1) {
	scrFloorFill(_x, _y, 3, 3);
	}
	
     // Change Direction:
    var _turn = 0;
    if(random(2) < 1){
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
	
#define area_pop_props

if (random(25) < 1) DevBox_create(x + 16,y + 16);
if (random(40) < 1) DevCone_create(x + 16,y + 16);
//if (random(60) < 1) DevLight_create(x + 16,y + 16);


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
    
#define area_transit
    // Restore Wall Sounds:
    sound_restore(sndWallBreakRock);
    
#define area_step
	 // NO POPO
	if(global.noPopo = true){
		if(instance_exists(WantPopo) || instance_exists(WantVan)){
			with(WantPopo){
				instance_delete(self);
			}
			with(WantVan){
				instance_delete(self);
			}
		}
		if(instance_exists(VanSpawn) || instance_exists(IDPDSpawn) || array_length(instances_matching(CustomObject, "name", "IDPDPortal")) > 0){
			with(IDPDSpawn){
				instance_delete(self);
			}
			with(VanSpawn){
				instance_delete(self);
			}
			with(instances_matching(CustomObject, "name", "IDPDPortal")){
				instance_delete(self);
			}
			sound_stop(sndIDPDPortalSpawn);
			sound_stop(sndEliteIDPDPortalSpawn);
			sound_stop(sndVanWarning);
		}
	}
    
//#region PROPS
#define ExampleProp_create(_x, _y)
	with(instance_create(_x, _y, CustomProp)){
		
		 // Visual:
		spr_idle	= global.sprDevbox1;
		spr_hurt	= global.sprDevbox1Hurt;
		spr_dead	= global.sprDevbox1Dead;
		 // Sounds:
		snd_hurt	= sndHitMetal;
		snd_dead	= sndStreetLightBreak;
		 // Vars:
		maxhealth	= 4;
		my_health	= maxhealth;
		mask_index	= mskSpider
		team		= 0;
		
		return self;
	}

//Devzone Props	
#define DevBox_create(_x, _y)
	with(instance_create(_x, _y, CustomProp)){
		
		 // Visual:
		altsprite	= choose(1,2,3)
		 
		if altsprite = 1{
		spr_idle = global.sprDevbox1;
		spr_hurt = global.sprDevbox1Hurt;}
		if altsprite = 2{
		spr_idle = global.sprDevbox2;
		spr_hurt = global.sprDevbox2Hurt;}
		if altsprite = 3{
		spr_idle = global.sprDevbox3;
		spr_hurt = global.sprDevbox3Hurt;}
		
		
		spr_dead	= global.sprDevbox1Dead;
		 // Sounds:
		snd_hurt	= sndHitMetal;
		snd_dead	= sndStreetLightBreak;
		 // Vars:
		maxhealth	= 4;
		my_health	= maxhealth;
		team		= 0;
		
		return self;
	}
	
#define DevCone_create(_x, _y)
	with(instance_create(_x, _y, CustomProp)){
		
		 // Visual:
		spr_idle	= global.sprDevcone;
		spr_hurt	= global.sprDevconeHurt;
		spr_dead	= global.sprDevconeDead;
		 // Sounds:
		snd_hurt	= sndHitMetal;
		snd_dead	= sndStreetLightBreak;
		 // Vars:
		maxhealth	= 4;
		my_health	= maxhealth;
		team		= 0;
		
		return self;
	}
	
#define DevLight_create(_x, _y)
	with(instance_create(_x, _y, CustomProp)){
		
		 // Visual:
		spr_idle	= global.sprDevLight;
		spr_hurt	= global.sprDevLightHurt;
		spr_dead	= global.sprDevLightDead;
		mask_index	= mskStreetLight;
		spr_shadow	= shd32;	
		spr_shadow_y = 1;
		depth		= -7;
		 // Sounds:
		snd_hurt	= sndHitMetal;
		snd_dead	= sndStreetLightBreak;
		 // Vars:
		maxhealth	= 4;
		my_health	= maxhealth;
		team		= 0;
		
		return self;
	}
	
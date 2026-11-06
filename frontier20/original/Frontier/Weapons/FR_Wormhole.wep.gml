#define init

     // Sprites:
    global.sprWeapon 	        =[
    								sprite_add_weapon("../Sprites/Weapons/sprUnstableWormholeInactive.png", 	10, 13),
    								sprite_add_weapon("../Sprites/Weapons/sprUnstableWormholeBullet.png",		10, 13),
    								sprite_add_weapon("../Sprites/Weapons/sprUnstableWormholeShell.png",		10, 13),
    								sprite_add_weapon("../Sprites/Weapons/sprUnstableWormholeBolt.png", 		10, 13),
    								sprite_add_weapon("../Sprites/Weapons/sprUnstableWormholeExplosive.png",	10, 13),
    								sprite_add_weapon("../Sprites/Weapons/sprUnstableWormholeEnergy.png",		10, 13)
    							];
    global.sprWormholeBall			= sprite_add("../Sprites/Weapons/sprUnstableWormholeBall.png",				5, 6, 6);
    global.sprWormholeSpark			= sprite_add("../Sprites/Particles/sprWormholeSpark.png",					3, 5, 2);
    
    global.knownMods				= [];
    
    WormholeList_init();
    
#define weapon_name         return "UNSTABLE WORMHOLE";          
#define weapon_text         return "WHAT'S HAPPENING";
#define weapon_sprt(_wep)   return !is_object(_wep) ? global.sprWeapon[0] : global.sprWeapon[_wep.spriteIndex];
#define weapon_type(_wep)   
	if(is_object(_wep)){
		return _wep.wormholeType;
	} else {
		return 1;
	}
	
#define weapon_melee        		return false;
#define weapon_area         		return (mod_variable_get("mod", "Frontier_Projectiles", "settingNaturalLabsWeps") = true) ? 20 : -1;
#define weapon_auto         		return true;
#define weapon_load         		return 38;
#define weapon_cost(_wep)         	return !is_object(_wep) ? 8 : _wep.ammoCost;
#define weapon_swap         		
									sound_play_pitchvol(sndNothing2Ball, 0.9 + random(0.1), 0.6);
									return sndSwapMotorized;
#define weapon_handy				return true;
#define weapon_handy_data			return	{ x : -1, y : 4, bhand : true, bx : 8, by : 5 }

#define weapon_reloaded
	wkick += 3;

#define weapon_fire(_wep)
	
     // FireCont Support:
	var c = ((instance_is(self, FireCont) && "creator" in self) ? creator : self);

     // Sounds:
	sound_play_pitchvol(sndNothing2Beam,		1.2 + random(0.3), 0.75);
	sound_play_pitchvol(sndSuperFlakCannon,	    1.2 + random(0.3), 1);
	
	var _bonus = (random(5) < 1) ? true : false;
	repeat(1 + _bonus){
		switch(_wep.wormholeSpawnType){
			case "Basegame":
				repeat(irandom_range(_wep.wormholeProjectileMin, _wep.wormholeProjectileMax)){
					with(instance_create(x, y, _wep.wormholeSpawnObject)){
						direction		= other.gunangle + (random_range(-_wep.wormholeProjectileSpread, _wep.wormholeProjectileSpread) * other.accuracy);
						image_angle     = direction;
						team            = other.team;
						creator         = other;		
						speed			= random_range(_wep.wormholeProjectileSpeedMin, _wep.wormholeProjectileSpeedMax)
					}
				}		
			break;
			case "Mod":
				repeat(irandom_range(_wep.wormholeProjectileMin, _wep.wormholeProjectileMax)){
					with(mod_script_call("mod", _wep.wormholeSpawnMod, _wep.wormholeSpawnObject, x, y)){
						direction		= other.gunangle + (random_range(-_wep.wormholeProjectileSpread, _wep.wormholeProjectileSpread) * other.accuracy);
						image_angle     = direction;
						team            = other.team;
						creator         = other;		
						speed			= random_range(_wep.wormholeProjectileSpeedMin, _wep.wormholeProjectileSpeedMax)
					}
				}		
			break;
			case "OBJ":
				repeat(irandom_range(_wep.wormholeProjectileMin, _wep.wormholeProjectileMax)){
					with(mod_script_call("mod", _wep.wormholeSpawnMod, "obj_create", x, y, _wep.wormholeSpawnObject)){
						direction		= other.gunangle + (random_range(-_wep.wormholeProjectileSpread, _wep.wormholeProjectileSpread) * other.accuracy);
						image_angle     = direction;
						team            = other.team;
						creator         = other;		
						speed			= random_range(_wep.wormholeProjectileSpeedMin, _wep.wormholeProjectileSpeedMax)
					}
				}		
			break;
		}
		if(_bonus){
			wormhole_next_projectile(_wep, false);
		}
	}

	
	/*
     // Projectiles:
	with(mod_script_call("mod", "Frontier_Projectiles", "HeavyBlunderball_create", x, y)){
		direction		= other.gunangle + (random_range(-3, 3) * other.accuracy);
		image_angle     = direction;
		team            = other.team;
		creator         = other;
	}
	*/
	
     // Kick, Shift, Shake:
    weapon_post(10, 2, 2);
    motion_add(gunangle + 180, 1)
   
	 // Dust:
	repeat(6){
		with(instance_create(x, y, Dust)){
			direction	= other.gunangle + random_range(-45, 45);
			speed		= 3 + random(2);
			image_blend	= c_black;
		}
	}
	repeat(8){
		with(instance_create(x, y, Dust)){
			direction	= other.gunangle + random_range(-25, 25);
			speed		= 5 + random(4);
			image_blend	= c_black;
		}
	}
	
	with(instances_matching(CustomObject, "fr_wormball", other)){
		instance_destroy();
	}
	
   wormhole_next_projectile(_wep, true);
   
#define wormhole_next_projectile(_wep, _switchAmmo)
		 // Switch Ammo:
	if(_switchAmmo){
	    if(_wep.wormholeType < 5){
			_wep.wormholeType += 1;
		} else {
			_wep.wormholeType = 1;
		}
	}
	
	_wep.spriteIndex = _wep.wormholeType;
	
	var _ammoCosts		= [1, 32, 8, 7, 6, 10];
	_wep.ammoCost		= _ammoCosts[_wep.wormholeType]
	
	var _listList	= [global.typelessWormholeList, global.bulletWormholeList, global.shellWormholeList, global.boltWormholeList, global.explosiveWormholeList, global.energyWormholeList],
		_list		= _listList[_wep.wormholeType];
		
		ds_list_shuffle(_list);
		
		var _projectile = ds_list_find_value(_list, 0);
		
		_wep.wormholeSpawnObject		= _projectile[0];
		_wep.wormholeSpawnType			= _projectile[1];
		_wep.wormholeSpawnMod			= _projectile[2];
		_wep.wormholeProjectileMin		= _projectile[3];
		_wep.wormholeProjectileMax		= _projectile[4];
		_wep.wormholeProjectileSpread	= _projectile[5];
		_wep.wormholeProjectileSpeedMin	= _projectile[6];
		_wep.wormholeProjectileSpeedMax	= _projectile[7];

#define step
    var _wep = (argument0 ? wep : bwep);
	if(!is_object(_wep)){
		lwo_initialize(_wep); 
		exit;
	};
	
	if(other.wep = _wep || other.race = "steroids"){
		if(other.reload <= 0) && (other.ammo[_wep.wormholeType] >= _wep.ammoCost){
			if(array_length(instances_matching(CustomObject, "fr_wormball", other)) = 0){
				with(other){
					WormholeBall_create(x, y, self, _wep.spriteIndex - 1, _wep);
					sound_play_pitchvol(sndPlasma, 0.4 + random(0.3), 0.6);
				}
			}
		}
	}
	
#define lwo_initialize(_wep)
		// yeah
	var _creator = ((instance_is(self, FireCont) && "creator" in self) ? creator : self);
	_wep = { 
		"wep"							: _wep, 
		"wormholeType"					: irandom_range(1, 5),
		"wormholeSpawnObject"			: 0,
		"wormholeSpawnType"				: 0,
		"wormholeSpawnMod"				: 0,
		"wormholeProjectileMin"			: 0,
		"wormholeProjectileMax"			: 0,
		"wormholeProjectileSpread"		: 0,
		"wormholeProjectileSpeedMin"	: 0,
		"wormholeProjectileSpeedMax"	: 0,
		"spriteIndex"					: 0,
		"ammoCost"						: 1,
	};
	
	wormhole_next_projectile(_wep, true)
	
	 // Tutorial Text:
//	mod_script_call("mod", "Frontier_Projectiles", "weapon_tutorial_text", x, y, "blunderboulder");
	
	if("wep" in _creator && _creator.wep == _wep.wep){
		_creator.wep = _wep;
	}
	if("bwep" in _creator && _creator.bwep == _wep.wep){
		_creator.bwep = lq_clone(_wep);
	}
	
#define WormholeProjectile_add(_spawnObject, _spawnType, _spawnMod, _ammoType, _projectileMin, _projectileMax, _projectileSpread, _projectileSpeedMin, _projectileSpeedMax)
	var _listList	= [global.typelessWormholeList, global.bulletWormholeList, global.shellWormholeList, global.boltWormholeList, global.explosiveWormholeList, global.energyWormholeList],
		_list		= _listList[_ammoType];
	ds_list_add(_list, [
		_spawnObject,
		_spawnType,
		_spawnMod,
		_projectileMin,
		_projectileMax,
		_projectileSpread,
		_projectileSpeedMin,
		_projectileSpeedMax
	]);
	
	
#define WormholeList_init
	global.typelessWormholeList		= ds_list_create();
	global.bulletWormholeList		= ds_list_create();
	global.shellWormholeList		= ds_list_create();
	global.boltWormholeList			= ds_list_create();
	global.explosiveWormholeList	= ds_list_create();
	global.energyWormholeList		= ds_list_create();
	
	 // Bullet:
	WormholeProjectile_add(Bullet1, 		"Basegame", undefined, 1, 45, 60, 20, 11, 18);
	WormholeProjectile_add(HeavyBullet, 	"Basegame", undefined, 1, 18, 30, 15, 11, 18);
	WormholeProjectile_add(BouncerBullet, 	"Basegame", undefined, 1, 16, 46, 32, 6, 10);
	WormholeProjectile_add(UltraBullet, 	"Basegame", undefined, 1, 16, 24, 12, 14, 18);
	
	WormholeProjectile_add("FlameBullet_create", 		"Mod", "Frontier_Projectiles", 1, 16, 24, 20, 12, 18);	
	WormholeProjectile_add("TeleBullet_create", 		"Mod", "Frontier_Projectiles2", 1, 10, 20, 26, 10, 16);	
	
	 // Shell:
	WormholeProjectile_add(Bullet2, 		"Basegame", undefined, 2, 26, 48, 25, 12, 17);
	WormholeProjectile_add(FlameShell,		"Basegame", undefined, 2, 24, 40, 18, 12, 17);
	WormholeProjectile_add(Slug,			"Basegame", undefined, 2, 14, 32, 18, 12, 17);
	WormholeProjectile_add(HeavySlug,		"Basegame", undefined, 2, 5, 12, 16, 12, 17);
	WormholeProjectile_add(HyperSlug,		"Basegame", undefined, 2, 7, 15, 20, 12, 17);
	WormholeProjectile_add(FlakBullet,		"Basegame", undefined, 2, 3, 8, 16, 12, 17);
	WormholeProjectile_add(SuperFlakBullet,	"Basegame", undefined, 2, 2, 6, 22, 12, 17);
	
	WormholeProjectile_add("Grapeshot_create", 			"Mod", "Frontier_Projectiles", 2, 20, 48, 20, 10, 18);	
	WormholeProjectile_add("InkBigFlak_create", 		"Mod", "Frontier_Projectiles", 2, 2, 5, 20, 10, 16);	
	WormholeProjectile_add("GluonSlug_create", 			"Mod", "Frontier_Projectiles2", 2, 1, 4, 20, 8, 11);	
	
	 // Bolt:
	WormholeProjectile_add(Bolt,			"Basegame", undefined, 3, 8, 14, 20, 16, 20);
	WormholeProjectile_add(HeavyBolt,		"Basegame", undefined, 3, 4, 14, 14, 16, 20);
	WormholeProjectile_add(Splinter,		"Basegame", undefined, 3, 12, 40, 35, 12, 20);
	WormholeProjectile_add(Disc,			"Basegame", undefined, 3, 12, 40, 14, 4, 9);
	WormholeProjectile_add(Seeker,			"Basegame", undefined, 3, 12, 20, 18, 6, 9);
	WormholeProjectile_add(ToxicBolt,		"Basegame", undefined, 3, 4, 16, 18, 14, 20);
	WormholeProjectile_add(UltraBolt,		"Basegame", undefined, 3, 3, 14, 12, 16, 20);
	
	WormholeProjectile_add("BallistaBolt_create", 		"Mod", "Frontier_Projectiles", 3, 3, 10, 14, 14, 20);	
	WormholeProjectile_add("Sawblade_create", 			"Mod", "Frontier_Projectiles", 3, 5, 20, 20, 7, 12);	
	WormholeProjectile_add("PlagueBolt_create", 		"Mod", "Frontier_Projectiles2", 3, 1, 3, 24, 15, 17);	
	
	 // Explosive:
	WormholeProjectile_add(Grenade, 		"Basegame", undefined, 4, 8, 20, 15, 8, 12);
	WormholeProjectile_add(HeavyNade, 		"Basegame", undefined, 4, 6, 18, 15, 8, 12);
	WormholeProjectile_add(BloodGrenade, 	"Basegame", undefined, 4, 8, 20, 15, 6, 12);
	WormholeProjectile_add(BloodBall, 		"Basegame", undefined, 4, 2, 7, 15, 6, 12);
	WormholeProjectile_add(Flare, 			"Basegame", undefined, 4, 4, 8, 22, 8, 14);
	WormholeProjectile_add(ClusterNade, 	"Basegame", undefined, 4, 5, 15, 20, 10, 14);
	WormholeProjectile_add(MiniNade, 		"Basegame", undefined, 4, 12, 46, 24, 10, 16);
	WormholeProjectile_add(FlameBall,		"Basegame", undefined, 4, 3, 9, 22, 5, 10);
	WormholeProjectile_add(ToxicGrenade, 	"Basegame", undefined, 4, 8, 20, 24, 12, 18);
	WormholeProjectile_add(Nuke, 			"Basegame", undefined, 4, 1, 12, 7, 6, 10);
	WormholeProjectile_add(UltraGrenade, 	"Basegame", undefined, 4, 2, 8, 20, 12, 18);
	WormholeProjectile_add(Flame, 			"Basegame", undefined, 4, 64, 100, 22, 6, 18);
	
	WormholeProjectile_add("FlameRocket_create", 			"Mod", "Frontier_Projectiles", 4, 3, 9, 26, 2, 6);	
	WormholeProjectile_add("Blunderball_create", 			"Mod", "Frontier_Projectiles", 4, 3, 12, 18, 14, 20);
	WormholeProjectile_add("HeavyBlunderball_create", 		"Mod", "Frontier_Projectiles", 4, 3, 8, 16, 14, 20);
	WormholeProjectile_add("HiveRocket_create", 			"Mod", "Frontier_Projectiles2", 4, 2, 7, 16, 2, 6);
	WormholeProjectile_add("FireworkCandle_create", 		"Mod", "Frontier_Projectiles", 4, 3, 11, 26, 13, 18);
	WormholeProjectile_add("FireworkRocket_create", 		"Mod", "Frontier_Projectiles", 4, 1, 3, 26, 14, 17);
	
	 // Energy
	WormholeProjectile_add(PlasmaBall,		"Basegame", undefined, 5, 8, 16, 7, 8, 8);
	WormholeProjectile_add(PlasmaBig,		"Basegame", undefined, 5, 3, 5, 16, 8, 8);
	WormholeProjectile_add(PlasmaHuge,		"Basegame", undefined, 5, 1, 3, 14, 8, 8);
	WormholeProjectile_add(LightningBall,	"Basegame", undefined, 5, 3, 8, 14, 4, 10);
	WormholeProjectile_add(LaserCannon,		"Basegame", undefined, 5, 2, 4, 20, 0, 0);
	WormholeProjectile_add(Devastator,		"Basegame", undefined, 5, 2, 5, 26, 6, 12);
	
	WormholeProjectile_add("EnergyPellet_create", 			"Mod", "Frontier_Projectiles2", 5, 4, 12, 16, 5, 10);
	WormholeProjectile_add("StarBullet_create", 			"Mod", "Frontier_Projectiles", 5, 10, 32, 24, 9, 15);
	
	
	 // NT:TE Projectiles:
	if(mod_exists("mod", "ntte")){

		 // Bolt:
		WormholeProjectile_add("BoneArrow", 				"OBJ", "telib", 3, 6, 13, 14, 14, 20);	
		WormholeProjectile_add("BatDisc", 					"OBJ", "telib", 3, 6, 13, 14, 8, 14);	
		
		 // Explo:
		WormholeProjectile_add("BubbleBomb", 				"OBJ", "telib", 4, 8, 16, 14, 4, 9);
		
		 // Energy:
		WormholeProjectile_add("ElectroPlasma", 			"OBJ", "telib", 5, 7, 12, 14, 4, 9);
		WormholeProjectile_add("QuasarBeam", 				"OBJ", "telib", 5, 2, 5, 14, 0, 0);
		WormholeProjectile_add("LightningDisc", 			"OBJ", "telib", 5, 5, 12, 14, 6, 14);	
	}
	
	 // Defpack Projectiles:
	if(mod_exists("mod", "defpack tools")){
		
		 // Bullet:
		WormholeProjectile_add("create_light_bullet", 			"Mod", "defpack tools", 1, 10, 24, 24, 14, 22);
		
		 // Shell:
		WormholeProjectile_add("create_split_shell", 			"Mod", "defpack tools", 2, 10, 24, 32, 8, 16);
		WormholeProjectile_add("create_burster", 				"Mod", "defpack tools", 2, 10, 24, 32, 8, 16);
		
		 // Bolt:
		WormholeProjectile_add("create_stickydisc", 			"Mod", "defpack tools", 3, 2, 12, 20, 3, 6);
		WormholeProjectile_add("create_megadisc", 				"Mod", "defpack tools", 3, 1, 6, 20, 3, 6);
		WormholeProjectile_add("create_shuriken", 				"Mod", "defpack tools", 3, 4, 12, 24, 12, 22);
		WormholeProjectile_add("create_knife", 					"Mod", "defpack tools", 3, 4, 12, 24, 12, 22);
		WormholeProjectile_add("create_bouncerdisc", 			"Mod", "defpack tools", 3, 4, 12, 24, 3, 6);
		
		 // Energy:
		WormholeProjectile_add("create_vector", 				"Mod", "defpack tools", 5, 2, 5, 40, 9, 14);
		
	}

	 // Varia Projectiles:
	if(mod_exists("mod", "va_weptools")){
		
		 // Bullet:
		WormholeProjectile_add("ribbonBullet_create", 			"Mod", "va_weptools", 1, 12, 30, 24, 14, 20);
		WormholeProjectile_add("gluonBullet_create", 			"Mod", "va_weptools", 1, 12, 30, 24, 14, 20);
		
		 // Shell:
		WormholeProjectile_add("pierceShell_create", 			"Mod", "va_weptools", 2, 16, 32, 48, 11, 20);
		WormholeProjectile_add("toxicPierceShell_create", 		"Mod", "va_weptools", 2, 16, 32, 24, 11, 20);
		WormholeProjectile_add("pinFlak_create", 				"Mod", "va_weptools", 2, 4, 7, 32, 11, 18);
		WormholeProjectile_add("dusterFlak_create", 			"Mod", "va_weptools", 2, 4, 7, 32, 11, 18);
		WormholeProjectile_add("superDusterFlak_create", 		"Mod", "va_weptools", 2, 2, 5, 24, 11, 18);
		WormholeProjectile_add("superPinFlak_create", 			"Mod", "va_weptools", 2, 2, 5, 24, 11, 18);
		
		 // Bolt:
		WormholeProjectile_add("digsaw_create", 				"Mod", "va_weptools", 3, 4, 12, 24, 6, 12);
		WormholeProjectile_add("smartsaw_create", 				"Mod", "va_weptools", 3, 4, 12, 24, 6, 12);
		WormholeProjectile_add("bigsaw_create", 				"Mod", "va_weptools", 3, 2, 5,  42, 1, 3);
		WormholeProjectile_add("bigbrainsaw_create", 			"Mod", "va_weptools", 3, 1, 4,  42, 2, 4);
		
		 // Explo:
		WormholeProjectile_add("breachGrenade_create",			"Mod", "va_weptools", 4, 4, 12, 30, 17, 23);
		WormholeProjectile_add("toxicBreachGrenade_create", 	"Mod", "va_weptools", 4, 4, 12, 30, 17, 23);
		WormholeProjectile_add("heavyBreachGrenade_create",		"Mod", "va_weptools", 4, 2, 4, 16, 7, 11);
		WormholeProjectile_add("breakerGrenade_create",			"Mod", "va_weptools", 4, 2, 4, 16, 16, 19);
		
		
		 // Energy:
		WormholeProjectile_add("qube_create", 					"Mod", "va_weptools", 5, 3, 6, 20, 2, 5);
		WormholeProjectile_add("superQube_create", 				"Mod", "va_weptools", 5, 1, 3, 20, 3, 6);
	}
	
	
#define wep_raw(_wep)
	/*
		For use with LWO weapons
		Calls a weapon's "weapon_raw" script in case of wrapper weapons
		
		Ex:
			wep_raw({ wep:{ wep:{ wep:123 }}}) == 123
	*/
	
	var _rawWep = _wep;
	
	 // Find Base Weapon:
	while(is_object(_rawWep)){
		_rawWep = (("wep" in _rawWep) ? _rawWep.wep : wep_none);
	}
	
	 // Wrapper:
	if(is_string(_rawWep) && mod_script_exists("weapon", _rawWep, "weapon_raw")){
		_rawWep = mod_script_call("weapon", _rawWep, "weapon_raw", _wep);
	}
	
	return _rawWep;
	
    
#define WormholeBall_create(_x, _y, _creator, _index, _wep)
	with(instance_create(_x, _y, CustomObject)){
		name = "fr_wormholeBall";
		
		sprite_index	= global.sprWormholeBall;
		image_speed		= 0;
		image_index		= _index;
		creator 		= _creator;
		fr_wormball		= creator;
		depth			= -1;
		fr_bloom		= [1.6, 0.1];
		weapong 		= _wep;
		distance		= -24;
		grown			= false;
		image_xscale	= 0;
		image_yscale	= image_xscale;

		x = creator.x - lengthdir_x(distance + creator.wkick, creator.gunangle) + random_range(-1, 1);
		y = creator.y - lengthdir_y(distance + creator.wkick, creator.gunangle) + random_range(-1, 1);
		
		on_end_step 		= WormholeBall_endstep;
		
		repeat(6){
			with(instance_create(x, y, PlasmaTrail)){
				sprite_index	= global.sprWormholeSpark;
				direction		= random(360);
				image_angle		= direction;
				speed			= 1 + random(2);
				image_index		= choose(0, 1);
			}
		}
		
		return self;
	}
	
#define WormholeBall_endstep
	if(!instance_exists(creator) || creator.wep != weapong){
		instance_destroy();
		exit;
	}
	
	if(grown = false){
		if(image_xscale < 1){
			image_xscale += 0.1 * current_time_scale;
		} else {
			grown = true;
		}
	} else {
		image_xscale	= 1 + random_range(-0.15, 0.15);
	}
	image_yscale	= image_xscale;
	
	x = creator.x - lengthdir_x(distance + creator.wkick, creator.gunangle) + random_range(-1, 1);
	y = creator.y - lengthdir_y(distance + creator.wkick, creator.gunangle) + random_range(-1, 1);
	
	if(random(10) < 1){
		with(instance_create(x, y, PlasmaTrail)){
			sprite_index	= global.sprWormholeSpark;
			direction		= random(360);
			image_angle		= direction;
			speed			= 1 + random(2);
			image_index		= choose(0, 1);
		}
	}
	
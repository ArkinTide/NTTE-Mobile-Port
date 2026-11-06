#define init

	 // Sprites:
	global.sprSkillIcon 					= sprite_add("../sprites/mutations/sprAugmentLaserBrain.png", 1, 12, 16);
	global.sprSkillHud  					= sprite_add("../sprites/mutations/sprAugmentLaserBrainIcon.png", 1, 8, 8);

	global.spritesReplaced					= false;
	global.settingAugmentProjectiles		= true;
	global.settingGreenAugments				= false;
	
	 // Defpack:
	global.sprPopoBeam						= sprite_add("../sprites/projectiles/popoenergy/sprPopoBeam.png",				1, 0, 10);
	global.sprPopoBeamCharge				= sprite_add("../sprites/projectiles/popoenergy/sprPopoBeamCharge.png", 		1, 16, 16);
	global.sprPopoBeamStart					= sprite_add("../sprites/projectiles/popoenergy/sprPopoBeamStart.png",			1, 12, 10);	
	global.sprPopoBeamEnd					= sprite_add("../sprites/projectiles/popoenergy/sprPopoBeamEnd.png",			1, 10, 12);
	global.sprPopoLaserFlak					= sprite_add("../sprites/projectiles/popoenergy/sprPopoLaserFlak.png",			2, 8, 8);
	global.sprPopoPlasmaImpactSmallDefpack	= sprite_add("../sprites/projectiles/popoenergy/sprPopoPlasmaImpactSmallDefpack.png",	7, 8, 8);
	global.sprPopoPlasmite					= sprite_add("../sprites/projectiles/popoenergy/sprPopoPlasmite.png",			1, 3, 3);
	global.sprPopoPlasmiteUpg				= sprite_add("../sprites/projectiles/popoenergy/sprPopoPlasmiteUpg.png",		1, 3, 3);
	global.sprPopoPlasmiteBig				= sprite_add("../sprites/projectiles/popoenergy/sprPopoPlasmiteBig.png",		2, 9, 9);
	global.sprPopoEShank					= sprite_add("../sprites/projectiles/popoenergy/sprPopoEShank.png",				4, -6, 4);
	global.sprPopoSonicExplosion			= sprite_add("../sprites/projectiles/popoenergy/sprPopoESonicExplosion.png",	8, 59, 56);
	global.sprPopoEnergyEffect				= sprite_add("../sprites/projectiles/popoenergy/sprPopoEnergyEffect.png",		6, 7, 7);
	global.sprPopoPSD						= sprite_add("../sprites/weapons/popovariants/sprPopoPSD.png",					7, 1, 2);
	global.sprPopoEnergyChainsaw			= sprite_add("../sprites/weapons/popovariants/sprPopoEnergyChainsaw.png",		7, 3, 4);
	global.sprPopoEnergyChainsawActive		= sprite_add_weapon("../sprites/weapons/popovariants/sprPopoEnergyChainsawActive.png",	3, 4);
	
	 // NT:TE:
	global.sprPopoAllyLaserCharge			= sprite_add("../sprites/projectiles/popoenergy/sprPopoAllyLaserCharge.png",	4, 3, 3);
	global.sprPopoEnergyBatSlash			= sprite_add("../sprites/projectiles/popoenergy/sprPopoEnergyBatSlash.png",		3, 0, 24);
	global.sprPopoVlasmaBullet				= sprite_add("../sprites/projectiles/popoenergy/sprPopoVlasmaBullet.png",		5, 8, 8);
	global.sprPopoVlasmaCannon				= sprite_add("../sprites/projectiles/popoenergy/sprPopoVlasmaCannon.png",		5, 10, 10);
	global.sprPopoPlasmaImpactSmall			= sprite_add("../sprites/projectiles/popoenergy/sprPopoPlasmaImpactSmall.png",	7, 8, 8);
	global.sprPopoEnergyBat					= sprite_add("../sprites/weapons/popovariants/sprPopoEnergyBat.png",			7, 0, 4);
	 
	 // FLV:
	global.sprPopoEnergyShovel				= sprite_add("../sprites/weapons/popovariants/sprPopoEnergyShovel.png",			7, 5, 7);
	
	 // need to define these as globals to replace WO sprites
	global.sprPopoEnergySword				= sprite_add("../sprites/weapons/popovariants/sprPopoEnergySword.png",			7, 2, 1);
	global.sprPopoEnergyScrewdriver			= sprite_add("../sprites/weapons/popovariants/sprPopoEnergyScrewdriver.png",	7, -2, 2);
	global.sprPopoEnergyHammer				= sprite_add("../sprites/weapons/popovariants/sprPopoEnergyHammer.png",			7, 5, 5);
	
	#macro refundChance						2.5 // 1 in x chance
	#macro reloadBuff						0.6 // reload decreased per frame
	
	AugmentLaserBrain_spriteinit();
	game_start();

#define AugmentLaserBrain_spriteinit
	var _path		= "../sprites/projectiles/popoenergy/",
		_weppath	= "../sprites/weapons/popovariants/";
	global.augmentBaseSprites = [
		[sprLaserBrain,		`${_path}sprPopoLaserBrain.png`,			7, -3, 8],
		[sprLaser,			`${_path}sprPopoLaser.png`,					1, 2, 3],
		[sprLaserStart,		`${_path}sprPopoLaserStart.png`,			8, 8, 6],
		[sprLaserEnd,		`${_path}sprPopoLaserEnd.png`,				8, 10, 8],
		[sprPlasmaBall,		`${_path}sprPopoPlasmaBall.png`,			2, 12, 12],
		[sprPlasmaBallBig,	`${_path}sprPopoPlasmaBallBig.png`,			2, 16, 16],
		[sprPlasmaBallHuge,	`${_path}sprPopoPlasmaBallHuge.png`,		2, 24, 24],
		[sprPlasmaImpact,	`${_path}sprPopoPlasmaImpact.png`,			7, 16, 16],
		[sprPlasmaTrail,	`${_path}sprPopoPlasmaTrail.png`,			3, 4, 4],
		[sprEnergyShank,		`${_path}sprPopoEnergyShank.png`,		2, -5, 8],
		[sprEnergySlash,		`${_path}sprPopoEnergySlash.png`,		3, -8, 24],
		[sprHeavyEnergySlash,	`${_path}sprPopoHeavyEnergySlash.png`,	3, -8, 24],
		[sprGunGunFire,			`${_path}sprPopoGunGunFire.png`,		12, 8, 8],
		
		[sprEnergySword,		`${_weppath}sprPopoEnergySword.png`,		7, 2, 1],
		[sprEnergyScrewDriver,	`${_weppath}sprPopoEnergyScrewdriver.png`,	7, -2, 2],
		[sprEnergyHammer,		`${_weppath}sprPopoEnergyHammer.png`,		7, 5, 5],
	]
	
	global.augmentBaseSpritesRestore = [
		sprLaserBrain,
		sprLaser,
		sprLaserStart,
		sprLaserEnd,
		sprPlasmaBall,
		sprPlasmaBallBig,
		sprPlasmaBallHuge,
		sprPlasmaImpact,
		sprPlasmaTrail,
		sprEnergyShank,
		sprEnergySlash,
		sprHeavyEnergySlash,
		sprGunGunFire,
		
		sprEnergySword,
		sprEnergyScrewDriver,
		sprEnergyHammer,
	]
	
	global.augmentSpritesMods	= [];
	global.augmentSpriteStorage	= ds_list_create();
	global.augmentSprites		= ds_list_create();

//	AugmentLaserBrain_addsprite("mod", "Frontier_Projectiles", "sprGunpowderCreep",			global.sprPopoGunpowderCreep, 			global.sprGreenPopoGunpowderCreep);	

#define game_start

	 // Defpack Sprites:
	if(mod_exists("mod", "defpack tools")){
		var _knownIndex = 0;
		var _seeMe		= 0;
		var _sprPath	= mod_variable_get("mod", "defpack tools", "spr")
	    repeat(array_length(global.augmentSpritesMods)){
	        if(global.augmentSpritesMods[_knownIndex] = "defpack tools"){
	            _seeMe += 1;
	        }
	        _knownIndex += 1;
	    }
	    if(_seeMe <= 0){
	    	array_push(global.augmentSpritesMods, "defpack tools");
	    	with(_sprPath){
				AugmentLaserBrain_addsprite_ext("mod", "defpack tools", "spr", LaserFlakBullet, "LaserFlakBullet",			global.sprPopoLaserFlak);
				AugmentLaserBrain_addsprite_ext("mod", "defpack tools", "spr", PlasmaImpactSmall, "PlasmaImpactSmall",		global.sprPopoPlasmaImpactSmallDefpack);	 
				AugmentLaserBrain_addsprite_ext("mod", "defpack tools", "spr", Plasmite, "Plasmite",						global.sprPopoPlasmite);	 
				AugmentLaserBrain_addsprite_ext("mod", "defpack tools", "spr", PlasmiteUpg, "PlasmiteUpg",					global.sprPopoPlasmiteUpg);	 
	    	}
	    	AugmentLaserBrain_addsprite("weapon", "mega laser cannon",	"sprBeam",			global.sprPopoBeam);	
	    	AugmentLaserBrain_addsprite("weapon", "mega laser cannon",	"sprBeamCharge",	global.sprPopoBeamCharge);	
	    	AugmentLaserBrain_addsprite("weapon", "mega laser cannon",	"sprBeamStart",		global.sprPopoBeamStart);	
	    	AugmentLaserBrain_addsprite("weapon", "mega laser cannon",	"sprBeamEnd",		global.sprPopoBeamEnd);	
	    	AugmentLaserBrain_addsprite("weapon", "plasmite cannon",	"sprPlasmiteBig",	global.sprPopoPlasmiteBig);	
	    	AugmentLaserBrain_addsprite("weapon", "energy chainsaw",	"sprChainsawShank",	global.sprPopoEShank);	
	    	AugmentLaserBrain_addsprite("weapon", "psd",				"sprSonicExplosion",global.sprPopoSonicExplosion);	
	    	AugmentLaserBrain_addsprite("weapon", "psd",				"sprEnergyEffect",	global.sprPopoEnergyEffect);
	    	
	    	AugmentLaserBrain_addsprite("weapon", "psd",				"sprEnergyDevice",	global.sprPopoPSD);
	    	AugmentLaserBrain_addsprite("weapon", "energy chainsaw",	"sprChainsaw",		global.sprPopoEnergyChainsaw);
	    	AugmentLaserBrain_addsprite("weapon", "energy chainsaw",	"sprChainsawActive",global.sprPopoEnergyChainsawActive);
	    }
	}
	
	 // NT:TE
	if(mod_exists("mod", "teassets")){
		var _knownIndex = 0;
		var _seeMe		= 0;
		var _sprPath	= mod_variable_get("mod", "teassets", "spr")
	    repeat(array_length(global.augmentSpritesMods)){
	        if(global.augmentSpritesMods[_knownIndex] = "teassets"){
	            _seeMe += 1;
	        }
	        _knownIndex += 1;
	    }
	    if(_seeMe <= 0){
	    	array_push(global.augmentSpritesMods, "teassets");
	    	with(_sprPath){
	    		AugmentLaserBrain_addsprite_ext("mod", "teassets", "spr", AllyLaserCharge, "AllyLaserCharge",		global.sprPopoAllyLaserCharge);
				AugmentLaserBrain_addsprite_ext("mod", "teassets", "spr", EnergyBatSlash, "EnergyBatSlash",			global.sprPopoEnergyBatSlash);
				AugmentLaserBrain_addsprite_ext("mod", "teassets", "spr", VlasmaBullet, "VlasmaBullet",				global.sprPopoVlasmaBullet);
				AugmentLaserBrain_addsprite_ext("mod", "teassets", "spr", VlasmaCannon, "VlasmaCannon",				global.sprPopoVlasmaCannon);
				AugmentLaserBrain_addsprite_ext("mod", "teassets", "spr", PlasmaImpactSmall, "PlasmaImpactSmall",	global.sprPopoPlasmaImpactSmall);
	    	}
	    	AugmentLaserBrain_addsprite("weapon", "energy bat",	"sprWep",		global.sprPopoEnergyBat);	
	    }
	}
	
	 // FLV
	if(mod_exists("weapon", "energy_shovel")){
		var _knownIndex = 0;
		var _seeMe		= 0;
	    repeat(array_length(global.augmentSpritesMods)){
	        if(global.augmentSpritesMods[_knownIndex] = "energy_shovel"){
	            _seeMe += 1;
	        }
	        _knownIndex += 1;
	    }
	    if(_seeMe <= 0){
	    	array_push(global.augmentSpritesMods, "energy_shovel");
	    	AugmentLaserBrain_addsprite("weapon", "energy_shovel",	"sprite", global.sprPopoEnergyShovel);	
	    }
	}
	
	 // Restore Sprites on run restart:
	if(global.spritesReplaced = true && !skill_get(mod_current)){
		wait(1); // doesnt work without it. I dont know why. It should be ok to put this wait here
		AugmentLaserBrain_restoresprite();
		exit;
	}

#define load_options(_options)

	var _prevSettingProjectiles			= global.settingAugmentProjectiles,
		_prevSettingGreen				= global.settingGreenAugments;
	
	global.settingAugmentProjectiles	= _options.settingAugmentProjectiles;
	global.settingGreenAugments			= _options.settingGreenAugments;
	
	 // Update Sprites on setting changes:
	if(skill_get(mod_current)){
		if(global.spritesReplaced = true && global.settingAugmentProjectiles = false){
			AugmentLaserBrain_restoresprite();
		}
		if(global.spritesReplaced = true && global.settingAugmentProjectiles != _prevSettingProjectiles){
			AugmentLaserBrain_resprite();
		}
		if(global.spritesReplaced = true && global.settingAugmentProjectiles != _prevSettingGreen){
			AugmentLaserBrain_restoresprite();
			AugmentLaserBrain_resprite();
		}
	}
	
#define skill_name			return loc("Frontier:AugmentLaserBrain:0", "PORTABLE FUSION REACTOR");
#define skill_text			return loc("Frontier:AugmentLaserBrain:1", "@wENERGY WEAPONS @(color:16776960)RELOAD FASTER#@sAND OFTEN @(color:16776960)REFUND @yAMMO");
#define skill_tip			return "DONT DROP IT";
#define skill_button		sprite_index = global.sprSkillIcon;
#define skill_icon			return global.sprSkillHud;
#define skill_avail			return (mod_variable_get("mod", "Frontier_IDPD", "settingMainPoolAugments") = true) ? 1 : 0;
#define skill_wepspec		return 0;
#define skill_sacrifice		return false;
#define skill_augment		return mut_laser_brain; 
	
#define cleanup
	if(global.spritesReplaced = true){
		AugmentLaserBrain_restoresprite();
	}
	
#define skill_take
	if(global.settingAugmentProjectiles = true){
		if(global.settingGreenAugments = false){
			AugmentLaserBrain_resprite();
			
			with(instances_matching(WepPickup, "wep", wep_energy_sword, wep_energy_screwdriver, wep_energy_hammer, "energy chainsaw", "psd", "energy_shovel")){
				with(instance_create(x, y, ImpactWrists)){
					image_blend	= make_colour_rgb(0, 255, 255);
				}				
			}
		}
	}
	
#define skill_lose
	with(instances_matching(CustomObject, "name", "fr_AugmentBoilingVeinsController")){
		instance_destroy();
	}
	AugmentLaserBrain_restoresprite();
	
#define step
	script_bind_end_step(AugmentLaserBrain_endstep, 0); // this was working with just having end_step defined at some point. I dont know why it was and why it stopped.
	
#define AugmentLaserBrain_endstep
	with(Player){
		if("fr_augmentLaserBrain_lastEnergy" not in self){
			fr_augmentLaserBrain_lastEnergy = ammo[5];
		}
		
		var _wep = wep_raw(wep);
		if(weapon_get_type(_wep) = 5){
			if(reload > 0){
				reload -= (reloadBuff * skill_get(mod_current));
			}
		}
		
		if(race = "steroids"){
			var _bwep = wep_raw(bwep);
			if(weapon_get_type(_bwep) = 5){
				if(breload > 0){
					breload -= (reloadBuff * skill_get(mod_current));
				}
			}			
		}
		
		if(ammo[5] != fr_augmentLaserBrain_lastEnergy){
			if(ammo[5] < fr_augmentLaserBrain_lastEnergy){
				if(random(refundChance) < 1){
					fusion_refund();
				}
			}
		}
		
		fr_augmentLaserBrain_lastEnergy = ammo[5];
	}
	
	instance_destroy();
	
#define fusion_refund
	ammo[5] = fr_augmentLaserBrain_lastEnergy;
	with(instance_create(x, y, LaserBrain)){
		creator = other;
	}
    
#define wep_raw(_wep) //thanks yokin!
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
    
#define AugmentLaserBrain_addsprite(_baseModType, _baseMod, _baseVar, _popospr)
	ds_list_add(global.augmentSpriteStorage, [[_baseModType, _baseMod, _baseVar, undefined, undefined], mod_variable_get(_baseModType, _baseMod, _baseVar)]);
	ds_list_add(global.augmentSprites, [[_baseModType, _baseMod, _baseVar, undefined, undefined], _popospr]);
	
#define AugmentLaserBrain_addsprite_ext(_baseModType, _baseMod, _spriteVar, _sprite, _spriteName, _popospr)
	 // Same as above but for use with mods like defpack and ntte that use .spr path things for storing sprites.
	var _sprSource	= mod_variable_get(_baseModType, _baseMod, _spriteVar);
	with(_sprSource){
		ds_list_add(global.augmentSpriteStorage, [[_baseModType, _baseMod, _spriteVar, _sprite, _spriteName], _sprite]);
		ds_list_add(global.augmentSprites, [[_baseModType, _baseMod, _spriteVar, _sprite, _spriteName], _popospr]);
	}

#define AugmentLaserBrain_resprite
	if(global.settingGreenAugments = false){
		 // Basegame Sprites:
		var _spr	= global.augmentBaseSprites
	    for(var i = 0; i < array_length(_spr); i++){
	    	if(_spr[i][1] != undefined){
	        	sprite_replace(_spr[i][0], _spr[i][1], _spr[i][2], _spr[i][3], _spr[i][4]);
	    	}
	    }
	     // Mod Sprites:
	    var _sprites = global.augmentSprites;
	    for(var i = 0; i < ds_list_size(_sprites); i++){
	        var _spr = ds_list_find_value(_sprites, i)
	        	
	         // for .spr paths:
	        if(_spr[0][3] != undefined){
	 	        if(_spr[1] != undefined){
		        	var _sprSource = mod_variable_get(_spr[0][0], _spr[0][1], _spr[0][2]);
		        	lq_set(_sprSource, _spr[0][4], _spr[1])
		        }       	
		     // normal sprites:
	        } else {
		        if(_spr[1] != undefined){
		        	mod_variable_set(_spr[0][0], _spr[0][1], _spr[0][2], _spr[1]);
		        }
	        }
	    }
	    
	     // WeaponsOverhaul
	    if(mod_exists("mod", "WeaponsOverhaul")){
	    	weapon_set_sprt(wep_energy_hammer,		global.sprPopoEnergyHammer);
	    	weapon_set_sprt(wep_energy_screwdriver, global.sprPopoEnergyScrewdriver);
	    	weapon_set_sprt(wep_energy_sword,		global.sprPopoEnergySword);
	    }
	}
    global.spritesReplaced = true;
    
#define AugmentLaserBrain_restoresprite
	 // Basegame Sprites:
    for(var i = 0; i < array_length(global.augmentBaseSpritesRestore); i++){
        sprite_restore(global.augmentBaseSpritesRestore[i]);
    }
     // Mod Sprites:
    var _storage = global.augmentSpriteStorage;
    for(var i = 0; i < ds_list_size(_storage); i++){
        var _spr = ds_list_find_value(_storage, i)
         // for .spr paths:
        if(_spr[0][3] != undefined){
	    	var _sprSource = mod_variable_get(_spr[0][0], _spr[0][1], _spr[0][2]);
	    	lq_set(_sprSource, _spr[0][4], _spr[1])
	     // normal sprites:
        } else {
	        mod_variable_set(_spr[0][0], _spr[0][1], _spr[0][2], _spr[1]);
        }
    }
    
     // WeaponsOverhaul
    if(mod_exists("mod", "WeaponsOverhaul")){
    	weapon_set_sprt(wep_energy_hammer,		mod_variable_get("mod", "WeaponsOverhaul", "sprEnergyHammer"));
    	weapon_set_sprt(wep_energy_screwdriver, mod_variable_get("mod", "WeaponsOverhaul", "sprEnergyScrewdriver"));
    	weapon_set_sprt(wep_energy_sword,		mod_variable_get("mod", "WeaponsOverhaul", "sprEnergySword"));
    }
    global.spritesReplaced = false;
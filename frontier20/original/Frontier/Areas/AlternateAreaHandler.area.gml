#define init
    // https://wigglercola.itch.io/alternate-area-handler
    // ALTERNATE AREA HANDLER by wigglercola
    // feel free to bundle this with your area mods, thats what its for.
    // do not touch this mod directly, it is meant to be loaded alongside other mods importing altareas.
    // this is a .area file because area_transit only works in those, probably dont try going here.
    // if u need help using this, contact wigglercola on discord.

	global.prevArea 		= "";
	global.knownMods		= [];	
	global.areaVars	        = [];
	global.openListSlot		= 0;
    global.areaList         = ds_list_create();
    
    global.rollingEnabled   = true; // whether or not the mod actually rolls areas, for use with other mods' options menus and whatnot
    global.tempRolls 		= 0; // how many transitions that rolling will be disabled for, for things like warp zone.
    global.defaultAreas     = true; // whether or not base areas are in their own area pools, also for external editing.

#define area_transit

     // area files can't run game_start, we gotta make do
    with(instances_matching(GameCont, "alternateAreaHandler", null)){
        alternateAreaHandler = true;
        global.prevArea = ""
    }
    
     // warp zone check:
    if(GameCont.area = "red"){
    	global.tempRolls += 2;
    }
   
     // check and roll areas on area change:
    if(global.rollingEnabled = true && global.tempRolls <= 0){
		if(GameCont.area != global.prevArea){
    		var _newArea = area_roll(GameCont.area);
    		if(_newArea != undefined){
    			GameCont.area = _newArea;
    		}
		}
		global.prevArea	= GameCont.area;
    }
    if(global.tempRolls > 0){
    	global.tempRolls -= 1;
    }

#define altareas_import_example
	// this is a general way of how to import area to the altarea handler, youll want this to run in init and game_start
	// run these functions via a mod_script_call in a different file, you dont want to touch the altarea handler file.

	 // Check if in alternateareahandler array:
	var _knownMods	= mod_variable_get("area", "AlternateAreaHandler", "knownMods"),
        _knownIndex = 0,
        _seeMe		= 0;
    repeat(array_length(_knownMods)){
        if(_knownMods[_knownIndex] = mod_current){
            _seeMe += 1;
        }
        _knownIndex += 1;
    }
     // If not found, add self then run area add functions
    if(_seeMe <= 0){
    	array_push(_knownMods, mod_current);
    	mod_variable_set("area", "AlternateAreaHandler", "knownMods", _knownMods)
    	
    	 // Add areas here:
    	mod_script_call("area", "AlternateAreaHandler", "area_add", 1, ["greendesert",		1, true, false, mod_current]);	// adds greendesert to the pool of desert alternatives
    	mod_script_call("area", "AlternateAreaHandler", "area_add", 3, ["junkyard",			1, true, false, mod_current]);	// adds junkyard to the pool of scrapyard alternatives
    	mod_script_call("area", "AlternateAreaHandler", "area_add", 3, ["garbagedump",		1, true, false, mod_current]);	// also adds garbagedump to the pool of scrapyard alternatives
    }
    
#define area_add(_baseArea, _newArea)
    /*
        youll want to call this externally with a mod_script_call, example file shows how youd want to set it up.
        area_add vars: (baseArea, [altArea, spawnWeight, subarea1only])
        baseArea        - the area you want to have a possible alternative
        altArea         - the new area that you want a chance to visit instead
        spawnWeight     - spawn weight for the altArea to appear, baseArea has a weight of 1, set to 1 for equal chances.
        				   setting spawnWeight as a string will make it call that function when calculating weight, for use in dynamic weight change/special conditions.
        				   this function will be called from the same file area_add is run from, if "bluedesert_check" is inputted, it will run bluedesert_check to calculate its weight number.
        subarea1only    - whether this area is only valid for rolling when entering subarea 1, stops scenarios like scrapyard(3-2) -> Vault -> altArea(a3-3), generally set to true
        overrridepool	- whether this area becomes part of the override pool if its weight is >0, the override pool overwrites the main pool if not empty
        					this is for cases like cursed crystal caves where if x going to y is guranteed, generally set this to false.
        					(note if there are multiple areas in the override pool it will choose between them as if they were in the area pool)
        areaMod			- what mod to run spawn weight check from if spawn weight is a string, usually just keep as mod_current.
         
        Ex: area_add(101, ["beach", 1, true, false, mod_current]) - makes it so theres an equal chance to visit oasis or beach when entering oasis.
        
        Ex2: area_add(7, ["temple", "templeWeight_check", true, true, mod_current]) - makes it so if templeWeight_check returns >0, temple is guranteed* instead of going to palace.
         *if multiple areas are in the override pool it will choose between them.
    */
    if(ds_list_find_index(global.areaList, _baseArea) != -1){
        var _areaIndex = ds_list_find_index(global.areaList, _baseArea),
            _areaSlot = global.areaVars[_areaIndex];
    	    array_push(_areaSlot, _newArea);
    } else {
        area_add_base(_baseArea, _newArea);
    }
    

#define area_add_base(_baseArea, _newArea)
    /*
        run by area_add when it doesn't have a preexisting slot for that area.
    */
	ds_list_add(global.areaList, _baseArea)
	global.areaVars[global.openListSlot] = []
	array_push(global.areaVars[global.openListSlot], _newArea)
	global.openListSlot += 1;
	
#define area_roll(_baseArea)
	var _chosenArea = undefined,
		_areaIndex	= ds_list_find_index(global.areaList, _baseArea);
	if(_areaIndex != -1){
	    var _areaPool   	= (global.defaultAreas = true) ? [[undefined, 1]] : [],
	        _areaArray  	= global.areaVars[_areaIndex],
	        _overridePool	= [];
	   for(var i = 0; i < array_length(_areaArray); i++){
	        var _altOption = [];
	         // push area name:
            array_push(_altOption, _areaArray[i][0])
	        
	         // calculate weight then push to chosen pool
	        var _weightNum		= _areaArray[i][1]
	        
	         // run special check if string:
	        if(is_string(_weightNum)){
	        	_weightNum = mod_script_call("mod", _areaArray[i][4], _areaArray[i][1]);
	        }
	         // Final spawnweight and what pool to go to:
	        var	_spawnWeight    = (_areaArray[i][2] = true) ? _weightNum * (GameCont.subarea = 1) : _weightNum,
	        	_choosePool		= (_areaArray[i][3] = true && _spawnWeight > 0) ? _overridePool : _areaPool;
	        array_push(_altOption, _spawnWeight)
    		array_push(_choosePool, _altOption);
    	}
    	 // if override pool >0 use it instead
    	var _poolPool = (array_length(_overridePool) > 0) ? _overridePool : _areaPool;
    	_chosenArea = pool(_poolPool)
	}
	return _chosenArea;
	
#define pool(_pool)
	/*
		Accepts a LWO or array of value:weight pairs and returns one of the values based on random chance
		
		Ex:
			pool({
				"A" : 4, // 50%
				"B" : 3, // 37.5%
				"C" : 1  // 12.5%
			})
			pool([
				[Bandit,    5], // 50%
				[Scorpion,  3], // 30%
				[BigMaggot, 1], // 10%
				[Maggot,    1]  // 10%
			])
	*/
	
	 // Turn LWO Into Array:
	if(is_object(_pool)){
		var _poolNew = [];
		for(var i = 0; i < lq_size(_pool); i++){
			array_push(_poolNew, [lq_get_key(_pool, i), lq_get_value(_pool, i)]);
		}
		_pool = _poolNew;
	}
	
	 // Roll Max Number:
	var _roll = 0;
	with(_pool){
		_roll += self[1];
	}
	_roll -= seeded_random(GameCont.hard + GameCont.baseseed + 500, 0, _roll, false)
	
	 // Find Rolled Value:
	if(_roll > 0){
		with(_pool){
			_roll -= self[1];
			if(_roll <= 0){
				return self[0];
			}
		}
	}
	
	return undefined;
	
#define seeded_random(_seed, _min, _max, _irandom)
	var _lastSeed = random_get_seed();
	random_set_seed(GameCont.baseseed + _seed);
	random_set_seed(ceil(random(100000) * random(100000)));
	var rand;
	if(_irandom){
		rand = _min+irandom(_max-_min);
	}else{
		rand = _min+random(_max-_min);
	}
	random_set_seed(_lastSeed);
	return rand;	
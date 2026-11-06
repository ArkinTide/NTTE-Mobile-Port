/*	               Events
	This is the Events package of Lib.
	It adds an Event system that can be hooked
	into to create custom events.
*/
	
// Original implementation and description taken from NTTE
/*
	0) Determine if X should be an event:
		Would X use the event tip system?
		If a mutation made events more likely, should X be more likely?
		If a crown made events spawn in any area, should X spawn anywhere?
		
	1) Add an event using 'event_add(_event)'
	
	2) Define scripts:
		Event_text    : Returns the event's loading tip, leave undefined or return a blank string for no loading tip (NOTE: @e in this works like @s,@r,etc, but for the default color)
		Event_area    : Returns the event's spawn area, leave undefined if it can spawn on any area
		Event_hard    : Returns the event's minimum difficulty, leave undefined to default to 2 (Desert-2)
		Event_chance  : Returns the event's spawn chance from 0 to 1, leave undefined if it always spawns
		Event_setup   : The event's pre-generation code, called from its controller object to define variables and/or adjust level gen before floors are made
		Event_create  : The event's generation code, called from its controller object during lib's level_start script
		Event_step    : The event's step code, called from its controller object
		Event_cleanup : The event's cleanup code, called from its controller object when it's destroyed (usually when the level ends)
*/

//For internal use, adds the script to be easily usable.
#define addScript(name)
	lq_set(instances_matching(CustomObject, "name", "libGlobal")[0].scriptReferences, name, ["mod", mod_current, name]);

#define init

	#macro infinity 1/0
	
	addScript("event_add");
	addScript("event_add_ext");
	addScript("event_set_active");
	addScript("event_get_active");
	script_ref_call(["mod", "lib", "updateRef"]);
	global.isLoaded = true;
	
	 // Event Tip Color:
	event_tip = `@(color:${make_color_rgb(175, 143, 106)})`;
	
	 // Event Execution Order:
	event_list = [];
	
	script_ref_call(["mod", "lib", "getRef"], "mod", mod_current, "scr");
	
#define update(_newID)
	 // Loading Screen:
	if(instance_exists(GenCont) && GenCont.id > _newID){
		
		 // Setup Events:
		var _list = event_list;
		for(var i = 0; i < array_length(_list); i++){
			var	_scrt    = _list[i],
				_modType = _scrt[0],
				_modName = _scrt[1],
				_name    = _scrt[2],
				_area    = mod_script_call(_modType, _modName, _name + "_area");
				
			var _check = false;
			if(
				is_undefined(_area) && 
				(
					is_real(GameCont.area) && 
					(GameCont.area != 0) && 
					(GameCont.area != 7 || GameCont.subarea != 3) ||
					is_string(GameCont.area) && (!mod_script_exists("area", GameCont.area, "area_special") || !mod_script_call("area", GameCont.area, "area_special"))
				) || 
				GameCont.area == _area){
				_check = true;
			}else if(is_array(_area)){
				with(_area){
					if(GameCont.area == self){
						_check = true;
						break;
					}
				}
			}
			if(_check){
				var _hard = mod_script_call(_modType, _modName, _name + "_hard");
				if(GameCont.hard >= (is_undefined(_hard) ? 2 : _hard)){
					var _chance = 1;
					if(mod_script_exists(_modType, _modName, _name + "_chance")){
						_chance = mod_script_call(_modType, _modName, _name + "_chance");
					}
					if(chance(_chance, 1)){
						event_set_active(_modType, _modName, _name, true);
					}
				}
			}
		}
	}

#define level_start
	 // Activate Events:
	with(event_get_active(all)){
		x = 0;
		y = 0;
		
		 // Set Events:
		on_step    = script_ref_create_ext(mod_type, mod_name, event + "_step");
		on_cleanup = script_ref_create_ext(mod_type, mod_name, event + "_cleanup");
		
		 // Generate Event:
		var _minID = instance_create(0, 0, DramaCamera);
		mod_script_call(mod_type, mod_name, event + "_create");
		floors = instances_matching_gt(Floor, "id", _minID);
		
		 // Position Controller:
		if(x == 0 && y == 0){
			if(array_length(floors) > 0){
				var	_x1 = +infinity,
					_y1 = +infinity,
					_x2 = -infinity,
					_y2 = -infinity;
					
				with(floors){
					if(_x1 > bbox_left      ) _x1 = bbox_left;
					if(_y1 > bbox_top       ) _y1 = bbox_top;
					if(_x2 < bbox_right  + 1) _x2 = bbox_right  + 1;
					if(_y2 < bbox_bottom + 1) _y2 = bbox_bottom + 1;
				}
				
				x = (_x1 + _x2) / 2;
				y = (_y1 + _y2) / 2;
			}
		}
	}

#macro spr global.spr
#macro msk spr.msk
#macro snd global.snd
#macro mus snd.mus
#macro lag global.debug_lag

#macro event_tip  global.event_tip
#macro event_list global.event_list

#define event_add
	/*
		Adds a given event to the list of events
		If you give a list of events to add, they will be added
		
		Ex:
			event_add(mod_current, "MaggotPark");
			event_add([[mod_current, "MaggotPark"], [mod_current, "IceRink"]]);
	*/
	if(is_array(argument[0])){
		var _scrt_list = [];
		with(argument[0]){
			array_push(_scrt_list, event_add(self[0], self[1]));
		}
		return _scrt_list;
	}
	
	var _scrt = (
		script_ref_create_ext("mod", argument[1], argument[0])
	);
	
	with(event_list){
		if(self[0] == _scrt[0] && self[1] == _scrt[1] && self[2] == _scrt[2]){
			return undefined;
		}
	}
	array_push(event_list, _scrt);
	
	return _scrt;

#define event_add_ext
	/*
		Adds a given event script reference to the list of events
		
		Ex:
			event_add_ext(script_ref_create_ext(mod_type_current, mod_current, "MaggotPark"));
	*/
	
	var _scrt = argument[0];
	
	with(event_list){
		if(self[0] == _scrt[0] && self[1] == _scrt[1] && self[2] == _scrt[2]){
			return undefined;
		}
	}
	array_push(event_list, _scrt);
	
	return _scrt;
	
#define event_set_active(_modType, _modName, _name, _active)
	/*
		Activates or deactivates a given event and returns its controller object
		Use the 'all' keyword to activate every event and return all of their controller objects as an array, wtf
	*/
	
	 // Activate:
	if(_active){
		 // All:
		if(_name == all){
			with(event_list){
				event_set_active(_modType, _modName, self[2], _active);
			}
		}
		
		 // Normal:
		else if(!event_get_active(_name)){
			with(instance_create(0, 0, CustomObject)){
				name     = "Event";
				mod_type = _modType;
				mod_name = _modName;
				event    = _name;
				tip      = mod_script_call(mod_type, mod_name, event + "_text");
				floors   = [];
				spawn_x  = 10016;
				spawn_y  = 10016;
				
				with(GenCont){
					 // Spawn Point:
					other.spawn_x = spawn_x;
					other.spawn_y = spawn_y;
					
					 // Tip:
					if(is_string(other.tip) && other.tip != ""){
						if("tip_event" not in self){
							tip_event = other.tip;
							tip       = event_tip + string_replace(tip_event, "@e", event_tip);
						}
					}
				}
				
				 // Setup:
				mod_script_call(mod_type, mod_name, event + "_setup");
			}
		}
	}
	
	 // Deactivate:
	else with(event_get_active(_name)){
		instance_destroy();
	}
	
	return event_get_active(_name);
	
#define event_get_active(_name)
	/*
		Returns a given event's controller object
		Use the 'all' keyword to return an array of every active event's controller object
	*/
	
	var _inst = instances_matching(CustomObject, "name", "Event");
	
	 // All:
	if(_name == all){
		array_sort(_inst, true);
		return _inst;
	}
	
	 // Normal:
	with(instances_matching(_inst, "event", _name)){
		return self;
	}
	
	return noone;
	
#define chance(_numer, _denom)                                                          		return  random(_denom) < _numer;
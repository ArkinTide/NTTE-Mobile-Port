/*						Lib
	This is Lib, an all-in-one NTT library mod meant
	to combine all the strengths of the current
	generation of mods into one easily-usable library.
*/

#define init
//global variable storage
if(array_length(instances_matching(CustomObject, "name", "libGlobal")) != 1){
	with(instances_matching(CustomObject, "name", "libGlobal")){
		instance_destroy();
	}
	with(instance_create(0,0,CustomObject)){
		name = "libGlobal";
		loadedPackages = {};
		scriptReferences = {};
		activeReferences = [];
		activeHooks = [];
		updateid = real(instance_create(0, 0, DramaCamera));
		endupdateid = updateid;
		level_loading = false;
		canLoad = undefined;
		bind_late_step = noone;
		bind_end_step = noone;
		previousmutations = [];
		persistent = true;
	}
}
global.loadedPackages = GlobalGet("loadedPackages");
global.scriptReferences = GlobalGet("scriptReferences");
global.activeReferences = GlobalGet("activeReferences");
global.activeHooks = GlobalGet("activeHooks");
global.updateid = GlobalGet("updateid");
global.endupdateid = GlobalGet("endupdateid");
global.level_loading = GlobalGet("level_loading");
global.canLoad = GlobalGet("canLoad");
global.bind_late_step = GlobalGet("bind_late_step");
global.bind_end_step = GlobalGet("bind_end_step");
global.previousmutations = GlobalGet("previousmutations");

addScript("import");
addScript("getRef");

for(var i = 0; i < lq_size(global.loadedPackages); i++){
	if(lq_get_value(global.loadedPackages, i) == 1 || !mod_exists("mod", lq_get_key(global.loadedPackages, i))){
		lq_set(global.loadedPackages, lq_get_key(global.loadedPackages, i), 0)
		import(lq_get_key(global.loadedPackages, i));
	}
}

//v100 allow sideloading
//cansideload=1;
//wait for sideloading
while(!mod_sideload()){wait 1;}

//wait in case libloader's already done the work for you
wait(2);
if(GlobalGet("canLoad") == undefined){
	ping();
}
//libGeneral is important for the rest of lib, so it's loaded by default
import("libGeneral");

#define import(package)
/* Creator: Golden Epsilon
Description: 
	Lets you import parts of the library in for use.
	If you do not use this function, you cannot access
	the features of this mod.
Usage:
	script_ref_call(["mod", "lib", "import"], "libPackageName");
*/
while(!mod_sideload()){wait 1;}
while(GlobalGet("canLoad") == undefined){wait(1)}
if(GlobalGet("canLoad")){
	if((!lq_exists(GlobalGet("loadedPackages"), package) || lq_get(GlobalGet("loadedPackages"), package) == 0) && !mod_exists("mod", package)){
		lq_set(GlobalGet("loadedPackages"), package, 1);
		file_delete("../../mods/lib/" + package + ".mod.gml");
		while (file_exists("../../mods/lib/" + package + ".mod.gml")) {wait 1;}
		file_download(URL + package + ".mod.gml", "../../mods/lib/" + package + ".mod.gml");
		while (!file_loaded("../../mods/lib/" + package + ".mod.gml")) {wait 1;}
		var timeout = 300;
		while (!file_exists("../../mods/lib/" + package + ".mod.gml") && timeout > 0) {wait 1;timeout--;}

		if(file_exists("../../mods/lib/" + package + ".mod.gml")){
			mod_load("../../mods/lib/" + package);
		}else{
			trace("Could not find package " + package);
			lq_set(GlobalGet("loadedPackages"), package, 3);
		}
	}
}else{
	if((!lq_exists(GlobalGet("loadedPackages"), package) || lq_get(GlobalGet("loadedPackages"), package) == 0) && !mod_exists("mod", package)){
		lq_set(GlobalGet("loadedPackages"), package, 1);
		file_load("../../mods/lib/" + package + ".mod.gml");
		while (!file_loaded("../../mods/lib/" + package + ".mod.gml")) {wait 1;}
		if(file_exists("../../mods/lib/" + package + ".mod.gml")){
			mod_load("../../mods/lib/" + package);
		}else{
			trace("Could not find package " + package);
			lq_set(GlobalGet("loadedPackages"), package, 3);
		}
	}
}
while((!mod_exists("mod", package) || !mod_variable_get("mod", package, "isLoaded")) && lq_get(GlobalGet("loadedPackages"), package) != 3){wait(1);}
lq_set(GlobalGet("loadedPackages"), package, 2);

#define cleanup
     // Unbind Script on Mod Unload:
    with(GlobalGet("bind_late_step")){
        instance_destroy();
    }
    with(GlobalGet("bind_end_step")){
        instance_destroy();
    }

#define getRef(_type, _mod, _name)
// _type should be the type of mod file ("mod", "race", "weapon", etc)
// _mod should be the mod file name (mod_current, basically)
// _name should be the name of the *global* variable you want to use.

// ALSO, calling this function makes this mod call function hooks automatically.

getScr(_type, _mod, _name);
getHooks(_type, _mod);

#define getScr(_type, _mod, _name)
// sets the global variable given to this function to a LWO of script references.
// _type should be the type of mod file ("mod", "race", "weapon", etc)
// _mod should be the mod file name (mod_current, basically)
// _name should be the name of the *global* variable you want to use.
//
// For example, if you run this on a variable global.scr with
// script_ref_call(["mod", "lib", "getScr"], "mod", mod_current, "scr");
// (assuming you are calling it from a .mod.gml file), you can then run
// script_ref_call(global.scr.obj_create, 0, 0, Bandit);
// instead of
// script_ref_call(["mod", "libGeneral", "obj_create"], 0, 0, Bandit);
//
// (you can also do "#macro scr global.scr" and "#macro call script_ref_call" to make it easier)

mod_variable_set(_type, _mod, _name, GlobalGet("scriptReferences"));

//ensure that there are no duplicates
with(GlobalGet("activeReferences")){
	if(self[0] == _type && self[1] == _mod && self[2] == _name){
		return;
	}
}
array_push(GlobalGet("activeReferences"), [_type, _mod, _name]);

#define getHooks(_type, _mod)
// Hooks are functions that are called by lib, that work like step(), draw(), game_start(), etc work for base NTT.
// Call this function to opt-in the calling mod for these hooks.
// _type should be the type of mod file ("mod", "race", "weapon", etc)
// _mod should be the mod file name (mod_current, basically)
//
// Hooks are:
// late_step: gets called after the normal step, useful for doing stuff after, say, projectile creation.
// end_step: gets called after collision and other such things
// update(startID, endID) : gets called whenever a new object is created, and passes in the latest ID from the frame before.
//          (does NOT include Effect objects, CustomObject objects, or CustomScript objects)
// end_update(startID, endID) : like update, but occurs at the same time as end_step
// level_start : gets called when the level starts
// mutation_update(currentmutations, previousmutations) : gets called when there are new/removed mutations
// weapon_prefire(specfire, weapon) : gets called when the player is going to fire that frame. (also calls on non-weapon mods!)
// You use a hook just by having a function with the right name (for example, #define update)
// The function will be called when needed as long as the mod's called getRef at some point.
// NOTE: when you use a hook in a weapon file you have an additional parameter, before all the others,
// 		saying whether the weapon is in the primary or secondary slot.

//ensure that there are no duplicates
with(GlobalGet("activeHooks")){
	if(self[0] == _type && self[1] == _mod){
		return;
	}
}
array_push(GlobalGet("activeHooks"), [_type, _mod]);

#define functionList
// prints to the chat all loaded functions.
// Mainly for a reference for modders, I don't expect this to be used much though.
// Only traces the module name and function name, does NOT print parameters.
with(GlobalGet("scriptReferences")){
	trace(self[1] + ": " + self[2]);
}

#define ping()
	//Check internet connection
	file_download("https://api.github.com/zen", "ping.txt");
	var d = 0;
	while (!file_loaded("ping.txt")){
		if d++ > 150 {
			trace("Server timed out, using already downloaded files");
			GlobalSet("canLoad", false);
			return;
		}
		wait 1;
	}
	var str = string_load("ping.txt");
	GlobalSet("canLoad", true);
	if(is_undefined(str)){
		GlobalSet("canLoad", false);
		return;
	}/*else{
		var json = json_decode(str)
		if(json == json_error){
			GlobalSet("canLoad, false);
			return;
		}
	}*/

#define updateRef
// For internal use.
with(GlobalGet("activeReferences")){
	mod_variable_set(self[0], self[1], self[2], GlobalGet("scriptReferences"));
}

#define loadText(path)
// For internal use.
mod_loadtext(path);

//For internal use, adds the script to be easily usable.
#define addScript(name)
	lq_set(instances_matching(CustomObject, "name", "libGlobal")[0].scriptReferences, name, ["mod", mod_current, name]);

#macro URL "https://raw.githubusercontent.com/GoldenEpsilon/NTT-Lib/main/"


#define step
	//global variable storage
	var _global = instances_matching(CustomObject, "name", "libGlobal");
	if(array_length(_global) != 1 || "lastUpdatedFrame" not in _global[0] || current_frame - _global[0].lastUpdatedFrame > 1){
		with(_global){
			instance_destroy();
		}
		with(instance_create(0,0,CustomObject)){
			name = "libGlobal";
			loadedPackages = global.loadedPackages;
			scriptReferences = global.scriptReferences;
			activeReferences = global.activeReferences;
			activeHooks = global.activeHooks;
			updateid = global.updateid;
			endupdateid = global.endupdateid;
			level_loading = global.level_loading;
			canLoad = global.canLoad;
			bind_late_step = global.bind_late_step;
			bind_end_step = global.bind_end_step;
			previousmutations = global.previousmutations;
			persistent = true;
			lastUpdatedFrame = current_frame;
		}
	}else{
		global.loadedPackages = GlobalGet("loadedPackages");
		global.scriptReferences = GlobalGet("scriptReferences");
		global.activeReferences = GlobalGet("activeReferences");
		global.activeHooks = GlobalGet("activeHooks");
		global.updateid = GlobalGet("updateid");
		global.endupdateid = GlobalGet("endupdateid");
		global.level_loading = GlobalGet("level_loading");
		global.canLoad = GlobalGet("canLoad");
		global.bind_late_step = GlobalGet("bind_late_step");
		global.bind_end_step = GlobalGet("bind_end_step");
		global.previousmutations = GlobalGet("previousmutations");
		_global[0].lastUpdatedFrame = current_frame;
	}
	
	//binded steps
    if(!instance_exists(GlobalGet("bind_late_step"))){
        GlobalSet("bind_late_step", script_bind_step(late_step, 0));
    }
    if(!instance_exists(GlobalGet("bind_end_step"))){
        GlobalSet("bind_end_step", script_bind_end_step(end_step, 0));
    }
	
	//level_start
	if(instance_exists(GenCont) || instance_exists(Menu)){
		GlobalSet("level_loading", true);
	}
	else if(GlobalGet("level_loading")){
		GlobalSet("level_loading", false);
		with(GlobalGet("activeHooks")){
			switch(self[0]){
				case "skill":
					with(GameCont){
						if(skill_get(other[1])){
							script_ref_call([other[0], other[1], "level_start"]);
						}
					}
					break;
				case "race":
					with(Player){
						if(race == other[1]){
							script_ref_call([other[0], other[1], "level_start"]);
						}
					}
					break;
				case "wep":
				case "weapon":
					with(Player){
						if(wep == other[1] || (is_object(wep) && wep.wep == other[1])){
							script_ref_call([other[0], other[1], "level_start"], 1);
						}
						if(bwep == other[1] || (is_object(bwep) && bwep.wep == other[1])){
							script_ref_call([other[0], other[1], "level_start"], 0);
						}
					}
					break;
				default:
					with(GameCont){
						script_ref_call([other[0], other[1], "level_start"]);
					}
			}
		}
	}
	
	//mutation_update
	var mutations = [];
	while(skill_get_at(array_length(mutations)) != null){
		array_push(mutations, skill_get_at(array_length(mutations)));
	}
	for(var i = 0; i < array_length(GlobalGet("previousmutations")) || i < array_length(mutations); i++){
		if(i >= array_length(mutations) || i >= array_length(GlobalGet("previousmutations")) || GlobalGet("previousmutations")[i] != mutations[i]){
			with(GlobalGet("activeHooks")){
				switch(self[0]){
					case "skill":
						with(GameCont){
							if(skill_get(other[1])){
								script_ref_call([other[0], other[1], "mutation_update"], mutations, GlobalGet("previousmutations"));
							}
						}
						break;
					case "race":
						with(Player){
							if(race == other[1]){
								script_ref_call([other[0], other[1], "mutation_update"], mutations, GlobalGet("previousmutations"));
							}
						}
						break;
					case "wep":
					case "weapon":
						with(Player){
							if(wep == other[1] || (is_object(wep) && wep.wep == other[1])){
								script_ref_call([other[0], other[1], "mutation_update"], 1, mutations, GlobalGet("previousmutations"));
							}
							if(bwep == other[1] || (is_object(bwep) && bwep.wep == other[1])){
								script_ref_call([other[0], other[1], "mutation_update"], 0, mutations, GlobalGet("previousmutations"));
							}
						}
						break;
					default:
						with(GameCont){
							script_ref_call([other[0], other[1], "mutation_update"], mutations, GlobalGet("previousmutations"));
						}
				}
			}
			GlobalSet("previousmutations", mutations);
			break;
		}
	}
	
	//weapon_prefire
	with(Player){
		var _auto = weapon_get_auto(wep);
		var secondary = 0;
		var specfire = 0;
		var fired = 0;
		if(race == "steroids" && _auto >= 0){
			_auto = true;
		}
		if(race == "steroids" && bcan_shoot && canspec && (((_auto && bwep != 0) ? button_check(index, "spec") : button_pressed(index, "spec")) || usespec) && (ammo[weapon_get_type(bwep)] >= weapon_get_cost(bwep) || infammo != 0)){
			secondary = 1;
			specfire = 1;
			fired = 1;
		}
		if(can_shoot){
			if(race == "skeleton" && canspec && (button_pressed(index, "spec") || usespec) && weapon_get_cost(wep) > 0){
				specfire = 1;
				fired = 1;
			}
			else if(race == "venuz" && canspec && (button_pressed(index, "spec") || usespec) && weapon_get_type(wep) != 0 && (ammo[weapon_get_type(wep)] >= weapon_get_cost(wep) * floor(2 + (2 * skill_get(mut_throne_butt))) || infammo != 0)){
				specfire = 1;
				fired = 1;
			}
			else if(canfire && ((_auto && wep != 0) ? button_check(index, "fire") : (clicked || button_pressed(index, "fire"))) && (ammo[weapon_get_type(wep)] >= weapon_get_cost(wep) || infammo != 0)){
				fired = 1;
			}
		}
		if(fired){
			with(GlobalGet("activeHooks")){
				switch(self[0]){
					case "skill":
						with(other){
							if(skill_get(other[1])){
								script_ref_call([other[0], other[1], "weapon_prefire"], specfire, secondary ? bwep : wep);
							}
						}
						break;
					case "race":
						with(other){
							if(race == other[1]){
								script_ref_call([other[0], other[1], "weapon_prefire"], specfire, secondary ? bwep : wep);
							}
						}
						break;
					case "wep":
					case "weapon":
						with(other){
							if(wep == other[1] || (is_object(wep) && wep.wep == other[1])){
								script_ref_call([other[0], other[1], "weapon_prefire"], 1, specfire, secondary ? bwep : wep);
							}
							if(bwep == other[1] || (is_object(bwep) && bwep.wep == other[1])){
								script_ref_call([other[0], other[1], "weapon_prefire"], 0, specfire, secondary ? bwep : wep);
							}
						}
						break;
					default:
						with(other){
							script_ref_call([other[0], other[1], "weapon_prefire"], specfire, secondary ? bwep : wep);
						}
				}
			}
		}
	}

#define late_step
	create_update();
	
	//late step
	with(GlobalGet("activeHooks")){
		switch(self[0]){
			case "skill":
				with(GameCont){
					if(skill_get(other[1])){
						script_ref_call([other[0], other[1], "late_step"]);
					}
				}
				break;
			case "race":
				with(Player){
					if(race == other[1]){
						script_ref_call([other[0], other[1], "late_step"]);
					}
				}
				break;
			default:
				with(GameCont){
					script_ref_call([other[0], other[1], "late_step"]);
				}
		}
	}
	
#define end_step
	create_end_update();
	
	//end step
	with(GlobalGet("activeHooks")){
		switch(self[0]){
			case "skill":
				with(GameCont){
					if(skill_get(other[1])){
						script_ref_call([other[0], other[1], "end_step"]);
					}
				}
				break;
			case "race":
				with(Player){
					if(race == other[1]){
						script_ref_call([other[0], other[1], "end_step"]);
					}
				}
				break;
			default:
				with(GameCont){
					script_ref_call([other[0], other[1], "end_step"]);
				}
		}
	}
	
#define create_update
	//update
	var newID = real(instance_create(0, 0, DramaCamera));
	var updateid = GlobalGet("updateid");
	var lastid = GlobalGet("updateid");
	while(updateid++ < newID){
		if(instance_exists(updateid)){
			if("object_index" in updateid){
				var obj = updateid.object_index;
				if(object_get_parent(obj) == Effect || obj == Effect || object_get_parent(obj) == CustomScript || obj == CustomScript || obj == CustomObject){
					lastid++;
				}
			}else{
				lastid++;
			}
		}else{
			lastid++;
		}
	}
	if(newID > lastid){
		with(GlobalGet("activeHooks")){
			switch(self[0]){
				case "skill":
					with(GameCont){
						if(skill_get(other[1])){
							script_ref_call([other[0], other[1], "update"], GlobalGet("updateid"), newID);
						}
					}
					break;
				case "race":
					with(Player){
						if(race == other[1]){
							script_ref_call([other[0], other[1], "update"], GlobalGet("updateid"), newID);
						}
					}
					break;
				default:
					with(GameCont){
						script_ref_call([other[0], other[1], "update"], GlobalGet("updateid"), newID);
					}
			}
		}
	}
	GlobalSet("updateid", newID);
	
#define create_end_update
	//end_update
	var newID = real(instance_create(0, 0, DramaCamera));
	var updateid = GlobalGet("endupdateid");
	var lastid = GlobalGet("endupdateid");
	while(updateid++ < newID){
		if(instance_exists(updateid)){
			if("object_index" in updateid){
				var obj = updateid.object_index;
				if(object_get_parent(obj) == Effect || obj == Effect || object_get_parent(obj) == CustomScript || obj == CustomScript || obj == CustomObject){
					lastid++;
				}
			}else{
				lastid++;
			}
		}else{
			lastid++;
		}
	}
	if(newID > lastid){
		with(GlobalGet("activeHooks")){
			switch(self[0]){
				case "skill":
					with(GameCont){
						if(skill_get(other[1])){
							script_ref_call([other[0], other[1], "end_update"], GlobalGet("endupdateid"), newID);
						}
					}
					break;
				case "race":
					with(Player){
						if(race == other[1]){
							script_ref_call([other[0], other[1], "end_update"], GlobalGet("endupdateid"), newID);
						}
					}
					break;
				default:
					with(GameCont){
						script_ref_call([other[0], other[1], "end_update"], GlobalGet("endupdateid"), newID);
					}
			}
		}
	}
	GlobalSet("endupdateid", newID);
	
#define draw_pause
	create_update();
	create_end_update();

#define chat_command(command, parameter, player)

#define GlobalGet(_var)
var _global = instances_matching(CustomObject, "name", "libGlobal");
if(array_length(_global) != 1){
	return mod_variable_get("mod", mod_current, _var);
}else{
	return variable_instance_get(_global[0], _var)
}

#define GlobalSet(_var, _val)
var _global = instances_matching(CustomObject, "name", "libGlobal");
if(array_length(_global) != 1){
	mod_variable_set("mod", mod_current, _var, _val);
}else{
	variable_instance_set(_global[0], _var, _val)
}
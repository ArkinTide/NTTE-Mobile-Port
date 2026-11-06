/*	                
	This is the Chars package of Lib, for
	functions that help with making characters
*/

/*
||||||||||||||||||||||||UNFINISHED PACKAGE||||||||||||||||||||||||||||
*/

/*
	Scripts:
*/

//For internal use, adds the script to be easily usable.
#define addScript(name)
	lq_set(instances_matching(CustomObject, "name", "libGlobal")[0].scriptReferences, name, ["mod", mod_current, name]);

#define init
	addScript("");
	script_ref_call(["mod", "lib", "updateRef"]);
	global.isLoaded = true;
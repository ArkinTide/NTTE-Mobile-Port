// This mod downloads the latest version of Lib from github and loads it.
// This mod requires sideload permissions, if you do not give them the user will be prompted.

// For more information on lib: https://github.com/GoldenEpsilon/NTT-Lib

// IF YOU ARE LOOKING TO USE LIB IN YOUR MOD, THIS IS THE ONLY FILE YOU NEED.

//You can also just copy this file into yours if it's a one-file-mod, but it's not as recommended.

#define init
global.scr = {};
global.ready = 0;
wait(5);
loadLib();

#define import(module)
if(mod_exists("mod", "lib")){
	script_ref_call(["mod", "lib", "import"], module);
}else{
	if("toLoad" not in GameCont){
		GameCont.toLoad = [];
	}
	if(is_string(module)){
		array_push(GameCont.toLoad, module);
	}else if(is_array(module)){
		with(module){
			array_push(GameCont.toLoad, self);
		}
	}else{
		trace("Error: LibLoader's import needs either a string or an array");
	}
}

#define loadLib
//if lib is already loaded we do not need to reload it
if(!mod_exists("mod", "lib")){

	//if you don't mind keeping it as a folder download, you can allowmod by using multiple txt files
	//(load this mod in the first txt file, then load a second txt file and have the allowmod command in that second txt file)
	while(!mod_sideload()){wait 1;}
	
	global.err = false;
	if(!global.err){
		//Check internet connection
		file_download("https://api.github.com/zen", "ping.txt");
		var d = 0;
		while (!file_loaded("ping.txt")){
			if d++ > 150 {
				trace("Server timed out, using already downloaded files");
				global.err = true;
				break;
			}
			wait 1;
		}
	}
	
	if(!global.err){
		var str = string_load("ping.txt");
		if(is_undefined(str)){
			trace("Cannot connect to the internet, using already downloaded files");
			global.err = true;
		}/*else{
			var json = json_decode(str)
			if(json == json_error){
				trace("Cannot connect to the internet, using already downloaded files");
				global.err = true;
			}
		}*/
	}
	
	if(mod_exists("mod", "lib")){exit;}
	if(!global.err){
		//downloading lib (no version checking because that would slow the process further)
		//I delete for safety, there's a chance it isn't necessary
		file_delete("../../mods/lib/lib.mod.gml");
		file_delete("../../mods/lib/main.txt");
		file_delete("../../mods/lib/main2.txt");
		while (file_exists("../../mods/lib/lib.mod.gml")) {wait 1;}
		while (file_exists("../../mods/lib/main.txt")) {wait 1;}
		while (file_exists("../../mods/lib/main2.txt")) {wait 1;}
		file_download(URL + "lib.mod.gml", "../../mods/lib/lib.mod.gml");
		file_download(URL + "main.txt", "../../mods/lib/main.txt");
		file_download(URL + "main2.txt", "../../mods/lib/main2.txt");
		while (!file_loaded("../../mods/lib/lib.mod.gml")) {wait 1;}
		while (!file_loaded("../../mods/lib/main.txt")) {wait 1;}
		while (!file_loaded("../../mods/lib/main2.txt")) {wait 1;}
		while (!file_exists("../../mods/lib/lib.mod.gml")) {wait 1;}
		while (!file_exists("../../mods/lib/main.txt")) {wait 1;}
		while (!file_exists("../../mods/lib/main2.txt")) {wait 1;}
	}

	if(mod_exists("mod", "lib")){exit;}
	mod_loadtext("lib/main.txt");
	while(!mod_exists("mod", "lib")){wait(0);}
	mod_variable_set("mod", "lib", "canLoad", !global.err);
	script_ref_call(["mod", "lib", "getRef"], "mod", mod_current, "scr");
	global.ready = 1;
}else if(mod_exists("mod", "lib")){
	if("toLoad" in GameCont){
		with(GameCont.toLoad){
			script_ref_call(["mod", "lib", "import"], self);
		}
	}
	script_ref_call(["mod", "lib", "getRef"], "mod", mod_current, "scr");
	global.ready = 1;
}

#macro URL "https://raw.githubusercontent.com/GoldenEpsilon/NTT-Lib/main/"

#macro  scr																						global.scr
#macro  call																					script_ref_call
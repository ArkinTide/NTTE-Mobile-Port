#define init
// VERSION: 1.3.0

global.loaded = false;
wait(1);
load_campfire();

#macro repo "https://raw.githubusercontent.com/McChomk/CampfireAddon/main/"

#define load_campfire
if (!mod_exists("mod", "campfire"))
{
	while (!mod_sideload()) { wait(1); }
	global.err = false;
	
	if (!global.err)
	{
		//Check internet connection
		file_download("https://api.github.com/zen", "ping.txt");
		var _d = 0;
		while (!file_loaded("ping.txt"))
		{
			if (_d++ > 150)
			{
				trace("CAMPFIRE LOADER:\nServer timed out! Using already downloaded files");
				global.err = true;
				break;
			}
			wait (1);
		}
	}
	
	if (!global.err)
	{
		var _str = string_load("ping.txt");
		if (is_undefined(_str))
		{
			trace("CAMPFIRE LOADER:\nCannot connect to the internet, using already downloaded files");
			global.err = true;
		}
	}
	
	if (mod_exists("mod", "campfire")) exit;
	if (!global.err)
	{
		file_delete("../../mods/campfireaddon/campfire.mod.gml");
		file_delete("../../mods/campfireaddon/load_campfire.txt");
		
		while (file_exists("../../mods/campfireaddon/campfire.mod.gml")) {wait 0;}
		while (file_exists("../../mods/campfireaddon/load_campfire.txt")) {wait 0;}
		
		file_download(repo + "campfire.mod.gml", "../../mods/campfireaddon/campfire.mod.gml");
		file_download(repo + "load_campfire.txt", "../../mods/campfireaddon/load_campfire.txt");
		
		while (!file_loaded("../../mods/campfireaddon/campfire.mod.gml")) {wait 0;}
		while (!file_loaded("../../mods/campfireaddon/load_campfire.txt")) {wait 0;}
		
		while (!file_exists("../../mods/campfireaddon/campfire.mod.gml")) {wait 0;}
		while (!file_exists("../../mods/campfireaddon/load_campfire.txt")) {wait 0;}
	}

	if (mod_exists("mod", "campfire")) exit;
	mod_loadtext("campfireaddon/load_campfire.txt");
	while (!mod_exists("mod", "campfire")) { wait(0); }
	
	global.loaded = 1;
}
else
{
    mod_load("campfireaddon/campfire.mod.gml");
	while(!mod_exists("mod", "campfire")) { wait(0); }
	
    global.loaded = 1;
}
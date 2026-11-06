#define init
    // WIGGLERCOLA ULTIMATE LIBRARY LOADER //
    // if u want to use it for your own projects go ahead but do be aware I might update it and break all your stuff at any moment
    
    // this file is just a copy of McChomk's campfire loader ty for letting me use it I didnt wanna write my own.

    global.loaded = false;
    wait(1);
    load_wibbly();
    
    #macro repo "https://raw.githubusercontent.com/WigglerCola/wibbly/main/"

#define load_wibbly
    if (!mod_exists("mod", "wibbly"))
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
    				trace("WIBBLY LOADER:\nServer timed out! Using already downloaded files");
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
    			trace("WIBBLY LOADER:\nCannot connect to the internet, using already downloaded files");
    			global.err = true;
    		}
    	}
    	
    	if (mod_exists("mod", "wibbly")) exit;
    	if (!global.err)
    	{
    		file_delete("../../mods/wibbly/wibbly.mod.gml");
    		file_delete("../../mods/wibbly/load_wibbly.txt");
    		
    		while (file_exists("../../mods/wibbly/wibbly.mod.gml")) {wait 0;}
    		while (file_exists("../../mods/wibbly/load_wibbly.txt")) {wait 0;}
    		
    		file_download(repo + "wibbly.mod.gml", "../../mods/wibbly/wibbly.mod.gml");
    		file_download(repo + "load_wibbly.txt", "../../mods/wibbly/load_wibbly.txt");
    		
    		while (!file_loaded("../../mods/wibbly/wibbly.mod.gml")) {wait 0;}
    		while (!file_loaded("../../mods/wibbly/load_wibbly.txt")) {wait 0;}
    		
    		while (!file_exists("../../mods/wibbly/wibbly.mod.gml")) {wait 0;}
    		while (!file_exists("../../mods/wibbly/load_wibbly.txt")) {wait 0;}
    	}
    
    	if (mod_exists("mod", "wibbly")) exit;
    	mod_loadtext("wibbly/load_wibbly.txt");
    	while (!mod_exists("mod", "wibbly")) { wait(0); }
    	
    	global.loaded = 1;
    }
    else
    {
        mod_load("wibbly/wibbly.mod.gml");
    	while(!mod_exists("mod", "wibbly")) { wait(0); }
    	
        global.loaded = 1;
    }
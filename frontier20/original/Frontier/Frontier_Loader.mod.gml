#define init
	 // ty jsburg for letting me steal the defpack loader


	 // do not touch please
	#macro MODVERSION	"VERSION 1.0.3.3"; 
    #macro paused		global.paused
    #macro loading		global.loading
    #macro category 	global.category 
    #macro maxProgress	global.maxProgress
    #macro progress 	global.progress
    #macro fade 		global.fade
    #macro done 		global.done
	
	global.paused		= false;
	global.loading		= true;
	global.category		= "Main Files";
	global.maxProgress	= 1;
	global.progress		= 0;
	global.fade			= 0;
	global.done			= false;
	global.loaderHeight	= 0;
	global.outOfDate	= false;
	global.outdateCheck	= true;

	#macro  scr			global.scr
	#macro  call		script_ref_call
	
	 // SPRITES: //
	global.sprLoaderBarBack		= sprite_add("sprites/menu/sprLoaderBarBack.png",	1, 57, 14);
	global.sprLoaderBarFront	= sprite_add("sprites/menu/sprLoaderBarFront.png",	1, 57, 15);
	global.sprLoaderBack		= sprite_add("sprites/menu/sprLoaderBack.png",		1, 57, 15);
	
    global.sprUpdateSign		= sprite_add("sprites/areas/campfire/sprUpdateSign.png",				1, 26, 28);
    global.sprUpdateSignExt		= sprite_add("sprites/areas/campfire/sprUpdateSignLoadOutdated.png",	1, 26, 14);
    
     // KILL SIGNS
    with(instances_matching(CustomObject, "name", "fr_updateSign", "fr_updateSignExt")){
    	instance_destroy();
    }
    
	 // LIB:
	global.libLoaded = false;
	if(fork()){
				
			while(!mod_exists("mod", "lib")){wait(1);}
		
			script_ref_call(["mod", "lib", "getRef"], "mod", mod_current, "scr");
		
			var modules = ["libMenu", "libSaves", "libEvents", "libWeps", "libPickups", "libMuts", "libAreas"];
			with(modules) call(scr.import, self);
				
			global.libLoaded = true;
	
    	global.requests = [];
    	add_post_load_statement("UNCHARTED FRONTIER LOADED!", make_color_rgb(215, 175, 113));
    	add_post_load_statement("Please report any bugs/feedback to wigglercola on the Nuclear Throne Discord or on Uncharted Frontier's itch.io page", make_color_rgb(215, 175, 113));
    	/*   it seems fine
	    if(room_speed > 30){ // 60FPS Warning:
	    	add_post_load_statement("NOTICE: FPS above 30 is not fully tested and may have issues, be careful!", 16745694);
	    }
	    */
	    
	     // Update Check:
		file_download("https://raw.githubusercontent.com/WigglerCola/NTEI-Ping/main/updateping.txt", "updateping.txt");
		
		 // Make sure file is loaded:
    	var tries = 0;
		while(!file_loaded("updateping.txt")){
    	    wait(0);
        	tries++
        	if(tries > 150){
            	add_post_load_statement("FRONTIER REPO TIMED OUT: CANNOT CHECK FOR UPDATES", c_red)
            	break;
        	}
    	}
    	 // Something went wrong!
		if(!file_exists("updateping.txt") || (file_exists("updateping.txt") && is_undefined(string_load("updateping.txt")))){
			add_post_load_statement("FRONTIER UNABLE TO CONNECT TO REPO: CANNOT CHECK FOR UPDATES", c_red);
		} else {
			 // Update Needed!
			var _newPing = string_load("updateping.txt");
			if(string_trim(_newPing) != string_trim(MODVERSION)){
				
				 // create signs on campfire
				create_updatesigns()
				
				 // EEK!
				trace("")
				trace_color("UNCHARTED FRONTIER IS OUT OF DATE! Please reinstall at wigglercola.itch.io/uncharted-frontier", make_color_rgb(154, 97, 56));
				trace_color("INSTALLED: " + MODVERSION, make_color_rgb(154, 97, 56));
				trace_color("LATEST: " + _newPing, make_color_rgb(154, 97, 56));
				trace_color("PRESS B TO CONTINUE LOADING OUTDATED FRONTIER VERSION ANYWAYS", c_yellow);
				trace_color("If loading the latest Frontier version without restarting this session, you will likely need to use '/load Frontier' twice for it to load the mod!", c_orange);
				trace("")
				trace_color("Press T to open NTT's chat to view this full message", c_gray)

				
				 // PAUSED!
				while(global.outdateCheck = true){
					if(button_pressed(0, "horn")){
						global.outdateCheck = false;
						trace_color("FRONTIER loading continued!", c_yellow);
						with(instances_matching(CustomObject, "name", "fr_updateSignExt")){
							sound_play_pitchvol(sndWallBreakJungle, 1, 0.4);
							repeat(10){
								with(instance_create(x, y, Dust)){
									speed		= 2 + irandom(2);
									direction	= random(360);
								}
							}
							instance_destroy();
						}
					}
					wait(0);
				}

				add_post_load_statement("UNCHARTED FRONTIER IS OUT OF DATE! Please reinstall at wigglercola.itch.io/uncharted-frontier", make_color_rgb(154, 97, 56));
				add_post_load_statement("INSTALLED: " + MODVERSION, make_color_rgb(154, 97, 56))
				add_post_load_statement("LATEST: " + _newPing, make_color_rgb(154, 97, 56))
				global.outOfDate = true;
			//} else {	add_post_load_statement("ISS ALL GOOD :)", c_green); 
			}
		}
				
    
    	// Loading Failed!
    	var tries = 0;
    	while(!mod_sideload()){
    	    wait(0)
        	tries++
        	if(tries > 150){
            	trace_color("An error has occurred while loading FRONTIER! Please try /load Frontier again or report this if the issue persists.", c_red)
            	exit;
        	}
    	}
    
    	while(fade < 1){
        	fade += current_time_scale / 20;
        	wait(0);
    	}
    	
		LoaderBarController_create(64, 64);

    	var first = [
        		"custom_options.mod.gml",
        		"custom_options_v100_patch.mod.ntgml",
        		"Frontier_Main.mod.gml",
        		"CustomIDPDHandler.mod.gml"
        	];
    
    	with(first){
        	mod_load(self)
    	}
    	progress++
    	
		 // Load Main Directory:
    	var _mainDirectory = [];
    	wait(file_find_all("", _mainDirectory))
    
    	for (var i = 0, l = array_length(_mainDirectory); i < l; i++) {
        	var n = string_replace(_mainDirectory[i].name, ".mod.gml", "");
        	if(n == mod_current || n == "custom_options" || n == "Frontier_Main" || n = "Wibbly_Loader" || n = "CustomIDPDHandler" || n = "LibLoader"){
            	_mainDirectory = array_delete(_mainDirectory, i)
            	i--
            	l--
        	}
    	}
    	
    	set_load_category("Main Files", array_length(_mainDirectory))
    	load_all(_mainDirectory)
    	
    	
		 // Load Objects:
    	var _objects = [];
    	wait(file_find_all("Objects", _objects, 0))
    	set_load_category("Objects", array_length(_objects))
    	load_all(_objects)
    	
		 // Load Areas:
    	var _areas = [];
    	wait(file_find_all("Areas", _areas, 0))
    	set_load_category("areas", array_length(_areas))
    	load_all(_areas)
    	
		 // Load Characters:
    	var subfolders = ["Characters"]
    	set_load_category("Characters", array_length(subfolders))
    	with(subfolders){
    		wait(mod_loadtext(self + "/main.txt"))
    		wait(3)
    		progress++
    	}

		 // Load Crowns:
    	var _crowns = [];
    	wait(file_find_all("Crowns", _crowns, 0))
    	set_load_category("crowns", array_length(_crowns))
    	load_all(_crowns)
    	
		 // Load Mutations:
    	var _muts = [];
    	wait(file_find_all("Mutations", _muts, 0))
    	set_load_category("mutations", array_length(_muts))
    	load_all(_muts)
    	
		 // Load Skins:
    	var _skins = [];
    	wait(file_find_all("Skins", _skins, 0))
    	set_load_category("skins", array_length(_skins))
    	load_all(_skins)
    	
		 // Load Trinkets:
    	var _trinkets = [];
    	wait(file_find_all("Trinkets", _trinkets, 0))
    	set_load_category("trinkets", array_length(_trinkets))
    	load_all(_trinkets)

 		 // Load Iris Weapons:
    	var _weps = [];
    	wait(file_find_all("Weapons/Iris Weapons", _weps, 0))
    	set_load_category("iris weapons", array_length(_weps))
    	load_all(_weps)
    	
		 // Load Weapons:
    	var _weps = [];
    	wait(file_find_all("Weapons", _weps, 0))
    	set_load_category("weapons", array_length(_weps))
    	load_all(_weps)


    	done = true
    
    	wait(10);
    	with(global.requests){
        	trace_color(str, col);
        	global.requests = []
    	}
	}
	
#define game_start
	if(fade > 0){
		fade = 0;
	}
    
#define load_all(list)
    var pauseCooldown = 0;
    with(list){
        progress++
        if ext != ".gml" || is_dir || is_data continue;
        wait(mod_load(string(path)))
        if button_check(0, "horn") && pauseCooldown <= 0 {
            trace_color("FRONTIER loading paused!", c_yellow)
            paused = true
            wait(0)
            do {
                wait(0)
                if !mod_exists("mod", mod_current) exit
            }
            until button_pressed(0, "horn")
            paused = false;
            pauseCooldown = 10;
            trace_color("FRONTIER loading resumed!", c_yellow)
        }
        pauseCooldown--
    }
    
#define array_delete(arr, index)
	// Returns an array that holds everything but the indicated index
	var b = [], _l = array_length(arr);
	if index > 0 array_copy(b, 0, arr, 0, index)
	if index != _l - 1 array_copy(b, array_length(b), arr, index + 1, _l - index)
	return b

#define add_post_load_statement(str, col)
	if(!done){
	    array_push(global.requests, {
	        "str": str,
	        "col": col
	    })
	}
    
#define set_load_category(cat, maxprogress)
    category = cat
    maxProgress = maxprogress
    progress = 0
    
#define LoaderBarController_create(_x, _y)
	with(instance_create(_x, _y, CustomObject)){
		
		on_step		= LoaderBarController_step;
		upDelay		= 10;
		lilBounce	= 5;
		
		return self;
	}
	
#define LoaderBarController_step
	if(global.done = true){
		if(upDelay > 0){
			upDelay -= current_time_scale;
		} else {
			if(lilBounce > 0){
				global.loaderHeight += (3 * current_time_scale);
				lilBounce -= current_time_scale;
			} else {
				global.loaderHeight -= (5 * current_time_scale);
			}
		}
		if(global.loaderHeight < -100){
			fade -= current_time_scale / 20;
		}
	}
    
#define draw_gui_end
    if(fade > 0){
        
        var _x = game_width / 2 - 45,
            _y = game_height / 2 - 80;
        
        var _barWidth	= 80,
        	_barHeight	= 5,
            _blockWidth = 90,
            _height 	= global.loaderHeight;
            
        draw_set_alpha(fade)
        
         // Draw Back:
    	draw_sprite(global.sprLoaderBack,	0, _x + _blockWidth / 2, _y - 34 + _height)
    	draw_sprite(global.sprLoaderBarBack, 0, _x + _blockWidth / 2, _y + 12 + _height)
    	draw_sprite(global.sprLoaderBarFront, 0, _x + _blockWidth / 2, _y + 12 + _height)
        
        if !done draw_set_font(fntSmall)
        draw_text_nt(_x, _y + 1 + _height, done ? "Done!" : "FRONTIER is loading")
        
        _y += 9
        
        if !done draw_text_nt(_x, _y + _height, paused ? "loading paused" : "loading " + category + "...")
        
        _y += 8
        _x += 8
        draw_roundrect_color_ext(_x - 8, _y + _height, _x + _barWidth, _y + _barHeight + _height, 0, 0, c_black, c_black, false)
        draw_roundrect_color_ext(_x - 8, _y + _height, _x + _barWidth * power(progress / maxProgress, 1.5), _y + _barHeight + _height, 0, 0, c_white, c_white, false)
     
        draw_set_font(fntM)
        draw_set_alpha(1)
    }

#define create_updatesigns
	with(Campfire){
		with(instance_create(x, y - 20, CustomObject)){
			name			= "fr_updateSign";
			sprite_index	= global.sprUpdateSign;
			depth			= -5;
		}
		repeat(16){
			with(instance_create(x, y - 20, Dust)){
				direction		= random(360);
				speed			= 3 + random(3);
				depth			= -6;
			}
		}
		
		with(instance_create(x + 48, y - 20, CustomObject)){
			name			= "fr_updateSignExt";
			sprite_index	= global.sprUpdateSignExt;
			depth			= -6;
		}
		
	}
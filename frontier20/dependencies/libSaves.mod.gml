/*	                Saves
	This is the Saves package of Lib, for
	anything you need to save, such as
	unlocks and settings!
	Also includes unlock functions, such as
	for the splat!
*/

/*
	Scripts:
	#define save_load(_mod, ?default)
	#define save_get(_mod, _name, ?default)
	#define save_set(_mod, _name, _value
	#define save_reset(_mod, _lwo)
	#define unlock_popup(_name, _text)
	#define unlock_splat(_name, _text, _sprite, _sound)
	#define unlock_splat_ext(_name, _gameovername, _text, _sprite, _image, _sound)
*/

//For internal use, adds the script to be easily usable.
#define addScript(name)
	lq_set(instances_matching(CustomObject, "name", "libGlobal")[0].scriptReferences, name, ["mod", mod_current, name]);

#define init
	addScript("save_load");
	addScript("save_get");
	addScript("save_set");
	addScript("save_reset");
	addScript("unlock_popup");
	addScript("unlock_splat");
	addScript("unlock_splat_ext");
	script_ref_call(["mod", "lib", "updateRef"]);
	
	while(!mod_exists("mod", "libGeneral")){wait(1);}
	script_ref_call(["mod", "libGeneral", "obj_setup"], "libSaves", "UnlockCont");
	global.saves = {};
	global.isLoaded = true;
	
#define save_load
	//(_mod, ?default)
	//_mod should be a string, default should be a lwo with all key/value pairs you want set if they are not found.
	wait(file_load(argument[0]+"Save.json"));
	while(!file_loaded(argument[0]+"Save.json")){wait(1);}
	var json = {};
	if(file_exists(argument[0]+"Save.json")){
		json = json_decode(string_load(argument[0]+"Save.json"));
	}
	if(json != json_error){
		if(argument_count == 2){
			for(var i = 0; i < lq_size(argument[1]); i++){
				if(lq_get_key(argument[1], i) not in json){
					lq_set(json, lq_get_key(argument[1], i), lq_get_value(argument[1], i));
				}
			}
		}
		save_reset(argument[0], json);
	}

#define save_get
	//(_mod, _name, ?default)
	if(argument[0] not in global.saves){
		//You really should be calling save_load first, to avoid trouble with waits, but if you don't this'll be a backup.
		save_load(argument[0]);
	}
	if(argument[0] in global.saves && argument[1] in lq_defget(global.saves, argument[0], noone)){
		return lq_get(lq_get(global.saves, argument[0]), argument[1]);
	}
	if(argument_count == 3){
		return argument[2];
	}
	return noone;
	
#define save_set(_mod, _name, _value)
	if(_mod not in global.saves){
		var save = {};
		lq_set(save, _name, _value);
		lq_set(global.saves, _mod, save);
	}else{
		lq_set(lq_get(global.saves, _mod), _name, _value);
	}
	string_save(json_encode(lq_get(global.saves, _mod)), _mod+"Save.json");
	
#define save_reset(_mod, _lwo)
	lq_set(global.saves, _mod, _lwo);
	string_save(json_encode(lq_get(global.saves, _mod)), _mod+"Save.json");
	
//This is a simplified version of unlock_splat that ONLY displays the popup.
#define unlock_popup(_name, _text)
	 // Make Sure UnlockCont Exists:
	if(!array_length(instances_matching(CustomObject, "name", "UnlockCont"))){
		script_ref_call(["mod", "libGeneral", "obj_create"], 0, 0, "UnlockCont");
	}
	
	 // Add New Unlock:
	var _unlock = {
		"nam" : [_name, _name], // [splash popup, gameover popup]
		"txt" : _text,
		"spr" : -1,
		"img" : 0,
		"snd" : 0
	};
	
	with(instances_matching(CustomObject, "name", "UnlockCont")){
		if(splash_index >= array_length(unlock) - 1 && splash_timer <= 0){
			splash_delay = 40;
		}
		array_push(unlock, _unlock);
	}
	
	return _unlock;
	
#define unlock_splat(_name, _text, _sprite, _sound)
	 // Make Sure UnlockCont Exists:
	if(!array_length(instances_matching(CustomObject, "name", "UnlockCont"))){
		script_ref_call(["mod", "libGeneral", "obj_create"], 0, 0, "UnlockCont");
	}
	
	 // Add New Unlock:
	var _unlock = {
		"nam" : [_name, _name], // [splash popup, gameover popup]
		"txt" : _text,
		"spr" : _sprite,
		"img" : 0,
		"snd" : _sound
	};
	
	with(instances_matching(CustomObject, "name", "UnlockCont")){
		if(splash_index >= array_length(unlock) - 1 && splash_timer <= 0){
			splash_delay = 40;
		}
		array_push(unlock, _unlock);
	}
	
	return _unlock;
	
//This includes all the inputs for unlock_splat
#define unlock_splat_ext(_name, _gameovername, _text, _sprite, _image, _sound)
	 // Make Sure UnlockCont Exists:
	if(!array_length(instances_matching(CustomObject, "name", "UnlockCont"))){
		script_ref_call(["mod", "libGeneral", "obj_create"], 0, 0, "UnlockCont");
	}
	
	 // Add New Unlock:
	var _unlock = {
		"nam" : [_name, _gameovername], // [splash popup, gameover popup]
		"txt" : _text,
		"spr" : _sprite,
		"img" : _image,
		"snd" : _sound
	};
	
	with(instances_matching(CustomObject, "name", "UnlockCont")){
		if(splash_index >= array_length(unlock) - 1 && splash_timer <= 0){
			splash_delay = 40;
		}
		array_push(unlock, _unlock);
	}
	
	return _unlock;

#define UnlockCont_create(_x, _y)
	/*
		Taken from TE, set up the same way to prevent problems
	*/
	
	with(instance_create(_x, _y, CustomObject)){
		 // Visual:
		depth = UberCont.depth - 1;
		
		 // Vars:
		persistent            = true;
		unlock                = [];
		unlock_sprit          = sprMutationSplat;
		unlock_image          = 0;
		unlock_delay          = 50;
		unlock_index          = 0;
		unlock_porty          = 0;
		unlock_delay_continue = 0;
		splash_sprit          = sprUnlockPopupSplat;
		splash_image          = 0;
		splash_delay          = 0;
		splash_index          = -1;
		splash_texty          = 0;
		splash_timer          = 0;
		splash_timer_max      = 150;
		
		return self;
	}
	
#define UnlockCont_step
	if(instance_exists(Menu)){
		instance_destroy();
		exit;
	}
	
	depth = UberCont.depth - 1;
	
	 // Animate Corner Popup:
	if(splash_delay > 0) splash_delay -= current_time_scale;
	else{
		var _img = 0;
		if(instance_exists(Player) || instance_exists(BackMainMenu) || instance_exists(PauseButton)){
			if(splash_timer > 0){
				splash_timer -= current_time_scale;
				
				_img = sprite_get_number(splash_sprit) - 1;
				
				 // Text Offset:
				if(splash_image >= _img && splash_texty > 0){
					splash_texty -= current_time_scale;
				}
			}
			else{
				splash_texty = 2;
				
				 // Splash Next Unlock:
				if(splash_index < array_length(unlock) - 1){
					splash_index++;
					splash_timer = splash_timer_max;
				}
			}
		}
		splash_image += clamp(_img - splash_image, -1, 1) * current_time_scale;
	}
	
	 // Game Over Splash:
	if(instance_exists(UnlockScreen)) unlock_delay = 1;
	else if(!instance_exists(Player) && !instance_exists(BackMainMenu) && !instance_exists(PauseButton)){
		while(
			unlock_index >= 0                   &&
			unlock_index < array_length(unlock) &&
			unlock[unlock_index].spr == -1
		){
			unlock_index++; // No Game Over Splash
		}
		
		if(unlock_index < array_length(unlock)){
			 // Disable Game Over Screen:
			with(GameOverButton){
				if(game_letterbox) alarm_set(0, 30);
				else instance_destroy();
			}
			with(TopCont){
				gameoversplat = 0;
				go_addy1 = 9999;
				dead = false;
			}
			
			 // Delay Unlocks:
			if(unlock_delay > 0){
				unlock_delay -= current_time_scale;
				var _delayOver = (unlock_delay <= 0);
				
				unlock_delay_continue = 20;
				unlock_porty = 0;
				
				 // Screen Dim + Letterbox:
				with(TopCont){
					visible = _delayOver;
					if(darkness){
					   visible = true;
					   darkness = 2;
					}
				}
				game_letterbox = _delayOver;
				
				 // Sound:
				if(_delayOver){
					sound_play(sndCharUnlock);
					sound_play(unlock[unlock_index].snd);
				}
			}
			else{
				 // Animate Unlock Splash:
				var _img = sprite_get_number(unlock_sprit) - 1;
				unlock_image += clamp(_img - unlock_image, -1, 1) * current_time_scale;
				
				 // Portrait Offset:
				if(unlock_porty < 3){
					unlock_porty += current_time_scale;
				}
				
				 // Next Unlock:
				if(unlock_delay_continue > 0) unlock_delay_continue -= current_time_scale;
				else for(var i = 0; i < maxp; i++){
					if(button_pressed(i, "fire") || button_pressed(i, "okay")){
						if(unlock_index < array_length(unlock)){
							unlock_index++;
							unlock_delay = 1;
						}
						break;
					}
				}
			}
		}
		
		 // Done:
		else{
			with(TopCont){
				go_addy1 = 55;
				dead = true;
			}
			instance_destroy();
		}
	}
	
#define UnlockCont_draw
	var	_vx = view_xview_nonsync,
		_vy = view_yview_nonsync,
		_gw = game_width,
		_gh = game_height;
		
	 // Game Over Splash:
	if(unlock_delay <= 0){
		if(unlock_image > 0){
			var	_unlock = unlock[unlock_index],
				_nam    = _unlock.nam[1],
				_spr    = _unlock.spr,
				_img    = _unlock.img,
				_x      = _gw / 2,
				_y      = _gh - 20;
				
			 // Unlock Portrait:
			var	_px = _vx + _x - 60,
				_py = _vy + _y + 9 + unlock_porty;
				
			draw_sprite(_spr, _img, _px, _py);
			
			 // Splash:
			draw_sprite(unlock_sprit, unlock_image, _vx + _x, _vy + _y);
			
			 // Unlock Name:
			var	_tx = _vx + _x,
				_ty = _vy + _y - 92 + (unlock_porty < 2);
				
			draw_set_font(fntBigName);
			draw_set_halign(fa_center);
			draw_set_valign(fa_top);
			
			var _t = string_upper(_nam);
			draw_text_nt(_tx, _ty, _t);
			
			 // Unlocked!
			_ty += string_height(_t) + 3;
			if(unlock_porty >= 3){
				d3d_set_fog(1, 0, 0, 0);
				draw_sprite(sprTextUnlocked, 4, _tx + 1, _ty);
				draw_sprite(sprTextUnlocked, 4, _tx,     _ty + 1);
				draw_sprite(sprTextUnlocked, 4, _tx + 1, _ty + 1);
				d3d_set_fog(0, 0, 0, 0);
				draw_sprite(sprTextUnlocked, 4, _tx,     _ty);
			}
			
			 // Continue Button:
			if(unlock_delay_continue <= 0){
				var	_cx    = _x,
					_cy    = _y - 4,
					_blend = make_color_rgb(102, 102, 102);
					
				for(var i = 0; i < maxp; i++){
					if(point_in_rectangle(mouse_x[i] - view_xview[i], mouse_y[i] - view_yview[i], _cx - 64, _cy - 12, _cx + 64, _cy + 16)){
						_blend = c_white;
						break;
					}
				}
				
				draw_sprite_ext(sprUnlockContinue, 0, _vx + _cx, _vy + _cy, 1, 1, 0, _blend, 1);
			}
		}
	}
	
	 // Corner Popup:
	if(splash_image > 0){
		 // Splash:
		var	_x = _vx + _gw,
			_y = _vy + _gh;
			
		draw_sprite(splash_sprit, splash_image, _x, _y);
		
		 // Unlock Text:
		if(splash_texty < 2){
			var	_unlock = unlock[splash_index],
				_nam    = _unlock.nam[0],
				_txt    = _unlock.txt,
				_tx     = _x - 4,
				_ty     = _y - 16 + splash_texty;
				
			draw_set_font(fntM);
			draw_set_halign(fa_right);
			draw_set_valign(fa_bottom);
			
			 // Title:
			if(_nam != ""){
				draw_text_nt(_tx, _ty, _nam);
			}
			
			 // Description:
			if(splash_texty <= 0){
				_ty += string_height(_nam + " ");
				draw_text_nt(_tx, _ty, "@s" + _txt);
			}
		}
	}
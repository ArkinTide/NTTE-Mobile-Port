/*	                Settings
	This is the Settings package of Lib, for
	EXTREMELY basic settings.
	Use this if you want people to be able to 
	change stuff in your mod but you don't
	want to spend a day doing it right.
*/

/*
	Scripts:
	#define add_setting(_modName, _variableName, _visualName)
*/

//For internal use, adds the script to be easily usable.
#define addScript(name)
	lq_set(instances_matching(CustomObject, "name", "libGlobal")[0].scriptReferences, name, ["mod", mod_current, name]);

#define init
	global.settings = [];
	global.open = 0;
	global.offset = 0;
	global.textInput = -1;
	scr = false;
	
	addScript("add_setting");
	script_ref_call(["mod", "lib", "updateRef"]);
	global.isLoaded = true;

	script_ref_call(["mod", "lib", "import"], "libMenu");
	
	script_ref_call(["mod", "lib", "getRef"], "mod", mod_current, "scr");
	
	
	/*
	global.a = 1;
	global.b = ["one", "two", "three"];
	global.c = "test";
	add_setting("libSettings", "a", "Test Variable A");
	add_setting("libSettings", "b", "Test Variable B");
	add_setting("libSettings", "c", "Test Variable C");

	add_setting("libSettings", ["mod", mod_current, "settings_menu_open"], "Open Settings Menu");
	*/
	
#macro scr global.scr
#macro call script_ref_call

#define draw_gui
	if(!instance_exists(Menu) || scr == false || array_length(global.settings) == 0){return;}
	draw_set_font(fntSmall);
	draw_set_color(c_white);
	if(call(scr.menubutton_check, game_width - 40, game_height - 6, 38, 4, 2, 1) != -1){
		draw_set_color(c_lime);
	}
	draw_text(game_width - 40, game_height - 6, "[SETTINGS]");
	draw_set_font(fntM0);
	draw_set_color(c_black);
	
	if(call(scr.menubutton_check, game_width - 40, game_height - 6, 38, 4, 0, 1) != -1){
		global.open = !global.open;
	}
	
	if(global.open){
		draw_set_color(c_white);
		var offset = global.offset;
		for(var i = 0; i < array_length(global.settings); i++){
			var v = mod_variable_get("mod", global.settings[i][1], global.settings[i][2]);
			draw_sprite(sprScoreSplat, 2, game_width/2 - 95, 42 + offset * 10);
			draw_sprite(sprScoreSplat, 2, game_width/2 - 65, 42 + offset * 10);
			draw_sprite(sprScoreSplat, 2, game_width/2 - 35, 42 + offset * 10);
			draw_sprite(sprScoreSplat, 2, game_width/2 + 25, 42 + offset * 10);
			offset++;
		}
		offset = global.offset;
		for(var i = 0; i < array_length(global.settings); i++){
			draw_set_halign(2);
			draw_text(game_width/2 + 30, 40 + offset * 10, global.settings[i][3] + " ");
			draw_set_halign(1);
			draw_text(game_width/2 + 30, 40 + offset * 10, ":");
			draw_set_halign(0);
			if is_array(global.settings[i][2]) {
				if(call(scr.menubutton_check, game_width/2 + 30, 40 + offset * 10, 60, 9, 2, 1) != -1){
					draw_set_color(c_lime);
					if(call(scr.menubutton_check, game_width/2 + 30, 40 + offset * 10, 60, 9, 0, 1) != -1){
						script_ref_call(global.settings[i][2]);
					}
				}
				draw_text(game_width/2 + 30, 40 + offset * 10, " Activate");
			} else {
				var v = mod_variable_get("mod", global.settings[i][1], global.settings[i][2]);
				if(v == true || v == false){
					if(call(scr.menubutton_check, game_width/2 + 30, 40 + offset * 10, 60, 9, 2, 1) != -1){
						draw_set_color(c_lime);
						if(call(scr.menubutton_check, game_width/2 + 30, 40 + offset * 10, 60, 9, 0, 1) != -1){
							mod_variable_set("mod", global.settings[i][1], global.settings[i][2], !v);
						}
					}
					draw_text(game_width/2 + 30, 40 + offset * 10, " " + (v ? "On":"Off"));
				}else if(is_string(v)){
					if(i == global.textInput){
						draw_set_color(c_aqua);
						if(call(scr.menubutton_check, game_width/2 + 30, 40 + offset * 10, 60, 9, 2, 1) != -1){
							draw_set_color(c_orange);
							if(call(scr.menubutton_check, game_width/2 + 30, 40 + offset * 10, 60, 9, 0, 1) != -1){
								global.textInput = -1;
							}
						}
					}else if(call(scr.menubutton_check, game_width/2 + 30, 40 + offset * 10, 60, 9, 2, 1) != -1){
						draw_set_color(c_lime);
						if(call(scr.menubutton_check, game_width/2 + 30, 40 + offset * 10, 60, 9, 0, 1) != -1){
							global.textInput = i;
						}
					}
					draw_text(game_width/2 + 30, 40 + offset * 10, " " + string(v));
				}else if(is_array(v)){
					if(call(scr.menubutton_check, game_width/2 + 30, 40 + offset * 10, 60, 9, 2, 1) != -1){
						draw_set_color(c_lime);
						if(call(scr.menubutton_check, game_width/2 + 30, 40 + offset * 10, 60, 9, 0, 1) != -1){
							var arr = [];
							for(i2 = 1; i2 < array_length(v); i2++){
								array_push(arr, v[i2]);
							}
							array_push(arr, v[0]);
							mod_variable_set("mod", global.settings[i][1], global.settings[i][2], arr);
						}
					}
					draw_text(game_width/2 + 30, 40 + offset * 10, " " + string(v[0]));
				}
			}
			draw_set_color(c_white);
			offset++;
		}
		draw_set_color(c_black);
	}
	
#define chat_message(_message, _player)
	if(global.textInput != -1){
		mod_variable_set("mod", global.settings[global.textInput][1], global.settings[global.textInput][2], _message);
		global.textInput = -1;
	}
	
#define add_setting(_modName, _variableName, _visualName)
	for(var i = 0; i < array_length(global.settings); i++) {
		if global.settings[i][0] == "mod" && global.settings[i][1] == _modName && global.settings[i][2] == _variableName && global.settings[i][3] == _visualName {
			return;
		}
	}
	array_push(global.settings, ["mod", _modName, _variableName, _visualName]);
	
#define add_setting_ext(_modName, _modType, _variableName, _visualName)
	for(var i = 0; i < array_length(global.settings); i++) {
		if global.settings[i][0] == _modType && global.settings[i][1] == _modName && global.settings[i][2] == _variableName && global.settings[i][3] == _visualName {
			return;
		}
	}
	array_push(global.settings, [_modType, _modName, _variableName, _visualName]);
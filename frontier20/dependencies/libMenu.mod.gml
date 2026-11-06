/*	                
	This is the Menu package of Lib, for
	basic functions to help with building menus
*/

/*
	Scripts:
		#define create_button(x,y,sprite,clickScr,?hoverScr,?holdScr,?pop)
		#define menubutton_check(x,y,w,h,?hold,?view,?index)
*/

//For internal use, adds the script to be easily usable.
#define addScript(name)
	lq_set(instances_matching(CustomObject, "name", "libGlobal")[0].scriptReferences, name, ["mod", mod_current, name]);

#define init
	addScript("create_button");
	addScript("menubutton_check");
	script_ref_call(["mod", "lib", "updateRef"]);
	global.isLoaded = true;
	
	wait(script_ref_call(["mod", "lib", "import"], "libGeneral"));
	
	script_ref_call(["mod", "libGeneral", "obj_setup"], "libMenu", "libButton");
	
#define create_button
//x,y,sprite,clickScr,?hoverScr,?holdScr,?pop
	var x = argument[0];
	var y = argument[1];
	var sprite = argument[2];
	var clickScr = argument[3];
	var hoverScr = noone;
	if(argument_count >= 5){
		hoverScr = argument[4];
	}
	if(argument_count >= 6){
		holdScr = argument[5];
	}
	var btn = script_ref_call(["mod", "libGeneral", "obj_create"], x, y, "libButton");
	with(btn){
		sprite_index = sprite;
		clickScr = clickScr;
		hoverScr = hoverScr;
		holdScr = holdScr;
		pop = !(argument_count >= 7 && !argument[6]);
	}
	return btn;

#define libButton_create(_x, _y)
	with(instance_create(_x, _y, CustomObject)){
		//appear above menus
		depth = UberCont.depth-1;
		sprite_index = mskNone;
		image_speed = 0;
		clickScr = script_ref_create(nilScr);
		hoverScr = script_ref_create(nilScr);
		holdScr = script_ref_create(nilScr);
		hoverIndex = 0;
		clickIndex = 0;
		holdIndex = 0;
		pop = 1;
		return self;
	}

#define libButton_step
	clickIndex = menubutton_check(x-sprite_xoffset, y-sprite_yoffset, sprite_width, sprite_height, 0);
	hoverIndex = menubutton_check(x-sprite_xoffset, y-sprite_yoffset, sprite_width, sprite_height, 2);
	holdIndex = menubutton_check(x-sprite_xoffset, y-sprite_yoffset, sprite_width, sprite_height, 1);
	if(clickIndex != -1){
		script_ref_call(clickScr, clickIndex, self);
	}
	if(hoverIndex != -1){
		script_ref_call(hoverScr, hoverIndex, self);
	}
	if(holdIndex != -1){
		script_ref_call(holdScr, holdIndex, self);
	}
	
#define libButton_draw
	if(pop){
		if(hoverIndex != -1){y-=1;}
		if(holdIndex != -1){y+=1;}
	}
	draw_self();
	if(pop){
		if(hoverIndex != -1){y+=1;}
		if(holdIndex != -1){y-=1;}
	}

#define nilScr

#define menubutton_check
//x,y,w,h,?hold,?view,?index
//returns the index of the player that pressed the button
//setting hold to 1 makes it check for holding
//setting hold to 2 makes it check for hovering
//setting view to 1 makes it work in draw_gui
	var x = argument[0];
	var y = argument[1];
	var w = argument[2];
	var h = argument[3];
	if(argument_count == 6 && argument[4] == 0 && argument[5] == 1){
		for(var i = 0; i < 4; i++){
			var mouseX = mouse_x[i]-view_xview[i];
			var mouseY = mouse_y[i]-view_yview[i];
			if(button_pressed(i, "fire") && point_in_rectangle(mouseX,mouseY,x,y,x+w,y+h)){return i;}
		}
	}else if(argument_count == 6 && argument[4] == 1 && argument[5] == 1){
		for(var i = 0; i < 4; i++){
			var mouseX = mouse_x[i]-view_xview[i];
			var mouseY = mouse_y[i]-view_yview[i];
			if(button_check(i, "fire") && point_in_rectangle(mouseX,mouseY,x,y,x+w,y+h)){return i;}
		}
	}else if(argument_count == 6 && argument[4] == 2 && argument[5] == 1){
		for(var i = 0; i < 4; i++){
			var mouseX = mouse_x[i]-view_xview[i];
			var mouseY = mouse_y[i]-view_yview[i];
			if(point_in_rectangle(mouseX,mouseY,x,y,x+w,y+h)){return i;}
		}
	}else if(argument_count == 4 || ((argument_count == 5 || argument_count == 6) && argument[4] == 0)){
		for(var i = 0; i < 4; i++){
			var mouseX = mouse_x[i];
			var mouseY = mouse_y[i];
			if(button_pressed(i, "fire") && point_in_rectangle(mouseX,mouseY,x,y,x+w,y+h)){return i;}
		}
	}else if((argument_count == 5 || argument_count == 6) && argument[4] == 1){
		for(var i = 0; i < 4; i++){
			var mouseX = mouse_x[i];
			var mouseY = mouse_y[i];
			if(button_check(i, "fire") && point_in_rectangle(mouseX,mouseY,x,y,x+w,y+h)){return i;}
		}
	}else if((argument_count == 5 || argument_count == 6) && argument[4] == 2){
		for(var i = 0; i < 4; i++){
			var mouseX = mouse_x[i];
			var mouseY = mouse_y[i];
			if(point_in_rectangle(mouseX,mouseY,x,y,x+w,y+h)){return i;}
		}
	}else if(argument_count == 7 && argument[4] == 0){
		var mouseX = mouse_x[argument[6]];
		var mouseY = mouse_y[argument[6]];
		if(argument[5] == 1){
			mouseX = mouse_x[argument[6]]-view_xview[argument[6]];
			mouseY = mouse_y[argument[6]]-view_yview[argument[6]];
		}
		if(button_pressed(argument[6], "fire") && point_in_rectangle(mouseX,mouseY,x,y,x+w,y+h)){return argument[6];}
	}else if(argument_count == 7 && argument[4] == 1){
		var mouseX = mouse_x[argument[6]];
		var mouseY = mouse_y[argument[6]];
		if(argument[5] == 1){
			mouseX = mouse_x[argument[6]]-view_xview[argument[6]];
			mouseY = mouse_y[argument[6]]-view_yview[argument[6]];
		}
		if(button_check(argument[6], "fire") && point_in_rectangle(mouseX,mouseY,x,y,x+w,y+h)){return argument[6];}
	}else if(argument_count == 7 && argument[4] == 2){
		var mouseX = mouse_x[argument[6]];
		var mouseY = mouse_y[argument[6]];
		if(argument[5] == 1){
			mouseX = mouse_x[argument[6]]-view_xview[argument[6]];
			mouseY = mouse_y[argument[6]]-view_yview[argument[6]];
		}
		if(point_in_rectangle(mouseX,mouseY,x,y,x+w,y+h)){return argument[6];}
	}
	return -1;
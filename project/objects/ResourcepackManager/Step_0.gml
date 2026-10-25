if lockstep_stop
	exit

/// @description Scroll

x = xstart
y = ystart

ypos += vspeed

if !show_details {
	if mouse_wheel_up() {
		vspeed -= (5) * timescale
		ypos -= (6) * timescale
	}
	
	if mouse_wheel_down() {
		vspeed += (5) * timescale
		ypos += (6) * timescale
	}
	
	if vspeed < -20
		vspeed = (-20) * timescale
	if vspeed > (20) * timescale
		vspeed = (20) * timescale
	
	if is_gamepad() {
		var v = (scrNTTEGamepadButton(gp_padd,keystate_hold) - scrNTTEGamepadButton(gp_padu,keystate_hold)) * 4
		
		if v == 0
			v = scrNTTEGamepadAxis(gp_axislv)
		
		if v != 0
			vspeed = (v * 8) * timescale
	}
}

if ypos < 0
	ypos = 0

if ypos > max_height
	ypos = max_height

if speed > 0
	wait = 5

if mouse_check_button_pressed(mb_left) {
	if !scroll
		speed = 0
	
	mx_last = device_mouse_x_to_gui(0)
	my_last = device_mouse_y_to_gui(0)
	
	if device_mouse_x_to_gui(0) < view_width - 32 {
		dragging = -1
	}
}

if scroll
	scroll -= timescale

if !mouse_check_button(mb_left) && dragging == -1
	dragging = false


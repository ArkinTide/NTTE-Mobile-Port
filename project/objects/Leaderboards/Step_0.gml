if lockstep_stop
	exit

if mouse_check_button_pressed(mb_left) {
    speed = 0
	
	if device_mouse_x_to_gui(0) < view_width - 32
		dragging = -1
}

if !mouse_check_button(mb_left) && dragging == -1
	dragging = false


if is_gamepad() {
	var v = (scrNTTEGamepadButton(gp_padd,keystate_hold) - scrNTTEGamepadButton(gp_padu,keystate_hold)) * 4
	
	if v == 0
		v = scrNTTEGamepadAxis(gp_axislv)
	
	vspeed = (v * 8) * timescale
}

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

ypos += lengthdir_y(speed, direction)
ypos = clamp(ypos, 0, max_height)

if (ypos <= 0 or ypos >= max_height) && speed > 0
    speed = 0

x = 0
y = 0

scr_camera_set_position(0, 0)

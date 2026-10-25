if lockstep_stop
	exit

if current_frame < start
	exit

if wait {
	wait -= timescale
	exit
}

// Back
if scrNTTEGamepadButton(gp_face2,keystate_hold) && image_index == 3 {
	event_user(0)
}

if mouse_ui_hovered(id, false) {
	if !is_gamepad() {
		if !hover {
			snd_play(sndHover)
			hover = true
		}
	}
	
	if mouse_ui_clicked() {
		event_user(0)
	}
}
else if !is_gamepad() && hover {
	hover = false
}

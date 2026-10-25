event_inherited()

if (instance_exists(MenuOptions) || UberCont.opt_keyboard) exit

if (!hold <= 0 && KeyCont.dis_fire[global.index] > 0) {
	KeyCont.dis_fire[global.index] --
}

if (vdis > dis) vdis = approach(vdis, dis, 2)

var _is_autoaim = !UberCont.opt_gamepad && self.can_full_autoaim()

if (_is_autoaim) {
    with(scrPlayerFindLocal()) scrJoyAim(other.rad);
}

if (UberCont.opt_gamepad) exit

var i = get_nearest_touch(rad)

// reset attack
KeyCont.hold_fire[global.index] = 0
KeyCont.press_fire[global.index] = 0
KeyCont.release_fire[global.index] = 0

if (index == -1) index = i

if UberCont.opt_hiddensticks {
	image_alpha = lerp(image_alpha, (index != -1) * 0.2, 0.4)
}

if (!_is_autoaim) {
	if (self.is_player_crystaltb() && KeyCont.moving[global.index] != 0) {
		var _max = min(view_width, view_height) * 0.5,
			_dis = _max * KeyCont.moving[global.index]
		
		KeyCont.dir_fire[global.index] = KeyCont.dir_move[global.index]
		KeyCont.dis_fire[global.index] = _dis
		
		vdis = _dis
	}
	else if (index != -1) {
        var mx = device_mouse_x_to_gui(index),
			my = device_mouse_y_to_gui(index),
			mdis = min(rad, point_distance(x, y, mx, my))

        dir = point_direction(x, y, mx, my)
		
		if (self.is_player_crystaltb()) {
			dis = min(view_width, view_height) * (mdis / rad) * 0.5
		}
		else {
			dis = min(rad, mdis) * 2
		}
		
        KeyCont.dir_fire[global.index] = dir
        KeyCont.dis_fire[global.index] = dis
		
        // note: press & release are swapped intentionally
		if ((dis / rad) > ATTACK_BUTTON_DEADZONE && !UberCont.opt_splitfire) {
			KeyCont.hold_fire[global.index] = true
			
	        if (device_mouse_check_button_pressed(index, mb_left)) {
				KeyCont.release_fire[global.index] = true
			}
			
	        if (device_mouse_check_button_released(index, mb_left)) {
				KeyCont.press_fire[global.index] = true
			}
		}
		
        if (!device_mouse_check_button(index, mb_left) || (distance_to_point(mx, my) > rad * 3)) {
            index = -1
        }
		
        vdis = lerp(vdis, dis, mdis / rad * 0.4)
		
        hold = 30
    }
	else {
        dis = 0

        if (!hold) {
            if (vdis > 0) vdis -= timescale
        }
		else hold --
    }
}
else {
	index = -1
	dis = 0
	
	if !UberCont.opt_splitfire && i != -1 {
		var mx = device_mouse_x_to_gui(i),
			my = device_mouse_y_to_gui(i)
		
		dis = min(rad, point_distance(x, y, mx, my))
		
		KeyCont.hold_fire[global.index] = device_mouse_check_button(i, mb_left)
		KeyCont.press_fire[global.index] = device_mouse_check_button_pressed(i, mb_left)
		KeyCont.release_fire[global.index] = device_mouse_check_button_released(i, mb_left)
		
		index = i
	}
}

scrControlAutoSnare()

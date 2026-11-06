function scrJoyAim(_move_radius=32) {
    if(!scrNTTEFullAutoAimAllowed(id) || clicked) return;
var _target = scrNTTENearestAimEnemy(x,y,team)

        if (!scrNTTEAimTargetAllowed(aimbot_target,team)) aimbot_target=noone
		
		if (instance_exists(_target) && instance_exists(aimbot_target)) {
			var _dir = point_direction(x, y, aimbot_target.x, aimbot_target.y),
				_dir2 = point_direction(x, y, _target.x, _target.y),
			
			if (abs(angle_difference(_dir, gunangle)) >= abs(angle_difference(_dir2, gunangle))) {
				_target = aimbot_target
			}
		}
		
        if (instance_exists(NothingInactive)) {
            _target = instance_nearest(x, y, NothingInactive)

            if (instance_exists(_target) && !_target.active) {
                _target = noone
			}
        }
		else if (instance_exists(LastIntro)) {
            _target = instance_nearest(x, y, LastIntro)
        }
		else if (distance_to_object(BigGenerator) <= 32) {
            _target = instance_nearest(x, y, BigGenerator)
        }
		
        var _dir = -1, _area = min(view_width, view_height) * 0.4

        if (scrTargetIsVisible(_target)) {
            var _tx = _target.x,
				_ty = _target.y
			
			var _dis = point_distance(x, y, _tx, _ty),
				_dir = point_direction(x, y, _tx, _ty)
			
			KeyCont.dis_fire[index] = min(_dis, _area)
        }
		else {
			var _rotspeed = (race == Race.Steroids || scr_weapon_is_melee(wep) || scr_weapon_is_auto(wep) || can_shoot) ? 0.5 : 0.1
			
			_dir = angle_lerp(KeyCont.dir_fire[index], KeyCont.dir_move[index], _rotspeed)
			KeyCont.dis_fire[index] = _move_radius * KeyCont.moving[index] * 2
			
			if (crosshair_alpha > 0.5) {
				crosshair_alpha = 0.5
			}
		}
		
        if (_dir != -1) {
            KeyCont.dir_fire[index] = angle_lerp(KeyCont.dir_fire[index], _dir, 0.75)
		}
		
		if (!scrNTTEAimTargetAllowed(_target,team)) _target=noone
		aimbot_target = _target
}

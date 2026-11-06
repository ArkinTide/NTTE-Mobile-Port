if lockstep_stop
	exit

var _force_snap = false

if (force_snap_camera_position) {
	force_snap_camera_position = false
	_force_snap = true
}

if (!scrGameIsGenerationScreen() && !instance_exists(GameOver)) {
    if instance_exists(Cinematic) {
        with (Cinematic) {
            // 相机平滑系数按逻辑帧折算（30 帧 ts=1 → 恒等于原 0.1）
            var _cm = 1 - power(1 - 0.1, timescale)
            view_xview = round(lerp(view_xview, (x - view_width / 2), _cm))
            view_yview = round(lerp(view_yview, (y - view_height / 2), _cm))
            // 同步浮点累加器
            BackCont.viewxf = view_xview
            BackCont.viewyf = view_yview
        }
		
        camera_set_view_pos(view_camera, view_xview, view_yview)
		
        exit
    }
	
	var _dir = 0,
		_dis = 0,
		_dir2 = 0,
		_dis2 = 0,
		_poi = noone,
		_viewdist = 4
    var _ntte_camera_focus=scrNTTEFullValue(id,"ntte_full_view_object",noone);
    var _ntte_camera_pan=scrNTTEFullValue(id,"ntte_full_view_pan_factor",undefined);
	
    /**/ if instance_exists(Portal) _poi = Portal
    else if instance_exists(BecomeNothing) _poi = BecomeNothing
    else if instance_exists(BecomeNothing) _poi = Nothing2Appear
    else if instance_exists(NothingDeath) _poi = NothingDeath
    else if instance_exists(Nothing2Death) _poi = Nothing2Death
    else if instance_exists(SitDown) _poi = SitDown
	
	if instance_exists(TutCont) && instance_exists(WeaponChest) {
		_poi = WeaponChest
	}

    with Player if (index == global.index) {
        if scr_weapon_is_melee(wep) {
			_viewdist = 8
		}
		else if scr_weapon_get_type(wep) == Ammo.Bolts {
			_viewdist = 3
		}
		
	    if(instance_exists(_ntte_camera_focus) && !is_undefined(_ntte_camera_pan)) _viewdist=_ntte_camera_pan;
	    if instance_exists(_poi) {
	        var _instance = instance_nearest(x, y, _poi)
	        _dis = point_distance(x, y, _instance.x, _instance.y) / 6
	        _dir = point_direction(x, y, _instance.x, _instance.y)
			
	        if (_poi == Portal || instance_is(_poi, WeaponChest)) {
	            _dis = min(_dis, 72)
	        }
	    }
		
	    if !UberCont.localcoop {
	        _dir2 = KeyCont.dir_fire[index]
			
	        if UberCont.opt_gamepad {
	            var gpx = scrNTTEGamepadAxis(gp_axisrh)
	            var gpy = scrNTTEGamepadAxis(gp_axisrv)
	            _dis2 = (point_distance(0, 0, gpx, gpy) * 72) / _viewdist
	        }
			else if UberCont.opt_keyboard {
	            //_dis2 = point_distance(x, y, mouse_x, mouse_y) / _viewdist
				_dis2 = KeyCont.dis_fire[index] / _viewdist
	        }
			else if instance_exists(JoystickAttack) && !save_get_value("contorls", "aimbot", 0) {
	            _dir2 = KeyCont.dir_fire[index]
	            _dis2 = JoystickAttack.vdis / _viewdist
	        }
	    }
		
		var _sx = ldrx(_dis, _dir) + ldrx(_dis2, _dir2),
			_sy = ldry(_dis, _dir) + ldry(_dis2, _dir2)
		
		if (UberCont.opt_shake > 0) {
			var _shake = other.shake * UberCont.opt_shake
			// 抖动重采样门控到 30Hz 逻辑帧（30 帧恒真 → 逐字节不变）
			if (current_frame_active) {
				other.shake_ox = orandom(_shake)
				other.shake_oy = orandom(_shake)
			}
			_sx += other.shake_ox
			_sy += other.shake_oy
		}
		
		if (_force_snap) {
			_sx = 0
			_sy = 0
			other.viewx2 = 0
			other.viewy2 = 0
		}
		else if (bleed) {
			var _any = false
			
			with (ChickenHead) if (index == other.index) {
				_any = true
				// 同①（30 帧 ts=1 → 恒等于原 0.5）
				var _bm = 1 - power(1 - 0.5, timescale)
				view_xview = lerp(view_xview, x - view_width * 0.5, _bm)
				view_yview = lerp(view_yview, y - view_height * 0.5, _bm)
				// 同步浮点累加器
				BackCont.viewxf = view_xview
				BackCont.viewyf = view_yview
				break
			}
			
			if (!_any) break
		}
		
		// 主路径平滑系数（30 帧 ts=1 → 恒等于原 0.4）
		// ⛔ 曾改为「按 30Hz 逻辑帧更新」，但那会让相机**每 2 帧才动一次**，
		// 而玩家每帧都在动 → 快速移动（翻滚 / water boost）时**画面明显抽搐**（实测）。
		var _m = _force_snap ? 1 : (1 - power(1 - 0.4, timescale))
		var _tx = (instance_exists(_ntte_camera_focus)?_ntte_camera_focus.x:x) - view_width * 0.5 + other.viewx2 + _sx
		var _ty = (instance_exists(_ntte_camera_focus)?_ntte_camera_focus.y:y) - view_height * 0.5 + other.viewy2 + _sy
		// 60/120 帧改用「浮点累加 + 输出取整」。
		// 原因：_m 折算后每帧增量 < 0.5px，round() 会吃掉增量并反馈回累加器
		// → 相机进入「死区」永远不动（模拟实测 mean|Δy|=0.00）→ 抖动完全看不见（F21）。
		// 30 帧 ts=1 → 走原路径，逐字节不变。
		if (timescale >= 1) {
			view_xview = round(lerp(view_xview, _tx, _m))
			view_yview = round(lerp(view_yview, _ty, _m))
		}
		else {
			// 安全网：与当前实际相机偏差过大（房间切换 / 外部改写）时直接重同步
			if (abs(BackCont.viewxf - view_xview) > 32 || abs(BackCont.viewyf - view_yview) > 32) {
				BackCont.viewxf = view_xview
				BackCont.viewyf = view_yview
			}
			BackCont.viewxf = lerp(BackCont.viewxf, _tx, _m)
			BackCont.viewyf = lerp(BackCont.viewyf, _ty, _m)
			view_xview = round(BackCont.viewxf)
			view_yview = round(BackCont.viewyf)
		}
	}
}

// 回弹偏移衰减（30 帧 ts=1 → 恒等于原 *0.6）
viewx2 = round(viewx2 * power(1 - 0.4, timescale))
viewy2 = round(viewy2 * power(1 - 0.4, timescale))

if UberCont.opt_shake <= 0 {
    shake = 0
    viewx2 = 0
    viewy2 = 0
}

if shake > 10 {
    shake *= power(0.8, timescale)
}
else if shake > 0 {
    // 按 30Hz 逻辑帧结算（30 帧恒真 → 逐字节不变）。
    // 原因：抖动偏移用的是「衰减前」的 shake，而每帧衰减量 = timescale（60 帧 = 0.5）
    // → 60 帧的偏移基数比 30 帧小 0.5（实测 mean_abs 1.50 vs 2.02）→ 抖动偏弱。
    if (current_frame_active) shake -= 1
    if shake <= 0 {
        shake = 0
    }
}

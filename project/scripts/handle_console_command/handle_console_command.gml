function handle_console_command(str) {
	if instance_exists(CoopController) && !CoopController.event_run {
		
		scr_network_attach_event_data("other", "console", str)
		
		exit
	}
	
    var cmdraw = string_split_array(str, " ")
    var cmd = string_split_array(string_lower(str), " ")

    var args = []

    if array_length(cmd) {
        array_copy(args, 0, cmd, 1, array_length(cmd))
    }

    var commands = scr_console_commands()

    if command_binding {
        scr_log_push("Bound \"" + str + "\" to \"P\"", c_yellow)
        scr_log_push("Press RMB to discard bind", c_gray)

        bound_command = str
        command_binding = false

        return undefined
    }

    try {
        switch cmd[0] {
            case "help":
                scr_log_push("All commands available:", c_yellow)

                var names = struct_keys(commands)
                array_sort(names, true)

                for (var i = 0; i < array_length(names); i++) {
                    var name = names[i]
                    print(name + " - " + variable_struct_get(commands, name))
                }
                break

            case "spawn":
                var o = scrParseSpawn(cmd)

                if object_exists(o) {
                    var c = array_length(cmd) > 1 ? real(cmd[1]) : 1
                    var _x = 10016
                    var _y = 10016

                    if is_desktop && !instance_exists(CoopController) {
                        _x = mouse_x
                        _y = mouse_y
                    }

                    if o == Player {
                        with scrPlayerCreate(global.index, c, GameCont.bskin) {
                            x = 10016
                            y = 10016

                            visible = 1
                            wep = race_swep[c]
                        }

                        break
                    }

                    repeat c {
                        instance_create(_x, _y, o)
                    }
                } else scr_log_push("Cannot create given object", c_red)
                break

            case "lvl":
                GameCont.rad += 9990
                break

            case "reload":
                discard_custom_sprites(true)
                discard_custom_sounds()
                load_resourcepacks()
                break

            case "rads":
            case "rad":
                GameCont.rad += real(args[0])
                break
			
			case "intro":
			case "bossintro":
				scrBossIntro(real(args[0]))
				break
			
			case "unlockscreen":
				scrUnlockScreenCreate(irandom_range(1, 15), 1)
				break
			
            case "mut":
            case "skill":
                var s = scrContentIdByName(args, skill_name)

                if s {
                    scr_skill_set(s, !scr_skill_get(s))
                } else scr_log_push("Unknown mut given", c_red)
                break

            case "killall":
                instance_destroy(enemy, false)
                instance_destroy(prop, false)
                instance_destroy(projectile, false)
                instance_destroy(Portal, false)
				instance_destroy(IDPDSpawn, false)
				instance_destroy(VanSpawn, false)
				
				// restore player's sprite after killing the portal
                with Player {
                    if mask_index == mskPlayer continue
					
                    angle = 0
                    mask_index = mskPlayer
                    sprite_index = spr_idle
                    image_index = 0
                    visible = 1
                }
                break

            case "wep":
            case "weapon":
            case "gun":
                var i = scrContentIdByName(args, wep_name)

                if i != -1 {
                    with Player {
                        ammo[scr_weapon_get_type(i)] = typ_amax[scr_weapon_get_type(i)]

                        var _w = variable_instance_get(id, "_debuglastwep")

                        if wep == _w or !bwep {
                            bwep = i
                        } else wep = i

                        variable_instance_set(id, "_debuglastwep", i)

                        if reload reload = 1
                    }
                } else print("Failed to find given weapon")
                break

            case "nodeath":
            case "nd":
                with Player {
                    can_die = !can_die

                    print(can_die ? "You can now become dead" : "You can no longer become dead")
                }
                break

            case "goto":
            case "area":
                with Player {
                    var m = string_split_array(cmd[1], "-")

                    GameCont.route = 0

                    if string_copy(cmd[1], 1, 2) == "hq" {
                        m[0] = 106
                        m[1] = real(string_delete(cmd[1], 1, 2))
                    } else if cmd[1] == "???"
                    or cmd[1] == "vault" {
                        m[0] = 100
                        m[1] = 1
                    } else if m[1] == "?" {
                        m[0] = 100 + m[0]
                        m[1] = 1
                    } else if m[0] == "hq" {
                        m[0] = 106
                        m[1] = real(m[1])
                    } else if string_count("b", m[0]) {
                        m[0] = string_replace_all(m[0], "b", "")

                        GameCont.route = 1

                        m[0] = real(m[0])
                        m[1] = real(m[1])
                    } else {
                        m[0] = real(m[0])
                        m[1] = real(m[1])
                    }


                    GameCont.area = m[0]
                    GameCont.subarea = m[1] - 1

                    if m[0] % 2 == 0 && m[0] < 100 && m[0] != 106 {
                        GameCont.area = m[0] - 1
                        GameCont.subarea = GameCont.maxsubarea
                    }

                    with GameCont {
                        hard = subarea - 1

                        if area == 0 hard += 0
                        else if area == 1 hard += 1
                        else if area == 2 hard += 3
                        else if area == 3 hard += 4
                        else if area == 4 hard += 7
                        else if area == 5 hard += 8
                        else if area == 6 hard += 11
                        else if area == 7 hard += 12
                        else if area == 100 hard += 6
                        else if area == 101 hard++
                        else if area == 102 hard += 4
                        else if area == 103 hard += 5
                        else if area == 104 hard += 7
                        else if area == 105 hard += 10
                        else if area == 106 hard++
                    }

                    print("Teleporting to " + string(GameCont.area) + "-" + string(GameCont.subarea) + " L" + string(GameCont.loops) + " h: " + string(GameCont.hard))

                    if array_length(cmd) > 2 {
                        GameCont.loops = real(string_replace(cmd[2], "l", ""))
                        GameCont.hard += (GameCont.loops * 16)
                    }
					else GameCont.loops = 0

                    with instance_create(x, y, Portal) {
                        sprite_index = sprPortalDisappear
                        event_perform(ev_other, ev_animation_end)
                    }

                    break
                }
                break

            case "instgen":
                if (flags & 2) == 2 {
                    flags ^= 2
                } else flags |= 2
                break
			
            case "instances":
                if (flags & 4) == 4 {
                    flags ^= 4
                } else flags |= 4
                break

            case "overlay":
                if (flags & 8) == 8 {
                    flags ^= 8
                } else flags |= 8
                break

            case "clear":
                global.log_output = []
                global.log_color = []
                break

            case "mobile":
				
                with UberCont {
					opt_keyboard = !opt_keyboard
					save_set_value("options", "keyboard", opt_keyboard)
					
					print(opt_keyboard ? "Disabled mobile controls" : "Enabled mobile controls")
				}
				
                break

            case "restart":
                with UberCont
                want_restart = 1
                break

            case "reset":
                game_restart()
                break
			
			case "fps":
                game_set_speed(real(args[0]), gamespeed_fps)
                break

            case "seed":
                if args[0] == "none"
                or args[0] == "null"
                or args[0] == "0" {
                    print("Seed has been reset.")

                    break
                }

                try {
                    Console.seed = real(args[0])
                    print("Seed set to " + string(Console.seed))
                }
                catch (e) {
                    scr_log_push("Bad value given.", c_red)
                }
                break

            case "close":
                global.console_active = 0
                break

            case "load":
            case "loadmod":
                print(":^) hehe")
                break

            case "exportsprites":
                var p = game_directory + "exportsprites"

                if !directory_exists(p) directory_create(p)

                p += "/"

                for (var i = 0; sprite_exists(i); i++) {
                    sprite_strip_save(i, p + sprite_get_name(i) + ".png")
                }

                print("Exported", i, "sprites")
                break

            case "hard":
                print("Current difficulty:", GameCont.hard)
                break
			
			case "option":
				try {
					UberCont.saveData[? cmd[0]] = real(cmd[1])
					print("real")
					scrOptionsUpdate()
				}
				catch(e) {
					UberCont.saveData[? cmd[0]] = cmd[1]
					scrOptionsUpdate()
				}
				
				break
			
            // debugclear（简写 dear）= 一条指令：重置所有调试状态 + 重载当前关卡。
            // 目的：清掉「运行中切 30/60 帧」烘焙在实例上的旧 speed/friction（2-O 现象），让测试从干净状态开始。
            // ⚠️ 重载「同一关」**不需要动种子**：关卡布局由 scrRngStatesReset() 从 global.seed 派生，
            //    只要不改变 global.seed 与 area/subarea/loops，重新加载就是同一关 —— 这正是 GM debug 面板
            //    「Goto」按钮的做法（见 scr_create_debug_overlay_views.gml 的 __area_transit_button）。
            case "debugclear":
            case "dear":
                // ★ 只允许在「真正在跑一局」时使用。
                // 否则（主菜单 / 篝火选人 / 暂停页）会出事（实测三种）：
                //   ① 主菜单：`Portal/Create_0` 第 5 行读 `GameCont.underwater`，而 GameCont 不存在 → **直接崩溃**。
                //   ② 篝火选人：没有 Player → 坐标快照成 (0,0) → 开局后被传到 (0,0)（且关卡变 1-0）。
                //   ③ 暂停页：Portal 建出来了但房间不重载 → 标记残留 → 之后新开一局被传到 (0,0)。
                if (!instance_exists(GameCont) || !instance_exists(Player)
                    || scrGameIsPaused() || UberCont.want_pause) {
                    print("debugclear: only works while playing a level (not in menus / paused).")
                    break
                }

                if (variable_global_exists("debugclear_restore") && global.debugclear_restore != undefined) {
                    print("debugclear: already in progress.")
                    break
                }

                // ① 快照「要保留」的东西：武器 + 当前坐标
                //    （血量按用户要求自然重置；变异存在 GameCont.skills 里、GameCont 跨重载保留 → 自动保留）
                var _dc_wep = -1, _dc_bwep = -1, _dc_x = 0, _dc_y = 0
                if (instance_exists(Player)) {
                    _dc_wep = Player.wep
                    _dc_bwep = Player.bwep
                    _dc_x = Player.x
                    _dc_y = Player.y
                }

                // ② 第一次重置：调试参数 + **帧率固化**（传送前，见 scr_console_debug_reset）
                scr_console_debug_reset()
                Console.flags = 0

                // ③ 记下待还原数据 —— 交给 GenCont/Alarm_1（关卡定稿）在把玩家摆到出生点**之后**还原。
                //    这样就不再需要「每帧轮询 / 等关卡就绪」那套脆弱的状态机（实测它会永久卡住）。
                global.debugclear_restore = {
                    x: _dc_x, y: _dc_y, wep: _dc_wep, bwep: _dc_bwep,
                }

                // ④ 重载当前关卡：与 GM debug 面板「Goto」完全相同的传送通路（不碰 global.seed）
                with (GameCont) {
                    is_level_ended = false
                    can_advance_stage = false
                }
                with instance_create(_dc_x, _dc_y, Portal) {
                    sprite_index = sprPortalDisappear
                    event_perform(ev_other, ev_animation_end)
                }

                print("debugclear: reloading current level (seed " + string(global.seed) + ")")
                break

            default:
                return 1
        }
    } catch (e) {
        scr_log_push("Console exception: " + e.message, c_red) show_debug_message(e.longMessage)
    }
}

// console 调试状态统一重置入口（`dear`/`debugclear` 自动调用）。
// 职责：① 按定义重算「帧率固化」；② **进入冷静期**（`global.debugclear_cooldown = 60`）。
// 设计原则（重要）：冷却状态是独立全局（`global.debugclear_cooldown`），
// 不依赖、也不反向引用任何临时调试代码的变量。
// 
function scr_console_debug_reset() {
	// ① 重置「帧率固化」——**按定义重算**（重新执行当初设置这些量的算式），不是按比例硬掰。
	//
	// 被固化的量 = 「只在创建时算一次、之后不再重算」的 × timescale 属性；
	// 之所以固化，是因为持有它们的对象是 **persistent**，关卡重载（room_restart）与原版 Retry
	// 都不会重建它们（只有回主菜单 scrCleanupSessionInstances() 会）。
	//
	// 已排查：全部持久对象里，被 × timescale 且「只算一次」的只有下面这三处；
	// 其余（Credits/MusCont/UberCont/Draw_*/GameCont/SkillText/Revive/… ）都是每帧 +=/-= 重算，不会固化。
	with (Player) {
		// 种族基础 maxspeed（定义见 scrPlayerRaceChange） + extra feet 技能加成（定义见 scrSkills）
		var _base = 4
		if (race == Race.Plant) _base = 4.5
		else if (race == Race.BigDog) _base = 2
		else if (race == Race.Skeleton) _base = 3

		maxspeed = (_base + 0.5 * footextra) * timescale
		image_speed = (0.4) * timescale

		if (speed > maxspeed) speed = maxspeed
	}
	with (CrownObject) image_speed = (0.4) * timescale
	with (ClusterNade) knockback_speed = (10) * timescale

	// 进入**冷静期**（60 逻辑帧 ≈ 2 秒）：左上角显示倒计时小字；归零即「可以开始测数据」。
	global.debugclear_cooldown = 60
}

// debugclear 的「还原」步骤。
// **由关卡定稿处调用**（`GenCont/Alarm_1`，以及走升级界面时的 `LevCont/Create_0`），
// 而**不是**每帧轮询 —— 轮询需要「猜」关卡何时就绪，实测会永久卡在 "already in progress"。
//
// 为什么挂在 GenCont/Alarm_1：
//   该事件里有一句 `with (Player) { x = 10016; y = 10016 }`（把玩家摆到出生点）——
//   这就是「debugclear 后位置没还原」的真凶。在它**之后**还原坐标，才不会被它覆盖。
function scr_console_debugclear_restore() {
	if (!variable_global_exists("debugclear_restore") || global.debugclear_restore == undefined) return

	var _r = global.debugclear_restore
	global.debugclear_restore = undefined

	with (Player) {
		x = _r.x
		y = _r.y
		xprevious = x
		yprevious = y

		// 传送/重载期间攒下的速度一并清掉：否则会在「落地后」继续滑行
		// （实测：速度越快、偏离越远 —— 正是旧速度没清造成的）。
		speed = 0
		hspeed = 0
		vspeed = 0

		if (is_me) scr_camera_set_position(x, y, fa_center, fa_middle)

		if (scr_weapon_is_valid(_r.wep)) {
			wep = _r.wep
			ammo[scr_weapon_get_type(wep)] = typ_amax[scr_weapon_get_type(wep)]
		}
		if (scr_weapon_is_valid(_r.bwep)) {
			bwep = _r.bwep
			ammo[scr_weapon_get_type(bwep)] = typ_amax[scr_weapon_get_type(bwep)]
		}
	}

	// 传送后再重置一次：消除关卡重载本身带来的数值偏差（幂等，不会重复缩放）。
	scr_console_debug_reset()

	print("debugclear: done (teleported to " + string(_r.x) + ", " + string(_r.y) + ")")
}

// console 命令表（help 与「命令补全」共用；static = 只建一次）。
// ⚠️ 这里要**列全**所有 `switch` 里能命中的命令（含别名），否则 help 里看不到、补全也补不出来
//    （实测：`goto` 没补全 —— 就是漏在这张表里）。
function scr_console_commands() {
	static _table = {
		help: "Definitely helps you",
		wep: "Gives you a weapon",
		weapon: "Alias of wep",
		gun: "Alias of wep",
		spawn: "Spawns something at start coordinates",
		mut: "Grants you mutation",
		skill: "Alias of mut",
		rads: "Gain some rads",
		rad: "Alias of rads",
		lvl: "Instantly reach level ultra",
		area: "Transit to some area",
		goto: "Alias of area",
		instgen: "Instantenious generation flag",
		killall: "Kills everyone and everything while also preventing portal from spawn",
		mobile: "Enable/disable mobile mode",
		restart: "Restart the run",
		reset: "Reset the game",
		nodeath: "Disable death",
		nd: "Alias of nodeath",
		reload: "Reload all resourcepacks",
		seed: "Set seed, works properly after restart",
		instances: "Display list of existing instances",
		overlay: "Toggle debug overlay",
		clear: "Clear console log",
		close: "Close the console",
		fps: "Set game speed (fps)",
		hard: "Show current difficulty",
		debugclear: "DEBUG: reset all debug state and reload the current level (same seed)",
		dear: "Alias of debugclear"
	}

	return _table
}

// 命令补全：返回当前输入行「正在编辑的那一段」的可能补全项。
//  - 第 1 个词  → 命令名（scr_console_commands 的 key）
//  - spawn 参数 → 对象名；**注意**：scrParseSpawn 是把 "spawn" 之后所有词**拼成一个名字**，
//                所以这里也要用「拼接后的整段」去匹配（否则 `spawn big por` 会错配出 PortalClear 等）
//  - wep / mut 参数 → 武器名 / 变异名（只取最后一个词）
// 前缀匹配、不区分大小写。
// ⚠️ **保留**与输入段完全相等的候选 —— 否则「刚好打完」时该条会消失、永远选不到（实测）。
function scr_console_completions(_input) {
	var _out = []
	if (!is_string(_input)) return _out

	var _trimmed = string_trim(_input)

	// 空输入 → 不弹候选（这样 ↑↓ 才能用来翻历史）
	if (_trimmed == "") return _out

	var _fsp = string_pos(" ", _trimmed),
		_is_first = (_fsp == 0),
		_head = _is_first ? "" : string_lower(string_copy(_trimmed, 1, _fsp - 1))

	// 要匹配的前缀
	var _prefix = ""
	if (_is_first) {
		_prefix = string_lower(_trimmed)
	}
	else if (_head == "spawn") {
		_prefix = string_lower(string_replace_all(string_delete(_trimmed, 1, _fsp), " ", ""))
	}
	else {
		var _lastsp = _fsp
		for (var _i = string_length(_trimmed); _i >= 1; _i--) {
			if (string_char_at(_trimmed, _i) == " ") { _lastsp = _i; break }
		}
		_prefix = string_lower(string_delete(_trimmed, 1, _lastsp))
	}

	// 候选池
	var _pool = []
	if (_is_first) {
		_pool = struct_get_names(scr_console_commands())
	}
	else {
		switch (_head) {
			case "spawn":
				if (!variable_global_exists("_console_instance_names")) scrParseSpawn([""])
				_pool = struct_get_names(global._console_instance_names)
				break

			case "wep":
			case "weapon":
			case "gun":
				for (var _i = 0; _i < array_length(wep_name); _i++) array_push(_pool, scr_weapon_get_name(_i))
				break

			case "mut":
			case "skill":
				for (var _i = 0; _i < array_length(skill_name); _i++) array_push(_pool, skill_name[_i])
				break

			// `goto` / `area` 的参数补全：
			// 语法是 `<区域>-<子区>`（1 基，见 goto 的解析：subarea = m[1] - 1），
			// 所以候选直接给「区域-子区」对；另加 hqN / vault / ???。
			case "goto":
			case "area":
				var _areas = [0, 1, 2, 3, 4, 5, 6, 7, 100, 101, 102, 103, 104, 105, 106, 107]
				for (var _ai = 0; _ai < array_length(_areas); _ai++) {
					var _ar = _areas[_ai],
						_nsub = scrAreaGetMaxSubarea(_ar)
					for (var _si = 1; _si <= _nsub; _si++) array_push(_pool, string(_ar) + "-" + string(_si))
				}
				for (var _si = 1; _si <= 3; _si++) array_push(_pool, "hq" + string(_si))
				array_push(_pool, "vault")
				array_push(_pool, "???")
				break
		}
	}

	for (var _i = 0; _i < array_length(_pool); _i++) {
		var _c = string_lower(string(_pool[_i]))
		if (_c == "") continue
		if (string_starts_with(_c, _prefix)) array_push(_out, _pool[_i])
	}

	array_sort(_out, true)
	return _out
}
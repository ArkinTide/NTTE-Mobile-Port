if lockstep_stop
	exit

if enemy_test && instance_exists(GameCont) {
	if instance_exists(enemy) {
		var fine = false;
		
		if GameCont.loops {
			enemy_number += instance_number(enemy) + instance_number(MeleeFake)
			enemy_count ++
			
			fine = true
		}
		
		room_speed = 120
	
		GameCont.area = 1
		GameCont.subarea = 0
		GameCont.hard = 16
		GameCont.loops = 1
		
		global.seed = randomize()
		GameCont.seed = global.seed
		
		with instance_create(Player.x, Player.y, Portal) {
			sprite_index = sprPortalDisappear
			event_perform(ev_other, ev_animation_end)
		}
		
		GameCont.rad = 0
		
		var types = {}
		
		with enemy {
			var n = object_get_name(object_index)
			
			if types[$ n] == undefined
				types[$ n] = 0
			
			types[$ n] ++
		}
		
		if types[$ "MeleeBandit"] != undefined
			types[$ "MeleeBandit"] += instance_number(MeleeFake)
		
		if fine {
			var names = variable_struct_get_names(types);
	
			for(var i = 0; i < array_length(names); i ++) {
				var name = names[i];
			
				var c = variable_struct_get(enemy_species, name),
					a = variable_struct_get(types, name)
			
				if c == undefined c = 0
				if a == undefined a = 0
			
				variable_struct_set(enemy_species, name, c + a)
			}
		
			names = variable_struct_get_names(enemy_species);
		
			for(var i = 0; i < array_length(names); i ++) {
				print(names[i] + ": " + string(variable_struct_get(enemy_species, names[i]) / enemy_count))
			}
			
			print("#" + string(enemy_count), " Average: ", enemy_number / enemy_count)
		}
	}
}

// 开关 console 的键（`~` / 反引号）本身会往 keyboard_string 里塞一个字符，
// 它不该出现在输入行里 —— 每次开关时把末尾的这个字符去掉（实测：否则每次开都会多一个 "`"）。
if (open || keyboard_check_pressed(vk_tilde)) {
	var _kc = string_char_at(keyboard_string, string_length(keyboard_string))
	if (_kc == "`" || _kc == "~") {
		keyboard_string = string_delete(keyboard_string, string_length(keyboard_string), 1)
	}
}

// Android 软键盘输入（洗掉换行/首尾空白）——
// ⚠️ 必须在下面「暂存 pending_input」**之前**算出来：否则会把 IME 残留的 "\n" 一起存进 pending_input。
var _ai_raw0 = keyboard_string
var _ai_raw = string_replace_all(string_replace_all(_ai_raw0, "\n", ""), "\r", "")
_ai_raw = string_trim(_ai_raw)

// 打开期间持续把「未按回车提交」的输入同步到 pending_input，
// 这样无论从哪条路关闭（~ / ESC / Android 返回键 / close 命令），输入都已存好、不会丢。
// ⚠️ 存的是**去掉换行**的版本：Android 软键盘的 Enter 会往 keyboard_string 里塞 "\n"；
//    若把带 "\n" 的串存进 pending_input，重新打开时会被还原成 "\n" → 立刻又判定「空回车」→ console 秒关。
//    （实测：空回车关闭后 console 再也打不开、只能重启游戏 —— 因为 pending_input 一直卡着 "\n"。）
if (global.console_active) {
	pending_input = string_replace_all(string_replace_all(keyboard_string, "\n", ""), "\r", "")
}

if key_check("console", keystate_press) or open {
	
	if global.console_active or UberCont.opt_console {
		global.console_active = !global.console_active
		// 用原版控制台时不联动 GM debug 面板
		if (!UberCont.opt_orig_console) {
			show_debug_overlay(global.console_active, true)
		}
	}
	
	event_user(0)

	// 这里不再清空 keyboard_string —— 改由下面的「开关过渡」块
	// 统一处理（关闭时暂存、打开时还原），以便保留「未按回车提交」的输入。
	open = false
}

// Android 软键盘输入
// 软键盘的「回车」只会往 keyboard_string 里塞 "\n"，并不一定触发 vk_enter：
//   "help"        -> cmd[0] = "help\n"   -> 匹配不到任何 case -> 灰字、无反应
//   "spawn grunt" -> cmd[1] = "grunt\n"  -> keys[$ "grunt\n"] 取不到 -> "Cannot create given object"
// 修法：先洗掉换行/首尾空白，再同时用「vk_enter」和「出现换行」两种来源判定提交。
// （`_ai_raw0` / `_ai_raw` 已在上面「暂存 pending_input」之前算好。）
// console 自身改用**原生** keyboard_check_* ——
// 因为 scr_keyboard_is_typing() 现在会把「console 打开」也算作「正在输入」，scr_keyboard_check_* 会恒为 false。
var _ai_submit = keyboard_check_pressed(vk_enter) || (os_type == os_android && (string_pos("\n", _ai_raw0) > 0 || string_pos("\r", _ai_raw0) > 0))

// **刚打开的这一帧不判定提交**：
// 打开瞬间 keyboard_string 里可能还残留 IME 的 "\n"（尚未被下面的「开关过渡」块还原成 pending_input），
// 不挡住的话会「开了立刻关」（实测：空回车关闭后每次重开都秒关）。
if (global.console_active && !prev_active) _ai_submit = false

// 命令补全：算候选（输入没变就不重算，免得每帧把选中项重置）。
if (!global.console_active) {
	completion_input = keyboard_string
	completion_list = []
}
else if (keyboard_string != completion_input) {
	completion_input = keyboard_string
	completion_list = scr_console_completions(keyboard_string)
	completion_sel = 0
}

// 候选条可见时，回车 = **接受补全**（把选中项填进输入行），而不是提交命令。
// ⚠️ 例外：若「当前正在编辑的那段」已经和选中候选**等价**（例如已完整打出 `spawn big portal`，
//    候选是 `bigportal`），就不该再「补全」——否则回车被反复吃掉、命令永远发不出去（用户 Android 实测 F31-1），
//    此时**直接提交**（不消耗 _ai_submit，落到下面的提交逻辑）。
if (_ai_submit && array_length(completion_list) > 0) {
	var _ct = string_trim(keyboard_string)
	var _cfsp = string_pos(" ", _ct)
	var _token = (_cfsp > 0) ? string_delete(_ct, 1, _cfsp) : _ct

	// spawn 的候选是「去掉空格后的整段」，所以比较时也去掉空格
	if (string_lower(string_replace_all(_token, " ", "")) == string_lower(string(completion_list[completion_sel]))) {
		// 已是完整命令 → 保持 _ai_submit，直接提交
	}
	else {
		if (_cfsp > 0) keyboard_string = string_copy(_ct, 1, _cfsp) + completion_list[completion_sel]
		else keyboard_string = completion_list[completion_sel]

		completion_input = keyboard_string
		completion_list = []          // 关掉候选条；输入再改动时会自动重算、重新弹出
		_ai_submit = false
		keyboard_clear(vk_enter)
	}
}

// 消费掉这次的换行。
// 软键盘的 "\n" 会**一直留在 keyboard_string 里**，不立刻清掉的话 _ai_submit 就变成
// 「电平触发」→ 每帧都判定一次提交；空输入时就会**每帧**关一次 console 并播一次开关音
// → 表现为「高频重复的开关音效」（60 帧下频率翻倍，正好对上实测现象）。
if (_ai_submit) keyboard_string = ""

// ESC / Android 返回键的「关闭 console」已移到 scrKeyboardHandleKeyPress
// （与 GM debug 面板同一处理位置；靠它返回 true 让 KeyPress_1 消费按键，不再需要每帧判断 + keyboard_clear）。
// 这里只保留「空回车也关闭 console」。
if (global.console_active && _ai_submit && string_length(_ai_raw) == 0)
{
	global.console_active = false
	event_user(0)
	keyboard_clear(vk_enter)
}

// 刚打开 → 还原上次未提交的输入；刚关闭 → 清空输入行（内容已存进 pending_input）。
if (global.console_active != prev_active) {
	if (global.console_active) keyboard_string = pending_input
	else keyboard_string = ""

	completion_input = keyboard_string
	completion_list = []
	prev_active = global.console_active
}

// 原版在 daily / weekly / continued 三种 run 里都禁用 console（防排行榜作弊）。
// 但「继续存档」的 run 不写存档、不进每日/每周挑战、不记录排行（cheat 下这些入口本就关闭），
// 放开它对平衡无影响；且原版 GM debug 面板在重进后本来就可打开，说明这条门控对「原版控制台」是历史遗留。
if !UberCont.opt_console
 or UberCont.daily_run
 or UberCont.weekly_run
	exit

if bound_command != "" {
	if scr_keyboard_check_pressed(ord("P")) {
		handle_console_command(bound_command)
	}

	if mouse_check_button_pressed(mb_right) {
		bound_command = ""
		print("Bind removed.")
	}
}

if (flags & 2) == 2 && instance_exists(GenCont) {
	var iter = 0

	do {
		with FloorMaker
			event_perform(ev_step, 0)

		iter ++

		if iter >= 100
			break
	} until instance_number(Floor) >= GenCont.goal
}

if !global.console_active exit

// 候选条可见时，↑↓ 用来选候选（**优先于全体历史**）；
// 否则保持原版：↑↓ 翻历史。
if (array_length(completion_list) > 0) {
	var _ncomp = array_length(completion_list)

	if keyboard_check_pressed(vk_up) {
		completion_sel = (completion_sel - 1 + _ncomp) mod _ncomp
	}
	else if keyboard_check_pressed(vk_down) {
		completion_sel = (completion_sel + 1) mod _ncomp
	}
}
else if array_length(history) {
	if keyboard_check_pressed(vk_up) {
		historypos--

		if historypos < 0 {
			historypos = array_length(history) - 1
		}

		keyboard_string = history[historypos]

		// 翻历史时**不弹候选**：
		// 把 completion_input 同步成新输入 → 下一帧不会重算候选 → ↑↓ 能继续翻历史。
		// （否则一旦翻到某条本身就是命令前缀的历史（如 `dear`），候选条会冒出来把 ↑↓ 抢走，永远翻不到下一条。）
		completion_input = keyboard_string
		completion_list = []
	}
	else if keyboard_check_pressed(vk_down) {
		historypos++

		if historypos >= array_length(history) {
			historypos = 0
		}

		keyboard_string = history[historypos]

		completion_input = keyboard_string
		completion_list = []
	}
}

if keyboard_check(vk_control) && keyboard_check_pressed(ord("V")) {
	keyboard_string += clipboard_get_text()
}

if _ai_submit {
	var _ai_cmd = _ai_raw

	historypos = -1
	pending_input = ""   // 已提交 → 丢弃暂存（下次打开 console 应为空）

	if string_length(_ai_cmd) {
		if laststr != _ai_cmd {
			array_push(history, _ai_cmd)
			laststr = _ai_cmd
		}

		var _ai_ret = handle_console_command(_ai_cmd)

		if (_ai_ret) {
			scr_log_push(_ai_cmd, c_gray)
		}
		else scr_log_push(_ai_cmd, c_white - 1)
	}
}
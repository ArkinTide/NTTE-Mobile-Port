global.log_output = []
global.log_color = []

global.console_active = 0

// debugclear 的「待还原数据」（坐标 + 武器）必须先声明：
// GML 里直接读取一个**从未赋值过的 global** 会抛「global variable name … not set before reading it」。
// 由 `GenCont/Alarm_1`（或走升级界面时的 `LevCont/Create_0`）在关卡定稿后消费并清空 —— 不再需要每帧轮询。
global.debugclear_restore = undefined

// debugclear 的「冷静期」倒计时（单位 = 30Hz 逻辑帧，30 帧 = 1 秒）。
// 由 `dear`/`debugclear` 置 60（≈2 秒）；`UberCont/Step_0` 每帧按 timescale 递减；归零 = 关卡已稳定。
// 用途：左上角小字倒计时（什么时候可以开始测数据）。
// ⚠️ 本状态为永久（不依赖任何临时调试代码，勿随调试工具增删而移除）。
global.debugclear_cooldown = 0

function scrContentIdByName(name, arr) {
    var i = -1

    if is_array(name) name = array_join(name, " ")

    try {
        if real(name) {
            return real(name)
        }
    } catch (e) {}

    if i == -1 {
        name = string_upper(name)

        for (var i = 0; i < array_length(arr); i++) {
            if name == arr[i]
            return i
        }

        return -1
    }

    return -1
}

function scrParseSpawn(cmd) {
    var keys = variable_global_exists("_console_instance_names") ? variable_global_get("_console_instance_names") : -1

    if keys == -1 {
        keys = {}

        for (var i = 0; object_exists(i); i++) {
            keys[$ string_lower(object_get_name(i))] = i
        }

        keys[$ "bigdog"] = ScrapBoss
        keys[$ "throne"] = Nothing
        keys[$ "captain"] = Last
        keys[$ "bigbandit"] = BanditBoss

        variable_global_set("_console_instance_names", keys)
    }

    var name = ""

    for (var i = 1; i < array_length(cmd); i++) {
        // bruh :kms:
        try {
            if real(cmd[i]) break
        } catch (e) {
            name += cmd[i]

            array_delete(cmd, 1, 1)
            i--
        }
    }

    var _object = keys[$ string_lower(name)]
    // Cooperative controllers are unavailable in this single-player edition.
    if (_object == CoopMenu || _object == CoopController) return -1
    return _object
}

function string_split_array(str, delimiter) {
    var r = []
    var l = string_length(str)
    var p = 1
    var v = ""

    while p <= l {
        var c = string_char_at(str, p++)

        if c == delimiter {
            array_push(r, v) v = ""
            continue
        }

        v += c
    }

    array_push(r, v)

    return r
}
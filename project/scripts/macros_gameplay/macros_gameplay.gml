#macro CHEAT_PRACTICE_FAINTED_TIME (45 * 30)
#macro PLAYER_LEVEL_MAX scrCustomParam("maxlevel", 10)

#macro c_gold     #dad090
#macro c_curse    #8b448c
#macro c_ultra    #3dc616
#macro c_tooltip  #31293d
#macro c_uidark   #333333
#macro c_uigray   #999999
#macro c_menugray #7d838d
#macro c_menudark #3b3e43
#macro c_uilight  #dcdcdc
#macro c_uisilver #7d838d

#macro team_none   0
#macro team_enemy  1
#macro team_player 2
#macro team_popo   3

globalvar current_frame, is_desktop, is_mobile, is_steamdeck;

current_frame = 0

// 60帧适配：timescale 的初始值。
// 真正的数值每步由 objects/UberCont/Step_0.gml 根据当前帧率重算，这里只是保证
// 在任何对象首次读到 timescale 之前它已存在且为「30fps 等效」的 1。
// 注意变量名是 time_scale（不是 timescale），原因见 macros_general.gml 的说明。
global.time_scale = 1

// 60帧适配：alarm 整数补偿的累加器。
// 详见 objects/UberCont/Step_1.gml —— alarm 值必须是整数，所以补偿只能用
// 「攒够 1 就补 1」的方式。这里初始化，避免首次使用时未定义。
global.alarm_topup_acc = 0

is_desktop = ((os_type == os_windows) || (os_type == os_linux) || (os_type == os_macosx))
is_mobile = ((os_type == os_android) || (os_type == os_ios))
is_steamdeck = scr_check_steamdeck()

#macro current_frame_active ((current_frame % 1) < timescale)
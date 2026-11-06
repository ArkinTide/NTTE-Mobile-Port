width = display_get_gui_width()
height = display_get_gui_height()

if (instance_number(object_index) > 1) {
    instance_destroy()
}

history = []
historypos = 0

// 关闭 console 时暂存「未提交的输入」，重新打开时还原。
pending_input = ""
prev_active = global.console_active

// 命令补全（弹窗式）状态
completion_input = ""      // 上次算候选时的输入（输入没变就不重算，免得每帧重置选中项）
completion_list = []       // 当前候选
completion_sel = 0         // 选中项下标

flags = 0

cursor = "|"
alarm[0] = room_speed
laststr = ""
command_binding = 0
bound_command = ""
alert = ""

seed = undefined

open = false

__draw_text = function(_x, _y, _string, _color = undefined, _alpha = undefined, _scale = 1) {
	draw_set_color(c_black)
	draw_set_alpha(1)
	
	draw_text_transformed(_x - _scale, _y, _string, _scale, _scale, 0)
	draw_text_transformed(_x, _y + _scale, _string, _scale, _scale, 0)
	draw_text_transformed(_x, _y - _scale, _string, _scale, _scale, 0)
	draw_text_transformed(_x + _scale, _y, _string, _scale, _scale, 0)
	
	if (is_numeric(_color)) draw_set_color(_color)
	if (is_numeric(_color)) draw_set_alpha(_alpha)
	
	draw_text_transformed(_x, _y, _string, _scale, _scale, 0)
}

enemy_test = false
enemy_count = 0
enemy_number = 0
enemy_species = {}
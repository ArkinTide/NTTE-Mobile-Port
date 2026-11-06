#region make menu

scrLetterbox(false, 0)
image_speed = 0

crown = crwn_none
race = Race.Random

char = array_create(Race.NUM_ALL_RACE_TYPES, noone)

scrLoadoutMenuInit()

scrCampfireMenuCreate()

with Campfire {
	scr_camera_set_position(x, y)
	break
}

var _slot_index = 0,
	_slot_height = sprite_get_height(sprCharSelect),
	_unlocked_chars = 0,
	_char_list = [];

for(var _race_id = Race.Random; _race_id < Race.NUM_ALL_RACE_TYPES; ++_race_id) {
	if(scrNTTEFullRaceNumeric(_race_id)>=0 && !scrNTTEFullRaceReady(_race_id)) continue
	if (!scrRaceIsHidden(_race_id) || scr_race_is_unlocked(_race_id)) {
		array_push(_char_list, _race_id)
	}
}

var _count = array_length(_char_list),
	_slot_ystart = view_height - _slot_height - ((LETTERBOX_SIZE - _slot_height) div 2),
	// 选人栏间隙（原版遗留问题 · v2）。原式：min(20, floor((320−40)/角色数)) ——
	// 两个问题：① 预算被写死 320，而宽屏手机的菜单 view_width 实际 ≈496（240×宽高比）→ 右侧大量空余没用上
	//（用户截图「底部没有排满」即此）；② 满员 16 角色时步距 17 → 间隙仅 1px（「几乎紧贴」）。
	// v1 曾试「单机收回 40px 预留」→ 失败：单机按下 Play 后 is_server 也 = true（PlayButton/Other_10），条件永不满足。
	// v4 修法：**只把预算基准从写死的 game_screen_width 换成真实 view_width**，预留维持开发者原值 40px
	//（联机 GO 按钮预留 —— 与 toncho 2026-07 Discord 说明一致；v4 起不再引入任何自造数字）：
	//   步距 = min(20, floor((view_width − 40) / 角色数))
	//   宽屏（view≥368）：16 角色步距 17→20（间隙 1px→4px）；14 角色维持 20（不变）；
	//   窄屏（view=320）：floor(280/16)=17 与修前一致（= 原版数值）；GO 定位沿用原版公式（见下方）。
	_slot_step_size = min(20, floor((view_width - 40) / max(1, _count))),
	_slot_xstart = 8,
	_slot_x = _slot_xstart

for(var i = 0; i < _count; ++i) {
	// relative to the camera
	_slot_x = _slot_xstart + _slot_step_size * _slot_index
	
    with instance_create(_slot_x, _slot_ystart, CharSelect) {
        slot_index = _slot_index
        race = _char_list[i]
    }
	
	_slot_index ++
}

if global.is_server && _slot_x < (view_width - 30) {
	var _sprite = sprGoButtonSymbolic,
		_offset = sprite_get_bbox_height(_sprite) div 2,
		_ypos = view_height - LETTERBOX_SIZE + _offset - 2
    
	// GO 定位回归**原版公式** `_slot_x + _slot_step_size + 2`
	//（v2 的 `+6`、v3 的 `+22` 都是自造数值 → v4 起不再引入任何新数字）。
	// 机理：循环结束时 `_slot_x` = 最后一个槽位自身的 x；原版「空一个步距再 +2」在步距=20 时
	// 恰好等于「槽位宽 16 + 间隙 6」，GO 完整落在最后槽位右侧（PC-2 被盖是 v2 的 +6 所致）。
	with instance_create(_slot_x + _slot_step_size + 2, _ypos, GoButton) {
		sprite_index = _sprite
		visible = false
	}
}


#endregion

portrait_offsets = array_create(INPUT_MAX_PLAYERS, 0)
textappear = array_create(INPUT_MAX_PLAYERS, 2)
splatindex = 0

loadout_open = false
loadout_crown = crwn_none
loadout_frame = 0
loadout_arrow_pointed = false
loadout_crown_pointed = false
loadout_skin_pointed = false
loadout_weapon_pointed = false

weekly = false

if (scrGameIsCustomMode()) {
	scrMenuPrepareCustomLoadout()
}
else if (scrGameIsWeeklyRun()) {
	scrMenuPrepareWeeklyLoadout()
}

unlock_hint = ""
unlock_hint_pop = 0
tooltip = undefined
tooltip_pop = 0

if !instance_exists(MusCont) {
	instance_create(0, 0, MusCont)
}

with MusCont {
	audio_stop_sound(amb)
	amb = custom_sound_check(amb0)
	snd_play_ambience(amb, true)
}

event_user(0)

menu_hid_offset = 0

if instance_exists(char[race]) {
	with char[race] {
	    view_xview = x - view_width / 2
	    view_yview = y - view_height / 2
	}
	
	scr_camera_set_position(view_xview, view_yview)
}

loadout_wep = 0
loadout_bwep = 0

gpadmode = false
gpadpointed = 0

mousex = gui_w / 2
mousey = gui_h / 2

event_perform(ev_step, ev_step_begin)

if global.custom_seed {
	seed_text = string(global.custom_seed)
}

alarm[10] = 5
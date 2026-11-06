/// @description click

// Keep the original sprite/action IDs for normal, hard and custom modes.
// Reject stale challenge buttons before changing any run state.
var _image = floor(num)
if (_image != 0 && _image != 3 && _image != 4) exit

global.index = 0
global.is_server = true

with (UberCont) {
	coop = false
	hardmode = false
	if (!scrGameIsCustomMode()) {
		protowep = save_get_value("etc", "protowep", wep_rusty_revolver)
	}
	else protowep = wep_rusty_revolver
}

scrGameCustomModeReset()

with (UberCont) {
	daily_run = false
	weekly_run = false
	scr_playerinstance_reset()
}

if (_image == 3) {
	UberCont.hardmode = true
}
else if (_image == 4) {
	instance_destroy(PlayButton)
	instance_destroy(MainMenuButton)
	scrCustomModeLoadPresets()
	with (UberCont) {
		custom_options = custom_mode_slots[custom_mode_slot_index]
		custom = true
	}
	with (instance_create(0, 0, MenuOptions)) {
		scrOptionsMenuChangeCategory(OptionCategory.CustomMode, false)
		dispose_on_empty = true
	}
}

instance_destroy(PlayButton)
instance_destroy(MainMenuButton)

if (!instance_exists(MenuOptions)) {
	instance_destroy(SpiralCont)
	instance_create(0, 0, GameCont)
	instance_create(0, 0, MenuGen)
	snd_play(sndMenuCharSelect)
}

UberCont.gamepad_sel = 0
snd_play(sndClick)

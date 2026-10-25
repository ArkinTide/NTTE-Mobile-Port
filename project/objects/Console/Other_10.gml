if !UberCont.opt_console
	exit

/// @description update virtual keyboard

if global.console_active {
	snd_play(sndClick)

	if os_type == os_ios {
        // NTTE iOS console: same four-zero call as the device-tested VM patch
        keyboard_virtual_show(0,0,0,0)
    }
    else if os_type == os_android {
        scrShowVirtualKeyboard()
    }
}
else {
	snd_play(sndClickBack)

	if os_type == os_android || os_type == os_ios {
		keyboard_virtual_hide()
	}
}
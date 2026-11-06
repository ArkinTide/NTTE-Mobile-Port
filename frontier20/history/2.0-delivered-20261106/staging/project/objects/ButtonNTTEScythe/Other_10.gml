event_inherited()
// The editor keeps inherited drag ownership until the finger is released.
if(instance_exists(MenuOptions)) exit

index = -1
if(UberCont.opt_keyboard || UberCont.opt_gamepad) exit

var _player = scrNTTEFullScytheControlPlayer()
if(!scrNTTEFullScytheControlVisible(_player)) exit

index = get_nearest_touch(rad)
scrNTTEFullScytheControlPress(_player,index,index != -1 && device_mouse_check_button_pressed(index,mb_left))
